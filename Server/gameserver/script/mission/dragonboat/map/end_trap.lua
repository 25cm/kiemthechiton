-- �ļ�������end_trap.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-05-11 11:24:10
-- ��  ��  ���յ�

local tbMap 	= Map:GetClass(1535);

local tbTrap 	= tbMap:GetTrapClass("trap_end");

function tbTrap:OnPlayer()
	local tbMis = Esport.DragonBoat:GetPlayerMission(me);
	if tbMis and tbMis:IsOpen() == 1 then
		if tbMis:GetGameState() == 2 and tbMis:GetRank(me) < Esport.DragonBoat.DEF_FINISH_RANK then
			tbMis:SetRank(Esport.DragonBoat.DEF_FINISH_RANK);
			tbMis:OnSingleEndGame(me);
			return 0;
		end
	end	
end
