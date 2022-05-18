local tbLongHonDon = Item:GetClass("lenhbaidanhvongmoi")
function tbLongHonDon:OnUse()
local tbItemId2	= {18,1,8000,1,0,0};
me.AddRepute(13,1,50)
Task:DelItem(me, tbItemId2, 1);
end