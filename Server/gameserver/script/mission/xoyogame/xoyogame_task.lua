-- 逍遥谷挑战
XoyoGame.XoyoChallenge = XoyoGame.XoyoChallenge or {};
local XoyoChallenge = XoyoGame.XoyoChallenge;

XoyoChallenge.tbNpcId2Data = {};
XoyoChallenge.tbNpcId2Data_id = {}; -- 内容与tbNpcId2Data一样，但用每行开头的id做索引

XoyoChallenge.tbItem2Data = {};
XoyoChallenge.tbItem2Data_id = {}; -- 内容与tbItem2Data一样，但用每行开头的id做索引

XoyoChallenge.tbRoom2Data = {};
XoyoChallenge.tbRoom2Data_id = {}; -- 内容与tbRoom2Data一样，但用每行开头的id做索引

XoyoChallenge.tbCardStorage = {};
XoyoChallenge.tbCardStorage_probability = {};

XoyoChallenge.TASKGID = 2050;
XoyoChallenge.TASK_NPC_BEGIN = 20; -- npc任务用，每个2位，1表示已收集卡片，2表示已使用卡片
XoyoChallenge.TASK_ITEM_BEGIN = 24; -- 收集物品用
XoyoChallenge.TASK_ROOM_BEGIN = 28; -- 过房间用
XoyoChallenge.TASK_END = 32; -- 这个不使用
XoyoChallenge.TASK_GET_XOYOLU_MONTH = 41; -- 记录获得逍遥录的年和月，如200903
XoyoChallenge.TASK_HANDUP_XOYOLU_MONTH = 42; -- 上交的是那个时候获得的逍遥录，如200903
XoyoChallenge.TASK_SPECIAL_CARD_DATE = 43; -- 获得特殊卡的日期，如20090312
XoyoChallenge.TASK_SPECIAL_CARD_NUM = 44; -- 当天成功换特殊卡的数量
XoyoChallenge.TASK_GET_AWARD_MONTH = 45; -- 领奖时间，例如玩家在200906拿了逍遥录，他在下个月领奖后，就会把这个变量记上200906（拿逍遥录的月份）
XoyoChallenge.TASK_GET_AWARD_MONTH_COPY = 46; --7月临时使用领奖时间任务变量

XoyoChallenge.tbSpecialCard = {18,1,314,1}; -- 特殊卡
XoyoChallenge.tbXoyolu = {18,1,318,1}; -- 逍遥录
XoyoChallenge.MAX_SPECIAL_CARD_NUM = 2; -- 每天最多换两张特殊卡

XoyoChallenge.MINUTE_OF_MONTH = 32*24*60;

-------------- load file ---------------------------

function XoyoChallenge:LoadCommonEntry(nRowNum, tbRow)
	local g,d,p,l = tonumber(tbRow.CARD_G), tonumber(tbRow.CARD_D), tonumber(tbRow.CARD_P), tonumber(tbRow.CARD_L);
	local id = tonumber(tbRow.Id);
	assert(id == nRowNum);
	local tb = {["tbCardGDPL"] = {g,d,p,l}, ["szCardGDPL"] = string.format("%d,%d,%d,%d",g,d,p,l),
			["id"] = id, ["szDesc"] = tbRow.CARD_DESC, ["nWeight"] = tonumber(tbRow.CARD_WEIGHT), ["nProbability"] = tbRow.PROBABILITY};
	return tb, id;
end

function XoyoChallenge:__LoadDropRate(tbRow, szKey)
	local tbId = Lib:SplitStr(tbRow[szKey], "|"); -- ROOM_ID或者NPC_ID
	for i = 1, #tbId do
		tbId[i] = assert(tonumber(tbId[i]));
	end
	
	local tbDropRate = Lib:SplitStr(tbRow.DROP_RATE, "|");
	for i = 1, #tbDropRate do
		tbDropRate[i] = assert(tonumber(tbDropRate[i]));
	end
	
	assert(#tbId == #tbDropRate);
	return tbId, tbDropRate;
end

function XoyoChallenge:LoadFile()
local tbFile = Lib:LoadTabFile("\\setting\\xoyogame\\card_kill_npc.txt");
for i = 1, #tbFile do
	local tbRow = tbFile[i];
	
	local tbNpcId, tbDropRate = self:__LoadDropRate(tbRow, "NPCID");
	
	for j = 1, #tbNpcId do
		local nNpcId = tbNpcId[j];
		local nDropRate = tbDropRate[j];
		assert(XoyoChallenge.tbNpcId2Data[nNpcId] == nil, tostring(nNpcId));
		local tb, id = XoyoChallenge:LoadCommonEntry(i, tbRow);
		tb["nDropRate"] = nDropRate;
		XoyoChallenge.tbNpcId2Data[nNpcId] = tb;
		XoyoChallenge.tbNpcId2Data_id[id] = tb;
	end
end

tbFile = Lib:LoadTabFile("\\setting\\xoyogame\\card_collect_item.txt");
for i = 1, #tbFile do
	local tbRow = tbFile[i];
	local szKey = string.format("%s,%s,%s,%s", tbRow.ITEM_G, tbRow.ITEM_D, tbRow.ITEM_P, tbRow.ITEM_L);
	local nNum = tonumber(tbRow.NUM);
	assert(XoyoChallenge.tbItem2Data[szKey] == nil);
	local tb, id = XoyoChallenge:LoadCommonEntry(i, tbRow);
	tb["nNeededNum"] = nNum;
	tb["tbItemGDPL"] = {tonumber(tbRow.ITEM_G), tonumber(tbRow.ITEM_D), tonumber(tbRow.ITEM_P), tonumber(tbRow.ITEM_L)};
	XoyoChallenge.tbItem2Data[szKey] = tb;
	XoyoChallenge.tbItem2Data_id[id] = tb;
end

tbFile = Lib:LoadTabFile("\\setting\\xoyogame\\card_room.txt");
for i = 1, #tbFile do
	local tbRow = tbFile[i];
	local tbRoomId, tbDropRate = self:__LoadDropRate(tbRow, "ROOM_ID");
	
	for j = 1, #tbRoomId do
		local nRoomId = tbRoomId[j];
		local nDropRate = tbDropRate[j];
		assert(XoyoChallenge.tbRoom2Data[nRoomId] == nil);
		local tb, id = XoyoChallenge:LoadCommonEntry(i, tbRow);
		tb["nDropRate"] = nDropRate;
		XoyoChallenge.tbRoom2Data[nRoomId] = tb;
		XoyoChallenge.tbRoom2Data_id[id] = tb;
	end
end
end
--------------- load file end------------------------

XoyoChallenge.nCardNum = 0; -- 卡片总数
XoyoChallenge.nProbabilitySum = 0; -- 概率总和
function XoyoChallenge:InitCardStorage()
	local tbCtrl = {
		{self.tbNpcId2Data, self.TASK_NPC_BEGIN},
		{self.tbItem2Data,  self.TASK_ITEM_BEGIN},
		{self.tbRoom2Data,  self.TASK_ROOM_BEGIN},
		{nil, 				self.TASK_END}
	};
	
	for i = 1, #tbCtrl - 1 do
		local info = tbCtrl[i];
		
		for _, v in pairs(info[1]) do
			local szKey = string.format("%d,%d,%d,%d", unpack(v.tbCardGDPL));
			local nTaskId = info[2] + math.floor((v.id - 1)*2 / 32);
			local nBit = math.fmod((v.id - 1)*2, 32);
			
			assert(nTaskId < tbCtrl[i + 1][2], string.format("i:%d, id:%d", i, v.id)); -- 不能超过该类任务的数量限制(id太大)
			
			if self.tbCardStorage[szKey] and
				not (self.tbCardStorage[szKey][3] == i and self.tbCardStorage[szKey][4] == v.id) then -- npc表有多个npcId对应同一个卡片的情况
					
				assert(false, string.format("prev i:%d, prev id:%d, curr i:%d, curr id:%d, gdpl:%s", 
					self.tbCardStorage[szKey][3], self.tbCardStorage[szKey][3], i, v.id, szKey)); -- 卡片gdpl不能重复
			end
			
			if not self.tbCardStorage[szKey] then
				self.nProbabilitySum = self.nProbabilitySum + v.nProbability;
				self.tbCardStorage[szKey] = {nTaskId, nBit, i, v.id}; -- i和v.id构成该行的唯一标识
				self.tbCardStorage[szKey]["szDesc"] = v.szDesc;
				self.tbCardStorage[szKey]["tbCardGDPL"] = v.tbCardGDPL;
				self.tbCardStorage[szKey]["nWeight"] = v.nWeight;
				table.insert(self.tbCardStorage_probability, {self.nProbabilitySum, v.tbCardGDPL});
				self.nCardNum = self.nCardNum + 1;
			end
		end
	end
	
	self.nTotalWeight = 0;
	for _, v in pairs(self.tbCardStorage) do
		self.nTotalWeight = self.nTotalWeight + v.nWeight;
	end
	
	self.__tbRange = self:TransRange({self.MINUTE_OF_MONTH, self.nTotalWeight, self.nCardNum});
end

function XoyoChallenge:GetCardState(pPlayer, szCardGDPL)
	local info = self.tbCardStorage[szCardGDPL];
	assert(info, szCardGDPL);
	local nTask = info[1];
	local nBit = info[2];
	
	local nVal = pPlayer.GetTask(self.TASKGID, nTask);
	return Lib:LoadBits(nVal, nBit, nBit+1);
end

function XoyoChallenge:SetCardState(pPlayer, szCardGDPL, value)
	local info = self.tbCardStorage[szCardGDPL];
	assert(info, szCardGDPL);
	local nTask = info[1];
	local nBit = info[2];
	local nVal = pPlayer.GetTask(self.TASKGID, nTask);
	nVal = Lib:SetBits(nVal, value, nBit, nBit+1);
	pPlayer.SetTask(self.TASKGID, nTask, nVal);
end

if MODULE_GAMECLIENT then

function XoyoChallenge:InitXoyoluTips()
	local tbTipsRef = {
		[1] = XoyoChallenge.tbNpcId2Data_id,
		[2] = XoyoChallenge.tbRoom2Data_id,
		[3] = XoyoChallenge.tbItem2Data_id,
	};
	
	local nXoyoluTipsCol = 4; -- 4列
	local nXoyoluTipsRow = math.ceil(XoyoChallenge.nCardNum/nXoyoluTipsCol);
	local nTipsRefIdx = 1;
	local nTipsRefId  = 1;	
	XoyoChallenge.tbTips = {};	
	for col = 1, nXoyoluTipsCol do
		for row = 1, nXoyoluTipsRow do
			if not self.tbTips[row] then
				table.insert(self.tbTips, {});
			end
			table.insert(self.tbTips[row], tbTipsRef[nTipsRefIdx][nTipsRefId].szCardGDPL);
			nTipsRefId = nTipsRefId + 1;
			if nTipsRefId > #tbTipsRef[nTipsRefIdx] then
				nTipsRefIdx = nTipsRefIdx + 1;
				nTipsRefId = 1;
				if not tbTipsRef[nTipsRefIdx] then
					return;
				end
			end
		end
	end
end

function XoyoChallenge:GetXoyoluTips(pPlayer)
	local szTips = "";	
	szTips = "<color=green>Đã thu thập ("..self:GetGatheredCardNum(pPlayer).."/"..self:GetTotalCardNum()..") thẻ<color>\n\n";
	for _, tbRow in ipairs(self.tbTips) do
		local tbSz = {};
		for _, szCardGDPL in ipairs(tbRow) do
			local szEntry = string.format("%-10s", self.tbCardStorage[szCardGDPL].szDesc);
			if self:GetCardState(pPlayer, szCardGDPL) == 2 then
				szEntry = "<color=yellow>" .. szEntry .. "<color>";
			end
			table.insert(tbSz, szEntry);
		end
		
		for _, sz in ipairs(tbSz) do
			szTips = szTips .. sz;
		end
	end	
	
	return szTips;
end

end

function XoyoChallenge:CanHandUpItemForCard(pPlayer)
	local nRes, szMsg = self:GetXoyoluState(pPlayer, tonumber(GetLocalDate("%Y%m")));
	if nRes == 0 then
		return 0, szMsg;
	end
	return 1;
end


function XoyoChallenge:CanGetSpecialCard(pPlayer, _nToday)
	local nToday;
	if _nToday then
		nToday = _nToday;
	else
		nToday = tonumber(GetLocalDate("%Y%m%d"));
	end
	
	local nRes, szMsg = self:GetXoyoluState(pPlayer, math.floor(nToday/100));
	
	if nRes == 0 then
		return 0, szMsg;
	end
	
	local nLastGetDate = pPlayer.GetTask(self.TASKGID, self.TASK_SPECIAL_CARD_DATE);
	if nToday > nLastGetDate then
		pPlayer.SetTask(self.TASKGID, self.TASK_SPECIAL_CARD_NUM, 0);
	end
	
	local nCardNum = pPlayer.GetTask(self.TASKGID, self.TASK_SPECIAL_CARD_NUM);
	if nCardNum >= self.MAX_SPECIAL_CARD_NUM then
		return 0, string.format("Hôm nay ngươi đã đổi %d tấm thẻ, ngày mai hãy quay lại.", nCardNum);
	end
	
	if pPlayer.CountFreeBagCell() < self.MAX_SPECIAL_CARD_NUM then
		return 0, string.format("Túi không đủ chỗ. Hãy để trống %d ô rồi đến nhận sau.", self.MAX_SPECIAL_CARD_NUM);
	end
	
	return 1;
end

function XoyoChallenge:GetSpecialCard(pPlayer, tbItems)
	local nToday = tonumber(GetLocalDate("%Y%m%d"));
	local nRes, szMsg = self:CanGetSpecialCard(pPlayer, nToday);
	if nRes == 0 then
		return nRes, szMsg;
	end
	
	local nCardNum = pPlayer.GetTask(self.TASKGID, self.TASK_SPECIAL_CARD_NUM);
	local tbXoyoItem = {}; -- 逍遥谷成品表
	local nItemNum = 0;
	for _, tbItem in ipairs(tbItems) do
		local pItem = tbItem[1];
		if pItem.szClass == "xoyoitem" then
			table.insert(tbXoyoItem, pItem);
			nItemNum = nItemNum + pItem.nCount;
		end
	end
		
	local nGetCardNum = 0;
	local nCanGiveNum = math.min(self.MAX_SPECIAL_CARD_NUM - nCardNum, nItemNum);
	for i = 1, nCanGiveNum do
		local pItem = pPlayer.AddItem(unpack(self.tbSpecialCard));
		if pItem then
			self:__RemoveItem(pPlayer, 1, tbXoyoItem);
			nGetCardNum = nGetCardNum + 1;
		else
			break;
		end
	end
	
	if nGetCardNum > 0 then
		pPlayer.SetTask(self.TASKGID, self.TASK_SPECIAL_CARD_NUM, nGetCardNum + nCardNum);
		pPlayer.SetTask(self.TASKGID, self.TASK_SPECIAL_CARD_DATE, nToday);
	end
	
	return 1;
end

function XoyoChallenge:HandUpItemForCard(pPlayer, tbItems, tbItem2Data)
	if self:CanHandUpItemForCard(pPlayer) == 0 then
		return 0;
	end
	
	local tbItemsSorted = {}; -- "g,d,p,l" --> {pItem1, pItem2...}
		
	for _, tbItem in ipairs(tbItems) do
		local szKey = tbItem[1].SzGDPL();
		if tbItemsSorted[szKey] then
			table.insert(tbItemsSorted[szKey], tbItem[1]);
		elseif self.tbItem2Data[szKey] then
			tbItemsSorted[szKey] = {tbItem[1]};
		end
	end
	
	local nAlreadyHasSomeCard = 0;
	for k, tbItem in pairs(tbItemsSorted) do
		if self:HasItem(pPlayer, self.tbItem2Data[k].tbCardGDPL) == 0 
			and self:GetCardState(pPlayer, self.tbItem2Data[k].szCardGDPL) ~= 2 then
			local nNeededNum = self.tbItem2Data[k].nNeededNum;
			local nItemNum = 0;
			for _, pItem in ipairs(tbItem) do
				nItemNum = nItemNum + pItem.nCount;
			end
			
			if nItemNum >= nNeededNum then
				local tbData = self.tbItem2Data[k];
				
				if pPlayer.CountFreeBagCell() < 1 then
					return 0, "Túi không đủ chỗ.";
				end
				
				local nRes = self:_TryGiveCard(pPlayer, tbData);
				if nRes == 1 then
					self:__RemoveItem(pPlayer, nNeededNum, tbItem);
				else
					return 0;
				end
			end
		else
			nAlreadyHasSomeCard = 1;
		end
	end
	
	local szMsg;
	if nAlreadyHasSomeCard == 1 then
		szMsg = "Một số thẻ ngươi đã thu thập qua rồi, lần này sẽ không cho nữa.";
	end
	return 1, szMsg;
end

function XoyoChallenge:ItemForCardDesc()
	
	local szDesc = ""
	for _, v in ipairs(self.tbItem2Data_id) do
		local szItemName = string.format("%-8s",KItem.GetNameById(unpack(v.tbItemGDPL)));
		local szCardName = KItem.GetNameById(unpack(v.tbCardGDPL));
		szDesc = szDesc .. string.format("%s%s<enter>", szItemName .. " x " .. tostring(v.nNeededNum) .. ":", szCardName);
	end
	return szDesc;
end

function XoyoChallenge:__RemoveItem(pPlayer, nNeededNum, tbItem)
	local nDeletedNum = 0;
	while nDeletedNum < nNeededNum do
		local pItem = table.remove(tbItem);
		local nCanDelete = math.min(nNeededNum - nDeletedNum, pItem.nCount);
		local nNewCount = pItem.nCount - nCanDelete;
		if nNewCount == 0 then
			pItem.Delete(pPlayer);
		else
			pItem.SetCount(nNewCount);
			table.insert(tbItem,pItem);
		end
		assert(nCanDelete > 0);
		nDeletedNum = nDeletedNum + nCanDelete;
	end
	assert(nDeletedNum == nNeededNum);
end

function XoyoChallenge:KillNpcForCard(pPlayer, pNpc)
	if not pPlayer then
		return 0;
	end
	
	local nNpcTemplateId = pNpc.nTemplateId;
	if not self.tbNpcId2Data[nNpcTemplateId] then
		return 0;
	end
	
	local tbCandidatePlayer = {pPlayer};
	local nTeamId = pPlayer.nTeamId;
	if nTeamId > 0 then
		local tbPlayerList = KNpc.GetAroundPlayerList(pNpc.dwId, 50);
		for _, pPlayerNearby in ipairs(tbPlayerList) do
			if pPlayerNearby.nTeamId == nTeamId and pPlayer.nId ~= pPlayerNearby.nId then
				table.insert(tbCandidatePlayer, pPlayerNearby);
			end
		end
	end
	
	for _, pPlayer in ipairs(tbCandidatePlayer) do
		local nRes, tbData = self:_Check(pPlayer, nNpcTemplateId, self.tbNpcId2Data);
		if nRes == 1 then
			local nRand = MathRandom(1, 100);
			if nRand <= tbData.nDropRate then
				self:_TryGiveCard(pPlayer, tbData);
			end
		end
	end
end

function XoyoChallenge:PassRoomForCard(pPlayer, nRoomId)
	local nRes, tbData = self:_Check(pPlayer, nRoomId, self.tbRoom2Data);
	if nRes == 0 then
		return 0;
	end
	local nRand = MathRandom(1, 100);
	if nRand <= tbData.nDropRate then
		self:_TryGiveCard(pPlayer, tbData);
	end
end

function XoyoChallenge:HasItem(pPlayer, tbGDPL)
	local tb1 = pPlayer.FindItemInRepository(unpack(tbGDPL)); 
	local tb2 = pPlayer.FindItemInBags(unpack(tbGDPL));
	if not tb1[1] and not tb2[1] then
		return 0;
	else
		return 1;
	end
end

function XoyoChallenge:GetXoyoluState(pPlayer, nCurrYearMonth)
	if not nCurrYearMonth then
		nCurrYearMonth = tonumber(GetLocalDate("%Y%m"));
	end
	
	local nGetXoyoluMonth = pPlayer.GetTask(self.TASKGID, self.TASK_GET_XOYOLU_MONTH);
	
	if nGetXoyoluMonth < nCurrYearMonth then
		return 0, "Tháng này ngươi vẫn chưa nhận Tiêu Dao Lục.";
	end
	return 1;
end

function XoyoChallenge:_Check(pPlayer, key, tb)
	local tbData = tb[key];
	if not tbData then
		return 0;
	end
	
	if self:HasItem(pPlayer, tbData.tbCardGDPL) == 1 then -- 身上已有卡片
		return 0;
	end
	
	local nCurrYearMonth = tonumber(os.date("%Y%m", GetTime()));
	
	if self:GetXoyoluState(pPlayer, nCurrYearMonth) == 0 then -- 没有逍遥录
		return 0;
	end
		
	local nCardState = self:GetCardState(pPlayer, tbData.szCardGDPL);
	if nCardState == 2 then -- 已经放入逍遥录（已使用）
		return 0;
	end
	
	if pPlayer.CountFreeBagCell() < 1 then
		return 0;
	end
	
	return 1, tbData;
end

function XoyoChallenge:_TryGiveCard(pPlayer, tbData)
	local pItem = pPlayer.AddItem(unpack(tbData.tbCardGDPL));
	
	if not pItem then
		return 0;
	end
	
	if self.tbCardStorage[tbData.szCardGDPL].nWeight >= 10 then
		pPlayer.SendMsgToFriend("Hảo hữu của bạn ["..pPlayer.szName.."] trong nhiệm vụ thu thập Tiêu Dao Lục nhận được 1 tấm " .. pItem.szName .. ".");
	end
	
	return 1;
end

-- 清除卡片记录
function XoyoChallenge:ClearCardRecord(pPlayer)
	for i = self.TASK_NPC_BEGIN, self.TASK_END - 1 do
		pPlayer.SetTask(self.TASKGID, i, 0);
	end
end

-- 清除全部记录
function XoyoChallenge:Clear(pPlayer)
	for task = self.TASK_NPC_BEGIN, self.TASK_GET_AWARD_MONTH do
		pPlayer.SetTask(self.TASKGID, task, 0);
	end
end

-- 可否获取逍遥录
-- return 1 or 0, szMsg
function XoyoChallenge:CanGetXoyolu(pPlayer)
	if TimeFrame:GetState("OpenXoyoGameTask") ~= 1 then
		return 0;
	end
	
	local nCurrYearMonth, nPrevMonth = XoyoChallenge:__GetYearMonth();
	local nPrevGetMonth = pPlayer.GetTask(self.TASKGID, self.TASK_GET_XOYOLU_MONTH);
	local nGetAwardMonth = pPlayer.GetTask(self.TASKGID, self.TASK_GET_AWARD_MONTH);

	if nCurrYearMonth == 200907 and Task.IVER_nXoyo_GetAward_Fix == 1 then
		local nGetAwardCopy = pPlayer.GetTask(self.TASKGID, self.TASK_GET_AWARD_MONTH_COPY);
		if nPrevGetMonth == nPrevMonth and nGetAwardCopy == 0 then
			return 0, "Phần thưởng tháng trước vẫn chưa nhận, hãy nhận trước rồi đến lấy Tiêu Dao Lục!";
		end
	else
		if nPrevGetMonth == nPrevMonth and nGetAwardMonth < nPrevMonth then
			return 0, "Phần thưởng tháng trước vẫn chưa nhận, hãy nhận trước rồi đến lấy Tiêu Dao Lục!";
		end
	end
	
	if nPrevGetMonth >= nCurrYearMonth then
		return 0, "Tháng này đã cho ngươi 1 quyển rồi, trí nhớ của ta rất tốt, đừng hòng lừa ta.";
	end
	
	if pPlayer.CountFreeBagCell() < 1 then
		return 0, "Túi không đủ chỗ, để trống 1 ô rồi trở lại nhận Tiêu Dao Lục!";
	end
	
	return 1;
end

function XoyoChallenge:GetXoyolu(pPlayer)
	local nRes, szMsg = self:CanGetXoyolu(pPlayer);
	if nRes == 0 then
		return 0, szMsg;
	end
	
	local nYearMonth = tonumber(GetLocalDate("%Y%m"));
	local pItem = pPlayer.AddItem(unpack(self.tbXoyolu));
	
	if not pItem then
		return 0;
	end
	
	self:ClearCardRecord(pPlayer);
	pPlayer.SetTask(self.TASKGID, self.TASK_GET_XOYOLU_MONTH, nYearMonth);
	return 1;
end

function XoyoChallenge:HasXoyoluInBags(pPlayer)
	local tbFind = pPlayer.FindItemInBags(unpack(self.tbXoyolu));
	if not tbFind[1] then
		return 0;
	end
	return 1, tbFind[1].pItem;
end

function XoyoChallenge:TransRange(tbRange, nMax)
	local tbRes = {}
	local n = 1
	for _, v in ipairs(tbRange) do
		n = n*(v+1)
		table.insert(tbRes,n)
	end
	local max = table.remove(tbRes)
	if not nMax then nMax = 2147483648 end
	assert(max < nMax)
	table.insert(tbRes, 1, 0)
	return tbRes
end

function XoyoChallenge:PackNumber(tbR, tbData)
	local n = 0;
	local i = #tbData;
	while i > 1 do
		n = n + tbData[i]*tbR[i]
		i = i - 1
	end
	n = n + tbData[1]
	return n
end

function XoyoChallenge:UnpackNumber(tbR, nNum)
	local tbRes = {}
	local i = #tbR
	while i > 1 do
		table.insert(tbRes, 1, math.floor((nNum)/tbR[i]))
		nNum = math.fmod(nNum, tbR[i])
		i = i - 1
	end
	table.insert(tbRes, 1, nNum)
	return tbRes
end

function XoyoChallenge:GetTotalPoint(pPlayer)
	local tbTime = os.date("*t", GetTime());
	local nMinRemain = self.MINUTE_OF_MONTH - (tbTime.day*1440 + tbTime.hour*60 + tbTime.min);
	local nCardNum = 0;
	local nWeightSum = 0;
	
	for szCardGDPL, tbData in pairs(self.tbCardStorage) do
		if self:GetCardState(pPlayer, szCardGDPL) == 2 then
			nCardNum = nCardNum+1;
			nWeightSum = nWeightSum+tbData.nWeight;
		end
	end
	
	if nCardNum > 0 then
		return self:PackNumber(self.__tbRange, {nMinRemain, nWeightSum, nCardNum});
	else
		return 0;
	end
end

function XoyoChallenge:GetLadderDesc(nPoints)
	local tbData = self:UnpackNumber(self.__tbRange, nPoints);
	local nCardNum = tbData[3];
	local nLastUseCardDate = tbData[1]
	local tbTime = os.date("*t", GetTime());
	local nMonth = tbTime.month
	if tbTime.day == 1 then -- 1号看到的还是上个月的排名
		if nMonth == 1 then
			nMonth = 12;
		else
			nMonth = nMonth - 1;
		end
	end
	local nDay = math.floor((self.MINUTE_OF_MONTH - nLastUseCardDate)/1440);
	local nHour = math.floor((self.MINUTE_OF_MONTH -nLastUseCardDate - nDay*1440)/60);
	local nMin = self.MINUTE_OF_MONTH - nLastUseCardDate - nDay*1440 - nHour*60;
	local szContext = string.format("%d tấm\nThời hạn sử dụng thẻ: %d - %d %.2d:%.2d", nCardNum, nMonth, nDay, nHour, nMin);
	local szTxt1 = string.format("%d tấm", nCardNum);
	return szContext, szTxt1;
end

function XoyoChallenge:Point2CardNum(nPoints)
	return self:UnpackNumber(self.__tbRange, nPoints)[3];
end


function XoyoChallenge:UseCard(pPlayer, pCard)
	if self:HasXoyoluInBags(pPlayer) == 0 then
		return 0, "Bạn không có Tiêu Dao Lục, không thể sử dụng thẻ. Mau đến chỗ Hiểu Phi ở Tiêu Dao Cốc nhận 1 quyển.";
	end
	
	if self:GetCardState(pPlayer, pCard.SzGDPL()) == 2 then
		return 0, "Tháng này ngươi đã thu thập qua tấm thẻ này.";
	end
	
	self:SetCardState(pPlayer, pCard.SzGDPL(), 2);
	pCard.Delete(pPlayer);
	
	local nPrevPoint = GetXoyoPointsByName(pPlayer.szName); -- 这个月的点数
	local nCurrPoint = self:GetTotalPoint(pPlayer);
	
	if nCurrPoint > nPrevPoint then
		PlayerHonor:SetPlayerXoyoPointsByName(pPlayer.szName, nCurrPoint);
	end
	
	return 1;
end

function XoyoChallenge:__GetYearMonth()
	local tbTime = os.date("*t", GetTime());
	local nYearMonth = tbTime.year * 100 + tbTime.month;
	local nPrevMonth;
	if tbTime.month == 1 then
		nPrevMonth = (tbTime.year - 1)*100 + 12;
	else
		nPrevMonth = nYearMonth - 1;
	end
	return nYearMonth, nPrevMonth;
end

function XoyoChallenge:CanGetAward(pPlayer)
	local nLastGetAwardMonth = pPlayer.GetTask(self.TASKGID, self.TASK_GET_AWARD_MONTH);
	local nGetXoyoluMonth    = pPlayer.GetTask(self.TASKGID, self.TASK_GET_XOYOLU_MONTH);
	local nYearMonth, nPrevMonth = self:__GetYearMonth();
	
	if nYearMonth == 200907 and Task.IVER_nXoyo_GetAward_Fix == 1  then
		local nGetAwardCopy = pPlayer.GetTask(self.TASKGID, self.TASK_GET_AWARD_MONTH_COPY);
		if nGetAwardCopy > 0 then
			return 0, "Tháng này ngươi đã nhận thưởng rồi, đừng hòng lừa ta.";
		end
	else
		if nLastGetAwardMonth >= nPrevMonth then
			return 0, "Tháng này ngươi đã nhận thưởng rồi, đừng hòng lừa ta.";
		end
	end
	
	if nPrevMonth > nGetXoyoluMonth then -- 很久前领的逍遥录
		return 0, "Tháng trước ngươi không nhận Tiêu Dao Lục, còn muốn nhận thưởng?";
	end
	
	if nYearMonth == nGetXoyoluMonth then -- 当月领的逍遥录，尚未排名
		return 0, "Tháng này ngươi đã nhận Tiêu Dao Lục, tháng sau hãy quay lại.";
	end
	
	if KGblTask.SCGetDbTaskInt(DBTASK_XOYO_FINAL_LADDER_MONTH) ~= nYearMonth then
		return 0, "Xếp hạng của tháng trước vẫn chưa có.";
	end
	
	if nYearMonth == 200907 and Task.IVER_nXoyo_GetAward_Fix == 1  then
		local nGetAwardCopy = pPlayer.GetTask(self.TASKGID, self.TASK_GET_AWARD_MONTH_COPY);
		assert(nGetXoyoluMonth == nPrevMonth);
		assert(nGetAwardCopy == 0);
	else
		assert(nGetXoyoluMonth == nPrevMonth);
		assert(nLastGetAwardMonth < nPrevMonth);
	end
	
	return 1, nYearMonth, nPrevMonth;
end

function XoyoChallenge:GetAward(pPlayer)
	local nRes, var, nPrevMonth = self:CanGetAward(pPlayer);
	if nRes == 0 then
		return nRes, var;
	end
	
	local nYearMonth = var;
	local nRank = GetXoyoPointsRank(pPlayer.szName);
	local nLastMonthPoint = GetXoyoLastPointsByName(pPlayer.szName); -- 上个月的点数
	local nCardNum = self:Point2CardNum(nLastMonthPoint);
	
	if (not ((0 <nRank and nRank < 3001) or nCardNum>=24 )) or -- 最后一个条件是排不上名次，但收集了24+张卡
		(nYearMonth <= 200909 and self:GetGatheredCardNum(pPlayer) <= 0) -- 上个月卡片数为0
	then 
		--SetXoyoPointsRank(pPlayer.szName, 0);
		pPlayer.SetTask(self.TASKGID, self.TASK_GET_AWARD_MONTH, nPrevMonth);
		pPlayer.SetTask(self.TASKGID, self.TASK_GET_AWARD_MONTH_COPY, nPrevMonth);
		
		local szLog = string.format("Tên người chơi: %s Không được thưởng. Hạng: %d, điểm: %d, lượng thẻ thu thập: % d", 
			pPlayer.szName, nRank, nLastMonthPoint, nCardNum);
		Dbg:WriteLog("XoyoChallenge:GetAward", szLog);
		pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "Nhận thưởng khiêu chiến Tiêu Dao Cốc: " .. szLog);
		
		return 0, "Chỗ ta không có ghi chép nhận thưởng của ngươi, hãy tiếp tục cố gắng.";
	end
	
	local tbFinishAward = {
		--大陆,马来,盛大
		[1]=
		{
			[1] = {tbItem={18,1,114,10}, nCount=1, nTime=43200},--1-10
			[2] = {tbItem={18,1,114,9},	 nCount=2, nTime=43200},--11-100
			[3] = {tbItem={18,1,114,9},  nCount=1, nTime=43200},--101-500
			[4] = {tbItem={18,1,114,8},  nCount=2, nTime=43200},--501-1500
			[5] = {tbItem={18,1,114,8},  nCount=1, nTime=43200},--1501-3000或24张卡
		}, 
		--越南版
		[2]=
		{
			[1] = {tbItem={18,1,460,2},  nCount=5, nTime=43200},--1-10
			[2] = {tbItem={18,1,460,2},	 nCount=3, nTime=43200},--11-100
			[3] = {tbItem={18,1,460,2},  nCount=2, nTime=43200},--101-500
			[4] = {tbItem={18,1,460,2},  nCount=1, nTime=43200},--501-1500
			[5] = {tbItem={18,1,460,1},  nCount=2, nTime=43200},--1501-3000或24张卡
		}, 		
	};
	local nRankType = 5;
	if nRank > 0 and nRank <= 10 then
		nRankType = 1;
	elseif nRank > 10 and nRank <= 100 then
		nRankType = 2;
	elseif nRank > 100 and nRank <= 500 then
		nRankType = 3;
	elseif nRank > 500 and nRank <= 1500 then
		nRankType = 4;
	end
	
	local tbGiveAward = tbFinishAward[EventManager.IVER_nXoyoGameTaskAwardType][nRankType];
	if pPlayer.CountFreeBagCell() < tbGiveAward.nCount then
		return 0, string.format("Dọn túi rồi quay lại nhận thưởng. <color=red>(Cần %s ô trống)<color>", tbGiveAward.nCount);
	end
	local szItemName = "";
	local nAddCount = 0;
	for i=1, tbGiveAward.nCount do
		local pItem = pPlayer.AddItem(unpack(tbGiveAward.tbItem));
		if pItem then 
			pPlayer.SetItemTimeout(pItem, tbGiveAward.nTime, 0);
			pItem.Sync();
			szItemName  = pItem .szName;
			nAddCount   = nAddCount  + 1;
		end
	end
	
	SetXoyoPointsRank(pPlayer.szName, 0);
	pPlayer.SetTask(self.TASKGID, self.TASK_GET_AWARD_MONTH, nPrevMonth); -- 领取的是那个月的奖励
	pPlayer.SetTask(self.TASKGID, self.TASK_GET_AWARD_MONTH_COPY, nPrevMonth);
	
	--log
	local szLog = string.format("Tên người chơi: %s thưởng: %s, hạng: %d, điểm: %d lượng thẻ thu thập: %d", 
		pPlayer.szName, szItemName, nRank, nLastMonthPoint, nCardNum);
	Dbg:WriteLog("XoyoChallenge:GetAward", szLog);
	pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "Nhận thưởng khiêu chiến Tiêu Dao Cốc: " .. szLog);
	
	-- msg
	if 1 <= nRank and nRank <= 100 then
		pPlayer.SendMsgToFriend(string.format("Hảo hữu của bạn, [%s] tháng trước tham gia nhiệm vụ thu thập Tiêu Dao Lục đạt hạng %d, nhận được phần thưởng %s.",
			pPlayer.szName, nRank, nAddCount, szItemName));
	end
	
	local szMsg;
	if nRank > 0 then
		szMsg = string.format("Chúc mừng bạn được hạng %d trong nhiệm vụ thu thập Tiêu Dao Lục tháng trước!", nRank);
	else
		szMsg = string.format("Bạn đã thu thập được %d tấm thẻ trong nhiệm vụ thu thập Tiêu Dao Lục tháng trước, thành tích khá lắm!", nCardNum);
	end
		
	return 1, szMsg;
end

function XoyoChallenge:GetRandomCard()
	local nRand = MathRandom(1, self.nProbabilitySum);
	local tbCardGDPL;
	for _, v in pairs(self.tbCardStorage_probability) do
		tbCardGDPL = v[2]; -- 保证返回有效值
		if nRand <= v[1] then
			break;
		end
	end
	return tbCardGDPL;
end

function XoyoChallenge:GetGatheredCardNum(pPlayer)
	local nFinishedNum = 0;
	for k, _ in pairs(self.tbCardStorage) do
		if self:GetCardState(pPlayer, k) == 2 then
			nFinishedNum = nFinishedNum + 1;
		end
	end
	return nFinishedNum;
end

function XoyoChallenge:GetTotalCardNum()
	return self.nCardNum;
end

function XoyoChallenge:GetAwardRemind()
	local nYearMonth, nPrevMonth = self:__GetYearMonth();
	local nPrevGetMonth = me.GetTask(self.TASKGID, self.TASK_GET_XOYOLU_MONTH);
	local nGetAwardMonth = me.GetTask(self.TASKGID, self.TASK_GET_AWARD_MONTH);
	local nGetAwardCopy = me.GetTask(self.TASKGID, self.TASK_GET_AWARD_MONTH_COPY);
	if nYearMonth == 200907 and Task.IVER_nXoyo_GetAward_Fix == 1 then
		if nPrevGetMonth == nPrevMonth and nGetAwardCopy == 0 and 
			KGblTask.SCGetDbTaskInt(DBTASK_XOYO_FINAL_LADDER_MONTH) == nYearMonth
		then
			me.Msg("Phần thưởng thu thập Tiêu Dao Lục tháng rồi ngươi chưa nhận, hãy tìm Hiểu Phi ngay cửa vào Tiêu Dao Cốc để nhận");
		end
	else
		if nPrevGetMonth == nPrevMonth and nGetAwardMonth < nPrevMonth and
			KGblTask.SCGetDbTaskInt(DBTASK_XOYO_FINAL_LADDER_MONTH) == nYearMonth
		then
			me.Msg("Phần thưởng thu thập Tiêu Dao Lục tháng rồi ngươi chưa nhận, hãy tìm Hiểu Phi ngay cửa vào Tiêu Dao Cốc để nhận");
		end
	end
end

function XoyoChallenge:__debug__output_curr_rank()
	me.Msg("__debug__output_curr_rank " .. GetLocalDate("%H:%M"))
	local tbName = {}
	for i = 1, 100 do 
		local szName = KGCPlayer.GetPlayerName(i)
		if not szName then
			break;
		end
		table.insert(tbName, szName)
	end
	
	for i, name in ipairs(tbName) do
		local nPoint = GetXoyoPointsByName(name);
		me.Msg(string.format("% - 20s Điểm: %d",name, nPoint));
	end
end

XoyoChallenge:LoadFile();
XoyoChallenge:InitCardStorage();


if MODULE_GAMECLIENT then
	XoyoChallenge:InitXoyoluTips();
end

if (MODULE_GC_SERVER) then
	
function XoyoChallenge:RefreshXoyoLadderGC()
	local nCurWeight = self.__tbRange[3];
	local nPreWeight = KGblTask.SCGetDbTaskInt(DBTASK_XOYOGAME_WEIGHT);
	if nCurWeight == nPreWeight then
		return;
	end
	if nPreWeight == 0 then
		KGblTask.SCSetDbTaskInt(DBTASK_XOYOGAME_WEIGHT, nCurWeight);
		return;
	end 		
	local tbRange = {};
	tbRange[1] = self.__tbRange[1]; 
	tbRange[2] = self.__tbRange[2];
	tbRange[3] = nPreWeight;
	local nType = 0;
	local tbLadderCfg = Ladder.tbLadderConfig[PlayerHonor.HONOR_CLASS_XOYOGAME];
	nType = Ladder:GetType(0, tbLadderCfg.nLadderClass, tbLadderCfg.nLadderType, tbLadderCfg.nLadderSmall);
	local tbShowLadder= GetTotalLadder(nType) or {};
	local nValue = 0;
	local nPrePoint = 0;
	local tbRes = nil;
	local nNewPoint = 0;
	for _,tbPlayerList in ipairs(tbShowLadder) do 
		nPrePoint = tbPlayerList["dwValue"];
		if nPrePoint > 0 then
			tbRes = self:UnpackNumber(tbRange, nPrePoint);			
			nNewPoint = self:PackNumber(self.__tbRange, tbRes);
			if nNewPoint > 0 then	
				PlayerHonor:SetPlayerXoyoPointsByName(tbPlayerList["szPlayerName"], nNewPoint);
			end
		end
	end
	PlayerHonor:UpdateXoyoLadder(0);
	KGblTask.SCSetDbTaskInt(DBTASK_XOYOGAME_WEIGHT, nCurWeight);
end

GCEvent:RegisterGCServerStartFunc(XoyoGame.XoyoChallenge.RefreshXoyoLadderGC, XoyoGame.XoyoChallenge);
end

if MODULE_GAMESERVER then
	
function XoyoChallenge:RefreshPlayerValue()
	local nPrevPoint = GetXoyoPointsByName(me.szName);
	local nPrevCardNum = self:Point2CardNum(nPrevPoint);
	local nCurrCardNum = self:GetGatheredCardNum(me);
	if nCurrCardNum == nPrevCardNum then
		return;
	end	
	local nCurrYearMonth = tonumber(GetLocalDate("%Y%m"));		
	local nGetXoyoluMonth = me.GetTask(self.TASKGID, self.TASK_GET_XOYOLU_MONTH);	
	if nCurrYearMonth ~= nGetXoyoluMonth then 
		return;
	end	
	local nValue = self:GetTotalPoint(me);
	if 0 == nValue then 
		return;
	end
	PlayerHonor:SetPlayerXoyoPointsByName(me.szName, nValue);
end

PlayerEvent:RegisterOnLoginEvent(XoyoChallenge.RefreshPlayerValue, XoyoChallenge);
PlayerEvent:RegisterOnLoginEvent(XoyoChallenge.GetAwardRemind, XoyoChallenge);
end
