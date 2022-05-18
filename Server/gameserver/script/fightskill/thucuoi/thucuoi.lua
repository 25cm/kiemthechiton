Require("\\script\\fightskill\\fightskill.lua")
--??
local tb	= {
	thucuoi_ts={ -- Ngo?i Công
		lifemax_v ={{{1,1000},{10,10000}}},
	},
	thucuoi_dt={ -- Ngo?i Công
        lifereplenish_p ={{{1,4},{10,40}}},
        manareplenish_p ={{{1,2},{10,20}}},
	},
	thucuoi_ct={ -- Ngo?i Công
        adddefense_v ={{{1,64},{10,640}}},
	},
	thucuoi_tg={ -- Ngo?i Công
        damage_all_resist={{{1,11},{10,111}}},
	},
	thucuoi_lds={ -- Ngo?i Công
        defencedeadlystrikedamagetrim ={{{1,5},{10,50}}},
	},
	thucuoi_dm={ -- Ngo?i Công
        staminamax_v ={{{1,100},{10,1000}}},
	},
	thucuoi_dgma={ -- Ngo?i Công
		expenhance_p ={{{1,5},{10,50}}},
	},
	thucuoi_pht={ -- Ngo?i Công
        deadlystrikeenhance_r={{{1,48},{10,480}}},
        deadlystrikedamageenhance_p={{{1,6},{10,60}}},
	},
	thucuoi_hbv={ -- Ngo?i Công
		skilldamageptrim ={{{1,5},{10,50}}},
	},
	thucuoi_kln={ -- Ngo?i Công
        skillselfdamagetrim={{{1,5},{10,50}}},
	},
}
FightSkill:AddMagicData(tb)