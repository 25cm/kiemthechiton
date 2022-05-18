-- ��ң����ս
XoyoGame.XoyoChallenge = XoyoGame.XoyoChallenge or {};
local XoyoChallenge = XoyoGame.XoyoChallenge;

-- NpcId�����������б�
--            ��ֵ�����                                    ������������ĸ���
-- npcId --> {"nDropRate","tbCardGDPL", "id", "szCardGDPL", "nProbability"}
XoyoChallenge.tbNpcId2Data = {};
XoyoChallenge.tbNpcId2Data_id = {}; -- ������tbNpcId2Dataһ��������ÿ�п�ͷ��id������

-- ��ƷGDPL�����������б�
-- "g,d,p,l" --> {"nNeededNum", "tbItemGDPL", "tbCardGDPL", "id", "szCardGDPL", "nProbability"}
XoyoChallenge.tbItem2Data = {};
XoyoChallenge.tbItem2Data_id = {}; -- ������tbItem2Dataһ��������ÿ�п�ͷ��id������

-- �����������������б�
-- nRoomId --> {"tbCardGDPL", "id", "nDropRate", "szCardGDPL", "nProbability"}
XoyoChallenge.tbRoom2Data = {};
XoyoChallenge.tbRoom2Data_id = {}; -- ������tbRoom2Dataһ��������ÿ�п�ͷ��id������

-- ������������Ƭ�������ĸ��ط�
--                  [1]    [2]    [3]    [4]
-- "g,d,p,l" --> {nTaskId, nBit, nIndex, nId, 
-- szDesc, tbCardGDPL}
XoyoChallenge.tbCardStorage = {};
-- {self.nProbabilitySum, v.tbCardStorage}
XoyoChallenge.tbCardStorage_probability = {};

-- �ѿ�Ƭ�ռ������������������У�һλ��ʾһ�ſ�Ƭ
-- �ɵ�1λ��ʼ��һ��������������������һ��
XoyoChallenge.TASKGID = 2050;
XoyoChallenge.TASK_NPC_BEGIN = 20; -- npc�����ã�ÿ��2λ��1��ʾ���ռ���Ƭ��2��ʾ��ʹ�ÿ�Ƭ
XoyoChallenge.TASK_ITEM_BEGIN = 24; -- �ռ���Ʒ��
XoyoChallenge.TASK_ROOM_BEGIN = 28; -- ��������
XoyoChallenge.TASK_END = 32; -- �����ʹ��
XoyoChallenge.TASK_GET_XOYOLU_MONTH = 41; -- ��¼�����ң¼������£���200903
XoyoChallenge.TASK_HANDUP_XOYOLU_MONTH = 42; -- �Ͻ������Ǹ�ʱ���õ���ң¼����200903
XoyoChallenge.TASK_SPECIAL_CARD_DATE = 43; -- ������⿨�����ڣ���20090312
XoyoChallenge.TASK_SPECIAL_CARD_NUM = 44; -- ����ɹ������⿨������
XoyoChallenge.TASK_GET_AWARD_MONTH = 45; -- �콱ʱ�䣬���������200906������ң¼�������¸����콱�󣬾ͻ�������������200906������ң¼���·ݣ�
XoyoChallenge.TASK_GET_AWARD_MONTH_COPY = 46; --7����ʱʹ���콱ʱ���������

XoyoChallenge.tbSpecialCard = {18,1,314,1}; -- ���⿨
XoyoChallenge.tbXoyolu = {18,1,318,1}; -- ��ң¼
XoyoChallenge.MAX_SPECIAL_CARD_NUM = 2; -- ÿ����໻�������⿨

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
	local tbId = Lib:SplitStr(tbRow[szKey], "|"); -- ROOM_ID����NPC_ID
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

XoyoChallenge.nCardNum = 0; -- ��Ƭ����
XoyoChallenge.nProbabilitySum = 0; -- �����ܺ�
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
			
			assert(nTaskId < tbCtrl[i + 1][2], string.format("i:%d, id:%d", i, v.id)); -- ���ܳ��������������������(id̫��)
			
			if self.tbCardStorage[szKey] and
				not (self.tbCardStorage[szKey][3] == i and self.tbCardStorage[szKey][4] == v.id) then -- npc���ж��npcId��Ӧͬһ����Ƭ�����
					
				assert(false, string.format("prev i:%d, prev id:%d, curr i:%d, curr id:%d, gdpl:%s", 
					self.tbCardStorage[szKey][3], self.tbCardStorage[szKey][3], i, v.id, szKey)); -- ��Ƭgdpl�����ظ�
			end
			
			if not self.tbCardStorage[szKey] then
				self.nProbabilitySum = self.nProbabilitySum + v.nProbability;
				self.tbCardStorage[szKey] = {nTaskId, nBit, i, v.id}; -- i��v.id���ɸ��е�Ψһ��ʶ
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

-- ��ȡ��Ƭ�ռ�״�������ռ�����1��δ�ռ�����0
function XoyoChallenge:GetCardState(pPlayer, szCardGDPL)
	local info = self.tbCardStorage[szCardGDPL];
	assert(info, szCardGDPL);
	local nTask = info[1];
	local nBit = info[2];
	
	local nVal = pPlayer.GetTask(self.TASKGID, nTask);
	return Lib:LoadBits(nVal, nBit, nBit+1);
end

-- ���ÿ�Ƭ�ռ�״̬
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
	
	local nXoyoluTipsCol = 4; -- 4��
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

-- ��ȡ��ң¼tips
-- ����һ��string
function XoyoChallenge:GetXoyoluTips(pPlayer)
	local szTips = "";	
	szTips = "<color=green>���ռ���"..self:GetGatheredCardNum(pPlayer).."/"..self:GetTotalCardNum().."���ſ�Ƭ<color>\n\n";
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

-- �ɷ���Ʒ����Ƭ
-- return 1 or 0, szMsg
function XoyoChallenge:CanHandUpItemForCard(pPlayer)
	local nRes, szMsg = self:GetXoyoluState(pPlayer, tonumber(GetLocalDate("%Y%m")));
	if nRes == 0 then
		return 0, szMsg;
	end
	return 1;
end


-- �ɷ��ȡ���⿨
-- tbItemsΪDialog:OpenGift���صĶ����
-- return 1 or 0, szMsg
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
		return 0, string.format("������Ѿ���%d�ſ��ˣ����������ɡ�", nCardNum);
	end
	
	if pPlayer.CountFreeBagCell() < self.MAX_SPECIAL_CARD_NUM then
		return 0, string.format("�����ռ䲻�㡣��ճ�%d��������ȡ��", self.MAX_SPECIAL_CARD_NUM);
	end
	
	return 1;
end

-- ���Ի�ȡ���⿨
-- tbItemsΪDialog:OpenGift���صĶ����
-- return 1 or 0, szMsg
function XoyoChallenge:GetSpecialCard(pPlayer, tbItems)
	local nToday = tonumber(GetLocalDate("%Y%m%d"));
	local nRes, szMsg = self:CanGetSpecialCard(pPlayer, nToday);
	if nRes == 0 then
		return nRes, szMsg;
	end
	
	local nCardNum = pPlayer.GetTask(self.TASKGID, self.TASK_SPECIAL_CARD_NUM);
	local tbXoyoItem = {}; -- ��ң�ȳ�Ʒ��
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

-- �Ͻ���Ʒ��ÿ�Ƭ�������ܶ��ƥ��
-- ����õ���Ƭ�Ļ�������Ӧ��¼
-- tbItemsΪDialog:OpenGift���صĶ����
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
					return 0, "�����ռ䲻�㡣";
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
		szMsg = "��һЩ��Ƭ���Ѿ��ռ���������ؾ��Ȳ��ٸ����ˡ�";
	end
	return 1, szMsg;
end

-- ��ȡ��Ƭ����Ʒ����Ϣ
function XoyoChallenge:ItemForCardDesc()
	
	local szDesc = ""
	for _, v in ipairs(self.tbItem2Data_id) do
		local szItemName = string.format("%-8s",KItem.GetNameById(unpack(v.tbItemGDPL)));
		local szCardName = KItem.GetNameById(unpack(v.tbCardGDPL));
		szDesc = szDesc .. string.format("%s%s<enter>", szItemName .. " x " .. tostring(v.nNeededNum) .. ":", szCardName);
	end
	return szDesc;
end

-- ��tbItem��nNeededNum�����ĵ���ɾ����
-- �����˿ɵ��ӵ��ߵ����
-- �����Ҫ��֤tbItem�е��������㹻��
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

-- ɱ��npc����Ա��Ƭ
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

-- �������ÿ�Ƭ
-- ����õ���Ƭ�Ļ�������Ӧ��¼������1
-- �ò�����Ƭ�ͷ���0
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

-- �ұ����ʹ����俴����û���������
function XoyoChallenge:HasItem(pPlayer, tbGDPL)
	local tb1 = pPlayer.FindItemInRepository(unpack(tbGDPL)); 
	local tb2 = pPlayer.FindItemInBags(unpack(tbGDPL));
	if not tb1[1] and not tb2[1] then
		return 0;
	else
		return 1;
	end
end

-- ��ȡ�����ң¼״̬
-- ���ﶼû�еĻ�����0, szMsg
-- �еĻ�����1
function XoyoChallenge:GetXoyoluState(pPlayer, nCurrYearMonth)
	if not nCurrYearMonth then
		nCurrYearMonth = tonumber(GetLocalDate("%Y%m"));
	end
	
	local nGetXoyoluMonth = pPlayer.GetTask(self.TASKGID, self.TASK_GET_XOYOLU_MONTH);
	--local nHandUpXoyoluMonth = pPlayer.GetTask(self.TASKGID, self.TASK_HANDUP_XOYOLU_MONTH);
	
	if nGetXoyoluMonth < nCurrYearMonth then
		return 0, "������»�û����ң¼����";
	end
	
	--if nHandUpXoyoluMonth == nGetXoyoluMonth then 
	--	return 0, self:MsgAlreadyHandUp(pPlayer);
	--end	
	
	return 1;
end

function XoyoChallenge:_Check(pPlayer, key, tb)
	local tbData = tb[key];
	if not tbData then
		return 0;
	end
	
	if self:HasItem(pPlayer, tbData.tbCardGDPL) == 1 then -- �������п�Ƭ
		return 0;
	end
	
	local nCurrYearMonth = tonumber(os.date("%Y%m", GetTime()));
	
	if self:GetXoyoluState(pPlayer, nCurrYearMonth) == 0 then -- û����ң¼
		return 0;
	end
		
	local nCardState = self:GetCardState(pPlayer, tbData.szCardGDPL);
	if nCardState == 2 then -- �Ѿ�������ң¼����ʹ�ã�
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
		pPlayer.SendMsgToFriend("���ĺ���["..pPlayer.szName.."]����ң¼�ռ������л��һ��" .. pItem.szName .. "��");
	end
	
	return 1;
end

-- �����Ƭ��¼
function XoyoChallenge:ClearCardRecord(pPlayer)
	for i = self.TASK_NPC_BEGIN, self.TASK_END - 1 do
		pPlayer.SetTask(self.TASKGID, i, 0);
	end
end

-- ���ȫ����¼
function XoyoChallenge:Clear(pPlayer)
	for task = self.TASK_NPC_BEGIN, self.TASK_GET_AWARD_MONTH do
		pPlayer.SetTask(self.TASKGID, task, 0);
	end
end

-- �ɷ��ȡ��ң¼
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
			return 0, "���ϸ��µĽ�����û��ȡ���Ȱѽ���������������ң¼�ɣ�";
		end
	else
		if nPrevGetMonth == nPrevMonth and nGetAwardMonth < nPrevMonth then
			return 0, "���ϸ��µĽ�����û��ȡ���Ȱѽ���������������ң¼�ɣ�";
		end
	end
	
	if nPrevGetMonth >= nCurrYearMonth then
		return 0, "������Ѿ�������һ���ˣ���С����Կ��Ǻõúܣ���������ҡ�";
	end
	
	if pPlayer.CountFreeBagCell() < 1 then
		return 0, "�����ռ䲻��,���һ��������ȡ��ң¼�ɣ�";
	end
	
	return 1;
end

-- ��ȡ��ң¼
-- return 1 or 0
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

-- ��������û����ң¼
function XoyoChallenge:HasXoyoluInBags(pPlayer)
	local tbFind = pPlayer.FindItemInBags(unpack(self.tbXoyolu));
	if not tbFind[1] then
		return 0;
	end
	return 1, tbFind[1].pItem;
end

-- �ɷ��Ͻ���ң¼
-- bDontCheckBag: ����鱳��
--function XoyoChallenge:CanHandUpXoyolu(pPlayer, bDontCheckBag)
--	local nCurrYearMonth = tonumber(os.date("%Y%m"));
--	local nPrevYearMonth = pPlayer.GetTask(self.TASKGID, self.TASK_HANDUP_XOYOLU_MONTH);
--	if nCurrYearMonth == nPrevYearMonth then
--		return 0, "��������Ѿ�������ң¼�����¸��������콱�ɣ�";
--	end
--	
--	if not bDontCheckBag then
--		local nRes, pItem = self:HasXoyoluInBags(pPlayer);
--		if  nRes == 0 then
--			return 0, "�����ϵ���ң¼��?";
--		end
--	end
--	
--	return 1;
--end


-- �Ͻ���ң¼
-- return 1, szMsg or 0, szMsg
--function XoyoChallenge:HandUpXoyolu(pPlayer, tbItems)
--	local pXoyolu;
--	
--	for _, tbItem in ipairs(tbItems) do
--		local pItem = tbItem[1];
--		if pItem.Equal(unpack(self.tbXoyolu)) == 1 then
--			pXoyolu = pItem;
--			break;
--		end
--	end
--	
--	if not pXoyolu then
--		return 0, "�����ң¼�أ�����ô����������";
--	end
--	
--	local nRes = self:CanHandUpXoyolu(pPlayer, 1);
--	if nRes == 0 then
--		return 0, szMsg;
--	end
--	
--	local nFinishedNum = 0; -- ����˼�������
--	local nTotalWeight = 0;
--	for k, v in pairs(self.tbCardStorage) do
--		if self:GetCardState(pPlayer, k) == 2 then
--			nFinishedNum = nFinishedNum + 1;
--			nTotalWeight = nTotalWeight + v.nWeight;
--		end
--	end
--	
--	local nPoints = nFinishedNum * 10000 + nTotalWeight;
--	
--	if nPoints == 0 then
--		return 0, "��һ�ſ�Ƭ��û�ռ�����Ҫ������ң¼��������";
--	end
--	
--	PlayerHonor:SetPlayerXoyoPointsByName(pPlayer.szName, nPoints);
--	
--	pXoyolu.Delete(pPlayer);
--	self:ClearCardRecord(pPlayer);
--	local nGetXoyoluMonth = pPlayer.GetTask(self.TASKGID, self.TASK_GET_XOYOLU_MONTH);
--	pPlayer.SetTask(self.TASKGID, self.TASK_HANDUP_XOYOLU_MONTH, nGetXoyoluMonth);
--	
--	Dbg:WriteLog("XoyoChallenge:HandUpXoyolu", "points:" .. tostring(nPoints) .. "player:" .. pPlayer.szName);
--	
--	return 1, string.format("������½���������ң¼�ﹲ�ռ���<color=green>%d/%d<color>�ſ�Ƭ����С���Ѿ��������ˣ����¸���1�����������������콱�ɡ�",
--		nFinishedNum, self.nCardNum);
--	
--	-- GC GSͬ����Ҫʱ�䣬���ܵ�MsgAlreadyHandUp
--	--return 1, self:MsgAlreadyHandUp(pPlayer); 
--end

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

-- ��ȡ��ǰ���������¼���ܷ�
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

-- ��ȡ���а�����
function XoyoChallenge:GetLadderDesc(nPoints)
	local tbData = self:UnpackNumber(self.__tbRange, nPoints);
	local nCardNum = tbData[3];
	local nLastUseCardDate = tbData[1]
	local tbTime = os.date("*t", GetTime());
	local nMonth = tbTime.month
	if tbTime.day == 1 then -- 1�ſ����Ļ����ϸ��µ�����
		if nMonth == 1 then
			nMonth = 12;
		else
			nMonth = nMonth - 1;
		end
	end
	local nDay = math.floor((self.MINUTE_OF_MONTH - nLastUseCardDate)/1440);
	local nHour = math.floor((self.MINUTE_OF_MONTH -nLastUseCardDate - nDay*1440)/60);
	local nMin = self.MINUTE_OF_MONTH - nLastUseCardDate - nDay*1440 - nHour*60;
	local szContext = string.format("%d��\n���Ƭʹ��ʱ�䣺%d��%d�� %.2d:%.2d", nCardNum, nMonth, nDay, nHour, nMin);
	local szTxt1 = string.format("%d��", nCardNum);
	return szContext, szTxt1;
end

-- ���а����ת��Ϊ��Ƭ��
function XoyoChallenge:Point2CardNum(nPoints)
	return self:UnpackNumber(self.__tbRange, nPoints)[3];
end


-- ʹ�ÿ�Ƭ
-- return 1, or 0, szMsg
function XoyoChallenge:UseCard(pPlayer, pCard)
	if self:HasXoyoluInBags(pPlayer) == 0 then
		return 0, "������û����ң¼������ʹ�ÿ�Ƭ���쵽��ң�������Ƕ���һ���ɡ�";
	end
	
	if self:GetCardState(pPlayer, pCard.SzGDPL()) == 2 then
		return 0, "�㱾���Ѿ��ռ������ſ�Ƭ�ˡ�";
	end
	
	self:SetCardState(pPlayer, pCard.SzGDPL(), 2);
	pCard.Delete(pPlayer);
	
	local nPrevPoint = GetXoyoPointsByName(pPlayer.szName); -- ����µĵ���
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
			return 0, "��������Ѿ�������ˣ�������Ʊ�С�㡣";
		end
	else
		if nLastGetAwardMonth >= nPrevMonth then
			return 0, "��������Ѿ�������ˣ�������Ʊ�С�㡣";
		end
	end
	
	if nPrevMonth > nGetXoyoluMonth then -- �ܾ�ǰ�����ң¼
		return 0, "���ϸ���û����ң¼������Ҫ������";
	end
	
	if nYearMonth == nGetXoyoluMonth then -- ���������ң¼����δ����
		return 0, "�������������ң¼���¸��������콱�ɡ�";
	end
	
	if KGblTask.SCGetDbTaskInt(DBTASK_XOYO_FINAL_LADDER_MONTH) ~= nYearMonth then
		return 0, "�ϸ���������û�����ء�";
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

-- ������
-- return 1, or 0, szMsg
function XoyoChallenge:GetAward(pPlayer)
	local nRes, var, nPrevMonth = self:CanGetAward(pPlayer);
	if nRes == 0 then
		return nRes, var;
	end
	
	local nYearMonth = var;
	local nRank = GetXoyoPointsRank(pPlayer.szName);
	local nLastMonthPoint = GetXoyoLastPointsByName(pPlayer.szName); -- �ϸ��µĵ���
	local nCardNum = self:Point2CardNum(nLastMonthPoint);
	
	if (not ((0 <nRank and nRank < 3001) or nCardNum>=24 )) or -- ���һ���������Ų������Σ����ռ���24+�ſ�
		(nYearMonth <= 200909 and self:GetGatheredCardNum(pPlayer) <= 0) -- �ϸ��¿�Ƭ��Ϊ0
	then 
		--SetXoyoPointsRank(pPlayer.szName, 0);
		pPlayer.SetTask(self.TASKGID, self.TASK_GET_AWARD_MONTH, nPrevMonth);
		pPlayer.SetTask(self.TASKGID, self.TASK_GET_AWARD_MONTH_COPY, nPrevMonth);
		
		local szLog = string.format("�������%s �޽����� ����: %d, ����: %d, ��Ƭ�ռ���:% d", 
			pPlayer.szName, nRank, nLastMonthPoint, nCardNum);
		Dbg:WriteLog("XoyoChallenge:GetAward", szLog);
		pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "��ң����ս�콱��" .. szLog);
		
		return 0, "������û����Ľ�����¼�������Ŭ���ɡ�";
	end
	
	local tbFinishAward = {
		--��½,����,ʢ��
		[1]=
		{
			[1] = {tbItem={18,1,114,10}, nCount=1, nTime=43200},--1-10
			[2] = {tbItem={18,1,114,9},	 nCount=2, nTime=43200},--11-100
			[3] = {tbItem={18,1,114,9},  nCount=1, nTime=43200},--101-500
			[4] = {tbItem={18,1,114,8},  nCount=2, nTime=43200},--501-1500
			[5] = {tbItem={18,1,114,8},  nCount=1, nTime=43200},--1501-3000��24�ſ�
		}, 
		--Խ�ϰ�
		[2]=
		{
			[1] = {tbItem={18,1,460,2},  nCount=5, nTime=43200},--1-10
			[2] = {tbItem={18,1,460,2},	 nCount=3, nTime=43200},--11-100
			[3] = {tbItem={18,1,460,2},  nCount=2, nTime=43200},--101-500
			[4] = {tbItem={18,1,460,2},  nCount=1, nTime=43200},--501-1500
			[5] = {tbItem={18,1,460,1},  nCount=2, nTime=43200},--1501-3000��24�ſ�
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
		return 0, string.format("����ñ��������콱�ɡ�<color=red>����Ҫ%s�񱳰��ռ䡣��<color>", tbGiveAward.nCount);
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
	pPlayer.SetTask(self.TASKGID, self.TASK_GET_AWARD_MONTH, nPrevMonth); -- ��ȡ�����Ǹ��µĽ���
	pPlayer.SetTask(self.TASKGID, self.TASK_GET_AWARD_MONTH_COPY, nPrevMonth);
	
	--log
	local szLog = string.format("�������%s ����: %s, ����: %d, ����: %d ��Ƭ�ռ���: %d", 
		pPlayer.szName, szItemName, nRank, nLastMonthPoint, nCardNum);
	Dbg:WriteLog("XoyoChallenge:GetAward", szLog);
	pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "��ң����ս�콱��" .. szLog);
	
	-- msg
	if 1 <= nRank and nRank <= 100 then
		pPlayer.SendMsgToFriend(string.format("���ĺ���[%s]���ϸ��µ���ң¼�ռ�������������%dλ�����%d��%s������",
			pPlayer.szName, nRank, nAddCount, szItemName));
	end
	
	local szMsg;
	if nRank > 0 then
		szMsg = string.format("��ϲ�����ϸ��µ���ң¼�ռ������õ�%d����", nRank);
	else
		szMsg = string.format("�����ϸ��µ���ң¼�ռ��������ռ���%d�ſ�Ƭ���ɵò������", nCardNum);
	end
		
	return 1, szMsg;
end

-- ���һ����Ƭ
-- return tbCardGDPL
function XoyoChallenge:GetRandomCard()
	local nRand = MathRandom(1, self.nProbabilitySum);
	local tbCardGDPL;
	for _, v in pairs(self.tbCardStorage_probability) do
		tbCardGDPL = v[2]; -- ��֤������Чֵ
		if nRand <= v[1] then
			break;
		end
	end
	return tbCardGDPL;
end

-- ��ȡ���Ͻ���Ƭ��
function XoyoChallenge:GetGatheredCardNum(pPlayer)
	local nFinishedNum = 0;
	for k, _ in pairs(self.tbCardStorage) do
		if self:GetCardState(pPlayer, k) == 2 then
			nFinishedNum = nFinishedNum + 1;
		end
	end
	return nFinishedNum;
end

--function XoyoChallenge:MsgAlreadyHandUp(pPlayer)
--	local nPoint = GetXoyoPointsByName(pPlayer.szName); -- ����µĵ���
--	return string.format("������½���������ң¼��һ���ռ���<color=green>%d/%d<color>�ſ�Ƭ����С���Ѿ��������ˣ����¸���1�����������������콱�ɡ�",
--		math.floor(nPoint / 10000), self.nCardNum);
--end

-- ��ȡ��Ƭ����
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
			me.Msg("��������ң¼�ռ�������δ��ȡ���뵽��ң��������ƴ���ȡ����");
		end
	else
		if nPrevGetMonth == nPrevMonth and nGetAwardMonth < nPrevMonth and
			KGblTask.SCGetDbTaskInt(DBTASK_XOYO_FINAL_LADDER_MONTH) == nYearMonth
		then
			me.Msg("��������ң¼�ռ�������δ��ȡ���뵽��ң��������ƴ���ȡ����");
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
		me.Msg(string.format("%-20s������%d",name, nPoint));
	end
end

XoyoChallenge:LoadFile();
XoyoChallenge:InitCardStorage();


if MODULE_GAMECLIENT then
	XoyoChallenge:InitXoyoluTips();
end

-- ?pl DoScript("\\script\\mission\\xoyogame\\xoyogame_task.lua")

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
