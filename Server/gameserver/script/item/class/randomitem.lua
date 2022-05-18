
local tbRandomItem = Item:GetClass("randomitem");
local SZITEMFILE = "\\setting\\item\\001\\other\\randomitem.txt";
function tbRandomItem:OnUse()	
	if self.tbItemList == nil then
		self.tbItemList = self:GetItemList();
	end
	local nkind = tonumber(it.GetExtParam(1));
	local nTaskGroupId = tonumber(it.GetExtParam(3));
	local nTaskpId = tonumber(it.GetExtParam(4));
	local nTaskValue = tonumber(it.GetExtParam(5));
	local nTaskData = tonumber(it.GetExtParam(6));
	local nTaskTimes = tonumber(it.GetExtParam(7));
	local nTaskTimes_Max = tonumber(it.GetExtParam(8));
	local nTaskTimes_All = tonumber(it.GetExtParam(9));
	local nTaskTimes_All_Max = tonumber(it.GetExtParam(10));

	return self:SureOnUse(nkind, nTaskGroupId, nTaskpId, nTaskValue, nTaskData, nTaskTimes, nTaskTimes_Max, nTaskTimes_All, nTaskTimes_All_Max)
end

function tbRandomItem:SureOnUse(nkind, nTaskGroupId, nTaskpId, nTaskValue, nTaskData, nTaskTimes, nTaskTimes_Max, nTaskTimes_All, nTaskTimes_All_Max)
	if self:CheckTask(nTaskGroupId, nTaskData, nTaskTimes, nTaskTimes_Max, nTaskTimes_All, nTaskTimes_All_Max) == 0 then		
		return 0;
	end	
	local nBagCellNeeded = 0; -- 所需背包空间
	local tbTask = {nTaskGroupId, nTaskpId, nTaskValue, nTaskTimes, nTaskTimes_All};
	local nMaxProbability = self.tbItemList[nkind].nMaxProp;
	local nRate = Random(nMaxProbability) + 1;
	local nRateSum = 0;
	local nMustGet = 0; -- 100%概率的item个数
	local nNeedMax = 0;
	for nitem=1, #self.tbItemList[nkind] do
		local tbItem = self.tbItemList[nkind][nitem];
		if tbItem and tbItem.nProbability == 0 then
			local nFreeCount = 1;
			if tbItem.nGenre ~= 0 and tbItem.nDetailType ~= 0 and tbItem.nParticularType ~= 0 then
				local tbItemInfo = {};
				if tbItem.szTimeLimit and tbItem.szTimeLimit ~= "" then
					tbItemInfo.bTimeOut = 1;
					if tonumber(tbItem.szTimeLimit) and  tonumber(tbItem.szTimeLimit) <= 0 then
						tbItemInfo.bTimeOut = nil;
					end
				end
				if tbItem.nBind > 0 then
					tbItemInfo.bForceBind = tbItem.nBind;
				end
				nFreeCount = KItem.GetNeedFreeBag(tbItem.nGenre, tbItem.nDetailType, tbItem.nParticularType, tbItem.nLevel, tbItemInfo, (tbItem.nAmount or 1))
				nBagCellNeeded = nBagCellNeeded + nFreeCount;
			end
			nMustGet = nMustGet + nFreeCount;
		end
		if tbItem and tbItem.nProbability > 0 then
			if tbItem.nGenre ~= 0 and tbItem.nDetailType ~= 0 and tbItem.nParticularType ~= 0 then
				local tbItemInfo = {};
				if tbItem.szTimeLimit and tbItem.szTimeLimit ~= "" then
					tbItemInfo.bTimeOut = 1;
				end
				if tbItem.nBind > 0 then
					tbItemInfo.bForceBind = tbItem.nBind;
				end
				local nFreeCount = KItem.GetNeedFreeBag(tbItem.nGenre, tbItem.nDetailType, tbItem.nParticularType, tbItem.nLevel, tbItemInfo, (tbItem.nAmount or 1));
				if nNeedMax < nFreeCount then
					nNeedMax = nFreeCount;
				end
			end
		end		
	end
	
	if self:CheckItemFree(me, nBagCellNeeded + nNeedMax) == 0 then
		return 0;
	end
	
	if nMustGet > 0 then
		for nitem=1, #self.tbItemList[nkind] do
			local tbItem = self.tbItemList[nkind][nitem];
			if tbItem and tbItem.nProbability == 0 then
				if self:GetItem(me, tbItem, tbTask, nMustGet) == 0 then
					Dbg:WriteLog("Ngẫu nhiên nhận vật phẩm thất bại",  me.szName, string.format("Loại: %s, thứ tự vật phẩm: %s", nkind, nitem));
					return 1;
				end
			end
		end
	end
	
	for nitem=1, #self.tbItemList[nkind] do
		nRateSum = nRateSum + self.tbItemList[nkind][nitem].nProbability;
		if nRate <= nRateSum and self.tbItemList[nkind][nitem].nProbability ~= -1 then
			if self:GetItem(me, self.tbItemList[nkind][nitem], tbTask, nMustGet) == 0 then
				Dbg:WriteLog("Ngẫu nhiên nhận vật phẩm thất bại",  me.szName, string.format("Loại: %s, thứ tự vật phẩm: %s", nkind, nitem));
				return 1;
			else
				return 1;
			end
		end
	end
	return 1; -- 如果该随机物品表只有概率为0的必得物品.
end

function tbRandomItem:GetItem(pPlayer, tbitem, tbTask, nMustGet)
	if tbitem.nBindMoney ~= 0 then
		pPlayer.AddBindMoney(tbitem.nBindMoney, Player.emKBINDMONEY_ADD_RANDOMITEM);
		local szAnnouce = string.format("Chúc mừng bạn nhận được <color=white>%s<color> bạc khóa", tbitem.nBindMoney);
		pPlayer.Msg(szAnnouce);
		KStatLog.ModifyAdd("bindjxb", "[Nơi]"..(tbitem.szDesc or "Chưa biết rương gì"), "Tổng", tbitem.nBindMoney);
	end
	if tbitem.nMoney ~= 0 then
		local nAddMoney = pPlayer.Earn(tbitem.nMoney, Player.emKEARN_RANDOM_ITEM);
		local szAnnouce = string.format("Bạn nhận được <color=white>%s<color> lượng bạc", tbitem.nMoney);
		pPlayer.Msg(szAnnouce);
		if nAddMoney == 1 then
			Dbg:WriteLog("Ngẫu nhiên nhận vật phẩm",  pPlayer.szName,  string.format("Ngẫu nhiên nhận %s bạc", tbitem.nMoney));
			KStatLog.ModifyAdd("jxb", "[Nơi]"..(tbitem.szDesc or "Chưa biết rương gì"), "Tổng", tbitem.nMoney);
		else
			Dbg:WriteLog("Ngẫu nhiên nhận vật phẩm",  pPlayer.szName,  string.format("Bạc có hạn, ngẫu nhiên nhận %s bạc thất bại", tbitem.nMoney));
		end
	end
	if tbitem.nCoin ~= 0 then
		local nAddCoin = pPlayer.AddBindCoin(tbitem.nCoin, Player.emKBINDCOIN_ADD_RANDOM_ITEM); -- 只会加绑金
		local szAnnouce = string.format("Chúc mừng bạn nhận được <color=white>%s<color> %s khóa", tbitem.nCoin, IVER_g_szCoinName);
		pPlayer.Msg(szAnnouce);
		if nAddCoin == 1 then
			KStatLog.ModifyAdd("bindcoin", "[Nơi]"..(tbitem.szDesc or "Chưa biết rương gì"), "Tổng", tbitem.nCoin);
			Dbg:WriteLog("Ngẫu nhiên nhận vật phẩm",  pPlayer.szName,  string.format("Ngẫu nhiên nhận được %s %s khóa", tbitem.nCoin, IVER_g_szCoinName));
		else
			Dbg:WriteLog("Ngẫu nhiên nhận vật phẩm",  pPlayer.szName,  string.format("%s khóa đạt mức tối đa, ngẫu nhiên nhận %s %s khóa thất bại", IVER_g_szCoinName, tbitem.nCoin, IVER_g_szCoinName));
		end
	end
	if tbitem.nGenre ~= 0 and tbitem.nDetailType ~= 0 and tbitem.nParticularType ~= 0 then
		local nCount = tonumber(tbitem.nAmount) or 1;
		
		local tbItemInfo = {};
		tbItemInfo.nSeries = tbitem.nSeries;
		tbItemInfo.nEnhTimes = tbitem.nEnhTimes;
		
		if tbitem.szTimeLimit and tbitem.szTimeLimit ~= "" then
			tbItemInfo.bTimeOut = 1;
		end
		
		if tbitem.nBind > 0 then
			tbItemInfo.bForceBind = tbitem.nBind;
		end
		
		if tbItemInfo.bTimeOut ~= 1 then
			local nAddCount = pPlayer.AddStackItem(tbitem.nGenre, tbitem.nDetailType, tbitem.nParticularType, tbitem.nLevel, tbItemInfo, nCount);
			if nAddCount > 0 then
				local szAnnouce = string.format("Chúc mừng bạn đã nhận được <color=white>%s<color>", tbitem.szName);
				pPlayer.Msg(szAnnouce);
				Dbg:WriteLog("Ngẫu nhiên nhận vật phẩm",  pPlayer.szName, string.format("Nhận vật phẩm ngẫu nhiên %s", tbitem.szName));
			else
				local szMsg = string.format("Ngẫu nhiên nhận vật phẩm thất bại, ID vật phẩm: %s,%s,%s", tbitem.nGenre, tbitem.nDetailType, tbitem.nParticularType);
				Dbg:WriteLog("Ngẫu nhiên nhận vật phẩm",  pPlayer.szName, szMsg);
				return 0;
			end
		else
			for i= 1, nCount do
				local pItem = pPlayer.AddItemEx(tbitem.nGenre, tbitem.nDetailType, tbitem.nParticularType, tbitem.nLevel, tbItemInfo, Player.emKITEMLOG_TYPE_JOINEVENT);
				if pItem then
					if tbitem.szTimeLimit ~= "" then
						self:LimitTime(pPlayer, tbitem.szTimeLimit, pItem);
					end
					local szAnnouce = string.format("Chúc mừng bạn đã nhận được <color=white>%s<color>", pItem.szName);
					pPlayer.Msg(szAnnouce);
					Dbg:WriteLog("Ngẫu nhiên nhận vật phẩm",  pPlayer.szName, string.format("Nhận vật phẩm ngẫu nhiên %s", pItem.szName));
				else
					local szMsg = string.format("Ngẫu nhiên nhận vật phẩm thất bại, ID vật phẩm: %s,%s,%s", tbitem.nGenre, tbitem.nDetailType, tbitem.nParticularType);
					Dbg:WriteLog("Ngẫu nhiên nhận vật phẩm",  pPlayer.szName, szMsg);
					return 0;
				end
			end
		end
	end
	
	if tbitem.nExp ~= 0 then
		pPlayer.AddExp(tbitem.nExp)
		local szAnnouce = string.format("Chúc mừng bạn nhận được <color=white>%s<color> kinh nghiệm",tbitem.nExp);
		pPlayer.Msg(szAnnouce);
		Dbg:WriteLog("Ngẫu nhiên nhận vật phẩm",  pPlayer.szName, string.format("Ngẫu nhiên nhận được %s kinh nghiệm", tbitem.nExp));
	end
	
	if tbitem.nBaseExp ~= 0 then
		pPlayer.AddExp(me.GetBaseAwardExp() * tbitem.nBaseExp);
		local szAnnouce = string.format("Chúc mừng bạn nhận được <color=white>%s<color> kinh nghiệm", me.GetBaseAwardExp() * tbitem.nBaseExp);
		pPlayer.Msg(szAnnouce);
		Dbg:WriteLog("Ngẫu nhiên nhận vật phẩm",  pPlayer.szName, string.format("Ngẫu nhiên nhận được %s kinh nghiệm", me.GetBaseAwardExp() * tbitem.nBaseExp));
	end
		
	if tbitem.nMKP ~= 0 then
		pPlayer.ChangeCurMakePoint(tbitem.nMKP)
		local szAnnouce = string.format("Chúc mừng bạn nhận được <color=white>%s<color> tinh lực",tbitem.nMKP);
		pPlayer.Msg(szAnnouce);
		Dbg:WriteLog("Ngẫu nhiên nhận vật phẩm",  pPlayer.szName, string.format("Ngẫu nhiên nhận được %s tinh lực", tbitem.nMKP));
	end
	
	if tbitem.nGTP ~= 0 then
		pPlayer.ChangeCurGatherPoint(tbitem.nGTP)
		local szAnnouce = string.format("Chúc mừng bạn nhận được <color=white>%s<color> hoạt lực",tbitem.nGTP);
		pPlayer.Msg(szAnnouce);
		Dbg:WriteLog("Ngẫu nhiên nhận vật phẩm",  pPlayer.szName, string.format("Ngẫu nhiên nhận được %s hoạt lực", tbitem.nGTP));		
	end
	
	if tbTask[1] and tbTask[2] and tbTask[3] then
		if tbTask[1] ~= 0 and tbTask[2] ~= 0 then
			pPlayer.SetTask(unpack(tbTask));
		end		
	end
	local nStep = 1;
	if nMustGet <= 0 then
		nStep = 2;
	end
	if tbTask[1] and tbTask[1] ~= 0 and tbTask[4] and tbTask[4] ~= 0 then
		pPlayer.SetTask(tbTask[1],tbTask[4], pPlayer.GetTask(tbTask[1],tbTask[4]) + nStep);
	end
	if tbTask[1] and tbTask[1] ~= 0 and tbTask[5] and tbTask[5] ~= 0 then
		pPlayer.SetTask(tbTask[1],tbTask[5], pPlayer.GetTask(tbTask[1],tbTask[5]) + nStep);
	end

	if tbitem.nAnnounce == 1 then
		local szMsg = string.format("<color=white>%s<color> mở <color=red>%s<color> nhận được <color=blue>%s<color>, thật may mắn!", pPlayer.szName, tbitem.szDesc, tbitem.szName);
		--KDialog.NewsMsg(1, Env.NEWSMSG_NORMAL, szMsg);
		--Player:SendMsgToKinOrTong(pPlayer, " mở "..tbitem.szDesc.." nhận được "..tbitem.szName..".", 1);
	end
	
	if tbitem.nFriendMsg == 1 then
		--pPlayer.SendMsgToFriend("Hảo hữu của bạn [<color=white>"..pPlayer.szName.."<color>] mở "..tbitem.szDesc.. " nhận được <color=white>"..tbitem.szName.."<color> .");		
	end

	return 1;
end

function tbRandomItem:CheckItemFree(pPlayer, nCount)
	if pPlayer.CountFreeBagCell() < nCount then
		local szAnnouce = "Túi đã đầy, hãy chừa trống "..nCount.." ô rồi thử lại.";
		pPlayer.Msg(szAnnouce);
		return 0;
	end
	return 1;
end

function tbRandomItem:CheckTask(nTaskGroupId, nTaskData, nTaskTimes, nTaskTimes_Max, nTaskTimes_All, nTaskTimes_All_Max)	
	if not nTaskGroupId or nTaskGroupId == 0 then
		return 1;
	end
	if nTaskData and nTaskTimes and nTaskTimes_Max and nTaskData ~= 0 and nTaskTimes ~= 0 and nTaskTimes_Max ~= 0 then		
		local nDate = me.GetTask(nTaskGroupId, nTaskData);
		local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
		if nDate ~= nNowDate then
			me.SetTask(nTaskGroupId, nTaskData, nNowDate);
			me.SetTask(nTaskGroupId, nTaskTimes, 0);
		end	
		local nTimes = me.GetTask(nTaskGroupId, nTaskTimes);			
		if nTimes >= nTaskTimes_Max * 2 then
			me.Msg("Hôm nay bạn đã mở đủ rồi! Mai quay lại nhé!");
			return 0;
		end
	end
	if nTaskTimes_All and nTaskTimes_All_Max and nTaskTimes_All_Max ~= 0 and nTaskTimes_All ~= 0 then
		local nTimesAll = me.GetTask(nTaskGroupId, nTaskTimes_All);		
		if nTimesAll >= nTaskTimes_All_Max * 2 then
			me.Msg("Hôm nay bạn đã mở đủ rồi! Xin nhường cơ hội cho người khác nhé!");
			return 0;
		end
	end
	return 1;
end

function tbRandomItem:LimitTime(pPlayer, szParam, pItem)
	if szParam == nil then
		return 1;
	end
	if not pItem then
		return 0;
	end
	if tonumber(szParam) ~= nil then
		local szDate = os.date("%Y/%m/%d/%H/%M/%S", GetTime() + tonumber(szParam) * 60);
		pPlayer.SetItemTimeout(pItem,szDate);
	else
		local tbStr = Lib:SplitStr(szParam, "/");
		if #tbStr == 3 then
			local nNowDate = GetLocalDate("%Y/%m/%d");
			local szTime = string.format("%s/%s", nNowDate, szParam);
			pPlayer.SetItemTimeout(pItem,szTime);
		elseif #tbStr == 4 then
			if tonumber(tbStr[1]) > 0 then
				local nNowDate = GetLocalDate("%Y/%m");
				local nHour = tonumber(GetLocalDate("%H"));
				local nMin = tonumber(GetLocalDate("%M"));
				local nSecond = tonumber(GetLocalDate("%S"));
				local nLastTime = 24 * 3600 - (nHour * 3600 + nMin *60 + nSecond);
				local nLastTime2 = tonumber(tbStr[2]) * 3600 + tonumber(tbStr[3]) * 60 + tonumber(tbStr[4]);
				local nLimitTime = nLastTime + ((tonumber(tbStr[1]) - 1)* 24 * 3600) + nLastTime2;
				local szDate = os.date("%Y/%m/%d/%H/%M/%S", GetTime() + nLimitTime);
				pPlayer.SetItemTimeout(pItem,szDate);
			else
				local nNowDate = GetLocalDate("%Y/%m/%d");
				local szTime = string.format("%s/%s/%s/%s", nNowDate, tonumber(tbStr[2]), tonumber(tbStr[3]), tonumber(tbStr[4]));
				pPlayer.SetItemTimeout(pItem,szTime);				
			end			
		elseif #tbStr == 6 then
			pPlayer.SetItemTimeout(pItem,szParam);
		end
	end
	return 0;
end

function tbRandomItem:InitGenInfo()
	local nkind = tonumber(it.GetExtParam(2));
	if nkind == 1 then
		local nDate = tonumber(GetLocalDate("%Y%m%d2400"));
		local nSec = Lib:GetDate2Time(nDate);
		it.SetTimeOut(0, nSec);
	elseif nkind == 2 then
		it.SetTimeOut(0, GetTime() + 3600 * 24 * 7);
	end
	return	{ };
end

function tbRandomItem:GetItemList()
	
	local tbsortpos = Lib:LoadTabFile(SZITEMFILE);
	local nLineCount = #tbsortpos;
	local tbClassItemList = {};
	
	for nLine=2, nLineCount do
		local nClassParamID = tonumber(tbsortpos[nLine].ClassParamID);
		local nProbability = tonumber(tbsortpos[nLine].Probability) or 0;
		local szName = tbsortpos[nLine].Name;
		local szDesc = tbsortpos[nLine].Desc;
		local nBindMoney = tonumber(tbsortpos[nLine].BindMoney) or 0;
		local nMoney = tonumber(tbsortpos[nLine].Money) or 0;
		local nGenre = tonumber(tbsortpos[nLine].Genre) or 0;
		local nDetailType = tonumber(tbsortpos[nLine].DetailType)or 0;
		local nParticularType = tonumber(tbsortpos[nLine].ParticularType) or 0;
		local nLevel = tonumber(tbsortpos[nLine].Level)or 0;
		local nSeries = tonumber(tbsortpos[nLine].Series) or 0;
		local nEnhTimes = tonumber(tbsortpos[nLine].EnhTimes) or 0;
		local nAmount = tonumber(tbsortpos[nLine].Amount) or 1;
		local nExp = tonumber(tbsortpos[nLine].Exp) or 0;
		local nBaseExp = tonumber(tbsortpos[nLine].BaseExp) or 0;
		local nMKP = tonumber(tbsortpos[nLine].MKP) or 0;
		local nGTP = tonumber(tbsortpos[nLine].GTP) or 0;
		local szTimeLimit = tbsortpos[nLine].TimeLimit;
		local nBind = tonumber(tbsortpos[nLine].Bind) or 0;
		local nCoin = tonumber(tbsortpos[nLine].Coin) or 0;
		local nAnnounce = tonumber(tbsortpos[nLine].Announce) or 0;
		local nFriendMsg = tonumber(tbsortpos[nLine].FriendMsg) or 0;
		
		if tbClassItemList[nClassParamID] == nil then
			tbClassItemList[nClassParamID] = {};
			tbClassItemList[nClassParamID].nMaxProp = 0;
		end
		local nPosNo = (#tbClassItemList[nClassParamID]+ 1);
		tbClassItemList[nClassParamID][nPosNo] = {};
		tbClassItemList[nClassParamID][nPosNo].nProbability = nProbability;
		tbClassItemList[nClassParamID][nPosNo].szName = szName;
		tbClassItemList[nClassParamID][nPosNo].nBindMoney = nBindMoney;
		tbClassItemList[nClassParamID][nPosNo].nMoney = nMoney;
		tbClassItemList[nClassParamID][nPosNo].nGenre = nGenre;
		tbClassItemList[nClassParamID][nPosNo].nDetailType = nDetailType;
		tbClassItemList[nClassParamID][nPosNo].nParticularType = nParticularType;
		tbClassItemList[nClassParamID][nPosNo].nLevel = nLevel;
		tbClassItemList[nClassParamID][nPosNo].nSeries = nSeries;
		tbClassItemList[nClassParamID][nPosNo].nEnhTimes = nEnhTimes;
		tbClassItemList[nClassParamID][nPosNo].nAmount = nAmount;
		tbClassItemList[nClassParamID][nPosNo].nExp = nExp;
		tbClassItemList[nClassParamID][nPosNo].nBaseExp = nBaseExp;
		tbClassItemList[nClassParamID][nPosNo].nMKP = nMKP;
		tbClassItemList[nClassParamID][nPosNo].nGTP = nGTP;
		tbClassItemList[nClassParamID][nPosNo].szTimeLimit = szTimeLimit;
		tbClassItemList[nClassParamID][nPosNo].nBind = nBind;
		tbClassItemList[nClassParamID][nPosNo].nCoin = nCoin;
		tbClassItemList[nClassParamID][nPosNo].nAnnounce = nAnnounce;
		tbClassItemList[nClassParamID][nPosNo].nFriendMsg = nFriendMsg;
		tbClassItemList[nClassParamID][nPosNo].szDesc = szDesc;

		if nProbability >= 0 then
			tbClassItemList[nClassParamID].nMaxProp =
			tbClassItemList[nClassParamID].nMaxProp + nProbability;
		end
	end
	return tbClassItemList;
end

tbRandomItem.tbItemList = tbRandomItem:GetItemList()
