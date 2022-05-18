
-- 玄晶合成功能脚本

------------------------------------------------------------------------------------------
local COMITEM_CLASS = "xuanjing";	-- 道具类型：玄晶
local PEEL_ITEM = { nGenre = Item.SCRIPTITEM, nDetail = 1, nParticular = 1 };	-- 玄晶

-- 各等级玄晶的信息表
local tbCrystal;

local function InitCrystalTable(tbComItem)
	tbCrystal = {};
	for i = 1, 12 do
		tbCrystal[i] = KItem.GetItemBaseProp(18, 1, 1, i);
	end 
end

-- 计算合成价值预算(服务端客户端共用)
function Item:GetComposeBudget(tbComItem, nMoneyType)
	local nTotalValue = 0;
	local bBind = 0;
	if not tbCrystal then
		InitCrystalTable();
	end
	local nTime = 0;
	local tbAbsTime;
	local tbCalcuate = {};
	for i, pItem in pairs(tbComItem) do
		nTotalValue = nTotalValue + pItem.nValue;
		if pItem.IsBind() == 1 then	-- 有一个玄晶绑定则绑定
			bBind = 1;
		end
		if pItem.szClass ~= COMITEM_CLASS then
			return 0;
		end
		local tbTime = me.GetItemAbsTimeout(pItem);
		if tbTime then
			local nNewTime = tbTime[1] * 100000000 + tbTime[2] * 1000000 + 
				tbTime[3] * 10000 + tbTime[4] * 100 + tbTime[5];
			if nTime == 0 or nNewTime < nTime then
				nTime = nNewTime;
				tbAbsTime = tbTime;
			end
		end
		local szName = pItem.szName
		if not tbCalcuate[szName] then
			tbCalcuate[szName] = 0;
		end
		tbCalcuate[szName] = tbCalcuate[szName] + 1;
	end
	local szLog = ""
	if MODULE_GAMESERVER then
		for szName, nCount in pairs(tbCalcuate) do
			szLog = szLog..szName..nCount.."个  ";
		end
	end
	local nMinLevel = 0;
	for i = 1, 12 do
		if nTotalValue >= tbCrystal[i].nValue then
			nMinLevel = i;
		end
	end
	local nFee = math.ceil(nTotalValue / 10 * self:GetJbPrice());
	
	local nMinLevelRate = 0;
	local nMaxLevelRate = 0
	if nMinLevel >= 12 then
		nMinLevel = 11;
		nMinLevelRate = 0;
		nMaxLevelRate = 1;
	else
		nMinLevelRate = tbCrystal[nMinLevel + 1].nValue - nTotalValue;
		nMaxLevelRate = nTotalValue - tbCrystal[nMinLevel].nValue;
	end
	if (bBind == 0) and (nMoneyType == Item.BIND_MONEY) then
		bBind = 1;
	end
	return nMinLevel, nMinLevelRate, nMinLevel + 1, nMaxLevelRate, nFee, bBind, tbAbsTime, szLog;
end

function Item:Compose(tbComItem, nMoneyType, nParam)
	if (me.nFightState ~= 0) then
		me.Msg("Trạng thái chiến đấu không được tiến hành thao tác này!");
		return 0;
	end
	
	local nIbValue = 0;
	local nMinLevel, nMinLevelRate, nMaxLevel, nMaxLevelRate, nFee, bBind, tbAbsTime, szLog = Item:GetComposeBudget(tbComItem, nMoneyType);
	
	if nMinLevel < 1 then
		me.Msg("Không hợp thành được! Có vật phẩm không phải huyền tinh")
		return 0;
	end
	
	-- 合成玄晶不需检查背包空间的前提是玄晶不可叠加，如果可叠加需要检查背包空间
	-- TODO
	if (nMoneyType == Item.NORMAL_MONEY and me.CostMoney(nFee, Player.emKPAY_COMPOSE) ~= 1) then	-- 扣除金钱
		me.Msg("Ngươi không đủ bạc, không thể hợp thành!");
		return 0;
	elseif (nMoneyType == Item.BIND_MONEY and me.CostBindMoney(nFee, Player.emKBINDMONEY_COST_COMPOSE) ~= 1) then
		me.Msg("Không đủ bạc khóa, không thể hợp thành!");
		return 0;
	elseif (nMoneyType ~= Item.NORMAL_MONEY)and (nMoneyType ~= Item.BIND_MONEY) then
		return 0;
	end
	
	if nMoneyType == Item.NORMAL_MONEY then
		KStatLog.ModifyAdd("jxb", "[Tiêu hao] Ghép huyền tinh", "Tổng", nFee);
	end
	
	if nMoneyType == Item.BIND_MONEY then
		KStatLog.ModifyAdd("bindjxb", "[Tiêu hao] Ghép huyền tinh", "Tổng", nFee);
	end
	
	--if nMoneyType == Item.NORMAL_MONEY then
	--	nIbValue = nIbValue + nFee / Spreader.ExchangeRate_Gold2Jxb;
	--end
	
	local szSucc = "Tỷ lệ thành công: "..nMaxLevelRate.."/"..(nMinLevelRate + nMaxLevelRate).." có thể hợp thành "..nMaxLevel.." (cấp) ";
	Dbg:WriteLog("Compose", "Tên nhân vật:"..me.szName, "Tài khoản:"..me.szAccount, "Nguyên liệu: "..szLog, szSucc);
	
	-- 删除玄晶
	for i = 1, #tbComItem do
		if tbComItem[i].nBuyPrice > 0 then -- 有Ib价值量
			nIbValue = nIbValue + tbComItem[i].nBuyPrice; -- Ib价值仍然附在非绑定玄晶上
		end

		local szItemName = tbComItem[i].szName;
		local nRet = me.DelItem(tbComItem[i], Player.emKLOSEITEM_TYPE_COMPOSE);		-- 扣除玄晶
		if nRet ~= 1 then
			Dbg:WriteLog("Compose", "Tên nhân vật:"..me.szName, "Tài khoản:"..me.szAccount, "Trừ "..szItemName.."Thất bại");
			return 0;
		end
	end
	
	local nRandom = Random(nMinLevelRate + nMaxLevelRate);
	local nResultLevel = 0;
	if nRandom < nMinLevelRate then
		nResultLevel = nMinLevel;
	else
		-- 合成了较高级的玄晶
		nResultLevel = nMaxLevel;
	end
	-- 给予玄晶
	local pItem;
	local tbGive = {}
	tbGive.bForceBind = bBind;
	if tbAbsTime then
		tbGive.bTimeOut = 1;
	end
	pItem = me.AddItemEx(PEEL_ITEM.nGenre, PEEL_ITEM.nDetail, PEEL_ITEM.nParticular, nResultLevel, tbGive, Player.emKITEMLOG_TYPE_COMPOSE);
	if pItem and tbAbsTime then
		local nTime = os.time({year = tbAbsTime[1], month=tbAbsTime[2], day=tbAbsTime[3], hour=tbAbsTime[4], min=tbAbsTime[5]});
		me.SetItemTimeout(pItem, os.date("%Y/%m/%d/%H/%M/00", nTime));
	end
	if not pItem then
		-- 给予玄晶失败？记个log吧
		Dbg:WriteLog("Compose", "Tên nhân vật: "..me.szName, "Tài khoản:"..me.szAccount," cho  "..nResultLevel.." (cấp) thất bại!");
		return 0;
	else
		Dbg:WriteLog("Compose", "Tên nhân vật: "..me.szName, " hợp thành 1 "..pItem.szName);
	end

	if bBind ~= 1 then
		pItem.nBuyPrice = nIbValue;
	else
		Spreader:AddConsume(nIbValue);
	end

	return nResultLevel;
end

