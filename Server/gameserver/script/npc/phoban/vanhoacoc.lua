
-- uniqueboss 模板
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

	if (pPlayer) then
		self:AwardXinDe(pPlayer, 300000);
		local nTeamId	= pPlayer.nTeamId;
		if nTeamId == 0 then
			if nFlag ~= 1 then
				pPlayer.AddKinReputeEntry(nWeiWang, "vanhoacoc");
															pPlayer.AddExp(30000000)
		pPlayer.AddStackItem(18,1,553,1,tbItemInfo,50) --tien du long
			pPlayer.Earn(300000,0);
		pPlayer.AddBindMoney(300000);
		pPlayer.AddJbCoin(100000);
		pPlayer.AddBindCoin(20000);--5v ??ng khóa
		pPlayer.Msg("<color=green>Hành trang trống >=5 để nhận<color> <color=yellow>Phần Thưởng<color>");
				
			end
		else
			local tbPlayerId, nMemberCount	= KTeam.GetTeamMemberList(nTeamId);
			for i, nPlayerId in pairs(tbPlayerId) do
				local pTeamPlayer = KPlayer.GetPlayerObjById(nPlayerId);
				if (pTeamPlayer and pTeamPlayer.nMapId == him.nMapId) then
					if nFlag ~= 1 then
						pTeamPlayer.AddKinReputeEntry(nWeiWang, "vanhoacoc");
																			pTeamPlayer.AddExp(30000000)
		pTeamPlayer.AddStackItem(18,1,553,1,tbItemInfo,50) --tien du long
			pTeamPlayer.Earn(300000,0);
		pTeamPlayer.AddBindMoney(300000);
		pTeamPlayer.AddJbCoin(20000);
		pTeamPlayer.AddBindCoin(20000);--5v ??ng khóa
		pTeamPlayer.Msg("<color=green>Hành trang trống >=5 để nhận<color> <color=yellow>Phần Thưởng<color>");
					end
				end
			end
		end
		local szMsg = "Hảo hữu của bạn ["..pPlayer.szName.."] đã đánh bại cao thủ "..him.szName.." tại phó bản Vạn Hoa Cốc.";
		pPlayer.SendMsgToFriend(szMsg);
		Player:SendMsgToKinOrTong(pPlayer, " đã đánh bại cao thủ "..him.szName.." tại phó bản Vạn Hoa Cốc.", 0);
		
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


