
Require("\\ui\\script\\logic\\messagelist.lua")

local tbMsgList = Ui.tbLogic.tbMessageList;

local tbNameElem = {};

function tbNameElem:Init(tbInfo, szName)
	self.szText 		= tbInfo[1];
	self.szSayContent 	= tbInfo[4];
	self.IsSystem		= tbInfo[5];
	self.szChannelName	= tbInfo[6];
	
	local szTempText = self.szText;
	if (szTempText ~= "") then
		szTempText = szTempText .. ":";
	end
	
	local bFiterColor = 1;
	if (self.IsSystem == 1) then
		bFiterColor = 0;
	end
	
	local nId		= MessageList_PushBtn(self.tbManager.UIGROUP, self.tbManager.szMessageListName or szName, 0, szTempText, "white", "black", bFiterColor);
	return nId;
end

function tbNameElem:Clear()

end
function tbNameElem:GetShowMsg(tbInfo)	
	return tbInfo[1];	
end

function tbNameElem:LeftClick()
	if (self.bDisableMenu == 1) then
		return;
	end
	local bForbid = 0;
	for i, szForbidName in pairs(tbMsgList.tbForbidName) do
		if (self.szText == szForbidName) then
			return;
		end
	end
	
	if (self.szChannelName == Ui.tbLogic.tbMsgChannel.CHANNEL_ME) then
		return;
	end
	
	local nX, nY = GetCursorPos();
	if (IVER_g_nSdoVersion == 0) then
		SetChatFiterReport(0);
	end
	
	PopMenuDataInit(0, self.szText, nX ,nY, self.szSayContent); 
	if (IVER_g_nSdoVersion == 0) then
		SetChatFiterReport(1);
	end
end

function tbNameElem:CtrlLeftClick()
	if (self.bDisableMenu == 1) then
		return;
	end
	if me.szName ~= self.szText then
		ChatToPlayer(self.szText);
	end
end

function tbNameElem:RightClick()
	if (self.bDisableMenu == 1) then
		return;
	end
	local nX, nY = GetCursorPos()
	PopMenuDataInit(1, self.szText, nX ,nY);
end

tbMsgList:RegisterBaseClass("name", tbNameElem);
