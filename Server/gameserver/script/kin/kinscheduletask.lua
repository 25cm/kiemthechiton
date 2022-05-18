-------------------------------------------------------------------
--File: kinscheduletask.lua
--Author: lbh
--Date: 2007-7-11 11:26
--Describe: 家族时间任务
-------------------------------------------------------------------
if not Kin then --调试需要
	Kin = {}
	print(GetLocalDate("%Y/%m/%d/%H/%M/%S").." build ok ..")
end

if MODULE_GC_SERVER then
---------------------------GC_SERVER_START----------------------

--一个帮会的记名成员转正
function Kin:PerMemberDailyAction(cKin, nKinId)
	local itor = cKin.GetMemberItor()
	local cMember = itor.GetCurMember()
	--获取当天的0点时间（假设任务为18:00执行，若不是要更改下式）
	local nTodayBeginTime = GetTime();
	--大于48小时即可转正
	local nMinTime = nTodayBeginTime - self.CHANGE_REGULAR_TIME;
	local nTotalRepute = 0;
	local nTotalDec = 0
	local cTmpMember = cMember;
	local nMemberId;
	while cMember do
		--记名成员转正
		nMemberId = itor.GetCurMemberId();
		cTmpMember = itor.NextMember();
		if (cMember.GetFigure() == self.FIGURE_SIGNED) then
			if (cMember.GetJoinTime() < nMinTime) then
				cMember.SetCan2Regular(1);
				GlobalExcute{"Kin:SetCan2Regular_GS2", nKinId, nMemberId};
			end
		end
		-- 计算家族总威望
		local nPlayerId = cMember.GetPlayerId();
		local nMemberRepute = KGCPlayer.GetPlayerPrestige(nPlayerId);
		nTotalRepute = nTotalRepute + nMemberRepute;
		--判断是否退出生效（假设是18:00执行，若不是需更改）
		local nLeaveInitTime = cMember.GetLeaveInitTime()
		if nLeaveInitTime > 0 and nTodayBeginTime - nLeaveInitTime > self.MEMBER_LEAVE_TIME then
			local nFigure = cMember.GetFigure()
			-- 族长不能直接删除
			if nFigure == self.FIGURE_CAPTAIN then
				cMember.SetLeaveInitTime(0);
			else
				self:MemberDel_GC(nKinId, nMemberId, 0);
			end
		end
		cMember = cTmpMember; 
	end
	--家族总威望
	if nTotalRepute < 0 then
		nTotalRepute = 0
	end
	cKin.SetTotalRepute(nTotalRepute)
	self.nJourNum = self.nJourNum + 1
	cKin.SetKinDataVer(self.nJourNum)
	--KStatLog.ModifyMax("Kin", cKin.GetName(), "人数", cKin.nMemberCount);
	local nApplyTime = cKin.GetApplyQuitTime();
	if nApplyTime ~= 0 and GetTime() - nApplyTime >= self.QUIT_TONG_TIME then
		if self:CheckQuitTong(cKin) == 1 then
			local nTongId = cKin.GetBelongTong();
			Tong:KinDel_GC(nTongId, nKinId, 0); -- 通过表决退出成功
		else
			Kin:FailedQuitTong_GC(nKinId, 0);			-- 失败
		end
	end
	-- 族长罢免，开启竞选
	if cKin.GetCaptainLockState() == 1 then
		Kin:StartCaptainVote_GC(nKinId);
	end
	GlobalExcute{"Kin:PerMemberDailyAction_GS", nKinId, self.nJourNum, nMinTime, nTotalRepute}
end

Kin.aSecTotalRepute = { 0, 0, 0, 0 };
function Kin:PerMemberWeeklyAction(cKin, nKinId)
	if not cKin then
		return 0;
	end
	print(cKin.GetName(), "WeeklyAction");
	Kin:PerKinWeeklyTask_GC(self.PerKinWeekly_cNextKin, self.PerKinWeekly_nNextKin);	-- 为家族随机周目标
	local nRepute = cKin.GetTotalRepute();
	if nRepute >= 4000 then
		Kin:AddGuYinBi_GC(nKinId, 200);
		-- self.aSecTotalRepute[4] = self.aSecTotalRepute[4] + 1;		
	elseif nRepute >= 2000 then
		Kin:AddGuYinBi_GC(nKinId, 150);
		-- self.aSecTotalRepute[3] = self.aSecTotalRepute[3] + 1;
	elseif nRepute >= 1000 then
		Kin:AddGuYinBi_GC(nKinId, 100);
		-- self.aSecTotalRepute[2] = self.aSecTotalRepute[2] + 1;	
	else
		-- self.aSecTotalRepute[1] = self.aSecTotalRepute[1] + 1;		
	end
end

function Kin:PerKinDailyAction_Timer()
	self:PerMemberDailyAction(self.PerKinDaily_cNextKin, self.PerKinDaily_nNextKin)
	self.PerKinDaily_cNextKin, self.PerKinDaily_nNextKin = KKin.GetNextKin(self.PerKinDaily_nNextKin)
	
	-- 每日清理家族招募榜
	Kin:KinRecruitmenClean(self.PerKinDaily_nNextKin);
	
	if not self.PerKinDaily_cNextKin then
		self.PerKinDaily_cNextKin = nil
		self.PerKinDaily_nNextKin = nil
		return 0	--Timer结束
	end
	return 1	--1帧后再执行
end

function Kin:PerKinWeeklyAction_Timer()
	Kin:CleanKinRecruitmenPublish(self.PerKinWeekly_nNextKin);

	self:PerMemberWeeklyAction(self.PerKinWeekly_cNextKin, self.PerKinWeekly_nNextKin);
	self.PerKinWeekly_cNextKin, self.PerKinWeekly_nNextKin = KKin.GetNextKin(self.PerKinWeekly_nNextKin)
	
	if not self.PerKinWeekly_cNextKin then
		self.PerKinWeekly_cNextKin = nil;
		self.PerKinWeekly_nNextKin = nil;
		self.bIsKinWeeklyActionOver = 1;
		if (Tong.bIsTongWeeklyActionOver and 1 == Tong.bIsTongWeeklyActionOver) then
			self:RecordWeeklyActionNo();	-- 记录流水号
			self:LogWeeklyTaskLevel();	-- 在家族和帮会都维护完成之后把周目标的log写进数据库
			self.bIsKinWeeklyActionOver = 0;
			Tong.bIsTongWeeklyActionOver = 0;
		end
		-- KStatLog.ModifyField("mixstat", "家族0威望段", "总量", self.aSecTotalRepute[1]);
		-- KStatLog.ModifyField("mixstat", "家族1000威望段", "总量", self.aSecTotalRepute[2]);
		-- KStatLog.ModifyField("mixstat", "家族2000威望段", "总量", self.aSecTotalRepute[3]);
		-- KStatLog.ModifyField("mixstat", "家族4000威望段", "总量", self.aSecTotalRepute[4]);
		return 0	--Timer结束
	end
	return 1	--1帧后再执行
end

function Kin:CaptainVoteStart()
	local nMonth = tonumber(GetLocalDate("%m"))
	--如果当月已启动过竞选，不启动
	if KGblTask.SCGetDbTaskInt(DBTASK_KIN_VOTE) == nMonth then
		return 0
	end
	local itor = KKin.GetKinItor()
	if not itor then
		return 0
	end
	local nKinId = itor.GetCurKinId()
	while nKinId > 0 do
		Kin:StartCaptainVote_GC(nKinId);
		nKinId = itor.NextKinId()
	end
	--记录本月族长竞选已启动
	KGblTask.SCSetDbTaskInt(DBTASK_KIN_VOTE, nMonth);
	return 1;
end

function Kin:CaptainVoteStop()
	local itor = KKin.GetKinItor()
	if not itor then
		return 0
	end
	local cKin = itor.GetCurKin()
	local nCurTime = GetTime()
	--临时数组记录竞选结束要统计票数的家族Id
	self.CaptainVote_anVoteStatKinId = {}
	while cKin do
		local nVoteTime = cKin.GetVoteStartTime()
		--24 * 4 * 3600 = 345600
		--投票在第五天后结束
		if nVoteTime > 0 and nCurTime - nVoteTime > 24 * 4 * 3600 then
			table.insert(self.CaptainVote_anVoteStatKinId, itor.GetCurKinId())
		end
		cKin = itor.NextKin()
	end
	--启动统计票数定时函数（每个家族的统计均错帧执行，以提高效率）
	Timer:Register(1, self.PerKinVoteStat_Timer, self)
	return 1
end

function Kin:PerKinVoteStat_Timer()
	if not self.CaptainVote_anVoteStatKinId then
		return 0
	end
	--取出一个Kin
	local nKinId = table.remove(self.CaptainVote_anVoteStatKinId)
	--已为空
	if not nKinId then
		self.CaptainVote_anVoteStatKinId = nil
		return 0
	end
	self:StopCaptainVote_GC(nKinId)
	return 1
end

--家族日常处理
function Kin:PerKinDailyStart()
	self.PerKinDaily_cNextKin, self.PerKinDaily_nNextKin = KKin.GetFirstKin()
	if not self.PerKinDaily_cNextKin then
		return 0
	end
	Timer:Register(1, self.PerKinDailyAction_Timer, self)
	return 0
end

-- 家族周处理
function Kin:PerKinWeeklyStart()
	self.aSecTotalRepute = { 0, 0, 0, 0 };
	local nWeek = tonumber(GetLocalDate("%W"))
	--如果当周已启动过不启动
	if KGblTask.SCGetDbTaskInt(DBTASK_KIN_WEEKLY) == nWeek then
		return 0
	end
	self.PerKinWeekly_cNextKin, self.PerKinWeekly_nNextKin = KKin.GetFirstKin()
	if not self.PerKinWeekly_cNextKin then
		self.bIsKinWeeklyActionOver = 1;
		if (Tong.bIsTongWeeklyActionOver and 1 == Tong.bIsTongWeeklyActionOver) then
			self:RecordWeeklyActionNo();	-- 记录流水号
			self:LogWeeklyTaskLevel();	-- 在家族和帮会都维护完成之后把周目标的log写进数据库
			self.bIsKinWeeklyActionOver = 0;
			Tong.bIsTongWeeklyActionOver = 0;
		end
		return 0
	end
	Timer:Register(1, self.PerKinWeeklyAction_Timer, self)
	KGblTask.SCSetDbTaskInt(DBTASK_KIN_WEEKLY, nWeek)
	return 0
end
----------------------GC_SERVER_END------------------------------
end

if MODULE_GAMESERVER then
----------------------GAME_SERVER_START---------------------------

function Kin:PerMemberDailyAction_GS(nKinId, nDataVer, nMinTime, nTotalRepute)
	local cKin = KKin.GetKin(nKinId)
	if not cKin then
		return
	end
	cKin.SetTotalRepute(nTotalRepute)
	cKin.SetKinDataVer(nDataVer)
end
---------------------GAME_SERVER_END--------------------------------
end
