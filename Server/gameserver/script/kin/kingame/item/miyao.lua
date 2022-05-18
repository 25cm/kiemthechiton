
local tbItem = Item:GetClass("kingame_miyao")

function tbItem:OnUse()
	--持续120秒，有技能配置表决定
	local nMapIndex 		= SubWorldID2Idx(me.nMapId);
	local nMapTemplateId	= SubWorldIdx2MapCopy(nMapIndex);
	if KinGame.MAP_TEMPLATE_ID ~= nMapTemplateId then
		me.Msg("Bản đồ không cho phép sử dụng vật phẩm này.")
		return 0;
	end
	me.AddSkillState(764,1,0,1);
	Dialog:SendBlackBoardMsg(me, "sử dụng Bí Dược, cơ thể cảm thấy nóng dần lên.")
	return 1;
end
