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
-- nhiem vu hang ngay
	local tbNhiemVu = SpecialEvent.NhiemVuHangNgay;
	tbNhiemVu:ResetTaskDaily();
---------------------------------------------
	self:Refresh();
	if Config.Mission_Battle_CheckNumAccount == 1 then
		-- print(Battle:CheckValidHardware(me));
		-- Battle:CheckValidHardware(me);
			if Battle:CheckValidHardware(me) == 0 then
			Battle:WriteZeroHardWare(me);
			
			end
	end

---------------------------Reset task mua lại phần thưởng TK------------------------
	if ReBuyBattle.ReBuy_Battle_OnOff == 1 then
		ReBuyBattle:ReloadTask();
	end
------------------------------------------------------------------------------------

---------------------------mỗi HWID chỉ được vào 1 bên Tống Kim------------------------
    local nCheckCamp = me.GetWorldPos();  

    local nHardWareId_p = me.dwHardWareId;
	local szIPPath = "\\script\\MrKent\\CampBattle\\Tong.txt";  
    local tbNameBangHoi = Lib:LoadTabFile(szIPPath);
    for nRow, tbRowData in pairs(tbNameBangHoi) do
        if ((tonumber(tbRowData.Name) == nHardWareId_p) and (nCheckCamp == 184 or nCheckCamp == 185)) then
        Dialog:Say("Mỗi địa chỉ IP mạng chỉ được vào 1 phe Tống Kim\nMáy tính của bạn đã gia nhập phe <color=blue>Tống<color>.");
        return 0;		
        end
    end
	
	local szIpKim = "\\script\\MrKent\\CampBattle\\Kim.txt";  
    local tbKim = Lib:LoadTabFile(szIpKim);
    for nRoww, tbRowDataa in pairs(tbKim) do
        if ((tonumber(tbRowDataa.Name) == nHardWareId_p) and (nCheckCamp == 181 or nCheckCamp == 182)) then
        Dialog:Say("Mỗi địa chỉ IP mạng chỉ được vào 1 phe Tống Kim\nMáy tính của bạn đã gia nhập phe <color=purple>Kim<color>.");
        return 0;		
        end
    end
	
	if (me.IsFreshPlayer() == 1) then
		Dialog:Say("Bạn chưa gia nhập môn phái, gia nhập rồi hãy quay lại!");
		return;
	end
---------------------------sửa lỗi nhận thưởng mỗi lần thoát ra vào lại tống kim, sửa lại thời gian nhận thưởng thành thời gian kết thúc tông kim-------------------------------------------------
	local nThoiGian = tonumber(os.date("%H%M", GetTime()));
	if (nThoiGian >= 0000 and nThoiGian <= 1059) or (nThoiGian >= 1150 and nThoiGian <= 1659) or (nThoiGian >= 1750 and nThoiGian <= 2059) or (nThoiGian >= 2150 and nThoiGian <= 2259) or (nThoiGian >= 2350 and nThoiGian <= 2359) then

	if not GLOBAL_AGENT then
		if (0 == self:AwardGood()) then
			return;
		end
	end
end
----------------------------------------------------------------------------
	Battle:DbgOut("tbNpcBase:OnDialog", self, self.nMapId, self.tbMission);
	if (not self.tbMission) then
		local szMsg = "<color=yellow>Tống Kim<color> bắt đầu báo danh lúc: <color=green>10h50, 16h50, 20h50, 22h50<color> <color=gold>(4 Trận/1Ngày)<color>\n=> Hiện chưa mở, xin hãy quay lại sau!";
		local tbOpt = 
		{

		};
		Dialog:Say(szMsg,tbOpt)
		return;
	end

	if (0 == self:CheckMaxNum()) then
		Dialog:Say(self.tbDialog[1]);
		return;
	end
	local pPlayer = me;
	local szIp	= pPlayer.dwHardWareId;
	local nCheckResult = self:CheckPlayer();
	if (1 == nCheckResult) then
		local nPLLevel	= Battle.LEVEL_LIMIT[self.nLevel];
		Dialog:Say(string.format(self.tbDialog[2], nPLLevel),
			{
				{string.format("Ta muốn gia nhập quân <color=red>%s<color>", Battle.NAME_CAMP[self.nCampId]), self.OnSingleJoin, self, pPlayer},
				{"Để ta suy nghĩ đã"},
			}
		);
	elseif (2 == nCheckResult) then
		Dialog:Say("Ngươi muốn vào chiến trường bây giờ sao? Lúc chiến đấu, ngươi và người khác hợp thành tổ đội giết địch, một công đôi việc.<enter>- Máy chủ không cho phép post điểm, nếu post điểm bạn sẽ bị cấm tham gia Tống Kim<enter><color=green>HWID:<color> "..szIp.."",
			{
				{"Ta muốn vào chiến trường", self.OnSingleJoin, self, pPlayer},
				{"Chờ chút hãy nói"},
			}
		);
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
			{"Đồng ý", self.OnAwardGood, self, pPlayer, nAwardPai, nPaiCount, nFuCount, nBouns, nFinalBouns}, 
			{"Nói tiếp đi"},
		};
		local _, _, szExtendInfo = SpecialEvent.ExtendAward:DoCheck("Battle", pPlayer, nBouns, self.nLevel);
		Dialog:Say(szMsg..szExtendInfo..", muốn nhận bây giờ?", tbOpt);
		return 0;
	end
	return 1;
end

function tbNpcBase:OnAwardGood(pPlayer, nItemId, nPaiCount, nFuCount, nBouns, nFinalBouns)
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
			szMsg = szMsg .. string.format(", Nhận được %s <color=green>Lệnh bài chiến trường<color> và <color=yellow>Túi Phúc Hoàng Kim<color>.", Battle.NAME_GAMELEVEL[nItemId]);
		elseif (nFuCount > 0) then
			szMsg = szMsg .. ", Nhận được <color=yellow>Túi Phúc Hoàng Kim<color>."
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

---------------------------Chặn vào tống kim 23h00-------------------------------------
	local nSoTran = KGblTask.SCGetDbTaskInt(DBTASD_TONGKIM_SOTRAN);
	local nCount = me.GetTask(3147,1)
	if GhiTenTk:CheckValidHardware(me) == 0 then
	if nCount >= nSoTran then
		Dialog:Say("Bạn đã hết lượt tham gia tống kim rồi, chờ trận sau nhé");
		return 0;
	end
	end

---------------------------Chặn vào tống kim 23h00-------------------------------------
	local nCheckTran = tonumber(GetLocalDate("%H%M"));
        if (nCheckTran >= 2249) and (nCheckTran < 2356) then
		local nMua = me.GetTask(3150,40)
		if nMua >= 1 then
			Dialog:Say("Bạn đã mua lại trận <color=purple>22h50<color> không được phép tham gia Trận này nữa");
			return 0;
		end
	end    
---------------------------------------------------------------------------------------
	if Config.Mission_Battle_CheckNumAccount == 1 then
		local nCheck,nNum,Msg = Battle:CheckHardWare(me);
			if nCheck ~= 1 then
			Dialog:Say(""..Msg.."");
			return 0;
			end
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
								-- {"Vào Chiến trường", self.OnBattleInfo, self},
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
	local nDifNumLimit	= Battle.BTPLNUM_NUMDIF;
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
	if Config.Mission_Battle_CheckNumAccount == 1 then
	local _,nNumOld,_ = Battle:CheckHardWare(pPlayer);
	Battle:WriteNewHardWare(pPlayer,nNumOld);
	end
	
---------------------------set task mua lại phần thưởng TK------------------------
	if GhiTenTk.Tat_Mo_Tinh_Nang == 1 then
		-- print(Battle:CheckValidHardware(me));
		-- Battle:CheckValidHardware(me);
			if GhiTenTk:CheckValidHardware(me) == 0 then
			GhiTenTk:WriteZeroHardWare(me);
			GhiTenTk:WriteNewHardWare(me);
			end
	end

---------------------------set task mua lại phần thưởng TK------------------------
	if ReBuyBattle.ReBuy_Battle_OnOff == 1 then
		ReBuyBattle:SetTaskLoadMap();
	end
	
---------------------Ghi Lai Ma O Cung Camp Tong Kim-----------------------
    local nCheckCamp = pPlayer.GetWorldPos();  
    if (nCheckCamp == 181 or nCheckCamp == 182) and (CampBattle.Mission_CampBattle_CheckNumAccount == 1) then
        CampBattle:WriteSongCamp(pPlayer);
	end
	if (nCheckCamp == 184 or nCheckCamp == 185) and (CampBattle.Mission_CampBattle_CheckNumAccount == 1) then
		CampBattle:WriteKimCamp(pPlayer);
	end
---------------------------------------------------------------------------
	Dialog:SendBlackBoardMsg(pPlayer, "Nghiêm cấm mọi hành vi Post mạng Tống Kim");
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
