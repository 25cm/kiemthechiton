-- 交易稅數據定義

local preEnv = _G;	--保存舊的環境
setfenv(1, TradeTax);	--設置當前環境為TradeTax;

MIN_WEIWANG 		= 500;
TAX_TO_WELFARE		= 0.8;	-- 稅收與福利轉換率
UNIT_WEL_MAX		= 50000

-- 玩家任務變量
TAX_TASK_GROUP		= 2022; -- 任務組ID號
TAX_WEL_JOU_TASK_ID = 1;	-- 周福利流水號
TAX_LEVEL_TASK_ID 	= 2;	-- 福利檔次
TAX_AMOUNT_TASK_ID	= 3;	-- 本周交易額
TAX_JOU_TASK_ID		= 4;	-- 交易記錄周流水號
TAX_ACCOUNT_TASK_ID	= 5;	-- 本周交稅情況
CLEAR_DATE			= 0;	-- 周日0點更新

TAX_REGION_MAXNUMBER	= 0.20	-- 30000001+ 收稅 20%
TAX_CHANGED			= 0;

-- TODO:臨時的收稅區
ORIG_TAX_REGION = 
{
	[1] = {800000,  	0},
	[2] = {2000000, 	0.02},
	[3] = {5000000, 	0.04},
	[4] = {10000000, 	0.06},
	[5] = {30000000, 	0.08},
}

-- 計算使用
TAX_REGION = 
{
	[1] = {800000,  	0},
	[2] = {2000000, 	0.02},
	[3] = {5000000, 	0.04},
	[4] = {10000000, 	0.06},
	[5] = {30000000, 	0.08},
}

-- TODO：臨時福利檔次對應表
WELFARE_LEVEL = 
{
	[1] = {500, 		2},
	[2] = {1000,		4},
	[3] = {1500, 		5},
}

--恢復全局環境
preEnv.setfenv(1, preEnv);
