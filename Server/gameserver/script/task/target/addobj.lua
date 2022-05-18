
-- 文件載入的時候可以在Task.tbTargetLib中載入這個目標
local tb	= Task:GetTarget("AddObj");
tb.szTargetName	= "AddObj";

function tb:Init(tbItemId, nNpcTempId, szNewName, nMapId, nPosX, nPosY, nR, szPosName, szMsg)
	if (tbItemId[1] ~= 20) then
		print("[Task Error]"..self.szTargetName.."  Không dùng đạo cụ nhiệm vụ!")
	end
	self.tbItemId	= tbItemId;
	self.szItemName	= KItem.GetNameById(unpack(tbItemId));
	self.nParticular= tbItemId[3];
	self.nNpcTempId	= nNpcTempId;
	assert(nNpcTempId > 0);
	self.szNpcName	= KNpc.GetNameByTemplateId(nNpcTempId);
	self.szNewName	= szNewName;
	self.nMapId		= nMapId;
	self.nPosX		= nPosX;
	self.nPosY		= nPosY;
	self.nR			= nR;
	self.szPosName	= szPosName;
	if (self.szMsg ~= "") then
		self.szMsg	= szMsg;
	end;
end;

function tb:Start()
	self.bDone		= 0;
	self:Register();
	if (MODULE_GAMESERVER) then	-- 服務端看情況添加物品
		if (Task:GetItemCount(self.me, self.tbItemId) <= 0) then
			Task:AddItem(self.me, self.tbItemId);
		end
	end
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

function tb:IsDone()
	return self.bDone == 1;
end;

function tb:GetDesc()
	return self:GetStaticDesc();
end;

function tb:GetStaticDesc()
	return string.format("Đem %s để ở %s", self.szNpcName, self.szPosName);
end;

function tb:Close(szReason)
	self:UnRegister();
	if (MODULE_GAMESERVER) then	-- 服務端看情況刪除物品，完成的話在完成瞬間刪
		if (szReason == "giveup" or szReason == "failed") then
			Task:DelItem(self.me, self.tbItemId, 1);
		end;
	end;
end;


function tb:Register()
	self.tbTask:AddItemUse(self.nParticular, self.OnItem, self)
end;

function tb:UnRegister()
	self.tbTask:RemoveItemUse(self.nParticular);
end;

function tb:OnItem()
	if (self:IsDone()) then
		return nil;
	end;
	
	local oldme = me;
	me = self.me;
	local bAtPos, szMsg	= TaskCond:IsAtPos(self.nMapId, self.nPosX, self.nPosY, self.nR);
	if (not bAtPos) then
		self.me.Msg(szMsg);
		me = oldme;
		return 1;
	end;
	
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
	local oldme = me;
	me = self.me;
	local pNpc = TaskAct:AddObj(self.nNpcTempId, self.szNewName);
	me = oldme;
	
	Timer:Register(2 * 60 *Env.GAME_FPS, self.DelNpc, self, pNpc.dwId);
	Task:DelItem(self.me, self.tbItemId);
	
	self.bDone	= 1;
	
	local tbSaveTask	= self.tbSaveTask;
	if (MODULE_GAMESERVER and tbSaveTask) then	-- 自行同步到客戶端，要求客戶端刷新
		self.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId, self.bDone, 1);
		KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
	end;
	
	self.me.Msg("Mục tiêu: "..self:GetStaticDesc());
	self:UnRegister()	-- 本目標是一旦達成後不會失效的
	if (self.szMsg) then
		local oldPlayer = me;
		me = self.me;
		me.Msg(self.szMsg);
		me = oldPlayer;
	end;
	
	self.tbTask:OnFinishOneTag();
	 
	return 0;
end


function tb:DelNpc(nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc) then
		return 0;
	end
	pNpc.Delete();
	return 0;
end
