package com.ruoyi.system.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 息肉详情对象 his_polyp_detail
 *
 * @author lijie
 * @date 2026-03-19
 */
public class HisPolypDetail extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 息肉 ID */
    private Long polypId;

    /** 检测结果 ID */
    private Long resultId;

    /** 息肉序号 */
    private Integer polypIndex;

    /** 置信度 */
    private BigDecimal confidence;

    /** 尺寸 (mm) */
    private BigDecimal sizeMm;

    /** 位置 */
    private String position;

    /** 边界框 X 坐标 */
    private Integer bboxX;

    /** 边界框 Y 坐标 */
    private Integer bboxY;

    /** 边界框宽度 */
    private Integer bboxWidth;

    /** 边界框高度 */
    private Integer bboxHeight;

    /** 分类 */
    private String classification;

    public void setPolypId(Long polypId)
    {
        this.polypId = polypId;
    }

    public Long getPolypId()
    {
        return polypId;
    }
    public void setResultId(Long resultId)
    {
        this.resultId = resultId;
    }

    public Long getResultId()
    {
        return resultId;
    }
    public void setPolypIndex(Integer polypIndex)
    {
        this.polypIndex = polypIndex;
    }

    public Integer getPolypIndex()
    {
        return polypIndex;
    }
    public void setConfidence(BigDecimal confidence)
    {
        this.confidence = confidence;
    }

    public BigDecimal getConfidence()
    {
        return confidence;
    }
    public void setSizeMm(BigDecimal sizeMm)
    {
        this.sizeMm = sizeMm;
    }

    public BigDecimal getSizeMm()
    {
        return sizeMm;
    }
    public void setPosition(String position)
    {
        this.position = position;
    }

    public String getPosition()
    {
        return position;
    }
    public void setBboxX(Integer bboxX)
    {
        this.bboxX = bboxX;
    }

    public Integer getBboxX()
    {
        return bboxX;
    }
    public void setBboxY(Integer bboxY)
    {
        this.bboxY = bboxY;
    }

    public Integer getBboxY()
    {
        return bboxY;
    }
    public void setBboxWidth(Integer bboxWidth)
    {
        this.bboxWidth = bboxWidth;
    }

    public Integer getBboxWidth()
    {
        return bboxWidth;
    }
    public void setBboxHeight(Integer bboxHeight)
    {
        this.bboxHeight = bboxHeight;
    }

    public Integer getBboxHeight()
    {
        return bboxHeight;
    }
    public void setClassification(String classification)
    {
        this.classification = classification;
    }

    public String getClassification()
    {
        return classification;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("polypId", getPolypId())
            .append("resultId", getResultId())
            .append("polypIndex", getPolypIndex())
            .append("confidence", getConfidence())
            .append("sizeMm", getSizeMm())
            .append("position", getPosition())
            .append("bboxX", getBboxX())
            .append("bboxY", getBboxY())
            .append("bboxWidth", getBboxWidth())
            .append("bboxHeight", getBboxHeight())
            .append("classification", getClassification())
            .append("createTime", getCreateTime())
            .toString();
    }
}
