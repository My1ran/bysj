package com.medical.polyp.service.impl;

import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.fail;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.multipart.MultipartFile;
import com.medical.common.core.domain.entity.SysUser;
import com.medical.common.core.domain.model.LoginUser;
import com.medical.common.exception.ServiceException;
import com.medical.polyp.domain.FileAsset;
import com.medical.polyp.domain.PolypDetectTask;
import com.medical.polyp.domain.PolypModel;
import com.medical.polyp.mapper.PolypDetectTaskMapper;
import com.medical.polyp.service.IFileAssetService;
import com.medical.polyp.service.IPolypModelService;

public class PolypDetectTaskServiceImplTest
{
    private RecordingTaskMapper taskMapper;
    private PolypDetectTaskServiceImpl service;

    @Before
    public void setUp()
    {
        setCurrentUser(7L);
        taskMapper = new RecordingTaskMapper();
        service = new PolypDetectTaskServiceImpl(
            taskMapper,
            new EmptyFileAssetService(),
            new EmptyPolypModelService(),
            null,
            null,
            null);
    }

    @After
    public void tearDown()
    {
        SecurityContextHolder.clearContext();
    }

    @Test
    public void selectListAlwaysUsesCurrentUser()
    {
        PolypDetectTask query = new PolypDetectTask();
        query.setUserId(99L);

        service.selectPolypDetectTaskList(query);

        assertEquals(Long.valueOf(7L), taskMapper.lastListQuery.getUserId());
    }

    @Test
    public void adminListDoesNotApplyUserScope()
    {
        setCurrentUser(1L);
        PolypDetectTask query = new PolypDetectTask();
        query.setUserId(99L);

        service.selectPolypDetectTaskList(query);

        assertNull(taskMapper.lastListQuery.getUserId());
    }

    @Test
    public void exportAlwaysUsesCurrentUser()
    {
        PolypDetectTask query = new PolypDetectTask();
        query.setUserId(99L);

        service.selectTaskExportList(query);

        assertEquals(Long.valueOf(7L), taskMapper.lastExportQuery.getUserId());
    }

    @Test
    public void adminExportDoesNotApplyUserScope()
    {
        setCurrentUser(1L);
        PolypDetectTask query = new PolypDetectTask();
        query.setUserId(99L);

        service.selectTaskExportList(query);

        assertNull(taskMapper.lastExportQuery.getUserId());
    }

    @Test
    public void detailRejectsOtherUsersTask()
    {
        taskMapper.tasks.put(10L, task(10L, 8L));

        try
        {
            service.getTaskDetail(10L);
            fail("Expected other users' tasks to be hidden");
        }
        catch (ServiceException e)
        {
            assertEquals("task does not exist", e.getMessage());
        }
    }

    @Test
    public void adminCanViewOtherUsersTask()
    {
        setCurrentUser(1L);
        taskMapper.tasks.put(14L, task(14L, 8L));

        assertEquals(Long.valueOf(14L), ((PolypDetectTask) service.getTaskDetail(14L).get("task")).getTaskId());
    }

    @Test
    public void deleteOnlyRemovesCurrentUsersTasks()
    {
        taskMapper.tasks.put(11L, task(11L, 7L));
        taskMapper.tasks.put(12L, task(12L, 8L));

        int deleted = service.deleteTasks(new Long[] {11L, 12L});

        assertEquals(1, deleted);
        assertArrayEquals(new Long[] {11L}, taskMapper.deletedTaskIds);
    }

    @Test
    public void adminCanDeleteAllUsersTasks()
    {
        setCurrentUser(1L);
        taskMapper.tasks.put(15L, task(15L, 7L));
        taskMapper.tasks.put(16L, task(16L, 8L));

        int deleted = service.deleteTasks(new Long[] {15L, 16L});

        assertEquals(2, deleted);
        assertArrayEquals(new Long[] {15L, 16L}, taskMapper.deletedTaskIds);
    }

    @Test
    public void deleteIgnoresOtherUsersTask()
    {
        taskMapper.tasks.put(13L, task(13L, 8L));

        int deleted = service.deleteTasks(new Long[] {13L});

        assertEquals(0, deleted);
        assertNull(taskMapper.deletedTaskIds);
    }

    private static PolypDetectTask task(Long taskId, Long userId)
    {
        PolypDetectTask task = new PolypDetectTask();
        task.setTaskId(taskId);
        task.setUserId(userId);
        task.setSourceFileId(1L);
        task.setModelId(1L);
        task.setIsDeleted(0);
        return task;
    }

    private static void setCurrentUser(Long userId)
    {
        SysUser user = new SysUser();
        user.setUserId(userId);
        user.setUserName("user" + userId);
        LoginUser loginUser = new LoginUser(userId, 1L, user, Collections.emptySet());
        UsernamePasswordAuthenticationToken authentication =
            new UsernamePasswordAuthenticationToken(loginUser, null, Collections.emptyList());
        SecurityContextHolder.getContext().setAuthentication(authentication);
    }

    private static class RecordingTaskMapper implements PolypDetectTaskMapper
    {
        private final Map<Long, PolypDetectTask> tasks = new HashMap<>();
        private PolypDetectTask lastListQuery;
        private PolypDetectTask lastExportQuery;
        private Long[] deletedTaskIds;

        @Override
        public int insertPolypDetectTask(PolypDetectTask task)
        {
            return 1;
        }

        @Override
        public int updatePolypDetectTask(PolypDetectTask task)
        {
            return 1;
        }

        @Override
        public PolypDetectTask selectPolypDetectTaskByTaskId(Long taskId)
        {
            return tasks.get(taskId);
        }

        @Override
        public List<PolypDetectTask> selectPolypDetectTaskList(PolypDetectTask query)
        {
            lastListQuery = query;
            return new ArrayList<>();
        }

        @Override
        public int logicDeletePolypDetectTaskByTaskIds(Long[] taskIds, Date updateTime)
        {
            deletedTaskIds = taskIds;
            return taskIds.length;
        }

        @Override
        public List<Map<String, Object>> selectPolypTaskExportList(PolypDetectTask query)
        {
            lastExportQuery = query;
            return new ArrayList<>();
        }

        @Override
        public Map<String, Object> selectDashboardOverview(Long userId)
        {
            return new HashMap<>();
        }

        @Override
        public List<Map<String, Object>> selectDashboardTrend(Long userId)
        {
            return new ArrayList<>();
        }

        @Override
        public List<Map<String, Object>> selectDashboardMediaDistribution(Long userId)
        {
            return new ArrayList<>();
        }

        @Override
        public List<Map<String, Object>> selectDashboardStatusDistribution(Long userId)
        {
            return new ArrayList<>();
        }

        @Override
        public List<Map<String, Object>> selectDashboardRecentTasks(Long userId, Integer limit)
        {
            return new ArrayList<>();
        }
    }

    private static class EmptyFileAssetService implements IFileAssetService
    {
        @Override
        public FileAsset uploadSourceFile(MultipartFile file)
        {
            return null;
        }

        @Override
        public FileAsset selectFileAssetByFileId(Long fileId)
        {
            return null;
        }

        @Override
        public String resolvePlayableVideoUrl(FileAsset fileAsset)
        {
            return "";
        }
    }

    private static class EmptyPolypModelService implements IPolypModelService
    {
        @Override
        public PolypModel selectCurrentPolypModel()
        {
            return null;
        }

        @Override
        public PolypModel selectPolypModelByModelId(Long modelId)
        {
            return null;
        }
    }
}
