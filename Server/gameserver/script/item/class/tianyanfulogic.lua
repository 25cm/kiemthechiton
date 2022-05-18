if (not Item.tbTianYanFu) then
	Item.tbTianYanFu = {};
end

local tb = Item.tbTianYanFu;

tb.tbItemList = {
	[206] = 10
}

function tb:SelectEnemyPos(nEnemyId, nPlayerId, nItemId)
	GlobalExcute({"Item.tbTianYanFu:SeachPlayer", nEnemyId, nPlayerId, nItemId});
end


function tb:SeachPlayer(nEnemyId, nPlayerId, nItemId)
	local pMember = KPlayer.GetPlayerObjById(nEnemyId)
	if (pMember) then
		local nMapId, nPosX, nPosY 	= pMember.GetWorldPos();
		local nMapIndex 			= SubWorldID2Idx(nMapId);
		local nMapTemplateId		= SubWorldIdx2MapCopy(nMapIndex);
		local nFightState 			= pMember.nFightState;
		GCExcute({"Item.tbTianYanFu:FindMember", pMember.szName, nPlayerId, nItemId, nMapTemplateId, nPosX, nPosY, nFightState});		
	end
end


function tb:FindMember(szEnemyName, nPlayerId, nItemId, nMapId, nPosX, nPosY, nFightState)
	GlobalExcute({"Item.tbTianYanFu:ObtainMemberPos", szEnemyName, nPlayerId, nItemId, nMapId, nPosX, nPosY, nFightState})
end


function tb:ObtainMemberPos(szEnemyName, nPlayerId, nItemId, nMapId, nPosX, nPosY, nFightState)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	if not pPlayer then
		return 0;
	end
	
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		pPlayer.Msg("Không tìm được vật phẩm, không thể thao tác. Hãy liên hệ GM.")
		return 0;
	end
	local nNTime = GetTime();
	local nYearDate = tonumber(os.date("%Y%m%d",nNTime));
	local nTimeDate = tonumber(os.date("%H%M%S",nNTime));
	pItem.SetGenInfo(2,nYearDate);
	pItem.SetGenInfo(3,nTimeDate);	
	if nFightState == 0 or Item:IsCallInAtMap(nMapId, 18,1,85,1) == 0 then
		Setting:SetGlobalObj(pPlayer, him, pItem);
		Dialog:Say(string.format("Kẻ thù <color=red>%s<color> hiện không ở bên ngoài, hãy thử lại sau.", szEnemyName));
		Setting:RestoreGlobalObj();
		return 0;
	end
	
	local nUseCount = pItem.GetGenInfo(1,0);
	if self.tbItemList[pItem.nParticular] - nUseCount == 1 then
		if (pPlayer.DelItem(pItem, Player.emKLOSEITEM_USE) ~= 1) then
			pPlayer.Msg("Xóa vật phẩm thất bại!");
			return 0;
		end
	else
		pItem.SetGenInfo(1,nUseCount + 1);
		pItem.Sync();
	end
	Setting:SetGlobalObj(pPlayer, him, pItem);
	Dialog:Say(string.format("Vị trí hiện tại của kẻ thù <color=red>%s<color> là:\n\nBản đồ: <color=yellow>%s<color>\nTọa độ: <color=yellow>%s/%s<color>", szEnemyName, GetMapNameFormId(nMapId), math.floor(nPosX/8), math.floor(nPosY/16)))
	Setting:RestoreGlobalObj();
end

