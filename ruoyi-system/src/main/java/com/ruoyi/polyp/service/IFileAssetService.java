package com.ruoyi.polyp.service;

import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.polyp.domain.FileAsset;

public interface IFileAssetService
{
    public FileAsset uploadSourceFile(MultipartFile file);

    public FileAsset selectFileAssetByFileId(Long fileId);

    public String resolvePlayableVideoUrl(FileAsset fileAsset);
}
