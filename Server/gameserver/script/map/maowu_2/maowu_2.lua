-- Map 的例子加测试
-- 欢迎删除！

-------------- 定义特定地图回调 ---------------
local tbTest = Map:GetClass(502); -- 地图Id

-- 定义玩家进入事件
function tbTest:OnEnter(szParam)
	
end;

-- 定义玩家离开事件
function tbTest:OnLeave(szParam)
	
end;

-------------- 【离开顾重颜2】 ---------------
local tbTestTrap20	= tbTest:GetTrapClass("to_exit502")

function tbTestTrap20:OnPlayer()
	me.NewWorld(88,1705,3484)	-- 传送,[地图Id,坐标X,坐标Y]	
	me.SetFightState(1)
end;

