-- 募兵校尉报名脚本程序
-- zhouchenfei  create  2007-09-17

local tbNpc	= Npc:GetClass("mubingxiaowei");

function tbNpc:Init()
	if (self.tbMapNpc) then	-- 支持重载
		return;
	end

	local tbMapNpc	= {};	-- 通过地图Id寻找募兵校尉
	for nLevel, tbMId in pairs(Battle.MAPID_LEVEL_CAMP) do
		for nBattleSeq, tbMapId in pairs(tbMId) do
			for nCampId, nMapId in pairs(tbMapId) do
				tbMapNpc[nMapId]	= Lib:NewClass(Battle.tbNpcBase, nMapId, nLevel, nCampId, nBattleSeq);
			end
		end
	end
	
	self.tbMapNpc			= tbMapNpc;
end

-- 和募兵校尉对话
function tbNpc:OnDialog()
	local tbNpc	= self.tbMapNpc[him.nMapId];
	
	tbNpc:OnDialog();
end

-- 针对一个募兵校尉的基类
local tbNpcBase	= Battle.tbNpcBase or {};	-- 支持重载

tbNpcBase.tbBattleSeq = {"1", "2", "3"};

function tbNpcBase:init(nMapId, nLevel, nCampId, nBattleSeq)
	self.nMapId		= nMapId;
	self.nLevel		= nLevel;
	self.nCampId	= nCampId;
	self.nBattleSeq = nBattleSeq;
	self.tbDialog	= Battle.tbCampDialog[self.nCampId];
end

-- 刷新，使得链接到相应阵营
function tbNpcBase:Refresh()
	local tbMission	= Battle:GetMission(self.nLevel, self.nBattleSeq);
	if (tbMission) then
		self.tbMission	= tbMission;
		self.tbCamp		= tbMission.tbCamps[self.nCampId];
	else
		self.tbMission	= nil;
		self.tbCamp		= nil;
	end
end

function tbNpcBase:OnDialog()
	self:Refresh();

	if (me.IsFreshPlayer() == 1) then
		Dialog:Say("Bạn chưa gia nhập môn phái, gia nhập rồi hãy quay lại!");
		return;
	end

	if not GLOBAL_AGENT then
		if (0 == self:AwardGood()) then
			return;
		end
	end

	Battle:DbgOut("tbNpcBase:OnDialog", self, self.nMapId, self.tbMission);
	if (not self.tbMission) then
		Dialog:Say("Đại quân tuần tra chiến trường vẫn chưa xuất phát, hãy tiếp tục thao luyện và đợi thông báo.");
		return;
	end

	if (0 == self:CheckMaxNum()) then
		Dialog:Say(self.tbDialog[1]);
		return;
	end
	local pPlayer = me;
	local nCheckResult = self:CheckPlayer();
		local tbItemId1 = {18,1,3039,5,0,0}; -- vk1
	local nCount1 = me.GetItemCountInBags(18,1,3039,5);
	if nCount1 >= 1 then
	if (me.nFaction == 5) and (me.nRouteId == 2) then
	Dialog:Say("Để tránh tình trạng kéo xe. Nga My Buff không thể vào chiến trường <color=yellow>Tống Kim<color>. Xin hãy đổi sang phái khác để có thể vào chiến trường <color=yellow>Tống Kim<color>");
	else
	if (1 == nCheckResult) then
		local nPLLevel	= Battle.LEVEL_LIMIT[self.nLevel];
		Dialog:Say(string.format(self.tbDialog[2], nPLLevel),
			{
				{string.format("Ta muốn gia nhập quân <color=red>%s<color>", Battle.NAME_CAMP[self.nCampId]), self.OnSingleJoin, self, pPlayer},
				{"Để ta suy nghĩ đã"},
			}
		);
	elseif (2 == nCheckResult) then
		Dialog:Say("Ngươi muốn vào chiến trường bây giờ sao? Lúc chiến đấu, ngươi và người khác hợp thành tổ đội giết địch, một công đôi việc.",
			{
				{"Ta muốn vào chiến trường", self.OnSingleJoin, self, pPlayer},
				{"Chờ chút hãy nói"},
			}
		);
	end
	
end
else
	Dialog:Say("Không có lệnh bài tham gia <color=yellow>Tống Kim<color> không thể vào chiến trường. Hãy liên hệ ADM để được trợ giúp. Tối đa 4 Tài Khoản/ 1IP tham gia <color=yellow>Tống Kim<color>");
end
end
-- 奖励上一场宋金战场的积分对应的奖励，返回1表示继续，返回0表示不用继续了
function tbNpcBase:AwardGood()
	-- 判断是否能给予奖励
	local pPlayer = me;
	if (self.tbMission) then
		local nCampId		= pPlayer.GetTask(Battle.TSKGID, Battle.TASKID_BTCAMP);
		local nMyBTKey		= pPlayer.GetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_KEY);
		local nBTKey		= self.tbMission.nBattleKey;
		local nDiaFlag		= 0;

		local nBattleSeqA	= math.fmod(nMyBTKey, 10);
		local nBattleSeqB	= math.fmod(nBTKey, 10);
		local nBattleTimeA	= nMyBTKey - nBattleSeqA;
		local nBattleTimeB	= nBTKey - nBattleSeqB;

		-- id不一样表示可能是同一时间段不同场次，可能是不同一时间段
		if (nMyBTKey ~= nBTKey) then
			-- 如果是同一时间段的表示这个玩家可能从另一个场次出来到其他场次
			if (nBattleTimeA == nBattleTimeB) then
				nDiaFlag = 1;
			end
		else -- 相同id
			-- 如果战局开始了就不能领了，直接继续下面对话
			if (self.tbMission.nState == 2) then
				return 1;
			end
			-- 同一场次却不是同一阵营
			if (0 ~= nCampId and self.nCampId ~= nCampId) then
				nDiaFlag = 2;
			end		
		end

		if (nDiaFlag == 1) then
			Dialog:Say(string.format(self.tbDialog[8], Battle.NAME_GAMELEVEL[self.nLevel], self.tbBattleSeq[nBattleSeqA], Battle.NAME_CAMP[nCampId]));
			return 0;
		elseif (nDiaFlag == 2) then
			Dialog:Say(self.tbDialog[5]);
			return 0;
		end
	end

	local nAwardPai = pPlayer.GetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_ZHANCHANGLINGPAI);
	local nAwardFu	= pPlayer.GetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_FUDAI);
	local nBouns	= pPlayer.GetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_TOTALBOUNS);
	
	if (nAwardPai + nAwardFu + nBouns > 0) then
		local nPaiCount		= 0;
		local nFuCount		= 0;
		local szMsg = string.format("Điểm tích lũy chiến trường lần trước của ngươi là %d", nBouns);
		local nFinalBouns	= 0;
		
		if (nBouns > 0) then
			nFinalBouns = nBouns;
			local nMyUse = pPlayer.GetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_USEBOUNS);
			if (nMyUse + nBouns > Battle.BATTLES_POINT2EXP_MAXEXP) then
				nFinalBouns = Battle.BATTLES_POINT2EXP_MAXEXP - nMyUse;
			end
		end
		if (nFinalBouns > 0) then
			szMsg = szMsg .. string.format(", có thể nhận %d điểm phần thưởng kinh nghiệm", nFinalBouns);
		elseif (nFinalBouns == 0 and nBouns > 0) then
			szMsg = szMsg .. string.format(", điểm tích lũy đổi kinh nghiệm tuần này của ngươi đã đạt giới hạn <color=yellow>500.000<color>, trong tuần không thể đổi kinh nghiệm nhưng vẫn nhận được phần thưởng điểm cống hiến gia tộc", nFinalBouns);
		end
		
		if (nAwardPai > 0 and nAwardFu > 0) then
			szMsg = szMsg .. string.format(", có thể nhận 1 Lệnh bài chiến trường %s và 2 Túi Phúc Hoàng Kim", Battle.NAME_GAMELEVEL[nAwardPai]);
			nPaiCount	= 1;
			nFuCount	= nAwardFu;
		elseif (nAwardFu > 0) then
			szMsg = szMsg .. ", có thể nhận 1 Túi Phúc";
			nFuCount = nAwardFu;
		end
		local tbOpt = { 
			{"Đồng ý", self.OnAwardGood, self, pPlayer, nAwardPai, nPaiCount, nFuCount, nBouns}, 
			{"Nói tiếp đi"},
		};
		local _, _, szExtendInfo = SpecialEvent.ExtendAward:DoCheck("Battle", pPlayer, nBouns, self.nLevel);
		Dialog:Say(szMsg..szExtendInfo..", muốn nhận bây giờ?", tbOpt);
		return 0;
	end
	return 1;
end

function tbNpcBase:OnAwardGood(pPlayer, nItemId, nPaiCount, nFuCount, nBouns)
	if (0 == Battle:AwardGood(pPlayer, nItemId, nPaiCount, nFuCount, nBouns, self.nLevel)) then
		-- 保存玩家义军令牌的等级
		pPlayer.Msg("Hành trang của bạn không đủ chỗ, không thể nhận phần thưởng");
	else
		local szMsg = string.format("Điểm tích lũy chiến trường lần trước của ngươi là %d", nBouns);
		if (nFinalBouns > 0) then
			szMsg = szMsg .. string.format(", đã nhận %d điểm phần thưởng kinh nghiệm", nFinalBouns);
		elseif (nFinalBouns == 0 and nBouns > 0) then
			szMsg = szMsg .. string.format(", điểm tích lũy đổi kinh nghiệm tuần này của ngươi đã đạt giới hạn <color=yellow>500.000<color>, trong tuần không thể đổi kinh nghiệm nhưng vẫn nhận được phần thưởng điểm cống hiến gia tộc", nFinalBouns);
		end
		if (nPaiCount > 0) then
			szMsg = szMsg .. string.format(", nhận được 1 %s <color=green>Lệnh bài chiến trường<color> và 2 <color=yellow>Túi Phúc Hoàng Kim<color>.", Battle.NAME_GAMELEVEL[nItemId]);
		elseif (nFuCount > 0) then
			szMsg = szMsg .. ", nhận được 1 <color=yellow>Túi Phúc Hoàng Kim<color>."
		end
		pPlayer.Msg(szMsg);
	end
	return;
end

function tbNpcBase:CheckMaxNum()
	local nMyCampCount		= self.tbCamp:GetPlayerCount();
	if (Battle.BTPLNUM_HIGHBOUND <= nMyCampCount) then
		return 0;
	end
	return 1;
end

-- 检查玩家的等级和阵营
-- 返回值：0、此玩家不能进入；1、此玩家本场尚未报名，可以参加；2、此玩家报过名了，可以进入
function tbNpcBase:CheckPlayer()
	if (not self.tbMission) then
		Dialog:Say("Đại quân tuần tra chiến trường vẫn chưa xuất phát, hãy tiếp tục thao luyện và đợi thông báo.");
		return;
	end	

	local pPlayer = me;
	
	local nJoinLevel	= Battle:GetJoinLevel(pPlayer);
	local nCampId = pPlayer.GetTask(Battle.TSKGID, Battle.TASKID_BTCAMP);
	local nFlag = 1;

	local nMyBTKey		= pPlayer.GetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_KEY);
	local nBTKey		= self.tbMission.nBattleKey;
	local nDiaFlag		= 0;


	local nBattleSeqA = math.fmod(nMyBTKey, 10);
	local nBattleSeqB = math.fmod(nBTKey, 10);
	local nBattleTimeA = nMyBTKey - nBattleSeqA;
	local nBattleTimeB = nBTKey - nBattleSeqB;

	if (nMyBTKey ~= nBTKey) then
		if (nBattleTimeA == nBattleTimeB) then
			nDiaFlag = 1;
		end
	else
		if (0 ~= nCampId and self.nCampId ~= nCampId) then
			nDiaFlag = 2;
		elseif (0 ~= nCampId and self.nCampId == nCampId) then
			nFlag = 2;
		end
	end

	if (nFlag == 1) then
		if (self.nLevel > nJoinLevel) then
			local tbOpt =	{
--								{"我想了解战役的信息", self.OnBattleInfo, self},
								{"Được rồi"},
							};
			Dialog:Say("Trình độ của ngươi chưa đạt, hãy về cố gắng luyện tập sau này quay lại góp sức cho nước nhà!", tbOpt);
			return 0;
		end

		if (pPlayer.IsFreshPlayer() == 1) then
			Dialog:Say("Bạn chưa gia nhập môn phái, gia nhập rồi hãy quay lại!");
			return 0;
		end
	
		if (self.nLevel < nJoinLevel) then	-- 有问题
			Dialog:Say(string.format("Ngươi đã tinh thông võ nghệ, hãy đi tham gia chiến trường <color=yellow>%s<color>!", Battle.NAME_GAMELEVEL[nJoinLevel]));
			return 0;
		end
	end
	
	if (nDiaFlag == 1) then
		Dialog:Say(string.format(self.tbDialog[8], Battle.NAME_GAMELEVEL[self.nLevel], self.tbBattleSeq[nBattleSeqA], Battle.NAME_CAMP[nCampId]));
		return 0;
	elseif (nDiaFlag == 2) then
		Dialog:Say(self.tbDialog[5]);
		return 0;
	end

	if (0 == self:CheckNumDif(self.nLevel)) then
		local nSongNum	= self.tbMission.tbCamps[Battle.CAMPID_SONG].nPlayerCount;
		local nJinNum	= self.tbMission.tbCamps[Battle.CAMPID_JIN].nPlayerCount;
		local szMsg		= string.format("Hiện tại quân số hai bên là: <color=orange>Tống: %d<color>, <color=purple>Kim: %d<color>, so với quân địch, ta tạm thời thiếu hụt quân số, ngươi hãy kiên nhẫn chờ đợi tí nữa quay lại.", nSongNum, nJinNum);
		Dialog:Say(szMsg);
		return 0;
	end

	return nFlag;
end

function tbNpcBase:CheckNumDif(nJoinLevel)
	local nMyCampNum	= self.tbCamp:GetPlayerCount();
	local nEnemyCampNum	= self.tbCamp.tbOppCamp:GetPlayerCount();
	if (nMyCampNum < Battle.tbBTPLNUM_LOWBOUND[nJoinLevel]) then
		return 1;
	end
	local nTemp			= nMyCampNum - nEnemyCampNum;
	local nDifNumLimit	= math.max(Battle.BTPLNUM_NUMDIF, (nMyCampNum + nEnemyCampNum) * 0.1);
	if (nTemp >= nDifNumLimit) then
		return 0;
	end
	return 1;
end

-- 选择个人进入战场
function tbNpcBase:OnSingleJoin(pPlayer)
	self:Refresh();
	
	if (0 == self:CheckPlayer()) then
		return;
	end
	
	self:DoSingleJoin(pPlayer);
end


function tbNpcBase:OnNewEnter(pPlayer, nNowTime)
	if (0 == self:CheckPlayer()) then
		return;
	end
	self:DoSingleJoin(pPlayer);
	Battle:ResetBonus(pPlayer, nNowTime);
end

-- 执行真正进入战场操作
function tbNpcBase:DoSingleJoin(pPlayer)
	local pPlayerOld 	= me;
	if (not self.tbMission) then -- 异常
		me = pPlayer;
		Dialog:Say(" Bạn đã quá mệt, hãy nghỉ ngơi!");
		me = pPlayerOld;
		return;
	elseif (self.tbMission.nState == 2) then -- 战局开始
		pPlayer.Msg(self.tbDialog[4]);
	else			-- 战局还没开始
		me = pPlayer;	
		Dialog:Say(self.tbDialog[3]);
		me = pPlayerOld;
	end
	if (self.tbMission.nState == 2) then -- 战局开始后才记录玩家阵营和战场id
		--记录玩家参加宋金战场的次数
		local nBTKey = self.tbMission.nBattleKey;
		local bIsDiffBattle = Battle:IsDiffBattle(pPlayer, nBTKey)
		if (bIsDiffBattle and 1 == bIsDiffBattle) then
			Stats.Activity:AddCount(pPlayer, Stats.TASK_COUNT_BATTLE, 1);
		end
		
		pPlayer.SetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_KEY, self.tbMission.nBattleKey);
		pPlayer.SetTask(Battle.TSKGID, Battle.TASKID_BTCAMP, self.nCampId);

	end
	self.tbMission:JoinPlayer(pPlayer, self.nCampId);
end

function tbNpcBase:OnBattleInfo() -- todo
	self:Refresh();
end

Battle.tbNpcBase	= tbNpcBase;

tbNpc:Init();
