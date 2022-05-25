------------------------------------------------------
local uiAutosay = Ui:GetClass("autosay");

local EDIT_CONTENT 	  = "EdtContent";
local EDIT_TIMES 	  = "EdtTimes";
local EDIT_INTERVAL	  = "EdtInterval";
local BUTTON_JIN	  = "BtnJin";
local BUTTON_CHENG	  = "BtnCheng";
local BUTTON_GONG	  = "BtnGong";
local BUTTON_X		  = "BtnX";
local BUTTON_Btnzdhf	  = "Btnzdhf";
local BUTTON_CLOSE	  = "BtnClose";
local BUTTON_ADD_TIMES    = "BtnAddTimes";
local BUTTON_DEC_TIMES	  = "BtnDecTimes";
local BUTTON_ADD_INTERVAL = "BtnAddInterval";
local BUTTON_DEC_INTERVAL = "BtnDecInterval";
local BUTTON_HANHUA	 = "BtnHanhua";
local BUTTON_HANHUA1	 = "BtnHanhua1";
local BUTTON_HANHUA2	 = "BtnHanhua2";
local BUTTON_HANHUA3	 = "BtnHanhua3";
local BUTTON_HANHUA4	 = "BtnHanhua4";
local BUTTON_HANHUA5	 = "BtnHanhua5";
local nTimerIdJ = 0;
local nStateJ   = 0; 
local nTimerIdCh= 0;
local nStateCh   = 0; 
local nTimerIdG = 0;
local nStateG   = 0; 
local szMsg1 = 0;
local nInterval1= 0;
local nTimes1= 0;
local szMsg2 = 0;
local nInterval2= 0;
local nTimes2= 0;
local szMsg3 = 0;
local nInterval3 = 0;
local nTimes3= 0;
local nTimerIdX = 0;
local nStateX   = 0; 
local nInterval4 = 0;
local szMsg4 = 0;
local nTimes4= 0;
local Timer1=1;
local Timer2=1;
local Timer3=1;
local Timer4=1;

function uiAutosay:OnOpen(nParam)
	local szData = KFile.ReadTxtFile("\\interface\\ui_autosay2\\data\\hanhua.txt");
	local tbSplit = Lib:SplitStr(szData, "#^@");
	Edt_SetTxt(self.UIGROUP, EDIT_CONTENT, tbSplit[1]);
	Edt_SetInt(self.UIGROUP, EDIT_INTERVAL, tonumber(tbSplit[2]));
	Edt_SetInt(self.UIGROUP, EDIT_TIMES, tonumber(tbSplit[3]));
end

function uiAutosay:OnEditChange(szWnd, nParam)
	if (szWnd == EDIT_TIMES) then
		local nTimes = Edt_GetInt(self.UIGROUP, EDIT_TIMES);
		if nTimes > 1000 then
			Edt_SetInt(self.UIGROUP, EDIT_TIMES, 1000);	
		end
	elseif (szWnd == EDIT_INTERVAL) then
		local nInterval = Edt_GetInt(self.UIGROUP, EDIT_INTERVAL);
		if nInterval > 300 then
			Edt_SetInt(self.UIGROUP, EDIT_INTERVAL, 300);	
		end
	end
end

function uiAutosay:OnButtonClick(szWnd, nParam)
	if szWnd == BUTTON_CLOSE then
		UiManager:CloseWindow(self.UIGROUP);
	elseif (szWnd == BUTTON_HANHUA) then
		local szData = KFile.ReadTxtFile("\\interface\\ui_autosay2\\data\\hanhua.txt");
		local tbSplit = Lib:SplitStr(szData, "#^@");
		Edt_SetTxt(self.UIGROUP, EDIT_CONTENT, tbSplit[1]);
	elseif (szWnd == BUTTON_HANHUA1) then
		local szData = KFile.ReadTxtFile("\\interface\\ui_autosay2\\data\\hanhua1.txt");
		local tbSplit = Lib:SplitStr(szData, "#^@");
		Edt_SetTxt(self.UIGROUP, EDIT_CONTENT, tbSplit[1]);
	elseif (szWnd == BUTTON_HANHUA2) then
		local szData = KFile.ReadTxtFile("\\interface\\ui_autosay2\\data\\hanhua2.txt");
		local tbSplit = Lib:SplitStr(szData, "#^@");
		Edt_SetTxt(self.UIGROUP, EDIT_CONTENT, tbSplit[1]);
	elseif (szWnd == BUTTON_HANHUA3) then
		local szData = KFile.ReadTxtFile("\\interface\\ui_autosay2\\data\\hanhua3.txt");
		local tbSplit = Lib:SplitStr(szData, "#^@");
		Edt_SetTxt(self.UIGROUP, EDIT_CONTENT, tbSplit[1]);
	elseif (szWnd == BUTTON_HANHUA4) then
		local szData = KFile.ReadTxtFile("\\interface\\ui_autosay2\\data\\hanhua4.txt");
		local tbSplit = Lib:SplitStr(szData, "#^@");
		Edt_SetTxt(self.UIGROUP, EDIT_CONTENT, tbSplit[1]);
	elseif (szWnd == BUTTON_HANHUA5) then
		local szData = KFile.ReadTxtFile("\\interface\\ui_autosay2\\data\\hanhua5.txt");
		local tbSplit = Lib:SplitStr(szData, "#^@");
		Edt_SetTxt(self.UIGROUP, EDIT_CONTENT, tbSplit[1]);
	elseif (szWnd == BUTTON_ADD_TIMES) then
		local nTimes = Edt_GetInt(self.UIGROUP, EDIT_TIMES);
		if nTimes + 1 <= 1000 and nTimes + 1 >= 5 then
			Edt_SetInt(self.UIGROUP, EDIT_TIMES, nTimes + 1);
		elseif nTimes > 1000 then
			Edt_SetInt(self.UIGROUP, EDIT_TIMES, 1000);
		elseif nTimes < 5 then
			Edt_SetInt(self.UIGROUP, EDIT_TIMES, 5);
		end
	elseif (szWnd == BUTTON_DEC_TIMES) then
		local nTimes = Edt_GetInt(self.UIGROUP, EDIT_TIMES);
		if nTimes - 1 <= 1000 and nTimes - 1 >= 5 then
			Edt_SetInt(self.UIGROUP, EDIT_TIMES, nTimes - 1);
		elseif nTimes > 1000 then
			Edt_SetInt(self.UIGROUP, EDIT_TIMES, 1000);
		elseif nTimes < 5 then
			Edt_SetInt(self.UIGROUP, EDIT_TIMES, 5);
		end
	elseif (szWnd == BUTTON_ADD_INTERVAL) then
		local nInterval = Edt_GetInt(self.UIGROUP, EDIT_INTERVAL);
		if nInterval + 1 <= 300 and nInterval + 1 >= 5 then
			Edt_SetInt(self.UIGROUP, EDIT_INTERVAL, nInterval + 1);
		elseif nInterval > 300 then
			Edt_SetInt(self.UIGROUP, EDIT_INTERVAL, 300);
		elseif nInterval < 5 then
			Edt_SetInt(self.UIGROUP, EDIT_INTERVAL, 5);
		end
	elseif (szWnd == BUTTON_DEC_INTERVAL) then
		local nInterval = Edt_GetInt(self.UIGROUP, EDIT_INTERVAL);
		if nInterval - 1 <= 300 and nInterval - 1 >= 5 then
			Edt_SetInt(self.UIGROUP, EDIT_INTERVAL, nInterval - 1);
		elseif nInterval > 300 then
			Edt_SetInt(self.UIGROUP, EDIT_INTERVAL, 300);
		elseif nInterval < 5 then
			Edt_SetInt(self.UIGROUP, EDIT_INTERVAL, 5);
		end
	elseif (szWnd == BUTTON_JIN) then
		nInterval1 = Edt_GetInt(self.UIGROUP, EDIT_INTERVAL);
		nTimes1 = Edt_GetInt(self.UIGROUP, EDIT_TIMES);
		szMsg1 = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT);
		if nTimerIdJ == 0 then
			if nInterval1 < 5 then
				me.Msg("<color=yellow>Kênh Cận，ít nhất là 5 giây！");
				return 0;	
			end
			if not szMsg1 or szMsg1 == "" then
				me.Msg("Nhập nội dung !");
				return 0;		
			end
			AutoAi:SwitchJinAutoSay();
		else
			AutoAi:SwitchJinAutoSay();
		end
	elseif (szWnd == BUTTON_CHENG) then
		nInterval2 = Edt_GetInt(self.UIGROUP, EDIT_INTERVAL);
		nTimes2 = Edt_GetInt(self.UIGROUP, EDIT_TIMES);
		szMsg2 = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT);
		if nTimerIdCh == 0 then
			if nInterval2 < 20 then
				me.Msg("<color=yellow>Kênh Thành thị，ít nhất là 20 giây！");
				return 0;	
			end
			if not szMsg2 or szMsg2 == "" then
				me.Msg("Nhập nội dung !");
				return 0;		
			end
			AutoAi:SwitchChAutoSay();
		else
			AutoAi:SwitchChAutoSay();
		end
	elseif (szWnd == BUTTON_GONG) then
		nInterval3 = Edt_GetInt(self.UIGROUP, EDIT_INTERVAL);
		nTimes3 = Edt_GetInt(self.UIGROUP, EDIT_TIMES);
		szMsg3 = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT);
		if nTimerIdG == 0 then
			if nInterval3 < 60 then
				me.Msg("<color=yellow>Kênh Thế giới，ít nhất là 60 giây！");
				return 0;	
			end
			if not szMsg3 or szMsg3 == "" then
				me.Msg("Nhập nội dung !");
				return 0;		
			end
			AutoAi:SwitchGAutoSay();
		else
			AutoAi:SwitchGAutoSay();
		end
	elseif (szWnd == BUTTON_X) then
		nInterval4 = Edt_GetInt(self.UIGROUP, EDIT_INTERVAL);
		nTimes4 = Edt_GetInt(self.UIGROUP, EDIT_TIMES);
		szMsg4 = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT);
		if nTimerIdX == 0 then
			if nInterval4 < 10 then
				me.Msg("<color=yellow>Thời gian quá ngắn, ít nhất phải 10 giây !");
				return 0;	
			end
			if not szMsg4 or szMsg4 == "" then
				me.Msg("Nhập nội dung !");
				return 0;		
			end
			AutoAi:SwitchXAutoSay();
		else
			AutoAi:SwitchXAutoSay();
		end
	elseif (szWnd == BUTTON_Btnzdhf) then
		Map.tbAutoReply:Switch();
	end
end


function AutoAi:SwitchJinAutoSay()
	if nStateJ == 0 then 
		nStateJ = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bật chế độ rao Cận");
		SendChannelMsg("NearBy", szMsg1);	
		nTimerIdJ = Ui.tbLogic.tbTimer:Register(nInterval1 * Env.GAME_FPS,self.JinAutoSay, self);
	else
		nStateJ = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt chế độ rao Cận");
		Ui.tbLogic.tbTimer:Close(nTimerIdJ);
		nTimerIdJ = 0;
	end
end
function AutoAi:JinAutoSay()
	SendChannelMsg("NearBy", szMsg1);	
	Timer1 = Timer1 + 1;
	if Timer1 == nTimes1 then
		nStateJ = 0;		
		Ui.tbLogic.tbTimer:Close(nTimerIdJ);
		nTimerIdJ = 0;
		Timer1 = 1;
	end
end


function AutoAi:SwitchChAutoSay()
	if nStateCh == 0 then 
		nStateCh = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bật chế độ rao Kênh thành thị");	
		SendChannelMsg("City", szMsg2);	
		nTimerIdCh = Ui.tbLogic.tbTimer:Register(nInterval2 * Env.GAME_FPS,self.ChAutoSay, self);	
	else
		nStateCh = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt chế độ rao Kênh thành thị");
		Ui.tbLogic.tbTimer:Close(nTimerIdCh);
		nTimerIdCh = 0;
	end
end
function AutoAi:ChAutoSay()		
	SendChannelMsg("City", szMsg2);	
	Timer2 = Timer2 + 1;
	if Timer2 == nTimes2 then
		nStateCh = 0;		
		Ui.tbLogic.tbTimer:Close(nTimerIdCh);
		nTimerIdCh = 0;
		Timer2 = 1;
	end
end


function AutoAi:SwitchGAutoSay()
	if nStateG == 0 then 
		nStateG = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bật chế độ rao Kênh thế giới");
		SendChannelMsg("World", szMsg3);
		nTimerIdG = Ui.tbLogic.tbTimer:Register(nInterval3 * Env.GAME_FPS,self.GAutoSay, self);	
	else
		nStateG = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt chế độ rao Kênh thế giới");
		Ui.tbLogic.tbTimer:Close(nTimerIdG);
		nTimerIdG = 0;
	end
end
function AutoAi:GAutoSay()		
	SendChannelMsg("World", szMsg3);
	Timer3 = Timer3 + 1;
	if Timer3 == nTimes3 then
		nStateG = 0;		
		Ui.tbLogic.tbTimer:Close(nTimerIdG);
		nTimerIdG = 0;
		Timer3 = 1;
	end
end

function AutoAi:SwitchXAutoSay()
	if nStateX == 0 then 
		nStateX = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bật chế độ rao Kênh hiện tại");
		SendChatMsg(szMsg4);
		nTimerIdX = Ui.tbLogic.tbTimer:Register(nInterval4 * Env.GAME_FPS,self.XAutoSay, self);	
	else
		nStateX = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt chế độ rao Kênh hiện tại");
		Ui.tbLogic.tbTimer:Close(nTimerIdX);
		nTimerIdX = 0;
	end
end
function AutoAi:XAutoSay()		
	SendChatMsg(szMsg4);	
	Timer4 = Timer4 + 1;
	if Timer4 == nTimes4 then
		nStateX = 0;		
		Ui.tbLogic.tbTimer:Close(nTimerIdX);
		nTimerIdX = 0;
		Timer4 = 1;
	end
end

function uiAutosay:OnClose()
	local szMysay = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT);
	local szInterval = Edt_GetInt(self.UIGROUP, EDIT_INTERVAL);
	local szTimes = Edt_GetInt(self.UIGROUP, EDIT_TIMES);
	KFile.WriteFile("\\interface\\ui_autosay2\\data\\hanhua.txt", szMysay.."#^@"..szInterval.."#^@"..szTimes);

end

Ui:RegisterNewUiWindow("UI_AUTOSAY", "autosay", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});

local tCmd={ "UiManager:SwitchWindow(Ui.UI_AUTOSAY)", "UI_AUTOSAY", "", "N", "N", "UI_AUTOSAY"};
        AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
        UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	
LoadUiGroup(Ui.UI_AUTOSAY, "autosay.ini");
