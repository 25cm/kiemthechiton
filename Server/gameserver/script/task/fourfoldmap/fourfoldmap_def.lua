--四倍經驗練級地圖
--sunduoliang
--2008.11.05

local Fourfold = Task.FourfoldMap or {};
Task.FourfoldMap = Fourfold;

Fourfold.MAP_TEMPLATE_ID = 343; --模版地圖
Fourfold.MAP_APPLY_MAX   = 15;  --每台服務器申請上限
Fourfold.NPC_ID   		 = 2317;  --npcId
Fourfold.TIME_GET_READY  = 3; -- 准備時間（分鐘）

Fourfold.TSK_GROUP = 2040;	--任務變量組
--Fourfold.TSK_STATE = 12;	--狀態，0未在4倍地圖，1在4倍地圖
--Fourfold.TSK_ENTER_MAP 	= 13;--傳入點地圖Id
--Fourfold.TSK_ENTER_POSX = 14;--傳入點地圖X坐標
--Fourfold.TSK_ENTER_POSY = 15;--傳入點地圖Y坐標
Fourfold.TSK_REMAIN_TIME= 16;--剩余時間（秒）
--Fourfold.TSK_USE_COUNT	= 17;--使用次數
--Fourfold.TSK_CAPTAIN	= 18;--副本所屬隊長Id
Fourfold.DEF_MAX_TIME 	= EventManager.IVER_nFourfoldMapMaxTime*3600; 		--最大累計增加時間10小時;
Fourfold.DEF_PRE_TIME 	= EventManager.IVER_nFourfoldMapPreTime*3600;  		--每天累計增加2小時;
Fourfold.DEF_MIN_OPEN_TIME	= 120*60;   --時間大於120分才能開啟
Fourfold.DEF_MIN_ENTER_TIME	= 60; 	    --剩余時間少於60秒的玩家不允許進入
Fourfold.DEF_MAX_ENTER	= 6;   --最多隻能6人進入秘境地圖。
Fourfold.DEF_LUCKY		= 10;  --默認增加10點幸運。
Fourfold.LIMIT_LEVEL 	= EventManager.IVER_nFourfoldMapLevel;  --達到50級才能進入

Fourfold.UI_READYTIME_MSG = "<color=green>Bắt đầu mở trong: <color=white>%s\n";
Fourfold.UI_TIME_MSG 	= "<color=green>Thời gian tu luyện còn: <color=white>%s\n\n<color=green>Thời gian tích lũy còn: <color=white>%s\n";
Fourfold.UI_STAIC_MSG 	= "<color=yellow>Đang tu luyện...<color>";

Fourfold.DEF_MAP_POS	=	{{51840/32,100896/32}}; --傳入坐標 

Fourfold.DEF_ITEM_KEY= {18,1,251,1};	--開啟副本道具﹔

Fourfold.TimerList = Fourfold.TimerList or {}; --存儲計時器Id;
Fourfold.MissionList = Fourfold.MissionList or {}; --mission列表;
Fourfold.NpcPosList = Fourfold.NpcPosList or {}; --npc坐標列表;
Fourfold.PlayerTempList = Fourfold.PlayerTempList or {}; --玩家臨時數據列表;

--模版地圖列表;
if not Fourfold.MapTempletList then
	Fourfold.MapTempletList = {};
	Fourfold.MapTempletList.tbBelongList = {};
	Fourfold.MapTempletList.tbMapList = {};
	Fourfold.MapTempletList.nCount = 0;
end

--玩家申請秘境開啟時間
if not Fourfold.tbOpenHour then
	Fourfold.tbOpenHour = {};
end
