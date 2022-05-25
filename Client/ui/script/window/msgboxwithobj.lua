-----------------------------------------------------
--ÎÄ¼þÃû		£º	msgboxwithobj.lua
--´´½¨Õß		£º	zhangjianyu(lucifer~yu)
--´´½¨Ê±¼ä		£º	2008-10-13
--¹¦ÄÜÃèÊö		£º	ÏûÏ¢È·ÈÏÐ¡´°¿Ú
------------------------------------------------------

local tbMsgBoxWithObj = Ui:GetClass("msgboxwithobj");
local tbTimer = Ui.tbLogic.tbTimer;
local tbObject  = Ui.tbLogic.tbObject;

local TXT_MSG 			= "TxtMsg";
local TXT_TITLE			= "TxtTitle";
local BTN_OPTION		= "BtnOption";
local OBJ_OBJ				= "Obj";
local OBJ_NAME				= "ObjName";
local OBJ_EDIT			= "ObjEdit";
local TIMER_TICK		= Env.GAME_FPS;		-- ¶¨Ê±Æ÷×îÐ¡µ¥Î»£¬1Ãë
local MAX_OPTION_NUMBER	= 3;
local TIMEOUT_LIMIT		= 5;
local CLOSED_EVENT		= 99;

local tbViewGoodCont = { bShowCd = 0, bUse = 0 };
function tbViewGoodCont:CheckMouse(tbMouseObj)
	return 0;
end
function tbViewGoodCont:ClickMouse(tbObj, nX, nY)
	return 0;
end

----------------------------------------------------------------------------------------
--                MsgBoxÍ¨¹Ø¹¥ÂÔ
-- µ÷ÓÃ·½Ê½£º UiManager:OpenWindow(Ui.UI_MSGBOXWITHOBJ, tbMsg, ...);
-- tbMsg²ÎÊýÏê½â£º
-- tbMsg.szMsg		±ØÌî	ÏÔÊ¾µÄÏûÏ¢
-- tbMsg.tgObj		±ØÌî	ÏÔÊ¾µÄobj
-- tbMsg.szObjName±ØÌî	ÏÔÊ¾µÄobjÃû×Ö
-- tbMsg.szObjEdt±ØÌî	
-- tbMsg.bObjEdt±ØÌî	
-- tbMsg.szTitle	¿ÉÑ¡	±êÌâÎÄ×Ö
-- tbMsg.bExclusive	¿ÉÑ¡	ÊÇ·ñ¶ÀÕ¼´°¿Ú£¬Ä¬ÈÏÎª¶ÀÕ¼
-- tbMsg.tbPos		¿ÉÑ¡	´°¿ÚµÄ³õÊ¼Î»ÖÃ¡£Àý£ºtbPos = { 203, 426 } Ôò´°¿ÚÎ»ÖÃÎª203,426
-- tbMsg.nOptCount  ¿ÉÑ¡    ¶¨Òå´°¿ÚÉÏÑ¡Ïî¸öÊý£¬Ä¿Ç°Ö§³Ö×î´óMAX_BTN_NUMBER¸ö£¬Ä¬ÈÏÎª2
-- tbMsg.tbOptTitle	¿ÉÑ¡    Ñ¡ÏîÃû×Ö±í, ±ÈÈç tbOptTitle[2] = "È·¶¨"
-- tbMsg.nTimeout   ¿ÉÑ¡	³¬Ê±Ê±¼ä£¨Ãë£©£¬Èç¹û³¬Ê±£¬Ôòµ÷ÓÃÉè¶¨µÄCallback£¬Ñ¡ÏîË÷ÒýÎª0
-- tbMsg.bClose   	¿ÉÑ¡	ÊÇ·ñ¹Ø±Õ×Ô¼º
-- tbMsg:Callback	¿ÉÑ¡	µã»÷°´Å¥ºóµÄ»Øµ÷º¯Êý£¬ÆäÖÐµÚÒ»¸ö²ÎÊýÎªÑ¡ÏîË÷Òý£¨´Ó1¿ªÊ¼£©£¬ºóÐø²ÎÊýÎª×Ô¶¨Òå
--
----------------------------------------------------------------------------------------

function tbMsgBoxWithObj:Init()
	self.tbMsg		= nil;
	self.tbArgs		= {};
	self.nTimerId	= 0;
	self.bClose		= 1;
end

function tbMsgBoxWithObj:OnCreate()
	self.tbViewGoodCont = tbObject:RegisterContainer(self.UIGROUP, OBJ_OBJ, 1, 1, tbViewGoodCont);
end

function tbMsgBoxWithObj:OnDestroy()
	tbObject:UnregContainer(self.tbViewGoodCont);
end

function tbMsgBoxWithObj:OnOpen(tbMsg, ...)

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

	if (tbMsg.bClose and tbMsg.bClose == 0) then
		self.bClose = 0;
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
	
	self.tbViewGoodCont:ClearObj();
	if (tbMsg.tgObj ~= nil) then
		self.tbViewGoodCont:SetObj(tbMsg.tgObj);
	end
	
	if (tbMsg.szObjEdt ~= nil and tbMsg.szObjEdt ~= "") then
		Edt_SetTxt(self.UIGROUP, OBJ_EDIT, tbMsg.szObjEdt);		-- ÉèÖÃ±êÌâÎÄ×Ö
	end	
	if (tbMsg.bObjEdt == 1) then
		Wnd_SetEnable(self.UIGROUP, OBJ_EDIT, 1);
		Img_SetImage(self.UIGROUP,"Main",1,"\\image\\ui\\001a\\auction\\auctiondialog.spr");
	else
		Wnd_SetEnable(self.UIGROUP, OBJ_EDIT, 0);
		Img_SetImage(self.UIGROUP,"Main",1,"\\image\\ui\\001a\\auction\\auctiondialog0.spr");
	end
	
	if (tbMsg.szObjEdtTxt ~= nil and tbMsg.szObjEdtTxt ~= "") then
		Txt_SetTxt(self.UIGROUP, "TxtObjEdt", tbMsg.szObjEdtTxt);		-- ÉèÖÃ±êÌâÎÄ×Ö
	end
	
	if (tbMsg.szObjName ~= "" and tbMsg.szObjName ~= nil) then
		Txt_SetTxt(self.UIGROUP, OBJ_NAME, tbMsg.szObjName);		-- ÉèÖÃ±êÌâÎÄ×Ö
	end

	self:UpdateMsg();
	return 1;

end

function tbMsgBoxWithObj:OnClose()
	
	local tbMsg = self.tbMsg;
	if tbMsg.Callback then
		tbMsg:Callback(CLOSED_EVENT, self, unpack(self.tbArgs));
	end
	
	self.tbViewGoodCont:ClearObj();	
	if (self.nTimerId > 0) then
		tbTimer:Close(self.nTimerId);
		self.nTimerId = 0;
	end
	if (self.tbMsg.bExclusive == 1) then
		UiManager:SetExclusive(self.UIGROUP, 0);			-- È¡Ïû¶ÀÕ¼×´Ì¬
	end
end

function tbMsgBoxWithObj:OnButtonClick(szWnd, nParam)
	if (szWnd == "BtnOption1" or szWnd == "BtnClose") then
		UiManager:CloseWindow(self.UIGROUP);
		return;
	end

	local tbMsg = self.tbMsg;
	local _, _, szIndex = string.find(szWnd, BTN_OPTION.."(%d+)");
	if (not szIndex) then
		return;
	end
	local nIndex = tonumber(szIndex);
	if tbMsg.Callback then
		tbMsg:Callback(nIndex, self, unpack(self.tbArgs));
	end
	if self.bClose == 1 then
		UiManager:CloseWindow(self.UIGROUP);	-- °´ÏÂ°´Å¥±ØÈ»»á¹Ø±Õ×Ô¼º
	end
end

function tbMsgBoxWithObj:OnTimer()
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

function tbMsgBoxWithObj:UpdateMsg()
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

function tbMsgBoxWithObj:GetObjEdtInt()
	local nPrice = Edt_GetInt(self.UIGROUP,OBJ_EDIT)
	return nPrice;
end

function tbMsgBoxWithObj:RegisterEvent()
	local tbRegEvent = {};
	tbRegEvent = Lib:MergeTable(tbRegEvent, self.tbViewGoodCont:RegisterEvent());
	return tbRegEvent;
end

function tbMsgBoxWithObj:RegisterMessage()
	local tbRegMsg = {};		
	tbRegMsg = Lib:MergeTable(tbRegMsg, self.tbViewGoodCont:RegisterMessage());	
	return tbRegMsg;
end

function tbMsgBoxWithObj:OnEscExclusiveWnd(szWnd)
	UiManager:CloseWindow(self.UIGROUP);
end