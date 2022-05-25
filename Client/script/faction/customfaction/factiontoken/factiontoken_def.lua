
Item.tbFactionToken = Item.tbFactionToken or {};
local tbFactionToken = Item.tbFactionToken;

tbFactionToken.PARAM = 
{	-- 接口名  			 	GenInfoId  nBitBegin nBitEnd Desc
	["Active"]  			= {1, 0, 0,  	"Kích hoạt"},				-- 是否激活
	["PhyType"] 			= {1, 1, 3,  	"Nội/Ngoại công"},				-- 内外功
	["Series"]  			= {1, 4, 7,  	"Ngũ hành"},				-- 五行
	["Level"]  				= {1, 8, 15,	"Cấp"},				-- 等级 即开启词条数目
	["ChopParticular"]  	= {1, 16, 23,   "Loại dung hợp Quan Ấn"},		-- 官印融合类型
	["ChopLevel"]  			= {1, 24, 31,   "Cấp dung hợp Quan Ấn"},		-- 官印融合等级
	
	["AttribId1"]   		= {2, 0, 7,  "id thuộc tính 1"},				-- ID
	["AttribLevel1"]    	= {2, 8, 23, "level thuộc tính 1"},				-- 等级 每条属性预留8位
	
	["AttribId2"]   		= {3, 0, 7,  "id thuộc tính 2"},				-- ID
	["AttribLevel2"]    	= {3, 8, 23, "level thuộc tính 2"},				-- 等级 每条属性预留8位
	
	["AttribId3"]   		= {4, 0, 7,  "id thuộc tính 3"},				-- ID
	["AttribLevel3"]    	= {4, 8, 23, "level thuộc tính 3"},				-- 等级 每条属性预留8位
	
	["AttribId4"]   		= {5, 0, 7,  "id thuộc tính 4"},				-- ID
	["AttribLevel4"]    	= {5, 8, 23, "level thuộc tính 4"},				-- 等级 每条属性预留8位
	
	["AttribId5"]   		= {6, 0, 7,  "id thuộc tính 5"},				-- ID
	["AttribLevel5"]    	= {6, 8, 23, "level thuộc tính 5"},				-- 等级 每条属性预留8位
	
	["AttribId6"]   		= {7, 0, 7,  "id thuộc tính 6"},				-- ID
	["AttribLevel6"]    	= {7, 8, 23, "level thuộc tính 6"},				-- 等级 每条属性预留8位
	
	["AttackSumLevel"]		= {8, 0, 15,  "Tổng thuộc tính tấn công"}, 			-- 攻击类属性等级和
	["DefenceSumLevel"]		= {8, 16, 31, "Tổng thuộc tính phòng thủ"}, 			-- 防御类属性等级和
	
	["RareLandLevel"]		= {9, 0, 3, "tăng cấp Lãnh Địa hiếm"},		-- 稀有领地加成等级
};

tbFactionToken.CLASS_NAME 			= "factiontoken";
tbFactionToken.ITEM_GDPL 		 	= {1, 18, 16, 1};
tbFactionToken.PHY_DESC				= {"Ngoại", "Nội"};
tbFactionToken.MAX_NORMAL_ATTRIB	= 6;							-- 最多6条可镶嵌属性
tbFactionToken.MAX_ACTIVE_ATTRIB	= 3;							-- 3条激活属性
tbFactionToken.ACTIVE_ATTRIB_INDEX  = {7, 8, 9};					-- 激活属性位置
tbFactionToken.MAX_ATTRIB			= 9;							-- 最多10条
tbFactionToken.MAGIC_ATTACK			= 1;							-- 攻击类属性
tbFactionToken.MAGIC_DEFENCE		= 2;							-- 防御类属性
tbFactionToken.MAGIC_CLASS_NAME		= {"Công", "Thủ"};					-- 描述
tbFactionToken.MAGIC_CLASS_NAME_EX	= {"Tấn công", "Phòng thủ"};				-- 描述
tbFactionToken.NEED_ITEM_ID			= {18, 1, 3000, 1};				-- 材料
tbFactionToken.NEED_BIND_ITEM_ID	= {18, 1, 3000, 3};				-- 不可交易的材料
tbFactionToken.NEED_ITEM_ID_F		= "18,1,3000,2";				-- 失效的材料
tbFactionToken.RASE_DAILY_MAX		= 4;							-- 升级属性每天上限	vn edit 调整为4次
tbFactionToken.ATTRIB_MAX_LEVEL		= 30;							-- 属性最高等级
tbFactionToken.GET_TOKEN_CONTRIBUTE = 100;							-- 贡献度要求
tbFactionToken.MIN_LEVEL_LIMIT		= 70;							-- 最低等级要求
tbFactionToken.CHOP_BUFF_TIME		= 10080 * 60 *  Env.GAME_FPS;   -- 官印buff有效期
tbFactionToken.CHOP_BUFF_ID			= {3661, 3662};					-- 官印buff id 
tbFactionToken.SPEEDUP_SECOUND		= 30 * 60;						-- 加速30分钟
tbFactionToken.EXCHANGE_MAX			= 100;							-- 每周兑换100个
tbFactionToken.EXCHANGE_TYPE_BC		= 1;							-- 兑换类型绑金
tbFactionToken.EXCHANGE_TYPE_BM		= 2;							-- 兑换类型绑银
tbFactionToken.EXCHANGE_TYPE_CB		= 3;							-- 兑换类型贡献度
tbFactionToken.EXCHANGE_NUM			= {10, 10000, 3};				-- 碎片兑换绑金,绑银,贡献度
tbFactionToken.RARE_LAND_EXTRA_LEVEL= 1;							-- 稀有领地额外加成的等级
tbFactionToken.EUIQP_TOKEN_ACH		= 577;							-- 成就
tbFactionToken.EXCHANGE_TYPE_DESC   = 
{
	"Đồng khóa", "Bạc khóa", "Cống hiến"
};
tbFactionToken.TRADE_NEED_ITEM_CONT = 3000;
tbFactionToken.WEEK_CONSUME_COUNT	= 999999999;					-- 每周消耗到这个阀值成本会增加！	vn edit 取消此限制，把数值改成非常大
tbFactionToken.WEEK_CONSUME_TIME	= 3;							-- 消耗达到阀值后时间增加的倍数
tbFactionToken.WEEK_CONSUME_ITEM	= 5;							-- 消耗达到阀值后材料增加的倍数

tbFactionToken.TASK_GROUP			= 2298;							-- 任务组(1- 60号属性占了！)1-30 号记录属性等级 31-60记录升级时间！（以magictype为key）
tbFactionToken.TASK_GET_ITEM		= 61;							-- 一个角色只能获取一次信物！
tbFactionToken.TASK_RAISE_DAILY_MAX = 62;							-- 升级属性次数 每天清！
tbFactionToken.TASK_RAISE_COIN		= 63;							-- 升级付费次数
tbFactionToken.TASK_DAILY_RAISE		= 64;							-- 付费升级每日价格
tbFactionToken.TASK_DAILY_SPEEDUP	= 65;							-- 付费加速每日价格
tbFactionToken.TASK_WEEKLY_EXCHANGE = 66;							-- 每周兑换个数
tbFactionToken.TASK_WEEKLY			= 67;							-- 周数
tbFactionToken.TASK_WEEK_CONSUME	= 68;							-- 每周消耗的碎片数

tbFactionToken.MAX_LEVEL_DIFF  = 18;			--攻击防御最高等级差

tbFactionToken.tbSKILL_TO_BUFFER = {
	[1297] = 3661,
	[899] = 3662,
	[4006] = 3661,	-- vn edit 越南强化版官印
	[4007] = 3661,	-- vn edit 越南强化版官印
}
tbFactionToken.ICON_PATH			= 
{
	"\\image\\item\\equip\\guanyin\\xw_jin_s.spr",
	"\\image\\item\\equip\\guanyin\\xw_mu_s.spr",
	"\\image\\item\\equip\\guanyin\\xw_shui_s.spr",
	"\\image\\item\\equip\\guanyin\\xw_huo_s.spr",
	"\\image\\item\\equip\\guanyin\\xw_tu_s.spr",
};

tbFactionToken.ICON_PATH_WITH_GUANYIN = 
{
	"\\image\\item\\equip\\guanyin\\g_jin_s.spr",
	"\\image\\item\\equip\\guanyin\\g_mu_s.spr",
	"\\image\\item\\equip\\guanyin\\g_shui_s.spr",
	"\\image\\item\\equip\\guanyin\\g_huo_s.spr",
	"\\image\\item\\equip\\guanyin\\g_tu_s.spr",
};

tbFactionToken.VIEW_PATH			= 
{
	"\\image\\item\\equip\\guanyin\\xw_jin.spr",
	"\\image\\item\\equip\\guanyin\\xw_mu.spr",
	"\\image\\item\\equip\\guanyin\\xw_shui.spr",
	"\\image\\item\\equip\\guanyin\\xw_huo.spr",
	"\\image\\item\\equip\\guanyin\\xw_tu.spr",
};

tbFactionToken.VIEW_PATH_WITH_GUANYIN = 
{
	"\\image\\item\\equip\\guanyin\\g_jin.spr",
	"\\image\\item\\equip\\guanyin\\g_mu.spr",
	"\\image\\item\\equip\\guanyin\\g_shui.spr",
	"\\image\\item\\equip\\guanyin\\g_huo.spr",
	"\\image\\item\\equip\\guanyin\\g_tu.spr",
};

tbFactionToken.CHOP_DESC = 
{
	"Trí Sự",
	"Tư Mã",
	"Thái Thú",
	"Thiếu Khanh",
	"Thượng Khanh",
	"Quốc Công",
	"Thừa Tướng",
	"Hoàng Đế",
};

tbFactionToken.TOKEN_NAME = 
{
	"Kim Lan Chử", 
	"Khổng Tước Vũ",
	"Tầm Tri Âm",
	"Vạn Niên Túy",
	"Ti Trúc Dẫn",
};

tbFactionToken.TOKEN_TIP = 
{
	"Múa gậy vàng, trừ ác phá ma chướng.",
	"Chim bay xa biết nơi đâu mà tìm.",
	"Lên núi gảy đàn, nước chảy cuồn cuộn, cùng phổ Thái Cổ Di Âm.",
	"Ngày nào cùng uống Đỗ Khang, bàn chuyện nhân sinh mấy lượt say.",
	"Tiệc vui ta hết khúc ca, dẫu hay dẫu dở bạn vàng vẫn nghe.",
};

tbFactionToken.MORE_TOKENITEM_NOTICE = 
"\n<color=red>Số Gỗ Lim dùng trong tuần đã vượt 999999999, chi phí thăng cấp thuộc tính Tín Vật (Gỗ Lim, Bạc Lẻ) và thời gian thăng cấp sẽ tăng lên!<enter>";
