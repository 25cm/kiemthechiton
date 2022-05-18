
-- ====================== 文件信息 ======================

-- 大漠古城 BOSS 脚本
-- Edited by peres
-- 2008/05/15 PM 20:27

-- 她的眼泪轻轻地掉落下来
-- 抚摸着自己的肩头，寂寥的眼神
-- 是，褪掉繁华和名利带给的空洞安慰，她只是一个一无所有的女子
-- 不爱任何人，亦不相信有人会爱她

-- ======================================================

local tbBoss_1			= Npc:GetClass("damogucheng_boss1");	-- 面具武士
local tbBoss_2			= Npc:GetClass("damogucheng_boss2");	-- 尸逐达鲁
local tbBoss_3			= Npc:GetClass("damogucheng_boss3");	-- 无名氏


function tbBoss_1:OnDeath(pNpc)
	local nNpcMapId, nNpcPosX, nNpcPosY	= him.GetWorldPos();
	
	-- 加一个袋子
	KNpc.Add2(2727, 1, -1, nNpcMapId, nNpcPosX, nNpcPosY);
	
	local pPlayer = pNpc.GetPlayer();
	if (pPlayer) then
		    pPlayer.AddStackItem(18,1,5001,51,tbItemInfo,10)
		pPlayer.AddStackItem(18,1,5002,52,tbItemInfo,10)
		pPlayer.Msg("Bạn đã tiêu diệt Boss nhận được: <color=yellow>10 Rương MG + 10 Rương VP<color>");
		pPlayer.DropRateItem(TreasureMap.tbDrop_Level_2["Npc_Boss1"], 24, -1, -1, him);
		TreasureMap:AwardWeiWangAndXinde(pPlayer, 2, 5, 1, 100000);
	end
	
end;

function tbBoss_2:OnDeath(pNpc)
	local nNpcMapId, nNpcPosX, nNpcPosY	= him.GetWorldPos();
	
	-- 加一个袋子
	KNpc.Add2(2729, 1, -1, nNpcMapId, nNpcPosX, nNpcPosY);
	--KNpc.Add2(2597, 1, -1, nNpcMapId, 1914, 3313);
	
	local pPlayer = pNpc.GetPlayer();
	if (pPlayer) then
		    pPlayer.AddStackItem(18,1,5001,51,tbItemInfo,10)
		pPlayer.AddStackItem(18,1,5002,52,tbItemInfo,10)
		pPlayer.Msg("Bạn đã tiêu diệt Boss nhận được: <color=yellow>10 Rương MG + 10 Rương VP<color>");
		pPlayer.DropRateItem(TreasureMap.tbDrop_Level_2["Npc_Boss2"], 24, -1, -1, him);
		TreasureMap:AwardWeiWangAndXinde(pPlayer, 2, 5, 1, 100000);
	end
	
end;

function tbBoss_3:OnDeath(pNpc)
	local nNpcMapId, nNpcPosX, nNpcPosY	= him.GetWorldPos();
		KNpc.Add2(2597, 1, -1, nNpcMapId, nNpcPosX, nNpcPosY);
		-------------------------------------------------
	local nSubWorld, _, _	= him.GetWorldPos();
	local tbInstancing = TreasureMap:GetInstancing(nSubWorld);
	assert(tbInstancing);
	
	tbInstancing.nBoss_3_kill		= 1;
	local pPlayer = pNpc.GetPlayer();
	if (pPlayer) then
	
				pPlayer.AddJbCoin(100000);--5v ??ng khóa
				pPlayer.AddExp(10000000)
pPlayer.AddStackItem(18,1,1331,2,nil,2);
		pPlayer.AddBindMoney(300000);
		pPlayer.AddBindCoin(50000);--5v ??ng khóa
		pPlayer.Msg("Bạn đã tiêu diệt <color=green>Boss cuối Phó Bản Đại Mạc Cổ Thành<color> nhận được: <color=yellow>10 vạn đồng thường<color>");
	-----------------------------------------
        GlobalExcute({"Dialog:GlobalNewsMsg_GS","Người chơi <color=green>"..pPlayer.szName.."<color> tiêu diệt Boss Tàng Bản Đồ <color=red>Đại Mạc Cổ Thành<color> nhận được <color=gold>10 Vạn Đồng<color>"});
		KDialog.MsgToGlobal("Người chơi <color=green>"..pPlayer.szName.."<color> tiêu diệt Boss Tàng Bản Đồ <color=gold>Đại Mạc Cổ Thành<color> nhận được <color=yellow>10 Vạn Đồng<color>");
		
------------------------------------------------------
		pPlayer.DropRateItem(TreasureMap.tbDrop_Level_2["Npc_Boss2"], 24, -1, -1, him);
		TreasureMap:AwardWeiWangAndXinde(pPlayer, 2, 5, 1, 100000);	
		-- 副本任务的处理
		local tbTeamMembers, nMemberCount	= pPlayer.GetTeamMemberList();
		
		if (not tbTeamMembers) or (nMemberCount <= 0) then
			TreasureMap:InstancingTask(pPlayer, tbInstancing.nMapTemplateId);
			return;
		else
			for i=1, nMemberCount do
				local pNowPlayer	= tbTeamMembers[i];
				TreasureMap:InstancingTask(pNowPlayer, tbInstancing.nMapTemplateId);
			end
		end
		-- 添加亲密度
		TreasureMap:AddFriendFavor(tbTeamMembers, pPlayer.nMapId, 50);
		
		-- 师徒成就：副本大漠古城
		TreasureMap:GetAchievement(tbTeamMembers, Achievement.FUBEN_DAMOGUCHENG, pPlayer.nMapId);
	end	
	
	if tbInstancing.tbStele_1_Idx then
		for i=1, #tbInstancing.tbStele_1_Idx do
			local pNpc	= KNpc.GetById(tbInstancing.tbStele_1_Idx[i]);
			if pNpc then
				pNpc.Delete();
			end;
		end;
	end;
	
end;