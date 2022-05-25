
Require("\\script\\player\\define.lua");

local tbUiSetting	= Ui:GetClass("nopick_setting");


tbUiSetting.BTN_CLOSE       = "BtnClose";
tbUiSetting.BTN_SAVE        = "BtnSave"; 
tbUiSetting.BTN_CLEAR       = "BtnClear";
tbUiSetting.BTN_REMOVE      = "BtnRemove";
tbUiSetting.TXT_NOPICKITEM  = "TxtNoPickItem";
tbUiSetting.TXT_NOPICKLIST  = "TxtNoPickList";
tbUiSetting.BTN_NOPICK      = {};
tbUiSetting.BTN_NOPICK[1]   = "BtnNoPick1";
tbUiSetting.BTN_NOPICK[2]   = "BtnNoPick2";
tbUiSetting.BTN_NOPICK[3]   = "BtnNoPick3";
tbUiSetting.BTN_NOPICK[4]   = "BtnNoPick4";
tbUiSetting.BTN_NOPICK[5]   = "BtnNoPick5";
tbUiSetting.BTN_NOPICK[6]   = "BtnNoPick6";
tbUiSetting.BTN_NOPICK[7]   = "BtnNoPick7";
tbUiSetting.BTN_NOPICK[8]   = "BtnNoPick8";
tbUiSetting.BTN_NOPICK[9]   = "BtnNoPick9";
tbUiSetting.BTN_NOPICK[10]  = "BtnNoPick10";


function tbUiSetting:OnOpen()
	self:UpdateAll();
	self:Update_Item_Nopick_List();
end


function tbUiSetting:OnButtonClick(szWnd, nParam)
	if (szWnd == tbUiSetting.BTN_CLOSE) then
		UiManager:CloseWindow("UI_NOPICK_SETTING");
	elseif (szWnd == tbUiSetting.BTN_SAVE) then
		local szData = self:GetItemList();
		if not szData then
			szData = "";
		end
		local szText = {};
		for i = 1, 10 do
			local nCheck = Btn_GetCheck(self.UIGROUP, self.BTN_NOPICK[i]);
			szText[i] = Btn_GetTxt(self.UIGROUP, self.BTN_NOPICK[i]);
			szText[i] = szText[i]..";";
			if nCheck == 1 and not string.find(szData,szText[i]) and szText[i] ~= "预留位;" then
				szData = szData..szText[i]; 
			end
			if nCheck == 0 and string.find(szData,szText[i]) then
				szData = Lib:ReplaceStr(szData, szText[i], "");
			end
		end
		self:Save(szData);
		self:AddNew();
		self:UpdateAll();
		self:Update_Item_Nopick_List();
	elseif (szWnd == tbUiSetting.BTN_CLEAR) then
		self:Clear();		
		self:UpdateAll();
		self:Update_Item_Nopick_List();
	elseif (szWnd == tbUiSetting.BTN_REMOVE) then
		self:Remove();		
		self:UpdateAll();
		self:Update_Item_Nopick_List();
	end
end

-- 功能：读取数据
function tbUiSetting:GetItemList()
	local szFilePath="\\user\\nopick\\"..me.szName.."_setting.txt";
	local szData = KIo.ReadTxtFile(szFilePath);
	return szData;
end


function tbUiSetting:Save(szData)
	local szFilePath="\\user\\nopick\\"..me.szName.."_setting.txt";
	KIo.WriteFile(szFilePath, szData);
end


function tbUiSetting:Clear()
	local szFilePath="\\user\\nopick\\"..me.szName.."_setting.txt";
	KIo.WriteFile(szFilePath, "");
end


function tbUiSetting:Remove()
	local szItemName = Edt_GetTxt(self.UIGROUP, self.TXT_NOPICKITEM);
	szItemName = Lib:StrTrim(szItemName, " ");
	if szItemName == "" then
		return;
	end
	local szData = self:GetItemList();
	local tmpData = "";
	if szData then
		local tbStr = Lib:SplitStr(szData, ";");
		for i = 1, #tbStr do
			local szStr = tbStr[i];
			if szItemName ~= szStr and szStr ~= "" then
				tmpData = tmpData..szStr..";";
			end
		end
	end
	self:Save(tmpData);
end


function tbUiSetting:UpdateAll()
	local szData = self:GetItemList();
	if not szData then
		Txt_SetTxt(self.UIGROUP, self.TXT_NOPICKLIST, "(Không có)");
	else
		Txt_SetTxt(self.UIGROUP, self.TXT_NOPICKLIST, szData);
	end
	Edt_SetTxt(self.UIGROUP, self.TXT_NOPICKITEM, "");
	self:UpdateBtnCheck();
end


function tbUiSetting:UpdateBtnCheck()
	local szData = self:GetItemList();
	if not szData then
		szData = "";
	end
	local szText = {};
	for i = 1, 10 do
		szText[i] = Btn_GetTxt(self.UIGROUP, self.BTN_NOPICK[i]);
		if string.find(szData,szText[i]) then
			szText[i] = 1;
		else
			szText[i] = 0;
		end
		Btn_Check("UI_NOPICK_SETTING", self.BTN_NOPICK[i], szText[i]);
	end
end


function tbUiSetting:AddNew()
	local szItemName = Edt_GetTxt(self.UIGROUP, self.TXT_NOPICKITEM);
	szItemName = Lib:StrTrim(szItemName, " ");
	if szItemName == "" then
		return;
	end
	szItemName = szItemName..";";
	local szData = self:GetItemList();		
	if not szData then
		szData = szItemName;
	else
		local tbStr = Lib:SplitStr(szData, ";");
		for i = 1, #tbStr do
			local szStr = tbStr[i];
			if string.find(szItemName, szStr) and szStr ~= "" then
				szItemName = ""; 
				break;
			end
		end
		szData = szData..szItemName;
	end
	self:Save(szData);
end


function tbUiSetting:Update_Item_Nopick_List()
	local szData = self:GetItemList();
	if not szData then
		szData = "";
	end
	AutoAi.ITEM_NOPICK_LIST = szData;
	AutoAi:Init();
	AutoAi.ProcessHandCommand("auto_fight", me.nAutoFightState);
end


Ui:RegisterNewUiWindow("UI_NOPICK_SETTING", "nopick_setting", {"a", 200, 66}, {"b", 200, 66}, {"c", 200, 66});


local EnterGame_bak = Ui.EnterGame;
function Ui:EnterGame()
	EnterGame_bak(Ui);
	tbUiSetting:Update_Item_Nopick_List();
end

local tCmd={ "UiManager:OpenWindow(Ui.UI_NOPICK_SETTING)", "nopick", "", "Alt+5", "Alt+5", "拾取设置" };
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	--：ALT+4