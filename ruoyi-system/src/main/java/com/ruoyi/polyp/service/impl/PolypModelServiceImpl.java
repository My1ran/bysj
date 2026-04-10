package com.ruoyi.polyp.service.impl;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.polyp.domain.PolypModel;
import com.ruoyi.polyp.mapper.PolypModelMapper;
import com.ruoyi.polyp.service.IPolypModelService;

@Service
public class PolypModelServiceImpl implements IPolypModelService
{
    private final PolypModelMapper polypModelMapper;

    @Value("${polyp.inference.default-model-id:1}")
    private Long defaultModelId;

    public PolypModelServiceImpl(PolypModelMapper polypModelMapper)
    {
        this.polypModelMapper = polypModelMapper;
    }

    @Override
    public PolypModel selectCurrentPolypModel()
    {
        PolypModel model = polypModelMapper.selectCurrentPolypModel();
        if (model == null)
        {
            model = polypModelMapper.selectPolypModelByModelId(defaultModelId);
        }
        if (model == null)
        {
            throw new ServiceException("当前未配置可用检测模型");
        }
        return model;
    }

    @Override
    public PolypModel selectPolypModelByModelId(Long modelId)
    {
        return polypModelMapper.selectPolypModelByModelId(modelId);
    }
}
