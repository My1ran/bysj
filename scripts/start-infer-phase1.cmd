@echo off
cd /d M:\0NUIST\class\bysj\Medical-platform-master\python-infer-service
python -m uvicorn app:app --host 0.0.0.0 --port 8001 >> ..\logs\phase1-infer.out 2>> ..\logs\phase1-infer.err
