-- �ļ�������mission.lua
-- �����ߡ���zhaoyu
-- ����ʱ�䣺2009/11/9 10:16:46
-- ��  ��  ��

local tbItem = Item:GetClass("boom");
tbItem.nSkillId = 1481;		--��������

function tbItem:OnUse()
	me.CastSkill(self.nSkillId, 1, -1, me.GetNpc().nIndex);
	return 0;
end
