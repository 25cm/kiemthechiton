-- 功能：练功模式下自动释放辅助技能
local tbAutoAsist	= Map.tbAutoAsist or {};
Map.tbAutoAsist		= tbAutoAsist;

local nAsistState = 0;


local szCmd = [=[
	Map.tbAutoAsist:Asistswitch();
]=];
UiShortcutAlias:AddAlias("GM_C2", szCmd);	-- 热键：Alt + 3

function tbAutoAsist:Asistswitch()
	if nAsistState == 0 then
		nAsistState = 1;
		me.Msg("<color=yellow>Bật tự buff skill hỗ trợ bản thân (Alt+2)<color>");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=Yellow>Bật tự buff skill hỗ trợ bản thân [Alt+2]<color>");
	else
		nAsistState = 0;
		me.Msg("<color=green>Tắt tự buff skill hỗ trợ bản thân (Alt+2)<color>");
		UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Tắt tự buff skill hỗ trợ bản thân [Alt+2]<color>");
	end
end

function AutoAi:fnOnMoveState()
	if (nAsistState == 0) then
		return;
	end
	local nSkillId = self:GetRunSkillId();
	--if (me.nPkModel == Player.emKPK_STATE_PRACTISE) then
		if (nSkillId > 0) then
			local _, _, nRestTime	= me.GetSkillState(nSkillId);
			if (not nRestTime or nRestTime < Env.GAME_FPS) then
				AutoAi:Pause();
				AutoAi.DoAttack(nSkillId, AutoAi.GetSelfIndex());
				Timer:Register(Env.GAME_FPS * 1, AutoAi.DelayResumeAi, AutoAi);
			end
		end
	--elseif (me.nFightState == 0) then
		--if (nSkillId > 0) then
			--local _, _, nRestTime	= me.GetSkillState(nSkillId);
			--if (not nRestTime or nRestTime < Env.GAME_FPS) then
			--	AutoAi:Pause();
			--	AutoAi.DoAttack(nSkillId, AutoAi.GetSelfIndex());
			--	Timer:Register(Env.GAME_FPS * 1, AutoAi.DelayResumeAi, AutoAi);
			--end
		--end
	--end
end

-- 功能：获取角色可用的加状态的主动辅助技能ID
function AutoAi:GetRunSkillId()
	local tbAssistSkill	= {861, 851, 115, 132, 177, 377, 230, 180, 697, 26, 219, 46, 55, 161, 783, 191, 835, 1249, 1259};
	for _, nSkillId in ipairs(tbAssistSkill) do
		if (me.CanCastSkill(nSkillId) == 1) then
			return 	nSkillId;
		end
	end
	return 0;
end

UiNotify:RegistNotify(UiNotify.emCOREEVENT_SYNC_POSITION, AutoAi.fnOnMoveState,AutoAi);
