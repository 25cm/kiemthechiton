--- 進度條目標
local tb	= Task:GetTarget("WithProcessAddNpc");
tb.szTargetName	= "WithProcessAddNpc";
tb.REFRESH_FRAME	= 18;

function tb:Init(nNpcTempId, nMapId, nMapX, nMapY, nIntervalTime, nFightNpcId, nFightNpcLevel, szPos, nNeedCount, szDynamicDesc, szStaticDesc)
	self.nNpcTempId			= nNpcTempId;
	self.szNpcName			= KNpc.GetNameByTemplateId(nNpcTempId);
	self.nMapId				= nMapId;
	self.szMapName			= Task:GetMapName(nMapId);
	self.nMapX				= nMapX;
	self.nMapY				= nMapY;
	self.nIntervalTime		= nIntervalTime * self.REFRESH_FRAME;
	
	self.szProcessInfo		= "Đang tiến hành";
	self.szSucMsg			= "Thành công";
	self.szFailedMsg		= "Thất bại";
	
	self.nFightNpcId		= nFightNpcId;
	self.nFightNpcLevel		= nFightNpcLevel;
	self.tbNpcPos			= self:ParsePos(szPos);
	self.nNeedCount			= nNeedCount;
	
	self.szDynamicDesc		= szDynamicDesc;
	self.szStaticDesc	  	= szStaticDesc;

	self:IniTarget();
end;

function tb:IniTarget()
	if (MODULE_GAMESERVER) then
		if (not self.bExist or self.bExist == 0) then
			local pProcessNpc = KNpc.Add2(self.nNpcTempId, self.nFightNpcLevel, -1, self.nMapId, self.nMapX, self.nMapY);
			if (not pProcessNpc) then
				return;
			end
			self.nProcessNpcId = pProcessNpc.dwId;
			Timer:Register(Env.GAME_FPS * 60, self.OnCheckNpcExist, self);
			self.bExist = 1; -- 隻添加一次
		end
		
	end
end;

-- 用於防止意外造成Npc丟失
function tb:OnCheckNpcExist()
	if (Task:IsNpcExist(self.nProcessNpcId, self) == 1) then
		return;
	end
	
	if (self.nReviveDurationTimeId) then
		return;
	end
	
	print("TaskNpcMiss", self.nDialogNpcId, self.nReviveDurationTimeId);
	print(debug.traceback());
	
	self.nProcessNpcId = nil;
	
	if (MODULE_GAMESERVER) then
		self.nReviveDurationTimeId = Timer:Register(Env.GAME_FPS * self.nDeathDuration, self.AddProcessNpc, self);
	end;
end

-- 添加一個對話Npc
function tb:AddProcessNpc()
	assert(not self.nFightNpcId);
	
	-- 避免下面assert造成重復調用
	if (not self.nReviveDurationTimeId) then
		return 0;
	end

	self.nReviveDurationTimeId = nil;
	
	local pProcessNpc = KNpc.Add2(self.nNpcTempId, self.nFightNpcLevel, -1, self.nMapId, self.nMapX, self.nMapY);
	assert(pProcessNpc);
	
	self.nProcessNpcId = pProcessNpc.dwId;
	Task.tbToBeDelNpc[self.nProcessNpcId] = 1;
	return 0;
end

function tb:ParsePos(szPos)
	local tbRet = {};
	
	if (szPos and szPos ~= "") then
		local tbTrack = Lib:SplitStr(szPos, "\n")
		for i=1, #tbTrack do
			if (tbTrack[i] and tbTrack[i] ~= "") then
				tbRet[i] = {};
				local tbPos = Lib:SplitStr(tbTrack[i]);
				tbRet[i].nX = tonumber(tbPos[1]);
				tbRet[i].nY = tonumber(tbPos[2]);
			end
		end
	end
	
	return tbRet;
end

function tb:Start()
	self.nCount = 0;
	self:Register();
end;

function tb:Save(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
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
	if (not self:IsDone()) then	-- 本目標是一旦達成後不會失效的
		self:Register();
	end;
	
	return 1;
end;


function tb:IsDone()
	return self.nCount >= self.nNeedCount;
end;


function tb:GetDesc()
	local bHasTag = 0;
	local bTagStart, bTagEnd = string.find(self.szDynamicDesc, "%%d");
	if (bTagEnd) then
		bHasTag = bHasTag + 1;	
		bTagStart, bTagEnd = string.find(self.szDynamicDesc, "%%d", bTagEnd + 1);
		if (bTagEnd) then
			bHasTag = bHasTag + 1;
		end
	end
	
	if (bHasTag == 1) then
		return string.format(self.szDynamicDesc, self.nCount);
	elseif (bHasTag == 2) then
		return string.format(self.szDynamicDesc, self.nCount, self.nNeedCount);
	else
		return self.szDynamicDesc;
	end
end;


function tb:GetStaticDesc()
	return self.szStaticDesc;
end;




function tb:Close(szReason)
	self:UnRegister();
end;


function tb:Register()
	self.tbTask:AddExclusiveDialog(self.nNpcTempId, self.SelectOpenBox, self);
end;

function tb:UnRegister()
	self.tbTask:RemoveNpcExclusiveDialog(self.nNpcTempId);
end;


-- 玩家選擇開
function tb:SelectOpenBox()
	if (self.nMapId ~= 0 and self.nMapId ~= self.me.GetMapId()) then
		print(self.nMapId, self.me.GetMapId());
		self.me.Msg("Đây không phải là bản đồ cần mở"..self.szNpcName.."Xin hãy đến "..self.szMapName)
		return;
	end;

	if (self:IsDone()) then
		self.me.Msg(self.szFailedMsg)
		return;
	end;

	self.nCurTagIdx = him.dwId;

	Task:SetProgressTag(self, self.me);
	KTask.StartProgressTimer(self.me, self.nIntervalTime, self.szProcessInfo);
end;


function tb:OnProgressFull()
	self:AddFightNpc();
end;

function tb:AddFightNpc()	
	local tbNpcList = KNpc.GetMapNpcWithName(self.nMapId, KNpc.GetNameByTemplateId(self.nFightNpcId));
	if (tbNpcList and #tbNpcList > self.nNeedCount * 2) then
		return; -- 最多存在2倍的
	end;
	
	for i = 1, #self.tbNpcPos do
		local pNpc = KNpc.Add2(self.nFightNpcId, self.nFightNpcLevel, -1, self.nMapId, self.tbNpcPos[i].nX, self.tbNpcPos[i].nY);
		if (not pNpc or pNpc.nIndex == 0) then
			print("[Task Error]:"..self.nNpcTempId.." thêm thất bại!");
		end;
	end;
end;

function tb:OnKillNpc(pPlayer, pNpc)
	if (self:IsDone()) then
		return;
	end;
	if (self.nFightNpcId ~= pNpc.nTemplateId) then
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
	
	if (self:IsDone()) then	-- 本目標是一旦達成後不會失效的
		self.me.Msg("目標達成："..self:GetStaticDesc());
		self.tbTask:OnFinishOneTag();
	end;
end;
