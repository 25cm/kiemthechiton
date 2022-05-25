
local uiCheckTeacher = Ui(Ui.UI_CHECKTEACHER);
local nCastState = 0;
local nCastTimerId = 0;
local nCastTime = 0.5;
local nCastState = 0;
local nUseX = 0;
local nUseY = 0;
local nRecTimer = 0;
local nRecState = 0;

	local tCmd={"Ui(Ui.UI_CHECKTEACHER):Switch()", "AutoCast", "", "Ctrl+R", "Ctrl+R", "AutoCast" };
	AddCommand(tCmd[4], tCmd[3], tCmd[2], tCmd[7] or UiShortcutAlias.emKSTATE_INGAME);
	UiShortcutAlias:AddAlias(tCmd[2], tCmd[1]);

function uiCheckTeacher:Switch()
	if nCastState == 0 then
		local nMapId,nX,nY = me.GetWorldPos()
		nUseX = nX;
		nUseY = nY;
		nCastState = 1;
		UiManager:OpenWindow("UI_INFOBOARD","<bclr=red><color=yellow>Bật tự xuất chiêu <bclr=pink><color=yellow>[Tay trái]")
		assert(nCastTimerId == 0);
		nCastTimerId = Timer:Register(nCastTime * Env.GAME_FPS, self.AutoCast, self);
		nRecTimer = Timer:Register(5 * Env.GAME_FPS, self.CheckPos, self);
	elseif nCastState == 1 then
		Timer:Close(nCastTimerId);
		nCastState = 2;
		UiManager:OpenWindow("UI_INFOBOARD","<bclr=pink><color=yellow>Bật tự xuất chiêu <bclr=red><color=yellow>[Tay phải]")
		nCastTimerId = Timer:Register(3 * Env.GAME_FPS, self.AutoCast, self);
		Timer:Close(nRecTimer);
	elseif nCastState == 2 then
		nCastState = 0;
		UiManager:OpenWindow("UI_INFOBOARD","<bclr=blue><color=white>Ngừng tự xuất chiêu<color>")
		Timer:Close(nCastTimerId);
		nCastTimerId = 0;
	end
end

function uiCheckTeacher:AutoCast()
	if me.nFightState ~= 1  then
		return
	end
	if nCastState == 1 then
		if nRecState == 0 then
			me.UseSkill(me.nLeftSkill ,GetCursorPos());
			me.Msg("<bclr=red><color=yellow>Nhấn [Ctrl+R] để ngừng");
		else
			self:ResumePos()
		end
	elseif nCastState == 2 then
		me.UseSkill(me.nRightSkill ,GetCursorPos());
		me.Msg("<bclr=pink><color=yellow>Nhấn [Ctrl+R] lần nữa để ngừng");
	else

	end
end

function uiCheckTeacher:CheckPos()
	if me.nFightState ~= 1 then
		return
	end
	local _,nX,nY = me.GetWorldPos()
	Switch("sit");
	if nX ~= nUseX or nY ~= nUseY then
		nRecState = 1;
	end
end

function uiCheckTeacher:ResumePos()
	local _,nX,nY = me.GetWorldPos()
	if nX == nUseX and nY == nUseY then
		nRecState = 0;
	else
		me.AutoPath(nUseX,nUseY);
	end
end
