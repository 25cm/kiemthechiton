
local tbItem = Item:GetClass("tui_tanthuyhoang1")

function tbItem:OnUse()
		if me.CountFreeBagCell() < 15 then
		Dialog:Say("Trống 15 ô mới nhận được Phần Thưởng");
		return 0;
	end
	if me.CountFreeBagCell() >= 15 then
		local tbItemInfo = {bForceBind = 1};
	me.AddStackItem(18,1,3046,1,nil,10);   --ruong mg
	me.AddStackItem(18,1,3019,1,nil,20);        --ruongvp
	me.AddStackItem(18,1,3039,1,nil,2);
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Boss Tần Thủy Hoàng <color> cho toàn Server thành công");
	KDialog.MsgToGlobal("Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=yellow>Boss Tần Thủy Hoàng<color> cho toàn Server thành công");
	me.Msg("<color=yellow>Chúc mừng bạn nhận Thưởng thành công<color>");
	return 1;
	end
end;