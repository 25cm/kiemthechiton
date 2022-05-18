
local tb	= Task:GetTarget("BagSpace");
tb.szTargetName	= "BagSpace";
tb.REFRESH_FRAME	= 18;	-- 一秒檢測一次

function tb:Init(nBagType, nNeedSpaceCount)
	self.nBagType			= nBagType;
	self.nNeedSpaceCount	= nNeedSpaceCount;
end;

function tb:Start()
	-- nothing
end;

function tb:Save(nGroupId, nStartTaskId)
	self.nGroupId = nGroupId;
	return 0;
end;

function tb:Load(nGroupId, nStartTaskId)
	self:Register();
	self.nGroupId = nGroupId;
	return 0;
end;

function tb:IsDone()
	return self:GetBagSpaceCount() >= self.nNeedSpaceCount;
end;

function tb:GetDesc()
	local szMsg	= string.format("Cần %s: %d/%d", "Chỗ trống", self:GetBagSpaceCount(), self.nNeedSpaceCount);
	return szMsg;
end;

function tb:GetStaticDesc()
	local szMsg	= string.format("Cần %s: %d", "Chỗ trống", self.nNeedSpaceCount);
	return szMsg;
end;

function tb:Close(szReason)
	self:UnRegister();
end;

function tb:Register()
	-- 客戶端實時檢查物品數量
	if (MODULE_GAMECLIENT) then
		if (not self.nRegisterId) then
			self.nRegisterId	= Timer:Register(self.REFRESH_FRAME, self.OnTimer, self);
			self.nCount			= self:GetBagSpaceCount();
		end;
	end;
end;

function tb:UnRegister()
	-- 客戶端關閉實時監視
	if (MODULE_GAMECLIENT) then
		if (self.nRegisterId) then
			Timer:Close(self.nRegisterId);
			self.nRegisterId	= nil;
		end;
	end;
end;


function tb:OnTimer(nTickCount)
	if (self:GetBagSpaceCount() ~= self.nCount) then
		self.nCount = self:GetBagSpaceCount();
	else
		return self.REFRESH_FRAME;
	end;
	
	if (MODULE_GAMESERVER) then	-- 自行同步到客戶端，要求客戶端刷新
		KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, self.nGroupId);
	end;
	
	-- UNDONE:背包滿自動觸發不合常理
--[[	
	if (self:IsDone()) then
		self.tbTask:OnFinishOneTag();
	end
--]]
	
	return self.REFRESH_FRAME;
end;


function tb:GetBagSpaceCount()
	if (MODULE_GAMESERVER) then	-- 服務端每次重新計算
		return me.CalcFreeItemCellCount();
	else	-- 客戶端檢查過頻，使用緩沖
		return self.nCount;
	end;
end;
