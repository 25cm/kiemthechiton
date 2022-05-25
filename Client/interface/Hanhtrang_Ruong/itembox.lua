local tbItemBox = Ui(Ui.UI_ITEMBOX);
--khai báo nút
local OBJ_MAINBAG			= "ObjMainBag";
local BTN_CLOSE				= "BtnClose";
local BTN_START_SALE		= "BtnStartSale";
local BTN_START_BUY			= "BtnStartBuy";
local BTN_SET_ADV  	 		= "BtnAdvertisement";
local BTN_OPEN_EXTBAG		= "BtnOpenExtBag";
local BTN_ZHEN_LI			= "BtnBeginSortItem";
local BTN_BoHT				= "BtnBoHT";
local BTN_BoTrangBi			= "BtnBoTrangBi";
-- 3 nút này nằm bên hàm khác đã gọi tới hàm nên ko cần xài đến action click
local BTN_SALE_SETTING		= "BtnSaleSetting";
local BTN_BUY_SETTING		= "BtnBuySetting";
local tbBtn2State =
{
    { "BtnSplitItem",		UiManager.UIS_ITEM_SPLIT			},
    { "BtnSaleSetting",		UiManager.UIS_STALL_SETPRICE		},
    { "BtnBuySetting",		UiManager.UIS_OFFER_SETPRICE		},
}

local STATE_USE =
{
	UiManager.UIS_ACTION_GIFT,
	UiManager.UIS_EQUIP_BREAKUP, 
	UiManager.UIS_EQUIP_ENHANCE,
	UiManager.UIS_EQUIP_PEEL,
	UiManager.UIS_EQUIP_COMPOSE,
	UiManager.UIS_EQUIP_UPGRADE,
	UiManager.UIS_EQUIP_REFINE,	
	UiManager.UIS_EQUIP_STRENGTHEN,
	UiManager.UIS_OPEN_REPOSITORY,
};

local tbExtBagBarCont = { nRoom = Item.ROOM_EXTBAGBAR};
local tbMainBagCont = { bSendToGift = 1};

function tbItemBox:OnButtonClick(szWnd, nParam)
	if (szWnd == BTN_SET_ADV) then
		if (me.IsAccountLock() ~= 0) then
			me.Msg("Tài khoản đang khóa, không thể thực hiện thao tác này!");
			return;
		end
		UiManager:OpenWindow(Ui.UI_STALLOFFERADV);
	elseif (szWnd == BTN_START_SALE) then
		if (me.IsAccountLock() ~= 0) then
			me.Msg("Tài khoản đang khóa, không thể thực hiện thao tác này!");
			return;
		end
		if (UiManager:WindowVisible(Ui.UI_MAILVIEW) ~= 0  or UiManager:WindowVisible(Ui.UI_MAIL) ~= 0) then
			me.Msg("Hộp thư đang mở, không thể thực hiện thao tác này!");
			Btn_Check(self.UIGROUP, BTN_START_SALE,	0);
			return;
		end
		if (Stall:ChenckPermit() == 1) then
			self:OnSwitchStallState();
		else
			Btn_Check(self.UIGROUP, BTN_START_SALE, 0);
		end		
	elseif (szWnd == BTN_START_BUY) then
		if (me.IsAccountLock() ~= 0) then
			me.Msg("Tài khoản đang khóa, không thể thực hiện thao tác này!");
			return;
		end
		if (UiManager:WindowVisible(Ui.UI_MAILVIEW) ~= 0  or UiManager:WindowVisible(Ui.UI_MAIL) ~= 0) then
			me.Msg("Hộp thư đang mở, không thể thực hiện thao tác này!");
			
			Btn_Check(self.UIGROUP, BTN_START_BUY,	0);
			return;
		end	
		if (Stall:ChenckPermit() == 1) then
			self:OnSwitchOfferState();
		else
			Btn_Check(self.UIGROUP, BTN_START_BUY, 0);
		end		
	elseif (szWnd == BTN_OPEN_EXTBAG) then
		self:UpdateOpenExtBagState();
	elseif (szWnd == BTN_ZHEN_LI) then 
		Player:ItemSort_SortBag();
	elseif (szWnd == BTN_BoHT) then
		me.Msg("<color=yellow>Bỏ Huyền tinh thấp!");
		AutoAi:SwitchAutoThrowAway(1,0,0);
	elseif (szWnd == BTN_BoTrangBi) then 
		AutoAi:SwitchAutoThrowAway(0,0,1);
		AutoAi:AutoThrowAway2();
	elseif (szWnd == BTN_CLOSE) then
		UiManager:CloseWindow(self.UIGROUP);
	else
		for i = 1, #tbBtn2State do
	        if szWnd == tbBtn2State[i][1] then
	        	if (me.IsAccountLock() ~= 0) then
					me.Msg("Tài khoản đang khóa, không thể thực hiện thao tác này!");
					Btn_Check(self.UIGROUP, szWnd, 0);
					break;
				end
				
				if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
					UiManager:CloseWindow(Ui.UI_SHOP);
				end
	
	            if i == self.nCurState then
	                UiManager:ReleaseUiState(tbBtn2State[i][2]);
	                self.nCurState = 0;
	            else
    	            if tbBtn2State[self.nCurState] then
    	                UiManager:ReleaseUiState(tbBtn2State[self.nCurState][2]);
    	                Btn_Check(self.UIGROUP, tbBtn2State[self.nCurState][1], 0);
    	            end
    	            UiManager:SetUiState(tbBtn2State[i][2]);
    	            self.nCurState = i;
    	        end
    	        Btn_Check(self.UIGROUP, szWnd, self.nCurState);
    	        break;
	        end
	    end
	end
end
--update button bán
function tbItemBox:UpdateStallStateCallback(nFlag)
	Btn_Check(self.UIGROUP, BTN_START_SALE, nFlag);
	if nFlag ~= 1 then
		UiManager:ReleaseUiState(UiManager.UIS_BEGIN_STALL);
		Btn_SetTxt(self.UIGROUP, BTN_START_SALE, "  Bán");
		Wnd_SetEnable(self.UIGROUP, BTN_SALE_SETTING, 1);
		Wnd_SetEnable(self.UIGROUP, BTN_BUY_SETTING, 1);
		Btn_Check(self.UIGROUP, BTN_SALE_SETTING, 0);
		Btn_Check(self.UIGROUP, BTN_BUY_SETTING, 0);
	else
		UiManager:SetUiState(UiManager.UIS_BEGIN_STALL);
		Btn_SetTxt(self.UIGROUP, BTN_START_SALE, "  Dọn");
		Wnd_SetEnable(self.UIGROUP, BTN_SALE_SETTING, 0);
		Wnd_SetEnable(self.UIGROUP, BTN_BUY_SETTING, 0);
	end
end
--update button mua
function tbItemBox:UpdateOfferStateCallback(nFlag)
	Btn_Check(self.UIGROUP, BTN_START_BUY, nFlag);
	if nFlag ~= 1 then
		UiManager:ReleaseUiState(UiManager.UIS_BEGIN_OFFER);
		Btn_SetTxt(self.UIGROUP, BTN_START_BUY, "  Mua");
		Wnd_SetEnable(self.UIGROUP, BTN_SALE_SETTING, 1);
		Wnd_SetEnable(self.UIGROUP, BTN_BUY_SETTING, 1);
		Btn_Check(self.UIGROUP, BTN_SALE_SETTING, 0);
		Btn_Check(self.UIGROUP, BTN_BUY_SETTING, 0);
	else
		UiManager:SetUiState(UiManager.UIS_BEGIN_OFFER);
		Btn_SetTxt(self.UIGROUP, BTN_START_BUY, "  Dừng");
		Wnd_SetEnable(self.UIGROUP, BTN_SALE_SETTING, 0);
		Wnd_SetEnable(self.UIGROUP, BTN_BUY_SETTING, 0);
	end
end