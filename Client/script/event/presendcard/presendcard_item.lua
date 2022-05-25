local tbItem = Item:GetClass("presendcard_item");

function tbItem:OnUse()
	local nPresentType =  it.GetGenInfo(1);
	if not PresendCard.PRESEND_TYPE[nPresentType] then
		return;
	end
	
	if not PresendCard.PRESEND_TYPE[nPresentType][PresendCard.INDEX_PARAM] then
		return;
	end	
	
	local tbParam = PresendCard.PRESEND_TYPE[nPresentType][PresendCard.INDEX_PARAM];	
	local nSecType = it.GetGenInfo(2);
	if nSecType ~= 0 then
		if not tbParam[nSecType] then
			print("{error}，nSecType",nSecType);
			return;
		end
		tbParam = tbParam[nSecType];
	end

	local tbParamEx = {}; -- 为了使用Event的 check 和 exe函数
	for nIdx , tbData in ipairs(tbParam) do
		tbParamEx[nIdx] = {};
		tbParamEx[nIdx][1] = tbData;
	end
	
	if #tbParamEx > 31 or #tbParamEx == 0 then
		print("{error},presendcard_item,tbParamEx",#tbParamEx);
		return;
	end
	
	local tbOpt = {};
	local nIsUsed = it.GetGenInfo(3) or 0;
	local nTmp = 0;	
	local tbParamInfo = EventManager.tbFun:GetParamEx(tbParam,1);
	
	for nIdx, tbData in ipairs(tbParamInfo) do
		local tbDataInfo = PresendCard.KEYNAME[tbData[1]];
		local szMsg  = "Khác";
		if tbDataInfo then
			if tbDataInfo[1] == 1 then
				local tbStr = Lib:SplitStr(tbData[2][1]);
				local tbInt = {};
				for i, str in ipairs(tbStr) do
					tbInt[i] = tonumber(str);
				end
				szMsg = string.format("%s:%s", tbDataInfo[2], KItem.GetNameById(unpack(tbInt)));
			else
				szMsg = string.format("%s:%s", tbDataInfo[2],tbData[2][1]);
			end
		end
		
		local bUsed = Lib:LoadBits(nIsUsed, nIdx - 1, nIdx - 1);
		if bUsed == 0 then
			table.insert(tbOpt, {szMsg,self.OnUseEx,self,it.dwId,nIdx,tbParamEx});
		else
			table.insert(tbOpt, {string.format("<color=gray>%s<color>",szMsg),self.OnUseEx,self,it.dwId,nIdx,tbParamEx});
		end			
	end
	table.insert(tbOpt,{"Ta suy nghĩ lại."});
	Dialog:Say((it.szCustomString or "").."Phần thưởng hoạt động phong phú.",tbOpt);
	return;	
end

function tbItem:OnUseEx(nItemId, nIdx, tbParamEx)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return;
	end		
	local nIsUsed = pItem.GetGenInfo(3);	
	local bUsed = Lib:LoadBits(nIsUsed, nIdx - 1, nIdx -1);
	if bUsed ~= 0 then
		Dialog:Say("Ngươi đã nhận phần thưởng này.");
		return;
	end

	if not tbParamEx[nIdx] then
		print("presendcard_item	tbParamEx error",nIdx);
		return;
	end
	local nFlag, szMsg = EventManager.tbFun:CheckParam(tbParamEx[nIdx],2);
	if nFlag and nFlag ~= 0 then
		if szMsg then
			Dialog:Say(szMsg);
		end	
		return 0;
	end
		
	nFlag, szMsg = EventManager.tbFun:ExeParam(tbParamEx[nIdx],2);
	if nFlag and nFlag ~= 0 then
		if szMsg then
			me.Msg(szMsg);
		end
		return 0;
	end

	nIsUsed = Lib:SetBits(nIsUsed, 1, nIdx - 1, nIdx - 1);	
	pItem.SetGenInfo(3,nIsUsed);
	local nState = 0;
	for nIndex in ipairs(tbParamEx) do
		if Lib:LoadBits(nIsUsed, nIndex - 1, nIndex - 1) == 0 then
			nState = 1;
			break;
		end		
	end

	if nState == 0 then
		pItem.Delete(me);
	end	
	return;
end

function tbItem:GetTip() 
	return	(it.szCustomString or "").."Lễ bao hoạt động, mở ra nhận được nhiều phần thưởng.";
end