package com.ruoyi.polyp.inference;

import java.math.BigDecimal;
import com.fasterxml.jackson.annotation.JsonProperty;

public class InferRequest
{
    @JsonProperty("image_path")
    private String imagePath;

    @JsonProperty("model_path")
    private String modelPath;

    @JsonProperty("model_id")
    private Long modelId;

    @JsonProperty("conf_threshold")
    private BigDecimal confThreshold;

    public String getImagePath()
    {
        return imagePath;
    }

    public void setImagePath(String imagePath)
    {
        this.imagePath = imagePath;
    }

    public String getModelPath()
    {
        return modelPath;
    }

    public void setModelPath(String modelPath)
    {
        this.modelPath = modelPath;
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
