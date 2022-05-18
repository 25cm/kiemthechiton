-------------------------------------------------------------------
--File: 	
--Author: 	sunduoliang
--Date: 	2008-4-14 9:00
--Describe:	乾坤符逻辑，也就是不需要请求，直接传送到指令玩家身边逻辑
-------------------------------------------------------------------

if (not Item.tbQianKunFu) then
	Item.tbQianKunFu = {};
end

local tb = Item.tbQianKunFu;

--乾坤符ID,对应使用次数.
tb.tbItemList = {
		[85] = 10;
		[91] = 100;
	}
tb.tbItemTemplet= {18,1,85,1};
-- GC询问各个Server指定的队友是否在线
function tb:SelectMemberPos(nMemberPlayerId, nPlayerId, nItemId)
	GlobalExcute({"Item.tbQianKunFu:SeachPlayer", nMemberPlayerId, nPlayerId, nItemId});
end


-- GS 搜索本服务器上是否有指定玩家
function tb:SeachPlayer(nMemberPlayerId, nPlayerId, nItemId)
	-- 如果找到的话返回这个玩家的坐标
	local pMember = KPlayer.GetPlayerObjById(nMemberPlayerId)
	if (pMember) then
		local nMapId, nPosX, nPosY = pMember.GetWorldPos();
		local nFightState = pMember.nFightState
		local nCanSendIn  = Item:IsCallInAtMap(nMapId, unpack(self.tbItemTemplet));
		if (nCanSendIn ~= 1) then
			nMapId = -1;
		end	
		GCExcute({"Item.tbQianKunFu:FindMember", nMemberPlayerId, nPlayerId, nItemId, nMapId, nPosX, nPosY, nFightState});		
	end
end


-- GC 得到指定徒弟信息，通知师傅
function tb:FindMember(nMemberPlayerId, nPlayerId, nItemId, nMapId, nPosX, nPosY, nFightState)
	GlobalExcute({"Item.tbQianKunFu:ObtainMemberPos", nMemberPlayerId, nPlayerId, nItemId, nMapId, nPosX, nPosY, nFightState})
end


-- GS 得知对友位置
function tb:ObtainMemberPos(nMemberPlayerId, nPlayerId, nItemId, nMapId, nPosX, nPosY, nFightState)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	if pPlayer == nil then
		return 0;
	end
	if nMapId == -1 then
		pPlayer.Msg("Không thể đến được mục tiêu!");
		return 0;
	end
	local nCanSendOut = Item:CheckIsUseAtMap(pPlayer.nMapId, unpack(self.tbItemTemplet));
	if (nCanSendOut ~= 1) then
		pPlayer.Msg("Không được đến khu vực hiện tại!");
		return 0;
	end
	if self:CheckMember(nPlayerId,nMemberPlayerId) ~= 1 then
		pPlayer.Msg("Đồng đội này không có, hoặc đã rời khỏi đội!");
		return 0;		
	end
	-- 执行传送
	local pItem = KItem.GetObjById(nItemId);
	if pItem == nil then
		pPlayer.Msg("Không tìm được Càn Khôn Phù, thao tác không đúng. Xin liên hệ GM.")
		return 0;
	end
	local nRet, szMsg = Map:CheckTagServerPlayerCount(nMapId)
	if nRet ~= 1 then
		pPlayer.Msg(szMsg);
		return 0;
	end
	local nUseCount = pItem.GetGenInfo(1,0);
	if self.tbItemList[pItem.nParticular] - nUseCount == 1 then
		if (pPlayer.DelItem(pItem, Player.emKLOSEITEM_USE) ~= 1) then
			pPlayer.Msg("Xóa Càn Khôn Phù thất bại!");
			return 0;
		end
	else
		pItem.SetGenInfo(1,nUseCount + 1);
		pItem.Sync();
	end
	pPlayer.SetFightState(nFightState);
	pPlayer.NewWorld(nMapId, nPosX, nPosY);
end

function tb:CheckMember(nPlayerId, nMemberPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	if pPlayer == nil then
		return 0;
	end
	local tbTeamMemberList = KTeam.GetTeamMemberList(pPlayer.nTeamId);
	if tbTeamMemberList == nil then
		return 0;
	else
		for _, nMemPlayerId in pairs(tbTeamMemberList) do
				if nMemPlayerId == nMemberPlayerId then
					return 1;
				end
		end	
	end
	return 0;
end

