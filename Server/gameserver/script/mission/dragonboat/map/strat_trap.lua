-- �ļ�������strat_trap.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-05-11 11:24:04
-- ��  ��  �����

local tbMap 	= Map:GetClass(1535);

local tbTrap 	= tbMap:GetTrapClass("trap_start");

function tbTrap:OnPlayer()
	local tbMis = Esport.DragonBoat:GetPlayerMission(me);
	if tbMis and tbMis:IsOpen() == 1 then
		if tbMis:GetGameState() ~= 2 then
			local nR = MathRandom(#Esport.DragonBoat.MAP_POS_START);
			me.NewWorld(me.nMapId, unpack(Esport.DragonBoat.MAP_POS_START[nR]));
			return 0;
		end
	end
end
