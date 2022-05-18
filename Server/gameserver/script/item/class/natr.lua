
local natruong = Item:GetClass("natr");

function natruong:OnUse()	

	if me.CountFreeBagCell() < 4 then
	me.Msg("Túi của bạn đã đầy, cần ít nhất 4 ô trống.");
	return 0;
	end	
	me.AddStackItem(18,1,476,1,nil,100);
	me.Msg("Bạn nhận được <color=gold>100 Nguyệt Ảnh Thạch<color>");
	return 1;
end

