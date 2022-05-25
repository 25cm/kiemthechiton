
if (not FightSkill.tbStatereplaceregular) then
	FightSkill.tbStateReplaceRegular = {};
end

local tbRegular = FightSkill.tbStateReplaceRegular;

tbRegular.tbReplaceRegular = 
{
	-- 新来的强制替换
	tbForceReplace = 
	{
		{383,1344,1345,1346,1347,1349,1351,1353,1355,1357,1811,1813,1815,1817,1819,1821,1823,1825},
		{381,382,1348,1350,1352,1354,1356,1810,1812,1814,1816,1818,1820,1822,1824},
		{1401,1404,586},
		{830},--袖箭120伤害增加状态
		{834},--掌毒传递伤害
		{2093,2095},--韩丹的两种debuff互相覆盖
		},
	
	-- 等级高的替换 
	tbLevelReplace = 
	{
		{385,876},
		{386,877},
		{387,878},
		{106,277},
		{1625,1626},--侠客岛资源点debuff用10级覆盖占领buff
		{1154,1638},
	},

	-- 时间多的替换
	tbTimeReplace = 
	{
		{476},--周菜和月菜剩余时间多的覆盖
	},
	-- 自身的优先
	tbRelation = 
	{
		{25,253},
		{46,239},
		{55,240},
		{61,275},
		{201,247},
		{101,276},
		{102,241},
		{108,278},
		{116,244},
		{228,779},
		{164,242},
		{170,243},
		{180,245},
		{191,246},
		{177,780},
		{1360,1361},
		{1298,1299},
		{1472,1473},
		{855,1186},
		{1254,1269},
		{1249,1266},
		{838,1647},
		{826,1665},
	},
	-- 魔法属性值较大的优先，设为一组内的技能需要有且仅有一条魔法属性，且是相同属性，才会生效
	-- 若技能填入如下组，则该技能本身的替代规则也由默认的等级优先，变为大数值优先
	tbMagicValue = 
	{
		{333,478,880},
		{482,882},
		{835,1173},
	},
	tbFirstRecValue =
	{
		{210},--乾坤大挪移
		{1281},--被动触发的悲酥清风,以免被反弹诅咒频繁反弹
		{774},--被动触发的万蛊蚀心,以免被反弹诅咒频繁反弹
		{801},--被动触发的悲魔血光,以免被反弹诅咒频繁反弹
		{269},--被动触发的瘟蛊之气,以免被反弹诅咒频繁反弹
	},
	--如果以前存在此buff，则buff等级+1，即叠加
	tbSuperpose = 
	{
		{1273},
		{1276},
		{1279},
		{1285},
		{13},--轻功耗体叠加
		{1292},--袖箭120子
		{1648},--刀翠120子
		{1112},--剑武120子
		{1671},--气武120子
		{1661},--剑昆120子
		{1848},--伏牛山boss技能,叠加受到伤害增加
		{1870},--叠加受到伤害增加
		{1875},--叠加受到伤害增加
		{1886},--叠加受到伤害增加
		{1892},--叠加受到伤害增加
		{1900},--叠加受到伤害增加
		{1917},--叠加受到伤害增加
		{1925},--叠加攻击增加
		{1938},--叠加受到伤害增加
		{1953},--叠加攻击增加
		{2170},
		{1855},--自动伤害叠加
	},
}

function tbRegular:AdjustSkillRegular()
	local tbSkillCheck = {};
	for _, tbRegular in pairs(self.tbReplaceRegular) do
		for _, tbSkillId in ipairs(tbRegular) do
			for _, nSkillId in ipairs(tbSkillId) do
				assert(not tbSkillCheck[nSkillId]);
				tbSkillCheck[nSkillId] = 1;
			end
		end
	end
end

tbRegular:AdjustSkillRegular();


function tbRegular:GetConflictingSkillList(nDesSkillId)
	for _, tbRegular in pairs(self.tbReplaceRegular) do
		for _, tbSkillId in ipairs(tbRegular) do
			for _, nSkillId in ipairs(tbSkillId) do
				if (nDesSkillId == nSkillId) then
					return tbSkillId;
				end
			end
		end
	end
end

function tbRegular:GetStateGroupReplaceType(nDesSkillId)
	for _, tbSkillId in ipairs(self.tbReplaceRegular.tbForceReplace) do
		for _, nSkillId in ipairs(tbSkillId) do
			if (nDesSkillId == nSkillId) then
				return 1;
			end
		end
	end
	
	for _, tbSkillId in ipairs(self.tbReplaceRegular.tbLevelReplace) do
		for _, nSkillId in ipairs(tbSkillId) do
			if (nDesSkillId == nSkillId) then
				return 2;
			end
		end
	end
	
	for _, tbSkillId in ipairs(self.tbReplaceRegular.tbTimeReplace) do
		for _, nSkillId in ipairs(tbSkillId) do
			if (nDesSkillId == nSkillId) then
				return 3;
			end
		end
	end
	
	for _, tbSkillId in ipairs(self.tbReplaceRegular.tbRelation) do
		for _, nSkillId in ipairs(tbSkillId) do
			if (nDesSkillId == nSkillId) then
				return 4;
			end
		end
	end
	
	for _, tbSkillId in ipairs(self.tbReplaceRegular.tbMagicValue) do
		for _, nSkillId in ipairs(tbSkillId) do
			if (nDesSkillId == nSkillId) then
				return 5;
			end
		end
	end
	
	for _, tbSkillId in ipairs(self.tbReplaceRegular.tbFirstRecValue) do
		for _, nSkillId in ipairs(tbSkillId) do
			if (nDesSkillId == nSkillId) then
				return 6;
			end
		end
	end
	
	for _, tbSkillId in ipairs(self.tbReplaceRegular.tbSuperpose) do
		for _, nSkillId in ipairs(tbSkillId) do
			if (nDesSkillId == nSkillId) then
				return 7;
			end
		end
	end
	
	return 0;
end
