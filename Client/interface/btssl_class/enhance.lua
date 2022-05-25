--Hiển Thị % cường hóa chi tiết
function Item:CalcEnhanceProb(pEquip, tbEnhItem, nMoneyType)
  	local tbSetting = Item:GetExternSetting("value", pEquip.nVersion);
	if (not tbSetting) then
		return	0;
	end
	local nEnhItemVal = 0;
	local bBind       = 0;
	local tbCalcuate  = {};
	for _, pEnhItem in ipairs(tbEnhItem) do
		nEnhItemVal = nEnhItemVal + pEnhItem.nValue;
		if (pEnhItem.IsBind() == 1) then
			bBind = 1;
		end
		local szName = pEnhItem.szName
		if not tbCalcuate[szName] then
			tbCalcuate[szName] = 0;
		end
		tbCalcuate[szName] = tbCalcuate[szName] + 1;
	end	
	local szLog = ""
	if MODULE_GAMESERVER then
		for szName, nCount in pairs(tbCalcuate) do
			szLog = szLog..szName..nCount..", ";
		end
	end
	local nEnhValue = tbSetting.m_tbEnhanceValue[pEquip.nEnhTimes + 1];
	if (not nEnhValue) then
		return	0;
	end
	local nTypeRate = (tbSetting.m_tbEquipTypeRate[pEquip.nDetail] or 100) / 100;
	local nCostValue = nEnhValue * nTypeRate;
	local nMoney	 = nCostValue * 0.1;
	nCostValue		 = nCostValue - nMoney;
	nMoney 			 = math.floor(nMoney * self:GetJbPrice());
	
	local nFreeCount, tbExecute, nExpMultipe = SpecialEvent.ExtendAward:DoCheck("EnhanceEquip", me);
	nMoney = math.ceil(nMoney * nExpMultipe);
	local nProb = math.floor(nEnhItemVal / nCostValue * 100);
	local nTrueProb = nProb;
	if nMoneyType == Item.BIND_MONEY then
		bBind = 1;
	end
	if (bBind == 1) and (pEquip.IsBind() == 1) then
		bBind = 0;	
	end
	if GetTime() < KGblTask.SCGetDbTaskInt(DBTASK_COZONE_TIME) + 7 * 24 * 60 * 60 and nExpMultipe == 1 then
		nMoney = math.floor(nMoney * 8 / 10);
	end
	return	nProb, nMoney, bBind, szLog, nEnhItemVal, nTrueProb;
end

function Item:FormatMoney(nMoney)
	local szMoney = "";
	if (not nMoney) or (nMoney < 0) then
		return	"Vô hiệu";
	end
	if (nMoney >= 100000000) then
		szMoney = szMoney..tostring(math.floor(nMoney / 100000000)).."Ức";
		nMoney = nMoney % 100000000;
	end
	if (nMoney >= 10000) then
		szMoney = szMoney..tostring(math.floor(nMoney / 10000)).."Vạn";
		nMoney = nMoney % 10000;
	end
	if (nMoney > 0) then
		szMoney = szMoney..tostring(nMoney);
	end
	if (szMoney == "") then
		szMoney = "0";
	end
	return	szMoney;
end
function Item:CalcMaxEnhanceTimes(pEquip)	
	if (not pEquip) then
		return 0;
	end
	local nLevel = pEquip.nLevel;
	if (nLevel <= 3) then
		return 4;					
	elseif (nLevel <= 6) then
		return 8;					
	elseif (nLevel <= 9) then		
		return 12;					
	else
		return 16;					
	end
end