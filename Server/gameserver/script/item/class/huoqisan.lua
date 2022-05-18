-- 活气散
local tbItem = Item:GetClass("huoqisan");

--活气散ID,对应增加活力值
tbItem.tbUseItem =
{
	--等级 =
	[1] = {TASK_GROUPID=2024, TASK_ID1=3, TASK_ID2=4, TASK_IDEX=21, nUseMax=50, nAddPoint=500,	 szTypeName="Hoạt Khí Tán (tiểu)"},
	[2] = {TASK_GROUPID=2024, TASK_ID1=7, TASK_ID2=8, nUseMax=500, nAddPoint=10000, szTypeName="Hoạt Khí Tán (trung)"},
	[3] = {TASK_GROUPID=2024, TASK_ID1=15, TASK_ID2=16, nUseMax=-1, nAddPoint=1500, szTypeName="Hoạt Khí Tán (đại)"},
}

function tbItem:OnUse()
	local tbAddGTP = self.tbUseItem[it.nLevel];
	if tbAddGTP == nil then
		return 0;
	end
	local nNowDay =tonumber(GetLocalDate("%Y%m%d"));
	for _, tbItem in ipairs(self.tbUseItem) do
		local nDay = me.GetTask(tbItem.TASK_GROUPID, tbItem.TASK_ID1);
		if nNowDay > nDay then
			me.SetTask(tbItem.TASK_GROUPID, tbItem.TASK_ID1, nNowDay);
			me.SetTask(tbItem.TASK_GROUPID, tbItem.TASK_ID2, 0);
		end
	end
	
	local nExFlag = 0;
	if me.GetTask(tbAddGTP.TASK_GROUPID, tbAddGTP.TASK_ID2) >= tbAddGTP.nUseMax and tbAddGTP.nUseMax >= 0 then
		if tbAddGTP.TASK_IDEX and me.GetTask(tbAddGTP.TASK_GROUPID, tbAddGTP.TASK_IDEX) > 0 then
			nExFlag = 1;
		else
		me.Msg(string.format("Mỗi ngày có thể sử dụng <color=yellow>%s<color> %s。",tbAddGTP.nUseMax, tbAddGTP.szTypeName));
		return 0;
		end
	end
	if tbAddGTP.nUseMax >= 0 then
		if nExFlag == 1 then
			local nCount = me.GetTask(tbAddGTP.TASK_GROUPID, tbAddGTP.TASK_IDEX);
			me.SetTask(tbAddGTP.TASK_GROUPID, tbAddGTP.TASK_IDEX, nCount - 1);
		else
		local nCount = me.GetTask(tbAddGTP.TASK_GROUPID, tbAddGTP.TASK_ID2);
		me.SetTask(tbAddGTP.TASK_GROUPID, tbAddGTP.TASK_ID2, nCount + 1);
		end
	end
	me.ChangeCurGatherPoint(tbAddGTP.nAddPoint);
	local szMsg = string.format("Sử dụng <color=yellow>%s<color>, nhận được <color=yellow>%s điểm<color> hoạt lực.\n", tbAddGTP.szTypeName, tbAddGTP.nAddPoint);
	me.Msg(szMsg);
	szMsg = "";
	for _, tbItem in ipairs(self.tbUseItem) do
		local nMinCount = me.GetTask(tbItem.TASK_GROUPID, tbItem.TASK_ID2);
		local nExCount 	= 0;
		if tbItem.TASK_IDEX then
			nExCount = me.GetTask(tbItem.TASK_GROUPID, tbItem.TASK_IDEX);
		end
		if tbItem.nUseMax < 0 then
			szMsg = szMsg .. string.format("Có thể sử dụng <color=yellow>%s<color> không giới hạn\n", tbItem.szTypeName);
		else
			--local szCount = "零"
			--if (tbItem.nUseMax - nMinCount) > 0 then
			--	szCount = Lib:Transfer4LenDigit2CnNum((tbItem.nUseMax - nMinCount));
			--end
			local szExMsg = "";
			if nExCount > 0 then
				szExMsg = string.format("(Nhận <color=yellow>%s<color>)", nExCount);
			end			
			szMsg = szMsg .. string.format("Có thể sử dụng <color=yellow>%s %s<color> %s\n", tbItem.szTypeName, (tbItem.nUseMax - nMinCount), szExMsg);
		end
	end
	me.Msg(szMsg);
	return 1;
end
