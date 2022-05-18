-- 上交指定数目的材料可以到下一关
local tbNpc = Npc:GetClass("caikuangqudoorsill");

tbNpc.tbNeedItemList = 
{
	{20, 1, 604, 1, 3},
	{20, 1, 605, 1, 3},
}

function tbNpc:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nCaiKuangQuPass == 1) then
		Dialog:Say("Thuyền đã được sữa chưa, lên thuyền để đi tới mỏ đá.",
		{
			{"<color=yellow>Lên thuyền tới mỏ đá<color>", self.Send, self, tbInstancing, me.nId},
			{"Kết thúc đối thoại"}
		})
	else
	Dialog:Say("Thuyền đã bị hỏng, thu thập 3 gỗ 3 dây thừng để sửa thuyền.",
		{
			{"<color=yellow>Sửa chữa thuyền<color>", self.Fix, self, tbInstancing, me.nId},
			{"Kết thúc đối thoại"}
		})
	end
end

function tbNpc:Fix(tbInstancing, nPlayerId)
	Task:OnGift("Thuyền đã bị hỏng, thu thập 3 gỗ 3 dây thừng để sửa thuyền.", self.tbNeedItemList, {self.PassCaiKuangQu, self, tbInstancing, nPlayerId}, nil, {self.CheckRepeat, self, tbInstancing});
end

function tbNpc:Send(tbInstancing)
	me.NewWorld(tbInstancing.nMapId, 1668, 3764);
end


function tbNpc:PassCaiKuangQu(tbInstancing, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);	
	tbInstancing.nCaiKuangQuPass = 1;
	if (pPlayer) then
		Task.tbArmyCampInstancingManager:ShowTip(pPlayer, "Thuyền cũ đã được sửa chữa");
	end
end

function tbNpc:CheckRepeat(tbInstancing)
	if (tbInstancing.nCaiKuangQuPass == 1) then
		return 0;
	end
	
	return 1; 
end
