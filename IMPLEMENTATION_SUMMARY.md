# YOLOv5 肠道息肉检测系统 - 实现总结

## 项目概述
将原有医疗平台改造为基于 YOLOv5 的肠道息肉检测系统，支持医生用户进行息肉检测、结果管理和报告生成。

---

## 一、数据库变更

### 新增数据库表（3 张）
**SQL 文件位置**: `sql/yolo_polyp_detection.sql`

1. **his_patient** - 患者信息表
   - 字段：pati_id, pati_name, pati_code, gender, age, birthday, phone, id_card, address, allergy, medical_history 等

2. **his_detection_result** - 检测结果表
   - 字段：result_id, pati_id, pati_name, detection_type, sample_number, original_file, result_file, polyp_count, max_size, min_size, avg_confidence, positions, detection_time, report_generated 等

3. **his_polyp_detail** - 息肉详情表
   - 字段：polyp_id, result_id, polyp_index, confidence, size_mm, position, bbox_x, bbox_y, bbox_width, bbox_height, classification 等

---

## 二、后端新增文件

### 1. 实体类（Domain）- 3 个
**位置**: `system/src/main/java/com/medical/system/domain/`

| 文件名 | 说明 |
|--------|------|
| `HisPatient.java` | 患者信息实体 |
| `HisDetectionResult.java` | 检测结果实体 |
| `HisPolypDetail.java` | 息肉详情实体 |

### 2. Mapper 接口 - 3 个
**位置**: `system/src/main/java/com/medical/system/mapper/`

| 文件名 | 说明 |
|--------|------|
| `HisPatientMapper.java` | 患者信息 Mapper |
| `HisDetectionResultMapper.java` | 检测结果 Mapper |
| `HisPolypDetailMapper.java` | 息肉详情 Mapper |

### 3. Mapper XML - 3 个
**位置**: `system/src/main/resources/mapper/system/`

| 文件名 | 说明 |
|--------|------|
| `HisPatientMapper.xml` | 患者信息 SQL 映射 |
| `HisDetectionResultMapper.xml` | 检测结果 SQL 映射 |
| `HisPolypDetailMapper.xml` | 息肉详情 SQL 映射 |

### 4. Service 接口 - 3 个
**位置**: `system/src/main/java/com/medical/system/service/`

| 文件名 | 说明 |
|--------|------|
| `IHisPatientService.java` | 患者服务接口 |
| `IHisDetectionResultService.java` | 检测服务接口 |
| `IHisPolypDetailService.java` | 息肉详情服务接口 |

### 5. Service 实现 - 3 个
**位置**: `system/src/main/java/com/medical/system/service/impl/`

| 文件名 | 说明 |
|--------|------|
| `HisPatientServiceImpl.java` | 患者服务实现 |
| `HisDetectionResultServiceImpl.java` | 检测服务实现 |
| `HisPolypDetailServiceImpl.java` | 息肉详情服务实现 |

### 6. YOLOv5 检测模块 - 4 个
**位置**: `system/src/main/java/com/medical/system/yolo/`

| 文件名 | 说明 |
|--------|------|
| `YoloV5ServiceImpl.java` | YOLOv5 检测服务核心 |
| `YoloResult.java` | 检测结果 DTO |
| `BoundingBox.java` | 边界框 DTO |
| `detect.py` | Python 推理脚本 |
| `requirements.txt` | Python 依赖 |

### 7. Controller - 3 个
**位置**: `admin/src/main/java/com/medical/web/controller/system/`

| 文件名 | 接口路径 | 说明 |
|--------|----------|------|
| `HisPatientController.java` | `/system/patient/*` | 患者管理 |
| `HisDetectionController.java` | `/system/detection/*` | 检测管理 |
| `HisReportController.java` | `/system/report/*` | 报告管理 |

---

## 三、前端新增文件

### 1. API 接口 - 3 个
**位置**: `ui/src/api/system/`

| 文件名 | 说明 |
|--------|------|
| `patient.js` | 患者管理 API |
| `detection.js` | 检测管理 API |
| `report.js` | 报告管理 API |

### 2. 页面视图 - 3 个
**位置**: `ui/src/views/system/`

| 文件名 | 说明 |
|--------|------|
| `patient/index.vue` | 患者列表页（增删改查） |
| `detection/index.vue` | 检测列表页（上传检测、结果查看） |
| `detection/realtime.vue` | 实时检测页（摄像头检测） |

---

## 四、API 接口汇总

### 患者管理
| 方法 | 路径 | 说明 | 权限 |
|------|------|------|------|
| GET | /system/patient/list | 查询患者列表 | system:patient:list |
| GET | /system/patient/{patiId} | 查询患者详情 | system:patient:query |
| POST | /system/patient | 新增患者 | system:patient:add |
| PUT | /system/patient | 修改患者 | system:patient:edit |
| DELETE | /system/patient/{patiIds} | 删除患者 | system:patient:remove |
| POST | /system/patient/export | 导出患者 | system:patient:export |

### 检测管理
| 方法 | 路径 | 说明 | 权限 |
|------|------|------|------|
| GET | /system/detection/list | 查询检测列表 | system:detection:list |
| GET | /system/detection/{resultId} | 查询检测详情 | system:detection:query |
| POST | /system/detection/upload | 上传图片检测 | system:detection:upload |
| DELETE | /system/detection/{resultIds} | 删除检测 | system:detection:remove |
| POST | /system/detection/export | 导出检测 | system:detection:export |

### 报告管理
| 方法 | 路径 | 说明 | 权限 |
|------|------|------|------|
| GET | /system/report/{resultId} | 查询报告详情 | system:report:query |
| GET | /system/report/{resultId}/pdf | 导出 PDF 报告 | system:report:export |

---

## 五、功能模块说明

### 1. 用户管理模块
- **登录注册**: 复用现有系统功能
- **个人中心**: 复用现有系统功能
- **权限控制**: 基于医疗平台框架的权限管理

### 2. 核心检测模块
- **图片上传检测**:
  - 支持 JPG/PNG/BMP 格式
  - 文件大小限制 10MB
  - 调用 YOLOv5 模型检测
  - 返回息肉数量、位置、置信度

- **实时检测**:
  - WebRTC 获取摄像头画面
  - 每 2 秒自动检测一帧
  - Canvas 叠加显示检测结果
  - 实时统计检测数据

- **视频检测** (待实现):
  - 上传视频文件
  - 后端逐帧检测
  - 前端渲染标注

### 3. 检测结果管理模块
- **结果列表**: 分页展示所有检测记录
- **结果详情**: 查看检测图片、息肉详情、统计信息
- **增删改查**: 完整 CRUD 操作
- **导出功能**: Excel 导出检测结果

### 4. 患者信息管理模块
- **患者列表**: 分页展示患者信息
- **患者详情**: 查看患者基本信息、过敏史、既往病史
- **增删改查**: 完整 CRUD 操作

### 5. 检测报告模块
- **报告预览**: 查看检测报告详情
- **PDF 导出**: 生成并下载 PDF 报告（需实现）
- **统计分析**: 息肉数量、大小分布、历史对比

---

## 六、部署步骤

### 1. 数据库配置
```bash
# 执行 SQL 脚本创建表
mysql -u root -p medical-vue < sql/yolo_polyp_detection.sql
```

### 2. Python 环境配置
```bash
# 进入 YOLO 目录
cd system/src/main/resources/yolo

# 安装依赖
pip install torch torchvision opencv-python numpy ultralytics pandas

# 放置模型文件
# 将训练好的 polyp.pt 模型文件放到此目录
```

### 3. 后端配置
- 修改 `YoloV5ServiceImpl.java` 中的模型路径和 Python 脚本路径
- 确保 Python 已加入系统 PATH

### 4. 前端配置
- 无需特殊配置，复用现有项目结构

### 5. 启动项目
```bash
# 后端启动
cd admin
mvn spring-boot:run

# 前端启动
cd ui
npm install
npm run dev
```

---

## 七、后续待实现功能

1. **PDF 报告生成**
   - 使用 iTextPDF 或 Apache PDFBox
   - 包含患者信息、检测结果、统计图表

2. **视频检测**
   - 视频文件上传
   - 后端逐帧处理
   - 结果视频生成

3. **统计分析**
   - 息肉大小分布图
   - 检测趋势图
   - 患者历史记录对比

4. **模型优化**
   - 支持 GPU 加速
   - 模型热加载
   - 多模型切换

---

## 八、关键文件路径汇总

### 后端核心
- `system/src/main/java/com/medical/system/yolo/YoloV5ServiceImpl.java`
- `system/src/main/resources/yolo/detect.py`
- `admin/src/main/java/com/medical/web/controller/system/HisDetectionController.java`

### 前端核心
- `ui/src/views/system/detection/index.vue` - 检测列表
- `ui/src/views/system/detection/realtime.vue` - 实时检测
- `ui/src/api/system/detection.js` - 检测 API

### 数据库
- `sql/yolo_polyp_detection.sql` - 建表脚本

---

## 九、技术栈

### 后端
- Spring Boot 2.5.14
- MyBatis
- Python 3.8+ (YOLOv5 推理)
- PyTorch

### 前端
- Vue 2.6.12
- Element UI 2.15.10
- Axios
- WebRTC (实时检测)
- Canvas (结果渲染)

---

## 十、注意事项

1. **Python 依赖**: 确保安装 torch、opencv-python 等依赖
2. **模型文件**: 需自行准备 YOLOv5 息肉检测模型 (.pt 文件)
3. **路径配置**: 根据实际部署环境修改路径配置
4. **权限配置**: 在医疗平台后台添加对应的菜单和权限
5. **摄像头权限**: 实时检测需要浏览器授予摄像头权限

---

## 十一、2026-03-27 更新

### 本次修改

1. **删除"医疗平台官网"和"李杰的项目源码"**
   - 修改 `Navbar.vue`，移除 `MedicalGit` 和 `MedicalDoc` 组件引用
   - 移除了"李杰的项目源码" tooltip

2. **新增息肉详情前端页面**
   - 新增 `ui/src/api/system/polyp.js` - 息肉详情 API
   - 新增 `ui/src/views/system/polyp/index.vue` - 息肉详情管理页面

3. **新增息肉详情 Controller**
   - 新增 `admin/src/main/java/com/medical/web/controller/system/HisPolypController.java`
   - 接口路径：`/system/polyp/*`
   - 支持：列表查询、按检测结果ID查询、增删改查

### 菜单配置（需在医疗平台后台添加）

| 菜单名称 | 路由地址 | 组件路径 |
|----------|----------|----------|
| 息肉详情 | /system/polyp | system/polyp/index |

### 权限配置

需要在 `sys_menu` 表添加：
```sql
-- 息肉详情目录
INSERT INTO `sys_menu` VALUES (..., '息肉详情', 0, 6, '/polyp', 'system/polyp/index', '', 1, 0, 'C', '0', '0', 'system:polyp:view', 'clipboard', ...);

-- 息肉详情按钮（查看、编辑、删除、新增等）
```

---

*最后更新时间: 2026-03-27*
