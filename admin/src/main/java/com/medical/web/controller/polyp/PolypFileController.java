package com.medical.web.controller.polyp;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import com.medical.common.annotation.Log;
import com.medical.common.core.domain.AjaxResult;
import com.medical.common.enums.BusinessType;
import com.medical.polyp.domain.FileAsset;
import com.medical.polyp.service.IFileAssetService;
import com.medical.polyp.util.PolypFileTypeUtils;

@RestController
@RequestMapping("/system/polyp/file")
public class PolypFileController
{
    private final IFileAssetService fileAssetService;

    public PolypFileController(IFileAssetService fileAssetService)
    {
        this.fileAssetService = fileAssetService;
    }

    @Log(title = "检查资料上传", businessType = BusinessType.INSERT, isSaveRequestData = false, isSaveResponseData = false)
    @PreAuthorize("@ss.hasPermi('system:polyp:add')")
    @PostMapping("/upload")
    public AjaxResult upload(@RequestParam("file") MultipartFile file)
    {
        if (file == null || file.isEmpty())
        {
            return AjaxResult.error("上传文件不能为空");
        }

        String ext = PolypFileTypeUtils.getExtension(file);
        if (!PolypFileTypeUtils.isSupportedExt(ext))
        {
            return AjaxResult.error("仅支持 " + PolypFileTypeUtils.allowListText() + " 格式");
        }

        FileAsset asset = fileAssetService.uploadSourceFile(file);
        return AjaxResult.success(asset);
    }
}
