Require("\\script\\fightskill\\fightskill.lua")
local tb	= {
	canyangruxue={ --残阳如血_20
		appenddamage_p= {{{1,100},{20,100},{21,100*FightSkill.tbParam.nSadd}}},
		seriesdamage_r={{{1,50},{20,100},{21,100}}},
		physicsenhance_p={{{1,35},{10,53},{20,76},{21,76*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,60*0.85},{10,375*0.9},{20,625*0.85},{21,625*FightSkill.tbParam.nSadd*0.85}},
			[3]={{1,60*1.15},{10,375*1.1},{20,625*1.15},{21,625*FightSkill.tbParam.nSadd*1.15}}
		},
		state_hurt_attack={{{1,15},{10,35},{20,40},{21,41}},{{1,18},{20,18}}},
		state_burn_attack={{{1,15},{10,35},{20,40},{21,41}},{{1,36},{20,54},{21,54}}},
		skill_cost_v={{{1,2},{20,20},{21,20}}},
		addskilldamagep={146, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={149, {{1,2},{20,10},{21,12}},1},
	},
	tianrenmaofa={ --天忍矛法_10
		addphysicsdamage_p={{{1,25},{10,130},{11,143}}},
		attackratingenhance_p={{{1,50},{10,150},{11,165}}},
		deadlystrikeenhance_r={{{1,30},{10,50},{11,55}}},
		attackspeed_v={{{1,10},{10,35},{11,36},{12,37},{13,37}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	huanyingzhuihunqiang={ --幻影追魂枪_10
		state_drag_attack={{{1,40},{10,100},{11,100}},{{1,25},{10,25},{11,25}},{{1,32},{2,32}}},
		fastwalkrun_p={{{1,-10},{10,-30},{11,-31}}},
		skill_statetime={{{1,18*2},{10,18*4},{11,18*4}}},
		skill_cost_v={{{1,20},{20,50},{21,50}}},
		skill_mintimepercast_v={{{1,20*18},{10,20*18},{11,20*18},{12,20*18}}},
		skill_mintimepercastonhorse_v={{{1,20*18},{10,20*18},{11,20*18},{12,20*18}}},
		missile_range={1,0,1},
	},
	huanyingzhuihunqiang_child={ --幻影追魂枪子子
		fastwalkrun_p={{{1,-10},{10,-30},{11,-31}}},
		skill_statetime={{{1,18*2},{10,18*4},{11,18*4}}}
	},
	jinchantuoqiao={ --金蝉脱壳_20
		state_hurt_resisttime={{{1,30},{20,170},{21,177}}},
		adddefense_v={{{1,50},{10,150},{20,360},{21,375}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	liehuoqingtian={ --烈火情天_20
		appenddamage_p= {{{1,75},{10,93},{20,104},{21,104*FightSkill.tbParam.nSadd}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		physicsenhance_p={{{1,50},{10,68},{20,88},{21,88*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,700*0.9},{10,835*0.9},{20,935*0.9},{21,935*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,700*1.1},{10,835*1.1},{20,935*1.1},{21,935*FightSkill.tbParam.nSadd*1.1}}
		},
		state_hurt_attack={{{1,15},{10,35},{20,50},{21,51}},{{1,18},{20,18}}},
		state_burn_attack={{{1,15},{10,35},{20,40},{21,41}},{{1,36},{20,54},{21,54}}},
		skill_cost_v={{{1,20},{20,50},{21,50}}},
		steallife_p={{{1,1},{20,5},{21,6}},{{1,100},{20,100}}},
		stealmana_p={{{1,1},{20,5},{21,6}},{{1,100},{20,100}}},
		addskilldamagep={149, {{1,2},{20,30},{21,35}},1},
	},
	beisuqingfeng={ --悲酥清风_10
		autoskill={{{1,4},{2,4}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	beisuqingfeng_child={ --悲酥清风子_10
		state_hurt_resisttime={{{1,-15},{10,-125},{11,-130}}},
		attackratingenhance_p={{{1,-20},{10,-150},{12,-162}}},
		adddefense_v={{{1,-50},{10,-150},{11,-155}}},
		missile_hitcount={{{1,3},{10,5},{11,5},{12,5}}},
		skill_statetime={{{1,18*120},{10,18*180},{11,18*183}}},
	},
	moyinshipo={ --魔音噬魄_20
		state_confuse_attack={{{1,40},{20,80},{23,85}},{{1,18*3},{20,18*6},{21,18*6}}},
		state_burn_attack={{{1,25},{20,75},{23,80}},{{1,18*2},{20,18*3},{21,18*3}}},
		skill_cost_v={{{1,200},{20,500},{21,500}}},
		skill_mintimepercast_v={{{1,45*18},{20,35*18},{21,34*18}}},
		skill_mintimepercastonhorse_v={{{1,45*18},{20,35*18},{21,34*18}}},
		missile_hitcount={{{1,3},{5,4},{10,5},{15,6},{16,6}}},
		missile_range={13,0,13},
	},
	moyinshipo_child={ --魔音噬魄子
		autoskill={{{1,20},{2,20}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	moyinshipo_child2={ --魔音噬魄子子
		state_confuse_attack={{{1,100},{20,100}},{{1,18*3},{20,18*6},{21,18*6}}},
		state_burn_attack={{{1,25},{20,100},{21,100}},{{1,18*2},{20,18*3},{21,18*3}}},
		missile_hitcount={{{1,3},{5,4},{10,5},{15,6},{16,6}}},
	},
	yunlongji={ --云龙击
		appenddamage_p= {{{1,105*FightSkill.tbParam.nS1},{10,105},{20,105*FightSkill.tbParam.nS20},{21,105*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,145*FightSkill.tbParam.nS1},{10,145},{20,145*FightSkill.tbParam.nS20},{21,145*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,1000*0.9*FightSkill.tbParam.nS1},{10,1000*0.9},{20,1000*0.9*FightSkill.tbParam.nS20},{21,1000*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,1000*1.1*FightSkill.tbParam.nS1},{10,1000*1.1},{20,1000*1.1*FightSkill.tbParam.nS20},{21,1000*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_hurt_attack={{{1,15},{10,35},{20,50}},{{1,18},{20,18}}},
		state_burn_attack={{{1,15},{10,35},{20,40}},{{1,36},{20,54},{21,54}}},
		steallife_p={{{1,1},{20,10}},{{1,100},{20,100}}},
		stealmana_p={{{1,1},{20,10}},{{1,100},{20,100}}},
		missile_hitcount={{{1,3},{10,4},{20,5},{21,5}}},
	},
	tianmojieti={ --天魔解体
		state_hurt_attackrate={{{1,10},{20,100}}},
		state_stun_resistrate={{{1,10},{10,100},{20,150}}},
		state_hurt_resistrate={{{1,10},{10,100},{20,150}}},
		attackspeed_v={{{1,10},{10,16},{20,26},{23,29},{24,29}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	moyanzaitian={ --魔炎在天
		skilldamageptrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		skillselfdamagetrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		state_burn_attacktime={{{1,10},{10,80}}},
		state_hurt_resisttime={{{1,10},{10,120}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	
	biyuefeixing={ --中级秘籍：碧月飞星
		addenchant={10, {{1,1}, {2, 2}}},
		damage_return_receive_p={{{1,-10},{10,-30},{11,-36}}},
		skill_skillexp_v=FightSkill.tbParam.tbMidBookSkillExp,
		skill_statetime={{{1,-1},{2,-1}}},
	},
	
	feihongwuji={ --飞鸿无迹_10
		appenddamage_p= {{{1,100*FightSkill.tbParam.nS1},{10,100},{11,100*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,95*FightSkill.tbParam.nS1},{10,95},{11,95*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,2000*0.9*0.7},{10,2000*0.9},{11,2000*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,2000*1.1*0.7},{10,2000*1.1},{11,2000*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,250},{10,250},{11,250}}},
		skill_cost_v={{{1,50},{10,100},{11,100}}},
		state_hurt_attack={{{1,35},{10,50}},{{1,18},{10,18}}},
		state_burn_attack={{{1,14},{10,20}},{{1,18},{10,27}}},
		skill_mintimepercast_v={{{1,45*18},{10,35*18},{11,34*18}}},
		skill_mintimepercastonhorse_v={{{1,45*18},{10,35*18},{11,34*18}}},
	},
	feihongwuji_child={ --飞鸿无迹免疫
		state_hurt_ignore={1},
		state_slowall_ignore={1},
		state_stun_ignore={1},
		state_fixed_ignore={1},
		state_knock_ignore={1},
		prop_invincibility={1},
		skill_statetime={{{1,18*10},{2,18*10}}},
	},
	zhanrenadvancedbook={ --高级秘籍技能：九曲一合枪
		addenchant={25, {{1,1}, {2, 2}}},
		autoskill={3,{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{2,-1}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	zhanrenadvancedbook_child={ --九曲一合枪_会心
		autoskill={7,{{1,1},{10,10}}},
		deadlystrikeenhance_r={{{1,999},{10,9999}}},
		deadlystrikedamageenhance_p={{{1,-30},{10,-30},{12,-15}}},
		ignoreskill={{{1,49},{10,99},{11,99}},0,{{1,3},{2,3}}},
		skill_statetime={{{1,4*18},{2,4*18}}},
	},
	
	zhanren120={ --战忍120_10
		attackratingenhance_p={{{1,50},{10,100},{11,110}}},
		deadlystrikedamageenhance_p={{{1,3},{10,30},{11,33}}},
		ignoreattackontime={{{1,18*20},{10,18*10},{13,18*9}}, {{1,18*0.5},{10,18*0.5}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},

	tanzhilieyan={ --弹指烈焰_20
		appenddamage_p= {{{1,100},{10,100},{20,100},{21,100*FightSkill.tbParam.nSadd}}},
		seriesdamage_r={{{1,50},{20,100},{21,100}}},
		firedamage_v={
			[1]={{1,60*0.9},{10,132*0.9},{20,172*0.9},{21,172*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,60*1.1},{10,132*1.1},{20,172*1.1},{21,172*FightSkill.tbParam.nSadd*1.1}}
		},
		state_burn_attack={{{1,15},{10,35},{20,40},{21,41}},{{1,36},{20,54},{21,54}}},
		skill_cost_v={{{1,10},{20,50},{21,50}}},
		missile_hitcount={{{1,2},{10,3},{11,4},{12,4}}},
		addskilldamagep={153, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={156, {{1,2},{20,10},{21,12}},1},
		addskilldamagep3={157, {{1,2},{20,10},{21,12}}},
		skill_mintimepercast_v={2*18},
	},
	tianrenjianfa={ --天忍剑法_10
		addfiremagic_v={{{1,100},{10,500},{11,550}}},
		deadlystrikeenhance_r={{{1,60},{10,100},{11,110}}},
		castspeed_v={{{1,5},{10,15},{11,16},{12,17},{13,17}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	tuishantianhai={ --推山填海_20
		appenddamage_p= {{{1,20},{10,20},{20,20},{21,20*FightSkill.tbParam.nSadd}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		firedamage_v={
			[1]={{1,150*0.95},{10,240*0.9},{20,340*0.95},{21,340*FightSkill.tbParam.nSadd*0.95}},
			[3]={{1,150*1.05},{10,240*1.1},{20,340*1.05},{21,340*FightSkill.tbParam.nSadd*1.05}}
		},
		state_burn_attack={{{1,15},{20,30},{21,31}},{{10,36},{20,36}}},
		skill_missilenum_v={{{1,2},{20,6},{21,6},{22,6}}},
		skill_cost_v={{{1,100},{20,250}}},
		missile_hitcount={{{1,2},{10,3},{11,3}}},
		addskilldamagep={156, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={157, {{1,2},{20,30},{21,35}}},
		skill_mintimepercast_v={3.5*18},
	},
	limoduohun={ --厉魔夺魂
		addphysicsdamage_p={{{1,-50},{10,-125},{12,-150}}},
		fastwalkrun_p={{{1,-10},{10,-30},{11,-30}}},
		skill_cost_v={{{1,20},{10,20}}},
		missile_hitcount={{{1,3},{10,5},{11,5},{12,5}}},
		skill_statetime={{{1,18*120},{10,18*180},{11,18*189}}},
	},
	huolianfenhua={ --火莲焚华_10
		state_burn_attack={{{1,6},{10,18},{11,19}},{{1,18*2.5},{10,18*2.5}}},
		state_drag_attack={{{1,35},{10,80}},{{1,25},{10,25},{11,25}},{{1,11},{2,11}}},
		missile_drag={1},
		missile_hitcount={{{1,3},{10,5},{11,5},{12,5}}},
		skill_cost_v={{{1,50},{10,100},{20,100}}},
		skill_mintimepercast_v={{{1,60*18},{10,30*18},{12,27*18}}},
		skill_mintimepercastonhorse_v={{{1,60*18},{10,30*18},{12,27*18}}},
		missile_range={11,0,11},
		missile_lifetime_v={5*18},
		skill_maxmissile={{{1,3},{10,3}}},
	},
	shehunluanxin={ --慑魂乱心_20
		state_palsy_attack={{{1,35},{10,65},{20,75},{23,85}},{{1,18*1.5},{10,18*2.5},{20,18*3},{21,18*3.2}}},
		skill_cost_v={{{1,300},{20,500},{21,500}}},
		skill_mintimepercast_v={{{1,45*18},{20,35*18},{21,30*18},{22,30*18}}},
		skill_mintimepercastonhorse_v={{{1,45*18},{20,35*18},{21,30*18},{22,30*18}}},
		missile_hitcount={{{1,3},{5,4},{10,5},{15,6},{16,6},{21,6},{22,6}}},
	},
	tianwailiuxing={ --天外流星
		appenddamage_p= {{{1,80*FightSkill.tbParam.nS1},{10,80},{20,80*FightSkill.tbParam.nS20},{21,80*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,900*0.9*FightSkill.tbParam.nS1},{10,900*0.9},{20,900*0.9*FightSkill.tbParam.nS20},{21,900*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,900*1.5*FightSkill.tbParam.nS1},{10,900*1.5},{20,900*1.5*FightSkill.tbParam.nS20},{21,900*1.5*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_burn_attack={{{1,15},{20,30}},{{10,36},{20,36}}},
		skill_vanishedevent={{{1,157},{20,157}}},
		skill_showevent={{{1,8},{20,8}}},
	},
	yehuofencheng={ --业火焚城，天外流星第二式
		appenddamage_p= {{{1,10*FightSkill.tbParam.nS1},{10,10},{20,10*FightSkill.tbParam.nS20},{21,10*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,150*0.9*FightSkill.tbParam.nS1},{10,150*0.9},{20,150*0.9*FightSkill.tbParam.nS20},{21,150*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,150*1.1*FightSkill.tbParam.nS1},{10,150*1.1},{20,150*1.1*FightSkill.tbParam.nS20},{21,150*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_burn_attack={{{1,5},{20,25}},{{10,9},{20,9}}},
		missile_hitcount={{{1,3},{5,4},{10,5},{15,6},{20,7},{21,7}}},
	},
	chikongmoyan={ --炽空魔焰_20
		state_burn_attackrate={{{1,10},{10,100},{20,150}}},
		state_hurt_resistrate={{{1,10},{10,100},{20,150}}},
		castspeed_v={{{1,10},{10,16},{20,26},{23,29},{24,29}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	moyanqisha={ --魔焰七杀
		skilldamageptrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		skillselfdamagetrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		state_burn_attacktime={{{1,10},{10,80}}},
		state_hurt_resisttime={{{1,10},{10,120}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	
	xuanmingxixing={ --中级秘籍：玄冥吸星
		addenchant={11, {{1,1}, {2, 2}}},
		damage_return_receive_p={{{1,-10},{10,-30},{11,-36}}},
		skill_skillexp_v=FightSkill.tbParam.tbMidBookSkillExp,
		skill_statetime={{{1,-1},{2,-1}}},
	},
	
	shufuzhou={ --束缚咒_10
		autoskill={{{1,38},{2,38}},{{1,1},{10,10}}},
		fastwalkrun_p={{{1,10},{10,30},{11,31}}},
		damage_return_receive_p={{{1,-10},{10,-30}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	shufuzhou_child={ --束缚咒子
		state_palsy_attack={{{1,35},{10,75}},{{1,18*1},{10,18*1.5}}},
		missile_hitcount={{{1,3},{5,4},{10,5}}},
	},
	shufuzhou_child2={ --束缚咒子子
		fastwalkrun_p={{{1,10},{10,30},{11,30}}},
		skill_statetime={{{1,6*18},{10,15*18}}},
	},
	morenadvancedbook={ --魔忍高级秘籍
		autoskill={{{1,45},{10,45}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{10,-1}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	morenadvancedbook_child={ --魔忍高级秘籍子
		autoskill={{{1,47},{10,47}},{{1,1},{10,10}}},
		skill_statetime={{{1,60*18},{10,60*18}}},
	},
	morenadvancedbook_child2={ --魔忍高级秘籍子2
		state_stun_attack		={{{1,20},{10,100},{11,105}},{{1,18*1},{20,18*1}}},
		state_hurt_attack		={{{1,20},{10,100},{11,105}},{{1,18*1},{20,18*1}}},
		state_weak_attack		={{{1,20},{10,100},{11,105}},{{1,18*1},{20,18*1.5}}},
		state_burn_attack		={{{1,20},{10,100},{11,105}},{{1,18*1},{20,18*1.5}}},
		state_slowall_attack	={{{1,20},{10,100},{11,105}},{{1,18*1},{20,18*1.5}}},
	},
	moren120={ --魔忍120_10
		autoskill={{{1,60},{10,60}},{{1,1},{10,10}}},
		steallifeenhance_p={{{1,1},{10,1},{12,1}},{{1,100},{10,100}}},
		skill_cost_v={{{1,500},{10,500}}},
		skill_mintimepercast_v={{{1,15*18},{10,15*18}}},
		skill_mintimepercastonhorse_v={{{1,15*18},{10,15*18}}},
		skill_statetime={{{1,300*18},{10,300*18}}},
	},
	moren120_child={ --魔忍120子_10
		seriesdamage_r={{{1,250},{10,250}}},
		appenddamage_p={{{1,10*0.7},{10,10},{11,10}}},
		firedamage_v={
			[1]={{1,150*0.9*0.7},{10,150*0.9},{11,150*0.9}},
			[3]={{1,150*1.1*0.7},{10,150*1.1},{11,150*1.1}}
			},
		steallife_p={{{1,10},{10,50},{11,55}},{{1,100},{10,100}}},
	},
	
	huanyingfeihu={ --幻影飞狐
		deadlystrikeenhance_r={{{1,-50},{20,-150}}},
		skill_cost_v={{{1,50},{20,500}}},
		skill_statetime={{{1,18*120},{20,18*180}}},
	},
}

FightSkill:AddMagicData(tb)

local tbSkill	= FightSkill:GetClass("beisuqingfeng");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};	
	local szMsg = "";
	szMsg = szMsg.."Khi đánh trúng kẻ địch sẽ tự thi triển trạng thái sau:\n";
	szMsg = szMsg.."    <color=green>Bi Tô Thanh Phong<color>\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("moyinshipo_child");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg	= string.format("Khi bị trọng thương, xác suất thi triển: <color=gold>%d%%<color>\nẢnh hưởng tối đa: <color=gold>%d<color>\nGây hỗn loạn: <color=gold>%d%%<color>, duy trì <color=gold>%s giây<color>\nLàm bỏng: <color=gold>%d%%<color>, duy trì <color=gold>%s giây<color>\nThời gian giãn cách: <color=Gold>%s giây<color>",
		tbAutoInfo.nPercent,
		tbChildInfo.nMissileHitcount,
		tbChildInfo.tbWholeMagic["state_confuse_attack"][1],
		FightSkill:Frame2Sec(tbChildInfo.tbWholeMagic["state_confuse_attack"][2]),
		tbChildInfo.tbWholeMagic["state_burn_attack"][1],
		FightSkill:Frame2Sec(tbChildInfo.tbWholeMagic["state_burn_attack"][2]),
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("shufuzhou");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbCCInfo	= KFightSkill.GetSkillInfo(tbChildInfo.tbEvent.nStartSkillId, tbChildInfo.tbEvent.nLevel);
	local szMsg	= string.format("\n<color=green>Chiêu thức con<color>\nLúc bị đánh trúng thi triển: <color=gold>%d%%<color>\nẢnh hưởng tối đa: <color=gold>%d<color>\nGây tê liệt đối thủ: <color=gold>%d%%<color>, duy trì <color=gold>%s giây<color>\nTốc độ di chuyển: <color=gold>+%s%%<color>, duy trì <color=gold>%s giây<color>\nGiãn cách thi triển: <color=Gold>%s giây<color>",
		tbAutoInfo.nPercent,
		tbChildInfo.nMissileHitcount,
		tbChildInfo.tbWholeMagic["state_palsy_attack"][1],
		FightSkill:Frame2Sec(tbChildInfo.tbWholeMagic["state_palsy_attack"][2]),
		tbCCInfo.tbWholeMagic["fastwalkrun_p"][1],
		FightSkill:Frame2Sec(tbCCInfo.nStateTime),
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("morenadvancedbook");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbAutoInfo2	= KFightSkill.GetAutoInfo(tbChildInfo.tbWholeMagic["autoskill"][1], tbChildInfo.tbWholeMagic["autoskill"][2]);
	local tbChildInfo2	= KFightSkill.GetSkillInfo(tbAutoInfo2.nSkillId, tbAutoInfo2.nSkillLevel);
	local szMsg	= string.format("Khi tấn công kẻ địch kèm theo trạng thái sau: \n    <color=green>Trói buộc<color>\n    Sau <color=gold>%d lần<color> tấn công chí mạng sẽ khiến bản thân:\n    Tỷ lệ <color=gold>%d%%  thọ thương %s giây\n    Tỷ lệ %d%% suy yếu %s giây\n   Tỷ lệ %d%% làm chậm%s giây\n    Tỷ lệ %d%% bỏng%s giây\n   Tỷ lệ %d%% choáng %s giây<color>\n    Thời gian duy trì: <color=gold>%s giây<color>\nThời gian giãn cách: <color=gold>%s giây<color>",
		tbAutoInfo2.nCastCount,
		tbChildInfo2.tbWholeMagic["state_hurt_attack"][1],
		FightSkill:Frame2Sec(tbChildInfo2.tbWholeMagic["state_hurt_attack"][2]),
		tbChildInfo2.tbWholeMagic["state_weak_attack"][1],
		FightSkill:Frame2Sec(tbChildInfo2.tbWholeMagic["state_weak_attack"][2]),
		tbChildInfo2.tbWholeMagic["state_slowall_attack"][1],
		FightSkill:Frame2Sec(tbChildInfo2.tbWholeMagic["state_slowall_attack"][2]),
		tbChildInfo2.tbWholeMagic["state_burn_attack"][1],
		FightSkill:Frame2Sec(tbChildInfo2.tbWholeMagic["state_burn_attack"][2]),
		tbChildInfo2.tbWholeMagic["state_stun_attack"][1],
		FightSkill:Frame2Sec(tbChildInfo2.tbWholeMagic["state_stun_attack"][2]),
		FightSkill:Frame2Sec(tbChildInfo.nStateTime),
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime)
		);
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("morenadvancedbook_child");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg	= string.format("Sau <color=gold>%d lần<color> tấn công chí mạng sẽ khiến bản thân rơi vào trạng thái:\nTỷ lệ <color=gold>%d%% thọ thương %s giây\nTỷ lệ %d%% suy yếu %s giây\nTỷ lệ %d%% làm chậm %s giây\nTỷ lệ %d%% bỏng %s giây\nTỷ lệ %d%% choáng %s giây<color>",
		tbAutoInfo.nCastCount,
		tbChildInfo.tbWholeMagic["state_hurt_attack"][1],
		FightSkill:Frame2Sec(tbChildInfo.tbWholeMagic["state_hurt_attack"][2]),
		tbChildInfo.tbWholeMagic["state_weak_attack"][1],
		FightSkill:Frame2Sec(tbChildInfo.tbWholeMagic["state_weak_attack"][2]),
		tbChildInfo.tbWholeMagic["state_slowall_attack"][1],
		FightSkill:Frame2Sec(tbChildInfo.tbWholeMagic["state_slowall_attack"][2]),
		tbChildInfo.tbWholeMagic["state_burn_attack"][1],
		FightSkill:Frame2Sec(tbChildInfo.tbWholeMagic["state_burn_attack"][2]),
		tbChildInfo.tbWholeMagic["state_stun_attack"][1],
		FightSkill:Frame2Sec(tbChildInfo.tbWholeMagic["state_stun_attack"][2])
		);
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("zhanrenadvancedbook");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbAutoInfo2	= KFightSkill.GetAutoInfo(tbChildInfo.tbWholeMagic["autoskill"][1], tbChildInfo.tbWholeMagic["autoskill"][2]);
	local tbChildInfo2	= KFightSkill.GetSkillInfo(tbAutoInfo2.nSkillId, tbAutoInfo2.nSkillLevel);
	local szMsg	= string.format("Bị <color=gold>Huyễn Ảnh Truy Hồn Thương<color> và <color=gold>Ma Âm Phệ Phách<color> đánh trúng nhận được trạng thái:\n    Đánh chí mạng: <color=gold>Tăng %s<color>\n    Sát thương chí mạng: <color=gold>%s%%<color>\n    <color=gold>%s%%<color> né tránh ngoại nội công\n    Đánh trúng <color=gold>%s lần<color> mất hiệu quả\n    Duy trì: <color=gold>%s giây<color>",
		tbChildInfo.tbWholeMagic["deadlystrikeenhance_r"][1],
		180+tbChildInfo.tbWholeMagic["deadlystrikedamageenhance_p"][1],
		tbChildInfo.tbWholeMagic["ignoreskill"][1],
		tbAutoInfo2.nCastCount,
		FightSkill:Frame2Sec(tbChildInfo.nStateTime)
		);
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("zhanrenadvancedbook_child");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg	= string.format("Hiệu quả mất sau khi đánh trúng <color=gold>%s lần<color>",
		tbAutoInfo.nCastCount
		);
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("moren120");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};	
	local szMsg = "";
	szMsg = szMsg.."Mỗi <color=gold>"..FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime).."<color> giây tự động thi triển:\n";
	szMsg = szMsg.."    <color=green>Ma Đao Thôn Thần<color>\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	return szMsg;
end
