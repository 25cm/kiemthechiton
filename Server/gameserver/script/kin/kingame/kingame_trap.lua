-------------- ضͼص ---------------
Require("\\script\\kin\\kingame\\datatable.lua")

local tbMap = {};

function KinGame:InitMapTrap(nMapId)
	self:InitSelectRoomTrap(nMapId);
	local tbMapTrap = Map:GetClass(nMapId);
	for nRoomId, tbMapInfo in pairs(KinGame.WalkTrap) do
		for szClassName, tbPos in pairs(tbMapInfo) do 
			local tbTrap	= tbMapTrap:GetTrapClass(szClassName);
			tbTrap.nMapId = nMapId;
			tbTrap.nRoomId = nRoomId;
			tbTrap.nPosX = tbPos[1];
			tbTrap.nPosY = tbPos[2];
			for szFnc in pairs(tbMap) do			-- ƺ
				tbTrap[szFnc] = tbMap[szFnc];
			end
		end
	end
end

-- Trap¼
function tbMap:OnPlayer()
	local pGame =  KinGame:GetGameObjByMapId(me.nMapId) --ö
	if pGame == nil then
		return 0;
	end
	if self.nRoomId == 0 then --
		me.RemoveSkillState(764); --ҩЧ
		pGame:KickPlayer(me);
		return 0;
	end
	local pRoom = pGame.tbRoom[self.nRoomId];
	if self.nRoomId == 2 and pRoom:IsStart() == 1 then --
		if me.nFightState == 0 then
			me.SetFightState(1)
			me.NewWorld(me.nMapId, KinGame.FIGHTSTATE_POS[1], KinGame.FIGHTSTATE_POS[2]);
			return 0;
		else
			me.SetFightState(0)
			me.NewWorld(me.nMapId, self.nPosX, self.nPosY);
		end
	end
	
	if pRoom:IsStart() == 1 then
		--ѿ
		return 0;
	end
	me.NewWorld(me.nMapId, self.nPosX, self.nPosY);
end;


--⴦ѡtrap
local tbSelectRoom = {};
local tbSelectRoomInfo = 
{
	--className   
	to_fantanjian  = {nRoomId= 4, tbIn = {math.floor(54016/32), math.floor(98208/32)}, tbOut = {1697, 3084}},
	to_xiaoboss    = {nRoomId= 5, tbIn = {math.floor(55840/32), math.floor(98432/32)}, tbOut = {1736, 3090}},
	to_yunxuanjian = {nRoomId= 6, tbIn = {math.floor(55968/32), math.floor(100544/32)}, tbOut = {1741, 3129}},
}

function KinGame:InitSelectRoomTrap(nMapId)
	local tbMapTrap = Map:GetClass(nMapId);
	for szClassName, tbMapInfo in pairs(tbSelectRoomInfo) do
		local tbTrap	= tbMapTrap:GetTrapClass(szClassName);
		tbTrap.nMapId = nMapId;
		tbTrap.nRoomId = tbMapInfo.nRoomId;
		tbTrap.tbInPos = {};
		tbTrap.tbInPos.nPosX = tbMapInfo.tbIn[1];
		tbTrap.tbInPos.nPosY = tbMapInfo.tbIn[2];
		tbTrap.tbOutPos = {};
		tbTrap.tbOutPos.nPosX = tbMapInfo.tbOut[1];
		tbTrap.tbOutPos.nPosY = tbMapInfo.tbOut[2];			
		for szFnc in pairs(tbSelectRoom) do			-- ƺ
			tbTrap[szFnc] = tbSelectRoom[szFnc];
		end
	end
end

-- Trap¼
function tbSelectRoom:OnPlayer()
	local pGame =  KinGame:GetGameObjByMapId(me.nMapId) --ö
	if pGame == nil then
		return 0;
	end	
	local pRoom = pGame.tbRoom[26];	--Ϣ
	local pCurRoom = pGame.tbRoom[self.nRoomId];
	if pRoom:IsStart() == 1 then
		--ѿֱ
		return 0;
	end
	if pCurRoom:IsStart() ~= 1 then
		me.NewWorld(me.nMapId, self.tbOutPos.nPosX, self.tbOutPos.nPosY);
		return 0;
	end
	local nCountMax = pGame:GetPlayerCount(0);
	local nCanPass = math.ceil(nCountMax / 3);
	local nCount = 0;
	if self.nRoomId == 4 then
		if pGame.tbPlayerId.tbLeft.tbPlayerId[me.nId] == 1 then
			self:OnLeaveRoom(pGame);
			return 0;
		end
		nCount = pGame:GetLeftPlayerCount();
	elseif self.nRoomId == 5 then
		if pGame.tbPlayerId.tbMid.tbPlayerId[me.nId] == 1 then
			self:OnLeaveRoom(pGame);
			return 0;
		end
		nCount = pGame:GetMidPlayerCount();
	elseif self.nRoomId == 6 then
		if pGame.tbPlayerId.tbRight.tbPlayerId[me.nId] == 1 then
			self:OnLeaveRoom(pGame);
			return 0;
		end
		nCount = pGame:GetRightPlayerCount();
	else
		return 0;
	end
	
	if nCanPass - nCount <= 0 then
		me.NewWorld(me.nMapId, self.tbOutPos.nPosX, self.tbOutPos.nPosY);
		me.Msg("·ͨ")
		return 0;
	end	
	if self.nRoomId == 4 then
		pGame:AddLeftPlayer(me.nId);
	elseif self.nRoomId == 5 then
		pGame:AddMidPlayer(me.nId);
	elseif self.nRoomId == 6 then
		pGame:AddRightPlayer(me.nId);
	end
	me.NewWorld(me.nMapId, self.tbInPos.nPosX, self.tbInPos.nPosY);	
	return 0;
end

function tbSelectRoom:OnLeaveRoom(pGame)
	me.NewWorld(me.nMapId, self.tbInPos.nPosX, self.tbInPos.nPosY);
	local nCoin = me.GetTask(KinGame.TASK_GROUP_ID, KinGame.TASK_BAG_ID)
	if nCoin < KinGame.PAY_GUQIANBI then
		me.Msg("Không đủ Tiền xu cổ");
		return 0;
	end	
	local tbOpt = {
		{"Đưa 5 đồng tiền xu cổ để vào", self.LeaveRoomSure, self, pGame},
		{"Bỏ qua"},
	}
	Dialog:Say("Bia đá: Ngươi phải trả 5 đồng tiền xu cổ để trở vào.");
	--ý룬ȷص
end

function tbSelectRoom:LeaveRoomSure(pGame)
	if not pGame then
		return 0;
	end
	local nCoin = me.GetTask(KinGame.TASK_GROUP_ID, KinGame.TASK_BAG_ID)
	if nCoin < KinGame.PAY_GUQIANBI then
		me.Msg("Không đủ Tiền xu cổ");
		return 0;
	end
	me.SetTask(KinGame.TASK_GROUP_ID, KinGame.TASK_BAG_ID, nCoin - KinGame.PAY_GUQIANBI);
	pGame:DelLinePlayer(me.nId)
	me.NewWorld(me.nMapId, self.tbOutPos.nPosX, self.tbOutPos.nPosY);
end

KinGame:InitMapTrap(273);

