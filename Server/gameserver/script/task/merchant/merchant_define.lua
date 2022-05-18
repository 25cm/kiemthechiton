
Merchant.TASK_GOURP 	= 2036; --任務組
Merchant.TASK_OPEN 		= 1;	--開始任務標志,0為可接任務，1為不可接任務。
Merchant.TASK_STEP_COUNT= 2;	--進行到任務的第幾步驟
Merchant.TASK_NOWTASK 	= 3;	--當前任務Id	
Merchant.TASK_TYPE 	  	= 4;	--任務類型
Merchant.TASK_STEP 	  	= 5;	--任務步驟類型,1為普通步驟,2為10的倍數步驟,3為100的倍數步驟
Merchant.TASK_LEVEL		= 6;	--等級段任務,50為50級任務,60為達到60級才有的任務.
Merchant.TASK_ACCEPT_WEEK_TIME = 7;		--接受任務的周
Merchant.TASK_ACCEPT_STEP_TIME = 8; 	--接受步驟的時間，秒GETTIME()
Merchant.TASK_ACCEPT_TASK_TIME = 9; 	--完成任務的累積時間，秒
Merchant.TASK_RESET_NEWTYPE    = 10; 	--商人任務更換新類型標志（原步驟數/10）

Merchant.TASK_ITEM_FIX	= 
{
 -- 等級  任務變量,累計最大值,名稱
	[1] = {nTask=11, nMax=3,  szName= "Lệnh bài Đại Tướng Tống Kim", nLiveTime = 3600*2},		--商會牌子1
	[2] = {nTask=12, nMax=6,  szName= "Lệnh bài Phó Tướng Tống Kim", nLiveTime = 3600*2},		--商會牌子2
	[3] = {nTask=13, nMax=15, szName= "Lệnh bài Thống Lĩnh Tống Kim", nLiveTime = 3600*2},		--商會牌子3
	[4] = {nTask=14, nMax=9,  szName= "Lệnh Bài Bạch Hổ Đường 3", nLiveTime = 3600*2},	--商會牌子4
	[5] = {nTask=15, nMax=9,  szName= "Lệnh Bài Bạch Hổ Đường 2", nLiveTime = 3600*2},	--商會牌子5
	[6] = {nTask=16, nMax=15, szName= "Lệnh Bài Bạch Hổ Đường 1", nLiveTime = 3600*2},	--商會牌子6
	[7] = {nTask=17, nMax=10, szName= "Lệnh bài Tiêu Dao cấp 5"},		--商會牌子7
	[8] = {nTask=18, nMax=10, szName= "Lệnh bài Tiêu Dao cấp 4"},		--商會牌子8
	[9] = {nTask=19, nMax=10, szName= "Lệnh bài Tiêu Dao cấp 3"},		--商會牌子8
	[10]= {nTask=20, nMax=10, szName= "Lệnh bài Tiêu Dao cấp 2"},		--商會牌子8
};
-- 殺死NPC/玩家對應跌落表的索引(漢語拼音)
Merchant.KILL_SONGJIN_DAJIANG			= 1;
Merchant.KILL_SONGJIN_DAJIANG_PLAYER	= 2;
Merchant.KILL_SONGJIN_FUJIANG			= 3;
Merchant.KILL_SONGJIN_FUJIANG_PLAYER	= 4;
Merchant.KILL_SONGJIN_TONGLING			= 5;
Merchant.KILL_SONGJIN_TONGLING_PLAYER	= 6;
Merchant.KILL_BAIHUTANG_3				= 7;
Merchant.KILL_BAIHUTANG_2				= 8;
Merchant.KILL_BAIHUTANG_1				= 9;

-- 殺死NPC/玩家對應跌落表
Merchant.TASK_NPC_DROP = 
{
	[Merchant.KILL_SONGJIN_DAJIANG			]= {nLevel = 1, nRate = 100},
	[Merchant.KILL_SONGJIN_DAJIANG_PLAYER	]= {nLevel = 1, nRate = 100},
	[Merchant.KILL_SONGJIN_FUJIANG			]= {nLevel = 2, nRate = 100},
	[Merchant.KILL_SONGJIN_FUJIANG_PLAYER	]= {nLevel = 2, nRate = 100},
	[Merchant.KILL_SONGJIN_TONGLING			]= {nLevel = 3, nRate = 100},
	[Merchant.KILL_SONGJIN_TONGLING_PLAYER	]= {nLevel = 3, nRate = 100},
	[Merchant.KILL_BAIHUTANG_3				]= {nLevel = 4, nRate = 10},
	[Merchant.KILL_BAIHUTANG_2				]= {nLevel = 5, nRate = 8},
	[Merchant.KILL_BAIHUTANG_1				]= {nLevel = 6, nRate = 5},
}

-- 宋金死亡玩家掉令牌時間記錄
Merchant.tbSongjin_Kill_Player_Time = {};
Merchant.SONGJIN_KILL_PLAYER_INTERVAL = 5*60; --宋金殺玩家拿令牌的時間間隔

Merchant.TASKDATA_ID 		= 50000; --主任務ID
Merchant.TASKDATA_MAXCOUNT 	= 40; 	 --最大任務步驟次數

Merchant.DERIVEL_ITEM	= {20,1,481,1}; 	--送信ID
Merchant.MERCHANT_BOX_ITEM	= {18,1,288,1}; 	--商會收集箱

Merchant.FILE_PATH		= "\\setting\\task\\merchant\\";	--表格路徑
Merchant.FILE_SELECT	= "type_select.txt";	--選擇類型表﹔
Merchant.FILE_AWARD		= "award_step.txt";		--獎勵表﹔
Merchant.FILE_RANDOM_NPC= "random_npc.txt";		--隨機npc表﹔

Merchant.TYPE_DELIVERITEM	= 1;		--舊類型商會
Merchant.TYPE_BUYITEM		= 2;		--舊類型商會
Merchant.TYPE_FINDITEM		= 3;		--舊類型商會
Merchant.TYPE_COLLECTITEM	= 4;		--舊類型商會
Merchant.TYPE_DELIVERITEM_NEW	= 5;
Merchant.TYPE_BUYITEM_NEW		= 6;
Merchant.TYPE_FINDITEM_NEW		= 7;
Merchant.TYPE_COLLECTITEM_NEW	= 8;




Merchant.SETP_NORMAL	= 1;
Merchant.SETP_HARD		= 2;
Merchant.SETP_HARDEST	= 3;


Merchant.NPC_ID	= 2965;	--任務npcID

Merchant.NPCLIST = {};	--隨機商會npc dwid表﹔

Merchant.TYPE_DESCRIPT = {
	"Đưa Thư Thương Hội đến NPC chỉ định (Thương Nhân Thần Bí xuất hiện ngẫu nhiên ở các thành)",
	"Mua đặc sản cho bang hội tại địa điểm chỉ định (Thương Nhân Thần Bí xuất hiện ngẫu nhiên ở các thành)",
	"Thu thập trang bị và đạo cụ chỉ định cho bang hội (có thể chế tạo các trang bị kỹ năng sống cần thiết)",
	"Đến địa điểm chỉ định thu thập vật phẩm (luôn có quái vật trấn giữ, phải nhập nhóm)",
	};
