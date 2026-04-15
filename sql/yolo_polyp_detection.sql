-- ----------------------------
-- 患者信息表
-- ----------------------------
DROP TABLE IF EXISTS `his_patient`;
CREATE TABLE `his_patient` (
  `pati_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '患者 ID',
  `pati_name` varchar(50) NOT NULL COMMENT '患者姓名',
  `pati_code` varchar(30) DEFAULT NULL COMMENT '病历号',
  `gender` char(1) DEFAULT NULL COMMENT '性别 (0 男 1 女)',
  `age` int(3) DEFAULT NULL COMMENT '年龄',
  `birthday` date DEFAULT NULL COMMENT '出生日期',
  `phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `id_card` varchar(18) DEFAULT NULL COMMENT '身份证号',
  `address` varchar(200) DEFAULT NULL COMMENT '联系地址',
  `allergy` varchar(500) DEFAULT NULL COMMENT '过敏史',
  `medical_history` varchar(1000) DEFAULT NULL COMMENT '既往病史',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`pati_id`),
  UNIQUE KEY `uk_pati_code` (`pati_code`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='患者信息表';

-- ----------------------------
-- 检测结果表
-- ----------------------------
DROP TABLE IF EXISTS `his_detection_result`;
CREATE TABLE `his_detection_result` (
  `result_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '检测结果 ID',
  `pati_id` bigint(20) DEFAULT NULL COMMENT '患者 ID',
  `pati_name` varchar(50) DEFAULT '' COMMENT '患者姓名 (冗余)',
  `detection_type` char(1) DEFAULT '' COMMENT '检测类型 (0 图片检测 1 视频检测 2 实时检测)',
  `sample_number` varchar(50) DEFAULT NULL COMMENT '样本编号',
  `original_file` varchar(500) DEFAULT NULL COMMENT '原始文件路径',
  `result_file` varchar(500) DEFAULT NULL COMMENT '结果文件路径',
  `polyp_count` int(5) DEFAULT 0 COMMENT '息肉数量',
  `max_size` decimal(10,2) DEFAULT NULL COMMENT '最大尺寸 (mm)',
  `min_size` decimal(10,2) DEFAULT NULL COMMENT '最小尺寸 (mm)',
  `avg_confidence` decimal(5,2) DEFAULT NULL COMMENT '平均置信度',
  `positions` varchar(500) DEFAULT NULL COMMENT '息肉位置分布 (JSON)',
  `detection_time` datetime DEFAULT NULL COMMENT '检测时间',
  `report_generated` char(1) DEFAULT '0' COMMENT '是否已生成报告 (0 否 1 是)',
  `report_file` varchar(500) DEFAULT NULL COMMENT '报告文件路径',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`result_id`),
  KEY `idx_pati_id` (`pati_id`),
  KEY `idx_detection_time` (`detection_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='检测结果表';

-- ----------------------------
-- 息肉详情表
-- ----------------------------
DROP TABLE IF EXISTS `his_polyp_detail`;
CREATE TABLE `his_polyp_detail` (
  `polyp_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '息肉 ID',
  `result_id` bigint(20) NOT NULL COMMENT '检测结果 ID',
  `polyp_index` int(5) DEFAULT NULL COMMENT '息肉序号',
  `confidence` decimal(5,2) DEFAULT NULL COMMENT '置信度',
  `size_mm` decimal(10,2) DEFAULT NULL COMMENT '尺寸 (mm)',
  `position` varchar(50) DEFAULT NULL COMMENT '位置',
  `bbox_x` int(5) DEFAULT NULL COMMENT '边界框 X 坐标',
  `bbox_y` int(5) DEFAULT NULL COMMENT '边界框 Y 坐标',
  `bbox_width` int(5) DEFAULT NULL COMMENT '边界框宽度',
  `bbox_height` int(5) DEFAULT NULL COMMENT '边界框高度',
  `classification` varchar(50) DEFAULT NULL COMMENT '分类',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`polyp_id`),
  KEY `idx_result_id` (`result_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='息肉详情表';