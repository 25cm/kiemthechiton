local tbItem = Item:GetClass("satthu95_sirongusac");
tbItem.tbItemInfo = {
bForceBind=1,
};
function tbItem:OnUse()
DoScript("\\script\\event\\cacevent\\tetthieunhi\\sirongusac.lua") -- Reload Siro Ngũ Sắc
local nCount = me.GetItemCountInBags(18,1,2080,1) -- Siro Ngũ Sắc
if nCount < 1 then
Dialog:SendBlackBoardMsg(me, string.format("Trong người không có <color=yellow>Siro Ngũ Sắc<color> !"));
return
end
 self:OnUse1();
end
function tbItem:OnUse1()
if me.CountFreeBagCell() < 10 then
		Dialog:Say("Phải Có 10 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local nCount = me.GetItemCountInBags(18,1,2080,1) -- Siro Ngũ Sắc
local tbItemId1	= {18,1,2080,0,0,0}; -- Siro Ngũ Sắc
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	nRand = MathRandom(1, 100);
	local tbRate = {50, 30, 15, 5}; -- Rate Item
	local tbAward = {1 ,2, 3, 4}; -- Rate 4 con số
	for i = 1, 4 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
if (tbAward[nIndex]==1) then -- Xác xuất ra số 1 là 50/100 (50%)
me.AddExp(10000000) -- 10tr Exp
me.AddStackItem(18,1,1,7,self.tbItemInfo,2) -- (18,1,1,7) là Huyền Tinh (Cấp 7) , 2 là số lượng Huyền Tinh (Cấp 7) người chơi nhận được
Dialog:SendBlackBoardMsg(me, string.format("Nhận được 10tr EXP và 2 Huyền Tinh (Cấp 7)!"));
Task:DelItem(me, tbItemId1, 1); -- Xóa 1 Item tbItemId1 được khai báo ở trên là Siro Ngũ Sắc
me.CastSkill(307, 1, -1, me.GetNpc().nIndex);
end
if (tbAward[nIndex]==2) then -- Xác xuất ra số 2 là 30/10000 (30%)
me.AddExp(20000000) -- 20tr Exp
me.AddStackItem(18,1,1,8,self.tbItemInfo,1) -- (18,1,1,8) là Huyền Tinh (Cấp 8) , 1 là số lượng Huyền Tinh (Cấp 8) người chơi nhận được
Dialog:SendBlackBoardMsg(me, string.format("Nhận được 20tr EXP và 1 Huyền Tinh (Cấp 8)!"));
Task:DelItem(me, tbItemId1, 1); -- Xóa 1 Item tbItemId1 được khai báo ở trên là Siro Ngũ Sắc
me.CastSkill(307, 1, -1, me.GetNpc().nIndex);
end
if (tbAward[nIndex]==3) then -- Xác xuất ra số 3 là 15/100 (15%)
me.AddExp(400000000) -- 40tr Exp
me.AddStackItem(18,1,1,8,self.tbItemInfo,3) -- (18,1,1,8) là Huyền Tinh (Cấp 8) , 2 là số lượng Huyền Tinh (Cấp 8) người chơi nhận được
Dialog:SendBlackBoardMsg(me, string.format("Nhận được 40tr EXP và 3 Huyền Tinh (Cấp 8)!"));
Task:DelItem(me, tbItemId1, 1); -- Xóa 1 Item tbItemId1 được khai báo ở trên là Siro Ngũ Sắc
me.CastSkill(307, 1, -1, me.GetNpc().nIndex);
end
if (tbAward[nIndex]==4) then -- Xác xuất ra số 4 là 5/100 (5%)
me.AddExp(150000000) -- 100tr Exp
me.AddStackItem(18,1,1,10,self.tbItemInfo,2) -- (18,1,1,12) là Huyền Tinh (Cấp 10) , 2 là số lượng Huyền Tinh (Cấp 10) người chơi nhận được
Dialog:SendBlackBoardMsg(me, string.format("Nhận được 100tr EXP và 2 Huyền Tinh (Cấp 10)!"));
Task:DelItem(me, tbItemId1, 1); -- Xóa 1 Item tbItemId1 được khai báo ở trên là Siro Ngũ Sắc
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow>Người chơi <color=green>["..me.szName.."]<color> sử dụng <color=yellow>Siro Ngũ Sắc<color> nhận được <color=green>2 Huyền Tinh Hoàn Mỹ (Cấp 10)<color> !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow>Người chơi <color=green>["..me.szName.."]<color> sử dụng <color=yellow>Siro Ngũ Sắc<color> nhận được <color=green>2 Huyền Tinh Hoàn Mỹ (Cấp 10)<color> !<color>");
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> sử dụng <color=yellow>Siro Ngũ Sắc<color> nhận được <color=green>2 Huyền Tinh Hoàn Mỹ (Cấp 10)<color> !<color>");	
me.CastSkill(307, 1, -1, me.GetNpc().nIndex);
end
end