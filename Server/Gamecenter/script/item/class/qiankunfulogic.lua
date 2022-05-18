-------------------------------------------------------------------
--File: 	
--Author: 	sunduoliang
--Date: 	2008-4-14 9:00
--Describe:	Ǭ�����߼���Ҳ���ǲ���Ҫ����ֱ�Ӵ��͵�ָ���������߼�
-------------------------------------------------------------------

if (not Item.tbQianKunFu) then
	Item.tbQianKunFu = {};
end

local tb = Item.tbQianKunFu;

--Ǭ����ID,��Ӧʹ�ô���.
tb.tbItemList = {
		[85] = 10;
		[91] = 100;
	}
tb.tbItemTemplet= {18,1,85,1};
-- GCѯ�ʸ���Serverָ���Ķ����Ƿ�����
function tb:SelectMemberPos(nMemberPlayerId, nPlayerId, nItemId)
	GlobalExcute({"Item.tbQianKunFu:SeachPlayer", nMemberPlayerId, nPlayerId, nItemId});
end


-- GS ���������������Ƿ���ָ�����
function tb:SeachPlayer(nMemberPlayerId, nPlayerId, nItemId)
	-- ����ҵ��Ļ����������ҵ�����
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


-- GC �õ�ָ��ͽ����Ϣ��֪ͨʦ��
function tb:FindMember(nMemberPlayerId, nPlayerId, nItemId, nMapId, nPosX, nPosY, nFightState)
	GlobalExcute({"Item.tbQianKunFu:ObtainMemberPos", nMemberPlayerId, nPlayerId, nItemId, nMapId, nPosX, nPosY, nFightState})
end


-- GS ��֪����λ��
function tb:ObtainMemberPos(nMemberPlayerId, nPlayerId, nItemId, nMapId, nPosX, nPosY, nFightState)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	if pPlayer == nil then
		return 0;
	end
	if nMapId == -1 then
		pPlayer.Msg("Kh?ng th? d?ch chuy?n ??n b?n ?? m?c ti��u��");
		return 0;
	end
	local nCanSendOut = Item:CheckIsUseAtMap(pPlayer.nMapId, unpack(self.tbItemTemplet));
	if (nCanSendOut ~= 1) then
		pPlayer.Msg("B?n ?? hi?n t?i kh?ng th? chuy?n ???c��");
		return 0;
	end
	if self:CheckMember(nPlayerId,nMemberPlayerId) ~= 1 then
		pPlayer.Msg("B?n kh?ng c�� ??ng ??i, c�� th? l�� ??ng ??i ?? r?i kh?i ??i��");
		return 0;		
	end
	-- ִ�д���
	local pItem = KItem.GetObjById(nItemId);
	if pItem == nil then
		pPlayer.Msg("Kh?ng t��m th?y bi?u t??ng v? tr?, ho?t ??ng b?t h?p ph��p. Vui l��ng li��n h? v?i GM.")
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
			pPlayer.Msg("Kh?ng x��a ???c B��a h? m?nh trong v? tr?!");
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

