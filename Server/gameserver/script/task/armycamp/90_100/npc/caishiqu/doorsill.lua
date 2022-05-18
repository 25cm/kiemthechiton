-- 上交指定数目的材料可以到下一关
local tbNpc = Npc:GetClass("caishiqudoorsill");

tbNpc.tbNeedItemList = 
{
	{20,1,603,1,20},
}


function tbNpc:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if(tbInstancing.nCaiShiQuColItem == 1) then
		Task.tbArmyCampInstancingManager:ShowTip(me,"Thiết thạch khí đã bị hỏng");
		return;
	end
	
	Dialog:Say("Thu thập 20 “đạo cụ” từ thợ thủ công, bỏ vào dụng cụ cắt đá để hủy hoại dụng cụ cắt đá.",
		{
			{"<color=yellow>Đưa đạo cụ<color>", self.Destroy, self, tbInstancing},
			{"Kết thúc đối thoại"}
		})	
	
end

function tbNpc:Destroy(tbInstancing)
	if (tbInstancing.nCaiShiQuColItem ~= 1) then
		Task:OnGift("Nhận được 20 đạo cụ, có thể hủy hoại dụng cụ cắt đá", self.tbNeedItemList, {self.PassCaiKuangQu, self, tbInstancing}, nil, {self.CheckRepeat, self, tbInstancing});
	end
end

function tbNpc:PassCaiKuangQu(tbInstancing)
	TaskAct:Talk("<npc=4002>: \"Các ngươi là đồ ngu, mạo phạm mà là chuyện tốt? Xem ta giáo huấn các ngươi.\"");
	tbInstancing.nCaiShiQuColItem = 1;
	KNpc.Add2(4002, tbInstancing.nNpcLevel, -1, tbInstancing.nMapId, 1696, 3880);
end


function tbNpc:CheckRepeat(tbInstancing)
	if (tbInstancing.nCaiShiQuColItem == 1) then
		return 0;
	end
	
	return 1;
end
