
Require("\\ui\\script\\logic\\messagelist.lua")

local tbMsgList = Ui.tbLogic.tbMessageList;

local tbEquipElem = {};

function tbEquipElem:Init(tbInfo, szName)
	self.pItem = self:CreateLink(tbInfo[1]);
	if (not self.pItem) then
		return;
	end
	
	self.szText = "<" .. self.pItem.szName .. ">";
	Setting:SetGlobalObj(nil, nil, self.pItem);
	local _, _, szItemNameColor = Item:CalcValueInfo(self.pItem.szClass);
	Setting:RestoreGlobalObj();
	
	local nId		= MessageList_PushBtn(self.tbManager.UIGROUP, self.tbManager.szMessageListName or szName, 0, self.szText, szItemNameColor, nil, 0);
	return nId;
end

function tbEquipElem:GetShowMsg(tbInfo)
	local pItem = self:CreateLink(tbInfo);

	local szTempText = "<" .. pItem.szName .. ">";
	Ui.tbLogic.tbTempItem:Destroy(pItem);

	return szTempText;	
end

function tbEquipElem:CreateLink(tbParams)
	local tbExtraParams = tbParams;
	for i, szParam in pairs(tbExtraParams) do
		tbExtraParams[i] = tonumber(szParam);
	end
	local tbGenInfo =  { tbExtraParams[15], tbExtraParams[16], tbExtraParams[17], tbExtraParams[18], tbExtraParams[19], tbExtraParams[20], tbExtraParams[21], tbExtraParams[22], tbExtraParams[23], tbExtraParams[24], tbExtraParams[25], tbExtraParams[26] };
	local tbRandomMa = { tbExtraParams[27], tbExtraParams[28], tbExtraParams[29], tbExtraParams[30], tbExtraParams[31], tbExtraParams[32], tbExtraParams[14]}; -- 最后一位是绑定与否
	local pItem = Ui.tbLogic.tbTempItem:Create(tbExtraParams[2],
		tbExtraParams[3],
		tbExtraParams[4],
		tbExtraParams[5],
		tbExtraParams[6],
		tbExtraParams[7],
		tbExtraParams[8], 
		tbGenInfo,
		tbExtraParams[9],
		tbExtraParams[10],
		-1,
		0,
		tbExtraParams[11],
		tbExtraParams[12],
		tbExtraParams[13],
		tbRandomMa
	);
	return pItem;
end

function tbEquipElem:Clear()
	if (self.pItem) then
		Ui.tbLogic.tbTempItem:Destroy(self.pItem);
	end
end

function tbEquipElem:LeftClick()
	local pItem = self.pItem;
	local szTitle, szTip, szView, szCmpTitle, szCmpTip, szCmpView = self.pItem.GetCompareTip();
	ShowEquipLink(szTitle, szTip, szView, szCmpTitle, szCmpTip, szCmpView);
end

function tbEquipElem:ShiftLeftClick()
	local pItem = self.pItem;
	UiCallback:LinkPreView(pItem.nGenre, pItem.nDetail, pItem.nParticular, pItem.nLevel, pItem.nSeries);
end

tbMsgList:RegisterBaseClass("item", tbEquipElem);