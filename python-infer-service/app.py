import os
import time
from typing import List, Optional

from fastapi import FastAPI, File, Form, Request, UploadFile
from fastapi.responses import Response
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel, Field

from infer_image import infer_image_file
from infer_video import infer_video_file
from model_loader import ModelManager
from file_utils import download_to_temp, ensure_output_dir, infer_file_type, save_upload_file, get_ffmpeg_bin

app = FastAPI(title="Polyp YOLOv5 Inference Service", version="1.1.0")
model_manager = ModelManager()
output_dir = ensure_output_dir()
app.mount("/outputs", StaticFiles(directory=output_dir), name="outputs")

PUBLIC_BASE_URL = os.getenv("PUBLIC_BASE_URL", "").strip()
FORCE_HTTPS_PUBLIC_URL = os.getenv("FORCE_HTTPS_PUBLIC_URL", "true").lower() == "true"

cors_allow_origins = [item.strip() for item in os.getenv("CORS_ALLOW_ORIGINS", "*").split(",") if item.strip()]
if not cors_allow_origins:
    cors_allow_origins = ["*"]
allow_credentials = os.getenv("CORS_ALLOW_CREDENTIALS", "false").lower() == "true"
if "*" in cors_allow_origins:
    allow_credentials = False

app.add_middleware(
    CORSMiddleware,
    allow_origins=cors_allow_origins,
    allow_credentials=allow_credentials,
    allow_methods=["*"],
    allow_headers=["*"],
)


class InferBox(BaseModel):
    x1: int
    y1: int
    x2: int
    y2: int
    score: float
    class_name: str


class FrameSummary(BaseModel):
    frame_index: int
    timestamp_sec: float = 0.0
    box_count: int
    max_confidence: float
    boxes: List[InferBox] = Field(default_factory=list)


class InferResponse(BaseModel):
    success: bool
    message: str
    file_type: str
    inference_ms: int
    image_width: int
    image_height: int
    boxes: List[InferBox]
    frame_count: int = 0
    detected_frame_count: int = 0
    max_confidence: float = 0.0
    fps: float = 0.0
    result_image_url: str = ""
    result_video_url: str = ""
    result_video_raw_url: str = ""
    result_frames_url: str = ""
    transcode_success: bool = False
    transcode_error: str = ""
    ffmpeg_path: str = ""
    frames: List[FrameSummary] = Field(default_factory=list)


def resolve_public_base_url(request: Request) -> str:
    base_url = PUBLIC_BASE_URL
    if not base_url:
        base_url = str(request.base_url).rstrip("/")
        forwarded_proto = (request.headers.get("x-forwarded-proto") or "").split(",")[0].strip()
        forwarded_host = (request.headers.get("x-forwarded-host") or "").split(",")[0].strip()
        if forwarded_proto and forwarded_host:
            base_url = f"{forwarded_proto}://{forwarded_host}"
    if FORCE_HTTPS_PUBLIC_URL and base_url.startswith("http://"):
        base_url = "https://" + base_url[len("http://") :]
    return base_url.rstrip("/")


@app.get("/health")
def health():
    return {
        "success": True,
        "message": "ok",
        "service": "polyp-infer",
        "output_dir": output_dir,
        "public_base_url": PUBLIC_BASE_URL,
        "ffmpeg_path": get_ffmpeg_bin(),
        "model": model_manager.health(),
    }

@app.middleware("http")
async def add_outputs_cors_headers(request: Request, call_next):
    response: Response = await call_next(request)
    if request.url.path.startswith("/outputs/"):
        origin = request.headers.get("origin", "*")
        response.headers["Access-Control-Allow-Origin"] = origin if origin else "*"
        response.headers["Vary"] = "Origin"
    return response


@app.post("/infer", response_model=InferResponse)
async def infer(
    request: Request,
    file: Optional[UploadFile] = File(default=None),
    file_url: Optional[str] = Form(default=None),
    file_type: Optional[str] = Form(default=None),
    model_id: Optional[int] = Form(default=None),
    model_path: Optional[str] = Form(default=None),
    conf_threshold: float = Form(default=0.25),
    iou_thres: float = Form(default=0.45),
    imgsz: str = Form(default="640"),
    max_det: int = Form(default=1000),
    frame_stride: int = Form(default=1),
    vid_stride: int = Form(default=0),
    max_frames: int = Form(default=0),
    agnostic_nms: bool = Form(default=False),
    augment: bool = Form(default=False),
    include_frames: bool = Form(default=False),
    generate_result_video: bool = Form(default=True),
):
    local_path = ""
    original_name = ""

    try:
        if file is not None:
            local_path, original_name = save_upload_file(file)
        elif file_url:
            local_path, original_name = download_to_temp(file_url)
        else:
            return InferResponse(
                success=False,
                message="file or file_url is required",
                file_type="",
                inference_ms=0,
                image_width=0,
                image_height=0,
                boxes=[],
            )

        resolved_type = infer_file_type(original_name, file_type)
        if resolved_type not in {"image", "video"}:
            return InferResponse(
                success=False,
                message="unsupported file type",
                file_type="",
                inference_ms=0,
                image_width=0,
                image_height=0,
                boxes=[],
            )

        predictor = model_manager.get_predictor(model_path=model_path, model_id=model_id)

        start = time.time()
        if resolved_type == "image":
            result = infer_image_file(local_path, predictor, conf_threshold)
        else:
            effective_stride = frame_stride
            if int(vid_stride or 0) > 0:
                effective_stride = int(vid_stride)
            result = infer_video_file(
                local_path,
                predictor,
                conf_thres=conf_threshold,
                iou_thres=iou_thres,
                imgsz=imgsz,
                max_det=max_det,
                frame_stride=effective_stride,
                max_frames=max_frames,
                agnostic_nms=agnostic_nms,
                augment=augment,
                include_frames=include_frames,
                generate_result_video=generate_result_video,
            )
        inference_ms = int((time.time() - start) * 1000)

        base_url = resolve_public_base_url(request)

        result_image_url = ""
        result_image_path = result.get("result_image_path", "")
        if result_image_path and os.path.exists(result_image_path):
            result_image_url = f"{base_url}/outputs/{os.path.basename(result_image_path)}"

        result_video_url = ""
        result_video_path = result.get("result_video_path", "")
        if result_video_path and os.path.exists(result_video_path):
            result_video_url = f"{base_url}/outputs/{os.path.basename(result_video_path)}"

        result_video_raw_url = ""
        result_video_raw_path = result.get("result_video_raw_path", "")
        if result_video_raw_path and os.path.exists(result_video_raw_path):
            result_video_raw_url = f"{base_url}/outputs/{os.path.basename(result_video_raw_path)}"

        result_frames_url = ""
        result_frames_path = result.get("result_frames_path", "")
        if result_frames_path and os.path.exists(result_frames_path):
            result_frames_url = f"{base_url}/outputs/{os.path.basename(result_frames_path)}"

        transcode_success = bool(result.get("transcode_success", False))
        transcode_error = str(result.get("transcode_error", "") or "")
        ffmpeg_path = str(result.get("ffmpeg_bin", "") or get_ffmpeg_bin())
        response_message = "ok"
        if resolved_type == "video" and generate_result_video and not result_video_url:
            response_message = "ok_but_result_video_transcode_failed"

        return InferResponse(
            success=True,
            message=response_message,
            file_type=result.get("file_type", resolved_type),
            inference_ms=inference_ms,
            image_width=result.get("image_width", 0),
            image_height=result.get("image_height", 0),
            boxes=result.get("boxes", []),
            frame_count=result.get("frame_count", 0),
            detected_frame_count=result.get("detected_frame_count", 0),
            max_confidence=result.get("max_confidence", 0.0),
            fps=result.get("fps", 0.0),
            result_image_url=result_image_url,
            result_video_url=result_video_url,
            result_video_raw_url=result_video_raw_url,
            result_frames_url=result_frames_url,
            transcode_success=transcode_success,
            transcode_error=transcode_error,
            ffmpeg_path=ffmpeg_path,
            frames=result.get("frames", []),
        )
    except Exception as e:
        return InferResponse(
            success=False,
            message=str(e),
            file_type=file_type or "",
            inference_ms=0,
            image_width=0,
            image_height=0,
            boxes=[],
        )
    finally:
        if local_path and os.path.exists(local_path):
            try:
                os.remove(local_path)
            except Exception:
                pass


if __name__ == "__main__":
    import uvicorn

    uvicorn.run("app:app", host="0.0.0.0", port=8001, reload=False)
