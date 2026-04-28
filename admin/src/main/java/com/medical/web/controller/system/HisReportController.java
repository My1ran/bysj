package com.medical.web.controller.system;

import java.io.IOException;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.medical.common.annotation.Log;
import com.medical.common.core.controller.BaseController;
import com.medical.common.core.domain.AjaxResult;
import com.medical.common.enums.BusinessType;
import com.medical.system.service.IHisDetectionResultService;
import com.medical.system.service.IHisPolypDetailService;
import com.medical.system.domain.HisDetectionResult;
import com.medical.system.domain.HisPolypDetail;

/**
 * 检测报告 Controller
 *
 * @author lijie
 * @date 2026-03-19
 */
@RestController
@Deprecated
@RequestMapping("/system/report")
public class HisReportController extends BaseController
{
    @Autowired
    private IHisDetectionResultService hisDetectionResultService;

    @Autowired
    private IHisPolypDetailService hisPolypDetailService;

    /**
     * 获取检测报告详情
     */
    @PreAuthorize("@ss.hasPermi('system:report:query')")
    @GetMapping(value = "/{resultId}")
    public AjaxResult getReport(@PathVariable("resultId") Long resultId)
    {
        HisDetectionResult result = hisDetectionResultService.selectHisDetectionResultByResultId(resultId);
        if (result == null) {
            return AjaxResult.error("检测结果不存在");
        }

        // 获取息肉详情
        java.util.List<HisPolypDetail> polypDetails = hisPolypDetailService.selectHisPolypDetailByResultId(resultId);
        result.getParams().put("polypDetails", polypDetails);

        return AjaxResult.success(result);
    }

    /**
     * 导出 PDF 报告
     */
    @PreAuthorize("@ss.hasPermi('system:report:export')")
    @Log(title = "检测报告", businessType = BusinessType.EXPORT)
    @GetMapping(value = "/{resultId}/pdf")
    public void exportPdf(@PathVariable("resultId") Long resultId, HttpServletResponse response) throws IOException
    {
        HisDetectionResult result = hisDetectionResultService.selectHisDetectionResultByResultId(resultId);
        if (result == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "检测结果不存在");
            return;
        }

        // TODO: 生成 PDF 报告
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=report_" + result.getSampleNumber() + ".pdf");

        // 这里调用 PDF 生成服务
        // pdfService.generateReport(result, response.getOutputStream());
    }
}
