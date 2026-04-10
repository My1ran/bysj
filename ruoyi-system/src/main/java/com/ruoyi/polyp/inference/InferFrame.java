package com.ruoyi.polyp.inference;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class InferFrame
{
    @JsonProperty("frame_index")
    private Integer frameIndex;

    @JsonProperty("timestamp_sec")
    private BigDecimal timestampSec;

    @JsonProperty("box_count")
    private Integer boxCount;

    @JsonProperty("max_confidence")
    private BigDecimal maxConfidence;

    private List<InferBox> boxes = new ArrayList<>();

    public Integer getFrameIndex()
    {
        return frameIndex;
    }

    public void setFrameIndex(Integer frameIndex)
    {
        this.frameIndex = frameIndex;
    }

    public BigDecimal getTimestampSec()
    {
        return timestampSec;
    }

    public void setTimestampSec(BigDecimal timestampSec)
    {
        this.timestampSec = timestampSec;
    }

    public Integer getBoxCount()
    {
        return boxCount;
    }

    public void setBoxCount(Integer boxCount)
    {
        this.boxCount = boxCount;
    }

    public BigDecimal getMaxConfidence()
    {
        return maxConfidence;
    }

    public void setMaxConfidence(BigDecimal maxConfidence)
    {
        this.maxConfidence = maxConfidence;
    }

    public List<InferBox> getBoxes()
    {
        return boxes;
    }

    public void setBoxes(List<InferBox> boxes)
    {
        this.boxes = boxes;
    }
}
