
local GoldBoz = Item:GetClass("goldbox");

function GoldBoz:OnUse()
	
	local nWeekOpen	= me.GetTask(2124,1);
	
	if nWeekOpen >= 70 then
		me.Msg("Một tuần chỉ có thể mở 70 Rương Hoàng Kim, vui lòng kiểm tra lại!");
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
	local tbRate = {4500, 4300, 650, 550};
	local tbAward = {1 ,2, 3, 4};
	
	-- get index
	for i = 1, 4 do
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
	me.AddStackItem(18,1,1334,1,nil,5);
	end
	if (tbAward[nIndex]==2) then
	me.AddStackItem(18,1,1333,1,nil,5);
	end
	if (tbAward[nIndex]==3) then
	me.AddStackItem(18,1,476,1,nil,50);
	end
	if (tbAward[nIndex]==4) then
	me.AddItem(18,1,377,1);
	end
	
	nWeekOpen = nWeekOpen + 1;
	me.SetTask(2124,1, nWeekOpen);
	return 1;
end

function GoldBoz:WeekEvent()
	me.SetTask(2124, 1, 0);
end;

PlayerSchemeEvent:RegisterGlobalWeekEvent({GoldBoz.WeekEvent, GoldBoz});
