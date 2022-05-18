--优惠购买精活
--孙多良
--2008.09.22

Require("\\script\\player\\jinghuofuli.lua");

local tbBuyJingHuo = {};
SpecialEvent.BuyJingHuo = tbBuyJingHuo;
function tbBuyJingHuo:OnDialog()
	local nFlag, szMsg = Player.tbBuyJingHuo:OpenBuJingHuo(me);
	if (0 == nFlag) then
		Dialog:Say(szMsg);
	end
end

--脚本购买精气药过渡物品
local tbItem = Item:GetClass("jingqisan_coin")
function tbItem:OnUse()
	if me.CountFreeBagCell() < 5 then
		me.Msg(string.format("您的背包空间不足，需要5格背包空间。"));
		Dbg:WriteLog("Player.tbBuyJingHuo", "优惠购买精活", me.szAccount, me.szName, "背包空间不足，无法获得精气散。");		
		return 0;
	end
	local tbItemInfo = {bTimeOut=1};
	for i=1, 5 do
		local pItem = me.AddItemEx(18, 1, 89, 1, tbItemInfo)
		--不公告
		if pItem then
			pItem.Bind(1);
			local szDate = os.date("%Y/%m/%d/%H/%M/%S", GetTime() + 3600*24*30);
			me.SetItemTimeout(pItem, szDate);
			local szLog = string.format("自动使用获得了1个精气散");
			Dbg:WriteLog("Player.tbBuyJingHuo", "优惠购买精活", me.szAccount, me.szName, szLog);		
		end
	end
	me.SetTask(Player.tbBuyJingHuo.tbItem[1].TASK_GROUPID, Player.tbBuyJingHuo.tbItem[1].TASK_ID2, 5);
	KStatLog.ModifyAdd("mixstat", "[统计]购买福利精气散人数", "总量", 1);
	return 1
end

--脚本购买活气药过渡物品
local tbItem = Item:GetClass("huoqisan_coin")
function tbItem:OnUse()
	if me.CountFreeBagCell() < 5 then
		me.Msg(string.format("您的背包空间不足，需要5格背包空间。"));
		Dbg:WriteLog("Player.tbBuyJingHuo", "优惠购买精活", me.szAccount, me.szName, "背包空间不足，无法获得活气散。");		
		return 0;
	end	
	
	local tbItemInfo = {bTimeOut=1};
	--不公告
	for i=1, 5 do
		local pItem = me.AddItemEx(18, 1, 90, 1, tbItemInfo)
		if pItem then
			pItem.Bind(1);
			local szDate = os.date("%Y/%m/%d/%H/%M/%S", GetTime() + 3600*24*30);
			me.SetItemTimeout(pItem, szDate);
			local szLog = string.format("自动使用获得了1个活气散");
			Dbg:WriteLog("Player.tbBuyJingHuo", "优惠购买精活", me.szAccount, me.szName, szLog);
		end
	end
	me.SetTask(Player.tbBuyJingHuo.tbItem[2].TASK_GROUPID, Player.tbBuyJingHuo.tbItem[2].TASK_ID2, 5);	
	KStatLog.ModifyAdd("mixstat", "[统计]购买福利活气散人数", "总量", 1);
	return 1
end
