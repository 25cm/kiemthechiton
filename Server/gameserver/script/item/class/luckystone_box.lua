local tbItem 	= Item:GetClass("box_luckystone");

tbItem.TSKG_GROUP 		 = 2116;
tbItem.TSK_ITEM_BEGIN	 = 1;
tbItem.TSK_ITEM_END		 = 100; -- 最多可以存50个
tbItem.TIME_LIMIT		 = 5;  -- 有效期相差不大的可以放进来 暂时设5s

tbItem.tbBox =
{
	[1] = {szName = "Bảo Thạch May Mắn",tbGDPL = {18,1,908,1}, nMaxCount = 21},
}


function tbItem:OnUse()
	local tbOpt = {
		{"Gửi vật phẩm", self.TakeOutItem, self,it.dwId},
		{"Rút vật phẩm", self.TakeInItem, self,it.dwId},
		{"Đóng"}
	};
	local szMsg = "Đây là Hộp Thần Kì, bạn muốn dùng nó làm gì?";
	Dialog:Say(szMsg, tbOpt);
end;


function tbItem:TakeInItem(nItemId)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return;
	end		
	local tbOpt = {};
	for i = 1 , #self.tbBox do
		local nTskId = self.TSK_ITEM_BEGIN + (i - 1) * 2;		
		local nCurCount = me.GetTask(self.TSKG_GROUP, nTskId);
		local nTimeSec  = me.GetTask(self.TSKG_GROUP, nTskId + 1);
		local nCurDate	= tonumber(GetLocalDate("%Y%m%d"));
		local nCurSec	= Lib:GetDate2Time(nCurDate);		
		
		if nCurCount == 0 then
			if nTimeSec ~= 0 then
				me.SetTask(self.TSKG_GROUP, nTskId + 1,0);
			end
		elseif nCurSec > nTimeSec then
			me.SetTask(self.TSKG_GROUP, nTskId,0);
			me.SetTask(self.TSKG_GROUP, nTskId + 1,0);
		else
			local szName = string.format("Lấy ra %s còn %s", Lib:StrFillC(self.tbBox[i].szName,10),nCurCount);
			table.insert(tbOpt,{szName, self.OnOpenItem, self,nTskId,nItemId,nCurCount});
		end
	end
	table.insert(tbOpt, {"Để ta suy nghĩ đã"});
	local szMsg = "\nChọn vật phẩm muốn rút.";
	Dialog:Say(szMsg, tbOpt)
end

function tbItem:OnOpenItem(nTskId, nItemId,nCurCount)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return;
	end

	Dialog:AskNumber("Nhập số lượng: ", nCurCount, self.OnUseTakeOut, self, nTskId, nItemId);
end

function tbItem:OnUseTakeOut(nTskId, nItemId, nTakeOutCount)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return;
	end
	local nCurCount = me.GetTask(self.TSKG_GROUP,nTskId)
	if  nCurCount <= 0 or nTakeOutCount > nCurCount then
		return 0;
	end

	local nTimeSec  = me.GetTask(self.TSKG_GROUP, nTskId + 1);
	local nCurDate	= tonumber(GetLocalDate("%Y%m%d"));
	local nCurSec	= Lib:GetDate2Time(nCurDate);
	if  nCurSec > nTimeSec then
		me.SetTask(self.TSKG_GROUP, nTskId,0);
		me.SetTask(self.TSKG_GROUP, nTskId + 1,0);
		return 0;
	end
	
	if me.CountFreeBagCell() < nTakeOutCount then
		Dialog:Say("Túi bạn không đủ chỗ.");
		return 0;
	end	
	
	for i=1, nTakeOutCount do
		local nItemNum = (nTskId - tbItem.TSK_ITEM_BEGIN) / 2 + 1;
		local pAddItem = me.AddItem(unpack(self.tbBox[nItemNum].tbGDPL));
		if pAddItem then
			pAddItem.Bind(1);
			pAddItem.SetTimeOut(0,nTimeSec);		
			pAddItem.Sync();	
		end
	end
	local nLeftCount = nCurCount - nTakeOutCount;
	me.SetTask(self.TSKG_GROUP,nTskId,nLeftCount);
end

function tbItem:FindPos(pItem)
	local nPos = 0;
	for i = 1, #self.tbBox do
		if pItem.Equal(unpack(self.tbBox[i].tbGDPL)) == 1 then
			nPos = i;
			break;
	 	end
	end
	return nPos;	
end

function tbItem:CanAddIntoBox(pPlayer,pItem,nAddCount)
	if not pItem  then
		return 0 , "Vật phẩm mất rồi";
	end
	nAddCount = nAddCount or 0;
	local nPos = self:FindPos(pItem);
	
	if nPos == 0 then
		return 0,"Không thể thêm vật phẩm này vào hộp.";
	end
	
	local nTskId = self.TSK_ITEM_BEGIN + (nPos - 1) * 2;

	local nCurCount = pPlayer.GetTask(self.TSKG_GROUP,nTskId);
	local nTimeSec = pPlayer.GetTask(self.TSKG_GROUP,nTskId +1);
	local nType,nSec = pItem.GetTimeOut();
	if nType == 1 then
		return 0,"Không thể thêm vật phẩm này vào hộp.";
	end

	if nCurCount ~= 0 and nTimeSec > nSec + self.TIME_LIMIT and nSec > nTimeSec + self.TIME_LIMIT then
		return 0,"Thời hạn không đồng nhất, không thể bỏ vào hộp";
	end	
	
	if (nCurCount + nAddCount ) >= self.tbBox[nPos].nMaxCount then
		return 0 ,"Không thể bỏ thêm vật phẩm này.";
	end	
	return 1, nTskId,nCurCount, nSec;
end

function tbItem:AddIntoBox(pPlayer,pItem)

	local nResult, varRes1,varRes2,varRes3 = self:CanAddIntoBox(pPlayer,pItem);
	if nResult == 0 then
		return 0 ,varRes1;
	end
	pItem.Delete(me);
	pPlayer.SetTask(self.TSKG_GROUP, varRes1, varRes2 + 1);
	pPlayer.SetTask(self.TSKG_GROUP, varRes1+1, varRes3);
	return 1;
end

function tbItem:TakeOutItem(nItemId)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return;
	end	
	Dialog:OpenGift("Đặt vật phẩm gửi vào", {"Merchant:LuckyBoxCheckGiftSwith"}, {self.OnOpenGiftOk, self});
end

function tbItem:OnOpenGiftOk(tbItemObj)
	local nResult, szMsg = nil, nil;
	for _, pItem in pairs(tbItemObj) do
		nResult, szMsg = self:AddIntoBox(me,pItem[1]);
		if nResult == 0 then
			me.Msg(pItem[1].szName.."Không thể bỏ vào:",szMsg);
		end
	end
	
	return 1;
end;

function Merchant:LuckyBoxCheckGiftSwith(tbGiftSelf, pPickItem, pDropItem, nX, nY)
	local tbItem = Item:GetClass("box_luckystone");
	if (not tbGiftSelf.tbOnSwithItemCount) then
		tbGiftSelf.tbOnSwithItemCount = {};
	end	
	local szMsg = "";
	if pDropItem then
		local nPos = tbItem:FindPos(pDropItem);
		if nPos == 0 then
			me.Msg("Không thể thêm vật phẩm này vào hộp.");
			return 0;
		end
		tbGiftSelf.tbOnSwithItemCount[nPos] = tbGiftSelf.tbOnSwithItemCount[nPos] or 0;
		local nResult, varResult = tbItem:CanAddIntoBox(me,pDropItem, tbGiftSelf.tbOnSwithItemCount[nPos]);
		if nResult == 0 then
			me.Msg(varResult);
			return 0;
		end		
				tbGiftSelf.tbOnSwithItemCount[nPos] = tbGiftSelf.tbOnSwithItemCount[nPos] + 1;
		szMsg = tbItem:LuckyBoxUpdateGiftSwith(tbGiftSelf.tbOnSwithItemCount);
	end
	if pPickItem then
		local nPos = tbItem:FindPos(pPickItem);
		if nPos == 0 then
			return 0;
		end		
		tbGiftSelf.tbOnSwithItemCount[nPos] = tbGiftSelf.tbOnSwithItemCount[nPos] - 1;
		szMsg = tbItem:LuckyBoxUpdateGiftSwith(tbGiftSelf.tbOnSwithItemCount);
	end
	
	tbGiftSelf:UpdateContent(szMsg);
	return 1;
end;

function tbItem:LuckyBoxUpdateGiftSwith(tbOnSwithItemCount)
	local szTip = "";
	for i = 1 , #self.tbBox do
		local nTskId = self.TSK_ITEM_BEGIN + (i - 1) * 2;	
		local nCurCount = me.GetTask(self.TSKG_GROUP, nTskId);		
		local nTimeSec  = me.GetTask(self.TSKG_GROUP, nTskId + 1);
		local nCurDate	= tonumber(GetLocalDate("%Y%m%d"));
		local nCurSec	= Lib:GetDate2Time(nCurDate)
	
		local nSec = nTimeSec - nCurSec;
		
		nCurCount = nCurCount + (tbOnSwithItemCount[i] or 0);
		if nCurCount ~= 0 and (nTimeSec == 0 or nSec > 0) then
			local szName = string.format("<color=green>%s<color> %s/%s\n",Lib:StrFillC(self.tbBox[i].szName,20),nCurCount,self.tbBox[i].nMaxCount);
			szTip = szTip..szName;
		end
	end		

	return szTip;
end

function tbItem:GetTip(nState)
	local szTip = "";
	for i = 1 , #self.tbBox do
		local nTskId = self.TSK_ITEM_BEGIN + (i - 1) * 2;	
		local nCurCount = me.GetTask(self.TSKG_GROUP, nTskId);		
		local nTimeSec  = me.GetTask(self.TSKG_GROUP, nTskId + 1);
		local nCurDate	= tonumber(GetLocalDate("%Y%m%d"));
		local nCurSec	= Lib:GetDate2Time(nCurDate)
	
		local nSec = nTimeSec - nCurSec;
		if nCurCount ~= 0 and nSec > 0 then
			local szName = string.format("<color=green>%s<color> %s/%s Thời gian còn:%s\n",Lib:StrFillC(self.tbBox[i].szName,10),nCurCount,self.tbBox[i].nMaxCount,Lib:TimeFullDescEx(nSec));
			szTip = szTip..szName;
		end
	end	
	szTip = szTip..string.format("\n<color=gold>Nhấn chuột phải mở<color>");
	return	szTip;
end

function tbItem:InitGenInfo()
	local nDate = it.GetExtParam(1);
	local nSec = Lib:GetDate2Time(nDate);
	it.SetTimeOut(0, nSec);
	return	{ };
end
