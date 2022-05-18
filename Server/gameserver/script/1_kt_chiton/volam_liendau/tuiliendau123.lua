-- 文件名　：zongziexp.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-05-18 11:56:05
-- 描  述  ：

local tbItem = Item:GetClass("tuiliendau123")

function tbItem:OnUse()
		if me.CountFreeBagCell() < 10 then
		Dialog:Say("Trống 10 ô mới nhận được Phần Thưởng");
		return 0;
	end
	if me.CountFreeBagCell() >= 10 then
		local tbItemInfo = {bForceBind = 1};
	me.AddStackItem(18,1,3046,1,nil,5);   --ruong mg
	me.AddStackItem(18,1,3019,1,nil,5);        --ruongvp
	me.AddStackItem(18,1,3039,1,nil,2);        --ruongvp	         --htb
	me.AddStackItem(18,1,553,1,tbItemInfo,20);     --đong hanh 4skill
	me.AddStackItem(18,1,325,1,nil,20);
	me.AddStackItem(18,1,2094,1,tbItemInfo,3);
		me.Msg("<color=yellow>Chúc mừng bạn nhận thưởng <color=green>Võ Lâm Liên Đấu<color> thành công<color>");
	return 1;
	end
end;