Require("\\script\\fightskill\\enchant\\enchant.lua");

local tb	= 
{
	--中级秘籍：百步穿杨
	baibuchuanyangadd =
	{
		{
			RelatedSkillId = 216,
			magic = 
			{
				skill_attackradius = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,48}, {10, 200}}},
				},
				skill_mintimepercast_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18}, {10,-18*3}}},
				},
			},
		},
		
		{
			RelatedSkillId = 237,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,8}, {10, 35}}},
				},
			},
		},
	},
	
	--中级秘籍：白虹贯日
	baihongguanriadd =
	{
		{
			RelatedSkillId = 226,
			magic = 
			{
				missile_range = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,1}, {10, 1}}},
					value3 = {SkillEnchant.OP_ADD,  {{1,1}, {10, 1}}},
				},
				missile_ablility = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,14}, {10, 100}}},
					value2 = {SkillEnchant.OP_SET,  {{1,0}, {10, 0}}},
				},
			},
		},
		
		{
			RelatedSkillId = 229,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,6}, {10, 15}}},
				},
				missile_ablility = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,14}, {10, 100}}},
					value2 = {SkillEnchant.OP_SET,  {{1,2}, {10, 2}}},
				},	
			},
		},
	},
};


SkillEnchant:AddBooksInfo(tb)