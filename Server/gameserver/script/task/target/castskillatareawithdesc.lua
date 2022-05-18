
local tb	= Task:GetTarget("CastSkillAtAreaWithDesc");
tb.szTargetName	= "CastSkillAtAreaWithDesc";

function tb:Init(tbItemId, nSkillId, nMapId, nPosX, nPosY, nR, szDynamicDesc, szStaticDesc, szExtraPos)
	if (tbItemId[1] ~= 20) then
		--print("[Task Error]"..self.szTargetName.."  沒有使用任務道具！")
	end
	self.tbItemId		= tbItemId;
	self.szItemName		= KItem.GetNameById(unpack(tbItemId));
	self.nSkillId		= nSkillId;
	self.nParticular 	= tbItemId[3];
	self.tbPos			= self:ParsePos(szExtraPos);
	table.insert(self.tbPos, {nMapId, nPosX, nPosY, nR});
	self.szDynamicDesc  = szDynamicDesc;
	self.szStaticDesc	= szStaticDesc;
end;


function tb:ParsePos(szPosSet)
	local tbRet = {};
	local tbPos = Lib:SplitStr(szPosSet, "\n")
	for i=1, #tbPos do
		if (tbPos[i] and tbPos[i] ~= "") then
			-- 坐標的格式：{nMapId, nPosX, nPosY, nR}
			local tbTemp = loadstring(string.gsub(tbPos[i],"(.+),(.+),(.+),(.+)", "return {tonumber(%1),tonumber(%2),tonumber(%3),tonumber(%4)}"))()
			table.insert(tbRet, tbTemp);
		end
	end
	return tbRet;
end;


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
	if (not self.szDynamicDesc) then
		return self:GetStaticDesc();
	else
		return self.szDynamicDesc;
	end
end;


--返回目標的靜態描述，與當前玩家進行的情況無關
function tb:GetStaticDesc()
	if (not self.szStaticDesc) then
		return "使用"..self.szItemName;
	else
		return self.szStaticDesc;
	end
end;


--目標活動停止
--	szReason，停止的原因：
--		"logout"	玩家下線
--		"finish"	步驟完成
--		"giveup"	玩家放棄任務
--		"failed"	任務失敗
--		"refresh"	客戶端刷新
function tb:Close(szReason)
	self:UnRegister();
	if (MODULE_GAMESERVER) then	-- 服務端看情況刪除物品，完成的話在完成瞬間刪
		if (szReason == "giveup" or szReason == "failed") then
			Task:DelItem(self.me, self.tbItemId, 1);
		end;
	end;
end;

----==== 以下是本目標所特有的函數定義，如有雷同，純屬巧合 ====----

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
	for _, Pos in pairs(self.tbPos) do
		if (TaskCond:IsAtPos(Pos[1],Pos[2],Pos[3],Pos[4])) then
			bIsAtPos = 1;
			break;
		end
	end
	
	if (bIsAtPos ~= 1) then
		Dialog:SendInfoBoardMsg(me, "Không đúng vị trí, xin đến vị trí chỉ định.");
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
self.me.CastSkill(self.nSkillId, 1, -1, self.me.GetNpc().nIndex);
	
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
