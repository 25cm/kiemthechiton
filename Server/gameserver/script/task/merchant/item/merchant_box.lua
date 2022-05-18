
local tbBox = Item:GetClass("merchant_box");

tbBox.tbFollowInsertItem 	= {18, 1, 289};

function tbBox:OnUse()
	local tbOpt = {
		{"Gửi vật phẩm", self.TakeInItem, self},
		{"Rút vật phẩm", self.TakeOutItem, self},
		{"Đóng"}
	};
	local szMsg = "Được gửi hoặc rút thẻ thương hội.\n\n" .. self:GetTip() .. "\n<color=red>Chú ý: Có thể nhận lệnh bài tương ứng dựa vào số lệnh bài trong hộp và nhiệm vụ thương hội chưa đến giới hạn<color>";
	Dialog:Say(szMsg, tbOpt);
end;
-- 放入
function tbBox:TakeInItem()
	Dialog:OpenGift("Đặt vật phẩm gửi vào", {"Merchant:CheckGiftSwith"}, {self.OnOpenGiftOk, self});
end;

-- 取出
function tbBox:TakeOutItem(nNowPage)
	local tbOpt = {};
	if not nNowPage then
		nNowPage = 0;
	end
	local nPage = 5;
	local nCount = nNowPage * nPage;
	local nSum = 0;
	for nLevel, tbItem in ipairs(Merchant.TASK_ITEM_FIX) do
		local nCurCount = me.GetTask(Merchant.TASK_GOURP, tbItem.nTask);
		if (nCurCount > 0) then
			nSum = nSum + 1;
			if nSum > nCount then
				nCount = nCount + 1;
				if nCount > (nPage * (nNowPage + 1)) then
					table.insert(tbOpt, {"Sau", self.TakeOutItem, self, nNowPage + 1});
					break;
				end
				table.insert(tbOpt, {tbItem.szName .. "(Còn lại" .. nCurCount .. ")", self.SelectItem, self, nLevel});
			end
		end
	end
	
	if nCount > (nPage + 1) then
		table.insert(tbOpt, {"Trước", self.TakeOutItem, self, nNowPage - 1});
	end
	
	tbOpt[#tbOpt + 1] = {"Đóng"};
	local szMsg = "Xin chọn vật phẩm muốn rút";
	Dialog:Say(szMsg, tbOpt);
end;

function tbBox:SelectItem(nLevel)
	local nCurCount = me.GetTask(Merchant.TASK_GOURP, Merchant.TASK_ITEM_FIX[nLevel].nTask);
	Dialog:AskNumber("Nhập số lượng lấy: ", nCurCount, self.OnUseTakeOut, self, nLevel);
end;

function tbBox:OnUseTakeOut(nLevel, nCount)
	local nCurCount = me.GetTask(Merchant.TASK_GOURP, Merchant.TASK_ITEM_FIX[nLevel].nTask);
	if (nCount <= 0 or nCount > nCurCount) then
		me.Msg("Số lượng nhập không đúng!");
		return 0;
	end;
	if me.CountFreeBagCell() < nCount then
		Dialog:Say("Túi bạn không đủ chỗ.");
		return 0;
	end	
	local nCurCount = me.GetTask(Merchant.TASK_GOURP, Merchant.TASK_ITEM_FIX[nLevel].nTask);
	nCurCount = nCurCount - nCount;
	me.SetTask(Merchant.TASK_GOURP, Merchant.TASK_ITEM_FIX[nLevel].nTask, nCurCount);
	for i = 1, nCount do
		me.AddItem(self.tbFollowInsertItem[1], self.tbFollowInsertItem[2], self.tbFollowInsertItem[3], nLevel);
	end;
end;

function tbBox:OnOpenGiftOk(tbItemObj)
	local bForbidItem 	= false;
	self.tbItemList		= {}; -- 歸類後的物品列表
	for _, pItem in pairs(tbItemObj) do
		if (self:ChechItem(pItem, self.tbItemList) == 0) then
			bForbidItem = true;
		end;
	end
	if (bForbidItem) then
		me.Msg("Vật phẩm không thích hợp hoặc số lượng vượt giới hạn!")
		return 0;	
	end;
	
	for _, pItem in pairs(tbItemObj) do
		if me.DelItem(pItem[1]) ~= 1 then
			return 0;
		end
	end
	
	for nLevel, tbItem in pairs(Merchant.TASK_ITEM_FIX) do
		if (self.tbItemList[nLevel]) then
			local nCurCount = me.GetTask(Merchant.TASK_GOURP, tbItem.nTask);
			nCurCount = nCurCount + self.tbItemList[nLevel];
			me.SetTask(Merchant.TASK_GOURP, tbItem.nTask, nCurCount);
			me.Msg(string.format("Thu thập được %s <color=green>%s<color>", self.tbItemList[nLevel], tbItem.szName))
		end;
	end;
	
	return 1;
end;

-- 檢測物品及數量是否符合
function tbBox:ChechItem(pItem)
	local szFollowItem 	= string.format("%s,%s,%s", unpack(self.tbFollowInsertItem));
	local szItem		= string.format("%s,%s,%s",pItem[1].nGenre, pItem[1].nDetail, pItem[1].nParticular);
	if szFollowItem ~= szItem then
		return 0;
	end;
	if (not self.tbItemList[pItem[1].nLevel]) then
		self.tbItemList[pItem[1].nLevel] = 1;
	else
		self.tbItemList[pItem[1].nLevel] = self.tbItemList[pItem[1].nLevel] + 1;
	end;
	
	local nCurCount = me.GetTask(Merchant.TASK_GOURP, Merchant.TASK_ITEM_FIX[pItem[1].nLevel].nTask);
	local nMaxCount = Merchant.TASK_ITEM_FIX[pItem[1].nLevel].nMax;
	
	if (nCurCount + self.tbItemList[pItem[1].nLevel] > nMaxCount) then
		return 0;
	end;		
	return 1;	
end;

function tbBox:GetTip(nState)
	local szTip = "";
	local szRow = "<color=%s>    %-20s %2d / %-2d<color>\r\n";
	
	for _, data in ipairs(Merchant.TASK_ITEM_FIX) do
		local nItemNum = me.GetTask(Merchant.TASK_GOURP, data.nTask);
		local szColor = "white";
		if nItemNum <= 0 then szColor = "gray" end
		if nItemNum >= data.nMax then szColor = "green" end;
		szTip = szTip .. string.format(szRow, szColor, data.szName, nItemNum, data.nMax);
	end
	
	return szTip;
end
