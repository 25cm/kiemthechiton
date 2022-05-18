-------------------------------------------------------------------
--File: 	factionbattle_base.lua
--Author: 	zhengyuhua
--Date: 	2008-1-8 17:38
--Describe:	门派战逻辑
-------------------------------------------------------------------
local tbBaseFaction	= {};	-- 	各门派的门派战基类
FactionBattle.tbBaseFaction = tbBaseFaction;

tbBaseFaction.tbSortFunc = {
	__lt = function(tbA, tbB)
		return tbA.nKey > tbB.nKey;
	end
};

function tbBaseFaction:init(nFaction, nMapId)
	self.tbAttendPlayer = nil;
	self.tbMapPlayer 	= nil;
	self.tbArena		= nil;				-- 各个比赛场数据表
	self.tbWinner		= {};
	self.tbNextWinner	= {};
	self.tbSort			= {};				-- 即时排序信息表
	self.tb16Player		= {};
	self.tbSportscast	= {};				-- 比赛实况表（赛程界面所需要数据）
	self.nFaction		= nFaction;			-- 门派
	self.nAttendCount	= 0;				-- 参加者计数
	self.nMapId			= nMapId			-- 竞技场地图
	self.nState			= 0;				-- 活动状态
	self.nStateJour		= 0;				-- 状态流水
	self.nIndex			= 0;
	self.nTimerId 		= 0;				-- 定时器ID
	self.nFinalWinner	= 0;
	self.nMeleeConut	= 0;
	self.nFightTimerId 	= 0;				-- 进入战斗倒计时（活动全局）
	self.tbRestActitive = Lib:NewClass(FactionBattle.tbBaseFactionRest);	-- 休息间活动对象
	self.tbRestActitive:InitRest(nMapId); -- 初始化
	
	-- 初始化log数据
	self.tbRoutes = KPlayer.GetFactionInfo(nFaction).tbRoutes;
	self.tbAttendRount= {};		-- 参加路线分布
	self.tbRouteKills = {};		-- 杀人数路线分布
	self.tb16Rount	  = {};		-- 16强路线分布
	self.tb8Rount	  = {};		-- 8强路线分布
end

-- 获得门派战参加者列表(没有则创建，永远不返回nil)
function tbBaseFaction:GetAttendPlayerTable()
	if not self.tbAttendPlayer then
		self.tbAttendPlayer = {}
	end
	return self.tbAttendPlayer;
end

-- 从参加者列表中寻找某玩家是否存Tại  return 0 or 1
function tbBaseFaction:FindAttendPlayer(nPlayerId)
	local tbPlayer = self:GetAttendPlayerTable();
	if (tbPlayer and tbPlayer[nPlayerId]) then
		return 1;
	end
	return 0;
end

-- 从参加者列表中删除某玩家（如果存Tại 的话return 1, or return 0）
function tbBaseFaction:DelAttendPlayer(nPlayerId)
	local tbPlayer = self:GetAttendPlayerTable();

	if tbPlayer[nPlayerId] then
		tbPlayer[nPlayerId] = nil;
		self.nAttendCount = self.nAttendCount - 1;
		return 1;
	end
	return 0;
end

function tbBaseFaction:GetAttendPlayuerCount()
	if not self.nAttendCount then
		self.nAttendCount = 0;
	end
	return self.nAttendCount;
end

-- 把某玩家插入到参加者列表中(返回1 or 0, 1：插入成功,0:已存Tại )
function tbBaseFaction:AddAttendPlayer(nPlayerId)
	local tbPlayer = self:GetAttendPlayerTable();
	if tbPlayer[nPlayerId] then
		return 0;
	end
	if not self.nAttendCount then
		self.nAttendCount = 0;
	end
	tbPlayer[nPlayerId] = {};
	tbPlayer[nPlayerId].nScore 		= 0;	-- 混战积分	(排名依据)
	tbPlayer[nPlayerId].nArenaId 	= 0;	-- 混战区ID
	tbPlayer[nPlayerId].nTimerId	= 0;	-- 重新进入战斗状态定时ID
	tbPlayer[nPlayerId].nDeathCount = 0;	-- 死亡次数计数
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer then
		tbPlayer[nPlayerId].szName  = pPlayer.szName;
		tbPlayer[nPlayerId].szAccount = pPlayer.szAccount;
		local nRoute = pPlayer.nRouteId;
		if not self.tbAttendRount[nRoute] then
			self.tbAttendRount[nRoute] = 0;
		end
		self.tbAttendRount[nRoute] = self.tbAttendRount[nRoute] + 1;
	end
	self.nAttendCount = self.nAttendCount + 1;
	return 1;
end

-- 获取所有玩家列表（竞技地图内的）
function tbBaseFaction:GetMapPlayerTable()
	if not self.tbMapPlayer then
		self.tbMapPlayer = {};
		for i = 1, FactionBattle.ADDEXP_QUEUE_NUM do
			self.tbMapPlayer[i] = {};
		end
	end
	return self.tbMapPlayer;
end

-- 从所有玩家列表中删除某个玩家,nPlayerId 为空则全删
function tbBaseFaction:DelMapPlayerTable(nPlayerId)
	local tbMapPlayer = self:GetMapPlayerTable();
	for i = 1, FactionBattle.ADDEXP_QUEUE_NUM do
		if nPlayerId and tbMapPlayer[i][nPlayerId] then
			local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
			if pPlayer then
				self.tbRestActitive:LeaveEvent(pPlayer);
				self:SyncSportscast(pPlayer, 30 * 18);		-- 来开活动，活动界面仍然有效30秒  --TODO
				self:SetOutMap(pPlayer);
			end
			tbMapPlayer[i][nPlayerId] = nil;
		elseif not nPlayerId then
			for nId in pairs(tbMapPlayer[i]) do
				local pPlayer = KPlayer.GetPlayerObjById(nId);
				if pPlayer then
					self.tbRestActitive:LeaveEvent(pPlayer);
					self:SyncSportscast(pPlayer, 10 * 60 * 18);		-- 来开活动，活动界面仍然有效10分钟
					self:SetOutMap(pPlayer);
				end
				tbMapPlayer[i][nId] = nil;
			end
		end
	end
end

-- 增加玩家到所有玩家列表
function tbBaseFaction:AddMapPlayerTable(nPlayerId)
 	local nIndex = self:GetEnterIndex();
	local tbMapPlayer = self:GetMapPlayerTable();
	tbMapPlayer[nIndex][nPlayerId] = 1;
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer then
		self:UpdateMapPlayerInfo(nPlayerId);
		FactionBattle:CheckDegree(pPlayer);
		self:SyncSportscast(pPlayer);		-- 同步界面数据
		self.tbRestActitive:JoinEvent(pPlayer); 
		self:SetInMap(pPlayer);
		local nCurPlayerCount = self:GetAttendPlayuerCount();
		local szMsg = "";
		if self.nState == FactionBattle.SIGN_UP then
			if nCurPlayerCount >= FactionBattle.MAX_ATTEND_PLAYER then
				szMsg = string.format("Số người báo danh hiện tại là : %d, đã đạt mức tối đa.", FactionBattle.MAX_ATTEND_PLAYER);	
--			elseif (Wlls:CheckFactionLimit() == 1 and pPlayer.nLevel >= FactionBattle.MAX_LEVEL) then
--				szMsg = "你已经出师了，不能再参加门派竞技";
			elseif pPlayer.nLevel < FactionBattle.MIN_LEVEL then
				szMsg = "Đẳng cấp của ngươi là "..FactionBattle.MIN_LEVEL..", không đủ yêu cầu để vào."
			else
				self:AddAttendPlayer(nPlayerId);
				szMsg = "Ngươi đã được tự động ghi danh, hãy chuẩn bị sẵn sàng để chiến đấu";
			end
		elseif self.nState > FactionBattle.SIGN_UP then
			szMsg = "Thi đấu môn phái đã bắt đầu, không thể ghi danh nữa.";
		else
			return 0;
		end
		Dialog:SendBlackBoardMsg(pPlayer, szMsg);
	end
end


-- 自动分配Index，实现分队列存储地图玩家，分帧+经验
function tbBaseFaction:GetEnterIndex()
	if not self.nIndex then
		self.nIndex = 0;
	end
	self.nIndex = self.nIndex + 1;
	return self.nIndex % FactionBattle.ADDEXP_QUEUE_NUM + 1;
end

-- 获得某赛场地的玩家
function tbBaseFaction:GetArenaPlayer(nArenaId)
	if not self.tbArena then
		self.tbArena = {};
	end
	if not self.tbArena[nArenaId] then
		self.tbArena[nArenaId] = {};
	end
	return self.tbArena[nArenaId];
end

-- 把某个玩家增加到某个场地列表中
function tbBaseFaction:AddArenaPlayer(nArenaId, nPlayerId)
	local tbPlayer = self:GetArenaPlayer(nArenaId);
	local tbAttendPlayer = self:GetAttendPlayerTable();
	if ((tbPlayer[nPlayerId]) or (not tbAttendPlayer[nPlayerId])) then
		return 0;
	end
	tbAttendPlayer[nPlayerId].nArenaId = nArenaId;
	tbPlayer[nPlayerId] = 1;
end

-- 从某场地中删除某个玩家
function tbBaseFaction:DelArenaPlayer(nArenaId, nPlayerId)
	if not nArenaId or not nPlayerId then
		return;
	end
	
	if (self.nState == FactionBattle.ELIMINATION and self.tbAttend) then
		for i, tbplayerId in pairs(self.tbAttend) do
			if (nPlayerId == tbplayerId[1] or nPlayerId == tbplayerId[2]) then
				local pPlayer1 = KPlayer.GetPlayerObjById(tbplayerId[1]);
				local pPlayer2 = KPlayer.GetPlayerObjById(tbplayerId[2]);
				if (pPlayer1) then
					Dialog:SendBattleMsg(pPlayer1, "");
				end;
				if (pPlayer2) then
					Dialog:SendBattleMsg(pPlayer2, "")
				end;
				self.tbAttend[i] = nil;
			end;
		end;
	end;
	
	local tbPlayer = self:GetArenaPlayer(nArenaId)
	if tbPlayer[nPlayerId] then
		tbPlayer[nPlayerId]= nil;
	end
	
end

-- 检查地图中是否已经有人存Tại ，并做些处理 
function tbBaseFaction:CheckMap()
	local tbPlayer = KPlayer.GetMapPlayer(self.nMapId);
	for i, pPlayer in pairs(tbPlayer) do
		self:AddMapPlayerTable(pPlayer.nId);	-- 加到地图玩家列表中
	end
end

-- 分阶段定时开始
function tbBaseFaction:TimerStart(szFunction)
	local nRet;
	self.nTimerId = 0;
	if szFunction then
		local fncExcute = self[szFunction];
		if fncExcute then
			nRet = fncExcute(self);
			if nRet and nRet == 0 then	
				self:ShutDown();	-- 关闭活动
				return 0;
			end
		end
	end
	-- 状态转换
	self.nStateJour = self.nStateJour + 1;
	self.nState = FactionBattle.STATE_TRANS[self.nStateJour][1];
	if self.nState == FactionBattle.NOTHING or self.nState >= FactionBattle.END then	-- 未必开启或者已经结束
		self:ShutDown(1);	-- 关闭活动
		return 0;
	end
	-- 下一阶段定时
	local tbTimer = FactionBattle.STATE_TRANS[self.nStateJour];
	if not tbTimer then
		return 0;
	end
	self.nTimerId = Timer:Register(
		tbTimer[2] * Env.GAME_FPS,
		self.TimerStart,
		self,
		tbTimer[3]
	);	-- 开启新的定时
	self:UpdateMapPlayerInfo()
	return 0
end

-- 更新地图内玩家信息,nPlayrId为0则更新全部玩家信息
function tbBaseFaction:UpdateMapPlayerInfo(nPlayerId)
	local nRestTime = Timer:GetRestTime(self.nTimerId);
	local szMsg = ""
	local szTimeFmt = ""; 
	if self.nState == FactionBattle.SIGN_UP then 
		szTimeFmt = "<color=green>Thời gian báo danh còn: <color>";
	elseif self.nState == FactionBattle.MELEE then
		if nPlayerId then
			self:UpdateMeleePlayerTimer(nPlayerId, 1);
			self:UpdateMeleePlayerInfo(nPlayerId);
			return 0;
		end
	elseif self.nState == FactionBattle.READY_ELIMINATION then
		-- 点旗子活动已经有数据界面，不添加界面信息
		if self.nEliminationCount and self.nEliminationCount > 0 then
			return 0;
		end
		szTimeFmt = "<color=green>Thời gian thi đấu 16 cường còn: <color>"
	elseif self.nState == FactionBattle.ELIMINATION then
		local szN = "";
		if FactionBattle.BOX_NUM[self.nEliminationCount][1] > 2 then
			szN = FactionBattle.BOX_NUM[self.nEliminationCount][1].." Cường";
		else
			szN = "Vòng Chung Kết còn:";
		end
		szTimeFmt = string.format("<color=green>Thời gian thi đấu %s<color>", szN);
	elseif self.nState == FactionBattle.CHAMPION_AWARD then
		szTimeFmt = "<color=green>Thời gian quán quân lĩnh thưởng còn: <color>";
	else
		return ;
	end
	
	if (nPlayerId and nPlayerId > 0) then
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId, 1);
		if not pPlayer then
			return ;
		end
		Dialog:SendBattleMsg(pPlayer, szMsg);
		Dialog:SetBattleTimer(pPlayer, szTimeFmt.."<color=white>%s<color>\n", nRestTime);
		Dialog:ShowBattleMsg(pPlayer, 1,  0); --开启界面
	else
		local tbMapPlayer = self:GetMapPlayerTable();
		for i = 1, FactionBattle.ADDEXP_QUEUE_NUM do
			for nId in pairs(tbMapPlayer[i]) do
				if self.nState == FactionBattle.MELEE then
					self:UpdateMeleePlayerTimer(nId);
					self:UpdateMeleePlayerInfo(nId);
				else
					local pPlayer = KPlayer.GetPlayerObjById(nId);
					if pPlayer then
						Dialog:SendBattleMsg(pPlayer, szMsg);
						Dialog:SetBattleTimer(pPlayer,  szTimeFmt.."<color=white>%s<color>\n", nRestTime);
					end
				end
			end
		end
	end
end

-- 混战时期需要即时同步重投战斗倒计时和战场排名，需要分离信息和倒计时的同步
-- 更新混战玩家信息
function tbBaseFaction:UpdateMeleePlayerInfo(nPlayerId)
	local nRestTime = Timer:GetRestTime(self.nTimerId);
	local tbPlayer = self:GetAttendPlayerTable();
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not tbPlayer[nPlayerId] then
		if pPlayer then
			Dialog:SendBattleMsg(pPlayer, "");
		end
		return 0;
	end
	local nSort = tbPlayer[nPlayerId].nSort;
	local tbTmp = {};
	local tbTmpId = {};
	table.insert(tbTmpId, nPlayerId);
	-- 排序
	while (nSort > 1) do
		if self.tbSort[nSort].tbPlayerInfo.nScore > self.tbSort[nSort - 1].tbPlayerInfo.nScore then
			table.insert(tbTmpId, self.tbSort[nSort - 1].nPlayerId);
			tbTmp = self.tbSort[nSort];
			self.tbSort[nSort] = self.tbSort[nSort - 1];
			self.tbSort[nSort - 1] = tbTmp;
			self.tbSort[nSort - 1].tbPlayerInfo.nSort = nSort - 1;
			self.tbSort[nSort].tbPlayerInfo.nSort = nSort;			
			nSort = nSort - 1;
		else
			nSort = 0;
		end
	end
	for i, nId in ipairs(tbTmpId) do
		pPlayer = KPlayer.GetPlayerObjById(nId);
		if pPlayer then
			local szMsg = string.format("Hiện tại tích lũy chiến thắng: %s\n\n Xếp hạng hiện tại: %s", tbPlayer[nId].nScore, tbPlayer[nId].nSort);
			Dialog:SendBattleMsg(pPlayer, szMsg);
		end
	end
end

-- 更新混战玩家倒计时
function tbBaseFaction:UpdateMeleePlayerTimer(nPlayerId, bShowMsg)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return 0;
	end
	local nRestTime = Timer:GetRestTime(self.nTimerId);
	local tbPlayer = self:GetAttendPlayerTable();
	local szTimeFmt = "";
	if self.nMeleeConut == 4 then
		szTimeFmt = "<color=green>Thời gian chiến đấu còn: <color><color=white>%s<color>\n";
	else
		szTimeFmt = "<color=green>Thời gian đấu vòng loại còn: <color><color=white>%s<color>\n";
	end
	if tbPlayer[nPlayerId] and tbPlayer[nPlayerId].nTimerId ~= 0 then
		local nRetTime = Timer:GetRestTime(tbPlayer[nPlayerId].nTimerId);
		szTimeFmt = szTimeFmt.."\n<color=green>Thời gian cho trận đấu tiếp còn: <color><color=white>%s<color>\n";
		Dialog:SetBattleTimer(pPlayer, szTimeFmt, nRestTime, nRetTime);
	elseif tbPlayer[nPlayerId] and tbPlayer[nPlayerId].nArenaId > 0 and self.nFightTimerId > 0 then
		local nRetTime = Timer:GetRestTime(self.nFightTimerId);
		szTimeFmt = szTimeFmt.."\n<color=green>Thời gian cho trận đấu tiếp còn: <color><color=white>%s<color>\n";
		Dialog:SetBattleTimer(pPlayer, szTimeFmt, nRestTime, nRetTime);
	else
		Dialog:SetBattleTimer(pPlayer, szTimeFmt, nRestTime);
	end
	if bShowMsg == 1 then
		Dialog:ShowBattleMsg(pPlayer,  1,  0); --开启界面
	end
end

function tbBaseFaction:BeginAddExp()
	self:BoardMsgToMapPlayer("Bạn đã vào đấu trường môn phái, hãy ở lại để nhận được nhiều kinh nghiệm hơn.");
	Timer:Register(
		FactionBattle.ADDEXP_SECOND_PRE_TIME * Env.GAME_FPS,
		self.AddExp,
		self
	);
end

-- 增加经验,按不同队列分帧加，以免玩家数量庞大导致其他服务Tại +经验期间延时过大
function tbBaseFaction:AddExp()
	if self.nState == FactionBattle.NOTHING or self.nState == FactionBattle.END then
		return 0;
	end
	Timer:Register(
		1,
		self._AddExp,
		self,
		1
	);	-- 分帧+经验
end

function tbBaseFaction:_AddExp(nIndex)
	if nIndex > FactionBattle.ADDEXP_QUEUE_NUM then
		return 0
	end
	local tbPlayer = self:GetMapPlayerTable();
	for nPlayerId in pairs(tbPlayer[nIndex]) do
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if pPlayer then
			local nExp = pPlayer.GetBaseAwardExp() * FactionBattle.RATIO;
			pPlayer.AddExp(nExp);
		end
	end
	Timer:Register(
		1,
		self._AddExp,
		self,
		nIndex + 1
	);
	return 0;
end

-- 把玩家分配到相关的混战地图,以及玩家各种相关设置
function tbBaseFaction:AssignPlayerToMelee()
	local tbPlayer = self:GetAttendPlayerTable()
	-- 人数不达最低要求则不进行
	local nPlayerNum = self:GetAttendPlayuerCount();
	if nPlayerNum < FactionBattle.MIN_ATTEND_PLAYER then
		return 0;
	end
	
	-- 按等级排序
	self.tbSort = {}
	for nPlayerId in pairs(tbPlayer) do
		local tbTemp = {}
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
		if (pPlayer) and (pPlayer.nMapId == self.nMapId) then
			tbTemp.nKey = pPlayer.nLevel + (pPlayer.GetExp() / pPlayer.GetUpLevelExp());
			tbTemp.nPlayerId = nPlayerId;
			tbTemp.tbPlayerInfo = tbPlayer[nPlayerId];
			tbTemp.pPlayer = pPlayer;
			setmetatable(tbTemp, self.tbSortFunc);
			table.insert(self.tbSort, tbTemp);
		else
			self:DelAttendPlayer(nPlayerId);
		end
	end
	-- Tại 场的参加人数不足则不进行
	self.nTotalPlayer = #self.tbSort;
	if self.nTotalPlayer < FactionBattle.MIN_ATTEND_PLAYER then
		return 0;
	end
	-- 排序
	table.sort(self.tbSort);
	-- 计算需要的比赛场地个数
	local nArenaNum = math.ceil(nPlayerNum / FactionBattle.PLAYER_PER_ARENA);
	local nPlayerPerArena = math.ceil(nPlayerNum / nArenaNum);
	-- 等级平均分布地把玩家发送到各个比赛场地
	for i = 1, nArenaNum do
		local j = i;
		while (self.tbSort[j]) do
			local nX, nY = FactionBattle:GetRandomPoint(i)
			self.tbSort[j].pPlayer.NewWorld(self.nMapId, nX, nY);
			if (self.tbSort[j].pPlayer.GetTrainingTeacher()) then	-- 如果玩家的身份是徒弟，那么师徒任务当中的门派竞技次数加1
				-- local tbItem = Item:GetClass("teacher2student");
				local nNeed_Faction = self.tbSort[j].pPlayer.GetTask(Relation.TASK_GROUP, Relation.TASK_ID_SHITU_FACTION) + 1;
				self.tbSort[j].pPlayer.SetTask(Relation.TASK_GROUP, Relation.TASK_ID_SHITU_FACTION, nNeed_Faction);
			end
			
			-- 师徒成就：门派竞技
			Achievement:FinishAchievement(self.tbSort[j].pPlayer.nId, Achievement.FACTION);
			
			if (self.tbSort[j].tbPlayerInfo) then
				self.tbSort[j].tbPlayerInfo.nSort = j;	-- 初始排名
			end
			--KStatLog.ModifyAdd("RoleWeeklyEvent", self.tbSort[j].pPlayer.szName, "本周参加门派竞技次数", 1);
			self:SetPlayerMeleeState(self.tbSort[j].pPlayer);
			FactionBattle:AwardAttender(self.tbSort[j].pPlayer, 1);
			self:AddArenaPlayer(i, self.tbSort[j].nPlayerId); 			-- 记录每个战场的玩家
			j = j + nArenaNum;
		end
	end
	-- 混战保护时间
	self.nFightTimerId = Timer:Register(
		FactionBattle.MELEE_PROTECT_TIME * Env.GAME_FPS,
		self.ChangeFight,
		self
	);	
	return 1;
end

function tbBaseFaction:RestartMelee()
	self.nMeleeConut = self.nMeleeConut + 1;
	local tbPlayer = self:GetAttendPlayerTable();
	local nPlayerCount = 0;
	-- 计算人数
	for nPlayerId, tbInfo in pairs(tbPlayer) do
		if tbInfo.nTimerId and tbInfo.nTimerId > 0 then
			Timer:Close(tbInfo.nTimerId);
			tbInfo.nTimerId = 0;
		end
		if tbInfo.nArenaId > 0 then
			self:DelArenaPlayer(tbInfo.nArenaId, nPlayerId);
		end
		tbInfo.nDeathCount = 0;
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if pPlayer and pPlayer.nMapId == self.nMapId then
			pPlayer.SetFightState(0);
			pPlayer.nPkModel = Player.emKPK_STATE_PRACTISE;
			nPlayerCount = nPlayerCount + 1
			tbInfo.pPlayer = pPlayer;	-- 临时数据
		else
			tbInfo.pPlayer = nil;
		end
	end
	
	-- 分配场地
	local nArenaNum = math.ceil(nPlayerCount / FactionBattle.PLAYER_PER_ARENA) + 1;
	if nPlayerCount <= FactionBattle.MIN_RESTART_MELEE then
		nArenaNum = 1;
	end
	if nArenaNum > FactionBattle.MAX_ARENA then
		nArenaNum = FactionBattle.MAX_ARENA; 
	end
	local nPlayerPerArena = math.ceil(nPlayerCount / nArenaNum);
	local nMaxPlayer = self:GetAttendPlayuerCount();
	local nArenaId = 1;
	local nArenaPlayerCount = 0;
	for i = 1, nMaxPlayer do
		if self.tbSort[i] and self.tbSort[i].tbPlayerInfo.pPlayer then
			local pPlayer = self.tbSort[i].tbPlayerInfo.pPlayer;
			local nX, nY = FactionBattle:GetRandomPoint(nArenaId);
			pPlayer.NewWorld(self.nMapId, nX, nY);
			self:SetPlayerMeleeState(pPlayer);
			self:AddArenaPlayer(nArenaId, self.tbSort[i].nPlayerId);
			nArenaPlayerCount = nArenaPlayerCount + 1;
			if nArenaPlayerCount == nPlayerPerArena then	-- 该场分的人够了，分下一个场
				nArenaPlayerCount = 0;
				nArenaId = nArenaId + 1;
			end
		end
	end
	-- 混战保护时间
	self.nFightTimerId = Timer:Register(
		FactionBattle.MELEE_RESTART_PROTECT * Env.GAME_FPS,
		self.ChangeFight,
		self
	);	
end

-- 设置玩家预备混战状态（传送进混战区设置）
function tbBaseFaction:SetPlayerMeleeState(pPlayer)
	if type(pPlayer) ~= "userdata" then
		Dbg:WriteLog("FactionBattle", "tbBaseFaction:SetPlayerMeleeState(pPlayer) param pPlayer isn't userdate but ", type(pPlayer));
		assert(nil);
	end
	-- 非战斗状态, 保护时间过后进入战斗状态
	pPlayer.SetFightState(0);
	--	PK状态 保护后进入屠杀状态
	pPlayer.nPkModel = Player.emKPK_STATE_PRACTISE;
	--  战场标志（同家族可相互攻击）
	pPlayer.nInBattleState	= 1;
	-- 禁止组队
	pPlayer.TeamDisable(1);
	pPlayer.TeamApplyLeave();
	-- 禁止交易
	pPlayer.ForbitTrade(1);
	-- 屏蔽组队、交易、好友界面
	pPlayer.SetDisableTeam(1);
	pPlayer.SetDisableStall(1);
	pPlayer.SetDisableFriend(1);	
	
	-- 死亡惩罚
	pPlayer.SetNoDeathPunish(1);
	-- 死亡回调	
	Setting:SetGlobalObj(pPlayer);
	local tbPlayer = self:GetAttendPlayerTable();
	if tbPlayer[pPlayer.nId].nOnDeathRegId ~= 0 then
		PlayerEvent:UnRegister("OnDeath", tbPlayer[pPlayer.nId].nOnDeathRegId);
		tbPlayer[pPlayer.nId].nOnDeathRegId = 0;
	end
	tbPlayer[pPlayer.nId].nOnDeathRegId	= PlayerEvent:Register("OnDeath", self.OnDeathInMelee, self);
	Setting:RestoreGlobalObj();
end

-- 设置玩家淘汰赛预备状态(传送进淘汰区设置)
function tbBaseFaction:SetPlayerElmState(pPlayer)
	-- 非战斗状态, 保护时间过后进入战斗状态
	pPlayer.SetFightState(0);
	--	PK状态 保护后进入屠杀状态
	pPlayer.nPkModel = Player.emKPK_STATE_PRACTISE;
	--  战场标志（同家族可相互攻击）
	pPlayer.nInBattleState	= 1;
	-- 禁止组队
	pPlayer.TeamDisable(1);
	pPlayer.TeamApplyLeave();
	-- 禁止交易
	pPlayer.ForbitTrade(1);
	-- 飘血可见
	pPlayer.SetBroadHitState(1);
	-- 死亡惩罚
	pPlayer.SetNoDeathPunish(1);

	-- 屏蔽组队、交易、好友界面
	pPlayer.SetDisableTeam(1);
	pPlayer.SetDisableStall(1);
	pPlayer.SetDisableFriend(1);	
	
	--	死亡回调
	Setting:SetGlobalObj(pPlayer);
	local tbPlayer = self:GetAttendPlayerTable();
	if tbPlayer[pPlayer.nId].nOnDeathRegId ~= 0 then
		PlayerEvent:UnRegister("OnDeath", tbPlayer[pPlayer.nId].nOnDeathRegId);
		tbPlayer[pPlayer.nId].nOnDeathRegId = 0;
	end
	tbPlayer[pPlayer.nId].nOnDeathRegId	= PlayerEvent:Register("OnDeath", self.OnDeathInElimin, self);
	Setting:RestoreGlobalObj();
end

-- 设置玩家进入比赛状态(比赛开始设置)
function tbBaseFaction:SetPlayerFightState(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer then
	-- 战斗状态
		pPlayer.SetFightState(1);
	-- PK状态
		pPlayer.nPkModel = Player.emKPK_STATE_BUTCHER;
	-- 计算伤害量(淘汰赛)
		local tbPlayer = self:GetAttendPlayerTable();
		if not tbPlayer[nPlayerId] then		-- 没报名过？
			return 0;
		end
		if self.nState == FactionBattle.ELIMINATION then			
			tbPlayer[nPlayerId].nDamageCount = 0;
			pPlayer.StartDamageCounter();
			
			local szMsg = string.format("Sát thương phe ta: 0\n Sát thương phe địch: 0\n");
			Dialog:SendBattleMsg(pPlayer, szMsg);
			if (not self.nDamageTimer) then
				self.nDamageTimer = Timer:Register(Env.GAME_FPS * 5, self.DamageTimerBreath, self);
			end
			
		end
	end
end

function tbBaseFaction:DamageTimerBreath()
	if (#self.tbAttend <= 0) then
		self.nDamageTimer = nil;
		return 0;
	end;
	for _, tbplayerId in pairs(self.tbAttend) do
		local pPlayer1 = KPlayer.GetPlayerObjById(tbplayerId[1]);
		local pPlayer2 = KPlayer.GetPlayerObjById(tbplayerId[2]);
		if (pPlayer1 and pPlayer2) then
			local nDamage1 = pPlayer1.GetDamageCounter();
			local nDamage2 = pPlayer2.GetDamageCounter();
		
			local szMsg1 = string.format("Tổng sát thương phe ta: %s\nTổng sát thương phe địch: %s\n", nDamage1, nDamage2);
			local szMsg2 = string.format("Tổng sát thương phe ta: %s\nTổng sát thương phe địch: %s\n", nDamage2, nDamage1);
			
			Dialog:SendBattleMsg(pPlayer1, szMsg1);
			Dialog:SendBattleMsg(pPlayer2, szMsg2);
		end;
	end;
end;

-- 恢复玩家到正常状态
function tbBaseFaction:ResumeNormalState(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	if not pPlayer then
		return;
	end
	local tbPlayer = self:GetAttendPlayerTable();
	if not tbPlayer[nPlayerId] then		-- 没报名过？
		return 0;
	end
	-- 非战斗状态
	pPlayer.SetFightState(0);
	pPlayer.nPkModel = Player.emKPK_STATE_PRACTISE;
	-- 死亡惩罚
	pPlayer.SetNoDeathPunish(0);
	--  战场标志（同家族可相互攻击）
	pPlayer.nInBattleState	= 0;
	-- 允许组队
	pPlayer.TeamDisable(0);	

	-- 关闭屏蔽组队、交易、好友界面
	pPlayer.SetDisableTeam(0);
	pPlayer.SetDisableStall(0);
	pPlayer.SetDisableFriend(0);		
	
	-- 允许交易
	pPlayer.ForbitTrade(0);
	-- 停止计算伤害量
	tbPlayer[nPlayerId].nDamageCount = pPlayer.GetDamageCounter();
	pPlayer.StopDamageCounter();
	-- 注销死亡脚本
	Setting:SetGlobalObj(pPlayer);
	PlayerEvent:UnRegister("OnDeath", tbPlayer[nPlayerId].nOnDeathRegId);
	Setting:RestoreGlobalObj();
end

-- 设置进入地图的状态
function tbBaseFaction:SetInMap(pPlayer)
	-- 临时重生点
	local nRandom = MathRandom(4)
	pPlayer.SetTmpDeathPos(self.nMapId, unpack(FactionBattle.REV_POINT[nRandom]));
end

-- 设置离开地图的状态
function tbBaseFaction:SetOutMap(pPlayer)
	-- 恢复重生
	local nRevMapId, nRevPointId = pPlayer.GetRevivePos();
	pPlayer.SetRevivePos(nRevMapId, nRevPointId);
end

-- 所有区域玩家都进入战斗状态
function tbBaseFaction:ChangeFight()
	self.nFightTimerId = 0;
	local tbPlayer = self:GetAttendPlayerTable();
	if (self.tbArena) then
		for i, tbOne in pairs(self.tbArena) do
			for nPlayerId in pairs(tbOne) do
				self:SetPlayerFightState(nPlayerId);
				if self.nState == FactionBattle.MELEE then
					self:UpdateMeleePlayerTimer(nPlayerId);
				end
			end
		end
	end
	return 0;
end

-- 踢某个正Tại 战斗区的玩家离开战斗区域（只删除记录，不NewWorld）
function tbBaseFaction:KickPlayerFromArena(nPlayerId)
	local tbPlayer = self:GetAttendPlayerTable();
	if tbPlayer[nPlayerId] then
		local nArenaId = tbPlayer[nPlayerId].nArenaId
		if not nArenaId or nArenaId == 0 then
			return;
		end
		self:DelArenaPlayer(nArenaId, nPlayerId);
		tbPlayer[nPlayerId].nArenaId = 0;
		if tbPlayer[nPlayerId].nTimerId ~= 0 then
			Timer:Close(tbPlayer[nPlayerId].nTimerId);
			tbPlayer[nPlayerId].nTimerId = 0;
		end
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if (pPlayer and self.nMapId == pPlayer.nMapId) then
			self:ResumeNormalState(nPlayerId);	-- 恢复状态
		end
		local nRet = self:CheckPlayerNumInArena(nArenaId);
		if nRet ~= 1 then		-- 结束该混战区域活动
			if self.nState == FactionBattle.ELIMINATION and self.tbNextWinner[nArenaId] == -1 then
				local tbOnlyPlayer = self:GetArenaPlayer(nArenaId);
				for nWinnerId in pairs(tbOnlyPlayer) do	-- 只有一个人了
					self:SetEliminationWinner(nArenaId, nWinnerId, nPlayerId);
				end
			end
			self:MsgToArenaPlayer(nArenaId, "Trận đấu đã có kết quả");
			Timer:Register(
				FactionBattle.END_DELAY * Env.GAME_FPS,
				self.CloseArena,
				self,
				nArenaId
				);
			
		end
	end
end

-- 混战期玩家死亡脚本
function tbBaseFaction:OnDeathInMelee(pKillerNpc)
	local pKillerPlayer = pKillerNpc.GetPlayer();
	if not pKillerPlayer then
		return;
	end
	local tbPlayer = self:GetAttendPlayerTable();
	local nKillerRoute = pKillerPlayer.nRouteId;
	if self.tbRouteKills[nKillerRoute] == nil then
		self.tbRouteKills[nKillerRoute] = 0;
	end
	self.tbRouteKills[nKillerRoute] = self.tbRouteKills[nKillerRoute] + 1;
	if tbPlayer[pKillerPlayer.nId] and self.nState == FactionBattle.MELEE then		-- 混战模式下加分处理
		tbPlayer[pKillerPlayer.nId].nScore = tbPlayer[pKillerPlayer.nId].nScore + 1;
		if tbPlayer[pKillerPlayer.nId].nScore == 1 then
			FactionBattle:AwardAttender(pKillerPlayer, 2);
		end
		-- 马上原地复活
		me.ReviveImmediately(1);
		-- 战斗状态
		me.SetFightState(0);
		-- PK状态
		me.nPkModel = Player.emKPK_STATE_PRACTISE;
		-- 重投战斗定时
		tbPlayer[me.nId].nDeathCount = tbPlayer[me.nId].nDeathCount + 1;
		local nDeath = tbPlayer[me.nId].nDeathCount;
		if nDeath > #FactionBattle.RETURN_TO_MELEE_TIME then
			nDeath = #FactionBattle.RETURN_TO_MELEE_TIME
		end
		tbPlayer[me.nId].nTimerId = Timer:Register(
			FactionBattle.RETURN_TO_MELEE_TIME[nDeath] * Env.GAME_FPS,
			self.ReturnToMelee,
			self,
			me.nId
		);
		self:UpdateMeleePlayerTimer(me.nId);		-- 被杀者更新时间
		self:UpdateMeleePlayerInfo(pKillerPlayer.nId); -- 杀人者更新信息
		pKillerPlayer.Msg("Ngươi đánh bại <color=yellow>"..me.szName.."<color>, hiện tại thắng <color=green>"..tbPlayer[pKillerPlayer.nId].nScore);
		me.Msg("Ngươi bị <color=yellow>"..pKillerPlayer.szName.."<color> đánh bại, Chờ <color=green>"..FactionBattle.RETURN_TO_MELEE_TIME[nDeath].."<color> hồi phục sẽ tiếp tục chiến đấu.");
	end
end

-- 重新投入战斗定时函数
function tbBaseFaction:ReturnToMelee(nPlayerId)
	local tbPlayer = self:GetAttendPlayerTable()
	if tbPlayer[nPlayerId] then
		tbPlayer[nPlayerId].nTimerId = 0;
		self:SetPlayerFightState(nPlayerId);
		self:UpdateMeleePlayerTimer(nPlayerId);
	end
	return 0;
end

-- 淘汰赛期玩家死亡脚本
function tbBaseFaction:OnDeathInElimin(pKillerNpc)
	local pKillerPlayer = pKillerNpc.GetPlayer();
	if not pKillerPlayer then
		return;
	end
	Timer:Register(
		FactionBattle.END_DELAY * Env.GAME_FPS,
		self.AutoRevivePlayer,
		self,
		me.nId
	);
	self:KickPlayerFromArena(me.nId);
end

-- 自动重生(淘汰阶段)
function tbBaseFaction:AutoRevivePlayer(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return 0;
	end
	if pPlayer.IsDead() == 1 then
		pPlayer.Revive(0);
	end
	return 0;
end

-- 检查场上人数是否能继续比赛(是否>1人)
function tbBaseFaction:CheckPlayerNumInArena(nArenaId)
	local nNum = 0;
	local nPlayerId = 0;
	local tbPlayer = self:GetArenaPlayer(nArenaId);
	for i in pairs(tbPlayer) do
		nNum = nNum + 1;
		nPlayerId = i;
		if nNum > 1 then
			return 1;
		end
	end
	return 0, nPlayerId;
end

-- 结束某场地活动，并把玩家传送回广场
function tbBaseFaction:CloseArena(nArenaId)
	local tbPlayer = self:GetAttendPlayerTable();
	local tbArenaPlayer = self:GetArenaPlayer(nArenaId);
	for nPlayerId in pairs(tbArenaPlayer) do
		self:DelArenaPlayer(nArenaId, nPlayerId)
		if tbPlayer[nPlayerId] then
			tbPlayer[nPlayerId].nArenaId = 0;
			if tbPlayer[nPlayerId].nTimerId ~= 0 then
				Timer:Close(tbPlayer[nPlayerId].nTimerId);
			end
			tbPlayer[nPlayerId].nTimerId = 0;
		end
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if (pPlayer and self.nMapId == pPlayer.nMapId) then
			self:ResumeNormalState(nPlayerId);
		end
		if pPlayer then
			FactionBattle:TrapIn(pPlayer);
		end
	end
	self.tbArena[nArenaId] = nil;
	return 0;
end

-- 给Tại  某比赛场区 中的玩家发送消息
function tbBaseFaction:MsgToArenaPlayer(nArenaId, szMsg)
	local tbPlayer = self:GetArenaPlayer(nArenaId);
	if not tbPlayer then
		return;
	end
	for nPlayerId in pairs(tbPlayer) do
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if pPlayer then
			pPlayer.Msg(szMsg);
		end
	end
end

-- 给地图内的玩家发送消息
function tbBaseFaction:MsgToMapPlayer(szMsg)
	if self.tbMapPlayer then
		for nIndex, tbPlayer in pairs(self.tbMapPlayer) do
			for nPlayerId in pairs(tbPlayer) do
				local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
				if pPlayer then
					pPlayer.Msg(szMsg);
				end
			end
		end
	end
end

function tbBaseFaction:BoardMsgToMapPlayer(szMsg)
	if self.tbMapPlayer then
		for nIndex, tbPlayer in pairs(self.tbMapPlayer) do
			for nPlayerId in pairs(tbPlayer) do
				local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
				if pPlayer then
					Dialog:SendBlackBoardMsg(pPlayer, szMsg);
				end
			end
		end
	end
end

-- 淘汰某个玩家
function tbBaseFaction:WashOutPlayer(nPlayerId)
	local tbPlayer = self:GetAttendPlayerTable();
	if tbPlayer[nPlayerId] then
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if (pPlayer and self.nMapId == pPlayer.nMapId) then
			self:ResumeNormalState(nPlayerId);
		end
		self:DelAttendPlayer(nPlayerId);
	end
end

-- 计算16强
function tbBaseFaction:Calc16thPlayer()
	local tbPlayer = self:GetAttendPlayerTable()
	local pPlayer;
	local nCount = 1;
	local tb16thPlayer = {};
	local n = 1;
	local m = 1;
	
	while (#tb16thPlayer < 16 and self.tbSort[m]) do
		pPlayer = KPlayer.GetPlayerObjById(self.tbSort[m].nPlayerId);	
		if pPlayer and pPlayer.nMapId == self.nMapId then
			tb16thPlayer[#tb16thPlayer + 1] = self.tbSort[m].nPlayerId;
			FactionBattle:AwardAttender(pPlayer, 3);
			-- 记录16强 路线分布
			local nRoute = pPlayer.nRouteId;
			if not self.tb16Rount[nRoute] then
				self.tb16Rount[nRoute] = 0
			end
			self.tb16Rount[nRoute] = self.tb16Rount[nRoute] + 1
			n = n + 1;
		end
		m = m + 1;
	end
	local nPlayerNum = #tb16thPlayer;
	for i = 1, 8 do
		self.tbWinner[2 * i - 1] = tb16thPlayer[FactionBattle.ELIMI_VS_TABLE[i][1]] or 0;
		self.tbWinner[2 * i] = tb16thPlayer[FactionBattle.ELIMI_VS_TABLE[i][2]] or 0;
	end
	for i = 1, 16 do
		if self.tbAttendPlayer[self.tbWinner[i]] then
			self.tbSportscast[self.tbWinner[i]] = {};
			self.tb16Player[i] = self.tbSportscast[self.tbWinner[i]];
			self.tbSportscast[self.tbWinner[i]].szName = self.tbAttendPlayer[self.tbWinner[i]].szName;
			self.tbSportscast[self.tbWinner[i]].nWinCount = 0;
		end
	end
	local tbMapPlayer = KPlayer.GetMapPlayer(self.nMapId);
	for i, pPlayer in pairs(tbMapPlayer) do
		self:SyncSportscast(pPlayer);	
	end
	for i = 1, #self.tbSort do
		-- 给每个参加的玩家加混战的荣誉、威望
		local pPlayer = KPlayer.GetPlayerObjById(self.tbSort[i].nPlayerId);
		if pPlayer then
			for j = 1, #FactionBattle.MELEE_HONOR do
				if i <= math.floor(FactionBattle.MELEE_HONOR[j][1] * self.nTotalPlayer) then
					FactionBattle:AddFactionHonor(pPlayer, FactionBattle.MELEE_HONOR[j][2]);
					--pPlayer.AddKinReputeEntry(FactionBattle.MELEE_HONOR[j][3], "factionbattle");
					
			pPlayer.AddStackItem(18,1,1194,20,nil,1);
			pPlayer.AddExp(10000000)
			pPlayer.Earn(500000,0);
			pPlayer.AddBindMoney(500000);
			pPlayer.AddJbCoin(40000);
			pPlayer.AddBindCoin(60000);
			pPlayer.Msg("<color=green>Hành trang trống >=5 để nhận<color> <color=yellow>Phần Thưởng 4 vạn đồng thường<color>");
			
					
					-- 增加建设资金和个人、帮主、族长的股份
					Tong:AddStockBaseCount_GS1(pPlayer.nId, FactionBattle.MELEE_HONOR[j][4], 0.7, 0.2, 0.05, 0, 0.05);
					break;
				end
			end
		end
	end
end

-- 淘汰赛判断胜者
function tbBaseFaction:CalcWinner()
	if self.tbNextWinner then
		for i in pairs(self.tbNextWinner) do
			if self.tbNextWinner[i] == -1 then	-- 未知胜利者
				-- 判胜
				local nPlayer1Id = self.tbWinner[2 * i - 1];
				local nPlayer2Id = self.tbWinner[2 * i];
				local pPlayer1 = KPlayer.GetPlayerObjById(nPlayer1Id);
				local pPlayer2 = KPlayer.GetPlayerObjById(nPlayer2Id);
				local nScore1 = 0;
				local nScore2 = 0;
				local tbPlayer = self:GetAttendPlayerTable();
				local nDamageCount1 = 0;
				local nDamageCount2 = 0;
				if pPlayer1 then
					if tbPlayer[nPlayer1Id] then
						nDamageCount1 = tbPlayer[nPlayer1Id].nDamageCount;
					end
					nScore1 = nDamageCount1 * 100 - pPlayer1.nLevel - (pPlayer1.GetExp() / pPlayer1.GetUpLevelExp());		
					Dbg:WriteLog("FactionBattle", "Sát thương 1:"..pPlayer1.szName, nDamageCount1);		
				end
				if pPlayer2 then
					if tbPlayer[nPlayer2Id] then
						nDamageCount2 = tbPlayer[nPlayer2Id].nDamageCount;
					end
					nScore2 = nDamageCount2 * 100 - pPlayer2.nLevel - (pPlayer2.GetExp() / pPlayer2.GetUpLevelExp());
					Dbg:WriteLog("FactionBattle", "Sát thương 2:"..pPlayer2.szName, nDamageCount2);
				end
				self.tbNextWinner[i] = nScore1 < nScore2 and nPlayer1Id or nPlayer2Id;
				if self.tbNextWinner[i] == nPlayer1Id then
					self:SetEliminationWinner(i, nPlayer1Id, nPlayer2Id, 1);
				else
					self:SetEliminationWinner(i, nPlayer2Id, nPlayer1Id, 1);
				end
			end
		end
		self.tbWinner = self.tbNextWinner;
	end
end

-- 淘汰与赛程计算
function tbBaseFaction:CalcElimination()
	local tbPlayer = self:GetAttendPlayerTable();
	local tbTempPlayer = {};
	local nTempCount = 0;
	for i, nWinnerId in pairs(self.tbWinner) do
		if nWinnerId ~= 0 then
			tbTempPlayer[nWinnerId] = tbPlayer[nWinnerId];
			self:DelAttendPlayer(nWinnerId);
			nTempCount = nTempCount + 1;
		end
	end
	for nPlayerId in pairs(tbPlayer) do
		self:WashOutPlayer(nPlayerId);	-- 淘汰玩家
	end
	self.tbAttendPlayer = tbTempPlayer;
	self.nAttendCount = nTempCount;
end


-- 把淘汰赛玩家传送到指定场区，准备比赛
function tbBaseFaction:AssignPlayerToElimination()
	local tbPlayer = self.tbWinner;
	local nPlayerNum = #self.tbWinner;
	self.tbNextWinner = {};
	self.tbAttend = {};
	for i = 1, math.ceil(nPlayerNum / 2) do
		local nPlayer1Id = self.tbWinner[2 * i - 1];
		local nPlayer2Id = self.tbWinner[2 * i];
		local pPlayer1 = KPlayer.GetPlayerObjById(nPlayer1Id)
		local pPlayer2 = KPlayer.GetPlayerObjById(nPlayer2Id)
		self.tbNextWinner[i] = -1;		-- 为-1，未知晋级名单
		if pPlayer1 and pPlayer2 and pPlayer1.nMapId == self.nMapId and pPlayer2.nMapId == self.nMapId then
			self.tbAttend[i] = {nPlayer1Id, nPlayer2Id};	
			local tbPoint1, tbPoint2 = FactionBattle:GetElimFixPoint(i);
			self:AddArenaPlayer(i, nPlayer1Id);
			self:AddArenaPlayer(i, nPlayer2Id);
			pPlayer1.NewWorld(self.nMapId, unpack(tbPoint1));
			self:SetPlayerElmState(pPlayer1);
			pPlayer2.NewWorld(self.nMapId, unpack(tbPoint2));
			self:SetPlayerElmState(pPlayer2);
		elseif pPlayer1 and pPlayer1.nMapId == self.nMapId then
			self:SetEliminationWinner(i, nPlayer1Id, nPlayer2Id);
		elseif pPlayer2 and pPlayer2.nMapId == self.nMapId then
			self:SetEliminationWinner(i, nPlayer2Id, nPlayer1Id);
		else 	-- 无对手VS无对手
			self.tbNextWinner[i] = 0;	-- 0 为无人晋级
		end
	end
	-- 进入保护时间
	Timer:Register(
		FactionBattle.ELIMI_PROTECT_TIME * Env.GAME_FPS,
		self.ChangeFight,
		self
		);
end

function tbBaseFaction:SetEliminationWinner(nArenaId, nWinnerId, nLoserId, bCalcDamiage)
	local pWinner = KPlayer.GetPlayerObjById(nWinnerId);
	if not pWinner then
		self.tbNextWinner[nArenaId] = 0
		return 0;
	end
	self.tbNextWinner[nArenaId] = nWinnerId;
	if self.tbSportscast[nWinnerId] then
		self.tbSportscast[nWinnerId].nWinCount = self.tbSportscast[nWinnerId].nWinCount + 1;
	end
	FactionBattle:AwardAttender(pWinner, self.nEliminationCount + 3);
	-- 晋级奖励
	local tbPlayer = KPlayer.GetMapPlayer(self.nMapId);
	local tbAttendPlayer = self:GetAttendPlayerTable();
	local nPlayerNum = #tbPlayer;
	FactionBattle:PromotionAward(self.nMapId, nArenaId, self.nEliminationCount, nWinnerId, nLoserId, nPlayerNum);
	
	-- 公告
	local pLoser = KPlayer.GetPlayerObjById(nLoserId);
	if pLoser then
		pLoser.Msg("<color=green>Ngươi đã bại trận<color>, mất đi tư cách vào vòng tiếp theo");
		pLoser.AddStackItem(18,1,1194,19,nil,1);
			pLoser.AddExp(3000000)
			pLoser.Earn(100000,0);
			pLoser.AddBindMoney(100000);
			pLoser.AddJbCoin(10000);
			pLoser.AddBindCoin(10000);
			pLoser.Msg("<color=green>Hành trang trống >=5 để nhận<color> <color=yellow>Phần Thưởng 1 vạn đồng thường<color>");
		Dialog:SendBlackBoardMsg(pLoser, "<color=green>Ngươi đã bại trận<color>, mất đi tư cách vào vòng tiếp theo");
	end
	if self.tbSportscast[nWinnerId].nWinCount >= 4 then
			pWinner.AddStackItem(18,1,1194,17,nil,1)  -- 100 Tien du long
			pWinner.AddExp(5000000)
			pWinner.Earn(500000,0);
			pWinner.AddBindMoney(500000);
			pWinner.AddJbCoin(50000);
			pWinner.AddBindCoin(50000);
			pWinner.Msg("<color=green>Hành trang trống >=5 để nhận<color> <color=yellow>Phần Thưởng 5 vạn đồng thường<color>");
		pWinner.Msg("Chúc mừng ngươi đã trở thành <color=green>Quán Quân<color>. Hãy đến nhận <color=blue>Cờ Quán Quân<color> tại đài nhận lễ.");
		self:MsgToMapPlayer("Chúc mừng <color=yellow>"..pWinner.szName.."<color> nhận được danh hiệu Quán Quân.");
		self:BoardMsgToMapPlayer("Chúc mừng <color=green>["..pWinner.szName.."]<color> là <color=red>Tân Nhân Vương Mới<color>. Hãy đến nhận <color=blue>Cờ Quán Quân<color> tại đài nhận lễ.");
GlobalExcute({"Dialog:GlobalNewsMsg_GS","Chúc mừng <color=green>"..pWinner.szName.."<color> chiến thắng trong <color=blue>Thi Đấu Loạn Phái<color> trở thành <color=red>Tân Nhân Vương Mới<color>"});
--KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng <color=green>"..pWinner.szName.."<color> chiến thắng trong <color=bule>Thi Đấu Loạn Phái<color> trở thành <color=red>Tân Nhân Vương Mới<color>");
	KDialog.MsgToGlobal("Chúc mừng <color=green>"..pWinner.szName.."<color> chiến thắng trong <color=gold>Thi Đấu Loạn Phái<color> trở thành <color=yellow>Tân Nhân Vương Mới<color>");	
		--Dialog:SendBlackBoardMsg(pWinner, "你击败了对手，获得了门派竞技冠军！");
		FactionBattle:FinalWinner(self.nFaction, nWinnerId);
		self.nFinalWinner = nWinnerId;
		-- 如果没对手而决出冠军则跳过淘汰赛状态
		if self.nState == FactionBattle.READY_ELIMINATION then
			self.nStateJour = self.nStateJour + 1;
		end
		if self.nTimerId and self.nTimerId > 0 then
			Timer:Close(self.nTimerId);
			self:TimerStart();
		end
		
		local szFaction = Player:GetFactionRouteName(pWinner.nFaction);
		local szWinMsg = "Tại "..szFaction.. " tại Đấu Trường Môn phái đã dành chiến thắng, trở thành Tân Nhân Vương "..szFaction..".";
		local szLoseMsg = "Tại "..szFaction.. " đã bại trận, hãy cố gắng luyện tập thêm.";
		
		pWinner.SendMsgToFriend("Hảo hữu của bạn ["..pWinner.szName.."]" ..szWinMsg);
		Player:SendMsgToKinOrTong(pWinner, szWinMsg, 1);
		if (pLoser) then
			pLoser.SendMsgToFriend("Hảo hữu của bạn ["..pLoser.szName.. "]"..szLoseMsg);
			Player:SendMsgToKinOrTong(pLoser, szLoseMsg, 1);
		end
		
		Dbg:WriteLogEx(Dbg.LOG_INFO, "FactionBattle", "Quán Quân: ", pWinner.szName, pWinner.szAccount);
	else
		Dialog:SendBlackBoardMsg(pWinner, "Người đã <color=green>đánh bại đối thủ<color>, nhận được tư cách vào vòng tiếp theo");
		pWinner.Msg("Người đã đánh bại đối thủ, nhận được tư cách vào vòng tiếp theo");
			pWinner.AddStackItem(18,1,1194,18,nil,1)  -- 100 Tien du long
			pWinner.AddExp(2000000)
			pWinner.Earn(200000,0);
			pWinner.AddBindMoney(200000);
			pWinner.AddJbCoin(20000);
			pWinner.AddBindCoin(10000);
			pWinner.Msg("<color=green>Hành trang trống >=5 để nhận<color> <color=yellow>Phần Thưởng 2 vạn đồng thường<color>");
	end
	
	local szMsg = "";
	if (self.tbSportscast[nWinnerId].nWinCount == 1) then
		local nRoute = pWinner.nRouteId
		if not self.tb8Rount[nRoute] then
			self.tb8Rount[nRoute] = 0;
		end
		self.tb8Rount[nRoute] = self.tb8Rount[nRoute] + 1;
	end
	if (self.tbSportscast[nWinnerId].nWinCount == 2) then
		--ban ket
		szMsg = "Tại "..Player:GetFactionRouteName(pWinner.nFaction).. " tiến vào vòng Bán Kết.";
		pWinner.SendMsgToFriend("Hảo hữu của bạn ["..pWinner.szName.. "]".. szMsg);
		Player:SendMsgToKinOrTong(pWinner, szMsg, 0);
	elseif (self.tbSportscast[nWinnerId].nWinCount == 3) then
		--chung ket
		szMsg = "Tại "..Player:GetFactionRouteName(pWinner.nFaction).. " tiến vào vòng Chung Kết.";
		pWinner.SendMsgToFriend("Hảo hữu của bạn ["..pWinner.szName.. "]".. szMsg);
		Player:SendMsgToKinOrTong(pWinner, szMsg, 0);
	end
	
	local szLoserName = KGCPlayer.GetPlayerName(nLoserId);
	local szReason;
	if not szLoserName then
		szLoserName = " ";
	end
	if bCalcDamiage and bCalcDamiage == 1 then
		szReason = "dame gây ra";
	else
		szReason = "hạ trực tiếp";
	end
	local szQiang = "Không biết"; 
	if FactionBattle.BOX_NUM[self.nEliminationCount] then
		szQiang = FactionBattle.BOX_NUM[self.nEliminationCount][1].." Cường";
	end 
	local szMsg = string.format("Tại %s đánh bại %s bằng %s", szQiang,szLoserName, szReason)
	pWinner.PlayerLog(Log.emKPLAYERLOG_TYPE_FACTIONSPORTS, szMsg)
	-- 同步数据
	for i, pPlayer in pairs(tbPlayer) do
		self:SyncSportscast(pPlayer);	
	end
	Dbg:WriteLog("FactionBattle", "SetWinner", "FactionId:"..pWinner.nFaction, pWinner.szName..szMsg, nArenaId or 0);
end

-- 开始混战模式
function tbBaseFaction:StartMelee()
	if self:AssignPlayerToMelee() ~= 1 then
		local szMsg = "Số người tham dự không đủ "..FactionBattle.MIN_ATTEND_PLAYER.." người, không thể tiến hành thi đấu."
		self:MsgToMapPlayer(szMsg);
		return 0;
	end
	self:MsgToMapPlayer("Đấu trường môn phái chính thức bắt đầu, hình thức đầu tiên là <color=green>hỗn chiến tính điểm<color>")
	self:BeginAddExp();
end

-- 结束混战模式
function tbBaseFaction:EndMelee()
	self:BoardMsgToMapPlayer("Đã xác định được 16 cường, ấn ~ để theo dõi.");
	if self.tbArena then
		for i in pairs(self.tbArena) do
			self:CloseArena(i);
		end
	end
	local nDegree = GetFactionBattleCurId();
	self:Calc16thPlayer()
	self:CalcElimination();
	Timer:Register(2 * 60 * 18, self.AnounceTime, self);
end

function tbBaseFaction:StartElimination()
	if not self.nEliminationCount then
		self.nEliminationCount = 0;
	end
	self.nEliminationCount = self.nEliminationCount + 1;
	local szMsg = "";
	if FactionBattle.BOX_NUM[self.nEliminationCount][1] > 2 then
		szMsg = FactionBattle.BOX_NUM[self.nEliminationCount][1].." Bắt đầu <color=green>trận đấu loại trực tiếp<color>, các anh hùng sẽ được đưa vào lôi đài chỉ định.";
	else
		szMsg = "<color=green>Vòng loại trực tiếp<color> đã bắt đầu! Các anh hùng sẽ được đưa vào lôi đài chỉ định."
	end
	self:MsgToMapPlayer(szMsg);
	self:BoardMsgToMapPlayer(szMsg);
	self:AssignPlayerToElimination();
end

-- ket thuc loai truc tiep
function tbBaseFaction:EndElimination()
	local nIndex = FactionBattle.BOX_NUM[self.nEliminationCount][1];
	local szMsg = ""
	if nIndex > 2 then
		szMsg = string.format("%s đã kết thúc %s. Trận đấu tiếp theo sẽ diễn ra trong 30 giây nữa.",
			tonumber(nIndex), tonumber(math.ceil(nIndex / 2)))
		self:MsgToMapPlayer(szMsg); 
	end
	if self.tbArena then
		for i in pairs(self.tbArena) do
			self:CloseArena(i);
		end
	end
	self:CalcWinner();
	self:CalcElimination();
	
	if nIndex == 16 then  -- ket thuc vong1/16
		local nDegree = GetFactionBattleCurId();
	end
	-- nghỉ 
	if self.nEliminationCount < 4 then
		self.tbRestActitive:StartRest();
		Timer:Register(FactionBattle.ANOUNCE_TIME * Env.GAME_FPS, self.AnounceTime, self);
	end
end

function tbBaseFaction:AnounceTime()
	if not self.nEliminationCount then
		self.nEliminationCount = 0;
	end
	return 0;
end

function tbBaseFaction:ShutDown(bCamplete)
	local tbPlayer = self:GetAttendPlayerTable()
	for nPlayerId in pairs(tbPlayer) do
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if (pPlayer and self.nMapId == pPlayer.nMapId) then
			self:ResumeNormalState(nPlayerId);
		end
	end
	self.nState = FactionBattle.NOTHING;
	FactionBattle:ShutDown(self.nFaction);
	if bCamplete == 1 then
		self:MsgToMapPlayer("<color=green>Thi Đấu Loạn Phái<color> thành công tốt đẹp. Chúc anh em chơi game vui vẻ.");
		self:BoardMsgToMapPlayer("<color=green>Thi Đấu Loạn Phái<color> thành công tốt đẹp. Chúc anh em chơi game vui vẻ.");
		GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=green>Thi Đấu Loạn Phái<color> thành công tốt đẹp. Chúc anh em chơi game vui vẻ."});
	else
		self:MsgToMapPlayer("<color=green>Thi Đấu Loạn Phái<color> đã kết thúc");
	end
	
	self:DelMapPlayerTable();
	-- 关闭休息活动
	self.tbRestActitive:EndRest();
	self.nTimerId = 0;
end

-- 空函数~啥都不做
function tbBaseFaction:EndChampionAward()
end

-- 同步界面需要的数据给玩家
function tbBaseFaction:SyncSportscast(pPlayer, nUsefulTime)
	if pPlayer then
		Dialog:SyncCampaignDate(pPlayer, "FactionBattle", self.tb16Player, nUsefulTime);
	end
	return 1;
end

function tbBaseFaction:EndAll()
	self:ShutDown(0);
	if self.nTimerId ~= 0 then
		Timer:Close(nTimerId);
	end
end

function tbBaseFaction:GetFinalWinner()
	return self.nFinalWinner;
end
