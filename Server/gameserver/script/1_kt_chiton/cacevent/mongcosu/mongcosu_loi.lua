-------------------------------------------------------
-- 文件名　：mongcosu_loi.lua
-- 创建者　：zhangjinpin@kingsoft
-- 创建时间：2009-06-11 19:56:05
-- 文件描述：
-------------------------------------------------------

-- 配置文件("\\setting\\npc\npc.txt")

-- 秦始皇boss
local tbQinshihuangBoss	= Npc:GetClass("mongcosu_loi");

-- 对话事件
function tbQinshihuangBoss:OnDialog()
	me.Msg("...");
end

-- 掉落物品回调
function tbQinshihuangBoss:DeathLoseItem(tbLoseItem)
	
	local tbItem = tbLoseItem.Item;
	local szMsg = "<color=green>Mông Cổ Sứ (Lôi) rơi vật phẩm:<color>\n";
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
function tbQinshihuangBoss:OnDeath(pNpcKiller)
	
	-- 关键之处：清除召唤表
	Boss.tbUniqueBossCallOut[him.nTemplateId] = nil;
	
	-- 清楚传送NPC和信息
	Boss.Qinshihuang:ClearPassNpc();
	Boss.Qinshihuang:ClearInfo();
	
	-- 找到玩家
	local pPlayer = pNpcKiller.GetPlayer();
	
	-- 找不到返回
	if not pPlayer then
		return 0;
	end

	-- 增加威望
	local nTeamId = pPlayer.nTeamId;
	if nTeamId == 0 then
		pPlayer.AddKinReputeEntry(5, "mongcosu_loi");
	else
		local tbPlayerId, nMemberCount = KTeam.GetTeamMemberList(nTeamId);
		for i, nPlayerId in pairs(tbPlayerId) do
			local pTeamPlayer = KPlayer.GetPlayerObjById(nPlayerId);
			if (pTeamPlayer and pTeamPlayer.nMapId == him.nMapId) then
				pTeamPlayer.AddKinReputeEntry(5, "mongcosu_loi");
			end
		end
	end
	
	-- 频道公告
	local szMsg = "Hảo hữu của bạn ["..pPlayer.szName.."] đánh bại "..him.szName..".";
	pPlayer.SendMsgToFriend(szMsg);
	Player:SendMsgToKinOrTong(pPlayer, " đánh bại "..him.szName..".", 0);
	
	local szMsg = string.format("Tổ đội của <color=green>%s<color> tại tầng Tàn Tích Cung A Phòng đánh thắng Mông Cổ Sứ (Lôi)!!!", pPlayer.szName);
		GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=red>[Anh Hùng] <color><color=yellow><color=Turquoise>"..pPlayer.szName.."<color>: đánh bại Mông Cổ Sứ (Lôi)"});
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=red>[Anh Hùng] <color><color=yellow><color=Turquoise>"..pPlayer.szName.."<color>: đánh bại Mông Cổ Sứ (Lôi)");
	KDialog.MsgToGlobal("<color=red>[Anh Hùng]<color> <color=yellow><color=Turquoise>"..pPlayer.szName.."<color>: đánh bại Mông Cổ Sứ (Lôi)");	

	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		pPlayer.AddStackItem(18,1,377,1,nil,5) -- 5 Hòa Thị Bích
	pPlayer.AddStackItem(18,10,11,2,nil,2) -- 100 NHHT
	pPlayer.AddStackItem(18,1,1331,1,nil,5) -- 5 Chân Nguyên TLĐ
	pPlayer.AddExp(100000000) -- 100tr EXP
	pPlayer.AddStackItem(18,1,1,9,nil,1) -- 1 HT9
		local nNpcMapId, nNpcPosX, nNpcPosY = him.GetWorldPos();
	KItem.AddItemInPos(nNpcMapId,nNpcPosX,nNpcPosY,18,1,1,8);
	KItem.AddItemInPos(nNpcMapId,nNpcPosX,nNpcPosY,18,1,1,8);
	KItem.AddItemInPos(nNpcMapId,nNpcPosX,nNpcPosY,18,10,11,2);
	KItem.AddItemInPos(nNpcMapId,nNpcPosX,nNpcPosY,18,10,11,2);
	KItem.AddItemInPos(nNpcMapId,nNpcPosX,nNpcPosY,18,10,11,2);
	KItem.AddItemInPos(nNpcMapId,nNpcPosX,nNpcPosY,18,10,11,2);
	KItem.AddItemInPos(nNpcMapId,nNpcPosX,nNpcPosY,18,10,11,2);
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
	
end;


-- 血量触发
function tbQinshihuangBoss:OnLifePercentReduceHere(nLifePercent)
	
	local pNpc = him;
	if nLifePercent == 80 then
		
		if Boss.Qinshihuang:GetBossStep() == 0 then

			local szMsg = "Quả nhân, mệt mỏi.";
			pNpc.SendChat(szMsg);
			Boss.Qinshihuang:Broadcast("Mông Cổ Sứ (Lôi) nói: "..szMsg);
						
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
			Boss.Qinshihuang:Broadcast("Mông Cổ Sứ (Lôi) nói: "..szMsg);
						
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
			Boss.Qinshihuang:Broadcast("Mông Cổ Sứ (Lôi) nói: "..szMsg);
			
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
	
	Boss.tbUniqueBossCallOut[him.nTemplateId] = nil;
	
	local pPlayer = pNpcKiller.GetPlayer();
	if not pPlayer then
		return 0;
	end
	KNpc.Add2(9952, 255, 1,132, 1780,3553);
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
	
	Boss.tbUniqueBossCallOut[him.nTemplateId] = nil;
	
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
