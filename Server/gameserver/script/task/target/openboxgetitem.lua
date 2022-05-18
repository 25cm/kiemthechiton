
local tb	= Task:GetTarget("OpenBoxGetItem");
tb.szTargetName	= "OpenBoxGetItem";

-- 箱子的模板Id，地圖Id, 箱子的對話內容, 重復信息，開箱子後得到的道具，開始泡泡，結束泡泡
function tb:Init(nNpcTempId, nMapId, szOption, szMsg, szRepeatMsg, tbItem, szBeforePop, szLaterPop)
	self.nNpcTempId	= nNpcTempId;
	self.szNpcName	= KNpc.GetNameByTemplateId(nNpcTempId);
	self.nMapId		= nMapId;
	self.szMapName	= Task:GetMapName(nMapId);
	self.szOption	= szOption;
	self.szMsg		= szMsg;
	if (szRepeatMsg ~= "") then
		self.szRepeatMsg	= szRepeatMsg;
	end;
	
	self.ItemList	= self:ParseItem(tbItem);
	self.szBeforePop	= szBeforePop;
	self.szLaterPop		= szLaterPop;
end;

function tb:Start()
	self.bDone		= 0;
	self:Register();
end;

function tb:ParseItem(szItemSet)
	local tbRet = {};
	local tbItem = Lib:SplitStr(szItemSet, "\n")
	for i=1, #tbItem do
		if (tbItem[i] and tbItem[i] ~= "") then
			-- 每行的物品格式：{物品名, nGenre, nDetail, nParticular, nLevel, nSeries, nItemNum}
			local tbTemp = loadstring(string.gsub(tbItem[i],"{.+,(.+),(.+),(.+),(.+),(.+),(.+)}", "return {tonumber(%1),tonumber(%2),tonumber(%3),tonumber(%4),tonumber(%5),tonumber(%6)}"))()
			for i = 1, tbTemp[6] do
				table.insert(tbRet, {tbTemp[1],tbTemp[2],tbTemp[3],tbTemp[4],tbTemp[5]});
			end
		end
	end
	
	return tbRet;
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
	local szMsg	= "Mở ";
	if (self.nMapId ~= 0) then
		szMsg	= szMsg..self.szMapName.." -  ";
	end;
	szMsg	= szMsg..string.format("%s ", self.szNpcName);
	return szMsg;
end;


function tb:Close(szReason)
	self:UnRegister();
end;


function tb:Register()
	self.tbTask:AddNpcMenu(self.nNpcTempId, self.nMapId, self.szOption, self.OnTalkNpc, self);
end;

function tb:UnRegister()
	self.tbTask:RemoveNpcMenu(self.nNpcTempId);
end;

function tb:OnTalkNpc()
	if (self.nMapId ~= 0 and self.nMapId ~= self.me.GetMapId()) then
		self.me.Msg("Đây không phải là bản đồ cần mở"..self.szNpcName.."Xin hãy đến "..self.szMapName)
		return;
	end;
	
	if (self:IsDone()) then
		if (self.szRepeatMsg) then
			TaskAct:Talk(self.szRepeatMsg);
		end;
		return;
	end;
	
	local tbOpt =
	{
        { "Mở", 			self.SelectOpenBox,	self },
        { "Không mở"},
    };

    Dialog:Say("Mở ra sẽ có niềm vui bất ngờ bên trong!", tbOpt);
end;

-- 玩家選擇打開箱子[S]
-- 1.向客戶端發送協議讓客戶端設置進度條?
function tb:SelectOpenBox()
	self.bDone	= 1;
	local tbSaveTask	= self.tbSaveTask;
	if (MODULE_GAMESERVER and tbSaveTask) then	-- 自行同步到客戶端，要求客戶端刷新
		self.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId, self.bDone, 1);
		KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
	end;
	self.me.Msg("Mục tiêu:"..self:GetStaticDesc());
	
	for _, tbItem in ipairs(self.ItemList) do
		Task:AddItem(self.me, tbItem);
	end
	
	if (not self.szRepeatMsg) then
		self:UnRegister()	-- 本目標是一旦達成後不會失效的
	end;
	
	self.tbTask:OnFinishOneTag();
end;

--[[
-- 2.客戶端設置進度條並設置它的完成回掉
function tb:SetProgressBar()
end;

-- 客戶端進度條完成回掉，通知服務端給獎勵
function tb:OnProgressFull()
end;

-- 3.服務端為玩家添加物品，目標完成
function tb:OnGiveItem()
	
end;
--]]
