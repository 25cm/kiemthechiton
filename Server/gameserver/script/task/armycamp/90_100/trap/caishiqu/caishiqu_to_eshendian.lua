--伐木区--蛮瘴山

local tbMap	= Map:GetClass(557);
local tbTrap_1 = tbMap:GetTrapClass("to_eshendian");

function tbTrap_1:OnPlayer()
	me.NewWorld(me.nMapId, 1807, 3773);
	TaskAct:StepOverEvent("Thỉnh giáo Vân Tiểu Đao dẫn đường vào Ngạc Thần Điện");
end


