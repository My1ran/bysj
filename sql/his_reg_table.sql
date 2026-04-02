-- ----------------------------
-- 挂号表
-- ----------------------------
DROP TABLE IF EXISTS `his_reg`;
CREATE TABLE `his_reg` (
  `reg_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '挂单号',
  `pati_name` varchar(30) DEFAULT '' COMMENT '患者姓名',
  `reg_card_num` varchar(18) DEFAULT '' COMMENT '身份证号',
  `reg_depts` varchar(50) DEFAULT '' COMMENT '挂号科室',
  `reg_docter` varchar(30) DEFAULT '' COMMENT '接诊医生',
  `reg_price` decimal(10,2) DEFAULT NULL COMMENT '挂号费用',
  `reg_num` int(4) DEFAULT NULL COMMENT '流水编号',
  `reg_status` char(1) DEFAULT '0' COMMENT '状态（0 待就诊 1 已就诊 2 已取消）',
  `reg_sdate` date DEFAULT NULL COMMENT '就诊日期',
  `reg_type` char(1) DEFAULT '' COMMENT '挂号类型（0 普通 1 专家）',
  `reg_time` varchar(20) DEFAULT '' COMMENT '挂号时段',
  `reg_rdate` date DEFAULT NULL COMMENT '挂号时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`reg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='挂号表';