-- Map 的例子加测试
-- 欢迎删除！

-------------- 定义特定地图回调 ---------------
local tbTest = Map:GetClass(536); -- 地图Id

-- 定义玩家进入事件
function tbTest:OnEnter(szParam)
	
end;

-- 定义玩家离开事件
function tbTest:OnLeave(szParam)

end;


-------------- 【离开吴曦别院】 ---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit536")

function tbTestTrap1:OnPlayer()
		me.NewWorld(104,1895,3321)	-- 传送,[地图Id,坐标X,坐标Y]	
		me.SetFightState(1);
end;

