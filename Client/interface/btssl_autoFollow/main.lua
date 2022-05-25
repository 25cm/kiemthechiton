Ui.UI_AUTOAIM_UI		= "UI_AUTOAIM_UI";
local uiAutoAimUi		= Ui.tbWnd[Ui.UI_AUTOAIM_UI] or {};
uiAutoAimUi.UIGROUP		= Ui.UI_AUTOAIM_UI;
Ui.tbWnd[Ui.UI_AUTOAIM_UI] 	= uiAutoAimUi;
uiAutoAimUi.BTN_CLOSE		  = "BtnClose";
uiAutoAimUi.PAGESET_MAIN	= "PageSetMain";
uiAutoAimUi.PAGE_ONE		  = "PageOne";
uiAutoAimUi.BTN_REKEY		  = "BtnKeyReload";
uiAutoAimUi.BTN_DEKEY		  = "BtnKeyDefault";
uiAutoAimUi.BTN_EXIT		  = "BtnExit";
uiAutoAimUi.BTN_SHOWPAGE1	= "BtnShowOne";
uiAutoAimUi.BTN_SHOWPAGE2	= "BtnShowTwo";
uiAutoAimUi.BTN_SHOWPAGE3	= "BtnShowThree";
uiAutoAimUi.BTN_AUTOYAO		= "BtnAutoYao";
uiAutoAimUi.TXT_YAODELAY	= "YaoDelay";
uiAutoAimUi.TXT_LIFE		  = "YaoLife";
uiAutoAimUi.TXT_MANA		  = "YaoMana";
uiAutoAimUi.BTN_PICKUP		= "BtnPickUp";
uiAutoAimUi.TEAM_MEMBER_LIST	= "LstTeamMember";
uiAutoAimUi.TXT_TEAM		  = "TxtP1-4";
uiAutoAimUi.BTN_SUFOLLOW	= "BtnSuperFollow";
uiAutoAimUi.BTN_NMATTACK_MONSTER	= "BtnNMAttackMonster";
uiAutoAimUi.TXT_FOLLOW		= "TextFollow";
uiAutoAimUi.BTN_AUTOEAT		= "BtnAutoEat";
uiAutoAimUi.TXT_HEALDELAY	= "HealDelay";
uiAutoAimUi.BTN_GATHER	= "BtnGather";
uiAutoAimUi.BTN_STONE		= "BtnStone";
uiAutoAimUi.BTN_FIRE		= "BtnFire";
uiAutoAimUi.TXT_FIRE		= "TxtFire";
uiAutoAimUi.BTN_SHOW_TWO	= "BtnShowTwo";
uiAutoAimUi.TXT1_KEY	= {
	"Txt1Key1";
	"Txt1Key2";
	"Txt1Key3";
	"Txt1Key4";
	"Txt1Key5";
	"Txt1Key6";
	"Txt1Key7";
	"Txt1Key8";
	"Txt1Key9";
	"Txt1Key10";
	"Txt1Key11";
	"Txt1Key12";
	"Txt1Key13";
}
uiAutoAimUi.TXT2_KEY	= {
	"Txt2Key1";
	"Txt2Key2";
	"Txt2Key3";
	"Txt2Key4";
	"Txt2Key5";
	"Txt2Key6";
	"Txt2Key7";
	"Txt2Key8";
	"Txt2Key9";
	"Txt2Key10";
	"Txt2Key11";
	"Txt2Key12";
	"Txt2Key13";
}
uiAutoAimUi.KEY_CFGSET	= {
	"Key1";
	"Key2";
	"Key3";
	"Key4";
	"Key5";
	"Key6";
	"Key7";
	"Key8";
	"Key9";
	"Key10";
	"Key11";
	"Key12";
	"Key13";
}

uiAutoAimUi.BTN_003		        = "Btn003"
uiAutoAimUi.BTN_BookTask	    = "BtnBookAcc"
uiAutoAimUi.BTN_AutoMed    	    = "BtnAutoMed";
uiAutoAimUi.BTN_yijun	        = "Btnyijun"
uiAutoAimUi.BTN_yijunrd    	    = "Btnyijunrd";
uiAutoAimUi.BTN_GenSui          = "BtnGenSui"
uiAutoAimUi.BTN_Zwtz		    = "Btnzwtz"
uiAutoAimUi.BTN_BTNZDLBKG       = "Btnzdlbkg"
uiAutoAimUi.BTN_BTNZDLB         = "Btnzdlb"
uiAutoAimUi.BTN_BTNTZLB         = "Btntzlb"
uiAutoAimUi.BTN_JingJiLin       = "BtnJingJiLin"
uiAutoAimUi.BTN_Hqzb            = "Btnhqzb"
uiAutoAimUi.BTN_GenSui2         = "BtnGenSui2"
uiAutoAimUi.BTN_LiGuan	        = "BtnLiGuan"
uiAutoAimUi.BTN_BaiQiuLing	    = "BtnBaiQiuLing"
uiAutoAimUi.BTN_YaoDian         = "BtnYaoDian"
uiAutoAimUi.BTN_BaoGuan         = "BtnBaoGuan"
uiAutoAimUi.BTN_Qianzhuang      = "BtnQianzhuang"
uiAutoAimUi.BTN_Huanglin        = "BtnHuanglin"
local BTNCallAutoPuFire					= "BTNCallAutoPuFire"
local BTNCallQuangAnhThach					= "BtnCallQuangAnhThach"
local BTNCallLuyenCong					= "BtnCallLuyenCong" 
local BTNCallPKBang					= "BtnCallPKBang"
local BTNCallPKPhe					= "BtnCallPKPhe"
local yaokg=0

local KeyDefCfg = {
		[1] 	= {name="Bảng phụ trợ", key="O"},
		[2] 	= {name="Nhặt nhanh", key=""},
		[3] 	= {name="Auto thuốc", key=""},
		[4] 	= {name="Tự làm theo", key="Ctrl+Q"},
		[5] 	= {name="Chạy/Đi bộ", key="R"},
		[6] 	= {name="Tự động chiến đấu", key="F"},
		[7] 	= {name="Bảng Nhân Vật", key=""},
		[8] 	= {name="Lên/Xuống Ngựa", key=""},
		[9] 	= {name="Hành Trang", key=""},
		[10] 	= {name="Ghép HT", key=""},
		[11] 	= {name="SuperMapLink", key=""},
		[12] 	= {name="Không buff", key=""},
		}

function uiAutoAimUi:Init()
	
	self.YaoDelay = 0.5;
	self.LifeRet = 1500;
	self.ManaRet = 200;
	self.HealDelay = 0.5; 	
	self.AutoEat = 1;
	self.UserFile	= "\\interface\\btssl_autoFollow\\key.dat";
	self:LoadSetting();
	self:LoadKeyData();
	self:KeyUpDate();
	self:UpdateAimCfg();
end

function uiAutoAimUi:LoadKeyData()
	self.KEY_CFG	= {};
	local szKey		= KFile.ReadTxtFile(self.UserFile);
	if (not szKey) then
		for i=1,#KeyDefCfg do
			self.KEY_CFG[i] = {name=KeyDefCfg[i].name,key=KeyDefCfg[i].key};
		end
	else
		local tbMyKeyData	= Lib:Str2Val(szKey);
		for k, v in pairs(tbMyKeyData) do
			self.KEY_CFG[k] = {name=tbMyKeyData[k].nName,key=tbMyKeyData[k].nKey};
		end
	end
end

function uiAutoAimUi:SaveKeyData()
	self.tbUserKeyData ={}
	for i = 1,#KeyDefCfg do
		self.tbUserKeyData[i] = {nName=self.KEY_CFG[i].name,nKey=self.KEY_CFG[i].key};	
	end
	local szKey	= Lib:Val2Str(self.tbUserKeyData);
	KFile.WriteFile(self.UserFile, szKey);
end

function uiAutoAimUi:LoadKeyDefault()
	for i = 1,#KeyDefCfg do
		self.KEY_CFG[i] = {name=KeyDefCfg[i].name,key=KeyDefCfg[i].key};
	end
	self:SaveKeyData()
end

function uiAutoAimUi:SaveUserData()
	local LocalFile = GetPlayerPrivatePath().."aimset.dat";
	self.YaoDelay = Edt_GetTxt(self.UIGROUP, self.TXT_YAODELAY);
	self.LifeRet = Edt_GetTxt(self.UIGROUP, self.TXT_LIFE);
	self.ManaRet = Edt_GetTxt(self.UIGROUP, self.TXT_MANA);
	self.HealDelay = Edt_GetTxt(self.UIGROUP, self.TXT_HEALDELAY);
	self.tbAutoAimSetting = {nYaoDelay=self.YaoDelay, nLifeRet=self.LifeRet, nManaRet=self.ManaRet, nHealDelay=self.HealDelay, nAutoEat=self.AutoEat,}
	local szKey	= Lib:Val2Str(self.tbAutoAimSetting);
	KFile.WriteFile(LocalFile, szKey);
end

function uiAutoAimUi:LoadSetting()
	local LocalFile = GetPlayerPrivatePath().."aimset.dat";
	local szSet = KFile.ReadTxtFile(LocalFile);
	if (szSet) then
		local UserSetting = Lib:Str2Val(szSet);
		
		if UserSetting.nYaoDelay then
			self.YaoDelay = UserSetting.nYaoDelay;
		end
		if UserSetting.nLifeRet then
			self.LifeRet = UserSetting.nLifeRet;
		end
		if UserSetting.nManaRet then
			self.ManaRet = UserSetting.nManaRet;
		end
		
		if UserSetting.nHealDelay then
			self.HealDelay = UserSetting.nHealDelay;
		end
		if UserSetting.nAutoEat then
			self.AutoEat = UserSetting.nAutoEat;
		end
	end
end

uiAutoAimUi.UpdateAimCfg = function(self)
	local AimCfg =
	{
		nYaoDelay	= self.YaoDelay,
		nLifeRet	= self.LifeRet,
		nManaRet	= self.ManaRet,
		nHealDelay	= self.HealDelay,
		nAutoEat	= self.AutoEat,
	};
	Map.tbAutoAim:UpdateSetting(AimCfg)
end

function uiAutoAimUi:OnOpen()
	PgSet_ActivePage(self.UIGROUP, self.PAGESET_MAIN, self.PAGE_ONE);
	self:LoadSetting();
	self:UpdateWnd();
end
uiAutoAimUi.OnButtonClick = function(self, szWnd, nParam)
	if (szWnd == self.BTN_CLOSE) then
		UiManager:CloseWindow(self.UIGROUP);
	elseif (szWnd == self.BTN_REKEY) then
		self:KeyLoad();
		self:SaveUserData();
		UiManager:OpenWindow(Ui.UI_SYSTEM);
		UiManager:CloseWindow(Ui.UI_SYSTEM);
		UiManager:CloseWindow(self.UIGROUP);
	elseif (szWnd == self.BTN_DEKEY) then
		self:LoadKeyDefault();
		UiManager:CloseWindow(self.UIGROUP);
	elseif (szWnd == self.BTN_AUTOYAO) then
		self:SaveUserData();
		self:UpdateAimCfg();
		Map.tbAutoAim:FAutoYao()	
	elseif (szWnd == self.BTN_PICKUP) then
		Map.tbAutoAim:FPickUp();	
	elseif (szWnd == self.BTN_AUTOEAT) then
		self.AutoEat=nParam;
	elseif (szWnd == self.BTN_SUFOLLOW) then
		local nIndex = Lst_GetCurKey(self.UIGROUP, self.TEAM_MEMBER_LIST);
		if nIndex and nIndex >= 0 then
			self:UpdateFollow(nIndex);
		end
	elseif (szWnd == self.BTN_NMATTACK_MONSTER) then
		Map.tbAutoAim.nAttackMonsterState = 1 - Map.tbAutoAim.nAttackMonsterState;
	elseif (szWnd == self.BTN_EXIT) then
		local LocalDir = GetPlayerPrivatePath();
	elseif (szWnd == self.BTN_GATHER) then
		Map.tbAutoAim:Select();
	elseif (szWnd == self.BTN_STONE) then
		Map.tbAutoEgg:AutoPick();
	---------------
elseif szWnd == BTNCallQuangAnhThach then
		Map.tbSuperCall:QuangAnhThach()
	elseif szWnd == BTNCallAutoPuFire then
		Map.tbSuperCall:AutoPuFire()
	elseif szWnd == BTNCallLuyenCong then
		Map.tbSuperCall:LuyenCong()  
	elseif szWnd == BTNCallPKBang then
		Map.tbSuperCall:PKBang()
	elseif szWnd == BTNCallPKPhe then
		Map.tbSuperCall:PKPhe()	
---------------------		
	elseif (szWnd == self.BTN_FIRE) then
		Map.tbAutoEgg:AutoPick();
	elseif (szWnd == self.BTN_003) then
		self:ScrReload();
  elseif (szWnd == self.BTN_BookTask) then 
		Map.tbAimFight:Start_Clock();	
	elseif (szWnd == self.BTN_AutoMed) then
                if yaokg == 0 then
			yaokg=1
			Ui(Ui.UI_AUTOFIGHT):StartAutoMed();
		else    yaokg=0
			Ui(Ui.UI_AUTOFIGHT):StopAutoMed();
		end
	elseif (szWnd == self.BTN_GenSui) then	
		Ui(Ui.UI_SERVERSPEED):AutoFollow();
		Map.tbAutoAim:AutoFollow();
	elseif (szWnd == self.BTN_Hqzb) then
		Ui.tbLogic.tbTimer:Close(self.JingChiLing_TimerId)
		local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
		self.nNum=self.nNum+1
		local tbPos={
			[self.nNum]={MapId=nCurMapId,PosX=nWorldPosX,PosY=nWorldPosY}
					}
		self:GetAroundNpcId1()
	end
end

uiAutoAimUi.OnScorllbarPosChanged = function(self, szWnd, nParam)
	if szWnd == self.SCROLL_DELAY then
		self.YaoDelay = nParam / 2 + 0.5;
	elseif szWnd == self.SCROLL_LIFE then
		self.LifeRet = nParam * 5;
	elseif szWnd == self.SCROLL_MANA then
		self.ManaRet = nParam * 5;
	end
	self:UpdateWnd();
end

function uiAutoAimUi:UpdateWnd()
	
	Btn_Check(self.UIGROUP, self.BTN_AUTOYAO, Map.tbAutoAim.nYaoState);
	Edt_SetTxt(self.UIGROUP, self.TXT_YAODELAY, self.YaoDelay);
	Edt_SetTxt(self.UIGROUP, self.TXT_LIFE, self.LifeRet);
	Edt_SetTxt(self.UIGROUP, self.TXT_MANA, self.ManaRet);
	
	Btn_Check(self.UIGROUP, self.BTN_PICKUP, Map.tbAutoAim.nPickState);
	Btn_Check(self.UIGROUP, self.BTN_NMATTACK_MONSTER, Map.tbAutoAim.nAttackMonsterState);
	if Map.tbAutoAim.nfireState == 1 then
		local szText	= "<color=red>Fire in the ...<color>";
		Txt_SetTxt(self.UIGROUP, self.TXT_FIRE, szText);
	else
		local szText	= " ";
		Txt_SetTxt(self.UIGROUP, self.TXT_FIRE, szText);
	end

	Btn_Check(self.UIGROUP, self.BTN_AUTOEAT, self.AutoEat);
	if Map.tbAutoAim.nFollowState == 1 then
		Btn_Check(self.UIGROUP, self.BTN_SUFOLLOW, Map.tbAutoAim.nFollowState);
		if Map.tbAutoAim.nszName then
			local szText	= Map.tbAutoAim.nszName;
			Txt_SetTxt(self.UIGROUP, self.TXT_FOLLOW, szText);		
		end
	end

	local tbMember = me.GetTeamMemberInfo();	
	for i = 1, #tbMember do
		if tbMember[i].szName and tbMember[i].nPlayerID then
			local szBuf = tbMember[i].szName;
			local szFaction = Player:GetFactionRouteName(tbMember[i].nFaction);
			local szMap = GetMapNameFormId(tbMember[i].nMapId)
			Lst_SetCell(self.UIGROUP, self.TEAM_MEMBER_LIST, i , 0, szBuf);
			Lst_SetCell(self.UIGROUP, self.TEAM_MEMBER_LIST, i , 1, szFaction);
			Lst_SetCell(self.UIGROUP, self.TEAM_MEMBER_LIST, i , 2, szMap);
			Lst_SetLineData(self.UIGROUP, self.TEAM_MEMBER_LIST, i, tbMember[i].nPlayerID);
		end			
	end

	Edt_SetTxt(self.UIGROUP, self.TXT_HEALDELAY, self.HealDelay);

	for i = 1,#KeyDefCfg do 
		local szText1 = "<color=130,130,240>"..self.KEY_CFG[i].name.."<color>";
		local szText2 = "<color=130,130,220>"..self.KEY_CFG[i].key.."<color>";
		Txt_SetTxt(self.UIGROUP, self.TXT1_KEY[i], szText1);
		Txt_SetTxt(self.UIGROUP, self.TXT2_KEY[i], szText2);
		Edt_SetTxt(self.UIGROUP, self.KEY_CFGSET[i], self.KEY_CFG[i].key);
	end

	self:UpdateAimCfg();
end


function uiAutoAimUi:UpdateFollow(nIndex)
	local szName = Lst_GetCell(self.UIGROUP, self.TEAM_MEMBER_LIST, nIndex, 0);
	local nItemData = Lst_GetLineData(self.UIGROUP, self.TEAM_MEMBER_LIST, nIndex);
	Map.tbAutoAim:FollowData(szName,nItemData)
end

function uiAutoAimUi:KeyLoad()
	for i=1,#KeyDefCfg do
		local nMsg = Edt_GetTxt(self.UIGROUP, self.KEY_CFGSET[i]);
		self.KEY_CFG[i].key = nMsg;
	end
	self:SaveKeyData()
end

function uiAutoAimUi:KeyUpDate()

	local tCmd={ "UiManager:SwitchWindow(Ui.UI_AUTOAIM_UI)", "AutoAim", "", self.KEY_CFG[1].key, self.KEY_CFG[1].key, "Tự động hỗ trợ" };
	AddCommand(self.KEY_CFG[1].key, self.KEY_CFG[1].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);

	local tCmd={"Map.tbAutoAim:FPickUp()", "AutoPickup", "",self.KEY_CFG[2].key,self.KEY_CFG[2].key,"Nhặt nhanh" };
	AddCommand(self.KEY_CFG[2].key, self.KEY_CFG[2].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);

	local tCmd={"Map.tbAutoAim:FAutoYao()", "AutoYao", "", self.KEY_CFG[3].key, self.KEY_CFG[3].key, "Tự động uống Thuốc" };
	AddCommand(self.KEY_CFG[3].key, self.KEY_CFG[3].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);

	local tCmd = { "Map.tbAutoAim:AutoFollow();", "AutoFollow", "", self.KEY_CFG[4].key, self.KEY_CFG[4].key, "Buff&Hộ tống" };
	AddCommand(self.KEY_CFG[4].key, self.KEY_CFG[4].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);

	local tCmd={ "Switch([[run]])", "SwitchRun", "", self.KEY_CFG[5].key, self.KEY_CFG[5].key, "Chạy/Đi bộ" };
        AddCommand(self.KEY_CFG[5].key, self.KEY_CFG[5].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
        UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);

	local tCmd={ "AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey())", "AutoFight", "", self.KEY_CFG[6].key, self.KEY_CFG[6].key, "AutoFight" };
        UiShortcutAlias.m_tKeyList[#UiShortcutAlias.m_tKeyList+1] = tCmd;

	local tCmd={ "UiManager:SwitchWindow(Ui.UI_PLAYERPANEL)", "PlayerPanel", "", self.KEY_CFG[7].key, self.KEY_CFG[7].key, "Bảng Nhân Vật" };
        AddCommand(self.KEY_CFG[7].key, self.KEY_CFG[7].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
        UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);

	local tCmd={ "Switch([[horse]])", "SwitchMount", "", self.KEY_CFG[8].key, self.KEY_CFG[8].key, "lên/xuống ngựa" };
        UiShortcutAlias.m_tKeyList[#UiShortcutAlias.m_tKeyList+1] = tCmd;

	local tCmd={ "UiManager:SwitchWindow(Ui.UI_ITEMBOX)",	"ItemBoxPalen",	"", self.KEY_CFG[9].key, self.KEY_CFG[9].key, "Hành trang F2" };
        AddCommand(self.KEY_CFG[9].key, self.KEY_CFG[9].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
        UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);

	local tCmd={"UiManager:hexuan()", "Autohexuan", "",self.KEY_CFG[10].key,self.KEY_CFG[10].key,"Ghép HT" };
	      AddCommand(self.KEY_CFG[10].key, self.KEY_CFG[10].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	      UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);

	local tCmd={ "UiManager:SwitchWindow(Ui.UI_SUPERMAPLINK_UI)", "SuperMapLink", "", self.KEY_CFG[11].key, self.KEY_CFG[11].key, "SUPERMAPLINK" };
	AddCommand(self.KEY_CFG[11].key, self.KEY_CFG[11].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);

	local tCmd={"Map.BtnNMAttackMonster()", "NMAttackMonster", "",self.KEY_CFG[12].key,self.KEY_CFG[12].key,"Không Buff" };
	AddCommand(self.KEY_CFG[12].key, self.KEY_CFG[12].key, tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
end

uiAutoAimUi:Init();
LoadUiGroup(Ui.UI_AUTOAIM_UI, "autoFollow.ini");
