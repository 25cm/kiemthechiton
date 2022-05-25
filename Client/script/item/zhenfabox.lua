
local tbItem = Item:GetClass("zhenfa_box")


tbItem.szHighZhenFaGDPL = "18,1,320,3"; --高级阵法册的gdpl,用于比较是否为高级阵法册

tbItem.szSelfGDPL	= "";

tbItem.PRIMER_ZHONGJIZHENFA_LIST = {
			{"Trung: Ngũ Hành Trận", 1, 15, 12, 1},
	}
tbItem.NORMAL_ZHONGJIZHENFA_LIST = {
			{"Trung: Bát Quái Trận-Li", 1, 15, 2, 1},
			{"Trung: Bát Quái Trận-Đoài", 1, 15, 3, 1},
			{"Trung: Bát Quái Trận-Cấn", 1, 15, 4, 1},
			{"Trung: Bát Quái Trận-Khảm", 1, 15, 5, 1},
			{"Trung: Bát Quái Trận-Tốn", 1, 15, 6, 1},
			{"Trung: Bát Quái Trận-Càn", 1, 15, 7, 1},
			{"Trung: Thanh Long Trận", 1, 15, 8, 1},
			{"Trung: Huyền Vũ Trận", 1, 15, 9, 1},
			{"Trung: Bạch Hổ Trận", 1, 15, 10, 1},
			{"Trung: Chu Tước Trận", 1, 15, 11, 1},
	}
tbItem.ALL_ZHONGJIZHENFA_LIST ={
			{"Trung: Ngũ Hành Trận", 1, 15, 12, 1},
			{"Trung: Bát Quái Trận-Li", 1, 15, 2, 1},
			{"Trung: Bát Quái Trận-Đoài", 1, 15, 3, 1},
			{"Trung: Bát Quái Trận-Cấn", 1, 15, 4, 1},
			{"Trung: Bát Quái Trận-Khảm", 1, 15, 5, 1},
			{"Trung: Bát Quái Trận-Tốn", 1, 15, 6, 1},
			{"Trung: Bát Quái Trận-Càn", 1, 15, 7, 1},
			{"Trung: Thanh Long Trận", 1, 15, 8, 1},
			{"Trung: Huyền Vũ Trận", 1, 15, 9, 1},
			{"Trung: Bạch Hổ Trận", 1, 15, 10, 1},
			{"Trung: Chu Tước Trận", 1, 15, 11, 1},
	}
tbItem.PRIMER_GAOJIZHENFA_LIST = {
			{"Cao: Ngũ Hành Trận",1,15,1,3},
	}
tbItem.NORMAL_GAOJIZHENFA_LIST = {
			{"Cao: Bát Quái Trận-Li",1,15,2,3},
			{"Cao: Bát Quái Trận-Đoài",1,15,3,3},
			{"Cao: Bát Quái Trận-Cấn",1,15,4,3},
			{"Cao: Bát Quái Trận-Khảm",1,15,5,3},
			{"Cao: Bát Quái Trận-Tốn",1,15,6,3},
			{"Cao: Bát Quái Trận-Càn",1,15,7,3},
			{"Cao: Thanh Long Trận",1,15,8,3},
			{"Cao: Huyễn Vũ Trận",1,15,9,3},
			{"Cao: Bạch Hổ Trận",1,15,10,3},
			{"Cao: Chu Tước Trận",1,15,11,3},
	}
tbItem.HIGH_GAOJIZHENFA_LIST = {
			{"Cao: Nguyệt Mê Tân Độ Trận",1,15,12,3},
			{"Cao: Vụ Thất Lâu Đài Trận",1,15,13,3},
			{"Cao: Tham Lang Trận-Dương",1,15,14,3},
			{"Cao: Tham Lang Trận-Âm",1,15,15,3},
			{"Cao: Bát Quái Trận-Chấn",1,15,16,3},
			{"Cao: Bát Quái Trận-Khôn",1,15,17,3},
			{"Cao: Phá Quân Trận",1,15,18,3},
			{"Cao: Thất Sát Trận",1,15,19,3},
	}
tbItem.ALL_GAOJIZHENFA_LIST = {
			{"Cao: Ngũ Hành Trận",1,15,1,3},
			{"Cao: Bát Quái Trận-Li",1,15,2,3},
			{"Cao: Bát Quái Trận-Đoài",1,15,3,3},
			{"Cao: Bát Quái Trận-Cấn",1,15,4,3},
			{"Cao: Bát Quái Trận-Khảm",1,15,5,3},
			{"Cao: Bát Quái Trận-Tốn",1,15,6,3},
			{"Cao: Bát Quái Trận-Càn",1,15,7,3},
			{"Cao: Thanh Long Trận",1,15,8,3},
			{"Cao: Huyễn Vũ Trận",1,15,9,3},
			{"Cao: Bạch Hổ Trận",1,15,10,3},
			{"Cao: Chu Tước Trận",1,15,11,3},
			{"Cao: Nguyệt Mê Tân Độ Trận",1,15,12,3},
			{"Cao: Vụ Thất Lâu Đài Trận",1,15,13,3},
			{"Cao: Tham Lang Trận-Dương",1,15,14,3},
			{"Cao: Tham Lang Trận-Âm",1,15,15,3},
			{"Cao: Bát Quái Trận-Chấn",1,15,16,3},
			{"Cao: Bát Quái Trận-Khôn",1,15,17,3},
			{"Cao: Phá Quân Trận",1,15,18,3},
			{"Cao: Thất Sát Trận",1,15,19,3},
	}


tbItem.LIVE_TIME	= 30 * 24 * 60 * 60; -- 秒 一个月
	
function tbItem:InitGenInfo()
	if MODULE_GAMECLIENT then
		it.SetTimeOut(1, self.LIVE_TIME);
	else
		it.SetTimeOut(0, GetTime() + self.LIVE_TIME);
	end;
	return	{};
end

function tbItem:OnUse()
	self.szSelfGDPL = string.format("%s,%s,%s,%s", it.nGenre, it.nDetail, it.nParticular, it.nLevel);
	local szMsg 		= "Hãy chọn thao tác bạn muốn tiến hành:"
	local tbOpt 		= {};
	tbOpt[#tbOpt + 1] 	= {"Thay đổi trận pháp", self.ReplaceBook, self, me.nId, it.dwId};
	tbOpt[#tbOpt + 1] 	= {"Lấy Trận pháp đồ", self.SelectBook, self, me.nId, it.dwId};
	tbOpt[#tbOpt + 1]	= {"Trả Trận pháp đồ", self.DeleteBook, self, me.nId};
	tbOpt[#tbOpt + 1]	= {"Hủy"};
	Dialog:Say(szMsg, tbOpt);
end;

function tbItem:SelectBook(nPlayerId, nBoxId)
	local szMsg 	= "Hãy chọn loại trận pháp:"
	local tbOpt		= {};
	if self.szHighZhenFaGDPL == self.szSelfGDPL then
		tbOpt[#tbOpt + 1] 	= {"Trận pháp-Cao", self.HandleGiveZhenFaKind, self, self.HIGH_GAOJIZHENFA_LIST,nPlayerId, nBoxId};
		tbOpt[#tbOpt + 1] 	= {"Trận pháp-Trung", self.HandleGiveZhenFaKind, self, self.NORMAL_GAOJIZHENFA_LIST,nPlayerId, nBoxId};
		tbOpt[#tbOpt + 1]	= {"Trận pháp-Sơ", self.HandleGiveZhenFaKind, self, self.PRIMER_GAOJIZHENFA_LIST,nPlayerId, nBoxId};
	else
		tbOpt[#tbOpt + 1] 	= {"Trận pháp-Trung", self.HandleGiveZhenFaKind, self, self.NORMAL_ZHONGJIZHENFA_LIST,nPlayerId, nBoxId};
		tbOpt[#tbOpt + 1]	= {"Trận pháp-Sơ", self.HandleGiveZhenFaKind, self, self.PRIMER_ZHONGJIZHENFA_LIST,nPlayerId, nBoxId};
	end
	tbOpt[#tbOpt + 1]	= {"Hủy"};
	Dialog:Say(szMsg, tbOpt); 
end;

function tbItem:HandleGiveZhenFaKind(tbZhenFaList,nPlayerId,nBoxId)
	local szMsg		= "Hãy chọn Trận pháp đồ:";
	local tbOpt		= {};
	if not tbZhenFaList then
		return;
	end
	for i = 1, #tbZhenFaList do
		local szTip = "<item=".. tbZhenFaList[i][2] .. "," .. tbZhenFaList[i][3] .. "," .. 
						tbZhenFaList[i][4] .. "," .. tbZhenFaList[i][5]..">"
		tbOpt[#tbOpt + 1]	= {tbZhenFaList[i][1] .. szTip,self.GiveBook, self, nPlayerId, i, nBoxId,tbZhenFaList};
	end;
	tbOpt[#tbOpt + 1]	=  {"Hủy"};
	Dialog:Say(szMsg, tbOpt);
end

function tbItem:ReplaceBook(nPlayerId, nBoxId)
	local szMsg 	= "Hãy chọn loại Trận pháp đồ muốn đổi:"
	local tbOpt		= {};
	if self.szHighZhenFaGDPL == self.szSelfGDPL then
		tbOpt[#tbOpt + 1] 	= {"Trận pháp-Cao", self.HandleReplaceZhenFaKind, self, self.HIGH_GAOJIZHENFA_LIST,nPlayerId, nBoxId};
		tbOpt[#tbOpt + 1] 	= {"Trận pháp-Trung", self.HandleReplaceZhenFaKind, self, self.NORMAL_GAOJIZHENFA_LIST,nPlayerId, nBoxId};
		tbOpt[#tbOpt + 1]	= {"Trận pháp-Sơ", self.HandleReplaceZhenFaKind, self, self.PRIMER_GAOJIZHENFA_LIST,nPlayerId, nBoxId};
	else
		tbOpt[#tbOpt + 1] 	= {"Trận pháp-Trung", self.HandleReplaceZhenFaKind, self, self.NORMAL_ZHONGJIZHENFA_LIST,nPlayerId,nBoxId};
		tbOpt[#tbOpt + 1]	= {"Trận pháp-Sơ", self.HandleReplaceZhenFaKind, self, self.PRIMER_ZHONGJIZHENFA_LIST,nPlayerId,nBoxId};
	end
	tbOpt[#tbOpt + 1]	= {"Hủy"};
	Dialog:Say(szMsg, tbOpt); 
end

function tbItem:HandleReplaceZhenFaKind(tbZhenFaList,nPlayerId,nBoxId)
	local szMsg		= "Hãy chọn Trận pháp đồ cần đổi, sau đó đổi trang bị của Trận pháp-Trung hiện tại thành Trận pháp-Trung mới:";
	local tbOpt		= {};
	if not tbZhenFaList then
		return;
	end
	for i = 1, #tbZhenFaList do
		local szTip = "<item=".. tbZhenFaList[i][2] .. "," .. tbZhenFaList[i][3] .. "," .. 
						tbZhenFaList[i][4] .. "," .. tbZhenFaList[i][5]..">"
		tbOpt[#tbOpt + 1]	= {tbZhenFaList[i][1] .. szTip,self.ChangeBook, self, nPlayerId, i, nBoxId,tbZhenFaList};
	end;
	tbOpt[#tbOpt + 1]	=  {"Hủy"};
	Dialog:Say(szMsg, tbOpt);
end

function tbItem:ChangeBook(nPlayerId, nBookId, nBoxId,tbZhenFaList)
	local pOldItem = me.GetItem(Item.ROOM_EQUIP, Item.EQUIPPOS_ZHEN,0);

	if not pOldItem or self:CheckItem(pOldItem.nGenre, pOldItem.nDetail, pOldItem.nParticular, pOldItem.nLevel) ~= 0 then
		local pNewItem = self:GiveBook(nPlayerId, nBookId, nBoxId,tbZhenFaList);
		if not pNewItem then
			return;
		end
		Setting:SetGlobalObj(me,him,pNewItem);
		Item:OnUse(pNewItem.szClass);
		Setting:RestoreGlobalObj();
	else
		local tbTimeOut = me.GetItemAbsTimeout(pOldItem);
		local nResult = pOldItem.Regenerate(tbZhenFaList[nBookId][2], tbZhenFaList[nBookId][3], tbZhenFaList[nBookId][4], tbZhenFaList[nBookId][5], 
											pOldItem.nSeries, pOldItem.nEnhTimes, pOldItem.nLucky, pOldItem.GetGenInfo(),
											pOldItem.nVersion,pOldItem.dwRandSeed, pOldItem.nStrengthen);
		if nResult ~= 1 then
			me.Msg("Đổi pháp trận thất bại!");
			return; 
		end
		if (tbTimeOut) then
			local szTime = string.format("%02d/%02d/%02d/%02d/%02d/10", 			
					tbTimeOut[1],
					tbTimeOut[2],
					tbTimeOut[3],
					tbTimeOut[4],
					tbTimeOut[5]);
			me.SetItemTimeout(pOldItem, szTime);
			pOldItem.Sync()
		end
	end
end

function tbItem:GiveBook(nPlayerId, nBookId, nBoxId,tbZhenFaList)
	local pBox = KItem.GetObjById(nBoxId);
	if (not pBox) then
		print("ZhenFaBox ERROR", nPlayerId, nBookId, nBoxId);
		return;
	end;
	pBox.Bind(1);
	local nFreeBagCell = me.CountFreeBagCell();
	if nFreeBagCell < 1 then
			me.Msg("Túi đầy, ít nhất phải chừa 1 ô túi trống!");
			return;
	end
	local pItem = me.AddItemEx(tbZhenFaList[nBookId][2], tbZhenFaList[nBookId][3], tbZhenFaList[nBookId][4], tbZhenFaList[nBookId][5], nil, 0);
	if (not pItem) then
		return;
	end;
	local tbTimeOut = me.GetItemAbsTimeout(pBox);		--设置绝对过期时间
	if (tbTimeOut) then
		local szTime = string.format("%02d/%02d/%02d/%02d/%02d/10", 			
				tbTimeOut[1],
				tbTimeOut[2],
				tbTimeOut[3],
				tbTimeOut[4],
				tbTimeOut[5]);
		me.SetItemTimeout(pItem, szTime);
		pItem.Sync()
	end;
	return pItem;	
end;



function tbItem:DeleteBook(nPlayerId)
	Dialog:OpenGift("Hãy đặt Trận pháp đồ muốn trả", nil, {self.OnOpenGiftOk, self});
end;

function tbItem:OnOpenGiftOk(tbItemObj)
	local bForbidItem 	= false;
	
	for _, pItem in pairs(tbItemObj) do
		if (self:CheckItem(pItem[1].nGenre,pItem[1].nDetail,pItem[1].nParticular,pItem[1].nLevel) == 0) then
			me.DelItem(pItem[1], 0);
		else
			bForbidItem = true;
		end;
	end
	
	if (bForbidItem == true) then
		me.Msg("Một số vật phẩm không thuộc Trận pháp đồ của quyển này, không thể trả lại!");
	end;
end;

function tbItem:CheckItem(nGenre, nDetail,nParticular,nLevel)
	local szBook = string.format("%s,%s,%s,%s", nGenre, nDetail,nParticular,nLevel)
	local nIsHigh = false;
	if self.szHighZhenFaGDPL == self.szSelfGDPL then
		nIsHigh = true;
	else
		nIsHigh = false;
	end
	for i,v in ipairs(nIsHigh and self.ALL_GAOJIZHENFA_LIST or self.ALL_ZHONGJIZHENFA_LIST) do
		local szItem = string.format("%s,%s,%s,%s", v[2], v[3], v[4], v[5]);
		if (szItem == szBook) then
			return 0;
		end;
	end;
	return 1;
end;
