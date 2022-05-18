-------------------------------------------------------------------
--File: kinlogic_gc.lua
--Author: lbh
--Date: 2007-6-26 14:57
--Describe: gamecenter家族逻辑
-------------------------------------------------------------------
if not Kin then --调试需要
	Kin = {}
	print(GetLocalDate("%Y/%m/%d/%H/%M/%S").." build ok ..")
else
	if not MODULE_GC_SERVER then
		return
	end
end

function Kin:CreateKinApply_GC(nPlayerId, szKinName)
	local nKinId = KKin.GetKinNameId(szKinName);
	return Tong:ApplyKinName(nKinId, nPlayerId);
end

function Kin:OnKinNameResult(nParam, nResult)
	GlobalExcute{"Kin:OnKinNameResult_GS2", nParam, nResult};
end

--以列表的PlayerId创建家族
function Kin:CreateKin_GC(anPlayerId, anStoredRepute, szKinName, nCamp)
	--检查创建家族的成员是否符合要求
	if self:CanCreateKin(anPlayerId) ~= 1 then
		return 0
	end
	local nCreateTime = GetTime()
	local tbStock = {};
	if self:CreateKin(anPlayerId, anStoredRepute, szKinName, nCamp, nCreateTime, tbStock) == nil then
		return 0
	end
	
	--Log 记录
	local szMsg =  string.format("Lập gia tộc %s", szKinName);
	KGCPlayer.PlayerLog(anPlayerId[1], Log.emKPLAYERLOG_TYPE_CREATEFAMILY, szMsg);
	szMsg = string.format("Gia tộc %s được thành lập",  KGCPlayer.GetPlayerName(anPlayerId[1]));
	_G.KinLog(szKinName,  Log.emKKIN_LOG_TYPE_KINSTRUCTURE, szMsg);
	
	return GlobalExcute{"Kin:CreateKin_GS2", anPlayerId, anStoredRepute, szKinName, nCamp, nCreateTime, tbStock}
end

--增加成员
function Kin:MemberAdd_GC(nKinId, nExcutorId, nPlayerId, bCanJoinKinImmediately)
	local nRet, cKin = self:CheckSelfRight(nKinId, nExcutorId, 2)
	if nRet ~= 1 then
		return 0
	end
	if (self:CheckMemberCanAdd(nKinId, nPlayerId) ~= 1) then
		return 0
	end
	--从Id生成器获取Id
	local nMemberId = cKin.GetMemberIdGentor() + 1
	local cMember = cKin.AddMember(nMemberId)
	if not cMember then
		return 0
	end
	if KKin.SetPlayerKinMember(nPlayerId, nKinId, nMemberId) ~= 1 then
		cKin.DelMember(nMemberId)
		return 0
	end
	local nJoinTime = GetTime()
	--设置Id生成器
	cKin.SetMemberIdGentor(nMemberId)
	cMember.SetJoinTime(nJoinTime)
	cMember.SetPlayerId(nPlayerId)
	cMember.SetFigure(self.FIGURE_SIGNED)
	if (bCanJoinKinImmediately == 1) then	-- 如果是被召回老玩家，在老玩家活动期间可以马上转正
		cMember.SetFigure(self.FIGURE_REGULAR);
	end
	local nStoredRepute = KGCPlayer.GetPlayerPrestige(nPlayerId);
	if (nStoredRepute and nStoredRepute > 0) then
		cKin.AddTotalRepute(nStoredRepute)
	end
	self.nJourNum = self.nJourNum + 1
	cKin.SetKinDataVer(self.nJourNum)
	local szPlayerName = KGCPlayer.GetPlayerName(nPlayerId);
	if szPlayerName then
		cKin.AddHistoryPlayerJoin(szPlayerName);
	end
	
	KKin.DelKinInductee(nKinId, szPlayerName);
	local nRegular, nSigned, nRetire = cKin.GetMemberCount();
	local nMemberCount = nRegular + nSigned;
	if cKin.GetRecruitmentPublish() == 1 and nMemberCount >= self.MEMBER_LIMITED then
		cKin.SetRecruitmentPublish(0);
	end
	
	-- 股份处理
	local nTongId = cKin.GetBelongTong()
	local pTong = KTong.GetTong(nTongId);
	local nPersonalStock = KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_TONGSTOCK);		-- 个人资产;
	nPersonalStock = nPersonalStock or 0;
	if pTong then
		local nPrice = Tong.DEFAULT_STOCKPRICE;
		local nBuildFund = pTong.GetBuildFund()
		local nTotalStock = pTong.GetTotalStock();
		if nBuildFund > 0 and nTotalStock > 0 then
			nPrice = nBuildFund / nTotalStock;		-- 计算股价
		end
		nBuildFund = nBuildFund + nPersonalStock;
		pTong.SetBuildFund(nBuildFund);
		nPersonalStock = math.floor(nPersonalStock * Tong.JOIN_TONG_STOCK / nPrice);
		
		nTotalStock = nTotalStock + nPersonalStock;
		pTong.SetTotalStock(nTotalStock);
		Tong:SyncStock(nTongId);
	end
	cMember.SetPersonalStock(nPersonalStock)
	
	local szMsg = string.format("%s gia nhập gia tộc",  KGCPlayer.GetPlayerName(nPlayerId));
	_G.KinLog(cKin.GetName(),  Log.emKKIN_LOG_TYPE_KINSTRUCTURE, szMsg);
	return GlobalExcute{"Kin:MemberAdd_GS2", self.nJourNum, nKinId, nPlayerId, nMemberId, nJoinTime, nStoredRepute, nPersonalStock, bCanJoinKinImmediately}
end

function Kin:MemberIntroduce_GC(nKinId, nExcutorId, nPlayerId, nPrestige)
	if self:HaveFigure(nKinId, nExcutorId, 3) ~= 1 then
		return 0
	end
	local aThisIntroEvent = self:GetKinData(nKinId).aIntroduceEvent
	--如果推荐已经发起过，返回
	if aThisIntroEvent[nPlayerId] then
		return 0
	end
	aThisIntroEvent[nPlayerId] = nPrestige
	--5分钟后删除
	Timer:Register(5*60*18, self.IntroduceCancel_GC, self, nKinId, nPlayerId)
	return GlobalExcute{"Kin:MemberIntroduce_GS2", nKinId, nExcutorId, nPlayerId}
end

--接受或拒绝推荐申请
function Kin:AcceptIntroduce_GC(nKinId, nExcutorId, nPlayerId, bAccept)
	if self:CheckSelfRight(nKinId, nExcutorId, 2) ~= 1 then
		return 0
	end
	local aThisIntroEvent = self:GetKinData(nKinId).aIntroduceEvent
	local nPrestige = aThisIntroEvent[nPlayerId]
	--如果推荐事件已不存在
	if not nPrestige then
		return 0
	end
	aThisIntroEvent[nPlayerId] = nil
	if KKin.GetPlayerKinMember(nPlayerId) ~= 0 then
		return 0
	end
	GlobalExcute{"Kin:AcceptIntroduce_GS2", nKinId, nPlayerId}
	if bAccept == 1 then
		return Kin:MemberAdd_GC(nKinId, nExcutorId, nPlayerId)
	end
	return 1
end

--时间到取消推荐事件
function Kin:IntroduceCancel_GC(nKinId, nPlayerId)
	local aThisIntroEvent = self:GetKinData(nKinId).aIntroduceEvent
	aThisIntroEvent[nPlayerId] = nil
	return 0
end

--删除成员nMethod = 0自己退出，nMethod = 1开除
function Kin:MemberDel_GC(nKinId, nMemberId, nMethod)
	local cKin = KKin.GetKin(nKinId)
	local cMember = cKin.GetMember(nMemberId)
	if not cMember then
		return 0
	end
	local nFigure = cMember.GetFigure()
	-- 族长不能直接删除
	if nFigure == self.FIGURE_CAPTAIN then
		return 0
	end
	
	local nPlayerId = cMember.GetPlayerId()
	if nPlayerId <= 0 then
		return 0
	end
	
	-- 股份处理
	local nTongId = cKin.GetBelongTong()
	local pTong = KTong.GetTong(nTongId);
	local nPersonalStock = cMember.GetPersonalStock();
	local nNewStock = 0;
	if pTong then
		local nPrice = 0;
		local nBuildFund = pTong.GetBuildFund()
		local nTotalStock = pTong.GetTotalStock();
		if nBuildFund > 0 and nTotalStock > 0 then
			nPrice = nBuildFund / nTotalStock;		-- 计算股价
		end
		local nMemberFund = math.floor(nPersonalStock * nPrice)
		nNewStock = math.floor(nMemberFund * Tong.QUIT_REDUCE_STOCK)
		nBuildFund = nBuildFund - nMemberFund;
		nTotalStock = nTotalStock - nPersonalStock;
		pTong.SetBuildFund(nBuildFund);
		pTong.SetTotalStock(nTotalStock);
		Tong:SyncStock(nTongId);
	else
		nNewStock = math.floor(nPersonalStock * Tong.QUIT_REDUCE_STOCK);
	end
	KGCPlayer.OptSetTask(nPlayerId, KGCPlayer.TSK_TONGSTOCK, nNewStock);		-- 保存个人资产
	-- 威望处理
	local nRepute = KGCPlayer.GetPlayerPrestige(nPlayerId);
	local nReputeLeft = 0
	if nRepute > 0 then
		--家族总江湖威望减少
		cKin.AddTotalRepute(-nRepute)
	end
	--退出时的时间
	KGCPlayer.OptSetTask(nPlayerId, KGCPlayer.TSK_LEAVE_KIN_TIME, GetTime())
	if KKin.DelPlayerKinMember(nPlayerId) ~= 1 then
		return 0
	end
	if cKin.DelMember(nMemberId) ~= 1 then
		return 0
	end
	if nFigure == self.FIGURE_ASSISTANT then
		cKin.SetAssistant(0)
	end
	self.nJourNum = self.nJourNum + 1
	cKin.SetKinDataVer(self.nJourNum)
	-- Add Kin Log
	local szMsg = string.format("%s, %s", KGCPlayer.GetPlayerName(nPlayerId), (nMethod == 0 and "叛离家族" or "被开除家族"));
	_G.KinLog(cKin.GetName(),  Log.emKKIN_LOG_TYPE_KINSTRUCTURE, szMsg);
	KGCPlayer.PlayerLog(nPlayerId, Log.emKKIN_LOG_TYPE_KINSTRUCTURE, szMsg);	
	
	return GlobalExcute{"Kin:MemberDel_GS2", self.nJourNum, nKinId, nMemberId, nPlayerId, nMethod, nReputeLeft, nRepute}
end

function Kin:LeaveApply_GC(nKinId, nExcutorId, bLeave)
	local cKin = KKin.GetKin(nKinId)
	if not cKin then
		return 0
	end
	local cMember = cKin.GetMember(nExcutorId)
	if not cMember then
		return 0
	end
	local nTime = 0;
	if bLeave == 1 then
		nTime = GetTime()
	end
	cMember.SetLeaveInitTime(nTime)
	return GlobalExcute{"Kin:LeaveApply_GS2", nKinId, nExcutorId, nTime}
end

--开除成员
function Kin:MemberKickInit_GC(nKinId, nExcutorId, nMemberId)
	if self:CheckSelfRight(nKinId, nExcutorId, 2) ~= 1 then
		return 0
	end	
	local aThisKickEvent = self:GetKinData(nKinId).aKickEvent
	--如果开除已经发起过，返回
	if aThisKickEvent[nMemberId] then
		return 0
	end
	--记录踢人响应事件信息
	aThisKickEvent[nMemberId] = 0	
	--在一定时间后删除
	Timer:Register(self.KICK_RESPOND_TIME, self.MemberKickCancel_GC, self, nKinId, nMemberId)
	return GlobalExcute{"Kin:MemberKickInit_GS2", nKinId, nExcutorId, nMemberId}
end

function Kin:MemberKickRespond_GC(nKinId, nExcutorId, nMemberId)
	if self:HaveFigure(nKinId, nExcutorId, 3) ~= 1 then
		return 0
	end
	local aThisKickEvent = self:GetKinData(nKinId).aKickEvent
	--如果开除未发起或已取消，返回
	if not aThisKickEvent[nMemberId] then
		return 0
	end	
	--先前已经有一个人响应，加上这个响应就有两个人响应，执行删除
	if aThisKickEvent[nMemberId] ~= 0 then
		--如果是同一个人，返回
		if aThisKickEvent[nMemberId] == nExcutorId then
			return 0
		end
		aThisKickEvent[nMemberId] = nil	--释放该事件
		return self:MemberDel_GC(nKinId, nMemberId, 1)
	end
	--否则作为第一个响应的成员记录
	aThisKickEvent[nMemberId] = nExcutorId
end

function Kin:Member2Regular_GC(nKinId, nMemberId)
	local cKin = KKin.GetKin(nKinId)
	if not cKin then
		return 0
	end
	local cMember = cKin.GetMember(nMemberId)
	if not cMember then
		return 0
	end
	if cMember.GetFigure() ~= self.FIGURE_SIGNED then
		return 0
	end
	cMember.SetFigure(self.FIGURE_REGULAR)
	return GlobalExcute{"Kin:Member2Regular_GS2", nKinId, nMemberId}
end

function Kin:AddKinOffer_GC(nKinId, nMemberId, nOffer)
	local cKin = KKin.GetKin(nKinId);
	if (not cKin) then
		return 0;
	end
	if (not nOffer or nOffer <= 0) then
		return 0;
	end
	local cMember = cKin.GetMember(nMemberId);
	if (not cMember) then
		return 0;
	end

	cKin.AddKinOffer(nOffer);
	cKin.AddWeeklyKinOffer(nOffer);
	
	cMember.AddKinOffer(nOffer);
	cMember.AddWeeklyKinOffer(nOffer);
	
	GlobalExcute{"Kin:AddKinOffer_GS2", nKinId, nMemberId, nOffer};
end

function Kin:MemberKickCancel_GC(nKinId, nMemberId)
	local aThisKickEvent = self:GetKinData(nKinId).aKickEvent
	aThisKickEvent[nMemberId] = nil
	GlobalExcute{"Kin:MemberKickCancel_GS2", nKinId, nMemberId}
	return 0
end

function Kin:MemberRetire_GC(nKinId, nMemberId)
	local cKin = KKin.GetKin(nKinId)
	if not cKin then
		return 0
	end
	local cMember = cKin.GetMember(nMemberId)
	if not cMember then
		return 0
	end
	local nFigure = cMember.GetFigure()
	if nFigure == self.FIGURE_CAPTAIN then
		return 0
	end
	if cMember.GetFigure() > self.FIGURE_REGULAR then
		return 0
	end
	local n = 0.5;
	if cKin.GetBelongTong() ~= 0 then
		n = 1; 
	end
	local nRegular, nSigned, nRetireCount = cKin.GetMemberCount();
	if nRetireCount >= (nRegular + nSigned) * n then
		return 0;
	end	
	-- 首领不能退隐
	local nTongId = cKin.GetBelongTong();
	if Tong:IsPresident(nTongId, nKinId, nMemberId) == 1 then
		return 0;
	end
	
	if nFigure == self.FIGURE_ASSISTANT then
		cKin.SetAssistant(0);
	end
	cMember.SetFigure(self.FIGURE_RETIRE)
	cMember.SetEnvoyFigure(0);			-- 退隐删除掌令使职位
	cMember.SetBitExcellent(0);			-- 退隐删除精英
	local nTime = GetTime();
	cMember.SetRetireTime(nTime);		-- 记录申请退隐的时间
	
	local nPlayerId = cMember.GetPlayerId();
	local szMsg = string.format("[%s] trở thành thành viên ẩn gia tộc [%s]", KGCPlayer.GetPlayerName(nPlayerId), cKin.GetName());
	_G.KinLog(cKin.GetName(),  Log.emKKIN_LOG_TYPE_KINSTRUCTURE, szMsg);
	
	return GlobalExcute{"Kin:MemberRetire_GS2", nKinId, nMemberId, nTime}
end

-- 取消退隐
function Kin:CancelRetire_GC(nKinId, nMemberId)
	local cKin = KKin.GetKin(nKinId)
	if not cKin then
		return 0;
	end
	local cMember = cKin.GetMember(nMemberId)
	if not cMember then
		return 0
	end
	local nFigure = cMember.GetFigure()
	if nFigure ~= self.FIGURE_RETIRE then
		return 0;
	end
	if GetTime() - cMember.GetRetireTime() < self.CANCEL_RETIRE_TIME then
		return 0;
	end
	local nRegular, nSign = cKin.GetMemberCount();
	if nRegular + nSign >= self.MEMBER_LIMITED then		-- 到达人数上限，取消退隐失败
		return 0;
	end
	cMember.SetFigure(self.FIGURE_REGULAR);
	
	local nPlayerId = cMember.GetPlayerId();
	local szMsg = string.format("[%s] hủy bỏ làm thành viên ẩn gia tộc [%s]", KGCPlayer.GetPlayerName(nPlayerId), cKin.GetName());
	_G.KinLog(cKin.GetName(),  Log.emKKIN_LOG_TYPE_KINSTRUCTURE, szMsg);
	
	local nMemberCount = nRegular + nSign + 1;
	if cKin.GetRecruitmentPublish() == 1 and nMemberCount >= self.MEMBER_LIMITED then
		cKin.SetRecruitmentPublish(0);
	end
	
	return GlobalExcute{"Kin:CancelRetire_GS2", nKinId, nMemberId}
end

--更换称号
function Kin:ChangeTitle_GC(nKinId, nExcutorId, nTitleType, szTitle)
	local nRet, cKin = self:CheckSelfRight(nKinId, nExcutorId, 2)
	if nRet ~= 1 then
		return 0
	end
	--nTitleType + 1即为称号ID
	if cKin.SetBufTask(nTitleType + 1, szTitle) ~= 1 then
		return 0
	end
	return GlobalExcute{"Kin:ChangeTitle_GS2", nKinId, nTitleType, szTitle}
end

--更换阵营
function Kin:ChangeCamp_GC(nKinId, nExcutorId, nCamp)
	local nRet, cKin = self:CheckSelfRight(nKinId, nExcutorId, 1)
	if nRet ~= 1 then
		return 0
	end
	--有帮会则不能更改
	if cKin.GetBelongTong() ~= 0 then
		return 0
	end
	if cKin.SetCamp(nCamp) ~= 1 then
		return 0
	end
	-- 有可能没执行却扣了钱~写个LOG吧
	Dbg:WriteLog("Gia tộc","执行更换阵营", "Gia tộc ID:"..nKinId);
	self.nJourNum = self.nJourNum + 1;
	cKin.SetKinDataVer(self.nJourNum);
	local nDate = tonumber(Lib:GetLocalDay(GetTime()));
	cKin.SetChangeCampDate(nDate);
	return GlobalExcute{"Kin:ChangeCamp_GS2", self.nJourNum, nKinId, nCamp, nDate}
end

--设置副族长
function Kin:SetAssistant_GC(nKinId, nExcutorId, nMemberId)
	local nRet, cKin = self:CheckSelfRight(nKinId, nExcutorId, 1)
	if nRet ~= 1 then
		return 0
	end
	local cMember = cKin.GetMember(nMemberId)
	if not cMember then
		return 0
	end	
	local nOldAssistant = cKin.GetAssistant()
	if nOldAssistant ~= 0 then
		local cOldAssistant = cKin.GetMember(nOldAssistant)
		if cOldAssistant then
			cOldAssistant.SetFigure(self.FIGURE_REGULAR)
		end
	end
	cKin.SetAssistant(nMemberId)
	cMember.SetFigure(self.FIGURE_ASSISTANT)
	self.nJourNum = self.nJourNum + 1
	cKin.SetKinDataVer(self.nJourNum)
	
	--Log 记录
	local szAssistantName = KGCPlayer.GetPlayerName(cMember.GetPlayerId());
	local nCaptainId = cKin.GetCaptain();
	local cCaptain = cKin.GetMember(nCaptainId);
	local szCaptainName = KGCPlayer.GetPlayerName(cCaptain.GetPlayerId());
	local szMsg = string.format("%s được %s bổ nhiệm làm Tộc phó", szAssistantName, szCaptainName);
	KGCPlayer.PlayerLog(cMember.GetPlayerId(), Log.emKPLAYERLOG_TYPE_FAMILYAPPOINT, szMsg);
	
	return GlobalExcute{"Kin:SetAssistant_GS2", self.nJourNum, nKinId, nMemberId}
end

function Kin:FireAssistant_GC(nKinId, nExcutorId, nMemberId)
	local nRet, cKin = self:CheckSelfRight(nKinId, nExcutorId, 1)
	if nRet ~= 1 then
		return 0
	end
	if cKin.GetAssistant() ~= nMemberId then
		return 0
	end
	local cMember = cKin.GetMember(nMemberId)
	if not cMember then
		return 0
	end
	cMember.SetFigure(self.FIGURE_REGULAR)
	cKin.SetAssistant(0)
	
	--Log 记录
	local szAssistantName = KGCPlayer.GetPlayerName(cMember.GetPlayerId());
	local nCaptainId = cKin.GetCaptain();
	local cCaptain = cKin.GetMember(nCaptainId);
	local szCaptainName = KGCPlayer.GetPlayerName(cCaptain.GetPlayerId());

	local szMsg = string.format("%s bị %s thu hồi vị trí Tộc phó", szAssistantName, szCaptainName);
	KGCPlayer.PlayerLog(cMember.GetPlayerId(), Log.emKPLAYERLOG_TYPE_FAMILYAPPOINT, szMsg);
	
	return GlobalExcute{"Kin:FireAssistant_GS2", nKinId, nMemberId}
end

--更换族长（bPlayerAction是否玩家操作）
function Kin:ChangeCaptain_GC(nKinId, nExcutorId, nMemberId)
	local cKin = KKin.GetKin(nKinId)
	if not cKin then
		return 0
	end
	local bSys = 0;
	--系统执行
	if nExcutorId == -1 then
		bSys = 1
		nExcutorId = cKin.GetCaptain()
	end
	if nExcutorId == nMemberId then
		return 0
	end
	local cExcutor = cKin.GetMember(nExcutorId)
	
	local cMember = cKin.GetMember(nMemberId)
	if not cExcutor or not cMember then
		return 0
	end
	
	-- 如果族长是帮主，也记录到帮会事件上
	local nTongId = cKin.GetBelongTong();
	local szNewCaptain = KGCPlayer.GetPlayerName(cMember.GetPlayerId());
	local szOldCaptain = KGCPlayer.GetPlayerName(cExcutor.GetPlayerId());
	if nTongId then
		local pTong = KTong.GetTong(nTongId);
		if pTong then
			if pTong.GetMaster() == nKinId then
				pTong.AddAffairChangeMaster(szNewCaptain, szOldCaptain);
			end
		end
	end
	
	if cKin.GetAssistant() == nMemberId then
		cKin.SetAssistant(0)
	end
	if cKin.SetCaptain(nMemberId) ~= 1 then
		return 0
	end
	if cMember.SetFigure(self.FIGURE_CAPTAIN) ~= 1 then
		return 0
	end
	cExcutor.SetFigure(self.FIGURE_REGULAR)
	cKin.AddAffairChangeCaptain(szNewCaptain, szOldCaptain);
	self.nJourNum = self.nJourNum + 1;
	cKin.SetKinDataVer(self.nJourNum)
		
	if 0 == bSys then
		local nPlayerId = cExcutor.GetPlayerId();
		local nPrestige = KGCPlayer.GetPlayerPrestige(nPlayerId);
		if nPrestige < 10 then
			return 0
		end
		KGCPlayer.SetPlayerPrestige(nPlayerId, nPrestige - 10);
	end
	
	local szMsg = "";
	if bSys == 1 then
		--罢免选举成族长
		szMsg = string.format("[%s] Trở thành tộc trưởng trong cuộc bầu cử", KGCPlayer.GetPlayerName(cMember.GetPlayerId()));	
		KGCPlayer.PlayerLog(cMember.GetPlayerId(), Log.emKPLAYERLOG_TYPE_FAMILYAPPOINT, szMsg);		
	else
		--传位成族长
		local szExcutorMsg = string.format("[%s] được bổ nhiệm làm tộc trưởng, [%s] trở thành thành viên bình thường", 
							 KGCPlayer.GetPlayerName(cMember.GetPlayerId()), 
							 KGCPlayer.GetPlayerName(cExcutor.GetPlayerId()));
		szMsg = string.format("[%s] thay [%s] làm tộc trưởng",szNewCaptain,szOldCaptain);
		
		KGCPlayer.PlayerLog(cExcutor.GetPlayerId(), Log.emKPLAYERLOG_TYPE_FAMILYAPPOINT, szExcutorMsg);
		KGCPlayer.PlayerLog(cMember.GetPlayerId(), Log.emKPLAYERLOG_TYPE_FAMILYAPPOINT, szMsg);		
	end	

	-- Add KinLog
	_G.KinLog(cKin.GetName(),  Log.emKKIN_LOG_TYPE_KINSTRUCTURE,  szMsg);
	return GlobalExcute{"Kin:ChangeCaptain_GS2", self.nJourNum, nKinId, nExcutorId, nMemberId}
end

--发起罢免族长
function Kin:FireCaptain_Init_GC(nKinId, nExcutorId)
	local nRet, cKin, cExcutor = self:CheckSelfRight(nKinId, nExcutorId, 3)
	if nRet ~= 1 then
		return 0
	end
	local aKinData = self:GetKinData(nKinId)
	if aKinData.eveFireCaptain0 then
		return 0
	end
	aKinData.eveFireCaptain0 = nExcutorId
	Timer:Register(5*60*18, self.FireCaptain_Cancel, self, nKinId)
	return GlobalExcute{"Kin:FireCaptain_Init_GS2", nKinId, nExcutorId}
end

function Kin:FireCaptain_Cancel(nKinId)
	local aKinData = self:GetKinData(nKinId)
	aKinData.eveFireCaptain0 = nil
	aKinData.eveFireCaptain1 = nil
	GlobalExcute{"Kin:FireCaptain_Cancel_GS2", nKinId}
	return 0
end

function Kin:FireCaptain_Vote_GC(nKinId, nExcutorId)
	local nRet, cKin, cExcutor = self:HaveFigure(nKinId, nExcutorId, 3)
	if nRet ~= 1 then
		return 0
	end
	local aKinData = self:GetKinData(nKinId)
	if not aKinData.eveFireCaptain0 then
		return 0
	end
	local bLock
	--已经表决过
	if aKinData.eveFireCaptain0 == nExcutorId or aKinData.eveFireCaptain1 == nExcutorId then
		return 0
	end
	if not aKinData.eveFireCaptain1 then
		aKinData.eveFireCaptain1 = nExcutorId
	else --已有两个人表决
		aKinData.eveFireCaptain0 = nil
		aKinData.eveFireCaptain1 = nil
		cKin.SetCaptainLockState(1)
		bLock = 1;
	end
	local szPlayerName = KGCPlayer.GetPlayerName(cExcutor.GetPlayerId());
	KGCPlayer.PlayerLog(cExcutor.GetPlayerId(), Log.emKPLAYERLOG_TYPE_FAMILYAPPOINT, "["..szPlayerName.."]族长被罢免变成普通成员");
	
	return GlobalExcute{"Kin:FireCaptain_Vote_GS2", nKinId, nExcutorId, bLock}
end

--编辑公告
function Kin:SetAnnounce_GC(nKinId, nExcutorId, szAnnounce)
	local nRet, cKin = self:CheckSelfRight(nKinId, nExcutorId, 2)
	if nRet ~= 1 then
		return 0
	end
	if cKin.SetAnnounce(szAnnounce) ~= 1 then
		return 0
	end
	self.nJourNum = self.nJourNum + 1
	cKin.SetKinDataVer(self.nJourNum)
	return GlobalExcute{"Kin:SetAnnounce_GS2", self.nJourNum, nKinId, szAnnounce}
end

--族长竞选（启动单个家族的竞选）
function Kin:StartCaptainVote_GC(nKinId)
	local cKin = KKin.GetKin(nKinId)
	if not cKin then
		return 0
	end
	--竞选已启动，则不能再启动
	if cKin.GetVoteStartTime() ~= 0 then
		return 0
	end
	local nStartTime = GetTime()
	cKin.SetVoteStartTime(nStartTime)
	KKin.SendKinMail(nKinId, "Thông báo bỏ phiếu gia tộc", "Bỏ phiếu bầu tộc trưởng được thông qua, thành viên gia tộc qua giao diện gia tộc có thể bỏ phiếu!")
	return GlobalExcute{"Kin:StartCaptainVote_GS2", nKinId, nStartTime}
end

function Kin:StopCaptainVote_GC(nKinId)
	local cKin = KKin.GetKin(nKinId)
	if not cKin then
		return 1
	end
	cKin.SetVoteCounter(0)
	cKin.SetVoteStartTime(0)
	local itor = cKin.GetMemberItor()
	local cMember = itor.GetCurMember()
	local nMaxBallot = 0
	local nCurMaxMember = 0
	local nCurJourNum = 0
	while cMember do
		local nBallot = cMember.GetBallot()
		if nBallot > nMaxBallot or (nBallot == nMaxBallot and cMember.GetVoteJourNum() < nCurJourNum) then
			nMaxBallot = nBallot
			nCurMaxMember = itor.GetCurMemberId()
			nCurJourNum = cMember.GetVoteJourNum()
		end
		--清空投票数据
		cMember.SetBallot(0)
		cMember.SetVoteState(0)
		cMember.SetVoteJourNum(0)
		
		cMember = itor.NextMember()
	end
	if nCurMaxMember > 0 then
		Kin:ChangeCaptain_GC(nKinId, -1, nCurMaxMember)
	end
	--解除族长锁定状态
	cKin.SetCaptainLockState(0)
	return GlobalExcute{"Kin:StopCaptainVote_GS2", nKinId, nCurMaxMember, nMaxBallot}
end

--族长竞选投票
function Kin:CaptainVoteBallot_GC(nKinId, nExcutorId, nMemberId)
	local nRet, cKin, cMemberExcutor = self:HaveFigure(nKinId, nExcutorId, 3)
	if nRet ~= 1 then
		return 0
	end
	local nVoteStartTime = cKin.GetVoteStartTime()
	if nVoteStartTime == 0 then
		return 0
	end
	if cMemberExcutor.GetVoteState() == nVoteStartTime then
		return 0
	end
	cMemberExcutor.SetVoteState(nVoteStartTime)
	--江湖威望作为票数
	local nBallot = KGCPlayer.GetPlayerPrestige(cMemberExcutor.GetPlayerId());
	if nBallot <= 0 then
		return 0
	end
	local cTargetMember = cKin.GetMember(nMemberId)
	if not cTargetMember or cTargetMember.GetFigure() > self.FIGURE_REGULAR then
		return 0
	end
	local nVoteCounter = cKin.GetVoteCounter() + 1
	cKin.SetVoteCounter(nVoteCounter)
	cTargetMember.AddBallot(nBallot)
	--记录投票序号
	cTargetMember.SetVoteJourNum(nVoteCounter)
	return GlobalExcute{"Kin:CaptainVoteBallot_GS2", nKinId, nExcutorId, nMemberId, nBallot, nVoteCounter}
end

function Kin:JoinTong_GC(nKinId, szTong, nTongId, nCamp, bSync)
	local cKin = KKin.GetKin(nKinId)
	if not cKin then
		return 0
	end
	-- add Tonglog JoinTong
	local szMsg = string.format("[%s] Gia tộc vào bang hội", cKin.GetName());
	_G.TongLog(szTong, Log.emKTONG_LOG_TONGSTRUCTURE , szMsg);
	
	cKin.SetLastCamp(cKin.GetCamp())
	cKin.SetBelongTong(nTongId)
	cKin.SetCamp(nCamp)
	cKin.AddHistoryJoinTong(szTong);
	if bSync then
		return GlobalExcute{"Kin:JoinTong_GS2", nKinId, szTong, nTongId, nCamp}
	end
	return 1
end

function Kin:ApplyQuitTong_GC(nTongId, nKinId, nExcutorId)
	local nRet, cKin, cExcutor = self:CheckSelfRight(nKinId, nExcutorId, 1);
	if nRet ~= 1 then
		return 0
	end
	if cKin.GetApplyQuitTime() ~= 0 then
		return 0;
	end
	local nCurTime =GetTime();
	cKin.SetApplyQuitTime(nCurTime);
	return GlobalExcute{"Kin:ApplyQuitTong_GS2", nKinId, nCurTime};
end

function Kin:FailedQuitTong_GC(nKinId, nSuccess)
	return self:CloseQuitTong_GC(nKinId, nSuccess);
end

--关闭退出帮会的投票状态
--注意：nSuccess 为0；没通过,反对人数足够多，2为 族长取消）
function Kin:CloseQuitTong_GC(nKinId, nSuccess)
	local cKin = KKin.GetKin(nKinId);
	if not cKin then 
		return 0;
	end
	cKin.SetApplyQuitTime(0);
	local cMemberItor = cKin.GetMemberItor();
	local cCurMember = cMemberItor.GetCurMember();
	while cCurMember do
		cCurMember.SetQuitVoteState(0);		-- 清空各个成员的投票状态
		cCurMember = cMemberItor.NextMember()
	end
	GlobalExcute{"Kin:CloseQuitTong_GS2", nKinId, nSuccess};
	return 1;
end

-- 成员表决退出帮会
function Kin:QuitTongVote_GC(nKinId, nMemberId, nAccept)
	local cKin = KKin.GetKin(nKinId);
	if not cKin then 
		return 0;
	end
	if cKin.GetApplyQuitTime() == 0 then
		return 0;
	end
	local cMember = cKin.GetMember(nMemberId);
	if not cMember then 
		return 0;
	end
	if cMember.GetQuitVoteState() ~= 0 then
		return 0;
	end
	cMember.SetQuitVoteState((nAccept == 1) and 1 or 2);
	return GlobalExcute{"Kin:QuitTongVote_GS2", nKinId, nMemberId, nAccept};
end
function Kin:LeaveTong_GC(nTongId, nKinId, nMethod, bSync)
	local cKin = KKin.GetKin(nKinId)
	if not cKin then
		return 0
	end
	
--	local nLastCamp = cKin.GetLastCamp()
--	if nLastCamp ~= 0 then
--		cKin.SetCamp(nLastCamp)
--	end
	--清空帮会相关数据
	cKin.SetBelongTong(0)
	cKin.SetTongFigure(0)
	cKin.SetTongVoteBallot(0)
	cKin.SetTongVoteJourNum(0)
	cKin.SetTongVoteState(0)
	
	-- 股份处理
	local pTong = KTong.GetTong(nTongId);
	if not pTong then
		return 0;
	end
	local nBuildFund = pTong.GetBuildFund()
	local nTotalStock = pTong.GetTotalStock();
	local nPrice = 0;
	if nBuildFund > 0 and nTotalStock > 0 then
		nPrice = nBuildFund / nTotalStock;		-- 计算股价
	end
	--清空成员帮会相关数据
	local cMemberItor = cKin.GetMemberItor()
	local cMember = cMemberItor.GetCurMember()
	local tbResult = {};
	local nReduceFund = 0;
	while cMember do
		cMember.SetTongFlag(0);
		cMember.SetEnvoyFigure(0);
		cMember.SetWageFigure(0);
		cMember.SetWageValue(0);
		cMember.SetStockFigure(Tong.NONE_STOCK_RIGHT);
		local nPersonalStock = cMember.GetPersonalStock()
		local nMemberFund = math.floor(nPersonalStock * nPrice)
		local nNewStock = math.floor(nMemberFund * Tong.QUIT_REDUCE_STOCK)
		tbResult[cMemberItor.GetCurMemberId()] = nNewStock		-- 记录结果
		cMember.SetPersonalStock(nNewStock);		-- 无帮会的成员股票数等于资产，即股价恒为1
		nBuildFund = nBuildFund - nMemberFund;		-- 总资减少
		nReduceFund = nReduceFund + nMemberFund
		nTotalStock = nTotalStock - nPersonalStock;	-- 总股票减少
		local nPlayerId = cMember.GetPlayerId();
		cMember = cMemberItor.NextMember();
	end
	if nBuildFund < 0 then
		nBuildFund = 0;
	end
	if nTotalStock < 0 then
		nTotalStock = 0;
	end
	pTong.SetBuildFund(nBuildFund);
	pTong.SetTotalStock(nTotalStock);
	self:CloseQuitTong_GC(nKinId);	-- 关闭该家族的退出投票状态（如果存在的话）
	GlobalExcute{"Kin:LeaveTong_GS2", nTongId, nKinId, nMethod, nBuildFund, nTotalStock, tbResult, bSync or 1};
	return nReduceFund;
end

function Kin:SetSelfQuitVoteState_GC(nKinId, nMemberId, nVoteState)
	local cKin = KKin.GetKin(nKinId);
	if not cKin then
		return 0;
	end
	local cMember = cKin.GetMember(nMemberId);
	if not cMember then
		return 0;
	end
	cMember.SetQuitVoteState(nVoteState);
end

function Kin:AddKinTotalRepute_GC(nKinId, nMemberId, nPlayerId, nRepute)
	KGCPlayer.SetPlayerPrestige(nPlayerId, KGCPlayer.GetPlayerPrestige(nPlayerId) + nRepute);
	local pKin = KKin.GetKin(nKinId);
	if pKin then
		pKin.AddTotalRepute(nRepute);
		self.nJourNum = self.nJourNum + 1
		pKin.SetKinDataVer(self.nJourNum);
	end
	GlobalExcute{"Kin:AddKinTotalRepute_GS2", nKinId, nMemberId, nPlayerId, nRepute, self.nJourNum};
end

-- 增加古银币
function Kin:AddGuYinBi_GC(nKinId, nAddGuYinBi)
	local pKin = KKin.GetKin(nKinId);
	if not pKin then
		return 0;
	end
	if nAddGuYinBi <= 0 then
		return 0;
	end
	local nCurGuYinBi = pKin.GetKinGuYinBi();
	if nCurGuYinBi + nAddGuYinBi > self.MAX_GU_YIN_BI then
		nAddGuYinBi = self.MAX_GU_YIN_BI - nCurGuYinBi;
	end
	if nAddGuYinBi > 0 then
		pKin.AddKinGuYinBi(nAddGuYinBi);
	end
	GlobalExcute{"Kin:AddGuYinBi_GS2", nKinId, nCurGuYinBi + nAddGuYinBi, nAddGuYinBi};
end

-- 衰减威望
function Kin:DecreasePrestige()
	KGCPlayer.StartSortPrestige(1);
end

-- 保存插旗的时间和地点
function Kin:SaveBuildFlagSetting_GC(nPlayerId, nKinId, nTime, nMapId, nMapX, nMapY)
	-- 判断时间是否正确
	local nBeginTime		= 19 * 60 + 30	-- 允许使用的开始时间
	local nEndTime			= 23 * 60 + 30	-- 允许使用的结束时间
	if nTime < nBeginTime or nTime > nEndTime then
		return 0;
	end	
	
	local cKin = KKin.GetKin(nKinId);
	if not cKin then
		return 0
	end
	

	-- 记录插旗时间
	cKin.SetKinBuildFlagOrderTime(nTime);
	-- 记录插旗地点
	cKin.SetKinBuildFlagMapId(nMapId);
	cKin.SetKinBuildFlagMapX(nMapX);
	cKin.SetKinBuildFlagMapY(nMapY);
	
	-- 记录今天已经插旗 （因为nTime只是记录时间，没有日期，所以要再取）
	local nNowDay = tonumber(os.date("%m%d", GetTime()));
	cKin.SetTogetherTime(nNowDay);
	--print("Kin"..nKinId..",BuildFlag_GC——TogetherTime"..nNowDay);
	GlobalExcute{"Kin:SaveBuildFlagSetting_GS2", nPlayerId, nKinId, nTime, nMapId, nMapX, nMapY};
end


-- 修改家族令牌的KinExpstate,使玩家能再领家族令牌
function Kin:ChangeKinExpState_GC(nPlayerId, nKinId, nMemberId)
	local nRet, cKin = self:CheckSelfRight(nKinId, nMemberId, 2); 
	if nRet ~= 1 then
		Dbg:WriteLog("Kin", "修改家族令牌时权限不足", "玩家姓名："..KGCPlayer.GetPlayerName(nPlayerId));
		return 0;
	end
	

	local nTime = GetTime();
	local nNowDay = tonumber(os.date("%m%d", nTime));

	-- 如果今天已经领过了
	if cKin.GetGainExpState() == nNowDay then
		Dbg:WriteLog("Kin", "修改家族令牌时发现今天已经领过了家族令牌",  "玩家姓名："..KGCPlayer.GetPlayerName(nPlayerId));
		return 0;
	end
	
	-- 如果已经给过钱了还没设时间或者是第一次领令牌
	if cKin.GetKinBuildFlagOrderTime() == 0 then
		Dbg:WriteLog("Kin", "修改家族令牌时发现已经给过钱了还没设时间或者是第一次领令牌",  "玩家姓名："..KGCPlayer.GetPlayerName(nPlayerId));
		return 0;
	end

	cKin.SetGainExpState(nNowDay);
	cKin.SetKinBuildFlagOrderTime(0);
	
	GlobalExcute{"Kin:ChangeKinExpState_GS2", nPlayerId, nKinId};
end


-- 领取家族令牌
function Kin:GetKinLingPai_GC(nKinId, nMemberId)
	local nRet, cKin = self:CheckSelfRight(nKinId, nMemberId, 2);
	if nRet ~= 1 then
		return 0;
	end
	

	local nTime = GetTime();
	local nNowDay = tonumber(os.date("%m%d", nTime));
	
	if cKin.GetGainExpState() == nNowDay then	--已经领取过了
		return 0;
	end
	
	local nPlayerId = cKin.GetMember(nMemberId).GetPlayerId();
	
	if not nPlayerId then
		return 0;
	end
	
	cKin.SetGainExpState(nNowDay);
	GlobalExcute{"Kin:GetKinLingPai_GS2", nKinId, nPlayerId};
end
-- 1.白虎堂 2.宋金 3. 通缉 4. 逍遥谷 5. 军营
Kin.tbWeeklyAction = {
	{1, 2, 3,},	-- 50级周目标任务
	{1, 2, 3, 4,},	-- 80级的周目标任务
	{1, 2, 3, 4, 5,},	-- 90级的周目标任务
	};

function Kin:PerKinWeeklyTask_GC(cKin, nKinId)
	if (not cKin) then
		return;
	end
	if (cKin.GetBelongTong() ~= 0) then
		return 0;	-- 有帮会的家族不对家族进行处理
	end
	Kin:StatisticsWeeklyTaskLevel(cKin);
	-- 为家族随机周任务，并且把周任务记录到家族当中
	local nWeeklyTask = self:RandWeeklyAction(cKin);
	if (not nWeeklyTask or nWeeklyTask == 0) then
		return;
	end
	-- 记录家族上周的贡献度，并把本周贡献度清零
	local nOffer = cKin.GetWeeklyKinOffer();
	cKin.SetWeeklyKinOffer(0);
	cKin.SetLastWeekKinOffer(nOffer);
	cKin.SetIsCaptainGetAward(0);
	-- 记录下上周的活动目标
	local nTaskTemp = cKin.GetWeeklyTask();
	cKin.SetLastWeeklyTask(nTaskTemp);
	cKin.SetWeeklyTask(nWeeklyTask);
	local nTaskLevel = cKin.GetTaskLevel();
	Kin:PerKinMemberWeeklyTask(cKin);
	GlobalExcute{"Kin:PerKinWeeklyTask_GS2", nKinId, nOffer, nTaskTemp, nTaskLevel, nWeeklyTask};
end

-- 获取家族周目标等级
function Kin:GetWeeklyTaskLevel(cKin)
	-- local cKin = self.PerKinWeekly_cNextKin;
	if (not cKin) then
		return 0;
	end
	local nMinLevel = cKin.GetNewTaskLevel();
	if (nMinLevel == 0) then
		nMinLevel = cKin.GetTaskLevel();
		if (nMinLevel == 0) then
			nMinLevel = Kin.TASK_LEVEL_LOW;
			cKin.SetTaskLevel(Kin.TASK_LEVEL_LOW);	-- 家族的默认周目标等级是50
		end
	elseif (nMinLevel ~= 0) then
		cKin.SetNewTaskLevel(0);
		cKin.SetTaskLevel(nMinLevel);	-- 把新的周任务目标等级生效
	end
	nMinLevel = cKin.GetTaskLevel();
	return nMinLevel;
end

-- 根据家族的周任务目标等级随机可以执行的周任务
function Kin:RandWeeklyAction(cKin)
	-- local cKin = self.PerKinWeekly_cNextKin;
	local nLastAction = 0;
	local nLastAction = cKin.GetWeeklyTask();
	local nTaskLevel = self:GetWeeklyTaskLevel(cKin);
	if (nTaskLevel == Kin.TASK_LEVEL_LOW) then
		nTaskLevel = 1;
	elseif (nTaskLevel == Kin.TASK_LEVEL_MID) then
		nTaskLevel = 2;
	elseif (nTaskLevel == Kin.TASK_LEVEL_HIGH) then
		nTaskLevel = 3;
	else
		return 0;
	end
	local nWeeklyAction = MathRandom(#self.tbWeeklyAction[nTaskLevel]);
	while nLastAction == nWeeklyAction do	-- 本周任务要和上周任务不同
		nWeeklyAction = MathRandom(#self.tbWeeklyAction[nTaskLevel]);
	end
	if (not nWeeklyAction or nWeeklyAction < 1 or nWeeklyAction > #self.tbWeeklyAction[nTaskLevel]) then
		return 0;
	end
	if (nWeeklyAction == 1 or nWeeklyAction == 2 or nWeeklyAction == 3) then
		return nWeeklyAction;
	elseif (nWeeklyAction == 4 and nTaskLevel >= 2) then
		return nWeeklyAction;
	elseif (nWeeklyAction == 5 and nTaskLevel == 3) then
		return nWeeklyAction;
	else
		return 0;
	end
end

function Kin:SetNewTaskLevel_GC(nKinId , nTaskLevel)
	local cKin = KKin.GetKin(nKinId);
	if (not cKin) then
		return 0;
	end
	cKin.SetNewTaskLevel(nTaskLevel);
	GlobalExcute{"Kin:SetNewTaskLevel_GS2", nKinId , nTaskLevel};
end

function Kin:SetLWKinOffer0_GC(nKinId, nMemberId, nFigure)
	local cKin = KKin.GetKin(nKinId);
	if (not cKin) then
		return 0;
	end
	if (nFigure == 2 and cKin.GetIsCaptainGetAward() == 0) then
		cKin.SetIsCaptainGetAward(1);
	end
	local cMember = cKin.GetMember(nMemberId);
	if (not cMember) then
		return 0;
	end
	cMember.SetLastWeekKinOffer(0);
	GlobalExcute{"Kin:SetLWKinOffer0_GS2", nKinId, nMemberId, nFigure};
end

-- 在第一次gamecenter启动的时候，把家族周活动的流水号初始化为当前周的正确值
function Kin:InitKinWeeklyNo()
	if (0 == KGblTask.SCGetDbTaskInt(DBTASK_KIN_WEEKLYACTION_NO)) then
		local nCurNo = tonumber(os.date("%Y%W", GetTime()));
		KGblTask.SCSetDbTaskInt(DBTASK_KIN_WEEKLYACTION_NO, nCurNo);
	end
end
GCEvent:RegisterGCServerStartFunc(Kin.InitKinWeeklyNo, Kin);

-- 发布\取消招募
function Kin:RecruitmentPublish_GC(nKinId, nMemberId, nPublish, nLevel, nHonour)
	local pKin = KKin.GetKin(nKinId);
	if not pKin then
		return 0;
	end
	if Kin:CheckSelfRight(nKinId, nMemberId, 2) ~= 1 then
		return 0;
	end
	if pKin.GetMemberCount() >= self.MEMBER_LIMITED then
		return 0;
	end
	if nPublish then
	 	pKin.SetRecruitmentPublish(nPublish);
	end
	if nLevel then
	 	pKin.SetRecruitmentLevel(nLevel);
	end
	if nHonour then
	 	pKin.SetRecruitmentHonour(nHonour);
	end
	
	pKin.SetRecruitmentPublish(nPublish);
	pKin.SetRecruitmentPublishTime(GetTime());
	GlobalExcute{"Kin:RecruitmentPublish_GS2", nKinId, nPublish, nLevel, nHonour};
end

-- 同意招募
function Kin:RecruitmentAgree_GC(nSelfKinId, nSelfMemberId, szName, nKinId)
	local pSelfKin = KKin.GetKin(nSelfKinId);
	if not pSelfKin then
		return 0;
	end
	if Kin:CheckSelfRight(nSelfKinId, nSelfMemberId, 2) ~= 1 then
		return 0;
	end
	local nRegular, nSigned, nRetire = pSelfKin.GetMemberCount();
	local nMemberCount = nRegular + nSigned;
	if nMemberCount >= self.MEMBER_LIMITED then
		return 0;
	end
	local nPlayerId = KGCPlayer.GetPlayerIdByName(szName);
	if not nPlayerId or nPlayerId <= 0 then
		return 0;
	end
	local nKinId = KGCPlayer.GetKinId(nPlayerId)
	local pKin = KKin.GetKin(nKinId);
	if pKin then
		return 0;
	end
	GlobalExcute{"Kin:RecruitmentAgree_GS2", nSelfKinId, nSelfMemberId, szName, nPlayerId};
end

-- 拒绝招募
function Kin:RecruitmentReject_GC(szName, nKinId, nMemberId)
	local pKin = KKin.GetKin(nKinId)
	if not pKin then
		return 0;
	end
	if Kin:CheckSelfRight(nKinId, nMemberId, 2) ~= 1 then
		return 0;
	end
	local nPlayerId = KGCPlayer.GetPlayerIdByName(szName);
	if not nPlayerId or nPlayerId <= 0 then
		return 0;
	end
	KKin.DelKinInductee(nKinId, szName);
	
	GlobalExcute{"Kin:RecruitmentReject_GS2", szName, nKinId, nMemberId};
end

-- 加入招募榜
function Kin:JoinRecruitment_GC(nKinId, nPlayerId)
	local pKin = KKin.GetKin(nKinId);
	if not pKin then
		return 0;
	end
	local nPublish =  pKin.GetRecruitmentPublish();
	if nPublish == 0 then
		return;
	end
	local nRegular, nSigned, nRetire = pKin.GetMemberCount();
	local nMemberCount = nRegular + nSigned;
	if nMemberCount >= self.MEMBER_LIMITED then
		return 0;
	end
	local szName = KGCPlayer.GetPlayerName(nPlayerId);
	if not szName then
		return 0;
	end
	if KKin.GetKinInducteeJoinTime(nKinId, szName) then
		return 0;
	end 
	
	local nTime = GetTime();

	KKin.AddKinInductee(nKinId, nTime, szName);	

	GlobalExcute{ "Kin:JoinRecruitment_GS2", nKinId, nPlayerId, nTime, szName};
end

-- 每日清理家族超时应聘者
function Kin:KinRecruitmenClean(nKinId)
	local nCurTime = GetTime();
	local tbDelKinInducteeList = {};
	if not nKinId or nKinId == 0 then
		return 0;
	end
	local tbKeyList = KKin.GetKinInducteeKeyList(nKinId)
	if not tbKeyList then 
		return 0;
	end
	for i, nKey in pairs(tbKeyList) do
		local szName, nJoinTime = KKin.GetKinInductee(nKinId, nKey);
		if nCurTime - nJoinTime > 7 * 24 * 60 * 60 then
			KKin.DelKinInductee(nKinId, szName);
			table.insert(tbDelKinInducteeList, szName);
		end
	end
	
	GlobalExcute{ "Kin:KinRecruitmenClean_GS2", nKinId, tbDelKinInducteeList};
end

-- 每次打开清理有家族的应聘者
function Kin:KinInducteeClean_GC(nKinId)
	local tbDelKinInducteeList = {};
	local tbKeyList = KKin.GetKinInducteeKeyList(nKinId)
	if not tbKeyList then  -- 程序传不过来 加保护zounan
		return;
	end
	
	for i, nKey in pairs(tbKeyList) do
		local szName, nJoinTime = KKin.GetKinInductee(nKinId, nKey);
		local nPlayerId = KGCPlayer.GetPlayerIdByName(szName);
		local nTagetKinId = KGCPlayer.GetKinId(nPlayerId);
		local pTagetKin = KKin.GetKin(nTagetKinId);
		if pTagetKin and nTagetKinId ~= 0 then
			KKin.DelKinInductee(nKinId, szName);
			table.insert(tbDelKinInducteeList, szName);
		end
	end
	GlobalExcute{ "Kin:KinRecruitmenClean_GS2", nKinId, tbDelKinInducteeList};
end

-- 每周清理家族招募榜
function Kin:CleanKinRecruitmenPublish(nKinId)
	local nCurTime = GetTime();
	if nCurTime < os.time({year=2010, month=1, day=17}) then		-- 1月12日前发布的家族招募榜的给7天发布期
		return
	end
	local pCurKin = KKin.GetKin(nKinId);
	if not pCurKin then
		return;
	end
	if pCurKin.GetRecruitmentPublish() == 0 then
		return;
	end
    if nCurTime - pCurKin.GetRecruitmentPublishTime() > self.KIN_RECRUITMENT_PUBLISH_TIME then
        pCurKin.SetRecruitmentPublish(0);
        GlobalExcute{ "Kin:CleanKinRecruitmenPublish_GS2", nKinId};
    end
end
