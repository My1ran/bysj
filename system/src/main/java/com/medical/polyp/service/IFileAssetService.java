package com.medical.polyp.service;

import org.springframework.web.multipart.MultipartFile;
import com.medical.polyp.domain.FileAsset;

public interface IFileAssetService
{
    public FileAsset uploadSourceFile(MultipartFile file);

    public FileAsset selectFileAssetByFileId(Long fileId);

    public String resolvePlayableVideoUrl(FileAsset fileAsset);
}
