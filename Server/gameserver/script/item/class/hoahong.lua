
local HHEvent = Item:GetClass("hoahongevent");

function HHEvent:OnUse()
	
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
	local tbRate = {5000, 5000};
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
	me.AddBindMoney(100000);
	end
	if (tbAward[nIndex]==2) then
	me.AddBindCoin(20000);
	end	
	
	return 1;
end

