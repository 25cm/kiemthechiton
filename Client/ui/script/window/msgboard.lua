-----------------------------------------------------
--ÎÄ¼þÃû		£º	msgboard.lua
--´´½¨Õß		£º	sunduoliang
--´´½¨Ê±¼ä		£º	2008-3-14
--¹¦ÄÜÃèÊö		£º	ÔÚÏßGMÁôÑÔ°å¡£
------------------------------------------------------

local uiMsgBoard = Ui:GetClass("msgboard");

local TXT_HELP_DESCRIPT	= "TxtHelpDescript";
local EDT_SERVER		= "EditServer";
local EDT_ACCOUNT		= "EditAccount";
local EDT_NAME			= "EditRoleName";
local EDT_LEVEL			= "EditLevel";			-- »ù´¡ÊôÐÔÒ³:Íæ¼ÒµÈ¼¶
local EDT_DESCRIPT		= "EditDescript";	
local BTN_ACCEPT		= "BtnAccept";
local BTN_CANCEL		= "BtnCancel";
local BTN_CLOSE			= "BtnClose";
local COMBOBOX_FATHER	= "ComboBoxFather";
local COMBOBOX_CHILD	= "ComboBoxChild";
local tbDate = {};
local szContact = string.format("Lưu ý: Nếu cần, hãy để lại địa chỉ liên hệ của bạn, %s chúng tôi sẽ cung cấp chế độ phục vụ tốt nhất! %s", UiManager.IVER_szTelNote, UiManager.IVER_szTelNum);

local INFO_TABLE =
{
	{
		szName  = "BUG/Tư vấn",
	 	tbChild =
	 	{
			{
				szName = "Các bước nhiệm vụ",
				szDescript = string.format("<color=red>[ÌîÐ´ÐÅÏ¢]<color><color=white>Tên nhiệm vụ cụ thể, nội dung muốn tư vấn<color><enter><enter>%s", szContact),
			},
			{
				szName = "Kỹ xảo kỹ năng",
				szDescript = string.format("<color=red>[ÌîÐ´ÐÅÏ¢]<color><color=white>Tên chức năng cụ thể, nội dung muốn tư vấn<color>%s", szContact),
			},
			{
				szName = "Phản hồi BUG/Báo vi phạm",
				szDescript = string.format("<color=red>[ÌîÐ´ÐÅÏ¢]<color><color=white>Tả BUG, tên nhân vật vi phạm, nội dung báo vi phạm<color><enter><enter>%s", szContact),
			},
			{
				szName = "Hoạt động",
				szDescript = string.format("<color=red>[ÌîÐ´ÐÅÏ¢]<color><color=white>Miêu tả hoạt động, nội dung muốn tư vấn<color><enter><enter>%s", szContact),
			},
		}
	},
	{
		szName  = "Lỗi máy chủ",
		tbChild =
		{
			{
				szName = "Lỗi bản đồ server",
				szDescript = string.format("<color=red>[ÌîÐ´ÐÅÏ¢]<color><color=white>Cụm máy, tài khoản, tên nhân vật, tên bản đồ<color><enter><enter>%s", szContact),
			},
			{
				szName = "Lỗi mạng",
				szDescript = string.format("<color=red>[ÌîÐ´ÐÅÏ¢]<color><color=white>Tên hệ thống, miêu tả giao diện, câu báo lỗi<color><enter><enter>%s", szContact),
			},
		}
	},
	{
		szName  = "Cập nhật cài đặt",
		tbChild =
		{
			{
				szName = "Không tải được",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Cập nhật phiên bản mới, vị trí tải xuống, dạng kết nối<color><enter><enter>%s", szContact),
			},
			{
				szName = "Không cài đặt được",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Cập nhật phiên bản mới, vị trí tải xuống, câu báo lỗi<color><enter><enter>%s", szContact),
			},
			{
				szName = "Không thể update",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Phiên bản client, câu báo lỗi, thao tác hệ thống<color><enter><enter>%s", szContact),
			},
			{
				szName = "Lỗi cập nhật",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Miêu tả sự bất thường<color><enter><enter>%s", szContact),
			},
		}
	},
	{
		szName  = "Khách hàng",
	 	tbChild =
	 	{
			{
				szName = "Đổi mật mã",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Nội dung, tài khoản muốn tư vấn<color><enter><enter>%s", szContact),
			},
			{
				szName = "Nhân vật/Chuyển server",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Nội dung, tài khoản, nhân vật muốn tư vấn<color><enter><enter>%s", szContact),
			},
			{
				szName = "Lỗi vật phẩm",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Tài khoản/nhân vật/cụm máy, lần cuối nhìn thấy vật phẩm/lúc phát hiện bị mất<color><enter><enter>%s", szContact),
			},
			{
				szName = "Khóa vi phạm",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Tài khoản, nhân vật, nội dung phảm hồi của người chơi<color><enter><enter>%s", szContact),
			},
			{
				szName = "Dịch vụ VIP",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Tài khoản, thông tin người chơi, nội dung muốn tư vấn<color><enter><enter>%s", szContact),
			},
			{
				szName = "Khóa di động",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Tài khoản, thông tin người chơi, nội dung muốn tư vấn<color><enter><enter>%s", szContact),
			},
		
		}
	},		
	{
		szName  = "Nạp thẻ",
	 	tbChild =
	 	{
			{
				szName = "Kiểm tra thẻ nạp",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Mệnh giá, hình thức nạp thẻ, nội dung muốn kiểm tra<color><enter><enter>%s", szContact),
			},
			{
				szName = "Nhận đổi",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Tài khoản nạp thẻ/mệnh giá/cách nhận, nhân vật nhận/thời gian/số lượng, nêu vấn đề<color><enter><enter>%s", szContact),
			},
			{
				szName = "Không nạp được",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Nêu vấn đề, tài khoản nạp thẻ/mệnh giá/hình thức<color><enter><enter>%s", szContact),
			},
			{
				szName = "Tư vấn nạp thẻ",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Thông tin tư vấn cụ thể<color><enter><enter>%s", szContact),
			},
		}
	},
	{
		szName  = "Nhân vật/Lỗi nhiệm vụ",
		tbChild =
		{
			{
				szName = "Lỗi thuộc tính nhân vật",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Tài khoản/nhân vật/server, nhân vật/tin bang hội(cấp), thông báo hệ thống<color><enter><enter>%s", szContact),
			},
			{
				szName = "Lỗi vật phẩm",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Tài khoản/nhân vật/server, thông tin vật phẩm (tên, thuộc tính chính), thông báo hệ thống<color><enter><enter>%s", szContact),
			},
			{
				szName = "Lỗi vật phẩm",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Tài khoản/nhân vật/server, thông tin vật phẩm (tên, thuộc tính chính), lần cuối thấy vật phẩm/lúc phát hiện mất, nguồn gốc vật phẩm<color><enter><enter>%s", szContact),
			},
			{
				szName = "Lỗi nhân vật",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Tài khoản, nhân vật, server, tình trạng bất thường, thời gian xảy ra bất thường<color><enter><enter>%s", szContact),
			},
			{
				szName = "Lỗi nhiệm vụ",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Tài khoản, nhân vật, server, tên nhiệm vụ, thông báo hệ thống, hiển thị thanh hệ thống<color><enter><enter>%s", szContact),
			},
		}
	},
	{
		szName  = "Khiếu nại",
	 	tbChild =
	 	{
			{
				szName = "Người chơi khiếu nại",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Tài khoản/nhân vật/cụm máy, nội dung khiếu nại, thông tin cá nhân<color><enter><enter>%s", szContact),
			},
			{
				szName = "Kiến nghị",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Tài khoản/cụm máy, nội dung kiến nghị, thông tin cá nhân<color><enter><enter>%s", szContact),
			},
			{
				szName = "Lỗi nội dung",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Vị trí cụ thể thông tin lỗi, nội dung lỗi<color><enter><enter>%s", szContact),
			},
		}
	},
	{
		szName  = "Khác",
	 	tbChild =
	 	{
			{
				szName = "Khác",
				szDescript = string.format("<color=red>[Điền thông tin]<color><color=white>Trình bày chi tiết vấn đề<color><enter><enter>%s", szContact),
			},
		}
	},		
}

local PUT_INFO_TABLE ={
	{
		szName="Báo",
		tbChild={
		{
			szName="Tán gẫu không lành mạnh",		
			szDescript="<color=red>Báo tên và thông tin người chơi<color><enter><enter><color=yellow>Lưu ý: Mục này không thể thay đổi<color>"	},
		}
	},
}

function uiMsgBoard:Init()
	self.nFatherClass = 0;
	self.nChildClass = 0;
	self.szAppealMsg = "";
	self.szSourceText = nil;
	self.tbClassTemp = {};
	
end

function uiMsgBoard:UpdateServer()
	local szName = GetServerZoneName();
	if UiManager.IVER_nMsgBoardNameSplitType == 1 then
		local nSplit = string.find(szName, "-");
		if nSplit then
			szName = string.sub(szName, 1, nSplit-1);
		end
	else
		local nStart = string.find(szName, "[");
		local nEnd = string.find(szName, "]");
		local nSplit = string.find(szName, "-");
		if nStart and nEnd then
			szName = string.sub(szName, nStart, nEnd+1);
		elseif nSplit then
			szName = string.sub(szName, 1, nSplit-1);
		end
	end
	Edt_SetTxt(self.UIGROUP, EDT_SERVER, szName);
end

function uiMsgBoard:UpdateAccount()
	Edt_SetTxt(self.UIGROUP, EDT_ACCOUNT, "(Tài khoản)");
end

function uiMsgBoard:UpdateName()
	Edt_SetTxt(self.UIGROUP, EDT_NAME, me.szName);
end

function uiMsgBoard:UpdateLevel()
	Edt_SetTxt(self.UIGROUP, EDT_LEVEL, me.nLevel);
end

function uiMsgBoard:UpdateDescript()
	Edt_SetTxt(self.UIGROUP, EDT_DESCRIPT, "");
end

function uiMsgBoard:OnUpdateBasic()

	-- ¸üÐÂËùÓÐ¿Ø¼þ
	self:UpdateServer();
	self:UpdateAccount();
	self:UpdateName();
	self:UpdateLevel();	
	self:UpdateDescript();
end
-- Ìî³äÏÂÀ­¿ò
function uiMsgBoard:FillComboBoxFather(tbFatherClass)
	ClearComboBoxItem(self.UIGROUP, COMBOBOX_FATHER);
	local nItemCount = 0;
	for nId, tbClass in pairs(tbFatherClass) do
		if (ComboBoxAddItem(self.UIGROUP, COMBOBOX_FATHER, nId, tbClass.szName) == 1) then
			nItemCount = nItemCount + 1;
		end
	end	
	
	return nItemCount;
end

function uiMsgBoard:FillComboBoxChild(tbFatherClass)
	ClearComboBoxItem(self.UIGROUP, COMBOBOX_CHILD);
	local nItemCount = 0;

	for nId, tbClass in pairs(tbFatherClass[self.nFatherClass + 1].tbChild) do
		if (ComboBoxAddItem(self.UIGROUP, COMBOBOX_CHILD, nId, tbClass.szName) == 1) then
			nItemCount = nItemCount + 1;
		end
	end	
	
	return nItemCount;
end

function uiMsgBoard:OnOpen(szMsg, szSourceText)
	if (IVER_g_nTwVersion == 1) then
		local szGM_TW_URL = "http://service.gameflier.com/bug/bug_intro.asp";
		OpenWebSite(szGM_TW_URL);
		return 0;
	end

	-- Ìî³äÏÂÀ­²Ëµ¥
	self:OnUpdateBasic();
	self.nFatherClass = 0;
	self.nChildClass = 0;
	self.tbClassTemp = INFO_TABLE;
	self.szAppealMsg = szMsg or ""	--Í¶ËßÐÅÏ¢
	self.szSourceText = szSourceText;
	if (szSourceText) then
		Wnd_SetEnable(self.UIGROUP, EDT_SERVER, 0);
		Wnd_SetEnable(self.UIGROUP, EDT_ACCOUNT, 0);
		Wnd_SetEnable(self.UIGROUP, EDT_NAME, 0);
		Wnd_SetEnable(self.UIGROUP, EDT_LEVEL, 0);
		Wnd_SetEnable(self.UIGROUP, EDT_DESCRIPT, 0);
		Edt_SetTxt(self.UIGROUP, EDT_DESCRIPT, self.szAppealMsg);
		self.tbClassTemp = PUT_INFO_TABLE;
	end
	
	local nItemCount = self:FillComboBoxFather(self.tbClassTemp);
	if (nItemCount <= 0) then
		return 0;
	end
	nItemCount = self:FillComboBoxChild(self.tbClassTemp);
	if (nItemCount <= 0) then
		return 0;
	end

	ComboBoxSelectItem(self.UIGROUP, COMBOBOX_FATHER, self.nFatherClass);
	ComboBoxSelectItem(self.UIGROUP, COMBOBOX_CHILD, self.nChildClass);
	Txt_SetTxt(self.UIGROUP, TXT_HELP_DESCRIPT,	self.tbClassTemp[self.nFatherClass + 1].tbChild[self.nChildClass + 1].szDescript);
	
end

-- µã»÷¿ì½Ý°´¼ü´¦Àí
function uiMsgBoard:OnButtonClick(szWnd, nParam)
	if szWnd ==	BTN_CANCEL then
		UiManager:CloseWindow(self.UIGROUP);
	elseif szWnd ==	BTN_CLOSE then
		UiManager:CloseWindow(self.UIGROUP);
	elseif szWnd == BTN_ACCEPT then
		local nNowDate = tonumber(GetLocalDate("%y%m%d%H%M%S"))
		if tbDate[me.nId] == nil then
			tbDate[me.nId] = 0;
		end
		if (nNowDate - tbDate[me.nId]) < 5 then
			Dialog:Say("Mỗi 5 phút chỉ được nhắn tin 1 lần.")
			UiManager:CloseWindow(self.UIGROUP);
			return 0;
		end

		local szServer = Edt_GetTxt(self.UIGROUP, EDT_SERVER);
		local szAccount = Edt_GetTxt(self.UIGROUP, EDT_ACCOUNT);
		local szName = Edt_GetTxt(self.UIGROUP, EDT_NAME);
		local nLevel = tonumber(Edt_GetTxt(self.UIGROUP, EDT_LEVEL));
		local szDescript = self.szSourceText or Edt_GetTxt(self.UIGROUP, EDT_DESCRIPT);
		local szClassFather = self.tbClassTemp[self.nFatherClass + 1].szName
		local szClassChild = self.tbClassTemp[self.nFatherClass + 1].tbChild[self.nChildClass + 1].szName
		if szAccount == "(Tài khoản)" then
			szAccount = me.szAccount;
		end
		
		if string.len(szServer) <= 2 then
			Dialog:Say("Nhập chính xác tên cụm máy.");
			return 0;	
		end	
		if string.len(szAccount) <= 2 then
			Dialog:Say("Nhập chính xác tên tài khoản.");
			return 0;			
		end	
		if string.len(szName) <= 2 then
			Dialog:Say("Nhập chính xác tên nhân vật.");
			return 0;			
		end
		if type(nLevel) ~= "number" then
			Dialog:Say("Cấp phải là con số.");
			return 0;
		end
		if (string.len(szDescript) <= 10 and not self.szSourceText) then
			Dialog:Say("Nhập vào");
			return 0;
		end
		me.SendMsgBoard(szServer,szAccount,szName,nLevel,szClassFather,szClassChild, szDescript);
		tbDate[me.nId] = nNowDate;
		UiManager:CloseWindow(self.UIGROUP);
	end
end

-- ÏÂÀ­²Ëµ¥¸Ä±ä
function uiMsgBoard:OnComboBoxIndexChange(szWnd, nIndex)
	if (szWnd == COMBOBOX_FATHER) then
		self.nFatherClass = nIndex;
		self.nChildClass = 0;
		ComboBoxSelectItem(self.UIGROUP, COMBOBOX_CHILD, self.nChildClass);
		self:FillComboBoxChild(self.tbClassTemp);
		Txt_SetTxt(self.UIGROUP, TXT_HELP_DESCRIPT,	self.tbClassTemp[self.nFatherClass + 1].tbChild[self.nChildClass + 1].szDescript);
	elseif (szWnd == COMBOBOX_CHILD) then
		self.nChildClass = nIndex;
		Txt_SetTxt(self.UIGROUP, TXT_HELP_DESCRIPT,	self.tbClassTemp[self.nFatherClass + 1].tbChild[self.nChildClass + 1].szDescript);
	end	
end

function uiMsgBoard:OpenBoardForReport(szName, szMsg, szSourceText)
	
	UiManager:OpenWindow(Ui.UI_MSGBOARD, szName .. ":" .. szMsg, szName .. ":" .. szSourceText);
end

function uiMsgBoard:RegisterEvent()
	local tbRegEvent =
	{
		{ UiNotify.emCOREEVENT_REPORT_SOMEONE,	self.OpenBoardForReport },
	};
	return tbRegEvent;
end
