-- 2009 ֲ����
-- maiyajin

local tbZhiShu09 = {};
SpecialEvent.ZhiShu2009 = tbZhiShu09;

tbZhiShu09.TASKGID = 2027;
tbZhiShu09.TASK_LAST_IRRIGATE_TIME = 56; -- ���ˮʱ��
tbZhiShu09.TASK_LAST_PLANT_TIME = 57; -- ���ֲ����ʼʱ��
tbZhiShu09.TASK_LAST_PLANT_DAY = 58; -- ���ɹ�ֲ���Ǽ���
tbZhiShu09.TASK_TREE_COUNT_TODAY = 59; -- ����ɹ�ֲ����
tbZhiShu09.TASK_TREE_COUNT_TOTAL = 60; -- �ɹ�ֲ������
tbZhiShu09.TASK_TREE_IS_PLANTING = 61; -- �Ƿ�����ֲ�� 1:���������� 0:û��
tbZhiShu09.TASK_LASK_GIVE_SEED_TIME = 62; -- ����ľ����������ӵ�ʱ��
tbZhiShu09.TASK_XP_COUNT_TODAY = 63; -- �����õľ�����
tbZhiShu09.TASK_HAND_UP_SEED_TOTAL = 64; -- �Ͻ���������
tbZhiShu09.TASK_LAST_GIVE_XP_DAY = 65; -- ���һ�θ�����������

tbZhiShu09.WATER_TIME = 5; -- ��һ����ʹ�õ�ʱ��
tbZhiShu09.GROW_TIME = 5; -- ��ˮ�ɹ������ó��ɴ���
tbZhiShu09.ALERT_TIME = 20; -- ��ľ����ǰ ALERT_TIME ����ʾ
tbZhiShu09.DIE_TIME = 2 * 60; -- ��ľ����ò���ˮ������
tbZhiShu09.WATER_INTERVAL = 60; -- ��ˮ��Сʱ����
tbZhiShu09.COLLECT_INTERVAL = 2 * 60; -- �ɼ�ʱ����
tbZhiShu09.MAX_TREE_COUNT_TODAY = 2; -- һ���������ּ�����
tbZhiShu09.MAX_TREE_COUNT_TOTAL = 42; -- �ܹ������ּ�����
tbZhiShu09.JUG_VOLUMN = 10; -- ˮ����ˮ��
tbZhiShu09.GIVE_SEED_INTERVAL = 30 * 60; -- ��ȡ���ӵ�ʱ����
tbZhiShu09.GIVE_XP_INTERVAL = 5; -- ������ʱ����
tbZhiShu09.BIG_TREE_LIFE = 1 * 60 * 20; -- ����������

tbZhiShu09.tbNewSeed = {18,1,297,1}; -- ����������
tbZhiShu09.tbOldSeed = {18,1,295,1}; -- ��������
tbZhiShu09.tbJug = {18,1,296,1}; -- ˮ��
tbZhiShu09.tbBox = {18,1,298,1}; -- ī�̺���
tbZhiShu09.tbListWaterPlayList = {};	--��¼��ˮ����

tbZhiShu09.tbIndex2Data = {
		--{ģ��id, ����}
	[1] = {3634, 10}, -- ����С����
	[2] = {3635, 20}, -- �δ�����
	[3] = {3636, 30}, -- ����С��
	[4] = {3637, 40}, -- ��׳С��
	[5] = {3638, 50}, -- ������ľ
	[6] = {3639,  0}, -- �ô�һ����
};

tbZhiShu09.INDEX_BIG_TREE = #tbZhiShu09.tbIndex2Data; -- �����ı��

-- �������ϵ�ˮ��
-- return: pItem or nil
function tbZhiShu09:FindJug(pPlayer)
	local tbFind = pPlayer.FindItemInBags(unpack(self.tbJug));
	if tbFind[1] then
		return tbFind[1].pItem;
	end
	return nil;
end

-- ���ػ����Խ�����ˮ
function tbZhiShu09:GetWaterTimes(pPlayer)
	local pJug = self:FindJug(pPlayer);
	if pJug then
		return pJug.GetGenInfo(1);
	else
		return 0;
	end
end

-- ˮ����ˮ����1
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

-- װ��ˮ��
--no_msg �� nil �Ļ��������Ϣ
function tbZhiShu09:FillJug(pPlayer, no_msg)
	local pJug = self:FindJug(pPlayer);
	if not pJug then
		return 0, "���ˮ���أ�";
	end
	
	pJug.SetGenInfo(1,self.JUG_VOLUMN);
	pJug.Sync();
	
	if not no_msg then
		Dialog:SendBlackBoardMsg(pPlayer, "�����ˮ����ע����ˮ����ȥ�����ɣ�");
	end
end

-- �ж����ֲ�������Ƿ����Ҫ��
function tbZhiShu09:IsTreeCountOk(pPlayer)
	-- ֲ������
	local nTreeCountTotal = pPlayer.GetTask(self.TASKGID, self.TASK_TREE_COUNT_TOTAL);
	if nTreeCountTotal >= self.MAX_TREE_COUNT_TOTAL then
		return 0, "TOTAL", nTreeCountTotal;
	end
	
	local nToday = tonumber(GetLocalDate("%Y%m%d"));
	local nLastPlantDay = pPlayer.GetTask(self.TASKGID, self.TASK_LAST_PLANT_DAY);
	local nTreeCountToday = pPlayer.GetTask(self.TASKGID, self.TASK_TREE_COUNT_TODAY);
	
	-- ����ֲ����(ע�⣺������������ֲ���ĺ���һ��ʱ����Ҫ�жϣ���һ���Ļ���ʾ�����Ѿ���ȥ��)
	if nToday == nLastPlantDay and nTreeCountToday >= self.MAX_TREE_COUNT_TODAY then -- �����������ڻ����1���·�����Ч
		return 0, "TODAY", nTreeCountToday;
	end
	
	return 1;
end

-- �ɷ�����
-- return 0, 1
function tbZhiShu09:CanPlantTree(pPlayer)
	local nMapId, x, y = pPlayer.GetWorldPos();
	if nMapId > 8 then
		return 0, "ֻ�������ִ�ſ������������ﲻ�ǣ��������ھͿ�ȥ�ɣ�";
	end
	
	local nRes, szKind, nNum = self:IsTreeCountOk(pPlayer);
	if nRes == 0 then
		if szKind == "TOTAL" then
			return 0, string.format("���Ѿ�����%d�����ˣ�����Ҫ�����ˣ����Ǹ���������ط��ɡ�", nNum);
		else
			return 0, string.format("�ҽ����Ѿ�����%d�����ˣ�������Ϣ�£�������˵�ɡ�", nNum);
		end
	end
	
	local tbNpcList = KNpc.GetAroundNpcList(pPlayer, 10);
	for _, pNpc in ipairs(tbNpcList) do
		if pNpc.nKind == 3 then
			return 0, "�����ֻ��<color=green>".. pNpc.szName.."<color>����ס�ˣ�����Ų���ط��ɡ�";
		end
	end
	
	local nIsPlanting = pPlayer.GetTask(self.TASKGID, self.TASK_TREE_IS_PLANTING);
	if nIsPlanting == 0 then
		return 1;
	end
	
	local nCurrTime = GetTime();
	local nLastPlantTime = pPlayer.GetTask(self.TASKGID, self.TASK_LAST_PLANT_TIME);
	
	-- nDelta = ��Ҫ�ȴ�ʱ�� - �Ѿ��ȴ���ʱ��
	local nDelta = self.INDEX_BIG_TREE * self.DIE_TIME - (nCurrTime - nLastPlantTime);
	if nDelta > 0 then
		local szMsg = "������������������ֲ�л���Ϊ���뿪�������������������ˡ�\n\n<color=yellow>����һ������ʣ��ʱ�䣺".. Lib:TimeDesc(nDelta) .."<color>";
		return 0, szMsg;
	else
		self:SetTreePlantingState(pPlayer.nId, 0);
		return 1;
	end
end

-- �ɷ�ˮ
-- return 1 or 0
function tbZhiShu09:CanIrrigate(pPlayer, pNpc)
	local tbTreeData = pNpc.GetTempTable("Npc").tbPlantTree09;
	local nTreeIndex = tbTreeData.nTreeIndex;
	
	if not self:FindJug(pPlayer) then
		return 0, "��ѽ�����˰�ˮ���������ˡ�";
	end
	
	if self:GetWaterTimes(pPlayer) <= 0 then
		return 0, "ˮ����ûˮ�ˣ�����ȥ��ľ����ˮ�����ɡ�";
	end
	
	if nTreeIndex == self.INDEX_BIG_TREE then -- ���������ٽ�ˮ��
		return 0;
	end
	
	local nPlayerId = tbTreeData.nPlayerId; -- ֻ�ܽ��Լ��ǿ���
	if nPlayerId ~= pPlayer.nId then
		return 0;
	end
	
	local nCurrTime = GetTime();
	local nLastIrrigateTime = pPlayer.GetTask(self.TASKGID, self.TASK_LAST_IRRIGATE_TIME);
	
	local nInterval = nCurrTime - nLastIrrigateTime;
	if nInterval < self.WATER_INTERVAL then
		local szMsg = string.format("��ˮ̫��Ҳ���ã�������������ģ����ٵ�<color=green>%d��<color>�Ϳ����ٽ�ˮ�ˡ�", self.WATER_INTERVAL - nInterval);
		return 0, szMsg;
	end
	
	return 1;
end

-- ������û�����ӿ��Բɼ�
function tbZhiShu09:HasSeed(pNpc)
	local nSeedCollectNum = pNpc.GetTempTable("Npc").tbPlantTree09.nSeedCollectNum;
	if nSeedCollectNum > 0 then
		return 0;
	else
		return 1;
	end
end


-- �Ƿ���Բɼ���ʵ
function tbZhiShu09:CanGatherSeed(pPlayer, pNpc)
	local nCurrTime = GetTime();
	local nBirthday = pNpc.GetTempTable("Npc").tbPlantTree09.nBirthday;
	local nInterval = nCurrTime - nBirthday;
	if nInterval < self.COLLECT_INTERVAL then
		local szMsg = string.format("��ѽ����ʵ����û���죬�ٵ�%d�뿴����", self.COLLECT_INTERVAL - nInterval);
		return 0, szMsg;
	end
	
	if pPlayer.nId ~= pNpc.GetTempTable("Npc").tbPlantTree09.nPlayerId then
		return 0;
	end
	
	if self:HasSeed(pNpc) == 0 then
		return 0;
	end
	
	if pPlayer.CountFreeBagCell() < 1 then
		return 0, "�����ռ䲻��";
	end
	
	return 1;
end

-- �ɼ���ʵ
function tbZhiShu09:GatherSeed(pPlayer, pNpc)
	pPlayer.AddItem(unpack(self.tbNewSeed));
	pNpc.GetTempTable("Npc").tbPlantTree09.nSeedCollectNum = 1;
	return "�Ǻǣ�ժ��һ����ôƯ���Ĺ�ʵ����ȡ�����ֽ�����ľС���ϰ�ľ����ȡ��Ʒ�ɡ�";
end

-- �Ƿ���Ը��������
function tbZhiShu09:CanGiveSeed(pPlayer)
	if pPlayer.nLevel < 60 then
		return 0, "��ȼ�����60���������޷��ú��������磬60�������ɣ�";
	end
	
	if self:FindJug(pPlayer) then 
		return 0,"�������Ѿ�����ˮ���ˡ�";
	end
	
	local tbFind = pPlayer.FindItemInRepository(unpack(self.tbJug));
	if tbFind and #tbFind > 0 then
		return 0,"�������Ѿ�����ˮ���ˡ�";
	end	
	
	if pPlayer.CountFreeBagCell() < 1 then
		return 0, "�����ռ䲻�㡣";
	end
	
	return 1;
end

-- �����ˮ��
function tbZhiShu09:GiveSeed(pPlayer)
	local pJug = pPlayer.AddItem(unpack(self.tbJug));
	if pJug then
		pJug.SetGenInfo(1,self.JUG_VOLUMN);
		pJug.Sync();
		Dialog:SendBlackBoardMsg(pPlayer, "��������ˮ��");
	end
end

-- ����Ͻ�����
-- tbItem Ϊ����Ͻ�����Ʒ�б�
function tbZhiShu09:HandupSeed(pPlayer, tbItem)
	local nHandupSeedTotal = pPlayer.GetTask(self.TASKGID, self.TASK_HAND_UP_SEED_TOTAL);
	if nHandupSeedTotal >= self.MAX_TREE_COUNT_TOTAL then
		return 0, "���Ѿ�������" .. tostring(self.MAX_TREE_COUNT_TOTAL) .. "���������������ٸ��ˡ�";
	end
	
	local tbSeed = {};
	for _, pItem in ipairs(tbItem) do
		if pItem[1].Equal(unpack(self.tbNewSeed)) == 1 then
			table.insert(tbSeed, pItem[1]);
		end
	end
	
	if pPlayer.CountFreeBagCell() < #tbSeed then
		return 0, "�����ռ䲻�㡣";
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

-- ��ʼ��ˮ
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
	
	GeneralProcess:StartProcess("��ˮ��...", self.WATER_TIME * Env.GAME_FPS, 
			{self.IrrigateFinished, SpecialEvent.ZhiShu2009, pPlayer.nId, pNpc.dwId}, nil, tbEvent);
end

-- ��ˮ����
function tbZhiShu09:IrrigateFinished(nPlayerId, dwNpcId)
	local pNpc = KNpc.GetById(dwNpcId);
	if not pNpc then -- ��������
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
	
	if nTreeIndex < self.INDEX_BIG_TREE then -- ��Ҫ������
		self.tbListWaterPlayList[nPlayerId] = 1;
		Dialog:SendBlackBoardMsg(pPlayer, "��������ˮ�ɹ��ˣ�");
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
	if nXpToday >= pPlayer.GetBaseAwardExp()*72 then -- ÿ���ȡ��������72����
		return 1;
	else
		return 0;
	end
end

-- ���µ�һ����
-- pItem������
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

-- ����һ����
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
		Dialog:SendBlackBoardMsg(pPlayer, "���ַ�ѿ�ˣ��Ͽ콽ˮѽ����Ȼ������ģ�");
	elseif nTreeIndex >= 2 and nTreeIndex < self.INDEX_BIG_TREE then
		Dialog:SendBlackBoardMsg(pPlayer, "���ֵ������ֳ�����");
	else
		Dialog:SendBlackBoardMsg(pPlayer, "���������������ڿ�ʼ����ˣ����ڵ��ŷ��հɡ�");
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
		["nTreeIndex"]  = nTreeIndex; -- ��Ӧ tbZhiShu09.tbIndex2Data ������
		["nTimerId_Water_Again"] = nTimerId_Water_Again;
		["nTimerId_Die"] = nTimerId_Die;
		["nTimerId_Alert"] = nTimerId_Alert;
		["nTimerId_Give_Xp"] = nTimerId_Give_Xp;
		["nBirthday"] = GetTime();
		["nSeedCollectNum"] = 0; -- ��Ҵ�������ϲɼ��˶�������
		};
		
	pNpc.szName = szPlayerName .. "��" .. pNpc.szName;
	return 0, pNpc;
end
function tbZhiShu09:_RpGetPlayerList(pPlayer, pNpc)
	local nTeamId = pPlayer.nTeamId;
	local tbValidPlayer = {};  -- ������Χ��ͬ�����
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

-- ����Ҿ���
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


-- ���ѿ��Խ�ˮ��
function tbZhiShu09:CanWaterAgain(nPlayerId, dwNpcId)
	local pNpc = KNpc.GetById(dwNpcId);
	if not pNpc then
		return 0;
	end
	
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer then
		Dialog:SendBlackBoardMsg(pPlayer, "���ֿ��Ը�������罽ˮ�ˡ�");
	end
	pNpc.GetTempTable("Npc").tbPlantTree09.nTimerId_Water_Again = nil;
	return 0;
end

-- ���ѿ콽ˮ
function tbZhiShu09:TreeDieAlert(nPlayerId, dwNpcId)
	local pNpc = KNpc.GetById(dwNpcId);
	if not pNpc then
		return 0;
	end
	
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer then
		Dialog:SendBlackBoardMsg(pPlayer, "�������绹��20���Ҫ�����ˣ��Ͽ콽ˮ��������");
	end
	pNpc.GetTempTable("Npc").tbPlantTree09.nTimerId_Alert = nil;
	return 0;
end

-- ������
function tbZhiShu09:TreeDie(nPlayerId, dwNpcId, nState)
	local pNpc = KNpc.GetById(dwNpcId);
	if not pNpc then
		return 0;
	end
	
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not nState and pPlayer then
		Dialog:SendBlackBoardMsg(pPlayer, "���ź������������ֵ��������ˣ��´�Ҫϸ�ĵ�ѽ����");
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

-- �Ƿ����
-- return 0, 1
function tbZhiShu09:IsBigTree(pNpc)
	local nTreeIndex = pNpc.GetTempTable("Npc").tbPlantTree09.nTreeIndex;
	if nTreeIndex == self.INDEX_BIG_TREE then
		return 1;
	else
		return 0;
	end
end

-- ����ֲ��״̬
function tbZhiShu09:SetTreePlantingState(nPlayerId, nState)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer then
		pPlayer.SetTask(self.TASKGID, self.TASK_TREE_IS_PLANTING, nState);
		if nState == 1 then
			pPlayer.SetTask(self.TASKGID, self.TASK_LAST_PLANT_TIME, GetTime());
		end
	end
end

-- ���ɴ�����Ĳ���
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