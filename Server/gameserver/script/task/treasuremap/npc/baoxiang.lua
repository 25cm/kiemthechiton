
-- 宝箱
local tbTreasureBox = Npc:GetClass("treasurebox");

-- 藏宝贼
tbTreasureBox.tbSetting = 
{
	{nOpenRate = 100, nMuggerRate = 0, nMin = 1, nMax = 3, nDuration = 10 * Env.GAME_FPS},
--	{nOpenRate = 100, nMuggerRate = 60, nMin = 2, nMax = 3, nDuration = 10 * Env.GAME_FPS},
--	{nOpenRate = 100, nMuggerRate = 60, nMin = 2, nMax = 5, nDuration = 10 * Env.GAME_FPS},
--	{nOpenRate = 100, nMuggerRate = 50, nMin = 3, nMax = 5, nDuration = 10 * Env.GAME_FPS},
--	{nOpenRate = 100, nMuggerRate = 50, nMin = 3, nMax = 5, nDuration = 10 * Env.GAME_FPS},
--	{nOpenRate = 30, nMuggerRate = 30, nMin = 3, nMax = 5, nDuration = 10 * Env.GAME_FPS},
}

-- 每个等级宝箱对应的玩家等级和锁的层次
tbTreasureBox.tbLevelLimit	= {
	[1] = {20, 1},
	[2]	= {50, 1},
	[3]	= {70, 1},	
}

-- 当前面对第几层锁
function tbTreasureBox:GetCurLockLayer(pNpc)
	local tbNpcData = pNpc.GetTempTable("TreasureMap");
	if (not tbNpcData.nTreasureBoxLockLayer) then
		tbNpcData.nTreasureBoxLockLayer = 1;
	end
	
	return tbNpcData.nTreasureBoxLockLayer;
end

function tbTreasureBox:DecreaseLockLayer(pPlayer, pNpc)
	local tbNpcData = pNpc.GetTempTable("TreasureMap");
	if (not tbNpcData.nTreasureBoxLockLayer) then
		tbNpcData.nTreasureBoxLockLayer = 1;
	end

	-- 宝箱的等级不同，层数也不同
	if not pPlayer or not pNpc then
		return;	
	end;
	
	local nLockLevel	= self.tbLevelLimit[self:GetBoxLevel(pNpc)][2];
	
	local nMapId, nPosX, nPosY = pPlayer.GetWorldPos();
	local szMapName	= GetMapNameFormId(nMapId);
	local nShowX = math.ceil(nPosX/8);
	local nShowY = math.ceil(nPosY/16);
	
	--  当前服务器得到通知
	TreasureMap:NotifyAroundPlayer(pPlayer, pPlayer.szName.."Đã mở Bảo rương!");
	self:AddOpenTime(pPlayer);
	tbNpcData.nTreasureBoxLockLayer = tbNpcData.nTreasureBoxLockLayer + 1;
	if (tbNpcData.nTreasureBoxLockLayer > nLockLevel) then
		if (pNpc and pNpc.nIndex > 0) then
			
			local nBoxLevel = self:GetBoxLevel(pNpc);
			if nBoxLevel == 1 then
				pPlayer.DropRateItem(TreasureMap.szBaoXiangDropFilePath, TreasureMap.nTreasureBoxDropCount, -1, -1, pNpc);
			elseif nBoxLevel==2 then
				pPlayer.DropRateItem(TreasureMap.szBoxOutsideDrop, TreasureMap.nTreasureBoxDropCount, -1, -1, pNpc);
			elseif nBoxLevel==3 then
				pPlayer.DropRateItem(TreasureMap.szBoxOutsideDrop_Level3, TreasureMap.nTreasureBoxDropCount, -1, -1, pNpc);
			end;
			
			pPlayer.Msg("<color=yellow>Rương đã mở<color>!")
			local nTimerId = pNpc.GetTempTable("TreasureMap").nDeleteTimeId;
			if (nTimerId) then
				Timer:Close(nTimerId);
			end
			pNpc.Delete();
		end
	end
end

function tbTreasureBox:GetDependentTreasureId(pNpc)
	local tbNpcData = pNpc.GetTempTable("TreasureMap");
	return tbNpcData.nTreasureId;
end

-- 得到一个宝箱的等级（初中高级藏宝图都有对应不同的宝箱）
function tbTreasureBox:GetBoxLevel(pNpc)
	local nTreasureId	= self:GetDependentTreasureId(pNpc)
	local tbInfo		= TreasureMap:GetTreasureInfo(nTreasureId);	
	
	return tbInfo.Level;
end;

function tbTreasureBox:OnDialog()
	
	local pNpc = KNpc.GetById(him.dwId);
	if (not pNpc or pNpc.nIndex == 0) then
		return;
	end

	local tbNpcData = him.GetTempTable("TreasureMap");
	assert(tbNpcData.nPlayerId);
	local pOpener = KPlayer.GetPlayerObjById(tbNpcData.nPlayerId);
	
	if not pOpener then
		local szMsg = "Không thể mở rương người khác!"
		Dialog:SendInfoBoardMsg(me, szMsg);		
		return;
	end;
	
	local nTeamId = pOpener.nTeamId;
	
	if (me.nTeamId == 0) then
		local szMsg = "Tổ đội mới mở được rương!"
		Dialog:SendInfoBoardMsg(me, szMsg);
		return;
	end
	
	if (me.nTeamId ~= nTeamId) then
		local szMsg = "Chỉ có đội ngũ ở <color=yellow>"..pOpener.szName.."<color> mới mở được rương này!"
		Dialog:SendInfoBoardMsg(me, szMsg);
		return;
	end
	
	-- 队伍中有人本周开箱子次数过多
	local nRet, szErrorMsg = self:CheckTeammateOpenTime(me);
	if (nRet ~= 1) then
		local szMsg = szErrorMsg;
		Dialog:SendInfoBoardMsg(me, szMsg);
		return;
	end
	
	local nBoxLevel = self:GetBoxLevel(pNpc);
	
	if me.nLevel < self.tbLevelLimit[nBoxLevel][1] then
		Dialog:SendInfoBoardMsg(me, "<color=red>Cấp của bạn chưa mở được Bảo rương này!<color>");
		return;
	end;
	
	if (me.nFaction == 0) then
		Dialog:SendInfoBoardMsg(me, "<color=red>Bạn chưa gia nhập môn phái, không thể mở Bảo rương này!<color>");
		return;
	end
		
	local nRet = me.GetSkillState(TreasureMap.nTiredSkillId);
	if (nRet ~=  -1) then
		Dialog:SendInfoBoardMsg(me, "<color=red>Ngươi mệt rồi cần nghỉ ngơi mới mở được rương!<color>");
		return;
	end
	
	local nCurLockLayer = self:GetCurLockLayer(him);
	
	local tbLayerInfo	= self.tbSetting[nCurLockLayer];
	assert(tbLayerInfo);
	local tbEvent = 
	{
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SITE,
		Player.ProcessBreakEvent.emEVENT_USEITEM,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_DROPITEM,
		Player.ProcessBreakEvent.emEVENT_SENDMAIL,		
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
	}
	
	GeneralProcess:StartProcess("Mở Bảo Rương", tbLayerInfo.nDuration, {self.OnCheckOpen, self, me.nId, him.dwId}, {me.Msg, "Mở bị gián đoạn"}, tbEvent);
end

-- 试图打开
function tbTreasureBox:OnCheckOpen(nPlayerId, nNpcId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc or pNpc.nIndex == 0) then
		return;
	end
	local nCurLockLayer = self:GetCurLockLayer(pNpc);
	if (nCurLockLayer <= 0) then
		-- 已经打开过的
		return;
	end
	
	--打开时也要判断是否组队  zounan
	if (pPlayer.nTeamId == 0) then
	--	local szMsg = "只有组队才能开启宝箱！"  不给信息或许比较好
	--	Dialog:SendInfoBoardMsg(pPlayer, szMsg);
		return;
	end
	
	local nRet, szErrorMsg = self:CheckTeammateOpenTime(pPlayer);
	if (nRet ~= 1) then
		local szMsg = szErrorMsg;
		Dialog:SendInfoBoardMsg(me, szMsg);
		return;
	end
	
	pPlayer.AddSkillState(TreasureMap.nTiredSkillId, 1, 1, TreasureMap.nTiredDuration)
	
	local tbLayerInfo	= self.tbSetting[nCurLockLayer];
	assert(tbLayerInfo);
	local nOpenRate = MathRandom(100);
	if (nOpenRate > tbLayerInfo.nOpenRate) then
		pPlayer.Msg("<color=yellow>Mở Bảo rương thất bại!<color>");
		return;
	end
	
	-- 不再有夺宝贼
--	local nCallMuggerRate = MathRandom(100);
--	if (nCallMuggerRate <= tbLayerInfo.nMuggerRate) then
--		local nTreasureId = self:GetDependentTreasureId(pNpc);
--		TreasureMap:AddTreasureMugger(pPlayer, nTreasureId, tbLayerInfo.nMin, tbLayerInfo.nMax);
--	end
	
	self:DecreaseLockLayer(pPlayer, pNpc);
	
end


function tbTreasureBox:CheckTeammateOpenTime(pPlayer)
	assert(pPlayer.nTeamId ~= 0);
	
	local tbTeamPlayer, nCount = pPlayer.GetTeamMemberList();
	for _, pTeammate in ipairs(tbTeamPlayer) do
		if (pTeammate.GetTask(TreasureMap.TSKGID, TreasureMap.TSK_OPENBOX) >= TreasureMap.MAXOPENTIME_PERWEEK) then
			if (pPlayer.nId  == pTeammate.nId) then
				return nil, "Mở Bảo rương tuần này đã vượt quá <color=yellow>"..TreasureMap.MAXOPENTIME_PERWEEK.."<color> lần, không thể mở tiếp!";
			else
				return nil, "Đồng đội <color=yellow>"..pTeammate.szName.."<color> tuần này đã mở bảo rương hơn <color=yellow>"..TreasureMap.MAXOPENTIME_PERWEEK.."<color> lần, không thể tổ đội mở Bảo rương!";
			end
		end
	end
	
	return 1;
end

function tbTreasureBox:AddOpenTime(pPlayer)
	assert(pPlayer.nTeamId ~= 0);
	
	local tbTeamPlayer, nCount = pPlayer.GetTeamMemberList();
	for _, pTeammate in ipairs(tbTeamPlayer) do
		local nTime = pTeammate.GetTask(TreasureMap.TSKGID, TreasureMap.TSK_OPENBOX);
		pTeammate.SetTask(TreasureMap.TSKGID, TreasureMap.TSK_OPENBOX, nTime + 1, 1);
		pTeammate.Msg("Số lần bạn mở bảo rương tuần này là <color=yellow>"..(nTime + 1).."<color> lần!");
	end
end
