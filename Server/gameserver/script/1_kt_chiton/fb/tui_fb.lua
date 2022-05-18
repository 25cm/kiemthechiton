-- 文件名　：zongziexp.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-05-18 11:56:05
-- 描  述  ：

local tbItem = Item:GetClass("tui_fb")

function tbItem:OnUse()
		if me.CountFreeBagCell() < 10 then
		Dialog:Say("Trống 10 ô mới nhận được Phần Thưởng");
		return 0;
	end
	if me.CountFreeBagCell() >= 10 then
	local tbItemInfo = {bForceBind = 1};
	me.Earn(1000000,0);
	me.AddStackItem(18,1,3046,1,nil,100);   --ruong mg
	me.AddStackItem(18,1,1333,10,nil,30);   --chan nguyen
	me.AddStackItem(18,1,1334,10,nil,60);        --thanh linh        --htb
	me.AddStackItem(18,1,666,5,tbItemInfo,1);     --đong hanh 4skill
	me.AddStackItem(18,1,3039,5,nil,1);
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Giftcode FaceBook<color> thành công");
	KDialog.MsgToGlobal("Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=yellow>Giftcode FaceBook<color> thành công");
		me.Msg("<color=yellow>Chúc mừng bạn nhận Thưởng thành công<color>");
	return 1;
	end
end;