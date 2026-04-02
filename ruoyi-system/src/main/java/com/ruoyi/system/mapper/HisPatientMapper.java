package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.HisPatient;

/**
 * 患者信息 Mapper 接口
 *
 * @author lijie
 * @date 2026-03-19
 */
public interface HisPatientMapper
{
    /**
     * 查询患者信息
     *
     * @param patiId 患者 ID
     * @return 患者信息
     */
    public HisPatient selectHisPatientByPatiId(Long patiId);

    /**
     * 查询患者信息列表
     *
     * @param hisPatient 患者信息
     * @return 患者信息集合
     */
    public List<HisPatient> selectHisPatientList(HisPatient hisPatient);

    /**
     * 新增患者信息
     *
     * @param hisPatient 患者信息
     * @return 结果
     */
    public int insertHisPatient(HisPatient hisPatient);

    /**
     * 修改患者信息
     *
     * @param hisPatient 患者信息
     * @return 结果
     */
    public int updateHisPatient(HisPatient hisPatient);

    /**
     * 删除患者信息
     *
     * @param patiId 患者 ID
     * @return 结果
     */
    public int deleteHisPatientByPatiId(Long patiId);

    /**
     * 批量删除患者信息
     *
     * @param patiIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteHisPatientByPatiIds(Long[] patiIds);
}
