-- Phase 2 Round 1: low-risk medical convergence for menus and labels
-- Purpose: hide weak-related entries and keep a clear medical workflow.
-- Safe strategy: no physical delete, only rename/hide.

-- 1) Top-level menu wording
UPDATE sys_menu SET menu_name = '系统维护' WHERE menu_name = '系统管理';
UPDATE sys_menu SET menu_name = '审计日志' WHERE menu_name = '日志管理';

-- 2) Home and core entry wording
UPDATE sys_menu
SET menu_name = '监测总览', visible = '0', status = '0'
WHERE menu_name = '首页' OR component = 'index';

UPDATE sys_menu
SET menu_name = '医护账号管理'
WHERE component = 'system/user/index';

UPDATE sys_menu
SET menu_name = '患者管理', visible = '0', status = '0'
WHERE component = 'system/patient/index';

UPDATE sys_menu
SET menu_name = '息肉检测中心', visible = '0', status = '0', order_num = 2
WHERE component = 'system/polyp/index';

-- If only old detection menu exists, keep it as the main entry temporarily.
UPDATE sys_menu
SET menu_name = '息肉检测中心', visible = '0', status = '0', order_num = 2
WHERE component = 'system/detection/index'
  AND NOT EXISTS (SELECT 1 FROM (SELECT component, visible FROM sys_menu) x WHERE x.component = 'system/polyp/index' AND x.visible = '0');

-- Hide old detection entry only when /system/polyp/index is available.
UPDATE sys_menu
SET visible = '1'
WHERE component = 'system/detection/index'
  AND EXISTS (SELECT 1 FROM (SELECT component, visible FROM sys_menu) x WHERE x.component = 'system/polyp/index' AND x.visible = '0');

-- 3) Audit log wording
UPDATE sys_menu SET menu_name = '审计日志' WHERE component = 'monitor/operlog/index';
UPDATE sys_menu SET menu_name = '登录审计' WHERE component = 'monitor/logininfor/index';

-- 4) Keep only one patient chain, hide duplicate patient entry
UPDATE sys_menu
SET visible = '1'
WHERE component IN ('system/pati/index', 'system/addpati/index')
   OR perms LIKE 'system:pati:%';

-- 5) Hide weak-related HIS/business modules (no deletion)
UPDATE sys_menu
SET visible = '1'
WHERE perms LIKE 'his:%'
   OR perms LIKE 'system:student:%'
   OR perms LIKE 'system:cost:%'
   OR perms LIKE 'system:cost2:%'
   OR perms LIKE 'system:depts:%'
   OR perms LIKE 'system:docters:%'
   OR perms LIKE 'system:drug:%'
   OR perms LIKE 'system:factory:%'
   OR perms LIKE 'system:purchase:%'
   OR perms LIKE 'system:reg:%'
   OR perms LIKE 'system:supplier:%'
   OR perms LIKE 'system:report:%'
   OR perms LIKE 'system:polyp:list'
   OR perms LIKE 'system:polyp:add'
   OR perms LIKE 'system:polyp:edit'
   OR perms LIKE 'system:polyp:remove';

-- 6) Hide weak-related components by path (fallback)
UPDATE sys_menu
SET visible = '1'
WHERE component IN (
  'system/cost/index',
  'system/cost2/index',
  'system/depts/index',
  'system/docters/index',
  'system/drug/index',
  'system/factory/index',
  'system/purchase/index',
  'system/reg/index',
  'system/regadd/index',
  'system/supplier/index',
  'his/chargedetail/index',
  'his/depts/index',
  'his/docters/index',
  'his/purchase/index',
  'his/puradd/index',
  'his/Data/index',
  'his/chat/index'
);

-- 7) Down-sink monitoring and tools (keep audit logs visible)
UPDATE sys_menu
SET visible = '1'
WHERE component IN (
  'monitor/server/index',
  'monitor/cache/index',
  'monitor/cache/list',
  'monitor/druid/index',
  'monitor/job/index',
  'monitor/online/index',
  'tool/build/index',
  'tool/gen/index',
  'tool/swagger/index'
);
