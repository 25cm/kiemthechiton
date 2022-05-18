
local tb	= Task:GetTarget("JoinFaction");
tb.szTargetName	= "JoinFaction";

function tb:Init(nFactionId, szDynamicDesc, szStaticDesc)
	self.nFactionId 		= nFactionId;
	self.szDynamicDesc		= szDynamicDesc;
	self.szStaticDesc		= szStaticDesc;	
end;



function tb:Start()
	self.bDone		= 0;
	
	if (self.nFactionId == 0) then
		if (self.me.nFaction > 0) then
			self.bDone = 1;
		end
	else
		if (self.me.nFaction == self.nFactionId) then
			self.bDone = 1;
		end
	end
	if (self.bDone == 1) then
		local tbSaveTask	= self.tbSaveTask;
		if (MODULE_GAMESERVER and tbSaveTask) then	-- 自行同步到客戶端，要求客戶端刷新
			self.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId, self.bDone, 1);
			KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
		end;
		self.tbTask:OnFinishOneTag();
	else
		self:Register();	
	end	 
	
end;


function tb:Save(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	self.me.SetTask(nGroupId, nStartTaskId, self.bDone);
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

--返回目標是否達成
function tb:IsDone()
	return self.bDone == 1;
end;

--返回目標進行中的描述（客戶端）
function tb:GetDesc()
	return self.szDynamicDesc or "";
end;


--返回目標的靜態描述，與當前玩家進行的情況無關
function tb:GetStaticDesc()
	return self.szStaticDesc or "";
end;



function tb:Close(szReason)
	self:UnRegister();
end;


function tb:Register()
	assert(self._tbBase._tbBase)	--沒有經過兩次派生，腳本書寫錯誤
	local oldPlayer = me;
	me = self.me;
	if (MODULE_GAMESERVER and not self.nRegisterId) then
		self.nRegisterId	= PlayerEvent:Register("OnFactionChange", self.OnFactionChange, self);
	end;
	me = oldPlayer;
end;


function tb:UnRegister()
	assert(self._tbBase._tbBase)	--沒有經過兩次派生，腳本書寫錯誤
	local oldPlayer = me;
	me = self.me;
	if (MODULE_GAMESERVER and self.nRegisterId) then
		PlayerEvent:UnRegister("OnFactionChange", self.nRegisterId);
		self.nRegisterId	= nil;
	end;
	me = oldPlayer;
end;

function tb:OnFactionChange(nFactionId)
	if (self:IsDone()) then
		return;
	end
	
	if (self.nFactionId == 0) then
		if (self.me.nFaction > 0) then
			self.bDone = 1;
		end
	else
		if (self.me.nFaction == self.nFactionId) then
			self.bDone = 1;
		end
	end
	
	local tbSaveTask	= self.tbSaveTask;
	if (MODULE_GAMESERVER and tbSaveTask) then	-- 自行同步到客戶端，要求客戶端刷新
		self.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId, self.bDone, 1);
		KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
	end;
	self.me.Msg("Mục tiêu:"..self:GetStaticDesc());
	self:UnRegister();
	self.tbTask:OnFinishOneTag();
end
