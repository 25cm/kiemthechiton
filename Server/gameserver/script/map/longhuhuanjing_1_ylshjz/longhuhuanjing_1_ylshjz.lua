-- Map 的例子加测试
-- 欢迎删除！

-------------- 定义特定地图回调 ---------------
local tbTest = Map:GetClass(438); -- 地图Id

-- 定义玩家进入事件
function tbTest:OnEnter(szParam)
	
end;

-- 定义玩家离开事件
function tbTest:OnLeave(szParam)
	
end;

-------------- 定义特定Trap点回调 ---------------
local tbTestTrap	= tbTest:GetTrapClass("zhadou2ylshj")

-- 定义玩家Trap事件
function tbTestTrap:OnPlayer()
	local task_value = me.GetTask(1022,66)
	if (task_value == 1) then 	
		me.NewWorld(437,1540,3115)	-- 传送,[地图Id,坐标X,坐标Y]
		me.SetFightState(0);	
		return;
	else
		me.NewWorld(436,1540,3115)	-- 传送,[地图Id,坐标X,坐标Y]
		me.SetFightState(0);	
		return;
	end	
	
end;

-- 定义Npc Trap事件
function tbTestTrap:OnNpc()
	
end;

