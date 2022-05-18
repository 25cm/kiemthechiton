-------------------------------------------------------
-- 文件名　：youlongmibao_def.lua
-- 创建者　：zhangjinpin@kingsoft
-- 创建时间：2009-10-29 14:30:36
-- 文件描述：
-------------------------------------------------------

Youlongmibao.TASK_GROUP_ID 				= 2106;	-- 游龙密窑
Youlongmibao.TASK_YOULONG_HAVEAWARD		= 1;	-- 有奖未领
Youlongmibao.TASK_YOULONG_INTERVAL		= 2;	-- 挑战间隔
Youlongmibao.TASK_YOULONG_COUNT			= 3;	-- 累计次数
Youlongmibao.TASK_YOULONG_HAPPY_EGG		= 6;	-- 是否已经拿过开心蛋；0为未拿

Youlongmibao.TaskId_Day = 15; --task l?u ngày
Youlongmibao.Use_Max = 7; --so lan toi da

Youlongmibao.MAX_TIMES 					= 4;	-- 最多进行4次
Youlongmibao.MAX_GRID					= 25;	-- 格子数量
Youlongmibao.MAX_INTERVAL				= 20;	-- 挑战间隔20秒

-- ITEM ID
Youlongmibao.ITEM_YUEYING	= {18, 1, 476, 1};	-- 月影之石
Youlongmibao.ITEM_ZHANSHU	= {18, 1, 524, 1};	-- 游龙战书
Youlongmibao.ITEM_COIN		= {18, 1, 553, 1};	-- 游龙古币
Youlongmibao.ITEM_HAPPYEGG	= "18,1,525,1" 		-- 开心蛋
Youlongmibao.DEF_GET_HAPPYEGG_COUNT	= 5;		-- 前5次必得一个开心蛋

-- NPC ID
Youlongmibao.NPC_DIALOG			= 3690;
Youlongmibao.NPC_FIGHT			= 3689;

-- 多语言开关
Youlongmibao.bOpen = EventManager.IVER_bOpenYoulongmibao;
--Youlongmibao.bOpen = 1;

-- 表的路径
Youlongmibao.TYPE_RATE_PATH = "\\setting\\event\\youlongmibao\\youlongmibao_rate.txt";
