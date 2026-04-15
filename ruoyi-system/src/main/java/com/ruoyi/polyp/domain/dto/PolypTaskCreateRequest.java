package com.ruoyi.polyp.domain.dto;

import java.math.BigDecimal;

public class PolypTaskCreateRequest
{
    private Long sourceFileId;
    private Long patientId;
    private Long modelId;
    private BigDecimal confThreshold;

    public Long getSourceFileId()
    {
        return sourceFileId;
    }

    public void setSourceFileId(Long sourceFileId)
    {
        this.sourceFileId = sourceFileId;
    }

    public Long getPatientId()
    {
        return patientId;
    }

    public void setPatientId(Long patientId)
    {
        this.patientId = patientId;
    }

    public Long getModelId()
    {
        return modelId;
    }

    public void setModelId(Long modelId)
    {
        this.modelId = modelId;
    }

    public BigDecimal getConfThreshold()
    {
        return confThreshold;
    }

    public void setConfThreshold(BigDecimal confThreshold)
    {
        this.confThreshold = confThreshold;
    }
}
