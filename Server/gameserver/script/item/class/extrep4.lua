
local tbItem = Item:GetClass("extrep4")

tbItem.TaskGroup = 2024;
tbItem.TaskId 	 = 38;

function tbItem:OnUse()
	self:SureUse(it.dwId);
	return 0;
end

function tbItem:SureUse(nItemId, nFlag)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 1
	end
	local nTask = me.GetTask(self.TaskGroup, self.TaskId);
	if me.nExtRepState ~= pItem.nLevel - 1  then
		Dialog:Say(string.format("Đạo cụ này chỉ giúp ngươi tăng ngăn thứ %s trở lên của rương chứa đồ, hãy đảm bảo ngăn thứ 6 đã được mở.", me.nExtRepState + 2));
		return 1;
	end
	if not nFlag then
		local tbOpt =
		{
			{"Đồng ý dùng", self.SureUse, self, nItemId, 1},
			{"Để ta suy nghĩ đã"},
		}
		Dialog:Say(string.format("Dùng đạo cụ này sẽ tăng ngăn thứ %s của rương chứa đồ, <color=red>có thể sử dụng nhiều lần<color>, đồng ý chứ?", me.nExtRepState + 2), tbOpt);
		return 1;
	end
	local nItemLevel = pItem.nLevel;
	if me.DelItem(pItem) == 1 then
		if me.nExtRepState >= Item.EXTREPPOS_NUM then
			Dialog:Say("Đã đạt mức tối đa.");
			return 1;
		end	
		me.SetExtRepState(me.nExtRepState + 1);
		me.SetTask(self.TaskGroup, self.TaskId, nTask + 10^(me.nExtRepState-5));
		me.Msg("Chúc mừng bạn đã mở thêm một ngăn mới.");
	end
	return 1;	
end
function tbItem:GetTip()
	local nUse = 0;
	nUse = me.nExtRepState-5;
	local szTip = string.format("<color=green>Đã sử dụng %s lần<color>", nUse);
	return szTip;
end