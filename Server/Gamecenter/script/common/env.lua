
-- 游戏世界基础常量定义（注意保持与程序的一致）

Env.GAME_FPS			= 18;		-- 游戏世界每秒帧数

-- 性别定义
Env.SEX_MALE			= 0;		-- 男性
Env.SEX_FEMALE			= 1;		-- 女性

-- 性别描述字符串
Env.SEX_NAME =
{
	[Env.SEX_MALE]		= "Nam",
	[Env.SEX_FEMALE]	= "Nữ",
};

-- 五行常量定义
Env.SERIES_NONE			= 0;		-- 无系
Env.SERIES_METAL		= 1;		-- 金系
Env.SERIES_WOOD			= 2;		-- 木系
Env.SERIES_WATER		= 3;		-- 水系
Env.SERIES_FIRE			= 4;		-- 火系
Env.SERIES_EARTH		= 5;		-- 土系

-- 五行名称字符串
Env.SERIES_NAME	=
{
	[Env.SERIES_NONE]	= "Vô",
	[Env.SERIES_METAL]	= "Kim",
	[Env.SERIES_WOOD]	= "Mộc",
	[Env.SERIES_WATER]	= "Thủy",
	[Env.SERIES_FIRE]	= "Hỏa",
	[Env.SERIES_EARTH]	= "Thổ",
};

-- 世界新闻类型
Env.NEWSMSG_NORMAL 		= 0;    -- 普通
Env.NEWSMSG_COUNT		= 1;	-- 延时播放
Env.NEWSMSG_TIMEEND		= 2;	-- 定时停止

Env.WEIWANG_BATTLE		= 1;
Env.WEIWANG_MENPAIJINGJI= 2;
Env.WEIWANG_DATI		= 3;
Env.WEIWANG_BAIHUTANG 	= 4;
Env.WEIWANG_TREASURE	= 5;
Env.WEIWANG_BAOWANTONG	= 6;
Env.WEIWANG_GUOZI		= 7;
Env.WEIWANG_BOSS		= 8;

-- 大区类型定义（默认电信）
--	TODO：目前只支持金山版
Env.ZONE_TYPE	=
{
	[2]		= 2,
	[5]		= 2,
	[9]		= 2,
	[11]	= 2,
};

-- 大区类型名定义
Env.ZONE_TYPE_NAME	=
{
	[1]		= "Điện tín",
	[2]		= "Võng thông",
};

function Env:GetZoneType(szGatewayName)
	local nZoneId	= tonumber(string.sub(szGatewayName, 5, 6));
	return self.ZONE_TYPE[nZoneId] or 1;
end
