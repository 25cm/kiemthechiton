-------------------------------------------------------------------
--File: globaltaskdef.lua
--Author: lbh
--Date: 2007-7-12 14:23
--Describe: 脚本全局任务变量定义
-------------------------------------------------------------------
--暂时去掉全局变量保护，后面恢复
local mTable = getmetatable(_G)
setmetatable(_G, {})

if (MODULE_GAMECLIENT) then	------- 客户端模拟KGblTask
	KGblTask	= {};
end

------------------------------全局GblIntBuf定义Start-----------------------------------------
GBLINTBUF_HELPNEWS			= 	1;	--帮助锦囊buf
GBLINTBUF_COMPENSATE_GM		= 	2;	--GM离线指令buf
GBLINTBUF_GIRL_VOTE			=	3;	--第一美女评选
GBLINTBUF_DOMAINSTATUARY	=	4;	--领土二期雕像buf
GBLINTBUF_GIRL_VOTE2		= 	5;	--第一美女评选决赛
GBLINTBUF_LOTTERY_200908  	=	6;  --09年8月促销抽奖活动
GBLINTBUF_IBSHOP			=   7;  -- 奇珍阁物品上下架状态
GBLINTBUF_KINGEYES_EVENT	=   8;  -- 在线运营活动存档
GBLINTBUF_WLDH_MEMBER		=	9;	--武林大会资格认定
GBLINTBUF_LOTTERY_200909	=  	10;  --09年9月促销抽奖活动
GBLINTBUF_ARREST_LIST		=  	11;  -- 批量关天牢
GBLINTBUF_BLACKLIST			= 	12;	--非法刷道具玩家及其所得道具名单
GBLINTBUF_MAIL_LIST			=  	13;  -- 批量邮件
GBLINTBUF_VIP_TRANSFER		=  	14;  -- Vip转服数据
GBLINTBUF_QUEST_PLIAYERLIST	=  	15;  -- 调查问卷名单
GBLINTBUF_MARRY				= 	16;	-- 结婚系统
GBLINTBUF_PROPOSAL			=	17;	-- 解除求婚关系
GBLINTBUF_IBSHOP_CMDBUF		=	18;	-- 奇珍阁在线修改指令buf
GBLINTBUF_MARRY_COZONE		= 	19;	-- 婚期合服备份
GBLINTBUF_GBWLLS_FINALPLAYERLIST = 20; -- 八强战队信息，包括成员名
GBLINTBUF_Tong_Vote			= 21;	-- 帮会选举
GBLINTBUF_PRESENDCARD		= 22; --定制礼包
------------------------------全局GblIntBuf定义End-----------------------------------------


------------------------------存储并同步的全局任务变量----------------------------------
DBTASD_EVENT_SPRINGFRESTIVAL_VOWNUM = 0; --新年活动许愿树全局次数(以后不可以使用0)
DBTASK_KIN_VOTE = 1	--记录本月家族竞选启动是否已执行
DBTASK_TONG_WEEKLY = 2 --记录帮会周任务时为第几周
DBTASK_TONG_VOTE = 3 --记录本月帮会竞选启动是否已执行
DBTASK_HuangJinZhiZhong_MapId = 4

DBTASK_HELPNEWS_TITLE	= 5;	-- 帮助锦囊—最新消息—标题（对外内测临时）
DBTASK_HELPNEWS_MSG1	= 6;	-- 帮助锦囊—最新消息—内容1（对外内测临时）
DBTASK_HELPNEWS_MSG2	= 7;	-- 帮助锦囊—最新消息—内容2（对外内测临时）
DBTASK_HELPNEWS_MSG3	= 8;	-- 帮助锦囊—最新消息—内容3（对外内测临时）
DBTASK_HELPNEWS_TIME	= 9;	-- 帮助锦囊—最新消息—激活时间（对外内测临时）

DBTASK_TRADE_TAX_JOUR_NUM 	= 10		-- 交易税周流水号
DBTASK_TRADE_CUR_TAX 		= 11		-- 本周收税金额
DBTASK_TRADE_UNIT_WEL 		= 12		-- 最小单元福利金额
DBTASK_TRADE_MIN_UNIT 		= 13		-- 申请福利的最小单元数（不同福利档次的玩家占最小单元数不同）

DBTASD_EVENT_FENGCEPRICE  = 14   	---封测奖励活动的开关
DBTASD_EVENT_CHANGESERVER = 15  	---移民转服,记移出服务器.

DBTASD_SERVER_STARTTIME   = 16		--记录开服时间(格式:GetTime);
-- 提醒：改变等级上限的时候必须要及时通知程序修改离线托管模块中的等级信息表
DBTASD_SERVER_SETMAXLEVEL79   = 17		--记录开启79级时间(格式:GetTime);
DBTASD_SERVER_SETMAXLEVEL89   = 18		--记录开启89级时间(格式:GetTime);
DBTASD_SERVER_SETMAXLEVEL99   = 19		--记录开启99级时间(格式:GetTime); 
-- 提醒：改变等级上限的时候必须要及时通知程序修改离线托管模块中的等级信息表
DBTASD_SERVER_RECOMMEND_TIME   	= 20		--推荐服务器开启时间(格式：GetTime);
DBTASD_SERVER_RECOMMEND_CLOSE	= 21		--推荐服务器当天24点自动关闭标志;

DBTASK_KIN_WEEKLY = 22			-- 家族周维护

--盛夏活动（按标记可重用，现标记为0）
DBTASD_EVENT_COLLECTCARD_RANDOM = 23		--盛夏活动，随机卡奖励;
DBTASD_EVENT_COLLECTCARD_FINISH = 24		--盛夏活动，集齐所有卡片的玩家数量;
DBTASD_EVENT_COLLECTCARD_BELT01 = 25	--盛夏活动，黄金令牌随机第几人;
DBTASD_EVENT_COLLECTCARD_BELT02 = 26	--盛夏活动，白银令牌随机第几人;
DBTASD_EVENT_COLLECTCARD_BELT03 = 27	--盛夏活动，白银令牌随机第几人;
DBTASD_EVENT_COLLECTCARD_BELT_COUNT = 28	--盛夏活动，五环腰带令牌第几人领取;
DBTASD_EVENT_COLLECTCARD_RANK01	= 29;		--收集卡片排名1
DBTASD_EVENT_COLLECTCARD_RANK02	= 30;		--收集卡片排名2
DBTASD_EVENT_COLLECTCARD_RANK03	= 31;		--收集卡片排名3
DBTASD_EVENT_COLLECTCARD_RANK04	= 32;		--收集卡片排名4
DBTASD_EVENT_COLLECTCARD_RANK05	= 33;		--收集卡片排名5
DBTASD_EVENT_COLLECTCARD_RANK06	= 34;		--收集卡片排名6
DBTASD_EVENT_COLLECTCARD_RANK07	= 35;		--收集卡片排名7
DBTASD_EVENT_COLLECTCARD_RANK08	= 36;		--收集卡片排名8
DBTASD_EVENT_COLLECTCARD_RANK09	= 37;		--收集卡片排名9
DBTASD_EVENT_COLLECTCARD_RANK10	= 38;		--收集卡片排名10
DBTASD_EVENT_COLLECTCARD_RANDOM_DAY = 39	--盛夏活动，随机卡奖励,记录改天随机;
DBTASD_EVENT_COLLECTCARD_RANDOM_DAY = 40	--盛夏活动，使用标记，可清除重用，现标记为0;

--王老吉活动使用排名20名（可重用，现标记为0）
DBTASD_EVENT_SORT01 = 41		--排名
DBTASD_EVENT_SORT02 = 42		--排名
DBTASD_EVENT_SORT03 = 43		--排名
DBTASD_EVENT_SORT04 = 44		--排名
DBTASD_EVENT_SORT05 = 45		--排名
DBTASD_EVENT_SORT06 = 46		--排名
DBTASD_EVENT_SORT07 = 47		--排名
DBTASD_EVENT_SORT08 = 48		--排名
DBTASD_EVENT_SORT09 = 49		--排名
DBTASD_EVENT_SORT10 = 50		--排名
DBTASD_EVENT_SORT11 = 51		--排名
DBTASD_EVENT_SORT12 = 52		--排名
DBTASD_EVENT_SORT13 = 53		--排名
DBTASD_EVENT_SORT14 = 54		--排名
DBTASD_EVENT_SORT15 = 55		--排名
DBTASD_EVENT_SORT16 = 56		--排名
DBTASD_EVENT_SORT17 = 57		--排名
DBTASD_EVENT_SORT18 = 58		--排名
DBTASD_EVENT_SORT19 = 59		--排名
DBTASD_EVENT_SORT20 = 60		--排名
DBTASD_EVENT_SORT21 = 61		--排名
DBTASD_EVENT_KEEP01	= 62		--保留记录
DBTASD_EVENT_KEEP02	= 63		--保留记录
DBTASD_EVENT_KEEP03	= 64		--保留记录
DBTASD_EVENT_KEEP04	= 65		--保留记录
DBTASD_EVENT_KEEP05	= 66		--保留记录
DBTASD_EVENT_KEEP06	= 67		--保留记录
DBTASD_EVENT_KEEP07	= 68		--保留记录
DBTASD_EVENT_KEEP08	= 69		--保留记录
DBTASD_EVENT_KEEP09	= 70		--保留记录
DBTASD_EVENT_KEEP10	= 71		--保留记录
DBTASD_EVENT_SORT_SIGN = 72		--重用标记

DBTASD_EVENT_PRESIGE_RESULT = 73 -- 威望排序结果

DBTASD_EVENT_QQSHOW = 74 -- QQShow激活码发放状态
DBTASD_EVENT_GONGCE_YANHUA = 75 -- 公测烟花激活，记录时间Time
DBTASD_EVENT_GONGCE_RABBIT = 76 -- 公测财宝兔激活，记录时间Time
DBTASD_EVENT_GONGCE_PAYAWARD = 77 -- 公测充值送礼激活，记录时间Time
DBTASD_SERVER_SETMAXLEVEL200 = 78 --记录开启150级时间(格式:GetTime); 
DBTASD_SERVER_SETMAXLEVEL150 = 201 
--联赛使用--
DBTASD_WIIS_SESSION 	= 79	--联赛届数
DBTASD_WIIS_STATE		= 80	--联赛阶段(间歇期,比赛期);
DBTASD_WIIS_MAP_STATE 	= 81	--联赛赛场满人状态
DBTASD_WIIS_LASTSESSION = 82	--上届比赛届数，记录排名使用，防止出现排序进行中时换届


DBTASD_WIIS_RANK		= 83	--武林联赛排名标志

DBTASD_LADDER_MODIFYOLDLADDER = 84 -- 记录是否已经执行了更换新排行榜的指令 
DBTASD_EVENT_TEMP_01 = 85		--临时记录(王老吉增加周头名);

DBTASD_HONOR_LADDER_TIME	= 86	-- 上次荣誉排行的排行时间GetTime()

DBTASD_UI_FUN_SWITCH	= 87	-- 客户端功能开关

-- 领土争夺战
DBTASK_DOMAIN_BATTLE_NO	= 88	-- 领土争夺战流水编号

DBTASK_COZONE_TIME = 89		-- 合并服务器时间
DBTASK_SERVER_STARTTIME_DISTANCE = 90		-- 合并的2个服务器的开服时间差值
DBTASK_COZONE_DOMAIN_BATTLE_NO = 91		-- 合并服务器时主服的领土战号
DBTASD_WLDH_TYPE	= 92	--比赛类型
DBTASK_XOYOGAME_WEIGHT = 93				--记录逍遥谷卡片的权值(更新得分用)
DBTASK_YOULONGMIBAO_COUNT = 94			--游龙密窑服务器累加次数
DBTASK_YOULONGMIBAO_BIG_AWARD = 95		--游龙秘宝5级以上大奖累计次数


-- 非绑银兑换
DBTASK_COIN_EXCHANGE_PAYER = 100		-- 上月平均在线付费玩家
DBTASK_COIN_EXCHANGE_PAYER_RECENT = 101 -- 最近在线付费总人数
DBTASK_COIN_EXCHANGE_RECENT_MONTH = 102 -- 最后统计的月份
DBTASK_COIN_EXCHANGE_PRESTIGE = 103		-- 威望排序
DBTASK_COIN_EXCHANGE_PAYER_RECENT_DAYS = 104 -- 当前统计天数
DBTASK_OFFICIAL_MAINTAIN_NO = 105 			 -- 官衔维护流水号
DBTASK_FACTION_LIMIT				= 115;  -- 多修上限
DBTASK_BAIBAOXIANG_CAICHI	= 116;		-- 彩池银币数量

DBTASK_XOYO_FINAL_LADDER_MONTH = 117; -- 逍遥录最终排行月份
DBTASK_GREAT_MEMBER_VOTE_NO = 118		-- 帮会评优流水号
DBTASK_STATS_KEY = 119;					-- 潜在流失标准统计控制开关
DBTASK_WEIWANG_WEEK = 120;				-- 这是那个星期的威望排行
DBTASK_GIRL_VOTE_MAX = 121;				-- 美女评选报名,压力控制(最多报名玩家数)
DBTASK_BAZHUZHIYIN_MAX = 122;			-- 领取争夺战，缴纳霸主之印最多的玩家姓名和数量
DBTASK_DOMAINTASK_OPENTIME = 123;		-- 开门任务开启时间点 -- by zhangjinpin@kingsoft
DBTASK_DOMAIN_BATTLE_STEP = 124;		-- 领土战步骤: 0-未开启, 1-领土一期, 2-开门任务进行中, 3-领土二期....
DBTASK_COIN_EXCHANGE_PAYER_EXCHANGE_COUNT = 125 -- 每周服务器绑银换银两的人数；
DBTASK_COIN_EXCHANGE_PAYER_EXCHANGE_DATE = 126 -- 记录刷新人数上限的日期
DBTASK_STATS_ACTIVITY_KEY = 127			-- 角色参与活动总次数记录的开关
DBTASK_KIN_WEEKLYACTION_NO = 128		-- 家族周目标维护流水号
DBTASK_LOTTERY_DATE = 129               -- 八月促销抽奖数据处理完成时间
DBTASK_NATIONAL_DAY_CLEAR_DATE = 130	-- 09国庆清除以前雪仗数据时间

DBTASK_WLDH_PROSSESSION = 131;			-- 武林资格认定
DBTASK_NINE_LOTTERY_DATE = 132              -- 九月促销抽奖数据处理完成时间

DBTASD_EVENT_SESSION		= 133;	--比赛届数
DBTASD_EVENT_LASTSESSION	= 134;	--上届比赛届数，记录排名使用，防止出现排序进行中时换届
DBTASD_EVENT_STATE			= 135;	--比赛阶段(0,未开启, 1间歇期,2.比赛期第一阶段,3.比赛期第二阶段 4.八强赛期)
DBTASD_EVENT_MAP_STATE		= 136;	--准备场满人状态（0，未满，1已满）
DBTASD_EVENT_RANK			= 137;	--是否已排名完成标志
DBTASD_EVENT_MAX_SCORE_FOR_NEXT = 138;	--第120名
DBTASD_LOTTERY_STARTTIME = 139;	--促销抽奖开始时间和名字(例：一月份抽奖)
DBTASD_LOTTERY_ENDTIME = 140;	--促销抽奖结束时间
DBTASD_GBWLLS_STARSERVER_RANK = 141;	-- 明星服务器标记
DBTASD_GBWLLS_STARSERVER_RANK_TIME = 142; -- 标记明星服务器时间
DBTASD_GBWLLS_GUESS_MAX_TICKET = 143; -- 跨服联赛最多投票数和这个人名
DBTASD_EVENT_ZHENZAI_VOWNUM = 144; --赈灾全服次数

------------------------------不存储但同步的全局任务变量--------------------------------


-- 宋金战场用100~199
DBTASK_BATTLE_PLCNT_LEVEL1_SONG1	= 100;	-- 记录：人数+1	（即：1为无人、0为未开启）
DBTASK_BATTLE_PLCNT_LEVEL1_JIN1		= 101;
DBTASK_BATTLE_PLCNT_LEVEL2_SONG1	= 102;
DBTASK_BATTLE_PLCNT_LEVEL2_JIN1		= 103;
DBTASK_BATTLE_PLCNT_LEVEL3_SONG1	= 104;
DBTASK_BATTLE_PLCNT_LEVEL3_JIN1		= 105;
DBTASK_BATTLE_PLCNT_LEVEL1_SONG2	= 106;	-- 记录：人数+1	（即：1为无人、0为未开启）
DBTASK_BATTLE_PLCNT_LEVEL1_JIN2		= 107;
DBTASK_BATTLE_PLCNT_LEVEL2_SONG2	= 108;
DBTASK_BATTLE_PLCNT_LEVEL2_JIN2		= 109;
DBTASK_BATTLE_PLCNT_LEVEL3_SONG2	= 110;
DBTASK_BATTLE_PLCNT_LEVEL3_JIN2		= 111;
DBTASK_BATTLE_PLCNT_LEVEL1_SONG3	= 112;	-- 记录：人数+1	（即：1为无人、0为未开启）
DBTASK_BATTLE_PLCNT_LEVEL1_JIN3		= 113;
DBTASK_BATTLE_PLCNT_LEVEL2_SONG3	= 114;
DBTASK_BATTLE_PLCNT_LEVEL2_JIN3		= 115;

-- 武林大会 by zhangjinpin
DBTASK_WLDH_BATTLE_SONG1 	= 121;
DBTASK_WLDH_BATTLE_SONG2 	= 122;
DBTASK_WLDH_BATTLE_SONG3 	= 123;
DBTASK_WLDH_BATTLE_SONG4 	= 124;
DBTASK_WLDH_BATTLE_JIN1 	= 125;
DBTASK_WLDH_BATTLE_JIN2 	= 126;
DBTASK_WLDH_BATTLE_JIN3 	= 127;
DBTASK_WLDH_BATTLE_JIN4 	= 128;
DBTASK_WLDH_BATTLE_SONG5	= 129;
DBTASK_WLDH_BATTLE_SONG6	= 130;
DBTASK_WLDH_BATTLE_JIN5		= 131;
DBTASK_WLDH_BATTLE_JIN6		= 132;


DBTASK_XISUIDAO_PLAYER				= 200; -- 洗髓岛在线人数


------------------------------不同步也不存储的任务变量----------------------------------




--恢复全局变量保护
setmetatable(_G, mTable)

---- 需要同步客户端的变量（暂时只支持key为数值型） ----
GblTask.tbSyncReg	= {
	DBTASD_SERVER_STARTTIME,
	DBTASD_UI_FUN_SWITCH,
	DBTASD_WIIS_SESSION,
	DBTASK_COZONE_TIME,
	DBTASK_TRADE_TAX_JOUR_NUM,
	DBTASK_BAIBAOXIANG_CAICHI, -- by zhangjinpin@kingsoft
	DBTASK_DOMAINTASK_OPENTIME,
	DBTASK_DOMAIN_BATTLE_STEP,
	DBTASK_DOMAIN_BATTLE_NO,
	DBTASD_EVENT_PRESIGE_RESULT,
	DBTASD_EVENT_COLLECTCARD_RANDOM,
	DBTASD_EVENT_SESSION,
	DBTASD_EVENT_STATE,
};

