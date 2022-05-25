Require("\\script\\item\\class\\equip.lua");
Require("\\script\\item\\zhenyuan\\zhenyuan_define.lua");

------------------------------------------------------------------------------------------
-- initialize

local tbZhenYuan = Item:NewClass("zhenyuan", "equip");
if not tbZhenYuan then
	tbZhenYuan = Item:GetClass("zhenyuan");
end

tbZhenYuan.MASKICON_FILE = "\\image\\effect\\other\\zhenyuan_maskicon.spr";
tbZhenYuan.Icon = {
	[0] = 191,
	[1] = 192,
	[2] = 192,
	[3] = 192,
	[4] = 193,
	[5] = 193,
	[6] = 193,
	[7] = 194,
	[8] = 194,
	[9] = 194,
	[10] = 195,
	[11] = 195,
	[12] = 195,
	[13] = 196,
	[14] = 196,
	[15] = 196,
	[16] = 197,
	[17] = 197,
	[18] = 197,
	[19] = 198,
	[20] = 198,
}
------------------------------------------------------------------------------------------
-- public

function tbZhenYuan:GetTip(nState)		-- ªÒ»°”°’¬Tip
	local szTip = "";
	szTip = szTip.."Trang B·ªã ƒê·ªÉ H·ªô Th·ªÉ\n\n";
	
	szTip = szTip..self:Tip_ReqAttrib();
	szTip = szTip..self:Tip_LevelAndExp();
	
	--  Ù–‘◊ ÷ 
	szTip = szTip..self:Tip_AtribTip();

	return szTip;
end

--  Ù–‘µƒTIP
function tbZhenYuan:Tip_AtribTip()
	local szTip = "<color=gold>C·∫•p sao v√† thu·ªôc t√≠nh t∆∞ ch·∫•t<color>\n\n";
	
	local tbBaseAttrib = it.GetBaseAttrib();
	--local tbAttribEnhanced = Item.tbZhenYuan:GetAttribEnhanced(it, 0);
			
	for i= 1,Item.ZHENYUAN_ATTRIB_NUM do
		local nLevel, nExp, nUpgradeExp = Item:CalcZhenYuanUpgrade(it, i, 0);
		local nStarLevel = math.floor((nLevel / Item.tbMAX_ZHENYUAN_LEVEL[it.nLevel][i])*18);
		--Tip1
		local szStar = self:GetAttribStar(nStarLevel, 1);
		--Tip2
		local szStarTip = ""; 
		for nStarId=1,18 do
			if nStarId > nStarLevel then
				szStarTip = szStarTip.."<pic=191>";
			else
				szStarTip = szStarTip.."<pic="..tbZhenYuan.Icon[nStarId]..">";
			end
		end	
		local szAttribTipName = self:GetAttribTipName(tbBaseAttrib[i].szName);
		
		szTip = szTip..string.format("<color=green>%s c·∫•p %d <color=gold>[%d/%d]<color><color>\n", szAttribTipName, nLevel, nExp, nUpgradeExp);
		--Use Tip1
		szTip = szTip..string.format("\n   %s\n", szStar);
		--Use Tip2
		szTip = szTip..string.format(" %s\n", szStarTip);
	end
	
	return szTip;
end

function tbZhenYuan:Tip_LevelAndExp()
	return "C·∫•o ch√¢n nguy√™n 120 [0/0]\n\n";
	--[[
	return string.format("’Ê‘™µ»º∂£∫%d [%d/%d]\n\n", 
		Item.tbZhenYuan:GetLevel(it), 
		Item.tbZhenYuan:GetCurExp(it), 
		Item.tbZhenYuan:GetNeedExp(Item.tbZhenYuan:GetLevel(it)));
		]]
end


-- ªÒµ√ƒ≥Ãı Ù–‘◊ ÷ µƒº€÷µ¡ø–«º∂£¨’‚¿Ô∑µªÿµƒ «÷ÿ◊È◊÷∑˚¥Æ£¨≤ª «–«º∂ ˝
-- nType£∫1±Ì æÕº∆¨£¨2±Ì æ»°Œƒ±æ
function tbZhenYuan:GetAttribStar(nPotenLevel, nType)
	local tbSetting = Partner.tbStarLevel;
	local szFillStar = "";
	local szEmptyStar = "";
	if nType == 1 and tbSetting and tbSetting[nPotenLevel] then
		szFillStar = string.format("<pic=%s>", tbSetting[nPotenLevel].nFillStar - 1);
		szEmptyStar = string.format("<pic=%s>", tbSetting[nPotenLevel].nEmptyStar - 1);
	else
				szFillStar = "‚òÖ";
		szEmptyStar = "‚òÜ";
	end
	local szStar = "";
	
	for i = 1, math.floor(nPotenLevel / 2) do
		szStar = szStar..szFillStar;
		if i % 3 == 0 then
			szStar = szStar.." ";
		end
	end
	if (nPotenLevel % 2 ~= 0) then
		szStar = szStar..szEmptyStar;
	end
	
	return szStar;
end

function tbZhenYuan:CalcValueInfo()
	local nValue = it.nOrgValue;
	for i = 1, Item.ZHENYUAN_ATTRIB_NUM do
		local nLevel = it.GetGenInfo(2 * i - 1);
		if Item.tbZhenYuanSetting.m_LevelValue[nLevel] then
			nValue = nValue + Item.tbZhenYuanSetting.m_LevelValue[nLevel];
		end
	end

	local szMaskIcon = nil;
	szMaskIcon = self.MASKICON_FILE;
	
	local nStarLevel, szNameColor, szTransIcon = Item:CalcStarLevelInfo(it.nVersion, it.nDetail, it.nLevel, nValue);
	
	return	nValue, nStarLevel, szNameColor, szTransIcon, szMaskIcon;
end

-- Õ®π˝ Ù–‘IDªÚ’ﬂ Ù–‘√˚ªÒ»° Ù–‘TIP√˚◊÷
function tbZhenYuan:GetAttribTipName(varAttrib)
	local nId = 0;
	if type(varAttrib) == "number" then
		nId = varAttrib;
	elseif type(varAttrib) == "string" then
		nId = Item.tbZhenYuanSetting.tbAttribNameToId[varAttrib];
	end
	
	if not nId or nId == 0 then
		return "";
	end
	
	return Item.tbZhenYuanSetting.tbAttribSetting[nId].szTipText;
end
--------------------------------Item----------------------------------

function Item:CalcZhenYuanUpgrade(pZhenYuan, nMagicIndex, nItemNum)
	if not pZhenYuan or pZhenYuan.szClass ~= self.ZHENYUAN_EQUIP_CLASS then
		return 0;
	end
	if nMagicIndex <= 0 or nMagicIndex > self.ZHENYUAN_ATTRIB_NUM then
		return 0;
	end
	local nLevel 	= pZhenYuan.GetGenInfo(nMagicIndex * 2 - 1, 0);
	local nExp		= pZhenYuan.GetGenInfo(nMagicIndex * 2, 0);
	
	-- ∏˘æ›ŒÂ––”°µƒ≤ªÕ¨£¨ Ù–‘µ»º∂µƒ…œœﬁ“≤≤ªÕ¨
	local nLevelMax = self.tbMAX_ZHENYUAN_LEVEL[pZhenYuan.nLevel or 1][nMagicIndex];
	
	
	nExp = nExp + math.floor(nItemNum * self.ZHENYUAN_EXP_PER_ITEM / 100);

	if nLevel < self.MIN_ZHENYUAN_LEVEL then
		return 0;
	end
	while (nLevel < nLevelMax and nExp >= Item.tbZhenYuanSetting.m_LevelExp[nLevel]) do
		nExp = nExp - Item.tbZhenYuanSetting.m_LevelExp[nLevel];
		nLevel = nLevel + 1;
	end
	local nResCount = 0;
	-- »Áπ˚µ»º∂µΩ¥Ô…œœﬁ∫Û£¨ªπ”–∂‡”‡µƒæ≠—È£¨∞—’‚–©æ≠—È◊™≥…ªÍ Ø∏ˆ ˝∑µªπ∏¯ÕÊº“
	if nLevel >= nLevelMax and  nExp > 0 then
		nResCount = math.floor(nExp / (self.ZHENYUAN_EXP_PER_ITEM / 100));
	end
	return nLevel, nExp, Item.tbZhenYuanSetting.m_LevelExp[nLevel] or 0, nResCount;
end

function Item:SetZhenYuanMagic(pZhenYuan, nMagicIndex, nLevel, nExp)
	pZhenYuan.SetGenInfo(nMagicIndex * 2 - 1, nLevel);
	pZhenYuan.SetGenInfo(nMagicIndex * 2, nExp);
	local nRet = pZhenYuan.Regenerate(
		pZhenYuan.nGenre,
		pZhenYuan.nDetail,
		pZhenYuan.nParticular,
		pZhenYuan.nLevel,
		pZhenYuan.nSeries,
		pZhenYuan.nEnhTimes,
		pZhenYuan.nLucky,
		pZhenYuan.GetGenInfo(),
		0,
		pZhenYuan.dwRandSeed,
		0
	);
end

function Item:UpgradeZhenYuanNoItem(pZhenYuan, nCurCount, nMagicIndex)
	if not pZhenYuan or pZhenYuan.szClass ~= self.ZHENYUAN_EQUIP_CLASS then
		return 0;
	end

	-- ∏˘æ›ŒÂ––”°µƒ≤ªÕ¨£¨ Ù–‘µ»º∂µƒ…œœﬁ“≤≤ªÕ¨
	local nLevelMax = self.tbMAX_ZHENYUAN_LEVEL[pZhenYuan.nLevel or 1][nMagicIndex];

	local nLevel, nExp, _, nResCount = self:CalcZhenYuanUpgrade(pZhenYuan, nMagicIndex, nCurCount);
	if nLevel >= nLevelMax then -- …˝º∂µΩº´œﬁ¡À
		nExp=0;
	end
	local nRet = self:SetZhenYuanMagic(pZhenYuan, nMagicIndex, nLevel, nExp);

	return nResCount; -- ∑µªÿ±£¡Ù ˝¡ø
end
