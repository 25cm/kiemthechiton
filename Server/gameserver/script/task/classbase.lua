
--一個任務在玩家身上，類的形式
local tbClassBase	= {};
Task._tbClassBase	= tbClassBase;

function tbClassBase:GetName()
	return self.tbReferData.szName;
end;

-- 得到當前步驟 
function tbClassBase:GetCurStep()
	return self.tbSubData.tbSteps[self.nCurStep];
end;

-- 看這個Npc身上有沒有對話(tbNpcMenu)如果有的話就添加選項，否則返回nil
function tbClassBase:AppendNpcMenu(nNpcTempId, tbOption, pNpc)
	local tbNpcMenuData	= self.tbNpcMenus[nNpcTempId];
	
	if (not tbNpcMenuData) then
		return nil;
	end
	
	if (pNpc.nMapId ~= tbNpcMenuData.nMapId and tbNpcMenuData.nMapId ~= 0) then
		return nil;
	end
	
	local tbNpcMenu = tbNpcMenuData.tbCallBack;
	
	assert(type(tbNpcMenu[1]) == "string" );
	
	if (tbOption) then
		tbOption[#tbOption + 1]	= tbNpcMenu;
	end;
	
	return 1;
end;


function tbClassBase:CheckTaskOnNpc()
	if (self.tbNpcMenus[him.nTemplateId] and ((him.nMapId == self.tbNpcMenus[him.nTemplateId].nMapId) or self.tbNpcMenus[him.nTemplateId].nMapId == 0)) then
		return 1;
	end
	
	return nil;
end


function tbClassBase:OnExclusiveDialogNpc(nNpcTempId)
	local tbDialogTrigger = self.tbNpcExclusiveDialogs[nNpcTempId];
	if (not tbDialogTrigger) then
		return nil;
	end
	Lib:CallBack(tbDialogTrigger);
end

-- 物品觸發
function tbClassBase:OnTaskItem(nParticular)
	local tbItemUse	= self.tbItemUse[nParticular];
	if (not tbItemUse) then
		return nil;
	end;
	Lib:CallBack(tbItemUse);
	return 1;
end;

-- 完成一個目標的時候執行，她判斷是否事件為自動觸發，若是則執行下一步驟。
function tbClassBase:OnFinishOneTag()
	local tbStep	= self:GetCurStep();
	if (not tbStep) then
		return "None.";
	end;

	if (tbStep.tbEvent.nType == 3) then
		assert(self.nCurStep > 0);
		for _, tbCurTag in ipairs(self.tbCurTags) do
			if (not tbCurTag:IsDone()) then
				return;
			end;
		end;
	
		self:GoNextStep();
	end
end;


function tbClassBase:Active()
	for _, tbCurTag in ipairs(self.tbCurTags) do
		if (not tbCurTag:IsDone()) then
			return;
		end
	end
	local bOK, szMsg	= self:IsCurStepDone();
	if (not bOK) then
		Dialog:SendInfoBoardMsg(self.me, szMsg);
		return nil;
	end;

	self:GoNextStep()
	
	return 1;
end;

function tbClassBase:IsCurStepDone()
	local tbStep	= self:GetCurStep();
	if (not tbStep) then
		return nil;
	end;
	if (not tbStep.tbJudge) then
		return 1;
	end;
	return Lib:DoTestFuncs(tbStep.tbJudge);
end;

function tbClassBase:GoNextStep()
	assert(self.nCurStep > 0);
	for _, tbCurTag in ipairs(self.tbCurTags) do
		if (not tbCurTag:IsDone()) then
			Dialog:SendInfoBoardMsg(self.me, "Mục tiêu chưa hoàn thành:"..tbCurTag:GetStaticDesc());
			return;
		end;
	end;
	local tbStep	= self:GetCurStep();
	local tbStepEvent = tbStep.tbEvent;
	if (tbStepEvent.nType == 2) then
		local tbItemId = {20,1,tbStepEvent.nValue,1};
		if (not Task:DelItem(self.me, tbItemId, 1)) then
			self.me.Msg("Vật phẩm chỉ định không tồn tại!")
			return nil;
		end
	end
		
	
	if (tbStep.tbExecute) then
		local oldPlayer = me;
		me = self.me;
		
		Lib:DoExecFuncs(tbStep.tbExecute, self.nTaskId);
		me = oldPlayer;
	end;
	self:CloseCurStep("finish");
	self.me.Msg("Hoàn thành.");
	self.me.CastSkill(Task.nFinishStepSkillId,1,-1, self.me.GetNpc().nIndex);
	
	if self.nTaskId == Merchant.TASKDATA_ID then
		local nCount = Merchant:GetTask(Merchant.TASK_STEP_COUNT);
		-- 記Log
		if nCount == 20 then
			-- KStatLog.ModifyAdd("mixstat", "商會完成20次人數", "總量", 1);
		elseif nCount % 100 == 0 then
			-- KStatLog.ModifyAdd("mixstat", "商會完成"..nCount.."次人數", "總量", 1);			
		end
		if nCount < Merchant.TASKDATA_MAXCOUNT then
			Merchant:SyncTaskExp();
			Merchant:OnAccept();
			self:SetCurStep(self.nCurStep);
		else
			--強制刷新獎勵
			Merchant:SyncTaskExp();
			self:SetCurStep(self.nCurStep + 1);			
			Merchant:FinishTask()
		end
	else
		self:SetCurStep(self.nCurStep + 1);
	end	
	return 1;
end;

-- 設置當前步驟，包括當前目標
function tbClassBase:SetCurStep(nStep, bLoading)
	local oldPlayer = me;
	me = self.me;
	local tbCurTags	= {};
	self.tbCurTags	= tbCurTags;
	self.tbNpcMenus	= {}; --下標為Npc模板Id
	self.tbNpcExclusiveDialogs = {};
	self.tbItemUse	= {};
	self.tbCollectList = {};
	self.nCurStep		= nStep;
	local tbStep		= self:GetCurStep();
	if (tbStep) then --還有步驟，說明還沒有做完此任務
		local tbStepDesc	= self.tbReferData.tbDesc.tbStepsDesc;
		local szStepDesc		= nil;
		if (tbStepDesc and tbStepDesc[nStep]) then
			szStepDesc = tbStepDesc[nStep];
		end

		local tbEvent	= tbStep.tbEvent;
		if (tbEvent.nType == 1) then --如果觸發為npc
			self:AddNpcMenu(tbEvent.nValue, 0, self:GetName(),
				TaskAct.Talk, TaskAct, {self.GetNpcDialog, self},
				Task.Active, Task, self.nTaskId, self.nReferId, nStep);
		elseif (tbEvent.nType == 2) then --如果觸發為Item
			self:AddItemUse(tbEvent.nValue,
				Task.Active, Task, self.nTaskId, self.nReferId, nStep);
		end;
		local nSaveLen	= 5; --保存的長度從5開始，之前4個為任務Id,引用子任務Id,當前步驟，接任務時間

		for i, tbTarget in ipairs(tbStep.tbTargets) do
			local tbCurTag	= Lib:NewClass(tbTarget); -- 目標的第2次派生，第一次見loadfile.lua
			tbCurTags[i]	= tbCurTag;
			tbCurTag.tbTask	= self;
			tbCurTag.me		= self.me;
			if (bLoading) then
				nSaveLen	= nSaveLen + tbCurTag:Load(self.nSaveGroup, nSaveLen); -- 一個步驟中的所有目標是固定的，所以nSaveLen會對應到指定目標
			else
				tbCurTag:Start();
			end;
		end;
		
	else -- 步驟已經全部完成
		self.nCurStep	= -1;
		
		--商會加載最終經驗獎勵
		if self.nTaskId == Merchant.TASKDATA_ID then
			Merchant:SyncTaskFixAward();
		end
		
		
		if (MODULE_GAMESERVER and not bLoading) then
			--local tbAwards	= self.tbReferData.tbAwards;
			local tbAwards = Task:GetAwards(self.nReferId); -- 如果沒有獎勵則直接算完成任務
			if (not (tbAwards.tbOpt[1] or tbAwards.tbRand[1] or tbAwards.tbFix[1])) then
				Task:SetFinishedRefer(self.nTaskId, self.nReferId);
				Task:CloseTask(self.nTaskId, "finish");
				me = oldPlayer;
				return;
			end;
		end;
		local szMsg = "";
		if (self.tbSubData.tbAttribute.tbDialog.Prize.szMsg) then -- 未分步驟
			szMsg = self.tbSubData.tbAttribute.tbDialog.Prize.szMsg;
		else
			szMsg = self.tbSubData.tbAttribute.tbDialog.Prize.tbSetpMsg[1];
		end
				
		local tbAwardCall	= {
			TaskAct.TalkInDark, TaskAct,
			szMsg,
			KTask.SendAward, self.me, self.nTaskId, self.nReferId,
		};
		if (MODULE_GAMESERVER and not bLoading) then
			if (TaskCond:HaveBagSpace(self.tbReferData.nBagSpaceCount)) then
				Lib:CallBack(tbAwardCall);
			else
				Dialog:SendInfoBoardMsg(self.me, "Thu xếp túi còn "..self.tbReferData.nBagSpaceCount.." ô trống rồi đến lãnh thưởng!");
			end
		end;
		
		if (not self.tbReferData.nReplyNpcId or self.tbReferData.nReplyNpcId <= 0) then
			local tbEvent	= self.tbSubData.tbSteps[#self.tbSubData.tbSteps].tbEvent;
			if (tbEvent.nType == 1) then
				self:AddNpcMenu(tbEvent.nValue, 0, self:GetName().."- Nhận thưởng", unpack(tbAwardCall));
			else
				assert(false or "Không có nơi lãnh thưởng!");
			end
		else
			self:AddNpcMenu(self.tbReferData.nReplyNpcId, 0, self:GetName().."- Nhận thưởng", unpack(tbAwardCall));
		end

	end;

	if (MODULE_GAMESERVER) then
		if (not bLoading) then
			self:SaveData();
		end;
		self.me.SyncTaskGroup(self.nSaveGroup);
		KTask.SendRefresh(self.me, self.nTaskId, self.nReferId, self.nSaveGroup);
		if (not bLoading and self.nCurStep > 0) then
			self:OnFinishOneTag();
		end
	end;
	
	
	me = oldPlayer;
end;

function tbClassBase:CloseCurStep(szReason)
	for i, tbCurTag in ipairs(self.tbCurTags) do
		tbCurTag:Close(szReason);
	end;
	
	self.tbCurTags	= {};
	self.tbNpcMenus	= {};
	self.tbItemUse	= {};
	self.tbCollectList = {};
	self.tbNpcExclusiveDialogs = {};
end;


function tbClassBase:SaveData()
	self.me.SetTask(self.nSaveGroup, Task.emSAVEID_TASKID, self.nTaskId);
	self.me.SetTask(self.nSaveGroup, Task.emSAVEID_REFID, self.nReferId);
	self.me.SetTask(self.nSaveGroup, Task.emSAVEID_CURSTEP, self.nCurStep);
	self.me.SetTask(self.nSaveGroup, Task.emSAVEID_ACCEPTDATA, self.nAcceptDate);
	local nSaveLen	= 5;
	for _, tbCurTag in ipairs(self.tbCurTags) do
		nSaveLen	= nSaveLen + tbCurTag:Save(self.nSaveGroup, nSaveLen);
	end;
end;


-- 載入玩家指定任務組的數據
function tbClassBase:LoadData(nSaveGroup)
	Merchant:LoadDate(self.nTaskId)
	self.nSaveGroup		= nSaveGroup;
	self.nAcceptDate	= self.me.GetTask(nSaveGroup, Task.emSAVEID_ACCEPTDATA);
	self:SetCurStep(self.me.GetTask(nSaveGroup,Task.emSAVEID_CURSTEP), 1); -- 1標識為Load
	
	-- 遍歷玩家所有任務目標
	if (MODULE_GAMESERVER) then
		for i, tbCurTag in ipairs(self.tbCurTags) do
			if (tbCurTag:IsDone()) then
				self:OnFinishOneTag();
				break;
			end
		end;
	end

end;


function tbClassBase:AddNpcMenu(nNpcTempId, nMapId, szOption, ...)
	if (not nMapId) then
		nMapId = 0;
	end
	Task:DbgOut("AddNpcMenu", nNpcTempId, nMapId, szOption)
	assert(not self.tbNpcMenus[nNpcTempId], "too many Target on npc:"..nNpcTempId);--對一個任務來說，應該不會存在多個選項在同一個Npc身上
	-- 替換任務名關鍵字
	szOption = string.gsub(szOption, "<taskname>", self.tbTaskData.szName);
	szOption = string.gsub(szOption, "<subtaskname>", self.tbReferData.szName);
	self.tbNpcMenus[nNpcTempId]	= {tbCallBack = {"[Nhiệm vụ] "..szOption, unpack(arg)}, nMapId = nMapId};
end;

function tbClassBase:AddExclusiveDialog(nNpcTempId ,...)
	Task:DbgOut("AddNpcExclusiveDialog", nNpcTempId)
	assert(not self.tbNpcExclusiveDialogs[nNpcTempId], "too many ExclusiveDialog on npc:"..nNpcTempId);
	self.tbNpcExclusiveDialogs[nNpcTempId] = {unpack(arg)};
end

-- 隻能是任務物品
function tbClassBase:AddItemUse(nTaskItemId, ...)
	assert(not self.tbItemUse[nTaskItemId], "too many Target on item:"..nTaskItemId);
	self.tbItemUse[nTaskItemId]	= {unpack(arg)};
end;

function tbClassBase:RemoveNpcMenu(nNpcTempId)
	self.tbNpcMenus[nNpcTempId]	= nil;
end;
	
function tbClassBase:RemoveNpcExclusiveDialog(nNpcTempId)
	self.tbNpcExclusiveDialogs[nNpcTempId] = nil;
end

function tbClassBase:RemoveItemUse(nParticular)
	self.tbItemUse[nParticular] = nil;
end;


-- 去一個步驟結束Npc那裡的對話
function tbClassBase:GetNpcDialog()
	local tbStep = self:GetCurStep();
	if (not tbStep) then
		Dbg:WriteLog("[UNKNOWBUG]", "TaskClassBase", "GetNpcDialog", "Can't Find CurStep", self.nCurStep or "UnKnowSetp");
		return nil;
	end

	local szMsg = nil;
	
	-- 1.目標沒達成：過程對白
	for _, tbCurTag in ipairs(self.tbCurTags) do
		if (not tbCurTag:IsDone()) then
			if (self.tbSubData.tbAttribute.tbDialog.Procedure.szMsg) then -- 未分步驟
				szMsg = self.tbSubData.tbAttribute.tbDialog.Procedure.szMsg;
			else -- 分了步驟
				szMsg = self.tbSubData.tbAttribute.tbDialog.Procedure.tbSetpMsg[self.nCurStep];
			end
			
			return szMsg;
		end;
	end;
	

	-- 2.目標達成，條件沒達成：出錯對白
	local bOK, _  = self:IsCurStepDone();
	if (not bOK) then
		if (self.tbSubData.tbAttribute.tbDialog.Error.szMsg) then -- 未分步驟
			szMsg = self.tbSubData.tbAttribute.tbDialog.Error.szMsg;
		else -- 分了步驟
			szMsg = self.tbSubData.tbAttribute.tbDialog.Error.tbSetpMsg[self.nCurStep];
		end
		return szMsg
	end


	-- 3.目標和條件均達成：結束對白
	if (self.tbSubData.tbAttribute.tbDialog.End.szMsg) then -- 未分步驟
		szMsg = self.tbSubData.tbAttribute.tbDialog.End.szMsg;
	else -- 分了步驟
		szMsg = self.tbSubData.tbAttribute.tbDialog.End.tbSetpMsg[self.nCurStep];
	end
			
	return szMsg;	
end


-------------------------------------------------------------------------
-- 一個玩家殺死Npc有多種分享策略

function tbClassBase:OnKillNpcForCount(pPlayer, pNpc)
	for _, tbCurTag in ipairs(self.tbCurTags) do
		if (tbCurTag.OnKillNpc) then
			tbCurTag:OnKillNpc(pPlayer, pNpc);
		end
	end;
end


function tbClassBase:OnKillNpcForItem(pPlayer, pNpc)
	local bDrop = 0;
	for _, tbCurTag in ipairs(self.tbCurTags) do
		if (tbCurTag.OnKillNpcDropItem) then
			if (tbCurTag:OnKillNpcDropItem(pPlayer, pNpc) == 1) then
				bDrop = 1;
			end
		end
	end
	
	return bDrop;
end

function tbClassBase:OnKillBossForItem(pPlayer, pNpc)
	for _, tbCurTag in ipairs(self.tbCurTags) do
		if (tbCurTag.OnShareBossItem) then
			tbCurTag:OnShareBossItem(pPlayer, pNpc);
		end
	end;
end

function tbClassBase:AddInCollectList(tbItem)
	self.tbCollectList[#self.tbCollectList + 1] =  tbItem;
end

function tbClassBase:RemoveInCollectList(tbItem)
	local nRemoveIndex = -1;
	for i=1, #self.tbCollectList do
		if (Task:IsSameItem(tbItem, self.tbCollectList[i]) == 1) then
			nRemoveIndex = i;
			break;
		end
	end
	
	if (nRemoveIndex > 0) then
		table.remove(self.tbCollectList, nRemoveIndex);
	else
		assert(false);
	end
end

function tbClassBase:IsItemToBeCollect(tbItem)
	for _, item in ipairs(self.tbCollectList) do
		if (tbItem[1] == item[1] and
			tbItem[2] == item[2] and
			tbItem[3] == item[3] and
			tbItem[4] == item[4]) then
				return 1;
			end
	end
	
	return 0;
end
