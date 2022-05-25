-----------------------------------------------------
--ÎÄ¼þÃû		£º	mailview.lua
--´´½¨Õß		£º	tongxuehu@kingsoft.net
--´´½¨Ê±¼ä		£º	2007-06-02
--¹¦ÄÜÃèÊö		£º	ÐÅ¼þ½çÃæ½Å±¾¡£
------------------------------------------------------

local uiMailView = Ui:GetClass("mailview");
local tbObject = Ui.tbLogic.tbObject;

uiMailView.CLOSE_WINDOW_BUTTON	= "BtnClose";
uiMailView.DELETE_MAIL_BUTTON	= "BtnDelMail";
uiMailView.WRITE_BACK_BUTTON	= "BtnWriteBack";
uiMailView.FETCH_MONEY_BUTTON	= "BtnFetchMoney";

uiMailView.MAIL_TITLE_TEXT		= "TxtMailTitle";
uiMailView.MAIL_FROM_TEXT		= "TxtFrom";
uiMailView.MAIL_CONTENT_TEXT	= "TxtContent";
uiMailView.MAIL_CONTENT_TEXTEX	= "TxxContent";
uiMailView.MAIL_CONTENT_IMAGE	= "ImgContent";
uiMailView.MAIL_MONEY_TEXT		= "TxtMailMoney";
uiMailView.MAIL_ITEM_OBJECT		= "ObjItem";

-----------------------------------------------------------
-- tbMail±í²ÎÊý£º
--	nMailId,			[1]
--	nPicId,				[2]
--	szContent,			[3]
--	nMoney,				[4]
--  nItemCount,			[5]
--	nItemIdx			[6]

function uiMailView:Init()
	self.szSender  = "";
	self.szTitle   = "";
	self.nMoney    = 0;
	self.ItemIndex = 0;
	self.nMailType = 0;
end

local tbMailViewCont = { bShowCd = 0, bUse = 0 };

function tbMailViewCont:CheckMouse(tbMouseObj)
	return 0;
end

function tbMailViewCont:ClickMouse(tbObj, nX, nY)
	if (tbObj.nType ~= Ui.OBJ_ITEM) then
		return 0;
	end
	if (not self.nMailId) then
		return 0;
	end
	if me.CalcFreeSameItemCountInBags(tbObj.pItem) > 0 then
		--Ïò·þÎñÆ÷·¢ËÍ»ñÈ¡¸½¼þµÄÇëÇó	Á½¸ö²ÎÊý·Ö±ð±íÊ¾ÐÅ¼þID£¬µÚ¼¸¸ö¸½¼þ£¬Ä¿Ç°Ö»ÓÐÒ»¸ö¸½¼þ£¬¾ÍÓÃ0±íÊ¾
		me.CallServerScript({ "MailCmd", "ApplyProcess", self.nMailId, 0 });
	else
		me.Msg("Túi đã đầy!");
	end
	return 0;
end

function uiMailView:OnCreate()
	self.tbMailViewCont = tbObject:RegisterContainer(self.UIGROUP, self.MAIL_ITEM_OBJECT, 1, 1, tbMailViewCont);
end

function uiMailView:OnDestroy()
	tbObject:UnregContainer(self.tbMailViewCont);
end

function uiMailView:WriteStatLog()
	Log:Ui_SendLog("Kiểm tra thư", 1);
end

function uiMailView:OnOpen()
	self:WriteStatLog();	

	local tbTempTable = me.GetTempTable("Mail");
	local tbMail = tbTempTable.tbMailContent;
	local tbMailInfo = tbTempTable.tbMailListID[tbMail.nMailId];

	self.nMailType = tbMailInfo.nType;
	self:OnFetchItemOK();
	self:OnFetchMoneyOK();

	if tbMailInfo then
		Txt_SetTxt(self.UIGROUP, self.MAIL_TITLE_TEXT, "Tiêu đề: "..tbMailInfo.szCaption);
		local szSender = tbMail.szContent;
		if szSender then
			local nA1, nB1 = string.find(szSender, "<Sender>");
			if nA1 and nB1 then
				szSender = string.sub(szSender, nB1 + 1);
				local nA2, nB2 = string.find(szSender, "<Sender>");
				if nA2 and nB2 then
					if (((nB1 - nA1) == 7) and ((nB2 - nA2) == 7)) then
						tbMailInfo.szSender = string.sub(szSender, 1, nA2 - 1);
						tbMail.szContent = string.sub(szSender, nB2 + 1);
					end
				end
			end
		end

		Txt_SetTxt(self.UIGROUP, self.MAIL_FROM_TEXT, "Người gửi: "..tbMailInfo.szSender);
		if (self.nMailType == 0 or self.nMailType == 2) then	-- ÏµÍ³ÐÅ¼þ
			Txt_SetTxt(self.UIGROUP, self.MAIL_CONTENT_TEXT, "");
			TxtEx_SetText(self.UIGROUP, self.MAIL_CONTENT_TEXTEX, tbMail.szContent);
		else
			Txt_SetTxt(self.UIGROUP, self.MAIL_CONTENT_TEXT, tbMail.szContent);
			TxtEx_SetText(self.UIGROUP, self.MAIL_CONTENT_TEXTEX, "");
		end

		self.tbMailViewCont.nMailId = tbMail.nMailId;
		self.szTitle = tbMailInfo.szCaption;
		self.szSender = tbMailInfo.szSender;
		self.nMoney = tbMail.nMoney;
		self.ItemIndex = tbMail.nItemIdx;

		--[[
		local szImg = self:GetMailImage(tbMail.nPicId);
		Img_SetImage(self.UIGROUP, self.MAIL_CONTENT_IMAGE, 1, szImg);
		local _, nImgHeight = Wnd_GetSize(self.UIGROUP, self.MAIL_CONTENT_IMAGE);
		if nImgHeight then
			Wnd_SetPos(self.UIGROUP, self.MAIL_CONTENT_TEXT, 10, nImgHeight + 10);
			Wnd_SetPos(self.UIGROUP, self.MAIL_CONTENT_TEXTEX, 10, nImgHeight + 10);
		end
		--]]			
		if tbMail.nItemCount > 0 then
			local pItem = KItem.GetItemObj(tbMail.nItemIdx);
			local tbObj = nil;
			if pItem then
				tbObj = {};
				tbObj.nType = Ui.OBJ_ITEM;
				tbObj.pItem = pItem;
			end
			self.tbMailViewCont:SetObj(tbObj);
		end

		Wnd_SetEnable(self.UIGROUP, self.FETCH_MONEY_BUTTON, self.nMoney);
		Txt_SetTxt(self.UIGROUP, self.MAIL_MONEY_TEXT, Item:FormatMoney(self.nMoney));

	end

end

function uiMailView:OnClose()
	self.tbMailViewCont:ClearObj();
	Ui(Ui.UI_MAIL):RefreshMailList(Mail.MAILCONDTYPE);	-- Ë¢ÐÂÐÅ¼þ
end

function uiMailView:OnButtonClick(szWnd, nParam)
	if szWnd == self.CLOSE_WINDOW_BUTTON then
		UiManager:CloseWindow(self.UIGROUP);
	elseif szWnd == self.DELETE_MAIL_BUTTON then
		if self.tbMailViewCont then
			local tbObj = self.tbMailViewCont:GetObj();
			local szMoney = Txt_GetTxt(self.UIGROUP, self.MAIL_MONEY_TEXT);	-- TODO: xyf ×îºÃ±ðÒÀÀµ¿Ø¼þÊý¾Ý¶øÊÇ¶ÁCOREÊý¾Ý
			if tbObj or (tonumber(szMoney) ~= 0) then
				me.Msg("Không xóa được, trong thư có bạc hoặc đính kèm!");
				return;
			end
			
			local tbMsg = {};
			tbMsg.szMsg = "Thư đã xóa sẽ không thể phục hồi, xác định xóa?";
			tbMsg.nOptCount = 2;
			function tbMsg:Callback(nOptIndex, nMailId)
				if (nOptIndex == 2) then
					Ui(Ui.UI_MAIL):DeleteMail(nMailId);
					UiManager:CloseWindow(Ui.UI_MAILVIEW);
				end 
			end
			UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg, self.tbMailViewCont.nMailId);
		end
	elseif szWnd == self.WRITE_BACK_BUTTON then
		if (self.nMailType ~= 1 ) then
			me.Msg("Thư hệ thống không thể trả lời!");
			return;
		end

		local tbParam = {};
		tbParam.szTitle = "Trả lời"..self.szTitle;
		tbParam.szSender = self.szSender;
		if Mail:RequestOpenNewMail(tbParam) ~= 1 then
			return;
		end
		UiManager:OpenWindow(Ui.UI_MAILNEW, { "Trả lời"..self.szTitle, self.szSender });
		UiManager:CloseWindow(self.UIGROUP);
	elseif szWnd == self.FETCH_MONEY_BUTTON then
		if self.tbMailViewCont and (self.tbMailViewCont.nMailId > 0) then
			if self.nMoney + me.nCashMoney <= me.GetMaxCarryMoney() then
				me.MailFetchMoney(self.tbMailViewCont.nMailId);
				Wnd_SetEnable(self.UIGROUP, self.FETCH_MONEY_BUTTON, 0);
			else
				me.Msg("Bạc đem theo đã đạt mức tối đa!");
			end
		end
	end
end

function uiMailView:GetMailImage(nId)
	if nId > 0 then
		return KIo.GetPictureById(nId);
	else
		return "";
	end
end

function uiMailView:OnFetchItemOK()
	self.tbMailViewCont:ClearObj();
end

function uiMailView:OnFetchMoneyOK()
	Txt_SetTxt(self.UIGROUP, self.MAIL_MONEY_TEXT, Item:FormatMoney(0));
end

function uiMailView:RegisterEvent()
	local tbRegEvent =
	{
		{ UiNotify.emCOREEVENT_MAIL_FETCHITEMOK,	self.OnFetchItemOK },
		{ UiNotify.emCOREEVENT_MAIL_FETCHMONEYOK,	self.OnFetchMoneyOK },
	};
	tbRegEvent = Lib:MergeTable(tbRegEvent, self.tbMailViewCont:RegisterEvent());
	return tbRegEvent;
end

function uiMailView:RegisterMessage()
	local tbRegMsg = self.tbMailViewCont:RegisterMessage();
	return tbRegMsg;
end
