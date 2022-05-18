local tbLuHuong = Npc:GetClass("luhuong");
tbLuHuong.TaskId_Count = 1;
tbLuHuong.TASK_GROUP_ID1 = 3010;
tbLuHuong.tbItemInfo = {
        bForceBind=1,
};  

function tbLuHuong:OnDialog()
local nCount555 = me.GetTask(self.TASK_GROUP_ID1, self.TaskId_Count);
local nDate = tonumber(GetLocalDate("%Y%m%d"));
-- if ( nDate < 20140419 or nDate > 20140419 ) then -- Check ngày giỗ tổ 19/4 (Tức 10/3 âm lịch)
-- Dialog:Say("Hôm nay chưa phải ngày giỗ tổ")
-- return
-- end
local tbItemId1	= {18,1,20306,1,0,0}; -- Nhang trầm
local nCount1 = me.GetItemCountInBags(18,1,20306,1) -- Nhang trầm
if nCount1 < 1 then
Dialog:Say("Ngươi không mang theo Nhang Trầm. Không thể cắm")
return
end
if me.CountFreeBagCell() < 10 then
		Dialog:Say("Phải Có 10 Ô Trống Trong Túi Hành Trang");
		return 0;
	end
if nCount555 >= 1 then
Dialog:Say("Đừng tham lam quá mỗi người chỉ 1 lần thôi")
return
end
	local tbEvent = 
	{
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SITE,
		Player.ProcessBreakEvent.emEVENT_USEITEM,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_DROPITEM,
		Player.ProcessBreakEvent.emEVENT_SENDMAIL,
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
	}
	 local tbOpt = {
				 GeneralProcess:StartProcess("Đang Cắm Nhang", 60 * Env.GAME_FPS, {self.OnDialog4, self}, nil, tbEvent);
	 };
end
function tbLuHuong:OnDialog4()
local nCount555 = me.GetTask(self.TASK_GROUP_ID1, self.TaskId_Count);
local tbItemId1	= {18,1,20306,1,0,0}; -- Nhang trầm
local nCount1 = me.GetItemCountInBags(18,1,20306,1) -- Nhang trầm
me.AddExp(100000000) -- 100tr EXP
me.AddItem(18,1,1,9).Bind(1) -- 1 Viên HT9
me.AddStackItem(18,1,20322,1,self.tbItemInfo,5) -- 5 Lam Long Đơn
me. AddStackItem(18,1,20305,1,self.tbItemInfo,5) -- 5 Hộp Quà Vua Hùng
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow>Người chơi <color=green>["..me.szName.."]<color> thắp nhang tỏ lòng thành kính với Vua Hùng nhận được 100tr EXP , 5 Lam Long Đơn , 1 Huyền Tinh 9, 5 Hộp Quà Vua Hùng !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow>Người chơi <color=green>["..me.szName.."]<color> thắp nhang tỏ lòng thành kính với Vua Hùng nhận được 100tr EXP , 5 Lam Long Đơn , 1 Huyền Tinh 9, 5 Hộp Quà Vua Hùng !<color>");
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> thắp nhang tỏ lòng thành kính với Vua Hùng nhận được 100tr EXP , 5 Lam Long Đơn , 1 Huyền Tinh 9, 5 Hộp Quà Vua Hùng !<color>");	
Task:DelItem(me, tbItemId1, 1);
me.SetTask(self.TASK_GROUP_ID1, self.TaskId_Count, nCount555 + 1);
end