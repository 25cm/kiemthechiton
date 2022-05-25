Require("\\script\\fightskill\\enchant\\enchant.lua");

local tb	= 
{
	--ÖÐ¼¶ÃØ¼®£ºÉñÁú°ÚÎ²
	shengongbaiweiadd =
	{
		{
			RelatedSkillId = 128,
			magic = 
			{
				missile_ablility = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,14}, {10, 100}}},
					value2 = {SkillEnchant.OP_SET,  {{1,0}, {10, 0}}},
				},
			},
		},
		
		{
			RelatedSkillId = 131,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,6}, {10, 15}}},
				},
				missile_ablility = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,14}, {10, 100}}},
					value2 = {SkillEnchant.OP_SET,  {{1,2}, {10, 2}}},
				},
			},
		},
		
		{
			RelatedSkillId = 489,
			magic = 
			{
				skill_mintimepercast_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-1*18}, {10, -5*18}}},
				},
				skill_mintimepercastonhorse_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-1*18}, {10, -5*18}}},
				},
			},
		},
		
		{
			RelatedSkillId = 134,
			magic = 
			{
				missile_speed_v = 
				{
					value1 = {SkillEnchant.OP_ADD, {{1,6}, {10, 15}}},
				},
				missile_range = 
				{
					value3 = {SkillEnchant.OP_ADD, {{1,1}, {10, 2}}},
				},
			},
		},
		
		{
			RelatedSkillId = 135,
			magic = 
			{
				missile_range = 
				{
					value3 = {SkillEnchant.OP_ADD, {{1,1}, {10, 3}}},
				},
			},
		},
	},
	
	qinlonggongadd =
	{
		{
			RelatedSkillId = 490,
			magic = 
			{
				state_palsy_attack = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,7}, {10, 20}}},
					value2 = {SkillEnchant.OP_ADD,  {{1,18*1.5},{10,18*2.5}}},
				},
			},
		},
	},
	gungai120add =
	{
		{
			RelatedSkillId = 141,--????817
			magic = 
			{
				state_knock_attack = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1, 1},{10, 7},{10,7}}},
					value2 = {SkillEnchant.OP_ADD,  {{1, 1},{10,10}}},
					value3 = {SkillEnchant.OP_ADD,  {{1,26},{10,26}}},
				},
			},
		},
		{
			RelatedSkillId = 817,--??????
			magic = 
			{
				state_drag_attack = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1, 2},{10,20},{11,20}}},
					value2 = {SkillEnchant.OP_ADD,  {{1, 1},{10,10}}},
					value3 = {SkillEnchant.OP_ADD,  {{1,32},{10,32}}},
				},
			},
		},
	},
};


SkillEnchant:AddBooksInfo(tb)