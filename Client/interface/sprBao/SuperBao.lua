local tbSuperBao	= UiManager
Map.tbSuperBao		= tbSuperBao;
local nTime4State = 0;
local nTimerId1 = 0;
local nlogB=0
local nLvMapId
local nTrainMapId				
local nTrainWorldPosX			
local nTrainWorldPosY			
local Traindx = 0				
local Traindy = 0				
local nOnOfftrain = 0
local nOnOffexit = 0
local nOnOffVAGT = 0
local nAutoHour
local nAutoMinute
local nAutoSecond
local AutoLinkTaskState = 0
local nSubTaskId
local nActionType
local nCityId
local nCityIdc
local nHPLvId            
local nMPLvId
local nMPLvId1 
local nCount_FreeBag
local nFlagGoHome = 0
local nFlagBag1 = 0
local nFlagBag2 = 0
local nCFreeBag = 0		 
local nLvBuyItem	
local nCBuyHP  		
local nCBuyMP 		
local nCBuyFood		
local nCBuyHTPc 	
local nCBuyHTP
local bCNeedRepair = 0 
local material
local nTimerId = 0
local nCloseActionType = 0
local nTaskMax	     
local nWuMax   = 1  
local nShouMax = 1   
local nFangMax = 1   
local nMoMax   = 1   
local rTimerId = 0 
local BINDMONEY      = "bindmoney";        
local LINKTASKCANCEL = "linktask_cancel";  
local ITEM           = "item";             
local EXP            = "exp";             
local nAwardFirst             
local nAwardSecond       
local nAwardThird       
local nXuanMix = 2;             
local nExp = 0;  		
local nBind = 0;  		
local tbTeamLeader = {}; 
local nCountPT = 0;
local nFlag = 0
local nCount={}
local g_killnpcs = {}
local g_finditem = {}
local bgua=0
local nGuaeReg  = 0
local nGuaeReg1  = 0
local nve  = 0
local nAutoTask
local Fire
local nRac
local nMoney
local ActiveTime = 0;
local ActiveTimeT1 = 0;
local ActiveTimeT2 = 0;
local nCloseUiTimerIdc = 0;
local nCloseUiTimerId = 0;
local nCloseUiTimerIdHT = 0;
local Horse_check=0;
local AutoPath=0;
local nBac
local nKptp 
local GhepHT
local GhepHT2
local GhepHT3
local LvHT
local nPhuChk = 0;
local nActive = 0;
local nSetPhu = 0;
local nXY = 0;
local nCheckSkill = 0;
local nBuyTTP = 0;       
local nChetQuayLai = 0;
local nBacE = 0;       
local nHorse = 0;
local nSetskillId = 0;        
local nSetCancel = 0;
local nSetHTPId = 7;
local szMsgAutoRemote
local hhFindSkillList = {21,24,27,59,62,66,76,80,83,107,106,143,146,149,194,198,202}	
local tbAwardName = {"Ti???n","H???y","Huy???n Tinh","Kinh Nghi???m"}
local tbAwardCode = {"bindmoney","linktask_cancel","item","exp"}
tbSuperBao.UpdateAll=function(self,ifSave)	--
	local tbSaveData = Ui.tbLogic.tbSaveData;
	local tbSprBao_Setting = Ui:GetClass("SprBao_setting");
	local tbSetting = tbSprBao_Setting:Load(tbSprBao_Setting.DATA_KEY) or {};
	self.nAutoTask	= tbSetting.nAutoTask or 0;
	self.nAutoHour = tbSetting.nHour or 0;
	self.nAutoMinute = tbSetting.nMinute or 0;
	self.nAutoSecond = tbSetting.nSecond or 0;
	self.nAwardFirst = tbSetting.nAwardFirst or 1;
	self.nAwardSecond = tbSetting.nAwardSecond or 1;
	self.nAwardThird = tbSetting.nAwardThird or 1;
	nTaskMax = tbSetting.nMaxCount or 50;
	nCheckSkill = tbSetting.nCheckSkill or 0; 
	nChetQuayLai = tbSetting.nChetQuayLai or 0;
	nBacE = tbSetting.nBacexit or 0;
	nRac = tbSetting.nRac or 0;	
	nHorse = tbSetting.nHorse or 0;  
	nSetHTPId =	tbSetting.nSetHTPId or 7
	nSetskillId = tbSetting.nSetskillId or 0;    
	nOnOfftrain = tbSetting.nGuaJi or 0;
	nTrainMapId = tbSetting.nGuaJiMap or 0;
	nTrainWorldPosX = tbSetting.nGuaJiX or 0;
	nTrainWorldPosY = tbSetting.nGuaJiY or 0;
	Traindx	= tonumber(tbSetting.nGuaJiDX) or 0;
	Traindy = tonumber(tbSetting.nGuaJiDY) or 0;
	nXuanMix = tbSetting.nXuanJingLevel or 0;
	nBind = tbSetting.nBindLevel or 0;
	nExp = tbSetting.nExpLevel or 0;
	nSetCancel = tbSetting.nCancel or 10;
	nCityId = tbSetting.nCityId or 5;
	nHPLvId = tbSetting.nHPLvId or 3; 
	nMPLvId = tbSetting.nMPLvId or 3;
	nMPLvId1 = tbSetting.nMPLvId1 or 3;
	nCBuyHP = tbSetting.nHpLevel or 0;
	nCBuyMP = tbSetting.nMpLevel or 0;
	nCBuyFood = tbSetting.nFoodLevel or 0;
	nCBuyHTP = tbSetting.nHtpLevel or 0;
	nMoMax = tbSetting.nItemLevel or 0;
	nWuMax = tbSetting.nWuMaxLevel or 0;
	nFangMax = tbSetting.nEquipLevel or 0;
	nShouMax = tbSetting.nShouMaxLevel or 0;
	Fire = tbSetting.bFire or 0;
	LvHT = tonumber (tbSetting.nLvHT) or 0;
	GhepHT = tonumber (tbSetting.nGhepHT) or 0;
	GhepHT2 = tonumber (tbSetting.nGhepHT2) or 0;
	GhepHT3 = tonumber (tbSetting.nGhepHT3) or 0;
	nOnOffexit = tbSetting.nExitGame or 0;
	nOnOffVAGT = tbSetting.nVAGT or 0;
	nKptp = tonumber (tbSetting.nKptp) or 200;
	nMoney = tonumber (tbSetting.nMoney) or 2000;
	nCFreeBag = tonumber (tbSetting.nFullbag) or 6;
	nBac = tonumber (tbSetting.nBac) or 10000;
	nXY = tbSetting.nXyId or 0; 
	if ifSave == 1 then
		if tonumber(self.nAutoTask) == 1 then
			me.Msg(string.format("<color=yellow>Th???i gian t??? ?????ng l??m nhi???m v???: <color><color=pink> %s:%s:%s<color>",self.nAutoHour,self.nAutoMinute,self.nAutoSecond));
			self:SwitchAutoLinkTask(1);
		else
			self:SwitchAutoLinkTask(0);
		end
	end
	if nlogB==0 then
		me.Msg(string.format("<bclr=pink><color=white>- Nhi???m v??? Bao V???n ?????ng thi???t l???p: <color><color=white>%s<color>","<bclr=red><color=yellow>"..nTaskMax)); 
	end
	if nSetPhu == 0 then
		local SaveCiTy = tbSetting.nCityId ;
		if tbSetting.nCityId==1 then SaveCiTy = "V??n Trung Tr???n"
		elseif tbSetting.nCityId==2 then SaveCiTy = "Long M??n Tr???n"
		elseif tbSetting.nCityId==3 then SaveCiTy = "V??nh L???c Tr???n"
		elseif tbSetting.nCityId==4 then SaveCiTy = "?????o H????ng Th??n"
		elseif tbSetting.nCityId==5 then SaveCiTy = "Giang T??n Th??n"
		elseif tbSetting.nCityId==6 then SaveCiTy = "Th???ch C??? Tr???n"
		elseif tbSetting.nCityId==7 then SaveCiTy = "Long Tuy???n Th??n"
		elseif tbSetting.nCityId==8 then SaveCiTy = "Ba L??ng Huy???n"
		elseif tbSetting.nCityId==23 then SaveCiTy = "Bi???n Kinh Ph???"
		elseif tbSetting.nCityId==24 then SaveCiTy = "Ph?????ng T?????ng Ph???"
		elseif tbSetting.nCityId==25 then SaveCiTy = "T????ng D????ng Ph???"
		elseif tbSetting.nCityId==26 then SaveCiTy = "D????ng Ch??u Ph???"
		elseif tbSetting.nCityId==27 then SaveCiTy = "Th??nh ???? Ph???"
		elseif tbSetting.nCityId==28 then SaveCiTy = "?????i L?? Ph???"
		elseif tbSetting.nCityId==29 then SaveCiTy = "L??m An Ph???"
		end
		if nlogB==0 then
		me.Msg("<bclr=red><color=white>- S??? d???ng <color><bclr=red><color=yellow>[Truy???n T???ng Ph??]<color>");
		me.Msg(string.format("<bclr=red><color=white>- Th??nh v??? tr??? nhi???m v???: <color><color=yellow>%s<color><color>","<bclr=red><color=yellow>"..SaveCiTy));
		end
	end
	if nCBuyHP > 0 or nCBuyMP > 0 then
		local NameHPLv = tbSetting.nHPLvId ;
		local NameMPLv = tbSetting.nMPLvId ;
		if tbSetting.nHPLvId==1 then NameHPLv = "Kim s??ng d?????c (ti???u)"
		elseif tbSetting.nHPLvId==2 then NameHPLv = "Kim s??ng d?????c (trung)"
		elseif tbSetting.nHPLvId==3 then NameHPLv = "Kim s??ng d?????c (?????i)"
		elseif tbSetting.nHPLvId==4 then NameHPLv = "H???i Thi??n ????n"
		elseif tbSetting.nHPLvId==5 then NameHPLv = "C???u Chuy???n Ho??n H???n ????n"
		end
		if tbSetting.nMPLvId==1 and tbSetting.nMPLvId1==2 then NameMPLv = "Ng??ng th???n ????n (ti???u)"
		elseif tbSetting.nMPLvId==2 and tbSetting.nMPLvId1==2 then NameMPLv = "Ng??ng th???n ????n (trung)"
		elseif tbSetting.nMPLvId==3 and tbSetting.nMPLvId1==2 then NameMPLv = "Ng??ng th???n ????n (?????i)"
		elseif tbSetting.nMPLvId==4 and tbSetting.nMPLvId1==2 then NameMPLv = "?????i B??? T??n"
		elseif tbSetting.nMPLvId==5 and tbSetting.nMPLvId1==2 then NameMPLv = "Th??? ?? ho??n th???n ????n"
		elseif tbSetting.nMPLvId==1 and tbSetting.nMPLvId1==3 then NameMPLv = "Th???a ti??n m???t (ti???u)"
		elseif tbSetting.nMPLvId==2 and tbSetting.nMPLvId1==3 then NameMPLv = "Th???a ti??n m???t (trung)"
		elseif tbSetting.nMPLvId==3 and tbSetting.nMPLvId1==3 then NameMPLv = "Th???a ti??n m???t (?????i)"
		elseif tbSetting.nMPLvId==4 and tbSetting.nMPLvId1==3 then NameMPLv = "Th???t X???o B??? T??m ????n"
		elseif tbSetting.nMPLvId==5 and tbSetting.nMPLvId1==3 then NameMPLv = "Ng?? Hoa Ng???c L??? Ho??n"
		end
		if nlogB==0 then
		me.Msg(string.format("<bclr=red><color=white>-M??u mua lo???i: <color><color=yellow>[%s]<color><color>","<bclr=red><color=yellow>"..NameHPLv));
		me.Msg(string.format("<bclr=red><color=white>-Mana mua lo???i: <color><color=yellow>[%s]<color><color>","<bclr=red><color=yellow>"..NameMPLv));
		end
	end
	nAwardFirst = tbAwardCode[self.nAwardFirst];      
	nAwardSecond = tbAwardCode[self.nAwardSecond];   
	nAwardThird = tbAwardCode[self.nAwardThird];
	tbSuperBao:AutoPhu();
	tbSuperBao:PhuChk() 
	local nCount_GoHome = me.GetItemCountInBags(18,1,nSetHTPId,1);
	if nlogB==0 then
		if  nSetPhu == 0 and (nSetHTPId == 309 or nSetHTPId == 310 or nSetHTPId == 13 or nSetHTPId == 235 or nSetHTPId == 12 or nSetHTPId == 195 ) then
			me.Msg("<color=yellow>-<bclr=blue><color=white> [V?? H???n Truy???n T???ng Ph??]  <bclr><color=yellow>c??n??? <color><bclr=red><color=white>[ "..nCount_GoHome.." ]");
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>S??? d???ng: <bclr=red><color=white>[V?? H???n Truy???n T???ng Ph??]")
		elseif  nSetPhu == 1 and (nSetHTPId == 316 or nSetHTPId == 315 or nSetHTPId == 118 or nSetHTPId == 234 or nSetHTPId == 23 ) then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>S??? d???ng: <bclr=red><color=white>[V?? H???n H???i Th??nh Ph??]")
			me.Msg("<color=yellow>-<bclr=blue><color=white> [V?? H???n H???i Th??nh Ph??]  <bclr><color=yellow>c??n??? <color><bclr=red><color=white>[ "..nCount_GoHome.." ]");
		elseif nSetPhu == 1 and nSetHTPId == 7 and nCBuyHTP > 0 then
			me.Msg("<color=yellow>-<bclr=blue><color=white> [H???i Th??nh Ph??]  <bclr><color=yellow>c??n??? <color><bclr=red><color=white>[ "..nCount_GoHome.." ]");
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>S??? d???ng: <bclr=red><color=white>[H???i Th??nh Ph??]")
		elseif nSetPhu == 1 and nSetHTPId == 7 and nCBuyHTP == 0 then
			me.Msg("<color=yellow>-<color><bclr=red><color=white>Kh??ng s??? d???ng Ph?? <bclr>");
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>[Kh??ng s??? d???ng Ph??] ")
		end	
	end	
end

tbSuperBao.UpdateHexuan=function(self,ifSave)	
	local tbSaveData = Ui.tbLogic.tbSaveData;
	local tbSprBao_Setting = Ui:GetClass("SprBao_setting");
	local tbSetting = tbSprBao_Setting:Load(tbSprBao_Setting.DATA_KEY) or {};
	LvHT = tonumber (tbSetting.nLvHT) or 0;
	GhepHT = tonumber (tbSetting.nGhepHT) or 0;
	GhepHT2 = tonumber (tbSetting.nGhepHT2) or 0;
	GhepHT3 = tonumber (tbSetting.nGhepHT3) or 0;
end

function tbSuperBao:OnAutoLinkTask()
	if self.AutoLinkTaskState == 0 then
	    Timer:Close(self.AutoLinkTaskTimer)
		return
	end
	local nHour = tonumber(tostring(os.date("%H", GetTime())));
	local nMinute = tonumber(tostring(os.date("%M", GetTime())));
	local nSecond = tonumber(tostring(os.date("%S", GetTime())));
	if (nHour == tonumber(self.nAutoHour)) and (nMinute == tonumber(self.nAutoMinute)) and (nSecond == tonumber(self.nAutoSecond)) then
		me.Msg("<color=yellow>???? ?????n gi??? l??m BV?? ho???c VAGT<color>");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>???? ?????n gi??? l??m BV?? ho???c VAGT");
		if bgua==1 then 
		UiManager:StopBao();
		AutoAi.ProcessHandCommand("auto_fight", 0);
		end
		AutoAi.SetTargetIndex(0);
		bgua=0;
		nve=Ui.tbLogic.tbTimer:Register(3.0*Env.GAME_FPS, self.ve,self,nTrainMapId,nTrainWorldPosX,nTrainWorldPosY);
		return
	end
end

function tbSuperBao:SwitchAutoLinkTask(switch)
	if tonumber(switch) == 1 then
		if self.AutoLinkTaskState ~= 1 then		
			self.AutoLinkTaskState = 1;
			UiManager:OpenWindow("UI_INFOBOARD","<color=yellow>T??? ?????ng l??m nhi???m v??? BV?? ho???c VAGT theo th???i gian ?????nh tr?????c");
			self.AutoLinkTaskTimer = Timer:Register(Env.GAME_FPS,self.OnAutoLinkTask,self);
		else
			UiManager:OpenWindow("UI_INFOBOARD","<color=yellow>T??? ?????ng l??m nhi???m v??? BV?? ho???c VAGT theo th???i gian");
		end
	else
		if self.AutoLinkTaskState ~= 0 then		
			self.AutoLinkTaskState = 0;
		else
		end
	end
end

tbSuperBao.StartGua =function(self)
	if bgua==1 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>??ang trong tr???ng th??i Luy???n c??ng")
		return
	end
	if bgua==0 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>B???t ?????u Luy???n c??ng")
		self:UpdateAll(0);
		tbSuperBao:OpenExtBag();
		tbSuperBao:AutoPhu();
		tbSuperBao:PhuChk() 
		tbSuperBao:CheckItem();
		tbSuperBao:CheckItem1();
		tbSuperBao:CheckItem2();
		tbSuperBao:CheckItem3();
		
			if (nTrainWorldPosX == 0 or nTrainWorldPosY == 0 ) then
				UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Ch??a thi???t l???p<bclr=red><color=yellow>[T???a ????? Luy???n C??ng]")
				me.Msg("<bclr=red><color=white>B???n ch??a l???y  <bclr=red><color=yellow>[T???a ????? Luy???n C??ng], <bclr><bclr=red><color=white> h???y l???y <bclr=red><color=yellow>[T???a ????? Luy???n C??ng] v?? [T???a ????? Ph??] <bclr=red><color=white>tr??n c??ng m???t B???n ????? th??ch h???p");
				UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Ng???ng Luy???n c??ng")
				bgua=0;
				return 0;
			elseif (Traindx == 0 or Traindy == 0) then
				UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>[T???a ????? Ph??] <bclr=red><color=yellow>T??? ?????ng")	
			end 
		bgua=1;	
		local nMyMapId	= me.GetMapTemplateId();
		if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
			nCityId = nMyMapId
		end
		local szPosText	= "";
		szPosText	= string.format("<bclr=red><color=white>B???n ????? Luy???n???<bclr><bclr=red><color=yellow>%s <bclr><bclr=blue><color=white>(%d,%d)", GetMapNameFormId(nTrainMapId), nTrainWorldPosX / 8, nTrainWorldPosY / 16);
		Ui(Ui.UI_TASKTIPS):Begin(szPosText);
		me.Msg(szPosText);
		self.nActionType = 20
		tbSuperBao:CTestLv();
		AutoAi.ProcessHandCommand("auto_fight", 0);
		nGuaeReg=Ui.tbLogic.tbTimer:Register(2.5 * Env.GAME_FPS, self.OnTimer_Gua,self,nTrainMapId,nTrainWorldPosX,nTrainWorldPosY);
		if (nCloseUiTimerIdc == 0) then
			nCloseUiTimerIdc = Ui.tbLogic.tbTimer:Register(120 * Env.GAME_FPS, tbSuperBao.CloseHP);
		end	
		if (Horse_check == 0) then
			Horse_check = Ui.tbLogic.tbTimer:Register(3 * Env.GAME_FPS, tbSuperBao.Horse);
		end	
	end
end
tbSuperBao.OnTimer_Gua = function(self,nMapId,nPosX,nPosY)
	local PhuItemF = me.FindItemInBags(18,1,309,1)[1] or me.FindItemInBags(18,1,310,1)[1] or me.FindItemInBags(18,1,13,1)[1] or me.FindItemInBags(18,1,235,1)[1] or me.FindItemInBags(18,1,12,1)[1] or me.FindItemInBags(18,1,195,1)[1] or me.FindItemInBags(18,1,316,1)[1] or me.FindItemInBags(18,1,315,1)[1] or me.FindItemInBags(18,1,18,1)[1] or me.FindItemInBags(18,1,234,1)[1] or me.FindItemInBags(18,1,23,1)[1] or me.FindItemInBags(18,1,7,1)[1];
	local PhuItem = me.FindItemInBags(18,1,309,1)[1] or me.FindItemInBags(18,1,310,1)[1] or me.FindItemInBags(18,1,13,1)[1] or me.FindItemInBags(18,1,235,1)[1] or me.FindItemInBags(18,1,12,1)[1] or me.FindItemInBags(18,1,195,1)[1] or me.FindItemInBags(18,1,316,1)[1] or me.FindItemInBags(18,1,315,1)[1] or me.FindItemInBags(18,1,18,1)[1] or me.FindItemInBags(18,1,234,1)[1] or me.FindItemInBags(18,1,23,1)[1];
	local PhuItem2 = me.FindItemInBags(18,1,7,1)[1];
	local n = self.nActionType
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	if UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1 then
		return
	end
	if UiManager:WindowVisible(Ui.UI_TEXTINPUT) == 1 then
		return
	end
	if (me.IsDead() == 1) and nChetQuayLai == 1 then
			me.SendClientCmdRevive(0);
			if me.nAutoFightState == 1 then
				AutoAi.ProcessHandCommand("auto_fight", 0);
			end
			return
	end
	local tbMyPos	= {};
	tbMyPos.nMapId, tbMyPos.nPosX, tbMyPos.nPosY	= me.GetWorldPos();
	if (tbMyPos.nMapId <= 0 or tbMyPos.nPosX <= 0) then
		return;	
	end		
	if self.nActionType==0 then
		return 0
	end
	if self.nActionType==20 then
		tbSuperBao:CloseShop()
		tbSuperBao:AutoPhu()
		tbSuperBao.PhuChk()
		local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
		if ((nCurMapId <30 and nCurMapId >22) or (nCurMapId<9 and nCurMapId>0)) then
			tbSuperBao:MyNewGuaJi2(self,nMapId,nPosX,nPosY);
		end
		
		if self.nActionType== 21 then
			return 40
		end
		local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
		if nCurMapId~=nMapId then
			local tbPosInfo ={}
			tbPosInfo.szType = "pos"
			tbPosInfo.szLink = "??i???m treo m??y,"..nMapId..","..nPosX..","..nPosY
			if (nMapId==130 or nMapId==122 or nMapId==115 or nMapId==101 or nMapId==108 or nMapId==94 or nMapId==114) and nCurMapId==11 then 
				me.StartAutoPath(1534,3098)
			elseif nMapId==133 and nCurMapId==10 then 
				me.StartAutoPath(1828,3720)
			elseif (nMapId==120 or nMapId==136 or nMapId==137 or nMapId==128) and nCurMapId==22 then
				me.StartAutoPath(1609,3233)	
			else
			Ui.tbLogic.tbAutoPath:GotoPos({nMapId=nMapId,nX=nPosX,nY=nPosY}) 
			end
		elseif math.abs(nPosX-nWorldPosX) < 10 and  math.abs(nPosY-nWorldPosY) < 10 then
			local function fnCreateTeam()
				self:CreateTeam();
				return 0
			end
			if me.nAutoFightState ~= 1 then
				tbSuperBao:setLeftSkillhh()      
				AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey())
				Ui.tbLogic.tbTimer:Register(10 * Env.GAME_FPS, fnCreateTeam);
			end
			tbSuperBao:MyNewGuaJi2(self,nMapId,nPosX,nPosY);
			tbSuperBao:AutoPhu()
			self:TeamApply();
			return 100
		else
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
			end
			me.StartAutoPath(nPosX,nPosY);
		end
		return 40
	elseif self.nActionType==21 then
		if me.nAutoFightState == 1 then
			AutoAi.ProcessHandCommand("auto_fight", 0);
		end
		local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
		local bChecked = me.GetNpc().IsRideHorse();
		if (nMapId <30 and nMapId >22) or (nMapId<9 and nMapId>0) then
				me.StartAutoPath(nCurWorldPosX, nCurWorldPosY);
				self.nActionType = 22	
				return (2 * Env.GAME_FPS)
		end   
			local nX1 = nPosX 
			local nY1 = nPosY 
			local tbPosInfo ={}
			tbPosInfo.szType = "pos"
			tbPosInfo.szLink = "??i???m ch???y v???,"..nMapId..","..Traindx..","..Traindy
			if nPhuChk == 1 and (Traindx==0 or Traindy==0) then
				local function fngobao()
					local nMap = me.GetMapTemplateId();
					if nMap >29 then 
						tbSuperBao:fnfindNpc(3574,"D?? Luy???n ?????i S??");
					end
					return 0
				end
				local M1, X1, Y1 = me.GetWorldPos();
					local function fngotr()
						if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
							return
						end
						if (nX1-X1)< 30 and (nY1-Y1)< 30 then
						me.StartAutoPath(nX1+35, nY1+35);
						Ui.tbLogic.tbTimer:Register(80, fngobao); 
						if (AutoPath > 0) then
							Ui.tbLogic.tbTimer:Close(AutoPath);
							AutoPath = 0;
						end
						return 0
						end
					end
				if AutoPath==0 then	
					AutoPath=Ui.tbLogic.tbTimer:Register(15 * Env.GAME_FPS, fngotr); 
				end 
				me.StartAutoPath(nX1-35, nY1-35);
				if (nX1-X1)> 30 and (nY1-Y1)> 30 then
					Ui.tbLogic.tbTimer:Register(18, fngobao); 
				end 
			elseif nPhuChk == 1 and (Traindx~=0 or Traindy~=0) then
				local function fngobao()
					tbSuperBao:fnfindNpc(3574,"D?? luy???n ?????i s?? ");
					return 0
				end
				Ui.tbLogic.tbTimer:Register(18, fngobao);
				Ui.tbLogic.tbAutoPath:GotoPos({nMapId=nMapId,nX=Traindx,nY=Traindy}) 
			elseif nPhuChk == 0	then
				tbSuperBao:MapIdc2()
				if (nCloseActionType == 0) then
					nCloseActionType = Ui.tbLogic.tbTimer:Register(3 * Env.GAME_FPS, tbSuperBao.CheckMap3);
				end 
			end		
				return (2 * Env.GAME_FPS)
	elseif  self.nActionType==22 then
		tbSuperBao:CFreeBag()  
		if ( me.nPkModel~= Player.emKPK_STATE_PRACTISE ) then
			me.nPkModel = Player.emKPK_STATE_PRACTISE;
		end
		local bFlag = 0   
		for i = 1,LvHT do
			nCount[i] = me.GetItemCountInBags(18,1,1,i)
			if nCount[i] >= GhepHT3 and i<LvHT then  
				bFlag=1
			end
		end
		for i = 1,LvHT do
			nCount[i] = nCount[i]+ me.GetItemCountInBags(18,1,114,i)
			if nCount[i] >= GhepHT3 and i<LvHT  then  
				bFlag=1
			end
		end
		if 	bFlag==1 then
			tbSuperBao:hexuan2();
		else 
			tbSuperBao:CloseShop()
			self.nActionType=23
		end	
	elseif  self.nActionType==23 then
			tbSuperBao:CFreeBag()
			tbSuperBao:AutoPhu()
			tbSuperBao.PhuChk()
		if PhuItem then
			nCBuyHTPc = 0;  
			tbSuperBao:CloseShop()
			self.nActionType =24
		elseif (not PhuItem) and (not PhuItem2) and (nCBuyHTP > 0 or bCNeedRepair == 1) and nCount_FreeBag == 1 then
			nCBuyHTPc = nCBuyHTP;
			UiManager:CloseWindow(Ui.UI_SHOP);
			tbSuperBao:CBuyHTPhu();
		else 
			tbSuperBao:CloseShop()
			self.nActionType =24
		end	
	elseif  self.nActionType==24 then
			tbSuperBao:CFreeBag()
		local nCountFood = me.GetItemCountInBags(19,3,1,nLvBuyItem); 
		tbSuperBao:CNeedRepair();
		if ((nCBuyFood > 0 and nCountFood < nCBuyFood) or bCNeedRepair == 1) and nCount_FreeBag == 1 then
				tbSuperBao:CBuyFood();	
		else
			tbSuperBao:CloseShop()
			self.nActionType = 25
		end 
	elseif  self.nActionType==25 then
		tbSuperBao:CFreeBag()
		tbSuperBao:CNeedRepair();
		local nCountHP = me.GetItemCountInBags(17,1,1,nHPLvId); 
		local nCountMP = me.GetItemCountInBags(17,nMPLvId1,1,nMPLvId); 
		if ((nCBuyHP>0 and nCountHP < nCBuyHP) or (nCBuyMP > 0 and  nCountMP < nCBuyMP)) and nCount_FreeBag == 1 then 
			tbSuperBao:CBuyHPMP();
		else
			tbSuperBao:CloseShop()
			self.nActionType =26
		end
	elseif  self.nActionType==26 then
		tbSuperBao:CFreeBag()
		tbSuperBao:CloseShop()
		if nCount_FreeBag == 0 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>H??nh trang kh??ng an to??n cho Luy???n C??ng")
		me.Msg("<color=yellow>H??nh trang kh??ng an to??n cho Luy???n C??ng");
		me.Msg("<color=yellow>H???y s???p x???p ho???c thi???t l???p kho???ng tr???ng l???i h??nh trang h???p l??");
		end	
		if (not PhuItem) and (not PhuItem2) and (nCBuyHTP > 0 or bCNeedRepair == 1) and nCount_FreeBag == 1 then
			self.nActionType = 23
		else	
			self.nActionType = 20
		end	
	end
end

tbSuperBao.MyNewGuaJi2 = function (self,nMapId,nPosX,nPosY)
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	local nCountHTP = me.GetItemCountInBags(18,1,7,1);
	local nCountHP = me.GetItemCountInBags(17,1,1,nHPLvId); 
	local nCountMP = me.GetItemCountInBags(17,nMPLvId1,1,nMPLvId);
	local nCountFood = me.GetItemCountInBags(19,3,1,nLvBuyItem);
	local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();	
	tbSuperBao:CNeedRepair();
	tbSuperBao:CFreeBag();
	tbSuperBao:AutoPhu();
	tbSuperBao.PhuChk();
	if (me.IsDead() == 1) then
		me.SendClientCmdRevive(0);
		if me.nAutoFightState == 1 then
			AutoAi.ProcessHandCommand("auto_fight", 0);
		end
		return
	end
	local tbMyPos	= {};
	tbMyPos.nMapId, tbMyPos.nPosX, tbMyPos.nPosY	= me.GetWorldPos();
	if (tbMyPos.nMapId <= 0 or tbMyPos.nPosX <= 0) then
		return;	
	end
	if self.nActionType~=20 then
		return
	end	
	if me.nAutoFightState == 1 then
		local bChecked = me.GetNpc().IsRideHorse();
		tbSuperBao:setLeftSkillhh();
	end
	local bFlag = 0
	for i = 1,LvHT do
		nCount[i] = me.GetItemCountInBags(18,1,1,i)
		if nCount[i] >= GhepHT3 and i<LvHT  then
			bFlag=1
		end
	end
	for i = 1,LvHT do
		nCount[i] = nCount[i]+ me.GetItemCountInBags(18,1,114,i)
		if nCount[i] >=GhepHT3 and i<LvHT then
			bFlag=1
		end
	end      
	local nFreeBagTrain = me.CalcFreeItemCountInBags(19,3,1,5,0,0)
	if ((nFreeBagTrain < 1 or ((nMapId <30 and nMapId >22) or (nMapId<9 and nMapId>0))) and bFlag==1) then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>X??? l?? h??nh trang: Gh??p Huy???n Tinh")
		self.nActionType=21
		return 10
	end 
	if (nCBuyFood > 0 and nCountFood < 1) or (((nMapId <30 and nMapId >22) or (nMapId<9 and nMapId>0)) and (nCBuyFood > 0 and nCountFood < nCBuyFood))  or bCNeedRepair == 1 then
		self.nActionType=21
		return 10
	end
	if (nCountHTP == 0 or bCNeedRepair == 1) and nCount_FreeBag == 1 and ((nMapId <30 and nMapId >22) or (nMapId<9 and nMapId>0)) and nSetHTPId == 7 and nCBuyHTP > 0 then
		self.nActionType=21
		return 10
	end
	tbSuperBao:CNeedRepair();
	if bCNeedRepair == 1 then
		self.nActionType=21
		return 10
	end
	tbSuperBao:AutoFood();
end
 
tbSuperBao.StartBao = function(self)
	if (nTimerId ~= 0) then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>??ang trong tr???ng th??i l??m Bao V???n ?????ng")
		return
	end
	if (nTimerId == 0) then
		if nlogB==0 then
		me.Msg("<bclr=red><color=white>B???t ?????u l??m Bao V???n ?????ng<color>")
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Start BV??")
			if nRac==1 then
			tbSuperBao:Check4Start();
			end
		end
		tbSuperBao:OpenExtBag();
		local nMyMapId	= me.GetMapTemplateId();
		if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
			nCityId = nMyMapId
		end		
		self:UpdateAll(0);
		tbSuperBao:TeamLeave();
		if nlogB==0 then
			me.Msg("<color=0,255,255>Bao V???n ?????ng ???????c thi???t l???p l??: "..nTaskMax.." l???n <color>")	
			if nOnOfftrain == 1 then
				me.Msg("<bclr=red><color=white>- Ho??n th??nh Bao V???n ?????ng:  <bclr=red><color=yellow>[T??? Luy???n C??ng]");
			end
			if nOnOfftrain == 0 and nOnOffexit == 0 and nOnOffVAGT == 0 then
				me.Msg("<bclr=red><color=white>- Ho??n th??nh Bao V???n ?????ng:  <bclr=red><color=yellow>[?????ng y??n ??? Th??nh]");
			end
			if nOnOffexit == 1 then
				me.Msg("<bclr=red><color=white>- Ho??n th??nh Bao V???n ?????ng:  <bclr=red><color=yellow>[Tho??t Game]");
			end
			if nOnOffVAGT == 1 then
				me.Msg("<bclr=red><color=white>- Ho??n th??nh Bao V???n ?????ng:  <bclr=red><color=yellow>[VAGT]");
			end
		end	
		if nOnOfftrain == 1 and nTrainMapId == 0  then
			me.Msg("<bclr=red><color=white>- B???n ????? b???n thi???t l???p: <bclr=red><color=yellow>[Kh??ng th??? Luy???n C??ng]");
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>B???n ????? thi???t l???p:<bclr=red><color=yellow>[Kh??ng th??? Luy???n C??ng]")
			return 0;
		end
		tbSuperBao:CheckItem();
		tbSuperBao:CheckItem1();
		tbSuperBao:CheckItem2();
		tbSuperBao:CheckItem3();
		tbSuperBao:CTestLv()
		tbSuperBao:fnAutoBaobao()
		if (nTimerId == 0) then
			nTimerId = Ui.tbLogic.tbTimer:Register(1 * Env.GAME_FPS, tbSuperBao.OnTimer, self)
		end
		if (nCloseUiTimerIdc == 0) then
			nCloseUiTimerIdc = Ui.tbLogic.tbTimer:Register(120 * Env.GAME_FPS, tbSuperBao.CloseHP);
		end	
		if (ActiveTime == 0) then
		ActiveTime = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 62,self.ActiveBaoT1,self);
		end
		if (Horse_check== 0) then
			Horse_check = Ui.tbLogic.tbTimer:Register(3 * Env.GAME_FPS, tbSuperBao.Horse);
		end	
		nActive = 1;
		nlogB=0;
	end	
end
tbSuperBao.StopBao = function(self)
	local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();
		Ui.tbLogic.tbAutoPath:GotoPos({nMapId=nCurMapId,nX=nWorldPosX,nY=nWorldPosY}) 
		tbSuperBao:Check4Stop();
	if (nCloseActionType > 0) then
		Ui.tbLogic.tbTimer:Close(nCloseActionType);
		nCloseActionType = 0;
	end
	AutoAi.SetTargetIndex(0);
	if bgua==0 and nTimerId == 0 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>???? ng???ng m???i ho???t ?????ng");
		return
	end
	
	if bgua==1 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Ng???ng Luy???n c??ng ");
		me.Msg("<bclr=gold><color=white>Ng???ng Bao V???n ?????ng!<color>")
	elseif (nTimerId  ~= 0) and nlogB==0 then
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Ng???ng Bao V???n ?????ng")
	end
	if AutoLinkTaskState == 1 then
		self.nActionType = 20
	else 
		self.nActionType = 0
	end
	
	AutoAi.ProcessHandCommand("auto_fight", 0);
	self.nActionType = 0
	Ui.tbLogic.tbTimer:Close(self.nTimerRegisterId);
	if (nTimerId  ~= 0) then
		Ui.tbLogic.tbTimer:Close(nTimerId);
	end
	if (rTimerId > 0) then
		Ui.tbLogic.tbTimer:Close(rTimerId);
	end
	if (nCloseUiTimerId > 0) then
		Ui.tbLogic.tbTimer:Close(nCloseUiTimerId);
	end
	if (Horse_check > 0) then
	Ui.tbLogic.tbTimer:Close(Horse_check)
	Horse_check = 0
	end
	if (nCloseActionType > 0) then
		Ui.tbLogic.tbTimer:Close(nCloseActionType);
		nCloseActionType = 0;
	end
	if (nCloseUiTimerIdc > 0) then
		Ui.tbLogic.tbTimer:Close(nCloseUiTimerIdc);
		nCloseUiTimerIdc = 0;
	end
	Ui.tbLogic.tbTimer:Close(ActiveTime);
	Ui.tbLogic.tbTimer:Close(ActiveTimeT1);
	Ui.tbLogic.tbTimer:Close(ActiveTimeT2);
	if nActive == 1 then 
		nActive = 0 ;
	end
	if (nve > 0) then
		Ui.tbLogic.tbTimer:Close(nve);
	end
	
	if bgua==1 then
		bgua=0;
		self.nActionType=0;
		AutoAi.ProcessHandCommand("auto_fight", 0);
		AutoAi:CloseAutoThrowAway();
		if (nCloseActionType > 0) then
			Ui.tbLogic.tbTimer:Close(nCloseActionType);
			nCloseActionType = 0;
		end
		if (nGuaeReg > 0) then
			Ui.tbLogic.tbTimer:Close(nGuaeReg);
		end
		nGuaeReg =0
		if (nCloseUiTimerIdc > 0) then
			Ui.tbLogic.tbTimer:Close(nCloseUiTimerIdc);
			nCloseUiTimerIdc = 0;
		end
		if (AutoPath > 0) then
			Ui.tbLogic.tbTimer:Close(AutoPath);
			AutoPath = 0;
		end
	end	
	nve = 0;
	nTimerId = 0;
	rTimerId = 0;
	ActiveTime = 0;
	ActiveTimeT2 =0;
	nlogB=0;
end
tbSuperBao.fnAutoBaobao = function(self)	
	local function fnCloseSay(szWnd)
		UiManager:CloseWindow(szWnd);
		return 10
	end
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	if UiManager:WindowVisible(Ui.UI_TEXTINPUT) == 1 then
		return
	end
	Ui.tbLogic.tbMsgInfo:Clear();	
	if (me.IsDead() == 1) then
		me.SendClientCmdRevive(0);
		self.nActionType = 1
		if me.nAutoFightState == 1 then
			AutoAi.ProcessHandCommand("auto_fight", 0);
		end
		return
	end  
	if ( me.nPkModel~= Player.emKPK_STATE_PRACTISE ) then
		me.nPkModel = Player.emKPK_STATE_PRACTISE;
	end
	local PhuItemF = me.FindItemInBags(18,1,309,1)[1] or me.FindItemInBags(18,1,310,1)[1] or me.FindItemInBags(18,1,13,1)[1] or me.FindItemInBags(18,1,235,1)[1] or me.FindItemInBags(18,1,12,1)[1] or me.FindItemInBags(18,1,195,1)[1] or me.FindItemInBags(18,1,316,1)[1] or me.FindItemInBags(18,1,315,1)[1] or me.FindItemInBags(18,1,18,1)[1] or me.FindItemInBags(18,1,234,1)[1] or me.FindItemInBags(18,1,23,1)[1] or me.FindItemInBags(18,1,7,1)[1];
	local PhuItem = me.FindItemInBags(18,1,309,1)[1] or me.FindItemInBags(18,1,310,1)[1] or me.FindItemInBags(18,1,13,1)[1] or me.FindItemInBags(18,1,235,1)[1] or me.FindItemInBags(18,1,12,1)[1] or me.FindItemInBags(18,1,195,1)[1] or me.FindItemInBags(18,1,316,1)[1] or me.FindItemInBags(18,1,315,1)[1] or me.FindItemInBags(18,1,18,1)[1] or me.FindItemInBags(18,1,234,1)[1] or me.FindItemInBags(18,1,23,1)[1];
	local PhuItem2 = me.FindItemInBags(18,1,7,1)[1];
	local nOpen		= LinkTask:GetTask(LinkTask.TSK_TASKOPEN);  
	local nTaskType		= LinkTask:GetTask(LinkTask.TSK_TASKTYPE);  
	local tbTask 		= Task:GetPlayerTask(me).tbTasks[nTaskType];
	local nContain		= LinkTask:GetTask(LinkTask.TSK_CONTAIN);
	local nSubTaskId	= LinkTask:GetTask(LinkTask.TSK_TASKID)
	local nNowDate 		= tonumber(GetLocalDate("%Y%m%d")); 
	local nOldDate 		= LinkTask:GetTask(LinkTask.TSK_DATE);
	local nQuestTime	= me.GetTask(LinkTask.TSKG_LINKTASK, LinkTask.TSK_NUM_PERDAY);
	if nNowDate~=nOldDate then
		nQuestTime = 0;
	end;
	if nQuestTime >= nTaskMax then 
		if nOnOfftrain == 1 then
			bgua=0
			nOnOffexit = 0
			nOnOffVAGT = 0
			me.Msg("<bclr=red><color=white>Ho??n th??nh nhi???m v??? Bao V???n ?????ng ng??y h??m nay, chuy???n sang <bclr=red><color=yellow> [Luy???n C??ng]");
				local function fngobaoc()
					tbSuperBao:StartGua();
					return 0
				end
			self:TeamLeave();	
			Ui.tbLogic.tbTimer:Register(50, fngobaoc);
			tbSuperBao:StopBao();
		elseif nOnOffexit == 1 then
			nOnOfftrain = 0
			nOnOffVAGT = 0
			tbSuperBao:StopBao();
			Exit();
		elseif nOnOffVAGT == 1 then
			nOnOfftrain = 0
			nOnOffexit = 0
			tbSuperBao:StopBao();
			Map.tbSuperMapLink:VAGT();
			me.Msg("<bclr=red><color=white>Ho??n th??nh nhi???m v??? Bao V???n ?????ng ng??y h??m nay, <bclr=red><color=yellow>VAGT...");
		elseif nOnOffexit == 0 and nOnOfftrain == 0 and nOnOffVAGT == 0 then
			me.Msg("<bclr=red><color=white>Ho??n th??nh nhi???m v??? Bao V???n ?????ng ng??y h??m nay, <bclr=red><color=yellow>ch??a c?? c??ng vi???c ti???p theo...");
			tbSuperBao:StopBao();
		else
			tbSuperBao:StopBao();
		end
		return
	end
		tbSuperBao:AutoPhu();
	local nMyMapId	= me.GetMapTemplateId();
	if tbTask == nil and nMyMapId>30 then
		if PhuItemF then
			if (nCloseActionType == 0) then
				nCloseActionType = Ui.tbLogic.tbTimer:Register(2 * Env.GAME_FPS, tbSuperBao.GoTest);
			end
		elseif not PhuItemF then
			tbSuperBao:GoBao()
		end
	end
	local nIdb = tbSuperBao:GetAroundNpcId(3573)
	if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
		if nIdb then
		me.Msg("<bclr=red><color=yellow>- Nhi???m v??? th???: ["..(nQuestTime + 1).."/"..nTaskMax.."]<color>") 
		local nCount_FreeBag1 = me.CalcFreeItemCountInBags(19,3,1,5,0,0)
		me.Msg("<color=yellow>- Ch??? tr???ng h??nh trang c??n: <color><bclr=red><color=white>[ "..nCount_FreeBag1.." ]");
		end
		tbSuperBao.CFreeBag();
		if nCount_FreeBag == 0 then
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Kho???ng tr???ng h??nh trang kh??ng ?????")
			me.Msg("<bclr=red><color=yellow>- Ch?? ??: <bclr=red><color=white>H??nh trang ph???i h??n<bclr=red><color=yellow> [6] <bclr=red><color=white>?? tr???ng ????? Bao V???n ?????ngho???t ?????ng! ");	
		end
		local nCountFood = me.GetItemCountInBags(19,3,1,nLvBuyItem); 
			tbSuperBao:CNeedRepair();
			tbSuperBao:CFreeBag();
		local nCountHP = me.GetItemCountInBags(17,1,1,nHPLvId); 
		local nCountMP = me.GetItemCountInBags(17,nMPLvId1,1,nMPLvId); 
		local PhuItem2 = me.FindItemInBags(18,1,7,1)[1];
		if (not PhuItem2) and nSetHTPId == 7 and nCBuyHTP > 0 then 
			self.nActionType = 15
			return 0
		elseif nCount_FreeBag == 0 then
			self.nActionType = 14
			return 0
		elseif (nCBuyHP > 0 and nCountHP < 1) or (nCBuyMP > 0 and nCountMP < 1) then
			if nCBuyHP > 0 and nCountHP < 1 then 
			end
			self.nActionType = 13		
			return 0
		elseif (nCBuyFood > 0 and nCountFood < 1) or bCNeedRepair == 1 then	
			self.nActionType = 12
			return 0
		elseif tbTask == nil then 
			if nCount_FreeBag == 1 then
				local nId = tbSuperBao:GetAroundNpcId(3573)
				if nId then
					AutoAi.SetTargetIndex(nId);
					if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
						me.AnswerQestion(0)
						me.AnswerQestion(0)
						Ui.tbLogic.tbTimer:Register(18, fnCloseSay(Ui.UI_SAYPANEL));
					end
					self.nActionType =1
				else
					tbSuperBao:fnfindNpc(3573,"Bao V???n ?????ng");
					self.nActionType =1
				end
			end
		elseif LinkTask:GetAwardState()==1 then
			local nId = tbSuperBao:GetAroundNpcId(3573)
			if nId then
				if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
					me.AnswerQestion(0)
					Ui.tbLogic.tbTimer:Register(18, fnCloseSay(Ui.UI_SAYPANEL));
				elseif UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
					me.Msg("<color=0,255,255>L???a ch???n ph???n th?????ng<color>")
					local uiGutAward = Ui(Ui.UI_GUTAWARD)
					local j = tbSuperBao:SelectAward()
					uiGutAward.OnButtonClick(uiGutAward,"ObjOptional"..j)
					uiGutAward.OnButtonClick(uiGutAward,"zBtnAccept")
				else
					AutoAi.SetTargetIndex(nId);
				end
				self.nActionType =1
			else
				tbSuperBao:fnfindNpc(3573,"Bao V???n ?????ng");
				self.nActionType =1
			end
		elseif LinkTask:CheckTaskFinish() == 1 and  nTaskType == 20000 then
			if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
				local nId = tbSuperBao:GetAroundNpcId(3573)
				if nId then
					AutoAi.SetTargetIndex(nId);
					if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
						me.AnswerQestion(1)
					elseif UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
						me.Msg("<color=0,255,255>L???a ch???n ph???n th?????ng<color>")
						local uiGutAward = Ui(Ui.UI_GUTAWARD)
						local j = tbSuperBao:SelectAward()
						uiGutAward.OnButtonClick(uiGutAward,"ObjOptional"..j)
						Ui.tbLogic.tbTimer:Register(6,uiGutAward.OnButtonClick(uiGutAward,"zBtnAccept"))
					else
						AutoAi.SetTargetIndex(nId)
					end
					self.nActionType =1
				else
					tbSuperBao:fnfindNpc(3573,"Bao V???n ?????ng");
					self.nActionType =1
				end
			end
		elseif nTaskType == 10000 then
			local Ans
			local nSubTaskId = LinkTask:GetTask(LinkTask.TSK_TASKID)
			self:OpenExtBag();
			Ans =  tbSuperBao:MyFindItem(self.g_finditem[nSubTaskId].id[1],self.g_finditem[nSubTaskId].id[2],self.g_finditem[nSubTaskId].id[3],self.g_finditem[nSubTaskId].id[4],0,2)
			if Ans == 1 then
				me.Msg("C?? v???t ph???m ????? giao")
				local nId = tbSuperBao:GetAroundNpcId(3573)
				if nId then
					if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
						local uiSayPanel = Ui(Ui.UI_SAYPANEL)
						me.AnswerQestion(1)
						Ui.tbLogic.tbTimer:Register(18, fnCloseSay(Ui.UI_SAYPANEL));
						self.nActionType = 1
					elseif  UiManager:WindowVisible(Ui.UI_ITEMGIFT) == 1  then
						tbSuperBao:MyFindItem(self.g_finditem[nSubTaskId].id[1],self.g_finditem[nSubTaskId].id[2],self.g_finditem[nSubTaskId].id[3],self.g_finditem[nSubTaskId].id[4],1,2)
						local uiGift = Ui(Ui.UI_ITEMGIFT)
						uiGift.OnButtonClick(uiGift,"BtnOk")
					else
						AutoAi.SetTargetIndex(nId);
					end
				else
					tbSuperBao:fnfindNpc(3573,"Bao V???n ?????ng");
					self.nActionType =1
				end
			else
				me.Msg("Kh??ng c?? v???t ph???m nhi???m v???")
				local nCount = me.GetItemCountInBags(self.g_finditem[nSubTaskId].id[1],self.g_finditem[nSubTaskId].id[2],self.g_finditem[nSubTaskId].id[3],self.g_finditem[nSubTaskId].id[4]);
				if nCount >=2 then
					me.Msg("T??i ????? c?? "..nCount.." v???t ph???m nhi???m v???")
					tbSuperBao:MyFindItemAndSplit(self.g_finditem[nSubTaskId].id[1],self.g_finditem[nSubTaskId].id[2],self.g_finditem[nSubTaskId].id[3],self.g_finditem[nSubTaskId].id[4])
				else
					local nCount = me.GetItemCountInBags(self.g_finditem[nSubTaskId].id[1],self.g_finditem[nSubTaskId].id[2],self.g_finditem[nSubTaskId].id[3]+6,self.g_finditem[nSubTaskId].id[4]);
					if nCount>0 then
						tbSuperBao:MyFindXiangAndTake(self.g_finditem[nSubTaskId].id[1],self.g_finditem[nSubTaskId].id[2],self.g_finditem[nSubTaskId].id[3]+6,self.g_finditem[nSubTaskId].id[4],10)
					else
						local bCanskill=1
						local id1 =self.g_finditem[nSubTaskId].ReceptId
						local canid1 = self.canReceptID(self,id1)
						bCanskill = bCanskill * canid1
						local g,d,p,l,n,buyid,Id2=unpack(self.g_finditem[nSubTaskId].Cl1)
						local Canid2 = self.canReceptID(self,Id2)
						bCanskill = bCanskill * Canid2
						local level = self.g_finditem[nSubTaskId].level;
						if (level > nMoMax) or me.dwCurMKP < nKptp or me.dwCurGTP < nKptp or me.nCashMoney < nMoney then
							bCanskill = 0;
						end
						if bCanskill==1 then
							me.Msg("T??m t??i li???u ")
							local g,d,p,l,n,buyid,nReceptId=unpack(self.g_finditem[nSubTaskId].Cl1)
							local nCount = me.GetItemCountInBags(g,d,p,l)
							if nCount<n then
								local nCount1 = me.GetItemCountInBags(g,d,tonumber(p)-1,l)
								if (nCount1+nCount)<n then
									self.material={g,d,p,l,n-nCount1,buyid}
									self.nActionType =10
									return
								else
									me.DoRecipe(nReceptId)
									self.nActionType =1
									return
								end
							end
							if self.g_finditem[nSubTaskId].Cl2 then
								local g,d,p,l,n,buyid,nReceptId=unpack(self.g_finditem[nSubTaskId].Cl2)
								local nCount = me.GetItemCountInBags(g,d,p,l)
								if nCount<n then
									local nCount2 = me.GetItemCountInBags(g,d,tonumber(p)-1,l)
									if (nCount2+nCount)<n then
										self.material={g,d,p,l,n-nCount2,buyid}
										self.nActionType =10
										return
									else
										me.DoRecipe(nReceptId)
										self.nActionType =1
										return
									end
								end
							end
							me.DoRecipe(self.g_finditem[nSubTaskId].ReceptId)
							self.nActionType = 1
						else
							local nId = tbSuperBao:GetAroundNpcId(3573)
							if nId then
								if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
									me.AnswerQestion(2)
									me.AnswerQestion(0)
									Ui.tbLogic.tbTimer:Register(18, fnCloseSay(Ui.UI_SAYPANEL));
								else
									AutoAi.SetTargetIndex(nId);
								end
							else
								tbSuperBao:fnfindNpc(3573,"Bao V???n ?????ng");
								self.nActionType =1
							end
						end

					end
				end
			end
			self.nActionType =1
		elseif nTaskType == 20000 then
			local nSubTaskId = LinkTask:GetTask(LinkTask.TSK_TASKID)
			self.nSubTaskId = nSubTaskId 
			local nId = tbSuperBao:GetAroundNpcId(3573) ---
			if nId then
				AutoAi.SetTargetIndex(nId);
				if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
						me.AnswerQestion(2)
						me.AnswerQestion(0)
					Ui.tbLogic.tbTimer:Register(18, fnCloseSay(Ui.UI_SAYPANEL));
					self.nActionType = 3
				else
					self.nActionType = 1
				end
			else
				tbSuperBao:fnfindNpc(3573,"Bao V???n ?????ng");
				self.nActionType =2
			end
		elseif nTaskType == 30000 then
			self:OpenExtBag(); 
			local nSubTaskId = LinkTask:GetTask(LinkTask.TSK_TASKID)
			local szItemName = Task.tbSubDatas[nSubTaskId].tbSteps[1].tbTargets[1].szItemName
			local szSuffix = Task.tbSubDatas[nSubTaskId].tbSteps[1].tbTargets[1].szSuffix
			local nReceptId = self.finditembyname(self,szItemName,szSuffix)
			if nReceptId then
				local tbItem0 = LifeSkill.tbRecipeDatas[nReceptId].tbProductSet[1].tbItem
				local nCount = me.GetItemCountInBags(tbItem0[1],tbItem0[2],tbItem0[3],tbItem0[4])
				if nCount > 0 then
					me.Msg("T??i ????? t??m ???????c "..szItemName.." - "..szSuffix)
					local nId = tbSuperBao:GetAroundNpcId(3573)
					if nId then
						if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
							me.AnswerQestion(1)
							Ui.tbLogic.tbTimer:Register(18, fnCloseSay(Ui.UI_SAYPANEL));							self.nActionType = 1
						elseif  UiManager:WindowVisible(Ui.UI_ITEMGIFT) == 1  then
							tbSuperBao:MyFindItem(tbItem0[1],tbItem0[2],tbItem0[3],tbItem0[4],1,1)
							local uiGift = Ui(Ui.UI_ITEMGIFT)
							uiGift.OnButtonClick(uiGift,"BtnOk")
						else
							AutoAi.SetTargetIndex(nId);
						end
					else
						tbSuperBao:fnfindNpc(3573,"Bao V???n ?????ng");
						self.nActionType =1
					end
				else
					local tbStuffSet1 = LifeSkill.tbRecipeDatas[nReceptId].tbStuffSet[1]
					local tbItem1 = tbStuffSet1.tbItem
					local nCount = me.GetItemCountInBags(tbItem1[1],tbItem1[2],tbItem1[3],tbItem1[4])
					if nCount<tbStuffSet1.nCount then
						local Ans1 = tbSuperBao:Made(tbItem1[1],tbItem1[2],tbItem1[3],tbItem1[4])
						if Ans1 == 0 then
							local nId = tbSuperBao:GetAroundNpcId(3573)
							if nId then
								if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
									me.AnswerQestion(2)
									me.AnswerQestion(0)
									local function fnCloseSay2(szWnd)
										UiManager:CloseWindow(szWnd);
										return 10
									end
									Ui.tbLogic.tbTimer:Register(18, fnCloseSay2(Ui.UI_SAYPANEL));
								else
									AutoAi.SetTargetIndex(nId);
								end
							else
								tbSuperBao:fnfindNpc(3573,"Bao V???n ?????ng");
								self.nActionType =1
								return
							end
						else
							return
						end
					end
					local tbStuffSet2 = LifeSkill.tbRecipeDatas[nReceptId].tbStuffSet[2]
					if tbStuffSet2.nCount>0 then
						local tbItem2 = tbStuffSet2.tbItem
						local nCount2 = me.GetItemCountInBags(tbItem2[1],tbItem2[2],tbItem2[3],tbItem2[4])
						if nCount2<tbStuffSet2.nCount then
							local Ans2 = tbSuperBao:Made(tbItem2[1],tbItem2[2],tbItem2[3],tbItem2[4])
							if Ans2 == 0 then
								local nId = tbSuperBao:GetAroundNpcId(3573)
								if nId then
									if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
										me.AnswerQestion(2)
										me.AnswerQestion(0)
										local function fnCloseSay2(szWnd)
											UiManager:CloseWindow(szWnd);
											return 0
										end
										Ui.tbLogic.tbTimer:Register(18, fnCloseSay2(Ui.UI_SAYPANEL));
									else
										AutoAi.SetTargetIndex(nId);
									end
								else
									tbSuperBao:fnfindNpc(3573,"Bao V???n ?????ng");
									self.nActionType =1
									return
								end
							else
								return
							end
						end
					end
					me.DoRecipe(nReceptId)
					self.nActionType = 1
				end
			else
				local nId = tbSuperBao:GetAroundNpcId(3573)
				if nId then
					if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
						me.AnswerQestion(2)
						me.AnswerQestion(0)
						local function fnCloseSay2(szWnd)
							UiManager:CloseWindow(szWnd);
							return 0
						end
						Ui.tbLogic.tbTimer:Register(18, fnCloseSay2(Ui.UI_SAYPANEL));
					else
						AutoAi.SetTargetIndex(nId);
					end
				else
					tbSuperBao:fnfindNpc(3573,"Bao V???n ?????ng");
					self.nActionType =1
				end
			end
		end
	else
		if  nTaskType == 20000 and LinkTask:CheckTaskFinish() ~= 1 then
			if((nMyMapId > 45 and nMyMapId < 76) or (nMyMapId > 85 and nMyMapId < 122)) then
				local nSubTaskId = LinkTask:GetTask(LinkTask.TSK_TASKID)
				self.nSubTaskId = nSubTaskId
				local nMapId = Task.tbSubDatas[self.nSubTaskId].tbSteps[1].tbTargets[1].nMapId;
				local nMyMapId	= me.GetMapTemplateId();
				if self.nSubTaskId and self.nSubTaskId>0 and Task.tbSubDatas[self.nSubTaskId] then
					local nFreeBagBao = me.CalcFreeItemCountInBags(19,3,1,5,0,0)
					if  nFreeBagBao > 6 then
						if tonumber(nMapId) == tonumber(nMyMapId) then
							self.nActionType = 3
						elseif tonumber(nMapId) ~= tonumber(nMyMapId) then
							if PhuItemF then
								if (nCloseActionType == 0) then
									nCloseActionType = Ui.tbLogic.tbTimer:Register(2 * Env.GAME_FPS, tbSuperBao.GoTest);
								end
							elseif not PhuItemF then
								tbSuperBao:GoBao()
							end
						end
					else
						UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>X??? l?? kho???ng tr???ng h??nh trang")
						if PhuItemF then
							if (nCloseActionType == 0) then
								nCloseActionType = Ui.tbLogic.tbTimer:Register(2 * Env.GAME_FPS, tbSuperBao.GoTest);
							end
						elseif not PhuItemF then
							tbSuperBao:GoBao()
						end
					end
				end	
			else
				if PhuItemF then
					if (nCloseActionType == 0) then
						nCloseActionType = Ui.tbLogic.tbTimer:Register(2 * Env.GAME_FPS, tbSuperBao.GoTest);
					end
				elseif not PhuItemF then
					tbSuperBao:GoBao()
				end
			end
		else
			if PhuItemF then
				if (nCloseActionType == 0) then
					nCloseActionType = Ui.tbLogic.tbTimer:Register(2 * Env.GAME_FPS, tbSuperBao.GoTest);
				end 
			elseif not PhuItemF then
				tbSuperBao:GoBao()
			end
		end	
	end
end

function tbSuperBao:GoTest()
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	tbSuperBao:fnfindNpc(3573,"Bao V???n ?????ng");
	local nM = me.GetMapTemplateId();
	if (nM  <30 and nM  >22) or (nM  <9 and nM  >0)  then
		local function fnBaox()
				UiManager:StartBao();
				return 0
		end
		Ui.tbLogic.tbTimer:Register(100, fnBaox);
		UiManager:StopBao();
		if (nCloseActionType > 0) then
		Ui.tbLogic.tbTimer:Close(nCloseActionType);
		end
		nlogB=1	;
		if (nve > 0) then
			Ui.tbLogic.tbTimer:Close(nve);
		end
		nCloseActionType=0;
		nve =0;
	end
end

function tbSuperBao:GoBao()
	tbSuperBao:MapIdc2()
	if (nCloseActionType == 0) then
		nCloseActionType = Ui.tbLogic.tbTimer:Register(5 * Env.GAME_FPS, tbSuperBao.CheckMapc2);
	end 
	if bgua==0 then
		tbSuperBao:TeamLeave()
	end		
end

function tbSuperBao:CheckMapc2()
	tbSuperBao:MapIdc2()
	local nM = me.GetMapTemplateId();
	if nCityIdc==8 and nM==128 then 
		me.StartAutoPath(1931,3133)
		return
	elseif nCityIdc==7 and nM==120 then
		me.StartAutoPath(1800,3262)
		return
	elseif nCityIdc==1 and nM==130 then
		me.StartAutoPath(1780,3729)
		return	
	else	
		Ui.tbLogic.tbAutoPath:GotoPos({nMapId=nCityIdc,nX=0,nY=0}) 
	end
	if (nM  <30 and nM  >22) or (nM  <9 and nM  >0)  then
		local function fnBao()
			UiManager:StartBao();
			return 0
		end
		if (nTimerId  ~= 0) then
			Ui.tbLogic.tbTimer:Close(nTimerId);
		end
		nTimerId = 0;
			UiManager:CloseWindow(Ui.UI_SAYPANEL); 
			if (nCloseActionType > 0) then
			Ui.tbLogic.tbTimer:Close(nCloseActionType);
			nCloseActionType = 0;
			end
		nlogB=1	;
		Ui.tbLogic.tbTimer:Register(50, fnBao);
	end 
end
--130  128 133
function tbSuperBao:MapIdc2()
	local M = me.GetMapTemplateId();
	if M==45 or M==37 or M==121  or M==129 or M==134 or M==137 or M==128 then
		nCityIdc = 8; 
	return 0
	elseif M==88 or M==111 or M==14 or M==59 or M==69 then
		nCityIdc = 25; 
	return 0
	elseif M==126 or M==118 or M==34 or M==42 or M==16 or M==51 or M==61 or M==71 or M==5  or M==18  or M==53 or M==63 or M==73 then
		nCityIdc = 5; 
	return 0
	elseif M==104 or M==97 or M==90  then
		nCityIdc = 27; 
	return 0
	elseif M==33 or M==41 or M==15 or M==50 or M==60 or M==70 or M==117 or M==110 or M==133 then
		nCityIdc = 4; 
	return 0 
	elseif M==89 or M==103 then
		nCityIdc = 26; 
	return 0
	elseif M==96  or M==92 or M==99 or M==109 or M==106 then
		nCityIdc = 29; 
	return 0
	elseif M==36  or M==44 or M==21 or M==120 or M==136  or M==20 or M==54 or M==64 or M==74 or M==113 then
		nCityIdc = 7;
	return 0
	elseif M==91 or M==112 or M==98 or M==105 or M==19 or M==52 or M==62 or M==72 then
		nCityIdc = 28; 
	return 0
	elseif M==43 or M==17 or M==35 or M==135 or M==127 or M==119 then
		nCityIdc = 6; 
	return 0
	elseif M==10 or M==47 or M==57 or M==67 or M==86 or M==100 or M==107 or M==9 or M==46 or M==56 or M==66  or M==95 or M==102 or M==125 or M==93 then
		nCityIdc = 23; 
	return 0
	elseif M==30 or M==114 or M==11 or M==38 or M==122 or M==130 then
		nCityIdc = 1; 
	return 0
	elseif M==124 or M==96 or M==40 or M==32 or M==132 or M==116 then
		nCityIdc = 3; 
	return 0
	elseif M==87 or M==94 or M==101 or M==108 then 
		nCityIdc = 24; 
	return 0
	elseif M==115 or M==123 or M==131 or M==39 or M==31 or M==48 or M==58 or M==68  or M==12 then
		nCityIdc = 2;
	return 0
	end
end
function tbSuperBao:CheckMap2()
	local nM = me.GetMapTemplateId();
	if nCityIdc==8 and nM==128 then 
		me.StartAutoPath(1931,3133)
		return
	elseif nCityIdc==7 and nM==120 then
		me.StartAutoPath(1800,3262)
		return
	elseif nCityIdc==1 and nM==130 then
		me.StartAutoPath(1780,3729)
		return	
	else	
		Ui.tbLogic.tbAutoPath:GotoPos({nMapId=nCityIdc,nX=0,nY=0}) 
	end
	if (nM  <30 and nM  >22) or (nM  <9 and nM  >0)  then
		local function fnBao()
			UiManager:StartBao();
			return 0
		end
		if (nTimerId  ~= 0) then
			Ui.tbLogic.tbTimer:Close(nTimerId);
		end
		nTimerId = 0;
		nlogB=1	;
		Ui.tbLogic.tbTimer:Register(50, fnBao);
		if (nCloseActionType > 0) then
			Ui.tbLogic.tbTimer:Close(nCloseActionType);
			nCloseActionType = 0;
		end
	end 
end

function tbSuperBao:CheckMap3()
	tbSuperBao:MapIdc2()
	local nM = me.GetMapTemplateId();
	local nM, nCX, nCY = me.GetWorldPos();
	if nCityIdc==8 and nM==128 then 
		me.StartAutoPath(1931,3133)
		return
	elseif nCityIdc==7 and nM==120 then
		me.StartAutoPath(1800,3262)
		return
	elseif nCityIdc==1 and nM==130 then
		me.StartAutoPath(1780,3729)
		return	
	else	
		Ui.tbLogic.tbAutoPath:GotoPos({nMapId=nCityIdc,nX=0,nY=0}) 
	end
	if (nM  <30 and nM  >22) or (nM  <9 and nM  >0)  then
		if (nCloseActionType > 0) then
			Ui.tbLogic.tbTimer:Close(nCloseActionType);
			nCloseActionType = 0;
		end
	end 
end

tbSuperBao.Made = function(self,G,D,P,L)
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	if UiManager:WindowVisible(Ui.UI_TEXTINPUT) == 1 then
		return
	end
	local nRecipeId11 = tbSuperBao:finditembyGDPL(G,D,P,L)
	if nRecipeId11 then
		local tbStuffSet1 = LifeSkill.tbRecipeDatas[nRecipeId11].tbStuffSet[1]
		local tbItem1 = tbStuffSet1.tbItem
		local nCount = me.GetItemCountInBags(tbItem1[1],tbItem1[2],tbItem1[3],tbItem1[4])
		if nCount < tbStuffSet1.nCount then
			local buyid = 680 + 35 + (tbItem1[3] - 1) * 5 + tbItem1[4]
			self.material={tbItem1[1],tbItem1[2],tbItem1[3],tbItem1[4],tbStuffSet1.nCount-nCount,buyid}
			self.nActionType =11
			return 10
		else
			me.DoRecipe(nRecipeId11)
			return 10
		end
	else
		return 0
	end
end

tbSuperBao.SelectAward = function(self)
	local j = 1;
	local aw = 0;
	local nFirst  = 0;
	local nSecond = 0;
	local nThird  = 0;
	local SelAward = 1;
	local nFirstName = tbAwardCode[self.nAwardFirst];
	local nSecondName = tbAwardCode[self.nAwardSecond];
	local nThirdName = tbAwardCode[self.nAwardThird];
	if UiManager:WindowVisible(Ui.UI_GUTAWARD) == 1 then
		local uiGutAward = Ui(Ui.UI_GUTAWARD);
		local nCanCancel = LinkTask:GetTask(3);  
		if nCanCancel < nSetCancel then
			if nFirstName == "linktask_cancel" then  
			elseif nSecondName == "linktask_cancel" then 
				nSecondName = nFirstName;
			else  
				nThirdName = nSecondName;
				nSecondName = nFirstName;
			end
			nFirstName = "linktask_cancel";
		end
		for i = 1, 3 do
			me.Msg("<color=0,255,255>Ph???n th?????ng th???: <color><color=gold>"..i.."<color> <color=0,255,255>l?? <color>"..uiGutAward.tbAwards.tbOpt[i].szType)
			if uiGutAward.tbAwards.tbOpt[i].szType == ITEM then
				me.Msg("<color=0,255,255>Huy???n tinh c???p: <color> <color=gold>"..tonumber(uiGutAward.tbAwards.tbOpt[i].varValue[4]).."<color>")
			else
				me.Msg(" <color=0,255,255>C?? gi?? tr??? l??: <color><color=gold> "..tonumber(uiGutAward.tbAwards.tbOpt[i].varValue).."<color>")
			end
			if uiGutAward.tbAwards.tbOpt[i].szType == nFirstName then
				nFirst = i;
				if nFirstName == ITEM and uiGutAward.tbAwards.tbOpt[i].varValue[4] <= nXuanMix then
					nFirst = 0;
				end
				if nFirstName == EXP and uiGutAward.tbAwards.tbOpt[i].varValue < nExp then
					nFirst = 0;
				end
				if nFirstName == BINDMONEY and uiGutAward.tbAwards.tbOpt[i].varValue < nBind then
					nFirst = 0;
				end
			elseif uiGutAward.tbAwards.tbOpt[i].szType == nSecondName then
				nSecond = i;
				if nSecondName  == ITEM and uiGutAward.tbAwards.tbOpt[i].varValue[4] <= nXuanMix then
					nSecond = 0;
				end
				if nSecondName  == EXP and uiGutAward.tbAwards.tbOpt[i].varValue < nExp then
					nSecond = 0;
				end
				if nSecondName  == BINDMONEY and uiGutAward.tbAwards.tbOpt[i].varValue < nBind then
					nSecond = 0;
				end
			elseif uiGutAward.tbAwards.tbOpt[i].szType == nThirdName then
				nThird = i;
				if nThirdName  == ITEM and uiGutAward.tbAwards.tbOpt[i].varValue[4] <= nXuanMix then
					nThird = 0;
				end
				if nThirdName  == EXP and uiGutAward.tbAwards.tbOpt[i].varValue < nExp then
					nThird = 0;
				end
				if nThirdName  == BINDMONEY and uiGutAward.tbAwards.tbOpt[i].varValue < nBind then
					nThird = 0;
				end
			end	
		end
		if (nFirst > 0 ) then
			aw = nFirst;
		elseif (nSecond > 0) then
			aw = nSecond;
		elseif (nThird > 0) then
			aw = nThird;
		end
			for i = 1, 3 do
				if nCanCancel < nSetCancel and (uiGutAward.tbAwards.tbOpt[i].varValue == 10)then 
				UiManager:OpenWindow("UI_INFOBOARD"," <bclr=pink><color=white>C?? h??i h???y b??? ch??a ????? ["..nSetCancel.."]<color><bclr=red><color=yellow> [Nh???n C?? H???i H???y B???]<color>")
				end
			end	
		if (aw > 0) then
			j = aw;
		end
	end
	
	return j;
end

tbSuperBao.OnTimer = function(self)
	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return
	end
	local bChecked = me.GetNpc().IsRideHorse();
	if me.nAutoFightState == 1 and nHorse == 0 then
		tbSuperBao:setLeftSkillhh()
	end
	if UiManager:WindowVisible(Ui.UI_TEXTINPUT) == 1 then
		return
	end
	if (me.IsDead() == 1) then
		me.SendClientCmdRevive(0);
		if me.nAutoFightState == 1 then
			AutoAi.ProcessHandCommand("auto_fight", 0);
		end
		self.nActionType = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>B???n ???? hy sinh")
	end
	local tbMyPos	= {};
	tbMyPos.nMapId, tbMyPos.nPosX, tbMyPos.nPosY	= me.GetWorldPos();
	if (tbMyPos.nMapId <= 0 or tbMyPos.nPosX <= 0) then
		return;	
	end	
	Ui.tbLogic.tbMsgInfo:Clear();
	local nX1
	local nY1
	local PhuItem = me.FindItemInBags(18,1,309,1)[1] or me.FindItemInBags(18,1,310,1)[1] or me.FindItemInBags(18,1,13,1)[1] or me.FindItemInBags(18,1,235,1)[1] or me.FindItemInBags(18,1,12,1)[1] or me.FindItemInBags(18,1,195,1)[1] or me.FindItemInBags(18,1,316,1)[1] or me.FindItemInBags(18,1,315,1)[1] or me.FindItemInBags(18,1,18,1)[1] or me.FindItemInBags(18,1,234,1)[1] or me.FindItemInBags(18,1,23,1)[1];
	local PhuItemF = me.FindItemInBags(18,1,309,1)[1] or me.FindItemInBags(18,1,310,1)[1] or me.FindItemInBags(18,1,13,1)[1] or me.FindItemInBags(18,1,235,1)[1] or me.FindItemInBags(18,1,12,1)[1] or me.FindItemInBags(18,1,195,1)[1] or me.FindItemInBags(18,1,316,1)[1] or me.FindItemInBags(18,1,315,1)[1] or me.FindItemInBags(18,1,18,1)[1] or me.FindItemInBags(18,1,234,1)[1] or me.FindItemInBags(18,1,23,1)[1] or me.FindItemInBags(18,1,7,1)[1];
	local PhuItem2 = me.FindItemInBags(18,1,7,1)[1];
	local bChecked = me.GetNpc().IsRideHorse();
	local nSubTaskId = LinkTask:GetTask(LinkTask.TSK_TASKID)
	self.nSubTaskId = nSubTaskId
	if self.nActionType then
		if self.nActionType == 0 then
			return 0
		end
		if self.nActionType == 1 then
			if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
				UiManager:CloseWindow(Ui.UI_SHOP);
			end
			tbSuperBao:fnAutoBaobao()
		elseif self.nActionType == 2 then
			tbSuperBao.CloseHP()
			local nId = tbSuperBao:GetAroundNpcId(3573)
			if nId then
				tbSuperBao:fnAutoBaobao()
			else
				tbSuperBao:fnfindNpc(3573,"Bao V???n ?????ng");
			end	
		elseif self.nActionType ==3 then
			if bChecked	~= 1 then
				Switch([[horse]])
			end
			if self.nSubTaskId and self.nSubTaskId>0 and Task.tbSubDatas[self.nSubTaskId] then
				local nMapId = Task.tbSubDatas[self.nSubTaskId].tbSteps[1].tbTargets[1].nMapId;
				local nMyMapId	= me.GetMapTemplateId();
				if tonumber(nMapId) == tonumber(nMyMapId) then
				if self.g_killnpcs[nSubTaskId] then
					if nXY==0 then
						nX1 = self.g_killnpcs[nSubTaskId].x
						nY1 = self.g_killnpcs[nSubTaskId].y
					elseif nXY==1 then
						nX1 = self.g_killnpcs[nSubTaskId].x1
						nY1 = self.g_killnpcs[nSubTaskId].y1
					end
					if	nMyMapId == 92 and nX1== 1708 and nY1 == 3428 then
						me.StartAutoPath(1768, 3427)
						self.nActionType = 4
						return 500
					end	
						me.StartAutoPath(nX1, nY1)
						self.nActionType = 4
					else
						self.nActionType = 0
					end
				end
			end
		elseif self.nActionType == 4 then
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
			end
			if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then
				UiManager:CloseWindow(Ui.UI_ITEMBOX);
			end
			local nSubTaskId	= LinkTask:GetTask(LinkTask.TSK_TASKID)
			if nXY==0 then
				nX1 = self.g_killnpcs[nSubTaskId].x
				nY1 = self.g_killnpcs[nSubTaskId].y
			elseif nXY==1 then
				nX1 = self.g_killnpcs[nSubTaskId].x1
				nY1 = self.g_killnpcs[nSubTaskId].y1
			end
			local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
			if math.abs(nX1-nCurWorldPosX) < 5 and  math.abs(nY1-nCurWorldPosY) < 5 then
				local function fnTeamApply()
					self:TeamApply();
					return 0
				end
				local function fnCreateTeam()
					self:CreateTeam();
					return 0
				end
				Ui.tbLogic.tbTimer:Register(150, fnCreateTeam);
				Ui.tbLogic.tbTimer:Register(20, fnTeamApply); 
				self:TeamLeave(); 
				if me.nAutoFightState ~= 1 then
					AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey())	
				end	
				self.nActionType = 5
			else
				me.StartAutoPath(nX1,nY1)
			end
		elseif self.nActionType == 5 then
			local FlagFire = 0
			local nSkillLevel = me.GetSkillState(377); 
				if nSkillLevel then
					if nSkillLevel > 0 then
						FlagFire = Fire
					end
				end	
			if FlagFire == 0 then	
			 	if LinkTask:CheckTaskFinish() == 1 then
					nCountPT = 0;
					tbSuperBao:AutoPhu();
					AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey())
					local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
					if nXY==0 then
						nX1 = self.g_killnpcs[nSubTaskId].x
						nY1 = self.g_killnpcs[nSubTaskId].y
					elseif nXY==1 then
						nX1 = self.g_killnpcs[nSubTaskId].x1
						nY1 = self.g_killnpcs[nSubTaskId].y1
					end
					AutoAi.SetTargetIndex(0);
					me.StartAutoPath(nX1,nY1)
					self.nActionType = 6    
				end	
			else
				if nCountPT == 500 then
					nCountPT = 0;
					Ui.tbLogic.tbTimer:Register(3,self:CreateTeam());
				else
					Ui.tbLogic.tbTimer:Register(3,self:TeamApply());
					nCountPT = nCountPT + 1;
				end
			end
		elseif  self.nActionType == 6 then
			local nMapId, nCurWorldPosX1, nCurWorldPosY1 = me.GetWorldPos();
					if nXY==0 then
						nX1 = self.g_killnpcs[nSubTaskId].x
						nY1 = self.g_killnpcs[nSubTaskId].y
					elseif nXY==1 then
						nX1 = self.g_killnpcs[nSubTaskId].x1
						nY1 = self.g_killnpcs[nSubTaskId].y1
					end
			if ((nX1-nCurWorldPosX1)^2 + (nY1-nCurWorldPosY1)^2)>800 then
				local function fngobao()
					tbSuperBao:fnfindNpc(3573,"Bao V???n ?????ng");
					return 0
				end
				if PhuItemF then
					local nMapId, nCurWorldPosX1, nCurWorldPosY1 = me.GetWorldPos();
					Ui.tbLogic.tbAutoPath:GotoPos({nMapId=nMapId,nX=nCurWorldPosX1,nY=nCurWorldPosY1}) 
					self:TeamLeave();
					Ui.tbLogic.tbTimer:Register(18, fngobao);
				end	
				self.nActionType = 7
				return (2 * Env.GAME_FPS)
			else
			print(" X:"..self.g_killnpcs[self.nSubTaskId].dx.."  Y:"..self.g_killnpcs[self.nSubTaskId].dy)
				if PhuItemF then
						me.StartAutoPath(self.g_killnpcs[self.nSubTaskId].dx,self.g_killnpcs[self.nSubTaskId].dy)
				elseif not PhuItemF then
						tbSuperBao:MapIdc2()
						if (nCloseActionType == 0) then
							nCloseActionType = Ui.tbLogic.tbTimer:Register(5 * Env.GAME_FPS, tbSuperBao.CheckMap2);
						end
				end	
			end
		elseif  self.nActionType == 7 then
			local nMyMapId	= me.GetMapTemplateId();
			if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
				self:TeamLeave(); 
				self.nActionType = 1
				return (1 * Env.GAME_FPS)
			else
				if self.nSubTaskId and self.g_killnpcs[self.nSubTaskId] then
					print("X:"..self.g_killnpcs[self.nSubTaskId].dx.."  Y:"..self.g_killnpcs[self.nSubTaskId].dy)
					
					if PhuItemF then
						me.StartAutoPath(self.g_killnpcs[self.nSubTaskId].dx,self.g_killnpcs[self.nSubTaskId].dy)
					elseif not PhuItemF then
						tbSuperBao:MapIdc2()
						if (nCloseActionType == 0) then
							nCloseActionType = Ui.tbLogic.tbTimer:Register(5 * Env.GAME_FPS, tbSuperBao.CheckMap2);
						end
					end	
				end
				self.nActionType = 6
				return (5 * Env.GAME_FPS)
			end
		elseif  self.nActionType == 10 then
			if self.material then
				local g,d,p,l,n,buyid=unpack(self.material)
				local nId = tbSuperBao:GetAroundNpcId(3565)
				if nId then
					if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
					--me.AnswerQestion(1) ---- fix event thang 11
						if p==4 then
							me.AnswerQestion(2)
						else
							me.AnswerQestion(6)
						end
						local function fnCloseSay3()
							UiManager:CloseWindow(Ui.UI_SAYPANEL);
							return 0
						end
						local function fnbuy(id,num1)
							local pItem = KItem.GetItemObj(id);
							local bOK, szMsg = me.ShopBuyItem(id, num1);
							if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
								UiManager:CloseWindow(Ui.UI_SHOP);
							end
							self.nActionType = 1
							return 0
						end
						Ui.tbLogic.tbTimer:Register(15, fnCloseSay3);
						Ui.tbLogic.tbTimer:Register(40, fnbuy, buyid, n);
					elseif  UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
					else
						AutoAi.SetTargetIndex(nId);
					end
				else
					tbSuperBao:fnfindNpc(3565,"B???t ?????ng ti??n sinh ");
				end
			end
		elseif  self.nActionType == 11 then
			if self.material then
				local g,d,p,l,n,buyid=unpack(self.material)
				local nId = tbSuperBao:GetAroundNpcId(3565)
				if nId then
					if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
						--me.AnswerQestion(1) ---- fix event thang 11
						if p>=1 and p<=4 then
							me.AnswerQestion(2)
						elseif p>=5 and p<=8 then
							me.AnswerQestion(3)
						elseif p>=13 and p<=16 then
							me.AnswerQestion(5)
						else
							me.AnswerQestion(6)
						end
						local function fnCloseSay3()
							UiManager:CloseWindow(Ui.UI_SAYPANEL);
							return 0
						end
						local function fnbuy(id,num1)
							local pItem = KItem.GetItemObj(id);
							local bOK, szMsg = me.ShopBuyItem(id, num1);
							if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
								UiManager:CloseWindow(Ui.UI_SHOP);
							end
							self.nActionType = 1
							return 0
						end
						Ui.tbLogic.tbTimer:Register(15, fnCloseSay3);
						Ui.tbLogic.tbTimer:Register(40, fnbuy, buyid, n);
					elseif  UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
					else
						AutoAi.SetTargetIndex(nId);
					end
				else
					tbSuperBao:fnfindNpc(3565,"B???t ?????ng ti??n sinh ");
				end
			end
		elseif  self.nActionType == 12  then
				tbSuperBao:CFreeBag()
				local nCountFood = me.GetItemCountInBags(19,3,1,nLvBuyItem); 
				tbSuperBao:CNeedRepair();
				if ((nCBuyFood > 0 and nCountFood < 1) or bCNeedRepair == 1) and nCount_FreeBag == 1 then
				tbSuperBao:CBuyFood();
				else 
				tbSuperBao:CloseShop()
				self.nActionType =1
				end	
		elseif  self.nActionType == 13 then
				tbSuperBao:CFreeBag()
				local nCountHP = me.GetItemCountInBags(17,1,1,nHPLvId); 
				local nCountMP = me.GetItemCountInBags(17,nMPLvId1,1,nMPLvId); 
				if ((nCBuyHP>0 and nCountHP < 1) or (nCBuyMP > 0 and  nCountMP < 1)) and nCount_FreeBag == 1 then 
					tbSuperBao:CBuyHPMP();
				else 
				tbSuperBao:CloseShop()
				self.nActionType =1
				end 
		elseif self.nActionType == 14 then
				tbSuperBao:CFreeBag()
				local nCount={}
				local bFlag = 0
				for i = 1,LvHT do
						nCount[i] = me.GetItemCountInBags(18,1,1,i)
					if nCount[i] >= GhepHT3 and i<LvHT  then
						bFlag=1
					end
				end
				for i = 1,LvHT do
						nCount[i] = nCount[i]+ me.GetItemCountInBags(18,1,114,i)
					if nCount[i] >3 and i<LvHT then
						bFlag=1
					end
				end
			if 	bFlag==1 then
				tbSuperBao:hexuan2();
			else 
				tbSuperBao:CloseShop()
				self.nActionType=1
			end	
		elseif self.nActionType == 15 then
				tbSuperBao:CFreeBag()
				tbSuperBao:AutoPhu()
			local PhuItem = me.FindItemInBags(18,1,309,1)[1] or me.FindItemInBags(18,1,310,1)[1] or me.FindItemInBags(18,1,13,1)[1] or me.FindItemInBags(18,1,235,1)[1] or me.FindItemInBags(18,1,12,1)[1] or me.FindItemInBags(18,1,195,1)[1] or me.FindItemInBags(18,1,316,1)[1] or me.FindItemInBags(18,1,315,1)[1] or me.FindItemInBags(18,1,18,1)[1] or me.FindItemInBags(18,1,234,1)[1] or me.FindItemInBags(18,1,23,1)[1];
			local PhuItem2 = me.FindItemInBags(18,1,7,1)[1];		
			if PhuItem then	
				nCBuyHTPc = 0;
				UiManager:CloseWindow(Ui.UI_SHOP);
				self.nActionType = 1
			elseif (not PhuItem) and (not PhuItem2) and (nCBuyHTP > 0 or bCNeedRepair == 1) and nCount_FreeBag == 1 then
				nCBuyHTPc = nCBuyHTP;
				UiManager:CloseWindow(Ui.UI_SHOP);
				tbSuperBao:CBuyHTPhu();	
			else
				tbSuperBao:CloseShop()
				self.nActionType = 1
			end 
		end
	else
		--me.Msg("C?? l???i")
	end
end

tbSuperBao.hexuan = function(self)
	Ui(Ui.UI_TASKTIPS):Begin("<bclr=pink><color=white>B???t ?????u Gh??p Huy???n Tinh");
	tbSuperBao:fnfindNpc(3574,"D?? Luy???n ?????i S??");
	self.nTimerRegisterId	= Ui.tbLogic.tbTimer:Register(20, 1, self.OnTimer_he, self);
end
tbSuperBao.hexuan3 = function(self)	
	print("B???t ?????u r???i ")
	local nCount={}
	local bFlag = 0
	local nId = tbSuperBao:GetAroundNpcId(3574)
	tbSuperBao:OpenExtBag()
	if nId then

		AutoAi.SetTargetIndex(nId);
		local function fnhexuan()
			for i = 1,LvHT do
				nCount[i] = me.GetItemCountInBags(18,1,1,i)
				if nCount[i] >= GhepHT3 and i<LvHT  then
					bFlag=1
				end
			end
			for i = 1,LvHT do
				nCount[i] = nCount[i]+ me.GetItemCountInBags(18,1,114,i)
				--me.Msg("<color=green>Huy???n Tinh C???p "..i.." c?? "..nCount[i].." vi??n.")
				if nCount[i] >= GhepHT3 and i<LvHT then
					bFlag=1
				end
			end
			if bFlag == 0 then
				if UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1 then
					UiManager:CloseWindow(Ui.UI_EQUIPENHANCE)
				end
				me.Msg("<color=yellow>Kh??ng ????? Huy???n Tinh ????? gh??p")
				return 0
			end
		--	me.Msg("<color=yellow>B???t ?????u gh??p Huy???n Tinh")
			for i=1,LvHT do
				if nCount[i] > GhepHT then  
					me.Msg("<color=yellow>"..GhepHT.." vi??n c???p "..i.." gh??p th??nh vi??n c???p "..(i+2).."<color=pink>(c?? th??? th???t b???i n???u kh??ng ?????t 100%)")

					tbSuperBao:MyFindItem2(18,1,1,i,1,GhepHT,114)
					me.ApplyEnhance(Item.ENHANCE_MODE_COMPOSE, Item.BIND_MONEY)
					return
				elseif nCount[i] >= GhepHT2 and nCount[i+1]>=2 then    
					me.Msg("<color=yellow>"..GhepHT2.." vi??n c???p "..i..", 2 vi??n c???p "..(i+1).." gh??p th??nh vi??n c???p "..(i+2).."<color=pink>(c?? th??? th???t b???i n???u kh??ng ?????t 100%)")

					tbSuperBao:MyFindItem2(18,1,1,i,1,GhepHT2,114)
					tbSuperBao:MyFindItem2(18,1,1,(i+1),1,2,114)
					me.ApplyEnhance(Item.ENHANCE_MODE_COMPOSE, Item.BIND_MONEY)
					return
				elseif  nCount[i] >=GhepHT3 then  
					me.Msg("<color=yellow>"..GhepHT3.." vi??n c???p "..i.." gh??p th??nh vi??n c???p "..(i+1).."<color=pink>(c?? th??? th???t b???i n???u kh??ng ?????t 100%)")
					tbSuperBao:MyFindItem2(18,1,1,i,1,GhepHT3,114)
					me.ApplyEnhance(Item.ENHANCE_MODE_COMPOSE, Item.BIND_MONEY)
					return
				end
			end
			if UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1 then
				UiManager:CloseWindow(Ui.UI_EQUIPENHANCE);
				UiManager:CloseWindow(Ui.UI_ITEMBOX);
			end
			return 0
		end
		local function CloseWindow2()
 			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
			end
			return 0
		end
		local function fnCloseSay()
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
				me.AnswerQestion(2)
				me.AnswerQestion(0)
				Ui.tbLogic.tbTimer:Register(15, CloseWindow2);
				Ui.tbLogic.tbTimer:Register(40, fnhexuan);
				return 0;
			end
		end
		Ui.tbLogic.tbTimer:Register(18, fnCloseSay);
	end
end

tbSuperBao.hexuan2 = function(self)	
	print("B???t ?????u")
	local nCount={}
	local bFlag = 0
	--local mTimer1
	local nId = tbSuperBao:GetAroundNpcId(3574)
	tbSuperBao:OpenExtBag()
	if nId then
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1 and UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) ~= 1 then
				AutoAi.SetTargetIndex(nId);
				return
		end
		local function fnhexuan()
			for i = 1,LvHT do
				nCount[i] = me.GetItemCountInBags(18,1,1,i)
				if nCount[i] >= GhepHT3 and i<LvHT  then
					bFlag=1
				end
			end
			for i = 1,LvHT do
				nCount[i] = nCount[i]+ me.GetItemCountInBags(18,1,114,i)
				if nCount[i] >= GhepHT3 and i<LvHT then
					bFlag=1
				end
			end
			if bFlag == 0 then
				if UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1 then
					UiManager:CloseWindow(Ui.UI_EQUIPENHANCE)
				end
				me.Msg("<color=yellow>Kh??ng ????? Huy???n Tinh ????? gh??p")
				return 0
			end
			for i=1,LvHT do
				if nCount[i] > GhepHT then 
					tbSuperBao:MyFindItem2(18,1,1,i,1,GhepHT,114)
					me.ApplyEnhance(Item.ENHANCE_MODE_COMPOSE, Item.BIND_MONEY)
					return
				elseif nCount[i] >= GhepHT2 and nCount[i+1]>=2 then  
					tbSuperBao:MyFindItem2(18,1,1,i,1,GhepHT2,114)
					tbSuperBao:MyFindItem2(18,1,1,(i+1),1,2,114)
					me.ApplyEnhance(Item.ENHANCE_MODE_COMPOSE, Item.BIND_MONEY)
					return
				elseif  nCount[i] >=GhepHT3 then  
					tbSuperBao:MyFindItem2(18,1,1,i,1,GhepHT3,114)
					me.ApplyEnhance(Item.ENHANCE_MODE_COMPOSE, Item.BIND_MONEY)
					return
				end
			end
			if UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1 then
				UiManager:CloseWindow(Ui.UI_EQUIPENHANCE);
				UiManager:CloseWindow(Ui.UI_ITEMBOX);
			end   
			return 0
		end
		local function CloseWindow2()
 			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
			end
			return 0
		end
		local function fnCloseSay()
			local nId = tbSuperBao:GetAroundNpcId(3574)
			if nId and UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
				me.AnswerQestion(2)
				if me.GetBindMoney() > nBac then
					me.AnswerQestion(0)
				elseif me.GetBindMoney() <= nBac and nBacE == 1 then
					Exit();
				else
					me.AnswerQestion(1)
				end	
				Ui.tbLogic.tbTimer:Register(15, CloseWindow2);
			elseif nId then	
				Ui.tbLogic.tbTimer:Register(40, fnhexuan);
				if (nCloseUiTimerIdHT == 0) then
					nCloseUiTimerIdHT = Ui.tbLogic.tbTimer:Register(30 * Env.GAME_FPS, tbSuperBao.CloseHT);
				end
				return 0;
			end
		end
		Ui.tbLogic.tbTimer:Register(18, fnCloseSay);
	else	
		tbSuperBao:fnfindNpc(3574,"D?? Luy???n ?????i S??");
	end
end

tbSuperBao.OnTimer_he = function(self)
	self:UpdateHexuan(0);
	local nId = tbSuperBao:GetAroundNpcId(3574)
	if nId then
		Ui.tbLogic.tbTimer:Close(self.nTimerRegisterId);
		tbSuperBao:hexuan3()
		return 0
	else
		return
	end
end

tbSuperBao.MaiCai=function(self)
	tbSuperBao:fnfindNpc(3566,"?????i l??o B???ch");
	self.nTimerRegisterId	= Ui.tbLogic.tbTimer:Register(20, 1, self.OnTimer_Cai, self);
end

tbSuperBao.OnTimer_Cai = function(self)
	local nId = tbSuperBao:GetAroundNpcId(3566)
	if nId then
		Ui.tbLogic.tbTimer:Close(self.nTimerRegisterId);
		tbSuperBao:MaiCai2()
		return 0
	else
		return
	end
end


tbSuperBao.MaiCai2=function(self)
	print("B???t ?????u")
	local nId = tbSuperBao:GetAroundNpcId(3566)
	if nId then
		AutoAi.SetTargetIndex(nId);
		local function fnMaiCai()
		local nCaiLevel,nCaiID
                                if me.nLevel<30 then
		                    nCaiLevel=1
                                    nCaiID = 821
                        end
	                        if (me.nLevel> 29) and (me.nLevel<50) then
		                    nCaiLevel=2
                                    nCaiID = 822
                        end
	                        if (me.nLevel> 49) and (me.nLevel<70) then
		                    nCaiLevel=3
                                    nCaiID = 823
                        end
				if (me.nLevel>69) and (me.nLevel < 90) then
					nCaiLevel =4
					nCaiID = 824
			end
				if me.nLevel >= 90 then
					nCaiLevel = 5
					nCaiID = 825
			end
			local nCount_Cai = me.GetItemCountInBags(19,3,1,nCaiLevel);
				if nCount_Cai < nCBuyFood then
			local pItem = KItem.GetItemObj(825);
			local bOK, szMsg = me.ShopBuyItem(nCaiID, nCBuyFood -nCount_Cai);
			end
			UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIREXALL_SEND);
 			if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
				UiManager:CloseWindow(Ui.UI_SHOP);
			end
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Mua th???c ??n v?? s???a ????? ho??n t???t")
			return 0
		end
		local function CloseWindow2()
 			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
			end
			return 0
		end
		local function fnCloseSay()
			if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
				me.AnswerQestion(1)
				Ui.tbLogic.tbTimer:Register(15, CloseWindow2);
				Ui.tbLogic.tbTimer:Register(40, fnMaiCai);
				return 0;
			end
		end
		Ui.tbLogic.tbTimer:Register(36, fnCloseSay);
	end
end

tbSuperBao.GetAroundNpcId = function(self,nTempId)
	local tbAroundNpc	= KNpc.GetAroundNpcList(me, 20);
	for _, pNpc in ipairs(tbAroundNpc) do
		if (pNpc.nTemplateId == nTempId) then
			return pNpc.nIndex
		end
	end
	return
end
tbSuperBao.fnfindNpc = function(self, nNpcId, szName)
	local nMyMapId	= me.GetMapTemplateId();
	local nTargetMapId;
	if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
		nTargetMapId = nMyMapId;
	elseif nCityId then
		nTargetMapId = nCityId
	else
		nTargetMapId = 5
	end
	if (nMyMapId == 556 or nMyMapId == 558 or nMyMapId == 559) and (nNpcId == 3566 or nNpcId == 3564) then 
		nTargetMapId = nMyMapId;
	end

	local nX1, nY1;
	nX1, nY1 = KNpc.ClientGetNpcPos(nTargetMapId, nNpcId);


	local tbPosInfo ={}
	tbPosInfo.szType = "pos"
	tbPosInfo.szLink = szName..","..nTargetMapId..","..nX1..","..nY1
	if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) or nSetPhu == 0 then	
		Ui.tbLogic.tbAutoPath:GotoPos({nMapId=nTargetMapId,nX=nX1,nY=nY1})
	else
		local tbFind = me.FindItemInBags(unpack({18,1,nSetHTPId,1}));
		for j, tbItem in pairs(tbFind) do
			me.UseItem(tbItem.pItem);
			return;
		end
		self.fnfindNpc(nNpcId, szName);
	end	
end
tbSuperBao.MyFindXiangAndTake = function(self,g,d,p,l,num)
	tbSuperBao:MyFindItemAndGift(g,d,p,l,1)
	local function fngobao1()
		if (UiManager:WindowVisible(Ui.UI_TEXTINPUT) == 1) then
			me.CallServerScript({ "DlgCmd", "InputNum", num });
			UiManager:CloseWindow(Ui.UI_TEXTINPUT);
			return 0;
		end
	end
	Ui.tbLogic.tbTimer:Register(200, fngobao1);
end
 tbSuperBao.MyFindItemAndSplit=function(self,g,d,p,l)
	for j = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nLine - 1 do
		for i = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRow - 1 do
			local pItem = me.GetItem(Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRoom, i, j);
			if pItem then
				if pItem.nGenre == g and pItem.nDetail == d and pItem.nParticular == p and pItem.nLevel == l and pItem.nCount > 1 then
						UiManager:SetUiState(UiManager.UIS_ITEM_SPLIT);
						me.SplitItem(pItem, 2);
						UiManager:ReleaseUiState(UiManager.UIS_ITEM_SPLIT);
					return 1;
				end
			end
		end
	end

	if (UiManager:WindowVisible(Ui.UI_EXTBAG1) == 1) then
		for j = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nLine - 1 do
			for i = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRow - 1 do
				local pItem = me.GetItem(Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRoom, i, j);
				if pItem then
					if pItem.nGenre == g and pItem.nDetail == d and pItem.nParticular == p and pItem.nLevel == l and pItem.nCount > 1 then
						UiManager:SetUiState(UiManager.UIS_ITEM_SPLIT);
						me.SplitItem(pItem, 2);
						UiManager:ReleaseUiState(UiManager.UIS_ITEM_SPLIT);
						return 1;
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
					if pItem.nGenre == g and pItem.nDetail == d and pItem.nParticular == p and pItem.nLevel == l and pItem.nCount > 1 then
						UiManager:SetUiState(UiManager.UIS_ITEM_SPLIT);
						me.SplitItem(pItem, 2);
						UiManager:ReleaseUiState(UiManager.UIS_ITEM_SPLIT);
						return 1;
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
					if pItem.nGenre == g and pItem.nDetail == d and pItem.nParticular == p and pItem.nLevel == l and pItem.nCount > 1 then
						UiManager:SetUiState(UiManager.UIS_ITEM_SPLIT);
						me.SplitItem(pItem, 2);
						UiManager:ReleaseUiState(UiManager.UIS_ITEM_SPLIT);
						return 1;
					end
				end
			end
		end
	end

	return 0;
end

tbSuperBao.MyFindItem2 = function(self,g,d,p,l,bOffer,count,p1)
	local k = 0
	for j = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nLine - 1 do
		for i = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRow - 1 do
			local pItem = me.GetItem(Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRoom, i, j);
			if pItem then
				local tbObj =Ui(Ui.UI_ITEMBOX).tbMainBagCont.tbObjs[j][i];
				if pItem.nGenre == g and pItem.nDetail == d and (pItem.nParticular == p or pItem.nParticular == p1)  and pItem.nLevel == l then
					--me.Msg("j:"..j..",i:"..i.."  "..pItem.nGenre..","..pItem.nDetail..","..pItem.nParticular..","..pItem.nLevel)
					if bOffer == 1 then
						k= k+1
						Ui(Ui.UI_ITEMBOX).tbMainBagCont:UseObj(tbObj,i,j);
						if k >= count then
							return
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
					if pItem.nGenre == g and pItem.nDetail == d and (pItem.nParticular == p or pItem.nParticular == p1)  and pItem.nLevel == l then
						if bOffer == 1  then
							k= k+1
							Ui(Ui.UI_EXTBAG1).tbExtBagCont:UseObj(tbObj,i,j);
						end
						if k >= count then
							return
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
					if pItem.nGenre == g and pItem.nDetail == d and (pItem.nParticular == p or pItem.nParticular == p1)  and pItem.nLevel == l then
						if bOffer == 1 then
							k= k+1
							Ui(Ui.UI_EXTBAG2).tbExtBagCont:UseObj(tbObj,i,j);
						end
						if k >= count then
							return
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
					if pItem.nGenre == g and pItem.nDetail == d and (pItem.nParticular == p or pItem.nParticular == p1)  and pItem.nLevel == l then
						if bOffer == 1 then
							k= k+1
							Ui(Ui.UI_EXTBAG3).tbExtBagCont:UseObj(tbObj,i,j);
						end
						if k >= count then
							return
						end
					end
				end
			end
		end
	end
	return 0;
end
tbSuperBao.MyFindItem = function(self,g,d,p,l,bOffer,nCount0)
	for j = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nLine - 1 do
		for i = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRow - 1 do
			local pItem = me.GetItem(Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRoom, i, j);
			if pItem then
				local tbObj =Ui(Ui.UI_ITEMBOX).tbMainBagCont.tbObjs[j][i];
				if pItem.nGenre == g and pItem.nDetail == d and pItem.nParticular == p and pItem.nLevel == l and pItem.nCount == nCount0 then
					if bOffer == 1 then
						Ui(Ui.UI_ITEMBOX).tbMainBagCont:UseObj(tbObj,i,j);
					end
					return 1;
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
					if pItem.nGenre == g and pItem.nDetail == d and pItem.nParticular == p and pItem.nLevel == l and pItem.nCount == nCount0  then
						if bOffer == 1  then
							Ui(Ui.UI_EXTBAG1).tbExtBagCont:UseObj(tbObj,i,j);
						end
						return 1;
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
					if pItem.nGenre == g and pItem.nDetail == d and pItem.nParticular == p and pItem.nLevel == l and pItem.nCount == nCount0  then
						if bOffer == 1 then
							Ui(Ui.UI_EXTBAG2).tbExtBagCont:UseObj(tbObj,i,j);
						end
						return 1;
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
					if pItem.nGenre == g and pItem.nDetail == d and pItem.nParticular == p and pItem.nLevel == l and pItem.nCount == nCount0 then
						if bOffer == 1 then
							Ui(Ui.UI_EXTBAG3).tbExtBagCont:UseObj(tbObj,i,j);
						end
						return 1;
					end
				end
			end
		end
	end
	return 0;
end

 tbSuperBao.MyFindItemAndGift=function(self,g,d,p,l)
	for j = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nLine - 1 do
		for i = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRow - 1 do
			local pItem = me.GetItem(Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRoom, i, j);
			if pItem then
				if pItem.nGenre == g and pItem.nDetail == d and pItem.nParticular == p and pItem.nLevel == l and pItem.nCount == 1 then
					me.UseItem(pItem);
				end
			end
		end
	end
	if (UiManager:WindowVisible(Ui.UI_EXTBAG1) == 1) then
		for j = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nLine - 1 do
			for i = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRow - 1 do
				local pItem = me.GetItem(Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRoom, i, j);
				if pItem then
					if pItem.nGenre == g and pItem.nDetail == d and pItem.nParticular == p and pItem.nLevel == l and pItem.nCount == 1 then
						me.UseItem(pItem);
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
					if pItem.nGenre == g and pItem.nDetail == d and pItem.nParticular == p and pItem.nLevel == l and pItem.nCount == 1 then
						me.UseItem(pItem);
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
					if pItem.nGenre == g and pItem.nDetail == d and pItem.nParticular == p and pItem.nLevel == l  and pItem.nCount == 1 then
						me.UseItem(pItem);
					end
				end
			end
		end
	end
	return 0;
end




tbSuperBao.ClearBag = function(Self)
	if UiManager:WindowVisible(Ui.UI_ITEMBOX) ~= 1 then
		UiManager:SwitchWindow(Ui.UI_ITEMBOX)
	end
	if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then
		for i = 66,68 do
			for j = 1,4 do
				tbSuperBao:MyFindItemAndGift(18,1,i,j)
			end
		end
	else
		--me.Msg("kh??ng c???a s??? ")
	end
end

tbSuperBao.readkillnpc = function(self)
	self.g_killnpcs = {}
		self.g_killnpcs[20001]={Name=" ph???m gi???i t??ng nh??n ",mapid=46,mapname=" ph??a sau n??i c???m ?????a ",x=1981,y=3373,npcid=2054, dx=2006, dy=3306} 	
		self.g_killnpcs[20002]={Name=" Ph???m gi???i ?????u ???? ",mapid=46,mapname=" H???u s??n c???m ?????a ",x=1703,y=3686,npcid=2055, dx=2006, dy=3306} 
		self.g_killnpcs[20003]={Name=" Lam di???n nh??n ",mapid=49,mapname=" Thi??n tr??? phong ",x=1883,y=3511,npcid=2036, dx=1698, dy=3778} 
		self.g_killnpcs[20004]={Name=" H???ng c??n nh??n ",mapid=49,mapname=" Thi??n tr??? phong ",x=1844,y=3762,npcid=2035, dx=1698, dy=3778} 
		self.g_killnpcs[20005]={Name=" Kim qu???c t??? t??c ",mapid=49,mapname=" Thi??n tr??? phong ",x=1673,y=3912,npcid=2207, dx=1698, dy=3778} 
		self.g_killnpcs[20006]={Name=" B??i s?? ????? t??? ",mapid=49,mapname=" Thi??n tr??? phong ",x=1805,y=3388,npcid=2208, dx=1698, dy=3778} 
		self.g_killnpcs[20007]={Name=" Qu???i t??? ",mapid=52,mapname=" B??ch hoa c???c ",x=1824,y=3649,npcid=2209, dx=1855, dy=3688} 
		self.g_killnpcs[20008]={Name=" M??ng C??? ?????i phu ",mapid=52,mapname=" B??ch hoa c???c ",x=1810,y=3833,npcid=2210, dx=1849, dy=3832} 
		self.g_killnpcs[20009]={Name=" Giang h??? ??ao kh??ch ",mapid=52,mapname=" B??ch hoa c???c ",x=1673,y=3576,npcid=2037, dx=1713, dy=3575} 
		self.g_killnpcs[20010]={Name=" Giang h??? ki???m kh??ch ",mapid=52,mapname=" B??ch hoa c???c ",x=1768,y=3434,npcid=2038, dx=1738, dy=3455} 
		self.g_killnpcs[20011]={Name=" H???c long ",mapid=53,mapname=" Ph??? th??y h??? ",x=1797,y=3228,npcid=2039, dx=1769, dy=3245} 
		self.g_killnpcs[20012]={Name=" ?????c x?? ",mapid=53,mapname=" Ph??? th??y h??? ",x=1762,y=3450,npcid=2040, dx=1783, dy=3484} 
		self.g_killnpcs[20013]={Name=" ?????ng l???c s?? ",mapid=53,mapname=" Ph??? th??y h??? ",x=1711,y=3625,npcid=2211, dx=1742, dy=3646} 
		self.g_killnpcs[20014]={Name=" B???ch linh ",mapid=53,mapname=" Ph??? th??y h??? ",x=1683,y=3543,npcid=2212, dx=1709, dy=3570} 
		self.g_killnpcs[20015]={Name=" t??? h??e l??m c?????ng t???c ",mapid=51,mapname=" C???u l??o phong ",x=1780,y=3293,npcid=2213, dx=1776, dy=3337} 
		self.g_killnpcs[20016]={Name=" kh??? tu ni ",mapid=51,mapname=" C???u l??o phong ",x=1595,y=3555,npcid=2042, dx=1620, dy=3591} 
		self.g_killnpcs[20017]={Name=" ??c vi??n ",mapid=51,mapname=" C???u l??o phong ",x=1522,y=3448,npcid=2041, dx=1486, dy=3432} 
		self.g_killnpcs[20018]={Name=" kim qu???c h??nh th????ng ",mapid=51,mapname=" C???u l??o phong ",x=1451,y=3232,npcid=2214, dx=1438, dy=3288} 
		self.g_killnpcs[20019]={Name=" c?????ng ?????o ",mapid=50,mapname=" C?? t?? th???y t??? ",x=1850,y=3210,npcid=2215, dx=1755, dy=3294} 
		self.g_killnpcs[20020]={Name=" S??n l??m ???n s?? ",mapid=50,mapname=" C?? t?? th???y t??? ",x=1843,y=3475,npcid=2216, dx=1755, dy=3294} 
		self.g_killnpcs[20021]={Name=" ????ng ??? cung binh ",mapid=50,mapname=" C?? t?? th???y t??? ",x=1736,y=3467,npcid=2044, dx=1755, dy=3294} 
		self.g_killnpcs[20022]={Name=" ????ng ??? th????ng binh ",mapid=50,mapname=" C?? t?? th???y t??? ",x=1695,y=3363,npcid=2043, dx=1755, dy=3294} 
		self.g_killnpcs[20023]={Name=" di??m bang bang ch??ng ",mapid=55,mapname=" Thanh loa ?????o ",x=1881,y=3428,npcid=2045, dx=1863, dy=3675} 
		self.g_killnpcs[20024]={Name=" th???n b?? th??ch kh??ch ",mapid=55,mapname=" Thanh loa ?????o ",x=1780,y=3639,npcid=2046, dx=1863, dy=3675} 
		self.g_killnpcs[20025]={Name=" ?????i b??n trong t??y t??ng ",mapid=55,mapname=" Thanh loa ?????o ",x=1705,y=3735,npcid=2217, dx=1863, dy=3675} 
		self.g_killnpcs[20026]={Name=" h??nh c?????c th????ng nh??n ",mapid=55,mapname=" Thanh loa ?????o ",x=1750,y=3399,npcid=2218, dx=1863, dy=3675} 
		self.g_killnpcs[20027]={Name=" nam man ??ao kh??ch ",mapid=54,mapname=" nam di b??? l???c ",x=1765,y=3274,npcid=2219, dx=1795, dy=3339} 
		self.g_killnpcs[20028]={Name=" nam man vu n??? ",mapid=54,mapname=" nam di b??? l???c ",x=1748,y=3631,npcid=2220, dx=1795, dy=3339} 
		self.g_killnpcs[20029]={Name=" h???c t??m khuy???n ",mapid=54,mapname=" nam di b??? l???c ",x=1663,y=3513,npcid=2048, dx=1795, dy=3339} 
		self.g_killnpcs[20030]={Name=" nam man li???p th??? ",mapid=54,mapname=" nam di b??? l???c ",x=1679,y=3273,npcid=2047, dx=1795, dy=3339} 
		self.g_killnpcs[20031]={Name=" h??? l??ng ??ao binh ",mapid=47,mapname=" thi??n nh???n gi??o c???m ?????a" ,x=1731,y=3335,npcid=2049,  dx=1667, dy=3660} 	
		self.g_killnpcs[20032]={Name=" o???t th??? c??ng t?????ng ",mapid=47,mapname=" thi??n nh???n gi??o c???m ?????a ",x=1736,y=3659,npcid=2221, dx=1667, dy=3660} 	
		self.g_killnpcs[20033]={Name=" th??? th???ch c??ng t?????ng ",mapid=47,mapname=" thi??n nh???n gi??o c???m ?????a ",x=1638,y=3603,npcid=2222,  dx=1667, dy=3660} 
		self.g_killnpcs[20034]={Name=" h??? l??ng cung th??? ",mapid=47,mapname=" thi??n nh???n gi??o c???m ?????a ",x=1623,y=3285,npcid=2050,  dx=1667, dy=3660}
		self.g_killnpcs[20035]={Name=" tham kh??ch ",mapid=48,mapname=" ki???n t??nh phong ",x=1758,y=3523,npcid=2051,dx=1872,dy=3440} 	
		self.g_killnpcs[20036]={Name=" v?? danh ??ao kh??ch ",mapid=48,mapname=" ki???n t??nh phong ",x=1820,y=3710,npcid=2052,dx=1872,dy=3440}  --roi
		self.g_killnpcs[20037]={Name=" ph??i Tuy???t S??n tr??? danh ????? t??? ",mapid=48,mapname=" ki???n t??nh phong ",x=1701,y=3690,npcid=2053,dx=1872,dy=3440} 	
		self.g_killnpcs[20038]={Name=" gi?? nua tuy???t vi??n ",mapid=48,mapname=" ki???n t??nh phong ",x=1674,y=3545,npcid=2223,dx=1872,dy=3440} 	
		self.g_killnpcs[20039]={Name=" c?? quan m???c nh??n ",mapid=56,mapname=" th??p l??m ????ng b??? ",x=1863,y=3496,npcid=2033, dx=1889, dy=3532} 	
		self.g_killnpcs[20040]={Name=" c?? quan lang ",mapid=56,mapname=" th??p l??m ????ng b??? ",x=1818,y=3956,npcid=2034, dx=1778, dy=3959} 	
		self.g_killnpcs[20041]={Name=" c?? quan ?????ng nh??n ",mapid=56,mapname=" th??p l??m ????ng b??? ",x=1724,y=3867,npcid=2205, dx=1757, dy=3842} 
		self.g_killnpcs[20042]={Name=" ?????ng gi??c th?? ",mapid=56,mapname=" th??p l??m ????ng b??? ",x=1765,y=3508,npcid=2206, dx=1801, dy=3524} 	
		self.g_killnpcs[20043]={Name=" h??? l??ng th????ng binh ",mapid=57,mapname=" kim qu???c ho??ng l??ng m???t t???ng ",x=1649,y=3282,npcid=2070, dx=1699, dy=3268} 
		self.g_killnpcs[20044]={Name=" minh ph??? quy kh??ch ",mapid=57,mapname=" kim qu???c ho??ng l??ng m???t t???ng ",x=1531,y=3374,npcid=2072, dx=1498, dy=3401} 	
		self.g_killnpcs[20045]={Name=" h??? l??ng n??? th??? ",mapid=57,mapname=" kim qu???c ho??ng l??ng m???t t???ng ",x=1473,y=3276,npcid=2071, dx=1513, dy=3288} 	
		self.g_killnpcs[20046]={Name=" c?????ng h??n tuy???t vi??n ",mapid=58,mapname=" b??ng huy???t m?? cung m???t t???ng ",x=1768,y=3095,npcid=2073,dx=1736,dy=3024} 	 --roi
		self.g_killnpcs[20047]={Name=" tuy???t vi??n v????ng ",mapid=58,mapname=" b??ng huy???t m?? cung m???t t???ng ",x=1693,y=3260,npcid=2074,dx=1736,dy=3024} 
		self.g_killnpcs[20048]={Name=" ???u h??? ",mapid=59,mapname=" long h??? huy???n c???nh ????ng b??? ",x=1381,y=2486,npcid=2056,dx=1546,dy=3136} 	
		self.g_killnpcs[20049]={Name=" th?? h??? ",mapid=59,mapname=" long h??? huy???n c???nh ????ng b??? ",x=1525,y=2951,npcid=2057,dx=1546,dy=3136} 	
		self.g_killnpcs[20050]={Name=" ????o ph???m ",mapid=59,mapname=" long h??? huy???n c???nh ????ng b??? ",x=1333,y=2881,npcid=2224,dx=1546,dy=3136} 	
		self.g_killnpcs[20051]={Name=" che m???t th??ch kh??ch ",mapid=59,mapname=" long h??? huy???n c???nh ????ng b??? ",x=1311,y=2534,npcid=2225,dx=1546,dy=3136} 	
		self.g_killnpcs[20052]={Name=" ???????ng lang quy???n s?? ",mapid=60,mapname=" y???n t??? ??? b??n ngo??i ",x=1603,y=2810,npcid=2232,dx=1604,dy=2726} 
		self.g_killnpcs[20053]={Name=" kim qu???c m???t tham ",mapid=60,mapname=" y???n t??? ??? b??n ngo??i ",x=1598,y=3034,npcid=2233,dx=1604,dy=2726} 
		self.g_killnpcs[20054]={Name=" di??m bang bang ch??ng ",mapid=60,mapname=" y???n t??? ??? b??n ngo??i ",x=1450,y=3030,npcid=2064,dx=1604,dy=2726} 
		self.g_killnpcs[20055]={Name=" c??? dong v?? s?? ",mapid=60,mapname=" y???n t??? ??? b??n ngo??i ",x=1300,y=2989,npcid=2065,dx=1604,dy=2726} 	
		self.g_killnpcs[20056]={Name=" du qu??n th????ng binh ",mapid=61,mapname=" ch??n l??o ?????ng m???t t???ng ",x=1770,y=3452,npcid=2063,dx=1630,dy=3810} 	
		self.g_killnpcs[20057]={Name=" du qu??n ??ao binh ",mapid=61,mapname=" ch??n l??o ?????ng m???t t???ng ",x=1861,y=3660,npcid=2231,dx=1630,dy=3810} 
		self.g_killnpcs[20058]={Name=" ???????ng gia ?????c s??? ",mapid=61,mapname=" ch??n l??o ?????ng m???t t???ng ",x=1690,y=3734,npcid=2230,dx=1630,dy=3810} 	
		self.g_killnpcs[20059]={Name=" ???????ng gia n??? th??? ",mapid=61,mapname=" ch??n l??o ?????ng m???t t???ng ",x=1687,y=3561,npcid=2062,dx=1630,dy=3810} 
		self.g_killnpcs[20060]={Name=" d?? lang ",mapid=62,mapname=" tr??m hoa ngo??i tr???n tr???n ",x=2300,y=3749,npcid=2058,dx=2369,dy=3775} 	
		self.g_killnpcs[20061]={Name=" s??t ????nh chuy ",mapid=62,mapname=" tr??m hoa ngo??i tr???n tr???n ",x=2168,y=3949,npcid=2059,dx=2369,dy=3775} 
		self.g_killnpcs[20062]={Name=" d???o ch??i hi???p kh??ch ",mapid=62,mapname=" tr??m hoa ngo??i tr???n tr???n ",x=1934,y=3595,npcid=2226,dx=2369,dy=3775} 
		self.g_killnpcs[20063]={Name=" tr??m hoa h??? ph??p ",mapid=62,mapname=" tr??m hoa ngo??i tr???n tr???n ",x=2208,y=3606,npcid=2227,dx=2369,dy=3775}
		self.g_killnpcs[20064]={Name=" ?? y ki???m s?? ",mapid=63,mapname=" ven h??? r???ng tr??c ????ng b??? ",x=1790,y=3350,npcid=2228,dx=1791,dy=3603} 
		self.g_killnpcs[20065]={Name=" r???ng tr??c ph??? ",mapid=63,mapname=" ven h??? r???ng tr??c ????ng b??? ",x=1756,y=3427,npcid=2229,dx=1791,dy=3603} 
		self.g_killnpcs[20066]={Name=" m?? bang v?? s?? ",mapid=63,mapname=" ven h??? r???ng tr??c ????ng b??? ",x=1646,y=3542,npcid=2061,dx=1791,dy=3603} 
		self.g_killnpcs[20067]={Name=" m?? bang th??i th??? ",mapid=63,mapname=" ven h??? r???ng tr??c ????ng b??? ",x=1724,y=3364,npcid=2060,dx=1791,dy=3603} 	
		self.g_killnpcs[20068]={Name=" nam di d??ng s?? ",mapid=64,mapname=" nguy??n th???y r???ng r???m ????ng b??? ",x=1792,y=3497,npcid=2068,dx=1877,dy=3246} 
		self.g_killnpcs[20069]={Name=" nam di t??? ti ",mapid=64,mapname=" nguy??n th???y r???ng r???m ????ng b??? ",x=1808,y=3795,npcid=2069,dx=1877,dy=3246} 	
		self.g_killnpcs[20070]={Name=" hoa m??ng ",mapid=64,mapname=" nguy??n th???y r???ng r???m ????ng b??? ",x=1721,y=3725,npcid=2236,dx=1877,dy=3246} 
		self.g_killnpcs[20071]={Name=" th??? tr??? vu n??? ",mapid=64,mapname=" nguy??n th???y r???ng r???m ????ng b??? ",x=1701,y=3544,npcid=2237,dx=1877,dy=3246} 	
		self.g_killnpcs[20072]={Name=" b??? kho??i ",mapid=65,mapname=" l?? vi ????ng ????ng nam b??? ",x=1906,y=3357,npcid=2067,dx=1962,dy=3704} 	
		self.g_killnpcs[20073]={Name=" ki???u trang m???t tham ",mapid=65,mapname=" l?? vi ????ng ????ng nam b??? ",x=1855,y=3577,npcid=2066,dx=1962,dy=3704} --roi 	
		self.g_killnpcs[20074]={Name=" qu?? l??? l??? kh??ch ",mapid=65,mapname=" l?? vi ????ng ????ng nam b??? ",x=1909,y=3702,npcid=2234,dx=1962,dy=3704} 
		self.g_killnpcs[20075]={Name=" h??nh c?????c th????ng phi???n ",mapid=65,mapname=" l?? vi ????ng ????ng nam b??? ",x=1664,y=3341,npcid=2235,dx=1962,dy=3704} 	
		self.g_killnpcs[20076]={Name=" ?????o d?????c nh??n ",mapid=66,mapname=" th??p l??m t??y b??? ",x=1913,y=3504,npcid=2238, dx=1796, dy=3552} 	
		self.g_killnpcs[20077]={Name=" s??n nam b???o d??n ",mapid=66,mapname=" th??p l??m t??y b??? ",x=1793,y=3671,npcid=2075, dx=1796, dy=3552} 	
		self.g_killnpcs[20078]={Name=" s??n b???c ?????o ph??? ",mapid=66,mapname=" th??p l??m t??y b??? ",x=1728,y=3605,npcid=2076, dx=1796, dy=3552} 	
		self.g_killnpcs[20079]={Name=" ch???y tr???n h??a th?????ng ",mapid=66,mapname=" th??p l??m t??y b??? ",x=1711,y=3513,npcid=2239, dx=1796, dy=3552} 
		self.g_killnpcs[20080]={Name=" ki???n l??ng c??ng t?????ng ",mapid=67,mapname=" kim qu???c ho??ng l??ng hai t???ng ",x=1661,y=03462,npcid=2093, dx=1518, dy=3396} 	
		self.g_killnpcs[20081]={Name=" kim qu???c gi??o ??y ",mapid=67,mapname=" kim qu???c ho??ng l??ng hai t???ng ",x=1582,y=3455,npcid=2252, dx=1518, dy=3396} 	
		self.g_killnpcs[20082]={Name=" tham quan gia ??inh ",mapid=67,mapname=" kim qu???c ho??ng l??ng hai t???ng ",x=1479,y=3448,npcid=2092, dx=1518, dy=3396} 	
		self.g_killnpcs[20083]={Name=" u minh lang ",mapid=67,mapname=" kim qu???c ho??ng l??ng hai t???ng ",x=1604,y=3230,npcid=2091, dx=1518, dy=3396} 	
		self.g_killnpcs[20084]={Name=" huy???t c?? nam d?? nh??n ",mapid=68,mapname=" b??ng huy???t m?? cung hai t???ng ",x=1771,y=3071,npcid=2095,dx=1632,dy=3344} --roi
		self.g_killnpcs[20085]={Name=" huy???t c?? ti???u d?? nh??n ",mapid=68,mapname=" b??ng huy???t m?? cung hai t???ng ",x=1734,y=3168,npcid=2096,dx=1632,dy=3344} 	
		self.g_killnpcs[20086]={Name=" huy???t c?? n??? d?? nh??n ",mapid=68,mapname=" b??ng huy???t m?? cung hai t???ng ",x=1692,y=3259,npcid=2094,dx=1632,dy=3344} 
		self.g_killnpcs[20087]={Name=" h???c th???y ??ao kh??ch ",mapid=69,mapname=" long h??? huy???n c???nh t??y b??? ",x=1569,y=2974,npcid=2077,dx=1574,dy=3164} 	
		self.g_killnpcs[20088]={Name=" h???c th???y ki???m s?? ",mapid=69,mapname=" long h??? huy???n c???nh t??y b??? ",x=1228,y=2643,npcid=2078,dx=1574,dy=3164} 	
		self.g_killnpcs[20089]={Name=" nam ???nh ",mapid=70,mapname=" y???n t??? ??? trung ??o???n ",x=1595,y=2899,npcid=2086,dx=1579,dy=2949} 	
		self.g_killnpcs[20090]={Name=" n??? ???nh ",mapid=70,mapname=" y???n t??? ??? trung ??o???n ",x=1644,y=3116,npcid=2085,dx=1579,dy=2949} 	
		self.g_killnpcs[20091]={Name=" khinh n??? th??? ",mapid=70,mapname=" y???n t??? ??? trung ??o???n ",x=1441,y=3018,npcid=2246,dx=1579,dy=2949} 	
		self.g_killnpcs[20092]={Name=" tr???ng gi??p binh ",mapid=70,mapname=" y???n t??? ??? trung ??o???n ",x=1299,y=2992,npcid=2247,dx=1579,dy=2949} 	
		self.g_killnpcs[20064]={name=" V?? S?? U Minh ",mapid=71,mapname=" ch??n l??o ?????ng hai t???ng ",x=1771,y=3454,npcid=2083, dx=1624, dy=3824}
		self.g_killnpcs[20094]={Name=" b???ch c???t ki???m kh??ch ",mapid=71,mapname=" ch??n l??o ?????ng hai t???ng ",x=1859,y=3659,npcid=2084, dx=1624, dy=3824} --roi
		self.g_killnpcs[20095]={Name=" th??? ki???m t??n gi??? ",mapid=71,mapname=" ch??n l??o ?????ng hai t???ng ",x=1688,y=3731,npcid=2244, dx=1624, dy=3824} 
		self.g_killnpcs[20096]={Name=" L??ng Ba ti??n t??? ",mapid=71,mapname=" ch??n l??o ?????ng hai t???ng ",x=1685,y=3558,npcid=2245, dx=1624, dy=3824} 
		self.g_killnpcs[20097]={Name=" th???ch th??nh li???t binh ",mapid=72,mapname=" tr??m hoa trong tr???n tr???n ",x=2332,y=3692,npcid=2079, dx=2232, dy=3456} 	--roi
		self.g_killnpcs[20098]={Name=" ??i???n quang m??u ",mapid=72,mapname=" tr??m hoa trong tr???n tr???n ",x=2130,y=3941,npcid=2080, dx=2232, dy=3456} 
		self.g_killnpcs[20099]={Name=" ti???u mao t???c ",mapid=72,mapname=" tr??m hoa trong tr???n tr???n ",x=1940,y=3610,npcid=2240, dx=2232, dy=3456} 
		self.g_killnpcs[20100]={Name=" t???m b???o l??? nh??n ",mapid=72,mapname=" tr??m hoa trong tr???n tr???n ",x=2205,y=3598,npcid=2241, dx=2232, dy=3456} 
		self.g_killnpcs[20101]={Name=" ??eo ??ao v?? s?? ",mapid=73,mapname=" ven h??? r???ng tr??c t??y b??? ",x=1794,y=3362,npcid=2242,dx=1726,dy=3306} 
		self.g_killnpcs[20102]={Name=" l???ng x?? nh??n ",mapid=73,mapname=" ven h??? r???ng tr??c t??y b??? ",x=1728,y=3477,npcid=2243,dx=1726,dy=3306} 
		self.g_killnpcs[20103]={Name=" ho??ng c??n kh??ch ",mapid=73,mapname=" ven h??? r???ng tr??c t??y b??? ",x=1623,y=3426,npcid=2081,dx=1726,dy=3306} 
		self.g_killnpcs[20104]={Name=" b???ch di???n kh??ch ",mapid=73,mapname=" ven h??? r???ng tr??c t??y b??? ",x=1685,y=3347,npcid=2082,dx=1726,dy=3306} 
		self.g_killnpcs[20105]={Name=" l???c ph??ch s??t th??? ",mapid=74,mapname=" nguy??n th???y r???ng r???m t??y b??? ",x=1879,y=3385,npcid=2250, dx=1784, dy=3568} 	--r???i
		self.g_killnpcs[20106]={Name=" l??u ph??ng ??ao kh??ch ",mapid=74,mapname=" nguy??n th???y r???ng r???m t??y b??? ",x=1888,y=3826,npcid=2251, dx=1784, dy=3568} 	
		self.g_killnpcs[20107]={Name=" l??u ph??ng vu n??? ",mapid=74,mapname=" nguy??n th???y r???ng r???m t??y b??? ",x=1671,y=3754,npcid=2089, dx=1784, dy=3568} 
		self.g_killnpcs[20108]={Name=" l???c ph??ch v?? s?? ",mapid=74,mapname=" nguy??n th???y r???ng r???m t??y b??? ",x=1686,y=3630,npcid=2090, dx=1784, dy=3568} 	
		self.g_killnpcs[20109]={Name=" kho??i ki???m kh??ch ",mapid=75,mapname=" l?? vi ????ng t??y b???c b??? ",x=1667,y=3426,npcid=2088,dx=1952,dy=3728}  --roi
		self.g_killnpcs[20110]={Name=" kho??i ??ao kh??ch ",mapid=75,mapname=" l?? vi ????ng t??y b???c b??? ",x=1868,y=3773,npcid=2087,dx=1952,dy=3728}  
		self.g_killnpcs[20111]={Name=" t?? ??c b???ng ph??? ",mapid=75,mapname=" l?? vi ????ng t??y b???c b??? ",x=1851,y=3577,npcid=2249,dx=1952,dy=3728}  	
		self.g_killnpcs[20112]={Name=" ph??? ????? bang hung ",mapid=75,mapname=" l?? vi ????ng t??y b???c b??? ",x=1908,y=3358,npcid=2248,dx=1952,dy=3728}  		
		self.g_killnpcs[20113]={Name=" ti???u ph??? binh ",mapid=86,mapname=" th??i h??nh c??? k??nh ",x=1896,y=3891,npcid=2119,dx=1865,dy=3768} 	
		self.g_killnpcs[20114]={Name=" v?? trang th??n d??n ",mapid=86,mapname=" th??i h??nh c??? k??nh ",x=1756,y=3693,npcid=2117, dx=1781, dy=3729} 
		self.g_killnpcs[20115]={Name=" b???o n??? qu??ng c??ng ",mapid=86,mapname=" th??i h??nh c??? k??nh ",x=1648,y=3398,npcid=2118, dx=1677, dy=3374} 
		self.g_killnpcs[20116]={Name=" m?? t???c du k??? ",mapid=87,mapname=" ?????i t??n quan ",x=1776,y=3640,npcid=2133, dx=1604, dy=3400} 	
		self.g_killnpcs[20117]={Name=" thi???t di??u t??? ",mapid=87,mapname=" ?????i t??n quan ",x=1771,y=3829,npcid=2132, dx=1604, dy=3400} 	
		self.g_killnpcs[20118]={Name=" t??y h??? du binh ",mapid=87,mapname=" ?????i t??n quan ",x=1666,y=3418,npcid=2134, dx=1604, dy=3400} 	
		self.g_killnpcs[20119]={Name=" t??o bang ???? th??? ",mapid=88,mapname=" h??n th???y c??? ????? ",x=01662,y=3337,npcid=2120, dx=1904, dy=3329} 	--roi
		self.g_killnpcs[20120]={Name=" t??o bang ?????o l??nh ",mapid=88,mapname=" h??n th???y c??? ????? ",x=1692,y=3645,npcid=2121, dx=1904, dy=3329} 	
		self.g_killnpcs[20121]={Name=" t????ng d????ng quan binh ",mapid=88,mapname=" h??n th???y c??? ????? ",x=1699,y=3431,npcid=2122, dx=1904, dy=3329} 
		self.g_killnpcs[20122]={Name=" ????o nan v??n quan ",mapid=89,mapname=" h??n s??n c??? th??p ",x=1888,y=3318,npcid=2126,dx=1560, dy=3376} 	--roi	
		self.g_killnpcs[20123]={Name=" ????o nan v?? quan ",mapid=89,mapname=" h??n s??n c??? th??p ",x=1966,y=3545,npcid=2127,dx=1560, dy=3376} 	
		self.g_killnpcs[20124]={Name=" ?????i t???ng c???m qu??n ",mapid=89,mapname=" h??n s??n c??? th??p ",x=1641,y=3378,npcid=2128,dx=1560, dy=3376}
		self.g_killnpcs[20125]={Name=" h?????ng th???y t??? s?? ",mapid=90,mapname=" ho??n hoa kh?? ",x=1750,y=3277,npcid=2125,dx=1960, dy=3552} 	--roi
		self.g_killnpcs[20126]={Name=" ng?? gia ??ao binh ",mapid=90,mapname=" ho??n hoa kh?? ",x=1969,y=3846,npcid=2124,dx=1960, dy=3552} 	
		self.g_killnpcs[20127]={Name=" ng?? gia th????ng binh ",mapid=90,mapname=" ho??n hoa kh?? ",x=1910,y=3555,npcid=2123,dx=1960, dy=3552} 	
		self.g_killnpcs[20128]={Name=" ?? man th??? binh ",mapid=91,mapname=" nh??? h???i ma nham ",x=1917,y=3374,npcid=2135,dx=1792, dy=3675} 	--chua chinh
		self.g_killnpcs[20129]={Name=" ?? man cung th??? ",mapid=91,mapname=" nh??? h???i ma nham ",x=1874,y=3727,npcid=2136,dx=1792, dy=3675} 	
		self.g_killnpcs[20130]={Name=" ?? man th???n vu ",mapid=91,mapname=" nh??? h???i ma nham ",x=1760,y=3629,npcid=2137,dx=1792, dy=3675} 	
		self.g_killnpcs[20131]={Name=" t??o bang bang ch??ng ",mapid=92,mapname=" th???i th???ch ki ",x=1708,y=3428,npcid=2129,dx=1706, dy=3486} 	
		self.g_killnpcs[20132]={Name=" m?? bang v?? s?? ",mapid=92,mapname=" th???i th???ch ki ",x=1851,y=3728,npcid=2131,dx=1792, dy=3675} 	--OK
		self.g_killnpcs[20133]={Name=" l??m an th??? qu??n ",mapid=92,mapname=" th???i th???ch ki ",x=1944,y=3389,npcid=2130,dx=1792, dy=3675} 	

		self.g_killnpcs[20134]={Name=" th?? v????ng li???p th??? ",mapid=93,mapname=" d?????c v????ng ?????ng ",x=1793,y=3825,npcid=2139, dx=1786,dy=3760} --roi
		self.g_killnpcs[20135]={Name=" th?? v????ng tu???n du ",mapid=93,mapname=" d?????c v????ng ?????ng ",x=1865,y=3722,npcid=2140, dx=1910,dy=3713} 
		self.g_killnpcs[20136]={Name=" th?? v????ng t??? ti ",mapid=93,mapname=" d?????c v????ng ?????ng ",x=1714,y=3446,npcid=2138, dx=1749,dy=3417}
		self.g_killnpcs[20137]={Name=" ho??nh s??n ??ng k??? ",mapid=94,mapname=" c?? duy??n tr???ch ",x=1680,y=3712,npcid=2155,dx=1648,dy=3714} --roi
		self.g_killnpcs[20138]={Name=" ho??nh s??n kh????ng b?????c binh ",mapid=94,mapname=" c?? duy??n tr???ch ",x=1695,y=3635,npcid=2153,dx=1864,dy=3936} 	
		self.g_killnpcs[20139]={Name=" ho??nh s??n h??? k??? ",mapid=94,mapname=" c?? duy??n tr???ch ",x=1880,y=3632,npcid=2154,dx=1864,dy=3936} 	
		self.g_killnpcs[20140]={Name=" ng??u lan tr???i l??u la ",mapid=95,mapname=" ph???c ng??u s??n ",x=1854,y=3256,npcid=2141,dx=1864,dy=3936} 	-- roi
		self.g_killnpcs[20141]={Name=" ng??u lan tr???i ng?????i c???m ??ao ",mapid=95,mapname=" ph???c ng??u s??n ",x=1791,y=3636,npcid=2142,dx=1804,dy=3276} 
		self.g_killnpcs[20142]={Name=" t?? gi??o nam ????? t??? ",mapid=95,mapname=" ph???c ng??u s??n ",x=1630,y=3936,npcid=2143,dx=1804,dy=3276} 	
		self.g_killnpcs[20143]={Name=" tinh k??? binh ",mapid=96,mapname=" h??? kh??u ki???m tr?? ",x=1741,y=3487,npcid=2149, dx=1920, dy=3712} 	--roi
		self.g_killnpcs[20144]={Name=" b???c doanh c???m qu??n ",mapid=96,mapname=" h??? kh??u ki???m tr?? ",x=1880,y=3387,npcid=2147, dx=1920, dy=3712} 
		self.g_killnpcs[20145]={Name=" nam doanh c???m qu??n ",mapid=96,mapname=" h??? kh??u ki???m tr?? ",x=1653,y=3663,npcid=2148, dx=1920, dy=3712} 
		self.g_killnpcs[20146]={Name=" h?????ng th???y kho??i ng?????i c???m ??ao ",mapid=97,mapname=" h?????ng th???y ?????ng ",x=1711,y=3742,npcid=2145, dx=1736, dy=3587} 	--roi
		self.g_killnpcs[20147]={Name=" h?????ng th???y th???n x??? th??? ",mapid=97,mapname=" h?????ng th???y ?????ng ",x=1729,y=3340,npcid=2144,dx=1736, dy=3587} 
		self.g_killnpcs[20148]={Name=" h?????ng th???y t??? s?? ",mapid=97,mapname=" h?????ng th???y ?????ng ",x=1863,y=3476,npcid=2146, dx=1736, dy=3587} 
		self.g_killnpcs[20149]={Name=" ?? b??? tr???i tinh binh ",mapid=98,mapname=" ??i???m Th????ng s??n ",x=1825,y=3431,npcid=2156, dx=1712, dy=3770} 	--roi
		self.g_killnpcs[20150]={Name=" ?? b??? tr???i tu???n th??? ",mapid=98,mapname=" ??i???m Th????ng s??n ",x=1899,y=3582,npcid=2157, dx=1712, dy=3770} 	
		self.g_killnpcs[20151]={Name=" h???c th???y khinh k??? ",mapid=98,mapname=" ??i???m Th????ng s??n ",x=1687,y=3654,npcid=2158, dx=1712, dy=3770} 	
		self.g_killnpcs[20152]={Name=" ng???a hoang ",mapid=99,mapname=" b??nh l??? c??? tr???ch ",x=1285,y=2899,npcid=2152,dx=1448,dy=3073} 	
		self.g_killnpcs[20153]={Name=" d?? h???u ",mapid=99,mapname=" b??nh l??? c??? tr???ch ",x=1448,y=3023,npcid=2151,dx=1448,dy=3073} 
		self.g_killnpcs[20154]={Name=" d?? l???c ",mapid=99,mapname=" b??nh l??? c??? tr???ch ",x=1317,y=2668,npcid=2150,dx=1448,dy=3073} 
		self.g_killnpcs[20155]={Name=" m??nh an m??u kh???c qu??n ",mapid=100,mapname=" phong l??ng ????? ",x=1968,y=3615,npcid=2159,dx=1968,dy=3232} --roi
		self.g_killnpcs[20157]={Name=" m?? bang th??i th??? ",mapid=100,mapname=" phong l??ng ????? ",x=1690,y=3448,npcid=2161,dx=1968,dy=3232} 
		self.g_killnpcs[20158]={Name=" t??o bang ???? th??? ",mapid=100,mapname=" phong l??ng ????? ",x=1703,y=3265,npcid=2160,dx=1968,dy=3232} 
		self.g_killnpcs[20159]={Name=" th???n t?? cung ",mapid=101,mapname=" sa m???c m?? cung ",x=1797,y=3754,npcid=2174,dx=1624,dy=3872} --roi
		self.g_killnpcs[20161]={Name=" h???c th???y kho??i k??? binh ",mapid=101,mapname=" sa m???c m?? cung ",x=1592,y=3696,npcid=2176,dx=1624,dy=3872} --sua toa do danh roi 	
		self.g_killnpcs[20162]={Name=" m?? t???c khinh ph??? th??? ",mapid=101,mapname=" sa m???c m?? cung ",x=1609,y=3444,npcid=2175,dx=1624,dy=3872} 	
		self.g_killnpcs[20163]={Name=" t?? gi??o b???c s?? ",mapid=102,mapname=" k?? quan ?????ng ",x=1601,y=2838,npcid=2164,dx=1592,dy=3200} --roi
		self.g_killnpcs[20165]={Name=" t?? gi??o nam ????? t??? ",mapid=102,mapname=" k?? quan ?????ng ",x=1479,y=03135,npcid=2162,dx=1592,dy=3200} 
		self.g_killnpcs[20166]={Name=" t?? gi??o n??? ????? t??? ",mapid=102,mapname=" k?? quan ?????ng ",x=1259,y=2844,npcid=2163,dx=1592,dy=3200} 
		self.g_killnpcs[20167]={Name=" t???ng khinh k??? binh ",mapid=103,mapname=" th???c c????ng s??n ",x=1889,y=3521,npcid=2168,dx=1875,dy=3774} 
		self.g_killnpcs[20169]={Name=" t???ng qu??n th????ng binh ",mapid=103,mapname=" th???c c????ng s??n ",x=1875,y=3774,npcid=2169,dx=1694,dy=3684} 	
		self.g_killnpcs[20170]={Name=" t???ng qu??n n??? th??? ",mapid=103,mapname=" th???c c????ng s??n ",x=1694,y=3684,npcid=2170,dx=1889,dy=3521} 	
		self.g_killnpcs[20171]={Name=" nam ???nh ",mapid=104,mapname=" ki???m c??ic th???c ?????o ",x=1919,y=3482,npcid=2166,dx=1545,dy=3460} 	
		self.g_killnpcs[20173]={Name=" th???n h??nh binh ",mapid=104,mapname=" ki???m c??ic th???c ?????o ",x=1759,y=3708,npcid=2167,dx=1919,dy=3482} 	
		self.g_killnpcs[20174]={Name=" n??? ???nh ",mapid=104,mapname=" ki???m c??ic th???c ?????o ",x=1545,y=3460,npcid=2165,dx=1759,dy=3708} 	
		self.g_killnpcs[20175]={Name=" th??? b??? b???c s?? ",mapid=105,mapname=" ??o???n th??? ho??ng l??ng ",x=1666,y=3342,npcid=2178,dx=1418,dy=3448}
		self.g_killnpcs[20177]={Name=" t??? di???n v?? s?? ",mapid=105,mapname=" ??o???n th??? ho??ng l??ng ",x=1469,y=3550,npcid=2179,dx=1666,dy=3342}
		self.g_killnpcs[20178]={Name=" th??? b??? t???c nh??n ",mapid=105,mapname=" ??o???n th??? ho??ng l??ng ",x=1418,y=3448,npcid=2177,dx=1469,dy=3550}
		self.g_killnpcs[20179]={Name=" giang h??? ki???m kh??ch ",mapid=106,mapname=" ch??n nghi kh?? ",x=1828,y=3420,npcid=2171,dx=1742,dy=3613} 
		self.g_killnpcs[20181]={Name=" giang h??? ??ao kh??ch ",mapid=106,mapname=" ch??n nghi kh?? ",x=1727,y=3353,npcid=2172,dx=1828,dy=3420} 	
		self.g_killnpcs[20182]={Name=" ?????i b??n trong m???t tham ",mapid=106,mapname=" ch??n nghi kh?? ",x=1742,y=3613,npcid=2173,dx=1727,dy=3353} 	
		self.g_killnpcs[20183]={Name=" ?????i kim c???m v??? qu??n ",mapid=107,mapname=" long m??n th???ch qu???t ",x=1914,y=3487,npcid=2180,dx=1730,dy=3696} 	
		self.g_killnpcs[20185]={Name=" ?????i kim phi k??? binh ",mapid=107,mapname=" long m??n th???ch qu???t ",x=1840,y=3745,npcid=2181,dx=1914,dy=3487} 
		self.g_killnpcs[20186]={Name=" ???nh h???i bang ch??ng ",mapid=107,mapname=" long m??n th???ch qu???t ",x=1730,y=3696,npcid=2182,dx=1840,dy=3745}
		self.g_killnpcs[20187]={Name=" ho??ng l??ng kh??n th??? ",mapid=108,mapname=" t??y h??? ho??ng l??ng ",x=1954,y=3064,npcid=2195,dx=1824,dy=3092} 	
		self.g_killnpcs[20189]={Name=" Ph???n qu??n c???m ??ao ",mapid=108,mapname=" t??y h??? ho??ng l??ng ",x=1904,y=3187,npcid=2196,dx=2001,dy=3122} 	
		self.g_killnpcs[20190]={Name=" c???n ng?????i c???m ??ao ",mapid=108,mapname=" t??y h??? ho??ng l??ng ",x=1824,y=3092,npcid=2197,dx=1904,dy=3187}
		self.g_killnpcs[20191]={Name=" l??u vong ??ao binh ",mapid=109,mapname=" Ho??ng H???c l??u ",x=1854,y=3594,npcid=2183,dx=1838,dy=3645}
		self.g_killnpcs[20193]={Name=" tr?? th??nh th??? qu??n ",mapid=109,mapname=" Ho??ng H???c l??u ",x=1615,y=3592,npcid=2184,dx=1838,dy=3645} 	
		self.g_killnpcs[20194]={Name=" l??u kh???u ",mapid=109,mapname=" Ho??ng H???c l??u ",x=1717,y=3772,npcid=2185,dx=1838,dy=3645} 	
		self.g_killnpcs[20195]={Name=" kh??? c??ng ",mapid=110,mapname=" ti???n c??c ?????ng ",x=1480,y=3144,npcid=2190,dx=1531,dy=3189} 	
		self.g_killnpcs[20197]={Name=" b???c m?? bang ch??ng ",mapid=110,mapname=" ti???n c??c ?????ng ",x=1557,y=3264,npcid=2191,dx=1531,dy=3189} 
		self.g_killnpcs[20198]={Name=" di??m bang bang ch??ng ",mapid=110,mapname=" ti???n c??c ?????ng ",x=1477,y=2913,npcid=2189,dx=1531,dy=3189} 	
		self.g_killnpcs[20199]={Name=" ki???m m??n th??? qu??n ",mapid=111,mapname=" ki???m m??n quan ",x=1613,y=3435,npcid=2186,dx=1639,dy=3490}
		self.g_killnpcs[20201]={Name=" h???c th???y v??n k??? binh ",mapid=111,mapname=" ki???m m??n quan ",x=1895,y=3591,npcid=2188,dx=1639,dy=3490}
		self.g_killnpcs[20202]={Name=" h??? quan thi???t k??? binh ",mapid=111,mapname=" ki???m m??n quan ",x=1663,y=3605,npcid=2187,dx=1639,dy=3490} 	
		self.g_killnpcs[20203]={Name=" h??? t??? t??ng binh ",mapid=112,mapname=" thi??n long t??? ",x=1809,y=3426,npcid=2199,dx=1675,dy=3662}
		self.g_killnpcs[20205]={Name=" ?? man d??ng s?? ",mapid=112,mapname=" thi??n long t??? ",x=1907,y=3585,npcid=2200,dx=1809,dy=3426} 	
		self.g_killnpcs[20206]={Name=" t??y h??? k??? binh ",mapid=112,mapname=" thi??n long t??? ",x=1675,y=3662,npcid=2198,dx=1907,dy=3585} 	
		self.g_killnpcs[20207]={Name=" Giang Nam ngh??a s?? ",mapid=113,mapname=" bang nguy??n b?? ?????ng ",x=1410,y=3330,npcid=2192,dx=1838,dy=3645}
		self.g_killnpcs[20209]={Name=" ????ng nam ngh??a s?? ",mapid=113,mapname=" bang nguy??n b?? ?????ng ",x=1899,y=3606,npcid=2193,dx=1838,dy=3645} 
		self.g_killnpcs[20210]={Name=" giang b???c ngh??a s?? ",mapid=113,mapname=" bang nguy??n b?? ?????ng ",x=1394,y=3750,npcid=2194,dx=1838,dy=3645} 	
		--------------
		self.g_killnpcs[20211]={Name=" th??t ????t truy binh ",mapid=114,mapname=" s???c l???c xuy??n ",x=1857,y=3443,x1=1883,y1=3377,npcid=2253,dx=1747,dy=3524} 	---MV 12-04
		self.g_killnpcs[20212]={Name="K??? Binh Kim Qu???c",mapid=114,mapname=" s???c l???c xuy??n ",x=1838,y=3645,x1=1777,y1=3666,npcid=2254,dx=1747,dy=3524} 	---MV
		self.g_killnpcs[20213]={Name="???? L??i K??? Binh",mapid=114,mapname=" s???c l???c xuy??n ",x=1659,y=3778,x1=1657,y1=3591,npcid=2255,dx=1747,dy=3524} 	---MV
		self.g_killnpcs[20214]={Name="?????i M???c ??ao Kh??ch",mapid=114,mapname=" s???c l???c xuy??n ",x=1629,y=3405,x1=1717,y1=3304,npcid=2256,dx=1747,dy=3524} 	---MV
		
		self.g_killnpcs[20215]={Name="Qu??n S?? T??y H???",mapid=115,mapname=" gia d???c quan ",x=1674,y=2921,x1=1727,y1=2881,npcid=2257,dx=1624,dy=3156} 	
		self.g_killnpcs[20216]={Name="M???t B??? Binh S??",mapid=115,mapname=" gia d???c quan ",x=1701,y=3163,x1=1777,y1=3165,npcid=2258,dx=1624,dy=3156} 	
		self.g_killnpcs[20217]={Name="Th??? Qu??n Gia D??? Quan",mapid=115,mapname=" gia d???c quan ",x=1446,y=3142,x1=1462,y1=3051,npcid=2259,dx=1624,dy=3156} 	
		self.g_killnpcs[20218]={Name="T??i Ngo???i H??o Lang",mapid=115,mapname=" gia d???c quan ",x=1553,y=3009,x1=1507,y1=2984,npcid=2260,dx=1624,dy=3156} 
		
		self.g_killnpcs[20219]={Name=" Hoa S??n di???p h???u ",mapid=116,mapname=" Hoa S??n ",x=1776,y=3363,x1=1714,y1=3353,npcid=2261,dx=1786,dy=3490} 
		self.g_killnpcs[20220]={Name=" Hoa S??n th??? qu??n ",mapid=116,mapname=" Hoa S??n ",x=1875,y=3682,x1=1933,y1=3736,npcid=2262,dx=1786,dy=3490} 	
		self.g_killnpcs[20221]={Name="D??? Nh??n Ki???m Kh??ch",mapid=116,mapname=" Hoa S??n ",x=1759,y=3778,x1=1775,y1=3634,npcid=2263,dx=1786,dy=3490} 	
		self.g_killnpcs[20222]={Name=" Hoa S??n c?????ng t???c ",mapid=116,mapname=" Hoa S??n ",x=1613,y=3380,x1=1639,y1=3557,npcid=2264,dx=1786,dy=3490} 	
		
		self.g_killnpcs[20223]={Name=" ph?? du t??n binh ",mapid=117,mapname=" th???c c????ng b?? c???nh ",x=1673,y=2971,x1=1697,y1=3102,npcid=2265,dx=1552,dy=3168} 	
		self.g_killnpcs[20224]={Name=" b?? c???nh m??u th??? ",mapid=117,mapname=" th???c c????ng b?? c???nh ",x=1718,y=3379,x1=1688,y1=3245,npcid=2266,dx=1552,dy=3168} 	
		self.g_killnpcs[20225]={Name=" giang h??? lang trung ",mapid=117,mapname=" th???c c????ng b?? c???nh ",x=1499,y=3264,x1=1410,y1=3315,npcid=2267,dx=1552,dy=3168} 	
		self.g_killnpcs[20226]={Name=" s??n mi??u ",mapid=117,mapname=" th???c c????ng b?? c???nh ",x=1488,y=3140,x1=1596,y1=3055,npcid=2268,dx=1552,dy=3168} 
		
		self.g_killnpcs[20227]={Name=" ?????c ?????ng t??? ",mapid=118,mapname=" phong ?????u|c??ng qu??? th??nh ",x=1822,y=3466,x1=1827,y1=3566,npcid=2269,dx=1705,dy=3527} 	
		self.g_killnpcs[20228]={Name=" qu??? n?? ",mapid=118,mapname=" phong ?????u|c??ng qu??? th??nh ",x=1772,y=3673,x1=1700,y1=3644,npcid=2270,dx=1705,dy=3527} 	
		self.g_killnpcs[20229]={Name=" qu??? s??? ",mapid=118,mapname=" phong ?????u|c??ng qu??? th??nh ",x=1730,y=3976,x1=1680,y1=3942,npcid=2271,dx=1705,dy=3527}
		self.g_killnpcs[20230]={Name=" mai c???t binh ",mapid=118,mapname=" phong ?????u|c??ng qu??? th??nh ",x=1561,y=3717,x1=1523,y1=3664,npcid=2272,dx=1705,dy=3527}
		
		self.g_killnpcs[20231]={Name=" h???c mi??u li???p th??? ",mapid=119,mapname=" mi??u l??nh ",x=1697,y=3387,x1=1770,y1=3323,npcid=2273,dx=1667,dy=3494} 
		self.g_killnpcs[20232]={Name=" man n??? t??? ti ",mapid=119,mapname=" mi??u l??nh ",x=1844,y=3366,x1=1833,y1=3475,npcid=2274,dx=1667,dy=3494} 	
		self.g_killnpcs[20233]={Name=" b???ch mi??u li???p th??? ",mapid=119,mapname=" mi??u l??nh ",x=1623,y=3746,x1=1663,y1=3746,npcid=2275,dx=1667,dy=3494} 
		self.g_killnpcs[20234]={Name=" mi??u l??nh th??? qu??n ",mapid=119,mapname=" mi??u l??nh ",x=1539,y=3326,x1=1638,y1=3198,npcid=2276,dx=1667,dy=3494} 
		
		self.g_killnpcs[20235]={Name=" tr?????ng ca m??n s?? t??? ",mapid=120,mapname=" V?? Di S??n ",x=1931,y=3545,x1=1873,y1=3533,npcid=2277,dx=1725,dy=3546} 	
		self.g_killnpcs[20236]={Name=" h???ng y l??u la ",mapid=120,mapname=" V?? Di S??n ",x=1860,y=3749,x1=1872,y1=3838,npcid=2278,dx=1725,dy=3546} 	
		self.g_killnpcs[20237]={Name=" t??? y l??u la ",mapid=120,mapname=" V?? Di S??n ",x=1627,y=3700,x1=1607,y1=3778,npcid=2279,dx=1725,dy=3546} 	
		self.g_killnpcs[20238]={Name=" d?? sanh hoa nam h??? ",mapid=120,mapname=" V?? Di S??n ",x=1592,y=3617,x1=1546,y1=3585,npcid=2280,dx=1725,dy=3546} 
		
		self.g_killnpcs[20239]={Name=" v?? l??ng s??n th??? qu??n ",mapid=121,mapname=" v?? l??ng s??n ",x=1771,y=3189,x1=1705,y1=3184,npcid=2281,dx=1643,dy=3295}
		self.g_killnpcs[20240]={Name=" x??ch luy???n v????ng x?? ",mapid=121,mapname=" v?? l??ng s??n ",x=1740,y=3429,x1=1785,y1=3416,npcid=2282,dx=1643,dy=3295}  	
		self.g_killnpcs[20241]={Name=" b??u ph??ch kh??n th??? ",mapid=121,mapname=" v?? l??ng s??n ",x=1656,y=3393,x1=1600,y1=3379,npcid=2283,dx=1643,dy=3295} 	
		self.g_killnpcs[20242]={Name=" th???o qu??? b?? ",mapid=121,mapname=" v?? l??ng s??n ",x=1530,y=3207,x1=1483,y1=3252,npcid=2284,dx=1643,dy=3295} 	 	

	self.g_finditem = {}

	--cl1:(g,d,p,l,num,buyid,nRecdepId)  id:buyid
	self.g_finditem[10001]
		={level=1,name="1????????????????",id={18,1,66,1},ReceptId=1296,Cl1={22,1,4,1,1,726,11}}
	self.g_finditem[10002]
		={level=2,name="2????????????????",id={18,1,66,2},ReceptId=1297,Cl1={22,1,4,2,1,727,12},Cl2={22,1,4,1,1,726,11}}
	self.g_finditem[10003]
		={level=3,name="3????????????????",id={18,1,66,3},ReceptId=1298,Cl1={22,1,4,3,1,728,13},Cl2={22,1,4,2,2,727,12}}
	self.g_finditem[10004]
		={level=4,name="4????????????????",id={18,1,66,4},ReceptId=1299,Cl1={22,1,4,4,1,729,14},Cl2={22,1,4,3,2,728,13}}

	self.g_finditem[10005]
		={level=1,name="1????????????????",id={18,1,67,1},ReceptId=1306,Cl1={22,1,18,1,1,796,81}}
	self.g_finditem[10006]
		={level=2,name="2????????????????",id={18,1,67,2},ReceptId=1307,Cl1={22,1,18,2,1,797,82},Cl2={22,1,18,1,1,796,81}}
	self.g_finditem[10007]
		={level=3,name="3????????????????",id={18,1,67,3},ReceptId=1308,Cl1={22,1,18,3,1,798,83},Cl2={22,1,18,2,2,797,82}}
	self.g_finditem[10008]
		={level=4,name="4????????????????",id={18,1,67,4},ReceptId=1309,Cl1={22,1,18,4,1,799,84},Cl2={22,1,18,3,3,798,83}}

	self.g_finditem[10009]
		={level=1,name="1????????????????",id={18,1,68,1},ReceptId=1316,Cl1={22,1,4,1,1,726,11}}
	self.g_finditem[10010]
		={level=2,name="2????????????????",id={18,1,68,2},ReceptId=1317,Cl1={22,1,4,2,1,727,12},Cl2={22,1,4,1,1,726,11}}
	self.g_finditem[10011]
		={level=3,name="3????????????????",id={18,1,68,3},ReceptId=1318,Cl1={22,1,4,3,1,728,13},Cl2={22,1,4,2,2,727,12}}
	self.g_finditem[10012]
		={level=4,name="4????????????????",id={18,1,68,4},ReceptId=1319,Cl1={22,1,4,4,1,729,14},Cl2={22,1,4,3,2,728,13}}

end


tbSuperBao.canReceptID = function(self,nReceptId)
	local tbRecipeList = me.GetRecipeList();
	if (not tbRecipeList or #tbRecipeList == 0) then
		return 0;
	end
	local Ans = 0
	for _, nRecipeId1 in ipairs(tbRecipeList) do
		if tonumber(nReceptId) == tonumber(nRecipeId1) then
			print("C?? th??? s???n xu???t : "..nRecipeId1)
			Ans = 1
			break
		end
	end
	return Ans
end

tbSuperBao.finditembyname = function(self,szItemName,szSuffix)
	local tbRecipeList = me.GetRecipeList();

	local mName=szItemName
	if szSuffix then
		mName=mName.." - "..szSuffix
	end
	if (not tbRecipeList or #tbRecipeList == 0) then
		return nil;
	end

	for _, nRecipeId1 in ipairs(tbRecipeList) do
		if LifeSkill.tbRecipeDatas[nRecipeId1].Name == mName then		
			-- me.Msg("Name:"..mName);	
			local nKind = LifeSkill.tbRecipeDatas[nRecipeId1].Kind; 
			-- me.Msg("Kind:"..nKind);
			-- Kind???1-50   ?????????12-20 ?????????21-38 ?????????41-44???50 ?????????????????????2-4 --JUN
			local nSkillLevel = LifeSkill.tbRecipeDatas[nRecipeId1].SkillLevel; -- 1 10 20 30 40 50 60 70 80 90
			-- me.Msg("SkillLevel:"..nSkillLevel);
			if (nKind >= 12 and nKind <= 20 and nSkillLevel >= self:Level2SkillLevel(nWuMax)) then 
				me.Msg("<color=0,255,255>K??? n??ng V?? kh?? c???p "..nWuMax.." ch??a ?????t y??u c???u<color>");
				return nil 
			elseif (nKind >= 41 and nKind <= 50 and nSkillLevel >= self:Level2SkillLevel(nShouMax)) then 
				me.Msg("<color=0,255,255>K??? n??ng Trang s???c c???p "..nShouMax.." ch??a ?????t y??u c???u<color>"); 
				return nil 
			elseif (nKind >= 21 and nKind <= 38 and nSkillLevel >= self:Level2SkillLevel(nFangMax)) then  
				me.Msg("<color=0,255,255>K??? n??ng Ph??ng c??? c???p "..nFangMax.." ch??a ?????t y??u c???u<color>");
				return nil 
			elseif (nKind >= 2 and nKind <= 4 and nSkillLevel >= self:Level2SkillLevel(nMoMax)) then   
				me.Msg("<color=0,255,255>K??? n??ng Ng?? h??nh c???p "..nMoMax.." ch??a ?????t y??u c???u<color>");   
				return nil 
			elseif me.dwCurMKP < nKptp or me.dwCurGTP < nKptp or me.nCashMoney < nMoney then     -----tdeeeeeeeeeeeeeeeeee
				return nil 
			else
				return nRecipeId1
			end
		end
	end
	return nil
end


tbSuperBao.finditembyGDPL = function(self,G,D,P,L)
	local tbRecipeList = me.GetRecipeList();

	if (not tbRecipeList or #tbRecipeList == 0) then
		return nil;
	end

	for _, nRecipeId1 in ipairs(tbRecipeList) do
		local tbData = LifeSkill.tbRecipeDatas[nRecipeId1]
		if tbData.Produce1Genre==G and  tbData.Produce1Detail==D and   tbData.Produce1Parti==P and   tbData.Produce1Level==L then
			return nRecipeId1
		end
	end
	return nil
end

tbSuperBao.MySay = function(self)
	local szMsg = "????????????ch???p h??nh ?????????????"


	Dialog:Say(szMsg,{
				   {"t??? ?????ng Bao V???n ?????ng", self.StartBao, self},
				   {"t??? ?????ng gh??p Huy???n tinh ", self.hexuan, self},
				   {"t??? ?????ng mua ????? ???s???a ????? ", self.MaiCai, self},
				   {"kh??ng ???"},});

end

local nPrayCount = 0

tbSuperBao.mPray = function(self)
	local uiPlayerPray	= Ui(Ui.UI_PLAYERPRAY);
	tbSuperBao.Pray_bak	= tbSuperBao.Pray_bak or uiPlayerPray.SetHandFrame;
	function uiPlayerPray:SetHandFrame(nCount)
		tbSuperBao.Pray_bak(uiPlayerPray, 1);
	end

end

tbSuperBao.Init2 = function(self)
	for i=1,#UiShortcutAlias.m_tKeyList do
		if UiShortcutAlias.m_tKeyList[i][1]=="MoveTo(0,	0)" then
			UiShortcutAlias.m_tKeyList[i][1]="UiManager:mymovedown(0,1)";
			UiShortcutAlias:AddAlias(UiShortcutAlias.m_tKeyList[i][2], UiShortcutAlias.m_tKeyList[i][1]);
		elseif  UiShortcutAlias.m_tKeyList[i][1]=="MoveTo(8,	0)" then
			UiShortcutAlias.m_tKeyList[i][1]="UiManager:mymovedown(-1,1)";
			UiShortcutAlias:AddAlias(UiShortcutAlias.m_tKeyList[i][2], UiShortcutAlias.m_tKeyList[i][1]);
		elseif  UiShortcutAlias.m_tKeyList[i][1]=="MoveTo(16,	0)" then
			UiShortcutAlias.m_tKeyList[i][1]="UiManager:mymovedown(-1,0)";
			UiShortcutAlias:AddAlias(UiShortcutAlias.m_tKeyList[i][2], UiShortcutAlias.m_tKeyList[i][1]);
		elseif  UiShortcutAlias.m_tKeyList[i][1]=="MoveTo(24,	0)" then
			UiShortcutAlias.m_tKeyList[i][1]="UiManager:mymovedown(-1,-1)";
			UiShortcutAlias:AddAlias(UiShortcutAlias.m_tKeyList[i][2], UiShortcutAlias.m_tKeyList[i][1]);
		elseif  UiShortcutAlias.m_tKeyList[i][1]=="MoveTo(32,	0)" then
			UiShortcutAlias.m_tKeyList[i][1]="UiManager:mymovedown(0,-1)";
			UiShortcutAlias:AddAlias(UiShortcutAlias.m_tKeyList[i][2], UiShortcutAlias.m_tKeyList[i][1]);
		elseif  UiShortcutAlias.m_tKeyList[i][1]=="MoveTo(40,	0)" then
			UiShortcutAlias.m_tKeyList[i][1]="UiManager:mymovedown(1,-1)";
			UiShortcutAlias:AddAlias(UiShortcutAlias.m_tKeyList[i][2], UiShortcutAlias.m_tKeyList[i][1]);
		elseif  UiShortcutAlias.m_tKeyList[i][1]=="MoveTo(48,	0)" then
			UiShortcutAlias.m_tKeyList[i][1]="UiManager:mymovedown(1,0)";
			UiShortcutAlias:AddAlias(UiShortcutAlias.m_tKeyList[i][2], UiShortcutAlias.m_tKeyList[i][1]);
		elseif  UiShortcutAlias.m_tKeyList[i][1]=="MoveTo(56,	0)" then
			UiShortcutAlias.m_tKeyList[i][1]="UiManager:mymovedown(1,1)";
			UiShortcutAlias:AddAlias(UiShortcutAlias.m_tKeyList[i][2], UiShortcutAlias.m_tKeyList[i][1]);
		end
	end
end

tbSuperBao.mymovedown=function(self,nx,ny)
	AutoAi.SetTargetIndex(0)
	local x,y,world = me.GetNpc().GetMpsPos()
	AutoAi.AiAutoMoveTo(x+nx*200, y+ny*200);
end

tbSuperBao.mInit = function(self)
	tbSuperBao:readkillnpc()
	tbSuperBao:Init2()

		local szCmd	= [=[
		UiManager:StartBao();
	]=];
	UiShortcutAlias:AddAlias("", szCmd);	-- ????????????Ctrl + 9 GM_S9

	local szCmd	= [=[
		UiManager:StopBao();
	]=];
	UiShortcutAlias:AddAlias("", szCmd);	-- ????????????Ctrl + 8 GM_S8

	local szCmd	= [=[
		UiManager:hexuan();
	]=];
	UiShortcutAlias:AddAlias("", szCmd);	-- ????????????Ctrl + 7 GM_S7
	local szCmd	= [=[
		UiManager:MaiCai();
	]=];
	UiShortcutAlias:AddAlias("", szCmd);	-- ????????????Ctrl + 6 GM_S6

	local szCmd	= [=[
		UiManager:StartGua();
	]=];
	UiShortcutAlias:AddAlias("", szCmd);	-- ????????????Ctrl + 5  GM_S5


end
function tbSuperBao:Level2SkillLevel(nLevel)
	local nSkillLevel = 1;
	if (nLevel > 1) then
		nSkillLevel = (nLevel - 1) * 10;
	end
	return nSkillLevel;
end


function tbSuperBao:OpenExtBag()	
	if (UiManager:WindowVisible(Ui.UI_ITEMBOX) ~= 1) then		
		UiManager:SwitchWindow(Ui.UI_ITEMBOX);
	end	
	local tbItemBox = Ui(Ui.UI_ITEMBOX);	
	local tbExtBagLayout = Ui.tbLogic.tbExtBagLayout;
	tbExtBagLayout:Show();  
end

function tbSuperBao:TeamApply()
	local	tbNearbyPlayer = me.GetNearbyLonePlayer();
	local nAllotModel, tbMemberList = me.GetTeamInfo();
	if tbMemberList ~= nil then
		return;
	end
	for i = 1, #tbNearbyPlayer do
		local szName = tbNearbyPlayer[i].szName;
		if szName and tbNearbyPlayer[i].nPlayerID then
			local nId = tbNearbyPlayer[i].nPlayerID;
			if (tbNearbyPlayer[i].nCaptainFlag == 1 and tbTeamLeader[szName] == nil)then
				me.TeamApply(nId, szName);
				tbTeamLeader[szName] = szName;
			end
		end
	end
end

function tbSuperBao:CreateTeam()
	local	tbNearbyPlayer = me.GetNearbyLonePlayer();
	local nAllotModel, tbMemberList = me.GetTeamInfo();
	local nCaptain = 0
	for i = 1, #tbNearbyPlayer do
		local szName = tbNearbyPlayer[i].szName;
		if szName and tbNearbyPlayer[i].nPlayerID then
			local nId = tbNearbyPlayer[i].nPlayerID;
			if (tbNearbyPlayer[i].nCaptainFlag == 1 )then
				nCaptain = 1;
			end
		end
	end
	if  nCaptain == 1 then
		return;
	end
	me.CreateTeam();
end

function tbSuperBao:ClearTeamLeader()
	tbTeamLeader = {};
end

function tbSuperBao:TeamLeave()
	local nAllotModel, tbMemberList = me.GetTeamInfo();
	if tbMemberList == nil then
		return;
	end
	me.TeamLeave();
	self:ClearTeamLeader();
end
function tbSuperBao:ModifyUi()
	local uiMsgPad =Ui(Ui.UI_MSGPAD)
	tbSuperBao.Say_bak	= tbSuperBao.Say_bak or Ui(Ui.UI_MSGPAD).OnSendMsgToChannel;
	function uiMsgPad:OnSendMsgToChannel(szChannelName, szName, szMsg, szGateway)
		tbSuperBao.Say_bak(Ui(Ui.UI_MSGPAD), szChannelName, szName, szMsg, szGateway);
		local function fnOnSay()
			tbSuperBao:OnSay(szChannelName, szName, szMsg, szGateway);
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(1, fnOnSay);
	end
end

function tbSuperBao.CTestLv()
	if me.nLevel > 89 then
		nLvBuyItem = 5
	elseif me.nLevel > 69 then 
		nLvBuyItem = 4
	elseif me.nLevel > 49 then 
		nLvBuyItem = 3
	elseif me.nLevel > 29 then
		nLvBuyItem = 2
	else
		nLvBuyItem = 1
	end
	return 
end




function tbSuperBao.CNeedRepair() 
	for i = 0, Item.EQUIPPOS_NUM - 1 do
		local pItem = me.GetItem(Item.ROOM_EQUIP,i,0)
		if pItem then
			if pItem.nCurDur  < Item.DUR_MAX/50  then 
				bCNeedRepair = 1
			end
		end
	end
	bCNeedRepair = 0
end

function tbSuperBao.CBuyHTPhu(selft)
	local nId = tbSuperBao:GetAroundNpcId(3565)
	if nId then
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
		--me.AnswerQestion(1) ---- fix event thang 11
			if me.GetBindMoney() > nBac then
				me.AnswerQestion(0)
			elseif me.GetBindMoney() <= nBac and nBacE == 1 then
				Exit();
			else
				me.AnswerQestion(1)
			end
			local function fnCloseSay6()
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
				return 0
			end
			local function fnbuy6()
				local bOK, szMsg = me.ShopBuyItem(714, nCBuyHTPc); --
				UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIREXALL_SEND);
				
				if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
					UiManager:CloseWindow(Ui.UI_SHOP);
					UiManager:CloseWindow(Ui.UI_ITEMBOX);
				end
			--	nFlagGoHome  = 0
				return 0
			end
			Ui.tbLogic.tbTimer:Register(15, fnCloseSay6());
			Ui.tbLogic.tbTimer:Register(40, fnbuy6());
		elseif  UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
		else
			AutoAi.SetTargetIndex(nId);
		end						
	else
		tbSuperBao:fnfindNpc(3565,"B???t ?????ng Ti??n Sinh");
	end
end		

function tbSuperBao.CFreeBag()
	local FreeBag = me.CalcFreeItemCountInBags(19,3,1,5,0,0)
	if (nTimerId ~= 0) and nCFreeBag < 6 then 
		nCFreeBag=6
	end
	if FreeBag < nCFreeBag then
		nCount_FreeBag = 0;
	else
		nCount_FreeBag = 1;
	end
end

function tbSuperBao.CBuyHPMP()	
	local nId = tbSuperBao:GetAroundNpcId(3564)
	if nId then
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			if me.GetBindMoney() > nBac then
				me.AnswerQestion(0)
			elseif me.GetBindMoney() <= nBac and nBacE == 1 then
				Exit();
			else
				me.AnswerQestion(1)
			end	
			local function fnCloseSay3()
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
				return 0
			end
			local function fnbuy()
				local nCountHP = me.GetItemCountInBags(17,1,1,nHPLvId);
				local nCountMP = me.GetItemCountInBags(17,nMPLvId1,1,nMPLvId);
				if nCountHP < nCBuyHP then
					me.ShopBuyItem(675 + nHPLvId, nCBuyHP - nCountHP); --
				elseif nCountMP < nCBuyMP and nMPLvId1 ==  2 then
					me.ShopBuyItem(680 + nMPLvId, nCBuyMP - nCountMP); --
				elseif nCountMP < nCBuyMP and nMPLvId1 ==  3 then
					me.ShopBuyItem(685 + nMPLvId, nCBuyMP - nCountMP); --
				end
				UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIREXALL_SEND);
				if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
					UiManager:CloseWindow(Ui.UI_SHOP);
					UiManager:CloseWindow(Ui.UI_ITEMBOX);
				end
				nFlagHPMP = 0
				return 0
			end
			Ui.tbLogic.tbTimer:Register(15, fnCloseSay3);
			Ui.tbLogic.tbTimer:Register(40, fnbuy);
		elseif  UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
		else
			AutoAi.SetTargetIndex(nId);
		end
	else									
		tbSuperBao:fnfindNpc(3564,"Tr????ng Tr???m Kinh");
	end
end
function tbSuperBao.CBuyFood()
	local nCountFood = me.GetItemCountInBags(19,3,1,nLvBuyItem);
	local nId = tbSuperBao:GetAroundNpcId(3566)
	if nId then
		if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
			if me.GetBindMoney() > nBac then
				me.AnswerQestion(0)
			elseif me.GetBindMoney() <= nBac and nBacE == 1 then
				Exit();
			else
				me.AnswerQestion(1)
			end	
			local function fnCloseSay3()
				UiManager:CloseWindow(Ui.UI_SAYPANEL);
				return 0
			end
			local function fnbuy()
				if nCountFood < nCBuyFood then
					local bOK, szMsg = me.ShopBuyItem(820 + nLvBuyItem, nCBuyFood - nCountFood); --
				end
				UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIREXALL_SEND);
			
				if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
					UiManager:CloseWindow(Ui.UI_SHOP);
					UiManager:CloseWindow(Ui.UI_ITEMBOX);
				end
				nFlagFood = 0
				return 0
			end
			Ui.tbLogic.tbTimer:Register(15, fnCloseSay3);
			Ui.tbLogic.tbTimer:Register(40, fnbuy);
		elseif  UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
		else
			AutoAi.SetTargetIndex(nId);
		end
	else
	tbSuperBao:fnfindNpc(3566,"?????i L??o B???ch");
	end
end					

local bAutoFood=0;
local nTimeLastFood = 0;
function  tbSuperBao.AutoFood1()
	if(not bAutoFood) then
		return;
	end
	local nLevel, nState, nTime = me.GetSkillState(AutoAi.FOOD_SKILL_ID);
	if ((not nTime or nTime < Env.GAME_FPS * 3) and (GetTime() - self.nTimeLastFood > 3)) then
		self:EatFood();
		self.nTimeLastFood = GetTime();
	end
end

function tbSuperBao.CloseHT()
	if UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1 then
		UiManager:CloseWindow(Ui.UI_EQUIPENHANCE);
	end
	if (nCloseUiTimerIdHT > 0) then
		Ui.tbLogic.tbTimer:Close(nCloseUiTimerIdHT);
		nCloseUiTimerIdHT = 0;
	end
end

function tbSuperBao.CloseHP()
	if (UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
		UiManager:CloseWindow(Ui.UI_SHOP);  
	end
	if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
		UiManager:CloseWindow(Ui.UI_SAYPANEL); 
	end
	if (UiManager:WindowVisible(Ui.UI_REPOSITORY) == 1) then
		UiManager:CloseWindow(Ui.UI_REPOSITORY);
	end
	if UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1 then
		UiManager:CloseWindow(Ui.UI_EQUIPENHANCE);
	end
	if (nCloseUiTimerId > 0) then
		Ui.tbLogic.tbTimer:Close(nCloseUiTimerId);
		nCloseUiTimerId = 0;
	end

end

function  tbSuperBao.AutoFood()
	if(not bAutoFood) then
		return;
	end
	local nLevel, nState, nTime = me.GetSkillState(AutoAi.FOOD_SKILL_ID);
	if (not nTime or nTime < Env.GAME_FPS * 3)  then
		tbSuperBao:EatFood();
	end
end

function tbSuperBao:setLeftSkillhh()
	if nSetskillId > 1 then
		if me.IsHaveSkill(nSetskillId) == 1 then
			if me.nLeftSkill ~= nSetskillId and nCheckSkill==1 then
				me.nLeftSkill = nSetskillId
			end
		end
	end	
	if (nSetskillId == 2000 or nSetskillId == 3000) and nCheckSkill==1 then  
		if me.nPkModel == 0 and me.IsHaveSkill(229) == 1 and me.IsHaveSkill(232) == 1 then
		local tbAroundNpc = KNpc.GetAroundNpcList(me, 32);
		local nCountNpcs = 0;
		for _, pNpc in ipairs(tbAroundNpc) do
			local nCanAttack = AutoAi.AiTargetCanAttack(pNpc.nIndex);
				if (nCanAttack == 1) then
				nCountNpcs = nCountNpcs + 1;
			end
		end
			if nCountNpcs >= 3 then
				me.nLeftSkill = 229;
			else
				me.nLeftSkill = 232;
			end
		end
		if me.nPkModel == 0 and me.IsHaveSkill(131) == 1 and me.IsHaveSkill(134) == 1 then
			local tbAroundNpc = KNpc.GetAroundNpcList(me, 32);
			local nCountNpcs = 0;
			for _, pNpc in ipairs(tbAroundNpc) do
				local nCanAttack = AutoAi.AiTargetCanAttack(pNpc.nIndex);
				if (nCanAttack == 1) then
					nCountNpcs = nCountNpcs + 1;
				end
			end
			if nCountNpcs >= 3 then
				me.nLeftSkill = 131;
			else
			me.nLeftSkill = 134;
		end
    end
	end 
end

function  tbSuperBao.EatFood()
	local tbItemList = me.FindItemInBags(Item.SKILLITEM);
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
function tbSuperBao.PhuChk() 
	local tbItem = me.FindItemInBags(18,1,309,1)[1] or me.FindItemInBags(18,1,310,1)[1] or me.FindItemInBags(18,1,13,1)[1] or me.FindItemInBags(18,1,235,1)[1] or me.FindItemInBags(18,1,12,1)[1] or me.FindItemInBags(18,1,195,1)[1] or me.FindItemInBags(18,1,316,1)[1] or me.FindItemInBags(18,1,315,1)[1] or me.FindItemInBags(18,1,18,1)[1] or me.FindItemInBags(18,1,234,1)[1] or me.FindItemInBags(18,1,23,1)[1] or me.FindItemInBags(18,1,7,1)[1];
	if tbItem then
		nPhuChk = 1
	else 
		nPhuChk = 0
	end	
end

function tbSuperBao:Horse()
	local tbSkillInfo	= KFightSkill.GetSkillInfo(me.nLeftSkill, 1);
	local bChecked = me.GetNpc().IsRideHorse();
	if me.nAutoFightState ~= 1 and bChecked == 0 then
		Switch([[horse]])
	end
	if me.nAutoFightState == 1 and nHorse==1 and bChecked == 1 then
		Switch([[horse]])
		return
	end
	if me.nAutoFightState ~= 1 or nHorse==1 or bChecked == 0 then
		return
	end
	for i = 0,#hhFindSkillList do
		local nFindSkill = hhFindSkillList[i]
		if me.IsHaveSkill(nFindSkill) == 1 and bChecked == 0 then
			Switch([[horse]])
		end
		if not me.IsHaveSkill(nFindSkill) == 1 then
			if (me.nFaction == 1 or me.nFaction == 3 or me.nFaction == 4 or me.nFaction == 5 or me.nFaction == 8 or me.nFaction == 11) and  bChecked == 1 then
			Switch([[horse]])
			end
		end
		if (me.nFaction == 2 or me.nFaction == 6 or me.nFaction == 7 or me.nFaction == 9 or me.nFaction == 10  or me.nFaction == 12) and bChecked == 1 then  
			Switch([[horse]])
		end	
	end
end

function tbSuperBao:AutoPhu()
		local nCount_TTPc1 = me.GetItemCountInBags(18,1,309,1);  
		local nCount_TTPc2 = me.GetItemCountInBags(18,1,310,1); 	
		local nCount_TTPc3 = me.GetItemCountInBags(18,1,13,1); 		
		local nCount_TTPc4 = me.GetItemCountInBags(18,1,235,1); 	
		local nCount_TTPc5 = me.GetItemCountInBags(18,1,12,1);  	
		local nCount_TTPc6 = me.GetItemCountInBags(18,1,195,1);  	
		local nCount_HTPc1 = me.GetItemCountInBags(18,1,316,1); 	
		local nCount_HTPc2 = me.GetItemCountInBags(18,1,315,1);  	
		local nCount_HTPc3 = me.GetItemCountInBags(18,1,18,1); 		
		local nCount_HTPc4 = me.GetItemCountInBags(18,1,234,1); 	
		local nCount_HTPc5 = me.GetItemCountInBags(18,1,23,1);  	
		local nCountHTP = me.GetItemCountInBags(18,1,7,1); 
		if  nCount_TTPc1 > 0 then
			nSetPhu = 0 ;
			nSetHTPId = 309 ;
			return 0;
		elseif  nCount_TTPc2 > 0 then
			nSetPhu = 0 ;
			nSetHTPId = 310 ;
			return 0;
		elseif  nCount_TTPc3 > 0 then
			nSetPhu = 0 ;
			nSetHTPId = 13 ;
			return 0;
		elseif  nCount_TTPc4 > 0 then
			nSetPhu = 0 ;
			nSetHTPId = 235 ;
			return 0;
		elseif  nCount_TTPc5 > 0 then
			nSetPhu = 0 ;
			nSetHTPId = 12 ;
			return 0;
		elseif  nCount_TTPc6 > 0 then
			nSetPhu = 0 ;
			nSetHTPId = 195 ;
			return 0;
		elseif  nCount_HTPc1 > 0 then
			nSetPhu = 1 ;
			nSetHTPId = 316 ;
			return 0;
		elseif  nCount_HTPc2 > 0 then
			nSetPhu = 1 ;
			nSetHTPId = 315 ;
			return 0;
		elseif  nCount_HTPc3 > 0 then
			nSetPhu = 1 ;
			nSetHTPId = 18 ;
			return 0;
		elseif  nCount_HTPc4 > 0 then
			nSetPhu = 1 ;
			nSetHTPId = 234 ;
			return 0;
		elseif  nCount_HTPc5 > 0 then
			nSetPhu = 1 ;
			nSetHTPId = 23 ;
			return 0;
		else 
			nSetPhu = 1 ;
			nSetHTPId = 7 ;
			return 0;
		end
end

function tbSuperBao:ve()
	local PhuItemF = me.FindItemInBags(18,1,309,1)[1] or me.FindItemInBags(18,1,310,1)[1] or me.FindItemInBags(18,1,13,1)[1] or me.FindItemInBags(18,1,235,1)[1] or me.FindItemInBags(18,1,12,1)[1] or me.FindItemInBags(18,1,195,1)[1] or me.FindItemInBags(18,1,316,1)[1] or me.FindItemInBags(18,1,315,1)[1] or me.FindItemInBags(18,1,18,1)[1] or me.FindItemInBags(18,1,234,1)[1] or me.FindItemInBags(18,1,23,1)[1] or me.FindItemInBags(18,1,7,1)[1];
	local PhuItem = me.FindItemInBags(18,1,309,1)[1] or me.FindItemInBags(18,1,310,1)[1] or me.FindItemInBags(18,1,13,1)[1] or me.FindItemInBags(18,1,235,1)[1] or me.FindItemInBags(18,1,12,1)[1] or me.FindItemInBags(18,1,195,1)[1] or me.FindItemInBags(18,1,316,1)[1] or me.FindItemInBags(18,1,315,1)[1] or me.FindItemInBags(18,1,18,1)[1] or me.FindItemInBags(18,1,234,1)[1] or me.FindItemInBags(18,1,23,1)[1];
	local PhuItem2 = me.FindItemInBags(18,1,7,1)[1];
	local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
	local nX1 = nTrainWorldPosX 
	local nY1 = nTrainWorldPosY 
	local tbPosInfo ={}
	tbPosInfo.szType = "pos"
	tbPosInfo.szLink = "??i???m v???,"..nTrainMapId..","..Traindx..","..Traindy
	if ((nMapId <30 and nMapId >22) or (nMapId<9 and nMapId>0)) then
		UiManager:StartBao();
		if bgua==1 then 
			UiManager:StopBao();
		end
		if (nve > 0) then
			Ui.tbLogic.tbTimer:Close(nve);
		end
			nve =0
	elseif nMapId == nTrainMapId and (nCurWorldPosX ~= Traindx or nCurWorldPosY ~= Traindy) and (Traindx~=0 or Traindy~=0) then
		Ui.tbLogic.tbAutoPath:GotoPos({nMapId=nTrainMapId,nX=Traindx,nY=Traindy})  ---OK
	elseif nMapId == nTrainMapId  and (Traindx==0 or Traindy==0) then 
				local function fngobao()
					local nMap = me.GetMapTemplateId();
					if nMap >29 then 
						tbSuperBao:fnfindNpc(3574,"D?? Luy???n ?????i S??");
					end
					return 0
				end
				local M1, X1, Y1 = me.GetWorldPos();
					local function fngotr()
						if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
							return
						end
						if (nX1-X1)< 30 and (nY1-Y1)< 30 then
						me.StartAutoPath(nX1+35, nY1+35);
						Ui.tbLogic.tbTimer:Register(80, fngobao); 
						if (AutoPath > 0) then
							Ui.tbLogic.tbTimer:Close(AutoPath);
							AutoPath = 0;
						end
						return 0
						end
					end
				if AutoPath==0 then	
					AutoPath=Ui.tbLogic.tbTimer:Register(15 * Env.GAME_FPS, fngotr); 
				end
				me.StartAutoPath(nX1-35, nY1-35);
				if (nX1-X1)> 30 and (nY1-Y1)> 30 then
					if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
							return
					end
					Ui.tbLogic.tbTimer:Register(18, fngobao); 
				end
	elseif (nMapId == nTrainMapId and nCurWorldPosX == Traindx and nCurWorldPosY == Traindy) or (nMapId ~= nTrainMapId) then
		if PhuItemF then
			if (nCloseActionType == 0) then
				nCloseActionType = Ui.tbLogic.tbTimer:Register(2 * Env.GAME_FPS, tbSuperBao.GoTest);
			end
		elseif not PhuItemF then
			tbSuperBao:GoBao()
			if (nve > 0) then
				Ui.tbLogic.tbTimer:Close(nve);
			end
			nve =0;
		end
	end			
end
function tbSuperBao:CloseShop()
	if UiManager:WindowVisible(Ui.UI_SHOP) == 1 then
		UiManager:CloseWindow(Ui.UI_SHOP);
		UiManager:CloseWindow(Ui.UI_ITEMBOX);
	end	
end

function tbSuperBao:OnSay(szChannelName, szSendName, szMsg)
szMsgAutoRemote = KFile.ReadTxtFile("\\user\\sprBao\\Remote.lua");
	if (szChannelName == "Personal")  and (string.sub(szMsg, 1, 6) == "THOAT ") and (string.sub(szMsg, 7, 100) == szMsgAutoRemote) then
			Exit();
		if me.nAutoFightState == 1 then
			AutoAi.ProcessHandCommand("auto_fight", 0);
			if bgua==1 then UiManager:StopBao(); 
			end
			UiManager:StopBao();
			nGuaeReg1=Ui.tbLogic.tbTimer:Register(3.0*Env.GAME_FPS, self.OnTimer_Gua1,self,nTrainMapId,nTrainWorldPosX,nTrainWorldPosY);
			Ui.tbLogic.tbTimer:Register(400, tbSuperBao.Thoat, self)
		elseif me.nAutoFightState == 0  then
			if bgua==1 then UiManager:StopBao(); 
			end
			UiManager:StopBao();
			Ui.tbLogic.tbTimer:Register(400, tbSuperBao.Thoat, self)
		end
	end	
	if (szChannelName == "Personal")  and (string.sub(szMsg, 1, 7) == "BATBVD ") and (string.sub(szMsg, 8, 100) == szMsgAutoRemote) then
		Ui.tbLogic.tbTimer:Register(20, tbSuperBao.ve, self)
	end

	if (szChannelName == "Personal")  and (string.sub(szMsg, 1, 7) == "TATBVD ") and (string.sub(szMsg, 8, 100) == szMsgAutoRemote) then
		UiManager:StopBao();
		if (nGuaeReg1 > 0) then
				Ui.tbLogic.tbTimer:Close(nGuaeReg1);
		end
		if bgua==1 then 
		UiManager:StopBao();
		end
	end
	if (szChannelName == "Personal")  and (string.sub(szMsg, 1, 9) == "BATTRAIN ") and (string.sub(szMsg, 10, 100) == szMsgAutoRemote) then
		UiManager:StopBao();
		if me.nAutoFightState == 1 then
		AutoAi.ProcessHandCommand("auto_fight", 0);
		elseif bgua==0 then UiManager:StartGua(); 
		end
	end
	if (szChannelName == "Personal")  and (string.sub(szMsg, 1, 9) == "TATTRAIN ") and (string.sub(szMsg, 10, 100) == szMsgAutoRemote) then
		nGuaeReg1=Ui.tbLogic.tbTimer:Register(4.0*Env.GAME_FPS, self.OnTimer_Gua1,self,nTrainMapId,nTrainWorldPosX,nTrainWorldPosY);
		UiManager:StopBao();
		if me.nAutoFightState == 1 then
		AutoAi.ProcessHandCommand("auto_fight", 0);
		elseif bgua==1 then 
		UiManager:StopBao();
		end
	end
	if (szChannelName == "Personal")  and (string.sub(szMsg, 1, 10) == "BATTUDANH ") and (string.sub(szMsg, 11, 100) == szMsgAutoRemote) then
		local nMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
		UiManager:StopBao();
		if me.nAutoFightState == 0 and nMapId > 30 then
		AutoAi.ProcessHandCommand("auto_fight", 1);
		elseif bgua==1 then UiManager:StopBao(); 
		end
	end
	if (szChannelName == "Personal")  and (string.sub(szMsg, 1, 10) == "TATTUDANH ") and (string.sub(szMsg, 11, 100) == szMsgAutoRemote) then
		UiManager:StopBao();
		if me.nAutoFightState == 1 then
		AutoAi.ProcessHandCommand("auto_fight", 0);
		elseif bgua==1 then UiManager:StopBao(); 
		end
	end
	if (szChannelName == "Personal")  and (string.sub(szMsg, 1, 2) == "? ") and (string.sub(szMsg, 3, 100) == szMsgAutoRemote) then
		if bgua==1 or me.nAutoFightState == 1 then 
		SendChatMsg("/"..szSendName.." ??ang Luy???n C??ng ... ");
		elseif (nTimerId ~= 0 and bgua==0) then
		SendChatMsg("/"..szSendName.." ??ang l??m Bao V???n ?????ng... ");
		elseif me.nAutoFightState ~= 1 and me.nCurLife < me.nMaxLife then 
		SendChatMsg("/"..szSendName.." ??ang b??? t???n c??ng... ");
		else
		SendChatMsg("/"..szSendName.." ??ang ?????ng ch??i ... ");
		end
	end
	if (szChannelName == "Personal")  and (string.sub(szMsg, 1, 3) == "TD ") and (string.sub(szMsg, 4, 100) == szMsgAutoRemote) then
		local nMapId, x, y	= me.GetWorldPos();
		local szPosText	= "";
		szPosText	= string.format(" ??ang ?????? %s (%d,%d)", GetMapNameFormId(nMapId), x / 8, y / 16);
		SendChatMsg("/"..szSendName.." "..szPosText);
	end
	if (szChannelName == "Personal")  and (string.sub(szMsg, 1, 9) == "BIENKINH ") and (string.sub(szMsg, 10, 100) == szMsgAutoRemote)then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",23,2601,"});
	elseif (szChannelName == "Personal")  and (string.sub(szMsg, 1, 12) == "PHUONGTUONG ") and (string.sub(szMsg, 13, 100) == szMsgAutoRemote)then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",24,2601,"});
	elseif (szChannelName == "Personal")  and (string.sub(szMsg, 1, 11) == "TUONGDUONG ") and (string.sub(szMsg, 12, 100) == szMsgAutoRemote)then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",25,2601,"});
	elseif (szChannelName == "Personal")  and (string.sub(szMsg, 1, 10) == "DUONGCHAU ") and (string.sub(szMsg, 11, 100) == szMsgAutoRemote)then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",26,2601,"});
	elseif (szChannelName == "Personal")  and (string.sub(szMsg, 1, 8) == "THANHDO ") and (string.sub(szMsg, 9, 100) == szMsgAutoRemote)then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",27,2601,"});
	elseif (szChannelName == "Personal")  and (string.sub(szMsg, 1, 6) == "DAILY ") and (string.sub(szMsg, 7, 100) == szMsgAutoRemote)then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",25,2601,"});
	elseif (szChannelName == "Personal")  and (string.sub(szMsg, 1, 6) == "LAMAN ") and (string.sub(szMsg, 7, 100) == szMsgAutoRemote)then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",25,2601,"});
	elseif (szChannelName == "Personal")  and (string.sub(szMsg, 1, 9) == "VANTRUNG ") and (string.sub(szMsg, 10, 100) == szMsgAutoRemote)then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",1,2601,"});
	elseif (szChannelName == "Personal")  and (string.sub(szMsg, 1, 8) == "LONGMON ") and (string.sub(szMsg, 9, 100) == szMsgAutoRemote)then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",2,2601,"});
	elseif (szChannelName == "Personal")  and (string.sub(szMsg, 1, 8) == "VINHLAC ") and (string.sub(szMsg, 9, 100) == szMsgAutoRemote)then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",3,2601,"});
	elseif (szChannelName == "Personal")  and (string.sub(szMsg, 1, 9) == "DAOHUONG ") and (string.sub(szMsg, 10, 100) == szMsgAutoRemote)then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",4,2601,"});
	elseif (szChannelName == "Personal")  and (string.sub(szMsg, 1, 9) == "GIANGTAN ") and (string.sub(szMsg, 10, 100) == szMsgAutoRemote)then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",5,2601,"});
	elseif (szChannelName == "Personal")  and (string.sub(szMsg, 1, 8) == "THACHCO ") and (string.sub(szMsg, 9, 100) == szMsgAutoRemote)then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",6,2601,"});
	elseif (szChannelName == "Personal")  and (string.sub(szMsg, 1, 10) == "LONGTUYEN ") and (string.sub(szMsg, 11, 100) == szMsgAutoRemote)then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",7,2601,"});
	elseif (szChannelName == "Personal")  and (string.sub(szMsg, 1, 7) == "BALANG ") and (string.sub(szMsg, 8, 100) == szMsgAutoRemote)then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",8,2601,"});
	end
end
function tbSuperBao:Thoat()
	Exit();
	return 0
end

function tbSuperBao:go2()
	Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",23,2601,"});
	return 0
end
tbSuperBao.OnTimer_Gua1 = function(self,nMapId,nPosX,nPosY)
		local jMapId, nCurWorldPosX, nCurWorldPosY = me.GetWorldPos();
		local nX1 = nPosX 
		local nY1 = nPosY 
		local tbPosInfo ={}
			tbPosInfo.szType = "pos"
			tbPosInfo.szLink = "Treo,"..nMapId..","..Traindx..","..Traindy
		if jMapId == nMapId and (nCurWorldPosX ~= Traindx or nCurWorldPosY ~= Traindy) then
			Ui.tbLogic.tbAutoPath:GotoPos({nMapId=nMapId,nX=Traindx,nY=Traindy}) 
		end
		if (jMapId == nMapId and nCurWorldPosX == Traindx and nCurWorldPosY == Traindy) or (nMapId <30 and nMapId >0) then
			Ui.tbLogic.tbTimer:Register(10, tbSuperBao.go2, self)
			if (nGuaeReg1 > 0) then
				Ui.tbLogic.tbTimer:Close(nGuaeReg1);
			end
			nGuaeReg1 =0
		return 0;	
		end
		if (jMapId ~= nMapId) then
		Ui.tbLogic.tbTimer:Register(10, tbSuperBao.go2, self)
			if (nGuaeReg1 > 0) then
				Ui.tbLogic.tbTimer:Close(nGuaeReg1);
			end
			nGuaeReg1 =0
		return 0;	
		end
end	

function tbSuperBao:CheckItem()
    for j = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nLine - 1 do
		for i = 0, Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRow - 1 do
			local pItem = me.GetItem(Ui(Ui.UI_ITEMBOX).tbMainBagCont.nRoom, i, j);
			if pItem then
                    local function fnStopBao()
								tbSuperBao:OpenExtBag()
								Ui.tbLogic.tbTimer:Close(self.nTimerRegisterId);
								if (nTimerId  ~= 0) then
								UiManager:StopBao();
								end
								if bgua==1 then UiManager:StopBao(); 
								end
							return 0
					end
					if pItem.szName=="Nhang tr???m"  or pItem.szName=="L?? H????ng" or pItem.szName=="Gia th?? th???n b??"  or pItem.szName=="T??i nhi???m v???" or pItem.szName=="Th??nh Ng???n" or  pItem.szName=="T?? Linh" or pItem.szName=="T??? Bi T??m Kinh" then
                    Ui.tbLogic.tbTimer:Register(15, fnStopBao);
					UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>C?? v???t ph???m [<bclr=red><color=white>"..pItem.szName.."<bclr=blue><color=white>] nh???m l???n v???i Ph?? b??n h??nh trang ch??nh")
					me.Msg("<color=yellow>H???y c???t ho???c h???y [<color><bclr=red><color=white>"..pItem.szName.."<bclr><color=yellow>] trong h??nh trang ch??nh");
					end
			end
		end
	end
end
function tbSuperBao:CheckItem1()
	if (UiManager:WindowVisible(Ui.UI_EXTBAG1) == 1) then
    for j = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nLine - 1 do
		for i = 0, Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRow - 1 do
			local pItem = me.GetItem(Ui(Ui.UI_EXTBAG1).tbExtBagCont.nRoom, i, j);
			if pItem then
                    local function fnStopBao1()
								tbSuperBao:OpenExtBag()
								Ui.tbLogic.tbTimer:Close(self.nTimerRegisterId);
								if (nTimerId  ~= 0) then
								UiManager:StopBao();
								end
								if bgua==1 then UiManager:StopBao(); 
								end
							return 0
					end
					if pItem.szName=="Nhang tr???m"  or pItem.szName=="L?? H????ng" or pItem.szName=="Gia th?? th???n b??"  or pItem.szName=="T??i nhi???m v???" or pItem.szName=="Th??nh Ng???n" or  pItem.szName=="T?? Linh" or pItem.szName=="T??? Bi T??m Kinh" then
                    Ui.tbLogic.tbTimer:Register(15, fnStopBao1);
					UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>C?? v???t ph???m [<bclr=red><color=white>"..pItem.szName.."<bclr=blue><color=white>] nh???m l???n v???i Ph?? b??n h??nh trang ph??? 1")
					me.Msg("<color=yellow>H???y c???t ho???c h???y [<color><bclr=red><color=white>"..pItem.szName.."<bclr><color=yellow>] trong h??nh trang ph??? 1");
					end
			end
		end
	end
	end
end
function tbSuperBao:CheckItem2()
 if (UiManager:WindowVisible(Ui.UI_EXTBAG2) == 1) then
    for j = 0, Ui(Ui.UI_EXTBAG2).tbExtBagCont.nLine - 1 do
		for i = 0, Ui(Ui.UI_EXTBAG2).tbExtBagCont.nRow - 1 do
			local pItem = me.GetItem(Ui(Ui.UI_EXTBAG2).tbExtBagCont.nRoom, i, j);
			if pItem then
                    local function fnStopBao2()
								tbSuperBao:OpenExtBag()
								Ui.tbLogic.tbTimer:Close(self.nTimerRegisterId);
								if (nTimerId  ~= 0) then
								UiManager:StopBao();
								end
								if bgua==1 then UiManager:StopBao(); 
								end
							return 0
					end
					if pItem.szName=="Nhang tr???m"  or pItem.szName=="L?? H????ng" or pItem.szName=="Gia th?? th???n b??"  or pItem.szName=="T??i nhi???m v???" or pItem.szName=="Th??nh Ng???n" or  pItem.szName=="T?? Linh" or pItem.szName=="T??? Bi T??m Kinh" then
                    Ui.tbLogic.tbTimer:Register(15, fnStopBao2);
					UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>C?? v???t ph???m [<bclr=red><color=white>"..pItem.szName.."<bclr=blue><color=white>] nh???m l???n v???i Ph?? b??n h??nh trang ph??? 2")
					me.Msg("<color=yellow>H???y c???t ho???c h???y [<color><bclr=red><color=white>"..pItem.szName.."<bclr><color=yellow>] trong h??nh trang ph??? 2");
					end
			end
		end
	end
 end	
end
function tbSuperBao:CheckItem3()
if (UiManager:WindowVisible(Ui.UI_EXTBAG3) == 1) then
    for j = 0, Ui(Ui.UI_EXTBAG3).tbExtBagCont.nLine - 1 do
		for i = 0, Ui(Ui.UI_EXTBAG3).tbExtBagCont.nRow - 1 do
			local pItem = me.GetItem(Ui(Ui.UI_EXTBAG3).tbExtBagCont.nRoom, i, j);
			if pItem then
                    local function fnStopBao3()
								tbSuperBao:OpenExtBag()
								Ui.tbLogic.tbTimer:Close(self.nTimerRegisterId);
								if (nTimerId  ~= 0) then
								UiManager:StopBao();
								end
								if bgua==1 then UiManager:StopBao(); 
								end
							return 0
					end
					local function fnclose()
							if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then
								UiManager:CloseWindow(Ui.UI_ITEMBOX);
							end
						return 0
					end
					if pItem.szName=="Nhang tr???m"  or pItem.szName=="L?? H????ng" or pItem.szName=="Gia th?? th???n b??"  or pItem.szName=="T??i nhi???m v???" or pItem.szName=="Th??nh Ng???n" or  pItem.szName=="T?? Linh" or pItem.szName=="T??? Bi T??m Kinh" then
                    Ui.tbLogic.tbTimer:Register(15, fnStopBao3);
					UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>C?? v???t ph???m [<bclr=red><color=white>"..pItem.szName.."<bclr=blue><color=white>] nh???m l???n v???i Ph?? b??n h??nh trang ph??? 3")
					me.Msg("<color=yellow>H???y c???t ho???c h???y [<color><bclr=red><color=white>"..pItem.szName.."<bclr><color=yellow>] trong h??nh trang ph??? 3");
					else
					Ui.tbLogic.tbTimer:Register(100, fnclose);
					end
			end
		end
	end
end	
end

function tbSuperBao:ActiveBaoT1()
	local kMapId,kX,kY = me.GetWorldPos();
		local function fnActiveBaoT1()
				local mkMapId,mkX,mkY = me.GetWorldPos();
				if mkMapId==kMapId and mkX==kX and mkY==kY then
				tbSuperBao:ActiveBao();
				end
		end
		local function fnActiveBaoT2()
		local nkMapId,nkX,nkY = me.GetWorldPos();
			if (nkMapId~=kMapId or nkX~=kX or nkY~=kY) and ActiveTimeT1 > 0 then
				Ui.tbLogic.tbTimer:Close(ActiveTimeT1);
				Ui.tbLogic.tbTimer:Close(ActiveTimeT2);
				ActiveTimeT1 =0
				ActiveTimeT2 =0
			end
		end
	if  ((kMapId <30 and kMapId >22) or (kMapId<9 and kMapId>0)) and (nActive  == 1) then 
			ActiveTimeT1 = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 60, fnActiveBaoT1);
			ActiveTimeT2 = Ui.tbLogic.tbTimer:Register(Env.GAME_FPS * 5, fnActiveBaoT2);
	end
end

function tbSuperBao:ActiveBao()
	local aMapId,aX,aY = me.GetWorldPos();
	if  ((aMapId <30 and aMapId >22) or (aMapId<9 and aMapId>0)) and (nActive  == 1) then 
		local function fngobaoc1()
			local nId = tbSuperBao:GetAroundNpcId(3573)
			if nId and (UiManager:WindowVisible(Ui.UI_ITEMGIFT) == 1) then 
				self:StopBao();
				tbSuperBao:CloseHP();
				UiManager:StartGua();
			else	
				UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=White>K??ch ho???t Bao V???n ?????ng")
				self:StopBao();
				self:StartBao();
			end
			Ui.tbLogic.tbTimer:Close(ActiveTimeT1);
			Ui.tbLogic.tbTimer:Close(ActiveTimeT2);
			ActiveTimeT1 =0
			ActiveTimeT2 =0
			return 0
		end
	tbSuperBao:CloseHP();
	Ui.tbLogic.tbTimer:Register(10 * Env.GAME_FPS, fngobaoc1);
	end
end
tbSuperBao:ModifyUi()
tbSuperBao:mInit();
me.Msg("<bclr=255,100,0><color=white>Bao V???n ?????ng<bclr=pink><color=white> [5-5-2011] <bclr=255,100,0><color=white> OK !");

function tbSuperBao:Run4TSwitch()
	if nTime4State == 0 then
		nTime4State = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>B???t 1 ph??t s??? reset BVD<color>");
		me.Msg("<color=yellow>B???t<color>");
		nTimerId1 = Ui.tbLogic.tbTimer:Register(240 * Env.GAME_FPS,self.Run4Minute,self);
	else
		nTime4State = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>T???t 1 ph??t s??? reset BVD<color>");
		me.Msg("<color=yellow>T???t<color>");
		Ui.tbLogic.tbTimer:Close(nTimerId1);
		nTimerId1 = 0;
	end
end

function tbSuperBao:Run4Minute()
UiManager:StopBao();
UiManager:StartBao();
end

function tbSuperBao:Check4Start()
	if nTime4State == 0 then
		tbSuperBao:Run4TSwitch();
		end
	end

function tbSuperBao:Check4Stop()
	if nTime4State == 1 then
		tbSuperBao:Run4TSwitch();
		end
	end


