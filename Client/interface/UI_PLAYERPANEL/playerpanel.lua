-------------------------------------------------------------------
-- F1 nâng cao
-------------------------------------------------------------------
local tbPlayerPanel = Ui(Ui.UI_PLAYERPANEL);
local self 					= tbPlayerPanel;
----------------------------
local BTN_REPAIRJX_ALL     	= "BtnRepairJxAll";
local BTN_VALUE				= "BtnEquipValue"
-------------------------
local PAGE_EDITBLOG			= "BtnEditBlog";
local BTN_CLOSE				= "BtnClose";
local BTN_SWITCH			= "BtnSwitch";
local BTN_BASIC_ASSAUTO		= "BtnBasicAssignAuto";
local BTN_BASIC_ASSOK		= "BtnBasicAssignOK";
local BTN_BASIC_ASSCANCEL	= "BtnBasicAssignCancel";
local BTN_BASIC_INCSTR		= "BtnBasicIncStr";	
local BTN_BASIC_DECSTR		= "BtnBasicDecStr";	
local BTN_BASIC_INCDEX		= "BtnBasicIncDex";		
local BTN_BASIC_DECDEX		= "BtnBasicDecDex";		
local BTN_BASIC_INCVIT		= "BtnBasicIncVit";			
local BTN_BASIC_DECVIT		= "BtnBasicDecVit";			
local BTN_BASIC_INCENG		= "BtnBasicIncEng";			
local BTN_BASIC_DECENG		= "BtnBasicDecEng";			
local BTN_SEL_PORTRAIT		= "BtnSelPortrait";			
local IMG_PLAYER_PORTRAIT	= "ImgPortrait";		
local BTN_ACTIVE_TITLE		= "BtnActiveTitle";		
local BTN_INACTIVE_TITLE	= "BtnInactiveTitle";		
local BTN_EQUIP_PAGE		= "BtnEquipPage";		
local BTN_SWITCH_EQUIP		= "BtnSwitchEquip";	
local EDIT_BASIC_STR		= "EdtBasicStr";
local EDIT_BASIC_DEX		= "EdtBasicDex";
local EDIT_BASIC_VIT		= "EdtBasicVit";
local EDIT_BASIC_ENG		= "EdtBasicEng";
local BTN_HONOR 			= "BtnHistory";		
local OUTLOOK_REPUTE		= "OutLookRepute";	
local OUTLOOK_TITLE 		= "OutLookTitle";
local OUTLOOK_HISTORY		= "OutLookHistory";	
local OBJ_EQUIP_PREVIEW		= "ObjPreview";
local BTN_FIGHTPOWER		= "BtnFightPower";    
-----------------------BLOG
local BTN_BLOGCLOSE								= "BtnEditBlogCancel";
local EDT_EDITBLOGNAME							= "EdtEditBlogName";
local EDT_EDITBLOGMONICKER						= "EdtEditBlogMonicker";
local EDT_EDITBLOGOCCUPATION					= "EdtEditBlogOccupation";
local CMB_EDITBLOGSEX							= "ComboBoxEdtEditBlogSex";
local EDT_EDITBLOGTAG							= "EdtEditBlogTag";
local BTN_EDITBLOGFRIENDONLY					= "BtnEditBlogFriendOnly";
local EDT_EDITBLOGBIRTHDAY						= "EdtEditBlogBirthday";
local EDT_EDITBLOGCITY							= "EdtEditBlogCity";
local CMB_EDITBLOGMARRIAGE						= "ComboBoxFatherEditBlog";
local EDT_EDITBLOGLIKE							= "EdtEditBlogLike";
local BTN_EDITBLOGEditBLOG						= "BtnEditBlogEditBlog";
local EDT_EDITBLOGEditBLOG						= "EdtEditBlogEditBlog";
local EDT_EDITBLOGDIANDI						= "EdtEditBlogDianDi";
local BTN_EDITBLOGLINGCHEN						= "BtnEditBlogLingchen";
local BTN_EDITBLOGSHANGWU						= "BtnEditBlogShangwu";
local BTN_EDITBLOGZHONGWU						= "BtnEditBlogZhongwu";
local BTN_EDITBLOGXIAWU			  				= "BtnEditBlogXiawu";
local BTN_EDITBLOGWANSHANG						= "BtnEditBlogWanshang";
local BTN_EDITBLOGWUYE							= "BtnEditBlogWuye";
local	BTN_EDITBLOGSAVE						= "BtnEditBlogSave";
local	CMB_YEAR								= "ComboBoxYearEditBlog";
local	CMB_MONTH								= "ComboBoxMonthEditBlog";
local	CMB_DATE								= "ComboBoxDateEditBlog";

function tbPlayerPanel:OnButtonClick(szWnd, nParam)
	if (BTN_CLOSE == szWnd or BTN_BLOGCLOSE == szWnd) then	
		UiManager:CloseWindow(self.UIGROUP);
	elseif (BTN_REPAIRJX_ALL == szWnd) then -- sửa kim tê
		Ui(Ui.UI_PLAYERPANEL):RepairJxAll();
	elseif (BTN_VALUE == szWnd) then        -- tài phú
		UiManager:OpenWindow(Ui.UI_VIEWWEALTHVALUE);
	elseif (BTN_SWITCH == szWnd) then		
		self:OnSwitch();
	elseif (BTN_SEL_PORTRAIT == szWnd) then	
		OnSelPortrait();
	elseif (BTN_BASIC_ASSAUTO == szWnd) then	
		self:OnAutoAssign();
	elseif (BTN_BASIC_ASSOK == szWnd) then	
		self:OnSubmitAssign();
	elseif (BTN_BASIC_ASSCANCEL == szWnd) then		
		self:OnCancelAssign();
	elseif (BTN_BASIC_INCSTR == szWnd) then		
		self:OnIncrease(Player.ATTRIB_STR);
	elseif (BTN_BASIC_DECSTR == szWnd) then		
		self:OnDecrease(Player.ATTRIB_STR);
	elseif (BTN_BASIC_INCDEX == szWnd) then		
		self:OnIncrease(Player.ATTRIB_DEX);
	elseif (BTN_BASIC_DECDEX == szWnd) then		
		self:OnDecrease(Player.ATTRIB_DEX);
	elseif (BTN_BASIC_INCVIT == szWnd) then
		self:OnIncrease(Player.ATTRIB_VIT);
	elseif (BTN_BASIC_DECVIT == szWnd) then	
		self:OnDecrease(Player.ATTRIB_VIT);
	elseif (BTN_BASIC_INCENG == szWnd) then	
		self:OnIncrease(Player.ATTRIB_ENG);
	elseif (BTN_BASIC_DECENG == szWnd) then	
		self:OnDecrease(Player.ATTRIB_ENG);
	elseif (BTN_ACTIVE_TITLE == szWnd) then	
		self:OnActiveTitle();
	elseif (BTN_INACTIVE_TITLE	== szWnd) then
		self:OnInactiveTitle();
	elseif (BTN_EQUIP_PAGE == szWnd) then
		self:SwitchEquipPage()
	elseif (BTN_SWITCH_EQUIP == szWnd) then
		self:ApplySwitchEquip()
	elseif (BTN_HONOR	== szWnd) then
		self:OnRequestHonorData();
		self:OnUpdatePageHistory();
	elseif (BTN_EDITBLOGEditBLOG == szWnd) then
		local tbBlogMsg = {};
		tbBlogMsg.szMsg = "Nhắc: Trình duyệt của bạn sẽ tự đăng nhập trang này, cẩn thận với virus Trojan!";	
		tbBlogMsg.nOptCount = 2;
		local blogUrl = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGEditBLOG);
		function tbBlogMsg:Callback(nOptIndex, szUrl)
			if (nOptIndex == 2) then
				ShellExecute(szUrl);
			end
		end		
		if (blogUrl ~= nil and blogUrl ~= "") then
			UiManager:OpenWindow(Ui.UI_MSGBOX, tbBlogMsg, blogUrl);		
		end
	elseif (PAGE_EDITBLOG == szWnd) then
		UiManager.bEditBlogState = 1;
		PProfile:Require(me.szName);
	elseif (BTN_EDITBLOGSAVE == szWnd) then
	
		local szName = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGNAME);
	 	local szBlogMonicker = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGMONICKER);
		local szFaction = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGOCCUPATION);
		local szCity = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGCITY);
		local szBlogTag = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGTAG);
		local szLike = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGLIKE);
		local szBlogBlog = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGEditBLOG);
		local szDianDi = Edt_GetTxt(self.UIGROUP, EDT_EDITBLOGDIANDI);
		local lingChen = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGLINGCHEN);
		local shangWu = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGSHANGWU);
		local zhongWu = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGZHONGWU);
		local xiaWu = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGXIAWU);
		local wanShang = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGWANSHANG);
		local wuYe = Btn_GetCheck(self.UIGROUP, BTN_EDITBLOGWUYE);	
		local nOnlineTime = KPProfile.BoolOffset(lingChen, shangWu, zhongWu, xiaWu, wanShang, wuYe);	
		if (szName ~= nil and szName ~= "" and
				szBlogMonicker ~= nil and szBlogMonicker ~= "" and
				szFaction ~= nil and szFaction ~= "" and
				szCity ~= nil and szCity ~= "" and
				szBlogTag ~= nil and szBlogTag ~= "" and
				szLike ~= nil and szLike ~= "" and szLike ~= "(Hãy ghi sở thích của bạn!)" and
				szBlogBlog ~= nil and szBlogBlog ~= ""  and
				szDianDi ~= nil and szDianDi ~= "" and szDianDi ~=  string.format("Nhắc nhở: Lần đầu điền thông tin sẽ nhận được 100 %s khóa!", IVER_g_szCoinName) and
				nOnlineTime ~= nil and nOnlineTime ~= 0) then	
			if (self.bFirst == 0) then				
				self:ApplyAllBlogInfo();
			else
				self:ApplyBlogInfo();
			end
		else
			local tbApplyMsg = {};
			tbApplyMsg.szMsg = "Nội dung không đúng, không lưu được.";	
			tbApplyMsg.nOptCount = 1;
			UiManager:OpenWindow(Ui.UI_MSGBOX, tbApplyMsg);		
		end	
    elseif (BTN_FIGHTPOWER == szWnd) then        
        if (1 == Player.tbFightPower:IsFightPowerValid()) then
				UiManager:SwitchWindow(Ui.UI_FIGHTPOWER);
			else
				Ui:ServerCall("UI_TASKTIPS", "Begin", "Hệ thống sức chiến đấu chưa mở, xin hãy đợi");
			end
	end	
end
-- Bảng Danh Vọng
 tbPlayerPanel.OnUpdatePageRepute=function(self)
	self:UpdateReputeName();
	local tbSet = self.tbReputeSetting;
	if (not tbSet) then
		return;
	end
	OutLookPanelClearAll(self.UIGROUP, OUTLOOK_REPUTE);
	AddOutLookPanelColumnHeader(self.UIGROUP, OUTLOOK_REPUTE, "");
	AddOutLookPanelColumnHeader(self.UIGROUP, OUTLOOK_REPUTE, "");
	AddOutLookPanelColumnHeader(self.UIGROUP, OUTLOOK_REPUTE, "");
	SetOutLookHeaderWidth(self.UIGROUP, OUTLOOK_REPUTE, 0, 100);
	SetOutLookHeaderWidth(self.UIGROUP, OUTLOOK_REPUTE, 1, 60);
	SetOutLookHeaderWidth(self.UIGROUP, OUTLOOK_REPUTE, 2, 100);
	
	AddOutLookGroup(self.UIGROUP, OUTLOOK_REPUTE, "<color=green>Danh vọng cá nhân");
	AddOutLookGroup(self.UIGROUP, OUTLOOK_REPUTE, "<color=blue>Hoạt động");

	for i = 1, #tbSet do
		for j = 1, #tbSet[i] do
			local nLevel = me.GetReputeLevel(i, j);
			if (nLevel) then
				local tbItemContent = {};
				tbItemContent[1] = tbSet[i][j].szName;
				tbItemContent[2] = tbSet[i][j][nLevel].szName.." ["..nLevel.."]";
				if (#tbSet[i][j] == nLevel) then
					tbItemContent[3] = "            [Cấp cao nhất]";
				else
					tbItemContent[3] = "            "..me.GetReputeValue(i, j, nLevel).."/"..tbSet[i][j][nLevel].nLevelUp;
				end
				if nLevel == 1 and me.GetReputeValue(i, j, nLevel) == 0 then
					local nRet = AddOutLookItem(self.UIGROUP, OUTLOOK_REPUTE, 1, tbItemContent);
				else
					local nRet = AddOutLookItem(self.UIGROUP, OUTLOOK_REPUTE, 0, tbItemContent);
				end
			end
		end
	end


	Wnd_SetEnable(self.UIGROUP, BTN_ACTIVE_TITLE,	0);
	Wnd_SetEnable(self.UIGROUP, BTN_INACTIVE_TITLE,	0);

end

---sửa = kim tê
function tbPlayerPanel:RepairJxAll()
	AutoAi:RepairAll()
	return 1
end

function tbPlayerPanel:UpdateFightPower(nPower)
	nPower = math.floor(nPower * 100) / 100;
	local szFightPower = string.format("Sức chiến đấu: %g", nPower);
	Btn_SetTxt(self.UIGROUP, BTN_FIGHTPOWER, szFightPower);
end

LoadUiGroup(Ui.UI_PLAYERPANEL,"playerpanel.ini");

