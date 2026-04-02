package com.ruoyi.web.controller.system;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.HisPolypDetail;
import com.ruoyi.system.service.IHisPolypDetailService;

/**
 * 息肉详情 Controller
 *
 * @author lijie
 * @date 2026-03-27
 */
@RestController
@RequestMapping("/system/polyp")
public class HisPolypController extends BaseController
{
    @Autowired
    private IHisPolypDetailService hisPolypDetailService;

    /**
     * 查询息肉详情列表
     */
    @PreAuthorize("@ss.hasPermi('system:polyp:list')")
    @GetMapping("/list")
    public AjaxResult list(HisPolypDetail hisPolypDetail)
    {
        startPage();
        List<HisPolypDetail> list = hisPolypDetailService.selectHisPolypDetailList(hisPolypDetail);
        return AjaxResult.success(getDataTable(list));
    }

    /**
     * 根据检测结果ID查询息肉详情
     */
    @PreAuthorize("@ss.hasPermi('system:polyp:list')")
    @GetMapping("/listByResult/{resultId}")
    public AjaxResult listByResultId(@PathVariable("resultId") Long resultId)
    {
        List<HisPolypDetail> list = hisPolypDetailService.selectHisPolypDetailByResultId(resultId);
        return AjaxResult.success(list);
    }

    /**
     * 获取息肉详情详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:polyp:query')")
    @GetMapping("/{polypId}")
    public AjaxResult getInfo(@PathVariable("polypId") Long polypId)
    {
        return AjaxResult.success(hisPolypDetailService.selectHisPolypDetailByPolypId(polypId));
    }

    /**
     * 新增息肉详情
     */
    @PreAuthorize("@ss.hasPermi('system:polyp:add')")
    @Log(title = "息肉详情", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody HisPolypDetail hisPolypDetail)
    {
        return AjaxResult.success(hisPolypDetailService.insertHisPolypDetail(hisPolypDetail));
    }

    /**
     * 修改息肉详情
     */
    @PreAuthorize("@ss.hasPermi('system:polyp:edit')")
    @Log(title = "息肉详情", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody HisPolypDetail hisPolypDetail)
    {
        return AjaxResult.success(hisPolypDetailService.updateHisPolypDetail(hisPolypDetail));
    }

    /**
     * 删除息肉详情
     */
    @PreAuthorize("@ss.hasPermi('system:polyp:remove')")
    @Log(title = "息肉详情", businessType = BusinessType.DELETE)
    @DeleteMapping("/{polypIds}")
    public AjaxResult remove(@PathVariable Long[] polypIds)
    {
        return AjaxResult.success(hisPolypDetailService.deleteHisPolypDetailByPolypIds(polypIds));
    }
}
