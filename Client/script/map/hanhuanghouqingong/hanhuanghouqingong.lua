
local tbTest = Map:GetClass(565); -- 地图Id

function tbTest:OnEnter(szParam)
	
end;

function tbTest:OnLeave(szParam)
	
end;

local tbTestTrap6	= tbTest:GetTrapClass("to_exit565")

function tbTestTrap6:OnPlayer()	
	me.NewWorld(29,1705,3862)	-- 传送,[地图Id,坐标X,坐标Y]	
	me.SetFightState(0)
end;
