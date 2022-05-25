
-- װͨùܽű

------------------------------------------------------------------------------------------
-- initialize
local nScriptVersion = Item.IVER_nEquipEnhance

local tbEquip = Item:GetClass("equiptt");

-- ߳
tbEquip.HOLDSTATUS_NONE			= 0;	-- ӵдƷ
tbEquip.HOLDSTATUS_ROOM			= 1;	-- ӻƷʧЧ
tbEquip.HOLDSTATUS_EQUIP		= 2;	-- װ

-- вĥϵͳװλ
tbEquip.ABRADE_POS =
{
	Item.EQUIPPOS_HEAD,
	Item.EQUIPPOS_BODY,
	Item.EQUIPPOS_BELT,
	Item.EQUIPPOS_WEAPON,
	Item.EQUIPPOS_FOOT,
	Item.EQUIPPOS_CUFF,
	Item.EQUIPPOS_AMULET,
	Item.EQUIPPOS_RING,
	Item.EQUIPPOS_NECKLACE,
	Item.EQUIPPOS_PENDANT,
};

-- Ǳб
tbEquip.POTENTIAL_NAME = { "Sức mạnh", "Thân pháp", "Ngoại công", "Nội công" };

------------------------------------------------------------------------------------------
-- public

function tbEquip:OnUse()			-- ҼԶװ
	local nCanUse, szMsg = Item:CheckIsUseAtMap(me.nMapId, it.dwId);
	if (me.CanUseItem(it) == 1 and nCanUse == 1) then
		me.AutoEquip(it);
		me.AddTitle(17, 202, 8, 0);
	else
		self:DialogChange(it);
	end
	return	0;

end

function tbEquip:DialogChange(pEquip)
	local tbOpt = {};
	local tbSetting = Item:GetExternSetting("change", it.nVersion, 1);
	local szGDPL = string.format("%d,%d,%d,%d", pEquip.nGenre, pEquip.nDetail, pEquip.nParticular, pEquip.nLevel);
	if not tbSetting.tbItemToChangeId or not tbSetting.tbItemToChangeId[szGDPL] then
		return 0;
	end
	local tbFacEquip = Item:CheckCanChangable(pEquip);
	local tbFactions = Faction:GetGerneFactionInfo(me);
	for nFactionId, tbGDPL in pairs(tbFacEquip) do
		for _, id in ipairs(tbFactions) do
			if (id == nFactionId) then
				table.insert(tbOpt, {Player.tbFactions[nFactionId].szName, Item.ChangeEquipToFac, Item, it.dwId, nFactionId});
			end
		end
	end
	table.insert(tbOpt, {"Không cần chuyển đổi"});
	Dialog:Say("Không thể sử dụng trang bị, nhưng có thể chuyển đổi thành trang bị tương ứng với môn phái, <color=green>tất cả thuộc tính của trang bị đều chuyển đổi bằng giá, không sợ bị lỗ.<color>",
		tbOpt);
end

function tbEquip:GetTip(nState, tbEnhRandMASS, tbEnhEnhMASS)		-- ȡװTip

	local szTip = "";

	szTip = szTip..self:Tip_ReqAttrib();
	szTip = szTip..self:Tip_Durability();
	szTip = szTip..self:Tip_Level();
	szTip = szTip..self:Tip_Series(nState);
	szTip = szTip.."<color>";
	szTip = szTip..self:Tip_BaseAttrib(nState);
	szTip = szTip..self:Tip_RandAttrib(nState, tbEnhRandMASS);
	szTip = szTip..self:Tip_EnhAttrib(nState, tbEnhEnhMASS);
	szTip = szTip..self:Tip_StrAttrib(nState);
	szTip = szTip..self:Tip_Maker();
	szTip = szTip..self:Tip_RepairInfo(nState);
	szTip = szTip..self:GetBreakUpStuffTips();

	return	Lib:StrTrim(szTip, "\n");

end

-- ߼ֵϢڵʱִһ
-- ֵֵֵǼɫ͸ͼ·
function tbEquip:CalcValueInfo()

	-- ֵ
	local nValue = it.nOrgValue;
	local tbSetting = Item:GetExternSetting("value", it.nVersion, 1);

	if (not tbSetting) then

		print("File cấu hình value không tồn tại! Trở về giá trị ban đầu!");

	else

		local tbGenInfo	= it.GetGenInfo(0, 1);
		local tbValue = {};
		local nLevelRate = tbSetting.m_tbEquipLevel[it.nLevel] or 100;
		local nTypeRate  = tbSetting.m_tbEquipTypeRate[it.nDetail] or 100;
		local nEnhValue  = 0;
		local nStrValue  = 0;
		for i = 1, it.nEnhTimes do
			nEnhValue = nEnhValue + (tbSetting.m_tbEnhanceValue[i] or 0);
		end
		if it.nStrengthen > 0 then
			nStrValue = tbSetting.m_tbStrengthenValue[it.nEnhTimes] or 0;
		end

		-- λüȨ
		for i, tbInfo in ipairs(tbGenInfo) do
			local v = KItem.GetMagicValue(tbInfo.szName, tbInfo.nLevel, it.nVersion);
			local nRate = (tbSetting.m_tbEquipRandPos[i] or 100) / 100;
			v = math.floor(v * nRate);
			tbValue[i] = v;
			nValue = nValue + v;
		end

		-- ϼȨ
		for i = 1, #tbGenInfo do
			for j = i, #tbGenInfo do
				local t = tbSetting.m_tbMagicCombine[tbGenInfo[i].szName];
				if t then
					local n = t[tbGenInfo[j].szName];
					if n then
						local nRate = math.sqrt(n) / 10;
						nRate = (nRate - 1) * tbGenInfo[i].nLevel * tbGenInfo[j].nLevel / 400;
						local v = math.floor((tbValue[i] + tbValue[j]) * nRate);
						nValue = nValue + v;
					end
				end
			end
		end

		nValue = math.floor(nValue / 100 * nLevelRate);					-- װȼȨ
		nValue = math.floor(nValue / 100 * nTypeRate);					-- װͼȨ
		nValue = nValue + math.floor(nEnhValue / 100 * nTypeRate);		-- ǿֵӳ
		nValue = nValue + math.floor(nStrValue / 100 * nTypeRate);		-- ֵӳ
	end

	-- װֵǼɫ͸ͼ·
	local nStarLevel, szNameColor, szTransIcon = Item:CalcStarLevelInfo(it.nVersion, it.nDetail, it.nLevel, nValue);
	return	nValue, nStarLevel, szNameColor, szTransIcon;

end

------------------------------------------------------------------------------------------
-- private

function tbEquip:CalcEnhanceAttrib(nState)		-- װǿ/жħֵ

	if (nState ~= Item.TIPS_ENHANCE) then
		return;
	end

	if (it.nDetail < Item.MIN_COMMON_EQUIP) or (it.nDetail > Item.MAX_COMMON_EQUIP) then
		return;
	end

	if (it.nEnhTimes >= Item:CalcMaxEnhanceTimes(it)) then
		return;
	end

	local pTemp = KItem.CreateTempItem(
		it.nGenre,
		it.nDetail,
		it.nParticular,
		it.nLevel,
		it.nSeries,
		it.nEnhTimes + 1,
		it.nLucky,
		it.GetGenInfo(),
		0,
		it.dwRandSeed,
		it.nIndex
	);

	if (not pTemp) then
		return;
	end

	local tbRandMASS = pTemp.GetRandMASS();
	local tbEnhMASS  = pTemp.GetEnhMASS();
	local nStarLevel = pTemp.nStarLevel;
	local nNameColor = pTemp.nNameColor;
	pTemp.Remove();
	return tbRandMASS, tbEnhMASS, nStarLevel, nNameColor;

end

function tbEquip:GetTitle(nState, nEnhNameColor)	-- Tipַ֡ǿ

	local szTip = string.format("<color=0x%x>", it.nNameColor);

	if ((nState == Item.TIPS_PREVIEW) or (nState == Item.TIPS_GOODS)) and (it.nGenre == Item.EQUIP_GENERAL) then
		szTip = szTip..it.szOrgName;	-- װԤ״̬ʱʾ׺
	else
		szTip = szTip..it.szName;
	end

	-- ǿϢ
	if (it.IsWhite() ~= 1) then
		if (it.nEnhTimes <= 0) then
			szTip = szTip.." Chưa cường hóa";
		else
			szTip = szTip.." +"..it.nEnhTimes;
		end
		if (it.nStrengthen > 0) then
			szTip = szTip.." Sửa";
		end
		
		
		if (nState == Item.TIPS_ENHANCE) and nEnhNameColor then		-- װǿԤ
			local nEnhTimes = it.nEnhTimes + 1;
			if (nEnhTimes <= Item:CalcMaxEnhanceTimes(it)) then
				szTip = szTip..string.format(
					" <color=gold>→<color> <color=0x%x>+%d<color>",
					nEnhNameColor,
					nEnhTimes
				);
			end
		elseif nState == Item.TIPS_STRENGTHEN  and Item:CheckStrengthenEquip(it) == 1 then
			szTip = szTip..string.format(
				" <color=gold>→<color> <color=0x%x>+%d sửa<color>",
				it.nNameColor,
				it.nEnhTimes
			);
		end
	end

	return	szTip.."<color>\n";

end

function tbEquip:Tip_Warning()		-- TipַڸװľϢ

	if (it.IsDuped() == 1) then
		return	"<color=red>!! Vật phẩm này là đồ giả, hệ thống sẽ tịch thu!! \nCoi chừng bị lừa, đừng giao dịch<color>\n"
	end

	return	"";

end

function tbEquip:Tip_Durability()

	local bIsAbrade = 0;
	for i = 1, #self.ABRADE_POS do
		if (self.ABRADE_POS[i] == it.nEquipPos) then
			bIsAbrade = 1;
			break;
		end
	end;

	if (bIsAbrade ~= 1) then	-- ﴦĥϵͳװ;Ϣ
		return	"";				-- ʾ;
	end

	-- ĥϵͳװ;Ϣ

	local szTip = "";
	local bColor = 0;

	if (it.nCurDur <= 0) then
		szTip = "<color=red>";
		bColor = 1;
	end
	szTip = szTip.."Độ bền: "..math.ceil(it.nCurDur / 10);
	if bColor == 1 then
		szTip = szTip.."<color>";
	end

	bColor = 0;
	szTip = szTip.." / ";

	if (it.nMaxDur <= Item.DUR_WARNING) then
		szTip = szTip.."<color=red>";
		bColor = 1;
	elseif (it.nMaxDur < Item.DUR_MAX) then
		szTip = szTip.."<color=orange>";
		bColor = 1;
	end
	szTip = szTip..math.ceil(it.nMaxDur / 10);
	if (bColor == 1) then
		szTip = szTip.."<color>";
	end

	return	"\n"..szTip;

end

function tbEquip:Tip_Level()			-- Tipַװ

	return	"\nCấp trang bị: "..it.nLevel.."";

end

function tbEquip:Tip_Series(nState)		-- Tipַ

	local szTip = "   Thuộc tính Ngũ Hành:";
	local nSeries = it.nSeries;

	if (nState == Item.TIPS_PREVIEW) then	-- Ԥ״̬ʱҪñе
		local tbBaseProp = KItem.GetEquipBaseProp(it.nGenre, it.nDetail, it.nParticular, it.nLevel, it.nVersion);
		if (tbBaseProp) then
			nSeries = tbBaseProp.nSeries;
		else
			nSeries = -1;
		end
	end

	local szSeries = Env.SERIES_NAME[nSeries] or "";
	szTip = szTip..szSeries;

	return	szTip;

end

function tbEquip:Tip_ReqAttrib()	-- Tipַ

	local tbAttrib = it.GetReqAttrib();		-- õ

	return	Item:GetRequireDesc(tbAttrib);
end

function tbEquip:Tip_BaseAttrib(nState)	-- Tipַ

	local szTip = "";
	local tbAttrib = it.GetBaseAttrib();	-- õ߻

	if (nState == Item.TIPS_PREVIEW) or (nState == Item.TIPS_GOODS) then	-- Ԥ״̬

		local tbBaseProp = KItem.GetEquipBaseProp(it.nGenre, it.nDetail, it.nParticular, it.nLevel, it.nVersion);
		if tbBaseProp then
			for i, tbMA in ipairs(tbBaseProp.tbBaseAttrib) do
				if (tbBaseProp.nSeries > 0) and (tbMA.szName == "damage_series_resist") then	-- TODO: п⴦
					tbMA.tbRange[3].nMin = tbAttrib[i].tbValue[3];
					tbMA.tbRange[3].nMax = tbAttrib[i].tbValue[3];
				end
				local szTemp = self:GetMagicAttribDescEx(tbMA.szName, self:BuildMARange(tbMA.tbRange));
				if szTemp ~= "" then
					szTip = szTip.."\n"..szTemp;
				end
			end
		end

	else									-- ״̬

		for _, tbMA in ipairs(tbAttrib) do
			local szDesc = self:GetMagicAttribDesc(tbMA.szName, tbMA.tbValue);
			local bInvalid = it.IsInvalid();
			if (szDesc ~= "") then
				if bInvalid == 1 then
					szTip = szTip..string.format("\n<color=gray>%s<color>", szDesc);
				else
					szTip = szTip.."\n"..szDesc;
				end
			end
		end

	end

	if szTip ~= "" then
		return	"\n"..szTip.."";
	end

	return szTip;

end

function tbEquip:Tip_RandAttrib(nState, tbEnhRandMASS)	-- Tipַ

	local szTip = "";
	local nPos1, nPos2 = KItem.GetEquipActive(KItem.EquipType2EquipPos(it.nDetail));
	local tbMASS = it.GetRandMASS();			-- õħ

	if (nState == Item.TIPS_PREVIEW) or (nState == Item.TIPS_GOODS) then	-- Ԥ״̬ʾħԷΧ

		local nSeries = it.nSeries;
		local tbGenInfo = it.GetGenInfo(0, 1);

		if (nState == Item.TIPS_PREVIEW) then	-- Ԥ״̬ȡñе
			local tbBaseProp = KItem.GetEquipBaseProp(it.nGenre, it.nDetail, it.nParticular, it.nLevel, it.nVersion);
			if (tbBaseProp) then
				nSeries = tbBaseProp.nSeries;
			else
				nSeries = -1;					-- вȷ
			end
		end

		if (not nPos1) or (not nPos2) then		-- мװ

			for _, tbMA in ipairs(tbGenInfo) do
				local tbMAInfo = KItem.GetRandAttribInfo(tbMA.szName, tbMA.nLevel, it.nVersion);
				if tbMAInfo then
					szTip = szTip.."\n"..self:GetMagicAttribDescEx(tbMA.szName, self:BuildMARange(tbMAInfo.tbRange));
				end
			end

		else									-- мװ

			for i = 1, #tbGenInfo / 2 do		-- Դ
				local tbMA = tbGenInfo[i];
				local tbMAInfo = KItem.GetRandAttribInfo(tbMA.szName, tbMA.nLevel, it.nVersion);
				if tbMAInfo then
					szTip = szTip.."\n"..self:GetMagicAttribDescEx(tbMA.szName, self:BuildMARange(tbMAInfo));
				end
			end

			local nTotal  = 0;					-- ܼ
			local nActive = 0;					-- ѼԼ
			for i = #tbGenInfo / 2 + 1, #tbGenInfo do	-- Դ
				local tbMA = tbGenInfo[i];
				if tbMA.szName ~= "" then
					nTotal = nTotal + 1;
					if tbMA.bActive == 1 then
						nActive = nActive + 1;
					end
				else
					break;
				end
			end

			if nTotal > 0 then					-- ڰ

				if nSeries < 0 then				-- вȷ

					szTip = szTip..string.format("\n\n<color=blue>Kích hoạt ngũ hành (0/%d)", nTotal);
					szTip = szTip..string.format(
						"<color=gray>%s (?) %s (?) Nhân vật (?) <color>",
						Item.EQUIPPOS_NAME[nPos1],
						Item.EQUIPPOS_NAME[nPos2]
					);		-- ǻҵ
					szTip = szTip.."<color>";

					for i = #tbGenInfo / 2 + 1, #tbGenInfo do
						local tbMA = tbGenInfo[i];
						local tbMAInfo = KItem.GetRandAttribInfo(tbMA.szName, tbMA.nLevel, it.nVersion);
						if tbMAInfo then
							local szDesc = self:GetMagicAttribDescEx(tbMA.szName, self:BuildMARange(tbMAInfo));
							if (szDesc ~= "") and (tbMASS[i].bVisible == 1) then
								szTip = szTip..string.format("\n<color=gray>%s<color>", szDesc);	-- ǻҵ
							end
						end
					end

				else

					local nAccSeries  = KMath.AccruedSeries(it.nSeries);
					local szAccSeries = Env.SERIES_NAME[nAccSeries];
					local pEquip1 = me.GetEquip(nPos1);
					local pEquip2 = me.GetEquip(nPos2);
					local nSeries1 = pEquip1 and pEquip1.nSeries or Env.SERIES_NONE;
					local nSeries2 = pEquip2 and pEquip2.nSeries or Env.SERIES_NONE;

					szTip = szTip..string.format("\n\n<color=blue>Kích hoạt ngũ hành (%d/%d)\n", nActive, nTotal);

					if (nSeries1 ~= nAccSeries) then
						szTip = szTip..string.format("<color=gray>%s (%s)<color> ", Item.EQUIPPOS_NAME[nPos1], szAccSeries);
					else
						szTip = szTip..string.format("<color=white>%s (%s)<color> ", Item.EQUIPPOS_NAME[nPos1], szAccSeries);
					end
					if (nSeries2 ~= nAccSeries) then
						szTip = szTip..string.format("<color=gray>%s (%s)<color> ", Item.EQUIPPOS_NAME[nPos2], szAccSeries);
					else
						szTip = szTip..string.format("<color=white>%s (%s)<color> ", Item.EQUIPPOS_NAME[nPos2], szAccSeries);
					end
					if (me.nSeries ~= nAccSeries) then
						szTip = szTip..string.format("<color=gray>Nhân vật (%s)<color>", szAccSeries);
					else
						szTip = szTip..string.format("<color=white>Nhân vật (%s)<color>", szAccSeries);
					end

					szTip = szTip.."<color>";

					for i = #tbGenInfo / 2 + 1, #tbGenInfo do
						local tbMA = tbGenInfo[i];
						local tbMAInfo = KItem.GetRandAttribInfo(tbMA.szName, tbMA.nLevel, it.nVersion);
						if tbMAInfo then
							local szDesc = self:GetMagicAttribDescEx(tbMA.szName, self:BuildMARange(tbMAInfo));
							if (szDesc ~= "") and (tbMASS[i].bVisible == 1) then
								szTip = szTip..string.format("\n<color=gray>%s<color>", szDesc);	-- ǻҵ
							end
						end
					end

				end

			end

		end

	else										-- ״̬ʾħԾֵ

		if (not nPos1) or (not nPos2) then		-- мװ

			for i = 1, #tbMASS do
				local tbMA = tbMASS[i];
				local szDesc = "";
				if tbEnhRandMASS then
					szDesc = self:GetMagicAttribDescEx2(tbMA.szName, tbMA.tbValue, tbEnhRandMASS[i].tbValue);
				else
					szDesc = self:GetMagicAttribDesc(tbMA.szName, tbMA.tbValue);
				end
				if (szDesc ~= "") and (tbMA.bVisible == 1) then
					if (tbMA.bActive ~= 1) then
						szTip = szTip..string.format("\n<color=gray>%s<color>", szDesc);
					else
						szTip = szTip.."\n"..szDesc;
					end
				end
			end

		else
												-- мװ
			for i = 1, #tbMASS / 2 do			-- Դ
				local tbMA = tbMASS[i];
				local szDesc = "";
				if tbEnhRandMASS then
					szDesc = self:GetMagicAttribDescEx2(tbMA.szName, tbMA.tbValue, tbEnhRandMASS[i].tbValue);
				else
					szDesc = self:GetMagicAttribDesc(tbMA.szName, tbMA.tbValue);
				end
				if (szDesc ~= "") and (tbMA.bVisible == 1) then
					if (tbMA.bActive ~= 1) then
						szTip = szTip..string.format("\n<color=gray>%s<color>", szDesc);
					else
						szTip = szTip.."\n"..szDesc;
					end
				end
			end

			local nTotal  = 0;					-- ܼ
			local nActive = 0;					-- ѼԼ
			for i = #tbMASS / 2 + 1, #tbMASS do	-- Դ
				local tbMA = tbMASS[i];
				if tbMA.szName ~= "" then
					nTotal = nTotal + 1;
					if tbMA.bActive == 1 then
						nActive = nActive + 1;
					end
				else
					break;
				end
			end

			if nTotal > 0 then					-- ڰ
				local nAccSeries  = KMath.AccruedSeries(it.nSeries);
				local szAccSeries = Env.SERIES_NAME[nAccSeries];
				local pEquip1 = me.GetEquip(nPos1);
				local pEquip2 = me.GetEquip(nPos2);
				local nSeries1 = pEquip1 and pEquip1.nSeries or Env.SERIES_NONE;
				local nSeries2 = pEquip2 and pEquip2.nSeries or Env.SERIES_NONE;
				szTip = szTip..string.format("\n\n<color=blue>Kích hoạt ngũ hành (%d/%d)\n", nActive, nTotal);
				if (nSeries1 ~= nAccSeries) then
					szTip = szTip..string.format("<color=gray>%s (%s)<color> ", Item.EQUIPPOS_NAME[nPos1], szAccSeries);
				else
					szTip = szTip..string.format("<color=white>%s (%s)<color> ", Item.EQUIPPOS_NAME[nPos1], szAccSeries);
				end
				if (nSeries2 ~= nAccSeries) then
					szTip = szTip..string.format("<color=gray>%s (%s)<color> ", Item.EQUIPPOS_NAME[nPos2], szAccSeries);
				else
					szTip = szTip..string.format("<color=white>%s (%s)<color> ", Item.EQUIPPOS_NAME[nPos2], szAccSeries);
				end
				if (me.nSeries ~= nAccSeries) then
					szTip = szTip..string.format("<color=gray>Nhân vật (%s)<color>", szAccSeries);
				else
					szTip = szTip..string.format("<color=white>Nhân vật (%s)<color>", szAccSeries);
				end
				szTip = szTip.."<color>";
				for i = #tbMASS / 2 + 1, #tbMASS do
					local tbMA = tbMASS[i];
					local szDesc = "";
					if tbEnhRandMASS then
						szDesc = self:GetMagicAttribDescEx2(tbMA.szName, tbMA.tbValue, tbEnhRandMASS[i].tbValue);
					else
						szDesc = self:GetMagicAttribDesc(tbMA.szName, tbMA.tbValue);
					end
					if (szDesc ~= "") and (tbMA.bVisible == 1) then
						if tbMA.bActive == 1 then
							szTip = szTip..string.format("\n%s", szDesc);
						else
							szTip = szTip..string.format("\n<color=gray>%s<color>", szDesc);
						end
					end
				end
			end

		end

	end
	if szTip ~= "" then
		return	"\n<color=greenyellow>"..szTip.."<color>";
	end
	return szTip;
end

function tbEquip:Tip_EnhAttrib(nState, tbEnhEnhMASS)	-- Tipַǿ

	if (it.IsWhite() == 1) then
		return	"";						-- ɫװʾǿ
	end

	local szTip = "<color=greenyellow>";
	local tbMASS = it.GetEnhMASS();		-- õǿħ

	if (nState == Item.TIPS_PREVIEW) then	-- Ԥ״̬ʾħԷΧ

		local tbBaseProp = KItem.GetEquipBaseProp(it.nGenre, it.nDetail, it.nParticular, it.nLevel, it.nVersion);

		if tbBaseProp then
			local tbEnhMA = tbBaseProp.tbEnhaceMA;
			local nCount = 0;				-- ǿԼ
			for i, tbMA in ipairs(tbEnhMA) do
				if (tbMA.szName ~= "") and (tbMASS[i].bVisible == 1) then
					nCount = nCount + 1;
				end
			end
			if nCount > 0 then				-- ǿ
				szTip = string.format(
					"%s\n<color=blue>Cường hóa (%d/%d)<color>",
					szTip,
					it.nEnhTimes,
					Item:CalcMaxEnhanceTimes(it)
				);
				for i, tbMA in ipairs(tbEnhMA) do
					local szDesc = self:GetMagicAttribDescEx(tbMA.szName, self:BuildMARange(tbMA.tbRange));
					if (szDesc ~= "") and (tbMASS[i].bVisible == 1) then
						if tbMASS[i].bActive ~= 1 then	-- δʾΪɫ
							if nScriptVersion ~= 1 then
								szTip = szTip.."\n<color=gray>"..Lib:StrFillL(string.format("(+ %d)", tbMA.nTimes), 12)..szDesc.."<color>";
							elseif tbMA.nTimes <= Item:CalcMaxEnhanceTimes(it) then
								szTip = szTip.."\n<color=gray>"..Lib:StrFillL(string.format("(+ %d)", tbMA.nTimes), 12)..szDesc.."<color>";
							end
						else
							szTip = szTip.."\n"..Lib:StrFillL(string.format("(+ %d)", tbMA.nTimes), 12)..szDesc;
						end
					end
				end
			end
		end

	else									-- ״̬ʾħԾֵ

		local nCount = 0;					-- ǿԼ

		for _, tbMA in ipairs(tbMASS) do
			if (tbMA.szName ~= "") and (tbMA.bVisible == 1) then
				nCount = nCount + 1;
			end
		end

		if nCount > 0 then					-- ǿ
			szTip = string.format(
				"%s\n<color=blue>Cường hóa (%d/%d)<color>",
				szTip,
				it.nEnhTimes,
				Item:CalcMaxEnhanceTimes(it)
			);
			for i = 1, #tbMASS do
				local tbMA = tbMASS[i];
				local szDesc = self:GetMagicAttribDesc(tbMA.szName, tbMA.tbValue);
				if (szDesc ~= "") and (tbMA.bVisible == 1) then
					if (tbMA.bActive ~= 1) and (tbMA.bVisible == 1) then
						if tbEnhEnhMASS and (tbEnhEnhMASS[i].bActive == 1) then
							szTip = szTip.."\n<color=gold>"..Lib:StrFillL(string.format("(+ %d)", tbMA.nTimes), 12)..szDesc.."<color>";
						else
							if nScriptVersion ~= 1 then
								szTip = szTip.."\n<color=gray>"..Lib:StrFillL(string.format("(+ %d)", tbMA.nTimes), 12)..szDesc.."<color>";
							elseif tbMA.nTimes <= Item:CalcMaxEnhanceTimes(it) then
								szTip = szTip.."\n<color=gray>"..Lib:StrFillL(string.format("(+ %d)", tbMA.nTimes), 12)..szDesc.."<color>";
							end
						end
					else
						szTip = szTip.."\n"..Lib:StrFillL(string.format("(+ %d)", tbMA.nTimes), 12)..szDesc;
					end
				end
			end
		end

	end

	if szTip ~= "" then
		return	"\n<color=greenyellow>"..szTip.."<color>";
	end

	return szTip;

end

-- 
function tbEquip:Tip_StrAttrib(nState)
	if (it.IsWhite() == 1 or it.nEnhTimes < 14 or it.nEnhTimes > 15) then
		return	"";						-- ɫװʾǿ
	end

	local nCount = 0;					-- Լ	
	local szTip = "\n<color=blue>Sửa<color>";
	local tbMASS = it.GetStrMASS();		-- õǿħ
	for i = 1, #tbMASS do
		local tbMA = tbMASS[i];
		local szDesc = self:GetMagicAttribDesc(tbMA.szName, tbMA.tbValue);
		
		if (szDesc ~= "") and (tbMA.bVisible == 1) then
			nCount = nCount + 1;
			--װԤ״̬󣬸TIPɫװǿ
			if nState == Item.TIPS_STRENGTHEN  and Item:CheckStrengthenEquip(it) == 1 then
				local _, _, _, nStrengthenColor = self:CalcEnhanceAttrib(Item.TIPS_ENHANCE);	--װǿʱõɫб
				local szColor = string.format("<color=0x%x>", nStrengthenColor);
				szDesc = "\n"..szColor..Lib:StrFillL(string.format("(Cường hóa +%d sửa)", tbMA.nTimes), 12)..szDesc.."<color>";
			elseif (tbMA.bActive == 1) and (tbMA.bVisible == 1) then
				szDesc = "\n"..Lib:StrFillL(string.format("(Cường hóa +%d sửa)", tbMA.nTimes), 12)..szDesc;
			else
				if nScriptVersion ~= 1 then
					szDesc = "\n<color=gray>"..Lib:StrFillL(string.format("(Cường hóa +%d sửa)", tbMA.nTimes), 12)..szDesc.."<color>";
				elseif tbMA.nTimes <= Item:CalcMaxEnhanceTimes(it) then
					szDesc = "\n<color=gray>"..Lib:StrFillL(string.format("(+ %d )", tbMA.nTimes), 12)..szDesc.."<color>";
				end
			end
		end

		szTip = szTip..szDesc;
	end

	if nCount == 0 then
		return	"";
	else
		return	"\n<color=greenyellow>"..szTip.."<color>";
	end
end

function tbEquip:Tip_Maker()			-- TipַϢ

	if (it.nCustomType == Item.CUSTOM_TYPE_MAKER) and it.szCustomString ~= "" then
		return	"\n<color=orange>"..it.szCustomString.."<color> <color=green>chế tạo<color>";
	end
	if (it.nCustomType == Item.CUSTOM_TYPE_EVENT) and it.szCustomString ~= "" then
		return	"\n<color=orange>"..it.szCustomString.."<color>";
	end

	return "";

end

function tbEquip:Tip_RepairInfo(nState)	-- TipַϢ

	if (nState == Item.TIPS_CREPAIR) then
		local nMoney = Item:CalcCommonRepairPrice(it);
		if (nMoney >= 0) then
			local szMoney = "Miễn phí";
			if (nMoney > 0) then
				szMoney = Item:FormatMoney(nMoney).." lượng";
			end
			return	"\n<color=yellow>޷Phí sửa thường: "..szMoney.."<color>";
		end
	elseif (nState == Item.TIPS_SREPAIR) or (nState == Item.TIPS_IREPAIR) then	-- ״̬ʾϢ
		local nMoney   = Item:CalcSpecialRepairPrice(it);
		local nItemDur = Item:CalcItemRepairPrice(it);
		local szMoney = "Miễn phí";
		if (nMoney > 0) then
			szMoney = Item:FormatMoney(nMoney).." lượng";
		end
		if (nMoney >= 0) and (nItemDur >= 0) then
			return	"\n<color=yellow>޷Phí sửa kỹ: "..szMoney.." (ưu tiên dùng bạc khóa) hoặc"..nItemDur.."Điểm độ bền Kim Tê <color>";
		else
			return	"\n<color=yellow>Không cần sửa thành độ bền lớn nhất<color>";
		end
	end

	return	"";

end

------------------------------------------------------------------------------------------

function tbEquip:GetMagicAttribDesc(szName, tbValue, bActive)
	if szName == "" then
		return	"";
	end
	local s = FightSkill:GetMagicDesc(szName, tbValue, nil, 1);
	return s;
end

function tbEquip:GetMagicAttribDescEx(szName, tbLow, tbHigh)
	if szName == "" then
		return	"";
	end
	local szDesc = FightSkill:GetExtentMagicDesc(szName, tbLow, tbHigh);
	return szDesc;
end

function tbEquip:GetMagicAttribDescEx2(szName, tbBefore, tbAfter)
	if szName == "" then
		return	"";
	end
	local s = FightSkill:GetExtentMagicDesc(szName, tbBefore, tbAfter, 1);
	return s;
end

function tbEquip:BuildMARange(tbRange)
	local tbLow  = {};
	local tbHigh = {};
	for _, tb in ipairs(tbRange) do
		table.insert(tbLow, tb.nMin);
		table.insert(tbHigh, tb.nMax);
	end
	return tbLow, tbHigh;
end

function tbEquip:GetBreakUpStuffTips()
	local szTip = ""
	local nGTPCost, tbStuff, tbExp = Item:CalcBreakUpStuff(it);
	
	if (nGTPCost > 0) and (#tbStuff > 0) then
		szTip = "\n\n<color=orange>".."Tách vật phẩm (mất "..tostring(nGTPCost).. " hoạt lực): <color>\n";
		for _, tbInfo in ipairs(tbStuff) do
			local szName = KItem.GetNameById(tbInfo.nGenre, tbInfo.nDetail, tbInfo.nParticular, tbInfo.nLevel);
			szTip = szTip..string.format("<color=green>%s<color><color=yellow> x %d<color>\n", szName, tbInfo.nCount);
		end
	end
	return szTip;
end

