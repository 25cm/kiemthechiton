
if (MODULE_GAMECLIENT) then
Trade.nCoinMinLimit = 100;
function Trade:Request(pNpc, bCancel)
	self:SetTradeClientNpc(me, pNpc);
	CoreEventNotify(UiNotify.emCOREEVENT_TRADE_REQUEST, bCancel);
end

function Trade:Response(pNpc)
	self:SetTradeClientNpc(me, pNpc);
	CoreEventNotify(UiNotify.emCOREEVENT_TRADE_RESPONSE);
end

function Trade:Trading(pNpc, nFaction)
	self:SetTradeClientNpc(me, pNpc);
	CoreEventNotify(UiNotify.emCOREEVENT_TRADE_TRADING, nFaction);
end

function Trade:GetTradeClientNpc(pPlayer)
	if (not pPlayer) then
		return;
	end
	local tbTrade = pPlayer.GetPlayerTempTable().tbTrade;
	if (not tbTrade) then
		return;
	end
	return tbTrade.pNpc;
end

function Trade:SetTradeClientNpc(pPlayer, pNpc)
	if (not pPlayer) then
		return;
	end
	local tbTemp = pPlayer.GetPlayerTempTable();
	if not tbTemp.tbTrade then
		tbTemp.tbTrade = {};
	end
	local tbTrade = tbTemp.tbTrade;
	tbTrade.pNpc = pNpc;
end

--禁用金币交易功能
function Trade:DisableCoinTrade(bDisable)
	self.bCoinTradeDisable = bDisable;
	local nShow;
	if bDisable == 1 then
		nShow = 0;
	else
		nShow = 1;
	end
	Wnd_SetVisible("UI_TRADE", "TxtPlayerOtherCoinNum", nShow);
	Wnd_SetVisible("UI_TRADE", "EditSelfCoin", nShow);
end

function Trade:SetCoinTradeMinLimit(nLimit)
	Trade.nCoinMinLimit = nLimit;
end

--ClientEvent:RegisterClientStartFunc(Trade.DisableCoinTrade, Trade, 1);

end	-- if (MODULE_GAMECLIENT) then
