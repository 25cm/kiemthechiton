--thêm tip hiển thị tài phú 
function Item:Tip_Prefix(nState, nEnhStarLevel, szBindType)
	local szPreTip = "";
	if it.IsEquip() == 1 then
		szPreTip = szPreTip..self:Tip_StarLevel(nState, nEnhStarLevel);
		szPreTip = szPreTip..self:Tip_Value(nState);--hiển thị tài phú món đồ
		szPreTip = szPreTip..self:Tip_BindInfo(nState, szBindType);	
		szPreTip = szPreTip..self:Tip_Changeable(nState)..self:Tip_CanBreakUp(nState);  
		szPreTip = szPreTip..self:Tip_GetRefineLevel();
		szPreTip = szPreTip..self:Tip_FixSeries(nState);
	else
		szPreTip = szPreTip..self:Tip_Value(nState);
		szPreTip = szPreTip..self:Tip_BindInfo(nState, szBindType);
		szPreTip = szPreTip..self:Tip_Changeable(nState); 
	end
	return szPreTip;
end
--hàm hiển thị tài phú đồ
function Item:Tip_Value(nState)
	local szTip = "\n";
	local nValue = it.nValue;
	local nOrigin = self:Tip_Origin(nState);
	if it.nEnhTimes == 0 then
		local strValue = string.format("<color=0,255,255>Tài phú:<color=0,255,0> %.4f<color>", nValue/10000);
		szTip = szTip..strValue.."<color=white>\n";
	else
		local strValue = string.format("<color=0,255,255>Tài phú:<color=0,255,0> %.4f(%.4f)<color>", nValue/10000,nOrigin/10000);
		szTip = szTip..strValue.."<color=white>\n";
	end
	return szTip;
end

function Item:Tip_Origin(nState)
	local pTempItem = KItem.CreateTempItem(
				it.nGenre,	
				it.nDetail,		
				it.nParticular,	
				it.nLevel,		
				it.nSeries,		
				0,			
				it.nLucky,		
				it.GetGenInfo(),	
				0,			
				it.dwRandSeed,	
				it.nIndex	
			);
	local nValue = pTempItem.nValue;
	pTempItem.Remove();
	return nValue;
end


