
local IronBoz = Item:GetClass("ironbox");

function IronBoz:OnUse()
	
	local nWeekOpen	= me.GetTask(2124,6);
	
	if nWeekOpen >= 250 then
		me.Msg("Một tuần chỉ có thể mở 250 Rương Huyền Thiết, vui lòng kiểm tra lại!");
		return 0;		
	end;
	
	if me.CountFreeBagCell() < 1 then
		me.Msg("Túi của bạn đã đầy, cần ít nhất 1 ô trống.");
		return 0;
	end	
	me.AddBindMoney(200000);

	
	nWeekOpen = nWeekOpen + 1;
	me.SetTask(2124,6, nWeekOpen);
	return 1;
end

function IronBoz:WeekEvent()
	me.SetTask(2124, 6, 0);
end;

PlayerSchemeEvent:RegisterGlobalWeekEvent({IronBoz.WeekEvent, IronBoz});
