local tbItem = Item:GetClass("eventpresent");


function tbItem:OnUse()
local tbItemId1	= {18,1,2071,1,0,0}; -- Tiên Thảo Lộ Đặc Biệt (6 giờ)
DoScript("\\script\\item\\class\\eventpresent.lua");
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=green>["..me.szName.."]<color> sử dung Túi Quà Mirinda nhận được <color=green>Tiên Thảo Lộ Đặc Biệt (6 giờ)<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=green>["..me.szName.."]<color> sử dung Túi Quà Mirinda nhận được <color=green>Tiên Thảo Lộ Đặc Biệt (6 giờ)<color>");
KDialog.MsgToGlobal("<color=yellow><color=green>["..me.szName.."]<color> sử dung Túi Quà Mirinda nhận được <color=green>Tiên Thảo Lộ Đặc Biệt (6 giờ)<color>");	
Task:DelItem(me, tbItemId1, 1);
end