-- 文件名　：xinhunlibao.lua
-- 创建者　：furuilei
-- 创建时间：2009-12-07 15:09:33
-- 功能描述：新婚礼包
-- modify by zhangjinpin@kingsoft 2010-01-20


local tbItem = Item:GetClass("marry_xinhunlibao");

--==========================================================

tbItem.SUBITEM_MASK_XINLANG_HUALI	= 1; -- 新郎华丽面具
tbItem.SUBITEM_MASK_XINLANG_PUTONG 	= 2; -- 新郎普通面具
tbItem.SUBITEM_MASK_XINNIANG_HUALI	= 3; -- 新娘华丽面具
tbItem.SUBITEM_MASK_XINNIANG_PUTONG	= 4; -- 新娘普通面具
tbItem.SUBITEM_MASK_BANLANG			= 5; -- 伴郎面具
tbItem.SUBITEM_MASK_BANNIANG		= 6; -- 伴娘面具
tbItem.SUBITEM_YAOQINGHAN			= 7; -- 邀请函
tbItem.SUBITEM_ZHUKELING			= 8; -- 逐客令
tbItem.SUBITEM_LIHUABAO				= 9; -- 婚礼礼花包

tbItem.LEVEL_PINGMIN	= 1; -- 平民
tbItem.LEVEL_GUIZU		= 2; -- 贵族
tbItem.LEVEL_WANGHOU	= 3; -- 王侯
tbItem.LEVEL_HUANGJIA	= 4; -- 皇家

tbItem.tbLibaoInfo = {
	[tbItem.LEVEL_PINGMIN]	= {szName = "Dân sự", nTimeOut = 1 * 3600 * 24, tbCount = {0, 1, 0, 1, 1, 1, 10, 2, 1}},
	[tbItem.LEVEL_GUIZU]	= {szName = "Tầng lớp quý tộc", nTimeOut = 1 * 3600 * 24, tbCount = {0, 1, 0, 1, 1, 1, 20, 2, 2}},
	[tbItem.LEVEL_WANGHOU]	= {szName = "Vua", nTimeOut = 1 * 3600 * 24, tbCount = {1, 0, 1, 0, 2, 2, 30, 4, 4}},
	[tbItem.LEVEL_HUANGJIA]	= {szName = "Hoàng gia", nTimeOut = 7 * 3600 * 24, tbCount = {1, 0, 1, 0, 2, 2, 40, 4, 8}},
	};
	
tbItem.tbSubItemInfo = {
	[tbItem.SUBITEM_MASK_XINLANG_HUALI]		= {szName = "Lam Nhan (Thẻ mặt nạ đẹp)",	tbGUID = {18, 1, 598, 1}}, -- 新郎华丽面具
	[tbItem.SUBITEM_MASK_XINLANG_PUTONG] 	= {szName = "Lam Nhan (Thẻ mặt nạ thường)",	tbGUID = {18, 1, 598, 3}}, -- 新郎普通面具
	[tbItem.SUBITEM_MASK_XINNIANG_HUALI]	= {szName = "Hồng Nhan (Thẻ mặt nạ đẹp)",	tbGUID = {18, 1, 598, 2}}, -- 新娘华丽面具
	[tbItem.SUBITEM_MASK_XINNIANG_PUTONG]	= {szName = "Hồng Nhan (Thẻ mặt nạ thường)",	tbGUID = {18, 1, 598, 4}}, -- 新娘普通面具
	[tbItem.SUBITEM_MASK_BANLANG]			= {szName = "Thẻ kết nghĩa huynh đệ",			tbGUID = {18, 1, 598, 5}}, -- 伴郎面具
	[tbItem.SUBITEM_MASK_BANNIANG]			= {szName = "Thẻ mật hữu	Thẻ Dâu Phụ",			tbGUID = {18, 1, 598, 6}}, -- 伴娘面具
	[tbItem.SUBITEM_YAOQINGHAN]				= {szName = "Thiệp Mời",				tbGUID = {18, 1, 591, 1}}, -- 侍女
	[tbItem.SUBITEM_ZHUKELING]				= {szName = "Trục Khách Lệnh",				tbGUID = {18, 1, 592, 1}}, -- 花童
	[tbItem.SUBITEM_LIHUABAO]				= {szName = "Túi pháo hoa",				tbGUID = {18, 1, 613, 1}}, -- 手捧花
	};
	
--==========================================================

-- 检查礼包是否是一个新的没有使用过的礼包
function tbItem:IsNewItem(pItem)
	if (not pItem) then
		return 0;
	end
	
	local nLibaoLevel = pItem.nLevel;
	local tbLibaoInfo = self.tbLibaoInfo[nLibaoLevel];
	if (not tbLibaoInfo or not tbLibaoInfo.tbCount) then
		return 0;
	end
	local tbSubItemCount = tbLibaoInfo.tbCount;
	local bIsNewItem = 1;
	for nSubItemIndex, nMaxCount in ipairs(tbSubItemCount) do
		local nUsedCount = pItem.GetGenInfo(nSubItemIndex);
		if (nUsedCount ~= 0) then
			bIsNewItem = 0;
			break;
		end
	end
	
	return bIsNewItem;
end

--==========================================================

function tbItem:GetCount(nSubItem)
	local tbItemInfo = self:GetItemInfo();
	local tbCount = self.tbLibaoInfo[tbItemInfo.nLevel].tbCount;
	local nMaxCount = tbCount[nSubItem];
	if (0 == nMaxCount) then
		return -1;		-- 返回-1表示该道具中不会包含此子物品
	end
	
	local pItem = KItem.GetObjById(tbItemInfo.nItemId);
	if (not pItem) then
		return 0;
	end
	local nCurCount = pItem.GetGenInfo(nSubItem);
	if (nCurCount > nMaxCount) then
		nCurCount = nMaxCount;
	end
	return nMaxCount - nCurCount;
end

function tbItem:GetColor(nSubItem, nCount)
	local tbItemInfo = self:GetItemInfo();
	local tbCount = self.tbLibaoInfo[tbItemInfo.nLevel].tbCount;
	local nMaxCount = tbCount[nSubItem];
	if (0 == nMaxCount) then
		return "gray";
	end
	if (nCount == nMaxCount) then
		return "green";
	elseif (nCount > 0 and nCount < nMaxCount) then
		return "white";
	else
		return "gray";
	end
end

function tbItem:CanUse(pItem)
	local szErrMsg = "";
	if (not pItem) then
		return 0;
	end
	
	if (1 ~= pItem.IsBind()) then
		szErrMsg = " Món Lễ đã bị khóa, không thể sử dụng được";
		return 0, szErrMsg;
	end

	if (0 == Marry:CheckWeddingMap(me.nMapId)) then
		szErrMsg = "Bạn không có địa điêm tổ chức buổi lễ, vì thế không tiến hành được.";
		return 0, szErrMsg;
	end
	
	local tbCoupleName = Marry:GetWeddingOwnerName(me.nMapId) or {};
	local bIsMyWedding = 0;
	for _, szName in pairs(tbCoupleName) do
		if (me.szName == szName) then
			bIsMyWedding = 1;
			break;
		end
	end
	if (0 == bIsMyWedding) then
		szErrMsg = "Đây không phải là địa điểm tổ chức buổi lễ của bạn, nên không sử dụng được";
		return 0, szErrMsg;
	end
	
	return 1;
end

function tbItem:SetItemInfo(pItem)
	if (not pItem) then
		return 0;
	end
	
	local tbItemInfo = {};
	tbItemInfo.nItemId = pItem.dwId;
	tbItemInfo.nLevel = pItem.nLevel;
	Marry:SetLibaoInfo(me.nMapId, tbItemInfo);
end

function tbItem:GetItemInfo()
	return Marry:GetLibaoInfo(me.nMapId) or {};
end

function tbItem:OnUse()
	if (Marry:CheckState() == 0) then
		return 0;
	end
	local bCanUse, szErrMsg = self:CanUse(it);
	if (0 == bCanUse) then
		if ("" ~= szErrMsg) then
			Dialog:Say(szErrMsg);
			return 0;
		end
		return 0;
	end
	
	self:SetItemInfo(it);

	local szMsg = "Lễ vật";
	local tbOpt = {};
	for i = 1, 9 do
		local nCount = self:GetCount(i);
		if (-1 ~= nCount) then
			local szColor = self:GetColor(i, nCount);
			local szOpt = string.format("<color=%s>%s tặng %s<color>",
				szColor, self.tbSubItemInfo[i].szName, nCount);
			table.insert(tbOpt, {szOpt, self.SelectItem, self, i});
		end
	end
	table.insert(tbOpt, "Kết thúc đối thoại");
	Dialog:Say(szMsg, tbOpt);
end

function tbItem:SelectItem(nSubItem)
	local nCount = self:GetCount(nSubItem);
	if (0 == nCount or -1 == nCount) then
		Dialog:Say("Vượt quá mức bạn nhận được");
		return 0;
	end
	
	if (1 == nCount) then
		self:OnUseTakeOut(nSubItem, nCount);
	else
		Dialog:AskNumber("Xin vui lòng nhập lại số", nCount, self.OnUseTakeOut, self, nSubItem);
	end	
end

function tbItem:OnUseTakeOut(nSubItem, nCount)
	if (nCount <= 0) then
		Dialog:Say("Số lượng nhập không đúng.");
		return 0;
	end
	if me.CountFreeBagCell() < nCount then
		Dialog:Say(string.format("Hành trang không đủ chỗ trống, vui lòng thử lại sau.", nCount));
		return 0;
	end
	self:GetItem(nSubItem, nCount);
end

function tbItem:GetItem(nSubItem, nCount)
	local tbItemInfo = self:GetItemInfo();
	local pItem = KItem.GetObjById(tbItemInfo.nItemId);
	if (not pItem) then
		return 0;
	end
	local nCurCount = pItem.GetGenInfo(nSubItem);
	pItem.SetGenInfo(nSubItem, nCurCount + nCount);
	
	for i = 1, nCount do
		local cItem = me.AddItem(unpack(self.tbSubItemInfo[nSubItem].tbGUID));
		if (cItem) then
			local nWeddingCloseTime = self:GetWeddingCloseTime();
			cItem.SetTimeOut(0, nWeddingCloseTime);
			
			local tbCoupleName = Marry:GetWeddingOwnerName(me.nMapId);
			cItem.SetCustom(Item.CUSTOM_TYPE_MAKER, tbCoupleName[1]);
			cItem.Sync();
		end
	end
end

function tbItem:GetWeddingCloseTime()
	local nCurTime = GetTime();
	local nCurHour = tonumber(os.date("%H", nCurTime));
	local nCurDate = tonumber(os.date("%Y%m%d", nCurTime));
	local nCrossDayTime = Lib:GetDate2Time(nCurDate);
	local nWeddingCloseTime = 0;
	if (nCurHour <= 7) then
		nWeddingCloseTime = nCrossDayTime + 7 * 3600;
	else
		nWeddingCloseTime = nCrossDayTime + (24 + 7) * 3600;
	end
	return nWeddingCloseTime;
end

--=========================================================

local tbUselessLibao = Item:GetClass("marry_uselessxinhunlibao");
-- 如果是因为性别原因女性玩家无法使用结婚礼包的话，可以把礼包兑换成一定数量的情花
tbUselessLibao.TBCOUNT_QINGHUA_EXCHANGE = {99, 499, 1999, 9999};


function tbUselessLibao:OnUse()
	if (me.nSex == Env.SEX_FEMALE) then
		self:FemaleUse(it);
		return 0;
	end

	Dialog:Say("Món này không thể sử dụng được. Vui lòng đi chỗ khác hỏi xem");
	return 0;
end

-- 如果是女性玩家使用的话，会给出兑换情花的提示信息
function tbUselessLibao:FemaleUse(pItem)
	local nCount_Exchange = self.TBCOUNT_QINGHUA_EXCHANGE[pItem.nLevel];
	if (nCount_Exchange) then
		local szMsg = string.format("Bạn không thể sử dụng vì không cùng giới tính<color=yellow>%s<color>Những bông hoa đẹp, bạn có muốn trao đổi nó không?",
			nCount_Exchange);
		local tbOpt = {
			{"Có,tôi sẽ trao đổi", self.Change2Qinghua, self, pItem, nCount_Exchange},
			{"Tôi vẫn suy nghĩ về nó"},
			};
		Dialog:Say(szMsg, tbOpt);
	end
	return 1;
end

function tbUselessLibao:Change2Qinghua(pItem, nChangeCount)
	if (me.CountFreeBagCell() < 1) then
		Dialog:Say("Hành trang không đủ chỗ trống, vui lòng thử lại sau.");
		return 0;
	end
	
	me.AddStackItem(Marry.ITEM_QINGHUA_ID[1], Marry.ITEM_QINGHUA_ID[2], Marry.ITEM_QINGHUA_ID[3],
		Marry.ITEM_QINGHUA_ID[4], {bForceBind = 1}, nChangeCount);
	
	pItem.Delete(me);
end
