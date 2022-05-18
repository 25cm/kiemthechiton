
local natruong = Item:GetClass("100tdl");

function natruong:OnUse()	

	if me.CountFreeBagCell() < 5 then
	me.Msg("Túi của bạn đã đầy, cần ít nhất 5 ô trống.");
	return 0;
	end	
	me.AddStackItem(18,1,553,1,nil,100);
	me.Msg("Bạn nhận được <color=gold>100 Tiền Du Long<color>");
	return 1;
end

