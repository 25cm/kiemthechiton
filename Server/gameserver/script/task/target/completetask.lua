-------------------------------------------------------
-- 文件名　：completetask.lua
-- 文件描述：需要完成指定任務 [暫且隻用於老玩家召回任務]
-- 創建者　：ZhangDeheng
-- 創建時間：2009-03-06 09:28:22
-------------------------------------------------------
local tb	= Task:GetTarget("CompleteTask");

tb.szTargetName	= "CompleteTask";
tb.REFRESH_FRAME	= 18;	-- 一秒檢測一次

function tb:Init(nTaskGroupId, nTaskId, nNeedCount, szStaticDesc, szDynamicDesc)
	self.nTaskGroupId			= nTaskGroupId;
	self.nTaskId				= nTaskId;
	self.nNeedCount				= nNeedCount;
	self.szStaticDesc			= szStaticDesc or szDynamicDesc;
	self.szDynamicDesc			= szDynamicDesc;
end;

--目標開啟
function tb:Start()
	self.bDone		= 0;
	self:Register();
end;

function tb:Save(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	self.me.SetTask(nGroupId, nStartTaskId, self.bDone, 1);
	return 1;
end;

function tb:Load(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	self.bDone		= self.me.GetTask(nGroupId, nStartTaskId);

	if (not self:IsDone()) then	-- 本目標是一旦達成後不會失效的
		self:Register();
	end;
	return 1;
end;

function tb:IsDone()
	return self.bDone == 1;
end;

function tb:GetDesc()
	local szMsg = "";
	if (not self:IsDone()) then
		local nCount = self.me.GetTask(self.nTaskGroupId, self.nTaskId);
		szMsg	= string.format("%s：%d/%d", self.szDynamicDesc, nCount, self.nNeedCount);
	else
		szMsg 	= self.szDynamicDesc .. ": Hoàn thành";
	end;
	return szMsg;
end;

function tb:GetStaticDesc()
	return self.szStaticDesc;
end;

function tb:Close(szReason)
	self:UnRegister();
end;

function tb:Register()
	if (MODULE_GAMESERVER and not self.nRegisterId) then
		self.nRegisterId	= Timer:Register(self.REFRESH_FRAME, self.OnTimer, self);
	end;
end;

function tb:UnRegister()
	if (MODULE_GAMESERVER and self.nRegisterId) then
		Timer:Close(self.nRegisterId);
		self.nRegisterId	= nil;
	end;
end;

function tb:OnTimer()
	local tbSaveTask	= self.tbSaveTask;
	if (MODULE_GAMESERVER and tbSaveTask) then	-- 要求客戶端刷新
		KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
	end;
	
	if (self.me.GetTask(self.nTaskGroupId, self.nTaskId) >= self.nNeedCount) then
		self.bDone = 1;
		
		local tbSaveTask	= self.tbSaveTask;
		if (MODULE_GAMESERVER and tbSaveTask) then	-- 自行同步到客戶端，要求客戶端刷新
			self.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId, self.bDone, 1);
			KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
		end;
	
		self.me.Msg("Mục tiêu:"..self:GetStaticDesc());
	
		self:UnRegister()	-- 本目標是一旦達成後不會失效的
	
		self.tbTask:OnFinishOneTag();
	end
end
