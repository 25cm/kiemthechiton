 ------------------------------------------------------
-- �ļ�������protectnpc.lua
-- �����ߡ���zhaoyu
-- ����ʱ�䣺2009/10/30 9:38:45
-- ��  ��  ��
------------------------------------------------------

local tbNpc = Npc:GetClass("mentor_protect");

function tbNpc:OnDialog()
	local szMsg = "û�±���ң���";
	
	Dialog:Say(szMsg);
end

function tbNpc:OnDeath(pNpc)
	assert(him)
	
	local tbMiss = Esport.Mentor:GetMission(him);
	if not tbMiss then
		return;
	end
	
	tbMiss:SendMessage("��սʧ�ܣ����������رգ�");
	self.tbOverTimer = Timer:Register(5 * Env.GAME_FPS, self.OnGameOver, self, tbMiss); --5���Ӻ�رո���
end

function tbNpc:OnGameOver(tbMiss)
	tbMiss:OnGameOver();
	
	--�����ʱ��ֻ��Ҫִ��һ�Σ�ִ�й���ر�
	Timer:Close(self.tbOverTimer);
	self.tbOverTimer = nil;
end