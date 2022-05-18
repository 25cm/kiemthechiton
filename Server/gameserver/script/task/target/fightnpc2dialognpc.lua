
-- 和指定的Npc對話可完成任務和talknpc目標一樣，但這個指定的Npc要擊敗一個指定戰斗Npc才能出來。
-- 指定對話Npc出來一段時間會被刪掉，然後這個時候戰斗Npc會被添加
local tb	= Task:GetTarget("FightNpc2DialogNpc");
tb.szTargetName	= "FightNpc2DialogNpc";


-- 地圖Id,戰斗Npc模板,對話Npc模板,對話選項,對話內容,重復對話，對話Npc持續時間,目標完成前泡泡，目標完成後泡泡
function tb:Init(nMapId, nMapPosX, nMapPosY, nFightNpcTempId, nFightNpcLevel, nDialogNpcTempId, szOption, szMsg, szRepeatMsg, nDialogDuration, szStaticDesc, szDynamicDesc, szBeforePop, szLaterPop)
	self.nMapId				= nMapId;
	self.szMapName			= Task:GetMapName(nMapId);
	self.nMapPosX			= nMapPosX;
	self.nMapPosY			= nMapPosY;
	self.nFightNpcTempId	= nFightNpcTempId;
	self.szFightNpcName		= KNpc.GetNameByTemplateId(nFightNpcTempId);
	self.nFightNpcLevel		= nFightNpcLevel;
	self.nDialogNpcTempId	= nDialogNpcTempId;
	self.szDialogNpcName	= KNpc.GetNameByTemplateId(nDialogNpcTempId);
	self.szOption			= szOption;
	self.szMsg				= szMsg;
	self.szRepeatMsg		= szRepeatMsg;
	self.nDialogDuration	= nDialogDuration;
	self.szStaticDesc		= szStaticDesc;
	self.szDynamicDesc		= szDynamicDesc;
	self.szBeforePop		= szBeforePop;
	self.szLaterPop			= szLaterPop;
	self:IniTarget();
end;


---------------------------------------------------------------------
function tb:IniTarget()
	if (MODULE_GAMESERVER) then
		if (not self.bAddFight or self.bAddFight == 0) then
			local pFightNpc	= KNpc.Add2(self.nFightNpcTempId, self.nFightNpcLevel, -1, self.nMapId, self.nMapPosX, self.nMapPosY);
			if (not pFightNpc) then
				return;
			end
			self.nFightNpcId = pFightNpc.dwId;
			Npc:RegPNpcOnDeath(pFightNpc, self.OnDeath, self);
			Timer:Register(Env.GAME_FPS * 60, self.OnCheckNpcExist, self);
			self.bAddFight = 1; -- 確保隻添加一次
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
	self.nDialogNpcId = nil;
	self.nFightNpcId  = nil;
	
	self:AddFightNpc();
end


-- 第一個開啟這個目標的玩家會注冊一個戰斗Npc，之後則是它的輪回
function tb:Start()
	self.bDone		= 0;
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
	
	if (not self:IsDone() or self.szRepeatMsg) then	-- 本目標是一旦達成後不會失效的
		self:Register();
		assert(self._tbBase._tbBase)
	end;
	
	return 1;
end;



function tb:IsDone()
	return self.bDone == 1;
end;


function tb:GetDesc()
	return self.szDynamicDesc or "";
end;


function tb:GetStaticDesc()
	return self.szStaticDesc or "";
end;


function tb:Close(szReason)
	self:UnRegister();
end;


function tb:Register()
	assert(self._tbBase._tbBase)
	
	self.tbTask:AddNpcMenu(self.nDialogNpcTempId, self.nMapId, self.szOption, self.OnTalkNpc, self);
end;

function tb:UnRegister()
	assert(self._tbBase._tbBase)
	
	self.tbTask:RemoveNpcMenu(self.nDialogNpcTempId);
end;


function tb:OnTalkNpc()
	if (not him) then
		return;
	end;
	
	assert(self._tbBase._tbBase)

	if (self.nMapId ~= 0 and self.nMapId ~= self.me.GetMapId()) then
		TaskAct:Talk("Không phải bản đồ ngươi muốn tìm"..self.szDialogNpcName.."Xin hãy đến "..self.szMapName)
		return;
	end
		
	if (self:IsDone()) then
		if (self.szRepeatMsg) then
			TaskAct:Talk(self.szRepeatMsg);
		end
		
		return;
	end
	
	TaskAct:Talk(self.szMsg, self.OnTalkFinish, self);
end



function tb:OnTalkFinish()
	assert(self._tbBase._tbBase)
	self.bDone	= 1;
	local tbSaveTask	= self.tbSaveTask;
	if (MODULE_GAMESERVER and tbSaveTask) then	-- 自行同步到客戶端，要求客戶端刷新
		self.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId, self.bDone, 1);
		KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
	end;
	self.me.Msg("Mục tiêu:"..self:GetStaticDesc());
	
	self.tbTask:OnFinishOneTag();
	
	if (not self.szRepeatMsg) then
		self:UnRegister()	-- 本目標是一旦達成後不會失效的
	end;
end;


function tb:RiseDialogNpc(pFightNpc)
	assert(self._tbBase)
	assert(self._tbBase._tbBase == nil)
	
	-- 在戰斗Npc的位置添加對話Npc
	local nCurMapId, nCurPosX, nCurPosY = pFightNpc.GetWorldPos();
	local pDialogNpc = KNpc.Add2(self.nDialogNpcTempId, 1, -1, nCurMapId, nCurPosX, nCurPosY);
	assert(pDialogNpc);
	self.nDialogNpcId = pDialogNpc.dwId;
	Task.tbToBeDelNpc[self.nDialogNpcId] = 1;
	-- 指定時間後刪除對話Npc，並添加戰斗Npc
	if (MODULE_GAMESERVER) then
		self.nReviveDurationTimeId = Timer:Register(Env.GAME_FPS * self.nDialogDuration, self.Dialog2Fight, self);
	end;
end;


-- 對話轉戰斗
function tb:Dialog2Fight()
	assert(not self.nFightNpcId);
	assert(self._tbBase)
	assert(self._tbBase._tbBase == nil)
	assert(MODULE_GAMESERVER);
	-- 避免下面assert造成重復調用
	if (not self.nReviveDurationTimeId) then
		return 0;
	end
	
	self.nReviveDurationTimeId = nil;
	
	-- 刪除這個對話Npc
	if (self.nDialogNpcId) then
		local pDialogNpc = KNpc.GetById(self.nDialogNpcId);
		assert(pDialogNpc);
		Task.tbToBeDelNpc[self.nDialogNpcId] = 0;
		pDialogNpc.Delete();
		self.nDialogNpcId = nil;
	else
		assert(false);
	end
	
	self:AddFightNpc();
	
	return 0;
end;

-- 添加一個戰斗Npc
function tb:AddFightNpc()
	assert(not self.nDialogNpcId);
	assert(not self.nFightNpcId);
	assert(not self._tbBase._tbBase);
	assert(self._tbBase);
	
	local pFightNpc	= KNpc.Add2(self.nFightNpcTempId, self.nFightNpcLevel, -1, self.nMapId, self.nMapPosX, self.nMapPosY);
	assert(pFightNpc);	
	self.nFightNpcId = pFightNpc.dwId; 
	Npc:RegPNpcOnDeath(pFightNpc, self.OnDeath, self);
end


-- OnDeath處於tb._tbBase環境
function tb:OnDeath()
	assert(self._tbBase)
	assert(not self._tbBase._tbBase)
	
	if (self.nFightNpcId and him.dwId == self.nFightNpcId) then
		self.nFightNpcId = nil;
		self:RiseDialogNpc(him);
	else
		assert(false);
	end
end;
