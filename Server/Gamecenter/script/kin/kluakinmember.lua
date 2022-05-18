-------------------------------------------------------------------
--File: kluakinmember.lua
--Author: lbh
--Date: 2007-7-3 16:20
--Describe: KLuaKinMember扩展脚本指令
-------------------------------------------------------------------
if not _KLuaKinMember then --调试需要
	_KLuaKinMember = {}
	print(GetLocalDate("%Y\\%m\\%d  %H:%M:%S").." build ok ..")
end

local self	--作为第一个Up Value

--用于生成家族任务变量对应的指令
local function _GEN_TASK_FUN(szDesc, nTaskId)
	local funGet = 
		function ()
			return self.GetTask(nTaskId)
		end
	local funSet = 
		function (nValue)
			return self.SetTask(nTaskId, nValue)
		end
	local funAdd = 
		function (nValue)
			return self.AddTask(nTaskId, nValue)
		end
	rawset(_KLuaKinMember, "Get"..szDesc, funGet)
	rawset(_KLuaKinMember, "Set"..szDesc, funSet)
	rawset(_KLuaKinMember, "Add"..szDesc, funAdd)
end

--单Bit指令
local function _GEN_TASK_FUN_FLAG(szDesc, nTaskId, nPos)
	local funGet = 
		function ()
			return self.GetTaskFlag(nTaskId, nPos)
		end
	local funSet = 
		function (nValue)
			return self.SetTaskFlag(nTaskId, nPos, nValue)
		end
	rawset(_KLuaKinMember, "Get"..szDesc, funGet)
	rawset(_KLuaKinMember, "Set"..szDesc, funSet)
end

local function _GEN_TMP_TASK_FUN(szDesc, nTaskId)
	local funGet = 
		function ()
			return self.GetTmpTask(nTaskId)
		end
	local funSet = 
		function (nValue)
			return self.SetTmpTask(nTaskId, nValue)
		end
	local funAdd = 
		function (nValue)
			return self.AddTmpTask(nTaskId, nValue)
		end
	rawset(_KLuaKinMember, "Get"..szDesc, funGet)
	rawset(_KLuaKinMember, "Set"..szDesc, funSet)
	rawset(_KLuaKinMember, "Add"..szDesc, funAdd)
end

_GEN_TASK_FUN("JoinTime", 1)				-- 加入时间
_GEN_TASK_FUN("Figure", 2)					-- 职位
--_GEN_TASK_FUN("Repute", 3)					-- 江湖威望
_GEN_TASK_FUN("Ballot", 4)					-- 族长竞选票数
_GEN_TASK_FUN("VoteState", 5)				-- 是否已投票
_GEN_TASK_FUN("VoteJourNum", 6)				-- 投票的序号
_GEN_TASK_FUN("TongFlag", 7)				-- 帮会的一些标志
_GEN_TASK_FUN("EnvoyFigure", 8)				-- 掌令使职位
_GEN_TASK_FUN("LeaveInitTime", 9)			-- 退出家族申请的起始时间
_GEN_TASK_FUN("QuitVoteState", 10)			-- 是否表决过退出帮会，表决结果:0 未必表决； 1 同意； 2 拒绝
_GEN_TASK_FUN("WageFigure", 11) 			-- 上周工资发放职位记录.
_GEN_TASK_FUN("WageValue", 12) 				-- 上周工资已领取数量.
_GEN_TASK_FUN("RetireTime",13)				-- 申请退隐时间
_GEN_TASK_FUN("KinOffer", 14)				-- 玩家的家族贡献度
--_GEN_TASK_FUN("WeeklyTongOffer", 15)		-- 本周帮会贡献度 已无效
_GEN_TASK_FUN("WeeklyKinOffer", 16)			-- 本周家族贡献度
_GEN_TASK_FUN("LastWeekKinOffer", 17)		-- 上周家族贡献度
_GEN_TASK_FUN("PersonalStock", 18)			-- 个人股份数
_GEN_TASK_FUN("StockFigure", 19)			-- 股权职位
_GEN_TASK_FUN("TongVoteState", 5)			-- 帮主竞选是否已投票
_GEN_TASK_FUN("GreatMemberVote", 20)		-- 优秀成员竞选票数
_GEN_TASK_FUN("MemberVoteNo", 21)			-- 优秀成员竞选投票的流水号
_GEN_TASK_FUN("ReceiveGreatBonusNo", 22)	-- 优秀成员竞选领奖的流水号



--定义帮会变量标志
_GEN_TASK_FUN_FLAG("BitExcellent", 7, 1)	--是否精英
_GEN_TASK_FUN_FLAG("Can2Regular", 7, 2)		-- 能否转正

if not MODULE_GAMECLIENT then
	--临时任务变量定义
	_GEN_TMP_TASK_FUN("PlayerId", 1)		--玩家Id
	_GEN_TMP_TASK_FUN("KickBallot", 2)	--开除成员的响应计数
else
	_GEN_TASK_FUN("PlayerId", 1001)
	_GEN_TASK_FUN("Online", 1002)	
	_GEN_TASK_FUN("Level", 1003)
	_GEN_TASK_FUN("Sex", 1004)
	_GEN_TASK_FUN("Faction", 1005)
	_GEN_TASK_FUN("HonorRank", 1006)
	_GEN_TASK_FUN("Honor", 1007)
	_GEN_TASK_FUN("ClientRepute", 1008)
	_GEN_TASK_FUN("Platform_MonthScore", 1009)
	_GEN_TASK_FUN("Platform_TotalScore", 1010)
end
