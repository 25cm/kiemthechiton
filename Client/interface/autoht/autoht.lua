local uiAutoHT = Ui:GetClass("autoht");

local BUTTON_CLOSE	= "BtnClose";
local BUTTON_STOP	= "BtnStop";
local BUTTON_CHOOSE_MAP	= "BtnChooseMap";
local BUTTON_START_AUTOHT	= "BtnStartAutoHT";
local BUTTON_BACKHT	= "BtnBackHT";
local BUTTON_NEXTHT	= "BtnNextHT";
local BUTTON_ONOFF_AUTOPT = "BtnOnOffAutoPt";
local EDT_GIAY	= "EdtGiay";
local EDT_PASS_JOIN_TEAM = "EdtPasswordJoinTeam";
local PAGESET_MAIN	= "PageSetMain";
local BUTTON_ONOFF_TRAINAFK = "BtnOnOffTrainIfAfk";
local EDT_TOA_DO_TRAIN = "EdtToaDoTrain";
local BUTTON_GET_POS_TRAIN = "BtnGetPosTrain";
local BUTTON_SAVE_POS_TRAIN = "BtnSavePosTrain";
local BUTTON_KICK_PARTY_NFRIEND = "BtnKickPartyIfNotFriend";
local BUTTON_AUTO_BUY_HP = "BtnAutoBuyHP";
local BUTTON_AUTO_BUY_MP = "BtnAutoBuyMP";
local EDT_MIN_QUANTITY_HP = "EdtMinQuantityHP";
local EDT_MAX_QUANTITY_HP = "EdtMaxQuantityHP";
local EDT_MIN_QUANTITY_MP = "EdtMinQuantityMP";
local EDT_MAX_QUANTITY_MP = "EdtMaxQuantityMP";

uiAutoHT.BTN_SUFOLLOW	= "BtnSuperFollow";
uiAutoHT.BTN_NMATTACK_MONSTER	= "BtnNMAttackMonster";
uiAutoHT.BTN_AUTO_REPAIR_ITEM	= "BtnAutoRepairItem";
uiAutoHT.TEAM_MEMBER_LIST	= "LstTeamMember";
--uiAutoHT.nOnOffAutoPt = 0;
--uiAutoHT.szPassJoinTeam = "tanvu";

local nIdHT	= 1;
local nContinue	= 0;
local nTimerId1 = 0; --timer cho autoHT
local nTimerIdLife = 0; --timer cho life
local nTimerIdFood = 0; --timer cho food
local nTimerIdMana = 0; --timer cho mana
local nTimes1 = 1;
local Timer1 = 0;
local IntervalHT = 1; -- tan so auto
local nActionTypeHT = 0; -- trang thai hien tai
local nNextHT = 1; --con HT thu ...
local nMapHT = 1; --id cua map trong nay - mac dinh la sac lac xuyen
local nFinishHT = 0; -- giet dc ht chua?
local nTimeWaitHT = 10; --thoi gian cho mac dinh
local TimeWaitHT = 0; -- thoi gian dang cho
local RangerSeeHT = 60; -- khoang cach nhan biet HT
local nLastTimeSeeHT = 0; -- lan gan nhat thay ht
local MaxLastTimeSeeHT = 5; -- thoi gian lon nhat giua cac lan thay ht
local szFilePath = 0;
local LastTimeTown = 0; -- thoi gian town lan cuoi cung
local nMaxLastTimeTown = 18;
local nTimerOnSayPT = 0;
local Say_bak = 0;
local nCloseSayWnd = 0;
local tbList = {}
local tbList2 = {}
local tbListEx = {}
local tbRelationTypes = {}
local KickPtStatus = 0;
local nMaxHP = 50; -- so luong mau max
local nMinHP = 20; --so luong mau min
local AutoBuyHPStatus = 0;
local nLvBuyItem = 0;
local nMaxMP = 50; -- so luong mana max
local nMinMP = 20; --so luong mana min
local AutoBuyMPStatus = 0;
local nLvBuyItem = 0;

local bAutoFood=0;
local nTimeLastFood = 0;
local bAutoLife=0
local nAutoLifeLv1=0
local nAutoLifeLv2=0
local nAutoLifeLv3=0
local nAutoLifeDelay=3
local bAutoLife_P=0
local nAutoLifeLv1_P=60
local nAutoLifeLv2_P=40
local nAutoLifeLv3_P=20
local nAutoLifeDelay_P=3
local nTimeLastAutoLife1 = 0;
local nTimeLastAutoLife2 = 0;
local nTimeLastAutoLife3 = 0;
local nTimeLastAutoLife1_P = 0;
local nTimeLastAutoLife2_P = 0;
local nTimeLastAutoLife3_P = 0;


local tbListMapHT = {};
tbListMapHT[1]={Name="S???c L???c Xuy??n-map9x",idMapListHT=0}
tbListMapHT[2]={Name="V?? Di S??n-map9x",idMapListHT=4}
tbListMapHT[3]={Name="Hoa S??n-map9x",idMapListHT=8}
tbListMapHT[4]={Name="V?? L??ng S??n-map9x",idMapListHT=12}
tbListMapHT[5]={Name="Gia D??? Quan-map9x",idMapListHT=16}
tbListMapHT[6]={Name="Mi??u L??nh-map9x",idMapListHT=20}
tbListMapHT[7]={Name="Th???c C????ng B?? C???nh-map9x",idMapListHT=24}
tbListMapHT[8]={Name="Phong ???? Qu??? Th??nh-map9x",idMapListHT=28}
tbListMapHT[9]={Name="Long M??n Th???ch Qu???t-map8x",idMapListHT=32}
tbListMapHT[10]={Name="Ki???m M??n Quan-map8x",idMapListHT=36}
tbListMapHT[11]={Name="Ti???n C??c ?????ng-map8x",idMapListHT=40}
tbListMapHT[12]={Name="Bang Nguy??n B?? ?????ng-map8x",idMapListHT=44}
tbListMapHT[13]={Name="K?? Qu??n ?????ng-map7x",idMapListHT=48}
tbListMapHT[14]={Name="H?????ng Th???y ?????ng-map6x",idMapListHT=52}
tbListMapHT[15]={Name="C?? Di??n Tr???ch-map6x",idMapListHT=56}
tbListMapHT[16]={Name="H??n S??n C??? S??t-map5x",idMapListHT=60}

local tbListHT = {};
tbListHT[1]={Name="C??p Nh?? Ba L???p",mapid=114,mapname="S???c L???c Xuy??n",x=1839,y=3772,npcid=3109}
tbListHT[2]={Name="H??c Nh???t Can",mapid=114,mapname="S???c L???c Xuy??n",x=1618,y=3747,npcid=3107}
tbListHT[3]={Name="Tra Can Ba L???p",mapid=114,mapname="S???c L???c Xuy??n",x=1738,y=3232,npcid=3108}
tbListHT[4]={Name="T?? H??ch Ba L???",mapid=114,mapname="S???c L???c Xuy??n",x=1927,y=3236,npcid=3110}
tbListHT[5]={Name="??i???n B???t Nh???",mapid=120,mapname="V?? Di S??n",x=1843,y=3471,npcid=3131}
tbListHT[6]={Name="Th???m Ng?? Lang",mapid=120,mapname="V?? Di S??n",x=1932,y=3870,npcid=3132}
tbListHT[7]={Name="S??? Thi???t Ch?????ng",mapid=120,mapname="V?? Di S??n",x=1691,y=3806,npcid=3133}
tbListHT[8]={Name="D?? Ch??nh H???i",mapid=120,mapname="V?? Di S??n",x=1620,y=3574,npcid=3134}
tbListHT[9]={Name="Ninh C??n C??n",mapid=116,mapname="Hoa S??n",x=1857,y=3594,npcid=3118}
tbListHT[10]={Name="L???nh H??? Chi??m",mapid=116,mapname="Hoa S??n",x=1601,y=3669,npcid=3115}
tbListHT[11]={Name="Nh???c L??nh Thi???n",mapid=116,mapname="Hoa S??n",x=1701,y=3492,npcid=3116}
tbListHT[12]={Name="Phong C???c",mapid=116,mapname="Hoa S??n",x=1821,y=3238,npcid=3117}
tbListHT[13]={Name="B??i Th???i Uy??n",mapid=121,mapname="V?? L??ng S??n",x=1821,y=3267,npcid=3135}
tbListHT[14]={Name="Ng?? Th??i Huy???n",mapid=121,mapname="V?? L??ng S??n",x=1682,y=3457,npcid=3136}
tbListHT[15]={Name="Ho??ng Ph??? Ki???n",mapid=121,mapname="V?? L??ng S??n",x=1568,y=3313,npcid=3137}
tbListHT[16]={Name="Th??n ????? Ch??n",mapid=121,mapname="V?? L??ng S??n",x=1484,y=3161,npcid=3138}
tbListHT[17]={Name="Ca Th?? M???c",mapid=115,mapname="Gia D??? Quan",x=1641,y=3268,npcid=3113}
tbListHT[18]={Name="M?? V???n C??",mapid=115,mapname="Gia D??? Quan",x=1513,y=3177,npcid=3112}
tbListHT[19]={Name="Cu???ng Phong Sa",mapid=115,mapname="Gia D??? Quan",x=1491,y=2903,npcid=3111}
tbListHT[20]={Name="S??? Phi ??ng",mapid=115,mapname="Gia D??? Quan",x=1778,y=2920,npcid=3114}
tbListHT[21]={Name="K??? Thi??n Th??nh",mapid=119,mapname="Mi??u L??nh",x=1607,y=3658,npcid=3128}
tbListHT[22]={Name="Ba ?????i Nhi",mapid=119,mapname="Mi??u L??nh",x=1581,y=3197,npcid=3127}
tbListHT[23]={Name="L??u Thi??n Thi??n",mapid=119,mapname="Mi??u L??nh",x=1720,y=3279,npcid=3129}
tbListHT[24]={Name="B???ch Vi???n H???i",mapid=119,mapname="Mi??u L??nh",x=1839,y=3670,npcid=3130}
tbListHT[25]={Name="Nguy??n Th???p Nh???",mapid=117,mapname="Th???c C????ng B?? C???nh",x=1674,y=3361,npcid=3120}
tbListHT[26]={Name="Di??u Thanh B??nh",mapid=117,mapname="Th???c C????ng B?? C???nh",x=1439,y=3405,npcid=3121}
tbListHT[27]={Name="T??n Nguy???t L??u",mapid=117,mapname="Th???c C????ng B?? C???nh",x=1537,y=2940,npcid=3122}
tbListHT[28]={Name="Ng??u Ch???n S??n",mapid=117,mapname="Th???c C????ng B?? C???nh",x=1622,y=2916,npcid=3119}
tbListHT[29]={Name="B???ch V?? Th?????ng",mapid=118,mapname="Phong ???? Qu??? Th??nh",x=1618,y=3853,npcid=3124}
tbListHT[30]={Name="H???c V?? Th?????ng",mapid=118,mapname="Phong ???? Qu??? Th??nh",x=1459,y=3600,npcid=3123}
tbListHT[31]={Name="Chung Th???n Ph??n",mapid=118,mapname="Phong ???? Qu??? Th??nh",x=1874,y=3409,npcid=3126}
tbListHT[32]={Name="Di??m Th???p ??i???n",mapid=118,mapname="Phong ???? Qu??? Th??nh",x=1861,y=3786,npcid=3125}
tbListHT[33]={Name="Gia Lu???t Thi???t Th??ch",mapid=107,mapname="Long M??n Th???ch Qu???t",x=1944,y=3693,npcid=3079}
tbListHT[34]={Name="Ch????ng Nguy??n S??ng",mapid=107,mapname="Long M??n Th???ch Qu???t",x=1779,y=3831,npcid=3080}
tbListHT[35]={Name="Tr???nh C???u C??ng",mapid=107,mapname="Long M??n Th???ch Qu???t",x=1709,y=3305,npcid=3081}
tbListHT[36]={Name="Tr???nh Tr??c Qu??n",mapid=107,mapname="Long M??n Th???ch Qu???t",x=1884,y=3296,npcid=3082}
tbListHT[37]={Name="Gia C??t Kinh H???ng",mapid=111,mapname="Ki???m M??n Quan",x=1939,y=3700,npcid=3097}
tbListHT[38]={Name="Phong V?? Ng??n",mapid=111,mapname="Ki???m M??n Quan",x=1622,y=3639,npcid=3098}
tbListHT[39]={Name="Chu Tr???n Phi",mapid=111,mapname="Ki???m M??n Quan",x=1709,y=3210,npcid=3095}
tbListHT[40]={Name="Chu S??? B??",mapid=111,mapname="Ki???m M??n Quan",x=1960,y=3228,npcid=3096}
tbListHT[41]={Name="C??? Thanh D????ng",mapid=110,mapname="Ti???n C??c ?????ng",x=1587,y=3279,npcid=3092}
tbListHT[42]={Name="C??? V?? Th?????ng",mapid=110,mapname="Ti???n C??c ?????ng",x=1324,y=3056,npcid=3091}
tbListHT[43]={Name="H?? Li??n T???",mapid=110,mapname="Ti???n C??c ?????ng",x=1381,y=3001,npcid=3094}
tbListHT[44]={Name="Quan T??? M???c",mapid=110,mapname="Ti???n C??c ?????ng",x=1643,y=2944,npcid=3093}
tbListHT[45]={Name="Ph???m Tri???u S????ng",mapid=113,mapname="Bang Nguy??n B?? ?????ng",x=1741,y=3703,npcid=3103}
tbListHT[46]={Name="Ph?? T?? V??n",mapid=113,mapname="Bang Nguy??n B?? ?????ng",x=1406,y=3495,npcid=3106}
tbListHT[47]={Name="Ph??ng Song D???c",mapid=113,mapname="Bang Nguy??n B?? ?????ng",x=1496,y=3307,npcid=3105}
tbListHT[48]={Name="Ph????ng ?????i Ch??u",mapid=113,mapname="Bang Nguy??n B?? ?????ng",x=1705,y=3198,npcid=3104}
tbListHT[49]={Name="Tang An Nhi",mapid=102,mapname="K?? Qu??n ?????ng",x=1616,y=3122,npcid=3059}
tbListHT[50]={Name="T??ng A Ng??u",mapid=102,mapname="K?? Qu??n ?????ng",x=1634,y=2842,npcid=3060}
tbListHT[52]={Name="Chi??m Ph??c V??n",mapid=102,mapname="K?? Qu??n ?????ng",x=1213,y=2955,npcid=3061}
tbListHT[51]={Name="Tr????ng Tr???n Phi",mapid=102,mapname="K?? Qu??n ?????ng",x=1400,y=2724,npcid=3062}
tbListHT[53]={Name="V???n Ti??u S??n",mapid=97,mapname="H?????ng Th???y ?????ng",x=1636,y=3489,npcid=3039}
tbListHT[54]={Name="U??ng Th??? Th???y",mapid=97,mapname="H?????ng Th???y ?????ng",x=1795,y=3276,npcid=3040}
tbListHT[55]={Name="V????ng B?? Thi??n",mapid=97,mapname="H?????ng Th???y ?????ng",x=1871,y=3348,npcid=3041}
tbListHT[56]={Name="Vu C???u ?????",mapid=97,mapname="H?????ng Th???y ?????ng",x=1893,y=3659,npcid=3042}
tbListHT[57]={Name="L??u K??? Thi???n",mapid=94,mapname="C?? Di??n Tr???ch",x=1616,y=3775,npcid=3027}
tbListHT[58]={Name="L?? Qu??n B???c",mapid=94,mapname="C?? Di??n Tr???ch",x=1713,y=3250,npcid=3028}
tbListHT[59]={Name="L???c Tr???ng Hi???n",mapid=94,mapname="C?? Di??n Tr???ch",x=1970,y=3711,npcid=3029}
tbListHT[60]={Name="L???c Nh?? Kim",mapid=94,mapname="C?? Di??n Tr???ch",x=1716,y=3746,npcid=3030}
tbListHT[61]={Name="L?? H??nh Ki???m",mapid=89,mapname="H??n S??n C??? S??t",x=1923,y=3188,npcid=3010}
tbListHT[62]={Name="Kha H??ng Phi",mapid=89,mapname="H??n S??n C??? S??t",x=1555,y=3189,npcid=3007}
tbListHT[63]={Name="Kh???ng B???t Dung",mapid=89,mapname="H??n S??n C??? S??t",x=1610,y=3694,npcid=3008}
tbListHT[64]={Name="L??i C???u Kh??ch",mapid=89,mapname="H??n S??n C??? S??t",x=1897,y=3692,npcid=3009}



function uiAutoHT:OnOpen(nParam)	
	local szData = KFile.ReadTxtFile("\\interface\\autoht\\toadotrain.txt");
	--me.Msg("szData= "..szData);
	local tbSplit = Lib:SplitStr(szData, "#^@");
	Map.tbAutoAimHT.MapidTrain = tonumber(tbSplit[1]);
	Map.tbAutoAimHT.PosXTrain = tonumber(tbSplit[2]);
	Map.tbAutoAimHT.PosYTrain = tonumber(tbSplit[3]);
	Edt_SetTxt("UI_AUTOHT", EDT_GIAY, nTimeWaitHT);	
	Btn_Check("UI_AUTOHT", BUTTON_ONOFF_TRAINAFK, Map.tbAutoAimHT.nOnOffTrainAfk);
	--me.Msg(GetMapNameFormId(Map.tbAutoAimHT.MapidTrain).."("..math.floor(Map.tbAutoAimHT.PosXTrain/8)..","..math.floor(Map.tbAutoAimHT.PosYTrain/16)..")");
	Edt_SetTxt("UI_AUTOHT", EDT_TOA_DO_TRAIN, GetMapNameFormId(Map.tbAutoAimHT.MapidTrain).."("..math.floor(Map.tbAutoAimHT.PosXTrain/8)..","..math.floor(Map.tbAutoAimHT.PosYTrain/16)..")");	
	Edt_SetTxt("UI_AUTOHT", EDT_PASS_JOIN_TEAM, Map.tbSuperCallHT.szPassJoinTeam);
	Btn_SetTxt("UI_AUTOHT",BUTTON_CHOOSE_MAP,tbListMapHT[nMapHT].Name);
	Btn_Check("UI_AUTOHT", BUTTON_ONOFF_AUTOPT, Map.tbSuperCallHT.nOnOffAutoPt);
	Btn_Check("UI_AUTOHT", self.BTN_SUFOLLOW, Map.tbAutoAimHT.nFollowState);	
	Btn_Check(self.UIGROUP, self.BTN_NMATTACK_MONSTER, Map.tbAutoAimHT.nAttackMonsterState);
	Btn_Check(self.UIGROUP, self.BTN_AUTO_REPAIR_ITEM, Map.tbAutoAimHT.nRepairItemState);
	Btn_Check("UI_AUTOHT", BUTTON_KICK_PARTY_NFRIEND, KickPtStatus);
	Edt_SetTxt("UI_AUTOHT", EDT_MIN_QUANTITY_HP, nMinHP);
	Edt_SetTxt("UI_AUTOHT", EDT_MAX_QUANTITY_HP, nMaxHP);
	Btn_Check("UI_AUTOHT", BUTTON_AUTO_BUY_HP, AutoBuyHPStatus);
	Edt_SetTxt("UI_AUTOHT", EDT_MIN_QUANTITY_MP, nMinMP);
	Edt_SetTxt("UI_AUTOHT", EDT_MAX_QUANTITY_MP, nMaxMP);
	Btn_Check("UI_AUTOHT", BUTTON_AUTO_BUY_MP, AutoBuyMPStatus);
	uiAutoHT:CTestLv();
	--me.Msg("lv="..nLvBuyItem);
	
	local tbMember = me.GetTeamMemberInfo();	
	for i = 1, #tbMember do
		if tbMember[i].szName and tbMember[i].nPlayerID then
			local szBuf = tbMember[i].szName;
			local szFaction = Player:GetFactionRouteName(tbMember[i].nFaction);
			local szMap = GetMapNameFormId(tbMember[i].nMapId)
			Lst_SetCell("UI_AUTOHT", self.TEAM_MEMBER_LIST, i , 0, szBuf);
			Lst_SetCell("UI_AUTOHT", self.TEAM_MEMBER_LIST, i , 1, szFaction);
			Lst_SetLineData("UI_AUTOHT", self.TEAM_MEMBER_LIST, i, tbMember[i].nPlayerID);
		end			
	end
	self:UpdateAimCfg();
end

function uiAutoHT:OnButtonClick(szWnd, nParam)	
	if szWnd == BUTTON_CLOSE then
		UiManager:CloseWindow(self.UIGROUP);
	elseif (szWnd == BUTTON_AUTO_BUY_HP) then
		AutoBuyHPStatus = 1 - AutoBuyHPStatus;	
		nMinHP = Edt_GetTxt("UI_AUTOHT", EDT_MIN_QUANTITY_HP);
		nMinHP = tonumber(nMinHP);
		nMaxHP = Edt_GetTxt("UI_AUTOHT", EDT_MAX_QUANTITY_HP);
		nMaxHP = tonumber(nMaxHP);
		UiManager:OpenWindow("UI_INFOBOARD","<color=red>M??u t???i thi???u: "..nMinHP..", m??u t???i ??a: "..nMaxHP);	
	elseif (szWnd == BUTTON_AUTO_BUY_MP) then
		AutoBuyMPStatus = 1 - AutoBuyMPStatus;	
		nMinMP = Edt_GetTxt("UI_AUTOHT", EDT_MIN_QUANTITY_MP);
		nMinMP = tonumber(nMinMP);
		nMaxMP = Edt_GetTxt("UI_AUTOHT", EDT_MAX_QUANTITY_MP);
		nMaxMP = tonumber(nMaxMP);
		UiManager:OpenWindow("UI_INFOBOARD","<color=red>Mana t???i thi???u: "..nMinMP..", mana t???i ??a: "..nMaxMP);	
	elseif (szWnd == BUTTON_KICK_PARTY_NFRIEND) then
		KickPtStatus = 1 - KickPtStatus;
	elseif (szWnd == BUTTON_ONOFF_TRAINAFK) then
		Map.tbAutoAimHT.nOnOffTrainAfk = 1 - Map.tbAutoAimHT.nOnOffTrainAfk;	
	elseif (szWnd == BUTTON_GET_POS_TRAIN) then
		local nMapId,nX,nY = me.GetWorldPos();
		Map.tbAutoAimHT.MapidTrain  = nMapId;
		Map.tbAutoAimHT.PosXTrain = nX;
		Map.tbAutoAimHT.PosYTrain = nY;
		Edt_SetTxt("UI_AUTOHT", EDT_TOA_DO_TRAIN, GetMapNameFormId(Map.tbAutoAimHT.MapidTrain).."("..math.floor(Map.tbAutoAimHT.PosXTrain/8)..","..math.floor(Map.tbAutoAimHT.PosYTrain/16)..")");	
	elseif (szWnd == BUTTON_SAVE_POS_TRAIN) then
		local nMapId,nX,nY = me.GetWorldPos();
		Map.tbAutoAimHT.MapidTrain  = nMapId;
		Map.tbAutoAimHT.PosXTrain = nX;
		Map.tbAutoAimHT.PosYTrain = nY;
		Edt_SetTxt("UI_AUTOHT", EDT_TOA_DO_TRAIN, GetMapNameFormId(Map.tbAutoAimHT.MapidTrain).."("..math.floor(Map.tbAutoAimHT.PosXTrain/8)..","..math.floor(Map.tbAutoAimHT.PosYTrain/16)..")");	
		KFile.WriteFile("\\interface\\autoht\\toadotrain.txt", nMapId.."#^@"..nX.."#^@"..nY);
	elseif (szWnd == BUTTON_ONOFF_AUTOPT) then
		Map.tbSuperCallHT.nOnOffAutoPt = 1 - Map.tbSuperCallHT.nOnOffAutoPt;
		Map.tbSuperCallHT.szPassJoinTeam = Edt_GetTxt("UI_AUTOHT", EDT_PASS_JOIN_TEAM);		
	elseif (szWnd == self.BTN_NMATTACK_MONSTER) then
		Map.tbAutoAimHT.nAttackMonsterState = 1 - Map.tbAutoAimHT.nAttackMonsterState;
	elseif (szWnd == self.BTN_AUTO_REPAIR_ITEM) then
		Map.tbAutoAimHT.nRepairItemState = 1 - Map.tbAutoAimHT.nRepairItemState;		
	elseif (szWnd == self.BTN_SUFOLLOW) then
		local nIndex = Lst_GetCurKey("UI_AUTOHT", self.TEAM_MEMBER_LIST);
		Map.tbAutoAimHT.TimeStartFollow = GetTime();
		if nIndex and nIndex >= 0 then
			self:UpdateFollow(nIndex);
		end
	elseif (szWnd == BUTTON_STOP) then					
		uiAutoHT:KetThucTrainHT();		
	elseif (szWnd == BUTTON_BACKHT) then
		UiManager:OpenWindow("UI_INFOBOARD","<color=red>Back");
		Timer1 = 0;
		nActionTypeHT = 1;
		nFinishHT = 0;
		TimeWaitHT = 0;
		if nNextHT == 1 then
			nNextHT = 4;
		else 
			nNextHT = nNextHT - 1;
		end
	elseif (szWnd == BUTTON_NEXTHT) then
		UiManager:OpenWindow("UI_INFOBOARD","<color=red>Next");
		Timer1 = 0;
		nActionTypeHT = 1;
		nFinishHT = 0;
		TimeWaitHT = 0;
		if nNextHT == 4 then
			nNextHT = 1;
		else 
			nNextHT = nNextHT + 1;
		end
	elseif (szWnd == BUTTON_CHOOSE_MAP) then
		UiManager:OpenWindow("UI_INFOBOARD","<color=red>Ch???n map train");
		DisplayPopupMenu(
		"UI_AUTOHT",szWnd,16,0,
		tbListMapHT[1].Name,1,
		tbListMapHT[2].Name,2,
		tbListMapHT[3].Name,3,
		tbListMapHT[4].Name,4,
		tbListMapHT[5].Name,5,
		tbListMapHT[6].Name,6,
		tbListMapHT[7].Name,7,
		tbListMapHT[8].Name,8,
		tbListMapHT[9].Name,9,
		tbListMapHT[10].Name,10,
		tbListMapHT[11].Name,11,
		tbListMapHT[12].Name,12,
		tbListMapHT[13].Name,13,
		tbListMapHT[14].Name,14,
		tbListMapHT[15].Name,15,
		tbListMapHT[16].Name,16
		)
	elseif (szWnd == BUTTON_START_AUTOHT) then
		uiAutoHT:BatDauTrainHT();
	end
end

function uiAutoHT:KetThucTrainHT()
		nActionTypeHT = 0;
		if me.nAutoFightState == 1 then
			AutoAi.ProcessHandCommand("auto_fight", 0);
		end
		UiManager:OpenWindow("UI_INFOBOARD","<color=red>Ch??n R??i...Kh??ng Train N???a");	
end

function uiAutoHT:BatDauTrainHT()
		UiManager:OpenWindow("UI_INFOBOARD","<color=red>Kill H???t H???i T???c Kh??ng Cho B???n N?? L??m NV N??o");
		local szGiay = Edt_GetInt("UI_AUTOHT", EDT_GIAY)
		if szGiay == "" or nil then
			nTimeWaitHT = 60;
		else
			nTimeWaitHT = tonumber(szGiay);
		end
		if nTimeWaitHT < 5 then
			nTimeWaitHT = 5;
		end
		AutoAi:StartTrainHT();
end

function uiAutoHT:UpdateFollow(nIndex)
	local szName = Lst_GetCell(self.UIGROUP, self.TEAM_MEMBER_LIST, nIndex, 0);
	local nItemData = Lst_GetLineData(self.UIGROUP, self.TEAM_MEMBER_LIST, nIndex);	
	Map.tbAutoAimHT:FollowData(szName,nItemData)
end

uiAutoHT.UpdateAimCfg = function(self)
	local AimCfg =
	{
		nYaoDelay	= 0.5,
		nLifeRet	= 1500,
		nManaRet	= 200,
		nHealDelay	= 2.5,
		nAutoEat	= 1,
	};
	Map.tbAutoAimHT:UpdateSetting(AimCfg)
end

function uiAutoHT:OnMenuItemSelected(szWnd, nItemId, nParam)
	nMapHT = nItemId;
	Btn_SetTxt("UI_AUTOHT",BUTTON_CHOOSE_MAP,tbListMapHT[nMapHT].Name);	
	nNextHT = 1; 
	nActionTypeHT = 1;
	TimeWaitHT = 0;
	nFinishHT = 0;
	Timer1 = 0;
end

function AutoAi:StartTrainHT()
	Timer1 = 0;
	nActionTypeHT = 1; --bat dau
	nNextHT = 1; --con dau tien
	nFinishHT = 0;
	TimeWaitHT = 0;
	if nTimerId1 ~= 0 then
		Ui.tbLogic.tbTimer:Close(nTimerId1);
	end
	nTimerId1 = Ui.tbLogic.tbTimer:Register(IntervalHT * Env.GAME_FPS,self.TrainHTOnTime, self);		
end

function AutoAi:TrainHTOnTime()
	
	if (me.IsDead() == 1) then
		me.SendClientCmdRevive(0);
		nActionTypeHT = 1;
		nCloseSayWnd = 0;
		if me.nAutoFightState == 1 then
			AutoAi.ProcessHandCommand("auto_fight", 0);
		end		
		return
	end
	
	local nX1
	local nY1	
	local nXout 
	local nYout	
	local bChecked = me.GetNpc().IsRideHorse();
	
	if nActionTypeHT == 0 then
		Ui.tbLogic.tbTimer:Close(nTimerId1);
		nTimerId1 = 0;
	elseif nActionTypeHT == 1 then
		if bChecked	~= 1 then
			Switch([[horse]])
		end
		if me.nAutoFightState == 1 then
			AutoAi.ProcessHandCommand("auto_fight", 0);
		end
		nX1 = tbListHT[tbListMapHT[nMapHT].idMapListHT + nNextHT].x
		nY1 = tbListHT[tbListMapHT[nMapHT].idMapListHT + nNextHT].y
		local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
			nXout = nCurWorldPosX
			nYout = nCurWorldPosY
		-- n???u trong ph???m vi ????nh
		if nMapId == tbListHT[tbListMapHT[nMapHT].idMapListHT + nNextHT].mapid then
			if math.abs(nX1-nCurWorldPosX) < 5 and  math.abs(nY1-nCurWorldPosY) < 5 then
				uiAutoHT:AutoFood();
				uiAutoHT:AutoLife();
				if me.nAutoFightState ~= 1 then
					--bat ctrl F
					AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey())	
				end
				nActionTypeHT = 2;				
			else					
				me.AutoPath(nX1, nY1);
			end
		elseif (nMapId <30 and nMapId >22) or (nMapId <9 and nMapId >0) then
			if (AutoBuyHPStatus == 1) or (AutoBuyMPStatus == 1)then			
				local nFreeBag = me.CalcFreeItemCountInBags(19,3,1,5,0,0);
				local nCountHP = me.GetItemCountInBags(17,1,1,nLvBuyItem);
				local nCountMP = me.GetItemCountInBags(17,2,1,nLvBuyItem);
				local muadcko = 0;
				if (nCountHP < nMinHP) and (AutoBuyHPStatus == 1) and (nFreeBag > 0) then
					uiAutoHT:BuyHP();		
					muadcko = 1;
				end
				if (nCountMP < nMinMP) and (AutoBuyMPStatus == 1) and (nFreeBag > 0) then
					uiAutoHT:BuyMP();
					muadcko = 1;
				end
				if (muadcko == 0) then
					nMapId = tbListHT[tbListMapHT[nMapHT].idMapListHT + nNextHT].mapid;
					local tbPosInfo ={}
					tbPosInfo.szType = "pos"
					tbPosInfo.szLink = ","..nMapId..","..nX1..","..nY1
					Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,tbPosInfo);						
				end
			else --chay nhu bt
				nMapId = tbListHT[tbListMapHT[nMapHT].idMapListHT + nNextHT].mapid;
				local tbPosInfo ={}
				tbPosInfo.szType = "pos"
				tbPosInfo.szLink = ","..nMapId..","..nX1..","..nY1
				Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,tbPosInfo);		
			end
		elseif UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) ~= 1 then	
			nMapId = tbListHT[tbListMapHT[nMapHT].idMapListHT + nNextHT].mapid;
			local tbPosInfo ={}
			tbPosInfo.szType = "pos"
			tbPosInfo.szLink = ","..nMapId..","..nX1..","..nY1
			Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,tbPosInfo);
		end
	elseif nActionTypeHT == 2 then
		if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) and (nCloseSayWnd == 0) then
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
				nCloseSayWnd = 1;
			end
		local tbSkillInfo	= KFightSkill.GetSkillInfo(me.nLeftSkill, 1);
		if (tbSkillInfo.nHorseLimited == 1 and me.GetNpc().nIsRideHorse == 1) then	-- k??? n??ng ph???i xu???ng ng???a??? xu???ng ng???a l???p t???c
			Switch("horse");	-- xu???ng ng???a 
		end
		local nId = uiAutoHT:GetAroundNpcId(tbListHT[tbListMapHT[nMapHT].idMapListHT + nNextHT].npcid)
		if nId then
			nLastTimeSeeHT = GetTime();
			if nFinishHT == 0 then
				nFinishHT = 1;
			end
		elseif (GetTime() - nLastTimeSeeHT > MaxLastTimeSeeHT) then
			if nFinishHT == 0 then
				TimeWaitHT = TimeWaitHT + 1;
				if TimeWaitHT == nTimeWaitHT then --chuyen con khac
					nFinishHT = 0;
					nActionTypeHT = 1; --chuyen trang thai
					TimeWaitHT = 0; --thoi gian doi ve 0
					if nNextHT == 4 then
						nNextHT = 1;
					else
						nNextHT = nNextHT + 1;
					end
					if KickPtStatus == 1 then
						uiAutoHT:KickIfNotIsFriend();
					end
				end						
			elseif nFinishHT == 1 then --da ket thuc HT
				nFinishHT = 0;
				nActionTypeHT = 1; --chuyen trang thai
				TimeWaitHT = 0;
				if nNextHT == 4 then
					nNextHT = 1;
				else
					nNextHT = nNextHT + 1;
				end	
				if KickPtStatus == 1 then
					uiAutoHT:KickIfNotIsFriend();
				end				
			end
		end		
	end	
end

function uiAutoHT:BuyHP()
	local nId = uiAutoHT:GetAroundNpcId(3564)
	if nId then
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			me.AnswerQestion(0)
	
			local function fnCloseSay3()
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
				return 0
			end
			local function fnbuy()
				local nCountHP = me.GetItemCountInBags(17,1,1,nLvBuyItem); -- Mua m??u
				--local nCountMP = me.GetItemCountInBags(17,2,1,nLvBuyItem); -- Mua lo???i v???a m??u v???a mana , n???u mua mana ch???nh th??nh 17,2,1				
				if nCountHP < nMinHP then
					--local pItem = KItem.GetItemObj(675 + nLvBuyItem); --					
					local nFreeBag = me.CalcFreeItemCountInBags(19,3,1,5,0,0);
					if nFreeBag > nMaxHP - nCountHP then
						nFreeBag = nMaxHP - nCountHP
					end
					local bOK, szMsg = me.ShopBuyItem(675 + nLvBuyItem, nFreeBag); --
					--local bOK, szMsg = me.ShopBuyItem(675 + nLvBuyItem, 7);
				--elseif nCountMP < nCBuyMP then
				--	--local pItem = KItem.GetItemObj(680 + nLvBuyItem); --
				--	local bOK, szMsg = me.ShopBuyItem(680 + nLvBuyItem, nCBuyMP - nCountMP); --
				end

				UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIREXALL_SEND);
							
				if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
					UiManager:CloseWindow(Ui.UI_SHOP);
					UiManager:CloseWindow(Ui.UI_ITEMBOX);
				end

				--nFlagHPMP = 0
				return 0
			end
	
			Ui.tbLogic.tbTimer:Register(15, fnCloseSay3);
			Ui.tbLogic.tbTimer:Register(40, fnbuy);
		elseif  UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
			--trong l??c mua ????? c??i g?? c??ng kh??ng l??m, m??i ????? tr?????c	
		else
			AutoAi.SetTargetIndex(nId);
		end
	else									
		--me.Msg("T??m Tr????ng Tr???m Kinh")
		uiAutoHT:fnfindNpc(3564,"Tr????ng Tr???m Kinh");
	end	
end


function uiAutoHT:BuyMP()
	local nId = uiAutoHT:GetAroundNpcId(3564)
	if nId then
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			me.AnswerQestion(0)
	
			local function fnCloseSay3()
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
				return 0
			end
			local function fnbuy()
				local nCountMP = me.GetItemCountInBags(17,2,1,nLvBuyItem);							
				if nCountMP < nMinMP then
					--local pItem = KItem.GetItemObj(675 + nLvBuyItem); --					
					local nFreeBag = me.CalcFreeItemCountInBags(19,3,1,5,0,0);
					if nFreeBag > nMaxMP - nCountMP then
						nFreeBag = nMaxMP - nCountMP
					end
					local bOK, szMsg = me.ShopBuyItem(680 + nLvBuyItem, nFreeBag);
					--local bOK, szMsg = me.ShopBuyItem(675 + nLvBuyItem, 7);
				--elseif nCountMP < nCBuyMP then
				--	--local pItem = KItem.GetItemObj(680 + nLvBuyItem); --
				--	local bOK, szMsg = me.ShopBuyItem(680 + nLvBuyItem, nCBuyMP - nCountMP); --
				end

				UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIREXALL_SEND);
							
				if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
					UiManager:CloseWindow(Ui.UI_SHOP);
					UiManager:CloseWindow(Ui.UI_ITEMBOX);
				end

				--nFlagHPMP = 0
				return 0
			end
	
			Ui.tbLogic.tbTimer:Register(15, fnCloseSay3);
			Ui.tbLogic.tbTimer:Register(40, fnbuy);
		elseif  UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
			--trong l??c mua ????? c??i g?? c??ng kh??ng l??m, m??i ????? tr?????c	
		else
			AutoAi.SetTargetIndex(nId);
		end
	else									
		--me.Msg("T??m Tr????ng Tr???m Kinh")
		uiAutoHT:fnfindNpc(3564,"Tr????ng Tr???m Kinh");
	end	
end


function uiAutoHT:GetAroundNpcId(nTempId)	
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, RangerSeeHT);
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == nTempId) then				
			return pNpc.nIndex
		end
	end
	return
end

function uiAutoHT:fnfindNpc(nNpcId, szName)
	local nMyMapId	= me.GetMapTemplateId();
	local nTargetMapId;
	if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
		nTargetMapId = nMyMapId;
	elseif self.nCityId then
		nTargetMapId =  self.nCityId
	else
		nTargetMapId = 25
	end

	local nX1, nY1;
	nX1, nY1 = KNpc.ClientGetNpcPos(nTargetMapId, nNpcId);

	if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
	me.AutoPath(nX1, nY1)
	else
	local tbPosInfo ={}
	tbPosInfo.szType = "pos"
	tbPosInfo.szLink = szName..","..nTargetMapId..","..nX1..","..nY1
	--me.Msg("Link:"..tbPosInfo.szLink)
	Map.tbSuperMapLink.StartGoto(Map.tbSuperMapLink,tbPosInfo);
	end
end

function uiAutoHT:CTestLv()
    --Ki???m tra s??? l?????ng HP, MP trong tui v?? mua
	--local nLvBuyItem
	if me.nLevel > 89 then
		nLvBuyItem = 4
	elseif me.nLevel > 69 then 
		nLvBuyItem = 4
	elseif me.nLevel > 49 then 
		nLvBuyItem = 3
	elseif me.nLevel > 29 then
		nLvBuyItem = 2
	else
		nLvBuyItem = 1
	end
	    nLvBuyItem = 4
	return 
end

function  uiAutoHT:EatBattleMedicine(nType)
	-- find blood medicine
	local tbItemList = me.FindItemInBags(Item.MEDICINE, 0, nType);
	
	-- nothing found, nothing to do
	if((not tbItemList) or (#tbItemList == 0)) then
		return false;
	end
	local pItem = tbItemList[1].pItem;
	me.Msg(pItem.szName);
	if(me.CanUseItem(pItem)) then
		me.Msg("S??? d???ng thu???c <color=yellow>" .. pItem.szName .. "<color>");
		return me.UseItem(pItem);
	end
	return false;
end

function  uiAutoHT:EatMedicine(nType)
	-- find blood medicine
	local tbItemList = me.FindItemInBags(Item.MEDICINE, nType);
	
	-- nothing found, nothing to do
	if((not tbItemList) or (#tbItemList == 0)) then
		return false;
	end
	local pItem = tbItemList[1].pItem;
	me.Msg(pItem.szName);
	if(me.CanUseItem(pItem)) then
		me.Msg("S??? d???ng thu???c <color=yellow>" .. pItem.szName .. "<color>");
		return me.UseItem(pItem);
	end
	return false;
end

function  uiAutoHT:EatFood()
	-- find food
	local tbItemList = me.FindItemInBags(Item.SKILLITEM);
	
	-- nothing found, nothing to do
	if((not tbItemList) or (#tbItemList == 0)) then
		return false;
	end
	local pItem = tbItemList[1].pItem;
	if(me.CanUseItem(pItem)) then
		me.Msg("S??? d???ng th???c ??n <color=yellow>" .. pItem.szName .. "<color>");
		return me.UseItem(pItem);
	end
	return false;
end

function  uiAutoHT:AutoFood()
--	local tbConfig = self.tbConfig;
	if(not bAutoFood) then
		return;
	end
	
	local nLevel, nState, nTime = me.GetSkillState(AutoAi.FOOD_SKILL_ID);
	if (not nTime or nTime < Env.GAME_FPS * 3)  then
		uiAutoHT:EatFood();
	end	
end

function  uiAutoHT:AutoLife()
--	local tbConfig = self.tbConfig;
	local nCurLife = me.nCurLife;
	local nCurLife_P = AutoAi.AI_GetLifePercent(me.GetNpc().nIndex);
	if(not bAutoLife) then
		return;
	end
	if((nAutoLifeLv1 > 0) and (nCurLife < nAutoLifeLv1) and (GetTime() - self.nTimeLastAutoLife1 > nAutoLifeDelay)) then
		if(not self:EatBattleMedicine(1)) then
			if(not self:EatBattleMedicine(3)) then
				if(not self:EatMedicine(1)) then
					self:EatMedicine(3);
				end
			end
		end
		self.nTimeLastAutoLife1 = GetTime();
		return;
	end
	-- level 2
	if((nAutoLifeLv2 > 0) and (nCurLife < nAutoLifeLv2) and (GetTime() - self.nTimeLastAutoLife2  > nAutoLifeDelay)) then
		if(not self:EatBattleMedicine(1)) then
			if(not self:EatBattleMedicine(3)) then
				if(not self:EatMedicine(1)) then
					self:EatMedicine(3);
				end
			end
		end
		self.nTimeLastAutoLife2 = GetTime();
		return;
	end
	-- level 3
	if((nAutoLifeLv3 > 0) and (nCurLife < nAutoLifeLv3) and (GetTime() - self.nTimeLastAutoLife3 > nAutoLifeDelay)) then
		if(not self:EatBattleMedicine(1)) then
			if(not self:EatBattleMedicine(3)) then
				if(not self:EatMedicine(1)) then
					self:EatMedicine(3);
				end
			end
		end
		self.nTimeLastAutoLife3 = GetTime();
		return;
	end
	
	-- auto hp percent
	-- level 1
	if((nAutoLifeLv1_P > 0) and (nCurLife_P < nAutoLifeLv1_P) and (GetTime() - self.nTimeLastAutoLife1_P > nAutoLifeDelay_P)) then
		if(not self:EatBattleMedicine(1)) then
			if(not self:EatBattleMedicine(3)) then
				if(not self:EatMedicine(1)) then
					self:EatMedicine(3);
				end
			end
		end
		self.nTimeLastAutoLife1_P = GetTime();
		return;
	end
	-- level 2
	if((nAutoLifeLv2_P > 0) and (nCurLife_P < nAutoLifeLv2_P) and (GetTime() - self.nTimeLastAutoLife2_P  > nAutoLifeDelay_P)) then
		if(not self:EatBattleMedicine(1)) then
			if(not self:EatBattleMedicine(3)) then
				if(not self:EatMedicine(1)) then
					self:EatMedicine(3);
				end
			end
		end
		self.nTimeLastAutoLife2_P = GetTime();
		return;
	end
	-- level 3
	if((nAutoLifeLv3_P > 0) and (nCurLife_P < nAutoLifeLv3_P) and (GetTime() - self.nTimeLastAutoLife3_P > nAutoLifeDelay_P)) then
		if(not self:EatBattleMedicine(1)) then
			if(not self:EatBattleMedicine(3)) then
				if(not self:EatMedicine(1)) then
					self:EatMedicine(3);
				end
			end
		end
		self.nTimeLastAutoLife3_P = GetTime();
		return;
	end
	
end

function uiAutoHT:CheckErrorData(szDate)
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

function uiAutoHT:KickIfNotIsFriend()
	local isfriend = 0;
	tbList = {};
	tbList2 = {};
	tbListEx = {};
	local tbRelationList, tbInfo = me.Relation_GetRelationList()	
	if (not tbRelationList) then
		return;
	end	
	tbList = self:MergeTableHT(
			tbRelationList[Player.emKPLAYERRELATION_TYPE_BIDFRIEND],
			tbRelationList[Player.emKPLAYERRELATION_TYPE_TMPFRIEND]
		);	
	tbListEx = self:_GetPlayerListHT(Player.emKPLAYERRELATION_TYPE_INTRODUCTION, 1);	-- nRole = 1 ???????????????
	tbList = self:MergeTableHT(tbList, tbListEx);	
	
	tbListEx = {};
	tbRelationTypes = {};
	self:InsertToBuddyListHT(tbList2, tbRelationList[Player.emKPLAYERRELATION_TYPE_BUDDY]);
	tbListEx = self:_GetPlayerListHT(Player.emKPLAYERRELATION_TYPE_INTRODUCTION, 0);	-- nRole = 1 ???????????????
	self:InsertToBuddyListHT(tbList2, tbListEx);
	
	local nAllotModel, tbMemberList = me.GetTeamInfo();
	if not tbMemberList then
		return;
	end	
	for i = 1, #tbMemberList do
		if tbMemberList[i].szName and tbMemberList[i].nPlayerID then			
			--me.Msg("Name="..tbMemberList[i].szName..", id="..tbMemberList[i].nPlayerID);
			isfriend = 0;
			if tbList then
				for szPlayer, tbRelation in pairs(tbList) do
					--me.Msg("ten = "..szPlayer);			
					if tbMemberList[i].szName == szPlayer then
						--me.Msg(szPlayer.."nam trong list");
						isfriend = 1;
						break;
					end
				end		
			end
			if tbList2 and isfriend == 0 then
				for szPlayer, tbRelation in pairs(tbList2) do
					--me.Msg("ten = "..szPlayer);			
					if tbMemberList[i].szName == szPlayer then
						--me.Msg(szPlayer.."nam trong list");
						isfriend = 1;
						break;
					end
				end		
			end
			if isfriend == 0 then
				me.TeamKick(tbMemberList[i].nPlayerID);
			end
		end
	end	
end

function uiAutoHT:InsertToBuddyListHT(tbBuddyList, tbListEx)
	if not tbBuddyList then
		return 0;
	end
	if not tbRelationTypes then
		tbRelationTypes = {};
	end
	if tbListEx then
		for szPlayer, tbRelation in pairs(tbListEx) do
			tbBuddyList[szPlayer] = tbRelation;
			if not tbRelationTypes[szPlayer] then
				tbRelationTypes[szPlayer] = {}
			end
			table.insert(tbRelationTypes[szPlayer], tbRelation.nType);
		end
	end
	return tbBuddyList;
end

function uiAutoHT:NormalSortHT(tbList)
	local _, tbInfo = me.Relation_GetRelationList()
	local tbSortList = {};
	local tbTempFriend	= {};
	
	if tbList then
		for szPlayer, tbRelation in pairs(tbList) do
			local tbItem = {};
			tbItem.szPlayer = szPlayer;
			tbItem.nOnline	= tbRelation.nOnline;

			if tbInfo[szPlayer] then
				tbItem.nFavor = tbInfo[szPlayer].nFavor;
				table.insert(tbSortList, tbItem);
			else
				table.insert(tbTempFriend, tbItem);
			end
		end
		
		if (#tbSortList > 1) then
			table.sort(tbSortList, self._Cmp);
		end
	end
	for _, pPlayer in ipairs(tbTempFriend) do
		table.insert(tbSortList, pPlayer);
	end
	
	return tbSortList;
end

function uiAutoHT:_GetPlayerListHT(nType, nRole)
	local tbList = {};
	local tbRelationList = me.Relation_GetRelationList();
	if not tbRelationList then
		return tbList;
	end
	if tbRelationList[nType] then
		for szPlayer, tbInfo in pairs(tbRelationList[nType]) do
			if tbInfo.nRole == nRole then
				tbList[szPlayer] = tbInfo
			end
		end
	end
	return tbList;
end

function uiAutoHT:MergeTableHT(tbA, tbB)
	local tbList = {}
	if tbA then
		for varIndex, varItem in pairs(tbA) do
			tbList[varIndex] = varItem
		end
	end

	if tbB then
		for varIndex, varItem in pairs(tbB) do
			tbList[varIndex] = varItem
		end
	end
	return tbList;
end

function uiAutoHT:OnClose()
	
	
end

Ui:RegisterNewUiWindow("UI_AUTOHT", "autoht", {"a", 250, 150}, {"b", 250, 150}, {"c", 250, 150});

local tCmd={ "UiManager:SwitchWindow(Ui.UI_AUTOHT)", "UI_AUTOHT", "", "Alt+H", "Alt+H", "san ht"};
        AddCommand(tCmd[4], tCmd[4], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
        UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);
	  
	  