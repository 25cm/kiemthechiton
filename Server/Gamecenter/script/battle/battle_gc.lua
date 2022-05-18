-- 战役

if not MODULE_GC_SERVER then
	return;
end	

Battle.DBKEY_BATTLE			=	"BATTLE_%d_%d";		-- 战役信息的数据库KEY
Battle.tbCurRoundDataAll	=	{};					-- 各战役当前进行的战局信息
Battle.RANKTYPE				= 2;
Battle.RANKLISTNAME			= "SongJinBattle";
Battle.ITOR					= 1;
Battle.RANKMEMBERTASK		= 1;
Battle.tbMapInfo			= {};


function Battle:_LoadMapInfo()
	local tbMapInfo = {};
	local tbData		= Lib:LoadTabFile("\\setting\\battle\\songjin\\battlemap.txt");
	for _, tbRow in ipairs(tbData) do
		local nBattleLevel	= tonumber(tbRow.BATTLE_LEVEL);
		local tbBattle		= tbMapInfo[nBattleLevel];
		if (not tbBattle) then
			tbBattle	= {};
			tbMapInfo[nBattleLevel]	= tbBattle;
		end
		local tbMapId = {};
		for i=1, 3 do
			local nMapid = tonumber(tbRow["WORLD_MAP_ID" .. i]);
			if (nMapid) then
				tbMapId[#tbMapId + 1] = nMapid;
			end
		end
		local tbMapName = {};
		for i=1, 2 do
			local szMapName = tostring(tbRow["BATTLE_MAP_NAME" .. i]);
			if (szMapName and string.len(szMapName) > 0) then
				tbMapName[#tbMapName + 1] = szMapName;	
			end
		end
		local tbMapRule = {};
		for i=1, 3 do
			local nMapRule = tonumber(tbRow["BATTLE_RULE" .. i]);
			if (nMapRule) then
				tbMapRule[#tbMapRule + 1] = nMapRule;
			end
		end
		
		local nMapNpcNumType = tonumber(tbRow.NPC_NUM_TYPE) or 1;
		
		local tbBattleInfo = {};
		tbBattleInfo.tbMapId	= tbMapId;
		tbBattleInfo.tbMapName	= tbMapName;
		tbBattleInfo.tbMapRule	= tbMapRule;
		tbBattleInfo.nMapNpcNumType = nMapNpcNumType;
		tbBattle[#tbBattle + 1]	= tbBattleInfo;
		
	end
	self.tbMapInfo = tbMapInfo;
end

-- 战局启动
function Battle:RoundStart_GC(dwBattleId, dwBattleLevel, nSeqNum)
	-- 通知GameServer执行战局启动操作
	if (not self.tbMapInfo[dwBattleLevel]) then
		Battle:DbgOut_GC("ScheduleSongJin", "Không có thông tin cấp độ bản đồ này");
		return;
	end
	local nBattleChoose = MathRandom(#self.tbMapInfo[dwBattleLevel]);
	local tbBattleInfo = self.tbMapInfo[dwBattleLevel][nBattleChoose];
	if (not tbBattleInfo) then
		Battle:DbgOut_GC("ScheduleSongJin", "Không có thông tin bản đồ này");
		return;
	end
	local tbWorldMapId	= tbBattleInfo.tbMapId;
	local szMapName		= tbBattleInfo.tbMapName[MathRandom(#tbBattleInfo.tbMapName)];
	local dwRuleType	= tbBattleInfo.tbMapRule[MathRandom(#tbBattleInfo.tbMapRule)];
	local nMapNpcNumType = tbBattleInfo.nMapNpcNumType or 1;
	GlobalExcute{"Battle:RoundStart_GS", dwBattleId, dwBattleLevel, tbWorldMapId, szMapName, dwRuleType, nMapNpcNumType, nSeqNum};
	-- 显示战局启动提示
	self:_MsgNewRound(dwBattleLevel, szMapName);
end

-- 战局结束
function Battle:RoundEnd_GC(dwBattleId, dwBattleLevel, dwBattleResult, tbPlayerList)
	if (tbPlayerList) then
--		self:_UpdateGongXunRank(tbPlayerList);
	end
	self:_MsgRoundResult(dwBattleLevel);
end

-- 开启gamecenter时获取排行榜信息
--function Battle:OnUpDateRank_GC()
--	local nRemainTime = self:UpdateRank();
--	Timer:Register(nRemainTime * Env.GAME_FPS, Battle.UpdateRank, Battle);
--end

Battle._PlayerCmp	= function (tbPlayerA, tbPlayerB)
	return tbPlayerA.nGongXun > tbPlayerB.nGongXun;
end

function Battle:UpdateRank()
	print("UpdateRank Begin to Rank GongXun");

	local nNowTime = GetTime();
	if (not self.nLastUpdateTime) then
		self.nLastUpdateTime = 0;
	end
	self:GetGongXunRank();
	if (0 < self.nLastUpdateTime and self.nLastUpdateTime <= nNowTime) then
		local nNowWeek			= Lib:GetLocalWeek(nNowTime);
		local nLastWeek			= Lib:GetLocalWeek(nLastUpdateTime);	
		local nPassWeekCount	= nLastWeek - nNowWeek;

		for _, tbPlayer in pairs(self.tbGongXunRank) do
			local nLastWeekGongXu = tbPlayer.nGongXun;
			for i = 1, nPassWeekCount do
				if (0 >= nLastWeekGongXu) then
					break;
				end
				nLastWeekGongXu = math.floor(nLastWeekGongXu * 0.99);
			end
			tbPlayer.nGongXun = nLastWeekGongXu;
		end
	end
	
	Battle:DelRankMember();
	local tbPlayerRankList	= {};
	for _, tbPlayer in pairs(self.tbGongXunRank) do
		if (0 ~= tbPlayer.nGongXun) then
			tbPlayerRankList[#tbPlayerRankList + 1] = tbPlayer;
		end
	end

	table.sort(tbPlayerRankList, self._PlayerCmp);	
	print(string.format("UpdateRank tbPlayerRankList number is %d", #tbPlayerRankList));
	
	self.tbGongXunRank = nil;
	self.tbGongXunRank = {};
	for nKey, tbPlayer in ipairs(tbPlayerRankList) do
		tbPlayer.nRank = nKey;
		self.tbGongXunRank[tbPlayer.szName] = tbPlayer;
	end
	Battle:AddRankMember(self.tbGongXunRank);
	
	self.nLastUpdateTime = nNowTime;
	self:SendGongRankToGS();

	self:DbgOut_GC("UpdateRank", "self.tbGongXunRank", self.tbGongXunRank);
--	Ladder:SetGongXunLadder_GC(self.tbGongXunRank);
end

function Battle:SendGongRankToGS()
	GlobalExcute({"Battle:ReceiveGongRank_GS", self.tbGongXunRank});	
end

-- 更新gamecenter排行榜
function Battle:_UpdateGongXunRank(tbPlayerList)
	print("Đang xếp hạng danh sách chiến sự......");
	if (not self.tbGongXunRank) then
		self.tbGongXunRank = {};
	end
	if (not self.pRankList) then
		self:GetGongXunRank();
	end
	for _, tbPlayer in pairs(tbPlayerList) do
		local szName = tbPlayer.szName;
		if (not self.tbGongXunRank[szName]) then
			self.tbGongXunRank[szName] = {};
		end
		self.tbGongXunRank[szName].nGongXun = tbPlayer.nGongXun;
		self.tbGongXunRank[szName].szName	= szName;
	end
	Battle:DelRankMember();
	local tbPlayerRankList	= {};
	for _, tbPlayer in pairs(self.tbGongXunRank) do
		if (0 ~= tbPlayer.nGongXun) then
			tbPlayerRankList[#tbPlayerRankList + 1] = tbPlayer;
		end
	end
	table.sort(tbPlayerRankList, self._PlayerCmp);
	self.tbGongXunRank = nil;
	self.tbGongXunRank = {};
	for nKey, tbPlayer in ipairs(tbPlayerRankList) do
		tbPlayer.nRank = nKey;
		self.tbGongXunRank[tbPlayer.szName] = tbPlayer;
	end
	Battle:AddRankMember(self.tbGongXunRank);
	Battle:SendGongRankToGS();
	print("Bảng xếp hạng danh sách chiến sự hoàn thành......");
end

function Battle:GetGongXunRank()
	self.tbGongXunRank 	= {};
	self.pRankList		= KLeague.GetLeagueSetObject(Battle.RANKTYPE);
	assert(self.pRankList);
	local pBTRank 	= self.pRankList.FindLeague(Battle.RANKLISTNAME);
	if (not pBTRank) then
		self.pRankList.AddLeague(Battle.RANKLISTNAME);
		return self.tbGongXunRank;
	end
	Battle:GetRankMemeberValue();
end

-- 取排行榜数值
function Battle:GetRankMemeberValue()
	if (0 == KLeague.GetMemberSet(Battle.RANKTYPE, Battle.RANKLISTNAME, Battle.ITOR)) then
		return 0;
	end
	local szName 	= KLeague.GetCurMember(Battle.ITOR);
	local nValue	= 0;
	if (szName) then
		nValue = KLeague.GetLeagueMemberTask(Battle.RANKTYPE, Battle.RANKLISTNAME, szName, Battle.RANKMEMBERTASK);
		self.tbGongXunRank[szName] = {};
		self.tbGongXunRank[szName].nGongXun = nValue;
		self.tbGongXunRank[szName].szName = szName;
		while true do
			szName = KLeague.GetNextMember(Battle.ITOR);
			if (not szName) then
				break;
			end
			nValue = KLeague.GetLeagueMemberTask(Battle.RANKTYPE, Battle.RANKLISTNAME, szName, Battle.RANKMEMBERTASK);
			self.tbGongXunRank[szName] = {};
			self.tbGongXunRank[szName].nGongXun = nValue;
			self.tbGongXunRank[szName].szName = szName;
		end
	end
end

-- 增加成员
function Battle:AddRankMember(tbRankList)
	for key, pValue in pairs(tbRankList) do
		local pMember = self.pRankList.AddLeagueMember(Battle.RANKLISTNAME, key);
		if pMember then
--			Battle:DbgOut_GC(Dbg.LOG_INFO, "Battle", "AddRankMember", key, pValue.nGongXun);
			pMember.SetTask(Battle.RANKMEMBERTASK, pValue.nGongXun);
		end
	end
end

function Battle:DelRankMember(tbRankList)
	if (not tbRankList) then
		-- 如果为空说明是全部删除
		tbRankList = {}
		if (0 == KLeague.GetMemberSet(Battle.RANKTYPE, Battle.RANKLISTNAME, Battle.ITOR)) then
			return 0;
		end
		local szName 	= KLeague.GetCurMember(Battle.ITOR);
		local nValue	= 0;
		if (szName) then
			tbRankList[szName]	= {};
			tbRankList[szName].szName = szName; 
			while true do
				szName = KLeague.GetNextMember(Battle.ITOR);
				if (not szName) then
					break;
				end
				tbRankList[szName]	= {};
				tbRankList[szName].szName = szName;
			end
		end	
	end
	for key, pValue in pairs(tbRankList) do
		if (not self.pRankList.DelLeagueMember(Battle.RANKLISTNAME, key)) then
			Battle:DbgOut_GC("DelRankMember", "there is no this member", key);
		end
	end
end

-- 显示分隔符
function Battle:_MsgSeparator()
	print("-------------------------------------------------------------------------------");
end

-- 显示战局启动提示
function Battle:_MsgNewRound(dwBattleLevel, szMapName, szExtraMsg)
	self:_MsgSeparator();
	print(string.format("[%s]\tBATTLE ROUND START", GetLocalDate("%Y-%m-%d %H:%M:%S")));
	print(string.format("tBattleLevel: %d\tMapName: %s", dwBattleLevel, szMapName));
	if (szExtraMsg ~= nil) then
		print(szExtraMsg);
	end
	self:_MsgSeparator();
end

-- 显示战局结束提示
function Battle:_MsgRoundResult(dwBattleLevel, szExtraMsg)
	self:_MsgSeparator();
	print(string.format("[%s]\tBATTLE ROUND END", GetLocalDate("%Y-%m-%d %H:%M:%S")));
	print(string.format("BattleLevel: %d", dwBattleLevel));
	if (szExtraMsg ~= nil) then
		print(szExtraMsg);
	end
	self:_MsgSeparator();
end

-- 调度宋金
function Battle:ScheduleSongJin(nSeqNum)
	
	if GLOBAL_AGENT then
		return;
	end
	
	-- 启动高中低3级战役
	for i = 1, 3 do
		Battle:RoundStart_GC(1, i, nSeqNum);
	end
end

-- 跨服宋金
function Battle:GlobalSongJin(nSeqNum)
	
	if not GLOBAL_AGENT then
		return;
	end
	
	Battle:RoundStart_GC(1, 2, nSeqNum);
end

function Battle:ScheduleSongJinGongXun()
	local nDay	= tonumber(GetLocalDate("%w"));
	self:DbgOut_GC("ScheduleSongJinGongXun", "Open GongXun", nDay);
	print(string.format("ScheduleSongJinGongXun Open GongXun  nDay = %d", nDay));
	if (1 ~= nDay) then
		return;
	end
--	self:UpdateRank();
end

function Battle:DbgOut_GC(szMode, ...)
	Dbg:Output("Battle", szMode, unpack(arg));
end

Battle:_LoadMapInfo();
