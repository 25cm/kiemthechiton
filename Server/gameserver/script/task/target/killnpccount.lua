
local tb	= Task:GetTarget("KillNpcCount");
tb.szTargetName	= "KillNpcCount";

function tb:Init(nNpcTempId, nMapId, nNeedCount, nTaskValueId, szBeforePop, szLaterPop)
	self.nNpcTempId		= nNpcTempId;
	self.szNpcName		= KNpc.GetNameByTemplateId(nNpcTempId);
	self.nMapId			= nMapId;
	self.szMapName		= Task:GetMapName(nMapId);
	self.nNeedCount		= nNeedCount;
	self.nTaskValueId	= nTaskValueId;
	self.szBeforePop	= szBeforePop;
	self.szLaterPop		= szLaterPop;
end;

function tb:Start()
	self.nCount		= 0;
end;

function tb:Save(nGroupId, nStartTaskId)
	return 0	-- 隨時保存的，此時不需要再保存
end;

function tb:Load(nGroupId, nStartTaskId)
	self.nCount	= self.me.GetTask(nGroupId, self.nTaskValueId);
	return 0	-- 有特定的保存位置，不進行統一讀取
end;

function tb:IsDone()
	return self.nCount >= self.nNeedCount;
end;

function tb:GetDesc()
	local szMsg	= "Đánh bại ";
	if (self.nMapId ~= 0) then
		szMsg	= szMsg..self.szMapName.." - ";
	end;
	szMsg	= szMsg..string.format("%s： %d", self.szNpcName, self.nCount);
	if (self.nNeedCount ~= 0) then
		szMsg	= szMsg.."/"..self.nNeedCount;
	end;
	return szMsg;
end;

function tb:GetStaticDesc()
	local szMsg	= "Đánh bại ";
	if (self.nMapId ~= 0) then
		szMsg	= szMsg..self.szMapName.." - ";
	end;
	szMsg	= szMsg..string.format("%s", self.szNpcName);
	if (self.nNeedCount ~= 0) then
		szMsg	= szMsg..string.format(" hơn %d", self.nNeedCount);
	end;
	return szMsg;
end;


function tb:Close(szReason)

end;


-- pPlayer 為殺死NPC的玩家
function tb:OnKillNpc(pPlayer, pNpc)
	if (self.nNpcTempId ~= pNpc.nTemplateId) then
		return;
	end;
	if (self.nMapId ~= 0 and self.nMapId ~= self.me.GetMapId()) then
		return;
	end;
	self.nCount	= self.nCount + 1;
	if (MODULE_GAMESERVER) then	-- 自行同步到客戶端，要求客戶端刷新
		local tbTask	= self.tbTask;
		self.me.SetTask(tbTask.nSaveGroup, self.nTaskValueId, self.nCount, 1);
		KTask.SendRefresh(self.me, tbTask.nTaskId, tbTask.nReferId, tbTask.nSaveGroup);
	end;
	
	if (self:IsDone()) then
		self.tbTask:OnFinishOneTag();
	end
end;
