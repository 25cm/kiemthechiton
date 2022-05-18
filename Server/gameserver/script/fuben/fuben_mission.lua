-- Œƒº˛√˚°°£∫fuben_mission.lua
-- ¥¥Ω®’ﬂ°°£∫zounan
-- ¥¥Ω® ±º‰£∫2009-12-17 09:43:45
-- √Ë   ˆ  £∫∏±±æMISSION
Require("\\script\\mission\\lockmis_base.lua");



CFuben.FubenMission	= CFuben.FubenMission or Lib:NewClass(Mission.LockMis);
local BaseGame = CFuben.FubenMission;

-- Kh·ªüi t·∫°o 
function BaseGame:InitGameEx(nMapId, nPlayerId, nFubenId)
	self:InitGame(nMapId);
	self.nPlayerId = nPlayerId;
	self.nFubenId = nFubenId;
	self.tbMisCfg = 
	{
		nDeathPunish   = 1,
		nPkState       = Player.emKPK_STATE_PRACTISE,
--		nOnDeath 	   = 1,        -- C√≥ th·ªÉ ch·∫øt
--		nOnKillNpc 	   = 1,        -- NPC ch·∫øt 		
		nFightState	   = 1,
		nForbidStall   = 1,        -- V·∫≠t ph·∫©m c·∫•m
	};		
	self.tbLockMisCfg = CFuben.tbLockMis[nFubenId].tbLockMisCfg;	
	self.tbMisCfg.nOnDeath = self.tbLockMisCfg.nOnDeath or 0;	
end

--ƒê·ªçc c√°c t·∫≠p tin c·∫•u h√¨nh
--[[
function BaseGame:LoadMisFile(szPath)
--	local tbLockMisCfg = self:LoadMisFile(szPath);
--	self.tbLockMisCfg = tbLockMisCfg;	
--	self.tbLockMisCfg = CFuben.tbLockMisFile:LoadMisFile(szPath);
end
--]]

--Callback
function BaseGame:OnLockMisJoin(nGroupId)
end

function BaseGame:OnLockMisLeave(nGroupId, szReason)
	local nMapId = CFuben.FubenData[self.nPlayerId][3];
	local nPosX = CFuben.FubenData[self.nPlayerId][6];
	local nPosY = CFuben.FubenData[self.nPlayerId][7];
	me.NewWorld(nMapId, nPosX, nPosY);
	CFuben:OnLeave(self.nPlayerId);
--	if self.nPlayerCount <= 0 and self.nIsGameOver ~= 1 then
--		self:GameLose();
--	end
end


--G·ªçi l·∫°i c√°i ch·∫øt c·ªßa nh√¢n v·∫≠t
function BaseGame:OnDeath(pKillerNpc) 
	if not self.tbLockMisCfg.tbNpcPoint["playerbirth"] then
		print("NO BIRTH");
		return;
	end
	local nRandom = #self.tbLockMisCfg.tbNpcPoint["playerbirth"];
	local nX = self.tbLockMisCfg.tbNpcPoint["playerbirth"][nRandom][1];
	local nY = self.tbLockMisCfg.tbNpcPoint["playerbirth"][nRandom][2];	
	me.SetTmpDeathPos(self.nMapId, nX, nY);
	me.ReviveImmediately(0);
	me.SetFightState(1);
	--self:KickPlayer(me);
end

function BaseGame:OnGameClose()	
	--ƒê√≥ng m·ªôt ph√≥ b·∫£n 
	local nTempMapId = CFuben.FubenData[self.nPlayerId][1];
	CFuben:Close(nTempMapId, self.nMapId, self.nPlayerId);
end


 --pNpc.AddLifePObserver(90)
 --local tbNpc = Npc:GetClass("animal");
-- local tbNpc = Npc:GetClass("dataosha_baoming");
-- function tbNpc:OnLifePercentReduceHere(nPercent)
-- end