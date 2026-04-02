package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.HisPolypDetail;

/**
 * 息肉详情 Mapper 接口
 *
 * @author lijie
 * @date 2026-03-19
 */
public interface HisPolypDetailMapper
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
     * 删除息肉详情
     *
     * @param polypId 息肉 ID
     * @return 结果
     */
    public int deleteHisPolypDetailByPolypId(Long polypId);

    /**
     * 批量删除息肉详情
     *
     * @param polypIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteHisPolypDetailByPolypIds(Long[] polypIds);

    /**
     * 根据检测结果 ID 删除息肉详情
     *
     * @param resultId 检测结果 ID
     * @return 结果
     */
    public int deleteHisPolypDetailByResultId(Long resultId);
}
