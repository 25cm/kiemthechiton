-- Gamecenter事件

local MAX20E = 2000000000;

function GCEvent:OnGCExcute(tbCall)
	print("OnGCExcute", unpack(tbCall));
	Lib:CallBack(tbCall);
end

function GCEvent:OnGBGCExcute(tbCall, nConnectId)
	print("OnGBGCExcute", "From ConnectId:"..nConnectId, unpack(tbCall));
	self.nGBGCExcuteFromId = nConnectId;
	Lib:CallBack(tbCall);
	self.nGBGCExcuteFromId = nil;
end

-- Gamecenter初始化完毕
function GCEvent:OnGCInited()
	TimeFrame:SaveStartServerTime();	--第一次启动服务器时,自动记录开服时间;
	TimeFrame:Init();					--时间轴初始化;
	Task.tbHelp:LoadDynamicNewsGC();	--加载动态消息
	Player:SetMaxLevelGC();				--最大等级设置;
	EventManager.EventManager:Init();	--活动系统初始化;
	-- 执行服务器启动函数
	if self.tbStartFun then
		for i, tbStart in ipairs(self.tbStartFun) do
			tbStart.fun(unpack(tbStart.tbParam));
		end
	end
end

--普通服务器启好连接上全局服务器时的回调(普通服务器和全局服务器都有)
function GCEvent:OnGlobalConnect(nConnectId)
	
	--已经注册的启好后给全局服务器回调
	if not GLOBAL_AGENT then
		if self.tbConnectGBGCServerFun then
			self.nConnectGBGCServerFunCount = 0;
			Timer:Register(1, GCEvent.OnConnectGBGCServerFun, GCEvent, nConnectId);
		end		
	end
	
end

function GCEvent:OnConnectGBGCServerFun(nConnectId)
	if self.nConnectGBGCServerFunCount > 1800 then
		print("Error!!!", "Can't Not GetGatewayName!!");
		return 0;
	end
	if GetGatewayName() == "" then
		self.nConnectGBGCServerFunCount = self.nConnectGBGCServerFunCount + 1;
		return 1;
	end
	if self.tbConnectGBGCServerFun then
		for i, tbStart in ipairs(self.tbConnectGBGCServerFun) do
			local tbCallBack = {unpack(tbStart)};
			table.insert(tbCallBack, nConnectId);
			--GC_AllExcute(tbCallBack);
			Lib:CallBack(tbCallBack);
		end
	end
	return 0;
	
end

-- Gamecent正常关闭时调用
function GCEvent:OnGCUnit()
	-- 执行服务器关闭函数
	print("GCEvent:OnGCUnit");
	if self.tbShutDownFun then
		for i, tbShutDown in ipairs(self.tbShutDownFun) do
			tbShutDown.fun(unpack(tbShutDown.tbParam));
		end
	end	
end

-- 注册普通服务器连上全局服务器时本服回调执行函数(回调第一个参数为nConnectId连接号)
-- 例子：GCEvent:RegisterConnectGBGCServerFunc({"GbWlls:SendMyWllsSession"})
function GCEvent:RegisterConnectGBGCServerFunc(tbStartFun)
	if GLOBAL_AGENT then
		return
	end
	if not self.tbConnectGBGCServerFun then
		self.tbConnectGBGCServerFun = {}
	end
	table.insert(self.tbConnectGBGCServerFun, tbStartFun);
end

-- 注册服务器启动执行函数
function GCEvent:RegisterGCServerStartFunc(fnStartFun, ...)
	if not self.tbStartFun then
		self.tbStartFun = {}
	end
	table.insert(self.tbStartFun, {fun=fnStartFun, tbParam=arg});
end

-- 注册服务器正常关闭执行函数
function GCEvent:RegisterGCServerShutDownFunc(fnShutDownFun, ...)
	if not self.tbShutDownFun then
		self.tbShutDownFun = {}
	end
	table.insert(self.tbShutDownFun, {fun=fnShutDownFun, tbParam=arg});
end

function GCEvent:OnCoZoneStepSubZone()	
	--KJbExchange.DelAllBill();
	self:CozoneFactionElecet_Load();
	self.tbWllsLeagueList = Wlls:_GetWllsLeague();
	self.nCoZoneSubZoneTax = KGblTask.SCGetDbTaskInt(DBTASK_TRADE_CUR_TAX);
	self.nCoZoneSubZoneCoinPlayer = KGblTask.SCGetDbTaskInt(DBTASK_COIN_EXCHANGE_PAYER) * 0.9;
	self.nCoZoneSubZoneCoinPlayerRecent = KGblTask.SCGetDbTaskInt(DBTASK_COIN_EXCHANGE_PAYER_RECENT) * 0.9;
	self.nCoZoneSubZoneBaiBaoxiangCaichi	= KGblTask.SCGetDbTaskInt(DBTASK_BAIBAOXIANG_CAICHI);
	self.nCoZoneSubZoneBaZhuZhiYinMaxCount	= KGblTask.SCGetDbTaskInt(DBTASK_BAZHUZHIYIN_MAX);
	self.szCoZoneSubZoneBaZhuZhiYinMaxName	= KGblTask.SCGetDbTaskStr(DBTASK_BAZHUZHIYIN_MAX);
	self.nCoZoneSubZoneBaZhuZhiYinState 	= KGblTask.SCGetDbTaskInt(DBTASK_DOMAIN_BATTLE_STEP);
	self.bCoZoneSubZoneBaZhuZhiYinGetTongAward = Domain:IsGetTongAward();
	Domain:CozoneDomain_Deal()
	self.tbCoZoneStatuData = {}
	self:OnCoZoneStatuary_Load();
	self.tbCoZoneGirlGblBuf	= GetGblIntBuf(GBLINTBUF_GIRL_VOTE, 0, 1);
	self.tbCoZoneCompensateGmBuf = GetGblIntBuf(GBLINTBUF_COMPENSATE_GM, 0, 1); --离线指令
	self.tbCoZoneKingeyesEventBuf = GetGblIntBuf(GBLINTBUF_KINGEYES_EVENT, 0, 1); --活动指令
	self.tbCoZoneArrestListBuf = GetGblIntBuf(GBLINTBUF_ARREST_LIST, 0, 1); --批量关天牢
	self.tbCoZoneBlackListBuf = GetGblIntBuf(GBLINTBUF_BLACKLIST, 0, 1); -- 非法刷道具玩家及其所得道具名单
	self.tbCoZoneIBShopListBuf = GetGblIntBuf(GBLINTBUF_IBSHOP, 0, 1); -- 奇珍阁物品上下架状态
	self.tbCoZoneWldhMemberListBuf = GetGblIntBuf(GBLINTBUF_WLDH_MEMBER, 0, 1); -- 武林大会资格认定
	self.tbCoZoneVipTransferBuf = GetGblIntBuf(GBLINTBUF_VIP_TRANSFER, 0, 1); -- vip转服
	-- marrry
	self.tbCoZonePropopalBuf = GetGblIntBuf(GBLINTBUF_PROPOSAL, 0, 1);	-- 解除订婚
	self.tbCoZoneMarryBuf = GetGblIntBuf(GBLINTBUF_MARRY, 0, 1);		-- 预定婚期
	-- end
	
	-- 子服开服时间记录，用于计算两服开服相差时间
	if not self.nSubServerStartTime then
		self.nSubServerStartTime = 0;
	end
	self.nSubServerStartTime = KGblTask.SCGetDbTaskInt(DBTASD_SERVER_STARTTIME);
	print("SubZoneStartTime", self.nSubServerStartTime);
	return 1;
end

function GCEvent:OnCoZoneStatuary_Load()
	self.tbCoZoneStatuData = {};
	local tbLoadBuf = GetGblIntBuf(GBLINTBUF_DOMAINSTATUARY, 0, 1);
	if (not tbLoadBuf) then
		return;
	end
	
	for _, tbInfo in pairs(tbLoadBuf) do
		local tbIn = {};
		tbIn.tbPlayerInfo = tbInfo;
		self.tbCoZoneStatuData[#self.tbCoZoneStatuData + 1] = tbIn;
	end
end

function GCEvent:OnCoZoneStepMainZone()
	print("GCEvent:OnCoZoneStepMainZone");
	--KJbExchange.DelAllBill();
	self:CozoneFactionElecet_Load();
	Union:DisbandAllUnion_GC();
	self.nCoZoneMainZoneBaZhuZhiYinState = KGblTask.SCGetDbTaskInt(DBTASK_DOMAIN_BATTLE_STEP);
	self.bCoZoneMainZoneBaZhuZhiYinGetTongAward = Domain:IsGetTongAward();
	Domain:CozoneDomain_Deal()
	-- 记录主服开服时间
	local nMainServerStartTime = KGblTask.SCGetDbTaskInt(DBTASD_SERVER_STARTTIME);
	print("MainZoneStartTime", nMainServerStartTime);
	-- 计算两服开服相差时间
	local nServerTimeDistance = math.abs(self.nSubServerStartTime - nMainServerStartTime);
	if self.nSubServerStartTime < nMainServerStartTime then
		error("Error: SubZone is Earlier than MainZone!!!");
		return 0;
	end
	-- 记录两服开服相差时间
	KGblTask.SCSetDbTaskInt(DBTASK_SERVER_STARTTIME_DISTANCE, nServerTimeDistance);
	-- 领土战编号记录，用于标识合服后开的第一场做判断
	local nBattleNo = KGblTask.SCGetDbTaskInt(DBTASK_DOMAIN_BATTLE_NO);
	KGblTask.SCSetDbTaskInt(DBTASK_COZONE_DOMAIN_BATTLE_NO, nBattleNo);
	
	return 1;
end

function GCEvent:OnCoZoneStepCombinedSub()
	print("GCEvent:OnCoZoneStepCombinedSub");
	-- 门派选举数据合并
	self:CozoneFactionElecet_Merge();
	Union:DisbandAllUnion_GC();
	
	
	-- 联赛数据合并
	Ladder:LoadTotalLadders();
	Wlls:_SetWllsLeague(Wlls.LGTYPE, self.tbWllsLeagueList);
	-- 清除联赛历史榜
	for i=0, 12 do
		local tbNowLadder = GetShowLadder(Ladder:GetType(0, 3, 4, i));
		if tbNowLadder then
			DelShowLadder(Ladder:GetType(0, 3, 4, i));
		end
		
		tbNowLadder = GetShowLadder(Ladder:GetType(0, 3, 5, i));
		if tbNowLadder then
			DelShowLadder(Ladder:GetType(0, 3, 5, i));
		end
	end
	-- 排行榜重排
	Ladder:LoadLevelLadder() -- 等级排行榜
	PlayerHonor:OnSchemeLoadFactionHonorLadder(); -- 门派荣誉排行榜
	PlayerHonor:OnSchemeUpdateSongJinBattleHonorLadder();	-- 宋金荣誉排行榜
	Wlls:UpdateWllsHonorLadder();
	
	PlayerHonor:UpdateWuLinHonorLadder();	-- 武林荣誉排行榜
	PlayerHonor:UpdateMoneyHonorLadder();	-- 财富荣誉排行榜
	PlayerHonor:UpdateLeaderHonorLadder();	-- 领袖荣誉排行榜
	PlayerHonor:UpdateXoyoLadder(0);		-- 逍遥荣誉榜
	PlayerHonor:OnSchemeUpdateKaimenTaskHonorLadder();
	KGblTask.SCSetDbTaskInt(DBTASD_HONOR_LADDER_TIME, GetTime()); -- 重置荣誉等级
	KGblTask.SCAddDbTaskInt(DBTASK_TRADE_CUR_TAX, self.nCoZoneSubZoneTax)
	KGblTask.SCAddDbTaskInt(DBTASK_COIN_EXCHANGE_PAYER, self.nCoZoneSubZoneCoinPlayer);
	KGblTask.SCAddDbTaskInt(DBTASK_COIN_EXCHANGE_PAYER_RECENT, self.nCoZoneSubZoneCoinPlayerRecent);

	Domain.tbStatuary:ZoneMergeStatuary(self.tbCoZoneStatuData);	
	
	local nCaichi = KGblTask.SCGetDbTaskInt(DBTASK_BAIBAOXIANG_CAICHI)  + self.nCoZoneSubZoneBaiBaoxiangCaichi;
	if nCaichi > MAX20E then
		nCaichi = MAX20E
	end
	KGblTask.SCSetDbTaskInt(DBTASK_BAIBAOXIANG_CAICHI, nCaichi);
	
	-- 合服的时候要把最大霸主之印的人刷新一下
	local nCurMaxCount = KGblTask.SCGetDbTaskInt(DBTASK_BAZHUZHIYIN_MAX);
	if (nCurMaxCount < self.nCoZoneSubZoneBaZhuZhiYinMaxCount) then
		KGblTask.SCSetDbTaskStr(DBTASK_BAZHUZHIYIN_MAX, self.szCoZoneSubZoneBaZhuZhiYinMaxName);
		KGblTask.SCSetDbTaskInt(DBTASK_BAZHUZHIYIN_MAX, self.nCoZoneSubZoneBaZhuZhiYinMaxCount);
	end	
	
	-- 合服的时候发放霸主之印的帮会奖励
	if (3 == self.nCoZoneMainZoneBaZhuZhiYinState and 2 == self.nCoZoneSubZoneBaZhuZhiYinState) then
		-- 主服务器活动结束并且已经发放帮会奖励，而子服务器活动没有没有
		if (1 == self.bCoZoneMainZoneBaZhuZhiYinGetTongAward) then
			Domain.tbStatuary:AddStatuaryCompetence(self.szCoZoneSubZoneBaZhuZhiYinMaxName, Domain.tbStatuary.TYPE_EVENT_NORMAL);
			Domain:CozoneGetTongAward();
		end
	elseif (3 == self.nCoZoneMainZoneBaZhuZhiYinState and 3 == self.nCoZoneSubZoneBaZhuZhiYinState) then
		-- 两个服务器都活动结束，但是主服务器已经发放帮会奖励，而子服务器没有
		if (1 == self.bCoZoneMainZoneBaZhuZhiYinGetTongAward and 0 == self.bCoZoneSubZoneBaZhuZhiYinGetTongAward) then
			Domain.tbStatuary:AddStatuaryCompetence(self.szCoZoneSubZoneBaZhuZhiYinMaxName, Domain.tbStatuary.TYPE_EVENT_NORMAL);
			Domain:CozoneGetTongAward();
		end
	end
	
	self:CoZoneUpdateGirlVote();
	self:CoZoneUpdateCompensateGmBuf();
	self:CoZoneUpdateKingeyesEventBuf();
	self:CoZoneUpdateArrestListBuf();
	self:CoZoneUpdateBlackListBuf();
	self:CoZoneUpdateIBShopListBuf();
	self:CoZoneUpdateWldhMemberListBuf();
	self:CoZoneUpdateVipTransferBuf();
	-- marry
	self:CoZoneUpdateProposalBuf();
	self:CoZoneUpdateMarryBuf();
	-- end
	
	-- 记录并服时间
	local nTime = GetTime();
	KGblTask.SetGblInt(2, 0, nTime);
	KGblTask.SCSetDbTaskInt(DBTASK_COZONE_TIME, nTime);
	return 1;
end

function GCEvent:CoZoneUpdateGirlVote()
	if (GetTime() > 1249920000) then
		return;
	end
	local tbGirlBuf = GetGblIntBuf(GBLINTBUF_GIRL_VOTE, 0, 1);
	if self.tbCoZoneGirlGblBuf then
		tbGirlBuf = tbGirlBuf or {};
		for szName, tbInfo in pairs(self.tbCoZoneGirlGblBuf) do
			tbGirlBuf[szName] = tbInfo;
		end
	end
	
	SpecialEvent.Girl_Vote:SetGblBuf(tbGirlBuf);
	SetGblIntBuf(GBLINTBUF_GIRL_VOTE, 0, 1, tbGirlBuf);
end

function GCEvent:CoZoneUpdateCompensateGmBuf()
	local tbGirlBuf = GetGblIntBuf(GBLINTBUF_COMPENSATE_GM, 0, 1) or {};
	if self.tbCoZoneCompensateGmBuf then
		tbGirlBuf = tbGirlBuf or {};
		for szType, tbInfo in pairs(self.tbCoZoneCompensateGmBuf) do
			tbGirlBuf[szType] = tbGirlBuf[szType] or {};
			for szName, tbPInfo in pairs(tbInfo) do
				tbGirlBuf[szType][szName] = tbPInfo;
			end
		end
	end
	SpecialEvent.CompensateGM:SetGblBuf(tbGirlBuf);
	SetGblIntBuf(GBLINTBUF_COMPENSATE_GM, 0, 1, tbGirlBuf);	
end

function GCEvent:CoZoneUpdateKingeyesEventBuf()
	print("[CoZoneUpdateKingeyesEventBuf] start!!!");
	local tbBuf = GetGblIntBuf(GBLINTBUF_KINGEYES_EVENT, 0, 1) or {};
	if self.tbCoZoneKingeyesEventBuf then
		for EId, tbInfo in pairs(self.tbCoZoneKingeyesEventBuf) do
			tbBuf[EId] = tbBuf[EId] or {};
			tbBuf[EId].tbPart = tbBuf[EId].tbPart or {};
			if (tbInfo.tbPart) then
				for nPId, tbPInfo in pairs(tbInfo.tbPart) do
					tbBuf[EId].tbPart[nPId] = tbPInfo;
				end
			end
		end
	end
	EventManager.KingEyes:SetGblBuf(tbBuf);
	--SetGblIntBuf(GBLINTBUF_KINGEYES_EVENT, 0, 1, tbBuf);	
end

function GCEvent:CoZoneUpdateIBShopListBuf()
	IbShop:MergeCoZoneAndMainZoneBuf(self.tbCoZoneIBShopListBuf or {});
end

function GCEvent:CoZoneUpdateWldhMemberListBuf()
	Wldh.Qualification:MergeCoZoneAndMainZoneBuffer(self.tbCoZoneWldhMemberListBuf or {});
end

function GCEvent:CoZoneUpdateArrestListBuf()
	GM.BatchArrest:CoZoneUpdateArrestListBuf(self.tbCoZoneArrestListBuf or {});
end

function GCEvent:CoZoneUpdateBlackListBuf()
	SpecialEvent.HoleSolution:CoZoneUpdateBlackListBuf(self.tbCoZoneBlackListBuf or {});
end

function GCEvent:CoZoneUpdateVipTransferBuf()
	VipPlayer.VipTransfer:CombineMainAndSubBuf(self.tbCoZoneVipTransferBuf or {});
end

-- marrry
function GCEvent:CoZoneUpdateProposalBuf()
	Marry:CozoneProposalBuffer(self.tbCoZonePropopalBuf or {});
end

function GCEvent:CoZoneUpdateMarryBuf()
	Marry:CozoneGlobalBuffer(self.tbCoZoneMarryBuf or {});
end
-- end

-- 加载数据进表里缓存
function GCEvent:CozoneFactionElecet_Load()
	if not self.tbFactionLastElect then
		self.tbFactionLastElect = {};
		self.tbFactionCurElect = {};
		self.tbFactionWinner = {};
	end
	for nFaction = 1, 12 do
		if not self.tbFactionLastElect[nFaction] then
			self.tbFactionLastElect[nFaction] = {};		-- 上月侯选
			self.tbFactionCurElect[nFaction] = {};		-- 本月侯选
			self.tbFactionWinner[nFaction] = {};		-- 历届优胜
		end
		local tbList = GetLastMonthCandidate(nFaction);
		if tbList then
			self.tbFactionLastElect[nFaction] = Lib:MergeTable(self.tbFactionLastElect[nFaction], tbList);
		end
		tbList = GetCurCandidate(nFaction);
		if tbList then
			self.tbFactionCurElect[nFaction] = Lib:MergeTable(self.tbFactionCurElect[nFaction], tbList);
		end
		tbList = GetAllElectWinner(nFaction);
		if tbList then			
			self.tbFactionWinner[nFaction] = Lib:MergeTable(self.tbFactionWinner[nFaction], tbList);
		end
	end
end

-- 合并保存数据
function GCEvent:CozoneFactionElecet_Merge()
	for nFaction = 1, 12 do
		-- 合并上月候选人
		local nCount = #self.tbFactionLastElect[nFaction]
		if nCount > FactionElect.KD_FACTION_CANDIDATE_MAX then
			nCount = FactionElect.KD_FACTION_CANDIDATE_MAX;
			print("门派"..nFaction.."合并上月候选人异常，合并后数据大于储存位置，正常合并前30，列表如下")
			Lib:ShowTB(self.tbFactionLastElect[nFaction]);
		end
		for i = 1, nCount do
			local tbCandidate = self.tbFactionLastElect[nFaction][i]
			local nPlayerId = KGCPlayer.GetPlayerIdByName(tbCandidate.szName)
			if not nPlayerId then
				SetFactionElectRecord(FactionElect.emKFACTION_CANDIDATE_LAST_BEGIN, nFaction, i, nPlayerId);
				SetFactionElectValue(FactionElect.emKFACTION_CANDIDATE_VOTE_BEGIN + i - 1, nFaction, tbCandidate.nVote)
			end	
		end
		SetFactionElectValue(FactionElect.emKFACTION_LAST_CANDIDATE_COUNT, nFaction, nCount);
		--print("上月合并完成,结果如下:")
		--Lib:ShowTB(GetLastMonthCandidate(nFaction));
		
		-- 合并本月候选人
		nCount = #self.tbFactionCurElect[nFaction]
		if nCount > FactionElect.KD_FACTION_CANDIDATE_MAX then
			nCount = FactionElect.KD_FACTION_CANDIDATE_MAX;
			print("门派"..nFaction.."合并本月候选人异常，合并后数据大于储存位置，正常合并前30，列表如下")
			Lib:ShowTB(self.tbFactionCurElect[nFaction]);
		end
		for i = 1, nCount do
			local tbCandidate = self.tbFactionCurElect[nFaction][i]
			SetFactionElectRecord(FactionElect.emKFACTION_CANDIDATE_CUR_BEGIN, nFaction, i, tbCandidate.nPlayerId);
		end
		SetFactionElectValue(FactionElect.emKFACTION_CANDIDATE_CUR_COUNT, nFaction, nCount);
		--print("门派"..nFaction.."本月合并完成,结果如下:")
		--Lib:ShowTB(GetCurCandidate(nFaction));
		--合并历届大师兄
		nCount = #self.tbFactionWinner[nFaction]
		if nCount > FactionElect.KD_FACTION_DATA_SEGMENT_LENGTH then
			nCount = FactionElect.KD_FACTION_DATA_SEGMENT_LENGTH;
			print("门派"..nFaction.."合并历届大师兄异常，合并后数据大于储存位置，正常合并前1000，列表如下")
			Lib:ShowTB(self.tbFactionWinner[nFaction]);
		end
		for i = 1, nCount do
			local tbCandidate = self.tbFactionWinner[nFaction][i]
			SetFactionElectRecord(FactionElect.emKFACTION_WINNER_RECODE_BEGIN, nFaction, i, tbCandidate.nPlayerId);
		end
		SetFactionElectValue(FactionElect.emKFACTION_WINNER_RECODE_COUNT, 1, nCount);
		--print("门派"..nFaction.."历届合并完成,结果如下:")
		--Lib:ShowTB(GetAllElectWinner(nFaction));
	end
end

-- 玩家数据上线加载回调 ----

local function DescHonorJHWW(nHonor)
	if (nHonor > 1000) then
		nHonor = nHonor - 20;
	elseif (nHonor > 50) then
		nHonor = math.floor(nHonor * 0.98);
	elseif (nHonor > 1) then
		nHonor = nHonor - 1;
	else
		nHonor = 0;
	end
	return nHonor;
end

function GCEvent:DescHonorInPlayerLogin(szName, nDay)
	local nPlayerId = KGCPlayer.GetPlayerIdByName(szName);
	local nHonorJHWW =  KGCPlayer.GetPlayerPrestige(nPlayerId);
	local nHonorLXRY = GetPlayerHonorByName(szName, PlayerHonor.HONOR_CLASS_LINGXIU, 0);
	
	local nHonorMP	= GetPlayerHonorByName(szName, PlayerHonor.HONOR_CLASS_FACTION, 0);
	local nHonorSJ 	= GetPlayerHonorByName(szName, PlayerHonor.HONOR_CLASS_BATTLE, 0);
	local nHonorLS	= GetPlayerHonorByName(szName, PlayerHonor.HONOR_CLASS_WLLS, 0);

	for i = 1, nDay do
		if (nHonorJHWW > 0) then
			nHonorJHWW = DescHonorJHWW(nHonorJHWW);
		else
			break;
		end
	end
	
	local nMonth = nDay / 30;
	for i = 1, nMonth do
		if (nHonorLXRY > 0) then
			nHonorLXRY = math.floor(nHonorLXRY * 0.80);
		end
		if (nHonorMP > 0) then
			nHonorMP = math.floor(nHonorMP * 0.80);
		end
		if (nHonorLS > 0) then
			nHonorLS = math.floor(nHonorLS * 0.80);
		end
		if (nHonorSJ > 0) then
			nHonorSJ = math.floor(nHonorSJ * 0.80);
		end
	end
	
	KGCPlayer.SetPlayerPrestige(nPlayerId, nHonorJHWW);
	SetPlayerHonorByName(szName, PlayerHonor.HONOR_CLASS_WULIN, 0, nHonorMP + nHonorSJ + nHonorLS);
	SetPlayerHonorByName(szName, PlayerHonor.HONOR_CLASS_LINGXIU, 0, nHonorLXRY);
	
	SetPlayerHonorByName(szName, PlayerHonor.HONOR_CLASS_FACTION, 0, nHonorMP);
	SetPlayerHonorByName(szName, PlayerHonor.HONOR_CLASS_BATTLE, 0, nHonorSJ);
	SetPlayerHonorByName(szName, PlayerHonor.HONOR_CLASS_WLLS, 0, nHonorLS);
	
	
	for i = 1, PlayerHonor.HONOR_CLASS_KAIMENTASK do
		SetPlayerHonorRank(nPlayerId, i, 0, 0);
	end
	
	Dbg:WriteLog("DescHonorInPlayerLogin", "Simp Player Login!", szName, nDay);
end