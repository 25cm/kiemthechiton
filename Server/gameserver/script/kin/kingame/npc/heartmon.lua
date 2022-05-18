
local tbNpc = Npc:GetClass("heartmonster")

function tbNpc:OnDeath(pKiller)
	local pPlayer = pKiller.GetPlayer();
	if not pPlayer then
		return 0;
	end
	local tbTmp = him.GetTempTable("KinGame");
	local tbHeartMonster = KinGame.tbHeartMonster;
	local nMapId 	= him.nMapId;
	local nPosX 	= math.floor(tbHeartMonster.MONSTERROOM[tbTmp.nRoomId].tbPlayerOut[1]/32);
	local nPosY		=	math.floor(tbHeartMonster.MONSTERROOM[tbTmp.nRoomId].tbPlayerOut[2]/32);
	local pGame =  KinGame:GetGameObjByMapId(nMapId) --ö
	pGame:DelHeartRoomNpc(pPlayer.nId, him.dwId);
	local pItem = pPlayer.AddItemEx(unpack(tbHeartMonster.MIYAO_ITEM_ID));
	if pItem then
		me.SetItemTimeout(pItem, tbHeartMonster.MIYAO_ITEM_TIME);
		pItem.Sync();
		pPlayer.Msg("Đánh bại thây ma, nhận được Bí dược.");
	else
		pPlayer.Msg("Hành trang của bạn đã đầy!");
	end
	KinGame:GiveEveryOneAward(nMapId);
	tbHeartMonster:AddMonsterItem(tbTmp.nRoomId, nMapId);
	pPlayer.NewWorld(nMapId, nPosX, nPosY);
end

