param(
    [string]$Root = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = "Stop"
$failures = New-Object System.Collections.Generic.List[string]

function Add-Failure([string]$message) {
    $failures.Add($message) | Out-Null
}

function Read-Utf8([string]$path) {
    return [System.IO.File]::ReadAllText((Join-Path $Root $path), [System.Text.Encoding]::UTF8)
}

function Assert-Contains([string]$content, [string]$needle, [string]$message) {
    if (-not $content.Contains($needle)) {
        Add-Failure $message
    }
}

function Assert-NotContains([string]$content, [string]$needle, [string]$message) {
    if ($content.Contains($needle)) {
        Add-Failure $message
    }
}

function Assert-NoMojibake([string]$content, [string]$label) {
    $patterns = @(
        '[\uE000-\uF8FF]'
    )

    foreach ($pattern in $patterns) {
        if ($content -match $pattern) {
            Add-Failure "$label still contains garbled text pattern: $pattern"
        }
    }
}

function U([int[]]$codes) {
    return -join ($codes | ForEach-Object { [char]$_ })
}

$router = Read-Utf8 'ui/src/router/index.js'
Assert-NoMojibake $router 'ui/src/router/index.js'
$expectedTitles = @(
    (U @(0x4E2A,0x4EBA,0x4E2D,0x5FC3)),
    (U @(0x5206,0x914D,0x89D2,0x8272)),
    (U @(0x5206,0x914D,0x7528,0x6237)),
    (U @(0x5B57,0x5178,0x6570,0x636E)),
    (U @(0x8BA2,0x5355,0x5BA1,0x6838)),
    (U @(0x8C03,0x5EA6,0x65E5,0x5FD7)),
    (U @(0x4FEE,0x6539,0x751F,0x6210,0x914D,0x7F6E))
)
foreach ($title in $expectedTitles) {
    Assert-Contains $router "title: '$title'" "Missing corrected route title: $title"
}
Assert-Contains $router "path: '/system/notice-detail'" 'Router should expose a dedicated notice detail route.'
Assert-Contains $router "permissions: ['system:notice:query']" 'Notice detail route should require query permission.'
Assert-Contains $router "component: () => import('@/views/system/notice/detail')" 'Notice detail route should load the dedicated detail view.'

$noticeIndex = Read-Utf8 'ui/src/views/system/notice/index.vue'
Assert-Contains $noticeIndex "this.`$router.push({ name: 'NoticeDetail'" 'Notice list view should navigate to the dedicated detail page.'
Assert-Contains $noticeIndex "v-hasPermi=`"['system:notice:query']`"" 'Notice list view should guard the view action with query permission.'

if (-not (Test-Path (Join-Path $Root 'ui/src/views/system/notice/detail.vue'))) {
    Add-Failure 'Missing dedicated notice detail view: ui/src/views/system/notice/detail.vue'
}
else {
    $noticeDetail = Read-Utf8 'ui/src/views/system/notice/detail.vue'
    Assert-Contains $noticeDetail 'getNotice(this.noticeId)' 'Notice detail view should fetch notice detail by id.'
    Assert-Contains $noticeDetail 'v-html="notice.noticeContent || emptyContent"' 'Notice detail view should render notice content read-only.'
}

$userService = Read-Utf8 'system/src/main/java/com/medical/system/service/impl/SysUserServiceImpl.java'
Assert-Contains $userService 'fillDefaultRoleIdsByDept(user);' 'SysUserServiceImpl should apply department default roles before saving users.'
Assert-Contains $userService 'selectRoleByKey' 'SysUserServiceImpl should resolve roles by roleKey.'
Assert-Contains $userService 'medical_support' 'SysUserServiceImpl should know the medical support role key.'
Assert-Contains $userService 'endoscopy_clinical' 'SysUserServiceImpl should know the endoscopy clinical role key.'

$roleMapper = Read-Utf8 'system/src/main/java/com/medical/system/mapper/SysRoleMapper.java'
Assert-Contains $roleMapper 'selectRoleByKey' 'SysRoleMapper should expose selectRoleByKey.'

$roleMapperXml = Read-Utf8 'system/src/main/resources/mapper/system/SysRoleMapper.xml'
Assert-Contains $roleMapperXml 'selectRoleByKey' 'SysRoleMapper.xml should implement selectRoleByKey.'

$phase3 = Read-Utf8 'sql/polyp_phase3_medical_org_refine.sql'
Assert-Contains $phase3 'medical_support' 'Phase3 SQL should define the medical_support role.'
Assert-Contains $phase3 'endoscopy_clinical' 'Phase3 SQL should define the endoscopy_clinical role.'
Assert-Contains $phase3 "perms LIKE 'system:polyp:%'" 'Endoscopy clinical role should include polyp detection permissions.'
Assert-Contains $phase3 "perms IN ('system:notice:list', 'system:notice:query')" 'Endoscopy clinical role should only receive notice list/query permissions.'
Assert-Contains $phase3 "perms IN ('system:notice:add', 'system:notice:edit', 'system:notice:remove')" 'Phase3 SQL should explicitly remove notice management permissions from endoscopy clinical.'
Assert-Contains $phase3 "role_key = 'medical_support'" 'Phase3 SQL should assign all menus to medical_support.'

$polypTaskController = Read-Utf8 'admin/src/main/java/com/medical/web/controller/polyp/PolypTaskController.java'
Assert-Contains $polypTaskController "@ss.hasPermi('system:polyp:add')" 'Polyp task creation should use the existing polyp add permission.'
Assert-Contains $polypTaskController "@ss.hasPermi('system:polyp:query')" 'Polyp task detail should use the existing polyp query permission.'
Assert-Contains $polypTaskController "@ss.hasPermi('system:polyp:list')" 'Polyp task list should use the existing polyp list permission.'
Assert-Contains $polypTaskController "@ss.hasPermi('system:polyp:remove')" 'Polyp task deletion should use the existing polyp remove permission.'
Assert-Contains $polypTaskController "@ss.hasPermi('system:polyp:export')" 'Polyp task export should use the existing polyp export permission.'
Assert-NotContains $polypTaskController 'system:polyp:task:' 'Polyp task controller should not require unassigned task:* permissions.'

$polypFileController = Read-Utf8 'admin/src/main/java/com/medical/web/controller/polyp/PolypFileController.java'
Assert-Contains $polypFileController "@ss.hasPermi('system:polyp:add')" 'Polyp file upload should use the existing polyp add permission.'
Assert-NotContains $polypFileController 'system:polyp:file:' 'Polyp file controller should not require unassigned file:* permissions.'

$polypModelController = Read-Utf8 'admin/src/main/java/com/medical/web/controller/polyp/PolypModelController.java'
Assert-Contains $polypModelController "@ss.hasPermi('system:polyp:query')" 'Polyp model lookup should use the existing polyp query permission.'
Assert-NotContains $polypModelController 'system:polyp:model:' 'Polyp model controller should not require unassigned model:* permissions.'

$polypDashboardController = Read-Utf8 'admin/src/main/java/com/medical/web/controller/polyp/PolypDashboardController.java'
Assert-Contains $polypDashboardController "@ss.hasPermi('system:polyp:query')" 'Polyp dashboard should use the existing polyp query permission.'
Assert-NotContains $polypDashboardController 'system:polyp:task:' 'Polyp dashboard should not require unassigned task:* permissions.'

$detectionView = Read-Utf8 'ui/src/views/system/detection/index.vue'
Assert-Contains $detectionView "v-hasPermi=`"['system:polyp:query']`"" 'Detection view model button should use the existing polyp query permission.'
Assert-Contains $detectionView "v-hasPermi=`"['system:polyp:add']`"" 'Detection view submit button should use the existing polyp add permission.'
Assert-Contains $detectionView "v-hasPermi=`"['system:polyp:remove']`"" 'Detection view delete button should use the existing polyp remove permission.'
Assert-Contains $detectionView "v-hasPermi=`"['system:polyp:export']`"" 'Detection view export button should use the existing polyp export permission.'
Assert-NotContains $detectionView 'system:polyp:task:' 'Detection view should not require unassigned task:* permissions.'
Assert-NotContains $detectionView 'system:polyp:file:' 'Detection view should not require unassigned file:* permissions.'
Assert-NotContains $detectionView 'system:polyp:model:' 'Detection view should not require unassigned model:* permissions.'

$logoPath = Join-Path $Root 'ui/src/assets/logo/logo.png'
Add-Type -AssemblyName System.Drawing
$img = [System.Drawing.Image]::FromFile($logoPath)
try {
    if ($img.Width -lt 128 -or $img.Height -lt 128) {
        Add-Failure "Logo should be at least 128x128 pixels, got $($img.Width)x$($img.Height)."
    }
}
finally {
    $img.Dispose()
}

$faviconPath = Join-Path $Root 'ui/public/favicon.ico'
$faviconBytes = [System.IO.File]::ReadAllBytes($faviconPath)
if ($faviconBytes.Length -lt 30 -or $faviconBytes[0] -ne 0 -or $faviconBytes[1] -ne 0 -or $faviconBytes[2] -ne 1 -or $faviconBytes[3] -ne 0) {
    Add-Failure 'Favicon should be a valid ICO file.'
}
else {
    $imageOffset = [BitConverter]::ToInt32($faviconBytes, 18)
    $pngSignature = [byte[]](0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A)
    $hasPngPayload = $faviconBytes.Length -ge ($imageOffset + $pngSignature.Length)
    for ($i = 0; $hasPngPayload -and $i -lt $pngSignature.Length; $i++) {
        if ($faviconBytes[$imageOffset + $i] -ne $pngSignature[$i]) {
            $hasPngPayload = $false
        }
    }
    if (-not $hasPngPayload) {
        Add-Failure 'Favicon should use the medical logo PNG payload, not the old bitmap icon.'
    }
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Host "FAIL: $_" }
    exit 1
}

Write-Host "Medical access verification passed."
