------------------------------------------------------
-- 文件名　：zhenyuansetting.lua
-- 创建者　：dengyong
-- 创建时间：2010-07-05 14:58:24
-- 功能    ：真元的配置表管理
------------------------------------------------------
Item.tbZhenYuanSetting  = {};

local tbZhenYuanSetting = Item.tbZhenYuanSetting;

tbZhenYuanSetting.PATH_SETTING		= "\\setting\\item\\001\\zhenyuansetting\\";

tbZhenYuanSetting.ATTRIB_SETTING	= "attribsetting.txt";  -- 属性配置表
tbZhenYuanSetting.LEVEL_SETTING		= "levelsetting.txt";   -- 属性等级表
tbZhenYuanSetting.MIN_LEVEL				= 1;			-- 等级下限
tbZhenYuanSetting.MAX_LEVEL				= 500;			-- 等级上限

-- 存放这些配置数据的内存表
tbZhenYuanSetting.tbAttribSetting 			= {};	-- 属性价值量和成长表
tbZhenYuanSetting.tbAttribNameToId 			= {};	-- 魔法属性名到魔法属性ID映射表
tbZhenYuanSetting.m_LevelExp = {};
tbZhenYuanSetting.m_LevelValue = {};


-- 属性配置表（价值量和资质成长）
-- tbAttribSetting = 
-- {
--		[AttribId] = {szDesc, nWeight, StarLevel1Value, ..., StarLevel20Value, StarLevel1Growth, ..., StarLevel20Growth}
-- }
-- tbAttribNameToId =
-- {
-- 		[Desc] = {AttribId},
-- }
function tbZhenYuanSetting:LoadAttribSetting()
	local tbFile = Lib:LoadTabFile(self.PATH_SETTING..self.ATTRIB_SETTING);
	if not tbFile then
		print("属性配置表表加载失败！");
		return;
	end
	
	self.tbAttribSetting = {};
	self.tbAttribNameToId = {};
	
	for _, tbValue in pairs(tbFile) do
		local nAttribId = tonumber(tbValue.AttribId);
		if not nAttribId then
			assert(false);
		end
		
		self.tbAttribSetting[nAttribId] = self.tbAttribSetting[nAttribId] or {};
		
		self.tbAttribSetting[nAttribId].szDesc = tbValue.Desc;
		self.tbAttribSetting[nAttribId].szTipText = tbValue.TipText;
		self.tbAttribSetting[nAttribId].szTipDesc = tbValue.TipDesc;
			
		self.tbAttribNameToId[tbValue.Desc] = {};
		self.tbAttribNameToId[tbValue.Desc] = nAttribId;
	end
end

function tbZhenYuanSetting:LoadLevelSetting()
	local tbFile = Lib:LoadTabFile(self.PATH_SETTING..self.LEVEL_SETTING);

	if not tbFile then
		print("属性配置表表加载失败！");
		return;
	end
	
	self.m_LevelExp = {};
	self.m_LevelValue = {};

	for _, tbValue in pairs(tbFile) do
		local nLevel = tonumber(tbValue['Level']);
		self.m_LevelExp[nLevel] = tonumber(tbValue['UpgardeExp']);
		self.m_LevelValue[nLevel] = tonumber(tbValue['Value']);
	end
end
tbZhenYuanSetting:LoadAttribSetting();
tbZhenYuanSetting:LoadLevelSetting();