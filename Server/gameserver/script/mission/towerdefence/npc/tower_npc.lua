-- �ļ�������tower_npc.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2010-03-09 09:44:29
-- ��  ��  ��tower 

local tbNpc = Npc:GetClass("td_tower");
tbNpc.tbLifeAbout = {100, 200, 300};		--ÿ�ֵȼ�ֲ�������ֵ

function tbNpc:OnDeath(pNpcKiller)	
	local tbMission = him.GetTempTable("Npc").tbMission;	
	if not tbMission then
		return;
	end	
	if tbMission:IsOpen() ~= 1 then
		return;
	end
	tbMission:DelTower(him.dwId);
	return;
end
