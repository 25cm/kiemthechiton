Require("\\script\\fightskill\\fightskill.lua")
local tb	= {
	jianrenshenshou={ --见人伸手_20
		appenddamage_p= {{{1,100},{20,100},{21,100*FightSkill.tbParam.nSadd}}},
		seriesdamage_r={{{1,50},{20,100},{21,100}}},
		firedamage_v={
			[1]={{1,50*0.8},{10,320*0.9},{20,570*0.9},{21,570*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,50*1.2},{10,320*1.1},{20,570*1.1},{21,570*FightSkill.tbParam.nSadd*1.1}}
		},
		state_burn_attack={{{1,15},{10,35},{20,40},{21,41}},{{1,36},{20,54},{21,54}}},
		skill_cost_v={{{1,10},{20,50},{21,50}}},
		addskilldamagep={131, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={134, {{1,2},{20,10},{21,12}},1},
		addskilldamagep3={135, {{1,2},{20,10},{21,12}}},
		addskilldamagep4={794, {{1,2},{20,30}}},
	},
	gaibangzhangfa={ --丐帮掌法_10
		-- addfiremagic_v={{{1,15},{10,535},{12,642}}},
		addfiremagic_v={{{1,30},{10,1070},{12,1284}}},
		-- deadlystrikeenhance_r={{{1,30},{10,50},{11,55}}},
		deadlystrikeenhance_r={{{1,45},{10,75},{11,83}}},
		castspeed_v={{{1,10},{10,15},{11,16},{12,17},{13,17}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	huaxianweiyi={ --化险为夷_10
		meleedamagereturn_p={{{1,5},{10,30},{12,33}},{{1,-1},{20,-1}}},
		damage_return_receive_p={{{1,-10},{10,-30}}},
		adddefense_v={{{1,50},{10,350},{11,385}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	kanglongyouhui={ --亢龙有悔_20
		appenddamage_p= {{{1,50},{20,50},{21,50*FightSkill.tbParam.nSadd}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		firedamage_v={
			[1]={{1,450*0.8},{10,540*0.9},{20,640*0.9},{21,640*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,450*1.2},{10,540*1.1},{20,640*1.1},{21,640*FightSkill.tbParam.nSadd*1.1}}
		},
		state_burn_attack={{{1,15},{10,35},{20,40},{21,41}},{{1,36},{20,54},{21,54}}},
		skill_cost_v={{{1,50},{20,150},{21,150}}},
		skill_missilenum_v={{{1,5},{3,5},{4,7},{7,7},{8,9},{10,9},{11,11},{14,11},{15,13},{18,13},{19,15},{20,15}},1},
		addskilldamagep={134, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={135, {{1,2},{20,30},{21,35}}},
		missile_hitcount={{{1,5},{2,5}}},
		missile_speed_v={40},
	},
	yuyueyuyuan={ --鱼越于渊
		appenddamage_p= {{{1,50},{20,50},{21,50*FightSkill.tbParam.nSadd}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		firedamage_v={
			[1]={{1,450*0.8},{10,540*0.9},{20,640*0.9},{21,640*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,450*1.2},{10,540*1.1},{20,640*1.1},{21,640*FightSkill.tbParam.nSadd*1.1}}
		},
		state_burn_attack={{{1,15},{10,35},{20,40}},{{1,36},{20,54}}},
	},
	huabuliushou={ --滑不溜手_20
		fastwalkrun_p={{{1,10},{20,40},{21,41}}},
		skill_cost_v={{{1,100},{10,150},{20,300},{21,300}}},
		state_hurt_resisttime={{{1,30},{20,135},{21,141}}},
		skill_statetime={{{1,18*180},{20,18*300},{21,18*305}}},
	},
	shichengliulong={ --时乘六龙_10
		autoskill={{{1,16},{2,16}},{{1,1},{10,10}}},
		skill_statetime={{{1,5*18},{10,20*18},{11,21*18}}},
		skill_mintimepercast_v={{{1,60*18},{10,30*18},{12,27*18}}},
		skill_mintimepercastonhorse_v={{{1,60*18},{10,30*18},{12,27*18}}},
		skill_cost_v={{{1,20},{10,50},{11,50}}},
	},
	shichengliulong_child={ --时乘六龙子
		appenddamage_p= {{{1,50},{10,50}}},
		firedamage_v={
			[1]={{1,200*0.8},{10,600*0.9}},
			[3]={{1,200*1.2},{10,600*1.1}}
		},
		seriesdamage_r={{{1,100},{10,250},{11,250}}},
		missile_hitcount={{{1,5},{2,5}}},
	},
	zuidiekuangwu={ --醉蝶狂舞_20
		damage_all_resist={{{1,10},{20,140},{21,147}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	feilongzaitian={ --飞龙在天
		appenddamage_p= {{{1,15*FightSkill.tbParam.nS1},{10,15},{20,15*FightSkill.tbParam.nS20},{21,15*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,350*0.9*FightSkill.tbParam.nS1},{10,350*0.9},{20,350*0.9*FightSkill.tbParam.nS20},{21,350*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,350*1.1*FightSkill.tbParam.nS1},{10,350*1.1},{20,350*1.1*FightSkill.tbParam.nS20},{21,350*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_burn_attack={{{1,5},{10,10},{20,15}},{{1,36},{20,54},{21,54}}},
		skill_missilenum_v={{{1,4},{20,4}}},
		skill_vanishedevent={{{1,135},{20,135}}},
		skill_showevent={{{1,8},{20,8}}},
		missile_range={1,0,1},
		missile_speed_v={40},
	},
	longzhanyuye={ --龙战于野，飞龙在天第二式
		appenddamage_p= {{{1,100*FightSkill.tbParam.nS1},{10,100},{20,100*FightSkill.tbParam.nS20},{21,100*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,2500*0.8*FightSkill.tbParam.nS1},{10,2500*0.8},{20,2500*0.8*FightSkill.tbParam.nS20},{21,2500*0.8*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,2500*1.2*FightSkill.tbParam.nS1},{10,2500*1.2},{20,2500*1.2*FightSkill.tbParam.nS20},{21,2500*1.2*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		missile_hitcount={{{1,2},{10,3},{20,4},{21,4}}},
		missile_missrate={{{1,90},{2,90}}},
		missile_range={5,0,5},
	},
	qianlongzaiyuan={ --潜龙在渊_20
		state_burn_attackrate={{{1,10},{20,100}}},
		state_hurt_resistrate={{{1,10},{10,100},{20,150}}},
		castspeed_v={{{1,10},{10,16},{20,26},{23,29},{24,29}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},
	xianglongzhang={ --降龙掌
		skilldamageptrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		skillselfdamagetrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		state_burn_attacktime={{{1,10},{10,80}}},
		state_hurt_resisttime={{{1,10},{10,120}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},
	
	shengongbaiwei={ --中级秘籍：神龙摆尾
		addenchant={9, {{1,1}, {2, 2}}},
		addrangewhencol={131, {{1,1}, {10, 1}},2},
		addpowerwhencol={131, {{1,50}, {10, 75}, {11, 80}}, {{1,50}, {10, 150}, {11, 160}}},
		skill_skillexp_v=FightSkill.tbParam.tbMidBookSkillExp,
		skill_statetime={{{1,-1},{2,-1}}}
	},
	
	qinlonggong={ --擒龙功_10
		autoskill={{{1,37},{2,37}},{{1,1},{10,10}}},
		addenchant={20, {{1,1}, {2, 2}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},
	qinlonggong_child={ --擒龙功子
		damage_return_receive_p={{{1,-20},{10,-60}}},
		skilldamageptrim={{{1,1},{10,10}}},
		skillselfdamagetrim={{{1,1},{10,10}}},
		skill_statetime={{{1,18*3},{10,18*7},{13,18*10}}},
	},
	zhanggaiadvancedbook={ --掌丐高级秘籍_10
		autoskill={{{1,41},{2,41}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{2,-1}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	zhanggaiadvancedbook_child={ --掌丐高级秘籍子_10
		skilldamageptrim	={{{1,6},{10,60},{11,63}}},
		skillselfdamagetrim	={{{1,6},{10,60},{11,63}}},
		skill_statetime={{{1,1*18},{10,2.5*18},{11,2.5*18}}},
	},
	zhanggai120={ --掌丐120_10
		autoskill={{{1,59},{2,59}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{10,-1}}},
	},
	zhanggai120_child={ --掌丐120子_10
		state_knock_attack={{{1,10},{10,100},{11,105}},{{1,3},{10,10},{11,10}},{{1,32},{2,32}}},
	},
	yanmentuobo={ --沿门托钵_20
		appenddamage_p= {{{1,100},{20,100},{21,100*FightSkill.tbParam.nSadd}}},
		seriesdamage_r={{{1,50},{20,100},{21,100}}},
		physicsenhance_p={{{1,5},{10,50},{20,100},{21,100*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,10*0.9},{10,235*0.9},{20,385*0.9},{21,385*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,10*1.1},{10,235*1.1},{20,385*1.1},{21,385*FightSkill.tbParam.nSadd*1.1}}
		},
		state_hurt_attack={{{1,15},{20,30},{21,31}},{{1,18},{20,18}}},
		state_burn_attack={{{1,10},{10,25},{20,30},{21,31}},{{1,36},{20,54},{21,54}}},
		skill_cost_v={{{1,2},{20,20},{21,20}}},
		addskilldamagep={140, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={141, {{1,2},{20,10},{21,12}},1},
	},
	gaibangbangfa={ --丐帮棒法_10
		addphysicsdamage_p={{{1,10},{10,250},{11,265}}},
		attackratingenhance_p={{{1,50},{10,150},{11,165}}},
		deadlystrikeenhance_r={{{1,30},{10,50},{11,55}}},
		attackspeed_v={{{1,5},{10,15},{11,16},{12,17},{13,17}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	xiaoyaogong={ --逍遥功_10
		attackratingenhance_p={{{1,30},{10,100},{11,105}}},
		damage_return_receive_p={{{1,-10},{10,-30}}},
		adddefense_v={{{1,50},{10,200},{20,250}}},
		lifemax_p={{{1,12},{10,40},{11,43}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	bangdaegou={ --棒打恶狗_20
		appenddamage_p= {{{1,90},{20,90},{21,90*FightSkill.tbParam.nSadd}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		physicsenhance_p={{{1,50},{10,95},{20,115},{21,115*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,280*0.8},{10,415*0.9},{20,515*0.9},{21,515*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,280*1.2},{10,415*1.1},{20,515*1.1},{21,515*FightSkill.tbParam.nSadd*1.1}}
		},
		state_hurt_attack={{{1,15},{20,35},{21,36}},{{1,18},{20,18}}},
		state_burn_attack={{{1,10},{10,25},{20,30},{21,31}},{{1,36},{20,54},{21,54}}},
		skill_cost_v={{{1,20},{20,50},{21,50}}},
		addskilldamagep={141, {{1,2},{20,30},{21,35}},1},
	},
	egoulanlu={ --恶狗拦路_10
		state_knock_attack={{{1,65},{10,100},{11,100}},{{1,3},{10,10},{11,11}},{{1,32},{2,32}}},
		state_fixed_attack={{{1,65},{10,100},{11,100}},{{1,18*2.5},{10,18*2.5}}},
		skill_cost_v={{{1,20},{20,50},{21,50}}},
		skill_mintimepercast_v={{{1,20*18},{10,10*18},{13,8*18}}},
		skill_mintimepercastonhorse_v={{{1,20*18},{10,10*18},{13,8*18}}},
		missile_hitcount={{{1,3},{10,5},{12,5}}},
	},
	huntianqigong={ --混天气功_20
		damage_all_resist={{{1,25},{20,100},{21,105}}},
		adddefense_v={{{1,50},{10,150},{20,200},{21,208}}},
		fastwalkrun_p={{{1,10},{20,20},{21,21}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	tianxiawugou={ --天下无狗
		appenddamage_p= {{{1,39*FightSkill.tbParam.nS1},{10,39},{20,39*FightSkill.tbParam.nS20},{21,39*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,66*FightSkill.tbParam.nS1},{10,66},{20,66*FightSkill.tbParam.nS20},{21,66*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,275*0.9*FightSkill.tbParam.nS1},{10,275*0.9},{20,275*0.9*FightSkill.tbParam.nS20},{21,275*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,275*1.1*FightSkill.tbParam.nS1},{10,275*1.1},{20,275*1.1*FightSkill.tbParam.nS20},{21,275*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_hurt_attack={{{1,20},{20,25}},{{1,18},{20,18}}},
		state_burn_attack={{{1,10},{10,20},{20,25}},{{1,36},{20,54},{21,54}}},
	},
	benliudaohai={ --奔流到海_20
		state_burn_attackrate={{{1,10},{20,100}}},
		state_hurt_resistrate={{{1,10},{10,100},{20,150}}},
		attackspeed_v={{{1,10},{10,16},{20,26},{23,29},{24,29}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},
	dagoubangfa={ --打狗棒法
		skilldamageptrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		skillselfdamagetrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		state_burn_attacktime={{{1,10},{10,80}}},
		state_hurt_resisttime={{{1,10},{10,120}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},
	
	toulongzhuanfeng={ --中级秘籍：偷龙转凤
		stealstate={1,100,{{1,1},{10,1}}},
		skill_cost_v={{{1,100},{10,100}}},
		skill_statetime={{{1,23*18},{10,23*18}}},
		skill_mintimepercast_v={{{1,41*18},{10,41*18}}},
		skill_mintimepercastonhorse_v={{{1,40*18},{10,40*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbMidBookSkillExp,
	},
	toulongzhuanfeng_self={ --中级秘籍：偷龙转凤
		stealskillstate={1},
		skill_statetime={{{1,5*18},{10,5*18}}},
		skill_mintimepercast_v={{{1,41*18},{10,41*18}}},
		skill_mintimepercastonhorse_v={{{1,40*18},{10,40*18}}},		
	},	
	
	dagouzhenfa={ --打狗阵法_10
		appenddamage_p= {{{1,150*0.7},{10,150},{11,150*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,200*0.7},{10,200},{11,200*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,775*0.9*0.7},{10,775*0.9},{11,775*0.9*FightSkill.tbParam.nSadd}},
			[3]={{1,775*1.1*0.7},{10,775*1.1},{11,775*1.1*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,250},{10,250}}},
		state_hurt_attack={{{1,30},{10,50}},{{1,18},{10,18}}},
		state_burn_attack={{{1,18},{10,30}},{{1,54},{10,54}}},
		skill_cost_v={{{1,500},{10,500}}},
		skill_maxmissile={{{1,2},{10,2},{20,3},{21,3}}},
		skill_mintimepercast_v			={5*18},
		skill_mintimepercastonhorse_v	={5*18},		
		missile_hitcount={{{1,7},{2,7}}},
		missile_drag={1},
	},
	
	gungaiadvancedbook={ --棍丐高级秘籍
		ignoreskill={{{1,1},{10,10},{11,11}},0,{{1,3},{2,3}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	gungaiadvancedbook_child={ --棍丐高级秘籍子
		ignoreskill={{{1,1},{10,5},{11,5}},0,{{1,3},{2,3}}},
	},
	gungai120={ --棍丐120
		deadlystrikeenhance_r={{{1,30},{10,150},{11,155}}},
		deadlystrikedamageenhance_p={{{1,2},{10,20},{11,22}}},
		addenchant={29, {{1,1}, {2, 2}}},
		skill_statetime={{{1,18*60*60},{10,18*60*60}}},
	},
}

FightSkill:AddMagicData(tb)

local tbSkill	= FightSkill:GetClass("shichengliulong");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};
	local szMsg = "";
	szMsg = szMsg.."<color=gold>"..tbAutoInfo.nCastCount.." <color> lần kế, đánh chính xác thi triển:\n";
	szMsg = szMsg.."    <color=green>Thời Thừa Lục Long<color>\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("qinlonggong");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg	= string.format("Sinh lực giảm còn 50%% thi triển: <color=gold>%d%%<color>\nKháng phản đòn: <color=gold> Tăng %s%%<color>\nPhát huy lực đánh thường: <color=gold>%s%%<color>\nPhát huy lực đánh kỹ năng: <color=gold>%s%%<color>\nDuy trì: <color=Gold>%s giây<color>\nNhận được <color=gold>[Thời Thừa Lục Long] cấp %d <color><color>\nGiãn cách thi triển: <color=Gold>%s giây<color>",
		tbAutoInfo.nPercent,
		-tbChildInfo.tbWholeMagic["damage_return_receive_p"][1],
		tbChildInfo.tbWholeMagic["skilldamageptrim"][1],
		tbChildInfo.tbWholeMagic["skillselfdamagetrim"][1],
		FightSkill:Frame2Sec(tbChildInfo.nStateTime),
		tbChildInfo.tbEvent.nLevel,
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("zhanggaiadvancedbook");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg	= string.format("Khi đánh trúng kẻ địch có tỷ lệ <color=gold>%d%%<color> nhận được trạng thái sau:\nPhát huy lực tấn công cơ bản tăng: <color=Gold>%d%%<color>\nPhát huy lực tấn công kỹ năng: <color=Gold>%d%%<color>\nThời gian duy trì: <color=Gold>%s giây<color>\nThời gian giãn cách: <color=Gold>%s giây<color>",
		tbAutoInfo.nPercent,
		tbChildInfo.tbWholeMagic["skilldamageptrim"][1],
		tbChildInfo.tbWholeMagic["skillselfdamagetrim"][1],
		FightSkill:Frame2Sec(tbChildInfo.nStateTime),
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("zhanggai120");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg	= string.format("Bị đánh trúng thi triển: <color=gold>%d%%<color>\nGây tỷ lệ lui: <color=gold>%d%%<color>, khoảng cách đánh lui <color=gold>%d<color>",
		tbAutoInfo.nPercent,
		tbChildInfo.tbWholeMagic["state_knock_attack"][1],
		tbChildInfo.tbWholeMagic["state_knock_attack"][2]*tbChildInfo.tbWholeMagic["state_knock_attack"][3]);
	return szMsg;
end;

local tbSkill = FightSkill:GetClass("gungai120")

function tbSkill:GetExtraDesc(tbInfo)
	if (not tbInfo) then
		return "";
	end

	local szMsg	= string.format("<color=gray>(Đang trong trạng thái nếu dùng lần nữa sẽ đóng kỹ năng)<color>");
	return szMsg;
end
