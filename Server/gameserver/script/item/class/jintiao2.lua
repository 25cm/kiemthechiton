
local tbItem = Item:GetClass("jintiao2");
tbItem.GETCOIN = 
{
	[1] = {10, 20},
	[2] = {100, 200},
	[3] = {1000, 2000},
	[4] = {10000, 20000},
	[5] = {100000, 200000},
};

function tbItem:OnUse()
	local nGetCoin = self.GETCOIN[it.nLevel][1];
	local nGetBindCoin = self.GETCOIN[it.nLevel][2];

	local szMsg = string.format("Sử dụng <color=yellow>%s<color> có thể nhận được：<color=yellow>%s đồng khóa <color>\n\n bạn muốn nhận không ?", it.szName, nGetCoin);
	local tbOpt = {
		{"Ta đồng ý", self.SureUse, self, it, 1},
		{"Để ta xem lại"},
	}
	Dialog:Say(szMsg, tbOpt);
	return 0;
end

function tbItem:SureUse(pItem, nType, nSure)
	if not pItem then
		return
	end
	local szItemName = pItem.szName;
	local nIbValue = pItem.nBuyPrice;
	local nGetCoin = self.GETCOIN[pItem.nLevel][nType];
	local nGetBindCoin = self.GETCOIN[pItem.nLevel][2];
	local szType = "Đồng khóa";
	if nType == 2 then
		szType = "Đổi đồng khóa";
	end
	if not nSure then
		local szMsg = string.format("Bạn xác nhận việc đổi <color=yellow>%s%s<color> ?", nGetCoin, szType);
		local tbOpt = {
			{"Ta đồng ý", self.SureUse, self, pItem, nType, 1},
			{"Để ta xem lại"},
		};
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end

	if me.DelItem(pItem, Player.emKLOSEITEM_JINTIAO) ~= 1 then
		Dbg:WriteLog(me.szName, "Del Item:", szItemName, "Không");
		return 0;
	end
--	if self.ExReturnBindMoney > 0 then
--		me.AddBindMoney(math.floor(self.ExReturnBindMoney * nGetBindMoney / 100), Player.emKBINDMONEY_ADD_JITIAO);
--		KStatLog.ModifyAdd("bindjxb", "[产出]金条开出", "总量", math.floor(self.ExReturnBindMoney * nGetBindMoney / 100));	
--	end

	local szCoinType = "Đồng khóa";
	if nType == 1 then
		me.AddJbCoin(nGetCoin);
		Dbg:WriteLog(me.szName, "Use Item:", szItemName, "GetCoin:", nGetCoin);
--		KStatLog.ModifyAdd("jxb", "[产出]金币券开出", "总量", nGetCoin);	
	else
		szCoinType = "Đồng khóa"..szCoinType;
		me.AddBindCoin(nGetBindCoin);
		Dbg:WriteLog(me.szName, "Use Item:", szItemName, "GetBindCoin:", nGetBindCoin);
		KStatLog.ModifyAdd("bindcoin", "[产出]金币券开出", "总量", nGetBindCoin);			
	end

	Dbg:WriteLog("use jintiao", me.szAccount, me.szName,  string.format("Sử dụng %s nhận được %d%s", szItemName, nGetCoin, szCoinType));
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("%s sử dụng %s nhận được %d%s", me.szName, szItemName, nGetCoin, szCoinType));
end
