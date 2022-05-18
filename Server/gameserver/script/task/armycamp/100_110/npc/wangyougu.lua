-----------------------------------------------------------
-- 文件名　：wangyougu.lua
-- 文件描述：忘忧谷脚本
-- 创建者　：ZhangDeheng
-- 创建时间：2008-12-12 09:38:03
-----------------------------------------------------------

-- 火蓬春 对话
local tbHuoPengChen_Dialog = Npc:GetClass("huopengchen_dialog");

tbHuoPengChen_Dialog.tbNeedItemList = { {20, 1, 624, 1, 1}, {20, 1, 625, 1, 1}};

function tbHuoPengChen_Dialog:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	if (tbInstancing.nHuoPengChenOut ~= 0) then
		return;
	end;
	
	local szMsg = "Cút đi, lão tử lại để cho ngươi chết sao?？";
	Dialog:Say(szMsg,
		{
			{"Để hạt và chữ thiền", self.Give, self, tbInstancing, me.nId, him.dwId},
			{"Kết thúc đối thoại"}
		});
	
end;

function tbHuoPengChen_Dialog:Give(tbInstancing, nPlayerId, nNpcId)
	Task:OnGift("Hãy xem xét những điều này một cách cẩn thận！", self.tbNeedItemList, {self.Pass, self, tbInstancing, nPlayerId, nNpcId}, nil, {self.CheckRepeat, self, tbInstancing}, true);
end;

function tbHuoPengChen_Dialog:CheckRepeat(tbInstancing)
	if (tbInstancing.nHuoPengChenOut == 1) then
		return 0;
	end	
	return 1; 
end

function tbHuoPengChen_Dialog:Pass(tbInstancing, nPlayerId, nNpcId)
	if (tbInstancing.nHuoPengChenOut ~= 0) then
		return;
	end;
	
	local szMsg = "Hạt châu này dường như là do lão nhân gia tặng cho cô gái nhỏ ở Âm Tông kia, làm sao có thể ở trong tay ngươi được? Và những ghi chú của bức thư này cũng rất quen thuộc, hình như là của cô gái nhỏ của Âm Tống, để anh xem em đã viết gì.。<color=yellow>\
     《Tôi thật ngu ngốc》    《Nằm mùa xuân》\
  Tôi không có văn hóa (NPC), \
  IQ của tôi rất thấp, \
    Tôi muốn hỏi tôi là ai, \
    Một con lừa lớn ngu ngốc (NPC), \
    Tôi là một con lừa (bờ biển giống như màu xanh lá cây), \
    Tôi là một con lừa (bờ biển giống như màu xanh lá cây xuyên qua), \
    Tôi là một con lừa câm (bờ như lục). <color>";
	
	Dialog:Say(szMsg,
	{
		{"Kết thúc đối thoại", self.ChangeFight, self, tbInstancing, nNpcId},
	});
	if (tbInstancing.nHuoPengChenOut == 0 and not tbInstancing.nHuoPengChenTimerId) then
		tbInstancing.nHuoPengChenTimerId = Timer:Register(Env.GAME_FPS * 0.5, self.OnClose, self, tbInstancing, nNpcId);
	end;
end;

function tbHuoPengChen_Dialog:OnClose(tbInstancing, nNpcId)
	self:ChangeFight(tbInstancing, nNpcId);
	if (tbInstancing.nHuoPengChenTimerId) then
		Timer:Close(tbInstancing.nHuoPengChenTimerId);
		tbInstancing.nHuoPengChenTimerId = nil;
	end;
	return 0;
end;

function tbHuoPengChen_Dialog:ChangeFight(tbInstancing, nNpcId)
	assert(tbInstancing, nPlayerId, nNpcId);
	if (tbInstancing.nHuoPengChenOut ~= 0) then
		return;
	end;
	
	local pNpc = KNpc.GetById(nNpcId);
	local nSubWorld, nPosX, nPosY	= him.GetWorldPos();
	pNpc.Delete();
	
	local pNpc = KNpc.Add2(4145, tbInstancing.nNpcLevel, -1, nSubWorld, nPosX, nPosY);
	tbInstancing.nHuoPengChenOut = 1;
	pNpc.AddLifePObserver(90);
	pNpc.AddLifePObserver(70);
	pNpc.AddLifePObserver(60);
	pNpc.AddLifePObserver(40);
	pNpc.AddLifePObserver(30);
	pNpc.AddLifePObserver(20);
	pNpc.AddLifePObserver(10);
	pNpc.AddLifePObserver(5);
	pNpc.AddLifePObserver(4);
	pNpc.AddLifePObserver(3);
	pNpc.AddLifePObserver(2);
	
	local tbNpc = Npc:GetClass("huopengchen_fight");

	if (tbNpc) then
		tbInstancing:NpcSay(pNpc.dwId, tbNpc.tbSayText[100]);
	end;
	
end;

-- 火蓬春 战斗
local tbHuoPengChen_Fight = Npc:GetClass("huopengchen_fight");

tbHuoPengChen_Fight.tbSayText = {
	[100] = {"NPC, bộ phim về cô gái nhỏ này!", "Đừng quên trêu chọc mọi người sau khi mọi người đi hết!"},
[90] = {"Ông già sắp chết, phải không?", "Tôi đã nghe về tất cả ở trên!"},
[70] = {"Ông già sắp chết, gầm lên!", "Tôi không phải là trưởng nhóm ở đây sao?"},
[60] = {"Chờ tôi dọn dẹp mọi người ở đây!", "Hãy nhìn cách tôi dọn dẹp cho bạn!"},
[40] = {"Tôi chắc chắn sẽ không vô dụng như chủ nhân của tôi!"},
[30] = {"Tôi phải cho họ xem!", "Tôi thật tuyệt vời!"},
[20] = {"Đúng, có cô gái nhỏ của Yin Tong!", "Tôi nhất định phải bắt lấy cô ấy!", "Để cô ấy làm vợ tôi!"},
[10] = {"Bạn không thể nhấn vào nó!", "A! Tại sao Gus của tôi không được tuyển dụng?", "Bạn đã làm gì tôi?"},
[5] = "Lão bản có cho Âm Tông ...",
[4] = "Ôi ông già chết tiệt!",
[3] = "Bạn thật là bất hiếu muốn chết!",
[2] = "Tôi ... tôi ...",
[0] = "Tôi ghét bạn ...",
}

function tbHuoPengChen_Fight:OnLifePercentReduceHere(nLifePercent)
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;

	if (nLifePercent < 10 and him) then
		him.SendChat(self.tbSayText[nLifePercent]);
		
		local tbPlayList, nCount = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			teammate.Msg(self.tbSayText[nLifePercent], him.szName);
		end;
		return;
	end;
	
	tbInstancing:NpcSay(him.dwId, self.tbSayText[nLifePercent]);
end;

function tbHuoPengChen_Fight:OnDeath(pNpc)
	-- 掉一个宝箱
	local nSubWorld, nNpcPosX, nNpcPosY = him.GetWorldPos();
	local pBaoXiang = KNpc.Add2(4113, 1, -1, nSubWorld, nNpcPosX, nNpcPosY);
	assert(pBaoXiang)

	local pPlayer  	= pNpc.GetPlayer();
	pBaoXiang.GetTempTable("Task").nOwnerPlayerId = pPlayer.nId;
	pBaoXiang.GetTempTable("Task").CUR_LOCK_COUNT = 0;
	
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		Task.tbArmyCampInstancingManager:ShowTip(teammate, "Một chiếc hộp sáng bóng xuất hiện trên mặt đất！");
	end;
end;

-- 雪羽鸿飞
local tbXueYuHongFei = Npc:GetClass("xueyuhongfei");

tbXueYuHongFei.tbText = {
	[99] = "Mày là ai mà dám xông vào vùng cấm.",
[90] = "Không có gì ở đây, bạn muốn gì?",
[70] = {"Có phải anh ấy không?", "Huo Pengchun đã hẹn bạn đến?"},
[50] = {"Bạn? Bạn biết gì không?", "Bạn có biết mình đang làm gì không?"},
[30] = "Có vẻ như bạn biết gì?",
[0] = "Bạn sẽ hối hận!",
}

function tbXueYuHongFei:OnLifePercentReduceHere(nLifePercent)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (nLifePercent == 50 or nLifePercent == 70) then
		tbInstancing:NpcSay(him.dwId, self.tbText[nLifePercent]);
		return;
	end;
		
	local tbPlayList, nCount = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg(self.tbText[nLifePercent], him.szName);
	end;
	him.SendChat(self.tbText[nLifePercent]);
end;