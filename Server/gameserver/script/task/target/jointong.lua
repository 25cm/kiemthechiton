-------------------------------------------------------
-- 文件名　：jointong.lua
-- 文件描述：成為幫會正式成員
-- 創建者　：ZhangDeheng
-- 創建時間：2009-03-04 10:11:59
-------------------------------------------------------

local tb	= Task:GetTarget("JoinTong");
tb.szTargetName	= "JoinTong";
tb.REFRESH_FRAME	= 18;	-- 一秒檢測一次

function tb:Init(szStaticDesc, szDynamicDesc)
	self.szStaticDesc	= szStaticDesc;
	self.szDynamicDesc	= szDynamicDesc;
end;

function tb:Start()
	self.bDone = 1;
	if (not self.me.dwTongId or self.me.dwTongId <= 0) then
		self.bDone = 0;
	end;
	local nKinId, nMemberId = self.me.GetKinMember();
	if (not nKinId or not nMemberId) then
		self.bDone = 0;
	end;
	if Kin:HaveFigure(nKinId, nMemberId, Kin.FIGURE_REGULAR) ~= 1 then
		self.bDone = 0;
	end	
	if (self:IsDone()) then	-- 本目標是一旦達成後不會失效的
		self.me.Msg("目標達成："..self:GetStaticDesc());
		self.tbTask:OnFinishOneTag();
		return;
	end;
	
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
	
	if (self.bDone ~= 1) then
		self:Register();
	end
	
	return 1;
end;

function tb:IsDone()
	return self.bDone == 1;
end;

function tb:GetDesc()
	return self.szDynamicDesc;
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
	self.bDone = 1;
	if (not self.me.dwTongId or self.me.dwTongId <= 0) then
		self.bDone = 0;
	end;
	local nKinId, nMemberId = self.me.GetKinMember();
	if (not nKinId or not nMemberId) then
		self.bDone = 0;
	end;
	if Kin:HaveFigure(nKinId, nMemberId, Kin.FIGURE_REGULAR) ~= 1 then
		self.bDone = 0;
	end	
	
	if (self:IsDone()) then
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
