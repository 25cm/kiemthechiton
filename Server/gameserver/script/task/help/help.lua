-- 文件名　：help.lua
-- 創建者　：FanZai
-- 創建時間：2008-03-13 12:52:48

Require("\\script\\task\\help\\help_table.lua")
local tbHelp	= Task.tbHelp or {};	-- 支持重載
Task.tbHelp		= tbHelp;

tbHelp.TSKG_SNEWSTIME	= 2018;		--幫助錦囊-靜態最新消息激活時間
tbHelp.TSKG_SNEWSREAD	= 2019;		--幫助錦囊-靜態最新消息閱讀標記,bit型
tbHelp.TSKG_DNEWSREAD	= 2035;		--幫助錦囊-動態最新消息閱讀標記,記錄時間

tbHelp.NEWSBUFID	= 1;

if (not tbHelp.tbMenPaiNew) then
	tbHelp.tbMenPaiNew = {};
end

if (not tbHelp.tbMenPaiDa) then
	tbHelp.tbMenPaiDa = {};
end

-- 靜態消息的id
tbHelp.NEWSID_ONLEVELUP	= {
	[10]	= 1010,
	[12]	= 1012,
	[20]	= 1020,
	[25]	= 1025,
	[30]	= 1030,
	[50]	= 1050,
	[60]	= 1060,
	[69]	= 1069,
	[70]	= 1070,
	[90]	= 1090,
	[100]	= 1100,
	[120]	= 1120,
};

-- 當gameserver連接到gamecenter上時做的處理
function Task:OnNotifyHelp(nConnectId)
	Task.tbHelp:OnRecConnectMsg(nConnectId);
	SpecialEvent.CompensateGM:OnRecConnectMsg(nConnectId);	--在線補償指令﹔
	Domain.tbStatuary:OnRecConnectEvent(nConnectId);
	GCEvent:OnRecConnectEvent(nConnectId);
end

-- 收到連接的消息，進行數據加載
function tbHelp:OnRecConnectMsg(nConnectId)
	-- 向gameserver發送數據
	if (self.tbNewsList) then
		for key, tbNewsInfo in pairs(self.tbNewsList) do
			if (tbNewsInfo) then
				self:WriteLog("OnRecConnectMsg", nConnectId, tbNewsInfo.nKey, tbNewsInfo.szTitle);
				GSExcute(nConnectId, {"Task.tbHelp:ReceiveNewsInfo", tbNewsInfo});
			end
		end
	end
end

-- 從數據庫中加載動態消息
function tbHelp:LoadDynamicNewsGC()
	-- 如果gamecenter中消息的數據不存在先加載數據
	self.tbNewsList = {};
	local tbNewsList = GetGblIntBuf(self.NEWSBUFID, 0, 0);
	if (tbNewsList and type(tbNewsList) == "table") then
		self.tbNewsList = tbNewsList;
	end
	self:_SetOrgLevelNews();
	self:_AddMoneyUseNews();
	self:WriteLog("LoadDynamicNewsGC", "Load success");
end

-- 增加金幣獲得途徑消息
function tbHelp:_AddMoneyUseNews()
	local tbAddTime		= {
		year 	= 2008,
		month	= 7,
		day		= 8,
		hour	= 14,
		min		= 0,	
	};
	local nAddTime	= Lib:GetSecFromNowData(tbAddTime);

	local nAddFlag = 0;
	if (not self.tbNewsList[self.NEWSKEYID.NEWS_MONEYUSEWAY]) then
		nAddFlag = 1;
	else
		local tbNewsInfo	= self.tbNewsList[self.NEWSKEYID.NEWS_MONEYUSEWAY];
		if (tbNewsInfo.nAddTime and tbNewsInfo.nAddTime > 0) then
			if (tbNewsInfo.nAddTime < nAddTime) then
				nAddFlag = 1;
			end
		else
			nAddFlag = 1;
		end
	end
	if (nAddFlag == 1) then
		local szTitle	= "Làm sao nhận được bạc";
		local szMsg		= "Cách có được bạc không khóa trong Kiếm Thế:\nHoàn thành <color=yellow>Nhiệm vụ nghĩa quân<color> và có <color=yellow>bản đồ kho báu<color>.\n\n" .. 
						"<color=yellow>Nhiệm vụ nghĩa quân<color>\nNhận ở chỗ Bao Vạn Đồng tại Thành thị và Tân Thủ Thôn, hoàn thành 10 nhiệm vụ sẽ nhận được khoảng <color=yellow>10000<color> bạc không khóa.\n\n" .. 
						"<color=yellow>Bản đồ kho báu<color>\nHoàn thành 10 Nhiệm vụ nghĩa quân mỗi ngày sẽ nhận được 1 Bản đồ kho báu, đào tại nơi chỉ định theo thuyết minh trên bản đồ, sẽ nhận được bạc không khóa và có thể đào ra mê cung, hoàn thành sẽ được <color=yellow>100000 hoặc 120000 bạc không khóa<color>.\n";
		local nEndTime	= nAddTime + 3600 * 24 * 7;
		self:SetDynamicNews(self.NEWSKEYID.NEWS_MONEYUSEWAY, szTitle, szMsg, nEndTime, nAddTime);
	end
end

-- 更新等級上限消息
function tbHelp:UpdateLevelOpenTimeNews(nLevelOpenId, nLevel)
	local nId = self.NEWSKEYID.NEWS_LEVELOPENTIME;
	local nTime	= KGblTask.SCGetDbTaskInt(nLevelOpenId);
	-- 如果存在這條消息
	if (self.tbNewsList[nId]) then
		if (nTime > self.tbNewsList[nId].nAddTime) then -- 表示不是同一個消息
			self:SetLevelOpenTimeNews(nId, nTime, nLevel);
		end
	else -- 如果不存在這條消息
		self:SetLevelOpenTimeNews(nId, nTime, nLevel);
	end
end

-- 設置等級上限消息
function tbHelp:SetLevelOpenTimeNews(nKey, nTime, nLevel)
	local nAddTime	= nTime;
	local nEndTime	= GetTime() + 3600 * 24 * 7;
	local szTime	= os.date("<color=Yellow>%m - %d<color>", nTime);
	local szTitle	= string.format("Đẳng cấp nhân vật cao nhất đã mở đến cấp %d", nLevel);
	local szMsg		= string.format("<color=yellow>Server<color> trong %s mở nhân vật giới hạn đến cấp <color=yellow>%d<color>", szTime, nLevel);
	self:WriteLog("SetLevelOpenTimeNews", szTitle, szTime, GetTime());
	self:SetDynamicNews(nKey, szTitle, szMsg, nEndTime, nAddTime);
end

-- 設置盛夏活動
function tbHelp:SetLuckCardNews(szCard, nAddTime, nEndTime, nTime)
	if szCard == nil then
		return 0;
	end
	local szTime	= os.date("%m - %d", nTime);
	local szTitle	= string.format("%s hạng mục may mắn hoạt động Quốc Khánh", szTime);
	local szMsg		= string.format("<color=yellow>%s<color> Hạng mục may mắn hoạt động Quốc Khánh: <color=yellow>%s<color>\n\nTất cả Thẻ đoàn viên đã giám định hôm nay-<color=yellow>%s<color> đều có thể sử dụng phần thưởng hạng mục may mắn\n\nPhần thưởng: \n<color=yellow>50000 Bạc khóa\n500 Đồng khóa<color>\n\nĐối với thẻ hoạt động Thịnh Hạ không trúng giải có thể trực tiếp đổi thưởng, sử dụng thẻ này sẽ tự động thu thập thẻ hoạt động Thịnh Hạ trong sổ tay thu thập.",szTime, szCard, szCard);
	self:WriteLog("SetLuckCardNews", szTitle, szTime, GetTime());
	self:SetDynamicNews(self.NEWSKEYID.NEWS_LUCKCARD, szTitle, szMsg, nEndTime, nAddTime);
end

-- 設置盛夏活動信息
function tbHelp:SetCollectCardNews(nAddTime, nEndTime, szTitle, szMsg, nKey)
	local tbTemp = 
	{
		[1] = self.NEWSKEYID.NEWS_COLLECTCARD_1,
		[2] = self.NEWSKEYID.NEWS_COLLECTCARD_2,
		[3] = self.NEWSKEYID.NEWS_COLLECTCARD_3,
		[4] = self.NEWSKEYID.NEWS_COLLECTCARD_4,
		[5] = self.NEWSKEYID.NEWS_COLLECTCARD_5,
		[6] = self.NEWSKEYID.NEWS_COLLECTCARD_6,
	}
	self:WriteLog("SetLuckCardNews", szTitle, szTime, GetTime());
	self:SetDynamicNews(tbTemp[nKey], szTitle, szMsg, nEndTime, nAddTime);
end

function tbHelp:_SetOrgLevelNews()
	local nEndTime	= KGblTask.SCGetDbTaskInt(DBTASK_HELPNEWS_TIME); 
	local nAddTime	= nEndTime - 3600 * 24 * 3;
	local szTitle	= KGblTask.SCGetDbTaskStr(DBTASK_HELPNEWS_TITLE);
	local szMsg		= KGblTask.SCGetDbTaskStr(DBTASK_HELPNEWS_MSG1) .. KGblTask.SCGetDbTaskStr(DBTASK_HELPNEWS_MSG2)
			.. KGblTask.SCGetDbTaskStr(DBTASK_HELPNEWS_MSG3);
	if (szTitle ~= "" and szMsg ~= "") then
		self:SetDynamicNews(self.NEWSBUFID, szTitle, szMsg, nEndTime, nAddTime);
		KGblTask.SCSetDbTaskStr(DBTASK_HELPNEWS_TITLE, "");
		KGblTask.SCSetDbTaskStr(DBTASK_HELPNEWS_MSG1, "");
		KGblTask.SCSetDbTaskStr(DBTASK_HELPNEWS_MSG2, "");
		KGblTask.SCSetDbTaskStr(DBTASK_HELPNEWS_MSG3, "");
		KGblTask.SCSetDbTaskInt(DBTASK_HELPNEWS_TIME, 0);
	end
end

-- 獲得靜態消息閱讀標記
function tbHelp:GetSNewsReaded(nNewsId)
	local bReaded	= me.GetTaskBit(self.TSKG_SNEWSREAD, nNewsId);
	return bReaded;
end

-- 設置靜態消息的閱讀標記
function tbHelp:SetSNewsReaded(nNewsId)
	local nTime	= me.SetTaskBit(self.TSKG_SNEWSREAD, nNewsId, 1);
	return nTime;
end

-- 獲得動態消息的閱讀標記
function tbHelp:GetDNewsReaded(nNewsId)
	local nTime	= me.GetTask(self.TSKG_DNEWSREAD, nNewsId);
	if (self.tbNewsList and self.tbNewsList[nNewsId]) then
		local nNewsTime = self.tbNewsList[nNewsId].nAddTime;
		if (nTime >= nNewsTime) then
			return 1;
		end
	end
	return 0;
end

-- 設置動態消息的閱讀標記
function tbHelp:SetDNewsReaded(nNewsId)
	local nNewsTime = self.tbNewsList[nNewsId].nAddTime;
	me.SetTask(self.TSKG_DNEWSREAD, nNewsId, nNewsTime);
end

-- 清除閱讀標記(測試用的)
function tbHelp:ClearNewsReaded()
	me.ClearTaskGroup(self.TSKG_SNEWSREAD, 1);
	me.ClearTaskGroup(self.TSKG_DNEWSREAD, 1);
end

-- 獲取靜態消息閱讀時間
function tbHelp:GetSNewsTime(nNewsId)
	local nTime	= me.GetTask(self.TSKG_SNEWSTIME, nNewsId);
	return nTime;
end

-- 激活靜態消息的時間
function tbHelp:ActiveSNews(nNewsId)
	local nNowTime	= GetTime();
	me.SetTask(self.TSKG_SNEWSTIME, nNewsId, nNowTime);
end

--== 服務端 ==--
-- 增加動態消息，增加前必須確定消息的id是否正確，每個消息的id是唯一的
function tbHelp:AddDNews(nKey, szTitle, szMsg, nEndTime, nAddTime)
	self:SetDynamicNews(nKey, szTitle, szMsg, nEndTime, nAddTime);
end

-- 保存動態消息 這個是不同步的保存
function tbHelp:SaveDynamicNews(tbNewsList)
	SetGblIntBuf(self.NEWSBUFID, 0, 0, tbNewsList);
end

-- 設置動態消息內容
function tbHelp:SetDynamicNews(nKey, szTitle, szMsg, nEndTime, nAddTime)
	self:WriteLog("tbHelp:SetDynamicNews", nKey, szTitle, szMsg, nEndTime, nAddTime);
	if (MODULE_GAMESERVER) then -- 如果是gameserver就向gamecenter發送數據
		GCExcute({"Task.tbHelp:SetDynamicNews", nKey, szTitle, szMsg, nEndTime, nAddTime});
	end
	if (MODULE_GC_SERVER) then -- 如果是gamecenter就直接處理 
		local tbNewsInfo = {
				nKey 			= nKey,
				szTitle 		= szTitle,
				nAddTime		= nAddTime,
				nEndTime		= nEndTime,
				szMsg			= szMsg, 
			};
			
		self.tbNewsList[nKey] = tbNewsInfo;
		self:SaveDynamicNews(self.tbNewsList);
		GlobalExcute({"Task.tbHelp:ReceiveNewsInfo", tbNewsInfo});
	end
end

function tbHelp:ReceiveNewsInfo(tbNewsInfo)
	self:WriteLog("Get The Dynamic new nKey: , szTitle:  ", tbNewsInfo.nKey, tbNewsInfo.szTitle);
	if (not self.tbNewsList) then
		self.tbNewsList = {};
	end
	self.tbNewsList[tbNewsInfo.nKey] = tbNewsInfo;
	local tbPlayerList	= KPlayer.GetAllPlayer();
	for _, pPlayer in ipairs(tbPlayerList) do
		pPlayer.CallClientScript({"Task.tbHelp:OnUpdateNews", tbNewsInfo});
	end
end

function tbHelp:GetDNewsTime(nNewsId)
	if (self.tbNewsList and self.tbNewsList[nNewsId]) then
		return self.tbNewsList[nNewsId].nAddTime; 
	end
	return 0;
end

function tbHelp:ClearDNews()
	KGblTask.SCSetDbTaskInt(DBTASK_HELPNEWS_TIME, 0); 
	
	GlobalExcute({"Task.tbHelp:UpdateAll"});
end

function tbHelp:OnLevelUp(nLevel)
	local nNewsId	= self.NEWSID_ONLEVELUP[nLevel];
	if (nNewsId) then
		self:ActiveSNews(nNewsId);
	end

	if (nLevel == 69 and self:GetDNewsTime(self.NEWSKEYID.NEWS_LEVELUP) == 0)  then
		local szTitle	= string.format("%s đạt cấp 69 đầu tiên!", me.szName);
		local szMsg		= string.format("Võ lâm cao thủ đạt cấp 69 đầu tiên đã xuất hiện\nHọ tên: <color=gold>%s<color>\nGiới tính: <color=gold>%s<color>\nNhánh môn phái: <color=gold>%s<color>\nTổng thời gian lên mạng: <color=gold>%.1f<color> giờ",
			me.szName, Player.SEX[me.nSex], Player:GetFactionRouteName(me.nFaction, me.nRouteId), me.nOnlineTime / 3600);
		local nNowTime 	= GetTime(); 
		local nEndTime	= nNowTime + 3600 * 24 * 3;
		self:AddDNews(self.NEWSKEYID.NEWS_LEVELUP, szTitle, szMsg, nEndTime, nNowTime);
	end
end

-- 玩家登陸的時候處理
function tbHelp:OnLogin()
	if (not self.tbNewsList) then
		return;
	end
	for key, tbValue in pairs(self.tbNewsList) do
		if (tbValue) then
			me.CallClientScript({"Task.tbHelp:OnUpdateNews", tbValue});
		end
	end
end


function tbHelp:WriteLog(...)
	if (MODULE_GAMESERVER) then
		Dbg:WriteLogEx(Dbg.LOG_INFO, "Task", "Help", unpack(arg));
	end
	if (MODULE_GC_SERVER) then
		Dbg:Output("Task", "Help", unpack(arg));
	end
end


-- TODO: REOMVE zhengyuhua 臨時消息 一周後刪掉
if MODULE_GC_SERVER then
	function tbHelp:SetLinShiNews()
		local szHelp = [[
  <color=yellow>Điều chỉnh giới hạn đẳng cấp tham gia thi đấu môn phái<color>
  
  Từ hôm nay, sau Liên đấu, từ <color=yellow>ngày 1~7<color> mỗi tháng server sẽ tổ chức thi đấu môn phái, nhân vật cấp 100 trở lên có thể tham gia
  
  Đồng thời, số người tham gia thi đấu môn phái sẽ giảm từ 16 xuống còn <color=yellow> 8 <color> người


		]]
		if not self.tbNewsList[self.NEWSKEYID.NEWS_STARTDOMAIN] then
			local nAddTime = GetTime();
			local nEndTime = nAddTime + 3600 * 24 * 7;
			-- 暫時使用領土戰消息的ID~用完記得刪掉
			self:SetDynamicNews(self.NEWSKEYID.NEWS_STARTDOMAIN, "Điều chỉnh giới hạn đẳng cấp tham gia thi đấu môn phái", szHelp, nEndTime, nAddTime);
		end
	end
	GCEvent:RegisterGCServerStartFunc(Task.tbHelp.SetLinShiNews, Task.tbHelp);
end


--== 客戶端 ==--

if (MODULE_GAMECLIENT) then
	if (not tbHelp.tbNewsList) then
		tbHelp.tbNewsList = {};
	end
end

function tbHelp:OnUpdateNews(tbNewsInfo)
	if (not self.tbNewsList) then
		self.tbNewsList = {};
	end
	self.tbNewsList[tbNewsInfo.nKey] = tbNewsInfo;
end

if (MODULE_GAMESERVER) then	-- GS專用
	-- 注冊事件回調
	PlayerEvent:RegisterGlobal("OnLevelUp", tbHelp.OnLevelUp, tbHelp);
	PlayerEvent:RegisterGlobal("OnLogin", tbHelp.OnLogin, tbHelp);
end
