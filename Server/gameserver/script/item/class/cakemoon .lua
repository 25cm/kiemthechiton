
local MoonCake = Item:GetClass("mooncake");

function MoonCake:OnUse()
	
	local nWeekOpen	= me.GetTask(2124,4);
	
	if nWeekOpen >= 200 then
		me.Msg("Một người chỉ đuợc dùng 200 cái trong suốt event, vui lòng kiểm tra lại!");
		return 0;		
	end;
	
	if me.CountFreeBagCell() < 10 then
		me.Msg("Túi của bạn đã đầy, cần ít nhất 10 ô trống.");
		return 0;
	end
	
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	
	-- random
	nRand = MathRandom(1, 10000);
	
	-- fill 3 rate	
	local tbRate = {1500, 1300, 950, 745, 505, 2000,2000,200,400,400};
	local tbAward = {1 ,2, 3, 4, 5, 6, 7, 8, 9, 10};
	
	-- get index
	for i = 1, 10 do
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
	me.AddStackItem(18,1,476,1,nil,10);
	end
	if (tbAward[nIndex]==3) then
	me.AddItem(18,1,547,3);
	end
	if (tbAward[nIndex]==4) then
	me.AddItem(18,1,377,1).Bind(1);
	end
	if (tbAward[nIndex]==5) then
	me.AddItem(1,26,46,1).Bind(1);
	me.AddItem(1,26,47,1).Bind(1);
	end
	if (tbAward[nIndex]==6) then
	me.AddStackItem(18,1,1336,1,nil,5);
	end
	if (tbAward[nIndex]==7) then
	me.AddStackItem(18,1,597,1,nil,500);
	end
	if (tbAward[nIndex]==8) then
	me.AddItem(18,1,554,4);
	end
	if (tbAward[nIndex]==9) then
	me.AddItem(18,1,554,3);
	end
	if (tbAward[nIndex]==10) then
	me.AddItem(18,1,563,1);
	end
	
	nWeekOpen = nWeekOpen + 1;
	me.SetTask(2124,4, nWeekOpen);
	return 1;
end

function MoonCake:WeekEvent()
	me.SetTask(2124, 4, 0);
end;

PlayerSchemeEvent:RegisterGlobalWeekEvent({MoonCake.WeekEvent, MoonCake});
