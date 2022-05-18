-- 文件名　：define.lua
-- 创建者　：zhouchenfei
-- 创建时间：2008-11-13 16:26:06


if not Ladder then --调试需要
	Ladder = {};
	print(GetLocalDate("%Y\\%m\\%d  %H:%M:%S").." build ok ..");
end

local preEnv = _G;	--保存旧的环境
setfenv(1, Ladder);	--设置当前环境为Ladder

-- 排行榜大类
LADDER_CLASS_WLDH				= 1;	-- 其他排行榜类
LADDER_CLASS_LADDER				= 2;	-- 其他排行榜类
LADDER_CLASS_WLLS				= 3;	-- 联赛类
LADDER_CLASS_WULIN				= 4;	-- 武林荣誉
LADDER_CLASS_LINGXIU			= 5;	-- 领袖荣誉
LADDER_CLASS_MONEY				= 6;	-- 财富

-- 排行榜小类
LADDER_TYPE_LADDER_LEVEL			= 1;	-- 等级排行榜小类
LADDER_TYPE_LADDER_ACTION			= 2;	-- 活动排行榜
LADDER_TYPE_LADDER_EVENTPLANT		= 3;


LADDER_TYPE_LADDER_ACTION_SPRING			= 1;
LADDER_TYPE_LADDER_ACTION_XOYOGAME			= 2;
LADDER_TYPE_LADDER_ACTION_DRAGONBOAT		= 3;	-- 龙舟排行榜
LADDER_TYPE_LADDER_ACTION_WEIWANG			= 4;	-- 江湖威望
LADDER_TYPE_LADDER_ACTION_PRETTYGIRL		= 5;	-- 美女大选排行榜
LADDER_TYPE_LADDER_ACTION_KAIMENTASK		= 6;	-- 霸主之印排行榜

LADDER_TYPE_LADDER_EVENTPLANT_CURTEAM		= 1;
LADDER_TYPE_LADDER_EVENTPLANT_PRETEAM		= 2;

LADDER_TYPE_WLLS_CUR_PRIMAY		= 1;	-- 当届联赛初级榜 
LADDER_TYPE_WLLS_CUR_ADV 		= 2;	-- 当届联赛高级榜
LADDER_TYPE_WLLS_HONOR			= 3;	-- 荣誉榜
LADDER_TYPE_WLLS_LAST_PRIMAY		= 4;	-- 上届联赛初级榜
LADDER_TYPE_WLLS_LAST_PRIMAY		= 5;	-- 上届联赛高级榜

LADDER_TYPE_WLDH_FACTION				= 1;	-- 武林大会门派 
LADDER_TYPE_WLDH_DOUBLE 				= 2;	-- 武林大会双人赛
LADDER_TYPE_WLDH_THREE					= 3;	-- 武林大会三人赛
LADDER_TYPE_WLDH_SERIESFIVE				= 4;	-- 武林大会五行五人赛
LADDER_TYPE_WLDH_RAID					= 5;	-- 武林大会团体赛

LADDER_TYPE_WULIN_HONOR_WULIN			= 1;	-- 武林荣誉小类
LADDER_TYPE_WULIN_HONOR_FACTION			= 2;	-- 门派荣誉小类
LADDER_TYPE_WULIN_HONOR_WLLS			= 3;	-- 联赛荣誉小类
LADDER_TYPE_WULIN_HONOR_SONGJINBATTLE	= 4;	-- 宋金荣誉小类

LADDER_TYPE_LINGXIU_HONOR_LINGXIU		= 1;	-- 领袖荣誉小类
LADDER_TYPE_LINGXIU_HONOR_AREABATTLE	= 2;	-- 区域争夺战荣誉小类
LADDER_TYPE_LINGXIU_HONOR_BAIHUTANG		= 3;	-- 白虎堂荣誉小类

LADDER_TYPE_MONEY_HONOR_MONEY		= 1;	-- 财富荣誉小类

tbFacContext = {
		[0] = "Thế Giới";
		[1] = "Thiếu Lâm";
		[2] = "Thiên Vương";
		[3] = "Đường Môn";
		[4] = "Ngũ Độc";
		[5] = "Nga My";
		[6] = "Thúy Yên";
		[7] = "Cái Bang";
		[8] = "Thiên Nhẫn";
		[9] = "Võ Đang";
		[10] = "Côn Lôn";
		[11] = "Minh Giáo";
		[12] = "Đoàn Thị";
	};
	

SEARCHTYPE_PLAYERNAME			= 1;		-- 排行榜搜索类型搜索人名
SEARCHTYPE_WLLSTEAMNAME			= 2;		-- 排行榜搜索类型搜索战队名

preEnv.setfenv(1, preEnv);	--恢复全局环境
	