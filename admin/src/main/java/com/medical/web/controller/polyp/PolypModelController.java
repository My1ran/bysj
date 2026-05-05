package com.medical.web.controller.polyp;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.medical.common.core.domain.AjaxResult;
import com.medical.polyp.domain.PolypModel;
import com.medical.polyp.service.IPolypModelService;

@RestController
@RequestMapping("/system/polyp/model")
public class PolypModelController
{
    private final IPolypModelService polypModelService;

    public PolypModelController(IPolypModelService polypModelService)
    {
        this.polypModelService = polypModelService;
    }

    @PreAuthorize("@ss.hasPermi('system:polyp:query')")
    @GetMapping("/current")
    public AjaxResult currentModel()
    {
        PolypModel model = polypModelService.selectCurrentPolypModel();
        return AjaxResult.success(model);
    }
}
