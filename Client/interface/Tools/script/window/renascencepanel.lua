
local uiRenascencePanel   = Ui(Ui.UI_RENASCENCEPANEL);

uiRenascencePanel.BTN_ACCEPT_CURE		= "btnAcceptCure";
uiRenascencePanel.BTN_TAKEN_DRUG		= "btnTakenDrug";
uiRenascencePanel.BTN_LOCAL_TREATMENT	= "btnLocalTreatment";
uiRenascencePanel.BTN_TREATMENT	= "btnTreatment";
uiRenascencePanel.BTN_GO_HOME			= "btnGoHome";

uiRenascencePanel.OnOpen = function(self)
	Wnd_SetEnable(self.UIGROUP, self.BTN_ACCEPT_CURE, 0);
end

uiRenascencePanel.OnButtonClick = function(self, szWndName, nParam)
	if (me.IsDead() ~= 1) then
		UiManager:CloseWindow(Ui.UI_RENASCENCEPANEL);
		return;
	end
	
	if (szWndName == self.BTN_LOCAL_TREATMENT) then -- 本地复活
		me.SendClientCmdRevive(1);
	elseif (szWndName == self.BTN_TREATMENT) then 
		Ui.tbLogic.tbTimer:Register(0.5* Env.GAME_FPS, self.MedRevive, self);		
	elseif (szWndName == self.BTN_GO_HOME) then 
		me.SendClientCmdRevive(0);
	elseif (szWndName == self.BTN_ACCEPT_CURE) then 
		me.SendClientCmdRevive(2);
	end

end

uiRenascencePanel.WhenGetCure = function(self, nLifeP, nManaP, nStaminaP)
	Wnd_SetEnable(self.UIGROUP, self.BTN_ACCEPT_CURE, 1);
end

uiRenascencePanel.OnPlayerRevival = function(self)
	UiManager:CloseWindow(Ui.UI_RENASCENCEPANEL);
end

uiRenascencePanel.OnPlayerDeath = function(self, szPlayer)
	me.Msg("<color=yellow>Bạn đã bị trọng thương !");
	UiManager:OpenWindow(self.UIGROUP);
end

uiRenascencePanel.MedRevive = function(self)
	if me.IsDead() == 1 and me.nLevel >= 30 then
		if me.GetItemCountInBags(18,1,24,1) > 0 or me.GetItemCountInBags(18,1,268,1) > 0 then
			UiManager:CloseWindow(Ui.UI_IBSHOP);
			me.SendClientCmdRevive(1);
			return 0;
		else
			if me.nBindCoin >= 50 then
				if UiManager:WindowVisible(Ui.UI_IBSHOP) == 1 then
					if Ui(Ui.UI_IBSHOP).m_nZoneType ~= 3 then
						Ui(Ui.UI_IBSHOP):OnButtonClick("BtnBindGoldSection");
					else
						if	me.IbCartIsEmpty() ~= 1 then
							me.IbCart_Commit(2)	
						else
							me.IbCart_AddWare(322,2);
--							me.IbCart_SetWareCount(322,2)	
						end
					end
				else
					UiManager:OpenWindow(Ui.UI_IBSHOP);
				end
				return 0.5* Env.GAME_FPS;
			else
				me.SendClientCmdRevive(1);
				return 0;
			end
		end
	elseif	me.IsDead() == 1 and me.nLevel < 30 then
		me.SendClientCmdRevive(1);
		return 0;
	else
		return 0;
	end
end

uiRenascencePanel.RegisterEvent = function(self)
	local tbRegEvent =
	{
		{ UiNotify.emCOREEVENT_PLAYER_DEATH, 	self.OnPlayerDeath },
		{ UiNotify.emCOREEVENT_PLAYER_REVIVE,	self.OnPlayerRevival },
		{ UiNotify.emCOREEVENT_GET_CURE,		self.WhenGetCure },
	};
	return tbRegEvent;
end
