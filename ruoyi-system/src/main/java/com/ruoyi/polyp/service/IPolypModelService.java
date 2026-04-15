package com.ruoyi.polyp.service;

import com.ruoyi.polyp.domain.PolypModel;

public interface IPolypModelService
{
    public PolypModel selectCurrentPolypModel();

    public PolypModel selectPolypModelByModelId(Long modelId);
}
