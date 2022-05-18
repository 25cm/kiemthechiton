-------------------------------------------------------
-- 文件名　：fuqichuansonglogic.lua
-- 创建者　：zhangjinpin@kingsoft
-- 创建时间：2010-01-29 18:02:18
-- 文件描述：
-------------------------------------------------------

if (not Item.tbFuQiChuanSongFu) then
	Item.tbFuQiChuanSongFu = {};
end

local tb = Item.tbFuQiChuanSongFu;

-- GC询问各个Server对方是否在线
function tb:SelectMemberPos(nCoupleId, nPlayerId)
	GlobalExcute({"Item.tbFuQiChuanSongFu:SeachPlayer", nCoupleId, nPlayerId});
end

-- GS 搜索本服务器上是否有指定玩家
function tb:SeachPlayer(nCoupleId, nPlayerId)
	
	-- 如果找到的话返回这个玩家的坐标
	local pMember = KPlayer.GetPlayerObjById(nCoupleId)
	if (pMember) then
		local nMapId, nPosX, nPosY = pMember.GetWorldPos();
		local nFightState = pMember.nFightState
		local nCanSendIn  = Item:IsCallInAtMap(nMapId, "chuansong");
		if (nCanSendIn ~= 1) then
			nMapId = -1;
		end	
		GCExcute({"Item.tbFuQiChuanSongFu:FindMember", nCoupleId, nPlayerId, nMapId, nPosX, nPosY, nFightState});		
	end
end

-- GC 得到对方信息，通知传送者
function tb:FindMember(nCoupleId, nPlayerId, nMapId, nPosX, nPosY, nFightState)
	GlobalExcute({"Item.tbFuQiChuanSongFu:ObtainMemberPos", nCoupleId, nPlayerId, nMapId, nPosX, nPosY, nFightState})
end

-- GS 得知对方位置
function tb:ObtainMemberPos(nCoupleId, nPlayerId, nMapId, nPosX, nPosY, nFightState)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	if pPlayer == nil then
		return 0;
	end
	if nMapId == -1 then
		pPlayer.Msg("Không thể di chuyển đến mục tiêu");
		return 0;
	end
	local nCanSendOut = Item:CheckIsUseAtMap(pPlayer.nMapId, "chuansong");
	if (nCanSendOut ~= 1) then
		pPlayer.Msg("Bản đồ hiện tại không thể mở thư !");
		return 0;
	end
	local nRet, szMsg = Map:CheckTagServerPlayerCount(nMapId)
	if nRet ~= 1 then
		pPlayer.Msg(szMsg);
		return 0;
	end
	pPlayer.SetFightState(nFightState);
	pPlayer.NewWorld(nMapId, nPosX, nPosY);
end
