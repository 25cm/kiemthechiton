-- 一旦指定任務變量改變為指定值觸發此目標達成

local tb	= Task:GetTarget("RequireTaskValue");
tb.szTargetName	= "RequireTaskValue";
tb.REFRESH_FRAME	= 18;	-- 一秒檢測一次

function tb:Init(nTaskGroupId, nTaskId, nStartTaskValue, nNeedTaskValue, szStaticDesc, szDynamicDesc)
	self.nTaskGroupId 			= nTaskGroupId;
	self.nTaskId						= nTaskId;
	self.nStartTaskValue		= nStartTaskValue;
	self.nNeedTaskValue			= nNeedTaskValue;
	self.szStaticDesc				= szStaticDesc;
	self.szDynamicDesc			= szDynamicDesc;
end;


--目標開啟
function tb:Start()
	self.bDone		= 0;
	self:Register();
end;

--目標保存
--根據任務變量組Id（nGroupId）以及組內變量起始Id（nStartTaskId），保存本目標的運行期數據
--返回實際存入的變量數量
function tb:Save(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	self.me.SetTask(nGroupId, nStartTaskId, self.bDone, 1);
	return 1;
end;

--目標載入
--根據任務變量組Id（nGroupId）以及組內變量起始Id（nStartTaskId），載入本目標的運行期數據
--返回實際載入的變量數量
function tb:Load(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	
	self.bDone		= self.me.GetTask(nGroupId, nStartTaskId);
	if (self:IsDone()) then
		return 1;
	end;
	
	local nTaskValue = self.me.GetTask(self.nTaskGroupId, self.nTaskId);
	if (nTaskValue == self.nNeedTaskValue) then
		self:OnTaskValueChange();
		return 1;
	end;
		
	self:Register();
	return 1;
end;
		
--返回目標是否達成
function tb:IsDone()
	return self.bDone == 1;
end;

--返回目標進行中的描述（客戶端）
function tb:GetDesc()
	return self.szDynamicDesc;
end;


--返回目標的靜態描述，與當前玩家進行的情況無關
function tb:GetStaticDesc()
	return self.szStaticDesc;
end;


function tb:Close(szReason)
	self:UnRegister();
end;

function tb:Register()
	assert(self._tbBase._tbBase)	--沒有經過兩次派生，腳本書寫錯誤
	local oldPlayer = me;
	me = self.me;
	if (MODULE_GAMESERVER and not self.nRegisterId) then
		if (self.nTaskGroupId == 1022 and self.nTaskId == 119) then
			local nOldTask = self.me.GetTask(self.nTaskGroupId, self.nTaskId);
			if (nOldTask == 1) then
				print("Task Value Set Error");
				print(debug.traceback());
			end
		end
		
		self.me.SetTask(self.nTaskGroupId, self.nTaskId, self.nStartTaskValue, 1);
		self.nRegisterId	= Timer:Register(self.REFRESH_FRAME, self.OnTaskValueChange, self);
	end;
	me = oldPlayer;
end;

function tb:UnRegister()
	assert(self._tbBase._tbBase)	--沒有經過兩次派生，腳本書寫錯誤
	local oldPlayer = me;
	me = self.me;
	if (MODULE_GAMESERVER and self.nRegisterId) then
		Timer:Close(self.nRegisterId);
		self.nRegisterId	= nil;
	end;
	me = oldPlayer;
end;


function tb:OnTaskValueChange()
	local nTaskValue = self.me.GetTask(self.nTaskGroupId, self.nTaskId);
	if (nTaskValue == self.nNeedTaskValue) then
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

