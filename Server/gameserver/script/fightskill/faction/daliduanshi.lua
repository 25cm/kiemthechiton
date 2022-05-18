Require("\\script\\fightskill\\fightskill.lua")
local tb	= {
	shenzhidianxue={ --神指点穴_20
		appenddamage_p= {{{1,90},{20,90},{21,90*FightSkill.tbParam.nSadd1}}},
		seriesdamage_r={{{1,50},{20,100},{21,100}}},
		physicsenhance_p={{{1,5},{10,50},{20,70},{21,70*FightSkill.tbParam.nSadd1}}},
		colddamage_v={
			[1]={{1,20*0.9},{10,150*0.9},{20,230*0.9},{21,230*FightSkill.tbParam.nSadd1*0.9}},
			[3]={{1,20*1.1},{10,150*1.1},{20,230*1.1},{21,230*FightSkill.tbParam.nSadd1*1.1}}
		},
		state_hurt_attack={{{1,15},{20,35},{21,36}},{{1,18},{20,18}}},
		state_slowall_attack={{{1,15},{10,30},{20,35},{21,36}},{{1,18},{20,36},{21,36}}},
		skill_cost_v={{{1,2},{20,20},{21,21}}},
		addskilldamagep={217, {{1,2},{20,30},{21,31}},1},
		addskilldamagep2={218, {{1,2},{20,30},{21,35}}},
		addskilldamagep3={223, {{1,2},{20,10},{21,12}},1},
		addskilldamagep4={224, {{1,2},{20,10},{21,12}}},
	},
	duanshizhifa={ --段氏指法_10
		addphysicsdamage_p={{{1,10},{10,150},{11,165}}},
		attackratingenhance_p={{{1,50},{10,150},{11,165}}},
		deadlystrikeenhance_r={{{1,30},{10,50},{11,55}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	yiyangzhi={ --一阳指_10
		state_fixed_attack={{{1,50},{10,85},{13,95}},{{1,18*3},{10,18*3.5},{13,18*4.5}}},
		skill_cost_v={{{1,20},{10,50},{11,50}}},
		skill_attackradius={600},
		skill_mintimepercast_v={18*10},
		missile_speed_v={200},
	},
	yizhiqiankun={ --一指乾坤_20
		appenddamage_p= {{{1,50},{20,50},{21,50*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,50},{10,95},{20,145},{21,145*FightSkill.tbParam.nSadd1}}},
		colddamage_v={
			[1]={{1,600*0.95},{10,780*0.95},{20,890*0.95},{21,890*FightSkill.tbParam.nSadd1*0.95}},
			[3]={{1,600*1.05},{10,780*1.05},{20,890*1.05},{21,890*FightSkill.tbParam.nSadd1*1.05}}
		},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_hurt_attack={{{1,15},{10,30},{20,35},{21,36}},{{1,18},{20,18}}},
		state_slowall_attack={{{1,20},{10,30},{20,35},{21,36}},{{1,18},{20,36}}},
		skill_cost_v={{{1,20},{20,50},{21,50}}},
		addskilldamagep={223, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={224, {{1,2},{20,30},{21,35}}},
	},
	lingboweibu={ --凌波微步_20
		fastwalkrun_p={{{1,40},{20,100},{21,110}}},
		ignoreskill={{{1,35},{10,75},{20,95},{21,96},{22,96},{23,97}},0,{{1,3},{2,3}}},
		state_knock_resistrate={{{1,100},{20,1000},{20,1050}}},
		skill_cost_v={{{1,100},{10,150},{20,300},{21,300}}},
		skill_statetime={{{1,18*5},{20,18*15},{21,18*16}}},
		skill_mintimepercast_v={{{1,20*18},{20,45*18},{21,45*18}}},--ok
		skill_mintimepercastonhorse_v={{{1,20*18},{20,45*18},{21,45*18}}},--ok
		movewithshadow={1},
	},
	cibeijue={ --慈悲诀_10
		autoskill={{{1,17},{2,17}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	shiyuanjue={ --弑元诀_20
		autoskill={{{1,1},{2,1}},{{1,1},{20,20}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	shiyuanjue_child1={ --弑元诀子
		attackratingenhance_p={{{1,-50},{10,-100},{20,-150},{22,-165}}},
		missile_hitcount={{{1,3},{10,4},{20,5},{21,5}}},
		skill_statetime={{{1,18*10},{20,18*15},{21,18*15}}},
	},
	shiyuanjue_child2={ --弑元诀子子
		state_stun_attack={{{1,50},{10,60},{20,70},{23,80}},{{1,18*2},{10,18*3},{20,18*3.5},{21,18*3.8}}},
		missile_hitcount={{{1,3},{10,4},{20,5},{21,5}}},
	},
	shiyuanjue_child3={ --弑元诀子子子
		state_hurt_ignore={1},
		state_slowall_ignore={1},
		state_fixed_ignore={1},
		state_palsy_ignore={1},
		state_confuse_ignore={1},
		skill_statetime={{{1,18*1.5},{10,18*3},{20,18*4},{21,18*5},{22,18*5}}},
	},
	qianyangshenzhi={ --乾阳神指_20
		appenddamage_p= {{{1,65*FightSkill.tbParam.nS1},{10,75},{20,75*FightSkill.tbParam.nS20},{21,75*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,100*FightSkill.tbParam.nS1},{10,100},{20,100*FightSkill.tbParam.nS20},{21,100*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		colddamage_v={
			[1]={{1,550*0.9*FightSkill.tbParam.nS1},{10,550*0.9},{20,550*0.9*FightSkill.tbParam.nS20},{21,550*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,550*1.1*FightSkill.tbParam.nS1},{10,550*1.1},{20,550*1.1*FightSkill.tbParam.nS20},{21,550*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,45},{20,90},{21,90}}},
		state_hurt_attack={{{1,7},{10,20},{20,25}},{{1,18},{20,18}}},
		state_slowall_attack={{{1,7},{10,20},{20,25}},{{1,18},{20,36},{21,36}}},
		missile_hitcount={{{1,5},{20,5}}},
	},
	jinyuzhifa={ --金玉指法_20
		state_slowall_attackrate={{{1,10},{20,100}}},
		state_burn_resistrate={{{1,10},{10,100},{20,150}}},
		damage_return_receive_p={{{1,-10},{10,-15},{20,-23}}},
		ignoredefenseenhance_v={{{1,50},{20,180},{21,187}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	qiantianzhifa={ --乾天指法
		skilldamageptrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		skillselfdamagetrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		state_slowall_attacktime={{{1,10},{10,80}}},
		state_burn_resisttime={{{1,10},{10,120}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},

	baibuchuanyang={ --中级秘籍：百步穿杨
		fastwalkrun_p={{{1,10},{10,30},{11,30}}},
		addenchant={17, {{1,1}, {2, 2}}},
		decautoskillcdtime={220, 1, {{1,18*6}, {10, 18*15}, {11, 18*16}}},
		skill_skillexp_v=FightSkill.tbParam.tbMidBookSkillExp,
		skill_statetime={{{1,-1},{2,-1}}},
	},
	
	miaodizhi={ --妙谛指_10
		addstartskill={216, 1184, {{1,1}, {10, 10}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	miaodizhiqi={ --妙谛指气
		deadlystrikedamageenhance_p={{{1,3},{10,30},{11,33}}},
		deadlystrikeenhance_r={{{1,150},{10,275},{11,289}}},
		skilldamageptrim={{{1,3},{10,30}}},
		skillselfdamagetrim={{{1,3},{10,30}}},
		skill_statetime={{{1,18*6.5},{10,18*6.5}}},
	},
	zhiduanadvancedbook={ --指段高级秘籍
		appenddamage_p= {{{1,65*0.7},{10,65}}},
		physicsenhance_p={{{1,100*0.7},{10,100}}},
		colddamage_v={
			[1]={{1,550*0.9*0.7},{10,550*0.9}},
			[3]={{1,550*1.1*0.7},{10,550*1.1}}
			},
		seriesdamage_r={{{1,250},{10,250}}},
		skill_cost_v={{{1,200},{10,200}}},
		state_slowall_attack={{{1,5},{10,50}},{{1,45},{10,45}}},
		missile_hitcount={{{1,3},{10,3}}},
		skill_mintimepercast_v={{{1,45*18},{10,45*18}}},
		skill_mintimepercastonhorse_v={{{1,45*18},{10,45*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	zhiduan120={ --指段120_10
		appenddamage_p= {{{1,75*FightSkill.tbParam.nS1},{10,75*FightSkill.tbParam.nS20},{11,75*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,100*FightSkill.tbParam.nS1},{10,100*FightSkill.tbParam.nS20},{11,100*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		colddamage_v={
			[1]={{1,650*0.9*FightSkill.tbParam.nS1},{10,650*0.9*FightSkill.tbParam.nS20},{11,650*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,650*1.1*FightSkill.tbParam.nS1},{10,650*1.1*FightSkill.tbParam.nS20},{11,650*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		seriesdamage_r={{{1,100},{10,250},{11,250}}},
		skill_cost_v={{{1,45},{10,90},{11,90}}},
		state_hurt_attack={{{1,7},{10,35}},{{1,18},{10,18}}},
		state_slowall_attack={{{1,7},{10,35}},{{1,18},{10,36},{11,36}}},
		missile_hitcount={{{1,5},{10,5}}},
		skill_statetime={{{1,18*2},{10,18*4},{11,18*4.5}}},
		skill_mintimepercast_v={{{1,15*18},{10,10*18},{11,9.5*18}}},--ok
		skill_mintimepercastonhorse_v={{{1,15*18},{10,10*18},{11,9.5*18}}},--ok
	},

	fengyunbianhuan={ --风云变幻_20
		appenddamage_p= {{{1,100},{10,118},{20,128},{21,128*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,30*0.9},{10,345*0.9},{20,545*0.9},{21,545*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,30*1.1},{10,345*1.1},{20,545*1.1},{21,545*FightSkill.tbParam.nSadd*1.1}}
		},
		state_slowall_attack={{{1,15},{10,45},{20,50},{21,51}},{{1,45},{20,45}}},
		seriesdamage_r={{{1,50},{20,100},{21,100}}},
		skill_cost_v={{{1,10},{20,50},{21,50}}},
		addskilldamagep={229, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={232, {{1,2},{20,10},{21,12}},1},
		addskilldamagep3={869, {{1,2},{20,10},{21,12}}},
		addskilldamagep4={870, {{1,2},{20,10},{21,12}}},
		addskilldamagep5={871, {{1,2},{20,10},{21,12}}},
		addskilldamagep6={872, {{1,2},{20,10},{21,12}}},
		missile_range={1,0,1},
	},
	duanshixinfa={ --段氏心法_10
		deadlystrikedamageenhance_p={{{1,3},{10,30},{11,33}}},
		addcoldmagic_v={{{1,20},{10,400},{11,440}}},
		deadlystrikeenhance_r={{{1,30},{10,50},{11,55}}},
		castspeed_v={{{1,5},{10,15},{11,16},{12,17},{13,17}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	beimingshengong={ --北冥神功_10
		dynamicmagicshield_v={{{1,50},{10,180},{11,189}},30},
		state_palsy_resistrate={{{1,100},{10,1000},{11,1050}}},
		state_confuse_resistrate={{{1,100},{10,1000},{11,1050}}},
		state_knock_resistrate={{{1,100},{10,1000},{11,1050}}},
		state_drag_resistrate={{{1,100},{10,1000},{11,1050}}},
	},
	beimingshengong_team={ --北冥神功_队友
		dynamicmagicshield_v={{{1,30},{10,90},{12,99}},30},
	},
	jinyumantang={ --金玉满堂_20
		appenddamage_p= {{{1,50},{10,60},{20,65},{21,65*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,500*0.9},{10,680*0.9},{20,780*0.9},{21,780*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,500*1.1},{10,680*1.1},{20,780*1.1},{21,780*FightSkill.tbParam.nSadd*1.1}}
		},
		state_slowall_attack={{{1,15},{10,45},{20,50},{21,51}},{{1,45},{20,45}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,50},{20,150},{21,150}}},
		addskilldamagep={232, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={868, {{1,2},{20,30},{21,35}}},
		addskilldamagep3={869, {{1,2},{20,30},{21,35}}},
		addskilldamagep4={870, {{1,2},{20,30},{21,35}}},
		addskilldamagep5={871, {{1,2},{20,30},{21,35}}},
		addskilldamagep6={872, {{1,2},{20,30},{21,35}}},
		missile_hitcount={{{1,4},{2,4}}},
		skill_missilenum_v={{{1,2},{10,3},{15,4},{20,5},{21,5}},1},
		missile_speed_v={40},
	},
	tiannanbufa={ --天南步法_20
		fastwalkrun_p={{{1,10},{20,40},{21,41}}},
		state_burn_resisttime={{{1,10},{20,135},{21,141}}},
		skill_cost_v={{{1,100},{10,250},{20,300},{21,300}}},
		skill_statetime={{{1,18*180},{20,18*300},{21,18*310}}},
	},
	liujianqifa={ --六剑齐发
		autoskill={{{1,18},{2,18}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	liujianqifa_child={ --六剑齐发_10
		appenddamage_p= {{{1,50},{10,65},{21,65}}},
		colddamage_v={
			[1]={{1,600*0.9},{10,816*0.9},{11,856*0.9}},
			[3]={{1,600*1.1},{10,816*1.1},{11,856*1.1}}
		},
		steallife_p={{{1,100},{10,100}},{{1,100},{10,100}}},
		seriesdamage_r={{{1,100},{10,250},{11,250}}},
	},
	kurongchangong={ --枯荣禅功	_20
		addcoldmagic_v={{{1,100},{20,600},{21,630}}},
		castspeed_v={{{1,10},{20,30},{21,30}}},
		autoskill={{{1,8},{2,8}},{{1,1},{20,20}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	kurongchangong_child={ --枯荣禅功子
		addcoldmagic_v={{{1,-100},{20,-350},{21,-350}}},
		castspeed_v={{{1,-10},{20,-20},{21,-20}}},
		fastlifereplenish_v={{{1,50},{20,400},{21,420}}},
		damage_physics_resist={{{1,30},{10,60},{20,80},{21,84}}},
		damage_poison_resist={{{1,30},{10,60},{20,80},{21,84}}},
		damage_cold_resist={{{1,30},{10,60},{20,80},{21,84}}},
		damage_fire_resist={{{1,30},{10,60},{20,80},{21,84}}},
		skill_statetime={{{1,18*5},{20,18*10},{21,10.5*18}}},
	},
	liumaishenjian={ --六脉神剑主_伤
		appenddamage_p= {{{1,30*FightSkill.tbParam.nS1},{10,30},{20,30*FightSkill.tbParam.nS20},{21,30*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,475*0.9*FightSkill.tbParam.nS1},{10,475*0.9},{20,475*0.9*FightSkill.tbParam.nS20},{21,475*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,475*1.1*FightSkill.tbParam.nS1},{10,475*1.1},{20,475*1.1*FightSkill.tbParam.nS20},{21,475*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_hurt_attack={{{1,5},{10,10},{20,15}},{{1,18},{20,18}}},
		missile_hitcount={{{1,4},{2,4}}},
	},
	liumaishenjian_child={ --六脉神剑_减攻速_作废
		castspeed_v={{{1,-90},{2,-90}}},
		skill_statetime={{{1,18*2},{2,18*2}}},
	},
	liumaishenjian_child1={ --六脉神剑子1_灼
		state_burn_attack={{{1,5},{20,10}},{{1,36},{20,54},{21,54}}},
		missile_hitcount={{{1,4},{2,4}}},
	},
	liumaishenjian_child2={ --六脉神剑子2_缓
		appenddamage_p= {{{1,30*FightSkill.tbParam.nS1},{10,30},{20,30*FightSkill.tbParam.nS20},{21,30*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,475*0.9*FightSkill.tbParam.nS1},{10,475*0.9},{20,475*0.9*FightSkill.tbParam.nS20},{21,475*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,475*1.1*FightSkill.tbParam.nS1},{10,475*1.1},{20,475*1.1*FightSkill.tbParam.nS20},{21,475*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_slowall_attack={{{1,15},{10,45},{20,50}},{{1,45},{20,45}}},
		missile_hitcount={{{1,4},{2,4}}},
	},
	liumaishenjian_child3={ --六脉神剑子3_弱
		state_weak_attack={{{1,5},{20,10}},{{1,36},{20,54},{21,54}}},
		missile_hitcount={{{1,4},{2,4}}},
	},
	liumaishenjian_child4={ --六脉神剑子4_晕
		state_stun_attack={{{1,5},{20,10}},{{1,18},{20,18}}},
		missile_hitcount={{{1,4},{2,4}}},
	},
	liumaishenjian_child5={ --六脉神剑子5_攻击
		appenddamage_p= {{{1,30*1.28*FightSkill.tbParam.nS1},{10,30*1.28},{20,30*1.28*FightSkill.tbParam.nS20},{21,30*1.28*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,475*1.28*0.9*FightSkill.tbParam.nS1},{10,475*1.28*0.9},{20,475*1.28*0.9*FightSkill.tbParam.nS20},{21,475*1.28*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,475*1.28*1.1*FightSkill.tbParam.nS1},{10,475*1.28*1.1},{20,475*1.28*1.1*FightSkill.tbParam.nS20},{21,475*1.28*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		missile_hitcount={{{1,4},{2,4}}},
	},
	tianlongshengong={ --天龙神功_20
		state_slowall_attackrate={{{1,10},{20,100}}},
		state_burn_resistrate={{{1,10},{10,100},{20,150}}},
		castspeed_v={{{1,10},{10,16},{20,26},{23,29},{24,29}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	duanjiaqijian={ --段家气剑
		skilldamageptrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		skillselfdamagetrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		state_slowall_attacktime={{{1,10},{10,80}}},
		state_burn_resisttime={{{1,10},{10,120}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	
	baihongguanri={ --中级秘籍：白虹贯日
		addenchant={18, {{1,1}, {2, 2}}},
		addpowerwhencol={229, {{1,50}, {10, 50}, {12, 55}}, {{1,50}, {10, 150}, {12, 165}}},
		skill_skillexp_v=FightSkill.tbParam.tbMidBookSkillExp,
		skill_statetime={{{1,-1},{2,-1}}},
	},
	
	jingtianyijian={ --惊天一剑_10
		state_knock_attack={{{1,65},{10,100},{11,100}},{{1,2},{10,2},{11,2}},{{1,32},{2,32}}},
		state_slowall_attack={{{1,65},{10,100},{11,100}},{{1,36},{10,72},{11,72}}},
		skill_mintimepercast_v={{{1,30*18},{10,30*18},{11,29*18}}},
		skill_mintimepercastonhorse_v={{{1,30*18},{10,30*18},{11,29*18}}},
	},
	qiduanadvancedbook={ --气段高级秘籍_炼气还神_10
		lifemax_p={{{1,6},{10,90},{11,93}}},
		fastwalkrun_p={{{1,1},{10,10},{11,10}}},
		adddefense_v={{{1,20},{10,200},{11,210}}},
		autoskill={{{1,49},{2,49}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{2,-1}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	qiduanadvancedbook_child2={ --气段高级秘籍_炼气还神_子2_10
		state_slowall_attacktime={{{1,10},{10,100},{11,105}}},
		deadlystrikeenhance_r={{{1,10},{10,100},{11,105}}},
		superposemagic={{{1,1},{10,5},{11,5}}},
		skill_statetime={{{1,22*18},{2,22*18}}},
	},
	qiduan120={ --气段120_9_注意,最高等级9级
		appenddamage_p= {{{1,2.2*25*0.7},{9,2.2*25*0.7},{10,2.2*25*0.7*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,2.2*250*0.9*0.7},{9,2.2*250*0.9},{10,2.2*250*0.9*FightSkill.tbParam.nSadd}},
			[3]={{1,2.2*250*1.1*0.7},{9,2.2*250*1.1},{10,2.2*250*1.1*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,250},{10,250}}},
		skill_cost_v={{{1,300},{10,300}}},
		state_slowall_attack={{{1,45},{9,50}},{{1,45},{9,45}}},
		missile_hitcount={{{1,4},{2,4}}},
		skill_appendskill={{{1,226},{10,226}},{{1,1},{9,20},{10,21}}},
		skill_appendskill2={{{1,232},{9,232}},{{1,1},{9,20},{10,21}}},
		skill_mintimepercast_v={{{1,5*18},{10,5*18}}},
		skill_mintimepercastonhorse_v={{{1,5*18},{10,5*18}}},
	},
	qiduan120_2={ --气段120_附属技能_1
		changecdtype={{{1,866},{10,866}},{{1,1300},{10,1300}},{{1,100},{10,100}}},
		autoskill={{{1,67},{2,67}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	qiduan120_2_child={ --气段120_附属技能_触发回复使用次数_10
		recover_usepoint={{{1,866},{10,866}},{{1,100},{10,100}}},
	},
	
}

FightSkill:AddMagicData(tb)

local tbSkill	= FightSkill:GetClass("shiyuanjue");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbCCInfo	= KFightSkill.GetSkillInfo(tbChildInfo.tbEvent.nStartSkillId, tbChildInfo.tbEvent.nLevel);
	local tbCCInfo2	= KFightSkill.GetSkillInfo(tbCCInfo.tbEvent.nStartSkillId, tbCCInfo.tbEvent.nLevel);
	local nPerCastTime = (tbAutoInfo.nPerCastTime - KFightSkill.GetAutoSkillCDTimeAddition(tbSkillInfo.nId, tbAutoInfo.nId));
	local szMsg	= string.format("Lúc bị đánh trúng thi triển: <color=gold>%d%%<color>\nẢnh hưởng tối đa: <color=gold>%d<color>\nChính xác của đối phương xung quanh <color=gold>-%d%%<color>, duy trì <color=Gold>%s giây<color>\nGây choáng xung quanh: <color=gold>%d%%<color>, duy trì <color=gold>%s giây<color>\nMiễn dịch sát thương, làm chậm, bất động, hỗn loạn, tê liệt, duy trì <color=gold>%s giây<color>\nGiãn cách thi triển: <color=Gold>%s giây<color>",
		tbAutoInfo.nPercent,
		tbChildInfo.nMissileHitcount,
		-tbChildInfo.tbWholeMagic["attackratingenhance_p"][1],
		FightSkill:Frame2Sec(tbChildInfo.nStateTime),
		tbCCInfo.tbWholeMagic["state_stun_attack"][1],
		FightSkill:Frame2Sec(tbCCInfo.tbWholeMagic["state_stun_attack"][2]),
		FightSkill:Frame2Sec(tbCCInfo2.nStateTime),
		FightSkill:Frame2Sec(nPerCastTime));
	return szMsg;
end;


local tbSkill	= FightSkill:GetClass("kurongchangong");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};
	local szMsg = ""
	szMsg = szMsg.."\nSinh lực giảm còn 25% tự động thi triển:\n";
	szMsg = szMsg.."    <color=green>Khô Thiền<color>\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	szMsg = szMsg.."\nGiãn cách thi triển: <color=Gold>"..FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime).." giây<color>";
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("cibeijue");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};
	local szMsg = ""
	szMsg = szMsg.."Sinh lực giảm còn 25% <color=gold>"..tbAutoInfo.nPercent.."%<color> tự động thi triển:\n";
	szMsg = szMsg.."    <color=green>Lăng Ba Vi Bộ<color>\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	szMsg = szMsg.."\nGiãn cách thi triển: <color=Gold>"..FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime).." giây<color>";
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("liujianqifa");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};
	local szMsg = ""
	szMsg = szMsg.."Sinh lực giảm còn 25% <color=gold>"..tbAutoInfo.nPercent.."%<color> tự động thi triển:\n";
	szMsg = szMsg.."    <color=green>Lục Kiếm Tề Phát<color>\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	szMsg = szMsg.."\nGiãn cách thi triển: <color=Gold>"..FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime).." giây<color>";
	return szMsg;
end;

local tbSkill = FightSkill:GetClass("liumaishenjian")

function tbSkill:GetExtraDesc(tbInfo)
	if (not tbInfo) then
		return "";
	end
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbInfo.nId, tbInfo.nLevel,me,1);
	local tbCCInfo1		= KFightSkill.GetSkillInfo(tbChildInfo.tbEvent.nStartSkillId, tbChildInfo.tbEvent.nLevel, me, 1)
	local tbCCInfo2		= KFightSkill.GetSkillInfo(tbCCInfo1.tbEvent.nStartSkillId, tbCCInfo1.tbEvent.nLevel, me, 1)
	local tbCCInfo3		= KFightSkill.GetSkillInfo(tbCCInfo2.tbEvent.nStartSkillId, tbCCInfo2.tbEvent.nLevel, me, 1);
	local tbCCInfo4		= KFightSkill.GetSkillInfo(tbCCInfo3.tbEvent.nStartSkillId, tbCCInfo3.tbEvent.nLevel, me, 1);
	local tbCCInfo5		= KFightSkill.GetSkillInfo(tbCCInfo4.tbEvent.nStartSkillId, tbChildInfo.tbEvent.nLevel);
	
	local szMsg	= string.format("<color=green>Trung Xung Kiếm<color>\nBăng công: <color=gold>%s đến %s điểm<color>\nLàm chậm: <color=gold>%d%%<color>, duy trì <color=gold>%s giây<color>\nLực tấn công cơ bản: <color=gold>%s%%<color>\n<color=green>Thiếu Trạch Kiếm<color>\nBăng công: <color=gold>%s đến %s điểm<color>\nLực tấn công cơ bản: <color=gold>%s%%<color>\n<color=green>Thương Dương Kiếm<color>\nLàm bỏng: <color=gold>%d%%<color>, duy trì <color=gold>%s giây<color>\n<color=green>Quan Xung Kiếm<color>\nLàm suy yếu: <color=gold>%d%%<color>, duy trì <color=gold>%s giây<color>\n<color=green>Thiếu Xung Kiếm<color>\nGây choáng: <color=gold>%d%%<color>, duy trì <color=gold>%s giây<color>",
		
	tbCCInfo2.tbWholeMagic["colddamage_v"][1],
	tbCCInfo2.tbWholeMagic["colddamage_v"][3],
	tbCCInfo2.tbWholeMagic["state_slowall_attack"][1],
	FightSkill:Frame2Sec(tbCCInfo2.tbWholeMagic["state_slowall_attack"][2]),
	tbCCInfo2.nAppenDamageP,

	tbCCInfo5.tbWholeMagic["colddamage_v"][1],
	tbCCInfo5.tbWholeMagic["colddamage_v"][3],
	tbCCInfo5.nAppenDamageP,
		
	tbCCInfo1.tbWholeMagic["state_burn_attack"][1],
	FightSkill:Frame2Sec(tbCCInfo1.tbWholeMagic["state_burn_attack"][2]),
	
	tbCCInfo3.tbWholeMagic["state_weak_attack"][1],
	FightSkill:Frame2Sec(tbCCInfo3.tbWholeMagic["state_weak_attack"][2]),
		
	tbCCInfo4.tbWholeMagic["state_stun_attack"][1],
	FightSkill:Frame2Sec(tbCCInfo4.tbWholeMagic["state_stun_attack"][2]));
	return szMsg;
end

local tbSkill	= FightSkill:GetClass("qiduanadvancedbook");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbChildInfo2		= KFightSkill.GetSkillInfo(tbChildInfo.tbEvent.nVanishedSkillId, tbChildInfo.tbEvent.nLevel, me, 1)
	local szMsg	= string.format("Mỗi <color=gold>%d giây<color> ở vị trí hiện tại sinh ra khí trường hút chân khí, sau <color=gold>5 giây<color> ngưng tụ tạo thành <color=gold>nguyên khí<color> duy trì trong <color=gold>5 giây<color>, nếu bản thân tiếp xúc <color=gold>nguyên khí<color> sẽ nhận được trạng thái <color=gold>Luyện Thần Hoàn Hư<color>:\n    Thời gian làm chậm: <color=gold>+%d<color>\n    Tấn công chí mạng: <color=gold>+%d<color>\n    Cộng dồn tối đa: <color=gold>%s lần<color>\n    Thời gian duy trì <color=gold>%s giây<color>",
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime),
		tbChildInfo2.tbWholeMagic["state_slowall_attacktime"][1],
		tbChildInfo2.tbWholeMagic["deadlystrikeenhance_r"][1],
		tbChildInfo2.tbWholeMagic["superposemagic"][1],
		FightSkill:Frame2Sec(tbChildInfo2.nStateTime)
		);
	return szMsg;
end;
local tbSkill	= FightSkill:GetClass("zhiduan120");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};
	local szMsg = ""
	szMsg = szMsg.."<color=green>[Nhất Dương Chỉ]<color> chính xác giúp <color=green>[Huyền Băng Cửu Kiếp]<color> hồi <color=gold>"..(tbChildInfo.tbWholeMagic["recover_usepoint"][2]/100).."<color>"
	return szMsg;
end;
local tbSkill	= FightSkill:GetClass("qiduan120_2");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};
	local szMsg = ""
	szMsg = szMsg.."Đánh chính xác <color=gold>"..tbAutoInfo.nPercent.."%<color> giúp <color=green>[Sơ Ảnh]<color> hồi <color=gold>1<color>"
	return szMsg;
end;

