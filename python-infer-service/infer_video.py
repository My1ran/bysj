import json
import os
import logging
from typing import Dict, List

import cv2

from file_utils import create_output_stem, ensure_output_dir, ffmpeg_transcode_web, get_ffmpeg_bin

logger = logging.getLogger("polyp_infer.video")


def _draw_boxes(frame, boxes: List[Dict]):
    for box in boxes:
        x1 = int(box.get("x1", 0))
        y1 = int(box.get("y1", 0))
        x2 = int(box.get("x2", 0))
        y2 = int(box.get("y2", 0))
        score = float(box.get("score", 0))
        class_name = str(box.get("class_name", "polyp"))
        cv2.rectangle(frame, (x1, y1), (x2, y2), (20, 20, 255), 2)
        label = f"{class_name} {score:.3f}"
        cv2.putText(frame, label, (x1, max(18, y1 - 8)), cv2.FONT_HERSHEY_SIMPLEX, 0.55, (20, 20, 255), 2)


def infer_video_file(
    video_path: str,
    predictor,
    conf_thres: float = 0.25,
    iou_thres: float = 0.45,
    imgsz=640,
    max_det: int = 1000,
    frame_stride: int = 1,
    max_frames: int = 0,
    agnostic_nms: bool = False,
    augment: bool = False,
    include_frames: bool = False,
    generate_result_video: bool = True,
):
    cap = cv2.VideoCapture(video_path)
    if not cap.isOpened():
        raise ValueError(f"failed to open video: {video_path}")

    frame_stride = max(int(frame_stride), 1)
    target_max_frames = max(int(max_frames), 0)

    estimated_total = int(cap.get(cv2.CAP_PROP_FRAME_COUNT) or 0)
    image_width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH) or 0)
    image_height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT) or 0)
    fps = float(cap.get(cv2.CAP_PROP_FPS) or 0.0)
    write_fps = fps if fps > 0 else 25.0

    output_dir = ensure_output_dir()
    output_stem = create_output_stem("video")
    raw_video_path = os.path.join(output_dir, f"{output_stem}_raw.mp4")
    web_video_path = os.path.join(output_dir, f"{output_stem}.mp4")
    frames_json_path = os.path.join(output_dir, f"{output_stem}_frames.json")

    writer = None
    if generate_result_video:
        writer = cv2.VideoWriter(
            raw_video_path,
            cv2.VideoWriter_fourcc(*"mp4v"),
            write_fps,
            (max(1, image_width), max(1, image_height)),
        )

    frame_idx = 0
    processed_frames = 0
    detected_frame_count = 0
    max_confidence = 0.0
    best_boxes: List[Dict] = []
    recorded_frames: List[Dict] = []
    while True:
        ok, frame = cap.read()
        if not ok:
            break

        should_infer = frame_idx % frame_stride == 0
        if should_infer:
            if hasattr(predictor, "predict_frame"):
                boxes = predictor.predict_frame(
                    frame,
                    conf_thres=conf_thres,
                    iou_thres=iou_thres,
                    imgsz=imgsz,
                    max_det=max_det,
                    agnostic_nms=agnostic_nms,
                    augment=augment,
                )
            else:
                boxes = predictor.predict_image(frame, conf_thres)
        else:
            boxes = []

        frame_max = max((float(item.get("score", 0.0)) for item in boxes), default=0.0)
        if boxes:
            detected_frame_count += 1
            if frame_max > max_confidence:
                max_confidence = frame_max
                best_boxes = boxes

        frame_record = {
            "frame_index": frame_idx,
            "timestamp_sec": round(frame_idx / write_fps, 6) if write_fps > 0 else 0.0,
            "box_count": len(boxes),
            "max_confidence": round(frame_max, 6),
            "boxes": boxes,
        }
        if include_frames or boxes:
            recorded_frames.append(frame_record)

        if writer is not None:
            draw_boxes = boxes if boxes else []
            _draw_boxes(frame, draw_boxes)
            writer.write(frame)

        frame_idx += 1
        processed_frames += 1
        if target_max_frames > 0 and processed_frames >= target_max_frames:
            break

    cap.release()
    if writer is not None:
        writer.release()

    result_video_path = ""
    result_video_raw_path = raw_video_path if writer is not None else ""
    transcode_success = False
    transcode_error = ""
    ffmpeg_bin = get_ffmpeg_bin()
    if writer is not None and os.path.exists(raw_video_path):
        transcode_result = ffmpeg_transcode_web(raw_video_path, web_video_path)
        transcode_success = bool(transcode_result.get("success"))
        transcode_error = (transcode_result.get("stderr") or "").strip()
        logger.warning(
            "video transcode result: success=%s ffmpeg=%s input=%s output=%s exit_code=%s",
            transcode_success,
            ffmpeg_bin,
            raw_video_path,
            web_video_path,
            transcode_result.get("exit_code"),
        )
        if transcode_success and os.path.exists(web_video_path):
            result_video_path = web_video_path
        else:
            if not transcode_error:
                transcode_error = "transcode failed and no final mp4 generated"
            logger.error("video transcode failed: %s", transcode_error)

    with open(frames_json_path, "w", encoding="utf-8") as fp:
        json.dump(
            {
                "frame_count": int(estimated_total if estimated_total > 0 else frame_idx),
                "detected_frame_count": int(detected_frame_count),
                "fps": round(write_fps, 6),
                "image_width": int(image_width),
                "image_height": int(image_height),
                "frames": recorded_frames,
            },
            fp,
            ensure_ascii=False,
        )

    return {
        "file_type": "video",
        "image_width": int(image_width),
        "image_height": int(image_height),
        "boxes": best_boxes,
        "frame_count": int(estimated_total if estimated_total > 0 else frame_idx),
        "detected_frame_count": int(detected_frame_count),
        "max_confidence": round(float(max_confidence), 6),
        "fps": round(write_fps, 3) if write_fps > 0 else 0.0,
        "frames": recorded_frames if include_frames else [],
        "result_video_path": result_video_path,
        "result_video_raw_path": result_video_raw_path,
        "result_frames_path": frames_json_path,
        "transcode_success": transcode_success,
        "transcode_error": transcode_error,
        "ffmpeg_bin": ffmpeg_bin,
    }
