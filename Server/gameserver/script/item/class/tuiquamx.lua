local tbMungXuan = Item:GetClass("tuiquamungxuan")
function tbMungXuan:OnUse()
	if me.CountFreeBagCell() < 23 then
		me.Msg( "Hành trang của bạn không đủ 23 ô trống.")
		return 0;
	end	
local tbItemId1	= {18,1,25251,1,0,0};
me.AddBindCoin(10000000);
me.AddItem(18,1,377,1).Bind(1)
me.AddItem(18,1,377,1).Bind(1)
me.AddItem(18,1,377,1).Bind(1)
me.AddItem(18,1,377,1).Bind(1)
me.AddItem(18,1,377,1).Bind(1)
---------
me.AddItem(18,1,25252,1).Bind(1)
me.AddItem(18,1,25252,1).Bind(1)
me.AddItem(18,1,25252,1).Bind(1)
me.AddItem(18,1,25252,1).Bind(1)
me.AddItem(18,1,25252,1).Bind(1)
---------
me.AddItem(18,1,916,1).Bind(1)
me.AddItem(18,1,916,1).Bind(1)
me.AddItem(18,1,916,1).Bind(1)
me.AddItem(18,1,916,1).Bind(1)
me.AddItem(18,1,916,1).Bind(1)
--------
me.AddItem(18,1,215,3).Bind(1)
me.AddItem(18,1,215,3).Bind(1)
me.AddItem(18,1,215,3).Bind(1)
me.AddItem(18,1,215,3).Bind(1)
me.AddItem(18,1,215,3).Bind(1)
	Task:DelItem(me, tbItemId1, 1);
end