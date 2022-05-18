-------------------------------------------------------------------
--File: gouhuo.lua
--Author: zongbeilei
--Date: 2007-12-21 21:59
--Describe: 篝火物品脚本
-------------------------------------------------------------------

local tbGouhuoItem	= Item:GetClass("firewood");

tbGouhuoItem.nDelayTime		= 0.5;	-- 拾取篝火时会延时5(秒) 
tbGouhuoItem.nExistentTime	= 900;	-- 篝火存在的时间(秒)

-- 功能:	判断篝火能否被拾取(没有组队不能拾取)
-- 参数:	nObjId	物品ID
function tbGouhuoItem:IsPickable(nObjId)
	if (0 == me.nTeamId) then
		me.Msg("Tổ đội mới có thể đốt lửa trại.");
		return 0;
	end
	self:DelayTime(me, nObjId);
	return 0;
end

-- 功能:	篝火拾取了以后的操作
-- 参数:	nX, nY	被拾取的篝火的坐标
function tbGouhuoItem:PickUp(nX, nY)
	self:CallGouhuoNpc(nX, nY);
	me.Msg("Bạn đã đôt lửa trại, các thành viên trong nhóm có thể cùng nhau chia sẻ điểm kinh nghiệm.");
	local nTeamId = me.nTeamId;
	if (nTeamId > 0) then
		KTeam.Msg2Team(nTeamId, "Lửa trại đã được đốt, các thành viên trong nhóm có thể cùng nhau chia sẻ điểm kinh nghiệm.");
	end
	return	0;
end


local tbEvent = 
{
	Player.ProcessBreakEvent.emEVENT_MOVE,
	Player.ProcessBreakEvent.emEVENT_ATTACK,
	Player.ProcessBreakEvent.emEVENT_SITE,
	Player.ProcessBreakEvent.emEVENT_USEITEM,
	Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
	Player.ProcessBreakEvent.emEVENT_DROPITEM,
	Player.ProcessBreakEvent.emEVENT_SENDMAIL,
	Player.ProcessBreakEvent.emEVENT_TRADE,
	Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
	Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
	Player.ProcessBreakEvent.emEVENT_LOGOUT,
	Player.ProcessBreakEvent.emEVENT_DEATH,
}
-- 功能:	拾取篝火进度条，执行self.nDelayTime秒的延时
-- 参数:	pPlayer 拾取篝火的玩家对象
-- 参数:	nObjId	物品ID
function tbGouhuoItem:DelayTime(pPlayer, nObjId)
	GeneralProcess:StartProcess("Đang đốt...", self.nDelayTime * Env.GAME_FPS, {self.DoPickUp, self, pPlayer.nId, nObjId}, nil, tbEvent);
end

-- 功能:	进度条结束后执行拾取物品
-- 参数:	pPlayer	拾取的玩家，
-- 参数:	nObjId	物品ID
function tbGouhuoItem:DoPickUp(nPlayerId, nObjId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	if (not pPlayer) then
		return;
	end
	pPlayer.PickUpItem(nObjId, 0);
end

-- 功能:	call出篝火Npc
-- 参数:	nX, nY	被拾取的篝火的坐标
function tbGouhuoItem:CallGouhuoNpc(nX, nY)
	local tbGouhuoNpc	= Npc:GetClass("gouhuonpc");
	local nMapIdx		= SubWorldID2Idx(me.nMapId);
	local pGouhuoNpc	= KNpc.Add(tbGouhuoNpc.nNpcId, 1, -1, nMapIdx, nX, nY);		-- 获得篝火Npc
	local tbTmp 		= pGouhuoNpc.GetTempTable("Npc");								-- 获得篝火Npc的TempTable
	tbTmp.nTeamId		= me.nTeamId;
	tbTmp.nRestTime		= self.nExistentTime;
	Timer:Register(tbGouhuoNpc.nGouhuoPeriodTime * Env.GAME_FPS, tbGouhuoNpc.OnNpcTimer, tbGouhuoNpc, pGouhuoNpc.dwId);
	tbTmp.nDrinkTimerId = Timer:Register(1, tbGouhuoNpc.OnDrinkTimer, tbGouhuoNpc, me.nTeamId, pGouhuoNpc.dwId);
end
