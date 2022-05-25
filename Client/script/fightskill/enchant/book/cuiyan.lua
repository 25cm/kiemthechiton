Require("\\script\\fightskill\\enchant\\enchant.lua");

local tb	= 
{
	--÷–º∂√ÿºÆ£∫Ã§—©Œﬁ∫€
	taxuewuhenadd =
	{
		{
			RelatedSkillId = 120,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,6}, {10, 15}}},
				},
			},
		},
		
		{
			RelatedSkillId = 123,
			magic = 
			{
				missile_range = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,1}, {10, 1}}},
					value3 = {SkillEnchant.OP_ADD, {{1,1}, {10, 1}}},
				},
			},
		},
		
		{
			RelatedSkillId = 125,
			magic = 
			{
				missile_range = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,1}, {10, 1}}},
					value3 = {SkillEnchant.OP_ADD, {{1,1}, {10, 1}}},
				},
			},
		},
	},
shimianmaifuadd =
	{
		{
			RelatedSkillId = 117,
			magic = 
			{
				keephide = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,1}, {10, 1}}},
				},
			},
		},
	},
};


SkillEnchant:AddBooksInfo(tb)