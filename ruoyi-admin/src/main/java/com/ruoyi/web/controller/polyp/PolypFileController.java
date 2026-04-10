package com.ruoyi.web.controller.polyp;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.polyp.domain.FileAsset;
import com.ruoyi.polyp.service.IFileAssetService;
import com.ruoyi.polyp.util.PolypFileTypeUtils;

@RestController
@RequestMapping("/system/polyp/file")
public class PolypFileController
{
    private final IFileAssetService fileAssetService;

    public PolypFileController(IFileAssetService fileAssetService)
    {
        this.fileAssetService = fileAssetService;
    }

    @PreAuthorize("@ss.hasPermi('system:polyp:file:upload')")
    @PostMapping("/upload")
    public AjaxResult upload(@RequestParam("file") MultipartFile file)
    {
        if (file == null || file.isEmpty())
        {
            return AjaxResult.error("Upload file cannot be empty");
        }

        String ext = PolypFileTypeUtils.getExtension(file);
        if (!PolypFileTypeUtils.isSupportedExt(ext))
        {
            return AjaxResult.error("Only " + PolypFileTypeUtils.allowListText() + " is supported");
        }

        FileAsset asset = fileAssetService.uploadSourceFile(file);
        return AjaxResult.success(asset);
    }
}
