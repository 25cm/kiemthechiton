-- 传送去蛮瘴山的Npc

-- 上交指定数目的材料可以到下一关
local tbNpc = Npc:GetClass("yundadao");

tbNpc.tbNeedItemList = 
{
	{20, 1, 487, 1, 2},
}

function tbNpc:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nManZhangShanPass == 1) then
		Dialog:Say("Ngươi có muốn vào Man Chướng Sơn?",
		{
			{"Vào Man Chướng Sơn", self.Send, self, tbInstancing, me.nId},
			{"Kết thúc đối thoại"}
		})
	else
	Dialog:Say("Vân Đại Đao: \"Lần này ta đợi huynh đệ mấy người đến đây man chướng sơn tầm bảo, mất thật lớn khí lực tài hòa ở đây đích man nhân bộ hảo giao tình. Nếu ngươi muốn vào Man Chướng Sơn, ta sẽ giúp. Bất quá chúng ta khoái đao môn dĩ lợi trước, trước tiên ngươi phải đưa ta 2 Cốt Ngọc Đồ Đằng mới được.\"",
		{
			{"Đưa 2 Cốt Ngọc Đồ Đằng cho Vân Đại Đao", self.Give, self, tbInstancing, me.nId},
			{"Kết thúc đối thoại"}
		})
	end
end

function tbNpc:Give(tbInstancing, nPlayerId)
	Task:OnGift("Giao cho Vân Đại Đao hai Cốt Ngọc Đồ Đằng liền khả tại hắn đích đái lĩnh hạ vào man chướng sơn.", self.tbNeedItemList, {self.Pass, self, tbInstancing, nPlayerId}, nil, {self.CheckRepeat, self, tbInstancing});
end

function tbNpc:Send(tbInstancing)
	me.NewWorld(tbInstancing.nMapId, 1911, 3000);
end


function tbNpc:Pass(tbInstancing, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);	
	tbInstancing.nManZhangShanPass = 1;
	if (pPlayer) then
		Task.tbArmyCampInstancingManager:ShowTip(pPlayer, "Bây giờ có thể yên tâm vào Man Chướng Sơn");
	end
end

function tbNpc:CheckRepeat(tbInstancing)
	if (tbInstancing.nManZhangShanPass == 1) then
		return 0;
	end
	
	return 1; 
end
