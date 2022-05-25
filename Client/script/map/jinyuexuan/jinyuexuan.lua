
local tbTest = Map:GetClass(567); -- 地图Id

function tbTest:OnEnter(szParam)
	
end;

function tbTest:OnLeave(szParam)
	
end;

local tbTestTrap6	= tbTest:GetTrapClass("to_exit567")

function tbTestTrap6:OnPlayer()	
	me.NewWorld(29,1731,3849)	-- 传送,[地图Id,坐标X,坐标Y]	
	me.SetFightState(0)
end;

