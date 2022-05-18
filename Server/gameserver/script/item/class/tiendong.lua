local tbTienDong	= Item:GetClass("tiendong");
function tbTienDong:OnUse()
local tbItemId	= {18,13,20394,1,0,0};
me.AddBindMoney(2000000,0);
me.Msg("<color=yellow>Chúc mừng bạn nhận được 200v Bạc Khóa<color>")
Task:DelItem(me, tbItemId, 1);
end