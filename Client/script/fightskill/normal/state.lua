local tb	= {
	vn_some_state={
		lifemax_p=	{{{1,5},{2,10}}},
		manamax_p=	{{{1,5},{2,10}}},
	},

	changeseriesdammage={
		magic_turnphysicaldammage={{{1,80},{2,80}}},
		skill_statetime={18*60*60*2},
	},

	enhance_exp={
		expenhance_p={{{1,10},{2,20}}},
		skill_statetime={18}
	},
	
	enhance_luck={
		lucky_v={{{1,5},{2,10},{3,2},{4,5},{5,9},{6,14},{7,20}}},
		skill_statetime={18*60*30}
	},
	pray_exp={
		expenhance_p={{{1,10},{2,15},{3,20},{4,30},{5,50}}},
		skill_statetime={18}
	},
	
	pray_luck={
		lucky_v={{{1,10},{2,15},{3,20},{4,30},{5,50}}},
		skill_statetime={18*60*30}
	},
	
	addtion_exp={
		skillexpaddtionp={{{1,100},{2,150}}},
		skill_statetime={18}
	},
	
	open_xiuwei={
		expxiuwei_v={0},
		skill_statetime={18}
	},
	lockstate={
		locked_state ={--是否不能移动,使用技能,使用物品
			[1] = {{1,1},{10,1}},
			[2] = {{1,0},{10,0}},
			[3] = {{1,0},{10,0}},
			},
	},  
	state_exp={
		expenhance_p={{{1,5},{2,10}}},
	},
	npc_resistseriesrate={
		state_hurt_resistrate={{{1,10},{10,100},{20,180}}},						
		state_weak_resistrate={{{1,10},{10,100},{20,180}}},					
		state_slowall_resistrate={{{1,10},{10,100},{20,180}}},						
		state_burn_resistrate={{{1,10},{10,100},{20,180}}},		
		state_stun_resistrate={{{1,10},{10,100},{20,180}}},	
	},
	npc_resistseriestime={
		state_hurt_resisttime={{{1,10},{10,100},{20,180}}},						
		state_weak_resisttime={{{1,10},{10,100},{20,180}}},					
		state_slowall_resisttime={{{1,10},{10,100},{20,180}}},						
		state_burn_resisttime={{{1,10},{10,100},{20,180}}},		
		state_stun_resisttime={{{1,10},{10,100},{20,180}}},				
	},
	npc_ignoreseriesstate={
	ignoredebuff = {{{1,32767},{10,32767}}},
	},
	longtimefood={
		fastlifereplenish_v={{{1,15},{2,30},{3,45},{4,60},{5,75},{6,75},{7,75}}},
		fastmanareplenish_v={{{1,15},{2,30},{3,45},{4,60},{5,75},{6,75},{7,75}}},
		skill_statetime={{{1,18*60*30},{5,18*60*30},{6,18*60*60*24*7},{7,18*60*60*24*30}}},
	},
	mapprotect={
		protected={1},
	},
	tianyuanxinfa={ --联赛黄金衣服
		subexplose={{{1,80},{2,85}}},
		damage_all_resist={{{1,35},{2,45}}},
	},
	tongweixianhua={ --领土帽子
		autoskill={{{1,32},{2,32}},{{1,1},{2,2}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},
	tongweixianhua_child1={ --领土帽子_队友
		npcdamageadded={{{1,15},{2,20}}},
	},
	tongweixianhua_child2={ --领土帽子_自身
		npcdamageadded={{{1,35},{2,50}}},
		lifemax_p={{{1,30},{2,40}}},
		manamax_p={{{1,30},{2,40}}},
	},
	bootskill={ --白银/黄金鞋子
		autoskill={{{1,51},{2,51}},{{1,1},{2,2}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},
	bootskill_team={ --白银/黄金鞋子_队友
		fastwalkrun_p={{{1,10},{2,10}}},
		seriesenhance={{{1,50},{2,100}}},
		seriesabate={{{1,50},{2,100}}},
	},
	bootskill_self={ --白银/黄金鞋子_自身
		fastwalkrun_p={{{1,10},{2,20}}},
		seriesenhance={{{1,300},{2,500}}},
		seriesabate={{{1,300},{2,500}}},
	},
	cuffskill_self={ --白银/黄金护腕
		staminareplenish_v={{{1,50},{2,100}}},
		allspecialstateresistrate={{{1,100},{2,245}}},
	},
	zixiashengong={ --高级披风
		allspecialstateresisttime={{{1,100},{2,245},{3,500}}},
		seriesenhance={{{1,0},{2,FightSkill.IVER_nZiXiaShenGongSeriersAbate},{3,FightSkill.IVER_nZiXiaShenGongSeriersAbate+200}}},
		seriesabate={{{1,0},{2,FightSkill.IVER_nZiXiaShenGongSeriersAbate},{4,FightSkill.IVER_nZiXiaShenGongSeriersAbate+200}}},
	},
	tianxiashengong={ --濒死无敌
		autoskill={{{1,52},{2,52}},{{1,1},{2,1}}},
		skill_statetime={{{1,-1},{2,-1}}},
	},
	tianxiashengong_child={ --触发无敌
		prop_invincibility={1},
		defense_dummy = {1},
		skill_statetime={{{1,18*5},{2,18*5}}},
	},
	dispute_defend={
		lifemax_p={{{1,5},{2,8},{3,12},{4,16},{5,20},{6,25},{7,30},{8,36},{9,43},{10,50}}},
		lifemax_v={{{1,60},{2,96},{3,144},{4,192},{5,240},{6,300},{7,360},{8,432},{9,516},{10,600}}},
		damage_all_resist={{{1,10},{2,16},{3,23},{4,31},{5,40},{6,50},{7,61},{8,73},{9,86},{10,100}}},
		addphysicsdamage_p={{{1,20},{2,32},{3,46},{4,62},{5,80},{6,100},{7,122},{8,146},{9,172},{10,200}}},
		addphysicsmagic_p={{{1,20},{2,32},{3,46},{4,62},{5,80},{6,100},{7,122},{8,146},{9,172},{10,200}}},
		skill_statetime={18}
	},
	
	chuzhanshachang={
		lifemax_p={{{1,5},{2,8},{3,12},{4,16},{5,20},{6,25},{7,30},{8,36},{9,43},{10,50}}},
		lifemax_v={{{1,60},{2,96},{3,144},{4,192},{5,240},{6,300},{7,360},{8,432},{9,516},{10,600}}},
		damage_all_resist={{{1,10},{2,16},{3,23},{4,31},{5,40},{6,50},{7,61},{8,73},{9,86},{10,100}}},
		addphysicsdamage_p={{{1,20},{2,32},{3,46},{4,62},{5,80},{6,100},{7,122},{8,146},{9,172},{10,200}}},
		addphysicsmagic_p={{{1,20},{2,32},{3,46},{4,62},{5,80},{6,100},{7,122},{8,146},{9,172},{10,200}}},
		skill_statetime={18}
	},
	
	ignoreattack_skill={
		ignoreattack={
			[1]={	--(lvl自己-划分等级)*成长值
				{1, (3-FightSkill.tbParam.nTitleLevel)*FightSkill.tbParam.nTitleGrowValue}, 
				{2, (4-FightSkill.tbParam.nTitleLevel)*FightSkill.tbParam.nTitleGrowValue}, 
				{3, (5-FightSkill.tbParam.nTitleLevel)*FightSkill.tbParam.nTitleGrowValue}, 
				{4, (6-FightSkill.tbParam.nTitleLevel)*FightSkill.tbParam.nTitleGrowValue}, 
				{5, (7-FightSkill.tbParam.nTitleLevel)*FightSkill.tbParam.nTitleGrowValue}, 
				{6, (8-FightSkill.tbParam.nTitleLevel)*FightSkill.tbParam.nTitleGrowValue}, 
				{7, (9-FightSkill.tbParam.nTitleLevel)*FightSkill.tbParam.nTitleGrowValue},
				},	
			[2]={	--等级修正 =  [100+(lvl自己-划分等级)^2*c] /100
				{1, 100+((3-FightSkill.tbParam.nTitleLevel)^FightSkill.tbParam.nTitleLevelPower)*FightSkill.tbParam.nTitleLevelAdjust}, 
				{2, 100+((4-FightSkill.tbParam.nTitleLevel)^FightSkill.tbParam.nTitleLevelPower)*FightSkill.tbParam.nTitleLevelAdjust}, 
				{3, 100+((5-FightSkill.tbParam.nTitleLevel)^FightSkill.tbParam.nTitleLevelPower)*FightSkill.tbParam.nTitleLevelAdjust}, 
				{4, 100+((6-FightSkill.tbParam.nTitleLevel)^FightSkill.tbParam.nTitleLevelPower)*FightSkill.tbParam.nTitleLevelAdjust}, 
				{5, 100+((7-FightSkill.tbParam.nTitleLevel)^FightSkill.tbParam.nTitleLevelPower)*FightSkill.tbParam.nTitleLevelAdjust}, 
				{6, 100+((8-FightSkill.tbParam.nTitleLevel)^FightSkill.tbParam.nTitleLevelPower)*FightSkill.tbParam.nTitleLevelAdjust}, 
				{7, 100+((9-FightSkill.tbParam.nTitleLevel)^FightSkill.tbParam.nTitleLevelPower)*FightSkill.tbParam.nTitleLevelAdjust}, 
				},	
			[3]={{1, 4}, {6, 4}},	--初始值
			},
	},
	chopskill={ --官印属性共享用技能
		autoskill={{{1,33},{2,33}},{{1,1},{2,2}}},
		skill_statetime={{{1,-1},{2,-1}}}
	},
	chopskill_team={ --官印属性共享用技能_队友
		missile_hitcount			={{{1,10},{2,10},{8,10}}},
		skilldamageptrim			={{{1, 5*0.5},{2,10*0.5},{8,10*0.5}}},
		allseriesstateresistrate	={{{1,30*0.5},{2,50*0.5},{8,50*0.5}}},
		lifemax_p					={{{1,30*0.5},{2,50*0.5},{8,50*0.5}}},
		manamax_p					={{{1,30*0.5},{2,50*0.5},{8,50*0.5}}},
		seriesstate_added			={{{1,30*0.5},{2,50*0.5},{8,50*0.5}}},
	},
	chopskill_self={ --官印属性共享用技能_自身
		skilldamageptrim			={{{1, 5},{2,10},{8,10}}},
		allseriesstateresistrate	={{{1,30},{2,50},{8,50}}},
		lifemax_p					={{{1,30},{2,50},{8,50}}},
		manamax_p					={{{1,30},{2,50},{8,50}}},
		seriesstate_added			={{{1,30},{2,50},{8,50}}},
	},

	xkd_avtive_equip={ --buff激活装备属性
		skill_activeequipattrib ={{{1,1},{2,2}}},
	},
	
	skill_chienthan={
		lifemax_p={{{1,50}}},
		damage_all_resist={{{1,100},{2,100}}},
		addphysicsdamage_p={{{1,200},{2,200}}},
		addphysicsmagic_p={{{1,200},{2,200}}},
		state_hurt_resisttime={{{1,100},{1,100}}},
		state_weak_resisttime={{{1,100},{1,100}}},
		state_slowall_resisttime={{{1,100},{1,100}}},
		state_burn_resisttime={{{1,100},{1,100}}},
		state_stun_resisttime={{{1,100},{1,100}}},
	},

	nhammach={ --??/????
		lifemax_v={{{1,1000},{2,2000},{3,3000},{4,4000},{5,5000},{6,6000},{7,7000},{8,11000},{9,13000},{10,18000}}},				
	},
	tammach={ --??/????
		damage_all_resist={{{1,50},{2,100},{3,150},{4,200},{5,250},{6,350},{7,450},{8,550},{9,650},{10,900}}},				
	},
	duongduymach={ --??/????
		addphysicsmagic_v={{{1,20},{2,40},{3,60},{4,80},{5,100},{6,130},{7,160},{8,190},{9,220},{10,300}}},				
	},
	amduymach={ --??/????
		addphysicsdamage_v={{{1,20},{2,40},{3,60},{4,80},{5,100},{6,130},{7,160},{8,190},{9,220},{10,300}}},				
	},
	docmach={ --??/????
		lifemax_p={{{1,5},{2,10},{3,15},{4,20},{5,25},{6,35},{7,45},{8,5},{9,65},{10,90}}},					
	},
	quannguyen={ --??/????
		lifereplenish_p={{{1,5},{2,8},{3,11},{4,14},{5,17},{6,22},{7,27},{8,32},{9,37},{10,50}}},					
	},
	xungmach={ --??/????
		deadlystrikedamageenhance_p={{{1,1},{2,3},{3,5},{4,7},{5,9},{6,12},{7,15},{8,18},{9,21},{10,30}}},					
	},
	khihai={ --??/????
		vitality_v={{{1,10},{2,20},{3,30},{4,40},{5,50},{6,80},{7,110},{8,140},{9,170},{10,250}}},					
	},
	menhmon={ --??/????
		energy_v={{{1,10},{2,20},{3,30},{4,40},{5,50},{6,80},{7,110},{8,140},{9,170},{10,250}}},					
	},
	thientrung={ --??/????
		strength_v={{{1,10},{2,20},{3,30},{4,40},{5,50},{6,80},{7,110},{8,140},{9,170},{10,250}}},					
	},
	anduong={ --??/????
		dexterity_v={{{1,10},{2,20},{3,30},{4,40},{5,50},{6,80},{7,110},{8,140},{9,170},{10,250}}},					
	},
	duongkhieumach={ --??/????
		addphysicsmagic_p={{{1,1},{2,3},{3,5},{4,7},{5,9},{6,12},{7,15},{8,18},{9,21},{10,30}}},					
	},
	amkhieumach={ --??/????
		addphysicsdamage_p={{{1,1},{2,3},{3,5},{4,7},{5,9},{6,12},{7,15},{8,18},{9,21},{10,30}}},					
	},
	doimach={ --??/????
		defencedeadlystrikedamagetrim={{{1,3},{2,5},{3,7},{4,9},{5,11},{6,15},{7,19},{8,23},{9,27},{10,40}}},					
	},
	chuthien={ --??/????
		skilldamageptrim={{{1,1},{2,2},{3,3},{4,4},{5,5},{6,7},{7,9},{8,11},{9,13},{10,20}}},					
	},
	cuuduongthancong={ --??/????
		lifereplenish_v={{{1,3000},{10,3000}}},
		lifemax_p={{{1,0},{2,50},{10,50}}},
		deadlystrikedamageenhance_p={{{1,0},{3,15},{4,15},{10,15}}},
		lifereplenish_p={{{1,0},{4,0},{5,30},{10,30}}},
		skillselfdamagetrim={{{1,0},{5,0},{6,10},{10,10}}},
		skilldamageptrim={{{1,0},{4,0},{5,10},{10,10}}},
		lifemax_v={{{1,0},{6,0},{7,15000},{8,15000},{10,15000}}},
		ignoreskill={{{1,0},{7,0},{8,10},{9,10},{10,10}},0,{{1,3},{2,3}}},
		dynamicmagicshield_v={{{1,0},{8,0},{9,100},{10,100}},40},
		--autoskill={{{1,15},{2,15}},{{1,1},{10,10}}},	
		--state_freeze_attack={{{1,0},{8,0},{9,25},{10,25}},{{1,0*1.5},{8,0*3},{9,18*3.1}}},
	},
	truongsinhma={ --??/????
		lifemax_v={{{1,1000},{2,2000},{10,10000},{11,12000}}},
		lifereplenish_p={{{1,5},{2,10}}},				
	},
	thietgiapma={ --??/????
		lifemax_p={{{1,10},{2,20}}},
		lifereplenish_p={{{1,5},{2,10}}},				
	},
	ngumathuat={ --??/????
		defencedeadlystrikedamagetrim={{{1,5},{2,10}}},
		lifereplenish_v={{{1,500},{2,1000}}},
		--lifereplenish_p={{{1,5},{2,10}}},				
	},
	duongma={ --??/????
		addphysicsmagic_p={{{1,10},{2,20}}},
		addphysicsdamage_p={{{1,10},{2,20}}},		
	},
	huyetsatma={ --??/????
		deadlystrikedamageenhance_p={{{1,2},{2,4}}},	
	},

}

FightSkill:AddMagicData(tb)

local tbSkill	= FightSkill:GetClass("tongweixianhua");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbChildInfo2	= KFightSkill.GetSkillInfo(tbChildInfo.tbEvent.nStartSkillId, tbChildInfo.tbEvent.nLevel);
	local szMsg	= string.format("\nCách %s giây thi triển: <color=green>Thông Vi Hiển Hóa<color>\n<color=blue>Hiệu quả bản thân:<color>\nSát thương quái: +<color=gold>%s%%<color>\nSinh lực tối đa: +<color=gold>%s%%<color>\nNội lực tối đa: +<color=gold>%s%%<color>\n<color=blue>Hiệu quả đồng đội:<color>\nSát thương quái: +<color=gold>%s%%<color>\nDuy trì <color=gold>%s giây<color>",
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime),
		tbChildInfo2.tbWholeMagic["npcdamageadded"][1],
		tbChildInfo2.tbWholeMagic["lifemax_p"][1],
		tbChildInfo2.tbWholeMagic["manamax_p"][1],
		tbChildInfo.tbWholeMagic["npcdamageadded"][1],
		FightSkill:Frame2Sec(tbChildInfo.nStateTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("bootskill");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbChildInfo2	= KFightSkill.GetSkillInfo(tbChildInfo.tbEvent.nStartSkillId, tbChildInfo.tbEvent.nLevel);
	local szMsg	= string.format("\nCách %s giây thi triển: <color=green>Du Long Chân Khí<color>\n<color=blue>Hiệu quả bản thân:<color>\nTốc độ di chuyển: +<color=gold>%s%%<color>\nCường hóa tương khắc ngũ hành: +<color=gold>%s<color>\nNhược hóa tương khắc ngũ hành: +<color=gold>%s<color>\n<color=blue>Hiệu quả đồng đội:<color>\nTốc độ di chuyển: +<color=gold>%s%%<color>\nCường hóa tương khắc ngũ hành: +<color=gold>%s<color>\nNhược hóa tương khắc ngũ hành: +<color=gold>%s<color>\nDuy trì <color=gold>%s giây<color>",
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime),
		tbChildInfo2.tbWholeMagic["fastwalkrun_p"][1],
		tbChildInfo2.tbWholeMagic["seriesenhance"][1],
		tbChildInfo2.tbWholeMagic["seriesabate"][1],
		tbChildInfo.tbWholeMagic["fastwalkrun_p"][1],
		tbChildInfo.tbWholeMagic["seriesenhance"][1],
		tbChildInfo.tbWholeMagic["seriesabate"][1],
		FightSkill:Frame2Sec(tbChildInfo.nStateTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("chopskill");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local tbChildInfo2	= KFightSkill.GetSkillInfo(tbChildInfo.tbEvent.nStartSkillId, tbChildInfo.tbEvent.nLevel);
	
	local tb = {
			"Tỷ lệ gây thọ thương: +<color=gold>",
			"Tỷ lệ suy nhược: +<color=gold>",
			"Tỷ lệ làm chậm: +<color=gold>",
			"Tỷ lệ bỏng: +<color=gold>",
			"Tỷ lệ choáng: +<color=gold>",
			"Tỷ lệ hiệu quả ngũ hành: +<color=gold>",
		};
	local nSeries = me.nSeries;
	if (nSeries >  6 or nSeries <=0) then
		nSeries = 6;
	end;
	
	local szMsg1 = tb[nSeries] .. tbChildInfo2.tbWholeMagic["seriesstate_added"][1] .. "<color>";
	local szMsg2 = tb[nSeries] .. tbChildInfo.tbWholeMagic["seriesstate_added"][1] .. "<color>";
	
	local szMsg	= string.format("\n<color=blue>Hiệu quả bản thân:<color>\nPhát huy lực tấn công cơ bản: +<color=gold>%s%%<color>\nXác suất trạng thái ngũ hành: -<color=gold>%s<color>\nTỷ lệ sinh mạng: +<color=gold>%s%%<color>\nTỷ lệ nội lực: +<color=gold>%s%%<color>\n%s\n<color=blue>Hiệu quả đồng đội:<color>\nPhát huy lực tấn công cơ bản: +<color=gold>%s%%<color>\nXác suất trạng thái ngũ hành: -<color=gold>%s<color>\nTỷ lệ sinh lực: +<color=gold>%s%%<color>\nTỷ lệ nội lực: +<color=gold>%s%%<color>\n%s\nSố mục tiêu ảnh hưởng lớn nhất: <color=gold>%s<color>\nDuy trì <color=gold>%s giây<color>",
		tbChildInfo2.tbWholeMagic["skilldamageptrim"][1],
		tbChildInfo2.tbWholeMagic["allseriesstateresistrate"][1],
		tbChildInfo2.tbWholeMagic["lifemax_p"][1],
		tbChildInfo2.tbWholeMagic["manamax_p"][1],
		szMsg1,
		tbChildInfo.tbWholeMagic["skilldamageptrim"][1],
		tbChildInfo.tbWholeMagic["allseriesstateresistrate"][1],
		tbChildInfo.tbWholeMagic["lifemax_p"][1],
		tbChildInfo.tbWholeMagic["manamax_p"][1],
		szMsg2,
		tbChildInfo.tbWholeMagic["missile_hitcount"][1],
		FightSkill:Frame2Sec(tbChildInfo.nStateTime));
	return szMsg;
end;

local tbSkill	= FightSkill:GetClass("tianxiashengong");

function tbSkill:GetAutoDesc(tbAutoInfo, tbSkillInfo)
	local tbChildInfo	= KFightSkill.GetSkillInfo(tbAutoInfo.nSkillId, tbAutoInfo.nSkillLevel);
	local szMsg	= string.format("Tỷ lệ triển khai khi sắp hôn mê: <color=gold>%d%%<color>\nKhông chịu bất cứ sát thương nào, duy trì <color=Gold>%s giây<color>\nThời gian giãn cách: <color=Gold>%s giây<color>",
		tbAutoInfo.nPercent,
		FightSkill:Frame2Sec(tbChildInfo.nStateTime),
		FightSkill:Frame2Sec(tbAutoInfo.nPerCastTime));
	return szMsg;
end;

local tbSkill = FightSkill:GetClass("changeseriesdammage")

function tbSkill:GetExtraDesc(tbInfo)
	if (not tbInfo) then
		return "";
	end

	local szMsg	= string.format("<color=gray>(Đang trong trạng thái nếu dùng lần nữa sẽ đóng kỹ năng)<color>");
	return szMsg;
end
