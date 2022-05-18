-- FileName	: relationrulemgr.lua
-- Author	: furuilei
-- Time		: 2010-3-2 10:36
-- Comment	: 人际关系逻辑规则

if (not MODULE_GC_SERVER) then
	return;
end

Require("\\script\\player\\define.lua");

local tbRelayRuleMgr = Relation.tbRelayRuleMgr or {};
Relation.tbRelayRuleMgr = tbRelayRuleMgr;

--==================================================

tbRelayRuleMgr.SZ_FILE_TRAINING = "\\setting\\relation\\training.ini";
tbRelayRuleMgr.SZ_FILE_RELATION = "\\setting\\relation\\relation.ini";
tbRelayRuleMgr.SZ_FILE_FAVORLEVEL = "\\setting\\relation\\favorlevel.txt";

tbRelayRuleMgr.CHECKTYPE_POSSIDE = 1; -- 检查规则，正向
tbRelayRuleMgr.CHECKTYPE_REVSIDE = 2; -- 检查规则，反向
tbRelayRuleMgr.CHECKTYPE_ALLSIDE = 3; -- 检查规则，双向

---- 人际关系规则策略
--tbRelayRuleMgr.tbRuleManager = {
--	{1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0}, -- 临时好友
--	{1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0}, -- 黑名单
--	{1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1}, -- 普通好友
--	{1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1}, -- 结拜（兄弟，姐妹）
--	{1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0}, -- 仇人
--	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, -- 当前师徒
--	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, -- 出师师徒
--	{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, -- 夫妻
--	{1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 1}, -- 介绍人
--	{1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1}, -- 指定密友
--	};
--	
---- 上表中每项依次代表的含义
--tbRelayRuleMgr.SYNCTOSERVER_ASMASTER = 1; -- 是否把关系同步到gameserver（自己作为主位玩家）
--tbRelayRuleMgr.SYNCTOSERVER_ASTARGET = 2; -- 是否把关系信息同步到GameServer（自己作为次位玩家）
--tbRelayRuleMgr.SYNCTOCLIENT_ASMASTER = 3; -- 是否把关系信息同步到客户端（自己作为主位玩家）
--tbRelayRuleMgr.SYNCTOCLIENT_ASTARGET = 4; -- 是否把关系信息同步到客户端（自己作为次位玩家）
--tbRelayRuleMgr.NOTIFYONLINE_ASMASTER = 5; -- 自己上线时是否需要通知好友（自己作为主位玩家）
--tbRelayRuleMgr.NOTIFYONLINE_ASTARGET = 6; -- 自己上线时是否需要通知好友（自己作为次位玩家）
--tbRelayRuleMgr.NOTIFYDELETE_ASMASTER = 7; -- 自己删号时是否需要通知好友（自己作为主位玩家）
--tbRelayRuleMgr.NOTIFYDELETE_SATARGET = 8; -- 自己删号时是否需要通知好友（自己作为次位玩家）
--tbRelayRuleMgr.NOTIFYTARGETCREATION  = 9; -- 是否把建立关系事件通知给次位玩家
--tbRelayRuleMgr.NOTIFYDELETE_TOMASTER = 10; -- 是否把关系删除通知主位玩家
--tbRelayRuleMgr.NOTIFYDELETE_TOTARGET = 11; -- 是否把关系删除通知次位玩家

-- 建立关系的冲突规则
tbRelayRuleMgr.tbCreateRepRule = {
	-- 临时好友
	[Player.emKPLAYERRELATION_TYPE_TMPFRIEND] = {
		{nType = Player.emKPLAYERRELATION_TYPE_BLACKLIST, nMode = tbRelayRuleMgr.CHECKTYPE_POSSIDE},
		{nType = Player.emKPLAYERRELATION_TYPE_BIDFRIEND, nMode = tbRelayRuleMgr.CHECKTYPE_POSSIDE},
		{nType = Player.emKPLAYERRELATION_TYPE_ENEMEY, nMode = tbRelayRuleMgr.CHECKTYPE_POSSIDE}
		},
	
	-- 黑名单
	[Player.emKPLAYERRELATION_TYPE_BLACKLIST] = {
		{nType = Player.emKPLAYERRELATION_TYPE_TMPFRIEND, nMode = tbRelayRuleMgr.CHECKTYPE_POSSIDE},
		{nType = Player.emKPLAYERRELATION_TYPE_BIDFRIEND, nMode = tbRelayRuleMgr.CHECKTYPE_POSSIDE},
		{nType = Player.emKPLAYERRELATION_TYPE_ENEMEY, nMode = tbRelayRuleMgr.CHECKTYPE_POSSIDE}
		},
	
	-- 仇人
	[Player.emKPLAYERRELATION_TYPE_ENEMEY] = {
		{nType = Player.emKPLAYERRELATION_TYPE_TMPFRIEND, nMode = tbRelayRuleMgr.CHECKTYPE_POSSIDE},
		{nType = Player.emKPLAYERRELATION_TYPE_BLACKLIST, nMode = tbRelayRuleMgr.CHECKTYPE_POSSIDE},
		{nType = Player.emKPLAYERRELATION_TYPE_BIDFRIEND, nMode = tbRelayRuleMgr.CHECKTYPE_POSSIDE},
		{nType = Player.emKPLAYERRELATION_TYPE_ENEMEY, nMode = tbRelayRuleMgr.CHECKTYPE_POSSIDE}
		}
	};

-- 建立关系的依赖规则
tbRelayRuleMgr.tbCreateDepRule = {
	-- 结拜
	[Player.emKPLAYERRELATION_TYPE_SIBLING] = {
		{nType = Player.emKPLAYERRELATION_TYPE_BIDFRIEND, nMode = tbRelayRuleMgr.CHECKTYPE_POSSIDE},
		},
	-- 师徒
	[Player.emKPLAYERRELATION_TYPE_TRAINING] = {
		{nType = Player.emKPLAYERRELATION_TYPE_BIDFRIEND, nMode = tbRelayRuleMgr.CHECKTYPE_POSSIDE},
		},
	[Player.emKPLAYERRELATION_TYPE_TRAINED] = {
		{nType = Player.emKPLAYERRELATION_TYPE_BIDFRIEND, nMode = tbRelayRuleMgr.CHECKTYPE_POSSIDE},
		},
	-- 夫妻
	[Player.emKPLAYERRELATION_TYPE_COUPLE] = {
		{nType = Player.emKPLAYERRELATION_TYPE_BIDFRIEND, nMode = tbRelayRuleMgr.CHECKTYPE_POSSIDE},
		},
	};

-- 删除关系的依赖规则
tbRelayRuleMgr.tbDeleteDepRule = {
	-- 普通好友
	[Player.emKPLAYERRELATION_TYPE_BIDFRIEND] = {
		{nType = Player.emKPLAYERRELATION_TYPE_SIBLING, nMode = tbRelayRuleMgr.CHECKTYPE_ALLSIDE},
		{nType = Player.emKPLAYERRELATION_TYPE_TRAINING, nMode = tbRelayRuleMgr.CHECKTYPE_ALLSIDE},
		{nType = Player.emKPLAYERRELATION_TYPE_TRAINED, nMode = tbRelayRuleMgr.CHECKTYPE_ALLSIDE},
		{nType = Player.emKPLAYERRELATION_TYPE_COUPLE, nMode = tbRelayRuleMgr.CHECKTYPE_ALLSIDE},
		{nType = Player.emKPLAYERRELATION_TYPE_INTRODUCTION, nMode = tbRelayRuleMgr.CHECKTYPE_ALLSIDE},
		{nType = Player.emKPLAYERRELATION_TYPE_BUDDY, nMode = tbRelayRuleMgr.CHECKTYPE_ALLSIDE},
		},
	};
	
--==================================================

-- 初始化拜师的条件
function tbRelayRuleMgr:InitTrainingCond()
	local tbIniInfo = Lib:LoadIniFile(self.SZ_FILE_TRAINING);
	assert(tbIniInfo);
	local tbTrainingCond = self.tbTrainingCond or {};
	self.tbTrainingCond = tbTrainingCond;
	local tbData = tbIniInfo["Global"];
	tbTrainingCond.nStudentMinLevel = tonumber(tbData["StudentMinLevel"]);
	tbTrainingCond.nStudentMaxLevel = tonumber(tbData["StudentMaxLevel"]);
	tbTrainingCond.nTeacherMinLevel = tonumber(tbData["TeacherMinLevel"]);
	tbTrainingCond.nCurrentStudentMaxCount = tonumber(tbData["CurrentStudentMaxCount"]);
	tbTrainingCond.nMonthlyStudentMaxCount = tonumber(tbData["MonthlyStudentMaxCount"]);
	tbTrainingCond.nGapMinLevel = tonumber(tbData["GapMinLevel"]);
end

-- 初始化人际全局的一些条件
function tbRelayRuleMgr:InitRelationCond()
	local tbIniInfo = Lib:LoadIniFile(self.SZ_FILE_RELATION);
	assert(tbIniInfo);
	local tbSystemCond = self.tbSystemCond or {};
	self.tbSystemCond = tbSystemCond;
	local tbData = tbIniInfo["system"];
	tbSystemCond.nMaxFavorEveryDayWithIB = tonumber(tbData["MaxFavorEveryDayWithIB"]);
	tbSystemCond.nMaxFavorEveryDayWithoutIB = tonumber(tbData["MaxFavorEveryDayWithoutIB"]);
	tbSystemCond.nMinFavor = tonumber(tbData["MinFavor"]);
	tbSystemCond.nMaxFavor = tonumber(tbData["MaxFavor"]);
	tbSystemCond.nMaxRelationCount = tonumber(tbData["MaxRelationCount"]);
	
	local tbFriendAward = self.tbFriendAward or {};
	self.tbFriendAward = tbFriendAward;
	tbData = tbIniInfo["friendaward"];
	local nCount = tonumber(tbData["Count"]);
	if (nCount <= 0) then
		return;
	end
	for i = 1, nCount do
		local szMaxLevel = "MaxLevel" .. i;
		local szAward = "Award" .. i;
		local nMaxLevel = tonumber(tbData[szMaxLevel]);
		local nAward = tonumber(tbData[szAward]);
		local tbTemp = {};
		tbTemp.nMaxCount = nMaxLevel;
		tbTemp.nAward = nAward;
		tbFriendAward[i] = tbTemp;
	end
end

-- 装载favorlevel.txt 信息
function tbRelayRuleMgr:LoadFavorLevelSetting()
	local tbFavorLevelSetting = KLib.LoadTabFile(self.SZ_FILE_FAVORLEVEL);
	assert(tbFavorLevelSetting);
end

function tbRelayRuleMgr:InitRule()
	self:InitTrainingCond();
	self:InitRelationCond();
end
tbRelayRuleMgr:InitRule();

--==================================================

-- 检查建立关系时的依赖和冲突关系
function tbRelayRuleMgr:CheckCreateDepRep(nType, nRole, nAppId, nDstId)
	if (nRole == 0) then
		nAppId, nDstId = nDstId, nAppId;
	end
	
	if (self:CheckCreateDep(nType, nAppId, nDstId) == 1 and
		self:CheckCreateRep(nType, nAppId, nDstId) == 1) then
		return 1;
	else
		return 0;
	end
end

-- 检查指定的冲突和依赖关系是否成立
function tbRelayRuleMgr:CheckSpeRule(nCheckMode, nPlayerId1, nPlayerId2, nType, nWishResult)
	if (nCheckMode == self.CHECKTYPE_POSSIDE) then
		if (KRelation.FindRelation(nPlayerId1, nPlayerId2, nType) == nWishResult) then
			return 1;
		else
			return 0;
		end
	end
	
	if (nCheckMode == self.CHECKTYPE_REVSIDE) then
		if (KRelation.FindRelation(nPlayerId2, nPlayerId1, nType) == nWishResult) then
			return 1;
		else
			return 0;
		end
	end
	
	if (nCheckMode == self.CHECKTYPE_ALLSIDE) then
		if (KRelation.FindRelation(nPlayerId1, nPlayerId2, nType) == nWishResult and
			KRelation.FindRelation(nPlayerId2, nPlayerId1, nType) == nWishResult) then
			return 1;
		else
			return 0;
		end
	end
end

-- 检查删除关系时的依赖和冲突关系
function tbRelayRuleMgr:CheckDelDepRep(nType, nRole, nAppId, nDstId)
	if (not self.tbDeleteDepRule[nType]) then
		return 1;
	end
	
	if (nRole == 0) then
		nAppId, nDstId = nDstId, nAppId;
	end

	local tbRule = self.tbDeleteDepRule[nType];
	local bRet = 1;
	for _, tbInfo in pairs(tbRule) do
		local nNeedCheckType = tbInfo.nType;
		local nCheckMode = tbInfo.nMode;
		if (self:CheckSpeRule(nCheckMode, nAppId, nDstId, nNeedCheckType, 0) == 0) then
			bRet = 0;
			break;
		end
	end
	return bRet;
end

function tbRelayRuleMgr:CheckCreateDep(nType, nAppId, nDstId)
	if (not self.tbCreateDepRule[nType]) then
		return 1;
	end
	local tbRule = self.tbCreateDepRule[nType];
	local bRet = 1;
	for _, tbInfo in pairs(tbRule) do
		local nNeedCheckType = tbInfo.nType;
		local nCheckMode = tbInfo.nMode;
		if (self:CheckSpeRule(nCheckMode, nAppId, nDstId, nNeedCheckType, 1) == 0) then
			bRet = 0;
			break;
		end
	end
	return bRet;
end

function tbRelayRuleMgr:CheckCreateRep(nType, nAppId, nDstId)
	if (not self.tbCreateRepRule[nType]) then
		return 1;
	end
	
	local tbRule = self.tbCreateRepRule[nType];
	local bRet = 1;
	for _, tbInfo in pairs(tbRule) do
		local nNeedCheckType = tbInfo.nType;
		local nCheckMode = tbInfo.nMode;
		if (self:CheckSpeRule(nCheckMode, nAppId, nDstId, nNeedCheckType, 0) == 0) then
			bRet = 0;
			break;
		end
	end
	return bRet;
end

--==================================================

-- 判断在某一个亲密度等级段，玩家是否可以获得奖励
function tbRelayRuleMgr:CanGetAward(nFavorLevel, nCurCount)
	if (nFavorLevel < 1 or nFavorLevel > 10) then
		return 0;
	end
	local tbAwardInfo = self.tbFriendAward[nFavorLevel];
	if (not tbAwardInfo) then
		return 0;
	end
	local nMaxCount = tbAwardInfo.nMaxCount;
	if (nMaxCount <= nCurCount) then
		return 0;
	end
	return 1;
end

-- 获取在某一个亲密度等级段，玩家可以获得的绑金奖励数量
function tbRelayRuleMgr:GetAwardNum(nFavorLevel)
	if (nFavorLevel < 1 or nFavorLevel > 10) then
		return 0;
	end
	local tbAwardInfo = self.tbFriendAward[nFavorLevel];
	if (not tbAwardInfo) then
		return 0;
	end
	return tbAwardInfo.nAward or 0;
end

function tbRelayRuleMgr:GetFavorMaxCountByLevel(nFavorLevel)
	if (nFavorLevel < 1 or nFavorLevel > 10) then
		return 0;
	end
	local tbAwardInfo = self.tbFriendAward[nFavorLevel];
	if (not tbAwardInfo) then
		return 0;
	end
	return tbAwardInfo.nMaxCount or 0;
end
