
-- ====================== 文件信息 ======================

-- 劍俠世界隨機任務任務卷軸頭文件
-- Edited by peres
-- 2007/06/03 PM 11:18

-- 她的眼淚輕輕地掉落下來
-- 撫摸著自己的肩頭，寂寥的眼神
-- 是，褪掉繁華和名利帶給的空洞安慰，她隻是一個一無所有的女子
-- 不愛任何人，亦不相信有人會愛她

-- ======================================================

ScrollTask.tbItemId = {18,1,5};  -- 卷軸的 ID 定義

ScrollTask.ITEM_TASKID = 1;      -- 儲存任務ID的物品索引

ScrollTask.nMainTaskId = tonumber("62", 16);

function ScrollTask:OnInit()
	
	self:_Debug("Start init scroll task! ");
	
	self.tbfile_EntityScrollTask     = Lib:NewClass(Lib.readTabFile);
	self.tbfile_LevelGroup           = Lib:NewClass(Lib.readTabFile);
	
	self.tbfile_EntityScrollTask:OnInit("\\setting\\task\\scroll\\scrolltask.txt");
	self.tbfile_LevelGroup:OnInit("\\setting\\task\\scroll\\level_group.txt");
end;

function ScrollTask:SelectLevelGroup()
	local nLevel = me.nLevel; --GetLevel();
	local nTabLevel = 0;
	local nGroup = 0;
	
	local nRow = self.tbfile_LevelGroup:GetRow();
	local i=0;
	
	self:_Debug("Get the level group file row: "..nRow);
	
	for i=1, nRow do
		nTabLevel = self.tbfile_LevelGroup:GetCellInt("Level", i);
		nGroup    = self.tbfile_LevelGroup:GetCellInt("LevelGroup", i);
		if nLevel<=nTabLevel then
			return nGroup;
		end;
	end;
end;

function ScrollTask:SelectTask()
	local nLevelGroup = self:SelectLevelGroup();
	
	local tbTask = self.tbfile_EntityScrollTask;
	local nTaskRow = tbTask:CountRate("Level"..nLevelGroup);
	
	local nTaskId  = tbTask:GetCell("TaskId", nTaskRow);
		
		if nTaskId == nil or nTaskId=="" then
			self:_Debug("Select task id error! ");
			return 0;
		end;
		
		nTaskId = tonumber(nTaskId, 16);
		self:_Debug("Select a task Id: "..nTaskId);
		
		return nTaskId;
end;

-- 給玩家加一個任務卷軸
function ScrollTask:AddScroll(nTaskNum)
	local nTaskId = self:SelectTask();
	
	-- 如果有傳進來的參數，直接按照傳進來的生成
	if nTaskNum~=nil then
		nTaskId = nTaskNum;
	end;
	
	if nTaskId==0 then
		self:_Debug("AddScroll: Select task id error!");
		return;
	end;
	
	local pItem = me.AddScriptItem(self.tbItemId[2], self.tbItemId[3], 1, 0, {nTaskId}, 0);
	
	if pItem==nil then
		self:_Debug("Add scroll item error!");
		return;
	end;
	
end;

-- 檢查一個玩家身上是否正在進行卷軸任務
function ScrollTask:HaveScrollTask()
	local tbTask  = nil;
	
	tbTask = Task:GetPlayerTask(me).tbTasks[self.nMainTaskId];
	if tbTask ~= nil then
		return tbTask.tbReferData;
	end;

	return nil;
end;



function ScrollTask:GetTaskInfo(nTaskId)
	local szInfo = Task.tbReferDatas[nTaskId].tbDesc.szMainDesc;
	if szInfo=="" then
		return "Không thể nhận miêu tả nhiệm vụ!";
	end;
	return szInfo;
end;


function ScrollTask:GetTaskAwardText(nTaskId)
	local tbAwards	= Task:GetAwardsForMe(nTaskId);
	local szAwardMain = "";
	
	local tbFix, tbRandom;
	
	-- 固定獎勵
	if (tbAwards.tbFix and #tbAwards.tbFix > 0) then
		szAwardMain = szAwardMain.."<color=yellow>Phần thưởng cố định<color><enter>";
		for _, tbFix in ipairs(tbAwards.tbFix) do
			szAwardMain = szAwardMain..tbFix.szDesc.."<enter>";
		end;
		szAwardMain = szAwardMain.."<enter>";
	end;

	-- 隨機獎勵
	if (tbAwards.tbRand and #tbAwards.tbRand > 0) then
		szAwardMain = szAwardMain.."<color=yellow>Phần thưởng ngẫu nhiên<color><enter>";
		for _, tbRandom in ipairs(tbAwards.tbRand) do
			szAwardMain = szAwardMain.."<color=green>"..tbRandom.szDesc.."<color>   "..tbRandom.nRate.."% 的概率<enter>";
		end;
		szAwardMain = szAwardMain.."<enter>";
	end;
	
	return szAwardMain;
end;


function ScrollTask:_Debug(szMsg)
	print ("[ScrollTask]: "..szMsg);
end;

-- ScrollTask:OnInit();
