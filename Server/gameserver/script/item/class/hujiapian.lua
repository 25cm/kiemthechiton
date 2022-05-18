
-- 护甲片
-- 作用：右键点击使用，使用后在一定时间内生命值上限提升
-- 详细说明：护甲片共分10级，等级越高所能提升的生命值上限越高

local tbItem 			= Item:GetClass("hujiapian");

function tbItem:OnUse()
	me.AddSkillState(385, it.nLevel, 1, 3600 * Env.GAME_FPS);
	return 1;
end

function tbItem:GetTip()
	return FightSkill:GetSkillItemTip(385, it.nLevel);
end