-------------------------------------------------------------------
--File		: kingame_def.lua
--Author	: zhengyuhua
--Date		: 2008-5-13 10:24
--Describe	: 家族关卡定义脚本
-------------------------------------------------------------------

local preEnv = _G	--保存旧的环境
setfenv(1, KinGame)	--设置当前环境为Kin

MAX_WEEK_DEGREE	= 2;		-- 周最大次数

FIX_NPC = 1;
DIF_NPC = 2;
COPY_NPC = 3;

-- 副本地图模板ID
MAP_TEMPLATE_ID = 273

GAME_MAX_TIME			= 2 * 3600 * 18 
MAX_GAME 				= 30;		-- 一个城市的最大副本数
MIN_PLAYER				= 6;		-- 参加副本的最小人数
TASK_GROUP_ID 			= 2028;		-- 斗场任务变量groupid
TASK_BAG_ID 			= 1; 		-- 钱袋任务变量
TASK_USED_NUM			= 2;
TASK_WEEK_ID			= 3;
MAX_MIYAO_LIMIT_ITEM 	= 3; 		-- 每个迷药刷出最大个数 
MAX_BAOXIANG 			= 5; 		-- 每个房间刷的最大古铜币宝箱数
NPCID_BAOXIANG 			= 2960; 	-- 古铜币宝箱Id
MAX_GUQIANBI			= 1000;		-- 最大古钱币存储量
KIN_REPUTE_CAMP			= 4;
KIN_REPUTE_CALSS		= 1;
KEY_ITME_TIME			= 10;
PAY_GUQIANBI			= 5;		--返回选择间所需要古钱币

GOU_HUN_YU_COST			= {50, 150, 300}; 	-- 换取勾魂玉的古银币数

GOU_HUN_YU_ITEM			= {18,1,146}		-- 勾魂玉道具
OPEN_KEY_ITEM = {18, 1, 106, 1, {bForceBind = 1, bTimeOut = 1}} 	-- 钥匙道具
QIANDAI_ITEM = {18, 1, 98, 1}		-- 钱袋道具
ZHENCHANGBAOXIANG_ITEM = {18, 1, 109, 1}		-- 马穿山的珍藏宝箱

FIGHTSTATE_POS = {1642,3191}	--入口状态状态转换传入点

REPUTE_SHOP_ID =
{
	[1] = 77, -- 少林
	[2] = 78, --天王掌门
	[3] = 79, --唐门掌门
	[4] = 81, --五毒掌门
	[5] = 83, --峨嵋掌门
	[6] = 84, --翠烟掌门
	[7] = 86, --丐帮掌门
	[8] = 85, --天忍掌门
	[9] = 87, --武当掌门
	[10] = 88, --昆仑掌门
	[11] = 80, --明教掌门
	[12] = 82, --大理段氏掌门
}

ENTER_POS = 
{
	{51552 / 32,	102592 / 32},
	{51680 / 32,	102720 / 32},
	{51552 / 32,	102944 / 32},
	{51392 / 32,	102752 / 32},
	{51648 / 32,	103072 / 32},
	{51808 / 32,	102880 / 32},
}
LEAVE_POS =
{	
	[26] = {1514, 3123},
	[25] = {1726, 3245},
	[29] = {1718, 4090},
	[24] = {1954, 3571},
	[28] = {1602, 3359},
	[27] = {1666, 3260},
	[23] = {1648, 3185},
}
DEATH_REV_POS_FIRST = {};

-- FIX_NPC, nTimeLock, nNumLock, nNpcIdx...
-- DIF_NPC, nTimeLock, nNumLock, nOnceNum, nDegree, nFrequency, nBoss

tbRoom = 
{
	[1] = 
	{
		{FIX_NPC, 10 * 60* 18, 1, 1, 2, 3},
	},
	[2] = 
	{
		{DIF_NPC, 2 * 60 * 18, 30, 15, 2, 60 * 18, 2},
	},
	[3] = 
	{
		{DIF_NPC, 0, 0, 24, 1, 0},
		{FIX_NPC, 0, 4, 1},
	},
	[4] = 				-- 反弹
	{
		{FIX_NPC, 0, 1, 1, 2},
		{DIF_NPC, 0, 30, 6, 5, 60 * 18},
	},
	[5] = 				-- 小BOSS
	{
		{FIX_NPC, 0, 0, 1},
		{DIF_NPC, 0, 1, 1, 1, 0},
	},
	[6] = 				-- 眩晕
	{
		{FIX_NPC, 0, 1, 1, 2},
		{DIF_NPC, 0, 30, 6, 5, 60 * 18},
	},
	[7] = 				-- 天
	{
		{DIF_NPC, 0, 12, 12, 1, 0, 2},
		{FIX_NPC, 0, 1, 1},
	},
	[8] = 				-- 地
	{
		{DIF_NPC, 0, 12, 12, 1, 0, 2},
		{FIX_NPC, 0, 1, 1},
	},
	[9] = 				-- 日
	{
		{DIF_NPC, 0, 12, 12, 1, 0, 2},
		{FIX_NPC, 0, 1, 1},
	},		
	[10] = 				-- 月
	{
		{DIF_NPC, 0, 12, 12, 1, 0, 2},
		{FIX_NPC, 0, 1, 1},
	},
	[11] = 				-- 青龙
	{
		{DIF_NPC, 0, 12, 12, 1, 0, 2},
		{FIX_NPC, 0, 1, 1},
	},
	[12] = 				-- 白虎
	{
		{DIF_NPC, 0, 12, 12, 1, 0, 2},
		{FIX_NPC, 0, 1, 1},
	},
	[13] = 				-- 朱雀
	{
		{DIF_NPC, 0, 12, 12, 1, 0, 2},
		{FIX_NPC, 0, 1, 1},
	},
	[14] = 				-- 玄武
	{
		{DIF_NPC, 0, 12, 12, 1, 0, 2},
		{FIX_NPC, 0, 1, 1},
	},
	[15] = 				-- 密码1
	{
		{DIF_NPC, 0, 12, 12, 1, 0, 2},
		{FIX_NPC, 0, 1, 1},
	},
	[16] = 				-- 密码2
	{
		{DIF_NPC, 0, 12, 12, 1, 0, 2},
		{FIX_NPC, 0, 1, 1},
	},
	[17] = 				-- 密码3
	{
		{DIF_NPC, 0, 12, 12, 1, 0, 2},
		{FIX_NPC, 0, 1, 1},
	},
	[18] = 				-- 密码4
	{
		{DIF_NPC, 0, 12, 12, 1, 0, 2},
		{FIX_NPC, 0, 1, 1},
	},
	[19] = 				-- 密码5
	{
		{DIF_NPC, 0, 12, 12, 1, 0, 2},
		{FIX_NPC, 0, 1, 1},
	},
	[20] = 				-- 密码6
	{
		{DIF_NPC, 0, 12, 12, 1, 0, 2},
		{FIX_NPC, 0, 1, 1},
	},
	[21] = 				-- 密码7
	{
		{DIF_NPC, 0, 12, 12, 1, 0, 2},
		{FIX_NPC, 0, 1, 1},
	},
	[22] = 				-- 密码8
	{
		{DIF_NPC, 0, 12, 12, 1, 0, 2},
		{FIX_NPC, 0, 1, 1},
	},
	[23] = 				-- 地雷
	{
		{FIX_NPC, 0, 1, 1},
		{DIF_NPC, 0, 25, 5, 5, 60 * 18},
	},
	[24] = 				-- 复制
	{
		{FIX_NPC, 0, 1, 1},
		{COPY_NPC},
	},
	[25] = 				-- 极速
	{
		{FIX_NPC, 0, 1, 1},
		{DIF_NPC, 0, 25, 5, 5, 60 * 18},
	},
	[26] = 				-- 休息
	{
		{FIX_NPC, 0, 0, 1},
	},
	[27] = 				-- 大BOSS
	{
		{FIX_NPC, 0, 0, 1},
		{DIF_NPC, 0, 1, 1, 1, 0},
	},
	[28] = 				-- 领奖
	{
		{FIX_NPC, 0, 0, 1, 2},
	},
	[29] = {},			-- 辅助用的房间
	[30] = {},			-- 辅助用的房间
}

ROOM_NAME =
{
	[1] = "Lối vào",
	[2] = "Khu quái nhỏ",
	[3] = "Phòng tuyển chọn",
	[4] = "Phòng đồng nhân phản đòn",
	[5] = "Khu Boss nhỏ",
	[6] = "Phòng choáng",
	[7] = "Phòng Thiên Tự",
	[8] = "Phòng Địa Tự",
	[9] = "Phòng Nhật Tự",
	[10] = "Phòng Nguyệt Tự",
	[11] = "Phòng Thanh Long",
	[12] = "Phòng Bạch Hổ",
	[13] = "Phòng Chu Tước",
	[14] = "Phòng Huyền Vũ",
	[15] = "Phòng bí văn 1",
	[16] = "Phòng bí văn 2",
	[17] = "Phòng bí văn 3",
	[18] = "Phòng bí văn 4",
	[19] = "Phòng bí văn 5",
	[20] = "Phòng bí văn 6",
	[21] = "Phòng bí văn 7",
	[22] = "Phòng bí văn 8",
	[23] = "Vực thẳm",
	[24] = "Phòng phục chế",
	[25] = "Phòng Siêu Tốc",
	[26] = "Phòng nghỉ ngơi",
	[27] = "Phòng bùa chú",
	[28] = "Phòng bảo rương",
}

AWARD_TABLE = 
{
	--房间号 = 1古钱币，2声望，3房间开启公告，4房间解锁公告，5房间开启角色Ui同步信息，6房间解锁角色Ui同步信息
	[1] 	= { 0,	0,	"", "Nghe thấy tiếng đóng cửa \"Ầm\", xem ra chỉ có thể tiến về trước. ", "","Ải đã mở"},
	[3] 	= {10, 	20, "", "Cùng với 1 loạt âm thanh vang ầm, 3 Bia đá xuất hiện!", "Phải mở cơ quan của 4 góc phòng tuyển chọn", "Phải mở cơ quan trong phòng phản đòn, phòng cơ quan, phòng choáng"},
	[4]		= {10,	30, "", "Nghe thấy tiếng \"két\" vang lên.","",""},
	[5]		= {10, 	30, "", "Nghe thấy tiếng \"két\" vang lên.","",""},
	[6]		= {10,	30, "", "Nghe thấy tiếng \"két\" vang lên.","",""},
	[15]	= {0,	0, 	"Thấy cửa cạnh phòng mở ra!", "","Phải mở khóa phòng bí văn 1 - 8",""},
	[29]	= {20,	30, "", "Nghe thấy tiếng \"két\" vang lên.","",""},
	[30]	= {20,	30, "", "Nghe thấy tiếng \"két\" vang lên.","",""},
	[23]	= {10,	30,	"Mặt đất rung lên, cửa thông phía trước mở ra!", "Nghe thấy tiếng \"két\" vang lên.","Phải mở cơ quan trong phòng vực thẳm, phòng phục chế, phòng siêu tốc",""},
	[24]	= {10,	30, "", "Nghe thấy tiếng \"két\" vang lên.","",""},
	[25]	= {10,	30, "", "Nghe thấy tiếng \"két\" vang lên.","",""},
	[26]	= {0,	0, 	"Ầm 1 tiếng, đường thông với phòng kế mở ra!", "","Phải đánh bại Minh Phủ Oan Hồn phòng bùa chú",""};
	[27]	= {0,	40, "","Âm thanh cực lớn vang lên, lối ra đã mở!","","Qua ải thuận lợi"},
}

preEnv.setfenv(1, preEnv)	--恢复全局环境

