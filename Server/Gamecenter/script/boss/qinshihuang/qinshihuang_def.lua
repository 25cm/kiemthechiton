-------------------------------------------------------
-- 文件名　：qinshihuang_def.lua
-- 创建者　：zhangjinpin@kingsoft
-- 创建时间：2009-06-20 14:20:37
-- 文件描述：
-------------------------------------------------------

local tbQinshihuang = {};
Boss.Qinshihuang = tbQinshihuang;

tbQinshihuang.TASK_GROUP_ID = 2098;		-- 任务变量组

tbQinshihuang.TASK_USE_TIME = 1;		-- 每日皇陵使用时间
tbQinshihuang.TASK_START_TIME = 2		-- 最后一次皇陵开启时间
tbQinshihuang.TASK_BUFF_LEVEL = 3;		-- 正面buff等级
tbQinshihuang.TASK_BUFF_FRAME = 4;		-- 正面buff剩余时间
tbQinshihuang.TASK_PROTECT = 5;			-- 宕机保护
tbQinshihuang.TASK_SAVEDATE = 8;
tbQinshihuang.TASK_REFINE_ITEM = 10;		-- 每天使用炼化声望物品的个数

tbQinshihuang.MAX_DAILY_TIME = 60 * 60 * 2;	-- 每天2小时
tbQinshihuang.MAX_DAILY_REFINEITEM = 10;	-- 每天使用炼化声望物品的个数

tbQinshihuang.SMALL_BOSS_POS_PATH = "\\setting\\boss\\qinshihuang\\smallboss_pos.txt";

tbQinshihuang.tbYemingzhu =				-- 夜明珠需求，暂时不用配置表了
{
	[1] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	[2] = {0, 0, 0, 0, 0, 0, 1, 1, 3, 5},
	[3] = {0, 0, 0, 0, 0, 1, 1, 3, 9, 15},
	[4] = {0, 0, 0, 1, 1, 1, 2, 6, 18, 30},
	[5] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
};

if not tbQinshihuang.tbBoss then	
	tbQinshihuang.tbBoss = {};			-- {{nTempId, nStep, nDeathCount}}
end

if not tbQinshihuang.tbPlayerList then
	tbQinshihuang.tbPlayerList = {}; 	-- {{PlayerId, {MapLevel, StartTime}}}
end

tbQinshihuang._bOpen = 1;				-- 系统开关
tbQinshihuang.bOpenQinFive = 0;			-- 第五层开关