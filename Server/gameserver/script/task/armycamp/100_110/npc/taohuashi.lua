-----------------------------------------------------------
-- 文件名　：taohuashi.lua
-- 文件描述：对话桃花使及战斗桃花使
-- 创建者　：ZhangDeheng
-- 创建时间：2008-11-26 17:26:10
-----------------------------------------------------------

-- 战斗桃花使
local tbTaoHuaShi_Fight = Npc:GetClass("taohuashifight");

tbTaoHuaShi_Fight.tbText = {
	[70] = {"Có vẻ như bạn ở đây đã chuẩn bị sẵn sàng! "," Nhưng tôi không phải là người ăn chay, ông ơi! "," Để bạn thấy tôi giỏi như thế nào!"},
	[50] = {"Tôi cảm thấy hơi lo lắng! "," Chúng ta ngồi xuống và nói chuyện thì sao? "," Đừng cứng đầu như vậy, bạn nhé？"},
	[20] = {"Tất cả đều ở ngoài đây, vì vậy chúng ta hãy thể hiện một số khuôn mặt! "," Điều đó không dễ dàng cho tất cả mọi người! "," Chúng ta dừng lại, OK?？"},
	[10] = {"Đúng là một đứa trẻ! Không ăn cứng và mềm đúng không? "," Chúng ta hãy chờ xem bạn có tàn nhẫn không！"},
	[0]  = {"Tôi thực sự không mong đợi……"},
}
-- 死亡时执行
function tbTaoHuaShi_Fight:OnDeath(pNpc)
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;
	him.SendChat(self.tbText[0][1]);
	
	tbInstancing.nTaoHuaShiPass = 1;
	if (not tbInstancing.nJinZhiTaoHuaLin) then
		return;
	end;
	
	local pNpc = KNpc.GetById(tbInstancing.nJinZhiTaoHuaShi);
	if (pNpc) then
		pNpc.Delete();
	end;
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		Task.tbArmyCampInstancingManager:ShowTip(teammate, "Bạn có thể đi tiếp！");
	end;
end;

-- 血量在一定的时候执行
function tbTaoHuaShi_Fight:OnLifePercentReduceHere(nLifePercent)
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;
	tbInstancing:NpcSay(him.dwId, self.tbText[nLifePercent]);
end;

-- 对话桃花使
local tbTaoHuaShi_Dialog = Npc:GetClass("taohuashidialog");

tbTaoHuaShi_Dialog.tbText = {
"Nào! Nào! Tôi sốt ruột quá!",
"Bạn có thực sự nghĩ rằng bạn có thể vượt qua ngọn núi của tôi?",
"Vô số người đã thử nó trước bạn!",
}
-- 对话
function tbTaoHuaShi_Dialog:OnDialog()
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (tbInstancing.nTaoHuaShiOut ~= 0) then
		return;
	end;
	
	local szMsg = string.format("%s：Mang nó vào! mang nó vào! Tôi rất thiếu kiên nhẫn！", him.szName);
	local tbOpt = {
		{"Bắt đầu chiến đấu", self.Fight, self, me.nId, him.dwId},
		{"Kết thúc đối thoại"},
	}
	Dialog:Say(szMsg, tbOpt);
end;

-- 对话转战斗
function tbTaoHuaShi_Dialog:Fight(nPlayerId, nNpcId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	local pNpc = KNpc.GetById(nNpcId);
	if (not pPlayer or not pNpc) then
		return;
	end;
	
	local nSubWorld, nNpcPosX, nNpcPosY = pNpc.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	if (tbInstancing.nTaoHuaShiOut ~= 0) then
		return;
	end
	-- 战斗桃花使
	local pTaoHuaShi = KNpc.Add2(4171, tbInstancing.nNpcLevel, -1 , nSubWorld, nNpcPosX, nNpcPosY);
	assert(pTaoHuaShi);
	tbInstancing:NpcSay(pTaoHuaShi.dwId, self.tbText);
	
	pTaoHuaShi.AddLifePObserver(70);
	pTaoHuaShi.AddLifePObserver(50);
	pTaoHuaShi.AddLifePObserver(20);
	pTaoHuaShi.AddLifePObserver(10);
	
	tbInstancing.nTaoHuaShiOut = 1;
	pNpc.Delete();
end;

