-- �ļ�������couplet_identify.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2009-12-28 17:42:09
-- ��  ��  ���������Ķ���

local tbItem 	= Item:GetClass("distich_get");
SpecialEvent.SpringFrestival = SpecialEvent.SpringFrestival or {};
local SpringFrestival = SpecialEvent.SpringFrestival or {};

function tbItem:GetTip()
	local nCount = it.GetGenInfo(1);	--�Ǹ�
	local nPart = it.GetGenInfo(2);		--������������
	local nTimes = me.GetTask(SpringFrestival.TASKID_GROUP,SpringFrestival.TASKID_IDENTIFYCOUPLET_NCOUNT) or 0;
	if nPart == 1 then
		return string.format("<color=yellow>������%s\n������%s<color>", SpringFrestival.tbCoupletList[nCount][1], SpringFrestival.tbCoupletList[nCount][nPart + 1]);
	else
		return string.format("<color=yellow>������%s\n������%s<color>", SpringFrestival.tbCoupletList[nCount][1], SpringFrestival.tbCoupletList[nCount][nPart + 1]);
	end
end
