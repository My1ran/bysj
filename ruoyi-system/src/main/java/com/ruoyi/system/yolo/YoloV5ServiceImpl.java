package com.ruoyi.system.yolo;

import org.springframework.stereotype.Service;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.JsonNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * YOLOv5 检测服务实现
 * 调用 Python 脚本进行息肉检测
 *
 * @author lijie
 * @date 2026-03-19
 */
@Service
public class YoloV5ServiceImpl {

    private static final Logger log = LoggerFactory.getLogger(YoloV5ServiceImpl.class);

    /**
     * YOLOv5 模型文件路径
     */
    private static final String MODEL_PATH = "M:/0NUIST/class/bysj/Medical-platform-master/ruoyi-system/src/main/resources/yolo/polyp.pt";

    /**
     * Python 检测脚本路径
     */
    private static final String DETECT_SCRIPT = "M:/0NUIST/class/bysj/Medical-platform-master/ruoyi-system/src/main/resources/yolo/detect.py";

    /**
     * Python 解释器路径 (根据实际情况修改)
     */
    private static final String PYTHON_PATH = "python";

    /**
     * 置信度阈值
     */
    private static final float CONF_THRESHOLD = 0.5f;

    /**
     * 执行 YOLOv5 检测
     *
     * @param imagePath 图片路径
     * @return 检测结果
     */
    public YoloResult detect(String imagePath) {
        log.info("开始检测图片：{}", imagePath);
        long startTime = System.currentTimeMillis();

        try {
            // 构建 Python 命令
            List<String> command = new ArrayList<>();
            command.add(PYTHON_PATH);
            command.add(DETECT_SCRIPT);
            command.add("--model");
            command.add(MODEL_PATH);
            command.add("--source");
            command.add(imagePath);
            command.add("--conf");
            command.add(String.valueOf(CONF_THRESHOLD));
            command.add("--output");
            command.add("json");

            // 执行命令
            ProcessBuilder processBuilder = new ProcessBuilder(command);
            processBuilder.redirectErrorStream(true);
            Process process = processBuilder.start();

            // 读取输出
            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            StringBuilder output = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                output.append(line);
            }

            // 等待进程结束
            int exitCode = process.waitFor();
            if (exitCode != 0) {
                log.error("Python 脚本执行失败，退出码：{}", exitCode);
                throw new RuntimeException("YOLOv5 检测失败");
            }

            // 解析 JSON 结果
            String jsonResult = output.toString();
            log.info("检测结果：{}", jsonResult);

            YoloResult result = parseJsonResult(jsonResult);
            result.setInferenceTime(System.currentTimeMillis() - startTime);

            log.info("检测完成，耗时：{}ms, 检测到{}个目标", result.getInferenceTime(),
                    result.getDetections() != null ? result.getDetections().size() : 0);

            return result;

        } catch (IOException e) {
            log.error("IO 异常", e);
            throw new RuntimeException("检测过程发生 IO 异常", e);
        } catch (InterruptedException e) {
            log.error("线程中断", e);
            Thread.currentThread().interrupt();
            throw new RuntimeException("检测过程被中断", e);
        }
    }

    /**
     * 解析 JSON 检测结果
     */
    private YoloResult parseJsonResult(String json) throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode rootNode = mapper.readTree(json);

        YoloResult result = new YoloResult();
        List<BoundingBox> detections = new ArrayList<>();

        JsonNode detectionsNode = rootNode.get("detections");
        if (detectionsNode != null && detectionsNode.isArray()) {
            for (JsonNode node : detectionsNode) {
                BoundingBox box = new BoundingBox();
                box.setClassName(node.get("class").asText());
                box.setConfidence(new BigDecimal(node.get("confidence").asText()));

                JsonNode bboxNode = node.get("bbox");
                if (bboxNode != null) {
                    box.setX(bboxNode.get("x").asInt());
                    box.setY(bboxNode.get("y").asInt());
                    box.setWidth(bboxNode.get("width").asInt());
                    box.setHeight(bboxNode.get("height").asInt());
                }

                detections.add(box);
            }
        }

        result.setDetections(detections);

        JsonNode imageNode = rootNode.get("image");
        if (imageNode != null) {
            result.setOriginalWidth(imageNode.get("width").asInt());
            result.setOriginalHeight(imageNode.get("height").asInt());
        }

        return result;
    }

    /**
     * 批量检测
     *
     * @param imagePaths 图片路径列表
     * @return 检测结果列表
     */
    public List<YoloResult> batchDetect(List<String> imagePaths) {
        List<YoloResult> results = new ArrayList<>();
        for (String path : imagePaths) {
            try {
                results.add(detect(path));
            } catch (Exception e) {
                log.error("检测失败：{}", path, e);
            }
        }
        return results;
    }
}
