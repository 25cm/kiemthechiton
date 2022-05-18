-- 传送去鳄神殿的Npc

-- 上交指定数目的材料可以到下一关
local tbNpc = Npc:GetClass("yunxiaodao");

tbNpc.tbNeedItemList = 
{
	{20, 1, 486, 1, 2},
}

function tbNpc:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nEShenDianPass == 1) then
		Dialog:Say("Ngươi có muốn vào Ngạc Thần Điện?",
		{
			{"Vào Ngạc Thần Điện", self.Send, self, tbInstancing, me.nId},
			{"Kết thúc đối thoại"}
		})
	else
	Dialog:Say("Vân Tiểu Đao: \"Thực sự là kỳ quái, ở đây lưu lại một tòa thượng cổ Ngạc Thần Điện, thần điện này nhất định có cái gì bí mật. Ta đợi huynh đệ có khí lực thật lớn dám xông vào thần điện, ngươi nếu muốn xông vào, đưa hai Chìa Khóa Mê Cung cho ta, coi như là lộ phí đi đường!\"",
		{
			{"Đưa 2 Chìa Khóa Mê Cung cho Vân Tiểu Đao", self.Give, self, tbInstancing, me.nId},
			{"Kết thúc đối thoại"}
		})
	end
end

function tbNpc:Give(tbInstancing, nPlayerId)
	Task:OnGift("Giao cho Vân Tiểu Đao hai Chìa Khóa Mê Cung có thể xông vào Ngạc Thần Điện.", self.tbNeedItemList, {self.Pass, self, tbInstancing, nPlayerId}, nil, {self.CheckRepeat, self, tbInstancing});
end

function tbNpc:Send(tbInstancing)
	me.NewWorld(tbInstancing.nMapId, 1819, 3941);
end


function tbNpc:Pass(tbInstancing, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);	
	tbInstancing.nEShenDianPass = 1;
	if (pPlayer) then
		Task.tbArmyCampInstancingManager:ShowTip(pPlayer, "Bây giờ có thể yên tâm xông vào Ngạc Thần Điện");
	end
end

function tbNpc:CheckRepeat(tbInstancing)
	if (tbInstancing.nEShenDianPass == 1) then
		return 0;
	end
	
	return 1; 
end
