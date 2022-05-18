
local tb	= Task:GetTarget("SearchMapChronicle");
tb.szTargetName	= "SearchMapChronicle";

function tb:Init(nMapId, nNeedCount)
	self.nMapId	= nMapId;
	self.nNeedCount	= nNeedCount;
end;

function tb:Start()
	-- 先清空以前任務保留的地圖志
	self:SetMapNum(0);
	
	-- 注冊事件
	self:Register();
end;

function tb:Save(nGroupId, nStartTaskId)
	return 0;
end;

function tb:Load(nGroupId, nStartTaskId)
	self:Register();
	return 0;
end;

-- 目標關閉時注銷事件
function tb:Close(szReason)
	self:UnRegister();
end;

function tb:GetDesc()
	local nMapNum = self.me.GetTask(LinkTask.TSKG_LINKTASK , LinkTask.TSK_WORLDMAPNUM);
	return "Tìm kiếm "..self.szMapName.." Địa Đồ Chí, hoàn thành: "..nMapNum.." / "..self.nNeedCount.." tấm";
end;


function tb:GetStaticDesc()
	local szMsg	= "";
	local szMapName = "";	
	if (self.nMapId ~= 0) then
		szMapName	= self.szMapName;
	end;
	szMsg = szMsg.."Tìm kiếm "..self.nNeedCount.." tấm"..szMapName.."Địa Đồ Chí";
	return szMsg;
end;


function tb:Register()
	assert(self._tbBase._tbBase)	--沒有經過兩次派生，腳本書寫錯誤
	local oldPlayer = me;
	me = self.me;
	if (MODULE_GAMESERVER and not self.nRegisterId) then
		self.nRegisterId	= PlayerEvent:Register("OnPickUp", self.OnPickUp, self);
	end;
	me = oldPlayer;
end;


function tb:UnRegister()
	local oldPlayer = me;
	me = self.me;
	if (MODULE_GAMESERVER and self.nRegisterId) then
		PlayerEvent:UnRegister("OnPickUp", self.nRegisterId);
		self.nRegisterId	= nil;
	end;
	me = oldPlayer;
end;


-- 玩家撿起任何一個物品時觸發
function tb:OnPickUp()
	local nNowCount = self:GetMapCount();
	
	-- print("Item Type: "..(it.nGenre).." / "..(it.nDetail).." / "..(it.nParticular));
	
	local tbItem = LinkTask.WorldMapItemGenre;
	
	-- 如果是地圖志
	if it.nGenre == tbItem[1] and it.nDetail == tbItem[2] and it.nParticular == tbItem[3] then
		nNowCount = nNowCount + 1;
		self:SetMapNum(nNowCount);
		
		-- 任務目標已經達到
		if nNowCount>=self.nNeedCount then
			self:UnRegister();
			self.tbTask:OnFinishOneTag();
			self.me.Msg("Hoàn thành nhiệm vụ tìm kiếm "..self.szMapName.." Địa Đồ Chí!");			
			return;
		end;
		
		self.me.Msg("Tìm kiếm "..self.szMapName.." Địa Đồ Chí:"..
					nNowCount.." / "..self.nNeedCount);
	end;
end;


-- 判斷任務是否已經完成
function tb:IsDone()
	local nNowCount = self:GetMapCount();
	return nNowCount>=self.nNeedCount;
end;


function tb:GetMapCount()
	return self.me.GetTask(LinkTask.TSKG_LINKTASK , LinkTask.TSK_WORLDMAPNUM);
end;

function tb:SetMapNum(nNum)
	self.me.SetTask(LinkTask.TSKG_LINKTASK , LinkTask.TSK_WORLDMAPNUM, nNum);
end;

