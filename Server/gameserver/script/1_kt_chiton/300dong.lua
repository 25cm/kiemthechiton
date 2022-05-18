-- 文件名　：zongziexp.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-05-18 11:56:05
-- 描  述  ：

local tbItem = Item:GetClass("300dong")

function tbItem:OnUse()
	me.AddJbCoin(500);
	me.Msg("Nhận được <color=yellow>500 Đồng Thường<color>");
	return 1;
end
