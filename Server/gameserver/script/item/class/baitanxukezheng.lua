
local tbBaiTan = Item:GetClass("baitanxukezheng");

function tbBaiTan:OnUse()
	local pPlayer = me;
	local nTotalTime	= pPlayer.GetTask(Stall.TASK_GROUP_ID, Stall.TASK_TOTAL_TIME);
	if (nTotalTime > 3600 * 8 * 8)then 
		pPlayer.Msg("Bạn đã bày bán hơn 72 giờ, tạm thời không thể sử dụng giấy phép bày bán.");
		return 0;
	end
	nTotalTime = nTotalTime + 3600 * 8;  -- 测试用三分钟  8 * 60; 
	pPlayer.SetTask(Stall.TASK_GROUP_ID, Stall.TASK_TOTAL_TIME, nTotalTime, 0);

	local szTime	= Lib:TimeDesc(nTotalTime);
	pPlayer.Msg("Thời gian cho phép bán là "..szTime..".");
	return 1;
end

