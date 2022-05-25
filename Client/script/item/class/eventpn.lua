
local EventPhunu = Item:GetClass("eventpn");

function EventPhunu:OnUse()
	
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
	local tbRate = {2950, 3000, 200, 100, 2950, 300, 500};
	local tbAward = {1 ,2, 3, 4, 5, 6, 7};
	
	-- get index
	for i = 1, 7 do
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
	me.AddStackItem(18,1,1343,1);
	end
	if (tbAward[nIndex]==3) then
	me.AddItem(18,1,547,3);
	end
	if (tbAward[nIndex]==4) then
	me.AddItem(18,1,377,1);
	end
	if (tbAward[nIndex]==5) then
	me.AddStackItem(18,1,1333,1,nil,5);
	end
	if (tbAward[nIndex]==6) then
	me.AddItem(18,1,554,4);
	end
	if (tbAward[nIndex]==7) then
	me.AddStackItem(18,1,1343,1,nil,5);
	end
	return 1;
end

