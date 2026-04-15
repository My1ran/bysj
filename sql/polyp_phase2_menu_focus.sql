-- Phase 2: 菜单收敛（隐藏/下沉）
-- 目标：突出“首页统计 + 息肉检测 + 历史任务 + 系统日志”
-- 注意：本脚本仅隐藏菜单入口，不物理删除代码和数据表

-- 1) 确保息肉检测主入口可见并靠前
UPDATE sys_menu
SET menu_name = '息肉检测中心',
    visible = '0',
    status = '0',
    order_num = 1
WHERE component = 'system/polyp/index';

-- 2) 隐藏旧检测入口（历史同步链路，避免与新链路重复）
UPDATE sys_menu
SET visible = '1'
WHERE component = 'system/detection/index'
   OR perms LIKE 'system:detection:%';

-- 3) 隐藏与当前演示主题弱相关的 HIS 菜单（his:*）
UPDATE sys_menu
SET visible = '1'
WHERE perms LIKE 'his:%';

-- 4) 隐藏与息肉检测主题弱相关的系统业务菜单（仅隐藏入口）
UPDATE sys_menu
SET visible = '1'
WHERE perms LIKE 'system:student:%'
   OR perms LIKE 'system:cost:%'
   OR perms LIKE 'system:cost2:%'
   OR perms LIKE 'system:depts:%'
   OR perms LIKE 'system:docters:%'
   OR perms LIKE 'system:drug:%'
   OR perms LIKE 'system:factory:%'
   OR perms LIKE 'system:pati:%'
   OR perms LIKE 'system:patient:%'
   OR perms LIKE 'system:purchase:%'
   OR perms LIKE 'system:reg:%'
   OR perms LIKE 'system:supplier:%';

-- 5) 按组件路径兜底隐藏（避免部分菜单无 perms 导致漏网）
UPDATE sys_menu
SET visible = '1'
WHERE component IN (
    'system/addpati/index',
    'system/cost/index',
    'system/cost2/index',
    'system/depts/index',
    'system/docters/index',
    'system/drug/index',
    'system/factory/index',
    'system/pati/index',
    'system/patient/index',
    'system/purchase/index',
    'system/reg/index',
    'system/regadd/index',
    'system/supplier/index',
    'system/student/index',
    'his/chargedetail/index',
    'his/depts/index',
    'his/docters/index',
    'his/purchase/index',
    'his/puradd/index',
    'his/Data/index'
);

-- 6) 保留系统基础能力（用户/角色/菜单/日志/参数）不做隐藏
-- 无需 SQL，默认保持现状。
