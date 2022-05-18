
-- 兑换魂石 脚本


--- 交换的Gift界面

Item.ChangeGift = Gift:New();

local tbGift = Item.ChangeGift;

Item.CHANGE_RATE			= 1000;
Item.SPIRITSTONE			= {18,1,205,1,0,0}
Item.SPIRITSTONE_STACK_NUM	= 1000;

function tbGift:OnSwitch(pPickItem, pDropItem, nX, nY)
	if pDropItem then
		if Item:CalcChange({pDropItem}) <= 0 then
			me.Msg("Vật phẩm này không đổi được!");
			return 0;
		end
	end	
	return	1;
end

function tbGift:OnUpdate()
	self._szTitle = "Đổi Hồn Thạch";
	local pItem = self:First();
	local tbItem = {}
	if not pItem then
		self._szContent = "Mời đặt vào vật phẩm muốn đổi."
		return 0;
	end
	while pItem do
		table.insert(tbItem, pItem);
		pItem = self:Next();
	end
	local nChangeNum = Item:CalcChange(tbItem);
	self._szContent = "Đổi được <color=yellow>"..nChangeNum.."<color> Ngũ Hành Hồn Thạch, cần "..math.ceil(nChangeNum / Item.SPIRITSTONE_STACK_NUM).." chỗ trống để cất giữ.";
end

function tbGift:OnOK(tbParam)
	local pItem = self:First();
	local tbItem = {}
	if not pItem then
		me.Msg("Mời đặt vào vật phẩm muốn đổi.")
		return 0;
	end
	while pItem do
		table.insert(tbItem, pItem);
		pItem = self:Next();
	end
	local nChangeNum = Item:CalcChange(tbItem);
	local nFreeCount = math.ceil(nChangeNum / Item.SPIRITSTONE_STACK_NUM);
	if me.CountFreeBagCell() < nFreeCount then
		me.Msg(string.format("Hành trang không đủ chỗ trống, cần %s ô trống.", nFreeCount));
		return 0;
	end
	Item:Change(tbItem)
end


--- 交换预算
function Item:CalcChange(tbItem)
	local nTotleCost = 0;
	for _, pItem in pairs(tbItem) do
		local tbClass = self.tbClass[pItem.szClass];
		if (not tbClass) then
			tbClass = self.tbClass["default"];
		end
		if tbClass:GetChangeable(pItem) == 1 and pItem.IsBind() ~= 1 then
			nTotleCost = nTotleCost + pItem.nMakeCost;
		end
	end
	return math.floor(nTotleCost / self.CHANGE_RATE);
end

--- 交换逻辑
function Item:Change(tbItem)
	local nBudget = self:CalcChange(tbItem);
	if nBudget <= 0 then
		return 0;
	end
	if me.CalcFreeItemCountInBags(unpack(self.SPIRITSTONE)) < nBudget then
		me.Msg("Túi bạn đã đầy");
		return 0;
	end
	local nTotleCost = 0;
	local szLog = "Nguyên liệu: "
	for _, pItem in pairs(tbItem) do
		local szItemName = pItem.szName;
		local tbClass = self.tbClass[pItem.szClass];
		if (not tbClass) then
			tbClass = self.tbClass["default"];
		end
		if tbClass:GetChangeable(pItem) == 1 and pItem.IsBind() ~= 1 then
			local nCurCost = pItem.nMakeCost;
			if nCurCost > 0 then
				local nRet = me.DelItem(pItem, Player.emKLOSEITEM_CHANGE_HUN);		-- 扣除魂石
				if nRet == 1 then
					nTotleCost = nTotleCost + nCurCost;
					szLog = szLog.." "..szItemName
				else
					Dbg:WriteLog("Change", "Tên nhân vật:"..me.szName, "Tài khoản:"..me.szAccount, "Trừ đạo cụ thất bại: ", szItemName);
				end
			end
		else
			Dbg:WriteLog("Change", "Tên nhân vật:"..me.szName, "Tài khoản:"..me.szAccount, "Thử đặt vào trang bị không thể đổi!", szItemName);
		end
	end
	local nItemNum = math.floor(nTotleCost / self.CHANGE_RATE);
	local nGivenNum = me.AddStackItem(self.SPIRITSTONE[1],self.SPIRITSTONE[2],self.SPIRITSTONE[3],self.SPIRITSTONE[4], nil, nItemNum);
	-- KStatLog.ModifyAdd("mixstat", "五行魂石\t产出", "总量", nGivenNum);
	Dbg:WriteLog("Change", "Tên nhân vật:"..me.szName, "Tài khoản:"..me.szAccount, " đổi được "..nItemNum.." Hồn Thạch, đã cho "..nGivenNum..", ", szLog);
	return 1
end



