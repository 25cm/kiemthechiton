
-- AI基础模板
Npc.tbAIBase	= {
	ai0	= {
		AIMode		= 0,
		AIParam1	= 0,
		AIParam2	= 0,
		AIParam3	= 0,
		AIParam4	= 0,
		AIParam5	= 0,
		AIParam6	= 0,
		AIParam7	= 0,
		AIParam8	= 0,
		AIParam9	= 0,
		AIParam10	= 0,
	},
	stup	= {
		AIMode		= 1,			--1号AI模式
		AIParam1	= 15,			--无敌人时,巡逻概率
		AIParam2	= 100,			--技能的概率 对应SkillList里面的技能 1
		AIParam3	= 0,			--技能的概率 对应SkillList里面的技能 2
		AIParam4	= 0,			--技能的概率 对应SkillList里面的技能 3
		AIParam5	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam6	= 25,			--敌人在攻击范围之外时,待机的概率
		AIParam7	= 10,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam8	= 0,			--无用
		AIParam9	= 0,			--无用
		AIParam10	= 0,			--无用
	},

	passivenormal	= {				--被动,巡逻,单技能,无逃跑,无治疗,无特技
		AIMode		= 4,			--4号AI模式
		AIParam1	= 15,			--无敌人时,巡逻概率
		AIParam2	= 100,			--技能的概率 对应SkillList里面的技能 1
		AIParam3	= 0,			--技能的概率 对应SkillList里面的技能 2
		AIParam4	= 0,			--技能的概率 对应SkillList里面的技能 3
		AIParam5	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam6	= 25,			--敌人在攻击范围之外时,待机的概率
		AIParam7	= 10,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam8	= 0,			--无用
		AIParam9	= 0,			--无用
		AIParam10	= 0,			--无用
	},

	passivenormal2	= {				--被动,巡逻,双技能,无逃跑,无治疗,无特技
		AIMode		= 4,			--4号AI模式
		AIParam1	= 15,			--无敌人时,巡逻概率
		AIParam2	= 66,			--技能的概率 对应SkillList里面的技能 1
		AIParam3	= 33,			--技能的概率 对应SkillList里面的技能 2
		AIParam4	= 0,			--技能的概率 对应SkillList里面的技能 3
		AIParam5	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam6	= 25,			--敌人在攻击范围之外时,待机的概率
		AIParam7	= 10,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam8	= 0,			--无用
		AIParam9	= 0,			--无用
		AIParam10	= 0,			--无用
	},
	passivenormal2ex	= {				--被动,巡逻,双技能,无逃跑,无治疗,无特技
		AIMode		= 4,			--4号AI模式
		AIParam1	= 15,			--无敌人时,巡逻概率
		AIParam2	= 80,			--技能的概率 对应SkillList里面的技能 1
		AIParam3	= 20,			--技能的概率 对应SkillList里面的技能 2
		AIParam4	= 0,			--技能的概率 对应SkillList里面的技能 3
		AIParam5	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam6	= 25,			--敌人在攻击范围之外时,待机的概率
		AIParam7	= 10,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam8	= 0,			--无用
		AIParam9	= 0,			--无用
		AIParam10	= 0,			--无用
	},
	passivenormal3	= {				--被动,巡逻,双技能,无逃跑,无治疗,无特技
		AIMode		= 4,			--4号AI模式
		AIParam1	= 15,			--无敌人时,巡逻概率
		AIParam2	= 50,			--技能的概率 对应SkillList里面的技能 1
		AIParam3	= 30,			--技能的概率 对应SkillList里面的技能 2
		AIParam4	= 20,			--技能的概率 对应SkillList里面的技能 3
		AIParam5	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam6	= 25,			--敌人在攻击范围之外时,待机的概率
		AIParam7	= 10,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam8	= 0,			--无用
		AIParam9	= 0,			--无用
		AIParam10	= 0,			--无用
	},
	passivenormal3ex	= {				--被动,巡逻,双技能,无逃跑,无治疗,无特技
		AIMode		= 4,			--4号AI模式
		AIParam1	= 15,			--无敌人时,巡逻概率
		AIParam2	= 80,			--技能的概率 对应SkillList里面的技能 1
		AIParam3	= 10,			--技能的概率 对应SkillList里面的技能 2
		AIParam4	= 10,			--技能的概率 对应SkillList里面的技能 3
		AIParam5	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam6	= 25,			--敌人在攻击范围之外时,待机的概率
		AIParam7	= 10,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam8	= 0,			--无用
		AIParam9	= 0,			--无用
		AIParam10	= 0,			--无用
	},
	passiveflee	= {					--被动,巡逻,单技能,逃跑,无治疗,无特技
		AIMode		= 5,			--5号AI模式,被动治疗
		AIParam1	= 15,			--无敌人时,巡逻概率
		AIParam2	= 15,			--血量低于15%时
		AIParam3	= 100,			--逃跑概率
		AIParam4	= 0,			--不治疗
		AIParam5	= 100,			--技能的概率 对应SkillList里面的技能 2
		AIParam6	= 0,			--技能的概率 对应SkillList里面的技能 3
		AIParam7	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam8	= 25,			--敌人在攻击范围之外时,待机的概率
		AIParam9	= 10,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam10	= 0,			--无用
	},
	passiveflee2ex	= {				--主动,巡逻,2技能,逃跑,无治疗,无特技
		AIMode		= 5,			--5号AI模式,被动治疗
		AIParam1	= 15,			--无敌人时,巡逻概率
		AIParam2	= 15,			--血量低于15%时
		AIParam3	= 100,			--逃跑概率
		AIParam4	= 0,			--不治疗
		AIParam5	= 80,			--技能的概率 对应SkillList里面的技能 2
		AIParam6	= 20,			--技能的概率 对应SkillList里面的技能 3
		AIParam7	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam8	= 25,			--敌人在攻击范围之外时,待机的概率
		AIParam9	= 10,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam10	= 0,			--无用
	},
	passiveheal	= {					--被动,巡逻,单技能,逃跑(无法治疗时),治疗,无特技
		AIMode		= 5,			--5号AI模式,被动治疗
		AIParam1	= 15,			--无敌人时,巡逻概率
		AIParam2	= 20,			--血量低于15%时
		AIParam3	= 100,			--治疗概率
		AIParam4	= 100,			--不逃跑
		AIParam5	= 100,			--技能的概率 对应SkillList里面的技能 2
		AIParam6	= 0,			--技能的概率 对应SkillList里面的技能 3
		AIParam7	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam8	= 25,			--敌人在攻击范围之外时,待机的概率
		AIParam9	= 10,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam10	= 1,			--最大治疗次数
	},

	passiveskill	= {				--被动,巡逻,单技能,逃跑(无法使用特技时),无治疗,特技
		AIMode		= 6,			--5号AI模式,被动治疗
		AIParam1	= 15,			--无敌人时,巡逻概率
		AIParam2	= 20,			--血量低于15%时
		AIParam3	= 50,			--特技触发概率
		AIParam4	= 100,			--不逃跑
		AIParam5	= 100,			--技能的概率 对应SkillList里面的技能 2
		AIParam6	= 0,			--技能的概率 对应SkillList里面的技能 3
		AIParam7	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam8	= 25,			--敌人在攻击范围之外时,待机的概率
		AIParam9	= 10,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam10	= 1,			--最大治疗次数
	},

	activenormal	= {				--主动,巡逻,单技能,无逃跑,无治疗,无特技
		AIMode		= 1,			--1号AI模式
		AIParam1	= 15,			--无敌人时,巡逻概率
		AIParam2	= 100,			--技能的概率 对应SkillList里面的技能 1
		AIParam3	= 0,			--技能的概率 对应SkillList里面的技能 2
		AIParam4	= 0,			--技能的概率 对应SkillList里面的技能 3
		AIParam5	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam6	= 25,			--敌人在攻击范围之外时,待机的概率
		AIParam7	= 10,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam8	= 0,			--无用
		AIParam9	= 0,			--无用
		AIParam10	= 0,			--无用
	},

	activenormal2	= {				--主动,巡逻,双技能,无逃跑,无治疗,无特技
		AIMode		= 1,			--1号AI模式
		AIParam1	= 15,			--无敌人时,巡逻概率
		AIParam2	= 50,			--技能的概率 对应SkillList里面的技能 1
		AIParam3	= 50,			--技能的概率 对应SkillList里面的技能 2
		AIParam4	= 0,			--技能的概率 对应SkillList里面的技能 3
		AIParam5	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam6	= 25,			--敌人在攻击范围之外时,待机的概率
		AIParam7	= 10,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam8	= 0,			--无用
		AIParam9	= 0,			--无用
		AIParam10	= 0,			--无用
	},

	activenormal2ex	= {				--主动,巡逻,双技能,无逃跑,无治疗,无特技
		AIMode		= 1,			--1号AI模式
		AIParam1	= 15,			--无敌人时,巡逻概率
		AIParam2	= 80,			--技能的概率 对应SkillList里面的技能 1
		AIParam3	= 20,			--技能的概率 对应SkillList里面的技能 2
		AIParam4	= 0,			--技能的概率 对应SkillList里面的技能 3
		AIParam5	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam6	= 25,			--敌人在攻击范围之外时,待机的概率
		AIParam7	= 10,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam8	= 0,			--无用
		AIParam9	= 0,			--无用
		AIParam10	= 0,			--无用
	},

	activenormal3	= {				--主动,巡逻,3技能,无逃跑,无治疗,无特技
		AIMode		= 1,			--1号AI模式
		AIParam1	= 15,			--无敌人时,巡逻概率
		AIParam2	= 50,			--技能的概率 对应SkillList里面的技能 1
		AIParam3	= 30,			--技能的概率 对应SkillList里面的技能 2
		AIParam4	= 20,			--技能的概率 对应SkillList里面的技能 3
		AIParam5	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam6	= 25,			--敌人在攻击范围之外时,待机的概率
		AIParam7	= 10,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam8	= 0,			--无用
		AIParam9	= 0,			--无用
		AIParam10	= 0,			--无用
	},

	activenormal3ex	= {				--主动,巡逻,3技能,无逃跑,无治疗,无特技
		AIMode		= 1,			--1号AI模式
		AIParam1	= 15,			--无敌人时,巡逻概率
		AIParam2	= 80,			--技能的概率 对应SkillList里面的技能 1
		AIParam3	= 10,			--技能的概率 对应SkillList里面的技能 2
		AIParam4	= 10,			--技能的概率 对应SkillList里面的技能 3
		AIParam5	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam6	= 25,			--敌人在攻击范围之外时,待机的概率
		AIParam7	= 10,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam8	= 0,			--无用
		AIParam9	= 0,			--无用
		AIParam10	= 0,			--无用
	},

	activeflee	= {					--主动,巡逻,单技能,逃跑,无治疗,无特技
		AIMode		= 2,			--2号AI模式,被动治疗
		AIParam1	= 15,			--无敌人时,巡逻概率
		AIParam2	= 15,			--血量低于15%时
		AIParam3	= 100,			--逃跑概率
		AIParam4	= 0,			--不治疗
		AIParam5	= 100,			--技能的概率 对应SkillList里面的技能 2
		AIParam6	= 0,			--技能的概率 对应SkillList里面的技能 3
		AIParam7	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam8	= 25,			--敌人在攻击范围之外时,待机的概率
		AIParam9	= 10,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam10	= 0,			--无用
	},

	fleeactive2ex	= {				--主动,巡逻,2技能,逃跑,无治疗,无特技
		AIMode		= 2,			--2号AI模式,被动治疗
		AIParam1	= 15,			--无敌人时,巡逻概率
		AIParam2	= 15,			--血量低于15%时
		AIParam3	= 100,			--逃跑概率
		AIParam4	= 0,			--不治疗
		AIParam5	= 80,			--技能的概率 对应SkillList里面的技能 2
		AIParam6	= 20,			--技能的概率 对应SkillList里面的技能 3
		AIParam7	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam8	= 25,			--敌人在攻击范围之外时,待机的概率
		AIParam9	= 10,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam10	= 0,			--无用
	},

	activeheal	= {					--主动,巡逻,单技能,逃跑(无法治疗时),治疗,无特技
		AIMode		= 2,			--2号AI模式,被动治疗
		AIParam1	= 15,			--无敌人时,巡逻概率
		AIParam2	= 20,			--血量低于15%时
		AIParam3	= 100,			--治疗概率
		AIParam4	= 100,			--不逃跑
		AIParam5	= 100,			--技能的概率 对应SkillList里面的技能 2
		AIParam6	= 0,			--技能的概率 对应SkillList里面的技能 3
		AIParam7	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam8	= 25,			--敌人在攻击范围之外时,待机的概率
		AIParam9	= 10,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam10	= 1,			--最大治疗次数
	},

	activeskill	= {					--主动,巡逻,单技能,逃跑(无法使用特技时),无治疗,特技
		AIMode		= 3,			--3号AI模式,被动治疗
		AIParam1	= 15,			--无敌人时,巡逻概率
		AIParam2	= 20,			--血量低于15%时
		AIParam3	= 50,			--特技触发概率
		AIParam4	= 100,			--不逃跑
		AIParam5	= 100,			--技能的概率 对应SkillList里面的技能 2
		AIParam6	= 0,			--技能的概率 对应SkillList里面的技能 3
		AIParam7	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam8	= 25,			--敌人在攻击范围之外时,待机的概率
		AIParam9	= 10,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam10	= 1,			--最大治疗次数
	},

	noaction	= {					--被动,巡逻,挨打无反应
		AIMode		= 4,			--4号AI模式,被动治疗
		AIParam1	= 0,			--无敌人时,巡逻概率
		AIParam2	= 0,
		AIParam3	= 0,
		AIParam4	= 0,
		AIParam5	= 0,
		AIParam6	= 100,			--敌人在攻击范围之外时,待机的概率
		AIParam7	= 0,
		AIParam8	= 0,
		AIParam9	= 0,
		AIParam10	= 0,
	},

	activeinstancing	= {			--主动,无巡逻,单技能,无逃跑,无治疗,无特技（副本专用小怪  by peres）
		AIMode		= 1,			--1号AI模式
		AIParam1	= 0,			--无敌人时,巡逻概率
		AIParam2	= 100,			--技能的概率 对应SkillList里面的技能 1
		AIParam3	= 0,			--技能的概率 对应SkillList里面的技能 2
		AIParam4	= 0,			--技能的概率 对应SkillList里面的技能 3
		AIParam5	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam6	= 10,			--敌人在攻击范围之外时,待机的概率
		AIParam7	= 10,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam8	= 0,			--无用
		AIParam9	= 0,			--无用
		AIParam10	= 0,			--无用
	},

	activeboss	= {					--主动bossAI
		AIMode		= 99,			--BossAI模式,配置成此模式时会读相关BossAI配置文件
		AIParam1	= 15,			--无敌人时,巡逻概率
		AIParam2	= 100,			--技能的概率 对应SkillList里面的技能 1
		AIParam3	= 0,			--技能的概率 对应SkillList里面的技能 2
		AIParam4	= 0,			--技能的概率 对应SkillList里面的技能 3
		AIParam5	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam6	= 10,			--敌人在攻击范围之外时,待机的概率
		AIParam7	= 0,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam8	= 0,			--无用
		AIParam9	= 0,			--无用
		AIParam10	= 0,			--无用
	},

	activestup	= {					--主动静止怪,不巡逻,不移动,单技能,无逃跑,无治疗,无特技
		AIMode		= 1,			--1号AI模式
		AIParam1	= 0,			--无敌人时,巡逻概率
		AIParam2	= 100,			--技能的概率 对应SkillList里面的技能 1
		AIParam3	= 0,			--技能的概率 对应SkillList里面的技能 2
		AIParam4	= 0,			--技能的概率 对应SkillList里面的技能 3
		AIParam5	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam6	= 100,			--敌人在攻击范围之外时,待机的概率
		AIParam7	= 0,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam8	= 0,			--无用
		AIParam9	= 0,			--无用
		AIParam10	= 0,			--无用
	},

	passivestup	= {					--被动静止怪,不巡逻,不移动,单技能,无逃跑,无治疗,无特技
		AIMode		= 4,			--4号AI模式
		AIParam1	= 0,			--无敌人时,巡逻概率
		AIParam2	= 100,			--技能的概率 对应SkillList里面的技能 1
		AIParam3	= 0,			--技能的概率 对应SkillList里面的技能 2
		AIParam4	= 0,			--技能的概率 对应SkillList里面的技能 3
		AIParam5	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam6	= 100,			--敌人在攻击范围之外时,待机的概率
		AIParam7	= 0,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam8	= 0,			--无用
		AIParam9	= 0,			--无用
		AIParam10	= 0,			--无用
	},
	fleewuxinggu	= {				--不还击,巡逻,单技能,逃跑,无治疗,无特技
		AIMode		= 5,			--5号AI模式
		AIParam1	= 50,			--无敌人时,巡逻概率
		AIParam2	= 0,			--血量低于100%时
		AIParam3	= 100,			--逃跑概率
		AIParam4	= 0,			--不治疗
		AIParam5	= 100,			--技能的概率 对应SkillList里面的技能 2
		AIParam6	= 0,			--技能的概率 对应SkillList里面的技能 3
		AIParam7	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam8	= 0,			--敌人在攻击范围之外时,待机的概率
		AIParam9	= 50,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam10	= 0,			--无用
	},
	fleecaibaotu	= {				--不还击,巡逻,单技能,逃跑,无治疗,无特技
		AIMode		= 5,			--5号AI模式
		AIParam1	= 50,			--无敌人时,巡逻概率
		AIParam2	= 100,			--血量低于100%时
		AIParam3	= 100,			--逃跑概率
		AIParam4	= 0,			--不治疗
		AIParam5	= 100,			--技能的概率 对应SkillList里面的技能 2
		AIParam6	= 0,			--技能的概率 对应SkillList里面的技能 3
		AIParam7	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam8	= 0,			--敌人在攻击范围之外时,待机的概率
		AIParam9	= 50,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam10	= 0,			--无用
		AIParam11	= 200,			--无用
	},
	yingziwushi	= {					--影子武士ai
		AIMode		= 99,			--BossAI模式,配置成此模式时会读相关BossAI配置文件
		AIParam1	= 50,			--无敌人时,巡逻概率
		AIParam2	= 0,			--技能的概率 对应SkillList里面的技能 1
		AIParam3	= 0,			--技能的概率 对应SkillList里面的技能 2
		AIParam4	= 0,			--技能的概率 对应SkillList里面的技能 3
		AIParam5	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam6	= 0,			--敌人在攻击范围之外时,待机的概率
		AIParam7	= 50,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam8	= 0,			--无用
		AIParam9	= 0,			--无用
		AIParam10	= 0,			--无用
	},
	cangbaotuboss2	= {				--主动静止怪,不巡逻,不移动,双技能,无逃跑,无治疗,无特技
		AIMode		= 1,			--1号AI模式--主动
		AIParam1	= 0,			--无敌人时,巡逻概率
		AIParam2	= 4,			--技能的概率 对应SkillList里面的技能 1
		AIParam3	= 100,			--技能的概率 对应SkillList里面的技能 2
		AIParam4	= 0,			--技能的概率 对应SkillList里面的技能 3
		AIParam5	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam6	= 100,			--敌人在攻击范围之外时,待机的概率
		AIParam7	= 0,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam8	= 0,			--无用
		AIParam9	= 0,			--无用
		AIParam10	= 0,			--无用
	},
	cangbaotuboss1	= {				--主动,巡逻,双技能,无逃跑,无治疗,无特技
		AIMode		= 1,			--1号AI模式主动
		AIParam1	= 15,			--无敌人时,巡逻概率
		AIParam2	= 60,			--技能的概率 对应SkillList里面的技能 1
		AIParam3	= 100,			--技能的概率 对应SkillList里面的技能 2
		AIParam4	= 0,			--技能的概率 对应SkillList里面的技能 3
		AIParam5	= 0,			--技能的概率 对应SkillList里面的技能 4
		AIParam6	= 25,			--敌人在攻击范围之外时,待机的概率
		AIParam7	= 10,			--敌人在攻击范围之外时,巡逻的概率为AIParam7-AIParam6;追击敌人的概率为100-Param7
		AIParam8	= 0,			--无用
		AIParam9	= 0,			--无用
		AIParam10	= 0,			--无用
	},
};

--五行定义
Npc.tbSeriesIndex = {
	[Env.SERIES_NONE]	= 1,
	[Env.SERIES_METAL]	= 2,
	[Env.SERIES_WOOD]	= 3,
	[Env.SERIES_WATER]	= 4,
	[Env.SERIES_FIRE]	= 5,
	[Env.SERIES_EARTH]	= 6,
};

-- 技能基础模板

--技能id表
Npc.tbSkillId =	{  	["sk"]						= {308, 309, 310, 311, 312, 313},		--近身单体
					["singleskillmelee"] 		= {308, 309, 310, 311, 312, 313},		--近身单体
					["singleskillmidrange"]		= {314, 315, 316, 317, 318, 319},		--中程单体
					["singleskillrange"]		= {320, 321, 322, 323, 324, 325},		--远程单体
					--近身普通攻击技能
					["singleskillfist"]			= {308, 309, 310, 311, 312, 313},		--拳单体
					["singleskillsword"]		= {338, 339, 340, 341, 342, 343},		--剑单体
					["singleskillblade"]		= {344, 345, 346, 347, 348, 349},		--刀单体
					["singleskillstick"]		= {350, 351, 352, 353, 354, 355},		--棍单体
					["singleskillspear"]		= {356, 357, 358, 359, 360, 361},		--枪单体
					["singleskillhammer"]		= {362, 363, 364, 365, 366, 367},		--锤单体
					["singleskillarrow"]		= {368, 369, 370, 371, 372, 373},		--箭单体
					["meleehack2"]				= {700, 700, 701, 702, 703, 704},		--近身2次砍击(第1套动作)
					["meleefist2"]				= {705, 705, 706, 707, 708, 709},		--近身2次拳攻击(第1套动作)
					--远程气攻击技能为匹配npc动作（刺,挥砍,拳）制作
					["rangestab"]				= {749, 749, 750, 751, 752, 753},		--远程尖锐的气攻击(第2套动作)
					["rangehack"]				= {754, 754, 755, 756, 757, 758},		--远程锋利的气攻击(第2套动作)
					["rangegas"]				= {320, 321, 322, 323, 324, 325},		--远程气攻击(第2套动作)
					["accidence"]				= {900, 900, 917, 925, 931, 941},		--各门派远程单体入门技能
					["advanced"]				= {1032, 1032, 1044, 1046, 1056, 1058},		--各门派高级范围攻击技能
					--特殊攻击方式的技能
					["rangetwiceskill"]			= {507, 507, 508, 509, 510, 511},		--远程2次攻击（第2套动作）
					["roundskill"]				= {512, 512, 513, 514, 515, 516},		--范围 圆形
					["semiroundskill"]			= {517, 517, 518, 519, 520, 521},		--范围 半圆
					["parallelskill"]			= {522, 522, 523, 524, 525, 526},		--范围 平衡
					["followskill"]				= {527, 527, 528, 529, 530, 531},		--跟踪
					["certainnormalskill"]		= {532, 532, 533, 534, 535, 536},		--定点普通
					["certainflyskill"]			= {537, 537, 538, 539, 540, 541},		--定点飞行
					["certainroundskill"]		= {542, 542, 543, 544, 545, 546},		--定点范围
					--npc第二套动作专用技能(为匹配npc各种奇怪的第二套动作制作)
					["meleehack3"]				= {710, 710, 711, 712, 713, 714},		--近身3次砍击（第2套动作）
					["meleehack2ex"]			= {715, 715, 716, 717, 718, 719},		--近身2次砍击（第2套动作）
					["meleestab"]				= {720, 720, 721, 722, 723, 724},		--近身刺击（第2套动作）
					["meleestab4"]				= {725, 725, 726, 727, 728, 729},		--近身4次刺击（第2套动作）
					["selfround"]				= {730, 730, 731, 732, 733, 734},		--自身范围攻击（第2套动作）
					["targetround"]				= {735, 735, 735, 735, 735, 735},		--目标范围攻击（第2套动作）
					["sectorgas"]				= {736, 736, 737, 738, 739, 740},		--扇形气攻击（第2套动作）
					["sectordart"]				= {741, 741, 741, 741, 741, 741},		--散花镖（第2套动作）
					["rainarrow"]				= {742, 742, 742, 742, 742, 742},		--箭雨（第2套动作）
					["midpenetrable"]			= {744, 744, 745, 746, 747, 748},		--中程穿透气攻击（第2套动作）
					["rangehack2"]				= {507, 507, 508, 509, 510, 511},		--远程2段锋锐的气攻击（第2套动作）
					--定点多次攻击技能
					["powerful"]				= {1029, 1029, 1130, 1116, 978, 1121},		--远程2段锋锐的气攻击（第2套动作）
				}
--技能等级与角色等级的关联表
Npc.tbSkillLv = {	{1,1},{9,1},
					{10,2},{19,2},
					{20,3},{29,3},
					{30,4},{39,4},
					{40,5},{49,5},
					{50,6},{59,6},
					{60,7},{69,7},
					{70,8},{79,8},
					{80,9},{89,9},
					{90,10},{100,10},
					}

--根据SkillType返回合适的技能函数
local function GetSkillId(SkillType)
	local function sss(nSeries)
		local nIndex	= Npc.tbSeriesIndex[nSeries];
		local nSkilId	= Npc.tbSkillId[SkillType][nIndex];
		return nSkilId;
	end
	return sss;
end

Npc.tbSkillBase	= {
	sk	= {
		Skill1				= GetSkillId("sk"),
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	noskill	= {
		Skill1				= 0,
		Level1				= 0,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	singleskill	= {
		Skill1				= 1,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	singleskillmelee	= {
		Skill1				= GetSkillId("singleskillmelee"),
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
--中程
	singleskillmidrange	= {
		Skill1				= GetSkillId("singleskillmidrange"),
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
--远程气攻击
	singleskillrange	= {
		Skill1				= GetSkillId("singleskillrange"),
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
--拳,拳+中程,拳+远程
	singleskillfist	= {
		Skill1				= GetSkillId("singleskillfist"),
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	fistandrangegas	= {
		Skill1				= GetSkillId("singleskillfist"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("rangegas"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	fistandsectordart	= {
		Skill1				= GetSkillId("singleskillfist"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("sectordart"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	fistandsectorgas	= {
		Skill1				= GetSkillId("singleskillfist"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("sectorgas"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	fistandmidpenetrable	= {
		Skill1				= GetSkillId("singleskillfist"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("midpenetrable"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	fistandselfround	= {
		Skill1				= GetSkillId("singleskillfist"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("selfround"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
--近身2拳+扇形气攻击
	meleefist2andsectorgas	= {
		Skill1				= GetSkillId("meleefist2"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("sectorgas"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
--箭系列
	singleskillarrow	= {
		Skill1				= GetSkillId("singleskillarrow"),
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	arrowandrangegas	= {
		Skill1				= GetSkillId("singleskillarrow"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("rangegas"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	arrowandrangetwice	= {
		Skill1				= GetSkillId("singleskillarrow"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("rangetwiceskill"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	arrowandrangehack	= {
		Skill1				= GetSkillId("singleskillarrow"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("rangehack"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	arrowandrainarrow	= {
		Skill1				= GetSkillId("singleskillarrow"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("rainarrow"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	arrowandsectordart	= {
		Skill1				= GetSkillId("singleskillarrow"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("sectordart"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	arrowandselfround	= {
		Skill1				= GetSkillId("singleskillarrow"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("selfround"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
--剑,剑+中程,剑+远程
	singleskillsword	= {
		Skill1				= GetSkillId("singleskillsword"),
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	swordandrangehack	= {
		Skill1				= GetSkillId("singleskillsword"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("rangehack"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	swordandrangestab	= {
		Skill1				= GetSkillId("singleskillsword"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("rangestab"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	swordandmeleestab4	= {
		Skill1				= GetSkillId("singleskillsword"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("meleestab4"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	swordandselfround	= {
		Skill1				= GetSkillId("singleskillsword"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("selfround"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
--刀系列
	singleskillblade	= {
		Skill1				= GetSkillId("singleskillblade"),
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	bladeandmeleehack2ex	= {
		Skill1				= GetSkillId("singleskillblade"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("meleehack2ex"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	bladeandrangegas	= {
		Skill1				= GetSkillId("singleskillblade"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("rangegas"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	bladeandrangehack	= {
		Skill1				= GetSkillId("singleskillblade"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("rangehack"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	bladeandrangehack2	= {
		Skill1				= GetSkillId("singleskillblade"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("rangehack2"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	bladeandrangestab	= {
		Skill1				= GetSkillId("singleskillblade"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("rangestab"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	bladeandmeleestab	= {
		Skill1				= GetSkillId("singleskillblade"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("meleestab"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	bladeandselfround	= {
		Skill1				= GetSkillId("singleskillblade"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("selfround"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
--刀2段攻击+2次远程挥砍攻击
	meleehack2andrange	= {
		Skill1				= GetSkillId("meleehack2"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("rangehack2"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
--刀3段攻击+自身范围
	meleehack3andrangehack2	= {
		Skill1				= GetSkillId("meleehack3"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("rangehack2"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
--棍,棍+中程,棍+远程
	singleskillstick	= {
		Skill1				= GetSkillId("singleskillstick"),
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	stickandrangegas	= {
		Skill1				= GetSkillId("singleskillstick"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("rangegas"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	stickandrangehack	= {
		Skill1				= GetSkillId("singleskillstick"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("rangehack"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	stickandselfround	= {
		Skill1				= GetSkillId("singleskillstick"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("selfround"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
--枪,枪+中程,枪+远程
	singleskillspear	= {
		Skill1				= GetSkillId("singleskillspear"),
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	spearandrangehack	= {
		Skill1				= GetSkillId("singleskillspear"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("rangehack"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	spearandmeleestab4	= {
		Skill1				= GetSkillId("singleskillspear"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("meleestab4"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	spearandmeleehack2ex	= {
		Skill1				= GetSkillId("singleskillspear"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("meleehack2ex"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
--锤,锤+中程,锤+远程
	singleskillhammer	= {
		Skill1				= GetSkillId("singleskillhammer"),
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	hammerandrangegas	= {
		Skill1				= GetSkillId("singleskillhammer"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("rangegas"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	hammerandselfround	= {
		Skill1				= GetSkillId("singleskillhammer"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("selfround"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	hammerandtargetround	= {
		Skill1				= GetSkillId("singleskillhammer"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("targetround"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
--逃跑系
	fleeskill	= {
		Skill1				= 0,
		Level1				= 0,
		Skill2				= 1,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	fleeskillmelee	= {
		Skill1				= 0,
		Level1				= 0,
		Skill2				= GetSkillId("singleskillmelee"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	fleeskillmidrange	= {
		Skill1				= 0,
		Level1				= 0,
		Skill2				= GetSkillId("singleskillmidrange"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	fleeskillrange	= {
		Skill1				= 0,
		Level1				= 0,
		Skill2				= GetSkillId("singleskillrange"),
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	healskill	= {
		Skill1				= 133,
		Level1				= 1,
		Skill2				= 1,
		Level2				= 1,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	specialskill	= {
		Skill1				= 45,
		Level1				= 1,
		Skill2				= 1,
		Level2				= 1,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	qiangtianskill	= {			--类似枪天王攻击技能
		Skill1				= 501,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	chuitianskill	= {			--类似锤天王攻击技能
		Skill1				= 503,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	fireskill	= {				--类似弹指烈焰攻击技能
		Skill1				= 505,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	coldskill	= {				--类似冰效果攻击技能
		Skill1				= 506,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	rangetwiceskill	= {			--远程,2次攻击
		Skill1				= GetSkillId("rangetwiceskill"),
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	roundskill	= {				--范围,圆形
		Skill1				= GetSkillId( "roundskill"),
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	semiroundskill	= {			--范围,半圆形
		Skill1				= GetSkillId("semiroundskill"),
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	parallelskill	= {			--范围,平衡
		Skill1				= GetSkillId("parallelskill"),
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	followskill	= {				--子弹跟踪
		Skill1				= GetSkillId("followskill"),
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	certainnormalskill	= {		--定点普通
		Skill1				= GetSkillId("certainnormalskill"),
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	certainflyskill	= {			--定点飞行效果
		Skill1				= GetSkillId("certainflyskill"),
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	certainroundskill	= {		--定点范围
		Skill1				= GetSkillId("certainroundskill"),
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	skill759	= {		--定点范围多次晕眩,
		Skill1				= 759,--该技能使用的一阳指的class,1级50%晕眩,攻击2次
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
--家族副本用各路线npc技能
	daoshao		={		--刀少
		Skill1				= 900,
		Level1				= Npc.tbSkillLv,
		Skill2				= 901,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	gunshao		={		--棍少
		Skill1				= 902,
		Level1				= Npc.tbSkillLv,
		Skill2				= 903,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	qiangtian		={		--枪天
		Skill1				= 904,
		Level1				= Npc.tbSkillLv,
		Skill2				= 906,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	chuitian		={		--锤天
		Skill1				= 908,
		Level1				= Npc.tbSkillLv,
		Skill2				= 910,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	nutang		={		--弩唐
		Skill1				= 912,
		Level1				= Npc.tbSkillLv,
		Skill2				= 913,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	kengtang		={		--坑唐
		Skill1				= 915,
		Level1				= Npc.tbSkillLv,
		Skill2				= 994,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	daodu		={		--刀毒
		Skill1				= 917,
		Level1				= Npc.tbSkillLv,
		Skill2				= 918,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	zhangdu		={		--掌毒
		Skill1				= 919,
		Level1				= Npc.tbSkillLv,
		Skill2				= 920,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	zhange		={		--掌峨
		Skill1				= 921,
		Level1				= Npc.tbSkillLv,
		Skill2				= 922,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	fue		={		--辅娥
		Skill1				= 924,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	jiancui		={		--剑翠
		Skill1				= 925,
		Level1				= Npc.tbSkillLv,
		Skill2				= 926,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	daocui		={		--刀翠
		Skill1				= 927,
		Level1				= Npc.tbSkillLv,
		Skill2				= 928,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	zhanggai		={		--掌丐
		Skill1				= 929,
		Level1				= Npc.tbSkillLv,
		Skill2				= 930,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	gungai		={		--棍丐
		Skill1				= 931,
		Level1				= Npc.tbSkillLv,
		Skill2				= 932,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	zhanren		={		--战忍
		Skill1				= 933,
		Level1				= Npc.tbSkillLv,
		Skill2				= 934,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	moren		={		--魔忍
		Skill1				= 935,
		Level1				= Npc.tbSkillLv,
		Skill2				= 936,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	qiwu		={		--气武
		Skill1				= 937,
		Level1				= Npc.tbSkillLv,
		Skill2				= 938,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	jianwu		={		--剑武
		Skill1				= 939,
		Level1				= Npc.tbSkillLv,
		Skill2				= 940,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	daokun		={		--刀昆
		Skill1				= 941,
		Level1				= Npc.tbSkillLv,
		Skill2				= 942,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	jiankun		={		--剑昆
		Skill1				= 943,
		Level1				= Npc.tbSkillLv,
		Skill2				= 944,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	chuiming		={		--锤明
		Skill1				= 946,
		Level1				= Npc.tbSkillLv,
		Skill2				= 948,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	jianming		={		--剑明
		Skill1				= 949,
		Level1				= Npc.tbSkillLv,
		Skill2				= 950,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	zhiduan		={		--指段
		Skill1				= 952,
		Level1				= Npc.tbSkillLv,
		Skill2				= 954,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	jianduan		={		--剑段
		Skill1				= 956,
		Level1				= Npc.tbSkillLv,
		Skill2				= 957,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	--藏宝图
	cangbaotuboss2sk	= {		--藏宝图boss2的定点攻击和怒气
		Skill1				= 666,
		Level1				= 10,
		Skill2				= 671,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	cangbaotuboss2717	= {		--副本第一个BOSS
		Skill1				= 971,
		Level1				= Npc.tbSkillLv,
		Skill2				= 967,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	cangbaotuboss2718	= {		--副本第二个BOSS
		Skill1				= 690,
		Level1				= 10,
		Skill2				= 970,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	cangbaotu2713		= {		--副本第1种小怪
		Skill1				= 968,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	cangbaotu2714		= {		--副本第2种小怪
		Skill1				= 969,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	cangbaotu2715		= {		--副本第3种小怪
		Skill1				= 970,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	cangbaotu2716		= {		--副本第4种小怪
		Skill1				= 967,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	cangbaotu2732		= {		--高级藏宝图小怪
		Skill1				= 1010,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	cangbaotu2733		= {		--高级藏宝图小怪
		Skill1				= 1010,
		Level1				= Npc.tbSkillLv,
		Skill2				= 1016,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	cangbaotu2734		= {		--高级藏宝图小怪
		Skill1				= 1006,
		Level1				= Npc.tbSkillLv,
		Skill2				= 1005,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	cangbaotu2735		= {		--高级藏宝图小怪
		Skill1				= 938,
		Level1				= Npc.tbSkillLv,
		Skill2				= 1015,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
--某副本用小怪ai
	certainroundskillandbellow		= {		--定点范围+狮子吼
		Skill1				= 938,
		Level1				= Npc.tbSkillLv,
		Skill2				= 31,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
--80-90级任务副本用小怪ai
	npc4001		= {		--天罡地煞+冻结+迟缓陷阱
		Skill1				= 920,
		Level1				= 1,
		Skill2				= 1016,
		Level2				= 2,
		Skill3				= 71,
		Level3				= 20,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4005		= {		--自身范围攻击+断魂
		Skill1				= 1005,
		Level1				= Npc.tbSkillLv,
		Skill2				= 983,
		Level2				= 1,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4007		= {		--伏魔棍法+狮子吼
		Skill1				= 903,
		Level1				= Npc.tbSkillLv,
		Skill2				= 989,
		Level2				= 5,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4008		= {		--近身2段攻击+断魂刺
		Skill1				= GetSkillId("meleehack2"),
		Level1				= 8,
		Skill2				= 983,
		Level2				= 1,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4009		= {		--扇形箭攻击,带击退效果
		Skill1				= 986,
		Level1				= 1,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4089		= {		--定点冰心仙子
		Skill1				= 1008,
		Level1				= 1,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	xoyo3249	= {		--弹幕
		Skill1				= 1096,
		Level1				= 1,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	duanjinren	= {		--断筋刃+定点攻击
		Skill1				= 266,
		Level1				= 10,
		Skill2				= certainroundskill,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	moyinshipo	= {		--自身范围攻击+混乱
		Skill1				= 1005,
		Level1				= Npc.tbSkillLv,
		Skill2				= 148,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	toutianhuanri	= {		--自身范围攻击+偷天换日
		Skill1				= 1005,
		Level1				= Npc.tbSkillLv,
		Skill2				= 1093,
		Level2				= 1,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	zuixiancuogu	= {		--自身范围攻击+醉仙错骨
		Skill1				= 1005,
		Level1				= Npc.tbSkillLv,
		Skill2				= 699,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	huanyingzhuihunqiang	= {		--自身范围攻击+幻影追魂枪
		Skill1				= 1005,
		Level1				= Npc.tbSkillLv,
		Skill2				= 484,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc2759	= {		--天竺绝刀+无我无剑
		Skill1				= 1032,
		Level1				= 10,
		Skill2				= 938,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc2775	= {		--天竺绝刀
		Skill1				= 1032,
		Level1				= 10,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc2782	= {		--狂雷震地+大范围回血技能
		Skill1				= 943,
		Level1				= 10,
		Skill2				= 1132,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc2776	= {		--近身2次攻击+断魂刺
		Skill1				= GetSkillId("meleehack2"),
		Level1				= 10,
		Skill2				= 983,
		Level2				= 1,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc2761	= {		--无我无剑+怒雷连环击
		Skill1				= 938,
		Level1				= 10,
		Skill2				= 1131,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc2764	= {		--六脉神剑+冰踪无影
		Skill1				= 1069,
		Level1				= 10,
		Skill2				= 1050,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
-------------------宋金------------------------
	song	= {		--天地无极
		Skill1				= 1058,
		Level1				= 20,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	jin	= {			--天外流星
		Skill1				= 1056,
		Level1				= 20,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
--------------------任务
	npc4126_1		={		--刀毒10技能
		Skill1				= 917,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4127_3	={		--掌毒90+技能，会放诅咒，掌毒50级技能（小几率）
		Skill1				= 917,
		Level1				= Npc.tbSkillLv,
		Skill2				= 920,
		Level2				= Npc.tbSkillLv,
		Skill3				= 88,
		Level3				= 20,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4128_1		={		--刀毒50技能
		Skill1				= 918,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4131_2		={		--锤明10级技能+断筋刃
		Skill1				= 946,
		Level1				= Npc.tbSkillLv,
		Skill2				= 266,
		Level2				= 20,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4132_2		={		--剑翠90+50
		Skill1				= 1048,
		Level1				= Npc.tbSkillLv,
		Skill2				= 926,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4136_2		={		--枪天90+断魂
		Skill1				= 1034,
		Level1				= Npc.tbSkillLv,
		Skill2				= 983,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4142_1		={		--刀翠90
		Skill1				= 1050,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4145_2		={		--战忍90+拉人
		Skill1				= 1055,
		Level1				= Npc.tbSkillLv,
		Skill2				= 492,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4146_2		={		--魔忍90+诅咒
		Skill1				= 1056,
		Level1				= Npc.tbSkillLv,
		Skill2				= 154,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4148_2		={		--剑昆50+90
		Skill1				= 944,
		Level1				= Npc.tbSkillLv,
		Skill2				= 1063,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4152_3		={		--阴风蚀骨,小李飞刀,乱环击
		Skill1				= 1044,
		Level1				= Npc.tbSkillLv,
		Skill2				= 915,
		Level2				= Npc.tbSkillLv,
		Skill3				= 1039,
		Level3				= Npc.tbSkillLv,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4153_1		={		--风霜碎影
		Skill1				= 1046,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4156_2		={		--锤天90+断魂
		Skill1				= 1036,
		Level1				= Npc.tbSkillLv,
		Skill2				= 983,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4157_3		={		--小李飞刀,勾魂阱,缠身刺
		Skill1				= 915,
		Level1				= Npc.tbSkillLv,
		Skill2				= 71,
		Level2				= 20,
		Skill3				= 73,
		Level3				= 20,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4159_1		={		--六脉神剑
		Skill1				= 1069,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4160_3		={		--龙吞式+断魂刺
		Skill1				= 1064,
		Level1				= Npc.tbSkillLv,
		Skill2				= 983,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4162_1		={		--飞龙在天
		Skill1				= 1052,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4170_1		={		--追星逐月
		Skill1				= 1052,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
-------区域争夺战---------
	domain_soldier	= {		--直线单体+直线穿透
		Skill1				= 1033,
		Level1				= 10,
		Skill2				= 1032,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	domain_general	= {		--自身范围+自身特大范围攻击
		Skill1				= 1139,
		Level1				= 20,
		Skill2				= 1140,
		Level2				= 20,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
---------------师徒任务--------------------
	shitu01	= {		--山寨先锋
		Skill1				= 1034,
		Level1				= 20,
		Skill2				= 983,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	shitu02	= {		--山寨弓手
		Skill1				= 1056,
		Level1				= 20,
		Skill2				= 992,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	shitu03	= {		--山寨巫医
		Skill1				= GetSkillId("sectorgas"),
		Level1				= Npc.tbSkillLv,
		Skill2				= 88,
		Level2				= 20,
		Skill3				= 147,
		Level3				= 10,
		Skill4				= 0,
		Level4				= 0,
	},
------------------120-130任务--------------------------
	npc4488	= {		--陷阱:小李,乱环,缠身
		Skill1				= 915,
		Level1				= Npc.tbSkillLv,
		Skill2				= 1039,
		Level2				= 20,
		Skill3				= 73,
		Level3				= 20,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4489	= {		--袖箭:暴雨,天罗,断筋
		Skill1				= 992,
		Level1				= Npc.tbSkillLv,
		Skill2				= 913,
		Level2				= Npc.tbSkillLv,
		Skill3				= 266,
		Level3				= 10,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4490	= {		--飞镖:散花+九宫
		Skill1				= 741,
		Level1				= Npc.tbSkillLv,
		Skill2				= 1162,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4498	= {		--掌毒:阴风+悲魔
		Skill1				= 1144,
		Level1				= Npc.tbSkillLv,
		Skill2				= 88,
		Level2				= 20,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4499	= {		--掌毒:玄阴斩
		Skill1				= 1042,
		Level1				= Npc.tbSkillLv,
		Skill2				= 269,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4500	= {		--刀昆:傲雪啸风
		Skill1				= 1061,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4501	= {		--刀昆:狂风骤电
		Skill1				= 942,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4507	= {		--掌峨:风霜碎影
		Skill1				= 1046,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4512	= {		--战忍:云龙击,魔音
		Skill1				= 1055,
		Level1				= Npc.tbSkillLv,
		Skill2				= 148,
		Level2				= 20,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4519	= {		--战忍:云龙击
		Skill1				= 1055,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4521	= {		--锤天:乘龙+断魂
		Skill1				= 1036,
		Level1				= Npc.tbSkillLv,
		Skill2				= 983,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	fleenpc4521	= {		--锤天:乘龙+断魂
		Skill1				= 0,
		Level1				= 0,
		Skill2				= 1036,
		Level2				= Npc.tbSkillLv,
		Skill3				= 983,
		Level3				= 10,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4525	= {		--锤明:龙吞+困虎
		Skill1				= 1064,
		Level1				= Npc.tbSkillLv,
		Skill2				= 958,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	fleenpc4525	= {		--锤明:龙吞+困虎
		Skill1				= 0,
		Level1				= 0,
		Skill2				= 1064,
		Level2				= Npc.tbSkillLv,
		Skill3				= 958,
		Level3				= 10,
		Skill4				= 0,
		Level4				= 0,

	},
	npc4531	= {		--魔忍:天外流星+慑魂乱心
		Skill1				= 1056,
		Level1				= Npc.tbSkillLv,
		Skill2				= 155,
		Level2				= 20,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4543	= {		--枪天:追星+断魂
		Skill1				= 1064,
		Level1				= Npc.tbSkillLv,
		Skill2				= 983,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	fleenpc4543	= {		--枪天:追星+断魂
		Skill1				= 0,
		Level1				= 0,
		Skill2				= 1064,
		Level2				= Npc.tbSkillLv,
		Skill3				= 983,
		Level3				= 10,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4544	= {		--剑翠:冰心+雨打梨花
		Skill1				= 1048,
		Level1				= Npc.tbSkillLv,
		Skill2				= 1209,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4548	= {		--刀少:天竺绝刀
		Skill1				= 1032,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	fleenpc4548	= {		--刀少:天竺绝刀
		Skill1				= 0,
		Level1				= 0,
		Skill2				= 1032,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	npc4550	= {		--剑明:90+50
		Skill1				= 1066,
		Level1				= Npc.tbSkillLv,
		Skill2				= 950,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
-------------各路线使用90级技能-------------
	daoshao90_1		={		--刀少
		Skill1				= 1032,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	gunshao90_2		={		--棍少
		Skill1				= 1033,
		Level1				= Npc.tbSkillLv,
		Skill2				= 989,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	qiangtian90_2		={		--枪天
		Skill1				= 1034,
		Level1				= Npc.tbSkillLv,
		Skill2				= 983,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	chuitian90_2		={		--锤天
		Skill1				= 1036,
		Level1				= Npc.tbSkillLv,
		Skill2				= 983,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	nutang90_2		={		--弩唐
		Skill1				= 992,
		Level1				= Npc.tbSkillLv,
		Skill2				= 266,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	kengtang90_2		={		--坑唐
		Skill1				= 994,
		Level1				= Npc.tbSkillLv,
		Skill2				= 1039,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	kengtang90_3		={		--坑唐
		Skill1				= 915,
		Level1				= Npc.tbSkillLv,
		Skill2				= 994,
		Level2				= Npc.tbSkillLv,
		Skill3				= 1039,
		Level3				= Npc.tbSkillLv,
		Skill4				= 0,
		Level4				= 0,
	},
	daodu90_2		={		--刀毒
		Skill1				= 1042,
		Level1				= Npc.tbSkillLv,
		Skill2				= 82,
		Level2				= 20,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	zhangdu90_2		={		--掌毒
		Skill1				= 1044,
		Level1				= Npc.tbSkillLv,
		Skill2				= 88,
		Level2				= 20,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	zhange90_1		={		--掌峨
		Skill1				= 1046,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	fue90_1		={		--辅娥
		Skill1				= 924,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	jiancui90_2		={		--剑翠
		Skill1				= 1048,
		Level1				= Npc.tbSkillLv,
		Skill2				= 1209,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	daocui90_1		={		--刀翠
		Skill1				= 1050,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	zhanggai90_1		={		--掌丐
		Skill1				= 1052,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	gungai90_2		={		--棍丐
		Skill1				= 1054,
		Level1				= Npc.tbSkillLv,
		Skill2				= 491,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	zhanren90_3		={		--战忍
		Skill1				= 1055,
		Level1				= Npc.tbSkillLv,
		Skill2				= 492,
		Level2				= 10,
		Skill3				= 148,
		Level3				= 20,
		Skill4				= 0,
		Level4				= 0,
	},
	moren90_3		={		--魔忍
		Skill1				= 1056,
		Level1				= Npc.tbSkillLv,
		Skill2				= 936,
		Level2				= Npc.tbSkillLv,
		Skill3				= 155,
		Level3				= 20,
		Skill4				= 0,
		Level4				= 0,
	},
	qiwu90_1		={		--气武
		Skill1				= 1058,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	jianwu90_2		={		--剑武
		Skill1				= 1059,
		Level1				= Npc.tbSkillLv,
		Skill2				= 1216,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	daokun90_1		={		--刀昆
		Skill1				= 1061,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	jiankun90_3		={		--剑昆
		Skill1				= 943,
		Level1				= Npc.tbSkillLv,
		Skill2				= 944,
		Level2				= Npc.tbSkillLv,
		Skill3				= 1063,
		Level3				= Npc.tbSkillLv,
		Skill4				= 0,
		Level4				= 0,
	},
	chuiming90_2		={		--锤明
		Skill1				= 1064,
		Level1				= Npc.tbSkillLv,
		Skill2				= 983,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	jianming90_3		={		--剑明
		Skill1				= 949,
		Level1				= Npc.tbSkillLv,
		Skill2				= 950,
		Level2				= Npc.tbSkillLv,
		Skill3				= 1066,
		Level3				= Npc.tbSkillLv,
		Skill4				= 0,
		Level4				= 0,
	},
	zhiduan90_2		={		--指段
		Skill1				= 1067,
		Level1				= Npc.tbSkillLv,
		Skill2				= 216,
		Level2				= 10,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	jianduan90_2		={		--剑段
		Skill1				= 1069,
		Level1				= Npc.tbSkillLv,
		Skill2				= 957,
		Level2				= Npc.tbSkillLv,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},

	--逍遥谷2期
	xoyo_jiancui		={		--剑翠90
		Skill1				= 1048,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
--秦始皇陵
	bmy_normalskill		={		--各种远程单体技能
		Skill1				= GetSkillId("accidence"),
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
--范围攻击+高威力技能
	roundandpowerful	= {
		Skill1				= GetSkillId("advanced"),
		Level1				= Npc.tbSkillLv,
		Skill2				= GetSkillId("powerful"),
		Level2				= 20,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
--逍遥谷3期
	xoyo4660_1	= {
		Skill1				= 1427,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	xoyo4661_1	= {
		Skill1				= 1056,
		Level1				= Npc.tbSkillLv,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
--清明节活动
	plant	= {--植物
		Skill1				= {{1,1603},{2,1604},{3,1605},{4,1605}},
		Level1				= 1,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
	corpse	= {--僵尸
		Skill1				= {{1,1617},{2,1618},{3,1619},{4,1619}},
		Level1				= 1,
		Skill2				= 0,
		Level2				= 0,
		Skill3				= 0,
		Level3				= 0,
		Skill4				= 0,
		Level4				= 0,
	},
};

--强度基础模板
--根据数据表返回多倍数值
--tbDataTemplet:	数值表的name
--multiple:			最终对应级别的数值是攻击表内的值的倍数,可不填,默认为1
local function GetData(tbDataTemplet, multiple)
	local function eee(nSeries, nLevel)
		local data = {};--攻击表
		data = tbDataTemplet
		multiple = multiple or 1;
		local data_v = math.floor( Lib.Calc:Link(nLevel, data) * multiple);
		return data_v;
	end;
	return eee;
end

--五行相克表,表中的值表示该行属性的NPC的列抗性高低(均按"无金木水火土"的顺序)
Npc.tbXiangKe	=	{	{ 2, 2, 2, 2, 2 },
						{ 2, 3, 2, 1, 2 },
						{ 1, 2, 2, 2, 3 },
						{ 2, 2, 2, 3, 1 },
						{ 3, 2, 1, 2, 2 },
						{ 2, 1, 3, 2, 2 }}

--根据tbResist和s返回合适的抗性函数
local function GetResist(tbResist, s)
	local function rrr(nSeries,nLevel)
		local rs = {};
		local nIndex = Npc.tbSeriesIndex[nSeries];
		local xk 	= Npc.tbXiangKe[nIndex][s];
		rs =  tbResist[xk];
		local sz = ""
		local rs_v = Lib.Calc:Link(nLevel,rs);
		sz = "nSeries="..nSeries..",DefSeries="..s..",xk="..xk..",nLevel"..nLevel..",rs_v="..rs_v;
--		print(sz)
		return rs_v;
	end;
	return rrr;
end

--npc五行属性与五行攻击的关系表,行五行的npc的列属性攻击
Npc.tbSeriesAtk	=	{	{ 1, 0, 0, 0, 0 },
						{ 1, 0, 0, 0, 0 },
						{ 0, 2, 0, 0, 0 },
						{ 0, 0, 1, 0, 0 },
						{ 0, 0, 0, 1, 0 },
						{ 0, 0, 0, 0, 1 }}
--根据五行和需要的攻击属性返回合适的攻击函数
--tbAtk:	攻击表的name
--s:		五行
--multiple:	最终攻击是攻击表内的值的倍数,可不填,默认为1
local function GetAtack(tbAtk, s, multiple)
	local function xxx(nSeries, nLevel)
		local atk = {};--攻击表
		local nIndex	= Npc.tbSeriesIndex[nSeries];
		local atktype 	= Npc.tbSeriesAtk[nIndex][s];
		local sz = ""
		if atktype == 2 then
			atk = tbAtk[atktype];
		elseif atktype == 1 then
			atk = tbAtk[atktype];
		else atk = 0;
		end;
		multiple = multiple or 1;
		local atk_v = math.floor( Lib.Calc:Link(nLevel,atk) * multiple);
		return atk_v;
	end;
	return xxx;
end

--根据五行返回合适的数值
local function GetSeriesData(tbData)
	local function ppp(nSeries)
		local nIndex	= Npc.tbSeriesIndex[nSeries];
		local nData	= tbData[nIndex];
		return nData;
	end
	return ppp;
end

--根据五行和等级返回合适的数值
local function GetSLData(tbData, multiple)
	local function ppp(nSeries, nLevel)
		local nIndex	= Npc.tbSeriesIndex[nSeries];
		local Data = {};
		Data = tbData[nIndex];
		multiple = multiple or 1;
		local Data_v = math.floor( Lib.Calc:Link(nLevel, Data) * multiple);
		return Data_v;
	end
	return ppp;
end

--常用数据表
Npc.tbDataTemplet={
	intensity99 = {		--练级怪经验表
					{  1,   50},{  9,   50},
					{ 10,  100},{ 19,  100},
					{ 20,  150},{ 29,  150},
					{ 30,  200},{ 39,  200},
					{ 40,  300},{ 49,  300},
					{ 50,  400},{ 59,  400},
					{ 60,  500},{ 69,  500},
					{ 70,  650},{ 79,  650},
					{ 80,  800},{ 89,  800},
					{ 90,  850},{ 99,  850},
					{100,  900},{109,  900},
					{110,  950},{119,  950},
					{120,  1000},{129, 1000},
					{130,  1100},{139, 1100},
					{140,  1250},{150, 1250},
				 },
	cangbaotuboss1_Exp		= { {  1,     50},{  9,     50},
								{ 10,   2690},{ 19,   2708},
								{ 20,   2990},{ 29,   3008},
								{ 30,   5950},{ 39,   6040},
								{ 40,  65000},{ 49,  65000},
								{ 50,  65000},{ 59,  65000},
								{ 60, 150000},{ 69, 150000},
								{ 70, 300000},{ 79, 300000},
								{ 80,   2000},{ 89,   2090},
								{ 90, 300000},{ 99, 300000},
								{100, 300000},{109, 300000},
								{110,   3300},{119,   3525},
								{120,   3900},{129,   4170},
								{130,   4500},{139,   4950},
								{140,   5200},{150,   5500},
							  },
	cangbaotuboss2_Exp		= { {  1,     50},{  9,     50},
								{ 10,   2690},{ 19,   2708},
								{ 20,   2990},{ 29,   3008},
								{ 30,   5950},{ 39,   6040},
								{ 40,  65000},{ 49,  65000},
								{ 50,  65000},{ 59,  65000},
								{ 60, 150000},{ 69, 150000},
								{ 70, 300000},{ 79, 300000},
								{ 80,   2000},{ 89,   2090},
								{ 90, 600000},{ 99, 600000},
								{100, 600000},{109, 600000},
								{110,   3300},{119,   3525},
								{120,   3900},{129,   4170},
								{130,   4500},{139,   4950},
								{140,   5200},{150,   5500},
							  },
	mingfuyuanhunLife	= {		--冥府冤魂生命值表
							{1,180},{9,360},{10,54800},{60,1279400},{100,2924400},
							},
	intensity99_Life	= {		--练级怪生命值表,战斗时间3秒
							{1,3000},{9,4000},{10,5000},{20,8000},{30,37000},{40,161000},{50,281000},{60,373000},{90,744000},{100,1069000},
							},
	domain_Life			= {		--练级怪生命值表,战斗时间3秒
							{1,90},{9,180},{10,250},{20,980},{30,2370},{40,3610},{50,4810},{60,6730},{90,14440},{100,19690},{105,29000},{120,39247},
							},
	intensity2_Life		= {		--强度2怪的生命值表
							{1,90},{9,180},{10,2400},{30,21200},{60,64000},{100,146200},
							},
	intensity3_Life		= {		--强度3怪的生命值表
							{1,90},{9,180},{10,3400},{30,30300},{60,82000},{100,246100},
							},
	intensity4_Life		= {
							{1,90},{9,180},{10,6100},{30,53800},{60,159900},{100,365500},
							},
	intensity5_Life		= {		--强度5怪的生命值表
							{1,90},{9,180},{10,9100},{60,213200},{100,487400},
							},
	intensity7_Life		= {
							{1,90},{9,180},{10,18300},{60,426500},{100,974800},
							},
	intensity8_Life		= {		--强度8怪的生命值表
							{1,90},{9,180},{10,27400},{60,639700},{100,1462200},
							},
	intensity9_Life		= {		--强度9怪的生命值表
							{1,90},{9,180},{10,54800},{60,1300000},{100,3000000},
							},
	battle2_Life		= {		--宋金校尉的生命值表
							{1,90},{60,24700},{90,49300},{100,65800},
							},
	battle3_Life		= {		--宋金统领的生命值表
							{1,90},{60,64000},{90,109700},{100,146200},
							},
	battle4_Life		= {		--宋金副将的生命值表
							{1,90},{60,1371000},{90,2742000},{100,3655000},
							},

	battle5_Life		= {		--宋金大将的生命值表
							{1,900},{9,1800},{10,274000},{60,6397000},{100,14622000},
							},
	battle6_Life		= {		--宋金大将的生命值表
							{1,900},{9,1800},{10,274000},{60,6397000},{100,14622000},
							},
--区域争夺战
--+8套
	dispute8_Life		= {		--全身+8的玩家生命值表
							{1,90},{9,180},{85,5000},{95,6000},{105,6300},{115,7000},
							},
--+10套
	dispute10_Life		= {		--全身+10的玩家生命值表
							{1,90},{9,180},{85,5800},{95,6700},{105,7000},{115,7750},
							},
--+12套
	dispute12_Life		= {		--全身+12的玩家生命值表
							{1,90},{9,180},{85,6250},{95,7200},{105,7650},{115,8500},
							},
--+14套
	dispute14_Life		= {		--全身+14的玩家生命值表
							{1,90},{9,180},{85,6850},{95,8000},{105,8500},{115,9500},
							},
	wanted_LifeReplenish	= {	--通缉任务npc回血速度
								{1,1},{10,375},{20,1500},{30,3250},{40,4500},{50,5500},{60,7500},{90,15000},{100,20000}
								},
	}

--抗性表
Npc.tbResist = {
	--pp级怪,未使用
	pp 		=	{	[1] = {{1, 5},{20, 10},{50, 18},{100, 30}},--低抗
					[2] = {{1,20},{20, 50},{50,150},{100,350}},--中抗
					[3] = {{1,40},{20,120},{50,300},{100,800}},--高抗
				},

	--普通强度怪
	--练级怪intensity0,fellow0-5全部跟随npc,宋金士兵,白虎堂普通npc
	normal		=	{	[1] = {{1,20},{9, 28},{10, 65},{100,245}},--低抗
						[2] = {{1,20},{9, 28},{10, 65},{100,245}},--中抗
						[3] = {{1,20},{9, 28},{10, 90},{ 30,130},{50,210},{100,260}},--高抗
					},
	--高强度怪
	--intensity1-intensity5,宋金校尉,统领,副将和大将,
	special	=	{	[1] = {{1,20},{9,28},{10, 50},{100,270}},--低抗
					[2] = {{1,20},{9,28},{10, 90},{100,360}},--中抗
					[3] = {{1,20},{9,28},{10,150},{100,528}},--高抗
				},
	--boss级怪
	--intensity6-intensity8,宋金元帅,白虎堂boss,世界boss1
	boss1 		=	{	[1] = {{1,20},{9,28},{10, 54},{100,288}},--低抗
						[2] = {{1,20},{9,28},{10,105},{100,420}},--中抗
						[3] = {{1,20},{9,28},{10,160},{100,565}},--高抗
				},
--区域争夺战
--+8套
	dispute8	= {		--全身+8的玩家抗性表
						[1] = {{1,20},{9,28},{85,115},{95,133},{105,150},{115,150}},--低抗
						[2] = {{1,20},{9,28},{85,215},{95,233},{105,250},{115,250}},--中抗
						[3] = {{1,20},{9,28},{85,415},{95,433},{105,450},{115,450}},--高抗
						},
--+10套
	dispute10	= {		--全身+8的玩家抗性表
						[1] = {{1,20},{9,28},{85,138},{95,152},{105,165},{115,165}},--低抗
						[2] = {{1,20},{9,28},{85,238},{95,252},{105,265},{115,265}},--中抗
						[3] = {{1,20},{9,28},{85,338},{95,352},{105,365},{115,365}},--高抗
						},
--+12套
	dispute12	= {		--全身+8的玩家抗性表
						[1] = {{1,20},{9,28},{85,156},{95,171},{105,180},{115,180}},--低抗
						[2] = {{1,20},{9,28},{85,256},{95,271},{105,280},{115,280}},--中抗
						[3] = {{1,20},{9,28},{85,356},{95,371},{105,380},{115,380}},--高抗
						},
--+14套
	dispute14	= {		--全身+14的玩家抗性表
						[1] = {{1,20},{9,28},{85,185},{95,200},{105,210},{115,210}},--低抗
						[2] = {{1,20},{9,28},{85,285},{95,300},{105,310},{115,310}},--中抗
						[3] = {{1,20},{9,28},{85,485},{95,500},{105,510},{115,510}},--高抗
						},
--秦始皇陵,小兵抗性
	bmy	= {		--全身+14的玩家抗性表
						[1] = {{1,   1},{9,   1}},--低抗
						[2] = {{1, 375},{9, 375}},--中抗
						[3] = {{1,1500},{9,1500}},--高抗
						},
};

--攻击力表
Npc.tbDamage = {
	--pp级怪,未使用
	pp 			=	{	[1] = {	{1, 1},{9,10},{10,20},{60,260},{100,420} },	--正常攻击
						[2] = { {1, 1},{9, 5},{10,10},{60,130},{100,210} },	--毒伤害
					},
	--练级怪intensity0~1,跟随怪fellow0-2
	intensity0		=	{	[1] = { {1, 1},{9,10},{10,20},{30,45},{60,120},{100,230} },	--正常攻击
							[2] = { {1, 1},{9, 5},{10,10},{30,20},{60, 60},{100,115} }, --毒伤害
						},
	--特殊怪intensity2~5,宋金士兵,白虎堂普通Npc
	intensity1		=	{	[1] = { {1, 1},{9,10},{10,25},{30,62},{60,180},{100,345} },	--正常攻击
							[2] = { {1, 1},{9, 5},{10,12},{30,30},{60, 90},{100,170} },	--毒伤害
						},
	--特殊怪intensity6~8,宋金校尉,统领,副将
	intensity2 	=	{	[1] = { {1, 1},{9,10},{10,35},{30,75},{60,240},{100,460} },	--正常攻击
						[2] = { {1, 1},{9, 5},{10,16},{30,35},{60,120},{100,230} }, --毒伤害
					},
	--宋金大将,白虎堂boss,藏宝图小怪
	intensity3 	=	{	[1] = { {1,100},{9,250},{10,510},{60,3500},{100,5750} },	--正常攻击
						[2] = { {1, 50},{9,120},{10,260},{60,1700},{100,2900} },	--毒伤害
					},
	--宋金元帅
	intensity4 	=	{	[1] = { {1,10},{9,25},{10,54},{60,420},{100,690} },	--正常攻击
						[2] = { {1, 5},{9,18},{10,27},{60,210},{100,345} },	--毒伤害
					},
	--
	intensity5 	=	{	[1] = { {1,10},{9,25},{10,76},{60,490},{100,800} },	--正常攻击
						[2] = { {1, 5},{9,17},{10,38},{60,245},{100,400} },	--毒伤害
					},
	--藏宝图boss
	intensity6 	=	{	[1] = { {1,10},{9,25},{10,78},{60,560},{100,920} },	--正常攻击
						[2] = { {1, 5},{9,13},{10,39},{60,280},{100,460} },	--毒伤害
					},
	--特殊怪fellow3,4,5
	fellow3	 	=	{	[1] = { {1,800},{9,1820},{10,4870},{60,5000},{100,6000} },	--正常攻击
						[2] = { {1,400},{9, 910},{10,2430},{60,5000},{100,6000} },	--毒伤害
					},
	--世界boss1
	boss1		 	=	{	[1] = { {1,10},{55,1000},{75,2000},{95,4000},{100,5000} },	--正常攻击
							[2] = { {1, 10},{55, 1000},{75,2000},{95,4000},{100,5000} },	--毒伤害
						},
	--藏宝图boss1
	cangbaotuboss1	=	{	[1] = { {1,150},{9,400},{10,1100},{60,5800},{100,8000} },	--正常攻击
							[2] = { {1, 70},{9,200},{10, 550},{60,2900},{100,4000} },	--毒伤害
						},
	--家族副本_心魔
	xinmo			=	{	[1] = { {1, 1},{9,10},{10,20},{30,45},{60,180},{100,345} },	--正常攻击
							[2] = { {1, 1},{9, 5},{10,10},{30,20},{60, 90},{100,170} },	--毒伤害
						},
--区域争夺战
	--全身+8的玩家攻击力表
	dispute8		=	{	[1] = { {1, 1},{9,10},{85,6000},{95,7000},{105,9000},{115,9500} },	--正常攻击
							[2] = { {1, 1},{9, 5},{85,4000},{95,4700},{105,6000},{115,6365} },	--毒伤害
						},
	--全身+10的玩家攻击力表
	dispute10		=	{	[1] = { {1, 1},{9,10},{85,6500},{95,7500},{105,9500},{115,10750} },	--正常攻击
							[2] = { {1, 1},{9, 5},{85,4000},{95,4700},{105,6000},{115, 6365} },	--毒伤害
						},
	--全身+12的玩家攻击力表
	dispute12		=	{	[1] = { {1, 1},{9,10},{85,7000},{95,8000},{105,10000},{115,12000} },	--正常攻击
							[2] = { {1, 1},{9, 5},{85,4690},{95,5360},{105, 6700},{115, 8040} },	--毒伤害
						},
	--全身+14的玩家攻击力表
	dispute14		=	{	[1] = { {1, 1},{9,10},{85,7750},{95,8800},{105,11000},{115,14000} },	--正常攻击
							[2] = { {1, 1},{9, 5},{85,5200},{95,5900},{105, 7370},{115, 9380} },	--毒伤害
						},
	--区域争夺战npc,100级以后攻击提高
	domainatk	=	{	[1] = { {1,80},{9,182},{10,487},{85,2881*1.1},{95,3200*1.2},{105,3520*1.3},{120,3700*1.3} },	--正常攻击
						[2] = { {1,40},{9, 91},{10,243},{85,1440*1.1},{95,1600*1.2},{105,1760*1.3},{120,1850*1.3} },	--毒伤害
					},
---秦始皇陵
	bmy_soldier1=	{	[1] = { {1,1000},{9,1000}},	--正常攻击
						[2] = { {1, 500},{9, 500}},	--毒伤害
					},
	bmy_soldier2=	{	[1] = { {1,1384},{9,1384}},	--正常攻击
						[2] = { {1, 692},{9, 692}},	--毒伤害
					},
	bmy_soldier3=	{	[1] = { {1,1600},{9,1600}},	--正常攻击
						[2] = { {1, 800},{9, 800}},	--毒伤害
					},
	bmy_soldier4=	{	[1] = { {1,2000},{9,2000}},	--正常攻击
						[2] = { {1,1000},{9,1000}},	--毒伤害
					},

	bmy_leader1	=	{	[1] = { {1,1300},{9,1300}},	--正常攻击
						[2] = { {1, 650},{9, 650}},	--毒伤害
					},
	bmy_leader2	=	{	[1] = { {1,1500},{9,1500}},	--正常攻击
						[2] = { {1, 750},{9, 750}},	--毒伤害
					},
	bmy_leader3	=	{	[1] = { {1,2000},{9,2000}},	--正常攻击
						[2] = { {1,1000},{9,1000}},	--毒伤害
					},
	bmy_leader4	=	{	[1] = { {1,2200},{9,2200}},	--正常攻击
						[2] = { {1,1100},{9,1100}},	--毒伤害
					},

	bmy_elite1	=	{	[1] = { {1,1600},{9,1600}},	--正常攻击
						[2] = { {1, 800},{9, 800}},	--毒伤害
					},
	bmy_elite2	=	{	[1] = { {1,1600},{9,1600}},	--正常攻击
						[2] = { {1, 800},{9, 800}},	--毒伤害
					},
	bmy_elite3	=	{	[1] = { {1,2400},{9,2400}},	--正常攻击
						[2] = { {1,1200},{9,1200}},	--毒伤害
					},
	bmy_elite4	=	{	[1] = { {1,2800},{9,2800}},	--正常攻击
						[2] = { {1,1400},{9,1400}},	--毒伤害
					},

	bmy_fellow1=	{	[1] = { {1,3840},{9,3840}},	--正常攻击
						[2] = { {1,1920},{9,1920}},	--毒伤害
					},
	bmy_fellow2=	{	[1] = { {1,3840},{9,3840}},	--正常攻击
						[2] = { {1,1920},{9,1920}},	--毒伤害
					},
};


Npc.tbPropBase	= {
	pp	= {
		Exp					= 0,
		Life				= {{1,90},{9,180},{10,250},{20,1150},{60,8480},{100,21880},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750}, },
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,3},{30,17*0.4},{31,20*0.4},{60,45*0.4},{61,50*0.4},{80,70*0.4},{81,86*0.4},{91,113*0.6},{100,122*0.4}, },
		MaxDamage			= {{1,3},{30,17*0.6},{31,20*0.6},{60,45*0.6},{61,50*0.6},{80,70*0.6},{81,86*0.6},{91,113*0.6},{100,122*0.6}, },
		PhysicsResist		= GetResist(Npc.tbResist.pp, 1),
		PoisonResist		= GetResist(Npc.tbResist.pp, 2),
		ColdResist			= GetResist(Npc.tbResist.pp, 3),
		FireResist 			= GetResist(Npc.tbResist.pp, 4),
		LightResist			= GetResist(Npc.tbResist.pp, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.pp, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.pp, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.pp, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.pp, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.pp, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.pp, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.pp, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.pp, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.pp, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.pp, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	intensity0	= {
		Exp					= 1,
		Life				= {{1,90},{9,180},{10,250},{20,980},{30,2370},{40,3610},{50,4810},{60,6730},{90,14440},{100,19690},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750}, },
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity0, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity0, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity0, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity0, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity0, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity0, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity0, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity0, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity0, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity0, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	intensity1	= {
		Exp					= 1,
		Life				= {{1,90},{9,180},{10,1000},{19,3800},{20,3920},{30,10100},{60,24700},{100,65800},},
		LifeReplenish		= 0,
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.special, 1),
		PoisonResist		= GetResist(Npc.tbResist.special, 2),
		ColdResist			= GetResist(Npc.tbResist.special, 3),
		FireResist 			= GetResist(Npc.tbResist.special, 4),
		LightResist			= GetResist(Npc.tbResist.special, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity0, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity0, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity0, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity0, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity0, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity0, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity0, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity0, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity0, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity0, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	intensity2	= {
		Exp					= 1,
		Life				= {{1,90},{9,180},{10,2400},{30,21200},{60,64000},{100,146200},},
		LifeReplenish		= 0,
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.special, 1),
		PoisonResist		= GetResist(Npc.tbResist.special, 2),
		ColdResist			= GetResist(Npc.tbResist.special, 3),
		FireResist 			= GetResist(Npc.tbResist.special, 4),
		LightResist			= GetResist(Npc.tbResist.special, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	intensity3	= {
		Exp					= 1,
		Life				= {{1,90},{9,180},{10,3400},{30,30300},{60,82000},{100,246100},},
		LifeReplenish		= 0,
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.special, 1),
		PoisonResist		= GetResist(Npc.tbResist.special, 2),
		ColdResist			= GetResist(Npc.tbResist.special, 3),
		FireResist 			= GetResist(Npc.tbResist.special, 4),
		LightResist			= GetResist(Npc.tbResist.special, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	intensity4	= {
		Exp					= 1,
		Life				= {{1,90},{9,180},{10,6100},{30,53800},{60,159900},{100,365500},},
		LifeReplenish		= 0,
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.special, 1),
		PoisonResist		= GetResist(Npc.tbResist.special, 2),
		ColdResist			= GetResist(Npc.tbResist.special, 3),
		FireResist 			= GetResist(Npc.tbResist.special, 4),
		LightResist			= GetResist(Npc.tbResist.special, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	intensity5	= {
		Exp					= 1,
		Life				= {{1,90},{9,180},{10,9100},{60,213200},{100,487400},},
		LifeReplenish		= 0,
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.special, 1),
		PoisonResist		= GetResist(Npc.tbResist.special, 2),
		ColdResist			= GetResist(Npc.tbResist.special, 3),
		FireResist 			= GetResist(Npc.tbResist.special, 4),
		LightResist			= GetResist(Npc.tbResist.special, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	intensity6	= {
		Exp					= 1,
		Life				= {{1,90},{9,180},{10,13700},{60,319800},{100,731100},},
		LifeReplenish		= 0,
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity2, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity2, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity2, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity2, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity2, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity2, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity2, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity2, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity2, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity2, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	intensity7	= {
		Exp					= 1,
		Life				= {{1,90},{9,180},{10,18300},{60,426500},{100,974800},},
		LifeReplenish		= 0,
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity2, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity2, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity2, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity2, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity2, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity2, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity2, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity2, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity2, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity2, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	intensity8	= {
		Exp					= 1,
		Life				= {{1,90},{9,180},{10,27400},{60,639700},{100,1462200},},
		LifeReplenish		= 0,
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity2, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity2, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity2, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity2, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity2, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity2, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity2, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity2, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity2, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity2, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	intensity9	= {
		Exp					= 1,
		Life				= GetData(Npc.tbDataTemplet.intensity9_Life),
		LifeReplenish		= 0,
		AR					= {{1,30},{10,300},{100,3000},},
		Defense				= {{1,5},{10,5},{11,100},{100,1000},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.5),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3, 2, 0.5),
		ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.5),
		FireDamageBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.5),
		LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.5),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3, 2, 0.5),
		ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.5),
		FireMagicBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.5),
		LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.5),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	intensity10	= {--任务用bt怪
		Exp					= 0,
		Life				= {{1,90000},{9,180000},{10,274000},{60,6397000},{100,14622000},},
		LifeReplenish		= 999999,
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.fellow3, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.fellow3, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	task9	= {
		Exp					= 1,
		Life				= GetData(Npc.tbDataTemplet.intensity9_Life,1.3),
		LifeReplenish		= 0,
		AR					= {{1,30},{10,300},{100,3000},},
		Defense				= {{1,5},{10,5},{11,100},{100,1000},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.5),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3, 2, 0.5),
		ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.5),
		FireDamageBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.5),
		LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.5),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3, 2, 0.5),
		ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.5),
		FireMagicBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.5),
		LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.5),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	intensity99	= {--练级怪,绝大部分杀怪经验由此强度npc提供
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 1),
		Life				= {{1,90},{9,180},{10,250},{20,980},{30,2370},{40,3610},{50,4810},{60,6730},{90,14440},{100,19690},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750}, {150,750},},
		AR					= {{1,30},{10,70},{100,700},{150,1050},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},{150,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity0, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity0, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity0, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity0, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity0, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity0, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity0, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity0, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity0, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity0, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},

	fellow0	= {		--护送NPC强度类型0：血量小于同等级玩家血量,伤害与同等级地图NPC的伤害相同
		Exp					= 0,
		Life				= {{1,175},{100,3000},},
		LifeReplenish		= {{1,5}, {10,20}, {20,35}, {60,90}, {100,150},	 },
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity0, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity0, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity0, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity0, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity0, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity0, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity0, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity0, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity0, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity0, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	fellow1	= {		--护送NPC强度类型1：血量与同等级玩家血量接近；伤害与同等级地图NPC伤害接近
		Exp					= 0,
		Life				= {{1,375},{100,6300},},
		LifeReplenish		= {{1,5}, {10,20}, {20,35}, {60,90}, {100,150},	 },
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity0, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity0, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity0, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity0, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity0, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity0, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity0, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity0, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity0, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity0, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	fellow2	= {		--护送NPC强度类型2：血量为同等级玩家血量3倍；伤害与同等级地图NPC伤害接近
		Exp					= 0,
		Life				= {{1,750},{100,12600},},
		LifeReplenish		= {{1,5}, {10,20}, {20,35}, {60,90}, {100,150},	 },
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity0, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity0, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity0, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity0, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity0, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity0, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity0, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity0, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity0, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity0, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	fellow3	= {		--护送NPC强度类型3：血量为同等级玩家血量3倍；伤害为同等级地图NPC伤害的8倍
		Exp					= 0,
		Life				= {{1,1500},{100,25000},},
		LifeReplenish		= {{1,5}, {10,20}, {20,35}, {60,90}, {100,150},	 },
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.fellow3, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.fellow3, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	fellow4	= {		--血量为强度8的怪的血量,100级时攻击10W
		Exp					= 0,
		Life				= GetData(Npc.tbDataTemplet.intensity8_Life),
		LifeReplenish		= {{1,5}, {10,20}, {20,35}, {60,90}, {100,150},	 },
		AR					= {{1,30},{10,300},{100,3000},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3, 1, 30),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3, 2, 30),
		ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3, 3, 30),
		FireDamageBase		= GetAtack(Npc.tbDamage.fellow3, 4, 30),
		LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3, 5, 30),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3, 1, 30),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3, 2, 30),
		ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3, 3, 30),
		FireMagicBase		= GetAtack(Npc.tbDamage.fellow3, 4, 30),
		LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3, 5, 30),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	fellow5	= {
		Exp					= 0,
		Life				= {{1,2500},{100,42000},},
		LifeReplenish		= {{1,5}, {10,20}, {20,35}, {60,90}, {100,150},	 },
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.fellow3, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.fellow3, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},

	battle1	= {		--宋金士兵强度
		Exp					= 0,
		Life				= {{1,90},{60,16825},{90,36100},{100,49225},},
		LifeReplenish		= 0,
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	battle2	= {		--宋金校尉强度
		Exp					= 0,
		Life				= GetData(Npc.tbDataTemplet.battle2_Life, 1.5),
		LifeReplenish		= 0,
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.special, 1),
		PoisonResist		= GetResist(Npc.tbResist.special, 2),
		ColdResist			= GetResist(Npc.tbResist.special, 3),
		FireResist 			= GetResist(Npc.tbResist.special, 4),
		LightResist			= GetResist(Npc.tbResist.special, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity2, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity2, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity2, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity2, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity2, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity2, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity2, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity2, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity2, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity2, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	battle3	= {		--宋金统领强度
		Exp					= 0,
		Life				= GetData(Npc.tbDataTemplet.battle3_Life, 1.5),
		LifeReplenish		= 0,
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.special, 1),
		PoisonResist		= GetResist(Npc.tbResist.special, 2),
		ColdResist			= GetResist(Npc.tbResist.special, 3),
		FireResist 			= GetResist(Npc.tbResist.special, 4),
		LightResist			= GetResist(Npc.tbResist.special, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity2, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity2, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity2, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity2, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity2, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity2, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity2, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity2, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity2, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity2, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	battle4	= {		--宋金副将强度
		Exp					= 0,
		Life				= GetData(Npc.tbDataTemplet.battle4_Life, 1.5),
		LifeReplenish		= 0,
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.special, 1),
		PoisonResist		= GetResist(Npc.tbResist.special, 2),
		ColdResist			= GetResist(Npc.tbResist.special, 3),
		FireResist 			= GetResist(Npc.tbResist.special, 4),
		LightResist			= GetResist(Npc.tbResist.special, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity2, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity2, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity2, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity2, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity2, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity2, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity2, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity2, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity2, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity2, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	battle5	= {		--宋金大将强度
		Exp					= 0,
		Life				= GetData(Npc.tbDataTemplet.battle5_Life, 1.2),
		LifeReplenish		= {{1,25}, {10,75}, {20,300}, {60,600}, {90,1200}, {100,1600}, },
		AR					= {{1,100},{100,1000},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.special, 1),
		PoisonResist		= GetResist(Npc.tbResist.special, 2),
		ColdResist			= GetResist(Npc.tbResist.special, 3),
		FireResist 			= GetResist(Npc.tbResist.special, 4),
		LightResist			= GetResist(Npc.tbResist.special, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity3, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity3, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity3, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity3, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity3, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity3, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity3, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity3, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity3, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity3, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	battle6	= {		--宋金元帅强度
		Exp					= 0,
		Life				= GetData(Npc.tbDataTemplet.battle6_Life, 1.2),
		LifeReplenish		= {{1,25}, {10,75}, {20,300}, {60,1500}, {90,3000}, {100,4000}, },
		AR					= {{1,100},{100,1000},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity4, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity4, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity4, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity4, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity4, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity4, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity4, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity4, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity4, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity4, 5),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},

	guidon	= {		--宋金旗手
		Exp					= 0,
		Life				= GetData(Npc.tbDataTemplet.dispute14_Life, 1),
		LifeReplenish		= 0,
		AR					= {{1,30},{100,3000},},
		Defense				= {{1,10},{100,1000},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.dispute14, 1),
		PoisonResist		= GetResist(Npc.tbResist.dispute14, 2),
		ColdResist			= GetResist(Npc.tbResist.dispute14, 3),
		FireResist 			= GetResist(Npc.tbResist.dispute14, 4),
		LightResist			= GetResist(Npc.tbResist.dispute14, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.dispute14, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.dispute14, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.dispute14, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.dispute14, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.dispute14, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.dispute14, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.dispute14, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.dispute14, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.dispute14, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.dispute14, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},


	baihutang1	= {	--白虎堂普通NPC
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 1),
		Life				={{1,90},{9,180},{10,250},{20,980},{30,2370},{40,3610},{50,4810},{60,6730},{90,14440},{100,19690},{110,25000},{115,30000},{120,35000}}, 
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1, 1},{100, 1},{110,200},{120,200}},
		MaxDamage			= {{1,10},{100,10},{110,300},{120,300}},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	baihutang2	= {	--白虎堂BOSS
		Exp					= { {  1,     50},{  9,     50},
								{ 10,   3590},{ 19,   3608},
								{ 20,   3990},{ 29,   4008},
								{ 30,   7950},{ 39,   8040},
								{ 40, 100000},{ 49, 100000},
								{ 50, 150000},{ 59, 150000},
								{ 60, 200000},{ 69, 200000},
								{ 70, 250000},{ 79, 250000},
								{ 80, 300000},{ 89, 300000},
								{ 90, 350000},{ 99, 350000},
								{100, 400000},{109, 400000},
								{110, 450000},{119, 450000},
								{120, 500000},{129, 500000},
								{130, 550000},{139, 550000},
								{140, 600000},{150, 600000},
							  },
		Life				= {{1,9000},{60,3576000},{100,4544000},{110,5000000},{115,10000000},{120,15000000}}, 
		LifeReplenish		= 0,
		AR					= {{1,100},{100,1000},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1, 1},{100, 1},{110,250},{120,250}},
		MaxDamage			= {{1,10},{100,10},{110,400},{120,400}},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity3, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity3, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity3, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity3, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity3, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity3, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity3, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity3, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity3, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity3, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
--第1套家族副本强度
	KinEctype_b1	= {	--家族副本房间b内的npc(地宫门卫)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 1),
		Life    			= {{1,90},{9,180},{10,1000},{19,3800},{20,3920},{30,10100},{60,24700},{100,65800},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_c1	= {	--家族副本房间c内的npc(图腾卫士),无形蛊光环
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life				= {{1,90},{9,180},{10,2400},{30,21200},{60,64000},{100,146200},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity3, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity3, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity3, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity3, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity3, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity3, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity3, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity3, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity3, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity3, 5),

		AuraSkillId			= 78,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_d1	= {	--家族副本房间d内的npc(罗汉铜人)反弹光环
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life    			= {{1,90},{9,180},{10,1000},{19,3800},{20,3920},{30,10100},{60,24700},{100,65800},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		AuraSkillId			= 25,	--反弹光环,20级反弹45%
		AuraSkillLevel		= 7,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_e1	= {	--家族副本房间e内的npc(机关骷髅)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 30),
		Life				= {{1,90},{9,180},{10,27400},{60,639700},{100,1462200},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity4, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity4, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity4, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity4, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity4, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity4, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity4, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity4, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity4, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity4, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_f1	= {	--家族副本房间f内的npc(雷鸣机关兽)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life    			= {{1,90},{9,180},{10,1000},{19,3800},{20,3920},{30,10100},{60,24700},{100,65800},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_g1	= {	--家族副本房间g和j内的npc(天地日月,青龙白虎朱雀玄武守卫和凶神)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life    			= {{1,90},{9,180},{10,1000},{19,3800},{20,3920},{30,10100},{60,24700},{100,65800},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_k1	= {	--家族副本房间k内的npc(影子武士)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 1),
		Life    			= {{1,90},{9,180},{10,1000},{19,3800},{20,3920},{30,10100},{60,24700},{100,65800},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_l1	= {	--家族副本房间l内的npc(飞速机关兽)无形蛊光环
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life				= {{1,90},{9,180},{10,2400},{30,21200},{60,64000},{100,146200},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		AuraSkillId			= 78,	--无形蛊
		AuraSkillLevel		= 20,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_o1	= {	--家族副本房间o内的npc(冥府冤魂)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 30),
		Life				= GetData(Npc.tbDataTemplet.mingfuyuanhunLife, 0.85),
		LifeReplenish		= {{1,1},{10,375},{20,1500},{30,3250},{40,4500},{50,5500},{60,7500},{90,15000},{100,20000}},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity4, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity4, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity4, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity4, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity4, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity4, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity4, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity4, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity4, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity4, 5),

		AuraSkillId			= 765,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
--第2套家族副本强度
	KinEctype_b2	= {	--家族副本房间b内的npc(地宫门卫)
		Exp					= GetData(Npc.tbDataTemplet.intensity99,1),
		Life    			= {{1,90*1.5},{9,180*1.5},{10,1000*1.5},{19,3800*1.5},{20,3920*1.5},{30,10100*1.5},{60,24700*1.5},{100,65800*1.5},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.1),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.1),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.1),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.1),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.1),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.1),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.1),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.1),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_c2	= {	--家族副本房间c内的npc(图腾卫士),无形蛊光环
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life				= {{1,90*1.5},{9,180*1.5},{10,2400*1.5},{30,21200*1.5},{60,64000*1.5},{100,146200*1.5},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity3, 1, 1.1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity3, 2, 1.1),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity3, 3, 1.1),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity3, 4, 1.1),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity3, 5, 1.1),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity3, 1, 1.1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity3, 2, 1.1),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity3, 3, 1.1),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity3, 4, 1.1),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity3, 5, 1.1),

		AuraSkillId			= 78,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_d2	= {	--家族副本房间d内的npc(罗汉铜人)反弹光环
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life    			= {{1,90*1.5},{9,180*1.5},{10,1000*1.5},{19,3800*1.5},{20,3920*1.5},{30,10100*1.5},{60,24700*1.5},{100,65800*1.5},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.1),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.1),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.1),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.1),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.1),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.1),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.1),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.1),

		AuraSkillId			= 25,	--反弹光环,20级反弹45%
		AuraSkillLevel		= 7,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_e2	= {	--家族副本房间e内的npc(机关骷髅)
		Exp					= GetData(Npc.tbDataTemplet.intensity99,30),
		Life				= {{1,90*1.5},{9,180*1.5},{10,27400*1.5},{60,639700*1.5},{100,1462200*1.5},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity4, 1, 1.1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity4, 2, 1.1),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity4, 3, 1.1),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity4, 4, 1.1),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity4, 5, 1.1),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity4, 1, 1.1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity4, 2, 1.1),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity4, 3, 1.1),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity4, 4, 1.1),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity4, 5, 1.1),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_f2	= {	--家族副本房间f内的npc(雷鸣机关兽)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life    			= {{1,90*1.5},{9,180*1.5},{10,1000*1.5},{19,3800*1.5},{20,3920*1.5},{30,10100*1.5},{60,24700*1.5},{100,65800*1.5},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.1),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.1),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.1),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.1),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.1),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.1),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.1),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.1),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_g2	= {	--家族副本房间g和j内的npc(天地日月,青龙白虎朱雀玄武守卫和凶神)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life    			= {{1,90*1.5},{9,180*1.5},{10,1000*1.5},{19,3800*1.5},{20,3920*1.5},{30,10100*1.5},{60,24700*1.5},{100,65800*1.5},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.1),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.1),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.1),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.1),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.1),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.1),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.1),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.1),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_k2	= {	--家族副本房间k内的npc(影子武士)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 1),
		Life    			= {{1,90*1.5},{9,180*1.5},{10,1000*1.5},{19,3800*1.5},{20,3920*1.5},{30,10100*1.5},{60,24700*1.5},{100,65800*1.5},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.1),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.1),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.1),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.1),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.1),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.1),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.1),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.1),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_l2	= {	--家族副本房间l内的npc(飞速机关兽)无形蛊光环
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life				= {{1,90*1.5},{9,180*1.5},{10,2400*1.5},{30,21200*1.5},{60,64000*1.5},{100,146200*1.5},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.1),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.1),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.1),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.1),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.1),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.1),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.1),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.1),

		AuraSkillId			= 78,	--无形蛊
		AuraSkillLevel		= 20,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_o2	= {	--家族副本房间o内的npc(冥府冤魂)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 30),
		Life				= GetData(Npc.tbDataTemplet.mingfuyuanhunLife, 1.275),
		LifeReplenish		= {{1,1},{10,375},{20,1500},{30,3250},{40,4500},{50,5500},{60,7500},{90,15000},{100,20000}},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity4, 1, 1.1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity4, 2, 1.1),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity4, 3, 1.1),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity4, 4, 1.1),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity4, 5, 1.1),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity4, 1, 1.1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity4, 2, 1.1),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity4, 3, 1.1),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity4, 4, 1.1),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity4, 5, 1.1),

		AuraSkillId			= 765,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
--第3套家族副本强度
	KinEctype_b3	= {	--家族副本房间b内的npc(地宫门卫)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 1),
		Life    			= {{1,90*3},{9,180*3},{10,1000*3},{19,3800*3},{20,3920*3},{30,10100*3},{60,24700*3},{100,65800*3},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.2),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.2),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.2),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.2),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.2),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.2),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.2),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.2),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_c3	= {	--家族副本房间c内的npc(图腾卫士),无形蛊光环
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life				= {{1,90*3},{9,180*3},{10,2400*3},{30,21200*3},{60,64000*3},{100,146200*3},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity3, 1, 1.2),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity3, 2, 1.2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity3, 3, 1.2),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity3, 4, 1.2),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity3, 5, 1.2),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity3, 1, 1.2),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity3, 2, 1.2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity3, 3, 1.2),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity3, 4, 1.2),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity3, 5, 1.2),

		AuraSkillId			= 78,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_d3	= {	--家族副本房间d内的npc(罗汉铜人)反弹光环
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life    			= {{1,90*3},{9,180*3},{10,1000*3},{19,3800*3},{20,3920*3},{30,10100*3},{60,24700*3},{100,65800*3},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.2),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.2),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.2),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.2),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.2),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.2),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.2),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.2),

		AuraSkillId			= 25,	--反弹光环,20级反弹45%
		AuraSkillLevel		= 7,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_e3	= {	--家族副本房间e内的npc(机关骷髅)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 30),
		Life				= {{1,90*3},{9,180*3},{10,27400*3},{60,639700*3},{100,1462200*3},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity4, 1, 1.2),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity4, 2, 1.2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity4, 3, 1.2),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity4, 4, 1.2),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity4, 5, 1.2),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity4, 1, 1.2),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity4, 2, 1.2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity4, 3, 1.2),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity4, 4, 1.2),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity4, 5, 1.2),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_f3	= {	--家族副本房间f内的npc(雷鸣机关兽)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life    			= {{1,90*3},{9,180*3},{10,1000*3},{19,3800*3},{20,3920*3},{30,10100*3},{60,24700*3},{100,65800*3},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.2),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.2),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.2),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.2),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.2),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.2),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.2),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.2),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_g3	= {	--家族副本房间g和j内的npc(天地日月,青龙白虎朱雀玄武守卫和凶神)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life    			= {{1,90*3},{9,180*3},{10,1000*3},{19,3800*3},{20,3920*3},{30,10100*3},{60,24700*3},{100,65800*3},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.2),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.2),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.2),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.2),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.2),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.2),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.2),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.2),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_k3	= {	--家族副本房间k内的npc(影子武士)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 1),
		Life    			= {{1,90*3},{9,180*3},{10,1000*3},{19,3800*3},{20,3920*3},{30,10100*3},{60,24700*3},{100,65800*3},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.2),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.2),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.2),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.2),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.2),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.2),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.2),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.2),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_l3	= {	--家族副本房间l内的npc(飞速机关兽)无形蛊光环
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life				= {{1,90*3},{9,180*3},{10,2400*3},{30,21200*3},{60,64000*3},{100,146200*3},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.2),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.2),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.2),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.2),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.2),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.2),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.2),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.2),

		AuraSkillId			= 78,	--无形蛊
		AuraSkillLevel		= 20,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_o3	= {	--家族副本房间o内的npc(冥府冤魂)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 30),
		Life				= GetData(Npc.tbDataTemplet.mingfuyuanhunLife, 2.55),
		LifeReplenish		= {{1,1},{10,375},{20,1500},{30,3250},{40,4500},{50,5500},{60,7500},{90,15000},{100,20000}},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity4, 1, 1.2),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity4, 2, 1.2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity4, 3, 1.2),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity4, 4, 1.2),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity4, 5, 1.2),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity4, 1, 1.2),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity4, 2, 1.2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity4, 3, 1.2),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity4, 4, 1.2),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity4, 5, 1.2),

		AuraSkillId			= 765,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
--第4套家族副本强度
	KinEctype_b4	= {	--家族副本房间b内的npc(地宫门卫)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 1),
		Life    			= {{1,90*4},{9,180*4},{10,1000*4},{19,3800*4},{20,3920*4},{30,10100*4},{60,24700*4},{100,65800*4},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.3),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.3),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.3),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.3),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.3),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.3),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.3),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.3),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_c4	= {	--家族副本房间c内的npc(图腾卫士),无形蛊光环
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life				= {{1,90*4},{9,180*4},{10,2400*4},{30,21200*4},{60,64000*4},{100,146200*4},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity3, 1, 1.3),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity3, 2, 1.3),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity3, 3, 1.3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity3, 4, 1.3),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity3, 5, 1.3),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity3, 1, 1.3),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity3, 2, 1.3),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity3, 3, 1.3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity3, 4, 1.3),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity3, 5, 1.3),

		AuraSkillId			= 78,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_d4	= {	--家族副本房间d内的npc(罗汉铜人)反弹光环
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life    			= {{1,90*4},{9,180*4},{10,1000*4},{19,3800*4},{20,3920*4},{30,10100*4},{60,24700*4},{100,65800*4},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.3),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.3),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.3),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.3),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.3),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.3),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.3),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.3),

		AuraSkillId			= 25,	--反弹光环,20级反弹45%
		AuraSkillLevel		= 7,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_e4	= {	--家族副本房间e内的npc(机关骷髅)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 30),
		Life				= {{1,90*4},{9,180*4},{10,27400*4},{60,639700*4},{100,1462200*4},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity4, 1, 1.3),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity4, 2, 1.3),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity4, 3, 1.3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity4, 4, 1.3),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity4, 5, 1.3),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity4, 1, 1.3),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity4, 2, 1.3),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity4, 3, 1.3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity4, 4, 1.3),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity4, 5, 1.3),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_f4	= {	--家族副本房间f内的npc(雷鸣机关兽)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life    			= {{1,90*4},{9,180*4},{10,1000*4},{19,3800*4},{20,3920*4},{30,10100*4},{60,24700*4},{100,65800*4},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.3),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.3),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.3),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.3),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.3),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.3),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.3),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.3),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_g4	= {	--家族副本房间g和j内的npc(天地日月,青龙白虎朱雀玄武守卫和凶神)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life    			= {{1,90*4},{9,180*4},{10,1000*4},{19,3800*4},{20,3920*4},{30,10100*4},{60,24700*4},{100,65800*4},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.3),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.3),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.3),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.3),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.3),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.3),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.3),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.3),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_k4	= {	--家族副本房间k内的npc(影子武士)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 1),
		Life    			= {{1,90*4},{9,180*4},{10,1000*4},{19,3800*4},{20,3920*4},{30,10100*4},{60,24700*4},{100,65800*4},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.3),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.3),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.3),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.3),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.3),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.3),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.3),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.3),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_l4	= {	--家族副本房间l内的npc(飞速机关兽)无形蛊光环
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life				= {{1,90*4},{9,180*4},{10,2400*4},{30,21200*4},{60,64000*4},{100,146200*4},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.3),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.3),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.3),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.3),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.3),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.3),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.3),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.3),

		AuraSkillId			= 78,	--无形蛊
		AuraSkillLevel		= 20,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_o4	= {	--家族副本房间o内的npc(冥府冤魂)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 30),
		Life				= GetData(Npc.tbDataTemplet.mingfuyuanhunLife, 3.4),
		LifeReplenish		= {{1,1},{10,375},{20,1500},{30,3250},{40,4500},{50,5500},{60,7500},{90,15000},{100,20000}},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity4, 1, 1.3),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity4, 2, 1.3),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity4, 3, 1.3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity4, 4, 1.3),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity4, 5, 1.3),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity4, 1, 1.3),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity4, 2, 1.3),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity4, 3, 1.3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity4, 4, 1.3),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity4, 5, 1.3),

		AuraSkillId			= 765,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
--第5套家族副本强度
	KinEctype_b5	= {	--家族副本房间b内的npc(地宫门卫)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 1),
		Life    			= {{1,90*5},{9,180*5},{10,1000*5},{19,3800*5},{20,3920*5},{30,10100*5},{60,24700*5},{100,65800*5},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.5),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.5),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.5),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.5),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.5),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.5),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.5),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.5),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_c5	= {	--家族副本房间c内的npc(图腾卫士),无形蛊光环
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life				= {{1,90*5},{9,180*5},{10,2400*5},{30,21200*5},{60,64000*5},{100,146200*5},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity3, 1, 1.5),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity3, 2, 1.5),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity3, 3, 1.5),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity3, 4, 1.5),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity3, 5, 1.5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity3, 1, 1.5),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity3, 2, 1.5),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity3, 3, 1.5),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity3, 4, 1.5),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity3, 5, 1.5),

		AuraSkillId			= 78,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_d5	= {	--家族副本房间d内的npc(罗汉铜人)反弹光环
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life    			= {{1,90*5},{9,180*5},{10,1000*5},{19,3800*5},{20,3920*5},{30,10100*5},{60,24700*5},{100,65800*5},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.5),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.5),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.5),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.5),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.5),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.5),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.5),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.5),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.5),

		AuraSkillId			= 25,	--反弹光环,20级反弹45%
		AuraSkillLevel		= 7,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_e5	= {	--家族副本房间e内的npc(机关骷髅)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 30),
		Life				= {{1,90*5},{9,180*5},{10,27400*5},{60,639700*5},{100,1462200*5},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity4, 1, 1.5),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity4, 2, 1.5),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity4, 3, 1.5),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity4, 4, 1.5),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity4, 5, 1.5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity4, 1, 1.5),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity4, 2, 1.5),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity4, 3, 1.5),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity4, 4, 1.5),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity4, 5, 1.5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_f5	= {	--家族副本房间f内的npc(雷鸣机关兽)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life    			= {{1,90*5},{9,180*5},{10,1000*5},{19,3800*5},{20,3920*5},{30,10100*5},{60,24700*5},{100,65800*5},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.5),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.5),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.5),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.5),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.5),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.5),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.5),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.5),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_g5	= {	--家族副本房间g和j内的npc(天地日月,青龙白虎朱雀玄武守卫和凶神)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life    			= {{1,90*5},{9,180*5},{10,1000*5},{19,3800*5},{20,3920*5},{30,10100*5},{60,24700*5},{100,65800*5},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.5),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.5),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.5),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.5),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.5),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.5),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.5),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.5),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_k5	= {	--家族副本房间k内的npc(影子武士)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 1),
		Life    			= {{1,90*5},{9,180*5},{10,1000*5},{19,3800*5},{20,3920*5},{30,10100*5},{60,24700*5},{100,65800*5},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.5),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.5),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.5),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.5),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.5),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.5),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.5),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.5),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_l5	= {	--家族副本房间l内的npc(飞速机关兽)无形蛊光环
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life				= {{1,90*5},{9,180*5},{10,2400*5},{30,21200*5},{60,64000*5},{100,146200*5},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.5),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 1.5),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.5),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.5),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 1.5),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 1.5),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 1.5),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 1.5),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 1.5),

		AuraSkillId			= 78,	--无形蛊
		AuraSkillLevel		= 20,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_o5	= {	--家族副本房间o内的npc(冥府冤魂)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 30),
		Life				= GetData(Npc.tbDataTemplet.mingfuyuanhunLife, 4.25),
		LifeReplenish		= {{1,1},{10,375},{20,1500},{30,3250},{40,4500},{50,5500},{60,7500},{90,15000},{100,20000}},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity4, 1, 1.5),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity4, 2, 1.5),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity4, 3, 1.5),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity4, 4, 1.5),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity4, 5, 1.5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity4, 1, 1.5),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity4, 2, 1.5),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity4, 3, 1.5),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity4, 4, 1.5),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity4, 5, 1.5),

		AuraSkillId			= 765,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},

	KinEctype_m	= {	--家族副本房间m内的npc(复制机关人)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 3),
		Life			    = {{1,90},{9,180},{10,2400},{30,21200},{60,64000},{100,146200},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	KinEctype_p	= {	--家族副本房间p内的npc(心魔)
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 4),
		Life				= {{1,90},{9,180},{10,1000},{19,3800},{20,3920},{30,10100},{40,14970},{50,39680},{60,65867},{70,93267},{80,135750},{90,222100},{100,263200},},
		LifeReplenish		= {{1,5}, {10,10}, {20,65}, {60,250}, {100,750},},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,10},{100,200},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.xinmo, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.xinmo, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.xinmo, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.xinmo, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.xinmo, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.xinmo, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.xinmo, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.xinmo, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.xinmo, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.xinmo, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},

	worldboss1	= {	--世界BOSS
		Exp					= { {  1,     50},{  9,     50},
								{ 10,   4490},{ 19,   4508},
								{ 20,   4990},{ 29,   5008},
								{ 30,   9950},{ 39,  10040},
								{ 40, 150000},{ 49, 150000},
								{ 50, 150000},{ 59, 150000},
								{ 60,   1200},{ 69,   1290},
								{ 70, 300000},{ 79, 300000},
								{ 80,   2000},{ 89,   2090},
								{ 90, 450000},{ 99, 450000},
								{100,   2800},{109,   3025},
								{110,   3300},{109,   3525},
								{120,   3900},{129,   4170},
								{130,   4500},{139,   4950},
								{140,   5200},{150,   5500},
							  },
		Life				= {{1,10000000*0.9},{55,200000000*0.9},{100,400000000*0.9},},
		LifeReplenish		= {{1,1},{10,375},{20,1500},{30,3250},{40,4500},{50,5500},{60,7500},{90,15000},{100,20000}},
		AR					= {{1,100},{55,1000},{75,3000},{95,5000},{100,5000},},
		Defense				= {{1,5},{55,300},{75,300},{95,300},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.boss1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.boss1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.boss1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.boss1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.boss1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.boss1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.boss1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.boss1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.boss1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.boss1, 5),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},

	kinworldboss1	= {	--家族副本世界BOSS
		Exp					= { {  1,     50},{  9,     50},
								{ 10,   4490},{ 19,   4508},
								{ 20,   4990},{ 29,   5008},
								{ 30,   9950},{ 39,  10040},
								{ 40, 150000},{ 49, 150000},
								{ 50, 150000},{ 59, 150000},
								{ 60,   1200},{ 69,   1290},
								{ 70, 300000},{ 79, 300000},
								{ 80,   2000},{ 89,   2090},
								{ 90,   2300},{ 99,   2480},
								{100,   2800},{109,   3025},
								{110,   3300},{109,   3525},
								{120,   3900},{129,   4170},
								{130,   4500},{139,   4950},
								{140,   5200},{150,   5500},
							  },
		Life				= {{1,160*0.9},{55,5500000},{75,9000000},},
		LifeReplenish		= {{1,1},{10,375},{20,1500},{30,3250},{40,4500},{50,5500},{60,7500},{90,15000},{100,20000}},
		AR					= {{1,100},{55,1000},{75,3000},{95,5000},{100,5000},},
		Defense				= {{1,5},{55,300},{75,300},{95,300},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.boss1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.boss1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.boss1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.boss1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.boss1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.boss1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.boss1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.boss1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.boss1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.boss1, 5),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	worldboss1_call	= {	--世界BOSS
		Exp					= { {  1,     50},{  9,     50},
								{ 10,   4490},{ 19,   4508},
								{ 20,   4990},{ 29,   5008},
								{ 30,   9950},{ 39,  10040},
								{ 40, 150000},{ 49, 150000},
								{ 50, 150000},{ 59, 150000},
								{ 60,   1200},{ 69,   1290},
								{ 70, 300000},{ 79, 300000},
								{ 80,   2000},{ 89,   2090},
								{ 90, 450000},{ 99, 450000},
								{100,   2800},{109,   3025},
								{110,   3300},{109,   3525},
								{120,   3900},{129,   4170},
								{130,   4500},{139,   4950},
								{140,   5200},{150,   5500},
							  },
		Life				= {{1,160*0.9*0.7},{55,7125000*0.9*0.7},{100,21930000*0.9*0.7},},
		LifeReplenish		= {{1,1},{10,375},{20,1500},{30,3250},{40,4500},{50,5500},{60,7500},{90,15000},{100,20000}},
		AR					= {{1,100},{55,1000},{75,3000},{95,5000},{100,5000},},
		Defense				= {{1,5},{55,300},{75,300},{95,300},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.boss1, 1, 0.7),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.boss1, 2, 0.7),
		ColdDamageBase		= GetAtack(Npc.tbDamage.boss1, 3, 0.7),
		FireDamageBase		= GetAtack(Npc.tbDamage.boss1, 4, 0.7),
		LightingDamageBase	= GetAtack(Npc.tbDamage.boss1, 5, 0.7),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.boss1, 1, 0.7),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.boss1, 2, 0.7),
		ColdMagicBase		= GetAtack(Npc.tbDamage.boss1, 3, 0.7),
		FireMagicBase		= GetAtack(Npc.tbDamage.boss1, 4, 0.7),
		LightingMagicBase	= GetAtack(Npc.tbDamage.boss1, 5, 0.7),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	BossFellow2412	= {	--世界BOSS召唤怪ID2412常用小兵
		Exp					= 0,
		Life				= {{1,45},{9,90},{10,500},{19,1900},{20,1910},{30,5050},{60,12900},{75,50000},{100,32900,}},
		LifeReplenish		= 0,
		AR					= {{1,100},{55,1000},{75,3000},{95,5000},{100,5000},},
		Defense				= {{1,5},{55,300},{75,300},{95,300},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= 1,
		PoisonResist		= 1,
		ColdResist			= 1,
		FireResist 			= 1,
		LightResist			= 1,

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.boss1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.boss1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.boss1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.boss1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.boss1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.boss1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.boss1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.boss1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.boss1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.boss1, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},

	BossFellow2413	= {	--世界BOSS召唤怪ID2413高攻小兵,低血高回复
		Exp					= 0,
		Life				= {{1,90},{9,180},{10,250},{20,980},{30,2370},{40,3610},{50,4810},{60,6730},{75,10000},{90,14440},{100,19690},},
		LifeReplenish		= 0,
		AR					= {{1,100},{55,1000},{75,3000},{95,5000},{100,5000},},
		Defense				= {{1,5},{55,300},{75,300},{95,300},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= 1,
		PoisonResist		= 1,
		ColdResist			= 1,
		FireResist 			= 1,
		LightResist			= 1,

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.boss1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.boss1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.boss1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.boss1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.boss1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.boss1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.boss1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.boss1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.boss1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.boss1, 5),

		AuraSkillId			= 976,
		AuraSkillLevel		= 2,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},

	BossFellow2414	= {	--世界BOSS召唤怪ID2414诅咒小兵,高血低攻击
		Exp					= 0,
		Life				= {{1,90},{9,180},{10,1000},{19,3800},{20,3920},{30,10100},{60,24700},{75,150000},{100,65800},},
		LifeReplenish		= 0,
		AR					= {{1,1000},{55,10000},{75,30000},{95,50000},{100,50000},},
		Defense				= {{1,5},{55,300},{75,300},{95,300},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= 1,
		PoisonResist		= 1,
		ColdResist			= 1,
		FireResist 			= 1,
		LightResist			= 1,

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.boss1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.boss1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.boss1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.boss1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.boss1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.boss1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.boss1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.boss1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.boss1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.boss1, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},

	BossFellow2415	= {	--世界BOSS召唤怪ID2415无形蛊小兵,高血
		Exp					= 0,
		Life				= {{1,90},{9,180},{10,1000},{19,3800},{20,3920},{30,10100},{60,24700},{75,250000},{100,65800},},
		LifeReplenish		= 0,
		AR					= {{1,100},{55,1000},{75,3000},{95,5000},{100,5000},},
		Defense				= {{1,1},{55,1},{75,1},{95,1},{100,1},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= 1,
		PoisonResist		= 1,
		ColdResist			= 1,
		FireResist 			= 1,
		LightResist			= 1,

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.boss1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.boss1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.boss1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.boss1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.boss1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.boss1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.boss1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.boss1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.boss1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.boss1, 5),

		AuraSkillId			= 652,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},

	BossFellow2416	= {	--世界BOSS召唤怪ID2416群攻小兵
		Exp					= 0,
		Life				= {{1,45},{9,90},{10,500},{19,1900},{20,1910},{30,5050},{60,12900},{75,100000},{100,32900},},
		LifeReplenish		= 0,
		AR					= {{1,100},{55,1000},{75,3000},{95,5000},{100,5000},},
		Defense				= {{1,5},{55,300},{75,300},{95,300},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= 1,
		PoisonResist		= 1,
		ColdResist			= 1,
		FireResist 			= 1,
		LightResist			= 1,

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.boss1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.boss1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.boss1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.boss1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.boss1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.boss1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.boss1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.boss1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.boss1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.boss1, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},

	BossFellow2417	= {	--世界BOSS召唤怪ID2417,自我复制小兵
		Exp					= 0,
		Life				= {{1,90},{9,180},{10,250},{20,980},{30,2370},{40,3610},{50,4810},{60,6730},{75,100000},{90,14440},{100,19690},},
		LifeReplenish		= 0,
		AR					= {{1,100},{55,1000},{75,3000},{95,5000},{100,5000},},
		Defense				= {{1,5},{55,300},{75,300},{95,300},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= 1,
		PoisonResist		= 1,
		ColdResist			= 1,
		FireResist 			= 1,
		LightResist			= 1,

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.boss1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.boss1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.boss1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.boss1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.boss1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.boss1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.boss1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.boss1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.boss1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.boss1, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},

	BossFellow2418	= {	--世界BOSS召唤怪ID2418弱弹幕小兵
		Exp					= 0,
		Life				= {{1,45},{9,90},{10,500},{19,1900},{20,1910},{30,5050},{60,12900},{75,150000},{100,32900},},
		LifeReplenish		= 0,
		AR					= {{1,100},{55,1000},{75,3000},{95,5000},{100,5000},},
		Defense				= {{1,5},{55,300},{75,300},{95,300},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= 1,
		PoisonResist		= 1,
		ColdResist			= 1,
		FireResist 			= 1,
		LightResist			= 1,

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.boss1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.boss1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.boss1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.boss1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.boss1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.boss1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.boss1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.boss1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.boss1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.boss1, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},

	BossFellow2419	= {	--世界BOSS召唤怪ID2419强弹幕小兵
		Exp					= 0,
		Life				= {{1,45},{9,90},{10,500},{19,1900},{20,1910},{30,5050},{60,12900},{75,200000},{100,32900},},
		LifeReplenish		= 0,
		AR					= {{1,100},{55,1000},{75,3000},{95,5000},{100,5000},},
		Defense				= {{1,5},{55,300},{75,300},{95,300},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= 1,
		PoisonResist		= 1,
		ColdResist			= 1,
		FireResist 			= 1,
		LightResist			= 1,

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.boss1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.boss1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.boss1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.boss1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.boss1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.boss1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.boss1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.boss1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.boss1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.boss1, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
---------------------------秦始皇陵-----------------------------------
	worldboss3	= {	--120级世界boss秦始皇
		Exp					= 1,
		Life				= {{1,1600*0.9},{55,41250000*0.9},{100,119300000*0.9},},
		LifeReplenish		= 0,
		AR					= 667,
		Defense				= 300,
		MinDamage			= 1,
		MaxDamage			= 200,
		PhysicsResist		= 200,
		PoisonResist		= 200,
		ColdResist			= 200,
		FireResist 			= 200,
		LightResist			= 200,

		PhysicalDamageBase	= 600,
		PoisonDamageBase	= 600,
		ColdDamageBase		= 600,
		FireDamageBase		= 600,
		LightingDamageBase	= 600,

		PhysicalMagicBase	= 600,
		PoisonMagicBase		= 600,
		ColdMagicBase		= 600,
		FireMagicBase		= 600,
		LightingMagicBase	= 600,

		AuraSkillId			= 1410,
		AuraSkillLevel		= 1,
		PasstSkillId		= 1407,--提高500%命中
		PasstSkillLevel		= 10,
	},

		lucchicamma	= {	--120级世界boss秦始皇
		Exp					= 1,
		Life				= {{1,3000000},{55,3000000},{100,3000000},},
		LifeReplenish		= 0,
		AR					= 667,
		Defense				= 300,
		MinDamage			= 1,
		MaxDamage			= 400,
		PhysicsResist		= 100,
		PoisonResist		= 100,
		ColdResist			= 100,
		FireResist 			= 100,
		LightResist			= 100,

		PhysicalDamageBase	= 1200,
		PoisonDamageBase	= 1200,
		ColdDamageBase		= 1200,
		FireDamageBase		= 1200,
		LightingDamageBase	= 1200,

		PhysicalMagicBase	= 1200,
		PoisonMagicBase		= 1200,
		ColdMagicBase		= 1200,
		FireMagicBase		= 1200,
		LightingMagicBase	= 1200,

		AuraSkillId			= 1007,
		AuraSkillLevel		= 1,
		PasstSkillId		= 1407,--提高500%命中
		PasstSkillLevel		= 10,
	},
	tubattuong = {	--120级世界boss秦始皇
		Exp					= 1,
		Life				= {{1,160*0.9},{55,9125000*0.9},{100,100000000*0.9},{200,100000000*0.9},},
		LifeReplenish		= 0,
		AR					= 1000,
		Defense				= 2000,
		MinDamage			= 1,
		MaxDamage			= 3000,
		PhysicsResist		= 1000,
		PoisonResist		= 1000,
		ColdResist			= 1000,
		FireResist 			= 1000,
		LightResist			= 1000,

		PhysicalDamageBase	= 3000,
		PoisonDamageBase	= 3000,
		ColdDamageBase		= 3000,
		FireDamageBase		= 3000,
		LightingDamageBase	= 3000,

		PhysicalMagicBase	= 3000,
		PoisonMagicBase		= 3000,
		ColdMagicBase		= 3000,
		FireMagicBase		= 3000,
		LightingMagicBase	= 3000,

		AuraSkillId			= 376,
		AuraSkillLevel		= 1,
		PasstSkillId		= 1407,--提高500%命中
		PasstSkillLevel		= 10,
	},


		Bossdaica	= {	--120级世界boss秦始皇
		Exp					= 1,
		Life				= {{1,3600*0.9},{55,84125000*0.9},{100,101930000*0.9},},
		LifeReplenish		= 0,
		AR					= 667,
		Defense				= 1500,
		MinDamage			= 1,
		MaxDamage			= 3000,
		PhysicsResist		= 800,
		PoisonResist		= 800,
		ColdResist			= 800,
		FireResist 			= 800,
		LightResist			= 800,

		PhysicalDamageBase	= 4000,
		PoisonDamageBase	= 4000,
		ColdDamageBase		= 4000,
		FireDamageBase		= 4000,
		LightingDamageBase	= 4000,

		PhysicalMagicBase	= 4000,
		PoisonMagicBase		= 4000,
		ColdMagicBase		= 4000,
		FireMagicBase		= 4000,
		LightingMagicBase	= 4000,

		AuraSkillId			= 1410,
		AuraSkillLevel		= 1,
		PasstSkillId		= 1407,--提高500%命中
		PasstSkillLevel		= 10,
	},
	
	Bosstamca	= {	--120级世界boss秦始皇
		Exp					= 1,
		Life				= {{1,2600*0.9},{55,64125000*0.9},{100,81930000*0.9},},
		LifeReplenish		= 0,
		AR					= 667,
		Defense				= 1500,
		MinDamage			= 1,
		MaxDamage			= 3000,
		PhysicsResist		= 800,
		PoisonResist		= 800,
		ColdResist			= 800,
		FireResist 			= 800,
		LightResist			= 800,

		PhysicalDamageBase	= 3000,
		PoisonDamageBase	= 3000,
		ColdDamageBase		= 3000,
		FireDamageBase		= 3000,
		LightingDamageBase	= 3000,

		PhysicalMagicBase	= 3000,
		PoisonMagicBase		= 3000,
		ColdMagicBase		= 3000,
		FireMagicBase		= 3000,
		LightingMagicBase	= 3000,

		AuraSkillId			= 1442,
		AuraSkillLevel		= 1,
		PasstSkillId		= 1407,--提高500%命中
		PasstSkillLevel		= 10,
	},

	Bossacma	= {	--120级世界boss秦始皇
		Exp					= 1,
		Life				= {{1,3600*0.9},{55,54125000*0.9},{100,70193000*0.9},{250,128530000*0.9},},
		LifeReplenish		= 0,
		AR					= 667,
		Defense				= 1500,
		MinDamage			= 1,
		MaxDamage			= 3000,
		PhysicsResist		= 800,
		PoisonResist		= 800,
		ColdResist			= 800,
		FireResist 			= 800,
		LightResist			= 800,

		PhysicalDamageBase	= 4000,
		PoisonDamageBase	= 4000,
		ColdDamageBase		= 4000,
		FireDamageBase		= 4000,
		LightingDamageBase	= 4000,

		PhysicalMagicBase	= 4000,
		PoisonMagicBase		= 4000,
		ColdMagicBase		= 4000,
		FireMagicBase		= 4000,
		LightingMagicBase	= 4000,

		AuraSkillId			= 1691, -- vong sang duoi chan
		AuraSkillLevel		= 1,
		PasstSkillId		= 1407,--提高500%命中
		PasstSkillLevel		= 10,
	},

	vongsang1	= { -- Vòng sáng NPC
		AuraSkillId			= 1439,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,--提高500%命中
		PasstSkillLevel	= 0,
	},

	vongsang2	= { -- Vòng sáng NPC
		AuraSkillId			= 1442,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,--提高500%命中
		PasstSkillLevel	= 0,
	},
	

	bmy_soldier1	= {	--秦始皇陵1层士兵
		Exp					= 20000,
		Life				= 845440,
		LifeReplenish		= 70000,
		AR					= 3000,
		Defense				= 1000,
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.bmy,1),
		PoisonResist		= GetResist(Npc.tbResist.bmy,2),
		ColdResist			= GetResist(Npc.tbResist.bmy,3),
		FireResist 			= GetResist(Npc.tbResist.bmy,4),
		LightResist			= GetResist(Npc.tbResist.bmy,5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.bmy_soldier1, 1, 0.8),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.bmy_soldier1, 2, 0.8),
		ColdDamageBase		= GetAtack(Npc.tbDamage.bmy_soldier1, 3, 0.8),
		FireDamageBase		= GetAtack(Npc.tbDamage.bmy_soldier1, 4, 0.8),
		LightingDamageBase	= GetAtack(Npc.tbDamage.bmy_soldier1, 5, 0.8),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.bmy_soldier1, 1, 0.8),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.bmy_soldier1, 2, 0.8),
		ColdMagicBase		= GetAtack(Npc.tbDamage.bmy_soldier1, 3, 0.8),
		FireMagicBase		= GetAtack(Npc.tbDamage.bmy_soldier1, 4, 0.8),
		LightingMagicBase	= GetAtack(Npc.tbDamage.bmy_soldier1, 5, 0.8),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},

	bmy_leader1	= {	--秦始皇陵1层头领
		Exp					= 45000,
		Life				= 845440,
		LifeReplenish		= 70000,
		AR					= 3000,
		Defense				= 1000,
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.bmy,1),
		PoisonResist		= GetResist(Npc.tbResist.bmy,2),
		ColdResist			= GetResist(Npc.tbResist.bmy,3),
		FireResist 			= GetResist(Npc.tbResist.bmy,4),
		LightResist			= GetResist(Npc.tbResist.bmy,5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.bmy_leader1, 1, 0.8),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.bmy_leader1, 2, 0.8),
		ColdDamageBase		= GetAtack(Npc.tbDamage.bmy_leader1, 3, 0.8),
		FireDamageBase		= GetAtack(Npc.tbDamage.bmy_leader1, 4, 0.8),
		LightingDamageBase	= GetAtack(Npc.tbDamage.bmy_leader1, 5, 0.8),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.bmy_leader1, 1, 0.8),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.bmy_leader1, 2, 0.8),
		ColdMagicBase		= GetAtack(Npc.tbDamage.bmy_leader1, 3, 0.8),
		FireMagicBase		= GetAtack(Npc.tbDamage.bmy_leader1, 4, 0.8),
		LightingMagicBase	= GetAtack(Npc.tbDamage.bmy_leader1, 5, 0.8),

		AuraSkillId			= 594,--GetSeriesData({1091,1091,1007,1133,1362,1133}),
		AuraSkillLevel		= 1,--GetSeriesData({   2,   2,   2,   3,   2,  20}),
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},

	bmy_elite1	= {	--秦始皇陵1层精英
		Exp					= 45000*1.25,
		Life				= 1710362,
		LifeReplenish		= 70000,
		AR					= 3000,
		Defense				= 1000,
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.bmy,1),
		PoisonResist		= GetResist(Npc.tbResist.bmy,2),
		ColdResist			= GetResist(Npc.tbResist.bmy,3),
		FireResist 			= GetResist(Npc.tbResist.bmy,4),
		LightResist			= GetResist(Npc.tbResist.bmy,5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.bmy_elite1, 1, 0.8),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.bmy_elite1, 2, 0.8),
		ColdDamageBase		= GetAtack(Npc.tbDamage.bmy_elite1, 3, 0.8),
		FireDamageBase		= GetAtack(Npc.tbDamage.bmy_elite1, 4, 0.8),
		LightingDamageBase	= GetAtack(Npc.tbDamage.bmy_elite1, 5, 0.8),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.bmy_elite1, 1, 0.8),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.bmy_elite1, 2, 0.8),
		ColdMagicBase		= GetAtack(Npc.tbDamage.bmy_elite1, 3, 0.8),
		FireMagicBase		= GetAtack(Npc.tbDamage.bmy_elite1, 4, 0.8),
		LightingMagicBase	= GetAtack(Npc.tbDamage.bmy_elite1, 5, 0.8),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	smallboss	= {	--秦始皇陵小boss
		Exp					= 600000,
		Life				= {{1,160*0.45},{55,7125000*0.45},{100,21930000*0.45},},
		LifeReplenish		= 70000,
		AR					= 667,
		Defense				= 1500,
		MinDamage			= 1,
		MaxDamage			= 500,
		PhysicsResist		= 300,
		PoisonResist		= 300,
		ColdResist			= 300,
		FireResist 			= 300,
		LightResist			= 300,

		PhysicalDamageBase	= 700,
		PoisonDamageBase	= 700,
		ColdDamageBase		= 700,
		FireDamageBase		= 700,
		LightingDamageBase	= 700,

		PhysicalMagicBase	= 700,
		PoisonMagicBase		= 700,
		ColdMagicBase		= 700,
		FireMagicBase		= 700,
		LightingMagicBase	= 700,

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 1407,--提高500%命中
		PasstSkillLevel		= 10,
	},

---------------------------------------------------------------
	cangbaotunormal1	= {  --藏宝图小怪
		Exp					= { {  1,    50},{  9,    50},
								{ 10,   290},{ 19,   308},
								{ 20,   390},{ 29,   408},
								{ 30,  2000},{ 39,  2000},
								{ 40,  4000},{ 49,  4000},
								{ 50,  5000},{ 59,  5000},
								{ 60,  6000},{ 69,  6000},
								{ 70, 12000},{ 79, 12000},
								{ 80,  2000},{ 89,  2090},
								{ 90,  2300},{ 99,  2480},
								{100,  2800},{109,  3025},
								{110,  3300},{109,  3525},
								{120,  3900},{129,  4170},
								{130,  4500},{139,  4950},
								{140,  5200},{150,  5500},
							  },
		Life				= {{1,90},{9,180},{10,3400},{30,30300},{60,82000},{65,159900},{75,205600},{100,365500},},
		LifeReplenish		= 0,
		AR					= {{1,100},{100,1000},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.special, 1),
		PoisonResist		= GetResist(Npc.tbResist.special, 2),
		ColdResist			= GetResist(Npc.tbResist.special, 3),
		FireResist 			= GetResist(Npc.tbResist.special, 4),
		LightResist			= GetResist(Npc.tbResist.special, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity3, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity3, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity3, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity3, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity3, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity3, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity3, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity3, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity3, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity3, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	cangbaotuboss1	= {
		Exp					= { {  1,     50},{  9,     50},
								{ 10,   2690},{ 19,   2708},
								{ 20,   2990},{ 29,   3008},
								{ 30,   5950},{ 39,   6040},
								{ 40,  75000},{ 49,  75000},
								{ 50,  75000},{ 59,  75000},
								{ 60, 150000},{ 69, 150000},
								{ 70, 300000},{ 79, 300000},
								{ 80,   2000},{ 89,   2090},
								{ 90,   2300},{ 99,   2480},
								{100,   2800},{109,   3025},
								{110,   3300},{109,   3525},
								{120,   3900},{129,   4170},
								{130,   4500},{139,   4950},
								{140,   5200},{150,   5500},
							  },
		Life				= {{1,90*0.9},{9,180*0.9},{10,27400*0.9},{45,438600*0.9},{55,570240*0.9},{65,1151460*0.9},{75,1480500*0.9},{100,2631960*0.9},},
		LifeReplenish		= {{1,1},{10,375},{20,1500},{30,3250},{40,4500},{50,5500},{60,7500},{90,15000},{100,20000}},
		AR					= {{1,100},{100,1000},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity6, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity6, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity6, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity6, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity6, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity6, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity6, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity6, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity6, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity6, 5),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	cangbaotuboss2	= {
		Exp					= { {  1,     50},{  9,     50},
								{ 10,   2690},{ 19,   2708},
								{ 20,   2990},{ 29,   3008},
								{ 30,   5950},{ 39,   6040},
								{ 40,  65000},{ 49,  65000},
								{ 50,  65000},{ 59,  65000},
								{ 60, 150000},{ 69, 150000},
								{ 70, 300000},{ 79, 300000},
								{ 80,   2000},{ 89,   2090},
								{ 90,   2300},{ 99,   2480},
								{100,   2800},{109,   3025},
								{110,   3300},{109,   3525},
								{120,   3900},{129,   4170},
								{130,   4500},{139,   4950},
								{140,   5200},{150,   5500},
							  },
		Life				= {{1,90*0.9},{9,180*0.9},{10,27400*0.9},{45,438600*0.9},{55,570240*0.9},{65,1151460*0.9},{75,1480500*0.9},{100,2631960*0.9},},
		LifeReplenish		= {{1,1},{10,375},{20,1500},{30,3250},{40,4500},{50,5500},{60,7500},{90,15000},{100,20000}},
		AR					= {{1,100},{100,1000},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.cangbaotuboss1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.cangbaotuboss1, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.cangbaotuboss1, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.cangbaotuboss1, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.cangbaotuboss1, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.cangbaotuboss1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.cangbaotuboss1, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.cangbaotuboss1, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.cangbaotuboss1, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.cangbaotuboss1, 5),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},

	cangbaotuboss3	= {
		Exp					= GetData(Npc.tbDataTemplet.cangbaotuboss1_Exp),
		Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 164*Npc.IVER_CangBaoTuNpcStrong),
		LifeReplenish		= {{1,10},{10,375000},{20,1500000},{30,3250000},{40,4500000},{50,5500000},{60,75000000},{90,300000000},{100,400000000}},
		AR					= {{1,100},{100,1000},},
		Defense				= {{1,5},{10,50},{11,300},{100,1000},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,100},{100,1000},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.cangbaotuboss1, 1, 2*Npc.IVER_CangBaoTuNpcStrong),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.cangbaotuboss1, 2, 2*Npc.IVER_CangBaoTuNpcStrong),
		ColdDamageBase		= GetAtack(Npc.tbDamage.cangbaotuboss1, 3, 2*Npc.IVER_CangBaoTuNpcStrong),
		FireDamageBase		= GetAtack(Npc.tbDamage.cangbaotuboss1, 4, 2*Npc.IVER_CangBaoTuNpcStrong),
		LightingDamageBase	= GetAtack(Npc.tbDamage.cangbaotuboss1, 5, 2*Npc.IVER_CangBaoTuNpcStrong),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.cangbaotuboss1, 1, 2*Npc.IVER_CangBaoTuNpcStrong),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.cangbaotuboss1, 2, 2*Npc.IVER_CangBaoTuNpcStrong),
		ColdMagicBase		= GetAtack(Npc.tbDamage.cangbaotuboss1, 3, 2*Npc.IVER_CangBaoTuNpcStrong),
		FireMagicBase		= GetAtack(Npc.tbDamage.cangbaotuboss1, 4, 2*Npc.IVER_CangBaoTuNpcStrong),
		LightingMagicBase	= GetAtack(Npc.tbDamage.cangbaotuboss1, 5, 2*Npc.IVER_CangBaoTuNpcStrong),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	cangbaotuboss4	= {
		Exp					= GetData(Npc.tbDataTemplet.cangbaotuboss2_Exp),
		Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 164*Npc.IVER_CangBaoTuNpcStrong),
		LifeReplenish		= {{1,10},{10,375000},{20,1500000},{30,3250000},{40,4500000},{50,5500000},{60,75000000},{90,300000000},{100,400000000}},
		AR					= {{1,100},{100,1000},},
		Defense				= {{1,5},{10,50},{11,300},{100,1000},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,100},{100,1000},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.cangbaotuboss1, 1, 2*Npc.IVER_CangBaoTuNpcStrong),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.cangbaotuboss1, 2, 2*Npc.IVER_CangBaoTuNpcStrong),
		ColdDamageBase		= GetAtack(Npc.tbDamage.cangbaotuboss1, 3, 2*Npc.IVER_CangBaoTuNpcStrong),
		FireDamageBase		= GetAtack(Npc.tbDamage.cangbaotuboss1, 4, 2*Npc.IVER_CangBaoTuNpcStrong),
		LightingDamageBase	= GetAtack(Npc.tbDamage.cangbaotuboss1, 5, 2*Npc.IVER_CangBaoTuNpcStrong),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.cangbaotuboss1, 1, 2*Npc.IVER_CangBaoTuNpcStrong),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.cangbaotuboss1, 2, 2*Npc.IVER_CangBaoTuNpcStrong),
		ColdMagicBase		= GetAtack(Npc.tbDamage.cangbaotuboss1, 3, 2*Npc.IVER_CangBaoTuNpcStrong),
		FireMagicBase		= GetAtack(Npc.tbDamage.cangbaotuboss1, 4, 2*Npc.IVER_CangBaoTuNpcStrong),
		LightingMagicBase	= GetAtack(Npc.tbDamage.cangbaotuboss1, 5, 2*Npc.IVER_CangBaoTuNpcStrong),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	cangbaotuboss2740	= {--带无形蛊光环
		Exp					= GetData(Npc.tbDataTemplet.cangbaotuboss1_Exp),
		Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 164*Npc.IVER_CangBaoTuNpcStrong),
		LifeReplenish		= {{1,10},{10,375000},{20,1500000},{30,3250000},{40,4500000},{50,5500000},{60,75000000},{90,300000000},{100,400000000}},
		AR					= {{1,100},{100,1000},},
		Defense				= {{1,5},{10,50},{11,300},{100,1000},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,100},{100,1000},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.cangbaotuboss1, 1, 2*Npc.IVER_CangBaoTuNpcStrong),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.cangbaotuboss1, 2, 2*Npc.IVER_CangBaoTuNpcStrong),
		ColdDamageBase		= GetAtack(Npc.tbDamage.cangbaotuboss1, 3, 2*Npc.IVER_CangBaoTuNpcStrong),
		FireDamageBase		= GetAtack(Npc.tbDamage.cangbaotuboss1, 4, 2*Npc.IVER_CangBaoTuNpcStrong),
		LightingDamageBase	= GetAtack(Npc.tbDamage.cangbaotuboss1, 5, 2*Npc.IVER_CangBaoTuNpcStrong),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.cangbaotuboss1, 1, 2*Npc.IVER_CangBaoTuNpcStrong),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.cangbaotuboss1, 2, 2*Npc.IVER_CangBaoTuNpcStrong),
		ColdMagicBase		= GetAtack(Npc.tbDamage.cangbaotuboss1, 3, 2*Npc.IVER_CangBaoTuNpcStrong),
		FireMagicBase		= GetAtack(Npc.tbDamage.cangbaotuboss1, 4, 2*Npc.IVER_CangBaoTuNpcStrong),
		LightingMagicBase	= GetAtack(Npc.tbDamage.cangbaotuboss1, 5, 2*Npc.IVER_CangBaoTuNpcStrong),

		AuraSkillId			= 1007,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},

	cangbaotuboss2736	= {--图腾柱带回复光环,5个人10秒围杀
		Exp					= 0,
		Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 12*Npc.IVER_CangBaoTuNpcStrong),
		LifeReplenish		= 0,
		AR					= {{1,100},{100,1000},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= 1,
		PoisonResist		= 1,
		ColdResist			= 1,
		FireResist 			= 1,
		LightResist			= 1,

		PhysicalDamageBase	= 1,
		PoisonDamageBase	= 1,
		ColdDamageBase		= 1,
		FireDamageBase		= 1,
		LightingDamageBase	= 1,

		PhysicalMagicBase	= 1,
		PoisonMagicBase		= 1,
		ColdMagicBase		= 1,
		FireMagicBase		= 1,
		LightingMagicBase	= 1,

		AuraSkillId			= 1018,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},

	cangbaotunormalEX	= {  --藏宝图精英级怪
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 20),
		Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 80*Npc.IVER_CangBaoTuNpcStrong),
		LifeReplenish		= 0,
		AR					= {{1,100},{100,1000},},
		Defense				= {{1,5},{10,5},{11,30},{100,3000},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,1000},},
		PhysicsResist		= GetResist(Npc.tbResist.special, 1),
		PoisonResist		= GetResist(Npc.tbResist.special, 2),
		ColdResist			= GetResist(Npc.tbResist.special, 3),
		FireResist 			= GetResist(Npc.tbResist.special, 4),
		LightResist			= GetResist(Npc.tbResist.special, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity3, 1, 1*Npc.IVER_CangBaoTuNpcStrong),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity3, 2, 1*Npc.IVER_CangBaoTuNpcStrong),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity3, 3, 1*Npc.IVER_CangBaoTuNpcStrong),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity3, 4, 1*Npc.IVER_CangBaoTuNpcStrong),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity3, 5, 1*Npc.IVER_CangBaoTuNpcStrong),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity3, 1, 1*Npc.IVER_CangBaoTuNpcStrong),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity3, 2, 1*Npc.IVER_CangBaoTuNpcStrong),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity3, 3, 1*Npc.IVER_CangBaoTuNpcStrong),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity3, 4, 1*Npc.IVER_CangBaoTuNpcStrong),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity3, 5, 1*Npc.IVER_CangBaoTuNpcStrong),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},

	cangbaotuboss2760	= {
		Exp					= GetData(Npc.tbDataTemplet.cangbaotuboss1_Exp),
		Life				= 150000000*Npc.IVER_CangBaoTuNpcStrong,
		LifeReplenish		= {{1,1},{10,375},{20,1500},{30,3250},{40,4500},{50,5500},{60,7500},{90,15000},{100,20000}},
		AR					= {{1,100},{100,1000},},
		Defense				= {{1,200},{10,500},{11,800},{100,1500},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,1000},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.5*Npc.IVER_CangBaoTuNpcStrong),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3, 2, 0.5*Npc.IVER_CangBaoTuNpcStrong),
		ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.5*Npc.IVER_CangBaoTuNpcStrong),
		FireDamageBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.5*Npc.IVER_CangBaoTuNpcStrong),
		LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.5*Npc.IVER_CangBaoTuNpcStrong),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.5*Npc.IVER_CangBaoTuNpcStrong),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3, 2, 0.5*Npc.IVER_CangBaoTuNpcStrong),
		ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.5*Npc.IVER_CangBaoTuNpcStrong),
		FireMagicBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.5*Npc.IVER_CangBaoTuNpcStrong),
		LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.5*Npc.IVER_CangBaoTuNpcStrong),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	cangbaotunormal2759	= {  --铁莫西
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 20),
		Life				= 90000000*Npc.IVER_CangBaoTuNpcStrong,
		LifeReplenish		= 0,
		AR					= {{1,100},{100,1000},},
		Defense				= {{1,200},{10,500},{11,800},{100,1500},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,1000},},
		PhysicsResist		= GetResist(Npc.tbResist.special, 1),
		PoisonResist		= GetResist(Npc.tbResist.special, 2),
		ColdResist			= GetResist(Npc.tbResist.special, 3),
		FireResist 			= GetResist(Npc.tbResist.special, 4),
		LightResist			= GetResist(Npc.tbResist.special, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.35*Npc.IVER_CangBaoTuNpcStrong),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3, 2, 0.35*Npc.IVER_CangBaoTuNpcStrong),
		ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.35*Npc.IVER_CangBaoTuNpcStrong),
		FireDamageBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.35*Npc.IVER_CangBaoTuNpcStrong),
		LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.35*Npc.IVER_CangBaoTuNpcStrong),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.35*Npc.IVER_CangBaoTuNpcStrong),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3, 2, 0.35*Npc.IVER_CangBaoTuNpcStrong),
		ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.35*Npc.IVER_CangBaoTuNpcStrong),
		FireMagicBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.35*Npc.IVER_CangBaoTuNpcStrong),
		LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.35*Npc.IVER_CangBaoTuNpcStrong),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	cangbaotunormal2775	= {  --蛮族战士
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 10),
		Life				= 150000000*Npc.IVER_CangBaoTuNpcStrong,
		LifeReplenish		= 0,
		AR					= {{1,100},{100,1000},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.special, 1),
		PoisonResist		= GetResist(Npc.tbResist.special, 2),
		ColdResist			= GetResist(Npc.tbResist.special, 3),
		FireResist 			= GetResist(Npc.tbResist.special, 4),
		LightResist			= GetResist(Npc.tbResist.special, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.25*Npc.IVER_CangBaoTuNpcStrong),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3, 2, 0.25*Npc.IVER_CangBaoTuNpcStrong),
		ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.25*Npc.IVER_CangBaoTuNpcStrong),
		FireDamageBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.25*Npc.IVER_CangBaoTuNpcStrong),
		LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.25*Npc.IVER_CangBaoTuNpcStrong),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.25*Npc.IVER_CangBaoTuNpcStrong),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3, 2, 0.25*Npc.IVER_CangBaoTuNpcStrong),
		ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.25*Npc.IVER_CangBaoTuNpcStrong),
		FireMagicBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.25*Npc.IVER_CangBaoTuNpcStrong),
		LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.25*Npc.IVER_CangBaoTuNpcStrong),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	cangbaotunormal2782	= {  --蛮族医师
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 7),
		Life				= 350000*Npc.IVER_CangBaoTuNpcStrong,
		LifeReplenish		= 0,
		AR					= {{1,100},{100,1000},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.special, 1),
		PoisonResist		= GetResist(Npc.tbResist.special, 2),
		ColdResist			= GetResist(Npc.tbResist.special, 3),
		FireResist 			= GetResist(Npc.tbResist.special, 4),
		LightResist			= GetResist(Npc.tbResist.special, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.3*Npc.IVER_CangBaoTuNpcStrong),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3, 2, 0.3*Npc.IVER_CangBaoTuNpcStrong),
		ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.3*Npc.IVER_CangBaoTuNpcStrong),
		FireDamageBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.3*Npc.IVER_CangBaoTuNpcStrong),
		LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.3*Npc.IVER_CangBaoTuNpcStrong),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.3*Npc.IVER_CangBaoTuNpcStrong),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3, 2, 0.3*Npc.IVER_CangBaoTuNpcStrong),
		ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.3*Npc.IVER_CangBaoTuNpcStrong),
		FireMagicBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.3*Npc.IVER_CangBaoTuNpcStrong),
		LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.3*Npc.IVER_CangBaoTuNpcStrong),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	cangbaotunormal2776	= {  --黑熊
		Exp					= GetData(Npc.tbDataTemplet.intensity99, 6),
		Life				= 300000*Npc.IVER_CangBaoTuNpcStrong,
		LifeReplenish		= 0,
		AR					= {{1,100},{100,1000},},
		Defense				= {{1,5},{10,5},{11,30},{100,3000},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,1000},},
		PhysicsResist		= GetResist(Npc.tbResist.special, 1),
		PoisonResist		= GetResist(Npc.tbResist.special, 2),
		ColdResist			= GetResist(Npc.tbResist.special, 3),
		FireResist 			= GetResist(Npc.tbResist.special, 4),
		LightResist			= GetResist(Npc.tbResist.special, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.25*Npc.IVER_CangBaoTuNpcStrong),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3, 2, 0.25*Npc.IVER_CangBaoTuNpcStrong),
		ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.25*Npc.IVER_CangBaoTuNpcStrong),
		FireDamageBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.25*Npc.IVER_CangBaoTuNpcStrong),
		LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.25*Npc.IVER_CangBaoTuNpcStrong),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.25*Npc.IVER_CangBaoTuNpcStrong),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3, 2, 0.25*Npc.IVER_CangBaoTuNpcStrong),
		ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.25*Npc.IVER_CangBaoTuNpcStrong),
		FireMagicBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.25*Npc.IVER_CangBaoTuNpcStrong),
		LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.25*Npc.IVER_CangBaoTuNpcStrong),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	cangbaotunormal2778	= {  --花豹
		Exp					= 90000,
		Life				= 200000000,
		LifeReplenish		= 0,
		AR					= {{1,100},{100,3000},},
		Defense				= {{1,10},{10,100},{11,110},{100,1000},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,1000},},
		PhysicsResist		= GetResist(Npc.tbResist.special, 1),
		PoisonResist		= GetResist(Npc.tbResist.special, 2),
		ColdResist			= GetResist(Npc.tbResist.special, 3),
		FireResist 			= GetResist(Npc.tbResist.special, 4),
		LightResist			= GetResist(Npc.tbResist.special, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3, 1, 100),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3, 2, 100),
		ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3, 3, 100),
		FireDamageBase		= GetAtack(Npc.tbDamage.fellow3, 4, 100),
		LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3, 5, 100),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3, 1, 100),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3, 2, 100),
		ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3, 3, 100),
		FireMagicBase		= GetAtack(Npc.tbDamage.fellow3, 4, 100),
		LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3, 5, 100),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},

	cangbaotufellow2761	= {  --陶子
		Exp					= 0,
		Life				= 100000000,
		LifeReplenish		= 0,
		AR					= {{1,100},{100,1000},},
		Defense				= {{1,200},{10,500},{11,800},{100,1500},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,1000},},
		PhysicsResist		= 0,
		PoisonResist		= 0,
		ColdResist			= 0,
		FireResist 			= 0,
		LightResist			= 0,

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.3),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3, 2, 0.3),
		ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.3),
		FireDamageBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.3),
		LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.3),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.3),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3, 2, 0.3),
		ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.3),
		FireMagicBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.3),
		LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.3),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	cangbaotufellow2764	= {  --青青
		Exp					= 0,
		Life				= 100000000,
		LifeReplenish		= 0,
		AR					= {{1,100},{100,3000},},
		Defense				= 1,
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= 0,
		PoisonResist		= 0,
		ColdResist			= 0,
		FireResist 			= 0,
		LightResist			= 0,

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.5),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3, 2, 0.5),
		ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.5),
		FireDamageBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.5),
		LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.5),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3, 2, 0.5),
		ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.5),
		FireMagicBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.5),
		LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.5),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	muren	= {
		Exp					= 0,
		Life				= {{1,100},{10,1000},{20,3000},{30,5000},{40,10000},{50,30000},{60,50000000},{70,100000000},},
		LifeReplenish		= 0,
		AR					= 0,
		Defense				= 0,
		MinDamage			= 1,
		MaxDamage			= 2,
		PhysicsResist		= 0,
		PoisonResist		= 0,
		ColdResist			= 0,
		FireResist 			= 0,
		LightResist			= 0,

		PhysicalDamageBase	= 1,
		PoisonDamageBase	= 1,
		ColdDamageBase		= 1,
		FireDamageBase		= 1,
		LightingDamageBase	= 1,

		PhysicalMagicBase	= 1,
		PoisonMagicBase		= 1,
		ColdMagicBase		= 1,
		FireMagicBase		= 1,
		LightingMagicBase	= 1,

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},

	wanted		= {		--通缉任务
		Exp					= 1,
		Life				= {{1,100},{10,1000},{20,3000},{30,5000},{40,500000},{50,1000000},{80,2000000},{100,3000000}},
		LifeReplenish		= 0,
		AR					= 667,
		Defense				= 300,
		MinDamage			= 1,
		MaxDamage			= 500,
		PhysicsResist		= 200,
		PoisonResist		= 200,
		ColdResist			= 200,
		FireResist 			= 200,
		LightResist			= 200,

		PhysicalDamageBase	= 1500,
		PoisonDamageBase	= 1500,
		ColdDamageBase		= 1500,
		FireDamageBase		= 1500,
		LightingDamageBase	= 1500,

		PhysicalMagicBase	= 1500,
		PoisonMagicBase		= 1500,
		ColdMagicBase		= 1500,
		FireMagicBase		= 1500,
		LightingMagicBase	= 1500,

		AuraSkillId			= 1007,
		AuraSkillLevel		= 1,
		PasstSkillId		= 1407,--提高500%命中
		PasstSkillLevel		= 10,
	},

	npc4006		= {
		Exp					= 1,
		Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 125),
		LifeReplenish		= {{1,1},{10,375},{20,1500},{30,3250},{40,4500},{50,5500},{60,7500},{90,15000},{100,20000}},
		AR					= {{1,100},{100,1000},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= 1,
		PoisonResist		= 1,
		ColdResist			= 1,
		FireResist 			= 1,
		LightResist			= 1,

		PhysicalDamageBase	= GetAtack(Npc.tbResist.boss1, 1, 2),
		PoisonDamageBase	= GetAtack(Npc.tbResist.boss1, 2, 2),
		ColdDamageBase		= GetAtack(Npc.tbResist.boss1, 3, 2),
		FireDamageBase		= GetAtack(Npc.tbResist.boss1, 4, 2),
		LightingDamageBase	= GetAtack(Npc.tbResist.boss1, 5, 2),

		PhysicalMagicBase	= GetAtack(Npc.tbResist.boss1, 1, 2),
		PoisonMagicBase		= GetAtack(Npc.tbResist.boss1, 2, 2),
		ColdMagicBase		= GetAtack(Npc.tbResist.boss1, 3, 2),
		FireMagicBase		= GetAtack(Npc.tbResist.boss1, 4, 2),
		LightingMagicBase	= GetAtack(Npc.tbResist.boss1, 5, 2),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	npc4004		= {
		Exp					= 0,
		Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 223),
		LifeReplenish		= {{1,1},{10,375},{20,1500},{30,3250},{40,4500},{50,5500},{60,7500},{90,15000},{100,20000}},
		AR					= {{1,100},{100,1000},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= 1,
		PoisonResist		= 1,
		ColdResist			= 1,
		FireResist 			= 1,
		LightResist			= 1,

		PhysicalDamageBase	= GetAtack(Npc.tbResist.boss1, 1, 2),
		PoisonDamageBase	= GetAtack(Npc.tbResist.boss1, 2, 2),
		ColdDamageBase		= GetAtack(Npc.tbResist.boss1, 3, 2),
		FireDamageBase		= GetAtack(Npc.tbResist.boss1, 4, 2),
		LightingDamageBase	= GetAtack(Npc.tbResist.boss1, 5, 2),

		PhysicalMagicBase	= GetAtack(Npc.tbResist.boss1, 1, 2.3),
		PoisonMagicBase		= GetAtack(Npc.tbResist.boss1, 2, 2.3),
		ColdMagicBase		= GetAtack(Npc.tbResist.boss1, 3, 2.3),
		FireMagicBase		= GetAtack(Npc.tbResist.boss1, 4, 2.3),
		LightingMagicBase	= GetAtack(Npc.tbResist.boss1, 5, 2.3),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	npc4002		= {
		Exp					= 0,
		Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 279),
		LifeReplenish		= {{1,1},{10,375},{20,1500},{30,3250},{40,4500},{50,5500},{60,7500},{90,15000},{100,20000}},
		AR					= {{1,100},{100,1000},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= 1,
		PoisonResist		= 1,
		ColdResist			= 1,
		FireResist 			= 1,
		LightResist			= 1,

		PhysicalDamageBase	= GetAtack(Npc.tbResist.boss1, 1, 2.5),
		PoisonDamageBase	= GetAtack(Npc.tbResist.boss1, 2, 2.5),
		ColdDamageBase		= GetAtack(Npc.tbResist.boss1, 3, 2.5),
		FireDamageBase		= GetAtack(Npc.tbResist.boss1, 4, 2.5),
		LightingDamageBase	= GetAtack(Npc.tbResist.boss1, 5, 2.5),

		PhysicalMagicBase	= GetAtack(Npc.tbResist.boss1, 1, 2.5),
		PoisonMagicBase		= GetAtack(Npc.tbResist.boss1, 2, 2.5),
		ColdMagicBase		= GetAtack(Npc.tbResist.boss1, 3, 2.5),
		FireMagicBase		= GetAtack(Npc.tbResist.boss1, 4, 2.5),
		LightingMagicBase	= GetAtack(Npc.tbResist.boss1, 5, 2.5),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	npc2773		= {		--暗哨
		Exp					= 0,
		Life				= {{1,90},{9,180},{10,6100},{30,53800},{60,159900},{100,365500},},
		LifeReplenish		= 0,
		AR					= {{1,100},{100,1000},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= 1,
		PoisonResist		= 1,
		ColdResist			= 1,
		FireResist 			= 1,
		LightResist			= 1,

		PhysicalDamageBase	= GetAtack(Npc.tbResist.boss1, 1, 1),
		PoisonDamageBase	= GetAtack(Npc.tbResist.boss1, 2, 1),
		ColdDamageBase		= GetAtack(Npc.tbResist.boss1, 3, 1),
		FireDamageBase		= GetAtack(Npc.tbResist.boss1, 4, 1),
		LightingDamageBase	= GetAtack(Npc.tbResist.boss1, 5, 1),

		PhysicalMagicBase	= GetAtack(Npc.tbResist.boss1, 1, 1),
		PoisonMagicBase		= GetAtack(Npc.tbResist.boss1, 2, 1),
		ColdMagicBase		= GetAtack(Npc.tbResist.boss1, 3, 1),
		FireMagicBase		= GetAtack(Npc.tbResist.boss1, 4, 1),
		LightingMagicBase	= GetAtack(Npc.tbResist.boss1, 5, 1),

		AuraSkillId			= 988,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	npc4074		= {		--雪魂珠和仙乳灵石
		Exp					= 0,
		Life				= {{1,90},{9,180},{10,6100},{30,53800},{60,159900},{100,365500},},
		LifeReplenish		= 0,
		AR					= {{1,100},{100,1000},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= 1,
		PoisonResist		= 1,
		ColdResist			= 1,
		FireResist 			= 1,
		LightResist			= 1,

		PhysicalDamageBase	= 1,
		PoisonDamageBase	= 1,
		ColdDamageBase		= 1,
		FireDamageBase		= 1,
		LightingDamageBase	= 1,

		PhysicalMagicBase	= 1,
		PoisonMagicBase		= 1,
		ColdMagicBase		= 1,
		FireMagicBase		= 1,
		LightingMagicBase	= 1,

		AuraSkillId			= 1018,
		AuraSkillLevel		= 2,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	npc4097		= {		--机关,强度4
		Exp					= 1,
		Life				= {{1,90},{9,180},{10,6100},{30,53800},{60,159900},{100,365500},},
		LifeReplenish		= 0,
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.special, 1),
		PoisonResist		= GetResist(Npc.tbResist.special, 2),
		ColdResist			= GetResist(Npc.tbResist.special, 3),
		FireResist 			= GetResist(Npc.tbResist.special, 4),
		LightResist			= GetResist(Npc.tbResist.special, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 0.5),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 0.5),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 0.5),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 0.5),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 0.5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 0.5),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 0.5),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 0.5),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 0.5),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 0.5),

		AuraSkillId			= 1024,--1024无形蛊击退,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
-----------------------------------------------------
	npc4241		= {		--任务副本,帅
		Exp					= 1,
		Life				= GetData(Npc.tbDataTemplet.intensity5_Life),
		LifeReplenish		= 0,
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.4),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3, 2, 0.4),
		ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.4),
		FireDamageBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.4),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.4),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3, 2, 0.4),
		ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.4),
		FireMagicBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.4),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	npc4242		= {		--任务副本,仕
		Exp					= 1,
		Life				= GetData(Npc.tbDataTemplet.intensity2_Life),
		LifeReplenish		= 0,
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.2),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3, 2, 0.2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.2),
		FireDamageBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.2),
		LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.2),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.2),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3, 2, 0.2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.2),
		FireMagicBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.2),
		LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.2),

		AuraSkillId			= 1018,--回血光环,半秒2W
		AuraSkillLevel		= 4,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	npc4243		= {		--任务副本,相
		Exp					= 1,
		Life				= GetData(Npc.tbDataTemplet.intensity2_Life),
		LifeReplenish		= 0,
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.2),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3, 2, 0.2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.2),
		FireDamageBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.2),
		LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.2),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.2),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3, 2, 0.2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.2),
		FireMagicBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.2),
		LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.2),

		AuraSkillId			= 1362,--提高友方攻击光环,3级30%
		AuraSkillLevel		= 3,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
----------------区域争夺战---------------
	dispute_boss  	= {		--区域争夺战boss
		Exp					= 0,
		Life				= GetData(Npc.tbDataTemplet.domain_Life, 156*6),--15人打1分钟
		LifeReplenish		= 0,--{{1,1*5},{10,375*5},{20,1500*5},{30,3250*5},{40,4500*5},{50,5500*5},{60,7500*5},{90,15000*5},{100,20000*5}},
		AR					= {{1,30},{10,300},{100,3000},},
		Defense				= {{1,5},{10,100},{100,1000},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,100},{100,100},},
		PhysicsResist		= GetResist(Npc.tbResist.special, 1),
		PoisonResist		= GetResist(Npc.tbResist.special, 2),
		ColdResist			= GetResist(Npc.tbResist.special, 3),
		FireResist 			= GetResist(Npc.tbResist.special, 4),
		LightResist			= GetResist(Npc.tbResist.special, 5),
		--100级攻击1600左右
		PhysicalDamageBase	= GetAtack(Npc.tbDamage.domainatk, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.domainatk, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.domainatk, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.domainatk, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.domainatk, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.domainatk, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.domainatk, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.domainatk, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.domainatk, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.domainatk, 5),

		AuraSkillId			= 594,--免疫五行状态光环,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	dispute_general  	= {		--区域争夺战将领
		Exp					= 0,
		Life				= GetData(Npc.tbDataTemplet.domain_Life, 156*1.4),--15人打1分钟
		LifeReplenish		= 0,--{{1,1*5},{10,375*5},{20,1500*5},{30,3250*5},{40,4500*5},{50,5500*5},{60,7500*5},{90,15000*5},{100,20000*5}},
		AR					= {{1,30},{10,300},{100,3000},},
		Defense				= {{1,5},{10,100},{100,1000},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,100},{100,100},},
		PhysicsResist		= GetResist(Npc.tbResist.special, 1),
		PoisonResist		= GetResist(Npc.tbResist.special, 2),
		ColdResist			= GetResist(Npc.tbResist.special, 3),
		FireResist 			= GetResist(Npc.tbResist.special, 4),
		LightResist			= GetResist(Npc.tbResist.special, 5),
		--100级攻击1600左右
		PhysicalDamageBase	= GetAtack(Npc.tbDamage.domainatk, 1, 0.4),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.domainatk, 2, 0.4),
		ColdDamageBase		= GetAtack(Npc.tbDamage.domainatk, 3, 0.4),
		FireDamageBase		= GetAtack(Npc.tbDamage.domainatk, 4, 0.4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.domainatk, 5, 0.4),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.domainatk, 1, 0.4),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.domainatk, 2, 0.4),
		ColdMagicBase		= GetAtack(Npc.tbDamage.domainatk, 3, 0.4),
		FireMagicBase		= GetAtack(Npc.tbDamage.domainatk, 4, 0.4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.domainatk, 5, 0.4),

		AuraSkillId			= 594,--免疫五行状态光环,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	dispute_soldier  	= {		--区域争夺战士兵
		Exp					= 0,
		Life				= GetData(Npc.tbDataTemplet.domain_Life, 24.5*1.4),--15人打0.25分钟
		LifeReplenish		= 0,--{{1,1*5},{10,375*5},{20,1500*5},{30,3250*5},{40,4500*5},{50,5500*5},{60,7500*5},{90,15000*5},{100,20000*5}},
		AR					= {{1,25},{10,250},{100,2500},},
		Defense				= {{1,7},{10,75},{100,750},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,100},{100,100},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),
		--100级攻击800左右
		PhysicalDamageBase	= GetAtack(Npc.tbDamage.domainatk, 1, 0.25),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.domainatk, 2, 0.25),
		ColdDamageBase		= GetAtack(Npc.tbDamage.domainatk, 3, 0.25),
		FireDamageBase		= GetAtack(Npc.tbDamage.domainatk, 4, 0.25),
		LightingDamageBase	= GetAtack(Npc.tbDamage.domainatk, 5, 0.25),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.domainatk, 1, 0.25),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.domainatk, 2, 0.25),
		ColdMagicBase		= GetAtack(Npc.tbDamage.domainatk, 3, 0.25),
		FireMagicBase		= GetAtack(Npc.tbDamage.domainatk, 4, 0.25),
		LightingMagicBase	= GetAtack(Npc.tbDamage.domainatk, 5, 0.25),

		AuraSkillId			= 594,--免疫五行状态光环,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	dispute_pillar  	= {		--非主城龙柱
		Exp					= 0,
		Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 334),--12人打2分钟
		LifeReplenish		= 0,
		AR					= 1,
		Defense				= 1,
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,100},{100,100},},
		PhysicsResist		= GetResist(Npc.tbResist.normal, 1),
		PoisonResist		= GetResist(Npc.tbResist.normal, 2),
		ColdResist			= GetResist(Npc.tbResist.normal, 3),
		FireResist 			= GetResist(Npc.tbResist.normal, 4),
		LightResist			= GetResist(Npc.tbResist.normal, 5),
		--100级攻击800左右
		PhysicalDamageBase	= 1,
		PoisonDamageBase	= 1,
		ColdDamageBase		= 1,
		FireDamageBase		= 1,
		LightingDamageBase	= 1,

		PhysicalMagicBase	= 1,
		PoisonMagicBase		= 1,
		ColdMagicBase		= 1,
		FireMagicBase		= 1,
		LightingMagicBase	= 1,

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 1411,
		PasstSkillLevel		= 1,
	},
	dispute_tank10  	= {		--攻城车
		Exp					= 0,
		Life				= GetData(Npc.tbDataTemplet.dispute10_Life, 4),
		LifeReplenish		= 0,--{{1,1*5},{10,375*5},{20,1500*5},{30,3250*5},{40,4500*5},{50,5500*5},{60,7500*5},{90,15000*5},{100,20000*5}},
		AR					= {{1,30},{10,300},{100,3000},},
		Defense				= {{1,5},{10,100},{100,1000},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,100},{100,100},},
		PhysicsResist		= GetResist(Npc.tbResist.dispute10, 1),
		PoisonResist		= GetResist(Npc.tbResist.dispute10, 2),
		ColdResist			= GetResist(Npc.tbResist.dispute10, 3),
		FireResist 			= GetResist(Npc.tbResist.dispute10, 4),
		LightResist			= GetResist(Npc.tbResist.dispute10, 5),
		--100级攻击1600左右
		PhysicalDamageBase	= GetAtack(Npc.tbDamage.dispute10, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.dispute10, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.dispute10, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.dispute10, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.dispute10, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.dispute10, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.dispute10, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.dispute10, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.dispute10, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.dispute10, 5),

		AuraSkillId			= 0,--免疫五行状态光环,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	dispute_tank12  	= {		--攻城车
		Exp					= 0,
		Life				= GetData(Npc.tbDataTemplet.dispute12_Life, 4),
		LifeReplenish		= 0,--{{1,1*5},{10,375*5},{20,1500*5},{30,3250*5},{40,4500*5},{50,5500*5},{60,7500*5},{90,15000*5},{100,20000*5}},
		AR					= {{1,30},{10,300},{100,3000},},
		Defense				= {{1,5},{10,100},{100,1000},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,100},{100,100},},
		PhysicsResist		= GetResist(Npc.tbResist.dispute12, 1),
		PoisonResist		= GetResist(Npc.tbResist.dispute12, 2),
		ColdResist			= GetResist(Npc.tbResist.dispute12, 3),
		FireResist 			= GetResist(Npc.tbResist.dispute12, 4),
		LightResist			= GetResist(Npc.tbResist.dispute12, 5),
		--100级攻击1600左右
		PhysicalDamageBase	= GetAtack(Npc.tbDamage.dispute12, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.dispute12, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.dispute12, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.dispute12, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.dispute12, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.dispute12, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.dispute12, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.dispute12, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.dispute12, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.dispute12, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	dispute_tank14  	= {		--攻城车
		Exp					= 0,
		Life				= GetData(Npc.tbDataTemplet.dispute14_Life, 4),
		LifeReplenish		= 0,--{{1,1*5},{10,375*5},{20,1500*5},{30,3250*5},{40,4500*5},{50,5500*5},{60,7500*5},{90,15000*5},{100,20000*5}},
		AR					= {{1,30},{10,300},{100,3000},},
		Defense				= {{1,5},{10,100},{100,1000},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,100},{100,100},},
		PhysicsResist		= GetResist(Npc.tbResist.dispute14, 1),
		PoisonResist		= GetResist(Npc.tbResist.dispute14, 2),
		ColdResist			= GetResist(Npc.tbResist.dispute14, 3),
		FireResist 			= GetResist(Npc.tbResist.dispute14, 4),
		LightResist			= GetResist(Npc.tbResist.dispute14, 5),
		--100级攻击1600左右
		PhysicalDamageBase	= GetAtack(Npc.tbDamage.dispute14, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.dispute14, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.dispute14, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.dispute14, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.dispute14, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.dispute14, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.dispute14, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.dispute14, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.dispute14, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.dispute14, 5),

		AuraSkillId			= 0,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	dispute_mercenary_atk  	= {		--区域争夺战雇佣兵攻击型
		Exp					= 0,
		Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 110),
		LifeReplenish		= 0,--{{1,1*5},{10,375*5},{20,1500*5},{30,3250*5},{40,4500*5},{50,5500*5},{60,7500*5},{90,15000*5},{100,20000*5}},
		AR					= {{1,30},{10,300},{100,3000},},
		Defense				= {{1,5},{10,100},{100,1000},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,100},{100,100},},
		PhysicsResist		= GetResist(Npc.tbResist.special, 1),
		PoisonResist		= GetResist(Npc.tbResist.special, 2),
		ColdResist			= GetResist(Npc.tbResist.special, 3),
		FireResist 			= GetResist(Npc.tbResist.special, 4),
		LightResist			= GetResist(Npc.tbResist.special, 5),
		--100级攻击1600左右
		PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.4),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3, 2, 0.4),
		ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.4),
		FireDamageBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.4),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.4),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3, 2, 0.4),
		ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.4),
		FireMagicBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.4),

		AuraSkillId			= 0,--免疫五行状态光环,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	dispute_mercenary_def  	= {		--区域争夺战雇佣兵防御型
		Exp					= 0,
		Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 312),--15人打2分钟
		LifeReplenish		= 0,--{{1,1*5},{10,375*5},{20,1500*5},{30,3250*5},{40,4500*5},{50,5500*5},{60,7500*5},{90,15000*5},{100,20000*5}},
		AR					= {{1,30},{10,300},{100,3000},},
		Defense				= {{1,5},{10,100},{100,1000},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,100},{100,100},},
		PhysicsResist		= GetResist(Npc.tbResist.special, 1),
		PoisonResist		= GetResist(Npc.tbResist.special, 2),
		ColdResist			= GetResist(Npc.tbResist.special, 3),
		FireResist 			= GetResist(Npc.tbResist.special, 4),
		LightResist			= GetResist(Npc.tbResist.special, 5),
		--100级攻击1600左右
		PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.2),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3, 2, 0.2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.2),
		FireDamageBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.2),
		LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.2),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.2),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3, 2, 0.2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.2),
		FireMagicBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.2),
		LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.2),

		AuraSkillId			= 0,--免疫五行状态光环,
		AuraSkillLevel		= 0,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
----------------游龙阁--------------------
	youlonggegongzhu  	= {		--游龙阁公主
		Exp					= 0,
		Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 10),--1个人打20s
		LifeReplenish		= 0,
		AR					= {{1,30},{10,300},{100,3000},},
		Defense				= {{1,5},{10,100},{100,1000},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,100},{100,100},},
		PhysicsResist		= GetResist(Npc.tbResist.special, 1),
		PoisonResist		= GetResist(Npc.tbResist.special, 2),
		ColdResist			= GetResist(Npc.tbResist.special, 3),
		FireResist 			= GetResist(Npc.tbResist.special, 4),
		LightResist			= GetResist(Npc.tbResist.special, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity5, 1, 0.1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity5, 2, 0.1),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity5, 3, 0.1),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity5, 4, 0.1),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity5, 5, 0.1),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity5, 1, 0.1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity5, 2, 0.1),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity5, 3, 0.1),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity5, 4, 0.1),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity5, 5, 0.1),

		AuraSkillId			= 594,--免疫五行状态光环,
		AuraSkillLevel		= 1,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
----------------逍遥谷---------------
-------------逍遥谷特殊怪------------
	xoyo_rebound	= {--xoyo谷特殊怪1,高反弹,需要断断续续的打
		Exp					= 1,
		Life				= 20000,
		LifeReplenish		= 0,
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= 0,
		PoisonResist		= 0,
		ColdResist			= 0,
		FireResist 			= 0,
		LightResist			= 0,

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity2, 1),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity2, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity2, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity2, 4),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity2, 5),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity2, 1),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity2, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity2, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity2, 4),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity2, 5),

		AuraSkillId			= 1091,
		AuraSkillLevel		= 4,
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	xoyoboss3180	= {--xoyo谷boss4分钟
		Exp					= 1,
		Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 36),
		LifeReplenish		= {{1,1},{10,375},{20,1500},{30,3250},{40,4500},{50,5500},{60,7500},{90,15000},{100,20000}},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity2, 1, 3),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity2, 2, 3),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity2, 3, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity2, 4, 3),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity2, 5, 3),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity2, 1, 3),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity2, 2, 3),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity2, 3, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity2, 4, 3),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity2, 5, 3),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 973,
		PasstSkillLevel		= 1,
	},
	xoyoboss3200	= {--xoyo谷boss6分钟
		Exp					= 1,
		Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 50),
		LifeReplenish		= {{1,1},{10,375},{20,1500},{30,3250},{40,4500},{50,5500},{60,7500},{90,15000},{100,20000}},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity2, 1, 2),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity2, 2, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity2, 3, 2),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity2, 4, 2),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity2, 5, 2),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity2, 1, 2),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity2, 2, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity2, 3, 2),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity2, 4, 2),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity2, 5, 2),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 973,
		PasstSkillLevel		= 1,
	},
	xoyoboss3201	= {--xoyo谷boss8分钟
		Exp					= 1,
		Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 55),
		LifeReplenish		= {{1,1},{10,375},{20,1500},{30,3250},{40,4500},{50,5500},{60,7500},{90,15000},{100,20000}},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity2, 1, 3),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity2, 2, 3),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity2, 3, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity2, 4, 3),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity2, 5, 3),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity2, 1, 3),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity2, 2, 3),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity2, 3, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity2, 4, 3),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity2, 5, 3),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 220,
		PasstSkillLevel		= 20,
	},
	xoyoboss3216	= {--xoyo谷boss10分钟
		Exp					= 1,
		Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 55),
		LifeReplenish		= {{1,1},{10,375},{20,1500},{30,3250},{40,4500},{50,5500},{60,7500},{90,15000},{100,20000}},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity2, 1, 3),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity2, 2, 3),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity2, 3, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity2, 4, 3),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity2, 5, 3),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity2, 1, 3),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity2, 2, 3),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity2, 3, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity2, 4, 3),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity2, 5, 3),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 973,
		PasstSkillLevel		= 1,
	},
	xoyoboss3221	= {--xoyo谷boss7分钟
		Exp					= 1,
		Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 65),
		LifeReplenish		= {{1,1},{10,375},{20,1500},{30,3250},{40,4500},{50,5500},{60,7500},{90,15000},{100,20000}},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity2, 1, 3),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity2, 2, 3),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity2, 3, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity2, 4, 3),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity2, 5, 3),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity2, 1, 3),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity2, 2, 3),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity2, 3, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity2, 4, 3),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity2, 5, 3),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 973,
		PasstSkillLevel		= 1,
	},
	xoyoboss3316	= {--xoyo谷boss7分钟
		Exp					= 1,
		Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 65),
		LifeReplenish		= {{1,1},{10,375},{20,1500},{30,3250},{40,4500},{50,5500},{60,7500},{90,15000},{100,20000}},
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity2, 1, 3),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity2, 2, 3),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity2, 3, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity2, 4, 3),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity2, 5, 3),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity2, 1, 3),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity2, 2, 3),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity2, 3, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity2, 4, 3),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity2, 5, 3),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 973,
		PasstSkillLevel		= 1,
	},
	xoyoboss3320	= {--xoyo谷boss8分钟*1.3
		Exp					= 1,
		Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 71),
		LifeReplenish		= {{1,1},{10,375},{20,1500},{30,3250},{40,4500},{50,5500},{60,7500},{90,15000},{100,20000}},   --5秒回血
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= {{1,5},{10,5},{11,30},{100,300},},
		MinDamage			= {{1,1},{100,1},},
		MaxDamage			= {{1,10},{100,10},},
		PhysicsResist		= GetResist(Npc.tbResist.boss1, 1),
		PoisonResist		= GetResist(Npc.tbResist.boss1, 2),
		ColdResist			= GetResist(Npc.tbResist.boss1, 3),
		FireResist 			= GetResist(Npc.tbResist.boss1, 4),
		LightResist			= GetResist(Npc.tbResist.boss1, 5),

		PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity2, 1, 3),
		PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity2, 2, 2),
		ColdDamageBase		= GetAtack(Npc.tbDamage.intensity2, 3, 3),
		FireDamageBase		= GetAtack(Npc.tbDamage.intensity2, 4, 3),
		LightingDamageBase	= GetAtack(Npc.tbDamage.intensity2, 5, 3),

		PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity2, 1, 3),
		PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity2, 2, 2),
		ColdMagicBase		= GetAtack(Npc.tbDamage.intensity2, 3, 3),
		FireMagicBase		= GetAtack(Npc.tbDamage.intensity2, 4, 3),
		LightingMagicBase	= GetAtack(Npc.tbDamage.intensity2, 5, 3),

		AuraSkillId			= 594,
		AuraSkillLevel		= 1,
		PasstSkillId		= 220,
		PasstSkillLevel		= 20,
	},
----------清明节活动npc----------
	plant	= {--蘑菇
		Exp					= 0,
		Life				= {{1,100},{2,200},{3,300},{4,300}},
		LifeReplenish		= 0,   --5秒回血
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= 0,
		MinDamage			= {{1,20},{2,25},{3,30},},
		MaxDamage			= {{1,20},{2,25},{3,30},},
		PhysicsResist		= 0,
		PoisonResist		= 0,
		ColdResist			= 0,
		FireResist 			= 0,
		LightResist			= 0,

		PhysicalDamageBase	= 0,
		PoisonDamageBase	= 0,
		ColdDamageBase		= 0,
		FireDamageBase		= 0,
		LightingDamageBase	= 0,

		PhysicalMagicBase	= 0,
		PoisonMagicBase		= 0,
		ColdMagicBase		= 0,
		FireMagicBase		= 0,
		LightingMagicBase	= 0,

		AuraSkillId			= GetSeriesData({1606,1606,1607,1608,1609,1610}),
		AuraSkillLevel		= GetSLData({		{{1,2},{2,3},{3,4}},
												{{1,2},{2,3},{3,4}},
												{{1,20},{2,26},{3,33}},
												{{1,1},{2,1},{3,1}},
												{{1,2},{2,3},{3,4}},
												{{1,3},{2,5},{3,8}}	}),
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
	corpse	= {--僵尸
		Exp					= 0,
		Life				= {{1,200},{2,500},{3,900},{4,7000}},
		LifeReplenish		= 0,   --5秒回血
		AR					= {{1,30},{10,70},{100,700},},
		Defense				= 0,
		MinDamage			= {{1,5},{2,8},{3,25},{4,100},},
		MaxDamage			= {{1,5},{2,8},{3,25},{4,100},},
		PhysicsResist		= 0,
		PoisonResist		= 0,
		ColdResist			= 0,
		FireResist 			= 0,
		LightResist			= 0,

		PhysicalDamageBase	= 0,
		PoisonDamageBase	= 0,
		ColdDamageBase		= 0,
		FireDamageBase		= 0,
		LightingDamageBase	= 0,

		PhysicalMagicBase	= 0,
		PoisonMagicBase		= 0,
		ColdMagicBase		= 0,
		FireMagicBase		= 0,
		LightingMagicBase	= 0,

		AuraSkillId			= {{1,0},{2,374},{3,375},{4,376},{5,376}},
		AuraSkillLevel		= {{1,0},{2,1},{3,1}},
		PasstSkillId		= 0,
		PasstSkillLevel		= 0,
	},
};
--剑贼
Npc.tbPropBase.intensity0_sword	= Lib:CopyTB1(Npc.tbPropBase.wanted);
Npc.tbPropBase.intensity0_sword.Exp = 0;
Npc.tbPropBase.intensity0_sword.LifeReplenish		= GetData(Npc.tbDataTemplet.wanted_LifeReplenish);
Npc.tbPropBase.intensity0_sword.PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity5, 1, 1.6);
Npc.tbPropBase.intensity0_sword.PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity5, 2, 1.6);
Npc.tbPropBase.intensity0_sword.ColdDamageBase		= GetAtack(Npc.tbDamage.intensity5, 3, 1.6);
Npc.tbPropBase.intensity0_sword.FireDamageBase		= GetAtack(Npc.tbDamage.intensity5, 4, 1.6);
Npc.tbPropBase.intensity0_sword.LightingDamageBase	= GetAtack(Npc.tbDamage.intensity5, 5, 1.6);
Npc.tbPropBase.intensity0_sword.PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity5, 1, 1.6);
Npc.tbPropBase.intensity0_sword.PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity5, 2, 1.6);
Npc.tbPropBase.intensity0_sword.ColdMagicBase		= GetAtack(Npc.tbDamage.intensity5, 3, 1.6);
Npc.tbPropBase.intensity0_sword.FireMagicBase		= GetAtack(Npc.tbDamage.intensity5, 4, 1.6);
Npc.tbPropBase.intensity0_sword.LightingMagicBase	= GetAtack(Npc.tbDamage.intensity5, 5, 1.6);
Npc.tbPropBase.intensity0_sword.AuraSkillId			= 1007;
Npc.tbPropBase.intensity0_sword.AuraSkillLevel		= 1;
Npc.tbPropBase.intensity0_sword.PasstSkillId		= 973;
Npc.tbPropBase.intensity0_sword.PasstSkillLevel		= 1;
--刀贼
Npc.tbPropBase.intensity1_blade	= Lib:CopyTB1(Npc.tbPropBase.intensity0_sword);
Npc.tbPropBase.intensity1_blade.Exp = 0;
Npc.tbPropBase.intensity1_blade.LifeReplenish		= GetData(Npc.tbDataTemplet.wanted_LifeReplenish,2);
Npc.tbPropBase.intensity1_blade.AuraSkillId			= 1007;
Npc.tbPropBase.intensity1_blade.AuraSkillLevel		= 1;
Npc.tbPropBase.intensity1_blade.PasstSkillId		= 973;
Npc.tbPropBase.intensity1_blade.PasstSkillLevel		= 1;
--枪贼
Npc.tbPropBase.intensity3_lance	= Lib:CopyTB1(Npc.tbPropBase.intensity0_sword);
Npc.tbPropBase.intensity3_lance.Exp = 0;
Npc.tbPropBase.intensity3_lance.LifeReplenish		= 999999;
Npc.tbPropBase.intensity3_lance.AuraSkillId			= 0;
Npc.tbPropBase.intensity3_lance.AuraSkillLevel		= 0;
Npc.tbPropBase.intensity3_lance.PasstSkillId		= 973;
Npc.tbPropBase.intensity3_lance.PasstSkillLevel		= 1;

--白斩鸡
Npc.tbPropBase.intensity6_4111	= Lib:CopyTB1(Npc.tbPropBase.intensity6);
--宠物鸡
Npc.tbPropBase.intensity0_4112	= Lib:CopyTB1(Npc.tbPropBase.intensity0);
Npc.tbPropBase.intensity0_4112.Life			= GetData(Npc.tbDataTemplet.intensity99_Life, 4);
Npc.tbPropBase.intensity0_4112.Defense		= {{1,100},{10,100},{11,200},{100,4000},};

--逍遥谷
--强度3的怪,2.7倍攻击
Npc.tbPropBase.xoyo3 = Lib:CopyTB1(Npc.tbPropBase.intensity3);
Npc.tbPropBase.xoyo3.PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 2.7);
Npc.tbPropBase.xoyo3.PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 2.7);
Npc.tbPropBase.xoyo3.ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 2.7);
Npc.tbPropBase.xoyo3.FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 2.7);
Npc.tbPropBase.xoyo3.LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 2.7);
Npc.tbPropBase.xoyo3.PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 2.7);
Npc.tbPropBase.xoyo3.PoisonMagicBase	= GetAtack(Npc.tbDamage.intensity1, 2, 2.7);
Npc.tbPropBase.xoyo3.ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 2.7);
Npc.tbPropBase.xoyo3.FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 2.7);
Npc.tbPropBase.xoyo3.LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 2.7);
--强度3的怪,2.7倍攻击,死亡爆伤害
Npc.tbPropBase.xoyo3_deadatk		= Lib:CopyTB1(Npc.tbPropBase.xoyo3);
Npc.tbPropBase.xoyo3_deadatk.PasstSkillId		= 272;
Npc.tbPropBase.xoyo3_deadatk.PasstSkillLevel	= 10;
--强度3的怪,2.7倍攻击,全屏回血光环
Npc.tbPropBase.xoyo3_auracure		= Lib:CopyTB1(Npc.tbPropBase.xoyo3);
Npc.tbPropBase.xoyo3_auracure.AuraSkillId		= 1018;
Npc.tbPropBase.xoyo3_auracure.AuraSkillLevel	= 2;
--强度3的怪,2.7倍攻击,无形蛊光环
Npc.tbPropBase.xoyo3_poison		= Lib:CopyTB1(Npc.tbPropBase.xoyo3);
Npc.tbPropBase.xoyo3_poison.AuraSkillId			= 1092;
Npc.tbPropBase.xoyo3_poison.AuraSkillLevel		= 10;
--忽略外功系攻击的intensity3_xoyo
Npc.tbPropBase.xoyo3_ignore1 = Lib:CopyTB1(Npc.tbPropBase.xoyo3);
Npc.tbPropBase.xoyo3_ignore1.PasstSkillId		= 1099;
Npc.tbPropBase.xoyo3_ignore1.PasstSkillLevel	= 20;
--忽略内功系攻击的intensity3
Npc.tbPropBase.xoyo3_ignore2 = Lib:CopyTB1(Npc.tbPropBase.xoyo3);
Npc.tbPropBase.xoyo3_ignore2.PasstSkillId		= 1100;
Npc.tbPropBase.xoyo3_ignore2.PasstSkillLevel	= 20;
--免疫五行状态的intensity3
Npc.tbPropBase.xoyo3_ignore3 = Lib:CopyTB1(Npc.tbPropBase.xoyo3);
Npc.tbPropBase.xoyo3_ignore3.AuraSkillId		= 594;
Npc.tbPropBase.xoyo3_ignore3.AuraSkillLevel		= 1;
--强度3的怪,高血量
Npc.tbPropBase.xoyo3_hp200		= Lib:CopyTB1(Npc.tbPropBase.xoyo3);
Npc.tbPropBase.xoyo3_hp200.Life = GetData(Npc.tbDataTemplet.intensity3_Life, 2);


--强度4的怪,2.7倍攻击
Npc.tbPropBase.xoyo4 = Lib:CopyTB1(Npc.tbPropBase.intensity4);
Npc.tbPropBase.xoyo4.PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 2.7);
Npc.tbPropBase.xoyo4.PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 2.7);
Npc.tbPropBase.xoyo4.ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 2.7);
Npc.tbPropBase.xoyo4.FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 2.7);
Npc.tbPropBase.xoyo4.LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 2.7);
Npc.tbPropBase.xoyo4.PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 2.7);
Npc.tbPropBase.xoyo4.PoisonMagicBase	= GetAtack(Npc.tbDamage.intensity1, 2, 2.7);
Npc.tbPropBase.xoyo4.ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 2.7);
Npc.tbPropBase.xoyo4.FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 2.7);
Npc.tbPropBase.xoyo4.LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 2.7);
--带无形蛊光环强度4的怪,2.7倍攻击
Npc.tbPropBase.xoyo4_poison = Lib:CopyTB1(Npc.tbPropBase.xoyo4);
Npc.tbPropBase.xoyo4_poison.AuraSkillId		= 1092;
Npc.tbPropBase.xoyo4_poison.AuraSkillLevel	= 10;
--强度4的怪,免疫五行状态
Npc.tbPropBase.xoyo4_ignore3		= Lib:CopyTB1(Npc.tbPropBase.xoyo4);
Npc.tbPropBase.xoyo4_ignore3.AuraSkillId 	= 594;
Npc.tbPropBase.xoyo4_ignore3.AuraSkillLevel = 1;

--强度5的怪,2.7倍攻击
Npc.tbPropBase.xoyo5 = Lib:CopyTB1(Npc.tbPropBase.intensity5);
Npc.tbPropBase.xoyo5.PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 2.7);
Npc.tbPropBase.xoyo5.PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 2.7);
Npc.tbPropBase.xoyo5.ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 2.7);
Npc.tbPropBase.xoyo5.FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 2.7);
Npc.tbPropBase.xoyo5.LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 2.7);
Npc.tbPropBase.xoyo5.PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 2.7);
Npc.tbPropBase.xoyo5.PoisonMagicBase	= GetAtack(Npc.tbDamage.intensity1, 2, 2.7);
Npc.tbPropBase.xoyo5.ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 2.7);
Npc.tbPropBase.xoyo5.FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 2.7);
Npc.tbPropBase.xoyo5.LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 2.7);
--强度5的怪,3.6倍攻击
Npc.tbPropBase.xoyo5_atk150 = Lib:CopyTB1(Npc.tbPropBase.intensity5);
Npc.tbPropBase.xoyo5_atk150.PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 3.6);
Npc.tbPropBase.xoyo5_atk150.PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 3.6);
Npc.tbPropBase.xoyo5_atk150.ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 3.6);
Npc.tbPropBase.xoyo5_atk150.FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 3.6);
Npc.tbPropBase.xoyo5_atk150.LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 3.6);
Npc.tbPropBase.xoyo5_atk150.PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 3.6);
Npc.tbPropBase.xoyo5_atk150.PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 3.6);
Npc.tbPropBase.xoyo5_atk150.ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 3.6);
Npc.tbPropBase.xoyo5_atk150.FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 3.6);
Npc.tbPropBase.xoyo5_atk150.LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 3.6);
--带无形蛊的intensity5_xoyo
Npc.tbPropBase.xoyo5_poison = Lib:CopyTB1(Npc.tbPropBase.xoyo5);
Npc.tbPropBase.xoyo5_poison.AuraSkillId			= 1092;
Npc.tbPropBase.xoyo5_poison.AuraSkillLevel		= 10;
--全屏回血的intensity5_xoyo
Npc.tbPropBase.xoyo5_auracure = Lib:CopyTB1(Npc.tbPropBase.xoyo5);
Npc.tbPropBase.xoyo5_auracure.AuraSkillId		= 1018;
Npc.tbPropBase.xoyo5_auracure.AuraSkillLevel	= 2;
--忽略外功系攻击的intensity5_xoyo
Npc.tbPropBase.xoyo5_ignore1 = Lib:CopyTB1(Npc.tbPropBase.xoyo5);
Npc.tbPropBase.xoyo5_ignore1.PasstSkillId		= 1099;
Npc.tbPropBase.xoyo5_ignore1.PasstSkillLevel	= 20;
--忽略内功系攻击的intensity5_xoyo
Npc.tbPropBase.xoyo5_ignore2 = Lib:CopyTB1(Npc.tbPropBase.xoyo5);
Npc.tbPropBase.xoyo5_ignore2.PasstSkillId		= 1100;
Npc.tbPropBase.xoyo5_ignore2.PasstSkillLevel	= 20;
--强度5的怪,1.5倍血
Npc.tbPropBase.xoyo5_hp150 = Lib:CopyTB1(Npc.tbPropBase.xoyo5);
Npc.tbPropBase.xoyo5_hp150.Life = GetData(Npc.tbDataTemplet.intensity5_Life, 1.5);
--强度5的怪,免疫五行状态
Npc.tbPropBase.xoyo5_ignore3 = Lib:CopyTB1(Npc.tbPropBase.xoyo5);
Npc.tbPropBase.xoyo5_ignore3.AuraSkillId		= 594;
Npc.tbPropBase.xoyo5_ignore3.AuraSkillLevel		= 1;

--强度6的怪,2倍攻击
Npc.tbPropBase.xoyo6 = Lib:CopyTB1(Npc.tbPropBase.intensity6);
Npc.tbPropBase.xoyo6.PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity2, 1, 2);
Npc.tbPropBase.xoyo6.PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity2, 2, 2);
Npc.tbPropBase.xoyo6.ColdDamageBase		= GetAtack(Npc.tbDamage.intensity2, 3, 2);
Npc.tbPropBase.xoyo6.FireDamageBase		= GetAtack(Npc.tbDamage.intensity2, 4, 2);
Npc.tbPropBase.xoyo6.LightingDamageBase	= GetAtack(Npc.tbDamage.intensity2, 5, 2);
Npc.tbPropBase.xoyo6.PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity2, 1, 2);
Npc.tbPropBase.xoyo6.PoisonMagicBase	= GetAtack(Npc.tbDamage.intensity2, 2, 2);
Npc.tbPropBase.xoyo6.ColdMagicBase		= GetAtack(Npc.tbDamage.intensity2, 3, 2);
Npc.tbPropBase.xoyo6.FireMagicBase		= GetAtack(Npc.tbDamage.intensity2, 4, 2);
Npc.tbPropBase.xoyo6.LightingMagicBase	= GetAtack(Npc.tbDamage.intensity2, 5, 2);
--强度6的怪,2倍攻击
Npc.tbPropBase.xoyo6_ignore3 = Lib:CopyTB1(Npc.tbPropBase.xoyo6);
Npc.tbPropBase.xoyo6_ignore3.AuraSkillId		= 594;
Npc.tbPropBase.xoyo6_ignore3.AuraSkillLevel		= 1;

--强度7的怪,2倍攻击
Npc.tbPropBase.xoyo7 = Lib:CopyTB1(Npc.tbPropBase.intensity7);
Npc.tbPropBase.xoyo7.Life = GetData(Npc.tbDataTemplet.intensity7_Life, 4);
Npc.tbPropBase.xoyo7.PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity2, 1, 5);
Npc.tbPropBase.xoyo7.PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity2, 2, 5);
Npc.tbPropBase.xoyo7.ColdDamageBase		= GetAtack(Npc.tbDamage.intensity2, 3, 5);
Npc.tbPropBase.xoyo7.FireDamageBase		= GetAtack(Npc.tbDamage.intensity2, 4, 5);
Npc.tbPropBase.xoyo7.LightingDamageBase	= GetAtack(Npc.tbDamage.intensity2, 5, 5);
Npc.tbPropBase.xoyo7.PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity2, 1, 5);
Npc.tbPropBase.xoyo7.PoisonMagicBase	= GetAtack(Npc.tbDamage.intensity2, 2, 5);
Npc.tbPropBase.xoyo7.ColdMagicBase		= GetAtack(Npc.tbDamage.intensity2, 3, 5);
Npc.tbPropBase.xoyo7.FireMagicBase		= GetAtack(Npc.tbDamage.intensity2, 4, 5);
Npc.tbPropBase.xoyo7.LightingMagicBase	= GetAtack(Npc.tbDamage.intensity2, 5, 5);
Npc.tbPropBase.xoyo7.AuraSkillId		= 594;
Npc.tbPropBase.xoyo7.AuraSkillLevel		= 1;
--强度8的怪,2倍攻击
Npc.tbPropBase.xoyo8 = Lib:CopyTB1(Npc.tbPropBase.intensity8);
Npc.tbPropBase.xoyo8.PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity2, 1, 2);
Npc.tbPropBase.xoyo8.PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity2, 2, 2);
Npc.tbPropBase.xoyo8.ColdDamageBase		= GetAtack(Npc.tbDamage.intensity2, 3, 2);
Npc.tbPropBase.xoyo8.FireDamageBase		= GetAtack(Npc.tbDamage.intensity2, 4, 2);
Npc.tbPropBase.xoyo8.LightingDamageBase	= GetAtack(Npc.tbDamage.intensity2, 5, 2);
Npc.tbPropBase.xoyo8.PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity2, 1, 2);
Npc.tbPropBase.xoyo8.PoisonMagicBase	= GetAtack(Npc.tbDamage.intensity2, 2, 2);
Npc.tbPropBase.xoyo8.ColdMagicBase		= GetAtack(Npc.tbDamage.intensity2, 3, 2);
Npc.tbPropBase.xoyo8.FireMagicBase		= GetAtack(Npc.tbDamage.intensity2, 4, 2);
Npc.tbPropBase.xoyo8.LightingMagicBase	= GetAtack(Npc.tbDamage.intensity2, 5, 2);
--强度8的怪,2.2倍攻击
Npc.tbPropBase.xoyo8_atk110 = Lib:CopyTB1(Npc.tbPropBase.intensity8);
Npc.tbPropBase.xoyo8_atk110.PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity2, 1, 2.2);
Npc.tbPropBase.xoyo8_atk110.PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity2, 2, 2.2);
Npc.tbPropBase.xoyo8_atk110.ColdDamageBase		= GetAtack(Npc.tbDamage.intensity2, 3, 2.2);
Npc.tbPropBase.xoyo8_atk110.FireDamageBase		= GetAtack(Npc.tbDamage.intensity2, 4, 2.2);
Npc.tbPropBase.xoyo8_atk110.LightingDamageBase	= GetAtack(Npc.tbDamage.intensity2, 5, 2.2);
Npc.tbPropBase.xoyo8_atk110.PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity2, 1, 2.2);
Npc.tbPropBase.xoyo8_atk110.PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity2, 2, 2.2);
Npc.tbPropBase.xoyo8_atk110.ColdMagicBase		= GetAtack(Npc.tbDamage.intensity2, 3, 2.2);
Npc.tbPropBase.xoyo8_atk110.FireMagicBase		= GetAtack(Npc.tbDamage.intensity2, 4, 2.2);
Npc.tbPropBase.xoyo8_atk110.LightingMagicBase	= GetAtack(Npc.tbDamage.intensity2, 5, 2.2);
--强度8的怪,2倍血,2.5倍攻击
Npc.tbPropBase.xoyo8_hp200_atk125 = Lib:CopyTB1(Npc.tbPropBase.intensity8);
Npc.tbPropBase.xoyo8_hp200_atk125.Life = GetData(Npc.tbDataTemplet.intensity8_Life, 2);
Npc.tbPropBase.xoyo8_hp200_atk125.PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity2, 1, 2.5);
Npc.tbPropBase.xoyo8_hp200_atk125.PoisonDamageBase		= GetAtack(Npc.tbDamage.intensity2, 2, 2.5);
Npc.tbPropBase.xoyo8_hp200_atk125.ColdDamageBase		= GetAtack(Npc.tbDamage.intensity2, 3, 2.5);
Npc.tbPropBase.xoyo8_hp200_atk125.FireDamageBase		= GetAtack(Npc.tbDamage.intensity2, 4, 2.5);
Npc.tbPropBase.xoyo8_hp200_atk125.LightingDamageBase	= GetAtack(Npc.tbDamage.intensity2, 5, 2.5);
Npc.tbPropBase.xoyo8_hp200_atk125.PhysicalMagicBase		= GetAtack(Npc.tbDamage.intensity2, 1, 2.5);
Npc.tbPropBase.xoyo8_hp200_atk125.PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity2, 2, 2.5);
Npc.tbPropBase.xoyo8_hp200_atk125.ColdMagicBase			= GetAtack(Npc.tbDamage.intensity2, 3, 2.5);
Npc.tbPropBase.xoyo8_hp200_atk125.FireMagicBase			= GetAtack(Npc.tbDamage.intensity2, 4, 2.5);
Npc.tbPropBase.xoyo8_hp200_atk125.LightingMagicBase		= GetAtack(Npc.tbDamage.intensity2, 5, 2.5);
--强度8的怪,4倍血,3倍攻击
Npc.tbPropBase.xoyo8_hp400_atk300 = Lib:CopyTB1(Npc.tbPropBase.intensity8);
Npc.tbPropBase.xoyo8_hp400_atk300.Life = GetData(Npc.tbDataTemplet.intensity8_Life, 4);
Npc.tbPropBase.xoyo8_hp400_atk300.PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity2, 1, 3);
Npc.tbPropBase.xoyo8_hp400_atk300.PoisonDamageBase		= GetAtack(Npc.tbDamage.intensity2, 2, 3);
Npc.tbPropBase.xoyo8_hp400_atk300.ColdDamageBase		= GetAtack(Npc.tbDamage.intensity2, 3, 3);
Npc.tbPropBase.xoyo8_hp400_atk300.FireDamageBase		= GetAtack(Npc.tbDamage.intensity2, 4, 3);
Npc.tbPropBase.xoyo8_hp400_atk300.LightingDamageBase	= GetAtack(Npc.tbDamage.intensity2, 5, 3);
Npc.tbPropBase.xoyo8_hp400_atk300.PhysicalMagicBase		= GetAtack(Npc.tbDamage.intensity2, 1, 3);
Npc.tbPropBase.xoyo8_hp400_atk300.PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity2, 2, 3);
Npc.tbPropBase.xoyo8_hp400_atk300.ColdMagicBase			= GetAtack(Npc.tbDamage.intensity2, 3, 3);
Npc.tbPropBase.xoyo8_hp400_atk300.FireMagicBase			= GetAtack(Npc.tbDamage.intensity2, 4, 3);
Npc.tbPropBase.xoyo8_hp400_atk300.LightingMagicBase		= GetAtack(Npc.tbDamage.intensity2, 5, 3);
Npc.tbPropBase.xoyo8_hp400_atk300.AuraSkillId = 594;
Npc.tbPropBase.xoyo8_hp400_atk300.AuraSkillLevel = 1;
--强度8的怪,3.6倍血,3倍攻击,免疫负面状态光环
Npc.tbPropBase.xoyo8_hp360_atk300_immunity = Lib:CopyTB1(Npc.tbPropBase.xoyo8_hp400_atk300);
Npc.tbPropBase.xoyo8_hp360_atk300_immunity.Life = GetData(Npc.tbDataTemplet.intensity8_Life, 3.6);
Npc.tbPropBase.xoyo8_hp360_atk300_immunity.AuraSkillId = 594;
Npc.tbPropBase.xoyo8_hp360_atk300_immunity.AuraSkillLevel = 1;

--极弱护送怪,血量为同等级练级怪的3倍
Npc.tbPropBase.xoyofellow = Lib:CopyTB1(Npc.tbPropBase.intensity99);
Npc.tbPropBase.xoyofellow.Life = GetData(Npc.tbDataTemplet.intensity99_Life, 3);

--护送怪,强度2的1.5倍血
Npc.tbPropBase.xoyofellow2 = Lib:CopyTB1(Npc.tbPropBase.intensity2);
Npc.tbPropBase.xoyofellow2.Life = GetData(Npc.tbDataTemplet.intensity2_Life, 1.5);

--护送怪,极强
Npc.tbPropBase.xoyofellow3 = Lib:CopyTB1(Npc.tbPropBase.intensity10);
Npc.tbPropBase.xoyofellow3.LifeReplenish = 200000;
Npc.tbPropBase.xoyofellow3.PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3, 1, 10);
Npc.tbPropBase.xoyofellow3.PoisonDamageBase		= GetAtack(Npc.tbDamage.fellow3, 2, 10);
Npc.tbPropBase.xoyofellow3.ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3, 3, 10);
Npc.tbPropBase.xoyofellow3.FireDamageBase		= GetAtack(Npc.tbDamage.fellow3, 4, 10);
Npc.tbPropBase.xoyofellow3.LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3, 5, 10);
Npc.tbPropBase.xoyofellow3.PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3, 1, 10);
Npc.tbPropBase.xoyofellow3.PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3, 2, 10);
Npc.tbPropBase.xoyofellow3.ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3, 3, 10);
Npc.tbPropBase.xoyofellow3.FireMagicBase		= GetAtack(Npc.tbDamage.fellow3, 4, 10);
Npc.tbPropBase.xoyofellow3.LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3, 5, 10);
--护送怪,极强2
Npc.tbPropBase.xoyofellow3_2 = Lib:CopyTB1(Npc.tbPropBase.xoyofellow3);
Npc.tbPropBase.xoyofellow3_2.AuraSkillId		= 594;
Npc.tbPropBase.xoyofellow3_2.AuraSkillLevel		= 1;

--萨达姆1
Npc.tbPropBase.xoyo_saddam1 = Lib:CopyTB1(Npc.tbPropBase.intensity5);
Npc.tbPropBase.xoyo_saddam1.Life = GetData(Npc.tbDataTemplet.intensity5_Life, 3);
Npc.tbPropBase.xoyo_saddam1.PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 6);
Npc.tbPropBase.xoyo_saddam1.PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 6);
Npc.tbPropBase.xoyo_saddam1.ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 6);
Npc.tbPropBase.xoyo_saddam1.FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 6);
Npc.tbPropBase.xoyo_saddam1.LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 6);
Npc.tbPropBase.xoyo_saddam1.PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 6);
Npc.tbPropBase.xoyo_saddam1.PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 6);
Npc.tbPropBase.xoyo_saddam1.ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 6);
Npc.tbPropBase.xoyo_saddam1.FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 6);
Npc.tbPropBase.xoyo_saddam1.LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 6);
--萨达姆2
Npc.tbPropBase.xoyo_saddam2 = Lib:CopyTB1(Npc.tbPropBase.intensity5);
Npc.tbPropBase.xoyo_saddam2.Life = GetData(Npc.tbDataTemplet.intensity5_Life, 1);
Npc.tbPropBase.xoyo_saddam2.PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity1, 1, 2);
Npc.tbPropBase.xoyo_saddam2.PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity1, 2, 2);
Npc.tbPropBase.xoyo_saddam2.ColdDamageBase		= GetAtack(Npc.tbDamage.intensity1, 3, 2);
Npc.tbPropBase.xoyo_saddam2.FireDamageBase		= GetAtack(Npc.tbDamage.intensity1, 4, 2);
Npc.tbPropBase.xoyo_saddam2.LightingDamageBase	= GetAtack(Npc.tbDamage.intensity1, 5, 2);
Npc.tbPropBase.xoyo_saddam2.PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity1, 1, 2);
Npc.tbPropBase.xoyo_saddam2.PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity1, 2, 2);
Npc.tbPropBase.xoyo_saddam2.ColdMagicBase		= GetAtack(Npc.tbDamage.intensity1, 3, 2);
Npc.tbPropBase.xoyo_saddam2.FireMagicBase		= GetAtack(Npc.tbDamage.intensity1, 4, 2);
Npc.tbPropBase.xoyo_saddam2.LightingMagicBase	= GetAtack(Npc.tbDamage.intensity1, 5, 2);
--强度8的怪,6倍攻击
Npc.tbPropBase.xoyo8_atk666 = Lib:CopyTB1(Npc.tbPropBase.intensity8);
Npc.tbPropBase.xoyo8_atk666.PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity2, 1, 6);
Npc.tbPropBase.xoyo8_atk666.PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity2, 2, 6);
Npc.tbPropBase.xoyo8_atk666.ColdDamageBase		= GetAtack(Npc.tbDamage.intensity2, 3, 6);
Npc.tbPropBase.xoyo8_atk666.FireDamageBase		= GetAtack(Npc.tbDamage.intensity2, 4, 6);
Npc.tbPropBase.xoyo8_atk666.LightingDamageBase	= GetAtack(Npc.tbDamage.intensity2, 5, 6);
Npc.tbPropBase.xoyo8_atk666.PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity2, 1, 6);
Npc.tbPropBase.xoyo8_atk666.PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity2, 2, 6);
Npc.tbPropBase.xoyo8_atk666.ColdMagicBase		= GetAtack(Npc.tbDamage.intensity2, 3, 6);
Npc.tbPropBase.xoyo8_atk666.FireMagicBase		= GetAtack(Npc.tbDamage.intensity2, 4, 6);
Npc.tbPropBase.xoyo8_atk666.LightingMagicBase	= GetAtack(Npc.tbDamage.intensity2, 5, 6);
Npc.tbPropBase.xoyo8_atk666.AuraSkillId			= 594;
Npc.tbPropBase.xoyo8_atk666.AuraSkillLevel		= 1;
--强度8的怪,4倍攻击
Npc.tbPropBase.xoyo8_atk66 = Lib:CopyTB1(Npc.tbPropBase.intensity8);
Npc.tbPropBase.xoyo8_atk66.PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity2, 1, 4);
Npc.tbPropBase.xoyo8_atk66.PoisonDamageBase		= GetAtack(Npc.tbDamage.intensity2, 2, 4);
Npc.tbPropBase.xoyo8_atk66.ColdDamageBase		= GetAtack(Npc.tbDamage.intensity2, 3, 4);
Npc.tbPropBase.xoyo8_atk66.FireDamageBase		= GetAtack(Npc.tbDamage.intensity2, 4, 4);
Npc.tbPropBase.xoyo8_atk66.LightingDamageBase	= GetAtack(Npc.tbDamage.intensity2, 5, 4);
Npc.tbPropBase.xoyo8_atk66.PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity2, 1, 4);
Npc.tbPropBase.xoyo8_atk66.PoisonMagicBase		= GetAtack(Npc.tbDamage.intensity2, 2, 4);
Npc.tbPropBase.xoyo8_atk66.ColdMagicBase		= GetAtack(Npc.tbDamage.intensity2, 3, 4);
Npc.tbPropBase.xoyo8_atk66.FireMagicBase		= GetAtack(Npc.tbDamage.intensity2, 4, 4);
Npc.tbPropBase.xoyo8_atk66.LightingMagicBase	= GetAtack(Npc.tbDamage.intensity2, 5, 4);
Npc.tbPropBase.xoyo8_atk66.AuraSkillId			= 594;
Npc.tbPropBase.xoyo8_atk66.AuraSkillLevel		= 1;

--逍遥谷拔萝卜变身
Npc.tbPropBase.pluckupradish = Lib:CopyTB1(Npc.tbPropBase.muren);
Npc.tbPropBase.pluckupradish.Life = 15;
--2点血的npc
Npc.tbPropBase.xoyo2hpnnpc = Lib:CopyTB1(Npc.tbPropBase.intensity0);
Npc.tbPropBase.xoyo2hpnnpc.Life = 2;
--财宝兔
Npc.tbPropBase.rabbit1 = Lib:CopyTB1(Npc.tbPropBase.muren);
Npc.tbPropBase.rabbit1.Life = 50;
Npc.tbPropBase.rabbit1.AuraSkillId		= 594;
Npc.tbPropBase.rabbit1.AuraSkillLevel	= 1;
Npc.tbPropBase.rabbit1.PasstSkillId		= 1111;
Npc.tbPropBase.rabbit1.PasstSkillLevel	= 10;

--小财宝兔
Npc.tbPropBase.rabbit2 = Lib:CopyTB1(Npc.tbPropBase.muren);
Npc.tbPropBase.rabbit2.Life = 15;
Npc.tbPropBase.rabbit2.AuraSkillId		= 0;
Npc.tbPropBase.rabbit2.AuraSkillLevel	= 0;
Npc.tbPropBase.rabbit2.PasstSkillId		= 1111;
Npc.tbPropBase.rabbit2.PasstSkillLevel	= 10;

--玉兔
Npc.tbPropBase.moonrabbit = Lib:CopyTB1(Npc.tbPropBase.intensity0);
Npc.tbPropBase.moonrabbit.AuraSkillId		= 1166;
Npc.tbPropBase.moonrabbit.AuraSkillLevel	= 1;

--高经验练级怪
Npc.tbPropBase.intensity99ex = Lib:CopyTB1(Npc.tbPropBase.intensity99);
Npc.tbPropBase.intensity99ex.Exp	= GetData(Npc.tbDataTemplet.intensity99, 2);

-------------100级藏宝图----------
Npc.tbPropBase.cangbaotuboss2766 = Lib:CopyTB1(Npc.tbPropBase.cangbaotuboss2760);
Npc.tbPropBase.cangbaotuboss2766.Exp  = GetData(Npc.tbDataTemplet.cangbaotuboss1_Exp);
Npc.tbPropBase.cangbaotuboss2766.Life = 150000000*Npc.IVER_CangBaoTuNpcStrong;

Npc.tbPropBase.cangbaotuboss2767 = Lib:CopyTB1(Npc.tbPropBase.cangbaotuboss2766);
Npc.tbPropBase.cangbaotuboss2767.Exp  = GetData(Npc.tbDataTemplet.cangbaotuboss1_Exp);
Npc.tbPropBase.cangbaotuboss2767.Life = 150000000*Npc.IVER_CangBaoTuNpcStrong;
Npc.tbPropBase.cangbaotuboss2767.AuraSkillId		= 1007;
Npc.tbPropBase.cangbaotuboss2767.AuraSkillLevel		= 1;

Npc.tbPropBase.cangbaotuboss2768 = Lib:CopyTB1(Npc.tbPropBase.cangbaotuboss2760);
Npc.tbPropBase.cangbaotuboss2768.Exp  = GetData(Npc.tbDataTemplet.cangbaotuboss1_Exp);
Npc.tbPropBase.cangbaotuboss2768.Life = 150000000*Npc.IVER_CangBaoTuNpcStrong;

Npc.tbPropBase.cangbaotuboss2769 = Lib:CopyTB1(Npc.tbPropBase.cangbaotuboss2768);
Npc.tbPropBase.cangbaotuboss2769.Exp  = GetData(Npc.tbDataTemplet.cangbaotuboss1_Exp);
Npc.tbPropBase.cangbaotuboss2769.Life = 150000000*Npc.IVER_CangBaoTuNpcStrong;
Npc.tbPropBase.cangbaotuboss2769.PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.2*Npc.IVER_CangBaoTuNpcStrong);
Npc.tbPropBase.cangbaotuboss2769.PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3, 2, 0.2*Npc.IVER_CangBaoTuNpcStrong);
Npc.tbPropBase.cangbaotuboss2769.ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.2*Npc.IVER_CangBaoTuNpcStrong);
Npc.tbPropBase.cangbaotuboss2769.FireDamageBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.2*Npc.IVER_CangBaoTuNpcStrong);
Npc.tbPropBase.cangbaotuboss2769.LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.2*Npc.IVER_CangBaoTuNpcStrong);
Npc.tbPropBase.cangbaotuboss2769.PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3, 1, 0.2*Npc.IVER_CangBaoTuNpcStrong);
Npc.tbPropBase.cangbaotuboss2769.PoisonMagicBase	= GetAtack(Npc.tbDamage.fellow3, 2, 0.2*Npc.IVER_CangBaoTuNpcStrong);
Npc.tbPropBase.cangbaotuboss2769.ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3, 3, 0.2*Npc.IVER_CangBaoTuNpcStrong);
Npc.tbPropBase.cangbaotuboss2769.FireMagicBase		= GetAtack(Npc.tbDamage.fellow3, 4, 0.2*Npc.IVER_CangBaoTuNpcStrong);
Npc.tbPropBase.cangbaotuboss2769.LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3, 5, 0.2*Npc.IVER_CangBaoTuNpcStrong);
Npc.tbPropBase.cangbaotuboss2769.AuraSkillId		= 1133;
Npc.tbPropBase.cangbaotuboss2769.AuraSkillLevel		= 20;

Npc.tbPropBase.cangbaotuboss2772 = Lib:CopyTB1(Npc.tbPropBase.cangbaotuboss2768);
Npc.tbPropBase.cangbaotuboss2772.Exp  = GetData(Npc.tbDataTemplet.cangbaotuboss1_Exp);
Npc.tbPropBase.cangbaotuboss2772.Life = 150000000*Npc.IVER_CangBaoTuNpcStrong;

Npc.tbPropBase.cangbaotuboss2773 = Lib:CopyTB1(Npc.tbPropBase.cangbaotuboss2768);
Npc.tbPropBase.cangbaotuboss2773.Exp  = GetData(Npc.tbDataTemplet.cangbaotuboss1_Exp);
Npc.tbPropBase.cangbaotuboss2773.Life = 150000000*Npc.IVER_CangBaoTuNpcStrong;

Npc.tbPropBase.worldboss1_call_jin = Lib:CopyTB1(Npc.tbPropBase.worldboss1_call);
Npc.tbPropBase.worldboss1_call_jin.Life = {{1,160*0.9*0.7*0.33},{55,7125000*0.9*0.7*0.33},{100,21930000*0.9*0.7*0.33},};

Npc.tbPropBase.battlefieldaura = Lib:CopyTB1(Npc.tbPropBase.intensity0);
Npc.tbPropBase.battlefieldaura.AuraSkillId = 1154;
Npc.tbPropBase.battlefieldaura.AuraSkillLevel = 1;

Npc.tbPropBase.tianlaoboss = Lib:CopyTB1(Npc.tbPropBase.intensity10);
Npc.tbPropBase.tianlaoboss.LifeReplenish = 9999999;

---100级任务
Npc.tbPropBase.task6_rebound = Lib:CopyTB1(Npc.tbPropBase.intensity6);
Npc.tbPropBase.task6_rebound.AuraSkillId = 1158;
Npc.tbPropBase.task6_rebound.AuraSkillLevel = 1;--1级10%反弹

Npc.tbPropBase.task6_poison = Lib:CopyTB1(Npc.tbPropBase.intensity6);
Npc.tbPropBase.task6_poison.AuraSkillId = 1159;--npc无形蛊,无特效
Npc.tbPropBase.task6_poison.AuraSkillLevel = 1;

Npc.tbPropBase.task8_poison = Lib:CopyTB1(Npc.tbPropBase.intensity8);
Npc.tbPropBase.task8_poison.PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3, 1);
Npc.tbPropBase.task8_poison.PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3, 2);
Npc.tbPropBase.task8_poison.ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3, 3);
Npc.tbPropBase.task8_poison.FireDamageBase		= GetAtack(Npc.tbDamage.fellow3, 4);
Npc.tbPropBase.task8_poison.LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3, 5);
Npc.tbPropBase.task8_poison.PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3, 1);
Npc.tbPropBase.task8_poison.PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3, 2);
Npc.tbPropBase.task8_poison.ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3, 3);
Npc.tbPropBase.task8_poison.FireMagicBase		= GetAtack(Npc.tbDamage.fellow3, 4);
Npc.tbPropBase.task8_poison.LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3, 5);
Npc.tbPropBase.task8_poison.AuraSkillId = 1159;
Npc.tbPropBase.task8_poison.AuraSkillLevel = 1;

Npc.tbPropBase.task2_hide = Lib:CopyTB1(Npc.tbPropBase.intensity2);
Npc.tbPropBase.task2_hide.PasstSkillId = 1157;
Npc.tbPropBase.task2_hide.PasstSkillLevel = 10;

Npc.tbPropBase.task7_cure = Lib:CopyTB1(Npc.tbPropBase.intensity7);
Npc.tbPropBase.task7_cure.AuraSkillId = 1018;
Npc.tbPropBase.task7_cure.AuraSkillLevel = 1;

Npc.tbPropBase.task7_cri = Lib:CopyTB1(Npc.tbPropBase.intensity7);
Npc.tbPropBase.task7_cri.AuraSkillId = 201;
Npc.tbPropBase.task7_cri.AuraSkillLevel = 10;

--新年活动:打雪仗变身后强度
Npc.tbPropBase.snowballchild = Lib:CopyTB1(Npc.tbPropBase.muren);
Npc.tbPropBase.snowballchild.Life = 100000;

--新年活动:打雪仗用可攻击玩家但不能被攻击的npc
Npc.tbPropBase.snowballtusha = Lib:CopyTB1(Npc.tbPropBase.muren);
Npc.tbPropBase.snowballtusha.Life = 100000;
Npc.tbPropBase.snowballtusha.PasstSkillId = 1475;
Npc.tbPropBase.snowballtusha.PasstSkillLevel = 10;

--新年活动:年兽
Npc.tbPropBase.newyearmonster = Lib:CopyTB1(Npc.tbPropBase.wanted);

-- 师徒任务
Npc.tbPropBase.shitu01 = Lib:CopyTB1(Npc.tbPropBase.intensity5);
Npc.tbPropBase.shitu01.AR = {{1,30},{10,300},{100,3000},};
Npc.tbPropBase.shitu01.Defense = {{1,10},{10,100},{100,1000},};
Npc.tbPropBase.shitu01.Life = GetData(Npc.tbDataTemplet.intensity99_Life, 2.5);

--逍遥谷LV5机关
Npc.tbPropBase.xoyo3_poison_lv5						= Lib:CopyTB1(Npc.tbPropBase.xoyo3);
Npc.tbPropBase.xoyo3_poison_lv5.AuraSkillId			= 1092;
Npc.tbPropBase.xoyo3_poison_lv5.AuraSkillLevel		= 10;
Npc.tbPropBase.xoyo3_poison_lv5.PasstSkillId		= 1111;
Npc.tbPropBase.xoyo3_poison_lv5.PasstSkillLevel		= 10;

Npc.tbPropBase.xoyo7_lv5						    = Lib:CopyTB1(Npc.tbPropBase.intensity7);
Npc.tbPropBase.xoyo7_lv5.Life 						= GetData(Npc.tbDataTemplet.intensity7_Life, 1.5);
Npc.tbPropBase.xoyo_dong							= Lib:CopyTB1(Npc.tbPropBase.xoyo8_atk110);
Npc.tbPropBase.xoyo_dong.Life 						= GetData(Npc.tbDataTemplet.intensity8_Life);
Npc.tbPropBase.xoyo_dong.AuraSkillId				= 594;
Npc.tbPropBase.xoyo_dong.AuraSkillLevel				= 1;
Npc.tbPropBase.xoyo_xi								= Lib:CopyTB1(Npc.tbPropBase.xoyo8_atk110);
Npc.tbPropBase.xoyo_xi.Life 						= GetData(Npc.tbDataTemplet.intensity8_Life);
Npc.tbPropBase.xoyo_xi.AuraSkillId					= 594;
Npc.tbPropBase.xoyo_xi.AuraSkillLevel				= 1;
Npc.tbPropBase.xoyo_nan								= Lib:CopyTB1(Npc.tbPropBase.xoyo8_atk110);
Npc.tbPropBase.xoyo_nan.Life 						= GetData(Npc.tbDataTemplet.intensity8_Life);
Npc.tbPropBase.xoyo_nan.AuraSkillId					= 594;
Npc.tbPropBase.xoyo_nan.AuraSkillLevel				= 1;
Npc.tbPropBase.xoyo_bei								= Lib:CopyTB1(Npc.tbPropBase.xoyo8_atk110);
Npc.tbPropBase.xoyo_bei.Life 						= GetData(Npc.tbDataTemplet.intensity8_Life);
Npc.tbPropBase.xoyo_bei.AuraSkillId					= 594;
Npc.tbPropBase.xoyo_bei.AuraSkillLevel				= 1;
Npc.tbPropBase.xoyo5_poison_lv5						= Lib:CopyTB1(Npc.tbPropBase.xoyo5);
Npc.tbPropBase.xoyo5_poison_lv5.AuraSkillId			= 1092;
Npc.tbPropBase.xoyo5_poison_lv5.AuraSkillLevel		= 10;
Npc.tbPropBase.xoyo5_poison_lv5.PasstSkillId		= 1111;
Npc.tbPropBase.xoyo5_poison_lv5.PasstSkillLevel		= 10;
Npc.tbPropBase.xoyo5_half							= Lib:CopyTB1(Npc.tbPropBase.xoyo5);
Npc.tbPropBase.xoyo5_half.PasstSkillId				= 1111;
Npc.tbPropBase.xoyo5_half.PasstSkillLevel			= 5;

---------------------领土争夺战-----------------------------
--反扑将领
Npc.tbPropBase.dispute_general_kickback				= Lib:CopyTB1(Npc.tbPropBase.dispute_general);
Npc.tbPropBase.dispute_general_kickback.PhysicalDamageBase	= GetAtack(Npc.tbDamage.domainatk, 1, 0.405);
Npc.tbPropBase.dispute_general_kickback.PoisonDamageBase	= GetAtack(Npc.tbDamage.domainatk, 2, 0.405);
Npc.tbPropBase.dispute_general_kickback.ColdDamageBase		= GetAtack(Npc.tbDamage.domainatk, 3, 0.405);
Npc.tbPropBase.dispute_general_kickback.FireDamageBase		= GetAtack(Npc.tbDamage.domainatk, 4, 0.405);
Npc.tbPropBase.dispute_general_kickback.LightingDamageBase	= GetAtack(Npc.tbDamage.domainatk, 5, 0.405);
Npc.tbPropBase.dispute_general_kickback.PhysicalMagicBase	= GetAtack(Npc.tbDamage.domainatk, 1, 0.405);
Npc.tbPropBase.dispute_general_kickback.PoisonMagicBase		= GetAtack(Npc.tbDamage.domainatk, 2, 0.405);
Npc.tbPropBase.dispute_general_kickback.ColdMagicBase		= GetAtack(Npc.tbDamage.domainatk, 3, 0.405);
Npc.tbPropBase.dispute_general_kickback.FireMagicBase		= GetAtack(Npc.tbDamage.domainatk, 4, 0.405);
Npc.tbPropBase.dispute_general_kickback.LightingMagicBase	= GetAtack(Npc.tbDamage.domainatk, 5, 0.405);
--反扑士兵
Npc.tbPropBase.dispute_soldier_kickback				= Lib:CopyTB1(Npc.tbPropBase.dispute_soldier);
Npc.tbPropBase.dispute_soldier_kickback.PhysicalDamageBase	= GetAtack(Npc.tbDamage.domainatk, 1, 0.25);
Npc.tbPropBase.dispute_soldier_kickback.PoisonDamageBase	= GetAtack(Npc.tbDamage.domainatk, 2, 0.25);
Npc.tbPropBase.dispute_soldier_kickback.ColdDamageBase		= GetAtack(Npc.tbDamage.domainatk, 3, 0.25);
Npc.tbPropBase.dispute_soldier_kickback.FireDamageBase		= GetAtack(Npc.tbDamage.domainatk, 4, 0.25);
Npc.tbPropBase.dispute_soldier_kickback.LightingDamageBase	= GetAtack(Npc.tbDamage.domainatk, 5, 0.25);
Npc.tbPropBase.dispute_soldier_kickback.PhysicalMagicBase	= GetAtack(Npc.tbDamage.domainatk, 1, 0.25);
Npc.tbPropBase.dispute_soldier_kickback.PoisonMagicBase		= GetAtack(Npc.tbDamage.domainatk, 2, 0.25);
Npc.tbPropBase.dispute_soldier_kickback.ColdMagicBase		= GetAtack(Npc.tbDamage.domainatk, 3, 0.25);
Npc.tbPropBase.dispute_soldier_kickback.FireMagicBase		= GetAtack(Npc.tbDamage.domainatk, 4, 0.25);
Npc.tbPropBase.dispute_soldier_kickback.LightingMagicBase	= GetAtack(Npc.tbDamage.domainatk, 5, 0.25);

--新手村元帅
Npc.tbPropBase.dispute_boss_dorp				= Lib:CopyTB1(Npc.tbPropBase.dispute_boss);
--新手村将领
Npc.tbPropBase.dispute_general_dorp				= Lib:CopyTB1(Npc.tbPropBase.dispute_general);
Npc.tbPropBase.dispute_general_dorp.PhysicalDamageBase	= GetAtack(Npc.tbDamage.domainatk, 1, 0.28);
Npc.tbPropBase.dispute_general_dorp.PoisonDamageBase	= GetAtack(Npc.tbDamage.domainatk, 2, 0.28);
Npc.tbPropBase.dispute_general_dorp.ColdDamageBase		= GetAtack(Npc.tbDamage.domainatk, 3, 0.28);
Npc.tbPropBase.dispute_general_dorp.FireDamageBase		= GetAtack(Npc.tbDamage.domainatk, 4, 0.28);
Npc.tbPropBase.dispute_general_dorp.LightingDamageBase	= GetAtack(Npc.tbDamage.domainatk, 5, 0.28);
Npc.tbPropBase.dispute_general_dorp.PhysicalMagicBase	= GetAtack(Npc.tbDamage.domainatk, 1, 0.28);
Npc.tbPropBase.dispute_general_dorp.PoisonMagicBase		= GetAtack(Npc.tbDamage.domainatk, 2, 0.28);
Npc.tbPropBase.dispute_general_dorp.ColdMagicBase		= GetAtack(Npc.tbDamage.domainatk, 3, 0.28);
Npc.tbPropBase.dispute_general_dorp.FireMagicBase		= GetAtack(Npc.tbDamage.domainatk, 4, 0.28);
Npc.tbPropBase.dispute_general_dorp.LightingMagicBase	= GetAtack(Npc.tbDamage.domainatk, 5, 0.28);
--新手村士兵
Npc.tbPropBase.dispute_soldier_dorp				= Lib:CopyTB1(Npc.tbPropBase.dispute_soldier);
Npc.tbPropBase.dispute_soldier_dorp.PhysicalDamageBase	= GetAtack(Npc.tbDamage.domainatk, 1, 0.175);
Npc.tbPropBase.dispute_soldier_dorp.PoisonDamageBase	= GetAtack(Npc.tbDamage.domainatk, 2, 0.175);
Npc.tbPropBase.dispute_soldier_dorp.ColdDamageBase		= GetAtack(Npc.tbDamage.domainatk, 3, 0.175);
Npc.tbPropBase.dispute_soldier_dorp.FireDamageBase		= GetAtack(Npc.tbDamage.domainatk, 4, 0.175);
Npc.tbPropBase.dispute_soldier_dorp.LightingDamageBase	= GetAtack(Npc.tbDamage.domainatk, 5, 0.175);
Npc.tbPropBase.dispute_soldier_dorp.PhysicalMagicBase	= GetAtack(Npc.tbDamage.domainatk, 1, 0.175);
Npc.tbPropBase.dispute_soldier_dorp.PoisonMagicBase		= GetAtack(Npc.tbDamage.domainatk, 2, 0.175);
Npc.tbPropBase.dispute_soldier_dorp.ColdMagicBase		= GetAtack(Npc.tbDamage.domainatk, 3, 0.175);
Npc.tbPropBase.dispute_soldier_dorp.FireMagicBase		= GetAtack(Npc.tbDamage.domainatk, 4, 0.175);
Npc.tbPropBase.dispute_soldier_dorp.LightingMagicBase	= GetAtack(Npc.tbDamage.domainatk, 5, 0.175);
--0级主城龙柱
Npc.tbPropBase.dispute_pillar0					= Lib:CopyTB1(Npc.tbPropBase.dispute_pillar);
--1级主城龙柱
Npc.tbPropBase.dispute_pillar1					= Lib:CopyTB1(Npc.tbPropBase.dispute_pillar);
Npc.tbPropBase.dispute_pillar1.Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 400);
--2级主城龙柱
Npc.tbPropBase.dispute_pillar2					= Lib:CopyTB1(Npc.tbPropBase.dispute_pillar);
Npc.tbPropBase.dispute_pillar2.Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 420*1.2);
--3级主城龙柱
Npc.tbPropBase.dispute_pillar3					= Lib:CopyTB1(Npc.tbPropBase.dispute_pillar);
Npc.tbPropBase.dispute_pillar3.Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 420*1.3);
Npc.tbPropBase.dispute_pillar3.LifeReplenish	= GetData(Npc.tbDataTemplet.intensity99_Life, 420*1.3*0.01*0.25);
--4级主城龙柱
Npc.tbPropBase.dispute_pillar4					= Lib:CopyTB1(Npc.tbPropBase.dispute_pillar);
Npc.tbPropBase.dispute_pillar4.Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 420*1.5);
Npc.tbPropBase.dispute_pillar4.LifeReplenish	= GetData(Npc.tbDataTemplet.intensity99_Life, 420*1.5*0.01*0.5);

--雕像
Npc.tbPropBase.effigy					= Lib:CopyTB1(Npc.tbPropBase.dispute_pillar);
Npc.tbPropBase.effigy.AuraSkillId		= {{100,0},{120,1165},{150,1164}};
Npc.tbPropBase.effigy.AuraSkillLevel	= 1;
----------秦始皇陵---------

--秦始皇陵2层小兵
Npc.tbPropBase.bmy_soldier2				= Lib:CopyTB1(Npc.tbPropBase.bmy_soldier1);
Npc.tbPropBase.bmy_soldier2.Life				= 845440;
Npc.tbPropBase.bmy_soldier2.PhysicalDamageBase	= GetAtack(Npc.tbDamage.bmy_soldier2, 1, 0.8);
Npc.tbPropBase.bmy_soldier2.PoisonDamageBase	= GetAtack(Npc.tbDamage.bmy_soldier2, 2, 0.8);
Npc.tbPropBase.bmy_soldier2.ColdDamageBase		= GetAtack(Npc.tbDamage.bmy_soldier2, 3, 0.8);
Npc.tbPropBase.bmy_soldier2.FireDamageBase		= GetAtack(Npc.tbDamage.bmy_soldier2, 4, 0.8);
Npc.tbPropBase.bmy_soldier2.LightingDamageBase	= GetAtack(Npc.tbDamage.bmy_soldier2, 5, 0.8);
Npc.tbPropBase.bmy_soldier2.PhysicalMagicBase	= GetAtack(Npc.tbDamage.bmy_soldier2, 1, 0.8);
Npc.tbPropBase.bmy_soldier2.PoisonMagicBase		= GetAtack(Npc.tbDamage.bmy_soldier2, 2, 0.8);
Npc.tbPropBase.bmy_soldier2.ColdMagicBase		= GetAtack(Npc.tbDamage.bmy_soldier2, 3, 0.8);
Npc.tbPropBase.bmy_soldier2.FireMagicBase		= GetAtack(Npc.tbDamage.bmy_soldier2, 4, 0.8);
Npc.tbPropBase.bmy_soldier2.LightingMagicBase	= GetAtack(Npc.tbDamage.bmy_soldier2, 5, 0.8);
--秦始皇陵2层头领
Npc.tbPropBase.bmy_leader2				= Lib:CopyTB1(Npc.tbPropBase.bmy_leader1);
Npc.tbPropBase.bmy_leader2.Life					= 845440;
Npc.tbPropBase.bmy_leader2.PhysicalDamageBase	= GetAtack(Npc.tbDamage.bmy_leader2, 1, 0.8);
Npc.tbPropBase.bmy_leader2.PoisonDamageBase		= GetAtack(Npc.tbDamage.bmy_leader2, 2, 0.8);
Npc.tbPropBase.bmy_leader2.ColdDamageBase		= GetAtack(Npc.tbDamage.bmy_leader2, 3, 0.8);
Npc.tbPropBase.bmy_leader2.FireDamageBase		= GetAtack(Npc.tbDamage.bmy_leader2, 4, 0.8);
Npc.tbPropBase.bmy_leader2.LightingDamageBase	= GetAtack(Npc.tbDamage.bmy_leader2, 5, 0.8);
Npc.tbPropBase.bmy_leader2.PhysicalMagicBase	= GetAtack(Npc.tbDamage.bmy_leader2, 1, 0.8);
Npc.tbPropBase.bmy_leader2.PoisonMagicBase		= GetAtack(Npc.tbDamage.bmy_leader2, 2, 0.8);
Npc.tbPropBase.bmy_leader2.ColdMagicBase		= GetAtack(Npc.tbDamage.bmy_leader2, 3, 0.8);
Npc.tbPropBase.bmy_leader2.FireMagicBase		= GetAtack(Npc.tbDamage.bmy_leader2, 4, 0.8);
Npc.tbPropBase.bmy_leader2.LightingMagicBase	= GetAtack(Npc.tbDamage.bmy_leader2, 5, 0.8);
--秦始皇陵2层精英
Npc.tbPropBase.bmy_elite2				= Lib:CopyTB1(Npc.tbPropBase.bmy_elite1);
Npc.tbPropBase.bmy_elite2.Life					= 1710362;
Npc.tbPropBase.bmy_elite2.PhysicalDamageBase	= GetAtack(Npc.tbDamage.bmy_elite2, 1, 0.8);
Npc.tbPropBase.bmy_elite2.PoisonDamageBase		= GetAtack(Npc.tbDamage.bmy_elite2, 2, 0.8);
Npc.tbPropBase.bmy_elite2.ColdDamageBase		= GetAtack(Npc.tbDamage.bmy_elite2, 3, 0.8);
Npc.tbPropBase.bmy_elite2.FireDamageBase		= GetAtack(Npc.tbDamage.bmy_elite2, 4, 0.8);
Npc.tbPropBase.bmy_elite2.LightingDamageBase	= GetAtack(Npc.tbDamage.bmy_elite2, 5, 0.8);
Npc.tbPropBase.bmy_elite2.PhysicalMagicBase		= GetAtack(Npc.tbDamage.bmy_elite2, 1, 0.8);
Npc.tbPropBase.bmy_elite2.PoisonMagicBase		= GetAtack(Npc.tbDamage.bmy_elite2, 2, 0.8);
Npc.tbPropBase.bmy_elite2.ColdMagicBase			= GetAtack(Npc.tbDamage.bmy_elite2, 3, 0.8);
Npc.tbPropBase.bmy_elite2.FireMagicBase			= GetAtack(Npc.tbDamage.bmy_elite2, 4, 0.8);
Npc.tbPropBase.bmy_elite2.LightingMagicBase		= GetAtack(Npc.tbDamage.bmy_elite2, 5, 0.8);

--秦始皇陵3层小兵
Npc.tbPropBase.bmy_soldier3				= Lib:CopyTB1(Npc.tbPropBase.bmy_soldier1);
Npc.tbPropBase.bmy_soldier3.Life				= 1439422;
Npc.tbPropBase.bmy_soldier3.PhysicalDamageBase	= GetAtack(Npc.tbDamage.bmy_soldier3, 1, 0.8);
Npc.tbPropBase.bmy_soldier3.PoisonDamageBase	= GetAtack(Npc.tbDamage.bmy_soldier3, 2, 0.8);
Npc.tbPropBase.bmy_soldier3.ColdDamageBase		= GetAtack(Npc.tbDamage.bmy_soldier3, 3, 0.8);
Npc.tbPropBase.bmy_soldier3.FireDamageBase		= GetAtack(Npc.tbDamage.bmy_soldier3, 4, 0.8);
Npc.tbPropBase.bmy_soldier3.LightingDamageBase	= GetAtack(Npc.tbDamage.bmy_soldier3, 5, 0.8);
Npc.tbPropBase.bmy_soldier3.PhysicalMagicBase	= GetAtack(Npc.tbDamage.bmy_soldier3, 1, 0.8);
Npc.tbPropBase.bmy_soldier3.PoisonMagicBase		= GetAtack(Npc.tbDamage.bmy_soldier3, 2, 0.8);
Npc.tbPropBase.bmy_soldier3.ColdMagicBase		= GetAtack(Npc.tbDamage.bmy_soldier3, 3, 0.8);
Npc.tbPropBase.bmy_soldier3.FireMagicBase		= GetAtack(Npc.tbDamage.bmy_soldier3, 4, 0.8);
Npc.tbPropBase.bmy_soldier3.LightingMagicBase	= GetAtack(Npc.tbDamage.bmy_soldier3, 5, 0.8);
--秦始皇陵3层头领
Npc.tbPropBase.bmy_leader3				= Lib:CopyTB1(Npc.tbPropBase.bmy_leader1);
Npc.tbPropBase.bmy_leader3.Life					= 1439422;
Npc.tbPropBase.bmy_leader3.PhysicalDamageBase	= GetAtack(Npc.tbDamage.bmy_leader3, 1, 0.8);
Npc.tbPropBase.bmy_leader3.PoisonDamageBase		= GetAtack(Npc.tbDamage.bmy_leader3, 2, 0.8);
Npc.tbPropBase.bmy_leader3.ColdDamageBase		= GetAtack(Npc.tbDamage.bmy_leader3, 3, 0.8);
Npc.tbPropBase.bmy_leader3.FireDamageBase		= GetAtack(Npc.tbDamage.bmy_leader3, 4, 0.8);
Npc.tbPropBase.bmy_leader3.LightingDamageBase	= GetAtack(Npc.tbDamage.bmy_leader3, 5, 0.8);
Npc.tbPropBase.bmy_leader3.PhysicalMagicBase	= GetAtack(Npc.tbDamage.bmy_leader3, 1, 0.8);
Npc.tbPropBase.bmy_leader3.PoisonMagicBase		= GetAtack(Npc.tbDamage.bmy_leader3, 2, 0.8);
Npc.tbPropBase.bmy_leader3.ColdMagicBase		= GetAtack(Npc.tbDamage.bmy_leader3, 3, 0.8);
Npc.tbPropBase.bmy_leader3.FireMagicBase		= GetAtack(Npc.tbDamage.bmy_leader3, 4, 0.8);
Npc.tbPropBase.bmy_leader3.LightingMagicBase	= GetAtack(Npc.tbDamage.bmy_leader3, 5, 0.8);
--秦始皇陵3层精英
Npc.tbPropBase.bmy_elite3				= Lib:CopyTB1(Npc.tbPropBase.bmy_elite1);
Npc.tbPropBase.bmy_elite3.Life					= 1710362;
Npc.tbPropBase.bmy_elite3.PhysicalDamageBase	= GetAtack(Npc.tbDamage.bmy_elite3, 1, 0.8);
Npc.tbPropBase.bmy_elite3.PoisonDamageBase		= GetAtack(Npc.tbDamage.bmy_elite3, 2, 0.8);
Npc.tbPropBase.bmy_elite3.ColdDamageBase		= GetAtack(Npc.tbDamage.bmy_elite3, 3, 0.8);
Npc.tbPropBase.bmy_elite3.FireDamageBase		= GetAtack(Npc.tbDamage.bmy_elite3, 4, 0.8);
Npc.tbPropBase.bmy_elite3.LightingDamageBase	= GetAtack(Npc.tbDamage.bmy_elite3, 5, 0.8);
Npc.tbPropBase.bmy_elite3.PhysicalMagicBase		= GetAtack(Npc.tbDamage.bmy_elite3, 1, 0.8);
Npc.tbPropBase.bmy_elite3.PoisonMagicBase		= GetAtack(Npc.tbDamage.bmy_elite3, 2, 0.8);
Npc.tbPropBase.bmy_elite3.ColdMagicBase			= GetAtack(Npc.tbDamage.bmy_elite3, 3, 0.8);
Npc.tbPropBase.bmy_elite3.FireMagicBase			= GetAtack(Npc.tbDamage.bmy_elite3, 4, 0.8);
Npc.tbPropBase.bmy_elite3.LightingMagicBase		= GetAtack(Npc.tbDamage.bmy_elite3, 5, 0.8);

--秦始皇陵4层小兵
Npc.tbPropBase.bmy_soldier4				= Lib:CopyTB1(Npc.tbPropBase.bmy_soldier1);
Npc.tbPropBase.bmy_soldier4.Exp					= 25000;
Npc.tbPropBase.bmy_soldier4.Life				= 1797003;
Npc.tbPropBase.bmy_soldier4.PhysicalDamageBase	= GetAtack(Npc.tbDamage.bmy_soldier4, 1, 0.8);
Npc.tbPropBase.bmy_soldier4.PoisonDamageBase	= GetAtack(Npc.tbDamage.bmy_soldier4, 2, 0.8);
Npc.tbPropBase.bmy_soldier4.ColdDamageBase		= GetAtack(Npc.tbDamage.bmy_soldier4, 3, 0.8);
Npc.tbPropBase.bmy_soldier4.FireDamageBase		= GetAtack(Npc.tbDamage.bmy_soldier4, 4, 0.8);
Npc.tbPropBase.bmy_soldier4.LightingDamageBase	= GetAtack(Npc.tbDamage.bmy_soldier4, 5, 0.8);
Npc.tbPropBase.bmy_soldier4.PhysicalMagicBase	= GetAtack(Npc.tbDamage.bmy_soldier4, 1, 0.8);
Npc.tbPropBase.bmy_soldier4.PoisonMagicBase		= GetAtack(Npc.tbDamage.bmy_soldier4, 2, 0.8);
Npc.tbPropBase.bmy_soldier4.ColdMagicBase		= GetAtack(Npc.tbDamage.bmy_soldier4, 3, 0.8);
Npc.tbPropBase.bmy_soldier4.FireMagicBase		= GetAtack(Npc.tbDamage.bmy_soldier4, 4, 0.8);
Npc.tbPropBase.bmy_soldier4.LightingMagicBase	= GetAtack(Npc.tbDamage.bmy_soldier4, 5, 0.8);
--秦始皇陵4层头领
Npc.tbPropBase.bmy_leader4				= Lib:CopyTB1(Npc.tbPropBase.bmy_leader1);
Npc.tbPropBase.bmy_leader4.Exp					= 50000;
Npc.tbPropBase.bmy_leader4.Life					= 1797003;
Npc.tbPropBase.bmy_leader4.PhysicalDamageBase	= GetAtack(Npc.tbDamage.bmy_leader4, 1, 0.8);
Npc.tbPropBase.bmy_leader4.PoisonDamageBase		= GetAtack(Npc.tbDamage.bmy_leader4, 2, 0.8);
Npc.tbPropBase.bmy_leader4.ColdDamageBase		= GetAtack(Npc.tbDamage.bmy_leader4, 3, 0.8);
Npc.tbPropBase.bmy_leader4.FireDamageBase		= GetAtack(Npc.tbDamage.bmy_leader4, 4, 0.8);
Npc.tbPropBase.bmy_leader4.LightingDamageBase	= GetAtack(Npc.tbDamage.bmy_leader4, 5, 0.8);
Npc.tbPropBase.bmy_leader4.PhysicalMagicBase	= GetAtack(Npc.tbDamage.bmy_leader4, 1, 0.8);
Npc.tbPropBase.bmy_leader4.PoisonMagicBase		= GetAtack(Npc.tbDamage.bmy_leader4, 2, 0.8);
Npc.tbPropBase.bmy_leader4.ColdMagicBase		= GetAtack(Npc.tbDamage.bmy_leader4, 3, 0.8);
Npc.tbPropBase.bmy_leader4.FireMagicBase		= GetAtack(Npc.tbDamage.bmy_leader4, 4, 0.8);
Npc.tbPropBase.bmy_leader4.LightingMagicBase	= GetAtack(Npc.tbDamage.bmy_leader4, 5, 0.8);
--秦始皇陵4层精英
Npc.tbPropBase.bmy_elite4				= Lib:CopyTB1(Npc.tbPropBase.bmy_elite1);
Npc.tbPropBase.bmy_elite4.Exp					= 50000*1.25;
Npc.tbPropBase.bmy_elite4.Life					= 2736580;
Npc.tbPropBase.bmy_elite4.PhysicalDamageBase	= GetAtack(Npc.tbDamage.bmy_elite4, 1, 0.8);
Npc.tbPropBase.bmy_elite4.PoisonDamageBase		= GetAtack(Npc.tbDamage.bmy_elite4, 2, 0.8);
Npc.tbPropBase.bmy_elite4.ColdDamageBase		= GetAtack(Npc.tbDamage.bmy_elite4, 3, 0.8);
Npc.tbPropBase.bmy_elite4.FireDamageBase		= GetAtack(Npc.tbDamage.bmy_elite4, 4, 0.8);
Npc.tbPropBase.bmy_elite4.LightingDamageBase	= GetAtack(Npc.tbDamage.bmy_elite4, 5, 0.8);
Npc.tbPropBase.bmy_elite4.PhysicalMagicBase		= GetAtack(Npc.tbDamage.bmy_elite4, 1, 0.8);
Npc.tbPropBase.bmy_elite4.PoisonMagicBase		= GetAtack(Npc.tbDamage.bmy_elite4, 2, 0.8);
Npc.tbPropBase.bmy_elite4.ColdMagicBase			= GetAtack(Npc.tbDamage.bmy_elite4, 3, 0.8);
Npc.tbPropBase.bmy_elite4.FireMagicBase			= GetAtack(Npc.tbDamage.bmy_elite4, 4, 0.8);
Npc.tbPropBase.bmy_elite4.LightingMagicBase		= GetAtack(Npc.tbDamage.bmy_elite4, 5, 0.8);

--秦始皇召唤的兵马俑boss
Npc.tbPropBase.bmy_fellow1				= Lib:CopyTB1(Npc.tbPropBase.bmy_leader4);
Npc.tbPropBase.bmy_fellow1.Exp					= 0;
Npc.tbPropBase.bmy_fellow1.Life					= 12355380;
Npc.tbPropBase.bmy_fellow1.PhysicalDamageBase	= GetAtack(Npc.tbDamage.bmy_fellow1,1);
Npc.tbPropBase.bmy_fellow1.PoisonDamageBase		= GetAtack(Npc.tbDamage.bmy_fellow1,2);
Npc.tbPropBase.bmy_fellow1.ColdDamageBase		= GetAtack(Npc.tbDamage.bmy_fellow1,3);
Npc.tbPropBase.bmy_fellow1.FireDamageBase		= GetAtack(Npc.tbDamage.bmy_fellow1,4);
Npc.tbPropBase.bmy_fellow1.LightingDamageBase	= GetAtack(Npc.tbDamage.bmy_fellow1,5);
Npc.tbPropBase.bmy_fellow1.PhysicalMagicBase	= GetAtack(Npc.tbDamage.bmy_fellow1,1);
Npc.tbPropBase.bmy_fellow1.PoisonMagicBase		= GetAtack(Npc.tbDamage.bmy_fellow1,2);
Npc.tbPropBase.bmy_fellow1.ColdMagicBase		= GetAtack(Npc.tbDamage.bmy_fellow1,3);
Npc.tbPropBase.bmy_fellow1.FireMagicBase		= GetAtack(Npc.tbDamage.bmy_fellow1,4);
Npc.tbPropBase.bmy_fellow1.LightingMagicBase	= GetAtack(Npc.tbDamage.bmy_fellow1,5);
Npc.tbPropBase.bmy_fellow1.AuraSkillId			= 594;
Npc.tbPropBase.bmy_fellow1.AuraSkillLevel		= 1;
--秦始皇召唤的招魂师boss
Npc.tbPropBase.bmy_fellow2				= Lib:CopyTB1(Npc.tbPropBase.bmy_leader4);
Npc.tbPropBase.bmy_fellow2.Exp					= 0;
Npc.tbPropBase.bmy_fellow2.Life					= 8236920;
Npc.tbPropBase.bmy_fellow2.PhysicalDamageBase	= GetAtack(Npc.tbDamage.bmy_fellow2,1);
Npc.tbPropBase.bmy_fellow2.PoisonDamageBase		= GetAtack(Npc.tbDamage.bmy_fellow2,2);
Npc.tbPropBase.bmy_fellow2.ColdDamageBase		= GetAtack(Npc.tbDamage.bmy_fellow2,3);
Npc.tbPropBase.bmy_fellow2.FireDamageBase		= GetAtack(Npc.tbDamage.bmy_fellow2,4);
Npc.tbPropBase.bmy_fellow2.LightingDamageBase	= GetAtack(Npc.tbDamage.bmy_fellow2,5);
Npc.tbPropBase.bmy_fellow2.PhysicalMagicBase	= GetAtack(Npc.tbDamage.bmy_fellow2,1);
Npc.tbPropBase.bmy_fellow2.PoisonMagicBase		= GetAtack(Npc.tbDamage.bmy_fellow2,2);
Npc.tbPropBase.bmy_fellow2.ColdMagicBase		= GetAtack(Npc.tbDamage.bmy_fellow2,3);
Npc.tbPropBase.bmy_fellow2.FireMagicBase		= GetAtack(Npc.tbDamage.bmy_fellow2,4);
Npc.tbPropBase.bmy_fellow2.LightingMagicBase	= GetAtack(Npc.tbDamage.bmy_fellow2,5);
Npc.tbPropBase.bmy_fellow2.AuraSkillId			= 594;
Npc.tbPropBase.bmy_fellow2.AuraSkillLevel		= 1;

--逍遥谷3期
Npc.tbPropBase.xoyo4660				= Lib:CopyTB1(Npc.tbPropBase.intensity99);
Npc.tbPropBase.xoyo4660.Exp			= 0;

Npc.tbPropBase.xoyo4661						= Lib:CopyTB1(Npc.tbPropBase.xoyo4660)
Npc.tbPropBase.xoyo4661.Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 5*15/2);--5个人打15秒
Npc.tbPropBase.xoyo4661.PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3,1,0.5);
Npc.tbPropBase.xoyo4661.PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3,2,0.5);
Npc.tbPropBase.xoyo4661.ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3,3,0.5);
Npc.tbPropBase.xoyo4661.FireDamageBase		= GetAtack(Npc.tbDamage.fellow3,4,0.5);
Npc.tbPropBase.xoyo4661.LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3,5,0.5);
Npc.tbPropBase.xoyo4661.PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3,1,0.5);
Npc.tbPropBase.xoyo4661.PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3,2,0.5);
Npc.tbPropBase.xoyo4661.ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3,3,0.5);
Npc.tbPropBase.xoyo4661.FireMagicBase		= GetAtack(Npc.tbDamage.fellow3,4,0.5);
Npc.tbPropBase.xoyo4661.LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3,5,0.5);
Npc.tbPropBase.xoyo4661.AuraSkillId			= 1018;--全屏回血
Npc.tbPropBase.xoyo4661.AuraSkillLevel		= 2;
Npc.tbPropBase.xoyo4661.PasstSkillId		= 1411;
Npc.tbPropBase.xoyo4661.PasstSkillLevel		= 1;

Npc.tbPropBase.xoyo4662						= Lib:CopyTB1(Npc.tbPropBase.xoyo4660)
Npc.tbPropBase.xoyo4662.Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 5*20/2);--5个人打20秒
Npc.tbPropBase.xoyo4662.PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3,1,0.5);
Npc.tbPropBase.xoyo4662.PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3,2,0.5);
Npc.tbPropBase.xoyo4662.ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3,3,0.5);
Npc.tbPropBase.xoyo4662.FireDamageBase		= GetAtack(Npc.tbDamage.fellow3,4,0.5);
Npc.tbPropBase.xoyo4662.LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3,5,0.5);
Npc.tbPropBase.xoyo4662.PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3,1,0.5);
Npc.tbPropBase.xoyo4662.PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3,2,0.5);
Npc.tbPropBase.xoyo4662.ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3,3,0.5);
Npc.tbPropBase.xoyo4662.FireMagicBase		= GetAtack(Npc.tbDamage.fellow3,4,0.5);
Npc.tbPropBase.xoyo4662.LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3,5,0.5);
Npc.tbPropBase.xoyo4662.PasstSkillId		= 1411;
Npc.tbPropBase.xoyo4662.PasstSkillLevel		= 1;

Npc.tbPropBase.xoyo4663						= Lib:CopyTB1(Npc.tbPropBase.xoyo4660)
Npc.tbPropBase.xoyo4663.Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 5*30/2);--5个人打30秒
Npc.tbPropBase.xoyo4663.PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3,1,0.5);
Npc.tbPropBase.xoyo4663.PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3,2,0.5);
Npc.tbPropBase.xoyo4663.ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3,3,0.5);
Npc.tbPropBase.xoyo4663.FireDamageBase		= GetAtack(Npc.tbDamage.fellow3,4,0.5);
Npc.tbPropBase.xoyo4663.LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3,5,0.5);
Npc.tbPropBase.xoyo4663.PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3,1,0.5);
Npc.tbPropBase.xoyo4663.PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3,2,0.5);
Npc.tbPropBase.xoyo4663.ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3,3,0.5);
Npc.tbPropBase.xoyo4663.FireMagicBase		= GetAtack(Npc.tbDamage.fellow3,4,0.5);
Npc.tbPropBase.xoyo4663.LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3,5,0.5);
Npc.tbPropBase.xoyo4663.AuraSkillId			= 1429;--提高20%攻击
Npc.tbPropBase.xoyo4663.AuraSkillLevel		= 2;
--Npc.tbPropBase.xoyo4663.PasstSkillId		= 1411;
--Npc.tbPropBase.xoyo4663.PasstSkillLevel		= 1;

Npc.tbPropBase.xoyo4664					= Lib:CopyTB1(Npc.tbPropBase.xoyo4660)
Npc.tbPropBase.xoyo4664.Life			= GetData(Npc.tbDataTemplet.intensity99_Life, 5*60/2);--5个人打60秒
Npc.tbPropBase.xoyo4664.PhysicalDamageBase	= GetAtack(Npc.tbDamage.fellow3,1,0.75);
Npc.tbPropBase.xoyo4664.PoisonDamageBase	= GetAtack(Npc.tbDamage.fellow3,2,0.75);
Npc.tbPropBase.xoyo4664.ColdDamageBase		= GetAtack(Npc.tbDamage.fellow3,3,0.75);
Npc.tbPropBase.xoyo4664.FireDamageBase		= GetAtack(Npc.tbDamage.fellow3,4,0.75);
Npc.tbPropBase.xoyo4664.LightingDamageBase	= GetAtack(Npc.tbDamage.fellow3,5,0.75);
Npc.tbPropBase.xoyo4664.PhysicalMagicBase	= GetAtack(Npc.tbDamage.fellow3,1,0.75);
Npc.tbPropBase.xoyo4664.PoisonMagicBase		= GetAtack(Npc.tbDamage.fellow3,2,0.75);
Npc.tbPropBase.xoyo4664.ColdMagicBase		= GetAtack(Npc.tbDamage.fellow3,3,0.75);
Npc.tbPropBase.xoyo4664.FireMagicBase		= GetAtack(Npc.tbDamage.fellow3,4,0.75);
Npc.tbPropBase.xoyo4664.LightingMagicBase	= GetAtack(Npc.tbDamage.fellow3,5,0.75);
Npc.tbPropBase.xoyo4664.PasstSkillId		= 1411;
Npc.tbPropBase.xoyo4664.PasstSkillLevel		= 1;

-----------------师徒副本-----------------------
Npc.tbPropBase.shitu2459					= Lib:CopyTB1(Npc.tbPropBase.intensity99);
Npc.tbPropBase.shitu2459.Exp				= 0;
Npc.tbPropBase.shitu2459.Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 16);
Npc.tbPropBase.shitu2459.LifeReplenish		= 0;
Npc.tbPropBase.shitu2459.PhysicalDamageBase	= GetAtack(Npc.tbDamage.intensity0, 1, 2);
Npc.tbPropBase.shitu2459.PoisonDamageBase	= GetAtack(Npc.tbDamage.intensity0, 2, 2);
Npc.tbPropBase.shitu2459.ColdDamageBase		= GetAtack(Npc.tbDamage.intensity0, 3, 2);
Npc.tbPropBase.shitu2459.FireDamageBase		= GetAtack(Npc.tbDamage.intensity0, 4, 2);
Npc.tbPropBase.shitu2459.LightingDamageBase	= GetAtack(Npc.tbDamage.intensity0, 5, 2);
Npc.tbPropBase.shitu2459.PhysicalMagicBase	= GetAtack(Npc.tbDamage.intensity0, 1, 2);
Npc.tbPropBase.shitu2459.PoisonMagicBase	= GetAtack(Npc.tbDamage.intensity0, 2, 2);
Npc.tbPropBase.shitu2459.ColdMagicBase		= GetAtack(Npc.tbDamage.intensity0, 3, 2);
Npc.tbPropBase.shitu2459.FireMagicBase		= GetAtack(Npc.tbDamage.intensity0, 4, 2);
Npc.tbPropBase.shitu2459.LightingMagicBase	= GetAtack(Npc.tbDamage.intensity0, 5, 2);

Npc.tbPropBase.shitu2460					= Lib:CopyTB1(Npc.tbPropBase.shitu2459);
Npc.tbPropBase.shitu2460.Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 80);
Npc.tbPropBase.shitu2460.PasstSkillId		= 1480;
Npc.tbPropBase.shitu2460.PasstSkillLevel	= 20;

Npc.tbPropBase.shitu2462					= Lib:CopyTB1(Npc.tbPropBase.shitu2459);
Npc.tbPropBase.shitu2462.Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 27);

Npc.tbPropBase.shitu2461					= Lib:CopyTB1(Npc.tbPropBase.shitu2459);
Npc.tbPropBase.shitu2461.Life				= GetData(Npc.tbDamage.intensity0[1], 6*20);
Npc.tbPropBase.shitu2461.PhysicalDamageBase	= 0;
Npc.tbPropBase.shitu2461.PoisonDamageBase	= 0;
Npc.tbPropBase.shitu2461.ColdDamageBase		= 0;
Npc.tbPropBase.shitu2461.FireDamageBase		= 0;
Npc.tbPropBase.shitu2461.LightingDamageBase	= 0;
Npc.tbPropBase.shitu2461.PhysicalMagicBase	= 0;
Npc.tbPropBase.shitu2461.PoisonMagicBase	= 0;
Npc.tbPropBase.shitu2461.ColdMagicBase		= 0;
Npc.tbPropBase.shitu2461.FireMagicBase		= 0;
Npc.tbPropBase.shitu2461.LightingMagicBase	= 0;

Npc.tbPropBase.shitu2464					= Lib:CopyTB1(Npc.tbPropBase.shitu2459);
Npc.tbPropBase.shitu2464.Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 150*3);
Npc.tbPropBase.shitu2464.AuraSkillId		= 594;
Npc.tbPropBase.shitu2464.AuraSkillLevel		= 1;

Npc.tbPropBase.shitu2465					= Lib:CopyTB1(Npc.tbPropBase.shitu2464);
Npc.tbPropBase.shitu2465.Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 150*2);

Npc.tbPropBase.shitu2467					= Lib:CopyTB1(Npc.tbPropBase.shitu2464);
Npc.tbPropBase.shitu2467.Life				= GetData(Npc.tbDataTemplet.intensity99_Life, 150*3.5);

Npc.tbPropBase.shitu2468					= Lib:CopyTB1(Npc.tbPropBase.shitu2461);
Npc.tbPropBase.shitu2468.PasstSkillId		= 1480;
Npc.tbPropBase.shitu2468.PasstSkillLevel	= 20;
