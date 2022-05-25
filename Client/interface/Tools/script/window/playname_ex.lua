local tbTimer = Ui.tbLogic.tbTimer;
Ui.UI_PLAYERNAME_EX = "Ui.UI_PLAYERNAME_EX";
local uiPlayerNameEx = Ui.tbWnd[UI_PLAYERNAME_EX] or {};
uiPlayerNameEx.TIMER_FRAME	= Env.GAME_FPS;
local tbAutoPlayerName	= Map.tbAutoPlayerName or {};
Map.tbAutoPlayerName		= tbAutoPlayerName;
uiPlayerNameEx.nTimerId = 0;
local nPlayerNameState = 1;

local szCmd = [=[
	Map.tbAutoPlayerName:PlayerNameswitch();
]=];
UiShortcutAlias:AddAlias("", szCmd);

function tbAutoPlayerName:PlayerNameswitch()
	if nPlayerNameState == 0 then
			nPlayerNameState = 1;
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bật hiển thị Phái-Cấp<color>");			
	elseif nPlayerNameState == 1 then
			nPlayerNameState = 0;
			UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt hiển thị Phái-Cấp<color>");			
	end		
end

function uiPlayerNameEx:OnInit()
	print("uiPlayerNameEx:OnInit()");
	self.EnterGame_bak	= self.EnterGame_bak or Ui.EnterGame;
	function Ui:EnterGame()
		print("Ui:EnterGame()");
		uiPlayerNameEx.EnterGame_bak(Ui);
		uiPlayerNameEx.nTimerId = tbTimer:Register(uiPlayerNameEx.TIMER_FRAME, uiPlayerNameEx.OnTimer, uiPlayerNameEx);
	end
end

function uiPlayerNameEx:OnTimer()
	if (nPlayerNameState == 0) then
		for _, pNpc in ipairs(KNpc.GetAroundNpcList(me, 50)) do
			if (pNpc.nKind == 1 and not pNpc.GetPlayer()) then	
				local szName = string.format("%s",pNpc.szName);
				pNpc.SetDisplayName(szName);
			end
		end
		return;
	end
	for _, pNpc in ipairs(KNpc.GetAroundNpcList(me, 20)) do
		if (pNpc.nKind == 1 and not pNpc.GetPlayer()) then	
		
			if nPlayerNameState == 0 then
				local szName = string.format("%s",pNpc.szName);
				pNpc.SetDisplayName(szName);
			end
			if nPlayerNameState == 1 then
			local szName = string.format("%s [%s.%d]",	pNpc.szName, Player.tbFactions[pNpc.nFaction].szName, pNpc.nLevel);
				pNpc.SetDisplayName(szName);
			end
		end
	end
end


uiPlayerNameEx:OnInit();