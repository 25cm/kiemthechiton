
local KnbSmal = Item:GetClass("knbsmall");

function KnbSmal:OnUse()	
	me.AddJbCoin(9990);
	me.Msg("Bạn nhận được <color=gold>9.990 đồng<color>");
	return 1;
end

