-- 文件名　：zongziexp.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-05-18 11:56:05
-- 描  述  ：

local tbItem = Item:GetClass("3tr")

function tbItem:OnUse()
	me.Addexp(2000000);
	me.Msg("Nhận được <color=yellow>2TR Kinh Nghiệm<color>");
	return 1;
end
