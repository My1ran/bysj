package com.medical.web.controller.system;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.medical.common.annotation.Log;
import com.medical.common.core.controller.BaseController;
import com.medical.common.core.domain.AjaxResult;
import com.medical.common.enums.BusinessType;
import com.medical.system.domain.HisPatient;
import com.medical.system.service.IHisPatientService;
import com.medical.common.utils.poi.ExcelUtil;
import com.medical.common.core.page.TableDataInfo;

/**
 * 患者信息 Controller
 *
 * @author lijie
 * @date 2026-03-19
 */
@RestController
@RequestMapping("/system/patient")
public class HisPatientController extends BaseController
{
    @Autowired
    private IHisPatientService hisPatientService;

    /**
     * 查询患者信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:patient:list')")
    @GetMapping("/list")
    public TableDataInfo list(HisPatient hisPatient)
    {
        startPage();
        List<HisPatient> list = hisPatientService.selectHisPatientList(hisPatient);
        return getDataTable(list);
    }

    /**
     * 导出患者信息列表
     */
    @PreAuthorize("@ss.hasPermi('system:patient:export')")
    @Log(title = "患者信息", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, HisPatient hisPatient)
    {
        List<HisPatient> list = hisPatientService.selectHisPatientList(hisPatient);
        ExcelUtil<HisPatient> util = new ExcelUtil<HisPatient>(HisPatient.class);
        util.exportExcel(response, list, "患者信息");
    }

    /**
     * 获取患者信息详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:patient:query')")
    @GetMapping(value = "/{patiId}")
    public AjaxResult getInfo(@PathVariable("patiId") Long patiId)
    {
        return AjaxResult.success(hisPatientService.selectHisPatientByPatiId(patiId));
    }

    /**
     * 新增患者信息
     */
    @PreAuthorize("@ss.hasPermi('system:patient:add')")
    @Log(title = "患者信息", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody HisPatient hisPatient)
    {
        return toAjax(hisPatientService.insertHisPatient(hisPatient));
    }

    /**
     * 修改患者信息
     */
    @PreAuthorize("@ss.hasPermi('system:patient:edit')")
    @Log(title = "患者信息", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody HisPatient hisPatient)
    {
        return toAjax(hisPatientService.updateHisPatient(hisPatient));
    }

    /**
     * 删除患者信息
     */
    @PreAuthorize("@ss.hasPermi('system:patient:remove')")
    @Log(title = "患者信息", businessType = BusinessType.DELETE)
    @DeleteMapping("/{patiIds}")
    public AjaxResult remove(@PathVariable Long[] patiIds)
    {
        return toAjax(hisPatientService.deleteHisPatientByPatiIds(patiIds));
    }
}
