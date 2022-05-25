if not Partner then
	Partner = {};
end

Require("\\script\\partner\\loadfile.lua");

function Partner:CheckGiftItem(tbGiftSelf, pPickItem, pDropItem, nX, nY)
	local nTalentPointAdded = self:CalcTalentPointAdded(tbGiftSelf);
	
	local pPartner = me.GetPartner(me.nActivePartner);
	local nCurTalent = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_TALENT);
	local nTalentLevel = nCurTalent % 1000;		-- nCurTalent = nTalentLevel*1000 + nTalentPoint
	local nTalentPoint = math.floor(nCurTalent / 1000);
	
	local szContent = "";
	
	if pDropItem then
		local szIndex = string.format("%d_%d_%d_%d", pDropItem.nGenre, pDropItem.nDetail, pDropItem.nParticular, pDropItem.nLevel);
		if not self.tbItemTalentValue[szIndex] then
			me.Msg("Vật phẩm này không thể tặng cho đồng hành.");
			return 0;
		end
		
		local szBindValue = pDropItem.nBindType == 1 and "nBindValue" or "nUnBindValue";
		nTalentPointAdded = nTalentPointAdded + self.tbItemTalentValue[szIndex][szBindValue] * pDropItem.nCount;
		
		if nTalentPointAdded > 0 then
			local nNewLevel, nBalancPoint = self:GetTalentLevelAdded(pPartner, nTalentPointAdded, 1);
			
			szContent = string.format("Lĩnh ngộ của đồng hành <color=yellow>%s<color> hiện tại là <color=yellow>%d<color>,\n", pPartner.szName, nTalentLevel);
			szContent = szContent..string.format("Quà trong giao diện sẽ giúp lĩnh ngộ của đồng hành tăng đến <color=yellow>%d<color>.", nNewLevel);
			if nNewLevel < self.TALENT_MAX then
				szContent = szContent.."<color=green>Muốn tăng thêm lĩnh ngộ, có thể đặt vào nhiều quà hơn.<color>";
			end
			
		else
			szContent = "Tặng quà cho đồng hành có thể tăng lĩnh ngộ.\nQuà tặng gồm: <color=yellow>Huyền Tinh, Hồn Thạch, Thỏi vàng, thành phẩm Tiêu Dao Cốc, thành phẩm Lãnh Thổ Chiến, thành phẩm Tần Lăng<color>.";
		end
	end
	if pPickItem then
		local szIndex = string.format("%d_%d_%d_%d", pPickItem.nGenre, pPickItem.nDetail, pPickItem.nParticular, pPickItem.nLevel);
		local szBindValue = pPickItem.nBindType == 1 and "nBindValue" or "nUnBindValue";
		nTalentPointAdded = nTalentPointAdded - self.tbItemTalentValue[szIndex][szBindValue] * pPickItem.nCount;
		if nTalentPointAdded > 0 then
			local nNewLevel, nBalancPoint = self:GetTalentLevelAdded(pPartner, nTalentPointAdded);
			
			szContent = string.format("Lĩnh ngộ của đồng hành <color=yellow>%s<color> hiện tại là <color=yellow>%d<color>,\n", pPartner.szName, nTalentLevel);
			szContent = szContent..string.format("Quà trong giao diện sẽ giúp lĩnh ngộ của đồng hành tăng đến <color=yellow>%d<color>.", nNewLevel);
			if nNewLevel < self.TALENT_MAX then
				szContent = szContent.."<color=green>Muốn tăng thêm lĩnh ngộ, có thể đặt vào nhiều quà hơn.<color>";
			end
		else
			szContent = "Tặng quà cho đồng hành có thể tăng lĩnh ngộ.\nQuà tặng gồm: <color=yellow>Huyền Tinh, Hồn Thạch, Thỏi vàng, thành phẩm Tiêu Dao Cốc, thành phẩm Lãnh Thổ Chiến, thành phẩm Tần Lăng<color>.";
		end
	end
	
	tbGiftSelf:UpdateContent(szContent);
	return 1;
end


function Partner:CalcTalentPointAdded(tbGift)
	local pItem = tbGift:First();
	local nTalentPointAdded = 0;
	while pItem do
		local szIndex = string.format("%s_%s_%s_%s", pItem.nGenre, pItem.nDetail, pItem.nParticular, pItem.nLevel);
		if self.tbItemTalentValue[szIndex] then
			local szBindValue = pItem.nBindType == 1 and "nBindValue" or "nUnBindValue";
			nTalentPointAdded = nTalentPointAdded + self.tbItemTalentValue[szIndex][szBindValue] * pItem.nCount;
		end
		
		pItem = tbGift:Next();
	end
	
	return nTalentPointAdded;
end

function Partner:GetNeedLevel(nLevel)
	if nLevel >= 120 then
		return 0;
	end
	return self.tbLevelSetting[nLevel].nExp;
end

function Partner:MoonStoneCheckFun(tbGiftSelf, pPickItem, pDropItem, nX, nY, tbParam)
	local nItemCount = self:GetMoonStoneCount(tbGiftSelf);
	
	if pDropItem then
		if not(pDropItem.nGenre == self.tbMoonStone.nGenre and
			pDropItem.nDetail == self.tbMoonStone.nDetail and
			pDropItem.nParticular == self.tbMoonStone. nParticular and
			pDropItem.nLevel == self.tbMoonStone.nLevel) then
				me.Msg("Chỉ được đặt Nguyệt Ảnh Thạch.");
				return 0;
		end		

		nItemCount = nItemCount + pDropItem.nCount;
	end
	
	if pPickItem then
		nItemCount = nItemCount - pPickItem.nCount;	
		if nItemCount <= 0 then
			tbGiftSelf:UpdateContent(tbParam.szTip);
			return 1;
		end
	end
		
	local nExchangeCount = math.floor(nItemCount / tbParam.nCount);	-- 能兑换的成品道具个数
	local nBalancCount = nItemCount - nExchangeCount * tbParam.nCount; -- 剩余的月影之石个数

	local szMsg = string.format("Đổi 1 <color=yellow>%s<color> cần <color=yellow>%d<color> Nguyệt Ảnh Thạch. Hiện bạn đặt vào <color=yellow>%d<color> Nguyệt Ảnh Thạch, sẽ nhận được <color=yellow>%d<color> <color=yellow>%s<color>",
		tbParam.szName, tbParam.nCount, nItemCount, nExchangeCount, tbParam.szName);
	if nBalancCount > 0 then
		szMsg = szMsg..string.format(", <color=green>(còn dư %d Nguyệt Ảnh Thạch, sẽ hoàn trả cho bạn)<color>.", nBalancCount);		
	else
		szMsg = szMsg..".";
	end
		
	tbGiftSelf:UpdateContent(szMsg);
	return 1;	
end

function Partner:GetMoonStoneCount(tbGiftSelf)
	local nCount = 0;
	local pItem = tbGiftSelf:First();
	while pItem do
		nCount = nCount + pItem.nCount;
		pItem = tbGiftSelf:Next();
	end
	
	return nCount;
end

function Partner:GetViewPartnerInfo_c(szName, nLevel, nStarLevel, tbPotential, tbSkill)
	CoreEventNotify(UiNotify.emCOREEVENT_VIEW_PLAYERPARTNER, szName, nLevel, nStarLevel, tbPotential, tbSkill);
end

function Partner:ChcekPartnerEquip(tbGiftSelf, pPickItem, pDropItem, nX, nY, nParam)
	local nType = nParam;	-- 类型，0为解绑，1为申绑
	
	if pDropItem then
		if nType == 0 then
			local pItem = tbGiftSelf:First();
			if (pItem) then
				me.Msg("Mỗi lần chỉ có thể mở 1 trang bị đồng hành đã khóa!");
				return 0;
			end
			
			if pDropItem.IsBind() == 0 then
				me.Msg("Chỉ có thể bỏ vào trang bị đồng hành đã khóa!");
				return 0;
			end
		elseif (nType == 1) then		-- 申绑同伴装备
			if (pDropItem.IsPartnerEquip() == 0) then 
				me.Msg("Chỉ có thể bỏ vào trang bị đồng hành!");
				return 0;
			end
		end
	end	
	
	return 1;
end
