-- 文件名　：youlongge_happyegg.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-11-11 09:08:59
-- 描  述  ：这个是游龙开心蛋，还有个盛夏开心蛋

local tbItem = Item:GetClass("youlongge_happyegg");
tbItem.TSK_GROUP = 2106;
tbItem.TSK_COUNT = 4;
tbItem.TSK_DATE	 = 5;
tbItem.DEF_BINDMONEY	= 150000;
tbItem.DEF_BINDCOIN		= 3000;
tbItem.DEF_MAXCOUNT 	= 5;

function tbItem:OnUse()
	--self:OnLoginDay(1);
	local nCount = me.GetTask(self.TSK_GROUP, self.TSK_COUNT);
	if nCount > self.DEF_MAXCOUNT or nCount < 0 then
		me.SetTask(self.TSK_GROUP, self.TSK_COUNT, 1000);
		nCount = 1000;
	end
	local szMsg = string.format("<color=yellow>Trứng du long càng ăn càng ngon<color>\n\n Mỗi ngày tham gia hoạt động du long và   mở trứng có thể nhận được phần thưởng   hấp dẫn.");
	local tbOpt = {
		{string.format("<color=yellow>3000 Đồng khóa<color>"), self.GetItem, self, it.dwId, 1},
		{"<color=yellow>150000 Bạc khóa<color>", self.GetItem, self, it.dwId, 2},
		{"Không mở nữa"},
		};
	Dialog:Say(szMsg, tbOpt);
	return 0;
end

function tbItem:GetItem(nItemId, nType)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	--local nCount= me.GetTask(self.TSK_GROUP, self.TSK_COUNT);
	--if nCount <= 1000 then
	--	Dialog:Say("số lần mở trứng du long hôm nay đã hết.");
	--	return 1;
	--end
	local bIsCanGetCard = 0;
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
	if nCurDate >= 20090921 and nCurDate < 20091011 then
		bIsCanGetCard = 1;
	end
	if bIsCanGetCard == 1 and me.CountFreeBagCell() < 1 then
		Dialog:Say("Hành trang đã đầy, vui lòng thử lại");
		return 0;
	end
	
	if nType == 2 then
		if me.GetBindMoney() + self.DEF_BINDMONEY > me.GetMaxCarryMoney() then
			Dialog:Say("Số tiền được mang đã quá giới hạn, vui lòng thử lại");
			return 0;
		end
	end
	
	if me.DelItem(pItem) == 1 then
		if nType == 1 then
			me.AddBindCoin(self.DEF_BINDCOIN, Player.emKBINDCOIN_ADD_HAPPYEGG);
			me.SendMsgToFriend(string.format("Hảo hữu của bạn[%s] mở trứng du long nhận được %s Đồng khóa", me.szName, self.DEF_BINDCOIN));
			Player:SendMsgToKinOrTong(me, string.format(" mở trứng du long nhận được %s Đồng khóa", self.DEF_BINDCOIN), 1);
			Dbg:WriteLog("happyegg", me.szAccount, string.format("%s mo trung du long nhan %s dong khoa", me.szName, self.DEF_BINDCOIN));
			me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("%s mo trung du long nhan %s dong khoa", me.szName, self.DEF_BINDCOIN));
			KStatLog.ModifyAdd("bindcoin", "[产出]开心蛋开出", "总量", self.DEF_BINDCOIN);
		end
		if nType == 2 then
			me.AddBindMoney(self.DEF_BINDMONEY, Player.emKBINDMONEY_ADD_HAPPYEGG);
			me.SendMsgToFriend(string.format("Hảo hữu của bạn[%s] mở trứng du long nhận được %s Bạc khóa", me.szName, self.DEF_BINDMONEY));
			Player:SendMsgToKinOrTong(me, string.format(" mở trứng du long nhận được %s Bạc khóa", self.DEF_BINDMONEY), 1);
			Dbg:WriteLog("happyegg", me.szAccount, string.format("%s mo trung du long nhan %s bac khoa", me.szName, self.DEF_BINDMONEY));			
			me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("%s mo trung du long nhan %s bac khoa", me.szName, self.DEF_BINDMONEY));		
			KStatLog.ModifyAdd("bindjxb", "[产出]开心蛋开出", "总量", self.DEF_BINDMONEY);
		end
		me.AddKinReputeEntry(2);
		--me.SetTask(self.TSK_GROUP, self.TSK_COUNT, nCount - 1);
		if bIsCanGetCard == 1 then
			local pItem = me.AddItemEx(18,1,402,1, {bForceBind=1}, Player.emKITEMLOG_TYPE_JOINEVENT);
			if pItem then
				me.SetItemTimeout(pItem, 4320, 0);
				pItem.Sync();
			end
		end
		return 1;
	end
	Dbg:WriteLog("happyegg",  string.format("%s mo trung du long", me.szName));
end

function tbItem:OnLoginDay(nUse)
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
	local nCurDay  =Lib:GetLocalDay();
	if me.GetTask(self.TSK_GROUP, self.TSK_DATE) == 0 then
		me.SetTask(self.TSK_GROUP, self.TSK_DATE, nCurDay);
		me.SetTask(self.TSK_GROUP, self.TSK_COUNT, 1);
		return 0;
	end
	
	local nDayCount = nCurDay - me.GetTask(self.TSK_GROUP, self.TSK_DATE);
	if nDayCount <= 0 then
		return 0;
	end
	
	local nDayCount = nDayCount + me.GetTask(self.TSK_GROUP, self.TSK_COUNT);
	if nDayCount > self.DEF_MAXCOUNT then
		nDayCount = self.DEF_MAXCOUNT;
	end
	
	me.SetTask(self.TSK_GROUP, self.TSK_COUNT, nDayCount);
	me.SetTask(self.TSK_GROUP, self.TSK_DATE, nCurDay);
	return 1;
end

PlayerEvent:RegisterOnLoginEvent(tbItem.OnLoginDay, tbItem);
