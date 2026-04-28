package com.medical.polyp.mapper;

import com.medical.polyp.domain.FileAsset;

public interface FileAssetMapper
{
    public int insertFileAsset(FileAsset fileAsset);

    public FileAsset selectFileAssetByFileId(Long fileId);
}
