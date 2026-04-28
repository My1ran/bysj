package com.medical.system.service.impl;

import java.util.List;
import com.medical.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.medical.system.domain.HisDetectionResult;
import com.medical.system.mapper.HisDetectionResultMapper;
import com.medical.system.service.IHisDetectionResultService;

/**
 * 检测结果 Service 业务层处理
 *
 * @author lijie
 * @date 2026-03-19
 */
@Service
public class HisDetectionResultServiceImpl implements IHisDetectionResultService
{
    @Autowired
    private HisDetectionResultMapper hisDetectionResultMapper;

    /**
     * 查询检测结果
     *
     * @param resultId 检测结果 ID
     * @return 检测结果
     */
    @Override
    public HisDetectionResult selectHisDetectionResultByResultId(Long resultId)
    {
        return hisDetectionResultMapper.selectHisDetectionResultByResultId(resultId);
    }

    /**
     * 查询检测结果列表
     *
     * @param hisDetectionResult 检测结果
     * @return 检测结果
     */
    @Override
    public List<HisDetectionResult> selectHisDetectionResultList(HisDetectionResult hisDetectionResult)
    {
        return hisDetectionResultMapper.selectHisDetectionResultList(hisDetectionResult);
    }

    /**
     * 新增检测结果
     *
     * @param hisDetectionResult 检测结果
     * @return 结果
     */
    @Override
    public int insertHisDetectionResult(HisDetectionResult hisDetectionResult)
    {
        hisDetectionResult.setCreateTime(DateUtils.getNowDate());
        return hisDetectionResultMapper.insertHisDetectionResult(hisDetectionResult);
    }

    /**
     * 修改检测结果
     *
     * @param hisDetectionResult 检测结果
     * @return 结果
     */
    @Override
    public int updateHisDetectionResult(HisDetectionResult hisDetectionResult)
    {
        hisDetectionResult.setUpdateTime(DateUtils.getNowDate());
        return hisDetectionResultMapper.updateHisDetectionResult(hisDetectionResult);
    }

    /**
     * 批量删除检测结果
     *
     * @param resultIds 需要删除的检测结 ID 集合
     * @return 结果
     */
    @Override
    public int deleteHisDetectionResultByResultIds(Long[] resultIds)
    {
        return hisDetectionResultMapper.deleteHisDetectionResultByResultIds(resultIds);
    }

    /**
     * 删除检测结果
     *
     * @param resultId 检测结果 ID
     * @return 结果
     */
    @Override
    public int deleteHisDetectionResultByResultId(Long resultId)
    {
        return hisDetectionResultMapper.deleteHisDetectionResultByResultId(resultId);
    }
}
