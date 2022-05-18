
local tbItem	= Item:GetClass("treasurebox_level2");

function tbItem:OnUse()
	
	local nKeys	= me.GetItemCountInBags(18, 1, 82, 1);
	
	if nKeys <=0 then
		Dialog:SendInfoBoardMsg(me, "<color=red>Phải có<color> <color=yellow>Chìa khóa bạc<color> <color=red>mới mở được Rương bạc tinh xảo này!<color>");
		return;
	end;
	
	local tbRate	= TreasureMap.tbAwardTreaBox_Level2;
	
	local nRow = #tbRate;
	local nRandom = 0;
	local nAdd = 0;
	local i=0;
	local nSelect = 0;

	for i=1, nRow do
		nAdd = nAdd + tbRate[i].Rate;
	end;

	nRandom = MathRandom(1, nAdd);

	nAdd = 0;

	for i=1, nRow do
		nAdd = nAdd + tbRate[i].Rate;
		if nAdd>=nRandom then
			nSelect = i;
			break;
		end;
	end;
	
	if nSelect == 0 then
		me.Msg("Chọn sai phần thưởng!");
		return;
	end;
	
	-- 删盒子删钥匙
	me.ConsumeItemInBags(1, 18, 1, 82, 1);
	
	local pItem = me.AddItem(tbRate[nSelect].Genre,
								tbRate[nSelect].Detail,
								tbRate[nSelect].Particular,
								tbRate[nSelect].Level,
								tbRate[nSelect].Five);

	me.Msg("Dùng 1 chìa khóa bạc mở rương, bạn sẽ có niềm vui bất ngờ: <color=yellow>"..pItem.szName.."<color>");
	return 1;
	
end;

