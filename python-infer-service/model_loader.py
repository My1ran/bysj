import os
import sys
import threading
from typing import Dict, Optional, Tuple

import numpy as np
import torch


class MockPredictor:
    def predict_image(self, image: np.ndarray, conf_threshold: float):
        height, width = image.shape[:2]
        if width <= 0 or height <= 0:
            return []
        score = max(min(float(conf_threshold) + 0.2, 0.99), float(conf_threshold))
        x1 = int(width * 0.25)
        y1 = int(height * 0.2)
        x2 = int(width * 0.55)
        y2 = int(height * 0.6)
        return [
            {
                "x1": x1,
                "y1": y1,
                "x2": x2,
                "y2": y2,
                "score": round(score, 4),
                "class_name": "polyp",
            }
        ]

    def predict_frame(
        self,
        image: np.ndarray,
        conf_thres: float = 0.25,
        iou_thres: float = 0.45,
        imgsz=640,
        max_det: int = 1000,
        agnostic_nms: bool = False,
        augment: bool = False,
    ):
        return self.predict_image(image, conf_thres)


class HubAutoShapePredictor:
    def __init__(self, model):
        self.model = model

    def predict_image(self, image: np.ndarray, conf_threshold: float):
        if hasattr(self.model, "conf"):
            self.model.conf = float(conf_threshold)
        with torch.no_grad():
            results = self.model(image)
        if not hasattr(results, "xyxy"):
            return []
        rows = results.xyxy[0].cpu().numpy().tolist() if len(results.xyxy) > 0 else []
        names = getattr(self.model, "names", {})
        boxes = []
        for row in rows:
            x1, y1, x2, y2, score, cls_id = row[:6]
            if float(score) < float(conf_threshold):
                continue
            class_idx = int(cls_id)
            if isinstance(names, dict):
                class_name = str(names.get(class_idx, class_idx))
            elif isinstance(names, (list, tuple)) and class_idx < len(names):
                class_name = str(names[class_idx])
            else:
                class_name = str(class_idx)
            boxes.append(
                {
                    "x1": int(x1),
                    "y1": int(y1),
                    "x2": int(x2),
                    "y2": int(y2),
                    "score": round(float(score), 6),
                    "class_name": class_name,
                }
            )
        return boxes

    def predict_frame(
        self,
        image: np.ndarray,
        conf_thres: float = 0.25,
        iou_thres: float = 0.45,
        imgsz=640,
        max_det: int = 1000,
        agnostic_nms: bool = False,
        augment: bool = False,
    ):
        if hasattr(self.model, "conf"):
            self.model.conf = float(conf_thres)
        if hasattr(self.model, "iou"):
            self.model.iou = float(iou_thres)
        if hasattr(self.model, "agnostic"):
            self.model.agnostic = bool(agnostic_nms)
        if hasattr(self.model, "max_det"):
            self.model.max_det = int(max_det)
        return self.predict_image(image, conf_thres)


class DetectPipelinePredictor:
    def __init__(self, model_path: str, yolov5_repo: str, device: str, fp16: bool):
        if not model_path:
            raise RuntimeError("model_path is required for detect pipeline")
        if not os.path.exists(model_path):
            raise RuntimeError(f"model_path not found: {model_path}")
        if not yolov5_repo or not os.path.isdir(yolov5_repo):
            raise RuntimeError(f"YOLOV5_REPO is invalid: {yolov5_repo}")

        repo_path = os.path.abspath(yolov5_repo)
        if repo_path not in sys.path:
            sys.path.insert(0, repo_path)

        from models.common import DetectMultiBackend  # type: ignore
        from utils.augmentations import letterbox  # type: ignore
        from utils.general import check_img_size, non_max_suppression, scale_boxes  # type: ignore

        self.letterbox = letterbox
        self.check_img_size = check_img_size
        self.non_max_suppression = non_max_suppression
        self.scale_boxes = scale_boxes

        self.device = torch.device(device)
        self.model = DetectMultiBackend(model_path, device=self.device, dnn=False, fp16=fp16)
        self.stride = self.model.stride
        self.names = self.model.names
        self.pt = self.model.pt
        self.fp16 = bool(fp16)

        default_imgsz = _parse_imgsz(os.getenv("YOLO_DEFAULT_IMGSZ", "640"))
        checked = self.check_img_size(default_imgsz, s=self.stride)
        self.default_imgsz = _normalize_imgsz_tuple(checked)
        self.model.warmup(imgsz=(1, 3, *self.default_imgsz))

    def predict_image(self, image: np.ndarray, conf_threshold: float):
        return self.predict_frame(image, conf_thres=conf_threshold)

    def predict_frame(
        self,
        image: np.ndarray,
        conf_thres: float = 0.25,
        iou_thres: float = 0.45,
        imgsz=640,
        max_det: int = 1000,
        agnostic_nms: bool = False,
        augment: bool = False,
    ):
        if image is None or image.size == 0:
            return []

        target_imgsz = _normalize_imgsz_tuple(self.check_img_size(_parse_imgsz(imgsz), s=self.stride))
        im0 = image
        im = self.letterbox(im0, target_imgsz, stride=self.stride, auto=self.pt)[0]
        im = im.transpose((2, 0, 1))[::-1]
        im = np.ascontiguousarray(im)
        im_tensor = torch.from_numpy(im).to(self.model.device)
        im_tensor = im_tensor.half() if self.model.fp16 else im_tensor.float()
        im_tensor /= 255.0
        if len(im_tensor.shape) == 3:
            im_tensor = im_tensor[None]

        with torch.no_grad():
            pred = self.model(im_tensor, augment=augment, visualize=False)
            pred = self.non_max_suppression(
                pred,
                conf_thres,
                iou_thres,
                classes=None,
                agnostic=agnostic_nms,
                max_det=int(max_det),
            )

        det = pred[0]
        boxes = []
        if len(det):
            det[:, :4] = self.scale_boxes(im_tensor.shape[2:], det[:, :4], im0.shape).round()
            for *xyxy, conf, cls in det.tolist():
                class_idx = int(cls)
                if isinstance(self.names, dict):
                    class_name = str(self.names.get(class_idx, class_idx))
                elif isinstance(self.names, (list, tuple)) and class_idx < len(self.names):
                    class_name = str(self.names[class_idx])
                else:
                    class_name = str(class_idx)
                boxes.append(
                    {
                        "x1": int(xyxy[0]),
                        "y1": int(xyxy[1]),
                        "x2": int(xyxy[2]),
                        "y2": int(xyxy[3]),
                        "score": round(float(conf), 6),
                        "class_name": class_name,
                    }
                )
        return boxes


class ModelManager:
    def __init__(self):
        self._lock = threading.Lock()
        self._cache: Dict[str, object] = {}
        self._status: Dict[str, str] = {}
        self.force_mock = os.getenv("INFER_FORCE_MOCK", "0") == "1"
        self.allow_fallback_mock = os.getenv("INFER_ALLOW_FALLBACK_MOCK", "0") == "1"
        self.yolov5_repo = os.getenv("YOLOV5_REPO", "").strip()
        self.default_model_path = os.getenv("YOLO_MODEL_PATH", "").strip()
        self.force_cpu = os.getenv("INFER_FORCE_CPU", "0") == "1"
        self.enable_detect_pipeline = os.getenv("INFER_USE_DETECT_PIPELINE", "1") == "1"
        self.enable_half = os.getenv("INFER_HALF", "0") == "1"

    def get_predictor(self, model_path: Optional[str], model_id: Optional[int]):
        key = self._build_cache_key(model_path, model_id)
        with self._lock:
            if key in self._cache:
                return self._cache[key]
            predictor = self._create_predictor(model_path)
            self._cache[key] = predictor
            return predictor

    def health(self):
        with self._lock:
            return {
                "force_mock": self.force_mock,
                "allow_fallback_mock": self.allow_fallback_mock,
                "use_detect_pipeline": self.enable_detect_pipeline,
                "cached_models": list(self._status.keys()),
                "status": self._status,
                "cuda_available": bool(torch.cuda.is_available()),
                "yolov5_repo": self.yolov5_repo,
            }

    def _build_cache_key(self, model_path: Optional[str], model_id: Optional[int]):
        if model_path:
            return f"path:{model_path}"
        if model_id is not None:
            return f"id:{model_id}"
        return "default"

    def _create_predictor(self, model_path: Optional[str]):
        key = self._build_cache_key(model_path, None)
        if self.force_mock:
            self._status[key] = "mock(force)"
            return MockPredictor()

        try:
            device = "cpu" if self.force_cpu or not torch.cuda.is_available() else "cuda:0"
            resolved_model_path = (model_path or "").strip() or self.default_model_path
            fp16 = self.enable_half and device.startswith("cuda")

            if self.enable_detect_pipeline and resolved_model_path and self.yolov5_repo:
                predictor = DetectPipelinePredictor(
                    model_path=resolved_model_path,
                    yolov5_repo=self.yolov5_repo,
                    device=device,
                    fp16=fp16,
                )
                self._status[key] = f"detect-pipeline({device},fp16={fp16})"
                return predictor

            model = self._load_yolov5_model(resolved_model_path)
            if hasattr(model, "to"):
                model.to(device)
            if hasattr(model, "eval"):
                model.eval()
            self._status[key] = f"hub-autoshape({device})"
            return HubAutoShapePredictor(model)
        except Exception as e:
            if self.allow_fallback_mock:
                self._status[key] = f"mock(fallback:{e})"
                return MockPredictor()
            self._status[key] = f"error:{e}"
            raise RuntimeError(f"YOLO model load failed: {e}") from e

    def _load_yolov5_model(self, model_path: Optional[str]):
        model_path = (model_path or "").strip()
        if self.yolov5_repo and not os.path.isdir(self.yolov5_repo):
            raise RuntimeError(f"YOLOV5_REPO is not a valid directory: {self.yolov5_repo}")
        if model_path:
            if self.yolov5_repo:
                return torch.hub.load(self.yolov5_repo, "custom", path=model_path, source="local")
            return torch.hub.load("ultralytics/yolov5", "custom", path=model_path, source="github")
        if self.yolov5_repo:
            return torch.hub.load(self.yolov5_repo, "yolov5s", source="local")
        return torch.hub.load("ultralytics/yolov5", "yolov5s", pretrained=True, source="github")


def _parse_imgsz(imgsz) -> Tuple[int, int]:
    if isinstance(imgsz, (tuple, list)):
        if len(imgsz) == 1:
            size = int(imgsz[0])
            return size, size
        if len(imgsz) >= 2:
            return int(imgsz[0]), int(imgsz[1])
    if isinstance(imgsz, str):
        text = imgsz.strip().lower().replace("x", ",")
        if "," in text:
            parts = [p for p in text.split(",") if p]
            if len(parts) >= 2:
                return int(parts[0]), int(parts[1])
            if len(parts) == 1:
                size = int(parts[0])
                return size, size
        size = int(float(text))
        return size, size
    size = int(imgsz)
    return size, size


def _normalize_imgsz_tuple(imgsz) -> Tuple[int, int]:
    if isinstance(imgsz, (tuple, list)):
        if len(imgsz) == 1:
            return int(imgsz[0]), int(imgsz[0])
        if len(imgsz) >= 2:
            return int(imgsz[0]), int(imgsz[1])
    if isinstance(imgsz, int):
        return imgsz, imgsz
    return 640, 640
