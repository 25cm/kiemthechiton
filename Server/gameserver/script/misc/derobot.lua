-------------------------------------------------------------------
--File: derobot.lua
--Author: luobaohang
--Date: 2008-12-9 19:48
--Describe: 反外挂脚本(GS、GC)
-------------------------------------------------------------------
DeRobot.N_CODE = 3; -- 非法客户端判定的设1，这个设3（第一版为2）
DeRobot.tbBandHwId = DeRobot.tbBandHwId or {};
DeRobot.tbHwMulti = DeRobot.tbHwMulti or {};
DeRobot.tbIpHwMulti = DeRobot.tbIpHwMulti or {};
DeRobot.tbHwBanTimer = DeRobot.tbHwBanTimer or {};
DeRobot.tbHwBanMinTimer = DeRobot.tbHwBanTimer or {};
DeRobot.BAN_MULTI_NUM = 9;	-- 此值需>=7
DeRobot.BAN_MIN_NUM = 7;	-- 此值需>=7
DeRobot.BAN_MULTI_NUM_CLIENT = 7;	-- 禁止值（客户端报的）
DeRobot.tbPermitHwId = { [0] = 1, };
DeRobot.JUDGE_MULTI_INTERVAL = 360 * 18;	-- 多开持续多少帧再禁
DeRobot.tbBattleHwCount = {};  -- 战场多开数

function DeRobot:OnPlayerLogout()
	--print("Logout", me.dwIp, me.dwHardWareId)
	local nHardWareId = me.dwHardWareId;
	if (self.tbPermitHwId[nHardWareId]) then
		return
	end
	local nCurMulti = self.tbHwMulti[nHardWareId];
	if nCurMulti and nCurMulti >= self.BAN_MULTI_NUM then
		local nRet = DeRobot:JudgeIfNotBan(self.BAN_MULTI_NUM);
		if nRet ~= 0 then
			Dbg:WriteLog("DeRobot", me.szName, me.dwHardWareId, "NotBanFor"..nRet);
		else
			me.ForbitSet(self.N_CODE, 0);
		end
	end
end

function DeRobot:ExternJudge(nBanNum)
	local dwIpMul = KLib.BitOperate(me.dwIp, "^", me.dwHardWareId);
	--print("ExternJudge "..dwIpMul)
	local nIphwMulti = self.tbIpHwMulti[dwIpMul];
	if nIphwMulti and nIphwMulti >= nBanNum then
		return 0; -- Ban
	end
	return 1; -- Not Ban
end

function DeRobot:JudgeIfNotBan(nBanNum)
	if me.nLevel > 105 or me.nLevel > KPlayer.GetMaxLevel() - 6 then
		return 2; -- Not Ban
	end
	local nFactionReputeLevel = me.GetReputeLevel(3, me.nFaction)
	if nFactionReputeLevel and nFactionReputeLevel > 1 then
		return 3;
	end
	if me.nMonCharge > 50 then
		return 4;
	end
--	if me.GetRelationCount(2) > 2 then
--		return 5;
--	end
	-- 门派竞技支线
	return self:ExternJudge(nBanNum);
end

-- 多开数量每增加3会调此函数并传入当前多开数及ip重复数
function DeRobot:OnHwMulti(dwHardWareId, dwIpHw, nHardWareMulti, nIpMulti)
	--print(dwHardWareId, dwIpHw, nHardWareMulti, nIpMulti)
	local nOrgHwMulti = self.tbHwMulti[dwHardWareId];
	self:SetHwMulti(dwHardWareId, dwIpHw, nHardWareMulti, nIpMulti)
	if (nHardWareMulti >= self.BAN_MULTI_NUM and nIpMulti >= self.BAN_MULTI_NUM) then
		if (self.tbPermitHwId[dwHardWareId]) then
			return
		end
		local nBanTimer = self.tbHwBanTimer[dwHardWareId];
		if not nBanTimer then -- 没有禁过才启动timer
			print("[DeRobot]", "TimerBan_"..dwHardWareId, nHardWareMulti, nIpMulti);
			nBanTimer = Timer:Register(self.JUDGE_MULTI_INTERVAL, "DeRobot:DoSyncHwMulti", dwHardWareId, dwIpHw);
			self.tbHwBanTimer[dwHardWareId] = nBanTimer;
		end
	else
		local nBanTimer = self.tbHwBanTimer[dwHardWareId];	
		if (nBanTimer) then
			if (nBanTimer >= 0) then  -- 启动了timer，但还没执行
				print("[DeRobot]", "CancelBan_"..dwHardWareId, nHardWareMulti, nIpMulti);
				Timer:Close(nBanTimer);
			else -- 已执行禁制，解除
				print("[DeRobot]", "UnBan_"..dwHardWareId, nHardWareMulti, nIpMulti);
				GlobalExcute{"DeRobot:SetHwMulti", dwHardWareId, dwIpHw, nHardWareMulti, nIpMulti}
			end
			self.tbHwBanTimer[dwHardWareId] = nil;			
		end
	end
	-- 7
	if (nHardWareMulti >= self.BAN_MIN_NUM and nIpMulti >= self.BAN_MIN_NUM) then
		if (self.tbPermitHwId[dwHardWareId]) then
			return
		end
		local nBanTimer = self.tbHwBanMinTimer[dwHardWareId];
		if not nBanTimer then -- 没有禁过才启动timer
			print("[DeRobot]", "TimerMinBan_"..dwHardWareId, nHardWareMulti, nIpMulti);
			nBanTimer = Timer:Register(self.JUDGE_MULTI_INTERVAL, "DeRobot:DoSyncHwMulti", dwHardWareId, dwIpHw, 1);
			self.tbHwBanMinTimer[dwHardWareId] = nBanTimer;
		end
	else
		local nBanTimer = self.tbHwBanMinTimer[dwHardWareId];	
		if (nBanTimer) then
			if (nBanTimer >= 0) then  -- 启动了timer，但还没执行
				print("[DeRobot]", "CancelBanMin_"..dwHardWareId, nHardWareMulti, nIpMulti);
				Timer:Close(nBanTimer);
			else -- 已执行禁制，解除
				print("[DeRobot]", "UnBanMin_"..dwHardWareId, nHardWareMulti, nIpMulti);
				GlobalExcute{"DeRobot:SetHwMulti", dwHardWareId, dwIpHw, nHardWareMulti, nIpMulti}
			end
			self.tbHwBanMinTimer[dwHardWareId] = nil;			
		end
	end
end

function DeRobot:DoSyncHwMulti(dwHardWareId, dwIpHw, bMin)
	local nHardWareMulti = self.tbHwMulti[dwHardWareId];
	local nIpMulti = self.tbIpHwMulti[dwIpHw];
	print("[DeRobot]", "DoBan"..dwHardWareId, nHardWareMulti, nIpMulti);
	GlobalExcute{"DeRobot:SetHwMulti", dwHardWareId, dwIpHw, nHardWareMulti, nIpMulti};
	if bMin then
		self.tbHwBanMinTimer[dwHardWareId] = -1;
	else
		self.tbHwBanTimer[dwHardWareId] = -1;
	end	
	return 0;
end

function DeRobot:SetHwMulti(dwHardWareId, dwIpHw, nHardWareMulti, nIpMulti)
	--print(dwHardWareId, dwIpHw, nHardWareMulti, nIpMulti)
	if (self.tbPermitHwId[dwHardWareId]) then
		return
	end
	local nOrgHwMulti = self.tbHwMulti[dwHardWareId];
	--if (not nOrgHwMulti) or nOrgHwMulti < nHardWareMulti then
		self.tbHwMulti[dwHardWareId] = nHardWareMulti;
		self.tbIpHwMulti[dwIpHw] = nIpMulti;
	--end	
end

function DeRobot:OnClientDetectMulti(nMulti)
	if nMulti >= self.BAN_MULTI_NUM_CLIENT then
		--me.ForbitSet(self.N_CODE, 0);
	end
end

DeRobot.tbRepairName = DeRobot.tbRepairName or {};
DeRobot.DEBAN_TIME = 1229991500;
function DeRobot:OnLoginDo(bExchange)
	local nForbitCode = me.GetTask(0, 2044);
	local nForbitTime = me.GetTask(0, 2045);
	if (nForbitCode > 0 and self.tbRepairName[me.szName] == 1) or (nForbitCode == 3 and nForbitTime > 0 and nForbitTime < self.DEBAN_TIME) then
		-- 解除封号，放出天牢
		--Player:SetFree(me);
		self.tbRepairName[me.szName] = 0;
	elseif nForbitCode == self.N_CODE then	
		Dialog:Say("由于多开登陆超过许可，您的角色已被自动封停！");
		Player:RegisterTimer(18*3, DeRobot.DoKickOut, DeRobot);
	end
end

function DeRobot:DoKickOut()
	me.KickOut();
	return 0;
end

function DeRobot:OnMissionJoin(pPlayer)
	local nCount = self.tbBattleHwCount[pPlayer.dwHardWareId];
	if not nCount then
		nCount = 1;
	else
		nCount = nCount + 1;
	end
	self.tbBattleHwCount[pPlayer.dwHardWareId] = nCount;
	Dbg:WriteLog("DeRobot", "BattleJoin"..nCount, pPlayer.szName, "Battle_"..pPlayer.dwHardWareId);
end

function DeRobot:OnMissionLeave(pPlayer)
	local nCount = self.tbBattleHwCount[pPlayer.dwHardWareId];
	if not nCount then
		nCount = -1;
	else
		nCount = nCount - 1;
	end
	self.tbBattleHwCount[pPlayer.dwHardWareId] = nCount;
	Dbg:WriteLog("DeRobot", "BattleLeave"..nCount, pPlayer.szName, "Battle_"..pPlayer.dwHardWareId);
end

function DeRobot:OnMissionDeath(tbBTInfo)
	local nHardWareId = me.dwHardWareId;
	if (self.tbPermitHwId[nHardWareId]) then
		return
	end
	local nCurMulti = self.tbHwMulti[nHardWareId];
	if nCurMulti and nCurMulti >= self.BAN_MIN_NUM then
		if tbBTInfo.nKillPlayerNum > 6 or (tbBTInfo.nBeenKilledNum + 1) % 5  ~= 0 then
			return;
		end			
		local nScore = 0;
		nScore = nScore + (tbBTInfo.nBeenKilledNum + 1) / 5 - math.floor(tbBTInfo.nKillNpcNum / 5 + tbBTInfo.nKillPlayerNum);
		nScore = nScore * 5;
		if nScore ~= 0 then
			local nRet = DeRobot:JudgeIfNotBan(self.BAN_MIN_NUM);
			if nRet ~= 0 and nRet ~= 5 then
				Dbg:WriteLog("DeRobot", me.szName, "BattleNotBanFor", nRet);	
			else
				Player.tbAntiBot:OnSaveRoleScore(me.szAccount, me.szName, "shanghui", nScore);
				Dbg:WriteLog("DeRobot", me.szName, "AddBattleScore", nScore);
			end
		end
	end
end

function DeRobot:OnFinishLinkTaskTurn()
	local nHardWareId = me.dwHardWareId;
	if (self.tbPermitHwId[nHardWareId]) then
		return
	end
	local nCurMulti = self.tbHwMulti[nHardWareId];
	if nCurMulti and nCurMulti >= self.BAN_MIN_NUM then
		local nRet = DeRobot:JudgeIfNotBan(self.BAN_MIN_NUM);
		if nRet ~= 0 then
			--Dbg:WriteLog("DeRobot", me.szName, me.dwHardWareId, "NotBanFor"..nRet);
		else
			Player.tbAntiBot:OnSaveRoleScore(me.szAccount, me.szName, "tasklink", 10)
			--Player.tbAntiBot.tbStrategy:ImmediateAgent(me.nId);
			Dbg:WriteLog("DeRobot", me.szName, "AddLinkTaskScore");
		end
	end
end

function DeRobot:OnMerchantTask10()
	local nHardWareId = me.dwHardWareId;
	if (self.tbPermitHwId[nHardWareId]) then
		return
	end
	local nCurMulti = self.tbHwMulti[nHardWareId];
	if nCurMulti and nCurMulti >= self.BAN_MIN_NUM then
		local nRet = DeRobot:JudgeIfNotBan(self.BAN_MIN_NUM);
		if nRet ~= 0 then
			--Dbg:WriteLog("DeRobot", me.szName, me.dwHardWareId, "NotBanFor"..nRet);
		else
			Player.tbAntiBot:OnSaveRoleScore(me.szAccount, me.szName, "shanghui", 10)
			Dbg:WriteLog("DeRobot", me.szName, "AddMerchantScore");
		end
	end
end

DeRobot.anRobotTask1 = {7, 184, 186, 187, 185, 8};
DeRobot.anRobotTask2 = {13, 175, 177, 14};
function DeRobot:OnFinishTask(nTaskId, nReferId)
	local nTask = me.GetTask(2066, 1);
	if nTask == 0 and self.anRobotTask1[1] == nReferId then
		me.SetTask(2066, 1, 2);
	elseif nTask > 0 then
		local nTask1Num = #self.anRobotTask1
		local nTask2Num = #self.anRobotTask2		
		local nRobotRefId = 0
		if nTask <= nTask1Num then -- 第一组
			nRobotRefId = self.anRobotTask1[nTask];			
		elseif nTask <= nTask1Num + nTask2Num then -- 第二组
			nRobotRefId = self.anRobotTask2[nTask - nTask1Num];
		else
			me.SetTask(2066, 1, -1);				
		end
		if nRobotRefId == nReferId then
			me.SetTask(2066, 1, nTask + 1)
		elseif nTask ~= nTask1Num + 1 then -- 不是第二组的第一个
			me.SetTask(2066, 1, -1);		
		end
		if nTask == nTask1Num + nTask2Num then -- 最后一个
			Player.tbAntiBot:OnSaveRoleScore(me.szAccount, me.szName, "roleaction", 60)
			Dbg:WriteLog("DeRobot", me.szName, "RobotLinkTask");
			me.SetTask(2066, 1, -1);
		end
	end
end

if (MODULE_GAMESERVER) then
-- 注册通用下线事件
PlayerEvent:RegisterGlobal("OnLogout", "DeRobot:OnPlayerLogout");
PlayerEvent:RegisterGlobal("OnLogin", "DeRobot:OnLoginDo");
end
