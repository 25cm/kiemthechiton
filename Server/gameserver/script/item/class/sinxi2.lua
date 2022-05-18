-- 文件名　：zongziexp.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-05-18 11:56:05
-- 描  述  ：

local tbItem = Item:GetClass("sinxi2")

function tbItem:OnUse()
	if me.GetTask(2064, 12) >= 2500 then
		Dialog:Say("Nhiều nhất bạn chỉ có sử dụng <color=yellow>2500 Thủy Tinh [Hắc Kiếm]<color>, không thể sử dụng nữa.");
		return 0;
	end
	me.AddExp(50000000);
	me.SetTask(2064, 12, me.GetTask(2064, 12)+1);
	return 1;
end

function tbItem:GetTip()
	local szTip = "";
	local tbParam = self.tbBook;
	local nUse =  me.GetTask(2064, 12);
	szTip = szTip .. string.format("<color=green>Đã Sử Dụng %s/2500 cái<color>", nUse);
	return szTip;
end

