Require("\\script\\item\\class\\equip.lua");

------------------------------------------------------------------------------------------
-- initialize

local tbSoulSignet = Item:NewClass("soulsignet", "equip");
if not tbSoulSignet then
	tbSoulSignet = Item:GetClass("soulsignet");
end

------------------------------------------------------------------------------------------
-- public

function tbSoulSignet:GetTip(nState)		-- »ñÈ¡Ó¡ÕÂTip
	local szTip = "";
	szTip = szTip..self:Tip_ReqAttrib();
	szTip = szTip..self:Tip_Durability();
	szTip = szTip..self:Tip_Level();
	szTip = szTip..self:Tip_Series(nState);
	szTip = szTip..self:Tip_BaseAttrib(nState);
	return szTip;
end

function tbSoulSignet:Tip_BaseAttrib(nState)	-- »ñµÃTip×Ö·û´®£º»ù´¡ÊôÐÔ

	local szTip = "";
	local tbAttrib = it.GetBaseAttrib();	-- »ñµÃµÀ¾ß»ù´¡ÊôÐÔ

	for i, tbMA in ipairs(tbAttrib) do
		local szDesc = self:GetMagicAttribDesc(tbMA.szName, tbMA.tbValue);
		local nLevel, nExp, nUpgradeExp = Item:CalcSoulUpgrade(it, i, 0);
		local bInvalid = it.IsInvalid();
		if (szDesc ~= "") and (nLevel > 0) then
			if nLevel >= Item.tbMAX_SOULSIGNET_LEVEL[it.nLevel][i] then 
				nExp = 0;
				nUpgradeExp = 0;
			end
			if bInvalid == 1 then
				szTip = szTip..string.format("\n<color=gray>"..Lib:StrFillL(szDesc, 18).."\n<color=red>(Tá»¥ linh <color=gold>%d/%d<color>)<color>", nExp, nUpgradeExp);
			else
				szTip = szTip.."\n"..Lib:StrFillL(szDesc, 18)..string.format("\n<color=red>(Tá»¥ linh <color=gold>%d/%d<color>)<color>", nExp, nUpgradeExp);
			end
			print(szTip);
		end
	end

	if szTip ~= "" then
		return	"\n<color=greenyellow>"..szTip.."<color>";
	end
	return szTip;
end

function tbSoulSignet:CalcValueInfo()
	local nValue = it.nOrgValue;
	local tbSetting = Item:GetExternSetting("soulsignet", it.nVersion);
	if tbSetting then
		for i = 1, Item.SOULSIGNET_ATTRIB_NUM do
			local nLevel = it.GetGenInfo(2 * i - 1);
			if tbSetting["m_LevelValue"..i][nLevel] then
				nValue = nValue + tbSetting["m_LevelValue"..i][nLevel];
			end
		end
	end
	
	local nStarLevel, szNameColor, szTransIcon = Item:CalcStarLevelInfo(it.nVersion, it.nDetail, it.nLevel, nValue);
	
	return	nValue, nStarLevel, szNameColor, szTransIcon;
end