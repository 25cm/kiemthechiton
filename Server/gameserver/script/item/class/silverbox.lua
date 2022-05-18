
local Silboz = Item:GetClass("silverbox");

function Silboz:OnUse()
	
	local nWeekOpen	= me.GetTask(2124,2);
	
	if nWeekOpen >= 100 then
		me.Msg("Một tuần chỉ có thể mở 100 Rương Bạch Ngân, vui lòng kiểm tra lại!");
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
	local tbRate = {4725, 4525, 650};
	local tbAward = {1 ,2, 3};
	
	-- get index
	for i = 1, 3 do
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
	me.AddStackItem(18,1,1334,1,nil,3);
	end
	if (tbAward[nIndex]==2) then
	me.AddStackItem(18,1,1333,1,nil,3);
	end
	if (tbAward[nIndex]==3) then
	me.AddStackItem(18,1,476,1,nil,25);
	end	
	nWeekOpen = nWeekOpen + 1;
	me.SetTask(2124,2, nWeekOpen);
	return 1;
end

function Silboz:WeekEvent()
	me.SetTask(2124, 2, 0);
end;

PlayerSchemeEvent:RegisterGlobalWeekEvent({Silboz.WeekEvent, Silboz});
