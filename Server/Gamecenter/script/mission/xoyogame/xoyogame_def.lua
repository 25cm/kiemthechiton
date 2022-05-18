--
-- 逍遥谷关卡 
-- 

local preEnv = _G	--保存旧的环境
setfenv(1, XoyoGame)	--设置当前环境为Kin

-- 事件ID

ADD_NPC 		= 1		-- 添加NPC
DEL_NPC			= 2		-- 删除NPC
CHANGE_TRAP		= 3		-- 更改Trip点
DO_SCRIPT		= 4		-- 执行脚本
TARGET_INFO		= 5		-- 目标信息
TIME_INFO		= 6		-- 时间信息
CLOSE_INFO		= 7		-- 关闭界面
CHANGE_FIGHT	= 8		-- 更换战斗状态
MOVIE_DIALOG	= 9		-- 电影模式
BLACK_MSG		= 10	-- 黑底字幕
CHANGE_NPC_AI	= 11	-- 更换NPC的AI
ADD_GOUHUO		= 12	-- 增加篝火
SEND_CHAT		= 13	-- 发送NPC近聊
ADD_TITLE		= 14	-- 加称号
TRANSFORM_CHILD = 15    -- 变小孩
SHOW_NAME_AND_LIFE = 16 -- 显示姓名和血条
NPC_CAN_TALK	= 17	-- Dialog Npc 禁止对话
CHANGE_CAMP		= 18	-- 改变阵形
SET_SKILL		= 19	-- 设置左右键技能
DISABLE_SWITCH_SKILL = 20 -- 禁止切换技能
TRANSFORM_CHILD_2	= 21 -- 变牧童
-- AI模式
AI_MOVE			= 1
AI_RECYLE_MOVE	= 2
AI_ATTACK		= 3

MAX_TIMES			= 4 	-- 最多累计次数
MIN_TEAM_PLAYERS	= 1		-- 队伍至少人数
MIN_LEVEL			= 100	-- 最低等级
MAX_TEAM			= 20		-- 闯关最大队伍数
PLAY_ROOM_COUNT		= 5		-- 闯关关数
ROOM_MAX_LEVEL		= 5		-- 房间最大等级
GUESS_QUESTIONS 	= 30	-- 猜迷最大题目数	
MIN_CORRECT			= 20	-- 最少要答对多少才能晋级
LOCK_MANAGER_TIME	= 20	-- 锁定报名的时间
PK_REFIGHT_TIME		= 20	-- PK重投战斗时间
MAX_REPUTE_TIMES	= 60	-- 最大兑换次数
START_TIME1			= 0900	-- 开启时间1
END_TIME1			= 1930	-- 关闭时间1
START_TIME2			= 2200	-- 开启时间2
END_TIME2			= 2400	-- 关闭时间2

TASK_GROUP			= 2050
TIMES_ID			= 1		-- 参加次数任务变量
CUR_DATE			= 2		-- 已经废弃
REPUTE_TIMES		= 3		-- 兑换次数任务变量
CUR_REPUTE_DATE		= 4		-- 最近兑换日期
ADDTIMES_TIME		= 5		-- 增加次数的时间

REPUTE_CAMP			= 5
REPUTE_CLASS		= 3
REPUTE_VALUE		= 10	-- 兑换声望值

START_GAME_TIME 	= 30*60	-- 每30分钟开一场（给玩家看的虚假定时）

ITEM_BAOXIANG		= {18,1,190,1};

LOG_ATTEND_OPEN     = 1;      --逍遥谷参与LOG开关
DELAY_ENDTIME = 5 ---- số giây qua ải

-- 房间等级对应的时间总数（秒）
ROOM_TIME = 
{
	[1] = 270,	-- 总 4分30
	[2] = 270,	-- 总 4分30
	[3] = 390,	-- 总 6分30
	[4]	= 510,	-- 总 8分30
	[5] = 630,	-- 总 10分30
}

-- 地图组 每组地图必须在同一个服务器~否则晋级之后跨服无法获得原来活动数据
MAP_GROUP = 
{
	[23] = {298, 299, 300, 301, 302, 1542},
	[24] = {303, 304, 305, 306, 307, 1543},
	[25] = {308, 309, 310, 311, 312, 1544},
	[26] = {313, 314, 315, 316, 317, 1545},
	[27] = {318, 319, 320, 321, 322, 1546},
	[28] = {323, 324, 325, 326, 327, 1547},
	[29] = {328, 329, 330, 331, 332, 1548},
}

-- 管理组
MANAGER_GROUP = 
{
	[341] = {23, 24, 25},
	[342] = {26, 27, 28, 29},
}

-- 开启开关
START_SWITCH = 
{
	[23] = 1,
	[24] = 1,
	[25] = 1,
	[26] = 1,
	[27] = 1,
	[28] = 1,
	[29] = 0,
}

BAOMING_IN_POS = {1625,3180};
GAME_IN_POS	   = {1406,2324};

-- 离开点
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

-- 4、5、6人队长增加的的领袖荣誉值
HONOR = {{[4] = 6,  [5] = 8,  [6] = 10},	-- 第一关
		 {[4] = 3,  [5] = 4, [6] = 5},	-- 第二关
		 {[4] = 3, [5] = 4, [6] = 5},	-- 第三关
		 {[4] = 3, [5] = 4, [6] = 5},	-- 第四关
		 {[4] = 3, [5] = 4, [6] = 5},	-- 第五关
		};

preEnv.setfenv(1, preEnv)

XoyoGame.TIMES_PER_DAY		= EventManager.IVER_nXoyoGameCount		-- 每天能参加逍遥谷的次数
