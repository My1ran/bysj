package com.medical.polyp.domain.vo;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.medical.common.annotation.Excel;

public class PolypTaskExportVO
{
    @Excel(name = "任务ID")
    private Long taskId;

    @Excel(name = "任务编号")
    private String taskNo;

    @Excel(name = "媒体类型")
    private String mediaType;

    @Excel(name = "状态")
    private String status;

    @Excel(name = "推理耗时(ms)")
    private Long inferenceMs;

    @Excel(name = "息肉数量")
    private Integer polypCount;

    @Excel(name = "结果图URL")
    private String resultImageUrl;

    @Excel(name = "结果视频URL")
    private String resultVideoUrl;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "创建时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

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

    public String getMediaType()
    {
        return mediaType;
    }

    public void setMediaType(String mediaType)
    {
        this.mediaType = mediaType;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public Long getInferenceMs()
    {
        return inferenceMs;
    }

    public void setInferenceMs(Long inferenceMs)
    {
        this.inferenceMs = inferenceMs;
    }

    public Integer getPolypCount()
    {
        return polypCount;
    }

    public void setPolypCount(Integer polypCount)
    {
        this.polypCount = polypCount;
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

    public Date getCreateTime()
    {
        return createTime;
    }

    public void setCreateTime(Date createTime)
    {
        this.createTime = createTime;
    }
}
