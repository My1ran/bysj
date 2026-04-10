package com.ruoyi.polyp.inference;

import java.io.File;
import java.math.BigDecimal;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.ResourceAccessException;
import org.springframework.web.client.RestTemplate;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.polyp.domain.PolypModel;

@Component
public class PolypInferenceClient
{
    private static final Logger log = LoggerFactory.getLogger(PolypInferenceClient.class);

    @Value("${polyp.inference.base-url:}")
    private String baseUrl;

    @Value("${polyp.inference.timeout:10000}")
    private int timeout;

    @Value("${polyp.inference.video-timeout:600000}")
    private int videoTimeout;

    @Value("${polyp.inference.send-model-path:false}")
    private boolean sendModelPath;

    @Value("${polyp.inference.video-frame-stride:1}")
    private int videoFrameStride;

    @Value("${polyp.inference.video-max-frames:0}")
    private int videoMaxFrames;

    @Value("${polyp.inference.video-conf-thres:0.25}")
    private BigDecimal videoConfThres;

    @Value("${polyp.inference.video-iou-thres:0.45}")
    private BigDecimal videoIouThres;

    @Value("${polyp.inference.video-imgsz:640}")
    private String videoImgsz;

    @Value("${polyp.inference.video-max-det:1000}")
    private int videoMaxDet;

    @Value("${polyp.inference.video-agnostic-nms:false}")
    private boolean videoAgnosticNms;

    @Value("${polyp.inference.video-augment:false}")
    private boolean videoAugment;

    @Value("${polyp.inference.include-frames:false}")
    private boolean includeFrames;

    @Value("${polyp.inference.generate-result-video:true}")
    private boolean generateResultVideo;

    public InferResponse infer(File sourceFile, String fileType, PolypModel model, BigDecimal confThreshold)
    {
        if (sourceFile == null || !sourceFile.exists() || !sourceFile.isFile())
        {
            throw new ServiceException("Source file does not exist: " + (sourceFile == null ? "null" : sourceFile.getAbsolutePath()));
        }
        if (StringUtils.isEmpty(baseUrl))
        {
            throw new ServiceException("polyp.inference.base-url is not configured");
        }

        String inferUrl = normalizeBaseUrl(baseUrl) + "/infer";

        try
        {
            RestTemplate restTemplate = createRestTemplate("video".equalsIgnoreCase(fileType));
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.MULTIPART_FORM_DATA);

            MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
            body.add("file", new FileSystemResource(sourceFile));
            body.add("file_type", StringUtils.isEmpty(fileType) ? "image" : fileType);
            if (model != null && model.getModelId() != null)
            {
                body.add("model_id", String.valueOf(model.getModelId()));
            }
            if (sendModelPath && model != null && StringUtils.isNotEmpty(model.getModelPath()))
            {
                body.add("model_path", model.getModelPath());
            }
            if ("video".equalsIgnoreCase(fileType))
            {
                BigDecimal effectiveVideoConf = videoConfThres != null ? videoConfThres : confThreshold;
                if (effectiveVideoConf != null)
                {
                    body.add("conf_threshold", effectiveVideoConf.toPlainString());
                }
                if (videoIouThres != null)
                {
                    body.add("iou_thres", videoIouThres.toPlainString());
                }
                if (StringUtils.isNotEmpty(videoImgsz))
                {
                    body.add("imgsz", videoImgsz);
                }
                body.add("max_det", String.valueOf(Math.max(videoMaxDet, 1)));
                body.add("frame_stride", String.valueOf(Math.max(videoFrameStride, 1)));
                body.add("vid_stride", String.valueOf(Math.max(videoFrameStride, 1)));
                body.add("max_frames", String.valueOf(Math.max(videoMaxFrames, 0)));
                body.add("agnostic_nms", String.valueOf(videoAgnosticNms));
                body.add("augment", String.valueOf(videoAugment));
                body.add("include_frames", String.valueOf(includeFrames));
                body.add("generate_result_video", String.valueOf(generateResultVideo));
            }
            else if (confThreshold != null)
            {
                body.add("conf_threshold", confThreshold.toPlainString());
            }

            HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);
            ResponseEntity<InferResponse> responseEntity = restTemplate.postForEntity(inferUrl, requestEntity, InferResponse.class);

            if (responseEntity.getStatusCode() != HttpStatus.OK)
            {
                log.error("Inference service http failed, status={}, url={}", responseEntity.getStatusCodeValue(), inferUrl);
                throw new ServiceException("Inference service HTTP error: " + responseEntity.getStatusCodeValue());
            }

            InferResponse response = responseEntity.getBody();
            if (response == null)
            {
                throw new ServiceException("Inference service returned empty response");
            }
            if (!Boolean.TRUE.equals(response.getSuccess()))
            {
                throw new ServiceException(StringUtils.isEmpty(response.getMessage()) ? "Inference service returned failure" : response.getMessage());
            }
            return response;
        }
        catch (ResourceAccessException e)
        {
            throw new ServiceException("Inference request timeout or unreachable: " + e.getMessage());
        }
        catch (ServiceException e)
        {
            throw e;
        }
        catch (Exception e)
        {
            throw new ServiceException("Inference service call failed: " + e.getMessage());
        }
    }

    private RestTemplate createRestTemplate()
    {
        return createRestTemplate(false);
    }

    private RestTemplate createRestTemplate(boolean videoInference)
    {
        SimpleClientHttpRequestFactory factory = new SimpleClientHttpRequestFactory();
        int effectiveTimeout = videoInference ? Math.max(videoTimeout, timeout) : timeout;
        factory.setConnectTimeout(effectiveTimeout);
        factory.setReadTimeout(effectiveTimeout);
        return new RestTemplate(factory);
    }

    private String normalizeBaseUrl(String rawBaseUrl)
    {
        String normalized = rawBaseUrl.trim();
        while (normalized.endsWith("/"))
        {
            normalized = normalized.substring(0, normalized.length() - 1);
        }
        return normalized;
    }
}
