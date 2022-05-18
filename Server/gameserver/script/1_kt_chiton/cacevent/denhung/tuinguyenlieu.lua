local tbTuiNguyenLieu = Item:GetClass("tuinguyenlieu");
function tbTuiNguyenLieu:OnUse()
if me.CountFreeBagCell() < 10 then
		Dialog:Say("Phải Có 10 Ô Trống Trong Túi Hành Trang");
		return 0;
	end
local tbItemId2	= {18,1,25298,1,0,0};

		local i = 0;
		local nAdd = 0;
		local nRand = 0;
		local nIndex = 0;
		
		-- random
		nRand = MathRandom(1, 4);
		
		-- fill 3 rate	
		local tbRate = {1,1,1,1};
		local tbAward = {20299,20300,20301,20307};
		
		-- get index
		for i = 1, 4 do
			nAdd = nAdd + tbRate[i];
			if nAdd >= nRand then
				nIndex = i;
				break;
			end
		end
			me.AddItem(18,1,tbAward[nIndex],1);--	nuoc
			Task:DelItem(me, tbItemId2, 1);
end
