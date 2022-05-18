-----------------------------------------------------------
-- �ļ�������jiguanshuxinde.lua
-- �ļ�������ʹ�ú����ӻ����;ö�
-- �����ߡ���ZhangDeheng
-- ����ʱ�䣺2008-11-17 11:28:11
-----------------------------------------------------------
local tbItem = Item:GetClass("jiguanshuxinde");

tbItem.AWARD 			= 20;	-- ����20������;ö�
tbItem.WEEK_USED_COUNT 	= 10; -- һ�ܿ���ʹ�õĸ���

function tbItem:OnUse()
	if (me.GetTask(1022, 117) ~= 1) then
		me.Msg("V?t ph?m n��y ch? c�� th? ???c s? d?ng sau khi h?c xong c? ch?��");
		return 0;
	end;
	
	local nCount = me.GetTask(1024, 57);
	if (nCount >= self.WEEK_USED_COUNT) then
		me.Msg("B?n ?? ??t ??n gi?i h?n trong tu?n n��y, b?n kh?ng th? s? d?ng n�� n?a��");
		return 0;		
	end;
	
	me.AddMachineCoin(self.AWARD);
	me.Msg(string.format("B?n nh?n ???c<color=yellow>%sdi?m<color>?? b?n c? quan", self.AWARD));
	nCount = nCount + 1;
	me.SetTask(1024, 57, nCount)
	return 1;
end

function tbItem:InitGenInfo()
	--���õ��ߵ�������
	it.SetTimeOut(0, GetTime() + 24 * 3600);
	return	{ };
end

-- ÿ����һ��
function tbItem:WeekEvent()
	me.SetTask(1024, 57, 0, 1);
end

PlayerSchemeEvent:RegisterGlobalWeekEvent({tbItem.WeekEvent, tbItem});