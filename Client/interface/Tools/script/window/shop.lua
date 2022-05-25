local uiShop 	= Ui(Ui.UI_SHOP);

uiShop.CLOSE_WINDOW_BUTTON	= "BtnClose";
uiShop.NEXT_PAGE_BUTTON		= "BtnNext";
uiShop.PREVIOUS_PAGE_BUTTON	= "BtnPrevious";
uiShop.BUTTON_PAGE_RECYCLE	= "BtnItemToRec"
uiShop.BUTTON_PAGE_BUY		= "BtnItemToBuy"
uiShop.PAGE_NUMBER_TEXT		= "TxtPageNum";
uiShop.OBJ_BUY				= "ObjShop";
uiShop.OBJ_RECYCLE			= "ObjRecycle"
uiShop.BTN_REPAIREX_ALL     = "BtnRepairExAll";
uiShop.BUY_WIDTH 	= 5;
uiShop.BUY_HEIGHT	= 8;

function uiShop:OnButtonClick(szWnd, nParam)
	if szWnd == self.CLOSE_WINDOW_BUTTON then
		UiManager:CloseWindow(self.UIGROUP);
	elseif szWnd == self.NEXT_PAGE_BUTTON then
		self.m_nCurPageNumber = self.m_nCurPageNumber + 1;
		self:UpdateShopItem();
	elseif szWnd == self.PREVIOUS_PAGE_BUTTON then
		self.m_nCurPageNumber = self.m_nCurPageNumber - 1;
		self:UpdateShopItem();
	elseif szWnd == self.BUTTON_PAGE_BUY then
		Wnd_Show(self.UIGROUP, self.OBJ_BUY);
		Wnd_Hide(self.UIGROUP, self.OBJ_RECYCLE);
		Btn_Check(self.UIGROUP, self.BUTTON_PAGE_BUY, 1);
		Btn_Check(self.UIGROUP, self.BUTTON_PAGE_RECYCLE, 0);
		self.m_nCurPageNumber = 0;
		self:UpdateShopItem();
	elseif szWnd == self.BUTTON_PAGE_RECYCLE then
		Wnd_Show(self.UIGROUP, self.OBJ_RECYCLE);
		Wnd_Hide(self.UIGROUP, self.OBJ_BUY);
		Btn_Check(self.UIGROUP, self.BUTTON_PAGE_BUY, 0);
		Btn_Check(self.UIGROUP, self.BUTTON_PAGE_RECYCLE, 1);
		Txt_SetTxt(self.UIGROUP,self.PAGE_NUMBER_TEXT,"1/1");
	elseif szWnd == self.BTN_REPAIREX_ALL then
		Ui(Ui.UI_PLAYERPANEL):RepairExAll();
	else
	    for i = 1, #self.tbBtn2State do
	        if szWnd == self.tbBtn2State[i][1] then
	            if i == self.m_nCurShopState then
	                UiManager:ReleaseUiState(self.tbBtn2State[i][2]);
	                self.m_nCurShopState = 0;
	            else
    	            if self.tbBtn2State[self.m_nCurShopState] then
    	                UiManager:ReleaseUiState(self.tbBtn2State[self.m_nCurShopState][2]);
    	                Btn_Check(self.UIGROUP, self.tbBtn2State[self.m_nCurShopState][1], 0);
    	            end
    	            UiManager:SetUiState(self.tbBtn2State[i][2]);
    	            self.m_nCurShopState = i;
    	            if self.tbBtn2State[i][3] then
    	            	UiManager:OpenWindow(self.tbBtn2State[i][3]);
    	            end
    	        end
    	        Btn_Check(self.UIGROUP, szWnd, self.m_nCurShopState);
    	        break;
	       end
	  end
     end
end
