

-- �������������¼ӵ��ߣ�����ʯ
-- ���ã��Ҽ����ʹ�ã�ʹ�ú���һ��ʱ����ȫ������
-- ��ϸ˵��������ʯ����10�����ȼ�Խ�����������Ŀ���Խ��


local tbItem 		= Item:GetClass("wuxingshi");

function tbItem:OnUse()
	me.AddSkillState(386, it.nLevel, 1, 3600 * Env.GAME_FPS);
	return 1;
end

function tbItem:GetTip()
	return FightSkill:GetSkillItemTip(386, it.nLevel);
end

