local tbNganNguyenBao	= Item:GetClass("ngannguyenbao");
function tbNganNguyenBao:OnUse()
local tbItemId	= {18,13,20393,1,0,0};
me.Earn(2000000,0);
me.Msg("<color=yellow>Chúc mừng bạn nhận được 200v Bạc Thường<color>");

Task:DelItem(me, tbItemId, 1);
end