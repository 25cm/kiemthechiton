-- 宋金马夫（车夫）脚本

local tbNpc	= Npc:GetClass("Longtruphekim");
tbNpc.nGouhuoSkillId		= 377;		-- 篝火的技能Id
function tbNpc:OnDialog()
local nCmp = me.GetTask(Battle.TSKGID, Battle.TASKID_BTCAMP);
	if nCmp == 2 then
	return 0;
	end
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
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
	}
	 local tbOpt = {
				 GeneralProcess:StartProcess("Đang chiếm lĩnh", 1 * Env.GAME_FPS, {self.OnDialog4, self,nCmp,him.dwId}, nil, tbEvent);
	 };
end
function tbNpc:OnDialog4(nCmp,nNpcId)
	if nCmp ~= 1 then
	return
	end 
	
	local pNpc = KNpc.GetById(nNpcId);
	local nMapId, nX, nY = pNpc.GetWorldPos();
	if not pNpc then
		return 0
	end
	ClearMapNpcWithName(nMapId,"Điêu Tượng Phe Kim");
	if nCmp == 1 then 
		local tbNpc	= Npc:GetClass("Longtruphetong");
		local pNpc2 = KNpc.Add2(7411,100,-1,nMapId, nX, nY);
		local szMsg = "<color=pink> Người Chơi Phe Tống <color=yellow>["..me.szName.."]<color>Đã Chiếm Lĩnh<color=yellow>Tượng Nguyên Soái Thành Công<color>";
        KDialog.MsgToGlobal(szMsg);
		tbNpc:StartNpcTimer(pNpc2.dwId)
	end
		-- local szMsg	= "Long Trụ đã xuất hiện,hãy mau mau chiếm lĩnh...";
	-- local tbPlayerList	= self.tbMission:GetPlayerList(nCmp);
	-- for _, pPlayer in pairs(tbPlayerList) do
		-- Dialog:SendInfoBoardMsg(pPlayer, szMsg);
	-- end

end
function tbNpc:StartNpcTimer(nNpcId)
		local pNpc = KNpc.GetById(nNpcId);
		if not pNpc then
			return 0
		end
		local tbTmp = pNpc.GetTempTable("Npc");
		Timer:Register(15 * Env.GAME_FPS, self.OnNpcTimer, self, nNpcId);
end
function tbNpc:OnNpcTimer(nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		return 0
	end
	self:AddAroundPlayersExp(nNpcId);							-- 给Npc周围队伍玩家加经验
	return 15 * Env.GAME_FPS;
end 
function tbNpc:AddAroundPlayersExp(nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc) then
		return 0;
	end
	local tbTmp			 = pNpc.GetTempTable("Npc");
	local tbPlayer = KNpc.GetAroundPlayerList(nNpcId, 120);
	local tbPlayerId = {};
	if tbPlayer then
		for _, pPlayer in pairs(tbPlayer) do
			local nCmp = pPlayer.GetTask(Battle.TSKGID, Battle.TASKID_BTCAMP);
			if nCmp == 2 then
			table.insert(tbPlayerId, pPlayer.nId);
			end
		end
	end
	for _, nPlayerId in pairs(tbPlayerId) do
		self:AddExp2Player(nPlayerId, nNpcId);
	end
	
end
function tbNpc:AddExp2Player(nPlayerId, nNpcId)
	local szMsg		= "<color=green>Ngươi có công bảo vệ long trụ 15 giây , nhận được : <color=yellow> 50.000 Exp, 300 Đồng, 1 Tiền Du Long<color>";
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	if pPlayer == nil then
		return 0;
	end
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc) then
		return 0;
	end
	local tbTmp		= pNpc.GetTempTable("Npc");
	pPlayer.CastSkill(self.nGouhuoSkillId, 20, -1, pPlayer.GetNpc().nIndex);
	pPlayer.AddExp(50000); --Exp
	pPlayer.AddJbCoin(300); --Đồng
	pPlayer.Earn(5000,0);
	pPlayer.AddStackItem(18,1,553,1,nil, 1); --
	local tbBattleInfo	= Battle:GetPlayerData(pPlayer);
					--if (0 < tbBattleInfo:AddBounsWithoutCamp(50)) then
						--tbBattleInfo.nProtectBouns = tbBattleInfo.nProtectBouns + 50;
					--end
					pPlayer.Msg(szMsg);

end


