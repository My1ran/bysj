package com.medical.polyp.mapper;

import com.medical.polyp.domain.PolypModel;

public interface PolypModelMapper
{
    public PolypModel selectPolypModelByModelId(Long modelId);

    public PolypModel selectCurrentPolypModel();
}
