-- 文件名　：zongziexp.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-05-18 11:56:05
-- 描  述  ：

local tbItem = Item:GetClass("tui_chienthang")

function tbItem:OnUse()
		if me.CountFreeBagCell() < 10 then
		Dialog:Say("Trống 10 ô mới nhận được Phần Thưởng");
		return 0;
	end
	if me.CountFreeBagCell() >= 10 then
		local tbItemInfo = {bForceBind = 1};
	me.AddStackItem(18,1,3046,1,nil,4);   --ruong mg
	me.AddStackItem(18,1,3019,1,nil,6);        --ruongvp
	me.AddStackItem(18,1,3039,1,nil,1);        --ruongvp
	me.AddStackItem(18,1,1333,10,nil,1);   --chan nguyen
	me.AddStackItem(18,1,1334,10,nil,5);        --thanh linh
	me.AddStackItem(18,1,553,1,tbItemInfo,15);     --đong hanh 4skill
	me.AddStackItem(18,1,325,1,nil,6);
		me.AddStackItem(18,1,2094,1,tbItemInfo,2);
	me.Msg("<color=yellow>Chúc mừng bạn nhận Thưởng thành công<color>");
	return 1;
	end
end;