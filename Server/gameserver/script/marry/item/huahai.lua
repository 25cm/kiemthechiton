-------------------------------------------------------
-- 文件名　：huahai.lua
-- 创建者　：zhangjinpin@kingsoft
-- 创建时间：2010-01-20 21:18:05
-- 文件描述：
-------------------------------------------------------

local tbItem = Item:GetClass("marry_huahai");

function tbItem:OnUse()
	
	local szMapClass = GetMapType(me.nMapId) or "";
	if szMapClass ~= "village" and szMapClass ~= "city" and szMapClass ~= "jiehun_fb" then
		me.Msg("Rừng hoa phủ kín chỉ có thể sử dụng tại tân thủ thôn hoặc thành thị.");
		return 0;
	end
	
	me.CastSkill(1549, 1, -1, me.GetNpc().nIndex);	
	return 1;
end
