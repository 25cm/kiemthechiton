
-- ����Ƭ
-- ���ã��Ҽ����ʹ�ã�ʹ�ú���һ��ʱ��������ֵ��������
-- ��ϸ˵��������Ƭ����10�����ȼ�Խ����������������ֵ����Խ��

local tbItem 			= Item:GetClass("hujiapian");

function tbItem:OnUse()
	me.AddSkillState(385, it.nLevel, 1, 3600 * Env.GAME_FPS);
	return 1;
end

function tbItem:GetTip()
	return FightSkill:GetSkillItemTip(385, it.nLevel);
end