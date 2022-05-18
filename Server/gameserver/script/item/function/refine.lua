

Item.REFINE_RECIPE_CALSS = "refineitem";
Item.REFINE_XUANJING_CALSS = "xuanjing";

local function CompareNumberTable(tbNumTab1, tbNumTab2)
	if #tbNumTab1 ~= #tbNumTab2 then
		print("if #tbNumTab1 ~= #tbNumTab2 then")
		return 0;
	end
	for i = 1, #tbNumTab1 do
		if tbNumTab1[i] ~= tbNumTab2[i] then
			return 0;
		end
	end
	return 1;
end


function Item:CalcEnhanceValue(pEquip)
	local tbSetting = Item:GetExternSetting("value", pEquip.nVersion);
	local nEnhTimes = pEquip.nEnhTimes;
	local nPeelValue = 0;

	repeat
		local nEnhValue = tbSetting.m_tbEnhanceValue[nEnhTimes] or 0;
		nPeelValue = nPeelValue + nEnhValue;
		nEnhTimes = nEnhTimes - 1;
	until (nEnhTimes <= 0);

	if (nPeelValue <= 0) then
		return 0;
	end
	
	local nTypeRate = (tbSetting.m_tbEquipTypeRate[pEquip.nDetail] or 100) / 100;
	nPeelValue = nPeelValue * nTypeRate;

	return nPeelValue;
end

function Item:CalcRefineMoney(pEquip)
	if not pEquip then
		print("no pEquip")
		return;
	end
	local nEnhanceValue = Item:CalcEnhanceValue(pEquip);
	local nEnhLevel = pEquip.nEnhTimes;
	local nRefineMoney = 0;
	local nJbPrice = self:GetJbPrice();
	if nJbPrice < 1 then
		nJbPrice = 1;
	end
	
	if nEnhLevel >= 12 and nEnhLevel <= 13 then
		nRefineMoney = nEnhanceValue * Item.ENHANCE_COST_RATE * nJbPrice - nEnhanceValue * Item.PEEL_RESTORE_RATE_12;
	elseif nEnhLevel >= 14 and nEnhLevel <= 16 then
		nRefineMoney = nEnhanceValue * Item.ENHANCE_COST_RATE * nJbPrice - nEnhanceValue * Item.PEEL_RESTORE_RATE_14;
	else
		nRefineMoney = nEnhanceValue * Item.ENHANCE_COST_RATE * nJbPrice;
	end

	return nRefineMoney;
end
	
function Item:CalcRefineItem(tbRefineItem, nIndex)
	local nRefineId 	= 0;
	local pRefineItem 	= nil;
	local pEquip		= nil;
 	local tbRefineStuff = {};
 	local nXuanJingValue = 0;
 	local nRefineDegree	= 0;
	for _, pItem in pairs(tbRefineItem) do
		if pItem.szClass == self.REFINE_RECIPE_CALSS then
			if pRefineItem then 		-- 放入了两个配方
				return;
			end
			pRefineItem = pItem;
			nRefineId = pItem.GetExtParam(1);
		elseif pItem.szClass == self.REFINE_XUANJING_CALSS then -- 放入了玄晶		
			nXuanJingValue = nXuanJingValue + pItem.nValue;
		elseif pItem.IsEquip() == 1 then
			if pEquip then				-- 放入了两件装备
				return;
			end
			pEquip = pItem;
		else
			table.insert(tbRefineStuff, pItem);
		end
	end
	if not pEquip or not pRefineItem or nRefineId == 0 then	-- 没原料装备或没改造图
		print("if not pEquip or not pRefineItem or nRefineId == 0 then")
		return;
	end
	local tbRefineSetting = Item:GetExternSetting("refine",1);          
	local tbRequireItem = {};
	if tbRefineSetting.m_tbRefineRequire and tbRefineSetting.m_tbRefineRequire[nRefineId] then
		tbRequireItem = tbRefineSetting.m_tbRefineRequire[nRefineId];
		for i = 1, tbRefineSetting.REQUIRE_MAX do
			local nCount = tbRefineSetting.m_tbRefineRequire[nRefineId][i].nCount;
			if nCount and nCount > 0 then
				local nItemCount = self:CalcItemCountInTable(tbRefineStuff, unpack(tbRefineSetting.m_tbRefineRequire[nRefineId][i]))
				if nItemCount < nCount then		-- 材料不足
					return;
				end
			end
		end
	end
	
	
	local tbProduce = {};
	if tbRefineSetting.m_tbRefine and tbRefineSetting.m_tbRefine[nRefineId] then
		if not nIndex then
			for i, tbProdEquip in pairs(tbRefineSetting.m_tbRefine[nRefineId]) do
				if ((tbProdEquip.nSex < 0 or tbProdEquip.nSex == me.nSex) and
					(tbProdEquip.nFaction < 0 or tbProdEquip.nFaction == me.nFaction) and
					(tbProdEquip.nAttRoute < 0 or tbProdEquip.nAttRoute == me.GetAttRoute())
					and (CompareNumberTable(tbProdEquip.tbEquip, {pEquip.nGenre, pEquip.nDetail, pEquip.nParticular, pEquip.nLevel}) == 1)) 
					then
						table.insert(tbProduce, {tbEquip = tbProdEquip.tbProduce, nFee = tbProdEquip.nFee, nIdx = i});
				end
			end
		else
			if tbRefineSetting.m_tbRefine[nRefineId][nIndex] then
				local tbProdEquip = tbRefineSetting.m_tbRefine[nRefineId][nIndex];
				table.insert(tbProduce, {tbEquip = tbProdEquip.tbProduce, nFee = tbProdEquip.nFee, nIdx = nIndex})
			end
		end
	end
		
	if pEquip.nEnhTimes > 0 and #tbProduce > 0 then
		nRefineDegree = math.floor((Item:CalcEnhanceValue(pEquip) * 8 + nXuanJingValue * 10) / (Item:CalcEnhanceValue(pEquip) * 9) * 100);

		if nRefineDegree > 100 then 
			nRefineDegree = 100;
		end
	elseif pEquip.nEnhTimes == 0 and #tbProduce > 0 then
		nRefineDegree = 100;
	end

	return pEquip, pRefineItem, tbProduce, tbRefineStuff, tbRequireItem, nRefineDegree; 
end

function Item:CalcItemCountInTable(tbItemSet, nGenre, nDetail, nPar, nLevel)
	local nCount = 0;
	for _, pItem in pairs(tbItemSet) do
		if (pItem.nGenre == nGenre and
			pItem.nDetail == nDetail and
			pItem.nParticular == nPar and
			pItem.nLevel == nLevel) 
			then
				nCount = nCount + pItem.nCount;
		end
	end
	return nCount;
end

function Item:DelItemInTable(pPlayer, tbItemSet, nCount, nGenre, nDetail, nPar, nLevel)
	for _, pItem in pairs(tbItemSet) do
		if (pItem.nGenre == nGenre and
			pItem.nDetail == nDetail and
			pItem.nParticular == nPar and
			pItem.nLevel == nLevel) 
			then
				local nItemCount = pItem.nCount;
				if nItemCount <= nCount then
					nCount = nCount - nItemCount;
					if pPlayer.DelItem(pItem) ~= 1 then
						return -1;
					end
				else
					pItem.SetCount(nItemCount - nCount);
					nCount = 0;
				end
				if nCount <= 0 then
					return 1;
				end
		end
	end
	return 0;
end

function Item:DoRefine(tbRefineItem, nMoneyTeyp, nIndex)
	local pEquip, pRefineItem, tbProduce, tbRefineStuff, tbRequireItem, nRefineDegree = self:CalcRefineItem(tbRefineItem, nIndex)
	if not pEquip then   -- 校验失败！
		me.Msg("Nguyên liệu mà bạn cung cấp không thể luyện hóa trang bị mới");
		return 0;
	end

	if not tbProduce or #tbProduce ~= 1 then	-- 没产物？产物不只1个？
		me.Msg("Nguyên liệu mà bạn cung cấp không thể luyện hóa trang bị mới");
		return 0;
	end
	
	if nRefineDegree < 100 then   -- 炼化度不足
		me.Msg("Độ luyện hóa trang bị của bạn không đủ!");
		return 0;
	end
	
	local nMoney = tbProduce[1].nFee + self:CalcRefineMoney(pEquip);
	
	if (me.CostBindMoney(nMoney, Player.emKBINDMONEY_COST_REFINE) ~= 1) then
		if (me.nCashMoney + me.GetBindMoney() < nMoney) then
			me.Msg("Bạc bạn đem theo không đủ, không thể luyện hóa!");
			return 0;
		else
			local nBindMoney = me.GetBindMoney();
			me.CostBindMoney(nBindMoney, Player.emKBINDMONEY_COST_REFINE);
			me.CostMoney(nMoney - nBindMoney, Player.emKPAY_REFINE);
			KStatLog.ModifyAdd("bindjxb", "[Tiêu hao] Luyện hóa trang bị", "Tổng", nBindMoney);
			KStatLog.ModifyAdd("jxb", "[Tiêu hao] Luyện hóa trang bị", "Tổng", nMoney - nBindMoney);			
		end
	else
		KStatLog.ModifyAdd("bindjxb", "[Tiêu hao] Luyện hóa trang bị", "Tổng", nMoney);
	end
	
	PlayerHonor:AddConsumeValue(me, self:CalcRefineMoney(pEquip) , "refine");


	if pEquip.nEnhTimes > 0 then 
		local newEnhanceValue = self:CalcEnhanceValue(pEquip) * 0.1;	
		PlayerHonor:AddConsumeValue(me, newEnhanceValue, "refine");
		
		for _, tbItem in pairs(tbRefineItem) do
			if tbItem.szClass == self.REFINE_XUANJING_CALSS then
				if me.DelItem(tbItem) ~= 1 then -- 扣除玄晶失败！
					Dbg:WriteLog("Refine", "Tên nhân vật:"..me.szName, "Tài khoản:"..me.szAccount, "Khấu trừ Huyền tinh thất bại", unpack(tbItem));
					return 0;
				end		
			end 
		end
	end
	
	for _, tbItem in pairs(tbRequireItem) do
		if self:DelItemInTable(me, tbRefineStuff, tbItem.nCount, unpack(tbItem)) ~= 1 then		-- 扣除材料失败！
			Dbg:WriteLog("Refine", "Tên nhân vật:"..me.szName, "Tài khoản:"..me.szAccount, "Khấu trừ đạo cụ thất bại", unpack(tbItem));
			return 0;
		end
	end
	
	if me.DelItem(pRefineItem) ~= 1 then
		Dbg:WriteLog("Refine", "Tên nhân vật:"..me.szName, "Tài khoản:"..me.szAccount, "Khấu trừ Cải Tạo Đồ thất bại", pRefineItem.szName);
		return 0;
	end
	local nRet = pEquip.Regenerate(
		tbProduce[1].tbEquip[1],
		tbProduce[1].tbEquip[2],
		tbProduce[1].tbEquip[3],
		tbProduce[1].tbEquip[4],
		pEquip.nSeries,
		pEquip.nEnhTimes,
		pEquip.nLucky,
		nil,
		0,
		pEquip.dwRandSeed,
		pEquip.nStrengthen
	);
	if nRet ~= 1 then
		Dbg:WriteLog("Refine", "Tên nhân vật:"..me.szName, "Tài khoản:"..me.szAccount, "Regenerate đạo cụ thất bại");
		return 0;
	end
	pEquip.Bind(1);  	-- 强制绑定
	me.Msg("Luyện hóa thành công! Trang bị của bạn được luyện hóa thành <color=gold>"..pEquip.szName.."<color>");
	
	return 1;
end

