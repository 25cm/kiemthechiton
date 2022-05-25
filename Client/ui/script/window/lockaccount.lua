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
    "Nhân vật đang ở trạng thái khóa bảo vệ. Trạng thái này cấm những thao tác như sau:\n"..
    "1. Giao dịch với người khác;              5. Sử dụng bồ câu đưa thư;\n"..
    "2. Bày bán;                    6. Bỏ vật phẩm;\n"..
    "3. Sử dụng Kỳ Trân Các;              7. Kỹ năng sống;\n"..
    "4. Sử dụng khu giao dịch đồng;          8. Cường hóa, tháo và ghép Huyền Tinh.\n\n"

UiLockAccount.SZ_UNLOCK_NOTE =
    "<color=green>Bạn đang ở trạng thái mở khóa! Nhân vật đăng nhập lần sau sẽ tự động vào trạng thái khóa. Chúc vui vẻ!<color>\n"

UiLockAccount.SZ_CARD_NOTE =
    "<color=yellow>Bạn đã mở chức năng Thẻ mật mã.<color>\n\n"

UiLockAccount.SZ_CARD_OPERATION_NOTE = "<color=yellow>Hãy xem Thẻ mật mã, nhập vào những con số tương ứng.<color>"

UiLockAccount.SZ_DISPROTECT_CARD_NOTE = 
    "<color=yellow>Bạn chưa mở chức năng Thẻ mật mã.<color>\n\n"..
    "Thẻ mật mã là hình ảnh gồm những con số, sau khi mở bảo vệ, mỗi lần nhân vật đăng nhập sẽ tự động ở trạng thái khóa, chỉ có thể giao dịch hay chuyển nhượng tài sản khi nhập mật mã. Thẻ mật mã sau khi tải xuống hãy in ra hay lưu vào điện thoại di động, không nên lưu trên máy vi tính.\n\n"..
    "<color=yellow>Giới thiệu cho tất cả người chơi sử dụng, miễn phí, đơn giản, tính an toàn cao.<color>"

UiLockAccount.SZ_GUIDE_CARD_NOTE =
    "<color=green>Phương pháp mở:\n"..
    "1. Nhấp \"Mở bảo vệ\" để vào trang chủ Thẻ mật mã;\n"..
    "2. Theo nhắc nhở trang chủ nhận Thẻ mật mã đồng thời khóa tài khoản trò chơi.<color>"

UiLockAccount.SZ_LINGPAI_NOTE = 
    "<color=yellow>Bạn đã mở chức năng Lệnh bài.<color>\n\n"

UiLockAccount.SZ_LINGPAI_OPERATION_NOTE = 
    "<color=yellow>Mỗi lần đăng nhập nhân vật phải đợi 5 phút mới có thể mở khóa.<color>"
    
UiLockAccount.SZ_DISPROTECT_LINGPAI_NOTE =     
    "<color=yellow>Bạn chưa mở chức năng Lệnh bài.<color>\n\n"..
    "Lệnh bài là sản phẩm bảo vệ tài khoản cá nhân, với cách thức mỗi lần 1 mã, mỗi lệnh bài có 1 mã duy nhất và khẩu lệnh duy nhất. Sau khi mở bảo vệ, mỗi lần nhân vật đăng nhập sẽ tự động ở trạng thái khóa, chỉ có thể giao dịch hay chuyển nhượng tài sản khi nhập mật mã thiết lập.\n\n"..
    "<color=yellow>Giới thiệu cho những nhân vật có vật phẩm quý, tính an toàn rất cao.<color>"

UiLockAccount.SZ_GUIDE_LINGPAI_NOTE =
    "<color=green>Phương pháp mở:\n"..
    "1. Nhấp \"Mở bảo vệ\" để vào trang chủ Lệnh bài VNG;\n"..
    "2. Tìm hiểu và mua Lệnh bài;\n"..
    "3. Khóa lệnh bài trên trang chủ Lệnh bài VNG.<color>"

UiLockAccount.SZ_GUIDE_ACCOUNT_LOCK_NOTE =  
    "<color=green>Phương pháp mở:\n"..
    "1. Nhấp \"Mở bảo vệ\", thiết lập mật mã khóa an toàn;\n"..
    "2. Mật mã có thể thay đổi, nếu bất cẩn quên mất mật mã có thể sử dụng \"Đăng ký mở khóa\" để hủy mật mã.<color>"

UiLockAccount.SZ_ACCOUNT_LOCK_NOTE = 
    "Bạn đã mở chức năng khóa bảo vệ. <color=yellow>Để bảo vệ an toàn tài khoản, bạn nhất định phải mở chức năng Thẻ mật mã hay Lệnh bài.<color>\n\n"

UiLockAccount.SZ_ACCOUNT_LOCK_OPERATION_NOTE = "<color=yellow>Hãy nhập mật mã mở khóa. Nếu quên có thể nhấp vào \"Đăng ký mở khóa\".<color>"

UiLockAccount.SZ_DISPROTECT_NOTE_ACCOUNT_LOCK = 
    "<color=yellow>Bạn chưa mở bất kỳ chức năng bảo vệ tài khoản.<color>\n\n"..
    "Khóa an toàn là một chức năng mật mã bảo vệ bên trong trò chơi. Sau khi mở bảo vệ, mỗi lần nhân vật đăng nhập sẽ tự động ở trạng thái khóa, chỉ có thể giao dịch hay chuyển nhượng tài sản khi nhập mật mã.\n\n"..
    "Giới thiệu với người chơi sơ cấp, để bảo vệ tài khoản, <color=yellow>bạn nhất định phải mở chức năng Thẻ mật mã hay Lệnh bài.<color>"
    
UiLockAccount.SZ_MIBAO_NOTE =
    "Phần mềm mật mã là phần mềm bảo vệ \"Chuyên dùng cho Kiếm Thế\".\n\n"..
    "Thích hợp cho tất cả người chơi, sau khi tải xuống có thể bảo vệ máy vi tính tránh sự xâm nhập của hacker.\n\n"..
    "<color=yellow>Nhấp \"Liên kết tải\" để vào trang chủ tìm hiểu đồng thời tải xuống sử dụng.<color>"

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
<color=yellow>什麼是通訊鎖？<color>
<color=green>
通訊鎖為保障遊戲帳號資料安全所設置的安全機制，以個人行動電話或市內電話來綁定遊戲帳號。當遊戲帳號登入遊戲中，首次欲進 行遊戲資料交易等財產轉移操作，都須進行通訊鎖解除鎖定方可進行 
<color>
通訊鎖專線 
台灣（含全區）解鎖號碼：0800-771-778 
香港解鎖號碼：3717-1615 
]]
UiLockAccount.SZ_TW_PHONE_LOCK_GUIDE = "Trạng thái đóng tin tức khóa";
UiLockAccount.SZ_TW_PHONE_LOCK_HOLDING = "Nội trong 1 phút xin gửi tin tức khóa của tài khoản này"
UiLockAccount.SZ_TW_PHONE_UNLOCK_GUIDE = "Trạng thái mở tin tức khóa";
UiLockAccount.SZ_NO_TW_PHONE_LOCK_GUIDE = "Chưa xin phép trạng thái khóa (Đài Loan)";

UiLockAccount.nTWPhoneLockTimer = nil;  -- 台湾手机锁提示计时器

function UiLockAccount:Init()
	self.bProtected = 1;	-- 开通保护
	self.bAccountLock = 1;	-- 安全锁
	self.bSafeKey = 1; 		-- 令牌
	self.bSafeCard = 1;		-- 密保卡
	self.bTWPhoneLock = 1;  -- 台湾手机锁
	self.nPwd = 1;
	self.nPos = 100000;
	self:UpdatePwdShow();
end

function UiLockAccount:OnOpen()
	if (0 == UiManager:CheckLockAccountState()) then
		self.SZ_DISPROTECT_NOTE_ACCOUNT_LOCK = 
[[<color=yellow>Bạn chưa mở chức năng bảo vệ tài khoản.<color>

Khóa an toàn là chức năng mật mã bảo vệ trong trò chơi. Sau khi mở bảo vệ, mỗi lần nhân vật đăng nhập sẽ tự động vào trạng thái khóa, sau khi nhập mật mã mới được tiến hành thao tác di chuyển tài sản giao dịch.
]];

		self.SZ_ACCOUNT_LOCK_NOTE = [[Bạn đã mở chức năng khóa bảo vệ an toàn.

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
		Btn_SetTxt(self.UIGROUP, self.BTN_ACCOUNT_LOCK_DISCHARGE, "Hủy mở khóa");
	else
		Btn_SetTxt(self.UIGROUP, self.BTN_ACCOUNT_LOCK_DISCHARGE, "Xin mở khóa");
	end
end

function UiLockAccount:OnButtonClick(szWndName, nParam)
	if szWndName == self.BTN_CARD_PROTECT then
		if self.bSafeCard == 1 and self.bProtected == 1 then
			self:SafeCardLogin();		-- 解锁
		elseif self.bSafeCard == 1 and self.bProtected == 0 then
			me.Msg("Nhân vật của bạn đang ở trạng thái mở khóa!");
		else
			UiManager:CloseWindow(self.UIGROUP);
			OpenWebSite(self.SZ_CARD_OPEN_URL);
		end
	end
	
	if szWndName == self.BTN_LINGPAI_PROTECT then
		if self.bProtected == 1 and self.bSafeKey == 1 and Ui.tbLogic.tbPassPodTime:IsReady() == 1 then
			self:SafeKeyLogin();		-- 解锁
		elseif self.bProtected == 0 and self.bSafeKey == 1 then
			me.Msg("Nhân vật của bạn đang ở trạng thái mở khóa!");
		elseif self.bProtected == 1 and self.bSafeKey == 1 and Ui.tbLogic.tbPassPodTime:IsReady() == 0 then
			me.Msg("5 phút sau khi nhân vật đăng nhập mới có thể mở Lệnh bài, xin hãy đợi!");
		else
			UiManager:CloseWindow(self.UIGROUP);
			OpenWebSite(self.SZ_LINGPAI_OPEN_URL);
		end
	end
	
	if szWndName == self.BTN_ACCOUNT_LOCK_PROTECT then
		if self.bProtected == 1 and self.bAccountLock == 1 then	-- 如果处于密保锁保护模式中
			self:SafeAccountLockLogin();		-- 解锁
		elseif self.bProtected == 0 and self.bAccountLock == 1 then -- 如果不在保护模式中
			me.Msg("Nhân vật của bạn đang ở trạng thái mở khóa!");
		else
			UiManager:OpenWindow(Ui.UI_SETPASSWORD, 1); -- 打开初始设定密码界面	
		end
	end
	
	if szWndName == self.BTN_SETPASSWORD then
		if self.bAccountLock ~= 1 then
			UiManager:OpenWindow(Ui.UI_SETPASSWORD, 1); -- 打开初始设定密码界面
		else
			UiManager:OpenWindow(Ui.UI_SETPASSWORD, 0); -- 打开修改密码界面
		end
	end
	
	if szWndName == self.BTN_ACCOUNT_LOCK_DISCHARGE then
		local tbMsg = {};
		if Player.bApplyingJiesuo == 1 then -- 取消自助解锁申请
			tbMsg.szMsg = "Xác nhận khóa tài khoản? Chọn \"Đồng ý\", tài khoản của bạn sẽ được bảo vệ an toàn.";
			tbMsg.nOptCount = 2;
			function tbMsg:Callback(nOptIndex)
				if (nOptIndex == 2) then
					me.CallServerScript({"AccountCmd", Account.JIESUO_CANCEL});
				end
			end		 
			UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg);
		else
			tbMsg.szMsg = "Xác nhận xóa mã bảo vệ? Đăng ký sẽ có hiệu lực sau 5 ngày.";
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
		Txt_SetTxt(self.UIGROUP, self.TEXT_TW_PHONE_LOCK_GUIDE, self.SZ_TW_PHONE_LOCK_HOLDING.."\n<color=yellow>Thời gian mở còn: <color><color=green>"..self.nOpenTWPhoneLockLeftTime.." giây<color>");
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
	
		local szTxt1 = "Con số hàng thứ <color=yellow>"..tbMatrixKey[1].."<color>, cột thứ <color=yellow>"..tbMatrixKey[2].."<color> là: ";
		local szTxt2 = "Con số hàng thứ <color=yellow>"..tbMatrixKey[3].."<color>, cột thứ <color=yellow>"..tbMatrixKey[4].."<color> là: ";
		local szTxt3 = "Con số hàng thứ <color=yellow>"..tbMatrixKey[5].."<color>, cột thứ <color=yellow>"..tbMatrixKey[6].."<color> là: ";
		
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
		Btn_SetTxt(self.UIGROUP, self.BTN_CARD_PROTECT, "Mở khóa");
	elseif self.bSafeCard == 1 and self.bProtected == 0 then
		self:ShowCardPswLogin(0);	
		Wnd_SetVisible(self.UIGROUP, self.TEXT_CARD_GUIDE, 0);
		Wnd_SetVisible(self.UIGROUP, self.BTN_CARD_DISCHARGE, 1);	
	  	Wnd_SetVisible(self.UIGROUP, self.BTN_CARD_CHANGE, 1);		
		Wnd_SetVisible(self.UIGROUP, self.BTN_CARD_MISS, 1);		
		Btn_SetTxt(self.UIGROUP, self.BTN_CARD_PROTECT, "Mở khóa");
		TxtEx_SetText(self.UIGROUP, self.TEXTEX_CARD_NOTE, self.SZ_CARD_NOTE..self.SZ_UNLOCK_NOTE);
	else
		self:ShowCardPswLogin(0);	
		Wnd_SetVisible(self.UIGROUP, self.TEXT_CARD_GUIDE, 1);
		Wnd_SetVisible(self.UIGROUP, self.BTN_CARD_DISCHARGE, 0);	
	  	Wnd_SetVisible(self.UIGROUP, self.BTN_CARD_CHANGE, 0);		
		Wnd_SetVisible(self.UIGROUP, self.BTN_CARD_MISS, 0);		
		Btn_SetTxt(self.UIGROUP, self.BTN_CARD_PROTECT, "Mở bảo vệ");
		TxtEx_SetText(self.UIGROUP, self.TEXTEX_CARD_NOTE, self.SZ_DISPROTECT_CARD_NOTE);
	end

	if self.bSafeKey == 1 and self.bProtected == 1 then
	  	Btn_SetTxt(self.UIGROUP, self.BTN_LINGPAI_PROTECT, "Mở khóa");
	  	if Ui.tbLogic.tbPassPodTime:GetLeaveTime() > 0 then
	   	 	TxtEx_SetText(self.UIGROUP, self.TEXTEX_LINGPAI_NOTE, self.SZ_LINGPAI_NOTE..self.FOBBIDEN_NOTE..self.SZ_LINGPAI_OPERATION_NOTE.."\n<color=yellow>Hiện thời gian chờ đợi còn:<color><color=green>".. Ui.tbLogic.tbPassPodTime:GetLeaveTime().." phút.<color>");
		    Wnd_SetVisible(self.UIGROUP, self.TEXT_LINGPAI_GUIDE, 0);
		  else
			TxtEx_SetText(self.UIGROUP, self.TEXTEX_LINGPAI_NOTE, self.SZ_LINGPAI_NOTE..self.FOBBIDEN_NOTE.."<color=yellow>Hãy nhập mật mã Lệnh bài để mở khóa.<color>");
		  	self:ShowLingPaiPswLogin(1);
		  	Wnd_SetVisible(self.UIGROUP, self.TEXT_LINGPAI_GUIDE, 0);
		  end
			Wnd_SetVisible(self.UIGROUP, self.BTN_LINGPAI_MISS, 1);	
			Wnd_SetVisible(self.UIGROUP, self.BTN_LINGPAI_DISCHARGE, 1);	
	  
	elseif self.bSafeKey == 1 and self.bProtected == 0 then
		self:ShowLingPaiPswLogin(0);
		Wnd_SetVisible(self.UIGROUP, self.TEXT_LINGPAI_GUIDE, 0);
		Btn_SetTxt(self.UIGROUP, self.BTN_LINGPAI_PROTECT, "Mở khóa");
		Wnd_SetVisible(self.UIGROUP, self.BTN_LINGPAI_MISS, 1);	
	  Wnd_SetVisible(self.UIGROUP, self.BTN_LINGPAI_DISCHARGE, 1);	
		TxtEx_SetText(self.UIGROUP, self.TEXTEX_LINGPAI_NOTE, self.SZ_LINGPAI_NOTE..self.SZ_UNLOCK_NOTE);
	else
		self:ShowLingPaiPswLogin(0);
		Wnd_SetVisible(self.UIGROUP, self.TEXT_LINGPAI_GUIDE, 1);
		Btn_SetTxt(self.UIGROUP, self.BTN_LINGPAI_PROTECT, "Mở bảo vệ");
		Wnd_SetVisible(self.UIGROUP, self.BTN_LINGPAI_MISS, 0);	
		Wnd_SetVisible(self.UIGROUP, self.BTN_LINGPAI_DISCHARGE, 0);	
		TxtEx_SetText(self.UIGROUP, self.TEXTEX_LINGPAI_NOTE, self.SZ_DISPROTECT_LINGPAI_NOTE);
	end
	
	if self.bAccountLock == 1 and self.bProtected == 1 then
		self:ShowAccountLockPswLogin(1);	
		Wnd_SetVisible(self.UIGROUP, self.TEXT_ACCOUNT_LOCK_GUIDE, 0);
		Btn_SetTxt(self.UIGROUP, self.BTN_ACCOUNT_LOCK_PROTECT, "Mở khóa");
		Wnd_SetVisible(self.UIGROUP, self.BTN_SETPASSWORD, 1);	
		Wnd_SetVisible(self.UIGROUP, self.BTN_ACCOUNT_LOCK_DISCHARGE, 1);	
		TxtEx_SetText(self.UIGROUP, self.TEXTEX_ACCOUNT_LOCK_NOTE, self.SZ_ACCOUNT_LOCK_NOTE..self.FOBBIDEN_NOTE..self.SZ_ACCOUNT_LOCK_OPERATION_NOTE);
	elseif self.bAccountLock == 1 and self.bProtected == 0 then
		self:ShowAccountLockPswLogin(0);
		Wnd_SetVisible(self.UIGROUP, self.TEXT_ACCOUNT_LOCK_GUIDE, 0);
		Btn_SetTxt(self.UIGROUP, self.BTN_ACCOUNT_LOCK_PROTECT, "Mở khóa");
		Wnd_SetVisible(self.UIGROUP, self.BTN_SETPASSWORD, 1);	
		Wnd_SetVisible(self.UIGROUP, self.BTN_ACCOUNT_LOCK_DISCHARGE, 1);	
		TxtEx_SetText(self.UIGROUP, self.TEXTEX_ACCOUNT_LOCK_NOTE, self.SZ_ACCOUNT_LOCK_NOTE..self.SZ_UNLOCK_NOTE);
	else
		self:ShowAccountLockPswLogin(0);
		Wnd_SetVisible(self.UIGROUP, self.TEXT_ACCOUNT_LOCK_GUIDE, 1);
		Btn_SetTxt(self.UIGROUP, self.BTN_ACCOUNT_LOCK_PROTECT, "Mở bảo vệ");
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
		me.Msg("Chưa điền con số chỉ định trong Thẻ mật mã!");
		return;
	end
	local szPsw = tbKey[1]..tbKey[2]..tbKey[3];
	me.CallServerScript{"AccountCmd", Account.UNLOCK_BYPASSPOD, szPsw};
end

function UiLockAccount:SafeKeyLogin()
	local szPass = Edt_GetTxt(self.UIGROUP, self.EDT_LINGPAI_PWD);
	if string.len(szPass) < 6 then
		me.Msg("Mật mã ít nhất có 6 số.");
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
		me.Msg("Mật mã không bắt đầu bằng 0!");
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
		me.Msg("Mật mã phải gồm 6 số!");
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
