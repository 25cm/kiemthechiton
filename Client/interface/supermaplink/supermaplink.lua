local szLastModify	= "2010/6/15";
local tbSuperMapLink	= Map.tbSuperMapLink or {};
Map.tbSuperMapLink		= tbSuperMapLink;

local tbAutoPath		= Ui.tbLogic.tbAutoPath;

tbSuperMapLink.STR_LASTMODIFY	= szLastModify;

tbSuperMapLink.tbUserData	= tbSuperMapLink.tbUserData or {	
	bUseTalk		= 1,
	nUiSelect		= 1,
	bAutoCloseWnd	= 1,
};

tbSuperMapLink.tbFastRunSkill	= { 230};	
_KLuaPlayer.AutoPath	= _KLuaPlayer.AutoPath or _KLuaPlayer.StartAutoPath;	

function tbSuperMapLink:LoadMapData()
	local tbAllMapInfo	= {};	
	self.tbAllMapInfo	= tbAllMapInfo;
	local tbFileData	= Lib:LoadTabFile("\\setting\\map\\maplist.txt");
	local nAllCount		= 0;
	for nRowNum, tbRow in ipairs(tbFileData) do
		if (nRowNum > 1) then	
			local nMapId	= tonumber(tbRow.TemplateId);
			tbAllMapInfo[nMapId]	= {
				nMapId		= nMapId,
				szMapName	= tbRow.MapName,
				szInfoFile	= tbRow.InfoFile,
				szMapType	= tbRow.MapType,
				nMapLevel	= tonumber(tbRow.MapLevel),
			};
			nAllCount	= nAllCount + 1;
		end
	end
	
	self:OutF("%d map loaded!", nAllCount);
end

function tbSuperMapLink:ModifyUi()
	local uiTaskPanel 	= Ui(Ui.UI_TASKPANEL);
	tbSuperMapLink._task_linkclick_bak	= tbSuperMapLink._task_linkclick_bak or uiTaskPanel.OnLinkClick;
	function uiTaskPanel:OnLinkClick(...)
		tbSuperMapLink.szLastClickUiGroup	= self.UIGROUP;
		tbSuperMapLink._task_linkclick_bak(self, ...);
		tbSuperMapLink:StartGoto();
	end
	tbSuperMapLink.OnLinkClicki_bak	= tbSuperMapLink.OnLinkClicki_bak or UiManager.OnLinkClick;
	
	function UiManager:OnLinkClick(szUiGroup, szWnd, szLink)
		tbSuperMapLink.szLastClickUiGroup	= szUiGroup;
		tbSuperMapLink.OnLinkClicki_bak(UiManager, szUiGroup, szWnd, szLink);
	end
	
	local function fnModifyLinkFunc(szType)
		local tbLink	= UiManager.tbLinkClass[szType];
		function tbLink:OnClick(szLink)
			tbSuperMapLink:StartGoto({szType = szType, szLink = szLink});
		end
	end
	-- fnModifyLinkFunc("pos");
	fnModifyLinkFunc("npcpos");
	local uiSayPanel	= Ui(Ui.UI_SAYPANEL);
	tbSuperMapLink.Say_bak	= tbSuperMapLink.Say_bak or uiSayPanel.OnOpen;
	function uiSayPanel:OnOpen(tbParam)
		tbSuperMapLink.Say_bak(uiSayPanel, tbParam);
		local function fnOnSay()
			tbSuperMapLink:OnSay(tbParam);
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(1, fnOnSay);
	end
	tbSuperMapLink.EnterGame_bak	= tbSuperMapLink.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		tbSuperMapLink.EnterGame_bak(Ui);
		tbSuperMapLink:LoadUserData();
	end
	if (not self.bSceneAotoPathReged) then
		local function fnOnStartAotoPath(self)
			self:OnStartAotoPath();
		end
		UiNotify:RegistNotify(UiNotify.emCOREEVENT_START_AUTOPATH, fnOnStartAotoPath, self);
		self.bSceneAotoPathReged	= 1;
	end
end

function tbSuperMapLink:Init()
	self:LoadMapData();
	self:ModifyUi();
end

function tbSuperMapLink:OutF(...)
	print("[SuperMapLink]", string.format(unpack(arg)));
end

function tbSuperMapLink:StartGoto(tbPosInfo)
	if (self.szLastClickUiGroup and self.tbUserData.bAutoCloseWnd == 1) then	
		UiManager:CloseWindow(self.szLastClickUiGroup);
	end
	local nLastClickFrame	= self.nLastClickFrame or 0;
	local nNowFrame			= GetFrame();
	if (nNowFrame < nLastClickFrame + Env.GAME_FPS) then	
		UiManager:CloseWindow(self.szLastClickUiGroup);
		return;
	end
	self.nLastClickFrame	= nNowFrame;
	self.bRidedHorse	= nil
	local tbSplit		= Lib:SplitStr(tbPosInfo.szLink, ",");
	local tbLink	= {
		szDesc		= tbSplit[1],
		varMap		= tbSplit[2],
	};
	local tbAutoAns;
	if (tbPosInfo.szType == "pos") then		
		tbLink.nPosX	= tonumber(tbSplit[3]);
		tbLink.nPosY	= tonumber(tbSplit[4]);
		if (tbSplit[5]) then	
			tbAutoAns	= {unpack(tbSplit, 5)};	
		end
	elseif (tbPosInfo.szType == "npcpos") then	
		tbLink.nNpcId	= tonumber(tbSplit[3]);
		if (tbLink.szDesc == "" and tbLink.nNpcId > 0) then
			tbLink.szDesc	= KNpc.GetNameByTemplateId(tbLink.nNpcId);
		end
		if (tbSplit[4]) then	
			tbAutoAns	= {unpack(tbSplit, 4)};	
		end
	end
	tbAutoPath:OnLinkClick(tbLink, tbAutoPath.CBNpc, tbAutoPath, tbLink.nNpcId or tbLink.szDesc, tbAutoAns);
end

function tbSuperMapLink:OnStartAotoPath()
	if (not self.bRidedHorse and me.GetEquip(Item.EQUIPPOS_HORSE)) then
		if (me.GetNpc().nIsRideHorse == 1) then	
			self.bRidedHorse	= 1;
			self:OutF("ridehorse ok!");
		else
			Switch("horse");	
			self:OutF("trying ridehorse...");
		end
	end	
	for _, nSkillId in ipairs(tbSuperMapLink.tbFastRunSkill) do
		if (me.CanCastSkill(nSkillId) == 1) then	
			local _, _, nRestTime	= me.GetSkillState(nSkillId);
			if (not nRestTime or nRestTime < Env.GAME_FPS) then
				AutoAi.DoAttack(nSkillId, me.GetNpc().nIndex);
				self:OutF("cast fast run skill: %d", nSkillId);
			end
			break;
		end
	end
end

function tbSuperMapLink:CalcGoPos(tbMyPos, tbToPos)
	local tbMapRoute, nDistance, bNeedTrans	= tbAutoPath:CalcPosToPos(tbMyPos, tbToPos);
	local tbGoPos	= (tbMapRoute or {})[1];
	if (bNeedTrans == 1 and tbGoPos) then
		tbGoPos	= self.tbAllBaseMap[tbGoPos.nMapId];
	end
	if (not tbGoPos) then
		return nil, nil, -1, 1;	
	end
	return tbGoPos, tbMapRoute, nDistance, bNeedTrans;
end

function tbAutoPath:CBNpc(varNpc, tbAutoAns)
	local self	= tbSuperMapLink;
	self:OutF("CBNpc(%s,%s)", varNpc, tostring(tbAutoAns));

	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 20);
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == varNpc or pNpc.szName == varNpc) then	
			self:OutF("find npc: %s(%d)", pNpc.szName, pNpc.nKind);
			if (pNpc.nKind == 0) then	
				self:AutoFight(1);
			elseif (tbAutoAns) then
				tbAutoAns.nStartTime	= GetTime();
				self.tbAutoAns	= tbAutoAns;
			end
			AutoAi.SetTargetIndex(pNpc.nIndex);
			return;
		end
	end
	self:OutF("can not find npc: %s", tostring(varNpc));
end
----------override
function tbAutoPath:UseTrans(nMapId,bSure)
	if (bSure ~= 1 and self.nTransferMsg == 1) then
		tbAutoPath:UseTrans(nMapId, 1);
		return;
	end
	me.CallServerScript({"UseUnlimitedTrans", nMapId});
	self.nWaitingTrans        = 1;
	self:StartTimer("OnTimer_TransTimeOut", Env.GAME_FPS * 7);
end

function tbSuperMapLink:OnSay(tbParam)
	local tbAutoAns	= self.tbAutoAns;
	if (not tbAutoAns) then
		return;
	end
	local nStartTime	= tbAutoAns.nStartTime;
	if (GetTime() - nStartTime > 3) then	
		return;
	end
	local nAnsIndex	= tonumber(tbAutoAns[1]);
	if (not nAnsIndex) then
		nAnsIndex	= 0;
		for i, szAns in ipairs(tbParam[2]) do
			if (szAns == tbAutoAns[1]) then
				nAnsIndex	= i;
				break;
			end
		end
	end
	self:OutF("AutoAns %d,%s", nAnsIndex, tbParam[2][nAnsIndex] or "nil");
	if (tbParam[2][nAnsIndex]) then
		Ui(Ui.UI_SAYPANEL):OnListSel("LstSelectArray", nAnsIndex);
	end
	if (tbAutoAns[2]) then	
		self.tbAutoAns	= {nStartTime = nStartTime; unpack(tbAutoAns, 2)};
	else
		self.tbAutoAns	= nil;
	end
end

function tbSuperMapLink:LoadUserData()
	self.szUserFilePath	= GetPlayerPrivatePath().."supermaplink.dat";
	local szData		= KFile.ReadTxtFile(self.szUserFilePath);
	if (not szData) then
		return;
	end

	local tbMyData	= Lib:Str2Val(szData);
	for k, v in pairs(tbMyData) do
		self.tbUserData[k]	= v;
	end
end

function tbSuperMapLink:SaveUserData()
	local szData	= Lib:Val2Str(self.tbUserData);
	KFile.WriteFile(self.szUserFilePath, szData);
end

function tbSuperMapLink:AutoFight(nAutoFight)
	local tbAutoFightData	= Ui.tbLogic.tbAutoFightData;
	tbAutoFightData:Load();
	if (tbAutoFightData.LoadData.nAutoFight	~= nAutoFight) then	
		tbAutoFightData.LoadData.nAutoFight	= nAutoFight;
		AutoAi:UpdateCfg(tbAutoFightData.LoadData);
	end
	if (nAutoFight == 1) then
		local tbSkillInfo	= KFightSkill.GetSkillInfo(me.nLeftSkill, 1);
		if (tbSkillInfo.nHorseLimited == 1 and me.GetNpc().nIsRideHorse == 1) then	
			Switch("horse");	
		end
	else
		AutoAi.SetTargetIndex(0);	
	end
end

--------------------Trả - Nhận NV Nhanh
function tbSuperMapLink:CloseDBWindow()
       local uiGutAward = Ui(Ui.UI_GUTAWARD);
       if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
               uiGutAward:OnButtonClick("zBtnAccept");
               Ui.tbLogic.tbTimer:Close(nRoseTimerId);
       end 
end
--------------------NPC

function tbSuperMapLink:TieuDaoCoc() 
      if (me.IsDead() == 1) then
                me.SendClientCmdRevive(0);
                if me.nAutoFightState == 1 then
                        AutoAi.ProcessHandCommand("auto_fight", 0);
                       Ui(Ui.UI_SYSTEM):UpdateOnlineState();
              end
        end
      Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",23,3237"});
      nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end
function tbSuperMapLink:ThuongHoi() 
      if (me.IsDead() == 1) then
                me.SendClientCmdRevive(0);
                if me.nAutoFightState == 1 then
                        AutoAi.ProcessHandCommand("auto_fight", 0);
                       Ui(Ui.UI_SYSTEM):UpdateOnlineState();
              end
        end
	  Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",28,2965,"});
      nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end
function tbSuperMapLink:LienDauCao() 
      if (me.IsDead() == 1) then
                me.SendClientCmdRevive(0);
                if me.nAutoFightState == 1 then
                        AutoAi.ProcessHandCommand("auto_fight", 0);
                       Ui(Ui.UI_SYSTEM):UpdateOnlineState();
              end
        end
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",25,3385"});
	    nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end

function tbSuperMapLink:DaLuyenDaiSu() 
      if (me.IsDead() == 1) then
                me.SendClientCmdRevive(0);
                if me.nAutoFightState == 1 then
                        AutoAi.ProcessHandCommand("auto_fight", 0);
                       Ui(Ui.UI_SYSTEM):UpdateOnlineState();
              end
        end
	  local nMyMapId	= me.GetMapTemplateId();
	  if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,3574"});
	  else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",5,3574"});
	  end
      nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end
function tbSuperMapLink:ThuKho() 
      if (me.IsDead() == 1) then
                me.SendClientCmdRevive(0);
                if me.nAutoFightState == 1 then
                        AutoAi.ProcessHandCommand("auto_fight", 0);
                       Ui(Ui.UI_SYSTEM):UpdateOnlineState();
              end
        end
	  local nMyMapId	= me.GetMapTemplateId();
	  if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2599"});
	  else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",5,2599"});
	  end
      nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end

function tbSuperMapLink:VAGT() 
      if (me.IsDead() == 1) then
                me.SendClientCmdRevive(0);
                if me.nAutoFightState == 1 then
                        AutoAi.ProcessHandCommand("auto_fight", 0);
						Ui(Ui.UI_SYSTEM):UpdateOnlineState();
              end
        end
	  local nMyMapId	= me.GetMapTemplateId();
	  if (nMyMapId <30 and nMyMapId >22) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2955,1,1"});
		Map.tbAutoQuanDoanh:AutoPick()
	  else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",24,2955,1,1"});
		Map.tbAutoQuanDoanh:AutoPick()
	  end
      nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end

function tbSuperMapLink:LeQuan() 
      if (me.IsDead() == 1) then
                me.SendClientCmdRevive(0);
                if me.nAutoFightState == 1 then
                        AutoAi.ProcessHandCommand("auto_fight", 0);
                       Ui(Ui.UI_SYSTEM):UpdateOnlineState();
              end
        end
	  local nMyMapId	= me.GetMapTemplateId();
	  if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2601"});
	  else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",26,2601"});
	  end
      nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end
function tbSuperMapLink:ThanhLong() 
      if (me.IsDead() == 1) then
                me.SendClientCmdRevive(0);
                if me.nAutoFightState == 1 then
                        AutoAi.ProcessHandCommand("auto_fight", 0);
                       Ui(Ui.UI_SYSTEM):UpdateOnlineState();
              end
        end
	  local nMyMapId	= me.GetMapTemplateId();
	  if (nMyMapId >=556 and nMyMapId <=559) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,4237"});
	  else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",556,4237"});
	  end
      nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end
function tbSuperMapLink:TanLang() 
      if (me.IsDead() == 1) then
                me.SendClientCmdRevive(0);
                if me.nAutoFightState == 1 then
                        AutoAi.ProcessHandCommand("auto_fight", 0);
                       Ui(Ui.UI_SYSTEM):UpdateOnlineState();
              end
        end
	  Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",132,2441,"});
      nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end
function tbSuperMapLink:VHC() 
      if (me.IsDead() == 1) then
                me.SendClientCmdRevive(0);
                if me.nAutoFightState == 1 then
                        AutoAi.ProcessHandCommand("auto_fight", 0);
                       Ui(Ui.UI_SYSTEM):UpdateOnlineState();
              end
        end
      Ui.tbLogic.tbAutoPath:GotoPos({nMapId=30,nX=nPosX,nY=nPosY})         
      nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end
function tbSuperMapLink:TQC() 
      if (me.IsDead() == 1) then
                me.SendClientCmdRevive(0);
                if me.nAutoFightState == 1 then
                        AutoAi.ProcessHandCommand("auto_fight", 0);
                       Ui(Ui.UI_SYSTEM):UpdateOnlineState();
              end
        end
      Ui.tbLogic.tbAutoPath:GotoPos({nMapId=39,nX=nPosX,nY=nPosY})         
      nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end

function tbSuperMapLink:XaPhu() 
      if (me.IsDead() == 1) then
                me.SendClientCmdRevive(0);
                if me.nAutoFightState == 1 then
                        AutoAi.ProcessHandCommand("auto_fight", 0);
                       Ui(Ui.UI_SYSTEM):UpdateOnlineState();
              end
        end
	  local nMyMapId	= me.GetMapTemplateId();
	  if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2597"});
	  else
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",27,2597"});
	  end
      nRoseTimerId = Ui.tbLogic.tbTimer:Register(30, self.CloseDBWindow, self);
end
----------------------------
tbSuperMapLink:Init();
----------------------------