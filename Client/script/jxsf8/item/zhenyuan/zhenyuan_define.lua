------------------------------------------------------
-- 文件名　：zhenyuan_define.lua
-- 创建者　：dengyong
-- 创建时间：2010-07-14 11:09:02
-- 功能    ：真元相关定义
------------------------------------------------------

Item.tbZhenYuan = Item.tbZhenYuan or {};
Item.ZHENYUAN_EQUIP_CLASS = "zhenyuan";
Item.ZHENYUAN_ATTRIB_NUM = 4;
Item.ZHENYUAN_EXP_PER_ITEM		= 100;				-- 每个道具的经验

--SoulSignet
Item.MIN_ZHENYUAN_LEVEL		= 1;
Item.tbMAX_ZHENYUAN_LEVEL =
{
	[1] = {
		[1] = 400,
		[2] = 400,
		[3] = 400,
		[4] = 400,
	}
}

local tbZhenYuan = Item.tbZhenYuan;

tbZhenYuan.MAPPINGVALUE_MIN		= 0;		-- 属性映射的最小值
tbZhenYuan.MAPPINGVALUE_MAX		= 1000;		-- 属性映射的最大值
tbZhenYuan.MAPPINGVALUE_MAX_ENHANCE = 960;	-- 属性成长映射的最大值

tbZhenYuan.CONVERT_COST_RATE	= 15;		-- 真元凝聚需要消耗同伴价值量15%的银两
tbZhenYuan.REFINE_COST_COUNT	= 20000;	-- 真元炼化固定每次消耗2W银两

tbZhenYuan.bOpen				= 1;		-- 真元开关，1表示开，0表示关
