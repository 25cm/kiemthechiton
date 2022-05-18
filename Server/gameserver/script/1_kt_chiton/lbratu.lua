-- 文件名　：zongziexp.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-05-18 11:56:05
-- 描  述  ：

local tbItem = Item:GetClass("lbratu")

function tbItem:OnUse()
me.NewWorld(4,1624,3253);
	return 1;
end
