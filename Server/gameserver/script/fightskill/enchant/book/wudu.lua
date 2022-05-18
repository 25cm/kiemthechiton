Require("\\script\\fightskill\\enchant\\enchant.lua");

local tb	= 
{
	--÷–º∂√ÿºÆ£∫ªØ—™Ωÿ¬ˆ
	huaxuejiemaiadd =
	{
		{
			RelatedSkillId = 269,
			magic = 
			{
				skill_mintimepercast_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18*6}, {10, -18*15}}},
				},
				skill_mintimepercastonhorse_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18*6}, {10, -18*15}}},
				},
			},
		},
		
		{
			RelatedSkillId = 82,
			magic = 
			{
				skill_mintimepercast_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18*1}, {10, -18*10}}},
				},
				skill_mintimepercastonhorse_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18*1}, {10, -18*10}}},
				},
			},
		},
		
		{
			RelatedSkillId = 78,
			magic = 
			{
				fastmanareplenish_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-30},{10,-75}}},
				},
			},
		},
	},
	
	--÷–º∂√ÿºÆ£∫◊∑∑Á∂æº¨
	zhuifengdujiadd =
	{
		{
			RelatedSkillId = 273,
			magic = 
			{
				missile_range = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,2}, {10, 4}}},
					value3 = {SkillEnchant.OP_ADD,  {{1,2}, {10, 4}}},
				},
			},
		},
		
		{
			RelatedSkillId = 88,
			magic = 
			{
				skill_mintimepercast_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18}, {10, -18*10}}},
				},
				skill_mintimepercastonhorse_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18}, {10, -18*10}}},
				},
			},
		},
	},
	--’∆∂æ∏ﬂº∂√ÿºÆ
	zhangduadvancedbookadd =
	{
		{
			RelatedSkillId = 93,--“ı∑Á ¥π«
			magic = 
			{
				missile_range = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,1}, {10, 3}}},
					value3 = {SkillEnchant.OP_ADD,  {{1,1}, {10, 3}}},
				},
			},
		},
		
		{
			RelatedSkillId = 94,--ÃÏÓ∏∂æ ÷
			magic = 
			{
				missile_range = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,1}, {10, 1}}},
					value3 = {SkillEnchant.OP_ADD,  {{1,1}, {10, 1}}},
				},
			},
		},
	},
};


SkillEnchant:AddBooksInfo(tb)