-- 文件名　：relation_def.lua
-- 创建者　：furuilei
-- 创建时间：2009-08-05 09:17:46
-- 功能描述：人际关系脚本宏定义

Relation.TASK_GROUP						= 2067;	-- 师徒相关任务group
Relation.TASK_ID_SHITU_BAIHUTANG 		= 1; -- 白虎堂
Relation.TASK_ID_SHITU_BATTLE 			= 2; -- 宋金战场
Relation.TASK_ID_SHITU_FACTION 			= 3; -- 门派竞技
Relation.TASK_ID_SHITU_WANTED 			= 4; -- 通缉任务
Relation.TASK_ID_SHITU_YIJUN 			= 5; -- 义军任务
Relation.TASK_ID_SHITU_CHUANGONG_COUNT 	= 6; -- 记录完家本周完成师徒传功的次数
Relation.TASK_ID_SHITU_CHUANGONG_TIME	= 7; -- 记录玩家上次传功的时间
Relation.TASK_ID_SHITU_BUFF_TIME 		= 12; -- 弟子上次领取师徒buff的日期
Relation.TASKID_LASTAPPTRAIN_DATE		= 10;	-- 上次申请拜师的日期
Relation.TASKID_APPTRAIN_COUNT			= 11;	-- 当天申请拜师的次数
Relation.MAX_APPTRAIN_COUNT				= 3;	-- 每天最多可以申请拜师的次数
Relation.STUDENT_MINILEVEL				= 20;	-- 弟子最低等级
Relation.STUDENT_MAXLEVEL				= 60;	-- 弟子最高等级
Relation.MAX_STUDENCOUNT				= 3;	-- 当前弟子的最大数目
Relation.GAPMINILEVEL					= 30;	-- 拜师时，师徒之间的最小等级差
Relation.TEACHER_NIMIEVEL				= 80;	-- 师傅的最低等级

Relation.nMax_ChuanGong_Time 	= 4;		-- 每周最多能够传功的次数


Relation.emKEADDRELATION_FAIL	= 0	-- 添加关系失败
Relation.emKEADDRELATION_SUCCESS = 1	-- 添加关系成功
Relation.emKEHAVE_RELATION		= 2	-- 已经有关系了
Relation.emKEPLAYER_NOTONLINE	= 3	-- 对方不在线的时时不能添加为好友

Relation.TIME_NOTIFYONEYEAR		= 7;	-- 在密友关系一年到期前7天，每次上线给出提示
