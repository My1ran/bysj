# Polyp YOLOv5 Inference Service

FastAPI service for cloud deployment. Supports image and video inference over HTTP/HTTPS.

## Directory

- `app.py`: FastAPI entrypoint (`/health`, `/infer`)
- `model_loader.py`: YOLOv5 model singleton/cache and fallback mock predictor
- `infer_image.py`: image inference pipeline
- `infer_video.py`: video inference pipeline (frame sampling + summary)
- `utils.py`: upload/download temp file helpers

## Install

```bash
cd python-infer-service
python -m venv .venv
. .venv/bin/activate  # Windows: .venv\\Scripts\\activate
pip install -r requirements.txt
```

## Run

```bash
uvicorn app:app --host 0.0.0.0 --port 8001
```

## Optional environment variables

- `INFER_FORCE_MOCK=1`: force mock predictor for demo/debug only
- `INFER_ALLOW_FALLBACK_MOCK=1`: allow silent fallback to mock predictor when model loading fails
- `INFER_FORCE_CPU=1`: force CPU inference
- `YOLOV5_REPO=/opt/yolov5`: local YOLOv5 repo path for `torch.hub.load(..., source='local')`

## API

### `GET /health`

Response example:

```json
{
  "success": true,
  "message": "ok",
  "service": "polyp-infer",
  "model": {
    "force_mock": false,
    "cached_models": ["default"],
    "status": {"default": "yolov5(cpu)"},
    "cuda_available": false
  }
}
```

### `POST /infer`

`multipart/form-data` fields:

- `file`: binary file (image/video), optional if `file_url` is provided
- `file_url`: remote URL, optional if `file` is provided
- `file_type`: `image` or `video` (optional; auto-detected if omitted)
- `model_id`: optional
- `model_path`: optional
- `conf_threshold`: optional, default `0.5`
- `frame_stride`: video only, optional, default `5`
- `max_frames`: video only, optional, default `0` (no limit)

Image response example:

```json
{
  "success": true,
  "message": "ok",
  "file_type": "image",
  "inference_ms": 75,
  "image_width": 1280,
  "image_height": 720,
  "boxes": [
    {
      "x1": 211,
      "y1": 145,
      "x2": 379,
      "y2": 302,
      "score": 0.9412,
      "class_name": "polyp"
    }
  ],
  "frame_count": 1,
  "detected_frame_count": 1,
  "max_confidence": 0.9412,
  "frames": []
}
```

Video response example:

```json
{
  "success": true,
  "message": "ok",
  "file_type": "video",
  "inference_ms": 1570,
  "image_width": 1920,
  "image_height": 1080,
  "boxes": [
    {
      "x1": 210,
      "y1": 144,
      "x2": 380,
      "y2": 299,
      "score": 0.915,
      "class_name": "polyp"
    }
  ],
  "frame_count": 120,
  "detected_frame_count": 18,
  "max_confidence": 0.962,
  "frames": [
    {"frame_index": 0, "box_count": 1, "max_confidence": 0.91},
    {"frame_index": 5, "box_count": 0, "max_confidence": 0.0}
  ]
}
```

## HTTPS recommendation

Use Nginx / gateway as TLS terminator and forward to FastAPI:

- Public endpoint: `https://your-domain/infer`
- Upstream service: `http://127.0.0.1:8001`

Java backend only needs to change `polyp.inference.base-url` to the gateway address.
