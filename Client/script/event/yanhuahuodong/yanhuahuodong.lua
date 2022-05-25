--
-- �̻���ű�
-- zhengyuhua

SpecialEvent.tbYanHua = {}
local tbYanHua = SpecialEvent.tbYanHua;

tbYanHua.BEGIN_TIME		= 20090727	-- ��ʼ����
tbYanHua.END_TIME		= 20090817	-- ��������
tbYanHua.TASK_GROUP		= 2038
tbYanHua.TASK_DATE_ID	= 9
tbYanHua.YANHUA_ITEM	= {18,1,180,1};

function tbYanHua:CheckEventTime()
	local nCurDate = tonumber(os.date("%Y%m%d",GetTime()));
	if nCurDate >= self.BEGIN_TIME and nCurDate < self.END_TIME then
		return 1;
	end
	return 0;
end

function tbYanHua:DialogLogic()
	local nCurDate = tonumber(os.date("%Y%m%d",GetTime()));
	if nCurDate < self.BEGIN_TIME then
		Dialog:Say("ʢ�Ļ�̻���ȡ����7��27����ʽ��ʼ��");
		return 0;
	elseif nCurDate > self.END_TIME then
		Dialog:Say("ʢ�Ļ�̻���ȡ�Ѿ�������");
		return 0;
	end
	local nDate = me.GetTask(self.TASK_GROUP, self.TASK_DATE_ID);
	local szInfo;
	local nKinId, nMemberId = me.GetKinMember();
	local nRet = Kin:HaveFigure(nKinId, nMemberId, 3)
	if nDate == nCurDate or nRet ~= 1 then
		szInfo = "  ��7��27����8��17��0�㣬���ÿ����Դ�������ȡһ���̻�����ֻ�м�������<color=red>��ʽ��Ա<color>������ȡ�̻����һ�ڼ䣬<color=red>ÿ��ֻ����ȡһ��<color>"
	end
	if me.CountFreeBagCell() <= 0 then
		szInfo = "��ı����ռ䲻��"
	end
	
	if not szInfo then
		local pItem = me.AddItem(unpack(self.YANHUA_ITEM));
		if pItem then
			me.SetItemTimeout(pItem, os.date("%Y/%m/%d/00/00/00", GetTime() + 3600 * 24));	-- ������Ч
			me.SetTask(self.TASK_GROUP, self.TASK_DATE_ID, nCurDate);
		end
		return 1;
	end
	Dialog:Say(szInfo);
end

