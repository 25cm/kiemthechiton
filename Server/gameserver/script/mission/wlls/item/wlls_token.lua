--������������
--�����
--2008.10.14

local tbItem = Item:GetClass("wlls_token");
tbItem.tbAward = 
{
	[1] = 200,
	[2] = 400,
	[3] = 600,
	[4] = 1000,
}

function tbItem:OnUse()	
	local nFlag = Player:AddRepute(me, 7, 1, self.tbAward[it.nLevel]);

	if (0 == nFlag) then
		return;
	elseif (1 == nFlag) then
		me.Msg("���Ѿ��ﵽ��������������ߵȼ������޷�ʹ������������������");
		return;
	end	

	me.Msg(string.format("�����<color=yellow>%s��<color>��������.",self.tbAward[it.nLevel]))
	return 1;
end


