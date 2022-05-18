-------------------------------------------------------
-- 文件名　：qinshihuangling_4.lua
-- 创建者　：zhangjinpin@kingsoft
-- 创建时间：2009-06-09 13:00:49
-- 文件描述：
-------------------------------------------------------


-------------- 定义特定地图回调 ---------------
local tbMap = Map:GetClass(1539);

-- 定义玩家进入事件
function tbMap:OnEnter(szParam)
	
	-- 判断剩余时间
	local nUseTime = me.GetTask(Boss.Qinshihuang.TASK_GROUP_ID, Boss.Qinshihuang.TASK_USE_TIME);
	
	-- 剩余时间为0
	if nUseTime >= Boss.Qinshihuang.MAX_DAILY_TIME then
		me.NewWorld(1538, 1762, 3191);		-- 第三层的安全区
		me.SetFightState(0);
		return;
	end
	
	-- 战斗保护
	Player:AddProtectedState(me, 6);
	
	-- 加入当前地图的列表
	Boss.Qinshihuang:AddPlayer(me.nId, 4);
	
	-- 地图对玩家影响
	Boss.Qinshihuang:OnMapEffect(me.nId, 4);
	
	self:_SetState(me);
end;

-- 定义玩家离开事件
function tbMap:OnLeave(szParam)
	
	-- 清除地图效果
	Boss.Qinshihuang:OnMapLeave(me.nId, 4);
			
	-- 移出当前地图的列表
	Boss.Qinshihuang:RemovePlayer(me.nId);
	
	self:_ResetState(me);
end;

function tbMap:_SetState(pPlayer)
	
	-- 设置为帮会模式
	pPlayer.nPkModel = Player.emKPK_STATE_TONG;
	
	-- 禁止摆摊
	pPlayer.DisabledStall(1);	
	
	-- 禁止切换战斗状态
	pPlayer.nForbidChangePK	= 1;
end

function tbMap:_ResetState(pPlayer)
	pPlayer.DisabledStall(0);
	pPlayer.nForbidChangePK	= 0;
end

-------------- 定义特定Trap点回调 ---------------


-- 进入5层点1
local tbTrap1 = tbMap:GetTrapClass("trap_f5_1");

function tbTrap1:OnPlayer()
	
	-- 进入第五层要检测
	if Boss.Qinshihuang:CheckOpenQinFive() ~= 1 then 
		Dialog:SendBlackBoardMsg(me, "里面神秘莫测，此时还是不要进去为好！");
		return;
	end
	
	me.NewWorld(1540, 1540, 3241);
	me.SetFightState(1);
end;


-- 进入5层点2
local tbTrap2 = tbMap:GetTrapClass("trap_f5_2");

function tbTrap2:OnPlayer()
	
	-- 进入第五层要检测
	if Boss.Qinshihuang:CheckOpenQinFive() ~= 1 then 
		Dialog:SendBlackBoardMsg(me, "里面神秘莫测，此时还是不要进去为好！");
		return;
	end
	
	me.NewWorld(1540, 1572, 3194);
	me.SetFightState(1);
end;

-- 返回3层点1
local tbTrap3 = tbMap:GetTrapClass("trap_f3_1");

function tbTrap3:OnPlayer()
	me.NewWorld(1538, 1713, 3477);
	me.SetFightState(1);
end;


-- 返回3层点2
local tbTrap4 = tbMap:GetTrapClass("trap_f3_2");

function tbTrap4:OnPlayer()
	me.NewWorld(1538, 1759, 3432);
	me.SetFightState(1);
end;
