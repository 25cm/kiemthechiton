-----------------------------------------------------------
-- 文件名　：biwufengnpc.lua
-- 文件描述：蛊翁，毒蝎幼虫，蝎王
-- 创建者　：ZhangDeheng
-- 创建时间：2008-11-26 18:11:25
-----------------------------------------------------------

-- 蛊翁
local tbGuWeng = Npc:GetClass("guweng");

-- 幼虫ID
tbGuWeng.nYouChongId = 4126;

-- 幼虫出现的位置
tbGuWeng.tbYouChongPos = {
	{1777, 3069}, {1784, 3069}, {1787, 3081}, {1779, 3091}, {1773, 3079},
};

-- 
tbGuWeng.tbLifePresent = {99, 90, 80, 70, 30, 10,};

tbGuWeng.tbLifePresentText = {
	[99] = {{"Anh hai, họ đang đập vỡ bình ghen tị của anh", "Tian Jue Shi"}, {"Im đi, tôi không phải là không có mắt", "Rết Xanh"}},
[90] = {{"Anh hai, còn đập phá!", "Đặc sứ"}, {"Nhìn mà nói, Gu của tôi không phải để nuôi mà xem!", "Rết Xanh"}},
[80] = {{"Anh hai, Gu của anh hình như không mạnh lắm!", "Sứ Thần"}, {"Vớ vẩn, anh biết gì không, hiện tại ra mặt cũng vô dụng, thế lực đã ở phía sau!" , "Rết Xanh"}},
[70] = {{"Anh hai ......", "Đặc phái viên"}, {"Im đi!", "Đặc phái viên Rết Xanh"}},
[30] = {"Anh hai, em thấy Gu của anh thật tệ! Em sợ nó không có mùi đúng không?", "Sứ Thần"},
[10] = {{"Anh hai, em không nghĩ anh ở đây an toàn lắm!", "NPC"}, {"Buổi biểu diễn hay vẫn chưa đến!", "Rết Xanh"}},
[0] = {{"NPC, bạn đã làm đủ chưa?", "Rết Xanh"}, {"Bây giờ hãy đếm xem Chúa tể của loài ngựa có bao nhiêu mắt!", "Rết Xanh"}},
}

function tbGuWeng:OnLifePercentReduceHere(nLifePercent)
	
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);

	-- 添加幼虫
	if (nLifePercent % 7 == 0) then
		for i = 1, #self.tbYouChongPos do
			for j = 1, 2 do
				KNpc.Add2(self.nYouChongId, tbInstancing.nNpcLevel, -1 , nSubWorld, self.tbYouChongPos[i][1], self.tbYouChongPos[i][2]);
			end;
		end;
	end;
	
	-- 说话
	for i = 1, #self.tbLifePresent do 
		if (nLifePercent == self.tbLifePresent[i]) then
			local tbPlayList, nCount = KPlayer.GetMapPlayer(tbInstancing.nMapId);
			for _, teammate in ipairs(tbPlayList) do
				teammate.Msg(self.tbLifePresentText[nLifePercent][1][1],self.tbLifePresentText[nLifePercent][1][2]);
				teammate.Msg(self.tbLifePresentText[nLifePercent][2][1],self.tbLifePresentText[nLifePercent][2][2]);
			end;
		end;
	end;
end;

function tbGuWeng:OnDeath(pNpc)
	local nSubWorld, _, _ = him.GetWorldPos();	
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
		
	local tbPlayList, nCount = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg(self.tbLifePresentText[0][1][1],self.tbLifePresentText[0][1][2]);
		teammate.Msg(self.tbLifePresentText[0][2][1],self.tbLifePresentText[0][2][2]);
	end;
end;

-- 毒蝎幼虫
local tbDuXieYouChong = Npc:GetClass("youchong");
-- 需要杀的数量
tbDuXieYouChong.NEED_COUNT		= 100;

-- 死亡时执行
function tbDuXieYouChong:OnDeath(pNpc)
	local nSubWorld, nNpcPosX, nNpcPosY = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;
	
	tbInstancing.nDuXieYouChong = tbInstancing.nDuXieYouChong + 1;
	if (tbInstancing.nDuXieYouChong >= self.NEED_COUNT and tbInstancing.nXieWangOut == 0) then
		local pXieWang = KNpc.Add2(4127, tbInstancing.nNpcLevel, -1 , nSubWorld, 1800, 3035);
		assert(pXieWang);
		
		pXieWang.AddLifePObserver(90);
		pXieWang.AddLifePObserver(70);
		pXieWang.AddLifePObserver(50);
		pXieWang.AddLifePObserver(30);
		pXieWang.AddLifePObserver(10);
		tbInstancing.nXieWangOut = 1;
		-- 留一半
		if (tbInstancing.nLiuYiBanOutCount ~= 0) then
			local pNpc = KNpc.Add2(4155, tbInstancing.nNpcLevel, -1, nSubWorld, 1804, 3036);
			pNpc.AddLifePObserver(60);
		end;
		
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			Task.tbArmyCampInstancingManager:ShowTip(teammate, "Rết xanh đã xuất hiện");
		end;
	end;
end;

-- 蝎王
local tbBiWuShi = Npc:GetClass("biwushi");

tbBiWuShi.tbText = {
	[90] = {"Thảo nào đứa thứ tư sợ quá! Thật là rắc rối! "," Không có một người chơi giỏi như vậy ở Đại Lý! "," Các ngươi là cao thủ nào, báo danh! "},
	[70] = {{"Có chuyện gì vậy? Coi thường mọi người? Bạn có biết tôi là ai? "," Tôi là ông chủ của núi Baiman! "}, {" Anh hai, chị cả biết sẽ khó chịu! "," Thiên Sứ "}, {" Không vui? Cô ấy hạnh phúc khi nào? "," Nếu cô ấy hạnh phúc, cô ấy đã là vợ hai của bạn!"}},
	[50] = {"Có ý tưởng! "," Nó hơi choáng ngợp！"},
	[30] = {{"Tôi nghĩ chúng ta nên đến gặp chị cả! "," Thiến Sứ "}, {" Bạn có chân thành khi thấy tôi tự lừa mình không? "," Bi Centipede "}, {" Thà tự lừa mình còn hơn chết, đúng không? "," Thiên sứ"}},
	[10] = {{"Anh trai! Bạn có sợ rằng sẽ không có củi nếu giữ cho những ngọn đồi xanh tươi? "," Thiên Sứ "}, {" Ồ! Gió gào thét! ","Con Rết Xanh"}},
	[0]  = {"Có vẻ hơi muộn! "," Bạn có thể chạy trốn một mình！"}
}

function tbBiWuShi:OnDeath(pNpc)
	local nSubWorld, nNpcPosX, nNpcPosY = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;
	
	local tbPlayList, nCount = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg(self.tbText[0][1], him.szName);
		teammate.Msg(self.tbText[0][2], him.szName);
	end;
	
	tbInstancing.nBiWuFengPass = 1;
	
	if (not tbInstancing.nJinZhiBiWuFeng) then
		return;
	end;
	
	local pNpc = KNpc.GetById(tbInstancing.nJinZhiBiWuFeng);
	if (pNpc) then
		pNpc.Delete();
	end;
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		Task.tbArmyCampInstancingManager:ShowTip(teammate, "Bạn có thể đến Đỉnh Nhện Thần！");
	end;
end;

function tbBiWuShi:OnLifePercentReduceHere(nLifePercent)
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;
	if (nLifePercent == 90 or nLifePercent == 50) then
			tbInstancing:NpcSay(him.dwId, self.tbText[nLifePercent]);
			him.GetTempTable("Task").tbSayOver = nil;
	end;
	if (nLifePercent == 70) then
		tbInstancing:NpcSay(him.dwId, self.tbText[nLifePercent][1]);
		him.GetTempTable("Task").tbSayOver = {self.SayOver, self, him.dwId, self.tbText[nLifePercent]};
	end;
	if (nLifePercent == 30 or nLifePercent == 10) then
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			for i = 1, #self.tbText[nLifePercent] do
				teammate.Msg(self.tbText[nLifePercent][i][1], self.tbText[nLifePercent][i][2]);
			end;
		end;
	end;
end;

function tbBiWuShi:SayOver(nNpcId, tbText)
	if (not nNpcId or not tbText) then
		return;
	end;
	
	local pNpc = KNpc.GetById(nNpcId);
	local nSubWorld, _, _ = pNpc.GetWorldPos();	
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
		
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg(tbText[2][1], tbText[2][2]);
	end;
	
	tbInstancing:NpcSay(nNpcId, tbText[3]);
	him.GetTempTable("Task").tbSayOver = nil;
end;

-- 碧蜈峰指引
local tbBiWuFengZhiYin = Npc:GetClass("biwufengzhiyin");

tbBiWuFengZhiYin.szText = "    Qua cầu là Đỉnh Bi Rết do sứ thần Bi Rết canh giữ. Bi Rết khiến những người đi trước tự tin, không bao giờ chủ động tấn công những người trẻ hơn. Nếu bạn muốn chiến đấu với anh ta, bạn phải khiêu khích anh ta.\n\n   khi đến Ải 2 về loài rết xanh, bạn sẽ thấy một chiêc Bình khổng lồ.<color=red>Chỉ cần bạn tấn công chiếc Bình này, các đồ vật có trong bình chắc chắn sẽ lao ra và gây thương tích cho mọi người, nếu các đồ vật có gu làm tổn thương quá nhiều, rết xanh đương nhiên sẽ không thể kiềm chế.<color>";

function tbBiWuFengZhiYin:OnDialog()
	local tbOpt = {{"Kết thúc"}, };
	Dialog:Say(self.szText, tbOpt);
end;