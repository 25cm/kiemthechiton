

-- 首饰制作技能新加道具：磐石符
-- 作用：右键点击使用，使用后在一定时间内减少五行状态效果
-- 详细说明：磐石符共分10级，等级越高所能提升的减少五行状态效果越高


local tbItem 		= Item:GetClass("panshifu");
tbItem.nDuration	= Env.GAME_FPS * 60 * 60;
tbItem.nSkillId		= 887;

function tbItem:OnUse()
	me.AddSkillState(self.nSkillId, it.nLevel, 2, self.nDuration, 1, 0, 1);
	
	return 1;
end

function tbItem:GetTip()
	return FightSkill:GetSkillItemTip(self.nSkillId, it.nLevel);
end
