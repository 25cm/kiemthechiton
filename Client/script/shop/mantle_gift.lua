
Require("\\script\\lib\\gift.lua");
Shop.MantleGift = Gift:New();
local tbGift = Shop.MantleGift;

function tbGift:OnOpen()
	me.CallClientScript({"Shop.MantleGift:OnUpdateParam"});
	Dialog:Gift("Shop.MantleGift");
end

function tbGift:OnSwitch(pPickItem, pDropItem, nX, nY)
	if pDropItem then
		if (self.nGetStore or 0) > 0 then
			me.Msg("Mỗi lần chỉ được dùng 1 Phi Phong đổi Hồn Thạch.");
			return 0;
		end
		local szKey = string.format("%s,%s,%s,%s,%s",pDropItem.nGenre,pDropItem.nDetail,pDropItem.nParticular,pDropItem.nLevel,pDropItem.nSeries);
		local tbMantle = self.MantleGoods[szKey];
		if tbMantle == nil 
		or type(tbMantle) ~= "table" 
		or tbMantle.nStore <= 0 
		or tbMantle.nTimeOut <= 0
		or tbMantle.nGenre ~= 1
		or tbMantle.nDetail ~= 17 then
			me.Msg("Ta không cần vật phẩm này, hãy đặt lại vật phẩm khác phù hợp.");
			return 0;
		end
		local nType, nTime = pDropItem.GetTimeOut();
		if nTime == 0 then
			me.Msg("Ta không cần vật phẩm này, hãy đặt lại vật phẩm khác phù hợp.");
			return 0;
		end
		local nLastTime = nTime;
		if nType == 0 then
			nLastTime = nTime - GetTime();
			if nLastTime <= 0 then
				me.Msg("Ta không cần vật phẩm này, hãy đặt lại vật phẩm khác phù hợp.");
				return 0;
			end
		end
		local nLastDay = math.floor(nLastTime / 86400);
		if nLastDay <= 0 then
				me.Msg("Phi Phong của bạn sắp hết hạn, không thể đổi.");
				return 0;
		end
		local nGetStore = math.floor(tbMantle.nStore * (nLastDay / (tbMantle.nTimeOut/1440)));
		self.nGetStore 	=  nGetStore;
		self._szContent = string.format("Bạn đặt vào <color=yellow>%s<color>, dựa vào hạn sử dụng và giá trị, có thể đổi <color=yellow>%s Hồn Thạch<color>.", tbMantle.szName, nGetStore);
	end
	
	if pPickItem then
		self.nGetStore 	=  0;
		self._szContent = string.format("Hãy đặt Phi Phong vào.");
	end
	return	1;
end

function tbGift:OnUpdateParam()
	self.nGetStore = 0;
	self._szContent = string.format("Hãy đặt Phi Phong vào.");
end

function tbGift:OnOK()
	local nGetStore = 0;
	local nCheckItem = 0;
	local nTimeOut = 0;
	local pFind = self:First();
	while pFind do
		if nCheckItem >= 1 then
			Dialog:Say("Mỗi lần chỉ được dùng 1 Phi Phong đổi Hồn Thạch.");
			return 0;
		end
		local szKey = string.format("%s,%s,%s,%s,%s",pFind.nGenre,pFind.nDetail,pFind.nParticular,pFind.nLevel,pFind.nSeries);
		local tbMantle = self.MantleGoods[szKey];
		if tbMantle == nil 
		or type(tbMantle) ~= "table" 
		or tbMantle.nStore <= 0 
		or tbMantle.nTimeOut <= 0
		or tbMantle.nGenre ~= 1
		or tbMantle.nDetail ~= 17 then
			me.Msg("Ta không cần vật phẩm này, hãy đặt lại vật phẩm khác phù hợp.");
			return 0;
		end
		local nType, nTime = pFind.GetTimeOut();
		if nTime == 0 then
			me.Msg("Ta không cần vật phẩm này, hãy đặt lại vật phẩm khác phù hợp.");
			return 0;
		end
		nTimeOut = nTime;
		if nType == 0 then
			nTimeOut = nTime - GetTime();
			if nTimeOut <= 0 then
				me.Msg("Ta không cần vật phẩm này, hãy đặt lại vật phẩm khác phù hợp.");
				return 0;
			end
		end
		local nLastDay = math.floor(nTimeOut / 86400);
		if nLastDay <= 0 then
				me.Msg("Phi Phong của bạn sắp hết hạn, không thể đổi.");
				return 0;
		end
		nGetStore = math.floor(tbMantle.nStore * (nLastDay / (tbMantle.nTimeOut/1440)));
		if nGetStore <= 0 then
				me.Msg("Phi Phong của bạn sắp hết hạn, không thể đổi.");
				return 0;			
		end
		nCheckItem = nCheckItem + 1;
		pFind = self:Next();
	end
	
	local nNeedBag = math.ceil(nGetStore/5000);
	if me.CountFreeBagCell() < nNeedBag then
		me.Msg(string.format("Hành trang không đủ chỗ trống, cần %s ô trống.", nNeedBag));
		return 0;
	end	
	
	local pFind = self:First();
	while pFind do
		Dbg:WriteLog("Phi Phong đổi Hồn Thạch",  me.szName..", cho phép giao diện trừ vật phẩm: ", pFind.szName);
		if me.DelItem(pFind, Player.emKLOSEITEM_MANTLE_SHOP) ~= 1 then
			return 0;
		end
		pFind = self:Next();
	end
	local tbItemInfo = {bForceBind = 1};
	local nGetNum = me.AddStackItem(18, 1, 205, 1, tbItemInfo, nGetStore);
	Dbg:WriteLog("Phi Phong đổi Hồn Thạch",  me.szName..", số Hồn Thạch đổi được:", nGetStore, "Số Hồn Thạch nhận thực tế:", nGetNum);
	me.Msg(string.format("Bạn đổi thành công <color=yellow>%s Hồn Thạch<color>, hạn sử dụng Phi Phong của bạn là <color=yellow>%s<color>", nGetNum, Lib:TimeFullDesc(nTimeOut)))
end

function tbGift:LoadMantleGoods()
	self.MantleGoods = {};
	local tbGoods = Lib:LoadTabFile("\\setting\\shop\\goods.txt");
	if not tbGoods then
		return
	end
	for _, tbGood in pairs(tbGoods) do
		local szName = tbGood.Name;
		local nGenre = tonumber(tbGood.Genre) or 0;
		local nDetail= tonumber(tbGood.DetailType) or 0;
		local nParticular = tonumber(tbGood.ParticularType) or 0;
		local nLevel = tonumber(tbGood.Level) or 0;
		local nSeries = tonumber(tbGood.Series) or 0;
		local nItemCoinIndex = tonumber(tbGood.goodsindex) or 0;
		local nStore = tonumber(tbGood.goodsprice) or 0;
		local nTimeOut = tonumber(tbGood.timeout) or 0;
		if (nStore > 0 and nItemCoinIndex == 1) then
			local szGoodKey = nGenre..","..nDetail..","..nParticular..","..nLevel..","..nSeries;
			if self.MantleGoods[szGoodKey] then
				print("error: shop\\goods.txt Xuất hiện vật phẩm lập lại", szName);
				self.MantleGoods[szGoodKey] = -1;
			end
			if not self.MantleGoods[szGoodKey] then
				self.MantleGoods[szGoodKey] = {
					szName = szName,
					nGenre=nGenre,
					nDetail=nDetail,
					nParticular=nParticular,
					nLevel=nLevel,
					nSeries=nSeries,
					nStore=nStore,
					nTimeOut = nTimeOut,
					};
			end
		end
	end
end

if (not MODULE_GC_SERVER) then

tbGift:LoadMantleGoods();

end
