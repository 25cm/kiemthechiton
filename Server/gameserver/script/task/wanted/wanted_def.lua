--官府通缉任务
--孙多良
--2008.08.06

Wanted.TASK_MAIN_ID = 50001;		--主任务Id
Wanted.TEXT_NAME	= "[Truy nã]";--主任务名称
Wanted.ACCEPT_NPC_ID= 2994;			--接任务npc

Wanted.Day_COUNT	= 10;	--每天累计6次;


Wanted.TASK_GROUP 	  = 2040;	--任务变量组；
Wanted.TASK_ACCEPT_ID = 1;		--已接任务ID
Wanted.TASK_COUNT  	  = 2;		--已剩任务次数；
Wanted.TASK_FIRST  	  = 3;		--更新后或新建角色当天给予6次标志；
Wanted.TASK_LEVELSEG  = 4;		--接任务等级段；
Wanted.TASK_FINISH    = 7;		--是否已完成目标；1,未完成,0已完成或没有任务

Wanted.LIMIT_COUNT_MAX	= 30;	--最大累计36次;
Wanted.LIMIT_LEVEL		= 100;	--等级限制;
Wanted.LIMIT_REPUTE		= 0;	--江湖威望限制;

Wanted.ITEM_WULINMIJI = {{18,1,5001,51}, 4} --武林秘籍(初级) ID,换取所需名捕令数量
Wanted.ITEM_XISUIJING = {{18,1,5002,52}, 3} --洗髓经(初级)  ID,换取所需名捕令数量
Wanted.ITEM_MINGBULING = {18,1,190,1} --名捕令

Wanted.AWARD_LIST =
{
	[1] = 1,	--50级任务奖励名捕令个数
	[2] = 2,	--60级任务奖励名捕令个数
	[3] = 3,
	[4] = 4,
	[5] = 5,
}

Wanted.DROPLUCK = 10; --掉落随机装备获得魔法属性额外增加幸运值。
Wanted.DROPRATE =
{
	[55] = "\\setting\\npc\\droprate\\guanfutongji\\tongji_lv55.txt",	--55级boss掉落表
	[65] = "\\setting\\npc\\droprate\\guanfutongji\\tongji_lv65.txt",	--65级boss掉落表
	[75] = "\\setting\\npc\\droprate\\guanfutongji\\tongji_lv75.txt",	--75级boss掉落表
	[85] = "\\setting\\npc\\droprate\\guanfutongji\\tongji_lv85.txt",	--85级boss掉落表
	[95] = "\\setting\\npc\\droprate\\guanfutongji\\tongji_lv95.txt",	--95级boss掉落表
}
