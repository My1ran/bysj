package com.medical.system.yolo;

import java.util.List;

/**
 * YOLOv5 检测结果
 *
 * @author lijie
 * @date 2026-03-19
 */
public class YoloResult {

    /**
     * 检测到的目标列表
     */
    private List<BoundingBox> detections;

    /**
     * 原始图片宽度
     */
    private int originalWidth;

    /**
     * 原始图片高度
     */
    private int originalHeight;

    /**
     * 检测耗时 (ms)
     */
    private long inferenceTime;

    public List<BoundingBox> getDetections() {
        return detections;
    }

    public void setDetections(List<BoundingBox> detections) {
        this.detections = detections;
    }

    public int getOriginalWidth() {
        return originalWidth;
    }

    public void setOriginalWidth(int originalWidth) {
        this.originalWidth = originalWidth;
    }

    public int getOriginalHeight() {
        return originalHeight;
    }

    public void setOriginalHeight(int originalHeight) {
        this.originalHeight = originalHeight;
    }

    public long getInferenceTime() {
        return inferenceTime;
    }

    public void setInferenceTime(long inferenceTime) {
        this.inferenceTime = inferenceTime;
    }

    @Override
    public String toString() {
        return "YoloResult{" +
                "detections=" + detections +
                ", originalWidth=" + originalWidth +
                ", originalHeight=" + originalHeight +
                ", inferenceTime=" + inferenceTime +
                '}';
    }
}
