-- 文件名　：zongziexp.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-05-18 11:56:05
-- 描  述  ：

local tbItem = Item:GetClass("tui_top1tk")

function tbItem:OnUse()
		if me.CountFreeBagCell() < 15 then
		Dialog:Say("Trống 15 ô mới nhận được Phần Thưởng");
		return 0;
	end
	if me.CountFreeBagCell() >= 15 then
		local tbItemInfo = {bForceBind = 1};
	me.AddStackItem(18,1,3046,1,nil,30);   --ruong mg
	me.AddStackItem(18,1,3019,1,nil,40);        --ruongvp
	me.AddStackItem(18,1,3039,1,nil,8);        --ruongvp	
	me.AddStackItem(18,1,1333,10,nil,10);   --chan nguyen
	me.AddStackItem(18,1,1334,10,nil,20);        --thanh linh
	me.AddStackItem(18,1,377,1,nil,1);           --htb
	me.AddStackItem(18,1,553,1,tbItemInfo,100);     --đong hanh 4skill
	--me.AddStackItem(18,1,1331,3,nil,1);  --tinh thach doan hai
	me.AddStackItem(18,1,325,1,nil,50);
	me.AddStackItem(18,1,2094,1,tbItemInfo,15);
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Top 1 Tống Kim<color> thành công");
	KDialog.MsgToGlobal("Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=yellow>Top 1 Tống Kim<color> thành công");
		me.Msg("<color=yellow>Chúc mừng bạn nhận Thưởng thành công<color>");
	return 1;
	end
end;