import os
import subprocess
import shutil
import tempfile
import time
import uuid
import logging
from pathlib import Path
from typing import Optional, Tuple

import requests
from fastapi import UploadFile

IMAGE_EXTS = {"jpg", "jpeg", "png", "bmp"}
VIDEO_EXTS = {"mp4", "avi", "mov", "mkv"}
DEFAULT_FFMPEG_PATH = "/root/ffmpeg-master-latest-linux64-gpl/bin/ffmpeg"

logger = logging.getLogger("polyp_infer.utils")


def infer_file_type(filename: str, file_type_hint: Optional[str] = None) -> str:
    hint = (file_type_hint or "").strip().lower()
    if hint in {"image", "video"}:
        return hint
    ext = get_ext(filename)
    if ext in IMAGE_EXTS:
        return "image"
    if ext in VIDEO_EXTS:
        return "video"
    return ""


def get_ext(filename: str) -> str:
    return Path(filename or "").suffix.lower().replace(".", "")


def ensure_temp_dir() -> str:
    temp_dir = os.path.join(tempfile.gettempdir(), "polyp-infer")
    os.makedirs(temp_dir, exist_ok=True)
    return temp_dir


def save_upload_file(upload_file: UploadFile) -> Tuple[str, str]:
    temp_dir = ensure_temp_dir()
    original_name = upload_file.filename or "upload.bin"
    ext = get_ext(original_name)
    safe_name = f"{uuid.uuid4().hex}.{ext}" if ext else uuid.uuid4().hex
    target_path = os.path.join(temp_dir, safe_name)
    with open(target_path, "wb") as out_file:
        shutil.copyfileobj(upload_file.file, out_file)
    return target_path, original_name


def download_to_temp(file_url: str, timeout: int = 30) -> Tuple[str, str]:
    temp_dir = ensure_temp_dir()
    ext = get_ext(file_url)
    safe_name = f"{uuid.uuid4().hex}.{ext}" if ext else uuid.uuid4().hex
    target_path = os.path.join(temp_dir, safe_name)
    response = requests.get(file_url, timeout=timeout, stream=True)
    response.raise_for_status()
    with open(target_path, "wb") as f:
        for chunk in response.iter_content(chunk_size=1024 * 1024):
            if chunk:
                f.write(chunk)
    return target_path, os.path.basename(file_url)


def ensure_output_dir() -> str:
    configured = os.getenv("INFER_OUTPUT_DIR", "").strip()
    if configured:
        output_dir = configured
    else:
        output_dir = os.path.join(os.getcwd(), "outputs")
    os.makedirs(output_dir, exist_ok=True)
    return output_dir


def create_output_stem(prefix: str = "infer") -> str:
    return f"{prefix}_{time.strftime('%Y%m%d%H%M%S')}_{uuid.uuid4().hex[:8]}"


def get_ffmpeg_bin() -> str:
    return os.getenv("FFMPEG_PATH", DEFAULT_FFMPEG_PATH).strip() or DEFAULT_FFMPEG_PATH


def ffmpeg_transcode_web(input_path: str, output_path: str) -> dict:
    ffmpeg_bin = get_ffmpeg_bin()
    timeout_sec = int(os.getenv("FFMPEG_TIMEOUT_SEC", "300"))
    cmd = [
        ffmpeg_bin,
        "-loglevel",
        "error",
        "-y",
        "-i",
        input_path,
        "-c:v",
        "libx264",
        "-pix_fmt",
        "yuv420p",
        "-movflags",
        "+faststart",
        output_path,
    ]
    logger.warning("ffmpeg transcode start: ffmpeg=%s input=%s output=%s", ffmpeg_bin, input_path, output_path)
    logger.warning("ffmpeg command: %s", " ".join(cmd))
    if not os.path.exists(ffmpeg_bin):
        error_msg = f"ffmpeg binary not found: {ffmpeg_bin}"
        logger.error(error_msg)
        return {
            "success": False,
            "ffmpeg_bin": ffmpeg_bin,
            "cmd": cmd,
            "exit_code": -1,
            "stderr": error_msg,
        }

    try:
        completed = subprocess.run(
            cmd,
            check=False,
            timeout=timeout_sec,
            capture_output=True,
            text=True,
        )
        stderr = (completed.stderr or "").strip()
        stdout = (completed.stdout or "").strip()
        logger.warning("ffmpeg exit code: %s", completed.returncode)
        if stdout:
            logger.warning("ffmpeg stdout: %s", stdout[:1000])
        if stderr:
            logger.warning("ffmpeg stderr: %s", stderr[:1000])
        if completed.returncode != 0:
            return {
                "success": False,
                "ffmpeg_bin": ffmpeg_bin,
                "cmd": cmd,
                "exit_code": completed.returncode,
                "stderr": stderr or stdout or f"ffmpeg exited with {completed.returncode}",
            }
        return {
            "success": True,
            "ffmpeg_bin": ffmpeg_bin,
            "cmd": cmd,
            "exit_code": 0,
            "stderr": stderr,
        }
    except subprocess.TimeoutExpired as e:
        error_msg = f"ffmpeg timeout after {timeout_sec}s: {e}"
        logger.error(error_msg)
        return {
            "success": False,
            "ffmpeg_bin": ffmpeg_bin,
            "cmd": cmd,
            "exit_code": -2,
            "stderr": error_msg,
        }
    except Exception as e:
        error_msg = f"ffmpeg exception: {e}"
        logger.error(error_msg)
        return {
            "success": False,
            "ffmpeg_bin": ffmpeg_bin,
            "cmd": cmd,
            "exit_code": -3,
            "stderr": error_msg,
        }
