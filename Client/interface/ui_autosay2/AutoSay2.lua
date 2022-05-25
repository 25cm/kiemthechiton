------------------------------------------------------
local uiReply = Ui:GetClass("autosay");

local BUTTON_Btnzdhf	  = "Btnzdhf";
local BUTTON_CLOSE	  = "BtnClose";
local EDIT_CONTENT_REPLY 	= "BtnReply";
local EDIT_CONTENT_REPLY2 	= "BtnReply2";
local EDIT_CONTENT_REPLY3 	= "BtnReply3";
local EDIT_CONTENT_REPLY4 	= "BtnReply4";
local EDIT_CONTENT_REPLY5 	= "BtnReply5";
local EDIT_CONTENT_REPLY6 	= "BtnReply6";
local EDIT_CONTENT_REPLY7 	= "BtnReply7";
local EDIT_CONTENT_REPLY8 	= "BtnReply8";
local EDIT_CONTENT_REPLY9 	= "BtnReply9";
local EDIT_CONTENT_REPLY10 	= "BtnReply10";
local szMsgReply = 0;
local szMsgReply2 = 0;
local szMsgReply3 = 0;
local szMsgReply4 = 0;
local szMsgReply5 = 0;
local szMsgReply6 = 0;
local szMsgReply7 = 0;
local szMsgReply8 = 0;
local szMsgReply9 = 0;
local szMsgReply10 = 0;

function uiReply:OnOpen(nParam)
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
	Edt_SetTxt(self.UIGROUP, EDIT_CONTENT_REPLY, szMsgReply);
	Edt_SetTxt(self.UIGROUP, EDIT_CONTENT_REPLY2, szMsgReply2);
	Edt_SetTxt(self.UIGROUP, EDIT_CONTENT_REPLY3, szMsgReply3);
	Edt_SetTxt(self.UIGROUP, EDIT_CONTENT_REPLY4, szMsgReply4);
	Edt_SetTxt(self.UIGROUP, EDIT_CONTENT_REPLY5, szMsgReply5);
	Edt_SetTxt(self.UIGROUP, EDIT_CONTENT_REPLY6, szMsgReply6);
	Edt_SetTxt(self.UIGROUP, EDIT_CONTENT_REPLY7, szMsgReply7);
	Edt_SetTxt(self.UIGROUP, EDIT_CONTENT_REPLY8, szMsgReply8);
	Edt_SetTxt(self.UIGROUP, EDIT_CONTENT_REPLY9, szMsgReply9);
	Edt_SetTxt(self.UIGROUP, EDIT_CONTENT_REPLY10, szMsgReply10);	
end

function uiReply:OnButtonClick(szWnd, nParam)
	szMsgReply = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT_REPLY);
	szMsgReply2 = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT_REPLY2);
	szMsgReply3 = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT_REPLY3);
	szMsgReply4 = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT_REPLY4);
	szMsgReply5 = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT_REPLY5);
	szMsgReply6 = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT_REPLY6);
	szMsgReply7 = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT_REPLY7);
	szMsgReply8 = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT_REPLY8);
	szMsgReply9 = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT_REPLY9);
	szMsgReply10 = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT_REPLY10);
	if szWnd == BUTTON_CLOSE then
		UiManager:CloseWindow(self.UIGROUP);
	elseif (szWnd == BUTTON_Btnzdhf) then
		Map.tbAutoReply:Switch();
	end
end

function uiReply:OnClose()
	local szMyReply = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT_REPLY);
	KFile.WriteFile("\\interface\\ui_autosay2\\data\\reply.txt", szMyReply);
	local szMyReply2 = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT_REPLY2);
	KFile.WriteFile("\\interface\\ui_autosay2\\data\\reply2.txt", szMyReply2);
	local szMyReply3 = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT_REPLY3);
	KFile.WriteFile("\\interface\\ui_autosay2\\data\\reply3.txt", szMyReply3);
	local szMyReply4 = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT_REPLY4);
	KFile.WriteFile("\\interface\\ui_autosay2\\data\\reply4.txt", szMyReply4);
	local szMyReply5 = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT_REPLY5);
	KFile.WriteFile("\\interface\\ui_autosay2\\data\\reply5.txt", szMyReply5);
	local szMyReply6 = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT_REPLY6);
	KFile.WriteFile("\\interface\\ui_autosay2\\data\\reply6.txt", szMyReply6);
	local szMyReply7 = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT_REPLY7);
	KFile.WriteFile("\\interface\\ui_autosay2\\data\\reply7.txt", szMyReply7);
	local szMyReply8 = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT_REPLY8);
	KFile.WriteFile("\\interface\\ui_autosay2\\data\\reply8.txt", szMyReply8);
	local szMyReply9 = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT_REPLY9);
	KFile.WriteFile("\\interface\\ui_autosay2\\data\\reply9.txt", szMyReply9);
	local szMyReply10 = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT_REPLY10);
	KFile.WriteFile("\\interface\\ui_autosay2\\data\\reply10.txt", szMyReply10);	
end

Ui:RegisterNewUiWindow("uiReply", "autosay", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});

local tCmd={ "UiManager:SwitchWindow(Ui.uiReply)", "uiReply", "", "Ctrl+N", "Ctrl+N", "uiReply"};
        AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
        UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	
LoadUiGroup(Ui.uiReply, "autosay2.ini");
