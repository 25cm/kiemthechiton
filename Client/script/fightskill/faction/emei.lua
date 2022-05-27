Require("\\script\\fightskill\\fightskill.lua")
local tb	= {
	piaoxuechuanyun={ --飘雪穿云_20
		appenddamage_p= {{{1,100},{20,100},{21,100*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,20*0.9},{10,245*0.9},{20,665*0.9},{21,665*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,20*1.1},{10,245*1.1},{20,665*1.1},{21,665*FightSkill.tbParam.nSadd*1.1}}
		},
		state_slowall_attack={{{1,15},{10,45},{20,50},{21,51}},{{1,27},{20,45},{21,45}}},
		seriesdamage_r={{{1,50},{20,100},{21,100}}},
		skill_cost_v={{{1,10},{20,50},{21,50}}},
		addskilldamagep={99, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={100, {{1,2},{20,30},{21,35}}},
		addskilldamagep3={103, {{1,2},{20,10},{21,12}},1},
		addskilldamagep4={104, {{1,2},{20,10},{21,12}}},
	},
	emeizhangfa={ --峨嵋掌法_10
		addcoldmagic_v={{{1,15},{10,350},{11,385}}},
		deadlystrikeenhance_r={{{1,30},{10,50},{11,55}}},
		castspeed_v={{{1,5},{10,15},{11,16},{12,17},{13,17}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	cihangpudu={ --慈航普渡_10
		fastlifereplenish_v={{{1,150},{10,750},{12,800}}},
		skill_cost_v={{{1,100},{10,350},{11,450}}},
		skill_statetime={{{1,18*5},{2,18*5}}},
		missile_range={9,0,9},
	},
	sixiangtonggui={ --四象同归_20
		appenddamage_p= {{{1,60},{20,60},{21,60*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,810*0.9},{10,1080*0.9},{20,1380*0.9},{21,1380*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,810*1.1},{10,1080*1.1},{20,1380*1.1},{21,1380*FightSkill.tbParam.nSadd*1.1}}
		},
		state_slowall_attack={{{1,15},{10,40},{20,45},{21,46}},{{1,27},{20,45},{21,45}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,50},{20,150},{21,150}}},
		missile_hitcount={{{1,3},{2,3}}},
		addskilldamagep={103, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={104, {{1,2},{20,30},{21,35}}},
	},
	sixiangtonggui_child={ --四象同归子
		appenddamage_p= {{{1,40},{20,40}}},
		colddamage_v={
			[1]={{1,425*0.9},{10,565*0.9},{20,720*0.9}},
			[3]={{1,425*1.1},{10,565*1.1},{20,720*1.1}}
		},
		state_slowall_attack={{{1,15},{10,25},{20,30},{21,31}},{{1,27},{20,45},{21,45}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		missile_hitcount={{{1,3},{2,3}}},
	},
	foxinciyou={ --佛心慈佑_20
		lifemax_p={{{1,10},{20,50},{21,55}}},
		manamax_p={{{1,10},{20,50},{22,55}}},
	},
	foxinciyou_team={ --佛心慈佑
		lifemax_p={{{1,10},{20,25},{21,25}}},
		manamax_p={{{1,10},{20,25},{21,25}}},
	},
	bumiebujue={ --不灭不绝_10
		autoskill={{{1,14},{2,14}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	bumiebujue_child={ --不灭不绝子
		fastlifereplenish_v={{{1,750},{10,2250},{12,2475}}},
		skill_statetime={{{1,18*5},{2,18*5}}},
	},
	liushuixinfa={ --流水心法_20
		fastwalkrun_p={{{1,10},{20,40},{21,41}}},
		state_burn_resisttime={{{1,10},{20,135},{21,141}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	fengshuangsuiying={ --风霜碎影
		appenddamage_p= {{{1,96*FightSkill.tbParam.nS1},{10,96},{20,96*FightSkill.tbParam.nS20},{21,96*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,2200*0.9*FightSkill.tbParam.nS1},{10,2200*0.9},{20,2200*0.9*FightSkill.tbParam.nS20},{21,2200*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,2500*2.2*FightSkill.tbParam.nS1},{10,2500*2.2},{20,2500*2.2*FightSkill.tbParam.nS20},{21,2500*2.2*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_slowall_attack={{{1,15},{10,40},{20,45}},{{1,27},{20,45}}},
		skill_startevent={{{1,104},{20,104}}},
		skill_showevent={{{1,1},{20,1}}},
		missile_hitcount={{{1,5},{10,6},{20,7},{21,7}}},
	},
	jindingfoguang={ --金顶佛光，风霜碎影第二式
		appenddamage_p= {{{1,6*FightSkill.tbParam.nS1},{10,6},{20,6*FightSkill.tbParam.nS20},{21,6*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,200*0.9*FightSkill.tbParam.nS1},{10,200*0.9},{20,200*0.9*FightSkill.tbParam.nS20},{21,200*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,200*1.1*FightSkill.tbParam.nS1},{10,200*1.1},{20,200*1.1*FightSkill.tbParam.nS20},{21,200*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_slowall_attack={{{1,5},{10,10},{20,15}},{{1,27},{20,45}}},
		state_hurt_attack={{{1,4},{10,8},{20,10}},{{1,18},{20,18}}},
		missile_hitcount={{{1,6},{20,6}}},
		missile_range={1,0,1},
	},
	fofawubian={ --佛法无边
		state_slowall_attackrate={{{1,10},{20,100}}},
		state_burn_resistrate={{{1,10},{20,150}}},
		castspeed_v={{{1,10},{10,16},{20,26},{23,29},{24,29}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	wanfoguizong={ --万佛归宗
		skilldamageptrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		skillselfdamagetrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		state_slowall_attacktime={{{1,10},{10,80}}},
		state_burn_resisttime={{{1,10},{10,120}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	
	jindingmianzhang={ --中级秘籍：金顶绵掌
		state_palsy_resistrate		={{{1,26},{10,260},{11,286}}},
		state_confuse_resistrate	={{{1,26},{10,260},{11,286}}},
		state_knock_resistrate		={{{1,26},{10,260},{11,286}}},
		state_drag_resistrate		={{{1,26},{10,260},{11,286}}},
		decautoskillcdtime ={479, 14, {{1,18},{10, 18*5},{11, 18*5}}},
		addenchant={5, {{1,1}, {2, 2}}},
		autoskill={{{1,27},{2,27}},{{1,1},{10,10}}},
		skill_skillexp_v=FightSkill.tbParam.tbMidBookSkillExp,
		skill_statetime={{{1,-1},{2,-1}}},
	},
	jindingmianzhang_child={ --中级秘籍：金顶绵掌
		deadlystrikeenhance_r={{{1,180},{10,450},{12,495}}},
		skill_statetime={{{1,18*3},{10,18*5},{11,18*5}}},
	},

	foguangzhanqi={ --佛光战气_10
		addphysicsmagic_p={{{1,50},{10,140},{11,147}}},
		skill_cost_v={{{1,100},{10,300},{10,300}}},
		skill_statetime={{{1,18*180},{10,18*300}}},
	},
	foguangzhanqi_ally={ --佛光战气_10
		addphysicsmagic_p={{{1,20},{10,60},{11,63}}},
		skill_statetime={{{1,18*180},{10,18*300}}},
	},
	zhangeadvancedbook={ --掌峨高级秘籍
		state_hurt_attacktime={{{1,50},{10,500}}},
		state_slowall_attacktime={{{1,50},{10,500}}},
		skill_cost_v={{{1,100},{10,300}}},
		skill_statetime={{{1,18*180},{10,18*300}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},	
	zhangeadvancedbook_child={ --掌峨高级秘籍
		state_hurt_attacktime={{{1,10},{10,100}}},
		state_weak_attacktime={{{1,10},{10,100}}},
		state_slowall_attacktime={{{1,10},{10,100}}},
		state_burn_attacktime={{{1,10},{10,100}}},
		state_stun_attacktime={{{1,10},{10,100}}},
		skill_statetime={{{1,18*180},{10,18*300}}},
	},	
	zhange120={ --掌峨120_10
		autoskill={{{1,56},{2,56}},{{1,1},{10,10}}},
		skill_cost_v={{{1,300},{10,300}}},
		skill_mintimepercast_v={{{1,15*18},{10,15*18}}},
		skill_mintimepercastonhorse_v={{{1,15*18},{10,15*18}}},
		skill_statetime={{{1,18*60},{10,18*60}}},
	},
	zhange120_child={ --掌峨120_10
		appenddamage_p= {{{1,0.8*100*0.7},{10,0.8*100},{11,0.8*100*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,0.8*750*0.9*0.7},{10,0.8*750*0.9},{11,0.8*750*0.9*FightSkill.tbParam.nSadd}},
			[3]={{1,0.8*750*1.1*0.7},{10,0.8*750*1.1},{11,0.8*750*1.1*FightSkill.tbParam.nSadd}}
			},
		missile_hitcount={{{1,5},{10,5}}},
		seriesdamage_r={{{1,250},{10,250}}},
	},

	mengdie={ --梦蝶_10
		fastlifereplenish_v={{{1,15},{10,50},{11,51}}},
		fastmanareplenish_v={{{1,15},{10,40},{11,41}}},
		lucky_v={{{1,5},{10,5}}},
		state_palsy_resistrate={{{1,20},{10,85},{11,90}}},
		state_confuse_resistrate={{{1,20},{10,85},{11,90}}},
		state_knock_resistrate={{{1,20},{10,85},{11,90}}},
		state_drag_resistrate={{{1,20},{10,85},{11,90}}},
	},
	mengdie_team={ --梦蝶
		fastlifereplenish_v={{{1,15},{10,50},{11,51}}},
		fastmanareplenish_v={{{1,15},{10,40},{11,41}}},
		lucky_v={{{1,5},{10,5}}},
		state_palsy_resistrate={{{1,20},{10,85},{11,90}}},
		state_confuse_resistrate={{{1,20},{10,85},{11,90}}},
		state_knock_resistrate={{{1,20},{10,85},{11,90}}},
		state_drag_resistrate={{{1,20},{10,85},{11,90}}},
	},
	foyinzhanyi={ --佛音战意_20
		appenddamage_p= {{{1,100},{10,145},{20,165},{21,165*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,35*0.9},{10,450*0.9},{20,1200*0.9},{21,1200*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,35*1.1},{10,450*1.1},{20,1200*1.1},{21,1200*FightSkill.tbParam.nSadd*1.1}}
		},
		state_slowall_attack={{{1,30},{10,45},{20,50},{21,51}},{{1,27},{20,45},{21,45}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		missile_hitcount={{{1,3},{10,5},{20,5},{21,5}}},
		skill_cost_v={{{1,10},{20,50},{21,50}}}
	},
	qingyinfanchang={ --清音梵唱_20
		allseriesstateresisttime={{{1,60},{10,125},{20,175},{21,182}}},
	},
	qingyinfanchang_team={ --清音梵唱_20
		allseriesstateresisttime={{{1,50},{10,100},{20,150},{21,155}}},
	},
	boluoxinjing={ --波罗心经_20
		state_slowall_attackrate={{{1,10},{20,100},{21,105}}},
		state_burn_resistrate={{{1,10},{10,100},{20,150}}},
		addmissilerange={277, {{1,2}, {20, 22}, {21, 22}}},
		addmissilerange2={276, {{1,2}, {20, 22}, {21, 22}}},
		addmissilerange3={241, {{1,2}, {20, 22}, {21, 22}}},
		addmissilerange4={278, {{1,2}, {20, 22}, {21, 22}}},
		autoskill={{{1,21},{2,21}},{{1,1},{20,20}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},
	boluoxinjing_child={ --波罗心经_20
		lifereplenish_v={{{1,1800},{20,3600}}},
		skill_statetime={{{1,18*15},{20,18*30}}}
	},
	liushuijue_team={ --流水诀_20
		fastwalkrun_p={{{1,5},{20,20},{21,21}}}
	},
	liushuijue={ --流水诀_20
		fastwalkrun_p={{{1,10},{20,40},{21,41}}},
		state_burn_resisttime={{{1,10},{20,135},{21,147}}},
	},
	puduzhongsheng={ --普渡众生_10
		damage_all_resist={{{1,40},{10,120},{11,126}}},
	},
	puduzhongsheng_team={ --普渡众生_10
		damage_all_resist={{{1,20},{10,50},{11,55}}},
	},
	foguangpuzhao={ --佛光普照_10
		missile_missrate={{{1,0},{10,0}}},
		revive={{{1,25},{10,100},{11,100}},{{1,25},{10,100},{11,100}},{{1,25},{10,100},{11,100}}},
		skill_mintimepercast_v={{{1,5*60*18},{10,2*60*18},{11,110*18}}},
		skill_mintimepercastonhorse_v={{{1,5*60*18},{10,2*60*18},{11,110*18}}},
		skill_cost_v={{{1,500},{10,1500},{11,1500}}},
	},
	qianfoqianye={ --千佛千叶_20
		addexpshare={{{1,15},{20,45},{22,50}}},
		subexplose={{{1,15},{20,60},{21,63}}},
		skill_appendskill={{{1,106},{20,106}},{{1,1},{20,20}}},
		skill_appendskill2={{{1,101},{20,101}},{{1,1},{20,20}}},
		skill_appendskill3={{{1,102},{20,102}},{{1,1},{20,20}}},
		skill_appendskill4={{{1,108},{20,108}},{{1,1},{20,20}}},
		skill_appendskill5={{{1,482},{20,482}},{{1,1},{20,20}}},
		skill_appendskill6={{{1,838},{20,838}},{{1,1},{20,20}}},
	},
	qianfoqianye_team={ --千佛千叶_20
		skill_appendskill={{{1,106},{20,106}},{{1,1},{20,10}}},
		skill_appendskill2={{{1,101},{20,101}},{{1,1},{20,5}}},
		skill_appendskill3={{{1,102},{20,102}},{{1,1},{20,10}}},
		skill_appendskill4={{{1,108},{20,108}},{{1,1},{20,10}}},
	},
	
	duyuangong={ --中级秘籍：渡元功
		addenchant={6, {{1,1}, {2, 2}}},
		skill_skillexp_v=FightSkill.tbParam.tbMidBookSkillExp,
		skill_statetime={{{1,-1},{2,-1}}}
	},
	
	jianyingfoguang={ --剑影佛光_10
		appenddamage_p= {{{1,120*0.7},{10,120},{11,120*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,900*0.7*0.9},{10,900*0.9},{11,900*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,900*0.7*1.1},{10,900*1.1},{11,900*FightSkill.tbParam.nSadd*1.1}}
		},
		state_slowall_attack={{{1,35},{10,65},{11,66}},{{1,45},{10,45},{11,45}}},
		seriesdamage_r={{{1,250},{10,250},{11,250}}},
		missile_hitcount={{{1,7},{10,7},{11,7}}},
		skill_cost_v={{{1,100},{10,200},{11,200}}},
	},
	jianyingfoguang_child={ --剑影佛光子_10
		appenddamage_p= {{{1,45*0.7},{10,45},{11,45*FightSkill.tbParam.nSadd}}},
		colddamage_v={
			[1]={{1,350*0.7*0.9},{10,350*0.9},{11,350*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,350*0.7*1.1},{10,350*1.1},{11,350*FightSkill.tbParam.nSadd*1.1}}
		},
		seriesdamage_r={{{1,250},{10,250},{11,250}}},
		missile_hitcount={{{1,5},{10,5},{11,5}}},
	},
	yuquanxichen={ --玉泉洗尘_10
		castspeed_v={{{1,24},{10,24},{12,27},{13,27}}},
		skill_statetime={{{1,18},{2,18}}}
	},
	fueadvancedbook={ --辅峨高级秘籍_10
		addenchant={{{1,24},{10,24}},{{1,1},{10,10}}},
		skill_statetime={{{1,-1},{10,-1}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	fue120={ --辅峨120_10
		defencedeadlystrikedamagetrim={{{1,3},{10,30},{11,33}}},
	},
	fue120_team={ ----辅峨120_子_10
		defencedeadlystrikedamagetrim={{{1,1},{10,10},{11,11}}},
	},
}

FightSkill:AddMagicData(tb)

local tbSkill	= FightSkill:GetClass("bumiebujue");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local nPerCastTime = (tbAutoInfo.nPerCastTime - KFightSkill.GetAutoSkillCDTimeAddition(tbSkillInfo.nId, tbAutoInfo.nId));
	if (nPerCastTime < 0) then
		nPerCastTime = 0;
	end
	local nLifereplenish = tbChildInfo.tbWholeMagic["fastlifereplenish_v"][1];
	
	local szMsg	= string.format("Khi sinh lực giảm xuống 25%%, xác suất thi triển: <color=gold>%d%%<color>\nMỗi nửa giây sinh lực hồi: <color=gold>%s điểm<color>, duy trì <color=gold>%s giây<color>\nThời gian giãn cách: <color=Gold>%s giây<color>",
		tbAutoInfo.nPercent,
		nLifereplenish,
		FightSkill:Frame2Sec(tbChildInfo.nStateTime),
		FightSkill:Frame2Sec(nPerCastTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("boluoxinjing");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg	= string.format("\n<color=green>Chiêu thức con<color>\nKhi bị trọng thương, xác suất thi triển: <color=gold>%d%%<color>\nCứ mỗi 5 giây sinh lực hồi cho đồng đội: <color=gold>%s điểm<color>, duy trì <color=gold>%s giây<color>\nThời gian giãn cách: <color=Gold>%s giây<color>",
		tbAutoInfo.nPercent,
		tbChildInfo.tbWholeMagic["lifereplenish_v"][1],
		FightSkill:Frame2Sec(tbChildInfo.nStateTime),
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("jindingmianzhang");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg	= string.format("\n<color=green>Chiêu thức con<color>\nKhi đánh chí mạng, xác suất thi triển: <color=gold>%d%%<color>\nHội tâm nhất kích: <color=gold>%d<color>, duy trì <color=Gold>%s giây<color>\nThời gian giãn cách: <color=Gold>%s giây<color>",
		tbAutoInfo.nPercent,
		tbChildInfo.tbWholeMagic["deadlystrikeenhance_r"][1],
		FightSkill:Frame2Sec(tbChildInfo.nStateTime),
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("zhange120");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};
	local szMsg = "";
	szMsg = szMsg..", đánh chính xác <color=gold>"..tbAutoInfo.nPercent.."%<color> Tự động thi triển:\n";
	szMsg = szMsg.."    <color=green>Diệp Để Tàng Hoa<color>\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	szMsg = szMsg.."\nGiãn cách thi triển: <color=Gold>"..FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime).." giây<color>";
	return szMsg;
end;
