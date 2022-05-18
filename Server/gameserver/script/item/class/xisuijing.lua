
local tbItem = Item:GetClass("xisuijing")
tbItem.tbBook =
{
	[1] = {5, 2040, 6, 10}, --初级洗髓经
	[2] = {5, 2040, 9, 10}, --中级洗髓经
	[3] = {2, 2040, 11, 10},--粽子
}
function tbItem:OnUse()
	local tbParam = self.tbBook[it.nLevel];
	if not tbParam then
		return 0;
	end
	local nUse =  me.GetTask(tbParam[2], tbParam[3]);
	if nUse >= tbParam[1] then
		me.Msg(string.format("<color=yellow> Bạn đã học %s quyển %s, không thể học nữa.", tbParam[1], it.szName));
		Dialog:SendInfoBoardMsg(me, string.format("<color=yellow> Bạn đã đọc kỹ %s, nhưng không được gì.", it.szName))
		return 0;
	end
	
	me.AddPotential(tbParam[4])
	me.SetTask(tbParam[2], tbParam[3], nUse +1)
	
	PlayerHonor:UpdataMaxWealth(me);		-- 更新财富最大值
	local szMsg = string.format("<color=yellow> Bạn đã đọc kỹ %s, đã giác ngộ, nhận được %s điểm tiềm năng.", it.szName, tbParam[4]);
	Dialog:SendInfoBoardMsg(me, szMsg)
	szMsg = string.format("%s đã đọc thành công %s quyển %s.",szMsg, nUse +1, it.szName);
	me.Msg(szMsg);
	
	return 1;
end

function tbItem:GetTip()
	local szTip = "";
	local tbParam = self.tbBook[it.nLevel];
	local nUse =  me.GetTask(tbParam[2], tbParam[3]);
	szTip = szTip .. string.format("<color=green>Đã đọc qua %s quyển này<color>", nUse);
	return szTip;
end
