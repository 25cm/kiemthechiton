local BuffTC = Map.BuffTC or {};
Map.BuffTC = BuffTC;

local nSwitch = 0;
local self = BuffTC;

function BuffTC:SwitchBuffTC()
	if nSwitch == 0 then
		self:StartBuffTC();
	else
		self:StopBuffTC();
	end
end

function BuffTC:StartBuffTC()
	me.Msg("<color=yellow>Bắt đầu tự Buff")
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=black><color=yellow>Tự động Buff Tại Chỗ<color>");
	self:StopAutoFight();
	self.BuffTCTimer = Timer:Register(Env.GAME_FPS * 1,self.OnBuffTCTime,self);
	nSwitch = 1;
end

function BuffTC:StopBuffTC()
	me.Msg("<color=green>Dừng Buff")
	UiManager:OpenWindow("UI_INFOBOARD", "<bclr=Black><color=white>Dừng Tự Buff Tại Chỗ");
	nSwitch = 0;
	Timer:Close(self.BuffTCTimer);
end

function BuffTC:OnBuffTCTime()
	if (me.GetMapTemplateId() < 30 or me.GetMapTemplateId() == 224) then
		me.Msg("<color=yellow>Đang trong thành, ko buff được");
		self:StopBuffTC();
	else
		if (me.nFaction == 5 and me.CanCastSkill(98) == 1) then
			me.UseSkill(98,GetCursorPos()); 
		else
			self:StopBuffTC();
		end
	end
end

function BuffTC:StopAutoFight()
	if me.nAutoFightState == 1 then
		AutoAi:UpdateCfg(Ui.tbLogic.tbAutoFightData:ShortKey());
	end
end

