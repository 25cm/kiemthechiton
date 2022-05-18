local tbTienVang	= Item:GetClass("tienvang");
function tbTienVang:OnUse()
local tbItemId	= {18,13,20395,1,0,0};
me.AddBindCoin(200000);
me.Msg("<color=yellow>Chúc mừng bạn nhận được 20v Đồng Khóa<color>")

Task:DelItem(me, tbItemId, 1);
end