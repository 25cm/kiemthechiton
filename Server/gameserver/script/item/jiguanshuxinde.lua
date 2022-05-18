-----------------------------------------------------------
-- 文件名　：jiguanshuxinde.lua
-- 文件描述：使用后增加机关耐久度
-- 创建者　：ZhangDeheng
-- 创建时间：2008-11-17 11:28:11
-----------------------------------------------------------
local tbItem = Item:GetClass("jiguanshuxinde");

tbItem.AWARD 			= 20;	-- 增加20点机关耐久度
tbItem.WEEK_USED_COUNT 	= 10; -- 一周可以使用的个数

function tbItem:OnUse()
	if (me.GetTask(1022, 117) ~= 1) then
		me.Msg("V?t ph?m này ch? có th? ???c s? d?ng sau khi h?c xong c? ch?！");
		return 0;
	end;
	
	local nCount = me.GetTask(1024, 57);
	if (nCount >= self.WEEK_USED_COUNT) then
		me.Msg("B?n ?? ??t ??n gi?i h?n trong tu?n này, b?n kh?ng th? s? d?ng nó n?a！");
		return 0;		
	end;
	
	me.AddMachineCoin(self.AWARD);
	me.Msg(string.format("B?n nh?n ???c<color=yellow>%sdi?m<color>?? b?n c? quan", self.AWARD));
	nCount = nCount + 1;
	me.SetTask(1024, 57, nCount)
	return 1;
end

function tbItem:InitGenInfo()
	--设置道具的生存期
	it.SetTimeOut(0, GetTime() + 24 * 3600);
	return	{ };
end

-- 每周清一次
function tbItem:WeekEvent()
	me.SetTask(1024, 57, 0, 1);
end

PlayerSchemeEvent:RegisterGlobalWeekEvent({tbItem.WeekEvent, tbItem});