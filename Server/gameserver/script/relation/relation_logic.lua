-- 文件名　：relation_logic.lua
-- 创建者　：furuilei
-- 创建时间：2009-07-30 16:15:32
-- 功能描述：gameserver和gamecenter共用的人际关系逻辑

if (MODULE_GAMECLIENT) then
	return;
end

-- 检查指定的玩家关系类型是否在合适的范围内
function Relation:CheckRelationType(nType)
	if (nType < Player.emKPLAYERRELATION_TYPE_TMPFRIEND or
		nType > Player.emKPLAYERRELATION_TYPE_BUDDY) then
			return 0;
	end
	return 1;
end

