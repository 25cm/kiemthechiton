local uiChatTab = Ui:GetClass("chattab");
local tbMsgChannel = Ui.tbLogic.tbMsgChannel;

local tbTab2BtnCtlName = 
	{
		[tbMsgChannel.TAB_COMMON]			= "TabCommon",
		[tbMsgChannel.TAB_PRIVATE]			= "TabPrivate",
		[tbMsgChannel.TAB_FRIEND]			= "TabFriend",
		[tbMsgChannel.TAB_TONG	]			= "TabTongKin",
		[tbMsgChannel.TAB_OTHER	]			= "TabOther",
		[tbMsgChannel.TAB_CUSTOM]			= "TabCustom",
	};
	
	
local tbSwitchTabSort = {
	[1] = tbMsgChannel.TAB_COMMON,
	[2] = tbMsgChannel.TAB_PRIVATE,
	[3] = tbMsgChannel.TAB_TONG,
	[4] = tbMsgChannel.TAB_FRIEND,
	[5] = tbMsgChannel.TAB_OTHER,
	[6] = tbMsgChannel.TAB_CUSTOM
	}
	
local szBtnAutoScroll = "BtnAutoScrol";

local nFlashTimes = 4;

local tbMenu = 
	{
		[1] = "L?u th?ng tin",
		[2] = "X¨®a m¨¤n h¨¬nh",
	}


function uiChatTab:Init()
	self.nCurFlashTime = 0;
	self.szActiveTabName = "";
end

function uiChatTab:OnOpen()
	local bAutoScroll = Ui(Ui.UI_MSGPAD):GetAutoScroll();
	Btn_Check(self.UIGROUP, szBtnAutoScroll, bAutoScroll);
	
	local tbTempData = Ui.tbLogic.tbTempData;
	local szTabName = tbTempData.szCurTab;
	if szTabName == "" then
		self:OnActive(tbMsgChannel.TAB_COMMON);
	else
		self:OnActive(szTabName);
	end
end

	
function uiChatTab:OnClose()
	Ui.tbLogic.tbTempData.szCurTab = self.szActiveTabName;	
end	
	
function uiChatTab:OnButtonMClick(szWnd)
	for szTabName, szBtnCtlName in pairs(tbTab2BtnCtlName) do
		if szBtnCtlName == szWnd then
			DisplayPopupMenu(
				self.UIGROUP,
				szWnd,
				2,
				0,
				tbMenu[1],
				1,
				tbMenu[2],
				2
			);
		end
	end
end

function uiChatTab:CancelAllCheck()
	for szTabName, szBtnCtlName in pairs(tbTab2BtnCtlName) do
		Btn_Check(self.UIGROUP, szBtnCtlName, 0);
	end
	
end

function uiChatTab:OnActive(szTabName)
	self:CancelAllCheck();
	self.szActiveTabName = szTabName;
	Btn_Check(self.UIGROUP, tbTab2BtnCtlName[szTabName], 1);
	UiNotify:OnNotify(UiNotify.emUIEVENT_CHAT_ONACTIVE_TAB, szTabName);
end

function uiChatTab:OnButtonClick(szWnd)
	if szWnd == tbTab2BtnCtlName[tbMsgChannel.TAB_PRIVATE] then
		self:CancelFlashPrivateTab();
	end
	
	if szWnd == szBtnAutoScroll then
		local bAutoScroll = Btn_GetCheck(self.UIGROUP, szBtnAutoScroll);
		Ui(Ui.UI_MSGPAD):SetAutoScroll(bAutoScroll);
		return;
	end

	for szTabName, szBtnCtlName in pairs(tbTab2BtnCtlName) do
		if szBtnCtlName == szWnd then
			self:OnActive(szTabName)
			break;
		end
	end
end

function uiChatTab:OnMenuItemSelected(szWnd, nItemId, nParam)
	for szTabName, szBtnCtlName in pairs(tbTab2BtnCtlName) do
		if szBtnCtlName == szWnd then
			if nItemId == 1 then
				Ui(Ui.UI_MSGPAD):OnSaveTabLog(szTabName);
			elseif nItemId == 2 then
				Ui(Ui.UI_MSGPAD):ClearTabMsg(szTabName);
			end
		end
	end
end

function uiChatTab:SwitchPrivateMsgMode()
	for i, szTabName in ipairs(tbSwitchTabSort) do
		if szTabName == self.szActiveTabName then
			print(szTabName, #tbSwitchTabSort)
			if i < #tbSwitchTabSort then
				self:OnActive(tbSwitchTabSort[i + 1])
			else
				self:OnActive(tbSwitchTabSort[1])
			end
			break;
		end
	end
end

function uiChatTab:FlashPrivateTab()
	Img_PlayAnimation(self.UIGROUP, tbTab2BtnCtlName[tbMsgChannel.TAB_PRIVATE], 1, 200, 1, 2);
end

function uiChatTab:CancelFlashPrivateTab()
	Img_StopAnimation(self.UIGROUP, szWnd);
end

function uiChatTab:OnAnimationLoop(szWnd)
	if (szWnd == tbTab2BtnCtlName[tbMsgChannel.TAB_PRIVATE]) then
		self.nCurFlashTime = self.nCurFlashTime + 1
		if self.nCurFlashTime >= nFlashTimes then
			Img_StopAnimation(self.UIGROUP, szWnd);
			self.nCurFlashTime = 0;
		end
	end
end

