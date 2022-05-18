
-- 副本入口Npc
local tbInstancingEntrancePoint = Npc:GetClass("instancingentrancepoint");

function tbInstancingEntrancePoint:OnDialog()
	local tbNpcData = him.GetTempTable("TreasureMap");
	assert(tbNpcData.nEntrancePlayerId);
	local pOpener = KPlayer.GetPlayerObjById(tbNpcData.nEntrancePlayerId);
	if (not pOpener) then
		return;
	end
	
	local nTeamId = pOpener.nTeamId;
	
	if (me.nTeamId == 0) then
		local szMsg = "Chỉ tổ đội mới vào được mê cung dưới đất này!"
		Dialog:SendInfoBoardMsg(me, szMsg);
		return;
	end
	
	if (me.nTeamId ~= nTeamId) then
		local szMsg = "Chỉ có đội ngũ ở <color=yellow>"..pOpener.szName.."<color> mới vào được mê cung dưới đất này!"
		Dialog:SendInfoBoardMsg(me, szMsg);
		return;
	end
	
	-- 进入副本的等级限制
	local tbLevelLimit	= {
		[1] = 256, --mặc định 50
		[2]	= 256, --mặc định 80
		[3]	= 256,	
	}
	
	local nTreasureId 		= tbNpcData.nEntranceTreasureId;
	local nTreasureMapId 	= tbNpcData.nTreasureMapId;
	local nTreasureMapLevel	= tbNpcData.nTreasureMapLevel;
	local nMapTemplateId 	= tbNpcData.nMapTemplateId;
	
	if tbLevelLimit[nTreasureMapLevel] then
		if me.nLevel >= tbLevelLimit[nTreasureMapLevel] then
			Dialog:SendInfoBoardMsg(me, "Cấp của bạn không thích hợp vào phó bản này!");
			return;
		end;
	end;
	
	Dialog:Say("Muốn vào phó bản ngay?", 
		{"Đồng ý", self.Enter, self, me.nId, him.dwId, nTreasureId, nTreasureMapId, nMapTemplateId},
		{"Tạm thời không đi"})
end

function tbInstancingEntrancePoint:Enter(nPlayerId, nNpcId, nTreasureId, nTreasureMapId, nMapTemplateId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	assert(pPlayer);
	local pNpc = KNpc.GetById(nNpcId);
	if (TreasureMap:IsInstancingFree(nTreasureId, nTreasureMapId) == 1) then
		pPlayer.Msg("<color=yellow>Mê cung dưới đất mà bạn phát hiện đã bị sập!<color>");
		if (pNpc) then
			pNpc.Delete();
		end
		return;
	end
	
	local tbInstancing = TreasureMap.InstancingMgr:GetInstancing(nTreasureMapId);
	if (not tbInstancing) then
		assert(false);
	end
	
	
	local tbTreasureInfo = TreasureMap:GetTreasureInfo(nTreasureId);
	
	-- 第一次进入

	if (not tbInstancing.tbPlayerList[nPlayerId]) then
		local nEnterTimes = pPlayer.GetTask(2066, tbTreasureInfo.InstancingMapId);
		local nLimitTimes = tbTreasureInfo.EnterLimtPerWeek;

		if (nLimitTimes > 0 and nEnterTimes >= nLimitTimes) then
			Dialog:SendInfoBoardMsg(pPlayer, "Mỗi tuần, phó bản này có thể vào <color=yellow> "..nLimitTimes.." <color> lần.")
			return;
		end
		
		local nPlayerCount = 0;
		for _,_ in pairs(tbInstancing.tbPlayerList) do
			nPlayerCount = nPlayerCount + 1;
		end
		
		if (nPlayerCount >= TreasureMap.nMaxPlayer) then
			Dialog:SendInfoBoardMsg(pPlayer, "Số người vào phó bản này đã đủ <color=yellow>"..nPlayerCount.."<color> người.")
			return;
		end
		
		-- 在这里设置每一个进入副本的队友状态（除了副本主人之外）
		-- 不是副本的主人，并且队友任务状态已经是 0
		if TreasureMap.TSK_INS_TBTASK[nMapTemplateId] then
		
			local nMainTaskState 	= pPlayer.GetTask(TreasureMap.TSKGID, TreasureMap.TSK_INS_TBTASK[nMapTemplateId][1]);
			local nTeamTaskState 	= pPlayer.GetTask(TreasureMap.TSKGID, TreasureMap.TSK_INS_TBTASK[nMapTemplateId][2]);
			
			local nHaveMainTask		= Task:HaveTask(pPlayer, TreasureMap.TSK_INS_TBTASK[nMapTemplateId][3]);
			local nHaveTeamTask		= Task:HaveTask(pPlayer, TreasureMap.TSK_INS_TBTASK[nMapTemplateId][4]);

			
			-- 对队友任务异常作除错（变量大于 1 但身上没任务）
			if nHaveTeamTask == 0 and nTeamTaskState>1 then
				print("Tổ đội Tàng Bảo Đồ khác thường, phải xử lý sai phạm:", nMapTemplateId);
				nTeamTaskState = 0;
			end;
			
			if nMainTaskState ~=1 and nTeamTaskState <= 1 then
				pPlayer.SetTask(TreasureMap.TSKGID, TreasureMap.TSK_INS_TBTASK[nMapTemplateId][2], 1, 1);
			end;
			
		end;
		
		pPlayer.SetTask(2066, tbTreasureInfo.InstancingMapId,  nEnterTimes + 1, 1);
	end
	
	tbInstancing.tbPlayerList[nPlayerId] = 1;
	pPlayer.NewWorld(nTreasureMapId, tbTreasureInfo.InstancingMapX, tbTreasureInfo.InstancingMapY);
	TreasureMap:SetMyInstancingTreasureId(pPlayer, nTreasureId);
	pPlayer.SetFightState(1);
end
