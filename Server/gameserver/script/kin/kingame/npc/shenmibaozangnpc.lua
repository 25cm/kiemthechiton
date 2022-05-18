local tbNpc = Npc:GetClass("shenmibaozangnpc")

function tbNpc:OnDeath()
	KinGame:NpcUnLockMulti(him);	
end

local tbYouhun = Npc:GetClass("mingfuyouhun");

function tbYouhun:OnDeath()
	local pGame =  KinGame:GetGameObjByMapId(him.nMapId)
	if not pGame then
		return;
	end
	local tbPlayer = pGame:GetPlayerList() or {};
	for _, pPlayer in pairs(tbPlayer) do
		if pPlayer.nLevel < 60 then
			pPlayer.AddKinReputeEntry(5, "kingame");
		elseif pPlayer.nLevel < 80 then
			pPlayer.AddKinReputeEntry(3, "kingame");
		end
	end
	KinGame:NpcUnLockMulti(him);
end
