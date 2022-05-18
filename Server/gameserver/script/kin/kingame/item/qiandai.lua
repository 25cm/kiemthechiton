local tbItem = Item:GetClass("kingame_qiandai")

function tbItem:GetTip()
	local nCount = me.GetTask(KinGame.TASK_GROUP_ID, KinGame.TASK_BAG_ID);
	local szTip = "";
	szTip = szTip..string.format("<color=0x8080ff>Túi đựng tiền xu cổ<color>\n");
	szTip = szTip..string.format("<color=yellow>Tiền xu cổ: %d/1000<color>", nCount);
	return szTip;
end
