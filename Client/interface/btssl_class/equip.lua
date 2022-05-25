-- hiện chi tiết giá bán shop , NHHT và chỉ số đồ có thể thay đổi
local tbEquip = Item:GetClass("equip");

function tbEquip:GetTip(nState, tbEnhRandMASS, tbEnhEnhMASS)
	local szTip = "";
	szTip = szTip..self:Tip_ReqAttrib();
	szTip = szTip..self:Tip_Durability();
	szTip = szTip..self:Tip_Level();
	szTip = szTip..self:Tip_Series(nState);
	szTip = szTip.."<color>";
	szTip = szTip..self:Tip_BaseAttrib(nState);
	szTip = szTip..self:Tip_RandAttrib(nState, tbEnhRandMASS);--hiện thêm chỉ số có thể thay đổi
	szTip = szTip..self:Tip_EnhAttrib(nState, tbEnhEnhMASS);
	szTip = szTip..self:Tip_StrAttrib(nState);
	szTip = szTip..self:Tip_Maker();
	szTip = szTip..self:Tip_RepairInfo(nState);
	szTip = szTip..self:GetBreakUpStuffTips();
	szTip = szTip..self:GetChangeStuffTips();	--hiện số NHHT đổi
	szTip = szTip..self:GetSalePriceStuffTips(); --hiện giá bán shop
	return	Lib:StrTrim(szTip, "\n");

end
function tbEquip:Tip_RandAttrib(nState, tbEnhRandMASS)
	local szTip = "";
	local nPos1, nPos2 = KItem.GetEquipActive(KItem.EquipType2EquipPos(it.nDetail));
	local tbMASS = it.GetRandMASS();

	if (nState == Item.TIPS_PREVIEW) or (nState == Item.TIPS_GOODS) then

		local nSeries = it.nSeries;
		local tbGenInfo = it.GetGenInfo(0, 1);

		if (nState == Item.TIPS_PREVIEW) then
			local tbBaseProp = KItem.GetEquipBaseProp(it.nGenre, it.nDetail, it.nParticular, it.nLevel, it.nVersion);
			if (tbBaseProp) then
				nSeries = tbBaseProp.nSeries;
			else
				nSeries = -1;				
			end
		end

		if (not nPos1) or (not nPos2) then	

			for _, tbMA in ipairs(tbGenInfo) do
				local tbMAInfo = KItem.GetRandAttribInfo(tbMA.szName, tbMA.nLevel, it.nVersion);
				if tbMAInfo then
					szTip = szTip.."\n"..self:GetMagicAttribDescEx(tbMA.szName, self:BuildMARange(tbMAInfo.tbRange));
				end
			end

		else								

			for i = 1, #tbGenInfo / 2 do
				local tbMA = tbGenInfo[i];
				local tbMAInfo = KItem.GetRandAttribInfo(tbMA.szName, tbMA.nLevel, it.nVersion);
				if tbMAInfo then
					szTip = szTip.."\n"..self:GetMagicAttribDescEx(tbMA.szName, self:BuildMARange(tbMAInfo));
				end
			end
			local nTotal  = 0;					
			local nActive = 0;					
			for i = #tbGenInfo / 2 + 1, #tbGenInfo do
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
			if nTotal > 0 then	
				if nSeries < 0 then	
					szTip = szTip..string.format("\n\n<color=blue>Kích hoạt ngũ hành (0/%d)", nTotal);
					szTip = szTip..string.format(
						"<color=gray>%s (?) %s (?) Nhân vật (?) <color>",
						Item.EQUIPPOS_NAME[nPos1],
						Item.EQUIPPOS_NAME[nPos2]
					);	
					szTip = szTip.."<color>";
					for i = #tbGenInfo / 2 + 1, #tbGenInfo do
						local tbMA = tbGenInfo[i];
						local tbMAInfo = KItem.GetRandAttribInfo(tbMA.szName, tbMA.nLevel, it.nVersion);
						if tbMAInfo then
							local szDesc = self:GetMagicAttribDescEx(tbMA.szName, self:BuildMARange(tbMAInfo));
							if (szDesc ~= "") and (tbMASS[i].bVisible == 1) then
								szTip = szTip..string.format("\n<color=gray>%s<color>", szDesc);	-- 总是灰的
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
								szTip = szTip..string.format("\n<color=gray>%s<color>", szDesc);
							end
						end
					end
				end
			end
		end
	else
		local tbGenInfo = it.GetGenInfo(0, 1);
		if (not nPos1) or (not nPos2) then
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
		--------------------------
		local tbMAInfo = KItem.GetRandAttribInfo(tbMA.szName, tbGenInfo[i]["nLevel"],it.nVersion);--tbMA.nLevel, it.nVersion);
		local tbMin, tbMax = self:BuildMARange(tbMAInfo);
		szTip = szTip.."  <color=yellow>("..tbMin[1].."-"..tbMax[1]..")<color>";
		---------------------------	
				end
			end
		else
			for i = 1, #tbMASS / 2 do
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
		--------------------------
		local tbMAInfo = KItem.GetRandAttribInfo(tbMA.szName, tbGenInfo[i]["nLevel"],it.nVersion);--tbMA.nLevel, it.nVersion);
		local tbMin, tbMax = self:BuildMARange(tbMAInfo);
		szTip = szTip.."  <color=yellow>("..tbMin[1].."-"..tbMax[1]..")<color>";
		--------------------------
				end
			end
			local nTotal  = 0;
			local nActive = 0;
			for i = #tbMASS / 2 + 1, #tbMASS do	
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
			if nTotal > 0 then
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
		--------------------------
		local tbMAInfo = KItem.GetRandAttribInfo(tbMA.szName, tbGenInfo[i]["nLevel"],it.nVersion);--tbMA.nLevel, it.nVersion);
		local tbMin, tbMax = self:BuildMARange(tbMAInfo);
		szTip = szTip.."  <color=yellow>("..tbMin[1].."-"..tbMax[1]..")<color>";
		---------------------------	
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

function tbEquip:GetChangeStuffTips()
	local szTip = ""
	if it.nMakeCost > 0 and it.IsBind() ~= 1 then
		local nChangeUpNum = math.floor(it.nMakeCost / Item.CHANGE_RATE);
		szTip = szTip..string.format("\n\n<color=green>Đổi tiền trang được  <color><color=yellow>%d<color><color=green>  Ngũ hành hồn thạch<color>\n", nChangeUpNum);
	end
	return szTip;
end

function tbEquip:GetSalePriceStuffTips()
	local szTip = ""
	local	nPrice = GetSalePrice(it);
	if it.IsForbitSell() == 1 then
		szTip = szTip.."\n\n<color=red>Không thể bán<color>";
	else
		szTip = szTip.."\n".."<color=yellow>Bán với giá cửa hàng: "..Item:FormatMoney(nPrice).." lượng<color>";
	end
	return szTip;
end
