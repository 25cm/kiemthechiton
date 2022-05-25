if MODULE_GC_SERVER then
	return
end

local self;		-- 提供以下函数用的UpValue


function _KLuaItem.CanUse(pPlayer)
	return KItem.CanPlayerUseItem(pPlayer, self);
end

function _KLuaItem.GetEventCustomString()
	local nType = self.nCustomType;
	if nType == KItem.CUSTOM_TYPE_EVENT then
		return self.szCustomString;
	end
	return nil;
end

function _KLuaItem.IsPartnerEquip()
	local bRet = 1;
	
	bRet = self.IsEquip();		-- 必须得先是装备
	if (bRet == 1) then
		if (self.nDetail >= Item.EQUIP_PARTNERWEAPON and self.nDetail <= Item.EQUIP_PARTNERAMULET) then
			bRet = 1;
		else
			bRet = 0;
		end
	end
	
	return bRet;
end

function _KLuaItem.IsZhenYuan()
	local bRet = 1;
	
	bRet = self.IsEquip();
	if (bRet == 1) then
		if self.nDetail == Item.EQUIP_ZHENYUAN then
			bRet = 1;
		else
			bRet = 0;
		end
	end
	
	return bRet;
end

function _KLuaItem.Delete(pPlayer, nWay)
	return	KItem.DelPlayerItem(pPlayer, self, (nWay or 100));
end

function _KLuaItem.GetForbidType()
	return KItem.GetOtherForbidType(self.nGenre, self.nDetail, self.nParticular, self.nLevel);
end

function _KLuaItem.Equal(g,d,p,l)
	g = g or 0;
	
	if d and p and l then
		if self.nGenre == g and self.nDetail == d and self.nParticular == p and self.nLevel == l then
			return 1;
		else
			return 0;
		end
	end
	
	if d and p then
		if self.nGenre == g and self.nDetail == d and self.nParticular == p then
			return 1;
		else
			return 0;
		end
	end
	
	if d then
		if self.nGenre == g and self.nDetail == d then
			return 1;
		else
			return 0;
		end
	end
	
	if self.nGenre == g then
		return 1;
	else
		return 0;
	end
end

function _KLuaItem.SzGDPL()
	return string.format("%d,%d,%d,%d", self.nGenre, self.nDetail, self.nParticular, self.nLevel);
end

function _KLuaItem.TbGDPL()
	return {self.nGenre, self.nDetail, self.nParticular, self.nLevel};
end


function _KLuaItem.GetTip(nState, szBindType)
	local pIt = it;
	it = self;
	local szTitle, szTip, szView = Item:GetTip(self.szClass, nState, szBindType);
	it = pIt;
	return	szTitle, szTip, szView;
end

function _KLuaItem.GetCompareTip(nState, szBindType)
	local pIt = it;
	it = self;
	local szTitle, szTip, szView, szCmpTitle, szCmpTip, szCmpView = Item:GetCompareTip(self.szClass, nState, szBindType);
	it = pIt;
	return	szTitle, szTip, szView, szCmpTitle, szCmpTip, szCmpView;
end

function _KLuaItem.GetSex()
	local tbReq = self.GetReqAttrib();
	for i, tbTmp in ipairs(tbReq) do
		if tbTmp then
			if tbTmp.nReq == 8 then
				return tbTmp.nValue;
			end		
		end
	end
	return nil;
end

function _KLuaItem.CalcExtraFightPower(nEnhance, nRefine)
	if self.IsEquip() == 0 then
		return 0;
	end
	local nXiShu = Item.tbEnhanceOfEquipPos[self.nEquipPos] or 1;	
	local nEnhancePower, nRefinePower;
	if nEnhance then
		nEnhancePower = Item.tbEnhanceFightPower[nEnhance];
	else
		nEnhancePower = Item.tbEnhanceFightPower[self.nEnhTimes];
	end
	if nRefine then
		nRefinePower = Item.tbRefineFightPower[nRefine];
	else
		nRefinePower = Item.tbRefineFightPower[self.nRefineLevel];
	end
	return nEnhancePower * nXiShu + nRefinePower;
end

function _KLuaItem.CalcFightPower(nEnhance, nRefine)
	return self.nFightPower + self.CalcExtraFightPower();
end
