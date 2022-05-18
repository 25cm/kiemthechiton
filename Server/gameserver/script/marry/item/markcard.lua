-- 文件名　：markcard.lua
-- 创建者　：furuilei
-- 创建时间：2009-12-18 10:26:53
-- 功能描述：面具卡片
-- modify by zhangjinpin@kingsoft 2010-01-20

local tbItem = Item:GetClass("marry_markcard");

--===================================================================

tbItem.TIME_FOREVER = -1;	-- 道具没有有效时间，永久有效
tbItem.SEX_MALE	= 0;		-- 性别需求，男性
tbItem.SEX_FEMALE = 1;		-- 性别需求，女性
tbItem.SEX_BOTH = -1;		-- 没有性别需求

tbItem.tbCardInfo = {
	[1] = {szName = "Thẻ kết nghĩa huynh đệ", tbCardGDPL = {18, 1, 598, 5}, tbMarkGDPL = {1, 13, 39, 1}, nNeedLevel = 1, nPurviewLevel = 2, nNeedSex = tbItem.SEX_MALE},
	[2] = {szName = "Thẻ mật hữu	Thẻ Dâu Phụ", tbCardGDPL = {18, 1, 598, 6}, tbMarkGDPL = {1, 13, 40, 1}, nNeedLevel = 1, nPurviewLevel = 2, nNeedSex = tbItem.SEX_FEMALE},
	[3] = {szName = "Lam Nhan (Thẻ mặt nạ đẹp)", tbCardGDPL = {18, 1, 598, 1}, tbMarkGDPL = {1, 13, 35, 1}, nNeedLevel = 4, nPurviewLevel = 4, nNeedSex = tbItem.SEX_MALE},
	[4] = {szName = "Hồng Nhan (Thẻ mặt nạ đẹp)", tbCardGDPL = {18, 1, 598, 2}, tbMarkGDPL = {1, 13, 36, 1}, nNeedLevel = 4, nPurviewLevel = 4, nNeedSex = tbItem.SEX_FEMALE},
	[5] = {szName = "Lam Nhan (Thẻ mặt nạ thường)", tbCardGDPL = {18, 1, 598, 3}, tbMarkGDPL = {1, 13, 37, 1}, nNeedLevel = 4, nPurviewLevel = 4, nNeedSex = tbItem.SEX_MALE},
	[6] = {szName = "Hồng Nhan (Thẻ mặt nạ thường)", tbCardGDPL = {18, 1, 598, 4}, tbMarkGDPL = {1, 13, 38, 1}, nNeedLevel = 4, nPurviewLevel = 4, nNeedSex = tbItem.SEX_FEMALE},
	};

--===================================================================

function tbItem:CanUse(pItem, tbCardInfo)
	if (Marry:CheckState() == 0) then
		return 0;
	end
	local szErrMsg = "";
	if (not tbCardInfo) then
		return 0, szErrMsg;
	end
	
	local bIsWeddingMap = self:CheckWeddingMap();
	if (0 == bIsWeddingMap) then
		szErrMsg = "Địa điểm không phải là chỗ tổ chức lễ, không thể sử dụng đạo cụ";
		return 0, szErrMsg;
	end
	
	local nNeedSex = tbCardInfo.nNeedSex;
	if (nNeedSex ~= self.SEX_BOTH) then
		if (me.nSex ~= nNeedSex) then
			szErrMsg = "Vì lý do giới tính, bạn không thể sử dụng vật phẩm này";
			return 0, szErrMsg;
		end
	end
	
	local nPurviewLevel = tbCardInfo.nPurviewLevel;
	if (nPurviewLevel < self:GetPurviewLevel()) then
		szErrMsg = "Tùy thuộc vào quyền của bạn, bạn không thể sử dụng vật phẩm này.";
		return 0, szErrMsg;
	end
	
	if (0 == Marry:CheckWeddingMap(me.nMapId)) then
		szErrMsg = "Bạn không có tại địa điểm tổ chức buổi lễ, bạn không thể sử dụng mục.";
		return 0, szErrMsg;
	end
	
	local tbCoupleName = Marry:GetWeddingOwnerName(me.nMapId) or {};
	local bIsCurMapItem = 0;	-- 是否是当前地图可以使用的物品
	for _, szName in pairs(tbCoupleName) do
		if (szName == pItem.szCustomString) then
			bIsCurMapItem = 1;
			break;
		end
	end
	if (0 == bIsCurMapItem) then
		szErrMsg = "2 lễ không phù hợp bạn không thể sử dụng.";
		return 0, szErrMsg;
	end
	
	local nMyCurPurviewLevel = Marry:GetWeddingPlayerLevel(me.nMapId, me.szName);
	if (nMyCurPurviewLevel < tbCardInfo.nNeedLevel) then
		szErrMsg = "Bạn không thể sử dụng đạo cụ này";
		return 0, szErrMsg;
	end
	
	local nFreeBag = me.CountFreeBagCell();
	if (nFreeBag < 1) then
		szErrMsg = "Hàng trang của bạn đã đầy, hãy cất gọn để thử nó";
		return 0, szErrMsg;
	end
	
	return 1;
end

function tbItem:CheckWeddingMap()
	return Marry:CheckWeddingMap(me.nMapId);
end

function tbItem:GetWeddingLevel()
	return Marry:GetWeddingLevel(me.nMapId);
end

function tbItem:GetPurviewLevel()
	return Marry:GetWeddingPlayerLevel(me.nMapId, me.szName);
end

function tbItem:SetPurviewLevel(nPurviewLevel)
	return Marry:SetWeddingPlayerLevel(me.nMapId, me.szName, nPurviewLevel);
end

function tbItem:GetItemInfo(pItem)
	if (not pItem) then
		return;
	end
	
	local szCardGDPL = string.format("%s-%s-%s-%s", pItem.nGenre, pItem.nDetail, pItem.nParticular, pItem.nLevel);
	for _, tbInfo in pairs(self.tbCardInfo) do
		local szGDPL = string.format("%s-%s-%s-%s", unpack(tbInfo.tbCardGDPL));
		if (szCardGDPL == szGDPL) then
			return tbInfo;
		end
	end
end

function tbItem:OnUse()
	local tbCardInfo = self:GetItemInfo(it);
	local bCanUse, szErrMsg = self:CanUse(it, tbCardInfo);
	if (0 == bCanUse) then
		if ("" ~= szErrMsg) then
			Dialog:Say(szErrMsg);
		end
		return 0;
	end
	
	local pMarkItem = me.AddItem(unpack(tbCardInfo.tbMarkGDPL));
	if (pMarkItem) then
		local nWeddingLevel = self:GetWeddingLevel();
		local nPurviewLevel = tbCardInfo.nPurviewLevel;
		pMarkItem.Bind(1);
		self:SetPurviewLevel(nPurviewLevel);
		pMarkItem.Sync();
	end
	return 1;
end
