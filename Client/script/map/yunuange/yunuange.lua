
local tbTest = Map:GetClass(566); -- 地图Id

function tbTest:OnEnter(szParam)
	
end;

function tbTest:OnLeave(szParam)
	
end;

local tbTestTrap6	= tbTest:GetTrapClass("to_exit566")

function tbTestTrap6:OnPlayer()	
	me.NewWorld(29,1740,3820)	-- 传送,[地图Id,坐标X,坐标Y]	
	me.SetFightState(0)
end;

