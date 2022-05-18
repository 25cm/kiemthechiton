Require("\\script\\fightskill\\enchant\\enchant.lua");

local tb	= 
{
	--ÖÐ¼¶ÃØ¼®£ºÅû¾£Õ¶¼¬
	pijingzhanjiadd =
	{
		{
			RelatedSkillId = 41,
			magic = 
			{
				skill_attackradius = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,25}, {10, 250}}},
				},
				skill_param1_v = 
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,2}, {10, 18}}},
				},
			},
		},
	},
};


SkillEnchant:AddBooksInfo(tb)
