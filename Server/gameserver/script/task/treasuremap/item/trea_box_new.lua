--新的箱子
--产出的玄晶都绑定，其他物品不绑

local tbItem	= Item:GetClass("treasurebox_new");

tbItem.tbUseKey = {
	[1] = {tbKey={18, 1, 77,  1}, szAward="tbAwardTreaBox"},
	[2] = {tbKey={18, 1, 82,  1}, szAward="tbAwardTreaBox_Level2"},
	[3] = {tbKey={18, 1, 187, 1}, szAward="tbAwardTreaBox_Level3"},
}

function tbItem:OnUse()
	if not self.tbUseKey[it.nLevel] then
		return 0; 
	end
	local nKeys	= me.GetItemCountInBags(unpack(self.tbUseKey[it.nLevel].tbKey));
	
	if nKeys <=0 then
		Dialog:SendInfoBoardMsg(me, string.format("<color=red>Phải có <color><color=yellow>%s<color><color=red> để mở %s!<color>", KItem.GetNameById(unpack(self.tbUseKey[it.nLevel].tbKey)), it.szName));
		return 0;
	end;
	
	local tbRate	= TreasureMap[self.tbUseKey[it.nLevel].szAward];
	
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
	me.ConsumeItemInBags(1, unpack(self.tbUseKey[it.nLevel].tbKey));
	
	local pItem = me.AddItem(tbRate[nSelect].Genre,
								tbRate[nSelect].Detail,
								tbRate[nSelect].Particular,
								tbRate[nSelect].Level,
								tbRate[nSelect].Five);
	if pItem then
		
		if tbRate[nSelect].Genre == 18 and tbRate[nSelect].Detail == 1 and tbRate[nSelect].Particular == 1 then
			pItem.Bind(1); --如果是玄晶进行绑定
		end
		
		me.Msg("Dùng 1 chìa khóa mở rương, bạn sẽ có niềm vui bất ngờ: <color=yellow>"..pItem.szName.."<color>");
	end
	return 1;
	
end;
