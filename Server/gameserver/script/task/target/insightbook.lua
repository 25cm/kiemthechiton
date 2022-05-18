
local tb	= Task:GetTarget("InsightBook");
tb.szTargetName	= "InsightBook";

function tb:Init(nMaxLimit, tbItem, szDynamicDesc, szStaticDesc)
	self.nMaxLimit			= nMaxLimit;
	self.tbItem				= tbItem;
	self.szDynamicDesc		= szDynamicDesc;
	self.szStaticDesc		= szStaticDesc;
end;


--目標開啟
function tb:Start()
	self.nCurInsight		= 0;
	self:Register();
	self.me.SetTask(2006, 2, 1);
end;

--目標保存
--根據任務變量組Id（nGroupId）以及組內變量起始Id（nStartTaskId），保存本目標的運行期數據
--返回實際存入的變量數量
function tb:Save(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	self.me.SetTask(nGroupId, nStartTaskId, self.nCurInsight, 1);
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
	self.nCurInsight		= self.me.GetTask(nGroupId, nStartTaskId);
	if (not self:IsDone()) then	-- 本目標是一旦達成後不會失效的
		self:Register();
		self.me.SetTask(2006, 2, 1);
	end;
	return 1;
end;

--返回目標是否達成
function tb:IsDone()
	return self.nCurInsight >= self.nMaxLimit;
end;

--返回目標進行中的描述（客戶端）
function tb:GetDesc()
	local szDesc = string.format("Hiện tại bạn nhận được %d/%d điểm kinh nghiệm tu luyện.", self.nCurInsight, self.nMaxLimit);
	return szDesc;
end;


--返回目標的靜態描述，與當前玩家進行的情況無關
function tb:GetStaticDesc()
	return "Cuối cùng bạn cũng viết được một quyển sách tâm đắc!";
end;


function tb:Close(szReason)
	self.me.SetTask(2006, 2, 0);
	self:UnRegister();
end;

function tb:Register()
	assert(self._tbBase._tbBase)	--沒有經過兩次派生，腳本書寫錯誤
	local oldPlayer = me;
	me = self.me;
	if (MODULE_GAMESERVER and not self.nRegisterId) then
		self.nRegisterId	= PlayerEvent:Register("OnAddInsight", self.OnAddInsight, self);
	end;
	me = oldPlayer;
end;

function tb:UnRegister()
	assert(self._tbBase._tbBase)	--沒有經過兩次派生，腳本書寫錯誤
	local oldPlayer = me;
	me = self.me;
	if (MODULE_GAMESERVER and self.nRegisterId) then
		PlayerEvent:UnRegister("OnAddInsight", self.nRegisterId);
		self.nRegisterId	= nil;
	end;
	me = oldPlayer;
end;


function tb:OnAddInsight(nInsightNumber)
	local nAddInsight = nInsightNumber;
	if ((self.nCurInsight + nAddInsight) > self.nMaxLimit) then
		nAddInsight = self.nMaxLimit - self.nCurInsight;
	end
	
	self.nCurInsight = self.nCurInsight + nAddInsight;
	
	self.me.Msg("Nhận được "..nAddInsight.." điểm tâm đắc!");

	
	local tbSaveTask	= self.tbSaveTask;
	if (MODULE_GAMESERVER and tbSaveTask) then	-- 自行同步到客戶端，要求客戶端刷新
		self.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId, self.nCurInsight, 1);
		KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
	end;
	
	if (self.nCurInsight >= self.nMaxLimit) then	
		self.tbTask:OnFinishOneTag();
	end
end

