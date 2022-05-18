-- 2009 ֲ˷ޚ
-- maiyajin

local tbZhiShu09 = {};
SpecialEvent.ZhiShu2009 = tbZhiShu09;

tbZhiShu09.TASKGID = 3005;
tbZhiShu09.TASK_LAST_IRRIGATE_TIME = 56; -- خ۳ݽˮʱݤ
tbZhiShu09.TASK_LAST_PLANT_TIME = 57; -- خ۳ֲ˷ߪʼʱݤ
tbZhiShu09.TASK_LAST_PLANT_DAY = 58; -- خ۳ԉ٦ֲ˷ˇܸۅ
tbZhiShu09.TASK_TREE_COUNT_TODAY = 59; -- ձͬԉ٦ֲ˷˽
tbZhiShu09.TASK_TREE_COUNT_TOTAL = 60; -- ԉ٦ֲ˷؜˽
tbZhiShu09.TASK_TREE_IS_PLANTING = 61; -- ˇرֽ՚ֲ˷ 1:ࠉŜֽ՚ז 0:ûז
tbZhiShu09.TASK_LASK_GIVE_SEED_TIME = 62; -- خ۳Փľ|Ԧܱփזؓքʱݤ
tbZhiShu09.TASK_XP_COUNT_TODAY = 63; -- ձܱͬփքޭҩ˽
tbZhiShu09.TASK_HAND_UP_SEED_TOTAL = 64; -- ʏݻזؓ؜˽
tbZhiShu09.TASK_LAST_GIVE_XP_DAY = 65; -- خ۳һՎٸޭҩˇŇͬ

tbZhiShu09.WATER_TIME = 5; -- ݽһࠃ˷ʹԃքʱݤ
tbZhiShu09.GROW_TIME = 5; -- ݽˮԉ٦۳ٴנ߃Ӥԉճ˷
tbZhiShu09.ALERT_TIME = 20; -- ˷ľڵ̀ǰ ALERT_TIME ī͡ʾ
tbZhiShu09.DIE_TIME = 2 * 60; -- ˷ľٴנ߃һݽˮܡִ̀
tbZhiShu09.WATER_INTERVAL = 5; -- ݽˮخСʱݤݤٴ
tbZhiShu09.COLLECT_INTERVAL = 5; -- Ӊܯʱݤݤٴ
tbZhiShu09.MAX_TREE_COUNT_TODAY = 10; -- һͬخנࠉӔזܸࠃ˷
tbZhiShu09.MAX_TREE_COUNT_TOTAL = 300; -- ؜ٲࠉӔזܸࠃ˷
tbZhiShu09.JUG_VOLUMN = 10; -- ˮ۸քˮ
tbZhiShu09.GIVE_SEED_INTERVAL = 30 * 60; -- ¬ȡזؓքʱݤݤٴ
tbZhiShu09.GIVE_XP_INTERVAL = 5; -- ٸޭҩʱݤݤٴ
tbZhiShu09.BIG_TREE_LIFE = 1 * 60 * 20; -- ճ˷քʺļ

tbZhiShu09.tbNewSeed = {18,1,20347,1}; -- Bát Cháo
tbZhiShu09.tbOldSeed = {18,1,20344,1}; -- Củi
tbZhiShu09.tbJug = {18,1,20345,1}; -- Túi Củi
tbZhiShu09.tbBox = {18,1,20346,1}; -- Túi QUà TÌnh Thương
tbZhiShu09.tbListWaterPlayList = {};	--݇¼ݽˮ˽ߝ

tbZhiShu09.tbIndex2Data = {
		--{ģѥid, ޭҩ}
	[1] = {9628, 10}, -- ҙҙС˷ħ
	[2] = {9629, 20}, -- ֎դ˷ħ
	[3] = {9630, 30}, -- ԄÌС˷
	[4] = {9631, 40}, -- ؂׳С˷
	[5] = {9632, 50}, -- ՐԴ˷ľ
	[6] = {9633,  0}, -- ۃճһࠃ˷
};

tbZhiShu09.INDEX_BIG_TREE = #tbZhiShu09.tbIndex2Data; -- ճ˷քҠۅ

-- ̷̑ʭʏքˮ۸
-- return: pItem or nil
function tbZhiShu09:FindJug(pPlayer)
	local tbFind = pPlayer.FindItemInBags(unpack(self.tbJug));
	if tbFind[1] then
		return tbFind[1].pItem;
	end
	return nil;
end

-- ׵ܘ۹ࠉӔݽܸՎˮ
function tbZhiShu09:GetWaterTimes(pPlayer)
	local pJug = self:FindJug(pPlayer);
	if pJug then
		return pJug.GetGenInfo(1);
	else
		return 0;
	end
end

-- ˮ۸քˮݵ1
function tbZhiShu09:DecreWaterTimes(pPlayer)
	local pJug = self:FindJug(pPlayer);
	if pJug then
		local nTimes = pJug.GetGenInfo(1);
		nTimes = nTimes - 1;
		if nTimes < 0 then
			nTimes = 0;
		end
		pJug.SetGenInfo(1, nTimes);
		pJug.Sync();
		return;
	end
end

-- װúˮ۸
--no_msg ˇ nil ք۰ӅˤԶхϢ
function tbZhiShu09:FillJug(pPlayer, no_msg)
	local pJug = self:FindJug(pPlayer);
	if not pJug then
		return 0, "Túi Củi của người đâu?";
	end
	
	pJug.SetGenInfo(1,self.JUG_VOLUMN);
	pJug.Sync();
	
	if not no_msg then
		Dialog:SendBlackBoardMsg(pPlayer, "Túi Củi đã đầy củi, hãy mang đi nhóm lò nấu cháo đi đi");
	end
end

-- Ɛ׏Φݒֲ˷˽ˇرػۏҪȳ
function tbZhiShu09:IsTreeCountOk(pPlayer)
	-- ֲ˷؜
	local nTreeCountTotal = pPlayer.GetTask(self.TASKGID, self.TASK_TREE_COUNT_TOTAL);
	if nTreeCountTotal >= self.MAX_TREE_COUNT_TOTAL then
		return 0, "TOTAL", nTreeCountTotal;
	end
	
	local nToday = tonumber(GetLocalDate("%Y%m%d"));
	local nLastPlantDay = pPlayer.GetTask(self.TASKGID, self.TASK_LAST_PLANT_DAY);
	local nTreeCountToday = pPlayer.GetTask(self.TASKGID, self.TASK_TREE_COUNT_TODAY);
	
	-- ձֲͬ˷(עӢúձͬۅ˽ۍخ۳ֲ˷քۅ˽һҹʱӅѨҪƐ׏ìһһҹք۰ҭʾŇͬӑޭڽȥ)
	if nToday == nLastPlantDay and nTreeCountToday >= self.MAX_TREE_COUNT_TODAY then -- ֢זضר޶՚ܮ֯ԦԚ1ٶՂ؃ŚԐЧ
		return 0, "TODAY", nTreeCountToday;
	end
	
	return 1;
end

-- ࠉرז˷
-- return 0, 1
function tbZhiShu09:CanPlantTree(pPlayer)
	local nMapId, x, y = pPlayer.GetWorldPos();
	if nMapId > 8 then
		return 0, "Chỉ có thể nấu cháo ở Tân Thủ Thôn.";
	end
	
	local nRes, szKind, nNum = self:IsTreeCountOk(pPlayer);
	if nRes == 0 then
		if szKind == "TOTAL" then
			return 0, string.format("Bạn đã nấu %d Nồi Cháo, không cần nấu thêm nữa, hãy để dành chỗ cho người khác.", nNum);
		else
			return 0, string.format("Hôm nay Bạn đã nấu %d Nồi Cháo, hãy nghỉ ngơi, mai nấu tiếp. Tiếp xúc với bếp củi nhiều không tốt.", nNum);
		end
	end
	
	local tbNpcList = KNpc.GetAroundNpcList(pPlayer, 10);
	for _, pNpc in ipairs(tbNpcList) do
		if pNpc.nKind == 3 then
			return 0, "<color=green>".. pNpc.szName.."<color>: Ngươi sẽ làm bỏng ta mất nấu lui xa ta ra.";
		end
	end
	
	local nIsPlanting = pPlayer.GetTask(self.TASKGID, self.TASK_TREE_IS_PLANTING);
	if nIsPlanting == 0 then
		return 1;
	end
	
	local nCurrTime = GetTime();
	local nLastPlantTime = pPlayer.GetTask(self.TASKGID, self.TASK_LAST_PLANT_TIME);
	
		self:SetTreePlantingState(pPlayer.nId, 0);
		return 1;
end

-- ࠉرݽˮ
-- return 1 or 0
function tbZhiShu09:CanIrrigate(pPlayer, pNpc)
	local tbTreeData = pNpc.GetTempTable("Npc").tbPlantTree09;
	local nTreeIndex = tbTreeData.nTreeIndex;
	
	if not self:FindJug(pPlayer) then
		return 0, "Bạn chưa có Túi Củi, Hãy đi hỏi <color=yellow>Mộc Lương<color> xem sao.";
	end
	
	if self:GetWaterTimes(pPlayer) <= 0 then
		return 0, "Không có Củi trong Túi, Hãy tìm Mộc Lương để lấy Củi!";
	end
	
	if nTreeIndex == self.INDEX_BIG_TREE then -- ճ˷һԃՙݽˮ2
		return 0;
	end
	
	local nPlayerId = tbTreeData.nPlayerId; -- ֻŜݽؔܺŇࠃ˷
	if nPlayerId ~= pPlayer.nId then
		return 0;
	end
	
	local nCurrTime = GetTime();
	local nLastIrrigateTime = pPlayer.GetTask(self.TASKGID, self.TASK_LAST_IRRIGATE_TIME);
	
	local nInterval = nCurrTime - nLastIrrigateTime;
	if nInterval < self.WATER_INTERVAL then
		local szMsg = string.format("Nhóm lửa nhanh quá. Bạn đợi thêm <color=green>%d giây <color>thì có thể nhóm lửa.", self.WATER_INTERVAL - nInterval);
		return 0, szMsg;
	end
	
	return 1;
end

-- ˷ʏԐûԐזؓࠉӔӉܯ
function tbZhiShu09:HasSeed(pNpc)
	local nSeedCollectNum = pNpc.GetTempTable("Npc").tbPlantTree09.nSeedCollectNum;
	if nSeedCollectNum > 0 then
		return 0;
	else
		return 1;
	end
end


-- ˇرࠉӔӉܯڻʵ
function tbZhiShu09:CanGatherSeed(pPlayer, pNpc)
	local nCurrTime = GetTime();
	local nBirthday = pNpc.GetTempTable("Npc").tbPlantTree09.nBirthday;
	local nInterval = nCurrTime - nBirthday;
	if nInterval < self.COLLECT_INTERVAL then
		local szMsg = string.format("Hãy đợi %d giây nữa xem sao.", self.COLLECT_INTERVAL - nInterval);
		return 0, szMsg;
	end
	
	if pPlayer.nId ~= pNpc.GetTempTable("Npc").tbPlantTree09.nPlayerId then
		return 0;
	end
	
	if self:HasSeed(pNpc) == 0 then
		return 0;
	end
	
	if pPlayer.CountFreeBagCell() < 1 then
		return 0, "Hành trang của Bạn không đủ!";
	end
	
	return 1;
end

-- Ӊܯڻʵ
function tbZhiShu09:GatherSeed(pPlayer, pNpc)
	pPlayer.AddItem(unpack(self.tbNewSeed));
	pNpc.GetTempTable("Npc").tbPlantTree09.nSeedCollectNum = 1;
	return "Haha. Được Củi Tốt như thế này, mau đem Bát Cháo vừa múc ra đem tới Mộc Lương - Chủ tiệm Gỗ để a ta đưa cho người nghèo";
end

-- ˇرࠉӔٸΦݒזؓ
function tbZhiShu09:CanGiveSeed(pPlayer)
	if pPlayer.nLevel < 120 then
		return 0, "Cấp của Bạn dưới 120, không thể tham gia nấu cháo. Đạt cấp 120 hãy quay lại tìm ta!";
	end
	
	if self:FindJug(pPlayer) then 
		return 0,"Bạn có Túi Củi trong người rồi!";
	end
	
	local tbFind = pPlayer.FindItemInRepository(unpack(self.tbJug));
	if tbFind and #tbFind > 0 then
		return 0,"Bạn có Túi Củi trong người rồi!";
	end	
	
	if pPlayer.CountFreeBagCell() < 1 then
		return 0, "Hành trang của Bạn không đủ!";
	end
	
	return 1;
end

-- ٸΦݒˮ۸
function tbZhiShu09:GiveSeed(pPlayer)
	local pJug = pPlayer.AddItem(unpack(self.tbJug));
	if pJug then
		pJug.SetGenInfo(1,self.JUG_VOLUMN);
		pJug.Sync();
		Dialog:SendBlackBoardMsg(pPlayer, "Bạn đã được bỏ thêm củi.");
	end
end

-- Φݒʏݻזؓ
-- tbItem ΪΦݒʏݻքϯƷҭ
function tbZhiShu09:HandupSeed(pPlayer, tbItem)
	local nHandupSeedTotal = pPlayer.GetTask(self.TASKGID, self.TASK_HAND_UP_SEED_TOTAL);
	if nHandupSeedTotal >= self.MAX_TREE_COUNT_TOTAL then
		return 0, "Bạn đã đưa cho tôi " .. tostring(self.MAX_TREE_COUNT_TOTAL) .. ", hình như là đủ rồi đó.";
	end
	
	local tbSeed = {};
	for _, pItem in ipairs(tbItem) do
		if pItem[1].Equal(unpack(self.tbNewSeed)) == 1 then
			table.insert(tbSeed, pItem[1]);
		end
	end
	
	if pPlayer.CountFreeBagCell() < #tbSeed then
		return 0, "Hành trang của Bạn không đủ!";
	end
	
	local nCount = #tbSeed;
	if nCount > self.MAX_TREE_COUNT_TOTAL - nHandupSeedTotal then
		nCount = self.MAX_TREE_COUNT_TOTAL - nHandupSeedTotal;
	end
	
	local nActualCount = 0;
	for i = 1, nCount do
		local pItem =pPlayer.AddItem(unpack(self.tbBox));
		if pItem then
			table.remove(tbSeed).Delete(pPlayer);
			nActualCount = nActualCount + 1;
		end
	end
	
	pPlayer.SetTask(self.TASKGID, self.TASK_HAND_UP_SEED_TOTAL, nHandupSeedTotal + nActualCount);
	return 1;
end

-- ߪʼݽˮ
function tbZhiShu09:IrrigateBegin(pPlayer, pNpc)
	self:DecreWaterTimes(pPlayer);
	
	local tbEvent = 
	{
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SITE,
		Player.ProcessBreakEvent.emEVENT_USEITEM,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_DROPITEM,
		Player.ProcessBreakEvent.emEVENT_SENDMAIL,
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_DEATH,
	}
	
	GeneralProcess:StartProcess("Đang nhóm củi...", self.WATER_TIME * Env.GAME_FPS, 
			{self.IrrigateFinished, SpecialEvent.ZhiShu2009, pPlayer.nId, pNpc.dwId}, nil, tbEvent);
end

-- ݽˮޡ˸
function tbZhiShu09:IrrigateFinished(nPlayerId, dwNpcId)
	local pNpc = KNpc.GetById(dwNpcId);
	if not pNpc then -- ˷ࠝ̀
		return;
	end
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return 0;
	end
	pPlayer.SetTask(self.TASKGID, self.TASK_LAST_IRRIGATE_TIME, GetTime());
	local tbTreeData = pNpc.GetTempTable("Npc").tbPlantTree09;
	local nTreeIndex = tbTreeData.nTreeIndex;
	
	if tbTreeData.nTimerId_Water_Again then
		Timer:Close(tbTreeData.nTimerId_Water_Again);
	end
	if tbTreeData.nTimerId_Die then
		Timer:Close(tbTreeData.nTimerId_Die);
	end
	if tbTreeData.nTimerId_Alert then
		Timer:Close(tbTreeData.nTimerId_Alert);
	end
	if tbTreeData.nTimerId_Give_Xp then
		Timer:Close(tbTreeData.nTimerId_Give_Xp);
	end
	
	if nTreeIndex < self.INDEX_BIG_TREE then -- ˷ҪӤճ
		self.tbListWaterPlayList[nPlayerId] = 1;
		Dialog:SendBlackBoardMsg(pPlayer, "Nấu Cháo: nhóm lửa thành công!");
		local nMapId, x, y = pNpc.GetWorldPos();
		self:PlantTree(pPlayer, nTreeIndex + 1, nMapId, x, y);
		pNpc.Delete();
	end
end

function tbZhiShu09:HasReachXpLimit(pPlayer)
	local nToday = tonumber(GetLocalDate("%Y%m%d")); 
	local nLastGiveXpDay = pPlayer.GetTask(self.TASKGID, self.TASK_LAST_GIVE_XP_DAY);
	
	if nToday > nLastGiveXpDay then
		pPlayer.SetTask(self.TASKGID, self.TASK_XP_COUNT_TODAY, 0);
	end
	
	local nXpToday = pPlayer.GetTask(self.TASKGID, self.TASK_XP_COUNT_TODAY);
	if nXpToday >= pPlayer.GetBaseAwardExp()*72 then -- ÿܱͬȡޭҩʏО72ؖד
		return 1;
	else
		return 0;
	end
end

-- זЂ֚һࠃ˷
-- pItemúזؓ
function tbZhiShu09:Plant1stTree(pPlayer, dwItemId)
	local nRes = self:CanPlantTree(pPlayer);
	if nRes == 0 then 
		return;
	end
	
	local nMapId, x, y = pPlayer.GetWorldPos();
	local _, pNpc = self:PlantTree(pPlayer,1, nMapId, x, y, nil);
	if pNpc then
		local pItem = KItem.GetObjById(dwItemId);
		if pItem then
			pPlayer.ConsumeItemInBags(1, 18, 1, 20344, 1);
		end
	end
end

-- זЂһࠃ˷
-- return pNpc
function tbZhiShu09:PlantTree(pPlayer, nTreeIndex, nMapId, x, y)
	local nPlayerId = pPlayer.nId;
	local szPlayerName = pPlayer.szName;
	local nNpcId = self.tbIndex2Data[nTreeIndex][1];
	assert(nNpcId);
	
	local pNpc = KNpc.Add2(nNpcId, 1, -1, nMapId, x, y)
	
	if not pNpc then
		self:SetTreePlantingState(nPlayerId, 0);
		return 0;
	end
	
	if nTreeIndex == 1 then
		self:SetTreePlantingState(pPlayer.nId, 1);
		Dialog:SendBlackBoardMsg(pPlayer, "Bếp nấu Nồi Cháo đang sắp hết lửa nhóm thêm củi đi nào!");
	elseif nTreeIndex >= 2 and nTreeIndex < self.INDEX_BIG_TREE then
		Dialog:SendBlackBoardMsg(pPlayer, "Nồi Cháo bạn nấu đang sôi rồi kìa!");
	else
		Dialog:SendBlackBoardMsg(pPlayer, "HaHa. Nồi Cháo của Bạn đã bắt đầu có kết quả rồi, hãy đợi múc cháo thôi thôi!");
		self:TreeIsBigNow(pPlayer);
	end
	
	local tbTemp = pNpc.GetTempTable("Npc");
	
	local nTimerId_Die, nTimerId_Alert, nTimerId_Water_Again, nTimerId_Give_Xp;
	
	if nTreeIndex < self.INDEX_BIG_TREE then
		nTimerId_Water_Again = Timer:Register(self.WATER_INTERVAL * Env.GAME_FPS, self.CanWaterAgain, self, nPlayerId, pNpc.dwId);
		nTimerId_Alert = Timer:Register((self.DIE_TIME - self.ALERT_TIME) * Env.GAME_FPS, self.TreeDieAlert, self, nPlayerId, pNpc.dwId);
		nTimerId_Die = Timer:Register(self.DIE_TIME * Env.GAME_FPS, self.TreeDie, self, nPlayerId, pNpc.dwId);
		
		if nTreeIndex > 1 then
			nTimerId_Give_Xp = Timer:Register(self.GIVE_XP_INTERVAL * Env.GAME_FPS, self.GiveXp, self, nPlayerId, pNpc.dwId);
		end
	else
		nTimerId_Water_Again = nil;
		nTimerId_Alert = nil;
		nTimerId_Die = Timer:Register(self.BIG_TREE_LIFE * Env.GAME_FPS, self.TreeDie, self, nPlayerId, pNpc.dwId, 1);
		nTimerId_Give_Xp = nil;
	end
	
	tbTemp.tbPlantTree09 = {
		["nPlayerId"] = nPlayerId,
		["nTreeIndex"]  = nTreeIndex; -- הӦ tbZhiShu09.tbIndex2Data ք̷ӽ
		["nTimerId_Water_Again"] = nTimerId_Water_Again;
		["nTimerId_Die"] = nTimerId_Die;
		["nTimerId_Alert"] = nTimerId_Alert;
		["nTimerId_Give_Xp"] = nTimerId_Give_Xp;
		["nBirthday"] = GetTime();
		["nSeedCollectNum"] = 0; -- ΦݒՓ֢ࠃ˷ʏӉܯנʙזؓ
		};
		
	pNpc.szName = pNpc.szName .. " của " .. szPlayerName;
	return 0, pNpc;
end
function tbZhiShu09:_RpGetPlayerList(pPlayer, pNpc)
	local nTeamId = pPlayer.nTeamId;
	local tbValidPlayer = {};  -- ՚˷לΧքͬةΦݒ
	local nDistance = 100;
	local nTreeIndex = pNpc.GetTempTable("Npc").tbPlantTree09.nTreeIndex;
	local nXp = self.tbIndex2Data[nTreeIndex][2];
	local tbPlayerList = KNpc.GetAroundPlayerList(pNpc.dwId, nDistance);
	if tbPlayerList then
		for _, pPlayerNearby in ipairs(tbPlayerList) do
			if pPlayerNearby.nId == pPlayer.nId then
				table.insert(tbValidPlayer, pPlayerNearby);
			elseif nTeamId > 0 then
				local nIsPlanting = pPlayerNearby.GetTask(self.TASKGID, self.TASK_TREE_IS_PLANTING);
				if pPlayerNearby.nTeamId == nTeamId and nIsPlanting == 1 and self.tbListWaterPlayList[pPlayerNearby.nId] then
					table.insert(tbValidPlayer, pPlayerNearby);
				end
			end
		end
	end
	return tbValidPlayer;
end

-- ٸΦݒޭҩ
function tbZhiShu09:GiveXp(nPlayerId, dwNpcId)
	local pNpc = KNpc.GetById(dwNpcId);
	if not pNpc then
		return 0;
	end
	
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return;
	end
	local tbValidPlayer = self:_RpGetPlayerList(pPlayer, pNpc);
	local nXp = pPlayer.GetBaseAwardExp()/12;
--	local nToday = tonumber(os.date("%Y%m%d"));
	local nToday = tonumber(GetLocalDate("%Y%m%d"));
	for _, pMPlayer in ipairs(tbValidPlayer) do
		if self:HasReachXpLimit(pMPlayer) == 0 then
			pMPlayer.AddExp(#tbValidPlayer * nXp);
			local nXpToday = pMPlayer.GetTask(self.TASKGID, self.TASK_XP_COUNT_TODAY);
			pMPlayer.SetTask(self.TASKGID, self.TASK_XP_COUNT_TODAY, nXpToday + #tbValidPlayer * nXp);
			pMPlayer.SetTask(self.TASKGID, self.TASK_LAST_GIVE_XP_DAY, nToday);
		end
	end
end


-- ͡ёࠉӔݽˮ
function tbZhiShu09:CanWaterAgain(nPlayerId, dwNpcId)
	local pNpc = KNpc.GetById(dwNpcId);
	if not pNpc then
		return 0;
	end
	
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer then
		Dialog:SendBlackBoardMsg(pPlayer, "Bây giờ Bạn có thể nhóm củi!");
	end
	pNpc.GetTempTable("Npc").tbPlantTree09.nTimerId_Water_Again = nil;
	return 0;
end

-- ͡ёࠬݽˮ
function tbZhiShu09:TreeDieAlert(nPlayerId, dwNpcId)
	local pNpc = KNpc.GetById(dwNpcId);
	if not pNpc then
		return 0;
	end
	
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer then
		Dialog:SendBlackBoardMsg(pPlayer, "Nồi Cháo của Bạn còn 20 giây nữa sẽ khê, Mau nhóm củi đi.");
	end
	pNpc.GetTempTable("Npc").tbPlantTree09.nTimerId_Alert = nil;
	return 0;
end

-- ࠝ̀
function tbZhiShu09:TreeDie(nPlayerId, dwNpcId, nState)
	local pNpc = KNpc.GetById(dwNpcId);
	if not pNpc then
		return 0;
	end
	
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not nState and pPlayer then
		Dialog:SendBlackBoardMsg(pPlayer, "Thật đáng tiếc, Nồi Cháo của bạn đã bị khê rồi, lần sau hãy cẩn thận hơn 1 chút nhé");
	end
	self:SetTreePlantingState(nPlayerId, 0);
	
	local nTimerId_Give_Xp = pNpc.GetTempTable("Npc").tbPlantTree09.nTimerId_Give_Xp;
	if nTimerId_Give_Xp then
		Timer:Close(nTimerId_Give_Xp);
	end
	self.tbListWaterPlayList[nPlayerId] = nil
	pNpc.Delete();
	return 0;
end

-- ˇرճ˷
-- return 0, 1
function tbZhiShu09:IsBigTree(pNpc)
	local nTreeIndex = pNpc.GetTempTable("Npc").tbPlantTree09.nTreeIndex;
	if nTreeIndex == self.INDEX_BIG_TREE then
		return 1;
	else
		return 0;
	end
end

-- ʨ׃ֲ˷״̬
function tbZhiShu09:SetTreePlantingState(nPlayerId, nState)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer then
		pPlayer.SetTask(self.TASKGID, self.TASK_TREE_IS_PLANTING, nState);
		if nState == 1 then
			pPlayer.SetTask(self.TASKGID, self.TASK_LAST_PLANT_TIME, GetTime());
		end
	end
end

-- Ӥԉճ˷۳քәط
function tbZhiShu09:TreeIsBigNow(pPlayer)
	local nTreeCountTotal = pPlayer.GetTask(self.TASKGID, self.TASK_TREE_COUNT_TOTAL);
	pPlayer.SetTask(self.TASKGID, self.TASK_TREE_COUNT_TOTAL, nTreeCountTotal + 1);
	
	local nToday = tonumber(GetLocalDate("%Y%m%d"));
	local nLastPlantDay = pPlayer.GetTask(self.TASKGID, self.TASK_LAST_PLANT_DAY);
	local nTreeCountToday = pPlayer.GetTask(self.TASKGID, self.TASK_TREE_COUNT_TODAY);
	
	if nToday > nLastPlantDay then
		pPlayer.SetTask(self.TASKGID, self.TASK_TREE_COUNT_TODAY, 1);
	else
		pPlayer.SetTask(self.TASKGID, self.TASK_TREE_COUNT_TODAY, nTreeCountToday + 1);
	end
	
	pPlayer.SetTask(self.TASKGID, self.TASK_LAST_PLANT_DAY, nToday);
	self:SetTreePlantingState(pPlayer.nId, 0); 
end

function tbZhiShu09:GetOwnerId(pNpc)
	return pNpc.GetTempTable("Npc").tbPlantTree09.nPlayerId;
end

function tbZhiShu09:ClearTask(pPlayer)
	for i = 56, 63 do
		pPlayer.SetTask(tbZhiShu09.TASKGID, i, 0);
	end
end

-- ?pl DoScript("\\script\\event\\jieri\\200903_zhishujie\\logic.lua")