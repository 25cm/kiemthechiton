--联赛奖励
--孙多良
--2008.09.23

--单场比赛奖励，1为获胜，2为平，3为输, 4为轮空获胜
function Wlls:MacthAward(szLeagueName, szMatchLeagueName, tbMisPlayerList, nResult, nMacthTime)
	if (GLOBAL_AGENT) then
		Wlls:GbWllsMacthAward(szLeagueName, szMatchLeagueName, tbMisPlayerList, nResult, nMacthTime)
		return 0;
	end
	
	local tbMsg = 
	{
		[1] = {string.format("<color=yellow>您的战队在比赛中战胜了%s的战队，恭喜获得了胜利。<color>", szMatchLeagueName or "")},
		[2] = {string.format("<color=green>您的战队在比赛中战平了%s的战队，下次继续努力吧。<color>", szMatchLeagueName or "")},
		[3] = {string.format("<color=blue>您的战队在比赛中败给了%s的战队，下次继续努力吧。<color>", szMatchLeagueName or "")},
		[4] = {string.format("<color=yellow>您的战队在这次比赛中轮空了，意外的获得了胜利。<color>")}
	}
	
	local nLeagueTotal 	= League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_TOTAL);
	local nLeagueWin 	= League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_WIN);
	local nLeagueTie 	= League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_TIE);
	local nLeagueTime 	= League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_TIME);
	local nGameLevel 	= League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_MLEVEL);
	local nSession 		= League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_MSESSION);	
	local nReadyId		= League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_ATTEND);
	if nResult == 3 then
		--负方不累计比赛时间
		nMacthTime = 0;
	end
	local tbPlayerList = {};
	local tbPlayerObjList = {};
	--加荣誉点
	for _, szMemberName in ipairs(Wlls:GetLeagueMemberList(szLeagueName)) do
		local nHonor = 0;
		if nResult == 1 or nResult == 4 then
			if Wlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Win.honor then
				nHonor = tonumber(Wlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Win.honor[1]);
			end
		end
		if nResult == 2 then
			if Wlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Tie.honor then
				nHonor = tonumber(Wlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Tie.honor[1]);
			end
		end
		if nResult == 3 then
			if Wlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Lost.honor then
				nHonor = tonumber(Wlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Lost.honor[1]);
			end
		end
		Wlls:AddHonor(szMemberName, nHonor);
		local nId = KGCPlayer.GetPlayerIdByName(szMemberName);
		tbPlayerList[nId] = szMemberName;
	end
	for nId, szName in pairs(tbPlayerList) do
		local pPlayer = KPlayer.GetPlayerObjById(nId);
		if pPlayer then
			pPlayer.Msg(tbMsg[nResult][1]);
			Dialog:SendBlackBoardMsg(pPlayer, tbMsg[nResult][1])
			--奖励
			pPlayer.SetTask(self.TASKID_GROUP, self.TASKID_MATCH_TOTLE, pPlayer.GetTask(self.TASKID_GROUP, self.TASKID_MATCH_TOTLE) + 1);
			pPlayer.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_TOTLE, nLeagueTotal + 1);
			if nResult == 1 or nResult == 4 then
				pPlayer.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_MATCH_WIN, pPlayer.GetTask(self.TASKID_GROUP, self.TASKID_MATCH_WIN) + 1);
				pPlayer.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_WIN, nLeagueWin + 1);
				Wlls.Fun:DoExcute(pPlayer, Wlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Win);
				pPlayer.SendMsgToFriend("你的好友[" ..pPlayer.szName.. "]在刚刚结束的武林联赛中取得了一场胜利。");
				pPlayer.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_MATCH_WIN_AWARD, 10);
			end
			
			if nResult == 2 then
				pPlayer.SetTask(self.TASKID_GROUP, self.TASKID_MATCH_TIE, pPlayer.GetTask(self.TASKID_GROUP, self.TASKID_MATCH_TIE) + 1);
				pPlayer.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_TIE, nLeagueTie + 1);
				Wlls.Fun:DoExcute(pPlayer, Wlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Tie);
			end
			if nResult == 3 then
				Wlls.Fun:DoExcute(pPlayer, Wlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Lost);
			end
			table.insert(tbPlayerObjList, pPlayer);
			
			-- 统计玩家参加武林联赛的场次
			Stats.Activity:AddCount(pPlayer, Stats.TASK_COUNT_WLLS, 1);
		else
			--不在线,下次上线自动给予.
			League:SetMemberTask(self.LGTYPE, szLeagueName, szName, self.LGMTASK_AWARD, nResult)
		end
		Wlls:WriteLog(string.format("奖励队员:%s，%s Vs %s，结果:%s", szName, szLeagueName, (szMatchLeagueName or ""), nResult))
	end
	
	if Wlls:GetMacthState() == Wlls.DEF_STATE_ADVMATCH then
		local nRank   = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_RANK);
		local nVsRank = 0;
		if szMatchLeagueName then
			nVsRank = League:GetLeagueTask(Wlls.LGTYPE, szMatchLeagueName, Wlls.LGTASK_RANK);
		end
		if Wlls.MACTH_STATE_ADV_TASK[Wlls.AdvMatchState] == 8 then
			if nResult == 1 or nResult == 4 or (nResult == 2 and nRank < nVsRank) then
				local nSeries = Wlls:GetAdvMatchSeries(nRank, 8);
				Wlls.AdvMatchLists[nReadyId][4][nSeries] = Wlls.AdvMatchLists[nReadyId][8][nRank];
				League:SetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_RANK_ADV, 4);
			end
		elseif Wlls.MACTH_STATE_ADV_TASK[Wlls.AdvMatchState] == 4 then
			if nResult == 1 or nResult == 4  or (nResult == 2 and nRank < nVsRank) then
				local nSeries = Wlls:GetAdvMatchSeries(nRank, 4);
				Wlls.AdvMatchLists[nReadyId][2][nSeries] = Wlls.AdvMatchLists[nReadyId][8][nRank];
				League:SetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_RANK_ADV, 2);
			end			
		elseif Wlls.MACTH_STATE_ADV_TASK[Wlls.AdvMatchState] == 2 then
			local nSeries = Wlls:GetAdvMatchSeries(nRank, 2);
			Wlls.AdvMatchLists[nReadyId][2][nSeries].tbResult[Wlls.AdvMatchState - 2] = nResult;
			--if Wlls.AdvMatchState == 5 then
			--	Wlls:SetAdvMacthResult();
			--end
		end
	else
		if nResult == 1 or nResult == 4 then
			League:SetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_WIN, nLeagueWin + 1 );
			Wlls:WriteLog(string.format("胜利增加胜利场次:%s", szLeagueName));
		elseif nResult == 2 then
			League:SetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_TIE, nLeagueTie + 1);
		end
		League:SetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_TOTAL, nLeagueTotal + 1);
		League:SetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_TIME, nLeagueTime + nMacthTime);
	end
	League:SetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_ENTER, 0);
	--增加亲密度：
	for i =1, #tbPlayerObjList do 
		for j = i + 1, #tbPlayerObjList do
			if (tbPlayerObjList[i].IsFriendRelation(tbPlayerObjList[j].szName) == 1) then
				Relation:AddFriendFavor(tbPlayerObjList[i].szName, tbPlayerObjList[j].szName, 50);
				tbPlayerObjList[i].Msg(string.format("您与<color=yellow>%s<color>好友亲密度增加了%d点。", tbPlayerObjList[j].szName, 50));
				tbPlayerObjList[j].Msg(string.format("您与<color=yellow>%s<color>好友亲密度增加了%d点。", tbPlayerObjList[i].szName, 50));
			end
		end
	end
end

function Wlls:GbWllsMacthAward(szLeagueName, szMatchLeagueName, tbMisPlayerList, nResult, nMacthTime)
	if (not GLOBAL_AGENT) then
		return 0;
	end
	local tbMsg = 
	{
		[1] = {string.format("<color=yellow>您的战队在比赛中战胜了%s的战队，恭喜获得了胜利。<color>", szMatchLeagueName or "")},
		[2] = {string.format("<color=green>您的战队在比赛中战平了%s的战队，下次继续努力吧。<color>", szMatchLeagueName or "")},
		[3] = {string.format("<color=blue>您的战队在比赛中败给了%s的战队，下次继续努力吧。<color>", szMatchLeagueName or "")},
		[4] = {string.format("<color=yellow>您的战队在这次比赛中轮空了，意外的获得了胜利。<color>")}
	}
	
	local nLeagueTotal 	= League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_TOTAL);
	local nLeagueWin 	= League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_WIN);
	local nLeagueTie 	= League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_TIE);
	local nLeagueTime 	= League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_TIME);
	local nGameLevel 	= League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_MLEVEL);
	local nSession 		= League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_MSESSION);	
	local nReadyId		= League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_ATTEND);
	local tbMemberList	= Wlls:GetLeagueMemberList(szLeagueName);
	for _, szMemberName in ipairs(tbMemberList) do
		Dbg:WriteLogEx(Dbg.LOG_INFO, "GbWllsMacthAward", szMemberName, szLeagueName, nResult, nMacthTime);
	end
	if nResult == 3 then
		--负方不累计比赛时间
		nMacthTime = 0;
	end
	local tbPlayerList = {};
	local tbPlayerObjList = {};
	--加荣誉点
	for _, szMemberName in ipairs(tbMemberList) do
		local nId = KGCPlayer.GetPlayerIdByName(szMemberName);
		tbPlayerList[nId] = szMemberName;
	end
	for nId, szName in pairs(tbPlayerList) do
		local pPlayer = KPlayer.GetPlayerObjById(nId);
		if pPlayer then
			pPlayer.Msg(tbMsg[nResult][1]);
			Dialog:SendBlackBoardMsg(pPlayer, tbMsg[nResult][1])
		end
		if nResult == 1 or nResult == 4 then
			GbWlls:SetPlayerSportTask(szName, GbWlls.GBTASKID_MATCH_WIN_AWARD, GbWlls:GetPlayerSportTask(szName, GbWlls.GBTASKID_MATCH_WIN_AWARD) + 1);
			GbWlls:SetPlayerSportTask(szName, GbWlls.GBTASKID_MATCH_DAILY_RESULT, GetTime());
		end
		if nResult == 2 then
			GbWlls:SetPlayerSportTask(szName, GbWlls.GBTASKID_MATCH_TIE_AWARD, GbWlls:GetPlayerSportTask(szName, GbWlls.GBTASKID_MATCH_TIE_AWARD) + 1);
		end
		if nResult == 3 then
			GbWlls:SetPlayerSportTask(szName, GbWlls.GBTASKID_MATCH_LOSE_AWARD, GbWlls:GetPlayerSportTask(szName, GbWlls.GBTASKID_MATCH_LOSE_AWARD) + 1);
		end		
		Wlls:WriteLog(string.format("[跨服联赛]奖励队员:%s，%s Vs %s，结果:%s", szName, szLeagueName, (szMatchLeagueName or ""), nResult))
	end
	
	if Wlls:GetMacthState() == Wlls.DEF_STATE_ADVMATCH then
		local nRank   = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_RANK);
		local nVsRank = 0;
		if szMatchLeagueName then
			nVsRank = League:GetLeagueTask(Wlls.LGTYPE, szMatchLeagueName, Wlls.LGTASK_RANK);
		end
		if Wlls.MACTH_STATE_ADV_TASK[Wlls.AdvMatchState] == 8 then
			if nResult == 1 or nResult == 4 or (nResult == 2 and nRank < nVsRank) then
				local nSeries = Wlls:GetAdvMatchSeries(nRank, 8);
				Wlls.AdvMatchLists[nReadyId][4][nSeries] = Wlls.AdvMatchLists[nReadyId][8][nRank];
				League:SetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_RANK_ADV, 4);
				self:SetTeamPlayerAdvRank(szLeagueName, 4);
			end
		elseif Wlls.MACTH_STATE_ADV_TASK[Wlls.AdvMatchState] == 4 then
			if nResult == 1 or nResult == 4  or (nResult == 2 and nRank < nVsRank) then
				local nSeries = Wlls:GetAdvMatchSeries(nRank, 4);
				Wlls.AdvMatchLists[nReadyId][2][nSeries] = Wlls.AdvMatchLists[nReadyId][8][nRank];
				League:SetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_RANK_ADV, 2);
				self:SetTeamPlayerAdvRank(szLeagueName, 2);
			end			
		elseif Wlls.MACTH_STATE_ADV_TASK[Wlls.AdvMatchState] == 2 then
			local nSeries = Wlls:GetAdvMatchSeries(nRank, 2);
			Wlls.AdvMatchLists[nReadyId][2][nSeries].tbResult[Wlls.AdvMatchState - 2] = nResult;
			--if Wlls.AdvMatchState == 5 then
			--	Wlls:SetAdvMacthResult();
			--end
		end
	else
		if nResult == 1 or nResult == 4 then
			League:SetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_WIN, nLeagueWin + 1 );
			Wlls:WriteLog(string.format("[跨服联赛]胜利增加胜利场次:%s", szLeagueName));
		elseif nResult == 2 then
			League:SetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_TIE, nLeagueTie + 1);
		end
		League:SetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_TOTAL, nLeagueTotal + 1);
		League:SetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_TIME, nLeagueTime + nMacthTime);
	end
	League:SetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_ENTER, 0);
end

--检查领取单场胜利奖项
function Wlls:OnCheckAwardSingle(pPlayer)
	if pPlayer.GetTask(Wlls.TASKID_GROUP, Wlls.TASKID_MATCH_WIN_AWARD) == 10 then
		return 1;
	end
	return 0;
end

--领取单场胜利奖励
function Wlls:OnGetAwardSingle()
	if Wlls:OnCheckAwardSingle(me) == 0 then
		return 0;
	end
	local nFreeCount, tbFunExecute = SpecialEvent.ExtendAward:DoCheck("Wlls", me); 
	
	if me.CountFreeBagCell() < (1 + nFreeCount) then
		Dialog:Say(string.format("您的背包空间不够,请整理%s格背包空间.", (1 + nFreeCount)));
		return 0;
	end
	local pItem = me.AddItem(18,1,259,1);
	if pItem then
		me.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_MATCH_WIN_AWARD, 0);
		Dbg:WriteLog("Wlls","成功领取联赛礼包", me.szName);
	end
	SpecialEvent.ExtendAward:DoExecute(tbFunExecute);
	Dialog:Say("您获得了一个<color=yellow>联赛礼包<color>。");
end

--最终奖励，有奖励时优先弹出奖励选项
function Wlls:OnCheckAward(pPlayer, nGameLevel)
	local szLeagueName = League:GetMemberLeague(Wlls.LGTYPE, pPlayer.szName);
	if not szLeagueName then
		return 0, 0, "您没有战队。";
	end
	
	local szGameLevelName = Wlls.MACTH_LEVEL_NAME[nGameLevel];
	if nGameLevel ~= League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_MLEVEL) then
		return 0, 0 ,string.format("您不是%s武林联赛的参赛选手。", szGameLevelName);
	end
	
	if Wlls:GetMacthState() ~= Wlls.DEF_STATE_REST or KGblTask.SCGetDbTaskInt(Wlls.GTASK_MACTH_RANK) < Wlls:GetMacthSession() then
		return 0, 0, string.format("比赛期还未结束或者比赛最终排行还未出来，请耐心等待。");		
	end
	
	if League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_TOTAL) <= 0 then
		return 0, 0, string.format("您的战队还未参加过比赛，是新建战队，不能领取奖励。");	
	end
	local nRank = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_RANK);
	local nTotle = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_TOTAL);
	local nSession = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_MSESSION);
	local nAdvRank = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_RANK_ADV);
	
	if pPlayer.GetTask(self.TASKID_GROUP, self.TASKID_MATCH_FINISH) >= nSession then
		return 0, 0 , string.format("您已领取过奖励了。");
	end	
	
	
	if nRank == 1 and nAdvRank == 2 then
		nRank = 2;
	end	
	local nGameType = Wlls:GetMacthType(nSession)
	local nLevelSep, nMaxRank = Wlls:GetAwardLevelSep(nGameLevel, nSession, nRank);
	if nLevelSep <= 0 then
		return 0, 0, string.format("您的战队没有奖励可以领取。");
	end
	if nMaxRank >= 10000 and nTotle < math.floor(nMaxRank/10000) then
		return 0, 0 , string.format("您的战队在本届比赛中没有获得任何奖励,请下届继续努力。");
	end
	return 1, nRank , string.format("领取奖励");
end


--领取最终奖励
function Wlls:OnGetAward(nGameLevel, nFlag)
	local nCheck,nRank,szError = Wlls:OnCheckAward(me, nGameLevel);
	if nCheck == 0 then
		Dialog:Say(szError);
		return 0;
	end
	local szLeagueName = League:GetMemberLeague(Wlls.LGTYPE, me.szName);
	local nSession = League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_MSESSION);
	local nGameType = Wlls:GetMacthType(nSession);
	local nLevelSep, nMaxRank = Wlls:GetAwardLevelSep(nGameLevel, nSession, nRank);
	
	if not nFlag then
		local szMsg = string.format("武林联赛官员：您的战队在上届武林联赛中获得了第<color=yellow>%s<color>名，领取奖励后，您将退出战队，如果战队没有剩余成员，战队将会解散。", nRank);
		local tbOpt = 
		{
			{"我确定领取奖励",self.OnGetAward, self, nGameLevel, 1},
			{"我再考虑考虑"},
		}
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end
	local nFree = Wlls.Fun:GetNeedFree(Wlls.AWARD_FINISH_LIST[nGameLevel][nSession][nLevelSep]);
	if me.CountFreeBagCell() < nFree then
		Dialog:Say(string.format("您的背包空间不够,请整理%s格背包空间.", nFree));
		return 0;
	end
	
	--变量设置
	if nRank == 1 then
		me.SetTask(self.TASKID_GROUP, self.TASKID_MATCH_FIRST, me.GetTask(self.TASKID_GROUP, self.TASKID_MATCH_FIRST) + 1);
		local pTong = KTong.GetTong(me.dwTongId);
		if pTong and nSession then
			pTong.AddHistoryLadder(me.szName, tostring(nSession), "冠军"); 
			pTong.AddAffairLadder(me.szName, tostring(nSession), "冠军");
			GCExcute{"Wlls:AddAffairLadder", me.dwTongId, me.szName, nSession, "冠军"};
		end
	end
	if nRank == 2 then
		me.SetTask(self.TASKID_GROUP, self.TASKID_MATCH_SECOND, me.GetTask(self.TASKID_GROUP, self.TASKID_MATCH_SECOND) + 1);
		local pTong = KTong.GetTong(me.dwTongId);
		if pTong and nSession then 
			pTong.AddHistoryLadder(me.szName, tostring(nSession), "亚军");
			pTong.AddAffairLadder(me.szName, tostring(nSession), "亚军");
			GCExcute{"Wlls:AddAffairLadder", me.dwTongId, me.szName, nSession, "亚军"};
		end
	end
	if nRank == 3 then
		me.SetTask(self.TASKID_GROUP, self.TASKID_MATCH_THIRD, me.GetTask(self.TASKID_GROUP, self.TASKID_MATCH_THIRD) + 1);
		local pTong = KTong.GetTong(me.dwTongId);
		if pTong then 
			pTong.AddHistoryLadder(me.szName, tostring(nSession), "季军");
			pTong.AddAffairLadder(me.szName, tostring(nSession), "季军");
			GCExcute{"Wlls:AddAffairLadder", me.dwTongId, me.szName, nSession, "季军"};
		end
	end	
	
	if me.GetTask(self.TASKID_GROUP, self.TASKID_MATCH_BEST) > nRank then
		me.SetTask(self.TASKID_GROUP, self.TASKID_MATCH_BEST, nRank);
	end
	if me.GetTask(self.TASKID_GROUP, self.TASKID_MATCH_BEST) == 0 then
		me.SetTask(self.TASKID_GROUP, self.TASKID_MATCH_BEST, nRank);
	end
	
	me.SetTask(self.TASKID_GROUP, self.TASKID_MATCH_FINISH, nSession);
	local nLogTaskFlag = nSession + nLevelSep * 1000 + nGameLevel * 1000000;
	me.SetTask(self.TASKID_GROUP, self.TASKID_AWARD_LOG, nLogTaskFlag);	
	
	--奖励
	Wlls.Fun:DoExcute(me, Wlls.AWARD_FINISH_LIST[nGameLevel][nSession][nLevelSep]);
	
	-- 玩家领取武林联赛最终奖励的客服log
	local nTotle = League:GetLeagueTask(Wlls.LGTYPE, szLeagueName, Wlls.LGTASK_TOTAL);
	local szLogMsg = string.format("玩家：%s 参赛场次：%s 名次：%s， 已经领取武林联赛奖励。", me.szName, nTotle, nRank);
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, szLogMsg);

	GCExcute{"Wlls:LeaveLeague", me.szName, nGameLevel, 1};
	Dialog:Say("您成功领取了奖励，并退出了战队，欢迎继续参加下届联赛。");
	Wlls:WriteLog(string.format("%s级联赛排名:%s, 路线:%s", nGameLevel, nRank, Player:GetFactionRouteName(me.nFaction, me.nRouteId)), me.nId)
end

--玩家登陆补领奖励.
function Wlls:OnLogin()
	local szLeagueName = League:GetMemberLeague(Wlls.LGTYPE, me.szName);
	if szLeagueName then
		local nLeagueTotal = League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_TOTAL);
		local nLeagueWin = League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_WIN);
		local nLeagueTie = League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_TIE);
		local nLeagueTime = League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_TIME);
		local nGameLevel = League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_MLEVEL);
		local nSession = League:GetLeagueTask(self.LGTYPE, szLeagueName, self.LGTASK_MSESSION);
		
		if nSession > me.GetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_SESSION) then
			me.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_SESSION, nSession);
			me.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_TOTLE, nLeagueTotal);
			me.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_WIN, nLeagueWin);
			me.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_TIE, nLeagueTie);	
		end
		if me.GetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_TOTLE) ~= nLeagueTotal then
			me.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_TOTLE, nLeagueTotal);
			me.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_WIN, nLeagueWin);
			me.SetTask(Wlls.TASKID_GROUP, Wlls.TASKID_HELP_TIE, nLeagueTie);		
		end
		local nResult = League:GetMemberTask(self.LGTYPE, szLeagueName, me.szName, self.LGMTASK_AWARD);
		if nResult == 0 then
			return 0
		end
		if nResult == 1 or nResult == 4 then
			--获胜奖励
			Wlls.Fun:DoExcute(me, Wlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Win);
			
		end
		if nResult == 2 then
			--平奖励
			Wlls.Fun:DoExcute(me, Wlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Tie);
		end
		
		if nResult == 3 then
			--负奖励
			Wlls.Fun:DoExcute(me, Wlls.AWARD_SINGLE_LIST[nGameLevel][nSession].Lost);
		end
		League:SetMemberTask(self.LGTYPE, szLeagueName, me.szName, self.LGMTASK_AWARD, 0);
		Wlls:WriteLog("成功补领单场奖励", me.nId);
	end
end
