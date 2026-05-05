package com.medical.polyp.service.impl;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import com.medical.common.utils.SecurityUtils;
import com.medical.polyp.mapper.PolypDetectTaskMapper;
import com.medical.polyp.service.IPolypDashboardService;

@Service
public class PolypDashboardServiceImpl implements IPolypDashboardService
{
    private static final DateTimeFormatter DAY_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    private static final List<String> DEFAULT_STATUS = Arrays.asList("PENDING", "RUNNING", "SUCCESS", "FAILED");

    private final PolypDetectTaskMapper polypDetectTaskMapper;

    public PolypDashboardServiceImpl(PolypDetectTaskMapper polypDetectTaskMapper)
    {
        this.polypDetectTaskMapper = polypDetectTaskMapper;
    }

    @Override
    public Map<String, Object> getOverview()
    {
        Map<String, Object> raw = polypDetectTaskMapper.selectDashboardOverview(getCurrentUserId());
        if (raw == null)
        {
            raw = Collections.emptyMap();
        }

        Map<String, Object> overview = new LinkedHashMap<>();
        overview.put("totalTaskCount", asLong(raw.get("totalTaskCount")));
        overview.put("todayTaskCount", asLong(raw.get("todayTaskCount")));
        overview.put("successTaskCount", asLong(raw.get("successTaskCount")));
        overview.put("failedTaskCount", asLong(raw.get("failedTaskCount")));
        overview.put("avgInferenceMs", asDecimal(raw.get("avgInferenceMs")));
        overview.put("totalPolypCount", asLong(raw.get("totalPolypCount")));
        return overview;
    }

    @Override
    public List<Map<String, Object>> getTrend()
    {
        List<Map<String, Object>> dbRows = polypDetectTaskMapper.selectDashboardTrend(getCurrentUserId());
        Map<String, Long> dbMap = new HashMap<>();
        if (dbRows != null)
        {
            for (Map<String, Object> row : dbRows)
            {
                String day = String.valueOf(row.get("statDate"));
                dbMap.put(day, asLong(row.get("taskCount")));
            }
        }

        List<Map<String, Object>> trend = new ArrayList<>();
        LocalDate today = LocalDate.now();
        for (int i = 6; i >= 0; i--)
        {
            String day = today.minusDays(i).format(DAY_FORMATTER);
            Map<String, Object> item = new LinkedHashMap<>();
            item.put("date", day);
            item.put("taskCount", dbMap.getOrDefault(day, 0L));
            trend.add(item);
        }
        return trend;
    }

    @Override
    public Map<String, Object> getDistribution()
    {
        Long currentUserId = getCurrentUserId();
        List<Map<String, Object>> mediaRows = polypDetectTaskMapper.selectDashboardMediaDistribution(currentUserId);
        List<Map<String, Object>> statusRows = polypDetectTaskMapper.selectDashboardStatusDistribution(currentUserId);

        Map<String, Long> mediaMap = new LinkedHashMap<>();
        mediaMap.put("image", 0L);
        mediaMap.put("video", 0L);
        if (mediaRows != null)
        {
            for (Map<String, Object> row : mediaRows)
            {
                String type = String.valueOf(row.get("mediaType"));
                mediaMap.put(type, asLong(row.get("taskCount")));
            }
        }

        Map<String, Long> statusMap = new LinkedHashMap<>();
        for (String status : DEFAULT_STATUS)
        {
            statusMap.put(status, 0L);
        }
        if (statusRows != null)
        {
            for (Map<String, Object> row : statusRows)
            {
                String status = String.valueOf(row.get("status"));
                statusMap.put(status, asLong(row.get("taskCount")));
            }
        }

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("media", toPairList(mediaMap, "type", "count"));
        result.put("status", toPairList(statusMap, "status", "count"));
        return result;
    }

    @Override
    public List<Map<String, Object>> getRecent(int limit)
    {
        int safeLimit = limit <= 0 ? 10 : Math.min(limit, 50);
        List<Map<String, Object>> rows = polypDetectTaskMapper.selectDashboardRecentTasks(getCurrentUserId(), safeLimit);
        return rows == null ? Collections.emptyList() : rows;
    }

    private Long getCurrentUserId()
    {
        return SecurityUtils.getUserId();
    }

    private List<Map<String, Object>> toPairList(Map<String, Long> source, String keyName, String valueName)
    {
        List<Map<String, Object>> list = new ArrayList<>();
        for (Map.Entry<String, Long> entry : source.entrySet())
        {
            Map<String, Object> item = new LinkedHashMap<>();
            item.put(keyName, entry.getKey());
            item.put(valueName, entry.getValue());
            list.add(item);
        }
        return list;
    }

    private Long asLong(Object value)
    {
        if (value == null)
        {
            return 0L;
        }
        if (value instanceof Number)
        {
            return ((Number) value).longValue();
        }
        try
        {
            return Long.parseLong(String.valueOf(value));
        }
        catch (Exception e)
        {
            return 0L;
        }
    }

    private BigDecimal asDecimal(Object value)
    {
        if (value == null)
        {
            return BigDecimal.ZERO;
        }
        if (value instanceof BigDecimal)
        {
            return ((BigDecimal) value).setScale(2, RoundingMode.HALF_UP);
        }
        try
        {
            return new BigDecimal(String.valueOf(value)).setScale(2, RoundingMode.HALF_UP);
        }
        catch (Exception e)
        {
            return BigDecimal.ZERO;
        }
    }
}
