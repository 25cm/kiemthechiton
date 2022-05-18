--date 27/09
SpecialEvent.Topplayer = SpecialEvent.Topplayer or {};
local Topplayer = SpecialEvent.Topplayer or {};
Topplayer.TSK_GROUP=2127;
Topplayer.TSK_MONEY=1;-- vinh du tai phu
Topplayer.TSK_WULIN=2;-- vo lam 
Topplayer.TSK_WEIWANG=3; -- uy danh 
Topplayer.TSK_LINGXIU=4; -- uy danh 
Topplayer.TSK_BATTLE=5; -- uy danh 
Topplayer.Time=2400;
Topplayer.OPT =
{
	"<color=gold>Đệ Nhất Tài Phú",
	"<color=green>Võ Lâm Cao Thủ",
	"<color=green>UY Chấn Giang Hồ",
	"<color=green>Người Dẫn Đường",
	"<color=green>Xông Pha Trận Mạc",	
}
Topplayer.Aw =
{
	[1]={18,1,1,12},
	[2]={18,1,1,12},
	[3]={18,1,1,12},
	[4]={18,1,1,12},
	[5]={18,1,1,12},
}
Topplayer.IdNpc =
{	
	[1]=
		{
			3656,
		},
	[2] = 
		{
			3657,
			3658,
		},
	[3] = 
		{
			3659,
			3660,
		},
	[4] = 
		{
			3661,
			3662,
		},	
	[5] = 
		{
			3663,
			3664,
		},
	[6] = 
		{
			3665,
			3666,
		},		
	[7] = 
		{
			3667,
			3668,
		},	
	[8] = 
		{
			3669,
			3670,
		},
	[9] = 
		{
			3671,
			3672,
		},
	[10] = 
		{
			3673,
			3674,
		},	
	[11] = 
		{
			3675,
			3676,
		},
	[12] = 
		{
			3677,
			3678,
		},	
};
Topplayer.nLadderType =
{		
	393472,
	262400,
	131588,
	327936,
	263168,
};
Topplayer.Name=
{
	"Vinh dự tài phú",
	"vinh dự võ lâm",
	"uy danh giang hồ ",
	"vinh dự thủ lĩnh",
	"vinh dự tống kim"
};
Topplayer.szMgs=
{
	"%s ,có thứ hạng %s không thể nhận thẻ bài xây dựng.",
};