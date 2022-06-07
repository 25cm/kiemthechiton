-------------------------------------------------------
-- 文件名　：boss_qinshihuang.lua
-- 创建者　：zhangjinpin@kingsoft
-- 创建时间：2009-06-11 19:56:05
-- 文件描述：
-------------------------------------------------------

-- 配置文件("\\setting\\npc\npc.txt")

-- 秦始皇boss
local tbQinshihuangBoss	= Npc:GetClass("boss_qinshihuang");

-- 对话事件
function tbQinshihuangBoss:OnDialog()
	me.Msg("...");
end

-- 掉落物品回调
function tbQinshihuangBoss:DeathLoseItem(tbLoseItem)
	
	local tbItem = tbLoseItem.Item;
	local szMsg = "<color=green>Boss rơi vật phẩm:<color>\n";
	local tbList = {};
	
	-- 列清单
	for _, nItemId in pairs(tbItem or {}) do
		local pItem = KItem.GetObjById(nItemId);
		if pItem then
			local szName = pItem.szName;					
			if not tbList[szName] then
				tbList[szName] = 1;
			else
				tbList[szName] = tbList[szName] + 1;
			end
		end
	end
	
	for szItemName, nCount in pairs(tbList or {}) do
		szMsg = szMsg .. "<color=yellow>" .. szItemName .. " - " .. nCount .. " cái<color>\n";
	end
	
	self:BroadCast(szMsg);
end

-- 广播给玩家
function tbQinshihuangBoss:BroadCast(szMsg)		
	if Boss.Qinshihuang.tbPlayerList then
		for nPlayerId, tbPlayerMap in pairs(Boss.Qinshihuang.tbPlayerList) do
			local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
			if pPlayer then
				pPlayer.Msg(szMsg);
			end
		end
	end
end

-- 死亡事件
function tbQinshihuangBoss:OnDeath(pNpcKiller, nFlag)
	
	-- 关键之处：清除召唤表
	Boss.tbUniqueBossCallOut[him.nTemplateId] = nil;
	
	-- 清楚传送NPC和信息
	Boss.Qinshihuang:ClearPassNpc();
	Boss.Qinshihuang:ClearInfo();
	
	-- 找到玩家
	local pPlayer = pNpcKiller.GetPlayer();
	local nWeiWang = 0;
	if him.nLevel >= 95 then
		nWeiWang = 5;
	elseif him.nLevel >= 75 then
		nWeiWang = 3;
	elseif him.nLevel >= 45 then
		nWeiWang = 2;
	end
	if (pPlayer) then
		self:AwardXinDe(pPlayer, 300000);
		pPlayer.AddExp(60000000)
		pPlayer.AddStackItem(18,1,553,1,tbItemInfo,150) --tien du long
		pPlayer.Earn(1500000,0);
		pPlayer.AddBindMoney(1500000);
		pPlayer.AddBindCoin(100000);--5v ??ng khóa
		pPlayer.AddStackItem(22,1,81,1,tbItemInfo,5) --hòa thị ngọc
		pPlayer.Msg("<color=green>Hành trang trống >=5 để nhận<color> <color=yellow>Phần Thưởng<color>");
		local nTeamId	= pPlayer.nTeamId;
		if nTeamId == 0 then
			if nFlag ~= 1 then
				pPlayer.AddKinReputeEntry(nWeiWang, "doccocaubai");
			end
		else
			local tbPlayerId, nMemberCount	= KTeam.GetTeamMemberList(nTeamId);
			for i, nPlayerId in pairs(tbPlayerId) do
				local pTeamPlayer = KPlayer.GetPlayerObjById(nPlayerId);
				if (pTeamPlayer and pTeamPlayer.nMapId == him.nMapId) then
					if nFlag ~= 1 then
						pTeamPlayer.AddKinReputeEntry(nWeiWang, "doccocaubai");
							pTeamPlayer.AddExp(60000000)
		pTeamPlayer.AddStackItem(18,1,553,1,tbItemInfo,150) --tien du long
			pTeamPlayer.Earn(1500000,0);
		pTeamPlayer.AddBindMoney(1500000);
		pTeamPlayer.AddBindCoin(100000);--5v ??ng khóa
		pTeamPlayer.Msg("<color=green>Hành trang trống >=5 để nhận<color> <color=yellow>Phần Thưởng<color>");
					end
				end
			end
		end
		local szMsg = "Hảo hữu của bạn ["..pPlayer.szName.."] đã đánh bại võ lâm cao thủ "..him.szName.."。";
		pPlayer.AddJbCoin(300000);
		pPlayer.Msg("Bạn đã tiêu diệt <color=blue>Tần Thủy Hoàng<color> nhận được: <color=yellow>30 vạn đồng thường<color>");
	pPlayer.SendMsgToFriend(szMsg);
	Player:SendMsgToKinOrTong(pPlayer, " đánh bại "..him.szName..".", 0);
	
	local szMsg = string.format("Tổ đội của <color=green>%s<color> đã đánh bại Tần Thủy Hoàng !!!", pPlayer.szName);
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
	
	-- 股份和荣誉
	local nStockBaseCount = 1500;
	local nHonor = 20;

	--增加建设资金和帮主、族长、个人的股份
	Tong:AddStockBaseCount_GS1(pPlayer.nId, nStockBaseCount, 0.1, 0.5, 0.1, 0.1, 0.3);	
	
	-- 额外奖励回调
	local nFreeCount, tbFunExecute = SpecialEvent.ExtendAward:DoCheck("QinlingBoss", pPlayer);
	SpecialEvent.ExtendAward:DoExecute(tbFunExecute);
	
	-- 队友共享
	local tbMember = pPlayer.GetTeamMemberList();
	if tbMember then
		for _, pMember in ipairs(tbMember) do
			-- 本人的话已经加过了
			if pMember.nId ~= pPlayer.nId then		
				--增加建设资金和帮主、族长、个人的股份		
				Tong:AddStockBaseCount_GS1(pMember.nId, nStockBaseCount, 0.1, 0.5, 0.1, 0.1, 0.3);
				-- 额外奖励回调
				local nFreeCount, tbFunExecute = SpecialEvent.ExtendAward:DoCheck("QinlingBoss", pMember);
				SpecialEvent.ExtendAward:DoExecute(tbFunExecute);
			end
		end
	end
	
	-- 增加族长和帮主的领袖荣誉
	local nKinId , nMemberId = pPlayer.GetKinMember();	
	local pKin = KKin.GetKin(nKinId);
	local pTong = KTong.GetTong(pPlayer.dwTongId);
	
	if pTong then
		-- 增加帮主的领袖荣誉
		local nMasterId = Tong:GetMasterId(pPlayer.dwTongId);
		if nMasterId ~= 0 then	
			PlayerHonor:AddPlayerHonorById_GS(nMasterId, PlayerHonor.HONOR_CLASS_LINGXIU, 0, nHonor);
		end
		-- 增加非帮主族长的领袖荣誉			
		local pKinItor = pTong.GetKinItor()
		local nKinInTongId = pKinItor.GetCurKinId();
		while (nKinInTongId > 0) do
			local pKinInTong = KKin.GetKin(nKinInTongId);
			local nCaptainId = Kin:GetPlayerIdByMemberId(nKinInTongId, pKinInTong.GetCaptain());
			if nMasterId ~= nCaptainId then
				PlayerHonor:AddPlayerHonorById_GS(nCaptainId, PlayerHonor.HONOR_CLASS_LINGXIU, 0, nHonor/2);
			end
			nKinInTongId = pKinItor.NextKinId();
		end
		
	elseif pKin then
		-- 增加Không bang hội族长的领袖荣誉
		local nCaptainId = Kin:GetPlayerIdByMemberId(nKinId, pKin.GetCaptain());
		PlayerHonor:AddPlayerHonorById_GS(nCaptainId, PlayerHonor.HONOR_CLASS_LINGXIU, 0, nHonor/2);
	end

	local szTongName = "Không bang hội";
	local szBossName = him.szName;
	local szKillPlayerName = pPlayer.szName;
	local pTong = KTong.GetTong(pPlayer.dwTongId);
	if pTong then
		szTongName = pTong.GetName();
	end
	Dbg:WriteLog("[BossDeath]", szBossName, szKillPlayerName, szTongName);
	
end
end;


-- 血量触发
function tbQinshihuangBoss:OnLifePercentReduceHere(nLifePercent)
	
	local pNpc = him;
	if nLifePercent == 80 then
		
		if Boss.Qinshihuang:GetBossStep() == 0 then

			local szMsg = "Quả nhân, mệt mỏi.";
			pNpc.SendChat(szMsg);
			Boss.Qinshihuang:Broadcast("Tần Thủy Hoàng nói: "..szMsg);
						
			-- 增加对话Npc
			local pTempNpc = KNpc.Add2(2450, 120, -1, 1540, 1820, 3282);
			
			-- 记录一些状态
			Boss.Qinshihuang:OnProtectBoss(pTempNpc.dwId, 1, pNpc.GetDamageTable());
		
			-- 增加4个兵马桶
			KNpc.Add2(2439, 120, -1, 1540, 1820, 3266);
			KNpc.Add2(2439, 120, -1, 1540, 1835, 3282);
			KNpc.Add2(2439, 120, -1, 1540, 1804, 3282);
			KNpc.Add2(2439, 120, -1, 1540, 1820, 3297);
			
			-- 增加两个传送npc
			local pNpc1 = KNpc.Add2(2456, 120, -1, 1539, 1609, 3899);
			local pNpc2 = KNpc.Add2(2457, 120, -1, 1539, 1985, 3532);
			
			Boss.Qinshihuang.tbBoss.nPassId1 = pNpc1.dwId;
			Boss.Qinshihuang.tbBoss.nPassId2 = pNpc2.dwId;
			
			pNpc.Delete();
		end
		
	elseif nLifePercent == 50 then
		
		if Boss.Qinshihuang:GetBossStep() == 1 then

			local szMsg = "Các ngươi, khách ở xa tới thì hãy du ngoạn một hồi.";
			pNpc.SendChat(szMsg);
			Boss.Qinshihuang:Broadcast("Tần Thủy Hoàng nói: "..szMsg);
						
			-- 增加对话Npc
			local pTempNpc = KNpc.Add2(2450, 120, -1, 1540, 1820, 3282);
			
			-- 记录一些状态
			Boss.Qinshihuang:OnProtectBoss(pTempNpc.dwId, 2, pNpc.GetDamageTable());
			
			-- 增加4个招魂师
			KNpc.Add2(2440, 120, -1, 1540, 1820, 3266);
			KNpc.Add2(2440, 120, -1, 1540, 1835, 3282);
			KNpc.Add2(2440, 120, -1, 1540, 1804, 3282);
			KNpc.Add2(2440, 120, -1, 1540, 1820, 3297);
			
			pNpc.Delete();
		end
		
	elseif nLifePercent == 20 then
		
		if Boss.Qinshihuang:GetBossStep() == 2 then
			
			local szMsg = "Quả nhân, cần nghỉ ngơi, các ngươi đi đi...";
			pNpc.SendChat(szMsg);
			Boss.Qinshihuang:Broadcast("Tần Thủy Hoàng nói: "..szMsg);
			
			-- 增加对话Npc
			local pTempNpc = KNpc.Add2(2450, 120, -1, 1540, 1820, 3282);
			
			-- 记录一些状态
			Boss.Qinshihuang:OnProtectBoss(pTempNpc.dwId, 3, pNpc.GetDamageTable());
			
			-- 增加2个兵马桶，2个招魂师
			KNpc.Add2(2439, 120, -1, 1540, 1820, 3266);
			KNpc.Add2(2439, 120, -1, 1540, 1835, 3282);
			KNpc.Add2(2440, 120, -1, 1540, 1804, 3282);
			KNpc.Add2(2440, 120, -1, 1540, 1820, 3297);
				
			pNpc.Delete();
		end
	end
end

-- 兵马俑
local tbBingmayong = Npc:GetClass("boss_bingmayong");
function tbBingmayong:OnDeath(pNpcKiller)
	Boss.Qinshihuang:AddDeathCount();
end
		
-- 招魂师
local tbZhaohunshi = Npc:GetClass("boss_zhaohunshi");
function tbZhaohunshi:OnDeath(pNpcKiller)
	Boss.Qinshihuang:AddDeathCount();
end

-- 精英
local tbJingying = Npc:GetClass("boss_qinjingying");
function tbJingying:OnDeath(pNpcKiller)
	
	Boss.tbQinshihuangCallOut[him.nTemplateId] = nil;
	
	local pPlayer = pNpcKiller.GetPlayer();
	if not pPlayer then
		return 0;
	end
	
	-- 额外奖励回调
	local nFreeCount, tbFunExecute = SpecialEvent.ExtendAward:DoCheck("QinlingBoss", pPlayer);
	SpecialEvent.ExtendAward:DoExecute(tbFunExecute);
	
	-- 队友共享
	local tbMember = pPlayer.GetTeamMemberList();
	if tbMember then
		for _, pMember in ipairs(tbMember) do
			if pMember.nId ~= pPlayer.nId then		
				local nFreeCount, tbFunExecute = SpecialEvent.ExtendAward:DoCheck("QinlingBoss", pMember);
				SpecialEvent.ExtendAward:DoExecute(tbFunExecute);
			end
		end
	end
end

-- 小boss
local tbSmallBoss = Npc:GetClass("boss_qinlingsmall");
function tbSmallBoss:OnDeath(pNpcKiller)
	
	Boss.tbQinshihuangCallOut[him.nTemplateId] = nil;
	
	local pPlayer = pNpcKiller.GetPlayer();
	if not pPlayer then
		return 0;
	end
	
	-- 额外奖励回调
	local nFreeCount, tbFunExecute = SpecialEvent.ExtendAward:DoCheck("QinlingBoss", pPlayer);
	SpecialEvent.ExtendAward:DoExecute(tbFunExecute);
	
	-- 队友共享
	local tbMember = pPlayer.GetTeamMemberList();
	if tbMember then
		for _, pMember in ipairs(tbMember) do
			if pMember.nId ~= pPlayer.nId then		
				local nFreeCount, tbFunExecute = SpecialEvent.ExtendAward:DoCheck("QinlingBoss", pMember);
				SpecialEvent.ExtendAward:DoExecute(tbFunExecute);
			end
		end
	end
	
	pPlayer.SendMsgToFriend("Hảo hữu của bạn ["..pPlayer.szName.."] đánh bại "..him.szName..".");
	Player:SendMsgToKinOrTong(pPlayer, " đánh bại "..him.szName..".", 0);
	self:BroadCast(string.format("Tổ đội của <color=green>%s<color> đánh bại %s!", pPlayer.szName, him.szName));
	
	local szTongName = "Không bang hội";
	local szBossName = him.szName;
	local szKillPlayerName = pPlayer.szName;
	local pTong = KTong.GetTong(pPlayer.dwTongId);
	if pTong then
		szTongName = pTong.GetName();
	end
	Dbg:WriteLog("[BossDeath]", szBossName, szKillPlayerName, szTongName);
		
end

function tbSmallBoss:BroadCast(szMsg)		
	if Boss.Qinshihuang.tbPlayerList then
		for nPlayerId, tbPlayerMap in pairs(Boss.Qinshihuang.tbPlayerList) do
			local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
			if pPlayer then
				pPlayer.Msg(szMsg);
			end
		end
	end
end
