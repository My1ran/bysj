import cv2
import os

from file_utils import create_output_stem, ensure_output_dir


def _draw_boxes(image, boxes):
    for box in boxes:
        x1 = int(box.get("x1", 0))
        y1 = int(box.get("y1", 0))
        x2 = int(box.get("x2", 0))
        y2 = int(box.get("y2", 0))
        score = float(box.get("score", 0.0))
        class_name = str(box.get("class_name", "polyp"))
        cv2.rectangle(image, (x1, y1), (x2, y2), (20, 20, 255), 2)
        label = f"{class_name} {score:.3f}"
        cv2.putText(image, label, (x1, max(18, y1 - 8)), cv2.FONT_HERSHEY_SIMPLEX, 0.55, (20, 20, 255), 2)


def infer_image_file(image_path: str, predictor, conf_threshold: float):
    image = cv2.imread(image_path)
    if image is None:
        raise ValueError(f"failed to read image: {image_path}")

    height, width = image.shape[:2]
    boxes = predictor.predict_image(image, conf_threshold)
    output_dir = ensure_output_dir()
    output_stem = create_output_stem("image")
    result_image_path = os.path.join(output_dir, f"{output_stem}.jpg")
    rendered = image.copy()
    _draw_boxes(rendered, boxes)
    cv2.imwrite(result_image_path, rendered)

    return {
        "file_type": "image",
        "image_width": int(width),
        "image_height": int(height),
        "boxes": boxes,
        "frame_count": 1,
        "detected_frame_count": 1 if boxes else 0,
        "max_confidence": max([float(b["score"]) for b in boxes], default=0.0),
        "fps": 0.0,
        "frames": [],
        "result_image_path": result_image_path,
    }
