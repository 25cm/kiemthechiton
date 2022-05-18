
-------------------------------------------------------------------------
-- 關於進度條目標
function Task:GetProgressData()
	local tbPlayerData				= me.GetTempTable("Task");
	local tbPlayerProgressTagData	= tbPlayerData.tbProgressTagData;
	if (not tbPlayerProgressTagData) then
		tbPlayerProgressTagData	= {};
		tbPlayerData.tbProgressTagData	= tbPlayerProgressTagData;
	end;
	
	return tbPlayerProgressTagData;
end


function Task:SetProgressTag(tbTag, pPlayer)
	local oldPlayer = me;
	me = pPlayer;
	local tbPlayerProgressTagData = self:GetProgressData();
	tbPlayerProgressTagData.tbTag = tbTag;
	me = oldPlayer;
end;

function Task:OnProgressTagFinish()
	local tbPlayerProgressTagData = self:GetProgressData();
	tbPlayerProgressTagData.tbTag.OnProgressFull(tbPlayerProgressTagData.tbTag);
	tbPlayerProgressTagData.tbTag = nil;
end


-------------------------------------------------------------------------
-- 關於給予物品目標
Task.GiveItemTag = Task.GiveItemTag or {};
Task.GiveItemTag.tbGiveForm = Gift:New();

local tbGiveForm = Task.GiveItemTag.tbGiveForm;

tbGiveForm._szTitle = "Cho vật phẩm vào";



function tbGiveForm:GetGiveFormData()
	local tbPlayerData				= me.GetTempTable("Task");
	local tbPlayerGiveFormData	= tbPlayerData.tbGiveFormData;
	if (not tbPlayerGiveFormData) then
		tbPlayerGiveFormData	= {};
		tbPlayerData.tbGiveFormData	= tbPlayerGiveFormData;
	end;
	
	return tbPlayerGiveFormData;
end


function tbGiveForm:SetRegular(tbTag, pPlayer)
	self._szContent = tbTag.szDesc or "Cho vật phẩm";
	pPlayer.CallClientScript({"Gift:SetContent", self._szContent})
	local oldMe = me;
	me = pPlayer;
	local tbPlayerGiveFormData = self:GetGiveFormData();
	tbPlayerGiveFormData.tbTag = tbTag;
	me = oldMe
end


function tbGiveForm:OnOK()
	local nTotalNeed = 0;
	local tbTag = self:GetGiveFormData().tbTag;
	
	--商會任務判斷 特殊處理
	if tbTag.tbTask.nTaskId == Merchant.TASKDATA_ID then
		local _, _, nItemFree = Merchant:GetStepAward(Merchant:GetTask(Merchant.TASK_STEP_COUNT), 0)
		if me.CountFreeBagCell() < nItemFree then
			Dialog:Say("Xin lỗi! Túi không đủ chỗ trống! Sắp sếp lại rồi hãy giao nhiệm vụ để nhận thưởng!");
			return 0;
		end
	end
		
	--按名字和魔法屬性
	if tbTag.szTargetName == "GiveItemWithName" then
		tbTag.ItemList.nRemainCount = tbTag.ItemList[3];
		nTotalNeed = tbTag.ItemList[3];
		
		-- 遍歷判斷給與界面中每個格子的物品
		local nFormItemCount = 0;
		local pFind = self:First();
		while pFind do
			nFormItemCount = nFormItemCount + pFind.nCount;
			tbTag.ItemList.nRemainCount = self:DecreaseItemInListWithName(pFind, tbTag.ItemList) - pFind.nCount;
			pFind = self:Next();
		end
		if (nFormItemCount ~= nTotalNeed) then
			tbTag.me.Msg("Số vật phẩm không đúng!")
			return;
		end
		if (tbTag.ItemList.nRemainCount ~= 0) then
			tbTag.me.Msg("Vật phẩm không đạt yêu cầu!")
			return;
		end	
	else
	
		-- 把 table 裡每個物品的數量等同於原始的數量，並計算總數量
		for i=1, #tbTag.ItemList do
			tbTag.ItemList[i].nRemainCount = tbTag.ItemList[i][6];
			nTotalNeed = nTotalNeed + tbTag.ItemList[i][6];
		end
	
		-- 遍歷判斷給與界面中每個格子的物品
		local nFormItemCount = 0;
		local pFind = self:First();
		while pFind do
			nFormItemCount = nFormItemCount + pFind.nCount;
			self:DecreaseItemInList(pFind, tbTag.ItemList);
			pFind = self:Next();
		end
		if (nFormItemCount ~= nTotalNeed) then
			tbTag.me.Msg("Số vật phẩm không đúng!")
			return;
		end
		for _,tbItem in ipairs(tbTag.ItemList) do
			if (tbItem.nRemainCount ~= 0) then
				tbTag.me.Msg("Vật phẩm không đạt yêu cầu!")
				return;
			end
		end
	end
	-- 刪除物品
	local pFind = self:First();
	while pFind do
		tbTag.me.DelItem(pFind, Player.emKLOSEITEM_TYPE_TASKUSED);
		pFind = self:Next();
	end
	
	--設置目標成功
	tbTag.OnFinish(tbTag);
end;

-- 判斷指定物品是否在靠標物品列表中，若在則把數量 -1(通過物品GDPL)
function tbGiveForm:DecreaseItemInList(pFind, tbItemList)
	for _,tbItem in ipairs(tbItemList) do
		if (tbItem[1] == pFind.nGenre and 
			tbItem[2] == pFind.nDetail and 
			tbItem[3] == pFind.nParticular and 
			(tbItem[4] == pFind.nLevel or tbItem[4] == -1) and 
			(tbItem[5] == pFind.nSeries or tbItem[5] == -1)) then
				tbItem.nRemainCount = tbItem.nRemainCount - pFind.nCount;
				return 1;
		end
	end
	
	return 0;
end

-- 判斷指定物品是否在靠標物品列表中，若在則把數量 -1(通過物品名)
function tbGiveForm:DecreaseItemInListWithName(pFind, tbItemList)
	if (tbItemList[1] == pFind.szOrgName and 
		tbItemList[2] == pFind.szSuffix) then
			return pFind.nCount;
	end
	return 0;
end

-------------------------------------------------------------------------
-- 根據地圖ID獲得地圖名字
function Task:GetMapName(nMapId)
	if (not nMapId or nMapId <= 0) then
		return "";
	end
		return GetMapNameFormId(nMapId);
end


------------ 以下函數可能不應該屬於任務系統，暫時放在這裡

-- 取得物品擁有數量
function Task:GetItemCount(pPlayer, tbItemId, nRoom)
	if (not nRoom) then
		local tbItemList;
		if (not tbItemId[5] or tbItemId[5] < 0) then
			tbItemList = self:GetPlayerItemList(pPlayer, {tbItemId[1], tbItemId[2], tbItemId[3], tbItemId[4]});
		else
			tbItemList = self:GetPlayerItemList(pPlayer, {tbItemId[1], tbItemId[2], tbItemId[3], tbItemId[4], tbItemId[5]});
		end
		local nCount = 0;
		for i = 1, #tbItemList do
			nCount = nCount + tbItemList[i].nCount;
		end
		return nCount;
	else
		return pPlayer.GetItemCount(nRoom, {tbItemId[1], tbItemId[2], tbItemId[3], tbItemId[4]});
	end
end;


-- 刪除物品
function Task:DelItem(pPlayer, tbItemId, nDelCount)
--	assert(tbItemId[1] == 20);
	if (not nDelCount) then
		nDelCount	= 1;
	end;
	
	assert(type(nDelCount) == "number");
		
	local tbItemList = self:GetPlayerItemList(pPlayer, tbItemId);
	local i = 1;
	while (nDelCount >= 1 ) do
		if (not tbItemList[i]) then
			return;
		end
		local nItemCount = tbItemList[i].nCount;
		if (nItemCount <= 0) then
			return 0;
		end
		if (nItemCount > nDelCount) then
			tbItemList[i].SetCount(nItemCount - nDelCount);
			break;
		else
			nDelCount = nDelCount - nItemCount;
			tbItemList[i].Delete(pPlayer);
		end
		i = i + 1;
	end
	
	return 1;
end;

-- 獲得玩家指定物品列表
function Task:GetPlayerItemList(pPlayer, tbItemId)
	local tbItemList = {};
	local tbNeedSearchRoom = {
			Item.ROOM_EQUIP,
			Item.ROOM_EQUIPEX,
			Item.ROOM_MAINBAG,		-- 主背包
			Item.ROOM_REPOSITORY,	-- 貯物箱
			Item.ROOM_EXTBAG1,		-- 擴展背包1
			Item.ROOM_EXTBAG2,		-- 擴展背包2
			Item.ROOM_EXTBAG3,		-- 擴展背包3
			Item.ROOM_EXTREP1,		-- 擴展貯物箱1
			Item.ROOM_EXTREP2,		-- 擴展貯物箱2
			Item.ROOM_EXTREP3,		-- 擴展貯物箱3
			Item.ROOM_EXTREP4,		-- 擴展貯物箱4
			Item.ROOM_EXTREP5,		-- 擴展貯物箱5
		};
	for _,room in pairs(tbNeedSearchRoom) do
		local tbRoomItemList = pPlayer.FindItem(room, tbItemId[1], tbItemId[2], tbItemId[3], tbItemId[4], tbItemId[5] or 0);
		for _, item in ipairs(tbRoomItemList) do
			tbItemList[#tbItemList + 1] = item.pItem;
		end
	end	
	
	return tbItemList;
end

function Task:IsSameItem(tbItem1, tbItem2)
	if (tbItem1[1] ~= tbItem2[1] or 
		tbItem1[2] ~= tbItem2[2] or 
		tbItem1[3] ~= tbItem2[3] or 
		tbItem1[4] ~= tbItem2[4] or 
		tbItem1[5] ~= tbItem2[5]) then
		
		return 0;
	end
	
	return 1;
end

-- 解析字符串<npc=xxx><playername>
function Task:ParseTag(szMsg)
	local nCurIdx = 1;
	while true do
		local nNpcTagStart, nNpcIdStart	= string.find(szMsg, "<npc=");
		local nNpcTagEnd, nNpcIdEnd			= string.find(szMsg, ">", nNpcIdStart);
		local nNpcTempId = -1;
		if (not nNpcIdStart or not nNpcIdEnd) then
			break;
		end
		local nNpcTempId 		= tonumber(string.sub(szMsg, nNpcIdStart+1, nNpcIdEnd-1));
		
		if (nNpcTempId) then
			local szNpcName = KNpc.GetNameByTemplateId(nNpcTempId);
			szMsg = Lib:ReplaceStrFormIndex(szMsg, nNpcTagStart, nNpcTagEnd, szNpcName);
		end
		nCurIdx = nNpcTagStart + 1; --不能是nNpcIdEnd + 1,因為字符串被替換了 
	end
	
	szMsg = Lib:ReplaceStr(szMsg, "<playername>", "<color=Gold>"..me.szName.."<color>");
	
	return szMsg;
end



-------------------------------------------------------------------------
--新人直接得到新手任務任務
function Task:OnAskBeginnerTask()
	local bFresh = me.GetTask(Task.nFirstTaskValueGroup, Task.nFirstTaskValueId);
	if (bFresh ~= 1) then
		me.SetTask(Task.nFirstTaskValueGroup, Task.nFirstTaskValueId, 1, 1);
		local tbTaskData	= Task.tbTaskDatas[Task.nFirstTaskId];
		
		if (tbTaskData) then
			local nReferId 		= tbTaskData.tbReferIds[1];
			local nSubTaskId	= Task.tbReferDatas[nReferId].nSubTaskId;
			local tbSubData		= Task.tbSubDatas[nSubTaskId];
			
			local szMsg = "";
			if (tbSubData.tbAttribute.tbDialog.Start.szMsg) then -- 未分步驟
					szMsg = tbSubData.tbAttribute.tbDialog.Start.szMsg;
			else
					szMsg = tbSubData.tbAttribute.tbDialog.Start.tbSetpMsg[1];
			end

			TaskAct:TalkInDark(szMsg,Task.AskAccept, Task, Task.nFirstTaskId, nReferId);
		else
			print("Nhiệm vụ tân thủ không tồn tại!")
		end
	end
end


-------------------------------------------------------------------------
-- 判斷兩個玩家是否是近距離
function Task:AtNearDistance(pPlayer1, pPlayer2)
	local nMapId1, nPosX1, nPosY1 = pPlayer1.GetWorldPos();
	local nMapId2, nPosX2, nPosY2 = pPlayer2.GetWorldPos();
	
	if (nMapId1 == nMapId2) then
		local nMyR	= ((nPosX1-nPosX2)^2 + (nPosY1-nPosY2)^2)^0.5;
		if (nMyR < self.nNearDistance) then
			return 1;
		end;
	end;
end

-------------------------------------------------------------------------
-- 增加玩家心得
function Task:AddInsight(nInsightNumber)
	PlayerEvent:OnEvent("OnAddInsight", nInsightNumber);
end


function Task:AddItems(pPlayer, tbItemId, nCount)
	if (nCount <= 0) then
		return;
	end
	
	for i = 1, nCount do
		Task:AddItem(pPlayer, tbItemId);
	end
end

-- 加物品
function Task:AddItem(pPlayer, tbItemId)
	local tbItemInfo = {};
	tbItemInfo.nSeries		= Env.SERIES_NONE;
	tbItemInfo.nEnhTimes	= 0;
	tbItemInfo.nLucky		= tbItemId[6];
	tbItemInfo.tbGenInfo	= nil;
	tbItemInfo.tbRandomInfo	= nil;
	tbItemInfo.nVersion		= 0;
	tbItemInfo.uRandSeed	= 0;
	tbItemInfo.bForceBind	= self:IsNeedBind(tbItemId);
	
	local nWay = Player.emKITEMLOG_TYPE_FINISHTASK;
	local pItem = pPlayer.AddItemEx(tbItemId[1], tbItemId[2], tbItemId[3], tbItemId[4], tbItemInfo, nWay);
	
	if (not pItem) then
		print("Thêm vật phẩm thất bại", "Name: "..pPlayer.szName.."..\n", unpack(tbItemId))		
		return;
	end
	
	if (pItem.szClass == "insightbook") then
		pItem.SetGenInfo(1, pPlayer.nLevel);
		pItem.SetCustom(Item.CUSTOM_TYPE_MAKER, pPlayer.szName);		-- 記錄制造者名字
		pItem.Sync();
	end
	
	return pItem;
end;


function Task:AddObjAtPos(pPlayer, tbItemId, nMapIdx, nPosX, nPosY)
	local tbParam = {};
	tbParam[1] = tbItemId[1];
	tbParam[2] = tbItemId[2];
	tbParam[3] = tbItemId[3];
	tbParam[4]	= tbItemId[4];
	if (tbParam[4] == 0) then
		tbParam[4] = 1;
	end
	tbParam[5] = tbItemId[5];
	if (tbParam[5] < 0) then
		tbParam[5] = 0;
	end
	tbParam[7] = tbItemId[6];
	tbParam[6] = 0;
	tbParam[8] = pPlayer.nPlayerIndex;
	tbParam[9] = nMapIdx;
	tbParam[10] = nPosX;
	tbParam[11] = nPosY;
	AddObjAtPos(unpack(tbParam));
end

function Task:IsNpcExist(dwNpcId, tb)
	if (not dwNpcId) then
		return 0;
	end
	
	local pNpc = KNpc.GetById(dwNpcId);
	if (not pNpc) then
		return 0;
	end
	
	return 1;
end

-------------------------------------------------------------------------
-- 以下函數為臨時添加用於測試
-------------------------------------------------------------------------
function Task:SetStep(nTaskId, nStep)
	if (type(nTaskId) == "string") then
		nTaskId = tonumber(nTaskId, 16);
	end
	
	local tbPlayerTask	= self:GetPlayerTask(me);
	local tbTask	= tbPlayerTask.tbTasks[nTaskId];
	if (not tbTask) then
		return nil;
	end;
	tbTask:CloseCurStep("finish");
	tbTask:SetCurStep(nStep);
end


-------------------------------------------------------------------------
-- 獲取目前正在進行的任務數目
function Task:GetMyRunTaskCount()
	local tbPlayerTask = self:GetPlayerTask(me);
	return tbPlayerTask.nCount;
end


-------------------------------------------------------------------------
-- 獲取當前可接任務，不包括物品觸發任務
function Task:GetCanAcceptTaskCount()
	local nCanAcceptCount = 0;
	local tbPlayerTasks	= self:GetPlayerTask(me).tbTasks;
	for _, tbTaskData in pairs(self.tbTaskDatas) do
		if (not tbPlayerTasks[tbTaskData.nId]) then
			local nReferIdx		= self:GetFinishedIdx(tbTaskData.nId) + 1;			-- +1表示將要繼續的任務
			local nReferId		= tbTaskData.tbReferIds[nReferIdx];
			if (nReferId) then				
				local tbReferData	= self.tbReferDatas[nReferId];
				local tbAccept	= tbReferData.tbAccept;
				local tbVisable = tbReferData.tbVisable
				local nTaskType = tbTaskData.tbAttribute.TaskType;
				if (Lib:DoTestFuncs(tbVisable) and Lib:DoTestFuncs(tbAccept) and  (nTaskType == 1 or nTaskType == 2)) then	-- 滿足可見和可接條件
					nCanAcceptCount = nCanAcceptCount + 1;	
				end
			end
		end
	end
	
	return nCanAcceptCount;
end


-- 獲得當前可接的最小等級的引用子任務數據
function Task:GetMinCanAcceptRefDataList(pPlayer, nTaskType)
	if (not nTaskType) then
		nTaskType = Task.emType_Main;
	end
	
	return self:GetCanAcceptRefDataList(pPlayer, 1, 2);
end

-- 0 All
-- 1 Max
-- 2 Min
function Task:GetCanAcceptRefDataList(pPlayer, nTaskType, nLevelType)
	if (not nTaskType) then
		nTaskType = Task.emType_Main;
	end
	
	local tbRefSubDataList = {};
	local nLevel = nil;
	local tbPlayerTasks	= self:GetPlayerTask(pPlayer).tbTasks;
	for _, tbTaskData in pairs(self.tbTaskDatas) do
		if (not tbPlayerTasks[tbTaskData.nId]) then
			local nReferIdx		= self:GetFinishedIdx(tbTaskData.nId) + 1;			-- +1表示將要繼續的任務
			local nReferId		= tbTaskData.tbReferIds[nReferIdx];
			if (nReferId) then				
				local tbReferData	= self.tbReferDatas[nReferId];
				if (tbReferData.nAcceptNpcId > 0) then
					local tbAccept	= tbReferData.tbAccept;
					local tbVisable = tbReferData.tbVisable;
					
					if (Lib:DoTestFuncs(tbVisable) and Lib:DoTestFuncs(tbAccept) and tbTaskData.tbAttribute.TaskType == nTaskType) then	-- 滿足可見和可接條件						
						if (nLevelType == 1 and (not nLevel or tbReferData.nLevel > nLevel)) then
							tbRefSubDataList = {};
							tbRefSubDataList[#tbRefSubDataList + 1] = tbReferData;
							nLevel = tbReferData.nLevel;						
						elseif (nLevelType == 2 and (not nLevel or tbReferData.nLevel < nLevel)) then
							tbRefSubDataList = {};
							tbRefSubDataList[#tbRefSubDataList + 1] = tbReferData;
							nLevel = tbReferData.nLevel;
						elseif (not nLevel or tbReferData.nLevel == nLevel) then
							tbRefSubDataList[#tbRefSubDataList + 1] = tbReferData;							
						end
					end
				end
			end
		end
	end
	
	return tbRefSubDataList;
end


function Task:GetMinAcceptRefData(pPlayer)
	local nMinLevel = 1000;
	local tbRefSubData = nil;
	local tbPlayerTasks = self:GetPlayerTask(pPlayer).tbTasks;
	for _, tbTask in pairs(tbPlayerTasks) do
		local tbReferData = self.tbReferDatas[tbTask.nReferId]
		local tbTaskData = tbTask.tbTaskData;
		if (tbTaskData.tbAttribute.TaskType == 1) then
			if (tbReferData.nLevel < nMinLevel) then
				nMinLevel = tbReferData.nLevel;
				tbRefSubData = tbReferData;
			end
		end
	end
	
	return tbRefSubData;
end

-- 獲得等級段描述
-- 先找已接任務最低等級段的任務描述，再找可接任務最低等級段描述
function Task:GetLevelRangeDesc(pPlayer)
	local nLevel = pPlayer.nLevel;
	local tbAcceptRefSubData = self:GetMinAcceptRefData(pPlayer);
	local tbRefSubData = self:GetMinCanAcceptRefDataList(pPlayer);
	
	if (tbAcceptRefSubData) then
		nLevel = tbAcceptRefSubData.nLevel;
	elseif (tbRefSubData and tbRefSubData[1]) then
		nLevel = tbRefSubData[1].nLevel;
	end
	
	for _, item in ipairs(self.tbLevelRangeInfo) do
		if (item.level_range_max >= nLevel) then
			return item.level_range_desc;
		end
	end
	
	return "";
end



-- 獲得當前可接的最小等級主線任務指引描述
function Task:GetMinLevelMainTaskInfo(pPlayer)
	local tbRet = {};
	local tbRefSubDataList = self:GetMinCanAcceptRefDataList(pPlayer);
	if (tbRefSubDataList) then
		for _, tbRefSubData in ipairs(tbRefSubDataList) do
			tbRet[#tbRet + 1] = {tbRefSubData.nLevel, tbRefSubData.szName, tbRefSubData.szIntrDesc};
		end
	end
	
	return tbRet;
end

function Task:GetMaxLevelCampTaskInfo(pPlayer)
	local tbRet = {};
	local tbRefSubDataList = self:GetCanAcceptRefDataList(me, Task.emType_Camp, 1);
	if (tbRefSubDataList) then
		for _, tbRefSubData in ipairs(tbRefSubDataList) do
			tbRet[#tbRet + 1] = {tbRefSubData.nLevel, tbRefSubData.szName, tbRefSubData.szIntrDesc};
		end
	end
	
	return tbRet;	
end

-- 獲得當前所有可接的支線任務列表
--
--{
--		{szName, szDesc = ""},
--		{szName, szDesc = ""},
--}
function Task:GetBranchTaskTable(pPlayer)
	local tbRet = {};
	local tbPlayerTasks	= self:GetPlayerTask(pPlayer).tbTasks;
	for _, tbTaskData in pairs(self.tbTaskDatas) do
		if (not tbPlayerTasks[tbTaskData.nId]) then
			local nReferIdx		= self:GetFinishedIdx(tbTaskData.nId) + 1;			-- +1表示將要繼續的任務
			local nReferId		= tbTaskData.tbReferIds[nReferIdx];
			if (nReferId) then				
				local tbReferData	= self.tbReferDatas[nReferId];
				if (tbReferData.nAcceptNpcId > 0) then
				local tbAccept	= tbReferData.tbAccept;
				local tbVisable = tbReferData.tbVisable
				if (Lib:DoTestFuncs(tbVisable) and Lib:DoTestFuncs(tbAccept) and tbTaskData.tbAttribute.TaskType == 2 and (not tbTaskData.tbAttribute["Repeat"])) then	-- 滿足可見和可接條件
					tbRet[#tbRet + 1] = {tbReferData.nLevel, tbReferData.szName, tbReferData.szIntrDesc}
					end
				end
			end
		end
	end
	
	table.sort(tbRet, self.CompLevel);
	
	return tbRet;
end


function Task.CompLevel(tbTaskA, tbTaskB)
	if (tbTaskA and tbTaskB) then
		return tbTaskA[1] < tbTaskB[1];
	end
end


-- 獲得難度描述
function Task:GetRefSubTaskDegreeDesc(nRefSubId)
	if (not self.tbReferDatas[nRefSubId]) then
		return "";
	end
	
	local nDegree = self.tbReferDatas[nRefSubId].nDegree or 1;
	if (nDegree <= 1) then
		return "";
	elseif (nDegree == 2) then
		return "<color=Yellow>Kiến nghị tổ đội<color=White>";
	elseif (nDegree == 3) then
		return "<color=Yellow>Hoan nghênh khiêu chiến<color=White>";
	elseif (nDegree == 4) then
		return"<color=Yellow>Nhiệm vụ có thể tuần hoàn<color=White>";
	end
	
	return "";
end


-- 玩家是否做過指定引用子任務，對於重復任務無效
function Task:HaveDoneSubTask(pPlayer, nTaskId, nRefId)
	local tbTaskData = self.tbTaskDatas[nTaskId];
	if (not tbTaskData) then
		return 0;
	end
	local nLastRefId = pPlayer.GetTask(1000, nTaskId);
	
	if (nLastRefId == 0) then
		return 0;
	end
	
	if (self.tbReferDatas[nLastRefId].nReferIdx >= self.tbReferDatas[nRefId].nReferIdx) then
		return 1;
	end
	
	return 0;
end

-- 玩家現在身上是否有某個任務
function Task:HaveTask(pPlayer, nTaskId)
	local tbPlayerTasks	= self:GetPlayerTask(pPlayer).tbTasks;
	if (tbPlayerTasks[nTaskId]) then
		return 1;
	end
	
	return 0;
end


-- 顯示所有任務，調試用
function Task:ShowAllTasks()
	local function fnCompEarlier(tbTask1, tbTask2)
		return tbTask1.nAcceptDate < tbTask2.nAcceptDate;
	end;

	local tbPlayerTask	= self:GetPlayerTask(me);
	local tbTasks	= {};
	for _, tbTask in pairs(tbPlayerTask.tbTasks) do
		tbTasks[#tbTasks+1]	= tbTask;
	end;
	me.Msg("My Tasks: ("..tbPlayerTask.nCount..")");
	table.sort(tbTasks, fnCompEarlier);
	for _, tbTask in ipairs(tbTasks) do
		me.Msg("  "..tbTask:GetName().." ["..os.date("%y/%m/%d %H:%M:%S", tbTask.nAcceptDate).."] ");
	end;
end


-- 以後補將可能用到，不刪先
function Task:ModifTaskItem(pPlayer)	
	if (pPlayer.GetTask(1022, 107) == 1) then
		pPlayer.Msg("Phần thưởng này không bị lỗi hoặc đã bồi thường rồi!");
		return;
	end
	
	if (pPlayer.CountFreeBagCell() < 1) then
		pPlayer.Msg("Khoảng trống trong rương không đủ");
		return;
	end
	
	pPlayer.SetTask(1022, 107, 1);
	
	if (pPlayer.nFaction == Player.FACTION_DUANSHI and pPlayer.nRouteId == Player.ROUTE_QIDUANSHI) then -- 氣段
		local nTaskId = tonumber("0C", 16);
		local nRefId  = tonumber("5E", 16);
		
		if (self:HaveDoneSubTask(pPlayer, nTaskId, nRefId) == 0) then
			if (self.tbReferDatas[nRefId]) then
				pPlayer.Msg("Bạn chưa hoàn thành nhiệm vụ "..self.tbReferDatas[nRefId].szName.."Không thể nhận bồi thường!");
			end
			return;
		end
		
		if (self:GetItemCount(pPlayer, {2, 1, 96, 5, 3}) <= 0) then
			pPlayer.AddItem(2, 1, 97, 6, 3);
			return;
		end
		pPlayer.Msg("Bạn đã có phần thưởng tương ứng!");
	elseif (pPlayer.nFaction == Player.FACTION_EMEI and pPlayer.nRouteId == Player.ROUTE_FUZHUEMEI) then -- 輔助峨嵋
		local nTaskId = tonumber("0C", 16);
		local nRefId  = tonumber("5E", 16);
		
		if (self:HaveDoneSubTask(pPlayer, nTaskId, nRefId) == 0) then
			if (self.tbReferDatas[nRefId]) then
				pPlayer.Msg("Bạn chưa hoàn thành nhiệm vụ "..self.tbReferDatas[nRefId].szName.."Không thể nhận bồi thường!");
			end
			return;
		end
		if (self:GetItemCount(pPlayer, {2, 1, 96, 5, 3}) <= 0) then
			pPlayer.AddItem(2, 1, 97, 6, 3);
			return;
		end
		pPlayer.Msg("Bạn đã có phần thưởng tương ứng!");
	elseif (pPlayer.nFaction == Player.FACTION_KUNLUN and pPlayer.nRouteId == Player.ROUTE_JIANWUDANG) then -- 劍武當
			local nTaskId = tonumber("09", 16);
			local nRefId  = tonumber("4A", 16);
		
			if (self:HaveDoneSubTask(pPlayer, nTaskId, nRefId) == 0) then
				if (self.tbReferDatas[nRefId]) then
					pPlayer.Msg("Bạn chưa hoàn thành nhiệm vụ "..self.tbReferDatas[nRefId].szName.."Không thể nhận bồi thường!");
				end
				return;
			end
		
		
			if (self:GetItemCount(pPlayer, {2, 1, 176, 5, 5}) <= 0) then
				pPlayer.AddItem(2, 1, 177, 6, 5);
				return;
			end
			
			pPlayer.Msg("Bạn đã có phần thưởng tương ứng!");
	else
		pPlayer.Msg("Hướng bạn chọn không bị lỗi phần thưởng!");
		return;
	end
end

function Task:IsNeedBind(tbItem)
	-- 裝備綁定
	if (tbItem[1] >= 1 and tbItem[1] <= 4) then
		return 1;
	end
	
	-- 玄晶會綁定
	if (tbItem[1] == 18 and tbItem[2] == 1 and tbItem[3] == 1) then
		return 1;
	end
	
	-- 白駒會綁定
	if (tbItem[1] == 18 and tbItem[2] == 1 and tbItem[3] == 71) then
		return 1;
	end
	
	-- 情花會綁定
	if (tbItem[1] == 18 and tbItem[2] == 1 and tbItem[3] == 597) then
		return 1;
	end
	
	-- 魂石會綁定
	if (tbItem[1] == 18 and tbItem[2] == 1 and tbItem[3] == 205) then
		return 1;
	end
	
	return 0;
end

function Task:OnLoadMapFinish(nMapId, nMapCopy, nParam)
	self.tbArmyCampInstancingManager:OnLoadMapFinish(nMapId, nMapCopy, nParam);
end


function Task:RepairTaskValue()
	local pPlayer = me;
	if (self:HaveDoneSubTask(pPlayer, tonumber("DB", 16), tonumber("18A", 16)) == 1) then
		if (0 ~= pPlayer.GetTask(1000, tonumber("DB", 16))) then
			Dbg:WriteLog("Task", "Player TaskValue Error!", 1000, tonumber("DB", 16));
			pPlayer.SetTask(1000, tonumber("DB", 16), 0, 1);
		end
	end
	
	if (self:HaveDoneSubTask(pPlayer, tonumber("DC", 16), tonumber("18B", 16)) == 1) then
		if (0 ~= pPlayer.GetTask(1000, tonumber("DC", 16))) then
			Dbg:WriteLog("Task", "Player TaskValue Error!", 1000, tonumber("DC", 16));
			pPlayer.SetTask(1000, tonumber("DC", 16), 0, 1);
		end
	end
		
	if (self:HaveDoneSubTask(pPlayer, tonumber("04", 16), tonumber("26", 16)) == 1 or 
		self:HaveDoneSubTask(pPlayer, tonumber("05", 16), tonumber("33", 16)) == 1 or 
		self:HaveDoneSubTask(pPlayer, tonumber("09", 16), tonumber("4A", 16)) == 1 or 
		self:HaveDoneSubTask(pPlayer, tonumber("0C", 16), tonumber("5F", 16)) == 1) then
			if (1 ~= pPlayer.GetTask(1022,107)) then
				Dbg:WriteLog("Task", "Player TaskValue Error!", 1022,107);
				pPlayer.SetTask(1022,107,1,1);
			end
	end
	
	if (self:HaveDoneSubTask(pPlayer, tonumber("F0", 16), tonumber("19F", 16)) == 1) then
		if (1 ~= pPlayer.GetTask(1022, 168)) then
			Dbg:WriteLog("Task", "Player TaskValue Error!", 1022, 168);
			pPlayer.SetTask(1022, 168, 1, 1);
		end
	end

	if (self:HaveDoneSubTask(pPlayer, tonumber("12C", 16), tonumber("1DB", 16)) == 1) then
		if (1 ~= pPlayer.GetTask(1022, 169)) then
			Dbg:WriteLog("Task", "Player TaskValue Error!", 1022, 169);
			pPlayer.SetTask(1022, 169, 1, 1);
		end
	end
	
	local tbPlayerTasks	= Task:GetPlayerTask(pPlayer).tbTasks;
	local tbTask = tbPlayerTasks[228];
	if (tbTask and tbTask.nReferId == 403 and tbTask.nCurStep == 4) then
		local tbFind1 = pPlayer.FindItemInBags(20,1,298,1);
		local tbFind2 = pPlayer.FindItemInRepository(20,1,298,1);
		if #tbFind1 <= 0 and #tbFind2 <= 0 then
			Dbg:WriteLog("Task", "Player TaskValue Error!", 1022, 119);
			pPlayer.SetTask(1022, 119, 1);
		end;
	end;
	
	self:SetTaskValueWithStepCondition(pPlayer, 240, 415, 1, 8, 1022, 141, 1); 
	
	self:SetTaskValueWithStepCondition(pPlayer, 292, 467, 2, 2, 1022, 151, 1); -- 千鈞一發
	self:SetTaskValueWithStepCondition(pPlayer, 295, 470, 7, 7, 1022, 152, 2); -- 在水一方
	self:SetTaskValueWithStepCondition(pPlayer, 295, 470, 8, 8, 1022, 141, 2); -- 在水一方
	self:SetTaskValueWithStepCondition(pPlayer, 237, 412, 3, 4, 1022, 137, 1); -- 背水一戰
	self:SetTaskValueWithStepCondition(pPlayer, 237, 412, 4, 4, 1022, 138, 1); -- 背水一戰
	self:SetTaskValueWithStepCondition(pPlayer, 239, 414, 7, 8, 1022, 141, 1); -- 功敗垂成
	self:SetTaskValueWithStepCondition(pPlayer, 240, 415, 3, 8, 1022, 141, 1); -- 慶元黨禁
	self:SetTaskValueWithStepCondition(pPlayer, 240, 415, 5, 8, 1022, 139, 3); -- 慶元黨禁
	
	self:SetTaskValueWithStepCondition(pPlayer, 240, 415, 9, 9, 1022, 141, 0); -- 慶元黨禁
	self:SetTaskValueWithStepCondition(pPlayer,  24, 170, 1, 3, 1024,   2, 4); -- 仇人相見

	self:SetTaskValueWithStepCondition(pPlayer,  24, 165, 1, 1, 1024,   2, 0); -- 洞中異象
	self:SetTaskValueWithStepCondition(pPlayer,  24, 165, 2, 3, 1024,   2, 1); -- 洞中異象
	self:SetTaskValueWithStepCondition(pPlayer,  24, 166, 1, 2, 1024,   2, 1); -- 別有洞天
	self:SetTaskValueWithStepCondition(pPlayer,  24, 167, 1, 3, 1024,   2, 2); -- 秘密泄露
	self:SetTaskValueWithStepCondition(pPlayer,  24, 167, 4, 6, 1024,   2, 3); -- 秘密泄露
	self:SetTaskValueWithStepCondition(pPlayer,  24, 167, 4, 6, 1024,   3, 1); -- 秘密泄露
	self:SetTaskValueWithStepCondition(pPlayer,  24, 168, 1, 2, 1024,   2, 3); -- 尋門而入
	self:SetTaskValueWithStepCondition(pPlayer,  24, 168, 1, 1, 1024,   3, 1); -- 尋門而入
	self:SetTaskValueWithStepCondition(pPlayer,  24, 168, 2, 2, 1024,   3, 2); -- 尋門而入
	self:SetTaskValueWithStepCondition(pPlayer,  24, 169, 1, 1, 1024,   2, 3); -- 有備無患
	self:SetTaskValueWithStepCondition(pPlayer,  24, 169, 1, 2, 1024,   3, 2); -- 有備無患
	self:SetTaskValueWithStepCondition(pPlayer,  24, 169, 2, 2, 1024,   2, 4); -- 有備無患
	
	self:SetTaskValueWithStepCondition(pPlayer,  18, 123, 1, 1, 1024,   9, 0); -- 謀劃
	self:SetTaskValueWithStepCondition(pPlayer,  18, 123, 2, 7, 1024,   9, 1); -- 謀劃
	self:SetTaskValueWithStepCondition(pPlayer,  18, 124, 1, 2, 1024,   9, 1); -- 爭奪
	self:SetTaskValueWithStepCondition(pPlayer,  18, 124, 3, 6, 1024,   9, 3); -- 爭奪
	self:SetTaskValueWithStepCondition(pPlayer,  18, 124, 4, 6, 1024,  10, 1); -- 爭奪
	self:SetTaskValueWithStepCondition(pPlayer,  18, 125, 1, 4, 1024,   9, 3); -- 懸疑
	self:SetTaskValueWithStepCondition(pPlayer,  18, 125, 1, 4, 1024,  10, 1); -- 懸疑
	self:SetTaskValueWithStepCondition(pPlayer,  18, 126, 1, 4, 1024,   9, 2); -- 撤離
	self:SetTaskValueWithStepCondition(pPlayer,  18, 126, 1, 4, 1024,  10, 1); -- 撤離
	self:SetTaskValueWithStepCondition(pPlayer,  18, 126,-1,-1, 1024,  10, 1); -- 撤離
	self:SetTaskValueWithStepCondition(pPlayer,  18, 126,-1,-1, 1024,   9, 2); -- 撤離
	self:SetTaskValueWithStepCondition(pPlayer,  18, 127, 1, 9, 1024,   9, 2); -- 風范
	self:SetTaskValueWithStepCondition(pPlayer,  18, 127, 1, 1, 1024,  10, 1); -- 風范
	self:SetTaskValueWithStepCondition(pPlayer,  18, 127, 2, 9, 1024,  10, 2); -- 風范
	
	local tbTasks = {225, 226, 227}
	local nHaveTask = 0;
	for _, nTaskId in ipairs(tbTasks) do
		if (Task:HaveTask(pPlayer, nTaskId) == 1) then
			nHaveTask = 1;
			break;
		end
	end
	if (nHaveTask == 0 and me.GetTask(1024, 50) ~= 0) then
		Dbg:WriteLog("Task", "Player TaskValue Error!", 1024, 50);
		me.SetTask(1024, 50, 0);
	end;
	
	local tbTasks = {333, 334, 337, 338}
	local nHaveTask = 0;
	for _, nTaskId in ipairs(tbTasks) do
		if (Task:HaveTask(pPlayer, nTaskId) == 1) then
			nHaveTask = 1;
			break;
		end
	end
	if (nHaveTask == 0 and (me.GetTask(1024, 60) ~= 0 or me.GetTask(1024, 59) ~= 0)) then
		Dbg:WriteLog("Task", "Player TaskValue Error!", 1024, 60);
		Dbg:WriteLog("Task", "Player TaskValue Error!", 1024, 59);
		me.SetTask(1024, 60, 0);
		me.SetTask(1024, 59, 0); 
	end;

	local tbTasks = {363, 364, 365, 366, 367, 368}
	local nHaveTask = 0;
	for _, nTaskId in ipairs(tbTasks) do
		if (Task:HaveTask(pPlayer, nTaskId) == 1) then
			nHaveTask = 1;
			break;
		end
	end
	if (nHaveTask == 0 and me.GetTask(1022, 176) ~= 0) then
		Dbg:WriteLog("Task", "Player TaskValue Error!", 1022, 176);
		me.SetTask(1022, 176, 0);
	end;
	
	local tbPlayerTasks	= self:GetPlayerTask(pPlayer).tbTasks;
	local tbTask = tbPlayerTasks[381];
	if (tbTask and tbTask.nReferId == 565 and pPlayer.GetTask(1022, 187) ~= 0) then
		Dbg:WriteLog("Task", "Player TaskValue Error!", 1022, 187);
		pPlayer.SetTask(1022, 187, 0, 1);
	end;	
end

function Task:SetTaskValueWithStepCondition(pPlayer, nTaskId, nReferId, nMinStep, nMaxStep, nGroupId, nRowId, nValue)
	if (not pPlayer or not nTaskId or not nReferId or not nMinStep or not nMaxStep) then
		return;
	end;
	if (not nGroupId or not nRowId or not nValue) then
		return;
	end;
	
	local tbPlayerTasks	= self:GetPlayerTask(pPlayer).tbTasks;
	local tbTask = tbPlayerTasks[nTaskId];
	if (tbTask and tbTask.nReferId == nReferId and tbTask.nCurStep >= nMinStep and tbTask.nCurStep <= nMaxStep) then
		if (nValue ~= pPlayer.GetTask(nGroupId, nRowId)) then
			Dbg:WriteLog("Task", "Player TaskValue Error!", nGroupId, nRowId);
			pPlayer.SetTask(nGroupId, nRowId, nValue, 1);
		end
	end;
end;

function Task:RepairBook()
	-- 如果背包裡沒有書，切處於指定任務的指定步驟，則加書給他
	local tbPlayerTasks	= self:GetPlayerTask(me).tbTasks;
	local tbTask0 = tbPlayerTasks[228];
	local tbTask1 = tbPlayerTasks[229];
	local tbTask2 = tbPlayerTasks[230];
	
	if (tbTask0 and tbTask0.nCurStep == 6 and not TaskCond:HaveItem({20, 1, 299, 1}) and me.GetTask(1022, 120) == 0) then
		-- 如果有背包空間
		if (TaskCond:HaveBagSpace(1) and not TaskCond:HaveItem({20, 1, 490, 1})) then
			Task:AddItem(me, {20, 1, 490, 1});
		end
	end
	-- 補償孫子兵法書
	if (tbTask1 and tbTask1.nCurStep == 2 and not TaskCond:HaveItem({20, 1, 298, 1}) and me.GetTask(1022, 119) == 0) then
		-- 如果有背包空間
		if (TaskCond:HaveBagSpace(1) and not TaskCond:HaveItem({20, 1, 489, 1})) then
			Task:AddItem(me, {20, 1, 489, 1});
		end
	end
	
	-- 墨家機關術
	if (tbTask2 and tbTask2.nCurStep == 2 and not TaskCond:HaveItem({20, 1, 299, 1}) and me.GetTask(1022, 120) == 0) then
		-- 如果有背包空間
		if (TaskCond:HaveBagSpace(1) and not TaskCond:HaveItem({20, 1, 490, 1})) then
			Task:AddItem(me, {20, 1, 490, 1});
		end
	end
	
	local tbTask3 = tbPlayerTasks[340];
	-- 兵書
	if (tbTask3 and tbTask3.nCurStep == 2 and not TaskCond:HaveItem({20,1,544,1}) and me.GetTask(1022, 165) == 0) then
		-- 如果有背包空間
		if (TaskCond:HaveBagSpace(1)) then
			Task:AddItem(me, {20,1,544,1});
		end
	end
	
	local tbTask4 = tbPlayerTasks[341];
	-- 墨家機關術
	if (tbTask4 and tbTask4.nCurStep == 2 and not TaskCond:HaveItem({20,1,545,1}) and me.GetTask(1022, 167) == 0) then
		-- 如果有背包空間
		if (TaskCond:HaveBagSpace(1)) then
			Task:AddItem(me, {20,1,545,1});
		end
	end
end


function Task:RepairCampTask()
	if (Task:HaveTask(me, 226) == 0 and Task:HaveTask(me, 227) == 0) then
		if (me.GetTask(1024, 50) == 1) then
			me.SetTask(1024, 50, 0, 1);
			if (me.GetTask(2060, 1) == 0) then
				me.SetTask(2060, 1, 1); -- 值為1表示可以領，領過之後累加
				me.Msg("Bạn có thể gặp người tiếp dẫn nhận bồi thường nhiệm vụ")
			end
		end
	end
end

function Task:AmendeForCampTask(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	assert(pPlayer);
	if (pPlayer.GetTask(2060, 1) == 0) then
		Dialog:Say("Nhiệm vụ Quân doanh của bạn không bị lỗi!");
	elseif (pPlayer.GetTask(2060, 1) ~= 1) then
		Dialog:Say("Phần thưởng bồi thường của nhiệm vụ Quân doanh không thể lặp lại!");
	else
		pPlayer.AddExp(8000000);							-- 800w經驗
		pPlayer.Earn(40000, Player.emKEARN_TASK_GIVE);	-- 4w非綁銀
		pPlayer.ChangeCurGatherPoint(1800);				-- 1800活力
		pPlayer.ChangeCurMakePoint(1800);				-- 1800精力
		local nOldValue = pPlayer.GetTask(2060, 1);
		pPlayer.SetTask(2060, 1, nOldValue+1, 1);
	end
end

function Task:DailyEvent()
	me.SetTask(1025, 1, 0, 1);--大拜年
	me.SetTask(2031, 1, 0, 1);
	me.SetTask(1025, 14, 0, 1);--2010拜年
	me.SetTask(1025, 16, 0, 1);--賑災任務
end;

local tbRepairArmyBook = Item:GetClass("repairarmybook");

function tbRepairArmyBook:OnUse()
	me.SetTask(1022,119,1,1);
	
	return 1;
end

local tbRepairHisBook = Item:GetClass("repairhisbook");
function tbRepairHisBook:OnUse()
	me.SetTask(1022,120,1,1);
	
	return 1;
end

PlayerSchemeEvent:RegisterGlobalDailyEvent({Task.DailyEvent, Task});

PlayerEvent:RegisterGlobal("OnLogin", Task.RepairTaskValue, Task);
PlayerEvent:RegisterGlobal("OnLogin", Task.RepairBook, Task);
PlayerEvent:RegisterGlobal("OnLogin", Task.RepairCampTask, Task);
