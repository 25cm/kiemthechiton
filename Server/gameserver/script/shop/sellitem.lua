-- 文件名　：sellitem.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-04-22 16:11:11
-- 描  述  ：把不绑定的物品卖成绑定银两


Shop.SellItem = Shop.SellItem or {};
local tbSell = Shop.SellItem;
tbSell.nGroupId 	= 2050;
tbSell.nTaskId		= 51;
tbSell.nTaskIdWeek 	= 52;
tbSell.nMaxSell 	= 300000;	--最多兑换30万；

function tbSell:OnOpenSell()
	local nBindMoney = self:GetRestMoney();
	local nMoney = (self.nMaxSell - nBindMoney);
	if nMoney <= 0 then
		Dialog:Say("Mỗi tuần được đổi tối đa <color=yellow>300000 Bạc khóa<color>, tuần này bạn đã đổi <color=yellow>300000 Bạc khóa<color>.");
		return 0;
	end
	Dialog:OpenGift(string.format("Đặt vào vật phẩm đổi Bạc khóa\n\nTuần này bạn còn được đổi <color=yellow>%s Bạc khóa\n\nMở cẩm nang trợ giúp xem danh sách vật phẩm dùng đổi Bạc khóa<color>", nMoney), {"Shop.SellItem:CheckGiftSwith"}, {self.OnOpenGiftOk, self});
end

function tbSell:GetRestMoney()
	
	local nWeek = me.GetTask(self.nGroupId, self.nTaskIdWeek);
	local nCurWeek = tonumber(GetLocalDate("%y%W"));
	if nCurWeek > nWeek then
		me.SetTask(self.nGroupId, self.nTaskIdWeek, nCurWeek);
		me.SetTask(self.nGroupId, self.nTaskId, 0);
	end
	local nMoney = me.GetTask(self.nGroupId, self.nTaskId);
	return nMoney;
end


function tbSell:OnOpenGiftOk(tbItemObj)
	local nAddBindMoney = 0;
	for _, tbItem in pairs(tbItemObj) do
		local pItem = tbItem[1];
		local szKey = string.format("%s,%s,%s,%s",pItem.nGenre,pItem.nDetail,pItem.nParticular,pItem.nLevel);
		local nBind = pItem.IsBind();
		if self.SellList[szKey] and self.SellList[szKey][nBind] then
			nAddBindMoney = nAddBindMoney + self.SellList[szKey][nBind] * pItem.nCount;
		end
	end
	
	local nBindMoney = self:GetRestMoney();
	local nMoney = (self.nMaxSell - nBindMoney);
	
	if nAddBindMoney > nMoney then
		Dialog:Say(string.format("Mỗi tuần được đổi tối đa <color=yellow>300000 Bạc khóa<color>, tuần này bạn đã đổi <color=yellow>%s Bạc khóa<color>, mức đổi bạn nhập vào đã vượt quá 300000, không thể tiến hành đổi.", nBindMoney));
		return 0;
	end
	
	if me.GetBindMoney() + nAddBindMoney > me.GetMaxCarryMoney() then
		Dialog:Say(string.format("Bạc khóa trên người bạn sắp vượt mức, sắp xếp rồi thử lại sau."));
		return 0
	end
	
	nAddBindMoney = 0;
	for _, tbItem in pairs(tbItemObj) do
		local pItem = tbItem[1];
		local szKey = string.format("%s,%s,%s,%s",pItem.nGenre,pItem.nDetail,pItem.nParticular,pItem.nLevel);
		local nBind = pItem.IsBind();
		if self.SellList[szKey] and self.SellList[szKey][nBind] then
			local nCount = pItem.nCount;
			if me.DelItem(pItem) ~= 1 then
				Dbg:WriteLog("XoyoGame", me.szName.."Nguyên liệu đổi Bạc khóa", "Xóa thất bại", szKey);
			else
				nAddBindMoney = nAddBindMoney + self.SellList[szKey][nBind] * nCount;
			end
		end
	end
	me.SetTask(self.nGroupId, self.nTaskId, me.GetTask(self.nGroupId, self.nTaskId) + nAddBindMoney);
	me.AddBindMoney(nAddBindMoney, Player.emKBINDMONEY_ADD_SHANGHUI);
	Dbg:WriteLog("XoyoGame", me.szName.."Nguyên liệu đổi Bạc khóa thành công", nAddBindMoney);
	KStatLog.ModifyAdd("bindjxb", "[Nơi] Thương nhân Thương Hội đổi", "Tổng", nAddBindMoney);
end

function tbSell:CheckGiftSwith(tbGiftSelf, pPickItem, pDropItem, nX, nY)
	tbGiftSelf.nOnSwithItemCount = tbGiftSelf.nOnSwithItemCount or 0;
	local nMoney = me.GetTask(self.nGroupId, self.nTaskId);
	local nRestMoney = self.nMaxSell - nMoney;
	if pDropItem then
		local szPutParam = string.format("%s,%s,%s,%s",pDropItem.nGenre,pDropItem.nDetail,pDropItem.nParticular,pDropItem.nLevel);
		local nBind = pDropItem.IsBind();
		if not self.SellList[szPutParam] or not self.SellList[szPutParam][nBind] then
			me.Msg("Vật phẩm này không thể đổi Bạc khóa, mở cẩm nang trợ giúp xem danh sách vật phẩm dùng đổi Bạc khóa.");
			return 0;
		end
		if tbGiftSelf.nOnSwithItemCount + self.SellList[szPutParam][nBind] * pDropItem.nCount > nRestMoney then
			me.Msg(string.format("Mỗi tuần được đổi tối đa <color=yellow>300000<color>, tuần này bạn đã đổi <color=yellow>%s<color>, mức đổi bạn nhập vào vượt quá 300000.", nMoney));
			return 0;
		end
		tbGiftSelf.nOnSwithItemCount = tbGiftSelf.nOnSwithItemCount + self.SellList[szPutParam][nBind] * pDropItem.nCount;
	end
	if pPickItem then
		local szPutParam = string.format("%s,%s,%s,%s",pPickItem.nGenre,pPickItem.nDetail,pPickItem.nParticular,pPickItem.nLevel);
		local nBind = pPickItem.IsBind();
		tbGiftSelf.nOnSwithItemCount = tbGiftSelf.nOnSwithItemCount - self.SellList[szPutParam][nBind] * pPickItem.nCount;
	end
	tbGiftSelf:UpdateContent(string.format("Vật phẩm bạn đặt vào có thể đổi thành <color=yellow>%s Bạc khóa<color>", tbGiftSelf.nOnSwithItemCount));
	return 1;	
end

function tbSell:LoadSellList()
	self.SellList = {};
	local tbFile = Lib:LoadTabFile("\\setting\\shop\\sellitem.txt");
	if not tbFile then
		return 0;
	end
	for i, tbItem in ipairs(tbFile) do
		local szName 			= 	tbItem.Name;
		local nGenre 			= 	tonumber(tbItem.Genre) or 0;
		local nDetailType 		= 	tonumber(tbItem.DetailType) or 0;
		local nParticularType 	= 	tonumber(tbItem.ParticularType) or 0;
		local nLevel 			= 	tonumber(tbItem.Level) or 0;
		local nBind 			= 	tonumber(tbItem.Bind) or -1;
		local nSellBindMoney 	= 	tonumber(tbItem.SellBindMoney) or 0;
		local szKey = string.format("%s,%s,%s,%s", nGenre, nDetailType, nParticularType, nLevel);
		self.SellList[szKey] = self.SellList[szKey] or {};
		if self.SellList[szKey][nBind] then
			print("[\\setting\\xoyogame\\sellitem.txt] Vật phẩm bị trùng"..szKey..","..nBind);
		end
		if nBind == -1 then
			self.SellList[szKey][0] = nSellBindMoney;
			self.SellList[szKey][1] = nSellBindMoney;
		else
			self.SellList[szKey][nBind] = nSellBindMoney;
		end
	end
end

tbSell:LoadSellList();