-- ====================== Auto săn HT H2N ======================

Ui.UI_AUTODADAO = "UI_AUTODADAO";
local uiAutoDaDao = Ui.tbWnd[Ui.UI_AUTODADAO] or {};	
uiAutoDaDao.UIGROUP = Ui.UI_AUTODADAO;
Ui.tbWnd[Ui.UI_AUTODADAO] = uiAutoDaDao;
local self = uiAutoDaDao;

uiAutoDaDao.BTN_CLOSE		= "BtnClose";
uiAutoDaDao.BTN_SAVE		= "BtnSave";
uiAutoDaDao.BTN_CANCEL		= "BtnCancel";
uiAutoDaDao.BTN_START		= "BtnStart";
uiAutoDaDao.BTN_SHEZHI		= "BtnShezhi";
uiAutoDaDao.CMB_CITYMAP		= "CmbCityMap";
uiAutoDaDao.CHK_DANSHUA		= "ChkDanShua";
uiAutoDaDao.CHK_QUNSHUA		= "ChkQunShua";
uiAutoDaDao.CHK_LBVD		= "ChkLBVD";
uiAutoDaDao.CHK_Thoat		= "ChkThoat";
uiAutoDaDao.CHK_Luyen		= "ChkLuyen";
uiAutoDaDao.CHK_NMChien		= "ChkNMChien";
uiAutoDaDao.CHK_THROWALL	= "ChkThrowAll";
uiAutoDaDao.TXT_BEFWAITTIME	= "TxtBefWaitTimeDisplay";
uiAutoDaDao.SCR_BEFWAITTIME	= "ScrBefWaitTime";
uiAutoDaDao.TXT_AFTWAITTIME	= "TxtAftWaitTimeDisplay";
uiAutoDaDao.SCR_AFTWAITTIME	= "ScrAftWaitTime";
uiAutoDaDao.EDT_BUYREDNUM	= "EdtBuyRedNum";
uiAutoDaDao.BTN_ADDREDNUM	= "BtnAddRedNum";
uiAutoDaDao.BTN_DECREDNUM	= "BtnDecRedNum";
uiAutoDaDao.CMB_TASKLEVEL	= "CmbTaskLevel";
uiAutoDaDao.CMB_RED	        = "CmbRed";


self.DATA_KEY	= "AutoDaDaoSetting";
self.tbSetting	= {};
self.TaskLevel	= {"Nhiệm vụ 90", "Nhiệm vụ 80", "Nhiệm vụ 70", "Nhiệm vụ 60", "Nhiệm vụ 50"};

self.tbCityMap	= {
		{"Biện Kinh Phủ", 23},
		{"Phượng Tường Phủ", 24},
		{"Tương Dương Phủ", 25},
		{"Dương Châu Phủ", 26},
		{"Thành Đô Phủ", 27},
		{"Đại Lý Phủ", 28},
		{"Lâm An Phủ", 29},
	};

self.tbRed	= {
		{"Máu 100 điểm","Kim Sáng Dược (tiểu)"},
		{"Máu 200 điểm","Kim Sáng Dược (trung)"},
		{"Máu 300 điểm","Kim Sáng Dược (đại)"},
		{"Máu 400 điểm","Hồi Thiên Đơn"},
		{"Máu 500 điểm(max)","Cửu Chuyển Hoàn Hồn Đơn"},
		{"Mana 100 điểm","Ngưng Thần Đơn (tiểu)"},
		{"Mana 200 điểm","Ngưng Thần Đơn (trung)"},
		{"Mana 300 điểm","Ngưng Thần Đơn (đại)"},
		{"Mana 400 điểm","Đại Bổ Tán"},
		{"Mana 500 điểm(max)","Thủ Ô Hoàn Thần Đơn"},
	};

self.STUFF_LIST = {
	["Thịt xào măng"] = {"Thịt xào măng", 821, 821, 19, 3, 1, 1},
	["Đậu tứ quý"] = {"Đậu tứ quý", 822, 822, 19, 3, 1, 2},
	["Đậu Hòa Lan xào"] = {"Đậu Hòa Lan", 823, 823, 19, 3, 1, 3},
	["Cải xào tỏi"] = {"Cải xào tỏi", 824, 824, 19, 3, 1, 4},
	["Ngọc trúc mai hoa"] = {"Ngọc trúc mai hoa", 825, 825, 19, 3, 1, 5},

	["Kim Sáng Dược (tiểu)"] = {"Kim Sáng Dược (tiểu)", 676, 676, 17, 1, 1, 1},
	["Kim Sáng Dược (trung)"] = {"Kim Sáng Dược (trung)", 677, 677, 17, 1, 1, 2},
	["Kim Sáng Dược (đại)"] = {"Kim Sáng Dược (đại)", 678, 678, 17, 1, 1, 3},
	["Hồi Thiên Đơn"] = {"Hồi Thiên Đơn", 679, 679, 17, 1, 1, 4},
	["Cửu Chuyển Hoàn Hồn Đơn"] = {"Cửu Chuyển Hoàn Hồn Đơn", 680, 680, 17, 1, 1, 5},

	["Ngưng Thần Đơn (tiểu)"] = {"Ngưng Thần Đơn (tiểu)", 681, 681, 17, 2, 1, 1},
	["Ngưng Thần Đơn (trung)"] = {"Ngưng Thần Đơn (trung)", 682, 682, 17, 2, 1, 2},
	["Ngưng Thần Đơn (đại)"] = {"Ngưng Thần Đơn (đại)", 683, 683, 17, 2, 1, 3},
	["Đại Bổ Tán"] = {"Đại Bổ Tán", 684, 684, 17, 2, 1, 4},
	["Thủ Ô Hoàn Thần Đơn"] = {"Thủ Ô Hoàn Thần Đơn", 685, 685, 17, 2, 1, 5},

	["Thừa tiên mật (tiểu)"] = {"Thừa tiên mật (tiểu)", 686, 686, 17, 3, 1, 1},
	["Thừa tiên mật (trung)"] = {"Thừa tiên mật (trung)", 687, 687, 17, 3, 1, 2},
	["Thừa tiên mật (đại)"] = {"Thừa tiên mật (đại)", 688, 688, 17, 3, 1, 3},
	["Thất xảo bổ tâm đơn"] = {"Thất xảo bổ tâm đơn", 689, 689, 17, 3, 1, 4},
	["Ngũ hoa ngọc lộ hoàn"] = {"Ngũ hoa ngọc lộ hoàn", 690, 690, 17, 3, 1, 5},
}

local status		= 0;
local nRunning		= 0;
local nArrival		= 0;
local nWaitTimes	= 0;
local nWantedTimerId	= 0;
local nFinishTimes	= 0;
local ConfirmFinish	= 0;
local nCloseUiTimerId	= 0;
local nWaitstats	= 0;
local nSelectOn		= 0;
local nTaskClass	= 0;
local pWantedTime	= 2;	-- 检测频率
local pCloseUiTime	= 3;	-- 等候3秒关闭窗口
local nWantedState	= 0;	-- 自动大盗开启状态
local nTaskNpcPosX	= 207;	-- 扬州刑部捕头X坐标
local nTaskNpcPosY	= 197;	-- 扬州刑部捕头Y坐标
local tbTeamLeader	= {};	-- 记录已经申请加入过的队伍

local tCmd={ "UiManager:SwitchWindow(Ui.UI_AUTODADAO)", "autothief", "", "Ctrl+Shift+3", "Ctrl+Shift+3", "autothief" };
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	--：Ctrl+Shift+3

function uiAutoDaDao:Init()

end


function uiAutoDaDao:OnOpen()
	self:LoadSetting();

	Wnd_SetFocus(self.UIGROUP, self.EDT_BUYREDNUM);

	ClearComboBoxItem(self.UIGROUP, self.CMB_CITYMAP);
	for i = 1, #self.tbCityMap do
		ComboBoxAddItem(self.UIGROUP, self.CMB_CITYMAP, i, self.tbCityMap[i][1]);
	end

	ClearComboBoxItem(self.UIGROUP, self.CMB_TASKLEVEL);
	for i = 1, #self.TaskLevel do
		ComboBoxAddItem(self.UIGROUP, self.CMB_TASKLEVEL, i, self.TaskLevel[i]);
	end

	ClearComboBoxItem(self.UIGROUP, self.CMB_RED);
	for i = 1, #self.tbRed do
		ComboBoxAddItem(self.UIGROUP, self.CMB_RED, i, self.tbRed[i][1]);
	end


	self:UpdateControlButton();
	self:UpdateCheckButton();
	self:UpdateScorllBar();
	self:UpdateEdit();
	self:UpdateComboBox();
end

function uiAutoDaDao:LoadSetting()
	self.tbSetting	= self:Load(self.DATA_KEY..tostring(me.nFaction)) or {};
	if not self.tbSetting.nCityMapID then
		self.tbSetting.nCityMapID = 3;
	end
	if not self.tbSetting.nDanShua then
		self.tbSetting.nDanShua = 0;
	end
	if not self.tbSetting.CHK_LBVD then
		self.tbSetting.CHK_LBVD = 0;
	end
	if not self.tbSetting.CHK_Luyen then
		self.tbSetting.CHK_Luyen = 0;
	end
	if not self.tbSetting.CHK_Thoat then
		self.tbSetting.CHK_Thoat = 1;
	end
	if not self.tbSetting.nNMChien then
		self.tbSetting.nNMChien = 0;
	end
	if not self.tbSetting.nThrowAll then
		self.tbSetting.nThrowAll = 0;
	end
	if not self.tbSetting.nBefWaitTime then
		self.tbSetting.nBefWaitTime = 0;
	end
	if not self.tbSetting.nAftWaitTime then
		self.tbSetting.nAftWaitTime = 0;
	end
	if not self.tbSetting.nBuyRedNum then
		self.tbSetting.nBuyRedNum = 0;
	end
	if not self.tbSetting.nTaskLevelID then
		self.tbSetting.nTaskLevelID = 0;
	end

	if not self.tbSetting.nRed then
		self.tbSetting.nRed = 4;
	end
end


function uiAutoDaDao:OnButtonClick(szWnd, nParam)
	if (szWnd == self.BTN_CLOSE) then		
		UiManager:CloseWindow(self.UIGROUP);
		self:LoadSetting();
	elseif (szWnd == self.BTN_SAVE) then	
		self:SaveData();
		self:Test();
		me.Msg("Lưu thông tin truy nã thành công ");
	elseif (szWnd == self.BTN_CANCEL) then	
		self:LoadSetting();
	elseif (szWnd == self.BTN_START) then	
		if (nWantedState == 0) then
			self:SaveData();
			UiManager:CloseWindow(self.UIGROUP);
			self:SwitchWantedTask();
			UiManager:SwitchWindow(Ui.UI_AUTODADAO);
			self:Test();
		else
			self:SwitchWantedTask();
			self:UpdateControlButton();
		end
	elseif (szWnd == self.BTN_SHEZHI) then	
           self.ScrReload();
	elseif (szWnd == self.CHK_DANSHUA) then	
		if (nParam == 1) then
			Btn_Check(self.UIGROUP, self.CHK_QUNSHUA, 0);
			self.tbSetting.nDanShua = 1;
		else
			Btn_Check(self.UIGROUP, self.CHK_QUNSHUA, 1);
			self.tbSetting.nDanShua = 0;
		end
	elseif (szWnd == self.CHK_QUNSHUA) then	
		if (nParam == 1) then
			self.tbSetting.nDanShua = 0;
			Btn_Check(self.UIGROUP, self.CHK_DANSHUA, 0);
		else
			self.tbSetting.nDanShua = 1;
			Btn_Check(self.UIGROUP, self.CHK_DANSHUA, 1);
		end
	elseif (szWnd == self.CHK_LBVD) then
		if (nParam == 1) then
			Btn_Check(self.UIGROUP, self.CHK_LBVD, 1);
			Btn_Check(self.UIGROUP, self.CHK_Thoat, 0);
			Btn_Check(self.UIGROUP, self.CHK_Luyen, 0);
			self.tbSetting.CHK_LBVD = 1;
			self.tbSetting.CHK_Thoat = 0;
			self.tbSetting.CHK_Luyen = 0;
		end	
	elseif (szWnd == self.CHK_Thoat) then
		if (nParam == 1) then
			Btn_Check(self.UIGROUP, self.CHK_LBVD, 0);
			Btn_Check(self.UIGROUP, self.CHK_Thoat, 1);
			Btn_Check(self.UIGROUP, self.CHK_Luyen, 0);
			self.tbSetting.CHK_LBVD = 0;
			self.tbSetting.CHK_Thoat = 1;
			self.tbSetting.CHK_Luyen = 0;
		end
	elseif (szWnd == self.CHK_Luyen) then
		if (nParam == 1) then
			Btn_Check(self.UIGROUP, self.CHK_LBVD, 0);
			Btn_Check(self.UIGROUP, self.CHK_Thoat, 0);
			Btn_Check(self.UIGROUP, self.CHK_Luyen, 1);
			self.tbSetting.CHK_LBVD = 0;
			self.tbSetting.CHK_Thoat = 0;
			self.tbSetting.CHK_Luyen = 1;
		end
	elseif (szWnd == self.CHK_NMChien) then	
		self.tbSetting.nNMChien = nParam;
	elseif (szWnd == self.CHK_THROWALL) then	
		self.tbSetting.nThrowAll = nParam;
		if (nParam == 1) then
			Wnd_SetEnable(self.UIGROUP, self.CMB_TASKLEVEL, 0);
		else
			Wnd_SetEnable(self.UIGROUP, self.CMB_TASKLEVEL, 1);
		end
	elseif (szWnd == self.BTN_ADDREDNUM) then	
		Edt_SetInt(self.UIGROUP, self.EDT_BUYREDNUM, self.tbSetting.nBuyRedNum + 1);

	elseif (szWnd == self.BTN_DECREDNUM) then	
		Edt_SetInt(self.UIGROUP, self.EDT_BUYREDNUM, self.tbSetting.nBuyRedNum - 1);

	end
end


function uiAutoDaDao:UpdateControlButton()
	local szMsg = "";
	if (nWantedState == 0) then		
		szMsg = "Bắt đầu";
	else
		szMsg = "Kết thúc";
	end
	Btn_SetTxt(self.UIGROUP, self.BTN_START, szMsg);
end


function uiAutoDaDao:UpdateCheckButton()
	if (self.tbSetting.nDanShua == 1) then
		Btn_Check(self.UIGROUP, self.CHK_DANSHUA, 1);
		Btn_Check(self.UIGROUP, self.CHK_QUNSHUA, 0);
	else
		Btn_Check(self.UIGROUP, self.CHK_DANSHUA, 0);
		Btn_Check(self.UIGROUP, self.CHK_QUNSHUA, 1);
	end
	Btn_Check(self.UIGROUP, self.CHK_LBVD, self.tbSetting.CHK_LBVD);
	Btn_Check(self.UIGROUP, self.CHK_Thoat, self.tbSetting.CHK_Thoat);
	Btn_Check(self.UIGROUP, self.CHK_Luyen, self.tbSetting.CHK_Luyen);
	Btn_Check(self.UIGROUP, self.CHK_NMChien, self.tbSetting.nNMChien);
	Btn_Check(self.UIGROUP, self.CHK_THROWALL, self.tbSetting.nThrowAll);
end


function uiAutoDaDao:OnScorllbarPosChanged(szWnd, nParam)
	if szWnd == self.SCR_BEFWAITTIME then
		self.tbSetting.nBefWaitTime = nParam;
	end
	if szWnd == self.SCR_AFTWAITTIME then
		self.tbSetting.nAftWaitTime = nParam;
	end
	self:UpdateScorllBar();
end


function uiAutoDaDao:UpdateScorllBar()
	ScrBar_SetCurValue(self.UIGROUP, self.SCR_BEFWAITTIME, self.tbSetting.nBefWaitTime);
	local szText = string.format(" <color=gold>%s<color>", self.tbSetting.nBefWaitTime) .." giây";
	Txt_SetTxt(self.UIGROUP, self.TXT_BEFWAITTIME, szText);

	ScrBar_SetCurValue(self.UIGROUP, self.SCR_AFTWAITTIME, self.tbSetting.nAftWaitTime);
	local szText = string.format(" <color=gold>%s<color>", self.tbSetting.nAftWaitTime) .." giây";
	Txt_SetTxt(self.UIGROUP, self.TXT_AFTWAITTIME, szText);
end


function uiAutoDaDao:OnComboBoxIndexChange(szWnd, nIndex)
	if (szWnd == self.CMB_CITYMAP) then
		self.tbSetting.nCityMapID = nIndex;
	end

	if (szWnd == self.CMB_TASKLEVEL) then
		self.tbSetting.nTaskLevelID = nIndex;
	end

	if (szWnd == self.CMB_RED) then
		self.tbSetting.nRed = nIndex;
	end
end


function uiAutoDaDao:UpdateComboBox()
	ComboBoxSelectItem(self.UIGROUP, self.CMB_CITYMAP, self.tbSetting.nCityMapID);
	Wnd_SetEnable(self.UIGROUP, self.CMB_TASKLEVEL, 1);
	ComboBoxSelectItem(self.UIGROUP, self.CMB_TASKLEVEL, self.tbSetting.nTaskLevelID);
	ComboBoxSelectItem(self.UIGROUP, self.CMB_RED, self.tbSetting.nRed);
end

function uiAutoDaDao:OnEditChange(szWndName, nParam)
	if (szWndName == self.EDT_BUYREDNUM) then
		local nNum = Edt_GetInt(self.UIGROUP, self.EDT_BUYREDNUM);
		if (nNum == self.tbSetting.nBuyRedNum) then		-- 防止死循环
			return;
		end
		if (nNum < 0) then
			nNum = 0;
		end
		self.tbSetting.nBuyRedNum = nNum;
		self:UpdateEdit();
	end
end

function uiAutoDaDao:OnEditEnter(szWnd)
	if (szWnd == self.EDT_BUYREDNUM) then
		self:OnButtonClick(self.BTN_SAVE, 0);
	end
end

function uiAutoDaDao:UpdateEdit()
	Edt_SetInt(self.UIGROUP, self.EDT_BUYREDNUM, self.tbSetting.nBuyRedNum);
end

function uiAutoDaDao:SaveData()
	self:Save(self.DATA_KEY..tostring(me.nFaction), self.tbSetting);
end

function uiAutoDaDao:Save(szKey, tbData)
	self.m_szFilePath="\\user\\Dadao\\"..me.szName..".dat";
	self.m_tbData[szKey] = tbData;
	local szData = Lib:Val2Str(self.m_tbData);
	assert(self.m_szFilePath);

	if self:CheckErrorData(szData) == 1 then
		KIo.WriteFile(self.m_szFilePath, szData);
	else
		local szSaveData = Lib:Val2Str(tbData);
	end
end

function uiAutoDaDao:Load(key)
	self.m_szFilePath="\\user\\Dadao\\"..me.szName..".dat";
	self.m_tbData = {};
	local szData = KIo.ReadTxtFile(self.m_szFilePath);

	if (szData) then
		if self:CheckErrorData(szData) == 1 then	
			self.m_tbData = Lib:Str2Val(szData);
		else
			KIo.WriteFile(self.m_szFilePath, "nil");
		end
	end
	local tbData = self.m_tbData[key];
	return tbData
end

function uiAutoDaDao:CheckErrorData(szDate)
	if szDate ~= "" then
		if string.find(szDate, "Ptr:") and string.find(szDate, "ClassName:") then
			return 0;
		end
		if (not Lib:CallBack({"Lib:Str2Val", szDate})) then	
			return 0;
		end
	end
	return 1;
end

function uiAutoDaDao:SwitchWantedTask()
	if nWantedState == 0 then
		self:GetWantedTaskStatus();
		if (status == 1) then
			me.Msg("Cấp độ nhân vật chưa đủ!");
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Cấp độ nhân vật chưa đủ!<color>");
			return;
		end
		Ui(Ui.UI_AUTOFIGHT):LoadSetting();
		local nLifeRet = Ui(Ui.UI_AUTOFIGHT).nLifeRet;	
		if (nLifeRet > 75) then
			me.Msg("<color=yellow>Tự-chiến thiết lập để ăn nhiều hơn 75% máu đỏ cần phải được điều chỉnh!<color>");
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tự-chiến thiết lập để ăn nhiều hơn 75% máu đỏ cần phải được điều chỉnh!<color>");
			return;
		end
		nWantedState = 1;
		nWaitstats = 1;
		self.nLeader = 0;
		nSelectOn = 1;
		me.Msg("<color=yellow>Bật tự làm truy nã lệnh (Ctrl+3)<color>");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bật tự làm truy nã lệnh<color>");
		nWantedTimerId = Ui.tbLogic.tbTimer:Register(pWantedTime * Env.GAME_FPS, self.OnWantedTaskTimer, self);
	else
		nWantedState = 0;
		me.Msg("<color=yellow>Tắt tự làm truy nã lệnh (Ctrl+3)<color>");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt tự làm truy nã lệnh<color>");
		self:StopAutoFight();
		Ui.tbLogic.tbTimer:Close(nWantedTimerId);
		nWantedTimerId = 0;
		nArrival = 0;
		if (nCloseUiTimerId > 0) then
			Ui.tbLogic.tbTimer:Close(nCloseUiTimerId);
			nCloseUiTimerId = 0;
		end
	end
end


function uiAutoDaDao:HaiTacOn()
	if nWantedState == 0 then
		uiAutoDaDao:SwitchWantedTask();
	end
end

function uiAutoDaDao:HaiTacOff()
	if nWantedState == 1 then
		uiAutoDaDao:SwitchWantedTask();
	end
end

function uiAutoDaDao:OnWantedTaskTimer()
	self:GetWantedTaskStatus();
	self:IsMoving();
	self:WantedTaskFlow();
end

function uiAutoDaDao:WantedTaskFlow()
	if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1) then
		return; 
	end

	local nAllotModel, tbMemberList = me.GetTeamInfo();
	local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
	--if (me.IsDead() == 1) and (me.nTeamId) > 0  and (nTeamLeader == 1)then	-- 如果是队长，死了马上回去复活，活了再来
		--me.SendClientCmdRevive(0);	-- 死亡回城
		--self:StopAutoFight();
		--nArrival = 0;
		--return;
	--end
	if (me.IsDead() == 1) and (status == 3) then
		me.SendClientCmdRevive(0);	
		self:StopAutoFight();
		return;
	end
	if (status == 1) then
		self:FinishConfirm();
	elseif (status == 2) then
		self:GetKillNpcTask(88);
	elseif (status == 3) then
		if (me.IsDead() == 1) then
			me.SendClientCmdRevive(0);
			self:StopAutoFight();
			return;
		end
		if (me.nAutoFightState ~= 1) then
			AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey()); 
		end
		local nNearby = self:IsNearbyNpcPos();
		if (nNearby == 1 and nWaitTimes < self.tbSetting.nAftWaitTime) then
			nWaitTimes = nWaitTimes + 1;		
			return 0;
		end
		self:StopAutoFight();

		local nMyMapId,nMyPosX,nMyPosY = me.GetWorldPos();
		if (nMyMapId == 115) then
			self:MoveToSafePos();
			if (nNearby == 0) then
				local _,nWorldPosX,nWorldPosY = me.GetWorldPos();
				me.AutoPath(nWorldPosX,nWorldPosY);	
				self:FinishKillNpcTask();
			end
		else
			self:FinishKillNpcTask();
		end
		nWaitTimes = 0;
		nArrival = 0;
	elseif (status == 4) then
		self:StopAutoFight();
		self:CloseUiWindow();
		if (nWaitTimes < 5) then
			nWaitTimes = nWaitTimes + 1;	
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
				UiManager:CloseWindow(Ui.UI_SAYPANEL)
			end
			if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
				UiManager:CloseWindow(Ui.UI_GUTAWARD)
			end
			return 0;
		end
		local nSubTaskId = me.GetTask(Wanted.TASK_GROUP,Wanted.TASK_ACCEPT_ID);
		local nTaskName,nMapId,nKillNpcId,nPosX,nPosY = self:GetWantedTaskInfo(nSubTaskId);
		self:GoToKillNpcPos(nMapId,nKillNpcId);
		local nSubTaskId  = me.GetTask(Wanted.TASK_GROUP,Wanted.TASK_ACCEPT_ID);
		local nTaskName,nMapId,nKillNpcId,nPosX,nPosY = self:GetWantedTaskInfo(nSubTaskId);
		local szPosText = string.format("MyPos: <%d,%d,%d>", nMapId, nPosX, nPosY);
	elseif (status == 5) then
		self:CastAssistSkill();	
		return;		
	elseif (status == 6) then
		if (me.nFaction == 5 and me.CanCastSkill(98) == 1) and (self.tbSetting.nNMChien == 0) then
			nArrival = 1;
			self:StopAutoFight();
			me.UseSkill(98,GetCursorPos());	
		else
			nArrival = 1;
			self:SetKillNpcTarget();	
			if (me.nAutoFightState ~= 1) then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());	
			end
			local bChecked = me.GetNpc().IsRideHorse();	
			local tbSkillInfo = KFightSkill.GetSkillInfo(me.nLeftSkill, 1);	
			if (tbSkillInfo.nHorseLimited == 1 and bChecked == 1) then
				Switch([[horse]]);	
			end
		end
	elseif (status == 7) then
		local nRedInBag   = self:GetItemCountByName(self.tbRed[self.tbSetting.nRed + 1][2]);
		local nNum = self.tbSetting.nBuyRedNum - nRedInBag;
		self:BuyRed(self.tbRed[self.tbSetting.nRed + 1][2], nNum);	
	end
end


function uiAutoDaDao:GetWantedTaskStatus()
	local nSubTaskId  = me.GetTask(Wanted.TASK_GROUP,Wanted.TASK_ACCEPT_ID); 
	local nTaskCount  = me.GetTask(Wanted.TASK_GROUP,Wanted.TASK_COUNT);     
	local nTaskFinish = me.GetTask(Wanted.TASK_GROUP,Wanted.TASK_FINISH);   
	local nRedInBag   = self:GetItemCountByName(self.tbRed[self.tbSetting.nRed + 1][2]);
	local nCountFree  = me.CountFreeBagCell();

	if (nSubTaskId == 0 and nTaskCount == 0) then
		status = 1;	
	elseif (nSubTaskId == 0 and nTaskCount > 0) then
		status = 2;	
		self:IsMoving();
		if (nRunning == 1) then
			status = 5;	
		elseif (me.nFightState ~= 1 and nRedInBag < self.tbSetting.nBuyRedNum and nCountFree > 1) then
			status = 7;	
		end
	elseif (nSubTaskId > 0 and nTaskFinish == 0) then
		status = 3;	
		local nMyMapId,nMyPosX,nMyPosY = me.GetWorldPos();
		if (nMyMapId <30 and nMyMapId >22) and (self.tbSetting.nThrowAll == 1) then
		AutoAi:SwitchAutoThrowAway(0,0,1)
		end
		self:IsMoving();
		if (nRunning == 1) and me.nAutoFightState ~=1 then
			status = 5;	
		end
	elseif (nSubTaskId > 0 and nTaskFinish == 1) then
		local nAtNpcPos = self:IsArrival();
		if (nAtNpcPos == 1 or nArrival == 1) then
			status = 6;	
		elseif (nRunning == 0) then
			status = 4;	
		else
			status = 5;	
		end
	end
end

function uiAutoDaDao:GoToKillNpcPos(nMapId, nKillNpcId)
	local szLink = ","..nMapId..","..nKillNpcId;
	UiManager.tbLinkClass["npcpos"]:OnClick(szLink);
	if (nCloseUiTimerId == 0) then
		nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
	end
end

function uiAutoDaDao:GetTaskClass()
	local nAllotModel, tbMemberList = me.GetTeamInfo();
	local tbMember = me.GetTeamMemberInfo()
	local nMemberCount = #tbMember
	local IsCaptain=1
	for i = 1, #tbMember do
		if tbMember[i].nLeader == 1 then
			IsCaptain=0
		end
	end
	if me.nTeamId > 0 then			
		local nTeamLeader = Ui(Ui.UI_TEAM):IsTeamLeader();
		if (nTeamLeader == 1 and self.tbSetting.nDanShua == 0 and  nMemberCount ~= 0) then	
			nTaskClass = 1;
		elseif (nTeamLeader == 1 and self.tbSetting.nDanShua == 1) then		
			nTaskClass = 2;
		elseif (nTeamLeader == 1 and nMemberCount == 0) then		
			nTaskClass = 2;
		elseif (nTeamLeader == 0 and self.tbSetting.nDanShua == 0) then		
			nTaskClass = 3;
		elseif (nTeamLeader == 0 and self.tbSetting.nDanShua == 1) then	
			nTaskClass = 4;
		end
	else						
		nTaskClass = 4;
	end
	nFinishTimes = nMemberCount;
end

function uiAutoDaDao:GetKillNpcTask(pLevel)

	local nTaskMapID = self.tbCityMap[self.tbSetting.nCityMapID + 1][2];
	local nTaskMapLink = {szType = "npcpos", szLink = ","..nTaskMapID..",2994"};
	local nLevel = self:GetKillNpcLevel(pLevel);
  	if (nLevel < 0) then
		return;  
	end
	if (self.tbSetting.nNMChien ~= 1) then
		nLevel = (5 - self.tbSetting.nTaskLevelID);
	end
	self:GetTaskClass();
	if (nTaskClass == 1) then
		me.Msg("Chủ pt dẫn nhóm đi săn , No.")
		if (nWaitTimes < self.tbSetting.nBefWaitTime) then
			nWaitTimes = nWaitTimes + 1;
				if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
				UiManager:CloseWindow(Ui.UI_SAYPANEL)
			end
			if (UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1) then
				UiManager:CloseWindow(Ui.UI_GUTAWARD)
			end
			return 0;
		end
		Map.tbSuperMapLink:StartGoto(nTaskMapLink);
		local nId = uiAutoDaDao:GetAroundNpcId(2994);
		if nId then
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
				AutoAi.SetTargetIndex(nId)
			end
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and nSelectOn == 1) then
				me.AnswerQestion(0)
				nSelectOn = 2
			end
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and nSelectOn == 2) then
				me.AnswerQestion(nLevel - 1)
				nSelectOn = 3
			end
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and nSelectOn == 3) then
				me.AnswerQestion(0)
				nSelectOn = 4
				UiManager:CloseWindow(Ui.UI_SAYPANEL)
			end
		end
	elseif (nTaskClass == 2) then
		me.Msg("Nhóm 1 người săn Hải Tặc ^^")
		Map.tbSuperMapLink:StartGoto(nTaskMapLink);
		local nId = uiAutoDaDao:GetAroundNpcId(2994);
		if nId then
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
				AutoAi.SetTargetIndex(nId)
			end
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and nSelectOn == 1) then
				me.AnswerQestion(1)
				nSelectOn = 2
			end
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and nSelectOn == 2) then
				me.AnswerQestion(nLevel - 1)
				nSelectOn = 3
			end
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and nSelectOn == 3) then
				me.AnswerQestion(0)
				UiManager:CloseWindow(Ui.UI_SAYPANEL)
			end
		end
	elseif (nTaskClass == 3) then
		me.Msg("Theo chủ pt , ta là lính :P")
		if nWaitstats == 1 then
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
				UiManager:CloseWindow(Ui.UI_SAYPANEL)
			end
			nWaitstats = 2;
		elseif nWaitstats == 0 or nWaitstats == 2 then
			local uiSayPannel = Ui(Ui.UI_SAYPANEL);
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
				me.AnswerQestion(0);
				UiManager:CloseWindow(Ui.UI_SAYPANEL)
			end
		end
	elseif (nTaskClass == 4) then
		me.Msg("Đơn thương độc mã tự làm truy nã")
		Map.tbSuperMapLink:StartGoto(nTaskMapLink);
		local nId = uiAutoDaDao:GetAroundNpcId(2994);
		if nId then
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
				AutoAi.SetTargetIndex(nId)
			end
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and nSelectOn == 1) then
				me.AnswerQestion(0);
				nSelectOn = 2
			end
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 and nSelectOn == 2) then
				me.AnswerQestion(nLevel - 1);
				UiManager:CloseWindow(Ui.UI_SAYPANEL)
			end
		end
	end
end

function uiAutoDaDao:FinishKillNpcTask()
	local nCountFree = me.CountFreeBagCell();
	if (nCountFree == 0) then
		AutoAi.Eat(1); 
	end
	local nTaskMapID = self.tbCityMap[self.tbSetting.nCityMapID + 1][2];
	local nTaskMapLink = {szType = "npcpos", szLink = ","..nTaskMapID..",2994"};
	Map.tbSuperMapLink:StartGoto(nTaskMapLink);
	local nId = uiAutoDaDao:GetAroundNpcId(2994)
	if nId then
		if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
			AutoAi.SetTargetIndex(nId)
		end
		if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
			me.AnswerQestion(0)
			UiManager:CloseWindow(Ui.UI_SAYPANEL)
		end
		if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
			local uiGutAward = Ui(Ui.UI_GUTAWARD)
			uiGutAward.OnButtonClick(uiGutAward, "zBtnAccept");
			UiManager:CloseWindow(Ui.UI_GUTAWARD)
			local nTaskNum = me.GetTask(2040,2);
			if nTaskNum>0 then
			else
			uiAutoDaDao:HaiTacOff();
			--self:TeamLeave();
			end
		end
		nWaitstats = 1
		nSelectOn = 1
	end
end

uiAutoDaDao.GetAroundNpcId = function(self,nTempId)
	local tbAroundNpc = KNpc.GetAroundNpcList(me, 20);
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == nTempId) then	
			return pNpc.nIndex
		end
	end
	return
end

function uiAutoDaDao:GetKillNpcLevel(pLevel)
	local nLevel = 0;
	nLevel = math.floor(pLevel/10) - 3; 
	if (nLevel > 5) then
		nLevel = 5;
	end
	return nLevel;
end

function uiAutoDaDao:GetWantedTaskInfo(nSubTaskId)
	local pTabFile	= KIo.OpenTabFile("\\setting\\task\\wanted\\wanted_killnpc.txt");
	local nKillID	= math.mod(nSubTaskId,50000) + 2;
	local nTaskName	= pTabFile.GetStr(nKillID,2);
	local nMapId	= pTabFile.GetInt(nKillID,4);
	local nPosX	= pTabFile.GetInt(nKillID,5);
	local nPosY	= pTabFile.GetInt(nKillID,6);
	local nKillNpcId	= pTabFile.GetInt(nKillID,8);
	KIo.CloseTabFile(pTabFile);
	return nTaskName, nMapId, nKillNpcId, nPosX, nPosY;
end

function uiAutoDaDao:IsNearbyNpcPos()
	local nDistance = self:GetNpcDistance();
	if (nMapId == nMyMapId and nDistance < 24) then
		return 1;
	end
	return 0;
end

function uiAutoDaDao:IsArrival()
	local nDistance = self:GetNpcDistance();
	if (nMapId == nMyMapId and nDistance < 10) then
		return 1;
	end
	return 0;
end

function uiAutoDaDao:GetNpcDistance()
	local nSubTaskId  = me.GetTask(Wanted.TASK_GROUP,Wanted.TASK_ACCEPT_ID);
	local nTaskName,nMapId,nKillNpcId,nPosX,nPosY = self:GetWantedTaskInfo(nSubTaskId);
	local nMyMapId,nMyPosX,nMyPosY = me.GetWorldPos();
	local nDistance = math.sqrt((nPosX-nMyPosX)^2 + (nPosY-nMyPosY)^2);
	return nDistance;
end

function uiAutoDaDao:IsMoving()
	if (me.GetNpc().nDoing == Npc.DO_WALK or me.GetNpc().nDoing == Npc.DO_RUN) then
		nRunning = 1;
	else
		nRunning = 0;
	end
end

function uiAutoDaDao:GetAssistSkillId()
	local tbAssistSkill = { 26, 46, 55, 115, 132, 161, 177, 180, 191, 219, 230, 489, 697, 770, 783, 1209};
		for _, nSkillId in ipairs(tbAssistSkill) do
		if (me.CanCastSkill(nSkillId) == 1) then	
			return 	nSkillId;
		end
	end
	return 0;
end

function uiAutoDaDao:CastAssistSkill()
	if (me.nFightState == 1) then	
		local nSkillId = self:GetAssistSkillId();
		if (nSkillId > 0) then
			local _, _, nRestTime	= me.GetSkillState(nSkillId);
			if (not nRestTime or nRestTime < Env.GAME_FPS) then
				AutoAi:Pause();
				AutoAi.DoAttack(nSkillId, AutoAi.GetSelfIndex());
				Timer:Register(Env.GAME_FPS * 1, AutoAi.DelayResumeAi, AutoAi);
			end
		end
	end
end

function uiAutoDaDao:MoveToSafePos()
	AutoAi.SetTargetIndex(0);
	self:RideHorse();
	local nCurMapId  = me.GetWorldPos();
	local szInfoFile = Map.tbSuperMapLink.tbAllMapInfo[nCurMapId].szInfoFile;
	local tbFileData = Lib:LoadTabFile("\\setting\\map\\map_info\\" .. szInfoFile .. "\\info.txt");
	for nRowNum, tbRow in ipairs(tbFileData or {}) do
		if (tbRow.NpcTemplateId == "2525") then  
			local bSuccess = me.AutoPath(tonumber(tbRow.XPos)/32+MathRandom(-10, 10), tonumber(tbRow.YPos)/32+MathRandom(-10, 10));
			break;
		end
	end
end

function uiAutoDaDao:SetKillNpcTarget()
	local nSubTaskId = me.GetTask(Wanted.TASK_GROUP,Wanted.TASK_ACCEPT_ID);
	local nTaskName,nMapId,nKillNpcId = self:GetWantedTaskInfo(nSubTaskId);
	local nTargetIndex = self:GetAroundNpcTargetIndex(nKillNpcId);
	AutoAi.SetTargetIndex(nTargetIndex);
end

function uiAutoDaDao:RideHorse()
	local bChecked = me.GetNpc().IsRideHorse();	
	if (bChecked == 0) then
		Switch([[horse]]);
	end
end

function uiAutoDaDao:GetDownHorse()
	local bChecked = me.GetNpc().IsRideHorse(); 
	if (bChecked == 1) then
		Switch([[horse]]);
	end
end

function uiAutoDaDao:GetItemCountByName(szName)
	local g;
	local d;
	local p;
	local l;
	local pTabFile = KIo.OpenTabFile("\\setting\\item\\001\\other\\medicine.txt");
	if (not pTabFile) then
		return 0;
	end
	local nHeight = pTabFile.GetHeight();
	for i = 2, nHeight do
		local name = pTabFile.GetStr(i, 1);
		if name == szName then
			g = pTabFile.GetInt(i, 3);
			d = pTabFile.GetInt(i, 4);
			p = pTabFile.GetInt(i, 5);
			l = pTabFile.GetInt(i, 6);
			break;
		end
	end
	KIo.CloseTabFile(pTabFile);
	return me.GetItemCountInBags(g,d,p,l);
end

function uiAutoDaDao:BuyRed(szName,nNum)
        me.Msg("Mua thuốc số lượng: " .. string.format(self.tbSetting.nBuyRedNum));
	local nCountFree = me.CountFreeBagCell();
	if (nNum >= nCountFree) then
		nNum = nCountFree - 1;			
	end
	local uId = uiAutoDaDao.STUFF_LIST[szName][3];	
	local nTaskMapID = self.tbCityMap[self.tbSetting.nCityMapID + 1][2];
	local szLink = ","..nTaskMapID..",3564,1";	
	local pItem = KItem.GetItemObj(uId);
	if (pItem and UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
		me.ShopBuyItem(uId, nNum);
		if (nCloseUiTimerId == 0) then
			nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
		end
	else
		UiManager.tbLinkClass["npcpos"]:OnClick(szLink);
	end
end

function uiAutoDaDao:CloseUiWindow()
	if (UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
		UiManager:CloseWindow(Ui.UI_SHOP);    
	end
	if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);  
	end
	if (UiManager:WindowVisible(Ui.UI_REPOSITORY) == 1) then
		UiManager:CloseWindow(Ui.UI_REPOSITORY); 
	end
	if (nCloseUiTimerId > 0) then
		Ui.tbLogic.tbTimer:Close(nCloseUiTimerId);
		nCloseUiTimerId = 0;
	end
end

function uiAutoDaDao:StopAutoFight()
	if me.nAutoFightState == 1 then
		AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
	end
end

function uiAutoDaDao:SetDeathRevivePos(nCityMapId)
	local nMapId = 26;
	if (nCityMapId) then
		nMapId = nCityMapId;
	end
	local szLink = ","..nMapId..",2599,1";	
	UiManager.tbLinkClass["npcpos"]:OnClick(szLink);
end

function uiAutoDaDao:GetAroundNpcTargetIndex(nTemplateId)
	local tbAroundNpc = KNpc.GetAroundNpcList(me, 100);
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == nTemplateId) then
			return pNpc.nIndex;
		end
	end
	return 0;
end

function uiAutoDaDao:FinishConfirm()
	local nSubTaskId  = me.GetTask(Wanted.TASK_GROUP,Wanted.TASK_ACCEPT_ID); 
	local nTaskCount  = me.GetTask(Wanted.TASK_GROUP,Wanted.TASK_COUNT);     
	local nMyMapId, nMyPosX, nMyPosY = me.GetWorldPos();
	if (nSubTaskId == 0 and nTaskCount == 0 and me.nAutoFightState ~= 1 and nMyMapId == self.tbCityMap[self.tbSetting.nCityMapID + 1][2]) then
		--me.Msg("Trộm tặc tất cả đã bị quét sạch!");
		local nAllotModel, tbMemberList = me.GetTeamInfo();
		if (self.tbSetting.CHK_LBVD == 1  and me.nTeamId > 0) then
			uuiAutoDaDao:HaiTacOff()
			UiManager:StartBao();
		elseif (self.tbSetting.CHK_Thoat == 1  and me.nTeamId > 0) then
			self:TeamLeave();
			uiAutoDaDao:HaiTacOff();
			Exit();	
		elseif (self.tbSetting.CHK_Luyen == 1  and me.nTeamId > 0) then
			self:TeamLeave();
			uiAutoDaDao:HaiTacOff();
			UiManager:StartGua();
		else
			self:TeamLeave();
			uiAutoDaDao:HaiTacOff();
		end
	end
end

function uiAutoDaDao:TeamLeave()
	local nAllotModel, tbMemberList = me.GetTeamInfo();
	if tbMemberList == nil then
		return;
	end
	me.TeamLeave();
	self:ClearTeamLeader();
end

function uiAutoDaDao:ClearTeamLeader()
	tbTeamLeader = {};
end

self:Init();

function uiAutoDaDao:Test()
	local nCityMapTxt = self.tbCityMap[self.tbSetting.nCityMapID + 1][1];
	me.Msg("Thời gian chờ: " .. string.format(self.tbSetting.nBefWaitTime));
	me.Msg("Trì hoãn về thành: " .. string.format(self.tbSetting.nAftWaitTime));
	me.Msg("Chọn mua: " .. string.format(self.tbSetting.nBuyRedNum));
	me.Msg("Cấp truy nã: " .. string.format((5 - self.tbSetting.nTaskLevelID)*10+45));
	me.Msg("Phủ truy nã: " .. string.format(nCityMapTxt));
	me.Msg("Cấp thuốc: " .. string.format(self.tbSetting.nRed));
	me.Msg("ID Phủ: " .. self.tbCityMap[self.tbSetting.nCityMapID + 1][2]);
	me.Msg("Thuốc: " .. self.tbRed[self.tbSetting.nRed + 1][2]);
	if self.tbSetting.CHK_LBVD == 1 then
		SysMsg("<color=yellow>Làm Xong HT Sẽ Đi Làm BVĐ");
	elseif self.tbSetting.CHK_Thoat == 1 then
		SysMsg("<color=yellow>Làm Xong HT Sẽ Thoát");
	elseif self.tbSetting.CHK_Luyen == 1 then
		SysMsg("<color=yellow>Làm Xong HT Sẽ Đi Luyện");
	end
end

function uiAutoDaDao:ScrReload()
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	fnDoScript("\\interface\\autothief\\AutoThief.lua");
	me.Msg("<color=blue>Tự động tải lại hoàn thành! ");
end

LoadUiGroup(Ui.UI_AUTODADAO, "AutoThiefpanel.ini");