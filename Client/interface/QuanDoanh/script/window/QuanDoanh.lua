-- ====================== 文件信息 ======================
-- 自动大盗
-- 修改：布衣隐
-- 问题修复： 耀眼
-- 2010/01/03
-- ======================================================

Ui.UI_QUANDOANH = "UI_QUANDOANH";
local uiQuanDoanh = Ui.tbWnd[Ui.UI_QUANDOANH] or {};	-- 支持重载
uiQuanDoanh.UIGROUP = Ui.UI_QUANDOANH;
Ui.tbWnd[Ui.UI_QUANDOANH] = uiQuanDoanh;
local self = uiQuanDoanh;

uiQuanDoanh.BTN_CLOSE		= "BtnClose";
uiQuanDoanh.BTN_SAVE		= "BtnSave";
uiQuanDoanh.BTN_CANCEL		= "BtnCancel";
uiQuanDoanh.BTN_START		= "BtnStart";
uiQuanDoanh.BTN_SHEZHI		= "BtnShezhi";
uiQuanDoanh.CMB_CITYMAP		= "CmbCityMap";
uiQuanDoanh.CHK_NMC	= "NMChien";
uiQuanDoanh.EDT_BUYREDNUM	= "EdtBuyRedNum";
uiQuanDoanh.BTN_ADDREDNUM	= "BtnAddRedNum";
uiQuanDoanh.BTN_DECREDNUM	= "BtnDecRedNum";
uiQuanDoanh.CMB_TASKLEVEL	= "CmbTaskLevel";
uiQuanDoanh.CMB_HPNS	= "CmbHPNS";
uiQuanDoanh.CMB_RED	        = "CmbRed";

uiQuanDoanh.CMB_BMS3	= "CmbBMS3";

uiQuanDoanh.EDT_BUYREDNUMTHUCAN	= "EdtBuyRedNumThucAn";
uiQuanDoanh.BTN_ADDREDNUMTHUCAN		= "BtnAddRedNumThucAn";
uiQuanDoanh.BTN_DECREDNUMTHUCAN		= "BtnDecRedNumThucAn";

uiQuanDoanh.CHK_Unbind		= "BtnUnbind";
uiQuanDoanh.CHK_Bind		= "BtnBind";
uiQuanDoanh.CHK_Mixed		= "BtnMixed";

uiQuanDoanh.EDT_CapGhepHT	= "EdtCapGhepHT";
uiQuanDoanh.BTN_ADDCapGhepHT	= "BtnAddCapGhepHT";
uiQuanDoanh.BTN_DECCapGhepHT	= "BtnDecCapGhepHT";

-- 功能：初始化设置
self.DATA_KEY	= "AutoDaDaoSetting";
self.tbSetting	= {};
self.PhanThuongBMS	={
		{"Danh Vọng Quân Doanh", "repute"},
		{"Quả Thu Hoạch", "item"},
		{"Danh Vọng Học Tạo Đồ", "repute"},
		{"Điểm Độ Bền Cơ Quan", "taskvalue"},
		};
self.tbCityMap	= {
		{"Thanh Long", 556},
		{"Huyền Vũ", 559},
		{"Chu Tước", 558},
	};

self.tbRed	= {
		{"Kim sáng dược (tiểu)","Kim sáng dược (tiểu)"},
		{"Kim sáng dược (trung)","Kim sáng dược (trung)"},
		{"Kim Sáng Dược (đại)","Kim Sáng Dược (đại)"},
		{"Hồi Thiên Đơn","Hồi Thiên Đơn"},
		{"Cửu Chuyển Hoàn Hồn Đơn","Cửu Chuyển Hoàn Hồn Đơn"},
	};

--self.Red	= {"金创药（小）", "金创药（中）", "金创药（大）", "回天丹", "九转还魂丹"};

self.STUFF_LIST = {
	["Thịt xào măng"] = {"Thịt xào măng", 821, 821, 17, 3, 2, 1},
	["Đậu tứ quý"] = {"Đậu tứ quý", 822, 822, 17, 3, 2, 2},
	["Đậu Hòa Lan xào"] = {"Đậu Hòa Lan xào", 823, 823, 17, 3, 2, 3},
	["Cải xào tỏi"] = {"Cải xào tỏi", 824, 824, 17, 3, 2, 4},
	["Ngọc trúc mai hoa"] = {"Ngọc trúc mai hoa", 825, 825, 17, 3, 2, 5},

	["Kim sáng dược (tiểu)"] = {"Kim sáng dược (tiểu)", 676, 676, 17, 1, 1, 1},
	["Kim sáng dược (trung)"] = {"Kim sáng dược (trung)", 677, 677, 17, 1, 1, 2},
	["Kim Sáng Dược (đại)"] = {"Kim Sáng Dược (đại)", 678, 678, 17, 1, 1, 3},
	["Hồi Thiên Đơn"] = {"Hồi Thiên Đơn", 679, 679, 17, 1, 1, 4},
	["Cửu Chuyển Hoàn Hồn Đơn"] = {"Cửu Chuyển Hoàn Hồn Đơn", 680, 680, 17, 1, 1, 5},

	["Ngưng thần đơn (tiểu)"] = {"Ngưng thần đơn (tiểu)", 681, 681, 17, 2, 1, 1},
	["Ngưng thần đơn (trung)"] = {"Ngưng thần đơn (trung)", 682, 682, 17, 2, 1, 2},
	["Ngưng thần đơn (đại)"] = {"Ngưng thần đơn (đại)", 683, 683, 17, 2, 1, 3},
	["Đại Bổ Tán"] = {"Đại Bổ Tán", 684, 684, 17, 2, 1, 4},
	["Thủ ô hoàn thần đơn"] = {"Thủ ô hoàn thần đơn", 685, 685, 17, 2, 1, 5},

	["Thừa tiên mật (tiểu)"] = {"Thừa tiên mật (tiểu)", 686, 686, 17, 3, 1, 1},
	["Thừa tiên mật (trung)"] = {"Thừa tiên mật (trung)", 687, 687, 17, 3, 1, 2},
	["Thừa tiên mật (đại)"] = {"Thừa tiên mật (đại)", 688, 688, 17, 3, 1, 3},
	["Thất xảo bổ tâm đơn"] = {"Thất xảo bổ tâm đơn", 689, 689, 17, 3, 1, 4},
	["Ngũ hoa ngọc lộ hoàn"] = {"Ngũ hoa ngọc lộ hoàn", 690, 690, 17, 3, 1, 5},
}
local Doan1;
local status		= 0;
local Chove		= 0;
local closeUi		    = 0;
local TimePhu		    = 0;
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
local dem=0;
local chaylairunggai=0;
local TheLoaiBuoc2=0;
local TimThayTruPhong=0;
local TimThayTruLam=0;
local TimThayTruHoa=0;
local TimThayTruSon=0;
local MoTruNao=1;
local BaoDanhBMSChua=0;
local ChayBMSBuoc1=0;
local ChayBMSBuoc2=0;
local ChayBMSBuoc3=0;
local DemBuoc3=0;
local ChayBMSBuoc4=0;
local ChayBMSBuoc5=0;
local ChayBMSBuoc6=0;
local ChayBMSBuoc6_a1=0;
local ChayBMSBuoc6_a2=0;
local ChayDiHam=0;
local BaoDanhBMS=0;
local dira=0;
local MoTheoThuTuThu=1;
local BienTam="";
local szMsg2	= "";
local annut;
local Buff=nil;
local phu=nil;
local j=1;
local cobaotiepkhong=0;
local Tru={
	[1]=0;
	[2]=0;
	[3]=0;
	[4]=0;
	[5]=0;
};
local nType;
local nLevel;
local Num = {13,0,6,2,3,0,2,3};
local nTimer	= 0;
local nCount={};
function uiQuanDoanh:Init()
self:ModifyUi();
self:ModifyUi2();
end

-- 功能：面板打开时设置
function uiQuanDoanh:OnOpen()
	self:LoadSetting();

	Wnd_SetFocus(self.UIGROUP, self.EDT_BUYREDNUM);
	Wnd_SetFocus(self.UIGROUP, self.EDT_BUYREDNUMTHUCAN);
	Wnd_SetFocus(self.UIGROUP, self.EDT_CapGhepHT);
	ClearComboBoxItem(self.UIGROUP, self.CMB_CITYMAP);
	for i = 1, #self.tbCityMap do
		ComboBoxAddItem(self.UIGROUP, self.CMB_CITYMAP, i, self.tbCityMap[i][1]);
	end

	ClearComboBoxItem(self.UIGROUP, self.CMB_TASKLEVEL);
	for i = 1, #self.PhanThuongBMS do
		ComboBoxAddItem(self.UIGROUP, self.CMB_TASKLEVEL, i, self.PhanThuongBMS[i][1]);
	end
	
	ClearComboBoxItem(self.UIGROUP, self.CMB_HPNS);
	for i = 1, #self.PhanThuongBMS do
		ComboBoxAddItem(self.UIGROUP, self.CMB_HPNS, i, self.PhanThuongBMS[i][1]);
	end
	
	ClearComboBoxItem(self.UIGROUP, self.CMB_BMS3);
	for i = 1, #self.PhanThuongBMS do
		ComboBoxAddItem(self.UIGROUP, self.CMB_BMS3, i, self.PhanThuongBMS[i][1]);
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

function uiQuanDoanh:LoadSetting()
	self.tbSetting	= self:Load(self.DATA_KEY..tostring(me.nFaction)) or {};
	if not self.tbSetting.nCityMapID then
		self.tbSetting.nCityMapID = 0;
	end
	if not self.tbSetting.nAutoLevel then
		self.tbSetting.nAutoLevel = 0;
	end
	if not self.tbSetting.nBuyRedNum then
		self.tbSetting.nBuyRedNum = 0;
	end
	if not self.tbSetting.nTaskLevelID then
		self.tbSetting.nTaskLevelID = 0;
	end
	if (not self.tbSetting.nBMS3) then
		self.tbSetting.nBMS3=0;
	end
	if (not self.tbSetting.nHPNS) then
		self.tbSetting.nHPNS=0;
	end
	if not self.tbSetting.nRed then
		self.tbSetting.nRed = 4;
	end
	if not self.tbSetting.nBuyRedNumThucAn then
		self.tbSetting.nBuyRedNumThucAn = 0;
	end
	if not self.tbSetting.nKhoaHayKhong then
		self.tbSetting.nKhoaHayKhong=2;
	end
	if not self.tbSetting.nCapGhepHT then
		self.tbSetting.nCapGhepHT = 3;
	end
end

-- 功能：点击按钮控制
function uiQuanDoanh:OnButtonClick(szWnd, nParam)
	if (szWnd == self.BTN_CLOSE) then		-- 关闭窗口
		UiManager:CloseWindow(self.UIGROUP);
		self:LoadSetting();
	elseif (szWnd == self.BTN_SAVE) then		-- 保存数据
		self:SaveData();
		self:Test();
		me.Msg("Lưu thông tin truy nã thành công ");
	elseif (szWnd == self.BTN_CANCEL) then		-- 取消更改
		self:LoadSetting();
	elseif (szWnd == self.BTN_START) then		-- 开始大盗
		if (nWantedState == 0) then
			self:SaveData();
			UiManager:CloseWindow(self.UIGROUP);
			self:SwitchWantedTask();
			UiManager:SwitchWindow(Ui.UI_QUANDOANH);
			self:Test();
		else
			self:SwitchWantedTask();
			self:UpdateControlButton();
		end
	elseif (szWnd == self.BTN_SHEZHI) then		-- 重载
           self.ScrReload();
	elseif (szWnd == self.CHK_NMC) then	-- 自动选择等级
		self.tbSetting.nAutoLevel = nParam;		
	elseif (szWnd == self.BTN_ADDREDNUM) then	-- 增加买红的数量
		Edt_SetInt(self.UIGROUP, self.EDT_BUYREDNUM, self.tbSetting.nBuyRedNum + 1);
	
	elseif (szWnd == self.BTN_DECREDNUM) then	-- 减少买红的数量
		Edt_SetInt(self.UIGROUP, self.EDT_BUYREDNUM, self.tbSetting.nBuyRedNum - 1);
		
	elseif (szWnd == self.BTN_ADDREDNUMTHUCAN) then	-- 增加买红的数量
		Edt_SetInt(self.UIGROUP, self.EDT_BUYREDNUMTHUCAN, self.tbSetting.nBuyRedNumThucAn + 1);
	
	elseif (szWnd == self.BTN_DECREDNUMTHUCAN) then	-- 减少买红的数量
		Edt_SetInt(self.UIGROUP, self.EDT_BUYREDNUMTHUCAN, self.tbSetting.nBuyRedNumThucAn - 1);
	elseif (szWnd == self.BTN_ADDCapGhepHT) then	-- 增加买红的数量
		Edt_SetInt(self.UIGROUP, self.EDT_CapGhepHT, self.tbSetting.nCapGhepHT + 1);

	elseif (szWnd == self.BTN_DECCapGhepHT) then	-- 减少买红的数量
		Edt_SetInt(self.UIGROUP, self.EDT_CapGhepHT, self.tbSetting.nCapGhepHT - 1);
	elseif (szWnd == self.CHK_Unbind) then		-- 单刷大盗
		if (nParam == 1) then
			Btn_Check(self.UIGROUP, self.CHK_Unbind, 1);
			Btn_Check(self.UIGROUP, self.CHK_Bind, 0);
			Btn_Check(self.UIGROUP, self.CHK_Mixed, 0);
			self.tbSetting.nKhoaHayKhong = 0;
		end
	elseif (szWnd == self.CHK_Bind) then		-- 单刷大盗
		if (nParam == 1) then
			Btn_Check(self.UIGROUP, self.CHK_Bind, 1);
			Btn_Check(self.UIGROUP, self.CHK_Unbind, 0);
			Btn_Check(self.UIGROUP, self.CHK_Mixed, 0);
			self.tbSetting.nKhoaHayKhong = 1;
		end
	elseif (szWnd == self.CHK_Mixed) then		-- 单刷大盗
		if (nParam == 1) then
			Btn_Check(self.UIGROUP, self.CHK_Mixed, 1);
			Btn_Check(self.UIGROUP, self.CHK_Bind, 0);
			Btn_Check(self.UIGROUP, self.CHK_Unbind, 0);
			self.tbSetting.nKhoaHayKhong = 2;
		end	
	end
end

--  功能：控制按钮更新
function uiQuanDoanh:UpdateControlButton()
	local szMsg = "";
	if (nWantedState == 0) then		
		szMsg = "Bắt đầu";
	else
		szMsg = "Kết thúc";
	end
	Btn_SetTxt(self.UIGROUP, self.BTN_START, szMsg);
end

-- 功能：选择按钮更新
function uiQuanDoanh:UpdateCheckButton()
	if self.tbSetting.nKhoaHayKhong == 0 then
	Btn_Check(self.UIGROUP, self.CHK_Mixed, 0);
	Btn_Check(self.UIGROUP, self.CHK_Bind, 0);
	Btn_Check(self.UIGROUP, self.CHK_Unbind, 1);
	elseif self.tbSetting.nKhoaHayKhong ==1 then
	Btn_Check(self.UIGROUP, self.CHK_Mixed, 0);
	Btn_Check(self.UIGROUP, self.CHK_Bind, 1);
	Btn_Check(self.UIGROUP, self.CHK_Unbind, 0);
	elseif self.tbSetting.nKhoaHayKhong ==2 then
	Btn_Check(self.UIGROUP, self.CHK_Mixed, 1);
	Btn_Check(self.UIGROUP, self.CHK_Bind, 0);
	Btn_Check(self.UIGROUP, self.CHK_Unbind, 0);
	end
	Btn_Check(self.UIGROUP, self.CHK_NMC, self.tbSetting.nAutoLevel);
end

-- 功能：滚动条移动
function uiQuanDoanh:OnScorllbarPosChanged(szWnd, nParam)
	self:UpdateScorllBar();
end

-- 功能：滚动条标签更新
function uiQuanDoanh:UpdateScorllBar()

end

-- 功能：下拉列表选择
function uiQuanDoanh:OnComboBoxIndexChange(szWnd, nIndex)
	if (szWnd == self.CMB_CITYMAP) then
		self.tbSetting.nCityMapID = nIndex;
	end

	if (szWnd == self.CMB_TASKLEVEL) then
		self.tbSetting.nTaskLevelID = nIndex;
	end
	if (szWnd == self.CMB_HPNS) then
		self.tbSetting.nHPNS = nIndex;
	end
	if (szWnd == self.CMB_BMS3) then
		self.tbSetting.nBMS3 = nIndex;
	end
	if (szWnd == self.CMB_RED) then
		self.tbSetting.nRed = nIndex;
	end
end

-- 功能：下拉列表框更新
function uiQuanDoanh:UpdateComboBox()
	ComboBoxSelectItem(self.UIGROUP, self.CMB_CITYMAP, self.tbSetting.nCityMapID);
	ComboBoxSelectItem(self.UIGROUP, self.CMB_TASKLEVEL, self.tbSetting.nTaskLevelID);
	ComboBoxSelectItem(self.UIGROUP, self.CMB_HPNS, self.tbSetting.nHPNS);
	ComboBoxSelectItem(self.UIGROUP, self.CMB_BMS3, self.tbSetting.nBMS3);
	ComboBoxSelectItem(self.UIGROUP, self.CMB_RED, self.tbSetting.nRed);
end

-- 功能：数字对话框改变
function uiQuanDoanh:OnEditChange(szWndName, nParam)

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
	
	if (szWndName == self.EDT_BUYREDNUMTHUCAN) then
		local nNum = Edt_GetInt(self.UIGROUP, self.EDT_BUYREDNUMTHUCAN);
		if (nNum == self.tbSetting.nBuyRedNumThucAn) then		-- 防止死循环
			return;
		end
		if (nNum < 0) then
			nNum = 0;
		end
		self.tbSetting.nBuyRedNumThucAn = nNum;
		self:UpdateEdit();
	end
	
	if (szWndName == self.EDT_CapGhepHT) then
		local nNum = Edt_GetInt(self.UIGROUP, self.EDT_CapGhepHT);
		if (nNum == self.tbSetting.nCapGhepHT) then		-- 防止死循环
			return;
		end
		if (nNum < 3) then
			nNum = 3;
		end
		if (nNum > 12) then
			nNum = 12;
		end
		self.tbSetting.nCapGhepHT = nNum;
		self:UpdateEdit();
	end
end

-- 功能：数字对话框输入
function uiQuanDoanh:OnEditEnter(szWnd)
	if (szWnd == self.EDT_BUYREDNUM) then
		self:OnButtonClick(self.BTN_SAVE, 0);
	end
	if (szWnd == self.EDT_BUYREDNUMTHUCAN) then
		self:OnButtonClick(self.BTN_SAVE, 0);
	end
	if (szWnd == self.EDT_CapGhepHT) then
		self:OnButtonClick(self.BTN_SAVE, 0);
	end
end

-- 功能：数字对话框更新
function uiQuanDoanh:UpdateEdit()
	Edt_SetInt(self.UIGROUP, self.EDT_BUYREDNUM, self.tbSetting.nBuyRedNum);
	Edt_SetInt(self.UIGROUP, self.EDT_BUYREDNUMTHUCAN, self.tbSetting.nBuyRedNumThucAn);
	Edt_SetInt(self.UIGROUP, self.EDT_CapGhepHT, self.tbSetting.nCapGhepHT);
end

-- 功能：保存数据
function uiQuanDoanh:SaveData()
	self:Save(self.DATA_KEY..tostring(me.nFaction), self.tbSetting);
end

-- 功能：将数据保存到用户配置文件
function uiQuanDoanh:Save(szKey, tbData)
	self.m_szFilePath="\\user\\QuanDoanh\\"..me.szName..".dat";
	self.m_tbData[szKey] = tbData;
	-- 存储到文件
	local szData = Lib:Val2Str(self.m_tbData);
	assert(self.m_szFilePath);
	if self:CheckErrorData(szData) == 1 then
		KIo.WriteFile(self.m_szFilePath, szData);
	else
		local szSaveData = Lib:Val2Str(tbData);
	end
end

-- 功能：从用户配置文件读取数据
function uiQuanDoanh:Load(key)
	self.m_szFilePath="\\user\\QuanDoanh\\"..me.szName..".dat";
	self.m_tbData = {};
	local szData = KIo.ReadTxtFile(self.m_szFilePath);
	if (szData) then
		if self:CheckErrorData(szData) == 1 then	-- 这里检测一下目录里是否被因出错写入了非法数据
			self.m_tbData = Lib:Str2Val(szData);
		else
			KIo.WriteFile(self.m_szFilePath, "nil");
		end
	end
	local tbData = self.m_tbData[key];
	return tbData
end

-- 功能：错误数据处理
function uiQuanDoanh:CheckErrorData(szDate)
	if szDate ~= "" then
		if string.find(szDate, "Ptr:") and string.find(szDate, "ClassName:") then
			return 0;
		end
		if (not Lib:CallBack({"Lib:Str2Val", szDate})) then	-- 因文件损坏等问题，无法读取到正确的包外文件
			return 0;
		end
	end
	return 1;
end
function uiQuanDoanh:SwitchWantedTask()
	if nWantedState == 0 then
		Ui(Ui.UI_AUTOFIGHT):LoadSetting();
		local nLifeRet = Ui(Ui.UI_AUTOFIGHT).nLifeRet;	-- 获取自动战斗喝血的设置
		if (nLifeRet > 75) then
			me.Msg("<color=yellow>Tự-chiến thiết lập để ăn nhiều hơn 75% máu đỏ cần phải được điều chỉnh!<color>");
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tự-chiến thiết lập để ăn nhiều hơn 75% máu đỏ cần phải được điều chỉnh!<color>");
			return;
		end
		nWantedState = 1;
		nWaitstats = 1;
		self.nLeader = 0;
		nSelectOn = 1;
		TimePhu=0;
		me.Msg("<color=yellow>Bật Tự Làm Bách Man Sơn [Shift+B]<color>");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Bật Tự Làm Bách Man Sơn [Shift+B]<color>");
		nWantedTimerId = Ui.tbLogic.tbTimer:Register(pWantedTime * Env.GAME_FPS, self.OnWantedTaskTimer, self);
	else
		nWantedState = 0;
		me.Msg("<color=yellow>Tắt Tự Làm Bách Man Sơn [Shift+B]<color>");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt Tự Làm Bách Man Sơn [Shift+B]<color>");
		self:StopAutoFight();
		Timer:Close(self.Buff);
		self.Buff = nil;
		Ui.tbLogic.tbTimer:Close(nWantedTimerId);
		nWantedTimerId = 0;
		nArrival = 0;
		Ui.tbLogic.tbTimer:Close(nTimer);
		nTimer = 0;
		if (nCloseUiTimerId > 0) then
			Ui.tbLogic.tbTimer:Close(nCloseUiTimerId);
			nCloseUiTimerId = 0;
		end
	end
end

-- 功能：自动大盗任务循环
function uiQuanDoanh:OnWantedTaskTimer()
local nMapIdMe, nPosXMe, nPosYMe	= me.GetWorldPos();
local nCountFree  = me.CountFreeBagCell();
local nRedInBag   = self:GetItemCountByName(self.tbRed[self.tbSetting.nRed + 1][2]);
local nTime = tonumber(GetLocalDate("%H%M"));
local tbCampList = Task:GetMaxLevelCampTaskInfo(me);
local DuHuyenTinhGhep=self:CanCompose(self.tbSetting.nKhoaHayKhong,math.abs(self.tbSetting.nCapGhepHT-1),Num);
if (DuHuyenTinhGhep==1 and nMapIdMe==self.tbCityMap[self.tbSetting.nCityMapID + 1][2]) then
	local tbFind = me.FindItemInBags(18,1,195,1)[1];
	if (tbFind) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",3,0"});
	else
		local tbFind2 = me.FindItemInBags(18,1,3,1)[1];
		if (tbFind2) then
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL)~=1) then
				me.UseItem(tbFind2.pItem);
			else
				me.AnswerQestion(0);
				if (nCloseUiTimerId == 0) then
				nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
				end
			end
		else
			self:BuyRed3(712, 1,self.tbCityMap[self.tbSetting.nCityMapID + 1][2]);
		end
	end
	return;
end
if (DuHuyenTinhGhep==1 and nMapIdMe==3) then
	self:Hexuan(self.tbSetting.nKhoaHayKhong,math.abs(self.tbSetting.nCapGhepHT-1),Num);
	return;
elseif (DuHuyenTinhGhep==0 and nMapIdMe==3) then
	local tbFind = me.FindItemInBags(18,1,195,1)[1];
	if (tbFind) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ","..self.tbCityMap[self.tbSetting.nCityMapID + 1][2]..",0"});
	else
		local tbFind2 = me.FindItemInBags(20,1,606,1)[1];
		if (tbFind2) then
				if (UiManager:WindowVisible(Ui.UI_SAYPANEL)~=1) then
					me.UseItem(tbFind2.pItem);
				else
					if phu==nil then
						return;
					else
						me.AnswerQestion(phu);
						phu=nil;
						if (nCloseUiTimerId == 0) then
						nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
						end
					end
				end
		else
			self:BuyRed3(2288, 1,3);
		end
	end
	return;
end
if (self.tbSetting.nBuyRedNumThucAn>0 and nCountFree>1 and me.GetItemCountInBags(19,3,1,5)<self.tbSetting.nBuyRedNumThucAn and nMapIdMe==self.tbCityMap[self.tbSetting.nCityMapID + 1][2]) then
	local nNum = self.tbSetting.nBuyRedNumThucAn - me.GetItemCountInBags(19,3,1,5);
	self:BuyRed2(825, nNum);
	return;
end
local ThucAn = me.FindItemInBags(Item.SKILLITEM);
	if(#ThucAn ~= 0) then
		local nLevel, nState, nTime = me.GetSkillState(AutoAi.FOOD_SKILL_ID);
			if (not nTime or nTime < Env.GAME_FPS * 3)  then
				local pItem = ThucAn[1].pItem;
				if(me.CanUseItem(pItem)) then
					PopoTip:ShowPopo(19, "Sử dụng thức ăn <color=yellow>" .. pItem.szName .. "<color>");
					me.UseItem(pItem);
				end
			end
	end
	local a=1;
	for a, tbInfo in ipairs(tbCampList) do
			if (tbInfo[2]=="Cổ Họa (Chính tuyến - Trung)" or tbInfo[2]=="Cổ Họa (Chính tuyến - Sơ)") then
					self:DiNhanNV(tbInfo[2]);
				return;
			elseif (tbInfo[2]~="Cổ Họa (Chính tuyến - Trung)" and tbInfo[2]~="Cổ Họa (Chính tuyến - Sơ)" and a==#tbCampList) then
				for _, tbInfo in ipairs(tbCampList) do
					if (tbInfo[2]=="Cổ Họa (Hằng ngày - Sơ)" or tbInfo[2]=="Cổ Họa (Hằng ngày - Trung)" ) then
							self:DiNhanNV(tbInfo[2]);
						return;
					end
				end
			end
	end
if ((1724-nPosXMe)^2 + (3131-nPosYMe)^2<100 and nRedInBag < self.tbSetting.nBuyRedNum and nCountFree>1) then
	local nNum = self.tbSetting.nBuyRedNum - nRedInBag;
	self:BuyRed(self.tbRed[self.tbSetting.nRed + 1][2], nNum);
	return;
end
local tbPlayerTask = Task:GetPlayerTask(me)
	local i=1;
	for _, nTaskIdItem in ipairs(Task.tbTrackTaskSet) do
		local tbTask = tbPlayerTask.tbTasks[nTaskIdItem];
		if (Task:GetTaskName(tbTask.nTaskId)=="[Cổ Họa (Hằng ngày - Sơ)]" or Task:GetTaskName(tbTask.nTaskId)=="[Cổ Họa (Hằng ngày - Trung)]" or Task:GetTaskName(tbTask.nTaskId)=="[Cổ Họa (Chính tuyến - Trung)]" or Task:GetTaskName(tbTask.nTaskId)=="[Cổ Họa (Chính tuyến - Sơ)]") then
						local szTotleDesc 	= "";
							local tbCurTags = tbTask.tbCurTags;
							if(#tbCurTags==0 and nMapIdMe==self.tbCityMap[self.tbSetting.nCityMapID + 1][2]) then
								self:TraNv(Task:GetTaskName(tbTask.nTaskId));
								return;
							end
							for _, tbCurTag in ipairs(tbCurTags) do
								local szTagDesc = tbCurTag:GetDesc();
								if (szTagDesc and szTagDesc ~="") then
									if (tbCurTag:IsDone()) then
									else
										if (i==1 and tbCurTag:GetDesc()=="Đến gặp Chung Minh Trì Mộ phục mệnh" and nMapIdMe==self.tbCityMap[self.tbSetting.nCityMapID + 1][2]) then
											self:TraNv(Task:GetTaskName(tbTask.nTaskId));
											return;
										end
										if (i==1 and tbCurTag:GetDesc()=="Đến gặp Chung Minh Trì Mộ phục mệnh" and me.GetMapTemplateId()~=self.tbCityMap[self.tbSetting.nCityMapID + 1][2]) then
											self:BMSBuoc6();
											return;
										end
										if (i==1 and me.GetMapTemplateId()~=self.tbCityMap[self.tbSetting.nCityMapID + 1][2]) then
											self:BMSBuoc1();
											return;
										end
										if (i==2 and me.GetMapTemplateId()~=self.tbCityMap[self.tbSetting.nCityMapID + 1][2]) then
											self:BMSBuoc2();
											return;
										end	
										if (i==3 and me.GetMapTemplateId()~=self.tbCityMap[self.tbSetting.nCityMapID + 1][2]) then
											self:BMSBuoc3();
											return;
										end	
										if (i==4 and me.GetMapTemplateId()~=self.tbCityMap[self.tbSetting.nCityMapID + 1][2]) then
											self:BMSBuoc4();
											return;
										end	
										if (i==5 and me.GetMapTemplateId()~=self.tbCityMap[self.tbSetting.nCityMapID + 1][2]) then
											self:BMSBuoc5();
											return;
										end	
									end
								end
								i=i+1;
							end
		end
	end
	if (nTime %100>10 and cobaotiepkhong==1 and (60-math.mod(nTime,100))>5) then
		cobaotiepkhong=0;
		return;
	end
	if (cobaotiepkhong==1) then
		return;
	end
	if (nMapIdMe==self.tbCityMap[self.tbSetting.nCityMapID + 1][2] and nTime %100<10 and BaoDanhBMS==0) then
	if Ui(Ui.UI_TEAM):IsTeamLeader()==1 then
		if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then	
				Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ","..nMapIdMe..",4038"});
		else
				me.AnswerQestion(1);
				me.AnswerQestion(0);
				SendChannelMsg("Team", "Báo Danh Roài Đấy!");
				BaoDanhBMS=1;
				if (nCloseUiTimerId == 0) then
					nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
				end
		end
	end
	return;
end
if(nMapIdMe==self.tbCityMap[self.tbSetting.nCityMapID + 1][2] and nTime %100<10 and BaoDanhBMS==1) then
	if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then	
				Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ","..nMapIdMe..",4038"});
		else
				me.AnswerQestion(1);
				me.AnswerQestion(1);
				if (nCloseUiTimerId == 0) then
					nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
				end
		end
	return;
end
end
function uiQuanDoanh:DiNhanNV(TenNvNhan)
BienTam=TenNvNhan;
local nMapIdMe, nPosXMe, nPosYMe	= me.GetWorldPos();
if UiManager:WindowVisible(Ui.UI_GUTAWARD) ~= 1 then
		if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then	
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ","..nMapIdMe..",4139"});
		else
			if not annut then
				return;
			end
			me.AnswerQestion(annut);
			if (nCloseUiTimerId == 0) then
					nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
			end
		end
	else
		local uiGutAward = Ui(Ui.UI_GUTAWARD);
		uiGutAward.OnButtonClick(uiGutAward,"zBtnAccept");
		return;
	end
end
function uiQuanDoanh:TraNv(TenNvTra)
local nCountFree  = me.CountFreeBagCell();
	if (nCountFree<5) then
		local tbFind = me.FindItemInBags(17,1,1,5)[1];
		if not tbFind then
			local tbFind = me.FindItemInBags(18,1,1,2,-1,0)[1];
			if tbFind then
				me.ThrowAway(tbFind.nRoom, tbFind.nX, tbFind.nY);
			end
		else
			me.UseItem(tbFind.pItem);
		end
	end
local nTime = tonumber(GetLocalDate("%H%M"));
if ( (nTime %100<10) or ( 60-math.mod(nTime,100)<=5 ) ) then
cobaotiepkhong=1;
elseif ( (nTime %100>10) and ( 60-math.mod(nTime,100)>5 ) ) then
cobaotiepkhong=0;
end
BaoDanhBMSChua=0;
ChayBMSBuoc1=0;
ChayBMSBuoc2=0;
ChayBMSBuoc3=0;
DemBuoc3=0;
ChayBMSBuoc4=0;
ChayBMSBuoc5=0;
ChayBMSBuoc6=0;
BaoDanhBMS=0;
ChayDiHam=0;
ChayBMSBuoc6_a1=0;
dira=0;
j=1;
MoTheoThuTuThu=1;
Tru[1]=0;
Tru[2]=0;
Tru[3]=0;
Tru[4]=0;
Tru[5]=0;
local nMapIdMe, nPosXMe, nPosYMe	= me.GetWorldPos();
local TenNvdaTach=string.sub(TenNvTra,2,-2);
BienTam=TenNvdaTach;
	if UiManager:WindowVisible(Ui.UI_GUTAWARD) ~= 1 then
		if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then	
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ","..nMapIdMe..",4139"});
		else
			if not annut then
				return;
			end
			me.AnswerQestion(annut);
			if (nCloseUiTimerId == 0) then
					nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
			end
		end
	else
		local uiGutAward = Ui(Ui.UI_GUTAWARD);
		if (uiGutAward.tbAwards.tbOpt[1].szType==self.PhanThuongBMS[self.tbSetting.nTaskLevelID + 1][2] or uiGutAward.tbAwards.tbOpt[1].szType==self.PhanThuongBMS[self.tbSetting.nHPNS + 1][2] or uiGutAward.tbAwards.tbOpt[1].szType==self.PhanThuongBMS[self.tbSetting.nBMS3 + 1][2]) then
			uiGutAward.OnButtonClick(uiGutAward,"ObjOptional1");
			uiGutAward.OnButtonClick(uiGutAward,"zBtnAccept");
			return;
		elseif (uiGutAward.tbAwards.tbOpt[2].szType==self.PhanThuongBMS[self.tbSetting.nTaskLevelID + 1][2] or uiGutAward.tbAwards.tbOpt[2].szType==self.PhanThuongBMS[self.tbSetting.nHPNS + 1][2] or uiGutAward.tbAwards.tbOpt[2].szType==self.PhanThuongBMS[self.tbSetting.nBMS3 + 1][2]) then
			uiGutAward.OnButtonClick(uiGutAward,"ObjOptional2");
			uiGutAward.OnButtonClick(uiGutAward,"zBtnAccept");
			return;
		else
			uiGutAward.OnButtonClick(uiGutAward,"ObjOptional"..MathRandom(1,2));
			uiGutAward.OnButtonClick(uiGutAward,"zBtnAccept");
			return;
		end
		return;
	end
end
function uiQuanDoanh:BMSBuoc6()
	self:ThoatKhoiQuanDoanh();
end
function uiQuanDoanh:DiHam()
	local nCountFree  = me.CountFreeBagCell();
	if (nCountFree<2) then
		local tbFind = me.FindItemInBags(17,1,1,5)[1];
		if not tbFind then
			local tbFind = me.FindItemInBags(18,1,1,2,-1,0)[1];
			if tbFind then
				me.ThrowAway(tbFind.nRoom, tbFind.nX, tbFind.nY);
			end
		else
			me.UseItem(tbFind.pItem);
		end
	end
	local tbNpcList2 = KNpc.GetAroundNpcList(me,2000);
	local tbPlayerTask = Task:GetPlayerTask(me)
	local i=1;
	local j=1;
	local nMapIdMe, nPosXMe, nPosYMe	= me.GetWorldPos();
	if ((1724-nPosXMe)^2 + (3131-nPosYMe)^2<100) then
		for _, pNpc in ipairs(tbNpcList2) do
			if (pNpc.nTemplateId == 4121) then
				if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then	
						AutoAi.SetTargetIndex(pNpc.nIndex);
				else
						me.AnswerQestion(3);
						ChayBMSBuoc6_a1=0;
						if (nCloseUiTimerId == 0) then
						nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
						end
				end
				break;
			end
		end
		return;
	end
	---- Het Cho Mua Mau
	if (ChayBMSBuoc6_a1==0) then
		if((1819-nPosXMe)^2 + (2845-nPosYMe)^2>10) then
			me.AutoPath(1819, 2845);
			self:RideHorse();
		else
			if (nCloseUiTimerId == 0) then
				nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
			end
			for _, pNpc in ipairs(tbNpcList2) do
				if (pNpc.nTemplateId == 4176) then
					if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then	
						AutoAi.SetTargetIndex(pNpc.nIndex);
					else
						me.AnswerQestion(0);
						ChayBMSBuoc6_a1=1;
						if (nCloseUiTimerId == 0) then
						nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
						end
					end
					return;
				end
			end
		end
		return;
	end
	--ChayBMSBuoc6_a1
	if (ChayDiHam==0) then
			for i, nTaskIdItem in ipairs(Task.tbTrackTaskSet) do
				local tbTask = tbPlayerTask.tbTasks[nTaskIdItem];
				if (Task:GetTaskName(tbTask.nTaskId)=="[Cấm Địa (trung)]" or Task:GetTaskName(tbTask.nTaskId)=="[Cấm Địa (Sơ)]" ) then
					ChayDiHam=1;
					break;
				elseif (Task:GetTaskName(tbTask.nTaskId)~="[Cấm Địa (trung)]" and Task:GetTaskName(tbTask.nTaskId)~="[Cấm Địa (Sơ)]" and i==#Task.tbTrackTaskSet) then
					ChayDiHam=0;
					if((1877-nPosXMe)^2 + (2821-nPosYMe)^2>10) then
						if me.nAutoFightState == 1  then
							AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
							AutoAi.ProcessHandCommand("auto_fight",0);
							me.AutoPath(nPosXMe-1, nPosYMe);
						end
						if (self.Buff~=nil) then
							Timer:Close(self.Buff);
							self.Buff = nil;
						end
						AutoAi.SetTargetIndex(0);
						me.AutoPath(1877, 2821);
						self:RideHorse();
					else
						if UiManager:WindowVisible(Ui.UI_GUTAWARD) ~= 1 then
									for _, pNpc in ipairs(tbNpcList2) do
										if (pNpc.nTemplateId == 4143) then
											if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
												AutoAi.SetTargetIndex(pNpc.nIndex);
											else
												me.AnswerQestion(0);
												if (nCloseUiTimerId == 0) then
												nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
												end
											end
											break;
										end
									end
						else
							local uiGutAward = Ui(Ui.UI_GUTAWARD);
							uiGutAward.OnButtonClick(uiGutAward,"zBtnAccept");
						end
					end
				end
			end
		return;
	-- elseif Chay Lấy Tịnh Tâm Châu
	elseif (ChayDiHam==1) then
		if (me.GetItemCountInBags(20,1,624,1)<1) then
			if((1908-nPosXMe)^2 + (2834-nPosYMe)^2>10) then
				if me.nAutoFightState == 1  then
					AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
					AutoAi.ProcessHandCommand("auto_fight",0);
					me.AutoPath(nPosXMe-1, nPosYMe);
				end
				if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
				AutoAi.SetTargetIndex(0);
				me.AutoPath(1908, 2834);
				self:RideHorse();
			else
				if (me.nFaction == 5) then
						if(self.tbSetting.nAutoLevel==0) then
									if (self.Buff==nil) then
									self.Buff = Timer:Register(Env.GAME_FPS * 1, self.NmBuff, self);
									end
								else
									if me.nAutoFightState ~= 1 then
										AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
									end
								end
					else
						if me.nAutoFightState ~= 1 then
							AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
						end
					end
			end
		elseif (me.GetItemCountInBags(20,1,624,1)>=1) then
			SendChannelMsg("Team", "Đi Lấy Thư Tín!");
			ChayDiHam=2;
		end
		return
	-- elseif Chay Lấy Thư Tín
	elseif(ChayDiHam==2) then
		if (me.GetItemCountInBags(20,1,625,1)<1) then
			if((1894-nPosXMe)^2 + (2924-nPosYMe)^2>10) then
				if me.nAutoFightState == 1  then
					AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
					AutoAi.ProcessHandCommand("auto_fight",0);
					me.AutoPath(nPosXMe-1, nPosYMe);
				end
				if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
				AutoAi.SetTargetIndex(0);
				me.AutoPath(1894, 2924);
				self:RideHorse();
			else
				if (me.nFaction == 5) then
						if(self.tbSetting.nAutoLevel==0) then
									if (self.Buff==nil) then
									self.Buff = Timer:Register(Env.GAME_FPS * 1, self.NmBuff, self);
									end
								else
									if me.nAutoFightState ~= 1 then
										AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
									end
								end
					else
						if me.nAutoFightState ~= 1 then
							AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
						end
					end
			end
		elseif (me.GetItemCountInBags(20,1,625,1)>=1) then
			SendChannelMsg("Team", "Đi Giao Hàng");
			ChayDiHam=3;
		end
		return;
	---- Chạy Đi Gao Hàng
	elseif(ChayDiHam==3) then
		if (Ui(Ui.UI_TEAM):IsTeamLeader()==1) then
			if((1842-nPosXMe)^2 + (2990-nPosYMe)^2>100) then
				if me.nAutoFightState == 1  then
					AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
					AutoAi.ProcessHandCommand("auto_fight",0);
					me.AutoPath(nPosXMe-1, nPosYMe);
				end
				if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
				AutoAi.SetTargetIndex(0);
				me.AutoPath(1842, 2990);
				self:RideHorse();
			else
				if (me.GetItemCountInBags(20,1,624,1)>=1 and me.GetItemCountInBags(20,1,625,1)>=1) then
					if (UiManager:WindowVisible(Ui.UI_ITEMGIFT) ~= 1) then
							for _, pNpc in ipairs(tbNpcList2) do
								if (pNpc.nTemplateId == 4144) then
									if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
										AutoAi.SetTargetIndex(pNpc.nIndex);
									else
										me.AnswerQestion(0);
									end
									break;
								end
							end
					else
						self:GiaoHang()
					end
				elseif (me.GetItemCountInBags(20,1,624,1)<1 and me.GetItemCountInBags(20,1,625,1)<1) then
					SendChannelMsg("Team", "Đánh Hỏa Bồng Xuân");
					ChayDiHam=4;
				end
			end
		elseif (Ui(Ui.UI_TEAM):IsTeamLeader()~=1) then
			if((1842-nPosXMe)^2 + (2990-nPosYMe)^2>100) then
				if me.nAutoFightState == 1  then
					AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
					AutoAi.ProcessHandCommand("auto_fight",0);
					me.AutoPath(nPosXMe-1, nPosYMe);
				end
				if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
				AutoAi.SetTargetIndex(0);
				me.AutoPath(1842, 2990);
				self:RideHorse();
			end
		end
		return;
	elseif(ChayDiHam==4) then
		if((1842-nPosXMe)^2 + (2990-nPosYMe)^2>100) then
				if me.nAutoFightState == 1  then
					AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
					AutoAi.ProcessHandCommand("auto_fight",0);
					me.AutoPath(nPosXMe-1, nPosYMe);
				end
				if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
				AutoAi.SetTargetIndex(0);
				me.AutoPath(1842, 2990);
				self:RideHorse();
		else
			for _, pNpc in ipairs(tbNpcList2) do
				if (pNpc.nTemplateId == 4145) then
					if (me.nFaction == 5) then
								if(self.tbSetting.nAutoLevel==0) then
									if (self.Buff==nil) then
									self.Buff = Timer:Register(Env.GAME_FPS * 1, self.NmBuff, self);
									end
								else
									if me.nAutoFightState ~= 1 then
										AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
									end
								end
					else
							if me.nAutoFightState ~= 1 then
								AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
							end
					end
					break;
				elseif (pNpc.nTemplateId ~= 4145 and pNpc.nTemplateId == 4113) then
					if me.nAutoFightState == 1  then
						AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
						AutoAi.ProcessHandCommand("auto_fight",0);
						AutoAi.SetTargetIndex(0);
						me.AutoPath(nPosXMe-1, nPosYMe);
					end
					if (self.Buff~=nil) then
						Timer:Close(self.Buff);
						self.Buff = nil;
					end
					ChayDiHam=5;
				end
			end
		end
		return;
	elseif(ChayDiHam==5) then
		for j, pNpc in ipairs(tbNpcList2) do
			if (pNpc.nTemplateId == 4113) then
				AutoAi.ProcessHandCommand("auto_pick", 1);
				if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1) then	
					AutoAi.SetTargetIndex(pNpc.nIndex);
				end
				break;
			elseif (pNpc.nTemplateId ~= 4113 and j==#tbNpcList2) then
				AutoAi.ProcessHandCommand("auto_pick", 0);
				ChayDiHam=6;
			end
		end
		return;
	elseif(ChayDiHam==6) then
		if((1877-nPosXMe)^2 + (2821-nPosYMe)^2>10) then
						if me.nAutoFightState == 1  then
							AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
							AutoAi.ProcessHandCommand("auto_fight",0);
							me.AutoPath(nPosXMe-1, nPosYMe);
						end
						if (self.Buff~=nil) then
							Timer:Close(self.Buff);
							self.Buff = nil;
						end
						AutoAi.SetTargetIndex(0);
						me.AutoPath(1877, 2821);
						self:RideHorse();
					else
						if UiManager:WindowVisible(Ui.UI_GUTAWARD) ~= 1 then
									for _, pNpc in ipairs(tbNpcList2) do
										if (pNpc.nTemplateId == 4143) then
											if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
												AutoAi.SetTargetIndex(pNpc.nIndex);
											else
												me.AnswerQestion(0);
												if (nCloseUiTimerId == 0) then
												nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
												end
											end
											break;
										end
									end
						else
							local uiGutAward = Ui(Ui.UI_GUTAWARD);
							uiGutAward.OnButtonClick(uiGutAward,"zBtnAccept");
							ChayDiHam=7;
						end
					end
		return;
	elseif(ChayDiHam==7) then
		if((1868-nPosXMe)^2 + (2836-nPosYMe)^2>10) then
			if me.nAutoFightState == 1  then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
				AutoAi.ProcessHandCommand("auto_fight",0);
				me.AutoPath(nPosXMe-1, nPosYMe);
			end
			if (self.Buff~=nil) then
				Timer:Close(self.Buff);
				self.Buff = nil;
			end
			AutoAi.SetTargetIndex(0);
			me.AutoPath(1868, 2836);
			self:RideHorse();
		else
			for _, pNpc in ipairs(tbNpcList2) do
				if (pNpc.nTemplateId == 4133) then
					if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
						AutoAi.SetTargetIndex(pNpc.nIndex);
					else
						me.AnswerQestion(0);
						if (nCloseUiTimerId == 0) then
							nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
						end
					end
					break;
				end
			end
		end
	end
	-----Ket Thuc
end
function uiQuanDoanh:GiaoHang()
	if (UiManager:WindowVisible(Ui.UI_ITEMGIFT) == 1) then
				if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
					UiManager:CloseWindow(Ui.UI_SAYPANEL);   -- 关闭对话窗口
				end
				local tbExtBagLayout = Ui.tbLogic.tbExtBagLayout;
							tbExtBagLayout:Show();    
							for j = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nLine - 1 do
							for i = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRow - 1 do
								local pItem = me.GetMainBagItem(i,j);
								if pItem then
									local tbObj =Ui(Ui.UI_ITEMBOX).tbMainBagCont.tbObjs[j][i];
									if pItem.szName == "Thư tín" or pItem.szName == "Tịnh Tâm Châu" then
										Ui(Ui.UI_ITEMBOX).tbMainBagCont:UseObj(tbObj,i,j);
									end
								end
							end
							end
							--- End Hom Chinh


							--- Hom Phu 1
							if (UiManager:WindowVisible(Ui.UI_EXTBAG1) == 1) then
								for j = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nLine - 1 do
								for i = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRow - 1 do
									local pItem = me.GetItem(Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRoom, i, j);
									if pItem then
									local tbObj =Ui(Ui.UI_EXTBAG1).tbExtBagCont.tbObjs[j][i];
									if pItem.szName == "Thư tín" or pItem.szName == "Tịnh Tâm Châu" then
										Ui(Ui.UI_EXTBAG1).tbExtBagCont:UseObj(tbObj,i,j);
									end
									end
								end
								end
							end
							--- End Hom Phu 1

							--- Hom Phu 2
							if (UiManager:WindowVisible(Ui.UI_EXTBAG2) == 1) then
								for j = 0, Ui(Ui.UI_EXTBAG2).tbExtBagCont.nLine - 1 do
								for i = 0, Ui(Ui.UI_EXTBAG2).tbExtBagCont.nRow - 1 do
									local pItem = me.GetItem(Ui(Ui.UI_EXTBAG2).tbExtBagCont.nRoom, i, j);
									if pItem then
									local tbObj =Ui(Ui.UI_EXTBAG2).tbExtBagCont.tbObjs[j][i];
									if pItem.szName == "Thư tín" or pItem.szName == "Tịnh Tâm Châu" then
										Ui(Ui.UI_EXTBAG2).tbExtBagCont:UseObj(tbObj,i,j);
									end
									end
								end
								end
							end
							--- End Hom Phu 2

							--- Hom Phu 3
							if (UiManager:WindowVisible(Ui.UI_EXTBAG3) == 1) then
								for j = 0, Ui(Ui.UI_EXTBAG3).tbExtBagCont.nLine - 1 do
								for i = 0, Ui(Ui.UI_EXTBAG3).tbExtBagCont.nRow - 1 do
									local pItem = me.GetItem(Ui(Ui.UI_EXTBAG3).tbExtBagCont.nRoom, i, j);
									if pItem then
									local tbObj =Ui(Ui.UI_EXTBAG3).tbExtBagCont.tbObjs[j][i];
									if pItem.szName == "Thư tín" or pItem.szName == "Tịnh Tâm Châu" then
										Ui(Ui.UI_EXTBAG3).tbExtBagCont:UseObj(tbObj,i,j);
									end
									end
								end
								end
							end
							local uiGift = Ui(Ui.UI_ITEMGIFT)
							uiGift.OnButtonClick(uiGift,"BtnOk");
							if (nCloseUiTimerId == 0) then
								nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
							end
	end
end
function uiQuanDoanh:ThoatKhoiQuanDoanh()
	local nMapIdMe, nPosXMe, nPosYMe	= me.GetWorldPos();
	if me.nAutoFightState == 1  then
		AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
		AutoAi.ProcessHandCommand("auto_fight",0);
		AutoAi.SetTargetIndex(0);
		me.AutoPath(nPosXMe-1, nPosYMe);
	end
	if (self.Buff~=nil) then
		Timer:Close(self.Buff);
		self.Buff = nil;
	end
	local tbNpcList2 = KNpc.GetAroundNpcList(me,2000);
	if ((1724-nPosXMe)^2 + (3131-nPosYMe)^2<100) then
		for _, pNpc in ipairs(tbNpcList2) do
			if (pNpc.nTemplateId == 4121) then
				if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then	
						AutoAi.SetTargetIndex(pNpc.nIndex);
				else
						me.AnswerQestion(3);
						if (nCloseUiTimerId == 0) then
							nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
						end
				end
				break;
			end
		end
		return;
	end
	if((1836-nPosXMe)^2 + (2835-nPosYMe)^2>10) then
			me.AutoPath(1836, 2835);
			self:RideHorse();
		elseif((1836-nPosXMe)^2 + (2835-nPosYMe)^2<10) then
			for _, pNpc in ipairs(tbNpcList2) do
				if (pNpc.nTemplateId == 4177) then
					if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then	
						AutoAi.SetTargetIndex(pNpc.nIndex);
					else
						me.AnswerQestion(0);
						if (nCloseUiTimerId == 0) then
						nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
						end
					end
					return;
				end
			end
	end
end
function uiQuanDoanh:BMSBuoc5()
	local tbNpcList = KNpc.GetAroundNpcList(me,3);
	local tbNpcList2 = KNpc.GetAroundNpcList(me,2000);
	local nMapIdMe, nPosXMe, nPosYMe	= me.GetWorldPos();
	local tbMember = me.GetTeamMemberInfo();
	if ((1724-nPosXMe)^2 + (3131-nPosYMe)^2<100) then
		for _, pNpc in ipairs(tbNpcList2) do
			if (pNpc.nTemplateId == 4121) then
				if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then	
						AutoAi.SetTargetIndex(pNpc.nIndex);
				else
						me.AnswerQestion(3);
						if (nCloseUiTimerId == 0) then
						nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
						end
				end
				break;
			end
		end
		return;
	end
	if (Ui(Ui.UI_TEAM):IsTeamLeader()==1 and ChayBMSBuoc5==0) then
		if (Tru[1]~=0 and Tru[2]~=0 and Tru[3]~=0 and Tru[4]~=0 and Tru[5]~=0) then	
						if me.nAutoFightState == 1  then
						AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
						AutoAi.ProcessHandCommand("auto_fight",0);
						me.AutoPath(nPosXMe-1, nPosYMe);
						
						end
						if (self.Buff~=nil) then
							Timer:Close(self.Buff);
							self.Buff = nil;
						end
						if (Tru[1]==MoTheoThuTuThu) then
							if ((1841-nPosXMe)^2 + (2772-nPosYMe)^2>300) then
								for _, pNpc in ipairs(tbNpcList2) do
									if (pNpc.nTemplateId == 4138) then
											for _, pNpc2 in ipairs(tbNpcList2) do
												if (pNpc2.nTemplateId==4147) then
													AutoAi.SetTargetIndex(pNpc.nIndex);
													break;
												end
											end
									end
								end
								for _, pNpc in ipairs(tbNpcList) do
									if (pNpc.nTemplateId == 4137) then
											if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1) then	
													AutoAi.SetTargetIndex(pNpc.nIndex);
											end
										break;
									elseif (pNpc.nTemplateId ~= 4137) then
										if (self.Buff~=nil) then
											Timer:Close(self.Buff);
											self.Buff = nil;
										end
										if me.nAutoFightState == 1 then
											AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
											AutoAi.ProcessHandCommand("auto_fight",0);
											me.AutoPath(nPosXMe-1, nPosYMe);
										end
										
											me.AutoPath(1822, 2818);
											self:RideHorse();
									end
								end
							else
								for _, pNpc in ipairs(tbNpcList2) do
									if (pNpc.nTemplateId == 4147) then
										if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1) then	
													AutoAi.SetTargetIndex(pNpc.nIndex);
										end
									end
								end
							end
							return;
						elseif (Tru[2]==MoTheoThuTuThu) then
							if ((1878-nPosXMe)^2 + (2862-nPosYMe)^2>300) then
								for _, pNpc in ipairs(tbNpcList2) do
									if (pNpc.nTemplateId == 4138) then
											for _, pNpc2 in ipairs(tbNpcList2) do
												if (pNpc2.nTemplateId==4147) then
													AutoAi.SetTargetIndex(pNpc.nIndex);
													break;
												end
											end
									end
								end
								for _, pNpc in ipairs(tbNpcList) do
									if (pNpc.nTemplateId == 4137) then
											if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1) then	
													AutoAi.SetTargetIndex(pNpc.nIndex);
											end
										break;
									elseif (pNpc.nTemplateId ~= 4137) then
										if (self.Buff~=nil) then
											Timer:Close(self.Buff);
											self.Buff = nil;
										end
										if me.nAutoFightState == 1 then
											AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
											AutoAi.ProcessHandCommand("auto_fight",0);
											me.AutoPath(nPosXMe-1, nPosYMe);
										end
										
											me.AutoPath(1844, 2860);
											self:RideHorse();
									end
								end
							else
								for _, pNpc in ipairs(tbNpcList2) do
									if (pNpc.nTemplateId == 4147) then
										if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1) then	
													AutoAi.SetTargetIndex(pNpc.nIndex);
										end
									end
								end
							end
							return;
						elseif (Tru[3]==MoTheoThuTuThu) then
							if ((1839-nPosXMe)^2 + (2934-nPosYMe)^2>300) then
								for _, pNpc in ipairs(tbNpcList2) do
									if (pNpc.nTemplateId == 4138) then
											for _, pNpc2 in ipairs(tbNpcList2) do
												if (pNpc2.nTemplateId==4147) then
													AutoAi.SetTargetIndex(pNpc.nIndex);
													break;
												end
											end
									end
								end
								for _, pNpc in ipairs(tbNpcList) do
									if (pNpc.nTemplateId == 4137) then
											if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1) then	
													AutoAi.SetTargetIndex(pNpc.nIndex);
											end
										break;
									elseif (pNpc.nTemplateId ~= 4137) then
										if (self.Buff~=nil) then
											Timer:Close(self.Buff);
											self.Buff = nil;
										end
										if me.nAutoFightState == 1 then
											AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
											AutoAi.ProcessHandCommand("auto_fight",0);
											me.AutoPath(nPosXMe-1, nPosYMe);
										end
										
											me.AutoPath(1824, 2881);
											self:RideHorse();
									end
								end
							else
								for _, pNpc in ipairs(tbNpcList2) do
									if (pNpc.nTemplateId == 4147) then
										if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1) then	
													AutoAi.SetTargetIndex(pNpc.nIndex);
										end
									end
								end
							end
							return;
						elseif (Tru[4]==MoTheoThuTuThu) then
							if ((1767-nPosXMe)^2 + (2895-nPosYMe)^2>300) then
								for _, pNpc in ipairs(tbNpcList2) do
									if (pNpc.nTemplateId == 4138) then
											for _, pNpc2 in ipairs(tbNpcList2) do
												if (pNpc2.nTemplateId==4147) then
													AutoAi.SetTargetIndex(pNpc.nIndex);
													break;
												end
											end
									end
								end
								for _, pNpc in ipairs(tbNpcList) do
									if (pNpc.nTemplateId == 4137) then
											if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1) then	
													AutoAi.SetTargetIndex(pNpc.nIndex);
											end
										break;
									elseif (pNpc.nTemplateId ~= 4137) then
										if (self.Buff~=nil) then
											Timer:Close(self.Buff);
											self.Buff = nil;
										end
										if me.nAutoFightState == 1 then
											AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
											AutoAi.ProcessHandCommand("auto_fight",0);
											me.AutoPath(nPosXMe-1, nPosYMe);
										end
										
											me.AutoPath(1794, 2862);
											self:RideHorse();
									end
								end
							else
								for _, pNpc in ipairs(tbNpcList2) do
									if (pNpc.nTemplateId == 4147) then
										if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1) then	
													AutoAi.SetTargetIndex(pNpc.nIndex);
										end
									end
								end
							end
							return;
						elseif (Tru[5]==MoTheoThuTuThu) then
							if ((1767-nPosXMe)^2 + (2815-nPosYMe)^2>300) then
								for _, pNpc in ipairs(tbNpcList2) do
									if (pNpc.nTemplateId == 4138) then
											for _, pNpc2 in ipairs(tbNpcList2) do
												if (pNpc2.nTemplateId==4147) then
													AutoAi.SetTargetIndex(pNpc.nIndex);
													break;
												end
											end
									end
								end
								for _, pNpc in ipairs(tbNpcList) do
									if (pNpc.nTemplateId == 4137) then
											if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1) then	
													AutoAi.SetTargetIndex(pNpc.nIndex);
											end
										break;
									elseif (pNpc.nTemplateId ~= 4137) then
										if (self.Buff~=nil) then
											Timer:Close(self.Buff);
											self.Buff = nil;
										end
										if me.nAutoFightState == 1 then
											AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
											AutoAi.ProcessHandCommand("auto_fight",0);
											me.AutoPath(nPosXMe-1, nPosYMe);
										end
										
											me.AutoPath(1798, 2837);
											self:RideHorse();
									end
								end
							else
								for _, pNpc in ipairs(tbNpcList2) do
									if (pNpc.nTemplateId == 4147) then
										if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1) then	
													AutoAi.SetTargetIndex(pNpc.nIndex);
										end
									end
								end
							end
							return;
						end
			return;	
		elseif (Tru[1]==0 or Tru[2]==0 or Tru[3]==0 or Tru[4]==0 or Tru[5]==0) then	
	------------------------Cua So1
		if (Tru[1]==0 and (1841-nPosXMe)^2 + (2772-nPosYMe)^2>300) then
			for _, pNpc in ipairs(tbNpcList) do
				if (pNpc.nTemplateId == 4137) then
						if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1) then	
								AutoAi.SetTargetIndex(pNpc.nIndex);
						end
					break;
				elseif (pNpc.nTemplateId ~= 4137) then
				if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
				if me.nAutoFightState == 1 then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
				AutoAi.ProcessHandCommand("auto_fight",0);
				me.AutoPath(nPosXMe-1, nPosYMe);
				end
				
				me.AutoPath(1822, 2818);
				self:RideHorse();
				return;
				end
			end
			return;
		elseif (Tru[1]==0 and (1841-nPosXMe)^2 + (2772-nPosYMe)^2<300) then
				for _, pNpc in ipairs(tbNpcList2) do
					if (pNpc.szName=="Huyễn Ảnh Phù Đăng(Kim)") then
						Tru[1]=1;
						break;
					elseif (pNpc.szName=="Huyễn Ảnh Phù Đăng(Mộc") then
						Tru[1]=2;
						break;
					elseif (pNpc.szName=="Huyễn Ảnh Phù Đăng(Thổ") then
						Tru[1]=3;
						break;
					elseif (pNpc.szName=="Huyễn Ảnh Phù Đăng(Thủ") then
						Tru[1]=4;
						break;
					elseif (pNpc.szName=="Huyễn Ảnh Phù Đăng(Hỏa") then
						Tru[1]=5;
						break;
					else
						if me.nAutoFightState ~= 1 then
							AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
						end
					end
				end
			return;
		elseif (Tru[1]~=0 and (1841-nPosXMe)^2 + (2772-nPosYMe)^2<300) then
			for _, pNpc in ipairs(tbNpcList2) do
				if (pNpc.nTemplateId == 4138) then
						if (self.Buff~=nil) then
						Timer:Close(self.Buff);
						self.Buff = nil;
						end
						if me.nAutoFightState == 1 then
						AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
						AutoAi.ProcessHandCommand("auto_fight",0);
						me.AutoPath(nPosXMe-1, nPosYMe);
						end
						AutoAi.SetTargetIndex(pNpc.nIndex);
					break;
				end
			end
			return;
		end
	------------------- Cua So 2
		if (Tru[2]==0 and (1878-nPosXMe)^2 + (2862-nPosYMe)^2>300) then
			for _, pNpc in ipairs(tbNpcList) do
				if (pNpc.nTemplateId == 4137) then
						if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1) then	
								AutoAi.SetTargetIndex(pNpc.nIndex);
						end
					break;
				elseif (pNpc.nTemplateId ~= 4137) then
				if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
					if me.nAutoFightState == 1 then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
				AutoAi.ProcessHandCommand("auto_fight",0);
				me.AutoPath(nPosXMe-1, nPosYMe);
				end
				
				me.AutoPath(1844, 2860);
				self:RideHorse();
				return;
				end
			end
			return;
		elseif (Tru[2]==0 and (1878-nPosXMe)^2 + (2862-nPosYMe)^2<300) then
				for _, pNpc in ipairs(tbNpcList2) do
					if (pNpc.szName=="Huyễn Ảnh Phù Đăng(Kim)") then
						Tru[2]=1;
						break;
					elseif (pNpc.szName=="Huyễn Ảnh Phù Đăng(Mộc") then
						Tru[2]=2;
						break;
					elseif (pNpc.szName=="Huyễn Ảnh Phù Đăng(Thổ") then
						Tru[2]=3;
						break;
					elseif (pNpc.szName=="Huyễn Ảnh Phù Đăng(Thủ") then
						Tru[2]=4;
						break;
					elseif (pNpc.szName=="Huyễn Ảnh Phù Đăng(Hỏa") then
						Tru[2]=5;
						break;
					else
						if me.nAutoFightState ~= 1 then
							AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
						end
					end
				end
			return;
		elseif (Tru[2]~=0 and (1878-nPosXMe)^2 + (2862-nPosYMe)^2<300) then
			for _, pNpc in ipairs(tbNpcList2) do
				if (pNpc.nTemplateId == 4138) then
					if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
					end
						if me.nAutoFightState == 1 then
						AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
						AutoAi.ProcessHandCommand("auto_fight",0);
						me.AutoPath(nPosXMe-1, nPosYMe);
						end
						AutoAi.SetTargetIndex(pNpc.nIndex);
					break;
				end
			end
			return;
		end
	------------------- Cua So 3
		if (Tru[3]==0 and (1839-nPosXMe)^2 + (2934-nPosYMe)^2>300) then
			for _, pNpc in ipairs(tbNpcList) do
				if (pNpc.nTemplateId == 4137) then
						if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1) then	
								AutoAi.SetTargetIndex(pNpc.nIndex);
						end
					break;
				elseif (pNpc.nTemplateId ~= 4137) then
				if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
				if me.nAutoFightState == 1 then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
				AutoAi.ProcessHandCommand("auto_fight",0);
				me.AutoPath(nPosXMe-1, nPosYMe);
				end
				
				me.AutoPath(1824, 2881);
				self:RideHorse();
				return;
				end
			end
			return;
		elseif (Tru[3]==0 and (1839-nPosXMe)^2 + (2934-nPosYMe)^2<300) then
				for _, pNpc in ipairs(tbNpcList2) do
					if (pNpc.szName=="Huyễn Ảnh Phù Đăng(Kim)") then
						Tru[3]=1;
						break;
					elseif (pNpc.szName=="Huyễn Ảnh Phù Đăng(Mộc") then
						Tru[3]=2;
						break;
					elseif (pNpc.szName=="Huyễn Ảnh Phù Đăng(Thổ") then
						Tru[3]=3;
						break;
					elseif (pNpc.szName=="Huyễn Ảnh Phù Đăng(Thủ") then
						Tru[3]=4;
						break;
					elseif (pNpc.szName=="Huyễn Ảnh Phù Đăng(Hỏa") then
						Tru[3]=5;
						break;
					else
						if me.nAutoFightState ~= 1 then
							AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
						end
					end
				end
			return;
		elseif (Tru[3]~=0 and (1839-nPosXMe)^2 + (2934-nPosYMe)^2<300) then
			for _, pNpc in ipairs(tbNpcList2) do
				if (pNpc.nTemplateId == 4138) then
				if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
						if me.nAutoFightState == 1 then
						AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
						AutoAi.ProcessHandCommand("auto_fight",0);
						me.AutoPath(nPosXMe-1, nPosYMe);
						end
						AutoAi.SetTargetIndex(pNpc.nIndex);
					break;
				end
			end
			return;
		end
	------------------- Cua So 4
		if (Tru[4]==0 and (1767-nPosXMe)^2 + (2895-nPosYMe)^2>300) then
			for _, pNpc in ipairs(tbNpcList) do
				if (pNpc.nTemplateId == 4137) then
						if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1) then	
								AutoAi.SetTargetIndex(pNpc.nIndex);
						end
					break;
				elseif (pNpc.nTemplateId ~= 4137) then
				if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
					if me.nAutoFightState == 1 then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
				AutoAi.ProcessHandCommand("auto_fight",0);
				me.AutoPath(nPosXMe-1, nPosYMe);
				end
				
				me.AutoPath(1794, 2862);
				self:RideHorse();
				return;
				end
			end
			return;
		elseif (Tru[4]==0 and (1767-nPosXMe)^2 + (2895-nPosYMe)^2<300) then
				for _, pNpc in ipairs(tbNpcList2) do
					if (pNpc.szName=="Huyễn Ảnh Phù Đăng(Kim)") then
						Tru[4]=1;
						break;
					elseif (pNpc.szName=="Huyễn Ảnh Phù Đăng(Mộc") then
						Tru[4]=2;
						break;
					elseif (pNpc.szName=="Huyễn Ảnh Phù Đăng(Thổ") then
						Tru[4]=3;
						break;
					elseif (pNpc.szName=="Huyễn Ảnh Phù Đăng(Thủ") then
						Tru[4]=4;
						break;
					elseif (pNpc.szName=="Huyễn Ảnh Phù Đăng(Hỏa") then
						Tru[4]=5;
						break;
					else
						if me.nAutoFightState ~= 1 then
							AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
						end
					end
				end
			return;
		elseif (Tru[4]~=0 and (1767-nPosXMe)^2 + (2895-nPosYMe)^2<300) then
			for _, pNpc in ipairs(tbNpcList2) do
				if (pNpc.nTemplateId == 4138) then
				if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
						if me.nAutoFightState == 1 then
						AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
						AutoAi.ProcessHandCommand("auto_fight",0);
						me.AutoPath(nPosXMe-1, nPosYMe);
						end
						AutoAi.SetTargetIndex(pNpc.nIndex);
					break;
				end
			end
			return;
		end
	------------------- Cua So 5
		if (Tru[5]==0 and (1767-nPosXMe)^2 + (2815-nPosYMe)^2>300) then
			for _, pNpc in ipairs(tbNpcList) do
				if (pNpc.nTemplateId == 4137) then
						if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1) then	
								AutoAi.SetTargetIndex(pNpc.nIndex);
						end
					break;
				elseif (pNpc.nTemplateId ~= 4137) then
				if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
				if me.nAutoFightState == 1 then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
				AutoAi.ProcessHandCommand("auto_fight",0);
				me.AutoPath(nPosXMe-1, nPosYMe);
				end
				
				me.AutoPath(1798, 2837);
				self:RideHorse();
				return;
				end
			end
			return;
		elseif (Tru[5]==0 and (1767-nPosXMe)^2 + (2815-nPosYMe)^2<300) then
				for _, pNpc in ipairs(tbNpcList2) do
					if (pNpc.szName=="Huyễn Ảnh Phù Đăng(Kim)") then
						Tru[5]=1;
						break;
					elseif (pNpc.szName=="Huyễn Ảnh Phù Đăng(Mộc") then
						Tru[5]=2;
						break;
					elseif (pNpc.szName=="Huyễn Ảnh Phù Đăng(Thổ") then
						Tru[5]=3;
						break;
					elseif (pNpc.szName=="Huyễn Ảnh Phù Đăng(Thủ") then
						Tru[5]=4;
						break;
					elseif (pNpc.szName=="Huyễn Ảnh Phù Đăng(Hỏa") then
						Tru[5]=5;
						break;
					else
						if me.nAutoFightState ~= 1 then
							AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
						end
					end
				end
			return;
		elseif (Tru[5]~=0 and (1767-nPosXMe)^2 + (2815-nPosYMe)^2<300) then
			for _, pNpc in ipairs(tbNpcList2) do
				if (pNpc.nTemplateId == 4138) then
				if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
						if me.nAutoFightState == 1 then
						AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
						AutoAi.ProcessHandCommand("auto_fight",0);
						me.AutoPath(nPosXMe-1, nPosYMe);
						end
						AutoAi.SetTargetIndex(pNpc.nIndex);
					break;
				end
			end
			return;
		end
		---------------- Het Toan Bo Cua
		--------------------------- Them So Cua
		----------------------------
	end
	elseif (Ui(Ui.UI_TEAM):IsTeamLeader()==0 and ChayBMSBuoc5==0) then
		if((1819-nPosXMe)^2 + (2845-nPosYMe)^2>150) then
		if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
				if me.nAutoFightState == 1 then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
				AutoAi.ProcessHandCommand("auto_fight",0);
				me.AutoPath(nPosXMe-1, nPosYMe);
				end
				
				me.AutoPath(1819, 2845);
				self:RideHorse();
				return;
		end
	end
	
	if (Ui(Ui.UI_TEAM):IsTeamLeader()==1 and ChayBMSBuoc5==1) then
		if((1819-nPosXMe)^2 + (2845-nPosYMe)^2>200) then
			for _, pNpc in ipairs(tbNpcList2) do
				if (pNpc.nTemplateId == 4138) then
					for _, pNpc2 in ipairs(tbNpcList2) do
						if (pNpc2.nTemplateId==4147) then
							AutoAi.SetTargetIndex(pNpc.nIndex);
							break;
						else
							if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
							if me.nAutoFightState == 1 then
							AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
							AutoAi.ProcessHandCommand("auto_fight",0);
							me.AutoPath(nPosXMe-1, nPosYMe);
							end
							me.AutoPath(1819, 2845);
							self:RideHorse();
						end
					end
				else
					if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
					if me.nAutoFightState == 1 then
							AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
							AutoAi.ProcessHandCommand("auto_fight",0);
							me.AutoPath(nPosXMe-1, nPosYMe);
							end
							me.AutoPath(1819, 2845);
							self:RideHorse();
				end
			end
		else
			for _, pNpc in ipairs(tbNpcList2) do
				if (pNpc.nTemplateId == 4152) then
					if (me.nFaction == 5) then
						if(self.tbSetting.nAutoLevel==0) then
									if (self.Buff==nil) then
									self.Buff = Timer:Register(Env.GAME_FPS * 1, self.NmBuff, self);
									end
								else
									if me.nAutoFightState ~= 1 then
										AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
									end
								end
					else
						if me.nAutoFightState ~= 1 then
							AutoAi.SetTargetIndex(pNpc.nIndex);
							AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
						end
					end
					break;
				end
			end
			return;
		end
		return;
	elseif (Ui(Ui.UI_TEAM):IsTeamLeader()==0 and ChayBMSBuoc5==1) then
		if((1819-nPosXMe)^2 + (2845-nPosYMe)^2>200) then
				if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
				if me.nAutoFightState == 1 then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
				AutoAi.ProcessHandCommand("auto_fight",0);
				me.AutoPath(nPosXMe-1, nPosYMe);
				end
				me.AutoPath(1819, 2845);
				self:RideHorse();
				return;
		else
					if (me.nFaction == 5) then
						if(self.tbSetting.nAutoLevel==0) then
									if (self.Buff==nil) then
									self.Buff = Timer:Register(Env.GAME_FPS * 1, self.NmBuff, self);
									end
								else
									if me.nAutoFightState ~= 1 then
										AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
									end
								end
					else
						if me.nAutoFightState ~= 1 then
							AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
						end
					end
			for _, pNpc in ipairs(tbNpcList2) do
				if (pNpc.nTemplateId == 4152) then
					AutoAi.SetTargetIndex(pNpc.nIndex);
					break;
				end
			end
		end
		return;
	end
end
function uiQuanDoanh:BMSBuoc4()
	if Ui(Ui.UI_TEAM):IsTeamLeader()==1 then
local nCountFree  = me.CountFreeBagCell();
	if (nCountFree<2) then
		local tbFind = me.FindItemInBags(17,1,1,5)[1];
		if not tbFind then
			local tbFind = me.FindItemInBags(18,1,1,2,-1,0)[1];
			if tbFind then
				me.ThrowAway(tbFind.nRoom, tbFind.nX, tbFind.nY);
			end
		else
			me.UseItem(tbFind.pItem);
		end
	end
end
	local tbNpcList = KNpc.GetAroundNpcList(me,2000);
	local nMapIdMe, nPosXMe, nPosYMe	= me.GetWorldPos();
	local i=1;
	if ((1724-nPosXMe)^2 + (3131-nPosYMe)^2<100) then
		for _, pNpc in ipairs(tbNpcList) do
			if (pNpc.nTemplateId == 4121) then
				if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then	
						AutoAi.SetTargetIndex(pNpc.nIndex);
				else
						me.AnswerQestion(2);
						if (nCloseUiTimerId == 0) then
						nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
						end
				end
				break;
			end
		end
		return;
	end
--------
	if ((1862-nPosXMe)^2 + (2637-nPosYMe)^2>250 and me.GetItemCountInBags(20,1,626,1)<20 and ChayBMSBuoc4==0) then
		if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
		if me.nAutoFightState == 1 then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
				AutoAi.ProcessHandCommand("auto_fight",0);
				me.AutoPath(nPosXMe-1, nPosYMe);
		end
		AutoAi.SetTargetIndex(0);
		me.AutoPath(1862, 2637);
		self:RideHorse();
		return;
	elseif ((1862-nPosXMe)^2 + (2637-nPosYMe)^2<250 and me.GetItemCountInBags(20,1,626,1)<20 and ChayBMSBuoc4==0) then
		if (me.nFaction == 5) then
						if(self.tbSetting.nAutoLevel==0) then
									if (self.Buff==nil) then
									self.Buff = Timer:Register(Env.GAME_FPS * 1, self.NmBuff, self);
									end
								else
									if me.nAutoFightState ~= 1 then
										AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
									end
								end
					else
						if me.nAutoFightState ~= 1 then
							AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
						end
		end
		return;
	elseif ((1874-nPosXMe)^2 + (2693-nPosYMe)^2>200 and me.GetItemCountInBags(20,1,626,1)>=20 and ChayBMSBuoc4==0) then
		if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
		if me.nAutoFightState == 1 then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
				AutoAi.ProcessHandCommand("auto_fight",0);
				me.AutoPath(nPosXMe-1, nPosYMe);
		end
		AutoAi.SetTargetIndex(0);
		me.AutoPath(1874, 2693);
		self:RideHorse();
		return;
	elseif ((1874-nPosXMe)^2 + (2693-nPosYMe)^2<200 and me.GetItemCountInBags(20,1,626,1)>=20 and ChayBMSBuoc4==0) then
		if (UiManager:WindowVisible(Ui.UI_ITEMGIFT) ~= 1) then
			for _, pNpc in ipairs(tbNpcList) do
				if (pNpc.nTemplateId == 4169) then
					if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1) then	
							if Ui(Ui.UI_TEAM):IsTeamLeader()==1 then
							AutoAi.SetTargetIndex(pNpc.nIndex);
							end
					end
					break;
				elseif (pNpc.nTemplateId ~= 4169 and pNpc.nTemplateId == 4134) then
					if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then	
							AutoAi.SetTargetIndex(pNpc.nIndex);
					else
							me.AnswerQestion(0);
							if (nCloseUiTimerId == 0) then
							nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
							end
					end
					break;
				end
			end
		else
			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
						UiManager:CloseWindow(Ui.UI_SAYPANEL);   -- 关闭对话窗口
					end
					local tbExtBagLayout = Ui.tbLogic.tbExtBagLayout;
							tbExtBagLayout:Show();    
							for j = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nLine - 1 do
							for i = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRow - 1 do
								local pItem = me.GetMainBagItem(i,j);
								if pItem then
									local tbObj =Ui(Ui.UI_ITEMBOX).tbMainBagCont.tbObjs[j][i];
									if pItem.szName == "Đuôi bọ cạp" then
										Ui(Ui.UI_ITEMBOX).tbMainBagCont:UseObj(tbObj,i,j);
									end
								end
							end
							end
							--- End Hom Chinh


							--- Hom Phu 1
							if (UiManager:WindowVisible(Ui.UI_EXTBAG1) == 1) then
								for j = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nLine - 1 do
								for i = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRow - 1 do
									local pItem = me.GetItem(Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRoom, i, j);
									if pItem then
									local tbObj =Ui(Ui.UI_EXTBAG1).tbExtBagCont.tbObjs[j][i];
									if pItem.szName == "Đuôi bọ cạp" then
										Ui(Ui.UI_EXTBAG1).tbExtBagCont:UseObj(tbObj,i,j);
									end
									end
								end
								end
							end
							--- End Hom Phu 1

							--- Hom Phu 2
							if (UiManager:WindowVisible(Ui.UI_EXTBAG2) == 1) then
								for j = 0, Ui(Ui.UI_EXTBAG2).tbExtBagCont.nLine - 1 do
								for i = 0, Ui(Ui.UI_EXTBAG2).tbExtBagCont.nRow - 1 do
									local pItem = me.GetItem(Ui(Ui.UI_EXTBAG2).tbExtBagCont.nRoom, i, j);
									if pItem then
									local tbObj =Ui(Ui.UI_EXTBAG2).tbExtBagCont.tbObjs[j][i];
									if pItem.szName == "Đuôi bọ cạp" then
										Ui(Ui.UI_EXTBAG2).tbExtBagCont:UseObj(tbObj,i,j);
									end
									end
								end
								end
							end
							--- End Hom Phu 2

							--- Hom Phu 3
							if (UiManager:WindowVisible(Ui.UI_EXTBAG3) == 1) then
								for j = 0, Ui(Ui.UI_EXTBAG3).tbExtBagCont.nLine - 1 do
								for i = 0, Ui(Ui.UI_EXTBAG3).tbExtBagCont.nRow - 1 do
									local pItem = me.GetItem(Ui(Ui.UI_EXTBAG3).tbExtBagCont.nRoom, i, j);
									if pItem then
									local tbObj =Ui(Ui.UI_EXTBAG3).tbExtBagCont.tbObjs[j][i];
									if pItem.szName == "Đuôi bọ cạp" then
										Ui(Ui.UI_EXTBAG3).tbExtBagCont:UseObj(tbObj,i,j);
									end
									end
								end
								end
							end
							local uiGift = Ui(Ui.UI_ITEMGIFT)
							uiGift.OnButtonClick(uiGift,"BtnOk");
							if (nCloseUiTimerId == 0) then
								nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
							end
		end
		return;
	------
	elseif ((1883-nPosXMe)^2 + (2603-nPosYMe)^2>150 and ChayBMSBuoc4==1) then
		if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
		if me.nAutoFightState == 1 then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
				AutoAi.ProcessHandCommand("auto_fight",0);
				me.AutoPath(nPosXMe-1, nPosYMe);
		end
		AutoAi.SetTargetIndex(0);
		me.AutoPath(1883, 2603);
		self:RideHorse();
		return;
	elseif ((1883-nPosXMe)^2 + (2603-nPosYMe)^2<150 and ChayBMSBuoc4==1) then
					if (me.nFaction == 5) then
						if(self.tbSetting.nAutoLevel==0) then
									if (self.Buff==nil) then
									self.Buff = Timer:Register(Env.GAME_FPS * 1, self.NmBuff, self);
									end
								else
									if me.nAutoFightState ~= 1 then
										AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
									end
								end
					else
						if me.nAutoFightState ~= 1 then
							AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
						end
					end
		for _, pNpc in ipairs(tbNpcList) do
			if(pNpc.nTemplateId == 4136) then
				AutoAi.SetTargetIndex(pNpc.nIndex);	
				break;
			end
		end
		return;
	end
--------	
end
function uiQuanDoanh:BMSBuoc3()
	local tbNpcList = KNpc.GetAroundNpcList(me,2000);
	local nMapIdMe, nPosXMe, nPosYMe	= me.GetWorldPos();
	local i=1;
	if ((1724-nPosXMe)^2 + (3131-nPosYMe)^2<100) then
		for _, pNpc in ipairs(tbNpcList) do
			if (pNpc.nTemplateId == 4121) then
				if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then	
						AutoAi.SetTargetIndex(pNpc.nIndex);
				else
						me.AnswerQestion(1);
						if (nCloseUiTimerId == 0) then
						nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
						end
				end
				break;
			end
		end
		return;
	end
	----
	if ((1952-nPosXMe)^2 + (2896-nPosYMe)^2>250 and ChayBMSBuoc3==0) then
		if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
		if me.nAutoFightState == 1 then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
				AutoAi.ProcessHandCommand("auto_fight",0);
				me.AutoPath(nPosXMe-1, nPosYMe);
		end
		AutoAi.SetTargetIndex(0);
		me.AutoPath(1952, 2896);
		self:RideHorse();
		return;
	elseif ((1952-nPosXMe)^2 + (2896-nPosYMe)^2<250 and ChayBMSBuoc3==0) then
		for _, pNpc in ipairs(tbNpcList) do
			if (pNpc.nTemplateId == 4131) then
				if (me.nFaction == 5) then
						if(self.tbSetting.nAutoLevel==0) then
									if (self.Buff==nil) then
									self.Buff = Timer:Register(Env.GAME_FPS * 1, self.NmBuff, self);
									end
								else
									if me.nAutoFightState ~= 1 then
										AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
									end
								end
					else
						if me.nAutoFightState ~= 1 then
							AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
							
						end
				end
				break;
			elseif (pNpc.nTemplateId ~= 4131 and pNpc.nTemplateId==4129) then
				if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
				if me.nAutoFightState == 1 then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
				AutoAi.ProcessHandCommand("auto_fight",0);
				me.AutoPath(nPosXMe-1, nPosYMe);
				end
				AutoAi.SetTargetIndex(0);
				if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1) then	
						if Ui(Ui.UI_TEAM):IsTeamLeader()==1 then
						AutoAi.SetTargetIndex(pNpc.nIndex);
						end
				end
			end
		end
		return;
	
	elseif ((1975-nPosXMe)^2 + (2852-nPosYMe)^2>100 and ChayBMSBuoc3==1) then
		if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
		if me.nAutoFightState == 1 then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
				AutoAi.ProcessHandCommand("auto_fight",0);
				me.AutoPath(nPosXMe-1, nPosYMe);
		end
		AutoAi.SetTargetIndex(0);
		me.AutoPath(1975, 2852);
		self:RideHorse();
		return;
	elseif ((1975-nPosXMe)^2 + (2852-nPosYMe)^2<100 and ChayBMSBuoc3==1) then
		for _, pNpc in ipairs(tbNpcList) do
			if (pNpc.nTemplateId == 4130) then
				if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1) then	
						if Ui(Ui.UI_TEAM):IsTeamLeader()==1 then
							AutoAi.SetTargetIndex(pNpc.nIndex);
						end
				end
				break;
			end
		end
	elseif ((1975-nPosXMe)^2 + (2852-nPosYMe)^2>100 and ChayBMSBuoc3==2) then
		if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
		if me.nAutoFightState == 1 then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
				AutoAi.ProcessHandCommand("auto_fight",0);
				me.AutoPath(nPosXMe-1, nPosYMe);
		end
		AutoAi.SetTargetIndex(0);
		me.AutoPath(1975, 2852);
		self:RideHorse();
		return;
	elseif ((1975-nPosXMe)^2 + (2852-nPosYMe)^2<100 and ChayBMSBuoc3==2) then
		if (me.nFaction == 5) then
						if(self.tbSetting.nAutoLevel==0) then
									if (self.Buff==nil) then
									self.Buff = Timer:Register(Env.GAME_FPS * 1, self.NmBuff, self);
									end
								else
									if me.nAutoFightState ~= 1 then
										AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
									end
								end
		else
						if me.nAutoFightState ~= 1 then
							AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());	
						end
		end
	------
	end
---------------	
end
function uiQuanDoanh:BMSBuoc2()
	local tbNpcList = KNpc.GetAroundNpcList(me,2000);
	local nMapIdMe, nPosXMe, nPosYMe	= me.GetWorldPos();
	local i=1;
	if ((1724-nPosXMe)^2 + (3131-nPosYMe)^2<100) then
		for _, pNpc in ipairs(tbNpcList) do
			if (pNpc.nTemplateId == 4121) then
				if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then	
						AutoAi.SetTargetIndex(pNpc.nIndex);
				else
						me.AnswerQestion(0);
						if (nCloseUiTimerId == 0) then
						nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
						end
				end
				break;
			end
		end
		return;
	end
	if ((1783-nPosXMe)^2 + (3070-nPosYMe)^2<200 and ChayBMSBuoc2==0) then
		for _, pNpc in ipairs(tbNpcList) do
			if (pNpc.nTemplateId == 4125) then
					if (me.nFaction == 5) then
						if(self.tbSetting.nAutoLevel==0) then
									if (self.Buff==nil) then
									self.Buff = Timer:Register(Env.GAME_FPS * 1, self.NmBuff, self);
									end
								else
									if me.nAutoFightState ~= 1 then
										AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
									end
								end
					else
						AutoAi.SetTargetIndex(pNpc.nIndex);
						if me.nAutoFightState ~= 1 then
							AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());	
						end
					end
				break;
			end
		end
		return;
	elseif ((1783-nPosXMe)^2 + (3070-nPosYMe)^2>200 and ChayBMSBuoc2==0) then
		if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
		if me.nAutoFightState == 1 then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
				AutoAi.ProcessHandCommand("auto_fight",0);
				me.AutoPath(nPosXMe-1, nPosYMe);
		end
		AutoAi.SetTargetIndex(0);
		me.AutoPath(1783, 3070);
		self:RideHorse();
		return;
	elseif ((1800-nPosXMe)^2 + (3035-nPosYMe)^2>200 and ChayBMSBuoc2==1) then
		if (self.Buff~=nil) then
					Timer:Close(self.Buff);
					self.Buff = nil;
				end
		if me.nAutoFightState == 1 then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
				AutoAi.ProcessHandCommand("auto_fight",0);
				me.AutoPath(nPosXMe-1, nPosYMe);
		end
		AutoAi.SetTargetIndex(0);
		me.AutoPath(1800, 3035);
		self:RideHorse();
		return;
	elseif ((1800-nPosXMe)^2 + (3035-nPosYMe)^2<200 and ChayBMSBuoc2==1) then
		for _, pNpc in ipairs(tbNpcList) do
			if (pNpc.nTemplateId == 4127) then
				if (me.nFaction == 5) then
				if(self.tbSetting.nAutoLevel==0) then
									if (self.Buff==nil) then
									self.Buff = Timer:Register(Env.GAME_FPS * 1, self.NmBuff, self);
									end
								else
									if me.nAutoFightState ~= 1 then
										AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
									end
								end
				else
				if me.nAutoFightState ~= 1 then
					AutoAi.SetTargetIndex(pNpc.nIndex);
					AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
				end
			end
				ChayBMSBuoc2=1;
				break;
			elseif (pNpc.nTemplateId ~= 4127) then
				ChayBMSBuoc2=0;
			end
		end
	end
end
function uiQuanDoanh:BMSBuoc1()
if Ui(Ui.UI_TEAM):IsTeamLeader()==1 then
local nCountFree  = me.CountFreeBagCell();
	if (nCountFree<2) then
		local tbFind = me.FindItemInBags(17,1,1,5)[1];
		if not tbFind then
			local tbFind = me.FindItemInBags(18,1,1,2,-1,0)[1];
			if tbFind then
				me.ThrowAway(tbFind.nRoom, tbFind.nX, tbFind.nY);
			end
		else
			me.UseItem(tbFind.pItem);
		end
	end
end
local nMapIdMe, nPosXMe, nPosYMe	= me.GetWorldPos();
local tbNpcList = KNpc.GetAroundNpcList(me,2000);
	if ((1724-nPosXMe)^2 + (3131-nPosYMe)^2<100) then
		MoveTo(24,	0);
		return;
	elseif ((1724-nPosXMe)^2 + (3131-nPosYMe)^2>100 and (1679-nPosXMe)^2 + (3113-nPosYMe)^2>200 and me.GetItemCountInBags(20,1,623,1)<20 and ChayBMSBuoc1==0) then
		if (self.Buff~=nil) then
			Timer:Close(self.Buff);
			self.Buff = nil;
		end
		if me.nAutoFightState == 1 then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
				AutoAi.ProcessHandCommand("auto_fight",0);
				me.AutoPath(nPosXMe-1, nPosYMe);
		end
		AutoAi.SetTargetIndex(0);
		me.AutoPath(1679, 3113);
		self:RideHorse();
		return;
	elseif ((1724-nPosXMe)^2 + (3131-nPosYMe)^2>100 and (1679-nPosXMe)^2 + (3113-nPosYMe)^2<200 and me.GetItemCountInBags(20,1,623,1)<20 and ChayBMSBuoc1==0) then
		if (me.nFaction == 5) then
			if(self.tbSetting.nAutoLevel==0) then
									if (self.Buff==nil) then
										self.Buff = Timer:Register(Env.GAME_FPS * 1, self.NmBuff, self);
									end
								else
									if me.nAutoFightState ~= 1 then
										AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
									end
								end
		else
		if me.nAutoFightState ~= 1 then
			AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
			
		end
		end
		return;
	elseif ((1724-nPosXMe)^2 + (3131-nPosYMe)^2>100 and me.GetItemCountInBags(20,1,623,1)>=20 and ChayBMSBuoc1==0) then
		if (self.Buff~=nil) then
			Timer:Close(self.Buff);
			self.Buff = nil;
		end
		if me.nAutoFightState == 1 then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
				AutoAi.ProcessHandCommand("auto_fight",0);
				AutoAi.SetTargetIndex(0);
				me.AutoPath(nPosXMe-1, nPosYMe);
		end
		if (UiManager:WindowVisible(Ui.UI_ITEMGIFT) ~= 1) then
			if ((1713-nPosXMe)^2 + (3104-nPosYMe)^2<100) then
				for _, pNpc in ipairs(tbNpcList) do
					if (pNpc.nTemplateId == 4123) then
						if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
						AutoAi.SetTargetIndex(pNpc.nIndex);
						else
						me.AnswerQestion(0);
						end
						break;
					end
				end
			else
				AutoAi.SetTargetIndex(0);
				me.AutoPath(1713, 3104);
			end
		else
					if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
						UiManager:CloseWindow(Ui.UI_SAYPANEL);   -- 关闭对话窗口
					end
					local tbExtBagLayout = Ui.tbLogic.tbExtBagLayout;
							tbExtBagLayout:Show();    
							for j = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nLine - 1 do
							for i = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRow - 1 do
								local pItem = me.GetMainBagItem(i,j);
								if pItem then
									local tbObj =Ui(Ui.UI_ITEMBOX).tbMainBagCont.tbObjs[j][i];
									if pItem.szName == "Nhiếp Không Thảo" then
										Ui(Ui.UI_ITEMBOX).tbMainBagCont:UseObj(tbObj,i,j);
									end
								end
							end
							end
							--- End Hom Chinh


							--- Hom Phu 1
							if (UiManager:WindowVisible(Ui.UI_EXTBAG1) == 1) then
								for j = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nLine - 1 do
								for i = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRow - 1 do
									local pItem = me.GetItem(Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRoom, i, j);
									if pItem then
									local tbObj =Ui(Ui.UI_EXTBAG1).tbExtBagCont.tbObjs[j][i];
									if pItem.szName == "Nhiếp Không Thảo" then
										Ui(Ui.UI_EXTBAG1).tbExtBagCont:UseObj(tbObj,i,j);
									end
									end
								end
								end
							end
							--- End Hom Phu 1

							--- Hom Phu 2
							if (UiManager:WindowVisible(Ui.UI_EXTBAG2) == 1) then
								for j = 0, Ui(Ui.UI_EXTBAG2).tbExtBagCont.nLine - 1 do
								for i = 0, Ui(Ui.UI_EXTBAG2).tbExtBagCont.nRow - 1 do
									local pItem = me.GetItem(Ui(Ui.UI_EXTBAG2).tbExtBagCont.nRoom, i, j);
									if pItem then
									local tbObj =Ui(Ui.UI_EXTBAG2).tbExtBagCont.tbObjs[j][i];
									if pItem.szName == "Nhiếp Không Thảo" then
										Ui(Ui.UI_EXTBAG2).tbExtBagCont:UseObj(tbObj,i,j);
									end
									end
								end
								end
							end
							--- End Hom Phu 2

							--- Hom Phu 3
							if (UiManager:WindowVisible(Ui.UI_EXTBAG3) == 1) then
								for j = 0, Ui(Ui.UI_EXTBAG3).tbExtBagCont.nLine - 1 do
								for i = 0, Ui(Ui.UI_EXTBAG3).tbExtBagCont.nRow - 1 do
									local pItem = me.GetItem(Ui(Ui.UI_EXTBAG3).tbExtBagCont.nRoom, i, j);
									if pItem then
									local tbObj =Ui(Ui.UI_EXTBAG3).tbExtBagCont.tbObjs[j][i];
									if pItem.szName == "Nhiếp Không Thảo" then
										Ui(Ui.UI_EXTBAG3).tbExtBagCont:UseObj(tbObj,i,j);
									end
									end
								end
								end
							end
							local uiGift = Ui(Ui.UI_ITEMGIFT)
							uiGift.OnButtonClick(uiGift,"BtnOk");
							if (nCloseUiTimerId == 0) then
								nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
							end
		end
	
			return;
	elseif ((1724-nPosXMe)^2 + (3131-nPosYMe)^2>100 and me.GetItemCountInBags(20,1,623,1)<20 and ChayBMSBuoc1==1) then
	-- Tiep tuc elseif
		if ((1670-nPosXMe)^2 + (2911-nPosYMe)^2>200) then
			if (self.Buff~=nil) then
			Timer:Close(self.Buff);
			self.Buff = nil;
			end
			if me.nAutoFightState == 1 then
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
				AutoAi.ProcessHandCommand("auto_fight",0);
				me.AutoPath(nPosXMe-1, nPosYMe);
			end
			AutoAi.SetTargetIndex(0);
			me.AutoPath(1670, 2911);
			self:RideHorse();
		else
					for _, pNpc in ipairs(tbNpcList) do
						if (pNpc.nTemplateId==4124) then
							if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then	
								AutoAi.SetTargetIndex(pNpc.nIndex);
							else
							me.AnswerQestion(0);	
							end
							break;
						elseif (pNpc.nTemplateId==4171) then
							if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
								UiManager:CloseWindow(Ui.UI_SAYPANEL);   -- 关闭对话窗口
							end
							if (me.nFaction == 5) then
								if(self.tbSetting.nAutoLevel==0) then
									if (self.Buff==nil) then
									self.Buff = Timer:Register(Env.GAME_FPS * 1, self.NmBuff, self);
									end
								else
									if me.nAutoFightState ~= 1 then
										AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
									end
								end
							else
							if me.nAutoFightState ~= 1 then
								AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
							end
							end
							break;
						end
					end
		end
	end
	-- het Ìf
end
function uiQuanDoanh:NmBuff()
	me.UseSkill(98,GetCursorPos());
	self:StopAutoFight();
end
function uiQuanDoanh:RideHorse()
	local bChecked = me.GetNpc().IsRideHorse();	-- 是否在马上
	if (bChecked == 0) then
		Switch([[horse]]);
	end
end

-- 功能：下马
function uiQuanDoanh:GetDownHorse()
	local bChecked = me.GetNpc().IsRideHorse(); -- 是否在马上
	if (bChecked == 1) then
		Switch([[horse]]);
	end
end

-- 功能：检查背包物品(药品或菜)数量
function uiQuanDoanh:GetItemCountByName(szName)
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

-- 功能：购买红药
function uiQuanDoanh:BuyRed(szName,nNum)
        local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
        me.Msg("Mua máu số lượng: " .. string.format(self.tbSetting.nBuyRedNum));
	local nCountFree = me.CountFreeBagCell();
	if (nNum >= nCountFree) then
		nNum = nCountFree - 1;			-- 背包留一格
	end
	local uId = uiQuanDoanh.STUFF_LIST[szName][3];	-- 680 九转还魂丹 药品+25 菜+35 材料+35
	local pItem = KItem.GetItemObj(uId);
	if (pItem and UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
		me.ShopBuyItem(uId,nNum);
		UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIREXALL_SEND);
		if (nCloseUiTimerId == 0) then
			nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
		end
	else
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1 then
				local tbNpcList = KNpc.GetAroundNpcList(me,2000);
				for _, pNpc in ipairs(tbNpcList) do
					if (pNpc.szName=="Trương Trảm Kinh") then
					AutoAi.SetTargetIndex(pNpc.nIndex);
					break;
					end
				end
		else
			me.AnswerQestion(0);
		end
	end
end

function uiQuanDoanh:BuyRed2(szName,nNum)
	local nCountFree = me.CountFreeBagCell();
	if (nNum >= nCountFree) then
		nNum = nCountFree - 1;			-- 背包留一格
	end
	local uId = szName;	-- 680 九转还魂丹 药品+25 菜+35 材料+35
	local nTaskMapID = self.tbCityMap[self.tbSetting.nCityMapID + 1][2];
	local szLink = ","..nTaskMapID..",3566";	-- 3564是药铺老板
	local pItem = KItem.GetItemObj(uId);
	if (pItem and UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
		me.ShopBuyItem(uId, nNum);
		UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIREXALL_SEND);
		if (nCloseUiTimerId == 0) then
			nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
		end
	else
		if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
			UiManager.tbLinkClass["npcpos"]:OnClick(szLink);
		else
			me.AnswerQestion(0);
		end
		
	end
end
function uiQuanDoanh:BuyRed3(szName,nNum,Map)
	local nCountFree = me.CountFreeBagCell();
	if (nNum >= nCountFree) then
		nNum = nCountFree - 1;			-- 背包留一格
	end
	local uId = szName;	-- 680 九转还魂丹 药品+25 菜+35 材料+35
	local nTaskMapID = Map;
	local szLink = ","..nTaskMapID..",3565";	-- 3564是药铺老板
	local pItem = KItem.GetItemObj(uId);
	if (pItem and UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
		me.ShopBuyItem(uId, nNum);
		if (nCloseUiTimerId == 0) then
			nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(pCloseUiTime * Env.GAME_FPS, self.CloseUiWindow);
		end
	else
		if (UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
			UiManager.tbLinkClass["npcpos"]:OnClick(szLink);
		else
			me.AnswerQestion(0);
		end
	end
end
function uiQuanDoanh:Hexuan(n,l,Num)
	local nMoneyType = Item.BIND_MONEY;
	if n == 0 or me.GetBindMoney()< 10000 then
		nMoneyType = Item.NORMAL_MONEY;
	end
	if self:CanCompose(n,l,Num) == 1 then
		if UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1 then
			for i=1,l do
				if (Num[2] == 0 and nCount[i] >= Num[1] and i<= l) or (Num[2] > 0 and (i+1)<= l and nCount[i] >= Num[1] and nCount[i+1] >= Num[2]) then
					me.Msg(Num[1].." viên Huyền Tinh cấp "..i.." + "..Num[2].." viên cấp "..(i+1).." <color=green>để hợp thành cấp: "..(i+2).."");
					self:PutXuanjing(i,n,Num[1]);
					self:PutXuanjing(i+1,n,Num[2]);
					me.ApplyEnhance(Item.ENHANCE_MODE_COMPOSE,nMoneyType);
					return;
				elseif (Num[4] == 0 and nCount[i] >= Num[3] and i<= l) or (Num[4] > 0 and (i+1)<= l and nCount[i] >= Num[3] and nCount[i+1] >= Num[4]) then
					me.Msg(Num[3].." viên Huyền Tinh cấp "..i.." + "..Num[4].." viên cấp "..(i+1).." <color=green>để hợp thành cấp: "..(i+2).."");
					self:PutXuanjing(i,n,Num[3]);
					self:PutXuanjing(i+1,n,Num[4]);
					me.ApplyEnhance(Item.ENHANCE_MODE_COMPOSE,nMoneyType);
					return;
				elseif (Num[6] == 0 and nCount[i] >= Num[5] and i<= l) or (Num[6] > 0 and (i+1)<= l and nCount[i] >= Num[5] and nCount[i+1] >= Num[6]) then
					me.Msg(Num[5].." viên Huyền Tinh cấp "..i.." + "..Num[6].." viên cấp "..(i+1).." <color=green>để hợp thành cấp: "..(i+2).."");
					self:PutXuanjing(i,n,Num[5]);
					self:PutXuanjing(i+1,n,Num[6]);
					me.ApplyEnhance(Item.ENHANCE_MODE_COMPOSE,nMoneyType);
					return;
				elseif (Num[8] == 0 and nCount[i] >= Num[7] and i<= l) or (Num[8] > 0 and (i+1)<= l and nCount[i] >= Num[7] and nCount[i+1] >= Num[8]) then
					me.Msg(Num[7].." viên Huyền Tinh cấp "..i.." + "..Num[8].." viên cấp "..(i+1).." <color=green>để hợp thành cấp: "..(i+2).."");
					self:PutXuanjing(i,n,Num[7]);
					self:PutXuanjing(i+1,n,Num[8]);
					me.ApplyEnhance(Item.ENHANCE_MODE_COMPOSE,nMoneyType);
					return;
				end
			end
		else
			me.Msg("Chuẩn bị ghép Huyền tinh ...");
			self:GotoYelian(nMoneyType);
			uiQuanDoanh:OpenExtBag();	
			return;
		end
	else
		if UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1 then
			UiManager:CloseWindow(Ui.UI_EQUIPENHANCE);
			UiManager:CloseWindow(Ui.UI_ITEMBOX);
			me.Msg("<color=green>Ghép Huyền Tinh đã hoàn thành.");
		else
			if me.nMapId <= 0 then 
				return; 
			end
			me.Msg("<color=green>Không có đủ Huyền Tinh để ghép");
		end
		if self.nTimer ~= 0 then
			Timer:Close(self.nTimer);
			self.nTimer = 0;
		end
		self:UpdateButton(nType,self.nTimer);
		return 0;
	end
end


function uiQuanDoanh:CanCompose(n,l,Num)
	local can = 0;
	for i = 1, l do
		if n == 0 then
			nCount[i] = me.GetItemCountInBags(18,1,1,i,-1,0);
			--me.Msg("<color=yellow>Huyền Tinh cấp "..i.." (không khóa) có: <color><color=green>"..nCount[i].." viên<color>");
		elseif n == 1 then
			nCount[i] = me.GetItemCountInBags(18,1,114,i);
			nCount[i] = nCount[i] + me.GetItemCountInBags(18,1,1,i,-1,1);
			--me.Msg("<color=yellow>Huyền Tinh cấp "..i.." (khóa) có: <color><color=green>"..nCount[i].." viên<color>");
		elseif n == 2 then
			nCount[i] = me.GetItemCountInBags(18,1,1,i,-1,0);
			nCount[i] = nCount[i] + me.GetItemCountInBags(18,1,1,i,-1,1);
			nCount[i] = nCount[i] + me.GetItemCountInBags(18,1,114,i);
			--me.Msg("<color=yellow>Huyền Tinh cấp "..i.." có: <color><color=green>"..nCount[i].." viên<color>");
		end
	end
	for i = 1, l do
		if (Num[2] == 0 and nCount[i] >= Num[1] and i<= l) or (Num[2] > 0 and (i+1)<= l and nCount[i] >= Num[1] and nCount[i+1] >= Num[2]) then
			can = 1;
		end
		if (Num[4] == 0 and nCount[i] >= Num[3] and i<= l) or (Num[4] > 0 and (i+1)<= l and nCount[i] >= Num[3] and nCount[i+1] >= Num[4]) then
			can = 1;
		end
		if (Num[6] == 0 and nCount[i] >= Num[5] and i<= l) or (Num[6] > 0 and (i+1)<= l and nCount[i] >= Num[5] and nCount[i+1] >= Num[6]) then
			can = 1;
		end
		if (Num[8] == 0 and nCount[i] >= Num[7] and i<= l) or (Num[8] > 0 and (i+1)<= l and nCount[i] >= Num[7] and nCount[i+1] >= Num[8]) then
			can = 1;
		end
	end
	return can;
end


function uiQuanDoanh:GotoYelian(nMoneyType)
	if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1) then
		return;
	end
	local n = 0;
	if nMoneyType == Item.NORMAL_MONEY then
		n = 1;
	end
	if (me.nMapId ==3) then
		if (UiManager:WindowVisible(Ui.UI_SAYPANEL)~=1) then
			Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ","..me.nMapId..",3574"});
		else
			me.AnswerQestion(2);
			me.AnswerQestion(n);
			if (nCloseUiTimerId == 0) then
				nCloseUiTimerId = Ui.tbLogic.tbTimer:Register(5 * Env.GAME_FPS, self.CloseUiWindow);
			end
		end
	end
end


function uiQuanDoanh:PutXuanjing(l,n,count)
	local k = 0;
	if count == 0 then
		return;
	end
	for j = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nLine - 1 do
		for i = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRow - 1 do
--			local pItem = me.GetItem(Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRoom, i, j);
			local pItem = me.GetMainBagItem(i,j);
			if pItem then
				local tbObj =Ui(Ui.UI_ITEMBOX).tbMainBagCont.tbObjs[j][i];
				if n == 2 then
					if pItem.szClass == "xuanjing" and pItem.nLevel == l then
						k= k+1;
						Ui(Ui.UI_ITEMBOX).tbMainBagCont:UseObj(tbObj,i,j);
						if k >= count then
							return;
						end
					end
				else
					if pItem.szClass == "xuanjing" and pItem.nLevel == l and pItem.IsBind() == n then
						k= k+1;
						Ui(Ui.UI_ITEMBOX).tbMainBagCont:UseObj(tbObj,i,j);
						if k >= count then
							return;
						end
					end
				end
			end
		end
	end

	if (UiManager:WindowVisible(Ui.UI_EXTBAG1) == 1) then
		for j = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nLine - 1 do
			for i = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRow - 1 do
				local pItem = me.GetItem(Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRoom, i, j);
				if pItem then
					local tbObj =Ui(Ui.UI_EXTBAG1).tbExtBagCont.tbObjs[j][i];
					if n == 2 then
						if pItem.szClass == "xuanjing" and pItem.nLevel == l then
							k= k+1;
							Ui(Ui.UI_EXTBAG1).tbExtBagCont:UseObj(tbObj,i,j);
							if k >= count then
								return;
							end
						end
					else
						if pItem.szClass == "xuanjing" and pItem.nLevel == l and pItem.IsBind() == n then
							k= k+1;
							Ui(Ui.UI_EXTBAG1).tbExtBagCont:UseObj(tbObj,i,j);
							if k >= count then
								return
							end
						end
					end
				end
			end
		end
	end

	if (UiManager:WindowVisible(Ui.UI_EXTBAG2) == 1) then
		for j = 0, Ui(Ui.UI_EXTBAG2).tbExtBagCont.nLine - 1 do
			for i = 0, Ui(Ui.UI_EXTBAG2).tbExtBagCont.nRow - 1 do
				local pItem = me.GetItem(Ui(Ui.UI_EXTBAG2).tbExtBagCont.nRoom, i, j);
				if pItem then
					local tbObj =Ui(Ui.UI_EXTBAG2).tbExtBagCont.tbObjs[j][i];
					if n == 2 then
						if pItem.szClass == "xuanjing" and pItem.nLevel == l then
							k= k+1;
							Ui(Ui.UI_EXTBAG2).tbExtBagCont:UseObj(tbObj,i,j);
							if k >= count then
								return;
							end
						end
					else
						if pItem.szClass == "xuanjing" and pItem.nLevel == l and pItem.IsBind() == n then
							k= k+1;
							Ui(Ui.UI_EXTBAG2).tbExtBagCont:UseObj(tbObj,i,j);
							if k >= count then
								return
							end
						end
					end
				end
			end
		end
	end

	if (UiManager:WindowVisible(Ui.UI_EXTBAG3) == 1) then
		for j = 0, Ui(Ui.UI_EXTBAG3).tbExtBagCont.nLine - 1 do
			for i = 0, Ui(Ui.UI_EXTBAG3).tbExtBagCont.nRow - 1 do
				local pItem = me.GetItem(Ui(Ui.UI_EXTBAG3).tbExtBagCont.nRoom, i, j);
				if pItem then
					local tbObj =Ui(Ui.UI_EXTBAG3).tbExtBagCont.tbObjs[j][i];
					if n == 2 then
						if pItem.szClass == "xuanjing" and pItem.nLevel == l then
							k= k+1;
							Ui(Ui.UI_EXTBAG3).tbExtBagCont:UseObj(tbObj,i,j);
							if k >= count then
								return;
							end
						end
					else
						if pItem.szClass == "xuanjing" and pItem.nLevel == l and pItem.IsBind() == n then
							k= k+1;
							Ui(Ui.UI_EXTBAG3).tbExtBagCont:UseObj(tbObj,i,j);
							if k >= count then
								return
							end
						end
					end
				end
			end
		end
	end
	return 0;
end

function uiQuanDoanh:OpenExtBag()	
	if (UiManager:WindowVisible(Ui.UI_ITEMBOX) ~= 1) then		
		UiManager:SwitchWindow(Ui.UI_ITEMBOX); -- đánh 开背包
	end	
	local tbItemBox = Ui(Ui.UI_ITEMBOX);	
	local tbExtBagLayout = Ui.tbLogic.tbExtBagLayout;
	tbExtBagLayout:Show();     -- đánh mở túi mở rộng  
end
function uiQuanDoanh:CloseUiWindow()
	if (UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
		UiManager:CloseWindow(Ui.UI_SHOP);       -- 关闭商店窗口
	end
	if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);   -- 关闭对话窗口
	end
	if (UiManager:WindowVisible(Ui.UI_REPOSITORY) == 1) then
		UiManager:CloseWindow(Ui.UI_REPOSITORY); -- 关闭仓库窗口
	end
	if (UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1) then
		UiManager:CloseWindow(Ui.UI_ITEMBOX); -- 关闭仓库窗口
	end
	if (UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1) then
		UiManager:CloseWindow(Ui.UI_EQUIPENHANCE); -- 关闭仓库窗口
	end
	if (nCloseUiTimerId > 0) then
		Ui.tbLogic.tbTimer:Close(nCloseUiTimerId);
		nCloseUiTimerId = 0;
	end
end

-- 功能:关闭自动战斗
function uiQuanDoanh:StopAutoFight()
	if me.nAutoFightState == 1 then
		AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
	end
end

-- 功能：设置死亡回城点
function uiQuanDoanh:SetDeathRevivePos(nCityMapId)
	local nMapId = 24;
	if (nCityMapId) then
		nMapId = nCityMapId;
	end
	local szLink = ","..nMapId..",2599,1";	-- 26是扬州，2599是邹德侩（物品保管人）
	UiManager.tbLinkClass["npcpos"]:OnClick(szLink);
end

-- 功能：根据TemplateId返回周围Npc的TargetIndex
function uiQuanDoanh:GetAroundNpcTargetIndex(nTemplateId)
	local tbAroundNpc = KNpc.GetAroundNpcList(me, 100);
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == nTemplateId) then
			return pNpc.nIndex;
		end
	end
	return 0;
end


function uiQuanDoanh:TeamLeave()
	local nAllotModel, tbMemberList = me.GetTeamInfo();
	if tbMemberList == nil then
		return;
	end
	me.TeamLeave();
	self:ClearTeamLeader();
end

-- 功能：清空tbTeamLeader
function uiQuanDoanh:ClearTeamLeader()
	tbTeamLeader = {};
end
function uiQuanDoanh:ModifyUi()
	local uiMsgPad = Ui(Ui.UI_MSGPAD)
	uiQuanDoanh.Say_bak	= uiQuanDoanh.Say_bak or Ui(Ui.UI_MSGPAD).OnSendMsgToChannel
	function uiMsgPad:OnSendMsgToChannel(szChannelName, szName, szMsg, szGateway)
		uiQuanDoanh.Say_bak(Ui(Ui.UI_MSGPAD), szChannelName, szName, szMsg, szGateway);
		local function fnOnSay()
			uiQuanDoanh:OnSay(szChannelName, szName, szMsg, szGateway);
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(1, fnOnSay)
	end
end
function uiQuanDoanh:ModifyUi2()
	local uiSayPanel = Ui(Ui.UI_SAYPANEL);
	uiQuanDoanh.Say_bak2 = uiQuanDoanh.Say_bak2 or Ui(Ui.UI_SAYPANEL).OnOpen
	function uiSayPanel:OnOpen(tbParam)
	uiQuanDoanh.Say_bak2(Ui(Ui.UI_SAYPANEL), tbParam)
	local function fnOnSay2()
			uiQuanDoanh:OnSay2(tbParam)
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(1, fnOnSay2)
	end
end
function uiQuanDoanh:OnSay2(tbParam)
	if (nWantedState==1) then
		for i, szAns in ipairs(tbParam[2]) do
			if (szAns=="[Nhiệm vụ] "..BienTam.."-Nhận thưởng") then
				annut=i-1;
				break;
			elseif (szAns=="[Nhiệm vụ] "..BienTam) then
				annut=i-1;
				break;
			end
			--{"Thanh Long", 556},
			--{"Huyền Vũ", 559},
			--{"Chu Tước", 558},
			if (self.tbCityMap[self.tbSetting.nCityMapID + 1][2]==556) then
				if (szAns=="Phục Ngưu Sơn Quân Doanh [Thanh Long]") then
					phu=i-1;
					break;
				end
				return;
			elseif (self.tbCityMap[self.tbSetting.nCityMapID + 1][2]==559) then
				if (szAns=="Phục Ngưu Sơn Quân Doanh [Huyền Vũ]") then
					phu=i-1;
					break;
				end
				return;
			elseif (self.tbCityMap[self.tbSetting.nCityMapID + 1][2]==558) then
				if (szAns=="Phục Ngưu Sơn Quân Doanh [Chu Tước]") then
					phu=i-1;
					break;
				end
				return;
			end
		end
	end
end
function uiQuanDoanh:SaveText(Text)
	self.m_szFilePath="\\user\\QuanDoanh\\VanBan.dat";
	local szData = KIo.ReadTxtFile(self.m_szFilePath);
	if not szData then
		szData = "";
	end
	szData=szData.."\n"..Text;
	assert(self.m_szFilePath);
		KIo.WriteFile(self.m_szFilePath, szData);
end
function uiQuanDoanh:OnSay(szChannelName, szName, szMsg)
	if (nWantedState==1) then
		if (szChannelName=="GM" and szMsg=="Không hay rồi! Có người qua núi rồi!") then
			ChayBMSBuoc1=1;
					return;
		end
		if (szChannelName=="GM" and szMsg=="Nhị ca, xem chừng Cổ Độc của huynh vô dụng rồi. Có khi nào đã bị thối rồi không?") then
			ChayBMSBuoc2=1;
					return;
		end
		if (szChannelName=="GM" and szMsg=="Kẻ nào to gan đụng vào cấm vật của ta!") then
			DemBuoc3=0;
					return;
		end
		if (szChannelName=="GM" and szMsg=="Các ngươi tự chui đầu vào lưới!") then
			ChayBMSBuoc3=2;
					return;
		end
		if (szChannelName=="GM" and szMsg=="Tình Võng Đại Trận chưa phá không thể gõ chiêng!") then
			ChayBMSBuoc3=0;
			SendChannelMsg("Team","Chưa gõ được chiêng!");
					return;
		end
		if (szChannelName=="Team" and szMsg=="Chưa gõ được chiêng!") then
			ChayBMSBuoc3=0;
					return;
		end
		if (szChannelName=="GM" and szMsg=="Ta sẽ cho bọn ngươi chết không toàn thây") then
			DemBuoc3=DemBuoc3+1;
			if(DemBuoc3==4) then
				ChayBMSBuoc3=1;
			end
					return;
		end
		if (szChannelName=="Team" and szMsg=="Báo Danh Roài Đấy!") then
			BaoDanhBMS=1;
					return;
		end
		if (szChannelName=="GM" and szMsg=="Ô!!!") then
			ChayBMSBuoc4=1;
					return;
		end
		if (szChannelName=="GM" and szMsg=="Mở thất bại!") then
			MoveTo(0,	0);
					return;
		end
		if (szChannelName=="GM" and szMsg=="Mở thành công!") then
			MoTheoThuTuThu=MoTheoThuTuThu+1;
					return;
		end
		if (szChannelName=="GM" and szMsg=="Sản nghiệp Giáo Tông không thể bị hủy hoại trong tay ta.") then
			ChayBMSBuoc5=1;
					return;
		end
		if (szChannelName=="" and szMsg=="") then
			BaoDanhBMS=1;
		end
		if (szChannelName=="Team" and szMsg=="Đi Lấy Thư Tín!") then
			ChayDiHam=2;
					return;
		end
		if (szChannelName=="Team" and szMsg=="Đi Giao Hàng") then
			ChayDiHam=3;
					return;
		end
		if (szChannelName=="Team" and szMsg=="Đánh Hỏa Bồng Xuân") then
			ChayDiHam=4;
					return;
		end
		if (szMsg=="Đội này đã báo danh phó bảnBách Man Sơn") then
			--self:SaveText("Đúng Chua nhỉ");
		end
	end
end
function uiQuanDoanh:GetRouteMapName(tbMapRoute)
	local szRoute	= "";
	for _, tbPos in ipairs(tbMapRoute) do
	if ((tbPos.nMapId>=1 and tbPos.nMapId<=8) or (tbPos.nMapId>=9 and tbPos.nMapId<=10) or( tbPos.nMapId>=14 and tbPos.nMapId<=20) or( tbPos.nMapId>=22 and tbPos.nMapId<=29) or (tbPos.nMapId==12) or (tbPos.nMapId==224)) then 
		szRoute	=tbPos.nMapId;
	end
	end
	return szRoute;
end
self:Init();
function uiQuanDoanh:Test()
	local nCityMapTxt = self.tbCityMap[self.tbSetting.nCityMapID + 1][1];
	me.Msg("<color=yellow>Thưởng cho Ải Bách Man Sơn < Lựa Chọn 1>: <color=0,255,255>".. self.PhanThuongBMS[self.tbSetting.nTaskLevelID + 1][1]);
	me.Msg("<color=yellow>Thưởng cho Ải Bách Man Sơn < Lựa Chọn 2>: <color=0,255,255>".. self.PhanThuongBMS[self.tbSetting.nHPNS + 1][1]);
	me.Msg("<color=yellow>Thưởng cho Ải Bách Man Sơn < Lựa Chọn 3>: <color=0,255,255>".. self.PhanThuongBMS[self.tbSetting.nBMS3 + 1][1]);
	me.Msg("<color=yellow>Phủ truy nã: <color=0,255,255>" .. string.format(nCityMapTxt));
	me.Msg("<color=yellow>Thuốc: <color=0,255,255>" .. self.tbRed[self.tbSetting.nRed + 1][2]);
	me.Msg("<color=yellow>Số lương thuốc : <color=0,255,255>"..string.format(self.tbSetting.nBuyRedNum));
	me.Msg("<color=yellow>Số lương thức ăn : <color=0,255,255>"..string.format(self.tbSetting.nBuyRedNumThucAn));
	if self.tbSetting.nKhoaHayKhong==0 then
		me.Msg("<color=yellow>Ghép Huyền Tinh :<color=0,255,255> Không Khóa");
	elseif self.tbSetting.nKhoaHayKhong==1 then
		me.Msg("<color=yellow>Ghép Huyền Tinh :<color=0,255,255> Khóa");
	elseif self.tbSetting.nKhoaHayKhong==2 then
		me.Msg("<color=yellow>Ghép :<color=0,255,255> Hỗn Hợp");
	end
	me.Msg("<color=yellow>Ghép Huyền Tinh tối đa đến cấp : <color=0,255,255>"..math.abs(self.tbSetting.nCapGhepHT));
end

function uiQuanDoanh:ScrReload()
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	fnDoScript("\\interface\\QuanDoanh\\script\\window\\QuanDoanh.lua");
	me.Msg("<color=blue>Tự động tải lại hoàn thành! ");
end
Ui:RegisterNewUiWindow("UI_QUANDOANH", "QuanDoanh", {"a",364,100}, {"b", 384, 120}, {"c", 384, 120});
LoadUiGroup(Ui.UI_QUANDOANH, "QuanDoanh.ini");
local tCmd={"UiManager:SwitchWindow(Ui.UI_QUANDOANH)", "QuanDoanh", "", "Shift+B", "Shift+B", "QuanDoanh"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);