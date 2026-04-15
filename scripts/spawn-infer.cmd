@echo off
cd /d M:\0NUIST\class\bysj\Medical-platform-master
start "" /b python -m uvicorn app:app --app-dir python-infer-service --host 0.0.0.0 --port 8001
