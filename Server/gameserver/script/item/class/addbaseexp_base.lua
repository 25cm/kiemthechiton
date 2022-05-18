-- 文件名　：addbaseexp_base.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-11-11 09:15:53
-- 描  述  ：增加基准经验通用
-- ExtParam1:多少分钟基准经验

local tbBase = Item:GetClass("addbaseexp_base");

function tbBase:OnUse()
	local nValue = it.GetExtParam(1);
	me.AddExp(me.GetBaseAwardExp() * nValue);
	local szLog = string.format("%s nhận được %s kinh nghiệm", me.szName, me.GetBaseAwardExp() * nValue);
	Dbg:WriteLog("UseItem",  szLog);			
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, szLog);		
	return 1;
end

function tbBase:GetTip()
	local szTip = "";
	local nValue = it.GetExtParam(1);
	szTip = szTip .. string.format("<color=green>Nhận được %s kinh nghiệm<color>",me.GetBaseAwardExp() * nValue);
	return szTip;
end
