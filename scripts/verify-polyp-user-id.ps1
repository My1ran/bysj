$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot

function Read-RepoFile([string]$relativePath) {
    return Get-Content -Raw -LiteralPath (Join-Path $root $relativePath)
}

function Assert-Contains([string]$name, [string]$content, [string]$pattern) {
    if ($content -notmatch $pattern) {
        throw "$name does not contain expected pattern: $pattern"
    }
}

function Assert-NotContains([string]$name, [string]$content, [string]$pattern) {
    if ($content -match $pattern) {
        throw "$name still contains forbidden pattern: $pattern"
    }
}

function Get-CreateTableBlock([string]$content, [string]$tableName) {
    $pattern = "(?s)CREATE TABLE(?: IF NOT EXISTS)? ``$tableName``.*?\)\s*ENGINE"
    $match = [regex]::Match($content, $pattern)
    if (-not $match.Success) {
        throw "CREATE TABLE block not found for $tableName"
    }
    return $match.Value
}

$polypDomain = Read-RepoFile "system/src/main/java/com/medical/polyp/domain/PolypDetectTask.java"
Assert-Contains "PolypDetectTask" $polypDomain "private Long userId;"
Assert-Contains "PolypDetectTask" $polypDomain "getUserId\("
Assert-NotContains "PolypDetectTask" $polypDomain "patientId|PatientId"

$polypCreateRequest = Read-RepoFile "system/src/main/java/com/medical/polyp/domain/dto/PolypTaskCreateRequest.java"
Assert-NotContains "PolypTaskCreateRequest" $polypCreateRequest "patientId|PatientId|userId|UserId"

$polypMapper = Read-RepoFile "system/src/main/resources/mapper/polyp/PolypDetectTaskMapper.xml"
Assert-Contains "PolypDetectTaskMapper.xml" $polypMapper "property=`"userId`" column=`"user_id`""
Assert-Contains "PolypDetectTaskMapper.xml" $polypMapper "t\.user_id"
Assert-NotContains "PolypDetectTaskMapper.xml" $polypMapper "patient_id|patientId"

$resultDomain = Read-RepoFile "system/src/main/java/com/medical/system/domain/HisDetectionResult.java"
Assert-Contains "HisDetectionResult" $resultDomain "private Long userId;"
Assert-Contains "HisDetectionResult" $resultDomain "getUserId\("
Assert-NotContains "HisDetectionResult" $resultDomain "patiId|PatiId"

$resultMapper = Read-RepoFile "system/src/main/resources/mapper/system/HisDetectionResultMapper.xml"
Assert-Contains "HisDetectionResultMapper.xml" $resultMapper "property=`"userId`"    column=`"user_id`""
Assert-NotContains "HisDetectionResultMapper.xml" $resultMapper "pati_id|patiId"

$taskService = Read-RepoFile "system/src/main/java/com/medical/polyp/service/impl/PolypDetectTaskServiceImpl.java"
Assert-Contains "PolypDetectTaskServiceImpl" $taskService "SecurityUtils\.getUserId\(\)"
Assert-Contains "PolypDetectTaskServiceImpl" $taskService "task\.setUserId"
Assert-Contains "PolypDetectTaskServiceImpl" $taskService "detectionResult\.setUserId\(task\.getUserId\(\)\)"
Assert-NotContains "PolypDetectTaskServiceImpl" $taskService "setPatientId|getPatientId|setPatiId|getPatiId"

$legacyController = Read-RepoFile "admin/src/main/java/com/medical/web/controller/system/HisDetectionController.java"
Assert-Contains "HisDetectionController" $legacyController "detectionResult\.setUserId\(getUserId\(\)\)"
Assert-NotContains "HisDetectionController" $legacyController "patiId|setPatiId|IHisPatientService|hisPatientService"

$realtimeVue = Read-RepoFile "ui/src/views/system/detection/realtime.vue"
Assert-NotContains "realtime.vue" $realtimeVue "listPatient|patientList|patiId|saveForm"

$detectionApi = Read-RepoFile "ui/src/api/system/detection.js"
Assert-NotContains "detection.js" $detectionApi "patiId"

foreach ($sqlPath in @("sql/polyp_phase1.sql", "sql/medical-vue.sql")) {
    $content = Read-RepoFile $sqlPath
    $block = Get-CreateTableBlock $content "polyp_detect_task"
    Assert-Contains $sqlPath $block "``user_id``"
    Assert-NotContains $sqlPath $block "``patient_id``"
}

foreach ($sqlPath in @("sql/yolo_polyp_detection.sql", "sql/medical-vue.sql")) {
    $content = Read-RepoFile $sqlPath
    $block = Get-CreateTableBlock $content "his_detection_result"
    Assert-Contains $sqlPath $block "``user_id``"
    Assert-NotContains $sqlPath $block "``pati_id``|idx_pati_id"
}

Write-Host "polyp user_id verification passed"
