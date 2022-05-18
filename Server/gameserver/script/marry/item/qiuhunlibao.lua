-- 文件名　：qiuhunlibao.lua
-- 创建者　：furuilei
-- 创建时间：2009-11-28 14:00:09
-- 功能描述：求婚礼包
-- modify by zhangjinpin@kingsoft 2010-01-20

local tbItem = Item:GetClass("marry_qiuhunlibao");

--==============================================================
tbItem.tbItemInfo = {
	[1] = {nCount = 2, tbGDPL = {18, 1, 571, 4}, szName = "Hãy đồng ý lấy anh nhé"},
	[1] = {nCount = 2, tbGDPL = {18, 1, 571, 2}, szName = "Tình yêu của anh"},
	[2] = {nCount = 2, tbGDPL = {18, 1, 571, 3}, szName = "Em là duy nhất"},
	[3] = {nCount = 1, tbGDPL = {18, 1, 574, 1}, szName = "Thiên thần của anh"},
	[4] = {nCount = 1, tbGDPL = {18, 1, 573, 1}, szName = "I Love You"},
	[5] = {nCount = 1, tbGDPL = {18, 1, 572, 3}, szName = "Anh em mình sẽ sống đến đầu bạc rang long"},
	[6] = {nCount = 1, tbGDPL = {18, 1, 604, 1}, szName = "Không rời xa nhau"},
	};
--==============================================================

function tbItem:GetNeedBagCell()
	local nCount = 0;
	for _, tbInfo in pairs(self.tbItemInfo) do
		nCount = nCount + tbInfo.nCount;
	end
	return nCount;
end

function tbItem:OnUse()
	if (Marry:CheckState() == 0) then
		return 0;
	end
	local nFreeBagCell = me.CountFreeBagCell();
	local nNeedBagCell = self:GetNeedBagCell();
	if (nNeedBagCell > nFreeBagCell) then
		local szErrMsg = string.format("Hành Trang không đủ chỗ trống. Chuẩn bị <color=yellow>%s<color> ô trống rồi thử lại.",
			nNeedBagCell);
		Dialog:Say(szErrMsg);
		return 0;
	end

	self:GetItem();
	
	return 1;
end

function tbItem:GetItem()
	for _, tbInfo in pairs(self.tbItemInfo) do
		for i = 1, tbInfo.nCount do
			me.AddItem(unpack(tbInfo.tbGDPL));
		end
	end
end
