local tbNpc = Npc:GetClass("send2caikuangqu");

function tbNpc:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	Dialog:Say("Tàu chỉ cần sửa chữa",
		{
			{"<color=yellow>Lên thuyền đi tới Tê Giác Khoáng<color>", self.Send, self, tbInstancing},
			{"Kết thúc đối thoại"}
		})	
end

function tbNpc:Send(tbInstancing)
	me.NewWorld(tbInstancing.nMapId, 1878, 3464);
end



local tbNpc1 = Npc:GetClass("outcaishiqu");

function tbNpc1:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	Dialog:Say("Đường thủy này về Đồi Canh là đường duy nhất",
		{
			{"<color=yellow>Đưa ta về Đồi Canh<color>", self.Send, self, tbInstancing},
			{"Kết thúc đối thoại"}
		})
end

function tbNpc1:Send(tbInstancing)
	me.NewWorld(tbInstancing.nMapId, 1643, 3623);
end
