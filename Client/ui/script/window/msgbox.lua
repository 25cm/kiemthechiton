-----------------------------------------------------
--ÎÄ¼þÃû		£º	msgbox.lua
--´´½¨Õß		£º	tongxuehu@kingsoft.net
--´´½¨Ê±¼ä		£º	2007-5-6
--¹¦ÄÜÃèÊö		£º	ÏûÏ¢È·ÈÏÐ¡´°¿Ú
------------------------------------------------------

local tbMsgBox = Ui:GetClass("msgbox");
local tbTimer = Ui.tbLogic.tbTimer;

local TXT_MSG 			= "TxtMsg";
local TXT_TITLE			= "TxtTitle";
local BTN_OPTION		= "BtnOption";

local TIMER_TICK		= Env.GAME_FPS;		-- ¶¨Ê±Æ÷×îÐ¡µ¥Î»£¬1Ãë
local MAX_OPTION_NUMBER	= 3;
local TIMEOUT_LIMIT		= 5;

----------------------------------------------------------------------------------------
--                MsgBoxÍ¨¹Ø¹¥ÂÔ
-- µ÷ÓÃ·½Ê½£º UiManager:OpenWindow(Ui.UI_MSGBOX, tbMsg, ...);
-- tbMsg²ÎÊýÏê½â£º
-- tbMsg.szMsg		±ØÌî	ÏÔÊ¾µÄÏûÏ¢
-- tbMsg.szTitle	¿ÉÑ¡	±êÌâÎÄ×Ö
-- tbMsg.bExclusive	¿ÉÑ¡	ÊÇ·ñ¶ÀÕ¼´°¿Ú£¬Ä¬ÈÏÎª¶ÀÕ¼
-- tbMsg.tbPos		¿ÉÑ¡	´°¿ÚµÄ³õÊ¼Î»ÖÃ¡£Àý£ºtbPos = { 203, 426 } Ôò´°¿ÚÎ»ÖÃÎª203,426
-- tbMsg.nOptCount  ¿ÉÑ¡    ¶¨Òå´°¿ÚÉÏÑ¡Ïî¸öÊý£¬Ä¿Ç°Ö§³Ö×î´óMAX_BTN_NUMBER¸ö£¬Ä¬ÈÏÎª2
-- tbMsg.tbOptTitle	¿ÉÑ¡    Ñ¡ÏîÃû×Ö±í, ±ÈÈç tbOptTitle[2] = "È·¶¨"
-- tbMsg.nTimeout   ¿ÉÑ¡	³¬Ê±Ê±¼ä£¨Ãë£©£¬Èç¹û³¬Ê±£¬Ôòµ÷ÓÃÉè¶¨µÄCallback£¬Ñ¡ÏîË÷ÒýÎª0
-- tbMsg:Callback	¿ÉÑ¡	µã»÷°´Å¥ºóµÄ»Øµ÷º¯Êý£¬ÆäÖÐµÚÒ»¸ö²ÎÊýÎªÑ¡ÏîË÷Òý£¨´Ó1¿ªÊ¼£©£¬ºóÐø²ÎÊýÎª×Ô¶¨Òå
--
----------------------------------------------------------------------------------------

function tbMsgBox:Init()
	self.tbMsg		= nil;
	self.tbArgs		= {};
	self.nTimerId	= 0;
end

function tbMsgBox:OnOpen(tbMsg, ...)

	if (not tbMsg) or (not tbMsg.szMsg) then
		return 0;
	end

	self.tbMsg  = tbMsg;
	self.tbArgs = arg;
	
	if (not tbMsg.szTitle) then
		tbMsg.szTitle = "Nhắc nhở";
	end
	
	if (not tbMsg.bExclusive) or (tbMsg.bExclusive == 1) then
		tbMsg.bExclusive = 1;
	else
		tbMsg.bExclusive = 0;
	end

	if (not tbMsg.nOptCount) or (tbMsg.nOptCount < 1) or (tbMsg.nOptCount > MAX_OPTION_NUMBER) then
		tbMsg.nOptCount = 2;
	end

	if (not tbMsg.tbOptTitle) then
		tbMsg.tbOptTitle = {};
	end

	if (tbMsg.nOptCount == 1) then
		if (not tbMsg.tbOptTitle[1]) then
			tbMsg.tbOptTitle[1] = "Đồng ý";
		end
	elseif (tbMsg.nOptCount == 2) then
		if (not tbMsg.tbOptTitle[1]) then
			tbMsg.tbOptTitle[1] = "Hủy";
		end
		if (not tbMsg.tbOptTitle[2]) then
			tbMsg.tbOptTitle[2] = "Đồng ý";
		end
	elseif (tbMsg.nOptCount == 3) then
		if (not tbMsg.tbOptTitle[1]) then
			tbMsg.tbOptTitle[1] = "Dừng";
		end
		if (not tbMsg.tbOptTitle[2]) then
			tbMsg.tbOptTitle[2] = "Thử lại";
		end
		if (not tbMsg.tbOptTitle[3]) then
			tbMsg.tbOptTitle[3] = "Bỏ qua";
		end
	end

	if (tbMsg.bExclusive == 1) then
		UiManager:SetExclusive(self.UIGROUP, 1);			-- ÉèÖÃÎª¶ÀÕ¼
	end

	Txt_SetTxt(self.UIGROUP, TXT_TITLE, tbMsg.szTitle);		-- ÉèÖÃ±êÌâÎÄ×Ö

	-- ÉèÖÃ°´Å¥ÏÔÊ¾
	for i = 1, MAX_OPTION_NUMBER do
		local szBtn = BTN_OPTION..i;
		Btn_SetTxt(self.UIGROUP, szBtn, tbMsg.tbOptTitle[i] or "");
		if (i <= tbMsg.nOptCount) then
			Wnd_Show(self.UIGROUP, szBtn);
		else
			Wnd_Hide(self.UIGROUP, szBtn);
		end
	end

	if tbMsg.tbPos and (#tbMsg.tbPos == 2) then
		Wnd_SetPos(self.UIGROUP, unpack(tbMsg.tbPos));	-- ÉèÖÃ´°¿ÚµÄ³õÊ¼Î»ÖÃ
	end

	if (not tbMsg.nTimeout) then
		tbMsg.nTimeout = 0;
	end

	if (tbMsg.nTimeout > 0) then
		self.nTimerId = tbTimer:Register(TIMER_TICK, self.OnTimer, self);	-- ¿ªÆô¶¨Ê±Æ÷£¬¶¨Ê±1Ãë
	end

	self:UpdateMsg();
	return 1;

end

function tbMsgBox:OnClose()
	if (self.nTimerId > 0) then
		tbTimer:Close(self.nTimerId);
		self.nTimerId = 0;
	end
	if (self.tbMsg.bExclusive == 1) then
		UiManager:SetExclusive(self.UIGROUP, 0);			-- È¡Ïû¶ÀÕ¼×´Ì¬
	end
end

function tbMsgBox:OnButtonClick(szWnd, nParam)
	local tbMsg = self.tbMsg;
	local _, _, szIndex = string.find(szWnd, BTN_OPTION.."(%d+)");
	if (not szIndex) then
		return;
	end
	local nIndex = tonumber(szIndex);
	if tbMsg.Callback then
		tbMsg:Callback(nIndex, unpack(self.tbArgs));
	end
	UiManager:CloseWindow(self.UIGROUP);	-- °´ÏÂ°´Å¥±ØÈ»»á¹Ø±Õ×Ô¼º
end

function tbMsgBox:OnTimer()
	local tbMsg = self.tbMsg;
	tbMsg.nTimeout = tbMsg.nTimeout - 1;
	if (tbMsg.nTimeout <= 0) then
		if (self.nTimerId > 0) then
			tbTimer:Close(self.nTimerId);
			self.nTimerId = 0;
		end
		if tbMsg.Callback then
			tbMsg:Callback(0, unpack(self.tbArgs));
		end
		UiManager:CloseWindow(self.UIGROUP);
	else
		self:UpdateMsg();
	end
end

function tbMsgBox:UpdateMsg()
	local tbMsg = self.tbMsg;
	local szMsg = tbMsg.szMsg;
	if (tbMsg.nTimeout > 0) then
		szMsg = string.format(
			"%s  ... [<color=%s>%d<color>]",
			szMsg,
			(tbMsg.nTimeout < TIMEOUT_LIMIT) and "red" or "green",
			tbMsg.nTimeout
		);
	end
	Txt_SetTxt(self.UIGROUP, TXT_MSG, szMsg);	-- ÉèÖÃÐÅÏ¢ÎÄ×Ö
end
