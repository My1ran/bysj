package com.ruoyi.polyp.mapper;

import java.util.List;
import com.ruoyi.polyp.domain.PolypDetectTask;

public interface PolypDetectTaskMapper
{
    int insertPolypDetectTask(PolypDetectTask task);

    int updatePolypDetectTask(PolypDetectTask task);

    PolypDetectTask selectPolypDetectTaskByTaskId(Long taskId);

    List<PolypDetectTask> selectPolypDetectTaskList(PolypDetectTask query);
}