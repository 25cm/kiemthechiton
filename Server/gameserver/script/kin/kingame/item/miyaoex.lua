
local tbItem = Item:GetClass("kingame_miyaoex")

function tbItem:OnUse()
	me.AddSkillState(764,1,0,1);
	Dialog:SendBlackBoardMsg(me, "sử dụng Bí Dược, cơ thể cảm thấy nóng dần lên.")
	return 1;
end
