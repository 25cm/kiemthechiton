
local tbTest = Map:GetClass(568); -- 地图Id

function tbTest:OnEnter(szParam)
	
end;

function tbTest:OnLeave(szParam)
	
end;

local tbTestTrap6	= tbTest:GetTrapClass("to_exit568")

function tbTestTrap6:OnPlayer()		
	me.NewWorld(29,1489,3761)	-- 传送,[地图Id,坐标X,坐标Y]	
	me.SetFightState(0)
end;


local tbTrap7 = tbTest:GetTrapClass("to_huanggongyushufang");

function tbTrap7:OnPlayer()
	me.NewWorld(564, 1554, 3119)	-- 传送,[地图Id,坐标X,坐标Y]	
	me.SetFightState(0)
end;

