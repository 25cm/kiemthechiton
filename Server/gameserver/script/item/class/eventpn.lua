
local EventPhunu = Item:GetClass("eventpn");
EventPhunu.tbItemInfo = {bForceBind=1,};
function EventPhunu:OnUse()
local tbItemId1	= {18,1,20346,1,0,0}; -- 
	DoScript("\\script\\item\\class\\eventpn.lua");
	if me.CountFreeBagCell() < 10 then
		me.Msg("Túi của bạn đã đầy, cần ít nhất 10 ô trống.");
		return 0;
	end
	
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	
	-- random
	nRand = MathRandom(1, 10000);
	
	-- fill 3 rate	
	local tbRate = {2950, 3000, 200, 100, 2950, 300, 500};
	local tbAward = {1 ,2, 3, 4, 5, 6, 7};
	
	-- get index
	for i = 1, 7 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
	
	if nIndex == 0 then
		me.Msg("Xin lỗi, bạn không nhận được gì.");
		return 0;
	end;
	if (tbAward[nIndex]==1) then 
	me.AddStackItem(18,1,20322,1,nil,2); -- 2 Lam Long Đơn
	KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> sử dụng <color=cyan>Túi Quà Tình Thương<color> nhận được <color=cyan>2 Lam Long Đơn<color><color>");	   
	me.Msg("<color=yellow>Nhận được 2 Lam Long Đơn<color>")
	Task:DelItem(me, tbItemId1, 1);
	end
	if (tbAward[nIndex]==2) then
	me.AddStackItem(18,1,2004,1,nil,3); -- 3 Mảnh Vũ Khí Đồng Hành
	KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> sử dụng <color=cyan>Túi Quà Tình Thương<color> nhận được <color=cyan>3 Mảnh Vũ Khi Đồng Hành<color><color>");	   
	me.Msg("<color=yellow>Nhận được 3 Mảnh Vũ Khí Đồng Hành<color>")
	Task:DelItem(me, tbItemId1, 1);
	end
	if (tbAward[nIndex]==3) then
	me.AddItem(18,1,547,3).Bind(1); -- 1 Đồng Hành Chu Đáo
	KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> sử dụng <color=cyan>Túi Quà Tình Thương<color> nhận được <color=cyan>1 Đồng Hành Chu Đáo<color><color>");	   
	me.Msg("<color=yellow>Nhận được 1 Đồng Hành Chu Đáo<color>")
	Task:DelItem(me, tbItemId1, 1);
	end
	if (tbAward[nIndex]==4) then
	me.AddStackItem(18,1,377,1,self.tbItemInfo,5); -- 10 Tần Lăng Hòa Thị Bích
	KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> sử dụng <color=cyan>Túi Quà Tình Thương<color> nhận được <color=cyan>5 Tần Lăng Hòa Thị Bích<color><color>");	   
	me.Msg("<color=yellow>Nhận được 5 Tần Lăng Hòa Thị Bích<color>")
	Task:DelItem(me, tbItemId1, 1);
	end
	if (tbAward[nIndex]==5) then
	me.AddStackItem(18,1,1331,3,self.tbItemInfo,1); -- 1 Tinh Thạch Thánh Hỏa
	KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> sử dụng <color=cyan>Túi Quà Tình Thương<color> nhận được <color=cyan>1 Tinh Thạch Đoạn Hải<color><color>");	   
	me.Msg("<color=yellow>Nhận được 1 Tinh Thạch Đoạn Hải<color>")
	Task:DelItem(me, tbItemId1, 1);
	end
	if (tbAward[nIndex]==6) then
	me.AddItem(18,1,554,4); -- Bí Kíp Đồng Hành Đặc Biệt
	KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> sử dụng <color=cyan>Túi Quà Tình Thương<color> nhận được <color=cyan>1 Bí Kíp Đồng Hành Đặc Biệt<color><color>");	   
	me.Msg("<color=yellow>Nhận được 1 Bí Kíp Đồng Hành Đặc Biệt<color>")
	Task:DelItem(me, tbItemId1, 1);
	end
	if (tbAward[nIndex]==7) then
	me.AddStackItem(18,1,2006,1,nil,3); -- 3 Mảnh Nhẫn ĐỒng Hành
	KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> sử dụng <color=cyan>Túi Quà Tình Thương<color> nhận được <color=cyan>3 Mảnh Nhẫn Đồng Hành<color><color>");	   
	me.Msg("<color=yellow>Nhận được 3 Mảnh Nhẫn Đồng Hành<color>")
	Task:DelItem(me, tbItemId1, 1);
	end
end

