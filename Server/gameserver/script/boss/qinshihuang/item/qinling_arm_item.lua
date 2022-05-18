-- 秦陵白银、黄金物品增加声望物品
-- By Peres 2009/06/13
-- 何不食肉糜

local tbItem = Item:GetClass("qinling_arm_item");

tbItem.tbData = 
{
	[5000] = {100, 2},
    [5000] = {100, 3},	-- 玉符，每次 100 点，最高加到 2 级
	[377] = {100, 3}, -- 和氏璧，每次 100 点，最高加到 3 级
}

function tbItem:OnUse()
	
	if not self.tbData[it.nParticular] then
		me.Msg("Không thể sử dụng!");
		return;
	end
	
	local nReputeLevel = me.GetReputeLevel(9, 2);
	if nReputeLevel >= self.tbData[it.nParticular][2] then
		me.Msg("Sử dụng <color=yellow>"..it.szName.."<color>, danh vọng <color=green>Tần Lăng - Phát Khâu Môn<color> tăng <color=yellow>"..self.tbData[it.nParticular][2].."<color> điểm!");
		return;
	end
	
	local nFlag = Player:AddRepute(me, 9, 2, self.tbData[it.nParticular][1]);
	if (nFlag == 0) then
		return;
	elseif (nFlag == 1) then
		me.Msg("Danh vọng <color=green>Tần Lăng - Phát Khâu Môn<color> của bạn đã đạt cấp cao nhất, không thể tăng thêm!");
		return;
	end	
	return 1;
end

