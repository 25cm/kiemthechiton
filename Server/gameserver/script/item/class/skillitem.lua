
-- 技能道具，通用功能脚本

------------------------------------------------------------------------------------------
-- initialize

local tbSkillItem = Item:GetClass("skillitem");

local CASTTYPE_LAUNCHER_POS	= 1;			-- 使用该物品时直接用当前玩家的所在位置为参数，发技能
local CASTTYPE_LAUNCHER_ID	= 2;			-- 使用该物品时直接以当前玩家的ID为参数，发技能
local CASTTYPE_TARGET_POS	= 3;			-- 使用该物品时必须要求玩家指定某个位置
local CASTTYPE_TARGET_ID	= 4;			-- 使用该物品时必须要求玩家指定某个目标

------------------------------------------------------------------------------------------
-- public

function tbSkillItem:OnUse()				-- 放技能

	local pNpc = me.GetNpc();
	local nSkillId    = it.GetExtParam(1);	-- 技能ID
	local nSkillLevel = it.GetExtParam(2);	-- 技能级别
	local nCastType   = it.GetExtParam(3);	-- 放技能类型
	local bBroadcast  = it.GetExtParam(4);	-- 是否向周围广播
	local nParam1     = 0;
	local nParam2     = 0;

	if		(CASTTYPE_LAUNCHER_POS	== nCastType) then
		nParam1, nParam2 = pNpc.GetMpsPos();
	elseif	(CASTTYPE_LAUNCHER_ID	== nCastType) then
		nParam1 = -1;
		nParam2 = pNpc.nIndex;
	elseif	(CASTTYPE_TARGET_POS	== nCastType) then
		-- TODO: 暂不提供
		return	0;
	elseif	(CASTTYPE_TARGET_ID		== nCastType) then
		-- TODO: 暂不提供
		return	0;
	end

	pNpc.CastSkill(nSkillId, nSkillLevel, nParam1, nParam2, bBroadcast);
	return	1;

end
