
local tbItem = Item:GetClass("presentitem");
local SZITEMFILE = "\\setting\\item\\001\\other\\presentitem.txt";

function tbItem:CheckItem(pItem, pPlayer, tbitem)	
	if tbitem.nBindMoney ~= 0 and		
	   pPlayer.GetBindMoney() + tbitem.nBindMoney > pPlayer.GetMaxCarryMoney() then
		return 0, "Bạc khóa của bạn sắp đạt tối đa, hãy dọn dẹp lại!";
	end
	
	if tbitem.nMoney ~= 0 and
	   pPlayer.nCashMoney + tbitem.nMoney > pPlayer.GetMaxCarryMoney() then
		return 0, "Bạc của bạn sắp đạt tối đa, hãy dọn dẹp lại!";
	end
	
	if tbitem.nGenre ~= 0 and tbitem.nDetailType ~= 0 and tbitem.nParticularType ~= 0 then		
		local tbItemInfo = {};
		local nNumber = tonumber(tbitem.szTimeLimit);
		tbItemInfo.bTimeOut = 1;	
		if nNumber then
			if nNumber == 0 then
				tbItemInfo.bTimeOut = nil;		
			elseif nNumber < 0 then
				local nItemTimeType, nItemTimeOut = pItem.GetTimeOut();
				if nItemTimeType == 0 and nItemTimeOut == 0 then
					tbItemInfo.bTimeOut = nil;
				end
			end
		end
		
		if tbitem.nBind > 0 then
			tbItemInfo.bForceBind = tbitem.nBind;
		end
		local nFreeCount = KItem.GetNeedFreeBag(tbitem.nGenre, tbitem.nDetailType, tbitem.nParticularType, tbitem.nLevel, tbItemInfo, tbitem.nAmount);
		if pPlayer.CountFreeBagCell() < nFreeCount then
			return 0,string.format("Cần %s ô trống, hãy sắp xếp lại.",nFreeCount);
		end	
	end
	return 1;
end

function tbItem:GetItem(pItem, pPlayer, tbitem)
	if tbitem.nBindMoney ~= 0 then
		pPlayer.AddBindMoney(tbitem.nBindMoney, Player.emKBINDMONEY_ADD_PRESENTITEM);
		local szAnnouce = string.format("Chúc mừng bạn nhận được <color=yellow>%s<color> bạc khóa", tbitem.nBindMoney);
		pPlayer.Msg(szAnnouce);
		KStatLog.ModifyAdd("bindjxb", "[Nơi]"..(tbitem.szDesc or "Chưa biết rương gì"), "Tổng", tbitem.nBindMoney);
	end
	if tbitem.nMoney ~= 0 then
		local nAddMoney = pPlayer.Earn(tbitem.nMoney, Player.emKEARN_PRESENT_ITEM);
		local szAnnouce = string.format("Bạn nhận được <color=yellow>%s<color> lượng bạc", tbitem.nMoney);
		pPlayer.Msg(szAnnouce);
		if nAddMoney == 1 then
			Dbg:WriteLog("[Túi quà đạo cụ] Nhận được vật phẩm",  pPlayer.szName,  string.format("[Túi quà đạo cụ] Nhận được %s bạc", tbitem.nMoney));
			KStatLog.ModifyAdd("jxb", "[Nơi]"..(tbitem.szDesc or "Chưa biết rương gì"), "Tổng", tbitem.nMoney);
		else
			Dbg:WriteLog("[Túi quà đạo cụ] Nhận được vật phẩm",  pPlayer.szName,  string.format("Bạc đã đạt tối đa, [Túi quà đạo cụ] nhận %s bạc thất bại", tbitem.nMoney));
		end
	end
	if tbitem.nCoin ~= 0 then
		local nAddCoin = pPlayer.AddBindCoin(tbitem.nCoin, Player.emKBINDCOIN_ADD_PRESENT_ITEM); -- 只会加绑金
		local szAnnouce = string.format("Chúc mừng bạn nhận được <color=yellow>%s<color> %s khóa", tbitem.nCoin, IVER_g_szCoinName);
		pPlayer.Msg(szAnnouce);
		if nAddCoin == 1 then
			KStatLog.ModifyAdd("bindcoin", "[Nơi]"..(tbitem.szDesc or "Chưa biết rương gì"), "Tổng", tbitem.nCoin);
			Dbg:WriteLog("[Túi quà đạo cụ] Nhận được vật phẩm",  pPlayer.szName,  string.format("[Túi quà đạo cụ] Nhận được %s %s khóa", tbitem.nCoin, IVER_g_szCoinName));
		else
			Dbg:WriteLog("[Túi quà đạo cụ] Nhận được vật phẩm",  pPlayer.szName,  string.format("%s khóa đã đạt tối đa, [Túi quà đạo cụ] nhận %s khóa %s thất bại", IVER_g_szCoinName, tbitem.nCoin, IVER_g_szCoinName));
		end
	end
	if tbitem.nGenre ~= 0 and tbitem.nDetailType ~= 0 and tbitem.nParticularType ~= 0 then
		local nCount = tonumber(tbitem.nAmount) or 1;		
		local tbItemInfo = {};
		tbItemInfo.nSeries = tbitem.nSeries;
		tbItemInfo.nEnhTimes = tbitem.nEnhTimes;

		local nItemTime = tonumber(tbitem.szTimeLimit);
		local nItemTimeType, nItemTimeOut = pItem.GetTimeOut();
		tbItemInfo.bTimeOut = 1;
		if nItemTime then
			if nItemTime == 0 then
				tbItemInfo.bTimeOut = nil;		
			elseif nItemTime < 0 then
				if nItemTimeType == 0 and nItemTimeOut == 0 then
					tbItemInfo.bTimeOut = nil;
				end
			end
		end		
		
		
		if tbitem.nBind > 0 then
			tbItemInfo.bForceBind = tbitem.nBind;
		end
		
		if tbItemInfo.bTimeOut ~= 1 then
			local nAddCount = pPlayer.AddStackItem(tbitem.nGenre, tbitem.nDetailType, tbitem.nParticularType, tbitem.nLevel, tbItemInfo, nCount);
			if nAddCount > 0 then
				local szAnnouce = string.format("Chúc mừng bạn đã nhận được <color=yellow>%s<color>", tbitem.szName);
				pPlayer.Msg(szAnnouce);
				Dbg:WriteLog("[Túi quà đạo cụ] Nhận được vật phẩm",  pPlayer.szName, string.format("[Túi quà đạo cụ] Nhận được %s", tbitem.szName));
			else
				local szMsg = string.format("[Túi quà đạo cụ] Nhận vật phẩm thất bại, ID: %s,%s,%s", tbitem.nGenre, tbitem.nDetailType, tbitem.nParticularType);
				Dbg:WriteLog("[Túi quà đạo cụ] Nhận được vật phẩm",  pPlayer.szName, szMsg);
				return 0;
			end
		else
			for i= 1, nCount do
				local pItemEx = pPlayer.AddItemEx(tbitem.nGenre, tbitem.nDetailType, tbitem.nParticularType, tbitem.nLevel, tbItemInfo, Player.emKITEMLOG_TYPE_JOINEVENT);
				if pItemEx then		
					if nItemTime and nItemTime < 0 then
						pItemEx.SetTimeOut(nItemTimeType, nItemTimeOut);
						pItemEx.Sync();
					elseif tbitem.szTimeLimit ~= "" then
						self:LimitTime(pPlayer, tbitem.szTimeLimit, pItemEx);
					end
					local szAnnouce = string.format("Chúc mừng bạn đã nhận được <color=yellow>%s<color>", pItemEx.szName);
					pPlayer.Msg(szAnnouce);
					Dbg:WriteLog("[Túi quà đạo cụ] Nhận được vật phẩm",  pPlayer.szName, string.format("[Túi quà đạo cụ] Nhận được %s", pItemEx.szName));
				else
					local szMsg = string.format("[Túi quà đạo cụ] Nhận vật phẩm thất bại, ID: %s,%s,%s", tbitem.nGenre, tbitem.nDetailType, tbitem.nParticularType);
					Dbg:WriteLog("[Túi quà đạo cụ] Nhận được vật phẩm",  pPlayer.szName, szMsg);
					return 0;
				end
			end
		end
	end
	
	if tbitem.nExp ~= 0 then
		pPlayer.AddExp(tbitem.nExp)
		local szAnnouce = string.format("Chúc mừng bạn nhận được <color=yellow>%s<color> kinh nghiệm",tbitem.nExp);
		pPlayer.Msg(szAnnouce);
		Dbg:WriteLog("[Túi quà đạo cụ] Nhận được vật phẩm",  pPlayer.szName, string.format("[Túi quà đạo cụ] Nhận được %s kinh nghiệm", tbitem.nExp));
	end
	
	if tbitem.nBaseExp ~= 0 then
		pPlayer.AddExp(me.GetBaseAwardExp() * tbitem.nBaseExp);
		local szAnnouce = string.format("Chúc mừng bạn nhận được <color=yellow>%s<color> kinh nghiệm", me.GetBaseAwardExp() * tbitem.nBaseExp);
		pPlayer.Msg(szAnnouce);
		Dbg:WriteLog("[Túi quà đạo cụ] Nhận được vật phẩm",  pPlayer.szName, string.format("[Túi quà đạo cụ] Nhận được %s kinh nghiệm", me.GetBaseAwardExp() * tbitem.nBaseExp));
	end
		
	if tbitem.nMKP ~= 0 then
		pPlayer.ChangeCurMakePoint(tbitem.nMKP)
		local szAnnouce = string.format("Chúc mừng bạn nhận được <color=yellow>%s<color> tinh lực",tbitem.nMKP);
		pPlayer.Msg(szAnnouce);
		Dbg:WriteLog("[Túi quà đạo cụ] Nhận được vật phẩm",  pPlayer.szName, string.format("[Túi quà đạo cụ] Nhận được %s Tinh lực", tbitem.nMKP));
	end
	
	if tbitem.nGTP ~= 0 then
		pPlayer.ChangeCurGatherPoint(tbitem.nGTP)
		local szAnnouce = string.format("Chúc mừng bạn nhận được <color=yellow>%s<color> hoạt lực",tbitem.nGTP);
		pPlayer.Msg(szAnnouce);
		Dbg:WriteLog("[Túi quà đạo cụ] Nhận được vật phẩm",  pPlayer.szName, string.format("[Túi quà đạo cụ] Nhận được %s Hoạt lực", tbitem.nGTP));		
	end

	if tbitem.nSkillId ~= 0 and tbitem.nSkillLevel ~= 0 and tbitem.nSkillTime ~= 0 then
		local bIsAddSkill = 1;
		local nSkillLevel, nTimeType, nTimeSec = pPlayer.GetSkillState(tbitem.nSkillId);
		if tonumber(nSkillLevel) == tonumber(tbitem.nSkillLevel) and tonumber(nTimeType) == 2 then
			if nTimeSec >= tbitem.nSkillTime*60*Env.GAME_FPS then
				pPlayer.Msg("Bạn đã có trạng thái này, hiệu quả của nó lâu hơn hiệu quả trạng thái hiện tại.");
				bIsAddSkill = 0;
				Dbg:WriteLog("[Túi quà đạo cụ] Nhận được vật phẩm",  pPlayer.szName, string.format("[Túi quà đạo cụ] Nhận kỹ năng BUFF thất bại do đã có trạng thái: %s,%s,%s", tbitem.nSkillId,tbitem.nLevel,tbitem.nSkillTime));			
			end
		end
		if bIsAddSkill == 1 then
			pPlayer.AddSkillState(tbitem.nSkillId, tbitem.nSkillLevel, 2, tbitem.nSkillTime*60*Env.GAME_FPS, 1, 0, 1);
			Dbg:WriteLog("[Túi quà đạo cụ] Nhận được vật phẩm",  pPlayer.szName, string.format("[Túi quà đạo cụ] nhận được kỹ năng BUFF: %s,%s,%s", tbitem.nSkillId,tbitem.nLevel,tbitem.nSkillTime));		
		end
	end


	if tbitem.nAnnounce == 1 then
		local szMsg = string.format("%s mở %s nhận được 1 %s, thật may mắn!", pPlayer.szName, tbitem.szDesc, tbitem.szName);
		KDialog.NewsMsg(1, Env.NEWSMSG_NORMAL, szMsg);
		Player:SendMsgToKinOrTong(pPlayer, " mở "..tbitem.szDesc.." nhận được "..tbitem.szName..".", 1);
	end
	
	if tbitem.nFriendMsg == 1 then
		pPlayer.SendMsgToFriend("Hảo hữu của bạn [<color=yellow>"..pPlayer.szName.."<color>] mở quà  "..tbitem.szDesc..
			"Nhận được <color=yellow>"..tbitem.szName.."<color>.");		
	end

	return 1;
end


function tbItem:GetItemList()
	
	local tbsortpos = Lib:LoadTabFile(SZITEMFILE);
	local nLineCount = #tbsortpos;
	local tbClassItemList = {};
	
	for nLine=2, nLineCount do
		local nClassParamID = tonumber(tbsortpos[nLine].ClassParamID);
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
		local szTimeLimit = tbsortpos[nLine].TimeLimit or "";
		if szTimeLimit == "" then
			szTimeLimit = "-1" ;
		end
		local nBind = tonumber(tbsortpos[nLine].Bind) or 0;
		local nCoin = tonumber(tbsortpos[nLine].Coin) or 0;
		local nAnnounce = tonumber(tbsortpos[nLine].Announce) or 0;
		local nFriendMsg = tonumber(tbsortpos[nLine].FriendMsg) or 0;
		
		local nSkillId = tonumber(tbsortpos[nLine].SkillId) or 0;
		local nSkillLevel = tonumber(tbsortpos[nLine].SkillLevel) or 0;
		local nSkillTime = tonumber(tbsortpos[nLine].SkillTime) or 0;
		
		if tbClassItemList[nClassParamID] == nil then
			tbClassItemList[nClassParamID] = {};
		end
		local nPosNo = (#tbClassItemList[nClassParamID]+ 1);
		tbClassItemList[nClassParamID][nPosNo] = {};
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
		
		tbClassItemList[nClassParamID][nPosNo].nSkillId    = nSkillId;
		tbClassItemList[nClassParamID][nPosNo].nSkillLevel = nSkillLevel;
		tbClassItemList[nClassParamID][nPosNo].nSkillTime  = nSkillTime;
	end
	return tbClassItemList;
end



function tbItem:LimitTime(pPlayer, szParam, pItem)
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

function tbItem:OnUse()
	if not self.tbItemList  then
		self.tbItemList = self:GetItemList();
	end
	local nkind = tonumber(it.GetExtParam(1));
	if not self.tbItemList[nkind] then
		return;
	end	


	if #self.tbItemList[nkind] > 31 or #self.tbItemList[nkind] == 0 then
		print("{error},presentitem,tbItemList",#self.tbItemList[nkind]);
		return;
	end
	
	local tbOpt = {};
	local nIsUsed = it.GetGenInfo(1) or 0;
	local nTmp = 0;	
	
	for nIdx, tbItem in ipairs(self.tbItemList[nkind]) do		
		local szMsg  = tbItem.szName;
		tbItem.nAmount = tbItem.nAmount or 1;
		if tbItem.nAmount > 1 then
			szMsg = szMsg..string.format("(%d)",tbItem.nAmount);
		end
		
		local bUsed = Lib:LoadBits(nIsUsed, nIdx - 1, nIdx - 1);
		if bUsed == 0 then
			table.insert(tbOpt, {szMsg,self.OnUseEx,self,it.dwId,nIdx,self.tbItemList[nkind]});
		else
			table.insert(tbOpt, {string.format("<color=gray>%s<color>",szMsg),self.OnUseEx,self,it.dwId,nIdx,self.tbItemList[nkind]});
		end			
	end
	table.insert(tbOpt,{"Ta suy nghĩ lại."});
	Dialog:Say((it.szName or "")..", mở ra có thể được phần thưởng phong phú.",tbOpt);
	return;	
end

function tbItem:OnUseEx(nItemId, nIdx, tbItemList)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return;
	end		
	local nIsUsed = pItem.GetGenInfo(1);	
	local bUsed = Lib:LoadBits(nIsUsed, nIdx - 1, nIdx -1);
	if bUsed ~= 0 then
		Dialog:Say("Ngươi đã nhận phần thưởng này.");
		return;
	end

	if not tbItemList[nIdx] then
		print("presentitem	tbItemList error",nIdx);
		return;
	end
	
	local nRes, varMsg = self:CheckItem(pItem,me, tbItemList[nIdx]);
	if nRes == 0 then
		Dialog:Say(varMsg);
		return;
	end
	self:GetItem(pItem,me, tbItemList[nIdx]);

	nIsUsed = Lib:SetBits(nIsUsed, 1, nIdx - 1, nIdx - 1);	
	pItem.SetGenInfo(1,nIsUsed);
	local nState = 0;
	for nIndex in ipairs(tbItemList) do
		if Lib:LoadBits(nIsUsed, nIndex - 1, nIndex - 1) == 0 then
			nState = 1;
			break;
		end		
	end

	if nState == 0 then   -- 没了东西就直接删了
		pItem.Delete(me);
	else
		pItem.Bind(1); -- 使用之后直接绑定
		pItem.Sync();  --要同步
	end
	return;
end

function tbItem:GetTip() 
	if not self.tbItemList  then
		self.tbItemList = self:GetItemList();
	end
	local nkind = tonumber(it.GetExtParam(1));
	local tbItem = self.tbItemList[nkind];
	if not tbItem then
		return "";
	end		
	
	local szMsg = "Dùng cho anh hùng luyện võ, bên trong có  ";

	local nIsUsed = it.GetGenInfo(1);	
	for nIdx, tbInfo in ipairs(tbItem) do
		local bUsed = Lib:LoadBits(nIsUsed, nIdx - 1, nIdx -1);
		if bUsed == 0 then	
			szMsg = szMsg.."\n"..tbInfo.szName;
			if tbInfo.nGenre ~= 0 then
				szMsg = string.format("%s <color=yellow>%d<color> cái  ", szMsg,tbInfo.nAmount);
			end	
		end
	end
	szMsg = szMsg.." \nRẻ hơn rất nhiều so với mua lẻ.\n<color=gold>Ghi chú: Sau khi lấy vật phẩm ra khỏi túi quà, túi quà sẽ khóa.<color>";
	return szMsg;
end

tbItem.tbItemList = tbItem:GetItemList();
