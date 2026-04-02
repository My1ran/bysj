package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.HisPolypDetail;
import com.ruoyi.system.mapper.HisPolypDetailMapper;
import com.ruoyi.system.service.IHisPolypDetailService;

/**
 * 息肉详情 Service 业务层处理
 *
 * @author lijie
 * @date 2026-03-19
 */
@Service
public class HisPolypDetailServiceImpl implements IHisPolypDetailService
{
    @Autowired
    private HisPolypDetailMapper hisPolypDetailMapper;

    /**
     * 查询息肉详情
     *
     * @param polypId 息肉 ID
     * @return 息肉详情
     */
    @Override
    public HisPolypDetail selectHisPolypDetailByPolypId(Long polypId)
    {
        return hisPolypDetailMapper.selectHisPolypDetailByPolypId(polypId);
    }

    /**
     * 查询息肉详情列表
     *
     * @param hisPolypDetail 息肉详情
     * @return 息肉详情
     */
    @Override
    public List<HisPolypDetail> selectHisPolypDetailList(HisPolypDetail hisPolypDetail)
    {
        return hisPolypDetailMapper.selectHisPolypDetailList(hisPolypDetail);
    }

    /**
     * 查询检测结果的所有息肉详情
     *
     * @param resultId 检测结果 ID
     * @return 息肉详情列表
     */
    @Override
    public List<HisPolypDetail> selectHisPolypDetailByResultId(Long resultId)
    {
        return hisPolypDetailMapper.selectHisPolypDetailByResultId(resultId);
    }

    /**
     * 新增息肉详情
     *
     * @param hisPolypDetail 息肉详情
     * @return 结果
     */
    @Override
    public int insertHisPolypDetail(HisPolypDetail hisPolypDetail)
    {
        hisPolypDetail.setCreateTime(DateUtils.getNowDate());
        return hisPolypDetailMapper.insertHisPolypDetail(hisPolypDetail);
    }

    /**
     * 修改息肉详情
     *
     * @param hisPolypDetail 息肉详情
     * @return 结果
     */
    @Override
    public int updateHisPolypDetail(HisPolypDetail hisPolypDetail)
    {
        return hisPolypDetailMapper.updateHisPolypDetail(hisPolypDetail);
    }

    /**
     * 批量删除息肉详情
     *
     * @param polypIds 需要删除的息肉 ID 集合
     * @return 结果
     */
    @Override
    public int deleteHisPolypDetailByPolypIds(Long[] polypIds)
    {
        return hisPolypDetailMapper.deleteHisPolypDetailByPolypIds(polypIds);
    }

    /**
     * 删除息肉详情
     *
     * @param polypId 息肉 ID
     * @return 结果
     */
    @Override
    public int deleteHisPolypDetailByPolypId(Long polypId)
    {
        return hisPolypDetailMapper.deleteHisPolypDetailByPolypId(polypId);
    }

    /**
     * 根据检测结果 ID 删除息肉详情
     *
     * @param resultId 检测结果 ID
     * @return 结果
     */
    @Override
    public int deleteHisPolypDetailByResultId(Long resultId)
    {
        return hisPolypDetailMapper.deleteHisPolypDetailByResultId(resultId);
    }
}
