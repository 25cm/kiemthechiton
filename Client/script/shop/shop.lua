

if not Shop then --调试需要
	Shop = {}
	print(GetLocalDate("%Y\\%m\\%d  %H:%M:%S").." build ok ..")
end

Shop.tbDemoItems = {}; -- 打开的商店的样例道具与对应商品Id表
Shop.tbGoodsIdSet = {};
Shop.tbItemCoinUnit = {};	-- 金币替代物品的单位
Shop.tbValueCoinUnit = {};	-- 数值货币的单位
local SZ_FILE_GAMESETTING = "\\setting\\gamesetting.ini";

function Shop:CheckCanUse(nShop)
end

function Shop:GetGoods(nShopId, nItemIndex)
	if not Shop.tbGoodsIdSet[nShopId] then
		return nil;
	end
	return Shop.tbGoodsIdSet[nShopId][nItemIndex];
end

function Shop:GetDemoItem(nShopId, nGoodsId)
	if not Shop.tbDemoItems[nShopId] then
		return nil;
	end
	return Shop.tbDemoItems[nShopId][nGoodsId];
end

function Shop:CreateDemoItem(nShopId, nGoodsId)
	local tbGoods = me.GetShopBuyItemInfo(nGoodsId);
	if not tbGoods or not nShopId then
		return nil;
	end
	
	if Shop.tbDemoItems[nShopId] == nil then
		Shop.tbDemoItems[nShopId] = {};
	end
	if Shop.tbGoodsIdSet[nShopId] == nil then
		Shop.tbGoodsIdSet[nShopId] = {};
	end
	
	local pItem = KItem.CreateTempItem(tbGoods.nGenre, 
									   tbGoods.nDetail, 
									   tbGoods.nParticular, 
									   tbGoods.nLevel, 
									   tbGoods.nSeries);								   
	if not pItem then
		return nil;
	end
	Shop.tbGoodsIdSet[nShopId][pItem.nIndex] = nGoodsId;
	Shop.tbDemoItems[nShopId][nGoodsId] = pItem;
	pItem.SetTimeOut(1, tbGoods.nTimeout * 60);
	return pItem;
end

function Shop:ClearDemoItem(nShopId)
	if Shop.tbDemoItems[nShopId] ~= nil then
		for i, pItem in pairs(Shop.tbDemoItems[nShopId]) do
			if pItem then
				pItem.Remove();
			end
		end	
		Shop.tbDemoItems[nShopId] = nil;
		Shop.tbGoodsIdSet[nShopId] = nil;
		return 1;
	end
	return 0;
end


function Shop:CheckCanBuy(nGoodsId)
	local tbGoods =  me.GetShopBuyItemInfo(nGoodsId);
	if not tbGoods then
		return 0;
	end
	local tbCurrencyType = { 
							 [1] = {nMine = me.nCashMoney or 0, nGoods = tbGoods.nPrice or 0, szMsg = "Bạc không đủ" },
							 [3] = {nMine = me.GetCashCoin(me.GetItemCoinIndex(nGoodsId)) or 0, nGoods = tbGoods.nCoin or 0, szMsg = "%s không đủ"},
							 [4] = {nMine = me.GetTask(2001, 9) or 0, nGoods = tbGoods.nScore or 0, szMsg = "Điểm tích lũy không đủ"},
							 [7] = {nMine = me.GetBindMoney() or 0, nGoods = tbGoods.nPrice or 0, szMsg = "Bạc khóa không đủ"},
							 [8] = {nMine = me.GetMachineCoin() or 0, nGoods = tbGoods.nPrice or 0, szMsg = "Độ bền cơ quan không đủ"},
							 [10] = {nMine = me.GetValueCoin(me.GetValueCoinIndex(nGoodsId)) or 0, nGoods = tbGoods.nCoin or 0, szMsg = "%s không đủ"},
						   }
	if me.nCurrencyType == 9 then
		return 1;
	end 					   
	if tbCurrencyType[me.nCurrencyType].nMine >= tbCurrencyType[me.nCurrencyType].nGoods then
		return 1, "Phù hợp điều kiện mua";
	else
		return 0, tbCurrencyType[me.nCurrencyType].szMsg;
	end
end

function Shop:ReadItemCoinUnitInfo()
	local tbIniInfo = Lib:LoadIniFile(SZ_FILE_GAMESETTING);
	assert(tbIniInfo);
	self.tbItemCoinUnit = {};
	for szSessionName, tbItemCoinInfo in pairs(tbIniInfo) do
		if (szSessionName == "Coin") then
			local nCount = tonumber(tbItemCoinInfo["nCount"]);
			if (nCount <= 0) then
				break;
			end
			for i = 1, nCount do
				local szInfoKey = string.format("CoinParam%s_", i);
				local nGenre = tonumber(tbItemCoinInfo[szInfoKey .. 1]);
				local nDetail = tonumber(tbItemCoinInfo[szInfoKey .. 2]);
				local nParticular = tonumber(tbItemCoinInfo[szInfoKey .. 3]);
				local nLevel = tonumber(tbItemCoinInfo[szInfoKey .. 4]);
				local szName = KItem.GetNameById(nGenre, nDetail, nParticular, nLevel);
				self.tbItemCoinUnit[i] = szName;
			end
		end
	end
end

function Shop:GetItemCoinUnit(nItemCoinIndex)
	return self.tbItemCoinUnit[nItemCoinIndex] or "";
end

function Shop:ReadValueCoinUnitInfo()
	local tbIniInfo = Lib:LoadIniFile(SZ_FILE_GAMESETTING);
	assert(tbIniInfo);
	self.tbValueCoinUnit = {};
	for szSessionName, tbValueCoinInfo in pairs(tbIniInfo) do
		if (szSessionName == "ValueCoin") then
			local nCount = tonumber(tbValueCoinInfo["nCount"]);
			if (nCount <= 0) then
				break;
			end
			for i = 1, nCount do
				local szKeyName = string.format("ValueName%s", i);
				local szName = tostring(tbValueCoinInfo[szKeyName]);
				self.tbValueCoinUnit[i] = szName;
			end
		end
	end
end

function Shop:GetValueCoinUnit(nValueCoinIndex)
	return self.tbValueCoinUnit[nValueCoinIndex] or "";
end
