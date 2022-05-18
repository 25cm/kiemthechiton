Require("\\script\\task\\linktask\\linktask_head.lua");

-------------------------------------------------------------------------
 -- 目標庫
if (not Task.tbTargetLib) then
	Task.tbTargetLib	= {};
end;

-------------------------------------------------------------------------------
-- 獲取任務目標，主要用於目標定義
function Task:GetTarget(szTarget)
	local tbTarget	= self.tbTargetLib[szTarget];
	if (not tbTarget) then
		tbTarget	= {};
		self.tbTargetLib[szTarget]	= tbTarget;
	end;
	return tbTarget;
end;


-------------------------------------------------------------------------
-- 任務系統初始化，載入200個任務文件和600個子任務文件
function Task:OnInit()
	local nTaskCount	= 0;
	local nSubCount		= 0;
	self:LoadText();
	for i = 1, 600 do
		if (self:LoadTask(i)) then
			nTaskCount	= nTaskCount + 1;
		end
	end

	-- Warring:liuchang 如果有太多的話就會有字符串Id重復，目前底層是把字符HASH成一個Id
	if (MODULE_GAMESERVER) then
		for i = 1, 700 do
			if (self:LoadSub(i)) then
				nSubCount	= nSubCount + 1;
			end
		end
	end
	
	
	print(string.format("Task System Inited! %d task(s) and %d subtask(s) loaded!", nTaskCount, nSubCount));
	
	self:LoadLevelRangeInfo();
	self:LoadTaskTypeFile();
	LinkTask:InitFile();	--包萬同任務
	TreasureMap:OnInit();	--藏寶圖任務
	Merchant:InitFile();	--商會任務
	Wanted:InitFile();		--官府通緝任務
end

-------------------------------------------------------------------------
-- 玩家上線，先載入這個玩家的任務數據
function Task:OnLogin()
	Dialog:SetTrackTask(me, false);
	self:LoadData();
	me.SyncTaskGroup(1000); -- 同步已完成的任務,nGroupId = 1000, nTaskValueId = nTaskId, nTaskValue = nLastRefId
	Dialog:SetTrackTask(me, true);
end


-------------------------------------------------------------------------
-- 玩家下線，保存任務數據
function Task:OnLogout()
	if (MODULE_GAMESERVER) then
		local tbPlayerTask	= self:GetPlayerTask(me);
		for _, tbTask in pairs(tbPlayerTask.tbTasks) do
			tbTask:SaveData();
			tbTask:CloseCurStep("logout");
		end
		
		print(string.format("Player[%s] %d task(s) saved.", me.szName, tbPlayerTask.nCount));
	end
end



-------------------------------------------------------------------------
-- 根據玩家任務變量，載入已接任務，每個任務變量組前面4個都有特殊意義
function Task:LoadData()
	local nCount = 0;
	for nSaveGroup = self.TASK_GROUP_MIN, self.TASK_GROUP_MAX do
		local nReferId	= me.GetTask(nSaveGroup, self.emSAVEID_REFID);
		if (nReferId ~= 0) then
			local tbTask	= self:NewTask(nReferId);
			if (tbTask) then
				tbTask:LoadData(nSaveGroup);-- 載入這個任務的數據，比如當前目標和步驟
				nCount	= nCount + 1;
			end
			
		end;
	end;
	
	print(string.format("Player[%s] %d task(s) loaded.", me.szName, nCount));
end;


-------------------------------------------------------------------------
-- 任務存入玩家任務變量
function Task:SaveData()
	local tbPlayerTask	= self:GetPlayerTask(me);
	for _, tbTask in pairs(tbPlayerTask.tbTasks) do
		tbTask:SaveData();
	end;
	print(string.format("Player[%s] %d task(s) saved.", me.szName, tbPlayerTask.nCount));
end;



-------------------------------------------------------------------------
-- [S]通知客戶端彈出接受任務對話框
function Task:AskAccept(nTaskId, nReferId, pSharedPlayer)
	local nSharedPlayerId = -1;
	
	if (self.tbTaskDatas[nTaskId] and self.tbTaskDatas[nTaskId].tbAttribute["Repeat"]) then
		if (self:CanAcceptRepeatTask() ~= 1) then
			if (pSharedPlayer) then
				pSharedPlayer.Msg(me.szName.."Nhiệm vụ tuần hoàn của hôm nay đã hết, không thể nhận nhiệm vụ chia sẻ");
			end
			
			return;
		end
	end

	if (pSharedPlayer) then
		nSharedPlayerId = pSharedPlayer.nId;
	end
	
	self:GetPlayerTask(me).tbAskAccept	= { -- 防止客戶端作弊(沒接任務也發送接任務請求)
		nTaskId			= nTaskId,
		nReferId		= nReferId,
		nAskDate		= GetCurServerTime(),
		nSharedPlayerId	= nSharedPlayerId; 
	};
	KTask.SendAccept(me, nTaskId, nReferId);
	return 1;
end;


-------------------------------------------------------------------------
-- 接到客戶端確認接受
function Task:OnAccept(nTaskId, nReferId, bAccept)
	if (self.tbTaskDatas[nTaskId] and 
		not self.tbTaskDatas[nTaskId].tbAttribute["Repeat"] and
		Task:HaveDoneSubTask(me, nTaskId, nReferId) == 1) then
		me.Msg("Bạn đã hoàn thành nhiệm vụ này rồi!");
		local szMsg = "TaskId: " .. nTaskId .. "ReferId"  .. nReferId;
		Dbg:WriteLog("Task", "Nhiệm vụ lặp lại", me.szAccount, me.szName, szMsg);
		BlackSky:GiveMeBright(me);
		return;
	end;
	
	BlackSky:GiveMeBright(me);
	local tbPlayerTask	= self:GetPlayerTask(me);
	local tbAskAccept	= tbPlayerTask.tbAskAccept;
	if (not tbAskAccept or tbAskAccept.nTaskId ~= nTaskId or tbAskAccept.nReferId ~= nReferId) then -- 校驗客戶端是否作弊(沒接任務也發送接任務請求)
		return;
	end
	local nSharedPlayerId	= tbAskAccept.nSharedPlayerId;
	
	local pSharedPlayer = KPlayer.GetPlayerObjById(nSharedPlayerId);
	
	tbPlayerTask.tbAskAccept	= nil;
	
	-- 重復任務需要檢查可接次數
	if (self.tbTaskDatas[nTaskId].tbAttribute["Repeat"]) then
		if (self:CanAcceptRepeatTask() ~= 1) then
			Dialog:SendInfoBoardMsg(me, "Nhiệm vụ tuần hoàn mỗi ngày chỉ có thể nhận 10 lần!");
			return;
		end
	end
	
	if (bAccept == 0) then
		if (pSharedPlayer) then
			pSharedPlayer.Msg(me.szName.."Từ chối nhiệm vụ bạn chia sẻ"..self.tbTaskDatas[nTaskId].szName);
		end
		
		return 1;
	end
	
	if (pSharedPlayer) then
		pSharedPlayer.Msg(me.szName.."Đồng ý nhiệm vụ bạn chia sẻ"..self.tbTaskDatas[nTaskId].szName);
	end
	
	return self:DoAccept(nTaskId, nReferId);
end


-------------------------------------------------------------------------
-- 立即接受任務
function Task:DoAccept(nTaskId, nReferId)
	if (type(nTaskId) == "string") then
		nTaskId = tonumber(nTaskId, 16);
	end
	if (type(nReferId) == "string") then
		nReferId = tonumber(nReferId, 16);
	end
	
	if (not nTaskId or not nReferId) then
		assert(false);
		return;
	end
	
	local tbTaskData	= self.tbTaskDatas[nTaskId];
	local tbReferData	= self.tbReferDatas[nReferId];
	if (not tbReferData) then
		return;
	end
	
	
	-- 判斷可接條件
	if (tbReferData.tbAccept) then
		local bOK, szMsg	= Lib:DoTestFuncs(tbReferData.tbAccept);
		if (not bOK) then
			Dialog:SendInfoBoardMsg(me, szMsg)
			return nil;
		end;
	end;
	
	local tbUsedGroup	= {};
	-- 標記已經使用過的Group
	for _, tbTask in pairs(self:GetPlayerTask(me).tbTasks) do
		tbUsedGroup[tbTask.nSaveGroup]	= 1;
	end;
	-- 找出空閑的可以使用的Group
	local nSaveGroup	= nil;
	for n = self.TASK_GROUP_MIN, self.TASK_GROUP_MAX do
		if (not tbUsedGroup[n]) then
			nSaveGroup	= n;
			break;
		end;
	end;
	if (not nSaveGroup) then
		Dialog:SendInfoBoardMsg(me, "Nhiệm vụ của bạn đã đầy!");
		return nil;
	end;

	-- 若是物品觸發，檢查玩家身上是否有此物品，有則刪除，沒有就返回nil
	if (tbReferData.nParticular) then
		local tbItemId = {20,1,tbReferData.nParticular,1};
		if (not self:DelItem(me, tbItemId, 1)) then
			Dialog:SendInfoBoardMsg(me, "Không có vật phẩm chỉ định, không nhận được nhiệm vụ!");
			return nil;
		end
	end
	
	-- 建立此任務的實例
	local tbTask	= self:NewTask(nReferId);
	if (not tbTask) then
		return nil;
	end;
	
	Merchant:DoAccept(tbTask, nTaskId, nReferId);
	-- 重復任務需要設置已接次數
	if (self.tbTaskDatas[nTaskId].tbAttribute["Repeat"] and tbReferData.nSubTaskId < 10000) then
		local nAcceptTime = me.GetTask(2031, 1);
		assert(nAcceptTime < self.nRepeatTaskAcceptMaxTime);
		me.SetTask(2031, 1, nAcceptTime + 1, 1);
	end
	
	tbTask.nAcceptDate	= GetCurServerTime();
	tbTask.nSaveGroup	= nSaveGroup;
	me.Msg("Nhận được nhiệm vụ mới: "..tbTask:GetName());
	tbTask:SetCurStep(1);
	me.CastSkill(self.nAcceptTaskSkillId,1,-1, me.GetNpc().nIndex);
	
	local tbStartExecute = tbTask.tbSubData.tbStartExecute;
	if (tbStartExecute and #tbStartExecute > 0) then
		Lib:DoExecFuncs(tbStartExecute);
	end;
	
	self:LogAcceptTask(nTaskId);
	--寫Log
--	if tbTask.tbTaskData.tbAttribute.TaskType == 1 then		
--		local szTaskName = self:GetTaskName(tbTask.nTaskId);
--		local szSubTaskName = self:GetManSubName(tbTask.nReferId);
--		KStatLog.ModifyField("roleinfo", me.szName, "主線："..szTaskName, szSubTaskName);
--	end
	return tbTask;
end;



function Task:LogAcceptTask(nTaskId)
	if (nTaskId == 226 or nTaskId == 337 or nTaskId == 338 or nTaskId == 363 or nTaskId == 365 or nTaskId == 367) then -- 劇情
		Task.tbArmyCampInstancingManager.StatLog:WriteLog(2, 1);
	elseif (nTaskId == 227 or nTaskId == 333 or nTaskId == 334 or nTaskId == 364 or nTaskId == 366 or nTaskId == 368) then -- 日常
		Task.tbArmyCampInstancingManager.StatLog:WriteLog(3, 1);
	elseif (nTaskId >= 269 and nTaskId <= 280) then
		Task.tbArmyCampInstancingManager.StatLog:WriteLog(10, 1);
	end
end


function Task:LogFinishTask(nTaskId)
	if (nTaskId == 226 or nTaskId == 337 or nTaskId == 338 or nTaskId == 363 or nTaskId == 365 or nTaskId == 367) then
		Task.tbArmyCampInstancingManager.StatLog:WriteLog(4, 1);
	elseif (nTaskId == 227 or nTaskId == 333 or nTaskId == 334 or nTaskId == 364 or nTaskId == 366 or nTaskId == 368) then
		Task.tbArmyCampInstancingManager.StatLog:WriteLog(5, 1);
	end
end
-------------------------------------------------------------------------
-- 建立玩家當前任務數據
function Task:NewTask(nReferId)
	local tbReferData	= self.tbReferDatas[nReferId];
	if (not tbReferData) then
		me.Msg("Nhiệm vụ ngẫu nhiên - " .. nReferId);
		return nil;
	end
	
	local nTaskId		= tbReferData.nTaskId;
	local nSubTaskId	= tbReferData.nSubTaskId;
	local tbTaskData	= self.tbTaskDatas[nTaskId];
	local tbSubData		= self.tbSubDatas[nSubTaskId];

	-- 獲得玩家的任務 
	local tbPlayerTask	= self:GetPlayerTask(me);
	if (tbPlayerTask.tbTasks[nTaskId]) then
		me.Msg("Nhiệm vụ tuần hoàn - " .. tbTaskData.szName);
		return nil;
	end;

	local tbTask		= Lib:NewClass(self._tbClassBase);
	tbTask.nTaskId		= nTaskId;
	tbTask.nSubTaskId	= nSubTaskId;
	tbTask.nReferId		= nReferId;
	tbTask.tbTaskData	= tbTaskData;
	tbTask.tbSubData	= tbSubData;
	tbTask.tbReferData	= tbReferData;
	tbTask.tbCurTags	= {};
	tbTask.nAcceptDate	= 0;
	tbTask.nCurStep		= 0;
	tbTask.nSaveGroup	= 0;
	tbTask.me			= me;
	tbTask.tbNpcMenus	= {};
	
	tbTask.nLogMoney	= 0;

	tbPlayerTask.tbTasks[nTaskId]	= tbTask;
	tbPlayerTask.nCount	= tbPlayerTask.nCount + 1;
	return tbTask;
end;



-------------------------------------------------------------------------
-- 接到客戶端放棄
function Task:OnGiveUp(nTaskId, nReferId)
	local tbPlayerTask	= self:GetPlayerTask(me);
	local tbTask	= tbPlayerTask.tbTasks[nTaskId];
	
	if (not tbTask or tbTask.nReferId ~= nReferId) then
		me.Msg("Hủy thất bại: Không có nhiệm vụ này");
		return;
	end

	if (not tbTask.tbReferData.bCanGiveUp) then
		me.Msg("Hủy thất bại: Không thể hủy nhiệm vụ này");
		return;
	end
	
	self:CloseTask(nTaskId, "giveup");
end


-------------------------------------------------------------------------
-- [S]接到客戶端申請共享
function Task:OnShare(nTaskId, nReferId)
	local tbPlayerTask	= self:GetPlayerTask(me);
	local tbTask	= tbPlayerTask.tbTasks[nTaskId];
	
	if (not tbTask or tbTask.nReferId ~= nReferId) then
		me.Msg("Chia sẻ thất bại: Không có nhiệm vụ này");
		return;
	end

	if (not tbTask.tbTaskData.tbAttribute["Share"]) then
		me.Msg("Chia sẻ thất bại: Nhiệm vụ này không thể chia sẻ");
		return;
	end
	
	local tbTeamMembers, nMemberCount	= me.GetTeamMemberList();
	if (not tbTeamMembers) then
		Dialog:SendInfoBoardMsg(me, "Chia sẻ thất bại: Chưa có tổ đội!");
		return;
	end
	if (nMemberCount <= 0) then
		Dialog:SendInfoBoardMsg(me, "Chia sẻ thất bại: Đội ngũ chưa có thành viên!");
		return;
	end
	
	-- 隻有玩家處於這個任務的第一個引用子任務的時候才能共享
	if (self:GetFinishedRefer(nTaskId) > 0) then
		me.Msg("Chia sẻ thất bại: Nhiệm vụ này không có trong chuỗi nhiệm vụ!");
		return;
	end
	
	local tbReferData	= self.tbReferDatas[nReferId];
	local tbVisable	= tbReferData.tbVisable;
					
	local plOld	= me;
	local nOldPlayerIdx = me.nPlayerIndex;
	for i = 1, nMemberCount do
		me	= tbTeamMembers[i];
		if (me.nPlayerIndex ~= nOldPlayerIdx) then
			if (Task:AtNearDistance(me, plOld) == 1) then
				local tbPlayerTask = self:GetPlayerTask(me);
				if (not tbPlayerTask.tbTasks[nTaskId]) then
					if (self:GetFinishedRefer(nTaskId) <= 0) then  -- 隻有從沒接這個任務的隊友才能接受
						if (Lib:DoTestFuncs(tbVisable)) then
							self:AskAccept(nTaskId, nReferId, plOld);
						else
							plOld.Msg(me.szName.."Không đủ điều kiện để nhận nhiệm vụ!")
						end
					else
						plOld.Msg(me.szName.." đã có nhiệm vụ này rồi!");
					end
				end
			else
				plOld.Msg(me.szName.." quá xa, không thể chia sẻ nhiệm vụ!");
			end
		end
	end
	me	= plOld;
end


-------------------------------------------------------------------------
-- 接到客戶端領獎
function Task:OnAward(nTaskId, nReferId, nChoice)
	-- 需判斷是否會接下一個子任務
	BlackSky:GiveMeBright(me);
	if (nChoice == -1) then
		me.Msg("Chưa nhận thưởng không thể hoàn thành nhiệm vụ. Bạn có thể quay lại nhận phần thưởng!");
		return;
	end;
	local tbPlayerTask	= self:GetPlayerTask(me);
	local tbTask	= tbPlayerTask.tbTasks[nTaskId];
	if (not tbTask or tbTask.nCurStep ~= -1) then --防止客戶端舞弊
		me.Msg("Không có nhiệm vụ này hoặc chưa hoàn thành!");
		return;
	end
	
	if (tbTask and tbTask.nReferId ~= nReferId) then -- 錯誤的ReferId
		return;
	end
	local tbTaskType = {
		[226] = 1,	--軍營劇情
		[337] = 1,
		[338] = 1,
		[363] = 1,
		[365] = 1,
		[367] = 1,
		[227] = 2,	--軍營日常
		[333] = 2,
		[334] = 2,
		[364] = 2,
		[366] = 2,
		[368] = 2,
		[50000] = 3, --商會任務
	};
	local nFreeCount = 0;
	local tbFunExecute = {};
	if tbTaskType[nTaskId] == 1 then
		nFreeCount, tbFunExecute = SpecialEvent.ExtendAward:DoCheck("ArmyCampTask", me);
	end
	
	if tbTaskType[nTaskId] == 3 then
		nFreeCount, tbFunExecute = SpecialEvent.ExtendAward:DoCheck("MerchantTask", me);
	end
	
	if (not TaskCond:HaveBagSpace(tbTask.tbReferData.nBagSpaceCount+nFreeCount)) then
		Dialog:SendInfoBoardMsg(me, "Thu xếp túi còn "..(tbTask.tbReferData.nBagSpaceCount + nFreeCount).." ô trống rồi quay lại nhận thưởng");
		return;
	end

	if tbTaskType[nTaskId] == 1 then	-- 完成劇情
		me.AddOfferEntry(80, WeeklyTask.GETOFFER_TYPE_ARMYCAMP);
		
		-- 增加幫會建設資金和相應族長、個人的股份		
		local nStockBaseCount = 50; -- 股份基數			
		Tong:AddStockBaseCount_GS1(me.nId, nStockBaseCount, 0.8, 0.15, 0.05, 0, 0, WeeklyTask.GETOFFER_TYPE_ARMYCAMP);
		SpecialEvent.ExtendAward:DoExecute(tbFunExecute);
		
		-- 成就：完成軍營任務
		Achievement:FinishAchievement(me.nId, Achievement.ARMYCAMP);
	elseif tbTaskType[nTaskId] == 2 then	-- 完成日常
		me.AddOfferEntry(40, WeeklyTask.GETOFFER_TYPE_ARMYCAMP);
		
		-- 增加幫會建設資金和相應個人的股份		
		local nStockBaseCount = 20; -- 股份基數				
		Tong:AddStockBaseCount_GS1(me.nId, nStockBaseCount, 0.8, 0.15, 0.05, 0, 0, WeeklyTask.GETOFFER_TYPE_ARMYCAMP);
		
		-- 成就：完成軍營任務
		Achievement:FinishAchievement(me.nId, Achievement.ARMYCAMP);
	elseif tbTaskType[nTaskId] == 3 then
		Merchant:FinishTaskOnAward();
	end

	local tbAwards	= self:GetAwardsForMe(nTaskId, true);
	if (tbAwards.tbOpt[nChoice]) then
		self:GiveAward(tbAwards.tbOpt[nChoice], nTaskId);
	end;
	for _, tbAward in pairs(tbAwards.tbFix) do
		self:GiveAward(tbAward, nTaskId);
	end;
	
	
	if (tbAwards.tbRand[1]) then
		local nSum	= 0;
		local nCurSum = 0;
		for _,tbAward in pairs(tbAwards.tbRand) do
			nSum = nSum + tbAward.nRate;
		end
		if (nSum >= 1) then
			local nRand	= MathRandom(nSum);
			for _, tbAward in pairs(tbAwards.tbRand) do
				nCurSum	= nCurSum + tbAward.nRate;
				if (nCurSum > nRand) then
					self:GiveAward(tbAward, nTaskId);
					break;
				end
			end
		end
	end			
	
	self:SetFinishedRefer(nTaskId, nReferId);

	self:CloseTask(nTaskId, "finish");
	
	self:LogFinishTask(nTaskId);
end


-------------------------------------------------------------------------
-- 給與一組獎勵，並提示獲得獎品
function Task:GiveAward(tbAward, nTaskId)
	
	local szType	= tbAward.szType;
	local varValue	= tbAward.varValue;
	
	if (szType == "exp") then
		local nExp = tbAward.varValue;
		local nKinId = me.dwKinId;
		local cKin = KKin.GetKin(nKinId);
		if (cKin) then
			local nWeeklyTask = cKin.GetWeeklyTask()
			if (5 == nWeeklyTask) then
				nExp = nExp * 1.5;	-- 如果周任務是軍營，那麼經驗是平常的1.5倍
			end
		end
		--越南防沉迷，經驗獲取0.5倍
		if (me.GetTiredDegree() == 1) then
			nExp = nExp * 0.5;
		end
		me.AddExp(nExp);
	elseif (szType == "money" or szType == "bindmoney") then
			me.AddBindMoney(tbAward.varValue, Player.emKBINDMONEY_ADD_TASK);
			KStatLog.ModifyAdd("bindjxb", "[Nơi]"..self:GetTaskTypeName(nTaskId), "Tổng", tbAward.varValue);
	elseif (szType == "activemoney") then
		local tbPlayerTask	= self:GetPlayerTask(me);
		local tbTask		= tbPlayerTask.tbTasks[nTaskId];
		if (tbTask) then
			me.Earn(tbAward.varValue, Player.emKEARN_TASK_GIVE);
			tbTask.nLogMoney = tbAward.varValue;
			KStatLog.ModifyAdd("jxb", "[Nơi]"..self:GetTaskTypeName(nTaskId), "Tổng", tbAward.varValue);
		end
	elseif (szType == "repute") then
		--軍營聲望
		if (tbAward.varValue[1] == 1 and tbAward.varValue[2] == 2) then
			me.Msg(string.format("Bạn nhận được <color=yellow>%s điểm <color> Danh vọng quân doanh", tbAward.varValue[3]));
		end
		--機關學造詣
		if (tbAward.varValue[1] == 1 and tbAward.varValue[2] == 3) then
			me.Msg(string.format("Bạn nhận được <color=yellow>%s điểm <color> Cơ Quan Học Tạo Đồ", tbAward.varValue[3]));
			Task.tbArmyCampInstancingManager.StatLog:WriteLog(11, tbAward.varValue[3]);
		end
		me.AddRepute(unpack(tbAward.varValue))
	elseif (szType == "title") then
		me.AddTitle(tbAward.varValue[1], tbAward.varValue[2], tbAward.varValue[3], 0)
	elseif (szType == "taskvalue") then
		if (tbAward.varValue[1] == 2025 and tbAward.varValue[2] == 2) then
			Task.tbArmyCampInstancingManager.StatLog:WriteLog(12, tbAward.varValue[3]);
			me.AddMachineCoin(tbAward.varValue[3]);
		else
			me.SetTask(tbAward.varValue[1], tbAward.varValue[2], tbAward.varValue[3], 1);
		end	
	elseif(szType == "script") then
		-- 直接執行腳本
		loadstring(tbAward.varValue)();
	elseif (szType == "item") then
		local nCount = tonumber(tbAward.szAddParam1) or 1;
		if (nCount < 1) then
			nCount = 1;
		end
		for i = 1, nCount do
			local pItem 	= Task:AddItem(me, tbAward.varValue);
			--self:WriteItemLog(pItem, me, nTaskId);
		end
	elseif (szType == "customizeitem") then
		Task:AddItem(me, tbAward.varValue);
	elseif (szType == "gatherpoint") then
		TaskAct:AddGatherPoint(tonumber(tbAward.varValue))
	elseif (szType == "makepoint") then
		TaskAct:AddMakePoint(tonumber(tbAward.varValue))
	elseif (szType == "KinReputeEntry") then
		me.AddKinReputeEntry(tbAward.varValue[1]);
	elseif (szType == "arrary") then
		for _, tbOneAward in ipairs(tbAward.varValue) do
			self:GiveAward(tbOneAward, nTaskId);
		end;
	elseif (szType == "bindcoin") then
		me.AddBindCoin(tbAward.varValue[1], Player.emKBINDCOIN_ADD_TASK);
		KStatLog.ModifyAdd("bindcoin", "[Nơi]"..self:GetTaskTypeName(nTaskId), "Tổng", tbAward.varValue[1]);
	end;
end;

function Task:WriteItemLog(pItem, pPlayer, nTaskId)
	local tbPlayerTask	= self:GetPlayerTask(pPlayer);
	local tbTask		= tbPlayerTask.tbTasks[nTaskId];
	local szLogMsg		= "";
	if (tbTask) then
		szLogMsg	= string.format(" hoàn thành %s, ID nhiệm vụ: %x, ID nhiệm vụ phụ tuyến: %x", tbTask:GetName(), tbTask.nTaskId, tbTask.nReferId);		
	else
		szLogMsg	= string.format("Không có nhiệm vụ có Id là %x!", nTaskId);
	end;
	local bGiveSuc 	= 1;
	if (not pItem) then
		bGiveSuc = 0;
	end
--	me.ItemLog(pItem, bGiveSuc, Log.emKITEMLOG_TYPE_FINISHTASK, szLogMsg);
	local szLog = string.format("%s nhận được 1 %s", szLogMsg, pItem.szName);
	Dbg:WriteLog("Task", "nhiệm vụ nhận được vật phẩm ", me.szAccount, me.szName, szLog);
end

-------------------------------------------------------------------------
-- 設定特定任務完成的最後一個引用子任務ID
function Task:SetFinishedRefer(nTaskId, nReferId)
	local nLogReferId = nReferId;
	local tbTaskData = self.tbTaskDatas[nTaskId];
	if (tbTaskData.tbAttribute["Repeat"]) then
		local nReferIdx		= self:GetFinishedIdx(nTaskId) + 2;	
		local nNextReferId	= tbTaskData.tbReferIds[nReferIdx];
		if (not nNextReferId) then
			nReferId = 0;
		end
	end
	
	me.SetTask(1000, nTaskId, nReferId, 1); -- Group1000保存了所有任務的完成情況,其中任務變量Id(nTaskId)也就是任務Id
end


-------------------------------------------------------------------------
-- 使任務失敗
function Task:Failed(nTaskId)
	if (type(nTaskId) == "string") then
		nTaskId = tonumber(nTaskId, 16);
	end

	return self:CloseTask(nTaskId, "failed");
end;

-------------------------------------------------------------------------

-- 獲取師徒成就：完成XXX任務
function Task:GetAchiemement(pPlayer, nMainTaskId, nSubTaskId)
	if (not pPlayer) then
		return;
	end
	local tbMainTaskId = Achievement.tbMainTaskId;
	for nAchievementId, tbAchievement in pairs(tbMainTaskId) do
		for i, v in pairs(tbAchievement) do
			local nMainId = v[1];
			local nSubId = v[2];
			if (nMainTaskId == nMainId and nSubTaskId == nSubId) then
				Achievement:FinishAchievement(pPlayer.nId, nAchievementId);				
			end
		end
	end
end

-------------------------------------------------------------------------
-- 關閉任務
function Task:CloseTask(nTaskId, szReason)
	local tbPlayerTask	= self:GetPlayerTask(me);
	local tbTask	= tbPlayerTask.tbTasks[nTaskId];
	if (not tbTask) then
		return nil;
	end;

	tbTask:CloseCurStep(szReason);
	if (szReason == "giveup") then
		me.Msg("Huỷ nhiệm vụ: "..tbTask:GetName());
		me.Msg(tbTask.tbReferData.szGossip);
	elseif (szReason == "failed") then
		me.Msg("Nhiệm vụ thất bại: "..tbTask:GetName());
		me.Msg(tbTask.tbReferData.szGossip);
	elseif (szReason == "finish") then
		-- 2. 低於50級以下角色的任務事件，不記入角色歷程日志。
		if (me.nLevel >= 50) then
			me.Msg("Nhiệm vụ hoàn thành: "..tbTask:GetName());
			me.CastSkill(self.nFinishTaskSkillId, 1, -1, me.GetNpc().nIndex);
			local szLogMsg = string.format(" hoàn thành %s, ID nhiệm vụ: %x, ID nhiệm vụ phụ tuyến: %x", tbTask:GetName(), tbTask.nTaskId, tbTask.nReferId);
			if (tbTask.nLogMoney > 0) then
				szLogMsg = szLogMsg .. string.format(" phần thưởng%d lượng", tbTask.nLogMoney)
				tbTask.nLogMoney = 0;
			end
			me.PlayerLog(Log.emKPLAYERLOG_TYPE_FINISHTASK ,szLogMsg);
		end
		
		if (self:CheckArmyTask(nTaskId) == 1) then -- 劇情任務
			Dbg:WriteLogEx(Dbg.LOG_INFO, "ArmyTask", "FinishJuqingTask", tbTask:GetName(), me.szName, os.date("%Y-%m-%d-%H:%M:%S", GetTime()));
		elseif (self:CheckArmyTask(nTaskId) == 2) then -- 日常任務
			Dbg:WriteLogEx(Dbg.LOG_INFO, "ArmyTask", "FinishDailyTask", tbTask:GetName(), me.szName, os.date("%Y-%m-%d-%H:%M:%S", GetTime()));
		elseif (self:CheckArmyTask(nTaskId) == 3) then
			Dbg:WriteLogEx(Dbg.LOG_INFO, "ArmyTask", "FinishWuJinTask", tbTask:GetName(), me.szName, os.date("%Y-%m-%d-%H:%M:%S", GetTime()));
		end
	end;
	
	-- 師徒成就：完成XXX任務
	self:GetAchiemement(me, tbTask.nTaskId, tbTask.nReferId);
	
	tbPlayerTask.tbTasks[nTaskId]	= nil;
	tbPlayerTask.nCount	= tbPlayerTask.nCount - 1;
	if (tbPlayerTask.nCount <= 0) then
		
	end;

	me.ClearTaskGroup(tbTask.nSaveGroup,1);

	KTask.SendRefresh(me, nTaskId, tbTask.nReferId, 0);
	
	if (szReason == "finish") then
		local tbFinishExecute = tbTask.tbSubData.tbFinishExecute;
		if (tbFinishExecute and #tbFinishExecute > 0) then
			Lib:DoExecFuncs(tbFinishExecute);
		end;
		
		local tbSubExecute = tbTask.tbSubData.tbExecute;
		if (tbSubExecute and #tbSubExecute > 0) then
			Lib:DoExecFuncs(tbSubExecute);
		end;		
	elseif (szReason == "failed" or szReason == "giveup") then
		local tbFailedExecute = tbTask.tbSubData.tbFailedExecute;
		if (tbFailedExecute and #tbFailedExecute > 0) then
			Lib:DoExecFuncs(tbFailedExecute);
		end;
	end
	
	return 1;
end;

function Task:CheckArmyTask(nTaskId)
	local tbTaskType = {
		[226] = 1,	--軍營劇情
		[337] = 1,
		[338] = 1,
		[363] = 1,
		[365] = 1,
		[367] = 1,
		[227] = 2,	--軍營日常
		[333] = 2,
		[334] = 2,
		[364] = 2,
		[366] = 2,
		[368] = 2,
		[429] = 3, -- 無盡的征程
	};
	if tbTaskType[nTaskId] then	-- 完成劇情
		return tbTaskType[nTaskId];
	end		
	return 0;
end

-------------------------------------------------------------------------
-- 追加Npc對話選項
function Task:AppendNpcMenu(tbOption)
	local nNpcTempId	= him.nTemplateId;
	local tbPlayerTasks	= self:GetPlayerTask(me).tbTasks;
	local bHaveRelation	= 0;
	-- 添加已有任務對話選項
	for _, tbTask in pairs(tbPlayerTasks) do
		if (tbTask:AppendNpcMenu(nNpcTempId, tbOption, him)) then
			bHaveRelation	= 1;
		end
	end
	
	-- 添加可見任務對話選項
	for _, tbTaskData in pairs(self.tbTaskDatas) do
		if (not tbPlayerTasks[tbTaskData.nId]) then
			local nReferIdx		= self:GetFinishedIdx(tbTaskData.nId) + 1;			-- +1表示將要繼續的任務
			local nReferId		= tbTaskData.tbReferIds[nReferIdx];
			if (not tbTaskData.tbAttribute["Repeat"] or self:CanAcceptRepeatTask() == 1) then
				if (nReferId) then
					local tbReferData	= self.tbReferDatas[nReferId];
					if (tbReferData.nAcceptNpcId == nNpcTempId) then
						local tbVisable	= tbReferData.tbVisable;
						local bOK	= Lib:DoTestFuncs(tbVisable);						-- 可見條件測試
						if (bOK) then
							bHaveRelation	= 1;
							local tbSubData	= self.tbSubDatas[tbReferData.nSubTaskId];
							if (tbSubData) then
								local szMsg = "";
								if (tbSubData.tbAttribute.tbDialog.Start) then
									if (tbSubData.tbAttribute.tbDialog.Start.szMsg) then 		-- 未分步驟
										szMsg = tbSubData.tbAttribute.tbDialog.Start.szMsg;
									else
										szMsg = tbSubData.tbAttribute.tbDialog.Start.tbSetpMsg[1];
									end
								end
								
								tbOption[#tbOption + 1]	= {"[Nhiệm vụ] "..tbReferData.szName,
									TaskAct.TalkInDark, TaskAct, szMsg,
									self.AskAccept, self, tbTaskData.nId, nReferId};
							end
						end
					end
				end
			end
		end
	end
	
	Lib:SmashTable(tbOption);
	return bHaveRelation;
end;


-------------------------------------------------------------------------
-- 靠近一個NPC時觸發，顯示在小地圖上的技能和頭上的問號，嘆號
function Task:OnApproachNpc()
	local tbTaskState = Task:CheckTaskOnNpc();
	
	self:ChangeNpcFlag(tbTaskState);
end;


-------------------------------------------------------------------------
-- 檢測Npc任務標記，用於客戶端顯示
-- TODO: liuchang 之後可能有需求根據是否已完成目標添加新的技能
function Task:CheckTaskOnNpc()
	local tbPlayerTasks	= self:GetPlayerTask(me).tbTasks;
	
	-- 檢測已有任務
	for _, tbTask in pairs(tbPlayerTasks) do
		if (tbTask:CheckTaskOnNpc() == 1) then
			if (tbTask.tbTaskData.tbAttribute["Repeat"]) then
				return self.CheckTaskFlagSkillSet.RepeatCanReply;
			elseif (tbTask.tbTaskData.tbAttribute.TaskType == self.emType_Main) then
				return self.CheckTaskFlagSkillSet.MainCanReply;
			elseif (tbTask.tbTaskData.tbAttribute.TaskType == self.emType_Branch) then
				return self.CheckTaskFlagSkillSet.BranchCanReply;
			elseif (tbTask.tbTaskData.tbAttribute.TaskType == self.emType_World) then
				return self.CheckTaskFlagSkillSet.WorldCanReply;
			elseif (tbTask.tbTaskData.tbAttribute.TaskType == self.emType_Random) then
				return self.CheckTaskFlagSkillSet.RandomCanReply;
			elseif (tbTask.tbTaskData.tbAttribute.TaskType == self.emType_Camp) then
				return self.CheckTaskFlagSkillSet.RandomCanReply;
			else
				assert(false);
			end
		end;
	end;
	
	
	-- 檢測可見任務
	for _, tbTaskData in pairs(self.tbTaskDatas) do
		if (not tbPlayerTasks[tbTaskData.nId]) then
			local nReferIdx		= self:GetFinishedIdx(tbTaskData.nId) + 1;--+1表示將要做的任務
			local nReferId		= tbTaskData.tbReferIds[nReferIdx];
			if (nReferId) then
				local tbReferData	= self.tbReferDatas[nReferId];
				if (tbReferData.nAcceptNpcId == him.nTemplateId) then
					local tbVisable	= tbReferData.tbVisable;
					local bOK	= Lib:DoTestFuncs(tbVisable);
					if (bOK) then
						if (tbTaskData.tbAttribute["Repeat"]) then
							if (self:CanAcceptRepeatTask() ~= 1) then
								return;
							end
							return self.CheckTaskFlagSkillSet.RepeatCanAccept;
						elseif (tbTaskData.tbAttribute.TaskType == self.emType_Main) then
							return self.CheckTaskFlagSkillSet.MainCanAccept;
						elseif (tbTaskData.tbAttribute.TaskType == self.emType_Branch) then
							return self.CheckTaskFlagSkillSet.BranchCanAccept;
						elseif (tbTaskData.tbAttribute.TaskType == self.emType_World) then
							return self.CheckTaskFlagSkillSet.WorldCanAccept;
						elseif (tbTaskData.tbAttribute.TaskType == self.emType_Random) then
							return self.CheckTaskFlagSkillSet.RandomCanAccept;
						elseif (tbTaskData.tbAttribute.TaskType == self.emType_Camp) then
							return self.CheckTaskFlagSkillSet.RandomCanAccept;
						else
							assert(false);
						end
					end
				end;
			end;
		end;
	end;
	
	return;

end;



-------------------------------------------------------------------------
-- 改變NPC的任務狀態顯示,去除不需要的，添加需要的
function Task:ChangeNpcFlag(tbSkillId)
	
	local tbTempTotleSkill = {};
	for _,tbSkillSet in pairs(self.CheckTaskFlagSkillSet) do
		for _, Skill in pairs(tbSkillSet) do
			tbTempTotleSkill[Skill] = 1;
		end
	end

	local tbTotleSkill = {};
	for Skill,Item in pairs(tbTempTotleSkill) do
		tbTotleSkill[#tbTotleSkill+1] = Skill;
	end


	if (not tbSkillId) then
		for _,nSkillId in ipairs(tbTotleSkill) do
			him.RemoveTaskState(nSkillId);
		end
		return;
	end

	for _,nSkillId in ipairs(tbTotleSkill) do	
		local bRemove = 1;
		for _, nRetainSkillId in ipairs(tbSkillId) do
			local tbBeRemoveSet = {};
			if (nRetainSkillId == nSkillId) then
				bRemove = 0;
			end
		end
		if (bRemove == 1) then
			him.RemoveTaskState(nSkillId);
		end
	end
	
	for _, nRetainSkillId in ipairs(tbSkillId) do
		him.AddTaskState(nRetainSkillId);
	end
end


-------------------------------------------------------------------------
-- 玩家使用任務物品時候觸發
function Task:OnTaskItem(pItem)
	local nParticular	= pItem.nParticular;
	local tbPlayerTasks	= self:GetPlayerTask(me).tbTasks;
	
	-- 用於已有任務
	for _, tbTask in pairs(tbPlayerTasks) do
		if (tbTask:OnTaskItem(nParticular)) then
			return 1;
		end;
	end;
	
	-- 用於接新任務
	for _, tbTaskData in pairs(self.tbTaskDatas) do
		if (not tbPlayerTasks[tbTaskData.nId]) then
			local nReferIdx	= self:GetFinishedIdx(tbTaskData.nId) + 1;--+1表示將要做的任務
			local nReferId	= tbTaskData.tbReferIds[nReferIdx];
			if (nReferId) then
				local tbReferData = self.tbReferDatas[nReferId];
				local tbSubData	  = self.tbSubDatas[tbReferData.nSubTaskId];
				local szMsg = "";
				if (tbSubData.tbAttribute.tbDialog.Start) then
					if (tbSubData.tbAttribute.tbDialog.Start.szMsg) then -- 未分步驟
						szMsg = tbSubData.tbAttribute.tbDialog.Start.szMsg;
					else
						szMsg = tbSubData.tbAttribute.tbDialog.Start.tbSetpMsg[1];
					end
				end
							
			
				if (tbReferData.nParticular == pItem.nParticular) then
					local tbVisable	= tbReferData.tbVisable;
					local bOK, szMsg = Lib:DoTestFuncs(tbVisable);						-- 可見條件測試
					if (bOK) then
						TaskAct:TalkInDark(szMsg, self.AskAccept, self, tbTaskData.nId, nReferId);
						return 1
					else
						me.Msg(szMsg);
						return nil;
					end
				end;
			end;
		else
			local nReferIdx	= self:GetFinishedIdx(tbTaskData.nId) + 1;--+1表示將要做的任務
			local nReferId	= tbTaskData.tbReferIds[nReferIdx];
			if (nReferId) then
				local tbReferData	= self.tbReferDatas[nReferId];
				if (tbReferData.nParticular == pItem.nParticular) then
					me.Msg("Vật phẩm để kích hoạt nhiệm vụ đang vận hành!");
					return nil;
				end
			end

		end;
	end;

	return nil;
end;



-------------------------------------------------------------------------
-- 觸發下個步驟時調用,NPC對話和使用道具的時候，見CalssBase.SetCurStep
function Task:Active(nTaskId, nReferId, nCurStep)
	local tbTask	= self:GetPlayerTask(me).tbTasks[nTaskId];
	if (not tbTask) then
		return nil;
	end;
	assert(tbTask.nReferId == nReferId);
	--assert(tbTask.nCurStep == nCurStep); -- 改為return nil; zounan
	if tbTask.nCurStep ~= nCurStep then
		return nil;
	end
	
	return tbTask:Active();
end;


-------------------------------------------------------------------------
-- 和withprocesstagnpc類型NPC交互時觸發，不會彈Say界面，而是進度條之類的及時觸發
function Task:OnExclusiveDialogNpc()
	local nTemplateId = him.nTemplateId;
	local tbPlayerTasks	= self:GetPlayerTask(me).tbTasks;
	

	for _, tbTask in pairs(tbPlayerTasks) do
		if (tbTask:OnExclusiveDialogNpc(nTemplateId)) then
			return 1;
		end;
	end;
	
end


-------------------------------------------------------------------------
-- 根據引用子任務Id獲取獎勵表
function Task:GetAwards(nReferId)
	local tbAwardRet = {};
	local tbRefSubData	= self.tbReferDatas[nReferId];
	if (tbRefSubData) then
		local tbAwardSrc = tbRefSubData.tbAwards;
		-- 1.固定獎勵
		tbAwardRet.tbFix = {};
		for _, tbFix in ipairs(tbAwardSrc.tbFix) do
			if (tbFix.tbConditions) then
				if (Lib:DoTestFuncs(tbFix.tbConditions) == 1) then
					table.insert(tbAwardRet.tbFix, tbFix);
				end
			else
				table.insert(tbAwardRet.tbFix, tbFix);
			end
		end
		
		-- 2.隨機獎勵
		tbAwardRet.tbRand = {};
		for _, tbRand in ipairs(tbAwardSrc.tbRand) do
			if (tbRand.tbConditions) then
				if (Lib:DoTestFuncs(tbRand.tbConditions) == 1) then
					table.insert(tbAwardRet.tbRand, tbRand);
				end
			else
				table.insert(tbAwardRet.tbRand, tbRand);
			end
		end
		
		-- 3.可選獎勵
			tbAwardRet.tbOpt = {};
		for _, tbOpt in ipairs(tbAwardSrc.tbOpt) do
			if (tbOpt.tbConditions) then
				if (Lib:DoTestFuncs(tbOpt.tbConditions) == 1) then
					table.insert(tbAwardRet.tbOpt, tbOpt);
				end
			else
				table.insert(tbAwardRet.tbOpt, tbOpt);
			end
		end
		
		return tbAwardRet;
	else
		return nil;
	end;
end;


-- 根據直接獲取獎勵表
function Task:GetAwardsForMe(nTaskId, bOutMsg)
	local tbAwardRet = {};
	local tbPlayerTask = self:GetPlayerTask(me);
	local tbTask = tbPlayerTask.tbTasks[nTaskId];
	if (not tbTask or not tbTask.tbReferData) then
		return nil;
	end
	local tbAwardSrc = tbTask.tbReferData.tbAwards;
	tbAwardRet.tbFix = self:GetTypeAward(tbAwardSrc.tbFix, bOutMsg);
	tbAwardRet.tbRand = self:GetTypeAward(tbAwardSrc.tbRand, bOutMsg);
	tbAwardRet.tbOpt = self:GetTypeAward(tbAwardSrc.tbOpt, bOutMsg);		
	return tbAwardRet;
end;

function Task:GetTypeAward(tbSrc, bOutMsg)
	local tb = {};
	for _, tbAward in ipairs(tbSrc) do
		if (tbAward.tbConditions) then
			local bRet, szMsg = Lib:DoTestFuncs(tbAward.tbConditions);
			if (bRet == 1) then
				table.insert(tb, tbAward);
			elseif (szMsg and bOutMsg) then
				Dialog:SendBlackBoardMsg(me, szMsg);		
			end
		else
			table.insert(tb, tbAward);
		end
	end
	return tb;
end
-------------------------------------------------------------------------
-- 取得當前玩家任務數據
function Task:GetPlayerTask(pPlayer)
	local tbPlayerData	= pPlayer.GetTempTable("Task");
	local tbPlayerTask	= tbPlayerData.tbTask;
	if (not tbPlayerTask) then
		tbPlayerTask	= {
			nCount	= 0,
			tbTasks	= {},
		};
		tbPlayerData.tbTask	= tbPlayerTask;
	end
	return tbPlayerTask;
end


-------------------------------------------------------------------------
-- 取得特定任務完成的最後一個引用子任務ID
function Task:GetFinishedRefer(nTaskId)
	return me.GetTask(1000, nTaskId);
end


-------------------------------------------------------------------------
-- 取得特定任務完成的最後一個引用子任務序號
function Task:GetFinishedIdx(nTaskId)
	local nReferId	= self:GetFinishedRefer(nTaskId);
	if (nReferId == 0) then
		return 0;
	end;
	local tbReferData	= self.tbReferDatas[nReferId];
	if (tbReferData) then
		return tbReferData.nReferIdx;
	end
	local tbTaskData	= self.tbTaskDatas[nTaskId];
	return #tbTaskData.tbReferIds;
end


-------------------------------------------------------------------------
-- 或得一個任務的名字
function Task:GetTaskName(nTaskId)
	if (not self.tbTaskDatas[nTaskId]) then
		self:LoadTask(nTaskId);
	end;
	
	return self.tbTaskDatas[nTaskId].szName;
end


-------------------------------------------------------------------------
-- 獲得一個任務的描述
function Task:GetTaskDesc(nTaskId)
	if (not self.tbTaskDatas[nTaskId]) then
		self:LoadTask(nTaskId);
	end;
	
	return self.tbTaskDatas[nTaskId].szDesc;
end


-------------------------------------------------------------------------
--獲得一個引用子任務名
function Task:GetManSubName(nReferId)
	return self.tbReferDatas[nReferId].szName;
end


-------------------------------------------------------------------------
--獲得一個引用子任務描述
function Task:GetManSubDesc(nReferId)
	return self.tbReferDatas[nReferId].tbDesc.szMainDesc;
end

-------------------------------------------------------------------------
-- 根據圖標索引得到圖標路徑
function Task:GetIconPath(nIconIndex)
	nIconIndex = tonumber(nIconIndex) or 1;
	nIconIndex = tonumber(nIconIndex);
	local szPath = KTask.GetIconPath(nIconIndex);
	if not szPath then
		szPath = "\\image\\ui\\001a\\tasksystem\\award\\item.spr"; -- 默認值
	end
	return szPath;
end


-------------------------------------------------------------------------
function Task:OnKillNpc(pPlayer, pNpc)
	local tbStudentList 	= {};
	local tbTeammateList 	= {};
	
	-- 隊友和徒弟(組隊的徒弟)計數
	local tbTeamMembers, nMemberCount	= pPlayer.GetTeamMemberList();	
	if (tbTeamMembers) then
		for i = 1, nMemberCount do
			if (pPlayer.nPlayerIndex ~= tbTeamMembers[i].nPlayerIndex) then
				if (tbTeamMembers[i].GetTrainingTeacher() == pPlayer.szName) then
					tbStudentList[#tbStudentList + 1] = tbTeamMembers[i];
				else
					tbTeammateList[#tbTeammateList + 1] = tbTeamMembers[i];
				end
			end
		end
	end
	
	self:OnKillNpcForCount(pPlayer, pNpc, tbStudentList, tbTeammateList);
	self:OnKillNpcForItem(pPlayer, pNpc, tbStudentList, tbTeammateList);
	self:OnKillBossForItem(pPlayer, pNpc, tbStudentList, tbTeammateList);
end


-- 殺怪計數
function Task:OnKillNpcForCount(pPlayer, pNpc, tbStudentList, tbTeammateList)
	-- 自己的和隊友的
	for _, tbMyTask in pairs(Task:GetPlayerTask(pPlayer).tbTasks) do
		for _, teammate in ipairs(tbTeammateList) do
			if (Task:AtNearDistance(pPlayer, teammate) == 1) then
				for _, tbTask in pairs(Task:GetPlayerTask(teammate).tbTasks) do
					if (tbMyTask.nReferId == tbTask.nReferId and (not tbMyTask.tbReferData.nShareKillNpc or tbMyTask.tbReferData.nShareKillNpc == 0)) then
						tbTask:OnKillNpcForCount(pPlayer, pNpc);
					end
				end
			end
		end
		
		tbMyTask:OnKillNpcForCount(pPlayer, pNpc);
	end
	
	for _, teammate in ipairs(tbTeammateList) do
		if (teammate.nMapId == pPlayer.nMapId) then
			for _, tbTask in pairs(Task:GetPlayerTask(teammate).tbTasks) do
				if (tbTask.tbReferData.nShareKillNpc == 1) then			
					tbTask:OnKillNpcForCount(pPlayer, pNpc);
				end
			end	
		end
	end
	
	-- 徒弟的
	for _, pStudent in ipairs(tbStudentList) do
		for _, tbTask in pairs(Task:GetPlayerTask(pStudent).tbTasks) do
			tbTask:OnKillNpcForCount(pPlayer, pNpc);
		end
	end
end

-- 殺怪獲物(自己需要的可以掉多個,別人的隻能掉一個)
function Task:OnKillNpcForItem(pPlayer, pNpc, tbStudentList, tbTeammateList)
	-- 自己和隊友的
	local nDropCount = 0;
	for _, tbMyTask in pairs(Task:GetPlayerTask(pPlayer).tbTasks) do
		if (tbMyTask:OnKillNpcForItem(pPlayer, pNpc) == 1) then
			nDropCount = nDropCount + 1;
		end
		for _, teammate in ipairs(tbTeammateList) do
			if (nDropCount > 0) then -- 保證不會因為隊友增多造成物品掉落增多
				break;
			end
			if (Task:AtNearDistance(pPlayer, teammate) == 1) then
				local tbTask = Task:GetPlayerTask(teammate).tbTasks[tbMyTask.nTaskId];
				if (tbTask) then
					if (tbMyTask.nReferId == tbTask.nReferId and (not tbMyTask.tbReferData.nShareKillNpc or tbMyTask.tbReferData.nShareKillNpc == 0)) then
						if (tbTask:OnKillNpcForItem(pPlayer, pNpc) == 1) then
							nDropCount = nDropCount + 1;
						end
					end
				end
			end
		end
	end
	
	for _, teammate in ipairs(tbTeammateList) do
		if (nDropCount > 0) then
			break;
		end

		for _, tbTask in pairs(Task:GetPlayerTask(teammate).tbTasks) do
			if (teammate.nMapId == pPlayer.nMapId) then
				if (tbTask.tbReferData.nShareKillNpc == 1) then			
					if (tbTask:OnKillNpcForItem(pPlayer, pNpc) == 1) then
						nDropCount = nDropCount + 1;
						break;
					end
				end
			end
		end
	end
	
	-- 徒弟的
	nDropCount = 0;
	for _, pStudent in ipairs(tbStudentList) do
		if (nDropCount > 0) then
			break;
		end
		for _, tbTask in pairs(Task:GetPlayerTask(pStudent).tbTasks) do
			if (tbTask:OnKillNpcForItem(pPlayer, pNpc) == 1) then
				nDropCount = nDropCount + 1;
			end
		end
	end
end

function Task:OnKillBossForItem(pPlayer, pNpc, tbStudentList, tbTeammateList)
	-- 自己的和隊友的
	for _, tbMyTask in pairs(Task:GetPlayerTask(pPlayer).tbTasks) do
		for _, teammate in ipairs(tbTeammateList) do
			if (Task:AtNearDistance(pPlayer, teammate) == 1) then
				for _, tbTask in pairs(Task:GetPlayerTask(teammate).tbTasks) do
					if (tbMyTask.nReferId == tbTask.nReferId and (not tbMyTask.tbReferData.nShareKillNpc or tbMyTask.tbReferData.nShareKillNpc == 0)) then
						tbTask:OnKillBossForItem(pPlayer, pNpc);
					end
				end
			end
		end
		tbMyTask:OnKillBossForItem(pPlayer, pNpc);
	end
	
	for _, teammate in ipairs(tbTeammateList) do
		if (teammate.nMapId == pPlayer.nMapId) then
			for _, tbTask in pairs(Task:GetPlayerTask(teammate).tbTasks) do
				if (tbTask.tbReferData.nShareKillNpc == 1) then			
					tbTask:OnKillBossForItem(pPlayer, pNpc);
				end
			end	
		end
	end
	
	
	-- 徒弟的
	for _, pStudent in ipairs(tbStudentList) do
		for _, tbTask in pairs(Task:GetPlayerTask(pStudent).tbTasks) do
			tbTask:OnKillBossForItem(pPlayer, pNpc);
		end
	end
end

-- 注冊離線事件
PlayerEvent:RegisterGlobal("OnLogout", Task.OnLogout, Task)

if (not Task.tbTrackTaskSet) then
	Task.tbTrackTaskSet = {};
end

if (not Task.tbTrackTaskSet) then
	Task.tbTrackTaskSet = {};
end

function Task:SendAward(nTaskId, nReferId, nSelIdx)
	KTask.SendAward(me, nTaskId, nReferId, nSelIdx);
end


-- C
function Task:OnRefresh(nTaskId, nReferId, nParam)
	local tbPlayerTask	= self:GetPlayerTask(me);
	if (nParam and nParam ~= 0) then
		local tbTask		= tbPlayerTask.tbTasks[nTaskId];
		if (not tbTask) then
			local tbReferData	= self.tbReferDatas[nReferId];
			local nSubTaskId	= tbReferData.nSubTaskId;
	
			if (not self.tbSubDatas[nSubTaskId]) then
				-- 任務鏈的任務特殊處理
				if self:GetTaskType(nSubTaskId) == "Task" then
					self:LoadSub(nSubTaskId);
				elseif self:GetTaskType(nSubTaskId) == "LinkTask" then
					--老包任務
					local tbTaskSub	= LinkTask.tbSubTaskData;
					LinkTask:_ReadSubTask(	nSubTaskId, 
											tbTaskSub[nSubTaskId].szTaskName, 
											tbTaskSub[nSubTaskId].szTargetName,
											tbTaskSub[nSubTaskId].tbParams);
				elseif self:GetTaskType(nSubTaskId) == "WantedTask" then
					--官府通緝任務
					local tbTaskSub	= Wanted.tbSubTaskData;
					Wanted:ReadSubTask(	nSubTaskId,
											tbTaskSub[nSubTaskId].szTaskName, 
											tbTaskSub[nSubTaskId].szTargetName,
											tbTaskSub[nSubTaskId].tbParams);
				end;
			end
			
			tbTask	= Task:NewTask(nReferId);
			if (self.tbTaskDatas[nTaskId].tbAttribute["AutoTrack"]) then
				self:OnTrackTask(nTaskId);
			end
		end
		
		tbTask:LoadData(nParam);
	elseif (tbPlayerTask.tbTasks[nTaskId]) then
		tbPlayerTask.tbTasks[nTaskId]:CloseCurStep("finish");
		tbPlayerTask.tbTasks[nTaskId] = nil;
		tbPlayerTask.nCount	= tbPlayerTask.nCount - 1;
	end
	
	CoreEventNotify(UiNotify.emCOREEVENT_TASK_REFRESH, nTaskId, nReferId, nParam);
end

function Task:OnTrackTask(nTaskId)
	CoreEventNotify(UiNotify.emCOREEVENT_TASK_TRACK, nTaskId);
end

function Task:ShowInfoBoard(szInfo)
	local szMsg = Lib:ParseExpression(szInfo);
	szMsg = Task:ParseTag(szMsg);
	CoreEventNotify(UiNotify.emCOREEVENT_TASK_SHOWBOARD, szMsg)
end

function Task:GetPlayerMainTask(pPlayer)
	local tbMainTaskLogData = {};
	local tbPlayerTasks = self:GetPlayerTask(pPlayer);
	for _, tbTask in pairs(tbPlayerTask.tbTasks) do
		if (tbTask.tbTaskData.tbAttribute.TaskType == 1) then
			local szTaskName = self:GetTaskName(tbTask.nTaskId);
			local szSubTaskName = self:GetManSubName(tbTask.nReferId);
			table.insert(tbMainTaskLogData, {szTaskName, szSubTaskName});
		end
	end

	return tbMainTaskLogData;
end


function Task:SharePickItem(pPlayer, pItem)
	local tbTeamMembers, nMemberCount	= pPlayer.GetTeamMemberList();
	if (not nMemberCount) then
		return;
	end

	for i = 1, nMemberCount do
		if (pPlayer.nPlayerIndex ~= tbTeamMembers[i].nPlayerIndex) then
			--if (Task:AtNearDistance(pPlayer, tbTeamMembers[i]) == 1) then
			if (pPlayer.nMapId == tbTeamMembers[i].nMapId) then
				Task:GetShareItem(tbTeamMembers[i], {pItem.nGenre, pItem.nDetail, pItem.nParticular, pItem.nLevel});
			end
		end
	end
end

function Task:GetShareItem(pPlayer, tbItem)
	Setting:SetGlobalObj(pPlayer)
	if (TaskCond:CanAddCountItemIntoBag(tbItem, 1)) then
		for _, tbTask in pairs(Task:GetPlayerTask(pPlayer).tbTasks) do
			if (tbTask:IsItemToBeCollect(tbItem) == 1) then
				Task:AddItem(pPlayer, tbItem);
				Setting:RestoreGlobalObj()
				return 1;
			end
		end		
	end
	
	Setting:RestoreGlobalObj()
end

function Task:CanAcceptRepeatTask()
	local nAcceptTime = me.GetTask(2031, 1);
	if (nAcceptTime >= self.nRepeatTaskAcceptMaxTime) then
		return 0;
	end
	
	return 1;
end

function Task:GetTaskType(nTaskId)
	local nTaskId = tonumber(nTaskId);
	if (nTaskId) then
		for ni, tbTask in pairs(self.tbTaskTypes) do
			if nTaskId >= tbTask.nFirstId and nTaskId <= tbTask.nLastId then
				return tbTask.szTaskType;
			end
		end
	end
	
	return "Task";
end

function Task:GetTaskTypeName(nTaskId)
	local nTaskId = tonumber(nTaskId);
	if (nTaskId) then
		for ni, tbTask in pairs(self.tbTaskTypes) do
			if nTaskId >= tbTask.nFirstId and nTaskId <= tbTask.nLastId then
				return tbTask.szTaskName;
			end
		end
	end
	
	return "Nhiệm vụ ngẫu nhiên";
end

function Task:IsInstancingTask(nTaskId)
	if (nTaskId == 219 or nTaskId == 220 or nTaskId == 224) then
		return 1;
	end
	
	return 0;
end

function Task:IsCommerceTask(nTaskId)
	if (nTaskId == 50000) then
		return 1;
	end
	
	return 0;
end

--============= 任務目標自動尋路 ====================

-- 從指定語句當中獲取
function Task:GetInfoFromSentence(szSource, szFormat)
	if (not szSource or not szFormat) then
		return;
	end
	local tbInfo = {};
	local s = 1;
	local e = 1;
	s, e = string.find(szSource, szFormat, 1);
	while (s and e and s ~= e) do
		local szSub = string.sub(szSource, s, e);
		s, e = string.find(szSource, szFormat, s + 1);
		table.insert(tbInfo, szSub);
	end
	return tbInfo;
end

-- 分析單條語句，返回改語句中的坐標信息
function Task:ParseSingleInfo(szDesc)
	if (not szDesc) then
		return;
	end
	local szFormat = "%<n?p?c?pos.-%>";				-- 模式匹配字符串，匹配"<" 和">" 之間的字符串
	local tbInfo = self:GetInfoFromSentence(szDesc, szFormat);
	if (not tbInfo or #tbInfo == 0) then
		return;
	end
	return tbInfo;
end

-- 獲取一個任務當中某個步驟的的坐標信息
function Task:GetPosInfo(szTaskName, nCurStep)
	if (not szTaskName or not nCurStep) then
		return;
	end
	if (not self.tbReferDatas or #self.tbReferDatas <= 0) then
		return;
	end
	for _, tbInfo in pairs(self.tbReferDatas) do
		if (tbInfo.szName == szTaskName and tbInfo.tbDesc and
			tbInfo.tbDesc.tbStepsDesc and
			tbInfo.tbDesc.tbStepsDesc[nCurStep]) then
			local szCurStepInfo = tbInfo.tbDesc.tbStepsDesc[nCurStep];
			return self:ParseSingleInfo(szCurStepInfo);
		end
	end
end

-- 尋找關鍵字，例如傳入參數是"<pos=紅娘,5,1633,2941>"
-- 返回值就是"紅娘"
function Task:FindKeyWord(szInfo)
	if (not szInfo) then
		return;
	end
	local s, e = string.find(szInfo, "=");
	if (not s or not e) then
		return;
	end
	local nBegin = e + 1;
	s, e = string.find(szInfo, ",", nBegin);
	if (not s or not e) then
		return;
	end
	local szKeyWord = string.sub(szInfo, nBegin, s - 1);
	if (not szKeyWord) then
		return;
	end
	
	return szKeyWord;
end

-- 在沒有找到匹配的時候進行替換
-- szSource "與白秋琳對話"
-- szReplace "<npcpos=秋姨,X,X>"
-- 結果 "<npcpos=與白秋琳對話,X,X>"
function Task:ReplaceWhileNoMatch(szSource, szReplace)
	if (not szSource or not szReplace) then
		return;
	end
	local szKeyWord = self:FindKeyWord(szReplace);
	if (not szKeyWord) then
		return;
	end
	return string.gsub(szReplace, szKeyWord, szSource);
end

function Task:GetFinalDesc(szDesc, tbPosInfo)
	if (not tbPosInfo) then
		return szDesc;
	end
	local nPosCount = #tbPosInfo;
	if (tbPosInfo and #tbPosInfo > 0) then
		for _, szPosInfo in pairs(tbPosInfo) do
			local szKeyWord = Task:FindKeyWord(szPosInfo);
			local s, e = string.find(szDesc, szKeyWord);
			if (s and e and s ~= e) then
				szDesc = string.gsub(szDesc, szKeyWord, szPosInfo);
			elseif (nPosCount == 1) then
				szDesc = Task:ReplaceWhileNoMatch(szDesc, szPosInfo) or szDesc;
			end
		end
	end
	return szDesc;
end
