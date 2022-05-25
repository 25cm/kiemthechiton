
if not MODULE_GAMECLIENT then
	return;
end

Require("\\script\\item\\class\\equip.lua");
Require("\\script\\faction\\customfaction\\factiontoken\\factiontoken_def.lua");
Require("\\script\\faction\\customfaction\\factiontoken\\factiontoken.lua");


Item.tbFactionToken = Item.tbFactionToken or {};
local tbFactionToken = Item.tbFactionToken;
local tbToken = Item:GetClass(tbFactionToken.CLASS_NAME);


tbToken.EFFECT_PATH = "\\image\\effect\\other\\tuceng_jin2.spr";
function tbToken:GetTip(nState, tbEnhRandMASS, tbEnhEnhMASS)
	local szTip = "";
	
	if Item.EQUIPPOS_CHOP ~= it.nEquipPos then
		return szTip;
	end

	szTip = szTip.."<color=white>";
	szTip = szTip..self:Tip_ReqAttrib();
	szTip = szTip..self:Tip_Level();
	szTip = szTip..self:Tip_Series();
	szTip = szTip.."<color>\n";
	szTip = szTip..self:Tip_Mass();
	szTip = szTip..self:Tip_Chop();
	szTip = szTip..self:Tip_Time();
	
	local nSeries = tbFactionToken:GetSeries(it);
	szTip = string.format("%s\n\n<color=pink>%s<color>", szTip, tbFactionToken.TOKEN_TIP[nSeries]);
	
	return	Lib:StrTrim(szTip, "\n");
end

function tbToken:Tip_Series()
	local TIP_SERISE = { "yellow", "green", "blue", "red", "gray"};
	
	local nSeries  = tbFactionToken:GetSeries(it);
	local szSeries = tbFactionToken:GetSeriesStr(it);
	return string.format("  Ngũ hành: %s (<color=%s>Tiến cử hệ %s<color>)", szSeries, TIP_SERISE[nSeries], szSeries);
end

function tbToken:Tip_Mass()
	local tbMass = it.GetTokenMass();
	if not tbMass then
		return "";
	end
	
	local nActive = tbFactionToken:GetActive(it);
	if nActive == 1 then
	end
	
	local szAllActiveColor = nActive == 1 and "greenyellow" or "gray";
	
	local nLevel = tbFactionToken:GetLevel(it);
	local nAttackLevel, nDefenceLevel = tbFactionToken:GetAttackSumLevel(it), tbFactionToken:GetDefenceSumLevel(it);
	local nExtraAttackLevel, nExtraDefenceLevel = tbFactionToken:GetTokenExtraSumLevel(it);
	local szExtraAttackLevel, szExtraDefenceLevel = "", "";
	if nExtraAttackLevel > 0 then
		szExtraAttackLevel = string.format("<color=cyan>+%d<color>", nExtraAttackLevel);
	end
	if nExtraDefenceLevel > 0 then
		szExtraDefenceLevel = string.format("<color=cyan>+%d<color>", nExtraDefenceLevel);
	end
	local nExtraLevel = tbFactionToken:GetRareLandLevel(it);
	local szExtraLevel = "";
	if nExtraLevel > 0 then
		szExtraLevel = string.format("<color=cyan>+%d<color>", nExtraLevel);
	end
	
	local szNormal = string.format("<color=blue>Thuộc tính Tín Vật (%d/%d)<color>\n", nLevel, tbFactionToken.MAX_NORMAL_ATTRIB);
	local szActive = "";
	local szSpe    = string.format("<color=greenyellow>[%s Lv%d %s] [%s Lv%d %s]<color>\n", 
		tbFactionToken.MAGIC_CLASS_NAME[1], nAttackLevel, szExtraAttackLevel, tbFactionToken.MAGIC_CLASS_NAME[2], nDefenceLevel, szExtraDefenceLevel);
	local tbActive = {0, 0, 0, 0, 0, 0};
	
	for i, tbMA in ipairs(tbMass) do
		local szDesc = self:GetMagicAttribDesc(tbMA.szName, tbMA.tbValue);
		if i <= tbFactionToken.MAX_NORMAL_ATTRIB then
			if i <= nLevel then
				local nId, nLv = tbFactionToken:GetAttribInfo(it, i);
				if nId > 0 then
					local szNewDesc = tbFactionToken:GetNewAttribValue(it, nId);
					if szNewDesc then
						szDesc = szNewDesc;
					end
					
					local tbAttrib 		= tbFactionToken:GetAttribSetting(nId);
					szNormal			= string.format("%s<color=%s>[%d%s]%s<color>\n", szNormal, szAllActiveColor, nLv, szExtraLevel, Lib:StrFillL(szDesc, 27));
					tbActive[i]			= nLv + nExtraLevel;
				else
					szNormal			= string.format("%s <color=green>có thể trang bị thuộc tính<color>\n", szNormal);
				end
			end
		elseif i <= tbFactionToken.MAX_NORMAL_ATTRIB + tbFactionToken.MAX_ACTIVE_ATTRIB then
			local nActiveIndex = i - tbFactionToken.MAX_NORMAL_ATTRIB;
			if nActiveIndex == 1 then
				local nActiveCount = 3;
				for j = 1, tbFactionToken.MAX_ACTIVE_ATTRIB do
					for k = j * 2 - 1, j * 2 do
						if tbActive[k] == 0 then
							nActiveCount = nActiveCount - 1;
							break;
						end
					end
				end
				szActive = string.format("<color=blue>Kích hoạt thuộc tính (%d/%d)<color>\n", nActiveCount, tbFactionToken.MAX_ACTIVE_ATTRIB)
			end
			
			local nId 	= tbFactionToken:GetActiveAtrribSetting(nActiveIndex);
			szDesc 		= tbFactionToken:GetNewAttribValue(it, nId);
			
			local nActiveNeed1 = nActiveIndex * 2 - 1;
			local szActiveColor1 = tbActive[nActiveNeed1] > 0 and szAllActiveColor or "gray";
			local nActiveNeed2 = nActiveIndex * 2;
			local szActiveColor2 = tbActive[nActiveNeed2] > 0 and szAllActiveColor or "gray";
			local szActiveColor = (tbActive[nActiveNeed1] > 0 and tbActive[nActiveNeed2] > 0) and szAllActiveColor or "gray";
			local nLevel = tbFactionToken:CalcActiveMagicLevel(tbActive[nActiveNeed1] or 0, tbActive[nActiveNeed2] or 0);
			local szActiveCount = string.format("Ô thuộc tính <color=%s>%d<color>, <color=%s>%d<color>, kích hoạt thuộc tính trang bị: ", 
				szActiveColor1, nActiveNeed1, szActiveColor2, nActiveNeed2);
			if szDesc and szDesc ~= "" then
				szActive = string.format("<color=%s>%s%s\n[%d]%s<color>\n\n", szActiveColor, szActive, szActiveCount, nLevel, Lib:StrFillL(szDesc, 17));
			else
				local tbAttrib 	= tbFactionToken:GetAttribSetting(nId);
				szActive		= string.format("<color=%s>%s%s\n%s<color>\n\n", szActiveColor, szActive, szActiveCount, tbAttrib.szDesc);
			end
		end
	end
	
	if nLevel < tbFactionToken.MAX_NORMAL_ATTRIB then
		szNormal = string.format("%s <color=gray>chưa mở<color>\n", szNormal);
	end
	
	return string.format("\n%s\n%s\n%s", szSpe, szNormal, szActive);
end

function tbToken:Tip_Chop()
	local szTip = "";
		
	local _, _, nLeftTime = me.GetSkillState(tbFactionToken.CHOP_BUFF_ID[1]);
	if nLeftTime and nLeftTime > 0 and self:__IsMyItem(it) == 1 then
		local tbBasePro = tbFactionToken:GetTokenBaseProb(it);
		if tbBasePro then
			szTip = string.format("\n<color=blue>Kích hoạt Quan Ấn<color>\n<color=greenyellow>%s (Lv%d)<color>", tbBasePro.szName, tbFactionToken:GetChopLevel(it));
		end
		szTip = szTip .. string.format("\nKích hoạt Quan Ấn đến: <color=green>%s<color>", os.date("%Y-%m-%d, %H:%M", GetTime() + nLeftTime / Env.GAME_FPS));
	end
	
	return szTip;
end

function tbToken:__IsMyItem(pItem)
	local pOwer = pItem.GetOwner();
	if not pOwer then
		return 0;
	end
	
	if pOwer.nId ~= me.nId then
		return 0;
	end
	
	return 1;
end

function tbToken:Tip_Time()
	local szTip = "";
	
	local nTrasfer = 0;
	if Player:GetTransferStatus(me) == 1 or me.IsTraveller() == 1 then
		nTrasfer = 1;
	end
	
	if self:__IsMyItem(it) == 1 and it.IsTemp() == 0 and nTrasfer == 0 then
		local nActive, szMsg = tbFactionToken:CheckActive(me, it);
		if nActive == 0 then
			szTip = string.format("\n\n<color=red>%s<color>", szMsg);
		else
			nActive = tbFactionToken:GetActive(it);
			if nActive == 0 then
				szTip = string.format("\n\n<color=green>Thoát bản đồ hiện tại hoặc đăng nhập lại kích hoạt Tín Vật<color>");
			elseif pai then
				szTip = string.format("\n\nKích hoạt Tín Vật đến: <color=green>%s<color>", os.date("%Y-%m-%d, %H:%M", pai.GetFactionLandEndTime()));
			end
		end
	end

	return szTip;
end


function tbFactionToken:GetDirectAddAttackMaxValue(pItem)
	local tbMass = pItem.GetTokenMass();
	local nValue = Item.EM_MAX_INPUT_VALUE;
	for i, tbMA in ipairs(tbMass) do
		if i <= tbFactionToken.MAX_NORMAL_ATTRIB then
			local nId, nLv = tbFactionToken:GetAttribInfo(pItem, i);
			if nId == 2 then
				return tbMA.tbValue[1];
			end
		end
	end
	
	return nValue;
end

function tbFactionToken:GetNewAttribValue(pItem, nId)
	local nMagicIndex = self.tbNewAttribIndex[nId];
	if not nMagicIndex or not pItem then
		return;
	end
	
	local nValue = tonumber(pItem.GetTaskBuff(1, nMagicIndex) or 0);
	if nValue <= 0 then
		return;
	end
	
	if nMagicIndex == Item.EAE_DIRECT_APPEND_ATK then
		local nMaxValue = self:GetDirectAddAttackMaxValue(pItem);
		return string.format("Tăng tấn công vũ khí Thần Sa: %d điểm, tối đa %d điểm", math.floor(nValue / 10), math.floor(nMaxValue / 10));
	elseif nMagicIndex == Item.EAE_ATTACK then
		local tbDesc = {"Phổ", "Độc", "Băng", "Hỏa", "Lôi"};
		local nSeries = tbFactionToken:GetSeries(pItem);
		local szPhyType = tbFactionToken:GetPhyTypeStr(pItem);
		return string.format("Tỉ lệ %s công %s công tăng: %d%%", szPhyType, tbDesc[nSeries], nValue);
	elseif nMagicIndex == Item.EAE_RESIST then
		return string.format("Kháng tất cả tăng: %d điểm", nValue);
	elseif nMagicIndex == Item.EAE_LIFE then
		return string.format("Sinh lực tăng: %d điểm", nValue);
	end
	
	return;
end

function tbFactionToken:ExchangeGift_Check(tbGiftSelf, pPickItem, pDropItem, nX, nY, szDefaulMsg, nType)
	local nCount = 0;
	local pItem = tbGiftSelf:First();
	while pItem do
		nCount = nCount + pItem.nCount;
		pItem = tbGiftSelf:Next();
	end
	
	if pDropItem then
		if pDropItem.SzGDPL(",") ~= self.NEED_ITEM_ID_F then
			me.Msg("Vật phẩm đặt vào không đúng!");
			return 0;
		end
	
		nCount = nCount + pDropItem.nCount;
	end
	
	if pPickItem then
		nCount = nCount - pPickItem.nCount;
	end
	
	local szMsg = string.format("%s\nĐổi được: %d %s", szDefaulMsg, nCount * self.EXCHANGE_NUM[nType], self.EXCHANGE_TYPE_DESC[nType]);
	tbGiftSelf:UpdateContent(szMsg);
	
	return 1;
end

function tbFactionToken:GetAttribTips(nId, nLevel, nMagicLevel)
	local szTip = "";
	local tbAttrib = self:GetAttribSetting(nId);
	if not tbAttrib then
		szTip = "Thuộc tính lỗi";
		return szTip;
	end
	
	local tbMA = KItem.GetTokenAttribMass(nId, nMagicLevel);
	if not tbMA then
		return szTip;
	end
	
	local szDesc = self:GetNewAttribValue(self:FindTokenItem(me), nId);
	if not szDesc then
		szDesc = tbToken:GetMagicAttribDesc(tbMA.szName, tbMA.tbValue);
	end
	
	local szClass = "";
	if tbAttrib.nMagicClass <= 2 then
		szClass = string.format("[Loại %s]", self.MAGIC_CLASS_NAME_EX[tbAttrib.nMagicClass]);
	end
	
	szTip = string.format("<color=cyan>[%s] %s Lv%d<color>\n\n<color=greenyellow>%s<color>", tbAttrib.szName, szClass, nLevel, szDesc);
	return szTip;
end

function tbFactionToken:GetBuyAttribTips(pPlayer, nId)
	local szTips = "";
	local tbAttrib = self:GetAttribSetting(nId);
	if not tbAttrib then
		return "";
	end
	
	local tbNeed = self:GetAttribSetting(nId);
	if not tbNeed then
		return "";
	end
	
	szTips = string.format("<color=cyan>[%s]<color> Điều kiện mua:\n", tbAttrib.szName);
	if pPlayer.nLevel < tbNeed.nNeedPlayerLevel then
		szTips = string.format("%s\n<color=red>Nhân vật đạt Lv%d (Chưa)<color>", szTips, tbNeed.nNeedPlayerLevel);
	else
		szTips = string.format("%s\n<color=green>Nhân vật đạt Lv%d<color>", szTips, tbNeed.nNeedPlayerLevel);
	end
	
	local pItem = self:GetTokenItem(pPlayer);
	if self:GetLevel(pItem) < tbNeed.nNeedTokenLevel then
		szTips = string.format("%s\n<color=red>Mở ô thuộc tính %d (Chưa)<color>", szTips, tbNeed.nNeedTokenLevel);
	else
		szTips = string.format("%s\n<color=green>Mở ô thuộc tính %d<color>", szTips, tbNeed.nNeedTokenLevel);
	end
	
	local nNeedItem = self:CalcBuyNeedItem(pPlayer, nId);
	if self:GetNeedItemCount(pPlayer) < nNeedItem then
		szTips = string.format("%s\n<color=red>%d Gỗ Lim (Chưa)<color>", szTips, nNeedItem);
	else
		szTips = string.format("%s\n<color=green>%d Gỗ Lim<color>", szTips, nNeedItem);
	end
	
	return szTips;
end

function tbFactionToken:GetLevelUpAttribTips(pPlayer, nId)
	local szTips = "";
	local tbAttrib = self:GetAttribSetting(nId);
	if not tbAttrib then
		return "";
	end
	
	local nLevel = self:GetPlayerAttribLevel(pPlayer, nId);
	local nNewLevel = nLevel + 1;
	local tbNeed = self.tbRaiseAttribSetting[nNewLevel];
	if not tbNeed then
		return "";
	end
	
	szTips = string.format("<color=cyan>[%s]<color> Điều kiện thăng cấp:\n", tbAttrib.szName);
	if pPlayer.nLevel < tbNeed.nNeedPlayerLevel then
		szTips = string.format("%s\n<color=red>Nhân vật đạt Lv%d (Chưa)<color>", szTips, tbNeed.nNeedPlayerLevel);
	else
		szTips = string.format("%s\n<color=green>Nhân vật đạt Lv%d<color>", szTips, tbNeed.nNeedPlayerLevel);
	end
	
	local tbSetting = self:GetAttribSetting(nId);
	local nMagicClass = tbSetting.nMagicClass;
	local pItem = self:GetTokenItem(pPlayer);
	local nSumLevel = self:GetPlayerMagicLevel(pPlayer, nMagicClass);
	local szClassName = self.MAGIC_CLASS_NAME_EX[nMagicClass];
	if nSumLevel < tbNeed.nNeedSumLevel then
		szTips = string.format("%s\n<color=red>Tổng cấp thuộc tính %s >= %d cấp (Chưa)<color>", szTips, szClassName, tbNeed.nNeedSumLevel);
	else
		szTips = string.format("%s\n<color=green>Tổng cấp thuộc tính %s >= %d cấp<color>", szTips, szClassName, tbNeed.nNeedSumLevel);
	end
	
	local nCheckDiff = 1;
	local nAttCount, nDefCount = self:GetPlayerMagicLevel(pPlayer);
	local nAttCountRaising, nDefCountRaising = self:GetPlayerRaisingMagicLevel(pPlayer);
	nAttCount = nAttCount + nAttCountRaising;
	nDefCount = nDefCount + nDefCountRaising;
	if nMagicClass == self.MAGIC_ATTACK then
		if nAttCount - nDefCount >= self.MAX_LEVEL_DIFF then
			nCheckDiff = 0;
		end
	elseif nMagicClass == self.MAGIC_DEFENCE then
		if nDefCount - nAttCount >= self.MAX_LEVEL_DIFF then
			nCheckDiff = 0;
		end
	end
	
	if nCheckDiff == 0 then
		szTips = string.format("%s\n<color=red>Tấn công và phòng thủ chênh lệch <= 18 cấp (Chưa)<color>", szTips);
	else
		szTips = string.format("%s\n<color=green>Tấn công và phòng thủ chênh lệch <= 18 cấp<color>", szTips);
	end
	
	local nNeedMoney = self:CalcRaiseNeedFactionMoney(pPlayer, nId, nNewLevel);
	if nNeedMoney > 0 then
		if pPlayer.GetCustomFactionMoney() < nNeedMoney then
			szTips = string.format("%s\n<color=red>Bạc Lẻ %d lượng (Chưa)<color>", szTips, nNeedMoney);
		else
			szTips = string.format("%s\n<color=green>Bạc Lẻ %d lượng<color>", szTips, nNeedMoney);
		end
	end
	
	local nNeedContribute = self:CalcRaiseNeedFactionContribute(pPlayer, nId, nNewLevel);
	if nNeedContribute > 0 then
		local cMember = KCustomFaction:GetSelfMember();
		if cMember.GetContribute() < nNeedContribute then
			szTips = string.format("%s\n<color=red>Cống hiến %d (Chưa)<color>", szTips, nNeedContribute);
		else
			szTips = string.format("%s\n<color=green>Cống hiến %d<color>", szTips, nNeedContribute);
		end
	end
	
	local nNeedItem = self:CalcRaiseNeedItem(pPlayer, nId, nNewLevel);
	if self:GetNeedItemCount(pPlayer) < nNeedItem then
		szTips = string.format("%s\n<color=red>%d Gỗ Lim (Chưa)<color>", szTips, nNeedItem);
	else
		szTips = string.format("%s\n<color=green>%d Gỗ Lim<color>", szTips, nNeedItem);
	end
	
	return szTips;
end

function tbFactionToken:GetOpenAttribTips(pPlayer, nIndex)
	local szTips = "";
	local tbNeed = self.tbOpenHoleSetting[nIndex];
	if not tbNeed then
		return "";
	end
	
	if nIndex == 1 then
		return "<color=cyan>[Ô thuộc tính 1]<color>Mặc định mở, hãy trang bị Tín Vật Tông Môn.";
	end
	
	szTips = string.format("<color=cyan>[Ô thuộc tính %d]<color> Điều kiện mở:\n", nIndex);
	
	local pItem = self:GetTokenItem(pPlayer);
	local nNowLevel = self:GetLevel(pItem);
	if nNowLevel ~= nIndex - 1 then
		szTips = string.format("%s\n<color=red>Mở ô thuộc tính %d (Chưa)<color>", szTips, nIndex - 1);
	else
		szTips = string.format("%s\n<color=green>Mở ô thuộc tính %d<color>", szTips, nIndex - 1);
	end
	
	if pPlayer.nLevel < tbNeed.nNeedPlayerLevel then
		szTips = string.format("%s\n<color=red>Nhân vật đạt Lv%d (Chưa)<color>", szTips, tbNeed.nNeedPlayerLevel);
	else
		szTips = string.format("%s\n<color=green>Nhân vật đạt Lv%d<color>", szTips, tbNeed.nNeedPlayerLevel);
	end
	
	if pai.GetBuildingLevel("cangshuge") < tbNeed.nNeedHouseLevel then
		szTips = string.format("%s\n<color=red>Thanh Ngọc Án đạt Lv%d (Chưa)<color>", szTips, tbNeed.nNeedHouseLevel);
	else
		szTips = string.format("%s\n<color=green>Thanh Ngọc Án đạt Lv%d<color>", szTips, tbNeed.nNeedHouseLevel);
	end
	
	if self:GetNeedItemCount(pPlayer) < tbNeed.nNeedItem then
		szTips = string.format("%s\n<color=red>%d Gỗ Lim (Chưa)<color>", szTips, tbNeed.nNeedItem);
	else
		szTips = string.format("%s\n<color=green>%d Gỗ Lim<color>", szTips, tbNeed.nNeedItem);
	end
	
	return szTips;
end
