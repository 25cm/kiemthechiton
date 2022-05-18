-- 殺掉指定Npc此任務完成,但是這個指定的Npc要通過對話才能Call出來
-- 一個隊伍中任何接這個目標的人均可共享
-- Npc被殺後指定時間變為對話Npc
-- 注意：兩個Npc都是不能復生的。

local tb = Task:GetTarget("Dialog2Fight");
tb.szTargetName		= "Dialog2Fight";


function tb:Init(nMapId, nMapPosX, nMapPosY, nDialogNpcTempId, szOption, szMsg, nFightNpcTempId, nFightNpcLevel, nDeathDuration, szBeforePop, szLaterPop)
	self.nMapId				= nMapId;
	self.szMapName			= Task:GetMapName(nMapId);
	self.nMapPosX			= nMapPosX;
	self.nMapPosY			= nMapPosY;
	self.nDialogNpcTempId	= nDialogNpcTempId;
	self.szDialogNpcName	= KNpc.GetNameByTemplateId(nDialogNpcTempId);
	self.szOption			= szOption;
	self.szMsg				= szMsg;
	self.nFightNpcTempId	= nFightNpcTempId;
	self.szFightNpcName		= KNpc.GetNameByTemplateId(nFightNpcTempId);
	self.nFightNpcLevel		= nFightNpcLevel;
	self.nDeathDuration		= nDeathDuration;
	self.szBeforePop		= szBeforePop;
	self.szLaterPop			= szLaterPop;
	self:IniTarget();
end;


function tb:IniTarget()
	if (MODULE_GAMESERVER) then
		if (not self.bExist or self.bExist == 0) then
			local pDialogNpc = KNpc.Add2(self.nDialogNpcTempId, 1, -1, self.nMapId, self.nMapPosX, self.nMapPosY);
			if (not pDialogNpc) then
				return;
			end
			self.nDialogNpcId = pDialogNpc.dwId;
			Timer:Register(Env.GAME_FPS * 60, self.OnCheckNpcExist, self);
			self.bExist = 1; -- 隻添加一次
		end
		
	end
end;

-- 用於防止意外造成Npc丟失
function tb:OnCheckNpcExist()
	if (Task:IsNpcExist(self.nDialogNpcId, self) == 1) then
		return;
	end
	
	if (Task:IsNpcExist(self.nFightNpcId, self) == 1) then
		return;
	end
	if (self.nReviveDurationTimeId) then
		return;
	end
	
	print("TaskNpcMiss", self.nDialogNpcId, self.nFightNpcId, self.nReviveDurationTimeId);
	print(debug.traceback());
	
	self.nDialogNpcId = nil;
	self.nFightNpcId  = nil;
	
	if (MODULE_GAMESERVER) then
		self.nReviveDurationTimeId = Timer:Register(Env.GAME_FPS * self.nDeathDuration, self.AddDialogNpc, self);
	end;
end

--目標開啟
function tb:Start()
	self.bDone	= 0;
	self:RegisterTalk();
end;


--目標保存
--根據任務變量組Id（nGroupId）以及組內變量起始Id（nStartTaskId），保存本目標的運行期數據
--返回實際存入的變量數量
function tb:Save(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	self.me.SetTask(nGroupId, nStartTaskId, self.bDone);
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
	self.bDone	= self.me.GetTask(nGroupId, nStartTaskId);
	
	if (not self:IsDone()) then	-- 本目標是一旦達成後不會失效的
		self:RegisterTalk();
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
	local szMsg	= "Đánh bại ";
	if (self.nMapId ~= 0) then
		szMsg	= szMsg..self.szMapName.." - ";
	end;
	szMsg	= szMsg..self.szFightNpcName;
	
	return szMsg;
end;

function tb:Close(szReason)
	self:UnRegisterTalk(); -- 注銷NPC對話
end;


function tb:RegisterTalk()
	self.tbTask:AddNpcMenu(self.nDialogNpcTempId, self.nMapId, self.szOption, self.OnTalkNpc, self);
end;


function tb:UnRegisterTalk()
	self.tbTask:RemoveNpcMenu(self.nDialogNpcTempId);
end;


function tb:OnTalkNpc()
	if (not him) then
		return;
	end;
	
	if (self.nDialogNpcId ~= him.dwId) then
		return;
	end
	
	local oldPlayer = me;
	me = self.me;
	TaskAct:Talk(self.szMsg, self.OnTalkFinish, self);
	me = oldPlayer;
end;


function tb:OnTalkFinish()
	assert(self._tbBase._tbBase)
	assert (MODULE_GAMESERVER);
	
	self:Dialog2Fight();
end;

function tb:Dialog2Fight()
	if (not self._tbBase.nDialogNpcId) then
		-- 被別人先領一步
		return;
	end
	
	-- 刪除對話Npc
	local pDialogNpc = KNpc.GetById(self._tbBase.nDialogNpcId);
	assert(pDialogNpc);
	
	local nCurMapId, nCurPosX, nCurPosY = pDialogNpc.GetWorldPos();
	Task.tbToBeDelNpc[self._tbBase.nDialogNpcId] = 0;
	pDialogNpc.Delete();
	self._tbBase.nDialogNpcId = nil;

		
	--然後在指定位置（玩家位置）添加一個戰斗Npc
	local pFightNpc	= KNpc.Add2(self.nFightNpcTempId, self.nFightNpcLevel, -1, nCurMapId, nCurPosX, nCurPosY);
	self._tbBase.nFightNpcId = pFightNpc.dwId;
	assert(pFightNpc);
	Npc:RegPNpcOnDeath(pFightNpc, self.OnFightDeath, self._tbBase);
end


-- 靜態注冊,當Npc死亡後會開始計時，到30秒後New新的Npc然後注銷
function tb:RiseDialogNpc()
	assert(self._tbBase)
	assert(self._tbBase._tbBase == nil)
	if (MODULE_GAMESERVER) then
		self.nReviveDurationTimeId = Timer:Register(Env.GAME_FPS * self.nDeathDuration, self.AddDialogNpc, self);
		Timer.tbAttach[self.nReviveDurationTimeId] = 1;
	end;
end;



-- 添加一個對話Npc
function tb:AddDialogNpc()
	assert(not self.nDialogNpcId);
	assert(not self.nFightNpcId);
	assert(not self._tbBase._tbBase);
	assert(self._tbBase);
	
	-- 避免下面assert造成重復調用
	if (not self.nReviveDurationTimeId) then
		return 0;
	end
	Timer.tbAttach[self.nReviveDurationTimeId] = nil;
	self.nReviveDurationTimeId = nil;
	
	local pDialogNpc = KNpc.Add2(self.nDialogNpcTempId, 1, -1, self.nMapId, self.nMapPosX, self.nMapPosY);
	assert(pDialogNpc);
	
	self.nDialogNpcId = pDialogNpc.dwId;
	Task.tbToBeDelNpc[self.nDialogNpcId] = 1;
	return 0;
end


-- 戰斗Npc死亡，一段時間後會生出對話Npc
function tb:OnFightDeath()
	assert(self._tbBase);
	assert(not self._tbBase._tbBase);
	
	if (self.nFightNpcId and him.dwId == self.nFightNpcId) then
		self.nFightNpcId = nil;
		self:RiseDialogNpc();
	else
		assert(false);
	end
end;


function tb:OnKillNpc(pPlayer, pNpc)
	if (self:IsDone()) then
		return;
	end;
	
	if (pNpc.dwId ~= self._tbBase.nFightNpcId) then
		return;
	end
	
	self.bDone	=  1;
	
	local tbSaveTask	= self.tbSaveTask;
	if (MODULE_GAMESERVER and tbSaveTask) then	-- 自行同步到客戶端，要求客戶端刷新
		self.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId, self.bDone, 1);
		KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
	end;
	
	if (self:IsDone()) then	-- 本目標是一旦達成後不會失效的
		self.me.Msg("Mục tiêu:"..self:GetStaticDesc());
		self:UnRegisterTalk();
		self.tbTask:OnFinishOneTag();
	end;
end
