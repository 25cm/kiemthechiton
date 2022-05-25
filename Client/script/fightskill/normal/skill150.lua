local tb	= {
	skill150tlb={
		appenddamage_p= {{{1,40*0.7},{10,40},{11,40*FightSkill.tbParam.nSadd}}}, -- Phát huy lực tấn công cơ bản
		physicsenhance_p={{{1,67*0.7},{10,67},{11,67*FightSkill.tbParam.nSadd}}}, -- Vật công 
		physicsdamage_v={ -- Damage vật lý + thêm
			[1]={{1,285*0.9*0.7},{10,285*0.9},{11,285*0.9*FightSkill.tbParam.nSadd}},
			[3]={{1,285*1.1*0.7},{10,285*1.1},{11,285*1.1*FightSkill.tbParam.nSadd}}
			},
		skill_cost_v={{{1,100},{10,150}}}, -- Mana sử dụng
		seriesdamage_r={{{1,250},{10,350},{11,360}}}, -- Ngũ hành tương khắc 1,2,3,4,5 = Kim, Mộc, Thủy, Hỏa, Thổ
		state_hurt_attack={{{1,10},{10,32}},{{1,18*1},{10,18*4}}}, -- Xác suất gây thọ thương, Thời gian duy trì
		missile_hitcount={{{1,3},{10,3}}}, -- Số người ảnh hưởng mỗi chiêu
		skill_appendskill={{{1,36},{10,36}},{{1,2},{10,20},{11,21}}}, -- Skill sử dụng kèm ở đây là skill 36 Thất tinh la sát công, 1 cấp skill 150 = 2 cấp skill kèm theo, 10 cấp = 20, 11 = 21
	},
	skill150cbr={
		appenddamage_p= {{{1,15*FightSkill.tbParam.nS1},{10,25},{20,35*FightSkill.tbParam.nS20},{21,36*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}}, -- Lực tấn công cơ bản
		firedamage_v={ -- Damage hỏa công
			[1]={{1,550*0.9*FightSkill.tbParam.nS1},{10,550*0.9},{20,550*0.9*FightSkill.tbParam.nS20},{21,550*0.9*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}},
			[3]={{1,550*1.1*FightSkill.tbParam.nS1},{10,550*1.1},{20,550*1.1*FightSkill.tbParam.nS20},{21,550*1.1*FightSkill.tbParam.nS20*FightSkill.tbParam.nSadd}}
			},
		seriesdamage_r={{{1,250},{10,350},{11,360}}},
		skill_cost_v={{{1,100},{10,200},{11,220}}},
		state_burn_attack={{{1,10},{10,25},{11,27}},{{1,36},{10,54},{11,58}}}, -- Xác suất gây bỏng
		skill_missilenum_v={{{1,8},{10,18}}},  -- Số lượng skill bắn ra cấp 1 8 cấp 10 18
		skill_vanishedevent={{{1,135},{20,135}}}, --  Sự kiện khi va chạm vào taget -- cấp 1 xh 135 cấp 20 xh 135
		skill_showevent={{{1,8},{20,8}}}, -- Chưa rõ
		missile_range={1,0,1}, -- Chưa rõ
		missile_speed_v={40}, -- tốc độ bay của skill 40
	},
}
FightSkill:AddMagicData(tb)
