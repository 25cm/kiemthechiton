-- 精气散
local tbItem = Item:GetClass("jingqisan");

--精气散ID,对应增加精力值
tbItem.tbUseItem =
{
	[1] = {TASK_GROUPID=2024, TASK_ID1=1, TASK_ID2=2, TASK_IDEX=20, nUseMax=50, nAddPoint=500, szTypeName="Tinh Khí Tán (tiểu)"},
	[2] = {TASK_GROUPID=2024, TASK_ID1=5, TASK_ID2=6, nUseMax=500, nAddPoint=10000, szTypeName="Tinh Khí Tán (trung)"},
	[3] = {TASK_GROUPID=2024, TASK_ID1=13, TASK_ID2=14, nUseMax=-1, nAddPoint=1500, szTypeName="Tinh Khí Tán (đại)"},
}
function tbItem:OnUse()
	local tbAddMKP = self.tbUseItem[it.nLevel];
	if tbAddMKP == nil then
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
	if me.GetTask(tbAddMKP.TASK_GROUPID, tbAddMKP.TASK_ID2) >= tbAddMKP.nUseMax and tbAddMKP.nUseMax >= 0 then
		if tbAddMKP.TASK_IDEX and me.GetTask(tbAddMKP.TASK_GROUPID, tbAddMKP.TASK_IDEX) > 0 then
			nExFlag = 1;
		else
			me.Msg(string.format("Mỗi ngày có thể sử dụng <color=yellow>%s<color> %s.",tbAddMKP.nUseMax, tbAddMKP.szTypeName));
			return 0;
		end
	end
	if tbAddMKP.nUseMax >= 0 then
		if nExFlag == 1 then
			local nCount = me.GetTask(tbAddMKP.TASK_GROUPID, tbAddMKP.TASK_IDEX);
			me.SetTask(tbAddMKP.TASK_GROUPID, tbAddMKP.TASK_IDEX, nCount - 1);
		else
			local nCount = me.GetTask(tbAddMKP.TASK_GROUPID, tbAddMKP.TASK_ID2);
			me.SetTask(tbAddMKP.TASK_GROUPID, tbAddMKP.TASK_ID2, nCount + 1);
		end
	end
	me.ChangeCurMakePoint(tbAddMKP.nAddPoint)
	local szMsg = string.format("Sử dụng <color=yellow>%s<color>, nhận được <color=yellow>%s điểm<color> tinh lực.\n", tbAddMKP.szTypeName, tbAddMKP.nAddPoint);
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
				szExMsg = string.format("(Tăng <color=yellow>%s<color> điểm)", nExCount);
			end
			szMsg = szMsg .. string.format("Hôm nay còn có thể sử dụng <color=yellow>%s %s<color> %s\n", tbItem.szTypeName, (tbItem.nUseMax - nMinCount), szExMsg);
		end
	end
	me.Msg(szMsg);
	return 1;
end
