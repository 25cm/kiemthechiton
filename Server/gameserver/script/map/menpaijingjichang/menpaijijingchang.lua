-------------- �����ض���ͼ�ص� ---------------
Require("\\script\\pvp\\factionbattle_def.lua")

local tbMap = {};

-- X��c ??nh s? ki?n nh?p tr��nh ph��t
function tbMap:OnEnter(szParam)
	Faction:SetForbidSwitchFaction(me, 1); -- ��ֹ������
	FactionBattle:OnEnterMap(self.nFaction);
end

-- ��������뿪�¼�
function tbMap:OnLeave(szParam)
	Faction:SetForbidSwitchFaction(me, 0);
	FactionBattle:OnLeaveMap(self.nFaction);
end

for nFaction, nMapId in pairs(FactionBattle.FACTION_TO_MAP) do
	local tbBattleMap = Map:GetClass(nMapId);
	for szFnc in pairs(tbMap) do			-- ���ƺ���
		tbBattleMap[szFnc] = tbMap[szFnc];
	end
	tbBattleMap.nFaction = nFaction;
end


local tbMapInfo = 
{
	--className = {����(1.�д賡 2.�ھ�̨)������x�㣬 ����y�㣬 �Ƿ��ɱ�� �Ƿ��д裬 �Ƿ�ս��״̬}
	qiecuochangchukou_1 = {nType=1, nPosX=49472,nPosY=108416, nPKEnmity=1,nPKExercise=1,nFightState=0},
	qiecuochangchukou_2 = {nType=1, nPosX=49952,nPosY=108832, nPKEnmity=1,nPKExercise=1,nFightState=0},
	qiecuochangchukou_3 = {nType=1, nPosX=50400,nPosY=109280, nPKEnmity=1,nPKExercise=1,nFightState=0},
	qiecuochangrukou_1 	= {nType=1, nPosX=48800,nPosY=109056, nPKEnmity=1,nPKExercise=0,nFightState=1},
	qiecuochangrukou_2 	= {nType=1, nPosX=49216,nPosY=109568, nPKEnmity=1,nPKExercise=0,nFightState=1},
	qiecuochangrukou_3 	= {nType=1, nPosX=49696,nPosY=110080, nPKEnmity=1,nPKExercise=0,nFightState=1},
	toguanjuntai_in			= {nType=2, nInPosX=50208,nInPosY=108224, nOutPosX=50048,nOutPosY=108512},
	toguanjuntai_out		=	{nType=2, nInPosX=50048,nInPosY=108512, nOutPosX=50048,nOutPosY=108512},
}

local tbMapTrapClass = {};
local tbMapTrap = {};
-- �������Trap�¼�
function tbMapTrapClass:OnPlayer()
	if self.nType == 1 then
		me.NewWorld(self.nMapId,math.floor(self.nPosX/32),math.floor(self.nPosY/32));
		me.ForbidEnmity(self.nPKEnmity);   	 --��ɱ
		me.ForbidExercise(self.nPKExercise); --�д�
		me.SetFightState(self.nFightState);		 --ս��״̬
	elseif self.nType == 2 then
		local tbDate = FactionBattle:GetFactionData(me.nFaction);
		if tbDate then
			if tbDate:GetFinalWinner() == me.nId then
				me.NewWorld(self.nMapId,math.floor(self.nInPosX/32),math.floor(self.nInPosY/32));
				return 0;
			end
		end
		Dbg:WriteLog("FactionBattle", "return from trap", me.szName, me.szAccount);
		me.NewWorld(self.nMapId,math.floor(self.nOutPosX/32),math.floor(self.nOutPosY/32));
		me.Msg("Khong the vao !")
	end
end;

for nFaction, nMapId in pairs(FactionBattle.FACTION_TO_MAP) do
	for szClassName, tbManInfo in pairs(tbMapInfo) do
		local tbBattleMap = Map:GetClass(nMapId);
		tbMapTrap	= tbBattleMap:GetTrapClass(szClassName);
		tbMapTrap.nMapId = nMapId;
		tbMapTrap.nType	= tbManInfo.nType;
		if tbMapTrap.nType == 1 then
			tbMapTrap.nPosX = tbManInfo.nPosX;
			tbMapTrap.nPosY = tbManInfo.nPosY;
			tbMapTrap.nPKEnmity = tbManInfo.nPKEnmity;
			tbMapTrap.nPKExercise = tbManInfo.nPKExercise;
			tbMapTrap.nFightState = tbManInfo.nFightState;
		elseif tbMapTrap.nType == 2 then
			tbMapTrap.nInPosX = tbManInfo.nInPosX;
			tbMapTrap.nInPosY = tbManInfo.nInPosY;
			tbMapTrap.nOutPosX = tbManInfo.nOutPosX;
			tbMapTrap.nOutPosY = tbManInfo.nOutPosY;
		end
		for szFnc in pairs(tbMapTrapClass) do			-- ���ƺ���
			tbMapTrap[szFnc] = tbMapTrapClass[szFnc];
		end
	end
end