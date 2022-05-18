local tbKimNguyenBao	= Item:GetClass("kimnguyenbao");
function tbKimNguyenBao:OnUse()
local tbItemId	= {18,1,25253,1,0,0};
me.AddJbCoin(10000);
me.Msg("<color=yellow>Chúc mừng bạn nhận được 1v Đồng Thường<color>");
Task:DelItem(me, tbItemId, 1);
end