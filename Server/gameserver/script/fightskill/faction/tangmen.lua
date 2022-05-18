Require("\\script\\fightskill\\fightskill.lua")
local tb	= {
	ducigu={ --毒刺骨_20
		appenddamage_p= {{{1,100},{20,100},{21,100*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,5},{10,50},{20,80},{21,80*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,5},{10,50},{20,80},{21,80*FightSkill.tbParam.nSadd}},{{1,9*3},{20,9*3}}},
		skill_maxmissile={{{1,3},{10,5},{20,8},{21,8}}},
		skill_cost_v={{{1,10},{20,150},{21,150}}},
		skill_mintimepercast_v={{{1,2.5*18},{20,2.5*18},{21,2.5*18}}},
		seriesdamage_r={{{1,50},{20,100},{21,100}}},
		addskilldamagep={72, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={74, {{1,2},{20,30},{21,35}}, 1},
		addskilldamagep3={796, {{1,2},{20,30},{21,35}}},
		addskilldamagep4={797, {{1,2},{20,30},{21,35}}},
		missile_lifetime_v={30*18},
	},
	ducigu_child={ --毒刺骨子
		appenddamage_p= {{{1,100},{20,100},{21,100*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,5},{10,50},{20,80},{21,80*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,5},{10,50},{20,80},{21,80*FightSkill.tbParam.nSadd}},{{1,9*5},{20,9*5}}},
		missile_hitcount={{{1,2},{10,3},{20,4},{21,4}}},
		seriesdamage_r={{{1,50},{20,100},{21,100}}},
	},
	tangmenxianjing={ --唐门陷阱_10
		addpoisondamage_v={{{1,5},{10,80},{11,88}},{{1,5*9},{20,5*9}}},
		deadlystrikeenhance_r={{{1,30},{10,150},{11,155}}},
		deadlystrikedamageenhance_p={{{1,4},{10,40},{11,45}}},
		attackratingenhance_p={{{1,40},{10,75},{12,90}}},
		attackspeed_v={{{1,5},{10,15},{11,16},{12,17},{13,17}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	gouhunjing={ --勾魂阱_20
		state_slowall_attack={{{1,25},{20,50},{21,51}},{{1,18*5},{20,18*10},{21,18*10}}},
		skill_maxmissile={{{1,3},{20,5},{21,5}}},
		skill_cost_v={{{1,100},{20,250}}},
		skill_mintimepercast_v={{{1,2.5*18},{20,2.5*18},{21,2.5*18}}},
		addskilldamagep={69, {{1,2},{20,10},{21,12}},1},
		addskilldamagep2={184, {{1,2},{20,10},{21,12}}},
		missile_lifetime_v={30*18},
	},
	gouhunjing_child={ --勾魂阱子
		state_slowall_attack={{{1,25},{20,50},{21,51}},{{1,18*5},{20,18*10},{21,18*10}}},
		missile_hitcount={{{1,2},{10,3},{20,4},{21,4}}},
	},
	xiaolifeidao={ --小李飞刀_20
		appenddamage_p= {{{1,100*1.2},{20,100*1.2},{21,100*FightSkill.tbParam.nSadd*1.2}}},
		skill_cost_v={{{1,5},{20,20},{21,20}}},
		state_hurt_attack={{{1,15},{10,35},{20,40},{21,41}},{{1,18},{20,18}}},
		state_weak_attack={{{1,15},{10,45},{20,50},{23,54}},{{1,36},{20,54},{21,54}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		poisondamage_v={{{1,5*1.2},{10,50*1.2},{20,100*1.2},{21,100*FightSkill.tbParam.nSadd*1.2}},{{1,5*9},{20,5*9}}},
		addskilldamagep={74, {{1,2},{20,30},{21,35}}, 1},
		addskilldamagep2={796, {{1,2},{20,30},{21,35}}},
		addskilldamagep3={797, {{1,2},{20,30},{21,35}}},
		skill_attackradius={520},
		missile_range={1,0,1},
	},
	miyingzong={ --迷影纵_10
		skill_cost_v={{{1,50},{10,100},{11,100}}},
		skill_param1_v={{{1,120},{10,400},{11,435},{12,470},{13,500},{14,500}}},
		skill_mintimepercast_v={{{1,8*18},{10,5*18},{11,5*18}}},
		skill_mintimepercastonhorse_v={{{1,11*18},{10,8*18},{11,8*18}}},
	},
	xixingzhen={ --吸星阵
		fastmanareplenish_v={{{1,-50},{10,-150},{11,-160}}},
		manareplenish_p={{{1,-10},{10,-40},{13,-45}}},
		skill_maxmissile={{{1,3},{10,5},{11,5}}},
		skill_cost_v={{{1,100},{10,250},{11,250}}},
		skill_mintimepercast_v={{{1,2.5*18},{10,2.5*18},{11,2.5*18}}},
		addskilldamagep={69, {{1,2},{10,10},{11,10}},1},
		addskilldamagep2={184, {{1,2},{10,10},{11,10}}},
		skill_statetime={{{1,18*5},{10,18*10},{11,18*10}}},
		missile_lifetime_v={30*18},
	},
	xixingzhen_child={ --吸星阵子
		fastmanareplenish_v={{{1,-50},{10,-150},{11,-160}}},
		manareplenish_p={{{1,-1},{10,-40},{11,-45}}},
		missile_hitcount={{{1,2},{10,4},{11,4}}},
		skill_statetime={{{1,18*5},{10,18*10},{11,18*10}}},
	},
	chanshenci={ --缠身刺_20
		state_fixed_attack={{{1,35},{20,75},{23,80}},{{1,18*1.5},{20,18*3},{23,3.5*18}}},
		skill_maxmissile={{{1,3},{10,5},{20,7},{21,7}}},
		skill_cost_v={{{1,150},{20,250},{21,250}}},
		missile_hitcount={{{1,2},{10,3},{20,4},{21,4}}},
		skill_mintimepercast_v={{{1,2.5*18},{20,2.5*18},{21,2.5*18}}},
		addskilldamagep={69, {{1,2},{20,10},{21,12}},1},
		addskilldamagep2={184, {{1,2},{20,10},{21,12}}},
		missile_lifetime_v={30*18},
	},
	luanhuanji={ --乱环击
		appenddamage_p= {{{1,40*1.2*FightSkill.tbParam.nS1},{10,40*1.2},{20,40*1.2*FightSkill.tbParam.nS20},{21,40*1.2*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,45*1.2*FightSkill.tbParam.nS1},{10,45*1.2},{20,45*1.2*FightSkill.tbParam.nS20},{21,45*1.2*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,2*9},{20,2*9}}},
		physicsdamage_v={
			[1]={{1,135*1.2*0.9*FightSkill.tbParam.nS1},{10,135*1.2*0.9},{20,135*1.2*0.9*FightSkill.tbParam.nS20},{21,135*1.2*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,135*1.2*1.1*FightSkill.tbParam.nS1},{10,135*1.2*1.1},{20,135*1.2*1.1*FightSkill.tbParam.nS20},{21,135*1.2*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		colddamage_v={
			[1]={{1,135*1.2*0.9*FightSkill.tbParam.nS1},{10,135*1.2*0.9},{20,135*1.2*0.9*FightSkill.tbParam.nS20},{21,135*1.2*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,135*1.2*1.1*FightSkill.tbParam.nS1},{10,135*1.2*1.1},{20,135*1.2*1.1*FightSkill.tbParam.nS20},{21,135*1.2*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		firedamage_v={
			[1]={{1,135*1.2*0.9*FightSkill.tbParam.nS1},{10,135*1.2*0.9},{20,135*1.2*0.9*FightSkill.tbParam.nS20},{21,135*1.2*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,135*1.2*1.1*FightSkill.tbParam.nS1},{10,135*1.2*1.1},{20,135*1.2*1.1*FightSkill.tbParam.nS20},{21,135*1.2*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		lightingdamage_v={
			[1]={{1,135*1.2*0.9*FightSkill.tbParam.nS1},{10,135*1.2*0.9},{20,135*1.2*0.9*FightSkill.tbParam.nS20},{21,135*1.2*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,135*1.2*1.1*FightSkill.tbParam.nS1},{10,135*1.2*1.1},{20,135*1.2*1.1*FightSkill.tbParam.nS20},{21,135*1.2*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,150},{20,300},{21,300}}},

		skill_maxmissile={{{1,2},{10,3},{20,4}}},
		skill_mintimepercast_v={{{1,2.5*18},{20,2.5*18},{21,2.5*18}}},
		state_knock_attack={{{1,30},{10,50},{20,80}},{{1,3},{10,10},{20,10}},{{1,32},{2,32}}},
		missile_hitcount={{{1,3},{10,4},{20,5},{21,5}}},
		missile_lifetime_v={30*18},
	},
	luanhuanji_child2={ --乱环击子2
		appenddamage_p= {{{1,50*1.2*FightSkill.tbParam.nS1},{10,50*1.2},{20,50*1.2*FightSkill.tbParam.nS20},{21,50*1.2*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,90*1.2*FightSkill.tbParam.nS1},{10,90*1.2},{20,90*1.2*FightSkill.tbParam.nS20},{21,90*1.2*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,2*9},{20,2*9}}},
		physicsdamage_v={
			[1]={{1,270*1.2*0.9*FightSkill.tbParam.nS1},{10,270*1.2*0.9},{20,270*1.2*0.9*FightSkill.tbParam.nS20},{21,270*1.2*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,270*1.2*1.1*FightSkill.tbParam.nS1},{10,270*1.2*1.1},{20,270*1.2*1.1*FightSkill.tbParam.nS20},{21,270*1.2*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		colddamage_v={
			[1]={{1,270*1.2*0.9*FightSkill.tbParam.nS1},{10,270*1.2*0.9},{20,270*1.2*0.9*FightSkill.tbParam.nS20},{21,270*1.2*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,270*1.2*1.1*FightSkill.tbParam.nS1},{10,270*1.2*1.1},{20,270*1.2*1.1*FightSkill.tbParam.nS20},{21,270*1.2*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		firedamage_v={
			[1]={{1,270*1.2*0.9*FightSkill.tbParam.nS1},{10,270*1.2*0.9},{20,270*1.2*0.9*FightSkill.tbParam.nS20},{21,270*1.2*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,270*1.2*1.1*FightSkill.tbParam.nS1},{10,270*1.2*1.1},{20,270*1.2*1.1*FightSkill.tbParam.nS20},{21,270*1.2*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		lightingdamage_v={
			[1]={{1,270*1.2*0.9*FightSkill.tbParam.nS1},{10,270*1.2*0.9},{20,270*1.2*0.9*FightSkill.tbParam.nS20},{21,270*1.2*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,270*1.2*1.1*FightSkill.tbParam.nS1},{10,270*1.2*1.1},{20,270*1.2*1.1*FightSkill.tbParam.nS20},{21,270*1.2*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		missile_hitcount={{{1,2},{10,3},{20,3},{21,3}}},
	},
	luanhuanji_child3={ --乱环击子3
		appenddamage_p= {{{1,40*1.2*FightSkill.tbParam.nS1},{10,40*1.2},{20,40*1.2*FightSkill.tbParam.nS20},{21,40*1.2*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,45*1.2*FightSkill.tbParam.nS1},{10,45*1.2},{20,45*1.2*FightSkill.tbParam.nS20},{21,45*1.2*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,2*9},{20,2*9}}},
		physicsdamage_v={
			[1]={{1,135*1.2*0.9*FightSkill.tbParam.nS1},{10,135*1.2*0.9},{20,135*1.2*0.9*FightSkill.tbParam.nS20},{21,135*1.2*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,135*1.2*1.1*FightSkill.tbParam.nS1},{10,135*1.2*1.1},{20,135*1.2*1.1*FightSkill.tbParam.nS20},{21,135*1.2*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		colddamage_v={
			[1]={{1,135*1.2*0.9*FightSkill.tbParam.nS1},{10,135*1.2*0.9},{20,135*1.2*0.9*FightSkill.tbParam.nS20},{21,135*1.2*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,135*1.2*1.1*FightSkill.tbParam.nS1},{10,135*1.2*1.1},{20,135*1.2*1.1*FightSkill.tbParam.nS20},{21,135*1.2*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		firedamage_v={
			[1]={{1,135*1.2*0.9*FightSkill.tbParam.nS1},{10,135*1.2*0.9},{20,135*1.2*0.9*FightSkill.tbParam.nS20},{21,135*1.2*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,135*1.2*1.1*FightSkill.tbParam.nS1},{10,135*1.2*1.1},{20,135*1.2*1.1*FightSkill.tbParam.nS20},{21,135*1.2*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		lightingdamage_v={
			[1]={{1,135*1.2*0.9*FightSkill.tbParam.nS1},{10,135*1.2*0.9},{20,135*1.2*0.9*FightSkill.tbParam.nS20},{21,135*1.2*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,135*1.2*1.1*FightSkill.tbParam.nS1},{10,135*1.2*1.1},{20,135*1.2*1.1*FightSkill.tbParam.nS20},{21,135*1.2*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_knock_attack={{{1,30},{10,50},{20,80}},{{1,3},{10,10},{20,10}},{{1,32},{2,32}}},
		missile_hitcount={{{1,1},{10,2},{20,3},{21,3}}},
	},
	xinpo={ --心魄_20
		state_weak_attackrate={{{1,10},{20,100}}},
		state_stun_resistrate={{{1,10},{10,100},{20,150}}},
		attackspeed_v={{{1,10},{10,16},{20,26},{23,29},{24,29}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	shiguxueren={ --蚀骨血刃
		skilldamageptrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		skillselfdamagetrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		state_weak_attacktime={{{1,10},{10,80}}},
		state_stun_resisttime={{{1,10},{10,120}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},

	hanshasheying={ --中级秘籍：含沙射影
		addenchant={1, {{1,1}, {2, 2}}},
		skill_skillexp_v=FightSkill.tbParam.tbMidBookSkillExp,
		skill_statetime={{{1,-1},{2,-1}}},
		
	},
	
	jiguanmishu={ --机关秘术_10
		addenchant={19, {{1,1}, {2, 2}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	xianjingadvancedbook={ --高级秘籍_10
		state_drag_attack={{{1,5},{10,20}},{{1,11},{10,11}},{{1,32},{2,32}}},
		missile_drag={1},
		missile_hitcount={{{1,3},{10,10}}},
		skill_cost_v={{{1,200},{10,200}}},
		skill_mintimepercast_v={{{1,60*18},{10,15*18}}},
		skill_mintimepercastonhorse_v={{{1,60*18},{10,15*18}}},
		skill_maxmissile={{{1,1},{10,1}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	xianjing120={ --陷阱120_10
		addenchant={28, {{1,1}, {2, 2}}},
		ignoreskill={{{1,66},{10,66}},0,{{1,3},{2,3}}},
		skilldamageptrim	={{{1,33},{10,33}}},
		skillselfdamagetrim	={{{1,33},{10,33}}},
		skill_cost_v={{{1,500},{10,500}}},
		skill_mintimepercast_v={{{1,30*18},{10,30*18}}},
		skill_statetime={{{1,6*18},{10,15*18},{11,16*18}}},
	},
	xianjing120_child={ --陷阱120_状态_10
		addenchant={28, {{1,1}, {2, 2}}},
		ignoreskill={{{1,66},{10,66}},0,{{1,3},{2,3}}},
		skilldamageptrim	={{{1,33},{10,33}}},
		skillselfdamagetrim	={{{1,33},{10,33}}},
		skill_missilenum_v={{{1,6},{10,15},{11,16}},1},
		skill_statetime={{{1,3.5*18},{2,3.5*18}}},
	},

	zhuixinjian={ --追心箭_20
		appenddamage_p={{{1,100},{20,100},{21,100*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,5},{10,23},{20,43},{21,43*FightSkill.tbParam.nSadd}}},
		skill_cost_v={{{1,2},{20,20},{21,20}}},
		state_hurt_attack={{{1,15},{20,40},{21,41}},{{1,18},{20,18}}},
		state_weak_attack={{{1,15},{10,45},{20,50},{23,55}},{{1,36},{20,54},{21,54}}},
		seriesdamage_r={{{1,50},{20,100},{21,100}}},
		poisondamage_v={{{1,15},{10,60},{20,100},{21,100*FightSkill.tbParam.nSadd}},{{1,10*9},{20,10*9}}},
		addskilldamagep={62, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={63, {{1,2},{20,30},{21,35}}},
		addskilldamagep3={66, {{1,2},{20,10},{21,12}},1},
		addskilldamagep4={67, {{1,2},{20,10},{21,12}}},
	},
	tangmenxiujian={ --唐门袖箭_10
		addphysicsdamage_p={{{1,10},{10,200},{11,220}}},
		attackratingenhance_p={{{1,40},{10,125},{12,150}}},
		deadlystrikeenhance_r={{{1,30},{10,50},{11,55}}},
		attackspeed_v={{{1,5},{10,15},{11,16},{12,17},{13,17}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	cuidushu={ --淬毒术_20
		deadlystrikedamageenhance_p={{{1,25},{20,120},{21,125}}},
		addpoisondamage_v={{{1,10},{20,45},{23,53}},{{1,9*9},{20,9*9}}},
		addphysicsdamage_p={{{1,20},{20,90},{21,95}}},
	},
	cuidushu_team={ --淬毒术_队友
		deadlystrikedamageenhance_p={{{1,10},{10,60},{20,115},{21,120}}},
	},
	tianluodiwang={ --天罗地网_20
		appenddamage_p= {{{1,65},{20,65},{21,65*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,50},{10,77},{20,107},{21,110}}},
		skill_cost_v={{{1,20},{20,50},{21,50}}},
		state_hurt_attack={{{1,15},{20,40},{21,41}},{{1,18},{20,18}}},
		state_weak_attack={{{1,15},{10,45},{20,50},{21,51}},{{1,36},{20,54},{21,54}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		poisondamage_v={{{1,120},{10,165},{20,215},{21,215*FightSkill.tbParam.nSadd}},{{1,10*9},{20,10*9}}},
		addskilldamagep={66, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={67, {{1,2},{20,30},{21,35}}},
	},
	tianluodiwang_child={ --天罗地网子
		appenddamage_p= {{{1,45},{20,45},{21,45*FightSkill.tbParam.nSadd}}},
		state_hurt_attack={{{1,15},{20,40},{21,41}},{{1,18},{20,18}}},
		state_weak_attack={{{1,15},{10,45},{20,50},{21,51}},{{1,36},{20,54},{21,54}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		poisondamage_v={{{1,70},{10,85},{20,95},{21,100}},{{1,10*9},{20,10*9}}},
		missile_speed_v={30},
		missile_range={1,0,1},
		},
	duanjinren={ --断筋刃_10
		autoskill={{{1,12},{2,12}},{{1,1},{10,10}}},
		skill_mintimepercast_v={{{1,45*18},{10,45*18}}},
		skill_mintimepercastonhorse_v={{{1,45*18},{10,45*18}}},
		skill_statetime={{{1,18*5},{10,18*30},{11,18*32.5}}},
		missile_speed_v={40},
		skill_missilenum_v={5},
		missile_hitcount={{{1,2},{2,2}}},
		state_fixed_attack={{{1,50},{10,85},{13,90}},{{1,18*2},{10,18*2}}},
	},
	duanjinren_child={ --断筋刃子
		state_fixed_attack={{{1,50},{10,85},{13,90}},{{1,18*3},{10,18*3}}},
	},
	yudushu={ --驭毒术_20
		addpoisondamage_v={{{1,20},{20,200},{21,210}},{{1,5*9},{20,5*9}}},
		state_stun_resisttime={{{1,30},{20,135},{21,140}}},
		deadlystrikeenhance_r={{{1,30},{10,50},{20,70},{21,75}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	baoyulihua={ --暴雨梨花
		appenddamage_p= {{{1,40*FightSkill.tbParam.nS1},{10,40},{20,40*FightSkill.tbParam.nS20},{21,40*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,40*FightSkill.tbParam.nS1},{10,40},{20,40*FightSkill.tbParam.nS20},{21,40*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,9*9},{20,9*9}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_hurt_attack={{{1,20},{20,25}},{{1,18},{20,18}}},
		state_weak_attack={{{1,10},{10,20},{20,30}},{{1,36},{20,54},{21,54}}},
		missile_hitcount={{{1,5},{2,5}}},
		skill_flyevent={{{1,67},{20,67}},{{1,10},{2,10}}},
		skill_showevent={{{1,2},{20,2}}},
	},
	zhuixingzhudian={ --追星逐电，暴雨梨花第二式
		appenddamage_p= {{{1,45*FightSkill.tbParam.nS1},{10,45},{20,45*FightSkill.tbParam.nS20},{21,45*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,45*FightSkill.tbParam.nS1},{10,45},{20,45*FightSkill.tbParam.nS20},{21,45*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,9*9},{20,9*9}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_hurt_attack={{{1,15},{20,30}},{{1,18},{20,18}}},
		state_weak_attack={{{1,10},{10,20},{20,30}},{{1,36},{20,54},{21,54}}},
	},
	xinmo={ --心魔
		state_weak_attackrate={{{1,10},{20,100}}},
		state_stun_resistrate={{{1,10},{10,100},{20,150}}},
		attackspeed_v={{{1,10},{10,16},{20,26},{23,29},{24,29}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	xinyan={ --心眼
		skilldamageptrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		skillselfdamagetrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		state_weak_attacktime={{{1,10},{10,80}}},
		state_stun_resisttime={{{1,10},{10,120}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	
	mantianhuayu={ --中级秘籍：漫天花雨
		addenchant={2, {{1,1}, {2, 2}}},
		skill_skillexp_v=FightSkill.tbParam.tbMidBookSkillExp,
		skill_statetime={{{1,-1},{2,-1}}},
	},

	qijueshaguang={ --七绝煞光
		autoskill={{{1,34},{2,34}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	qijueshaguang_child={ --七绝煞光子
		deadlystrikeenhance_r={{{1,50},{10,175},{11,184}}},
		state_hurt_attackrate={{{1,10},{10,100},{11,105}}},
		attackspeed_v={{{1,10},{10,10}}},
		skill_statetime={{{1,18*5},{10,18*10},{11,18*11}}},
	},
	
	xiujianadvancedbook={ --袖箭高级秘籍
		appenddamage_p={{{1,150*0.7},{10,150},{12,165}}},
		poisondamage_v={{{1,150*0.7},{10,150},{12,165}},{{1,9*9},{20,9*9}}},
		seriesdamage_r={{{1,250},{20,250}}},
		state_fixed_attack={{{1,25},{10,85},{13,90}},{{1,3*18},{10,3*18}}},
		addmagicbydist={{{1,5},{10,5}},{{1,3*18*22},{10,3*18*22}},{{1,2500},{10,2500}}},
		missile_hitcount={{{1,3},{2,3}}},
		skill_cost_v={{{1,100},{20,100}}},
		skill_mintimepercast_v={{{1,10*18},{10,10*18}}},
		skill_mintimepercastonhorse_v={{{1,10*18},{10,10*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	xiujian120={ --袖箭120_10
		appenddamage_p={{{1,100*0.7},{10,100},{11,100*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,100*0.7},{10,100},{11,100*FightSkill.tbParam.nSadd}},{{1,9*9},{20,9*9}}},
		autoskill={{{1,55},{2,55}},{{1,1},{10,10}}},
		seriesdamage_r={{{1,250},{10,250}}},
		skill_cost_v={{{1,150},{10,150}}},
		skill_statetime={{{1,18*30},{10,18*30}}},
		skill_mintimepercast_v={{{1,18*6},{10,18*6}}},
		skill_mintimepercastonhorse_v={{{1,18*6},{10,18*6}}},
		removestate={{{1,1292},{2,1292}}},--必须开始时清除目标已有的减少受到伤害效果,否则重复释放对方防御会变高
	},
	xiujian120_child={ --袖箭120_10
		superposemagic={{{1,5},{10,5}}},
		skill_statetime={{{1,18*6},{10,18*6}}},
	},
}

FightSkill:AddMagicData(tb)

local tbSkill	= FightSkill:GetClass("miyingzong");

function tbSkill:GetParamDesc(tbMsg, nParam1, nParam2, tbInfo)
	tbMsg[#tbMsg+1]	= string.format("Cự ly di chuyển tối đa: <color=gold>%d<color>", nParam1);
end;

local tbSkill	= FightSkill:GetClass("duanjinren");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg	= string.format("\n<color=green>Chiêu thức con<color>\nTrúng chí mạng thi triển: <color=gold>%d%%<color>\nGây bất động: <color=gold>%d%%<color>, duy trì <color=gold>%s giây<color>\nGiãn cách thi triển: <color=Gold>%s giây<color>",
		tbAutoInfo.nPercent,
		tbChildInfo.tbWholeMagic["state_fixed_attack"][1],
		FightSkill:Frame2Sec(tbChildInfo.tbWholeMagic["state_fixed_attack"][2]),
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("qijueshaguang");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg	= string.format("Đánh chí mạng: <color=gold>%d<color>\nTốc độ đánh ngoại công: <color=gold>%s<color>\nGây sát thương: <color=gold>%s<color>\nDuy trì: <color=Gold>%s giây<color>\nGiãn cách thi triển: <color=Gold>%s giây<color>",
		tbChildInfo.tbWholeMagic["deadlystrikeenhance_r"][1],
		tbChildInfo.tbWholeMagic["attackspeed_v"][1],
		tbChildInfo.tbWholeMagic["state_hurt_attackrate"][1],
		FightSkill:Frame2Sec(tbChildInfo.nStateTime),
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("xiujian120");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg	= string.format("<color=red>Mỗi<color> <color=gold>%s<color> <color=red>giây giảm<color> <color=gold>20%%<color>",
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime));
	return szMsg;
end;
