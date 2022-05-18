
-- 第二层左边的 BOSS
local tbNpc_1	= Npc:GetClass("caishiquboss");

tbNpc_1.ENTRYWAY_RATE =  1000; --打死BOSS后出现秘径的概率

function tbNpc_1:OnDeath(pNpc)
	local nSubWorld, nNpcPosX, nNpcPosY	= him.GetWorldPos();

	local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nSubWorld);
	assert(tbInstancing);
	tbInstancing.nCaiShiQuPass = 1;
	local pPlayer  	= pNpc.GetPlayer();
	-------------------------------------------
			pPlayer.AddExp(10000000)
			pPlayer.AddStackItem(18,1,1331,2,nil,2);
		pPlayer.AddBindMoney(500000);
		pPlayer.AddBindCoin(50000);--5v ??ng khóa
        pPlayer.AddJbCoin(100000);	
		pPlayer.Msg("Bạn đã tiêu diệt <color=blue>Boss cuối Hậu Phục Ngưu Sơn<color> nhận được: <color=yellow>10 vạn đồng thường<color>");
		-------------------------------------------------
		      GlobalExcute({"Dialog:GlobalNewsMsg_GS","Người chơi<color=green>"..pPlayer.szName.."<color> tiêu diệt Boss Quân Doanh <color=red>Hậu Phục Ngưu Sơn<color> nhận được <color=gold>10 Vạn Đồng<color>"});
		KDialog.MsgToGlobal("Người chơi<color=green>"..pPlayer.szName.."<color> tiêu diệt Boss Quân Doanh <color=gold>Hậu Phục Ngưu Sơn<color> nhận được <color=yellow>10 Vạn Đồng<color>");
			----------------------------------------------------------------------
	local nEntryWayRate = MathRandom(100);
	if (self.ENTRYWAY_RATE < nEntryWayRate) then	
		-- 开出秘径
		
		local pEntryway = KNpc.Add2(4114, 1, -1, nSubWorld, nNpcPosX, nNpcPosY);
		local tbNpcData = pEntryway.GetTempTable("Task");
		tbNpcData.nEntrancePlayerId = pPlayer.nId;
		tbNpcData.nEntryMapId	= nSubWorld;
		KTeam.Msg2Team(pPlayer.nTeamId, pPlayer.szName.."Phát hiện lối đi bí mật vào phục ngưu sơn trang!");
	end;
	
	KNpc.Add2(2793, 1, -1, nSubWorld, 1694, 3862);
	local tbPlayList, nCount = KPlayer.GetMapPlayer(tbInstancing.nMapId)
	
	-- 用于老玩家召回任务完成任务记录
--	local tbMemberList = pPlayer.GetTeamMemberList();	
	for _, player in ipairs(tbPlayList) do 
		Task.OldPlayerTask:AddPlayerTaskValue(player.nId, 2082, 4);
	end;
	
	-- 增加队长的领袖荣誉
	local tbHonor = {[3] = 24, [4] = 36, [5] = 48, [6] = 60}; -- 3、4、5、6人队长的领袖荣誉表
	local tbTeamPlayer, _ = KTeam.GetTeamMemberList(pPlayer.nTeamId);	
	if tbHonor[nCount] and tbTeamPlayer then
	-------------------------------------------------
								pTeamPlayer.AddExp(30000000)
		pTeamPlayer.AddBindMoney(500000);
		pTeamPlayer.AddBindCoin(50000);--5v ??ng khóa
		pTeamPlayer.Msg("<color=green>Hành trang trống >=5 để nhận<color> <color=yellow>Phần Thưởng<color>");
		------------------------------------------------------
		PlayerHonor:AddPlayerHonorById_GS(tbTeamPlayer[1], PlayerHonor.HONOR_CLASS_LINGXIU, 0, tbHonor[nCount]);
	end
	
	-- 四次任务
	for _, player in ipairs(tbPlayList) do 
		local tbPlayerTasks	= Task:GetPlayerTask(player).tbTasks;
		local tbTask1 = tbPlayerTasks[381];
		local tbTask2 = tbPlayerTasks[429]
		if ((tbTask1 and tbTask1.nReferId == 565) or (tbTask2 and tbTask2.nReferId == 622)) then
			player.SetTask(1022, 200, player.GetTask(1022, 200) + 1);
		end;
		
		-- 额外奖励回调
		local nFreeCount, tbFunExecute = SpecialEvent.ExtendAward:DoCheck("ArmyCampBoss", player);
		SpecialEvent.ExtendAward:DoExecute(tbFunExecute);
	end;
end

