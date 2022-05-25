local uiViewFightSkill = Ui(Ui.UI_VIEW_FIGHTSKILL)
local tbObject     = Ui.tbLogic.tbObject;

uiViewFightSkill.CLOSE_WINDOW_BUTTON	= "BtnClose";

uiViewFightSkill.PAGE_SET_MAIN			= "PageSetMain";

uiViewFightSkill.View_Skill_Object		= "ObjFightSkillView"
uiViewFightSkill.BTN_PAGEUP				= "BtnPageUp";
uiViewFightSkill.BTN_PAGEDOWN			= "BtnPageDown";
uiViewFightSkill.TXTPAGE				= "TxtPage";
uiViewFightSkill.BTN_LVUP				= "BtnLvup";
uiViewFightSkill.SKILL_POINT_TEXT		= "TxtPoint";
uiViewFightSkill.ACCEPT_BUTTON			= "BtnAccept";
uiViewFightSkill.CANCEL_BUTTON			= "BtnCancel";
uiViewFightSkill.Common_Skill_OBJECT	= "ObjCommonSkill";
uiViewFightSkill.BTNALLUP				= "BtnAllUp";

uiViewFightSkill.View_OBJECT_LINE			= 6;
uiViewFightSkill.View_OBJECT_ROW 			= 4;

uiViewFightSkill.MAXCOUNTS					= 12;
uiViewFightSkill.PAGE_WND =
{
	{ "BtnKombatPage1", 	"PageKombat", 	{ 0, 0, 0, 0, 0, 0 } },
};


uiViewFightSkill.WND_FACTION_BG			= "BgFactionImage";
uiViewFightSkill.FACTION_BG				= {
		"shaolin.spr",
		"tianwang.spr",
		"tangmen.spr",
		"wudu.spr",
		"emei.spr",
		"cuiyan.spr",
		"gaibang.spr",
		"tianren.spr",
		"wudang.spr",
		"kunlun.spr",
		"mingjiao.spr",
		"dali.spr",		
}

local tbViewSkillCont  = { bShowCd = 0, bUse = 0 };
tbViewSkillCont.nCurPage = 1;

tbViewSkillCont.SKILL_WND =
{
	[1] =
	{
		{
			{ "0", "Txt1_1_1", 0, 0, 0, "BtnLvup1_1_1", 0,  [12]= "TxtName1_1_1"},
			{ "1", "Txt1_1_2", 0, 0, 0, "BtnLvup1_1_2", 0,  [12]= "TxtName1_1_2"},

		},
		{
			{ "0", "Txt1_2_1", 0, 0, 0, "BtnLvup1_2_1", 0, 	[12]= "TxtName1_2_1" },
			{ "1", "Txt1_2_2", 0, 0, 0, "BtnLvup1_2_2", 0,  [12]= "TxtName1_2_2" },
		},
		{
			{ "0", "Txt1_3_1", 0, 0, 0, "BtnLvup1_3_1", 0,  [12]= "TxtName1_3_1" },
			{ "1", "Txt1_3_2", 0, 0, 0, "BtnLvup1_3_2", 0,  [12]= "TxtName1_3_2" },
		},
		{
			{ "0", "Txt1_4_1", 0, 0, 0, "BtnLvup1_4_1", 0, 	[12]= "TxtName1_4_1" },
			{ "1", "Txt1_4_2", 0, 0, 0, "BtnLvup1_4_2", 0,  [12]= "TxtName1_4_2" },
		},
		{
			{ "0", "Txt1_5_1", 0, 0, 0, "BtnLvup1_5_1", 0,  [12]= "TxtName1_5_1" },
			{ "1", "Txt1_5_2", 0, 0, 0, "BtnLvup1_5_2", 0,  [12]= "TxtName1_5_2" },
		},
		{
			{ "0", "Txt1_6_1", 0, 0, 0, "BtnLvup1_6_1", 0,  [12]= "TxtName1_6_1"  },
			{ "1", "Txt1_6_2", 0, 0, 0, "BtnLvup1_6_2", 0,  [12]= "TxtName1_6_2"  },
		},
	},
}
 tbViewSkillCont.PickMouse=function(self,tbObj, nX, nY)
    	return
end

 tbViewSkillCont.DropMouse=function(self,tbMouseObj, nX, nY)
	return 0;
end

 tbViewSkillCont.SwitchMouse=function(self,tbMouseObj, tbObj, nX, nY)
	return 0;
end

 tbViewSkillCont.CanPick=function(self,nX, nY)
	return 0;
end

 tbViewSkillCont.EnterFightSkill=function(self,tbFightSkill, nX, nY)
	local nSkillId = tbFightSkill.nSkillId;
	if nSkillId <= 0 then
		return;
	end
	local nPage = self.nCurPage;
	local nLine = nY + 1;
	local nRow  = nX + 1;
	if nPage and nLine and nRow then
		Wnd_ShowMouseHoverInfo(self.szUiGroup, self.szObjGrid, FightSkill:GetDesc(nSkillId, self.SKILL_WND[nPage][nLine][nRow][2], 0, nil, nil, 1));
	end
end


 uiViewFightSkill.OnCreate=function(self)
	self.tbViewSkillCont = tbObject:RegisterContainer(
		self.UIGROUP,
		self.View_Skill_Object,
		self.View_OBJECT_LINE,
		self.View_OBJECT_LINE,
		tbViewSkillCont
	);
end

 uiViewFightSkill.OnDestroy=function(self)
	tbObject:UnregContainer(self.tbViewSkillCont);
end

 uiViewFightSkill.Init=function(self)
	self.nCurPageNum = 1;
end

 uiViewFightSkill.OnOpen=function(self)
	Wnd_SetEnable(self.UIGROUP, self.CANCEL_BUTTON,0)
	Wnd_SetEnable(self.UIGROUP, self.BTNALLUP,0)
	self:HideAllAddBtn()
	self:UpdateViewPage();
end

 uiViewFightSkill.OnClose=function(self)
end


 uiViewFightSkill.UpDateBgImage=function(self,nFaction)
	
	local szPath		= "\\image\\ui\\001a\\skill\\fightskill_bg\\";
	local szBgImage		= "";
	
	if nFaction ~= 0 then
		szBgImage	= szPath..self.FACTION_BG[nFaction];
	else
		szBgImage	= szPath.."common.spr"
	end;
	print("Img_SetImage", szBgImage);
	Img_SetImage(self.UIGROUP, self.WND_FACTION_BG, 1, "");
	Img_SetImage(self.UIGROUP, self.WND_FACTION_BG, 1, szBgImage);
end;

 uiViewFightSkill.ClearPage=function(self,nPage)
	local x = nPage;
	for y = 1, #self.tbViewSkillCont.SKILL_WND[x] do
		for z = 1, #self.tbViewSkillCont.SKILL_WND[x][y] do
			self.tbViewSkillCont.SKILL_WND[x][y][z][2] = 0;
			Txt_SetTxt(self.UIGROUP, self.tbViewSkillCont.SKILL_WND[x][y][z][1], "");
			Txt_SetTxt(self.UIGROUP, self.tbViewSkillCont.SKILL_WND[x][y][z][12], "");
		end
	end
		
	for y = 1, #self.PAGE_WND[x][3] do
		self.PAGE_WND[nPage][3][y] = 0;
	end	
	self.tbViewSkillCont:ClearObj();
end

 uiViewFightSkill.UpdateViewPage=function(self)
	PgSet_ActivePage(self.UIGROUP, self.PAGE_SET_MAIN, self.PAGE_WND[self.nCurPageNum][2]);
	local tbViewSkill = me.GetPlayerSkillList();
	Txt_SetTxt(self.UIGROUP, self.TXTPAGE, "1/1");
	Wnd_SetEnable(self.UIGROUP, self.BTN_PAGEUP, 0)
	Wnd_SetEnable(self.UIGROUP, self.BTN_PAGEDOWN, 0)

	if not tbViewSkill then
		print("get skill error")
	end
	local nRoute = tbViewSkill.nRoute;
	local nFaction = tbViewSkill.nFaction;
	print("nRoute, nFaction", nRoute, nFaction)
	self:UpDateBgImage(nFaction);
	if not nFaction or nFaction == 0  or nRoute == 0 then
		--print("return");
		return;
	end
	
	self.SkillAllPoint=0
	
	local tbRoutes = KPlayer.GetFactionInfo(nFaction).tbRoutes;
	local szRouteName = tbRoutes[nRoute].szName;
	
	self:ClearPage(self.nCurPageNum);

	Btn_SetTxt(self.UIGROUP, self.PAGE_WND[self.nCurPageNum][1], szRouteName);
	for i = 1, #tbViewSkill do
		local nSkillId = tbViewSkill[i].nSkillId;
		local nLine = 0;
		if nSkillId == 0 then
			break;
		end	
		
		if (math.mod(i , 2) == 0) then
			nLine = math.floor(i / 2);
		else
			nLine = math.floor(i / 2)  + 1;
		end
		self:AddSkillToViewPage(nLine, tbViewSkill[i]);
	end
	
end

 uiViewFightSkill.AddSkillToViewPage=function(self,nLine, tbSkill)
	if (not nLine) or (not tbSkill) then
		return;
	end

	local nPage = self.nCurPageNum;

	local nOffset = self.PAGE_WND[nPage][3][nLine] + 1;	
	self.PAGE_WND[nPage][3][nLine] = nOffset;

	Wnd_Show(self.UIGROUP, self.tbViewSkillCont.SKILL_WND[nPage][nLine][nOffset][2]);
	local szLevel = tbSkill.nSkillLevel;
	
	self.tbViewSkillCont.SKILL_WND[nPage][nLine][nOffset][2] = tbSkill.nSkillLevel;
	--self.tbViewSkillCont.SKILL_WND[nPage][nLine][nOffset][3] = KFightSkill.GetNpcLevelReq(tbSkill.nSkillId);
	self.tbViewSkillCont.SKILL_WND[nPage][nLine][nOffset][4] = tbSkill.nSkillLevel;
	self.tbViewSkillCont.SKILL_WND[nPage][nLine][nOffset][5] = 0;
	self.tbViewSkillCont.SKILL_WND[nPage][nLine][nOffset][7] = 0;

	self.tbViewSkillCont.SKILL_WND[nPage][nLine][nOffset][8] = tbSkill.uId;
	self.tbViewSkillCont.SKILL_WND[nPage][nLine][nOffset][9] = KFightSkill.GetSkillMaxLevel(tbSkill.nSkillId);
	self.SkillAllPoint=self.SkillAllPoint+KFightSkill.GetSkillMaxLevel(tbSkill.nSkillId);
	self.tbViewSkillCont.SKILL_WND[nPage][nLine][nOffset][10] = tbSkill.nInitiative;
	--self.nSKILL_Level[nLine][nOffset]=KFightSkill.GetSkillMaxLevel(tbSkill.nSkillId);
	
	Txt_SetTxt(self.UIGROUP, self.tbViewSkillCont.SKILL_WND[nPage][nLine][nOffset][1], "Cấp: "..szLevel);
	local szSkillName = KFightSkill.GetSkillName(tbSkill.nSkillId);
	Txt_SetTxt(self.UIGROUP, self.tbViewSkillCont.SKILL_WND[nPage][nLine][nOffset][12], szSkillName);

		
	local tbObj = nil;
	tbObj = {};
	tbObj.nType = Ui.OBJ_FIGHTSKILL;
	tbObj.nSkillId = tbSkill.nSkillId;
   	self.tbViewSkillCont:SetObj(tbObj, nOffset - 1, nLine - 1);

end

 uiViewFightSkill.RegisterEvent=function(self)
	local tbRegEvent = 
	{
	};
	tbRegEvent = Lib:MergeTable(tbRegEvent, self.tbViewSkillCont:RegisterEvent());
	return tbRegEvent;
end

 uiViewFightSkill.RegisterMessage=function(self)
	local tbRegMsg = self.tbViewSkillCont:RegisterMessage()
	return tbRegMsg;
end
 uiViewFightSkill.OnButtonClick=function(self,szWnd, nParam)
	if szWnd == self.CLOSE_WINDOW_BUTTON then
		UiManager:CloseWindow(self.UIGROUP);
	elseif szWnd == self.ACCEPT_BUTTON then
		--self:PreAccept();
		self.nSkillPoint=self.SkillAllPoint-10
		self:ShowAllAddBtn()
		Wnd_SetEnable(self.UIGROUP, self.CANCEL_BUTTON,1)
		Wnd_SetEnable(self.UIGROUP, self.ACCEPT_BUTTON,0)
		Wnd_SetEnable(self.UIGROUP, self.BTNALLUP,1)
	------------------------------
		Txt_SetTxt(self.UIGROUP, self.SKILL_POINT_TEXT, self.nSkillPoint);
		self:Skill_Info()
	
	elseif szWnd == self.CANCEL_BUTTON then
		--self:Refresh();
		Wnd_SetEnable(self.UIGROUP, self.CANCEL_BUTTON,0)
		Wnd_SetEnable(self.UIGROUP, self.ACCEPT_BUTTON,1)
		Wnd_SetEnable(self.UIGROUP, self.BTNALLUP,0)
		self.nSkillPoint=0
		Txt_SetTxt(self.UIGROUP, self.SKILL_POINT_TEXT, self.nSkillPoint);
		self:HideAllAddBtn()
		self:UpdateViewPage()
	elseif string.sub(szWnd, 1, 7) == self.BTN_LVUP then
		--print(szWnd)
		local x = tonumber(string.sub(szWnd, 10, 10));
		local y = tonumber(string.sub(szWnd, 12, 12));
		self:OnSkillLvUp(x, y,szWnd);
	elseif szWnd == self.BTNALLUP then
		self:Skill_AllUp()
	end
end
uiViewFightSkill.Skill_AllUp=function(self)
	for x=1,6 do
		for y=1,2 do
			self.m_bSimTong = 1;
			local nPage = 1--self.m_nCurPageNum;
			if me.nRouteId == nil or me.nRouteId == 0 then	
				self.m_nSimRouteId = 1
			end
			--self.tbViewSkillCont.SKILL_WND[nPage][x][y][2]=0
			self.tbViewSkillCont.SKILL_WND[nPage][x][y][4]=0
			--self.tbViewSkillCont.SKILL_WND[nPage][x][y][5]=0
			local tbSkill = self.tbViewSkillCont.SKILL_WND[nPage][x][y];
			--print(tbSkill[2])
			tbSkill[5]=tbSkill[5]+1
			tbSkill[2] =tbSkill[5]+tbSkill[7]
			local szLevel = tbSkill[4];
			if tbSkill[7] > 0 or tbSkill[5]>0 then
				 szLevel = szLevel.." <color=cyan>+"..tbSkill[7].."<color>".." <color=pink>+"..tbSkill[5].."<color>";
			end
			Txt_SetTxt(self.UIGROUP, tbSkill[1], "Cấp: "..szLevel);
			Wnd_Show(self.UIGROUP, tbSkill[2]);	
		end
	end	
	
end
 uiViewFightSkill.Skill_Info=function(self)
	for x=1,6 do
		for y=1,2 do
			self.m_bSimTong = 1;
			local nPage = 1--self.m_nCurPageNum;
			if me.nRouteId == nil or me.nRouteId == 0 then
				self.m_nSimRouteId = 1--self.m_nCurPageNum;
			end
			self.tbViewSkillCont.SKILL_WND[nPage][x][y][2]=0
			self.tbViewSkillCont.SKILL_WND[nPage][x][y][4]=0
			self.tbViewSkillCont.SKILL_WND[nPage][x][y][7]=0
			self.tbViewSkillCont.SKILL_WND[nPage][x][y][5]=0
			local tbSkill = self.tbViewSkillCont.SKILL_WND[nPage][x][y];
			--print(tbSkill[2])
			tbSkill[2] =tbSkill[5]+tbSkill[7]
			local szLevel = tbSkill[4];
			--if tbSkill[7] > 0 or tbSkill[5]>0 then
				 szLevel = szLevel.." <color=cyan>+"..tbSkill[7].."<color>".." <color=pink>+"..tbSkill[5].."<color>";
			--end
			Txt_SetTxt(self.UIGROUP, tbSkill[1], "Cấp: "..szLevel);
			Wnd_Show(self.UIGROUP, tbSkill[2]);	
		end
	end
end
 uiViewFightSkill.OnSkillLvUp=function(self,x, y,szWnd)
	if x == nil or y == nil then
		return
	end
	self.m_bSimTong = 1;
	local nPage = 1--self.m_nCurPageNum;
	if me.nRouteId == nil or me.nRouteId == 0 then
		self.m_nSimRouteId = 1--self.m_nCurPageNum;
	end
	local tbSkill = self.tbViewSkillCont.SKILL_WND[nPage][x][y];

	--print(tbSkill[1],tbSkill[2],tbSkill[3],tbSkill[4],tbSkill[5],tbSkill[6],tbSkill[7],tbSkill[8],tbSkill[9])
	tbSkill[7] = tbSkill[7] + 1;	
	--tbSkill[2] = tbSkill[2] + 1;
	self.nSkillPoint = self.nSkillPoint - 1;
	Txt_SetTxt(self.UIGROUP, self.SKILL_POINT_TEXT, self.nSkillPoint);

	local szLevel = tbSkill[4];
	if tbSkill[7] > 0 or tbSkill[5]>0 then
		szLevel = szLevel.." <color=cyan>+"..tbSkill[7].."<color>".." <color=pink>+"..tbSkill[5].."<color>";
	end
	Txt_SetTxt(self.UIGROUP, tbSkill[1], "Cấp: "..szLevel);
	tbSkill[2]=tbSkill[7]+tbSkill[5]
	Wnd_Show(self.UIGROUP, tbSkill[2]);
	if tbSkill[7]>=tbSkill[9] then
		Wnd_Hide(self.UIGROUP, szWnd);
		return
	end
end
 uiViewFightSkill.HideAllAddBtn=function(self)
	--local tPage = self.tbFightSkillCont.SKILL_WND[self.m_nCurPageNum];
	for nX = 1, 6 do
		for nY = 1, 2 do
			Wnd_Hide(self.UIGROUP, "BtnLvup1_"..tostring(nX).."_"..tostring(nY));
		end
	end
end
 uiViewFightSkill.ShowAllAddBtn=function(self)
	--local tPage = self.tbFightSkillCont.SKILL_WND[self.m_nCurPageNum];
	for nX = 1, 6 do
		for nY = 1, 2 do
			Wnd_Show(self.UIGROUP, "BtnLvup1_"..tostring(nX).."_"..tostring(nY));
		end
	end
	--Wnd_Hide(self.UIGROUP, "BtnLvup1_6_1");
	Wnd_Hide(self.UIGROUP, "BtnLvup1_6_2");
end
uiViewFightSkill.UpdateSkillPoint=function(self)
	Txt_SetTxt(self.UIGROUP, self.SKILL_POINT_TEXT, self.nSkillPoint);
end