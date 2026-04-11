package com.ruoyi.polyp.service.impl;

import java.io.File;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Executor;
import javax.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.uuid.IdUtils;
import com.ruoyi.polyp.domain.FileAsset;
import com.ruoyi.polyp.domain.PolypDetectTask;
import com.ruoyi.polyp.domain.PolypModel;
import com.ruoyi.polyp.domain.PolypTaskStatus;
import com.ruoyi.polyp.domain.dto.PolypTaskCreateRequest;
import com.ruoyi.polyp.domain.vo.PolypTaskExportVO;
import com.ruoyi.polyp.inference.InferBox;
import com.ruoyi.polyp.inference.InferResponse;
import com.ruoyi.polyp.inference.PolypInferenceClient;
import com.ruoyi.polyp.mapper.PolypDetectTaskMapper;
import com.ruoyi.polyp.service.IFileAssetService;
import com.ruoyi.polyp.service.IPolypDetectTaskService;
import com.ruoyi.polyp.service.IPolypModelService;
import com.ruoyi.polyp.util.PolypFileTypeUtils;
import com.ruoyi.system.domain.HisDetectionResult;
import com.ruoyi.system.domain.HisPolypDetail;
import com.ruoyi.system.service.IHisDetectionResultService;
import com.ruoyi.system.service.IHisPolypDetailService;

@Service
public class PolypDetectTaskServiceImpl implements IPolypDetectTaskService
{
    private static final Logger log = LoggerFactory.getLogger(PolypDetectTaskServiceImpl.class);

    @Resource(name = "polypTaskExecutor")
    private Executor polypTaskExecutor;

    private final PolypDetectTaskMapper polypDetectTaskMapper;
    private final IFileAssetService fileAssetService;
    private final IPolypModelService polypModelService;
    private final PolypInferenceClient polypInferenceClient;
    private final IHisDetectionResultService hisDetectionResultService;
    private final IHisPolypDetailService hisPolypDetailService;
    private final ObjectMapper objectMapper = new ObjectMapper();

    public PolypDetectTaskServiceImpl(
        PolypDetectTaskMapper polypDetectTaskMapper,
        IFileAssetService fileAssetService,
        IPolypModelService polypModelService,
        PolypInferenceClient polypInferenceClient,
        IHisDetectionResultService hisDetectionResultService,
        IHisPolypDetailService hisPolypDetailService)
    {
        this.polypDetectTaskMapper = polypDetectTaskMapper;
        this.fileAssetService = fileAssetService;
        this.polypModelService = polypModelService;
        this.polypInferenceClient = polypInferenceClient;
        this.hisDetectionResultService = hisDetectionResultService;
        this.hisPolypDetailService = hisPolypDetailService;
    }

    @Override
    public PolypDetectTask createTask(PolypTaskCreateRequest request)
    {
        if (request == null || request.getSourceFileId() == null)
        {
            throw new ServiceException("sourceFileId cannot be empty");
        }

        FileAsset sourceFile = fileAssetService.selectFileAssetByFileId(request.getSourceFileId());
        if (sourceFile == null)
        {
            throw new ServiceException("source file does not exist");
        }

        String ext = StringUtils.isNotEmpty(sourceFile.getExtName())
            ? sourceFile.getExtName()
            : resolveExtension(sourceFile);
        String fileType = PolypFileTypeUtils.resolveFileTypeByExt(ext);
        if (StringUtils.isEmpty(fileType))
        {
            throw new ServiceException("unsupported source file type");
        }

        File sourcePhysicalFile = new File(sourceFile.getStorePath());
        if (!sourcePhysicalFile.exists() || !sourcePhysicalFile.isFile())
        {
            throw new ServiceException("source file does not exist on server: " + sourceFile.getStorePath());
        }

        PolypModel model = request.getModelId() == null
            ? polypModelService.selectCurrentPolypModel()
            : polypModelService.selectPolypModelByModelId(request.getModelId());
        if (model == null)
        {
            throw new ServiceException("polyp model does not exist");
        }

        PolypDetectTask task = new PolypDetectTask();
        task.setTaskNo(generateTaskNo());
        task.setPatientId(request.getPatientId());
        task.setSourceFileId(request.getSourceFileId());
        task.setModelId(model.getModelId());
        task.setConfThreshold(request.getConfThreshold() == null ? model.getConfThreshold() : request.getConfThreshold());
        task.setStatus(PolypTaskStatus.PENDING);
        task.setCreateTime(DateUtils.getNowDate());
        polypDetectTaskMapper.insertPolypDetectTask(task);
        final Long taskId = task.getTaskId();
        polypTaskExecutor.execute(() -> executeTaskAsync(taskId));
        return polypDetectTaskMapper.selectPolypDetectTaskByTaskId(taskId);
    }

    @Override
    public Map<String, Object> getTaskDetail(Long taskId)
    {
        PolypDetectTask task = polypDetectTaskMapper.selectPolypDetectTaskByTaskId(taskId);
        if (task == null)
        {
            throw new ServiceException("task does not exist");
        }

        Map<String, Object> result = new HashMap<>();
        FileAsset sourceFile = fileAssetService.selectFileAssetByFileId(task.getSourceFileId());
        String sourceFileUrl = normalizePublicMediaUrl(sourceFile);
        if (sourceFile != null)
        {
            sourceFile.setFileUrl(sourceFileUrl);
        }

        result.put("task", task);
        result.put("sourceFile", sourceFile);
        result.put("model", polypModelService.selectPolypModelByModelId(task.getModelId()));
        String fileType = sourceFile == null ? "" : PolypFileTypeUtils.resolveFileTypeByExt(resolveExtension(sourceFile));
        Map<String, Object> inferenceSummary = parseInferenceSummary(task.getRemark());
        String resultImageUrl = normalizePublicMediaUrl(stringValue(inferenceSummary.get("resultImageUrl")));
        String resultVideoUrl = normalizePublicMediaUrl(stringValue(inferenceSummary.get("resultVideoUrl")));
        String resultFramesUrl = normalizePublicMediaUrl(stringValue(inferenceSummary.get("resultFramesUrl")));
        Long frameCount = longValue(inferenceSummary.get("frameCount"));
        Long detectedFrameCount = longValue(inferenceSummary.get("detectedFrameCount"));
        Long boxCount = longValue(inferenceSummary.get("boxCount"));
        BigDecimal maxConfidence = decimalValue(inferenceSummary.get("maxConfidence"));
        BigDecimal fps = decimalValue(inferenceSummary.get("fps"));
        if (StringUtils.isEmpty(resultVideoUrl) && PolypFileTypeUtils.TYPE_VIDEO.equals(fileType))
        {
            resultVideoUrl = normalizePublicMediaUrl(fileAssetService.resolvePlayableVideoUrl(sourceFile));
        }
        result.put("fileType", fileType);
        result.put("mediaType", fileType);
        result.put("sourceFileUrl", sourceFileUrl);
        result.put("resultImageUrl", resultImageUrl);
        result.put("resultVideoUrl", resultVideoUrl);
        result.put("resultFramesUrl", resultFramesUrl);
        result.put("frameCount", frameCount == null ? 0L : frameCount);
        result.put("detectedFrameCount", detectedFrameCount == null ? 0L : detectedFrameCount);
        result.put("boxCount", boxCount == null ? 0L : boxCount);
        result.put("maxConfidence", maxConfidence == null ? BigDecimal.ZERO : maxConfidence);
        result.put("fps", fps == null ? BigDecimal.ZERO : fps);
        result.put("inferenceSummary", inferenceSummary);
        Object framesObj = inferenceSummary.get("frames");
        result.put("frames", framesObj instanceof List ? framesObj : Collections.emptyList());

        if (task.getResultId() != null)
        {
            HisDetectionResult detectionResult = hisDetectionResultService.selectHisDetectionResultByResultId(task.getResultId());
            List<HisPolypDetail> details = hisPolypDetailService.selectHisPolypDetailByResultId(task.getResultId());
            result.put("detectionResult", detectionResult);
            result.put("boxes", details);
            result.put("polypCount", details == null ? 0 : details.size());
            if ((boxCount == null || boxCount <= 0) && details != null)
            {
                result.put("boxCount", (long) details.size());
            }
            if ((maxConfidence == null || maxConfidence.compareTo(BigDecimal.ZERO) <= 0)
                && detectionResult != null && detectionResult.getAvgConfidence() != null)
            {
                result.put("maxConfidence", detectionResult.getAvgConfidence());
            }
        }
        else
        {
            result.put("detectionResult", null);
            result.put("boxes", new ArrayList<>());
            result.put("polypCount", 0);
        }
        return result;
    }

    @Override
    public List<PolypDetectTask> selectPolypDetectTaskList(PolypDetectTask query)
    {
        return polypDetectTaskMapper.selectPolypDetectTaskList(query);
    }

    @Override
    public int deleteTasks(Long[] taskIds)
    {
        if (taskIds == null || taskIds.length == 0)
        {
            return 0;
        }
        return polypDetectTaskMapper.logicDeletePolypDetectTaskByTaskIds(taskIds, DateUtils.getNowDate());
    }

    @Override
    public List<PolypTaskExportVO> selectTaskExportList(PolypDetectTask query)
    {
        List<Map<String, Object>> rows = polypDetectTaskMapper.selectPolypTaskExportList(query);
        List<PolypTaskExportVO> result = new ArrayList<>();
        if (rows == null)
        {
            return result;
        }
        for (Map<String, Object> row : rows)
        {
            PolypTaskExportVO item = new PolypTaskExportVO();
            item.setTaskId(longValue(row.get("taskId")));
            item.setTaskNo(stringValue(row.get("taskNo")));
            item.setMediaType(stringValue(row.get("mediaType")));
            item.setStatus(stringValue(row.get("status")));
            item.setInferenceMs(longValue(row.get("inferenceMs")));
            item.setPolypCount(intValue(row.get("polypCount")));
            item.setCreateTime(dateValue(row.get("createTime")));

            Map<String, Object> inferenceSummary = parseInferenceSummary(stringValue(row.get("remark")));
            item.setResultImageUrl(normalizePublicMediaUrl(stringValue(inferenceSummary.get("resultImageUrl"))));
            item.setResultVideoUrl(normalizePublicMediaUrl(stringValue(inferenceSummary.get("resultVideoUrl"))));
            result.add(item);
        }
        return result;
    }

    private void executeTaskAsync(Long taskId)
    {
        PolypDetectTask task = polypDetectTaskMapper.selectPolypDetectTaskByTaskId(taskId);
        if (task == null)
        {
            log.warn("skip async detect, task not found: {}", taskId);
            return;
        }

        try
        {
            FileAsset sourceFile = fileAssetService.selectFileAssetByFileId(task.getSourceFileId());
            if (sourceFile == null)
            {
                throw new ServiceException("source file does not exist");
            }

            String ext = StringUtils.isNotEmpty(sourceFile.getExtName())
                ? sourceFile.getExtName()
                : resolveExtension(sourceFile);
            String fileType = PolypFileTypeUtils.resolveFileTypeByExt(ext);
            if (StringUtils.isEmpty(fileType))
            {
                throw new ServiceException("unsupported source file type");
            }

            File sourcePhysicalFile = new File(sourceFile.getStorePath());
            if (!sourcePhysicalFile.exists() || !sourcePhysicalFile.isFile())
            {
                throw new ServiceException("source file does not exist on server: " + sourceFile.getStorePath());
            }

            PolypModel model = polypModelService.selectPolypModelByModelId(task.getModelId());
            if (model == null)
            {
                throw new ServiceException("polyp model does not exist");
            }

            task.setStatus(PolypTaskStatus.RUNNING);
            task.setStartTime(new Date());
            task.setErrorMsg(null);
            task.setUpdateTime(DateUtils.getNowDate());
            polypDetectTaskMapper.updatePolypDetectTask(task);

            InferResponse inferResponse = polypInferenceClient.infer(sourcePhysicalFile, fileType, model, task.getConfThreshold());
            Long resultId = saveLegacyResult(task, sourceFile, inferResponse, fileType);

            task.setStatus(PolypTaskStatus.SUCCESS);
            task.setResultId(resultId);
            task.setInferenceMs(inferResponse.getInferenceMs());
            task.setRemark(buildInferenceSummaryRemark(fileType, inferResponse, sourceFile));
            task.setFinishTime(new Date());
            task.setUpdateTime(DateUtils.getNowDate());
            polypDetectTaskMapper.updatePolypDetectTask(task);
            log.info("polyp detect task finished, taskId={}, resultId={}", taskId, resultId);
        }
        catch (Exception e)
        {
            task.setStatus(PolypTaskStatus.FAILED);
            task.setFinishTime(new Date());
            task.setErrorMsg(StringUtils.substring(e.getMessage(), 0, 500));
            task.setUpdateTime(DateUtils.getNowDate());
            polypDetectTaskMapper.updatePolypDetectTask(task);
            log.error("polyp detect task failed, taskId={}, error={}", taskId, e.getMessage(), e);
        }
    }

    private Long saveLegacyResult(PolypDetectTask task, FileAsset sourceFile, InferResponse inferResponse, String fileType)
    {
        List<InferBox> boxes = inferResponse.getBoxes() == null ? new ArrayList<>() : inferResponse.getBoxes();

        HisDetectionResult detectionResult = new HisDetectionResult();
        detectionResult.setPatiId(task.getPatientId());
        detectionResult.setDetectionType(PolypFileTypeUtils.TYPE_VIDEO.equals(fileType) ? "1" : "0");
        detectionResult.setSampleNumber(task.getTaskNo());
        detectionResult.setOriginalFile(sourceFile.getFileUrl());
        detectionResult.setPolypCount(boxes.size());
        detectionResult.setDetectionTime(new Date());
        detectionResult.setReportGenerated("0");

        if (!boxes.isEmpty())
        {
            BigDecimal sumConfidence = BigDecimal.ZERO;
            double minSize = Double.MAX_VALUE;
            double maxSize = 0D;
            for (InferBox box : boxes)
            {
                BigDecimal score = box.getScore() == null ? BigDecimal.ZERO : box.getScore();
                sumConfidence = sumConfidence.add(score);
                int width = (box.getX2() == null || box.getX1() == null) ? 0 : Math.max(0, box.getX2() - box.getX1());
                int height = (box.getY2() == null || box.getY1() == null) ? 0 : Math.max(0, box.getY2() - box.getY1());
                double size = Math.sqrt(width * width + height * height);
                minSize = Math.min(minSize, size);
                maxSize = Math.max(maxSize, size);
            }

            detectionResult.setAvgConfidence(sumConfidence.divide(BigDecimal.valueOf(boxes.size()), 2, RoundingMode.HALF_UP));
            detectionResult.setMaxSize(BigDecimal.valueOf(maxSize).setScale(2, RoundingMode.HALF_UP));
            detectionResult.setMinSize(BigDecimal.valueOf(minSize == Double.MAX_VALUE ? 0 : minSize).setScale(2, RoundingMode.HALF_UP));
        }
        else if (inferResponse.getMaxConfidence() != null)
        {
            detectionResult.setAvgConfidence(inferResponse.getMaxConfidence());
        }

        hisDetectionResultService.insertHisDetectionResult(detectionResult);

        for (int i = 0; i < boxes.size(); i++)
        {
            InferBox box = boxes.get(i);
            HisPolypDetail detail = new HisPolypDetail();
            detail.setResultId(detectionResult.getResultId());
            detail.setPolypIndex(i + 1);
            detail.setConfidence(box.getScore());
            int width = (box.getX2() == null || box.getX1() == null) ? 0 : Math.max(0, box.getX2() - box.getX1());
            int height = (box.getY2() == null || box.getY1() == null) ? 0 : Math.max(0, box.getY2() - box.getY1());
            detail.setSizeMm(BigDecimal.valueOf(Math.sqrt(width * width + height * height)).setScale(2, RoundingMode.HALF_UP));
            detail.setPosition(String.format("x1=%d,y1=%d,x2=%d,y2=%d", nvl(box.getX1()), nvl(box.getY1()), nvl(box.getX2()), nvl(box.getY2())));
            detail.setBboxX(nvl(box.getX1()));
            detail.setBboxY(nvl(box.getY1()));
            detail.setBboxWidth(width);
            detail.setBboxHeight(height);
            detail.setClassification(box.getClassName());
            hisPolypDetailService.insertHisPolypDetail(detail);
        }

        return detectionResult.getResultId();
    }

    private Map<String, Object> parseInferenceSummary(String remark)
    {
        if (StringUtils.isEmpty(remark))
        {
            return new HashMap<>();
        }
        try
        {
            return objectMapper.readValue(remark, Map.class);
        }
        catch (Exception e)
        {
            Map<String, Object> fallback = new HashMap<>();
            fallback.put("raw", remark);
            return fallback;
        }
    }

    private String buildInferenceSummaryRemark(String fileType, InferResponse inferResponse, FileAsset sourceFile)
    {
        Map<String, Object> summary = new HashMap<>();
        summary.put("fileType", fileType);
        summary.put("inferenceMs", inferResponse.getInferenceMs());
        summary.put("imageWidth", inferResponse.getImageWidth());
        summary.put("imageHeight", inferResponse.getImageHeight());
        summary.put("frameCount", inferResponse.getFrameCount());
        summary.put("detectedFrameCount", inferResponse.getDetectedFrameCount());
        summary.put("maxConfidence", inferResponse.getMaxConfidence());
        summary.put("fps", inferResponse.getFps());
        summary.put("resultImageUrl", normalizePublicMediaUrl(inferResponse.getResultImageUrl()));
        String resultVideoUrl = normalizePublicMediaUrl(inferResponse.getResultVideoUrl());
        if (StringUtils.isEmpty(resultVideoUrl) && PolypFileTypeUtils.TYPE_VIDEO.equals(fileType))
        {
            resultVideoUrl = normalizePublicMediaUrl(fileAssetService.resolvePlayableVideoUrl(sourceFile));
        }
        summary.put("resultVideoUrl", resultVideoUrl);
        summary.put("resultFramesUrl", normalizePublicMediaUrl(inferResponse.getResultFramesUrl()));
        summary.put("boxCount", inferResponse.getBoxes() == null ? 0 : inferResponse.getBoxes().size());
        summary.put("representativeBoxes", inferResponse.getBoxes());
        try
        {
            return objectMapper.writeValueAsString(summary);
        }
        catch (Exception e)
        {
            return summary.toString();
        }
    }

    private String resolveExtension(FileAsset sourceFile)
    {
        if (sourceFile == null)
        {
            return "";
        }
        if (StringUtils.isNotEmpty(sourceFile.getExtName()))
        {
            return sourceFile.getExtName();
        }
        if (StringUtils.isNotEmpty(sourceFile.getOriginName()))
        {
            return PolypFileTypeUtils.getExtension(sourceFile.getOriginName());
        }
        if (StringUtils.isNotEmpty(sourceFile.getFileUrl()))
        {
            return PolypFileTypeUtils.getExtension(sourceFile.getFileUrl());
        }
        return "";
    }

    private String normalizePublicMediaUrl(FileAsset sourceFile)
    {
        if (sourceFile == null)
        {
            return "";
        }
        String fileUrl = sourceFile.getFileUrl();
        if (StringUtils.isEmpty(fileUrl))
        {
            fileUrl = sourceFile.getStorePath();
        }
        return normalizePublicMediaUrl(fileUrl);
    }

    private String normalizePublicMediaUrl(String fileUrl)
    {
        if (StringUtils.isEmpty(fileUrl))
        {
            return "";
        }

        String normalized = fileUrl.replace("\\", "/").trim();
        if (normalized.startsWith("http://") || normalized.startsWith("https://"))
        {
            return normalized;
        }
        if (normalized.startsWith("/dev-api/profile/"))
        {
            normalized = normalized.substring("/dev-api".length());
        }
        else if (normalized.startsWith("/prod-api/profile/"))
        {
            normalized = normalized.substring("/prod-api".length());
        }

        int profileIndex = normalized.indexOf("/profile/");
        if (profileIndex >= 0)
        {
            return normalized.substring(profileIndex);
        }
        if (normalized.startsWith("profile/"))
        {
            return "/" + normalized;
        }

        int uploadIndex = normalized.indexOf("/upload/");
        if (uploadIndex >= 0)
        {
            return "/profile" + normalized.substring(uploadIndex);
        }
        return normalized.startsWith("/") ? normalized : "/" + normalized;
    }

    private String stringValue(Object value)
    {
        return value == null ? "" : String.valueOf(value);
    }

    private int nvl(Integer value)
    {
        return value == null ? 0 : value;
    }

    private Long longValue(Object value)
    {
        if (value == null || StringUtils.isEmpty(String.valueOf(value)))
        {
            return null;
        }
        try
        {
            return Long.valueOf(String.valueOf(value));
        }
        catch (Exception e)
        {
            return null;
        }
    }

    private Integer intValue(Object value)
    {
        if (value == null || StringUtils.isEmpty(String.valueOf(value)))
        {
            return 0;
        }
        try
        {
            return Integer.valueOf(String.valueOf(value));
        }
        catch (Exception e)
        {
            return 0;
        }
    }

    private BigDecimal decimalValue(Object value)
    {
        if (value == null || StringUtils.isEmpty(String.valueOf(value)))
        {
            return null;
        }
        try
        {
            return new BigDecimal(String.valueOf(value)).setScale(6, RoundingMode.HALF_UP);
        }
        catch (Exception e)
        {
            return null;
        }
    }

    private Date dateValue(Object value)
    {
        if (value == null)
        {
            return null;
        }
        if (value instanceof Date)
        {
            return (Date) value;
        }
        return DateUtils.parseDate(value);
    }

    private String generateTaskNo()
    {
        String suffix = IdUtils.fastUUID().replace("-", "").substring(0, 6).toUpperCase();
        return "PDT" + DateUtils.dateTimeNow("yyyyMMddHHmmss") + suffix;
    }
}
