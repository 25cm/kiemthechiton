-- 文件名　：zongziexp.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-05-18 11:56:05
-- 描  述  ：

local tbItem = Item:GetClass("tui_top11tk")

function tbItem:OnUse()
		if me.CountFreeBagCell() < 15 then
		Dialog:Say("Trống 15 ô mới nhận được Phần Thưởng");
		return 0;
	end
	if me.CountFreeBagCell() >= 15 then
	local tbItemInfo = {bForceBind = 1};
	me.AddStackItem(18,1,3046,1,nil,20);   --ruong mg
	me.AddStackItem(18,1,3019,1,nil,30);        --ruongvp
	me.AddStackItem(18,1,3039,1,nil,5);        --ruongvp
	me.AddStackItem(18,1,1333,10,nil,4);   --chan nguyen
	me.AddStackItem(18,1,1334,10,nil,15);        --thanh linh          --htb
	me.AddStackItem(18,1,553,1,tbItemInfo,60);     --đong hanh 4skill
	--me.AddStackItem(18,1,1331,2,nil,1);  --tinh thach doan hai
	me.AddStackItem(18,1,325,1,nil,25);
	me.AddStackItem(18,1,2094,1,tbItemInfo,8);
	me.Msg("<color=yellow>Chúc mừng bạn nhận Thưởng thành công<color>");
	return 1;
	end
end;