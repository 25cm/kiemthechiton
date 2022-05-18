local tbItem = Item:GetClass("coupon");

tbItem.tbWareInfo = {
	[359] = {"Đại Bạch Câu Hoàn giảm 70%", 30, "18-1-71-2", 1},
	[360] = {"Càn Khôn Phù giảm 70%", 30, "18-1-85-1", 1},
	[361] = {"Huyền Tinh 7 giảm 70%", 30, "18-1-1-7", 1},
	[362] = {"Huyền Tinh 9 giảm 70%", 30, "18-1-1-9", 1},
	};

function tbItem:GetWareInfo()
	return self.tbWareInfo;
end

function tbItem:CalDiscount(tbWareList)
	if not tbWareList then
		return {};
	end
	
	assert(it);
	assert(me);
	
	local tbRet = {};
	local pItem = KItem.GetObjById(it.dwId);
	local nWareId = pItem.GetExtParam(1);
	
	local nTimes = pItem.GetGenInfo(1);
	if (0 == nTimes) then
		nTimes = nTimes + 1;
	end
	
	for nIndex, tbData in pairs(tbWareList) do
		local tbInfo = me.IbShop_GetWareInf(tbData.nWareId);
		
		if tbInfo.nCurrencyType == 0 then	--只有金币区才能使用优惠券(程序中0表示金币，1表示银两，2表示绑金)
			local szWareIndex = string.format("%s-%s-%s-%s", tbInfo.nGenre, tbInfo.nDetailType, 
				tbInfo.nParticular, tbInfo.nLevel);
				
			local nActualDiscountTimes, nDiscountRate = 0, 0;
			if szWareIndex == self.tbWareInfo[nWareId][3] then	
				nDiscountRate = self.tbWareInfo[nWareId][2];

				nActualDiscountTimes = nTimes > tbData.nCount and tbData.nCount or nTimes; 
				nTimes = nTimes - nActualDiscountTimes;
				local bBind = self.tbWareInfo[nWareId][4]	--是否获取绑定 1是， 0否
				table.insert(tbRet, {tbData.nWareId, nActualDiscountTimes, nDiscountRate, bBind});
			end
		end
	end	
	
	return tbRet;
end

function tbItem:CanCouponUse(dwId)
	assert(dwId);
	local pItem = KItem.GetObjById(dwId);
	if not pItem then
		return 0, "Vé ưu đãi của ngươi đã hết hạn.";
	end
	
	local nWareId = pItem.GetExtParam(1);
	local tbWareInfo = self.tbWareInfo[nWareId];
	
	if IVER_g_nSdoVersion == 0 and me.GetJbCoin() < tbWareInfo[2] then
		return 0, string.format("%s của ngươi không đủ, mua 1 %s cần %d %s", IVER_g_szCoinName, tbWareInfo[1], tbWareInfo[2], IVER_g_szCoinName);
	end
	
	if me.IsAccountLock() ~= 0 then
		return 0, "Ngươi đang ở trạng thái khóa";
	end
	
	return 1, pItem;
end

function tbItem:DecreaseCouponTimes(tbCouponWare)
	if not tbCouponWare then
		return 0;
	end

	assert(it)
	local pItem = KItem.GetObjById(it.dwId);
	if not pItem then
		return 0;
	end

	local nWareId = pItem.GetExtParam(1);
	local nTimes = pItem.GetGenInfo(1);
	local nToDelTimes = 0;					--需要扣除的次数
	if (0 == nTimes) then
		nTimes = nTimes + 1;
	end
	
	if nTimes == 0 then
		pItem.Delete(me);
		return 0;
	end
		
	for nIndex, tbData in pairs(tbCouponWare) do
		local tbInfo = me.IbShop_GetWareInf(tbData[1]);
				
		local szWareIndex = string.format("%s-%s-%s-%s", tbInfo.nGenre, tbInfo.nDetailType, 
			tbInfo.nParticular, tbInfo.nLevel);
			
		if szWareIndex == self.tbWareInfo[nWareId][3] then
			nToDelTimes = nToDelTimes + tbData[2];
		end
	end
	
	if nToDelTimes > nTimes then	--要扣除的次数大于剩余次数
		Dbg:WriteLog("coupon", "Số ưu đãi lớn hơn số vé ưu đãi còn lại!");
		return 0;
	end
	
	nTimes = nTimes - nToDelTimes; 
	
	if nTimes == 0 then
		pItem.Delete(me);
	else
		pItem.SetGenInfo(1, nTimes);
		pItem.Sync();
	end
	
	return 1;
end


local tbBaijuwan = Item:GetClass("baijuwan_temp");
function tbBaijuwan:OnUse()	
	
	Dbg:WriteLog("TempItem", me.szName, it.szName);
end

local tbQiankunfu = Item:GetClass("qiankunfu_temp");
function tbQiankunfu:OnUse()	
	
	Dbg:WriteLog("TempItem", me.szName, it.szName);
end

local tbXuanjing = Item:GetClass("xuanjing_temp");
function tbXuanjing:OnUse()
	
	Dbg:WriteLog("TempItem", me.szName, it.szName);
end

local tbTongYinding = Item:GetClass("tongfunditem_temp");
function tbTongYinding:OnUse()
	
	Dbg:WriteLog("TempItem", me.szName, it.szName);
end

local tbNewItem = Item:GetClass("newcoupon");

tbNewItem.tbWareInfo = 
{--nWareId    szDescrip    nDicountRate  对应商品的"g-d-p-l"  购买的商品是否立即绑定
	[359] = {"Đại Bạch Câu Hoàn giảm 70%", 30, "18-1-71-2", 1},
	[360] = {"Càn Khôn Phù giảm 70%", 30, "18-1-85-1", 1},
	[361] = {"Huyền Tinh 7 giảm 70%", 30, "18-1-1-7", 1},
	[362] = {"Huyền Tinh 9 giảm 70%", 30, "18-1-1-9", 1},
	[383] = {"Giảm 50% phí mua Thỏi bạc bang hội (lớn)", 50, "18-1-284-2", 1},
	[13] = {"Vé ưu đãi Vô Hạn Truyền Tống Phù (1 tháng)", 50, "18-1-235-1", 1},
	[66] = {"Vé ưu đãi giảm 30% Rương Hồn Thạch (100)", 70, "18-1-244-1", 1},
	[67] = {"Vé ưu đãi giảm 30% Rương Hồn Thạch (1000)", 70, "18-1-244-2", 1},
	[49] = {"Vé ưu đãi giảm 30% Lệnh bài chúc phúc (sơ)", 70, "18-1-212-1", 1},
	[50] = {"Vé ưu đãi giảm 30% Lệnh bài chúc phúc (trung)", 70, "18-1-212-2", 1},
	[68] = {"Vé ưu đãi giảm 30% Bản đồ bí cảnh", 70, "18-1-251-1", 1},
	[32] = {"Vé ưu đãi giảm 30% Kim Tê (cấp 4)", 70, "18-1-2-4", 1},
	[9] = {"Vé ưu đãi giảm 20% Thỏi vàng", 80, "18-1-118-1", 1},
	[4] = {"Vé ưu đãi giảm 20% Thỏi vàng", 80, "18-1-118-2", 1},
};

function tbNewItem:GetWareInfo()
	return self.tbWareInfo;
end

function tbNewItem:CalDiscount(tbWareList)
	if not tbWareList then
		return {};
	end
	
	assert(it);
	assert(me);
	
	local tbRet = {};
	local pItem = KItem.GetObjById(it.dwId);
	local nWareId = pItem.GetExtParam(1);
	local nUseCount = 1;
	if pItem.GetExtParam(3) > 1 then
		nUseCount = pItem.GetExtParam(3);
	end
	local nTimes =nUseCount - pItem.GetGenInfo(1);
	
	for nIndex, tbData in pairs(tbWareList) do
		local tbInfo = me.IbShop_GetWareInf(tbData.nWareId);
		
		if tbInfo.nCurrencyType == 0 then	--只有金币区才能使用优惠券(程序中0表示金币，1表示银两，2表示绑金)
			local szWareIndex = string.format("%s-%s-%s-%s", tbInfo.nGenre, tbInfo.nDetailType, 
				tbInfo.nParticular, tbInfo.nLevel);
				
			local nActualDiscountTimes, nDiscountRate = 0, 0;
			if szWareIndex == self.tbWareInfo[nWareId][3] then		
				nDiscountRate = self.tbWareInfo[nWareId][2];

				nActualDiscountTimes = nTimes > tbData.nCount and tbData.nCount or nTimes; 
				nTimes = nTimes - nActualDiscountTimes;
				local bBind = self.tbWareInfo[nWareId][4]; 	--是否获取绑定
				table.insert(tbRet, {tbData.nWareId, nActualDiscountTimes, nDiscountRate, bBind});

			end
		end
	end	
	
	return tbRet;
end

function tbNewItem:CanCouponUse(dwId)
	assert(dwId);
	local pItem = KItem.GetObjById(dwId);
	if not pItem then
		return 0, "Vé ưu đãi của ngươi đã hết hạn.";
	end
	
	local nWareId = pItem.GetExtParam(1);
	local tbWareInfo = self.tbWareInfo[nWareId];
	
	if IVER_g_nSdoVersion == 0 and me.GetJbCoin() < tbWareInfo[2] then
		return 0, string.format("%s của ngươi không đủ, mua 1 %s cần %d %s", IVER_g_szCoinName, tbWareInfo[1], tbWareInfo[2], IVER_g_szCoinName);
	end
	
	if me.IsAccountLock() ~= 0 then
		return 0, "Ngươi đang ở trạng thái khóa";
	end
	
	return 1;
end

function tbNewItem:DecreaseCouponTimes(tbCouponWare)
	if not tbCouponWare then
		return 0;
	end

	assert(it)
	local pItem = KItem.GetObjById(it.dwId);
	if not pItem then
		return 0;
	end

	local nWareId = pItem.GetExtParam(1);
	local nTimes = pItem.GetGenInfo(1);		--已经使用次数
	local nMaxTimes = ((pItem.GetExtParam(3) <= 0) and 1) or pItem.GetExtParam(3);	--最多可使用次数
	local nToDelTimes = 0;					--需要扣除的次数
	
	if nTimes >= nMaxTimes then
		pItem.Delete(me);
		return 0;
	end
		
	for nIndex, tbData in pairs(tbCouponWare) do
		local tbInfo = me.IbShop_GetWareInf(tbData[1]);
				
		local szWareIndex = string.format("%s-%s-%s-%s", tbInfo.nGenre, tbInfo.nDetailType, 
			tbInfo.nParticular, tbInfo.nLevel);
			
		if szWareIndex == self.tbWareInfo[nWareId][3] then
			nToDelTimes = nToDelTimes + tbData[2];
		end
	end
	
	if nToDelTimes > nMaxTimes - nTimes then	--要扣除的次数大于剩余次数
		Dbg:WriteLog("coupon", "Số ưu đãi lớn hơn số vé ưu đãi còn lại!");
		return 0;
	end
	
	nTimes = nTimes + nToDelTimes; 
	
	if nTimes >= nMaxTimes then
		pItem.Delete(me);
	else
		pItem.SetGenInfo(1, nTimes);
		pItem.Sync();
	end
	
	return 1;
end
