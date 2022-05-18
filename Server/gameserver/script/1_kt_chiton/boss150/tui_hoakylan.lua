-- 文件名　：zongziexp.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-05-18 11:56:05
-- 描  述  ：

local tbItem = Item:GetClass("tui_hoakylan")

function tbItem:OnUse()
		if me.CountFreeBagCell() < 15 then
		Dialog:Say("Trống 15 ô mới nhận được Phần Thưởng");
		return 0;
	end
	if me.CountFreeBagCell() >= 15 then
	local tbItemInfo = {bForceBind = 1};
	me.AddStackItem(18,1,3046,1,nil,15);   --ruong mg
	me.AddStackItem(18,1,3019,1,nil,30);        --ruongvp
	me.AddStackItem(18,1,3039,1,nil,3); 	
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Boss Hỏa Kỳ Lân<color> cho toàn Server thành công");
	KDialog.MsgToGlobal("Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=yellow>Boss Hỏa Kỳ Lân<color> cho toàn Server thành công");
		me.Msg("<color=yellow>Chúc mừng bạn nhận Thưởng thành công<color>");
	return 1;
	end
end;