--战场道具技能
local tb	= {
	bt_lifereplenish_v={
		lifereplenish_v={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_manareplenish_v={
		manareplenish_v={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_staminareplenish_v={
		staminareplenish_v={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_lifereplenish_p={
		lifereplenish_p={{{1,5},{2,10}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_manareplenish_p={
		manareplenish_p={{{1,5},{2,10}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_lifemax_v={
		lifemax_v={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_manamax_v={
		manamax_v={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_staminamax_v={
		staminamax_v={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_lifemax_p={
		lifemax_p={{{1,5},{2,10}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_manamax_p={
		manamax_p={{{1,5},{2,10}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_staminamax_p={
		staminamax_p={{{1,5},{2,10}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_attackratingenhance_v={
		attackratingenhance_v={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_adddefense_v={
		adddefense_v={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_attackratingenhance_p={
		attackratingenhance_p={{{1,5},{2,10}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_adddefense_p={
		adddefense_p={{{1,5},{2,10}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_fastwalkrun_p={
		fastwalkrun_p={{{1,5},{2,10}}},
		skill_statetime={{{1,18 * 10},{2,18 * 10}}},
	},
	bt_skillspeed={
		castspeed_v={{{1,10},{2,20}}},
		attackspeed_v={{{1,10},{2,20}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_deadlystrikeenhance_r={
		deadlystrikeenhance_r={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_addphysicsdamage_v={
		addphysicsdamage_v={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_addpoisondamage_v={
		addpoisondamage_v={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_addcolddamage_v={
		addcolddamage_v={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_addfiredamage_v={
		addfiredamage_v={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_addlightingdamage_v={
		addlightingdamage_v={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_addphysicsmagic_v={
		addphysicsmagic_v={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_addpoisonmagic_v={
		addpoisonmagic_v={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_addcoldmagic_v={
		addcoldmagic_v={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_addfiremagic_v={
		addfiremagic_v={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_addlightingmagic_v={
		addlightingmagic_v={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_addphysicsdamage_p={
		addphysicsdamage_p={{{1,10},{2,20}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_addphysicsmagic_p={
		ddphysicsmagic_p={{{1,10},{2,20}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_damage_physics_resist={
		damage_physics_resist={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_damage_poison_resist={
		damage_poison_resist={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_damage_cold_resist={
		damage_cold_resist={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_damage_fire_resist={
		damage_fire_resist={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_damage_light_resist={
		damage_light_resist={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_damage_all_resist={
		damage_all_resist={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_life_and_mana_max_v={
		lifemax_v={{{1,50},{2,100}}},
		manamax_v={{{1,50},{2,100}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
	bt_zhanyi={
		damage_all_resist={{{1,50},{2,100},{3,150},{4,250},{5,400}}},
		skill_statetime={{{1,18 * 10},{2,18 * 20}}},
	},
}

FightSkill:AddMagicData(tb)