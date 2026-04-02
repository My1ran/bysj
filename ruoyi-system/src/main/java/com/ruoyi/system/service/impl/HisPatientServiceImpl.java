package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.HisPatient;
import com.ruoyi.system.mapper.HisPatientMapper;
import com.ruoyi.system.service.IHisPatientService;

/**
 * 患者信息 Service 业务层处理
 *
 * @author lijie
 * @date 2026-03-19
 */
@Service
public class HisPatientServiceImpl implements IHisPatientService
{
    @Autowired
    private HisPatientMapper hisPatientMapper;

    /**
     * 查询患者信息
     *
     * @param patiId 患者 ID
     * @return 患者信息
     */
    @Override
    public HisPatient selectHisPatientByPatiId(Long patiId)
    {
        return hisPatientMapper.selectHisPatientByPatiId(patiId);
    }

    /**
     * 查询患者信息列表
     *
     * @param hisPatient 患者信息
     * @return 患者信息
     */
    @Override
    public List<HisPatient> selectHisPatientList(HisPatient hisPatient)
    {
        return hisPatientMapper.selectHisPatientList(hisPatient);
    }

    /**
     * 新增患者信息
     *
     * @param hisPatient 患者信息
     * @return 结果
     */
    @Override
    public int insertHisPatient(HisPatient hisPatient)
    {
        hisPatient.setCreateTime(DateUtils.getNowDate());
        return hisPatientMapper.insertHisPatient(hisPatient);
    }

    /**
     * 修改患者信息
     *
     * @param hisPatient 患者信息
     * @return 结果
     */
    @Override
    public int updateHisPatient(HisPatient hisPatient)
    {
        hisPatient.setUpdateTime(DateUtils.getNowDate());
        return hisPatientMapper.updateHisPatient(hisPatient);
    }

    /**
     * 批量删除患者信息
     *
     * @param patiIds 需要删除的患者 ID 集合
     * @return 结果
     */
    @Override
    public int deleteHisPatientByPatiIds(Long[] patiIds)
    {
        return hisPatientMapper.deleteHisPatientByPatiIds(patiIds);
    }

    /**
     * 删除患者信息
     *
     * @param patiId 患者 ID
     * @return 结果
     */
    @Override
    public int deleteHisPatientByPatiId(Long patiId)
    {
        return hisPatientMapper.deleteHisPatientByPatiId(patiId);
    }
}
