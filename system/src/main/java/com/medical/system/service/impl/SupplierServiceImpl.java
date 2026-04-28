package com.medical.system.service.impl;

import java.util.List;
import com.medical.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.medical.system.mapper.SupplierMapper;
import com.medical.system.domain.Supplier;
import com.medical.system.service.ISupplierService;

/**
 * 供应商维护Service业务层处理
 * 
 * @author lijie
 * @date 2022-11-04
 */
@Service
public class SupplierServiceImpl implements ISupplierService 
{
    @Autowired
    private SupplierMapper supplierMapper;

    /**
     * 查询供应商维护
     * 
     * @param supId 供应商维护主键
     * @return 供应商维护
     */
    @Override
    public Supplier selectSupplierBySupId(Long supId)
    {
        return supplierMapper.selectSupplierBySupId(supId);
    }

    /**
     * 查询供应商维护列表
     * 
     * @param supplier 供应商维护
     * @return 供应商维护
     */
    @Override
    public List<Supplier> selectSupplierList(Supplier supplier)
    {
        return supplierMapper.selectSupplierList(supplier);
    }

    /**
     * 新增供应商维护
     * 
     * @param supplier 供应商维护
     * @return 结果
     */
    @Override
    public int insertSupplier(Supplier supplier)
    {
        supplier.setCreateTime(DateUtils.getNowDate());
        return supplierMapper.insertSupplier(supplier);
    }

    /**
     * 修改供应商维护
     * 
     * @param supplier 供应商维护
     * @return 结果
     */
    @Override
    public int updateSupplier(Supplier supplier)
    {
        supplier.setUpdateTime(DateUtils.getNowDate());
        return supplierMapper.updateSupplier(supplier);
    }

    /**
     * 批量删除供应商维护
     * 
     * @param supIds 需要删除的供应商维护主键
     * @return 结果
     */
    @Override
    public int deleteSupplierBySupIds(Long[] supIds)
    {
        return supplierMapper.deleteSupplierBySupIds(supIds);
    }

    /**
     * 删除供应商维护信息
     * 
     * @param supId 供应商维护主键
     * @return 结果
     */
    @Override
    public int deleteSupplierBySupId(Long supId)
    {
        return supplierMapper.deleteSupplierBySupId(supId);
    }
}
