local tbAutoReply	= Map.tbAutoReply or {};
Map.tbAutoReply		= tbAutoReply;

local tbMsgInfo = Ui.tbLogic.tbMsgInfo;

local callStart = 1
local ARStart = 0;
local szMsgReply
local szMsgReply2
local szMsgReply3
local szMsgReply4
local szMsgReply5
local szMsgReply6
local szMsgReply7
local szMsgReply8
local szMsgReply9
local szMsgReply10


tbAutoReply.Switch = function(self)
	if ARStart == 0 then 
		ARStart = 1;
		me.Msg("<color=yellow>Bật<color> <color=green>tự động trả lời (Ctrl+N)");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bật tự động trả lời (Reply)Ctrl+N)");
		szMsgReply = KFile.ReadTxtFile("\\interface\\ui_autosay2\\data\\reply.txt");
		szMsgReply2 = KFile.ReadTxtFile("\\interface\\ui_autosay2\\data\\reply2.txt");
		szMsgReply3 = KFile.ReadTxtFile("\\interface\\ui_autosay2\\data\\reply3.txt");
		szMsgReply4 = KFile.ReadTxtFile("\\interface\\ui_autosay2\\data\\reply4.txt");
		szMsgReply5 = KFile.ReadTxtFile("\\interface\\ui_autosay2\\data\\reply5.txt");
		szMsgReply6 = KFile.ReadTxtFile("\\interface\\ui_autosay2\\data\\reply6.txt");
		szMsgReply7 = KFile.ReadTxtFile("\\interface\\ui_autosay2\\data\\reply7.txt");
		szMsgReply8 = KFile.ReadTxtFile("\\interface\\ui_autosay2\\data\\reply8.txt");
		szMsgReply9 = KFile.ReadTxtFile("\\interface\\ui_autosay2\\data\\reply9.txt");
		szMsgReply10 = KFile.ReadTxtFile("\\interface\\ui_autosay2\\data\\reply10.txt");
	else
		ARStart = 0;
		me.Msg("<color=yellow>Tắt<color> <color=pink>tự động trả lời (Ctrl+N)");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt tự động trả lời (Reply)Ctrl+N)");
	end
end

function tbAutoReply:ModifyUi()
	local uiMsgPad =Ui(Ui.UI_MSGPAD)
	tbAutoReply.Say_bak	= tbAutoReply.Say_bak or Ui(Ui.UI_MSGPAD).OnSendMsgToChannel;
	function uiMsgPad:OnSendMsgToChannel(szChannelName, szName, szMsg, szGateway)
		tbAutoReply.Say_bak(Ui(Ui.UI_MSGPAD), szChannelName, szName, szMsg, szGateway);
		local function fnOnSay()
			tbAutoReply:OnSay(szChannelName, szName, szMsg, szGateway);
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(1, fnOnSay);
	end
end

function tbAutoReply:OnSay(szChannelName, szSendName, szMsg)
	if (ARStart ~= 0) and (szChannelName == "Personal") then
		local function fnOnSay1()
			ARStart = 1
			return 0;
		end
		ARStart = 0
		Ui.tbLogic.tbTimer:Register(50, fnOnSay1);
		SendChatMsg("/"..szSendName.." "..szMsgReply);
		SendChatMsg("/"..szSendName.." "..szMsgReply2);
		SendChatMsg("/"..szSendName.." "..szMsgReply3);
		SendChatMsg("/"..szSendName.." "..szMsgReply4);
		SendChatMsg("/"..szSendName.." "..szMsgReply5);
		SendChatMsg("/"..szSendName.." "..szMsgReply6);
		SendChatMsg("/"..szSendName.." "..szMsgReply7);
		SendChatMsg("/"..szSendName.." "..szMsgReply8);
		SendChatMsg("/"..szSendName.." "..szMsgReply9);
		SendChatMsg("/"..szSendName.." "..szMsgReply10);
	end
end

function tbAutoReply:Init()
	tbAutoReply:ModifyUi()
end

tbAutoReply:Init()