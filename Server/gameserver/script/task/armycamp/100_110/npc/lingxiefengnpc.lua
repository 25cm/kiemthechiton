-----------------------------------------------------------
-- 文件名　：lingxiefengnpc.lua
-- 文件描述：碧蜈峰NPC脚本
-- 创建者　：ZhangDeheng
-- 创建时间：2008-11-27 09:19:00
-----------------------------------------------------------

-- 铁公鸡牢门
local tbLaoMen = Npc:GetClass("laomen");

function tbLaoMen:OnDialog()
	local nSubWorld, _, _	= me.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nLaoMenDurationTime ~= 0) then
		me.Msg("Mở！")
		return;
	end;
	
		local tbEvent = 
	{
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_SITE,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
	}
	-- 
	GeneralProcess:StartProcess("Mở", 0.5 * Env.GAME_FPS, {self.Open, self, me.nId, him.dwId, tbInstancing}, {me.Msg, "Mở gián đoạn"}, tbEvent);
end;

-- 打开牢门 成功率30%
function tbLaoMen:Open(nPlayerId, nNpcId, tbInstancing)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	local pNpc = KNpc.GetById(nNpcId);
	assert(pPlayer);
	if (not pNpc) then
		return;
	end;
	
	-- 成功率30%
	local nSuccess = MathRandom(100);
	if (nSuccess < 30) then
		Task.tbArmyCampInstancingManager:ShowTip(pPlayer, "Cổng sắt mở！");
		tbInstancing.nTieGongJiLaoMen = 1;
		pNpc.Delete();
	else
		pPlayer.Msg("Mở thất bại！");
		tbInstancing.nLaoMenDurationTime = 5;
	end;
end;

-- 铁公鸡 对话
local tbTieGongJi = Npc:GetClass("tiegongji_dialog");
-- 需要的物品
tbTieGongJi.tbNeedItemList 	= { {20, 1, 626, 1, 20}, };
-- 铁公鸡的行走路线
tbTieGongJi.tbTrack			= { 
	{1870, 2694}, {1881, 2693}, {1890, 2681}, 
	{1900, 2675}, {1889, 2650}, {1871, 2650}, 
	{1866, 2638}, {1874, 2619}, {1882, 2606} 
};

tbTieGongJi.tbText = {"Ôi trời! Ôi trời! Ai đây? "," Ai đã mang đến một tên đáng ghét như vậy？"};

function tbTieGongJi:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	if (tbInstancing.nTieGongJiOut == 1) then
		return;
	end;
	
	Dialog:Say("Đặt vào 20 Đuôi Bò Cạp, ta sẽ giúp ngươi khống chế lũ Bò Cạp.",
		{
			{"<color=yellow>Đưa Đuôi Bò Cạp<color>", self.Give, self, tbInstancing, me.nId, him.dwId},
			{"Kết thúc đối thoại"}
		});
end;

function tbTieGongJi:Give(tbInstancing, nPlayerId, nNpcId)
	Task:OnGift("Đặt vào 20 Đuôi Bò Cạp.", self.tbNeedItemList, {self.Pass, self, tbInstancing, nPlayerId, nNpcId}, nil, {self.CheckRepeat, self, tbInstancing}, true);
end;

function tbTieGongJi:CheckRepeat(tbInstancing)
	if (tbInstancing.nTieGongJiOut == 1) then
		return 0;
	end	
	return 1; 
end

function tbTieGongJi:Pass(tbInstancing, nPlayerId, nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc) then
		return;
	end;
	local nSubWorld, nPosX, nPosY	= him.GetWorldPos();
	pNpc.Delete();
	
	if (tbInstancing.nTieGongJiLaoOut == 1) then
		return;
	end;
	local pFightNpc = KNpc.Add2(4170, 100, -1, nSubWorld, nPosX, nPosY);
	tbInstancing.nTieGongJiOut = 1;
	tbInstancing.dwFightGongJiId = pFightNpc.dwId;
	
	tbInstancing:Escort(pFightNpc.dwId, nPlayerId, self.tbTrack, 50, 1);
	pFightNpc.GetTempTable("Npc").tbOnArrive = {self.OnArrive, self, pFightNpc.dwId, me.nId};
	
	tbInstancing.bLXSCastSkill = false;
	
	if (tbInstancing.nLingXieShiId) then
		local pNpc = KNpc.GetById(tbInstancing.nLingXieShiId);
		if (not pNpc) then
			return;
		end;
		pNpc.RemoveSkillState(999);
	end;
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg("Oh! oh! oh!", pFightNpc.szName);
		Task.tbArmyCampInstancingManager:ShowTip(teammate, "Tiếng hét của gà trống vàng mỏ sắt đã làm mất tác dụng của chiếc lọ đựng chuông vàng của bọ cạp");
	end;
end;

function tbTieGongJi:OnArrive(dwNpcId, nPlayerId)

	assert(dwNpcId and nPlayerId);
	local pNpc = KNpc.GetById(dwNpcId);
	if not pNpc then  --加上保护 zounan
		return;
	end
	local nSubWorld, _, _	= pNpc.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);

	local tbNpc = Npc:GetClass("lingxieshi");
	tbInstancing:NpcSay(tbInstancing.nLingXieShiId, self.tbText);
end;

-- 灵蝎使
local tbLingXieShi = Npc:GetClass("lingxieshi");

tbLingXieShi.tbText = {
	[99] = "Mức độ này không phải là quá tốt！",
	[50] = {"Cút đi, mau cất đi! ", "Tôi xin bạn! Mang nó đi！"},
	[30] = "Chết tiệt, tôi sẽ không để bạn đi！",
	[10] = "Nhìn vào thế thân của tôi！",
	[0]  = "Bạn không thể chết！",
}
-- 毒蝎ID
tbLingXieShi.tbDuWeiXieId = 4128;
-- 毒蝎位置
tbLingXieShi.tbPos = {
	{1880, 2601}, {1883, 2601}, {1885, 2602}, {1886, 2604},
	{1886, 2607}, {1884, 2609}, {1881, 2609}, {1879, 2605},
}

tbLingXieShi.tbDropItem = {"setting\\npc\\droprate\\droprate010_shouling.txt", 6};

function tbLingXieShi:OnDeath(pNpc)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nJinZhiLingXieFeng) then
		local pNpc_x = KNpc.GetById(tbInstancing.nJinZhiLingXieFeng);
		if (pNpc_x) then
			pNpc_x.Delete();
		end;
	end;
	
	
	
	tbInstancing.nLingXieFengPass = 1;
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	
	-- 掉落
	local nId = 0;
	if (pNpc and pNpc.GetPlayer()) then
		nId = pNpc.GetPlayer().nId;
	else
		nId = tbPlayList[1].nId;
	end;
	him.DropRateItem(self.tbDropItem[1], self.tbDropItem[2], -1, -1, nId);
	
	for _, teammate in ipairs(tbPlayList) do
		Task.tbArmyCampInstancingManager:ShowTip(teammate, "Bạn có thể đi tiếp！");
	end;
end;

function tbLingXieShi:OnLifePercentReduceHere(nLifePercent)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (nLifePercent == 50) then
		tbInstancing:NpcSay(him.dwId, self.tbText[nLifePercent]);
		him.GetTempTable("Task").tbSayOver = nil;
		return;
	end;
	
	him.SendChat(self.tbText[nLifePercent]);
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	for _, teammate in ipairs(tbPlayList) do
		teammate.Msg(self.tbText[nLifePercent], him.szName);
	end;	
	
	if (nLifePercent == 10) then
		-- 毒蝎幼虫
		for i = 1, 8 do
			local pNpc = KNpc.Add2(self.tbDuWeiXieId, 100, -1, nSubWorld, self.tbPos[i][1], self.tbPos[i][2]);
			assert(pNpc);
			pNpc.GetTempTable("Task").nLingXieFengLifePresent = him.nCurLife;
		end;
		-- 删除公鸡
		if (tbInstancing.dwFightGongJiId) then
			local pGongJi = KNpc.GetById(tbInstancing.dwFightGongJiId);
			if (pGongJi) then
				pGongJi.Delete();
				tbInstancing.dwFightGongJiId = nil;
			end;
		end;
		-- 删除灵蝎使
		him.Delete();
	end;
end;

-- 毒尾蝎
local tbDuWeiXie = Npc:GetClass("duweixie");

function tbDuWeiXie:OnDeath(pNpc)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	--assert(tbInstancing); 改成保护 zounan
	if not tbInstancing then
		Dbg:WriteLog("Doanh trại "," Bọ cạp đuôi độc Không có bản sao lúc chết",nSubWorld);
		return;
	end
			
	local tbNpcData = him.GetTempTable("Task");
	if (not tbNpcData or not tbNpcData.nLingXieFengLifePresent) then
		return; -- 
	end;
	
	tbInstancing.nDuWeiXieCount = tbInstancing.nDuWeiXieCount + 1;
	if (tbInstancing.nDuWeiXieCount > 8) then
		return;
	end;
	
	if (tbInstancing.nDuWeiXieCount == 8) then
		local pNpc = KNpc.Add2(4136, tbInstancing.nNpcLevel, -1 , tbInstancing.nMapId, 1883, 2605);
		assert(pNpc);
		
		local nReduct = pNpc.nMaxLife - tbNpcData.nLingXieFengLifePresent;
		pNpc.ReduceLife(nReduct);
	end;
end;

-- 灵蝎峰指引
local tbLingXieFengZhiYin = Npc:GetClass("lingxiefengzhiyin");

tbLingXieFengZhiYin.szText = "    Nếu bạn có thể đến được đây, bạn thực sự là những bậc thầy. Nhưng sứ thần bọ cạp phía trước khác với ba sứ thần còn lại, các bạn chú ý lắng nghe nhé.。\n\n    Kỹ năng Kim Chung Trảo được sửa chữa bởi bọ cạp tinh linh có thể làm cho nó giống như một chiếc chuông vàng, và thanh kiếm khó bị hư hại. Tiếc rằng dù có đóng thế mạnh đến đâu cũng có chỗ dựa và chính chú gà trống sơ hở nhất đã phá vỡ kỹ năng Kim Chung Trảo của cô.。\n\n    Bạn có thể bí mật<color=red>Lấy 20 đuôi bọ cạp từ bọ cạp ở Đỉnh Núi, và nuôi chúng cho con gà trống vàng mỏ sắt đang bí mật nuôi dưỡng của tôi<color>，Nó sẽ giúp bạn。";

function tbLingXieFengZhiYin:OnDialog()
	local tbOpt = {{"Kết thúc đối thoại"}, };
	Dialog:Say(self.szText, tbOpt);
end;