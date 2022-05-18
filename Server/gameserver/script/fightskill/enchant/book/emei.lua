Require("\\script\\fightskill\\enchant\\enchant.lua");

local tb	= 
{
	--中级秘籍：金顶绵掌
	jindingmianzhangadd =
	{
		{
			RelatedSkillId = 480,
			magic = 
			{
				fastlifereplenish_v = 
				{
					value1 = {SkillEnchant.OP_MUL, {{1,10}, {10, 100}}},
				},
			},
		},
		
		{
			RelatedSkillId = 104,
			magic = 
			{
				missile_range = 
				{
					value3 = {SkillEnchant.OP_ADD, {{1,1}, {10, 2}}},
				},
			},
		},
	},
	
	--中级秘籍：渡元功
	duyuangongadd =
	{
		{
			RelatedSkillId = 107,
			magic = 
			{
				state_slowall_attack = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,6}, {10, 15}}},
				},
			},
		},
		
		{
			RelatedSkillId = 98,
			magic = 
			{
				fastlifereplenish_v = 
				{
					value1 = {SkillEnchant.OP_MUL, {{1,6}, {10, 20}}},
				},
				missile_range = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,2}, {10, 6}}},
					value3 = {SkillEnchant.OP_ADD, {{1,2}, {10, 6}}},
				},
			},
		},
		
		{
			RelatedSkillId = 101,
			magic = 
			{
				lifemax_p = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,14}, {10, 50}}},
				},
				manamax_p = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,7}, {10, 25}}},
				},
			},
		},
		
		{
			RelatedSkillId = 276,
			magic = 
			{
				lifemax_p = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,14}, {10, 50}}},
				},
				manamax_p = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,7}, {10, 25}}},
				},
			},
		},
		
		{
			RelatedSkillId = 110,
			magic = 
			{
				skill_mintimepercast_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-12*18}, {10, -30*18}}},
				},
				skill_mintimepercastonhorse_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-12*18}, {10, -30*18}}},
				},
			},
		},
	},
	--高级秘籍：
	fueadvancedbookadd =
	{	
		
		{
			RelatedSkillId = 98,--慈航普渡
			magic = 
			{
				fastlifereplenish_v = 
				{
					value1 = {SkillEnchant.OP_MUL, {{1,6}, {10, 20}}},
				},
			},
		},
		
		{
			RelatedSkillId = 101,--佛心慈佑
			magic = 
			{
				lifemax_p = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,14}, {10, 50}}},
				},
				manamax_p = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,7}, {10, 25}}},
				},
			},
		},
		
		{
			RelatedSkillId = 276,--佛心慈佑_队友
			magic = 
			{
				lifemax_p = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,14}, {10, 50}}},
				},
				manamax_p = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,7}, {10, 25}}},
				},
			},
		},
		
		{
			RelatedSkillId = 108,--清音梵唱
			magic = 
			{
				allseriesstateresisttime = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,15}, {10, 45}}},
				},
			},
		},
		{
			RelatedSkillId = 278,--清音梵唱_队友
			magic = 
			{
				allseriesstateresisttime = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,12}, {10, 35}}},
				},				
			},
		},

		{
			RelatedSkillId = 482,--普渡众生
			magic = 
			{
				damage_all_resist = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,10}, {10, 30}}},
				},
			},
		},
		{
			RelatedSkillId = 882,--清音梵唱_队友
			magic = 
			{
				damage_all_resist = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,5}, {10, 25}}},
				},
			},
		},
	},
};


SkillEnchant:AddBooksInfo(tb)