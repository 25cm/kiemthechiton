-------------------------------------------------------
-- 文件名　：ercengnpc.lua
-- 文件描述：海陵王墓
-- 创建者　：ZhangDeheng
-- 创建时间：2009-03-17 08:46:04
-------------------------------------------------------

local tbNpc = Npc:GetClass("hl_guess2");

tbNpc.szDesc = "Chữ số hiện tại từ <color=red>1-100<color> tùy cơ đoán, dựa theo trình tự nói đáp án.";

function tbNpc:OnInit(tbInstancing, nMin, nMax)

	tbInstancing.nCurGuess2No		= nMin;
	tbInstancing.nGuess2Max			= nMax;
	
	tbInstancing.nGuessState2		= 0;
	tbInstancing.nGuessNo2			= MathRandom(nMax - nMin) + nMin;
end;

function tbNpc:OnDialog()
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;
	if (tbInstancing.nZhuZiOpen ~= 1) then
		return;
	end;
	
	if (tbInstancing.nGuessState2 == 0) then
		local tbOpt = {
			{"Bắt đầu trò chơi", self.GuessStart, self, tbInstancing, him.dwId},
			{"Kết thúc đối thoại"},
		}
		Dialog:Say(self.szDesc, tbOpt);	
	end;
	if (tbInstancing.nGuessState2 == 1) then
		local pPlayer = KPlayer.GetPlayerObjById(tbInstancing.nCurGuessPlayer);
		if (not pPlayer) then -- 如果当前猜字的玩家不在了，则下一位
			pPlayer = tbInstancing:GetNextPlayerFromTable(tbInstancing.tbGuessTable);
		end;
		
		if (not pPlayer) then -- 副本中没人了，出错返回
			return;
		end;
		tbInstancing.nCurGuessPlayer = pPlayer.nId;
		
		if (me.nId == tbInstancing.nCurGuessPlayer) then
			Dialog:AskNumber("Chọn số:", tbInstancing.nGuess2Max, self.InputNo, self, tbInstancing, him.dwId, me.nId);
		else
			Dialog:SendInfoBoardMsg(me, "Bạn chọn sai đáp án, <color=yellow>" .. pPlayer.szName .. "<color> chọn tiếp");
			me.Msg("Bạn chọn sai đáp án, <color=yellow>" .. pPlayer.szName .. "<color> chọn tiếp");
		end;
	end;
end;

function tbNpc:GuessStart(tbInstancing, dwId)
	if (tbInstancing.nGuessState2 ~= 0) then
		return;
	end;
	 
	tbInstancing:SetGuessTable(tbInstancing.tbGuessTable);
	Lib:SmashTable(tbInstancing.tbGuessTable);
	local pPlayer = tbInstancing:GetNextPlayerFromTable(tbInstancing.tbGuessTable);
	if (pPlayer ~= nil) then
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			Dialog:SendInfoBoardMsg(teammate, "Đáp án không đúng, đáp án từ <color=green>" ..tbInstancing.nCurGuess2No .. " - " .. tbInstancing.nGuess2Max .."<color>, <color=yellow>" .. pPlayer.szName .. "<color> chọn tiếp");
			teammate.Msg("Đáp án không đúng, đáp án từ <color=green>" ..tbInstancing.nCurGuess2No .. " - " .. tbInstancing.nGuess2Max .."<color>, <color=yellow>" .. pPlayer.szName .. "<color> chọn tiếp");
		end;
		
		tbInstancing.nGuessTimerId = Timer:Register(Env.GAME_FPS * 5, self.OnBreath, self, tbInstancing, dwId);
		tbInstancing.nGuessState2 = 1;
		tbInstancing.nCurGuessPlayer = pPlayer.nId;
	end;

end;

function tbNpc:OnBreath(tbInstancing, nNpcId)	
	local pPlayer = KPlayer.GetPlayerObjById(tbInstancing.nCurGuessPlayer);
	if (not pPlayer) then
		return;
	end;

	if (tbInstancing.nGuessTimerId) then
		Timer:Close(tbInstancing.nGuessTimerId);
		tbInstancing.nGuessTimerId = nil;
	end;

	local nNo = MathRandom(tbInstancing.nGuess2Max - tbInstancing.nCurGuess2No) + tbInstancing.nCurGuess2No;
	local szMsg = "<color=green>";
	szMsg = szMsg .. nNo;
	szMsg = szMsg .. "<color>";
	Dialog:SendInfoBoardMsg(pPlayer, "Trong 5 giây không chọn, đáp án ngẫu nhiên" .. szMsg ..".");
	pPlayer.Msg("Trong 5 giây không chọn, đáp án ngẫu nhiên" .. szMsg ..".");
	self:InputNo(tbInstancing, nNpcId, pPlayer.nId, nNo);
	return 0;
end;

function tbNpc:InputNo(tbInstancing, nNpcId, nId, nCount)
	if (nId ~= tbInstancing.nCurGuessPlayer) then
		return;
	end;
	
	if (tbInstancing.nGuessTimerId) then
		Timer:Close(tbInstancing.nGuessTimerId);
		tbInstancing.nGuessTimerId = nil;
	end;
	
	local pCurPlayer = KPlayer.GetPlayerObjById(tbInstancing.nCurGuessPlayer);
	if (tbInstancing.nGuessNo2 == nCount) then
		tbInstancing.nCurGuessPlayer = nil;
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			Dialog:SendInfoBoardMsg(teammate, "Chúc mừng <color=yellow>" .. pCurPlayer.szName .. "<color> đoán đúng đáp án, nhận được 1 rương hoàng kim!");
			teammate.Msg("Chúc mừng <color=yellow>" .. pCurPlayer.szName .. "<color> đoán đúng đáp án, nhận được 1 rương hoàng kim!");
		end;

		if (pCurPlayer.CountFreeBagCell() >= 1) then
			pCurPlayer.AddItem(18, 1, 330, 1)
		else
			local nMapId, nPosX, nPosY = pCurPlayer.GetWorldPos();
			local pItem = KItem.AddItemInPos(nMapId, nPosX, nPosY, 18, 1, 330, 1,0, 0, 0, nil, nil, 0, 0, pCurPlayer);
			pItem.SetOnlyBelongPick(1);
		end;
		
		tbInstancing.nErCengWinner	 = pCurPlayer.nId;
		tbInstancing.nGuessState2 = 2;
		tbInstancing.nTrap5Pass	= 1;
		
		local pNpc = KNpc.GetById(nNpcId);
		if (pNpc) then
			local _, nPosX, nPosY = pNpc.GetWorldPos();
			pNpc.Delete();
			local pNpc = KNpc.Add2(4227, 120, -1, tbInstancing.nMapId, nPosX, nPosY);
			pNpc.szName = "Lối vào tầng 3";
		end;
	else
		local pPlayer = tbInstancing:GetNextPlayerFromTable(tbInstancing.tbGuessTable);
		if not pPlayer then -- 加层判断 zounan
			return;
		end
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			local szMsg = "";
			
			if (nCount < tbInstancing.nGuessNo2) then
				if (tbInstancing.nCurGuess2No < nCount) then
					tbInstancing.nCurGuess2No = nCount;
				end;
			else
				if (tbInstancing.nGuess2Max > nCount) then
					tbInstancing.nGuess2Max = nCount;
				end;
			end;
			Dialog:SendInfoBoardMsg(teammate, "Số <color=green>" .. nCount.. "<color> không đúng, <color=yellow>" .. pPlayer.szName .. "<color> chọn tiêp! Đáp án từ <color=green>" ..tbInstancing.nCurGuess2No .. " - " .. tbInstancing.nGuess2Max .."<color>.");
			teammate.Msg("Số <color=green>" .. nCount.. "<color> không đúng, <color=yellow>" .. pPlayer.szName .. "<color> chọn tiêp! Đáp án từ <color=green>" ..tbInstancing.nCurGuess2No .. " - " .. tbInstancing.nGuess2Max .."<color>.");
		end;
		tbInstancing.nGuessTimerId = Timer:Register(Env.GAME_FPS * 5, self.OnBreath, self, tbInstancing, nNpcId);
		tbInstancing.nCurGuessPlayer = pPlayer.nId;
	end;
end;

local tbZhuZi2 = Npc:GetClass("hl_zhuzi2");

tbZhuZi2.szDesc = "Nhị tằng cây cột";

function tbZhuZi2:OnDialog()
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;
	
	if (tbInstancing.tbOpen[him.dwId] ~= 0 or tbInstancing.nZhuZiOpen ~= 0) then
		return;
	end;
	if (tbInstancing.nOpenZhuZiTime ~= 2) then
		--进度条
		local tbEvent = 
		{
			Player.ProcessBreakEvent.emEVENT_MOVE,
			Player.ProcessBreakEvent.emEVENT_ATTACK,
			Player.ProcessBreakEvent.emEVENT_SITE,
			Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
			Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
			Player.ProcessBreakEvent.emEVENT_ATTACKED,
			Player.ProcessBreakEvent.emEVENT_DEATH,
			Player.ProcessBreakEvent.emEVENT_LOGOUT,
		}
		GeneralProcess:StartProcess("Đang mở...", 0.5 * 18, {self.OnOpen, self, him.dwId, me.nId, tbInstancing}, {me.Msg, "Mở ra bị gián đoạn!"}, tbEvent);
	end;
end;


function tbZhuZi2:OnOpen(nNpcId, nPlayerId, tbInstancing)
	tbInstancing.nOpenZhuZiTime = 1;
	tbInstancing.tbOpen[nNpcId] = 1;
end;

-- 一层开BOSS2机关
local tbJiGuan = Npc:GetClass("hl_round3");

tbJiGuan.szDesc = "Nhị tằng khai BOSS2 chốt mở";
tbJiGuan.szText = "<npc=4183>: ta chinh phục đích ranh giới bỉ các ngươi gặp qua đích hoàn đa, phóng ngựa nhiều ba, thanh niên nhân."
tbJiGuan.EFFECT_NPC	= 2976
tbJiGuan.tbHuWeiPos = {
		{1762, 3558},
		{1768, 3565},
		{1762, 3571},
		{1765, 3564},
	}
tbJiGuan.tbHuWeiId = {
			4185, 4186, 4187, 4188, 4189, 4190, 
			4191, 4192, 4193, 4194, 4195, 4196, 
			4197, 4198, 4199, 4200, 4201, 4202, 
			4203, 4204, 4205, 4206, 4207, 4208, 
		}
		
function tbJiGuan:OnDialog()
	local nMapId, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nMapId);

	if (not tbInstancing or tbInstancing.nBoss3Out ~= 0) then
		return;
	end;
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(nMapId);
	for _, teammate in ipairs(tbPlayList) do
		Setting:SetGlobalObj(teammate);
		TaskAct:Talk(self.szText, self.TalkEnd, self, him.dwId, tbInstancing);
		Setting:RestoreGlobalObj();
	end;	
end;

function tbJiGuan:TalkEnd(dwId, tbInstancing)

	local pNpc = KNpc.GetById(dwId);
	if (not pNpc or tbInstancing.nBoss3Out == 1) then
		return;
	end;
	local nMapId, nPosX, nPosY	= pNpc.GetWorldPos();
	pNpc.Delete();
	
	local pNpc = KNpc.Add2(self.EFFECT_NPC, 10, -1, tbInstancing.nMapId, nPosX, nPosY);
	Timer:Register(0.5 * Env.GAME_FPS, self.CallBoss, self, nMapId, pNpc.dwId);
end;

function tbJiGuan:CallBoss(nMapId, dwId)
	local pNpc = KNpc.GetById(dwId);
	if (not pNpc) then
		return 0;	
	end;

	local nMapId, nPosX, nPosY	= pNpc.GetWorldPos();
	pNpc.Delete();
	
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nMapId);
	if (not tbInstancing or tbInstancing.nBoss3Out == 1) then
		return 0;
	end;
		
	local pNpc = KNpc.Add2(4183, tbInstancing.nNpcLevel, -1, nMapId, nPosX, nPosY);
	pNpc.CastSkill(1163, 10, -1, pNpc.nIndex);
	for i = 1, 9 do
		pNpc.AddLifePObserver(i * 10);
	end;
	tbInstancing.nBoss3Out = 1;	
	
	for i = 1, 4 do
		Lib:SmashTable(self.tbHuWeiId);
		KNpc.Add2(self.tbHuWeiId[i], tbInstancing.nNpcLevel, -1, nMapId, self.tbHuWeiPos[i][1], self.tbHuWeiPos[i][2]);
	end;
end;
-- BOSS3
local tbBoss3 = Npc:GetClass("hl_boss3");

tbBoss3.szDesc = "BOSS3";
tbBoss3.tbText = {
		[90] = "Vô nhu ta xuất thủ, hộ vệ môn trảo thích khách.",
		[80] = "Ta rong ruổi giang hồ đích thời gian các ngươi đều còn không có sinh ra ni.",
		[70] = "Điều không phải ta cậy già lên mặt, các ngươi đánh không lại ta đích.",
		[60] = "Các ngươi dũng khí khả gia, thế nhưng y theo quân pháp án luật đương trảm.",
		[50] = "Muốn làm niên nhạc gia quân cũng muốn nhượng ta ba phần.",
		[40] = "Ta đảo cấp cho các ngươi nhìn, lão cẩu cũng có kỷ khỏa nha.",
		[30] = "Kiên cường đứng lên, ta trong khung lưu đích thế nhưng đại kim đích huyết.",
		[20] = "Đây là tối hậu một kích liễu, ta không bị thua cho các ngươi đích.",
		[10] = "Vô luận ngươi thành lập nhiều ít phong công sự nghiệp to lớn, ngươi đều không thể thừa thụ năm tháng đích dày vò.",
		[0] = "<npc=4183>: đại kim đích giang sơn khởi thị ngươi chờ bọn chuột nhắt khả dĩ dao động đích, các ngươi vĩnh viễn vô pháp chinh phục chúng ta cuồng dã đích tâm.",
	}
function tbBoss3:OnLifePercentReduceHere(nLifePercent)
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;
	
	if (self.tbText[nLifePercent]) then
		him.SendChat(self.tbText[nLifePercent]);
		
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			teammate.Msg(self.tbText[nLifePercent], him.szName);
		end;
	end;
end;

function tbBoss3:OnDeath(pNpc)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	
	tbInstancing.nTrap6Pass = 1;
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(nSubWorld);
	for _, teammate in ipairs(tbPlayList) do
		Setting:SetGlobalObj(teammate);
		TaskAct:Talk(self.tbText[0]);
		Setting:RestoreGlobalObj();
	end;
	local pNpc = KNpc.Add2(4151, 120, -1, tbInstancing.nMapId, 55840 / 32, 116736 / 32);
	pNpc.szName = "";
end;

local tbErCengSend = Npc:GetClass("hl_ceng2chuansong");

tbErCengSend.szDesc = "Truyền tống tầng 2";

function tbErCengSend:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	
	Dialog:Say("Có muốn vào?", 
		{"Có", self.Enter, self, me.nId, him.dwId, tbInstancing},
		{"Tạm thời không đi"})
end;

function tbErCengSend:Enter(nPlayerId, nNpcId, tbInstancing)
	local pNpc = KNpc.GetById(nNpcId);
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pNpc or not pPlayer) then
		return;
	end;
	local tbData = pNpc.GetTempTable("Task");
	if (not tbData or not tbData.tbNo) then
		return;
	end;
	
	me.NewWorld(tbInstancing.nMapId, tbInstancing.ERCENG_SEND_POS[tbData.tbNo[1]][tbData.tbNo[2]][tbData.tbNo[3]][1] / 32, tbInstancing.ERCENG_SEND_POS[tbData.tbNo[1]][tbData.tbNo[2]][tbData.tbNo[3]][2] / 32);
end;

local tbSend2 = Npc:GetClass("hl_ceng2send");

tbSend2.szDesc 		= "Sai điểm 2 hậu đích truyền tống môn"
tbSend2.tbSendPos 	= {1775, 3490}; 

function tbSend2:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	
	Dialog:Say("Có muốn vào?", 
		{"Có", self.Enter, self, me.nId, tbInstancing},
		{"Tạm thời không đi"})
end;

function tbSend2:Enter(nPlayerId, tbInstancing)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end;
	
	me.NewWorld(tbInstancing.nMapId, self.tbSendPos[1], self.tbSendPos[2]);
end;


-- 一层指引
local tbZhiYin = Npc:GetClass("hl_yindao2");

tbZhiYin.szDesc = "Chỉ dẫn tầng 2";

tbZhiYin.szText = "Hướng dẫn:\n    Đến mê cung góc, bốn người <color=red> song song mở ra quang ảnh thạch <color>, du long hội lần thứ hai phủ xuống, dựa theo hắn đích chỉ thị, đoán đúng đáp án, sẽ xuất hiện hạ tầng đích thông đạo, thế nhưng lần này dữ thượng tầng bất đồng, <color=red> sai đối đích nhân sẽ xong dày đích thưởng cho <color>."

tbZhiYin.szDianShu = "Quy tắc trò chơi:\n    Do hệ thống viết ra trong đó đích ý một vài tự, ( dĩ 1-100 vi lệ, viết ra 88), tái do sở hữu trò chơi người án trình tự mỗi người thuyết một vài tự, mà trò chơi người nói ra đích chữ số hữu ba loại khả năng tính, một người bỉ viết tốt đại, một người bỉ viết tốt tiểu, một người vừa lúc, nếu như bỉ viết tốt chữ số đại nói ( tỷ như 99), ra đề mục người nên thu nhỏ lại phạm vi vì thế trò chơi người thuyết đích chữ số dữ nhỏ nhất chữ số trong lúc đó ( ra đề mục người phải nói 1-99), tái do kế tiếp trò chơi người nói ra một vài tự, nếu như bỉ viết tốt chữ số tiểu nhân nói ( tỷ như 11), ra đề mục người nên thu nhỏ lại phạm vi vì thế trò chơi người thuyết đích chữ số dữ lớn nhất chữ số trong lúc đó ( ra đề mục người phải nói 11-100), tái do kế tiếp trò chơi người nói ra một vài tự, ( tái kéo dài một chút, kế tiếp trò chơi người thuyết 90, ra đề mục người thuyết 11-90, xuống lần nữa nhất trò chơi người thuyết 60, ra đề mục người thuyết 60-90, lần lượt loại suy ) thẳng đến trò chơi người nói ra ra đề mục người viết ra đích chữ số, trò chơi kết thúc."

function tbZhiYin:OnDialog()
	Dialog:Say(self.szText, 
			{
				{"Quy tắc trò chơi", self.Say, self},
				{"Kết thúc đối thoại"},	
			}
		);
end;

function tbZhiYin:Say()
	Dialog:Say(self.szDianShu,
			{
				{"Kết thúc đối thoại"},	
			}
		);	
end;