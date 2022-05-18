-- 文件名　：achievement_define.lua
-- 创建者　：furuilei
-- 创建时间：2009-10-21 15:45:42
-- 功能描述：成就系统中需要的宏定义

Achievement.TASKGROUP	= 2107;		-- 成就的完成情况

-- 下面的时间定义要与"\\setting\\achievement\\achievement.txt"文件中的事件的顺序完全一致，并且不要轻易改动
Achievement.JXCIDIAN				= 1;	-- 完全回答一个类型的剑侠词典问题
Achievement.LIFISKILL_20			= 2;	-- 任何一个生活技能达到20级
Achievement.YIJUN					= 3;	-- 完成一轮以军任务
Achievement.CANGBAOTU_CHUJI			= 4;	-- 成功挖掘一次初级藏宝图
Achievement.MAINTASK_50				= 5;	-- 完成50级主线剧情
Achievement.LIFISKILL_30			= 6;	-- 生活技能达到30级
Achievement.DENGMI					= 7;	-- 再一次灯谜活动中回答正果所有的问题
Achievement.FUBEN_BAINIANTIANLAO	= 8;	-- 成功通过藏宝图出击副本 - 百年天牢
Achievement.MAINTASK_59				= 9;	-- 完成59级主线剧情
Achievement.QIFU					= 10;	-- 进行祈福一次
Achievement.ENTER_KIN				= 11;	-- 成功加入家族
Achievement.CANGBAOTU_ZHONGJI		= 12;	-- 成功挖掘一次中级藏宝图
Achievement.FUBEN_TAOZHUGONG		= 13;	-- 成功通过藏宝图中级副本 - 陶朱公
Achievement.TONGJI_55				= 14;	-- 成功完成一次55级官府通缉任务
Achievement.BAIHUTANG_CHUJI			= 15;	-- 探索一次初级白虎堂
Achievement.XINDESHU				= 16;	-- 修炼一本心得书
Achievement.MAINTASK_69				= 17;	-- 完成69级主线任务
Achievement.BATTLE_YANGZHOU			= 18;	-- 参加一次初级宋金——扬州
Achievement.FACTION					= 19;	-- 参加一次门派竞技
Achievement.TONGJI_65				= 20;	-- 完成一次65级官府通缉任务
Achievement.FUBEN_DAMOGUCHENG		= 21;	-- 成功通过藏宝图迷宫中级副本——大漠古城
Achievement.MAINTASK_79				= 22;	-- 完成79级主线任务
Achievement.TONGJI_75				= 23;	-- 完成75级官府通缉任务
Achievement.MAINTASK_89				= 24;	-- 完成89级主线任务
Achievement.CANGBAOTU_GAOJI			= 25;	-- 成功挖掘一次高级藏宝图
Achievement.XOYOGAME				= 26;	-- 参加一次逍遥谷活动
Achievement.DOMAINBATTLE			= 27;	-- 参加一次领土争夺战
Achievement.TONGJI_85				= 28;	-- 完成一次85级通缉任务
Achievement.ARMYCAMP				= 29;	-- 完成一次军营任务
Achievement.TONGJI_95				= 30;	-- 完成一次95级官府通缉任务
Achievement.XOYOGAME_PASS			= 31;	-- 成功在逍遥谷闯关通过5关
Achievement.FUBEN_QIANQIONG			= 32;	-- 成功通过高级副本-千琼宫
Achievement.FUBEN_WANHUA			= 33;	-- 成功通过高级副本-万花谷
Achievement.BAIHUTANG_GAOJI			= 34;	-- 成功通过高级白虎堂一次
Achievement.QINSHIHUANG_5			= 35;	-- 成功到达秦始皇陵5层
Achievement.SHANGHUI_40				= 36;	-- 成功完成一轮40次的商会任务
Achievement.BATTLE_GAOJI_20			= 37;	-- 在高级宋金战场中取得前20名
Achievement.COUNT 					= 38;	-- 事件的总数


--=================================================================
-- 成就系统需要用到的其他变量定义（每个里面对应内容分别是任务的主id和子id）
Achievement.tbMainTaskId = {
	[Achievement.MAINTASK_50] = {{4, 38}, {5, 51}, {12, 95}, {9, 74}},
	[Achievement.MAINTASK_59] = {{15, 110}},
	[Achievement.MAINTASK_69] = {{18, 127}},
	[Achievement.MAINTASK_79] = {{21, 150}},
	[Achievement.MAINTASK_89] = {{24, 172}},
	[Achievement.ARMYCAMP]	  = {{225, 400}},
	[Achievement.XINDESHU]	  = {{161, 144}, {162, 145}, {163, 146}},
	};
