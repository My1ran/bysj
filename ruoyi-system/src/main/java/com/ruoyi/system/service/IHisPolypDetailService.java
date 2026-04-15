package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.HisPolypDetail;

/**
 * 息肉详情 Service 接口
 *
 * @author lijie
 * @date 2026-03-19
 */
public interface IHisPolypDetailService
{
    /**
     * 查询息肉详情
     *
     * @param polypId 息肉 ID
     * @return 息肉详情
     */
    public HisPolypDetail selectHisPolypDetailByPolypId(Long polypId);

    /**
     * 查询息肉详情列表
     *
     * @param hisPolypDetail 息肉详情
     * @return 息肉详情集合
     */
    public List<HisPolypDetail> selectHisPolypDetailList(HisPolypDetail hisPolypDetail);

    /**
     * 查询检测结果的所有息肉详情
     *
     * @param resultId 检测结果 ID
     * @return 息肉详情列表
     */
    public List<HisPolypDetail> selectHisPolypDetailByResultId(Long resultId);

    /**
     * 新增息肉详情
     *
     * @param hisPolypDetail 息肉详情
     * @return 结果
     */
    public int insertHisPolypDetail(HisPolypDetail hisPolypDetail);

    /**
     * 修改息肉详情
     *
     * @param hisPolypDetail 息肉详情
     * @return 结果
     */
    public int updateHisPolypDetail(HisPolypDetail hisPolypDetail);

    /**
     * 批量删除息肉详情
     *
     * @param polypIds 需要删除的息肉 ID 集合
     * @return 结果
     */
    public int deleteHisPolypDetailByPolypIds(Long[] polypIds);

    /**
     * 删除息肉详情
     *
     * @param polypId 息肉 ID
     * @return 结果
     */
    public int deleteHisPolypDetailByPolypId(Long polypId);

    /**
     * 根据检测结果 ID 删除息肉详情
     *
     * @param resultId 检测结果 ID
     * @return 结果
     */
    public int deleteHisPolypDetailByResultId(Long resultId);
}
