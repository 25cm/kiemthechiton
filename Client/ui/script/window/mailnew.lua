-----------------------------------------------------
--ÎÄ¼þÃû		£º	mailnew.lua
--´´½¨Õß		£º	tongxuehu@kingsoft.net
--´´½¨Ê±¼ä		£º	2007-06-02
--¹¦ÄÜÃèÊö		£º	ÐÅ¼þ½çÃæ½Å±¾¡£
------------------------------------------------------

local uiMailNew = Ui:GetClass("mailnew");
local tbObject  = Ui.tbLogic.tbObject;
local tbMouse   = Ui.tbLogic.tbMouse;

uiMailNew.CLOSE_WINDOW_BUTTON	= "BtnClose";
uiMailNew.SEND_MAIL_BUTTON		= "BtnSendMail";
uiMailNew.SELECT_MAIL_RECEIVER	= "BtnSelectTo";
uiMailNew.MAIL_TITLE_EDIT		= "EdtMailTitle";
uiMailNew.MAIL_TO_EDIT			= "EdtTo";
uiMailNew.MAIL_CONTENT_EDIT		= "EdtContent";
uiMailNew.MAIL_MONEY_EDIT		= "EdtMoney";
uiMailNew.MAIL_ITEM_OBJECT		= "ObjItem";
uiMailNew.MAIL_SEND_COST		= "TxtSendCost";

function uiMailNew:Init()
	self.nMoney    = 0;
	self.tbObj     = nil;
	self.tbExitObj = nil;
end

local tbMailCont = { bShowCd = 0, bUse = 0, bLink = 0, nRoom = Item.ROOM_MAIL };	-- ²»ÏÔÊ¾CDÌØÐ§£¬²»¿ÉÊ¹ÓÃ£¬²»¿ÉÁ´½Ó

function tbMailCont:CheckSwitchItem(pDrop, pPick, nX, nY)
	if not pDrop then
		return 1;
	end
	if (pDrop.IsForbitTrade() == 1) then
		me.Msg("Vật phẩm thuộc loại không thể giao dịch, không thể đính kèm theo thư!");
		tbMouse:ResetObj();
		return 0;
	end
	return 1;
end

function uiMailNew:OnCreate()
	self.tbMailCont = tbObject:RegisterContainer(self.UIGROUP, self.MAIL_ITEM_OBJECT, 1, 1, tbMailCont, "itemroom");
end

function uiMailNew:OnDestroy()
	tbObject:UnregContainer(self.tbMailCont);
end

function uiMailNew:OnClose()
	self.tbMailCont:ClearRoom();
	UiManager:ReleaseUiState(UiManager.UIS_MAIL_NEW);
end

function uiMailNew:OnOpen(tbParam)

	UiManager:SetUiState(UiManager.UIS_MAIL_NEW);

	Edt_SetTxt(self.UIGROUP, self.MAIL_CONTENT_EDIT, "");
	Edt_SetTxt(self.UIGROUP, self.MAIL_TO_EDIT, "");
	Edt_SetTxt(self.UIGROUP, self.MAIL_TITLE_EDIT, "");
	Edt_SetInt(self.UIGROUP, self.MAIL_MONEY_EDIT, 0);
	Wnd_SetFocus(self.UIGROUP, self.MAIL_TITLE_EDIT);

	if tbParam and tbParam.szSender then
		Edt_SetTxt(self.UIGROUP, self.MAIL_TITLE_EDIT, tbParam.szTitle);
		Edt_SetTxt(self.UIGROUP, self.MAIL_TO_EDIT, tbParam.szSender);
	end
	local nCost = me.GetMailCost();
	Txt_SetTxt(self.UIGROUP, self.MAIL_SEND_COST, "Chi phí gửi: "..Item:FormatMoney(nCost).."Bạc");

end

function uiMailNew:OnMailItemChangedCallback(nAction, uGenre, uId)
	if nAction > 0 then
		ObjBox_HoldObject(self.UIGROUP, self.MAIL_ITEM_OBJECT, uGenre, uId);
	else
		self.tbMailCont:SetObj(nil);
	end
end

function uiMailNew:OnButtonClick(szWnd, nParam)
	if szWnd == self.CLOSE_WINDOW_BUTTON then
		UiManager:CloseWindow(self.UIGROUP);
	elseif szWnd == self.SELECT_MAIL_RECEIVER then
		UiManager:OpenWindow(Ui.UI_RELATION);
	elseif szWnd == self.SEND_MAIL_BUTTON then
		if (Mail.nMailCount >= 20) then
			me.Msg("Gửi thư thất bại! Hộp thư có hơn 20 lá, phải xóa bớt!");
			return;
		end
		
		local nMoney = Edt_GetInt(self.UIGROUP, self.MAIL_MONEY_EDIT);
		local tbAttachment = self.tbMailCont:GetObj();
		
		if nMoney > 0 or tbAttachment ~= nil then 
	     
	    local tbMsg = {};
		  tbMsg.szMsg = "    <color=white>Hãy xác nhận số bạc và vật phẩm cần gởi.<color><enter><color=green>Hộp thư không có tính năng nhật ký giao dịch, cần cẩn thận!<color>";
		  tbMsg.nOptCount = 2;
		  function tbMsg:Callback(nOptIndex,fnAccept, tbSelf)
			  if (nOptIndex == 1) then
				  return
		  	elseif (nOptIndex == 2) then
			  	fnAccept(tbSelf);
		  	end
	  	end
		  UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg, self.SendMail, self);
		else
      self:SendMail();
    end
	end
end

function uiMailNew:SendMail()

	local szTitle = Edt_GetTxt(self.UIGROUP, self.MAIL_TITLE_EDIT);
	local szTo = Edt_GetTxt(self.UIGROUP, self.MAIL_TO_EDIT);
	local szContent = Edt_GetTxt(self.UIGROUP, self.MAIL_CONTENT_EDIT);
	local nMoney = Edt_GetInt(self.UIGROUP, self.MAIL_MONEY_EDIT);
	
	if (szTo and szTo == "") then
		me.Msg("Chưa điền tên người nhận.");
		return;
	end
	
	local bRet = me.HasRelation(szTo, 2);
	if (bRet ~= 1) then
		me.Msg("Đối tượng không phải hảo hữu chính thức, không thể gửi thư!");
		return;
	end
	if (me.nCashMoney < nMoney + me.GetMailCost()) then
		me.Msg("Không đủ tiền, gửi thư thất bại!");
		return;
	end
	if #szTitle > 0 and #szTo > 0 and #szContent > 0 then
		local nRetCode = 0;
		if (me.SendMail(szTo, szTitle, szContent, 0, nMoney) == 1) then
			UiManager:CloseWindow(self.UIGROUP);
		else
			me.Msg("Thông tin không đúng, gửi thư thất bại!");
		end
	else
		me.Msg("Xin điền đầy đủ thông tin!");
	end

end

function uiMailNew:OnEditChange(szWnd, nParam)
    if szWnd == self.MAIL_MONEY_EDIT then
		local nNum = Edt_GetInt(self.UIGROUP, self.MAIL_MONEY_EDIT);
		if nNum == self.nMoney then		-- ·ÀÖ¹ËÀÑ­»·
    		return;
    	end
    	if nNum < 0 then
    		nNum = 0;
    	elseif nNum > me.nCashMoney then
			nNum = me.nCashMoney;
		end
		self.nMoney = nNum;
		Edt_SetInt(self.UIGROUP, self.MAIL_MONEY_EDIT, nNum);
    end
end

function uiMailNew:SetReceiver(szPlayer)
	Edt_SetTxt(self.UIGROUP, self.MAIL_TO_EDIT, szPlayer);
end

function uiMailNew:RegisterEvent()
	return self.tbMailCont:RegisterEvent();
end

function uiMailNew:RegisterMessage()
	return self.tbMailCont:RegisterMessage();
end
