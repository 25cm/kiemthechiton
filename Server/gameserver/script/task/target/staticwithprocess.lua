
-- 靜態進度條目標
local tb	= Task:GetTarget("WithProcessStatic");
tb.szTargetName	= "WithProcessStatic";


function tb:Init(nNpcTempId, nMapId, nIntervalTime, szProcessInfo, szSucMsg, szFailedMsg,  tbItem, nNeedCount, szDynamicDesc, szStaticDesc, szBeforePop, szLaterPop)
	self.nNpcTempId			= nNpcTempId;
	self.szNpcName			= KNpc.GetNameByTemplateId(nNpcTempId);
	self.nMapId				= nMapId;
	self.szMapName			= Task:GetMapName(nMapId);
	self.nIntervalTime 		= tonumber(nIntervalTime) * 18;
	self.szProcessInfo		= szProcessInfo or "Đang tiến hành";
	self.szSucMsg			= szSucMsg or "Thành công";
	self.szFailedMsg		= szFailedMsg or "Thất bại";
	self.ItemList			= self:ParseItem(tbItem);
	self.nNeedCount			= nNeedCount;
	self.szDynamicDesc		= szDynamicDesc;
	self.szStaticDesc	  	= szStaticDesc;
	self.szBeforePop		= szBeforePop;
	self.szLaterPop			= szLaterPop;
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
	-- TODO: liuchang 字符串檢查
	return string.format(self.szDynamicDesc,self.nCount,self.nNeedCount);
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


-- 玩家選擇打開箱子[S]
function tb:SelectOpenBox()
	if (self.nMapId ~= 0 and self.nMapId ~= self.me.GetMapId()) then
		self.me.Msg("Đây không phải là bản đồ cần mở"..self.szNpcName.."Xin hãy đến "..self.szMapName)
		return;
	end;
	
	if (self:IsDone()) then
		self.me.Msg(self.szFailedMsg)
		return;
	end;
	
	Task:SetProgressTag(self, self.me);
	KTask.StartProgressTimer(self.me, self.nIntervalTime, self.szProcessInfo);
end;


-- 客戶端進度條完成回掉，通知服務端給獎勵
function tb:OnProgressFull()
	local nTotleCount = #self.ItemList;
	
	if (nTotleCount > 0 and TaskCond:CanAddItemsIntoBag(self.ItemList) ~= 1) then
		self.me.Msg("Hành trang đã đầy, không thể chứa vật phẩm mới!")
		return;
	end
	self.me.Msg(self.szSucMsg);
	self.nCount	= self.nCount + 1;
	local tbSaveTask	= self.tbSaveTask;
	if (MODULE_GAMESERVER and tbSaveTask) then	-- 自行同步到客戶端，要求客戶端刷新
		self.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId, self.nCount, 1);
		KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
	end;
	
	for _, tbItem in ipairs(self.ItemList) do
		Task:AddItem(self.me, tbItem);
	end
	
	if (self:IsDone()) then
		self.me.Msg("Mục tiêu:"..self:GetStaticDesc());
		self:UnRegister()	-- 本目標是一旦達成後不會失效的
		self.tbTask:OnFinishOneTag();
	end
end;
