--武林联赛
--孙多良
--2008.09.12
--GC/GS

function Wlls:GetTimeFrameState()
	if (GLOBAL_AGENT) then
		return 1;
	end
	local nSec = KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL150);
	if nSec <= 0 then
		return 0;--联赛未开启
	end
	local nMonth = tonumber(os.date("%Y%m", nSec));
	local nNowMonth = tonumber(GetLocalDate("%Y%m"));
	if nNowMonth > nMonth then
		return 1;--联赛开启
	end
	return 0;--联赛未开启
end

--用时间获得比赛属于哪个时期(7,27,28)
--1：间歇期		(28 24:00 - 7  00:00)
--2：比赛期		( 7 00:00 - 27 24:00)
--3. 八强赛期	(27 24:00 - 28 24:00)
function Wlls:GetMatchStateForDate()
	local nDate = tonumber(os.date("%d%H%M", GetTime()));
	
	--判断间歇期
	for nId, tbState in ipairs(Wlls.DATE_START_DAY) do
		local nStartDate = tbState[3] * 10000 + 2400;
		local nEndDate	 = Wlls.DATE_START_DAY[1][1] * 10000;
		if Wlls.DATE_START_DAY[nId + 1] then
			nEndDate = Wlls.DATE_START_DAY[nId + 1][1] * 10000;
		end
		
		--跨了月处理
		if nStartDate > nEndDate then
			if nDate > nStartDate then
				return Wlls.DEF_STATE_REST;
			end
			if nDate < nEndDate then
				return Wlls.DEF_STATE_REST;
			end
		else
			if nDate > nStartDate and nDate < nEndDate then
				return Wlls.DEF_STATE_REST;
			end
		end
	end
	
	--判断比赛期
	for nId, tbState in ipairs(Wlls.DATE_START_DAY) do
		local nStartDate = tbState[1]*10000;
		local nEndDate	 = tbState[2]*10000 + 2400;
		
		--跨了月处理
		if nStartDate > nEndDate then
			if nDate >= nStartDate then
				return Wlls.DEF_STATE_MATCH;
			end
			if nDate <= nEndDate then
				return Wlls.DEF_STATE_MATCH;
			end
		else
			if nDate >= nStartDate and nDate <= nEndDate then
				return Wlls.DEF_STATE_MATCH;
			end
		end
	end	
	
	--判断八强赛期
	for nId, tbState in ipairs(Wlls.DATE_START_DAY) do
		local nStartDate = tbState[2]*10000;
		local nEndDate	 = tbState[3]*10000 + 2400;
		
		--跨了月处理
		if nStartDate > nEndDate then
			if nDate > nStartDate then
				return Wlls.DEF_STATE_ADVMATCH;
			end
			if nDate < nEndDate then
				return Wlls.DEF_STATE_ADVMATCH;
			end
		else
			if nDate > nStartDate and nDate < nEndDate then
				return Wlls.DEF_STATE_ADVMATCH;
			end
		end
	end
	
	return Wlls.DEF_STATE_CLOSE;
end

function Wlls:GetMatchStartForDate(nDay)
	for _, tbDate in ipairs(Wlls.DATE_START_DAY) do
		if tbDate[1] == nDay then
			return 1
		end
	end
	return 0;	
end

function Wlls:GetMatchEndForDate(nDay)
	for _, tbDate in ipairs(Wlls.DATE_START_DAY) do
		if tbDate[2] == nDay then
			return 1
		end
	end
	return 0;
end

--获得赛制类型配置表
function Wlls:GetMacthTypeCfg(nMacthType)
	if not nMacthType or nMacthType <= 0 then
		return
	end
	return self.MacthType[self.MACTH_TYPE[nMacthType]];
end

--获得赛制等级配置表
function Wlls:GetMacthLevelCfg(nMacthType, nMacthLevel)
	if not nMacthType or nMacthType <= 0 then
		return
	end
	return self.MacthType[self.MACTH_TYPE[nMacthType]][self.MACTH_LEVEL[nMacthLevel]];
end

--获得当前赛制类型
function Wlls:GetMacthLevelCfgType()
	local nRankSession = Wlls:GetMacthSession();
	if Wlls:GetMacthTypeCfg(Wlls:GetMacthType(nRankSession)) then
		return Wlls:GetMacthTypeCfg(Wlls:GetMacthType(nRankSession)).nMapLinkType;
	end
	return 0;
end

--获得地图对应的编号(0,所有场，1会场)
function Wlls:GetMacthMapSeriesId(nMacthLevel, nMapId, nMapType)
	local tbMapLevel = Wlls:GetMacthLevelCfg(Wlls:GetMacthType(), nMacthLevel);
	if not nMapType or nMapType == 0 then
		for _, tbMapList in pairs(tbMapLevel) do
			for nId, nUseMapId in ipairs(tbMapList) do
				if nUseMapId == nMapId then
					return nId;
				end
			end
		end
	end
	if nMapType == 1 then
		for nId, nUseMapId in ipairs(tbMapLevel.tbIntoMap) do
			if nUseMapId == nMapId then
				return nId;
			end
		end
	end
	
	return 0;
end

--获得赛制类型,Int
function Wlls:GetMacthType(nSession)
	if not nSession then
		if not self.SEASON_TB[KGblTask.SCGetDbTaskInt(self.GTASK_MACTH_SESSION)] then
			return 0;
		end
		return self.SEASON_TB[KGblTask.SCGetDbTaskInt(self.GTASK_MACTH_SESSION)][1];
	
	else
		if not self.SEASON_TB[nSession] then
			return 0;
		end
		return self.SEASON_TB[nSession][1];
	end
	return 0;
end

--获得联赛届数
function Wlls:GetMacthSession()
	return KGblTask.SCGetDbTaskInt(self.GTASK_MACTH_SESSION);
end

--设置联赛届数
function Wlls:SetMacthSession(nSession)
	return KGblTask.SCSetDbTaskInt(self.GTASK_MACTH_SESSION, nSession);
end

--获得每个准备场最大战队数
function Wlls:GetPreMaxLeague()
	return Wlls.SEASON_TB[Wlls:GetMacthSession()][5];
end

--获得比赛时期
function Wlls:GetMacthState()
	return KGblTask.SCGetDbTaskInt(self.GTASK_MACTH_STATE)
end

--获得玩家荣誉排名
function Wlls:GetRank(szName)
	local nRank = GetPlayerHonorRankByName(szName, PlayerHonor.HONOR_CLASS_WLLS, 0);
	return nRank;
end

--获得玩家参加联赛等级
function Wlls:GetGameLevelForRank(szName)
	if (GLOBAL_AGENT) then
		if (MODULE_GAMESERVER) then
			local pPlayer = KPlayer.GetPlayerByName(szName);
			if (not pPlayer) then
				return self.MACTH_PRIM;
			end
			local nMoneyRank	= pPlayer.GetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_MONEY_RANK);
			local nWllsRank		= pPlayer.GetTask(GbWlls.TASKID_GROUP, GbWlls.TASKID_WLLS_RANK);
			if (self:GetMacthSession() >= self.MACTH_ADV_START_MISSION) and 
				((nMoneyRank > 0 and nMoneyRank <= GbWlls.DEF_ADV_MAXGBWLLS_MONEY_RANK) or (nWllsRank > 0 and nWllsRank <= GbWlls.DEF_ADV_MAXGBWLLS_WLLS_RANK)) then
				return self.MACTH_ADV;
			end			
		elseif (MODULE_GC_SERVER) then
			-- 这个有个漏洞就是假定gamecenter做这个判断的就一定是玩家已经建立了战队的
			local szLeagueName = League:GetMemberLeague(self.LGTYPE, szName);
			if (not szLeagueName) then
				return self.MACTH_PRIM;
			end
			local nResult = League:GetMemberTask(self.LGTYPE, szLeagueName, szName, self.LGMTASK_GBWLLSLEVEL);
			if (nResult == 0) then
				nResult = 1;
			end
			return nResult;
		end		
	else
		if self:GetMacthSession() >= self.MACTH_ADV_START_MISSION and self:GetRank(szName) > 0 and self:GetRank(szName) <= Wlls.SEASON_TB[Wlls:GetMacthSession()][3] then
			return self.MACTH_ADV;
		end
	end
	return self.MACTH_PRIM;
end

--获取荣誉值
function Wlls:GetHonor(szName)
	local nHonor = GetPlayerHonorByName(szName, PlayerHonor.HONOR_CLASS_WLLS, 0);
	return nHonor;
end

--设置荣誉值
function Wlls:SetHonor(szName, nHonor)
	SetPlayerHonorByName(szName, PlayerHonor.HONOR_CLASS_WLLS, 0, nHonor);
	return 0;
end

--增加荣誉值
function Wlls:AddHonor(szName, nHonor)
	if nHonor == 0 then
		return
	end
	if MODULE_GAMESERVER then
		GCExcute{"Wlls:AddHonor", szName, nHonor};
		
		--公告
		local nPlayerId = KGCPlayer.GetPlayerIdByName(szName);
		if nPlayerId and nPlayerId > 0 then
			local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
			if pPlayer then
				pPlayer.Msg(string.format("恭喜您获得了<color=yellow>%s点<color>联赛荣誉点", nHonor));
			end
		end
		return 0;
	end
	local nAddHonor = self:GetHonor(szName) + nHonor;
	self:SetHonor(szName, nAddHonor);	
end

--获得奖励等级段
function Wlls:GetAwardLevelSep(nGameLevel, nSession, nRank)
	if nRank <= 0 then
		return 0, 0;
	end
	for nLevelSep, nMaxRank in ipairs(self.AWARD_LEVEL[nSession][nGameLevel]) do
		if nRank <= nMaxRank then
			return nLevelSep, nMaxRank;
		end
	end
	return 0, 0;
end


--获得表中元素个数.
function Wlls:CountTableLeng(tbTable)
	local nLeng = 0;
	if type(tbTable) == 'table' then
		for Temp in pairs(tbTable) do
			nLeng = nLeng + 1;
		end
	end
	return nLeng;
end

--增加对手
function Wlls:AddMacthLeague(szLeagueName, szMacthLeagueId)
	local nEmy1Id = KLib.Number2UInt(League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_EMY1));
	local nEmy2Id = KLib.Number2UInt(League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_EMY2));
	local nEmy3Id = KLib.Number2UInt(League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_EMY3));
	local nEmy4Id = KLib.Number2UInt(League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_EMY4));
	local nEmy5Id = KLib.Number2UInt(League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_EMY5));
	if nEmy4Id > 0 then
		League:SetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_EMY5, nEmy4Id);
	end
	if nEmy3Id > 0 then
		League:SetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_EMY4, nEmy3Id);
	end
	if nEmy2Id > 0 then
		League:SetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_EMY3, nEmy2Id);
	end
	if nEmy1Id > 0 then
		League:SetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_EMY2, nEmy1Id);
	end
	League:SetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_EMY1, szMacthLeagueId);
end

--进入准备场
function Wlls:AddGroupMember(nGameLevel, nReadyId, szLeagueName, nPlayerId, szPlayerName)
	if not self.GroupList[nGameLevel][nReadyId] then
		self.GroupList[nGameLevel][nReadyId] = {};
	end
	
	if not self.GroupList[nGameLevel][nReadyId][szLeagueName] then
		self.GroupList[nGameLevel][nReadyId][szLeagueName] = {};
		self.GroupList[nGameLevel][nReadyId][szLeagueName].tbPlayerList = {};
		
		--战绩统计,胜率
		local nWin = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_WIN);
		local nTie = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_TIE);
		local nTotal   = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_TOTAL);
		local nRankAdv = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_RANK_ADV);
		local nRank    = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_RANK);
		local nWinRate =  Wlls.MACTH_NEW_WINRATE * 100;
		if nTotal > 0 then
			nWinRate = math.floor((nWin * 10000) / nTotal);
		end
		self.GroupList[nGameLevel][nReadyId][szLeagueName].nWinRate = nWinRate;
		self.GroupList[nGameLevel][nReadyId][szLeagueName].nRank 	= nRank;
		self.GroupList[nGameLevel][nReadyId][szLeagueName].nRankAdv = nRankAdv;
		--战队ID和战队对战历史记录
		self.GroupList[nGameLevel][nReadyId][szLeagueName].nNameId = tonumber(KLib.String2Id(szLeagueName));
		local nEmy1Id = KLib.Number2UInt(League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_EMY1));
		local nEmy2Id = KLib.Number2UInt(League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_EMY2));
		local nEmy3Id = KLib.Number2UInt(League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_EMY3));
		local nEmy4Id = KLib.Number2UInt(League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_EMY4));
		local nEmy5Id = KLib.Number2UInt(League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_EMY5));
		self.GroupList[nGameLevel][nReadyId][szLeagueName].tbHistory = {};
		if nEmy1Id > 0 then
			self.GroupList[nGameLevel][nReadyId][szLeagueName].tbHistory[nEmy1Id] = 1;
		end
		if nEmy2Id > 0 then
			self.GroupList[nGameLevel][nReadyId][szLeagueName].tbHistory[nEmy2Id] = 1;
		end
		if nEmy3Id > 0 then
			self.GroupList[nGameLevel][nReadyId][szLeagueName].tbHistory[nEmy3Id] = 1;
		end
		if nEmy4Id > 0 then
			self.GroupList[nGameLevel][nReadyId][szLeagueName].tbHistory[nEmy4Id] = 1;
		end
		if nEmy5Id > 0 then
			self.GroupList[nGameLevel][nReadyId][szLeagueName].tbHistory[nEmy5Id] = 1;
		end
	end
	table.insert(self.GroupList[nGameLevel][nReadyId][szLeagueName].tbPlayerList, nPlayerId);
end

--退出准备场
function Wlls:DelGroupMember(nGameLevel, nReadyId, szLeagueName, nPlayerId)
	if not self.GroupList[nGameLevel][nReadyId] or not  self.GroupList[nGameLevel][nReadyId][szLeagueName] then
		return
	end
	local tbTemp = {};
	if (MODULE_GC_SERVER) then
		tbTemp = self.GroupList[nGameLevel][nReadyId][szLeagueName]
		local nCount = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_ENTER);
		if nCount > 0 then
			League:SetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_ENTER, nCount - 1);
		end
	else
		tbTemp = self.GroupList[nGameLevel][nReadyId][szLeagueName].tbPlayerList
	end
	for ni, nId in pairs(tbTemp) do
		if nId == nPlayerId then
			table.remove(tbTemp, ni);
			break;
		end
	end
	if Wlls:CountTableLeng(tbTemp) <= 0 then
		self.GroupList[nGameLevel][nReadyId][szLeagueName] = nil
		if (MODULE_GC_SERVER) then
			KGblTask.SCSetDbTaskInt(self.GTASK_MACTH_MAP_STATE, 0);
			self.GroupList[nGameLevel][nReadyId].nLeagueCount = self.GroupList[nGameLevel][nReadyId].nLeagueCount - 1;
		end
	end
	if (not MODULE_GC_SERVER) then
		GCExcute{"Wlls:DelGroupMember", nGameLevel, nReadyId, szLeagueName, nPlayerId}
	end
end

function Wlls:WriteLog(szLog, nPlayerId)
	if nPlayerId then
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
		if (pPlayer) then
			Dbg:WriteLog("Wlls", "武林联赛", pPlayer.szAccount, pPlayer.szName, szLog);
			return 1;
		end
	end
	Dbg:WriteLog("Wlls","武林联赛", szLog);
end

function Wlls:SyncAdvMatchList(nReadyId, tbList)
	Wlls.AdvMatchLists[nReadyId] = Wlls.AdvMatchLists[nReadyId] or {};
	Wlls.AdvMatchLists[nReadyId] = tbList;
end

function Wlls:IsSeriesRestraint(nFirSeries, nSecSeries)
	if (nFirSeries <= 0 or nFirSeries > 5 or nSecSeries <= 0 or nSecSeries > 5) then
		return 0;
	end
	
	if (not self.SERIES_RESTRAINT_TABLE[nFirSeries]) then
		return 0;
	end
	
	if (self.SERIES_RESTRAINT_TABLE[nFirSeries][1] == nSecSeries) then
		return 1;
	end
	
	if (self.SERIES_RESTRAINT_TABLE[nFirSeries][2] == nSecSeries) then
		return 1;
	end
	
	return 0;
end

function Wlls:GetAdvMatchLeagueList(nReadyId)
	if not self.AdvMatchLists or not self.AdvMatchLists[nReadyId] then
		return {};
	end
	local nState = Wlls.MACTH_STATE_ADV_TASK[Wlls.AdvMatchState];
	if not nState or not self.AdvMatchLists[nReadyId][nState] then
		return {};
	end
	return self.AdvMatchLists[nReadyId][nState];
end

function Wlls:UpdateMatchTime()
	local nState		= Wlls:GetMacthState();
	local nRankSession	= Wlls:GetMacthSession();
	local tbMCfg		= Wlls:GetMacthTypeCfg(Wlls:GetMacthType(nRankSession));
	if (not tbMCfg) then
		return;
	end
	local tbCfg			= tbMCfg.tbMacthCfg;
	local nReadyTime	= self.MACTH_TIME_READY;
	local nRankTime		= self.MACTH_TIME_UPDATA_RANK;
	local nPkTime		= self.MIS_LIST[2][2];
	
	
	if (self.DEF_STATE_MATCH == nState) then
		if (not tbCfg.nReadyTime_Common or tbCfg.nReadyTime_Common <= 0 or not tbCfg.nReadyTime_Adv or tbCfg.nReadyTime_Adv <= 0) then
			return;
		end
		nReadyTime	= Env.GAME_FPS * tbCfg.nReadyTime_Common;		--准备场准备时间;
		nRankTime 	= Env.GAME_FPS * (tbCfg.nPKTime_Common + 10);		--准备时间结束进入比赛后多少时间更新排行;
		nPkTime		= Env.GAME_FPS * (tbCfg.nPKTime_Common - 15)
	elseif (self.DEF_STATE_ADVMATCH == nState) then
		if (not tbCfg.nPKTime_Common or tbCfg.nPKTime_Common <= 0 or not tbCfg.nPKTime_Adv or tbCfg.nPKTime_Adv <= 0) then
			return;
		end
		nReadyTime 	= Env.GAME_FPS * tbCfg.nReadyTime_Adv;		--准备场准备时间;
		nRankTime 	= Env.GAME_FPS * (tbCfg.nPKTime_Adv + 10);		--准备时间结束进入比赛后多少时间更新排行;
		nPkTime 	= Env.GAME_FPS * (tbCfg.nPKTime_Adv - 15)
	end
	self.MACTH_TIME_READY			=  nReadyTime
	self.MACTH_TIME_UPDATA_RANK		=  nRankTime
	self.MIS_LIST[2][2]				=  nPkTime

	local tbWeekend = self.CALEMDAR.tbWeekend;
	local tbCommon = self.CALEMDAR.tbCommon;
	local tbAdvMatch = self.CALEMDAR.tbAdvMatch;
	
	local tbCfg			= tbMCfg.tbMacthCfg;
	if (tbCfg and tbCfg.tbWeekend and #tbCfg.tbWeekend > 0) then
		tbWeekend = tbCfg.tbWeekend;
		self.CALEMDAR.tbWeekend = tbWeekend;
	end
	if (tbCfg and tbCfg.tbCommon and #tbCfg.tbCommon > 0) then
		tbCommon = tbCfg.tbCommon;
		self.CALEMDAR.tbCommon = tbCommon;
	end
	if (tbCfg and tbCfg.tbAdvMatch and #tbCfg.tbAdvMatch > 0) then
		tbAdvMatch = tbCfg.tbAdvMatch;
		self.CALEMDAR.tbAdvMatch = tbAdvMatch;
	end

	if (MODULE_GC_SERVER) then
		GlobalExcute{"Wlls:UpdateMatchTime"};
	end
end

function Wlls:SetPlayerSession(szPlayerName, nSession)
	if (GLOBAL_AGENT) then
		if (MODULE_GC_SERVER) then
			GbWlls:SetPlayerGblWllsSessionByName(szPlayerName, nSession);			
			return 0;
		end
	else
		if (MODULE_GC_SERVER) then
			GlobalExcute{"Wlls:SetPlayerSession", szPlayerName, nSession};
			return 0;
		end
		if (MODULE_GAMESERVER) then
			if (not szPlayerName or not nSession) then
				return 0;
			end
			local pPlayer = KPlayer.GetPlayerByName(szPlayerName);
			if (not pPlayer) then
				return 0;
			end
			pPlayer.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_WLLS_SESSION, nSession);
			return 0;
		end
	end
end

function Wlls:SetTeamPlayerRank(szLeagueName, nRank)
	if (not GLOBAL_AGENT) then
		return 0;
	end

	if (not szLeagueName or not nRank) then
		return 0;
	end

	local tbTeam = Wlls:GetLeagueMemberList(szLeagueName);
	if (not tbTeam) then
		return 0;
	end
	for _, szMemberName in ipairs(tbTeam) do
		GbWlls:SetPlayerSportTask(szMemberName, GbWlls.GBTASKID_MATCH_RANK, nRank);		
	end
end

function Wlls:SetTeamPlayerSportValue(szLeagueName, nTaskId, nValue)
	if (not GLOBAL_AGENT) then
		return 0;
	end
	
	if (not szLeagueName or not nTaskId or not nValue) then
		return 0;
	end

	local tbTeam = Wlls:GetLeagueMemberList(szLeagueName);
	if (not tbTeam) then
		return 0;
	end

	for _, szMemberName in ipairs(tbTeam) do
		GbWlls:SetPlayerSportTask(szMemberName, nTaskId, nValue);		
	end
end

function Wlls:SetTeamPlayerAdvRank(szLeagueName, nAdvRank)
	if (not GLOBAL_AGENT) then
		return 0;
	end

	if (not szLeagueName or not nAdvRank) then
		return 0;
	end	

	local tbTeam = Wlls:GetLeagueMemberList(szLeagueName);
	if (not tbTeam) then
		return 0;
	end
	for _, szMemberName in ipairs(tbTeam) do
		GbWlls:SetPlayerSportTask(szMemberName, GbWlls.GBTASKID_MATCH_ADVRANK, nAdvRank);		
	end
end

function Wlls:SetPlayerIsLeagueFlag(szName, nFlag)
	if (not MODULE_GAMESERVER) then
		return 0;
	end
	if (not szName) then
		return 0;
	end
	local pPlayer = KPlayer.GetPlayerByName(szName);
	if (not pPlayer) then
		return 0;
	end
	pPlayer.SetTask(self.TASKID_GROUP, self.TASKID_WLLS_ISHAVELEAGUE, nFlag);
end

function Wlls:GetPlayerLeagueFlag(pPlayer)
	if (not pPlayer) then
		return 0;
	end
	return pPlayer.GetTask(self.TASKID_GROUP, self.TASKID_WLLS_ISHAVELEAGUE);
end

function Wlls:GetGateWayInfo(szLeagueName)
	local nGateway	= League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_GATEWAY);
	local szGateway	= tostring(nGateway);
	local nLen		= string.len(szGateway);
	if (nLen < 4) then
		for i=1, 4 - nLen do
			szGateway = "0"..szGateway;
		end
	end
	szGateway = "gate" .. szGateway;
	return ServerEvent:GetServerInforByGateway(szGateway);
end

function Wlls:SendGbWlls_8RankInfo_Gb(nSession, nMapType, nState, nSaveFlag)
	if (not GLOBAL_AGENT) then
		return 0;
	end
	local tb8RankInfo = self:GetMatch8RankInfo(nSession, nMapType, nState);

	if (not tb8RankInfo) then
		return 0;
	end
	
	if (nSaveFlag and nSaveFlag == 1) then
		GbWlls:SaveGbWllsGbBuf(tb8RankInfo);
	end
	if (nState == Wlls.DEF_STATE_REST) then
		self:SendGbWllsFinalMsg_Gb(tb8RankInfo);
	end
	
	GC_AllExcute({"Wlls:SendGbWlls_8RankInfo_GC", tb8RankInfo, nSaveFlag});
	return 0;
end

function Wlls:SendGbWlls_8RankInfo_GC(tb8RankInfo, nSaveFlag)
	if (not MODULE_GC_SERVER) then
		return 0;
	end
	GbWlls:Process8RankInfo(tb8RankInfo);
	local nMapType = tb8RankInfo.nMapType;
	if (not nMapType or nMapType <= 0 or not tb8RankInfo.tbInfo) then
		return 0;
	end
	if (nMapType == Wlls.MAP_LINK_TYPE_FACTION) then
		if (tb8RankInfo.nState == Wlls.DEF_STATE_REST) then
			return 0;
		end
		for nFaction, tbFaction in pairs(tb8RankInfo.tbInfo) do
			local tbSendBuf = {
				nFac = nFaction,
				nType = tb8RankInfo.nMapType,
				nState = tb8RankInfo.nState,
				nSession = tb8RankInfo.nSession,
				tbBuf = tbFaction,	
			};
			GlobalExcute({"Wlls:SendGbWlls_8RankInfo_GS", tbSendBuf, nSaveFlag});	
		end
	end

end

function Wlls:SendGbWlls_8RankInfo_GS(tbSendBuf, nSaveFlag)
	if (not MODULE_GAMESERVER) then
		return 0;
	end
	
	if (not tbSendBuf) then
		return 0;
	end

	if (not nSaveFlag or nSaveFlag ~= 1) then
		return 0;	
	end

	local nMapType = tbSendBuf.nType;
	if (not GbWlls.tb8RankInfo) then
		GbWlls.tb8RankInfo = {};
	end

	if (tbSendBuf.nState == Wlls.DEF_STATE_REST) then
		return 0;
	end
	if (nMapType == Wlls.MAP_LINK_TYPE_FACTION) then
		GbWlls.tb8RankInfo.nMapType = nMapType;
		GbWlls.tb8RankInfo.nSession = tbSendBuf.nSession;
		GbWlls.tb8RankInfo.nState = tbSendBuf.nState;
		if (not GbWlls.tb8RankInfo.tbInfo) then
			GbWlls.tb8RankInfo.tbInfo = {};
		end
		GbWlls.tb8RankInfo.tbInfo[tbSendBuf.nFac] = tbSendBuf.tbBuf;		
	end
	
end

function Wlls:GetMatch8RankInfo(nSession, nType, nState)
	local tbMacthLevelCfg = self:GetMacthLevelCfg(self:GetMacthType(nSession), Wlls.MACTH_ADV);
	if (not tbMacthLevelCfg) then
		return;
	end
	
	if (not nSession or not nType or not nState) then
		return;
	end
	local nClass	= 2;
	if (nState == Wlls.DEF_STATE_REST) then
		nClass	= 5;
	end
	if (nType == Wlls.MAP_LINK_TYPE_FACTION) then
		local tbRankResult = {};
		for nReadyId, nMapId in pairs(tbMacthLevelCfg.tbReadyMap) do
			local tbLadder, szName, szContext = GetShowLadder(Ladder:GetType(0, 3, nClass, nReadyId));
			tbRankResult[nReadyId] = {};
			if (tbLadder) then
				for nId, tbLeague in ipairs(tbLadder) do
					if nId <= 8 then
						local tbLeagueInfo = self:GetLeagueDetailInfo(tbLeague.szName, nType);
						tbRankResult[nReadyId][nId] = tbLeagueInfo;
					end
				end
			end
		end

		local tb8RankInfo = {
				nSession	= nSession,
				nMapType	= nType,
				nState		= nState,
				tbInfo		= tbRankResult,
		};
		return tb8RankInfo;
	end	

	return;
end

function Wlls:GetLeagueDetailInfo(szLeagueName, nMapType)
	if (not szLeagueName) then
		return;
	end
	
	if (not League:FindLeague(self.LGTYPE, szLeagueName)) then
		return;
	end

	local tbMemberList = Wlls:GetLeagueMemberList(szLeagueName);
	local tbList = {};
	for i, szName in ipairs(tbMemberList) do
		tbList[#tbList + 1] = { szName, };
	end

	local nRank		= League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_RANK);
	local nWin		= League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_WIN);
	local nTie		= League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_TIE);
	local nTotal	= League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_TOTAL);
	local nTime		= League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_TIME);
	local nRankAdv	= League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_RANK_ADV);
	local nAdvId	= League:GetLeagueTask(self.LGTYPE, szLeagueName, Wlls.LGTASK_ADV_ID);
	local nMType	= League:GetLeagueTask(self.LGTYPE, szLeagueName, Wlls.LGTASK_MTYPE);
	local nLoss		= nTotal-nWin-nTie;	
	local nGateWay	= League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_GATEWAY);
	local szTime	= Lib:TimeFullDesc(nTime);
	local tbLeagueInfo = {
		tbInfo = { 
			szLeagueName,
			nMapType,
			nGateWay,
			nWin,
			nTie,
			nTotal,
			nRank,
			nRankAdv,
			szTime,
			nAdvId,
			nMType,
		},
		tbList = tbList,
	};
	return tbLeagueInfo;
end

function Wlls:SendGbWllsFinalMsg_Gb(tb8FinalResult)
	if (not GLOBAL_AGENT) then
		return 0;
	end

	if nNowType == Wlls.MAP_LINK_TYPE_FACTION then
		local tbAdv = tb8FinalResult.tbInfo;
		if (not tbAdv) then
			return 0;
		end

		for nFaction, tbInfo in pairs(tbAdv) do
			local tbFirst	= tbInfo[1];
			local tbSecond	= tbInfo[2];
			local tbThird	= tbInfo[3];
			local szFaction	= Player:GetFactionRouteName(nFaction);
			local szMatchName = string.format("%s门派", szFaction);
			self:SendGbWllsFinalOneMsg_Gb(tbThird, 3, szMatchName);
			self:SendGbWllsFinalOneMsg_Gb(tbSecond, 2, szMatchName);
			self:SendGbWllsFinalOneMsg_Gb(tbSecond, 1, szMatchName);
		end
	end
end

function Wlls:SendGbWllsFinalOneMsg_Gb(tbData, nRank, szMatchName)
	local tbFinalHonor = {
			[1] = "冠军",
			[2] = "亚军",
			[3] = "季军",
		};
	if (not tbData or not tbData.tbList or not tbData.szLeagueName or not tbData.nGateWay or  tbData.nGateWay <= 0) then
		return 0;
	end
	local szNameList = "";
	local tbGateInfo = self:GetGateWayInfo(tbData.szLeagueName);
	for i, tbPlayer in ipairs(tbData.tbList) do
		if (i > 1) then
			szNameList = szNameList .. "、";
		end
		szNameList = szNameList ..tbPlayer.szName;
		Dbg:WriteLogEx(Dbg.LOG_INFO, "GbWlls_Statary_Player", tbPlayer.szName, tbData.szLeagueName, nRank, szMatchName);
	end
	if (tbInfo) then
		local szFinalHonor = tbFinalHonor[nRank] or string.format("第%s名", nRank);
		local szMsg = string.format(MSG_MATCH_RESULT_ADV_FINAL_RESULT_1, tbGateInfo.ServerName, szNameList, tbData.szLeagueName, tbGateInfo.ZoneName, szMatchName, szFinalHonor);
		GbWlls:SendWorldMsg_Gb(szMsg);
		GbWlls:SendNewsMsg_Gb(szMsg);
	end
end

local function OnStarSort(tbA, tbB)
	if (tbA.nPoint ~= tbB.nPoint) then
		return tbA.nPoint > tbB.nPoint;
	end
	return tbA.nLeagueCount > tbB.nLeagueCount;
end

-- 将积分前三名的服务器发过去
function Wlls:SendGbWllsStarServer_GB()
	if (not GLOBAL_AGENT) then
		return 0;
	end
	local tbStarServer = {};
	local tbServer2Index = {};
	local nLgType		= self.LGTYPE;
	local pLeagueSet 	= KLeague.GetLeagueSetObject(nLgType);
	local pLeagueItor 	= pLeagueSet.GetLeagueItor();
	local pLeague 		= pLeagueItor.GetCurLeague();
	local tbLeagueList 	= {};
	local tbWllsLeagueList = {};
	while(pLeague) do
		local szLeagueName	= pLeague.szName;
		local nGateway		= League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, self.LGTASK_GATEWAY);
		local nWin			= League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_WIN);
		local nTie			= League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_TIE);
		local nTotal		= League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_TOTAL);
		local nLoss			= nTotal-nWin-nTie;
		local nPoint		= nWin * Wlls.MACTH_POINT_WIN + nTie * Wlls.MACTH_POINT_TIE + nLoss * Wlls.MACTH_POINT_LOSS;
		local nIndex		= tbServer2Index[nGateway];
		if (not nIndex or nIndex <= 0) then
			nIndex = #tbStarServer + 1; 
			tbStarServer[nIndex] = { nGate = nGateway, nPoint = 0, nLeagueCount = 0, };
			tbServer2Index[nGateway] = nIndex;
		end
		tbStarServer[nIndex].nPoint			= tbStarServer[nIndex].nPoint + nPoint;
		tbStarServer[nIndex].nLeagueCount	= tbStarServer[nIndex].nLeagueCount + 1;
		pLeague = pLeagueItor.NextLeague();
	end
	
	table.sort(tbStarServer, OnStarSort);
	
	local tbStarResult = {};
	
	for i=1, GbWlls.DEF_STARNUM do
		if (tbStarServer[i]) then
			tbStarResult[#tbStarResult + 1] = tbStarServer[i]
		end
	end
		
	GC_AllExcute({"Wlls:SendGbWllsStarServer_GC", tbStarResult});
	return 0;
end

function Wlls:SendGbWllsStarServer_GC(tbStarResult)
	if (not MODULE_GC_SERVER) then
		return 0;
	end
	
	if (not tbStarResult) then
		return 0;
	end
	
	local szGateway = GetGatewayName();
	local nNowGateWay = tonumber(string.sub(szGateway, 5, 8));
	
	KGblTask.SCSetDbTaskInt(GbWlls.GTASK_STARSERVERFLAG, 0);
	KGblTask.SCSetDbTaskInt(GbWlls.GTASK_STARSERVERFLAG_TIME, 0);
	
	for i, tbServer in ipairs(tbStarResult) do
		if (tbServer.nGate == nNowGateWay) then
			KGblTask.SCSetDbTaskInt(GbWlls.GTASK_STARSERVERFLAG, i);
			KGblTask.SCSetDbTaskInt(GbWlls.GTASK_STARSERVERFLAG_TIME, GetTime());
			return 1;
		end
	end
	return 0;
end

if (MODULE_GC_SERVER) then
	GCEvent:RegisterGCServerStartFunc(Wlls.UpdateMatchTime, Wlls);
end

if (MODULE_GAMESERVER) then
	ServerEvent:RegisterServerStartFunc(Wlls.UpdateMatchTime, Wlls);
end
