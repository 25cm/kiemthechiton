Require("\\script\\fightskill\\enchant\\enchant.lua");

local tb	= 
{
	--乘霜式
	chengshuangshiadd =
	{
		{
			RelatedSkillId = 1300,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,40}, {2, 4}, {3, 8}, {4, 12}, {5, 16}, {6, 20}}},
				},
			},
		},
		{
			RelatedSkillId = 1301,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,60}, {2, 6}, {3, 12}, {4, 18}, {5, 24}, {6, 30}}},
				},
			},
		},
		{
			RelatedSkillId = 1302,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,40}, {2, 4}, {3, 8}, {4, 12}, {5, 16}, {6, 20}}},
				},
			},
		},
		{
			RelatedSkillId = 1304,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,40}, {2, 4}, {3, 8}, {4, 12}, {5, 16}, {6, 20}}},
				},
			},
		},
		{
			RelatedSkillId = 1306,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,40}, {2, 4}, {3, 8}, {4, 12}, {5, 16}, {6, 20}}},
				},
			},
		},
		{
			RelatedSkillId = 1308,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,40}, {2, 4}, {3, 8}, {4, 12}, {5, 16}, {6, 20}}},
				},
			},
		},
		{
			RelatedSkillId = 1309,
			magic = 
			{
				missile_speed_v = 
				{
					vvalue1 = {SkillEnchant.OP_ADD, {{1,40}, {2, 4}, {3, 8}, {4, 12}, {5, 16}, {6, 20}}},
				},
			},
		},
	},
	
	--手套效果
	snowgloveadd =
	{
		{
			RelatedSkillId = 1300,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,40}, {2, 4}, {3, 8}, {4, 12}, {5, 16}, {6, 20}}},
				},
			},
		},
		{
			RelatedSkillId = 1301,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,60}, {2, 6}, {3, 12}, {4, 18}, {5, 24}, {6, 30}}},
				},
			},
		},
		{
			RelatedSkillId = 1302,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,40}, {2, 4}, {3, 8}, {4, 12}, {5, 16}, {6, 20}}},
				},
			},
		},
		{
			RelatedSkillId = 1304,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,40}, {2, 4}, {3, 8}, {4, 12}, {5, 16}, {6, 20}}},
				},
			},
		},
		{
			RelatedSkillId = 1306,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,40}, {2, 4}, {3, 8}, {4, 12}, {5, 16}, {6, 20}}},
				},
			},
		},
		{
			RelatedSkillId = 1308,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,40}, {2, 4}, {3, 8}, {4, 12}, {5, 16}, {6, 20}}},
				},
			},
		},
		{
			RelatedSkillId = 1309,
			magic = 
			{
				missile_speed_v = 
				{
					vvalue1 = {SkillEnchant.OP_ADD, {{1,40}, {2, 4}, {3, 8}, {4, 12}, {5, 16}, {6, 20}}},
				},
			},
		},
	},
};


SkillEnchant:AddBooksInfo(tb)