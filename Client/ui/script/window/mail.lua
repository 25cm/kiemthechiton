-----------------------------------------------------
--ÎÄ¼þÃû		£º	mail.lua
--´´½¨Õß		£º	tongxuehu@kingsoft.net
--´´½¨Ê±¼ä		£º	2007-06-01
--¹¦ÄÜÃèÊö		£º	ÐÅ¼þ½çÃæ½Å±¾¡£
------------------------------------------------------

local uiMail = Ui:GetClass("mail");

uiMail.CLOSE_WINDOW_BUTTON	= "BtnClose";
uiMail.LIST_MAIL			= "LstMail";
uiMail.BUTTON_OPEN_MAIL		= "BtnOpenMail";
uiMail.BUTTON_NEW_MAIL		= "BtnNewMail";
uiMail.MAX_MAIL_NUMBER		= 20;

-- ±íÇé·ûÐòºÅ£¬ÔÚ\setting\chat\chatface.iniÖÐ¶¨Òå
uiMail.MAIL_STATE_ICON		= { 140, 141, 142, 143 } -- { Î´¶Á£¬ÒÑ¶Á£¬ÍËÐÅ£¬±£´æ }

function uiMail:Init()
	self.tbMailList		= {};
	self.nRefreshFlag	= 0;
	self.nNewMailFlag 	= 0;
end

function uiMail:OnOpen()
	Mail:RequestMailList(Mail.MAILCONDTYPE);
	--Ð´log
	Log:Ui_SendLog("Mở hộp thư", 1);
	
	if Mail.nMailCount >= self.MAX_MAIL_NUMBER then
		me.Msg("Hộp thư đã đầy, có thể dẫn đến thất lạc các thư mới, hãy xóa các thư không cần thiết. Hộp thư đầy không thể gửi thư mới!");
	end
end

function uiMail:RequestMailList(nType)
	if self.nRefreshFlag ~= 1 then
		Lst_Clear(self.UIGROUP, self.LIST_MAIL);
		Mail:RequestMailList(nType);
		self.nRefreshFlag = 1;
	end
end

function uiMail:RefreshMailList(nType)
	self.nRefreshFlag = 0;
	self:RequestMailList(nType);
end

function uiMail:OnMailLoaded()
	self:RefreshMailList(Mail.MAILOTHERTYPE);
end

function uiMail:OnMailSendOk()
	me.Msg("Gửi thư thành công!");
end

function uiMail:OnMailSendFail()
	me.Msg("Gửi thư thất bại!");
end

function uiMail:OnMailNew()
	me.Msg("Có thư mới!");
	SetNewMailFlag(1);
	self.nNewMailFlag = 1;
	if (UiManager:WindowVisible(Ui.UI_MAIL) ~= 0) then
		Mail:RequestMailList(Mail.MAILCONDTYPE);
	else
		self:RefreshMailList(Mail.MAILOTHERTYPE);
	end
end

function uiMail:OnButtonClick(szWnd, nParam)
	if (szWnd == self.CLOSE_WINDOW_BUTTON) then
		UiManager:CloseWindow(self.UIGROUP);
	elseif (szWnd == self.BUTTON_OPEN_MAIL) then
		self:OnOpenMail();
	elseif (szWnd == self.BUTTON_NEW_MAIL) then
		Mail:RequestOpenNewMail();
	end
end

function uiMail:OnListDClick(szWnd, nParam)
	if (szWnd == self.LIST_MAIL) then
		self:OnOpenMail();
	end
end

function uiMail:OnOpenMail()
	local nMailId = Lst_GetCurKey(self.UIGROUP, self.LIST_MAIL);
	local tbMail = self.tbMailList[nMailId];
	if (not tbMail) then
		return;
	end
	self.nType = tbMail.nType;
	
	Mail:RequireMail(nMailId, tbMail.byClient);
end

function uiMail:DeleteMail(nMailId)
	if self.tbMailList[nMailId] then
		Mail:DeleteMailRequest(nMailId, self.tbMailList[nMailId].byClient);
		self.tbMailList[nMailId] = nil;
	end
end

function uiMail:OnShowMailList()

	local tbTempTable	= me.GetTempTable("Mail");
	local tbList 		= tbTempTable.tbMailList;
	local nNewMailFlag	= 0;

	Lst_Clear(self.UIGROUP, self.LIST_MAIL);

	for i, v in pairs(tbTempTable.tbMailListID) do
		self.tbMailList[i] = v;
	end

	local nMax = (Mail.nMailCount >= 20) and 20 or Mail.nMailCount;
	local nStart = 0;

	if (Mail.nMailCount >= 20) then
		nStart = Mail.nMailCount - 20;
	end
	local bHaveBackMail = 0;
	for i = 1, nMax do
		local tbMail  = tbList[nStart + i];
		local szTitle =  "";
		if (tbMail.nType ~= 1) then
			szTitle = "Tiêu đề: <color=red>"..tbMail.szCaption.."<color>\nĐến từ:<color=red>"..tbMail.szSender .. "<color>";
		else
			szTitle = "Tiêu đề: "..tbMail.szCaption.."\nĐến từ:"..tbMail.szSender;
		end
		Lst_SetCell(self.UIGROUP, self.LIST_MAIL, tbMail.nId, 1, "<pic="..self.MAIL_STATE_ICON[tbMail.nState + 1]..">");
		Lst_SetCell(self.UIGROUP, self.LIST_MAIL, tbMail.nId, 2, szTitle);
		Lst_SetCell(self.UIGROUP, self.LIST_MAIL, tbMail.nId, 3, tbMail.nTime.."Ngày");
		if (tbMail.nState == 0) then
			nNewMailFlag = 1;
		elseif (tbMail.nState == 2) then
			bHaveBackMail = 1;
		end
	end

	if (nNewMailFlag == 1) or (self.nNewMailFlag == 1) then
		SetNewMailFlag(1);
	else
		SetNewMailFlag(0);
	end
	self.nNewMailFlag = 0;
	if (bHaveBackMail == 1) then
		me.Msg("Bạn có thư bị trả về.");
	end
	if (Mail.nMailCount >= 20) then
		SetNewMailFlag(1);
		local szMsg = "Hộp thư đã đầy, hãy xóa các thư cũ";
		UiManager:OpenWindow(Ui.UI_INFOBOARD, szMsg);
	end
end

-----------------------------------------------------------

function uiMail:RegisterEvent()
	local tbRegEvent =
	{
		{ UiNotify.emCOREEVENT_MAIL_LOADED,		self.OnMailLoaded },
		{ UiNotify.emCOREEVENT_MAIL_SENDOK,		self.OnMailSendOk },
		{ UiNotify.emCOREEVENT_MAIL_SENDFAIL, 	self.OnMailSendFail },
		{ UiNotify.emCOREEVENT_MAIL_NEWMAIL, 	self.OnMailNew },
		{ UiNotify.emCOREEVENT_SYNC_MAIL_LIST, 	self.OnShowMailList },
	};
	return tbRegEvent;
end

-----------------------------------------------------------
