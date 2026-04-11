-- ============================================================
-- Phase 3 医疗化收敛：组织与岗位默认数据修正
-- 目标：
-- 1) 将 sys_dept 从企业结构改为医院组织结构（保留原 dept_id，避免破坏用户/角色关联）
-- 2) 将 sys_post 从企业岗位改为医疗岗位（保留原 post_id，避免破坏用户岗位关联）
-- 3) 菜单文案医疗化（系统维护/医护账号/科室组织/医疗岗位）
-- 4) 不改权限机制、不改登录、不改业务表结构
-- ============================================================

START TRANSACTION;

-- --------------------------------------------
-- 1) 部门树医疗化（按既有主键更新，保持 parent_id/ancestors 不变）
-- --------------------------------------------
UPDATE sys_dept
SET dept_name = '市人民医院内镜中心'
WHERE dept_id = 100;

UPDATE sys_dept
SET dept_name = '内镜临床部'
WHERE dept_id = 101;

UPDATE sys_dept
SET dept_name = '医疗支撑部'
WHERE dept_id = 102;

UPDATE sys_dept
SET dept_name = '消化内科'
WHERE dept_id = 103;

UPDATE sys_dept
SET dept_name = '内镜检查室'
WHERE dept_id = 104;

UPDATE sys_dept
SET dept_name = '病理评估组'
WHERE dept_id = 105;

UPDATE sys_dept
SET dept_name = '护理组'
WHERE dept_id = 106;

UPDATE sys_dept
SET dept_name = '影像与数据组'
WHERE dept_id = 107;

UPDATE sys_dept
SET dept_name = '信息科'
WHERE dept_id = 108;

UPDATE sys_dept
SET dept_name = '系统运维组'
WHERE dept_id = 109;

-- 可选：统一负责人文案（不改电话/邮箱，避免影响真实配置）
UPDATE sys_dept
SET leader = CASE
    WHEN dept_id = 100 THEN '中心主任'
    WHEN dept_id IN (101, 102) THEN '部门负责人'
    ELSE '科室负责人'
END
WHERE dept_id IN (100,101,102,103,104,105,106,107,108,109);

-- --------------------------------------------
-- 2) 岗位医疗化（保留既有 post_id，兼容 sys_user_post）
-- --------------------------------------------
UPDATE sys_post
SET post_code = 'sys_admin',
    post_name = '系统管理员',
    post_sort = 1
WHERE post_id = 1;

UPDATE sys_post
SET post_code = 'endoscopy_doctor',
    post_name = '内镜医师',
    post_sort = 2
WHERE post_id = 2;

UPDATE sys_post
SET post_code = 'review_doctor',
    post_name = '审核医师',
    post_sort = 3
WHERE post_id = 3;

UPDATE sys_post
SET post_code = 'nurse',
    post_name = '护士',
    post_sort = 4
WHERE post_id = 4;

-- 追加少量演示岗位（若已存在则跳过）
INSERT INTO sys_post (post_id, post_code, post_name, post_sort, status, create_by, create_time, update_by, update_time, remark)
SELECT 5, 'dept_director', '科室主任', 5, '0', 'admin', NOW(), '', NULL, 'Phase3 医疗化补充岗位'
WHERE NOT EXISTS (SELECT 1 FROM sys_post WHERE post_id = 5);

INSERT INTO sys_post (post_id, post_code, post_name, post_sort, status, create_by, create_time, update_by, update_time, remark)
SELECT 6, 'data_manager', '数据管理员', 6, '0', 'admin', NOW(), '', NULL, 'Phase3 医疗化补充岗位'
WHERE NOT EXISTS (SELECT 1 FROM sys_post WHERE post_id = 6);

INSERT INTO sys_post (post_id, post_code, post_name, post_sort, status, create_by, create_time, update_by, update_time, remark)
SELECT 7, 'ops_admin', '运维管理员', 7, '0', 'admin', NOW(), '', NULL, 'Phase3 医疗化补充岗位'
WHERE NOT EXISTS (SELECT 1 FROM sys_post WHERE post_id = 7);

-- --------------------------------------------
-- 3) 菜单文案医疗化（仅改显示，不改 perms/路由）
-- --------------------------------------------
UPDATE sys_menu
SET menu_name = '系统维护'
WHERE menu_id = 1;

UPDATE sys_menu
SET menu_name = '医护账号管理'
WHERE menu_id = 100;

UPDATE sys_menu
SET menu_name = '科室/组织管理'
WHERE menu_id = 103;

UPDATE sys_menu
SET menu_name = '医疗岗位管理'
WHERE menu_id = 104;

-- 若菜单 ID 在不同环境不一致，按 perms 再兜底一次
UPDATE sys_menu
SET menu_name = '医护账号管理'
WHERE perms = 'system:user:list';

UPDATE sys_menu
SET menu_name = '科室/组织管理'
WHERE perms = 'system:dept:list';

UPDATE sys_menu
SET menu_name = '医疗岗位管理'
WHERE perms = 'system:post:list';

COMMIT;

-- ============================================================
-- 执行后建议校验：
-- SELECT dept_id,parent_id,dept_name FROM sys_dept WHERE dept_id BETWEEN 100 AND 109 ORDER BY dept_id;
-- SELECT post_id,post_code,post_name,post_sort FROM sys_post ORDER BY post_id;
-- SELECT menu_id,menu_name,perms FROM sys_menu WHERE menu_id IN (1,100,103,104);
-- ============================================================
