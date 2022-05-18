local tbBinhNgocBich = Item:GetClass("binhngocbich")
function tbBinhNgocBich:OnUse()
DoScript("\\script\\item\\class\\binhngocbich.lua");
local tbItemId	= {18,1,25194,1,0,0};
me.AddExp(50000)
me.Msg("<color=green>Chúc mừng bạn nhận được <color> <color=yellow>50.000 EXP<color>");

Task:DelItem(me, tbItemId, 1);
end