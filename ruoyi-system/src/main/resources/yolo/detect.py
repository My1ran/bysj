#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
YOLOv5 肠道息肉检测脚本
依赖：torch, torchvision, opencv-python, numpy

使用方法:
    python detect.py --model path/to/model.pt --source path/to/image.jpg --conf 0.5 --output json

输出格式:
    {
        "detections": [
            {
                "class": "polyp",
                "confidence": 0.95,
                "bbox": {"x": 100, "y": 150, "width": 50, "height": 40}
            }
        ],
        "image": {"width": 640, "height": 480}
    }
"""

import argparse
import json
import sys
import os
import time

try:
    import cv2
    import numpy as np
    import torch
except ImportError as e:
    print(json.dumps({"error": f"缺少依赖：{str(e)}，请安装 torch, opencv-python 等依赖"}))
    sys.exit(1)


def load_model(model_path):
    """加载 YOLOv5 模型"""
    # 检查模型文件是否存在
    if not os.path.exists(model_path):
        print(json.dumps({"error": f"模型文件不存在：{model_path}"}))
        sys.exit(1)

    try:
        # 尝试从本地加载模型
        model = torch.hub.load('ultralytics/yolov5', 'custom', path=model_path, force_reload=False)
        return model
    except Exception as e:
        print(json.dumps({"error": f"加载模型失败：{str(e)}"}))
        sys.exit(1)


def detect_image(model, image_path, conf_threshold):
    """检测图片中的息肉"""
    # 读取图片
    img = cv2.imread(image_path)
    if img is None:
        print(json.dumps({"error": f"无法读取图片：{image_path}"}))
        sys.exit(1)

    # 获取原始尺寸
    height, width = img.shape[:2]

    # 执行检测
    results = model(img)

    # 解析检测结果
    detections = []
    df = results.pandas().xyxy[0]  # pandas DataFrame

    for _, row in df.iterrows():
        if row['confidence'] >= conf_threshold:
            x_min = int(row['xmin'])
            y_min = int(row['ymin'])
            x_max = int(row['xmax'])
            y_max = int(row['ymax'])

            detection = {
                "class": row['name'] if 'name' in row else "polyp",
                "confidence": f"{row['confidence']:.4f}",
                "bbox": {
                    "x": x_min,
                    "y": y_min,
                    "width": x_max - x_min,
                    "height": y_max - y_min
                }
            }
            detections.append(detection)

    return {
        "detections": detections,
        "image": {
            "width": width,
            "height": height
        }
    }


def main():
    parser = argparse.ArgumentParser(description='YOLOv5 肠道息肉检测')
    parser.add_argument('--model', type=str, required=True, help='模型文件路径 (.pt)')
    parser.add_argument('--source', type=str, required=True, help='输入图片路径')
    parser.add_argument('--conf', type=float, default=0.5, help='置信度阈值 (默认：0.5)')
    parser.add_argument('--output', type=str, default='json', help='输出格式 (json/image)')
    parser.add_argument('--save-dir', type=str, default='', help='保存结果图片的目录')

    args = parser.parse_args()

    # 加载模型
    model = load_model(args.model)

    # 执行检测
    start_time = time.time()
    result = detect_image(model, args.source, args.conf)
    inference_time = (time.time() - start_time) * 1000  # 毫秒

    result['inference_time'] = f"{inference_time:.2f}"

    # 输出结果
    if args.output == 'json':
        print(json.dumps(result, ensure_ascii=False))
    elif args.output == 'image':
        # 在图片上绘制检测结果
        img = cv2.imread(args.source)
        for det in result['detections']:
            bbox = det['bbox']
            x, y, w, h = bbox['x'], bbox['y'], bbox['width'], bbox['height']

            # 绘制边界框
            cv2.rectangle(img, (x, y), (x + w, y + h), (0, 255, 0), 2)

            # 绘制标签
            label = f"{det['class']} {det['confidence']}"
            cv2.putText(img, label, (x, y - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 2)

        # 保存结果
        if args.save_dir:
            os.makedirs(args.save_dir, exist_ok=True)
            output_path = os.path.join(args.save_dir, os.path.basename(args.source))
            cv2.imwrite(output_path, img)
            print(json.dumps({"result_image": output_path, "detections": result['detections']}))
        else:
            print(json.dumps(result, ensure_ascii=False))


if __name__ == '__main__':
    main()
