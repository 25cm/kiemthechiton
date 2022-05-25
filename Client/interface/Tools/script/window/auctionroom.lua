local tbAuctionRoom = Ui(Ui.UI_AUCTIONROOM)

local ITEM_BAR_STR = "Bar_";
local ITEM_OBJOBJ_STR = "_ObjItem";
local ITEM_NAME_STR = "_TxtItemName";
local ITEM_SELLERNAME_STR = "_TxtSellerName";
local ITEM_SELLERTIME_STR = "_TxtSellerTime";
local ITEM_PRICE_STR = "_TxtPrice";
local ITEM_ONEPRICE_STR = "_TxtOnePrice";
local ITEM_COIN_STR = "_TxtCoin"
local ITEM_STAR_STR = "_TxtStar";
local ITEM_SEND	= "_BtnSend";
local BTN_SHOWPRICE	= "BtnItemPrice";
local BROWSE_ITEMLIST_NAME = "BGList"
local nMoneyType = 0

function tbAuctionRoom:UpdateItemBar(szListName, nItemIdx, szSellName, szSellTime, nPrice, nOnePrice, nItemBarIdx, nCurrency)
	local szBarName	= szListName..ITEM_BAR_STR..nItemBarIdx;
	local objItemObj = szBarName..ITEM_OBJOBJ_STR;	
	local txtItemName = szBarName..ITEM_NAME_STR;
	local txtSellerName = szBarName..ITEM_SELLERNAME_STR;
	local txtSellerTime = szBarName..ITEM_SELLERTIME_STR;
	local txtPrice = szBarName..ITEM_PRICE_STR;
	local txtOnePrice = szBarName..ITEM_ONEPRICE_STR;	
	local txtCoin = szBarName .. ITEM_COIN_STR;	
	local txtStar = szBarName..ITEM_STAR_STR;	
	local btnSend = szBarName..ITEM_SEND;
	local nAvgPrice = nPrice;
	local nAvgOnePrice = nOnePrice;
	local pItem = KItem.GetItemObj(nItemIdx);	
	local tbObj = nil;
	if (pItem) then
		nAvgPrice = math.ceil(nPrice / pItem.nCount);
		nAvgOnePrice = math.ceil(nOnePrice / pItem.nCount);
		tbObj = {};
		tbObj.nType = Ui.OBJ_ITEM;
		tbObj.pItem = pItem;
		Txt_SetTxt(self.UIGROUP, txtStar, (pItem.nStarLevel/2).."Sao" );
		Txt_SetTxt(self.UIGROUP, txtItemName, pItem.szName);			
		self.tbListBarViewGood[szListName][nItemBarIdx]:SetObj(tbObj);
	end
	Txt_SetTxt(self.UIGROUP, txtSellerName, szSellName);
	Wnd_Show(self.UIGROUP, btnSend);
	local hTime = math.floor(szSellTime/60/60);
	if (hTime > 0) then
		Txt_SetTxt(self.UIGROUP, txtSellerTime, "Còn "..hTime.." giờ")
	else
		local mTime = math.floor(szSellTime/60)
		if (mTime > 4) then
			Txt_SetTxt(self.UIGROUP, txtSellerTime, "<color=yellow>Còn "..mTime.." phút<color>")
		else
			local sTime = math.floor(szSellTime)
			if (sTime > 0) then
				Txt_SetTxt(self.UIGROUP, txtSellerTime, "<color=red>Còn "..sTime.." giây<color>")
			end
		end
	end
	
	if (Btn_GetCheck(self.UIGROUP, BTN_SHOWPRICE) == 1 and szListName == BROWSE_ITEMLIST_NAME) then
		if (nMoneyType == 0) then
			if nCurrency and nCurrency == 2 then	-- 表示用金币交易的物品
				Txt_SetTxt(self.UIGROUP, txtCoin,  "Giá: <color=yellow>"..Item:FormatMoney(nAvgOnePrice).." đồng<color>");
				Wnd_SetEnable(self.UIGROUP, btnSend, 0);
			else
				Txt_SetTxt(self.UIGROUP, txtOnePrice, "Đơn giá: <color=orange>"..Item:FormatMoney(nAvgOnePrice).." lượng<color>");
				Txt_SetTxt(self.UIGROUP, txtPrice, "Đơn giá đấu: <color=orange>"..Item:FormatMoney(nAvgPrice).." lượng<color>");
				Wnd_SetEnable(self.UIGROUP, btnSend, 1);
			end
		end
	else
		if (nMoneyType == 0) then
			if nCurrency and nCurrency == 2 then	-- 表示用金币交易的物品
				Txt_SetTxt(self.UIGROUP, txtCoin,  "Giá chót: <color=yellow>"..Item:FormatMoney(nOnePrice).." đồng<color>");
				Wnd_SetEnable(self.UIGROUP, btnSend, 0);
			else
				Txt_SetTxt(self.UIGROUP, txtOnePrice, "Giá chót: <color=orange>"..Item:FormatMoney(nOnePrice).." lượng<color>");
				Txt_SetTxt(self.UIGROUP, txtPrice, "Giá đấu: <color=orange>"..Item:FormatMoney(nPrice).." lượng<color>");
				Wnd_SetEnable(self.UIGROUP, btnSend, 1);
			end
		end
	end
end
