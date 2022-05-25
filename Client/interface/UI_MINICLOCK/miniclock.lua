------miniclock-------
Ui.UI_MINICLOCK			= "UI_MINICLOCK";

local uiMiniClock		= Ui.tbWnd[Ui.UI_MINICLOCK] or {};	
uiMiniClock.UIGROUP		= Ui.UI_MINICLOCK;
Ui.tbWnd[Ui.UI_MINICLOCK] = uiMiniClock;

uiMiniClock.TXX_CTRL 	= "TxtCtrl";
uiMiniClock.TXX_TIME 	= "TxtTime";
uiMiniClock.WND_MAIN 	= "Main";

Ui:RegisterNewUiWindow("UI_MINICLOCK", "miniclock", {"a", 422, 605}, {"b", 533, 725}, {"c", 700, 755});

uiMiniClock.tbAllModeResolution	= {
	["a"]	= { 535,  605 },
	["b"]	= { 533, 725 },
	["c"]	= { 700, 755 },
};

uiMiniClock.tbTimeStyle	= {
	{"Characters",	" <font=24><bclr=red><color=white>%H:%M:%S"},
	{"Simple",	" %H:%M:%S"},
	{"Classic",	" %H:%M:<color=0xaaaaaa>%S "},
	{"Num",	" <font=24><color=black><bclr=white><bgclr=white>        <goto=4>%H:%M:<font=16><goto=76,8><color=white><bclr=gray><bgclr=black>  <tab=-3> <tab=-19>%S"},
	{"Full",	" %Y năm %m tháng %d ngày %H giờ %M phút %S giây"},
};

function uiMiniClock:OnEnterGame()
	if (not self.szCurStyle) then
		self:SetStyle(1);
	end
	local function fnOnTimer()
		self:OnTimer();
	end
	Ui.tbLogic.tbTimer:Register(Env.GAME_FPS / 2, fnOnTimer);
	--LoadUiGroup(Ui.UI_MINICLOCK, "miniclock.ini");
	UiManager:OpenWindow(self.UIGROUP);
end

function uiMiniClock:OnOpen()
	TxtEx_SetText(self.UIGROUP, self.TXX_CTRL, "");
end

function uiMiniClock:OnTimer()
	if (self.bTempText ~= 1) then
		local szText	= os.date(self.szCurStyle, GetTime());
		Wnd_SetSize(self.UIGROUP, self.TXX_TIME, 0, 0);
		TxtEx_SetText(self.UIGROUP, self.TXX_TIME, szText);
	end
	
	local nWidth, nHeight	= Wnd_GetSize(self.UIGROUP, self.TXX_TIME);
	nWidth	= nWidth + 10;
	Wnd_SetSize(self.UIGROUP, self.WND_MAIN, nWidth, nHeight);
	
	local nCurX, nCurY	= Wnd_GetPos(self.UIGROUP, self.WND_MAIN);
	local tbModeResolution	= self.tbAllModeResolution[GetUiMode()];
	local nNewX	= math.min(math.max(0, nCurX), tbModeResolution[1] - nWidth);
	local nNewY	= math.min(math.max(0, nCurY), tbModeResolution[2] - nHeight);
	Wnd_SetPos(self.UIGROUP, self.WND_MAIN, nNewX, nNewY);
end

function uiMiniClock:Link_mycmd_OnClick(szWnd, szLinkData)
	local szCmd		= szLinkData;
	local nAt		= string.find(szLinkData, ",");
	if (nAt) then
		szCmd		= string.sub(szLinkData, nAt + 1);
	end
	GM:DoCommand(szCmd);
end

function uiMiniClock:Link_mycmd_GetText(szWnd, szLinkData)
	local szDesc	= szLinkData;
	local nAt		= string.find(szLinkData, ",");
	if (nAt) then
		szDesc		= string.sub(szLinkData, 1, nAt - 1);
	end
	return szDesc;
end

function uiMiniClock:_Init()
	self.EnterGame_bak	= self.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		uiMiniClock.EnterGame_bak(Ui);
		uiMiniClock:OnEnterGame();
	end
	print("MiniClock Loaded!");
end

function uiMiniClock:Reload()
	self.bTempText	= 0;
	
    local function fnDoScript(szFilePath)
        local szFileData    = KFile.ReadTxtFile(szFilePath);
        assert(loadstring(szFileData, szFilePath))();
    end
	fnDoScript("\\interface\\ui_miniclock\\miniclock.lua")
	
	local function fnReload()
--		LoadUiGroup(self.UIGROUP, "miniclock.ini");
		UiManager:OpenWindow(self.UIGROUP);
		return 0;
	end
	Ui.tbLogic.tbTimer:Register(1, fnReload);
end

function uiMiniClock:SetStyle(nIndex)
	self.bTempText	= 0;
	
	self.szCurStyle	= self.tbTimeStyle[nIndex][2];
end

function uiMiniClock:Menu()
	if (self.bTempText == 1) then
		self.bTempText	= 0;
		return;
	end
	
	local szText	= "Minilock KT\n\nChọn dạng hiển thị:\n"
	for i, tbStyle in ipairs(self.tbTimeStyle) do
		szText	= szText .. string.format("T<link=mycmd:%s,Ui(Ui.UI_MINICLOCK):SetStyle(%d)>\n", tbStyle[1], i);
	end
	
	szText	= szText .. "\n<link=mycmd:Cập nhật,Ui(Ui.UI_MINICLOCK):Reload()>\n";
	
	TxtEx_SetText(self.UIGROUP, self.TXX_TIME, szText);
	
	self.bTempText	= 1;
end

uiMiniClock:_Init();
