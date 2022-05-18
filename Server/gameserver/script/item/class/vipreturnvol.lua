local TASK_VIPPLAYER_TASKID = 2083;

local tbItem 	= Item:GetClass("fanhuanjuan");


function tbItem:GetTip()
	local nLevel = it.nLevel + 2;
	if (nLevel < 2 or nLevel > 6)then
		assert(false);
	end
	local szTip = "Số Phản Hoàn Quyển còn <color=yellow>" .. me.GetTask(TASK_VIPPLAYER_TASKID, nLevel) .. "<color>";
	return szTip;
end
