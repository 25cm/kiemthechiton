
Require("\\interface\\supermaplink\\supermaplink.lua");
Ui.UI_SUPERMAPLINK_UI			= "UI_SUPERMAPLINK_UI";

local uiSuperMapLinkUi			= Ui.tbWnd[Ui.UI_SUPERMAPLINK_UI] or {};
uiSuperMapLinkUi.UIGROUP		= Ui.UI_SUPERMAPLINK_UI;
Ui.tbWnd[Ui.UI_SUPERMAPLINK_UI] = uiSuperMapLinkUi;

Map.tbSuperMapLink.tbUi			= uiSuperMapLinkUi;

uiSuperMapLinkUi.TXX_SHOW 		= "TxtExShow";
uiSuperMapLinkUi.TXT_TITLE		= "TxtTitle";
uiSuperMapLinkUi.TXT_PAGETITLE	= "TxtPageTitle";
uiSuperMapLinkUi.LST_TEXTLIST	= "LstTextList";
uiSuperMapLinkUi.BTN_SURE 		= "BtnSure";
uiSuperMapLinkUi.BTN_CANCEL		= "BtnCancel";
uiSuperMapLinkUi.BTN_CLOSE		= "BtnClose";

uiSuperMapLinkUi.tbDefaultUi	= {
  {
		"<color=purple>RELOAD<color>",
[[
<link=mycmd:Reload SuperBao				,Map.ReloadCH:BVD()>
<link=mycmd:Reload SuperBao Setting		,Map.ReloadCH:BVDSetting()>
<link=mycmd:Reload Thanh Tools			,Map.ReloadCH:Tools()>
<link=mycmd:Reload Thanh Tool			,Map.ReloadCH:Tool()>
<link=mycmd:Reload Đào Kho Báu			,Map.ReloadCH:DaoKhoBau()>
<link=mycmd:Reload Hải Lăng Vương Mộ	,Map.ReloadCH:HLVM()>
<link=mycmd:Reload Theo Sau - Hộ Tống	,Map.ReloadCH:TheoSau()>
<link=mycmd:Reload World Map Sub		,Map.ReloadCH:WorldMap()>
<link=mycmd:Reload Manager				,Map.ReloadCH:Mgr()>
<link=mycmd:Reload Buff Phụ Trợ			,Map.ReloadCH:TDBuff()>
<link=mycmd:Reload Trả Lời Câu Hỏi		,Map.ReloadCH:TraLoiCH()>
<link=mycmd:Reload Ghép HT [Shift+X]	,Map.ReloadCH:GhepHT()>
<link=mycmd:Reload Thông Tin F12		,Map.ReloadCH:F12()>
<link=mycmd:Reload Săn Hải Tặc			,Map.ReloadCH:HaiTac()>
<link=mycmd:Reload Tự Động Đánh			,Map.ReloadCH:TuDongDanh()>
<link=mycmd:Reload Đồng Hồ				,Map.ReloadCH:Miniclock()>
<link=mycmd:Reload Phím Tắt				,Map.ReloadCH:PhimTat()>
<link=mycmd:Reload SuperMapLink			,Map.ReloadCH:SuperMapLink()>
<link=mycmd:Reload Linh Tinh			,Map.ReloadCH:LinhTinh()>
<link=mycmd:Reload ReloadCH				,Map.ReloadCH:Self()>
]]},
 {
		"<color=yellow>Đọc tọa độ<color>",
[[
<link=mycmd:Tọa độ hiện tại				,Ui(Ui.UI_SUPERMAPLINK_UI):PickPos("pos")>
<link=mycmd:NPC đứng gần				,Ui(Ui.UI_SUPERMAPLINK_UI):PickPos("npcpos")>
<link=mycmd:IdNPC đứng gần				,Ui(Ui.UI_SUPERMAPLINK_UI):PickPos("npcid")>
<link=mycmd:Xóa hết						,Ui(Ui.UI_SUPERMAPLINK_UI):ClearPick()>
<link=mycmd:Tự Động đọc tọa độ			,Ui(Ui.UI_SUPERMAPLINK_UI):SendMyPos("text")>
<link=mycmd:Tự Động đọc tọa độ Code		,Ui(Ui.UI_SUPERMAPLINK_UI):SendMyPos("code")>
]]},
};

function uiSuperMapLinkUi:OnOpen()
	Map.tbSuperMapLink:OutF("Ui open!");
	local tbSplit	= Lib:SplitStr(Lib:SplitStr(Map.tbSuperMapLink.STR_LASTMODIFY, " ")[1], "/");
	local szTitle	= string.format("SuperMapLink", unpack(tbSplit));
	Txt_SetTxt(self.UIGROUP, self.TXT_TITLE, szTitle);
	self:RefreshList();
end

function uiSuperMapLinkUi:OnClose()
	Map.tbSuperMapLink:SaveUserData();
end

function uiSuperMapLinkUi:RefreshList()
	local tbTextList	= {};
	self.tbTextList		= tbTextList;
	
	local szMyUiData	= KFile.ReadTxtFile("\\interface\\supermaplink\\myui.dll");
	if (szMyUiData) then
		local tbMyUi	= Lib:Str2Val(szMyUiData);
		for _, tbText in ipairs(self.tbDefaultUi) do
			if (tbText[1] == (tbMyUi[1] or {})[1]) then
				tbTextList[#tbTextList + 1]	= {tbText[1], tbText[2] .. tbMyUi[1][2]};
				table.remove(tbMyUi, 1);
			else
				tbTextList[#tbTextList + 1]	= {tbText[1], tbText[2]};
			end
		end
		for _, tbText in ipairs(tbMyUi) do
			tbTextList[#tbTextList + 1]	= tbText;
		end
	end
	
	local nCurSelect	= Map.tbSuperMapLink.tbUserData.nUiSelect;
	if (not tbTextList[nCurSelect]) then
		nCurSelect		= 1;
	end
	
	Lst_Clear(self.UIGROUP, self.LST_TEXTLIST);
	for nIndex, tbText in ipairs(tbTextList) do
		Lst_SetCell(self.UIGROUP, self.LST_TEXTLIST, nIndex, 0, tbText[1]);
	end
	
	Lst_SetCurKey(self.UIGROUP, self.LST_TEXTLIST, nCurSelect);
end

function uiSuperMapLinkUi:UpdateMyUi(szTitle, szAppendText)
	local szMyUiData	= KFile.ReadTxtFile("\\interface\\supermaplink\\myui.dll");
	local tbMyUi		= {};
	if (szMyUiData) then
		tbMyUi	= Lib:Str2Val(szMyUiData);
	end
	for i, tbText in ipairs(tbMyUi) do
		if (tbText[1] == szTitle) then
			if (szAppendText) then
				tbText[2]	= tbText[2] .. szAppendText;
			else
				tbText[2]	= "";
			end
			szTitle		= nil;
			break;
		end
	end
	if (szTitle) then
		tbMyUi[#tbMyUi + 1]	= {szTitle, szAppendText or ""};
	end
	
	local szWriteData	= "{\n\n";
	for i, tbText in ipairs(tbMyUi) do
		szWriteData	= szWriteData .. "{" .. Lib:StrVal2Str(tbText[1]) .. ",\n";
		szWriteData	= szWriteData .. "[===[\n" .. tbText[2] .. "]===]},\n\n";
	end
	szWriteData	= szWriteData .. "}\n";
	szWriteData	= Lib:ReplaceStrS(szWriteData, "\n", "\r\n");
	KFile.WriteFile("\\interface\\supermaplink\\myui.dll", szWriteData);
	
	self:RefreshList();
end

function uiSuperMapLinkUi:SelText(nIndex)
	local tbText	= self.tbTextList[nIndex];
	if (not tbText) then
		return;
	end
	
	local function fnStrVal(str)
		return tostring(Lib:Str2Val(str));
	end
	local szText	= string.gsub(tbText[2], "<=([^>]*)>", fnStrVal);
	Txt_SetTxt(self.UIGROUP, self.TXT_PAGETITLE, tbText[1]);
	TxtEx_SetText(self.UIGROUP, self.TXX_SHOW, szText);
end

function uiSuperMapLinkUi:OnButtonClick(szWnd, nParam)
	if (szWnd == self.BTN_SURE) then
		UiManager:CloseWindow(self.UIGROUP);
	elseif (szWnd == self.BTN_CANCEL) then
		UiManager:CloseWindow(self.UIGROUP);
	elseif (szWnd == self.BTN_CLOSE) then
		UiManager:CloseWindow(self.UIGROUP);
	end
end

function uiSuperMapLinkUi:OnListSel(szWnd, nParam)
	if (szWnd == self.LST_TEXTLIST) then
		Map.tbSuperMapLink.tbUserData.nUiSelect	= nParam;
		self:SelText(nParam);
	end
end

function uiSuperMapLinkUi:Link_mycmd_OnClick(szWnd, szLinkData)
	local szCmd		= szLinkData;
	local nAt		= string.find(szLinkData, ",");
	if (nAt) then
		szCmd		= string.sub(szLinkData, nAt + 1);
	end
	GM:DoCommand(szCmd);
	self:SelText(Map.tbSuperMapLink.tbUserData.nUiSelect);
end

function uiSuperMapLinkUi:Link_mycmd_GetText(szWnd, szLinkData)
	local szDesc	= szLinkData;
	local nAt		= string.find(szLinkData, ",");
	if (nAt) then
		szDesc		= string.sub(szLinkData, 1, nAt - 1);
	end
	return szDesc;
end

function uiSuperMapLinkUi:PickPos(szType)
	local nMapId, x, y	= me.GetWorldPos();
	
	local szPosText	= "";
	if (szType == "pos") then
		szPosText	= string.format("<link=pos:%s(%d.%d),%d,%d,%d>",
			GetMapNameFormId(nMapId), x / 8, y / 16, nMapId, x, y);
	elseif (szType == "npcpos" or szType == "npcid") then
		local tbAroundNpc	= KNpc.GetAroundNpcList(me, 20);
		local nMinLenSquare	= math.huge;
		local pNearNpc		= nil;
		for _, pNpc in ipairs(tbAroundNpc) do
			if (pNpc.nKind ~= 1) then
				local _, nNpcX, nNpcY	= pNpc.GetWorldPos();
				local nThisLenSquare	= (nNpcX - x) ^ 2 + (nNpcY - y) ^ 2;
				if (nThisLenSquare < nMinLenSquare) then
					nMinLenSquare	= nThisLenSquare;
					pNearNpc		= pNpc;
				end
			end
		end
		if (not pNearNpc) then
			me.Msg("Không tìm thấy Npc đứng gần");
			return;
		end
		if (szType == "npcpos") then
			local _, nNpcX, nNpcY	= pNearNpc.GetWorldPos();
			szPosText	= string.format("%s<link=pos:%s,%d,%d,%d>",
				GetMapNameFormId(nMapId), pNearNpc.szName, nMapId, nNpcX, nNpcY);
		else
			szPosText	= string.format("%s<link=npcpos:,%d,%d>",
				GetMapNameFormId(nMapId), nMapId, pNearNpc.nTemplateId);
		end
	end
	
	self:UpdateMyUi("<color=yellow>Những tọa độ đã đọc qua<color>", szPosText .. "\n");
end

function uiSuperMapLinkUi:ClearPick()
	self:UpdateMyUi("<color=yellow>Những tọa độ đã đọc qua<color>");
end

function uiSuperMapLinkUi:SendMyPos(szType)
	local nMapId, x, y	= me.GetWorldPos();
	local szPosText	= "";
	if (szType == "text") then
		szPosText	= string.format("Tôi đang ở %s(%d,%d)", GetMapNameFormId(nMapId), x / 8, y / 16);
	elseif (szType == "code") then
		szPosText	= string.format("MyPos: <%d,%d,%d>", nMapId, x, y);
	end
	SendChatMsg(szPosText);
end

function uiSuperMapLinkUi:OnRecvPos(szSendName, nMapId, nPosX, nPosY)
	local szLinkData	= string.format("%s(%d.%d),%d,%d,%d",
		GetMapNameFormId(nMapId), nPosX / 8, nPosY / 16, nMapId, nPosX, nPosY);
	
	if (Map.tbSuperMapLink.tbUserData.bAutoFollow == 1) then
		Map.tbSuperMapLink.szLastClickUiGroup	= nil;
		Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = szLinkData});
	end
	
	self:UpdateMyUi("Phối hợp Transceiver", string.format("%s<link=pos:%s>\n", szSendName, szLinkData));
end

function uiSuperMapLinkUi:ClearRecv()
	self:UpdateMyUi("Phối hợp Transceiver");
end

LoadUiGroup(Ui.UI_SUPERMAPLINK_UI, "maplink_ui.ini");
