-------------------------------------------------------------------
--File: statlog.lua
--Author: lbh
--Date: 2008-3-18 15:31:26
--Describe: 统计Log
-------------------------------------------------------------------
--KStatLog.ModifyField(szTable, szKey, szField, value)
--KStatLog.ModifyMax(szTable, szKey, szField, nValue)
--KStatLog.ModifyMin(szTable, szKey, szField, nValue)
--KStatLog.ModifyAdd(szTable, szKey, szField, nValue)
-- 类型：0普通，1Daily，2Weekly, 3DailyBackup

if (MODULE_GAMECLIENT) then
	return;	-- 防止全包外客户端报错
end

StatLog.StatTaskGroupId = 2048;

-- [表名必须全部小写]
local aTableDefine = {
	["roleinfo"] 	= {"Tên", 3},
	["jxb"] 		= {"途径", 1},
	["ibshop"] 		= {"道具名称", 1},
	["ibitem"] 		= {"道具名称", 3},
	["mixstat"]	 	= {"项目", 1},
--	["tifu"] = {"项目", 1}, --90级技能体服Log
	["armycamp"] 	= {"军营", 3},
	--["zhongqiu"] 	= {"道具名称", 1},	--中秋log
	--["ui"] 		= {"点击数据统计", 3},
	["xoyogame"] 	= {"逍遥谷", 1},
	["wlls"] 		= {"联赛级别", 1}, --武林联赛
	["kinweeklytask"] 	= {"周活动项目", 2},	-- 帮会家族周活动数据分析（家族）
	["personweeklytask"]= {"周活动项目", 2}, -- 帮会家族周活动数据分析（成员）
	["playercount"] = {"时间点和地图", 3},	-- 黄金时段玩家行为统计
	["bindcoin"] 	= {"途径", 1},	--绑定金币
	["bindjxb"] 	= {"途径", 1},	--绑定银两
	["coin"] 	= {"途径", 1},	--金币
};

local function AddTable()
	for szTable, aTableInfo in pairs(aTableDefine) do
		
		KStatLog.AddTable(szTable, aTableInfo[1], aTableInfo[2]);
	end
end

AddTable();
