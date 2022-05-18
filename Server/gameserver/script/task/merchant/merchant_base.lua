Require("\\script\\task\\merchant\\merchant_define.lua")

function Merchant:GetTask(nTaskId)
	return me.GetTask(self.TASK_GOURP, nTaskId);
end

function Merchant:SetTask(nTaskId, nValue)
	self:_Debug("Đặt biến nhiệm vụ:",nTaskId, nValue)
	return me.SetTask(self.TASK_GOURP, nTaskId, nValue);
end

--完成一輪商會任務(完成觸發，未領獎勵之前)
function Merchant:FinishTask()
	Merchant:SetTask(Merchant.TASK_STEP_COUNT, 0);
	Merchant:SetTask(Merchant.TASK_TYPE, 0);
	Merchant:SetTask(Merchant.TASK_STEP, 0);
	Merchant:SetTask(Merchant.TASK_LEVEL, 0);
	Merchant:SetTask(Merchant.TASK_NOWTASK, 0);
	if Merchant:GetTask(Merchant.TASK_ACCEPT_WEEK_TIME) ~= tonumber(GetLocalDate("%W")) then
		Merchant:SetTask(Merchant.TASK_OPEN, 0);
	else
		Merchant:SetTask(Merchant.TASK_OPEN, 1);
	end
end

--完成一輪商會任務（獲得主線獎勵後）
function Merchant:FinishTaskOnAward()
	me.AddKinReputeEntry(80)	-- 由50改為80，by zhangjinpin@kingsoft
	
	-- 成就：完成一輪商會任務
	Achievement:FinishAchievement(me.nId, Achievement.SHANGHUI_40);
	
	local nFreeCount, tbFunExecute = SpecialEvent.ExtendAward:DoCheck("MerchantTask", me);
	SpecialEvent.ExtendAward:DoExecute(tbFunExecute);
end

--接主任務
function Merchant:DoAccept(tbTask, nTaskId, nReferId)
	if nTaskId == self.TASKDATA_ID and nReferId == self.TASKDATA_ID then
		self:SetTask(self.TASK_STEP_COUNT, 0);
		self:SetTask(self.TASK_RESET_NEWTYPE, 1);	--新類型轉換標志
		self:SetTask(self.TASK_ACCEPT_WEEK_TIME, tonumber(GetLocalDate("%W")));
		self:SetTask(self.TASK_ACCEPT_STEP_TIME, GetTime());
		self:SetTask(self.TASK_ACCEPT_TASK_TIME, 0);
		self:OnAccept();
	end
end

--接步驟
function Merchant:OnAccept()
	self:SetTask(self.TASK_STEP_COUNT, self:GetTask(self.TASK_STEP_COUNT ) + 1);
	self:GetRamdomEvent();
	self:LoadDate(self.TASKDATA_ID)
	
	-- 玩家參與商會任務計數加1
	Stats.Activity:AddCount(me, Stats.TASK_COUNT_SHANGHUI, 1);
end

function Merchant:GetRamdomEvent()
	local nLevelType = 50;
	local nStepType	 = 0;
	if me.nLevel >= 60 then
		nLevelType = 60;
	end
	local nStep = self:GetTask(self.TASK_STEP_COUNT)
	if math.mod(nStep,100) == 0 then
		nStepType = self.SETP_HARDEST;
	elseif math.mod(nStep,10) == 0 then
		nStepType = self.SETP_HARD;
	else
		nStepType = self.SETP_NORMAL;
	end
	local nEventType = 0;
	local nPreRate = Random(self.TaskFile[nStepType].MaxRate) + 1;
	local nSum = 0;
	for nTypeId, tbParam in pairs(self.TaskFile[nStepType].TypeClass) do
		nSum = nSum + tbParam.Rate;
		if nSum >= nPreRate then
			nEventType = nTypeId;
			break;
		end
	end
	local nNowTaskId = 0;
	local nCurStartSec = GetTime() - tonumber(KGblTask.SCGetDbTaskInt(DBTASD_SERVER_STARTTIME));
	local tbTaskList = {};
	local nMaxRate	 = 0;
	for nTaskId, tbParam in pairs(self.TaskFile[nStepType].TypeClass[nEventType][nLevelType].TaskEvent) do
		if nCurStartSec > tbParam.StartDay * 24 * 3600 then
			table.insert(tbTaskList, {nTaskId = nTaskId, nRate = tbParam.Rate});
			nMaxRate = nMaxRate + tbParam.Rate;
		end
	end
	
	
	nPreRate = Random(nMaxRate) + 1;
	nSum = 0;
	for _, tbParam in pairs(tbTaskList) do
		nSum = nSum + tbParam.nRate;
		if nSum >= nPreRate then
			nNowTaskId = tbParam.nTaskId;
			break;
		end
	end
	
	self:SetTask(self.TASK_TYPE, nEventType);
	self:SetTask(self.TASK_STEP, nStepType);
	self:SetTask(self.TASK_LEVEL, nLevelType);
	self:SetTask(self.TASK_NOWTASK, nNowTaskId);
	local nStepCount = self:GetTask(self.TASK_STEP_COUNT)
	local szBlackMsg = string.format("Nhiệm vụ %s là", nStepCount);
	if nStepCount == 1 then
		szBlackMsg = "Nhiệm vụ 1 là"
	end
	local tbTargetFile = self.TaskFile[nStepType].TypeClass[nEventType][nLevelType].TaskEvent[nNowTaskId];
	local szTaskName = tbTargetFile.TaskName;
	szBlackMsg = szBlackMsg .. szTaskName;
	TaskAct:Talk(szBlackMsg);
	if nStepCount % 10 == 9 then
		DeRobot:OnMerchantTask10();
	end
end

--GM測試使用接口
function Merchant:_GmUseTask(nEventType, nStepType, nNowTaskId)

	local nLevelType = 60;
	self:SetTask(self.TASK_TYPE, nEventType);
	self:SetTask(self.TASK_STEP, nStepType);
	self:SetTask(self.TASK_LEVEL, nLevelType);
	self:SetTask(self.TASK_NOWTASK, nNowTaskId);
	local nStepCount = self:GetTask(self.TASK_STEP_COUNT)
	local szBlackMsg = string.format("Nhiệm vụ %s là", nStepCount);
	if nStepCount == 1 then
		szBlackMsg = "Nhiệm vụ 1 là: "
	end
	local tbTargetFile = self.TaskFile[nStepType].TypeClass[nEventType][nLevelType].TaskEvent[nNowTaskId];
	local szTaskName = tbTargetFile.TaskName;
	szBlackMsg = szBlackMsg .. szTaskName;
	TaskAct:Talk(szBlackMsg);	
	self:LoadDate(self.TASKDATA_ID);
end

function Merchant:_Debug(...)
	--local szMss=""
	--for _, szMsg in pairs(arg) do
	--	szMss = szMss .. "\t"..szMsg
	--end
	--print(szMss);
end

function Merchant:ReSetWeekEvent()
	if self:GetTask(self.TASK_OPEN) == 1 then
		self:SetTask(self.TASK_OPEN, 0);
	end
end

function Merchant:RandomCallNpc(nStartFlag)
	--self:_Debug("開始召喚隨機npc")
	--for nId, nNpcId in pairs(self.NPCLIST) do
	--	local pNpc = KNpc.GetById(nNpcId);
	--	if pNpc then
	--		pNpc.Delete()
	--	end
	--end

	local nAINpcId = 3632;
	
	Npc:OnClearFreeAINpc(nAINpcId);	--清空
	Npc:OnClearFreeAINpc(2964);		--清空
	
	local tbChat = {
		"Ta có nhiều vật phẩm quý hiếm",
		"Ôi ~ Mệt thật ~",
		"Muốn mua vật quý hiếm theo ta đến ~",
	};
	local nMaxSec = 30 * 60 ;
	local nTime	 = GetTime();
	local nMin	 = tonumber(os.date("%M", nTime));
	local nSec	 = tonumber(os.date("%S", nTime));	
	if nStartFlag == 1 then

		 
		 if nMin > 30 then
			nMaxSec = (60 - nMin)*60 + (60 - nSec);
		 else
			nMaxSec = (30 - nMin)*60 + (60 - nSec);
		 end
		
	end
	
	for nId, tbGroup in pairs(self.NpcFile) do
		if #tbGroup > 0 then
			local nP = Random(#tbGroup) + 1;
			local nMapId = tbGroup[nP].nMapId;
			local nNpcId = tbGroup[nP].nNpcId;
			local nPosX	= tbGroup[nP].nPosX;
			local nPosY	= tbGroup[nP].nPosY;
			if SubWorldID2Idx(nMapId) > 0 then
				Npc:OnSetFreeAI(nMapId, nPosX*32, nPosY*32, nAINpcId, 3, 3, nMaxSec, 1000, nNpcId, 10, tbChat)
				self.tbTestUseList = self.tbTestUseList or {};		--方便測試尋找坐標
				self.tbTestUseList[nId] = {nMapId, nPosX, nPosY};	--方便測試尋找坐標
				Dbg:WriteLog("Merchant", "Gọi Thương Nhân Thần Bí ngẫu nhiên", os.date("%y-%m-%d %H:%M",nTime), nId);
			end
		end
	end
end

function Merchant:LoadNpcFile()
	self.NpcFile = {};			--隨機npc表
	local tbFile = Lib:LoadTabFile(self.FILE_PATH..self.FILE_RANDOM_NPC);
	if not tbFile then
		return
	end
	for i = 2, #tbFile do
		local nId 	=  tonumber(tbFile[i].RandomId) or 0;
		local nNpcId  	= tonumber(tbFile[i].NpcId) or 0;	
		local nMapId  	= tonumber(tbFile[i].MapId) or 0;
		local nPosX  	= tonumber(tbFile[i].PosX) or 0;
		local nPosY  = tonumber(tbFile[i].PosY) or 0;
		
		if self.NpcFile[nId] == nil then
			self.NpcFile[nId] = {};
		end
		local tbTemp = {
			nNpcId = nNpcId,
			nMapId	= nMapId,
			nPosX = nPosX,
			nPosY = nPosY,
		}
		table.insert(self.NpcFile[nId], tbTemp);
	end	
end

-- 殺宋金玩家，根據其頭銜得令牌
-- pPlayer: 嘗試給令牌這個玩家
-- nKilledPlayerId: 被殺死的玩家的Id
-- nKilledPlayerRank: 被殺死的玩家的頭銜
function Merchant:TryGiveToken_Songjin_PLayer(pPlayer, nKilledPlayerId, nKilledPlayerRank)
	local nPrevGetTokenTime = self.tbSongjin_Kill_Player_Time[nKilledPlayerId];
	if nPrevGetTokenTime and GetTime() - nPrevGetTokenTime < self.SONGJIN_KILL_PLAYER_INTERVAL then -- 拿令牌間隔5分鐘
		return;
	end
	
	local tbPlayerRank2KillIndex = {
			[9] = self.KILL_SONGJIN_DAJIANG_PLAYER,
			[7] = self.KILL_SONGJIN_FUJIANG_PLAYER,
			[5] = self.KILL_SONGJIN_TONGLING_PLAYER,
		};
	
	local nKillIndex = tbPlayerRank2KillIndex[nKilledPlayerRank];
	local nResult = self:TryGiveToken(pPlayer, nKillIndex);
	
	if nResult == 1 then
		self.tbSongjin_Kill_Player_Time[nKilledPlayerId] = GetTime();
	end
end

-- 殺宋金NPC得令牌
function Merchant:TryGiveToken_Songjin(pPlayer, nKilledNpcTemplateId)
	local tbTemplateId2KillIndex = {
		[2513] = self.KILL_SONGJIN_DAJIANG, [2519] = self.KILL_SONGJIN_DAJIANG, -- 大將 
		[2512] = self.KILL_SONGJIN_FUJIANG, [2518] = self.KILL_SONGJIN_FUJIANG, -- 副將 
		[2511] = self.KILL_SONGJIN_TONGLING, [2517] = self.KILL_SONGJIN_TONGLING, -- 統領
	};
	
	local nKillIndex = tbTemplateId2KillIndex[nKilledNpcTemplateId];
	Merchant:TryGiveToken(pPlayer, nKillIndex);
end

-- 殺白虎小怪得令牌
function Merchant:TryGiveToken_Baihu(pPlayer, nFloor)
	local tbFloor2LingPaiLevel = {[1] = self.KILL_BAIHUTANG_1, [2] = self.KILL_BAIHUTANG_2, [3] = self.KILL_BAIHUTANG_3};
	local nKillIndex = tbFloor2LingPaiLevel[nFloor];
	Merchant:TryGiveToken(pPlayer, nKillIndex);
end

function Merchant:TryGiveToken(pPlayer, nKillIndex)
	if not pPlayer then
		return;
	end
	
	if not nKillIndex then
		return;
	end
	
	if pPlayer.GetTask(self.TASK_GOURP, self.TASK_TYPE) == 0 then -- 沒接商會任務
		return;
	end
	
	local tbDrop = self.TASK_NPC_DROP[nKillIndex];
	if not tbDrop then
		return;
	end
	
	local tbData = self.TASK_ITEM_FIX[tbDrop.nLevel];
	local nItemNum = pPlayer.GetTask(self.TASK_GOURP, tbData.nTask);
	if nItemNum >= tbData.nMax then
		return;
	end
	
	if MathRandom(1, 100) <= tbDrop.nRate then
		if pPlayer.CountFreeBagCell() > 0 then
			pPlayer.AddItem(18, 1, 289, tbDrop.nLevel);
		end
		return 1;
	end
end

if MODULE_GAMESERVER then
	
Merchant:LoadNpcFile();
PlayerSchemeEvent:RegisterGlobalWeekEvent({Merchant.ReSetWeekEvent, Merchant});
ServerEvent:RegisterServerStartFunc(Merchant.RandomCallNpc, Merchant, 1);

end
