
local tb	= Task:GetTarget("UseItem2AddNpc");
tb.szTargetName	= "UseItem2AddNpc";

function tb:Init(tbItemId, nNpcTempId, nMapId, nPosX, nPosY, nR, szPos, nDelTime, szDynamicDesc, szStaticDesc)
	if (tbItemId[1] ~= 20) then
		print("[Task Error]"..self.szTargetName.."  Không dùng đạo cụ nhiệm vụ!")
	end
	
	self.tbItemId		= tbItemId;
	self.szItemName		= KItem.GetNameById(unpack(tbItemId));
	self.nParticular 	= tbItemId[3];
	self.nMapId			= nMapId;
	self.nNpcTempId		= nNpcTempId;
	self.tbPos			= {nMapId, nPosX, nPosY, nR};
	self.tbNpcPos		= self:ParsePos(szPos);
	self.tbNpc 			= {};
	
	self.DEL_TIME		= nDelTime * 18; -- 秒
	
	self.szDynamicDesc  = szDynamicDesc;
	self.szStaticDesc	= szStaticDesc;
end;

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

--目標開啟
function tb:Start()
	self.bDone		= 0;
	self:Register();
	if (MODULE_GAMESERVER) then	-- 服務端看情況添加物品
		if (Task:GetItemCount(self.me, self.tbItemId) <= 0) then
			Task:AddItem(self.me, self.tbItemId);
		end
	end
end;

--目標保存
function tb:Save(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	self.me.SetTask(nGroupId, nStartTaskId, self.bDone);
	return 1;
end;

--目標載入
function tb:Load(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	self.bDone		= self.me.GetTask(nGroupId, nStartTaskId);
	if (not self:IsDone()) then	-- 本目標是一旦達成後不會失效的
		self:Register();
		if (MODULE_GAMESERVER) then	-- 服務端看情況添加物品
			if (Task:GetItemCount(self.me, self.tbItemId) <= 0) then
				Task:AddItem(self.me, self.tbItemId);
			end
		end
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
	return "使用"..self.szItemName;
end;

function tb:Close(szReason)
	self:UnRegister();
	if (MODULE_GAMESERVER) then	-- 服務端看情況刪除物品，完成的話在完成瞬間刪
		if (szReason == "giveup" or szReason == "failed") then
			Task:DelItem(self.me, self.tbItemId, 1);
		end;
	end;
end;

-------------------------------------------------------------------------------------------

function tb:Register()
	self.tbTask:AddItemUse(self.nParticular, self.OnTaskItem, self)
end;

function tb:UnRegister()
	self.tbTask:RemoveItemUse(self.nParticular);
end;

function tb:OnTaskItem()
	if (self:IsDone()) then
		return;
	end;
	local oldme = me;
	me = self.me;
	local bIsAtPos = 0;

	if (TaskCond:IsAtPos(self.tbPos[1], self.tbPos[2], self.tbPos[3], self.tbPos[4])) then
		bIsAtPos = 1;
	end
	
	if (bIsAtPos ~= 1) then
		Dialog:SendInfoBoardMsg(me, "Vị trí không đúng, hãy đến vị trí chỉ định.");
		me = oldme;
		return;
	end
	
	-- 開始進度條計時
	local tbEvent = {
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SIT,
		Player.ProcessBreakEvent.emEVENT_USEITEM,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_DROPITEM,
		Player.ProcessBreakEvent.emEVENT_SENDMAIL,		
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_DEATH,
	}
	
	GeneralProcess:StartProcess("", 180, {self.OnProgressFull, self}, nil, tbEvent)
	me = oldme;
end;

function tb:OnProgressFull()
	self:AddNpcInPos();
	Timer:Register(self.DEL_TIME, self.OnTimer, self);
	
	-- 刪物品
	Task:DelItem(self.me, self.tbItemId, 1);
	
	self.bDone = 1;
	
	local tbSaveTask	= self.tbSaveTask;
	if (MODULE_GAMESERVER and tbSaveTask) then	-- 自行同步到客戶端，要求客戶端刷新
		self.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId, self.bDone, 1);
		KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
	end;
	
	
	self.me.Msg("Mục tiêu:"..self:GetStaticDesc());
	if (not self.szRepeatMsg) then
		self:UnRegister()	-- 本目標是一旦達成後不會失效的
	end;
	self.tbTask:OnFinishOneTag();
end

-- 添加NPC
function tb:AddNpcInPos()
	for i = 1, #self.tbNpcPos do
		local pNpc = KNpc.Add2(self.nNpcTempId, 125, -1, self.nMapId, self.tbNpcPos[i].nX, self.tbNpcPos[i].nY);
		if (not pNpc or pNpc.nIndex == 0) then
			print("[Task Error]:"..self.nNpcTempId.." thêm thất bại!");
		else
			self.tbNpc[#self.tbNpc + 1] = pNpc.dwId;
		end;
	end;
end;

-- 刪除NPC
function tb:OnTimer()
	for i = 1, #self.tbNpc do
		local pNpc = KNpc.GetById(self.tbNpc[i]);
		if (pNpc) then
			pNpc.Delete();
		end;
	end;
	return 0;
end;
