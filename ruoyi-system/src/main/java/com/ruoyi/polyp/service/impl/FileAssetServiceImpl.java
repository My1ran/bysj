package com.ruoyi.polyp.service.impl;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;
import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.polyp.domain.FileAsset;
import com.ruoyi.polyp.mapper.FileAssetMapper;
import com.ruoyi.polyp.service.IFileAssetService;
import com.ruoyi.polyp.util.PolypFileTypeUtils;

@Service
public class FileAssetServiceImpl implements IFileAssetService
{
    private static final Logger log = LoggerFactory.getLogger(FileAssetServiceImpl.class);

    private final FileAssetMapper fileAssetMapper;

    @Value("${polyp.storage.source-dir:polyp/source}")
    private String sourceDir;

    @Value("${polyp.ffmpeg.enabled:true}")
    private boolean ffmpegEnabled;

    @Value("${polyp.ffmpeg.path:ffmpeg}")
    private String ffmpegPath;

    @Value("${polyp.ffmpeg.timeout-seconds:300}")
    private long ffmpegTimeoutSeconds;

    @Value("${polyp.ffmpeg.output-suffix:_web}")
    private String ffmpegOutputSuffix;

    public FileAssetServiceImpl(FileAssetMapper fileAssetMapper)
    {
        this.fileAssetMapper = fileAssetMapper;
    }

    @Override
    public FileAsset uploadSourceFile(MultipartFile file)
    {
        try
        {
            String baseDir = RuoYiConfig.getUploadPath() + File.separator + sourceDir;
            String fileUrl = FileUploadUtils.upload(baseDir, file).replace("\\", "/");
            String relativePath = fileUrl.substring(Constants.RESOURCE_PREFIX.length() + 1);
            String storePath = RuoYiConfig.getProfile() + File.separator + relativePath.replace("/", File.separator);
            String ext = PolypFileTypeUtils.getExtension(file);
            String fileType = PolypFileTypeUtils.resolveFileTypeByExt(ext);
            String bizType = PolypFileTypeUtils.TYPE_VIDEO.equals(fileType) ? "SOURCE_VIDEO" : "SOURCE_IMAGE";

            FileAsset asset = new FileAsset();
            asset.setBizType(bizType);
            asset.setOriginName(file.getOriginalFilename());
            asset.setExtName(ext);
            asset.setMimeType(file.getContentType());
            asset.setSizeBytes(file.getSize());
            asset.setStorePath(storePath);
            asset.setFileUrl(fileUrl);
            asset.setCreateTime(DateUtils.getNowDate());
            fileAssetMapper.insertFileAsset(asset);

            if (PolypFileTypeUtils.TYPE_VIDEO.equals(fileType))
            {
                transcodeVideoForWeb(asset);
            }
            return asset;
        }
        catch (IOException e)
        {
            throw new ServiceException("File upload failed: " + e.getMessage());
        }
    }

    @Override
    public FileAsset selectFileAssetByFileId(Long fileId)
    {
        return fileAssetMapper.selectFileAssetByFileId(fileId);
    }

    @Override
    public String resolvePlayableVideoUrl(FileAsset fileAsset)
    {
        if (fileAsset == null || !PolypFileTypeUtils.isVideoExt(fileAsset.getExtName()))
        {
            return "";
        }
        File sourceFile = new File(fileAsset.getStorePath());
        File webFile = buildWebVideoFile(sourceFile);
        if (!webFile.exists() || !webFile.isFile())
        {
            return "";
        }
        return buildSiblingFileUrl(fileAsset.getFileUrl(), webFile.getName());
    }

    private void transcodeVideoForWeb(FileAsset asset)
    {
        if (!ffmpegEnabled)
        {
            return;
        }
        File sourceFile = new File(asset.getStorePath());
        if (!sourceFile.exists() || !sourceFile.isFile())
        {
            log.warn("skip video transcode, source file not found: {}", sourceFile.getAbsolutePath());
            return;
        }
        File outputFile = buildWebVideoFile(sourceFile);
        if (outputFile.exists() && outputFile.isFile())
        {
            return;
        }

        List<String> command = new ArrayList<>();
        command.add(StringUtils.isEmpty(ffmpegPath) ? "ffmpeg" : ffmpegPath);
        command.add("-loglevel");
        command.add("error");
        command.add("-y");
        command.add("-i");
        command.add(sourceFile.getAbsolutePath());
        command.add("-c:v");
        command.add("libx264");
        command.add("-pix_fmt");
        command.add("yuv420p");
        command.add("-movflags");
        command.add("+faststart");
        command.add("-an");
        command.add(outputFile.getAbsolutePath());

        ProcessBuilder builder = new ProcessBuilder(command);
        builder.redirectErrorStream(true);
        try
        {
            Process process = builder.start();
            boolean finished = process.waitFor(ffmpegTimeoutSeconds, TimeUnit.SECONDS);
            if (!finished)
            {
                process.destroyForcibly();
                log.error("ffmpeg transcode timeout, fileId={}, source={}", asset.getFileId(), sourceFile.getAbsolutePath());
                return;
            }
            String output = readProcessOutput(process);
            int exitCode = process.exitValue();
            if (exitCode != 0 || !outputFile.exists() || !outputFile.isFile())
            {
                log.error(
                    "ffmpeg transcode failed, exitCode={}, fileId={}, source={}, output={}, message={}",
                    exitCode,
                    asset.getFileId(),
                    sourceFile.getAbsolutePath(),
                    outputFile.getAbsolutePath(),
                    output);
                return;
            }
            log.info(
                "ffmpeg transcode success, fileId={}, source={}, web={}",
                asset.getFileId(),
                sourceFile.getAbsolutePath(),
                outputFile.getAbsolutePath());
        }
        catch (Exception e)
        {
            log.error(
                "ffmpeg transcode exception, fileId={}, source={}, message={}",
                asset.getFileId(),
                sourceFile.getAbsolutePath(),
                e.getMessage(),
                e);
        }
    }

    private File buildWebVideoFile(File sourceFile)
    {
        String sourceName = sourceFile.getName();
        String baseName = FilenameUtils.getBaseName(sourceName);
        String suffix = StringUtils.isEmpty(ffmpegOutputSuffix) ? "_web" : ffmpegOutputSuffix;
        if (!suffix.startsWith("_"))
        {
            suffix = "_" + suffix;
        }
        return new File(sourceFile.getParentFile(), baseName + suffix + ".mp4");
    }

    private String buildSiblingFileUrl(String sourceUrl, String outputFileName)
    {
        if (StringUtils.isEmpty(sourceUrl))
        {
            return "";
        }
        String normalized = sourceUrl.replace("\\", "/");
        int idx = normalized.lastIndexOf('/');
        if (idx < 0)
        {
            return "/" + outputFileName;
        }
        return normalized.substring(0, idx + 1) + outputFileName;
    }

    private String readProcessOutput(Process process) throws IOException
    {
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream(), StandardCharsets.UTF_8)))
        {
            String line;
            int lines = 0;
            while ((line = reader.readLine()) != null)
            {
                if (lines < 120)
                {
                    sb.append(line).append(System.lineSeparator());
                }
                lines++;
            }
        }
        return sb.toString();
    }
}
