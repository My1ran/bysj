package com.ruoyi.polyp.service;

import java.util.List;
import java.util.Map;
import com.ruoyi.polyp.domain.PolypDetectTask;
import com.ruoyi.polyp.domain.dto.PolypTaskCreateRequest;
import com.ruoyi.polyp.domain.vo.PolypTaskExportVO;

public interface IPolypDetectTaskService
{
    PolypDetectTask createTask(PolypTaskCreateRequest request);

    Map<String, Object> getTaskDetail(Long taskId);

    List<PolypDetectTask> selectPolypDetectTaskList(PolypDetectTask query);

    int deleteTasks(Long[] taskIds);

    List<PolypTaskExportVO> selectTaskExportList(PolypDetectTask query);
}
