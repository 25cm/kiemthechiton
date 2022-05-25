Require("\\script\\fightskill\\fightskill.lua")
--ÌìÍõ
local tb	= {
	--Ç¹Ìì --Thien Vuong
	huifengluoyan={ --»Ø·çÂäÑã_20
		appenddamage_p= {{{1,50},{20,50},{21,50*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,10},{10,100},{20,200},{21,200*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,30*0.9},{10,165*1.1},{20,315*0.9},{21,315*FightSkill.tbParam.nSadd1*0.9}},
			[3]={{1,30*1.1},{10,165*1.1},{20,315*1.1},{21,315*FightSkill.tbParam.nSadd1*1.1}}
			},
	--	attackrating_p={{{1,20},{20,50}}},
		skill_cost_v={{{1,2},{20,20},{21,20}}},
		state_hurt_attack={{{1,15},{10,30},{20,35}},{{1,18},{20,18}}},
		seriesdamage_r={{{1,50},{20,100},{21,100}}},
		addskilldamagep={43, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={44, {{1,2},{20,30},{21,35}}},
		addskilldamagep3={47, {{1,2},{20,10},{21,12}},1},
		addskilldamagep4={48, {{1,2},{20,10},{21,12}}},
	},
	tianwangqiangfa={ --ÌìÍõÇ¹·¨_10
		addphysicsdamage_p={{{1,5},{10,165},{12,198}}},
		attackratingenhance_p={{{1,50},{10,135},{12,162}}},
		deadlystrikeenhance_r={{{1,30},{10,50},{11,55}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	duanhunci={ --¶Ï»ê´Ì_10
		state_fixed_attack={{{1,35},{10,85},{12,90}},{{1,18*2},{20,18*2}}},
		state_hurt_attack={{{1,27},{10,54},{11,56}},{{1,18},{20,18}}},
		missile_hitcount={{{1,3},{10,3},{11,4},{12,4}}},
		skill_cost_v={{{1,20},{10,50},{11,50}}},
		skill_attackradius={550},
		skill_param1_v={32},
	},
	yangguansandie={ --Ñô¹ØÈýµþ_20
		appenddamage_p= {{{1,50},{20,50},{21,50*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,10},{10,100},{20,182},{21,182*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,300*0.9},{10,390*0.9},{20,490*0.9},{21,490*FightSkill.tbParam.nSadd1*0.9}},
			[3]={{1,300*1.1},{10,390*1.1},{20,490*1.1},{21,490*FightSkill.tbParam.nSadd1*1.1}}
			},
	--	attackrating_p={{{1,30},{20,60}}},
		skill_cost_v={{{1,20},{20,50},{21,50}}},
		state_hurt_attack={{{1,15},{10,35},{20,40},{21,41}},{{1,18},{20,18}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		addskilldamagep={47, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={48, {{1,2},{20,30},{21,35}}},
	},
	jingxinjue={ --¾²ÐÄ¾÷_10
		lifemax_p={{{1,10},{20,80},{21,82}}},
		poisontimereduce_p={{{1,5},{20,30},{23,35}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	jingleipotian={ --¾ªÀ×ÆÆÌì_10
		autoskill={{{1,10},{2,10}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	jingleipotian_child={ --¾ªÀ×ÆÆÌì×Ó
		-- prop_invincibility={1},
		skill_statetime={{{1,18*1},{10,18*8},{11,18*8}}},
	},
	jingleipotian_child2={ --¾ªÀ×ÆÆÌì×Ó×Ó
		deadlystrikeenhance_r={{{1,50},{10,240},{11,260}}},
		state_hurt_attackrate={{{1,15},{10,80},{11,84}}},
		skill_statetime={{{1,18*3},{10,18*15},{11,18*15}}},
	},
	tianwangzhanyi={ --ÌìÍõÕ½Òâ_20
		addphysicsdamage_p={{{1,25},{20,210},{21,219}}},
		deadlystrikeenhance_r={{{1,10},{20,50},{21,55}}},
		state_hurt_attackrate={{{1,15},{20,80},{23,90}}},
		skill_cost_v={{{1,300},{20,500},{21,500}}},
		skill_statetime={{{1,18*180},{20,18*300}}},
	},
	tianwangzhanyi_ally={ --ÌìÍõÕ½Òâ_20
		addphysicsdamage_p={{{1,15},{20,60},{21,63}}},
		deadlystrikeenhance_r={{{1,10},{20,30},{21,33}}},
		state_hurt_attackrate={{{1,10},{20,45},{23,49}}},
		skill_statetime={{{1,18*180},{20,18*300}}},
	},
	zhuixingzhuyue={ --×·ÐÇÖðÔÂ
		appenddamage_p= {{{1,40*FightSkill.tbParam.nS1},{10,40},{20,40*FightSkill.tbParam.nS20},{21,40*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,90*FightSkill.tbParam.nS1},{10,90},{20,90*FightSkill.tbParam.nS20},{21,90*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,660*0.9*FightSkill.tbParam.nS1},{10,660*0.9},{20,660*0.9*FightSkill.tbParam.nS20},{21,660*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,660*1.1*FightSkill.tbParam.nS1},{10,660*1.1},{20,660*1.1*FightSkill.tbParam.nS20},{21,660*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		seriesdamage_r={{{1,100},{20,200},{21,200}}},
		skill_cost_v={{{1,22},{20,45},{21,45}}},
		state_hurt_attack={{{1,5},{10,10},{20,10}},{{1,18},{20,18}}},-- xac xuat lam tho thuong
		missile_hitcount={{{1,3},{20,3}}},
	},
	tiangangzhanqi={ --Ììî¸Õ½Æø
	--	state_hurt_attackrate={{{1,10},{20,100}}},
		state_weak_resistrate={{{1,10},{10,100},{20,150}}},
		lifereplenish_p={{{1,5},{20,20},{21,21}}},
		attackratingenhance_p={{{1,50},{20,100}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	xuezhanbafang={ --ÑªÕ½°Ë·½
		skilldamageptrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		skillselfdamagetrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		state_hurt_attacktime={{{1,10},{10,80}}},
		state_weak_resisttime={{{1,10},{10,120}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},

	pijingzhanji={ --ÖÐ¼¶ÃØ¼®£ºÅû¾£Õ¶¼¬
		addenchant={14, {{1,1}, {2, 2}}},
		--addskillcastrange={41, 0, {{1,25}, {10, 250}}},
		--addrunattackspeed={41, 0, {{1,2}, {10, 18}}},
		addstartskill={41, 1224, {{1,1}, {10, 10}}},
		skill_skillexp_v=FightSkill.tbParam.tbMidBookSkillExp,
		skill_statetime={{{1,-1},{2,-1}}},
	},
	pijingzhanji_child={ --ÖÐ¼¶ÃØ¼®£ºÅû¾£Õ¶¼¬
		state_hurt_ignore={1},
		state_slowall_ignore={1},
		state_stun_ignore={1},
		state_fixed_ignore={1},
		--ignoreskill={{{1,50},{2,50}},0,{{1,5},{2,5}}},
		skill_statetime={{{1,18},{2,18}}},
	},
	pijingzhanji_child2={ --ÖÐ¼¶ÃØ¼®£º³Ë·çÆÆÀË×Ó
		missile_missrate={{{1,50},{2,50}}},
		ignoreskill={{{1,100},{2,100}},0,{{1,5},{2,5}}},
		skill_statetime={{{1,18},{2,18}}},
	},
	benleizuanlongqiang={ --±¼À××êÁúÇ¹_10 110 thien vuong
		appenddamage_p= {{{1,100*0.7*1.0},{10,100*1.0},{11,100*FightSkill.tbParam.nSadd1*1.0}}},
		physicsenhance_p={{{1,85*0.7*1.0},{10,85*1.0},{11,85*FightSkill.tbParam.nSadd1*1.0}}},
		physicsdamage_v={
			[1]={{1,375*0.9*0.7*1.0},{10,375*0.9*1.0},{11,375*0.9*FightSkill.tbParam.nSadd1*1.0}},
			[3]={{1,375*1.1*0.7*1.0},{10,375*1.1*1.0},{11,375*1.1*FightSkill.tbParam.nSadd1*1.0}}
			},
		seriesdamage_r={{{1,250},{10,250},{11,250}}},
		state_hurt_attack={{{1,5},{10,5},{11,5}},{{1,18},{10,18}}},
		missile_hitcount={{{1,11},{10,11}}},
		runattack_damageadded={{{1,-10},{10,-10}}},

		skill_missilenum_v={{{1,5},{10,5},{11,5}},1},
		skill_mintimepercast_v={{{1,20*18},{10,20*18}}},
		skill_cost_v={{{1,180},{10,180},{11,180}}},
	},
	benleizuanlongqiang2={ --±¼À××êÁúÇ¹_10 110 thien vuong
		appenddamage_p= {{{1,100*0.7*1.0},{10,100*1.0},{11,100*FightSkill.tbParam.nSadd1*1.0}}},
		physicsenhance_p={{{1,85*0.7*1.0},{10,85*1.0},{11,85*FightSkill.tbParam.nSadd1*1.0}}},
		physicsdamage_v={
			[1]={{1,375*0.9*0.7*1.0},{10,375*0.9*1.0},{11,375*0.9*FightSkill.tbParam.nSadd1*1.0}},
			[3]={{1,375*1.1*0.7*1.0},{10,375*1.1*1.0},{11,375*1.1*FightSkill.tbParam.nSadd1*1.0}}
			},
		seriesdamage_r={{{1,250},{10,250},{11,250}}},
		state_hurt_attack={{{1,15},{10,60},{11,63}},{{1,18},{10,18}}},
		missile_hitcount={{{1,11},{10,11}}},
		runattack_damageadded={{{1,-10},{10,-10}}},
	},
	benleizuanlongqiang_child={ --±¼À××êÁúÇ¹ÃâÒß
		ignoredebuff={{{1,32767},{2,32767}}},
		--prop_invincibility={1},
		redeivedamage_dec_p2={{{1,300},{10,300}}},
		skill_statetime={{{1,18*60},{2,18*60}}},
	},
	qiangtianadvancedbook={ --Ç¹Ìì¸ß¼¶ÃØ¼®_10
		autoskill={{{1,43},{2,43}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{2,-1}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	qiangtianadvancedbook_child={ --Ç¹Ìì¸ß¼¶ÃØ¼®_10
		skilldamageptrim		={{{1,1},{10,3},{11,3}}},
		skillselfdamagetrim		={{{1,1},{10,3},{11,3}}},
		superposemagic={{{1,10},{10,100},{11,105}}},
		skill_statetime={{{1,5*18},{10,5*18},{12,5.5*18}}},
	},
	qiangtian120={ --Ç¹Ìì120_10
		deadlystrikeenhance_r={{{1,30},{10,150},{11,155}}},
		deadlystrikedamageenhance_p={{{1,2},{10,20},{11,22}}},
		state_hurt_ignore={1},
		state_weak_ignore={1},
		state_slowall_ignore={1},
		state_stun_ignore={1},
		skill_statetime={{{1,6*18},{10,15*18},{11,16*18}}},
		autoskill={{{1,70},{2,70}},{{1,1},{10,10}}},
		skill_cost_v={{{1,500},{10,500}}},
		skill_mintimepercast_v={{{1,45*18},{10,45*18}}},
		skill_mintimepercastonhorse_v={{{1,45*18},{10,45*18}}},
	},
	qiangtian120_child={ --Ç¹Ìì120_×Ó_10
		state_hurt_ignore={1},
		state_weak_ignore={1},
		state_slowall_ignore={1},
		state_stun_ignore={1},
		skill_statetime={{{1,2*18},{10,2*18},{11,2*18}}},
	},
	--´¸Ìì
	xingyunjue={ --ÐÐÔÆ¾÷_20
		appenddamage_p= {{{1,80},{20,80},{21,80*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,5},{10,50},{20,100},{21,100*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,50*0.9},{10,140*0.9},{20,240*0.9},{21,240*FightSkill.tbParam.nSadd1*0.9}},
			[3]={{1,50*1.1},{10,140*1.1},{20,240*1.1},{21,240*FightSkill.tbParam.nSadd1*1.1}}
			},
	--	attackrating_p={{{1,50},{20,100}}},
		skill_cost_v={{{1,2},{20,20},{21,20}}},
		state_hurt_attack={{{1,15},{10,20},{20,25},{21,25},{22,26}},{{1,18},{20,18}}},
		seriesdamage_r={{{1,50},{20,100},{21,100}}},
		addskilldamagep={53, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={54, {{1,2},{20,30},{21,35}}},
		addskilldamagep3={56, {{1,2},{20,10},{21,12}},1},
		addskilldamagep4={57, {{1,2},{20,10},{21,12}}},
	},
	tianwangchuifa={ --ÌìÍõ´¸·¨_10
		addphysicsdamage_p={{{1,5},{10,145},{12,174}}},
		attackratingenhance_p={{{1,50},{10,200},{11,220}}},
		deadlystrikeenhance_r={{{1,30},{10,50},{11,55}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	jingxinshu={ --¾²ÐÄÊõ_20
		lifemax_p={{{1,10},{20,80},{21,82}}},
		poisontimereduce_p={{{1,5},{20,30},{23,35}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	zhuifengjue={ --×··ç¾÷_20
		appenddamage_p= {{{1,75},{20,75},{21,75*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,5},{10,68},{20,128},{21,128*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,150*0.9},{10,195*0.9},{20,245*0.9},{21,245*FightSkill.tbParam.nSadd1*0.9}},
			[3]={{1,150*1.1},{10,195*1.1},{20,245*1.1},{21,245*FightSkill.tbParam.nSadd1*1.1}}
			},
	--	attackrating_p={{{1,80},{20,120}}},
		skill_cost_v={{{1,20},{20,50},{21,50}}},
		state_hurt_attack={{{1,15},{10,20},{20,25},{21,25},{22,26}},{{1,18},{20,18}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		addskilldamagep={56, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={57, {{1,2},{20,30},{21,35}}},
	},
	tianwangbensheng={ --ÌìÍõ±¾Éú_10
		autoskill={{{1,11},{2,11}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	tianwangbensheng_child={ --ÌìÍõ±¾Éú×Ó
		-- prop_invincibility={1}, -- Kháng sát thương
		redeivedamage_dec_p={10000},
		-- ignoredebuff={{{1,32767},{2,32767}}},
		removestate={{{1,800},{2,800}}},
		skill_statetime={{{1,18*2},{10,18*5},{11,18*5.25}}},
	},
	jinzhongzhao={ --½ðÖÓÕÖ_20
		damage_physics_resist={{{1,10},{10,50},{20,150},{21,157}}},
		damage_poison_resist={{{1,10},{10,50},{20,150},{21,157}}},
		damage_cold_resist={{{1,10},{10,50},{20,150},{21,157}}},
		damage_light_resist={{{1,10},{10,50},{20,150},{21,157}}},
		state_hurt_attackrate={{{1,10},{20,80},{21,84}}},
		skill_cost_v={{{1,300},{20,500},{21,500}}},
		skill_statetime={{{1,18*60*1.5},{20,18*60*3},{21,18*60*3}}},
	},
	jinzhongzhao_ally={ --½ðÖÓÕÖ_20
		damage_physics_resist={{{1,10},{10,30},{20,60},{21,63}}},
		damage_poison_resist={{{1,10},{10,30},{20,60},{21,63}}},
		damage_cold_resist={{{1,10},{10,30},{20,60},{21,63}}},
		damage_light_resist={{{1,10},{10,30},{20,60},{21,63}}},
		skill_statetime={{{1,18*60*1.5},{20,18*60*3},{21,18*60*3}}},
	},
	chenglongjue={ --³ËÁú¾÷_20
		appenddamage_p= {{{1,65*FightSkill.tbParam.nS1},{10,65},{20,65*FightSkill.tbParam.nS20},{21,65*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsenhance_p={{{1,100*FightSkill.tbParam.nS1},{10,100},{20,100*FightSkill.tbParam.nS20},{21,100*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}},
		physicsdamage_v={
			[1]={{1,250*0.9*FightSkill.tbParam.nS1},{10,250*0.9},{20,250*0.9*FightSkill.tbParam.nS20},{21,250*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}},
			[3]={{1,250*1.1*FightSkill.tbParam.nS1},{10,250*1.1},{20,250*1.1*FightSkill.tbParam.nS20},{21,250*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd1}}
			},
		skill_cost_v={{{1,22},{20,45},{21,45}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_hurt_attack={{{1,15},{10,25},{20,35}},{{1,18},{20,18}}},
		missile_hitcount={{{1,4},{20,4}}},
	},
	daoxutian={ --µ¹ÐéÌì_20
	--	state_hurt_attackrate={{{1,10},{20,100}}},
		state_weak_resistrate={{{1,10},{10,100},{20,150}}},
		lifereplenish_p={{{1,5},{20,25},{21,26}}},
		ignoredefenseenhance_v={{{1,50},{10,200},{20,250}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	bumieshayi={ --²»ÃðÉ±Òâ_10
		skilldamageptrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		skillselfdamagetrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		state_hurt_attacktime={{{1,10},{10,80}}},
		state_weak_resisttime={{{1,10},{10,120}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},

	zhanlongjue={ --Õ¶Áú¾÷_10
		autoskill={{{1,65},{2,65}},{{1,1},{10,10}}},
		addedwith_enemycount={{{1,1183},{10,1183}},{{1,3},{10,10},{11,11}}, {{1,1600},{10,1600}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	zhanlongjue_child={ --Õ¶Áú¾÷×Ó_10
		damage_all_resist={{{1,10},{2,10}}},
		allseriesstateresistrate={{{1,26},{2,26}}},
		state_fixed_resistrate={{{1,26},{2,26}}},
		deadlystrikeenhance_r={{{1,24},{2,24}}},
		addphysicsdamage_p={{{1,20},{2,20}}},
		skill_statetime={{{1,18*2.5},{2,18*2.5}}},
	},
	zhanlongjue_child2={ --Õ¶Áú¾÷×Ó_10
		decautoskillcdtime={260,11,{{1,18*1},{10,18*1}}},
		skill_statetime={{{1,1*18},{10,1*18},{11,1*18}}},
	},

	chuitianadvancedbook={ --´¸Ìì¸ß¼¶ÃØ¼®_10
		autoskill={{{1,48},{2,48}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{2,-1}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	chuitianadvancedbook_child={ --´¸Ìì¸ß¼¶ÃØ¼®_10
		skilldamageptrim		={{{1,1},{10,10},{11,11}}},
		skillselfdamagetrim		={{{1,1},{10,10},{11,11}}},
		superposemagic={{{1,2},{10,10},{11,10}}},
		skill_statetime={{{1,6.5*18},{2,6.5*18}}},
	},
	chuitian120={ --锤天120_10
		skilldamageptrim		={{{1,5},{10,20},{11,22}}},
		skillselfdamagetrim		={{{1,5},{10,20},{11,22}}},
		poisontimereduce_p={{{1,5},{10,30},{13,35}}},
		state_hurt_attacktime={{{1,10},{10,80}}},
		state_weak_resisttime={{{1,10},{10,120}}},
	},
	chuitian120_team={ --锤天120_队友_10
		skilldamageptrim		={{{1,1},{10,10},{11,11}}},
		skillselfdamagetrim		={{{1,1},{10,10},{11,11}}},
		poisontimereduce_p={{{1,2},{10,15},{13,20}}},
		state_hurt_attacktime={{{1,5},{10,40}}},
		state_weak_resisttime={{{1,4},{10,40}}},
	},
}

FightSkill:AddMagicData(tb)

local tbSkill	= FightSkill:GetClass("jingleipotian");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbCCInfo	= KFightSkill.GetSkillInfo(tbChildInfo.tbEvent.nStartSkillId, tbChildInfo.tbEvent.nLevel);
	local szMsg	= string.format("Khi sinh lực giảm xuống 25%%, xác suất thi triển: <color=gold>%d%%<color>\nKhông thọ thương, duy trì <color=Gold>%s giây<color>\nChí mạng <color=gold>tăng %s<color>\nXác suất tạo thọ thương <color=gold> tăng %s<color>, duy trì <color=gold>%s giây<color>\nThời gian giãn cách: <color=Gold>%s giây<color>",
		tbAutoInfo.nPercent,
		FightSkill:Frame2Sec(tbChildInfo.nStateTime),
		tbCCInfo.tbWholeMagic["deadlystrikeenhance_r"][1],
		tbCCInfo.tbWholeMagic["state_hurt_attackrate"][1],
		FightSkill:Frame2Sec(tbCCInfo.nStateTime),
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("tianwangbensheng");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local nPerCastTime = (tbAutoInfo.nPerCastTime - KFightSkill.GetAutoSkillCDTimeAddition(tbSkillInfo.nId, tbAutoInfo.nId));
	if (nPerCastTime < 0) then
		nPerCastTime = 0;
	end
	local szMsg	= string.format("Khi sinh lực giảm xuống 25%%, xác suất thi triển: <color=gold>%d%%<color>\nKhông thọ thương, duy trì <color=Gold>%s giây<color>\nThời gian giãn cách: <color=Gold>%s giây<color>",
		tbAutoInfo.nPercent,
		FightSkill:Frame2Sec(tbChildInfo.nStateTime),
		FightSkill:Frame2Sec(nPerCastTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("qiangtianadvancedbook");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg = ""
	local tbMsg = {};
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0)
	szMsg = szMsg.."Khi tấn công chí mạng kẻ địch nhận được trạng thái sau:\n";
	szMsg = szMsg.."    ".."<color=green>Liên Hoàn Đoạt Mệnh<color>\n";
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	--szMsg = szMsg.."\n´¥·¢¼ä¸ôÊ±¼ä£º<color=Gold>"..FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime).."Ãë<color>";
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("chuitianadvancedbook");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg = ""
	local tbMsg = {};
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0)
	szMsg = szMsg.."Khi bị tấn công nhận được trạng thái sau:\n";
	szMsg = szMsg.."    ".."<color=green>Càn Khôn Đảo Huyền<color>\n";
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	szMsg = szMsg.."\nPhát huy lực tấn công cơ bản: <color=Gold>"..FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime).."%<color>";
	return szMsg;
end;

local tbSkill = FightSkill:GetClass("qiangtian120")

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	--[[local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg = ""
	local tbMsg = {};
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0)
	for i=1, #tbMsg do
		szMsg = szMsg..""..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end]]
	local szMsg = "Trạng thái trung, phụ cận hữu phương cũng khả thu được định thân bên ngoài đích miễn dịch hiệu quả";
	return szMsg;
end

local tbSkill = FightSkill:GetClass("zhanlongjue")

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg = ""
	if tbAutoInfo.nPercent >= 1 then
		szMsg = szMsg.."Khi bị công kích có xác suất <color=Gold>"..tbAutoInfo.nPercent.."%<color>\n"
		local tbMsg = {};
		FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0)
		for i=1, #tbMsg do
			szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
		end
	end
	return szMsg;
end
