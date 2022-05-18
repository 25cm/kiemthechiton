--伐木区--离开鳄神殿

local tbMap	= Map:GetClass(557);
local tbTrap_1 = tbMap:GetTrapClass("to_exitshanzhuang");

function tbTrap_1:OnPlayer()
	me.NewWorld(me.nMapId, 1630, 3638);
	me.SetFightState(0);
	TaskAct:StepOverEvent("Rời khỏi Tàn Tích Phục Ngưu Sơn Trang");
end


