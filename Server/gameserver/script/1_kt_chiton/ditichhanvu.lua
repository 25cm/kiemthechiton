local tbditichhanvu = Item:GetClass("ditichhanvu")
function tbditichhanvu:OnUse()
DoScript("\\script\\ditichhanvu.lua");
local tbItemId	= {18,1,529,7};
me.AddRepute(5,6,300)
me.Msg("Ban nhan duoc <color=yellow>300 Diem Di Tich Han Vu<color>");

Task:DelItem(me, tbItemId, 1);
end