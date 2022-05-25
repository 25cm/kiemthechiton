local tb = { 
    cbb180={ --????
		appenddamage_p= {{{1,73*FightSkill.tbParam.nS180S1},{20,73*FightSkill.tbParam.nS180S20},{29,73*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		physicsenhance_p={{{1,70*FightSkill.tbParam.nS180S1},{20,70*FightSkill.tbParam.nS180S20},{29,70*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		firedamage_v={
			[1]={{1,600*0.9*FightSkill.tbParam.nS180S1},{10,600*0.9},{20,600*0.9*FightSkill.tbParam.nS180S20},{29,600*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,600*1.1*FightSkill.tbParam.nS180S1},{10,600*1.1},{20,600*1.1*FightSkill.tbParam.nS180S20},{29,600*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{29,490}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		attackrating_p={{{1,100},{20,300},{21,300}}},
		state_hurt_attack={{{1,20},{20,25}},{{1,18},{20,18}}},
		state_burn_attack={{{1,10},{20,25},{29,40}},{{1,36},{20,54},{29,54}}},
		state_burn_attacktime={{{1,50},{20,250},{29,390}}},
		state_knock_attack={{{1,15},{30,15}},{{1,3},{10,10},{20,10}},{{1,32},{2,32}}},
		skill_vanishedevent={{{1,1711},{20,1711}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	
	
	cbb180con={ --????
		appenddamage_p= {{{1,42*FightSkill.tbParam.nS180S1},{20,42*FightSkill.tbParam.nS180S20},{29,42*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		physicsenhance_p={{{1,63*FightSkill.tbParam.nS180S1},{20,63*FightSkill.tbParam.nS180S20},{29,63*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		firedamage_v={
			[1]={{1,303*0.9*FightSkill.tbParam.nS180S1},{20,303*0.9*FightSkill.tbParam.nS180S20},{29,303*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,303*1.1*FightSkill.tbParam.nS180S1},{20,303*1.1*FightSkill.tbParam.nS180S20},{29,303*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}
			},
		seriesdamage_r={{{1,100},{20,300},{29,490}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_hurt_attack={{{1,20},{20,25}},{{1,18},{20,18}}},
		state_burn_attack={{{1,10},{10,20},{20,25}},{{1,36},{20,54},{21,54}}},
		state_knock_attack={{{1,0.5},{2,1}},{{1,3},{10,10},{20,10}},{{1,32},{2,32}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	
	cbr180={ --????
		appenddamage_p= {{{1,25*FightSkill.tbParam.nS180S1},{20,25*FightSkill.tbParam.nS180S20},{29,25*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		firedamage_v={
			[1]={{1,522*0.9*FightSkill.tbParam.nS180S1},{10,522*0.9},{20,522*0.9*FightSkill.tbParam.nS180S20},{29,522*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,522*1.1*FightSkill.tbParam.nS180S1},{10,522*1.1},{20,522*1.1*FightSkill.tbParam.nS180S20},{29,522*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{29,490}}},
		skill_cost_v={{{1,50},{20,50},{21,50}}},
		state_burn_attack={{{1,5},{10,10},{20,15}},{{1,36},{20,54},{21,54}}},
		skill_missilenum_v={{{1,4},{20,10},{30,10}}},
		skill_vanishedevent={{{1,1709},{20,1709}}},
		skill_showevent={{{1,8},{20,8}}},		
		missile_range={1,0,1},
		missile_speed_v={40},
--		state_knock_attack={{{1,2},{10,6},{20,10},{29,15}},{{1,3},{10,10},{20,10},{29,10}},{{1,18},{2,18}}},
		state_burn_attacktime={{{1,50},{20,250},{29,390}}},
		--skill_mintimepercast_v={{{1,3*18},{10,3*18},{20,3*18}}},
	},
	cbr180con={ --????,???????
		appenddamage_p= {{{1,50*FightSkill.tbParam.nS1},{20,50*FightSkill.tbParam.nS20},{21,50*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,1500*0.8*FightSkill.tbParam.nS1},{20,1500*0.8*FightSkill.tbParam.nS20},{21,1500*0.8*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,1500*1.2*FightSkill.tbParam.nS1},{20,1500*1.2*FightSkill.tbParam.nS20},{21,1500*1.2*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		missile_hitcount={{{1,2},{10,3},{20,4},{21,4}}},
		missile_missrate={{{1,90},{2,90}}},
		missile_range={5,0,5},
	},
	
	dtc180={	--Nh?t Ch? VÙ Song	Ch? d?ng t?n cÙng ngo?i cÙng	ID: 1898
		appenddamage_p= {{{1,100*FightSkill.tbParam.nS180S1},{10,100},{20,100*FightSkill.tbParam.nS180S20},{30,100*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}},
		physicsenhance_p={{{1,130*FightSkill.tbParam.nS180S1},{10,130},{20,130*FightSkill.tbParam.nS180S20},{29,130*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}},
		colddamage_v={
			[1]={{1,1552*0.9*FightSkill.tbParam.nS180S1},{10,1552*0.9},{20,1552*0.9*FightSkill.tbParam.nS180S20},{29,1552*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}},
			[3]={{1,1552*1.1*FightSkill.tbParam.nS180S1},{10,1552*1.1},{20,1552*1.1*FightSkill.tbParam.nS180S20},{29,1552*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,45},{20,90},{21,90}}},
		state_hurt_attack={{{1,21},{2,22}},{{1,18},{10,2*18},{11,2*18}}},
		state_slowall_attack={{{1,21},{2,22}},{{1,18},{10,3*18},{11,5*18}}},
		state_hurt_attacktime={{{1,150},{20,420},{21,420}}},
		state_slowall_attacktime={{{1,150},{20,420},{21,420}}},
		missile_hitcount={{{1,5},{20,5}}},
		attackratingenhance_p={{{1,50},{10,150},{11,165}}},
		--skill_vanishedevent={{{1,1731},{20,1731}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	
	dtc180con={	--Nh?t Ch? VÙ Song	Ch? d?ng t?n cÙng ngo?i cÙng	ID: 1898
		appenddamage_p= {{{1,20*FightSkill.tbParam.nS180S1},{10,25},{20,95*FightSkill.tbParam.nS180S20},{30,115*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}},
		physicsenhance_p={{{1,238*FightSkill.tbParam.nS180S1},{10,238},{20,238*FightSkill.tbParam.nS180S20},{29,297*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}},
		colddamage_v={
			[1]={{1,3300*0.9*FightSkill.tbParam.nS180S1},{10,3300*0.9},{20,3145*0.9*FightSkill.tbParam.nS180S20},{29,4120*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}},
			[3]={{1,3300*1.1*FightSkill.tbParam.nS180S1},{10,3300*1.1},{20,3145*1.1*FightSkill.tbParam.nS180S20},{29,4120*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}
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
	
	cn180={ --???_10
		appenddamage_p= {{{1,90*FightSkill.tbParam.nS180S1},{10,90},{20,90*FightSkill.tbParam.nS180S20},{29,90*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		physicsenhance_p={{{1,85*FightSkill.tbParam.nS180S1},{20,156*FightSkill.tbParam.nS180S20},{29,134*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		firedamage_v={
			[1]={{1,929*0.9*FightSkill.tbParam.nS180S1},{10,929*0.9},{20,929*0.9*FightSkill.tbParam.nS180S20},{29,929*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,929*1.1*FightSkill.tbParam.nS180S1},{10,929*1.1},{20,929*1.1*FightSkill.tbParam.nS180S20},{29,929*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_hurt_attack={{{1,31},{2,32}},{{1,2*18},{20,2*18}}},
		state_hurt_attacktime={{{1,110},{2,120}}},
		state_burn_attack={{{1,36},{2,37}},{{1,18},{10,2*18},{20,4*18},{21,4*18}}},
		steallife_p={{{1,1},{20,10}},{{1,100},{20,100}}},
		stealmana_p={{{1,1},{20,10}},{{1,100},{20,100}}},
		missile_hitcount={{{1,3},{10,4},{20,5},{21,5}}},
		--state_drag_attack={{{1,40},{10,100},{11,100}},{{1,25},{10,25},{11,25}},{{1,32},{2,32}}},
		skill_vanishedevent={{{1,1721},{20,1721}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	
	cn180con={ --???_10
		appenddamage_p= {{{1,90*FightSkill.tbParam.nS180S1},{10,90},{20,90*FightSkill.tbParam.nS180S20},{29,90*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		physicsenhance_p={{{1,85*FightSkill.tbParam.nS180S1},{20,156*FightSkill.tbParam.nS180S20},{29,134*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		firedamage_v={
			[1]={{1,929*0.9*FightSkill.tbParam.nS180S1},{10,929*0.9},{20,929*0.9*FightSkill.tbParam.nS180S20},{29,929*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,929*1.1*FightSkill.tbParam.nS180S1},{10,929*1.1},{20,929*1.1*FightSkill.tbParam.nS180S20},{29,929*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}
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
	
	tvc180={ --???_20
		appenddamage_p= {{{1,85*FightSkill.tbParam.nS180S1},{20,85*FightSkill.tbParam.nS180S20},{29,85*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}},
		physicsenhance_p={{{1,100*FightSkill.tbParam.nS180S1},{20,100*FightSkill.tbParam.nS180S20},{29,100*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		physicsdamage_v={
			[1]={{1,950*0.9*FightSkill.tbParam.nS180S1},{20,950*0.9*FightSkill.tbParam.nS180S20},{29,950*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}},
			[3]={{1,960*1.1*FightSkill.tbParam.nS180S1},{20,960*1.1*FightSkill.tbParam.nS180S20},{29,960*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}
			},
		skill_cost_v={{{1,22},{20,45},{21,45}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		state_hurt_attack={{{1,26},{2,27}},{{1,2*18},{20,4*18},{21,4*18}}},
		state_hurt_attacktime={{{1,220},{2,240}}},
		missile_hitcount={{{1,4},{20,4}}},
		--poisondamagereturn_p={{{1,10},{10,40},{12,45}}},
		skill_vanishedevent={{{1,1726},{20,1726}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	
	tvc180con1={ --???_20
		appenddamage_p= {{{1,70*FightSkill.tbParam.nS180S1},{20,70*FightSkill.tbParam.nS180S20},{29,70*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}},
		physicsenhance_p={{{1,100*FightSkill.tbParam.nS180S1},{20,100*FightSkill.tbParam.nS180S20},{29,100*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		physicsdamage_v={
			[1]={{1,950*0.9*FightSkill.tbParam.nS180S1},{20,950*0.9*FightSkill.tbParam.nS180S20},{29,950*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}},
			[3]={{1,960*1.1*FightSkill.tbParam.nS180S1},{20,960*1.1*FightSkill.tbParam.nS180S20},{29,960*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}
			},
		skill_cost_v={{{1,22},{20,45},{21,45}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		state_hurt_attack={{{1,26},{2,27}},{{1,2*18},{20,4*18},{21,4*18}}},
		state_hurt_attacktime={{{1,220},{2,240}}},
		missile_hitcount={{{1,4},{20,4}}},
		skill_vanishedevent={{{1,1727},{20,1727}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	
	tvc180con2={ --???_20
		appenddamage_p= {{{1,86*FightSkill.tbParam.nS180S1},{20,86*FightSkill.tbParam.nS180S20},{29,86*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}},
		physicsenhance_p={{{1,120*FightSkill.tbParam.nS180S1},{20,120*FightSkill.tbParam.nS180S20},{29,120*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		physicsdamage_v={
			[1]={{1,1144*0.9*FightSkill.tbParam.nS180S1},{20,1144*0.9*FightSkill.tbParam.nS180S20},{29,1144*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}},
			[3]={{1,1160*1.1*FightSkill.tbParam.nS180S1},{20,1160*1.1*FightSkill.tbParam.nS180S20},{29,1160*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}
			},
		skill_cost_v={{{1,22},{20,45},{21,45}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		state_hurt_attack={{{1,26},{2,27}},{{1,2*18},{20,4*18},{21,4*18}}},
		state_hurt_attacktime={{{1,220},{2,240}}},
		missile_hitcount={{{1,4},{20,4}}},

		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	
	cld180={ --????_20
		appenddamage_p= {{{1,80*FightSkill.tbParam.nS180S1},{20,80*FightSkill.tbParam.nS180S20},{29,80*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		physicsenhance_p={{{1,80*FightSkill.tbParam.nS180S1},{20,80*FightSkill.tbParam.nS180S20},{29,80*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		lightingdamage_v={
			[1]={{1,583*0.9*FightSkill.tbParam.nS180S1},{10,453*0.9},{20,583*0.9*FightSkill.tbParam.nS180S20},{29,583*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,616*1.1*FightSkill.tbParam.nS180S1},{10,305*1.1},{20,616*1.1*FightSkill.tbParam.nS180S20},{29,616*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}
			},
		skill_cost_v={{{1,100},{20,100},{21,105}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		attackrating_p={{{1,100},{20,300},{21,300}}},
		state_stun_attack={{{1,17},{20,50},{21,50}},{{1,0.5*18},{20,1*18}}},
		state_hurt_attack={{{1,21},{2,22}},{{1,1*18},{20,2*18}}},
		state_stun_attacktime={{{1,110},{2,120}}},
		state_hurt_attacktime={{{1,110},{2,120}}},
		state_drag_attack={{{1,10},{20,20},{29,30}},{{1,11},{10,11}},{{1,32},{2,32}}},
		missile_speed_v={40},
		skill_vanishedevent={{{1,1743},{20,1743}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	cld180con1={ --?????
		appenddamage_p= {{{1,60*FightSkill.tbParam.nS180S1},{20,60*FightSkill.tbParam.nS180S20},{29,56*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		physicsenhance_p={{{1,76*FightSkill.tbParam.nS180S1},{20,76*FightSkill.tbParam.nS180S20},{29,64*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		lightingdamage_v={
			[1]={{1,453*0.9*FightSkill.tbParam.nS180S1},{10,453*0.9},{20,453*0.9*FightSkill.tbParam.nS180S20},{29,453*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,305*1.1*FightSkill.tbParam.nS180S1},{10,305*1.1},{20,305*1.1*FightSkill.tbParam.nS180S20},{29,305*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}
			},
		state_hurt_attack={{{1,21},{2,22}},{{1,36},{2,36}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		missile_speed_v={30},
		missile_range={1,0,1},
		skill_vanishedevent={{{1,1744},{20,1744}}},
	},
	cld180con2={ --?????,???????
		appenddamage_p= {{{1,60*FightSkill.tbParam.nS180S1},{20,60*FightSkill.tbParam.nS180S20},{29,56*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		physicsenhance_p={{{1,76*FightSkill.tbParam.nS180S1},{20,76*FightSkill.tbParam.nS180S20},{29,64*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		lightingdamage_v={
			[1]={{1,453*0.9*FightSkill.tbParam.nS180S1},{10,453*0.9},{20,453*0.9*FightSkill.tbParam.nS180S20},{29,453*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,305*1.1*FightSkill.tbParam.nS180S1},{10,305*1.1},{20,305*1.1*FightSkill.tbParam.nS180S20},{29,305*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		missile_hitcount={{{1,2},{10,3},{20,3}}},
	},
	
	clk180={ --????
		appenddamage_p= {{{1,90*FightSkill.tbParam.nS180S1},{20,90*FightSkill.tbParam.nS180S20},{29,90*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		lightingdamage_v={
			[1]={{1,1732*0.9*FightSkill.tbParam.nS180S1},{10,1732*0.9},{20,1732*0.9*FightSkill.tbParam.nS180S20},{29,1732*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,1732*1.1*FightSkill.tbParam.nS180S1},{10,1732*1.1},{20,1732*1.1*FightSkill.tbParam.nS180S20},{29,1732*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}
			},
		seriesdamage_r={{{1,100},{20,410},{29,490}}},
		state_stun_attack={{{1,15},{10,40},{20,50}},{{1,36},{20,36}}},
		skill_cost_v={{{1,150},{20,300},{21,300}}},
		--skill_mintimepercast_v={{{1,3*18},{10,3*18}}},
		missile_hitcount={{{1,5},{10,7},{20,9},{21,9}}},
		skill_vanishedevent={{{1,1746},{20,1746}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},
	clk180con={ --?????
		appenddamage_p= {{{1,80*FightSkill.tbParam.nS180S1},{10,80},{20,80*FightSkill.tbParam.nS180S20},{29,80*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		lightingdamage_v={
			[1]={{1,1732*0.9*FightSkill.tbParam.nS180S1},{10,1732*0.9},{20,1732*0.9*FightSkill.tbParam.nS180S20},{29,1732*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,1732*1.1*FightSkill.tbParam.nS180S1},{10,1732*1.1},{20,1732*1.1*FightSkill.tbParam.nS180S20},{29,1732*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}
			},
		--state_stun_attack={{{1,15},{10,40},{20,55}},{{1,3*18},{20,3*18}}},
		missile_hitcount={{{1,2},{10,2}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		missile_range={4,0,4},
	},
	
	
	
	dtk180={ --????	
		appenddamage_p= {{{1,35*FightSkill.tbParam.nS180S1},{20,35*FightSkill.tbParam.nS180S20},{29,35*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		colddamage_v={
			[1]={{1,520*0.8*FightSkill.tbParam.nS180S1},{10,520*0.8},{20,490*0.8*FightSkill.tbParam.nS180S20},{29,490*0.8*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,520*1.2*FightSkill.tbParam.nS180S1},{10,520*1.2},{20,490*1.1*FightSkill.tbParam.nS180S20},{29,490*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}}, -- Ngu H‡nh Tuong Kh?c
		skill_cost_v={{{1,100},{20,100},{21,100}}},
		state_burn_attack={{{1,5},{20,10}},{{1,18},{20,18},{21,18}}},
		state_slowall_attack={{{1,15},{10,45},{20,50}},{{1,45},{20,45}}},
		state_stun_attack={{{1,5},{20,10}},{{1,18},{20,18},{21,18}}},
		state_weak_attack={{{1,5},{20,10}},{{1,18},{20,18},{21,54}}},
		state_hurt_attack={{{1,5},{10,10},{20,15}},{{1,18},{20,18}}},
		skill_missilenum_v={{{1,4},{20,4}}},
		skill_vanishedevent={{{1,1729},{20,1729}}},
		skill_showevent={{{1,8},{20,8}}},
		missile_range={1,0,1},
		missile_speed_v={40},
		--skill_mintimepercast_v={{{1,0.4*18},{10,0.4*18},{20,0.4*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	dtk180con={ --????,???????
		appenddamage_p= {{{1,30*FightSkill.tbParam.nS180S1},{10,30*FightSkill.tbParam.nS180S1},{20,30*FightSkill.tbParam.nS180S1},{29,40*FightSkill.tbParam.nS180S1}}},
		colddamage_v={
			[1]={{1,60*0.9*FightSkill.tbParam.nS180S1},{10,60*0.9},{20,60*0.9*FightSkill.tbParam.nS180S20},{21,60*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,65*1.1*FightSkill.tbParam.nS180S1},{10,65*1.1},{20,65*1.1*FightSkill.tbParam.nS180S20},{21,65*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}
			},
		seriesdamage_r={{{1,100},{20,210},{21,210}}}, -- Ngu H‡nh Tuong Kh?c
		missile_hitcount={{{1,2},{10,3},{20,4},{21,4}}},
		missile_missrate={{{1,70},{2,70}}},
		missile_range={5,0,5},
	},
	
	
	dmb180={ --????_20
		appenddamage_p= {{{1,100*FightSkill.tbParam.nS180S1},{20,100*FightSkill.tbParam.nS180S20},{29,95*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}},
		skill_cost_v={{{1,5},{20,20},{21,20}}},
		state_hurt_attack={{{1,21},{2,22}},{{1,2*18},{20,2*18}}},
		state_weak_attack={{{1,15},{10,45},{20,50},{23,54}},{{1,36},{20,54},{21,54}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		poisondamage_v={{{1,43},{2,46},{20,157},{29,228}},{{1,2*18},{29,2*18}}},
		state_drag_attack={{{1,5},{20,20},{21,30}},{{1,25},{10,25},{11,25}},{{1,16},{2,16}}},
		state_knock_attack={{{1,16},{2,17}},{{1,3},{10,10},{20,10}},{{1,32},{2,32}}},
		skill_attackradius={520},
		missile_range={1,0,1},
		state_fixed_attack={{{1,5},{20,20},{29,30}},{{1,18*1},{20,18*1},{29,1*18}}},
		skill_vanishedevent={{{1,1754},{20,1754}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	dmb180con={ --?????_10
		state_knock_attack={{{1,16},{2,17}},{{1,3},{10,10},{20,10}},{{1,32},{2,32}}},
		fastwalkrun_p={{{1,-10},{10,-30},{11,-31}}},
		skill_statetime={{{1,18*2},{10,18*4},{11,18*4}}},
		missile_hitcount={{{1,5},{10,5},{20,5},{21,5}}},
	},
	
	
	mgc180={ --???
		appenddamage_p= {{{1,125*FightSkill.tbParam.nS180S1},{20,125*FightSkill.tbParam.nS180S20},{29,125*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}},
		physicsenhance_p={{{1,180*FightSkill.tbParam.nS180S1},{20,180*FightSkill.tbParam.nS180S20},{29,180*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}},
		poisondamage_v={{{1,180*FightSkill.tbParam.nS180S1},{10,180},{20,180*FightSkill.tbParam.nS180S20},{29,198*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}},{{1,45},{29,45}}},
		seriesdamage_r={{{1,100},{20,500},{21,510}}},
		skill_cost_v={{{1,27},{20,54},{21,54}}},
		state_hurt_attack={{{1,11},{2,12}},{{1,2*18},{20,2*18}}},
		state_weak_attack={{{1,21},{2,22}},{{1,36},{20,54},{21,54}}},
		state_weak_attacktime={{{1,110},{2,120}}},
		skill_vanishedevent={{{1,1736},{20,1736}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	
	mgc180con={ --???
		appenddamage_p= {{{1,125*FightSkill.tbParam.nS180S1},{20,125*FightSkill.tbParam.nS180S20},{29,125*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}},
		physicsenhance_p={{{1,180*FightSkill.tbParam.nS180S1},{20,180*FightSkill.tbParam.nS180S20},{29,180*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}},
		poisondamage_v={{{1,180*FightSkill.tbParam.nS180S1},{10,180},{20,180*FightSkill.tbParam.nS180S20},{29,198*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}},{{1,45},{29,45}}},
		seriesdamage_r={{{1,100},{20,500},{21,510}}},
		skill_cost_v={{{1,27},{20,54},{21,54}}},
		state_hurt_attack={{{1,11},{2,12}},{{1,2*18},{20,2*18}}},
		state_weak_attack={{{1,21},{2,22}},{{1,36},{20,54},{21,54}}},
		state_weak_attacktime={{{1,110},{2,120}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	
	mgk180={ --Âú£ÁÅ´ÁáéÂéü
		appenddamage_p= {{{1,113*FightSkill.tbParam.nS180S1},{20,113*FightSkill.tbParam.nS180S20},{29,113*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		poisondamage_v={{{1,1600*FightSkill.tbParam.nS180S1},{20,1600*FightSkill.tbParam.nS180S20},{29,1605*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},{{1,4*9},{20,4*9}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,150},{20,200},{21,200}}},
		state_weak_attack={{{1,30},{10,55},{20,70}},{{1,72},{20,72}}},
		state_fixed_attack={{{1,0.5},{2,1}},{{1,2*18},{2,2*18}}},
		state_weak_attacktime={{{1,200},{2,220}}},
		--skill_mintimepercast_v={{{1,3.5*18},{2,3.5*18}}},
		missile_range={5,0,5},
		state_fixed_attack={{{1,5},{20,15},{29,30}},{{1,18*2},{20,18*2},{29,2*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},
	
	nmc180={ --????
		appenddamage_p= {{{1,113*FightSkill.tbParam.nS180S1},{20,113*FightSkill.tbParam.nS180S20},{29,83*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		colddamage_v={
			[1]={{1,1907*0.9*FightSkill.tbParam.nS180S1},{20,1907*0.9*FightSkill.tbParam.nS180S20},{29,1686*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,1907*1.1*FightSkill.tbParam.nS180S1},{20,1907*1.1*FightSkill.tbParam.nS180S20},{29,1686*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			},
		seriesdamage_r={{{1,100},{20,300},{29,490}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_slowall_attack={{{1,15},{20,50},{21,50}},{{1,1*18},{20,3*18}}},
		state_slowall_attacktime={{{1,110},{2,120}}},
		skill_startevent={{{1,1713},{20,1713}}},
		skill_showevent={{{1,5},{20,5}}},
		missile_hitcount={{{1,5},{10,6},{20,7},{21,7}}},
		missile_range={9,0,9},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	nmc180con1={ --????,???????
		appenddamage_p= {{{1,10*FightSkill.tbParam.nS180S1},{20,10*FightSkill.tbParam.nS180S20},{29,10*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		colddamage_v={
			[1]={{1,500*0.9*FightSkill.tbParam.nS180S1},{20,500*0.9*FightSkill.tbParam.nS180S20},{29,500*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,500*1.1*FightSkill.tbParam.nS180S1},{20,500*1.1*FightSkill.tbParam.nS180S20},{29,500*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			},
		seriesdamage_r={{{1,100},{20,550},{21,570}}},
		state_slowall_attack={{{1,5},{10,10},{20,15}},{{1,27},{20,45}}},
		state_hurt_attack={{{1,1},{2,2}},{{1,36},{20,36}}},
		missile_hitcount={{{1,6},{20,6}}},
		skill_startevent={{{1,1714},{20,1714}}},
		missile_range={1,0,1},
	},
	
	nmc180con2={ --????,???????
		appenddamage_p= {{{1,10*FightSkill.tbParam.nS180S1},{20,10*FightSkill.tbParam.nS180S20},{29,10*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		colddamage_v={
			[1]={{1,500*0.9*FightSkill.tbParam.nS180S1},{20,500*0.9*FightSkill.tbParam.nS180S20},{29,500*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,500*1.1*FightSkill.tbParam.nS180S1},{20,500*1.1*FightSkill.tbParam.nS180S20},{29,500*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			},
		seriesdamage_r={{{1,100},{20,550},{21,570}}},
		state_slowall_attack={{{1,5},{10,10},{20,15}},{{1,27},{20,45}}},
		state_hurt_attack={{{1,1},{2,2}},{{1,36},{20,36}}},
		missile_hitcount={{{1,6},{20,6}}},
		skill_startevent={{{1,1715},{20,1715}}},
		missile_range={1,0,1},
	},
	
	nmc180con3={ --????,???????
		appenddamage_p= {{{1,10*FightSkill.tbParam.nS180S1},{20,10*FightSkill.tbParam.nS180S20},{29,10*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		colddamage_v={
			[1]={{1,500*0.9*FightSkill.tbParam.nS180S1},{20,500*0.9*FightSkill.tbParam.nS180S20},{29,500*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,500*1.1*FightSkill.tbParam.nS180S1},{20,500*1.1*FightSkill.tbParam.nS180S20},{29,500*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			},
		seriesdamage_r={{{1,100},{20,550},{21,570}}},
		state_slowall_attack={{{1,5},{10,10},{20,15}},{{1,27},{20,45}}},
		state_hurt_attack={{{1,1},{2,2}},{{1,36},{20,36}}},
		missile_hitcount={{{1,6},{20,6}}},
		missile_range={1,0,1},
	},
	
	nmk180={ --????_10
		appenddamage_p= {{{1,90*FightSkill.tbParam.nS180S1},{20,90*FightSkill.tbParam.nS180S20},{29,90*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		colddamage_v={
			[1]={{1,1445*0.9*FightSkill.tbParam.nS180S1},{20,1445*0.9*FightSkill.tbParam.nS180S20},{29,1010*1.1*FightSkill.tbParam.nS180Sadd*FightSkill.tbParam.nS180S20}},
			[3]={{1,1445*1.1*FightSkill.tbParam.nS180S1},{20,1445*1.1*FightSkill.tbParam.nS180S20},{29,1211*1.1*FightSkill.tbParam.nS180Sadd*FightSkill.tbParam.nS180S20}}
		},
		state_slowall_attack={{{1,14},{20,50},{21,50}},{{1,2*18},{10,3*18},{11,3*18}}},
		state_slowall_attacktime={{{1,100},{2,110}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		state_fixed_attack={{{1,0.5},{2,1}},{{1,18*2},{2,18*2}}},
		missile_hitcount={{{1,7},{10,7},{11,7}}},
		skill_cost_v={{{1,100},{10,200},{11,200}}},
		skill_vanishedevent={{{1,1717},{20,1717}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	nmk180con={ --????_10
		state_knock_attack={{{1,16},{2,17}},{{1,3},{10,10},{20,10}},{{1,32},{2,32}}},
		state_slowall_attack={{{1,35},{10,65},{11,66}},{{1,45},{10,45},{11,45}}},
		lifemax_p={{{1,30},{20,100},{21,105}}},
		castspeed_v={{{1,10},{10,16},{20,26},{23,29},{24,29}}},
		skill_statetime={{{1,2*18},{20,5*18}}}
	},
	
	ndc180={ --????
		appenddamage_p= {{{1,80*FightSkill.tbParam.nS180S1},{20,80*FightSkill.tbParam.nS180S20},{29,80*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		poisondamage_v={{{1,430*FightSkill.tbParam.nS180S1},{20,430*FightSkill.tbParam.nS180S20},{29,430*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},{{1,4*9},{20,4*9}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		state_weak_attack={{{1,12},{2,13.5}},{{1,36},{10,2*36},{20,2*36},{21,2*36}}},
		state_weak_attacktime={{{1,110},{2,120}}},
		state_hurt_attack={{{1,15},{10,40},{20,50}},{{1,18},{20,18}}},
		state_fixed_attack={{{1,0.5},{2,1}},{{1,72},{2,72}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		skill_vanishedevent={{{1,1759},{20,1759}}},
		skill_showevent={{{1,8},{20,8}}},
		missile_hitcount={{{1,5},{5,6},{10,8},{15,9},{20,10},{21,10}}},
		missile_range={9,0,9},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	ndc180con={ --????,???????
		appenddamage_p= {{{1,60*FightSkill.tbParam.nS180S1},{20,60*FightSkill.tbParam.nS180S20},{29,60*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		poisondamage_v={{{1,334*FightSkill.tbParam.nS180S1},{10,334},{20,334*FightSkill.tbParam.nS180S20},{29,334*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},{{1,4*9},{20,4*9}}},seriesdamage_r={{{1,50},{20,1000},{21,1050}}},
		state_weak_attack={{{1,12},{2,13.5}},{{1,36},{10,2*36},{20,2*36},{21,2*36}}},
		missile_hitcount={{{1,5},{5,6},{10,8},{15,9},{20,10},{21,10}}},
		missile_range={11,0,11},
	},
	
	
	ndd180={ --???
		appenddamage_p= {{{1,74*FightSkill.tbParam.nS180S1},{20,74*FightSkill.tbParam.nS180S20},{29,74*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		physicsenhance_p={{{1,130*FightSkill.tbParam.nS180S1},{20,130*FightSkill.tbParam.nS180S20},{29,130*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		poisondamage_v={{{1,600*FightSkill.tbParam.nS180S1},{20,600*FightSkill.tbParam.nS180S20},{29,600*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},{{1,9*9},{20,9*9}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_hurt_attack={{{1,14},{20,50},{21,50}},{{1,2*18},{20,2*18},{21,2*18}}},
		state_weak_attack={{{1,18},{20,51},{21,51}},{{1,2*18},{20,2*18},{21,2*18}}},
		state_hurt_attacktime={{{1,150},{2,170}}},
		state_weak_attacktime={{{1,150},{2,170}}},
		--fastwalkrun_p={{{1,-10},{10,-20},{11,-22},{30,-50}}},
		--skill_statetime={{{1,18*2},{10,18*4},{11,18*4}}},
		missile_hitcount={{{1,5},{10,5},{20,5},{21,5}}},
		skill_vanishedevent={{{1,1756},{20,1756}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	
	ndd180con1={ --???
		appenddamage_p= {{{1,60*FightSkill.tbParam.nS180S1},{20,60*FightSkill.tbParam.nS180S20},{29,60*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		physicsenhance_p={{{1,140*FightSkill.tbParam.nS180S1},{20,140*FightSkill.tbParam.nS180S20},{29,140*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		poisondamage_v={{{1,239*FightSkill.tbParam.nS180S1},{20,239*FightSkill.tbParam.nS180S20},{29,239*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},{{1,9*9},{20,9*9}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		--state_hurt_attack={{{1,30},{2,34}},{{1,40},{20,40}}},
		--state_weak_attack={{{1,18},{2,22}},{{1,3*18},{20,4*18},{21,4*18}}},
		--state_hurt_attacktime={{{1,150},{2,170}}},
	--	state_weak_attacktime={{{1,150},{2,170}}},
		--fastwalkrun_p={{{1,-10},{10,-30},{11,-44}}},
		skill_statetime={{{1,18*2},{10,18*4},{11,18*4}}},
		missile_hitcount={{{1,5},{10,5},{20,5},{21,5}}},
		skill_vanishedevent={{{1,1757},{20,1757}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	
	ndd180con2={ --???
		appenddamage_p= {{{1,60*FightSkill.tbParam.nS180S1},{20,60*FightSkill.tbParam.nS180S20},{29,60*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		physicsenhance_p={{{1,140*FightSkill.tbParam.nS180S1},{20,140*FightSkill.tbParam.nS180S20},{29,140*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		poisondamage_v={{{1,239*FightSkill.tbParam.nS180S1},{20,239*FightSkill.tbParam.nS180S20},{29,239*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},{{1,9*9},{20,9*9}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		--state_hurt_attack={{{1,30},{2,34}},{{1,40},{20,40}}},
		--state_weak_attack={{{1,18},{2,22}},{{1,3*18},{20,4*18},{21,4*18}}},
		--state_hurt_attacktime={{{1,150},{2,170}}},
	--	state_weak_attacktime={{{1,150},{2,170}}},
		--fastwalkrun_p={{{1,-10},{10,-30},{11,-44}}},
		skill_statetime={{{1,18*2},{10,18*4},{11,18*4}}},
		missile_hitcount={{{1,5},{10,5},{20,5},{21,5}}},
		skill_vanishedevent={{{1,1757},{20,1757}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	
	
	dmtt180={ --????
		appenddamage_p= {{{1,70*FightSkill.tbParam.nS180S1},{20,70*FightSkill.tbParam.nS180S20},{29,70*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		poisondamage_v={{{1,135*FightSkill.tbParam.nS180S1},{20,135*FightSkill.tbParam.nS180S20},{29,135*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},{{1,6*18},{20,6*18}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		state_hurt_attack={{{1,21},{20,40}},{{1,2*18},{20,2*18}}},
		state_weak_attack={{{1,12},{10,30},{20,50}},{{1,36},{20,54},{21,54}}},
		state_weak_attacktime={{{1,110},{10,200}}},
		missile_hitcount={{{1,5},{2,5}}},
		skill_flyevent={{{1,1752},{20,1752}},{{1,10},{2,10}}},
		skill_showevent={{{1,2},{20,2}}},
		state_fixed_attack={{{1,5},{20,15},{29,30}},{{1,18*2},{20,18*2},{29,2*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	dmtt180con1={ --????,???????
		appenddamage_p= {{{1,50*FightSkill.tbParam.nS180S1},{20,50*FightSkill.tbParam.nS180S20},{29,50*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		poisondamage_v={{{1,105*FightSkill.tbParam.nS180S1},{20,105*FightSkill.tbParam.nS180S20},{29,105*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},{{1,6*18},{20,6*18}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		state_hurt_attack={{{1,15},{20,30}},{{1,18},{20,18}}},
		state_weak_attack={{{1,10},{10,20},{20,30}},{{1,36},{20,54},{21,54}}},
	},
	
	
	tvt180={ --????
		appenddamage_p= {{{1,65*FightSkill.tbParam.nS180S1},{20,65*FightSkill.tbParam.nS180S20},{29,65*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}},
		physicsenhance_p={{{1,115*FightSkill.tbParam.nS180S1},{10,115},{20,115*FightSkill.tbParam.nS180S20},{29,115*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}},
		physicsdamage_v={
			[1]={{1,720*0.9*FightSkill.tbParam.nS180S1},{10,720*0.9},{20,720*0.9*FightSkill.tbParam.nS180S20},{29,720*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}},
			[3]={{1,720*1.1*FightSkill.tbParam.nS180S1},{10,720*1.1},{20,720*1.1*FightSkill.tbParam.nS180S20},{20,720*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}
			},
		seriesdamage_r={{{1,100},{20,200},{21,210}}},
		skill_cost_v={{{1,22},{20,45},{21,45}}},
		state_hurt_attack={{{1,1},{2,2}},{{1,0.5*18},{20,0.5*18}}},
		state_hurt_attacktime={{{1,90},{2,100}}},
		missile_hitcount={{{1,3},{20,3}}},
		skill_vanishedevent={{{1,1723},{20,1723}}},
		skill_showevent={{{1,8},{20,8}}},
		--poisondamagereturn_p={{{1,10},{10,40},{12,45}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	tvt180con1={ --????
		appenddamage_p= {{{1,60*FightSkill.tbParam.nS180S1},{20,60*FightSkill.tbParam.nS180S20},{29,60*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}},
		physicsenhance_p={{{1,72*FightSkill.tbParam.nS180S1},{10,72},{20,72*FightSkill.tbParam.nS180S20},{29,72*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}},
		physicsdamage_v={
			[1]={{1,996*0.9*FightSkill.tbParam.nS180S1},{10,996*0.9},{20,996*0.9*FightSkill.tbParam.nS180S20},{29,996*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}},
			[3]={{1,978*1.1*FightSkill.tbParam.nS180S1},{10,978*1.1},{20,978*1.1*FightSkill.tbParam.nS180S20},{20,978*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		--state_hurt_attack={{{1,15},{10,25},{20,30}},{{1,18},{20,18}}},
		skill_vanishedevent={{{1,1724},{20,1724}}},
		missile_hitcount={{{1,1},{20,1}}},
	},
	
	tvt180con2={ --????
		appenddamage_p= {{{1,60*FightSkill.tbParam.nS180S1},{20,60*FightSkill.tbParam.nS180S20},{29,60*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}},
		physicsenhance_p={{{1,72*FightSkill.tbParam.nS180S1},{10,72},{20,72*FightSkill.tbParam.nS180S20},{29,72*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}},
		physicsdamage_v={
			[1]={{1,996*0.9*FightSkill.tbParam.nS180S1},{10,996*0.9},{20,996*0.9*FightSkill.tbParam.nS180S20},{29,996*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}},
			[3]={{1,978*1.1*FightSkill.tbParam.nS180S1},{10,978*1.1},{20,978*1.1*FightSkill.tbParam.nS180S20},{20,978*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd1}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		--state_hurt_attack={{{1,15},{10,25},{20,30}},{{1,18},{20,18}}},
		
		missile_hitcount={{{1,1},{20,1}}},
	},
	
	
	tlb180={
		appenddamage_p= {{{1,100*FightSkill.tbParam.nS180S1},{20,100*FightSkill.tbParam.nS180S20},{29,100*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		physicsenhance_p={{{1,145*FightSkill.tbParam.nS180S1},{20,145*FightSkill.tbParam.nS180S20},{29,145*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}}, -- V?t cÙng %
		physicsdamage_v={
			[1]={{1,1000*0.9*FightSkill.tbParam.nS180S1},{20,1000*0.9*FightSkill.tbParam.nS180S20},{29,1100*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,1000*1.1*FightSkill.tbParam.nS180S1},{20,1000*1.1*FightSkill.tbParam.nS180S20},{29,1100*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			},
		skill_cost_v={{{1,100},{20,200},{21,205}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		state_hurt_attack={{{1,41},{20,51},{21,51}},{{1,2*18},{20,2*18}}},
		state_stun_attack={{{1,14},{20,49},{21,49}},{{1,1*18},{20,1*18}}},
		state_hurt_attacktime={{{1,50},{2,65}}},
		missile_hitcount={{{1,5},{5,6},{10,7},{15,8},{20,9},{21,9}}},
		--poisondamagereturn_p={{{1,10},{10,40},{12,45}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp, 
	},


	tld180={ --????_20
		appenddamage_p= {{{1,55*FightSkill.tbParam.nS180S1},{20,55*FightSkill.tbParam.nS180S20},{29,55*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		physicsenhance_p={{{1,108*FightSkill.tbParam.nS180S1},{20,108*FightSkill.tbParam.nS180S20},{29,108*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		physicsdamage_v={
			[1]={{1,950*0.9*FightSkill.tbParam.nS180S1},{20,950*0.9*FightSkill.tbParam.nS180S20},{29,950*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,1024*1.1*FightSkill.tbParam.nS180S1},{20,1024*1.1*FightSkill.tbParam.nS180S20},{29,1024*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}
			},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		state_hurt_attack={{{1,21},{2,22}},{{1,2*18},{20,2*18}}},
		state_hurt_attacktime={{{1,110},{2,120}}},
		missile_hitcount={{{1,5},{10,5},{20,5},{21,5}}},
		--poisondamagereturn_p={{{1,10},{10,40},{12,45}}},
		skill_vanishedevent={{{1,1748},{20,1748}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},	
	
	tld180con1={ --????_20
		appenddamage_p= {{{1,35*FightSkill.tbParam.nS180S1},{20,35*FightSkill.tbParam.nS180S20},{29,35*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		physicsenhance_p={{{1,108*FightSkill.tbParam.nS180S1},{20,108*FightSkill.tbParam.nS180S20},{29,108*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		physicsdamage_v={
			[1]={{1,1048*0.9*FightSkill.tbParam.nS180S1},{20,1048*0.9*FightSkill.tbParam.nS180S20},{29,883*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,1152*1.1*FightSkill.tbParam.nS180S1},{20,1152*1.1*FightSkill.tbParam.nS180S20},{29,971*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}
			},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		--state_hurt_attack={{{1,21},{2,22}},{{1,2*19},{20,3*18}}},
		--state_hurt_attacktime={{{1,110},{2,120}}},
		missile_hitcount={{{1,5},{10,5},{20,5},{21,5}}},
		skill_vanishedevent={{{1,1749},{20,1749}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},	
	
	tld180con2={ --????_20
		appenddamage_p= {{{1,35*FightSkill.tbParam.nS180S1},{20,35*FightSkill.tbParam.nS180S20},{29,35*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		physicsenhance_p={{{1,128*FightSkill.tbParam.nS180S1},{20,128*FightSkill.tbParam.nS180S20},{29,128*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		physicsdamage_v={
			[1]={{1,1048*0.9*FightSkill.tbParam.nS180S1},{20,1048*0.9*FightSkill.tbParam.nS180S20},{29,883*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,1152*1.1*FightSkill.tbParam.nS180S1},{20,1152*1.1*FightSkill.tbParam.nS180S20},{29,971*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}
			},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		--state_hurt_attack={{{1,21},{2,22}},{{1,2*19},{20,3*18}}},
		--state_hurt_attacktime={{{1,110},{2,120}}},
		missile_hitcount={{{1,5},{10,5},{20,5},{21,5}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},	
	
	
	tyd180={ --????
		appenddamage_p= {{{1,90*FightSkill.tbParam.nS180S1},{20,90*FightSkill.tbParam.nS180S20},{29,90*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		physicsenhance_p={{{1,100*FightSkill.tbParam.nS180S1},{10,100},{20,96*FightSkill.tbParam.nS180S20},{29,96*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		colddamage_v={
			[1]={{1,550*0.9*FightSkill.tbParam.nS180S1},{10,550*0.9},{20,523*0.9*FightSkill.tbParam.nS180S20},{29,523*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,550*1.1*FightSkill.tbParam.nS180S1},{10,550*1.1},{20,523*1.1*FightSkill.tbParam.nS180S20},{29,523*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		attackrating_p={{{1,100},{20,200},{21,200}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_hurt_attack={{{1,16},{2,17}},{{1,18},{20,18}}},
		state_slowall_attacktime={{{1,100},{2,110}}},
		--skill_vanishedevent={{{1,1739},{20,1739}}},
		skill_collideevent={{{1,1739},{20,1739}}},
		--deadlystrikedamageenhance_p={{{1,1*0.5},{2,1}}},
		skill_showevent={{{1,4},{20,4}}},
		missile_range={1,0,1},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	tyd180con={ --????,???????
		state_slowall_attack={{{1,10},{10,25},{20,35}},{{1,27},{20,45},{21,45}}},
		missile_hitcount={{{1,2},{10,3},{20,4},{21,4}}},
	},
	
	
	tyk180={ --????
		appenddamage_p= {{{1,55*FightSkill.tbParam.nS180S1},{20,55*FightSkill.tbParam.nS180S20},{29,55*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		colddamage_v={
			[1]={{1,730*FightSkill.tbParam.nS180S1},{20,730*FightSkill.tbParam.nS180S20},{29,730*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,745*FightSkill.tbParam.nS180S1},{20,745*FightSkill.tbParam.nS180S20},{29,745*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		skill_flyevent={{{1,1741},{20,1741}},{{1,3},{2,3}}},
		--state_slowall_attack={{{1,22},{10,40},{20,61}},{{1,27},{20,54},{20,54}}},
		skill_showevent={{{1,2},{20,2}}},
		missile_hitcount={{{1,5},{5,5},{10,6},{15,6},{20,7},{21,7}}},		
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	
	tyk180con={ --????,???????
		appenddamage_p= {{{1,30*FightSkill.tbParam.nS180S1},{20,30*FightSkill.tbParam.nS180S20},{29,30*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		colddamage_v={
			[1]={{1,400*FightSkill.tbParam.nS180S1},{20,410*FightSkill.tbParam.nS180S20},{29,410*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,400*FightSkill.tbParam.nS180S1},{20,410*FightSkill.tbParam.nS180S20},{29,410*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_slowall_attack={{{1,16},{20,56},{21,56}},{{1,2*18},{20,2*18}}},
		state_slowall_attacktime={{{1,100},{2,110}}},
		missile_hitcount={{{1,2},{10,3},{20,4},{21,4}}},
	},
	
	vokhi180={ --????
		appenddamage_p= {{{1,20},{2,24},{29,135},{30,135}}},
		lightingdamage_v={
			[1]={{1,1144*0.9*FightSkill.tbParam.nS180S1},{10,1144*0.9},{20,1144*0.9*FightSkill.tbParam.nS180S20},{29,968*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,1144*1.1*FightSkill.tbParam.nS180S1},{10,1144*1.1},{20,1144*1.1*FightSkill.tbParam.nS180S20},{29,968*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}
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
	
	vokiem180={ --????
		appenddamage_p= {{{1,40*FightSkill.tbParam.nS180S1},{10,40},{20,40*FightSkill.tbParam.nS180S20},{29,40*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		physicsenhance_p={{{1,72*FightSkill.tbParam.nS180S1},{10,72},{20,72*FightSkill.tbParam.nS180S20},{29,72*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		lightingdamage_v={
			[1]={{1,524*0.9*FightSkill.tbParam.nS180S1},{10,524*0.9},{20,524*0.9*FightSkill.tbParam.nS180S20},{29,524*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,524*1.1*FightSkill.tbParam.nS180S1},{10,524*1.1},{20,524*1.1*FightSkill.tbParam.nS180S20},{29,524*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_hurt_attack={{{1,11},{2,12}},{{1,2*18},{20,2*18}}},
		--steallifeenhance_p={{{1,0.25},{2,0.5}},{{1,100},{10,100}}},
		--stealmanaenhance_p={{{1,0.25},{2,0.5}},{{1,100},{10,100}}},
		state_stun_attack={{{1,15},{20,50},{21,50}},{{1,2*9},{20,2*9}}},
		state_stun_attacktime={{{1,60},{2,65}}},
		skill_showevent={{{1,1},{20,1}}},
		missile_hitcount={{{1,3},{10,4},{20,5},{21,5}}},
		attackratingenhance_p={{{1,30},{20,100},{21,105}}},
		skill_vanishedevent={{{1,1733},{20,1733}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	vokiem180con={ --????,???????
		state_stun_attack={{{1,31},{2,40}},{{1,2*18},{20,2*18}}},
		missile_hitcount={{{1,3},{10,4},{20,5},{21,5}}},
	},

	mn180={ --????
		appenddamage_p= {{{1,56*FightSkill.tbParam.nS180S1},{20,56*FightSkill.tbParam.nS180S20},{29,56*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		firedamage_v={
			[1]={{1,700*0.9*FightSkill.tbParam.nS180S1},{20,700*0.9*FightSkill.tbParam.nS180S20},{29,700*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,700*1.1*FightSkill.tbParam.nS180S1},{20,700*1.1*FightSkill.tbParam.nS180S20},{29,700*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_burn_attack={{{1,14},{20,51},{21,51}},{{1,18},{10,27},{11,27}}},	
		state_burn_attacktime={{{1,50},{2,60}}},
		skill_vanishedevent={{{1,1719},{20,1719}}},
		skill_showevent={{{1,8},{20,8}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	mn180con={ --????,???????
		appenddamage_p= {{{1,10*FightSkill.tbParam.nS180S1},{20,10*FightSkill.tbParam.nS180S20},{29,10*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}},
		firedamage_v={
			[1]={{1,270*0.9*FightSkill.tbParam.nS180S1},{20,270*0.9*FightSkill.tbParam.nS180S20},{29,270*0.9*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}},
			[3]={{1,270*1.1*FightSkill.tbParam.nS180S1},{20,270*1.1*FightSkill.tbParam.nS180S20},{29,270*1.1*FightSkill.tbParam.nS180S20*FightSkill.tbParam.nS180Sadd}}
		},
		
	},
}
FightSkill:AddMagicData(tb) 