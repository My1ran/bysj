package com.ruoyi.polyp.domain;

import java.math.BigDecimal;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

public class PolypModel extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long modelId;
    private String modelName;
    private String modelVersion;
    private String modelPath;
    private String status;
    private Integer isDefault;
    private BigDecimal confThreshold;

    public Long getModelId()
    {
        return modelId;
    }

    public void setModelId(Long modelId)
    {
        this.modelId = modelId;
    }

    public String getModelName()
    {
        return modelName;
    }

    public void setModelName(String modelName)
    {
        this.modelName = modelName;
    }

    public String getModelVersion()
    {
        return modelVersion;
    }

    public void setModelVersion(String modelVersion)
    {
        this.modelVersion = modelVersion;
    }

    public String getModelPath()
    {
        return modelPath;
    }

    public void setModelPath(String modelPath)
    {
        this.modelPath = modelPath;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public Integer getIsDefault()
    {
        return isDefault;
    }

    public void setIsDefault(Integer isDefault)
    {
        this.isDefault = isDefault;
    }

    public BigDecimal getConfThreshold()
    {
        return confThreshold;
    }

    public void setConfThreshold(BigDecimal confThreshold)
    {
        this.confThreshold = confThreshold;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("modelId", getModelId())
            .append("modelName", getModelName())
            .append("modelVersion", getModelVersion())
            .append("modelPath", getModelPath())
            .append("status", getStatus())
            .append("isDefault", getIsDefault())
            .append("confThreshold", getConfThreshold())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
