
local tb = {
	 conlondao150={ --????_20
		appenddamage_p= {{{1,57},{2,64}}},
		physicsenhance_p={{{1,64},{2,78}}},
		lightingdamage_v={
			[1]={{1,500*0.9*FightSkill.tbParam.nS1},{10,500*0.9},{20,500*0.9*FightSkill.tbParam.nS20},{21,500*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,525*1.1*FightSkill.tbParam.nS1},{10,525*1.1},{20,525*1.1*FightSkill.tbParam.nS20},{21,525*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		skill_cost_v={{{1,100},{20,100},{21,105}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		state_stun_attack={{{1,17},{2,27}},{{1,0.5*18},{20,1*18}}},
		state_hurt_attack={{{1,21},{2,22}},{{1,1*18},{20,2*18}}},
		state_stun_attacktime={{{1,110},{2,120}}},
		state_hurt_attacktime={{{1,110},{2,120}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	conlondao150_child={ --?????
		appenddamage_p= {{{1,30*FightSkill.tbParam.nS1},{10,30},{20,30*FightSkill.tbParam.nS20},{21,30*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,45*FightSkill.tbParam.nS1},{10,45},{20,45*FightSkill.tbParam.nS20},{21,45*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={ 
			[1]={{1,350*0.9*FightSkill.tbParam.nS1},{10,350*0.9},{20,350*0.9*FightSkill.tbParam.nS20},{21,350*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,375*1.1*FightSkill.tbParam.nS1},{10,375*1.1},{20,375*1.1*FightSkill.tbParam.nS20},{21,375*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		state_hurt_attack={{{1,21},{2,22}},{{1,36},{2,36}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		missile_speed_v={30},
		missile_range={1,0,1},
	},
	conlondao150_child2={ 
		appenddamage_p= {{{1,20*FightSkill.tbParam.nS1},{10,20},{20,20*FightSkill.tbParam.nS20},{21,20*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,30*FightSkill.tbParam.nS1},{10,30},{20,30*FightSkill.tbParam.nS20},{21,30*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={
			[1]={{1,250*0.9*FightSkill.tbParam.nS1},{10,250*0.9},{20,250*0.9*FightSkill.tbParam.nS20},{21,250*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,250*1.1*FightSkill.tbParam.nS1},{10,250*1.1},{20,250*1.1*FightSkill.tbParam.nS20},{21,250*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		missile_hitcount={{{1,2},{10,3},{20,3}}},
	},
	  conlonkiem150={ --雷动九天
		appenddamage_p= {{{1,150*FightSkill.tbParam.nS1},{10,175},{20,200*FightSkill.tbParam.nS20},{21,203*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={ 
			[1]={{1,2250*0.9*FightSkill.tbParam.nS1},{10,2250*0.9},{20,2250*0.9*FightSkill.tbParam.nS20},{21,2250*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,2360*1.1*FightSkill.tbParam.nS1},{10,2510*1.1},{20,2710*1.1*FightSkill.tbParam.nS20},{21,2715*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,410},{21,410}}},
		state_stun_attack={{{1,15},{10,40},{20,50}},{{1,36},{20,36}}},
		skill_cost_v={{{1,150},{20,300},{21,300}}},
		--skill_mintimepercast_v={{{1,3*18},{10,3*18}}},
		missile_hitcount={{{1,5},{10,7},{20,9},{21,9}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},
	conlonkiem150_child={
		appenddamage_p= {{{1,90},{20,120},{21,123*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={
			[1]={{1,800*0.9},{10,1115*0.9},{20,1465*0.9},{21,1550*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,835*1.1},{10,1210*1.1},{20,1480*1.1},{21,1570*FightSkill.tbParam.nSadd*1.1}}
		},
		state_stun_attack={{{1,15},{10,40},{20,55}},{{1,3*18},{20,3*18}}},
		missile_hitcount={{{1,6},{10,6},{20,9}}},
		seriesdamage_r={{{1,100},{20,300},{21,310}}},
		missile_range={4,0,4},
	},
	   vokhi150={ --????
		appenddamage_p= {{{1,30},{2,33}}},
		lightingdamage_v={
			[1]={{1,1174*0.9*FightSkill.tbParam.nS1},{10,1174*0.9},{20,1200*0.9*FightSkill.tbParam.nS20},{21,1200*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,1174*1.1*FightSkill.tbParam.nS1},{10,1174*1.1},{20,1200*1.1*FightSkill.tbParam.nS20},{21,1200*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_stun_attack={{{1,31},{2,32}},{{1,2*18},{20,2*18}}},
		state_stun_attacktime={{{1,110},{2,120}}},
		--steallifeenhance_p={{{1,0.25},{2,0.5}},{{1,100},{10,100}}},
		--stealmanaenhance_p={{{1,0.25},{2,0.5}},{{1,100},{10,100}}},
		missile_hitcount={{{1,5},{5,6},{10,8},{15,9},{20,10},{21,10}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	 vokiem150={ --????
		appenddamage_p= {{{1,40*FightSkill.tbParam.nS1},{10,45},{20,50*FightSkill.tbParam.nS20},{21,50*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,76*FightSkill.tbParam.nS1},{10,76},{20,76*FightSkill.tbParam.nS20},{21,76*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={
			[1]={{1,550*0.9*FightSkill.tbParam.nS1},{10,550*0.9},{20,550*0.9*FightSkill.tbParam.nS20},{21,550*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,550*1.1*FightSkill.tbParam.nS1},{10,550*1.1},{20,550*1.1*FightSkill.tbParam.nS20},{21,550*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_hurt_attack={{{1,11},{2,12}},{{1,2*18},{20,2*18}}},
		--steallifeenhance_p={{{1,0.25},{2,0.5}},{{1,100},{10,100}}},
		--stealmanaenhance_p={{{1,0.25},{2,0.5}},{{1,100},{10,100}}},
		state_stun_attack={{{1,17},{2,27}},{{1,4*18},{20,4*18}}},
		state_stun_attacktime={{{1,95},{2,105}}},
		skill_showevent={{{1,1},{20,1}}},
		missile_hitcount={{{1,3},{10,4},{20,5},{21,5}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	vokiem150_child={ --太极剑意，人剑合一第二式
		state_stun_attack={{{1,31},{2,40}},{{1,2*18},{20,2*18}}},
		missile_hitcount={{{1,3},{10,4},{20,5},{21,5}}},
	},
	  thuyyenkiem150={ --冰心仙子
			appenddamage_p= {{{1,50*FightSkill.tbParam.nS1},{10,50},{20,55*FightSkill.tbParam.nS20},{21,55*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,700},{2,740}},
			[3]={{1,720*1.1},{2,750*1.1}},
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		skill_flyevent={{{1,1965},{20,1965}},{{1,3},{2,3}}},
		state_slowall_attack={{{1,10},{10,24},{20,36}},{{1,27},{20,48},{21,48}}},
		skill_showevent={{{1,2},{20,2}}},
		missile_hitcount={{{1,5},{5,5},{10,6},{15,6},{20,7},{21,7}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	
	thuyyenkiem150ctcon={ --风雪冰天，冰心仙子第二式
		appenddamage_p= {{{1,10*FightSkill.tbParam.nS1},{10,10},{20,12*FightSkill.tbParam.nS20},{21,14*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,300*0.9*FightSkill.tbParam.nS1},{10,300*0.9},{20,310*0.9*FightSkill.tbParam.nS20},{21,310*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,300*1.1*FightSkill.tbParam.nS1},{10,300*1.1},{20,310*1.1*FightSkill.tbParam.nS20},{21,310*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_slowall_attack={{{1,22},{10,40},{20,61}},{{1,27},{20,54},{20,54}}},
		state_slowall_attacktime={{{1,100},{2,110}}},
		missile_hitcount={{{1,2},{10,3},{20,4},{21,4}}},
	},
	thuyyendao150={ --冰踪无影
		appenddamage_p= {{{1,30},{2,36}}},
		physicsenhance_p={{{1,91*FightSkill.tbParam.nS1},{10,91},{20,91*FightSkill.tbParam.nS20},{21,91*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},--Vật công %
		colddamage_v={
			[1]={{1,550*0.9*FightSkill.tbParam.nS1},{10,550*0.9},{20,550*0.9*FightSkill.tbParam.nS20},{21,550*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,550*1.1*FightSkill.tbParam.nS1},{10,550*1.1},{20,550*1.1*FightSkill.tbParam.nS20},{21,550*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_hurt_attack={{{1,16},{2,17}},{{1,18},{20,18}}},
		state_slowall_attacktime={{{1,100},{2,110}}},
		
		--skill_collideevent={{{1,1967},{20,1967}}},
		--deadlystrikedamageenhance_p={{{1,1*0.5},{2,1}}},
		--skill_showevent={{{1,4},{20,4}}},
		--missile_range={1,0,1},
		--skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	thuyyendao150ctcon={ --冰心雪莲，冰踪无影第二式
		--state_slowall_attack={{{1,10},{10,25},{20,35}},{{1,27},{20,45},{21,45}}},
		--missile_hitcount={{{1,2},{10,3},{20,4},{21,4}}},
	},
	    chidoan150={
		appenddamage_p= {{{1,20*FightSkill.tbParam.nS1},{10,25},{20,25*FightSkill.tbParam.nS20},{21,30*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,250*FightSkill.tbParam.nS1},{10,250},{20,250*FightSkill.tbParam.nS20},{21,250*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		colddamage_v={
			[1]={{1,3300*0.9*FightSkill.tbParam.nS1},{10,3300*0.9},{20,3300*0.9*FightSkill.tbParam.nS20},{21,3330*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,3300*1.1*FightSkill.tbParam.nS1},{10,3300*1.1},{20,3300*1.1*FightSkill.tbParam.nS20},{21,3330*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,45},{20,90},{21,90}}},
		state_hurt_attack={{{1,21},{2,22}},{{1,18},{10,2*18},{11,2*18}}},
		state_slowall_attack={{{1,21},{2,22}},{{1,18},{10,3*18},{11,5*18}}},
		state_hurt_attacktime={{{1,110},{2,120}}},
		state_slowall_attacktime={{{1,150},{2,200}}},
		missile_hitcount={{{1,5},{20,5}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	doanthikiem150={ --飞龙在天	
		appenddamage_p= {{{1,8},{2,10}}},
		colddamage_v={
			[1]={{1,300*0.8*FightSkill.tbParam.nS1},{10,300*0.8},{20,300*0.8*FightSkill.tbParam.nS20},{21,300*0.8*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,300*1.2*FightSkill.tbParam.nS1},{10,300*1.2},{20,300*1.1*FightSkill.tbParam.nS20},{21,300*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,100},{20,100},{21,100}}},
		state_burn_attack={{{1,5},{20,10}},{{1,18},{20,18},{21,18}}},
		state_slowall_attack={{{1,15},{10,45},{20,50}},{{1,45},{20,45}}},
		state_stun_attack={{{1,5},{20,10}},{{1,18},{20,18},{21,18}}},
		state_weak_attack={{{1,5},{20,10}},{{1,18},{20,18},{21,54}}},
		state_hurt_attack={{{1,5},{10,10},{20,15}},{{1,18},{20,18}}},
		skill_missilenum_v={{{1,4},{20,4}}},
		skill_vanishedevent={{{1,1969},{20,1969}}},
		skill_showevent={{{1,8},{20,8}}},
		missile_range={1,0,1},
		missile_speed_v={40},
		--skill_mintimepercast_v={{{1,0.4*18},{10,0.4*18},{20,0.4*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	doanthikiem150_child={ --龙战于野，飞龙在天第二式
		appenddamage_p= {{{1,10},{10,15},{20,17},{21,17}}},
		colddamage_v={
			[1]={{1,60*0.9*FightSkill.tbParam.nS1},{10,60*0.9},{20,60*0.9*FightSkill.tbParam.nS20},{21,60*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,65*1.1*FightSkill.tbParam.nS1},{10,65*1.1},{20,65*1.1*FightSkill.tbParam.nS20},{21,65*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,210},{21,210}}},
		missile_hitcount={{{1,2},{10,3},{20,4},{21,4}}},
		missile_missrate={{{1,70},{2,70}}},
		missile_range={5,0,5},
	},
	 ngamychuong150={ --????
		appenddamage_p= {{{1,73},{2,76}}},
		colddamage_v={
			[1]={{1,2000*0.9*FightSkill.tbParam.nS1},{10,2000*0.9},{20,2000*0.9*FightSkill.tbParam.nS20},{21,2000*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,2000*1.1*FightSkill.tbParam.nS1},{10,2000*1.1},{20,2000*1.1*FightSkill.tbParam.nS20},{21,2000*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,300},{21,310}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_slowall_attack={{{1,32},{2,34}},{{1,18},{20,3*18}}},
		state_slowall_attacktime={{{1,110},{2,120}}},
		skill_startevent={{{1,1963},{20,1963}}},
		skill_showevent={{{1,1},{20,1}}},
		missile_hitcount={{{1,5},{10,6},{20,7},{21,7}}},
		missile_range={9,0,9},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	ngamychuongctcon={ --????,???????
		appenddamage_p= {{{1,16*FightSkill.tbParam.nS1},{10,34},{20,58*FightSkill.tbParam.nS20},{21,60*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,1000*0.9*FightSkill.tbParam.nS1},{10,1000*0.9},{20,1000*0.9*FightSkill.tbParam.nS20},{21,1000*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,1010*1.1*FightSkill.tbParam.nS1},{10,1010*1.1},{20,1010*1.1*FightSkill.tbParam.nS20},{21,1010*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,410},{21,410}}},
		state_slowall_attack={{{1,5},{10,10},{20,15}},{{1,27},{20,45}}},
		state_hurt_attack={{{1,1},{2,2}},{{1,36},{20,36}}},
		missile_hitcount={{{1,6},{20,6}}},
		missile_range={1,0,1},
	},
	 ngamykiem150={ --剑影佛光_10
		appenddamage_p= {{{1,140*0.7},{10,140},{11,140*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,2500},{2,2570}},
			[3]={{1,2540*0.7*1.1},{10,2840*1.1},{11,2860*FightSkill.tbParam.nSadd*1.1}}},
		state_slowall_attack={{{1,32},{2,34}},{{1,2*18},{10,3*18},{11,3*18}}},
		state_slowall_attacktime={{{1,100},{2,110}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		state_fixed_attack={{{1,0.5},{2,1}},{{1,18*2},{2,18*2}}},
		missile_hitcount={{{1,7},{10,7},{11,7}}},
		skill_cost_v={{{1,100},{10,200},{11,200}}},
		--skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	ngamykiem150_child={ --剑影佛光_10
		state_knock_attack={{{1,16},{2,17}},{{1,3},{10,10},{20,10}},{{1,32},{2,32}}},
		state_slowall_attack={{{1,35},{10,65},{11,66}},{{1,45},{10,45},{11,45}}},
		lifemax_p={{{1,30},{20,100},{21,105}}},
		castspeed_v={{{1,10},{10,16},{20,26},{23,29},{24,29}}},
		skill_statetime={{{1,2*18},{20,5*18}}}
	},
	chiennhan150={ --断筋刃_10
		appenddamage_p= {{{1,95*FightSkill.tbParam.nS1},{10,95},{20,95*FightSkill.tbParam.nS20},{21,95*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}}, --Phát huy lực tấn công cơ bản
		physicsenhance_p={{{1,85},{2,90}}},
		firedamage_v={
			[1]={{1,975*0.9*FightSkill.tbParam.nS1},{10,975*0.9},{20,975*0.9*FightSkill.tbParam.nS20},{21,975*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,975*1.1*FightSkill.tbParam.nS1},{10,975*1.1},{20,975*1.1*FightSkill.tbParam.nS20},{21,975*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_hurt_attack={{{1,31},{2,32}},{{1,2*18},{20,2*18}}},
		state_hurt_attacktime={{{1,110},{2,120}}},
		state_burn_attack={{{1,36},{2,37}},{{1,18},{10,2*18},{20,4*18},{21,4*18}}},
		steallife_p={{{1,1},{20,10}},{{1,100},{20,100}}},
		stealmana_p={{{1,1},{20,10}},{{1,100},{20,100}}},
		missile_hitcount={{{1,3},{10,4},{20,5},{21,5}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	   manhan150={ --????
		appenddamage_p= {{{1,10},{2,11}}},
		firedamage_v={
			[1]={{1,300},{2,310}},
			[3]={{1,320},{2,330}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_burn_attack={{{1,14},{2,16}},{{1,18},{10,45},{11,45}}},
		state_burn_attacktime={{{1,50},{2,60}}},
		skill_vanishedevent={{{1,1973},{20,1973}}},
		skill_showevent={{{1,8},{20,8}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	manhan150ctcon={
		appenddamage_p= {{{1,12*FightSkill.tbParam.nS1},{10,12},{20,12*FightSkill.tbParam.nS20},{21,12*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,15*0.9*FightSkill.tbParam.nS1},{10,15*0.9},{20,15*0.9*FightSkill.tbParam.nS20},{21,15*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,15*1.1*FightSkill.tbParam.nS1},{10,15*1.1},{20,15*1.1*FightSkill.tbParam.nS20},{21,15*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		
	},
	  caibangr150={ --飞龙在天
		appenddamage_p= {{{1,15*FightSkill.tbParam.nS1},{10,15},{20,15*FightSkill.tbParam.nS20},{21,15*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}}, 
		firedamage_v={ 
			[1]={{1,305*0.9*FightSkill.tbParam.nS1},{10,305*0.9},{20,305*0.9*FightSkill.tbParam.nS20},{21,305*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,305*1.1*FightSkill.tbParam.nS1},{10,305*1.1},{20,305*1.1*FightSkill.tbParam.nS20},{21,305*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,410},{21,410}}}, 
		skill_cost_v={{{1,50},{20,50},{21,50}}}, 
		state_burn_attack={{{1,5},{10,10},{20,15}},{{1,36},{20,54},{21,54}}}, 
		skill_missilenum_v={{{1,4},{20,10},{30,10}}},
		skill_vanishedevent={{{1,135},{20,135}}},
		skill_showevent={{{1,8},{20,8}}},		
		missile_range={1,0,1},
		missile_speed_v={40},
		--skill_mintimepercast_v={{{1,3*18},{10,3*18},{20,3*18}}}, 
	},
	caibangr150ctcon={ --龙战于野，飞龙在天第二式
		appenddamage_p= {{{1,20*FightSkill.tbParam.nS1},{10,20},{20,20*FightSkill.tbParam.nS20},{21,20*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}}, 
		firedamage_v={ 
			[1]={{1,305*0.8*FightSkill.tbParam.nS1},{10,305*0.8},{20,305*0.8*FightSkill.tbParam.nS20},{21,305*0.8*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,305*1.1*FightSkill.tbParam.nS1},{10,305*1.1},{20,305*1.1*FightSkill.tbParam.nS20},{21,305*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		missile_hitcount={{{1,2},{10,3},{20,4},{21,4}}},
		missile_missrate={{{1,90},{2,90}}},
		missile_range={5,0,5},
	},
	 caibangbong150={ --天下无狗
		appenddamage_p= {{{1,34*FightSkill.tbParam.nS1},{10,74},{20,112*FightSkill.tbParam.nS20},{29,115*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}}, 
		physicsenhance_p={{{1,36*FightSkill.tbParam.nS1},{10,76},{20,108*FightSkill.tbParam.nS20},{29,110*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}}, 
		firedamage_v={
			[1]={{1,500*0.9*FightSkill.tbParam.nS1},{10,900*0.9},{20,1020*0.9*FightSkill.tbParam.nS20},{21,1023*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,510*1.1*FightSkill.tbParam.nS1},{10,915*1.1},{20,1035*1.1*FightSkill.tbParam.nS20},{21,1038*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}}, 
		state_hurt_attack={{{1,20},{20,25}},{{1,18},{20,18}}},
		state_burn_attack={{{1,10},{10,20},{20,25}},{{1,36},{20,54},{21,54}}},
		state_knock_attack={{{1,0.5},{2,1}},{{1,3},{10,10},{20,10}},{{1,32},{2,32}}}, 
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	 thienvuongthuong150={ --追星逐月
	 	appenddamage_p= {{{1,60*FightSkill.tbParam.nS1},{10,60},{20,60*FightSkill.tbParam.nS20},{21,60*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,60*FightSkill.tbParam.nS1},{10,60},{20,60*FightSkill.tbParam.nS20},{21,60*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,500*0.9*FightSkill.tbParam.nS1},{10,500*0.9},{20,500*0.9*FightSkill.tbParam.nS20},{21,500*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,500*1.1*FightSkill.tbParam.nS1},{10,500*1.1},{20,500*1.1*FightSkill.tbParam.nS20},{21,500*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		seriesdamage_r={{{1,100},{20,200},{21,210}}},
		skill_cost_v={{{1,22},{20,45},{21,45}}},
		state_hurt_attack={{{1,1},{2,2}},{{1,0.5*18},{20,0.5*18}}},
		state_hurt_attacktime={{{1,90},{2,100}}},
		missile_hitcount={{{1,3},{20,3}}},
		--skill_vanishedevent={{{1,1983},{20,1983}}},
		skill_showevent={{{1,8},{20,8}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	thienvuongthuong150_child={ --追星逐月
	--[[	appenddamage_p= {{{1,30*FightSkill.tbParam.nS1},{10,30},{20,30*FightSkill.tbParam.nS20},{21,30*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,70*FightSkill.tbParam.nS1},{10,70},{20,70*FightSkill.tbParam.nS20},{21,70*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,500*0.9*FightSkill.tbParam.nS1},{10,500*0.9},{20,500*0.9*FightSkill.tbParam.nS20},{21,500*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,500*1.1*FightSkill.tbParam.nS1},{10,500*1.1},{20,500*1.1*FightSkill.tbParam.nS20},{21,500*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_hurt_attack={{{1,15},{10,25},{20,30}},{{1,18},{20,18}}},
		missile_hitcount={{{1,1},{20,1}}},]]
	},
	 chuythien150={ --乘龙诀_20
		appenddamage_p= {{{1,90*FightSkill.tbParam.nS1},{10,110},{20,170*FightSkill.tbParam.nS20},{21,172*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,210*FightSkill.tbParam.nS1},{10,210},{20,240*FightSkill.tbParam.nS20},{21,242*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsdamage_v={
			[1]={{1,1100*0.9*FightSkill.tbParam.nS1},{10,1500*0.9},{20,1800*0.9*FightSkill.tbParam.nS20},{21,1810*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,1200*1.1*FightSkill.tbParam.nS1},{10,1550*1.1},{20,1860*1.1*FightSkill.tbParam.nS20},{21,1880*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		skill_cost_v={{{1,22},{20,45},{21,45}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		state_hurt_attack={{{1,26},{2,27}},{{1,2*18},{20,4*18},{21,4*18}}},
		state_hurt_attacktime={{{1,220},{2,240}}},
		missile_hitcount={{{1,4},{20,6}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	 thieulamdao150={ --天竺绝刀_20
		appenddamage_p= {{{1,45*FightSkill.tbParam.nS1},{10,47},{20,47*FightSkill.tbParam.nS20},{21,50*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,132*FightSkill.tbParam.nS1},{10,135},{20,135*FightSkill.tbParam.nS20},{21,135*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsdamage_v={
			[1]={{1,1100*0.9*FightSkill.tbParam.nS1},{10,1100*0.9},{20,1100*0.9*FightSkill.tbParam.nS20},{21,775*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,1100*1.1*FightSkill.tbParam.nS1},{10,1100*1.1},{20,1100*1.1*FightSkill.tbParam.nS20},{21,775*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		state_hurt_attack={{{1,21},{2,22}},{{1,2*19},{20,3*18}}},
		state_hurt_attacktime={{{1,110},{2,120}}},
		missile_hitcount={{{1,5},{10,5},{20,5},{21,5}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},	
	 thieulambong_150={
		appenddamage_p= {{{1,26},{10,36},{20,56},{21,59}}},
		physicsenhance_p={{{1,62},{10,72},{20,90},{21,95}}},
		physicsdamage_v={
			[1]={{1,450},{2,500}},
			[3]={{1,450*1.1*FightSkill.tbParam.nSadd},{2,500*1.1*FightSkill.tbParam.nSadd}},
			},
		skill_cost_v={{{1,100},{20,200},{21,205}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		state_hurt_attack={{{1,41},{10,51},{20,61}},{{1,0.5*18},{20,2*18}}},
		state_stun_attack={{{1,7},{2,10}},{{1,0.5*18},{20,2*18}}},
		state_hurt_attacktime={{{1,50},{2,65}}},
		missile_hitcount={{{1,5},{5,6},{10,7},{15,8},{20,9},{21,9}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},	
	 skill150dmtt={ --????
		appenddamage_p= {{{1,70*FightSkill.tbParam.nS1},{10,70},{20,70*FightSkill.tbParam.nS20},{21,70*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,90*FightSkill.tbParam.nS1},{10,90},{20,90*FightSkill.tbParam.nS20},{21,90*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,6*18},{20,6*18}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		state_hurt_attack={{{1,21},{20,40}},{{1,2*18},{20,2*18}}},
		state_weak_attack={{{1,12},{10,30},{20,50}},{{1,36},{20,54},{21,54}}},
		state_weak_attacktime={{{1,110},{10,200}}},
		missile_hitcount={{{1,5},{2,5}}},
		skill_flyevent={{{1,1960},{20,1960}},{{1,10},{2,10}}},
		skill_showevent={{{1,2},{20,2}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	skill150dmtt_child={ --????,???????
		appenddamage_p= {{{1,20*FightSkill.tbParam.nS1},{10,40},{20,65*FightSkill.tbParam.nS20},{21,67*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,90*FightSkill.tbParam.nS1},{10,90},{20,90*FightSkill.tbParam.nS20},{21,90*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,6*18},{20,6*18}}},
		seriesdamage_r={{{1,100},{20,300},{21,320}}},
		state_hurt_attack={{{1,15},{20,30}},{{1,18},{20,18}}},
		state_weak_attack={{{1,10},{10,20},{20,30}},{{1,36},{20,54},{21,54}}},
	},
	    duongmonbay150={ --小李飞刀_20
		appenddamage_p= {{{1,52},{2,54}}},
		skill_cost_v={{{1,5},{20,20},{21,20}}},
		state_hurt_attack={{{1,21},{2,22}},{{1,2*18},{20,2*18}}},
		state_weak_attack={{{1,15},{10,45},{20,50},{23,54}},{{1,36},{20,54},{21,54}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		poisondamage_v={{{1,43},{2,46}},{{1,6*18},{20,2*18}}},
		state_drag_attack={{{1,50},{20,95},{21,95}},{{1,25},{10,25},{11,25}},{{1,16},{2,16}}},
		state_knock_attack={{{1,16},{2,17}},{{1,3},{10,10},{20,10}},{{1,32},{2,32}}},
		skill_attackradius={520},
		missile_range={1,0,1},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	duongmonbay150_child={ --幻影追魂枪_10
		state_knock_attack={{{1,16},{2,17}},{{1,3},{10,10},{20,10}},{{1,32},{2,32}}},
		fastwalkrun_p={{{1,-10},{10,-30},{11,-31}}},
		skill_statetime={{{1,18*2},{10,18*4},{11,18*4}}},
		missile_hitcount={{{1,5},{10,5},{20,5},{21,5}}},
	},
	ngudocdao150={ --玄阴斩
		appenddamage_p= {{{1,74*FightSkill.tbParam.nS1},{10,104},{20,126*FightSkill.tbParam.nS20},{21,128*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,100*FightSkill.tbParam.nS1},{10,150},{20,210*FightSkill.tbParam.nS20},{21,203*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,600*FightSkill.tbParam.nS1},{10,800},{20,1020*FightSkill.tbParam.nS20},{21,1024*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,9*9},{20,9*9}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_hurt_attack={{{1,30},{2,34}},{{1,40},{20,40}}},
		state_weak_attack={{{1,18},{2,22}},{{1,3*18},{20,4*18},{21,4*18}}},
		state_hurt_attacktime={{{1,150},{2,170}}},
		state_weak_attacktime={{{1,150},{2,170}}},
		fastwalkrun_p={{{1,-10},{10,-20},{11,-22}}}, 
		skill_statetime={{{1,18*2},{10,18*4},{11,18*4}}},
		missile_hitcount={{{1,5},{10,5},{20,7},{21,9}}},
		--skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	 ngudocchuong150={ --阴风蚀骨
		appenddamage_p= {{{1,47*FightSkill.tbParam.nS1},{10,50},{20,80*FightSkill.tbParam.nS20},{21,80*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,315*FightSkill.tbParam.nS1},{10,315},{20,315*FightSkill.tbParam.nS20},{21,315*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,4*9},{20,4*9}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		state_weak_attack={{{1,12},{2,13.5}},{{1,36},{10,2*36},{20,2*36},{21,2*36}}},
		state_weak_attacktime={{{1,110},{2,120}}},
		state_hurt_attack={{{1,15},{10,40},{20,50}},{{1,18},{20,18}}},
		state_fixed_attack={{{1,0.5},{2,1}},{{1,72},{2,72}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		skill_vanishedevent={{{1,1987},{20,1987}}},
		skill_showevent={{{1,8},{20,8}}},
		missile_hitcount={{{1,5},{5,6},{10,8},{15,9},{20,10},{21,10}}},
		missile_range={9,0,9},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	ngudocchuong150_child={ --天罡毒手，阴风蚀骨第二式
		appenddamage_p= {{{1,37*FightSkill.tbParam.nS1},{10,40},{20,41*FightSkill.tbParam.nS20},{21,41*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,200*FightSkill.tbParam.nS1},{10,200},{20,200*FightSkill.tbParam.nS20},{21,315*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,4*9},{20,4*9}}},
		seriesdamage_r={{{1,50},{20,1000},{21,1050}}},
		state_weak_attack={{{1,12},{2,13.5}},{{1,36},{10,2*36},{20,2*36},{21,2*36}}},
		missile_hitcount={{{1,5},{5,6},{10,8},{15,9},{20,10},{21,10}}},
		missile_range={11,0,11},
	},
	minhgiaokiem150={ --圣火燎原
		appenddamage_p= {{{1,2*125*FightSkill.tbParam.nS1},{10,2*125},{20,2*125*FightSkill.tbParam.nS20},{29,2*125*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		poisondamage_v={{{1,2*840*FightSkill.tbParam.nS1},{10,2*840},{20,2*840*FightSkill.tbParam.nS20},{29,2*840*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},{{1,4*9},{20,4*9}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,150},{20,200},{21,200}}},
		state_weak_attack={{{1,30},{10,55},{20,70}},{{1,72},{20,72}}},
		state_fixed_attack={{{1,0.5},{2,1}},{{1,18*2},{2,18*2}}},
		state_weak_attacktime={{{1,200},{2,220}}},
		--skill_mintimepercast_v={{{1,3.5*18},{2,3.5*18}}},
		missile_range={4,0,4},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},
	minhchuy150={ --龙吞式
		appenddamage_p= {{{1,80*FightSkill.tbParam.nS1},{10,100},{20,160*FightSkill.tbParam.nS20},{21,162*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,90*FightSkill.tbParam.nS1},{10,180},{20,240*FightSkill.tbParam.nS20},{21,242*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		poisondamage_v={{{1,74*FightSkill.tbParam.nS1},{10,114},{20,170*FightSkill.tbParam.nS20},{21,174*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},{{1,45},{20,45}}},
		seriesdamage_r={{{1,100},{20,300},{21,310}}},
		skill_cost_v={{{1,27},{20,54},{21,54}}},
		state_hurt_attack={{{1,11},{2,12}},{{1,2*18},{20,2*18}}},
		state_weak_attack={{{1,21},{2,22}},{{1,36},{20,54},{21,54}}},
		state_weak_attacktime={{{1,110},{2,120}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
}
FightSkill:AddMagicData(tb)