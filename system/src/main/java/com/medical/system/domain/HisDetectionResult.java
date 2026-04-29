package com.medical.system.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.medical.common.annotation.Excel;
import com.medical.common.core.domain.BaseEntity;

/**
 * 检测结果对象 his_detection_result
 *
 * @author lijie
 * @date 2026-03-19
 */
public class HisDetectionResult extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 检测结果 ID */
    private Long resultId;

    /** 用户ID */
    @Excel(name = "用户ID")
    private Long userId;

    /** 患者姓名 (冗余) */
    @Excel(name = "患者姓名")
    private String patiName;

    /** 检测类型 (0 图片检测 1 视频检测 2 实时检测) */
    @Excel(name = "检测类型")
    private String detectionType;

    /** 样本编号 */
    @Excel(name = "样本编号")
    private String sampleNumber;

    /** 原始文件路径 */
    @Excel(name = "原始文件路径")
    private String originalFile;

    /** 结果文件路径 */
    @Excel(name = "结果文件路径")
    private String resultFile;

    /** 息肉数量 */
    @Excel(name = "息肉数量")
    private Integer polypCount;

    /** 最大尺寸 (mm) */
    @Excel(name = "最大尺寸", readConverterExp = "mm")
    private BigDecimal maxSize;

    /** 最小尺寸 (mm) */
    @Excel(name = "最小尺寸", readConverterExp = "mm")
    private BigDecimal minSize;

    /** 平均置信度 */
    @Excel(name = "平均置信度")
    private BigDecimal avgConfidence;

    /** 息肉位置分布 (JSON) */
    @Excel(name = "息肉位置分布")
    private String positions;

    /** 检测时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "检测时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date detectionTime;

    /** 是否已生成报告 (0 否 1 是) */
    @Excel(name = "是否已生成报告", readConverterExp = "0=否，1=是")
    private String reportGenerated;

    /** 报告文件路径 */
    @Excel(name = "报告文件路径")
    private String reportFile;

    public void setResultId(Long resultId)
    {
        this.resultId = resultId;
    }

    public Long getResultId()
    {
        return resultId;
    }
    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Long getUserId()
    {
        return userId;
    }
    public void setPatiName(String patiName)
    {
        this.patiName = patiName;
    }

    public String getPatiName()
    {
        return patiName;
    }
    public void setDetectionType(String detectionType)
    {
        this.detectionType = detectionType;
    }

    public String getDetectionType()
    {
        return detectionType;
    }
    public void setSampleNumber(String sampleNumber)
    {
        this.sampleNumber = sampleNumber;
    }

    public String getSampleNumber()
    {
        return sampleNumber;
    }
    public void setOriginalFile(String originalFile)
    {
        this.originalFile = originalFile;
    }

    public String getOriginalFile()
    {
        return originalFile;
    }
    public void setResultFile(String resultFile)
    {
        this.resultFile = resultFile;
    }

    public String getResultFile()
    {
        return resultFile;
    }
    public void setPolypCount(Integer polypCount)
    {
        this.polypCount = polypCount;
    }

    public Integer getPolypCount()
    {
        return polypCount;
    }
    public void setMaxSize(BigDecimal maxSize)
    {
        this.maxSize = maxSize;
    }

    public BigDecimal getMaxSize()
    {
        return maxSize;
    }
    public void setMinSize(BigDecimal minSize)
    {
        this.minSize = minSize;
    }

    public BigDecimal getMinSize()
    {
        return minSize;
    }
    public void setAvgConfidence(BigDecimal avgConfidence)
    {
        this.avgConfidence = avgConfidence;
    }

    public BigDecimal getAvgConfidence()
    {
        return avgConfidence;
    }
    public void setPositions(String positions)
    {
        this.positions = positions;
    }

    public String getPositions()
    {
        return positions;
    }
    public void setDetectionTime(Date detectionTime)
    {
        this.detectionTime = detectionTime;
    }

    public Date getDetectionTime()
    {
        return detectionTime;
    }
    public void setReportGenerated(String reportGenerated)
    {
        this.reportGenerated = reportGenerated;
    }

    public String getReportGenerated()
    {
        return reportGenerated;
    }
    public void setReportFile(String reportFile)
    {
        this.reportFile = reportFile;
    }

    public String getReportFile()
    {
        return reportFile;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("resultId", getResultId())
            .append("userId", getUserId())
            .append("patiName", getPatiName())
            .append("detectionType", getDetectionType())
            .append("sampleNumber", getSampleNumber())
            .append("originalFile", getOriginalFile())
            .append("resultFile", getResultFile())
            .append("polypCount", getPolypCount())
            .append("maxSize", getMaxSize())
            .append("minSize", getMinSize())
            .append("avgConfidence", getAvgConfidence())
            .append("positions", getPositions())
            .append("detectionTime", getDetectionTime())
            .append("reportGenerated", getReportGenerated())
            .append("reportFile", getReportFile())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
