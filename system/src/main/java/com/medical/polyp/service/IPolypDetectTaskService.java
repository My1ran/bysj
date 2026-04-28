package com.medical.polyp.service;

import java.util.List;
import java.util.Map;
import com.medical.polyp.domain.PolypDetectTask;
import com.medical.polyp.domain.dto.PolypTaskCreateRequest;
import com.medical.polyp.domain.vo.PolypTaskExportVO;

public interface IPolypDetectTaskService
{
    PolypDetectTask createTask(PolypTaskCreateRequest request);

    Map<String, Object> getTaskDetail(Long taskId);

    List<PolypDetectTask> selectPolypDetectTaskList(PolypDetectTask query);

    int deleteTasks(Long[] taskIds);

    List<PolypTaskExportVO> selectTaskExportList(PolypDetectTask query);
}
