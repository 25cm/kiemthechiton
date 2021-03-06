local UiLockAccount = Ui:GetClass("lockaccount");

UiLockAccount.PAGESET_MAIN = "PageSetMain";
UiLockAccount.BTN_CLOSE = "BtnClose";

UiLockAccount.PAGE_CARD = "PageCard";
UiLockAccount.BTN_CARD_PAGE	= "BtnCardPage";
UiLockAccount.BTN_CARD_PROTECT = "BtnCardProtect";
UiLockAccount.BTN_CARD_MISS = "BtnCardMiss";
UiLockAccount.BTN_CARD_DISCHARGE = "BtnCardDischarge";
UiLockAccount.BTN_CARD_CHANGE = "BtnCardChange";
UiLockAccount.BTN_CARD_CANCEL = "BtnCardCancel";
UiLockAccount.TEXTEX_CARD_NOTE = "TxtExCardNote";
UiLockAccount.TEXT_CARD_NUM1 = "TxtCardNum1";
UiLockAccount.TEXT_CARD_NUM2 = "TxtCardNum2";
UiLockAccount.TEXT_CARD_NUM3 = "TxtCardNum3";
UiLockAccount.EDT_CARD_NUM1 = "EdtCardNum1";
UiLockAccount.EDT_CARD_NUM2 = "EdtCardNum2";
UiLockAccount.EDT_CARD_NUM3 = "EdtCardNum3";
UiLockAccount.IMG_CARD_NUM1 = "ImgCardNum1";
UiLockAccount.IMG_CARD_NUM2 = "ImgCardNum2";
UiLockAccount.IMG_CARD_NUM3 = "ImgCardNum3";
UiLockAccount.TEXT_CARD_GUIDE = "TxtCardGuide";

UiLockAccount.PAGE_LINGPAI = "PageLingPai";
UiLockAccount.BTN_LINGPAI_PAGE = "BtnLingPaiPage";
UiLockAccount.BTN_LINGPAI_PROTECT = "BtnLingPaiProtect";
UiLockAccount.BTN_LINGPAI_MISS = "BtnLingPaiMiss";
UiLockAccount.BTN_LINGPAI_DISCHARGE = "BtnLingPaiDischarge";
UiLockAccount.BTN_LINGPAI_CANCEL = "BtnLingPaiCancel";
UiLockAccount.TEXTEX_LINGPAI_NOTE = "TxtExLingPaiNote";
UiLockAccount.TEXTEX_LINGPAI_PSW = "TxtLingPaiPwd";
UiLockAccount.EDT_LINGPAI_PWD = "EdtLingPaiPwd";
UiLockAccount.IMG_LINGPAI_PWD = "ImgLingPaiPwd";
UiLockAccount.TEXT_LINGPAI_GUIDE = "TxtLingPaiGuide";

UiLockAccount.PAGE_ACCOUNT_LOCK = "PageAccountLock";
UiLockAccount.BTN_ACCOUNT_LOCK_PAGE	= "BtnAccountLockPage";
UiLockAccount.BTN_ACCOUNT_LOCK_PROTECT = "BtnAccountLockProtect";
UiLockAccount.BTN_SETPASSWORD = "BtnAccountLockSetPassword";
UiLockAccount.BTN_ACCOUNT_LOCK_DISCHARGE = "BtnAccountLockDischarge";
UiLockAccount.BTN_ACCOUNT_LOCK_CANCEL = "BtnAccountLockCancel";
UiLockAccount.TEXTEX_ACCOUNT_LOCK_NOTE = "TxtExAccountLockNote";
UiLockAccount.TEXTEX_ACCOUNT_LOCK_PSW = "TxtAccountLockPwd";
UiLockAccount.EDT_ACCOUNT_LOCK_PWD = "EdtAccountLockPwd";
UiLockAccount.IMG_ACCOUNT_LOCK_PWD = "ImgAccountLockPwd";
UiLockAccount.TEXT_ACCOUNT_LOCK_GUIDE = "TxtAccountLockGuide";


UiLockAccount.PAGE_MIBAO_LOCK = "PageMibao";
UiLockAccount.BTN_MIBAO_PAGE	= "BtnMibaoPage";
UiLockAccount.BTN_MIBAO_LINK = "BtnMibaoLink";
UiLockAccount.BTN_MIBAO_CANCEL = "BtnMibaoCancel";
UiLockAccount.TEXTEX_MIBAO_NOTE = "TxtExMibaoNote";

UiLockAccount.PAGE_TW_PHONE_LOCK = "PageTWPhoneLock";
UiLockAccount.BTN_TW_PHONE_LOCK_PAGE = "BtnTWPhoneLockPage";
UiLockAccount.BTN_TW_PHONE_LOCK_PROTECT = "BtnTWPhoneLockProtect";
UiLockAccount.BTN_TW_PHONE_LOCK_CANCEL = "BtnTWPhoneLockCancel";
UiLockAccount.TEXTEX_TW_PHONE_LOCK_NOTE = "TxtExTWPhoneLockNote";
UiLockAccount.TEXT_TW_PHONE_LOCK_GUIDE = "TxtTWPhoneLockGuide";

UiLockAccount.FOBBIDEN_NOTE =
    "Nh??n v???t ??ang ??? tr???ng th??i kh??a b???o v???. Tr???ng th??i n??y c???m nh???ng thao t??c nh?? sau:\n"..
    "1. Giao d???ch v???i ng?????i kh??c;              5. S??? d???ng b??? c??u ????a th??;\n"..
    "2. B??y b??n;                    6. B??? v???t ph???m;\n"..
    "3. S??? d???ng K??? Tr??n C??c;              7. K??? n??ng s???ng;\n"..
    "4. S??? d???ng khu giao d???ch ?????ng;          8. C?????ng h??a, th??o v?? gh??p Huy???n Tinh.\n\n"

UiLockAccount.SZ_UNLOCK_NOTE =
    "<color=green>B???n ??ang ??? tr???ng th??i m??? kh??a! Nh??n v???t ????ng nh???p l???n sau s??? t??? ?????ng v??o tr???ng th??i kh??a. Ch??c vui v???!<color>\n"

UiLockAccount.SZ_CARD_NOTE =
    "<color=yellow>B???n ???? m??? ch???c n??ng Th??? m???t m??.<color>\n\n"

UiLockAccount.SZ_CARD_OPERATION_NOTE = "<color=yellow>H??y xem Th??? m???t m??, nh???p v??o nh???ng con s??? t????ng ???ng.<color>"

UiLockAccount.SZ_DISPROTECT_CARD_NOTE = 
    "<color=yellow>B???n ch??a m??? ch???c n??ng Th??? m???t m??.<color>\n\n"..
    "Th??? m???t m?? l?? h??nh ???nh g???m nh???ng con s???, sau khi m??? b???o v???, m???i l???n nh??n v???t ????ng nh???p s??? t??? ?????ng ??? tr???ng th??i kh??a, ch??? c?? th??? giao d???ch hay chuy???n nh?????ng t??i s???n khi nh???p m???t m??. Th??? m???t m?? sau khi t???i xu???ng h??y in ra hay l??u v??o ??i???n tho???i di ?????ng, kh??ng n??n l??u tr??n m??y vi t??nh.\n\n"..
    "<color=yellow>Gi???i thi???u cho t???t c??? ng?????i ch??i s??? d???ng, mi???n ph??, ????n gi???n, t??nh an to??n cao.<color>"

UiLockAccount.SZ_GUIDE_CARD_NOTE =
    "<color=green>Ph????ng ph??p m???:\n"..
    "1. Nh???p \"M??? b???o v???\" ????? v??o trang ch??? Th??? m???t m??;\n"..
    "2. Theo nh???c nh??? trang ch??? nh???n Th??? m???t m?? ?????ng th???i kh??a t??i kho???n tr?? ch??i.<color>"

UiLockAccount.SZ_LINGPAI_NOTE = 
    "<color=yellow>B???n ???? m??? ch???c n??ng L???nh b??i.<color>\n\n"

UiLockAccount.SZ_LINGPAI_OPERATION_NOTE = 
    "<color=yellow>M???i l???n ????ng nh???p nh??n v???t ph???i ?????i 5 ph??t m???i c?? th??? m??? kh??a.<color>"
    
UiLockAccount.SZ_DISPROTECT_LINGPAI_NOTE =     
    "<color=yellow>B???n ch??a m??? ch???c n??ng L???nh b??i.<color>\n\n"..
    "L???nh b??i l?? s???n ph???m b???o v??? t??i kho???n c?? nh??n, v???i c??ch th???c m???i l???n 1 m??, m???i l???nh b??i c?? 1 m?? duy nh???t v?? kh???u l???nh duy nh???t. Sau khi m??? b???o v???, m???i l???n nh??n v???t ????ng nh???p s??? t??? ?????ng ??? tr???ng th??i kh??a, ch??? c?? th??? giao d???ch hay chuy???n nh?????ng t??i s???n khi nh???p m???t m?? thi???t l???p.\n\n"..
    "<color=yellow>Gi???i thi???u cho nh???ng nh??n v???t c?? v???t ph???m qu??, t??nh an to??n r???t cao.<color>"

UiLockAccount.SZ_GUIDE_LINGPAI_NOTE =
    "<color=green>Ph????ng ph??p m???:\n"..
    "1. Nh???p \"M??? b???o v???\" ????? v??o trang ch??? L???nh b??i VNG;\n"..
    "2. T??m hi???u v?? mua L???nh b??i;\n"..
    "3. Kh??a l???nh b??i tr??n trang ch??? L???nh b??i VNG.<color>"

UiLockAccount.SZ_GUIDE_ACCOUNT_LOCK_NOTE =  
    "<color=green>Ph????ng ph??p m???:\n"..
    "1. Nh???p \"M??? b???o v???\", thi???t l???p m???t m?? kh??a an to??n;\n"..
    "2. M???t m?? c?? th??? thay ?????i, n???u b???t c???n qu??n m???t m???t m?? c?? th??? s??? d???ng \"????ng k?? m??? kh??a\" ????? h???y m???t m??.<color>"

UiLockAccount.SZ_ACCOUNT_LOCK_NOTE = 
    "B???n ???? m??? ch???c n??ng kh??a b???o v???. <color=yellow>????? b???o v??? an to??n t??i kho???n, b???n nh???t ?????nh ph???i m??? ch???c n??ng Th??? m???t m?? hay L???nh b??i.<color>\n\n"

UiLockAccount.SZ_ACCOUNT_LOCK_OPERATION_NOTE = "<color=yellow>H??y nh???p m???t m?? m??? kh??a. N???u qu??n c?? th??? nh???p v??o \"????ng k?? m??? kh??a\".<color>"

UiLockAccount.SZ_DISPROTECT_NOTE_ACCOUNT_LOCK = 
    "<color=yellow>B???n ch??a m??? b???t k??? ch???c n??ng b???o v??? t??i kho???n.<color>\n\n"..
    "Kh??a an to??n l?? m???t ch???c n??ng m???t m?? b???o v??? b??n trong tr?? ch??i. Sau khi m??? b???o v???, m???i l???n nh??n v???t ????ng nh???p s??? t??? ?????ng ??? tr???ng th??i kh??a, ch??? c?? th??? giao d???ch hay chuy???n nh?????ng t??i s???n khi nh???p m???t m??.\n\n"..
    "Gi???i thi???u v???i ng?????i ch??i s?? c???p, ????? b???o v??? t??i kho???n, <color=yellow>b???n nh???t ?????nh ph???i m??? ch???c n??ng Th??? m???t m?? hay L???nh b??i.<color>"
    
UiLockAccount.SZ_MIBAO_NOTE =
    "Ph???n m???m m???t m?? l?? ph???n m???m b???o v??? \"Chuy??n d??ng cho Ki???m Th???\".\n\n"..
    "Th??ch h???p cho t???t c??? ng?????i ch??i, sau khi t???i xu???ng c?? th??? b???o v??? m??y vi t??nh tr??nh s??? x??m nh???p c???a hacker.\n\n"..
    "<color=yellow>Nh???p \"Li??n k???t t???i\" ????? v??o trang ch??? t??m hi???u ?????ng th???i t???i xu???ng s??? d???ng.<color>"

UiLockAccount.SZ_CARD_OPEN_URL = "http://ecard.xoyo.com/";
UiLockAccount.SZ_CARD_MISS_URL = "http://ecard.xoyo.com/?t=lost";
UiLockAccount.SZ_CARD_CHANGE_URL = "http://ecard.xoyo.com/?t=change";
UiLockAccount.SZ_CARD_DISCHARGE_URL = "http://ecard.xoyo.com/?t=games";

UiLockAccount.SZ_LINGPAI_OPEN_URL = "http://ekey.xoyo.com/";
UiLockAccount.SZ_LINGPAI_MISS_URL = "http://ekey.xoyo.com/ekeyzp/login.php?type=lost";
UiLockAccount.SZ_LINGPAI_DISCHARGE_URL = "http://ekey.xoyo.com/ekeyzp/login.php?type=setting";

UiLockAccount.SZ_MIBAO_URL = "http://www.duba.net/zt/2009/mibao_jxsj2/";

UiLockAccount.SZ_TW_PHONE_LOCK_NOTE = 
[[
<color=yellow>?????????????????????<color>
<color=green>
?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????? ?????????????????????????????????????????????????????????????????????????????????????????? 
<color>
??????????????? 
????????????????????????????????????0800-771-778 
?????????????????????3717-1615 
]]
UiLockAccount.SZ_TW_PHONE_LOCK_GUIDE = "Tr???ng th??i ????ng tin t???c kh??a";
UiLockAccount.SZ_TW_PHONE_LOCK_HOLDING = "N???i trong 1 ph??t xin g???i tin t???c kh??a c???a t??i kho???n n??y"
UiLockAccount.SZ_TW_PHONE_UNLOCK_GUIDE = "Tr???ng th??i m??? tin t???c kh??a";
UiLockAccount.SZ_NO_TW_PHONE_LOCK_GUIDE = "Ch??a xin ph??p tr???ng th??i kh??a (????i Loan)";

UiLockAccount.nTWPhoneLockTimer = nil;  -- ??????????????????????????????

function UiLockAccount:Init()
	self.bProtected = 1;	-- ????????????
	self.bAccountLock = 1;	-- ?????????
	self.bSafeKey = 1; 		-- ??????
	self.bSafeCard = 1;		-- ?????????
	self.bTWPhoneLock = 1;  -- ???????????????
	self.nPwd = 1;
	self.nPos = 100000;
	self:UpdatePwdShow();
end

function UiLockAccount:OnOpen()
	if (0 == UiManager:CheckLockAccountState()) then
		self.SZ_DISPROTECT_NOTE_ACCOUNT_LOCK = 
[[<color=yellow>B???n ch??a m??? ch???c n??ng b???o v??? t??i kho???n.<color>

Kh??a an to??n l?? ch???c n??ng m???t m?? b???o v??? trong tr?? ch??i. Sau khi m??? b???o v???, m???i l???n nh??n v???t ????ng nh???p s??? t??? ?????ng v??o tr???ng th??i kh??a, sau khi nh???p m???t m?? m???i ???????c ti???n h??nh thao t??c di chuy???n t??i s???n giao d???ch.
]];

		self.SZ_ACCOUNT_LOCK_NOTE = [[B???n ???? m??? ch???c n??ng kh??a b???o v??? an to??n.

]];
	end

	Txt_SetTxt(self.UIGROUP, self.TEXT_CARD_GUIDE, self.SZ_GUIDE_CARD_NOTE);
	Txt_SetTxt(self.UIGROUP, self.TEXT_LINGPAI_GUIDE, self.SZ_GUIDE_LINGPAI_NOTE);
	Txt_SetTxt(self.UIGROUP, self.TEXT_ACCOUNT_LOCK_GUIDE, self.SZ_GUIDE_ACCOUNT_LOCK_NOTE);
	self:ShowLingPaiPswLogin(0);
	self:ShowCardPswLogin(0);
	self:ShowAccountLockPswLogin(0);
	
 	self:UpdateProtect();
	if (1 == UiManager:CheckLockAccountState()) then
		Wnd_SetVisible(self.UIGROUP, self.BTN_LINGPAI_PAGE, 1);
		Wnd_SetVisible(self.UIGROUP, self.BTN_CARD_PAGE, 1);
		Wnd_SetVisible(self.UIGROUP, self.BTN_MIBAO_PAGE, 1);
	  

		if self.bSafeKey == 1 then
			PgSet_ActivePage(self.UIGROUP, self.PAGESET_MAIN, self.PAGE_LINGPAI);
			Wnd_SetEnable(self.UIGROUP, self.BTN_CARD_PAGE, 0);
			Wnd_SetEnable(self.UIGROUP, self.BTN_ACCOUNT_LOCK_PAGE, 0);
		elseif self.bSafeCard == 1 then
			PgSet_ActivePage(self.UIGROUP, self.PAGESET_MAIN, self.PAGE_CARD);
			Wnd_SetEnable(self.UIGROUP, self.BTN_LINGPAI_PAGE, 0);
			Wnd_SetEnable(self.UIGROUP, self.BTN_ACCOUNT_LOCK_PAGE, 0);
		elseif self.bAccountLock == 1 then
			PgSet_ActivePage(self.UIGROUP, self.PAGESET_MAIN, self.PAGE_ACCOUNT_LOCK);
		else
			PgSet_ActivePage(self.UIGROUP, self.PAGESET_MAIN, self.PAGE_CARD);
		end

	else
		Wnd_SetVisible(self.UIGROUP, self.BTN_LINGPAI_PAGE, 0);
		Wnd_SetVisible(self.UIGROUP, self.BTN_CARD_PAGE, 0);
		Wnd_SetVisible(self.UIGROUP, self.BTN_MIBAO_PAGE, 0);
		PgSet_ActivePage(self.UIGROUP, self.PAGESET_MAIN, self.PAGE_ACCOUNT_LOCK);
	end
	
	if self.bTWPhoneLock == 1 then
		Wnd_SetVisible(self.UIGROUP, self.BTN_TW_PHONE_LOCK_PAGE, 1);
		Wnd_SetVisible(self.UIGROUP, self.BTN_LINGPAI_PAGE, 0);
		Wnd_SetVisible(self.UIGROUP, self.BTN_CARD_PAGE, 0);
		Wnd_SetVisible(self.UIGROUP, self.BTN_CARD_PAGE, 0);
		Wnd_SetVisible(self.UIGROUP, self.BTN_ACCOUNT_LOCK_PAGE, 0);
		PgSet_ActivePage(self.UIGROUP, self.PAGESET_MAIN, self.PAGE_TW_PHONE_LOCK);
	else
		Wnd_SetVisible(self.UIGROUP, self.BTN_TW_PHONE_LOCK_PAGE, 0);
	end

	if Player.bApplyingJiesuo == 1 then
		Btn_SetTxt(self.UIGROUP, self.BTN_ACCOUNT_LOCK_DISCHARGE, "H???y m??? kh??a");
	else
		Btn_SetTxt(self.UIGROUP, self.BTN_ACCOUNT_LOCK_DISCHARGE, "Xin m??? kh??a");
	end
end

function UiLockAccount:OnButtonClick(szWndName, nParam)
	if szWndName == self.BTN_CARD_PROTECT then
		if self.bSafeCard == 1 and self.bProtected == 1 then
			self:SafeCardLogin();		-- ??????
		elseif self.bSafeCard == 1 and self.bProtected == 0 then
			me.Msg("Nh??n v???t c???a b???n ??ang ??? tr???ng th??i m??? kh??a!");
		else
			UiManager:CloseWindow(self.UIGROUP);
			OpenWebSite(self.SZ_CARD_OPEN_URL);
		end
	end
	
	if szWndName == self.BTN_LINGPAI_PROTECT then
		if self.bProtected == 1 and self.bSafeKey == 1 and Ui.tbLogic.tbPassPodTime:IsReady() == 1 then
			self:SafeKeyLogin();		-- ??????
		elseif self.bProtected == 0 and self.bSafeKey == 1 then
			me.Msg("Nh??n v???t c???a b???n ??ang ??? tr???ng th??i m??? kh??a!");
		elseif self.bProtected == 1 and self.bSafeKey == 1 and Ui.tbLogic.tbPassPodTime:IsReady() == 0 then
			me.Msg("5 ph??t sau khi nh??n v???t ????ng nh???p m???i c?? th??? m??? L???nh b??i, xin h??y ?????i!");
		else
			UiManager:CloseWindow(self.UIGROUP);
			OpenWebSite(self.SZ_LINGPAI_OPEN_URL);
		end
	end
	
	if szWndName == self.BTN_ACCOUNT_LOCK_PROTECT then
		if self.bProtected == 1 and self.bAccountLock == 1 then	-- ????????????????????????????????????
			self:SafeAccountLockLogin();		-- ??????
		elseif self.bProtected == 0 and self.bAccountLock == 1 then -- ???????????????????????????
			me.Msg("Nh??n v???t c???a b???n ??ang ??? tr???ng th??i m??? kh??a!");
		else
			UiManager:OpenWindow(Ui.UI_SETPASSWORD, 1); -- ??????????????????????????????	
		end
	end
	
	if szWndName == self.BTN_SETPASSWORD then
		if self.bAccountLock ~= 1 then
			UiManager:OpenWindow(Ui.UI_SETPASSWORD, 1); -- ??????????????????????????????
		else
			UiManager:OpenWindow(Ui.UI_SETPASSWORD, 0); -- ????????????????????????
		end
	end
	
	if szWndName == self.BTN_ACCOUNT_LOCK_DISCHARGE then
		local tbMsg = {};
		if Player.bApplyingJiesuo == 1 then -- ????????????????????????
			tbMsg.szMsg = "X??c nh???n kh??a t??i kho???n? Ch???n \"?????ng ??\", t??i kho???n c???a b???n s??? ???????c b???o v??? an to??n.";
			tbMsg.nOptCount = 2;
			function tbMsg:Callback(nOptIndex)
				if (nOptIndex == 2) then
					me.CallServerScript({"AccountCmd", Account.JIESUO_CANCEL});
				end
			end		 
			UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg);
		else
			tbMsg.szMsg = "X??c nh???n x??a m?? b???o v???? ????ng k?? s??? c?? hi???u l???c sau 5 ng??y.";
			tbMsg.nOptCount = 2;
			function tbMsg:Callback(nOptIndex)
				if (nOptIndex == 2) then
					me.CallServerScript({"AccountCmd", Account.JIESUO_APPLY});
				end
			end
			UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg);
		end
			UiManager:CloseWindow(self.UIGROUP);
	end
	
	if szWndName == self.BTN_CARD_MISS then
		OpenWebSite(self.SZ_CARD_MISS_URL);
	end
	
	if szWndName == self.BTN_CARD_CHANGE then
		OpenWebSite(self.SZ_CARD_CHANGE_URL);
	end
	
	if szWndName == self.BTN_CARD_DISCHARGE then
		OpenWebSite(self.SZ_CARD_DISCHARGE_URL);
	end
	
	if szWndName == self.BTN_LINGPAI_MISS then
		OpenWebSite(self.SZ_LINGPAI_MISS_URL);
	end
	
	if szWndName == self.BTN_LINGPAI_DISCHARGE then
		OpenWebSite(self.SZ_LINGPAI_DISCHARGE_URL);
	end
	
	if szWndName == self.BTN_MIBAO_LINK then
	  	OpenWebSite(self.SZ_MIBAO_URL);
	end
	
	if szWndName == self.BTN_TW_PHONE_LOCK_PROTECT then
		me.CallServerScript{"AccountCmd", Account.UNLOCK_PHONELOCK}
		Wnd_SetEnable(self.UIGROUP, self.BTN_TW_PHONE_LOCK_PROTECT, 0);
		self.nOpenTWPhoneLockLeftTime = 60;
		self.nTWPhoneLockTimer = Timer:Register(18, self.ShowOpenTWPhoneLockTime, self);
	end

	if szWndName == self.BTN_CLOSE or 
	   szWndName == self.BTN_ACCOUNT_LOCK_CANCEL or 
	   szWndName == self.BTN_LINGPAI_CANCEL or
	   szWndName == self.BTN_CARD_CANCEL or
	   szWndName == self.BTN_MIBAO_CANCEL or
	   szWndName == self.BTN_TW_PHONE_LOCK_CANCEL then
	   	UiManager:CloseWindow(Ui.UI_MINIKEYBOARD);
		UiManager:CloseWindow(self.UIGROUP);
	end
end

function UiLockAccount:ShowOpenTWPhoneLockTime()
	self.nOpenTWPhoneLockLeftTime = self.nOpenTWPhoneLockLeftTime - 1;
	if self.nOpenTWPhoneLockLeftTime > 0 then
		Txt_SetTxt(self.UIGROUP, self.TEXT_TW_PHONE_LOCK_GUIDE, self.SZ_TW_PHONE_LOCK_HOLDING.."\n<color=yellow>Th???i gian m??? c??n: <color><color=green>"..self.nOpenTWPhoneLockLeftTime.." gi??y<color>");
	else
		Txt_SetTxt(self.UIGROUP, self.TEXT_TW_PHONE_LOCK_GUIDE, self.SZ_TW_PHONE_LOCK_GUIDE);
		self.nTWPhoneLockTimer = nil;
		Wnd_SetEnable(self.UIGROUP, self.BTN_TW_PHONE_LOCK_PROTECT, 1);
		return 0;
	end
end

function UiLockAccount:OnEditFocus(szWndName)
	if szWndName == self.EDT_ACCOUNT_LOCK_PWD then
		self:ShowMiniKeyBoard();
	end
end

function UiLockAccount:UpdateCardPositionText()
	local tbMatrixKey = self:ParseMatrix(me.GetMatrixPosition());
	if tbMatrixKey then
	
		local szTxt1 = "Con s??? h??ng th??? <color=yellow>"..tbMatrixKey[1].."<color>, c???t th??? <color=yellow>"..tbMatrixKey[2].."<color> l??: ";
		local szTxt2 = "Con s??? h??ng th??? <color=yellow>"..tbMatrixKey[3].."<color>, c???t th??? <color=yellow>"..tbMatrixKey[4].."<color> l??: ";
		local szTxt3 = "Con s??? h??ng th??? <color=yellow>"..tbMatrixKey[5].."<color>, c???t th??? <color=yellow>"..tbMatrixKey[6].."<color> l??: ";
		
		Txt_SetTxt(self.UIGROUP, self.TEXT_CARD_NUM1, szTxt1);
		Txt_SetTxt(self.UIGROUP, self.TEXT_CARD_NUM2, szTxt2);
		Txt_SetTxt(self.UIGROUP, self.TEXT_CARD_NUM3, szTxt3);
	end
end

function UiLockAccount:ParseMatrix(szMatrix)
	local tbKeys = {};
	for i = 1, string.len(szMatrix) do
		tbKeys[i] = string.sub(szMatrix, i, i);
	end
	if #tbKeys > 0 then
		return tbKeys;
	else
		return nil;
	end
end

function UiLockAccount:UpdateProtect()
	if me.IsAccountLock() == 1 then
		self.bProtected = 1;
	else
		self.bProtected = 0;
	end;
	
	if me.IsAccountLockOpen() == 1 and me.GetPasspodMode() == 0 then
		self.bAccountLock = 1;
	else
		self.bAccountLock = 0;
	end
	
	if me.IsAccountLockOpen() == 1 and me.GetPasspodMode() == Account.PASSPODMODE_ZPTOKEN then
		self.bSafeKey = 1;
	else
		self.bSafeKey = 0;
	end
	
	if me.IsAccountLockOpen() == 1 and me.GetPasspodMode() == Account.PASSPODMODE_ZPMATRIX then
		self.bSafeCard = 1;
	else
		self.bSafeCard = 0;
	end
	
	if me.GetPasspodMode() == Account.PASSPODMODE_TW_PHONELOCK then
		self.bTWPhoneLock = 1;
	else
		self.bTWPhoneLock = 0;
	end
	self:Update();
end

function UiLockAccount:Update()	
	if self.bSafeCard == 1 and self.bProtected == 1 then
		self:UpdateCardPositionText();
		TxtEx_SetText(self.UIGROUP, self.TEXTEX_CARD_NOTE, self.SZ_CARD_NOTE..self.FOBBIDEN_NOTE..self.SZ_CARD_OPERATION_NOTE);	
		self:ShowCardPswLogin(1);
		Wnd_SetVisible(self.UIGROUP, self.TEXT_CARD_GUIDE, 0);
		Wnd_SetVisible(self.UIGROUP, self.BTN_CARD_DISCHARGE, 1);	
	 	Wnd_SetVisible(self.UIGROUP, self.BTN_CARD_CHANGE, 1);
	 	Wnd_SetVisible(self.UIGROUP, self.BTN_CARD_MISS, 1);	
		Btn_SetTxt(self.UIGROUP, self.BTN_CARD_PROTECT, "M??? kh??a");
	elseif self.bSafeCard == 1 and self.bProtected == 0 then
		self:ShowCardPswLogin(0);	
		Wnd_SetVisible(self.UIGROUP, self.TEXT_CARD_GUIDE, 0);
		Wnd_SetVisible(self.UIGROUP, self.BTN_CARD_DISCHARGE, 1);	
	  	Wnd_SetVisible(self.UIGROUP, self.BTN_CARD_CHANGE, 1);		
		Wnd_SetVisible(self.UIGROUP, self.BTN_CARD_MISS, 1);		
		Btn_SetTxt(self.UIGROUP, self.BTN_CARD_PROTECT, "M??? kh??a");
		TxtEx_SetText(self.UIGROUP, self.TEXTEX_CARD_NOTE, self.SZ_CARD_NOTE..self.SZ_UNLOCK_NOTE);
	else
		self:ShowCardPswLogin(0);	
		Wnd_SetVisible(self.UIGROUP, self.TEXT_CARD_GUIDE, 1);
		Wnd_SetVisible(self.UIGROUP, self.BTN_CARD_DISCHARGE, 0);	
	  	Wnd_SetVisible(self.UIGROUP, self.BTN_CARD_CHANGE, 0);		
		Wnd_SetVisible(self.UIGROUP, self.BTN_CARD_MISS, 0);		
		Btn_SetTxt(self.UIGROUP, self.BTN_CARD_PROTECT, "M??? b???o v???");
		TxtEx_SetText(self.UIGROUP, self.TEXTEX_CARD_NOTE, self.SZ_DISPROTECT_CARD_NOTE);
	end

	if self.bSafeKey == 1 and self.bProtected == 1 then
	  	Btn_SetTxt(self.UIGROUP, self.BTN_LINGPAI_PROTECT, "M??? kh??a");
	  	if Ui.tbLogic.tbPassPodTime:GetLeaveTime() > 0 then
	   	 	TxtEx_SetText(self.UIGROUP, self.TEXTEX_LINGPAI_NOTE, self.SZ_LINGPAI_NOTE..self.FOBBIDEN_NOTE..self.SZ_LINGPAI_OPERATION_NOTE.."\n<color=yellow>Hi???n th???i gian ch??? ?????i c??n:<color><color=green>".. Ui.tbLogic.tbPassPodTime:GetLeaveTime().." ph??t.<color>");
		    Wnd_SetVisible(self.UIGROUP, self.TEXT_LINGPAI_GUIDE, 0);
		  else
			TxtEx_SetText(self.UIGROUP, self.TEXTEX_LINGPAI_NOTE, self.SZ_LINGPAI_NOTE..self.FOBBIDEN_NOTE.."<color=yellow>H??y nh???p m???t m?? L???nh b??i ????? m??? kh??a.<color>");
		  	self:ShowLingPaiPswLogin(1);
		  	Wnd_SetVisible(self.UIGROUP, self.TEXT_LINGPAI_GUIDE, 0);
		  end
			Wnd_SetVisible(self.UIGROUP, self.BTN_LINGPAI_MISS, 1);	
			Wnd_SetVisible(self.UIGROUP, self.BTN_LINGPAI_DISCHARGE, 1);	
	  
	elseif self.bSafeKey == 1 and self.bProtected == 0 then
		self:ShowLingPaiPswLogin(0);
		Wnd_SetVisible(self.UIGROUP, self.TEXT_LINGPAI_GUIDE, 0);
		Btn_SetTxt(self.UIGROUP, self.BTN_LINGPAI_PROTECT, "M??? kh??a");
		Wnd_SetVisible(self.UIGROUP, self.BTN_LINGPAI_MISS, 1);	
	  Wnd_SetVisible(self.UIGROUP, self.BTN_LINGPAI_DISCHARGE, 1);	
		TxtEx_SetText(self.UIGROUP, self.TEXTEX_LINGPAI_NOTE, self.SZ_LINGPAI_NOTE..self.SZ_UNLOCK_NOTE);
	else
		self:ShowLingPaiPswLogin(0);
		Wnd_SetVisible(self.UIGROUP, self.TEXT_LINGPAI_GUIDE, 1);
		Btn_SetTxt(self.UIGROUP, self.BTN_LINGPAI_PROTECT, "M??? b???o v???");
		Wnd_SetVisible(self.UIGROUP, self.BTN_LINGPAI_MISS, 0);	
		Wnd_SetVisible(self.UIGROUP, self.BTN_LINGPAI_DISCHARGE, 0);	
		TxtEx_SetText(self.UIGROUP, self.TEXTEX_LINGPAI_NOTE, self.SZ_DISPROTECT_LINGPAI_NOTE);
	end
	
	if self.bAccountLock == 1 and self.bProtected == 1 then
		self:ShowAccountLockPswLogin(1);	
		Wnd_SetVisible(self.UIGROUP, self.TEXT_ACCOUNT_LOCK_GUIDE, 0);
		Btn_SetTxt(self.UIGROUP, self.BTN_ACCOUNT_LOCK_PROTECT, "M??? kh??a");
		Wnd_SetVisible(self.UIGROUP, self.BTN_SETPASSWORD, 1);	
		Wnd_SetVisible(self.UIGROUP, self.BTN_ACCOUNT_LOCK_DISCHARGE, 1);	
		TxtEx_SetText(self.UIGROUP, self.TEXTEX_ACCOUNT_LOCK_NOTE, self.SZ_ACCOUNT_LOCK_NOTE..self.FOBBIDEN_NOTE..self.SZ_ACCOUNT_LOCK_OPERATION_NOTE);
	elseif self.bAccountLock == 1 and self.bProtected == 0 then
		self:ShowAccountLockPswLogin(0);
		Wnd_SetVisible(self.UIGROUP, self.TEXT_ACCOUNT_LOCK_GUIDE, 0);
		Btn_SetTxt(self.UIGROUP, self.BTN_ACCOUNT_LOCK_PROTECT, "M??? kh??a");
		Wnd_SetVisible(self.UIGROUP, self.BTN_SETPASSWORD, 1);	
		Wnd_SetVisible(self.UIGROUP, self.BTN_ACCOUNT_LOCK_DISCHARGE, 1);	
		TxtEx_SetText(self.UIGROUP, self.TEXTEX_ACCOUNT_LOCK_NOTE, self.SZ_ACCOUNT_LOCK_NOTE..self.SZ_UNLOCK_NOTE);
	else
		self:ShowAccountLockPswLogin(0);
		Wnd_SetVisible(self.UIGROUP, self.TEXT_ACCOUNT_LOCK_GUIDE, 1);
		Btn_SetTxt(self.UIGROUP, self.BTN_ACCOUNT_LOCK_PROTECT, "M??? b???o v???");
		Wnd_SetVisible(self.UIGROUP, self.BTN_SETPASSWORD, 0);	
		Wnd_SetVisible(self.UIGROUP, self.BTN_ACCOUNT_LOCK_DISCHARGE, 0);	
		TxtEx_SetText(self.UIGROUP, self.TEXTEX_ACCOUNT_LOCK_NOTE, self.SZ_DISPROTECT_NOTE_ACCOUNT_LOCK);
	end
	
	TxtEx_SetText(self.UIGROUP, self.TEXTEX_MIBAO_NOTE, self.SZ_MIBAO_NOTE);	
	
	TxtEx_SetText(self.UIGROUP, self.TEXTEX_TW_PHONE_LOCK_NOTE, self.SZ_TW_PHONE_LOCK_NOTE);
	if self.bTWPhoneLock == 1 and self.bProtected == 1 then
		Txt_SetTxt(self.UIGROUP, self.TEXT_TW_PHONE_LOCK_GUIDE, self.SZ_TW_PHONE_LOCK_GUIDE);
		Wnd_SetVisible(self.UIGROUP, self.BTN_TW_PHONE_LOCK_PROTECT, 1);
	elseif self.bTWPhoneLock == 1 and self.bProtected == 0 then
		Txt_SetTxt(self.UIGROUP, self.TEXT_TW_PHONE_LOCK_GUIDE, self.SZ_TW_PHONE_UNLOCK_GUIDE);
		Wnd_SetVisible(self.UIGROUP, self.BTN_TW_PHONE_LOCK_PROTECT, 0);
		if self.nTWPhoneLockTimer then 
			self.nOpenTWPhoneLockLeftTime = 0;
			Timer:Close(self.nTWPhoneLockTimer);
			self.nTWPhoneLockTimer = nil;
		end
	else
		Txt_SetTxt(self.UIGROUP, self.TEXT_TW_PHONE_LOCK_GUIDE, self.SZ_NO_TW_PHONE_LOCK_GUIDE);
	end
	if self.nTWPhoneLockTimer == nil then
		Wnd_SetEnable(self.UIGROUP, self.BTN_TW_PHONE_LOCK_PROTECT, 1);
	else
		Wnd_SetEnable(self.UIGROUP, self.BTN_TW_PHONE_LOCK_PROTECT, 0);
	end
end

function UiLockAccount:SafeCardLogin()
	local tbKey = {};
	tbKey[1] = Edt_GetTxt(self.UIGROUP, self.EDT_CARD_NUM1);
	tbKey[2] = Edt_GetTxt(self.UIGROUP, self.EDT_CARD_NUM2);
	tbKey[3] = Edt_GetTxt(self.UIGROUP, self.EDT_CARD_NUM3);
	if not tbKey[1] or not tbKey[2] or not tbKey[3] then
		me.Msg("Ch??a ??i???n con s??? ch??? ?????nh trong Th??? m???t m??!");
		return;
	end
	local szPsw = tbKey[1]..tbKey[2]..tbKey[3];
	me.CallServerScript{"AccountCmd", Account.UNLOCK_BYPASSPOD, szPsw};
end

function UiLockAccount:SafeKeyLogin()
	local szPass = Edt_GetTxt(self.UIGROUP, self.EDT_LINGPAI_PWD);
	if string.len(szPass) < 6 then
		me.Msg("M???t m?? ??t nh???t c?? 6 s???.");
		return 0;
	end
	me.CallServerScript{"AccountCmd", Account.UNLOCK_BYPASSPOD, szPass};
end

function UiLockAccount:SafeAccountLockLogin()
	local bRightPwd = self:CheckPwd();
	if bRightPwd == 1 then
		local nPsw = self:EncryptPsw();
		local nDivValue = nPsw / self.nr3;
		if math.abs(nDivValue * self.nr3 - nPsw) < 1 then
			me.CallServerScript{"AccountCmd", Account.UNLOCK, nDivValue, self.nr3};	
		end
		UiManager:CloseWindow(Ui.UI_MINIKEYBOARD);
		self.nPwd = 1;
		self.nPos = 100000;
		self:UpdatePwdShow();
		return;
	end
	self.nPwd = 1;
	self.nPos = 100000;
	self:UpdatePwdShow();
end

function UiLockAccount:KeyProc(szKey)
	self:ProcessPwd(szKey);
	self:UpdatePwdShow();
end

function UiLockAccount:ProcessPwd(nKey)
	if UiManager:WindowVisible(self.UIGROUP) ~= 1 then
		return;
	end
	if not nKey then
		return;
	end
	if nKey == 0 and self.nPwd == 1 and me.GetPasspodMode() == 0 then
		me.Msg("M???t m?? kh??ng b???t ?????u b???ng 0!");
		return;
	end
	if nKey ~= -1 then		
		if self.nPwd >= 1000000 or self.nPos < 1 then
			return;
		end
		local nNameId = KLib.String2Id(tostring(me.GetNpc().dwId));
		self.nPwd = self.nPwd * 10 + (nKey + math.floor(nNameId / self.nPos) % 10) % 10;
		self.nPos = self.nPos / 10;
	elseif self.nPwd >= 10 then
		self.nPwd = math.floor(self.nPwd / 10);	
		self.nPos = self.nPos * 10;
	end
end

function UiLockAccount:UpdatePwdShow()	
	local szPwdStar = self:BuildStarByCount(math.ceil(math.log10(1 + self.nPwd)) - 1);
	Edt_SetTxt(self.UIGROUP, self.EDT_ACCOUNT_LOCK_PWD, szPwdStar);
end

function UiLockAccount:CheckPwd()
	if self.nPwd < 1000000 or self.nPwd > 1999999 then
		me.Msg("M???t m?? ph???i g???m 6 s???!");
		return 0;
	end
	return 1;
end

function UiLockAccount:EncryptPsw()
	return (self.nPwd % 1000000) * 64 + 32 + self.nr2 * 67108864;
end

function UiLockAccount:ShowMiniKeyBoard()
	self.nr1 = MathRandom(63);
	self.nr2 = MathRandom(63);
	self.nr3 = MathRandom(65535) / 65536;
	UiManager:OpenWindow(Ui.UI_MINIKEYBOARD);
	local x, y = Wnd_GetPos(Ui.UI_MINIKEYBOARD, "Main");
	y = MathRandom(10) * 30;
	Wnd_SetPos(Ui.UI_MINIKEYBOARD, "Main", x, y);
end

function UiLockAccount:BuildStarByCount(nCount)
	local szStar = "";
	if nCount > 0 then
		for i = 1, nCount do
			szStar = szStar.."*";
		end;
	end
	return szStar;
end

function UiLockAccount:ShowAccountLockPswLogin(bShow)
	Wnd_SetVisible(self.UIGROUP, self.TEXTEX_ACCOUNT_LOCK_PSW, bShow);
	Wnd_SetVisible(self.UIGROUP, self.EDT_ACCOUNT_LOCK_PWD, bShow);
	Wnd_SetVisible(self.UIGROUP, self.IMG_ACCOUNT_LOCK_PWD, bShow);
end

function UiLockAccount:ShowLingPaiPswLogin(bShow)
	Wnd_SetVisible(self.UIGROUP, self.TEXTEX_LINGPAI_PSW, bShow);
	Wnd_SetVisible(self.UIGROUP, self.EDT_LINGPAI_PWD, bShow);
	Wnd_SetVisible(self.UIGROUP, self.IMG_LINGPAI_PWD, bShow);	
end

function UiLockAccount:ShowCardPswLogin(bShow)
	Wnd_SetVisible(self.UIGROUP, self.TEXT_CARD_NUM1, bShow);
	Wnd_SetVisible(self.UIGROUP, self.TEXT_CARD_NUM2, bShow);
	Wnd_SetVisible(self.UIGROUP, self.TEXT_CARD_NUM3, bShow);
	Wnd_SetVisible(self.UIGROUP, self.EDT_CARD_NUM1, bShow);
	Wnd_SetVisible(self.UIGROUP, self.IMG_CARD_NUM1, bShow);
	Wnd_SetVisible(self.UIGROUP, self.EDT_CARD_NUM2, bShow);
	Wnd_SetVisible(self.UIGROUP, self.IMG_CARD_NUM2, bShow);	
	Wnd_SetVisible(self.UIGROUP, self.EDT_CARD_NUM3, bShow);
	Wnd_SetVisible(self.UIGROUP, self.IMG_CARD_NUM3, bShow);
	Wnd_SetVisible(self.UIGROUP, self.BTN_CARD_MISS, bShow);	

end

function UiLockAccount:RegisterEvent()
	local tbRegEvent = 
	{
		{ UiNotify.emCOREEVENT_SYNC_LOCK,				self.UpdateProtect },
		{ UiNotify.emUIEVENT_PASSPODTIME_REFRESH,		self.Update        },
		{ UiNotify.emUIEVENT_MINIKEY_SEND,				self.KeyProc },
	};
	return tbRegEvent;
end

function UiLockAccount:UpdateErrorMsg(szErrorMsg)
  
	if self.bSafeCard == 1 and self.bProtected == 1 then
		self:UpdateCardPositionText();
		TxtEx_SetText(self.UIGROUP, self.TEXTEX_CARD_NOTE, self.SZ_CARD_NOTE.."<color=red>"..szErrorMsg.."<color>");
	end	
	
	if self.bSafeKey == 1 and self.bProtected == 1 then
		TxtEx_SetText(self.UIGROUP, self.TEXTEX_LINGPAI_NOTE, self.SZ_LINGPAI_NOTE.."<color=red>"..szErrorMsg.."<color>");
	end
	
	if self.bAccountLock == 1 and self.bProtected == 1 then
		TxtEx_SetText(self.UIGROUP, self.TEXTEX_ACCOUNT_LOCK_NOTE, self.SZ_ACCOUNT_LOCK_NOTE.."<color=red>"..szErrorMsg.."<color>");
	end
	
	if self.bTWPhoneLock == 1 and self.bProtected == 1 then
		Txt_SetTxt(self.UIGROUP, self.TEXT_TW_PHONE_LOCK_GUIDE, self.SZ_ACCOUNT_LOCK_NOTE.."<color=red>"..szErrorMsg.."<color>");
	end
	
end

function UiLockAccount:PhoneLockResult(nRet)
	if self.bTWPhoneLock == 1 then
		if self.nTWPhoneLockTimer then 
			self.nOpenTWPhoneLockLeftTime = 0;
			Timer:Close(self.nTWPhoneLockTimer);
			self.nTWPhoneLockTimer = nil;
		end
		if nRet ~= 1 then
			Wnd_SetEnable(self.UIGROUP, self.BTN_TW_PHONE_LOCK_PROTECT, 1);
		end
		if Account.PHONE_UNLOCK_RESULT[nRet] then
			TxtEx_SetText(self.UIGROUP, self.TEXTEX_TW_PHONE_LOCK_NOTE, Account.PHONE_UNLOCK_RESULT[nRet]);
			me.Msg(Account.PHONE_UNLOCK_RESULT[nRet]);
		end
		
	end
end
