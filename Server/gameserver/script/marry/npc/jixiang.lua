-- 文件名　：jixiang.lua
-- 创建者　：furuilei
-- 创建时间：2009-12-07 11:09:14
-- 功能描述：结婚npc，吉祥

local tbNpc = Npc:GetClass("marry_jixiang");

--===================================================

tbNpc.LEVEL_LAIBIN = 1;		-- 来宾
tbNpc.LEVEL_BANLN = 2;		-- 伴郎伴娘
tbNpc.LEVEL_SIYI = 3;		-- 司仪
tbNpc.LEVEL_COUPLE = 4;		-- 新郎新娘

tbNpc.WEDDINGLEVEL_PINGMIN	= 1;
tbNpc.WEDDINGLEVEL_GUIZU	= 2;
tbNpc.WEDDINGLEVEL_WANGHOU	= 3;
tbNpc.WEDDINGLEVEL_HUANGJIA	= 4;

tbNpc.CDTIME_SETHUATONG		= 60 * 10;	-- 摆放花童操作的cd时间，10分钟

tbNpc.COST_PER_PLAYERLIMIT	= 10000;	-- 每个人数上限需要花费的银两
tbNpc.COST_PER_CAIYAOLIMIT	= 50000;	-- 每个菜肴上限需要花费的银两

tbNpc.STATE_STARTWEDDING	= 1;	-- 开启婚礼
-- tbNpc.STATE_YANHUO			= 2;	-- 开启焰火（皇家模式）
tbNpc.STATE_VISITORNPC		= 2;	-- 开启来访npc
tbNpc.STATE_ZHUHUNNPC		= 3;	-- 开启主婚人npc
tbNpc.STATE_YANXI			= 4;	-- 开启婚礼宴席上菜
tbNpc.STATE_OVER			= 5;

tbNpc.tbZhuHunNpc = {
	[1] = {szName = "Bạch thu lâm", nNpcId = 6659, tbPos = {1764, 3148}},
	[2] = {szName = "Bạch thu lâm", nNpcId = 6658, tbPos = {1605, 3169}},
	[3] = {szName = "Bạch thu lâm", nNpcId = 6657, tbPos = {1696, 3082}},
	[4] = {szName = "Bạch thu lâm", nNpcId = 6656, tbPos = {1592, 3214}},
	};

-- 抽奖次数
tbNpc.tbCount_ChouJiang = {[1] = 0, [2] = 0, [3] = 5, [4] = 5,};
tbNpc.tbAward_ChouJiang = {
	[1] = {tbGDPL = {}, szAwardName = ""},
	[2] = {tbGDPL = {}, szAwardName = ""},
	[3] = {tbGDPL = {18, 1, 614, 1}, szAwardName = "Bàn Điển Lễ May Mắn"},
	[4] = {tbGDPL = {18, 1, 614, 1}, szAwardName = "Bàn Điển Lễ May Mắn"},
	};

-- 最多摆放花童数量
tbNpc.MAX_HUATONG_COUNT = 64;
tbNpc.tbHuaTongPos = {{1600, 3200}, {1600, 3200}};

--===================================================

function tbNpc:OnDialog()
	if (Marry:CheckState() == 0) then
		return 0;
	end

	local szMsg = "Xin chào !  xin mời nhị vị hiệp lữ hoặc bọn họ đích huynh đệ kết nghĩa, khuê trung bạn thân nói cho ta biết ba!";
	local tbOpt = {{"Kết thúc đối thoại"},};
		
	local nTimerId = Marry:GetSpecTimer(me.nMapId, "huatong");
	if (nTimerId and 0 ~= nTimerId) then
		table.insert(tbOpt, 1, {"<color=gray>Hoa Đồng châm ngòi pháo<color>", self.OpenHuaTongYanHua, self});
		table.insert(tbOpt, 2, {"<color=yellow>Hoa Đồng ngừng châm ngòi pháo<color>", self.CloseHuaTongYanHua, self});
	else
		table.insert(tbOpt, 1, {"<color=yellow>Hoa Đồng châm ngòi pháo<color>", self.OpenHuaTongYanHua, self});
		table.insert(tbOpt, 2, {"<color=gray>Hoa Đồng ngừng châm ngòi pháo<color>", self.CloseHuaTongYanHua, self});
	end
		
	local bHaveDynamicChoice, tbDynamicChoice = self:GetCurDynamicChoice();
	if (1 == bHaveDynamicChoice) then
		table.insert(tbOpt, 1, tbDynamicChoice);
	end
	
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:CheckLevel(nNeedLevel)
	local nMyLevel = self:GetWeddingPlayerLevel(me.szName);
	if (nMyLevel >= nNeedLevel) then
		return 1;
	end
	return 0;
end

function tbNpc:GetCurDynamicChoice()
	local bRet = 0;
	local tbRet = {};
	local nCurState = self:GetCurState();

	if (self.STATE_STARTWEDDING == nCurState) then
		bRet = 1;
		tbRet = {"<color=yellow>Bắt đầu điển lễ<color>", self.StartWedding, self};
	elseif (self.STATE_VISITORNPC == nCurState) then
		bRet = 1;
		tbRet = {"<color=yellow>Mời các quan khách chúc mừng<color>", self.NpcVisitor, self};
	elseif (self.STATE_ZHUHUNNPC == nCurState) then
		bRet = 1;
		tbRet = {"<color=yellow>Chuẩn bị bái thiên địa<color>", self.ZhuHunNpc, self};
	elseif (self.STATE_YANXI == nCurState) then
		bRet = 1;
		tbRet = {"<color=yellow>Bắt đầu phục vụ yến tiệc<color>", self.OpenYanxi, self};
	end
	return bRet, tbRet;
end

-- 获取指定玩家的权限
function tbNpc:GetWeddingPlayerLevel(szPlayerName)
	return Marry:GetWeddingPlayerLevel(me.nMapId, szPlayerName);
end

function tbNpc:GetWeddingLevel(nMapId)
	return Marry:GetWeddingLevel(nMapId) or 0;
end

function tbNpc:SetLevel(szPlayerName, nLevel)
	Marry:SetWeddingPlayerLevel(me.nMapId, szPlayerName, nLevel)
end

function tbNpc:GetCurState()
	local nCurState = Marry:GetWeddingStep(me.nMapId);
	return nCurState;
end

function tbNpc:SetCurState(nState)
	Marry:SetWeddingStep(me.nMapId, nState);
end

function tbNpc:GetWeddingOwnerName()
	local tbCoupleName = Marry:GetWeddingOwnerName(me.nMapId) or {};
	return tbCoupleName;
end

--================================================================

function tbNpc:IsCoupleInTheMap()
	local tbCoupleName = self:GetWeddingOwnerName(me.nMapId);
	if (#tbCoupleName ~= 2) then
		return 0;
	end
	local bIsCoupleInTheMap = 1;
	for _, szName in pairs(tbCoupleName) do
		local pPlayer = KPlayer.GetPlayerByName(szName);
		if (not pPlayer or pPlayer.nMapId ~= me.nMapId) then
			bIsCoupleInTheMap = 0;
			break;
		end
	end
	return bIsCoupleInTheMap;
end

function tbNpc:CanOpt(bCheckRelation)
	local szErrMsg = "";
	local bIsWeddingMap = Marry:CheckWeddingMap(me.nMapId);
	if (0 == bIsWeddingMap) then
		szErrMsg = "Trước mặt không phải nơi tiến hành điển lễ, không thể thực hiện thao tác vừa chọn.";
		return 0, szErrMsg;
	end
	
	local bLevelOk = self:CheckLevel(self.LEVEL_BANLN);
	if (bLevelOk == 0) then
		szErrMsg = "Thao tác thất bại, cần nhị vị hiệp lữ hoặc bọn họ đích huynh đệ kết nghĩa, khuê trung bạn thân tài năng thao tác.";
		return 0, szErrMsg;
	end
	
	local bCoupleInTheMap = self:IsCoupleInTheMap();
	if (0 == bCoupleInTheMap) then
		szErrMsg = "Nhị vị hiệp lữ không trình diện, không thể thực hiện thao tác.";
		return 0, szErrMsg;
	end
	
	local bIsPerformance = Marry:GetPerformState(me.nMapId);
	if (1 == bIsPerformance) then
		szErrMsg = "Biểu diễn chính đang tiến hành ở giữa, chính chờ biểu diễn sau khi kết thúc trở lại tiến hành bước tiếp theo thao tác ba.";
		return 0, szErrMsg;
	end
	
	local tbCoupleName = Marry:GetWeddingOwnerName(me.nMapId);
	if (#tbCoupleName ~= 2) then
		return 0, szErrMsg;
	end
	local pPlayer1 = KPlayer.GetPlayerByName(tbCoupleName[1]);
	local pPlayer2 = KPlayer.GetPlayerByName(tbCoupleName[2]);
	if (0 == pPlayer1.IsFriendRelation(tbCoupleName[2])) then
		szErrMsg = "Ngươi và 2 vị hiệp lữ không phải là bằng hữu, hãy liên hệ với bọn họ trước khi vào.";
		return 0, szErrMsg;
	end
	if (not bCheckRelation) then
		if (not pPlayer1 or not pPlayer2) then
			return 0, szErrMsg;
		end
		if (1 == pPlayer1.IsMarried()) then
			szErrMsg = string.format("<color=yellow>%s<color> được mời vào dự lễ", pPlayer1.szName);
			return 0, szErrMsg;
		end
		if (1 == pPlayer2.IsMarried()) then
			szErrMsg = string.format("<color=yellow>%s<color> được mời vào dự lễ", pPlayer2.szName);
			return 0, szErrMsg;
		end
	end

	return 1;
end

--================================================================

function tbNpc:GetHuaTongList()
	local tbNpcIdxList = KNpc.GetMapNpcWithName(me.nMapId, "Hoa Đồng");
	if (not tbNpcIdxList or #tbNpcIdxList == 0) then
		return;
	end
	local tbNpcList = {};
	for _, nNpcIdx in pairs(tbNpcIdxList) do
		local pNpc = KNpc.GetByIndex(nNpcIdx);
		if (pNpc) then
			table.insert(tbNpcList, pNpc);
		end
	end
	return tbNpcList;
end

-- 燃放花童烟花
function tbNpc:OpenHuaTongYanHua()
	local nTimerId = Marry:GetSpecTimer(me.nMapId, "huatong");
	if (nTimerId and 0 ~= nTimerId) then
		return;
	end
	Marry:SetFireState(me.nMapId, 1);
	local nTimerId = Timer:Register(1, self.OpenYanHua, self, self:GetHuaTongList());
	Marry:AddSpecTimer(me.nMapId, "huatong", nTimerId);
end

function tbNpc:OpenYanHua(tbNpcList)
	if not tbNpcList then
		return 0;
	end
	local nFireState = Marry:GetFireState(me.nMapId) or 0;
	if (nFireState ~= 1) then
		return 0;
	end
	for _, pNpc in pairs(tbNpcList) do
		pNpc.CastSkill(307, 1, -1, pNpc.nIndex);
	end
	return 5 * Env.GAME_FPS;
end

--================================================================

-- Hoa Đồng ngừng châm ngòi pháo
function tbNpc:CloseHuaTongYanHua()
	local nTimerId = Marry:GetSpecTimer(me.nMapId, "huatong");
	Marry:ClearSpecTimer(me.nMapId, "huatong")
	Marry:SetFireState(me.nMapId, 0);
end

--================================================================

-- 开始婚礼
function tbNpc:StartWedding()
	local nCurState = self:GetCurState();
	if (nCurState ~= self.STATE_STARTWEDDING) then
		return;
	end
	
	local bCanOpt, szErrMsg = self:CanOpt();
	if (bCanOpt == 0) then
		if ("" ~= szErrMsg) then
			Dialog:Say(szErrMsg);
		end
		return 0;
	end
	
	local tbCoupleName = self:GetWeddingOwnerName(me.nMapId);
	if (#tbCoupleName ~= 2) then
		return 0;
	end
	local szMsg = string.format("Ngày tốt đã đến, <color=yellow>%s<color> và <color=yellow>%s<color> đích điển lễ chính thức bắt đầu.",
		tbCoupleName[1], tbCoupleName[2]);
	him.SendChat(szMsg, him.szName);
	
	self:SetCurState(self.STATE_VISITORNPC);
	
	Dbg:WriteLog("Marry", "Hệ thống kết hôn", 
		string.format("%s %s bắt đầu điển lễ", tbCoupleName[1], tbCoupleName[2]),
		string.format("Mở ra nghi thức thời gian: %s", os. date( "%H giờ, Ngày %d, Tháng: %m, Năm: %Y", GetTime()))
	);
end

--================================================================

-- 开启拜访npc
function tbNpc:NpcVisitor()
	local nCurState = self:GetCurState();
	if (nCurState ~= self.STATE_VISITORNPC) then
		return;
	end
	
	local bCanOpt, szErrMsg = self:CanOpt();
	if (bCanOpt == 0) then
		if ("" ~= szErrMsg) then
			Dialog:Say(szErrMsg);
		end
		return 0;
	end
	
	local nWeddingLevel = self:GetWeddingLevel(me.nMapId);
	Marry.VisitorManager:Open(me.nMapId, nWeddingLevel);
	
	self:SetCurState(self.STATE_ZHUHUNNPC);
end

--================================================================

function tbNpc:IsCoupleOnStage(nMapId)
	local tbCoupleName = self:GetWeddingOwnerName(nMapId);
	local bIsCoupleOnStage = 0;
	if (1 == Marry:CheckPlayerOnStage(nMapId, tbCoupleName[1]) and
		1 == Marry:CheckPlayerOnStage(nMapId, tbCoupleName[2])) then
		bIsCoupleOnStage = 1;
	end
	return bIsCoupleOnStage;
end

-- 开启主婚npc
function tbNpc:ZhuHunNpc()

	local nCurState = self:GetCurState();
	if (nCurState ~= self.STATE_ZHUHUNNPC) then
		return;
	end
	
	local bCanOpt, szErrMsg = self:CanOpt(1);
	if (bCanOpt == 0) then
		if ("" ~= szErrMsg) then
			Dialog:Say(szErrMsg);
		end
		return 0;
	end
	
	local bIsCoupleOnStage = self:IsCoupleOnStage(me.nMapId);
	if (0 == bIsCoupleOnStage) then
		Dialog:Say("Cần hai vị hiệp lữ đứng ra để bắt đầu buổi điển lễ");
		return 0;
	end
	
	local nWeddingLevel = self:GetWeddingLevel(me.nMapId);
	self:OpenZhuHunNpc(nWeddingLevel, me.nMapId);
	
	self:SetCurState(self.STATE_YANXI);
end

function tbNpc:Marry(tbCoupleName, nMapId)
	local pMale = KPlayer.GetPlayerByName(tbCoupleName[1]);
	local pFemale = KPlayer.GetPlayerByName(tbCoupleName[2]);
	self:RemoveProposalTitle(pMale, pFemale);
	
	local nWeddingLevel = Marry:GetWeddingLevel(nMapId);
	
	-- 为新人添加称号
	Marry:SetTitle(pMale, pFemale);
	
	local szBroadcastMsg = string.format("[<color=turquoise>%s<color>] và [<color=turquoise>%s<color>] đã kết thành vợ chồng, chúc 2 bạn trăm năm hạnh phúc đầu bạc răng long.",
		tbCoupleName[1], tbCoupleName[2]);
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT, szBroadcastMsg, 20);
end

-- 移除求婚称号（如果有的话）
function tbNpc:RemoveProposalTitle(pMale, pFemale)
	local szTitle = pFemale.GetTaskStr(Marry.TASK_GROUP_ID, Marry.TASK_QIUHUN_NAME) .. "Tình nhân";
	pMale.RemoveSpeTitle(szTitle);
	
	szTitle = pMale.GetTaskStr(Marry.TASK_GROUP_ID, Marry.TASK_QIUHUN_NAME) .. "Tình nhân";
	pFemale.RemoveSpeTitle(szTitle);
end

function tbNpc:OpenZhuHunNpc(nWeddingLevel, nMapId)
	local nMapLevel = Marry:GetWeddingMapLevel(nMapId, me.szName);
	local tbZhuHunNpcInfo = self.tbZhuHunNpc[nWeddingLevel];
	if (not tbZhuHunNpcInfo) then
		return 0;
	end
	
	
	local pNpc = KNpc.Add2(tbZhuHunNpcInfo.nNpcId, 120, -1, nMapId, unpack(Marry.MAP_STAGE_POS[nMapLevel]));
	local tbCoupleName = self:GetWeddingOwnerName(me.nMapId);
	if (pNpc and #tbCoupleName == 2) then
		-- 开始释放经验
		local tbGouhuoNpc = Npc:GetClass("gouhuonpc");
		tbGouhuoNpc:InitGouHuo(pNpc.dwId, 0, 900, 5, 60, 500, 0);
		tbGouhuoNpc:StartNpcTimer(pNpc.dwId);
	
		-- 证婚人开始表演
		Marry:SetWitnessesId(nMapId, pNpc.dwId);
		local tbNpcData = pNpc.GetTempTable("Marry") or {};
		tbNpcData.nCurZhenghunStep = 1;
		local tbZhenghunren = Npc:GetClass("marry_zhenghunren");
		tbZhenghunren:Start(nMapId, nMapLevel, tbCoupleName);
		pNpc.SetLiveTime(3600 * Env.GAME_FPS);
		Relation:AddRelation_GS(tbCoupleName[1], tbCoupleName[2], Player.emKPLAYERRELATION_TYPE_COUPLE, 1);
	end
	return 0;
end

--================================================================

-- 开启宴席
function tbNpc:OpenYanxi()
	
	local nCurState = self:GetCurState();
	if (nCurState ~= self.STATE_YANXI) then
		return;
	end
	
	local bCanOpt, szErrMsg = self:CanOpt(1);
	if (bCanOpt == 0) then
		if ("" ~= szErrMsg) then
			Dialog:Say(szErrMsg);
		end
		return 0;
	end
	
	-- 开始小游戏环节
	Marry.MiniGame:CallMiniGameNpc(me.nMapId);
	
	-- 上菜
	local tbNpc = Npc:GetClass("marry_shangcaipuren");
	tbNpc:Init(me.nMapId);
	
	-- 抽奖
	local nWeddingLevel = self:GetWeddingLevel(me.nMapId);
	local nCount_ChouJiang = self.tbCount_ChouJiang[nWeddingLevel];
	if (nCount_ChouJiang > 0) then
		if (not Marry.tbCount_ChouJiang) then
			Marry.tbCount_ChouJiang = {};
		end
		Marry.tbCount_ChouJiang[me.nMapId] = nCount_ChouJiang;
		local nChouJiang_CurCount = Marry:GetTicket(me.nMapId);
		if (nChouJiang_CurCount >= self.tbCount_ChouJiang[nWeddingLevel]) then
			return 0;
		end
		local szRightMsg = string.format("Sắp tới trò chơi  <color=yellow>%s<color> chúc may mắn", nChouJiang_CurCount + 1);
		Marry:UpdateRightUI(me.nMapId, szRightMsg);
		
		local nTimerId = Timer:Register(2.4 * 60 * Env.GAME_FPS, self.ChouJiang, self, me.nMapId, nWeddingLevel);
		Marry:AddSpecTimer(me.nMapId, "choujiang", nTimerId);
	end
	
	self:SetCurState(self.STATE_OVER);
end

-- 抽奖
function tbNpc:ChouJiang(nMapId, nWeddingLevel)
	-- 当前地图目前已经进行的抽奖次数
	local nChouJiang_CurCount = Marry:GetTicket(nMapId);
	if (nChouJiang_CurCount >= self.tbCount_ChouJiang[nWeddingLevel]) then
		return 0;
	end

	local szRightMsg = string.format("Sắp tới trò chơi  <color=yellow>%s<color> chúc may mắn", nChouJiang_CurCount + 2);
	Marry:UpdateRightUI(nMapId, szRightMsg);
	
	local tbCoupleName = Marry:GetWeddingOwnerName(nMapId);
	if (not tbCoupleName or #tbCoupleName ~= 2) then
		return 0;
	end
	local tbAllPlayer = Marry:GetAllPlayers(nMapId) or {};
	local nPlayerCount = #tbAllPlayer;
	if (0 ~= nPlayerCount) then
		local nRand = MathRandom(nPlayerCount);
		local pPlayer = tbAllPlayer[nRand];
		if (pPlayer) then
			local tbAwardInfo = self:GetAwardInfo(nWeddingLevel);
			KPlayer.SendMail(pPlayer.szName, "Điển lễ quà tặng", string. format( "Chúc mừng ! <color=yellow>%s<color> và <color=yellow>%s<color> <color=green>%s<color> cử hành liễu trừu tưởng hoạt động, nâm may mắn trung liễu giải thưởng lớn! hãy đến kiểm tra và nhận quà", tbCoupleName[1], tbCoupleName[2], Marry. WEDDING_LEVEL_NAME[nWeddingLevel]),
							0, 0, 1, unpack(tbAwardInfo.tbGDPL));
			local szMsg = string.format("<color=yellow>%s<color> rút thăm trúng %s, hãy kiểm tra lại thư của mình",
											pPlayer.szName, tbAwardInfo.szAwardName);
			for _, pTempPlayer in pairs(tbAllPlayer) do
				pTempPlayer.Msg(szMsg);
			end
		end
	end
	
	Marry:AddTicket(nMapId);
	nChouJiang_CurCount = nChouJiang_CurCount + 1;
	if (nChouJiang_CurCount >= self.tbCount_ChouJiang[nWeddingLevel]) then
		Marry:UpdateRightUI(nMapId, "");
		return 0;
	end
	
	return 2.4 * 60 * Env.GAME_FPS;
end

-- 获取抽奖的奖品信息
function tbNpc:GetAwardInfo(nWeddingLevel)
	local tbAwardInfo = self.tbAward_ChouJiang[nWeddingLevel];
	return tbAwardInfo;
end
