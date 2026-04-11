package com.ruoyi.polyp.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.polyp.domain.PolypDetectTask;

public interface PolypDetectTaskMapper
{
    int insertPolypDetectTask(PolypDetectTask task);

    int updatePolypDetectTask(PolypDetectTask task);

    PolypDetectTask selectPolypDetectTaskByTaskId(Long taskId);

    List<PolypDetectTask> selectPolypDetectTaskList(PolypDetectTask query);

    Map<String, Object> selectDashboardOverview();

    List<Map<String, Object>> selectDashboardTrend();

    List<Map<String, Object>> selectDashboardMediaDistribution();

    List<Map<String, Object>> selectDashboardStatusDistribution();

    List<Map<String, Object>> selectDashboardRecentTasks(@Param("limit") Integer limit);
}
