-- �ļ�������lingpaibaoxiang.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2010-04-29 17:26:12
-- ��  ��  ��

SpecialEvent.LaborDay = SpecialEvent.LaborDay or {};
local LaborDay = SpecialEvent.LaborDay or {};

local tbItem = Item:GetClass("lingpaibaoxiang");
function tbItem:OnUse()	
	local nTime = tonumber(GetLocalDate("%H%M"));
	if nTime >= 1900 and nTime <= 2100 then
		local tbPlayerList = KPlayer:GetAllPlayer();
		for _,pPlayer in pairs(tbPlayerList) do
			pPlayer.AddExp(1000000);
		end
		KDialog.NewsMsg(0, Env.NEWSMSG_NORMAL,string.format( "ף�ء�%s���Ѿ������Ʊ��䲢��ý�����ȫ�����������ͬʱ���1������ֵ��", me.szName));
	end
	return Item:GetClass("randomitem"):SureOnUse(LaborDay.nLingpaibaoxiang);
end
