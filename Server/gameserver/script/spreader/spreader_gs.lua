-- 文件名　：spreader_gs.lua
-- 创建者　：xiewen
-- 创建时间：2008-12-29 16:15:01

Require("\\script\\spreader\\spreader_def.lua")

if not MODULE_GAMESERVER then
	return
end

local szWareListPath = "\\setting\\ibshop\\warelist.txt";
local szNonIbItemCongfig = "\\setting\\spreader\\non_ib_item.txt";

Spreader.tbIbItem = {};						-- IB物品
Spreader.tbNonIbItem = {};				-- 非IB物品

Spreader.tbLittleConsumeCache = {};	-- 小额消耗缓存

function Spreader:CalBitByGDPL(nG, nD, nP, nL)
	--nLevel占0-5位，nParticular占6-15位, nDetailType占16-25位，nGenre占26-31位
	local nIndex = nL;
	nIndex = Lib:SetBits(nIndex, nP, 6,  15);
	nIndex = Lib:SetBits(nIndex, nD, 16, 25);
	nIndex = Lib:SetBits(nIndex, nG, 26, 31);
	
	return nIndex;
end

function Spreader:LoadWareListSetting()
	local tbWareListSetting = Lib:LoadTabFile(szWareListPath);
	-- 加载IB列表配置
	for nRow, tbRowData in pairs(tbWareListSetting) do
		local nGenre = tonumber(tbRowData["nGenre"]);
		local nDetailType = tonumber(tbRowData["nDetailType"]);
		local nParticular = tonumber(tbRowData["nParticular"]);
		local nLevel = tonumber(tbRowData["nLevel"]);
		local nCurrencyType = tonumber(tbRowData["nCurrencyType"]);
		
		--nLevel占0-5位，nParticular占6-15位, nDetailType占16-25位，nGenre占26-31位
		local nIndex = self:CalBitByGDPL(nGenre, nDetailType, nParticular, nLevel);
		
		if nIndex and nCurrencyType and nCurrencyType == 0 then
			local nConsumed = tonumber(tbRowData["Consumed"]) or 0;
			self.tbIbItem[nIndex] = nConsumed;
		end
	end
end

function Spreader:LoadNonIbItemConfig()
	local tbNonIbItemCongfig = Lib:LoadTabFile(szNonIbItemCongfig);
	
	-- 加载非IB类消耗物品配置
	for nRow, tbRowData in pairs(tbNonIbItemCongfig) do
		local nGenre = tonumber(tbRowData["nGenre"]);
		local nDetailType = tonumber(tbRowData["nDetailType"]);
		local nParticular = tonumber(tbRowData["nParticular"]);
		local nLevel = tonumber(tbRowData["nLevel"]);
		
		local nBuyPrice = tonumber(tbRowData["nBuyPrice"]);
		local bCanBind = tonumber(tbRowData["bCanBind"]) or 0;
		
		--nLevel占0-5位，nParticular占6-15位, nDetailType占16-25位，nGenre占26-31位
		local nIndex = self:CalBitByGDPL(nGenre, nDetailType, nParticular, nLevel);
		
		self.tbNonIbItem[nIndex] = {};
		self.tbNonIbItem[nIndex].nBuyPrice = nBuyPrice;
		self.tbNonIbItem[nIndex].bCanBind = bCanBind;
	end
end

function Spreader:OnItemConsumed(nCount, nCosumeMode)
	if self:IsIntroducee(me) ~= 1 then
		return
	end
	
	-- 卖店/叠加等消耗途径不算
	if (nCosumeMode == self.emITEM_CONSUMEMODE_SELL or
		nCosumeMode < self.emITEM_CONSUMEMODE_REALCONSUME_START or
		nCosumeMode > self.emITEM_CONSUMEMODE_REALCONSUME_END)
	then
		return
	end
	
	--nLevel占0-5位，nParticular占6-15位, nDetailType占16-25位，nGenre占26-31位
	local nIndex = self:CalBitByGDPL(it.nGenre, it.nDetail, it.nParticular, it.nLevel);
	
	if it.IsIbItem() == 1 then
		
		if (nCosumeMode == self.emITEM_CONSUMEMODE_EXPIREDTIMEOUT or	--保值期到
			nCosumeMode == self.emITEM_CONSUMEMODE_USINGTIMEOUT)		--物品超时
		then
			-- 过期删除可以按原价
			local nItConsumed =  it.nBuyPrice * nCount;
			Dbg:WriteLog("Spreader:OnItemConsumed",
				"推广员消耗记录：",
				self.ZoneGroup or self:ExtractZoneGroup(),
				me.szAccount,
				string.format("[%s]的Ib物品[%s]%d个,因过期删除,添加消耗记录[%s]", 
					me.szName, it.szName, nCount, tostring(nItConsumed))
			);
			self:AddConsume(nItConsumed)
		else
			-- Ib物品普通消耗（因为有些物品不是按原价计算消耗，所以都乘以一个百分比）
			if self.tbIbItem[nIndex] then
				local nItConsumed = it.nBuyPrice * nCount * self.tbIbItem[nIndex] / 100;
				Dbg:WriteLog("Spreader:OnItemConsumed",
					"推广员消耗记录：",
					self.ZoneGroup or self:ExtractZoneGroup(),
					me.szAccount,
					string.format("[%s]正常消耗Ib物品[%s]%d个,添加消耗记录[%s]", 
						me.szName, it.szName, nCount, tostring(nItConsumed))
				);
						
				self:AddConsume(nItConsumed);
			end
		end

	else
		
		-- 非Ib物品
		--if it.IsBind() == 0 and self.tbNonIbItem[nIndex] then
		if self.tbNonIbItem[nIndex] and it.IsBind() <= self.tbNonIbItem[nIndex].bCanBind then
			local nItConsumed = self.tbNonIbItem[nIndex].nBuyPrice * nCount;
			Dbg:WriteLog("Spreader:OnItemConsumed",
				"推广员消耗记录：",
				self.ZoneGroup or self:ExtractZoneGroup(),
				me.szAccount,
				string.format("[%s]使用非Ib物品[%s]%d个，添加消耗记录[%s]",
						 me.szName, it.szName, nCount, tostring(nItConsumed))
			);
			self:AddConsume(nItConsumed);
		end
		
	end
end

-- 装备绑定计算消耗
function Spreader:OnItemBound(pItem)
	if self:IsIntroducee(me) ~= 1 then
		return
	end

	if pItem and pItem.nBuyPrice > 0 then
			
		Dbg:WriteLog("Spreader:OnItemBound",
			"推广员消耗记录：",
			self.ZoneGroup or self:ExtractZoneGroup(),
			me.szAccount,
			string.format("[%s]绑定装备[%s],添加消耗记录[%s]",
				 me.szName, pItem.szName, tostring(pItem.nBuyPrice))
		);
			
		self:AddConsume(pItem.nBuyPrice)
		pItem.nBuyPrice = 0	-- 防止装备发生删除时又加一次消耗
	end
end

-- 勾魂玉的特殊处理
function Spreader:OnGouhunyuRepute(nReputeAdded)
	if self:IsIntroducee(me) ~= 1 or nReputeAdded <= 0 then
		return
	end
	
	local nConsume = nReputeAdded / 102; -- 102是一个勾魂玉能得到的令牌声望均值
	
	Dbg:WriteLog("Spreader:OnGouhunyuRepute",
		"推广员消耗记录：",
		self.ZoneGroup or self:ExtractZoneGroup(),
		me.szAccount,
		string.format("[%s]使用勾魂玉，得到声望[%d], 添加消耗记录[%s]", 
			me.szName, nReputeAdded, tostring(self.GOUHUNYU * nConsume))
	);
			
	self:AddConsume(self.GOUHUNYU * nConsume)
end

-- 先缓存起来
function Spreader:AddConsume(fConsume)
	if self:IsIntroducee(me) ~= 1 then
		return
	end

	if fConsume and fConsume > 0 then
		local fTempCache = self.tbLittleConsumeCache[me.nId] or 0
		
		fTempCache = fTempCache + fConsume
		
		if fTempCache > 1 then
			local nConsumeCached = me.GetTask(self.TASK_GROUP, self.TASKID_CONSUME)
			me.SetTask(self.TASK_GROUP, self.TASKID_CONSUME, nConsumeCached + fTempCache)
			
			self.tbLittleConsumeCache[me.nId] = fTempCache - math.floor(fTempCache);
		else
			-- 小于1的
			self.tbLittleConsumeCache[me.nId] = fTempCache
		end
		
	end
end

-- 是否由 推广员/老玩家 介绍来的
function Spreader:IsIntroducee(pPlayer)	
	if self:_IsIntroducee_Spreader(pPlayer) == 1 or
	EventManager.ExEvent.tbPlayerCallBack:CheckIsConsumeRelation(pPlayer) == 1  -- 2009-3-9增加：老玩家召回活动
	then
		return 1
	else
		return 0
	end
end

function Spreader:_IsIntroducee_Spreader(pPlayer)
	local nExt = pPlayer.GetExtPoint(6)
	if KLib.BitOperate(nExt, "&", 1) == 1 then
		return 1
	else
		return 0
	end	
end

-- 将玩家消耗发送到GC
function Spreader:Flush(pPlayer)
	local nConsume = pPlayer.GetTask(self.TASK_GROUP, self.TASKID_CONSUME)		-- 取总消耗量
	
--	-- 记录小额消耗的临时表
--	local fConsumeToAdd = self.tbLittleConsumeCache[pPlayer.nId] or 0
--	nConsume = nConsume + fConsumeToAdd
	self.tbLittleConsumeCache[pPlayer.nId] = nil
	
	local nConsumeToSend = math.floor(nConsume / self.ExchangeRate_Rmb2Gold)	-- 只取百位以上的
	local nCharge = me.GetExtPoint(2) 																				-- 取扩展点上累计充值余额￥
	local nLaoWanJia = EventManager.ExEvent.tbPlayerCallBack:CheckIsConsumeRelation(pPlayer);  -- 2009-3-9增加：老玩家召回活动

	if nCharge <= nConsumeToSend then
		nConsumeToSend = nCharge					-- 两者中取小
	end
	if nConsumeToSend > 0 then
		me.PayExtPoint(2, nConsumeToSend) -- 扣除累计充值额
		
		pPlayer.SetTask(self.TASK_GROUP,
			self.TASKID_CONSUME,
			nConsume - nConsumeToSend * self.ExchangeRate_Rmb2Gold)

		if nLaoWanJia == 1 then
			
			local nRealConsume = nConsumeToSend * self.ExchangeRate_Rmb2Gold;
			local nRate		= EventManager.ExEvent.tbPlayerCallBack:GetConsumeRate(pPlayer);
			nRealConsume	= math.floor(nRealConsume * nRate);	

			SendSpreaderConsume(self.ZoneGroup or self:ExtractZoneGroup(),
				pPlayer.szAccount,
				pPlayer.szName,
				nRealConsume,
				pPlayer.nId,
				self.emKTYPE_REDUX_PLAYER)
				
			Dbg:WriteLog("Spreader:Flush",
				"老玩家活动：",
				self.ZoneGroup or self:ExtractZoneGroup(),
				pPlayer.szAccount,
				pPlayer.szName,
				nRealConsume)
		end

		if self:_IsIntroducee_Spreader(pPlayer) == 1 then
			SendSpreaderConsume(self.ZoneGroup or self:ExtractZoneGroup(),
				pPlayer.szAccount,
				pPlayer.szName,
				nConsumeToSend * self.ExchangeRate_Rmb2Gold,
				pPlayer.nId,
				self.emKTYPE_SPREADER)
				
			Dbg:WriteLog("Spreader:Flush",
				"推广员消耗记录：",
				self.ZoneGroup or self:ExtractZoneGroup(),
				pPlayer.szAccount,
				pPlayer.szName,
				nConsumeToSend * self.ExchangeRate_Rmb2Gold)
		end
	end
end

-- 从gateway名中提取区服名
function Spreader:ExtractZoneGroup()
	local szGateway = GetGatewayName()
	local nZoneNumber = tonumber(string.sub(szGateway, 5, 6))
	
	if nZoneNumber then
		self.ZoneGroup = string.format("z%02d", nZoneNumber)
	else
		self.ZoneGroup = "zone.x(" .. szGateway .. ")" -- 无法匹配区服号
	end
	
	return self.ZoneGroup
end

-- 玩家下线后消费记录发送到GC
function Spreader:OnPlayerLogout()
	Spreader:Flush(me)
end

if not Spreader.LogoutHandlerId then
	Spreader.LogoutHandlerId = PlayerEvent:RegisterGlobal("OnLogout",
														  Spreader.OnPlayerLogout,
														  Spreader)
end

Spreader:LoadWareListSetting();
Spreader:LoadNonIbItemConfig();