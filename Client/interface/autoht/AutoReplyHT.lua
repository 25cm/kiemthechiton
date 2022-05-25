local tbSuperCallHT	= Map.tbSuperCallHT or {};
Map.tbSuperCallHT		= tbSuperCallHT;

local tbMsgInfo = Ui.tbLogic.tbMsgInfo;

local callStart = 0
local ARStart = 0;
local szMsgReply
local autopttimer = 0;
local timestarttrain = 0;
tbSuperCallHT.nOnOffAutoPt = 0;
tbSuperCallHT.szPassJoinTeam = "ptvoi";

tbSuperCallHT.Switch = function(self)
	if ARStart == 0 then 
		ARStart = 1;
		me.Msg("<color=yellow>Bật<color> tự động trả lời (Ctrl+7)");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=red><color=yellow>Mở tự động trả lời");
		szMsgReply = KFile.ReadTxtFile("\\interface\\ui_autosay\\reply.txt");
	else
		ARStart = 0;
		me.Msg("<color=yellow>Tắt<color> tự động trả lời (Ctrl+7)");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=blue><color=white>Đóng tự động trả lời");
	end
end

tbSuperCallHT.CallSwitch = function(self)
	if callStart == 0 then 
		callStart = 1;
		me.Msg("<color=yellow>Bật<color> hỗ trợ bằng hữu (Ctrl+9)");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=red><color=yellow>Mở hỗ trợ bằng hữu");
	else
		callStart = 0;
		me.Msg("<color=yellow>Tắt<color> hỗ trợ bằng hữu (Ctrl+9)");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=blue><color=white>Đóng hỗ trợ bằng hữu");
	end
end

function tbSuperCallHT:ModifyUi()
	me.Msg("aaaaa");
	local uiMsgPad =Ui(Ui.UI_MSGPAD)
	tbSuperCallHT.Say_bak	= tbSuperCallHT.Say_bak or Ui(Ui.UI_MSGPAD).OnSendMsgToChannel;
	function uiMsgPad:OnSendMsgToChannel(szChannelName, szName, szMsg, szGateway)
		tbSuperCallHT.Say_bak(Ui(Ui.UI_MSGPAD), szChannelName, szName, szMsg, szGateway);
		local function fnOnSay()
			tbSuperCallHT:OnSay(szChannelName, szName, szMsg, szGateway);
			return 0;
		end
		autopttimer = Ui.tbLogic.tbTimer:Register(1, fnOnSay);
	end
end

function tbSuperCallHT:OnSay(szChannelName, szSendName, szMsg)
	-- me.Msg("[<color=yellow>"..szChannelName.."<color>] <color=pink>"..szSendName.."<color>: "..szMsg)	
	if (szChannelName == "Personal") and ( self.nOnOffAutoPt == 1 ) then
	if string.find(szMsg, self.szPassJoinTeam, 1) == 1 then
		SendChatMsg("/"..szSendName.." Vào PT đi :T");
		me.TeamInvite(0, szSendName);
	end
	if string.find(szMsg, "ailampluginnay", 1) == 1 then
		SendChatMsg("/"..szSendName.." Auto hải tặc viết bởi Tần Vũ");
	end
	end
	--if (szChannelName == "Personal") then
	--	if string.find(szMsg, "Khởi động lại auto train!!", 1) == 1 then
	--		me.Msg("nhan dc msg");
	--		--
	--		if GetTime() - timestarttrain > 60 then
	--			timestarttrain = GetTime();
	--			AutoAi:StartTrainHT();
	--		end
	--	end
	--end
	if (szChannelName == "Team") then
		if string.find(szMsg, "Khởi động lại auto train!!", 1) == 1 then
			if Map.tbAutoAimHT.nFollowState == 0 then				
				if GetTime() - timestarttrain > 60 then
					timestarttrain = GetTime();
					AutoAi:StartTrainHT();
				end
			end
		end
	end
end

function tbSuperCallHT:Init()
	tbSuperCallHT:ModifyUi()
end

function tbSuperCallHT:StopAutoPt()
	if autopttimer ~= 0 then
		Ui.tbLogic.tbTimer:Close(autopttimer);
		autopttimer = 0;
	end
end

tbSuperCallHT:Init()