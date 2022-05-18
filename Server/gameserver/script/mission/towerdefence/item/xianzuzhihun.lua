-- �ļ�������toweritem.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2010-03-10 16:42:59
-- ��  ��  ��

local tbTower = Item:GetClass("xianzuzhihun");

function tbTower:OnUse()
	local nCurDay = tonumber(GetLocalDate("%Y%m%d"));
	local nTaskDay = me.GetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_NEWYEAR_LIANHUA_DAY);
	if nTaskDay < nCurDay then
		me.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_NEWYEAR_LIANHUA_DAY, nCurDay);
		me.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_NEWYEAR_LIANHUA_COUNT, 0);
	end 
	
	local nTaskCount = me.GetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_NEWYEAR_LIANHUA_COUNT);
	if nTaskCount >= 3 then
		me.Msg("ÿ��ֻ��ʹ��<color=yellow>3������֮��<color>��ȡ3�ζ�����ᣬ����컻ȡ�Ļ���<color=yellow>�Ѵ�3��<color>��")
		return 0;
	end
	local nTaskAllCount = me.GetTask(TowerDefence.TSK_GROUP,TowerDefence.TSK_NEWYEAR_LIGUAN_COUNT_ALL)
	if nTaskAllCount >= 10 then
		me.Msg("��ڼ�ֻ��ʹ��<color=yellow>10������֮��<color>��ȡ10�ζ�����ᣬ�㻻ȡ�Ļ���<color=yellow>�Ѵ�10��<color>��")
		return 0;
	end
	me.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_NEWYEAR_LIANHUA_COUNT, nTaskCount + 1);
	me.SetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_ATTEND_EXCOUNT, me.GetTask(TowerDefence.TSK_GROUP, TowerDefence.TSK_ATTEND_EXCOUNT) + 1);
	me.SetTask(TowerDefence.TSK_GROUP,TowerDefence.TSK_NEWYEAR_LIGUAN_COUNT_ALL, me.GetTask(TowerDefence.TSK_GROUP,TowerDefence.TSK_NEWYEAR_LIGUAN_COUNT_ALL) + 1);
	me.Msg("�������<color=yellow>1��<color>��������ʸ�");
	return 1;
end

function tbTower:GetTip()
	local nTimes = me.GetTask(2118,13);
	local szColor = "green"
	if nTimes == 10 then
		szColor = "gray"
	end
	local szMsg = "��ڼ����Ѿ�ʹ�ù��Ĵ�����<color="..szColor..">"..nTimes.."/10<color>";
	return szMsg;
end
