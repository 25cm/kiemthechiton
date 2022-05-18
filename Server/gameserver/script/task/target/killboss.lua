
local tb	= Task:GetTarget("KillBoss");
tb.szTargetName	= "KillBoss";

function tb:Init(nNpcTempId, nMapId, nNeedCount, szBeforePop, szLaterPop)
	self.nNpcTempId		= nNpcTempId;
	self.szNpcName		= KNpc.GetNameByTemplateId(nNpcTempId);
	self.nMapId			= nMapId;
	self.szMapName		= Task:GetMapName(nMapId);
	self.nNeedCount		= nNeedCount;
	self.szBeforePop	= szBeforePop;
	self.szLaterPop		= szLaterPop;
end;


function tb:Start()
	self.nCount		= 0;
end;


function tb:Save(nGroupId, nStartTaskId)
	self.tbSaveTask	= {
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	self.me.SetTask(nGroupId, nStartTaskId, self.nCount);
	return 1;
end;


function tb:Load(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	self.nCount		= self.me.GetTask(nGroupId, nStartTaskId);
	return 1;
end;


function tb:IsDone()
	return self.nCount >= self.nNeedCount;
end;


function tb:GetDesc()
	local szMsg	= "Đánh bại ";
	if (self.nMapId ~= 0) then
		szMsg	= szMsg..self.szMapName.." - ";
	end;
	szMsg	= szMsg..string.format("%s：%d/%d", self.szNpcName, self.nCount, self.nNeedCount);
	return szMsg;
end;


function tb:GetStaticDesc()
	local szMsg	= "Đánh bại ";
	if (self.nMapId ~= 0) then
		szMsg	= szMsg..self.szMapName.." - ";
	end;
	szMsg	= szMsg..string.format("%s%d ", self.szNpcName, self.nNeedCount);
	return szMsg;
end;


function tb:Close(szReason)

end;


function tb:OnKillNpc(pPlayer, pNpc)
	if (self:IsDone()) then
		return;
	end;
	
	if (self.nNpcTempId ~= pNpc.nTemplateId) then
		return;
	end;
	
	if (self.nMapId ~= 0 and self.nMapId ~= self.me.GetMapId()) then
		return;
	end;
	
	self.nCount	= self.nCount + 1;
	
	local tbSaveTask	= self.tbSaveTask;
	if (MODULE_GAMESERVER and tbSaveTask) then	-- 自行同步到客戶端，要求客戶端刷新
		self.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId, self.nCount, 1);
		KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
	end;
	
	
	if (self:IsDone()) then	-- 本目標是一旦達成後不會失效 - 
		self.me.Msg("Mục tiêu:"..self:GetStaticDesc());
		self.tbTask:OnFinishOneTag();
	end;
	
end;
