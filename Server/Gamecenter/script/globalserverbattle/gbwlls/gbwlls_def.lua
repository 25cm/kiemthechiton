--全局武林联赛
--zhouchenfei
--2009-12-16 15:37:34

Require("\\script\\mission\\wlls\\wlls_def.lua")

GbWlls.IsOpen = 1; -- 开启标志，做手动关闭用

GbWlls.GTASK_MACTH_SESSION		= Wlls.GTASK_MACTH_SESSION;
GbWlls.GTASK_MACTH_STATE		= Wlls.GTASK_MACTH_STATE;
GbWlls.DEF_STATE_CLOSE			= Wlls.DEF_STATE_CLOSE;
GbWlls.DEF_STATE_REST			= Wlls.DEF_STATE_REST;
GbWlls.DEF_STATE_MATCH			= Wlls.DEF_STATE_MATCH;
GbWlls.DEF_STATE_ADVMATCH		= Wlls.DEF_STATE_ADVMATCH;
GbWlls.GTASK_STARSERVERFLAG		= DBTASD_GBWLLS_STARSERVER_RANK;		--明星服务器标记
GbWlls.GTASK_STARSERVERFLAG_TIME= DBTASD_GBWLLS_STARSERVER_RANK_TIME;	--明星服务器标记
GbWlls.GTASK_MAX_GUESS_TICKET	= DBTASD_GBWLLS_GUESS_MAX_TICKET;

-- 跨服玩家变量
GbWlls.GBTASKID_GROUP				= 2;		-- 跨服变量组
GbWlls.GBTASKID_SESSION				= 1;		-- 记录玩家参加的全局服务器的联赛的届数
GbWlls.GBTASKID_MATCH_LEVEL			= 2;		-- 记录玩家参加的全局服务器的联赛等级
GbWlls.GBTASKID_MATCH_RANK			= 3;		-- 记录玩家参加的全局服务器联赛排名
GbWlls.GBTASKID_MATCH_WIN_AWARD		= 4;		-- 玩家单场胜场奖励
GbWlls.GBTASKID_MATCH_TIE_AWARD		= 5;		-- 玩家单场平场奖励
GbWlls.GBTASKID_MATCH_LOSE_AWARD	= 6;		-- 玩家单场负场奖励
GbWlls.GBTASKID_MATCH_FINAL_AWARD	= 7;		-- 玩家最终奖励
GbWlls.GBTASKID_MATCH_ADVRANK		= 8;		-- 记录玩家参加的全局服务器联赛八强赛排名
GbWlls.GBTASKID_MATCH_TYPE_PAREM	= 9;		-- 记录跨服联赛一些重要信息，比如门派赛的报名门派，比如五行赛的报名五行
GbWlls.GBTASKID_MATCH_DAILY_RESULT	= 10;		-- 记录跨服联赛玩家是否赢得比赛的时间

-- 跨服服务器变量
GbWlls.GBTASK_GROUP					= 2;		-- 跨服全局变量组
GbWlls.GBTASK_SESSION				= 11;		-- 记录全局服务器联赛届数
GbWlls.GBTASK_FIRSTOPENTIME			= 12;		-- 记录全局服务器第一届联赛时间
GbWlls.GBTASK_MATCH_STATE			= 13;		-- 记录跨服联赛状态
GbWlls.GBTASK_MATCH_RANK			= 14;		-- 是否排名完的标志


GbWlls.TASKID_GROUP					= 2111;		-- 任务变量组
GbWlls.TASKID_MONEY_RANK			= 1;		-- 财富荣誉排名
GbWlls.TASKID_WLLS_RANK				= 2;		-- 联赛排名
GbWlls.TASKID_MATCH_SESSION			= 3;		-- 奖励的的联赛届数
GbWlls.TASKID_MATCH_WIN_AWARD		= 4;		-- 玩家单场胜场奖励
GbWlls.TASKID_MATCH_TIE_AWARD		= 5;		-- 玩家单场平场奖励
GbWlls.TASKID_MATCH_LOSE_AWARD		= 6;		-- 玩家单场负场奖励
GbWlls.TASKID_MATCH_FINAL_AWARD		= 7;		-- 玩家最终奖励
GbWlls.TASKID_MATCH_FIRST			= 8;		-- 冠军数量
GbWlls.TASKID_MATCH_SECOND			= 9;		-- 银军数量
GbWlls.TASKID_MATCH_THIRD			= 10;		-- 亚军数量
GbWlls.TASKID_MATCH_BEST			= 11;		-- 最好名次
GbWlls.TASKID_AWARD_LOG				= 12;		-- 最终领取奖励log，（届数(3位) + 奖励段（3位） * 1000 + 初级高级类型（1位） * 1000000）
GbWlls.TASKID_ENTERFLAG				= 13;		-- 通过正常途径会纪录标记
GbWlls.TASKID_STATUARY_TYPE			= 14;		-- 雕像的标记
GbWlls.TASKID_GETFINALAWARD_TIME	= 15;		-- 记录领取最终奖励的时间
GbWlls.TASKID_PRAY_TIME				= 16;		-- 记录玩家祈福时间，每天一次
GbWlls.TASKID_STARSERVER_FLAG		= 17;		-- 明星服务器领取奖励标记
GbWlls.TASKID_GUESS_SESSION			= 18;		-- 竞猜的届数
GbWlls.TASKID_GUESS_PLAYER_FLAG1	= 19;		-- 玩家投票记录，所投玩家
GbWlls.TASKID_GUESS_PLAYER_COUNT1	= 20;		-- 所投票数
GbWlls.TASKID_GUESS_PLAYER_FLAG2	= 21;
GbWlls.TASKID_GUESS_PLAYER_COUNT2	= 22;
GbWlls.TASKID_GUESS_PLAYER_FLAG3	= 23;
GbWlls.TASKID_GUESS_PLAYER_COUNT3	= 24;

GbWlls.DEF_ZONESERVERCOUNT	= 1;

GbWlls.MACTH_PRIM			= 1;		--初级联赛
GbWlls.MACTH_ADV			= 2;		--高级联赛

GbWlls.DEF_MAXGBWLLS_MONEY_RANK = 200;	-- 参加跨服武林联赛的最低财富排名
GbWlls.DEF_MAXGBWLLS_WLLS_RANK = 150;	-- 参加跨服武林联赛的最低联赛荣誉排名

GbWlls.DEF_ADV_MAXGBWLLS_MONEY_RANK = 200;	-- 参加跨服高级武林联赛的最低财富排名
GbWlls.DEF_ADV_MAXGBWLLS_WLLS_RANK = 150;	-- 参加跨服高级武林联赛的最低联赛荣誉排名

GbWlls.DEF_OPENGBWLLSSESSION	= 4; 	-- 允许开启跨服联赛的届数是4届
GbWlls.DEF_MIN_PLAYERLEVEL		= 100;	-- 允许参加跨服联赛的等级

GbWlls.SEASON_TB 			= GbWlls.SEASON_TB 			or {};		--联赛表
GbWlls.AWARD_LEVEL 			= GbWlls.AWARD_LEVEL 		or {};		--奖励分层
GbWlls.MACTH_ENTER_FLAG 	= GbWlls.MACTH_ENTER_FLAG 	or {};		--玩家进入比赛场标志
GbWlls.AWARD_FINISH_LIST  	= GbWlls.AWARD_FINISH_LIST 	or {[GbWlls.MACTH_PRIM]={}, [GbWlls.MACTH_ADV] ={}};		--最终奖励表
GbWlls.AWARD_SINGLE_LIST  	= GbWlls.AWARD_SINGLE_LIST 	or {[GbWlls.MACTH_PRIM]={}, [GbWlls.MACTH_ADV] ={}};		--单场奖励表

GbWlls.DEF_OPEN_MONTH		= {1, 4, 7, 10}; -- 跨服联赛开启的月份

GbWlls.DEF_SEND_MAIL_DAY	= 1;
GbWlls._DEF_MATCHLEVEL_CHANGETIME = 20100129;

GbWlls.DEF_ADV_PK_STARTDAY	= 29;
GbWlls.DEF_ADV_GUESS_TICKET_ENDTIME	= 19;

-- 开了新大区需要维护
GbWlls.tbZoneName	= {
	[1] = {"青龙区", 1},
	[2]	= {"白虎区", 2},
	[3]	= {"朱雀区", 3},
	[4]	= {"玄武区", 4},
	[5]	= {"紫薇区", 5},
	[6]	= {"北斗区", 6},
	[7]	= {"金麟区", 7},
	[10]	= {"吉祥区", 8},
	[11]	= {"如意区", 9},
};

GbWlls.MAIL_JOINGBWLLS = {
	szTitle		= "Liên đấu liên server %s", 
	szContent	= "\"Liên đấu liên server lần %s\" lại được diễn ra! Liên đấu liên server lần này là <color=yellow>%s<color>, từ <color=yellow>%s27/7 các vị anh hùng có thể liên tục tranh tài với nhau, %s 8 đội mạnh sẽ quyết chiến với nhau<color>! <color=green>Xin chúc mừng bạn đã nhận được quyền tham gia<color>, hãy đến <color=orange>Lâm An<color><link=npcpos:Báo danh Liên đấu liên server,0,3718>, sau đó đến Anh Hùng đảo báo danh thi đấu! ",
};

GbWlls.MAIL_JOINGBWLLS_ADV = {
	szTitle		= "Liên đấu liên server %s_Tứ kết", 
	szContent	= "Anh Hùng quả thật là cao thủ của cao thủ! Xin chúc mừng bạn đã lọt vào Tứ kết Liên Server <color=green>%s<color>! Thi đấu sẽ tiếp tục vào <color=yellow>%s_ %s <color>, danh hiệu vô địch đang chờ bạn!",
};

GbWlls.MSG_JOIN_SUCCESS_FOR_ALL = "<color=yellow>%s<color> đã báo danh tham gia liên đấu liên server lần %s_ <color=yellow>%s<color>!  Mau đến <color=yellow>Lâm An, cạnh chỗ Liên đấu liên server đánh trống<color> cổ vũ chúc phúc cho chiến hữu!";
GbWlls.MSG_JOIN_SUCCESS_FOR_MY	= "Bạn đã báo danh thành công, sẽ tham gia liên đấu liên server lần thứ %s__%s! và sẽ được người chơi toàn server chúc phúc!";

GbWlls.MSG_MATCH_RESULT_COMMON_FACTION		= "%s trong liên đấu liên server lần %sm hiện môn phái %s đang xếp thứ %s!";
GbWlls.MSG_MATCH_RESULT_ADV_FINAL_RESULT_1	= "Server %s do %s thành chiến đội %s trong Liên đấu lần %s giành được %s %s! ";
GbWlls.MSG_MATCH_RESULT_ADV_FACTION_2		= "%s trong liên đấu liên server lần %s giành được môn phái %s hạng %s!";

GbWlls.MSG_MATCH_TIME_GLOBALMSG_COMMON		= "<color=yellow>\"Liên đấu liên server lần %s\"<color> long trọng khai màn. Lần này <color=yellow>%s, tháng %s từ 7-27 tiến hành đấu vòng tròn<color>. Các vị Đại hiệp mau đi <color=yellow>Lâm An<color> cạnh <color=yellow>Quan Liên đấu<color> đánh trống để cổ vũ chúc phúc cho chiến hữu!";
GbWlls.MSG_MATCH_TIME_GLOBALMSG_ADV			= "<color=yellow>Liên đấu liên server lần %s<color> đã bước vào giai đoạn gay cấn, 8 tuyển thủ mạnh nhất môn phái toàn cụm sẽ quyết đấu vào <color=yellow>%s<color>!";
GbWlls.MSG_MATCH_TIME_GLOBALMSG_STAR		= "Liên đấu liên server <color=yellow>lần %s<color> đã kết thúc thành công, tổng số điểm của server này được xếp trong danh sách <color=yellow>4 đội mạnh nhất %s<color>, được danh hiệu <color=yellow>\"Server Minh Tinh\"<color>, đó là vinh dự của toàn thể người chơi trong server, mau đến Lâm An-Trống liên đấu liên server nhận ánh sáng vinh dự!";

GbWlls.MSG_8RANK_GUESS	= [[    Đơn đấu môn phái liên server đã kết thúc, 8 người mạnh nhất đã xuất hiện. Chọn vào tên người tham gia có thể tìm hiểu thông tin tuyển thủ này.

    Giờ ngươi có thể cổ vũ người mà ngươi cho là mạnh nhất, ngươi chỉ có 1 cơ hội, nếu người ngươi chọn cuối cùng đoạt giải quán quân ngươi cũng sẽ nhận được <color=gold>Rương Liên đấu liên server<color> danh hiệu <color=gold>"Fans cuồng nhiệt"<color> và duy trì <color=gold>Vòng sáng rực rỡ<color> 1 tuần. Thời gian ngừng bỏ phiếu là <color=green>19 giờ 29/04<color>, không nên để lỡ cơ hội!

    Và hiệp khách được sự cổ vũ nhiều nhất trong 12 môn phái cũng sẽ nhận được danh hiệu thần bí và vòng sáng 1 tháng.
]]; -- 八强竞猜对话提示

GbWlls.MSG_STARPLAYER	= "Chúc mừng <color=yellow>%s<color> trở thành tuyển thủ nhận được sự cổ vũ nhiều nhất trong Liên đấu liên server <color=yellow>cụm %s<color>!";

GbWlls.JOIN_TITLE = {6,23,1,0};

GbWlls.DEF_PRAY_MIN_LEVEL				= 69;		-- 送祝福最低等级
GbWlls.DEF_PRAY_MIN_PRESTIGE			= 200;		-- 送祝福最低威望
GbWlls.DEF_PRAY_MIN_MONEY_HONOR_RANK	= 5000;		-- 送祝福最低财富荣誉排名

GbWlls.DEF_ITEM_LUCK_GBWLLS_CARD		= {18,1,912,1}; -- 幸运刮刮卡
GbWlls.DEF_ITEM_WINGUESS				= {18,1,913,1};		-- 幸运刮刮卡胜利奖励宝箱
GbWlls.DEF_ITEM_STAR_FLOWER				= {18,1,914,1}; -- 明星服务器礼花

GbWlls.DEF_GUESS_MIN_PRESTIGE_RANK		= 5000;		-- 竞猜最低名次要求

GbWlls.DEF_NOT_OPEN_LUCKCARD_TIME_START	= 15;
GbWlls.DEF_NOT_OPEN_LUCKCARD_TIME_END	= 22;		-- 开刮刮卡时间，比赛期每天22点后才能开刮刮卡

GbWlls.DEF_ITEM_LOSTGUESS				= {18,1,80,1}; -- 幸运刮刮卡玩家竞猜失败的奖励
GbWlls.DEF_ITEM_LOSTGUESS_COUNT			= 2;	-- 数量

GbWlls.DEF_ITEM_WINGUESS8RANK			= {18,1,553,1};	-- 游龙古币
GbWlls.DEF_ITEM_LOSTGUESS8RANK			= {18,1,80,1}; -- 幸运刮刮卡玩家竞猜失败的奖励
GbWlls.DEF_ITEM_LOSTGUESS8RANK_COUNT	= 2;	-- 数量


GbWlls.DEF_ITEM_GUESS					= {18,1,476,1};	-- 竞猜需要的物品
GbWlls.DEF_COUNT_MAX_GUESS				= 10;	-- 一次性投票最多能投10个

GbWlls.DEF_ITEM_WINGUESS_COUNT			= 1;

GbWlls.tbMatchPlayerList				= {};		-- 本服保存已经报名参加跨服联赛的玩家爱
GbWlls.tb8RankInfo						= {};		-- 大区前八名玩家

GbWlls.DEF_MAX_NUM_MONEY_HONOR			= 1000;		-- 取1000名财富荣誉玩家
GbWlls.DEF_MAX_NUM_WLLS_HONOR			= 1000;		-- 取1000名联赛荣誉玩家


GbWlls.DEF_INDEX_GBWLLS_8RANK_LEAGUENAME	= 1;
GbWlls.DEF_INDEX_GBWLLS_8RANK_MAPTYPE 		= 2;
GbWlls.DEF_INDEX_GBWLLS_8RANK_GATEWAY 		= 3;
GbWlls.DEF_INDEX_GBWLLS_8RANK_WIN 			= 4;
GbWlls.DEF_INDEX_GBWLLS_8RANK_TIE 			= 5;
GbWlls.DEF_INDEX_GBWLLS_8RANK_TOTAL 		= 6;
GbWlls.DEF_INDEX_GBWLLS_8RANK_RANK 			= 7;
GbWlls.DEF_INDEX_GBWLLS_8RANK_ADVRANK		= 8;
GbWlls.DEF_INDEX_GBWLLS_8RANK_TIME			= 9;
GbWlls.DEF_INDEX_GBWLLS_8RANK_ADVID			= 10;
GbWlls.DEF_INDEX_GBWLLS_8RANK_MATCHTYPE		= 11;

GbWlls.DEF_DAY_STARSERVER_1	= 20;	-- 礼花活动持续时间
GbWlls.DEF_DAY_STARSERVER_2	= 20;	-- 礼花活动持续时间
GbWlls.DEF_DAY_STARSERVER_3	= 10;	-- 礼花活动持续时间
GbWlls.DEF_DAY_STARSERVER_4	= 5;	-- 礼花活动持续时间

GbWlls.DEF_MAX_NUM_GUESS_TICKET				= 1000;	-- 每个人对一个人最多能投1000票

GbWlls.DEF_NUM_PER_TICKET		= 3; -- 每个投注获3个游龙古币
GbWlls.DEF_TIME_MSG_MAX_COUNT	= 6; -- 每次放6编
GbWlls.DEF_TIME_MSG_TIME		= 10 * 60; -- 10分钟一次
GbWlls.DEF_TIME_SEND_JOINMAIL	= 5 * 60;

GbWlls.IsOpenEvent1	= 1;	-- 是否跨服联赛活动
GbWlls.IsOpenEvent2	= 1;	-- 是否开启幸运卡活动
GbWlls.IsOpenEvent3	= 1;	-- 是否开启八强竞猜活动

GbWlls.DEF_STARPLAYER_FAC_TITLE	= {12, 10};
GbWlls.DEF_STARFANS_TITLE	= {6,24,1,0};

GbWlls.DEF_STARNUM = 4;

GbWlls.DEF_TIME_SAVE_GBWLLSBUF	= 10 * 60;
GbWlls.DEF_TIME_ADV_STARTMSG	= 25;
