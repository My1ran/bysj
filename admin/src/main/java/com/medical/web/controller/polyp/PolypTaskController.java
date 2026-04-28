package com.medical.web.controller.polyp;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.medical.common.annotation.Log;
import com.medical.common.core.controller.BaseController;
import com.medical.common.core.domain.AjaxResult;
import com.medical.common.core.page.TableDataInfo;
import com.medical.common.enums.BusinessType;
import com.medical.common.utils.poi.ExcelUtil;
import com.medical.polyp.domain.PolypDetectTask;
import com.medical.polyp.domain.dto.PolypTaskCreateRequest;
import com.medical.polyp.domain.vo.PolypTaskExportVO;
import com.medical.polyp.service.IPolypDetectTaskService;

@RestController
@RequestMapping("/system/polyp")
public class PolypTaskController extends BaseController
{
    private final IPolypDetectTaskService polypDetectTaskService;

    public PolypTaskController(IPolypDetectTaskService polypDetectTaskService)
    {
        this.polypDetectTaskService = polypDetectTaskService;
    }

    @Log(title = "检查任务创建", businessType = BusinessType.INSERT, isSaveResponseData = false)
    @PreAuthorize("@ss.hasPermi('system:polyp:task:add')")
    @PostMapping("/task")
    public AjaxResult createTask(@RequestBody PolypTaskCreateRequest request)
    {
        PolypDetectTask task = polypDetectTaskService.createTask(request);
        return AjaxResult.success(task);
    }

    @PreAuthorize("@ss.hasPermi('system:polyp:task:query')")
    @GetMapping("/task/{taskId}")
    public AjaxResult taskDetail(@PathVariable("taskId") Long taskId)
    {
        Map<String, Object> detail = polypDetectTaskService.getTaskDetail(taskId);
        return AjaxResult.success(detail);
    }

    @Log(title = "检查任务详情查看", businessType = BusinessType.OTHER, isSaveResponseData = false)
    @PreAuthorize("@ss.hasPermi('system:polyp:task:query')")
    @GetMapping("/task/{taskId}/view")
    public AjaxResult taskDetailForView(@PathVariable("taskId") Long taskId)
    {
        Map<String, Object> detail = polypDetectTaskService.getTaskDetail(taskId);
        return AjaxResult.success(detail);
    }

    @PreAuthorize("@ss.hasPermi('system:polyp:task:query')")
    @GetMapping("/task/list")
    public TableDataInfo taskList(PolypDetectTask query)
    {
        startPage();
        List<PolypDetectTask> list = polypDetectTaskService.selectPolypDetectTaskList(query);
        return getDataTable(list);
    }

    @Log(title = "检查任务删除", businessType = BusinessType.DELETE, isSaveResponseData = false)
    @PreAuthorize("@ss.hasPermi('system:polyp:task:remove')")
    @DeleteMapping("/task/{taskIds}")
    public AjaxResult remove(@PathVariable Long[] taskIds)
    {
        return toAjax(polypDetectTaskService.deleteTasks(taskIds));
    }

    @Log(title = "检查任务导出", businessType = BusinessType.EXPORT)
    @PreAuthorize("@ss.hasPermi('system:polyp:task:export')")
    @PostMapping("/task/export")
    public void export(HttpServletResponse response, PolypDetectTask query)
    {
        List<PolypTaskExportVO> list = polypDetectTaskService.selectTaskExportList(query);
        ExcelUtil<PolypTaskExportVO> util = new ExcelUtil<>(PolypTaskExportVO.class);
        util.exportExcel(response, list, "检查任务数据");
    }
}
