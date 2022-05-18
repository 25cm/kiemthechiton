

-- 首饰制作技能新加道具：五行石
-- 作用：右键点击使用，使用后在一定时间内全抗提升
-- 详细说明：五行石共分10级，等级越高所能提升的抗性越高


local tbItem 		= Item:GetClass("wuxingshi");

function tbItem:OnUse()
	me.AddSkillState(386, it.nLevel, 1, 3600 * Env.GAME_FPS);
	return 1;
end

function tbItem:GetTip()
	return FightSkill:GetSkillItemTip(386, it.nLevel);
end

