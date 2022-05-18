Require("\\script\\fightskill\\fightskill.lua")
local tb	= {
	fumodaofa={ --伏魔刀法_20
		appenddamage_p= {{{1,100},{20,100},{21,100*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,5},{10,50},{20,100},{21,100*FightSkill.tbParam.nSadd}}},
		physicsdamage_v={
			[1]={{1,20*0.9},{10,110*0.9},{20,310*0.9},{21,310*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,20*1.1},{10,110*1.1},{20,310*1.1},{21,310*FightSkill.tbParam.nSadd*1.1}}
			},
		skill_cost_v={{{1,2},{20,20},{21,20}}},
		state_hurt_attack={{{1,15},{10,35},{20,40},{21,41}},{{1,18},{20,18}}},
		seriesdamage_r={{{1,50},{20,100},{21,100}}},
		addskilldamagep={24, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={27, {{1,2},{20,10},{21,12}},1},
	},
	shaolindaofa={ --少林刀法_10
		addphysicsdamage_p={{{1,50},{10,200},{11,220}}},
		attackratingenhance_p={{{1,50},{10,150},{11,165}}},
		deadlystrikeenhance_r={{{1,30},{10,50},{11,55}}},
		attackspeed_v={{{1,5},{10,15},{11,16},{12,17},{13,17}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	yijinjing={ --易筋经_10
		lifemax_p={{{1,10},{10,45},{11,48},{12,51},{13,55}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	pojiedaofa={ --破戒刀法_20
		appenddamage_p= {{{1,45},{20,45},{21,45*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,50},{10,77},{20,110},{21,110*FightSkill.tbParam.nSadd}}},
		physicsdamage_v={
			[1]={{1,280*0.9},{10,550*0.9},{20,750*0.9},{21,750*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,280*1.1},{10,550*1.1},{20,750*1.1},{21,750*FightSkill.tbParam.nSadd*1.1}}
			},
		skill_cost_v={{{1,20},{20,50},{21,50}}},
		state_hurt_attack={{{1,15},{10,20},{20,30},{21,31}},{{1,18},{20,18}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		addskilldamagep={27, {{1,2},{20,30},{21,35}},1},
		missile_range={1,0,1},
	},
	aluohanshengong={ --阿罗汉神功_20
		meleedamagereturn_p={{{1,10},{10,30},{20,40},{22,45}}},
		rangedamagereturn_p={{{1,10},{10,30},{20,40},{22,45}}},
	},
	aluohanshengong_team={ --阿罗汉神功_队友
		meleedamagereturn_p={{{1,5},{10,15},{20,20},{22,23}}},
		rangedamagereturn_p={{{1,5},{10,15},{20,20},{22,23}}},
	},
	xianglongfuhu={ --降龙伏虎_10
		poisondamagereturn_p={{{1,10},{10,40},{12,45}}},
		autoskill={{{1,9},{2,9}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	xianglongfuhu_child={ --降龙伏虎子
		state_slowall_attack={{{1,15},{10,60},{11,65},{12,70},{13,75}},{{1,18*2},{10,18*3.5},{11,18*3.5}}},
		missile_hitcount={{{1,3},{10,5},{11,5}}},
		missile_range={13,0,13},
	},
	xianglongfuhu_child2={ --降龙伏虎子子
		state_hurt_ignore={1},
		state_weak_ignore={1},
		state_slowall_ignore={1},
		state_stun_ignore={1},
		state_fixed_ignore={1},
		skill_statetime={{{1,18*3},{10,18*7},{13,18*10}}},
	},
	putixinfa={ --菩提心法     _20
		state_hurt_resisttime={{{1,30},{10,85},{20,125},{21,130}}},
		state_weak_resisttime={{{1,30},{10,85},{20,125},{21,130}}},
		state_slowall_resisttime={{{1,30},{10,85},{20,125},{21,130}}},
		state_stun_resisttime={{{1,30},{10,85},{20,125},{21,130}}},
		state_fixed_resisttime={{{1,30},{10,85},{20,125},{21,130}}},
		skill_statetime={{{1,18*180},{20,18*300},{21,18*306}}},
		skill_cost_v={{{1,300},{20,500},{21,500}}},
	},
	tianzhujuedao={ --天竺绝刀_20
		appenddamage_p= {{{1,50*FightSkill.tbParam.nS1},{10,50},{20,50*FightSkill.tbParam.nS20},{21,50*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,115*FightSkill.tbParam.nS1},{10,115},{20,115*FightSkill.tbParam.nS20},{21,115*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsdamage_v={
			[1]={{1,775*0.9*FightSkill.tbParam.nS1},{10,775*0.9},{20,775*0.9*FightSkill.tbParam.nS20},{21,775*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,775*1.1*FightSkill.tbParam.nS1},{10,775*1.1},{20,775*1.1*FightSkill.tbParam.nS20},{21,775*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_hurt_attack={{{1,20},{10,25},{20,30}},{{1,18},{20,18}}},
		missile_hitcount={{{1,5},{10,5},{20,5},{21,5}}},
	},
	hunyuanyiqi={ --混元一气
		attackspeed_v={{{1,10},{10,16},{20,26},{23,29},{24,29}}},
		state_hurt_attackrate={{{1,10},{20,100}}},
		state_weak_resistrate={{{1,10},{10,100},{20,150}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	rulaiqianye={	--如来千叶
		skilldamageptrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		skillselfdamagetrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		state_hurt_attacktime={{{1,10},{10,80}}},
		state_weak_resisttime={{{1,10},{10,120}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	
	damobixigong={ --中级秘籍：达摩闭息功
		addenchant={7, {{1,1}, {2, 2}}},
		decautoskillcdtime={250, 9, {{1,18},{10, 18*5},{11, 18*5.5}}},
		state_hurt_resistrate		={{{1,5},{10,20},{11,21}}},
		state_weak_resistrate		={{{1,5},{10,20},{11,21}}},
		state_slowall_resistrate	={{{1,5},{10,20},{11,21}}},
		state_stun_resistrate		={{{1,5},{10,20},{11,21}}},
		state_fixed_resistrate		={{{1,5},{10,20},{11,21}}},
		skill_skillexp_v=FightSkill.tbParam.tbMidBookSkillExp,
		skill_statetime={{{1,-1},{2,-1}}},
	},
	chanyuangong={ --禅圆功_10
		strength_v={{{1,60},{10,150},{12,165}}},
		dexterity_v={{{1,32},{10,80},{11,84}}},
		vitality_v={{{1,60},{10,150},{12,165}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	daoshaoadvancedbook = { --刀少高级秘籍_10
		state_fixed_attack={{{1,35},{10,85},{12,90}},{{1,18*2.5},{10,18*2.5}}},
		state_drag_attack={{{1,35},{10,85},{12,90}},{{1,14},{10,14}},{{1,32},{2,32}}},
		steallifeenhance_p={{{1,-4},{10,-40},{11,-42}},{{1,100},{10,100}}},
		skill_statetime={{{1,6*18},{2,6*18}}},
		missile_drag={1},
		missile_hitcount={{{1,3},{10,8}}},
		skill_cost_v={{{1,100},{10,100}}},
		skill_mintimepercast_v={{{1,15*18},{10,15*18}}},
		skill_mintimepercastonhorse_v={{{1,15*18},{10,15*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	daoshao120={ --刀少120_10
		autoskill={{{1,54},{2,54}},{{1,1},{10,10}}},
		dynamicmagicshield_v={{{1,300},{10,3000},{11,3150}},99},
		posionweaken={{{1,300},{10,3000},{11,3150}},99},
		deadlystrikeenhance_r={{{1,20},{10,200},{11,200*1.05}}},
		deadlystrikedamageenhance_p={{{1,10},{10,100},{11,105}}},
		skill_cost_v={{{1,300},{10,300}}},
		skill_mintimepercast_v={{{1,30*18},{10,30*18}}},
		skill_mintimepercastonhorse_v={{{1,30*18},{10,30*18}}},
		skill_statetime={{{1,10*18},{2,10*18}}},
	},

	pudugunfa={ --普渡棍法_20
		appenddamage_p= {{{1,100},{20,100},{21,100*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,20},{10,110},{20,160},{21,160*FightSkill.tbParam.nSadd}}},
		physicsdamage_v={
			[1]={{1,50*0.9},{10,230*0.9},{20,380*0.9},{21,380*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,50*1.1},{10,230*1.1},{20,380*1.1},{21,380*FightSkill.tbParam.nSadd*1.1}}
			},
		skill_cost_v={{{1,2},{20,20},{21,20}}},
		state_hurt_attack={{{1,15},{10,40},{20,45},{21,46}},{{1,18},{20,18}}},
		seriesdamage_r={{{1,50},{20,100},{21,100}}},
		addskilldamagep={33, {{1,2},{20,30},{20,35}},1},
		addskilldamagep2={36, {{1,2},{20,10},{21,12}},1},
	},
	shaolingunfa={ --少林棍法_10
		addphysicsdamage_p={{{1,10},{10,250},{11,265}}},
		attackratingenhance_p={{{1,50},{10,135},{12,162}}},
		deadlystrikeenhance_r={{{1,30},{10,150},{11,155}}},
		attackspeed_v={{{1,10},{10,20},{11,21},{12,22},{13,22}}},
		lifemax_p={{{1,5},{10,30},{11,33}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	shizihou={ --狮子吼_10
		state_fixed_attack={{{1,35},{10,70},{11,73}},{{1,18*2.5},{20,18*2.5}}},
		state_hurt_attack={{{1,27},{10,54},{11,56}},{{1,18*1.5},{20,18*1.5}}},
		missile_hitcount={{{1,3},{10,5},{11,5}}},
		skill_cost_v={{{1,50},{10,100},{11,100}}},
	},
	fumogunfa={ --伏魔棍法_20
		appenddamage_p= {{{1,100},{20,100},{21,100*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,85},{10,130},{20,180},{21,180*FightSkill.tbParam.nSadd}}},
		physicsdamage_v={
			[1]={{1,500*0.9},{10,590*0.9},{20,690*0.9},{21,690*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,500*1.1},{10,590*0.9},{20,690*1.1},{21,690*FightSkill.tbParam.nSadd*1.1}}
			},
		skill_cost_v={{{1,20},{20,50},{21,50}}},
		state_hurt_attack={{{1,15},{10,35},{20,40},{21,41}},{{1,18},{20,18}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		addskilldamagep={36, {{1,2},{20,30},{21,35}},1},
	},
	budongmingwang={ --不动明王_10
		adddefense_v={{{1,20},{10,150},{11,165}}},
		poisondamagereturn_p={{{1,10},{10,40},{12,45}}},
		autoskill={{{1,2},{2,2}},{{1,1},{20,20}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	budongmingwang_child={ --不动明王子
		adddefense_v={{{1,-100},{10,-300},{11,-330}}},
		fastwalkrun_p={{{1,-20},{10,-40},{11,-40}}},
		skill_statetime={{{1,18*5},{10,18*8},{11,18*8},{12,18*9},{13,18*9}}},
		missile_hitcount={{{1,1},{10,3},{20,3}}},					
	},
	yigujing={ --易骨经_20
		lifemax_p={{{1,10},{20,50},{21,52}}},
		lifereplenish_p={{{1,5},{20,20},{21,21}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	qixingluoshagun={ --七星罗刹棍
		appenddamage_p= {{{1,105*FightSkill.tbParam.nS1},{10,105},{20,105*FightSkill.tbParam.nS20},{21,105*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,175*FightSkill.tbParam.nS1},{10,175},{20,175*FightSkill.tbParam.nS20},{21,175*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsdamage_v={
			[1]={{1,750*0.9*FightSkill.tbParam.nS1},{10,750*0.9},{20,750*0.9*FightSkill.tbParam.nS20},{21,750*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,750*1.1*FightSkill.tbParam.nS1},{10,750*1.1},{20,750*1.1*FightSkill.tbParam.nS20},{21,750*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_hurt_attack={{{1,25},{10,45},{20,50}},{{1,18},{20,18}}},
		missile_hitcount={{{1,5},{5,6},{10,7},{15,8},{20,9},{21,9}}},
	},
	damowujing={ --达摩武经
		attackspeed_v={{{1,10},{10,16},{20,26},{23,29},{24,29}}},
		state_hurt_attackrate={{{1,10},{20,100}}},
		state_weak_resistrate={{{1,10},{10,100},{20,150}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	wuxiangshengong={ --无相神功
		skilldamageptrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		skillselfdamagetrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		state_hurt_attacktime={{{1,10},{10,80}}},
		state_weak_resisttime={{{1,10},{10,120}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	
	jingangbuhuai={ --中级秘籍：金刚不坏
		autoskill={{{1,24},{2,24}},{{1,1},{10,10}}},
		skill_skillexp_v=FightSkill.tbParam.tbMidBookSkillExp,
		skill_statetime={{{1,-1},{2,-1}}},
	},
	jingangbuhuai_child={ --中级秘籍：金刚不坏
		dynamicmagicshield_v={{{1,400},{10,1500},{12,1650}},{{1,60},{10,90},{11,90}}},
		meleedamagereturn_p={{{1,5},{10,30},{12,33}}},
		rangedamagereturn_p={{{1,5},{10,30},{12,33}}},
		fastwalkrun_p={{{1,10},{10,40},{11,40}}},
		skill_statetime={{{1,3*18},{10,6*18}}},
	},
	
	zuibaxiangun={ --醉八仙棍_10
		state_drag_attack={{{1,35},{10,85},{11,89}},{{1,14},{10,14},{11,14}},{{1,32},{2,32}}},
		state_fixed_attack={{{1,35},{10,85},{11,89}},{{1,18*2.5},{10,18*2.5}}},
		missile_hitcount={{{1,3},{10,8},{11,8}}},
		skill_cost_v={{{1,50},{10,100},{11,100}}},
		skill_mintimepercast_v={{{1,12*18},{10,12*18}}},
		skill_mintimepercastonhorse_v={{{1,12*18},{10,12*18}}},
	},
	gunshaoadvancedbook={ --棍少高级秘籍技能
		autoskill={{{1,40},{2,40}},{{1,1},{20,20}}},
		skill_statetime={{{1,-1},{10,-1}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	gunshaoadvancedbook_child={ --棍少高级秘籍状态
		state_hurt_ignore={1},
		state_weak_ignore={1},
		state_slowall_ignore={1},
		state_stun_ignore={1},
		skill_statetime={{{1,18*3},{10,18*3}}},
	},
	gunshao120={ --棍少120_10
		appenddamage_p= {{{1,40*0.7},{10,40},{11,40*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,67*0.7},{10,67},{11,67*FightSkill.tbParam.nSadd}}},
		physicsdamage_v={
			[1]={{1,285*0.9*0.7},{10,285*0.9},{11,285*0.9*FightSkill.tbParam.nSadd}},
			[3]={{1,285*1.1*0.7},{10,285*1.1},{11,285*1.1*FightSkill.tbParam.nSadd}}
			},
		skill_cost_v={{{1,100},{10,100}}},
		seriesdamage_r={{{1,250},{10,250}}},
		missile_hitcount={{{1,1},{10,1}}},
		steallife_p={{{1,10},{10,20},{11,22}},{{1,100},{10,100}}},
		skill_appendskill={{{1,36},{10,36}},{{1,2},{10,20},{11,21}}},
	},
	gunshao120_child={ --棍少120_子_10
		lifereplenish_p={{{1,2},{10,20},{11,21}}},
		skill_statetime={{{1,18*300},{10,18*300}}},
	},
}

FightSkill:AddMagicData(tb)

local tbSkill	= FightSkill:GetClass("budongmingwang");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg = string.format("\n<color=green>Chiêu thức con<color>\nKhi bị đánh trúng, xác suất thi triển: <color=gold>%d%%<color>\nẢnh hưởng tối đa: <color=gold>%d<color>\nNé tránh đối thủ <color=gold>giảm %d điểm<color>, tốc độ di chuyển <color=gold>giảm %d%%<color>, duy trì <color=gold>%s giây<color>\nThời gian giãn cách: <color=Gold>%s giây<color>",
		tbAutoInfo.nPercent,
		tbChildInfo.nMissileHitcount,
		-tbChildInfo.tbWholeMagic["adddefense_v"][1],-tbChildInfo.tbWholeMagic["fastwalkrun_p"][1],
		FightSkill:Frame2Sec(tbChildInfo.nStateTime),
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("xianglongfuhu");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbCCInfo	= KFightSkill.GetSkillInfo(tbChildInfo.tbEvent.nStartSkillId, tbChildInfo.tbEvent.nLevel);
	local nRate = tbChildInfo.tbWholeMagic["state_slowall_attack"][1];
	local nPerCastTime = (tbAutoInfo.nPerCastTime - KFightSkill.GetAutoSkillCDTimeAddition(tbSkillInfo.nId, tbAutoInfo.nId));
	
	if (nPerCastTime < 0) then
		nPerCastTime = 0;
	end
	local szMsg	= string.format("\n<color=green>Chiêu thức con<color>\nKhi bị đánh trúng thi triển: <color=gold>%d%%<color>\nẢnh hưởng tối đa: <color=gold>%d<color>\nLàm chậm đối thủ: <color=gold>%d%%<color>, duy trì <color=gold>%s giây<color>\nMiễn dịch trạng thái thọ thương, suy yếu, làm chậm, choáng, bất động, duy trì <color=gold>%s giây<color>\nGiãn cách thi triển: <color=Gold>%s giây<color>",
		tbAutoInfo.nPercent,
		tbChildInfo.nMissileHitcount,
		nRate,
		FightSkill:Frame2Sec(tbChildInfo.tbWholeMagic["state_slowall_attack"][2]),
		FightSkill:Frame2Sec(tbCCInfo.nStateTime),
		FightSkill:Frame2Sec(nPerCastTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("jingangbuhuai");
function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg	= string.format("Khi sinh lực giảm xuống 25%%, xác suất thi triển: <color=gold>%d%%<color>\nTốc độ di chuyển: <color=gold>Tăng %s%%<color>\nTrúng phản đòn cận chiến: <color=gold>Tăng %s%%<color>\nTrúng phản đòn tầm xa: <color=gold>Tăng %s%%<color>\nHóa giải sát thương: <color=gold>Tăng %s điểm<color>, không vượt quá sát thương ban đầu <color=gold>%s%%<color>\nThời gian duy trì: <color=gold>%s giây<color>\nThời gian giãn cách: <color=Gold>%s giây<color>",
		tbAutoInfo.nPercent,
		tbChildInfo.tbWholeMagic["fastwalkrun_p"][1],
		tbChildInfo.tbWholeMagic["meleedamagereturn_p"][1],
		tbChildInfo.tbWholeMagic["rangedamagereturn_p"][1],
		tbChildInfo.tbWholeMagic["dynamicmagicshield_v"][1],
		tbChildInfo.tbWholeMagic["dynamicmagicshield_v"][2],
		FightSkill:Frame2Sec(tbChildInfo.nStateTime),
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("gunshaoadvancedbook");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg	= string.format("Khi bị tấn công nhận được trạng thái sau: \nGiải và miễn nhiễm <color=gold>thọ thương<color>\nGiải và miễn nhiễm <color=gold>suy yếu<color>\nGiải và miễn nhiễm <color=gold>làm chậm<color>\nGiải và miễn nhiễm <color=gold>choáng<color>\nThời gian duy trì: <color=Gold>%s giây<color>\nThời gian giãn cách: <color=Gold>%s giây<color>",
		FightSkill:Frame2Sec(tbChildInfo.nStateTime),
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("daoshao120");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg	= string.format("Bị đánh <color=gold>%s<color> lần mất hiệu quả",
		tbAutoInfo.nCastCount);
	return szMsg;
end;


local tbSkill	= FightSkill:GetClass("gunshao120");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};
	local szMsg = "";
	szMsg = szMsg.."Bị đánh trúng <color=gold>"..tbAutoInfo.nPercent.."%<color> nhận được trạng thái:\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	szMsg = szMsg.."\nGiãn cách thi triển: <color=Gold>"..FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime).." giây<color>";
	return szMsg;
end;
