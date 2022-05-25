Require("\\script\\fightskill\\fightskill.lua")
local tb	= {
	fengjuancanxue={ --风卷残雪_20
		appenddamage_p= {{{1,100},{20,100},{21,100*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,50*0.9},{10,410*1.1},{20,810*0.9},{21,810*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,50*1.1},{10,410*1.1},{20,810*1.1},{21,810*FightSkill.tbParam.nSadd*1.1}}
		},
		state_slowall_attack={{{1,15},{10,30},{20,35},{21,36}},{{1,27},{20,45},{21,45}}},
		seriesdamage_r={{{1,50},{20,100},{21,100}}},
		skill_cost_v={{{1,10},{20,50},{21,50}}},
		addskilldamagep={114, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={117, {{1,2},{20,10},{21,12}},1},
		addskilldamagep3={118, {{1,2},{20,10},{21,12}}},
	},
	cuiyanjianfa={ --翠烟剑法_10
		addcoldmagic_v={{{1,15},{10,300},{11,330}}},
		deadlystrikeenhance_r={{{1,30},{10,50},{11,55}}},
		castspeed_v={{{1,5},{10,15},{11,16},{12,17},{13,17}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	hutihanbing={ --护体寒冰_10
		rangedamagereturn_p={{{1,5},{10,20},{11,21}}},
		adddefense_v={{{1,100},{10,200},{11,210}}},
		lifemax_p={{{1,15},{10,45},{14,54}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	bihaichaosheng={ --碧海潮生_20
		appenddamage_p= {{{1,100},{10,110},{20,120},{21,120*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,400*0.9},{10,490*0.9},{20,540*0.9},{21,540*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,400*1.1},{10,490*1.1},{20,540*1.1},{21,540*FightSkill.tbParam.nSadd*1.1}}
		},
		state_slowall_attack={{{1,30},{10,45},{20,50},{21,51}},{{1,27},{20,45},{21,45}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,50},{20,150},{21,150}}},
		addskilldamagep={117, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={118, {{1,2},{20,30},{21,35}}},
		missile_hitcount={{{1,5},{5,5},{10,6},{15,6},{20,7},{21,7}}},
	},
	xueying={ --雪影_20
		fastwalkrun_p={{{1,10},{20,40},{21,41}}},
		state_burn_resisttime={{{1,15},{20,135},{21,141}}},
		skill_cost_v={{{1,100},{10,150},{20,300},{21,300}}},
		skill_statetime={{{1,18*180},{20,18*300},{21,18*300}}},
	},
	xuanbingwuxi={ --玄冰无息_10
		autoskill={{{1,15},{2,15}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	xuanbingwuxi_child={ --玄冰无息子_10
		state_freeze_attack={{{1,25},{10,75},{11,80}},{{1,18*1.5},{10,18*3},{11,18*3.1}}},
		missile_hitcount={{{1,3},{10,5},{11,5}}},
	},
	xuanbingwuxi_self={ --玄冰无息自身
		damage_all_resist={{{1,800},{10,1200},{11,1220}}},
		skill_statetime={{{1,18*1},{10,18*1.5},{12,18*1.6}}},
	},
	xueyinghongchen_team={ --雪映红尘_20
		lifereplenish_p={{{1,5},{20,15},{21,16}}},
		manareplenish_p={{{1,2},{20,10},{21,11}}},
	},
	xueyinghongchen={ --雪映红尘
		lifereplenish_p={{{1,10},{20,30},{21,31}}},
		manareplenish_p={{{1,10},{20,20},{21,21}}},
	},
	bingxinxianzi={ --冰心仙子
		appenddamage_p= {{{1,60*FightSkill.tbParam.nS1},{10,60},{20,60*FightSkill.tbParam.nS20},{21,60*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,300*0.9*FightSkill.tbParam.nS1},{10,300*0.9},{20,300*0.9*FightSkill.tbParam.nS20},{21,300*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,300*1.1*FightSkill.tbParam.nS1},{10,300*1.1},{20,300*1.1*FightSkill.tbParam.nS20},{21,300*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		skill_flyevent={{{1,118},{20,118}},{{1,3},{2,3}}},
		skill_showevent={{{1,2},{20,2}}},
		missile_hitcount={{{1,5},{5,5},{10,6},{15,6},{20,7},{21,7}}},
	},
	fengxuebingtian={ --风雪冰天，冰心仙子第二式
		appenddamage_p= {{{1,35*FightSkill.tbParam.nS1},{10,35},{20,35*FightSkill.tbParam.nS20},{21,35*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,225*0.9*FightSkill.tbParam.nS1},{10,225*0.9},{20,225*0.9*FightSkill.tbParam.nS20},{21,225*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,225*1.1*FightSkill.tbParam.nS1},{10,225*1.1},{20,225*1.1*FightSkill.tbParam.nS20},{21,225*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_slowall_attack={{{1,30},{10,45},{20,50}},{{1,27},{20,45},{21,45}}},
		missile_hitcount={{{1,2},{10,3},{20,4},{21,4}}},
	},
	bingguxuexin={ --冰骨雪心_20
		state_slowall_attackrate={{{1,10},{20,100}}},
		state_burn_resistrate={{{1,10},{10,100},{20,150}}},
		castspeed_v={{{1,10},{10,16},{20,26},{23,29},{24,29}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	fuyunsanxue={ --浮云散雪
		skilldamageptrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		skillselfdamagetrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		state_slowall_attacktime={{{1,10},{10,80}}},
		state_burn_resisttime={{{1,10},{10,120}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	
	yudalihua={ --中级秘籍：雨打梨花
		state_fixed_ignore={1},
		state_palsy_ignore={1},
		state_confuse_ignore={1},
		state_knock_ignore={1},
		state_drag_ignore={1},
		state_freeze_ignore={1},
		skill_mintimepercast_v={{{1,40*18},{10,20*18},{11,20*18}}},
		skill_mintimepercastonhorse_v={{{1,40*18},{10,20*18},{11,20*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbMidBookSkillExp,
		skill_statetime={{{1,18*0.5},{10,18*5},{12,18*5.5}}},
	},
	yudalihua_child={ --中级秘籍：雨打梨花
		damage_cold_resist={{{1,-110},{10,-200},{11,-210}}},
		state_slowall_attack={{{1,35},{10,80},{12,85}},{{1,18*3},{10,18*5},{11,18*5}}},
		missile_hitcount={{{1,3},{2,3}}},
		skill_statetime={{{1,18*2},{10,18*5},{11,18*5}}},
	},	
	yudalihua_child2={ --中级秘籍：春泥护花
		state_palsy_resistrate		={{{1,26},{10,260},{11,286}}},
		state_confuse_resistrate	={{{1,26},{10,260},{11,286}}},
		state_knock_resistrate		={{{1,26},{10,260},{11,286}}},
		state_drag_resistrate		={{{1,26},{10,260},{11,286}}},
		skill_statetime={{{1,18*300},{10,18*300}}},
	},	
	shimianmaifu_self={ --十面埋伏自身_10
		addenchant={31, {{1,1}, {2, 2}}},
		skilldamageptrim={{{1,2},{10,20}}},
		skillselfdamagetrim={{{1,2},{10,20}}},
		skill_statetime={{{1,18*30},{10,18*30}}},
		skill_startevent={{{1,1193},{10,1193}}},
		skill_eventskilllevel={{{1,1},{10,10},{11,10}}},
		skill_showevent={{{1,1},{10,1}}},
		skill_cost_v={{{1,100},{10,100},{11,100}}},
		skill_mintimepercast_v={{{1,80*18},{10,80*18},{11,80*18}}},
		skill_mintimepercastonhorse_v={{{1,80*18},{10,80*18},{11,80*18}}},
	},
	shimianmaifu={ --十面埋伏_队友_10
		autoskill={{{1,71},{2,71}},{{1,1},{10,10}}},
		skill_statetime={{{1,10*18},{10,15*18},{11,15*18}}},
	},
	shimianmaifu_child={ --十面埋伏_队友_子_10
		hide={0,{{1,2*18},{10,2*18}}, 2},
	},

	jiancuiadvancedbook={ --剑翠高级秘籍_飞絮飘花_10
		appenddamage_p= {{{1,15*0.5},{10,15},{11,15*1.05}}},
		colddamage_v={
			[1]={{1,67.5*0.9*0.5},{10,67.5*0.9},{11,67.5*0.9*1.05}},
			[3]={{1,67.5*1.1*0.5},{10,67.5*1.1},{11,67.5*1.1*1.05}}
			},
		seriesdamage_r={{{1,250},{10,250}}},
		state_slowall_attack={{{1,3},{10,30}},{{1,45},{10,45}}},
		state_fixed_attack={{{1,1},{10,15}},{{1,18*3},{10,18*3}}},
	},
	jiancuiadvancedbook_fellow={ --剑翠高级秘籍_10
		skill_cost_v={{{1,200},{10,200}}},
		skill_mintimepercast_v={{{1,15*18},{10,15*18}}},
		skill_mintimepercastonhorse_v={{{1,15*18},{10,15*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
		skill_maxmissile={{{1,3},{10,3}}},
	},
	jiancui120={ --剑翠120_10
		autoskill={{{1,53},{2,53}},{{1,1},{10,10}}},
		skill_statetime={{{1,15*18},{2,15*18}}},
		skill_cost_v={{{1,500},{10,500}}},
		skill_mintimepercast_v={{{1,30*18},{10,30*18}}},
		skill_mintimepercastonhorse_v={{{1,30*18},{10,30*18}}},
	},
	jiancui120_child={ --剑翠120_子_10
		appenddamage_p= {{{1,75*0.7},{10,75},{11,75*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,350*0.9*0.7},{10,350*0.9},{11,350*0.9*FightSkill.tbParam.nSadd}},
			[3]={{1,350*1.1*0.7},{10,350*1.1},{11,350*1.1*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,250},{10,250}}},
		state_slowall_attack={{{1,45},{10,50}},{{1,45},{10,45}}},
	},
	
	fenghuaxueyue={ --风花雪月_20
		appenddamage_p= {{{1,100},{20,100},{21,100*FightSkill.tbParam.nSadd}}},
		seriesdamage_r={{{1,50},{20,100},{21,100}}},
		physicsenhance_p={{{1,10},{10,100},{20,150},{21,157}}},
		colddamage_v={
			[1]={{1,50*0.85},{10,245*0.9},{20,450*0.9},{21,450*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,50*1.15},{10,245*1.1},{20,450*1.1},{21,450*FightSkill.tbParam.nSadd*1.1}}
		},
		state_hurt_attack={{{1,15},{20,35},{21,36}},{{1,18},{20,18}}},
		state_slowall_attack={{{1,30},{10,45},{20,50},{21,51}},{{1,27},{20,45},{21,45}}},
		skill_cost_v={{{1,2},{20,20},{21,20}}},
		addskilldamagep={123, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={125, {{1,2},{20,10},{21,12}},1},
		addskilldamagep3={126, {{1,2},{20,10},{21,12}}},
		missile_speed_v={40},
	},
	cuiyandaofa={ --翠烟刀法_10
			lifemax_p={{{1,10},{10,30},{11,33}}},
		addphysicsdamage_p={{{1,10},{10,150},{11,165}}},
		attackratingenhance_p={{{1,50},{10,150},{11,165}}},
		deadlystrikeenhance_r={{{1,30},{10,50},{11,55}}},
		attackspeed_v={{{1,5},{10,15},{11,16},{12,17},{13,17}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	yuxueyin={ --御雪隐_10
		skill_cost_v={{{1,50},{10,100},{11,100}}},
		hide={0,{{1,5*18},{10,30*18},{13,33*18}}, 1},
		skill_mintimepercast_v={{{1,60*18},{10,40*18},{11,40*18}}},
		skill_mintimepercastonhorse_v={{{1,60*18},{10,40*18},{11,40*18}}},
	},
	yuxueyin_child={ --御雪隐_会心
		deadlystrikeenhance_r={{{1,4000},{10,8000},{11,8400}}},
		attackspeed_v={{{1,20},{10,100},{11,110}}},
		skill_statetime={{{1,5*18},{10,30*18},{12,33*18}}},
	},
	muyeliuxing={ --牧野流星_20
		appenddamage_p= {{{1,50},{20,50},{21,50*FightSkill.tbParam.nSadd}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		physicsenhance_p={{{1,50},{10,86},{20,126},{21,126*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,100*0.95},{10,190*0.9},{20,290*0.95},{21,290*FightSkill.tbParam.nSadd*0.95}},
			[3]={{1,100*1.05},{10,190*1.1},{20,290*1.05},{21,290*FightSkill.tbParam.nSadd*1.05}}
		},
		state_hurt_attack={{{1,5},{20,15},{21,16}},{{1,18},{20,18}}},
		state_slowall_attack={{{1,30},{10,45},{20,50},{21,51}},{{1,27},{20,45},{21,46}}},
		skill_cost_v={{{1,20},{20,50},{21,50}}},
		addskilldamagep={125, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={126, {{1,2},{20,30},{21,35}}},
		missile_range={1,0,1},
	},
	bingxinqianying={ --冰心倩影_20
		attackratingenhance_p={{{1,30},{10,70},{20,100},{21,103}}},
		adddefense_v={{{1,50},{10,150},{20,200},{21,208}}},
		damage_all_resist={{{1,10},{20,50},{22,55}}},
		deadlystrikedamageenhance_p={{{1,1},{20,20},{21,21}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	bingzongwuying={ --冰踪无影
		appenddamage_p= {{{1,30*1.1*FightSkill.tbParam.nS1},{10,30*1.1},{20,30*1.1*FightSkill.tbParam.nS20},{21,30*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,80*FightSkill.tbParam.nS1},{10,80},{20,80*FightSkill.tbParam.nS20},{21,80*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,350*0.9*FightSkill.tbParam.nS1},{10,350*0.9},{20,350*0.9*FightSkill.tbParam.nS20},{21,350*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,350*1.1*FightSkill.tbParam.nS1},{10,350*1.1},{20,350*1.1*FightSkill.tbParam.nS20},{21,350*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		attackrating_p={{{1,100},{20,100}}},
		state_hurt_attack={{{1,5},{20,10}},{{1,18},{20,18}}},
		skill_collideevent={{{1,126},{20,126}}},
		skill_showevent={{{1,4},{20,4}}},
		missile_range={1,0,1},
	},
	bingxinxuelian={ --冰心雪莲，冰踪无影第二式
		state_slowall_attack={{{1,10},{10,25},{20,35}},{{1,27},{20,45},{21,45}}},
		missile_hitcount={{{1,2},{10,3},{20,4},{21,4}}},
	},
	bingjiyugu={ --冰肌玉骨_20
		state_slowall_attackrate={{{1,10},{20,100}}},
		state_burn_resistrate={{{1,10},{10,100},{20,150}}},
		attackspeed_v={{{1,10},{10,16},{20,26},{23,29},{24,29}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	qianlibingfeng={ --千里冰封
		skilldamageptrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		skillselfdamagetrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		state_slowall_attacktime={{{1,10},{10,80}}},
		state_burn_resisttime={{{1,10},{10,120}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	
	taxuewuhen={ --中级秘籍：踏雪无痕
		addenchant={8, {{1,1}, {2, 2}}},
		autoskill={{{1,28},{2,28}},{{1,1},{10,10}}},
		skill_skillexp_v=FightSkill.tbParam.tbMidBookSkillExp,
		skill_statetime={{{1,-1},{2,-1}}},
	},
	
	taxuewuhen_child={ --中级秘籍：踏雪无痕
		fastwalkrun_p={{{1,-20},{10,-40},{11,-40}}},
		skill_statetime={{{1,18*3},{10,18*6},{11,18*7}}},
	},
	taxuewuhen_child2={ --中级秘籍：踏雪无痕
		state_hurt_ignore={1},
		state_slowall_ignore={1},
		state_fixed_ignore={1},
		state_palsy_ignore={1},
		state_knock_ignore={1},
		skill_statetime={{{1,18*1.5},{10,18*3},{11,18*3}}},
	},
	
	guiqulaixi={ --归去来兮_10
		autoskill={{{1,36},{2,36}},{{1,1},{10,10}}},
		deadlystrikedamageenhance_p={{{1,13},{10,40},{11,42}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	daocuiadvancedbook={ --刀翠高级秘籍_夜来西风_10
		keephide={1},
		state_freeze_attack={{{1,25},{10,75}},{{1,18*3},{10,18*7.5},{11,18*8}}},
		missile_hitcount={{{1,2},{10,11},{11,12}}},
		skill_cost_v={{{1,100},{10,100}}},
		skill_mintimepercast_v={{{1,90*18},{10,90*18}}},
		skill_mintimepercastonhorse_v={{{1,90*18},{10,90*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	daocui120={ --刀翠120_10
		autoskill={{{1,57},{2,57}},{{1,1},{10,10}}},
		keephide={1},
		skill_cost_v={{{1,100},{10,100}}},
		skill_mintimepercast_v={{{1,35*18},{10,35*18}}},
		skill_mintimepercastonhorse_v={{{1,30*18},{10,30*18}}},
		skill_statetime={{{1,30*18},{2,30*18}}},
	},
	daocui120_child={ --刀翠120_伤害增加_10
		autoskill={{{1,58},{2,58}},{{1,1},{10,10}}},
		skilldamageptrim={{{1,2},{10,10},{14,14}}},
		skillselfdamagetrim={{{1,2},{10,7},{14,8}}},
		skill_statetime={{{1,5*18},{2,5*18}}},
	},
	daocui120_child1={ --刀翠120_子1_10
		skill_appendskill={{{1,1648},{10,1648}},{{1,1},{10,10}}},
	},
	daocui120_child2={ --刀翠120_子2_不中隐身_10
		autoskill={{{1,72},{2,72}},{{1,1},{10,10}}},
		keephide={1},
		skill_statetime={{{1,18},{2,18}}},
	},
}

FightSkill:AddMagicData(tb)

local tbSkill	= FightSkill:GetClass("xuanbingwuxi");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbCCInfo	= KFightSkill.GetSkillInfo(tbChildInfo.tbEvent.nStartSkillId, tbChildInfo.tbEvent.nLevel);
	local szMsg	= string.format("Khi sinh lực giảm xuống 25%%, xác suất thi triển: <color=gold>%d%%<color>\nẢnh hưởng tối đa: <color=gold>%d<color>\nXác suất đóng băng: <color=gold>%s%%<color>, duy trì <color=gold>%s giây<color>\nKháng tất cả: <color=gold>Tăng %s<color>, duy trì <color=gold>%s giây<color>\nThời gian giãn cách: <color=Gold>%s giây<color>",
		tbAutoInfo.nPercent,
		tbChildInfo.nMissileHitcount,
		tbChildInfo.tbWholeMagic["state_freeze_attack"][1],
		FightSkill:Frame2Sec(tbChildInfo.tbWholeMagic["state_freeze_attack"][2]),
		tbCCInfo.tbWholeMagic["damage_all_resist"][1],
		FightSkill:Frame2Sec(tbCCInfo.nStateTime),
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("taxuewuhen");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbChildInfo2	= KFightSkill.GetSkillInfo(tbChildInfo.tbEvent.nStartSkillId, tbChildInfo.tbEvent.nLevel);
	local szMsg	= string.format("\n<color=green>Chiêu thức con<color>\nKhi đánh chí mạng thi triển: <color=gold>%d%%<color>\nTốc chạy của đối thủ <color=gold>giảm %d%%<color>, duy trì <color=gold>%s giây<color>\nBản thân <color=gold>miễn dịch thọ thương, làm chậm, bất động, tê liệt và đánh lui<color>, duy trì <color=gold>%s giây<color>\nKhoảng cách thi triển: <color=Gold>%s giây<color>",
		tbAutoInfo.nPercent,
		-tbChildInfo.tbWholeMagic["fastwalkrun_p"][1],
		FightSkill:Frame2Sec(tbChildInfo.nStateTime),
		FightSkill:Frame2Sec(tbChildInfo2.nStateTime),
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("guiqulaixi");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg	= string.format("\n<color=green>Chiêu thức con<color>\nKhi sát thương 1 người chơi thi triển: <color=gold>%d%%<color>\nNhận <color=gold>[Ngự Tuyết Ẩn] Cấp %d<color><color>\nGiãn cách thi triển: <color=Gold>%s giây<color>",
		tbAutoInfo.nPercent,
		tbChildInfo.tbEvent.nLevel,
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("jiancui120");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};
	local szMsg = ""
	szMsg = szMsg.."Khi bị tấn công tự đánh trả:\n";
	szMsg = szMsg.."    <color=green>Băng Tâm Ngọc Lăng<color>\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	szMsg = szMsg.."\nHiệu lực tối đa <color=gold>"..tbAutoInfo.nCastCount.."<color> lần";
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("daocui120");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbChildInfo2 = KFightSkill.GetSkillInfo(1648, tbAutoInfo.nSkillLevel);
	
	local tbMsg = {};
	local szMsg = "";
	szMsg = szMsg.."<color=green>Ảm Tướng Vọng<color>\n";
	szMsg = szMsg.."Mỗi <color=gold>"..FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime).."<color> giây tự cộng dồn trạng thái:\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo2, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	szMsg = szMsg.."\n<color=gold>Không phải ẩn thân cộng dồn gấp bội<color>";
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("daocui120_child");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg	= string.format("Hiệu quả mất sau khi đánh chính xác <color=gold>%s lần<color>",tbAutoInfo.nCastCount);
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("daocui120_child2");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg	= string.format("Nhận ngay tăng 1 lần sát thương",tbAutoInfo.nCastCount);
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("shimianmaifu");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg	= string.format("Sau khi dùng kỹ năng, trong <color=gold>%s giây<color> phục hồi ẩn thân\nNhiều người <color=red>đồng cấp<color>, thời gian duy trì hiệu quả cộng dồn",FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime));
	return szMsg;
end;

local tbSkill = FightSkill:GetClass("jiancuiadvancedbook_fellow")

function tbSkill:GetExtraDesc(tbInfo)
	if (not tbInfo) then
		return "";
	end
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbInfo.nId, tbInfo.nLevel,me,1);
	local tbCCInfo		= KFightSkill.GetSkillInfo(tbChildInfo.tbEvent.nFlySkillId, tbChildInfo.tbEvent.nLevel, me, 1)
	
	local szMsg	= string.format("Ngũ hành tương khắc: <color=gold>%s điểm<color>\nBăng công: <color=gold>%d đến %d<color>\nPhát huy lực đánh thường: <color=gold>%d%%<color>\nGây làm chậm: <color=gold>%d%%<color>, duy trì <color=gold>%s giây<color>\nGây bất động: <color=gold>%d%%<color>, duy trì <color=gold>%d giây<color>",		
		tbCCInfo.tbWholeMagic["seriesdamage_r"][1],
		tbCCInfo.tbWholeMagic["colddamage_v"][1],
		tbCCInfo.tbWholeMagic["colddamage_v"][3],
		tbCCInfo.tbWholeMagic["appenddamage_p"][1],	
		tbCCInfo.tbWholeMagic["state_slowall_attack"][1],
		FightSkill:Frame2Sec(tbCCInfo.tbWholeMagic["state_slowall_attack"][2]),	
		tbCCInfo.tbWholeMagic["state_fixed_attack"][1],
		FightSkill:Frame2Sec(tbCCInfo.tbWholeMagic["state_fixed_attack"][2])
	);
	return szMsg;
end;
