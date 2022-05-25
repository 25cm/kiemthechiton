Ui.UI_TOOLS		= "UI_TOOLS";
local uiTools			= Ui.tbWnd[Ui.UI_TOOLS] or {};	
uiTools.UIGROUP		= Ui.UI_TOOLS;
Ui.tbWnd[Ui.UI_TOOLS] = uiTools
-------------
uiTools.BUTTON_FUDAI_ONE	="BtnFuDai"
uiTools.BUTTON_FUDAI_TWO	="BtnFuDaiWX"
uiTools.BUTTON_READ			="BtnRead"
uiTools.BTN_AutoRou			="BtnAutoRou"
uiTools.BTN_BackTrack		="BtnBackTrack"	
uiTools.BTN_AutoFoodz		="BtnAutoFoodz"
--------Các Menu
uiTools.BTN_ThanhTool		="BtnThanhTool" 
uiTools.BTN_Map11x			="BtnMap11x"
uiTools.BTN_Map10x			="BtnMap10x" 
uiTools.BTN_Map9x			="BtnMap9x"
uiTools.BTN_Map8x			="BtnMap8x"
uiTools.BTN_Map7x			="BtnMap7x"
uiTools.BTN_Map6x			="BtnMap6x"
uiTools.BTN_Map5x			="BtnMap5x"
uiTools.BTN_Map4x			="BtnMap4x" 
uiTools.BTN_Map3x			="BtnMap3x"
uiTools.BTN_Map2x			="BtnMap2x"
uiTools.BTN_Map1x			="BtnMap1x"
------------------------------------------
uiTools.BTN_ThanhLong       = "BtnThanhLong"
uiTools.BTN_ThuKho          = "BtnThuKho"
uiTools.BTN_DaLuyenDaiSu 	= "DaLuyenDaiSu"
uiTools.BTN_TieuDaoCoc	  	= "BtnTieuDaoCoc"
uiTools.BTN_ThuongHoi      	= "BtnThuongHoi" 
uiTools.BTN_LienDauCao	  	= "BtnLienDauCao"
uiTools.BTN_TanLang      	= "BtnTanLang"
uiTools.BTN_LeQuan      	= "BtnLeQuan"
uiTools.BTN_VHC      		= "BtnVHC"
uiTools.BTN_TQC     		= "BtnTQC"
uiTools.BTN_XaPhu     		= "BtnXaPhu"
--------------------
local tbTimer 				= Ui.tbLogic.tbTimer;
local BTNSuperMapLink		= "BtnSuperMapLink"
local self					= uiTools;
local bAutoFoodz=0;
self.BtnAutoFoodzKbn		= 0;
self.BtnAutoRouKbn 			= 0;
self.BtnReadKbn 			= 0;
self.BtnAutoFDKbn 			= 0;
self.BtnAutoFDWXKbn 		= 0;

Ui:RegisterNewUiWindow("UI_TOOLS", "tools", {"a", 100, 32}, {"b", 255, 32}, {"c", 392, 32});

uiTools.tbAllModeResolution	= {
	["a"]	= { 100, 32 },
	["b"]	= { 255, 32 },
	["c"]	= { 392, 32 },
};

uiTools.Map11x =
{ 
	{" Mông Cổ Vương Đình "},
	{" Nguyệt Nha Tuyền "},
	{" Tàn Tích Cung A Phòng "},
	{" Lương Sơn Bạc "},
	{" Thần Nữ Phong "},
	{" Tàn Tích Dạ Lang "},
	{" Cổ Lãng Dữ "},
	{" Đào Hoa Nguyên "},
};
uiTools.Map10x =
{ 
	{" Mạc Bắc Thảo Nguyên "},
	{" Đôn Hoàng Cổ Thành "},
	{" Hoạt Tử Nhân Mộ "},
	{" Đại Vũ Đài "},
	{" Tam Hiệp Sạn Đạo "},
	{" Xi Vưu Động "},
	{" Tỏa Vân Uyên "},
	{" Phục Lưu Động "},
};
uiTools.Map9x =
{ 
	{" Sắc Lặc Xuyên "},
	{" Gia Du Quan "},
	{" Hoa Sơn "},
	{" Thục Cương Sơn "},
	{" Phong Đô Quỷ Thành "},
	{" Miêu Lĩnh "},
	{" Vũ Di Sơn "},
	{" Vũ Lăng Sơn "},
};
uiTools.Map8x =
{ 
	{" Long Môn Thạch Quật "},
	{" Hoàng Lăng Tây Hạ "},
	{" Hoàng Hạc Lâu "},
	{" Tiến Cúc Động "},
	{" Kiếm Môn Quan "},
	{" Thiên Long Tự "},
	{" Bang Nguyên Bí Động "},
};
uiTools.Map7x =
{ 
	{" Phong Lăng Độ "},
	{" Mê Cung Sa Mạc "},
	{" Kê Quán Động "},
	{" Thục Cương Sơn "},
	{" Kiếm Các Thục Đạo "},
	{" Hoàng Lăng Đoàn Thị "},
	{" Cửu Nghi Khê "},
};
uiTools.Map6x =
{ 
	{" Cư Diên Trạch "},
	{" Phục Ngưu Sơn "},
	{" Hổ Khâu Kiếm Tri "},
	{" Hưởng Thủy Động "},
	{" Điểm Thương Sơn "},
	{" Bành Lãi Cổ Trạch "},
};
uiTools.Map5x =
{ 
	{" Thái Hành Cổ Kính "},
	{" Đại Tán Quan "},
	{" Hán Thủy Cổ Độ "},
	{" Hàn Sơn Cổ Sát "},
	{" Cán Hoa Khê "},
	{" Nhĩ Hải Ma Nham "},
	{" Thái Thạch Cơ "},
};
uiTools.Map4x =
{ 
	{" Tây Tháp Lâm "},
	{" Hoàng Lăng Kim Quốc 2 "},
	{" Mê Cung Băng Huyệt 2 "},
	{" Tây Long Hổ Huyễn Cảnh "},
	{" Giữa Yến Tử Ổ "},
	{" Cửu Lão Động 2 "},
	{" Trong Bách Hoa Trận "},
	{" Tây Bờ Hồ Trúc Lâm "},
	{" Tây Rừng Nguyên Sinh "},
	{" Tây Bắc Lư Vĩ Đãng "},
};
uiTools.Map3x =
{ 
	{" Đông Tháp Lâm "},
	{" Hoàng Lăng Kim Quốc 1 "},
	{" Mê Cung Băng Huyệt 1 "},
	{" Đông Long Hổ Huyễn Cảnh "},
	{" Ngoài Yến Tử Ổ "},
	{" Cửu Lão Động 1 "},
	{" Ngoài Bách Hoa Trận "},
	{" Đông Bờ Hồ Trúc Lâm "},
	{" Đông Rừng Nguyên Sinh "},
	{" Đông Nam Lư Vĩ Đãng "},
};
uiTools.Map2x =
{ 
	{" Cấm Địa Hậu Sơn "},
	{" Cấm Địa Thiên Nhẫn "},
	{" Kiến Tính Phong "},
	{" Thiên Trụ Phong "},
	{" Cô Tô Thủy Tạ "},
	{" Cừu Lão Phong "},
	{" Bách Hoa Cốc "},
	{" Hồ Phỉ Thúy "},
	{" Bộ Lạc Nam Di "},
	{" Thanh Loa Đảo "},
};
uiTools.Map1x =
{ 
	{" Trấn Đông Mộ Viên "},
	{" Trà Mã Cổ Đạo "},
	{" Kỳ Liên Sơn "},
	{" Đồng Quan "},
	{" Hoài Thủy Sa Châu "},
	{" Thục Nam Trúc Hải "},
	{" Nhạc Dương Lâu "},
};

self.nRead=1;
self.nAutoRou=1;
self.nAutoFoodz=1;
self.nAutoFD=0;     
self.nAutoFDWX=1;  

self.Rtime1=0;
self.Rtime2=0;
self.nSec0=0;
self.nSec1=0;
self.nSec2=0;
self.nSec3=0;
self.nSec4=0;
self.nSec5=0;  
self.nSec6=0;
self.nYe1=0;
self.nYe2=0;
self.nYe3=0;
self.nYe4=0;
self.nYe5=0; 
self.nYe6=0; 
self.nRelayTime1 =60;
self.nRelayTime2 =600; 
self.nNum=0
self.X1=0;
self.Y1=0;
self.X2=0;
self.Y2=0;
self.TimeLost=0;
self.IsRead=0;
self.BookNum=0;
self.read_now=0;
self.Move_Time=0;

self.nTime = 5;
self.nRelayTime1 =60;
self.nRelayTime2 =600; 
self.nTimerId=0;
self.tbOptionSetting = {};

uiTools.OnOpen=function(self)
 	tbTimer:Register(Env.GAME_FPS*2, self.OnTimer, self);
	tbTimer:Register(Env.GAME_FPS, self.LoadSetting, self);
	local tbSetting=self:Load("OptionSetting");
	if not tbSetting then
		tbSetting = {};
	end
	if tbSetting.nRead then
		Btn_Check(self.UIGROUP, uiTools.BUTTON_READ, tbSetting.nBack);
	end
	if tbSetting.nAutoFD then
		Btn_Check(self.UIGROUP, uiTools.BUTTON_FUDAI_ONE, tbSetting.nBack);
	end
	if tbSetting.nAutoFDWX then
		Btn_Check(self.UIGROUP, uiTools.BUTTON_FUDAI_TWO, tbSetting.nBack);
	end
	if tbSetting.nAutoRou then
		Btn_Check(self.UIGROUP, uiTools.BTN_AutoRou, tbSetting.nBack);
	end
	if tbSetting.nAutoFoodz then
		Btn_Check(self.UIGROUP, uiTools.BTN_AutoFoodz, tbSetting.nBack);
	end
end

uiTools.LoadSetting=function(self)
	local tbFightSetting = self:Load("OptionSetting");
	if not tbFightSetting then
		tbFightSetting = {};
	end
	if tbFightSetting.nRead 	then			self.nRead 		= tbFightSetting.nRead;				end		
	if tbFightSetting.nAutoFD 	then			self.nAutoFD	= tbFightSetting.nAutoFD;			end  	
	if tbFightSetting.nAutoRou 	then			self.nAutoRou 	= tbFightSetting.nAutoRou;			end		
	if tbFightSetting.nAutoFDWX then			self.nAutoFDWX 	= tbFightSetting.nAutoFDWX;			end	
	if tbFightSetting.nAutoFoodz then			self.nAutoFoodz =tbFightSetting.nAutoFoodz;			end	
	if self.nRead then
		Btn_Check(self.UIGROUP, uiTools.BUTTON_READ, self.nRead);
	end
	if self.nAutoFD then
		Btn_Check(self.UIGROUP, uiTools.BUTTON_FUDAI_ONE, self.nAutoFD);
	end
	if self.nAutoFDWX then
		Btn_Check(self.UIGROUP, uiTools.BUTTON_FUDAI_TWO, self.nAutoFDWX);
	end
	if self.nAutoRou then
		Btn_Check(self.UIGROUP, uiTools.BTN_AutoRou, self.nAutoRou);
	end
	if self.nAutoFoodz then
		Btn_Check(self.UIGROUP, uiTools.BTN_AutoFoodz, self.nAutoFoodz);
	end

end

uiTools.SaveData=function(self)
	self.tbOptionSetting = {
		nRead= self.nRead,
		nAutoFD=self.nAutoFD,
		nAutoFDWX=self.nAutoFDWX,
		nAutoRou=self.nAutoRou,
		nAutoFoodz=self.nAutoFoodz,
		}
	self:Save("OptionSetting", self.tbOptionSetting);
end

uiTools.OnButtonClick_Bak = uiTools.OnButtonClick;

uiTools.OnButtonClick=function(self,szWnd, nParam)
	if (szWnd == self.BTN_Map11x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		8,
		0,
		self.Map11x[1][1],
		1,
		self.Map11x[2][1],
		2,
		self.Map11x[3][1],
		3,
		self.Map11x[4][1],
		4,
		self.Map11x[5][1],
		5,
		self.Map11x[6][1],
		6,
		self.Map11x[7][1],
		7,
		self.Map11x[8][1],
		8
		);		
	elseif (szWnd == self.BTN_Map10x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		8,
		0,
		self.Map10x[1][1],
		1,
		self.Map10x[2][1],
		2,
		self.Map10x[3][1],
		3,
		self.Map10x[4][1],
		4,
		self.Map10x[5][1],
		5,
		self.Map10x[6][1],
		6,
		self.Map10x[7][1],
		7,
		self.Map10x[8][1],
		8
		);	
    elseif (szWnd == self.BTN_Map9x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		8,
		0,
		self.Map9x[1][1],
		1,
		self.Map9x[2][1],
		2,
		self.Map9x[3][1],
		3,
		self.Map9x[4][1],
		4,
		self.Map9x[5][1],
		5,
		self.Map9x[6][1],
		6,
		self.Map9x[7][1],
		7,
		self.Map9x[8][1],
		8
		);
    elseif (szWnd == self.BTN_Map8x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.Map8x[1][1],
		1,
		self.Map8x[2][1],
		2,
		self.Map8x[3][1],
		3,
		self.Map8x[4][1],
		4,
		self.Map8x[5][1],
		5,
		self.Map8x[6][1],
		6,
		self.Map8x[7][1],
		7
		);
     elseif (szWnd == self.BTN_Map7x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.Map7x[1][1],
		1,
		self.Map7x[2][1],
		2,
		self.Map7x[3][1],
		3,
		self.Map7x[4][1],
		4,
		self.Map7x[5][1],
		5,
		self.Map7x[6][1],
		6,
		self.Map7x[7][1],
		7
		);
        elseif (szWnd == self.BTN_Map6x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		6,
		0,
		self.Map6x[1][1],
		1,
		self.Map6x[2][1],
		2,
		self.Map6x[3][1],
		3,
		self.Map6x[4][1],
		4,
		self.Map6x[5][1],
		5,
		self.Map6x[6][1],
		6
		);	
	elseif (szWnd == self.BTN_Map5x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.Map5x[1][1],
		1,
		self.Map5x[2][1],
		2,
		self.Map5x[3][1],
		3,
		self.Map5x[4][1],
		4,
		self.Map5x[5][1],
		5,
		self.Map5x[6][1],
		6,
		self.Map5x[7][1],
		7
		);
	elseif (szWnd == self.BTN_Map4x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		10,
		0,
		self.Map4x[1][1],
		1,
		self.Map4x[2][1],
		2,
		self.Map4x[3][1],
		3,
		self.Map4x[4][1],
		4,
		self.Map4x[5][1],
		5,
		self.Map4x[6][1],
		6,
		self.Map4x[7][1],
		7,
		self.Map4x[8][1],
		8,
		self.Map4x[9][1],
		9,
		self.Map4x[10][1],
		10
		);
	elseif (szWnd == self.BTN_Map3x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		10,
		0,
		self.Map3x[1][1],
		1,
		self.Map3x[2][1],
		2,
		self.Map3x[3][1],
		3,
		self.Map3x[4][1],
		4,
		self.Map3x[5][1],
		5,
		self.Map3x[6][1],
		6,
		self.Map3x[7][1],
		7,
		self.Map3x[8][1],
		8,
		self.Map3x[9][1],
		9,
		self.Map3x[10][1],
		10
		);
	elseif (szWnd == self.BTN_Map2x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		10,
		0,
		self.Map2x[1][1],
		1,
		self.Map2x[2][1],
		2,
		self.Map2x[3][1],
		3,
		self.Map2x[4][1],
		4,
		self.Map2x[5][1],
		5,
		self.Map2x[6][1],
		6,
		self.Map2x[7][1],
		7,
		self.Map2x[8][1],
		8,
		self.Map2x[9][1],
		9,
		self.Map2x[10][1],
		10
		);
	elseif (szWnd == self.BTN_Map1x) then
		DisplayPopupMenu(
		self.UIGROUP,
		szWnd,
		7,
		0,
		self.Map1x[1][1],
		1,
		self.Map1x[2][1],
		2,
		self.Map1x[3][1],
		3,
		self.Map1x[4][1],
		4,
		self.Map1x[5][1],
		5,
		self.Map1x[6][1],
		6,
		self.Map1x[7][1],
		7
		);

	elseif szWnd == BTNSuperMapLink then
		UiManager:SwitchWindow(Ui.UI_SUPERMAPLINK_UI)
 	elseif (szWnd == self.BTN_BackTrack) then
        AutoAi:SwitchBackTrack()
		---------------New------------------
	elseif (szWnd == self.BTN_ThanhLong) then	
		Map.tbSuperMapLink:ThanhLong();
	elseif (szWnd == self.BTN_ThuKho) then
		Map.tbSuperMapLink:ThuKho();	
	elseif (szWnd == self.BTN_DaLuyenDaiSu) then
		Map.tbSuperMapLink:DaLuyenDaiSu();
	elseif (szWnd == self.BTN_TieuDaoCoc) then
		Map.tbSuperMapLink:TieuDaoCoc();
	elseif (szWnd == self.BTN_ThuongHoi) then
		Map.tbSuperMapLink:ThuongHoi();
	elseif (szWnd == self.BTN_LienDauCao) then
		Map.tbSuperMapLink:LienDauCao();
	elseif (szWnd == self.BTN_TanLang) then
		Map.tbSuperMapLink:TanLang();
	elseif (szWnd == self.BTN_LeQuan) then
		Map.tbSuperMapLink:LeQuan();
	elseif (szWnd == self.BTN_VHC) then
		Map.tbSuperMapLink:VHC();
	elseif (szWnd == self.BTN_TQC) then
		Map.tbSuperMapLink:TQC();
	elseif (szWnd == self.BTN_XaPhu) then
		Map.tbSuperMapLink:XaPhu();
	elseif (szWnd == self.BTN_ThanhTool) then
		UiManager:SwitchWindow(Ui.UI_TOOL);
-----------------------------------------------------------
elseif (szWnd == self.BTN_AutoFoodz) then		   
		if self.BtnAutoFoodzKbn == 0 then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Tự động ăn thức ăn<color>");
			self.BtnAutoFoodzKbn = 1;
		else
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Ngừng tự động ăn thức ăn<color>");
			self.BtnAutoFoodzKbn = 0;
		end
		self.nAutoFoodz=nParam
		self:SaveData()
	elseif (szWnd == self.BTN_AutoRou) then
		if self.BtnAutoRouKbn == 0 then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Tự động ăn thịt và Tinh hoạt khí<color>");
			self.BtnAutoRouKbn = 1;
		else
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tắt tự động ăn thịt và Tinh hoạt khí<color>");
			self.BtnAutoRouKbn = 0;
		end
		self.nAutoRou=nParam
		self:SaveData()
	elseif (szWnd == self.BUTTON_FUDAI_ONE) then		
		if (self.BtnAutoFDKbn == 0 and self.BtnAutoFDWXKbn == 0) or (self.BtnAutoFDKbn == 0 and self.BtnAutoFDWXKbn == 1) then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Tự động mở túi phúc giới hạn<color>");
			self.BtnAutoFDKbn = 1;
			self.BtnAutoFDWXKbn = 0;
		elseif (self.BtnAutoFDKbn == 1 and self.BtnAutoFDWXKbn == 1) or (self.BtnAutoFDKbn == 1 and self.BtnAutoFDWXKbn == 0) then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tắt tự động mở túi phúc giới hạn<color>");
			self.BtnAutoFDKbn = 0;
			self.BtnAutoFDWXKbn = 0;
		end
		self.nAutoFD=nParam
		self.nAutoFDWX=0
		self:SaveData()
		if nParam==1 then
			Btn_Check(self.UIGROUP, self.BUTTON_FUDAI_TWO,self.nAutoFDWX,0);
		end
	elseif (szWnd == self.BUTTON_FUDAI_TWO) then		
		if (self.BtnAutoFDWXKbn == 0 and self.BtnAutoFDKbn == 0) or (self.BtnAutoFDWXKbn == 0 and self.BtnAutoFDKbn == 1) then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Tự động mở túi phúc không giới hạn<color>");
			self.BtnAutoFDWXKbn = 1;
			self.BtnAutoFDKbn = 0;
		elseif (self.BtnAutoFDWXKbn == 1 and self.BtnAutoFDKbn == 1) or (self.BtnAutoFDWXKbn == 1 and self.BtnAutoFDKbn == 0) then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tắt tự động mở túi phúc không giới hạn<color>");
			self.BtnAutoFDWXKbn = 0;
			self.BtnAutoFDKbn = 0;
		end
		self.nAutoFDWX=nParam
		self.nAutoFD=0
		self:SaveData()
		if nParam==1 then
			Btn_Check(self.UIGROUP, self.BUTTON_FUDAI_ONE,0);
		end
	elseif (szWnd == self.BUTTON_READ) then		
		if self.BtnReadKbn == 0 then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Tự động Đọc sách<color>");
			self.BtnReadKbn = 1;
		else
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tắt tự động Đọc sách<color>");
			self.BtnReadKbn = 0;
		end
		self.nRead=nParam
		self:SaveData()
	end
end

uiTools.OnMenuItemSelected=function(self,szWnd, nItemId, nParam)
	if szWnd == self.BTN_Map11x then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",130,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",131,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",132,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",133,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",134,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",135,0,"});	
			elseif nItemId==7 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",136,0,"});	              
			elseif nItemId==8 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",137,0,"});	         
		   	end
	 end  
	if szWnd == self.BTN_Map10x then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",122,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",123,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",124,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",125,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",126,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",127,0,"});	
			elseif nItemId==7 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",128,0,"});	              
			elseif nItemId==8 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",129,0,"});	         
		   	end
	 end 
    if szWnd == self.BTN_Map9x then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",114,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",115,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",116,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",117,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",118,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",119,0,"});	
			elseif nItemId==7 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",120,0,"});	              
			elseif nItemId==8 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",121,0,"});	         
		   	end
	 end
	if szWnd == self.BTN_Map8x then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",107,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",108,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",109,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",110,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",111,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",112,0,"});	
			elseif nItemId==7 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",113,0,"});	              
			end
	 end 
	 if szWnd == self.BTN_Map7x then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",100,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",101,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",102,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",103,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",104,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",105,0,"});	
			elseif nItemId==7 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",106,0,"});	              
			end
	 end 
	 if szWnd == self.BTN_Map6x then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",94,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",95,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",96,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",97,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",98,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",99,0,"});	
		    end
	 end 
	 if szWnd == self.BTN_Map5x then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",86,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",87,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",88,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",89,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",90,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",91,0,"});	
			elseif nItemId==7 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",92,0,"});	              
			end
	 end 
	 if szWnd == self.BTN_Map4x then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",66,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",67,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",68,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",69,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",70,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",71,0,"});	
			elseif nItemId==7 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",72,0,"});
			elseif nItemId==8 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",73,0,"});	
			elseif nItemId==9 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",74,0,"});	
			elseif nItemId==10 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",75,0,"});	
			end
	 end
	 if szWnd == self.BTN_Map3x then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",56,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",57,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",58,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",59,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",60,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",61,0,"});	
			elseif nItemId==7 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",62,0,"});
			elseif nItemId==8 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",63,0,"});	
			elseif nItemId==9 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",64,0,"});	
			elseif nItemId==10 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",65,0,"});	
			end
	 end
	 if szWnd == self.BTN_Map2x then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",46,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",47,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",48,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",49,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",50,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",51,0,"});	
			elseif nItemId==7 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",52,0,"});
			elseif nItemId==8 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",53,0,"});	
			elseif nItemId==9 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",54,0,"});	
			elseif nItemId==10 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",55,0,"});	
			end
	 end
	 if szWnd == self.BTN_Map1x then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",38,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",43,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",39,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",40,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",41,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",42,0,"});	
			elseif nItemId==7 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",45,0,"});
		end
	 end
	 if szWnd == self.BTN_Map5 then
			if nItemId==1 then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",30,0,"});
			elseif nItemId==2 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",31,0,"});	
			elseif nItemId==3 then
       	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",32,0,"});		
			elseif nItemId==4 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",33,0,"});	  
			elseif nItemId==5 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",34,0,"});	
			elseif nItemId==6 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",35,0,"});	
			elseif nItemId==7 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",36,0,"});
			elseif nItemId==8 then
        Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",37,0,"});	
			end
	 end
end

uiTools.CheckErrorData=function(self,szDate)
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

uiTools.Save=function(self,szKey, tbData)
	self.m_szFilePath="\\user\\tools\\"..me.szName..".dat";
	self.m_tbData[szKey] = tbData;
	local szData = Lib:Val2Str(self.m_tbData);
	assert(self.m_szFilePath);
	if self:CheckErrorData(szData) == 1 then
		KIo.WriteFile(self.m_szFilePath, szData);
	else
		local szSaveData = Lib:Val2Str(tbData);
	end
end

uiTools.Load=function(self,key)
	self.m_szFilePath="\\user\\tools\\"..me.szName..".dat";
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

uiTools.Reading=function(self)
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	self:BookInfo();
	local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
	self.nSec0 = Lib:GetDate2Time(nDate);
	if self.nSec0 > self.nSec1 and self.nYe1<10 then
		self:Read_book_szbf();
	end
	if self.nSec0 > self.nSec2 and self.nYe2<10 then
		self:Read_book_mjjgs();
	end
	if self.nSec0 > self.nSec3 and self.nYe3<10 then
		self:Read_book_wmys();
	end
	if self.nSec0 > self.nSec4 and self.nYe4<10 then
		self:Read_book_ggds();
	end
	if self.nSec0 > self.nSec5 and self.nYe5<10 then
		self:Read_book_bfsslj();
	end
	if self.nSec0 > self.nSec6 and self.nYe6<10 then
		self:Read_book_qym();
	end
end

 uiTools.Read_book_szbf=function(self)
	if (me.nLevel >= 90) then
		local nBingShuCount = Task.tbArmyCampInstancingManager:GetBingShuReadTimesThisDay(me.nId);
		if (nBingShuCount >= 1) then
			return 1;
		else
			local tbFind = me.FindItemInBags(20,1,298,1);
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
				--me.Msg("<color=green>Đang đọc <color=yellow>Tôn Tử Binh Pháp<color>...");
				UiManager:OpenWindow("UI_INFOBOARD", "<color=yellow>Đang đọc <color><bclr=red><color=yellow> Tôn Tử Binh Pháp<color><bclr>");
			end
		end
	end
end

 uiTools.Read_book_mjjgs=function(self)
	if (me.nLevel >= 90) then
		local nJiGuanShuCount = Task.tbArmyCampInstancingManager:JiGuanShuReadedTimesThisDay(me.nId);
		if (nJiGuanShuCount >= 1) then
			return 1;
		else
			local tbFind = me.FindItemInBags(20,1,299,1);
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
				--me.Msg("<color=green>Đang đọc <color><color=yellow>Mặc Gia Cơ Quan Thuật<color>...");
				UiManager:OpenWindow("UI_INFOBOARD", "<color=yellow>Đang đọc <color><bclr=red><color=yellow> Mặc Gia Cơ Quan Thuật<color><bclr>");
			end
		end
	end
end

 uiTools.Read_book_ggds=function(self)
	if (me.nLevel >= 110) then
		local tbFind = me.FindItemInBags(20,1,545,1);
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			--me.Msg("<color=green>Đang đọc <color><color=yellow>Quỷ Cốc Đạo Thuật<color>...");
			UiManager:OpenWindow("UI_INFOBOARD", "<color=yellow>Đang đọc <color><bclr=red><color=yellow> Quỷ Cốc Đạo Thuật<color><bclr>");
		end
	end
end
 uiTools.Read_book_wmys=function(self)
	if (me.nLevel >= 110) then
		local tbFind = me.FindItemInBags(20,1,544,1);
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			--me.Msg("<color=green>Đang đọc <color><color=yellow> Võ Mục Di Thư<color>...");
			UiManager:OpenWindow("UI_INFOBOARD", "<color=yellow>Đang đọc <color><bclr=red><color=yellow> Võ Mục Di Thư<color><bclr>");
		end
	end
end

--#STC Doc sach 130 (Start)
uiTools.Read_book_bfsslj=function(self)
	if (me.nLevel >= 130) then
		local tbFind = me.FindItemInBags(20,1,809,1);
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			self.BookNum=5;
			Timer:Register(Env.GAME_FPS * 6, self.OutReadAi, self);
			UiManager:OpenWindow("UI_INFOBOARD", "<color=yellow>Đang đọc <color><bclr=red><color=yellow>Sach 130 (809)<color><bclr>");
		end
	end
end

uiTools.Read_book_qym=function(self)
	if (me.nLevel >= 130) then
		local tbFind = me.FindItemInBags(20,1,810,1);
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			self.BookNum=6;
			Timer:Register(Env.GAME_FPS * 6, self.OutReadAi, self);
			UiManager:OpenWindow("UI_INFOBOARD", "<color=yellow>Đang đọc <color><bclr=red><color=yellow>Khuyết Nhất Môn<color><bclr>");
		end
	end
end

--#STC Doc sach 130 (End)
 uiTools.BookInfo=function(self)
	local tbFind = me.FindItemInBags(20,1,298,1);
	for j, tbItem in pairs(tbFind) do
		self.nYe1=tbItem.pItem.GetGenInfo(1);
		local nYear =tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec1 = Lib:GetDate2Time(nCanDate) + self.nRelayTime1;
		end
	end

	local tbFind = me.FindItemInBags(20,1,299,1);
	for j, tbItem in pairs(tbFind) do
		self.nYe2=tbItem.pItem.GetGenInfo(1);
		local nYear =tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec2 = Lib:GetDate2Time(nCanDate) + self.nRelayTime2;
		end
	end

	local tbFind = me.FindItemInBags(20,1,544,1);
	for j, tbItem in pairs(tbFind) do
		self.nYe3=tbItem.pItem.GetGenInfo(1);
		local nYear =tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec3 = Lib:GetDate2Time(nCanDate) + self.nRelayTime1;
		end
	end

	local tbFind = me.FindItemInBags(20,1,545,1);
	for j, tbItem in pairs(tbFind) do
		self.nYe4=tbItem.pItem.GetGenInfo(1);
		local nYear =tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec4 = Lib:GetDate2Time(nCanDate) + self.nRelayTime2;
		end
	end

--#STC: Doc sach level 130+ (Checking hoahongnet's codes)
	local tbFind = me.FindItemInBags(20,1,809,1);
	for j, tbItem in pairs(tbFind) do
		self.nYe5=tbItem.pItem.GetGenInfo(1);
		local nYear =tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec5 = Lib:GetDate2Time(nCanDate) + self.nRelayTime2;
		end
	end

	local tbFind = me.FindItemInBags(20,1,810,1);
	for j, tbItem in pairs(tbFind) do
		self.nYe6=tbItem.pItem.GetGenInfo(1);
		local nYear =tbItem.pItem.GetGenInfo(2);
		local nTime = tbItem.pItem.GetGenInfo(3);
		if nYear > 0 then
			local nDate = tonumber(GetLocalDate("%Y%m%d%H%M%S"));
			local nCanDate = (nYear* 1000000 + nTime);
			self.nSec6 = Lib:GetDate2Time(nCanDate) + self.nRelayTime2;
		end
	end
--#STC: Doc sach level 130+ (End of Checking hoahongnet's codes)
end
uiTools.Use_LuckBag=function(self)
	local nFuCount = me.GetTask(2013, 1); 
	local nFuDate = me.GetTask(2013, 2); 
	local nFuLimit = me.GetTask(2013, 3); 
	local nDay = tonumber(os.date("%y%m%d", nNowDate));
	if (nFuDate < nDay) then
			nFuCount = 0;
	end
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
  		return
  	end	
	if (self.nAutoFD==1 and self.nAutoFDWX~=1) then
		if (nFuCount < nFuLimit) then
			local tbFind = me.FindItemInBags(18,1,80,1);--Túi Phúc Hoàng Kim
			for j, tbItem in pairs(tbFind) do
				me.UseItem(tbItem.pItem);
			end
		end
	elseif (self.nAutoFDWX==1 and self.nAutoFD ~=1) then
		local tbFind = me.FindItemInBags(18,1,80,1);--Túi Phúc Hoàng Kim
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
				if (nFuCount == nFuLimit) then
				if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
						me.AnswerQestion(0);
						UiManager:CloseWindow(Ui.UI_SAYPANEL);
					return 0;
				end
				-- Ui.tbLogic.tbTimer:Register(18, fnCloseSay);
				end
			return 1;
		end
	end
	local tbFind = me.FindItemInBags(18,1,193,1);--Túi quân hưởng (cấp 90)
	for j, tbItem in pairs(tbFind) do
		me.UseItem(tbItem.pItem);
	end
	local tbFind = me.FindItemInBags(18,1,285,1);--Túi quân hưởng (cấp 110)
	for j, tbItem in pairs(tbFind) do
		me.UseItem(tbItem.pItem);
	end
	local tbFind = me.FindItemInBags(18,1,336,1);--Túi quân hưởng (cấp 130)
	for j, tbItem in pairs(tbFind) do
		me.UseItem(tbItem.pItem);
	end
	
 if self.BtnAutoRouKbn == 1 then
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
  		return
  	end	
	local tbFind = me.FindItemInBags(20,1,488,1);--Thịt bò chín
	for j, tbItem in pairs(tbFind) do
		me.UseItem(tbItem.pItem);
		return 0;
	end
	local tbFind = me.FindItemInBags(20,1,488,2);--Chim cút quay
	for j, tbItem in pairs(tbFind) do
		me.UseItem(tbItem.pItem);
		return 0;
		end
	
	local tbFind = me.FindItemInBags(18,1,89,1);--Tinh Khí Tán (500)
	for j, tbItem in pairs(tbFind) do
		me.UseItem(tbItem.pItem);
		end
  
	local tbFind = me.FindItemInBags(18,1,90,1);--Hoạt Khí Tán (500)
	for j, tbItem in pairs(tbFind) do
		me.UseItem(tbItem.pItem);
		end
  	end
	if self.BtnAutoFoodzKbn == 1 then
	uiTools.AutoFoodz();
  end
end

uiTools.AutoFoodz=function(self)
	if(not bAutoFoodz) then
		return;
	end
	
	local nLevel, nState, nTime = me.GetSkillState(AutoAi.FOOD_SKILL_ID);
	if (not nTime or nTime < Env.GAME_FPS * 3)  then
		uiTools.EatFoodz();
	end	
end

uiTools.EatFoodz=function(self)
	local tbItemList = me.FindItemInBags(Item.SKILLITEM);
	if((not tbItemList) or (#tbItemList == 0)) then
		return false;
	end
	local pItem = tbItemList[1].pItem;
	if(me.CanUseItem(pItem)) then
		me.Msg("Sử dụng thức ăn <color=yellow>" .. pItem.szName .. "<color>");
		return me.UseItem(pItem);
	end
	return false;
end

uiTools.OnTimer=function(self)
	self:Use_LuckBag();
	if self.nRead==1 then
		local nLinhKien = 0;
		for i = 1, 10 do
 		local nSotay = me.GetTask(2044, i);
	  		nLinhKien = nLinhKien + nSotay;
		end
		if self.nRead==1 and nLinhKien < 10 then
			local tbFind = me.FindItemInBags(20,1,484,1);
			for j, tbItem in pairs(tbFind) do
 	  			me.UseItem(tbItem.pItem);
 	    			return 1;
			end
		end
		if me.nFightState==0 then
			self.Rtime1=self.Rtime1+1;
			if math.mod(self.Rtime1,20)==0 then
				self.Rtime1=0;
				self:Reading();
			end
		end
	end
	if self.nAutoRou==1 and self.BtnAutoRouKbn == 0 then 
	  self.BtnAutoRouKbn = 1;
	end
	if self.nRead==1 and self.BtnReadKbn == 0 then 
	  self.BtnReadKbn = 1;
	end
	if self.nAutoFD==1 and self.BtnAutoFDKbn == 0 then 
	  self.BtnAutoFDKbn = 1;
	end
	if self.nAutoFDWX==1 and self.BtnAutoFDWXKbn == 0 then 
	  self.BtnAutoFDWXKbn = 1;
	end
	if self.nAutoFoodz==1 and self.BtnAutoFoodzKbn == 0 then 
	  self.BtnAutoFoodzKbn = 1;
	end
	end
-------------------------------- tự mở rương MĐT , HGP , NHT
local uiTextInput = Ui(Ui.UI_TEXTINPUT);
local nTimerId = 0;
local nMoDaoTimerId = 0;
local nLastOpenTime = 0;
local nWaitTime = 5; 

function AutoAi:SwitchMoRuongThuoc()
	if nMoDaoTimerId == 0 then
		--me.Msg("<color=yellow>Bắt đầu tự mở rương thuốc<color>");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Bắt đầu tự mở rương thuốc [Alt+Shift+2]<color>");
		nMoDaoTimerId	= Ui.tbLogic.tbTimer:Register(36, AutoAi.MoRuongThuoc, AutoAi);
	else 
		AutoAi:StopMoRuongThuoc(); 
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=white>Tắt tự mở rương thuốc [Alt+Shift+2]<color>");
	end
end

local tCmd={ "AutoAi:SwitchMoRuongThuoc()", "SwitchMoRuongThuoc", "", "Alt+Shift+2", "Alt+Shift+2", "SwitchMoRuongThuoc" };
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	--：Alt+Shift+2

function AutoAi:MoRuongThuoc()
	if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1) or (UiManager:WindowVisible(Ui.UI_TEXTINPUT) == 1) then		
		return; 
	end
				local tbFind = me.FindItemInBags(18,1,72,1)[1] 	or me.FindItemInBags(18,1,73,1)[1] 	or me.FindItemInBags(18,1,74,1)[1]
							or me.FindItemInBags(18,1,72,2)[1]  or me.FindItemInBags(18,1,73,2)[1]  or me.FindItemInBags(18,1,74,2)[1]
							or me.FindItemInBags(18,1,72,3)[1]  or me.FindItemInBags(18,1,73,3)[1]  or me.FindItemInBags(18,1,74,3)[1]
							or me.FindItemInBags(18,1,72,4)[1]  or me.FindItemInBags(18,1,73,4)[1]  or me.FindItemInBags(18,1,74,4)[1]
							or me.FindItemInBags(18,1,72,5)[1]  or me.FindItemInBags(18,1,73,5)[1]  or me.FindItemInBags(18,1,74,5)[1]
							or me.FindItemInBags(18,1,72,6)[1]  or me.FindItemInBags(18,1,73,6)[1]  or me.FindItemInBags(18,1,74,6)[1]
							or me.FindItemInBags(18,1,72,7)[1]  or me.FindItemInBags(18,1,73,7)[1]  or me.FindItemInBags(18,1,74,7)[1]
							or me.FindItemInBags(18,1,72,8)[1]  or me.FindItemInBags(18,1,73,8)[1]  or me.FindItemInBags(18,1,74,8)[1]
							or me.FindItemInBags(18,1,72,9)[1]  or me.FindItemInBags(18,1,73,9)[1]  or me.FindItemInBags(18,1,74,9)[1]
							or me.FindItemInBags(18,1,72,10)[1] or me.FindItemInBags(18,1,73,10)[1] or me.FindItemInBags(18,1,74,10)[1];	
	if not tbFind then
		AutoAi:StopMoRuongThuoc();
	else
		local pItem  = tbFind.pItem;
		local g		 = pItem.nGenre;
		local d		 = pItem.nDetail;
		local p		 = pItem.nParticular;
		local l		 = pItem.nLevel;
		AutoAi:StartMoRuongThuoc(g,d,p,l,10);
	end
end

function AutoAi:StartMoRuongThuoc(g,d,p,l,n)
	if nTimerId == 0 then
		me.Msg("Bắt đầu mở ...");
		nTimerId	= Ui.tbLogic.tbTimer:Register(18, AutoAi.MoRuong, AutoAi, g, d, p, l, n);
	end
end

function AutoAi:StopMoRuongThuoc()
	if nMoDaoTimerId > 0 then
		--me.Msg("<color=yellow>Tắt tự mở rương thuốc<color>");
		Ui.tbLogic.tbTimer:Close(nMoDaoTimerId);
		nMoDaoTimerId = 0;
	end
end

function AutoAi:MoRuong(g,d,p,l,n)
	local nCurTime = GetTime();
	local nDiff = nCurTime - nLastOpenTime;
	if (UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1) then		
		return; 
	end
	if UiManager:WindowVisible(Ui.UI_TEXTINPUT) == 1 then
		me.CallServerScript({ "DlgCmd", "InputNum", n });
		UiManager:CloseWindow(Ui.UI_TEXTINPUT);
	end
	if nLastOpenTime > 0 and nDiff < nWaitTime then
		return; 
	end
	if nLastOpenTime > 0 and nDiff >= nWaitTime then			
		AutoAi:DungMoRuong(); 
		nLastOpenTime = 0;
		return;
	end
	local tbItem = me.FindItemInBags(g,d,p,l)[1];
	if tbItem then
		me.UseItem(tbItem.pItem);
		nLastOpenTime = nCurTime;
		me.AnswerQestion(0);
		Ui.tbLogic.tbTimer:Register(18, AutoAi.CloseSay);
	end
end

function AutoAi:DungMoRuong()
	if nTimerId > 0 then
		me.Msg("Mở hôp cuối ...");
		Ui.tbLogic.tbTimer:Close(nTimerId);
		nTimerId = 0;
	end
end
--------------------------mở rương thuốc TDC 
function AutoAi:MoRuongThuocTDC()
	local nPlanNum = 48; 
	local nFreeNum = 12; 
	local nCountFree = me.CountFreeBagCell(); 
	if (nPlanNum + nFreeNum) > nCountFree then
		nPlanNum = nCountFree - nFreeNum; 
	end	
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=yellow>Bật Mở rương thuốc Tiêu Dao Cốc [Ctrl+Shift+2]<color>");
				local tbFind = me.FindItemInBags(18,1,352,1)[1] or me.FindItemInBags(18,1,352,2)[1] or me.FindItemInBags(18,1,352,3)[1]
							or me.FindItemInBags(18,1,354,1)[1] or me.FindItemInBags(18,1,354,2)[1] or me.FindItemInBags(18,1,354,3)[1]
							or me.FindItemInBags(18,1,353,1)[1] or me.FindItemInBags(18,1,353,2)[1] or me.FindItemInBags(18,1,353,3)[1];
	if not tbFind then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=White>Hành trang không có rương thuốc Tiêu Dao Cốc<color>");
	else
		local pItem = tbFind.pItem;
		local g = pItem.nGenre;
		local d = pItem.nDetail;
		local p = pItem.nParticular;
		local l = pItem.nLevel;
		AutoAi:StartMoRuongThuoc(g,d,p,l,nPlanNum);
	end
end

local tCmd={ "AutoAi:MoRuongThuocTDC()", "MoRuongThuocTDC", "", "Ctrl+Shift+2", "Ctrl+Shift+2", "MoRuongThuocTDC" };
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	--：Ctrl+Shift+2
	
function AutoAi:CloseSay()
	if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		UiManager:CloseWindow(Ui.UI_SAYPANEL);
	end
	return 0;
end
-------------------------------
-------------------------------
