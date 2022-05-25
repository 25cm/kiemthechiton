
if MODULE_GC_SERVER then
	return;
end

Require("\\script\\item\\class\\equip.lua");
Require("\\script\\faction\\customfaction\\factiontoken\\factiontoken_def.lua");

Item.tbFactionToken = Item.tbFactionToken or {};
local tbFactionToken = Item.tbFactionToken;

local tbToken = Item:NewClass(tbFactionToken.CLASS_NAME, "equip");
if not tbToken then
	tbToken = Item:GetClass(tbFactionToken.CLASS_NAME);
end


function tbToken:OnUse()
	if me.CanUseItem(it) == 1 then
		me.AutoEquip(it);
	end
	
	return 0;
end

function tbToken:CheckCanEquip()
	return 1;
end

function tbToken:InitItemName()
	local nLevel = tbFactionToken:GetChopLevel(it);
	local nSeries = tbFactionToken:GetSeries(it);
	local szName = string.format("%s-Tín Vật chưởng môn", tbFactionToken.TOKEN_NAME[nSeries] or "Kim Lan Chử");
	if nLevel > 0 and tbFactionToken.CHOP_DESC[nLevel] then
		szName = string.format("%s-%s", szName, tbFactionToken.CHOP_DESC[nLevel]);
	end
	
	return szName;
end

function tbToken:CalcValueInfo()
	local nValue = tbFactionToken:CalcValue(it);
	local nStarLevel, szNameColor, szTransIcon = Item:CalcStarLevelInfo(it.nVersion, it.nDetail, it.nLevel, nValue);
	local nSeries = tbFactionToken:GetSeries(it);
	local szIcon  = tbFactionToken.ICON_PATH[nSeries];
	local szView  = tbFactionToken.VIEW_PATH[nSeries];
	local szMask  = "";
	local tbBasePro = tbFactionToken:GetTokenBaseProb(it);
	if tbBasePro then
		szIcon = tbFactionToken.ICON_PATH_WITH_GUANYIN[nSeries];
		szView = tbFactionToken.VIEW_PATH_WITH_GUANYIN[nSeries];
	end
	
	if szTransIcon == "" then
	end

	return nValue, nStarLevel, szNameColor, szTransIcon, szMask, szIcon, szView;
end


for key, _ in pairs(tbFactionToken.PARAM) do
	local funGet = 
		function (_self, ...)
			return tbFactionToken.GetParam(_self, key, unpack(arg));
		end
		
	rawset(tbFactionToken, "Get"..key, funGet);
end

function tbFactionToken:GetParam(szFun, varItem)
	local pItem = nil;
	if type(varItem) == "number" then
		pItem = KItem.GetObjById(varItem);
	elseif type(varItem) == "userdata" then
		pItem = varItem;
	end
	
	if not pItem then
		return;
	end
	
	if pItem.IsFactionToken() == 0 then
		return;
	end
	
	local tbFunParam = self.PARAM[szFun];
	local nValue = Lib:LoadBits(pItem.GetGenInfo(tbFunParam[1]), tbFunParam[2], tbFunParam[3]);
	return nValue;
end


function tbFactionToken:GetTokenItem(pPlayer)
	local pItem = pPlayer.GetItem(0, Item.EQUIPPOS_CHOP, 0);
	if pItem and pItem.IsFactionToken() == 1 then
		return pItem;
	end
	return;
end

function tbFactionToken:CalcMagicLevel(nLevel, nClassLevel)
	return nLevel * 6 + nClassLevel;
end

function tbFactionToken:CalcActiveMagicLevel(nLevel1, nLevel2)
	return math.floor(math.min(nLevel1, nLevel2) / 5) + 1;
end

function tbFactionToken:Generate(pItem)
	local tbAttrib = {};
	for i = 1, self.MAX_ATTRIB do
		tbAttrib[i] = {0, 0};
	end
	if not pItem or pItem.IsFactionToken() == 0 then
		return tbAttrib;
	end
	
	local nAttackLevel, nDefenceLevel = self:GetAttackSumLevel(pItem), self:GetDefenceSumLevel(pItem);
	local tbMagicClass = {nAttackLevel, nDefenceLevel};
	local tbActive = {0, 0, 0, 0, 0, 0};
	local nExtraLevel = self:GetRareLandLevel(pItem);
	local nExtraAttackLevel, nExtraDefenceLevel = self:GetTokenExtraSumLevel(pItem);
	local tbExtraMagicClass = {nExtraAttackLevel, nExtraDefenceLevel};
	
	for nIndex = 1, self.MAX_NORMAL_ATTRIB do
		local nId, nLevel = self:GetAttribInfo(pItem, nIndex);
		if nId > 0 then
			nLevel				= nLevel + nExtraLevel;
			local tbAt   		= self:GetAttribSetting(nId);
			local nMagicLevel	= self:CalcMagicLevel(nLevel, tbMagicClass[tbAt.nMagicClass] + tbExtraMagicClass[tbAt.nMagicClass]);
			tbAttrib[nIndex] 	= {nId, nMagicLevel};
			tbActive[nIndex]	= nLevel;
		end
	end
	
	for nIndex = 1, self.MAX_ACTIVE_ATTRIB do
		for k = nIndex * 2 - 1, nIndex * 2 do
			if tbActive[k] == 0 then
				break;
			end
			if k == nIndex * 2 then
				local nLevel = self:CalcActiveMagicLevel(tbActive[k - 1], tbActive[k]);
				local nId = self:GetActiveAtrribSetting(nIndex);
				tbAttrib[nIndex + self.MAX_NORMAL_ATTRIB] = {nId, nLevel};
			end
		end
	end
	
	return tbAttrib;
end

function tbFactionToken:GetAttribInfo(pItem, nIndex)
	return self["GetAttribId"..nIndex](self, pItem), self["GetAttribLevel"..nIndex](self, pItem);
end

function tbFactionToken:GetAttribSetting(nId)
	return self.tbAttribSetting[nId];
end

function tbFactionToken:GetActiveAtrribSetting(nIndex)
	return self.tbActiveSetting[nIndex];
end

function tbFactionToken:GetSpeAtrribSetting()
	return self.tbSpeSetting[1];
end

function tbFactionToken:GetPlayerAttribLevel(pPlayer, nId)
	local tbAttrib = self.tbAttribSetting[nId];
	if not tbAttrib or not tbAttrib.nMagicType then
		return;
	end
	
	return pPlayer.GetTask(self.TASK_GROUP, tbAttrib.nMagicType);
end

function tbFactionToken:GetPlayerAttribEndTime(pPlayer, nId)
	local tbAttrib = self.tbAttribSetting[nId];
	if not tbAttrib or not tbAttrib.nMagicType then
		return;
	end
	
	return pPlayer.GetTask(self.TASK_GROUP, tbAttrib.nMagicType + 30);
end

function tbFactionToken:GetAtrribTableByFeature(nPhyType, nSeries, nMagicClass)
	local tbAttribTable = nil;
	if self.tbAttribTable[nPhyType] and self.tbAttribTable[nPhyType][nSeries] then
		tbAttribTable = self.tbAttribTable[nPhyType][nSeries];
	end
	
	if nMagicClass == self.MAGIC_ATTACK or nMagicClass == self.MAGIC_DEFENCE then
		local tbTempAttribTable = Lib:CopyTB1(tbAttribTable);
		local tbRemove = {};
		for nIndex, nId in ipairs(tbTempAttribTable) do
			local tbSetting = self:GetAttribSetting(nId);
			if tbSetting.nMagicClass ~= nMagicClass then
				table.insert(tbRemove, 1, nIndex);
			end
		end
		
		for _, nIndex in ipairs(tbRemove) do
			table.remove(tbTempAttribTable, nIndex);
		end
		return tbTempAttribTable;
	end
	
	return tbAttribTable;
end

function tbFactionToken:GetPhyTypeStr(pItem)
	local nPhyType  = self:GetPhyType(pItem);
	if self:CheckPhyType(nPhyType) == 0 then
		return;
	end
	
	return self.PHY_DESC[nPhyType];
end

function tbFactionToken:GetSeriesStr(pItem)
	local nSeries   = self:GetSeries(pItem);
	local szRet		= "";
	if self:CheckSeries(nSeries) == 0 then
		return;
	end
	
	return Env.SERIES_NAME[nSeries];
end

function tbFactionToken:CalcFightPower(pItem)
	if not pItem or pItem.IsFactionToken() == 0 then
		return 0;
	end
	
	local nFightPower = 0;
	if self:GetActive(pItem) == 1 then
		local nAttackLevel, nDefenceLevel = self:GetAttackSumLevel(pItem), self:GetDefenceSumLevel(pItem);
		local tbMagicClass = {nAttackLevel, nDefenceLevel};
		
		for nIndex = 1, self.MAX_NORMAL_ATTRIB do
			local nId, nLevel = self:GetAttribInfo(pItem, nIndex);
			if nId > 0 then
				local tbAttrib 		= self:GetAttribSetting(nId);
				local nMagicLevel	= self:CalcMagicLevel(nLevel, tbMagicClass[tbAttrib.nMagicClass]);
				nFightPower			= nFightPower + 10 / 360 / 6 * nMagicLevel;
			end
		end
	end
	
	local tbBasePro = self:GetTokenEquipProb(pItem);
	if tbBasePro then
		nFightPower = nFightPower + tbBasePro.nFightPower;
	end
	
	nFightPower = tonumber(string.format("%.2f", nFightPower));
	
	return nFightPower;
end

function tbFactionToken:CalcValue(pItem)
	if not pItem or pItem.IsFactionToken() == 0 then
		return 0;
	end
	
	local nValue = pItem.nOrgValue;
	if self:GetActive(pItem) == 1 then
		local nAttackLevel, nDefenceLevel = self:GetAttackSumLevel(pItem), self:GetDefenceSumLevel(pItem);
		local tbMagicClass = {nAttackLevel, nDefenceLevel};
		
		for nIndex = 1, self.MAX_NORMAL_ATTRIB do
			local nId, nLevel = self:GetAttribInfo(pItem, nIndex);
			if nId > 0 then
				local tbAttrib 		= self:GetAttribSetting(nId);
				local nMagicLevel	= self:CalcMagicLevel(nLevel, tbMagicClass[tbAttrib.nMagicClass]);
				nValue				= nValue + 30000 * nMagicLevel;
			end
		end
	end
	
	local tbBasePro = self:GetTokenEquipProb(pItem);
	if tbBasePro then
		nValue = nValue + tbBasePro.nValue;
	end
	
	return nValue;
end

function tbFactionToken:GetTokenEquipProb(pItem)
	local nP, nL = self:GetChopParticular(pItem), self:GetChopLevel(pItem);
	if nP <= 0 or nL <= 0 then
		return;
	end
	local tbBaseProb = KItem.GetEquipBaseProp(1, 18, nP, nL);
	return tbBaseProb;
end

function tbFactionToken:GetTokenBaseProb(pItem)
	local nP, nL = self:GetChopParticular(pItem), self:GetChopLevel(pItem);
	if nP <= 0 or nL <= 0 then
		return;
	end
	local tbBaseProb = KItem.GetItemBaseProp(1, 18, nP, nL);
	return tbBaseProb;
end

function tbFactionToken:FindTokenItem(pPlayer)
	local pItem = self:GetTokenItem(pPlayer);
	if pItem then
		return pItem;
	end
	
	local tbResult = {};
	local tbFindRoom = {Item.ROOM_EQUIP, Item.ROOM_EQUIPEX, Item.ROOM_EQUIPEX2, Item.ROOM_REPOSITORY_EXT};
	Lib:MergeTable(tbFindRoom, Item.BAG_ROOM);
	Lib:MergeTable(tbFindRoom, Item.REPOSITORY_ROOM);
	for _, nRoom in pairs(tbFindRoom) do
		local tbFind = pPlayer.FindItem(nRoom, unpack(self.ITEM_GDPL));
		if tbFind and #tbFind > 0 then
			for _, tbItem in ipairs(tbFind) do
				tbItem.nRoom = nRoom;
			end
			Lib:MergeTable(tbResult, tbFind);
			break;
		end
	end
	if not tbResult or Lib:CountTB(tbResult) == 0 then
		return;
	end
	
	return tbResult[1].pItem;
end

function tbFactionToken:CalcOpenNeedItem(nIndex)
	local tbSetting = self.tbOpenHoleSetting[nIndex];
	if not tbSetting then
		return;
	end
	
	return tbSetting.nNeedItem;
end

function tbFactionToken:CalcBuyNeedItem(pPlayer, nId)
	local tbSetting = self:GetAttribSetting(nId);
	if not tbSetting then
		return;
	end
	
	local nNeedItem = tbSetting.nNeedItem;
	if self:CheckWeekConsume(pPlayer) == 1 then
		nNeedItem = math.ceil(nNeedItem * self.WEEK_CONSUME_ITEM);
	end
	
	return nNeedItem;
end

function tbFactionToken:CalcRaiseNeedItem(pPlayer, nId, nLevel)
	local tbSetting = self.tbRaiseAttribSetting[nLevel];
	if not tbSetting then
		return;
	end
	
	local nNeedItem = tbSetting.nNeedItem;
	if self.tbNewAttrib[nId] then
		nNeedItem = tbSetting.nNeedItemNew;
	end
	
	if self:CheckWeekConsume(pPlayer) == 1 then
		nNeedItem = math.ceil(nNeedItem * self.WEEK_CONSUME_ITEM);
	end
	
	return nNeedItem;
end

function tbFactionToken:CalcRaiseNeedTime(pPlayer, nId, nLevel)
	local tbSetting = self.tbRaiseAttribSetting[nLevel];
	if not tbSetting then
		return;
	end
	
	local nNeedTime = tbSetting.nNeedTime;
	if self.tbNewAttrib[nId] then
		nNeedTime = tbSetting.nNeedTimeNew;
	end
	
	if self:CheckWeekConsume(pPlayer) == 1 then
		nNeedTime = math.ceil(nNeedTime * self.WEEK_CONSUME_TIME);
	end
	
	return nNeedTime * 3600;
end

function tbFactionToken:CalcRaiseNeedFactionMoney(pPlayer, nId, nLevel)
	local tbSetting = self.tbRaiseAttribSetting[nLevel];
	if not tbSetting then
		return;
	end
	
	local nNeedMoney = tbSetting.nNeedFactionMoney;
	if self.tbNewAttrib[nId] then
		nNeedMoney = tbSetting.nNeedFactionMoneyNew;
	end
	
	if self:CheckWeekConsume(pPlayer) == 1 then
		nNeedMoney = math.ceil(nNeedMoney * self.WEEK_CONSUME_TIME);
	end
	
	return nNeedMoney;
end

function tbFactionToken:CalcRaiseNeedFactionContribute(pPlayer, nId, nLevel)
	local tbSetting = self.tbRaiseAttribSetting[nLevel];
	if not tbSetting then
		return;
	end
	
	local nNeedContribute = tbSetting.nNeedFactionContribute;
	if self.tbNewAttrib[nId] then
		nNeedContribute = tbSetting.nNeedFactionContributeNew;
	end
	if self:CheckWeekConsume(pPlayer) == 1 then
		nNeedContribute = math.ceil(nNeedContribute * self.WEEK_CONSUME_TIME);
	end
	return nNeedContribute;
end

function tbFactionToken:GetTokenExtraSumLevel(pItem)
	local nExtraLevel = self:GetRareLandLevel(pItem);
	local nExtraAttackLevel, nExtraDefenceLevel = 0, 0;
	if nExtraLevel == 0 then
		return nExtraAttackLevel, nExtraDefenceLevel;
	end
	
	for nMagicType, nMagicClass in pairs(self.tbMagicType2MagicClass) do
		if nMagicClass == self.MAGIC_ATTACK then
			nExtraAttackLevel = nExtraAttackLevel + nExtraLevel;
		elseif nMagicClass == self.MAGIC_DEFENCE then
			nExtraDefenceLevel = nExtraDefenceLevel + nExtraLevel;
		end
	end
	
	return nExtraAttackLevel, nExtraDefenceLevel;
end

function tbFactionToken:GetPlayerRaisingMagicLevel(pPlayer)
	local nAttackLevel, nDefenceLevel = 0, 0;
	for nMagicType, nMagicClass in pairs(self.tbMagicType2MagicClass) do
		local nEndTime = pPlayer.GetTask(self.TASK_GROUP, nMagicType + 30);
		if nEndTime > 0 then
			if nMagicClass == self.MAGIC_ATTACK then
				nAttackLevel = nAttackLevel + 1;
			elseif nMagicClass == self.MAGIC_DEFENCE then
				nDefenceLevel = nDefenceLevel + 1;
			end
		end
	end
	
	return nAttackLevel, nDefenceLevel;
end

function tbFactionToken:GetPlayerMagicLevel(pPlayer, nClass)
	local nAttackLevel, nDefenceLevel = 0, 0;
	for nMagicType, nMagicClass in pairs(self.tbMagicType2MagicClass) do
		local nLevel = pPlayer.GetTask(self.TASK_GROUP, nMagicType);
		if nMagicClass == self.MAGIC_ATTACK then
			nAttackLevel = nAttackLevel + nLevel;
		elseif nMagicClass == self.MAGIC_DEFENCE then
			nDefenceLevel = nDefenceLevel + nLevel;
		end
	end
	
	if nClass == self.MAGIC_ATTACK then
		return nAttackLevel;
	elseif nClass == self.MAGIC_DEFENCE then
		return nDefenceLevel;
	end
	
	return nAttackLevel, nDefenceLevel;
end

function tbFactionToken:GetAttribName(nId)
	local tbSetting = self.tbAttribSetting[nId];
	if not tbSetting then
		return;
	end
	
	return tbSetting.szName;
end

function tbFactionToken:GetAttribMagicType(nId)
	local tbSetting = self.tbAttribSetting[nId];
	if not tbSetting then
		return;
	end
	
	return tbSetting.nMagicType;
end

function tbFactionToken:GetRaiseCount(pPlayer)
	local nCount = self.RASE_DAILY_MAX - pPlayer.GetTask(self.TASK_GROUP, self.TASK_RAISE_DAILY_MAX);
	local nCoinCount = pPlayer.GetTask(self.TASK_GROUP, self.TASK_RAISE_COIN);
	return nCount + nCoinCount;
end

function tbFactionToken:CalcBuyRaiseCountPrice(pPlayer)
	local nCount = pPlayer.GetTask(self.TASK_GROUP, self.TASK_DAILY_RAISE);
	return self.RAISE_PRICE[nCount + 1] and self.RAISE_PRICE[nCount + 1] or self.RAISE_PRICE[#self.RAISE_PRICE];
end

function tbFactionToken:CalcSpeedUpCountPrice(pPlayer)
	local nCount = pPlayer.GetTask(self.TASK_GROUP, self.TASK_DAILY_SPEEDUP);
	return self.SPEEDUP_PRICE[nCount + 1] and self.SPEEDUP_PRICE[nCount + 1] or self.SPEEDUP_PRICE[#self.SPEEDUP_PRICE];
end

function tbFactionToken:GetNeedItemCount(pPlayer)
	return pPlayer.GetItemCountInBags(unpack(self.NEED_ITEM_ID)) + pPlayer.GetItemCountInBags(unpack(self.NEED_BIND_ITEM_ID));
end


function tbFactionToken:CheckWeekConsume(pPlayer)
	local nCount = pPlayer.GetTask(self.TASK_GROUP, self.TASK_WEEK_CONSUME);
	if nCount >= self.WEEK_CONSUME_COUNT then
		return 1;
	end
	
	return 0;
end

function tbFactionToken:CheckPhyType(nPhyType)
	if not nPhyType or nPhyType < 1 or nPhyType > 2 then
		return 0;
	end
	
	return 1;
end

function tbFactionToken:CheckSeries(nSeries)
	if not nSeries or nSeries < Env.SERIES_METAL or nSeries > Env.SERIES_EARTH then
		return 0;
	end
	
	return 1;
end

function tbFactionToken:CheckActive(pPlayer, pItem)
	if GLOBAL_AGENT or TRAVEL_AGENT or TRAVEL_DOMAIN or pPlayer.IsTraveller() == 1 then
		return 1;
	end
	
	local cFaction = nil;
	local cMember = nil;
	if MODULE_GAMESERVER then
		cFaction, cMember = pPlayer.GetCustomFactionMember();
	else
		cFaction = pai;
		cMember = KCustomFaction:GetSelfMember();
	end
	
	if not cFaction then
		return 0, "Không có Tông Môn, không thể kích hoạt Tín Vật";
	end
	
	if MODULE_GAMECLIENT then
		if cFaction.GetClientLandType() == 0 then
			return 0, "Không có lãnh địa, không thể kích hoạt Tín Vật";
		end
	else
		if cFaction.GetFactionLandType() == 0 then
			return 0, "Không có lãnh địa, không thể kích hoạt Tín Vật";
		end
	end
	
	if cFaction.GetSeries() == 0 then
		return 0, "Tông Môn chưa chọn ngũ hành, không thể kích hoạt Tín Vật";
	end
	
	if cFaction.GetFactionLandType() == 0 then
		return 0, "Tông Môn chưa chọn nội ngoại công, không thể kích hoạt Tín Vật";
	end
	
	if cFaction.CheckCanGetXinwu() == 0 then
		return 0, "Cấp kiến trúc Tín Vật chưa đạt cấp 1.";
	end
	
	if cMember.nFigure == CustomFaction.FIGURE_SIGNED then
		return 0, "Thành viên ký danh không thể kích hoạt";
	end
	
	return 1;
end

function tbFactionToken:CheckCommon(pPlayer)
	local cFaction = nil;
	if MODULE_GAMECLIENT then
		cFaction = KCustomFaction.GetSelfFaction();
	else
		cFaction = pPlayer.GetCustomFaction();
	end
	
	if not cFaction then
		return 0, "Không có Tông Môn, không thể thao tác.";
	end
	
	if MODULE_GAMECLIENT then
		if cFaction.GetClientLandType() == 0 then
			return 0, "Tông Môn không có lãnh địa, không thể thao tác.";
		end
	else
		if cFaction.GetFactionLandType() == 0 then
			return 0, "Tông Môn không có lãnh địa, không thể thao tác.";
		end
	end
	
	local pItem = self:GetTokenItem(pPlayer);
	if not pItem or pItem.IsFactionToken() == 0 then
		return 0, "Trang bị Tín Vật Tông Môn mới được thao tác.";
	end
	
	
	if self:CheckActive(pPlayer, pItem) == 0 then
		return 0, "Phải kích hoạt Tín Vật mới được thao tác!";
	end
	
	if self:GetActive(pItem) == 0 then
		return 0, "Phải kích hoạt Tín Vật mới được thao tác!";
	end
	
	local nMapId = pPlayer.nMapId;
	local szMapClass = GetMapType(nMapId) or "";
	if szMapClass ~= "city" and szMapClass ~= "village" then
		return 0, "Tại Tân Thủ Thôn hoặc các thành mới được thao tác!";
	end
	
	return 1;
end

function tbFactionToken:CheckOpenAttribHole(pPlayer, nIndex)
	local nRet, szMsg = self:CheckCommon(pPlayer);
	if nRet == 0 then
		return 0, szMsg;
	end
	
	local pItem = self:GetTokenItem(pPlayer);
	local nNowLevel = self:GetLevel(pItem);
	if nNowLevel ~= nIndex - 1 then
		return 0, string.format("Muốn mở ô thuộc tính này, phải mở <color=yellow>ô thuộc tính %d<color>, không đủ điều kiện không thể mở!", nIndex - 1);
	end
	
	if nIndex > self.MAX_NORMAL_ATTRIB then
		return 0, "Chỉ được mở tối đa 6 ô thuộc tính!";
	end
	
	local tbNeed = self.tbOpenHoleSetting[nIndex];
	if not tbNeed then
		return 0, "Tham số bị lỗi!";
	end
	
	if pPlayer.nLevel < tbNeed.nNeedPlayerLevel then
		return 0, string.format("Mở <color=green>ô thuộc tính %d<color> cần nhân vật đạt cấp %d.", nIndex, tbNeed.nNeedPlayerLevel);
	end
	
	local cFaction = pai;
	if not MODULE_GAMECLIENT then
		cFaction = pPlayer.GetCustomFaction();
	end
	
	if not cFaction then
		return 0, "Phái không tồn tại!";
	end
	
	if cFaction.GetBuildingLevel("cangshuge") < tbNeed.nNeedHouseLevel then
		return 0, string.format("Mở <color=green>ô thuộc tính %d<color> cần <color=red>Thanh Ngọc Án cấp %d trở lên<color>, không đủ điều kiện không thể mở.", nIndex, tbNeed.nNeedHouseLevel);
	end
	
	if self:GetNeedItemCount(pPlayer) < tbNeed.nNeedItem then
		return 0, string.format("Mở <color=green>ô thuộc tính %d<color> cần <color=yellow>%d Gỗ Lim<color>, số lượng không đủ không thể mở!", nIndex, tbNeed.nNeedItem);
	end
	
	return 1;
end

function tbFactionToken:CheckSetupAttrib(pPlayer, tbAttrib)
	local nRet, szMsg = self:CheckCommon(pPlayer);
	if nRet == 0 then
		return 0, szMsg;
	end
	
	if #tbAttrib ~= self.MAX_NORMAL_ATTRIB then
		return 0, "Tham số sai";
	end
	
	local pItem = self:GetTokenItem(pPlayer);
	local nLevel = self:GetLevel(pItem);
	local tbMagicType = {};
	for nIndex, nId in ipairs(tbAttrib) do
		if nId > 0 then
			if nLevel < nIndex then
				return 0, "Ô thuộc tính chưa mở!";
			end
			
			local nAtrribLevel = self:GetPlayerAttribLevel(pPlayer, nId);
			if not nAtrribLevel or nAtrribLevel == 0 then
				return 0, "Ô thuộc tính chưa mua!";
			end
			
			local tbAttribSetting = self:GetAttribSetting(nId);
			if tbMagicType[tbAttribSetting.nMagicType] then
				return 0, "Thuộc tính lặp lại!";
			end
			
			tbMagicType[tbAttribSetting.nMagicType] = 1;
		elseif nId < 0 then
			return 0, "Lỗi tham số.";
		end
	end
	return 1;
end

function tbFactionToken:CheckBuyAttribHole(pPlayer, nId)
	local nRet, szMsg = self:CheckCommon(pPlayer);
	if nRet == 0 then
		return 0, szMsg;
	end
	
	local nLevel = self:GetPlayerAttribLevel(pPlayer, nId);
	if not nLevel then
		return 0, "Thuộc tính lỗi";
	end
	
	if nLevel ~= 0 then
		return 0, "Thuộc tính đã được mua!";
	end
	
	local tbNeed = self:GetAttribSetting(nId);
	if not tbNeed then
		return 0, "Tham số bị lỗi!";
	end
	
	if pPlayer.nLevel < tbNeed.nNeedPlayerLevel then
		return 0, string.format("Mua <color=green>%s<color> cần nhân vật đạt cấp %d.", self:GetAttribName(nId), tbNeed.nNeedPlayerLevel);
	end
	
	local pItem = self:GetTokenItem(pPlayer);
	if self:GetLevel(pItem) < tbNeed.nNeedTokenLevel then
		return 0, string.format("Mua <color=green>%s<color> cần mở ô thuộc tính <color=yellow>%d<color>.", self:GetAttribName(nId), tbNeed.nNeedTokenLevel);
	end
	
	local nNeedItem = self:CalcBuyNeedItem(pPlayer, nId);
	if self:GetNeedItemCount(pPlayer) < nNeedItem then
		return 0, string.format("Mua <color=green>%s<color> cần <color=yellow>%d Gỗ Lim<color>, số lượng không đủ để mua!", self:GetAttribName(nId), nNeedItem);
	end
	
	return 1;
end

function tbFactionToken:CheckRaiseAttribHole(pPlayer, nId)
	local nRet, szMsg = self:CheckCommon(pPlayer);
	if nRet == 0 then
		return 0, szMsg;
	end
	
	local nLevel = self:GetPlayerAttribLevel(pPlayer, nId);
	if not nLevel then
		return 0, "Thuộc tính lỗi";
	end
	
	if nLevel == 0 then
		return 0, "Thuộc tính vẫn chưa mua!"..nId;
	end
	
	local nNewLevel = nLevel + 1;
	if nNewLevel < 1 or nNewLevel > self.ATTRIB_MAX_LEVEL then
		return 0, "Cấp không trong phạm vi.";
	end
	
	local nEndTime = self:GetPlayerAttribEndTime(pPlayer, nId);
	if nEndTime > 0 then
		return 0, "Thuộc tính đang thăng cấp.";
	end
	
	local tbNeed = self.tbRaiseAttribSetting[nNewLevel];
	if not tbNeed then
		return 0, "Tham số bị lỗi!";
	end
	
	if pPlayer.nLevel < tbNeed.nNeedPlayerLevel then
		return 0, string.format("Cần nhân vật đạt cấp %d.", tbNeed.nNeedPlayerLevel);
	end
	
	local tbSetting = self:GetAttribSetting(nId);
	local nMagicClass = tbSetting.nMagicClass;
	local pItem = self:GetTokenItem(pPlayer);
	local nSumLevel = self:GetPlayerMagicLevel(pPlayer, nMagicClass);
	if nSumLevel < tbNeed.nNeedSumLevel then
		return 0, string.format("<color=yellow>[%s]<color> tăng đến <color=green>cấp %d<color> cần: tổng cấp <color=cyan>%s loại<color> thuộc tính đạt <color=green>%d trở lên<color>", self:GetAttribName(nId), nNewLevel, self.MAGIC_CLASS_NAME_EX[nMagicClass], tbNeed.nNeedSumLevel);
	end
	
	local nAttCount, nDefCount = self:GetPlayerMagicLevel(pPlayer);
	local nAttCountRaising, nDefCountRaising = self:GetPlayerRaisingMagicLevel(pPlayer);
	nAttCount = nAttCount + nAttCountRaising;
	nDefCount = nDefCount + nDefCountRaising;
	if nMagicClass == self.MAGIC_ATTACK then
		if nAttCount - nDefCount >= self.MAX_LEVEL_DIFF then
			return 0, "Tấn công và phòng thủ cần chênh lệch <=18 cấp<color>";
		end
	elseif nMagicClass == self.MAGIC_DEFENCE then
		if nDefCount - nAttCount >= self.MAX_LEVEL_DIFF then
			return 0, "Tấn công và phòng thủ cần chênh lệch <=18 cấp<color>";
		end
	end
			
	local nNeedMoney = self:CalcRaiseNeedFactionMoney(pPlayer, nId, nNewLevel);
	if pPlayer.GetCustomFactionMoney() < nNeedMoney then
		return 0, string.format("Cần <color=yellow>%d Bạc Lẻ<color>, có thể đến <color=green>Lãnh Địa Tông Môn<color> gặp <color=yellow>Thương Nhân Xây Dựng<color> mua Bạc Lẻ!", nNeedMoney);
	end
	
	local nNeedContribute = self:CalcRaiseNeedFactionContribute(pPlayer, nId, nNewLevel);
	local cFaction = nil;
	local cMember = nil;
	if MODULE_GAMECLIENT then
		cMember = KCustomFaction:GetSelfMember();
	else
		cFaction, cMember = pPlayer.GetCustomFactionMember();
	end
	
	if cMember.GetContribute() < nNeedContribute then
		return 0, string.format("Cần <color=yellow>%d cống hiến<color>, số lượng không đủ để thăng cấp!", nNeedContribute);
	end
	
	local nNeedItem = self:CalcRaiseNeedItem(pPlayer, nId, nNewLevel);
	if self:GetNeedItemCount(pPlayer) < nNeedItem then
		return 0, string.format("Cần <color=yellow>%d Gỗ Lim<color>, số lượng không đủ để thăng cấp!", nNeedItem);
	end
	
	local nRaiseCount = self:GetRaiseCount(pPlayer);
	if nRaiseCount <= 0 then
		return 0, string.format("Mỗi ngày tăng cấp thuộc tính Tín Vật tối đa <color=red>%d lần<color>, có thể <color=green>mua thêm số lần tăng cấp<color> hoặc <color=green>mai hãy đến<color>.", 
			self.RASE_DAILY_MAX);
	end
	
	return 1;
end

function tbFactionToken:CheckAddToken(pPlayer)
	local cFaction, cMember = pPlayer.GetCustomFactionMember();
	if not cFaction or not cMember then
		return 0, "Bạn không có Tông Môn không được nhận Tín Vật!";
	end
	
	if pPlayer.nLevel < self.MIN_LEVEL_LIMIT then
		return 0, string.format("Chưa đạt Lv%d, không được nhận Tín Vật!", self.MIN_LEVEL_LIMIT);
	end
	
	local nPhyType = KGCPlayer.OptGetTask(pPlayer.nId, KGCPlayer.CUSTOMFACTION_PHYSICAL);
	if self:CheckPhyType(nPhyType) == 0 then
		return 0, "Chưa chọn Nội/Ngoại công!";
	end
	
	local nSeries = cFaction.GetSeries();
	if self:CheckSeries(nSeries) == 0 then
		return 0, "Tông Môn của bạn chưa xác định ngũ hành!";
	end
	
	if cFaction.GetFactionLandType() == 0 then
		return 0, "Tông Môn không có lãnh địa, không thể thao tác.";
	end
	
	if cFaction.CheckCanGetXinwu() == 0 then
		return 0, "Cấp kiến trúc Tín Vật chưa đạt cấp 1.";
	end
	
	if cMember.nFigure == CustomFaction.FIGURE_SIGNED then
		return 0, "Thành viên ký danh không thể nhận Tín Vật.";
	end
	
	if cMember.nFigure ~= CustomFaction.FIGURE_CAPTAIN and cMember.GetContribute() < self.GET_TOKEN_CONTRIBUTE then
		return 0, string.format("Đệ tử phải có %d điểm cống hiến mới được nhận Tín Vật Tông Môn!", self.GET_TOKEN_CONTRIBUTE);
	end
	
	if pPlayer.nFaction ~= Env.FACTION_ID_CUSTOM then
		return 0, "Phái hiện tại phải đổi thành Tông Môn tự tạo.";
	end
	
	if pPlayer.GetTask(self.TASK_GROUP, self.TASK_GET_ITEM) ~= 0 then
		return 0, "Bạn đã nhận Tín Vật Tông Môn!";
	end
	
	return 1;
end

function tbFactionToken:CheckNeedItemTrade(pPlayer, pItem)
	if not pPlayer or not pItem then
		return 0;
	end
	
	local cFaction = nil;
	local cMember = nil;
	if MODULE_GAMESERVER then
		cFaction, cMember = pPlayer.GetCustomFactionMember();
	else
		cFaction = pai;
		cMember = KCustomFaction:GetSelfMember();
	end
	
	if not cFaction or not cMember then
		return 0, "Hai bên phải có Tông Môn mới được giao dịch Mảnh!";
	end
	
	if cMember.nFigure == CustomFaction.FIGURE_SIGNED then
		return 0, "Hai bên phải là thành viên chính thức mới được giao dịch Mảnh!";
	end
	
	if cMember.GetContribute() < self.TRADE_NEED_ITEM_CONT then
		return 0, string.format("Cống hiến hai bên phải đạt %d điểm mới được giao dịch Mảnh!", self.TRADE_NEED_ITEM_CONT);
	end
	
	local nFactionId = KLib.Number2UInt(pItem.GetGenInfo(1, 0));
	if nFactionId ~= cFaction.dwId then
		return 0, "Tông Môn của Mảnh không phù hợp Tông Môn hiện tại!";
	end
	
	return 1;
end

function tbFactionToken:CheckTokenItem(pItem)
	if not pItem then
		return 0, 0
	end
	
	local tbGDPL = self.ITEM_GDPL
	if pItem.nGenre ~= tbGDPL[1] or pItem.nDetail ~= tbGDPL[2] or pItem.nParticular ~= tbGDPL[3] then
		return 0, 0
	end
	
	local nP, nL = self:GetChopParticular(pItem), self:GetChopLevel(pItem);
	if nP <= 0 or nL <= 0 then
		return -1, -1
	end

	return nP, nL
end

function tbFactionToken:GetTokenSkill(nSkillId)
	return self.tbSKILL_TO_BUFFER[nSkillId] or 0
end
