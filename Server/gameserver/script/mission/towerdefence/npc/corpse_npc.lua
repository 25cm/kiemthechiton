-- �ļ�������corpse_npc.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2010-03-09 09:26:23
-- ��  ��  ���ֽű�

local tbNpc = Npc:GetClass("td_corpse");

function tbNpc:OnDeath(pNpcKiller)		
	local nType = him.GetTempTable("Npc").nType;
	local tbMission = him.GetTempTable("Npc").tbMission;
	if not tbMission then
		return;
	end	
	if tbMission:IsOpen() ~= 1 then
		return;
	end	
	if nType == 1 then
		tbMission:DelBoss(him.dwId, pNpcKiller.dwId);
	else
		tbMission:OnDeathNpc(him.dwId, pNpcKiller.dwId, 0);
	end
end
