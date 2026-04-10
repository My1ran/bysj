package com.ruoyi.web.controller.polyp;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.polyp.domain.PolypModel;
import com.ruoyi.polyp.service.IPolypModelService;

@RestController
@RequestMapping("/system/polyp/model")
public class PolypModelController
{
    private final IPolypModelService polypModelService;

    public PolypModelController(IPolypModelService polypModelService)
    {
        this.polypModelService = polypModelService;
    }

    @PreAuthorize("@ss.hasPermi('system:polyp:model:query')")
    @GetMapping("/current")
    public AjaxResult currentModel()
    {
        PolypModel model = polypModelService.selectCurrentPolypModel();
        return AjaxResult.success(model);
    }
}
