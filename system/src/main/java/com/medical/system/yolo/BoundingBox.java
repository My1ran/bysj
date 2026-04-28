package com.medical.system.yolo;

import java.math.BigDecimal;

/**
 * YOLOv5 检测边界框
 *
 * @author lijie
 * @date 2026-03-19
 */
public class BoundingBox {

    /**
     * 类别名称
     */
    private String className;

    /**
     * 置信度
     */
    private BigDecimal confidence;

    /**
     * 边界框 X 坐标
     */
    private Integer x;

    /**
     * 边界框 Y 坐标
     */
    private Integer y;

    /**
     * 边界框宽度
     */
    private Integer width;

    /**
     * 边界框高度
     */
    private Integer height;

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public BigDecimal getConfidence() {
        return confidence;
    }

    public void setConfidence(BigDecimal confidence) {
        this.confidence = confidence;
    }

    public Integer getX() {
        return x;
    }

    public void setX(Integer x) {
        this.x = x;
    }

    public Integer getY() {
        return y;
    }

    public void setY(Integer y) {
        this.y = y;
    }

    public Integer getWidth() {
        return width;
    }

    public void setWidth(Integer width) {
        this.width = width;
    }

    public Integer getHeight() {
        return height;
    }

    public void setHeight(Integer height) {
        this.height = height;
    }

    @Override
    public String toString() {
        return "BoundingBox{" +
                "className='" + className + '\'' +
                ", confidence=" + confidence +
                ", x=" + x +
                ", y=" + y +
                ", width=" + width +
                ", height=" + height +
                '}';
    }
}
