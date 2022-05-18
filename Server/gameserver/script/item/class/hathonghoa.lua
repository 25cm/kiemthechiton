
local HHhat = Item:GetClass("hathonghoa");

function HHhat:OnUse()
	
	
	local tbOpt = {
		{"Kết thúc đối thoại"},
	};
	
	
	Dialog:Say("Khóa Event Tạm Thời", tbOpt);
	-- if me.CountFreeBagCell() < 10 then
		-- me.Msg("Túi của bạn đã đầy, cần ít nhất 11 ô trống.");
		-- return 0;
	-- end
	
	-- local i = 0;
	-- local nAdd = 0;
	-- local nRand = 0;
	-- local nIndex = 0;
	

	-- nRand = MathRandom(1, 10000);
	

	-- local tbRate = {4900, 4700, 250, 150};
	-- local tbAward = {1 ,2, 3, 4};
	

	-- for i = 1, 4 do
		-- nAdd = nAdd + tbRate[i];
		-- if nAdd >= nRand then
			-- nIndex = i;
			-- break;
		-- end
	-- end
	
	-- if nIndex == 0 then
		-- me.Msg("Xin lỗi, bạn không nhận được gì.");
		-- return 0;
	-- end;
	-- if (tbAward[nIndex]==1) then
	-- me.AddStackItem(18,1,298,1,nil,1);
	-- end
	-- if (tbAward[nIndex]==2) then
	-- me.AddStackItem(18,1,298,1,nil,2);
	-- end
	-- if (tbAward[nIndex]==3) then
	-- me.AddStackItem(18,1,298,1,nil,3);
	-- end
	-- if (tbAward[nIndex]==4) then
	-- me.AddStackItem(18,1,298,1,nil,4);
	-- end
	return 0;
end

