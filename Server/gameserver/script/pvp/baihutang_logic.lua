-------------------------------------------------------------------
--File		: baihutang_logic.lua
--Author	: ZouYing
--Date		: 2008-8-22 9:14
--Describe	: 白虎堂活动logic脚本
-------------------------------------------------------------------

-- BaiHuTang基础类，提供默认操作以及基础处理函数
local tbBase =  Mission:New();
BaiHuTang.tbMissionBase = tbBase;

function tbBase:SetCofig(nMapId)
	local tbTemp = {};
	for nIndex, tbPos in ipairs(BaiHuTang.tbDaDianPos) do
		table.insert(tbTemp, {nMapId, tbPos.nX / 32, tbPos.nY / 32});
	end
	--设置Mission的tbMisCfg
	self.tbMisCfg = 
	{
		nOnDeath = 1;
		nDeathPunish = 1;
		nPkState =  Player.emKPK_STATE_TONG;
		tbLeavePos    = {[0] = tbTemp };	
		tbDeathRevPos = {[0] = tbTemp };	
		nOnMovement		= 1,								-- 参加某项活动
		nDisableFriendPlane = 1,							-- 禁止好友界面
		nDisableStallPlane	= 1,							-- 禁止交易界面
	}
end

function tbBase:OnStartGame()
	self.tbGroups	= {};
	self.tbPlayers	= {};
	self.tbTimers	= {};
	self.nStateJour = 0;
	self.tbNowStateTimer = nil;
end

function tbBase:OnLeave()
	BaiHuTang:_SetLeaveFightState(me);
	Dialog:ShowBattleMsg(me, 0, 0);
end

function tbBase:OnDeath(pKillerNpc)
	
	local pKillerPlayer = pKillerNpc.GetPlayer();
	if (pKillerPlayer) then
		local szKillerRouter	= Player:GetFactionRouteName(pKillerPlayer.nFaction, pKillerPlayer.nRouteId);
		local szDeathRouter		= Player:GetFactionRouteName(me.nFaction, me.nRouteId);
	
		BaiHuTang.tbKillerChu[szKillerRouter] = (BaiHuTang.tbKillerChu[szKillerRouter] or 0) + 1;
		BaiHuTang.tbDeathChu[szDeathRouter] = (BaiHuTang.tbDeathChu[szDeathRouter] or 0 ) + 1;
		pKillerPlayer.Msg("<color=green>Bạn đẩy lui kẻ xâm nhập: "..me.szName.."。<color>");
		local tbPlayer, nCount = KPlayer.GetMapPlayer(me.nMapId);
		
		if (nCount > 2 ) then
			local szMsg = pKillerPlayer.szName.." Đánh lui kẻ xâm nhập: " .. me.szName .. "。";
			for _, pPlayer in pairs(tbPlayer) do
				if (pPlayer.szName ~= me.szName and pPlayer.szName ~= pKillerPlayer.szName) then
					pPlayer.Msg(szMsg, "Hệ thống");		
				end
			end
		end
	end
	self:KickPlayer(me);
end

-------------------白虎堂独立逻辑---------------------------------------------------

BaiHuTang.tbMissionList = {};
function BaiHuTang:CreateMissions()
	for i, nMapId in pairs(self.tbMapList) do
		self.tbMissionList[nMapId] = self.tbMissionList[nMapId] or Lib:NewClass(tbBase);
		self.tbMissionList[nMapId]:SetCofig(nMapId);
	end
end

function BaiHuTang:Open()
	for i, tbMission in pairs(self.tbMissionList) do
		tbMission:OnStartGame();
	end
end

function BaiHuTang:MissionStop()
	for nMapId, tbMission in pairs(self.tbMissionList) do
		if (tbMission:IsOpen() == 1) then
			tbMission:Close();
		end		
	end
end


--加入Mission
function BaiHuTang:JoinGame(nMapId, pPlayer)
	self:_SetPKState(pPlayer);		--进入战斗状态
	local bEnter = 0;
	for n, tbMission in pairs(self.tbMissionList) do
		if (n == nMapId and tbMission:IsOpen() == 1) then
			tbMission:JoinPlayer(pPlayer, 1);
			bEnter = 1;
			break;
		end
	end
	if (bEnter == 0) then
		return;
	end
	self:ShowTimeInfo(pPlayer);
	--popo提示
	pPlayer.CallClientScript({"PopoTip:ShowPopo", 18});
	return 1;
end

function BaiHuTang:KickOutMission(pPlayer, nMapId)
	for i, tbMission in pairs(self.tbMissionList) do
		
		if (nMapId == i) then
			tbMission:KickPlayer(pPlayer);
		end
	end
end

function BaiHuTang:OnKickPlayer(pPlayer, nMapId)
	if self.tbMissionList and self.tbMissionList[nMapId] then
		if self.tbMissionList[nMapId]:IsOpen() == 1 then
			if self.tbMissionList[nMapId]:GetPlayerGroupId(pPlayer) >= 0 then
				self.tbMissionList[nMapId]:KickPlayer(pPlayer);
			end
		end
	end
end
