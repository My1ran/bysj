    #!/usr/bin/env bash
set -euo pipefail

# ===== 基础目录 =====
APP_DIR="/root/python-infer-service"
YOLOV5_REPO="/root/yolov5"
YOLO_MODEL_PATH="/root/yolov5/runs/train/polyp_1cls_yolov5s2/weights/best.pt"
FFMPEG_PATH="/root/ffmpeg-master-latest-linux64-gpl/bin/ffmpeg"

# ===== 服务配置 =====
HOST="0.0.0.0"
PORT="6006"
LOG_DIR="${APP_DIR}/logs"
PID_FILE="${APP_DIR}/uvicorn.pid"

mkdir -p "${LOG_DIR}"

# ===== 环境变量 =====
export YOLOV5_REPO
export YOLO_MODEL_PATH
export INFER_FORCE_MOCK=0
export INFER_ALLOW_FALLBACK_MOCK=0
export INFER_USE_DETECT_PIPELINE=1
export INFER_HALF=0
export FFMPEG_PATH

cd "${APP_DIR}"

echo "APP_DIR=${APP_DIR}"
echo "YOLOV5_REPO=${YOLOV5_REPO}"
echo "YOLO_MODEL_PATH=${YOLO_MODEL_PATH}"
echo "FFMPEG_PATH=${FFMPEG_PATH}"
echo "HOST=${HOST}"
echo "PORT=${PORT}"

# ===== 启动前检查 =====
if [ ! -d "${YOLOV5_REPO}" ]; then
  echo "ERROR: YOLOV5_REPO 不存在: ${YOLOV5_REPO}"
  exit 1
fi

if [ ! -f "${YOLO_MODEL_PATH}" ]; then
  echo "ERROR: YOLO_MODEL_PATH 不存在: ${YOLO_MODEL_PATH}"
  exit 1
fi

if [ ! -x "${FFMPEG_PATH}" ]; then
  echo "ERROR: FFMPEG_PATH 不可执行: ${FFMPEG_PATH}"
  exit 1
fi

# ===== 清理旧进程 =====
if [ -f "${PID_FILE}" ]; then
  OLD_PID="$(cat "${PID_FILE}" || true)"
  if [ -n "${OLD_PID}" ] && kill -0 "${OLD_PID}" 2>/dev/null; then
    echo "发现旧进程，正在停止 PID=${OLD_PID}"
    kill "${OLD_PID}" || true
    sleep 2
  fi
  rm -f "${PID_FILE}"
fi

# 额外兜底：按端口清理
if command -v lsof >/dev/null 2>&1; then
  OLD_PORT_PID="$(lsof -ti tcp:${PORT} || true)"
  if [ -n "${OLD_PORT_PID}" ]; then
    echo "端口 ${PORT} 已被占用，正在停止 PID=${OLD_PORT_PID}"
    kill ${OLD_PORT_PID} || true
    sleep 2
  fi
fi

# ===== 启动服务 =====
nohup uvicorn app:app --host "${HOST}" --port "${PORT}" \
  > "${LOG_DIR}/uvicorn.out" 2> "${LOG_DIR}/uvicorn.err" &

NEW_PID=$!
echo "${NEW_PID}" > "${PID_FILE}"

sleep 2

if kill -0 "${NEW_PID}" 2>/dev/null; then
  echo "启动成功，PID=${NEW_PID}"
  echo "Health: http://127.0.0.1:${PORT}/health"
  echo "日志输出: ${LOG_DIR}/uvicorn.out"
  echo "错误日志: ${LOG_DIR}/uvicorn.err"
else
  echo "启动失败，请检查日志"
  exit 1
fi