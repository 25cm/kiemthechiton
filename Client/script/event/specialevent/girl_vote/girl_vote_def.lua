-- 文件名　：girl_vote_def.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-06-05 14:14:15
-- 描  述  ：

SpecialEvent.Girl_Vote = SpecialEvent.Girl_Vote or {};
local tbGirl = SpecialEvent.Girl_Vote;

tbGirl.TSK_GROUP 		= 2095;
tbGirl.TSKSTR_FANS_NAME = {1, 250};	--存储美女名和票数,最多50个美女，共250个任务变量(变量不能更换,用了偏移处理)
tbGirl.TSK_FANS_GATEWAYID = {260, 510};	--存储决赛投票的玩家区服(变量不能更换,用了偏移处理)
tbGirl.TSK_Vote_Girl 	= 256;	--记录美女报名后的标志，预防出问题后可以查询到哪些美女报名了；
tbGirl.TSK_Award_State1 = 257;	--领奖
tbGirl.TSK_Award_StateEx1= 258; --粉丝领奖
tbGirl.TSK_FANS_CLEAR	 = 259; --第二轮记录任务变量清0标志;
tbGirl.TSK_Award_State2	 = 511; --决赛领奖
tbGirl.TSK_Award_StateEx2= 512; --决赛粉丝领奖
tbGirl.TSK_Award_Buff	 = 513; --技能buff任务变量（记录时间）
tbGirl.TSK_Award_Buff_Level	= 514; --技能buff任务变量（记录等级）

tbGirl.DEF_TASK_OFFSET 	 = 259; 	--粉丝存储美女和区服变量偏移值
tbGirl.DEF_TASK_SAVE_FANS= 10; 		--多少个任务变量记录一个投票玩家和票数(影响TSKSTR_FANS_NAME存储的美女数量)

tbGirl.ITEM_MEIGUI		= {18,1,373,1}; --玫瑰
tbGirl.ITEM_MEIGUI_REBACK 	= {18,1,374,1}; --红颜的回赠
tbGirl.DEF_AWARD_ALL_RANK 	= 20; 	--前20名
tbGirl.DEF_AWARD_PASS_RANK 	= 10; 	--前10名入围
tbGirl.DEF_AWARD_TICKETS 	= 499; 	--499票

tbGirl.DEF_FINISH_MATCH_TITLE = {6,6,3,0};

tbGirl.DEF_SKILL_LASTTIME = 90*24*3600;	--光环技能持续时间,如果光环技能异常消失,根据这个时间自动补给

tbGirl.DEF_AWARD_LIST = {
	--初赛前20名里，不是入围前10名的玩家奖励
	[1] = {
		mask = {1,13,25,1},
		skill= {1415,1,2,18* tbGirl.DEF_SKILL_LASTTIME, 1,0,1},
		title= {6,6,2,0},
		freebag=1,	--背包空间
	},
	
	--初赛前20名里，入围前10名奖励
	[2] = {
		mask = {1,13,26,1},
		skill= {1415,2,2,18*tbGirl.DEF_SKILL_LASTTIME, 1,0,1},
		title= {6,6,4,0},
		item = {18,1,1,10, {bForceBind=1}, 1},
		freebag=2,	--背包空间		
	},
	
	--初赛前20名或达到499票的美女追随者奖励
	[3] = {
		title= {6,10,1,0},
		freebag=0,	--背包空间		
	},
	
	--决赛全区全服前10名奖励
	[4] = {
		mask = {1,13,27,1},
		skill= {1415,3,2,18*tbGirl.DEF_SKILL_LASTTIME, 1,0,1},
		title= {6,6,5,0},
		item = {18,1,1,10, {bForceBind=1}, 10},
		freebag=11,	--背包空间		
	},
	--决赛全区全服第一名奖励
	[5] = {
		mask = {1,13,27,1},
		skill= {1415,3,2,18*tbGirl.DEF_SKILL_LASTTIME, 1,0,1},
		title= {6,6,6,0},
		item = {18,1,1,10, {bForceBind=1}, 10},
		freebag=11,	--背包空间		
	},
	
	--决赛全区全服前10名粉丝奖励
	[6] = {
		title= {6,11,1,0},
		freebag=0,	--背包空间	
	},
};

tbGirl.STATE	=	
{
	20091109,	--1.开始报名
	20091114,	--2.开始投票，产出玫瑰
	20091128,	--3.结束报名
	20091202,	--4.结束投票
	20091209,	--5.第二轮投票
	20091222,	--6.第二轮结束，结束产出玫瑰
	20091229,	--7.查询结束
	20100208,	--8.全部完毕
};

tbGirl.STATE_AWARD	=
{
	20100122,	--1.初赛领奖开始时间
	20100129,	--2.初赛领奖结束时间
	20100122,	--3.决赛领奖开始时间
	20100205,	--4.决赛领奖结束时间
	20100208,	--5.(清除初赛,决赛数据)
};

--合区表,区服Id索引
tbGirl.GATEWAY_TRANS = 
{
	--原区服 = 合入服
	--gate0425 = {"gate0423"},
}
