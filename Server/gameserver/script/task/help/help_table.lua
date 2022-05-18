--動態消息統一管理
--(如不需要，盡量少用動態消息，效率問題。如消息是靜態的，用靜態消息處理。)
--sunduoliang
--2008.11.11

if (MODULE_GC_SERVER) then
Require("\\script\\misc\\gcevent.lua");
end

local tbHelp	= Task.tbHelp or {};
Task.tbHelp		= tbHelp;

-- 動態消息的id: 上限最多32個，超過將會有可能無法存儲和宕機，請節約使用
tbHelp.NEWSKEYID = {
	NEWS_LEVELUP 			= 1, 	--等級上限信息[常規]
	NEWS_MENPAIJINGJI_NEW 	= 2,	--門派新人王[常規]現在聯賽在用，現在還沒時間改
	NEWS_MENPAIJINGJI_DASHIXING = 3,--門派大師兄[常規]
	NEWS_MONEYUSEWAY	= 4, 	-- 劍俠幣獲得途徑的消息id[常規]
	NEWS_LEVELOPENTIME	= 5, 	-- 開放等級上限的消息id[常規]
	NEWS_LUCKCARD 		= 6,	-- 國慶活動 09-10-11過期
	NEWS_WLDH_PROSSESSION 	= 7,	-- 武林大會資格認定
	NEWS_LOTTERY_0909	= 8,   	--9月促銷抽獎
	NEWS_YOULONGMIBAO	= 9,	-- 游龍秘寶
	NEWS_MARRY_SUPER	= 10,	-- 皇家婚禮
	NEWS_MARRY_DAILY	= 11,	-- 每日婚禮
	--NEWS_COLLECTCARD_1	= 7,	--公測活動 11.18過期
	--NEWS_COLLECTCARD_2	= 8,	--公測活動 11.18過期
	--NEWS_COLLECTCARD_3	= 9,	--公測活動 11.18過期
	--NEWS_COLLECTCARD_4	= 10,	--公測活動 11.18過期
	--NEWS_COLLECTCARD_5	= 11,	--金山20周年 11.25過期
	--NEWS_COLLECTCARD_6	= 12,	--金山20周年 11.25過期
	--NEWS_WANGLAOJI_1 	= 13,	--金山20周年 11.25過期
	--NEWS_WANGLAOJI_2 	= 14,	--王老吉防上火行動11.25
	--NEWS_ZHONGQIU 		= 15,	--王老吉延長三周11.25
	NEWS_LEAGUE 		= 16,	--武林聯賽[常規]
	NEWS_LEAGUE_ADV		= 17,	--聯賽八強賽動態戰報[常規]
	NEWS_JINBIFANHUAN	= 18,	--金山20周年 11.25過期 
	NEWS_STARTDOMAIN	= 19,	--領土戰開啟
	NEWS_MENPAI_NEW		= 20,	--門派新人王
	NEWS_BAIBAOXIANG	= 21,	--百寶箱爆機
	NEWS_STATUARY		= 22,	--樹立雕像
	NEWS_DOMAINTASK		= 23,	--霸主任務活動結果揭曉
	NEWS_LOTTERY_0908	= 24,   --8月促銷抽獎
	NEWS_WLDH_1			= 25,	--武林大會單人
	NEWS_WLDH_2			= 26,	--武林大會雙人
	NEWS_WLDH_3			= 27,	--武林大會三人
	NEWS_WLDH_4			= 28,	--武林大會五行五人
	NEWS_WLDH_5			= 29,	--武林大會大型團體賽
	NEWS_GBWLLS_DAILY	= 30,	-- 跨服聯賽每日公告
};

tbHelp.tbDyNews = 
{
	--默認格式
	{
		nKey 		= 0,	--key值，默認為0
		nStartTime 	= 0,	--開啟時間 -年月日時分200810101200，默認為0
		nEndTime 	= 0,	--結束時間 -年月日時分200810101224，默認為0
		nGlobalKey 	= 16,	--默認為開服時間的全局變量
		nStartDay 	= 0,	--開服幾天後開啟（和nLastDay搭配使用），默認為0
		nLastDay 	= 0,	--開啟後持續時間（和nStartDay搭配使用），默認為0
		szTitle		= "",	--標題
		szContent 	= [[	--內容
		]],
	},
	
}

function tbHelp:RegisterDyNews(tbNews)
	if not self.tbDyNews then
		self.tbDyNews = {};
	end
	table.insert(self.tbDyNews, tbNews);
end

function tbHelp:UpdateDyNews()
	for _, tbNews in pairs(self.tbDyNews) do
		local nKey = tonumber(tbNews.nKey) or 0;
		local nStartTime = tonumber(tbNews.nStartTime) or 0;
		local nEndTime = tonumber(tbNews.nEndTime) or 0;
		local nGlobalKey = tonumber(tbNews.nGlobalKey) or DBTASD_SERVER_STARTTIME;
		local nStartDay = tonumber(tbNews.nStartDay) or 0;
		local nLastDay = tonumber(tbNews.nLastDay) or 0;
		local szTitle = tbNews.szTitle;
		local szContent = tbNews.szContent;
		local nAddSec = 0;
		local nEndSec = 0;
		if nStartDay > 0 and nLastDay > 0 then
			nAddSec = KGblTask.SCGetDbTaskInt(nGlobalKey) + nStartDay*24*3600;
			nEndSec = nAddSec + nLastDay * 24 * 3600;
		end
		if nStartTime > 0 then
			nAddSec = Lib:GetDate2Time(nStartTime);
		end
		if nEndTime > 0 then
			nEndSec = Lib:GetDate2Time(nEndTime);
		end
		if nKey > 0 then
			self:SetDynamicNews(nKey, szTitle, szContent, nEndSec, nAddSec);
		end
	end
end

if (MODULE_GC_SERVER) then
	GCEvent:RegisterGCServerStartFunc(Task.tbHelp.UpdateDyNews, Task.tbHelp);
end
