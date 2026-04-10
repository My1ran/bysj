package com.ruoyi.web.controller.polyp;

import java.util.List;
import java.util.Map;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.polyp.domain.PolypDetectTask;
import com.ruoyi.polyp.domain.dto.PolypTaskCreateRequest;
import com.ruoyi.polyp.service.IPolypDetectTaskService;

@RestController
@RequestMapping("/system/polyp")
public class PolypTaskController extends BaseController
{
    private final IPolypDetectTaskService polypDetectTaskService;

    public PolypTaskController(IPolypDetectTaskService polypDetectTaskService)
    {
        this.polypDetectTaskService = polypDetectTaskService;
    }

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

    @PreAuthorize("@ss.hasPermi('system:polyp:task:query')")
    @GetMapping("/task/list")
    public TableDataInfo taskList(PolypDetectTask query)
    {
        startPage();
        List<PolypDetectTask> list = polypDetectTaskService.selectPolypDetectTaskList(query);
        return getDataTable(list);
    }
}