-------------------------------------------------------------------
--File: 	factionbattle_sub.lua
--Author: 	zhengyuhua
--Date: 	2008-2-25 9:51
--Describe:	门派竞技子功能
-------------------------------------------------------------------

-- 给某个玩家箱子
function FactionBattle:GiveABoxPlayer(pPlayer)
	if not pPlayer then
		return 0;
	end
	if pPlayer.CountFreeBagCell() < 1 then	-- 背包空间不足
		pPlayer.Msg("Túi Không đủ chỗ trống")
		return 0;
	end
	pPlayer.AddScriptItem(unpack(self.AWARD_ITEM_ID));
end

-- 在某个点组中刷出奖励道具
function FactionBattle:FlushAwardItem(nMapId, tbPoint, nIndex, nPlayerCount)
	local nItemNum = 0;
	for i = 1, 5 do
		if self.PLAYER_COUNT_LIMIT[i] <= nPlayerCount then
			nItemNum = self.BOX_NUM[nIndex][i + 1];
		end
	end
	local nPointCount = #tbPoint;
	if nItemNum > nPointCount then
		nItemNum = nPointCount;
	end
	local tbParam = {};
	tbParam.tbTable = self;
	tbParam.fnAwardFunction = self.GiveABoxPlayer
	for i = 1 , nItemNum do
		local nRand = MathRandom(nPointCount - i + 1);
		local tbTemp = tbPoint[nRand + i - 1];
		tbPoint[nRand + i - 1] = tbPoint[i];
		tbPoint[i] = tbTemp; 
		Npc.tbXiangZiNpc:AddBox(
			nMapId, 
			tbPoint[i].nX, 
			tbPoint[i].nY, 
			FactionBattle.TAKE_BOX_TIME * Env.GAME_FPS, 
			tbParam,
			1,
			1 * 18
		);
	end
	return 0;
end

-- 冠军授予功能启动
function FactionBattle:AwardChampionStart(nFaction, nWinnerId)
	local pFlagNpc = KNpc.Add2(
		self.FLAG_NPC_TAMPLATE_ID, 
		10, 
		-1, 
		self.FACTION_TO_MAP[nFaction], 
		self.FLAG_X, 
		self.FLAG_Y
	);
	local tbTemp = pFlagNpc.GetTempTable("FactionBattle");
	tbTemp.tbFactionData = {};
	tbTemp.tbFactionData.nWinnerId = nWinnerId;
	tbTemp.tbFactionData.nFlagTimerId = Timer:Register(
		self.FLAG_EXIST_TIME * Env.GAME_FPS,
		self.CancelAwardChampion,
		self,
		pFlagNpc.dwId
	);
end

-- 触发冠军授予
function FactionBattle:ExcuteAwardChampion(pPlayer, pNpc)
	local tbTemp = pNpc.GetTempTable("FactionBattle");
	if (not tbTemp.tbFactionData) or 
		(not tbTemp.tbFactionData.nWinnerId) or
		(tbTemp.tbFactionData.nWinnerId ~= pPlayer.nId) then
		return 0;
	end
	-- 授予称号
	pPlayer.AddTitle(self.TITLE_GROUP, self.TITLE_ID, pPlayer.nFaction, 0);
	-- 特效
	pPlayer.CastSkill(self.YANHUA_SKILL_ID, 1, -1, pPlayer.GetNpc().nIndex);
	-- 奖励
	local tbPlayer = KPlayer.GetMapPlayer(pNpc.nMapId);
	local nPlayerCount = #tbPlayer;
	self:FlushAwardItem(
		pNpc.nMapId, 
		self.tbBoxPoint[9],
		5,
		nPlayerCount
	);	-- 临时
	local nNpcMapId, nNpcPosX, nNpcPosY = pNpc.GetWorldPos();
	--刷出篝火
	local tbNpc	= Npc:GetClass("gouhuonpc");
	local pGouHuoNpc	= KNpc.Add2(self.GOUHUO_NPC_ID, 1, -1, nNpcMapId, nNpcPosX, nNpcPosY);		-- 获得篝火Npc
	--篝火参数： Id， 类型， 持续时间，跳跃时间，范围(格子直径)，倍率，酒是否有效，修理珠是否有效
	tbNpc:InitGouHuo(pGouHuoNpc.dwId, 0, self.GOUHUO_EXISTENTIME, 5, 90, self.GOUHUO_BASEMULTIP, 0, 0);
	tbNpc:StartNpcTimer(pGouHuoNpc.dwId)
	local tbData = self:GetFactionData(pPlayer.nFaction);
	tbData:MsgToMapPlayer("Tân nhân vương chưa lên võ đài nhận thưởng.")	
	
	Timer:Close(tbTemp.tbFactionData.nFlagTimerId);
	pNpc.Delete();
	tbData:ShutDown(1);		-- 圆满结束了
end

-- 冠军授予超时
function FactionBattle:CancelAwardChampion(nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		return 0;
	end
	local tbTemp = pNpc.GetTempTable("FactionBattle");
	if (tbTemp.tbFactionData) and (tbTemp.tbFactionData.nWinnerId) then
		local pPlayer = KPlayer.GetPlayerObjById(tbTemp.tbFactionData.nWinnerId);
		if pPlayer then
			Dbg:WriteLog("FactionBattle", "Không nhận được phần thưởng vô địch do hết giờ", pPlayer.szName, pPlayer.szAccount);
		end
	end
	pNpc.Delete();
end

-- 晋级送礼
function FactionBattle:PromotionAward(nMapId, nArenaId, nIndex, nPlayer1Id, nPlayer2Id, nPlayerCount)
	if not self.tbBoxPoint then
		return 0;
	end
	
	Timer:Register(self.ADD_BOX_DELAY * Env.GAME_FPS,  
		self.FlushAwardItem,
		self,
		nMapId, 
		self.tbBoxPoint[nArenaId],
		nIndex,
		nPlayerCount
	);
end

-- 积分兑换经验功能
function FactionBattle:ExchangeExp(nPlayerId, bConfirm)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return 0;
	end
	local nGroupId = self.TASK_GROUP_ID;
	local nDegreeId = self.DEGREE_TASK_ID;
	local nScoreId = self.SCORE_TASK_ID;
	local nElimatId = self.ELIMINATION_TASK_ID;
	local nScore = pPlayer.GetTask(nGroupId, nScoreId);
	local nElimat = pPlayer.GetTask(nGroupId, nElimatId);
	if self:CheckDegree(pPlayer) == 0 then	-- 检查届数
		nScore = 0;
		nElimat = 0;
	end
	local nFlag = self:GetBattleFlag(pPlayer.nFaction);
	if nFlag == 1 then
		Dialog:Say("Đang trong thời gian thi đấu không thể đổi điểm");
		return 0;
	end
	if nScore == 0 and nElimat <= 2  then
		Dialog:Say("Hiện tại không có điểm để đổi.");
		return 0;
	end
	local nExp = math.floor((nScore / 4800) * pPlayer.GetBaseAwardExp() * 90);
	local nXiangZi = math.floor(nScore / 2400);
	local nWeiWang = 0;
	if nScore >= 4800 then
		nWeiWang = 8;
	elseif nScore >= 4000 then
		nWeiWang = 6;
	elseif nScore >= 3200 then
		nWeiWang = 5;
	elseif nScore >= 2400 then
		nWeiWang = 4;
	end
	local nExpEx = 0;
	local nXiangZiEx = 0;
	local szTitle = "";
	local nRank = 100;
	if nElimat > 2 then
		if self.BOX_NUM[nElimat - 2][1] == 1 then
			szTitle = "Nhận <color=red>Quán Quân<color>";
		else
			szTitle = "Nhận <color=red>"..self.BOX_NUM[nElimat - 2][1].."<color>";
		end
		if self.BOX_NUM[nElimat - 2][1] then
			nRank = self.BOX_NUM[nElimat - 2][1]
		end
		nExpEx = self.AWARD_TABLE[nElimat][4] * pPlayer.GetBaseAwardExp();
		nXiangZiEx = self.AWARD_TABLE[nElimat][5];
	end
	local nFreeCount, tbExecute, szExtendInfo = SpecialEvent.ExtendAward:DoCheck("FactionBattle", pPlayer, nScore, nRank, (nXiangZi + nXiangZiEx));
	if bConfirm == 1 then
		if pPlayer.CountFreeBagCell() < nXiangZi + nXiangZiEx + nFreeCount then
			local szError = string.format("Hành Trang không đủ chỗ trống, cần <color=green>%s<color> ô trống.", nXiangZi + nXiangZiEx + nFreeCount)
			pPlayer.Msg(szError);
			return 0;
		end
		for i = 1, nXiangZi + nXiangZiEx do
			pPlayer.AddScriptItem(unpack(self.AWARD_ITEM_ID));
		end
		pPlayer.AddExp(nExp + nExpEx);
		pPlayer.AddKinReputeEntry(nWeiWang, "factionbattle");
		pPlayer.SetTask(nGroupId, nScoreId, 0);	-- 积分清零
		pPlayer.SetTask(nGroupId, nElimatId, 0); -- 清淘汰赛成绩
		SpecialEvent.ExtendAward:DoExecute(tbExecute);
		
		-- 为玩家参加门派竞技的计数加1
		Stats.Activity:AddCount(pPlayer, Stats.TASK_COUNT_FACTION, 1);
		
		return 0;
	end
	local szMsg = string.format("Điểm hiện tại của bạn là: <color=green>%s<color>, Có thể đổi: <color=green>%s<color> kinh nghiệm, <color=green>%s<color> bảo rương.\n", 
		nScore, nExp, nXiangZi);
	if nElimat > 2 then
		szMsg = szMsg..string.format("Với thành tích "..szTitle..", bạn có thể nhận được <color=green>%s<color> kinh nghiệm, <color=green>%s<color> bảo rương.\n",
			nExpEx, nXiangZiEx);
	end
	Dialog:Say(szMsg..szExtendInfo,
		{
			--{"Ta muốn trao đổi", self.ExchangeExp, self, me.nId, 1},
			{"Để ta suy nghĩ đã"},
		})
end

-- 为参加者增加心得、威望、声望
function FactionBattle:AwardAttender(pPlayer, nIndex)
	self:CheckDegree(pPlayer);
	if pPlayer then
		local nOldIndex = pPlayer.GetTask(self.TASK_GROUP_ID, self.ELIMINATION_TASK_ID);
		Setting:SetGlobalObj(pPlayer);
		for i = nOldIndex + 1, nIndex do
			Task:AddInsight(self.AWARD_TABLE[i][1]);
			pPlayer.AddKinReputeEntry(self.AWARD_TABLE[i][2], "factionbattle");		-- 威望
			pPlayer.AddRepute(Player.CAMP_FACTION, me.nFaction, self.AWARD_TABLE[i][3]);
			
			-- 荣誉 
			self:AddFactionHonor(pPlayer, self.AWARD_TABLE[i][7]);
					
			-- 记录比赛成绩任务变量
			pPlayer.SetTask(self.TASK_GROUP_ID, self.ELIMINATION_TASK_ID, nIndex); 
			
			-- 增加建设资金和个人、帮主、族长的股份
			print(pPlayer.szName, self.AWARD_TABLE[i][6], 0.7, 0.2, 0.05, 0, 0.05)
			Tong:AddStockBaseCount_GS1(pPlayer.nId, self.AWARD_TABLE[i][6], 0.7, 0.2, 0.05, 0, 0.05);
		end
		Setting:RestoreGlobalObj();
	end
end

-- 加门派荣誉
function FactionBattle:AddFactionHonor(pPlayer, nHornor)
	local nFaction = pPlayer.nFaction;
	PlayerHonor:AddPlayerHonor(pPlayer, self.HONOR_CLASS, self.HONOR_WULIN_TYPE, nHornor);
end

function FactionBattle:CheckDegree(pPlayer)
	if not pPlayer then
		return 0;
	end
	local nGroupId = self.TASK_GROUP_ID;
	local nDegreeId = self.DEGREE_TASK_ID;
	local nScoreId = self.SCORE_TASK_ID;
	local nElimatId = self.ELIMINATION_TASK_ID;
	local nDegree =	pPlayer.GetTask(nGroupId, nDegreeId)
	local nCurDegree = GetFactionBattleCurId();
	if nCurDegree ~= nDegree then	-- 届数不同，积分无效~清积分
		pPlayer.SetTask(nGroupId, nDegreeId, nCurDegree);
		pPlayer.SetTask(nGroupId, nScoreId, 0);
		pPlayer.SetTask(nGroupId, nElimatId, 0);
		return 0;
	end
	return 1;
end
