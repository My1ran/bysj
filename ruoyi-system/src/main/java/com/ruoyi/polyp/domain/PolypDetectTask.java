package com.ruoyi.polyp.domain;

import java.math.BigDecimal;
import java.util.Date;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.BaseEntity;

public class PolypDetectTask extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long taskId;
    private String taskNo;
    private Long patientId;
    private Long sourceFileId;
    private Long modelId;
    private String status;
    private BigDecimal confThreshold;
    private Long resultId;
    private Long inferenceMs;
    private String errorMsg;
    private String mediaType;
    private Integer polypCount;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date startTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date finishTime;

    public Long getTaskId()
    {
        return taskId;
    }

    public void setTaskId(Long taskId)
    {
        this.taskId = taskId;
    }

    public String getTaskNo()
    {
        return taskNo;
    }

    public void setTaskNo(String taskNo)
    {
        this.taskNo = taskNo;
    }

    public Long getPatientId()
    {
        return patientId;
    }

    public void setPatientId(Long patientId)
    {
        this.patientId = patientId;
    }

    public Long getSourceFileId()
    {
        return sourceFileId;
    }

    public void setSourceFileId(Long sourceFileId)
    {
        this.sourceFileId = sourceFileId;
    }

    public Long getModelId()
    {
        return modelId;
    }

    public void setModelId(Long modelId)
    {
        this.modelId = modelId;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public BigDecimal getConfThreshold()
    {
        return confThreshold;
    }

    public void setConfThreshold(BigDecimal confThreshold)
    {
        this.confThreshold = confThreshold;
    }

    public Long getResultId()
    {
        return resultId;
    }

    public void setResultId(Long resultId)
    {
        this.resultId = resultId;
    }

    public Long getInferenceMs()
    {
        return inferenceMs;
    }

    public void setInferenceMs(Long inferenceMs)
    {
        this.inferenceMs = inferenceMs;
    }

    public String getErrorMsg()
    {
        return errorMsg;
    }

    public void setErrorMsg(String errorMsg)
    {
        this.errorMsg = errorMsg;
    }

    public String getMediaType()
    {
        return mediaType;
    }

    public void setMediaType(String mediaType)
    {
        this.mediaType = mediaType;
    }

    public Integer getPolypCount()
    {
        return polypCount;
    }

    public void setPolypCount(Integer polypCount)
    {
        this.polypCount = polypCount;
    }

    public Date getStartTime()
    {
        return startTime;
    }

    public void setStartTime(Date startTime)
    {
        this.startTime = startTime;
    }

    public Date getFinishTime()
    {
        return finishTime;
    }

    public void setFinishTime(Date finishTime)
    {
        this.finishTime = finishTime;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("taskId", getTaskId())
            .append("taskNo", getTaskNo())
            .append("patientId", getPatientId())
            .append("sourceFileId", getSourceFileId())
            .append("modelId", getModelId())
            .append("status", getStatus())
            .append("confThreshold", getConfThreshold())
            .append("resultId", getResultId())
            .append("inferenceMs", getInferenceMs())
            .append("errorMsg", getErrorMsg())
            .append("mediaType", getMediaType())
            .append("polypCount", getPolypCount())
            .append("startTime", getStartTime())
            .append("finishTime", getFinishTime())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
