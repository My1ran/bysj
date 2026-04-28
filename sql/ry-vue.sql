/*
 Navicat Premium Data Transfer

 Source Server         : 北京服务器
 Source Server Type    : MySQL
 Source Server Version : 80042
 Source Host           : 47.95.179.218:3306
 Source Schema         : ry-vue

 Target Server Type    : MySQL
 Target Server Version : 80042
 File Encoding         : 65001

 Date: 12/04/2026 00:39:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for charge
-- ----------------------------
DROP TABLE IF EXISTS `charge`;
CREATE TABLE `charge`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单号',
  `Registration_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '挂号单号',
  `Patient_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '患者姓名',
  `Total_amount` int NOT NULL COMMENT '总金额',
  `Payment_method` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付类型',
  `Order_status` int NOT NULL COMMENT '订单状态',
  `Creation_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of charge
-- ----------------------------

-- ----------------------------
-- Table structure for chargedetail
-- ----------------------------
DROP TABLE IF EXISTS `chargedetail`;
CREATE TABLE `chargedetail`  (
  `order_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '订单ID',
  `drug_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '药品名称',
  `drug_id` int NULL DEFAULT NULL COMMENT '药品ID',
  `drug_Rx_price` double(10, 2) NULL DEFAULT NULL COMMENT '药品单价',
  `drug_price` double(10, 2) NULL DEFAULT NULL COMMENT '药品价格',
  `drug_amount` int NULL DEFAULT NULL COMMENT '药品数量',
  `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '类型（1：项目，0：药品）',
  `status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '状态(1：已支付，0：未支付)',
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chargedetail
-- ----------------------------
INSERT INTO `chargedetail` VALUES ('23288c476c6b4db4a154fac8fe718b42', '麦丽素', 1, NULL, 2000.00, 10, '0', '1', 46);
INSERT INTO `chargedetail` VALUES ('23288c476c6b4db4a154fac8fe718b42', '混元丹', 2, NULL, 2000.00, 10, '0', '1', 47);
INSERT INTO `chargedetail` VALUES ('23288c476c6b4db4a154fac8fe718b42', '血常规', 1, NULL, 5000.00, 1, '1', '1', 48);
INSERT INTO `chargedetail` VALUES ('23288c476c6b4db4a154fac8fe718b42', 'CT', 2, NULL, 5000.00, 1, '1', '1', 49);
INSERT INTO `chargedetail` VALUES ('95b8dbf353894379869b078500c13b16', '麦丽素', 1, 200.00, 2000.00, 10, '0', '1', 50);
INSERT INTO `chargedetail` VALUES ('95b8dbf353894379869b078500c13b16', '混元丹', 2, 200.00, 2000.00, 10, '0', '1', 51);
INSERT INTO `chargedetail` VALUES ('0ee3cbfaa2c449c9a6af9bb8a710cc4b', '麦丽素', 1, 200.00, 2000.00, 10, '0', '1', 52);
INSERT INTO `chargedetail` VALUES ('0ee3cbfaa2c449c9a6af9bb8a710cc4b', '混元丹', 2, 200.00, 2000.00, 10, '0', '1', 53);
INSERT INTO `chargedetail` VALUES ('0ee3cbfaa2c449c9a6af9bb8a710cc4b', '血常规', 1, 200.00, 5000.00, 1, '1', '1', 54);
INSERT INTO `chargedetail` VALUES ('0ee3cbfaa2c449c9a6af9bb8a710cc4b', 'CT', 2, 200.00, 5000.00, 1, '1', '1', 55);
INSERT INTO `chargedetail` VALUES ('3c23704920504930a53a2668a1e755e8', '麦丽素', 1, 200.00, 2000.00, 10, '0', '2', 56);
INSERT INTO `chargedetail` VALUES ('3c23704920504930a53a2668a1e755e8', '混元丹', 2, 200.00, 2000.00, 10, '0', '2', 57);
INSERT INTO `chargedetail` VALUES ('3c23704920504930a53a2668a1e755e8', '血常规', 1, 5000.00, 5000.00, 1, '1', '2', 58);
INSERT INTO `chargedetail` VALUES ('3c23704920504930a53a2668a1e755e8', 'CT', 2, 5000.00, 5000.00, 1, '1', '2', 59);

-- ----------------------------
-- Table structure for check_mode
-- ----------------------------
DROP TABLE IF EXISTS `check_mode`;
CREATE TABLE `check_mode`  (
  `case_id` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '病例单号--caseId',
  `check_code` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '检查单号--checkCode',
  `pati_id` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '患者ID--patiID',
  `exam_name` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '检查项目--examName',
  `pati_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '患者姓名--patiName',
  `checkresult` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '检查结果--checkResult',
  `checkstatus` int NULL DEFAULT NULL COMMENT '检查状态--checkStatus 添加默认值为0',
  `pay_status` int NULL DEFAULT NULL COMMENT '支付状态',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者---createBy',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间--createTime',
  `update_by` varbinary(255) NULL DEFAULT NULL COMMENT '更新者----updateBy',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间--updateTime',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注------remark',
  `filename` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '系统自动生成的图片名称-----fileName',
  `filesite` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '图片地址-----filesite'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of check_mode
-- ----------------------------

-- ----------------------------
-- Table structure for doctor_work_records
-- ----------------------------
DROP TABLE IF EXISTS `doctor_work_records`;
CREATE TABLE `doctor_work_records`  (
  `reg_form_id` int NOT NULL COMMENT '挂号单ID regFormId',
  `d_id` int NOT NULL COMMENT '医生ID dId',
  `d_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '医生名字 dName',
  `reg_form_price` double(10, 2) NOT NULL COMMENT '挂号花费 regFormPrice',
  `pati_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '患者名字 patiName',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者 createBy',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间 createTime',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注 remark'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of doctor_work_records
-- ----------------------------

-- ----------------------------
-- Table structure for drug
-- ----------------------------
DROP TABLE IF EXISTS `drug`;
CREATE TABLE `drug`  (
  `drug_id` int NOT NULL AUTO_INCREMENT COMMENT '药品ID',
  `drug_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '药品名称',
  `drug_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '药品编码',
  `drug_key` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '药品关键字',
  `drug_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '药品类型',
  `drug_Rx_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '处方类型',
  `drug_unit` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单位',
  `drug_Rx_price` double(10, 2) NULL DEFAULT NULL COMMENT '处方价格',
  `drug_stocks` int NULL DEFAULT NULL COMMENT '库存量',
  `drug_warning` int NULL DEFAULT NULL COMMENT '预警值',
  `drug_matrixing` int NULL DEFAULT NULL COMMENT '换算值',
  `drug_status` int NULL DEFAULT NULL COMMENT '状态',
  `fac_id` int NULL DEFAULT NULL COMMENT '厂家ID',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者---createBy',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间--createTime',
  `update_by` varbinary(255) NULL DEFAULT NULL COMMENT '更新者----updateBy',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间--updateTime',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注------remark',
  PRIMARY KEY (`drug_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of drug
-- ----------------------------
INSERT INTO `drug` VALUES (1, '阿胶珠', 'sxt0001', 'AJJ', '中草药', '中药处方', 'g', 2.00, 200, 100, 1, 0, 2, 'admin', '2026-02-22 23:54:45', 0x61646D696E, '2026-02-22 23:54:45', 'null');
INSERT INTO `drug` VALUES (2, '醋艾炭', 'sxt0002', 'CAT', '中草药', '中药处方', 'g', 2.00, 200, 100, 1, 0, 2, 'admin', '2026-02-22 23:54:45', 0x61646D696E, '2026-02-22 23:54:45', '生产厂家');
INSERT INTO `drug` VALUES (3, '制巴戟天', 'sxt0003', 'ZBJT', '中草药', '中药处方', 'g', 2.00, 200, 100, 1, 0, 2, 'admin', '2026-02-22 23:54:45', 0x61646D696E, '2026-02-22 23:54:45', '生产厂家');
INSERT INTO `drug` VALUES (4, '白莲', 'sxt0004', 'BL', '中草药', '中药处方', 'g', 2.00, 200, 100, 1, 0, 2, 'admin', '2026-02-22 23:54:45', 0x61646D696E, '2026-02-22 23:54:45', '生产厂家');
INSERT INTO `drug` VALUES (5, '白果', 'sxt0005', 'BG', '中草药', '中药处方', 'g', 2.00, 200, 100, 1, 0, 2, 'admin', '2026-02-22 23:54:45', 0x61646D696E, '2026-02-22 23:54:45', '生产厂家');
INSERT INTO `drug` VALUES (6, '白芷', 'sxt0006', 'BZ', '中草药', '中药处方', 'g', 2.00, 200, 100, 1, 0, 2, 'admin', '2026-02-22 23:54:45', 0x61646D696E, '2026-02-22 23:54:45', '生产厂家');
INSERT INTO `drug` VALUES (7, '白芍', 'sxt0007', 'BS', '中草药', '中药处方', 'g', 2.00, 200, 100, 1, 0, 2, 'admin', '2026-02-22 23:54:45', 0x61646D696E, '2026-02-22 23:54:45', '生产厂家');
INSERT INTO `drug` VALUES (8, '白英', 'sxt0008', 'BY', '中草药', '中药处方', 'g', 2.00, 200, 100, 1, 0, 2, 'admin', '2026-02-22 23:54:45', 0x61646D696E, '2026-02-22 23:54:45', '生产厂家');
INSERT INTO `drug` VALUES (9, '阿胶', 'sxt0009', 'AJ', '中草药', '中药处方', 'g', 2.00, 200, 100, 1, 0, 2, 'admin', '2026-02-22 23:54:45', 0x61646D696E, '2026-02-22 23:54:45', '生产厂家');
INSERT INTO `drug` VALUES (10, '铁皮石斛', 'sxt0010', 'TPSH', '中草药', '中药处方', 'g', 2.00, 200, 100, 1, 0, 2, 'admin', '2026-02-22 23:54:45', 0x61646D696E, '2026-02-22 23:54:45', '生产厂家');

-- ----------------------------
-- Table structure for drug_sales_records
-- ----------------------------
DROP TABLE IF EXISTS `drug_sales_records`;
CREATE TABLE `drug_sales_records`  (
  `drug_id` int NOT NULL COMMENT '药品ID drogId',
  `drug_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '药品名字 drogName',
  `drug_price` double(10, 2) NOT NULL COMMENT '药品价格 drogPrice',
  `sales_num` int NOT NULL COMMENT '销售数量 salesNum',
  `sales_allmoney` double(10, 2) NOT NULL COMMENT '总价格 salesAllmoney',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者 createBy',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间 createTime',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注 remark'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of drug_sales_records
-- ----------------------------

-- ----------------------------
-- Table structure for factory
-- ----------------------------
DROP TABLE IF EXISTS `factory`;
CREATE TABLE `factory`  (
  `fac_id` int NOT NULL AUTO_INCREMENT COMMENT '厂家ID',
  `fac_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '厂家名称',
  `fac_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '厂家编码',
  `fac_contact` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `fac_tel` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '电话',
  `fac_key` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '关键字',
  `fac_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '地址',
  `status` int NULL DEFAULT NULL COMMENT '状态',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者---createBy',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间--createTime',
  `update_by` varbinary(255) NULL DEFAULT NULL COMMENT '更新者----updateBy',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间--updateTime',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注------remark',
  PRIMARY KEY (`fac_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of factory
-- ----------------------------
INSERT INTO `factory` VALUES (1, '云南白药集团股份有限公司', '000538', '雷大哥', '0871-66350538', 'ynby', '云南', 0, 'admin', '2026-02-22 23:54:30', 0x61646D696E, '2026-02-22 23:54:30', '生产厂家');
INSERT INTO `factory` VALUES (2, '上海医药(集团)有限公司', '1812538', '雷大哥', '0871-66350538', 'ynby', '云南', 0, 'admin', '2026-02-22 23:54:30', 0x61646D696E, '2026-02-22 23:54:30', '生产厂家');
INSERT INTO `factory` VALUES (3, '中国医药集团总公司', '1238571', '雷大哥', '0871-66350538', 'ynby', '云南', 0, 'admin', '2026-02-22 23:54:30', 0x61646D696E, '2026-02-22 23:54:30', '生产厂家');
INSERT INTO `factory` VALUES (4, '广州医药集团有限公司', '1031377', '雷大哥', '0871-66350538', 'ynby', '云南', 0, 'admin', '2026-02-22 23:54:30', 0x61646D696E, '2026-02-22 23:54:30', '生产厂家');
INSERT INTO `factory` VALUES (5, '哈药集团有限公司', '727719', '雷大哥', '0871-66350538', 'ynby', '云南', 0, 'admin', '2026-02-22 23:54:30', 0x61646D696E, '2026-02-22 23:54:30', '生产厂家');
INSERT INTO `factory` VALUES (6, '华北制药集团有限公司', '700869', '雷大哥', '0871-66350538', 'ynby', '云南', 0, 'admin', '2026-02-22 23:54:30', 0x61646D696E, '2026-02-22 23:54:30', '生产厂家');
INSERT INTO `factory` VALUES (7, '太极集团有限公司', '589700', '雷大哥', '0871-66350538', 'ynby', '云南', 0, 'admin', '2026-02-22 23:54:30', 0x61646D696E, '2026-02-22 23:54:30', '生产厂家');
INSERT INTO `factory` VALUES (8, '北京同仁堂集团有限公司', '224882', '雷大哥', '0871-66350538', 'ynby', '云南', 0, 'admin', '2026-02-22 23:54:30', 0x61646D696E, '2026-02-22 23:54:30', '生产厂家');
INSERT INTO `factory` VALUES (9, '湖南九芝堂股份有限公司', '101857', '雷大哥', '0871-66350538', 'ynby', '云南', 0, 'admin', '2026-02-22 23:54:30', 0x61646D696E, '2026-02-22 23:54:30', '生产厂家');
INSERT INTO `factory` VALUES (10, '新疆新特药民族药业有限责任公司', '85191', '雷大哥', '0871-66350538', 'ynby', '云南', 0, 'admin', '2026-02-22 23:54:30', 0x61646D696E, '2026-02-22 23:54:30', '生产厂家');

-- ----------------------------
-- Table structure for file_asset
-- ----------------------------
DROP TABLE IF EXISTS `file_asset`;
CREATE TABLE `file_asset`  (
  `file_id` bigint NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `biz_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '业务类型：SOURCE_IMAGE/RESULT_IMAGE',
  `origin_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '原始文件名',
  `ext_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件扩展名',
  `mime_type` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'MIME类型',
  `size_bytes` bigint NULL DEFAULT NULL COMMENT '文件大小(字节)',
  `store_path` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件绝对路径',
  `file_url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '访问URL(例如/profile/upload/...)',
  `sha256` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件哈希(预留)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`file_id`) USING BTREE,
  INDEX `idx_biz_type`(`biz_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '文件资源表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of file_asset
-- ----------------------------
INSERT INTO `file_asset` VALUES (1, 'SOURCE_IMAGE', '404.png', 'png', 'image/png', 98071, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\04\\404_20260404000121A001.png', '/profile/upload\\polyp/source/2026/04/04/404_20260404000121A001.png', NULL, NULL, '2026-04-04 00:01:21');
INSERT INTO `file_asset` VALUES (2, 'SOURCE_IMAGE', '404.png', 'png', 'image/png', 98071, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\04\\404_20260404000710A001.png', '/profile/upload/polyp/source/2026/04/04/404_20260404000710A001.png', NULL, NULL, '2026-04-04 00:07:11');
INSERT INTO `file_asset` VALUES (3, 'SOURCE_IMAGE', '404.png', 'png', 'image/png', 98071, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\04\\404_20260404001328A001.png', '/profile/upload/polyp/source/2026/04/04/404_20260404001328A001.png', NULL, NULL, '2026-04-04 00:13:28');
INSERT INTO `file_asset` VALUES (4, 'SOURCE_VIDEO', 'WL.mp4', 'mp4', 'video/mp4', 3633750, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\09\\WL_20260409155410A001.mp4', '/profile/upload/polyp/source/2026/04/09/WL_20260409155410A001.mp4', NULL, NULL, '2026-04-09 15:54:11');
INSERT INTO `file_asset` VALUES (5, 'SOURCE_IMAGE', 'preview_train_white.jpg', 'jpg', 'image/jpeg', 449477, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\09\\preview_train_white_20260409164534A001.jpg', '/profile/upload/polyp/source/2026/04/09/preview_train_white_20260409164534A001.jpg', NULL, NULL, '2026-04-09 16:45:35');
INSERT INTO `file_asset` VALUES (6, 'SOURCE_VIDEO', 'WL.mp4', 'mp4', 'video/mp4', 3633750, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\09\\WL_20260409171659A001.mp4', '/profile/upload/polyp/source/2026/04/09/WL_20260409171659A001.mp4', NULL, NULL, '2026-04-09 17:17:00');
INSERT INTO `file_asset` VALUES (7, 'SOURCE_VIDEO', 'WL.mp4', 'mp4', 'video/mp4', 3633750, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\09\\WL_20260409171804A002.mp4', '/profile/upload/polyp/source/2026/04/09/WL_20260409171804A002.mp4', NULL, NULL, '2026-04-09 17:18:04');
INSERT INTO `file_asset` VALUES (8, 'SOURCE_IMAGE', 'preview_train_white.jpg', 'jpg', 'image/jpeg', 449477, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\09\\preview_train_white_20260409171830A003.jpg', '/profile/upload/polyp/source/2026/04/09/preview_train_white_20260409171830A003.jpg', NULL, NULL, '2026-04-09 17:18:31');
INSERT INTO `file_asset` VALUES (9, 'SOURCE_IMAGE', 'preview_train_white.jpg', 'jpg', 'image/jpeg', 449477, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\09\\preview_train_white_20260409172818A004.jpg', '/profile/upload/polyp/source/2026/04/09/preview_train_white_20260409172818A004.jpg', NULL, NULL, '2026-04-09 17:28:19');
INSERT INTO `file_asset` VALUES (10, 'SOURCE_VIDEO', 'WL.mp4', 'mp4', 'video/mp4', 3633750, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\09\\WL_20260409172836A005.mp4', '/profile/upload/polyp/source/2026/04/09/WL_20260409172836A005.mp4', NULL, NULL, '2026-04-09 17:28:36');
INSERT INTO `file_asset` VALUES (11, 'SOURCE_IMAGE', 'cju1fuoa4wmc50835qfd11sp9.jpg', 'jpg', 'image/jpeg', 27677, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\09\\cju1fuoa4wmc50835qfd11sp9_20260409173929A006.jpg', '/profile/upload/polyp/source/2026/04/09/cju1fuoa4wmc50835qfd11sp9_20260409173929A006.jpg', NULL, NULL, '2026-04-09 17:39:29');
INSERT INTO `file_asset` VALUES (12, 'SOURCE_IMAGE', 'cju1cvkfwqrec0993wbp1jlzm.jpg', 'jpg', 'image/jpeg', 24059, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\09\\cju1cvkfwqrec0993wbp1jlzm_20260409215450A001.jpg', '/profile/upload/polyp/source/2026/04/09/cju1cvkfwqrec0993wbp1jlzm_20260409215450A001.jpg', NULL, NULL, '2026-04-09 21:54:50');
INSERT INTO `file_asset` VALUES (13, 'SOURCE_IMAGE', 'cju1cvkfwqrec0993wbp1jlzm.jpg', 'jpg', 'image/jpeg', 24059, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\09\\cju1cvkfwqrec0993wbp1jlzm_20260409215517A002.jpg', '/profile/upload/polyp/source/2026/04/09/cju1cvkfwqrec0993wbp1jlzm_20260409215517A002.jpg', NULL, NULL, '2026-04-09 21:55:18');
INSERT INTO `file_asset` VALUES (14, 'SOURCE_VIDEO', 'WL.mp4', 'mp4', 'application/octet-stream', 3633750, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\09\\WL_20260409223345A001.mp4', '/profile/upload/polyp/source/2026/04/09/WL_20260409223345A001.mp4', NULL, NULL, '2026-04-09 22:33:46');
INSERT INTO `file_asset` VALUES (15, 'SOURCE_VIDEO', 'WL.mp4', 'mp4', 'video/mp4', 3633750, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\09\\WL_20260409225806A001.mp4', '/profile/upload/polyp/source/2026/04/09/WL_20260409225806A001.mp4', NULL, NULL, '2026-04-09 22:58:06');
INSERT INTO `file_asset` VALUES (16, 'SOURCE_VIDEO', 'WL.mp4', 'mp4', 'video/mp4', 3633750, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\09\\WL_20260409231331A001.mp4', '/profile/upload/polyp/source/2026/04/09/WL_20260409231331A001.mp4', NULL, NULL, '2026-04-09 23:13:31');
INSERT INTO `file_asset` VALUES (17, 'SOURCE_VIDEO', 'WL.mp4', 'mp4', 'video/mp4', 3633750, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\09\\WL_20260409232148A001.mp4', '/profile/upload/polyp/source/2026/04/09/WL_20260409232148A001.mp4', NULL, NULL, '2026-04-09 23:21:49');
INSERT INTO `file_asset` VALUES (18, 'SOURCE_VIDEO', 'WL.mp4', 'mp4', 'video/mp4', 3633750, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\10\\WL_20260410001742A001.mp4', '/profile/upload/polyp/source/2026/04/10/WL_20260410001742A001.mp4', NULL, NULL, '2026-04-10 00:17:42');
INSERT INTO `file_asset` VALUES (19, 'SOURCE_VIDEO', 'WL.mp4', 'mp4', 'video/mp4', 3633750, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\10\\WL_20260410002346A001.mp4', '/profile/upload/polyp/source/2026/04/10/WL_20260410002346A001.mp4', NULL, NULL, '2026-04-10 00:23:46');
INSERT INTO `file_asset` VALUES (20, 'SOURCE_VIDEO', 'WL.mp4', 'mp4', 'video/mp4', 3633750, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\10\\WL_20260410002606A001.mp4', '/profile/upload/polyp/source/2026/04/10/WL_20260410002606A001.mp4', NULL, NULL, '2026-04-10 00:26:07');
INSERT INTO `file_asset` VALUES (21, 'SOURCE_IMAGE', 'wlp.jpg', 'jpg', 'image/jpeg', 24904, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\10\\wlp_20260410010046A001.jpg', '/profile/upload/polyp/source/2026/04/10/wlp_20260410010046A001.jpg', NULL, NULL, '2026-04-10 01:00:46');
INSERT INTO `file_asset` VALUES (22, 'SOURCE_IMAGE', 'wlp.jpg', 'jpg', 'image/jpeg', 24904, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\10\\wlp_20260410010508A001.jpg', '/profile/upload/polyp/source/2026/04/10/wlp_20260410010508A001.jpg', NULL, NULL, '2026-04-10 01:05:09');
INSERT INTO `file_asset` VALUES (23, 'SOURCE_VIDEO', 'WL.mp4', 'mp4', 'video/mp4', 3633750, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\10\\WL_20260410010542A002.mp4', '/profile/upload/polyp/source/2026/04/10/WL_20260410010542A002.mp4', NULL, NULL, '2026-04-10 01:05:43');
INSERT INTO `file_asset` VALUES (24, 'SOURCE_VIDEO', 'WL.mp4', 'mp4', 'video/mp4', 3633750, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\10\\WL_20260410012936A003.mp4', '/profile/upload/polyp/source/2026/04/10/WL_20260410012936A003.mp4', NULL, NULL, '2026-04-10 01:29:37');
INSERT INTO `file_asset` VALUES (25, 'SOURCE_VIDEO', 'WL.mp4', 'mp4', 'video/mp4', 3633750, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\10\\WL_20260410015933A001.mp4', '/profile/upload/polyp/source/2026/04/10/WL_20260410015933A001.mp4', NULL, NULL, '2026-04-10 01:59:34');
INSERT INTO `file_asset` VALUES (26, 'SOURCE_IMAGE', 'wlp.jpg', 'jpg', 'image/jpeg', 24904, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\10\\wlp_20260410020051A002.jpg', '/profile/upload/polyp/source/2026/04/10/wlp_20260410020051A002.jpg', NULL, NULL, '2026-04-10 02:00:51');
INSERT INTO `file_asset` VALUES (27, 'SOURCE_VIDEO', 'WL.mp4', 'mp4', 'video/mp4', 3633750, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\10\\WL_20260410135613A001.mp4', '/profile/upload/polyp/source/2026/04/10/WL_20260410135613A001.mp4', NULL, NULL, '2026-04-10 13:56:13');
INSERT INTO `file_asset` VALUES (28, 'SOURCE_VIDEO', 'WL.mp4', 'mp4', 'video/mp4', 3633750, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\10\\WL_20260410140100A002.mp4', '/profile/upload/polyp/source/2026/04/10/WL_20260410140100A002.mp4', NULL, NULL, '2026-04-10 14:01:01');
INSERT INTO `file_asset` VALUES (29, 'SOURCE_VIDEO', 'WL.mp4', 'mp4', 'video/mp4', 3633750, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\10\\WL_20260410141313A003.mp4', '/profile/upload/polyp/source/2026/04/10/WL_20260410141313A003.mp4', NULL, NULL, '2026-04-10 14:13:14');
INSERT INTO `file_asset` VALUES (30, 'SOURCE_IMAGE', 'wlp.jpg', 'jpg', 'image/jpeg', 24904, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\10\\wlp_20260410141524A004.jpg', '/profile/upload/polyp/source/2026/04/10/wlp_20260410141524A004.jpg', NULL, NULL, '2026-04-10 14:15:25');
INSERT INTO `file_asset` VALUES (31, 'SOURCE_IMAGE', 'wlp.jpg', 'jpg', 'image/jpeg', 24904, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\10\\wlp_20260410144637A001.jpg', '/profile/upload/polyp/source/2026/04/10/wlp_20260410144637A001.jpg', NULL, NULL, '2026-04-10 14:46:38');
INSERT INTO `file_asset` VALUES (32, 'SOURCE_VIDEO', 'WL.mp4', 'mp4', 'video/mp4', 3633750, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\10\\WL_20260410144754A002.mp4', '/profile/upload/polyp/source/2026/04/10/WL_20260410144754A002.mp4', NULL, NULL, '2026-04-10 14:47:54');
INSERT INTO `file_asset` VALUES (33, 'SOURCE_VIDEO', 'WL.mp4', 'mp4', 'video/mp4', 3633750, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\10\\WL_20260410151756A003.mp4', '/profile/upload/polyp/source/2026/04/10/WL_20260410151756A003.mp4', NULL, NULL, '2026-04-10 15:17:57');
INSERT INTO `file_asset` VALUES (34, 'SOURCE_IMAGE', 'wlp.jpg', 'jpg', 'image/jpeg', 24904, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\10\\wlp_20260410151927A004.jpg', '/profile/upload/polyp/source/2026/04/10/wlp_20260410151927A004.jpg', NULL, NULL, '2026-04-10 15:19:28');
INSERT INTO `file_asset` VALUES (35, 'SOURCE_IMAGE', 'wlp.jpg', 'jpg', 'image/jpeg', 24904, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\10\\wlp_20260410153523A005.jpg', '/profile/upload/polyp/source/2026/04/10/wlp_20260410153523A005.jpg', NULL, NULL, '2026-04-10 15:35:23');
INSERT INTO `file_asset` VALUES (36, 'SOURCE_IMAGE', 'wlp.jpg', 'jpg', 'image/jpeg', 24904, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\10\\wlp_20260410190834A001.jpg', '/profile/upload/polyp/source/2026/04/10/wlp_20260410190834A001.jpg', NULL, NULL, '2026-04-10 19:08:34');
INSERT INTO `file_asset` VALUES (37, 'SOURCE_VIDEO', 'WL.mp4', 'mp4', 'video/mp4', 3633750, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\10\\WL_20260410190855A002.mp4', '/profile/upload/polyp/source/2026/04/10/WL_20260410190855A002.mp4', NULL, NULL, '2026-04-10 19:08:56');
INSERT INTO `file_asset` VALUES (38, 'SOURCE_IMAGE', 'wlp.jpg', 'jpg', 'image/jpeg', 24904, 'uploadPath\\upload\\polyp\\source\\2026\\04\\11\\wlp_20260411002502A001.jpg', '/profile/upload/polyp/source/2026/04/11/wlp_20260411002502A001.jpg', NULL, NULL, '2026-04-11 00:25:02');
INSERT INTO `file_asset` VALUES (39, 'SOURCE_IMAGE', 'wlp.jpg', 'jpg', 'image/jpeg', 24904, 'uploadPath\\upload\\polyp\\source\\2026\\04\\11\\wlp_20260411003113A001.jpg', '/profile/upload/polyp/source/2026/04/11/wlp_20260411003113A001.jpg', NULL, NULL, '2026-04-11 00:31:14');
INSERT INTO `file_asset` VALUES (40, 'SOURCE_IMAGE', 'wlp.jpg', 'jpg', 'image/jpeg', 24904, 'uploadPath\\upload\\polyp\\source\\2026\\04\\11\\wlp_20260411004416A002.jpg', '/profile/upload/polyp/source/2026/04/11/wlp_20260411004416A002.jpg', NULL, NULL, '2026-04-11 00:44:17');
INSERT INTO `file_asset` VALUES (41, 'SOURCE_IMAGE', 'wlp.jpg', 'jpg', 'image/jpeg', 24904, 'uploadPath\\upload\\polyp\\source\\2026\\04\\11\\wlp_20260411131847A001.jpg', '/profile/upload/polyp/source/2026/04/11/wlp_20260411131847A001.jpg', NULL, NULL, '2026-04-11 13:18:48');
INSERT INTO `file_asset` VALUES (42, 'SOURCE_VIDEO', 'WL.mp4', 'mp4', 'video/mp4', 3633750, 'uploadPath\\upload\\polyp\\source\\2026\\04\\11\\WL_20260411131908A002.mp4', '/profile/upload/polyp/source/2026/04/11/WL_20260411131908A002.mp4', NULL, NULL, '2026-04-11 13:19:08');
INSERT INTO `file_asset` VALUES (43, 'SOURCE_IMAGE', 'wlp.jpg', 'jpg', 'image/jpeg', 24904, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\11\\wlp_20260411182051A001.jpg', '/profile/upload/polyp/source/2026/04/11/wlp_20260411182051A001.jpg', NULL, NULL, '2026-04-11 18:20:52');
INSERT INTO `file_asset` VALUES (44, 'SOURCE_IMAGE', 'wlp.jpg', 'jpg', 'image/jpeg', 24904, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\11\\wlp_20260411211549A001.jpg', '/profile/upload/polyp/source/2026/04/11/wlp_20260411211549A001.jpg', NULL, NULL, '2026-04-11 21:15:49');
INSERT INTO `file_asset` VALUES (45, 'SOURCE_VIDEO', 'WL.mp4', 'mp4', 'video/mp4', 3633750, 'M:/0NUIST/class/bysj/Medical-platform-master/uploadPath\\upload\\polyp\\source\\2026\\04\\11\\WL_20260411211619A002.mp4', '/profile/upload/polyp/source/2026/04/11/WL_20260411211619A002.mp4', NULL, NULL, '2026-04-11 21:16:19');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------

-- ----------------------------
-- Table structure for his_detection_result
-- ----------------------------
DROP TABLE IF EXISTS `his_detection_result`;
CREATE TABLE `his_detection_result`  (
  `result_id` bigint NOT NULL AUTO_INCREMENT COMMENT '检测结果 ID',
  `pati_id` bigint NULL DEFAULT NULL COMMENT '患者 ID',
  `pati_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '患者姓名 (冗余)',
  `detection_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '检测类型 (0 图片检测 1 视频检测 2 实时检测)',
  `sample_number` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '样本编号',
  `original_file` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '原始文件路径',
  `result_file` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '结果文件路径',
  `polyp_count` int NULL DEFAULT 0 COMMENT '息肉数量',
  `max_size` decimal(10, 2) NULL DEFAULT NULL COMMENT '最大尺寸 (mm)',
  `min_size` decimal(10, 2) NULL DEFAULT NULL COMMENT '最小尺寸 (mm)',
  `avg_confidence` decimal(5, 2) NULL DEFAULT NULL COMMENT '平均置信度',
  `positions` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '息肉位置分布 (JSON)',
  `detection_time` datetime NULL DEFAULT NULL COMMENT '检测时间',
  `report_generated` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '是否已生成报告 (0 否 1 是)',
  `report_file` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '报告文件路径',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`result_id`) USING BTREE,
  INDEX `idx_pati_id`(`pati_id`) USING BTREE,
  INDEX `idx_detection_time`(`detection_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '检测结果表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of his_detection_result
-- ----------------------------
INSERT INTO `his_detection_result` VALUES (1, NULL, '', '0', 'PDT20260404000121878EF5', '/profile/upload\\polyp/source/2026/04/04/404_20260404000121A001.png', NULL, 1, 226.27, 226.27, 0.75, NULL, '2026-04-04 00:01:22', '0', NULL, '', '2026-04-04 00:01:22', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (2, NULL, '', '0', 'PDT202604040007101089B5', '/profile/upload/polyp/source/2026/04/04/404_20260404000710A001.png', NULL, 1, 226.27, 226.27, 0.69, NULL, '2026-04-04 00:07:11', '0', NULL, '', '2026-04-04 00:07:11', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (3, NULL, '', '0', 'PDT202604040013287C6AEE', '/profile/upload/polyp/source/2026/04/04/404_20260404001328A001.png', NULL, 1, 226.27, 226.27, 0.54, NULL, '2026-04-04 00:13:29', '0', NULL, '', '2026-04-04 00:13:29', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (4, NULL, '', '1', 'PDT20260409155411EF2FCD', '/profile/upload/polyp/source/2026/04/09/WL_20260409155410A001.mp4', NULL, 1, 325.27, 325.27, 0.70, NULL, '2026-04-09 15:54:14', '0', NULL, '', '2026-04-09 15:54:14', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (5, NULL, '', '0', 'PDT20260409164535B70C2F', '/profile/upload/polyp/source/2026/04/09/preview_train_white_20260409164534A001.jpg', NULL, 1, 557.38, 557.38, 0.70, NULL, '2026-04-09 16:45:36', '0', NULL, '', '2026-04-09 16:45:36', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (6, NULL, '', '1', 'PDT20260409171700F7D958', '/profile/upload/polyp/source/2026/04/09/WL_20260409171659A001.mp4', NULL, 1, 325.27, 325.27, 0.70, NULL, '2026-04-09 17:17:04', '0', NULL, '', '2026-04-09 17:17:04', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (7, NULL, '', '1', 'PDT20260409171805FED624', '/profile/upload/polyp/source/2026/04/09/WL_20260409171804A002.mp4', NULL, 1, 325.27, 325.27, 0.70, NULL, '2026-04-09 17:18:08', '0', NULL, '', '2026-04-09 17:18:08', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (8, NULL, '', '0', 'PDT20260409171831B39DA2', '/profile/upload/polyp/source/2026/04/09/preview_train_white_20260409171830A003.jpg', NULL, 1, 557.38, 557.38, 0.70, NULL, '2026-04-09 17:18:32', '0', NULL, '', '2026-04-09 17:18:32', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (9, NULL, '', '0', 'PDT20260409172818C9F266', '/profile/upload/polyp/source/2026/04/09/preview_train_white_20260409172818A004.jpg', NULL, 1, 557.38, 557.38, 0.70, NULL, '2026-04-09 17:28:20', '0', NULL, '', '2026-04-09 17:28:20', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (10, NULL, '', '1', 'PDT20260409172836BD5E60', '/profile/upload/polyp/source/2026/04/09/WL_20260409172836A005.mp4', NULL, 1, 325.27, 325.27, 0.70, NULL, '2026-04-09 17:28:40', '0', NULL, '', '2026-04-09 17:28:40', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (11, NULL, '', '0', 'PDT20260409173929710B7F', '/profile/upload/polyp/source/2026/04/09/cju1fuoa4wmc50835qfd11sp9_20260409173929A006.jpg', NULL, 1, 281.28, 281.28, 0.70, NULL, '2026-04-09 17:39:30', '0', NULL, '', '2026-04-09 17:39:30', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (12, NULL, '', '0', 'PDT20260409215450B50BBA', '/profile/upload/polyp/source/2026/04/09/cju1cvkfwqrec0993wbp1jlzm_20260409215450A001.jpg', NULL, 1, 202.47, 202.47, 0.82, NULL, '2026-04-09 21:54:52', '0', NULL, '', '2026-04-09 21:54:52', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (13, NULL, '', '0', 'PDT20260409215518086BD7', '/profile/upload/polyp/source/2026/04/09/cju1cvkfwqrec0993wbp1jlzm_20260409215517A002.jpg', NULL, 1, 202.47, 202.47, 0.82, NULL, '2026-04-09 21:55:19', '0', NULL, '', '2026-04-09 21:55:19', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (14, NULL, '', '1', 'PDT202604092258068A6E4E', '/profile/upload/polyp/source/2026/04/09/WL_20260409225806A001.mp4', NULL, 1, 242.26, 242.26, 0.85, NULL, '2026-04-09 22:58:13', '0', NULL, '', '2026-04-09 22:58:13', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (15, NULL, '', '1', 'PDT20260409231331FC97F1', '/profile/upload/polyp/source/2026/04/09/WL_20260409231331A001.mp4', NULL, 1, 242.26, 242.26, 0.85, NULL, '2026-04-09 23:13:38', '0', NULL, '', '2026-04-09 23:13:38', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (16, NULL, '', '1', 'PDT2026040923215342A517', '/profile/upload/polyp/source/2026/04/09/WL_20260409232148A001.mp4', NULL, 1, 242.26, 242.26, 0.85, NULL, '2026-04-09 23:21:58', '0', NULL, '', '2026-04-09 23:21:58', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (17, NULL, '', '1', 'PDT20260410001742E35663', '/profile/upload/polyp/source/2026/04/10/WL_20260410001742A001.mp4', NULL, 1, 249.63, 249.63, 0.87, NULL, '2026-04-10 00:17:59', '0', NULL, '', '2026-04-10 00:17:59', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (18, NULL, '', '1', 'PDT20260410002347F29202', '/profile/upload/polyp/source/2026/04/10/WL_20260410002346A001.mp4', NULL, 1, 249.63, 249.63, 0.87, NULL, '2026-04-10 00:24:00', '0', NULL, '', '2026-04-10 00:24:00', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (19, NULL, '', '1', 'PDT20260410002611FC2B2B', '/profile/upload/polyp/source/2026/04/10/WL_20260410002606A001.mp4', NULL, 1, 249.63, 249.63, 0.87, NULL, '2026-04-10 00:26:23', '0', NULL, '', '2026-04-10 00:26:23', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (20, NULL, '', '0', 'PDT2026041001004637C95A', '/profile/upload/polyp/source/2026/04/10/wlp_20260410010046A001.jpg', NULL, 1, 267.92, 267.92, 0.93, NULL, '2026-04-10 01:00:48', '0', NULL, '', '2026-04-10 01:00:48', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (21, NULL, '', '0', 'PDT2026041001050911A01E', '/profile/upload/polyp/source/2026/04/10/wlp_20260410010508A001.jpg', NULL, 1, 265.22, 265.22, 0.92, NULL, '2026-04-10 01:05:15', '0', NULL, '', '2026-04-10 01:05:15', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (22, NULL, '', '1', 'PDT202604100105466BD6C3', '/profile/upload/polyp/source/2026/04/10/WL_20260410010542A002.mp4', NULL, 1, 291.45, 291.45, 0.91, NULL, '2026-04-10 01:05:57', '0', NULL, '', '2026-04-10 01:05:57', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (23, NULL, '', '1', 'PDT20260410012941F84476', '/profile/upload/polyp/source/2026/04/10/WL_20260410012936A003.mp4', NULL, 1, 291.45, 291.45, 0.91, NULL, '2026-04-10 01:30:02', '0', NULL, '', '2026-04-10 01:30:02', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (24, NULL, '', '1', 'PDT202604100159376E4C39', '/profile/upload/polyp/source/2026/04/10/WL_20260410015933A001.mp4', NULL, 1, 291.45, 291.45, 0.91, NULL, '2026-04-10 02:00:00', '0', NULL, '', '2026-04-10 02:00:00', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (25, NULL, '', '0', 'PDT2026041002005186B8BF', '/profile/upload/polyp/source/2026/04/10/wlp_20260410020051A002.jpg', NULL, 1, 265.22, 265.22, 0.92, NULL, '2026-04-10 02:00:52', '0', NULL, '', '2026-04-10 02:00:52', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (26, NULL, '', '1', 'PDT20260410141318270A2E', '/profile/upload/polyp/source/2026/04/10/WL_20260410141313A003.mp4', NULL, 1, 291.45, 291.45, 0.91, NULL, '2026-04-10 14:13:42', '0', NULL, '', '2026-04-10 14:13:42', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (27, NULL, '', '0', 'PDT20260410141524DB2533', '/profile/upload/polyp/source/2026/04/10/wlp_20260410141524A004.jpg', NULL, 1, 265.22, 265.22, 0.92, NULL, '2026-04-10 14:15:26', '0', NULL, '', '2026-04-10 14:15:26', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (28, NULL, '', '0', 'PDT202604101446384DF3D6', '/profile/upload/polyp/source/2026/04/10/wlp_20260410144637A001.jpg', NULL, 1, 265.22, 265.22, 0.92, NULL, '2026-04-10 14:46:44', '0', NULL, '', '2026-04-10 14:46:44', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (29, NULL, '', '1', 'PDT20260410144758056681', '/profile/upload/polyp/source/2026/04/10/WL_20260410144754A002.mp4', NULL, 1, 291.45, 291.45, 0.91, NULL, '2026-04-10 14:48:17', '0', NULL, '', '2026-04-10 14:48:17', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (30, NULL, '', '1', 'PDT20260410151802F5F4AA', '/profile/upload/polyp/source/2026/04/10/WL_20260410151756A003.mp4', NULL, 1, 291.45, 291.45, 0.91, NULL, '2026-04-10 15:18:27', '0', NULL, '', '2026-04-10 15:18:27', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (31, NULL, '', '0', 'PDT20260410151928C70AE4', '/profile/upload/polyp/source/2026/04/10/wlp_20260410151927A004.jpg', NULL, 1, 265.22, 265.22, 0.92, NULL, '2026-04-10 15:19:29', '0', NULL, '', '2026-04-10 15:19:29', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (32, NULL, '', '0', 'PDT202604101535240B4EB5', '/profile/upload/polyp/source/2026/04/10/wlp_20260410153523A005.jpg', NULL, 1, 265.22, 265.22, 0.92, NULL, '2026-04-10 15:35:25', '0', NULL, '', '2026-04-10 15:35:25', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (33, NULL, '', '0', 'PDT20260410190834B0AEB8', '/profile/upload/polyp/source/2026/04/10/wlp_20260410190834A001.jpg', NULL, 1, 265.22, 265.22, 0.92, NULL, '2026-04-10 19:08:40', '0', NULL, '', '2026-04-10 19:08:40', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (34, NULL, '', '1', 'PDT2026041019085906158C', '/profile/upload/polyp/source/2026/04/10/WL_20260410190855A002.mp4', NULL, 1, 291.45, 291.45, 0.91, NULL, '2026-04-10 19:09:20', '0', NULL, '', '2026-04-10 19:09:20', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (35, NULL, '', '0', 'PDT2026041100311447685F', '/profile/upload/polyp/source/2026/04/11/wlp_20260411003113A001.jpg', NULL, 1, 265.22, 265.22, 0.92, NULL, '2026-04-11 00:31:15', '0', NULL, '', '2026-04-11 00:31:15', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (36, NULL, '', '0', 'PDT202604110044174BC3DC', '/profile/upload/polyp/source/2026/04/11/wlp_20260411004416A002.jpg', NULL, 1, 265.22, 265.22, 0.92, NULL, '2026-04-11 00:44:18', '0', NULL, '', '2026-04-11 00:44:18', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (37, NULL, '', '0', 'PDT20260411131847EF66FA', '/profile/upload/polyp/source/2026/04/11/wlp_20260411131847A001.jpg', NULL, 1, 265.22, 265.22, 0.92, NULL, '2026-04-11 13:18:54', '0', NULL, '', '2026-04-11 13:18:54', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (38, NULL, '', '1', 'PDT202604111319126316B3', '/profile/upload/polyp/source/2026/04/11/WL_20260411131908A002.mp4', NULL, 1, 291.45, 291.45, 0.91, NULL, '2026-04-11 13:19:33', '0', NULL, '', '2026-04-11 13:19:33', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (39, NULL, '', '0', 'PDT2026041118205220DC4E', '/profile/upload/polyp/source/2026/04/11/wlp_20260411182051A001.jpg', NULL, 1, 265.22, 265.22, 0.92, NULL, '2026-04-11 18:20:59', '0', NULL, '', '2026-04-11 18:20:59', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (40, NULL, '', '0', 'PDT20260411211549329F42', '/profile/upload/polyp/source/2026/04/11/wlp_20260411211549A001.jpg', 'https://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/image_20260411211555_aac9a66f.jpg', 1, 265.22, 265.22, 0.92, NULL, '2026-04-11 21:15:55', '0', NULL, '', '2026-04-11 21:15:55', '', NULL, NULL);
INSERT INTO `his_detection_result` VALUES (41, NULL, '', '1', 'PDT20260411211624567ADB', '/profile/upload/polyp/source/2026/04/11/WL_20260411211619A002.mp4', 'https://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260411211629_738d1d1b.mp4', 1, 291.45, 291.45, 0.91, NULL, '2026-04-11 21:16:45', '0', NULL, '', '2026-04-11 21:16:45', '', NULL, NULL);

-- ----------------------------
-- Table structure for his_patient
-- ----------------------------
DROP TABLE IF EXISTS `his_patient`;
CREATE TABLE `his_patient`  (
  `pati_id` bigint NOT NULL AUTO_INCREMENT COMMENT '患者 ID',
  `pati_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '患者姓名',
  `pati_code` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '病历号',
  `gender` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '性别 (0 男 1 女)',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `birthday` date NULL DEFAULT NULL COMMENT '出生日期',
  `phone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `id_card` varchar(18) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `address` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '联系地址',
  `allergy` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '过敏史',
  `medical_history` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '既往病史',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`pati_id`) USING BTREE,
  UNIQUE INDEX `uk_pati_code`(`pati_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '患者信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of his_patient
-- ----------------------------

-- ----------------------------
-- Table structure for his_polyp_detail
-- ----------------------------
DROP TABLE IF EXISTS `his_polyp_detail`;
CREATE TABLE `his_polyp_detail`  (
  `polyp_id` bigint NOT NULL AUTO_INCREMENT COMMENT '息肉 ID',
  `result_id` bigint NOT NULL COMMENT '检测结果 ID',
  `polyp_index` int NULL DEFAULT NULL COMMENT '息肉序号',
  `confidence` decimal(5, 2) NULL DEFAULT NULL COMMENT '置信度',
  `size_mm` decimal(10, 2) NULL DEFAULT NULL COMMENT '尺寸 (mm)',
  `position` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '位置',
  `bbox_x` int NULL DEFAULT NULL COMMENT '边界框 X 坐标',
  `bbox_y` int NULL DEFAULT NULL COMMENT '边界框 Y 坐标',
  `bbox_width` int NULL DEFAULT NULL COMMENT '边界框宽度',
  `bbox_height` int NULL DEFAULT NULL COMMENT '边界框高度',
  `classification` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '分类',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`polyp_id`) USING BTREE,
  INDEX `idx_result_id`(`result_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '息肉详情表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of his_polyp_detail
-- ----------------------------
INSERT INTO `his_polyp_detail` VALUES (1, 1, 1, 0.75, 226.27, 'x1=220,y1=140,x2=380,y2=300', 220, 140, 160, 160, 'polyp', '2026-04-04 00:01:22');
INSERT INTO `his_polyp_detail` VALUES (2, 2, 1, 0.69, 226.27, 'x1=220,y1=140,x2=380,y2=300', 220, 140, 160, 160, 'polyp', '2026-04-04 00:07:11');
INSERT INTO `his_polyp_detail` VALUES (3, 3, 1, 0.54, 226.27, 'x1=220,y1=140,x2=380,y2=300', 220, 140, 160, 160, 'polyp', '2026-04-04 00:13:29');
INSERT INTO `his_polyp_detail` VALUES (4, 4, 1, 0.70, 325.27, 'x1=192,y1=115,x2=422,y2=345', 192, 115, 230, 230, 'polyp', '2026-04-09 15:54:14');
INSERT INTO `his_polyp_detail` VALUES (5, 5, 1, 0.70, 557.38, 'x1=320,y1=202,x2=704,y2=606', 320, 202, 384, 404, 'polyp', '2026-04-09 16:45:36');
INSERT INTO `his_polyp_detail` VALUES (6, 6, 1, 0.70, 325.27, 'x1=192,y1=115,x2=422,y2=345', 192, 115, 230, 230, 'polyp', '2026-04-09 17:17:04');
INSERT INTO `his_polyp_detail` VALUES (7, 7, 1, 0.70, 325.27, 'x1=192,y1=115,x2=422,y2=345', 192, 115, 230, 230, 'polyp', '2026-04-09 17:18:08');
INSERT INTO `his_polyp_detail` VALUES (8, 8, 1, 0.70, 557.38, 'x1=320,y1=202,x2=704,y2=606', 320, 202, 384, 404, 'polyp', '2026-04-09 17:18:32');
INSERT INTO `his_polyp_detail` VALUES (9, 9, 1, 0.70, 557.38, 'x1=320,y1=202,x2=704,y2=606', 320, 202, 384, 404, 'polyp', '2026-04-09 17:28:20');
INSERT INTO `his_polyp_detail` VALUES (10, 10, 1, 0.70, 325.27, 'x1=192,y1=115,x2=422,y2=345', 192, 115, 230, 230, 'polyp', '2026-04-09 17:28:40');
INSERT INTO `his_polyp_detail` VALUES (11, 11, 1, 0.70, 281.28, 'x1=155,y1=105,x2=341,y2=316', 155, 105, 186, 211, 'polyp', '2026-04-09 17:39:30');
INSERT INTO `his_polyp_detail` VALUES (12, 12, 1, 0.82, 202.47, 'x1=239,y1=335,x2=389,y2=471', 239, 335, 150, 136, 'polyp', '2026-04-09 21:54:52');
INSERT INTO `his_polyp_detail` VALUES (13, 13, 1, 0.82, 202.47, 'x1=239,y1=335,x2=389,y2=471', 239, 335, 150, 136, 'polyp', '2026-04-09 21:55:19');
INSERT INTO `his_polyp_detail` VALUES (14, 14, 1, 0.85, 242.26, 'x1=199,y1=302,x2=396,y2=443', 199, 302, 197, 141, 'polyp', '2026-04-09 22:58:13');
INSERT INTO `his_polyp_detail` VALUES (15, 15, 1, 0.85, 242.26, 'x1=199,y1=302,x2=396,y2=443', 199, 302, 197, 141, 'polyp', '2026-04-09 23:13:38');
INSERT INTO `his_polyp_detail` VALUES (16, 16, 1, 0.85, 242.26, 'x1=199,y1=302,x2=396,y2=443', 199, 302, 197, 141, 'polyp', '2026-04-09 23:21:58');
INSERT INTO `his_polyp_detail` VALUES (17, 17, 1, 0.87, 249.63, 'x1=211,y1=266,x2=417,y2=407', 211, 266, 206, 141, 'polyp', '2026-04-10 00:17:59');
INSERT INTO `his_polyp_detail` VALUES (18, 18, 1, 0.87, 249.63, 'x1=211,y1=266,x2=417,y2=407', 211, 266, 206, 141, 'polyp', '2026-04-10 00:24:00');
INSERT INTO `his_polyp_detail` VALUES (19, 19, 1, 0.87, 249.63, 'x1=211,y1=266,x2=417,y2=407', 211, 266, 206, 141, 'polyp', '2026-04-10 00:26:23');
INSERT INTO `his_polyp_detail` VALUES (20, 20, 1, 0.93, 267.92, 'x1=279,y1=139,x2=413,y2=371', 279, 139, 134, 232, 'polyp', '2026-04-10 01:00:48');
INSERT INTO `his_polyp_detail` VALUES (21, 21, 1, 0.92, 265.22, 'x1=277,y1=142,x2=419,y2=366', 277, 142, 142, 224, 'polyp', '2026-04-10 01:05:15');
INSERT INTO `his_polyp_detail` VALUES (22, 22, 1, 0.91, 291.45, 'x1=131,y1=310,x2=352,y2=500', 131, 310, 221, 190, 'polyp', '2026-04-10 01:05:57');
INSERT INTO `his_polyp_detail` VALUES (23, 23, 1, 0.91, 291.45, 'x1=131,y1=310,x2=352,y2=500', 131, 310, 221, 190, 'polyp', '2026-04-10 01:30:02');
INSERT INTO `his_polyp_detail` VALUES (24, 24, 1, 0.91, 291.45, 'x1=131,y1=310,x2=352,y2=500', 131, 310, 221, 190, 'polyp', '2026-04-10 02:00:00');
INSERT INTO `his_polyp_detail` VALUES (25, 25, 1, 0.92, 265.22, 'x1=277,y1=142,x2=419,y2=366', 277, 142, 142, 224, 'polyp', '2026-04-10 02:00:52');
INSERT INTO `his_polyp_detail` VALUES (26, 26, 1, 0.91, 291.45, 'x1=131,y1=310,x2=352,y2=500', 131, 310, 221, 190, 'polyp', '2026-04-10 14:13:43');
INSERT INTO `his_polyp_detail` VALUES (27, 27, 1, 0.92, 265.22, 'x1=277,y1=142,x2=419,y2=366', 277, 142, 142, 224, 'polyp', '2026-04-10 14:15:26');
INSERT INTO `his_polyp_detail` VALUES (28, 28, 1, 0.92, 265.22, 'x1=277,y1=142,x2=419,y2=366', 277, 142, 142, 224, 'polyp', '2026-04-10 14:46:44');
INSERT INTO `his_polyp_detail` VALUES (29, 29, 1, 0.91, 291.45, 'x1=131,y1=310,x2=352,y2=500', 131, 310, 221, 190, 'polyp', '2026-04-10 14:48:17');
INSERT INTO `his_polyp_detail` VALUES (30, 30, 1, 0.91, 291.45, 'x1=131,y1=310,x2=352,y2=500', 131, 310, 221, 190, 'polyp', '2026-04-10 15:18:27');
INSERT INTO `his_polyp_detail` VALUES (31, 31, 1, 0.92, 265.22, 'x1=277,y1=142,x2=419,y2=366', 277, 142, 142, 224, 'polyp', '2026-04-10 15:19:29');
INSERT INTO `his_polyp_detail` VALUES (32, 32, 1, 0.92, 265.22, 'x1=277,y1=142,x2=419,y2=366', 277, 142, 142, 224, 'polyp', '2026-04-10 15:35:25');
INSERT INTO `his_polyp_detail` VALUES (33, 33, 1, 0.92, 265.22, 'x1=277,y1=142,x2=419,y2=366', 277, 142, 142, 224, 'polyp', '2026-04-10 19:08:40');
INSERT INTO `his_polyp_detail` VALUES (34, 34, 1, 0.91, 291.45, 'x1=131,y1=310,x2=352,y2=500', 131, 310, 221, 190, 'polyp', '2026-04-10 19:09:20');
INSERT INTO `his_polyp_detail` VALUES (35, 35, 1, 0.92, 265.22, 'x1=277,y1=142,x2=419,y2=366', 277, 142, 142, 224, 'polyp', '2026-04-11 00:31:15');
INSERT INTO `his_polyp_detail` VALUES (36, 36, 1, 0.92, 265.22, 'x1=277,y1=142,x2=419,y2=366', 277, 142, 142, 224, 'polyp', '2026-04-11 00:44:18');
INSERT INTO `his_polyp_detail` VALUES (37, 37, 1, 0.92, 265.22, 'x1=277,y1=142,x2=419,y2=366', 277, 142, 142, 224, 'polyp', '2026-04-11 13:18:54');
INSERT INTO `his_polyp_detail` VALUES (38, 38, 1, 0.91, 291.45, 'x1=131,y1=310,x2=352,y2=500', 131, 310, 221, 190, 'polyp', '2026-04-11 13:19:33');
INSERT INTO `his_polyp_detail` VALUES (39, 39, 1, 0.92, 265.22, 'x1=277,y1=142,x2=419,y2=366', 277, 142, 142, 224, 'polyp', '2026-04-11 18:20:59');
INSERT INTO `his_polyp_detail` VALUES (40, 40, 1, 0.92, 265.22, 'x1=277,y1=142,x2=419,y2=366', 277, 142, 142, 224, 'polyp', '2026-04-11 21:15:55');
INSERT INTO `his_polyp_detail` VALUES (41, 41, 1, 0.91, 291.45, 'x1=131,y1=310,x2=352,y2=500', 131, 310, 221, 190, 'polyp', '2026-04-11 21:16:45');

-- ----------------------------
-- Table structure for his_reg
-- ----------------------------
DROP TABLE IF EXISTS `his_reg`;
CREATE TABLE `his_reg`  (
  `reg_id` bigint NOT NULL AUTO_INCREMENT COMMENT '挂单号',
  `pati_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '患者姓名',
  `reg_card_num` varchar(18) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '身份证号',
  `reg_depts` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '挂号科室',
  `reg_docter` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '接诊医生',
  `reg_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '挂号费用',
  `reg_num` int NULL DEFAULT NULL COMMENT '流水编号',
  `reg_status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '状态（0 待就诊 1 已就诊 2 已取消）',
  `reg_sdate` date NULL DEFAULT NULL COMMENT '就诊日期',
  `reg_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '挂号类型（0 普通 1 专家）',
  `reg_time` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '挂号时段',
  `reg_rdate` date NULL DEFAULT NULL COMMENT '挂号时间',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`reg_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '挂号表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of his_reg
-- ----------------------------

-- ----------------------------
-- Table structure for med_case
-- ----------------------------
DROP TABLE IF EXISTS `med_case`;
CREATE TABLE `med_case`  (
  `case_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '病例单号----caseId',
  `reg_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '挂单号ID----regId',
  `case_date` date NOT NULL COMMENT '发病日期----caseDate',
  `pati_code` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '患者身份证号----patiCode',
  `case_type` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '接诊类型----caseType',
  `case_contagion` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否传染----caseContagion',
  `case_complaint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '主诉-----caseComplaint',
  `case_daig_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '诊断信息----caseDaigInfo',
  `case_advise` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '医生建议----caseAdvise',
  `case_remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注----caseRemarks',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者---createBy',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间--createTime',
  `update_by` varbinary(255) NULL DEFAULT NULL COMMENT '更新者----updateBy',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间--updateTime'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of med_case
-- ----------------------------

-- ----------------------------
-- Table structure for med_case_check
-- ----------------------------
DROP TABLE IF EXISTS `med_case_check`;
CREATE TABLE `med_case_check`  (
  `case_id` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '病例单号----caseId',
  `reg_id` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '挂单号ID----regId',
  `pati_code` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '患者身份证号----patiCode',
  `check_id` int NOT NULL AUTO_INCREMENT COMMENT '检查序号----checkId',
  `exam_id` int NOT NULL COMMENT '检查项目ID---examId',
  `check_remark` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '检查备注-----checkRemark',
  `create_by` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '创建者---createBy',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间--createTime',
  `update_by` varbinary(255) NULL DEFAULT NULL COMMENT '更新者----updateBy',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间--updateTime',
  PRIMARY KEY (`check_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of med_case_check
-- ----------------------------

-- ----------------------------
-- Table structure for med_case_medical
-- ----------------------------
DROP TABLE IF EXISTS `med_case_medical`;
CREATE TABLE `med_case_medical`  (
  `case_id` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '病例单号----caseId',
  `reg_id` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '挂单号ID----regId',
  `pati_code` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '患者身份证号----patiCode',
  `medical_id` int NOT NULL AUTO_INCREMENT COMMENT '药用序号----medicalId',
  `drug_id` int NOT NULL COMMENT '药品Id----drugId',
  `medical_num` int NULL DEFAULT NULL COMMENT '数量---medicalNum',
  `medical_price` double(10, 3) NULL DEFAULT NULL COMMENT '金额-----medicalPrice',
  `medical_remark` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '服用备注---medicalRemark',
  `pay_status` int NULL DEFAULT NULL COMMENT '支付状态',
  `create_by` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '创建者---createBy',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间--createTime',
  `update_by` varbinary(255) NULL DEFAULT NULL COMMENT '更新者----updateBy',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间--updateTime',
  PRIMARY KEY (`medical_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of med_case_medical
-- ----------------------------

-- ----------------------------
-- Table structure for med_pati
-- ----------------------------
DROP TABLE IF EXISTS `med_pati`;
CREATE TABLE `med_pati`  (
  `pati_id` int NOT NULL AUTO_INCREMENT COMMENT '患者编号----patiId',
  `pati_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '患者名称----patiName',
  `pati_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '患者身份证--patiCode',
  `pati_phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '患者电话----patiPhone',
  `pati_birthday` datetime NULL DEFAULT NULL COMMENT '患者生日----patiBirthday',
  `pati_age` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '患者年龄----patiAge',
  `pati_sex` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '患者性别----patiSex',
  `pati_address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '患者住址----patiAddress',
  `pati_allergy` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '患者过敏史--patiAllergy',
  `status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '信息状态  status',
  `create_by` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '创建者---createBy',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间--createTime',
  `update_by` varbinary(255) NULL DEFAULT NULL COMMENT '更新者----updateBy',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间--updateTime',
  `remark` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注------remark',
  PRIMARY KEY (`pati_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of med_pati
-- ----------------------------

-- ----------------------------
-- Table structure for med_reg
-- ----------------------------
DROP TABLE IF EXISTS `med_reg`;
CREATE TABLE `med_reg`  (
  `reg_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '挂单号ID----regId',
  `pati_name` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '患者姓名----patiName',
  `reg_depts` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '挂号科室----regDepts',
  `reg_docter` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接诊医生-----regDocter',
  `reg_price` double(10, 3) NOT NULL COMMENT '挂号费用----regPrice',
  `reg_num` int NOT NULL COMMENT '流水编号（当前号数+1）----regNum',
  `reg_status` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态----regStatus',
  `reg_sdate` date NULL DEFAULT NULL COMMENT '就诊日期---- regSdate',
  `reg_type` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '挂号类型----regType',
  `reg_time` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '挂号时段----regTime',
  `reg_rdate` date NOT NULL COMMENT '挂号时间----regRdate',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者---createBy',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间--createTime',
  `update_by` varbinary(255) NULL DEFAULT NULL COMMENT '更新者----updateBy',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间--updateTime'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of med_reg
-- ----------------------------

-- ----------------------------
-- Table structure for polyp_detect_task
-- ----------------------------
DROP TABLE IF EXISTS `polyp_detect_task`;
CREATE TABLE `polyp_detect_task`  (
  `task_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `task_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务编号',
  `patient_id` bigint NULL DEFAULT NULL COMMENT '患者ID(可空)',
  `source_file_id` bigint NOT NULL COMMENT '原图文件ID(file_asset.file_id)',
  `media_type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'media type: image/video',
  `model_id` bigint NOT NULL COMMENT '模型ID(polyp_model.model_id)',
  `status` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务状态：PENDING/RUNNING/SUCCESS/FAILED',
  `conf_threshold` decimal(5, 4) NULL DEFAULT NULL COMMENT '本次任务阈值',
  `result_id` bigint NULL DEFAULT NULL COMMENT '检测结果ID(复用his_detection_result.result_id)',
  `inference_ms` bigint NULL DEFAULT NULL COMMENT '推理耗时(ms)',
  `error_msg` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '失败原因',
  `result_image_url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'result image url',
  `result_video_url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'result video url',
  `result_frames_url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'result frames json url',
  `frame_count` int NULL DEFAULT NULL COMMENT 'total frame count',
  `detected_frame_count` int NULL DEFAULT NULL COMMENT 'detected frame count',
  `box_count` int NULL DEFAULT NULL COMMENT 'total detection boxes',
  `max_confidence` decimal(10, 6) NULL DEFAULT NULL COMMENT 'max confidence',
  `start_time` datetime NULL DEFAULT NULL COMMENT '开始时间',
  `finish_time` datetime NULL DEFAULT NULL COMMENT '结束时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '推理摘要与扩展信息',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'logical delete: 0 active, 1 deleted',
  PRIMARY KEY (`task_id`) USING BTREE,
  UNIQUE INDEX `uk_task_no`(`task_no`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE,
  INDEX `idx_source_file_id`(`source_file_id`) USING BTREE,
  INDEX `idx_model_id`(`model_id`) USING BTREE,
  INDEX `idx_polyp_task_is_deleted`(`is_deleted`) USING BTREE,
  INDEX `idx_polyp_task_media_type`(`media_type`) USING BTREE,
  INDEX `idx_polyp_task_create_time`(`create_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '息肉检测任务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of polyp_detect_task
-- ----------------------------
INSERT INTO `polyp_detect_task` VALUES (1, 'PDT20260404000121878EF5', NULL, 1, NULL, 1, 'SUCCESS', 0.5000, 1, 56, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-04 00:01:22', '2026-04-04 00:01:22', NULL, '2026-04-04 00:01:22', '', '2026-04-04 00:01:22', NULL, 0);
INSERT INTO `polyp_detect_task` VALUES (2, 'PDT202604040007101089B5', NULL, 2, NULL, 1, 'SUCCESS', 0.5000, 2, 59, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-04 00:07:11', '2026-04-04 00:07:11', NULL, '2026-04-04 00:07:11', '', '2026-04-04 00:07:11', NULL, 0);
INSERT INTO `polyp_detect_task` VALUES (3, 'PDT202604040013287C6AEE', NULL, 3, NULL, 1, 'SUCCESS', 0.5000, 3, 54, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-04 00:13:29', '2026-04-04 00:13:29', NULL, '2026-04-04 00:13:28', '', '2026-04-04 00:13:29', NULL, 0);
INSERT INTO `polyp_detect_task` VALUES (4, 'PDT20260409155411EF2FCD', NULL, 4, NULL, 1, 'SUCCESS', 0.5000, 4, 460, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-09 15:54:11', '2026-04-09 15:54:14', NULL, '2026-04-09 15:54:11', '', '2026-04-09 15:54:14', '{\"imageWidth\":768,\"frameCount\":701,\"maxConfidence\":0.7,\"boxCount\":1,\"detectedFrameCount\":141,\"inferenceMs\":460,\"fileType\":\"video\",\"imageHeight\":576}', 0);
INSERT INTO `polyp_detect_task` VALUES (5, 'PDT20260409164535B70C2F', NULL, 5, NULL, 1, 'SUCCESS', 0.5000, 5, 41, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-09 16:45:35', '2026-04-09 16:45:36', NULL, '2026-04-09 16:45:35', '', '2026-04-09 16:45:36', '{\"imageWidth\":1280,\"frameCount\":1,\"maxConfidence\":0.7,\"representativeBoxes\":[{\"x1\":320,\"y1\":202,\"x2\":704,\"y2\":606,\"score\":0.7,\"class_name\":\"polyp\"}],\"boxCount\":1,\"frames\":[],\"fps\":null,\"detectedFrameCount\":1,\"inferenceMs\":41,\"fileType\":\"image\",\"imageHeight\":1010}', 0);
INSERT INTO `polyp_detect_task` VALUES (6, 'PDT20260409171700F7D958', NULL, 6, NULL, 1, 'RUNNING', 0.5000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-09 17:17:00', NULL, NULL, '2026-04-09 17:17:00', '', '2026-04-09 17:17:00', NULL, 0);
INSERT INTO `polyp_detect_task` VALUES (7, 'PDT20260409171805FED624', NULL, 7, NULL, 1, 'RUNNING', 0.5000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-09 17:18:05', NULL, NULL, '2026-04-09 17:18:05', '', '2026-04-09 17:18:05', NULL, 0);
INSERT INTO `polyp_detect_task` VALUES (8, 'PDT20260409171831B39DA2', NULL, 8, NULL, 1, 'SUCCESS', 0.5000, 8, 31, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-09 17:18:31', '2026-04-09 17:18:32', NULL, '2026-04-09 17:18:31', '', '2026-04-09 17:18:32', '{\"imageWidth\":1280,\"frameCount\":1,\"maxConfidence\":0.7,\"representativeBoxes\":[{\"x1\":320,\"y1\":202,\"x2\":704,\"y2\":606,\"score\":0.7,\"class_name\":\"polyp\"}],\"boxCount\":1,\"frames\":[],\"fps\":null,\"detectedFrameCount\":1,\"inferenceMs\":31,\"fileType\":\"image\",\"imageHeight\":1010}', 0);
INSERT INTO `polyp_detect_task` VALUES (9, 'PDT20260409172818C9F266', NULL, 9, NULL, 1, 'SUCCESS', 0.5000, 9, 38, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-09 17:28:19', '2026-04-09 17:28:20', NULL, '2026-04-09 17:28:19', '', '2026-04-09 17:28:20', '{\"imageWidth\":1280,\"frameCount\":1,\"maxConfidence\":0.7,\"representativeBoxes\":[{\"x1\":320,\"y1\":202,\"x2\":704,\"y2\":606,\"score\":0.7,\"class_name\":\"polyp\"}],\"boxCount\":1,\"frames\":[],\"fps\":null,\"detectedFrameCount\":1,\"inferenceMs\":38,\"fileType\":\"image\",\"imageHeight\":1010}', 0);
INSERT INTO `polyp_detect_task` VALUES (10, 'PDT20260409172836BD5E60', NULL, 10, NULL, 1, 'SUCCESS', 0.5000, 10, 420, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-09 17:28:37', '2026-04-09 17:28:40', NULL, '2026-04-09 17:28:37', '', '2026-04-09 17:28:40', '{\"imageWidth\":768,\"frameCount\":701,\"maxConfidence\":0.7,\"representativeBoxes\":[{\"x1\":192,\"y1\":115,\"x2\":422,\"y2\":345,\"score\":0.7,\"class_name\":\"polyp\"}],\"boxCount\":1,\"frames\":[{\"boxes\":[],\"frame_index\":0,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":5,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":10,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":15,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":20,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":25,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":30,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":35,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":40,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":45,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":50,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":55,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":60,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":65,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":70,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":75,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":80,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":85,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":90,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":95,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":100,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":105,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":110,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":115,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":120,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":125,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":130,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":135,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":140,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7},{\"boxes\":[],\"frame_index\":145,\"timestamp_sec\":null,\"box_count\":1,\"max_confidence\":0.7}],\"fps\":null,\"detectedFrameCount\":141,\"inferenceMs\":420,\"fileType\":\"video\",\"imageHeight\":576}', 0);
INSERT INTO `polyp_detect_task` VALUES (11, 'PDT20260409173929710B7F', NULL, 11, NULL, 1, 'SUCCESS', 0.5000, 11, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-09 17:39:30', '2026-04-09 17:39:30', NULL, '2026-04-09 17:39:30', '', '2026-04-09 17:39:30', '{\"imageWidth\":621,\"frameCount\":1,\"maxConfidence\":0.7,\"representativeBoxes\":[{\"x1\":155,\"y1\":105,\"x2\":341,\"y2\":316,\"score\":0.7,\"class_name\":\"polyp\"}],\"boxCount\":1,\"frames\":[],\"fps\":null,\"detectedFrameCount\":1,\"inferenceMs\":6,\"fileType\":\"image\",\"imageHeight\":528}', 0);
INSERT INTO `polyp_detect_task` VALUES (12, 'PDT20260409215450B50BBA', NULL, 12, NULL, 1, 'SUCCESS', 0.5000, 12, 58, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-09 21:54:51', '2026-04-09 21:54:52', NULL, '2026-04-09 21:54:51', '', '2026-04-09 21:54:52', '{\"imageWidth\":622,\"maxConfidence\":0.823371,\"frames\":[],\"fps\":0.0,\"inferenceMs\":58,\"imageHeight\":531,\"resultVideoUrl\":\"\",\"frameCount\":1,\"representativeBoxes\":[{\"x1\":239,\"y1\":335,\"x2\":389,\"y2\":471,\"score\":0.823371,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"\",\"detectedFrameCount\":1,\"fileType\":\"image\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (13, 'PDT20260409215518086BD7', NULL, 13, NULL, 1, 'SUCCESS', 0.5000, 13, 37, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-09 21:55:18', '2026-04-09 21:55:19', NULL, '2026-04-09 21:55:18', '', '2026-04-09 21:55:19', '{\"imageWidth\":622,\"maxConfidence\":0.823371,\"frames\":[],\"fps\":0.0,\"inferenceMs\":37,\"imageHeight\":531,\"resultVideoUrl\":\"\",\"frameCount\":1,\"representativeBoxes\":[{\"x1\":239,\"y1\":335,\"x2\":389,\"y2\":471,\"score\":0.823371,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"\",\"detectedFrameCount\":1,\"fileType\":\"image\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (14, 'PDT202604092258068A6E4E', NULL, 15, NULL, 1, 'SUCCESS', 0.5000, 14, 2128, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-09 22:58:07', '2026-04-09 22:58:13', NULL, '2026-04-09 22:58:07', '', '2026-04-09 22:58:13', '{\"imageWidth\":768,\"maxConfidence\":0.849007,\"frames\":[{\"boxes\":[],\"frame_index\":0,\"timestamp_sec\":0.0,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":5,\"timestamp_sec\":0.2,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":10,\"timestamp_sec\":0.4,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":15,\"timestamp_sec\":0.6,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":20,\"timestamp_sec\":0.8,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":25,\"timestamp_sec\":1.0,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":30,\"timestamp_sec\":1.2,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":35,\"timestamp_sec\":1.4,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":40,\"timestamp_sec\":1.6,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":45,\"timestamp_sec\":1.8,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":50,\"timestamp_sec\":2.0,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":55,\"timestamp_sec\":2.2,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":60,\"timestamp_sec\":2.4,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":65,\"timestamp_sec\":2.6,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":70,\"timestamp_sec\":2.8,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":75,\"timestamp_sec\":3.0,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":80,\"timestamp_sec\":3.2,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":85,\"timestamp_sec\":3.4,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":90,\"timestamp_sec\":3.6,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":95,\"timestamp_sec\":3.8,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":100,\"timestamp_sec\":4.0,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":105,\"timestamp_sec\":4.2,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":110,\"timestamp_sec\":4.4,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":115,\"timestamp_sec\":4.6,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":120,\"timestamp_sec\":4.8,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":125,\"timestamp_sec\":5.0,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":130,\"timestamp_sec\":5.2,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":135,\"timestamp_sec\":5.4,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":140,\"timestamp_sec\":5.6,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":145,\"timestamp_sec\":5.8,\"box_count\":0,\"max_confidence\":0.0}],\"fps\":25.0,\"inferenceMs\":2128,\"imageHeight\":576,\"resultVideoUrl\":\"\",\"frameCount\":701,\"representativeBoxes\":[{\"x1\":199,\"y1\":302,\"x2\":396,\"y2\":443,\"score\":0.849007,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"\",\"detectedFrameCount\":3,\"fileType\":\"video\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (15, 'PDT20260409231331FC97F1', NULL, 16, NULL, 1, 'SUCCESS', 0.5000, 15, 1998, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-09 23:13:32', '2026-04-09 23:13:38', NULL, '2026-04-09 23:13:32', '', '2026-04-09 23:13:38', '{\"imageWidth\":768,\"maxConfidence\":0.849007,\"frames\":[{\"boxes\":[],\"frame_index\":0,\"timestamp_sec\":0.0,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":5,\"timestamp_sec\":0.2,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":10,\"timestamp_sec\":0.4,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":15,\"timestamp_sec\":0.6,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":20,\"timestamp_sec\":0.8,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":25,\"timestamp_sec\":1.0,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":30,\"timestamp_sec\":1.2,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":35,\"timestamp_sec\":1.4,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":40,\"timestamp_sec\":1.6,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":45,\"timestamp_sec\":1.8,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":50,\"timestamp_sec\":2.0,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":55,\"timestamp_sec\":2.2,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":60,\"timestamp_sec\":2.4,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":65,\"timestamp_sec\":2.6,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":70,\"timestamp_sec\":2.8,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":75,\"timestamp_sec\":3.0,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":80,\"timestamp_sec\":3.2,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":85,\"timestamp_sec\":3.4,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":90,\"timestamp_sec\":3.6,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":95,\"timestamp_sec\":3.8,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":100,\"timestamp_sec\":4.0,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":105,\"timestamp_sec\":4.2,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":110,\"timestamp_sec\":4.4,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":115,\"timestamp_sec\":4.6,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":120,\"timestamp_sec\":4.8,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":125,\"timestamp_sec\":5.0,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":130,\"timestamp_sec\":5.2,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":135,\"timestamp_sec\":5.4,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":140,\"timestamp_sec\":5.6,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":145,\"timestamp_sec\":5.8,\"box_count\":0,\"max_confidence\":0.0}],\"fps\":25.0,\"inferenceMs\":1998,\"imageHeight\":576,\"resultVideoUrl\":\"\",\"frameCount\":701,\"representativeBoxes\":[{\"x1\":199,\"y1\":302,\"x2\":396,\"y2\":443,\"score\":0.849007,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"\",\"detectedFrameCount\":3,\"fileType\":\"video\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (16, 'PDT2026040923215342A517', NULL, 17, NULL, 1, 'SUCCESS', 0.5000, 16, 1965, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-09 23:21:53', '2026-04-09 23:21:58', NULL, '2026-04-09 23:21:53', '', '2026-04-09 23:21:58', '{\"imageWidth\":768,\"maxConfidence\":0.849007,\"frames\":[{\"boxes\":[],\"frame_index\":0,\"timestamp_sec\":0.0,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":5,\"timestamp_sec\":0.2,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":10,\"timestamp_sec\":0.4,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":15,\"timestamp_sec\":0.6,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":20,\"timestamp_sec\":0.8,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":25,\"timestamp_sec\":1.0,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":30,\"timestamp_sec\":1.2,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":35,\"timestamp_sec\":1.4,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":40,\"timestamp_sec\":1.6,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":45,\"timestamp_sec\":1.8,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":50,\"timestamp_sec\":2.0,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":55,\"timestamp_sec\":2.2,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":60,\"timestamp_sec\":2.4,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":65,\"timestamp_sec\":2.6,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":70,\"timestamp_sec\":2.8,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":75,\"timestamp_sec\":3.0,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":80,\"timestamp_sec\":3.2,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":85,\"timestamp_sec\":3.4,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":90,\"timestamp_sec\":3.6,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":95,\"timestamp_sec\":3.8,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":100,\"timestamp_sec\":4.0,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":105,\"timestamp_sec\":4.2,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":110,\"timestamp_sec\":4.4,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":115,\"timestamp_sec\":4.6,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":120,\"timestamp_sec\":4.8,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":125,\"timestamp_sec\":5.0,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":130,\"timestamp_sec\":5.2,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":135,\"timestamp_sec\":5.4,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":140,\"timestamp_sec\":5.6,\"box_count\":0,\"max_confidence\":0.0},{\"boxes\":[],\"frame_index\":145,\"timestamp_sec\":5.8,\"box_count\":0,\"max_confidence\":0.0}],\"fps\":25.0,\"inferenceMs\":1965,\"imageHeight\":576,\"resultVideoUrl\":\"/profile/upload/polyp/source/2026/04/09/WL_20260409232148A001_web.mp4\",\"frameCount\":701,\"representativeBoxes\":[{\"x1\":199,\"y1\":302,\"x2\":396,\"y2\":443,\"score\":0.849007,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"\",\"detectedFrameCount\":3,\"fileType\":\"video\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (17, 'PDT20260410001742E35663', NULL, 18, NULL, 1, 'SUCCESS', 0.5000, 17, 6551, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-10 00:17:43', '2026-04-10 00:17:59', NULL, '2026-04-10 00:17:43', '', '2026-04-10 00:17:59', '{\"imageWidth\":768,\"maxConfidence\":0.866281,\"fps\":25.0,\"inferenceMs\":6551,\"imageHeight\":576,\"resultFramesUrl\":\"http://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260410001753_e7742f7c_frames.json\",\"resultVideoUrl\":\"http://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260410001753_e7742f7c_raw.mp4\",\"frameCount\":701,\"representativeBoxes\":[{\"x1\":211,\"y1\":266,\"x2\":417,\"y2\":407,\"score\":0.866281,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"\",\"detectedFrameCount\":15,\"fileType\":\"video\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (18, 'PDT20260410002347F29202', NULL, 19, NULL, 1, 'SUCCESS', 0.5000, 18, 7917, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-10 00:23:47', '2026-04-10 00:24:01', NULL, '2026-04-10 00:23:47', '', '2026-04-10 00:24:01', '{\"imageWidth\":768,\"maxConfidence\":0.866281,\"fps\":25.0,\"inferenceMs\":7917,\"imageHeight\":576,\"resultFramesUrl\":\"http://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260410002353_40840ba7_frames.json\",\"resultVideoUrl\":\"http://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260410002353_40840ba7_raw.mp4\",\"frameCount\":701,\"representativeBoxes\":[{\"x1\":211,\"y1\":266,\"x2\":417,\"y2\":407,\"score\":0.866281,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"\",\"detectedFrameCount\":15,\"fileType\":\"video\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (19, 'PDT20260410002611FC2B2B', NULL, 20, NULL, 1, 'SUCCESS', 0.5000, 19, 7504, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-10 00:26:11', '2026-04-10 00:26:24', NULL, '2026-04-10 00:26:11', '', '2026-04-10 00:26:24', '{\"imageWidth\":768,\"maxConfidence\":0.866281,\"fps\":25.0,\"inferenceMs\":7504,\"imageHeight\":576,\"resultFramesUrl\":\"http://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260410002617_f6cd2b2c_frames.json\",\"resultVideoUrl\":\"http://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260410002617_f6cd2b2c_raw.mp4\",\"frameCount\":701,\"representativeBoxes\":[{\"x1\":211,\"y1\":266,\"x2\":417,\"y2\":407,\"score\":0.866281,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"\",\"detectedFrameCount\":15,\"fileType\":\"video\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (20, 'PDT2026041001004637C95A', NULL, 21, NULL, 1, 'SUCCESS', 0.5000, 20, 137, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-10 01:00:47', '2026-04-10 01:00:48', NULL, '2026-04-10 01:00:47', '', '2026-04-10 01:00:48', '{\"imageWidth\":549,\"maxConfidence\":0.931596,\"fps\":0.0,\"inferenceMs\":137,\"imageHeight\":530,\"resultFramesUrl\":\"\",\"resultVideoUrl\":\"\",\"frameCount\":1,\"representativeBoxes\":[{\"x1\":279,\"y1\":139,\"x2\":413,\"y2\":371,\"score\":0.931596,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"\",\"detectedFrameCount\":1,\"fileType\":\"image\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (21, 'PDT2026041001050911A01E', NULL, 22, NULL, 1, 'SUCCESS', 0.5000, 21, 233, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-10 01:05:09', '2026-04-10 01:05:15', NULL, '2026-04-10 01:05:09', '', '2026-04-10 01:05:15', '{\"imageWidth\":549,\"maxConfidence\":0.915233,\"fps\":0.0,\"inferenceMs\":233,\"imageHeight\":530,\"resultFramesUrl\":\"\",\"resultVideoUrl\":\"\",\"frameCount\":1,\"representativeBoxes\":[{\"x1\":277,\"y1\":142,\"x2\":419,\"y2\":366,\"score\":0.915233,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"\",\"detectedFrameCount\":1,\"fileType\":\"image\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (22, 'PDT202604100105466BD6C3', NULL, 23, NULL, 1, 'SUCCESS', 0.5000, 22, 7733, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-10 01:05:47', '2026-04-10 01:05:57', NULL, '2026-04-10 01:05:47', '', '2026-04-10 01:05:57', '{\"imageWidth\":768,\"maxConfidence\":0.907254,\"fps\":25.0,\"inferenceMs\":7733,\"imageHeight\":576,\"resultFramesUrl\":\"http://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260410010550_2da61c83_frames.json\",\"resultVideoUrl\":\"http://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260410010550_2da61c83_raw.mp4\",\"frameCount\":701,\"representativeBoxes\":[{\"x1\":131,\"y1\":310,\"x2\":352,\"y2\":500,\"score\":0.907254,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"\",\"detectedFrameCount\":387,\"fileType\":\"video\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (23, 'PDT20260410012941F84476', NULL, 24, NULL, 1, 'SUCCESS', 0.5000, 23, 13337, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-10 01:29:41', '2026-04-10 01:30:03', NULL, '2026-04-10 01:29:41', '', '2026-04-10 01:30:03', '{\"imageWidth\":768,\"maxConfidence\":0.907254,\"fps\":25.0,\"inferenceMs\":13337,\"imageHeight\":576,\"resultFramesUrl\":\"http://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260410012950_9d8fe6b7_frames.json\",\"resultVideoUrl\":\"http://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260410012950_9d8fe6b7.mp4\",\"frameCount\":701,\"representativeBoxes\":[{\"x1\":131,\"y1\":310,\"x2\":352,\"y2\":500,\"score\":0.907254,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"\",\"detectedFrameCount\":387,\"fileType\":\"video\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (24, 'PDT202604100159376E4C39', NULL, 25, NULL, 1, 'SUCCESS', 0.5000, 24, 14986, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-10 01:59:38', '2026-04-10 02:00:00', NULL, '2026-04-10 01:59:38', '', '2026-04-10 02:00:00', '{\"imageWidth\":768,\"maxConfidence\":0.907254,\"fps\":25.0,\"inferenceMs\":14986,\"imageHeight\":576,\"resultFramesUrl\":\"http://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260410015946_ba4fa761_frames.json\",\"resultVideoUrl\":\"http://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260410015946_ba4fa761.mp4\",\"frameCount\":701,\"representativeBoxes\":[{\"x1\":131,\"y1\":310,\"x2\":352,\"y2\":500,\"score\":0.907254,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"\",\"detectedFrameCount\":387,\"fileType\":\"video\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (25, 'PDT2026041002005186B8BF', NULL, 26, NULL, 1, 'SUCCESS', 0.5000, 25, 42, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-10 02:00:52', '2026-04-10 02:00:52', NULL, '2026-04-10 02:00:52', '', '2026-04-10 02:00:52', '{\"imageWidth\":549,\"maxConfidence\":0.915233,\"fps\":0.0,\"inferenceMs\":42,\"imageHeight\":530,\"resultFramesUrl\":\"\",\"resultVideoUrl\":\"\",\"frameCount\":1,\"representativeBoxes\":[{\"x1\":277,\"y1\":142,\"x2\":419,\"y2\":366,\"score\":0.915233,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"\",\"detectedFrameCount\":1,\"fileType\":\"image\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (26, 'PDT202604101356177E7162', NULL, 27, NULL, 1, 'FAILED', 0.5000, NULL, NULL, 'Inference request timeout or unreachable: I/O error on POST request for \"https://u231948-8c36-8d7654f5.westc.seetacloud.com:8443/infer\": Read timed out; nested exception is java.net.SocketTimeoutException: Read timed out', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-10 13:56:18', '2026-04-10 13:57:21', NULL, '2026-04-10 13:56:17', '', '2026-04-10 13:57:21', NULL, 0);
INSERT INTO `polyp_detect_task` VALUES (27, 'PDT20260410140105EC6A0C', NULL, 28, NULL, 1, 'FAILED', 0.5000, NULL, NULL, 'Inference request timeout or unreachable: I/O error on POST request for \"https://u231948-8c36-8d7654f5.westc.seetacloud.com:8443/infer\": Read timed out; nested exception is java.net.SocketTimeoutException: Read timed out', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-10 14:01:05', '2026-04-10 14:02:10', NULL, '2026-04-10 14:01:05', '', '2026-04-10 14:02:10', NULL, 0);
INSERT INTO `polyp_detect_task` VALUES (28, 'PDT20260410141318270A2E', NULL, 29, NULL, 1, 'SUCCESS', 0.5000, 26, 14146, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-10 14:13:18', '2026-04-10 14:13:43', NULL, '2026-04-10 14:13:18', '', '2026-04-10 14:13:43', '{\"imageWidth\":768,\"maxConfidence\":0.907254,\"fps\":25.0,\"inferenceMs\":14146,\"imageHeight\":576,\"resultFramesUrl\":\"http://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260410141328_22f5bb5b_frames.json\",\"resultVideoUrl\":\"http://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260410141328_22f5bb5b.mp4\",\"frameCount\":701,\"representativeBoxes\":[{\"x1\":131,\"y1\":310,\"x2\":352,\"y2\":500,\"score\":0.907254,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"\",\"detectedFrameCount\":387,\"fileType\":\"video\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (29, 'PDT20260410141524DB2533', NULL, 30, NULL, 1, 'SUCCESS', 0.5000, 27, 39, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-10 14:15:25', '2026-04-10 14:15:26', NULL, '2026-04-10 14:15:25', '', '2026-04-10 14:15:26', '{\"imageWidth\":549,\"maxConfidence\":0.915233,\"fps\":0.0,\"inferenceMs\":39,\"imageHeight\":530,\"resultFramesUrl\":\"\",\"resultVideoUrl\":\"\",\"frameCount\":1,\"representativeBoxes\":[{\"x1\":277,\"y1\":142,\"x2\":419,\"y2\":366,\"score\":0.915233,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"\",\"detectedFrameCount\":1,\"fileType\":\"image\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (30, 'PDT202604101446384DF3D6', NULL, 31, NULL, 1, 'SUCCESS', 0.5000, 28, 284, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-10 14:46:38', '2026-04-10 14:46:44', NULL, '2026-04-10 14:46:38', '', '2026-04-10 14:46:44', '{\"imageWidth\":549,\"maxConfidence\":0.915233,\"fps\":0.0,\"inferenceMs\":284,\"imageHeight\":530,\"resultFramesUrl\":\"\",\"resultVideoUrl\":\"\",\"frameCount\":1,\"representativeBoxes\":[{\"x1\":277,\"y1\":142,\"x2\":419,\"y2\":366,\"score\":0.915233,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"http://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/image_20260410144644_c0c8d5d5.jpg\",\"detectedFrameCount\":1,\"fileType\":\"image\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (31, 'PDT20260410144758056681', NULL, 32, NULL, 1, 'SUCCESS', 0.5000, 29, 14800, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-10 14:47:58', '2026-04-10 14:48:17', NULL, '2026-04-10 14:47:58', '', '2026-04-10 14:48:17', '{\"imageWidth\":768,\"maxConfidence\":0.907254,\"fps\":25.0,\"inferenceMs\":14800,\"imageHeight\":576,\"resultFramesUrl\":\"http://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260410144802_7c2aac9c_frames.json\",\"resultVideoUrl\":\"http://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260410144802_7c2aac9c.mp4\",\"frameCount\":701,\"representativeBoxes\":[{\"x1\":131,\"y1\":310,\"x2\":352,\"y2\":500,\"score\":0.907254,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"\",\"detectedFrameCount\":387,\"fileType\":\"video\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (32, 'PDT20260410151802F5F4AA', NULL, 33, NULL, 1, 'SUCCESS', 0.5000, 30, 15463, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-10 15:18:02', '2026-04-10 15:18:27', NULL, '2026-04-10 15:18:02', '', '2026-04-10 15:18:27', '{\"imageWidth\":768,\"maxConfidence\":0.907254,\"fps\":25.0,\"inferenceMs\":15463,\"imageHeight\":576,\"resultFramesUrl\":\"https://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260410151811_044db48f_frames.json\",\"resultVideoUrl\":\"https://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260410151811_044db48f.mp4\",\"frameCount\":701,\"representativeBoxes\":[{\"x1\":131,\"y1\":310,\"x2\":352,\"y2\":500,\"score\":0.907254,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"\",\"detectedFrameCount\":387,\"fileType\":\"video\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (33, 'PDT20260410151928C70AE4', NULL, 34, NULL, 1, 'SUCCESS', 0.5000, 31, 47, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-10 15:19:28', '2026-04-10 15:19:29', NULL, '2026-04-10 15:19:28', '', '2026-04-10 15:19:29', '{\"imageWidth\":549,\"maxConfidence\":0.915233,\"fps\":0.0,\"inferenceMs\":47,\"imageHeight\":530,\"resultFramesUrl\":\"\",\"resultVideoUrl\":\"\",\"frameCount\":1,\"representativeBoxes\":[{\"x1\":277,\"y1\":142,\"x2\":419,\"y2\":366,\"score\":0.915233,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"https://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/image_20260410151928_0cdf5085.jpg\",\"detectedFrameCount\":1,\"fileType\":\"image\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (34, 'PDT202604101535240B4EB5', NULL, 35, NULL, 1, 'SUCCESS', 0.5000, 32, 48, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-10 15:35:24', '2026-04-10 15:35:25', NULL, '2026-04-10 15:35:24', '', '2026-04-10 15:35:25', '{\"imageWidth\":549,\"maxConfidence\":0.915233,\"fps\":0.0,\"inferenceMs\":48,\"imageHeight\":530,\"resultFramesUrl\":\"\",\"resultVideoUrl\":\"\",\"frameCount\":1,\"representativeBoxes\":[{\"x1\":277,\"y1\":142,\"x2\":419,\"y2\":366,\"score\":0.915233,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"https://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/image_20260410153524_ca3a537a.jpg\",\"detectedFrameCount\":1,\"fileType\":\"image\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (35, 'PDT20260410190834B0AEB8', NULL, 36, NULL, 1, 'SUCCESS', 0.5000, 33, 291, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-10 19:08:35', '2026-04-10 19:08:40', NULL, '2026-04-10 19:08:34', '', '2026-04-10 19:08:40', '{\"imageWidth\":549,\"maxConfidence\":0.915233,\"fps\":0.0,\"inferenceMs\":291,\"imageHeight\":530,\"resultFramesUrl\":\"\",\"resultVideoUrl\":\"\",\"frameCount\":1,\"representativeBoxes\":[{\"x1\":277,\"y1\":142,\"x2\":419,\"y2\":366,\"score\":0.915233,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"https://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/image_20260410190840_46eb12d1.jpg\",\"detectedFrameCount\":1,\"fileType\":\"image\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (36, 'PDT2026041019085906158C', NULL, 37, NULL, 1, 'SUCCESS', 0.5000, 34, 15959, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-10 19:09:00', '2026-04-10 19:09:20', NULL, '2026-04-10 19:09:00', '', '2026-04-10 19:09:20', '{\"imageWidth\":768,\"maxConfidence\":0.907254,\"fps\":25.0,\"inferenceMs\":15959,\"imageHeight\":576,\"resultFramesUrl\":\"https://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260410190903_45042d83_frames.json\",\"resultVideoUrl\":\"https://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260410190903_45042d83.mp4\",\"frameCount\":701,\"representativeBoxes\":[{\"x1\":131,\"y1\":310,\"x2\":352,\"y2\":500,\"score\":0.907254,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"\",\"detectedFrameCount\":387,\"fileType\":\"video\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (37, 'PDT202604110025024AE2C6', NULL, 38, NULL, 1, 'DELETED', 0.5000, NULL, NULL, 'Inference request timeout or unreachable: I/O error on POST request for \"http://127.0.0.1:8001/infer\": Connection refused: connect; nested exception is java.net.ConnectException: Connection refused: connect', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-11 00:25:03', '2026-04-11 00:25:05', NULL, '2026-04-11 00:25:03', '', '2026-04-11 21:03:55', NULL, 1);
INSERT INTO `polyp_detect_task` VALUES (38, 'PDT2026041100311447685F', NULL, 39, NULL, 1, 'SUCCESS', 0.5000, 35, 58, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-11 00:31:15', '2026-04-11 00:31:16', NULL, '2026-04-11 00:31:14', '', '2026-04-11 00:31:16', '{\"imageWidth\":549,\"maxConfidence\":0.915233,\"fps\":0.0,\"inferenceMs\":58,\"imageHeight\":530,\"resultFramesUrl\":\"\",\"resultVideoUrl\":\"\",\"frameCount\":1,\"representativeBoxes\":[{\"x1\":277,\"y1\":142,\"x2\":419,\"y2\":366,\"score\":0.915233,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"https://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/image_20260411003116_4dbdb523.jpg\",\"detectedFrameCount\":1,\"fileType\":\"image\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (39, 'PDT202604110044174BC3DC', NULL, 40, NULL, 1, 'SUCCESS', 0.5000, 36, 42, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-11 00:44:17', '2026-04-11 00:44:18', NULL, '2026-04-11 00:44:17', '', '2026-04-11 00:44:18', '{\"imageWidth\":549,\"maxConfidence\":0.915233,\"fps\":0.0,\"inferenceMs\":42,\"imageHeight\":530,\"resultFramesUrl\":\"\",\"resultVideoUrl\":\"\",\"frameCount\":1,\"representativeBoxes\":[{\"x1\":277,\"y1\":142,\"x2\":419,\"y2\":366,\"score\":0.915233,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"https://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/image_20260411004418_2d0c1fb5.jpg\",\"detectedFrameCount\":1,\"fileType\":\"image\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (40, 'PDT20260411131847EF66FA', NULL, 41, NULL, 1, 'SUCCESS', 0.5000, 37, 326, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-11 13:18:48', '2026-04-11 13:18:54', NULL, '2026-04-11 13:18:48', '', '2026-04-11 13:18:54', '{\"imageWidth\":549,\"maxConfidence\":0.915233,\"fps\":0.0,\"inferenceMs\":326,\"imageHeight\":530,\"resultFramesUrl\":\"\",\"resultVideoUrl\":\"\",\"frameCount\":1,\"representativeBoxes\":[{\"x1\":277,\"y1\":142,\"x2\":419,\"y2\":366,\"score\":0.915233,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"https://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/image_20260411131855_d70b18b0.jpg\",\"detectedFrameCount\":1,\"fileType\":\"image\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (41, 'PDT202604111319126316B3', NULL, 42, NULL, 1, 'SUCCESS', 0.5000, 38, 16314, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-11 13:19:13', '2026-04-11 13:19:33', NULL, '2026-04-11 13:19:13', '', '2026-04-11 13:19:33', '{\"imageWidth\":768,\"maxConfidence\":0.907254,\"fps\":25.0,\"inferenceMs\":16314,\"imageHeight\":576,\"resultFramesUrl\":\"https://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260411131917_8de00f2f_frames.json\",\"resultVideoUrl\":\"https://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260411131917_8de00f2f.mp4\",\"frameCount\":701,\"representativeBoxes\":[{\"x1\":131,\"y1\":310,\"x2\":352,\"y2\":500,\"score\":0.907254,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"\",\"detectedFrameCount\":387,\"fileType\":\"video\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (42, 'PDT2026041118205220DC4E', NULL, 43, NULL, 1, 'SUCCESS', 0.5000, 39, 328, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-11 18:20:53', '2026-04-11 18:20:59', NULL, '2026-04-11 18:20:52', '', '2026-04-11 18:20:59', '{\"imageWidth\":549,\"maxConfidence\":0.915233,\"fps\":0.0,\"inferenceMs\":328,\"imageHeight\":530,\"resultFramesUrl\":\"\",\"resultVideoUrl\":\"\",\"frameCount\":1,\"representativeBoxes\":[{\"x1\":277,\"y1\":142,\"x2\":419,\"y2\":366,\"score\":0.915233,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"https://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/image_20260411182059_e3e4d6ed.jpg\",\"detectedFrameCount\":1,\"fileType\":\"image\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (43, 'PDT20260411211549329F42', NULL, 44, 'image', 1, 'SUCCESS', 0.5000, 40, 238, NULL, 'https://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/image_20260411211555_aac9a66f.jpg', '', '', 1, 1, 1, 0.915233, '2026-04-11 21:15:50', '2026-04-11 21:15:55', NULL, '2026-04-11 21:15:49', '', '2026-04-11 21:15:55', '{\"imageWidth\":549,\"maxConfidence\":0.915233,\"fps\":0.0,\"inferenceMs\":238,\"imageHeight\":530,\"resultFramesUrl\":\"\",\"resultVideoUrl\":\"\",\"frameCount\":1,\"representativeBoxes\":[{\"x1\":277,\"y1\":142,\"x2\":419,\"y2\":366,\"score\":0.915233,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"https://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/image_20260411211555_aac9a66f.jpg\",\"detectedFrameCount\":1,\"fileType\":\"image\"}', 0);
INSERT INTO `polyp_detect_task` VALUES (44, 'PDT20260411211624567ADB', NULL, 45, 'video', 1, 'SUCCESS', 0.5000, 41, 15547, NULL, '', 'https://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260411211629_738d1d1b.mp4', 'https://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260411211629_738d1d1b_frames.json', 701, 387, 1, 0.907254, '2026-04-11 21:16:25', '2026-04-11 21:16:45', NULL, '2026-04-11 21:16:25', '', '2026-04-11 21:16:45', '{\"imageWidth\":768,\"maxConfidence\":0.907254,\"fps\":25.0,\"inferenceMs\":15547,\"imageHeight\":576,\"resultFramesUrl\":\"https://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260411211629_738d1d1b_frames.json\",\"resultVideoUrl\":\"https://u231948-8c36-8d7654f5.westc.seetacloud.com/outputs/video_20260411211629_738d1d1b.mp4\",\"frameCount\":701,\"representativeBoxes\":[{\"x1\":131,\"y1\":310,\"x2\":352,\"y2\":500,\"score\":0.907254,\"class_name\":\"polyp\"}],\"boxCount\":1,\"resultImageUrl\":\"\",\"detectedFrameCount\":387,\"fileType\":\"video\"}', 0);

-- ----------------------------
-- Table structure for polyp_model
-- ----------------------------
DROP TABLE IF EXISTS `polyp_model`;
CREATE TABLE `polyp_model`  (
  `model_id` bigint NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `model_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '模型名称',
  `model_version` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '模型版本',
  `model_path` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '模型路径(本地/挂载路径)',
  `status` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'ACTIVE' COMMENT '状态：ACTIVE/INACTIVE',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否默认模型：1是0否',
  `conf_threshold` decimal(5, 4) NULL DEFAULT 0.5000 COMMENT '默认置信度阈值',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`model_id`) USING BTREE,
  INDEX `idx_status_default`(`status`, `is_default`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '息肉检测模型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of polyp_model
-- ----------------------------
INSERT INTO `polyp_model` VALUES (1, 'yolov5-polyp', 'v1', 'M:/0NUIST/class/bysj/Medical-platform-master/ruoyi-system/src/main/resources/yolo/polyp.pt', 'ACTIVE', 1, 0.5000, 'Phase1默认模型', '', '2026-04-03 20:09:47', '', '2026-04-03 20:09:47');

-- ----------------------------
-- Table structure for purchase
-- ----------------------------
DROP TABLE IF EXISTS `purchase`;
CREATE TABLE `purchase`  (
  `pur_order_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单编号',
  `pur_count` double(10, 2) NULL DEFAULT NULL COMMENT '订单总额',
  `pur_verify` int NULL DEFAULT NULL COMMENT '审核状态',
  `sup_id` int NULL DEFAULT NULL COMMENT '供应商ID',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者---createBy',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间--createTime',
  `update_by` varbinary(255) NULL DEFAULT NULL COMMENT '更新者----updateBy',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间--updateTime',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注------remark'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of purchase
-- ----------------------------
INSERT INTO `purchase` VALUES ('CG1271358119477379072', 1000.00, 0, 1, 'admin', '2026-02-22 23:54:56', 0x61646D696E, '2026-02-22 23:54:56', '生产厂家');
INSERT INTO `purchase` VALUES ('CG1271358325345435072', 1000.00, 0, 2, 'admin', '2026-02-22 23:54:56', 0x61646D696E, '2026-02-22 23:54:56', '生产厂家');
INSERT INTO `purchase` VALUES ('CG1271358119234239072', 1000.00, 0, 3, 'admin', '2026-02-22 23:54:56', 0x61646D696E, '2026-02-22 23:54:56', '生产厂家');

-- ----------------------------
-- Table structure for purchase_drug
-- ----------------------------
DROP TABLE IF EXISTS `purchase_drug`;
CREATE TABLE `purchase_drug`  (
  `pur_order_ID` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '订单编号',
  `drug_id` int NOT NULL COMMENT '药品ID',
  `pur_numbers` int NULL DEFAULT NULL COMMENT '采购数量',
  `pur_id` int NULL DEFAULT NULL COMMENT '批次号',
  `pur_price` double(10, 2) NULL DEFAULT NULL COMMENT '药品批发单价',
  `create_by` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pur_order_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of purchase_drug
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '日历信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '调度器状态表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for refund
-- ----------------------------
DROP TABLE IF EXISTS `refund`;
CREATE TABLE `refund`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单号',
  `Registration_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '挂号单号',
  `charge_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收费单号',
  `Patient_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '患者姓名',
  `Refund_amount` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '退费总金额',
  `Refund_method` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '退费方式',
  `Order_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单状态',
  `sup_build_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of refund
-- ----------------------------

-- ----------------------------
-- Table structure for supplier
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier`  (
  `sup_id` int NOT NULL AUTO_INCREMENT COMMENT '供应商ID',
  `sup_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '供应商名称',
  `sup_contact` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系人',
  `sup_mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系人手机',
  `sup_tel` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人电话',
  `sup_account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '银行账号',
  `sup_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `status` int NULL DEFAULT NULL COMMENT '状态',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者---createBy',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间--createTime',
  `update_by` varbinary(255) NULL DEFAULT NULL COMMENT '更新者----updateBy',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间--updateTime',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注------remark',
  PRIMARY KEY (`sup_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of supplier
-- ----------------------------
INSERT INTO `supplier` VALUES (101, '云南英才贸易有限公司', '雷华', '15902738715', '0278989765', '6379865245129741669', '云南', 0, 'admin', '2026-02-22 23:54:38', 0x61646D696E, '2026-02-22 23:54:38', '生产厂家');
INSERT INTO `supplier` VALUES (102, '武汉英才贸易有限公司', '雷华', '15902738715', '0278989765', '6379865245129741669', '武汉', 0, 'admin', '2026-02-22 23:54:38', 0x61646D696E, '2026-02-22 23:54:38', '生产厂家');
INSERT INTO `supplier` VALUES (103, '深圳英才贸易有限公司', '雷华', '15902738715', '0278989765', '6379865245129741669', '深圳', 0, 'admin', '2026-02-22 23:54:38', 0x61646D696E, '2026-02-22 23:54:38', '生产厂家');
INSERT INTO `supplier` VALUES (104, '北京英才贸易有限公司', '雷华', '15902738715', '0278989765', '6379865245129741669', '北京', 0, 'admin', '2026-02-22 23:54:38', 0x61646D696E, '2026-02-22 23:54:38', '生产厂家');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2026-02-22 23:51:11', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2026-02-22 23:51:11', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2026-02-22 23:51:11', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'false', 'Y', 'admin', '2026-02-22 23:51:11', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2026-02-22 23:51:11', '', NULL, '是否开启注册用户功能（true开启，false关闭）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-02-22 23:51:11', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-02-22 23:51:11', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-02-22 23:51:11', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-02-22 23:51:11', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-02-22 23:51:11', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-02-22 23:51:11', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-02-22 23:51:11', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-02-22 23:51:11', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-02-22 23:51:11', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-02-22 23:51:11', '', NULL);

-- ----------------------------
-- Table structure for sys_depts
-- ----------------------------
DROP TABLE IF EXISTS `sys_depts`;
CREATE TABLE `sys_depts`  (
  `depts_id` int NOT NULL COMMENT '科室编号---deptsId',
  `depts_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '科室名称---deptsName',
  `depts_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '科室编码---deptsCode',
  `depts_num` int NOT NULL DEFAULT 0 COMMENT '科室挂号量 ----deptsNum',
  `depts_leader` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '科室领导---deptsLeader',
  `depts_phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '科室电话---deptsPhone',
  `status` int NOT NULL COMMENT '科室状态---status',
  `create_by` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '创建者---createBy',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间--createTime',
  `update_by` varbinary(255) NULL DEFAULT NULL COMMENT '更新者----updateBy',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间--updateTime'
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_depts
-- ----------------------------
INSERT INTO `sys_depts` VALUES (101, '内科', 'HIS-Nk', 0, '雷哥', '17512344321', 1, 'admin', '2026-02-22 23:53:29', 0x61646D696E, '2026-02-22 23:53:29');
INSERT INTO `sys_depts` VALUES (102, '外科', 'HIS-WK', 0, '雷哥', '17512344321', 1, 'admin', '2026-02-22 23:53:29', 0x61646D696E, '2026-02-22 23:53:29');
INSERT INTO `sys_depts` VALUES (103, '儿科', 'HIS-EK', 0, '雷哥', '17512344321', 1, 'admin', '2026-02-22 23:53:29', 0x61646D696E, '2026-02-22 23:53:29');
INSERT INTO `sys_depts` VALUES (104, '妇科', 'HIS-FK', 0, '雷哥', '17512344321', 1, 'admin', '2026-02-22 23:53:29', 0x61646D696E, '2026-02-22 23:53:29');
INSERT INTO `sys_depts` VALUES (105, '眼科', 'HIS-YK', 0, '雷哥', '17512344321', 1, 'admin', '2026-02-22 23:53:29', 0x61646D696E, '2026-02-22 23:53:29');
INSERT INTO `sys_depts` VALUES (106, '耳鼻喉科', 'HIS-EBHK', 0, '雷哥', '17512344321', 1, 'admin', '2026-02-22 23:53:29', 0x61646D696E, '2026-02-22 23:53:29');
INSERT INTO `sys_depts` VALUES (107, '口腔科', 'HIS-KQK', 0, '雷哥', '17512344321', 1, 'admin', '2026-02-22 23:53:29', 0x61646D696E, '2026-02-22 23:53:29');
INSERT INTO `sys_depts` VALUES (108, '皮肤科', 'HIS-PFK', 0, '雷哥', '17512344321', 1, 'admin', '2026-02-22 23:53:29', 0x61646D696E, '2026-02-22 23:53:29');
INSERT INTO `sys_depts` VALUES (109, '其他', 'HIS-OTHER', 0, '雷哥', '17512344321', 1, 'admin', '2026-02-22 23:53:29', 0x61646D696E, '2026-02-22 23:53:29');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_docters
-- ----------------------------
DROP TABLE IF EXISTS `sys_docters`;
CREATE TABLE `sys_docters`  (
  `d_id` int NOT NULL AUTO_INCREMENT COMMENT '医生编号 dId',
  `d_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '医生姓名 dName',
  `d_password` varchar(300) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '医生密码 dPassword',
  `depts_id` int NULL DEFAULT NULL COMMENT '所属部门 deptId',
  `d_phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '医生手机号 dPhone',
  `d_sex` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '医生性别    dSex',
  `d_age` int NULL DEFAULT NULL COMMENT '医生年龄    dAge',
  `d_level` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '医生级别   dLevel',
  `orderwork` int NULL DEFAULT NULL COMMENT '是否排班 1、是  2 、否  orderWork',
  `d_education_bg` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '学历背景   dEducationBg',
  `create_by` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`d_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_docters
-- ----------------------------
INSERT INTO `sys_docters` VALUES (1, '扁鹊', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', 101, '14212345678', '1', 20, '医师', 1, '专科', 'admin', '2026-02-22 23:53:59', 'admin', '2026-02-22 23:53:59', '医生');

-- ----------------------------
-- Table structure for sys_docters_depts
-- ----------------------------
DROP TABLE IF EXISTS `sys_docters_depts`;
CREATE TABLE `sys_docters_depts`  (
  `d_id` int NULL DEFAULT NULL COMMENT '医生序号',
  `depts_id` int NULL DEFAULT NULL COMMENT '部门序号'
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_docters_depts
-- ----------------------------

-- ----------------------------
-- Table structure for sys_exam_cost
-- ----------------------------
DROP TABLE IF EXISTS `sys_exam_cost`;
CREATE TABLE `sys_exam_cost`  (
  `exam_id` int NOT NULL AUTO_INCREMENT COMMENT '项目费用ID---examId',
  `exam_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '项目名称------examName',
  `exam_key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '项目关键字----examKey',
  `exam_one_price` double(10, 2) NOT NULL COMMENT '项目单价------examOnePrice',
  `exam_cost` double(10, 2) NOT NULL COMMENT '项目成本------examCost',
  `exam_unit` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '单位 examUnit',
  `exam_type` int NOT NULL COMMENT '类别 examType 1、化验类  2、拍片类',
  `status` int NOT NULL COMMENT '状态 status',
  `create_by` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '创建者---createBy',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间--createTime',
  `update_by` varbinary(255) NULL DEFAULT NULL COMMENT '更新者----updateBy',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间--updateTime',
  `remark` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注------remark',
  PRIMARY KEY (`exam_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_exam_cost
-- ----------------------------
INSERT INTO `sys_exam_cost` VALUES (5, '乙肝五项', 'YGWX', 30.00, 10.00, '次', 1, 1, 'admin', '2026-02-22 23:53:43', 0x61646D696E, '2026-02-22 23:53:43', '乙肝五项检查');
INSERT INTO `sys_exam_cost` VALUES (6, '血常规', 'XCG', 5.00, 1.00, '次', 1, 1, 'admin', '2026-02-22 23:53:43', 0x61646D696E, '2026-02-22 23:53:43', '血液化验');
INSERT INTO `sys_exam_cost` VALUES (7, 'CT', 'CT', 50.00, 10.00, '次', 2, 1, 'admin', '2026-02-22 23:53:43', 0x61646D696E, '2026-02-22 23:53:43', '乙肝五项检查');
INSERT INTO `sys_exam_cost` VALUES (8, 'X光', 'XG', 20.00, 5.00, '次', 2, 1, 'admin', '2026-02-22 23:53:43', 0x61646D696E, '2026-02-22 23:53:43', '乙肝五项检查');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2026-02-22 23:51:11', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 148 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-23 00:00:25');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-23 14:15:33');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-23 14:47:06');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-15 11:04:24');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-15 11:12:56');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-03-15 11:13:35');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-03-15 11:13:42');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-15 11:13:47');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-19 21:43:28');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-19 21:57:03');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-19 21:57:11');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-19 23:28:09');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-19 23:29:44');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-27 15:51:10');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-27 20:11:53');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-28 14:55:08');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Mozilla', 'Windows 10', '0', '登录成功', '2026-04-03 23:23:50');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Mozilla', 'Windows 10', '0', '登录成功', '2026-04-04 00:01:21');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Mozilla', 'Windows 10', '0', '登录成功', '2026-04-04 00:02:32');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Mozilla', 'Windows 10', '0', '登录成功', '2026-04-04 00:06:08');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Mozilla', 'Windows 10', '0', '登录成功', '2026-04-04 00:07:10');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Mozilla', 'Windows 10', '0', '登录成功', '2026-04-04 00:13:28');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Mozilla', 'Windows 10', '0', '登录成功', '2026-04-04 00:14:21');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Mozilla', 'Windows 10', '0', '登录成功', '2026-04-04 00:15:17');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-06 16:55:22');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-09 15:53:51');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-09 16:43:52');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-09 17:16:47');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'Mozilla', 'Windows 10', '0', '登录成功', '2026-04-09 17:55:42');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Mozilla', 'Windows 10', '0', '登录成功', '2026-04-09 17:55:50');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-09 21:20:47');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-09 21:54:40');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Mozilla', 'Windows 10', '0', '登录成功', '2026-04-09 22:33:46');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Mozilla', 'Windows 10', '0', '登录成功', '2026-04-09 22:34:22');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'Mozilla', 'Windows 10', '0', '登录成功', '2026-04-09 22:34:41');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-09 22:57:48');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-10 00:17:31');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-10 01:00:34');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-10 13:55:53');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-10 19:05:20');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-10 22:53:05');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-11 00:08:47');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-11 12:20:39');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-11 13:18:39');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-11 15:40:25');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-11 17:53:24');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-11 17:58:46');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-11 18:08:34');
INSERT INTO `sys_logininfor` VALUES (148, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-11 19:10:28');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-11 20:20:15');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-11 21:04:04');
INSERT INTO `sys_logininfor` VALUES (151, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-12 00:22:25');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2006 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统功能', 0, 1, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2026-02-22 23:51:11', 'admin', '2026-04-12 00:28:53', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2026-02-22 23:51:11', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', 1, 0, 'M', '1', '0', '', 'tool', 'admin', '2026-02-22 23:51:11', 'admin', '2026-04-12 00:28:01', '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', 0, 0, 'M', '1', '0', '', 'guide', 'admin', '2026-02-22 23:51:11', 'admin', '2026-04-12 00:28:06', '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '医护账号管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2026-02-22 23:51:11', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2026-02-22 23:51:11', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2026-02-22 23:51:11', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2026-02-22 23:51:11', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2026-02-22 23:51:11', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2026-02-22 23:51:11', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2026-02-22 23:51:11', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2026-02-22 23:51:11', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '审计日志', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2026-02-22 23:51:11', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2026-02-22 23:51:11', 'admin', '2026-04-12 00:27:37', '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2026-02-22 23:51:11', 'admin', '2026-04-12 00:30:08', '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '1', '0', 'monitor:druid:list', 'druid', 'admin', '2026-02-22 23:51:11', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '1', '0', 'monitor:server:list', 'server', 'admin', '2026-02-22 23:51:11', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '1', '0', 'monitor:cache:list', 'redis', 'admin', '2026-02-22 23:51:11', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', 1, 0, 'C', '1', '0', 'monitor:cache:list', 'redis-list', 'admin', '2026-02-22 23:51:11', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '1', '0', 'tool:build:list', 'build', 'admin', '2026-02-22 23:51:11', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '1', '0', 'tool:gen:list', 'code', 'admin', '2026-02-22 23:51:11', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '1', '0', 'tool:swagger:list', 'swagger', 'admin', '2026-02-22 23:51:11', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '审计日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2026-02-22 23:51:11', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录审计', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2026-02-22 23:51:11', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '息肉检测中心', 1, 2, 'polyp', 'system/polyp/index', '', 1, 0, 'C', '0', '0', 'system:polyp:list', 'clipboard', 'admin', '2026-03-27 10:00:00', 'admin', '2026-04-12 00:27:09', '息肉详情菜单');
INSERT INTO `sys_menu` VALUES (2001, '息肉查看', 2000, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:polyp:query', '#', 'admin', '2026-03-27 10:00:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2002, '息肉新增', 2000, 2, '', '', '', 1, 0, 'F', '1', '0', 'system:polyp:add', '#', 'admin', '2026-03-27 10:00:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2003, '息肉修改', 2000, 3, '', '', '', 1, 0, 'F', '1', '0', 'system:polyp:edit', '#', 'admin', '2026-03-27 10:00:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2004, '息肉删除', 2000, 4, '', '', '', 1, 0, 'F', '1', '0', 'system:polyp:remove', '#', 'admin', '2026-03-27 10:00:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '息肉导出', 2000, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:polyp:export', '#', 'admin', '2026-03-27 10:00:00', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2026-02-22 23:51:11', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2026-02-22 23:51:11', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/4', '127.0.0.1', '内网IP', '{menuId=4}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-04-11 15:41:04');
INSERT INTO `sys_oper_log` VALUES (101, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/41/view', '127.0.0.1', '内网IP', '{taskId=41}', NULL, 0, NULL, '2026-04-11 17:53:39');
INSERT INTO `sys_oper_log` VALUES (102, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/40/view', '127.0.0.1', '内网IP', '{taskId=40}', NULL, 0, NULL, '2026-04-11 17:53:45');
INSERT INTO `sys_oper_log` VALUES (103, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/41/view', '127.0.0.1', '内网IP', '{taskId=41}', NULL, 0, NULL, '2026-04-11 18:13:43');
INSERT INTO `sys_oper_log` VALUES (104, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/41/view', '127.0.0.1', '内网IP', '{taskId=41}', NULL, 0, NULL, '2026-04-11 18:20:33');
INSERT INTO `sys_oper_log` VALUES (105, '息肉检测文件上传', 1, 'com.ruoyi.web.controller.polyp.PolypFileController.upload()', 'POST', 1, 'admin', NULL, '/system/polyp/file/upload', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2026-04-11 18:20:52');
INSERT INTO `sys_oper_log` VALUES (106, '息肉检测任务创建', 1, 'com.ruoyi.web.controller.polyp.PolypTaskController.createTask()', 'POST', 1, 'admin', NULL, '/system/polyp/task', '127.0.0.1', '内网IP', '{\"confThreshold\":0.5,\"modelId\":1,\"sourceFileId\":43}', NULL, 0, NULL, '2026-04-11 18:20:53');
INSERT INTO `sys_oper_log` VALUES (107, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/42/view', '127.0.0.1', '内网IP', '{taskId=42}', NULL, 0, NULL, '2026-04-11 18:20:53');
INSERT INTO `sys_oper_log` VALUES (108, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/42/view', '127.0.0.1', '内网IP', '{taskId=42}', NULL, 0, NULL, '2026-04-11 19:10:55');
INSERT INTO `sys_oper_log` VALUES (109, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/41/view', '127.0.0.1', '内网IP', '{taskId=41}', NULL, 0, NULL, '2026-04-11 19:10:57');
INSERT INTO `sys_oper_log` VALUES (110, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/42/view', '127.0.0.1', '内网IP', '{taskId=42}', NULL, 0, NULL, '2026-04-11 19:10:59');
INSERT INTO `sys_oper_log` VALUES (111, '息肉检测任务', 5, 'com.ruoyi.web.controller.polyp.PolypTaskController.export()', 'POST', 1, 'admin', NULL, '/system/polyp/task/export', '127.0.0.1', '内网IP', '{\"params\":{}}', NULL, 0, NULL, '2026-04-11 20:21:15');
INSERT INTO `sys_oper_log` VALUES (112, '息肉检测任务', 3, 'com.ruoyi.web.controller.polyp.PolypTaskController.remove()', 'DELETE', 1, 'admin', NULL, '/system/polyp/task/37', '127.0.0.1', '内网IP', '{taskIds=37}', NULL, 0, NULL, '2026-04-11 20:23:05');
INSERT INTO `sys_oper_log` VALUES (113, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/4', '127.0.0.1', '内网IP', '{menuId=4}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-04-11 20:24:20');
INSERT INTO `sys_oper_log` VALUES (114, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/41/view', '127.0.0.1', '内网IP', '{taskId=41}', NULL, 0, NULL, '2026-04-11 20:41:31');
INSERT INTO `sys_oper_log` VALUES (115, '息肉检测文件上传', 1, 'com.ruoyi.web.controller.polyp.PolypFileController.upload()', 'POST', 1, 'admin', NULL, '/system/polyp/file/upload', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2026-04-11 21:15:50');
INSERT INTO `sys_oper_log` VALUES (116, '息肉检测任务创建', 1, 'com.ruoyi.web.controller.polyp.PolypTaskController.createTask()', 'POST', 1, 'admin', NULL, '/system/polyp/task', '127.0.0.1', '内网IP', '{\"confThreshold\":0.5,\"modelId\":1,\"sourceFileId\":44}', NULL, 0, NULL, '2026-04-11 21:15:50');
INSERT INTO `sys_oper_log` VALUES (117, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/43/view', '127.0.0.1', '内网IP', '{taskId=43}', NULL, 0, NULL, '2026-04-11 21:15:50');
INSERT INTO `sys_oper_log` VALUES (118, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/43/view', '127.0.0.1', '内网IP', '{taskId=43}', NULL, 0, NULL, '2026-04-11 21:16:05');
INSERT INTO `sys_oper_log` VALUES (119, '息肉检测文件上传', 1, 'com.ruoyi.web.controller.polyp.PolypFileController.upload()', 'POST', 1, 'admin', NULL, '/system/polyp/file/upload', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2026-04-11 21:16:25');
INSERT INTO `sys_oper_log` VALUES (120, '息肉检测任务创建', 1, 'com.ruoyi.web.controller.polyp.PolypTaskController.createTask()', 'POST', 1, 'admin', NULL, '/system/polyp/task', '127.0.0.1', '内网IP', '{\"confThreshold\":0.5,\"modelId\":1,\"sourceFileId\":45}', NULL, 0, NULL, '2026-04-11 21:16:25');
INSERT INTO `sys_oper_log` VALUES (121, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/44/view', '127.0.0.1', '内网IP', '{taskId=44}', NULL, 0, NULL, '2026-04-11 21:16:26');
INSERT INTO `sys_oper_log` VALUES (122, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/19/view', '127.0.0.1', '内网IP', '{taskId=19}', NULL, 0, NULL, '2026-04-11 21:18:05');
INSERT INTO `sys_oper_log` VALUES (123, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/19/view', '127.0.0.1', '内网IP', '{taskId=19}', NULL, 0, NULL, '2026-04-11 21:18:12');
INSERT INTO `sys_oper_log` VALUES (124, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/29/view', '127.0.0.1', '内网IP', '{taskId=29}', NULL, 0, NULL, '2026-04-11 21:18:18');
INSERT INTO `sys_oper_log` VALUES (125, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/28/view', '127.0.0.1', '内网IP', '{taskId=28}', NULL, 0, NULL, '2026-04-11 21:18:21');
INSERT INTO `sys_oper_log` VALUES (126, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/33/view', '127.0.0.1', '内网IP', '{taskId=33}', NULL, 0, NULL, '2026-04-11 21:18:26');
INSERT INTO `sys_oper_log` VALUES (127, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/32/view', '127.0.0.1', '内网IP', '{taskId=32}', NULL, 0, NULL, '2026-04-11 21:18:31');
INSERT INTO `sys_oper_log` VALUES (128, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/36/view', '127.0.0.1', '内网IP', '{taskId=36}', NULL, 0, NULL, '2026-04-11 21:18:41');
INSERT INTO `sys_oper_log` VALUES (129, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/38/view', '127.0.0.1', '内网IP', '{taskId=38}', NULL, 0, NULL, '2026-04-11 21:26:59');
INSERT INTO `sys_oper_log` VALUES (130, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/38/view', '127.0.0.1', '内网IP', '{taskId=38}', NULL, 0, NULL, '2026-04-11 21:27:00');
INSERT INTO `sys_oper_log` VALUES (131, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/42/view', '127.0.0.1', '内网IP', '{taskId=42}', NULL, 0, NULL, '2026-04-11 21:27:01');
INSERT INTO `sys_oper_log` VALUES (132, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/39/view', '127.0.0.1', '内网IP', '{taskId=39}', NULL, 0, NULL, '2026-04-11 21:27:21');
INSERT INTO `sys_oper_log` VALUES (133, '息肉检测详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/44/view', '127.0.0.1', '内网IP', '{taskId=44}', NULL, 0, NULL, '2026-04-11 21:27:25');
INSERT INTO `sys_oper_log` VALUES (134, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/polyp/index\",\"createTime\":\"2026-03-27 10:00:00\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"息肉检测中心\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"polyp\",\"perms\":\"system:polyp:list\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-12 00:26:14');
INSERT INTO `sys_oper_log` VALUES (135, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/polyp/index\",\"createTime\":\"2026-03-27 10:00:00\",\"icon\":\"clipboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"息肉检测中心\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":1,\"path\":\"polyp\",\"perms\":\"system:polyp:list\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-12 00:27:09');
INSERT INTO `sys_oper_log` VALUES (136, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"monitor/online/index\",\"createTime\":\"2026-02-22 23:51:11\",\"icon\":\"online\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":109,\"menuName\":\"在线用户\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2,\"path\":\"online\",\"perms\":\"monitor:online:list\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-12 00:27:37');
INSERT INTO `sys_oper_log` VALUES (137, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-02-22 23:51:11\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-12 00:28:02');
INSERT INTO `sys_oper_log` VALUES (138, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-02-22 23:51:11\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-12 00:28:06');
INSERT INTO `sys_oper_log` VALUES (139, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-02-22 23:51:11\",\"icon\":\"system\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1,\"menuName\":\"系统功能\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-12 00:28:53');
INSERT INTO `sys_oper_log` VALUES (140, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/4', '127.0.0.1', '内网IP', '{menuId=4}', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-04-12 00:29:33');
INSERT INTO `sys_oper_log` VALUES (141, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"monitor/job/index\",\"createTime\":\"2026-02-22 23:51:11\",\"icon\":\"job\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":110,\"menuName\":\"定时任务\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2,\"path\":\"job\",\"perms\":\"monitor:job:list\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-12 00:30:09');
INSERT INTO `sys_oper_log` VALUES (142, '检查任务详情查看', 0, 'com.ruoyi.web.controller.polyp.PolypTaskController.taskDetailForView()', 'GET', 1, 'admin', NULL, '/system/polyp/task/44/view', '127.0.0.1', '内网IP', '{taskId=44}', NULL, 0, NULL, '2026-04-12 00:38:24');

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2026-02-22 23:51:11', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2026-02-22 23:51:11', '', NULL, '');

-- ----------------------------
-- Table structure for sys_registration_cost
-- ----------------------------
DROP TABLE IF EXISTS `sys_registration_cost`;
CREATE TABLE `sys_registration_cost`  (
  `reg_id` int NOT NULL AUTO_INCREMENT COMMENT '挂号费用ID---regId',
  `reg_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '挂号费名称------regName',
  `reg_price` double(10, 2) NOT NULL COMMENT '挂号费------regPrice',
  `status` int NOT NULL COMMENT '状态 status',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者---createBy',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间--createTime',
  `update_by` varbinary(255) NULL DEFAULT NULL COMMENT '更新者----updateBy',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间--updateTime',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注------remark',
  PRIMARY KEY (`reg_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_registration_cost
-- ----------------------------
INSERT INTO `sys_registration_cost` VALUES (1, '门诊', 6.00, 1, 'admin', '2026-02-22 23:54:21', 0x61646D696E, '2026-02-22 23:54:21', '门诊费用');
INSERT INTO `sys_registration_cost` VALUES (2, '门诊+病历本', 7.00, 1, 'admin', '2026-02-22 23:54:21', 0x61646D696E, '2026-02-22 23:54:21', '门诊+病历本费用');
INSERT INTO `sys_registration_cost` VALUES (3, '急诊', 12.00, 1, 'admin', '2026-02-22 23:54:21', 0x61646D696E, '2026-02-22 23:54:21', '急诊费用');
INSERT INTO `sys_registration_cost` VALUES (4, '急诊+病历本', 13.00, 1, 'admin', '2026-02-22 23:54:21', 0x61646D696E, '2026-02-22 23:54:21', '急诊+病历本费用');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2026-02-22 23:51:11', '', NULL, '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 2000);
INSERT INTO `sys_role_menu` VALUES (1, 2001);
INSERT INTO `sys_role_menu` VALUES (1, 2002);
INSERT INTO `sys_role_menu` VALUES (1, 2003);
INSERT INTO `sys_role_menu` VALUES (1, 2004);
INSERT INTO `sys_role_menu` VALUES (1, 2005);
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-04-12 00:22:24', 'admin', '2026-02-22 23:51:11', '', '2026-04-12 00:22:25', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-02-22 23:51:11', 'admin', '2026-02-22 23:51:11', '', NULL, '测试员');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

SET FOREIGN_KEY_CHECKS = 1;
