-- 2009 植树节
-- maiyajin

local tbZhiShu09 = {};
SpecialEvent.ZhiShu2009 = tbZhiShu09;

tbZhiShu09.TASKGID = 2027;
tbZhiShu09.TASK_LAST_IRRIGATE_TIME = 56; -- 最后浇水时间
tbZhiShu09.TASK_LAST_PLANT_TIME = 57; -- 最后植树开始时间
tbZhiShu09.TASK_LAST_PLANT_DAY = 58; -- 最后成功植树是几号
tbZhiShu09.TASK_TREE_COUNT_TODAY = 59; -- 当天成功植树数
tbZhiShu09.TASK_TREE_COUNT_TOTAL = 60; -- 成功植树总数
tbZhiShu09.TASK_TREE_IS_PLANTING = 61; -- 是否正在植树 1:可能正在种 0:没种
tbZhiShu09.TASK_LASK_GIVE_SEED_TIME = 62; -- 最后从木良处获得种子的时间
tbZhiShu09.TASK_XP_COUNT_TODAY = 63; -- 当天获得的经验数
tbZhiShu09.TASK_HAND_UP_SEED_TOTAL = 64; -- 上交种子总数
tbZhiShu09.TASK_LAST_GIVE_XP_DAY = 65; -- 最后一次给经验是那天

tbZhiShu09.WATER_TIME = 5; -- 浇一棵树使用的时间
tbZhiShu09.GROW_TIME = 5; -- 浇水成功后隔多久长成大树
tbZhiShu09.ALERT_TIME = 20; -- 树木旱死前 ALERT_TIME 秒提示
tbZhiShu09.DIE_TIME = 2 * 60; -- 树木隔多久不浇水会死掉
tbZhiShu09.WATER_INTERVAL = 60; -- 浇水最小时间间隔
tbZhiShu09.COLLECT_INTERVAL = 2 * 60; -- 采集时间间隔
tbZhiShu09.MAX_TREE_COUNT_TODAY = 2; -- 一天最多可以种几棵树
tbZhiShu09.MAX_TREE_COUNT_TOTAL = 42; -- 总共可以种几棵树
tbZhiShu09.JUG_VOLUMN = 10; -- 水壶的水量
tbZhiShu09.GIVE_SEED_INTERVAL = 30 * 60; -- 领取种子的时间间隔
tbZhiShu09.GIVE_XP_INTERVAL = 5; -- 给经验时间间隔
tbZhiShu09.BIG_TREE_LIFE = 1 * 60 * 20; -- 大树的生命

tbZhiShu09.tbNewSeed = {18,1,297,1}; -- 饱满的树种
tbZhiShu09.tbOldSeed = {18,1,295,1}; -- 陈年树种
tbZhiShu09.tbJug = {18,1,296,1}; -- 水壶
tbZhiShu09.tbBox = {18,1,298,1}; -- 墨绿盒子
tbZhiShu09.tbListWaterPlayList = {};	--记录浇水数据

tbZhiShu09.tbIndex2Data = {
		--{模板id, 经验}
	[1] = {3634, 10}, -- 奄奄小树苗
	[2] = {3635, 20}, -- 滴翠树苗
	[3] = {3636, 30}, -- 幽绿小树
	[4] = {3637, 40}, -- 茁壮小树
	[5] = {3638, 50}, -- 葱郁树木
	[6] = {3639,  0}, -- 好大一棵树
};

tbZhiShu09.INDEX_BIG_TREE = #tbZhiShu09.tbIndex2Data; -- 大树的编号

-- 搜索身上的水壶
-- return: pItem or nil
function tbZhiShu09:FindJug(pPlayer)
	local tbFind = pPlayer.FindItemInBags(unpack(self.tbJug));
	if tbFind[1] then
		return tbFind[1].pItem;
	end
	return nil;
end

-- 返回还可以浇几次水
function tbZhiShu09:GetWaterTimes(pPlayer)
	local pJug = self:FindJug(pPlayer);
	if pJug then
		return pJug.GetGenInfo(1);
	else
		return 0;
	end
end

-- 水壶的水量减1
function tbZhiShu09:DecreWaterTimes(pPlayer)
	local pJug = self:FindJug(pPlayer);
	if pJug then
		local nTimes = pJug.GetGenInfo(1);
		nTimes = nTimes - 1;
		if nTimes < 0 then
			nTimes = 0;
		end
		pJug.SetGenInfo(1, nTimes);
		pJug.Sync();
		return;
	end
end

-- 装满水壶
--no_msg 是 nil 的话才输出信息
function tbZhiShu09:FillJug(pPlayer, no_msg)
	local pJug = self:FindJug(pPlayer);
	if not pJug then
		return 0, "你的水壶呢？";
	end
	
	pJug.SetGenInfo(1,self.JUG_VOLUMN);
	pJug.Sync();
	
	if not no_msg then
		Dialog:SendBlackBoardMsg(pPlayer, "你的洒水壶已注满了水，快去种树吧！");
	end
end

-- 判断玩家植树数量是否符合要求
function tbZhiShu09:IsTreeCountOk(pPlayer)
	-- 植树总量
	local nTreeCountTotal = pPlayer.GetTask(self.TASKGID, self.TASK_TREE_COUNT_TOTAL);
	if nTreeCountTotal >= self.MAX_TREE_COUNT_TOTAL then
		return 0, "TOTAL", nTreeCountTotal;
	end
	
	local nToday = tonumber(GetLocalDate("%Y%m%d"));
	local nLastPlantDay = pPlayer.GetTask(self.TASKGID, self.TASK_LAST_PLANT_DAY);
	local nTreeCountToday = pPlayer.GetTask(self.TASKGID, self.TASK_TREE_COUNT_TODAY);
	
	-- 当天植树量(注意：当天号数和最后植树的号数一样时才需要判断，不一样的话表示那天已经过去了)
	if nToday == nLastPlantDay and nTreeCountToday >= self.MAX_TREE_COUNT_TODAY then -- 这种做法仅在活动处于1个月访内有效
		return 0, "TODAY", nTreeCountToday;
	end
	
	return 1;
end

-- 可否种树
-- return 0, 1
function tbZhiShu09:CanPlantTree(pPlayer)
	local nMapId, x, y = pPlayer.GetWorldPos();
	if nMapId > 8 then
		return 0, "只有在新手村才可以种树，这里不是，所以现在就快去吧！";
	end
	
	local nRes, szKind, nNum = self:IsTreeCountOk(pPlayer);
	if nRes == 0 then
		if szKind == "TOTAL" then
			return 0, string.format("我已经种了%d棵树了，不需要再种了，还是给他人留点地方吧。", nNum);
		else
			return 0, string.format("我今天已经种了%d棵树了，还是休息下，明天再说吧。", nNum);
		end
	end
	
	local tbNpcList = KNpc.GetAroundNpcList(pPlayer, 10);
	for _, pNpc in ipairs(tbNpcList) do
		if pNpc.nKind == 3 then
			return 0, "在这种会把<color=green>".. pNpc.szName.."<color>给挡住了，还是挪个地方吧。";
		end
	end
	
	local nIsPlanting = pPlayer.GetTask(self.TASKGID, self.TASK_TREE_IS_PLANTING);
	if nIsPlanting == 0 then
		return 1;
	end
	
	local nCurrTime = GetTime();
	local nLastPlantTime = pPlayer.GetTask(self.TASKGID, self.TASK_LAST_PLANT_TIME);
	
	-- nDelta = 需要等待时间 - 已经等待的时间
	local nDelta = self.INDEX_BIG_TREE * self.DIE_TIME - (nCurrTime - nLastPlantTime);
	if nDelta > 0 then
		local szMsg = "啊，你已有树正在种植中或因为你离开了树，导致树枯死掉了。\n\n<color=yellow>种下一棵树的剩余时间：".. Lib:TimeDesc(nDelta) .."<color>";
		return 0, szMsg;
	else
		self:SetTreePlantingState(pPlayer.nId, 0);
		return 1;
	end
end

-- 可否浇水
-- return 1 or 0
function tbZhiShu09:CanIrrigate(pPlayer, pNpc)
	local tbTreeData = pNpc.GetTempTable("Npc").tbPlantTree09;
	local nTreeIndex = tbTreeData.nTreeIndex;
	
	if not self:FindJug(pPlayer) then
		return 0, "哎呀，忘了把水壶带身上了。";
	end
	
	if self:GetWaterTimes(pPlayer) <= 0 then
		return 0, "水壶中没水了，还是去找木良把水灌满吧。";
	end
	
	if nTreeIndex == self.INDEX_BIG_TREE then -- 大树不用再浇水啦
		return 0;
	end
	
	local nPlayerId = tbTreeData.nPlayerId; -- 只能浇自己那棵树
	if nPlayerId ~= pPlayer.nId then
		return 0;
	end
	
	local nCurrTime = GetTime();
	local nLastIrrigateTime = pPlayer.GetTask(self.TASKGID, self.TASK_LAST_IRRIGATE_TIME);
	
	local nInterval = nCurrTime - nLastIrrigateTime;
	if nInterval < self.WATER_INTERVAL then
		local szMsg = string.format("浇水太勤也不好，会把树苗淹死的！您再等<color=green>%d秒<color>就可以再浇水了。", self.WATER_INTERVAL - nInterval);
		return 0, szMsg;
	end
	
	return 1;
end

-- 树上有没有种子可以采集
function tbZhiShu09:HasSeed(pNpc)
	local nSeedCollectNum = pNpc.GetTempTable("Npc").tbPlantTree09.nSeedCollectNum;
	if nSeedCollectNum > 0 then
		return 0;
	else
		return 1;
	end
end


-- 是否可以采集果实
function tbZhiShu09:CanGatherSeed(pPlayer, pNpc)
	local nCurrTime = GetTime();
	local nBirthday = pNpc.GetTempTable("Npc").tbPlantTree09.nBirthday;
	local nInterval = nCurrTime - nBirthday;
	if nInterval < self.COLLECT_INTERVAL then
		local szMsg = string.format("哎呀，果实好像还没成熟，再等%d秒看看。", self.COLLECT_INTERVAL - nInterval);
		return 0, szMsg;
	end
	
	if pPlayer.nId ~= pNpc.GetTempTable("Npc").tbPlantTree09.nPlayerId then
		return 0;
	end
	
	if self:HasSeed(pNpc) == 0 then
		return 0;
	end
	
	if pPlayer.CountFreeBagCell() < 1 then
		return 0, "背包空间不足";
	end
	
	return 1;
end

-- 采集果实
function tbZhiShu09:GatherSeed(pPlayer, pNpc)
	pPlayer.AddItem(unpack(self.tbNewSeed));
	pNpc.GetTempTable("Npc").tbPlantTree09.nSeedCollectNum = 1;
	return "呵呵，摘到一个这么漂亮的果实，快取出树种交给伐木小屋老板木良换取奖品吧。";
end

-- 是否可以给玩家种子
function tbZhiShu09:CanGiveSeed(pPlayer)
	if pPlayer.nLevel < 60 then
		return 0, "你等级不够60级，恐怕无法好好培育树苗，60后再来吧！";
	end
	
	if self:FindJug(pPlayer) then 
		return 0,"你身上已经有洒水壶了。";
	end
	
	local tbFind = pPlayer.FindItemInRepository(unpack(self.tbJug));
	if tbFind and #tbFind > 0 then
		return 0,"你身上已经有洒水壶了。";
	end	
	
	if pPlayer.CountFreeBagCell() < 1 then
		return 0, "背包空间不足。";
	end
	
	return 1;
end

-- 给玩家水壶
function tbZhiShu09:GiveSeed(pPlayer)
	local pJug = pPlayer.AddItem(unpack(self.tbJug));
	if pJug then
		pJug.SetGenInfo(1,self.JUG_VOLUMN);
		pJug.Sync();
		Dialog:SendBlackBoardMsg(pPlayer, "你获得了洒水壶");
	end
end

-- 玩家上交种子
-- tbItem 为玩家上交的物品列表
function tbZhiShu09:HandupSeed(pPlayer, tbItem)
	local nHandupSeedTotal = pPlayer.GetTask(self.TASKGID, self.TASK_HAND_UP_SEED_TOTAL);
	if nHandupSeedTotal >= self.MAX_TREE_COUNT_TOTAL then
		return 0, "你已经给了我" .. tostring(self.MAX_TREE_COUNT_TOTAL) .. "个果子啦，不用再给了。";
	end
	
	local tbSeed = {};
	for _, pItem in ipairs(tbItem) do
		if pItem[1].Equal(unpack(self.tbNewSeed)) == 1 then
			table.insert(tbSeed, pItem[1]);
		end
	end
	
	if pPlayer.CountFreeBagCell() < #tbSeed then
		return 0, "背包空间不足。";
	end
	
	local nCount = #tbSeed;
	if nCount > self.MAX_TREE_COUNT_TOTAL - nHandupSeedTotal then
		nCount = self.MAX_TREE_COUNT_TOTAL - nHandupSeedTotal;
	end
	
	local nActualCount = 0;
	for i = 1, nCount do
		local pItem =pPlayer.AddItem(unpack(self.tbBox));
		if pItem then
			table.remove(tbSeed).Delete(pPlayer);
			nActualCount = nActualCount + 1;
		end
	end
	
	pPlayer.SetTask(self.TASKGID, self.TASK_HAND_UP_SEED_TOTAL, nHandupSeedTotal + nActualCount);
	return 1;
end

-- 开始浇水
function tbZhiShu09:IrrigateBegin(pPlayer, pNpc)
	self:DecreWaterTimes(pPlayer);
	
	local tbEvent = 
	{
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SITE,
		Player.ProcessBreakEvent.emEVENT_USEITEM,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_DROPITEM,
		Player.ProcessBreakEvent.emEVENT_SENDMAIL,
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_DEATH,
	}
	
	GeneralProcess:StartProcess("浇水中...", self.WATER_TIME * Env.GAME_FPS, 
			{self.IrrigateFinished, SpecialEvent.ZhiShu2009, pPlayer.nId, pNpc.dwId}, nil, tbEvent);
end

-- 浇水结束
function tbZhiShu09:IrrigateFinished(nPlayerId, dwNpcId)
	local pNpc = KNpc.GetById(dwNpcId);
	if not pNpc then -- 树枯死了
		return;
	end
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return 0;
	end
	pPlayer.SetTask(self.TASKGID, self.TASK_LAST_IRRIGATE_TIME, GetTime());
	local tbTreeData = pNpc.GetTempTable("Npc").tbPlantTree09;
	local nTreeIndex = tbTreeData.nTreeIndex;
	
	if tbTreeData.nTimerId_Water_Again then
		Timer:Close(tbTreeData.nTimerId_Water_Again);
	end
	if tbTreeData.nTimerId_Die then
		Timer:Close(tbTreeData.nTimerId_Die);
	end
	if tbTreeData.nTimerId_Alert then
		Timer:Close(tbTreeData.nTimerId_Alert);
	end
	if tbTreeData.nTimerId_Give_Xp then
		Timer:Close(tbTreeData.nTimerId_Give_Xp);
	end
	
	if nTreeIndex < self.INDEX_BIG_TREE then -- 树要长大了
		self.tbListWaterPlayList[nPlayerId] = 1;
		Dialog:SendBlackBoardMsg(pPlayer, "您种树浇水成功了！");
		local nMapId, x, y = pNpc.GetWorldPos();
		self:PlantTree(pPlayer, nTreeIndex + 1, nMapId, x, y);
		pNpc.Delete();
	end
end

function tbZhiShu09:HasReachXpLimit(pPlayer)
	local nToday = tonumber(GetLocalDate("%Y%m%d")); 
	local nLastGiveXpDay = pPlayer.GetTask(self.TASKGID, self.TASK_LAST_GIVE_XP_DAY);
	
	if nToday > nLastGiveXpDay then
		pPlayer.SetTask(self.TASKGID, self.TASK_XP_COUNT_TODAY, 0);
	end
	
	local nXpToday = pPlayer.GetTask(self.TASKGID, self.TASK_XP_COUNT_TODAY);
	if nXpToday >= pPlayer.GetBaseAwardExp()*72 then -- 每天获取经验上限72分钟
		return 1;
	else
		return 0;
	end
end

-- 种下第一棵树
-- pItem：种子
function tbZhiShu09:Plant1stTree(pPlayer, dwItemId)
	local nRes = self:CanPlantTree(pPlayer);
	if nRes == 0 then 
		return;
	end
	
	local nMapId, x, y = pPlayer.GetWorldPos();
	local _, pNpc = self:PlantTree(pPlayer,1, nMapId, x, y, nil);
	if pNpc then
		local pItem = KItem.GetObjById(dwItemId);
		if pItem then
			pItem.Delete(pPlayer);
		end
	end
end

-- 种下一棵树
-- return pNpc
function tbZhiShu09:PlantTree(pPlayer, nTreeIndex, nMapId, x, y)
	local nPlayerId = pPlayer.nId;
	local szPlayerName = pPlayer.szName;
	local nNpcId = self.tbIndex2Data[nTreeIndex][1];
	assert(nNpcId);
	
	local pNpc = KNpc.Add2(nNpcId, 1, -1, nMapId, x, y)
	
	if not pNpc then
		self:SetTreePlantingState(nPlayerId, 0);
		return 0;
	end
	
	if nTreeIndex == 1 then
		self:SetTreePlantingState(pPlayer.nId, 1);
		Dialog:SendBlackBoardMsg(pPlayer, "树种发芽了，赶快浇水呀，不然会枯死的！");
	elseif nTreeIndex >= 2 and nTreeIndex < self.INDEX_BIG_TREE then
		Dialog:SendBlackBoardMsg(pPlayer, "你种的树苗又长大了");
	else
		Dialog:SendBlackBoardMsg(pPlayer, "啊，您的树苗终于开始结果了，现在等着丰收吧。");
		self:TreeIsBigNow(pPlayer);
	end
	
	local tbTemp = pNpc.GetTempTable("Npc");
	
	local nTimerId_Die, nTimerId_Alert, nTimerId_Water_Again, nTimerId_Give_Xp;
	
	if nTreeIndex < self.INDEX_BIG_TREE then
		nTimerId_Water_Again = Timer:Register(self.WATER_INTERVAL * Env.GAME_FPS, self.CanWaterAgain, self, nPlayerId, pNpc.dwId);
		nTimerId_Alert = Timer:Register((self.DIE_TIME - self.ALERT_TIME) * Env.GAME_FPS, self.TreeDieAlert, self, nPlayerId, pNpc.dwId);
		nTimerId_Die = Timer:Register(self.DIE_TIME * Env.GAME_FPS, self.TreeDie, self, nPlayerId, pNpc.dwId);
		
		if nTreeIndex > 1 then
			nTimerId_Give_Xp = Timer:Register(self.GIVE_XP_INTERVAL * Env.GAME_FPS, self.GiveXp, self, nPlayerId, pNpc.dwId);
		end
	else
		nTimerId_Water_Again = nil;
		nTimerId_Alert = nil;
		nTimerId_Die = Timer:Register(self.BIG_TREE_LIFE * Env.GAME_FPS, self.TreeDie, self, nPlayerId, pNpc.dwId, 1);
		nTimerId_Give_Xp = nil;
	end
	
	tbTemp.tbPlantTree09 = {
		["nPlayerId"] = nPlayerId,
		["nTreeIndex"]  = nTreeIndex; -- 对应 tbZhiShu09.tbIndex2Data 的索引
		["nTimerId_Water_Again"] = nTimerId_Water_Again;
		["nTimerId_Die"] = nTimerId_Die;
		["nTimerId_Alert"] = nTimerId_Alert;
		["nTimerId_Give_Xp"] = nTimerId_Give_Xp;
		["nBirthday"] = GetTime();
		["nSeedCollectNum"] = 0; -- 玩家从这棵树上采集了多少种子
		};
		
	pNpc.szName = szPlayerName .. "的" .. pNpc.szName;
	return 0, pNpc;
end
function tbZhiShu09:_RpGetPlayerList(pPlayer, pNpc)
	local nTeamId = pPlayer.nTeamId;
	local tbValidPlayer = {};  -- 在树周围的同组玩家
	local nDistance = 100;
	local nTreeIndex = pNpc.GetTempTable("Npc").tbPlantTree09.nTreeIndex;
	local nXp = self.tbIndex2Data[nTreeIndex][2];
	local tbPlayerList = KNpc.GetAroundPlayerList(pNpc.dwId, nDistance);
	if tbPlayerList then
		for _, pPlayerNearby in ipairs(tbPlayerList) do
			if pPlayerNearby.nId == pPlayer.nId then
				table.insert(tbValidPlayer, pPlayerNearby);
			elseif nTeamId > 0 then
				local nIsPlanting = pPlayerNearby.GetTask(self.TASKGID, self.TASK_TREE_IS_PLANTING);
				if pPlayerNearby.nTeamId == nTeamId and nIsPlanting == 1 and self.tbListWaterPlayList[pPlayerNearby.nId] then
					table.insert(tbValidPlayer, pPlayerNearby);
				end
			end
		end
	end
	return tbValidPlayer;
end

-- 给玩家经验
function tbZhiShu09:GiveXp(nPlayerId, dwNpcId)
	local pNpc = KNpc.GetById(dwNpcId);
	if not pNpc then
		return 0;
	end
	
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return;
	end
	local tbValidPlayer = self:_RpGetPlayerList(pPlayer, pNpc);
	local nXp = pPlayer.GetBaseAwardExp()/12;
--	local nToday = tonumber(os.date("%Y%m%d"));
	local nToday = tonumber(GetLocalDate("%Y%m%d"));
	for _, pMPlayer in ipairs(tbValidPlayer) do
		if self:HasReachXpLimit(pMPlayer) == 0 then
			pMPlayer.AddExp(#tbValidPlayer * nXp);
			local nXpToday = pMPlayer.GetTask(self.TASKGID, self.TASK_XP_COUNT_TODAY);
			pMPlayer.SetTask(self.TASKGID, self.TASK_XP_COUNT_TODAY, nXpToday + #tbValidPlayer * nXp);
			pMPlayer.SetTask(self.TASKGID, self.TASK_LAST_GIVE_XP_DAY, nToday);
		end
	end
end


-- 提醒可以浇水了
function tbZhiShu09:CanWaterAgain(nPlayerId, dwNpcId)
	local pNpc = KNpc.GetById(dwNpcId);
	if not pNpc then
		return 0;
	end
	
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer then
		Dialog:SendBlackBoardMsg(pPlayer, "您又可以给你的树苗浇水了。");
	end
	pNpc.GetTempTable("Npc").tbPlantTree09.nTimerId_Water_Again = nil;
	return 0;
end

-- 提醒快浇水
function tbZhiShu09:TreeDieAlert(nPlayerId, dwNpcId)
	local pNpc = KNpc.GetById(dwNpcId);
	if not pNpc then
		return 0;
	end
	
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer then
		Dialog:SendBlackBoardMsg(pPlayer, "您的树苗还有20秒就要枯死了，赶快浇水啊！！！");
	end
	pNpc.GetTempTable("Npc").tbPlantTree09.nTimerId_Alert = nil;
	return 0;
end

-- 枯死了
function tbZhiShu09:TreeDie(nPlayerId, dwNpcId, nState)
	local pNpc = KNpc.GetById(dwNpcId);
	if not pNpc then
		return 0;
	end
	
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not nState and pPlayer then
		Dialog:SendBlackBoardMsg(pPlayer, "真遗憾啊，您辛苦种的树枯死了，下次要细心点呀！！");
	end
	self:SetTreePlantingState(nPlayerId, 0);
	
	local nTimerId_Give_Xp = pNpc.GetTempTable("Npc").tbPlantTree09.nTimerId_Give_Xp;
	if nTimerId_Give_Xp then
		Timer:Close(nTimerId_Give_Xp);
	end
	self.tbListWaterPlayList[nPlayerId] = nil
	pNpc.Delete();
	return 0;
end

-- 是否大树
-- return 0, 1
function tbZhiShu09:IsBigTree(pNpc)
	local nTreeIndex = pNpc.GetTempTable("Npc").tbPlantTree09.nTreeIndex;
	if nTreeIndex == self.INDEX_BIG_TREE then
		return 1;
	else
		return 0;
	end
end

-- 设置植树状态
function tbZhiShu09:SetTreePlantingState(nPlayerId, nState)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer then
		pPlayer.SetTask(self.TASKGID, self.TASK_TREE_IS_PLANTING, nState);
		if nState == 1 then
			pPlayer.SetTask(self.TASKGID, self.TASK_LAST_PLANT_TIME, GetTime());
		end
	end
end

-- 长成大树后的操作
function tbZhiShu09:TreeIsBigNow(pPlayer)
	local nTreeCountTotal = pPlayer.GetTask(self.TASKGID, self.TASK_TREE_COUNT_TOTAL);
	pPlayer.SetTask(self.TASKGID, self.TASK_TREE_COUNT_TOTAL, nTreeCountTotal + 1);
	
	local nToday = tonumber(GetLocalDate("%Y%m%d"));
	local nLastPlantDay = pPlayer.GetTask(self.TASKGID, self.TASK_LAST_PLANT_DAY);
	local nTreeCountToday = pPlayer.GetTask(self.TASKGID, self.TASK_TREE_COUNT_TODAY);
	
	if nToday > nLastPlantDay then
		pPlayer.SetTask(self.TASKGID, self.TASK_TREE_COUNT_TODAY, 1);
	else
		pPlayer.SetTask(self.TASKGID, self.TASK_TREE_COUNT_TODAY, nTreeCountToday + 1);
	end
	
	pPlayer.SetTask(self.TASKGID, self.TASK_LAST_PLANT_DAY, nToday);
	self:SetTreePlantingState(pPlayer.nId, 0); 
end

function tbZhiShu09:GetOwnerId(pNpc)
	return pNpc.GetTempTable("Npc").tbPlantTree09.nPlayerId;
end

function tbZhiShu09:ClearTask(pPlayer)
	for i = 56, 63 do
		pPlayer.SetTask(tbZhiShu09.TASKGID, i, 0);
	end
end

-- ?pl DoScript("\\script\\event\\jieri\\200903_zhishujie\\logic.lua")