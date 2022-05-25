
local self = tbcTDLT;

local tbcTDLT	= Map.tbcTDLT or {};
Map.tbcTDLT		= tbcTDLT;

local loadTDLT = 0;
local nTimerId1 = 0;

local szCmd = [=[
	Map.tbcTDLT:cTDLTSwitch();
]=];

function tbcTDLT:cTDLTSwitch()
	if loadTDLT == 0 then
		loadTDLT = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bật chế độ ôm cột TDLT [alt+t]<color>");
		me.Msg("<color=yellow>Bật<color>");
		nTimerId1 = Ui.tbLogic.tbTimer:Register(3 * Env.GAME_FPS,self.RunCotTDLT,self);
	else
		loadTDLT = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt chế độ ôm cột TDLT [alt+t]<color>");
		me.Msg("<color=yellow>Tắt<color>");
		Ui.tbLogic.tbTimer:Close(nTimerId1);
		nTimerId1 = 0;
	end
end

function tbcTDLT:RunCotTDLT()
      if (me.IsDead() == 1) then
                me.SendClientCmdRevive(0);
				end
       local nMyMapId	= me.GetMapTemplateId();
	  if (nMyMapId <30 and nMyMapId >22) or (nMyMapId <9 and nMyMapId >0) then
		Map.tbSuperMapLink:StartGoto({szType = "npcpos", szLink = ",0,2597,1,1,1"});
	  else
	AutoAi:StartAutoFight();
	  end
end
function tbcTDLT:StartCotTDLT()
if loadTDLT == 0 then
tbcTDLT:cTDLTSwitch();
end
end

function tbcTDLT:StopCotTDLT()
if loadTDLT == 1 then
tbcTDLT:cTDLTSwitch();
end
end

local tCmd={"Map.tbcTDLT:cTDLTSwitch()", "cTDLT", "", "Alt+T", "Alt+T", "cTDLT"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);