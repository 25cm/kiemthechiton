---------------------------------------------------------------------
--Author:	火花的雨春天
--Time:		2010.11.30
--时光之轮转动如常，岁月来去如风，残留的记忆变为传说，传说又慢慢成为神话;
--而当其诞生的纪元再度循环降临时，连神话也早已被遗忘。
--但我依然记得我爱你。
--耍耍优化于：20110520
--重载：??Ui:GetClass("MPGua"):ReLoad1()
----------------------------------------------------------------------

local tbMPGua = Ui:GetClass("MPGua");
local self=tbMPGua;
local nDenJi = 5;				--有5玄就合

tbMPGua.BTN_CLOSE	="BtnClose";
tbMPGua.BTN_POS1	="BtnPos1";
tbMPGua.EDT_POS1	="EdtPos1";
tbMPGua.BTN_POS2	="BtnPos2";
tbMPGua.EDT_POS2	="EdtPos2";
tbMPGua.BTN_POS3	="BtnPos3";
tbMPGua.EDT_POS3	="EdtPos3";
tbMPGua.BTN_POS4	="BtnPos4";
tbMPGua.EDT_POS4	="EdtPos4";
tbMPGua.BTN_POS5	="BtnPos5";
tbMPGua.EDT_POS5	="EdtPos5";
tbMPGua.BTN_POS6	="BtnPos6";
tbMPGua.EDT_POS6	="EdtPos6";
tbMPGua.BTN_POS7	="BtnPos7";
tbMPGua.EDT_POS7	="EdtPos7";
tbMPGua.BTN_POS8	="BtnPos8";
tbMPGua.EDT_POS8	="EdtPos8";
tbMPGua.BTN_POS9	="BtnPos9";
tbMPGua.EDT_POS9	="EdtPos9";
tbMPGua.BTN_POS10	="BtnPos10";
tbMPGua.EDT_POS10	="EdtPos10";
tbMPGua.BTN_POS11	="BtnPos11";
tbMPGua.EDT_POS11	="EdtPos11";
tbMPGua.BTN_POS12	="BtnPos12";
tbMPGua.EDT_POS12	="EdtPos12";

tbMPGua.BTN_RED1	="BtnRedDrug1";
tbMPGua.BTN_RED2	="BtnRedDrug2";
tbMPGua.EDT_REDNUM	="EdtRedDrugNum";
tbMPGua.BTN_BLUE1	="BtnBlueDrug1";
tbMPGua.BTN_BLUE2	="BtnBlueDrug2";
tbMPGua.EDT_BLUENUM	="EdtBlueDrugNum";	--Mua Mana

tbMPGua.BTN_HX1		="BtnHeXuan1";		--皇陵3合玄？
tbMPGua.BTN_YMZ		="BtnYeMingZhu";	--皇陵3夜明珠？
tbMPGua.BTN_BuyCai1	="BtnBuyCai1";		--皇陵3买菜修炼？

tbMPGua.BTN_HX2		="BtnHeXuan2";		--普通挂机点合玄？
tbMPGua.BTN_BUYCAI2	="BtnBuyCai2"		--普通挂机点买菜？
tbMPGua.EDT_CAINUM	="EdtCaiNum";		--普通挂机点菜数量？
tbMPGua.BTN_FIREWAIT	="BtnFireWait";		--普通挂机点篝火等待？

tbMPGua.BTN_START	="BtnStart";		--开启
tbMPGua.BTN_SAVE	="BtnSave";		--保存
tbMPGua.BTN_RESET	="BtnReset";		--重置
tbMPGua.TXT_POS		="TxtPosInfo";		--提示挂机地点

tbMPGua.tbPos		={};
tbMPGua.nState		=0;
tbMPGua.nCurPos		=0;

tbMPGua.nTimes		=0;

tbMPGua.nMapId		=0;
tbMPGua.nRedDrugType	=2;	--1:回天丹 2：九转丹
tbMPGua.nBlueDrugType	=2;	--1:七巧丹 2：五花丸
tbMPGua.nRedNum		=-1;
tbMPGua.nBlueNum	=-1;
tbMPGua.nHX1		=1;
tbMPGua.nYeMingZhu	=0;

tbMPGua.nHX2		=0;
tbMPGua.nBuyCai		=1;
tbMPGua.nCaiNum		=6;
tbMPGua.nFireWait	=1;
tbMPGua.nConfFile	=0;		--设置选择

tbMPGua.bAutoClose	=0;

tbMPGua.nCountDead	=0;

local mypos		=0;
local nSkillId		=0;	--光环技能

local nPao = 0

function tbMPGua:OnOpen()
	if(self.nState==0) then
		self:Load();
	end
	for i=1,#self.tbPos do
		Edt_SetTxt(self.UIGROUP, "EdtPos"..i, "("..self.tbPos[i][1]..","..self.tbPos[i][2]..")");		
	end

	if(self.nRedDrugType==1) then
		Btn_Check(self.UIGROUP,self.BTN_RED1,1);
	else
		Btn_Check(self.UIGROUP,self.BTN_RED2,1);	
	end

	if(self.nBlueDrugType==1) then
		Btn_Check(self.UIGROUP,self.BTN_BLUE1,1);
	else
		Btn_Check(self.UIGROUP,self.BTN_BLUE2,1);	
	end

	Btn_Check(self.UIGROUP,self.BTN_HX1,self.nHX1);
	Btn_Check(self.UIGROUP,self.BTN_YMZ,self.nYeMingZhu);
	Edt_SetInt(self.UIGROUP,self.EDT_REDNUM,self.nRedNum);
	Edt_SetInt(self.UIGROUP,self.EDT_BLUENUM,self.nBlueNum);

	if(self.nRedNum==-1) then
		Edt_SetInt(self.UIGROUP, self.EDT_REDNUM, 2);		
	end

	if(self.nBlueNum==-1)	then
		Edt_SetInt(self.UIGROUP, self.EDT_BLUENUM, 0);
	end

	Btn_Check(self.UIGROUP,self.BTN_BUYCAI2,self.nBuyCai);
	Edt_SetInt(self.UIGROUP,self.EDT_CAINUM,self.nCaiNum);
	Btn_Check(self.UIGROUP,self.BTN_HX2,self.nHX2);
	Btn_Check(self.UIGROUP,self.BTN_FIREWAIT,self.nFireWait);

	if(self.nState==0) then
			Btn_SetTxt(self.UIGROUP, self.BTN_START, "Bắt Đầu");
			Wnd_SetEnable(self.UIGROUP,self.BTN_RESET,1);	
			Wnd_SetEnable(self.UIGROUP,self.BTN_RED1,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_RED2,1);
			Wnd_SetEnable(self.UIGROUP,self.EDT_REDNUM,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BLUE1,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BLUE2,1);
			Wnd_SetEnable(self.UIGROUP,self.EDT_BLUENUM,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_HX1,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_YMZ,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BUYCAI2,1);
			Wnd_SetEnable(self.UIGROUP,self.EDT_CAINUM,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_HX2,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_FIREWAIT,1);

	else
			for i=1,12 do
				Wnd_SetEnable(self.UIGROUP,"BtnPos"..i,0);
				Wnd_SetEnable(self.UIGROUP,"EdtPos"..i,0);
			end
			Wnd_SetEnable(self.UIGROUP,self.BTN_RESET,0);	
			Btn_SetTxt(self.UIGROUP, self.BTN_START, "Dừng");
			Wnd_SetEnable(self.UIGROUP,self.BTN_RED1,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_RED2,0);
			Wnd_SetEnable(self.UIGROUP,self.EDT_REDNUM,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BLUE1,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BLUE2,0);
			Wnd_SetEnable(self.UIGROUP,self.EDT_BLUENUM,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_HX1,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_YMZ,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BUYCAI2,0);
			Wnd_SetEnable(self.UIGROUP,self.EDT_CAINUM,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_HX2,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_FIREWAIT,0);
	end

        Btn_Check(self.UIGROUP,self.BTN_BuyCai1,1);
	Wnd_SetEnable(self.UIGROUP,self.BTN_BuyCai1,0);
	if(self.nMapId>0) then
		Txt_SetTxt(self.UIGROUP, self.TXT_POS,"【"..GetMapNameFormId(self.nMapId).."】");
	end
end

function tbMPGua:OnClose()
end

function tbMPGua:OnButtonClick(szWnd, nParam)
	if szWnd == self.BTN_START then					--开关，我讨厌面板
		self:MPGstart();
		if(self.nState==0) then
			for i=1,12 do
				Wnd_SetEnable(self.UIGROUP,"BtnPos"..i,1);
				Wnd_SetEnable(self.UIGROUP,"EdtPos"..i,1);
			end
			Btn_SetTxt(self.UIGROUP, self.BTN_START, "Bắt Đầu");
			Wnd_SetEnable(self.UIGROUP,self.BTN_RESET,1);	
			Wnd_SetEnable(self.UIGROUP,self.BTN_RED1,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_RED2,1);
			Wnd_SetEnable(self.UIGROUP,self.EDT_REDNUM,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BLUE1,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BLUE2,1);
			Wnd_SetEnable(self.UIGROUP,self.EDT_BLUENUM,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_HX1,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_YMZ,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BUYCAI2,1);
			Wnd_SetEnable(self.UIGROUP,self.EDT_CAINUM,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_HX2,1);
			Wnd_SetEnable(self.UIGROUP,self.BTN_FIREWAIT,1);
			if(self.nMapId>0) then
				Txt_SetTxt(self.UIGROUP, self.TXT_POS,"【"..GetMapNameFormId(self.nMapId).."】");
			end

		else
			if(self.nMapId==0 or (self.nMapId <30 and self.nMapId >22) or (self.nMapId <9 and self.nMapId >0)) then	
				me.Msg("Thiết Lập Tham Số Lỗi");
				return;
			end

			self.nCountDead=0;

			self.nRedNum	=Edt_GetInt(self.UIGROUP,self.EDT_REDNUM);
			self.nBlueNum	=Edt_GetInt(self.UIGROUP,self.EDT_BLUENUM);
			self.nCaiNum	=Edt_GetInt(self.UIGROUP,self.EDT_CAINUM);
			for i=1,12 do
				Wnd_SetEnable(self.UIGROUP,"BtnPos"..i,0);
				Wnd_SetEnable(self.UIGROUP,"EdtPos"..i,0);
			end

			Btn_SetTxt(self.UIGROUP, self.BTN_START, "Dừng");
			Wnd_SetEnable(self.UIGROUP,self.BTN_RESET,0);	
			Wnd_SetEnable(self.UIGROUP,self.BTN_RED1,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_RED2,0);
			Wnd_SetEnable(self.UIGROUP,self.EDT_REDNUM,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BLUE1,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BLUE2,0);
			Wnd_SetEnable(self.UIGROUP,self.EDT_BLUENUM,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_HX1,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_YMZ,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_BUYCAI2,0);
			Wnd_SetEnable(self.UIGROUP,self.EDT_CAINUM,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_HX2,0);
			Wnd_SetEnable(self.UIGROUP,self.BTN_FIREWAIT,0);
		end

	elseif szWnd == self.BTN_CLOSE then
		UiManager:SwitchWindow(Ui.UI_MULTIPOSGUA);
	elseif szWnd == self.BTN_POS1 then
		local nMapId,nX,nY = me.GetWorldPos();
		self.nMapId=nMapId;
		self.tbPos[1]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS1, "("..nX..","..nY..")");
	elseif szWnd == self.BTN_POS2 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[2]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS2, "("..nX..","..nY..")");
	elseif szWnd == self.BTN_POS3 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[3]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS3, "("..nX..","..nY..")");
	elseif szWnd == self.BTN_POS4 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[4]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS4, "("..nX..","..nY..")");
	elseif szWnd == self.BTN_POS5 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[5]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS5, "("..nX..","..nY..")");
	elseif szWnd == self.BTN_POS6 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[6]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS6, "("..nX..","..nY..")");
	elseif szWnd == self.BTN_POS7 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[7]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS7, "("..nX..","..nY..")");
	elseif szWnd == self.BTN_POS8 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[8]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS8, "("..nX..","..nY..")");
        elseif szWnd == self.BTN_POS9 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[9]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS9, "("..nX..","..nY..")");
        elseif szWnd == self.BTN_POS10 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[10]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS10, "("..nX..","..nY..")");
        elseif szWnd == self.BTN_POS11 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[11]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS11, "("..nX..","..nY..")");
        elseif szWnd == self.BTN_POS12 then
		local _,nX,nY = me.GetWorldPos();
		self.tbPos[12]={nX,nY};
		Edt_SetTxt(self.UIGROUP, self.EDT_POS12, "("..nX..","..nY..")");
	elseif szWnd == self.BTN_RED1 then
		Btn_Check(self.UIGROUP,self.BTN_RED1,1);
        	Btn_Check(self.UIGROUP,self.BTN_RED2,0);		
		self.nRedDrugType=1;
	elseif szWnd == self.BTN_RED2 then
		Btn_Check(self.UIGROUP,self.BTN_RED1,0);
        	Btn_Check(self.UIGROUP,self.BTN_RED2,1);		
		self.nRedDrugType=2;
	elseif szWnd == self.BTN_BLUE1 then
		Btn_Check(self.UIGROUP,self.BTN_BLUE1,1);
        	Btn_Check(self.UIGROUP,self.BTN_BLUE2,0);		
		self.nBlueDrugType=1;
	elseif szWnd == self.BTN_BLUE2 then
		Btn_Check(self.UIGROUP,self.BTN_BLUE1,0);
        	Btn_Check(self.UIGROUP,self.BTN_BLUE2,1);		
		self.nBlueDrugType=2;
	elseif szWnd == self.BTN_HX1 then
		self.nHX1=nParam;
	elseif szWnd == self.BTN_YMZ then
		self.nYeMingZhu=nParam;	
	elseif szWnd == self.BTN_BUYCAI2 then
		self.nBuyCai=nParam;
	elseif szWnd == self.BTN_HX2 then
		self.nHX2=nParam;
	elseif szWnd == self.BTN_FIREWAIT then
		self.nFireWait=nParam;
	elseif szWnd == self.BTN_SAVE then
		self:Save();
	elseif szWnd == self.BTN_RESET then
		for i=1,12 do
			Wnd_SetEnable(self.UIGROUP,"BtnPos"..i,1);
			Wnd_SetEnable(self.UIGROUP,"EdtPos"..i,1);
			Edt_SetTxt(self.UIGROUP, "EdtPos"..i, "");
		end
		self.tbPos={};
		self.nMapId=0;
	end
end

function tbMPGua:MPGstart()		--Bắt Đầu
	if(self.nState==0) then
		self.nState=1;
		self.nCurPos=1;
		self.nTimerId=Ui.tbLogic.tbTimer:Register(0.3* Env.GAME_FPS,self.OnTimer,self);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=pink><color=white>Bắt Đầu Train<color>")
		if (me.nTemplateMapId==1537) or (me.nTemplateMapId==1539) then
			Ui(Ui.UI_TASKTIPS):Begin("Treo Ở đây có thể không hổ trợ thuốc")
		end
	else
		self.nState=0;
		nPao = 0;
		mypos = 0;
		Ui.tbLogic.tbTimer:Close(self.nTimerId);
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=blue><color=white>Đóng Treo Đa Điểm<color>")
		if(me.nAutoFightState == 1 ) then
			AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
		end
	end
end

function tbMPGua:OnTimer()

	self.nTimes=self.nTimes+1;

	if(self.nTimes%25==0) then
		UiManager:OpenWindow("UI_INFOBOARD", string.format("<color=yellow>Tự Động Treo<color>"));
		print("【self.nState="..self.nState.."    mypos="..mypos.."】");
	end


	if(self.bAutoClose==1 and UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
			UiManager:CloseWindow(Ui.UI_SAYPANEL);
			self.bAutoClose=0;
	end

	if(self.bAutoClose==1 and UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
			UiManager:CloseWindow(Ui.UI_SHOP);	
			self.bAutoClose=0;
	end

	if(self.bAutoClose==1 and UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1) then
			UiManager:CloseWindow(Ui.UI_EQUIPENHANCE);
			self.bAutoClose=0;
	end


	if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
		return;		--进度条时不运行
	end

	
	if(self.nState==1) then			--步骤 1

		if(me.nAutoFightState == 1 ) then
			AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
			AutoAi.SetTargetIndex(0);
		end

		if (me.IsDead() == 1) then
			self.nCountDead=self.nCountDead+1;
			me.SendClientCmdRevive(0);
			return ;
		end

		if(self.nTimes%6==0) then
			Txt_SetTxt(self.UIGROUP, self.TXT_POS,"【"..GetMapNameFormId(self.nMapId).."】Di Chuyển "..self.nCurPos.."tới Nơi");
		end

		local nMapId=me.nTemplateMapId;
		if (nMapId>0 and nMapId ~=self.nMapId) then

			Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = ","..self.nMapId..","..self.tbPos[self.nCurPos][1]..","..self.tbPos[self.nCurPos][2]});
			return 2*Env.GAME_FPS;
		end

		local _,nX,nY = me.GetWorldPos();
		if (self.tbPos[self.nCurPos][1]-nX)^2+(self.tbPos[self.nCurPos][2]-nY)^2 > 10000 then
			if me.GetNpc().nIsRideHorse == 0 then
				Switch([[horse]]);
			end				
		end

		if(math.abs(nX-self.tbPos[self.nCurPos][1]) < 5 and math.abs(nY-self.tbPos[self.nCurPos][2]) < 5) then
			self.nState=2;
		else
			me.AutoPath(self.tbPos[self.nCurPos][1],self.tbPos[self.nCurPos][2]);
		end

		self:Check();

	elseif (self.nState==2) then
		if(me.nAutoFightState == 0 ) then
			AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
		end

		if (me.IsDead() == 1) then
			self.nCountDead=self.nCountDead+1;
			me.SendClientCmdRevive(0);
			self.nState=1;
			return ;
		end

		if(me.GetActiveAuraSkill()==0 and nSkillId>0) then
			UseSkill(nSkillId);  
		end

		if(self.nTimes%6==0) then
			Txt_SetTxt(self.UIGROUP, self.TXT_POS,"【"..GetMapNameFormId(self.nMapId).."】Bắt Đầu Ở Điểm "..self.nCurPos.."Đánh NPC");
		end

		local tbAroundNpc= KNpc.GetAroundNpcList(me,300);
		local nCount=0;
		local nWtime=0.3;
		local mX, mY = me.GetNpc().GetMpsPos();
		for i=1,#tbAroundNpc do
			local nX,nY=tbAroundNpc[i].GetMpsPos();

			if(tbAroundNpc[i].nKind==0 and self:GetToNpcDistance(mX, mY,nX,nY) < 700 and AutoAi.AiTargetCanAttack(tbAroundNpc[i].nIndex)==1) then
				nCount=nCount+1;
			end

			if(self.nFireWait==1 and tbAroundNpc[i].nTemplateId==2626) then
				nCount=1;
				break;
			end

			if(tbAroundNpc[i].GetNpcType() == 1 or tbAroundNpc[i].GetNpcType() == 2) then
				nWtime=8;
			end
		end
		
		if(#self.tbPos>1 and nCount<1 and nWtime<5) then
			if(self.nCurPos<#self.tbPos) then
				self.nCurPos=self.nCurPos+1;
			else
				self.nCurPos=1;
			end

			self.nState=1;

		end

		self:Check();

		return nWtime*Env.GAME_FPS;

	elseif (self.nState==3) then

		if(self.nTimes%6==0) then
			Txt_SetTxt(self.UIGROUP, self.TXT_POS,"【"..GetMapNameFormId(self.nMapId).."】Khu an toàn");
		end

		if(me.GetNpc().nIsRideHorse ~= 1) then
			Switch("horse");
		end

		if(me.nAutoFightState == 1 ) then
			AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
			AutoAi.SetTargetIndex(0);
		end

		local _,nX,nY = me.GetWorldPos();

		--回安全区，它的写法是配合下面找NPC的。 这里可加上1层挂机的。

		if(mypos==2 and math.abs(nX-1746)<5 and math.abs(nY-3196)<5) then	--到安全区第2点【秦始皇陵三层】(218.199),1538,1746,3196>
			self.nState=4;
			return;
		end

		if(mypos==1 and math.abs(nX-1762)<5 and math.abs(nY-3191)<5) then	--到安全区第1点【秦始皇陵三层】(220.199),1538,1762,3191>
			mypos=2;
			return;
		end

		if(mypos==0 and math.abs(nX-1789)<3 and math.abs(nY-3240)<3) then	--进安全区第1点【秦始皇陵三层】(223.202),1538,1789,3240>
			mypos=1;
		end

		if(mypos==0) then
			me.AutoPath(1789,3240);
		end

		if(mypos==1) then
			self:MoveTo(1801,3226);		--进入方向走动；
			return	0.1* Env.GAME_FPS;	
		end

		if(mypos==2) then
			self:MoveTo(1746,3196);
			return	0.1* Env.GAME_FPS;		
		end

	elseif (self.nState==4) then	--步骤 4			--到 安全区 合X 买菜 买药 修理 全做... 

		local nIndex_YeSou	=0;
		local nIndex_YeLianShi	=0;

		if(self.nTimes%6==0) then
			Txt_SetTxt(self.UIGROUP, self.TXT_POS,"【"..GetMapNameFormId(self.nMapId).."】Khu an toàn mua máu mana");
		end

		if me.nTemplateMapId == 1538 then
			local tbAroundNpc	= KNpc.GetAroundNpcList(me,200);
			for i=1,#tbAroundNpc do
				if(nIndex_YeSou>0 and nIndex_YeLianShi>0) then
					break;
				end

				if(tbAroundNpc[i].nTemplateId==2447) then  
					nIndex_YeSou=tbAroundNpc[i].nIndex;
				end
				if(tbAroundNpc[i].nTemplateId==3574) then  
					nIndex_YeLianShi=tbAroundNpc[i].nIndex;
				end
			end

			if(nIndex_YeSou==0 or nIndex_YeLianShi==0) then
				return;
			end
		end

		if me.nTemplateMapId == 1536 then
			nIndex_YeSou = UiManager:GetAroundNpcId(2443)
			if not nIndex_YeSou then
				self:MoveTo(1562,3618);
				return
			end

		end

		if(self.nHX1==1) then
			local bHeX,ts=self:HeXuan(nIndex_YeLianShi);
			if(bHeX==1) then
				return ts;
			end
		end

		local nCount_Cai = me.GetItemCountInBags(19,3,1,5);
		if (nCount_Cai< 5 and UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
			me.ShopBuyItem(825, 5-nCount_Cai);
		     	UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIRALL_SEND);
			self.bAutoClose	=1 ;
			return	1* Env.GAME_FPS;
		end

		if(nCount_Cai<5 and UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then	
			AutoAi.SetTargetIndex(nIndex_YeSou);
			return	1* Env.GAME_FPS;
		end

		if (nCount_Cai<5 and UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
			me.AnswerQestion(1);
			self.bAutoClose	=1 ;
			return	1* Env.GAME_FPS;
		end

		local nCount_HuiTianD=me.GetItemCountInBags(17,1,1,4);
		local nCount_JiuZhuanD=me.GetItemCountInBags(17,1,1,5);
		local nCount_DaBuSan=me.GetItemCountInBags(17,2,1,4);
		local nCount_ShouWuD=me.GetItemCountInBags(17,2,1,5);

		if (self.nRedDrugType==1 and self.nBlueDrugType==1 and UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
			me.ShopBuyItem(679, self.nRedNum-nCount_HuiTianD);		--679回天丹 680九转丹 684大补散 685首乌丹 689七巧丹 690五花丸
			me.ShopBuyItem(689, self.nBlueNum-nCount_DaBuSan);
		     	UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIRALL_SEND);
			self.bAutoClose	=1 ;
			return	3* Env.GAME_FPS;
		end

		if (self.nRedDrugType==1 and self.nBlueDrugType==2 and UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
			me.ShopBuyItem(679, self.nRedNum-nCount_HuiTianD);		--679回天丹 680九转丹 684大补散 685首乌丹 689七巧丹 690五花丸
			me.ShopBuyItem(690, self.nBlueNum-nCount_ShouWuD);	
		     	UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIRALL_SEND);
			self.bAutoClose	=1 ;
			return	3* Env.GAME_FPS;
		end

		if (self.nRedDrugType==2 and self.nBlueDrugType==1 and UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
			me.ShopBuyItem(680, self.nRedNum-nCount_JiuZhuanD);
			me.ShopBuyItem(689, self.nBlueNum-nCount_DaBuSan);		--679回天丹 680九转丹 684大补散 685首乌丹 689七巧丹 690五花丸
		     	UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIRALL_SEND);
			self.bAutoClose	=1 ;
			return	3* Env.GAME_FPS;
		end

		if (self.nRedDrugType==2 and self.nBlueDrugType==2 and UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
			me.ShopBuyItem(680, self.nRedNum-nCount_JiuZhuanD);
			me.ShopBuyItem(690, self.nBlueNum-nCount_ShouWuD);		--679回天丹 680九转丹 684大补散 685首乌丹 689七巧丹 690五花丸
		     	UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIRALL_SEND);		--普通修理
			self.bAutoClose	=1 ;
			return	3* Env.GAME_FPS;
		end

		local bFlag=0;
		if((self.nRedDrugType==1 and nCount_HuiTianD<self.nRedNum) or (self.nRedDrugType==2 and nCount_JiuZhuanD<self.nRedNum)) then
			bFlag=1;
		end

		if((self.nBlueDrugType==1 and nCount_DaBuSan<self.nBlueNum) or (self.nBlueDrugType==2 and nCount_ShouWuD<self.nBlueNum)) then
			bFlag=1;
		end

		if(bFlag==1 and UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then	
			AutoAi.SetTargetIndex(nIndex_YeSou);
			return	1* Env.GAME_FPS;
		end

		if (bFlag==1 and UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
			me.AnswerQestion(0);
			self.bAutoClose	=1 ;
			return	1.5* Env.GAME_FPS;
		end
		--------------------------------------
		if me.nTemplateMapId == 1538 then
			self.nState=5;
		else
			self.nState=9;
		end
		mypos=0;

	elseif (self.nState==5) then		--步骤 5	

		if(self.nTimes%6==0) then
			Txt_SetTxt(self.UIGROUP, self.TXT_POS,"【"..GetMapNameFormId(self.nMapId).."】Rời khỏi khu an toàn");
		end

		local _,nX,nY = me.GetWorldPos();

		if(mypos==3 and math.abs(nX-1746)<5 and math.abs(nY-3267)<5) then	--到非安全区后第1点【秦始皇陵三层】(218.204),1538,1746,3267>
			self.nState=1;
			return	0.3* Env.GAME_FPS;
		end

		if(mypos==0 and math.abs(nX-1786)<5 and math.abs(nY-3190)<5) then	--出安全区第1点【秦始皇陵三层】(223.199),1538,1786,3190>
			me.Msg("1:00");
			mypos=1;
		elseif(mypos==1 and math.abs(nX-1813)<3 and math.abs(nY-3216)<3) then --出安全区第2点【秦始皇陵三层】(226.201),1538,1811,3216>
			me.Msg("2:00");
			mypos=2;
		elseif(mypos==2 and math.abs(nX-1801)<5 and math.abs(nY-3226)<5) then --出安全区第3点【秦始皇陵三层】(225.201),1538,1801,3226>
			me.Msg("3:00");
			mypos=3;
		end

		if(mypos==0) then
			self:MoveTo(1786,3190);
			return	0.1* Env.GAME_FPS;
		end

		if(mypos==1) then
			self:MoveTo(1811,3216);
			return	0.1* Env.GAME_FPS;
		end
		if(mypos==2) then
			self:MoveTo(1801,3226);
			return	0.1* Env.GAME_FPS;
		end
		if(mypos==3) then
			self:MoveTo(1789,3240);
			return	0.1* Env.GAME_FPS;
		end
	elseif (self.nState==6) then		--步骤 6		--普通练功的 买菜 修理 合X。。

		if UiManager:WindowVisible(Ui.UI_SKILLPROGRESS) == 1 then
			return;
		end

		if(me.GetNpc().nIsRideHorse ~= 1) then
			Switch("horse");
		end

		if(me.nAutoFightState == 1 ) then
			AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
			AutoAi.SetTargetIndex(0);
		end

		if(self.nTimes%6==0) then
			Txt_SetTxt(self.UIGROUP, self.TXT_POS,"【"..GetMapNameFormId(self.nMapId).."】Về thành mua thuốc...");
		end

		if(me.GetActiveAuraSkill()>0) then
			nSkillId	=me.GetActiveAuraSkill();
			UseSkill(nSkillId);     
		end

		local nPosX,nPosY=self.tbPos[self.nCurPos][1],self.tbPos[self.nCurPos][2];
		local nCurMapId, nWorldPosX, nWorldPosY = me.GetWorldPos();

		if (mypos<2 and nCurMapId>0 and nCurMapId~=5)  then

			if (nCurMapId <30 and nCurMapId >22) or (nCurMapId <9 and nCurMapId >0) then
				mypos=1;
				nPosX,nPosY=0,0;
			end
							
			if(mypos==0) then	--去江津 
				if(me.GetNpc().nIsRideHorse ~= 1) then
					Switch("horse");
				end

				local szInfoFile	= Map.tbSuperMapLink.tbAllMapInfo[nCurMapId].szInfoFile;
				local tbFileData	= Lib:LoadTabFile("\\setting\\map\\map_info\\" .. szInfoFile .. "\\info.txt");
				for nRowNum, tbRow in ipairs(tbFileData or {}) do
					if (tbRow.NpcTemplateId == "2525") then   --入口
						me.AutoPath(tonumber(tbRow.XPos)/32+MathRandom(-10, 10), tonumber(tbRow.YPos)/32+MathRandom(-10, 10));
						break;
					end
				end
				mypos=1;
				return 2.5* Env.GAME_FPS;	
			end

			if(mypos==1 and ((nPosX-nWorldPosX)^2 + (nPosY-nWorldPosY)^2)>1500) then
				me.StopAutoPath("Chạy đũ xa");
				Map.tbSuperMapLink:StartGoto({szType = "pos", szLink = "Shop,5,1597,3149"});
				mypos=0;
				return 3* Env.GAME_FPS;
			else
				mypos=0;
				return 1.5* Env.GAME_FPS;			
			end
		end

		if (mypos<4 and nCurMapId==5) then
			local nIndex_DaLaoBai,nIndex_YeLianShi=0,0;
			local tbAroundNpc	= KNpc.GetAroundNpcList(me,200);
			for i=1,#tbAroundNpc do
				if(nIndex_DaLaoBai>0 or nIndex_YeLianShi>0) then
					break;
				end

				if(tbAroundNpc[i].nTemplateId==3566) then  
					nIndex_DaLaoBai=tbAroundNpc[i].nIndex;
				end
				if(tbAroundNpc[i].nTemplateId==3574) then  
					nIndex_YeLianShi=tbAroundNpc[i].nIndex;
				end
			end	

			--合X。。
			local bFlag,ts=0,0;

			if(mypos<2 and self.nHX2==1) then
				bFlag,ts=self:HeXuan(0);
				if(bFlag==1) then
					mypos=2;
				else
					me.Msg("Hoàn Thành...");	
					mypos=3;	
				end
			elseif(mypos<2) then
				mypos=3;				
			end

			if(mypos==2) then
				local nX1, nY1 = KNpc.ClientGetNpcPos(5, 3574);	
				if(math.abs(nWorldPosX-nX1)<5 and math.abs(nWorldPosY-nY1)<5) then
					print("Bắt Đầu "..nIndex_YeLianShi);
					local bFlag,ts=self:HeXuan(nIndex_YeLianShi);
					if(bFlag==0) then
						mypos=3;
						me.Msg("Hoàn Thành...");		
					end
					return ts;
				else	
					print("Làm Chủ");
					me.AutoPath(nX1, nY1);
					return 1* Env.GAME_FPS;
				end
			end

			--买菜修理
			local nCount_Cai = me.GetItemCountInBags(19,3,1,5); 		--包里90菜的数量
			local nX1, nY1 = KNpc.ClientGetNpcPos(5, 3566);	
			if(mypos==3  and math.abs(nWorldPosX-nX1)>5 and math.abs(nWorldPosY-nY1)>5) then
				me.AutoPath(nX1, nY1);
				return 1* Env.GAME_FPS;
			end
	
			if (UiManager:WindowVisible(Ui.UI_SHOP) == 1) then
				if(nCount_Cai<self.nCaiNum) then
					me.ShopBuyItem(825, self.nCaiNum-nCount_Cai);
				end
		     		UiNotify:OnNotify(UiNotify.emUIEVENT_REPAIRALL_SEND);
				self.bAutoClose	=1 ;
				mypos=4;
				return	2.5* Env.GAME_FPS;
			end

			if(UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
				AutoAi.SetTargetIndex(nIndex_DaLaoBai);
				return	1* Env.GAME_FPS;
			end

			if (UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
				me.AnswerQestion(1);
				self.bAutoClose	=1 ;
				return	1* Env.GAME_FPS;
			end

		end
		
		if(mypos==4 and nCurMapId>0) then
			self.nState=1;
			return	0.3* Env.GAME_FPS;
		end

	elseif (self.nState==7) then

		if(self.nTimes%6==0) then
			Txt_SetTxt(self.UIGROUP, self.TXT_POS,"【"..GetMapNameFormId(self.nMapId).."】Khu an toàn");
		end

		if(me.GetNpc().nIsRideHorse ~= 1) then
			Switch("horse");
		end

		if(me.nAutoFightState == 1 ) then
			AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
		end
		
		AutoAi.SetTargetIndex(0);

		local nM,nX,nY = me.GetWorldPos();

		if me.nTemplateMapId==1536 and me.nFightState == 0 then
			self.nState = 8
			return;
		end

		if 3685 < self.tbPos[1][2] then
			if self.tbPos[1][1] < 1455 then
				me.AutoPath(1545,3653)
				nPao = 3
			else
				me.AutoPath(1590,3664)
				nPao = 1
			end

		else
			if self.tbPos[1][1] > 1567 then
				me.AutoPath(1590,3607)
				nPao = 2
			else
				me.AutoPath(1545,3653)
				nPao = 3
			end

		end

	elseif (self.nState==8) then
		if self.nHX1 == 1 then
			local nId = UiManager:GetAroundNpcId(3574)
			if nId then
				local bHeX,ts=self:HeXuan(nId);
				if(bHeX==1) then
					return ts;
				end	
			else
				self:MoveTo(1574,3633);
				return	0.1* Env.GAME_FPS;
			end
		end
			
	elseif (self.nState==9) then

		if me.nFightState == 1 and me.nTemplateMapId == 1536 then
			self.nState = 1
			mypos = 0;
			nPao = 0;
			return
		end

		if(self.nTimes%6==0) then
			Txt_SetTxt(self.UIGROUP, self.TXT_POS,"【"..GetMapNameFormId(self.nMapId).."】Ra khỏi khu an toàn");
		end

		local _,nX,nY = me.GetWorldPos();

		if(mypos==3 and math.abs(nX-1534)<5 and math.abs(nY-3662)<5) then
			self.nState=1;
			return	0.3* Env.GAME_FPS;
		end

		if(mypos==0 and math.abs(nX-1565)<5 and math.abs(nY-3630)<5) then
			me.Msg("1:00");
			mypos=1;
		end

		if(mypos==0) then
			self:MoveTo(1565,3630);                                         
			return	0.1* Env.GAME_FPS;
		end

		if(mypos==1) then
			if nPao == 1 then
				self:MoveTo(1586,3657); 
			elseif nPao == 2 then
				self:MoveTo(1585,3610); 
			elseif nPao == 3 then
				self:MoveTo(1549,3648); 
			end                                        
			return	0.1* Env.GAME_FPS;
		end

	end

end

function tbMPGua:Check()

	if (me.nTemplateMapId==1538) or (me.nTemplateMapId==1536) then
		local nCount_FreeBag = me.CalcFreeItemCountInBags(19,3,1,5,0,0)
		if(nCount_FreeBag<3) then
			me.Msg("Hết Chổ Trống Rùi Về Xử Lý Thôi (Dịch : Jie Nguyễn)");
		end

		local nCount_Cai = me.GetItemCountInBags(19,3,1,5); -- thức ăn
		local nLevel, nState, nTime = me.GetSkillState(AutoAi.FOOD_SKILL_ID);
		local bNoFoodEaten = 1;
		if (not nTime or nTime < 36) then
			bNoFoodEaten = 0
		end
		local bNeedBuyCai=0
		if bNoFoodEaten == 0 and nCount_Cai==0 then
			bNeedBuyCai=1
			me.Msg("Hết Thức Ăn Rùi Về Mua Thôi");
		end


		local bNeedDrug=0
		local nCount_HuiTianD=me.GetItemCountInBags(17,1,1,4);
		local nCount_JiuZhuanD=me.GetItemCountInBags(17,1,1,5);
		local nCount_DaBuSan=me.GetItemCountInBags(17,3,1,4);
		local nCount_ShouWuD=me.GetItemCountInBags(17,3,1,5);

		if(self.nRedNum>0 and self.nRedDrugType==1 and nCount_HuiTianD<1) then
			bNeedDrug=1;
			me.Msg("Mua Máu");
		end
		if(self.nRedNum>0 and self.nRedDrugType==2 and nCount_JiuZhuanD<1) then
			bNeedDrug=1;
			me.Msg("Mua Máu");
		end
		if(self.nBlueNum>0 and self.nBlueDrugType==1 and nCount_DaBuSan<1) then
			bNeedDrug=1;
			me.Msg("Mua mana");
		end
		if(self.nBlueNum>0 and self.nBlueDrugType==2 and nCount_ShouWuD<1) then
			bNeedDrug=1;
			me.Msg("Mua mana");
		end


		--检查装备情况
		local bNeedRepair=0
		for i = 0, Item.EQUIPPOS_NUM - 1 do
			local pItem = me.GetItem(Item.ROOM_EQUIP,i,0);
			if pItem and pItem.nCurDur < Item.DUR_MAX / 10 then      -- 耐久低于10%
				bNeedRepair=1
			end
		end
		if bNeedRepair==1 then
			me.Msg("Cần phải sửa đồ");
		end

		if(self.nYeMingZhu==1) then
			local nLevel, nState, nTime = me.GetSkillState(1413);
			local nCount_YeMingZ = me.GetItemCountInBags(18,1,357,1); 

			if(nTime==nil and UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then	
				me.AnswerQestion(0);
				self.bAutoClose	=1;
				return;			
			end
	
			if(nCount_YeMingZ>0 and nTime==nil) then
	     			local tbFind = me.FindItemInBags(18,1,357,1);
	     			me.UseItem(tbFind[1].pItem);
				me.Msg("Không Có Dạ Minh Châu");
			end
		end

		if(bNeedBuyCai==1 or bNeedDrug==1 or nCount_FreeBag<3 or bNeedRepair==1) then

		--需买菜 或 买药 或 背包小于3 或 装备耐久低于10%
			if me.nTemplateMapId == 1538 then
				self.nState=3;			--转到步骤 3
			else
				self.nState=7;

			end
			mypos=0;		--小步骤参数
		end

	elseif (me.nTemplateMapId==1537) then	--皇陵2吃夜明珠

		if(self.nYeMingZhu==1) then
			local nLevel, nState, nTime = me.GetSkillState(1413);
			local nCount_YeMingZ = me.GetItemCountInBags(18,1,357,1); 

			if(nTime==nil and UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then	
				me.AnswerQestion(0);
				self.bAutoClose	=1;
				return;			
			end
	
			if(nCount_YeMingZ>0 and nTime==nil) then
	     			local tbFind = me.FindItemInBags(18,1,357,1);
	     			me.UseItem(tbFind[1].pItem);
				me.Msg("Không Có DMC");
			end
		end

	elseif(me.nTemplateMapId>0) then		--普通地图

		if self.nBuyCai == 0 and self.nHX2 == 0 then
			return;
		end
		

		local nCount_FreeBag = me.CalcFreeItemCountInBags(19,3,1,5,0,0)
		if(nCount_FreeBag<3) then
			me.Msg("Hết Chổ Trống Rùi Về Xử Lý Thôi (Dịch : Jie Nguyễn)");
		end

		local nCount_Cai = me.GetItemCountInBags(19,3,1,5);
		local nLevel, nState, nTime = me.GetSkillState(AutoAi.FOOD_SKILL_ID);
		local bNoFoodEaten = 1;
		if (not nTime or nTime < 50) then
			bNoFoodEaten = 0
		end
		local bNeedBuyCai=0
		if bNoFoodEaten == 0 and nCount_Cai==0 then   --没菜也没菜效果
			bNeedBuyCai=1
			me.Msg("Hết Thức Ăn Về Mua Thôi");
		end


		--检查装备情况
		local bNeedRepair=0
		for i = 0, Item.EQUIPPOS_NUM - 1 do
			local pItem = me.GetItem(Item.ROOM_EQUIP,i,0);
			if pItem and pItem.nCurDur < Item.DUR_MAX / 50 then      -- 耐久低于2%
				bNeedRepair=1
			end
		end
		if bNeedRepair==1 then
			me.Msg("Cần Sửa Đồ");
		end

		if (bNeedBuyCai==1 or (nCount_FreeBag < 1 and self.nHX2 == 1) or bNeedRepair==1) then
			if me.GetNpc().GetRangeDamageFlag() == 1 then
				--PlaySound("\\interface\\耍·探测器\\enemy.wav", 0);
				me.Msg("<color=yellow>Đã Đủ Đồ Cần Thiết<color>")
			else
				self.nState=6;
				mypos=0;
			end
		end
	end
end

function tbMPGua:HeXuan(nIndex)
		local bFlag = 0;   --0表示没有合玄的可能，1表示有
		local nCount={};
		for i = 1,nDenJi do
			nCount[i] = me.GetItemCountInBags(18,1,1,i);
			if nCount[i] >=4 and i <= nDenJi then
				bFlag=1;
			end
		end
		for i = 1,nDenJi do
			nCount[i] = nCount[i]+ me.GetItemCountInBags(18,1,114,i);
			if nCount[i] >=4 and i <= nDenJi   then
				bFlag=1;
			end
		end
		
		if(nIndex==0) then
			return bFlag,1* Env.GAME_FPS;
		end

		if bFlag==0 then
			if me.nTemplateMapId == 1536 then
				self.nState = 4;
			end
			if(UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1) then
				self.bAutoClose=1;
				print("Đóng");
				return 1,1* Env.GAME_FPS;
			end
			return bFlag,1* Env.GAME_FPS;
		end


		if(UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) ~= 1 and UiManager:WindowVisible(Ui.UI_SAYPANEL) ~= 1) then
			AutoAi.SetTargetIndex(nIndex);
			return	bFlag,1* Env.GAME_FPS;
		end

		if(UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1) then
			me.AnswerQestion(2);
			me.AnswerQestion(0);
			self.bAutoClose=1;
			return	bFlag,1* Env.GAME_FPS;			
		end

		if (UiManager:WindowVisible(Ui.UI_EQUIPENHANCE) == 1) then
			for i=1,nDenJi do
				if  nCount[i] >=13 then
					self:MyFindItem2(18,1,1,i,1,13,114);
					me.ApplyEnhance(Item.ENHANCE_MODE_COMPOSE, Item.BIND_MONEY);-- 用绑银
					return bFlag,1* Env.GAME_FPS;
				end
			end

			for i=1,nDenJi do
				if  nCount[i] >=4 then
					self:MyFindItem2(18,1,1,i,1,4,114);
					me.ApplyEnhance(Item.ENHANCE_MODE_COMPOSE, Item.BIND_MONEY);-- 用绑银
					return bFlag,1* Env.GAME_FPS;
				end
			end
		end

		return bFlag,2* Env.GAME_FPS;
end

function tbMPGua:MyFindItem2(g,d,p,l,bOffer,count,p1)
	if (UiManager:WindowVisible(Ui.UI_ITEMBOX) ~= 1) then		
		UiManager:SwitchWindow(Ui.UI_ITEMBOX); -- 打开背包
	end	
	local tbItemBox = Ui(Ui.UI_ITEMBOX);	
	local tbExtBagLayout = Ui.tbLogic.tbExtBagLayout;
	tbExtBagLayout:Show(); 			--打开扩展背包

	local k = 0;
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
							return k
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
							return k
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
							return k
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
							return k
						end
					end
				end
			end
		end
	end
	return 0;
end

function tbMPGua:GetToNpcDistance(x1,y1,x2,y2)
	local dx = x1 - x2;
	local dy = y1 - y2;
	local nDistance = math.sqrt(dx^2 + dy^2);
	return nDistance;
end

function tbMPGua:MoveTo(x,y)	--不能自动寻路时使用,向目标点移动1步
	local _, nX, nY	= me.GetWorldPos();
	local nDx		= x - nX + MathRandom(-2, 2);
	local nDy		= y - nY + MathRandom(-2, 2);
	local nDir		= math.fmod(64 - math.atan2(nDx, nDy) * 32 / math.pi, 64);
	MoveTo(nDir, 0);
end

function tbMPGua:Save()
	local	szUserFilePath1 = "\\user\\TrainNhieuToaDo\\"..me.szName.."_MPGua.dat";
	local	szUserFilePath2 = "\\user\\TrainNhieuToaDo\\MPGua.dat";

	self.nRedNum	=Edt_GetInt(self.UIGROUP,self.EDT_REDNUM);
	self.nBlueNum	=Edt_GetInt(self.UIGROUP,self.EDT_BLUENUM);
	self.nCaiNum	=Edt_GetInt(self.UIGROUP,self.EDT_CAINUM);
	local	tbSetting=	
		{
			nMapId		=self.nMapId;
			tbPos		=self.tbPos;
			nRedDrugType	=self.nRedDrugType;
			nBlueDrugType	=self.nBlueDrugType;
			nRedNum		=self.nRedNum;				
			nBlueNum	=self.nBlueNum;
			nHX1		=self.nHX1;
			nYeMingZhu	=self.nYeMingZhu;			
			nHX2		=self.nHX2;
			nBuyCai		=self.nBuyCai;
			nCaiNum		=self.nCaiNum;
			nFireWait	=self.nFireWait;	
		};
			
	local szData	= Lib:Val2Str(tbSetting);
	KFile.WriteFile(szUserFilePath1, szData);
	KFile.WriteFile(szUserFilePath2, szData);
end

function tbMPGua:Load()
	local 	szUserFilePath1	= "\\user\\TrainNhieuToaDo\\"..me.szName.."_MPGua.dat";
	local	szUserFilePath2 = "\\user\\TrainNhieuToaDo\\MPGua.dat";
	local 	szData;
	if(self.nConfFile==1) then
		szData		= KFile.ReadTxtFile(szUserFilePath2);
	else
		szData		= KFile.ReadTxtFile(szUserFilePath1);	
	end

	
	if (not szData) then
		return;
	end
	local	tbSetting={};
	local 	tbMyData	= Lib:Str2Val(szData);
	for k, v in pairs(tbMyData) do
		tbSetting[k]	= v;
	end

	if(tbSetting.nMapId) then
		self.nMapId=tbSetting.nMapId;
	end
	
	if(tbSetting.tbPos) then
		self.tbPos=tbSetting.tbPos;
	end

	if(tbSetting.nRedDrugType) then
		self.nRedDrugType=tbSetting.nRedDrugType;
	end		


	if(tbSetting.nBlueDrugType) then
		self.nBlueDrugType=tbSetting.nBlueDrugType;
	end


	if(tbSetting.nRedNum) then
		self.nRedNum=tbSetting.nRedNum;
	end


	if(tbSetting.nBlueNum) then
		self.nBlueNum=tbSetting.nBlueNum;
	end


	if(tbSetting.nHX1) then
		self.nHX1=tbSetting.nHX1;
	end


	if(tbSetting.nYeMingZhu) then
		self.nYeMingZhu=tbSetting.nYeMingZhu;
	end


	if(tbSetting.nHX2) then
		self.nHX2=tbSetting.nHX2;
	end	


	if(tbSetting.nBuyCai) then
		self.nBuyCai=tbSetting.nBuyCai;
	end

	if(tbSetting.nCaiNum) then
		self.nCaiNum=tbSetting.nCaiNum;
	end


	if(tbSetting.nFireWait) then
		self.nFireWait=tbSetting.nFireWait;
	end
end

function tbMPGua:ReLoad1()
	local function fnDoScript(szFilePath)
		local szFileData	= KFile.ReadTxtFile(szFilePath);
		assert(loadstring(szFileData, szFilePath))();
	end
	fnDoScript("\\interface\\TrainNhieuToa Do\\MPGua.lua");
	me.Msg("<color=yellow>Reload Thành Công<color>")
	UiManager:OpenWindow("UI_INFOBOARD", "<color=red>Xong")
	Ui:RegisterNewUiWindow("UI_MULTIPOSGUA", "MPGua", {"a",101, 70}, {"b",402, 222}, {"c",502, 222});

end


Ui:RegisterNewUiWindow("UI_MULTIPOSGUA", "MPGua", {"a",101, 70}, {"b",402, 222}, {"c",502, 222});

local tCmd={"UiManager:SwitchWindow(Ui.UI_MULTIPOSGUA)", "MPGua", "", "alt+j", "alt+j", "多点挂机"};
        AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
        UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);	-----快捷键alt+j
