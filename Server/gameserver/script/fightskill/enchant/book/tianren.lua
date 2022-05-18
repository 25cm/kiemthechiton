Require("\\script\\fightskill\\enchant\\enchant.lua");

local tb	=
{
	--÷–º∂√ÿºÆ£∫±Ã‘¬∑…–«
	biyuefeixingadd =
	{
		{
			RelatedSkillId = 787,
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
			RelatedSkillId = 492,
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

		{
			RelatedSkillId = 148,
			magic =
			{
				missile_range =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,2}, {10, 4}}},
					value3 = {SkillEnchant.OP_ADD, {{1,2}, {10, 4}}},
				},
			},
		},
	},
	--∏ﬂº∂√ÿºÆ£∫
	zhanrenadvancedbookadd =
	{
		{
			RelatedSkillId = 492,--ª√”∞◊∑ªÍ«π
			magic =
			{
				skill_mintimepercast_v =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18*0.5}, {10, -18*2.5}}},
				},
				skill_mintimepercastonhorse_v =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18*0.5}, {10, -18*2.5}}},
				},
			},
		},
		{
			RelatedSkillId = 787,--ª√”∞◊∑ªÍ«π
			magic =
			{
				state_zhican_attack =
				{
					value1 = {SkillEnchant.OP_ADD,  {{1,40},{10,100}}},
					value2 = {SkillEnchant.OP_ADD,  {{1,2.5*18},{10,2.5*18}}},
				},
			},
		},
		{
			RelatedSkillId = 148,--ƒß“Ù …∆«
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

		{
			RelatedSkillId = 847,--∑…∫ËŒﬁº£
			magic =
			{
				skill_mintimepercast_v =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18}, {10, -18*15}}},
				},
				skill_mintimepercastonhorse_v =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18}, {10, -18*15}}},
				},
			},
		},
	},
	--÷–º∂√ÿºÆ£∫–˛⁄§Œ¸–«
	xuanmingxixingadd =
	{
		{
			RelatedSkillId = 494,
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
				missile_range =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,2}, {10, 6}}},
					value3 = {SkillEnchant.OP_ADD, {{1,2}, {10, 6}}},
				},
				missile_lifetime_v =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,18}, {10, 18*5}}},
				},
			},
		},

		{
			RelatedSkillId = 151,
			magic =
			{
				skill_mintimepercast_v =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18*0.5}, {5, -18*1}, {10, -18*1.5}}},
				},
			},
		},

		{
			RelatedSkillId = 153,
			magic =
			{
				skill_mintimepercast_v =
				{
					value1 = {SkillEnchant.OP_ADD, {{1,-18*0.5}, {5, -18*1}, {10, -18*1.5}}},
				},
			},
		},
	},
};


SkillEnchant:AddBooksInfo(tb)