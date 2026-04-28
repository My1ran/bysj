package com.medical.system.service.impl;

import java.util.List;
import com.medical.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.medical.system.mapper.DrugMapper;
import com.medical.system.domain.Drug;
import com.medical.system.service.IDrugService;

/**
 * 药品信息维护Service业务层处理
 * 
 * @author lijie
 * @date 2022-11-04
 */
@Service
public class DrugServiceImpl implements IDrugService 
{
    @Autowired
    private DrugMapper drugMapper;

    /**
     * 查询药品信息维护
     * 
     * @param drugId 药品信息维护主键
     * @return 药品信息维护
     */
    @Override
    public Drug selectDrugByDrugId(Long drugId)
    {
        return drugMapper.selectDrugByDrugId(drugId);
    }

    /**
     * 查询药品信息维护列表
     * 
     * @param drug 药品信息维护
     * @return 药品信息维护
     */
    @Override
    public List<Drug> selectDrugList(Drug drug)
    {
        return drugMapper.selectDrugList(drug);
    }

    /**
     * 新增药品信息维护
     * 
     * @param drug 药品信息维护
     * @return 结果
     */
    @Override
    public int insertDrug(Drug drug)
    {
        drug.setCreateTime(DateUtils.getNowDate());
        return drugMapper.insertDrug(drug);
    }

    /**
     * 修改药品信息维护
     * 
     * @param drug 药品信息维护
     * @return 结果
     */
    @Override
    public int updateDrug(Drug drug)
    {
        drug.setUpdateTime(DateUtils.getNowDate());
        return drugMapper.updateDrug(drug);
    }

    /**
     * 批量删除药品信息维护
     * 
     * @param drugIds 需要删除的药品信息维护主键
     * @return 结果
     */
    @Override
    public int deleteDrugByDrugIds(Long[] drugIds)
    {
        return drugMapper.deleteDrugByDrugIds(drugIds);
    }

    /**
     * 删除药品信息维护信息
     * 
     * @param drugId 药品信息维护主键
     * @return 结果
     */
    @Override
    public int deleteDrugByDrugId(Long drugId)
    {
        return drugMapper.deleteDrugByDrugId(drugId);
    }
}
