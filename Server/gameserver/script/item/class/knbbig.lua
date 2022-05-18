
local KnbBiz = Item:GetClass("knbbig");

function KnbBiz:OnUse()	
	me.AddJbCoin(99900);
	me.Msg("Bạn nhận được <color=gold>99.900 đồng<color>");
	return 1;
end

