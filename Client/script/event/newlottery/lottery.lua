-- 文件名　：lottery.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-09-18 19:12:55
-- 描  述  ：

NewLottery.tbAwardBindCoin ={
	[1] = {needbag=2, item={18,1,496,1}, newitem={18,1,553,1}}, -- 金奖
	[2] = {needbag =1,bindcoin=50000,newbindcoin = 30000, newitem={18,1,564,1}},  -- 银奖
	 -- 铜奖 item 为未开放150级的服的奖品, 新加newitem 为已开放150级的奖品
	[3] = {needbag=1, item={18,1,495,1}, newitem = {18,1,495,2}, },  
};

NewLottery.BASE_BIND_COIN = 4000; -- 基础奖励--绑金
NewLottery.BASE_BIND_MONEY	= 500000; --基础奖励--绑银
NewLottery.FIRST_LOTTERY_DATE = 20100122; -- 活动开启时间
NewLottery.LAST_LOTTERY_DATE = 20100131; -- 最后一天抽奖
NewLottery.AWARD_KEEP_DAY = 3; -- 数据保留3天;最后一天领奖时间3天后清数据

NewLottery.tbAwardName = {[1] = "Vàng", [2] = "Bạc", [3] = "Đồng"};
NewLottery.PERCENT_BRONZE = 0.15; -- 铜奖百分比
NewLottery.PERCENT_SILVER = 0.008; -- 银奖百分比
NewLottery.szNo1Name = "";

NewLottery.RANK_MIN = 1;
NewLottery.RANK_MAX = 5000;

NewLottery.MSG_NOTIFY = "今天的充值抽奖活动将于%s分钟后开启，还没参加抽奖的赶快使用“幸运奖券”参加抽奖啊，大奖等着你！！";

function NewLottery:GetFirstDate()
	return  KGblTask.SCGetDbTaskInt(DBTASD_LOTTERY_STARTTIME);
end

function NewLottery:GetLastDate()
	return  KGblTask.SCGetDbTaskInt(DBTASD_LOTTERY_ENDTIME);
end

function NewLottery:GetName()
	return  KGblTask.SCGetDbTaskStr(DBTASD_LOTTERY_STARTTIME);
end

function NewLottery:CheckCanUseRank()
	local nSec = KGblTask.SCGetDbTaskInt(DBTASD_SERVER_STARTTIME)
	if GetTime() - nSec < 7*24*3600 then
		return 0;
	end
	return 1;
end

-- 玩家使用奖券
function NewLottery:UseTicket(szName, nId)
	if not MODULE_GC_SERVER then
		local pPlayer = KPlayer.GetPlayerObjById(nId);
		if pPlayer then
			pPlayer.AddWaitGetItemNum(1);
			GCExcute({"NewLottery:UseTicket", szName, nId});
		end
	else
		if not self.tbLottery[szName] then
			self.tbLottery[szName] = 1;
		else
			self.tbLottery[szName] = self.tbLottery[szName] + 1;
		end
		
		local nLastPorcessDate = KGblTask.SCGetDbTaskInt(DBTASK_NINE_LOTTERY_DATE);
		local nTime = GetTime();
		local nToday = tonumber(os.date("%Y%m%d", nTime));
		if nLastPorcessDate == nToday then -- 今天抽奖已经出来
			nTime = nTime + 24*60*60; -- 算进后一天
		end
		local nTimeOut = 1;
		if nLastPorcessDate < self:GetLastDate() then
			nTimeOut =0;
			Dbg:WriteLog(string.format("NewLottery:UseTicket, %s %s", szName, os.date("%Y%m%d", nTime)));
		end
		
		GlobalExcute({"NewLottery:UseTicketNotify", nId, nTime, nTimeOut});	
	end
end

function NewLottery:UseTicketNotify(nId, nTime, nTimeOut)
	local pPlayer = KPlayer.GetPlayerObjById(nId);
	if pPlayer then
		pPlayer.AddWaitGetItemNum(-1);
		if nTimeOut == 1 then
			pPlayer.Msg(string.format("抽奖已经结束，谢谢参与。"));
			return 0;
		end
		local szDate = os.date("%Y年%m月%d日", nTime);
		pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "促销抽奖: 使用奖券，奖券进入" .. szDate .. "的抽奖名单");
		pPlayer.Msg(string.format("您使用的奖券已经进入%s的抽奖名单，谢谢参与。", szDate));
	end
end

-- 每天更新数据
function NewLottery:UpdateData()
	local nDate = tonumber(GetLocalDate("%Y%m%d"));
	if nDate < self:GetFirstDate() or nDate > self:GetLastDate() then
		return;
	end
	
	self:RemoveOldAwardTable();
	self:GenerateNewAwardTable();
	KGblTask.SCSetDbTaskInt(DBTASK_NINE_LOTTERY_DATE, nDate);
	self.tbGoldPlayerName[nDate] = self.szNo1Name;
	self:SaveTable();
	
	self:SendMail(nDate);
	self:UpdateHelpSprite(nDate);
	if self.szNo1Name ~= "" then
		local szMsg = string.format("%s在充值抽奖中获得金奖！", self.szNo1Name);
		GlobalExcute({"NewLottery:AnnouceNo1", szMsg});
	end
end

-- 开奖前发公告
function NewLottery:LotteryNotify()
	local nDate = tonumber(os.date("%Y%m%d",GetTime()));
	if nDate < self:GetFirstDate() or nDate > self:GetLastDate() then
		return 0;
	end
	GlobalExcute({"NewLottery:AnnouceNo1", string.format(self.MSG_NOTIFY, 60 - tonumber(GetLocalDate("%M")))});
end

function NewLottery:AnnouceNo1(szMsg)
	KDialog.NewsMsg(1, Env.NEWSMSG_NORMAL, szMsg);
end

-- 删除过期的结果
function NewLottery:RemoveOldAwardTable()
	local nDate = GetTime() - self.AWARD_KEEP_DAY*24*60*60;
	nDate = tonumber(os.date("%Y%m%d", nDate));
	self:__RemoveOldAwardTable(nDate);
	GlobalExcute({"NewLottery:__RemoveOldAwardTable", nDate});
end

function NewLottery:__RemoveOldAwardTable(nCurDate)
	if self.tbAward then
		for nDate in pairs(self.tbAward) do
			if nDate <= nCurDate then
				self.tbAward[nDate] = nil;
			end
		end
	end
end

-- 抽奖
function NewLottery:GenerateNewAwardTable()
	local tbFlat = {}; -- ipars 确保遍历顺序不会改变
	local tbName = {};
	local tbFilterName = {}; -- 不能抽金银奖的玩家
	local tbAwardGold = {};	--能抽奖金的玩家
	local tbAwardGoldEx = {}; --金奖对应到tbFlag中的
	local nFilter = 0;       -- 不能抽金银奖的卡片数
	for szName, nNum in pairs(NewLottery.tbLottery) do
		local nRank = PlayerHonor:GetPlayerHonorRankByName(szName, PlayerHonor.HONOR_CLASS_MONEY, 0);
		if (self:CheckCanUseRank() == 0) or (nRank >= NewLottery.RANK_MIN and nRank<= NewLottery.RANK_MAX) then	
			table.insert(tbName, szName);
			for i = 1, nNum do
				table.insert(tbFlat, #tbName); -- szName索引
				if self:CheckGlodAward(szName) == 0 then		--检测是不是活动期间中过金奖
					table.insert(tbAwardGold, #tbName);		
					table.insert(tbAwardGoldEx,#tbFlat);			
				end
			end					
		else
			tbFilterName[szName] = nNum;
			nFilter = nFilter + nNum;
		end
	end	
	local nCandidateLenth = #tbFlat;
	local nLotteryNum = nCandidateLenth + nFilter;
	local tbAwardNum = {
		[1] = 1,
		[2] = math.max(1, math.ceil(nLotteryNum * self.PERCENT_SILVER)),
		[3] = math.max(1, math.ceil(nLotteryNum * self.PERCENT_BRONZE)),
	};
	local nDate = tonumber(GetLocalDate("%Y%m%d"));
	self.tbAward[nDate] = {};
	self.szNo1Name = "";
	local nSafe = 0;	--安全线,超过10000后不WriteLog,防止宕机
	for nAward, nAwardNum in ipairs(tbAwardNum) do
		 nCandidateLenth = #tbFlat;
		if nAward == 3 then         		--算铜奖要加入因财富荣誉给剔除的玩家
			for szName, nNum in pairs(tbFilterName) do
				table.insert(tbName, szName);
		    		for i = 1, nNum do
					table.insert(tbFlat, #tbName); -- szName索引	
		    		end
			end	
			nCandidateLenth = #tbFlat;
		end		
		for i = 1, nAwardNum do
			if nAward == 1 then
				nCandidateLenth = #tbAwardGold;
			end
			if nCandidateLenth > 0 then
				local nRand = MathRandom(1,nCandidateLenth);
				local szName = "";
				if nAward ~= 1 then
					local nNameIdx = tbFlat[nRand];
					szName = tbName[nNameIdx];
					self:__AddAwardEntry(szName, nAward, 1, nDate);
					GlobalExcute({"NewLottery:__AddAwardEntry", szName, nAward, 1, nDate});
					tbFlat[nRand] = tbFlat[nCandidateLenth];
					table.remove(tbFlat); 
					nCandidateLenth = nCandidateLenth - 1;
				else
					local nNameIdx = tbAwardGold[nRand];
					szName = tbName[nNameIdx];
					self:__AddAwardEntry(szName, nAward, 1, nDate);
					GlobalExcute({"NewLottery:__AddAwardEntry", szName, nAward, 1, nDate});
					tbFlat[tbAwardGoldEx[nRand]] = tbFlat[#tbFlat];
					table.remove(tbFlat); 
					self.szNo1Name = szName;
				end	
				nSafe = nSafe + 1;
				if nSafe < 10000 then
					Dbg:WriteLog(string.format("NewLottery:Result, %s\t%s\t%s", szName, nAward, nDate));
				end
				if nSafe == 10000 then
					Dbg:WriteLog(string.format("NewLottery:ResultIsOver, %s\t%s\t%s", szName, nAward, nDate));					
				end			
			end
		end
	end
	
	self.tbLottery = {};
end

-- 把玩家加入获奖列表
-- nAward: 拿到什么奖
function NewLottery:__AddAwardEntry(szName, nAward, nAwardNum, nDate)
	if not self.tbAward[nDate] then
		self.tbAward[nDate] = {};
	end
	if not self.tbAward[nDate][szName] then
		self.tbAward[nDate][szName] = {};
	end
	if not self.tbAward[nDate][szName][nAward] then
		self.tbAward[nDate][szName][nAward] = nAwardNum;
	else
		self.tbAward[nDate][szName][nAward] = self.tbAward[nDate][szName][nAward] + nAwardNum;
	end
end

-- 获取玩家奖励列表
-- nRes, var
--                  金奖几个  银奖几个  铜奖几个
--     [nDate] --> {[1] = xx, [2] = xx, [3] = xx} 
function NewLottery:GetPlayerAwardList(pPlayer)
	local tbRes = {};
	local nLastProcessDate = KGblTask.SCGetDbTaskInt(DBTASK_NINE_LOTTERY_DATE);
	
	if not MODULE_GC_SERVER then
		if self:GSDataIsValid() == 0 then
			return 0, "数据处理中，请稍候再来查询。";
		end
	end
	
	for nDate, tbAwardInDate in pairs(self.tbAward) do
		if nDate <= nLastProcessDate then -- 只取完整的数据
			tbRes[nDate] = {};
			if tbAwardInDate[pPlayer.szName] then
				local tb = {};
				for nAward, nAwardNum in pairs(tbAwardInDate[pPlayer.szName]) do
					tb[nAward] = nAwardNum;
				end
				tbRes[nDate] = tb;
			end
		end
	end
	
	local nRes = self:__HasAward(tbRes);
	if nRes == 0 then
		return 0, "这次抽奖没有您的得奖记录，谢谢参与。"
	elseif nRes == 1 then
		return 0, "你已经领完所有的奖励了。"
	end
	
	return 1, tbRes;
end


-- 0 无奖励
-- 1 领完了
-- 2 还可以领
function NewLottery:__HasAward(tbRes)
	local hasAward = 0; -- 有奖励
	local hasBeenAward = 0; -- 有奖励，可能已经领过
	
	for nDate, tbAwardInDate in pairs(tbRes) do
		for nAward, nAwardNum in pairs(tbAwardInDate) do
			hasBeenAward = 1;
			if nAwardNum > 0 then
				hasAward = 1;
			end
		end
	end
	
	if hasAward == 1 then
		return 2;
	else
		if hasBeenAward == 1 then
			return 1;
		else
			return 0;
		end
	end
end

-- 领奖
-- nDate: 开奖日期
-- nAward: 获得那种奖励
-- nAwardNum: 领几个奖，例如一人一次领两个银奖
function NewLottery:GetAward(pPlayer, nDate, nAward, nAwardNum)
	--print("GetAward")
	if MODULE_GC_SERVER then
		return;
	end
	
	nDate = tonumber(nDate);
	nAward = tonumber(nAward);
	nAwardNum = tonumber(nAwardNum);
	
	if self.tbAward[nDate][pPlayer.szName][nAward] >= nAwardNum then
		local nNeedBag = (self.tbAwardBindCoin[nAward].needbag or 0)*nAwardNum;
		if pPlayer.CountFreeBagCell() < nNeedBag then
			Dialog:Say(string.format("您的背包空间不足，需要%s格背包空间。", nNeedBag));
			return 0;
		end		
		
		pPlayer.AddWaitGetItemNum(1);
		
		if self.tbAwardBindCoin[nAward].bindcoin then
			if self.tbAwardBindCoin[nAward].newbindcoin and TimeFrame:GetState("OpenLevel150") == 1 then--开放150级开出银奖时是加载30000金币
				local nBindCoin = self.tbAwardBindCoin[nAward].newbindcoin * nAwardNum;
				pPlayer.AddBindCoin(nBindCoin, Player.emKBINDCOIN_ADD_EVENT);
			else
				local nBindCoin = self.tbAwardBindCoin[nAward].bindcoin * nAwardNum;
				pPlayer.AddBindCoin(nBindCoin, Player.emKBINDCOIN_ADD_EVENT);
			end
		end
		
		if self.tbAwardBindCoin[nAward].item then
			if nAward == 3 and TimeFrame:GetState("OpenLevel150") == 1 then -- 如果开放了150级且是铜奖
				for i=1, nAwardNum do
					local pItem = pPlayer.AddItem(unpack(self.tbAwardBindCoin[nAward].newitem));
					if pItem then
						pItem .Bind(1);
						me.SetItemTimeout(pItem, 30*24*60, 0);
						pItem.Sync();
					end
				end	
			elseif nAward == 1 and TimeFrame:GetState("OpenLevel150") == 1 then -- 如果开放了150级且是金奖
				local tbItem = self.tbAwardBindCoin[nAward].newitem;
				for i=1, nAwardNum do
					pPlayer.AddStackItem(tbItem[1],tbItem[2],tbItem[3],tbItem[4],{["bForceBind"] = 1},10000);
				end
			else
				for i=1, nAwardNum do
					local pItem = pPlayer.AddItem(unpack(self.tbAwardBindCoin[nAward].item));
					if pItem then
						pItem .Bind(1);
						me.SetItemTimeout(pItem, 30*24*60, 0);
						pItem.Sync();
					end
				end
			end
		end
		if nAward == 2 and TimeFrame:GetState("OpenLevel150") == 1 then-- 如果开放了150级且是银奖
			for i=1, nAwardNum do
				local pItem = pPlayer.AddItem(unpack(self.tbAwardBindCoin[nAward].newitem));
				if pItem then
					pItem .Bind(1);
					me.SetItemTimeout(pItem, 30*24*60, 0);
					pItem.Sync();
				end
			end
		end
		self:__GetAward(pPlayer.nId, pPlayer.szName, nDate, nAward);
		GlobalExcute({"NewLottery:__GetAward", pPlayer.nId, pPlayer.szName, nDate, nAward});
		GCExcute({"NewLottery:__GetAward", pPlayer.nId, pPlayer.szName, nDate, nAward});
		
		local szLog = string.format("玩家: %s, 领取了%d的%d等奖%d个", pPlayer.szName, nDate, nAward, nAwardNum);
		Dbg:WriteLog("NewLottery:GetAward", szLog);
		pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "促销抽奖:" .. szLog);
		
		local szMsg = string.format("在充值活动中获得了%d个%s", nAwardNum, self.tbAwardName[nAward]);
		Player:SendMsgToKinOrTong(pPlayer, szMsg, 1);
		pPlayer.SendMsgToFriend("您的好友" .. pPlayer.szName .. szMsg);
	end
end

function NewLottery:__GetAward(nId, szName, nDate, nAward)
	if self.tbAward[nDate][szName][nAward] == 0 then
		return;
	end
	
	if not MODULE_GC_SERVER then
		local pPlayer = KPlayer.GetPlayerObjById(nId);
		if pPlayer then
			pPlayer.AddWaitGetItemNum(-1);
		end
	end
	
	self.tbAward[nDate][szName][nAward] = 0;
end

function NewLottery:__date_2_zh(nDate)
	local nTime = Lib:GetDate2Time(nDate);
	return string.format("%d月%d日", tonumber(os.date("%m", nTime)), tonumber(os.date("%d", nTime)));
end


function NewLottery:SendMail(nDate)
	local tbName = {};
	if self.tbAward[nDate] then
		for szName, _ in pairs(self.tbAward[nDate]) do
			table.insert(tbName, szName);
		end
	end
	local szTitle = "恭喜你中奖啦！";
	local szContent  = string.format("你在%s的抽奖活动中获奖啦！快到到礼官那里看看吧！3天之后可就领不到了哦。", 
		self:__date_2_zh(nDate));
	Mail.tbParticularMail:SendMail(tbName, {szTitle = szTitle, szContent = szContent});
	return;
end

-- 用于是否显示领奖选项
function NewLottery:CheckLotteryOpen()
	local nDate = tonumber(GetLocalDate("%Y%m%d"));
	local nSec = Lib:GetDate2Time(self:GetLastDate()) + self.AWARD_KEEP_DAY*24*3600;
	local nEndDate = tonumber(os.date("%Y%m%d", nSec));
	if nDate >= self:GetFirstDate() and nDate <= nEndDate then
		return 1;
	else
		return 0;
	end
end

local function OnSort(tbA, tbB)
	return tbA[2] > tbB[2];
end

function NewLottery:__gen_help_sprite(nDate)
	local szMsg	= [[
<color=red>金奖：<color>
       今日金奖得主：<color=gold>%s<color>
       历史金奖得主：
%s

<color=green>银奖：<color>
       今日银奖得主:<color=yellow>
       %s
      <color>
	]];
	
	local nLastProcessDate = KGblTask.SCGetDbTaskInt(DBTASK_NINE_LOTTERY_DATE);
	local tbNo2Player = {};
	
	for szName, tbPlayerAward in pairs(self.tbAward[nLastProcessDate]) do
		for nAward, nAwardNum in pairs(tbPlayerAward) do
			if nAward == 2 and nAwardNum > 0 then
				table.insert(tbNo2Player, szName);
			end
		end
	end
	local szGoldPlayerName = self.tbGoldPlayerName[nDate] or "<color=gary>金奖轮空<color>";
	if szGoldPlayerName == "" then
		szGoldPlayerName = "<color=gray>金奖轮空<color>";
	end
	local szGoldPlayer = string.format("%s（%s）", szGoldPlayerName, self:__date_2_zh(nDate) or "");
	local tbGoldPlayerHistory = {};
	for nDate, szName in pairs(self.tbGoldPlayerName) do
		local szGName = szName or "";
		if szGName == "" then
			szGName = "<color=gray>金奖轮空<color>";
		end
		table.insert(tbGoldPlayerHistory, {szGName, nDate});
	end
	local szGoldPlayerHistory = "";
	table.sort(tbGoldPlayerHistory, OnSort);
	for _, tbInfo in ipairs(tbGoldPlayerHistory) do
		szGoldPlayerHistory = szGoldPlayerHistory .. string.format("       <color=gold>%s：%s<color>\n", self:__date_2_zh(tbInfo[2]), tbInfo[1])
	end

	if szGoldPlayerHistory == "" then
		szGoldPlayerHistory = "       暂无";
	end
	
	local i = 0;
	local tbSilverPlayer = {};
	local szSilverPlayer = "";
	for _, szPlayerName in ipairs(tbNo2Player) do
		table.insert(tbSilverPlayer, szPlayerName);
		i = i + 1;
		if i == 3 then
			i = 0;
			szSilverPlayer = szSilverPlayer .. table.concat(tbSilverPlayer, "    ") .. "\n       ";
			tbSilverPlayer = {};
		end
	end
	
	szSilverPlayer = szSilverPlayer .. table.concat(tbSilverPlayer, "    ");
	szMsg = string.format(szMsg, szGoldPlayer, szGoldPlayerHistory, szSilverPlayer);
	return szMsg;
end

function NewLottery:UpdateHelpSprite(nDate)
	local szTitle = self:GetName().."优惠中奖名单";
	local szMsg = self:__gen_help_sprite(nDate);
	local nAddTime	= GetTime();
	local nEndTime	= nAddTime + 3600 * 24 * 3;
	Task.tbHelp:SetDynamicNews(Task.tbHelp.NEWSKEYID.NEWS_LOTTERY_0909, szTitle, szMsg, nEndTime, nAddTime);
end

-- 显示获奖情况
function NewLottery:__debug_show_award()
	local szMsg = "";
	for nDate, tbAwardInDate in pairs(self.tbAward) do
		szMsg = szMsg .. nDate .. "\n"
		for szName, tbPlayerAward in pairs(tbAwardInDate) do
			local n1 =  tbPlayerAward[1] or 0;
			local n2 =  tbPlayerAward[2] or 0;
			local n3 =  tbPlayerAward[3] or 0;
			szMsg = szMsg .. szName .. " 1:" .. n1 .. " 2:" .. n2 .. " 3:" .. n3 .. "\n";
		end
	end
	if string.len(szMsg) == 0 then
		szMsg = "无获奖纪录"
	end
	me.Msg(szMsg);
end

-- 显示奖券使用情况
function NewLottery:__debug_show_ticket(var1, var2)
	if not MODULE_GC_SERVER then
		if not var1 then
			GCExcute({"NewLottery:__debug_show_ticket", me.nId});
		else
			local pPlayer = KPlayer.GetPlayerObjById(var1);
			if pPlayer then
				pPlayer.Msg(var2);
			end
		end
	else
		local szMsg = "";
		for szName, nNum in pairs(self.tbLottery) do
			szMsg = szMsg .. szName .. ":" .. nNum .. "\n";
		end
		if string.len(szMsg) == 0 then
			szMsg = "无人投票"
		end
		GlobalExcute({"NewLottery:__debug_show_ticket", var1, szMsg});
	end
end

function NewLottery:__debug_clear_record()
	if not MODULE_GC_SERVER then
		self.tbAward = {};
		GCExcute({"NewLottery:__debug_clear_record"});
	else
		for nBufId, szTblName in pairs(self.tbBufId2TblName) do
			self[szTblName] = {};
		end
		self:SaveTable();
	end
end

function NewLottery:__debug_load_lottery_record(szPath)
	self.tbLottery = {};
	local tbData = Lib:LoadTabFile(szPath);
	for i = 2, #tbData do
		local szName = assert(tbData[i]["name"]);
		local nNum = assert(tbData[i]["num"]);
		nNum = tonumber(nNum);
		self.tbLottery[szName] = nNum;
	end
end

function NewLottery:CheckGlodAward(szName)
	local nCount = self:GetLastDate() - self:GetFirstDate();
	for  i = 1,  nCount do
		if self.tbGoldPlayerName[self:GetFirstDate() + i -1] and self.tbGoldPlayerName[self:GetFirstDate() + i -1] == szName then		
			return 1;
		end
	end
	return 0;
end

--?pl DoScript("\\script\\event\\lottery\\lottery.lua")