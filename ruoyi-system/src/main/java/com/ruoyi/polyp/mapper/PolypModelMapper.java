package com.ruoyi.polyp.mapper;

import com.ruoyi.polyp.domain.PolypModel;

public interface PolypModelMapper
{
    public PolypModel selectPolypModelByModelId(Long modelId);

    public PolypModel selectCurrentPolypModel();
}
