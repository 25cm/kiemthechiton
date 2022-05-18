
local tbItem = Item:GetClass("merchant_token")

function tbItem:InitGenInfo()
	-- 設定有效期限
	if Merchant.TASK_ITEM_FIX[it.nLevel] and 
	   Merchant.TASK_ITEM_FIX[it.nLevel].nLiveTime then
		it.SetTimeOut(1, Merchant.TASK_ITEM_FIX[it.nLevel].nLiveTime);
	end
	return	{ };
end

function tbItem:OnUse()
	local tbData = Merchant.TASK_ITEM_FIX[it.nLevel];
	if not tbData then
		return 0;
	end
	local tbFind1 = me.FindItemInBags(unpack(Merchant.MERCHANT_BOX_ITEM));
	if #tbFind1 <= 0 then
		Dialog:Say("Bạn không có <color=yellow>hộp thu thập lệnh bài thương hội<color>, không thể đặt lệnh bài vào.");
		return 0;
	end
	local nSubTaskId = tbData.nTask;
	local nMaxNum = tbData.nMax;
	local nCurrNum = me.GetTask(Merchant.TASK_GOURP, nSubTaskId);
	if nCurrNum >= nMaxNum then
		Dialog:Say(string.format("Đã thu thập đủ <color=yellow>%s<color>", tbData.szName));
		return 0;
	end
	me.SetTask(Merchant.TASK_GOURP, nSubTaskId, nCurrNum + 1);
	me.Msg(string.format("Đã thu thập 1 <color=green>%s<color>", tbData.szName));
	return 1;
end
