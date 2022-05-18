
local CuBoz = Item:GetClass("cubox");

function CuBoz:OnUse()
	
	local nWeekOpen	= me.GetTask(2124,3);
	
	if nWeekOpen >= 120 then
		me.Msg("Một tuần chỉ có thể mở 120 Rương Thanh Đồng, vui lòng kiểm tra lại!");
		return 0;		
	end;
	
	if me.CountFreeBagCell() < 1 then
		me.Msg("Túi của bạn đã đầy, cần ít nhất 1 ô trống.");
		return 0;
	end
	
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	
	-- random
	nRand = MathRandom(1, 10000);
	
	-- fill 3 rate	
	local tbRate = {5000,5000};
	local tbAward = {1 ,2};
	
	-- get index
	for i = 1, 2 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
	
	if nIndex == 0 then
		me.Msg("Xin lỗi, bạn không nhận được gì.");
		return 0;
	end;
	if (tbAward[nIndex]==1) then
	me.AddBindMoney(500000);
	end
	if (tbAward[nIndex]==2) then
	me.AddBindCoin(50000);
	end

	
	nWeekOpen = nWeekOpen + 1;
	me.SetTask(2124,3, nWeekOpen);
	return 1;
end

function CuBoz:WeekEvent()
	me.SetTask(2124, 3, 0);
end;

PlayerSchemeEvent:RegisterGlobalWeekEvent({CuBoz.WeekEvent, CuBoz});
