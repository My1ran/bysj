package com.medical.polyp.service;

import com.medical.polyp.domain.PolypModel;

public interface IPolypModelService
{
    public PolypModel selectCurrentPolypModel();

    public PolypModel selectPolypModelByModelId(Long modelId);
}
