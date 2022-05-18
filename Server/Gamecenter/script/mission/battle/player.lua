-- 文件名　：player.lua
-- 创建者　：FanZai
-- 创建时间：2007-10-16

local tbPLBase	= Battle.tbPlayerBase or {};

-- 结构初始化
function tbPLBase:init(pPlayer, tbCamp)
	self.nSeriesKillNum		= 0;			-- 连斩数 
	self.nMaxSeriesKillNum	= 0;			-- 最大连斩数
	self.nSeriesKill		= 0;			-- 当前有效连斩数
	self.nMaxSeriesKill		= 0;			-- 最大有效连斩数
	self.nTriSeriesNum		= 0;			-- 三连斩个数
	self.nRank				= 1;			-- 官衔, 1表示士兵
	self.nBouns				= 0;			-- 战局积分
	self.nKillPlayerNum		= 0;			-- 杀死玩家个数
	self.nKillPlayerBouns	= 0;			-- 杀敌玩家积分
	self.nKillNpcNum		= 0;			-- 杀死NPC个数
	self.nKillNpcBouns		= 0;			-- 杀死NPC积分奖励
	self.nFlagNum			= 0; 			-- 夺得战旗个数
	self.nProtectBouns		= 0;			-- 护卫奖励
	self.nFlagsBouns		= 0;			-- 夺旗积分奖励
	self.nTreasure			= 0;			-- 夺得珍宝个数
	self.nTreasureBouns		= 0;			-- 夺宝积分奖励
	self.nGongXun			= 0;			-- 功勋值
	self.nShengWang			= 0;			-- 战场声望
	self.nListRank			= 0;			-- 排行榜排名
	self.nBackTime			= 0;			-- 最后一次回后营的时间
	self.nUseBouns			= 0;			-- 使用积分记录
	self.bHaveFlag			= 0;			-- 有旗的标记
	self.nBeenKilledNum		= 0;			-- 被杀数
	self.nHonor				= 0;			-- 玩家荣誉值
	self.szFacName			= Player:GetFactionRouteName(pPlayer.nFaction, pPlayer.nRouteId);	-- 玩家门派名称

	self.pPlayer		= pPlayer;			-- 玩家

	self.tbMission		= tbCamp.tbMission;	-- 所属Mission
	self.tbCamp			= tbCamp;			-- 所属阵营

	self.nLimitBouns	= Battle.POINT_LIMIT_MAP[tbCamp.nBattleLevel];	-- 一局积分限制
end

-- 增加当前积分，同时增加本阵营的
function tbPLBase:AddBounsWithCamp(nBouns)
	local nResult = self:AddBounsWithoutCamp(nBouns);
	self.tbCamp.nBouns	= self.tbCamp.nBouns + nBouns;
	return nResult;
end

-- 增加自身当前积分
function tbPLBase:AddBounsWithoutCamp(nBouns)
	local nNewBouns	= self.nBouns + nBouns;
	if (nNewBouns >= self.nLimitBouns) then
		nNewBouns	= self.nLimitBouns;
		self.pPlayer.Msg(string.format("Điểm tích lũy mới: %d.", nNewBouns));
	end
	self:AddBTBouns(nNewBouns - self.nBouns);
	local nResult = nNewBouns - self.nBouns;
	self.nBouns = nNewBouns;
	self:ProcessRank();
	self:ShowRightBattleInfo();
	return nResult;
end


-- 处理官衔相关信息
function tbPLBase:ProcessRank()
	local nRank 	= 0;
	if (self.nRank >= 10) then
		return;
	end
	for i = #Battle.TAB_RANKBONUS, 1, -1 do
		if (self.nBouns >= Battle.TAB_RANKBONUS[i] and -1 ~= Battle.TAB_RANKBONUS[i]) then
			nRank = i;
			break;
		end
	end
	if (self.nRank == nRank) then
		return;
	end

	assert(self.nRank < nRank);
	self.pPlayer.AddTitle(2, self.tbCamp.nCampId, nRank, 0);
	self.nRank	= nRank;
	return nRank;
end

-- 更新保存的功勋值
function tbPLBase:SetPlayerGongXun(nLastMaxGong, nNowTime, nTotalGong)
	self.pPlayer.SetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_LASTMAXGONG, nLastMaxGong);
	self.pPlayer.SetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_TOTALGONG, nTotalGong);	
	self.pPlayer.SetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_LASTGONGTIME, nNowTime);
	Battle:DbgWrite(Dbg.LOG_INFO, "tbPLBase:SetPlayerGongXun", nLastMaxGong, nTotalGong, nNowTime);
end

-- 添加角色声望
function tbPLBase:SetPlayerShengWang()
	self.pPlayer.AddRepute(2, self.tbMission.nBattleLevel, self.nShengWang);
end

-- 添加角色声望
function tbPLBase:SetPlayerHonor()
	local nAddHonor = 0;
	local nMinId	= 0;
	local nMinHonor = self.nHonor;
	for i = Battle.TSK_BTPLAYER_HONOR1, Battle.TSK_BTPLAYER_HONOR4, 1 do
		local nHonor = self.pPlayer.GetTask(Battle.TSKGID, i);
		if (nMinHonor > nHonor) then
			nMinId = i;
			nMinHonor = nHonor;
		end
	end
	if (nMinId > 0) then
		nAddHonor = self.nHonor - nMinHonor;
		PlayerHonor:AddPlayerHonor(self.pPlayer, PlayerHonor.HONOR_CLASS_BATTLE, 0, nAddHonor);
		self.pPlayer.SetTask(Battle.TSKGID, nMinId, self.nHonor);
	end
end

-- 设置总积分
function tbPLBase:SetTotalBouns(nPoint)
	self.pPlayer.SetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_TOTALBOUNS, nPoint);
end

-- 添加总积分
function tbPLBase:AddBTBouns(nValue)
	if (0 == nValue) then
		return;
	end
	local nBouns = self.pPlayer.GetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_TOTALBOUNS);
	nBouns = nBouns + nValue;
	self:SetTotalBouns(nBouns);
end

function tbPLBase:SetRightBattleInfo(nRemainFrame)
		local szMsgFormat		= "<color=green>Thời gian còn lại: <color> <color=white>%s<color>";
	Dialog:SetBattleTimer(self.pPlayer, szMsgFormat, nRemainFrame);
	self:ShowRightBattleInfo();
end

function tbPLBase:ShowRightBattleInfo()
	local szMsg				= "";

	if (3 == self.tbMission.tbRule.nRuleType) then
		szMsg = string.format("<color=green>Xếp hạng hiện tại：<color> <color=0xa0ff>%d<color>\n<color=green>Điểm cá nhân：<color> <color=yellow>%d<color>\n<color=green>Giết địch： <color><color=red>%d<color>\n<color=green>Bảo vệ cờ thành công：<color> <color=yellow><bclr=red>%d<bclr><color>", self.nListRank, self.nBouns, self.nKillPlayerNum, self.nFlagNum);
	else
		szMsg = string.format("<color=green>Xếp hạng hiện tại：<color> <color=0xa0ff>%d<color>\n<color=green>Điểm cá nhân：<color> <color=yellow>%d<color>\n<color=green>Giết địch： <color><color=red>%d<color>", self.nListRank, self.nBouns, self.nKillPlayerNum);
	end
	Dialog:SendBattleMsg(self.pPlayer, szMsg);
	Dialog:ShowBattleMsg(self.pPlayer, 1, 0);
end

function tbPLBase:DeleteRightBattleInfo()
	Dialog:ShowBattleMsg(self.pPlayer, 0, 3 * 18);
end

-- 获得杀死NPC积分奖励
function tbPLBase:GiveKillNpcBouns(pNpc)
	local nNpcBouns, nRankId	= self.tbMission.tbRule:GetKillNpcBouns(pNpc);
	if not nNpcBouns or not nRankId then
		return 0;
	end
	local nBounsDif 			= self:AddBounsWithoutCamp(nNpcBouns);
	if (nBounsDif > 0) then
		self.nKillNpcBouns = self.nKillNpcBouns + nNpcBouns;
	end
	self.nKillNpcNum			= self.nKillNpcNum + 1;

	local szMsg, nMidMsg	= self.tbMission.tbRule:GetKillNpcBoardMsg(nRankId, nNpcBouns, pNpc);
	if (1 == nMidMsg) then
		self.pPlayer.Msg(szMsg);
		local szAllMsg = string.format("<color=yellow>%s<color> <color=yellow>%s<color> sau trận đấu quyết liệt cuối cùng chặt được đầu <color=yellow>%s<color> quân địch", Battle.NAME_CAMP[self.tbCamp.nCampId], self.pPlayer.szName, Battle.NAME_RANK[nRankId]);
		local tbPlayerList = self.tbMission:GetPlayerList();
		szMsg = string.format("<color=yellow>%s<color> <color=yellow>%s<color> <color=yellow>%s<color> bị chặt đầu", Battle.NAME_CAMP[self.tbCamp.tbOppCamp.nCampId], Battle.NAME_RANK[nRankId], Battle.NAME_CAMP[self.tbCamp.nCampId]);
		for _, pPlayer in pairs(tbPlayerList) do
			pPlayer.Msg(szAllMsg);
			Dialog:SendInfoBoardMsg(pPlayer, szMsg);
		end
	elseif (0 == nMidMsg) then
		if (nRankId > 1) then
			local szAllMsg = string.format("%s %s %s chặt đầu %s %s hệ thống thưởng 10 điểm phúc duyên.", Battle.NAME_CAMP[self.tbCamp.nCampId], Battle.NAME_RANK[self.nRank], self.pPlayer.szName, Battle.NAME_CAMP[self.tbCamp.tbOppCamp.nCampId], Battle.NAME_RANK[nRankId]);
			self.pPlayer.Msg(szAllMsg);
		end
	end
end

function tbPLBase:GiveProtectFlagBouns()
	local nProtectBouns = self.tbMission.tbRule:GetProtectFlagBouns();
	local nBounsDif		= self:AddBounsWithCamp(nProtectBouns);
	if (nBounsDif > 0) then
		self.nFlagsBouns = self.nFlagsBouns + nBounsDif;
	end
	self.nFlagNum		= self.nFlagNum + 1;
	self.tbCamp.nFlags	= self.tbCamp.nFlags + 1;
	self.tbMission.tbRule:GiveFlagCampBouns(self.tbCamp.nCampId, self);
	self.tbMission.tbRule:GiveProtectFlagBounsForNearPlayer(self.tbCamp.nCampId, self);
end

function tbPLBase:GetKinTongName()
	local pPlayer		= self.pPlayer;
	local nTongId		= pPlayer.dwTongId;
	local pTong			= KTong.GetTong(nTongId);
	local szTKName		= "Không";
	
	if (pTong) then
		szTKName	= "Bang hội " .. pTong.GetName();
	else
		local nKinID			= pPlayer.GetKinMember();
		if (nKinID > 0) then
			local pKin		= KKin.GetKin(nKinID);
			if (pKin) then
				szTKName	= "Gia tộc " .. pKin.GetName();
			end
		end
	end

	return szTKName;			-- 家族帮会名，有帮会计帮会，无帮会计家族
end

function tbPLBase:GetFlagDesPos()
	return self.tbCamp.tbFlagDesPos;
end

Battle.tbPlayerBase	= tbPLBase;
