
Item.KNBGift = Gift:New();

local tbGift = Item.KNBGift;

function tbGift:OnSwitch(pPickItem, pDropItem, nX, nY)
	local nCountKNB = self:CountItemSwith();
	if pDropItem then
		local szParam = string.format("%s,%s,%s,%s", pDropItem.nGenre, pDropItem.nDetail, pDropItem.nParticular, pDropItem.nLevel);
		if not self._tbParam[szParam] then
			me.Msg("Hãy đưa ta Kim Nguyên Bảo.");
			return 0;
		else
			nCountKNB = nCountKNB + 1;
		end
	end
	if pPickItem then
		nCountKNB = nCountKNB - pPickItem.nCount;
		if nCountKNB <= 0 then
			nCountKNB = 0;
		end
	end
	self.nCountKNB = nCountKNB;
	return 1;
end

function tbGift:CountItemSwith()
	local nCount = 0;
	local pItem = self:First();
	while pItem do
		nCount = nCount + pItem.nCount;
		pItem = self:Next();
	end
	return nCount;
end

function tbGift:OnUpdate()
	local nCoin = self._tbParam.nGiaBan * self.nCountKNB;
	local szMsg = string.format("<color=yellow>%d<color> %s\nĐổi được <color=yellow>%s đồng<color>", self.nCountKNB , self._tbParam.szName, Item:FormatMoney(nCoin));
	self._szContent = self._tbParam.szTip .. szMsg;
end

function tbGift:OnUpdateParam(szContent, tbParam)
	self._szTitle = "Kim Nguyên Bảo";
	self._szContent = szContent;
	self.nCountKNB = 0;
	self._tbParam = {};
	for ni, tbItem in ipairs(tbParam.tbMareial) do
		if tbItem.nGenre ~= 0 and tbItem.nDetail ~= 0 and tbItem.nParticular ~= 0 then
			local szParam = string.format("%s,%s,%s,%s",tbItem.nGenre, tbItem.nDetail, tbItem.nParticular, tbItem.nLevel);
			self._tbParam[szParam] = 1;
		end
	end
	self._tbParam.szTip = tbParam.szTip;
	self._tbParam.nGiaBan = tbParam.nGiaBan;
	self._tbParam.szName = tbParam.szName;
end

function tbGift:OnOpen(szContent, tbParam)
	me.CallClientScript({"Item.KNBGift:OnUpdateParam", szContent, tbParam});
	Dialog:Gift("Item.KNBGift", tbParam);
end
