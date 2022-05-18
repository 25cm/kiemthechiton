Require("\\script\\fightskill\\fightskill.lua")
local tb	= {
	hufengfa={ --呼风法_20
		appenddamage_p= {{{1,100},{20,100},{21,100*FightSkill.tbParam.nSadd}}},
		seriesdamage_r={{{1,50},{20,100},{21,100}}},
		physicsenhance_p={{{1,5},{10,50},{20,100},{21,100*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={
			[1]={{1,80*0.85},{10,260*0.9},{20,460*0.9},{21,460*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,80*1.15},{10,260*1.1},{20,460*1.1},{21,460*FightSkill.tbParam.nSadd*1.1}}
		},
		state_stun_attack={{{1,15},{10,35},{20,40},{21,41}},{{1,18},{20,18}}},
		skill_cost_v={{{1,2},{20,20},{21,20}}},
		addskilldamagep={178, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={181, {{1,2},{20,10},{21,12}},1},
		addskilldamagep3={182, {{1,2},{20,10},{21,12}}},
	},
	kunlundaofa={ --昆仑刀法_10
		addphysicsdamage_p={{{1,10},{10,205},{11,215}}},
		attackratingenhance_p={{{1,50},{10,150},{11,165}}},
		deadlystrikeenhance_r={{{1,30},{10,50},{11,55}}},
		attackspeed_v={{{1,5},{10,15},{11,16},{12,17},{13,17}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	qingfengfu={ --清风符_20
		fastwalkrun_p={{{1,10},{20,40},{21,41}}},
		state_slowall_resisttime={{{1,10},{20,135},{21,141}}},
		skill_cost_v={{{1,100},{20,250}}},
		skill_statetime={{{1,18*180},{20,18*300},{21,18*305}}},
	},
	qingfengfu_ally={ --清风符_友方
		fastwalkrun_p={{{1,10},{20,20},{21,21}}},
		skill_statetime={{{1,18*180},{20,18*300},{21,18*305}}},
	},
	kuangfengzhoudian={ --狂风骤电_20
		appenddamage_p= {{{1,85},{20,85},{21,85*FightSkill.tbParam.nSadd}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		physicsenhance_p={{{1,50},{10,100},{20,120},{21,120*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={
			[1]={{1,515*0.9},{10,560*0.9},{20,610*0.95},{21,610*FightSkill.tbParam.nSadd*0.95}},
			[3]={{1,515*1.1},{10,560*1.1},{20,610*1.05},{21,610*FightSkill.tbParam.nSadd*1.05}}
		},
		state_stun_attack={{{1,15},{10,35},{20,40},{21,41}},{{1,18},{20,18}}},
		skill_cost_v={{{1,20},{20,50},{21,50}}},
		addskilldamagep={181, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={182, {{1,2},{20,30},{21,35}}},
		missile_hitcount={{{1,5},{10,5},{20,5},{21,5}}},
		missile_speed_v={40},
	},
	kaishenshu={ --开神术_10
		prop_showhide={1},
		skill_statetime={{{1,18*30},{10,18*60*1.5},{11,18*93}}},
		skill_cost_v={{{1,200},{10,300}}},
		skill_mintimepercast_v={{{1,5*60*18},{10,3*60*18},{11,171*18}}},
		skill_mintimepercastonhorse_v={{{1,5*60*18},{10,3*60*18},{11,171*18}}},
	},
	juyuanshu={ --聚元术
		skill_statetime={{{1,300*18},{10,300*18}}},
		lifemax_p={{{1,10},{10,90},{11,95}}},
	},
	xuantianwuji={	--玄天无极_10
		dynamicmagicshield_v={{{1,50},{10,200},{11,210}},40},
		damage_return_receive_p={{{1,-10},{10,-45},{13,-52}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	yiqisanqing_ally={ --一气三清
		addphysicsdamage_p={{{1,10},{20,100}}},
		skill_statetime={{{1,18*180},{20,18*300},{21,18*300}}},
	},
	yiqisanqing={ --一气三清
		addphysicsdamage_p={{{1,15},{20,200},{21,210}}},
		attackratingenhance_p={{{1,20},{20,100},{21,105}}},
		skill_cost_v={{{1,100},{20,300},{21,300}}},
		skill_statetime={{{1,18*180},{20,18*300},{21,18*305}}},
	},
	aoxuexiaofeng={ --傲雪啸风
		appenddamage_p= {{{1,65*FightSkill.tbParam.nS1},{10,65},{20,65*FightSkill.tbParam.nS20},{21,65*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,100*FightSkill.tbParam.nS1},{10,100},{20,100*FightSkill.tbParam.nS20},{21,100*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		state_stun_attack={{{1,15},{10,35},{20,40}},{{1,18},{20,18}}},
		skill_collideevent={{{1,182},{20,182}}},
		skill_showevent={{{1,4},{20,4}}},
		missile_hitcount={{{1,5},{10,5},{20,5},{21,5}}},
		missile_speed_v={40},
	},
	xiaofengsanlianji={ --啸风三连击，傲雪啸风第二式
		appenddamage_p= {{{1,20*FightSkill.tbParam.nS1},{10,20},{20,20*FightSkill.tbParam.nS20},{21,20*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		physicsenhance_p={{{1,30*FightSkill.tbParam.nS1},{10,30},{20,30*FightSkill.tbParam.nS20},{21,30*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={
			[1]={{1,375*0.9*FightSkill.tbParam.nS1},{10,375*0.9},{20,375*0.9*FightSkill.tbParam.nS20},{21,375*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,375*1.1*FightSkill.tbParam.nS1},{10,375*1.1},{20,375*1.1*FightSkill.tbParam.nS20},{21,375*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,50},{20,100},{21,100}}},
		missile_hitcount={{{1,2},{10,3},{20,3}}},
	},
	tianqingdizhuo={ --天清地浊_20
		state_stun_attackrate={{{1,10},{20,100}}},
		state_slowall_resistrate={{{1,10},{10,100},{20,150}}},
		attackspeed_v={{{1,10},{10,16},{20,26},{23,29},{24,29}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	shuangaokunlun={ --霜傲昆仑
		skilldamageptrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		skillselfdamagetrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		state_stun_attacktime={{{1,10},{10,80}}},
		state_slowall_resisttime={{{1,10},{10,120}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	
	liangyizhenqi={ --中级秘籍：两仪真气
		addenchant={12, {{1,1}, {2, 2}}},
		autoskill={{{1,30},{2,30}},{{1,1},{10,10}}},
		skill_skillexp_v=FightSkill.tbParam.tbMidBookSkillExp,
		skill_statetime={{{1,-1},{2,-1}}},
	},
	liangyizhenqi_child={ --中级秘籍：两仪真气
		dynamicmagicshield_v={{{1,200},{10,600},{11,630}},60},
		fastwalkrun_p={{{1,10},{10,30},{11,30}}},
		skill_statetime={{{1,18*2},{10,18*5},{11,18*5}}},
	},
	liangyizhenqi_child2={ --中级秘籍：两仪真气
		state_knock_attack={{{1,65},{10,100},{11,100}},{{1,10},{10,15},{11,15}},{{1,32},{2,32}}},
		missile_hitcount={{{1,3},{2,3}}},
	},
	
	wurenwuwo={ --无人无我_10
		deadlystrikeenhance_r={{{1,30},{10,150},{11,155}}},
		ignoredefenseenhance_v={{{1,50},{10,200},{11,210}}},
		state_stun_resisttime={{{1,60},{10,160},{11,168}}},
	},
	wurenwuwo_team={ --无人无我
		deadlystrikeenhance_r={{{1,30},{10,60},{11,65}}},
		ignoredefenseenhance_v={{{1,38},{10,150},{12,165}}},
		state_stun_resisttime={{{1,45},{10,120},{11,126}}},
	},
	daokunadvancedbook={ --刀昆高级秘籍_10
		skilldamageptrim	={{{1,-1.5},{10,-15},{11,-16}}},
		skillselfdamagetrim	={{{1,-1.5},{10,-15},{11,-16}}},
		
		skill_cost_v={{{1,150},{10,150}}},
		skill_mintimepercast_v={{{1,1*18},{10,1*18}}},
		skill_mintimepercastonhorse_v={{{1,1*18},{10,1*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
		skill_missilenum_v={{{1,8},{10,8}},1},
		skill_maxmissile={{{1,4*8},{10,4*8}}},
		skill_statetime={{{1,18*1},{10,18*1}}},
	},
	daokunadvancedbook_child={ --刀昆高级秘籍子_10
		skilldamageptrim	={{{1,1.5},{10,15},{11,16}}},
		skillselfdamagetrim	={{{1,1.5},{10,15},{11,16}}},
		skill_statetime={{{1,18*1},{10,18*1}}},
	},
	daokun120={ --刀昆120_10
		deadlystrikeenhance_r={{{1,30},{10,150},{11,155}}},
		deadlystrikedamageenhance_p={{{1,2},{10,20},{11,22}}},
		autoskill={{{1,62},{2,62}},{{1,1},{10,10}}},
		addstartskill={182, 1660, {{1,1}, {10, 10}}},
		skill_statetime={{{1,-1},{10,-1}}},
	},
	daokun120_child={ --刀昆120_子2拉回_10
		state_drag_attack={{{1,35},{10,85},{11,90}},{{1,11},{10,11}},{{1,32},{2,32}}},
	},
	daokun120_child2={ --刀昆120_子子10
		missile_random={{{1,5},{10,5},{11,5}},{{1,0},{10,0}}},
		skill_statetime={{{1,-1},{10,-1}}},
	},
		

	kuangleizhendi={ --狂雷震地_20
		appenddamage_p= {{{1,100},{20,100},{21,100*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={
			[1]={{1,80*0.8},{10,215*0.9},{20,500*0.9},{21,500*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,80*1.2},{10,215*1.1},{20,500*1.1},{21,500*FightSkill.tbParam.nSadd*1.1}}
		},
		state_stun_attack={{{1,15},{10,30},{20,35},{21,36}},{{1,18},{20,18}}},
		seriesdamage_r={{{1,50},{20,100},{21,100}}},
		skill_cost_v={{{1,20},{20,50},{21,50}}},
		missile_hitcount={{{1,5},{10,5}}},
		addskilldamagep={190, {{1,2},{20,30},{21,35}},1},
		addskilldamagep2={234, {{1,2},{20,30},{21,35}}},
		addskilldamagep3={192, {{1,2},{20,10},{21,12}},1},
		missile_range={1,0,1},
	},
	kunlunjianfa={ --昆仑剑法_10
		addlightingmagic_v={{{1,5},{10,350},{11,385}}},
		deadlystrikeenhance_r={{{1,30},{10,50},{11,55}}},
		castspeed_v={{{1,5},{10,15},{11,16},{12,17},{13,17}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	tianjixunlei={ --天际迅雷_20
		appenddamage_p= {{{1,45},{20,45},{21,45*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={
			[1]={{1,800*0.8},{10,1115*0.9},{20,1465*0.9},{21,1465*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,800*1.2},{10,1115*1.1},{20,1465*1.1},{21,1465*FightSkill.tbParam.nSadd*1.1}}
		},
		state_stun_attack={{{1,15},{10,30},{20,40},{21,41}},{{1,18},{20,18}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,50},{20,150},{21,150}}},
		missile_hitcount={{{1,3},{10,3}}},
		addskilldamagep={192, {{1,2},{20,30},{21,35}},1},
		skill_mintimepercast_v={2*18},
	},
	tianjixunlei_child={ --天际迅雷子
		appenddamage_p= {{{1,45},{20,45},{21,45*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={
			[1]={{1,800*0.8},{10,1115*0.9},{20,1465*0.9},{21,1465*FightSkill.tbParam.nSadd*0.9}},
			[3]={{1,800*1.2},{10,1115*1.1},{20,1465*1.1},{21,1465*FightSkill.tbParam.nSadd*1.1}}
		},
		state_stun_attack={{{1,15},{10,30},{20,40}},{{1,18},{20,18}}},
		missile_hitcount={{{1,2},{10,2}}},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		missile_range={3,0,3},
	},
	zuixiancuogu={ --醉仙错骨_10
		state_stun_attack={{{1,35},{10,60},{11,61}},{{1,18*1},{10,18*2},{11,18*2.1}}},
		missile_hitcount={{{1,3},{10,5},{11,5},{12,5}}},
		skill_cost_v={{{1,50},{10,100},{20,100}}},
		skill_mintimepercast_v={{{1,60*18},{10,30*18},{11,28.5*18}}},
		skill_mintimepercastonhorse_v={{{1,60*18},{10,30*18},{11,28.5*18}}},
	},
	daoguxianfeng_ally={ --道骨仙风
		damage_physics_resist={{{1,10},{20,60},{21,63}}},
		damage_cold_resist={{{1,10},{20,60},{21,63}}},
		damage_fire_resist={{{1,10},{20,60},{21,63}}},
		damage_light_resist={{{1,10},{20,60},{21,63}}},
		skill_statetime={{{1,18*180},{20,18*300},{21,18*305}}},
	},
	daoguxianfeng={ --道骨仙风_20
		damage_physics_resist={{{1,20},{20,150},{21,157}}},
		damage_cold_resist={{{1,20},{20,150},{21,157}}},
		damage_fire_resist={{{1,20},{20,150},{21,157}}},
		damage_light_resist={{{1,20},{20,150},{21,157}}},
		skill_cost_v={{{1,200},{20,300},{21,300}}},
		skill_statetime={{{1,18*180},{20,18*300},{21,18*305}}},
	},
	leidongjiutian={ --雷动九天
		appenddamage_p= {{{1,175*FightSkill.tbParam.nS1},{10,175},{20,175*FightSkill.tbParam.nS20},{21,175*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		lightingdamage_v={
			[1]={{1,2250*0.9*FightSkill.tbParam.nS1},{10,2250*0.9},{20,2250*0.9*FightSkill.tbParam.nS20},{21,2250*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,2250*1.1*FightSkill.tbParam.nS1},{10,2250*1.1},{20,2250*1.1*FightSkill.tbParam.nS20},{21,2250*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		skill_cost_v={{{1,150},{20,300},{21,300}}},
		state_stun_attack={{{1,15},{10,30},{20,40}},{{1,36},{20,36}}},
		missile_hitcount={{{1,5},{10,7},{20,9},{21,9}}},
	},
	wuleizhengfa={ --五雷正法
		state_stun_attackrate={{{1,10},{20,100}}},
		state_slowall_resistrate={{{1,10},{10,100},{20,150}}},
		castspeed_v={{{1,10},{10,16},{20,26},{23,29},{24,29}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	hunyuanqiankun={ --混元乾坤
		skilldamageptrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		skillselfdamagetrim={{{1,1*FightSkill.tbParam.nS100Min},{10,1*FightSkill.tbParam.nS100Max}}},
		state_stun_attacktime={{{1,10},{10,80}}},
		state_slowall_resisttime={{{1,10},{10,120}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	
	huasuiwuyi={ --中级秘籍：化髓无意
		addenchant={13, {{1,1}, {2, 2}}},
		lifemax_p={{{1,10},{10,100},{12,110}}},
		skill_skillexp_v=FightSkill.tbParam.tbMidBookSkillExp,
		skill_statetime={{{1,-1},{2,-1}}},
	},
	
	leitingjue={ --雷霆诀
		defencedeadlystrikedamagetrim={{{1,-10},{10,-20},{11,-21}}},
		state_stun_resisttime={{{1,-60},{10,-160},{11,-168}}},
		lifereplenish_p={{{1,-5},{10,-15},{11,-16}}},
		manareplenish_p={{{1,-5},{10,-10},{11,-11}}},
		missile_hitcount={{{1,7},{10,7}}},
	},

	leitingjue_self={ --雷霆诀_自身
		addenchant={26, {{1,1}, {2, 2}}},
		skill_statetime={{{1,5*18},{2,5*18}}},
	},
	jiankunadvancedbook={ --剑昆高级秘籍_10
		state_float_attack={{{1,15},{10,85},{12,90}},{{1,7*18},{10,7*18}}},
		damage_all_resist={{{1,-50},{10,-200},{11,-210}}},
		missile_hitcount={{{1,5},{10,5}}},
		skill_cost_v={{{1,300},{10,300}}},
		skill_mintimepercast_v={{{1,45*18},{10,45*18}}},
		skill_mintimepercastonhorse_v={{{1,45*18},{10,45*18}}},
		skill_statetime={{{1,15*18},{10,15*18}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	jiankun120={ --剑昆120_10
		autoskill={64, {{1,1}, {2, 2}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	jiankun120_child={ --剑昆120_子_10	
		skilldamageptrim		={{{1,2},{10,4},{11,5}}},
		skillselfdamagetrim		={{{1,2},{10,4},{11,5}}},
		deadlystrikeenhance_r={{{1,10},{10,30},{15,40},{25,60},{26,65}}}, -- Chí mạng
		state_stun_attacktime={{{1,5},{10,20},{15,30},{25,40},{26,42}}}, -- Thời gian gây choáng
		superposemagic={{{1,1},{10,5},{11,5}}}, -- Cộng dồn tối đa
		skill_statetime={{{1,3*18},{10,3*18}}},		
	},
	baidubuqin={ --百毒不侵
		damage_poison_resist={{{1,10},{20,100}}},
		skill_cost_v={{{1,15},{20,25}}},
		skill_statetime={{{1,18*180},{20,18*300}}},
	},
	xukongshanying={ --虚空闪影
		adddefense_v={{{1,20},{10,100},{20,200}}},
		skill_cost_v={{{1,15},{20,20}}},
		skill_statetime={{{1,18*180},{20,18*300}}},
	},
	qihanaoxue={ --欺寒傲雪
		damage_cold_resist={{{1,10},{20,100}}},
		skill_cost_v={{{1,10},{20,60}}},
		skill_statetime={{{1,18*180},{20,18*300}}},
	},
	zhenhuokangli={ --真火抗力
		damage_fire_resist={{{1,10},{20,100}}},
		skill_cost_v={{{1,80},{20,100}}},
		skill_statetime={{{1,18*180},{20,18*300}}},
	},
	jingangbupo={ --金刚不破
		damage_physics_resist={{{1,20},{20,150}}},
		skill_cost_v={{{1,100},{20,150}}},
		skill_statetime={{{1,18*180},{20,18*300}}},
	},
}

FightSkill:AddMagicData(tb)

local tbSkill	= FightSkill:GetClass("liangyizhenqi");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbCCInfo	= KFightSkill.GetSkillInfo(tbChildInfo.tbEvent.nStartSkillId, tbChildInfo.tbEvent.nLevel);
	local szMsg	= string.format("\n<color=green>Chiêu thức con<color>\nKhi sinh lực giảm xuống 25%%, xác suất thi triển: <color=gold>%d%%<color>\nẢnh hưởng tối đa: <color=gold>%d<color>\nXác suất tấn công đẩy lùi: <color=gold>%s%%<color>, cự ly đẩy lùi <color=gold>%s<color>\nTốc độ di chuyển: <color=gold>Tăng %s%%<color>\nHóa giải sát thương: <color=gold>Tăng %s điểm<color>, không vượt quá sát thương ban đầu <color=gold>%s%%<color>\nThời gian duy trì: <color=gold>%s giây<color>\nThời gian giãn cách: <color=Gold>%s giây<color>",
		tbAutoInfo.nPercent,
		tbCCInfo.nMissileHitcount,
		tbCCInfo.tbWholeMagic["state_knock_attack"][1],
		tbCCInfo.tbWholeMagic["state_knock_attack"][2] * tbCCInfo.tbWholeMagic["state_knock_attack"][3],
		tbChildInfo.tbWholeMagic["fastwalkrun_p"][1],
		tbChildInfo.tbWholeMagic["dynamicmagicshield_v"][1],
		tbChildInfo.tbWholeMagic["dynamicmagicshield_v"][2],
		FightSkill:Frame2Sec(tbChildInfo.nStateTime),
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime)
		);
	return szMsg;
end;

local tbSkill = FightSkill:GetClass("daokunadvancedbook")

function tbSkill:GetExtraDesc(tbInfo)
	if (not tbInfo) then
		return "";
	end
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbInfo.nId, tbInfo.nLevel,me,1);
	local tbCCInfo1		= KFightSkill.GetSkillInfo(tbChildInfo.tbEvent.nCollideSkillId, tbChildInfo.tbEvent.nLevel, me, 1)
	
	local szMsg	= string.format("\nDùng kỹ năng đánh trúng kẻ thù nhận được hiệu quả:\n<color=green>Lưỡng Nghi Hóa Hình<color>\n    Phát huy lực đánh thường: <color=Gold>Tăng %d%%<color>\n    Phát huy lực đánh kỹ năng: <color=Gold>Tăng %d%%<color>",		
	tbCCInfo1.tbWholeMagic["skilldamageptrim"][1],
	tbCCInfo1.tbWholeMagic["skillselfdamagetrim"][1]
	);
	return szMsg;
end

local tbSkill	= FightSkill:GetClass("daokun120");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbChildInfo2	= KFightSkill.GetSkillInfo(1660, tbAutoInfo.nSkillLevel);
	local tbMsg = {};
	local szMsg = "";
	szMsg = szMsg.."Mỗi lần thi triển <color=gold>Tiếu Phong Tam Liên Kích<color> đồng thời có <color=gold>"..tbChildInfo2.tbWholeMagic["missile_random"][1].."%<color> thi triển <color=green>Phong Hồi Lộ Chuyển<color>\n";
	szMsg = szMsg.."Mỗi <color=gold>"..FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime).." giây<color> lần đầu đánh trúng đối phương 100% thi triển <color=green>Phong Hồi Lộ Chuyển<color>\n";
	szMsg = szMsg.."    <color=green>Phong Hồi Lộ Chuyển<color>\n";
	szMsg = szMsg.."    Mỗi giây giật lại 1 lần, duy trì <color=gold>3 giây<color>\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("jiankun120");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbMsg = {};
	local szMsg = "";
	szMsg = szMsg.."Bị đánh trúng <color=gold>"..tbAutoInfo.nPercent.."%<color> nhận được:\n";
	szMsg = szMsg.."    <color=green>Tích Nhưỡng Vi Nhạc<color>".."\n";
	FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
	for i=1, #tbMsg do
		szMsg = szMsg.."    "..tostring(tbMsg[i])..(i ~= #tbMsg and "\n" or "");
	end
	szMsg = szMsg.."\nGiãn cách thi triển: <color=Gold>"..FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime).." giây<color>";
	return szMsg;
end;
