--
-- ң NPC߼

XoyoGame.TASK_GROUP_MEDICINE = 2050;
XoyoGame.TASK_GET_MEDICINE_TIME = 53;

function XoyoGame:CanGetMedicine()
	if SpecialEvent:IsWellfareStarted() ~= 1 then
		return 0, "Tính năng này vẫn chưa mở.";
	end
	
	if me.nLevel < 100 then
		return 0, "Bạn phải đạt cấp 100 mới có thể nhận dược phẩm Tiêu Dao Cốc.";
	end
	
	local nTime = tonumber(os.date("%Y%m%d", GetTime()));
	local nLastTime = me.GetTask(self.TASK_GROUP_MEDICINE, self.TASK_GET_MEDICINE_TIME);
	if nTime == nLastTime then
		return 0, "Hôm nay ngươi đã nhận, mai hãy quay lại.";
	end
	
	if me.CountFreeBagCell() < 1 then
		return 0, "Túi đã đầy, chừa 1 ô trống mới có thể nhận.";
	end
	
	return 1;
end

function XoyoGame:GetMedicine()
	local nRes, szMsg = self:CanGetMedicine();
	if nRes == 0 then
		Dialog:Say(szMsg);
		return;
	end
	
	local tbOpt = {
		{"Hồi Huyết Đơn-Rương", XoyoGame.GetMedicine2, XoyoGame, 1},
		{"Hồi Nội Đơn-Rương", XoyoGame.GetMedicine2, XoyoGame, 2},
		{"Càn Khôn Tạo Hóa Hoàn-Rương", XoyoGame.GetMedicine2, XoyoGame, 3},
		{"Ta chỉ đến xem"},
		};
	Dialog:Say("Ngươi muốn nhận loại nào?", tbOpt);
end

XoyoGame.tbFreeMedicine = {
	[80] = {
		[1] = {18,1,352,1},
		[2] = {18,1,353,1},
		[3] = {18,1,354,1},
		},
	[90] = {
		[1] = {18,1,352,2},
		[2] = {18,1,353,2},
		[3] = {18,1,354,2},
		},
	[120] = {
		[1] = {18,1,352,3},
		[2] = {18,1,353,3},
		[3] = {18,1,354,3},
		},
	};

function XoyoGame:GetMedicine2(nType)
	local nRes, szMsg = self:CanGetMedicine();
	if nRes == 0 then
		Dialog:Say(szMsg);
		return;
	end
	
	local nLevel;
	if me.nLevel >= 120 then
		nLevel = 120;
	elseif me.nLevel >= 90 then
		nLevel = 90;
	elseif me.nLevel >= 80 then
		nLevel = 80
	end
	
	local pItem = me.AddItem(unpack(self.tbFreeMedicine[nLevel][nType]));
	me.SetItemTimeout(pItem, 24*60, 0)
	me.SetTask(self.TASK_GROUP_MEDICINE, self.TASK_GET_MEDICINE_TIME, tonumber(os.date("%Y%m%d", GetTime())));
	Dbg:WriteLog("XoyoGame", string.format("%s nhận được Dược Phẩm Tiêu Dao %s", me.szName, pItem.szName));
end

function XoyoGame:JieYinRen()
	Dialog:Say("Dạo này có rất nhiều người muốn đến Tiêu Dao Cốc, ngươi cũng vậy sao?",
		{
			{"Đưa ta đến cổng Tiêu Dao Cốc 1", self.ToBaoMingDian, self, 341},
			--{"Đưa ta đến cổng Tiêu Dao Cốc 2", self.ToBaoMingDian, self, 342},
			{"Ta chỉ ghé qua thôi"},
		})
end

function XoyoGame:ToBaoMingDian(nMapId)
	if me.nLevel < self.MIN_LEVEL then
		Dialog:Say("Công lực của ngươi quá thấp, hãy luyện lên cấp ");
		return 0;
	end
	if me.GetCamp() == 0 then
		Dialog:Say("Ngươi chưa vào phái, hãy gia nhập môn phái rồi đến tìm lão phu.");
		return 0;
	end
	me.NewWorld(nMapId, unpack(self.BAOMING_IN_POS))
end

function XoyoGame:ApplyJoinGame(nGameId)
	local nManagerId = him.nMapId
	if not self.tbManager[nManagerId] or not self.tbManager[nManagerId].tbData then
		return 0;
	end
	local nCurTime = tonumber(os.date("%H%M", GetTime()));
	if not self.__debug_test and (nCurTime < self.START_TIME1 or nCurTime >= self.END_TIME1) and
		(nCurTime < self.START_TIME2 or nCurTime >= self.END_TIME2) then
		Dialog:Say("Hãy đến gặp lão phu từ <color=yellow>9h đến 19h30 và 22h đến 24h<color> mỗi ngày!")
		return 0;
	end
	local tbOpt = {};
	if not nGameId then
		for i, nCurGameId in pairs(self.MANAGER_GROUP[nManagerId]) do
			if self.START_SWITCH[nCurGameId] == 1 then
				local szTeamCount = "(Chưa mở)"
				if self.tbManager[nManagerId].tbData[nCurGameId] then
					if self.tbManager[nManagerId].tbData[nCurGameId] < self.MAX_TEAM then
						szTeamCount = "(Đã có "..self.tbManager[nManagerId].tbData[nCurGameId].." đội vào cốc)"
					else
						szTeamCount = "(Đã đầy)";
					end
				end
				table.insert(tbOpt, {string.format("Đến Tiêu Dao Cốc %s%s", i, szTeamCount), self.ApplyJoinGame, self, nCurGameId})
			end
		end
		table.insert(tbOpt, {"Ta vẫn chưa chuẩn bị xong, sẽ quay lại sau"});
		Dialog:Say("  Trong cốc rất nguy hiểm, để cho an toàn, <color=green>mỗi người mỗi ngày chỉ được vào cốc tối đa %s lần, phải tạo thành nhóm ít nhất 1 người<color>, lão phu mới cho các ngươi vào. Lập đội xong, đội trưởng hãy đến chỗ ta báo danh. Mỗi ngày từ <color=yellow>9h đến 19h30 và 22h đến 24h<color>, lão phu sẽ dẫn các vị vào cốc lúc <color=green>sáng và tối<color>.", tbOpt);
	else
		if not self.tbManager[nManagerId].tbData[nGameId] then
			Dialog:Say("Tiêu Dao Cốc chưa mở");
			return 0;
		end
		if self.tbManager[nManagerId].tbData[nGameId] >= self.MAX_TEAM then
			Dialog:Say("Cốc đã đầy.");
			return 0;
		end
		local nTeamId = me.nTeamId;
		if nTeamId == 0 then
			Dialog:Say("Ít nhất phải có 1 người, mau đi tìm đủ rồi quay lại đây.")
			return 0;
		end
		local tbMember, nMemberCount = KTeam.GetTeamMemberList(nTeamId);
		if not tbMember or nMemberCount < self.MIN_TEAM_PLAYERS then
			Dialog:Say("Ít nhất phải có 1 người, mau đi tìm đủ rồi quay lại đây.")
			return 0;
		end
		if me.nId ~= tbMember[1] then
			Dialog:Say("Hãy bảo đội trưởng đến gặp ta!")
			return 0;
		end
		for i = 1, #tbMember do
			local nRet = self:CheckPlayer(tbMember[i], nManagerId);
			if nRet ~= 1 then
				return 0;
			end
		end
		if self.tbManager[nManagerId].tbData[nGameId] >= self.MAX_TEAM then
			Dialog:Say("Đội ngũ đợi trước Tiêu Dao Cốc đã đầy");
			return 0;
		end
		self.tbManager[nManagerId].tbData[nGameId] = self.tbManager[nManagerId].tbData[nGameId] + 1;
		
		--LOGͳ
		if XoyoGame.LOG_ATTEND_OPEN == 1 then
			local szName = "";
			for i = 1, #tbMember do
				local pPlayer = KPlayer.GetPlayerObjById(tbMember[i]);	
				if pPlayer then
					szName = szName.."  "..pPlayer.szName;
				end
			end
			Dbg:WriteLog("xoyogame", "attend Người chơi:"..szName, " ghi danh vào thung lũng hạnh phúc.");
		end	
		
		
		for i = 1, #tbMember do
			local pPlayer = KPlayer.GetPlayerObjById(tbMember[i]);
			
			if XoyoGame.XoyoChallenge:GetXoyoluState(pPlayer) == 0 then
				local nRes, szMsg = XoyoGame.XoyoChallenge:GetXoyolu(pPlayer);
				if szMsg then
					pPlayer.Msg(szMsg);
				end
			end
			
			pPlayer.NewWorld(XoyoGame.MAP_GROUP[nGameId][1], unpack(self.GAME_IN_POS));
		end
	end
end

function XoyoGame:CheckPlayer(nPlayerId, nMapId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer or pPlayer.nMapId ~= nMapId then
		Dialog:Say("Trong đội các ngươi có người không ở gần đây, không vào cốc được!");
		return 0;
	end
	if pPlayer.nLevel < self.MIN_LEVEL then
		Dialog:Say("Có người chưa đủ thực lực! Hãy luyện đến cấp "..self.MIN_LEVEL.." rồi quay lại đây!");
		return 0;
	end
	if pPlayer.GetCamp() == 0 then
		Dialog:Say("Có người chưa vào phái, hãy gia nhập môn phái rồi đến tìm ta");
		return 0;
	end
	if self:GetPlayerTimes(pPlayer) <= 0 then
		Dialog:Say(string.format("Nè! Nè! <color=red>%s<color>, hôm nay ngươi không thể vào Cốc nữa, muốn vào thì đợi ngày mai đi!", pPlayer.szName));
		return 0;
	end
	return 1;
end

function XoyoGame:GetPlayerTimes(pPlayer)
	return self:AddPlayerTimes(pPlayer)
end

function XoyoGame:AddPlayerTimes(pPlayer)
	if pPlayer.nLevel < self.MIN_LEVEL then
		return 0;
	end
	local nCurTime = GetTime()
	local nCurDay = Lib:GetLocalDay(nCurTime);
	local nTimes = pPlayer.GetTask(self.TASK_GROUP, self.TIMES_ID);
	local nAddDay	= pPlayer.GetTask(self.TASK_GROUP, self.ADDTIMES_TIME);
	if nAddDay == 0 then
		nTimes = self.TIMES_PER_DAY;
		pPlayer.SetTask(self.TASK_GROUP, self.TIMES_ID, nTimes);
		pPlayer.SetTask(self.TASK_GROUP, self.ADDTIMES_TIME, nCurDay);
		return nTimes;
	end
	if nCurDay >= nAddDay then
		nTimes = nTimes + (nCurDay - nAddDay) * self.TIMES_PER_DAY;
		-- TODO: ԺҪɾ -------------------------------
		local nXiuFuNum = (nCurDay - 14333) * self.TIMES_PER_DAY; -- 14334 1970.1.1  2009.3.30 
		if nXiuFuNum < nTimes then
			nTimes = nXiuFuNum;
		end
		-- TODOEND --------------------------------------
		if nTimes >= self.MAX_TIMES then
			nTimes = self.MAX_TIMES
		end
		pPlayer.SetTask(self.TASK_GROUP, self.TIMES_ID, nTimes);
		pPlayer.SetTask(self.TASK_GROUP, self.ADDTIMES_TIME, nCurDay);
	end
	return nTimes;
end

function XoyoGame:AddPlayerTimesOnLogin()
	self:AddPlayerTimes(me)
end
PlayerEvent:RegisterOnLoginEvent(XoyoGame.AddPlayerTimesOnLogin, XoyoGame)

------------------------------------------------------------------------------------------------------------------
--  콱
XoyoGame.tbGift = Gift:New();

local tbGift = XoyoGame.tbGift;
tbGift.ITEM_CALSS = "xoyoitem"

function tbGift:OnOK(tbParam)
	local pItem = self:First();
	local tbItem = {};
	if not pItem then
		return 0;
	end
	while pItem do
		if pItem.szClass == self.ITEM_CALSS then
			table.insert(tbItem, pItem);
		end
		pItem = self:Next();
	end
	
	local nTimes = me.GetTask(XoyoGame.TASK_GROUP, XoyoGame.REPUTE_TIMES);
	local nDate = me.GetTask(XoyoGame.TASK_GROUP, XoyoGame.CUR_REPUTE_DATE);
	local nCurDate = tonumber(os.date("%Y%m%d",GetTime()));
	if nDate ~= nCurDate then
		nTimes = 0;
		me.SetTask(XoyoGame.TASK_GROUP, XoyoGame.CUR_REPUTE_DATE, nCurDate)
		me.SetTask(XoyoGame.TASK_GROUP, XoyoGame.REPUTE_TIMES, nTimes);
	end
	if nTimes >= XoyoGame.MAX_REPUTE_TIMES then
		Dialog:Say("Hôm nay ngươi đã đưa cho ta <color=red>"..XoyoGame.MAX_REPUTE_TIMES.."<color> bảo bối rồi, ngày mai hãy đến gặp ta!")
		return 0;
	end

	local nLevel		= me.GetReputeLevel(XoyoGame.REPUTE_CAMP, XoyoGame.REPUTE_CLASS);
	if (not nLevel) then
		print("AddRepute Repute is error ", me.szName, nClass, nCampId);
		return 0;
	else
		if (1 == me.CheckLevelLimit(XoyoGame.REPUTE_CAMP, XoyoGame.REPUTE_CLASS)) then
			me.Msg("Ngươi đã đưa ta đủ số bảo bối rồi, ta không cần nữa!");
			return 0;
		end
	end	
	
	local nRet = 0; 
	for _, pDelItem in ipairs(tbItem) do
		local nCount = pDelItem.nCount;
		if nTimes + nRet + nCount > XoyoGame.MAX_REPUTE_TIMES then	-- ɵ߳
			local nRemain = nCount - (XoyoGame.MAX_REPUTE_TIMES - nTimes - nRet)
			if nRemain > 0 and nRemain <= nCount and pDelItem.SetCount(nRemain) == 1 then
				nRet = XoyoGame.MAX_REPUTE_TIMES - nTimes;
			end
		elseif me.DelItem(pDelItem) == 1 then
			nRet = nRet + nCount;
		end
		if nTimes + nRet >= XoyoGame.MAX_REPUTE_TIMES then
			break;
		end
	end
	if nRet == 0 then
		Dialog:Say("Ngươi đừng nghĩ là sẽ lừa được ta với món đồ vớ vẩn này!");
		return 0;
	end
	
	me.AddRepute(XoyoGame.REPUTE_CAMP, XoyoGame.REPUTE_CLASS, nRet * XoyoGame.REPUTE_VALUE);
	me.SetTask(XoyoGame.TASK_GROUP, XoyoGame.REPUTE_TIMES, nTimes + nRet);
	Dialog:Say("Hay lắm! Chính là món ta cần!");
end

function tbGift:OnUpdate()
	self._szTitle = "Giao nộp bảo vật";
	local nTimes = me.GetTask(XoyoGame.TASK_GROUP, XoyoGame.REPUTE_TIMES);
	local nDate = me.GetTask(XoyoGame.TASK_GROUP, XoyoGame.CUR_REPUTE_DATE);
	local nCurDate = tonumber(os.date("%Y%m%d",GetTime()));
	if nDate ~= nCurDate then
		nTimes = 0;
	end
	self._szContent = "Mỗi ngày có thể giao tối đa "..XoyoGame.MAX_REPUTE_TIMES.." vật phẩm\nHôm nay đã giao <color=green> "..nTimes.."<color> "
	return 0;
end

-- ?pl DoScript("\\script\\mission\\xoyogame\\xoyogame_npc.lua")
