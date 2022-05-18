-- 牛栏寨
-- 上交指定数目的材料可以到下一关
local tbNpc = Npc:GetClass("qianlai");

tbNpc.tbNeedItemList = 
{
	{20, 1, 485, 1, 2},
}

function tbNpc:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nNiuLanZhaiPass ~= 1) then
		Dialog:Say("Tiền Lai: \"Ta đợi phụng hồ gia đại nhân chi mệnh vào Ngưu Lan Trại dò hỏi tin tức, may mắn trở thành lính gác trong đại môn. Ngươi nếu thị nghĩa quân huynh đệ, vậy đưa hai Ngưu Lan Trại Yêu Bài cho ta, đây là hồ đại nhân hạ đích mệnh lệnh, không cos ta cũng không thể đưa ngươi vào trong Ngưu Lan Trại.\"",
		{
			{"Đưa 2 Ngưu Lan Trại Yêu Bài cho Tiền Lai", self.Give, self, tbInstancing, me.nId},
			{"Kết thúc đối thoại"}
		})
	end
end

function tbNpc:Give(tbInstancing, nPlayerId)
	Task:OnGift("Giao cho Tiền Lai hai Ngưu Lan Trại Yêu Bài có thể xông vào Ngưu Lan Trại.", self.tbNeedItemList, {self.Pass, self, tbInstancing, nPlayerId}, nil, {self.CheckRepeat, self, tbInstancing});
end

function tbNpc:Send(tbInstancing)
	--me.NewWorld(tbInstancing.nMapId, 1911, 3000);
end


function tbNpc:Pass(tbInstancing, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);	
	tbInstancing.nNiuLanZhaiPass = 1;
	local pNpc = KNpc.GetById(tbInstancing.nNiuLanZhaiLaoMenId);
	if (pNpc) then
		pNpc.Delete();
	end
	
	if (pPlayer) then
		Task.tbArmyCampInstancingManager:ShowTip(pPlayer, "Bây giờ có thể yên tâm vào Ngưu Lan Trại");
	end
end

function tbNpc:CheckRepeat(tbInstancing)
	if (tbInstancing.nNiuLanZhaiPass == 1) then
		return 0;
	end
	
	return 1; 
end
