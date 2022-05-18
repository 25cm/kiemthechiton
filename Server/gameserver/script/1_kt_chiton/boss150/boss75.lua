
Npc._tbWorldBossBase = {};
local tbWorldBossBase = Npc._tbWorldBossBase;

-- 定义对话事件
function tbWorldBossBase:OnDialog()
	me.Msg("Unbelievable!!!");	-- 战斗Npc，不会发生对话吧？
end;

-- 定义死亡事件
-- 增加参数nFlag，用来标记是否增加江湖威望，nil-增加(默认)，1-不增加
function tbWorldBossBase:OnDeath(pNpcKiller, nFlag)
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
			local nTeamId	= pPlayer.nTeamId;
		if nTeamId == 0 then
			if nFlag ~= 1 then
				pPlayer.AddKinReputeEntry(nWeiWang, "boss75");
		self:AwardXinDe(pPlayer, 300000);
		pPlayer.AddExp(7000000)
		pPlayer.AddBindMoney(400000);
		pPlayer.AddBindCoin(40000);--5v ??ng khóa
		pPlayer.Msg("<color=green>Hành trang trống >=5 để nhận<color> <color=yellow>Phần Thưởng<color>");
		
			end
		else
			local tbPlayerId, nMemberCount	= KTeam.GetTeamMemberList(nTeamId);
			for i, nPlayerId in pairs(tbPlayerId) do
				local pTeamPlayer = KPlayer.GetPlayerObjById(nPlayerId);
				if (pTeamPlayer and pTeamPlayer.nMapId == him.nMapId) then
					if nFlag ~= 1 then
						pTeamPlayer.AddKinReputeEntry(nWeiWang, "boss75");
							pTeamPlayer.AddExp(7000000)
		pTeamPlayer.AddBindMoney(400000);
		pTeamPlayer.AddBindCoin(40000);--5v ??ng khóa
		pTeamPlayer.Msg("<color=green>Hành trang trống >=5 để nhận<color> <color=yellow>Phần Thưởng<color>");
					end
				end
			end
		end
		local szMsg = "Hảo hữu của bạn ["..pPlayer.szName.."] đã đánh bại võ lâm cao thủ "..him.szName.."。";
		pPlayer.AddJbCoin(70000);
		pPlayer.Msg("<color=blue>Bạn đã tiêu diệt Boss 75 nhận được:<color> <color=yellow>7 vạn đồng thường<color>");
		-------------------------------------
		GlobalExcute({"Dialog:GlobalNewsMsg_GS","Người chơi<color=green>"..pPlayer.szName.."<color> đánh bại Võ Lâm Cao Thủ <color=red>"..him.szName.."<color> nhận được <color=gold>7 Vạn Đồng<color>"});
		KDialog.MsgToGlobal("Người chơi<color=green>"..pPlayer.szName.."<color> đánh bại Võ Lâm Cao Thủ <color=gold>"..him.szName.."<color> nhận được <color=yellow>7 Vạn Đồng<color>");
		------------------------------------------
		pPlayer.SendMsgToFriend(szMsg);
		Player:SendMsgToKinOrTong(pPlayer, " đã đánh bại võ lâm cao thủ "..him.szName.."。", 0);
		
		local szTongName = "Vô";
		local szBossName = him.szName;
		local szKillPlayerName = pPlayer.szName;
		local pTong = KTong.GetTong(pPlayer.dwTongId);
		if pTong then
			szTongName = pTong.GetName();
		end
		if not nFlag or nFlag ~= 1 then
			Dbg:WriteLog("[BossDeath]", szBossName, szKillPlayerName, szTongName);
		end
	end
	end;

function tbWorldBossBase:AwardXinDe(pPlayer, nXinDe)
	if (nXinDe > 0) then
		Setting:SetGlobalObj(pPlayer);
		Task:AddInsight(nXinDe);
		Setting:RestoreGlobalObj();
	end	
end

-- 世界唯Boss
local tbboss75	= Npc:GetClass("boss75");
tbboss75._tbBase = tbWorldBossBase;

function tbboss75:OnDeath(pNpcKiller)
	self._tbBase:OnDeath(pNpcKiller);
	Boss.tbboss75CallOut[him.nTemplateId] = nil;
	
	local pPlayer = pNpcKiller.GetPlayer();
	if not pPlayer then
		return 0
	end
	local nStockBaseCount = 0;
	local nHonor = 0;
	if him.nLevel >= 95 then
		nStockBaseCount = 1500;
		nHonor = 20;
	elseif him.nLevel >= 75 then
		nStockBaseCount = 500;
		nHonor = 12;
		if TimeFrame:GetStateGS("OpenBoss95") then
			nHonor = nHonor / 2;
		end
	elseif him.nLevel >= 55 then
		nStockBaseCount = 300;
		nHonor = 10;
		if TimeFrame:GetStateGS("OpenBoss95") then
			nHonor = nHonor / 4;
		elseif TimeFrame:GetStateGS("OpenBoss75") then
			nHonor = nHonor / 2;
		end
	end

	--增加建设资金和帮主、族长、个人的股份
	Tong:AddStockBaseCount_GS1(pPlayer.nId, nStockBaseCount, 0.1, 0.5, 0.1, 0, 0.3);	
	
	-- 队友共享
	local tbMember = pPlayer.GetTeamMemberList();
	if tbMember then
		for _, pMember in ipairs(tbMember) do
			if pMember.nId ~= pPlayer.nId then		-- 本人的话已经加过了
				--增加建设资金和帮主、族长、个人的股份		
				Tong:AddStockBaseCount_GS1(pMember.nId, nStockBaseCount, 0.1, 0.5, 0.1, 0, 0.3);	
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
		-- 增加无帮会族长的领袖荣誉
		local nCaptainId = Kin:GetPlayerIdByMemberId(nKinId, pKin.GetCaptain());
		PlayerHonor:AddPlayerHonorById_GS(nCaptainId, PlayerHonor.HONOR_CLASS_LINGXIU, 0, nHonor/2);
	end
end

-- 家族召唤Boss
local tbKinBoss	= Npc:GetClass("kinboss");
tbKinBoss._tbBase = tbWorldBossBase;
function tbKinBoss:OnDeath(pNpcKiller)
	self._tbBase:OnDeath(pNpcKiller, 1);
	-- KStatLog.ModifyAdd("mixstat", "家族Boss\t死亡\t"..him.szName, "总量", 1);
end
