
local tbServer = {};
SpecialEvent.RecommendServer = tbServer;

tbServer.TASK_GOURP_ID 		= 2027;
tbServer.TASK_REGISTER_ID	=	4;
tbServer.TASK_LEVEL_ID 		= 
{
	[30] = 5,
	[40] = 6,
	[50] = 7,
	[60] = 8,
}
tbServer.LEVELSORT = {30, 40, 50, 60}
tbServer.TIME_LAST	= 20;	--持续20天.
tbServer.DIALOGTXT 	=
{
	szRecommed 	= "Tiến cử, xác định đăng ký?",
	szAward 	= nil,
	szAbout		= "Dưới cấp 10 phải đăng ký tham gia nhận thưởng ở chỗ Sứ giả hoạt động. Trong 20 ngày đạt cấp 30, 40, 50, 60 sẽ nhận được phần thưởng tương ứng.",
	szNoAward	= "Thật đáng tiếc, thời gian kết thúc nhận thưởng của bạn là <color=yellow>%s<color>, không thể nhận thưởng.",
	szFinAward	= "Bạn đã nhận tất cả phần thưởng của server mới này", 
	szGetAward	= "Nhận phần thưởng cấp %s",
	szGetAwardFin = "Bạn đã nhận phần thưởng <color=yellow>server mới<color> cấp %s",
	szClose 	= "server mới kết thúc hoạt động, xin lỗi vì bạn không thể đăng ký hoạt động đến với server.",
	szNoFreeBag	= "Xin lỗi, túi của bạn không đủ chỗ."
}
tbServer.AWARD = nil;

tbServer.__AWARD_1 = 
{
	[30] = {nBindCoin = 1000},
	[40] = {tbItem = {21, 5, 1, 1}},
	[50] = {nBindCoin = 3000},
	[60] = {nBindCoin = 6000},
}

tbServer.__AWARD_2 = 
{
	[30] = {nBindMoney = 100000},
	[40] = {nBindCoin = 1000},
	[50] = {nBindCoin = 3000},
	[60] = {nBindCoin = 5000},
}

tbServer.__szAward_1 = string.format("Chào mừng bạn đến với server mới, khi đạt cấp phù hợp, bạn có thể nhận các phần thưởng ở Sứ giả hoạt động các Tân Thủ Thôn:\n   Cấp 30: 1000 %s khóa\n   Cấp 40: Túi 12 ô\n   Cấp 50: 3000 %s khóa\n   Cấp 60: 6000 %s khóa\n   Chú ý: Trong vòng 20 ngày (trước <color=yellow>%%s<color>) đạt đến các cấp trên mới nhận được phần thưởng tương ứng", IVER_g_szCoinName, IVER_g_szCoinName, IVER_g_szCoinName)

tbServer.__szAward_2 = string.format("Chào mừng bạn đến với server mới, khi đạt cấp phù hợp, bạn có thể nhận các phần thưởng ở Sứ giả hoạt động các Tân Thủ Thôn:\n   Cấp 30: 100000 Bạc khóa\n   Cấp 40: 1000 %s khóa\n   Cấp 50: 3000 %s khóa\n   Cấp 60: 5000 %s khóa\n   Chú ý: Trong vòng 20 ngày (trước <color=yellow>%%s<color>) đạt đến các cấp trên mới nhận được phần thưởng tương ứng", IVER_g_szCoinName, IVER_g_szCoinName, IVER_g_szCoinName)

function tbServer:RefreshAward()
	if SpecialEvent:IsWellfareStarted() == 1 then
		self.AWARD = self.__AWARD_2;
		self.DIALOGTXT.szAward = self.__szAward_2;
	else
		self.AWARD = self.__AWARD_1;
		self.DIALOGTXT.szAward = self.__szAward_1;
	end
end

function tbServer:OnDialog(nFlag)
	self:RefreshAward();
	local tbOpt = {};
	if me.GetTask(self.TASK_GOURP_ID, self.TASK_REGISTER_ID) ~= 0 then
		if self:CheckGetAward() == 1 then
			Dialog:Say(self.DIALOGTXT.szFinAward);
			return 0;
		end
		local szDate = os.date("%Y-%m-%d %H:%M:%S", (me.GetTask(self.TASK_GOURP_ID, self.TASK_REGISTER_ID) + 20*86400));	
		if me.GetTask(self.TASK_GOURP_ID, self.TASK_REGISTER_ID) + self.TIME_LAST * 86400 < GetTime() then
			Dialog:Say(string.format(self.DIALOGTXT.szNoAward, szDate));
			return 0;
		end
		if nFlag ~= nil then
			if self.TASK_LEVEL_ID[nFlag] == nil or me.GetTask(self.TASK_GOURP_ID, self.TASK_LEVEL_ID[nFlag]) ~= 0 then
				return 0;
			end
			if self.AWARD[nFlag].tbItem ~= nil then
				if me.CountFreeBagCell() < 1 then
					Dialog:Say(self.DIALOGTXT.szNoFreeBag);
					return 0;
				end
			end
			self:GetAward(nFlag);
			Dialog:Say(string.format(self.DIALOGTXT.szGetAwardFin, nFlag));
			return 0;
		end
		local tbSort = {};
		for nId, nLevel in ipairs(self.LEVELSORT) do
			if self.TASK_LEVEL_ID[nLevel] then
				table.insert(tbSort, {nLevel, self.TASK_LEVEL_ID[nLevel]});
			end
		end
		
		for nId, tbItem in ipairs(tbSort) do
			if me.nLevel >= tbItem[1] then
				if me.GetTask(self.TASK_GOURP_ID, tbItem[2]) == 0 then
					table.insert(tbOpt, {string.format(self.DIALOGTXT.szGetAward, tbItem[1]), self.OnDialog, self, tbItem[1]});
				end
			end
		end

		table.insert(tbOpt, {"Kết thúc đối thoại"});
		Dialog:Say(string.format(self.DIALOGTXT.szAward, szDate), tbOpt);
		return 0;
	end
	if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_RECOMMEND_TIME) == 0 then
		Dialog:Say(self.DIALOGTXT.szClose);
		return 0;
	end	
	if me.GetTask(self.TASK_GOURP_ID, self.TASK_REGISTER_ID) <= KGblTask.SCGetDbTaskInt(DBTASD_SERVER_RECOMMEND_TIME) then
		table.insert(tbOpt, {"Ta muốn đăng ký", self.OnRecommend, self})
		table.insert(tbOpt, {"Xem quy tắc nhận thưởng", self.OnAbout, self});
		table.insert(tbOpt, {"Để ta suy nghĩ đã"})
		Dialog:Say(self.DIALOGTXT.szRecommed, tbOpt);
		return 0;
	end
	Dialog:Say("Bạn đã đăng ký.");
end

function tbServer:OnAbout()
	Dialog:Say(self.DIALOGTXT.szAbout);
end

function tbServer:GetAward(nLevel)
	if self.AWARD[nLevel] == nil then
		return 0;
	end
	if self.TASK_LEVEL_ID[nLevel] == nil or me.GetTask(self.TASK_GOURP_ID, self.TASK_LEVEL_ID[nLevel]) ~= 0 then
		return 0;
	end
	
	me.SetTask(self.TASK_GOURP_ID, self.TASK_LEVEL_ID[nLevel], 1);
	
	if self.AWARD[nLevel].tbItem then
		local pItem = me.AddItem(unpack(self.AWARD[nLevel].tbItem));
		if pItem then
			pItem.Bind(1);
			me.Msg(string.format("Bạn nhận được 1 <color=yellow>%s<color>", pItem.szName))
			Dbg:WriteLog("PlayerEvent.RecommendServer", me.szName..", server mới nhận thưởng thành công: ", pItem.szName);
		else
			Dbg:WriteLog("PlayerEvent.RecommendServer", me.szName..", server mới nhận thưởng thất bại: ", self.AWARD[nLevel].tbItem[1], self.AWARD[nLevel].tbItem[2], self.AWARD[nLevel].tbItem[3], self.AWARD[nLevel].tbItem[4]);
		end
		return 0;
	end
	
	if self.AWARD[nLevel].nBindCoin then
		me.AddBindCoin(self.AWARD[nLevel].nBindCoin, Player.emKBINDCOIN_ADD_EVENT)
		me.Msg(string.format("Chúc mừng bạn nhận được <color=yellow>%s %s khóa<color>", self.AWARD[nLevel].nBindCoin, IVER_g_szCoinName))
		Dbg:WriteLog("PlayerEvent.RecommendServer", me.szName..", server mới nhận thưởng: ", "Coin khóa", self.AWARD[nLevel].nBindCoin);
		KStatLog.ModifyAdd("bindcoin", "[Nơi] Phần thưởng server mới", "Tổng", self.AWARD[nLevel].nBindCoin);
		return 0;
	end
	
	if self.AWARD[nLevel].nBindMoney then
		me.AddBindMoney(self.AWARD[nLevel].nBindMoney, Player.emKBINDMONEY_ADD_EVENT)
		me.Msg(string.format("Chúc mừng bạn nhận được <color=yellow>%s bạc khóa<color>", self.AWARD[nLevel].nBindMoney))
		Dbg:WriteLog("PlayerEvent.RecommendServer", me.szName..", server mới nhận thưởng: ", "Bạc khóa", self.AWARD[nLevel].nBindMoney);
		KStatLog.ModifyAdd("bindjxb", "[Nơi] Phần thưởng server mới", "Tổng", self.AWARD[nLevel].nBindMoney);
		return 0;
	end
end


function tbServer:CheckRecommend()
	if me.GetTask(self.TASK_GOURP_ID, self.TASK_REGISTER_ID) ~= 0 then	
		if me.GetTask(self.TASK_GOURP_ID, self.TASK_REGISTER_ID) + self.TIME_LAST * 86400 <= GetTime() then
			return 0;
		end
		return 1;
	end
	return 0;
end

function tbServer:CheckGetAward()
	for nLevel, nTaskId in pairs(self.TASK_LEVEL_ID) do
		if me.GetTask(self.TASK_GOURP_ID, nTaskId) == 0 then
			return 0;
		end
	end
	return 1;
end

function tbServer:OnRecommend()
	if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_RECOMMEND_TIME) == 0 then
		Dialog:Say(self.DIALOGTXT.szClose);
		return 0;
	end		
	me.SetTask(self.TASK_GOURP_ID, self.TASK_REGISTER_ID, GetTime());
	Dialog:Say("Bạn đã đăng ký thành công.");
end

--nDate格式如(2008-6-25):20080625
function tbServer:SetDate(nDate)
	if string.len(nDate) ~= 8 then
		return
	end
	local nDateTemp = nDate*10000;
	local nSec = Lib:GetDate2Time(nDateTemp);
	if nSec then
		KGblTask.SCSetDbTaskInt(DBTASD_SERVER_RECOMMEND_TIME, nSec);
	end
	return GetLocalDate("%c", nSec);
end

function tbServer:Close()
	KGblTask.SCSetDbTaskInt(DBTASD_SERVER_RECOMMEND_TIME, 0);
	KGblTask.SCSetDbTaskInt(DBTASD_SERVER_RECOMMEND_CLOSE, 0);
	return 0;
end

function tbServer:DayClose()
	local nDate = tonumber(GetLocalDate("%Y%m%d"));
	KGblTask.SCSetDbTaskInt(DBTASD_SERVER_RECOMMEND_CLOSE, nDate);
	self:OnDayClose();
end

function tbServer:OnDayClose()
	local nDate = tonumber(GetLocalDate("%Y%m%d"));
	if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_RECOMMEND_CLOSE) == 0 then
		return 0;
	end
	if nDate > KGblTask.SCGetDbTaskInt(DBTASD_SERVER_RECOMMEND_CLOSE) then
		self:Close();
		return 0;
	end
	if nDate == KGblTask.SCGetDbTaskInt(DBTASD_SERVER_RECOMMEND_CLOSE) then
		local nGetTime =GetLocalDate("%H")*3600 + GetLocalDate("%M")*60 + GetLocalDate("%S");
		local nEndTime = 24 *3600 ;
		local nTime = nEndTime - nGetTime;
		if nTime > 0 then
			Timer:Register(nTime * Env.GAME_FPS, self.Close, self);
		end
	end
	return 0;
end

function tbServer:OnLoginRegister()
	if KGblTask.SCGetDbTaskInt(DBTASD_SERVER_RECOMMEND_TIME) == 0 then
		return 0;
	end
	if me.GetTask(self.TASK_GOURP_ID, self.TASK_REGISTER_ID) == 0 and self:CheckGetAward() == 0 then
		me.SetTask(self.TASK_GOURP_ID, self.TASK_REGISTER_ID, GetTime());
		return 0;
	end
	if me.GetTask(self.TASK_GOURP_ID, self.TASK_REGISTER_ID) < KGblTask.SCGetDbTaskInt(DBTASD_SERVER_RECOMMEND_TIME) and self:CheckGetAward() == 0 then
		me.SetTask(self.TASK_GOURP_ID, self.TASK_REGISTER_ID, GetTime());
	end
	return 0;
end

