
local tbHLTreasureBox = Npc:GetClass("hl_baoxiang");

tbHLTreasureBox.ALL_LOCK_COUNT 	= 5; 	--箱子的总层数
tbHLTreasureBox.COST_TIME			= 100	--开箱需要的时间
tbHLTreasureBox.TIRED_DURATION		= 5 * Env.GAME_FPS;	-- 劳累持续时间
tbHLTreasureBox.TIRED_SKILLID		= 389;	--技能 用于控制时间间隔

tbHLTreasureBox.tbProlibity = {
			50,
			30,
			20,
		}

-- 在开启每层宝箱时 掉落的物品及物品的数量
tbHLTreasureBox.tbDrapItem = 
{
	{szDropItemFilePath = "setting\\npc\\droprate\\renwudiaoluo\\baoxiang_lv1.txt", nDrapItemCount = 6,},
	{szDropItemFilePath = "setting\\npc\\droprate\\renwudiaoluo\\baoxiang_lv2.txt", nDrapItemCount = 6,},
	{szDropItemFilePath = "setting\\npc\\droprate\\renwudiaoluo\\baoxiang_lv3.txt", nDrapItemCount = 6,},
	{szDropItemFilePath = "setting\\npc\\droprate\\renwudiaoluo\\baoxiang_lv4.txt", nDrapItemCount = 6,},
	{szDropItemFilePath = "setting\\npc\\droprate\\renwudiaoluo\\baoxiang_lv5.txt", nDrapItemCount = 6,},
}

-- 打开一层
function tbHLTreasureBox:DecreaseLockLayer(pPlayer, pNpc)
	if not pPlayer or not pNpc then
		return;	
	end
	
	local tbNpcData = pNpc.GetTempTable("Task"); 
	assert(tbNpcData);
	
	if (5 <= tbNpcData.CUR_LOCK_COUNT) then
		return;
	end
	
	tbNpcData.CUR_LOCK_COUNT = tbNpcData.CUR_LOCK_COUNT + 1;
	KTeam.Msg2Team(pPlayer.nTeamId, pPlayer.szName.." mở lớp khóa thứ <color=yellow>" .. tbNpcData.CUR_LOCK_COUNT .. "<color>!");
	
	if (tbNpcData.CUR_LOCK_COUNT <= 5) then
		local tbLayerInfo = self.tbDrapItem[tbNpcData.CUR_LOCK_COUNT];
		pPlayer.DropRateItem(tbLayerInfo.szDropItemFilePath, tbLayerInfo.nDrapItemCount, -1, -1, pNpc);
	end
	--最后一层
	if(tbNpcData.CUR_LOCK_COUNT == 5) then 
		KTeam.Msg2Team(pPlayer.nTeamId, "<color=yellow>Rương đã được mở<color>!");
		tbNpcData.CUR_LOCK_COUNT = 0;
		local nEntryWayRate = MathRandom(100);
		--print(self.tbProlibity[tbNpcData.nHongLianDiYu], nEntryWayRate);
		if (tbNpcData.nHongLianDiYu and tbNpcData.nHongLianDiYu > 0 and tbNpcData.nHongLianDiYu < 4 and self.tbProlibity[tbNpcData.nHongLianDiYu] > nEntryWayRate) then	
			local nMapId, nPosX, nPosY = pNpc.GetWorldPos();
			local pBox = KNpc.Add2(4277, 120, -1, nMapId, nPosX, nPosY);
			local tbData = pBox.GetTempTable("Task");
			tbData.nHongLianDiYu = tbNpcData.nHongLianDiYu;
			local tbInstancing = Task.tbArmyCampInstancingManager:GetInstancing(nMapId);
			if (tbInstancing) then
				--Lib:ShowTB(tbInstancing.tbKuoZhanQuOut);
				tbInstancing.tbKuoZhanQuOut[tbData.nHongLianDiYu] = 1;
			end;
			
			local tbPlayList, _ = KPlayer.GetMapPlayer(nMapId);
			for _, teammate in ipairs(tbPlayList) do
				Task.tbArmyCampInstancingManager:ShowTip(teammate, "Có một đường hầm bí ẩn phía trước");
			end;
		end;
		pNpc.Delete();
	end
end

--开启宝箱
function tbHLTreasureBox:OnCheckOpen(nPlayerId, nNpcId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc or pNpc.nIndex == 0) then
		return;
	end
	
	local tbNpcData = pNpc.GetTempTable("Task"); 
	assert(tbNpcData);
	
	local nCurLockLayer = tbNpcData.CUR_LOCK_COUNT;
	if (5 <= nCurLockLayer) then
		-- 已经全部打开
		return;
	end
	
	pPlayer.AddSkillState(self.TIRED_SKILLID, 1, 1, self.TIRED_DURATION);
	self:DecreaseLockLayer(pPlayer, pNpc);
end

--点击宝箱时对话
function tbHLTreasureBox:OnDialog()
	
	local pNpc = KNpc.GetById(him.dwId);
	if (not pNpc or pNpc.nIndex == 0) then
		return;
	end
	--间隔时间是否到	
	local nRet = me.GetSkillState(self.TIRED_SKILLID);
	if (nRet ~=  -1) then
		Dialog:SendInfoBoardMsg(me, "<color=red>Bạn đã mệt rồi hãy nghỉ ngơi rồi sau đó mở tiếp!<color>");
		return;
	end
	--打断开启事件
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
	--开启宝箱
	GeneralProcess:StartProcess("Mở rương...", tbHLTreasureBox.COST_TIME, {self.OnCheckOpen, self, me.nId, him.dwId}, {me.Msg, "Mở bị gián đoạn"}, tbEvent);
end