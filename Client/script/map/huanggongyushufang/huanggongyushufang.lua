
local tbTest = Map:GetClass(564); -- 地图Id

function tbTest:OnEnter(szParam)
	
end;

function tbTest:OnLeave(szParam)
	
end;

local tbTestTrap6	= tbTest:GetTrapClass("to_exit564")

function tbTestTrap6:OnPlayer()	
	me.NewWorld(568, 1635, 3234)	-- 传送,[地图Id,坐标X,坐标Y]	
	me.SetFightState(0)
end;

