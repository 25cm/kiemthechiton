-- 文件名　：mission.lua
-- 创建者　：zhaoyu
-- 创建时间：2009/11/9 10:16:46
-- 描  述  ：

local tbItem = Item:GetClass("boom");
tbItem.nSkillId = 1481;		--爆破陷阱

function tbItem:OnUse()
	me.CastSkill(self.nSkillId, 1, -1, me.GetNpc().nIndex);
	return 0;
end
