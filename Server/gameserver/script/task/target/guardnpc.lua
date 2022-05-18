

local tb = Task:GetTarget("GuardNpc");
tb.szTargetName		= "GuardNpc";


function tb:Init(nMapId, nMapPosX, nMapPosY, nDialogNpcTempId, szOption, 
	szMsg, nFightNpcTempId, nFightNpcLevel, nFightNpcHP, nGuardDuration, 
	nDeathDuration, szStaticDesc, szDynamicDesc, szFailedMsg, szBeforePop, szLaterPop)
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
	self.nFightNpcHP		= nFightNpcHP;
	self.nFightNpcLevel		= nFightNpcLevel;
	self.nGuardDuration		= nGuardDuration;
	self.nDeathDuration		= nDeathDuration;
	self.szStaticDesc		= szStaticDesc;
	self.szDynamicDesc		= szDynamicDesc;
	self.szFailedMsg		= szFailedMsg;
	self.szBeforePop		= szBeforePop;
	self.szLaterPop			= szLaterPop;
	
	self:IniTarget();
end;


-- 初始化目標在讀取任務數據的時候執行
function tb:IniTarget()
	if (MODULE_GAMESERVER) then
		if (not self.bExist or self.bExist == 0) then
			-- 添加對話Npc
			local pDialogNpc = KNpc.Add2(self.nDialogNpcTempId, 1, -1, self.nMapId, self.nMapPosX, self.nMapPosY);
			if (not pDialogNpc) then
				return;
			end
			self.nDialogNpcId = pDialogNpc.dwId;
			Timer:Register(Env.GAME_FPS * 6, self.OnCheckNpcExist, self);
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
	
	self.nDialogNpcId = nil;
	self.nFightNpcId  = nil;
	self.nReviveDurationTimeId = nil;
	self:AddDialogNpc();
end


-- 玩家進入步驟
function tb:Start()
	self.bDone	= 0;
	self:RegisterTalk();
end;


-- 保存玩家任務數據
function tb:Save(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	self.me.SetTask(nGroupId, nStartTaskId, self.bDone);	-- 是否已經完成
	self.me.SetTask(nGroupId, nStartTaskId + 1, 0);			-- 過去的時間
	
	return 2;
end;


--目標載入
--根據任務變量組Id（nGroupId）以及組內變量起始Id（nStartTaskId），載入本目標的運行期數據
--返回實際載入的變量數量
function tb:Load(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	if (MODULE_GAMECLIENT) then
		local nCostTime			= self.me.GetTask(nGroupId, nStartTaskId + 1);
		self.nClientRestTime	= self.nGuardDuration - nCostTime;
	else
		self.me.SetTask(nGroupId, nStartTaskId + 1, 0, 1);
	end
	self.bDone	= self.me.GetTask(nGroupId, nStartTaskId);
	
	if (not self:IsDone()) then	-- 本目標是一旦達成後不會失效的
		self:RegisterTalk();
	end;
	
	return 2;
end;


--返回目標是否達成
function tb:IsDone()
	assert(self._tbBase._tbBase);
	return self.bDone == 1;
end;


--返回目標進行中的描述（客戶端）
function tb:GetDesc()
	assert(self._tbBase._tbBase);
	local szDesc = string.format(self.szDynamicDesc, self.nGuardDuration);
	if (MODULE_GAMECLIENT) then
		if (self.nClientRestTime and (not self:IsDone() and self.nClientRestTime ~= self.nGuardDuration)) then
			szDesc = szDesc.."："..self.nClientRestTime;
		end
	end
	
	return szDesc;
end;


--返回目標的靜態描述，與當前玩家進行的情況無關
function tb:GetStaticDesc()
	assert(self._tbBase._tbBase);
	return self.szStaticDesc or "";
end;


function tb:Close(szReason)
	assert(self._tbBase._tbBase);
	self:UnRegisterTimer();
	self:UnRegisterTalk(); -- 注銷NPC對話
	if (MODULE_GAMESERVER) then
		if (self.nRegisterLogoutId) then
			self:OnLogout();
		end
	end
	self:UnRegisterLogout();
end;


function tb:RegisterTalk()
	assert(self._tbBase._tbBase);
	self.tbTask:AddNpcMenu(self.nDialogNpcTempId, self.nMapId, self.szOption, self.OnTalkNpc, self);
end;

function tb:UnRegisterTalk()
	assert(self._tbBase._tbBase);
	self.tbTask:RemoveNpcMenu(self.nDialogNpcTempId);
end;

function tb:OnTalkNpc()
	if (self:IsDone()) then
		return;
	end
	assert(self._tbBase._tbBase);
	if (self.nMapId ~= 0 and self.nMapId ~= self.me.GetMapId()) then
		return;
	end;
	TaskAct:Talk(self.szMsg, self.OnTalkFinish, self);
end;

function tb:OnTalkFinish()
	assert(self._tbBase._tbBase)
	assert (MODULE_GAMESERVER);
	if (self._tbBase.nDialogNpcId) then
		self:Dialog2Fight();
	end
end;

function tb:Dialog2Fight()
	assert(MODULE_GAMESERVER);
	assert(self._tbBase.nDialogNpcId);
	local pDialogNpc = KNpc.GetById(self._tbBase.nDialogNpcId);
	assert(pDialogNpc);

	local nCurMapId, nCurPosX, nCurPosY = pDialogNpc.GetWorldPos();
	pDialogNpc.Delete();
	self._tbBase.nDialogNpcId = nil;
	
	self:AddFightNpc(nCurMapId, nCurPosX, nCurPosY);
end

function tb:AddFightNpc(nMapId, nMapX, nMapY)
	local pFightNpc	= KNpc.Add2(self.nFightNpcTempId, self.nFightNpcLevel, -1, nMapId, nMapX, nMapY);
	assert(pFightNpc);
	local szTitle = " Do đội <color=yellow>"..self.me.szName.."<color> bảo vệ";
	pFightNpc.SetTitle(szTitle);
	pFightNpc.SetCurCamp(0);
	
	if (self.nFightNpcHP > pFightNpc.nMaxLife) then
		pFightNpc.SetMaxLife(self.nFightNpcHP);
		pFightNpc.RestoreLife();
	end
	
	self._tbBase.nFightNpcId = pFightNpc.dwId;
	Npc:RegPNpcOnDeath(pFightNpc, self.OnDeath, self);
	
	self:RegisterLogout(); -- 接任務的下線則刪除此Npc
	self:RegisterTimer();
end

function tb:RegisterLogout()
	assert(self._tbBase._tbBase);
	if (MODULE_GAMESERVER) then
		if (not self.nRegisterLogoutId) then
			self.nRegisterLogoutId = true;
		end;
	end;
end

function tb:UnRegisterLogout()
	assert(self._tbBase._tbBase);
	if (MODULE_GAMESERVER) then
		if (self.nRegisterLogoutId) then
			self.nRegisterLogoutId	= false;
		end;
	end;
end

function tb:OnLogout()
	assert(self._tbBase._tbBase);
	--assert(self._tbBase.nFightNpcId);
	--改成保護 zounan
	if not self._tbBase.nFightNpcId then
		return;
	end
	
	local pFightNpc = KNpc.GetById(self._tbBase.nFightNpcId);
	assert(pFightNpc);
	pFightNpc.Delete();	
	self._tbBase.nFightNpcId = nil;
	self._tbBase:RiseDialogNpc();	
end



function tb:RegisterTimer()
	assert(self._tbBase._tbBase)	--沒有經過兩次派生，腳本書寫錯誤
	if (MODULE_GAMESERVER and not self.nRegisterGuardTimerId) then
		self.nElapse = 0;
		self.nRegisterGuardTimerId	= Timer:Register(Env.GAME_FPS, self.OnGuardTimer, self);
	end;
end;

function tb:UnRegisterTimer()
	assert(self._tbBase._tbBase)	--沒有經過兩次派生，腳本書寫錯誤
	if (MODULE_GAMESERVER and self.nRegisterGuardTimerId) then
		Timer:Close(self.nRegisterGuardTimerId);
		self.nRegisterGuardTimerId	= nil;
	end;
end;


-- 同一時間隻能有一個人守衛這個Npc
function tb:OnGuardTimer()
	assert(MODULE_GAMESERVER);
	assert(self._tbBase._tbBase);
	assert(not self:IsDone());

	if (not self.nElapse) then
		self.nElapse = 0;
	end
	
	local pFightNpc = KNpc.GetById(self._tbBase.nFightNpcId);
	assert(pFightNpc);
	self.nElapse = self.nElapse + 1;
	local tbSaveTask	= self.tbSaveTask;
	if (tbSaveTask) then
		self.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId + 1, self.nElapse, 1);
		KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
	end
	
	self:ShareTimer(self.nElapse);
	
	if (self.nElapse <  self.nGuardDuration) then
		return;
	end
	
	pFightNpc.Delete();
	self._tbBase.nFightNpcId = nil;
	
	self:ShareGuardNpc();
	self.bDone	=  1;
	
	if (tbSaveTask) then	-- 自行同步到客戶端，要求客戶端刷新
		self.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId, self.bDone, 1);
		KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
	end;
	
	self.me.Msg("目標達成："..self:GetStaticDesc());
	self:UnRegisterTimer();
	self:UnRegisterTalk();
	self:UnRegisterLogout()
	self.tbTask:OnFinishOneTag();
		
	self._tbBase:RiseDialogNpc(); -- 指定時間刷對話Npc
	return 0;
end;

function tb:ShareGuardNpc()
	assert(self._tbBase._tbBase);
	-- 遍歷所有隊友所有任務的當前步驟的目標，若是和此目標相同則調用OnTeamMateKillNpc
	local tbTeamMembers, nMemberCount	= self.me.GetTeamMemberList();
	if (not tbTeamMembers) then --共享失敗：沒有組隊
		return;
	end
	if (nMemberCount <= 0) then-- 共享失敗：隊伍沒有成員
		return;
	end
	
	local plOld	= self.me;
	local nOldPlayerIndex = self.me.nPlayerIndex;
	for i = 1, nMemberCount do
		me	= tbTeamMembers[i];
		if (me.nPlayerIndex ~= nOldPlayerIndex) then
			if (Task:AtNearDistance(me, self.me) == 1) then
				for _, tbTask in pairs(Task:GetPlayerTask(me).tbTasks) do
					for _, tbCurTag in pairs(tbTask.tbCurTags) do
						if (tbCurTag.szTargetName == self.szTargetName and (not tbCurTag:IsDone())) then
							if (tbCurTag.nFightNpcTempId == self.nFightNpcTempId and
								(tbCurTag.nMapId == 0 or tbCurTag.nMapId == self.nMapId)) then
								tbCurTag:OnTeamMateGuardNpc();
							end
						end
					end
				end
			end
		end
	end
	self.me	= plOld;
end;

function tb:OnTeamMateGuardNpc()
	assert(self._tbBase._tbBase);
	if (self:IsDone()) then
		return;
	end
	self.bDone  = 1;
	local tbSaveTask	= self.tbSaveTask;
	if (MODULE_GAMESERVER and tbSaveTask) then	-- 自行同步到客戶端，要求客戶端刷新
		self.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId, self.bDone, 1);
		KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
	end;
	if (self:IsDone()) then	-- 本目標是一旦達成後不會失效的
		self.me.Msg("Mục tiêu:"..self:GetStaticDesc());
		self:UnRegisterTalk();
		self:UnRegisterLogout();
		self.tbTask:OnFinishOneTag();
	end;
end;


function tb:RiseDialogNpc()
	assert(self._tbBase)
	assert(self._tbBase._tbBase == nil)
	if (MODULE_GAMESERVER) then
		self.nReviveDurationTimeId = Timer:Register(Env.GAME_FPS * self.nDeathDuration, self.AddDialogNpc, self);
	end;
end;

function tb:AddDialogNpc()
	assert(not self.nDialogNpcId);
	assert(not self.nFightNpcId);
	assert(not self._tbBase._tbBase);
	assert(self._tbBase);
	
	local pDialogNpc = KNpc.Add2(self.nDialogNpcTempId, 1, -1, self.nMapId, self.nMapPosX, self.nMapPosY);
	assert(pDialogNpc);
	
	self.nDialogNpcId = pDialogNpc.dwId;
	self.nReviveDurationTimeId = nil;
	return 0;
end


function tb:OnDeath()
	assert(self._tbBase._tbBase)
	local tbSaveTask	= self.tbSaveTask;
	if (MODULE_GAMESERVER) then
		self.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId + 1, 0, 1);
		KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
	end
	self:ShareTimer(0);
	self.me.Msg(self.szFailedMsg);
	self._tbBase.nFightNpcId = nil;
	self:UnRegisterTimer();
	self._tbBase:RiseDialogNpc();
end;


function tb:ShareTimer(nElapse)
	-- 遍歷所有隊友所有任務的當前步驟的目標，若是和此目標相同則調用OnTeamMateKillNpc
	local tbTeamMembers, nMemberCount	= self.me.GetTeamMemberList();
	if (not tbTeamMembers) then --共享失敗：沒有組隊
		return;
	end
	if (nMemberCount <= 0) then-- 共享失敗：隊伍沒有成員
		return;
	end
	
	local plOld	= self.me;
	local nOldPlayerIndex = self.me.nPlayerIndex;
	for i = 1, nMemberCount do
		me	= tbTeamMembers[i];
		if (me.nPlayerIndex ~= nOldPlayerIndex) then
			for _, tbTask in pairs(Task:GetPlayerTask(me).tbTasks) do
				if (tbTask.nReferId == self.tbTask.nReferId) then
					for _, tbCurTag in pairs(tbTask.tbCurTags) do
						if (tbCurTag.szTargetName == self.szTargetName and (not tbCurTag:IsDone())) then
							if (tbCurTag.nFightNpcTempId == self.nFightNpcTempId and (tbCurTag.nMapId == 0 or tbCurTag.nMapId == self.nMapId)) then
								if (Task:AtNearDistance(me, self.me) == 1) then
									tbCurTag:OnUpDateTeamMateTimer(nElapse);
								else
									tbCurTag:OnUpDateTeamMateTimer(0);
								end
							end
						end
					end
				end
			end
			
		end
	end
	
	self.me	= plOld;
end

function tb:OnUpDateTeamMateTimer(nElapse)	
	if (self:IsDone()) then
		return;
	end
	
	self.nElapse = nElapse;
	
	local tbSaveTask	= self.tbSaveTask;
	if (MODULE_GAMESERVER and tbSaveTask) then	-- 自行同步到客戶端，要求客戶端刷新
		self.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId + 1, self.nElapse, 1);
		KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
	end;
end
