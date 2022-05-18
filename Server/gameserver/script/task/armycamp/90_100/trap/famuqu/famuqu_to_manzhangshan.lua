--伐木区--蛮瘴山

local tbMap	= Map:GetClass(557);
local tbTrap_1 = tbMap:GetTrapClass("to_manzhangshan");

function tbTrap_1:OnPlayer()
	me.NewWorld(me.nMapId, 1831, 3080);
	TaskAct:StepOverEvent("Thỉnh giáo Vân Đại Đao dẫn đường vào Man Chướng Sơn");
end


