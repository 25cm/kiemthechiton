
local tb	= Task:GetTarget("Timer");
tb.szTargetName	= "Timer";

--	nMode，操作模式：
--		0、執行，到0後執行自定義腳本，並重新開始計數，此目標永遠是已達成
--		1、失敗，到0後執行自定義腳本，任務失敗，在到0之前是已達成
--		2、成功，到0後執行自定義腳本，目標達成

function tb:Init(nTotalSec, nMode, szCode)
	self.nTotalSec	= nTotalSec;
	self.nMode		= nMode;
	if (szCode ~= "") then
		self.fnCall	= loadstring(szCode);
	end;
end;

function tb:Start()
	self.nRestFrame	= self.nTotalSec * 18;
	self:Register();
end;

function tb:Save(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};

	self.me.SetTask(nGroupId, nStartTaskId, self.nRestFrame);
	return 1;
end;

function tb:Load(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	self.nRestFrame	= self.me.GetTask(nGroupId, nStartTaskId);

	if (self.nRestFrame ~= 0) then	-- 一旦計時到0，一定是達成了
		self:Register();
	end;
	
	return 1;
end;

function tb:IsDone()
	return self.nRestFrame <= 0 or self.nMode ~= 2;
end;

function tb:GetDesc()
	return "剩余時間："..self:GetTimeStr(math.ceil(self.nRestFrame/18));
end;

function tb:GetStaticDesc()
	return "限時："..self:GetTimeStr(self.nTotalSec);
end;

function tb:Close(szReason)
	self:UnRegister();
end;


function tb:Register()
	if (MODULE_GAMESERVER and not self.nRegisterId) then
		self.nRegisterId	= Timer:Register(18, self.OnTimer, self);
	end;
end;

function tb:UnRegister()
	if (MODULE_GAMESERVER and self.nRegisterId) then
		Timer:Close(self.nRegisterId);
		self.nRegisterId	= nil;
	end;
end;


function tb:OnTimer()
	self.nRestFrame	= self.nRestFrame - 18;
	
	if (self.nRestFrame > 0) then
		if (MODULE_GAMESERVER) then
			self.me.SetTask(self.tbSaveTask.nGroupId, self.tbSaveTask.nStartTaskId, self.nRestFrame, 1);
			KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, self.tbSaveTask.nGroupId);
		end
		
		return 18;
	end
	
	-- 完成了
	self.nRestFrame = 0;
	if (self.nMode == 0) then
		--無響應
		if (self.fnCall) then
			self.fnCall();
		end;
	elseif (self.nMode == 1) then
		--失敗
		if (self.fnCall) then
			self.fnCall();
		end;
		self.nRegisterId	= nil;	-- 先清除，防止重復注銷
		Task:Failed(self.tbTask.nTaskId)	-- 此函數在調用後應盡快全部返回，停止此任務的處理，否則容易出現異常
		return 0;	-- 返回0表示注銷Timer
	elseif (self.nMode == 2) then
		--成功
		if (self.fnCall) then
			self.fnCall();
		end;
		self.me.Msg("Mục tiêu:"..self:GetStaticDesc());
		self.tbTask:OnFinishOneTag();
	end;


	if (MODULE_GAMESERVER) then
		self.me.SetTask(self.tbSaveTask.nGroupId, self.tbSaveTask.nStartTaskId, self.nRestFrame, 1);
		KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, self.tbSaveTask.nGroupId);
	end
		
	if (self.nRestFrame == 0) then
		self.nRegisterId	= nil;	-- 先清除，防止重復注銷
	end;
	
	return 0;	
end;

function tb:GetTimeStr(nSec)
	local nMin	= math.floor(nSec / 60);
	local nHour	= math.floor(nMin / 60);
	local nDay	= math.floor(nHour / 24);
	nSec	= math.mod(nSec, 60);
	nMin	= math.mod(nMin, 60);
	nHour	= math.mod(nHour, 24);
	if (nDay > 0) then
		return string.format("%d ngày %d giờ", nDay, nHour);
	elseif (nHour > 0) then
		return string.format("%d giờ %d phút", nHour, nMin);
	else
		return string.format("%d phút %d giây", nMin, nSec);
	end;
end;
