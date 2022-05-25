local AimCommonHT	= Map.AimCommonHT or {};
Map.AimCommonHT	= AimCommonHT;

-- 通用跑图[补充功能]
local GetTempMap ={
	--城市to新手村
	[23] = 1,
	[24] = 2,
	[25] = 8,
	[26] = 4,
	[27] = 5,
	[28] = 6,
	[29] = 7,
	--挂机点to出口
}
-- 通用1: 跑图
function AimCommonHT:GotoDisMap(nDmapID,nDx,nDy)
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		--进度条，什么也不做
		return 0;
	end
	local nChuanSong = self:GetChuanSong();
	local nHuiCheng = self:GetHuiCheng();
	local nMyMap,nMyX, nMyY = me.GetWorldPos();
	self.nDisMap = nDmapID;
	if (me.nAutoFightState == 1) then	--如果在挂机,先停止。[缺少跑动避怪]
		AutoAi.ProcessHandCommand("auto_fight", 0);
		AutoAi.SetTargetIndex(0);
	end
	if (self.nDisMap == 556 or self.nDisMap == 558 or self.nDisMap == 559) and (nMyMap == 556 or nMyMap == 558 or nMyMap == 559) then
		self.nDisMap=nMyMap;
	end
	if (nChuanSong) or (nMyMap == self.nDisMap) then	--有无限传送，或同图。
		local nMapName = GetMapNameFormId(self.nDisMap)
		local DisPosInfo ={}
		DisPosInfo.szType = "pos"
		DisPosInfo.szLink = nMapName..","..self.nDisMap..","..nDx..","..nDy
		Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,DisPosInfo);
	else
		-- 判断地图[没有无限传送]
		if (nMyMap >= 1 and nMyMap <= 8) and (self.nDisMap == 556 or self.nDisMap == 558 or self.nDisMap == 559) then --在新手村且目标是军营
			self:TalktoNpc("王苍恩",4042,1);
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
				me.Msg("没有传送符也没有回程符，请手工跑图。")
				return;
			end
		end
	end
end
-- 通用2: NPC对话

function AimCommonHT:TalktoNpc(dNpcName,dNpcID,dSayId)
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		if dSayId ~= -1 then	--答案ID不是-1,则用ID回答
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

-- 通用2-3: 对话自动回答
function AimCommonHT:AutoAnswer()
	me.Msg("dsklahlkj")
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
-- 通用3: 背包物品相关
-- 通用3-1:背包"无限回程符"
function AimCommonHT:GetHuiCheng()
	local tbItem	= me.FindItemInBags(18,1,23,1)[1] or me.FindItemInBags(18,1,234,1)[1];
	return (tbItem or {}).pItem;
end
-- 通用3-2:背包"无限传送符"
function AimCommonHT:GetChuanSong()
	local tbItem	= me.FindItemInBags(18,1,195,1)[1] or me.FindItemInBags(18,1,235,1)[1];
	return (tbItem or {}).pItem;
end
-- 通用3-3:背包"红药"
function AimCommonHT:GetHongYao()
local HONG = {
	[1] = {17,1,1,1},--金创药小
	[2] = {17,1,1,2},--金创药中
	[3] = {17,1,1,3},--金创药大
	[4] = {17,1,1,4},--回天丹
	[5] = {17,1,1,5},--九转还魂丹
	[6] = {17,1,1,6},--灵芝续命丸
	[7] = {17,3,1,1},--承仙蜜（小）
	[8] = {17,3,1,2},--承仙蜜（中）
	[9] = {17,3,1,3},--承仙蜜（大）
	[10] = {17,3,1,4},--七巧补心丹
	[11] = {17,3,1,5},--五花玉露丸
	[12] = {17,3,1,6},--瑶池大还丹
	[13] = {17,6,1,1},--回血丹(小)
	[14] = {17,6,1,2},--回血丹(中)
	[15] = {17,6,1,3},--回血丹(大)
	[16] = {17,6,3,1},--乾坤造化丸(小)
	[17] = {17,6,3,2},--乾坤造化丸(中)
	[18] = {17,6,3,3},--乾坤造化丸(大)
	[19] = {17,7,1,1},--领土战回血丹(小)
	[20] = {17,7,1,2},--领土战回血丹(中)
	[21] = {17,7,1,3},--领土战回血丹(大)
	[22] = {17,7,3,1},--领土战乾坤造化丸(小)
	[23] = {17,7,3,2},--领土战乾坤造化丸(中)
	[24] = {17,7,3,3},--领土战乾坤造化丸(大)
	[25] = {17,8,1,1},--逍遥回血丹(小)
	[26] = {17,8,1,2},--逍遥回血丹(中)
	[27] = {17,8,1,3},--逍遥回血丹(大)
	[28] = {17,8,3,1},--逍遥乾坤造化丸(小)
	[29] = {17,8,3,2},--逍遥乾坤造化丸(中)
	[30] = {17,8,3,3},--逍遥乾坤造化丸(大)
};
	for i,tbHONG in pairs(HONG) do
		local tbFind = me.FindItemInBags(unpack(tbHONG));
		for j, tbItem in pairs(tbFind) do
			return tbItem.pItem;
		end
	end
end
-- 通用3-4:背包"蓝药"
function AimCommonHT:GetLanYao()
local LAN = {
	[1] = {17,2,1,1},--凝神丹（小）
	[2] = {17,2,1,2},--凝神丹（中）
	[3] = {17,2,1,3},--凝神丹（大
	[4] = {17,2,1,4},--大补散 大补散
	[5] = {17,2,1,5},--首乌还神丹
	[6] = {17,2,1,6},--雪参返气丸
	[7] = {17,3,1,1},--承仙蜜（小）
	[8] = {17,3,1,2},--承仙蜜（中）
	[9] = {17,3,1,3},--承仙蜜（大）
	[10] = {17,3,1,4},--七巧补心丹
	[11] = {17,3,1,5},--五花玉露丸
	[12] = {17,3,1,6},--瑶池大还丹
	[13] = {17,6,2,1},--回内丹(小)
	[14] = {17,6,2,2},--回内丹(中)
	[15] = {17,6,2,3},--回内丹(大)
	[16] = {17,6,3,1},--乾坤造化丸(小)
	[17] = {17,6,3,2},--乾坤造化丸(中)
	[18] = {17,6,3,3},--乾坤造化丸(大)
	[19] = {17,7,2,1},--领土战回内丹(小)
	[20] = {17,7,2,2},--领土战回内丹(中)
	[21] = {17,7,2,3},--领土战回内丹(大)
	[22] = {17,7,3,1},--领土战乾坤造化丸(小)
	[23] = {17,7,3,2},--领土战乾坤造化丸(中)
	[24] = {17,7,3,3},--领土战乾坤造化丸(大)
	[25] = {17,8,2,1},--逍遥回内丹(小)
	[26] = {17,8,2,2},--逍遥回内丹(中)
	[27] = {17,8,2,3},--逍遥回内丹(大)
	[28] = {17,8,3,1},--逍遥乾坤造化丸(小)
	[29] = {17,8,3,2},--逍遥乾坤造化丸(中)
	[30] = {17,8,3,3},--逍遥乾坤造化丸(大)
};
	for i,tbLAN in pairs(LAN) do
		local tbFind = me.FindItemInBags(unpack(tbLAN));
		for j, tbItem in pairs(tbFind) do
			return tbItem.pItem;
		end
	end
end
-- 通用3-5:背包"兵法书"
function AimCommonHT:GetBFBook()
	local tbItem	= me.FindItemInBags(20,1,298,1)[1] or me.FindItemInBags(20,1,544,1)[1] or me.FindItemInBags(20,1,809,1)[1];
	return (tbItem or {}).pItem;
end
-- 通用3-6:背包"机关书"	
function AimCommonHT:GetJGBook()
	local tbItem	= me.FindItemInBags(20,1,299,1)[1] or me.FindItemInBags(20,1,545,1)[1] or me.FindItemInBags(20,1,810,1)[1];
	return (tbItem or {}).pItem;
end
-- 通用3-7:背包"军饷袋"
function AimCommonHT:GetJunXiangBag()
	local tbItem	= me.FindItemInBags(18,1,193,1)[1] or me.FindItemInBags(18,1,285,1)[1];
	return (tbItem or {}).pItem;
end
--通用3-8:背包"肉"
function AimCommonHT:GetJunMeat()
	local tbItem	= me.FindItemInBags(20,1,488,1)[1] or me.FindItemInBags(20,1,488,2)[1];
	return (tbItem or {}).pItem;
end
--通用3-9:背包"福袋"
function AimCommonHT:GetLuckBag()
	local tbItem	= me.FindItemInBags(18,1,80,1)[1];
	return (tbItem or {}).pItem;
end
--通用3-10:背包"机关零件"
function AimCommonHT:GetJiGuanLJ()
	local tbItem	= me.FindItemInBags(20,1,484,1)[1];
	return (tbItem or {}).pItem;
end
-- 通用4: 关闭面版
-- 通用4-1:关闭SAY
function AimCommonHT:CloseSay()
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
		return 0;
	end
end
-- 通用4-2:关闭其他
function AimCommonHT:fnCPanel()
	if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
		local uiGutAward = Ui(Ui.UI_GUTAWARD)
		uiGutAward.OnButtonClick(uiGutAward,"ObjOptional1")
		uiGutAward.OnButtonClick(uiGutAward,"zBtnAccept")
	end
	UiManager:OnPressESC();
	UiManager:CloseWindow(Ui.UI_SYSTEM);
end

------------------------------End-----------------------------------