
-- 装备，秘籍修为配置

Require("\\script\\item\\externsetting\\externsetting.lua");

------------------------------------------------------------------------------------------
-- initialize

local tbSignetSetting = Item.tbExternSetting:GetClass("soulsignet");

tbSignetSetting.TABLEFILE_LEVELKARMA	= "levelsetting.txt";
tbSignetSetting.MIN_LEVEL				= 1;			-- 秘籍等级下限
tbSignetSetting.MAX_LEVEL				= 399;			-- 秘籍等级上限

------------------------------------------------------------------------------------------
-- interface

function tbSignetSetting:Load(szPath)

	local bRet = 1;

	if (1 ~= self:LoadLevelSetting(szPath)) then
		bRet = 0;
	end

	return	bRet;

end

------------------------------------------------------------------------------------------
-- private

function tbSignetSetting:LoadLevelSetting(szDir)
	self.m_LevelExp1 = {};
	self.m_LevelExp2 = {};
	self.m_LevelExp3 = {};
	self.m_LevelExp4 = {};
	self.m_LevelExp5 = {};
	self.m_LevelValue1 = {};
	self.m_LevelValue2 = {};
	self.m_LevelValue3 = {};
	self.m_LevelValue4 = {};
	self.m_LevelValue5 = {};

	local tbNumColName = { Level = 1, UpgardeExp1 = 1, Value1 = 1, UpgardeExp2 = 1, Value2 = 1 ,UpgardeExp3 = 3, Value3 = 1, UpgardeExp4 = 1, Value4 = 1,UpgardeExp5 = 1, Value5 = 1};
	local tbFile = Lib:LoadTabFile(szDir..self.TABLEFILE_LEVELKARMA, tbNumColName);
	if tbFile then
		for _, tbItem in pairs(tbFile) do
			local nLevel = tbItem.Level;
			self.m_LevelExp1[nLevel] = tbItem.UpgardeExp1;
			self.m_LevelValue1[nLevel] = tbItem.Value1;
			self.m_LevelExp2[nLevel] = tbItem.UpgardeExp2;
			self.m_LevelValue2[nLevel] = tbItem.Value2;
			self.m_LevelExp3[nLevel] = tbItem.UpgardeExp3;
			self.m_LevelValue3[nLevel] = tbItem.Value3;
			self.m_LevelExp4[nLevel] = tbItem.UpgardeExp4;
			self.m_LevelValue4[nLevel] = tbItem.Value4;
			self.m_LevelExp5[nLevel] = tbItem.UpgardeExp5;
			self.m_LevelValue5[nLevel] = tbItem.Value5;
		end
	end
	return	1;

end
