-------------------------------------------------------
-- 文件名　：yicengnpc.lua
-- 文件描述：副本一层NPC脚本
-- 创建者　：ZhangDeheng
-- 创建时间：2009-03-16 10:54:32
-------------------------------------------------------

local tbNpc = Npc:GetClass("hl_guess1");

tbNpc.tbDesc = {
		"Vòng đầu tiên: Câu trả lời trong khoảng <color=red>6-36<color>.",
		"Vòng thứ hai: Câu trả lời trong khoảng <color=red>5-30<color>.",
		"Vòng thứ ba: Câu trả lời trong khoảng <color=red>4-24<color>.",
	}

tbNpc.GUESS_GIFT = {
				{"Rương bạc", 18, 1, 331, 1},
				{"Rương thanh đồng", 18, 1, 332, 1},
				{"Rương bạch ngân", 18, 1, 333, 1},
		}

function tbNpc:OnInit(tbInstancing, nMin, nMax)
	tbInstancing.nCurGuessPlayer 	= 0;

	tbInstancing.nCurGuess1No		= nMin - 1;
	tbInstancing.nGuess1Max			= nMax;
	
	tbInstancing.nOpen1 			= 1;
	tbInstancing.nGuessState1		= 0;
	tbInstancing.nGuessNo1			= MathRandom(nMax - nMin) + nMin;
	tbInstancing.nPassGuess			= {};
	tbInstancing.nReturnGuess		= {};
end;

function tbNpc:OnDialog()
	local nSubWorld, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	if (not tbInstancing) then
		return;
	end;
	if (tbInstancing.nOpenJiGuan ~= 4) then
		return;
	end;
	
	if (tbInstancing.nGuessState1 == 0) then
		local tbOpt = {
			{"<color=yellow>Bắt đầu trò chơi<color>", self.GuessStart, self, tbInstancing},
			{"Kết thúc đối thoại"},
		}
		Dialog:Say(self.tbDesc[tbInstancing.nYiCengGuessCount + 1], tbOpt);	
	end;
	if (tbInstancing.nGuessState1 == 1) then
		local pPlayer = KPlayer.GetPlayerObjById(tbInstancing.nCurGuessPlayer);
		if (not pPlayer) then -- 如果当前猜字的玩家不在了，则下一位
			pPlayer = tbInstancing:GetNextPlayerFromTable(tbInstancing.tbGuessTable);
		end;
		
		if (not pPlayer) then -- 副本中没人了，出错trở lại
			return;
		end;
		tbInstancing.nCurGuessPlayer = pPlayer.nId;
		
		if (me.nId == tbInstancing.nCurGuessPlayer) then
			local szMsg = "Lựa chọn:"
			local nNo = tbInstancing.nCurGuess1No;
			local tbOpt = {
					{string.format("%d", nNo + 1), self.InputNo, self, me.nId, him.dwId, tbInstancing, 1},
					{string.format("%d,%d", nNo + 1, nNo + 2), self.InputNo, self, me.nId, him.dwId, tbInstancing, 2},
					{string.format("%d,%d,%d", nNo + 1, nNo + 2, nNo + 3), self.InputNo, self, me.nId, him.dwId, tbInstancing, 3},
				};
			if (not tbInstancing.nPassGuess[tbInstancing.nCurGuessPlayer] or tbInstancing.nPassGuess[tbInstancing.nCurGuessPlayer] ~= 1) then
				if (not tbInstancing.nReturnGuess[tbInstancing.nCurGuessPlayer] or tbInstancing.nReturnGuess[tbInstancing.nCurGuessPlayer] ~= 1) then
					tbOpt[#tbOpt + 1] = {"Bỏ qua", self.InputNo, self, me.nId, him.dwId, tbInstancing, 4};
					tbOpt[#tbOpt + 1] = {"Quay trở lại", self.InputNo, self, me.nId, him.dwId, tbInstancing, 5};
				end;
			end;
			Dialog:Say(szMsg, tbOpt);
		else
			Dialog:SendInfoBoardMsg(me, "Bạn không thể lựa chọn, <color=yellow>" .. pPlayer.szName .. "<color> có thể chọn");
			me.Msg("Bạn không thể lựa chọn, <color=yellow>" .. pPlayer.szName .. "<color> có thể chọn");
		end;
	end;
end;

function tbNpc:GuessStart(tbInstancing)
	if (tbInstancing.nGuessState1 ~= 0) then
		return;
	end;
	
	tbInstancing:SetGuessTable(tbInstancing.tbGuessTable);
	Lib:SmashTable(tbInstancing.tbGuessTable);
	local pPlayer = tbInstancing:GetNextPlayerFromTable(tbInstancing.tbGuessTable);
	if (pPlayer ~= nil) then
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			Dialog:SendInfoBoardMsg(teammate, "Đoán số bắt đầu, vòng hiện tại đáp án giữa <color=green>" ..(tbInstancing.nCurGuess1No + 1) .." - " .. tbInstancing.nGuess1Max .."<color>, <color=yellow>" .. pPlayer.szName .. "<color> có thể đoán");
			teammate.Msg("Đoán số bắt đầu, vòng hiện tại đáp án giữa <color=green>" ..(tbInstancing.nCurGuess1No + 1) .." - " .. tbInstancing.nGuess1Max .."<color>, <color=yellow>" .. pPlayer.szName .. "<color> có thể đoán");
		end;
		
		if (tbInstancing.nGuessTimerId) then
			Timer:Close(tbInstancing.nGuessTimerId);
			tbInstancing.nGuessTimerId = nil;
		end;
		tbInstancing.nGuessTimerId = Timer:Register(Env.GAME_FPS * 5, self.OnBreath, self, him.dwId, tbInstancing);
		tbInstancing.nCurGuessPlayer = pPlayer.nId;
		tbInstancing.nGuessState1 = 1;
	end;
end;

function tbNpc:OnBreath(nId, tbInstancing)
	local pPlayer = KPlayer.GetPlayerObjById(tbInstancing.nCurGuessPlayer);
	if (not pPlayer) then
		return;
	end;

	if (tbInstancing.nGuessTimerId) then
		Timer:Close(tbInstancing.nGuessTimerId);
		tbInstancing.nGuessTimerId = nil;
	end;
			
	local nNo = MathRandom(3);
	local szMsg = "<color=green>";
	for i = 1, nNo do
		local n = tbInstancing.nCurGuess1No + i;
		szMsg = szMsg .. n .. " ";
	end;
	szMsg = szMsg .. "<color>";
	Dialog:SendInfoBoardMsg(pPlayer, "Trong 5 giây không trả lời, ngẫu nhiên chọn" .. szMsg ..".");
	pPlayer.Msg("Trong 5 giây không trả lời, ngẫu nhiên chọn" .. szMsg ..".");
	self:InputNo(pPlayer.nId, nId, tbInstancing, nNo);
	return 0;
end;
	
function tbNpc:InputNo(nId, dwId, tbInstancing, nCount)
	if(nId ~= tbInstancing.nCurGuessPlayer) then
		return;
	end;
	
	if (tbInstancing.nGuessTimerId) then
		Timer:Close(tbInstancing.nGuessTimerId);
		tbInstancing.nGuessTimerId = nil;
	end;
	local pCurPlayer = KPlayer.GetPlayerObjById(tbInstancing.nCurGuessPlayer);
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	
	if (nCount == 4) then
		local pCurPlayer = KPlayer.GetPlayerObjById(tbInstancing.nCurGuessPlayer);
		local pPlayer = tbInstancing:GetNextPlayerFromTable(tbInstancing.tbGuessTable);
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			Dialog:SendInfoBoardMsg(teammate, "<color=yellow>" .. pCurPlayer.szName .."<color> chọn <color=green>bỏ qua<color>, <color=yellow>" .. pPlayer.szName .. "<color> có thể chọn");
			teammate.Msg("<color=yellow>" .. pCurPlayer.szName .."<color> chọn <color=green>bỏ qua<color>, <color=yellow>" .. pPlayer.szName .. "<color> có thể chọn");
			tbInstancing.nCurGuessPlayer = pPlayer.nId;
		end;
		
		if (tbInstancing.nGuessTimerId) then
			Timer:Close(tbInstancing.nGuessTimerId);
			tbInstancing.nGuessTimerId = nil;
		end;
	
		tbInstancing.nGuessTimerId = Timer:Register(Env.GAME_FPS * 5, self.OnBreath, self, dwId, tbInstancing);
		tbInstancing.nPassGuess[pCurPlayer.nId] = 1;
	elseif (nCount == 5) then
		local pCurPlayer = KPlayer.GetPlayerObjById(tbInstancing.nCurGuessPlayer);
		tbInstancing.tbGuessTable = tbInstancing:ConverseTable(tbInstancing.tbGuessTable);
		local pPlayer = tbInstancing:GetNextPlayerFromTable(tbInstancing.tbGuessTable);
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			Dialog:SendInfoBoardMsg(teammate, "<color=yellow>" .. pCurPlayer.szName .."<color> chọn <color=green>quay trở lại<color>, <color=yellow>" .. pPlayer.szName .. "<color> có thể chọn");
			teammate.Msg("<color=yellow>" .. pCurPlayer.szName .."<color> chọn <color=green>quay trở lại<color>, <color=yellow>" .. pPlayer.szName .. "<color> có thể chọn");
			tbInstancing.nCurGuessPlayer = pPlayer.nId;
		end;
		
		if (tbInstancing.nGuessTimerId) then
			Timer:Close(tbInstancing.nGuessTimerId);
			tbInstancing.nGuessTimerId = nil;
		end;
	
		tbInstancing.nGuessTimerId = Timer:Register(Env.GAME_FPS * 5, self.OnBreath, self, dwId, tbInstancing);
		tbInstancing.nReturnGuess[pCurPlayer.nId] = 1;
	else
		if (tbInstancing.nGuessNo1 >= tbInstancing.nCurGuess1No + 1 and tbInstancing.nGuessNo1 <= tbInstancing.nCurGuess1No + nCount) then
			tbInstancing.nYiCengGuessCount = tbInstancing.nYiCengGuessCount + 1;
			if (tbInstancing.nYiCengGuessCount ~= 3) then
				for _, teammate in ipairs(tbPlayList) do
					Dialog:SendInfoBoardMsg(teammate, "Không may <color=yellow>" .. pCurPlayer.szName .. "<color> đoán đúng số xui, lượt sau có thẻ chọn");
					teammate.Msg("Không may <color=yellow>" .. pCurPlayer.szName .. "<color> đoán đúng số xui, lượt sau có thẻ chọn");
				end;
				if (tbInstancing.nYiCengGuessCount == 1) then
					self:OnInit(tbInstancing, 5, 30);
				elseif (tbInstancing.nYiCengGuessCount == 2) then
					self:OnInit(tbInstancing, 4, 24);
				end;
				
				tbInstancing.tbYiCengWinner[tbInstancing.nYiCengGuessCount] = pCurPlayer.nId;
			else
				tbInstancing.tbYiCengWinner[tbInstancing.nYiCengGuessCount] = pCurPlayer.nId;
				self:GameOver(dwId, tbInstancing);
			end;
		else
			local pPlayer = tbInstancing:GetNextPlayerFromTable(tbInstancing.tbGuessTable);
			if not pPlayer then  -- 加层判断zounan
				return;
			end	
			local szMsg = "";
			for i = tbInstancing.nCurGuess1No + 1, tbInstancing.nCurGuess1No + nCount do
				szMsg = szMsg .. i .. " ";
			end;
			for _, teammate in ipairs(tbPlayList) do
				Dialog:SendInfoBoardMsg(teammate, "<color=yellow>" .. pCurPlayer.szName .."<color> chọn <color=green>" .. szMsg .. "<color>, không đúng, <color=yellow>" .. pPlayer.szName .. "<color> có thể đoán");
				teammate.Msg("<color=yellow>" .. pCurPlayer.szName .."<color> chọn <color=green>" .. szMsg .. "<color>, không đúng, <color=yellow>" .. pPlayer.szName .. "<color> có thể đoán");
			end;
			
			if (tbInstancing.nGuessTimerId) then
				Timer:Close(tbInstancing.nGuessTimerId);
				tbInstancing.nGuessTimerId = nil;
			end;
	
			tbInstancing.nGuessTimerId = Timer:Register(Env.GAME_FPS * 5, self.OnBreath, self, dwId, tbInstancing);
			tbInstancing.nCurGuess1No = tbInstancing.nCurGuess1No + nCount;
			tbInstancing.nCurGuessPlayer = pPlayer.nId;
		end;
	end;
end;

function tbNpc:GameOver(nNpcId, tbInstancing)
	local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
	local pCurPlayer = KPlayer.GetPlayerObjById(tbInstancing.nCurGuessPlayer);
	
	for _, teammate in ipairs(tbPlayList) do
		local nWinCount = 1;
		for i = 1, #tbInstancing.tbYiCengWinner do
			if (tbInstancing.tbYiCengWinner[i] == teammate.nId) then
				nWinCount = nWinCount + 1;
			end;
		end;
		if (self.GUESS_GIFT[nWinCount]) then
			if (teammate.CountFreeBagCell() >= 1) then
				teammate.AddItem(self.GUESS_GIFT[nWinCount][2], self.GUESS_GIFT[nWinCount][3], self.GUESS_GIFT[nWinCount][4], self.GUESS_GIFT[nWinCount][5])
			else
				local nMapId, nPosX, nPosY = teammate.GetWorldPos();
				local pItem = KItem.AddItemInPos(nMapId, nPosX, nPosY, self.GUESS_GIFT[nWinCount][2], self.GUESS_GIFT[nWinCount][3], self.GUESS_GIFT[nWinCount][4], self.GUESS_GIFT[nWinCount][5], 0, 0, 0, nil, nil, 0, 0, teammate);
				pItem.SetOnlyBelongPick(1);
			end;
			Dialog:SendInfoBoardMsg(teammate, "Không may <color=yellow>" .. pCurPlayer.szName .. "<color> đoán đúng số xui, trò chơi kết thúc. Bạn nhận được 1 <color=yellow>" .. self.GUESS_GIFT[nWinCount][1] .. "<color>!");
			teammate.Msg("Không may <color=yellow>" .. pCurPlayer.szName .. "<color> đoán đúng số xui, trò chơi kết thúc. Bạn nhận được 1 <color=yellow>" .. self.GUESS_GIFT[nWinCount][1] .. "<color>!");
		else
			Dialog:SendInfoBoardMsg(teammate, "Không may <color=yellow>" .. pCurPlayer.szName .. "<color> đoán đúng số xui, trò chơi kết thúc."); 
			teammate.Msg("Không may <color=yellow>" .. pCurPlayer.szName .. "<color> đoán đúng số xui, trò chơi kết thúc."); 
		end;
	end;
	
	local pNpc = KNpc.GetById(nNpcId);
	local nPosX = 58912 / 32;
	local nPosY = 102752 / 32;
	if (pNpc) then
		local _, nX, nY = pNpc.GetWorldPos();
		nPosX = nX;
		nPosY = nY;
		
		pNpc.Delete();
	end;
	
	local pNpc = KNpc.Add2(4226, 120, -1, tbInstancing.nMapId, nPosX, nPosY);
	pNpc.szName = "Lối vào tầng 2";
end;

-- 一层机关，按照风 林 火 山 顺序开启
local tbJiGuan = Npc:GetClass("hl_jiguan");

tbJiGuan.szDesc = "Một bộ phận then chốt";
tbJiGuan.szText = "<npc=4224>: các ngươi tìm được rồi ta, tốt, thế nhưng nếu muốn đi qua ở đây, các ngươi phải giúp ta tìm được ba đáp án.<end><npc=4224>: đã quên nói, đáp trả chữ số đích nhân sẽ đã bị nghiêm phạt.<end><npc=4224>: tưởng được rồi mà bắt đầu trò chơi, các ngươi thoả thích hưởng thụ, ha ha ha ha...<end>";

function tbJiGuan:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	if (tbInstancing.nOpenJiGuan == 4) then
		return;
	end;
	
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
	GeneralProcess:StartProcess("Đang mở...", 0.5 * 18, {self.OnOpen, self, him.dwId, me.nId, tbInstancing}, {me.Msg, "Mở bị gián đoạn!"}, tbEvent);
end;

function tbJiGuan:OnOpen(dwNpcId, nPlayerId, tbInstancing)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	local pNpc = KNpc.GetById(dwNpcId);
	if (not pPlayer or not pNpc) then
		return;
	end;
	
	if (tbInstancing.nOpenJiGuan >= 4) then
		return;
	end;
	
	local tbNpcData = pNpc.GetTempTable("Task"); 
	assert(tbNpcData);

	if (tbNpcData.nNo ~= (tbInstancing.nOpenJiGuan + 1)) then
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			Task.tbArmyCampInstancingManager:ShowTip(teammate, "Mở ra trình tự sai, quay lại mở từ đầu!!");
			teammate.Msg("Mở ra trình tự sai, quay lại mở từ đầu!");
		end;
		tbInstancing.nOpenJiGuan = 0;
		return;
	end;
	
	tbInstancing.nOpenJiGuan = tbInstancing.nOpenJiGuan + 1;
	pPlayer.Msg("Mở thành công!");
	
	if (tbInstancing.nOpenJiGuan == 4) then
		local tbPlayList, _ = KPlayer.GetMapPlayer(tbInstancing.nMapId);
		for _, teammate in ipairs(tbPlayList) do
			teammate.NewWorld(tbInstancing.nMapId, 58880 / 32, 102688 / 32);
			tbInstancing:OnCoverBegin(teammate);
			teammate.SetFightState(1);
			
			Setting:SetGlobalObj(teammate);
			TaskAct:Talk(self.szText);
			Setting:RestoreGlobalObj();		
		end;	
			
		--  có thể chọnNPC
		KNpc.Add2(4224, 120, -1, tbInstancing.nMapId, 58912 / 32, 102752 / 32);
	end;
end;

-- 一层指引
local tbZhiYin = Npc:GetClass("hl_yindao1");

tbZhiYin.szDesc = "Một tầng chỉ dẫn";

tbZhiYin.szText = "Gửi những người đến sau:\n    Thứ tự mở 4 cột <color=red>Phong => Lâm => Hỏa => Sơn<color> ải tiếp sẽ mở, gặp Du Long, theo chỉ thị, đoán 3 mật mã, xuất hiện lối vào tầng tiếp theo, thế nhưng, <color=red>đoán sai mọi người sẽ phải trả giá<color>."

tbZhiYin.szDianShu = "Quy tắc chọn:\n    1, đầu tiên do hệ thống tại quy định trong phạm vi trong lúc đó tùy cơ thiêu một vài tự ( tam luân đích phạm vi phân biệt thị 6-36, 5-30, 4-24). \n  2, ngoạn gia thay phiên điểm số, người thứ nhất ngoạn gia tòng ít nhất chữ số bắt đầu báo, dĩ vòng thứ nhất vi lệ, khả dĩ báo 6, 67, 678, ba loại tuyển trạch phương thức, nếu như điểm số trung không có hệ thống tuyển định đích chữ số, tắc an toàn đi qua. Người thứ hai ngoạn gia kéo dài người thứ nhất ngoạn gia đích điểm số trình tự đi xuống báo, cũng là ba loại tuyển trạch, dĩ thử loại suy nếu có một vị ngoạn gia đích điểm số dữ hệ thống thiêu trung đích chữ số tương đồng, như vậy hắn tựu thua trận liễu bỉ tái. \n  3, tại chữ số đích ba loại tổ hợp tuyển trạch ở ngoài, ngoạn gia còn có thể tuyển trạch đi qua hòa phản hồi, danh như ý nghĩa, nghĩ sau chữ số nguy hiểm, tuyển trạch đi qua nhà dưới bất điểm số, có lẽ phản hồi cấp nhà trên điểm số, tương điểm số đích trình tự nghịch nhiều. Tại một ván bỉ tái trung, ngoạn gia chỉ có thể tuyển trạch một lần đi qua có lẽ phản hồi, sử dụng lúc, giá hai người tuyển hạng tương sẽ không tại mặt bản trung xuất hiện. \n  4, đương một người ngoạn gia đoán đúng không may chữ số, tắc bị tiêu ký vi thua trận bản luân bỉ tái. Đợi cho tam luân sau khi kết thúc, dựa theo tổng hợp lại thành tích ban phát thưởng cho, một lần vị thâu người thưởng cho tối cao.";

function tbZhiYin:OnDialog()
	Dialog:Say(self.szText, 
			{
				{"Quy tắc chọn", self.Say, self},
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

-- 一层开BOSS2机关
local tbJiGuan = Npc:GetClass("hl_round2");

tbJiGuan.szDesc = "Mở tầng";
tbJiGuan.szText = "<npc=4182>: ta nghe thấy được người sống đích vị đạo, ta có bảo đao đã đã lâu không có hưởng qua tiên huyết liễu."
tbJiGuan.EFFECT_NPC	= 2976

function tbJiGuan:OnDialog()
	local nMapId, _, _ = him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nMapId);

	if (not tbInstancing or tbInstancing.nBoss2Out ~= 0) then
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
	if (not pNpc) then
		return;
	end;
	
	local nMapId, nPosX, nPosY	= pNpc.GetWorldPos();
	pNpc.Delete();
	
	local pNpc = KNpc.Add2(self.EFFECT_NPC, 10, -1, tbInstancing.nMapId, nPosX, nPosY);
	Timer:Register(0.5 * Env.GAME_FPS, self.CallBoss, self, nMapId, pNpc.dwId);
end;

function tbJiGuan:CallBoss(nMapId, nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc) then
		return 0;	
	end;

	local nMapId, nPosX, nPosY	= pNpc.GetWorldPos();
	pNpc.Delete();
		
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nMapId);
	if (not tbInstancing or tbInstancing.nBoss2Out == 1) then
		return 0;
	end;
		
	local pNpc = KNpc.Add2(4182, tbInstancing.nNpcLevel, -1, nMapId, nPosX, nPosY);
	pNpc.CastSkill(1163, 10, -1, pNpc.nIndex);
	for i = 1, 9 do
		pNpc.AddLifePObserver(i * 10);
	end;
	tbInstancing.nBoss2Out = 1;	
	return 0;
end;

local tbBoss2 = Npc:GetClass("hl_boss2");

tbBoss2.szDesc = "BOSS2"
tbBoss2.tbText = {
		[90] = "Không được các ngươi nhiễu loạn chủ nhân nghỉ ngơi, đi tìm chết ba.",
		[80] = "Kim quốc đệ nhất đao khách không có thể như vậy lãng đắc hư danh đích.",
		[70] = "Không ai có thể cú đi qua ở đây, không ai.",
		[60] = "Ta thiêu, ta thiêu, ta thiêu thiêu thiêu.",
		[50] = "Đêm nay gia một thái, ta muốn đem các ngươi biến thành thiêu khảo đích món ăn thôn quê.",
		[40] = "Xâm lấn người, cách sát vật luận.",
		[30] = "Ta yếu xuất toàn lực liễu, xem chiêu. .",
		[20] = "Năng bả ta bức đáo như vậy nông nỗi, chính lần đầu tiên.",
		[10] = "Hoàn nhan không phá thời khắc thủ hộ tại chủ nhân bên người.",
		[0] = "<npc=4182>: các ngươi thắng, quá khứ ba, mong muốn các ngươi bả những ... này lực lượng dùng tại chính nghĩa chuyện nghiệp thượng, đại địa mẫu thân cùng ngươi cùng tồn tại.",
	}
function tbBoss2:OnLifePercentReduceHere(nLifePercent)	
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

function tbBoss2:OnDeath(pNpc)
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	
	tbInstancing.nTrap4Pass = 1;
	
	local tbPlayList, _ = KPlayer.GetMapPlayer(nSubWorld);
	for _, teammate in ipairs(tbPlayList) do
		Setting:SetGlobalObj(teammate);
		TaskAct:Talk(self.tbText[0]);
		Setting:RestoreGlobalObj();
	end;
	
	local pNpc = KNpc.Add2(4151, 120, -1, tbInstancing.nMapId, 56192 / 32, 110528 / 32);
	pNpc.szName = "";
end;

local tbSend1 = Npc:GetClass("hl_ceng1send");

tbSend1.szDesc 		= "Sai chữ số 1 truyền tống về cửa hậu sơn"
tbSend1.tbSendPos 	= {1788, 3293}; 

function tbSend1:OnDialog()
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	
	Dialog:Say("Có hay không truyền tống?", 
		{"Có", self.Enter, self, me.nId, tbInstancing},
		{"Tạm thời không đi"})
end;

function tbSend1:Enter(nPlayerId, tbInstancing)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end;
	
	me.NewWorld(tbInstancing.nMapId, self.tbSendPos[1], self.tbSendPos[2]);
end;