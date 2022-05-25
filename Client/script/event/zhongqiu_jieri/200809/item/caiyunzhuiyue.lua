--彩云追月
--2008.09.03
--孙多良


local tbItem = Item:GetClass("caiyunzhuiyue");

tbItem.tbBook =
{ --物品等级 = {次数上限，任务变量组，任务变量, 增加潜能点数量};
  2, 2040, 20, 10,
}
function tbItem:OnUse()
	local tbParam = self.tbBook;
	if not tbParam then
		return 0;
	end
	local nUse =  me.GetTask(tbParam[2], tbParam[3]);
	if nUse >= tbParam[1] then
		me.Msg(string.format("<color=yellow>Bạn đã ăn %s cái %s, không thể ăn nữa.", tbParam[1], it.szName));
		Dialog:SendInfoBoardMsg(me, string.format("<color=yellow>Bạn cắn 1 miếng %s, thấy nhạt nhẽo.", it.szName))
		return 0;
	end
	
	me.AddPotential(tbParam[4])
	me.SetTask(tbParam[2], tbParam[3], nUse +1)
	
	PlayerHonor:UpdataMaxWealth(me);		-- 更新财富最大值
	local szMsg = string.format("<color=yellow>Bạn đã ăn %s, dường như ngộ ra gì đó, nhận được %s điểm kỹ năng.", it.szName, tbParam[4]);
	Dialog:SendInfoBoardMsg(me, szMsg)
	szMsg = string.format("%s đã ăn %s cái %s.",szMsg, nUse +1, it.szName);
	me.Msg(szMsg);
	
	return 1;
end

function tbItem:GetTip()
	local szTip = "";
	local tbParam = self.tbBook;
	local nUse =  me.GetTask(tbParam[2], tbParam[3]);
	szTip = szTip .. string.format("<color=green>đã ăn %s/%s cái<color>", nUse, self.tbBook[1]);
	return szTip;
end