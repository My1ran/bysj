package com.ruoyi.polyp.util;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Locale;
import java.util.Set;
import org.apache.commons.io.FilenameUtils;
import org.springframework.web.multipart.MultipartFile;

public final class PolypFileTypeUtils
{
    public static final String TYPE_IMAGE = "image";
    public static final String TYPE_VIDEO = "video";

    private static final Set<String> IMAGE_EXTS = new HashSet<>(Arrays.asList("jpg", "jpeg", "png", "bmp"));
    private static final Set<String> VIDEO_EXTS = new HashSet<>(Arrays.asList("mp4", "avi", "mov", "mkv"));

    private PolypFileTypeUtils()
    {
    }

    public static String getExtension(MultipartFile file)
    {
        if (file == null)
        {
            return "";
        }
        return normalizeExt(FilenameUtils.getExtension(file.getOriginalFilename()));
    }

    public static String getExtension(String filenameOrPath)
    {
        return normalizeExt(FilenameUtils.getExtension(filenameOrPath));
    }

    public static boolean isSupportedExt(String ext)
    {
        String normalized = normalizeExt(ext);
        return IMAGE_EXTS.contains(normalized) || VIDEO_EXTS.contains(normalized);
    }

    public static boolean isImageExt(String ext)
    {
        return IMAGE_EXTS.contains(normalizeExt(ext));
    }

    public static boolean isVideoExt(String ext)
    {
        return VIDEO_EXTS.contains(normalizeExt(ext));
    }

    public static String resolveFileTypeByExt(String ext)
    {
        String normalized = normalizeExt(ext);
        if (VIDEO_EXTS.contains(normalized))
        {
            return TYPE_VIDEO;
        }
        if (IMAGE_EXTS.contains(normalized))
        {
            return TYPE_IMAGE;
        }
        return "";
    }

    public static String allowListText()
    {
        return "jpg/jpeg/png/bmp/mp4 (optional: avi/mov/mkv)";
    }

    private static String normalizeExt(String ext)
    {
        return ext == null ? "" : ext.trim().toLowerCase(Locale.ROOT);
    }
}
