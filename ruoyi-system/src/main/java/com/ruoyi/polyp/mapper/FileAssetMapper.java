package com.ruoyi.polyp.mapper;

import com.ruoyi.polyp.domain.FileAsset;

public interface FileAssetMapper
{
    public int insertFileAsset(FileAsset fileAsset);

    public FileAsset selectFileAssetByFileId(Long fileId);
}
