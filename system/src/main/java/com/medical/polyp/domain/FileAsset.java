package com.medical.polyp.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.medical.common.core.domain.BaseEntity;

public class FileAsset extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long fileId;
    private String bizType;
    private String originName;
    private String extName;
    private String mimeType;
    private Long sizeBytes;
    private String storePath;
    private String fileUrl;
    private String sha256;

    public Long getFileId()
    {
        return fileId;
    }

    public void setFileId(Long fileId)
    {
        this.fileId = fileId;
    }

    public String getBizType()
    {
        return bizType;
    }

    public void setBizType(String bizType)
    {
        this.bizType = bizType;
    }

    public String getOriginName()
    {
        return originName;
    }

    public void setOriginName(String originName)
    {
        this.originName = originName;
    }

    public String getExtName()
    {
        return extName;
    }

    public void setExtName(String extName)
    {
        this.extName = extName;
    }

    public String getMimeType()
    {
        return mimeType;
    }

    public void setMimeType(String mimeType)
    {
        this.mimeType = mimeType;
    }

    public Long getSizeBytes()
    {
        return sizeBytes;
    }

    public void setSizeBytes(Long sizeBytes)
    {
        this.sizeBytes = sizeBytes;
    }

    public String getStorePath()
    {
        return storePath;
    }

    public void setStorePath(String storePath)
    {
        this.storePath = storePath;
    }

    public String getFileUrl()
    {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl)
    {
        this.fileUrl = fileUrl;
    }

    public String getSha256()
    {
        return sha256;
    }

    public void setSha256(String sha256)
    {
        this.sha256 = sha256;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("fileId", getFileId())
            .append("bizType", getBizType())
            .append("originName", getOriginName())
            .append("extName", getExtName())
            .append("mimeType", getMimeType())
            .append("sizeBytes", getSizeBytes())
            .append("storePath", getStorePath())
            .append("fileUrl", getFileUrl())
            .append("sha256", getSha256())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .toString();
    }
}
