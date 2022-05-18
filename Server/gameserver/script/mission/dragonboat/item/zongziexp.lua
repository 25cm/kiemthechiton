-- �ļ�������zongziexp.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-05-18 11:56:05
-- ��  ��  ��

local tbItem = Item:GetClass("dragonboat_zongziexp")

function tbItem:OnUse()
	if me.GetTask(2064, 21) >= 100 then
		Dialog:Say("�����ֻ��ʳ��<color=yellow>100������<color>���Ѳ����ٳ��ˡ�");
		return 0;
	end
	local nBase = me.GetBaseAwardExp();
	me.AddExp(nBase*60);
	me.SetTask(2064, 21, me.GetTask(2064, 21)+1);
	return 1;
end

function tbItem:GetTip()
	local szTip = "";
	local tbParam = self.tbBook;
	local nUse =  me.GetTask(2064, 21);
	szTip = szTip .. string.format("<color=green>��ʳ��%s/100��<color>", nUse);
	return szTip;
end

