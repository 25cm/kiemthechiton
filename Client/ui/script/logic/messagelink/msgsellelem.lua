
Require("\\ui\\script\\logic\\messagelist.lua")

local tbMsgList = Ui.tbLogic.tbMessageList;

local tbSellElem = {};

function tbSellElem:Init(tbInfo)
	self.pItem = self:CreateLink(tbInfo[1]);
	if (not self.pItem) then
		return;
	end
	
	self.szText = "<" .. self.pItem.szName .. ">";
	self.szKey	= tbInfo[1][34];
	self.szSellerName 	= tbInfo[1][35];
	self.nOnePrice 		= tonumber(tbInfo[1][36]);
	self.IsSystem		= tbInfo[5];
	 
	Setting:SetGlobalObj(nil, nil, self.pItem);
	local _, _, szItemNameColor = Item:CalcValueInfo(self.pItem.szClass);
	Setting:RestoreGlobalObj();
	
	local nId		= MessageList_PushBtn(self.tbManager.UIGROUP, self.tbManager.szMessageListName, 0, self.szText, szItemNameColor, nil, 0);
	return nId;
end

function tbSellElem:CreateLink(tbParams)
	local tbExtraParams = tbParams;
	for i, szParam in pairs(tbExtraParams) do
		if i < 34 then
			tbExtraParams[i] = tonumber(szParam);
		end
	end
	local tbGenInfo =  { tbExtraParams[15], tbExtraParams[16], tbExtraParams[17], tbExtraParams[18], tbExtraParams[19], tbExtraParams[20], tbExtraParams[21], tbExtraParams[22], tbExtraParams[23], tbExtraParams[24], tbExtraParams[25], tbExtraParams[26] };
	local tbRandomMa = { tbExtraParams[27], tbExtraParams[28], tbExtraParams[29], tbExtraParams[30], tbExtraParams[31], tbExtraParams[32], tbExtraParams[14]};
	
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

function tbSellElem:Clear()
	if (self.pItem) then
		Ui.tbLogic.tbTempItem:Destroy(self.pItem);
	end
end

function tbSellElem:GetShowMsg(tbInfo)
	local pItem = self:CreateLink(tbInfo);
	local szTempText = "<" .. pItem.szName .. ">";
	Ui.tbLogic.tbTempItem:Destroy(pItem);
	
	return szTempText;	
end

function tbSellElem:LeftClick()
	local nPrice = self.nOnePrice;
	local szKey = self.szKey;
	if (not nPrice) or (not szKey) or self.IsSystem == 0 then
		return;
	end

	local tbObj = nil;
	if (self.pItem) then
		tbObj = {};
		tbObj.nType = Ui.OBJ_ITEM;
		tbObj.pItem = self.pItem;
	end
	local tbApplyMsg = {};
	tbApplyMsg.tgObj = tbObj;
	tbApplyMsg.szObjName = self.pItem.szName;
	tbApplyMsg.szMsg = "Ngài xác nhận lấy một ngụm giới:<color=255,167,0>"..Item:FormatMoney(nPrice).."<color>[ hai ] đến mua vật phẩm này?";	
	tbApplyMsg.szTitle = "Cạnh chụp vật phẩm";
	tbApplyMsg.nOptCount = 2;
	tbApplyMsg.bObjEdt = 0;				
	tbApplyMsg.bClose = 0;
	function tbApplyMsg:Callback(nOptIndex, msgWnd, Wnd)
		if (nOptIndex == 2) then
			if me.nCashMoney < Wnd.nOnePrice then
				UiManager:OpenWindow(Ui.UI_INFOBOARD, "Ngươi không đủ  ngân lượng!");
			else
				Wnd:Buy(Wnd.szKey, tonumber(Wnd.nOnePrice));
			end
		end
		if (nOptIndex == 99) then
			Ui.tbLogic.tbTempItem:Destroy(Wnd.pTempItem);
		end
	end
	UiManager:OpenWindow(Ui.UI_MSGBOXWITHOBJ, tbApplyMsg, self);
end

function tbSellElem:Buy(szKey, nOnePrice)
	local tbMsg = {};
	tbMsg.szMsg = "Hay không một ngụm giới mua?";
	tbMsg.nOptCount = 2;
	function tbMsg:Callback(nOptIndex, szKey, nOnePrice)
		if (nOptIndex == 2) then
			KAuction.OnePriceBuyByAdvs(szKey, nOnePrice);
			UiManager:CloseWindow(Ui.UI_MSGBOXWITHOBJ);
		end
	end
	UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg, szKey, nOnePrice);
end

tbMsgList:RegisterBaseClass("sell", tbSellElem);