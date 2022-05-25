
local self = tbInputZero;

local tbInputZero	= Map.tbInputZero or {};
Map.tbInputZero		= tbInputZero;

local nZeroState = 0;
local nTimerId1 = 0;

local szCmd = [=[
	Map.tbInputZero:InputZeroSwitch();
]=];

function tbInputZero:InputZeroSwitch()
	if nZeroState == 0 then
		nZeroState = 1;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bật tự chọn số 0[Alt+C]<color>");
		me.Msg("<color=yellow>Bật<color>");
		nTimerId1 = Ui.tbLogic.tbTimer:Register(0.1 * Env.GAME_FPS,self.OnTimerZero,self);
	else
		nZeroState = 0;
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt tự chọn số 0 [Alt+C]<color>");
		me.Msg("<color=yellow>Tắt<color>");
		Ui.tbLogic.tbTimer:Close(nTimerId1);
		nTimerId1 = 0;
	end
end

function tbInputZero:OnTimerZero()
	if me.GetMapTemplateId() > 65500 then
		if UiManager:WindowVisible(Ui.UI_TEXTINPUT) == 1 then
			me.CallServerScript({ "DlgCmd", "InputNum", 0 });
			UiManager:CloseWindow(Ui.UI_TEXTINPUT);
		end
	end
end

local tCmd={"Map.tbInputZero:InputZeroSwitch()", "Input0", "", "Alt+C", "Alt+C", "Input0"};
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);