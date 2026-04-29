package com.medical.polyp.domain.dto;

import java.math.BigDecimal;

public class PolypTaskCreateRequest
{
    private Long sourceFileId;
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
