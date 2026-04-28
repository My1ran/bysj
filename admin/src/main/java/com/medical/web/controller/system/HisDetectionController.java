package com.medical.web.controller.system;

import java.io.File;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import com.medical.common.annotation.Log;
import com.medical.common.core.controller.BaseController;
import com.medical.common.core.domain.AjaxResult;
import com.medical.common.enums.BusinessType;
import com.medical.system.domain.HisDetectionResult;
import com.medical.system.domain.HisPolypDetail;
import com.medical.system.domain.HisPatient;
import com.medical.system.service.IHisDetectionResultService;
import com.medical.system.service.IHisPolypDetailService;
import com.medical.system.service.IHisPatientService;
import com.medical.system.yolo.YoloResult;
import com.medical.system.yolo.YoloV5ServiceImpl;
import com.medical.system.yolo.BoundingBox;
import com.medical.common.utils.DateUtils;
import com.medical.common.utils.StringUtils;
import com.medical.common.utils.file.FileUploadUtils;
import com.medical.common.utils.poi.ExcelUtil;
import com.medical.common.core.page.TableDataInfo;
import com.medical.common.config.MedicalConfig;

/**
 * 检测结果 Controller
 *
 * @author lijie
 * @date 2026-03-19
 */
@RestController
@Deprecated
@RequestMapping("/system/detection")
public class HisDetectionController extends BaseController
{
    @Autowired
    private IHisDetectionResultService hisDetectionResultService;

    @Autowired
    private IHisPolypDetailService hisPolypDetailService;

    @Autowired
    private IHisPatientService hisPatientService;

    @Autowired
    private YoloV5ServiceImpl yoloV5Service;

    /**
     * 查询检测结果列表
     */
    @PreAuthorize("@ss.hasPermi('system:detection:list')")
    @GetMapping("/list")
    public TableDataInfo list(HisDetectionResult hisDetectionResult)
    {
        startPage();
        List<HisDetectionResult> list = hisDetectionResultService.selectHisDetectionResultList(hisDetectionResult);
        return getDataTable(list);
    }

    /**
     * 导出检测结果列表
     */
    @PreAuthorize("@ss.hasPermi('system:detection:export')")
    @Log(title = "检测结果", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, HisDetectionResult hisDetectionResult)
    {
        List<HisDetectionResult> list = hisDetectionResultService.selectHisDetectionResultList(hisDetectionResult);
        ExcelUtil<HisDetectionResult> util = new ExcelUtil<HisDetectionResult>(HisDetectionResult.class);
        util.exportExcel(response, list, "检测结果");
    }

    /**
     * 获取检测结果详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:detection:query')")
    @GetMapping(value = "/{resultId}")
    public AjaxResult getInfo(@PathVariable("resultId") Long resultId)
    {
        HisDetectionResult result = hisDetectionResultService.selectHisDetectionResultByResultId(resultId);
        List<HisPolypDetail> polypDetails = hisPolypDetailService.selectHisPolypDetailByResultId(resultId);
        result.getParams().put("polypDetails", polypDetails);
        return AjaxResult.success(result);
    }

    /**
     * 上传图片并检测
     */
    @PreAuthorize("@ss.hasPermi('system:detection:upload')")
    @Log(title = "图片检测", businessType = BusinessType.INSERT)
    @PostMapping("/upload")
    public AjaxResult uploadDetect(@RequestParam("file") MultipartFile file,
                                    @RequestParam(value = "patiId", required = false) Long patiId) throws Exception
    {
        if (file.isEmpty()) {
            return AjaxResult.error("上传文件为空");
        }

        // 验证文件格式
        String extension = FileUploadUtils.getExtension(file);
        if (!StringUtils.equalsAnyIgnoreCase(extension, "jpg", "jpeg", "png", "bmp")) {
            return AjaxResult.error("只支持 JPG、PNG、BMP 格式的图片");
        }

        // 验证文件大小 (最大 10MB)
        if (file.getSize() > 10 * 1024 * 1024) {
            return AjaxResult.error("文件大小不能超过 10MB");
        }

        // 上传文件
        String filePath = FileUploadUtils.upload(MedicalConfig.getUploadPath() + "/detection/", file);
        String fileName = filePath.substring(filePath.lastIndexOf("/") + 1);

        // 执行 YOLOv5 检测
        String fullPath = MedicalConfig.getUploadPath() + "/detection/" + fileName;
        YoloResult yoloResult = yoloV5Service.detect(fullPath);

        // 保存检测结果
        HisDetectionResult detectionResult = new HisDetectionResult();
        detectionResult.setPatiId(patiId);
        detectionResult.setDetectionType("0"); // 图片检测
        detectionResult.setSampleNumber(generateSampleNumber());
        detectionResult.setOriginalFile("/detection/" + fileName);
        detectionResult.setPolypCount(yoloResult.getDetections().size());
        detectionResult.setDetectionTime(new Date());
        detectionResult.setReportGenerated("0");

        // 计算统计数据
        if (!yoloResult.getDetections().isEmpty()) {
            List<BoundingBox> detections = yoloResult.getDetections();

            // 计算平均置信度
            BigDecimal sumConfidence = detections.stream()
                .map(BoundingBox::getConfidence)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
            BigDecimal avgConfidence = sumConfidence.divide(
                new BigDecimal(detections.size()), 2, RoundingMode.HALF_UP);
            detectionResult.setAvgConfidence(avgConfidence);

            // 计算最大/最小尺寸 (基于边界框对角线长度)
            List<Double> sizes = new ArrayList<>();
            for (BoundingBox box : detections) {
                double size = Math.sqrt(box.getWidth() * box.getWidth() + box.getHeight() * box.getHeight());
                sizes.add(size);
            }
            detectionResult.setMaxSize(new BigDecimal(sizes.stream().mapToDouble(Double::doubleValue).max().orElse(0)).setScale(2, RoundingMode.HALF_UP));
            detectionResult.setMinSize(new BigDecimal(sizes.stream().mapToDouble(Double::doubleValue).min().orElse(0)).setScale(2, RoundingMode.HALF_UP));
        }

        // 保存检测结果
        hisDetectionResultService.insertHisDetectionResult(detectionResult);

        // 保存息肉详情
        for (int i = 0; i < yoloResult.getDetections().size(); i++) {
            BoundingBox box = yoloResult.getDetections().get(i);
            HisPolypDetail polypDetail = new HisPolypDetail();
            polypDetail.setResultId(detectionResult.getResultId());
            polypDetail.setPolypIndex(i + 1);
            polypDetail.setConfidence(box.getConfidence());
            polypDetail.setPosition("未知"); // 可以根据实际位置计算
            polypDetail.setBboxX(box.getX());
            polypDetail.setBboxY(box.getY());
            polypDetail.setBboxWidth(box.getWidth());
            polypDetail.setBboxHeight(box.getHeight());
            polypDetail.setClassification(box.getClassName());
            hisPolypDetailService.insertHisPolypDetail(polypDetail);
        }

        // 返回结果
        AjaxResult result = AjaxResult.success();
        result.put("resultId", detectionResult.getResultId());
        result.put("polypCount", detectionResult.getPolypCount());
        result.put("detections", yoloResult.getDetections());
        result.put("originalFile", "/detection/" + fileName);

        return result;
    }

    /**
     * 删除检测结果
     *
     */
    @PreAuthorize("@ss.hasPermi('system:detection:remove')")
    @Log(title = "检测结果", businessType = BusinessType.DELETE)
    @DeleteMapping("/{resultIds}")
    public AjaxResult remove(@PathVariable Long[] resultIds)
    {
        // 同时删除关联的息肉详情
        for (Long resultId : resultIds) {
            hisPolypDetailService.deleteHisPolypDetailByResultId(resultId);
        }
        return toAjax(hisDetectionResultService.deleteHisDetectionResultByResultIds(resultIds));
    }

    /**
     * 生成样本编号
     */
    private String generateSampleNumber() {
        return "S" + DateUtils.dateTimeNow("yyyyMMddHHmmss");
    }
}
