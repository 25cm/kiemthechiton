local tbFuDaiItem = Item:GetClass("fudainew");

function tbFuDaiItem:OnUse()
	
	if me.CountFreeBagCell() < 6 then
		me.Msg("Túi của bạn đã đầy, cần ít nhất 6 ô trống.");
		return 0;
	end
	
	me.AddBindMoney(5000);
	
	return 1;
end

