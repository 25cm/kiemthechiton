-- GlobalServer Player Event


if not GLOBAL_AGENT then
	return 0;
end

function PlayerEvent:Gb_PlayerLogin(bExchange)
	if bExchange == 1 then
		return 0;
	end
	me.SetTask(Player.ACROSS_TSKGROUPID, Player.ACROSS_TSKID, me.nExchangeMoney);
	me.CostBindMoney(me.GetBindMoney(), Player.emKBINDMONEY_COST_EVENT);
	me.AddBindMoney(me.nExchangeMoney, 100);
	Transfer:PlayerLogin(me.nId);
end

-- 注册跨区服登陆回调
PlayerEvent:RegisterGlobal("OnLogin", PlayerEvent.Gb_PlayerLogin, PlayerEvent);

function PlayerEvent:Gb_PlayerLogout(szReason)
	if (szReason ~= "SwitchServer") then 
		local nValue = me.GetBindMoney();
		nValue = nValue + me.GetItemPriceInBags();	
		local nOrgValue = me.GetTask(Player.ACROSS_TSKGROUPID, Player.ACROSS_TSKID);
		local nDiffValue = nValue - nOrgValue;
		me.SetTask(Player.ACROSS_TSKGROUPID, Player.ACROSS_TSKID, nValue);
		Dbg:WriteLog("GlobalConsume", me.szName, nValue);
		GCExcute{"Player:Gb_DataSync_GC", me.szName, nDiffValue};
	end
	
end
PlayerEvent:RegisterGlobal("OnLogout", PlayerEvent.Gb_PlayerLogout, PlayerEvent);
