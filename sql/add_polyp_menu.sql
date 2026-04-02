-- =============================================
-- 息肉检测系统菜单配置
-- 执行方式: mysql -u root -p ry-vue < sql/add_polyp_menu.sql
-- 或直接在数据库中执行以下 SQL
-- =============================================

-- 在系统管理目录下添加息肉详情菜单 (假设系统管理的 menu_id = 1)

-- 1. 息肉详情目录
INSERT INTO `sys_menu` VALUES (2000, '息肉详情', 1, 10, 'polyp', 'system/polyp/index', '', 1, 0, 'C', '0', '0', 'system:polyp:list', 'clipboard', 'admin', '2026-03-27 10:00:00', '', NULL, '息肉详情菜单');

-- 2. 息肉详情按钮 - 查看
INSERT INTO `sys_menu` VALUES (2001, '息肉查看', 2000, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:polyp:query', '#', 'admin', '2026-03-27 10:00:00', '', NULL, '');

-- 3. 息肉详情按钮 - 新增
INSERT INTO `sys_menu` VALUES (2002, '息肉新增', 2000, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:polyp:add', '#', 'admin', '2026-03-27 10:00:00', '', NULL, '');

-- 4. 息肉详情按钮 - 修改
INSERT INTO `sys_menu` VALUES (2003, '息肉修改', 2000, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:polyp:edit', '#', 'admin', '2026-03-27 10:00:00', '', NULL, '');

-- 5. 息肉详情按钮 - 删除
INSERT INTO `sys_menu` VALUES (2004, '息肉删除', 2000, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:polyp:remove', '#', 'admin', '2026-03-27 10:00:00', '', NULL, '');

-- 6. 息肉详情按钮 - 导出
INSERT INTO `sys_menu` VALUES (2005, '息肉导出', 2000, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:polyp:export', '#', 'admin', '2026-03-27 10:00:00', '', NULL, '');

-- =============================================
-- 分配权限给角色（使角色能够访问息肉详情菜单）
-- =============================================

-- 给管理员角色分配息肉菜单权限 (role_id=1 是超级管理员)
INSERT INTO `sys_role_menu` VALUES (1, 2000);
INSERT INTO `sys_role_menu` VALUES (1, 2001);
INSERT INTO `sys_role_menu` VALUES (1, 2002);
INSERT INTO `sys_role_menu` VALUES (1, 2003);
INSERT INTO `sys_role_menu` VALUES (1, 2004);
INSERT INTO `sys_role_menu` VALUES (1, 2005);

-- 给普通用户角色分配息肉菜单权限 (role_id=2)
INSERT INTO `sys_role_menu` VALUES (2, 2000);
INSERT INTO `sys_role_menu` VALUES (2, 2001);
INSERT INTO `sys_role_menu` VALUES (2, 2002);
INSERT INTO `sys_role_menu` VALUES (2, 2003);
INSERT INTO `sys_role_menu` VALUES (2, 2004);
INSERT INTO `sys_role_menu` VALUES (2, 2005);
