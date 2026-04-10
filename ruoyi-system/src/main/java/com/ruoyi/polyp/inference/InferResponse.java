package com.ruoyi.polyp.inference;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class InferResponse
{
    private Boolean success;
    private String message;

    @JsonProperty("file_type")
    private String fileType;

    @JsonProperty("inference_ms")
    private Long inferenceMs;

    @JsonProperty("image_width")
    private Integer imageWidth;

    @JsonProperty("image_height")
    private Integer imageHeight;

    @JsonProperty("frame_count")
    private Integer frameCount;

    @JsonProperty("detected_frame_count")
    private Integer detectedFrameCount;

    @JsonProperty("max_confidence")
    private BigDecimal maxConfidence;

    @JsonProperty("result_image_url")
    private String resultImageUrl;

    @JsonProperty("result_video_url")
    private String resultVideoUrl;

    @JsonProperty("result_frames_url")
    private String resultFramesUrl;

    private BigDecimal fps;

    private List<InferBox> boxes = new ArrayList<>();
    private List<InferFrame> frames = new ArrayList<>();

    public Boolean getSuccess()
    {
        return success;
    }

    public void setSuccess(Boolean success)
    {
        this.success = success;
    }

    public String getMessage()
    {
        return message;
    }

    public void setMessage(String message)
    {
        this.message = message;
    }

    public Long getInferenceMs()
    {
        return inferenceMs;
    }

    public void setInferenceMs(Long inferenceMs)
    {
        this.inferenceMs = inferenceMs;
    }

    public Integer getImageWidth()
    {
        return imageWidth;
    }

    public void setImageWidth(Integer imageWidth)
    {
        this.imageWidth = imageWidth;
    }

    public Integer getImageHeight()
    {
        return imageHeight;
    }

    public void setImageHeight(Integer imageHeight)
    {
        this.imageHeight = imageHeight;
    }

    public String getFileType()
    {
        return fileType;
    }

    public void setFileType(String fileType)
    {
        this.fileType = fileType;
    }

    public Integer getFrameCount()
    {
        return frameCount;
    }

    public void setFrameCount(Integer frameCount)
    {
        this.frameCount = frameCount;
    }

    public Integer getDetectedFrameCount()
    {
        return detectedFrameCount;
    }

    public void setDetectedFrameCount(Integer detectedFrameCount)
    {
        this.detectedFrameCount = detectedFrameCount;
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

    public BigDecimal getFps()
    {
        return fps;
    }

    public void setFps(BigDecimal fps)
    {
        this.fps = fps;
    }

    public String getResultImageUrl()
    {
        return resultImageUrl;
    }

    public void setResultImageUrl(String resultImageUrl)
    {
        this.resultImageUrl = resultImageUrl;
    }

    public String getResultVideoUrl()
    {
        return resultVideoUrl;
    }

    public void setResultVideoUrl(String resultVideoUrl)
    {
        this.resultVideoUrl = resultVideoUrl;
    }

    public List<InferFrame> getFrames()
    {
        return frames;
    }

    public void setFrames(List<InferFrame> frames)
    {
        this.frames = frames;
    }

    public String getResultFramesUrl()
    {
        return resultFramesUrl;
    }

    public void setResultFramesUrl(String resultFramesUrl)
    {
        this.resultFramesUrl = resultFramesUrl;
    }
}
