Require("\\script\\fightskill\\enchant\\enchant.lua");

local tb	= 
{
	--中级秘籍：达摩闭息功
	damobixigongadd =
	{
		{
			RelatedSkillId = 24,
			magic = 
			{
				missile_range = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,1}, {10, 1}}},
					value3 = {SkillEnchant.OP_ADD,  {{1,1}, {10, 1}}},
				},
			},
		},
		
		{
			RelatedSkillId = 251,
			magic = 
			{
				state_slowall_attack = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,7}, {10, 25}}},
				},
				missile_range = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,2}, {10, 6}}},
					value3 = {SkillEnchant.OP_ADD,  {{1,2}, {10, 6}}},
				},
			},
		},
	},
};


SkillEnchant:AddBooksInfo(tb)