
local tbSprBao_Setting			     = Ui:GetClass("SprBao_setting");
local tbSaveData 			= Ui.tbLogic.tbSaveData;
local EDIT_CONTENT_SAFE 	= "EdtRemote";
local szMsgAutoRemote = 0;
tbSprBao_Setting.BTN_CheckSkill		= "BtnCheckSkill"; 
tbSprBao_Setting.BTN_CLOSE		    = "BtnClose";
tbSprBao_Setting.BTN_SAVE         = "BtnSave"; -- 
tbSprBao_Setting.BTN_EXIT         = "BtnExit"; -- 
tbSprBao_Setting.BTN_FIRE		= "BtnFire";
tbSprBao_Setting.BTN_AUTOTASK		= "BtnAutoTask";  --
tbSprBao_Setting.BTN_GuaJi			= "BtnGuaJi"       --
tbSprBao_Setting.BTN_GETPOS			= "BtnGetPos"      --
tbSprBao_Setting.BTN_AWARDFIRST		= "BtnAwardFirst"  --
tbSprBao_Setting.BTN_AWARDSECOND		= "BtnAwardSecond"  --
tbSprBao_Setting.BTN_AWARDTHIRD		= "BtnAwardThird"  --
tbSprBao_Setting.BTN_STARTBAO		= "BtnStartBao"    --ִ
tbSprBao_Setting.BTN_OUTPOS			= "BtnOutPos"      --
tbSprBao_Setting.BTN_ChetQuayLai		= "BtnChetQuayLai"; 
tbSprBao_Setting.BTN_RAC		= "BtnRac";       
tbSprBao_Setting.BTN_Horse		= "BtnHorse";
tbSprBao_Setting.BTN_BACEXIT		= "BtnBacexit";
-----------
tbSprBao_Setting.EDT_HOUR		= "EdtHour";			--
tbSprBao_Setting.EDT_MINUTE		= "EdtMinute";		--
tbSprBao_Setting.EDT_SECOND		= "EdtSecond"		--
tbSprBao_Setting.EDT_LVHT	= "EdtLvHT";
tbSprBao_Setting.EDT_GHEPHT	= "EdtGhepHT";
tbSprBao_Setting.EDT_KPTP	= "EdtKptp";
tbSprBao_Setting.EDT_MONEY	= "EdtMoney";
tbSprBao_Setting.EDT_GHEPHT2	= "EdtGhepHT2";
tbSprBao_Setting.EDT_GHEPHT3	= "EdtGhepHT3";
tbSprBao_Setting.EDT_FULLBAG	= "EdtFullbag";
tbSprBao_Setting.EDT_BAC	= "EdtBac";
----------
tbSprBao_Setting.SCROLL_CANCEL	 	 = "ScrbarCancel";
tbSprBao_Setting.SCROLL_MAXCOUNT	 	 = "ScrbarMaxCount";      --
tbSprBao_Setting.SCROLL_XUANMIX	  = "ScrbarXuanMix";
tbSprBao_Setting.SCROLL_BIND	  = "ScrbarBind";
tbSprBao_Setting.SCROLL_EXP	  = "ScrbarExp";
tbSprBao_Setting.SCROLL_HP	 	 = "ScrbarHp";      --
tbSprBao_Setting.SCROLL_MP	  = "ScrbarMp"; 	  -- 
tbSprBao_Setting.SCROLL_FOOD	  = "ScrbarFood"; 	  --
tbSprBao_Setting.SCROLL_HTP	  = "ScrbarHtp"; 	  -- 
tbSprBao_Setting.SCROLL_ITEM	 	 = "ScrbarItem";      --
tbSprBao_Setting.SCROLL_EQUIP	  = "ScrbarEquip"; 	  -- 
tbSprBao_Setting.SCROLL_WUMAX	  = "ScrbarWuMax"; 	  -- 
tbSprBao_Setting.SCROLL_SHOUMAX	  = "ScrbarShouMax"; 	  --
----------
tbSprBao_Setting.TXT_CANCEL      = "TxtCancel";
tbSprBao_Setting.TXT_NAME      = "TxtName";
tbSprBao_Setting.TXT_MAXCOUNT      = "TxtMaxCount";    --
tbSprBao_Setting.TXT_HP				  = "TxtHP";    --
tbSprBao_Setting.TXT_MP				  = "TxtMP";    --
tbSprBao_Setting.TXT_FOOD				  = "TxtFOOD";    --
tbSprBao_Setting.TXT_HTP				  = "TxtHTP";    --
tbSprBao_Setting.TXT_MAXCOUNT      = "TxtMaxCount";    --
tbSprBao_Setting.TXT_EQUIP				  = "TxtEquip";    --
tbSprBao_Setting.TXT_WUMAX				  = "TxtWuMax";    --
tbSprBao_Setting.TXT_SHOUMAX				  = "TxtShouMax";    --
tbSprBao_Setting.TXT_XUANMIX				  = "TxtXuanMix";
tbSprBao_Setting.TXT_BIND				  = "TxtBind"; 
tbSprBao_Setting.TXT_EXP				  = "TxtExp";   
tbSprBao_Setting.BTN_EXITGAME			= "BtnExitGame"
tbSprBao_Setting.BTN_VAGT         = "BtnVAGT"; -- 
tbSprBao_Setting.TXT_GhepHT2				  = "TxtGhepHT2";
----------
tbSprBao_Setting.TXT_ITEM				  = "TxtItem";    --
tbSprBao_Setting.TXT_OUTPOS		= "TxtOutPos"    --
tbSprBao_Setting.TXT_MAP		= "TxtMap"    --
tbSprBao_Setting.TXT_GUAJIPOS		= "TxtGuaJiPos"    --
tbSprBao_Setting.BTN_CITY		= "BtnCity"
tbSprBao_Setting.BTN_HPLV		= "BtnHPLv"  
tbSprBao_Setting.BTN_MPLV		= "BtnMPLv"
tbSprBao_Setting.BTN_XY		= "BtnXy"

tbSprBao_Setting.BTN_MAPTRAIN		= "BtnMapTrain"
tbSprBao_Setting.BTN_SETMAPTRAIN		= "BtnSetMapTrain"; 
tbSprBao_Setting.BTN_SETSKILL		= "BtnSetskill"

tbSprBao_Setting.DATA_KEY			= "SprBao";
tbSprBao_Setting.tbSetting		= {};


local self = tbSprBao_Setting;

local tbAwardMenu = {"Tiền","Hủy","Huyền Tinh","Kinh Nghiệm"}
local tbCity = {"Biện Kinh Phủ","Phượng Tường Phủ","Tương Dương Phủ","Dương Châu Phủ","Thành Đô Phủ","Đại Lý Phủ","Lâm An Phủ","Vân Trung Trấn","Long Môn Trấn","Vĩnh Lạc Trấn","Đạo Hương Thôn","Giang Tân Thôn","Thạch Cổ Trấn","Long Tuyền Thôn","Ba Lăng Huyện"}
local tbHPLv = {"Kim sáng dược (tiểu)","Kim sáng dược (trung)","Kim sáng dược (đại)","Hồi Thiên Đơn","Cửu Chuyển Hoàn Hồn Đơn",}
local tbMPLv = {"Ngưng thần đơn (tiểu)","Ngưng thần đơn (trung)","Ngưng thần đơn (đại)","Đại Bổ Tán","Thủ ô hoàn thần đơn","Thừa tiên mật (tiểu)","Thừa tiên mật (trung)","Thừa tiên mật (đại)","Thất Xảo Bổ Tâm Đơn","Ngũ Hoa Ngọc Lộ Hoàn"}
local tbXY = {"T.Đ BVĐ1","T.Đ BVĐ2"}
local tbMapTrain = {"Mông Cổ Vương Đình(115) ","Nguyệt Nha Tuyền(115) ","Tàn Tích Cung A Phòng(115) ","Lương Sơn Bạc(115) ","Thần Nữ Phong(115) ","Tàn Tích Dạ Lang(115) ","Cổ Lãng Dữ(115) ","Đào Hoa Nguyên(115) ","Mạc Bắc Thảo Nguyên(105) ","Đôn Hoàng Cổ Thành(105) ","Hoạt Tử Nhân Mộ(105) ","Đại Vũ Đài(105) ","Tam Hiệp Sạn Đạo(105) ","Xi Vưu Động(105) ","Tỏa Vân Uyên(105) ","Phục Lưu Động(105) ","Sắc Lặc Xuyên(95) ","Gia Du Quan(95) ","Hoa Sơn(95) ","Thục Cương Sơn(95) ","Phong Đô Quỷ Thành(95) ","Miêu Lĩnh(95) ","Vũ Di Sơn(95) ","Vũ Lăng Sơn(95) ","Long Môn Thạch Quật(85) ","Hoàng Lăng Tây Hạ(85) ","Hoàng Hạc Lâu(85) ","Tiến Cúc Động(85) ","Kiếm Môn Quan(85) ","Thiên Long Tự(85) ","Bang Nguyên Bí Động(85) ","Phong Lăng Độ(75) ","Mê Cung Sa Mạc(75) ","Kê Quán Động(75) ","Thục Cương Sơn ","Kiếm Các Thục Đạo(75) ","Hoàng Lăng Đoàn Thị(75) ","Cửu Nghi Khê(75) ",}
local tbDoanThi1 = {"Chế độ tự động","Phong Vân Biến Huyễn (10)","Kim Ngọc Mãn Đường (50)","Lục Mạch Thần Kiếm (90)"}
local tbDoanThi2 = {"Thần Chỉ Điểm Huyệt (10)","Nhất Chỉ Càn Khôn (50)","Càn Dương Thần Chỉ(90)"}
local tbNgaMy1 = {"Phật Âm Chiến Ý (10)","Kiếm Ảnh Phật Quang (110)",}
local tbNgaMy2 = {"Phiêu Tuyết Xuyên Vân(10)","Tứ Tượng Đồng Quy (50)","Phong Sương Toái Ảnh (90)",}
local tbVD1 = {"Bác Cập Nhi Phục(10)","Vô Ngã Vô Kiếm(50)","Thiên Địa Vô Cực(90)"}
local tbVD2 = {"Kiếm Phi Kinh Thiên(10)","Tam Hoàn Sáo Nguyệt(50)","Nhân Kiếm Hợp Nhất(90)"}
local tbTVB1 = {"Hồi Phong Lạc Nhạn(10)","Dương Quan Tam Điệp(50)","Truy Tinh Trục Nguyệt(90)"}
local tbTVB2 = {"Hành Vân Quyết(10)","Truy Phong Quyết(50)","Thừa Long Quyết(90)"}
local tbCL1 = {"Hô Phong Pháp(10)","Cuồng Phong Sậu Điện(50)","Ngạo Tuyết Tiếu Phong(90)"}
local tbCL2 = {"Cuồng Lôi Chấn Địa(10)","Thiên Tế Tấn Lôi(50)","Lôi Động Cửu Thiên(90)"}  --OK
local tbTL1 = {"Phục Ma Đao Pháp(10)","Phá Giới Đao Pháp(50)","Thiên Trúc Tuyệt Đao(90)"}
local tbTL2 = {"Phổ Độ Côn Pháp(10)","Phục Ma Côn Pháp(50)","Thất Tinh La Sát Côn(90)"}   --OK
local tbDM1 = {"Truy Tâm Tiễn(10)","Thiên La Địa Võng(50)","Bạo Vũ Lê Hoa(90)"}
local tbDM2 = {"Độc Thích Cốt(10)","Tiểu Lý Phi Đao(50)","Triền Thân Thích(70)","Loạn Hoàn Kích(90)"} 
local tbTY1 = {"Phong Quyển Tàn Tuyết(10)","Bích Hải Triều Sinh(50)","Băng Tâm Tiên Tử(90)"}
local tbTY2 = {"Phong Hoa Tuyết Nguyệt(10)","Mục Dã Lưu Tinh(50)","Băng Tung Vô Ảnh(90)"}  
local tbMG1 = {"Khai Thiên Thức(10)","Phách Địa Thế(50)","Long Thôn Thức(90)"}
local tbMG2 = {"Thánh Hỏa Phần Tâm(10)","Vạn Vật Câu Phần(50)","Thánh Hỏa Liêu Nguyên(90)"}   --OK
local tbCB1 = {"Chế độ tự động ","Kiến Nhân Thân Thủ(10)","Hàng Long Hữu Hối(50)","Phi Long Tại Thiên(90)"}
local tbCB2 = {"Duyên Môn Thác Bát(10)","Bổng Đả Ác Cẩu(50)","Thiên Hạ Vô Cẩu(90)"}
local tbTN1 = {"Tàn Dương Như Huyết(10)","Liệt Hỏa Tình Thiên(50)","Vân Long Kích(90)"}
local tbTN2 = {"Đạn Chỉ Liệt Diệm(10)","Thôi Sơn Điền Hải(50)","Thiên Ngoại Lưu Tinh(90)"}  
local tbND1 = {"Độc Sa Chưởng(10)","Thiên Canh Địa Sát(50)","Âm Phong Thực Cốt(90)"}
local tbND2 = {"Huyết Đao Độc Sát(10)","Bách Độc Xuyên Tâm(50)","Huyền Âm Trảm(90)"}



 


function tbSprBao_Setting:OnOpen()
	self.tbSetting	= tbSprBao_Setting:Load(self.DATA_KEY) or {};
	szMsgAutoRemote = KFile.ReadTxtFile("\\user\\sprBao\\Remote.lua");
	Edt_SetTxt(self.UIGROUP, EDIT_CONTENT_SAFE, szMsgAutoRemote);

	if not self.tbSetting.nAutoTask then
		self.tbSetting.nAutoTask = 0;
	end	
	
	if not self.tbSetting.bFire then
		self.tbSetting.bFire = 0;
	end	

	if not self.tbSetting.nHour then
		self.tbSetting.nHour = 0;
	end
	if not self.tbSetting.nCheckSkill then   
		self.tbSetting.nCheckSkill = 0;
	end
	
	if not self.tbSetting.nSetMapTrain then   
		self.tbSetting.nSetMapTrain = 0;
	end
	
	
	if not self.tbSetting.nChetQuayLai then   
		self.tbSetting.nChetQuayLai = 1;
	end
	
	if not self.tbSetting.nRac then   
		self.tbSetting.nRac = 1;
	end
	
	
	if not self.tbSetting.nMinute then
		self.tbSetting.nMinute = 0;
	end

	if not self.tbSetting.nXuanJingLevel then
		self.tbSetting.nXuanJingLevel = 2;
	end

	if not self.tbSetting.nExpLevel then
		self.tbSetting.nExpLevel = 0;
	end
	if not self.tbSetting.nBindLevel then
		self.tbSetting.nBindLevel = 0;
	end

	if not self.tbSetting.nSecond then
		self.tbSetting.nSecond = 0;
	end

	if not self.tbSetting.nHpLevel then	--
		self.tbSetting.nHpLevel = 0;
	end

	if not self.tbSetting.nMpLevel then	--
		self.tbSetting.nMpLevel = 0;
	end

	if not self.tbSetting.nFoodLevel then	--
		self.tbSetting.nFoodLevel = 10;
	end

	if not self.tbSetting.nHtpLevel then	--
		self.tbSetting.nHtpLevel = 0;
	end

	if not self.tbSetting.nMaxCount then
		self.tbSetting.nMaxCount = 50;
	end
	
	if not self.tbSetting.nCancel then
		self.tbSetting.nCancel = 10;
	end
	
	if not self.tbSetting.nItemLevel then	--
		self.tbSetting.nItemLevel = 2;
	end

	if not self.tbSetting.nEquipLevel then	--װ
		self.tbSetting.nEquipLevel = 2;
	end

	if not self.tbSetting.nShouMaxLevel then	--
		self.tbSetting.nShouMaxLevel = 2;
	end

	if not self.tbSetting.nWuMaxLevel then	--
		self.tbSetting.nWuMaxLevel = 2;
	end

	if not self.tbSetting.nGuaJi then
		self.tbSetting.nGuaJi = 0;
	end

	

	if not self.tbSetting.nGuaJiY then
		self.tbSetting.nGuaJiY = 0;
	end

	if not self.tbSetting.nAwardFirst then
		self.tbSetting.nAwardFirst = 1;
	end

	if not self.tbSetting.nAwardSecond then
		self.tbSetting.nAwardSecond = 2;
	end

	if not self.tbSetting.nAwardThird then
		self.tbSetting.nAwardThird = 3;
	end
	
	
	

	if not self.tbSetting.nGuaJiDX then
		self.tbSetting.nGuaJiDX = 0;
	end

	if not self.tbSetting.nGuaJiDY then
		self.tbSetting.nGuaJiDY = 0;
	end

	if not self.tbSetting.nGuaJiX then
		self.tbSetting.nGuaJiX = 0;
	end 
	
	
	if not self.tbSetting.nGuaJiMap then
		self.tbSetting.nGuaJiMap = 0;
	end
	
	---------------------
	
	
	if not self.tbSetting.nLvHT then
		self.tbSetting.nLvHT = 5;
	end
	
	if not self.tbSetting.nGhepHT then
		self.tbSetting.nGhepHT = 12;
	end
	
	if not self.tbSetting.nKptp then
		self.tbSetting.nKptp = 200;
	end
	if not self.tbSetting.nMoney then
		self.tbSetting.nMoney = 2000;
	end
	
	if not self.tbSetting.nFullbag then
		self.tbSetting.nFullbag = 6;
	end
	
	if not self.tbSetting.nBac then
		self.tbSetting.nBac = 10000;
	end
	
	if not self.tbSetting.nGhepHT2 then
		self.tbSetting.nGhepHT2 = 6;
	end
	if not self.tbSetting.nGhepHT3 then
		self.tbSetting.nGhepHT3 = 4;
	end
	
	if not self.tbSetting.nCityId then  
		self.tbSetting.nCityId = 25;
	end
	
	if not self.tbSetting.nCity then   
		self.tbSetting.nCity = 3;
	end
	
	if not self.tbSetting.nHPLvId then  
		self.tbSetting.nHPLvId = 5; 
	end
	if not self.tbSetting.nXyId then  
		self.tbSetting.nXyId = 0; 
	end

	if not self.tbSetting.nSetskillId then  
		self.tbSetting.nSetskillId = 0; 
	end
	
	if not self.tbSetting.nSetskill then  
		self.tbSetting.nSetskill = 0; 
	end
	
	if not self.tbSetting.nHPLvId then  
		if me.nLevel < 30 then
			self.tbSetting.nHPLvId = 1;
		elseif me.nLevel < 50 then
			self.tbSetting.nHPLvId = 2;
		elseif me.nLevel < 70 then
			self.tbSetting.nHPLvId = 3;
		elseif me.nLevel < 90 then
			self.tbSetting.nHPLvId = 4;	
		elseif  me.nLevel >= 90 then
			self.tbSetting.nHPLvId = 5;
		end		
	end
	if not self.tbSetting.nHPLv then
		if me.nLevel < 30 then
			self.tbSetting.nHPLv = 1;
		elseif me.nLevel < 50 then
			self.tbSetting.nHPLv = 2;
		elseif me.nLevel < 70 then
			self.tbSetting.nHPLv = 3;
		elseif me.nLevel < 90 then
			self.tbSetting.nHPLv = 4;
		elseif  me.nLevel >= 90 then
			self.tbSetting.nHPLv = 5;		
		end		
	end
	if not self.tbSetting.nXy then  
		self.tbSetting.nXy = 1; 
	end
	if not self.tbSetting.nMPLvId then
		if me.nLevel < 30 then
			self.tbSetting.nMPLvId = 1;
		elseif me.nLevel < 50 then
			self.tbSetting.nMPLvId = 2;
		elseif me.nLevel < 70 then
			self.tbSetting.nMPLvId = 3;
		elseif me.nLevel < 90 then
			self.tbSetting.nMPLvId = 4;	
		elseif  me.nLevel >= 90 then
			self.tbSetting.nMPLvId = 5;
		end		
	end
	if not self.tbSetting.nMPLvId then  
		self.tbSetting.nMPLvId1 = 2; 
	end
	if not self.tbSetting.nMPLv then
		if me.nLevel < 30 then
			self.tbSetting.nMPLv = 1;
		elseif me.nLevel < 50 then
			self.tbSetting.nMPLv = 2;
		elseif me.nLevel < 70 then
			self.tbSetting.nMPLv = 3;
		elseif me.nLevel < 90 then
			self.tbSetting.nMPLv = 4;
		elseif  me.nLevel >= 90 then
			self.tbSetting.nMPLv = 5;		
		end		
	end
	
	if not self.tbSetting.nExitGame then
		self.tbSetting.nExitGame = 1;
	end
	if not self.tbSetting.nVAGT then
		self.tbSetting.nVAGT = 0;
	end
	Btn_Check("UI_SPRBAO_SETTING", self.BTN_CheckSkill, self.tbSetting.nCheckSkill);
	Btn_Check("UI_SPRBAO_SETTING", self.BTN_SETMAPTRAIN, self.tbSetting.nSetMapTrain);
	Btn_Check("UI_SPRBAO_SETTING", self.BTN_ChetQuayLai, self.tbSetting.nChetQuayLai);	
	Btn_Check("UI_SPRBAO_SETTING", self.BTN_RAC, self.tbSetting.nRac);
	Btn_Check("UI_SPRBAO_SETTING", self.BTN_Horse, self.tbSetting.nHorse);
	Btn_Check("UI_SPRBAO_SETTING", self.BTN_BACEXIT, self.tbSetting.nBacexit);
	Btn_Check("UI_SPRBAO_SETTING", self.BTN_AUTOTASK, self.tbSetting.nAutoTask);
	Btn_Check("UI_SPRBAO_SETTING", self.BTN_FIRE, self.tbSetting.bFire);
	Btn_Check("UI_SPRBAO_SETTING", self.BTN_GuaJi, self.tbSetting.nGuaJi);
	Btn_Check("UI_SPRBAO_SETTING", self.BTN_EXITGAME, self.tbSetting.nExitGame);
	Btn_Check("UI_SPRBAO_SETTING", self.BTN_VAGT, self.tbSetting.nVAGT);
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_MAXCOUNT, self.tbSetting.nMaxCount );
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_CANCEL, self.tbSetting.nCancel );
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_HP, self.tbSetting.nHpLevel );	--
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_MP, self.tbSetting.nMpLevel );	--
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_FOOD, self.tbSetting.nFoodLevel );	--
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_HTP, self.tbSetting.nHtpLevel );	--
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_ITEM, self.tbSetting.nItemLevel );	--
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_EQUIP, self.tbSetting.nEquipLevel );	--
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_WUMAX, self.tbSetting.nWuMaxLevel );	--
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_SHOUMAX, self.tbSetting.nShouMaxLevel );	--
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_XUANMIX, self.tbSetting.nXuanJingLevel);  --vinh
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_BIND, self.tbSetting.nBindLevel);  --vinh 21
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_EXP, self.tbSetting.nExpLevel);  --vinh  21
	Edt_SetTxt(self.UIGROUP, self.EDT_HOUR, self.tbSetting.nHour);
	Edt_SetTxt(self.UIGROUP, self.EDT_MINUTE, self.tbSetting.nMinute);
	Edt_SetTxt(self.UIGROUP, self.EDT_SECOND, self.tbSetting.nSecond);
	Edt_SetTxt(self.UIGROUP, self.EDT_GHEPHT, self.tbSetting.nGhepHT);
	Edt_SetTxt(self.UIGROUP, self.EDT_KPTP, self.tbSetting.nKptp);
	Edt_SetTxt(self.UIGROUP, self.EDT_MONEY, self.tbSetting.nMoney);
	Edt_SetTxt(self.UIGROUP, self.EDT_GHEPHT2, self.tbSetting.nGhepHT2);
	Edt_SetTxt(self.UIGROUP, self.EDT_GHEPHT3, self.tbSetting.nGhepHT3);
	Edt_SetTxt(self.UIGROUP, self.EDT_LVHT, self.tbSetting.nLvHT);
	Edt_SetTxt(self.UIGROUP, self.EDT_FULLBAG, self.tbSetting.nFullbag);
	Edt_SetTxt(self.UIGROUP, self.EDT_BAC, self.tbSetting.nBac);
	self:UpdateComboBox();
	self:SetAwardLabel();
	self:UpdateLable();
end

function tbSprBao_Setting:SaveSetting()
    self:GetEdtValue();
	tbSprBao_Setting:Save(self.DATA_KEY, self.tbSetting);
	UiManager:UpdateAll(1);
end

function tbSprBao_Setting:UpdateComboBox()
	if (self.tbSetting.nCheckSkill == 1) then
		Wnd_SetEnable(self.UIGROUP, self.BTN_SETSKILL, 1);
	else
		Wnd_SetEnable(self.UIGROUP, self.BTN_SETSKILL, 0);
	end 
	if (self.tbSetting.nSetMapTrain == 1) then
		Wnd_SetEnable(self.UIGROUP, self.BTN_GETPOS, 0);
		Wnd_SetEnable(self.UIGROUP, self.BTN_OUTPOS, 0);
		Wnd_SetEnable(self.UIGROUP, self.BTN_MAPTRAIN, 1);

	else
		Wnd_SetEnable(self.UIGROUP, self.BTN_GETPOS, 1);
		Wnd_SetEnable(self.UIGROUP, self.BTN_OUTPOS, 1);
		Wnd_SetEnable(self.UIGROUP, self.BTN_MAPTRAIN, 0);
	end
end

function tbSprBao_Setting:OnButtonClick(szWnd, nParam)
	szMsgAutoRemote = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT_SAFE);
	if szWnd == BUTTON_CLOSE then
		UiManager:CloseWindow(self.UIGROUP);
	end
	if szWnd == self.BTN_CLOSE or szWnd == self.BTN_EXIT then 
		UiManager:CloseWindow("UI_SPRBAO_SETTING");
	elseif szWnd == self.BTN_SAVE then
		self:SaveSetting();
		UiManager:CloseWindow("UI_SPRBAO_SETTING");
	elseif szWnd == self.BTN_AUTOTASK then
		self.tbSetting.nAutoTask = nParam;
	elseif szWnd == self.BTN_FIRE then
		self.tbSetting.bFire = nParam;
	elseif szWnd == self.BTN_CheckSkill then  
		self.tbSetting.nCheckSkill = nParam;
		if (nParam == 1) then
			Wnd_SetEnable(self.UIGROUP, self.BTN_SETSKILL, 1);
		else
			Wnd_SetEnable(self.UIGROUP, self.BTN_SETSKILL, 0);
		end   
	elseif szWnd == self.BTN_ChetQuayLai then  
		self.tbSetting.nChetQuayLai = nParam;
	elseif szWnd == self.BTN_RAC then  
		self.tbSetting.nRac = nParam;	

	elseif szWnd == self.BTN_Horse then  
		self.tbSetting.nHorse = nParam;	
	elseif szWnd == self.BTN_BACEXIT then  
		self.tbSetting.nBacexit = nParam;	
	elseif szWnd ==self.BTN_EXITGAME then
		self.tbSetting.nExitGame = nParam;
		self.tbSetting.nGuaJi = 0;
		self.tbSetting.nVAGT = 0;
		Btn_Check(self.UIGROUP, self.BTN_GuaJi, 0);
		Btn_Check(self.UIGROUP, self.BTN_VAGT, 0);
	elseif szWnd ==self.BTN_VAGT then
		self.tbSetting.nVAGT = nParam;
		self.tbSetting.nGuaJi = 0;
		self.tbSetting.nExitGame = 0;
		Btn_Check(self.UIGROUP, self.BTN_GuaJi, 0);
		Btn_Check(self.UIGROUP, self.BTN_EXITGAME, 0);
	elseif szWnd ==self.BTN_GuaJi then
		self.tbSetting.nGuaJi = nParam;
		self.tbSetting.nExitGame = 0;
		self.tbSetting.nVAGT = 0;
		Btn_Check(self.UIGROUP, self.BTN_EXITGAME, 0);
		Btn_Check(self.UIGROUP, self.BTN_VAGT, 0);		
	elseif szWnd == self.BTN_GETPOS then
		local nMapId,nX,nY = me.GetWorldPos();
		if ((nMapId <30 and nMapId >0) or (nMapId <1693 and nMapId >137)) then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Bản đồ này: <bclr=red><color=yellow>[Không thể Luyện Công]")
			self.tbSetting.nGuaJiMap  = 0;
			self.tbSetting.nGuaJiX = 0;
			self.tbSetting.nGuaJiY = 0;
			Txt_SetTxt(self.UIGROUP, self.TXT_OUTPOS, "<color=Black>[Chưa có]");
		else
			self.tbSetting.nGuaJiMap  = nMapId;
			self.tbSetting.nGuaJiX = nX;
			self.tbSetting.nGuaJiY = nY;
			self.tbSetting.nGuaJiDX = 0;
			self.tbSetting.nGuaJiDY = 0;
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>[Tọa độ Phù] <bclr=red><color=white>Tự động")
			UiManager:OpenWindow("UI_INFOBOARD", "<color=white>Bạn có thể lấy thêm [Tọa độ Phù] khác")
			Txt_SetTxt(self.UIGROUP, self.TXT_OUTPOS, "<color=Black>[Tọa độ Phù tự động]");
		end
		Txt_SetTxt(self.UIGROUP, self.TXT_MAP, string.format("<color=yellow>Bản đồ Luyện:<color=0,255,255> %s <color>",GetMapNameFormId(self.tbSetting.nGuaJiMap)));
		Txt_SetTxt(self.UIGROUP, self.TXT_GUAJIPOS, string.format("<color=yellow>Tọa độ: <color=0,255,255>[%s,%s]<color>",math.floor(self.tbSetting.nGuaJiX/8),math.floor(self.tbSetting.nGuaJiY/16)));
	elseif szWnd == self.BTN_OUTPOS then
		local mX=self.tbSetting.nGuaJiX;
		local mY=self.tbSetting.nGuaJiY;
		local nMapId,nDX,nDY = me.GetWorldPos();
		if (math.abs(mX-nDX) < 50 and  math.abs(mY-nDY) < 50) then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Cảnh báo: Tọa Độ phù không an toàn")
			self.tbSetting.nGuaJiMap  = nMapId;
			self.tbSetting.nGuaJiDX = nDX;
			self.tbSetting.nGuaJiDY = nDY;
		elseif ((nMapId <30 and nMapId >0) or (nMapId <1693 and nMapId >137)) then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Bản đồ này: <bclr=red><color=yellow>[Không thể Luyện Công]")
			self.tbSetting.nGuaJiMap  = 0;
			self.tbSetting.nGuaJiDX = 0;
			self.tbSetting.nGuaJiDY = 0;
		else 
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tọa Độ phù an toàn")
			self.tbSetting.nGuaJiMap  = nMapId;
			self.tbSetting.nGuaJiDX = nDX;
			self.tbSetting.nGuaJiDY = nDY;
		end
		Txt_SetTxt(self.UIGROUP, self.TXT_OUTPOS, string.format("<color=yellow>Phù: <color=0,255,255>[%s,%s]<color>",math.floor(self.tbSetting.nGuaJiDX/8),math.floor(self.tbSetting.nGuaJiDY/16)));
	elseif szWnd == self.BTN_SETMAPTRAIN then  
		self.tbSetting.nSetMapTrain = nParam;
		if (nParam == 1) then
			Wnd_SetEnable(self.UIGROUP, self.BTN_GETPOS, 0);
			Wnd_SetEnable(self.UIGROUP, self.BTN_OUTPOS, 0);
			Wnd_SetEnable(self.UIGROUP, self.BTN_MAPTRAIN, 1);
		else
			Wnd_SetEnable(self.UIGROUP, self.BTN_GETPOS, 1);
			Wnd_SetEnable(self.UIGROUP, self.BTN_OUTPOS, 1);
			Wnd_SetEnable(self.UIGROUP, self.BTN_MAPTRAIN, 0);
			
		end		
		
	elseif szWnd == self.BTN_CITY then
		DisplayPopupMenu(
		self.UIGROUP,szWnd,15,0,
		tbCity[1],1,
		tbCity[2],2,
		tbCity[3],3,
		tbCity[4],4,
		tbCity[5],5,
		tbCity[6],6,
		tbCity[7],7,
		tbCity[8],8,
		tbCity[9],9,
		tbCity[10],10,
		tbCity[11],11,
		tbCity[12],12,
		tbCity[13],13,
		tbCity[14],14,
		tbCity[15],15
		)
	elseif szWnd == self.BTN_MAPTRAIN then
		DisplayPopupMenu(
		self.UIGROUP,szWnd,38,0,
		tbMapTrain[1],1,
		tbMapTrain[2],2,
		tbMapTrain[3],3,
		tbMapTrain[4],4,
		tbMapTrain[5],5,
		tbMapTrain[6],6,
		tbMapTrain[7],7,
		tbMapTrain[8],8,
		tbMapTrain[9],9,
		tbMapTrain[10],10,
		tbMapTrain[11],11,
		tbMapTrain[12],12,
		tbMapTrain[13],13,
		tbMapTrain[14],14,
		tbMapTrain[15],15,
		tbMapTrain[16],16,
		tbMapTrain[17],17,
		tbMapTrain[18],18,
		tbMapTrain[19],19,
		tbMapTrain[20],20,
		tbMapTrain[21],21,
		tbMapTrain[22],22,
		tbMapTrain[23],23,
		tbMapTrain[24],24,
		tbMapTrain[25],25,
		tbMapTrain[26],26,
		tbMapTrain[27],27,
		tbMapTrain[28],28,
		tbMapTrain[29],29,
		tbMapTrain[30],30,
		tbMapTrain[31],31,
		tbMapTrain[32],32,
		tbMapTrain[33],33,
		tbMapTrain[34],34,
		tbMapTrain[35],35,
		tbMapTrain[36],36,
		tbMapTrain[37],37,
		tbMapTrain[38],38
		)
	elseif szWnd == self.BTN_HPLV then          
		DisplayPopupMenu(
		self.UIGROUP,szWnd,5,0,
		tbHPLv[1],1,
		tbHPLv[2],2,
		tbHPLv[3],3,
		tbHPLv[4],4,
		tbHPLv[5],5
		)	
	elseif szWnd == self.BTN_XY then          
		DisplayPopupMenu(
		self.UIGROUP,szWnd,2,0,
		tbXY[1],1,
		tbXY[2],2
		)		
	
	elseif szWnd == self.BTN_SETSKILL then             
			if me.nFaction == 12 and (me.IsHaveSkill(226) == 1 or me.IsHaveSkill(227) == 1 or me.IsHaveSkill(229) == 1 or me.IsHaveSkill(232) == 1) then   
				DisplayPopupMenu(
				self.UIGROUP,szWnd,4,0,
				tbDoanThi1[1],1,
				tbDoanThi1[2],2,
				tbDoanThi1[3],3,
				tbDoanThi1[4],4
				)
			elseif me.nFaction == 12 and (me.IsHaveSkill(213) == 1 or me.IsHaveSkill(215) == 1 or me.IsHaveSkill(217) == 1 or me.IsHaveSkill(223) == 1) then   
				DisplayPopupMenu(
				self.UIGROUP,szWnd,3,0,
				tbDoanThi2[1],1,
				tbDoanThi2[2],2,
				tbDoanThi2[3],3
				)
		
			elseif me.nFaction == 5 and (me.IsHaveSkill(107) == 1 or me.IsHaveSkill(837) == 1) then  
				DisplayPopupMenu(
				self.UIGROUP,szWnd,2,0,
				tbNgaMy1[1],1,
				tbNgaMy1[2],2
				)
			elseif me.nFaction == 5 and (me.IsHaveSkill(96) == 1 or me.IsHaveSkill(99) == 1 or me.IsHaveSkill(103) == 1) then  
				DisplayPopupMenu(
				self.UIGROUP,szWnd,3,0,
				tbNgaMy2[1],1,
				tbNgaMy2[2],2,
				tbNgaMy2[3],3
				)	

			elseif me.nFaction == 9  and  (me.IsHaveSkill(160) == 1 or me.IsHaveSkill(159) == 1 or me.IsHaveSkill(162) == 1 or me.IsHaveSkill(165) == 1) then 
				DisplayPopupMenu(
				self.UIGROUP,szWnd,3,0,
				tbVD1[1],1,
				tbVD1[2],2,
				tbVD1[3],3
				)
			elseif me.nFaction == 9  and  (me.IsHaveSkill(167) == 1 or me.IsHaveSkill(169) == 1 or me.IsHaveSkill(171) == 1) then 
				DisplayPopupMenu(
				self.UIGROUP,szWnd,3,0,
				tbVD2[1],1,
				tbVD2[2],2,
				tbVD2[3],3
				)

			elseif me.nFaction == 2 and (me.IsHaveSkill(38) == 1 or me.IsHaveSkill(43) == 1 or me.IsHaveSkill(47) == 1) then   
				DisplayPopupMenu(
				self.UIGROUP,szWnd,3,0,
				tbTVB1[1],1,
				tbTVB1[2],2,
				tbTVB1[3],3
				)
			elseif me.nFaction == 2 and (me.IsHaveSkill(52) == 1 or me.IsHaveSkill(50) == 1 or me.IsHaveSkill(53) == 1 or me.IsHaveSkill(56) == 1) then   
				DisplayPopupMenu(
				self.UIGROUP,szWnd,3,0,
				tbTVB2[1],1,
				tbTVB2[2],2,
				tbTVB2[3],3
				)

			elseif me.nFaction == 10 and (me.IsHaveSkill(175) == 1 or me.IsHaveSkill(178) == 1 or me.IsHaveSkill(181) == 1) then   
				DisplayPopupMenu(
				self.UIGROUP,szWnd,3,0,
				tbCL1[1],1,
				tbCL1[2],2,
				tbCL1[3],3
				)
			elseif me.nFaction == 10 and (me.IsHaveSkill(188) == 1 or me.IsHaveSkill(190) == 1 or me.IsHaveSkill(192) == 1) then   
				DisplayPopupMenu(
				self.UIGROUP,szWnd,3,0,
				tbCL2[1],1,
				tbCL2[2],2,
				tbCL2[3],3
				)
	
			elseif me.nFaction == 1 and (me.IsHaveSkill(21) == 1 or me.IsHaveSkill(24) == 1 or me.IsHaveSkill(27) == 1) then   
				DisplayPopupMenu(
				self.UIGROUP,szWnd,3,0,
				tbTL1[1],1,
				tbTL1[2],2,
				tbTL1[3],3
				)
			elseif me.nFaction == 1 and (me.IsHaveSkill(29) == 1 or me.IsHaveSkill(33) == 1 or me.IsHaveSkill(36) == 1) then   
				DisplayPopupMenu(
				self.UIGROUP,szWnd,3,0,
				tbTL2[1],1,
				tbTL2[2],2,
				tbTL2[3],3
				)
		
			elseif me.nFaction == 11 and (me.IsHaveSkill(194) == 1 or me.IsHaveSkill(198) == 1 or me.IsHaveSkill(202) == 1) then   
				DisplayPopupMenu(
				self.UIGROUP,szWnd,3,0,
				tbMG1[1],1,
				tbMG1[2],2,
				tbMG1[3],3
				)
			elseif me.nFaction == 11 and (me.IsHaveSkill(205) == 1 or me.IsHaveSkill(208) == 1 or me.IsHaveSkill(211) == 1) then   
				DisplayPopupMenu(
				self.UIGROUP,szWnd,3,0,
				tbMG2[1],1,
				tbMG2[2],2,
				tbMG2[3],3
				)	
			
			elseif me.nFaction == 3 and (me.IsHaveSkill(59) == 1 or me.IsHaveSkill(62) == 1 or me.IsHaveSkill(66) == 1) then   
				DisplayPopupMenu(
				self.UIGROUP,szWnd,3,0,
				tbDM1[1],1,
				tbDM1[2],2,
				tbDM1[3],3
				)
			elseif me.nFaction == 3 and (me.IsHaveSkill(69) == 1 or me.IsHaveSkill(72) == 1 or me.IsHaveSkill(73) == 1 or me.IsHaveSkill(74) == 1) then    
				DisplayPopupMenu(
				self.UIGROUP,szWnd,4,0,
				tbDM2[1],1,
				tbDM2[2],2,
				tbDM2[3],3,
				tbDM2[4],4
				)		
			
			elseif me.nFaction == 6 and (me.IsHaveSkill(111) == 1 or me.IsHaveSkill(114) == 1 or me.IsHaveSkill(117) == 1) then   
				DisplayPopupMenu(
				self.UIGROUP,szWnd,3,0,
				tbTY1[1],1,
				tbTY1[2],2,
				tbTY1[3],3
				)
			elseif me.nFaction == 6 and (me.IsHaveSkill(120) == 1 or me.IsHaveSkill(123) == 1 or me.IsHaveSkill(125) == 1) then   
				DisplayPopupMenu(
				self.UIGROUP,szWnd,3,0,
				tbTY2[1],1,
				tbTY2[2],2,
				tbTY2[3],3
				)	
			
			elseif me.nFaction == 7 and (me.IsHaveSkill(128) == 1 or me.IsHaveSkill(131) == 1 or me.IsHaveSkill(134) == 1) then   
				DisplayPopupMenu(
				self.UIGROUP,szWnd,4,0,
				tbCB1[1],1,
				tbCB1[2],2,
				tbCB1[3],3,
				tbCB1[4],4
				)
			elseif me.nFaction == 7 and (me.IsHaveSkill(137) == 1 or me.IsHaveSkill(140) == 1 or me.IsHaveSkill(141) == 1) then      
				DisplayPopupMenu(
				self.UIGROUP,szWnd,3,0,
				tbCB2[1],1,
				tbCB2[2],2,
				tbCB2[3],3
				)	
			
			elseif me.nFaction == 8 and (me.IsHaveSkill(143) == 1 or me.IsHaveSkill(146) == 1 or me.IsHaveSkill(149) == 1) then   
				DisplayPopupMenu(
				self.UIGROUP,szWnd,3,0,
				tbTN1[1],1,
				tbTN1[2],2,
				tbTN1[3],3
				)
			elseif me.nFaction == 8 and (me.IsHaveSkill(151) == 1 or me.IsHaveSkill(153) == 1 or me.IsHaveSkill(156) == 1) then      
				DisplayPopupMenu(
				self.UIGROUP,szWnd,3,0,
				tbTN2[1],1,
				tbTN2[2],2,
				tbTN2[3],3
				)		
				
			
			elseif me.nFaction == 4 and (me.IsHaveSkill(86) == 1 or me.IsHaveSkill(90) == 1 or me.IsHaveSkill(93) == 1) then   
				DisplayPopupMenu(
				self.UIGROUP,szWnd,3,0,
				tbND1[1],1,
				tbND1[2],2,
				tbND1[3],3
				)
			elseif me.nFaction == 4 and (me.IsHaveSkill(76) == 1 or me.IsHaveSkill(80) == 1 or me.IsHaveSkill(83) == 1) then      
				DisplayPopupMenu(
				self.UIGROUP,szWnd,3,0,
				tbND2[1],1,
				tbND2[2],2,
				tbND2[3],3
				)			

			end

	elseif szWnd == self.BTN_MPLV then            
		DisplayPopupMenu(
		self.UIGROUP,szWnd,10,0,
		tbMPLv[1],1,
		tbMPLv[2],2,
		tbMPLv[3],3,
		tbMPLv[4],4,
		tbMPLv[5],5,
		tbMPLv[6],6,
		tbMPLv[7],7,
		tbMPLv[8],8,
		tbMPLv[9],9,
		tbMPLv[10],10
		)	
	elseif szWnd == self.BTN_AWARDFIRST then
		DisplayPopupMenu(
		self.UIGROUP,szWnd,4,0,
		tbAwardMenu[1],1,
		tbAwardMenu[2],2,
		tbAwardMenu[3],3,
		tbAwardMenu[4],4
		)
	elseif szWnd == self.BTN_AWARDSECOND then
		DisplayPopupMenu(
		self.UIGROUP,szWnd,4,0,
		tbAwardMenu[1],5,
		tbAwardMenu[2],6,
		tbAwardMenu[3],7,
		tbAwardMenu[4],8
		)
	elseif szWnd == self.BTN_AWARDTHIRD then
		DisplayPopupMenu(
		self.UIGROUP,szWnd,4,0,
		tbAwardMenu[1],9,
		tbAwardMenu[2],10,
		tbAwardMenu[3],11,
		tbAwardMenu[4],12
		)
	elseif szWnd == self.BTN_STARTBAO then
		UiManager:StartBao()
	end
end

function tbSprBao_Setting:OnMenuItemSelected(szWnd, nItemId, nParam)

	--me.Msg(""..nItemId);
	if szWnd == self.BTN_CITY then
		self.tbSetting.nCity = nItemId
	end
	
	if szWnd == self.BTN_MAPTRAIN then
		self.tbSetting.nMapTrain = nItemId
	end
	
	
	if szWnd == self.BTN_HPLV then           
		self.tbSetting.nHPLv = nItemId
	end
	if szWnd == self.BTN_XY then           
		self.tbSetting.nXy = nItemId
	end
	if szWnd == self.BTN_SETSKILL then           
		self.tbSetting.nSetskill = nItemId
	end
	
	
	if szWnd == self.BTN_MPLV then         
		self.tbSetting.nMPLv = nItemId
	end
	
	if szWnd == self.BTN_AWARDFIRST then
		self.tbSetting.nAwardFirst = nItemId
	end
	if szWnd == self.BTN_AWARDSECOND then
		self.tbSetting.nAwardSecond = nItemId - 4
	end
	if szWnd == self.BTN_AWARDTHIRD then
		self.tbSetting.nAwardThird = nItemId - 8
	end
	self:SetAwardLabel();
end
function tbSprBao_Setting:OnScorllbarPosChanged(szWnd, nParam)
	if szWnd == tbSprBao_Setting.SCROLL_HP then
		local nCBuyHP = nParam
		self.tbSetting.nHpLevel  = nCBuyHP ;

	elseif szWnd == tbSprBao_Setting.SCROLL_MP then
		local nCBuyMP = nParam ;
		self.tbSetting.nMpLevel = nCBuyMP 

	elseif szWnd == tbSprBao_Setting.SCROLL_FOOD then
		local nCBuyFood = nParam ;
		self.tbSetting.nFoodLevel = nCBuyFood ;

	elseif szWnd == tbSprBao_Setting.SCROLL_HTP then
		local nCBuyHTP = nParam ;
		self.tbSetting.nHtpLevel = nCBuyHTP ;
	
	elseif szWnd == tbSprBao_Setting.SCROLL_ITEM then
		local nItem = nParam
		self.tbSetting.nItemLevel  = nItem  ;
		
	elseif szWnd == tbSprBao_Setting.SCROLL_EQUIP then
		local nEquip = nParam ;
		self.tbSetting.nEquipLevel = nEquip ;

	elseif szWnd == tbSprBao_Setting.SCROLL_WUMAX then
		local nWuMax = nParam ;
		self.tbSetting.nWuMaxLevel = nWuMax ;
		
	elseif szWnd == tbSprBao_Setting.SCROLL_SHOUMAX then
		local nShouMax = nParam ;
		self.tbSetting.nShouMaxLevel = nShouMax ;
	elseif szWnd == tbSprBao_Setting.SCROLL_XUANMIX then
		local nXuanMix = nParam ;
		self.tbSetting.nXuanJingLevel = nXuanMix ;

	elseif szWnd == tbSprBao_Setting.SCROLL_BIND then  --21
		local nBind = nParam ;
		self.tbSetting.nBindLevel = nBind ;  
	elseif szWnd == tbSprBao_Setting.SCROLL_EXP then  --21
		local nExp = nParam ;
		self.tbSetting.nExpLevel = nExp ; 
	elseif szWnd == tbSprBao_Setting.SCROLL_MAXCOUNT then
	    local nMaxCount = nParam ;
		self.tbSetting.nMaxCount = nMaxCount ;
	elseif szWnd == tbSprBao_Setting.SCROLL_CANCEL then
	    local nCancel = nParam ;
		self.tbSetting.nCancel = nCancel;	
	end
	self:UpdateLable();
end

function tbSprBao_Setting:GetEdtValue()
	local szHour = Edt_GetInt(self.UIGROUP, self.EDT_HOUR)
	if szHour == "" or nil then
		self.tbSetting.nHour = 0
	else
		self.tbSetting.nHour = tonumber(szHour)
	end
	if self.tbSetting.nHour > 23 then
		self.tbSetting.nHour = 23
	end

	local szMinute = Edt_GetInt(self.UIGROUP, self.EDT_MINUTE)
	if szMinute == "" or nil then
		self.tbSetting.nMinute = 0
	else
		self.tbSetting.nMinute = tonumber(szMinute)
	end
	if self.tbSetting.nMinute > 59 then
		self.tbSetting.nMinute = 59
	end

	local szSecond = Edt_GetInt(self.UIGROUP, self.EDT_SECOND)
	if szSecond == "" or nil then
		self.tbSetting.nSecond = 0
	else
		self.tbSetting.nSecond = tonumber(szSecond)
	end
	if self.tbSetting.nSecond > 59 then
		self.tbSetting.nSecond = 59
	end
	if me.nLevel < 30 then
		if self.tbSetting.nHPLv > 1 or self.tbSetting.nHPLvId > 1 then 
		self.tbSetting.nHPLv = 1;
		self.tbSetting.nHPLvId = 1;
		
		elseif self.tbSetting.nMPLv > 1 and self.tbSetting.nMPLv <= 5 then 
		self.tbSetting.nMPLv = 1;
		self.tbSetting.nMPLvId1 = 2;
		self.tbSetting.nMPLvId = 1;
		elseif self.tbSetting.nMPLv > 6 then 
		self.tbSetting.nMPLv = 6;
		self.tbSetting.nMPLvId1 = 3;
		self.tbSetting.nMPLvId = 1;
		end
	elseif me.nLevel < 50 then
		if self.tbSetting.nHPLv > 2 or self.tbSetting.nHPLvId > 2 then 
		self.tbSetting.nHPLv = 2;
		self.tbSetting.nHPLvId = 2;
		
		elseif self.tbSetting.nMPLv > 2 and self.tbSetting.nMPLv <= 5 then 
		self.tbSetting.nMPLv = 2;
		self.tbSetting.nMPLvId1 = 2;
		self.tbSetting.nMPLvId = 2;
		elseif self.tbSetting.nMPLv > 7 then 
		self.tbSetting.nMPLv = 7;
		self.tbSetting.nMPLvId1 = 3;
		self.tbSetting.nMPLvId = 2;
		end
	elseif me.nLevel < 70 then
		if self.tbSetting.nHPLv > 3 or self.tbSetting.nHPLvId > 3 then 
		self.tbSetting.nHPLv = 3;
		self.tbSetting.nHPLvId = 3;
		
		elseif self.tbSetting.nMPLv > 3 and self.tbSetting.nMPLv <= 5 then 
		self.tbSetting.nMPLv = 3;
		self.tbSetting.nMPLvId1 = 2;
		self.tbSetting.nMPLvId = 3;
		elseif self.tbSetting.nMPLv > 8 then 
		self.tbSetting.nMPLv = 8;
		self.tbSetting.nMPLvId1 = 3;
		self.tbSetting.nMPLvId = 3;
		end	
	elseif me.nLevel < 90 then
		if self.tbSetting.nHPLv > 4 or self.tbSetting.nHPLvId >4 then 
		self.tbSetting.nHPLv = 4;
		self.tbSetting.nHPLvId = 4;
		elseif self.tbSetting.nMPLv > 4 and self.tbSetting.nMPLv <= 5 then 
		self.tbSetting.nMPLv = 4;
		self.tbSetting.nMPLvId1 = 2;
		self.tbSetting.nMPLvId = 4;
		elseif self.tbSetting.nMPLv > 9 then 
		self.tbSetting.nMPLv = 9;
		self.tbSetting.nMPLvId1 = 3;
		self.tbSetting.nMPLvId = 4;
		end	
		
	end
	--if 	(self.tbSetting.nGuaJiDX == 0 or self.tbSetting.nGuaJiDY == 0) and self.tbSetting.nGuaJi == 1 then
	--	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chưa có: <bclr=red><color=yellow>[Tọa Độ Phù]")
	if (self.tbSetting.nGuaJiX == 0 or self.tbSetting.nGuaJiY == 0) and self.tbSetting.nGuaJi == 1 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Chưa có: <bclr=red><color=yellow>[Tọa Độ Luyện Công]")
	end
	
	local szLvHT = Edt_GetInt(self.UIGROUP, self.EDT_LVHT)
	if szLvHT == "" or nil then
		self.tbSetting.nLvHT = 5
	else
		self.tbSetting.nLvHT = tonumber(szLvHT)
	end	
	
	if self.tbSetting.nLvHT < 2 then 
	self.tbSetting.nLvHT = 2
	end
	if self.tbSetting.nLvHT > 11 then 
	self.tbSetting.nLvHT = 5
	end
	
	local szGhepHT = Edt_GetInt(self.UIGROUP, self.EDT_GHEPHT)
	if szGhepHT == "" or nil then
		self.tbSetting.nGhepHT = 12
	else
		self.tbSetting.nGhepHT = tonumber(szGhepHT)
	end	
	
	if self.tbSetting.nGhepHT < 2 then 
	self.tbSetting.nGhepHT = 2
	end
	if self.tbSetting.nGhepHT > 16 then 
	self.tbSetting.nGhepHT = 12
	end
	
	local szKptp = Edt_GetInt(self.UIGROUP, self.EDT_KPTP)
	if szKptp == "" or nil then
		self.tbSetting.nKptp = 200
	else
		self.tbSetting.nKptp = tonumber(szKptp)
	end
	
	if self.tbSetting.nKptp > 9999 then 
	self.tbSetting.nKptp = 9999
	end		
	
	local szMoney = Edt_GetInt(self.UIGROUP, self.EDT_MONEY)
	if szMoney == "" or nil then
		self.tbSetting.nMoney = 2000
	else
		self.tbSetting.nMoney = tonumber(szMoney)
	end
	if self.tbSetting.nMoney > 9999999 then 
	self.tbSetting.nMoney = 9999999
	end
	
	local szFullbag = Edt_GetInt(self.UIGROUP, self.EDT_FULLBAG)
	if szFullbag == "" or nil then
		self.tbSetting.nFullbag = 6
	else
		self.tbSetting.nFullbag = tonumber(szFullbag)
	end
	local szBac = Edt_GetInt(self.UIGROUP, self.EDT_BAC)
	if szBac == "" or nil then
		self.tbSetting.nBac = 10000
	else
		self.tbSetting.nBac = tonumber(szBac)
	end
	if self.tbSetting.nBac > 9999999 then 
	self.tbSetting.nBac = 9999999
	end
	
	local szGhepHT2 = Edt_GetInt(self.UIGROUP, self.EDT_GHEPHT2)
	if szGhepHT2 == "" or nil then
		self.tbSetting.nGhepHT2 = 6
	else
		self.tbSetting.nGhepHT2 = tonumber(szGhepHT2)
	end	
	if self.tbSetting.nGhepHT2 < 2 then 
	self.tbSetting.nGhepHT2 = 2
	end
	if self.tbSetting.nGhepHT2 > 14 then 
	self.tbSetting.nGhepHT2 = 6
	end
	
	local szGhepHT3 = Edt_GetInt(self.UIGROUP, self.EDT_GHEPHT3)
	if szGhepHT3 == "" or nil then
		self.tbSetting.nGhepHT3 = 4
	else
		self.tbSetting.nGhepHT3 = tonumber(szGhepHT3)
	end	
	if self.tbSetting.nGhepHT3 < 2 then 
	self.tbSetting.nGhepHT3 = 2
	end
	if self.tbSetting.nGhepHT3 > 16 then 
	self.tbSetting.nGhepHT3 = 4
	end
	if me.nLevel < 90 then 
	self.tbSetting.nXyId = 0;
	self.tbSetting.nXy = 1;
	end
	

	
end

-- RegisterNewUiWindow

function tbSprBao_Setting:UpdateLable()
	local Phai = me.nFaction;
	local nNowDate 		= tonumber(GetLocalDate("%Y%m%d")); 
	local nOldDate 		= LinkTask:GetTask(LinkTask.TSK_DATE);
	local nQuestTime	= me.GetTask(LinkTask.TSKG_LINKTASK, LinkTask.TSK_NUM_PERDAY);
	if me.nFaction == 1 then Phai = "T.Lâm";
	elseif me.nFaction == 2 then Phai = "T.Vương";
	elseif me.nFaction == 3 then Phai = "Đ.Môn";
	elseif me.nFaction == 4 then Phai = "N.Độc";
	elseif me.nFaction == 5 then Phai = "N.My";
	elseif me.nFaction == 6 then Phai = "T.Yên";
	elseif me.nFaction == 7 then Phai = "C.Bang";
	elseif me.nFaction == 8 then Phai = "T.Nhẫn";
	elseif me.nFaction == 9 then Phai = "V.Đang";
	elseif me.nFaction == 10 then Phai = "C.Lôn";
	elseif me.nFaction == 11 then Phai = "M.Giáo";
	elseif me.nFaction == 12 then Phai = "Đ.Thị";
	end
	if nNowDate~=nOldDate then
		nQuestTime = 0;
	end
	Txt_SetTxt(self.UIGROUP, self.TXT_MAXCOUNT, "Số nhiệm vụ   [<color=yellow>"..(nQuestTime + 1).."<color>/<color=green>"..self.tbSetting.nMaxCount.."<color>]");
	Txt_SetTxt(self.UIGROUP, self.TXT_HP, "[<color=yellow>"..self.tbSetting.nHpLevel.."<color>]");
	Txt_SetTxt(self.UIGROUP, self.TXT_MP, "[<color=yellow>"..self.tbSetting.nMpLevel.."<color>]");
	Txt_SetTxt(self.UIGROUP, self.TXT_FOOD, "[<color=yellow>"..self.tbSetting.nFoodLevel.."<color>]");
	Txt_SetTxt(self.UIGROUP, self.TXT_HTP, "[<color=yellow>"..self.tbSetting.nHtpLevel.."<color>]");
	Txt_SetTxt(self.UIGROUP, self.TXT_ITEM, "Cấp ngũ hành  [<color=yellow>"..self.tbSetting.nItemLevel.."<color>]");
	Txt_SetTxt(self.UIGROUP, self.TXT_EQUIP, "Cấp phòng cụ  [<color=yellow>"..self.tbSetting.nEquipLevel.."<color>]");
	Txt_SetTxt(self.UIGROUP, self.TXT_WUMAX, "Cấp vũ khí        [<color=yellow>"..self.tbSetting.nWuMaxLevel.."<color>]");
	Txt_SetTxt(self.UIGROUP, self.TXT_SHOUMAX, "Cấp trang sức [<color=yellow>"..self.tbSetting.nShouMaxLevel.."<color>]");
	Txt_SetTxt(self.UIGROUP, self.TXT_XUANMIX, "Huyền Tinh > [<color=green>"..self.tbSetting.nXuanJingLevel.."<color>]");
	Txt_SetTxt(self.UIGROUP, self.TXT_EXP, "Kinh nghiệm > [<color=green>"..self.tbSetting.nExpLevel.."<color>]");
	Txt_SetTxt(self.UIGROUP, self.TXT_BIND, "Tiền > [<color=green>"..self.tbSetting.nBindLevel.."<color>]"); 
	Txt_SetTxt(self.UIGROUP, self.TXT_CANCEL, "Cơ hội hủy bỏ:  [<color=yellow>"..LinkTask:GetTask(3).."<color>/<color=green>"..self.tbSetting.nCancel.."<color>]");
	Txt_SetTxt(self.UIGROUP, self.TXT_NAME, "Nhân vật: <color=yellow>"..me.szName.."<color=yellow> ["..me.nLevel.."<color=yellow>] - "..Phai.."<color>");
	
	if self.tbSetting.nGuaJiMap == 0 then
		Txt_SetTxt(self.UIGROUP, self.TXT_GUAJIPOS, "<color=yellow>Tọa độ: <color=Black>[Chưa có]");
	else
		Txt_SetTxt(self.UIGROUP, self.TXT_MAP, string.format("<color=yellow>Bản đồ Luyện:<color=0,255,255> %s <color>",GetMapNameFormId(self.tbSetting.nGuaJiMap)));
		Txt_SetTxt(self.UIGROUP, self.TXT_GUAJIPOS, string.format("<color=yellow>Tọa độ: <color=0,255,255> [%s,%s]<color>",math.floor(self.tbSetting.nGuaJiX/8),math.floor(self.tbSetting.nGuaJiY/16)));
	end
	if (self.tbSetting.nGuaJiDX==0 or self.tbSetting.nGuaJiDY==0) and self.tbSetting.nGuaJiMap ~=0 then
		Txt_SetTxt(self.UIGROUP, self.TXT_OUTPOS, "<color=Black>[Tọa độ Phù tự động]");
	elseif self.tbSetting.nGuaJiMap	==0 then
		Txt_SetTxt(self.UIGROUP, self.TXT_OUTPOS, "<color=Black>[Chưa có]");
	else
		Txt_SetTxt(self.UIGROUP, self.TXT_OUTPOS, string.format("<color=yellow>Phù: <color=0,255,255> [%s,%s]<color>",math.floor(self.tbSetting.nGuaJiDX/8),math.floor(self.tbSetting.nGuaJiDY/16)));
	end
	
end

function tbSprBao_Setting:SetAwardLabel()
	Btn_SetTxt(self.UIGROUP,self.BTN_CITY,tbCity[self.tbSetting.nCity]);
	if self.tbSetting.nCity == 1 then self.tbSetting.nCityId = 23;
	elseif self.tbSetting.nCity == 2 then self.tbSetting.nCityId = 24;
	elseif self.tbSetting.nCity == 3 then self.tbSetting.nCityId = 25;
	elseif self.tbSetting.nCity == 4 then self.tbSetting.nCityId = 26;
	elseif self.tbSetting.nCity == 5 then self.tbSetting.nCityId = 27;
	elseif self.tbSetting.nCity == 6 then self.tbSetting.nCityId = 28;
	elseif self.tbSetting.nCity == 7 then self.tbSetting.nCityId = 29;
	elseif self.tbSetting.nCity == 8 then self.tbSetting.nCityId = 1;
	elseif self.tbSetting.nCity == 9 then self.tbSetting.nCityId = 2;
	elseif self.tbSetting.nCity == 10 then self.tbSetting.nCityId = 3;
	elseif self.tbSetting.nCity == 11 then self.tbSetting.nCityId = 4;
	elseif self.tbSetting.nCity == 12 then self.tbSetting.nCityId = 5;
	elseif self.tbSetting.nCity == 13 then self.tbSetting.nCityId = 6;
	elseif self.tbSetting.nCity == 14 then self.tbSetting.nCityId = 7;
	elseif self.tbSetting.nCity == 15 then self.tbSetting.nCityId = 8;
	end
	Btn_SetTxt(self.UIGROUP,self.BTN_MAPTRAIN,tbMapTrain[self.tbSetting.nMapTrain]);
	if self.tbSetting.nSetMapTrain == 1 then	
	if self.tbSetting.nMapTrain == 1 then 
	self.tbSetting.nGuaJiMap = 130;
	self.tbSetting.nGuaJiX = 1626;
	self.tbSetting.nGuaJiY = 3604;     ---OK
	self.tbSetting.nGuaJiDX = 1651;
	self.tbSetting.nGuaJiDY = 3554;   ---OK
	
	elseif self.tbSetting.nMapTrain == 2 then 
	self.tbSetting.nGuaJiMap = 131;
	self.tbSetting.nGuaJiX = 1852;
	self.tbSetting.nGuaJiY = 3240;     ---OK
	self.tbSetting.nGuaJiDX = 1817;
	self.tbSetting.nGuaJiDY = 3277;   ---OK
	
	elseif self.tbSetting.nMapTrain == 3 then 
	self.tbSetting.nGuaJiMap = 132;
	self.tbSetting.nGuaJiX = 1745;
	self.tbSetting.nGuaJiY = 3400;     ---OK
	self.tbSetting.nGuaJiDX = 1717;
	self.tbSetting.nGuaJiDY = 3362;   ---OK
	
	
	elseif self.tbSetting.nMapTrain == 4 then 
	self.tbSetting.nGuaJiMap = 133;
	self.tbSetting.nGuaJiX = 1672;
	self.tbSetting.nGuaJiY = 3728;     ---OK
	self.tbSetting.nGuaJiDX = 1698;
	self.tbSetting.nGuaJiDY = 3665;   ---OK
	
	
	elseif self.tbSetting.nMapTrain == 5 then 
	self.tbSetting.nGuaJiMap = 134;
	self.tbSetting.nGuaJiX = 1608;
	self.tbSetting.nGuaJiY = 3291;     ---OK
	self.tbSetting.nGuaJiDX = 1605;
	self.tbSetting.nGuaJiDY = 3347;   ---OK
	
	elseif self.tbSetting.nMapTrain == 6 then 
	self.tbSetting.nGuaJiMap = 135;
	self.tbSetting.nGuaJiX = 1678;
	self.tbSetting.nGuaJiY = 3423;     ---OK
	self.tbSetting.nGuaJiDX = 1636;
	self.tbSetting.nGuaJiDY = 3389;   ---OK
	
	elseif self.tbSetting.nMapTrain == 7 then 
	self.tbSetting.nGuaJiMap = 136;
	self.tbSetting.nGuaJiX = 1642;
	self.tbSetting.nGuaJiY = 3283;     ---OK
	self.tbSetting.nGuaJiDX = 1648;
	self.tbSetting.nGuaJiDY = 3224;   ---OK
	
	elseif self.tbSetting.nMapTrain == 8 then 
	self.tbSetting.nGuaJiMap = 137;
	self.tbSetting.nGuaJiX = 1978;
	self.tbSetting.nGuaJiY = 3327;     ---OK
	self.tbSetting.nGuaJiDX = 1938;
	self.tbSetting.nGuaJiDY = 3368;   ---OK
	
	elseif self.tbSetting.nMapTrain == 9 then 
	self.tbSetting.nGuaJiMap = 122;
	self.tbSetting.nGuaJiX = 1653;
	self.tbSetting.nGuaJiY = 3402;     ---OK
	self.tbSetting.nGuaJiDX = 1697;
	self.tbSetting.nGuaJiDY = 3382;   ---OK
	
	elseif self.tbSetting.nMapTrain == 10 then 
	self.tbSetting.nGuaJiMap = 123;
	self.tbSetting.nGuaJiX = 1764;
	self.tbSetting.nGuaJiY = 3603;     ---OK
	self.tbSetting.nGuaJiDX = 1813;
	self.tbSetting.nGuaJiDY = 3583;   ---OK
	
	elseif self.tbSetting.nMapTrain == 11 then 
	self.tbSetting.nGuaJiMap = 124;
	self.tbSetting.nGuaJiX = 1537;
	self.tbSetting.nGuaJiY = 3309;     ---OK
	self.tbSetting.nGuaJiDX = 1500;
	self.tbSetting.nGuaJiDY = 3271;   
	
	elseif self.tbSetting.nMapTrain == 12 then 
	self.tbSetting.nGuaJiMap = 125;
	self.tbSetting.nGuaJiX = 1872;
	self.tbSetting.nGuaJiY = 3616;     ---OK
	self.tbSetting.nGuaJiDX = 1863;
	self.tbSetting.nGuaJiDY = 3681;   ---OK
	
	elseif self.tbSetting.nMapTrain == 13 then 
	self.tbSetting.nGuaJiMap = 126;
	self.tbSetting.nGuaJiX = 1559;
	self.tbSetting.nGuaJiY = 3415;     ---OK
	self.tbSetting.nGuaJiDX = 1574;
	self.tbSetting.nGuaJiDY = 3490;   ---OK--
	
	elseif self.tbSetting.nMapTrain == 14 then  
	self.tbSetting.nGuaJiMap = 127;
	self.tbSetting.nGuaJiX = 1772;
	self.tbSetting.nGuaJiY = 2966;     ---OK
	self.tbSetting.nGuaJiDX = 1717;
	self.tbSetting.nGuaJiDY = 2950;   
	
	elseif self.tbSetting.nMapTrain == 15 then 
	self.tbSetting.nGuaJiMap = 128;
	self.tbSetting.nGuaJiX = 1779;
	self.tbSetting.nGuaJiY = 3286;     ---OK
	self.tbSetting.nGuaJiDX = 1835;
	self.tbSetting.nGuaJiDY = 3317;   ---OK
	
	elseif self.tbSetting.nMapTrain == 16 then 
	self.tbSetting.nGuaJiMap = 129;
	self.tbSetting.nGuaJiX = 1777;
	self.tbSetting.nGuaJiY = 3301;     ---OK
	self.tbSetting.nGuaJiDX = 1789;
	self.tbSetting.nGuaJiDY = 3367;   ---OK-
	
	elseif self.tbSetting.nMapTrain == 17 then 
	self.tbSetting.nGuaJiMap = 114;
	self.tbSetting.nGuaJiX = 1718;
	self.tbSetting.nGuaJiY = 3308;     ---OK
	self.tbSetting.nGuaJiDX = 1669;
	self.tbSetting.nGuaJiDY = 3322;   
	
	elseif self.tbSetting.nMapTrain == 18 then 
	self.tbSetting.nGuaJiMap = 115;
	self.tbSetting.nGuaJiX = 1675;
	self.tbSetting.nGuaJiY = 2929;     ---OK
	self.tbSetting.nGuaJiDX = 1661;
	self.tbSetting.nGuaJiDY = 2990;   ---OK
	
	elseif self.tbSetting.nMapTrain == 19 then 
	self.tbSetting.nGuaJiMap = 116;
	self.tbSetting.nGuaJiX = 1758;
	self.tbSetting.nGuaJiY = 3776;     ---OK
	self.tbSetting.nGuaJiDX = 1765;
	self.tbSetting.nGuaJiDY = 3700;   ---OK---
	
	elseif self.tbSetting.nMapTrain == 20 then 
	self.tbSetting.nGuaJiMap = 117;
	self.tbSetting.nGuaJiX = 1675;
	self.tbSetting.nGuaJiY = 2969;     ---OK
	self.tbSetting.nGuaJiDX = 1675;
	self.tbSetting.nGuaJiDY = 2908;   
	
	elseif self.tbSetting.nMapTrain == 21 then 
	self.tbSetting.nGuaJiMap = 118;
	self.tbSetting.nGuaJiX = 1733;
	self.tbSetting.nGuaJiY = 3770;     ---OK
	self.tbSetting.nGuaJiDX = 1697;
	self.tbSetting.nGuaJiDY = 3813;   ---OK
	
	elseif self.tbSetting.nMapTrain == 22 then 
	self.tbSetting.nGuaJiMap = 119;
	self.tbSetting.nGuaJiX = 1549;
	self.tbSetting.nGuaJiY = 3548;     ---OK
	self.tbSetting.nGuaJiDX = 1592;
	self.tbSetting.nGuaJiDY = 3521;   ---OK---
	
	elseif self.tbSetting.nMapTrain == 23 then 
	self.tbSetting.nGuaJiMap = 120;
	self.tbSetting.nGuaJiX = 1651;
	self.tbSetting.nGuaJiY = 3506;     ---OK
	self.tbSetting.nGuaJiDX = 1673;
	self.tbSetting.nGuaJiDY = 3449;   ---OK
	
	elseif self.tbSetting.nMapTrain == 24 then 
	self.tbSetting.nGuaJiMap = 121;
	self.tbSetting.nGuaJiX = 1570;
	self.tbSetting.nGuaJiY = 3101;     ---OK
	self.tbSetting.nGuaJiDX = 1539;
	self.tbSetting.nGuaJiDY = 3039;   ---OK---
	
	elseif self.tbSetting.nMapTrain == 25 then 
	self.tbSetting.nGuaJiMap = 107;
	self.tbSetting.nGuaJiX = 1908;
	self.tbSetting.nGuaJiY = 3478;     ---OK
	self.tbSetting.nGuaJiDX = 1934;
	self.tbSetting.nGuaJiDY = 3425;   
	
	elseif self.tbSetting.nMapTrain == 26 then 
	self.tbSetting.nGuaJiMap = 108;
	self.tbSetting.nGuaJiX = 1924;
	self.tbSetting.nGuaJiY = 3023;     ---OK
	self.tbSetting.nGuaJiDX = 1891;
	self.tbSetting.nGuaJiDY = 3004;   ---OK
	
	elseif self.tbSetting.nMapTrain == 27 then 
	self.tbSetting.nGuaJiMap = 109;
	self.tbSetting.nGuaJiX = 1620;
	self.tbSetting.nGuaJiY = 3660;     ---OK
	self.tbSetting.nGuaJiDX = 1602;
	self.tbSetting.nGuaJiDY = 3605;   ---OK---
	
	elseif self.tbSetting.nMapTrain == 28 then 
	self.tbSetting.nGuaJiMap = 110;
	self.tbSetting.nGuaJiX = 1471;
	self.tbSetting.nGuaJiY = 3033;     ---OK
	self.tbSetting.nGuaJiDX = 1447;
	self.tbSetting.nGuaJiDY = 2973;   ---OK
	
	elseif self.tbSetting.nMapTrain == 29 then 
	self.tbSetting.nGuaJiMap = 111;
	self.tbSetting.nGuaJiX = 1768;
	self.tbSetting.nGuaJiY = 3418;     ---OK
	self.tbSetting.nGuaJiDX = 1815;
	self.tbSetting.nGuaJiDY = 3415;   ---OK---
	
	elseif self.tbSetting.nMapTrain == 30 then 
	self.tbSetting.nGuaJiMap = 112;
	self.tbSetting.nGuaJiX = 1807;
	self.tbSetting.nGuaJiY = 3518;     ---OK
	self.tbSetting.nGuaJiDX = 1805;
	self.tbSetting.nGuaJiDY = 3453;   
	
	elseif self.tbSetting.nMapTrain == 31 then 
	self.tbSetting.nGuaJiMap = 113;
	self.tbSetting.nGuaJiX = 1773;
	self.tbSetting.nGuaJiY = 3522;     ---OK
	self.tbSetting.nGuaJiDX = 1815;
	self.tbSetting.nGuaJiDY = 3502;   ---OK
	

	elseif self.tbSetting.nMapTrain == 32 then  
	self.tbSetting.nGuaJiMap = 100;
	self.tbSetting.nGuaJiX = 1700;
	self.tbSetting.nGuaJiY = 3243;     ---OK
	self.tbSetting.nGuaJiDX = 1749;
	self.tbSetting.nGuaJiDY = 3186;   ---OK
	
	elseif self.tbSetting.nMapTrain == 33 then 
	self.tbSetting.nGuaJiMap = 101;
	self.tbSetting.nGuaJiX = 1828;
	self.tbSetting.nGuaJiY = 3593;     ---OK
	self.tbSetting.nGuaJiDX = 1875;
	self.tbSetting.nGuaJiDY = 3551;   ---OK
	
	elseif self.tbSetting.nMapTrain == 34 then 
	self.tbSetting.nGuaJiMap = 102;
	self.tbSetting.nGuaJiX = 1599;
	self.tbSetting.nGuaJiY = 2772;     ---OK
	self.tbSetting.nGuaJiDX = 1604;
	self.tbSetting.nGuaJiDY = 2722;   ---OK
	
	elseif self.tbSetting.nMapTrain == 35 then 
	self.tbSetting.nGuaJiMap = 103;
	self.tbSetting.nGuaJiX = 1632;
	self.tbSetting.nGuaJiY = 3323;     ---OK
	self.tbSetting.nGuaJiDX = 1681;
	self.tbSetting.nGuaJiDY = 3303;   ---OK
	
	elseif self.tbSetting.nMapTrain == 36 then 
	self.tbSetting.nGuaJiMap = 104;
	self.tbSetting.nGuaJiX = 1562;
	self.tbSetting.nGuaJiY = 3502;     ---OK
	self.tbSetting.nGuaJiDX = 1606;
	self.tbSetting.nGuaJiDY = 3473;   ---OK
	
	elseif self.tbSetting.nMapTrain == 37 then 
	self.tbSetting.nGuaJiMap = 105;
	self.tbSetting.nGuaJiX = 1537;
	self.tbSetting.nGuaJiY = 3294;     ---OK
	self.tbSetting.nGuaJiDX = 1589;
	self.tbSetting.nGuaJiDY = 3246;   ---OK
	
	elseif self.tbSetting.nMapTrain == 38 then 
	self.tbSetting.nGuaJiMap = 106;
	self.tbSetting.nGuaJiX = 1733;
	self.tbSetting.nGuaJiY = 3337;     ---OK
	self.tbSetting.nGuaJiDX = 1770;
	self.tbSetting.nGuaJiDY = 3351;   ---OK
	
	end
	end	
	Btn_SetTxt(self.UIGROUP,self.BTN_HPLV,tbHPLv[self.tbSetting.nHPLv]);        
	if self.tbSetting.nHPLv == 1 then self.tbSetting.nHPLvId = 1;
	elseif self.tbSetting.nHPLv == 2 then self.tbSetting.nHPLvId = 2;
	elseif self.tbSetting.nHPLv == 3 then self.tbSetting.nHPLvId = 3;
	elseif self.tbSetting.nHPLv == 4 then self.tbSetting.nHPLvId = 4;
	elseif self.tbSetting.nHPLv == 5 then self.tbSetting.nHPLvId = 5;
	end
	Btn_SetTxt(self.UIGROUP,self.BTN_XY,tbXY[self.tbSetting.nXy]);        
	if self.tbSetting.nXy == 1 then self.tbSetting.nXyId = 0;
	elseif self.tbSetting.nXy == 2 then self.tbSetting.nXyId = 1;
	end
	if me.nFaction == 12 and (me.IsHaveSkill(226) == 1 or me.IsHaveSkill(227) == 1 or me.IsHaveSkill(229) == 1 or me.IsHaveSkill(232) == 1) then   
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbDoanThi1[self.tbSetting.nSetskill]);
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 3000;	
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 226;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 229;
		elseif self.tbSetting.nSetskill == 4 then self.tbSetting.nSetskillId = 232;
		end
	elseif me.nFaction == 12 and (me.IsHaveSkill(213) == 1 or me.IsHaveSkill(217) == 1 or me.IsHaveSkill(223) == 1) then   
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbDoanThi2[self.tbSetting.nSetskill]);
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 213;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 217;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 223;
		end	
	end	
	if me.nFaction == 5 and (me.IsHaveSkill(107) == 1 or me.IsHaveSkill(837) == 1) then 
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbNgaMy1[self.tbSetting.nSetskill]);        
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 107;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 837;
		end
	elseif me.nFaction == 5 and (me.IsHaveSkill(96) == 1 or me.IsHaveSkill(99) == 1 or me.IsHaveSkill(103) == 1) then
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbNgaMy2[self.tbSetting.nSetskill]); 
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 96;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 99;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 103;
		end
	end
	if me.nFaction == 9  and  (me.IsHaveSkill(159) == 1 or me.IsHaveSkill(162) == 1 or me.IsHaveSkill(165) == 1) then
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbVD1[self.tbSetting.nSetskill]); 
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 159;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 162;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 165;
		end
	elseif me.nFaction == 9  and  (me.IsHaveSkill(167) == 1 or me.IsHaveSkill(169) == 1 or me.IsHaveSkill(171) == 1) then
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbVD2[self.tbSetting.nSetskill]); 
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 167;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 169;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 171;
		end	
	end	
	
	if me.nFaction == 2 and (me.IsHaveSkill(38) == 1 or me.IsHaveSkill(43) == 1 or me.IsHaveSkill(47) == 1) then  
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbTVB1[self.tbSetting.nSetskill]); 
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 38;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 43;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 47;
		end
	elseif me.nFaction == 2 and (me.IsHaveSkill(52) == 1 or me.IsHaveSkill(50) == 1 or me.IsHaveSkill(53) == 1 or me.IsHaveSkill(56) == 1) then
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbTVB2[self.tbSetting.nSetskill]); 
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 50;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 53;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 56;
		end
	end
	if me.nFaction == 10 and (me.IsHaveSkill(175) == 1 or me.IsHaveSkill(178) == 1 or me.IsHaveSkill(181) == 1) then
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbCL1[self.tbSetting.nSetskill]); 
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 175;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 178;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 181;
		end
	elseif me.nFaction == 10 and (me.IsHaveSkill(188) == 1 or me.IsHaveSkill(190) == 1 or me.IsHaveSkill(192) == 1) then   
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbCL2[self.tbSetting.nSetskill]); 
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 188;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 190;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 192;
		end
	end
	if me.nFaction == 1 and (me.IsHaveSkill(21) == 1 or me.IsHaveSkill(24) == 1 or me.IsHaveSkill(27) == 1) then
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbTL1[self.tbSetting.nSetskill]); 
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 21;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 24;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 27;
		end
	elseif me.nFaction == 1 and (me.IsHaveSkill(29) == 1 or me.IsHaveSkill(33) == 1 or me.IsHaveSkill(36) == 1) then    
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbTL2[self.tbSetting.nSetskill]); 
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 29;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 33;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 36;
		end
	end
	if me.nFaction == 11 and (me.IsHaveSkill(194) == 1 or me.IsHaveSkill(198) == 1 or me.IsHaveSkill(202) == 1) then  
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbMG1[self.tbSetting.nSetskill]); 
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 194;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 198;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 202;
		end
	elseif me.nFaction == 11 and (me.IsHaveSkill(205) == 1 or me.IsHaveSkill(208) == 1 or me.IsHaveSkill(211) == 1) then    
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbMG2[self.tbSetting.nSetskill]); 
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 205;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 208;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 211;
		end
	end
	if me.nFaction == 3 and (me.IsHaveSkill(59) == 1 or me.IsHaveSkill(62) == 1 or me.IsHaveSkill(66) == 1) then   
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbDM1[self.tbSetting.nSetskill]); 
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 59;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 62;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 66;
		end
	elseif me.nFaction == 3 and (me.IsHaveSkill(69) == 1 or me.IsHaveSkill(72) == 1 or me.IsHaveSkill(73) == 1 or me.IsHaveSkill(74) == 1) then 
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbDM2[self.tbSetting.nSetskill]); 
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 69;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 72;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 73;
		elseif self.tbSetting.nSetskill == 4 then self.tbSetting.nSetskillId = 74;
		end
	end
	if me.nFaction == 6 and (me.IsHaveSkill(111) == 1 or me.IsHaveSkill(114) == 1 or me.IsHaveSkill(117) == 1) then 
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbTY1[self.tbSetting.nSetskill]); 
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 111;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 114;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 117;
		end
	elseif me.nFaction == 6 and (me.IsHaveSkill(120) == 1 or me.IsHaveSkill(123) == 1 or me.IsHaveSkill(125) == 1) then
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbTY2[self.tbSetting.nSetskill]); 
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 120;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 123;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 125;
		end
	end
	
	if me.nFaction == 7 and (me.IsHaveSkill(128) == 1 or me.IsHaveSkill(131) == 1 or me.IsHaveSkill(134) == 1) then  
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbCB1[self.tbSetting.nSetskill]); 
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 2000;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 128;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 131;
		elseif self.tbSetting.nSetskill == 4 then self.tbSetting.nSetskillId = 134;
		end
	elseif me.nFaction == 7 and (me.IsHaveSkill(137) == 1 or me.IsHaveSkill(140) == 1 or me.IsHaveSkill(141) == 1) then     
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbCB2[self.tbSetting.nSetskill]); 
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 137;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 140;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 141;
		end
	end
	if me.nFaction == 8 and (me.IsHaveSkill(143) == 1 or me.IsHaveSkill(146) == 1 or me.IsHaveSkill(149) == 1) then
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbTN1[self.tbSetting.nSetskill]); 
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 143;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 146;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 149;
		end
	elseif me.nFaction == 8 and (me.IsHaveSkill(151) == 1 or me.IsHaveSkill(153) == 1 or me.IsHaveSkill(156) == 1) then     
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbTN2[self.tbSetting.nSetskill]); 
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 151;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 153;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 156;
		end
	end
	
	if me.nFaction == 4 and (me.IsHaveSkill(86) == 1 or me.IsHaveSkill(90) == 1 or me.IsHaveSkill(93) == 1) then
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbND1[self.tbSetting.nSetskill]); 
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 86;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 90;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 93;
		end
	elseif me.nFaction == 4 and (me.IsHaveSkill(76) == 1 or me.IsHaveSkill(80) == 1 or me.IsHaveSkill(83) == 1) then     
		Btn_SetTxt(self.UIGROUP,self.BTN_SETSKILL,tbND2[self.tbSetting.nSetskill]); 
		if self.tbSetting.nSetskill == 1 then self.tbSetting.nSetskillId = 76;
		elseif self.tbSetting.nSetskill == 2 then self.tbSetting.nSetskillId = 80;
		elseif self.tbSetting.nSetskill == 3 then self.tbSetting.nSetskillId = 83;
		end
	end
	
	Btn_SetTxt(self.UIGROUP,self.BTN_MPLV,tbMPLv[self.tbSetting.nMPLv]);        
	if self.tbSetting.nMPLv == 1 then
	self.tbSetting.nMPLvId1 = 2;
	self.tbSetting.nMPLvId = 1;
	elseif self.tbSetting.nMPLv == 2 then
	self.tbSetting.nMPLvId1 = 2;	
	self.tbSetting.nMPLvId = 2;
	elseif self.tbSetting.nMPLv == 3 then
	self.tbSetting.nMPLvId1 = 2;	
	self.tbSetting.nMPLvId = 3;
	elseif self.tbSetting.nMPLv == 4 then
	self.tbSetting.nMPLvId1 = 2;	
	self.tbSetting.nMPLvId = 4;
	elseif self.tbSetting.nMPLv == 5 then
	self.tbSetting.nMPLvId1 = 2;	
	self.tbSetting.nMPLvId = 5;
	elseif self.tbSetting.nMPLv == 6 then
	self.tbSetting.nMPLvId1 = 3;
	self.tbSetting.nMPLvId = 1;
	elseif self.tbSetting.nMPLv == 7 then
	self.tbSetting.nMPLvId1 = 3;	
	self.tbSetting.nMPLvId = 2;
	elseif self.tbSetting.nMPLv == 8 then
	self.tbSetting.nMPLvId1 = 3;	
	self.tbSetting.nMPLvId = 3;
	elseif self.tbSetting.nMPLv == 9 then
	self.tbSetting.nMPLvId1 = 3;	
	self.tbSetting.nMPLvId = 4;
	elseif self.tbSetting.nMPLv == 10 then
	self.tbSetting.nMPLvId1 = 3;	
	self.tbSetting.nMPLvId = 5;
	end	
	
	Btn_SetTxt(self.UIGROUP,self.BTN_AWARDFIRST,tbAwardMenu[self.tbSetting.nAwardFirst]);
	Btn_SetTxt(self.UIGROUP,self.BTN_AWARDSECOND,tbAwardMenu[self.tbSetting.nAwardSecond]);
	Btn_SetTxt(self.UIGROUP,self.BTN_AWARDTHIRD,tbAwardMenu[self.tbSetting.nAwardThird]);
	
end

function tbSprBao_Setting:OnClose()
	local szMySafe = Edt_GetTxt(self.UIGROUP, EDIT_CONTENT_SAFE);
	KFile.WriteFile("\\user\\sprBao\\Remote.lua", szMySafe);
end	

Ui:RegisterNewUiWindow("UI_SPRBAO_SETTING", "SprBao_setting", {"a", 200, 66}, {"b", 515, 200}, {"c", 770, 240});

function tbSprBao_Setting:Save(szKey, tbData)
	self.m_szFilePath="\\user\\sprBao\\"..me.szName.."_setting.dat";
	self.m_tbData = {};
	self.m_tbData[szKey] = tbData;
	print(tbData);
	local szData = Lib:Val2Str(self.m_tbData);
	assert(self.m_szFilePath);
	if self:CheckErrorData(szData) == 1 then
		KIo.WriteFile(self.m_szFilePath, szData);
	else
		local szSaveData = Lib:Val2Str(tbData);
	end
end

-- 
function tbSprBao_Setting:Load(key)
	self.m_szFilePath="\\user\\sprBao\\"..me.szName.."_setting.dat";
	self.m_tbData = {};
	print(key);
	local szData = KIo.ReadTxtFile(self.m_szFilePath);
	if (szData) then
		if self:CheckErrorData(szData) == 1 then		-- 
			self.m_tbData = Lib:Str2Val(szData);
		else
			KIo.WriteFile(self.m_szFilePath, "");
		end
	end
	local tbData = self.m_tbData[key];
	print(self.m_tbData);
	return tbData;
end

function tbSprBao_Setting:CheckErrorData(szDate)
	if szDate ~= "" then
		if string.find(szDate, "Ptr:") and string.find(szDate, "ClassName:") then
			return 0;
		end
		if (not Lib:CallBack({"Lib:Str2Val", szDate})) then	-- 
			return 0;
		end
	end
	return 1;
end

local szCmd = [=[
	Ui:GetClass("SprBao_setting"):Reload();
	]=];
	UiShortcutAlias:AddAlias("", szCmd);	-- Ctrl + 

local szCmd = [=[
	UiManager:SwitchWindow(Ui.UI_SPRBAO_SETTING);
	]=];
	UiShortcutAlias:AddAlias("", szCmd);	-- Alt + 
