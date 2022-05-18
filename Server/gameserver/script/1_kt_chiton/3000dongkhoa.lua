-- 文件名　：zongziexp.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-05-18 11:56:05
-- 描  述  ：

local tbItem = Item:GetClass("3000dongkhoa")

function tbItem:OnUse()
	me.AddBindCoin(2000);
	me.Msg("Nhận được <color=yellow>2000 Đồng Khóa<color>");
	return 1;
end
