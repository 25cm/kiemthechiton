
Item.HTGift = Gift:New();

local tbGift = Item.HTGift;

function tbGift:OnSwitch(pPickItem, pDropItem, nX, nY)
	local nCountHT = self:CountItemSwith();
	if pDropItem then
		if (pDropItem.szClass ~= "xuanjing") then
			me.Msg("Hãy đưa ta Huyền Tinh.");
			return 0;
		else
			nCountHT = nCountHT + 1;
		end
	end
	if pPickItem then
		nCountHT = nCountHT - pPickItem.nCount;
		if nCountHT <= 0 then
			nCountHT = 0;
		end
	end
	self.nCountHT = nCountHT;
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
	local nRate = self.nCountHT * self._tbParam.nLevel;
	local szMsg = "<enter>Xác suất thành công <color=yellow>" .. nRate .. "<color>%";
	self._szContent = self._tbParam.szTip .. szMsg;
end

function tbGift:OnUpdateParam(szContent, tbParam)
	self._szTitle = tbParam.szTitle;
	self._szContent = szContent;
	self.nCountHT = 0;
	self._tbParam = {};
	self._tbParam.szTip = tbParam.szTip;
	self._tbParam.szName = tbParam.szName;
	self._tbParam.nLevel = tbParam.nLevel;
end

function tbGift:OnOpen(szContent, tbParam)
	me.CallClientScript({"Item.HTGift:OnUpdateParam", szContent, tbParam});
	Dialog:Gift("Item.HTGift", tbParam);
end
