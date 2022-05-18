
-- Player GC脚本

-- 帮会商店GC回调
function Player:Buy_GC(nCurrencyType, nCost, nEnergyCost, dwTongId, nSelfKinId, nSelfMemberId, nPlayerId, nBuy, nBuyIndex, nCount)
	local cTong = KTong.GetTong(dwTongId);
	if not cTong then
		return 0;
	end
	
	if nCurrencyType == 9 then
		local nEnergy = cTong.GetEnergy();
		local nEnergyLeft = nEnergy - nEnergyCost * nCount;
		if nEnergyLeft < 0 then 
			return 0;
		end
		if Tong:CostBuildFund_GC(dwTongId, nSelfKinId, nSelfMemberId, nCost * nCount, 0) ~= 1 then
			return 0;
		end
		cTong.SetEnergy(nEnergyLeft);
		GlobalExcute{"Player:Buy_GS2", nCurrencyType, dwTongId, nPlayerId, nBuy, nBuyIndex, nCost, nEnergyLeft, nCount};
	end
end

-- 跨区服数据同步_全局GC
function Player:Gb_DataSync_GC(szName, nValue)
	local nPlayerId = KGCPlayer.GetPlayerIdByName(szName);
	if nPlayerId and nValue and GLOBAL_AGENT then
		-- 如果是全局GC，则广播给各个普通GC
		local nConnetId = KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_CONNET_ID);
		if nConnetId > 0 then
			GlobalGCExcute(nConnetId, {"Player:Nor_DataSync_GC", szName, nValue});
		end
	end
end

-- 跨区服数据同步_普通GC
function Player:Nor_DataSync_GC(szName, nValue)
	local nPlayerId = KGCPlayer.GetPlayerIdByName(szName);
	if nPlayerId and nValue then
		local nCurrentMoney = KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_CURRENCY_MONEY);
		nCurrentMoney = nCurrentMoney + nValue;
		KGCPlayer.OptSetTask(nPlayerId, KGCPlayer.TSK_CURRENCY_MONEY, nCurrentMoney);
		Dbg:WriteLog("Nor_DataSync_GC", szName, nValue, KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_CURRENCY_MONEY));
		GlobalExcute{"Player:DataSync_GS2", szName, nCurrentMoney};
	end
end
