-- 秦陵炼化套装声望物品
-- By Peres 2009/06/13
-- 何不食肉糜

local tbItem = Item:GetClass("qinling_refine_item");

tbItem.tbData = 
{
	[360] = {10, 2}, -- 长明灯，每次 10 点，最高加到 2 级
	[363] = {10, 3}, -- 搬山印，每次 10 点，最高加到 3 级
	[366] = {10, 4}, -- 摸金符，每次 10 点，最高加到 4 级
	[375] = {10*50, 4},-- 摸金符x50，每次 10 点，最高加到 4 级
}

function tbItem:OnUse()
	
	if not self.tbData[it.nParticular] then
		me.Msg("Không thể sử dụng!");
		return;
	end
	
--	local nDailyNum	= me.GetTask(Boss.Qinshihuang.TASK_GROUP_ID, Boss.Qinshihuang.TASK_REFINE_ITEM);
--	if nDailyNum >= Boss.Qinshihuang.MAX_DAILY_REFINEITEM then
--		me.Msg("<color=green>Tần Lăng - Quan Phủ<color>的声望物品每天只能使用 <color=yellow>10 个<color>！");
--		return;
--	end
	
	
	local nReputeLevel = me.GetReputeLevel(9, 1);
	if nReputeLevel >= self.tbData[it.nParticular][2] then
		me.Msg("Sử dụng <color=yellow>"..it.szName.."<color>, danh vọng <color=green>Tần Lăng - Quan Phủ<color> tăng <color=yellow>"..self.tbData[it.nParticular][2].."<color> điểm!");
		return;
	end
	
	local nFlag = Player:AddRepute(me, 9, 1, self.tbData[it.nParticular][1]);
	if (nFlag == 0) then
		return;
	elseif (nFlag == 1) then
		me.Msg("Danh vọng <color=green>Tần Lăng - Quan Phủ<color> của bạn đã đạt cấp cao nhất, không thể tăng thêm!");
		return;
	end	
	
--	nDailyNum = nDailyNum + 1;
--	me.SetTask(Boss.Qinshihuang.TASK_GROUP_ID, Boss.Qinshihuang.TASK_REFINE_ITEM, nDailyNum);
	return 1;
end

