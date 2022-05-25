local AimCommon	= Map.AimCommon or {};
Map.AimCommon	= AimCommon;

local GetTempMap ={
	[23] = 1,
	[24] = 2,
	[25] = 8,
	[26] = 4,
	[27] = 5,
	[28] = 6,
	[29] = 7,
}
function AimCommon:GotoDisMap(nDmapID,nDx,nDy)
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return 0;
	end
	local nChuanSong = self:GetChuanSong();
	local nHuiCheng = self:GetHuiCheng();
	local nMyMap,nMyX, nMyY = me.GetWorldPos();
	self.nDisMap = nDmapID;
	if (me.nAutoFightState == 1) then
		AutoAi.ProcessHandCommand("auto_fight", 0);
		AutoAi.SetTargetIndex(0);
	end
	if (self.nDisMap == 556 or self.nDisMap == 558 or self.nDisMap == 559) and (nMyMap == 556 or nMyMap == 558 or nMyMap == 559) then
		self.nDisMap=nMyMap;
	end
	if (nChuanSong) or (nMyMap == self.nDisMap) then
		local nMapName = GetMapNameFormId(self.nDisMap)
		local DisPosInfo ={}
		DisPosInfo.szType = "pos"
		DisPosInfo.szLink = nMapName..","..self.nDisMap..","..nDx..","..nDy
		Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,DisPosInfo);
	else
		if (nMyMap >= 1 and nMyMap <= 8) and (self.nDisMap == 556 or self.nDisMap == 558 or self.nDisMap == 559) then --在新手村且目标是军营
			self:TalktoNpc("Chiu thua",4042,1);
		elseif (nMyMap >= 23 and nMyMap <= 29) and (self.nDisMap == 556 or self.nDisMap == 558 or self.nDisMap == 559) then --在城市且目标是军营
			local dTMap = GetTempMap[nMyMap];
			local nMapName = GetMapNameFormId(dTMap)
			local DisPosInfo ={}
			DisPosInfo.szType = "pos"
			DisPosInfo.szLink = nMapName..","..dTMap..",1500,3000"
			Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,DisPosInfo);
		else
			if (nHuiCheng) then
				if (nMyMap >= 1 and nMyMap <= 8) or (nMyMap >= 23 and nMyMap <= 29) then
					local nszMapName = GetMapNameFormId(nDmapID)
					local DisPosInfo ={}
					DisPosInfo.szType = "pos"
					DisPosInfo.szLink = nszMapName..","..nDmapID..",1500,3000"
					Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,DisPosInfo);
					return;
				else
					me.UseItem(nHuiCheng);
					return;
				end
			else
				return;
			end
		end
	end
end

function AimCommon:TalktoNpc(dNpcName,dNpcID,dSayId)
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		if dSayId ~= -1 then
			me.AnswerQestion(dSayId-1);
		end
		local function fnDoClose()
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(2, fnDoClose);
	else
		local nMyMap,nMyX, nMyY = me.GetWorldPos();
		local nX1, nY1;
		nX1, nY1 = KNpc.ClientGetNpcPos(nMyMap, dNpcID);
		local tbPosInfo ={}
		tbPosInfo.szType = "pos"
		tbPosInfo.szLink = dNpcName..","..nMyMap..","..nX1..","..nY1
		Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,tbPosInfo);
	end
end

function AimCommon:AutoAnswer()
	if AutoAnswer[1] == 1 then
		me.AnswerQestion(AutoAnswer[2]-1);
		AutoAnswer[1] = 0;
		AutoAnswer[2] = 0;
		local function fnDoClose()
			UiManager:CloseWindow(MySayPanel);
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(1, fnDoClose);
	end
end

function AimCommon:GetHuiCheng()
	local tbItem	= me.FindItemInBags(18,1,23,1)[1] or me.FindItemInBags(18,1,234,1)[1];
	return (tbItem or {}).pItem;
end
function AimCommon:GetChuanSong()
	local tbItem	= me.FindItemInBags(18,1,195,1)[1] or me.FindItemInBags(18,1,235,1)[1];
	return (tbItem or {}).pItem;
end
function AimCommon:GetHongYao()
local HONG = {
	[1] = {17,1,1,1},
	[2] = {17,1,1,2},
	[3] = {17,1,1,3},
	[4] = {17,1,1,4},
	[5] = {17,1,1,5},
	[6] = {17,1,1,6},
	[7] = {17,3,1,1},
	[8] = {17,3,1,2},
	[9] = {17,3,1,3},
	[10] = {17,3,1,4},
	[11] = {17,3,1,5},
	[12] = {17,3,1,6},
	[13] = {17,6,1,1},
	[14] = {17,6,1,2},
	[15] = {17,6,1,3},
	[16] = {17,6,3,1},
	[17] = {17,6,3,2},
	[18] = {17,6,3,3},
	[19] = {17,7,1,1},
	[20] = {17,7,1,2},
	[21] = {17,7,1,3},
	[22] = {17,7,3,1},
	[23] = {17,7,3,2},
	[24] = {17,7,3,3},
	[25] = {17,8,1,1},
	[26] = {17,8,1,2},
	[27] = {17,8,1,3},
	[28] = {17,8,3,1},
	[29] = {17,8,3,2},
	[30] = {17,8,3,3},
};
	for i,tbHONG in pairs(HONG) do
		local tbFind = me.FindItemInBags(unpack(tbHONG));
		for j, tbItem in pairs(tbFind) do
			return tbItem.pItem;
		end
	end
end
function AimCommon:GetLanYao()
local LAN = {
	[1] = {17,2,1,1},
	[2] = {17,2,1,2},
	[3] = {17,2,1,3},
	[4] = {17,2,1,4},
	[5] = {17,2,1,5},
	[6] = {17,2,1,6},
	[7] = {17,3,1,1},
	[8] = {17,3,1,2},
	[9] = {17,3,1,3},
	[10] = {17,3,1,4},
	[11] = {17,3,1,5},
	[12] = {17,3,1,6},
	[13] = {17,6,2,1},
	[14] = {17,6,2,2},
	[15] = {17,6,2,3},
	[16] = {17,6,3,1},
	[17] = {17,6,3,2},
	[18] = {17,6,3,3},
	[19] = {17,7,2,1},
	[20] = {17,7,2,2},
	[21] = {17,7,2,3},
	[22] = {17,7,3,1},
	[23] = {17,7,3,2},
	[24] = {17,7,3,3},
	[25] = {17,8,2,1},
	[26] = {17,8,2,2},
	[27] = {17,8,2,3},
	[28] = {17,8,3,1},
	[29] = {17,8,3,2},
	[30] = {17,8,3,3},
};
	for i,tbLAN in pairs(LAN) do
		local tbFind = me.FindItemInBags(unpack(tbLAN));
		for j, tbItem in pairs(tbFind) do
			return tbItem.pItem;
		end
	end
end
function AimCommon:GetBFBook()
	local tbItem	= me.FindItemInBags(20,1,298,1)[1] or me.FindItemInBags(20,1,544,1)[1] or me.FindItemInBags(20,1,809,1)[1];
	return (tbItem or {}).pItem;
end
function AimCommon:GetJGBook()
	local tbItem	= me.FindItemInBags(20,1,299,1)[1] or me.FindItemInBags(20,1,545,1)[1] or me.FindItemInBags(20,1,810,1)[1];
	return (tbItem or {}).pItem;
end
function AimCommon:GetJunXiangBag()
	local tbItem	= me.FindItemInBags(18,1,193,1)[1] or me.FindItemInBags(18,1,285,1)[1];
	return (tbItem or {}).pItem;
end
function AimCommon:GetJunMeat()
	local tbItem	= me.FindItemInBags(20,1,488,1)[1] or me.FindItemInBags(20,1,488,2)[1];
	return (tbItem or {}).pItem;
end
function AimCommon:GetLuckBag()
	local tbItem	= me.FindItemInBags(18,1,80,1)[1];
	return (tbItem or {}).pItem;
end
function AimCommon:GetJiGuanLJ()
	local tbItem	= me.FindItemInBags(20,1,484,1)[1];
	return (tbItem or {}).pItem;
end

function AimCommon:CloseSay()
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
		return 0;
	end
end
function AimCommon:fnCPanel()
	if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
		local uiGutAward = Ui(Ui.UI_GUTAWARD)
		uiGutAward.OnButtonClick(uiGutAward,"ObjOptional1")
		uiGutAward.OnButtonClick(uiGutAward,"zBtnAccept")
	end
	UiManager:OnPressESC();
	UiManager:CloseWindow(Ui.UI_SYSTEM);
end

------------------------------End-----------------------------------