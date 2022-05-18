
-- ====================== 文件信息 ======================

-- 劍俠世界門派任務鏈頭文件（第二版）
-- Edited by peres
-- 2007/12/11 PM 08:50

-- 很多事情不需要預測
-- 預測會帶來猶豫
-- 因為心裡會有恐懼

-- ======================================================

LinkTask.tbfile_SubTask		= {};	-- 子任務的表格內容集合
LinkTask.tbSubTaskData		= {};	-- 子任務的緩存數據

-- 初始化任務鏈表格
function LinkTask:InitFile()
	-- 根據等級段來選擇任務
	self.tbfile_TaskLevelGroup		= Lib:NewClass(Lib.readTabFile, "\\setting\\task\\linktask\\level_group.txt");
	
	-- 各種任務類型的權重
	self.tbfile_TaskType			= Lib:NewClass(Lib.readTabFile, "\\setting\\task\\linktask\\type_select.txt");
	
	for i=1, self.tbfile_TaskType:GetRow() do
		
		local nMainTaskId	= self.tbfile_TaskType:GetCellInt("TypeId", i);
		local szEntityFile	= self.tbfile_TaskType:GetCell("FileName", i);
		
		if nMainTaskId>0 and szEntityFile~="" then
			self:_Debug("Start create entity file: ", nMainTaskId, szEntityFile);
			self.tbfile_SubTask[nMainTaskId]		= Lib:NewClass(Lib.readTabFile, "\\setting\\task\\linktask\\"..szEntityFile);		
		end;
	end;
	
	self:ReadTaskFile();
end;

function LinkTask:ReadTaskFile()
	
	for nMainTaskId, _ in pairs(self.tbfile_SubTask) do

		self:_ReadTask(nMainTaskId);
		
		local tabfileSubTask	= self.tbfile_SubTask[nMainTaskId];
		
		for i=1, tabfileSubTask:GetRow() do
			local nSubTaskId		= tabfileSubTask:GetCellInt("TaskId", i); -- 引用子任務Id
			local szTargetName		= tabfileSubTask:GetCell("TaskType", i);
			local szTaskName		= tabfileSubTask:GetCell("TaskName", i);
			
			local tbParams			= {};
			
			-- 找物品任務
			if szTargetName == "SearchItemWithDesc" then
				local nGenre, nDetail, nParticular, nLevel, nSeries, nNum = 0,0,0,0,0,0;
				local szItemName		= "";
				
				nGenre		= tabfileSubTask:GetCellInt("Genre", i);
				nDetail		= tabfileSubTask:GetCellInt("Detail", i);
				nParticular	= tabfileSubTask:GetCellInt("Particular", i);
				nLevel		= tabfileSubTask:GetCellInt("Level", i);
				nSeries		= tabfileSubTask:GetCellInt("Series", i);
				nNum		= tabfileSubTask:GetCellInt("Num", i);
				szItemName	= tabfileSubTask:GetCell("ItemName", i);
	
				tbParams	= {szItemName, 
								nGenre, nDetail, nParticular, nLevel, nSeries, "", 
								nNum, 1};
			end;
			
			if szTargetName == "KillNpc" then
				local nMapId		= tabfileSubTask:GetCellInt("MapId", i);
				local nNpcId		= tabfileSubTask:GetCellInt("NpcId", i);
				local nCount		= tabfileSubTask:GetCellInt("Num", i);
				
				tbParams	= {nNpcId, nMapId, nCount};
			end;
			
			if szTargetName == "SearchItemBySuffix" then
				local szItemName	= tabfileSubTask:GetCell("ItemName", i);
				local szSuffix		= tabfileSubTask:GetCell("Suffix", i);
				local nCount		= tabfileSubTask:GetCellInt("Num", i);
				
				tbParams	= {szItemName, szSuffix, nCount, 1};
			end;
						
			-- 服務端才載入子任務
			if (MODULE_GAMESERVER) then
				self:_ReadSubTask(nSubTaskId, szTaskName, szTargetName, tbParams);
				-- self:_Debug("Find item id: ", nSubTaskId, szTaskName, unpack(tbParams));
			else
				-- 給客戶端用的緩存
				if self.tbSubTaskData[nSubTaskId]==nil then
					self.tbSubTaskData[nSubTaskId] = {};
				end;
				self.tbSubTaskData[nSubTaskId].szTaskName		= szTaskName;
				self.tbSubTaskData[nSubTaskId].szTargetName		= szTargetName;
				self.tbSubTaskData[nSubTaskId].tbParams			= tbParams;
			end;
		end;
	end;
end;

function LinkTask:_ReadTask(nTaskId)
	
	local tbTaskData	= {};
	tbTaskData.nId		= nTaskId;
	tbTaskData.szName	= "【"..self:GetMainTaskName(nTaskId).."】";
	
	
	-- 主任務的基礎屬性
	local tbAttribute	= {};
	tbTaskData.tbAttribute	= tbAttribute;
	
	tbAttribute["Order"]		= Lib:Str2Val("linear");	-- 任務流程：線性
	tbAttribute["Repeat"]		= Lib:Str2Val("true");		-- 是否可重做：是
	tbAttribute["Context"]		= Lib:Str2Val("");			-- 任務描述
	tbAttribute["Share"]		= Lib:Str2Val("false");		-- 是否可共享
	tbAttribute["TaskType"]		= Lib:Str2Val("3");			-- 任務類型：3、隨機任務
	tbAttribute["AutoTrack"]	= Lib:Str2Val("true");
	
	-- 主任務下的子任務
	local tbReferIds	= {};
	tbTaskData.tbReferIds	= tbReferIds;

	-- 任務的內容表
	local tabfileSubTask	= self.tbfile_SubTask[nTaskId];

	-- 在這裡循環將子任務放到任務 table 裡去
	
	self:_Debug("Start read subtask in maintask!");
	
	for i=1, tabfileSubTask:GetRow() do

		local nReferId		= tabfileSubTask:GetCellInt("TaskId", i); -- 引用子任務Id
		local nReferIdx		= #tbReferIds + 1;	-- 引用子任務索引
		local tbReferData	= {};
		
		-- 不能存在已有的任務
		assert(not Task.tbReferDatas[nReferId]);
		
		Task.tbReferDatas[nReferId]	= tbReferData;
		
		tbReferIds[nReferIdx]		= nReferId;
		tbReferData.nReferId		= nReferId;
		tbReferData.nReferIdx		= nReferIdx;
		tbReferData.nTaskId			= nTaskId;
		tbReferData.nSubTaskId		= tabfileSubTask:GetCellInt("TaskId", i);
		tbReferData.szName			= tabfileSubTask:GetCell("TaskName", i);
		tbReferData.tbDesc			= "";
		
		tbReferData.tbVisable	= {};	-- 可見條件
		tbReferData.tbAccept	= {}; 	-- 可接條件
		
		tbReferData.nAcceptNpcId	= 0;
		
		tbReferData.bCanGiveUp	= Lib:Str2Val("false");
		
		tbReferData.szGossip = "";			-- 流言文字
		tbReferData.nReplyNpcId	= 0;		-- 回復 NPC
		tbReferData.szReplyDesc	= "";		-- 回復文字
		tbReferData.nBagSpaceCount = 0;		-- 背包空間檢查
		tbReferData.nLevel = 1;
		tbReferData.szIntrDesc = "";
		tbReferData.nDegree = 100;
		tbReferData.tbAwards	= {
			tbFix	= {},
			tbOpt	= {},
			tbRand	= {},
		};
		
		self:_Debug("Read sub task: "..tbReferData.szName.."  Refer Id: "..nReferId.."  Refer Idx: "..nReferIdx);
	end;
	
	Task.tbTaskDatas[nTaskId]	= tbTaskData;
	return tbTaskData;
end;

-- 讀入子任務，子任務 id，子任務類型（殺怪、尋物等），任務中文名
function LinkTask:_ReadSubTask(nSubTaskId, szTaskName, szTargetName, tbParams)

	local tbSubData		= {};
	tbSubData.nId		= nSubTaskId;
	tbSubData.szName	= "【"..szTaskName.."】";
	tbSubData.szDesc	= "";
	
	tbSubData.tbSteps	= {};
	tbSubData.tbExecute = {};
	tbSubData.tbStartExecute = {};
	tbSubData.tbFailedExecute = {};
	tbSubData.tbFinishExecute = {};
	-- 任務屬性
	local tbAttribute	= {};
	tbSubData.tbAttribute	= tbAttribute;
	
	-- 開始對話
	local tbDialog	= {};
	tbAttribute.tbDialog	= tbDialog;
	tbAttribute.tbDialog["Start"] = {szMsg= ""};
	tbAttribute.tbDialog["Procedure"] = {szMsg = ""};
	tbAttribute.tbDialog["Error"] = {szMsg = ""};
	tbAttribute.tbDialog["Prize"] = {szMsg = ""};
	tbAttribute.tbDialog["End"] = {szMsg = ""};	

	-- 步驟
	local tbStep	= {};
	table.insert(tbSubData.tbSteps, tbStep);

	-- 開始事件，這裡設一個空的 npc
	local tbEvent	= {};
	tbStep.tbEvent	= tbEvent;
	tbEvent.nType	= 1;
	tbEvent.nValue	= 0;

	-- 任務目標
	local tbTargets		= {};
	tbStep.tbTargets	= tbTargets;


	local tbTagLib	= Task.tbTargetLib[szTargetName];
	assert(tbTagLib, "Target["..szTargetName.."] not found!!!");
	local tbTarget	= Lib:NewClass(tbTagLib);--根據函數名new目標
	tbTarget:Init(unpack(tbParams));--從子任務文件把目標數據讀入
	tbTargets[#tbTargets+1]	= tbTarget;


	-- 步驟條件
	tbStep.tbJudge	= {};
	tbStep.tbExecute = {};

	
	Task.tbSubDatas[nSubTaskId]	= tbSubData;
	return tbSubData;
end;

-- 根據一個主任務 Id 來獲取該主任務的中文名
function LinkTask:GetMainTaskName(nTaskId)
	local nRow =	self.tbfile_TaskType:GetDateRow("TypeId", nTaskId);
		if nRow == 0 then
			self:_Debug("GetMainTaskName Error!");
			return "";
		end;
	return self.tbfile_TaskType:GetCell("TypeName", nRow);
end;


function LinkTask:_Debug(...)
--	print ("[LinkTask]: ", unpack(arg));
end;
