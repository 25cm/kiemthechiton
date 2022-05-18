
-- 使用快捷鍵目標達成
local tb	= Task:GetTarget("UseShortcut");
tb.szTargetName	= "UseShortcut";	--本目標的名字，暫時還沒用到


--目標初始化
--具體參數可在任務編輯器中自定義
function tb:Init()
	
end;

--目標開啟
function tb:Start()
	self.bDone = 0;
	self:Register();
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
	return self:GetStaticDesc();
end;

--返回目標的靜態描述，與當前玩家進行的情況無關
function tb:GetStaticDesc()
	local szMsg	= "Nhấp chuột phải vào thanh công cụ để sử dụng vật phẩm ";
	return szMsg;
end;


function tb:Close(szReason)
	self:UnRegister();
end;

----==== 以下是本目標所特有的函數定義，如有雷同，純屬巧合 ====----

function tb:Register()
	assert(self._tbBase._tbBase)	--沒有經過兩次派生，腳本書寫錯誤
	local oldPlayer = me;
	me = self.me;
	if (MODULE_GAMESERVER and not self.nRegisterId) then
		self.nRegisterId	= PlayerEvent:Register("OnUseShortcut", self.OnUseShortcut, self);
	end;
	me = oldPlayer;
end;

function tb:UnRegister()
	assert(self._tbBase._tbBase)	--沒有經過兩次派生，腳本書寫錯誤
	local oldPlayer = me;
	me = self.me;
	if (MODULE_GAMESERVER and self.nRegisterId) then
		PlayerEvent:UnRegister("OnUseShortcut", self.nRegisterId);
		self.nRegisterId	= nil;
	end;
	me = oldPlayer;
end;


function tb:OnUseShortcut()
	if (self:IsDone()) then
		return;
	end;
	
	self.bDone = 1;
	local tbSaveTask	= self.tbSaveTask;
	if (MODULE_GAMESERVER and tbSaveTask) then	-- 自行同步到客戶端，要求客戶端刷新
		self.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId, self.bDone, 1);
		KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
	end;
	if (self:IsDone()) then	-- 本目標是一旦達成後不會失效的
		self.me.Msg("Mục tiêu:"..self:GetStaticDesc());
		self:UnRegister();
		self.tbTask:OnFinishOneTag();
	end;
end;
