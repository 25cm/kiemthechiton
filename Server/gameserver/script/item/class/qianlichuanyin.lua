
local tbItem = Item:GetClass("qianlichuanyin");
local nParticular = 924;
-- 道具可增加公聊的次数
local tbUseCount = 
{
	[nParticular] = 2,
	[nParticular + 1] = 11,
};

function tbItem:OnUse()
	if (me.nLevel < 30) then
		me.Msg("Nhân vật cấp lớn hơn 30 mới sử dụng được.");
		return 0;
	end
	local nCount = me.GetTask(ChatChannel.TASK_CHAT, 4);
	local nAdd = tbUseCount[it.nParticular];
	if (nAdd == nil or nAdd <= 0) then
		return 0;
	end
	nCount = nCount + nAdd;
	me.SetTask(ChatChannel.TASK_CHAT, 4, nCount);
	me.Msg(string.format("Số lần trò chuyện kênh công cộng tăng %d lần, tổng cộng %d lần.", nAdd, nCount));
	return 1;
end
