Require("\\script\\fightskill\\enchant\\enchant.lua");

local tb	= 
{
	--÷–º∂√ÿºÆ£∫∫¨…≥…‰”∞
	hanshasheyingadd =
	{
		{
			RelatedSkillId = 64,
			magic = 
			{
				skill_param1_v = 
				{
					value1 = {SkillEnchant.OP_MUL,  {{1,20}, {10, 50}}},
				},
			},
		},
		
		{
			RelatedSkillId = 72,
			magic = 
			{
				skill_attackradius = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,30}, {10, 80}}},
				},
				missile_range = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,1}, {10, 3}}},
					value3 = {SkillEnchant.OP_ADD,  {{1,1}, {10, 3}}},
				},
			},
		},
		
		{
			RelatedSkillId = 69,
			magic = 
			{
				skill_mintimepercast_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-9}, {5, -18}, {10, -27}, {11, -27}}},
				},
			},
		},
		
		{
			RelatedSkillId = 73,
			magic = 
			{
				skill_mintimepercast_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-9}, {5, -18}, {10, -27}, {11, -27}}},
				},
			},
		},
		
		{
			RelatedSkillId = 71,
			magic = 
			{
				skill_mintimepercast_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-9}, {5, -18}, {10, -27}, {11, -27}}},
				},
			},
		},
		
		{
			RelatedSkillId = 263,
			magic = 
			{
				skill_mintimepercast_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-9}, {5, -18}, {10, -27}, {11, -27}}},
				},
			},
		},
		
		{
			RelatedSkillId = 74,
			magic = 
			{
				skill_mintimepercast_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-9}, {5, -18}, {10, -27}, {11, -27}}},
				},
			},
		},
	},
	
	--÷–º∂√ÿºÆ£∫¬˛ÃÏª®”Í
	mantianhuayuadd =
	{
		{
			RelatedSkillId = 64,
			magic = 
			{
				skill_param1_v = 
				{
					value1 = {SkillEnchant.OP_MUL,  {{1,10}, {10, 30}}},
				},
			},
		},
		
		{
			RelatedSkillId = 266,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,6}, {10, 15}}},
				},
				skill_missilenum_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,2}, {4,2}, {5,4},{10, 4}}},
				},
				skill_mintimepercast_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18}, {10, -18*5}}},
				},
				skill_mintimepercastonhorse_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18}, {10, -18*5}}},
				},
			},
		},
		
		{
			RelatedSkillId = 63,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,4}, {10, 10}}},
				},
				missile_range = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,1}, {10, 1}}},
					value3 = {SkillEnchant.OP_ADD,  {{1,1}, {10, 1}}},
				},
			},
		},
	},
	
	--ª˙πÿ√ÿ ı
	jiguanmishuadd =
	{
		{
			RelatedSkillId = 69,--∂æ¥Ãπ«
			magic = 
			{
				skill_maxmissile = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,1},{6,2},{10,2}}},
				},
				missile_lifetime_v = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,10*18}, {10,20*18}}},
				},
			},
		},
		{
			RelatedSkillId = 71,--π¥ªÍ⁄Â
			magic = 
			{
				skill_maxmissile = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,0},{2,1},{7,2},{10,2}}},
				},
				missile_lifetime_v = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,0*18}, {2,10*18}, {10, 20*18}}},
				},
			},
		},
		{
			RelatedSkillId = 263,--Œ¸–«’Û
			magic = 
			{
				skill_maxmissile = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,0},{2,0},{3,1},{8,2},{10,2}}},
				},
				missile_lifetime_v = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,0*18}, {2,0*18}, {3,10*18}, {10, 20*18}}},
				},
			},
		},
		{
			RelatedSkillId = 73,--≤¯…Ì¥Ã
			magic = 
			{
				skill_maxmissile = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,0},{3,0},{4,1},{9,2},{10,2}}},
				},
				missile_lifetime_v = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,0*18}, {3,0*18}, {4,10*18}, {10,20*18}}},
				},
			},
		},
		{
			RelatedSkillId = 74,--¬“ª∑ª˜
			magic = 
			{
				skill_maxmissile = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,0},{4,0},{5,1},{10,2}}},
				},
				missile_lifetime_v = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,0*18}, {4,0*18}, {5,10*18}, {10, 20*18}}},
				},
			},
		},
	},
xianjing120add =
	{
		{
			RelatedSkillId = 64,
			magic = 
			{
				skill_param1_v = 
				{
					value1 = {SkillEnchant.OP_MUL,  {{1,50}, {10, 50}}},
				},
				skill_mintimepercast_v = 
				{
					value1 = {SkillEnchant.OP_MUL, {{1, -90}, {10, -90}}},
				},
			},
		},
	},

};


SkillEnchant:AddBooksInfo(tb)