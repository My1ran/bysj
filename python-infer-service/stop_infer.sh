#!/usr/bin/env bash
set -euo pipefail

APP_DIR="/root/python-infer-service"
PID_FILE="${APP_DIR}/uvicorn.pid"

if [ -f "${PID_FILE}" ]; then
  PID="$(cat "${PID_FILE}" || true)"
  if [ -n "${PID}" ] && kill -0 "${PID}" 2>/dev/null; then
    kill "${PID}"
    echo "已停止 PID=${PID}"
  else
    echo "PID 文件存在，但进程不存在"
  fi
  rm -f "${PID_FILE}"
else
  echo "未找到 PID 文件"
fi