local uiAutoFight = Ui(Ui.UI_AUTOFIGHT);
local tbSaveData = Ui.tbLogic.tbSaveData;
local tbObject  = Ui.tbLogic.tbObject;
local tbTempItem 		= Ui.tbLogic.tbTempItem;
local tbMouse 			= Ui.tbLogic.tbMouse;
local tbTimer			= Ui.tbLogic.tbTimer;
local self				= uiAutoFight;

uiAutoFight.BTN_Reload				= "BtnReload";
uiAutoFight.BTN_SettingPK			= "BtnSettingPK";
uiAutoFight.BUTTON_CLOSE			= "BtnClose";
uiAutoFight.BUTTON_EXIT				= "BtnExit";
uiAutoFight.BUTTON_SAVE				= "BtnSave";
uiAutoFight.TXX_INFOR				= "TxtExInFor";
uiAutoFight.TXT_BUFF				= "TxtBuff";
uiAutoFight.BUTTON_AUTOFIGHT		= "BtnAutoFight";
uiAutoFight.BUTTON_PICKITEM			= "BtnPickItem";
uiAutoFight.BUTTON_sqpc				= "Btnsqpc";
uiAutoFight.TXT_PICKITEMSTAR		= "TxtPickItemStar";
uiAutoFight.TXT_LIFE				= "TxtLife";
uiAutoFight.OBJ_SkILL				= "ObjSkill";
uiAutoFight.PAGE					= "Page";
uiAutoFight.SCROLL_ITEMSTAR			= "ScrbarItemStar";
uiAutoFight.SCROLL_LIFE				= "ScrbarLife";
uiAutoFight.SCROLL_BUFF				= "ScrbarBuff";
uiAutoFight.DATA_KEY				= "AutoFight";
uiAutoFight.OBJ_SkILL_ROW			= 6;
uiAutoFight.OBJ_SkILL_LINE			= 1;
uiAutoFight.BUTTON_TEAM				= "BtnTeam";
uiAutoFight.BUTTON_REPAIR			= "BtnRepair";
uiAutoFight.BUTTON_DRINK			= "BtnDrink";
uiAutoFight.BUTTON_JOIN				= "BtnJoin";
uiAutoFight.BUTTON_SiwanFanhui		= "BtnSiwanFanhui";
uiAutoFight.BUTTON_ENHANCEPICK		= "BtnEnhancePick";
uiAutoFight.BUTTON_FUDAIWUXIE		= "BtnFuDaiWuXie";
uiAutoFight.BUTTON_DUSHU			= "BtnRead";
uiAutoFight.BUTTON_DUSHU_MOVE		= "BtnMoveRead";
uiAutoFight.BUTTON_AUTOXLZ			= "BtnXiuLianZhu";
uiAutoFight.BUTTON_PVP_MODE			= "BtnPvpMode";
uiAutoFight.BUTTON_AUTO_MED			= "BtnAutoMed";
uiAutoFight.OBJ_MEDICAMENT			= "ObjMedicament";
uiAutoFight.OBJ_MEDICAMENT_ROW		= 2;
uiAutoFight.OBJ_MEDICAMENT_LINE		= 1;
--------------------------
uiAutoFight.BUTTON_OPENJIUXIANG		= "BtnOpenJiuXiang";
uiAutoFight.BUTTON_PKfanji			= "BtnPKfanji";
uiAutoFight.BTN_QINGCHU = "Qingchu";
uiAutoFight.BTN_TBSKILLID = "TbSkillId";
uiAutoFight.BTN_PK0 = "Pk0";
uiAutoFight.BTN_PK1 = "Pk1";
---------------------------
local tbObjSkillCont = { bShowCd = 0, bUse = 0, bLink = 0, bSwitch = 0};
local tbObjMedicamentCont 	= {bShowCd = 0, bUse = 0, bLink = 0};

function uiAutoFight:Init()
	self.bAutoFight			= 0;
	self.bPickItem			= 0;
	self.nAcceptTeam		= 1;
	self.nAutoRepair		= 1;
	self.nPickStar			= 2;
	self.nLifeRet			= 60;
	self.nBuffRet			= 70;
	self.nLeftSkillId		= 0;
	self.nRightSkillId		= 0;
	----------------------------
	self.n3SkillId	= 0;
	self.n4SkillId	= 0;
	self.n5SkillId	= 0;
	self.n6SkillId	= 0;
	self.nAutoOpenJiuXiang	= 0;
	self.nPKfanji	=0;--------------------
	-----------------------------
	self.nAutoDrink			= 1;
	self.nAutoEnhancePick	= 0;
	self.nAutoFDWX			= 0;
	self.nAutoRead			= 1;
	self.nAutoRead_Move		= 0;
	self.nAutoXLZ			= 0;
	self.nSkill				= 0;
	self.nJoin				= 1;
	self.nDead				= 0;
	self.tbFightSetting 	= {};
	self.nPvpMode 			= 0;
end

function uiAutoFight:OnCreate()
	self.tbObjSkillCont = tbObject:RegisterContainer(
		self.UIGROUP,
		self.OBJ_SkILL,
		self.OBJ_SkILL_ROW,
		self.OBJ_SkILL_LINE,
		tbObjSkillCont
	);
	self.tbObjMedicamentCont = tbObject:RegisterContainer(
		self.UIGROUP,
		self.OBJ_MEDICAMENT,
		self.OBJ_MEDICAMENT_ROW,
		self.OBJ_MEDICAMENT_LINE,
		tbObjMedicamentCont
	);
end

function uiAutoFight:OnDestroy()
	tbObject:UnregContainer(self.tbObjSkillCont);
	tbObject:UnregContainer(self.tbObjMedicamentCont);
end

function uiAutoFight:OnObjGridSwitch(szWnd, nX, nY)
	if szWnd == self.OBJ_SkILL then
		if nX == 0 then
			UiManager:SwitchWindow(Ui.UI_SKILLTREE, "AUTOLEFTSKILL");
		elseif nX == 1 then
			UiManager:SwitchWindow(Ui.UI_SKILLTREE, "AUTORIGHTSKILL");
		elseif nX == 2 then
			UiManager:SwitchWindow(Ui.UI_SKILLTREE, "AUTO3SKILL");
		elseif nX == 3 then
			UiManager:SwitchWindow(Ui.UI_SKILLTREE, "AUTO4SKILL");
		elseif nX == 4 then
			UiManager:SwitchWindow(Ui.UI_SKILLTREE, "AUTO5SKILL");
		elseif nX == 5 then
			UiManager:SwitchWindow(Ui.UI_SKILLTREE, "AUTO6SKILL");
		end
	end
end

function uiAutoFight:OnOpen()
	self:Init();
	self:LoadSetting();
	self.bAutoFight = me.nAutoFightState;
	self:UpdateWnd();
	local szText = "<a=infor>Trợ Giúp<a>";
	TxtEx_SetText(self.UIGROUP, self.TXX_INFOR, szText);
end

function uiAutoFight:OnButtonClick(szWnd, nParam)
	if szWnd == self.BUTTON_CLOSE  or szWnd == self.BUTTON_EXIT  then
		UiManager:CloseWindow(self.UIGROUP);

	elseif szWnd == self.BUTTON_SAVE then
		self:SaveData();
		uiAutoFight:UpdateAction();
		UiManager:CloseWindow(self.UIGROUP);
		
	elseif szWnd == self.BTN_Reload then	
           AutoAi:Reload();
	
	elseif szWnd == self.BTN_SettingPK then	
        UiManager:SwitchWindow("UI_PERESPLUS_SETTING");

	elseif szWnd == self.BUTTON_AUTOFIGHT then
		self.bAutoFight = nParam;

	elseif szWnd == self.BUTTON_PVP_MODE then
		self.nPvpMode = nParam;
	
	elseif szWnd == self.BUTTON_sqpc then
		UiManager:OpenWindow(Ui.UI_NOPICK_SETTING);		

	elseif szWnd == self.BUTTON_AUTO_MED then
		if nParam == 1 then
			self:StartAutoMed();
		elseif nParam == 0 then
			self:StopAutoMed();
		end

	elseif szWnd == self.BUTTON_PICKITEM then
		self.bPickItem = nParam;

	elseif szWnd == self.BUTTON_TEAM then
		self.nAcceptTeam = nParam;

	elseif szWnd == self.BUTTON_REPAIR then
		self.nAutoRepair = nParam;

	elseif szWnd == self.BUTTON_DRINK then
		self.nAutoDrink = nParam;

	elseif szWnd == self.BUTTON_ENHANCEPICK then
		self.nAutoEnhancePick = nParam;

	elseif szWnd == self.BUTTON_FUDAIWUXIE then
		self.nAutoFDWX=nParam;
		Btn_Check(self.UIGROUP, BUTTON_FUDAIWUXIE, 0);
		self.nAutoFDWX=0;

	elseif szWnd == self.BUTTON_DUSHU then
		self.nAutoRead=nParam;
		self.nAutoRead_Move=0;
		Btn_Check(self.UIGROUP, self.BUTTON_DUSHU_MOVE, 0);

	elseif szWnd == self.BUTTON_DUSHU_MOVE then
		self.nAutoRead_Move=nParam;
		self.nAutoRead=0;
		Btn_Check(self.UIGROUP, self.BUTTON_DUSHU, 0);

	elseif szWnd==self.BUTTON_AUTOXLZ then
		self.nAutoXLZ=nParam;
	elseif szWnd==self.BUTTON_JOIN then
		self.nJoin=nParam;

	elseif szWnd==self.BUTTON_SiwanFanhui then
		self.nDead=nParam;
	-----------------------------------------------------------
	elseif szWnd == self.BUTTON_OPENJIUXIANG then
		self.nAutoOpenJiuXiang = nParam;
		
	elseif szWnd == self.BUTTON_PKfanji then
		self.nPKfanji=nParam;
	-----------------------------------------------------------	
	elseif szWnd == self.BTN_QINGCHU then
		uiAutoFight.SaveData(uiAutoFight, "Qingchu")
		self:UpdateAction();
		UiManager:OpenWindow(self.UIGROUP);
		
	elseif szWnd == self.BTN_TBSKILLID then
		me.Msg(string.format("<bclr=0,0,200><color=white>Kỹ năng: 1=%d 2=%d 3=%d 4=%d 5=%d 6=%d",self.nLeftSkillId,self.nRightSkillId,self.n3SkillId,self.n4SkillId,self.n5SkillId,self.n6SkillId));
		
	elseif szWnd == self.BTN_PK0 then
		uiAutoFight.SaveData(uiAutoFight, "Pk0")
		self:UpdateAction();
		UiManager:OpenWindow(self.UIGROUP);
		
	elseif szWnd == self.BTN_PK1 then
		uiAutoFight.SaveData(uiAutoFight, "Pk1")
		self:UpdateAction();
		UiManager:OpenWindow(self.UIGROUP);
	----------------------------------------------------------
	end
end

uiAutoFight.SaveData=function(self, SetSkillId)
---------------------------------------------------------------
	local tbSkillIdPk0 = {
	[0] = {[0] = {1,0,0,0,0,0}}, 		
	[1] = {[1] = {1241,27,24,21,0,0},[2]={821,31,36,33,29,4}},
	[2] = {[1] = {823,41,47,43,38,0},[2]={41,56,53,50,6,0}}, 
	[3] = {[1] = {285,1245,828,69,74,72},[2]={830,1246,66,62,59,0}}, 
	[4] = {[1] = {831,83,80,76,0,0},[2]={833,93,90,86,0,0}},
	[5] = {[1] = {103,99,96,0,0,0},[2]={837,107,2,0,0,0}},
	[6] = {[1] = {839,840,1209,117,114,111},[2]={125,123,120,4,0,0}}, 
	[7] = {[1] = {489,134,131,128,0,0},[2]={845,141,140,137,0,0}}, 
	[8] = {[1] = {148,492,847,149,146,143},[2]={155,151,494,156,0,0}}, 
	[9] = {[1] = {852,165,162,159,2,0},[2]={1216,1258,171,169,167,2}}, 
	[10] = {[1] = {181,178,175,3,0,0},[2]={1261,699,192,190,188,0}}, 
	[11] = {[1] = {1261,198,199,202,194,6},[2]={770,211,208,205,0,0}}, 
	[12] = {[1] = {1263,216,223,217,213,0},[2]={865,866,232,229,226,0}}, 
	};
	
	local tbSkillIdPk1 = {
	[0] = {[0] = {1,0,0,0,0,0}},		
	[1] = {[1] = {283,27,24,21,3,0},[2]={283,36,33,29,0,0}}, 
	[2] = {[1] = {283,41,47,43,38,0},[2]={283,41,56,53,50,6}},
	[3] = {[1] = {285,69,72,0,0,0},[2]={285,66,62,59,0,0}}, 
	[4] = {[1] = {285,831,83,80,76,0},[2]={285,93,90,86,0,0}}, 
	[5] = {[1] = {103,99,96,0,0,0},[2]={837,107,2,0,0,0}}, 
	[6] = {[1] = {117,114,111,0,0,0},[2]={125,123,120,4,0,0}}, 
	[7] = {[1] = {289,489,134,131,128,0},[2]={289,845,141,140,137,0}},
	[8] = {[1] = {289,149,146,143,0,0},[2]={289,151,156,0,0,0}}, 
	[9] = {[1] = {291,165,162,159,2,0},[2]={291,1216,171,169,167,0}}, 
	[10] = {[1] = {291,181,178,175,3,0},[2]={291,192,190,188,0,0}}, 
	[11] = {[1] = {285,198,199,202,194,0},[2]={285,211,208,205,0,0}}, 
	[12] = {[1] = {216,223,217,213,0,0},[2]={866,232,229,226,0,0}}, 
	};
	
	if SetSkillId == "Qingchu" then
 		self.nLeftSkillId	= 0;
		self.nRightSkillId	= 0;
		self.n3SkillId	= 0;
		self.n4SkillId	= 0;
		self.n5SkillId	= 0;
		self.n6SkillId	= 0;
		
	elseif SetSkillId == "Pk0" and #tbSkillIdPk0[me.nFaction][me.nRouteId] == 6 then
 		self.nLeftSkillId	= tbSkillIdPk0[me.nFaction][me.nRouteId][1];
		self.nRightSkillId	= tbSkillIdPk0[me.nFaction][me.nRouteId][2];
		self.n3SkillId	= tbSkillIdPk0[me.nFaction][me.nRouteId][3];
		self.n4SkillId	= tbSkillIdPk0[me.nFaction][me.nRouteId][4];
		self.n5SkillId	= tbSkillIdPk0[me.nFaction][me.nRouteId][5];
		self.n6SkillId	= tbSkillIdPk0[me.nFaction][me.nRouteId][6];
		me.Msg("<bclr=red><color=yellow>Chế độ Skill tự động PK1<color><bclr>")
		
	elseif SetSkillId == "Pk0" and #tbSkillIdPk0[me.nFaction][me.nRouteId] ~= 6 then
		me.Msg(string.format("#tbSkillIdPk0[%d][%d] ~= 6",me.nFaction,me.nRouteId));
		
	elseif SetSkillId == "Pk1" and #tbSkillIdPk1[me.nFaction][me.nRouteId] == 6 then
 		self.nLeftSkillId	= tbSkillIdPk1[me.nFaction][me.nRouteId][1];
		self.nRightSkillId	= tbSkillIdPk1[me.nFaction][me.nRouteId][2];
		self.n3SkillId	= tbSkillIdPk1[me.nFaction][me.nRouteId][3];
		self.n4SkillId	= tbSkillIdPk1[me.nFaction][me.nRouteId][4];
		self.n5SkillId	= tbSkillIdPk1[me.nFaction][me.nRouteId][5];
		self.n6SkillId	= tbSkillIdPk1[me.nFaction][me.nRouteId][6];
		me.Msg("<bclr=red><color=yellow>Chế độ Skill tự động PK2<color><bclr>")
		
	elseif SetSkillId == "Pk1" and #tbSkillIdPk1[me.nFaction][me.nRouteId] ~= 6 then
		me.Msg(string.format("#tbSkillIdPk1[%d][%d] ~= 6",me.nFaction,me.nRouteId));
	end
---------------------------------------------------------------
	if self.tbObjMedicamentCont.tbMedInfo then
		self.tbLeftMed = self.tbObjMedicamentCont.tbMedInfo[1];
		self.tbRightMed= self.tbObjMedicamentCont.tbMedInfo[2];
	end

	self.tbFightSetting =
	{
	nUnPickCommonItem 	= self.bPickItem,
	nPickValue 			= self.nPickStar,
	nLifeRet 			= self.nLifeRet,
	nBuffRet 			= self.nBuffRet,
	nSkill1 			= self.nLeftSkillId,
	nSkill2 			= self.nRightSkillId,
	----------------------------------------------
	nSkill3 = self.n3SkillId,
	nSkill4 = self.n4SkillId,
	nSkill5 = self.n5SkillId,
	nSkill6 = self.n6SkillId,
	nAutoOpenJiuXiang = self.nAutoOpenJiuXiang,
	nPKfanji=self.nPKfanji,
	----------------------------------------------
	nAutoRepair 		= self.nAutoRepair,
	nAcceptTeam 		= self.nAcceptTeam,
	nAutoDrink 			= self.nAutoDrink,
	nPvpMode 			= self.nPvpMode,
	tbLeftMed 			= self.tbLeftMed,
	tbRightMed			= self.tbRightMed,
	nAutoEnhancePick	= self.nAutoEnhancePick,
	nAutoFD				= self.nAutoFD,
	nAutoFDWX			= self.nAutoFDWX,
	nAutoRead			= self.nAutoRead,
	nAutoXLZ			= self.nAutoXLZ,
	nSkill				= self.nSkill,
	nAutoRead_Move		= self.nAutoRead_Move,
	nJoin				= self.nJoin,
	nDead				= self.nDead,
	}
	self:Save(self.DATA_KEY, self.tbFightSetting);
end

uiAutoFight.OnScorllbarPosChanged = function(self, szWnd, nParam)
	if szWnd == self.SCROLL_ITEMSTAR then
		local nStar = nParam;
		self.nPickStar = nStar / 2;
	elseif szWnd == self.SCROLL_LIFE then
		local nLifeRet = nParam * 10;
		self.nLifeRet = nLifeRet;
	elseif szWnd == self.SCROLL_BUFF then
		local nBuffRet = nParam * 5;
		self.nBuffRet = nBuffRet;	
	end
	self:UpdateLable();
end

function uiAutoFight.UpdateLable()
	Txt_SetTxt(self.UIGROUP, self.TXT_PICKITEMSTAR, "Nhặt T.Bị > "..self.nPickStar.." ★");
	Txt_SetTxt(self.UIGROUP, self.TXT_LIFE, "Sinh lực < "..self.nLifeRet.."% tự Buff");
	Txt_SetTxt(self.UIGROUP, self.TXT_BUFF, "<color=white>Ngamy Buff: <color=yellow>"..self.nBuffRet.."%<color=white>");
end


function uiAutoFight:UpdateAction()
	local tbAutoAiCfg =
	{
		nAutoFight		 	= self.bAutoFight,
		nUnPickCommonItem	= self.bPickItem,
		nPickValue			= self.nPickStar,
		nLifeRet		  	= self.nLifeRet,
		nBuffRet		  	= self.nBuffRet,
		nSkill1			  	= self.nLeftSkillId,
		nSkill2			  	= self.nRightSkillId,
		----------------------------------------------
		nSkill3				= self.n3SkillId,
        nSkill4				= self.n4SkillId,
        nSkill5				= self.n5SkillId,
        nSkill6				= self.n6SkillId,
		nAutoOpenJiuXiang	= self.nAutoOpenJiuXiang,
		nPKfanji			= self.nPKfanji,
		----------------------------------------------
		nAutoRepair 	  	= self.nAutoRepair,
		nAcceptTeam		  	= self.nAcceptTeam,
		nAutoDrink		  	= self.nAutoDrink,
		nAutoEnhancePick  	= self.nAutoEnhancePick,
		nAutoFD			  	= self.nAutoFD,
		nAutoFDWX			= self.nAutoFDWX,
		nAutoRead			= self.nAutoRead,
		nAutoXLZ			= self.nAutoXLZ,
		nSkill				= self.nSkill,
		nJoin				= self.nJoin,
		nDead				= self.nDead,
		nAutoRead_Move		= self.nAutoRead_Move,
		nPvpMode 			= self.nPvpMode,
		tbLeftMed 			= self.tbLeftMed,
		tbRightMed			= self.tbRightMed,
	};
	AutoAi:UpdateCfg(tbAutoAiCfg)
end


function uiAutoFight:UpdateWnd()
	Btn_Check(self.UIGROUP, self.BUTTON_AUTOFIGHT, self.bAutoFight);
	Btn_Check(self.UIGROUP, self.BUTTON_PICKITEM, self.bPickItem);
	Btn_Check(self.UIGROUP, self.BUTTON_TEAM, self.nAcceptTeam);
	Btn_Check(self.UIGROUP, self.BUTTON_REPAIR, self.nAutoRepair);
	Btn_Check(self.UIGROUP, self.BUTTON_DRINK, self.nAutoDrink);
	Btn_Check(self.UIGROUP, self.BUTTON_ENHANCEPICK, self.nAutoEnhancePick);
	Btn_Check(self.UIGROUP, self.BUTTON_FUDAIWUXIE, self.nAutoFDWX);
	Btn_Check(self.UIGROUP, self.BUTTON_DUSHU, self.nAutoRead);
	Btn_Check(self.UIGROUP, self.BUTTON_JOIN, self.nJoin);
	Btn_Check(self.UIGROUP, self.BUTTON_AUTOXLZ, self.nAutoXLZ);
	Btn_Check(self.UIGROUP, self.BUTTON_SiwanFanhui, self.nDead);
	Btn_Check(self.UIGROUP, self.BUTTON_DUSHU_MOVE, self.nAutoRead_Move);
	-------------------------------------------------------------------------
	Btn_Check(self.UIGROUP, self.BUTTON_OPENJIUXIANG, self.nAutoOpenJiuXiang);
	Btn_Check(self.UIGROUP, self.BUTTON_PKfanji, self.nPKfanji);
	-------------------------------------------------------------------------
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_ITEMSTAR, self.nPickStar * 2);
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_LIFE, self.nLifeRet / 10);
	ScrBar_SetCurValue(self.UIGROUP, self.SCROLL_BUFF, self.nBuffRet / 5);

	self:UpdateLable();
	self.tbObjSkillCont:ClearObj();
	local tbLeftObj = nil;
	tbLeftObj = {};
	tbLeftObj.nType = Ui.OBJ_FIGHTSKILL;
	tbLeftObj.nSkillId = self.nLeftSkillId
	self.tbObjSkillCont:SetObj(tbLeftObj, 0, 0);

	local tbRightObj = nil;
	tbRightObj = {};
	tbRightObj.nType = Ui.OBJ_FIGHTSKILL;
	tbRightObj.nSkillId = self.nRightSkillId
	self.tbObjSkillCont:SetObj(tbRightObj, 1, 0);
	Btn_Check(self.UIGROUP, self.BUTTON_PVP_MODE, self.nPvpMode);
	Btn_Check(self.UIGROUP, self.BUTTON_AUTO_MED, self.nAutoMed);
	
-------------------------------------------------------------------------
	local tb3Obj = nil;
	tb3Obj = {};
	tb3Obj.nType = Ui.OBJ_FIGHTSKILL;
	tb3Obj.nSkillId = self.n3SkillId
	self.tbObjSkillCont:SetObj(tb3Obj, 2, 0);
	Img_SetImage(self.UIGROUP, "ObjSkill3", 1, tbObject:GetObjImage(tb3Obj));

	local tb4Obj = nil;
	tb4Obj = {};
	tb4Obj.nType = Ui.OBJ_FIGHTSKILL;
	tb4Obj.nSkillId = self.n4SkillId
	self.tbObjSkillCont:SetObj(tb4Obj, 3, 0);
	Img_SetImage(self.UIGROUP, "ObjSkill4", 1, tbObject:GetObjImage(tb4Obj));

	local tb5Obj = nil;
	tb5Obj = {};
	tb5Obj.nType = Ui.OBJ_FIGHTSKILL;
	tb5Obj.nSkillId = self.n5SkillId
	self.tbObjSkillCont:SetObj(tb5Obj, 4, 0);
	Img_SetImage(self.UIGROUP, "ObjSkill5", 1, tbObject:GetObjImage(tb5Obj));

	local tb6Obj = nil;
	tb6Obj = {};
	tb6Obj.nType = Ui.OBJ_FIGHTSKILL;
	tb6Obj.nSkillId = self.n6SkillId
	self.tbObjSkillCont:SetObj(tb6Obj, 5, 0);
	Img_SetImage(self.UIGROUP, "ObjSkill6", 1, tbObject:GetObjImage(tb6Obj));
---------------------------------------------------------------------------------

	for nPos = 0, 1 do
		local tbObj = self.tbObjMedicamentCont:GetObj(nPos);
		if tbObj and (tbObj.nType == Ui.OBJ_TEMPITEM) then
			self.tbObjMedicamentCont:SetObj(nil, nPos);
			self.tbObjMedicamentCont:DestroyTempItem(tbObj);
		end
	end

	self.tbObjMedicamentCont:ClearObj();

	if self.tbLeftMed then
		local tbLeftMedObj = self.tbObjMedicamentCont:LoadMedObj(self.tbLeftMed);
		self.tbObjMedicamentCont:SetObj(tbLeftMedObj, 0, 0);
	end

	if self.tbRightMed then
		local tbRightMedObj = self.tbObjMedicamentCont:LoadMedObj(self.tbRightMed);
		self.tbObjMedicamentCont:SetObj(tbRightMedObj, 1, 0);
	end
end

function uiAutoFight:LoadSetting()
	--self.tbFightSetting = tbAutoFightData:Load();
	local tbFightSetting = self:Load(self.DATA_KEY)
	if not tbFightSetting then
		tbFightSetting={}
	end
	if tbFightSetting.nUnPickCommonItem then
		self.bPickItem = tbFightSetting.nUnPickCommonItem;
	end
	if tbFightSetting.nPickValue then
		self.nPickStar = tbFightSetting.nPickValue;
	end
	if tbFightSetting.nLifeRet then
		self.nLifeRet = tbFightSetting.nLifeRet;
	end
	if tbFightSetting.nBuffRet then
		self.nBuffRet = tbFightSetting.nBuffRet;
	end
	if tbFightSetting.nSkill1 then
		self.nLeftSkillId = tbFightSetting.nSkill1;
	end
	if tbFightSetting.nSkill2 then
		self.nRightSkillId = tbFightSetting.nSkill2;
	end
-----------------------------------------------------------------------------------------
	if tbFightSetting.nSkill3 then
		self.n3SkillId = tbFightSetting.nSkill3;
	end
	if tbFightSetting.nSkill4 then
		self.n4SkillId = tbFightSetting.nSkill4;
	end
	if tbFightSetting.nSkill5 then
		self.n5SkillId = tbFightSetting.nSkill5;
	end
	if tbFightSetting.nSkill6 then
		self.n6SkillId = tbFightSetting.nSkill6;
	end
	if tbFightSetting.nAutoOpenJiuXiang then
		self.nAutoOpenJiuXiang = tbFightSetting.nAutoOpenJiuXiang;
	end
	if tbFightSetting.nPKfanji then
		self.nPKfanji = tbFightSetting.nPKfanji;
	end
-----------------------------------------------------------------------------------------	
	if tbFightSetting.nAcceptTeam then
		self.nAcceptTeam = tbFightSetting.nAcceptTeam;
	end

	if tbFightSetting.nAutoRepair then
		self.nAutoRepair = tbFightSetting.nAutoRepair;
	end

	if tbFightSetting.nAutoDrink then
		self.nAutoDrink = tbFightSetting.nAutoDrink;
	end

	if tbFightSetting.nPvpMode then
		self.nPvpMode = tbFightSetting.nPvpMode;
	end

	if tbFightSetting.tbLeftMed then
		self.tbLeftMed = tbFightSetting.tbLeftMed;
	end

	if tbFightSetting.tbRightMed then
		self.tbRightMed = tbFightSetting.tbRightMed;
	end

	if tbFightSetting.nAutoEnhancePick then
		self.nAutoEnhancePick = tbFightSetting.nAutoEnhancePick;
	end
	
	if tbFightSetting.nAutoFD then
		self.nAutoFD = tbFightSetting.nAutoFD;
	end
	
	if tbFightSetting.nAutoFDWX then
		self.nAutoFDWX = tbFightSetting.nAutoFDWX;
	end
	
	if tbFightSetting.nAutoRead then
		self.nAutoRead = tbFightSetting.nAutoRead;
	end
	
	if tbFightSetting.nAutoRead_Move then
		self.nAutoRead_Move = tbFightSetting.nAutoRead_Move;
	end
	
	if tbFightSetting.nAutoXLZ then
		self.nAutoXLZ = tbFightSetting.nAutoXLZ;
	end
	
	if tbFightSetting.nSkill then
		self.nSkill = tbFightSetting.nSkill;
	end
	
	if tbFightSetting.nJoin then
		self.nJoin = tbFightSetting.nJoin;
	end
	
	if tbFightSetting.nDead then
		self.nDead = tbFightSetting.nDead;
	end
end

function uiAutoFight:OnClose()
	self.tbObjSkillCont:ClearObj();
	for nPos = 0, 1 do
		local tbObj = self.tbObjMedicamentCont:GetObj(nPos);
		if tbObj and (tbObj.nType == Ui.OBJ_TEMPITEM) then
			self.tbObjMedicamentCont:SetObj(nil, nPos);
			self.tbObjMedicamentCont:DestroyTempItem(tbObj);
		end
	end

	self.tbObjMedicamentCont:ClearObj();
end

function uiAutoFight:UpdateSkill(nLeftSkillId, nRightSkillId, n3SkillId, n4SkillId, n5SkillId, n6SkillId)
	if nLeftSkillId  and  nLeftSkillId > 0 then
		self.nLeftSkillId = nLeftSkillId;
	end

	if nRightSkillId and nRightSkillId >0 then
		self.nRightSkillId = nRightSkillId;
	end
----------------------------------------------------------------
	if n3SkillId and n3SkillId >0 then
		self.n3SkillId = n3SkillId;
	end

	if n4SkillId and n4SkillId >0 then
		self.n4SkillId = n4SkillId;
	end

	if n5SkillId and n5SkillId >0 then
		self.n5SkillId = n5SkillId;
	end

	if n6SkillId and n6SkillId >0 then
		self.n6SkillId = n6SkillId;
	end
----------------------------------------------------------------
	self:UpdateWnd();
end

function uiAutoFight:OnChangeFactionFinished()
	if UiManager:WindowVisible(Ui.UI_AUTOFIGHT) == 1 then
		self:SaveData();
		tbAutoFightData:OnChangeFactionFinished();
		self:OnOpen();
	else
		tbAutoFightData:OnChangeFactionFinished();
	end
end

function uiAutoFight:RegisterEvent()
	local tbRegEvent =
	{
		{ UiNotify.emUIEVENT_SELECT_SKILL,	self.UpdateSkill },
		{ UiNotify.emCOREEVENT_SYNC_ITEM,self.OnSyncItem},
		{ UiNotify.emCOREEVENT_CHANGE_FACTION_FINISHED,	self.OnChangeFactionFinished},
	};
	tbRegEvent = Lib:MergeTable(tbRegEvent, self.tbObjSkillCont:RegisterEvent());
	tbRegEvent = Lib:MergeTable(tbRegEvent, self.tbObjMedicamentCont:RegisterEvent());
	return tbRegEvent;
end

function uiAutoFight:RegisterMessage()
	local tbRegMsg = {};
	tbRegMsg = Lib:MergeTable(tbRegMsg, self.tbObjSkillCont:RegisterMessage());
	tbRegMsg = Lib:MergeTable(tbRegMsg, self.tbObjMedicamentCont:RegisterMessage());
	return tbRegMsg;
end
----------------------------------------------------------------------------------------------
function uiAutoFight:Save(szKey, tbData)
	self.m_szFilePath="\\user\\TuDongDanh\\"..me.szName..tostring(me.nFaction).."_6Skill.dll";
	self.m_tbData[szKey] = tbData;
	local szData = Lib:Val2Str(self.m_tbData);
	assert(self.m_szFilePath);
	if self:CheckErrorData(szData) == 1 then
		KIo.WriteFile(self.m_szFilePath, szData);
	else
		local szSaveData = Lib:Val2Str(tbData);
	end
end

function uiAutoFight:Load(key)
	self.m_szFilePath="\\user\\TuDongDanh\\"..me.szName..tostring(me.nFaction).."_6Skill.dll";
	self.m_tbData = {};
--	print(key)
	local szData = KIo.ReadTxtFile(self.m_szFilePath);
	if (szData) then
		if self:CheckErrorData(szData) == 1 then	
			self.m_tbData = Lib:Str2Val(szData);
		else
			KIo.WriteFile(self.m_szFilePath, "nil");
		end
	end
	local tbData = self.m_tbData[key];
--	print(self.m_tbData)
	return tbData
end

function uiAutoFight:CheckErrorData(szDate)
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

function uiAutoFight:OnSyncItem(nRoom, nX, nY)
	for nPos = 0, 1 do
		self.tbObjMedicamentCont:Update(nPos);
	end
end

function tbObjMedicamentCont:FormatItem(tbItem)

	local tbObj = {};
	local pItem = tbItem.pItem;
	if not pItem then
		return;
	end

	tbObj.szBgImage = pItem.szIconImage;
	tbObj.szCdSpin  = self.CDSPIN_MEDIUM;
	tbObj.szCdFlash = self.CDFLASH_MEDIUM;

	tbObj.bShowSubScript = 1;
	return tbObj;
end

function tbObjMedicamentCont:UpdateItem(tbItem, nX, nY)

	local pItem = tbItem.pItem;
	local nCount = me.GetSameItemCountInBags(pItem);

	ObjGrid_ChangeSubScript(self.szUiGroup, self.szObjGrid, tostring(nCount), nX, nY);
	self:UpdateItemCd(pItem.nCdType);
end


function tbObjMedicamentCont:PickMouse(tbObj, nX, nY)

	self:SetObj(nil, nX, nY);
	self:SaveMedObj(nX);

	return 1;
end

function tbObjMedicamentCont:SwitchMouse(tbMouseObj, tbObj, nX, nY)
	if self:CheckObj(tbMouseObj) ~= 1 then
		me.Msg("Vật phẩm này ko đc đặt vào ô thuốc!");
		return 0;
	end
	self:PickMouse(tbObj, nX, nY);
	if tbObj.nType == Ui.OBJ_TEMPITEM then
		self:DestroyTempItem(tbObj);
	end
	self:DropMouse(tbMouseObj, nX, nY);
	return 1;
end

function tbObjMedicamentCont:DropMouse(tbMouseObj, nX, nY)

	if self:CheckObj(tbMouseObj) ~= 1 then
		me.Msg("Vật phẩm này ko đc đặt vào ô thuốc!");
		return 0;
	end

	if tbMouseObj.nType == Ui.OBJ_OWNITEM then

		local pItem = me.GetItem(tbMouseObj.nRoom, tbMouseObj.nX, tbMouseObj.nY);
		if not pItem then
			return 0;
		end

		local tbObj = self:CreateTempItem(pItem.nGenre, pItem.nDetail, pItem.nParticular, pItem.nLevel, pItem.nSeries);
		self:SetObj(tbObj, nX, nY);

		tbMouse:ResetObj();

	elseif tbMouseObj.nType == Ui.OBJ_TEMPITEM  then

		tbMouse:SetObj(nil);
		self:SetObj(tbMouseObj, nX, nY);

	else
		return 0;
	end

	self:SaveMedObj(nX);

	return 1;
end

function tbObjMedicamentCont:CheckObj(tbObj)

	if tbObj.nType == Ui.OBJ_OWNITEM then
		local pItem = me.GetItem(tbObj.nRoom, tbObj.nX, tbObj.nY);
		if pItem and pItem.CanBeShortcut() == 1 then
			return 1;
		end

	elseif tbObj.nType == Ui.OBJ_TEMPITEM then
		if tbObj.pItem.CanBeShortcut() == 1 then
			return 1;
		end
	end

	return 0;
end

function tbObjMedicamentCont:CreateTempItem(nGenre, nDetail, nParticular, nLevel, nSeries)

	local pItem = tbTempItem:Create(nGenre, nDetail, nParticular, nLevel, nSeries);
	if not pItem then
		return;
	end

	local tbObj = {};
	tbObj.nType = Ui.OBJ_TEMPITEM;
	tbObj.pItem = pItem;

	return tbObj;
end

function tbObjMedicamentCont:DestroyTempItem(tbObj)

	if tbObj.nType ~= Ui.OBJ_TEMPITEM then
		return tbObj;
	end

	tbTempItem:Destroy(tbObj.pItem);
	return nil;
end

function tbObjMedicamentCont:LoadMedObj(tbMedInfo)

	if not tbMedInfo then
		return nil;
	end

	local nGenre	  = Lib:LoadBits(tbMedInfo.nLow, 0, 15);
	local nDetail	  = Lib:LoadBits(tbMedInfo.nLow, 16, 31);
	local nParticular = Lib:LoadBits(tbMedInfo.nHigh, 0, 15);
	local nLevel	  = Lib:LoadBits(tbMedInfo.nHigh, 16, 23);
	local nSeries	  = Lib:LoadBits(tbMedInfo.nHigh, 24, 31);

	return self:CreateTempItem(nGenre, nDetail, nParticular, nLevel, nSeries);
end

function tbObjMedicamentCont:SaveMedObj(nPosition)

	if not self.tbMedInfo then
		self.tbMedInfo = {};
	end

	local tbObj = self:GetObj(nPosition);
	if tbObj and tbObj.nType == Ui.OBJ_TEMPITEM then

		local pItem = tbObj.pItem;
		local nLow  = Lib:SetBits(pItem.nGenre, pItem.nDetail, 16, 31);
		local nHigh = Lib:SetBits(pItem.nParticular, pItem.nLevel, 16, 23);
		nHigh = Lib:SetBits(nHigh, pItem.nSeries, 24, 31);
		self.tbMedInfo[nPosition + 1] = {nLow = nLow, nHigh = nHigh};
	else
		self.tbMedInfo[nPosition + 1] = nil;
	end
end

function uiAutoFight:StartAutoMed()

	if not self.tbFightSetting or #self.tbFightSetting <= 0 then
		self:LoadSetting();
	end

	if not self.nAutoMed or self.nAutoMed == 0 then

		self.nTimerID = tbTimer:Register(3, self.OnTimerAutoMed, self);
		--me.Msg("<color=orange>Bắt đầu tự động bơm máu ");
		me.Msg("<color=yellow>Khi sinh lực nhỏ hơn <color=green>"..self.nLifeRet.."%<color=yellow> tự dùng thuốc.");

		if not self.tbLeftMed and not self.tbRightMed then
			me.Msg("<color=yellow>Cảnh báo: Bạn chưa thiết lập tự động bơm máu!<color>");
		else
			local tbFindLeft, nLeftCount = self:GetMedObj(self.tbLeftMed);
			if tbFindLeft and nLeftCount >= 1 then
				me.Msg("<color=green>Tự động sử dụng <color=yellow>"..tbFindLeft[1].pItem.szName.."<color=green> còn:<color=yellow>"..nLeftCount.."<color=green> bình");
			end

			local tbFindRight, nRightCount = self:GetMedObj(self.tbRightMed);
			if tbFindRight and nRightCount >= 1 then
				me.Msg("<color=green>Thay thế thuốc: <color=yellow>"..tbFindRight[1].pItem.szName.."<color=green> còn:<color=yellow>"..nRightCount.."<color=green> bình");
			end

			if nLeftCount + nRightCount >= 0 and nLeftCount + nRightCount < 10 then
				Ui(Ui.UI_TASKTIPS):Begin("<bclr=0,0,200><color=yellow>Số lượng thuốc quá thấp rất nguy hiểm !<color><bclr>");
			end
		end

		self.nAutoMed = 1;

	elseif self.nAutoMed == 1 then
		self:StopAutoMed();
	end
end

function uiAutoFight:StopAutoMed()
	if self.nTimerID and self.nTimerID > 0 then
		tbTimer:Close(self.nTimerID);
		self.nTimerID = 0;
		self.nAutoMed = 0;
		me.Msg("<color=orange>Ngừng tự động bơm máu");
	end
end


function uiAutoFight:GetMedObj(tbMedInfo)

	if not tbMedInfo then
		return nil, 0;
	end

	local nGenre	  = Lib:LoadBits(tbMedInfo.nLow, 0, 15);
	local nDetail	  = Lib:LoadBits(tbMedInfo.nLow, 16, 31);
	local nParticular = Lib:LoadBits(tbMedInfo.nHigh, 0, 15);
	local nLevel	  = Lib:LoadBits(tbMedInfo.nHigh, 16, 23);
	local nSeries	  = Lib:LoadBits(tbMedInfo.nHigh, 24, 31);

	local tbFind = me.FindItemInBags(nGenre, nDetail, nParticular, nLevel, nSeries);
	local nCount = me.GetItemCountInBags(nGenre, nDetail, nParticular, nLevel);

	return tbFind, nCount;
end

function uiAutoFight:OnTimerAutoMed()

	if me.nCurLife * 100 / me.nMaxLife <= self.nLifeRet then

		local tbFindLeft, nLeftCount = self:GetMedObj(self.tbLeftMed);
		local tbFindRight, nRightCount = self:GetMedObj(self.tbRightMed);

		if tbFindLeft and nLeftCount >= 1 then
			me.UseItem(tbFindLeft[1].pItem);
		elseif tbFindRight and nRightCount >= 1 then
			me.UseItem(tbFindRight[1].pItem);
		end

		if nLeftCount + nRightCount > 0 and nLeftCount + nRightCount < 5 then
			Ui(Ui.UI_TASKTIPS):Begin("<bclr=0,0,200><color=yellow>Số lượng thuốc quá thấp rất nguy hiểm !<color><bclr>");
		end
	end

	return 3;
end

local uiSkillTree = Ui(Ui.UI_SKILLTREE);
uiSkillTree.OnOpen_Bak = uiSkillTree.OnOpen_Bak or uiSkillTree.OnOpen
uiSkillTree.OnOpen = function(uiSkillTree, szLeftOrRight)
	if szLeftOrRight == "AUTO3SKILL" then
		uiSkillTree.bAutoFightRightSkill = 2;
		uiSkillTree:UpdateSkill();
		uiSkillTree.bAutoFightModel = 1;
	elseif szLeftOrRight == "AUTO4SKILL" then
		uiSkillTree.bAutoFightRightSkill = 3;
		uiSkillTree:UpdateSkill();
		uiSkillTree.bAutoFightModel = 1;
	elseif szLeftOrRight == "AUTO5SKILL" then
		uiSkillTree.bAutoFightRightSkill = 4;
		uiSkillTree:UpdateSkill();
		uiSkillTree.bAutoFightModel = 1;
	elseif szLeftOrRight == "AUTO6SKILL" then
		uiSkillTree.bAutoFightRightSkill = 5;
		uiSkillTree:UpdateSkill();
		uiSkillTree.bAutoFightModel = 1;
	else
		uiSkillTree.OnOpen_Bak(uiSkillTree, szLeftOrRight)
	end
end

uiSkillTree.OnObjSwitch_Bak = uiSkillTree.OnObjSwitch_Bak or uiSkillTree.OnObjSwitch
uiSkillTree.OnObjSwitch = function(uiSkillTree, szWnd, uGenre, uId, nX, nY)
	if uiSkillTree.bAutoFightModel == 1 then
		local nLeftId, nRightId, n3Id, n4Id, n5Id, n6Id;
		if uiSkillTree.bAutoFightRightSkill == 0 then
			nLeftId = uId;
			nRightId = -1;
			n3Id = -1;
			n4Id = -1;
			n5Id = -1;
			n6Id = -1;
			me.Msg(string.format("Skill 1 =%s",uId));
		elseif uiSkillTree.bAutoFightRightSkill == 1 then
			nLeftId = -1;
			nRightId = uId;
			n3Id = -1;
			n4Id = -1;
			n5Id = -1;
			n6Id = -1;
			me.Msg(string.format("Skill 2 =%s",uId));
		elseif uiSkillTree.bAutoFightRightSkill == 2 then
			nLeftId = -1;
			nRightId = -1;
			n3Id = uId;
			n4Id = -1;
			n5Id = -1;
			n6Id = -1;
			me.Msg(string.format("Skill 3 =%s",uId));
		elseif uiSkillTree.bAutoFightRightSkill == 3 then
			nLeftId = -1;
			nRightId = -1;
			n3Id = -1;
			n4Id = uId;
			n5Id = -1;
			n6Id = -1;
			me.Msg(string.format("Skill 4 =%s",uId));
		elseif uiSkillTree.bAutoFightRightSkill == 4 then
			nLeftId = -1;
			nRightId = -1;
			n3Id = -1;
			n4Id = -1;
			n5Id = uId;
			n6Id = -1;
			me.Msg(string.format("Skill 5 =%s",uId));
		elseif uiSkillTree.bAutoFightRightSkill == 5 then
			nLeftId = -1;
			nRightId = -1;
			n3Id = -1;
			n4Id = -1;
			n5Id = -1;
			n6Id = uId;
			me.Msg(string.format("Skill 6 =%s",uId));
		end
		--UiNotify:OnNotify(UiNotify.emUIEVENT_SELECT_SKILL, nLeftId, nRightId);
		uiAutoFight.UpdateSkill(uiAutoFight, nLeftId, nRightId, n3Id, n4Id, n5Id, n6Id);
		UiManager:CloseWindow(Ui.UI_SKILLTREE);
	else
		uiSkillTree.OnObjSwitch_Bak(uiSkillTree, szWnd, uGenre, uId, nX, nY)
	end
end