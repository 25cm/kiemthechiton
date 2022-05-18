
local tbItem 	= Item:GetClass("distich_get");
SpecialEvent.SpringFrestival = SpecialEvent.SpringFrestival or {};
local SpringFrestival = SpecialEvent.SpringFrestival or {};

function tbItem:GetTip()
	local nCount = it.GetGenInfo(1);	--那副
	local nPart = it.GetGenInfo(2);		--上联还是下联
	local nTimes = me.GetTask(SpringFrestival.TASKID_GROUP,SpringFrestival.TASKID_IDENTIFYCOUPLET_NCOUNT) or 0;
	if nPart == 1 then
		return string.format("<color=yellow>Hoành phi: %s\nThượng Liễn: %s<color>", SpringFrestival.tbCoupletList[nCount][1], SpringFrestival.tbCoupletList[nCount][nPart + 1]);
	else
		return string.format("<color=yellow>Hoành phi: %s\nHạ Liễn: %s<color>", SpringFrestival.tbCoupletList[nCount][1], SpringFrestival.tbCoupletList[nCount][nPart + 1]);
	end
end
