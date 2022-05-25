
-- 印鉴属性升级
-- zhengyuhua

-- define

Item.UPGRADE_EXP_PER_ITEM		= 10;				-- 每个魂石头的经验
Item.UPGRADE_ITEM_CLASS			= "spiritstore"		-- 魂石Classname
Item.UPGRADE_EQUIP_CLASS		= "signet"			-- 印章Classname

----------------------------------------------------------------------

function Item:SetSignetMagic(pSignet, nMagicIndex, nLevel, nExp)
	pSignet.SetGenInfo(nMagicIndex * 2 - 1, nLevel);
	pSignet.SetGenInfo(nMagicIndex * 2, nExp);
	local nRet = pSignet.Regenerate(
		pSignet.nGenre,
		pSignet.nDetail,
		pSignet.nParticular,
		pSignet.nLevel,
		pSignet.nSeries,
		pSignet.nEnhTimes,
		pSignet.nLucky,
		pSignet.GetGenInfo(),
		0,
		pSignet.dwRandSeed,
		0
	);
	if nRet == 1 then
		Dbg:WriteLog("Upgrade", "Tên nhan v?t:"..me.szName, "Tài kho?n:"..me.szAccount, "Nang c?p thu?c tính th? "..nMagicIndex.." c?a Ng? Hành ?n thành ", nLevel, nExp);
	else
		Dbg:WriteLog("Upgrade", "Tên nhan v?t:"..me.szName, "Tài kho?n:"..me.szAccount, "Nang c?p Ng? Hành ?n th?t b?i, Regenerate");
	end
end

function Item:CalcUpgrade(pSignet, nMagicIndex, nItemNum)
	if not pSignet or pSignet.szClass ~= self.UPGRADE_EQUIP_CLASS then
		return 0;
	end
	if nMagicIndex <= 0 or nMagicIndex > self.SIGNET_ATTRIB_NUM then
		return 0;
	end
	local nLevel 	= pSignet.GetGenInfo(nMagicIndex * 2 - 1, 0);
	local nExp		= pSignet.GetGenInfo(nMagicIndex * 2, 0);
	
	-- zhengyuhua:庆公测活动临时内容
	local nMuti = 100;
	local nBufLevel = me.GetSkillState(881);
	if nBufLevel > 0 then
		nMuti = nMuti * 1.2;
	end
	
	nExp = nExp + math.floor(nItemNum * self.UPGRADE_EXP_PER_ITEM * nMuti / 100);
	local tbSetting = Item:GetExternSetting("signet", pSignet.nVersion);
	if nLevel < self.MIN_SIGNET_LEVEL then
		return 0;
	end
	while (nLevel < self.MAX_SIGNET_LEVEL and nExp >= tbSetting.m_LevelExp[nLevel]) do
		nExp = nExp - tbSetting.m_LevelExp[nLevel];
		nLevel = nLevel + 1;
	end
	local nResCount = 0;
	if nLevel >= self.MAX_SIGNET_LEVEL and  nExp > tbSetting.m_LevelExp[nLevel] then
		nResCount = math.floor(nExp / (self.UPGRADE_EXP_PER_ITEM * nMuti / 100));
	end
	return nLevel, nExp, tbSetting.m_LevelExp[nLevel] or 0, nResCount;
end

-- 升级五行印  
-- 		参数说明：pSignet:五行印指针，tbUpgradeItem:放在升级栏的道具，nMagicIndex:选择要升级的属性
function Item:UpgradeSignet(pSignet, tbUpgradeItem, nMagicIndex)
	if not pSignet or pSignet.szClass ~= self.UPGRADE_EQUIP_CLASS then
		return 0;
	end

	local nItemNum = 0;
	for _, pItem in pairs(tbUpgradeItem) do
		if pItem.szClass == self.UPGRADE_ITEM_CLASS then	-- 检查是否是魂石
			local nCurCount = pItem.nCount;
			local nLevel, nExp, _, nResCount = self:CalcUpgrade(pSignet, nMagicIndex, nCurCount);
			local nRet = 0;
			if nResCount > 0 then
				nRet = pItem.SetCount(nResCount);
			elseif nResCount == 0 then
				nRet = me.DelItem(pItem, Player.emKLOSEITEM_SERIES_STONE);		-- 扣除魂石
			end
			if nRet ~= 1 then
				Dbg:WriteLog("Upgrade", "Tên nhan v?t:"..me.szName, "Tài kho?n:"..me.szAccount, "Tr? H?n Th?ch th?t b?i! S? c?ng d?n: ", nCurCount);
			else
				nItemNum = nItemNum + nCurCount;
				self:SetSignetMagic(pSignet, nMagicIndex, nLevel, nExp);
			end
			if nLevel >= self.MAX_SIGNET_LEVEL then -- 升级到极限了
				break;
			end
		else
		Dbg:WriteLog("Upgrade", "Tên nhan v?t:"..me.szName, "Tài kho?n:"..me.szAccount, "Th? ??t vào kh?ng ph?i H?n Th?ch nang c?p Ng? Hành ?n")
		end
	end
	if nItemNum == 0 then
		return 0;
	end

	return 1;
end


