-- Phase 1: YOLOv5 息肉检测最小闭环表结构
-- 执行顺序：先建基础表，再初始化默认模型

CREATE TABLE IF NOT EXISTS `file_asset` (
  `file_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `biz_type` varchar(32) NOT NULL COMMENT '业务类型：SOURCE_IMAGE/RESULT_IMAGE',
  `origin_name` varchar(255) NOT NULL COMMENT '原始文件名',
  `ext_name` varchar(32) DEFAULT NULL COMMENT '文件扩展名',
  `mime_type` varchar(128) DEFAULT NULL COMMENT 'MIME类型',
  `size_bytes` bigint(20) DEFAULT NULL COMMENT '文件大小(字节)',
  `store_path` varchar(1024) NOT NULL COMMENT '文件绝对路径',
  `file_url` varchar(1024) NOT NULL COMMENT '访问URL(例如/profile/upload/...)',
  `sha256` char(64) DEFAULT NULL COMMENT '文件哈希(预留)',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`file_id`),
  KEY `idx_biz_type` (`biz_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文件资源表';

CREATE TABLE IF NOT EXISTS `polyp_model` (
  `model_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `model_name` varchar(64) NOT NULL COMMENT '模型名称',
  `model_version` varchar(32) DEFAULT NULL COMMENT '模型版本',
  `model_path` varchar(1024) DEFAULT NULL COMMENT '模型路径(本地/挂载路径)',
  `status` varchar(16) NOT NULL DEFAULT 'ACTIVE' COMMENT '状态：ACTIVE/INACTIVE',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否默认模型：1是0否',
  `conf_threshold` decimal(5,4) DEFAULT 0.5000 COMMENT '默认置信度阈值',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`model_id`),
  KEY `idx_status_default` (`status`, `is_default`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='息肉检测模型表';

CREATE TABLE IF NOT EXISTS `polyp_detect_task` (
  `task_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `task_no` varchar(64) NOT NULL COMMENT '任务编号',
  `patient_id` bigint(20) DEFAULT NULL COMMENT '患者ID(可空)',
  `source_file_id` bigint(20) NOT NULL COMMENT '原图文件ID(file_asset.file_id)',
  `model_id` bigint(20) NOT NULL COMMENT '模型ID(polyp_model.model_id)',
  `status` varchar(16) NOT NULL COMMENT '任务状态：PENDING/RUNNING/SUCCESS/FAILED',
  `conf_threshold` decimal(5,4) DEFAULT NULL COMMENT '本次任务阈值',
  `result_id` bigint(20) DEFAULT NULL COMMENT '检测结果ID(复用his_detection_result.result_id)',
  `inference_ms` bigint(20) DEFAULT NULL COMMENT '推理耗时(ms)',
  `error_msg` varchar(500) DEFAULT NULL COMMENT '失败原因',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `finish_time` datetime DEFAULT NULL COMMENT '结束时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`task_id`),
  UNIQUE KEY `uk_task_no` (`task_no`),
  KEY `idx_status` (`status`),
  KEY `idx_source_file_id` (`source_file_id`),
  KEY `idx_model_id` (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='息肉检测任务表';

-- 初始化默认模型（按需修改model_path）
INSERT INTO `polyp_model` (`model_name`, `model_version`, `model_path`, `status`, `is_default`, `conf_threshold`, `remark`)
SELECT 'yolov5-polyp', 'v1', 'M:/0NUIST/class/bysj/Medical-platform-master/ruoyi-system/src/main/resources/yolo/polyp.pt', 'ACTIVE', 1, 0.5000, 'Phase1默认模型'
WHERE NOT EXISTS (
  SELECT 1 FROM `polyp_model` WHERE `is_default` = 1 AND `status` = 'ACTIVE'
);
