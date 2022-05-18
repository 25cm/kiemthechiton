Require("\\script\\item\\class\\equip.lua");

------------------------------------------------------------------------------------------
-- initialize

--UpGrade Type Of Equip, Can use in OutHat-26,Garment-25,Mask-13
--Set item have different nLevel
Item.UPGRADE_TYPE_EQUIP_CLASSNAME = "upgradeequip";
Item.UPGRADE_TYPE_EQUIP_LEVEL_GENID = 12;
Item.UPGRADE_TYPE_EQUIP_GRADE_GENID = 11;
Item.UPGRADE_TYPE_EQUIP_GROWTH_RATE = {
	-- [nLevel] = {1-20's Growth Rate}
	-- [1] if nLevel is 1,then can't use this functions.
	[2] = {5,10,15,20,26,32,38,44,52,60,68,76,86,96,110,130,150,180,210,250}, --成长率 标识附加x%的属性。 
	[3] = {7,15,18,22,39,48,57,66,78,90,102,114,129,144,165,195,225,270,315,375}, --成长率 标识附加x%的属性。 
	[4] = {5,10,15,20,26,32,38,44,52,60,68,76,86,96,110,130,150,180,210,250}, --成长率 标识附加x%的属性。 
}

local tbUpGradeEquip = Item:NewClass("upgradeequip", "equip");
if not tbUpGradeEquip then
	tbUpGradeEquip = Item:GetClass("upgradeequip");
end

function tbUpGradeEquip:InitGenInfo()
	local tbAttrib = it.GetBaseAttrib();
	for i, tbMA in ipairs(tbAttrib) do
		--if (tbMA.szName ~= "")
		print(i,tbMA.tbValue[1]);
		if (tbMA.tbValue[1] ~= 0 ) then
			it.SetGenInfo(i,tbMA.tbValue[1]);
		end
	end
	return {};
end

tbUpGradeEquip.Icon = {
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

function Item:SetGradeEquipUpGradeLevel(pEquip,nSetLevel)
	if not pEquip then
		return 0;
	end
	
	pEquip.SetGenInfo(Item.UPGRADE_TYPE_EQUIP_LEVEL_GENID, nSetLevel);
	local UpGrade = Item.UPGRADE_TYPE_EQUIP_GROWTH_RATE[pEquip.nLevel][nSetLevel];
	pEquip.SetGenInfo(Item.UPGRADE_TYPE_EQUIP_GRADE_GENID, UpGrade);
	local nRet = pEquip.Regenerate(
		pEquip.nGenre,
		pEquip.nDetail,
		pEquip.nParticular,
		pEquip.nLevel,
		pEquip.nSeries,
		pEquip.nEnhTimes,
		pEquip.nLucky,
		pEquip.GetGenInfo(),
		0,
		pEquip.dwRandSeed,
		0
	);
end

function tbUpGradeEquip:Tip_BaseAttrib(nState)	-- 获得Tip字符串：基础属性

	local szTip = "";
	local tbAttrib = it.GetBaseAttrib();	-- 获得道具基础属性

	for i, tbMA in ipairs(tbAttrib) do
		local szDesc  = "";
		local AddValue =0;
		local OldValue = 0;
		if it.nLevel > 1 then
			OldValue = it.GetGenInfo(i);
			local tbMA2 = tbMA;
			AddValue = tbMA.tbValue[1] - OldValue;
			tbMA2.tbValue[1]=OldValue;
			szDesc = self:GetMagicAttribDesc(tbMA.szName, tbMA2.tbValue);
		else
			szDesc = self:GetMagicAttribDesc(tbMA.szName, tbMA.tbValue);
		end
		local bInvalid = it.IsInvalid();
		if (szDesc ~= "") then
			if bInvalid == 1 then
				if (it.nLevel > 1) and (AddValue ~= 0) then
					szTip = szTip..string.format("\n<color=gray>%s<color> + %d", szDesc,AddValue);
				else
					szTip = szTip..string.format("\n<color=gray>%s<color>", szDesc,AddValue);
				end
			else
				if (it.nLevel > 1) and (AddValue ~= 0) then
					szTip = szTip..string.format("\n%s + %d", szDesc,AddValue);
				else
					szTip = szTip.."\n"..szDesc;
				end
			end
		end
	end
	local nStarLevel 	= it.GetGenInfo(Item.UPGRADE_TYPE_EQUIP_LEVEL_GENID);
	local szStarTip		= "";
	if it.nLevel > 1 then
		for nStarId=1,20 do
			if nStarId > nStarLevel then
				szStarTip = szStarTip.."<pic=191>";
			else
				szStarTip = szStarTip.."<pic="..tbUpGradeEquip.Icon[nStarId]..">";
			end
		end
		szTip = szTip.."\n<color><color=yellow>S? quan tam sau s?c：\n"..szStarTip;
	end
	if szTip ~= "" then
		return	"\n<color=greenyellow>"..szTip.."<color>";
	end
	return szTip;
end

function tbUpGradeEquip:CalcValueInfo()
	local nValue = it.nOrgValue;
	local nEnhStar = it.GetGenInfo(Item.UPGRADE_TYPE_EQUIP_LEVEL_GENID);
	nValue = math.floor(nEnhStar * nEnhStar / 100) * nValue*5000;
	local nStarLevel, szNameColor, szTransIcon = Item:CalcStarLevelInfo(it.nVersion, it.nDetail, it.nLevel, nValue);
	
	return	nValue, nStarLevel, szNameColor, szTransIcon;
end