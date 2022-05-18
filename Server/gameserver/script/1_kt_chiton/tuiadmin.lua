-- 文件名　：zongziexp.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-05-18 11:56:05
-- 描  述  ：

local tbItem = Item:GetClass("tuiadmin")

function tbItem:OnUse()
	me.AddItem(18,1,22222,1);
	me.AddItem(18,1,400,1);
	return 1;
end
