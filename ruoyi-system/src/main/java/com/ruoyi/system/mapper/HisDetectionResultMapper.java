package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.HisDetectionResult;

/**
 * 检测结果 Mapper 接口
 *
 * @author lijie
 * @date 2026-03-19
 */
public interface HisDetectionResultMapper
{
    /**
     * 查询检测结果
     *
     * @param resultId 检测结果 ID
     * @return 检测结果
     */
    public HisDetectionResult selectHisDetectionResultByResultId(Long resultId);

    /**
     * 查询检测结果列表
     *
     * @param hisDetectionResult 检测结果
     * @return 检测结果集合
     */
    public List<HisDetectionResult> selectHisDetectionResultList(HisDetectionResult hisDetectionResult);

    /**
     * 新增检测结果
     *
     * @param hisDetectionResult 检测结果
     * @return 结果
     */
    public int insertHisDetectionResult(HisDetectionResult hisDetectionResult);

    /**
     * 修改检测结果
     *
     * @param hisDetectionResult 检测结果
     * @return 结果
     */
    public int updateHisDetectionResult(HisDetectionResult hisDetectionResult);

    /**
     * 删除检测结果
     *
     * @param resultId 检测结果 ID
     * @return 结果
     */
    public int deleteHisDetectionResultByResultId(Long resultId);

    /**
     * 批量删除检测结果
     *
     * @param resultIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteHisDetectionResultByResultIds(Long[] resultIds);
}
