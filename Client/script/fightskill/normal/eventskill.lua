--节日、活动技能
local tb	= {

	--2009新年活动
	snowball_damage={
		appenddamage_p={{{1,0},{2,0}}},
		magicdamage_v={
			[1]={{1,1},{2,2},{3,3},{4,4}},
			[3]={{1,1},{2,2},{3,3},{4,4}}
		},
		missile_speed_v={40},
	},
	snowball_xuejinzhen={
		appenddamage_p={{{1,0},{2,0}}},
		magicdamage_v={
			[1]={{1,1},{2,2},{3,3},{4,3}},
			[3]={{1,1},{2,2},{3,3},{4,3}}
		},
		missile_speed_v={60},
	},
	snowball_fixed={
		state_fixed_attack={{{1,100},{2,100}},{{1,18*1},{2,18*1},{3,18*1},{4,18*2}}},
	},
	snowball_freeze={
		state_freeze_attack={{{1,100},{2,100}},{{1,18*2},{2,18*2},{3,18*2},{4,18*2}}},
	},
	snowball_confuse={
		state_confuse_attack={{{1,100},{2,100}},{{1,18*1},{2,18*1},{3,18*1},{4,18*1}}},
	},
	snowball_stun={
		state_stun_attack={{{1,100},{2,100}},{{1,18*1},{2,18*1},{3,18*1},{4,18*2}}},
	},
	snowball_slowall={
		state_slowall_attack={{{1,100},{2,100}},{{1,18*2},{2,18*2},{3,18*1},{4,18*2}}},
	},
	snowball_duixueji={
		state_stun_attack={{{1,100},{2,100}},{{1,18*1},{2,18*1},{3,18*1},{4,18*2}}},
		appenddamage_p={{{1,0},{2,0}}},
		magicdamage_v={
			[1]={{1,1},{2,2},{3,3},{4,3}},
			[3]={{1,1},{2,2},{3,3},{4,3}}
		},
		missile_speed_v={40},
	},
	snowball_water={
		state_slowall_attack={{{1,100},{2,100}},{{1,18*3},{5,18*3}}},
		appenddamage_p={{{1,0},{2,0}}},
		magicdamage_v={
			[1]={{1,1},{2,2},{3,3},{4,3}},
			[3]={{1,1},{2,2},{3,3},{4,3}}
		},
	},
	tabingjue={
		fastwalkrun_p={{{1,10},{2,20}}},
		skill_statetime={{{1,18*30},{2,18*30}}},
	},
	chengshuangshi={
		addenchant={21, {{1,1}, {2, 2}}},
		skill_statetime={{{1,18*30},{2,18*30}}},
	},
	snowglove={
		addenchant={22, {{1,1}, {2, 2}}},
		skill_statetime={{{1,18*30},{2,18*30}}},
	},
	xueyingwu={
		state_slowall_ignore={1},
		state_stun_ignore={1},
		state_fixed_ignore={1},
		state_freeze_ignore={1},
		state_confuse_ignore={1},
		skill_statetime={{{1,18*30},{2,18*30}}},
	},
	jiangbinyu={
		prop_invincibility={1},
		skill_statetime={{{1,18*20},{2,18*20}}},
	},
	newyearmonsteratk={		--飞絮崖年兽攻击技能
		appenddamage_p={{{1,0},{2,0}}},
		magicdamage_v={
			[1]={{1,1},{2,2},{3,3},{4,3}},
			[3]={{1,1},{2,2},{3,3},{4,3}}
		},
	},
	newyear_transmutation={ --变身技能
		domainchangeself={{{1,3605},{2,3606},{3,3607},{4,3608},{5,4286},{8,4289},{9,4483}},{{1,1},{2,1}}},
		adddomainskill1={{{1,1300},{4,1300},{5,1451},{8,1451},{9,1430}},{{1,1},{20,1}}},
		adddomainskill2={{{1,0},{4,0},{5,0},{8,0},{9,0}},{{1,2},{20,2}}},
		skill_statetime={{{1,18*60*30},{10,18*60*30},{11,18*60*30}}},
	},
	addpower1329={ --年兽冲刺攻击穿透攻击提高
		--addpowerwhencol = {1329, {{1,10}, {10, 10}}, {{1,200}, {10, 200}}},
		skill_statetime={{{1,18*60*30},{10,18*60*30},{11,18*60*30}}},
	},
---------------------------------------
--端午节龙舟技能
--1级天罚,2级固定机关,3级粽子,4级玩家学习,11级撞墙
	lz_chihuan={ --履冰,迟缓5秒
		state_slowall_attack	={{{1,100},{10,100},{11,1000}},{{1,18*5},{2,18*5},{10,18*5},{11,18*6}}},
	},
	lz_yunxuan={ --暗礁,晕眩2秒
		state_stun_attack		={{{1,100},{10,100},{11,1000}},{{1,18*2},{2,18*2},{10,18*2},{11,18*3}}},
	},
	lz_dingshen={ --掀浪,定身3秒
		state_fixed_attack		={{{1,100},{10,100},{11,1000}},{{1,18*3},{2,18*3},{10,18*3},{11,18*4}}},
	},
	lz_hunluan={ --漩涡,混乱2秒
		state_confuse_attack	={{{1,100},{10,100},{11,1000}},{{1,18*2},{2,18*3},{10,18*4},{11,18*3}}},
	},
	lz_lahui={ --龙吞,拉回定身
		state_drag_attack		={{{1,100},{10,100},{11,1000}},{{1,25},{10,25}},{{1,32},{2,32}}},
		state_fixed_attack		={{{1,100},{10,100},{11,1000}},{{1,18*3},{10,18*3},{11,18*3}}},
	},
	lz_jitui={ --扫尾,击退400
		state_knock_attack		={{{1,100},{10,100},{11,1000}},{{1,20},{10,20}},{{1,20},{2,20}}},
	},

--被动技能
	shifu={ --石肤,减迟缓和定身40%
		state_slowall_resistrate={{{1,166},{2,166}}},
		state_fixed_resistrate={{{1,166},{2,166}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	longxin={ --龙心,减迟缓和混乱40%
		state_slowall_resistrate={{{1,166},{2,166}}},
		state_confuse_resistrate={{{1,166},{2,166}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	haihun={ --海魂,减迟缓和晕眩40%
		state_slowall_resistrate={{{1,166},{2,166}}},
		state_stun_resistrate={{{1,166},{2,166}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	nilin={ --逆鳞,减所有负面几率30%
		allseriesstateresistrate={{{1,107},{2,107}}},
		allspecialstateresistrate={{{1,107},{2,107}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
--主动辅助
	zhuihunyin={ --追魂引,跑速提高50%,持续6秒
		fastwalkrun_p={{{1,50},{2,50}}},
		skill_statetime={{{1,6*18},{2,6*18}}},
	},
	zhaohunqu={ --招魂曲,免疫负面状态8秒
		state_fixed_ignore={1},
		state_stun_ignore={1},
		state_slowall_ignore={1},
		state_knock_ignore={1},
		state_drag_ignore={1},
		state_confuse_ignore={1},
		skill_statetime={{{1,8*18},{2,8*18}}},
	},
	huihunjue={ --回魂诀,隐身8秒
		hide={0,{{1,8*18},{2,8*18}}, 1},
	},

	longzhou_transmutation={ --变身技能
		domainchangeself={{{1,3645},{2,3646},{3,3647},{4,3648}},{{1,99},{2,99}}},
		skill_statetime={{{1,18*60*30},{10,18*60*30},{11,18*60*30}}},
	},
-----------------美女光环----------------------
	bellebuff={
		autoskill={{{1,50},{2,50}},{{1,1},{2,2}}},
	},
	bellebuff_team={
		expenhance_p=	{{{1,5},{2,10}}},
		lucky_v=		{{{1,5},{2,10}}},
	},
-------------------联赛观战--------------------
	spectator_state={
		hide_all={{{1,1},{10,1}}},
	},
------------------中秋及国庆---------------------
	defencestate={--不能被攻击
		defense_state={1}
	},
------------------结婚系统---------------------
	jiehunxitongyanhua={ --结婚系统烟花
		skill_startevent={{{1,1529},{2,1530}}},
		skill_showevent={{{1,1},{20,1}}},
		skill_startevent={{{1,1529},{2,1530}}},
		skill_showevent={{{1,1},{20,1}}},
	},
	jiehunxitongziti={ --结婚系统字体
		skill_startevent={{{1,1556},{2,1557}}},
		skill_showevent={{{1,1},{20,1}}},
		skill_startevent={{{1,1556},{2,1557}}},
		skill_showevent={{{1,1},{20,1}}},
	},
----------------------------------清明节植物大战僵尸-----------------------------------	
	npc_liferefleshstate2={	--每5秒生命回复
		lifereplenish_v={{{1,5},{2,10},{3,15}}},
	},
	npc_maxhpstate2={	--增加生命上限
		lifemax_p={{{1,5},{2,10}}},
	},
	qingming_transmutation={ --变身技能
		domainchangeself={{{1,6692},{6,6697}},{{1,100},{2,100}}},
		adddomainskill1={{{1,1616},{4,1616}},{{1,1},{20,1}}},
		adddomainskill2={{{1,0},{4,0},{5,0},{8,0},{9,0}},{{1,2},{20,2}}},
		skill_statetime={{{1,18*60*30},{10,18*60*30},{11,18*60*30}}},
	},
	npc_changehp={	--加减血
		fastlifereplenish_v={{{1,30},{2,-30}}},
	},
--清明节玩家控制技能
	qmj_chihuan={ --履冰,迟缓5秒
		state_slowall_attack	={{{1,100},{10,100},{11,1000}},{{1,18*5},{2,18*5},{10,18*5},{11,18*6}}},
		magicdamage_v={
			[1]={{1,2},{2,2}},
			[3]={{1,2},{2,2}}
		},
	},
	qmj_yunxuan={ --暗礁,晕眩2秒
		state_stun_attack		={{{1,100},{10,100},{11,1000}},{{1,18*2},{2,18*2},{10,18*2},{11,18*3}}},
		magicdamage_v={
			[1]={{1,2},{2,2}},
			[3]={{1,2},{2,2}}
		},
	},
	qmj_dingshen={ --掀浪,定身3秒
		state_fixed_attack		={{{1,100},{10,100},{11,1000}},{{1,18*3},{2,18*3},{10,18*3},{11,18*4}}},
		magicdamage_v={
			[1]={{1,2},{2,2}},
			[3]={{1,2},{2,2}}
		},
	},
	qmj_hunluan={ --漩涡,混乱2秒
		state_confuse_attack	={{{1,100},{10,100},{11,1000}},{{1,18*2},{2,18*3},{10,18*4},{11,18*3}}},
		magicdamage_v={
			[1]={{1,2},{2,2}},
			[3]={{1,2},{2,2}}
		},
	},
	qmj_lahui={ --龙吞,拉回定身
		state_drag_attack		={{{1,100},{10,100},{11,1000}},{{1,25},{10,25}},{{1,32},{2,32}}},
		state_fixed_attack		={{{1,100},{10,100},{11,1000}},{{1,18*3},{10,18*3},{11,18*3}}},
		magicdamage_v={
			[1]={{1,2},{2,2}},
			[3]={{1,2},{2,2}}
		},
	},
	qmj_jitui={ --扫尾,击退400
		state_knock_attack		={{{1,100},{10,100},{11,1000}},{{1,20},{10,20}},{{1,20},{2,20}}},
		magicdamage_v={
			[1]={{1,2},{2,2}},
			[3]={{1,2},{2,2}}
		},
	},
-------------------------------------5.1活动-------------------------------------------------
	workday_transmutation={ --变身技能
		--参数1,变身npcid,参数2变身npc等级,参数3变身类型:1变外观,2变属性,4改变技能
		domainchangeself={{{1,6807},{5,6811},{6,6811}},{{1,100},{2,100}},{{1,1},{2,1}}},
		skill_statetime={{{1,18*60*60},{10,18*60*60},{11,18*60*60}}},
	},
}

FightSkill:AddMagicData(tb)

local tbSkill	= FightSkill:GetClass("bellebuff");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg	= string.format("\n每隔%s秒释放：<color=green>月华千里<color>\n幸运值：增加<color=gold>%s点<color>\n杀死敌人的经验：增加<color=gold>%s%%<color>\n持续时间<color=gold>%s秒<color>",
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime),
		tbChildInfo.tbWholeMagic["lucky_v"][1],
		tbChildInfo.tbWholeMagic["expenhance_p"][1],
		FightSkill:Frame2Sec(tbChildInfo.nStateTime));
	return szMsg;
end;
