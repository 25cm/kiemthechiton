------------------------------------------------------
-- 文件名　：编辑5
-- 创建者　：dengyong
-- 创建时间：2009-12-15 19:47:45
-- 描  述  ：通脉易筋散
------------------------------------------------------
local tbItem = Item:GetClass("tongmaiyijinsan");

tbItem.nSkillId   = 1525;	-- 触发的状态技能ID
local tb = {
	manhan150={ --????
		appenddamage_p= {{{1,58},{2,61}}},
		firedamage_v={
			[1]={{1,500},{2,520}},
			[3]={{1,540},{2,580}}
			},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		skill_cost_v={{{1,100},{20,200},{21,200}}},
		state_burn_attack={{{1,22},{2,24}},{{1,18},{10,45},{11,45}}},
		state_burn_attacktime={{{1,110},{2,120}}},
		state_drag_attack={{{1,0.5},{2,1}},{{1,32},{10,32},{11,32}},{{1,10},{2,10}}},
		skill_vanishedevent={{{1,1973},{20,1973}}},
		skill_showevent={{{1,8},{20,8}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	manhan150ctcon={ --????,???????
		appenddamage_p= {{{1,10*FightSkill.tbParam.nS1},{10,10},{20,10*FightSkill.tbParam.nS20},{21,10*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}},
		firedamage_v={
			[1]={{1,150*0.9*FightSkill.tbParam.nS1},{10,150*0.9},{20,150*0.9*FightSkill.tbParam.nS20},{21,150*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,150*1.1*FightSkill.tbParam.nS1},{10,150*1.1},{20,150*1.1*FightSkill.tbParam.nS20},{21,150*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,100},{20,250},{21,250}}},
		state_burn_attack={{{1,5},{20,25}},{{10,9},{20,9}}},
		missile_hitcount={{{1,3},{5,4},{10,5},{15,6},{20,7},{21,7}}},
	},
	-- Ma nh?n dao ch?a xong
	conlondao150={ --????_20
		appenddamage_p= {{{1,67},{2,69}}},
		physicsenhance_p={{{1,94},{2,98}}},
		lightingdamage_v={
			[1]={{1,428*0.9*FightSkill.tbParam.nS1},{10,428*0.9},{20,428*0.9*FightSkill.tbParam.nS20},{21,428*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,435*1.1*FightSkill.tbParam.nS1},{10,435*1.1},{20,435*1.1*FightSkill.tbParam.nS20},{21,435*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		skill_cost_v={{{1,100},{20,200},{21,205}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		state_stun_attack={{{1,31},{2,32}},{{1,36},{2,36*1.01}}},
		state_hurt_attack={{{1,21},{2,22}},{{1,36},{2,36}}},
		state_stun_attacktime={{{1,110},{2,120}}},
		state_hurt_attacktime={{{1,110},{2,120}}},
		skill_skillexp_v=FightSkill.tbParam.tbHighBookSkillExp,
	},
	conlondao150_child={ --?????
		appenddamage_p= {{{1,67},{2,69}}},
		lightingdamage_v={
			[1]={{1,200*0.9*FightSkill.tbParam.nS1},{10,200*0.9},{20,200*0.9*FightSkill.tbParam.nS20},{21,200*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,220*1.1*FightSkill.tbParam.nS1},{10,220*1.1},{20,220*1.1*FightSkill.tbParam.nS20},{21,220*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		state_hurt_attack={{{1,21},{2,22}},{{1,36},{2,36}}},
		seriesdamage_r={{{1,100},{20,400},{21,410}}},
		missile_speed_v={30},
		missile_range={1,0,1},
	},
	conlondao150_child2={ --?????,???????
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
}
FightSkill:AddMagicData(tb)

function tbItem:OnUse()
	if (Partner.bOpenPartner ~= 1) then
		Dialog:Say("Hoạt động đồng hành đã đóng, không thể sử dụng");
		return 0;
	end

	me.AddSkillState(self.nSkillId, 1, 1, 30 * 60* Env.GAME_FPS, 0);
	Dbg:WriteLog("同伴Log:", me.szName, "使用", it.szName, ",激活同伴获取经验无视怪物等级限制");
	return 1;
end