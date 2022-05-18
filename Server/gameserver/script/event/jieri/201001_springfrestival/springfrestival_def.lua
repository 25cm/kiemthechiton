SpecialEvent.SpringFrestival = SpecialEvent.SpringFrestival or {};
local SpringFrestival = SpecialEvent.SpringFrestival or {};

SpringFrestival.nLevel 		= 60;    			--Íæ¼ÒµÈ¼¶ÏÞÖÆ
SpringFrestival.nGTPMkPMin_NianHua 	= 500;		--Äê»­¼ø¶¨ÐèÒªµÄ¾«»î
SpringFrestival.nGTPMkPMin_Couplet 	= 1000;		--´ºÁª¼ø¶¨ÐèÒªµÄ¾«»î
SpringFrestival.tbXiWang 		= {18,1,552,1}; --Ï£ÍûÖ®ÖÖ
SpringFrestival.tbBaoXiang 	= {18,1,553,1};	--±¦Ïä£ºµÚÒ»Ç§ÁãÒ»¸öÔ¸Íû
SpringFrestival.tbVowXiang 	= {18,1,554,1};	--Ô¸ÍûºÐ×Ó
SpringFrestival.tbCouplet_Unidentify = {18,1,555,1};--Î´¼ø¶¨ºóµÄ¶ÔÁª
SpringFrestival.tbCouplet_identify 	= {18,1,555,2};	--¼ø¶¨ºóµÄ¶ÔÁª
SpringFrestival.nTrapNumber 		= 1001;				--1001¸öÔ¸Íûºó´ó¼Ò¿ÉÒÔÁì½±Àø
SpringFrestival.nGetFudaiMaxNum 	= 5; 				--ÐíÔ¸Ç°5´Î»ñµÃ¸£´üºÍÓÐ¼¸ÂÊµÄ½±Àø
SpringFrestival.nGetHuaDengMaxNum	= 5;			--Ã¿¸ö»¨µÆÇ°5´Î¸ø»¨µÆ±¦Ïä¡¤¸£ÒÔºó¸ø»¨µÆ±¦Ïä
SpringFrestival.tbHuaDengBox_N 		= {18,1,568,1};		--»¨µÆ±¦Ïä_Î´¿ª·ÅÍ¬°é
SpringFrestival.tbHuaDengBox 			= {18,1,568,2}		--»¨µÆ±¦Ïä_ÒÑ¿ª·ÅÍ¬°é
SpringFrestival.tbNianHua_Unidentify 	= {18,1,557,1};		--Î´¼ø¶¨µÄÄê»­
SpringFrestival.tbNianHua_identify 	= {18,1,558};		--¼ø¶¨ºóµÄÄê»­
SpringFrestival.tbNianHua_box		= {18,1,559,1};		--Äê»­ÊÕ²ØºÐ
SpringFrestival.tbNianHua_book	= {18,1,560,1};		--Äê»­ÊÕ¼¯²á
SpringFrestival.tbNianHua_award	= {18,1,561,1};		--Äê»­ÊÕ¼¯½±Àø±¦Ïä_¿ª·ÅÍ¬°é
SpringFrestival.tbNianHua_award_N	= {18,1,561,2};		--Äê»­ÊÕ¼¯½±Àø±¦Ïä_Î´¿ª·ÅÍ¬°é
SpringFrestival.tbBaiNianAward	= {18,1,551,2}		--ÐÂÄêÀñÎï[À¡Ôù]
SpringFrestival.VowTreeOpenTime	= 20120202;		--ÐíÔ¸Ê÷£¬Äê»­ÊÕ¼¯¿ªÆôÊ±¼ä
SpringFrestival.VowTreeCloseTime	= 20121223;		--ÐíÔ¸Ê÷£¬Äê»­ÊÕ¼¯½áÊøÊ±¼ä
SpringFrestival.HuaDengOpenTime	= 20100202;		--»¨µÆ¿ªÆôÊ±¼ä
SpringFrestival.HuaDengCloseTime	= 20121223;		--»¨µÆ½áÊøÊ±¼ä
SpringFrestival.HuaDengOpenTime_C	= 1200;		--»¨µÆ¿ªÆôµÄ¾ßÌåÊ±¼ä12µãÕû
SpringFrestival.nBaiNianCount		= 999999;				--Íæ¼Ò¿ÉÒÔ±»°ÝÄêµÄ´ÎÊý
SpringFrestival.nGuessCounple_nCount	= 100		--»î¶¯ÆÚ¼äÍæ¼Ò¿ÉÒÔ¶Ô´ºÁªµÄÊýÄ¿
SpringFrestival.nGuessCounple_nCount_daily	= 10		--»î¶¯ÆÚ¼äÍæ¼ÒÃ¿Ìì¿ÉÒÔ¶Ô´ºÁªµÄÊýÄ¿
SpringFrestival.tbVowTree_Title = {6, 20, 1, 9};		----³ÆºÅ½±Àø£ºµÚÒ»Ç§ÁãÒ»¸öÔ¸Íû
SpringFrestival.nGetAward_longwu	= 10;				--ÁúÎåÌ«Ò¯´¦¶Ò»»Äê»­ÊÕ¼¯²áµÄ´ÎÊý
SpringFrestival.nOutTime	= 201212240000			--ÎïÆ·¹ýÆÚÊ±¼ä
SpringFrestival.bPartOpen = EventManager.IVER_nPartOpen;						--Í¬°é¿ª·Å¿ª¹Ø

SpringFrestival.tbBaiAward = {		--拜年送新年礼物有几率获得一下东西（gdpl，几率区间）
	[1] = {{18,1,552,1}, 0, 40},			--希望之种
	[2] = {{18,1,555,1}, 40, 60},			--花灯春联
	[3] = {{18,1,557,1}, 60, 100},			--十二生肖年画[未鉴定]
	};

SpringFrestival.tbXiWangAward = {		--许愿5次之内有几率获得一下东西（gdpl，几率区间）
	[1] = {{18,1,551,1}, 0, 0},			--新年礼物
	[2] = {{18,1,555,1}, 10, 20},			--花灯春联
	[3] = {{18,1,557,1}, 20, 40},			--十二生肖年画[未鉴定]
	};

SpringFrestival.tbCouplet = {			--玩家对上春联后有几率获得一下东西（gdpl，几率区间）
	[1] = {{18,1,551,1}, 0, 15},			--新年礼物
	[2] = {{18,1,552,1}, 15, 30},			--希望之种
	[3] = {{18,1,557,1}, 30, 50},			--十二生肖年画[未鉴定]
	};	
	
SpringFrestival.tbNianHua = {			--成功鉴定一张年画后有几率获得一下东西（gdpl，几率区间）
	[1] = {{18,1,551,1}, 0, 20},			--新年礼物
	[2] = {{18,1,552,1}, 20, 35},			--希望之种
	[3] = {{18,1,555,1}, 35, 50},			--花灯春联
	};	
	
SpringFrestival.tbShengXiao = {"Tý", "Sửu", "Dần", "Mẹo", "Thìn", "Tỵ", "Ngọ", "Mùi", "Thân", "Dậu", "Tuất", "Hợi"};  --12生肖
SpringFrestival.nVowTreeTemplId	= 3723;			--许愿树模板id	
SpringFrestival.nHuaDengTemplId	= 3721;			--花灯模板id未点亮
SpringFrestival.nHuaDengTemplId_D	= 3722;		--花灯模板id点亮
SpringFrestival.tbVowTreePosition = {3,1631,3209};		--许愿树的位置(地图id，x坐标，y坐标)
SpringFrestival.tbTransferCondition = {["fight"] = 1, ["village"] = 1, ["faction"] = 1, ["city"] = 1};	--希望之种传送的限制(map的classname)

SpringFrestival.TASKID_GROUP			= 2113;	--任务变量组
SpringFrestival.TASKID_TIME			= 1;				--时间
SpringFrestival.TASKID_COUNT			= 2;				--第几次许愿 
SpringFrestival.TASKID_ISGETAWARD		= 3;				--是否已经领奖
SpringFrestival.TASKID_NIANHUA_BOX 	= 4;    			--4到15用来记录收藏盒里面的年画数
SpringFrestival.TASKID_NIANHUA_BOOK 	= 16; 			--16到27用来记录收集册里面的年画种类
SpringFrestival.TASKID_GETAWARD		= 28;				--兑换收集册的次数
SpringFrestival.TASKID_BAINIANNUMBER	= 29;				--被拜年的次数
SpringFrestival.TASKID_IDENTIFYCOUPLET_NCOUNT		=30;		--玩家鉴定的对联数
SpringFrestival.TASKID_GUESSCOUPLET_NCOUNT			=31;		--玩家活动期间猜对联的数目
SpringFrestival.TASKID_GUESSYCOUPLET_NCOUNT_DAILY  	=32;		--玩家每天才对联的数目
SpringFrestival.TASKID_STONE_COUNT_MAX			  	=33;		--宝石数
SpringFrestival.TASKID_STONE_WEEK			  		=34;		--每周最多7个宝石

SpringFrestival.TASKID_GROUP_EX		= 2093	--修复变量组
SpringFrestival.TASKID_VOWTREE_TIME	= 18		--许愿树日期

SpringFrestival.tbLuckyStone  	={18,1,908,1};	       --幸运宝石	
SpringFrestival.STONE_COUNT_MAX			  	= 7;		--宝石数

SpringFrestival.TASKID_GROUP_EX		= 2093	--修复变量组
SpringFrestival.TASKID_VOWTREE_TIME	= 18		--许愿树日期
SpringFrestival.HUADENG = SpringFrestival.HUADENG or {};			--7个城市的mapId和对应的刷点的文件明
SpringFrestival.HUADENG_POS = SpringFrestival.HUADENG_POS or {};	--7个城市花灯的刷出点（打乱取前50个）
SpringFrestival.tbCoupletList = SpringFrestival.tbCoupletList or {};			--对联
SpringFrestival.nVowTreenId =  SpringFrestival.nVowTreenId or 0;		--许愿树dwId
SpringFrestival.tbHuaDeng = SpringFrestival.tbHuaDeng or {};			--管理花灯
