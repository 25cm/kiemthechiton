
-- ====================== 文件信息 ======================

-- 劍俠世界隨機任務處理頭文件
-- Edited by peres
-- 2007/04/03 PM 19:51

-- 後來又笑自己的狷介。
-- 每個人有自己的宿命，一切又與他人何干。
-- 太多人太多事，隻是我們的借口和理由。

-- ======================================================
 
RandomTask.TSKG_ID = 2;         -- 隨機任務的任務變量組分配

RandomTask.LIMIT_NUM = 10;  -- 每個玩家每天隨機任務的上限
RandomTask.CHECKTIME     = 6000; -- 多少秒觸發一次隨機任務判斷點
RandomTask.TASKRATE      = 100;  -- 每次觸發點有百分之幾的概率可獲得隨機任務

-- 各個主任務的 ID，編輯器生成
RandomTask.nMainTaskId = {
		[1] = tonumber("63", 16),
		[2] = tonumber("64", 16),
	}

-- 各種任務類型的表格
-- 1 為殺怪
-- 2 為收集物品
RandomTask.tbTaskType = {[1]={}, [2]={}};

-- 隨機任務第一層卷軸的物品 ID
RandomTask.tbItemId = {18,1,6};

RandomTask.TSK_NUM       = 1;  -- 記錄今天已經領了多少次任務
RandomTask.TSK_DATE      = 2;  -- 記錄領取的天數


-- 隨機任務類初始化
function RandomTask:OnInit()
	self.tbfile_TaskLevelGroup     = Lib:NewClass(Lib.readTabFile);
	self.tbfile_TaskType           = Lib:NewClass(Lib.readTabFile);
	self.tbfile_EntityKillNpc      = Lib:NewClass(Lib.readTabFile);
	self.tbfile_EntityFindItem     = Lib:NewClass(Lib.readTabFile);	
	self.tbfile_EntityTaskBook     = Lib:NewClass(Lib.readTabFile);
		
	self:_Debug("Start load tabfile!");
	
	self.tbfile_TaskLevelGroup:OnInit("\\setting\\task\\random\\level_group.txt");
	self.tbfile_TaskType:OnInit("\\setting\\task\\random\\type_select.txt");

	self.tbfile_EntityKillNpc:OnInit("\\setting\\task\\random\\entity_killnpc.txt");
	self.tbfile_EntityFindItem:OnInit("\\setting\\task\\random\\entity_finditem.txt");

	self.tbTaskType[1] = self.tbfile_EntityKillNpc;
	self.tbTaskType[2] = self.tbfile_EntityFindItem;

end


-- 隨機任務的觸發點
function RandomTask:OnStart()
	self:_Debug("Start random task check point!");
	local nRandom = 0;
		nRandom = MathRandom(1,100);
		if nRandom <= self.TASKRATE then
			-- self:GiveTask();
			-- 臨時關掉隨機任務
			return;
		end
end


-- 選擇等級段
function RandomTask:SelectLevelGroup()
	local nLevel = me.nLevel; --GetLevel();
	local nTabLevel = 0;
	local nGroup = 0;
	
	local nRow = self.tbfile_TaskLevelGroup:GetRow();
	local i=0;
	
	self:_Debug("Get the level group file row: "..nRow);
	
	for i=1, nRow do
		nTabLevel = self.tbfile_TaskLevelGroup:GetCellInt("Level", i);
		nGroup    = self.tbfile_TaskLevelGroup:GetCellInt("LevelGroup", i);
		if nLevel<=nTabLevel then
			return nGroup;
		end;
	end;
end


-- 選擇一個任務 ID
function RandomTask:SelectTask()
	local nLevelGroup = self:SelectLevelGroup();
	local nTypeRow = self.tbfile_TaskType:CountRate("Level"..nLevelGroup);
	
	if nTypeRow<1 then
		self:_Debug("Select task type error!");
		return;
	end;
	
	-- 先選擇一個任務類型，是殺怪還是收集物品
	local nType = self.tbfile_TaskType:GetCellInt("TypeId", nTypeRow);
	
	self:_Debug("Task level group: "..nLevelGroup);
	self:_Debug("Select task type: "..nType);
	
	local nTaskRow = self.tbTaskType[nType]:CountRate("Level"..nLevelGroup);
	
	if nTaskRow<1 then
		self:_Debug("Select task row error!");
		return;
	end;
	
	-- 得到任務 ID 字符
	local nTaskId = self.tbTaskType[nType]:GetCell("TaskId", nTaskRow);
	
	nTaskId = tonumber(nTaskId, 16);
	
	return nTaskId;
	
end


-- 給予玩家隨機任務
function RandomTask:GiveTask()

	-- 當天已達上限，不能再發卷軸了
	if self:ApplyAddScroll()==0 then
		return;
	end;	

	local nTaskId = self:SelectTask();
	
	self:AddScroll(nTaskId);
end


-- 給玩家加一個任務卷軸
function RandomTask:AddScroll(nTaskId)
	
	if nTaskId==0 then
		self:_Debug("AddScroll: Select task id error!");
		return;
	end;
	
	local pItem = me.AddScriptItem(self.tbItemId[2], self.tbItemId[3], 1, 0, {nTaskId}, 0);
	
	me.Msg("<color=yellow>Nhận được 1 Trục cuốn nhiệm vụ<color>！");
	
	if pItem==nil then
		self:_Debug("Add scroll item error!");
		return;
	end;
	
end;


-- 檢查當天的任務是否已達上限，可以繼續發給卷軸的話就返回 1
function RandomTask:ApplyAddScroll()
	local nNum = self:GetTask(self.TSK_NUM);
	local nOldDate = self:GetTask(self.TSK_DATE);
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));  -- 獲取日期：XXXX/XX/XX 格式
	
	if nOldDate == nNowDate then
		if nNum + 1 >= self.LIMIT_NUM then
			return 0;
		end;
	else
		nNum = 0;
	end;
	
	nNum = nNum + 1;
	
	self:SetTask(self.TSK_NUM, nNum);
	self:SetTask(self.TSK_DATE, nNowDate);
	return 1;
end;


-- 檢查一個玩家身上是否正在進行隨機任務
function RandomTask:HaveRandomTask()
	local tbTask  = nil;
	
	for i=1, #self.nMainTaskId do
		tbTask = Task:GetPlayerTask(me).tbTasks[self.nMainTaskId[i]];
		if tbTask ~= nil then
			return tbTask.tbReferData;
		end;
	end;
	return nil;
end;

function RandomTask:GetTaskInfo(nTaskId)
	local szInfo = Task.tbReferDatas[nTaskId].tbDesc.szMainDesc;
	if szInfo=="" then
		return "Không thể nhận miêu tả nhiệm vụ!";
	end;
	return szInfo;
end;


function RandomTask:GetTask(nTaskId)
	return me.GetTask(self.TSKG_ID, nTaskId);
end;


function RandomTask:SetTask(nTaskId, nValue)
	me.SetTask(self.TSKG_ID, nTaskId, nValue);
end;


function RandomTask:_Debug(szMsg)
	print ("[RandomTask]: "..szMsg);
end;


function RandomTask:_Log(szLog)
	return
end;


-- 定時器的處理

-- 玩家上線時注冊一次計時器
function RandomTask:Register()
	
	self:_Debug("Start register randomtask event.");
	
	local tbData = self:PlayerTempData();
	if (not tbData.nTimerId) then
		self:_Debug("Register timer event!");
		tbData.nTimerId	= Timer:Register(self.CHECKTIME * 18, self.OnTimer, self, me.nId);
	end;
	-- 注冊下線事件
	if (not tbData.nLogoutId) then
		self:_Debug("Register logout id!");
		tbData.nLogoutId = PlayerEvent:Register("OnLogout", RandomTask.OnLogout, RandomTask);
	end;
	
end;

function RandomTask:OnTimer(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	if (not pPlayer) then
		return;
	end
	me = pPlayer;
	self:OnStart();
	return self.CHECKTIME * 18;  -- 設置多少秒刷新一次
end;


-- 玩家的下線事件
function RandomTask:OnLogout()
	self:StopTimer();
end;


-- 下線時調用
function RandomTask:StopTimer()
	self:_Debug("Player logout, remove timer event.");
	Timer:Close(self:GetPlayerTimerId());
end;

-- 獲取玩家的隨機任務 Timer ID，如果沒有，返回 -1
function RandomTask:GetPlayerTimerId()

		if (not self:PlayerTempData().nTimerId) then
			self:_Debug("Can't get temp timer id!");
			return -1;
		end;
		
		return self:PlayerTempData().nTimerId;
end;


-- 玩家的臨時數據
function RandomTask:PlayerTempData()
	local tbPlayerData	 = me.GetTempTable("Task");  -- 玩家的臨時表格
	if (not tbPlayerData.RandomTask) then
		tbPlayerData.RandomTask = {};
	end;
	return tbPlayerData.RandomTask;
end;


-- RandomTask:OnInit();
