-- 文件名　：addbindmoney_base.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-11-11 09:19:45
-- 描  述  ：增加绑定银两通用
-- ExtParam1:多少绑定银两

local tbBase = Item:GetClass("addbindmoney_base");

--数值
--类型（1.游龙密室产出）
function tbBase:OnUse()
	local nValue = it.GetExtParam(1);
	local nType = it.GetExtParam(2);
	if me.GetBindMoney() + nValue > me.GetMaxCarryMoney() then
		Dialog:Say("Lượng tiền mang trên người đã đạt mức tối đa, không thể tăng thêm.");
		return 0;
	end
	me.AddBindMoney(nValue, Player.emKBINDMONEY_ADD_YOULONG_ITEM);
	local szLog = string.format("%s nhận được %s", me.szName, nValue);
	Dbg:WriteLog("UseItem",  szLog);			
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, szLog);		
	if nType == 1 then
		KStatLog.ModifyAdd("bindjxb", "[产出]游龙密室", "总量", nValue);
	end
	return 1;
end
