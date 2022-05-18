--官府通缉令
--孙多良
--2008.08.05
Require("\\script\\task\\wanted\\wanted_def.lua");

function Wanted:LoadLevelGroup()
	self.LevelGroup = {};
	local tbFile = Lib:LoadTabFile("\\setting\\task\\wanted\\level_group.txt");
	if not tbFile then
		return;
	end
	for i=2, #tbFile do 
		local nLevel = tonumber(tbFile[i].Level);
		local nLevelGroup = tonumber(tbFile[i].LevelGroup);
		self.LevelGroup[nLevelGroup] = nLevel;
	end
end

function Wanted:LoadTask()
	self.TaskFile = {};
	self.TaskLevelSeg = {};
	local tbFile = Lib:LoadTabFile("\\setting\\task\\wanted\\wanted_killnpc.txt");
	if not tbFile then
		return;
	end
	for i=2, #tbFile do
		local nTaskId	= tonumber(tbFile[i].TaskId);
		local nLevelSeg	= tonumber(tbFile[i].LevelSeg);
		local tbTemp = {
		 szTaskName	= (tbFile[i].TaskName),
		 szTargetName= (tbFile[i].TaskType),
		 nMapId		= tonumber(tbFile[i].MapId),
		 nPosX		= math.floor(tonumber(tbFile[i].PosX)),
		 nPosY		= math.floor(tonumber(tbFile[i].PosY)),
		 szMapName	= (tbFile[i].MapName),
		 nNpcId		= tonumber(tbFile[i].NpcId),
		 nNum		= tonumber(tbFile[i].Num) or 1,		
		 nLevelSeg  = nLevelSeg;
		}
		self.TaskFile[nTaskId] = tbTemp;
		if not self.TaskLevelSeg[nLevelSeg] then
			self.TaskLevelSeg[nLevelSeg] = {};
		end
		table.insert(self.TaskLevelSeg[nLevelSeg], nTaskId);
	end
end

-- 初始化任务链表格
function Wanted:InitFile()
	-- 根据等级段来选择任务
	self:LoadLevelGroup();
	self:LoadTask();
	self:ReadMainTask();
	self:ReadTaskFile();
end;

function Wanted:ReadTaskFile()
	self.tbSubTaskData = {};
	for nTaskId, tbSubFile in pairs(self.TaskFile) do
		local tbParams = {};
		if tbSubFile.szTargetName == "KillNpc" then
			tbParams = {tbSubFile.nNpcId, tbSubFile.nMapId, tbSubFile.nNum};
		end;
		-- 服务端才载入子任务
		if (MODULE_GAMESERVER) then
			self:ReadSubTask(nTaskId, tbSubFile.szTaskName, tbSubFile.szTargetName, tbParams);
		else
			-- 给客户端用的缓存
			if self.tbSubTaskData[nTaskId]==nil then
				self.tbSubTaskData[nTaskId] = {};
			end;
			self.tbSubTaskData[nTaskId].szTaskName	= tbSubFile.szTaskName;
			self.tbSubTaskData[nTaskId].szTargetName	= tbSubFile.szTargetName;
			self.tbSubTaskData[nTaskId].tbParams		= tbParams;			
		end;
	end;
end;

function Wanted:ReadMainTask()
	
	local tbTaskData	= {};
	tbTaskData.nId		= self.TASK_MAIN_ID;
	tbTaskData.szName	= self.TEXT_NAME;
	
	
	-- 主任务的基础属性
	local tbAttribute	= {};
	tbTaskData.tbAttribute	= tbAttribute;
	
	tbAttribute["Order"]		= Lib:Str2Val("linear");	-- 任务流程：线性
	tbAttribute["Repeat"]		= Lib:Str2Val("true");		-- 是否可重做：是
	tbAttribute["Context"]		= Lib:Str2Val("");			-- 任务描述
	tbAttribute["Share"]		= Lib:Str2Val("false");		-- 是否可共享
	tbAttribute["TaskType"]		= Lib:Str2Val("3");			-- 任务类型：3、随机任务
	tbAttribute["AutoTrack"]	= Lib:Str2Val("true");
	
	-- 主任务下的子任务
	local tbReferIds	= {};
	tbTaskData.tbReferIds	= tbReferIds;
		
	for nTaskId, tbSubFile in pairs(self.TaskFile) do

		local nReferId		= nTaskId;  -- 引用子任务Id
		local nReferIdx		= #tbReferIds + 1;	-- 引用子任务索引
		local tbReferData	= {};
		
		-- 不能存在已有的任务
		assert(not Task.tbReferDatas[nReferId]);
		
		Task.tbReferDatas[nReferId]	= tbReferData;
		
		tbReferIds[nReferIdx]		= nReferId;
		tbReferData.nReferId		= nReferId;
		tbReferData.nReferIdx		= nReferIdx;
		tbReferData.nTaskId			= self.TASK_MAIN_ID;
		tbReferData.nSubTaskId		= nTaskId;
		tbReferData.szName			= string.format("Truy nã Hải tặc %s",tbSubFile.szTaskName);
		tbReferData.tbDesc			= {};
		
		tbReferData.tbVisable	= {};	-- 可见条件
		tbReferData.tbAccept	= {}; 	-- 可接条件
		
		tbReferData.nAcceptNpcId	= 0;
		
		tbReferData.bCanGiveUp	= Lib:Str2Val("false");
		
		tbReferData.szGossip = "";			-- 流言文字
		tbReferData.nReplyNpcId	= 0;		-- 回复 NPC
		tbReferData.szReplyDesc	= "";		-- 回复文字
		tbReferData.nBagSpaceCount = 0;		-- 背包空间检查
		tbReferData.nLevel = 50;
		tbReferData.szIntrDesc = "";
		tbReferData.nDegree = 1;
		tbReferData.tbAwards	= {
			tbFix	= {},
			tbOpt	= {},
			tbRand	= {},
		};
	end;
	
	Task.tbTaskDatas[self.TASK_MAIN_ID]	= tbTaskData;
	return tbTaskData;
end;

-- 读入子任务，子任务 id，子任务类型（杀怪、寻物等），任务中文名
function Wanted:ReadSubTask(nSubTaskId, szTaskName, szTargetName, tbParams)

	local tbSubData		= {};
	tbSubData.nId		= nSubTaskId;
	tbSubData.szName	= szTaskName;
	tbSubData.szDesc	= string.format("Hình bộ nha môn phát công văn thông báo, Hải tặc <pos=%s,%s,%s,%s> gần đây xuất hiện quanh <color=yellow>%s<color=white>. Bạn cần phải bắt chúng về quy án!",szTaskName,self.TaskFile[nSubTaskId].nMapId, self.TaskFile[nSubTaskId].nPosX, self.TaskFile[nSubTaskId].nPosY, self.TaskFile[nSubTaskId].szMapName);
	tbSubData.tbSteps	= {};
	tbSubData.tbExecute = {};
	tbSubData.tbStartExecute = {};
	tbSubData.tbFailedExecute = {};
	tbSubData.tbFinishExecute = {};
	-- 任务属性
	local tbAttribute	= {};
	tbSubData.tbAttribute	= tbAttribute;
	
	-- 开始对话
	local tbDialog	= {};
	tbAttribute.tbDialog	= tbDialog;
	tbAttribute.tbDialog["Start"] = {szMsg= ""};
	tbAttribute.tbDialog["Procedure"] = {szMsg = ""};
	tbAttribute.tbDialog["Error"] = {szMsg = ""};
	tbAttribute.tbDialog["Prize"] = {szMsg = ""};
	tbAttribute.tbDialog["End"] = {szMsg = ""};	

	-- 步骤
	local tbStep	= {};
	table.insert(tbSubData.tbSteps, tbStep);

	-- 开始事件，这里设一个空的 npc
	local tbEvent	= {};
	tbStep.tbEvent	= tbEvent;
	tbEvent.nType	= 1;
	tbEvent.nValue	= 0;

	-- 任务目标
	local tbTargets		= {};
	tbStep.tbTargets	= tbTargets;

	local tbTagLib	= Task.tbTargetLib[szTargetName];
	assert(tbTagLib, "Target["..szTargetName.."] not found!!!");
	local tbTarget	= Lib:NewClass(tbTagLib);--根据函数名new目标
	tbTarget:Init(unpack(tbParams));--从子任务文件把目标数据读入
	tbTargets[#tbTargets+1]	= tbTarget;


	-- 步骤条件
	tbStep.tbJudge	= {};
	tbStep.tbExecute = {};

	
	Task.tbSubDatas[nSubTaskId]	= tbSubData;
	return tbSubData;
end;

