package com.medical.polyp.service;

import java.util.List;
import java.util.Map;

public interface IPolypDashboardService
{
    Map<String, Object> getOverview();

    List<Map<String, Object>> getTrend();

    Map<String, Object> getDistribution();

    List<Map<String, Object>> getRecent(int limit);
}
