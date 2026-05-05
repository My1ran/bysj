package com.medical.web.controller.polyp;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.medical.common.core.domain.AjaxResult;
import com.medical.polyp.service.IPolypDashboardService;

@RestController
@RequestMapping("/system/polyp/dashboard")
public class PolypDashboardController
{
    private final IPolypDashboardService polypDashboardService;

    public PolypDashboardController(IPolypDashboardService polypDashboardService)
    {
        this.polypDashboardService = polypDashboardService;
    }

    @PreAuthorize("@ss.hasPermi('system:polyp:query')")
    @GetMapping("/overview")
    public AjaxResult overview()
    {
        return AjaxResult.success(polypDashboardService.getOverview());
    }

    @PreAuthorize("@ss.hasPermi('system:polyp:query')")
    @GetMapping("/trend")
    public AjaxResult trend()
    {
        return AjaxResult.success(polypDashboardService.getTrend());
    }

    @PreAuthorize("@ss.hasPermi('system:polyp:query')")
    @GetMapping("/distribution")
    public AjaxResult distribution()
    {
        return AjaxResult.success(polypDashboardService.getDistribution());
    }

    @PreAuthorize("@ss.hasPermi('system:polyp:query')")
    @GetMapping("/recent")
    public AjaxResult recent(@RequestParam(value = "limit", defaultValue = "10") Integer limit)
    {
        return AjaxResult.success(polypDashboardService.getRecent(limit == null ? 10 : limit));
    }
}
