
local tb 			= Task:GetTarget("ProductWithProcess");
tb.szTargetName 	= "ProductWithProcess";
tb.REFRESH_FRAME 	= 18;


-- 持續時間, 浮動數字(小費), 成功幾率，成功時的消息，失敗時的消息， 進度條信息，生產工具，材料， 需要的產品， 需要的產品個數 
-- 生成物概率表, 每次成功生產副產品最大生產次數，如果沒有生成材料指定的生產次數
function tb:Init(nDuration, szToke, nRate, szSucMsg, szFailedMsg, szProcessTip, tbTool, szStuffs, tbKeyProduct, nKeyProductNeedCount, 
	szTotleProducts, nArisingsLimitCount, nNeedProuductCount, nMapId, nPosX, nPosY, nRange, nSkillId,  nObjId, szDynamicDesc, szStaticDesc, nModel)
	self.nDuration 				= nDuration * 18;
	self.tbToke 				= self:ParseToke(szToke);
	self.nRate					= nRate;
	self.szSucMsg				= szSucMsg;
	self.szFailedMsg			= szFailedMsg;
	self.szProcessTip			= szProcessTip;
	self.tbTool					= tbTool;
	self.nToolParticular		= tbTool[1];
	self.tbStuffs				= self:ParseStuffs(szStuffs);
	self.tbKeyProduct			= tbKeyProduct;
	self.nKeyProductNeedCount	= nKeyProductNeedCount;	-- 需要指定產品的個數
	self.tbTotleProducts		= self:ParseTotleProducts(szTotleProducts);
	self.nTotleProductWeight	= self:GetTotleProductWeight();
	self.nArisingsLimitCount 	= nArisingsLimitCount;
	self.nNeedProuductCount		= nNeedProuductCount;	-- 需要成功生產的次數
	self.nMapId					= nMapId;
	self.nPosX 					= nPosX;
	self.nPosY					= nPosY;
	self.nRange 				= nRange;
	self.nSkillId				= nSkillId;
	self.nObjId					= nObjId;
	self.szDynamicDesc			= szDynamicDesc;
	self.szStaticDesc			= szStaticDesc;
	self.nModel					= nModel; -- 1.表示看次數，2表示看物品
	self.nArisingsCount			= 0;	-- 當前副產品數量
end


-- 是否需要
-- 經驗，金錢，聲望，精力，活力，
function tb:ParseToke(szToke)
	local tbToke = Lib:Str2Val(szToke);
	return tbToke;
end

-- 解析材料
--{物品名, nGenre, nDetail, nParticular, nLevel, nSeries, nItemNum}
function tb:ParseStuffs(szStuffs)
	local tbRet = {};
	local tbItem = Lib:SplitStr(szStuffs, "\n")
	for i=1, #tbItem do
		if (tbItem[i] and tbItem[i] ~= "") then
			local tbTemp = loadstring(string.gsub(tbItem[i],"{.+,(.+),(.+),(.+),(.+),(.+),(.+)}", "return {tonumber(%1),tonumber(%2),tonumber(%3),tonumber(%4),tonumber(%5),tonumber(%6)}"))()
			tbRet[#tbRet + 1] = {};
			tbRet[#tbRet].tbItem = {tbTemp[1],tbTemp[2],tbTemp[3],tbTemp[4],tbTemp[5]};
			tbRet[#tbRet].nCount = tbTemp[6];
		end
	end
	
	return tbRet;
end



-- 解析總物品
-- {物品名, nGenre, nDetail, nParticular, nLevel, nSeries, nRate}
function tb:ParseTotleProducts(szTotleProducts)
	local tbRet = {};
	local tbItem = Lib:SplitStr(szTotleProducts, "\n")
	for i=1, #tbItem do
		if (tbItem[i] and tbItem[i] ~= "") then
			local tbTemp = loadstring(string.gsub(tbItem[i],"{.+,(.+),(.+),(.+),(.+),(.+),(.+)}", "return {tonumber(%1),tonumber(%2),tonumber(%3),tonumber(%4),tonumber(%5),tonumber(%6)}"))()
			tbRet[#tbRet + 1] = {};
			tbRet[#tbRet].tbItem = {tbTemp[1],tbTemp[2],tbTemp[3],tbTemp[4],tbTemp[5]};
			tbRet[#tbRet].nRate = tbTemp[6];
		end
	end
	
	return tbRet;
end

function tb:GetTotleProductWeight()
	local nSum = 0;
	for _, tbProduct in ipairs(self.tbTotleProducts) do
		nSum = nSum + tbProduct.nRate;
	end
	return nSum;
end


function tb:Start()
	self.nSucMakeTimes = 0;		-- 成功制造次數
	if (Task:GetItemCount(self.me, {20, 1, self.nToolParticular, 1}) <= 0) then
		Task:AddItem(self.me, {20, 1, self.nToolParticular, 1});
	end
	
	self:Register();		
end

function tb:Load(nGroupId, nStartTaskId)
		self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	self.nSucMakeTimes		= self.me.GetTask(nGroupId, nStartTaskId);
	
	if (Task:GetItemCount(self.me, {20, 1, self.nToolParticular, 1}) <= 0) then
		Task:AddItem(self.me, {20, 1, self.nToolParticular, 1});
	end
	self:Register();

	return 1;
end


function tb:Save(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	self.me.SetTask(nGroupId, nStartTaskId, self.nSucMakeTimes);
	
	return 1;
end

function tb:Close()
	Task:DelItem(self.me, {20, 1, self.nToolParticular, 1}, 1);
	self:UnRegister();
end

function tb:GetStaticDesc()
	return self.szStaticDesc;
end

function tb:GetDesc()
	if (self.nModel == 1) then
		return self.szDynamicDesc.." ("..self.nSucMakeTimes.."/"..self.nNeedProuductCount..")";
	elseif(self.nModel == 2) then
		return self.szDynamicDesc.." ("..self:GetKeyProductCount().."/"..self.nKeyProductNeedCount..")";
	end
end


function tb:Register()
	self.tbTask:AddItemUse(self.nToolParticular, self.OnItem, self);
	if (MODULE_GAMESERVER and not self.nRegisterId and self.nModel == 2) then
		self.nRegisterId	= Timer:Register(self.REFRESH_FRAME, self.OnTimer, self);
	end;
	self:ResetItemCount();
end;

function tb:ResetItemCount()
	-- 隻對nModel為1(隻看次數)
	-- 或nArisingsLimitCount為0的時候有效
	local nRemainTimes = 0;
	if (self.nModel == 1 and self.nRate == 1) then
		nRemainTimes = self.nNeedProuductCount - self.nSucMakeTimes;
	elseif (self.nModel == 2 and self.nArisingsLimitCount == 0 and self.nRate == 1) then
		nRemainTimes = self.nKeyProductNeedCount - self:GetKeyProductCount();
	end
	
	if (nRemainTimes == 0) then
		return;
	end
	
	-- 看需要多少材料
	-- 材料是否足夠
	for _, tbStuff in ipairs(self.tbStuffs) do
		local nHaveCount = Task:GetItemCount(self.me, tbStuff.tbItem);
		if (nHaveCount < (tbStuff.nCount * nRemainTimes)) then
			if (TaskCond:CanAddCountItemIntoBag(tbStuff.tbItem, (tbStuff.nCount * nRemainTimes))) then
				Task:AddItems(self.me, tbStuff.tbItem, (tbStuff.nCount * nRemainTimes));
			end
		elseif (nHaveCount > (tbStuff.nCount * nRemainTimes)) then
			Task:DelItem(self.me, tbStuff.tbItem, nHaveCount - (tbStuff.nCount * nRemainTimes));
		end
	end
end

function tb:UnRegister()
	self.tbTask:RemoveItemUse(self.nToolParticular);
	if (MODULE_GAMESERVER and self.nRegisterId) then
		Timer:Close(self.nRegisterId);
		self.nRegisterId	= nil;
	end;
end;


function tb:OnItem()
	local plOld	= me;
	me	= self.me;
	if (self:IsDone()) then
		me	= plOld;
		return;
	end;
	
	-- 是否在指定位置
	
	local bAtPos	= TaskCond:IsAtPos(self.nMapId, self.nPosX, self.nPosY, self.nRange);
	
	if (not bAtPos) then
		me.Msg("Vị trí không chính xác!")
		me	= plOld;
		return;
	end;
	
	-- 材料是否足夠
	for _, tbStuff in ipairs(self.tbStuffs) do
		if (Task:GetItemCount(self.me, tbStuff.tbItem) < tbStuff.nCount) then
			me.Msg("Nguyên liệu không đủ!");
			me	= plOld;
			return;
		end
	end
	
	Task:SetProgressTag(self, self.me);
	
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
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
	}
	GeneralProcess:StartProcess(self.szProcessTip, self.nDuration, {self.OnProgressFull, self}, nil, tbEvent)

	me	= plOld;
end;

function tb:IsDone()
	if (self.nModel == 1) then
		return self.nSucMakeTimes >= self.nNeedProuductCount;
	elseif (self.nModel == 2) then
		return self:GetKeyProductCount() >= self.nNeedProuductCount;
	else
		assert(false);
	end
end


function tb:OnProgressFull()
	-- 刪除材料
	-- 材料是否足夠
	for _, tbStuff in ipairs(self.tbStuffs) do
		if (Task:GetItemCount(self.me, tbStuff.tbItem) < tbStuff.nCount) then
			self.me.Msg("Nguyên liệu không đủ!");
			return;
		end
	end
	
	
	-- 給小費
	self:AddToke();
	 
	-- 一定幾率失敗
	if (self.nRate < MathRandom()) then
		self.me.Msg(self.szFailedMsg);
		return;
	end
	
	local oldPlayer = me;
	me = self.me;
	-- 按幾率給指定物品
	if (self.nArisingsCount >= self.nArisingsLimitCount) then
		-- 直接給指定產品
		if (TaskCond:CanAddItemsIntoBag({self.tbKeyProduct}) ~= 1) then
			self.me.Msg("Túi đầy!");
			me = oldPlayer;
			return;
		end
		
		Task:AddItem(self.me, self.tbKeyProduct);
		self.nArisingsCount = 0;
	else
		local nRandom = MathRandom();
		local nCurSum = 0;
		for _, tbProduct in ipairs(self.tbTotleProducts) do
			nCurSum = nCurSum + tbProduct.nRate;
			if (nCurSum > nRandom) then
				if (TaskCond:CanAddItemsIntoBag({tbProduct.tbItem}) ~= 1) then	-- 背包空間
					self.me.Msg("Túi đầy!");
					me = oldPlayer;
					return;
				end
				Task:AddItem(self.me, tbProduct.tbItem);
				if (self:IsKeyProduct(tbProduct.tbItem) ~= 1) then
					self.nArisingsCount = self.nArisingsCount + 1;
				else
					self.nArisingsCount = 0;
				end
				break;
			end
		end	
	end
	
	for _, tbStuff in ipairs(self.tbStuffs) do
		if (Task:DelItem(self.me, tbStuff.tbItem, tbStuff.nCount) ~= 1) then
			--assert(false);
			--return;
		end
	end
	
		-- 成功
	self.nSucMakeTimes = self.nSucMakeTimes + 1;
	self.me.Msg(self.szSucMsg);
	-- 放技能，擺道具
	if (self.nSkillId ~= 0) then
		self.me.CastSkill(self.nSkillId, 1, -1, self.me.GetNpc().nIndex);
	end
	
	if (self.nObjId ~= 0) then
		Setting:SetGlobalObj(self.me, him, it);
		local pNpc = TaskAct:AddObj(self.nObjId);
		Setting:RestoreGlobalObj();
		Timer:Register(20 * Env.GAME_FPS, self.DelNpc, self, pNpc.dwId);
	end
	
	if (self.nModel == 1) then	-- 看是否達到次數
		local tbSaveTask	= self.tbSaveTask;
		if (MODULE_GAMESERVER and tbSaveTask) then	-- 自行同步到客戶端，要求客戶端刷新
			self.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId, self.nSucMakeTimes, 1);
			KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
		end;
		
		if (self:IsDone()) then
			self.me.Msg("Mục tiêu:"..self:GetStaticDesc());
			self:UnRegister()	-- 本目標是一旦達成後不會失效的
			self.tbTask:OnFinishOneTag();
		end
	end
	
	me = oldPlayer;
end


function tb:OnTimer()
	local nCount	= self:GetKeyProductCount();
	if (not self.nKeyProductCount or self.nKeyProductCount ~= nCount) then
		self.nKeyProductCount	= nCount;
		local tbSaveTask	= self.tbSaveTask;
		if (MODULE_GAMESERVER) then	-- 自行同步到客戶端，要求客戶端刷新
			KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
		end;
		
		if (self:IsDone()) then
			self.tbTask:OnFinishOneTag();
		end
	end;
	
	return self.REFRESH_FRAME;
end


function tb:GetKeyProductCount()
	return Task:GetItemCount(self.me, self.tbKeyProduct);
end

function tb:IsKeyProduct(tbDesItem)
	if (tbDesItem[1] == self.tbKeyProduct[1] and 
		tbDesItem[2] == self.tbKeyProduct[2] and 
		tbDesItem[3] == self.tbKeyProduct[3] and
		tbDesItem[4] == self.tbKeyProduct[4] ) then
			return 1;
		end
	
	return 0;
end

function tb:AddToke()
	if (not self.tbToke) then
		return;
	end
	
	if (self.tbToke.nExp and self.tbToke.nExp > 0) then
		self.me.AddExp(self.tbToke.nExp);
	end
	if (self.tbToke.nMoney and self.tbToke.nMoney > 0) then
		self.me.AddBindMoney(self.tbToke.nMoney, Player.emKBINDMONEY_ADD_TASK);
--		self.me.Earn(self.tbToke.nMoney, Player.emKEARN_TASK_TOKE);
--		KStatLog.ModifyAdd("jxb", "[產出]劇情任務", "總量", self.tbToke.nMoney);
	end
	if (self.tbToke.nMakePoint and self.tbToke.nMakePoint > 0) then
		self.me.ChangeCurMakePoint(self.tbToke.nMakePoint);
	end
	if (self.tbToke.nGatherPoint and self.tbToke.nGatherPoint > 0) then
		self.me.ChangeCurGatherPoint(self.tbToke.nGatherPoint);
	end
	if  (self.tbToke.tbRepute) then
		self.me.AddRepute(self.tbToke.tbRepute.Camp, self.tbToke.tbRepute.Class, self.tbToke.tbRepute.Delta);
	end 
end

function tb:DelNpc(nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc) then
		return 0;
	end
	pNpc.Delete();
	return 0;
end

