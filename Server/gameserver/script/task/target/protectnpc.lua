
local tb	= Task:GetTarget("ProtectNpc");
tb.szTargetName		= "ProtectNpc";
tb.REFRESH_FRAME 	= 18;
--tb.CHIEFSKILLID		= 100; -- 護送負責人的技能Id,目標關閉的時候關閉，開始的時候加載

--參數說明
--對話Npc模板Id, 刷對話Npc時間間隔,對話選項,對話內容,行走Npc模板Id,行走Npc等級,地圖Id,玩家能離開的最遠距離,目標點x坐標,目標點y坐標,目標半徑,行走路線,完成前泡泡，完成後泡泡
function tb:Init(nDialogNpcTempId, nMapPosX, nMapPosY, nInterval, szOption, szMsg, nMoveNpcTempId, nMoveNpcLevel, nMapId, nMaxDistance, nLimitTime, nAimX, nAimY, nAimR, szTrack, szBeforePop, strRszLaterPop, nAttartRate)
	self.nDialogNpcTempId	= nDialogNpcTempId;
	self.nMapPosX			= nMapPosX;
	self.nMapPosY			= nMapPosY;
	self.nInterval			= nInterval;
	self.szDialogNpcName	= KNpc.GetNameByTemplateId(nDialogNpcTempId);
	self.szOption			= szOption;
	self.szMsg				= szMsg;
	self.nMoveNpcTempId		= nMoveNpcTempId;
	self.szMoveNpcName		= KNpc.GetNameByTemplateId(nMoveNpcTempId)
	self.nMoveNpcLevel		= nMoveNpcLevel;
	self.nMapId				= nMapId;
	self.szMapName			= Task:GetMapName(nMapId);
	self.nMaxDistance		= nMaxDistance;
	self.nLimitTime			= nLimitTime;
	self.nAimX				= nAimX;
	self.nAimY				= nAimY;
	self.nAimR				= nAimR;
	self.tbTrack			= self:ParseTrack(szTrack);
	self.szBeforePop		= szBeforePop;
	self.szLaterPop			= szLaterPop;
	self.nAttartRate 		= tonumber(nAttartRate) or 20;
	self:IniTarget();
end;


-- 解析行走字符串
function tb:ParseTrack(szTrack)
	if (not szTrack or szTrack == "") then
		return;
	end
	local tbRet = {};
	local tbTrack = Lib:SplitStr(szTrack, "\n")
	for i=1, #tbTrack do
		if (tbTrack[i] and tbTrack[i] ~= "") then
			local tbPos = Lib:SplitStr(tbTrack[i]);
			table.insert(tbRet, tbPos);
		end
	end
	
	return tbRet;
end


function tb:IniTarget()
	if (MODULE_GAMESERVER) then
		if (not self.bStart) then
			local pDialogNpc = KNpc.Add2(self.nDialogNpcTempId, 1, -1, self.nMapId, self.nMapPosX, self.nMapPosY);
			if (not pDialogNpc) then
				return;
			end
			self.nDialogNpcId = pDialogNpc.dwId;
			Timer:Register(Env.GAME_FPS * 60, self.OnCheckNpcExist, self);
			self.bStart = true;
		end
	end
end;

-- 用於防止意外造成Npc丟失
function tb:OnCheckNpcExist()
	if (Task:IsNpcExist(self.nDialogNpcId, self) == 1) then
		return;
	end
	
	if (self.nReviveDurationTimeId) then
		return;
	end
	
	self.nDialogNpcId = nil;
	self.nReviveDurationTimeId = nil;
	
	self:AddDialogNpc();
end

-- 開始的時候
function tb:Start()
	self.bDone = 0;
	self:RegisterTalk();
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
	self.bDone	= self.me.GetTask(nGroupId, nStartTaskId);
	
	if (not self:IsDone()) then	-- 本目標是一旦達成後不會失效的
		self:RegisterTalk();
	end;
	
	return 1;
end;

function tb:IsDone()
	return self.bDone == 1;
end;

function tb:GetDesc()
	return self:GetStaticDesc();
end;

function tb:GetStaticDesc()
	return "Hộ tống "..self.szMoveNpcName;
end;


function tb:Close(szReason)
	self:UnReg_Npc_RunTimer();
	self:UnRegisterTalk();
	
	if (self.nMoveNpcId) then
		local pFightNpc = KNpc.GetById(self.nMoveNpcId);
		if (pFightNpc) then
			pFightNpc.Delete();
		end
	end
end;


-- 注冊和Npc對話
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
	
	if (self.nMapId ~= 0 and self.nMapId ~= self.me.GetMapId()) then
		TaskAct:Talk("Thứ cần tìm "..self.szDialogNpcName.." không có trong bản đồ, hãy đi về phía trước"..self.szMapName)
		return;
	end;
	local oldPlayer = me;
	me = self.me;
	TaskAct:Talk(self.szMsg, self.OnTalkFinish, self);
	me = oldPlayer;
	
	self.nMyDialogNpcId = him.dwId;
end;

-- 對話完後會刪除當前對話Npc,在指定地方刷一個行走Npc,並讓他行走，並注冊計時器，指定時間後再刷一個對話Npc
function tb:OnTalkFinish()
	if (self.nMyDialogNpcId ~= self._tbBase.nDialogNpcId) then
		return;
	end
	
	-- 對話轉戰斗
	self:Dialog2Fight();	 
	
	--注冊計時器到時間刪Npc，每秒看玩家離Npc的距離，若距離遠則刪除 
	self:Reg_Npc_RunTimer();
	
	-- 注冊指定時間後刷對話Npc
	self._tbBase:RiseDialogNpc();
end;


function tb:Dialog2Fight()
	assert(MODULE_GAMESERVER);
	local pDialogNpc = KNpc.GetById(self._tbBase.nDialogNpcId);
	assert(pDialogNpc);
	local nCurMapId, nCurPosX, nCurPosY = pDialogNpc.GetWorldPos();
	
	pDialogNpc.Delete(); 
	self._tbBase.nDialogNpcId = nil;
	
	-- 刪除之前領的
	if (self.nMoveNpcId) then
		local pFightNpc = KNpc.GetById(self.nMoveNpcId);
		
		if (pFightNpc) then
			pFightNpc.Delete();
			self.nMoveNpcId = nil;
		end
	end
	
	local pFightNpc	= KNpc.Add2(self.nMoveNpcTempId, self.nMoveNpcLevel, -1, self.nMapId, nCurPosX, nCurPosY, 0, 0, 1);
	assert(pFightNpc); 
	pFightNpc.SetCurCamp(0);
	local szTitle = " Do đội <color=yellow>"..self.me.szName.."<color> hộ tống";
	pFightNpc.SetTitle(szTitle);
	Npc:RegPNpcOnDeath(pFightNpc, self.OnDeath, self);
	self.nMoveNpcId = pFightNpc.dwId;
	
	pFightNpc.AI_ClearPath();
	for _,Pos in ipairs(self.tbTrack) do
		if (Pos[1] and Pos[2]) then
			pFightNpc.AI_AddMovePos(tonumber(Pos[1])*32, tonumber(Pos[2])*32)
		end
	end 
	
	pFightNpc.AI_AddMovePos(tonumber(self.nAimX)*32, tonumber(self.nAimY)*32);-- 終點為目標
	pFightNpc.SetNpcAI(9, self.nAttartRate, 1,-1, 25, 25, 25, 0, 0, 0, self.me.GetNpc().nIndex);	
end

function tb:RiseDialogNpc()
	assert(self._tbBase)
	assert(not self._tbBase._tbBase)
	if (MODULE_GAMESERVER) then
		self.nReviveDurationTimeId = Timer:Register(Env.GAME_FPS * self.nInterval, self.AddDialogNpc, self);
	end;
end

-- 添加一個對話Npc
function tb:AddDialogNpc()
	assert(self._tbBase);
	assert(not self._tbBase._tbBase);
	assert(not self.nDialogNpcId);
	local pDialogNpc = KNpc.Add2(self.nDialogNpcTempId, 1, -1, self.nMapId, self.nMapPosX, self.nMapPosY);
	assert(pDialogNpc)
	
	self.nDialogNpcId = pDialogNpc.dwId;
	self.nReviveDurationTimeId = nil;
	return 0;
end


function tb:Reg_Npc_RunTimer()
	self.nRunElapseTime = 0;
	if (MODULE_GAMESERVER and not self.nRegisterRunTimerId) then
		self.nRegisterRunTimerId = Timer:Register(self.REFRESH_FRAME, self.OnRunTimer, self);
	end;
end;

function tb:UnReg_Npc_RunTimer()
	if (MODULE_GAMESERVER and self.nRegisterRunTimerId) then
		Timer:Close(self.nRegisterRunTimerId);
		self.nRegisterRunTimerId	= nil;
	end;
end;

-- 1.到指定時間刪戰斗Npc﹔2.每秒看玩家離Npc的距離，若距離遠則刪常 3.目標是否完成(和玩家走))
function tb:OnRunTimer()
	if (not self.nMoveNpcId) then
		self.nRegisterRunTimerId	= nil;
		return 0;
	end
	
	local pFightNpc = KNpc.GetById(self.nMoveNpcId);
	if (not pFightNpc) then
		self.nRegisterRunTimerId	= nil;
		return 0;
	end
	self.nRunElapseTime = self.nRunElapseTime + 1;
	if (self.nRunElapseTime > self.nLimitTime) then -- 到了指定時間，護送失敗
		pFightNpc.Delete();
		self.me.Msg("Không hộ tống thành công trong thời gian chỉ định"..self.szMoveNpcName..", quay về khởi điểm đối thoại lại để mở nhiệm vụ Hộ tống.")
		self.nMoveNpcId = nil;
		self.nRegisterRunTimerId	= nil;
		return 0;
	else
		local nHimCurMapId, nHimCurPosX, nHimCurPosY = pFightNpc.GetWorldPos();
		local oldme = me;
		me = self.me;
		local bAtPos, szMsg	= TaskCond:IsAtPos(self.nMapId, nHimCurPosX, nHimCurPosY, self.nMaxDistance);
		me = oldme;
		if (not bAtPos) then
			pFightNpc.Delete();
			self.me.Msg("Khoảng cách hộ tống "..self.szMoveNpcName.."quá xa, nhiệm vụ thất bại, quay về đối thoại để mở nhiệm vụ Hộ tống.")
			self.nMoveNpcId = nil;
			self.nRegisterRunTimerId	= nil;
			return 0;
		end;

		local oldme = me;
		me = self.me;
		-- 判斷到達目的地
		if (TaskCond:IsNpcAtPos(pFightNpc.dwId, self.nMapId, self.nAimX, self.nAimY, self.nAimR) or pFightNpc.AI_IsArrival() == 1) then
			self.bDone	=  1;
			self:ShareProtectNpc();
			local tbSaveTask	= self.tbSaveTask;
			if (MODULE_GAMESERVER and tbSaveTask) then	-- 自行同步到客戶端，要求客戶端刷新
				self.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId, self.bDone, 1);
				KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
			end;
			pFightNpc.Delete();
			self.nMoveNpcId = nil;
			self:UnReg_Npc_RunTimer();
			self.nRunElapseTime = 0;
		end;
		me = oldme;
		
		if (self:IsDone()) then	-- 本目標是一旦達成後不會失效的
			self.me.Msg("Mục tiêu:"..self:GetStaticDesc());
			self:UnReg_Npc_RunTimer();
			self:UnRegisterTalk();
			self.tbTask:OnFinishOneTag();
			self.nRunElapseTime = 0;
			self.nRegisterRunTimerId	= nil;
			return 0
		end;
	end;
	
	return self.REFRESH_FRAME;
end;


function tb:ShareProtectNpc()
-- 遍歷所有隊友所有任務的當前步驟的目標，若是和此目標相同則調用OnTeamMateKillNpc
	local tbTeamMembers, nMemberCount	= self.me.GetTeamMemberList();
	if (not tbTeamMembers) then --共享失敗：沒有組隊
		return;
	end
	if (nMemberCount <= 0) then-- 共享失敗：隊伍沒有成員
		return;
	end
	
	local nOldPlayerIndex = self.me.nPlayerIndex;
	for i = 1, nMemberCount do
		local pPlayer	= tbTeamMembers[i];
		if (pPlayer.nPlayerIndex ~= nOldPlayerIndex) then
			if (Task:AtNearDistance(pPlayer, self.me) == 1) then
				for _, tbTask in pairs(Task:GetPlayerTask(pPlayer).tbTasks) do
					
					for _, tbCurTag in pairs(tbTask.tbCurTags) do
						
						if (tbCurTag.szTargetName == self.szTargetName) then
							if (tbCurTag.nMoveNpcTempId == self.nMoveNpcTempId and
								(tbCurTag.nMapId == 0 or tbCurTag.nMapId == self.nMapId)) then
								tbCurTag:OnTeamMateProtectNpc();
							end
						end
					end
				end
			end
		end
	end
end;


function tb:OnTeamMateProtectNpc()
	self.bDone  = 1;
	local tbSaveTask	= self.tbSaveTask;
	if (MODULE_GAMESERVER and tbSaveTask) then	-- 自行同步到客戶端，要求客戶端刷新
		self.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId, self.bDone, 1);
		KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
	end;
	if (self:IsDone()) then	-- 本目標是一旦達成後不會失效的
		self.me.Msg("Mục tiêu:"..self:GetStaticDesc());
		self:UnReg_Npc_RunTimer();
		self:UnRegisterTalk();
		self.tbTask:OnFinishOneTag();
	end;
end;


function tb:OnDeath()
	if (self:IsDone()) then
		return;
	end
	self.nMoveNpcId = nil;
	self.me.Msg(self.szMoveNpcName.." đã chết, nhiệm vụ thất bại, quay về đối thoại để mở nhiệm vụ Hộ tống.");
end
