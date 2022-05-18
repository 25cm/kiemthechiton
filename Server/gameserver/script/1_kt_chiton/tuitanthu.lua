local tbItem = Item:GetClass("tuitanthu")

function tbItem:OnUse()

local tbItemInfo = {bForceBind = 1};
if me.nLevel < 125 then
		if me.CountFreeBagCell() < 25 then
		Dialog:Say("Trống 25 ô mới mở được Túi Quà");
		return 0;
	end
		if me.CountFreeBagCell() >= 25 then
	me.AddLevel(125-me.nLevel);	
    me.Earn(1000000,0);
	me.AddBindMoney(30000000);
	me.AddBindCoin(3000000);
		--me.AddItem(18,1,351,1);
	me.AddStackItem(18,1,235,1,tbItemInfo,1);	 --truyen tong phu
	--3 tui 24 ?
    me.AddStackItem(1,12,33,4,tbItemInfo,1); --ngua pv
	me.AddStackItem(18,1,377,1,tbItemInfo,200);
    me.AddStackItem(18,1,205,1,tbItemInfo,2400)	 ---nhht
	me.AddItem(5,23,1,1); -- Phù C?p 1
	me.AddItem(5,20,1,1); -- áo C?p 1
	me.AddItem(5,22,1,1); -- Bao Tay C?p 1
	me.AddItem(5,21,1,1); -- Nh?n C?p 1
	me.AddItem(5,19,1,1); -- V? Khí C?p 1
	me.AddItem(1,14,25,4); --GLK
	me.AddItem(1,16,14,3); --luan hoi an
	me.AddItem(1,24,2,1);  --chan nguyen
	me.AddItem(1,27,6,1);   -- thanh linh
	me.AddItem(1,13,156,4);  --mat na
	me.AddStackItem(18,1,25502,1,tbItemInfo,1);   --tui qua trang bi
	me.AddStackItem(18,1,547,1,tbItemInfo,1);    -- dong hanh 4 skill
	--me.AddItem(18,1,382,1).Bind(1);
	me.AddItem(18,1,16,1); --tu luyen chau
	me.AddItem(19,3,1,7);  --thuc an
		for i=1, 30 do
		local pItem = me.AddItem(18,1,543,1,1,1);	 -- skndh
		pItem.Bind(1);
	end
	end

	return 1;
end
if me.nLevel >= 125 then
local tbItemId	= {18,1,1194,7,0,0};
	Task:DelItem(me, tbItemId, 1);
end

end;