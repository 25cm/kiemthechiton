
local tbSkillProgress = Ui(Ui.UI_SKILLPROGRESS);

local PRG_PROGRESS	= "PrgProgress";
local TXT_MSG		= "TxtMsg";
local TXT_PROGRESS	= "TxtProgress";
local nTimerIdToClose = 0;

tbSkillProgress.OnOpen=function(self)
	local nTimerId, nInterval, szMsg = me.GetTimerBar();
	if nInterval and szMsg then
		if nInterval > 0 then
			Txt_SetTxt(self.UIGROUP, TXT_MSG, szMsg);
			Txt_SetTxt(self.UIGROUP, TXT_PROGRESS, "0%");
			Prg_SetTime(self.UIGROUP, PRG_PROGRESS, math.floor(nInterval / Env.GAME_FPS * 1000));
		else
			return 0;
		end
	end
	nTimerIdToClose = Ui.tbLogic.tbTimer:Register(nInterval, self.OnCloseEx, self);
	return 1;
end

tbSkillProgress.OnCloseEx	= function(self)
	UiManager:CloseWindow(Ui.UI_SKILLPROGRESS);
end

tbSkillProgress.OnClose = function (self)
	if nTimerIdToClose and nTimerIdToClose > 0 then
		Ui.tbLogic.tbTimer:Close(nTimerIdToClose);
		nTimerIdToClose	= 0;
	end
end
local tbSkilProgress = Ui.tbSkilProgress or {};
function tbSkilProgress:ModifyUi()
	local uiSayPanel	= Ui(Ui.UI_SAYPANEL);
	tbSkilProgress.Say_bak	= tbSkilProgress.Say_bak or uiSayPanel.OnOpen;
	function uiSayPanel:OnOpen(tbParam)
		tbSkilProgress.Say_bak(uiSayPanel, tbParam);
		
		local function fnOnSay()
			tbSkilProgress:OnSay(tbParam);
			return 0;
		end
		Ui.tbLogic.tbTimer:Register(1, fnOnSay);
	end
	tbSkilProgress.EnterGame_bak	= tbSkilProgress.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		tbSkilProgress.EnterGame_bak(Ui);
	end
end

function tbSkilProgress:OnSay(tbParam)
		if string.find(tbParam[1], "Hôm nay đại hiệp đã giúp Nghĩa quân hoàn thành 50 nhiệm vụ") then
			local function CloseWindow()
				if UiManager:WindowVisible(Ui.UI_SAYPANEL) == 1 then
					UiManager:CloseWindow(Ui.UI_SAYPANEL);
				end
				if UiManager:WindowVisible(Ui.UI_ITEMBOX) == 1 then
					UiManager:CloseWindow(Ui.UI_ITEMBOX);
				end
				return 0
			end
			Ui.tbLogic.tbTimer:Register(3 * Env.GAME_FPS, CloseWindow);
			UiManager:StopBao();
			UiManager:StartGua();
			return 0
		end
end

function tbSkilProgress:Init()
	self:ModifyUi();
end

tbSkilProgress:Init();