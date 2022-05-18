-----------------------------------------------------------
-- 文件名　：zhunbeiqunpc.lua
-- 文件描述：准备区脚本 [路路通] [留一半]
-- 创建者　：ZhangDeheng
-- 创建时间：2008-11-26 20:21:59
-----------------------------------------------------------

-- 路路通
local tbNpc = Npc:GetClass("lulutong");
-- 传送的位置
tbNpc.tbPos = {
	{"Bích Ngô Phong", 1714, 2980,},
	{"Thần Thù Phong", 1876, 2991,},
	{"Linh Hạt Phong", 1936, 2723,},
	{"Thiên Tuyệt Phong", 1777, 2739,},
	};

function tbNpc:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	local szMsg = "Đây là đường tắt để đi tới các điểm trong bản đồ, ngươi có thể di chuyển đến các ải đã được tổ đội vượt qua, có thể đi qua ta. Tuy nhiên, cần phải trả 500 bạc.";
	local tbOpt = {};
	for i = 1, #self.tbPos do
		tbOpt[#tbOpt + 1] = {"Đi" .. self.tbPos[i][1], tbNpc.Send, self, i, tbInstancing, me.nId};
	end;
	tbOpt[#tbOpt + 1] = {"Kết thúc đối thoại"};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:Send(nPos, tbInstancing, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end;
	
	if (pPlayer.nCashMoney < 500) then
		Task.tbArmyCampInstancingManager:Warring(pPlayer, "Ngươi không đủ tiền!");
		return;
	end
	
	if (nPos == 1 and tbInstancing.nTaoHuaShiPass == 1) then
		self:SendToNewPos(nPos, tbInstancing.nMapId, nPlayerId);
		return;
	elseif (nPos == 2 and tbInstancing.nBiWuFengPass == 1) then
		self:SendToNewPos(nPos, tbInstancing.nMapId, nPlayerId);
		return;
	elseif (nPos == 3 and tbInstancing.nShenZhuFengPass == 1) then
		self:SendToNewPos(nPos, tbInstancing.nMapId, nPlayerId);
		return;
	elseif (nPos == 4 and tbInstancing.nLingXieFengPass == 1) then
		self:SendToNewPos(nPos, tbInstancing.nMapId, nPlayerId);
		return;
	end;

	Task.tbArmyCampInstancingManager:Warring(pPlayer, "Chỉ sử dụng để đi tắt đến ải đã vượt qua");
end;

function tbNpc:SendToNewPos(nPos, nMapId, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end;
		
	assert(pPlayer.CostMoney(500, Player.emKPAY_CAMPSEND) == 1);
	pPlayer.NewWorld(pPlayer.nMapId, tbNpc.tbPos[nPos][2], tbNpc.tbPos[nPos][3]);	
	pPlayer.SetFightState(1);	
end;

local tbLiuYiBan = Npc:GetClass("liuyiban");

tbLiuYiBan.tbLifePresentText = {
[99] = "Không, đừng lại gần tôi! Tôi không có gì ở đây!",
[80] = {"Nếu tôi không thể đánh bại tôi, tôi sẽ bỏ chạy", "Các bạn thực sự đang theo dõi tôi trong bóng tối"},
[60] = {"Hãy lên nếu bạn có khả năng!", "Các bạn thực sự bắt kịp!"},
[40] = {"Tôi chạy! Tôi sẽ chạy lại!", "Bạn có thể nghỉ một chút!"},
[20] = {"Không, tôi mệt!", "Các bạn thực sự đang theo dõi tôi!"},
[0] = "Bạn ... để lại cho tôi một nửa ...",
}

tbLiuYiBan.tbDrop = {
	{"\setting\npc\droprate\qd.txt", 8},
	{"\setting\npc\droprate\qd.txt", 8},
	{"\setting\npc\droprate\qd.txt", 8},
	{"\setting\npc\droprate\qd.txt", 8},
	{"\setting\npc\droprate\qd.txt", 8},	
}

function tbLiuYiBan:OnDeath(pNpc)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nLiuYiBanOutCount > 5) then
		return;
	end;
	
	him.SendChat(self.tbLifePresentText[0]);
	
	local tbPlayList, nCount = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg(self.tbLifePresentText[0], him.szName);
	end;
	
	local nId = 0;
	if (pNpc and pNpc.GetPlayer()) then
		nId = pNpc.GetPlayer().nId;
	else
		nId = tbPlayList[1].nId;
	end;
	him.DropRateItem(self.tbDrop[tbInstancing.nLiuYiBanOutCount][1], self.tbDrop[tbInstancing.nLiuYiBanOutCount][2], -1, -1, nId);
end;

function tbLiuYiBan:OnLifePercentReduceHere(nLifePercent)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nLiuYiBanOutCount == 0 or tbInstancing.nLiuYiBanOutCount >= 5) then
		return;
	end;
	if (nLifePercent == 99) then
		him.SendChat(self.tbLifePresentText[nLifePercent]);
		return;
	end;
	
	him.SendChat(self.tbLifePresentText[nLifePercent][1]);
	
	local tbPlayList, nCount = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg(self.tbLifePresentText[nLifePercent][1], him.szName);
	end;
	-- 掉落物品
	him.DropRateItem(self.tbDrop[tbInstancing.nLiuYiBanOutCount][1], self.tbDrop[tbInstancing.nLiuYiBanOutCount][2], -1, -1, tbPlayList[1].nId);
	tbInstancing.nLiuYiBanOutCount = tbInstancing.nLiuYiBanOutCount + 1;
	him.Delete();
end;