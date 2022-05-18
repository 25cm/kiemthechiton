
-- 临时Item模板

local tb = Item:GetClass("tempitem");

local _tbMap	= {
 {"Chiến Trường", "Báo Danh Chiến Trường_Tống (Dương Châu 1)", 181,1654,3314},
 {"Chiến Trường", "Báo Danh Chiến Trường_Tống (Tương Dương 1)", 183,1654,3314},
 {"Chiến Trường", "Báo Danh Chiến Trường_Tống (Phượng Tường 1)", 182,1654,3314},
 {"Chiến Trường", "Báo Danh Chiến Trường_Kim (Dương Châu 1)", 184,1654,3314},
 {"Chiến Trường", "Báo Danh Chiến Trường_Kim (Tương Dương 1)", 186,1654,3314},
 {"Chiến Trường", "Báo Danh Chiến Trường_Kim (Phượng Tường 1)", 185,1654,3314},
 {"Chiến Trường", "Báo Danh Chiến Trường_Tống (Dương Châu 2)", 257,1654,3314},
 {"Chiến Trường", "Báo Danh Chiến Trường_Tống (Tương Dương 2)", 259,1654,3314},
 {"Chiến Trường", "Báo Danh Chiến Trường_Tống (Phượng Tường 2)", 258,1654,3314},
 {"Chiến Trường", "Báo Danh Chiến Trường_Kim (Dương Châu 2)", 260,1654,3314},
 {"Chiến Trường", "Báo Danh Chiến Trường_Kim (Tương Dương 2)", 262,1654,3314},
 {"Chiến Trường", "Báo Danh Chiến Trường_Kim (Phượng Tường 2)", 261,1654,3314},
 {"Chiến Trường", "Bàn Long Cốc Chiến (Dương Châu 1)", 193,2335,3481},
 {"Chiến Trường", "Bàn Long Cốc Chiến (Tương Dương 1)", 195,2335,3481},
 {"Chiến Trường", "Bàn Long Cốc Chiến (Phượng Tường 1)", 194,2335,3481},
 {"Chiến Trường", "Ngũ Trượng Nguyên Chiến (Dương Châu 1)", 190,1767,2977},
 {"Chiến Trường", "Ngũ Trượng Nguyên Chiến (Tương Dương 1)", 192,1767,2977},
 {"Chiến Trường", "Ngũ Trượng Nguyên Chiến (Phượng Tường 1)", 191,1767,2977},
 {"Chiến Trường", "Cửu Khúc Chiến (Dương Châu 1)", 187,1435,3748},
 {"Chiến Trường", "Cửu Khúc Chiến (Tương Dương 1)", 189,1435,3748},
 {"Chiến Trường", "Cửu Khúc Chiến (Phượng Tường 1)", 188,1435,3748},
 {"Chiến Trường", "Bàn Long Cốc Chiến (Dương Châu 2)", 263,2335,3481},
 {"Chiến Trường", "Bàn Long Cốc Chiến (Tương Dương 2)", 265,2335,3481},
 {"Chiến Trường", "Bàn Long Cốc Chiến (Phượng Tường 2)", 264,2335,3481},
 {"Chiến Trường", "Ngũ Trượng Nguyên Chiến (Dương Châu 2)", 266,1767,2977},
 {"Chiến Trường", "Ngũ Trượng Nguyên Chiến (Tương Dương 2)", 268,1767,2977},
 {"Chiến Trường", "Ngũ Trượng Nguyên Chiến (Phượng Tường 2)", 267,1767,2977},
 {"Chiến Trường", "Cửu Khúc Chiến (Dương Châu 2)", 269,1435,3748},
 {"Chiến Trường", "Cửu Khúc Chiến (Tương Dương 2)", 271,1435,3748},
 {"Chiến Trường", "Cửu Khúc Chiến (Phượng Tường 2)", 270,1435,3748},
 {"Chiến Trường", "Báo Danh Chiến Trường_Tống (Dương Châu 3)", 282,1654,3314},
 {"Chiến Trường", "Báo Danh Chiến Trường_Kim (Dương Châu 3)", 283,1654,3314},
 {"Chiến Trường", "Cửu Khúc Chiến (Dương Châu 3)", 284,1435,3748},
 {"Chiến Trường", "Ngũ Trượng Nguyên Chiến (Dương Châu 3)", 285,1767,2977},
 {"Chiến Trường", "Bàn Long Cốc Chiến (Dương Châu 3)", 286,2335,3481},
 {"Chiến Trường", "Báo Danh Chiến Trường_Tống (Phượng Tường 3)", 288,1654,3314},
 {"Chiến Trường", "Báo Danh Chiến Trường_Kim (Phượng Tường 3)", 289,1654,3314},
 {"Chiến Trường", "Cửu Khúc Chiến (Phượng Tường 3)", 290,1435,3748},
 {"Chiến Trường", "Ngũ Trượng Nguyên Chiến (Phượng Tường 3)", 291,1767,2977},
 {"Chiến Trường", "Bàn Long Cốc Chiến (Tương Dương 3)", 292,2335,3481},
 {"Chiến Trường", "Báo Danh Chiến Trường_Tống (Tương Dương 3)", 293,1654,3314},
 {"Chiến Trường", "Báo Danh Chiến Trường_Kim (Tương Dương 3)", 294,1654,3314},
 {"Chiến Trường", "Cửu Khúc Chiến (Tương Dương 3)", 295,1435,3748},
 {"Chiến Trường", "Ngũ Trượng Nguyên Chiến (Tương Dương 3)", 296,1767,2977},
 {"Chiến Trường", "Bàn Long Cốc Chiến (Phượng Tường 3)", 297,2335,3481},
 {"Khu luyện công", "Mông Cổ Vương Đình", 130,1601,3721},
 {"Khu luyện công", "Nguyệt Nha Tuyền", 131,1938,3621},
 {"Khu luyện công", "Tàn Tích Cung A Phòng", 132,1572,3513},
 {"Khu luyện công", "Lương Sơn Bạc", 133,1789,3739},
 {"Khu luyện công", "Thần Nữ Phong", 134,1777,3194},
 {"Khu luyện công", "Tàn Tích Dạ Lang", 135,1603,3687},
 {"Khu luyện công", "Cổ Lãng Dữ", 136,1588,3169},
 {"Khu luyện công", "Đào Hoa Nguyên", 137,1848,3261},
 {"Khu luyện công", "Mạc Bắc Thảo Nguyên", 122,1797,3757},
 {"Khu luyện công", "Đôn Hoàng Cổ Thành", 123,1928,3366},
 {"Khu luyện công", "Hoạt Tử Nhân Mộ", 124,1734,3326},
 {"Khu luyện công", "Đại Vũ Đài", 125,1750,3855},
 {"Khu luyện công", "Tam Hiệp Sạn Đạo", 126,1523,3592},
 {"Khu luyện công", "Xi Vưu Động", 127,1605,3227},
 {"Khu luyện công", "Tỏa Vân Uyên", 128,1935,3406},
 {"Khu luyện công", "Phục Lưu Động", 129,1897,3586},
 {"Khu luyện công", "Sắc Lặc Xuyên", 114,1669,3788},
 {"Khu luyện công", "Gia Dụ Quan", 115,1440,3121},
 {"Khu luyện công", "Hoa Sơn", 116,1658,3425},
 {"Khu luyện công", "Thục Cương Bí Cảnh", 117,1548,3327},
 {"Khu luyện công", "Phong Đô Quỷ Thành", 118,1554,3615},
 {"Khu luyện công", "Miêu Lĩnh", 119,1833,3727},
 {"Khu luyện công", "Vũ Di Sơn", 120,1744,3830},
 {"Khu luyện công", "Vũ Lăng Sơn", 121,1548,3327},
 {"Khu luyện công", "Phường Đúc Kiếm", 44,1556,3509},
 {"Khu luyện công", "Trấn Đông Mộ Viên", 38,1569,3529},
 {"Khu luyện công", "Nhạc Dương Lâu", 45,1615,3823},
 {"Khu luyện công", "Tây Rừng Nguyên Sinh", 74,1882,3234},
 {"Khu luyện công", "Đông Rừng Nguyên Sinh", 64,1882,3234},
 {"Khu luyện công", "Dược Vương Động", 93,1913,3717},
 {"Khu luyện công", "Giữa Yến Tử Ổ", 70,1612,2699},
 {"Khu luyện công", "Ngoài Yến Tử Ổ", 60,1612,2699},
 {"Khu luyện công", "Nhạn Đãng Long Thu", 36,1613,3938},
 {"Khu luyện công", "Hưởng Thủy Động", 97,1720,3793},
 {"Khu luyện công", "Hoàng Lăng Tây Hạ", 108,1670,3214},
 {"Khu luyện công", "Đồng Quan", 40,1816,3883},
 {"Khu luyện công", "Thiên Trụ Phong", 49,1618,3927},
 {"Khu luyện công", "Cấm Địa Thiên Nhẫn", 47,1661,3679},
 {"Khu luyện công", "Thiên Long Tự", 112,1913,3537},
 {"Khu luyện công", "Thái Hành Cổ Kính", 86,1951,3913},
 {"Khu luyện công", "Tây Tháp Lâm", 66,1995,3287},
 {"Khu luyện công", "Đông Tháp Lâm", 56,1995,3287},
 {"Khu luyện công", "Thục Nam Trúc Hải", 42,2028,3430},
 {"Khu luyện công", "Thục Cương Sơn", 103,1802,3907},
 {"Khu luyện công", "Mê Cung Sa Mạc", 101,1624,3877},
 {"Khu luyện công", "Thanh Loa Đảo", 55,1926,3760},
 {"Khu luyện công", "Kỳ Liên Sơn", 39,2035,3252},
 {"Khu luyện công", "Bành Lãi Cổ Trạch", 99,1626,2433},
 {"Khu luyện công", "Bộ Lạc Nam Di", 54,1824,3201},
 {"Khu luyện công", "Mai Hoa Lĩnh", 33,1988,4048},
 {"Khu luyện công", "Tây Bắc Lư Vĩ Đãng", 75,1974,3724},
 {"Khu luyện công", "Đông Nam Lư Vĩ Đãng", 65,1974,3724},
 {"Khu luyện công", "Long Môn Thạch Quật", 107,1968,3824},
 {"Khu luyện công", "Quán Trọ Long Môn", 31,2034,3550},
 {"Khu luyện công", "Tây Long Hổ Huyễn Cảnh", 69,1588,3170},
 {"Khu luyện công", "Đông Long Hổ Huyễn Cảnh", 59,1588,3170},
 {"Khu luyện công", "Quân Mã Trường", 32,1611,3966},
 {"Khu luyện công", "Cư Diên Trạch", 94,1786,3958},
 {"Khu luyện công", "Cửu Nghi Khê", 106,1929,3324},
 {"Khu luyện công", "Cửu Lão Phong", 51,1776,3133},
 {"Khu luyện công", "Cửu Lão Động 1", 61,1638,3828},
 {"Khu luyện công", "Cửu Lão Động 2", 71,1638,3828},
 {"Khu luyện công", "Hoàng Lăng Kim Quốc 1", 57,1678,3237},
 {"Khu luyện công", "Hoàng Lăng Kim Quốc 2", 67,1678,3237},
 {"Khu luyện công", "Tiến Cúc Động", 110,1382,3279},
 {"Khu luyện công", "Kiếm Môn Quan", 111,1611,3269},
 {"Khu luyện công", "Kiếm Các Thục Đạo", 104,1546,3717},
 {"Khu luyện công", "Kiến Tính Phong", 48,1875,3725},
 {"Khu luyện công", "Kê Quán Động", 102,1599,3208},
 {"Khu luyện công", "Hoàng Hạc Lâu", 109,1929,3545},
 {"Khu luyện công", "Cán Hoa Khê", 90,1963,3559},
 {"Khu luyện công", "Hoài Thủy Sa Châu", 41,1973,3377},
 {"Khu luyện công", "Hổ Khâu Kiếm Trì", 96,1798,3971},
 {"Khu luyện công", "Tây Bờ Hồ Trúc Lâm", 73,1775,3241},
 {"Khu luyện công", "Đông Bờ Hồ Trúc Lâm", 63,1775,3241},
 {"Khu luyện công", "Cấm Địa Hậu Sơn", 46,2006,3306},
 {"Khu luyện công", "Hán Thủy Cổ Độ", 88,1901,3335},
 {"Khu luyện công", "Hàn Sơn Cổ Sát", 89,1528,3386},
 {"Khu luyện công", "Chiến Trường Cổ", 30,1623,4041},
 {"Khu luyện công", "Cô Tô Thủy Tạ", 50,1833,3140},
 {"Khu luyện công", "Phục Ngưu Sơn", 95,1603,3275},
 {"Khu luyện công", "Phong Lăng Độ", 100,1974,3264},
 {"Khu luyện công", "Hồ Phỉ Thúy", 53,1861,3207},
 {"Khu luyện công", "Nhĩ Hải Ma Nham", 91,1975,3437},
 {"Khu luyện công", "Hoàng Lăng Đoàn Thị", 105,1397,3544},
 {"Khu luyện công", "Bờ Hồ Động Đình", 37,1788,3255},
 {"Khu luyện công", "Điểm Thương Sơn", 98,1926,3801},
 {"Khu luyện công", "Đại Tán Quan", 87,1596,3382},
 {"Khu luyện công", "Trường Giang Hà Cốc", 34,1689,3407},
 {"Khu luyện công", "Trà Mã Cổ Đạo", 43,1958,3830},
 {"Khu luyện công", "Thái Thạch Cơ", 92,2069,3447},
 {"Khu luyện công", "Mê Cung Băng Huyệt 1", 58,1633,3368},
 {"Khu luyện công", "Mê Cung Băng Huyệt 2", 68,1633,3368},
 {"Khu luyện công", "Bang Nguyên Bí Động", 113,1893,3383},
 {"Khu luyện công", "Ngoài Bách Hoa Trận", 62,2378,3768},
 {"Khu luyện công", "Trong Bách Hoa Trận", 72,2378,3768},
 {"Khu luyện công", "Bách Hoa Cốc", 52,1957,3738},
 {"Khu luyện công", "Thị trấn Bạch Tộc", 35,2024,3979},
 {"Tân Thủ Thôn", "Vân Trung Trấn", 1,1389,3102},
 {"Tân Thủ Thôn", "Vĩnh Lạc Trấn", 3,1693,3288},
 {"Tân Thủ Thôn", "Thạch Cổ Trấn", 6,1572,3106 },
 {"Tân Thủ Thôn", "Long Tuyền Thôn", 7,1510,3268},
 {"Tân Thủ Thôn", "Long Môn Trấn", 2,1785,3586},
 {"Tân Thủ Thôn", "Giang Tân Thôn", 5,1597,3131},
 {"Tân Thủ Thôn", "Đạo Hương Thôn", 4,1624,3253},
 {"Tân Thủ Thôn", "Ba Lăng Huyện", 8,1721,3381},
 {"Phái", "Tây Hạ Nhất Phẩm Đường", 13,1679,3292},
 {"Phái", "Võ Đang Phái", 14,1435,2991},
 {"Phái", "Ngũ Độc Giáo", 20,1574,3145},
 {"Phái", "Thiên Vương Bang", 22,1663,3039},
 {"Phái", "Thiên Nhẫn Giáo", 10,1658,3324},
 {"Phái", "Đường Môn", 18,1633,3179},
 {"Phái", "Thiếu Lâm Phái", 9,1702,3093},
 {"Phái", "Tát Mãn Giáo", 11,1645,3196},
 {"Phái", "Côn Lôn Phái", 12,1700,3080},
 {"Phái", "Cái Bang", 15,1606,3245},
 {"Phái", "Nga My Phái", 16,1584,3041},
 {"Phái", "Đại Lý Đoàn Thị", 19,1618,3120},
 {"Phái", "Thúy Yên Môn", 17,1487,3093},
 {"Phái", "Trường Ca Môn", 21,1631,3404},
 {"Phái", "Minh Giáo", 224,1625,3181},
 {"Lôi Đài", "Lôi Đài Võ Lâm (Dương Châu)", 170,1646,3177},
 {"Lôi Đài", "Lôi Đài Võ Lâm (Tương Dương)", 169,1646,3177},
 {"Lôi Đài", "Lôi Đài Võ Lâm (Lâm An)", 173,1646,3177},
 {"Lôi Đài", "Lôi Đài Võ Lâm (Phượng Tường)", 168,1646,3177},
 {"Lôi Đài", "Lôi Đài Võ Lâm (Đại Lý)", 172,1646,3177},
 {"Lôi Đài", "Lôi Đài Võ Lâm (Thành Đô)", 171,1646,3177},
 {"Lôi Đài", "Lôi Đài Võ Lâm (Biện Kinh)", 167,1646,3177},
 {"Lôi Đài", "Thiết Sách Sạn Kiều (Dương Châu)", 177,1608,3216},
 {"Lôi Đài", "Thiết Sách Sạn Kiều (Tương Dương)", 176,1608,3216},
 {"Lôi Đài", "Thiết Sách Sạn Kiều (Lâm An)", 180,1608,3216},
 {"Lôi Đài", "Thiết Sách Sạn Kiều (Phượng Tường)", 175,1608,3216},
 {"Lôi Đài", "Thiết Sách Sạn Kiều (Đại Lý)", 179,1608,3216},
 {"Lôi Đài", "Thiết Sách Sạn Kiều (Thành Đô)", 178,1608,3216},
 {"Lôi Đài", "Thiết Sách Sạn Kiều (Biện Kinh)", 174,1608,3216},
 {"Thành", "Dương Châu Phủ", 26,1641,3129},
 {"Thành", "Tương Dương Phủ", 25,1630,3169},
 {"Thành", "Lâm An Phủ", 29,1605,3946},
 {"Thành", "Phượng Tường Phủ", 24,1767,3540},
 {"Thành", "Đại Lý Phủ", 28,1439,3366},
 {"Thành", "Thành Đô Phủ", 27,1666,3260},
 {"Thành", "Biện Kinh Phủ", 23,1486,3179},
};

tb.tbItems	= {
	"Đạo cụ nhiệm vụ",
	{
		{
			"Chữ cái b",
			{	
				{"Trứng Bạch Xà",				79},
				{"Bách Nghiệm Linh Dược",			355},
				{"Ban Ban",				316},
				{"Bản đồ Bang Nguyên Bí Động",		389},
				{"Lương thực Bang Nguyên Bí Động",		395},
				{"Vũ khí Bang Nguyên Bí Động",		394},
				{"Chìa khóa bảo rương",			126},
				{"Chìa khóa bảo rương",			148},
				{"Chìa khóa bảo rương",			393},
				{"Cờ phía bắc",			76},
				{"Ngọc Thoa bị cướp",			94},
				{"Cống phẩm bị cướp",			329},
				{"Lương thảo bị cướp",			48},
				{"Châu báu bị cướp",			49},
				{"Tị Cổ Thảo",				370},
				{"Biện Kinh Trắc Thiên Đài",			381},
				{"Bốc Toán Tử",				361},
				{"Pháo hoa của Bất Động Tiên Sinh",		406},
				{"Bố Giả Thương",			7},
			}
		},
		{
			"Chữ cái c",
			{
				{"Mảnh Tàng Bảo Đồ",			1158},
				{"Mảnh Tàng Bảo Đồ 2",			159},
				{"Mảnh Tàng Bảo Đồ 3",			160},
				{"Mảnh Tàng Bảo Đồ 4",			161},
				{"Thảo Liệu",				123},
				{"Siêu Độ Vong Hồn Kinh",			141},
				{"Túi bạc nặng trĩu",		22},
				{"Rượu lâu năm",			187},
				{"Rượu Trúc Diệp Thanh",			70},
				{"Xuất Cung Ký Lục",			310},
				{"Xuân Tuyệt Tâm Pháp",			63},
				{"Thư Hùng Song Kiếm",			103},
				{"Người giấy gấp vội vàng",		352},
				{"Bánh điểm tâm giòn",			311},
			}
		},
		{
			"Chữ cái d",
			{
				{"Thư của Đại Giới thiền sư",		124},
				{"Đại Lý Trắc Thiên Đài",			382},
				{"Đại Nội Tín Phù",			87},
				{"Đại Thanh Đâu ",				33},
				{"Y phục đạo sĩ",			400},
				{"Thư Đăng Sát Khẩu mới đến",	165},
				{"Bản Đồ Trích Thủy Động",			150},
				{"Tập bản đồ",			12},
				{"Chìa khóa địa huyệt",			2},
				{"Thủ lệnh Điệp Phiêu Phiêu",		168},
				{"Cờ phía đông",			73},
				{"Tập chú thơ Đông Pha",			186},
				{"Động Thiên Ngọc Giãn",			375},
				{"Độc hỏa thảo",				135},
				{"Độc Dược",				115},
				{"Nguồn gốc Độc Y",			55},
			}
		},
		{
			"Chữ cái e - f",
			{
				{"Nga Hoàng Ca",			23},
				{"Nga My Lục",		54},
				{"Cột của Đội 2",			338},
				{"Chìa khóa miếu hoang",			39},
				{"Phong Tín Tử",				18},
				{"Phượng Tường Trắc Thiên Đài",			384},
				{"Mảnh Phượng Nhãn Châu",			147},
				{"Phù bút",				349},
				{"Nước bùa",				114},
				{"Phù chỉ",				350},
				{"Phúc Long Thảo",				366},
				{"Da rắn hổ",				179},
			}
		},
		{
			"Chữ cái g",
			{
				{"Ngọc bội của Cốc Nam",			108},
				{"Mệnh lệnh của Cách Tây",			336},
				{"Mật hàm cho Hắc Hổ",		397},
				{"Thư gửi Cầu Chỉ Thủy",		136},
				{"Thư gửi Thạch Hiên Viên",		137},
				{"Thư của Tiểu Hiển",			120},
				{"Mật tín cấu kết",			356},
				{"Cổ Kiếm Trường Thanh",			29},
				{"Cổ Kiếm Vô Ngấn",			175},
				{"Đàn cổ",				399},
				{"Cổ Thư Thiện Bản",			358},
				{"Cổ Nữ Thủ Thư",			371},
				{"Thư Ải 1 mới đến",		162},
				{"Thư Ải 2 mới đến",		163},
				{"Thư Ải 3 mới đến",		164},
				{"Giỏ trái cây",				132},
			}
		},
		{
			"Chữ cái h",
			{
				{"Hàn Phủ Kim Yêu Bài",			98},
				{"Mật hàm của Hàn Trung Thuyết",		322},
				{"Hãn Huyết Bảo Mã",			205},
				{"Cỏ cực độc",		354},
				{"Hoa hợp hoan",				192},
				{"Hắc Cẩu Huyết",				95},
				{"Thư tiến cử của Hắc Hổ",	398},
				{"Hắc Long Triền",				185},
				{"Hắc Y Nhân",				203},
				{"Hoa Hồng Miên",				72},
				{"Hầu Nhi Tửu",				9},
				{"Thịt khỉ",				409},
				{"Hồ điệp thảo",				143},
				{"Da hổ",				197},
				{"Thịt hổ",				411},
				{"Hoàng Bảng",				97},
				{"Bản đồ Hoàng Hạc Lâu",		130},
				{"Xương Sói Vàng",				151},
				{"Chìa khóa Hoàng Đồng 3",			27},
				{"Chìa khóa Hoàng Đồng 1",			25},
				{"Chìa khóa Hoàng Đồng 2",			26},
				{"Hỏa Khí Phổ",				71},
				{"Hỏa Trang",				347},
			}
		},
		{
			"Chữ cái j",
			{
				{"Cơ quan khu nữu",			116},
				{"Thư tay cơ mật",			83},
				{"Cực Lạc Đơn",				402},
				{"Cực Lạc Hoàn",				342},
				{"Giá Y Thảo",				312},
				{"Kiếm Chủng Tín Phù",			301},
				{"Kiếm Chủng Ấn Tín",			306},
				{"Thủ cấp Khương Tam",			58},
				{"Sổ sách giao dịch",			391},
				{"Thuốc nối gân",			180},
				{"Cẩm nang tiếp dẫn đệ tử",		407},
				{"Sổ ghi chép của Tiếp Dẫn Sứ",		404},
				{"Thuốc giải độc",				318},
				{"Kim Cang Thiền Trượng (khai quang)",	36},
				{"Kim Cang Thiền Trượng (chưa khai quang)",	35},
				{"Kim Cang Kinh",				140},
				{"Đầu giặc Kim",		153},
				{"Kim khoáng thạch",				90},
				{"Túi thêu tơ vàng",			189},
				{"Kim Trang",				344},
				{"Cửu Tiết Xương Bồ",			32},
				{"Chìa khóa hầm rượu",			335},
				{"Tình báo tuyệt mật",			332},
				{"Băng lư",			62},
				{"Quân Tịch Quyển",			309},
				{"Bùa chú phát hiện trong quân doanh",	396},
				{"Vật tư quân dụng",			96},
			}
		},
		{
			"Chữ cái k",
			{
				{"Túi lữ khách",			204},
				{"Giấy trắng",			379},
				{"Bình rỗng",				313},
				{"Thuốc giải của Khấu Nhuệ",			300},
				{"Cô Lâu Phi Sí Mã Kỳ",		93},
				{"Tượng Khổ Thần",			111},
				{"Chìa khóa khoáng Đồng Cơ Quan",		101},
			}
		},
		{
			"Chữ cái l",
			{
				{"Ống đựng thư",			134},
				{"Ấn giám Lan Tùng Lâm",		170},
				{"Bức thư của ông lão",			177},
				{"Thủ cấp Lý A Đại",		80},
				{"Mặt nạ Lý Thăng Dương",			365},
				{"Liên căn thảo",				178},
				{"Đầu Lương Hạng Lâm",		363},
				{"Lâm An Trắc Thiên Đài",			380},
				{"Linh Phong Cổ Kính",			319},
				{"Ngọn lửa linh hồn",			125},
				{"Linh chi",				37},
				{"Lục Súc Bất Ninh Tán (Lâm An)",	385},
				{"Lục Súc Bất Ninh Tán (Tương Dương)",	387},
				{"Lục Súc Bất Ninh Tán (Dương Châu)",	386},
				{"Long Châu",				146},
				{"Gia thư của Lư Tiếu Bần",		191},
				{"Hươu nhung",				196},
				{"Thịt hươu",				315},
				{"Túi đồ Lộ Hiểu Nhiên giao",	42},
				{"Thư Lộ Hiểu Nhiên giao",	41},
				{"Mật rắn hổ",			367},
				{"Hoa Lục Thiểm Nhi",			167},
				{"Lục Ngọc Như Ý",			305},
				{"Thư của La Phong",			78},
				{"La bàn",				199},
				{"La bàn 2",				209},
				{"La bàn 3",				210},
				{"La bàn 4",				211},
				{"Hài cốt của La Tiểu Hổ",		326},
				{"Hài cốt của La Tiểu Anh",		327},
			}
		},
		{
			"Chữ cái m",
			{
				{"Lệnh bài Mã Tặc",			173},
				{"Thức ăn mèo",				317},
				{"Bút lông",				10},
				{"Xương Hươu",				152},
				{"Thịt hươu",				410},
				{"Bí Pháp Huyết Chú",			91},
				{"Sách kế hoạch bí mật",			88},
				{"Quân lệnh bí mật",			122},
				{"Danh sách bí mật",			127},
				{"Tài liệu bị dán kín",			113},
				{"Mật Chiếu",				112},
				{"Tranh chữ của danh nhân",			359},
				{"Đầu biến dạng",		331},
				{"Thủ cấp của Mạc Kỳ Tiêu Thanh Phương",	119},
				{"Linh kiện mộc nhân",			40},
				{"Chìa khóa Mộc Nhân Trận",			303},
				{"Cột gỗ",				345},
				{"Trường Kiếm của Mộ Dung Thị",			52},
			}
		},
		{
			"Chữ cái n - r",
			{
				{"Cờ phía nam",			74},
				{"Trái tim Nữ Tế Tư",			84},
				{"Hài cốt nữ",			77},
				{"Tóc nữ vu",			24},
				{"Đầu Bì La Các",		86},
				{"Giấy da dê cũ rách (trên)",		105},
				{"Giấy da dê cũ rách (dưới)",		106},
				{"Thất Bảo Lưu Ly",			50},
				{"Thất Tinh Thương Phổ",			138},
				{"Thân Tử Bồn",				128},
				{"Thủ cấp Tần Tương Nhân",		61},
				{"Thanh Minh Bảo Kiếm",			44},
				{"Bộ Thanh Minh Kiếm",			45},
				{"Danh sách phạm nhân",			46},
				{"Chìa khóa phòng giam",			321},
				{"Thư của Cầu Chỉ Thủy",			4},
				{"Hồi môn của Như Ý",			190},
			}
		},
		{
			"Chữ cái s",
			{
				{"Sái Vân Thủ",				64},
				{"Cột của Đội 3",			339},
				{"Cầm phổ tán loạn",			403},
				{"Bản đồ Mê Cung Sa Mạc",		117},
				{"Sơn Dược",				31},
				{"Tiền thời nhà Thương",			51},
				{"Khăn tay thần bí",			109},
				{"Gia thư thần bí",			408},
				{"Thuốc giải của thần y",		369},
				{"Vật tìm được trên thi thể",	307},
				{"Hoa Thi Vu",				401},
				{"Bia đá",				19},
				{"Thạch tượng cơ quan",			174},
				{"Thế Lực Phân Bố Đồ",			374},
				{"Xá Lợi Tử của Phật Thích Ca Mâu Ni",	121},
				{"Thích Giả Đấu Lạp",			38},
				{"Trang sách",				66},
				{"Ấn Soái",				89},
				{"Thịt Song Thủ",			360},
				{"Thủy Trang",				346},
				{"Sợi tơ",				34},
				{"Cột của Đội 4",			340},
				{"Tứ Phương Điêu Tượng",			201},
				{"Tứ Phương Điêu Tượng 2",			212},
				{"Tứ Phương Điêu Tượng 3",			213},
				{"Tứ Phương Điêu Tượng 4",			214},
				{"Thủ cấp Tống Triều",			59},
				{"Tín Phù của Tùy Phong",			405},
			}
		},
		{
			"Chữ cái t",
			{
				{"Món quà của Đường Như",			67},
				{"Ngân phiếu của đào phạm",			176},
				{"Đào Thoát Hòa Thượng",			183},
				{"Bạc của Đào Hoa Kiếm Thuyết",		390},
				{"Thư của Thiên Mục Đạo Trưởng",		188},
				{"Mật lệnh Thiên Nhẫn",			184},
				{"Thiên Nhẫn Tiểu Kỳ",			1},
				{"Trang phục Thiên Vương Bang",			323},
				{"Thiên Vương Bang Yêu Bài",			171},
				{"Thư của Thiên vương Phân Đà",		133},
				{"Hài cốt của Thiên Trúc Tăng Nhân",		107},
				{"Chìa khóa rương sắt",			328},
				{"Đồng Kính",				353},
				{"Cơ quan Đồng Kính",			202},
				{"Cơ quan Đồng Kính 2",			215},
				{"Cơ quan Đồng Kính 3",			216},
				{"Cơ quan Đồng Kính 4",			217},
				{"Thổ Phục Linh",				30},
				{"Thổ Trang",				348},
			}
		},
		{
			"Chữ cái w",
			{
				{"Vong Linh Siêu Độ Phù",			110},
				{"Vong ưu thảo",				15},
				{"Thuốc giải Vong Ưu Đơn",			92},
				{"Thư liên lạc giả",		5},
				{"Thư không ký tên",			169},
				{"Ôn nhuận thảo",				181},
				{"Ô Kim Trường Kiếm",			47},
				{"Vô danh thảo",			320},
				{"Cờ Ngũ Độc Giáo",			14},
				{"Cột của Đội 5",			341},
				{"Ngũ Hành Thư",				413},
				{"Hài cốt võ lâm cao thủ",		155},
			}
		},
		{
			"Chữ cái x",
			{
				{"Cờ phía tây",			75},
				{"Dưa hấu",				8},
				{"Danh sách mật thám",			53},
				{"Diên Hương Hương Nang",			21},
				{"Nhang đèn",				82},
				{"Quả sồi",				182},
				{"Tiêu Thạch Tán",				324},
				{"Pháo hoa do Tiểu Man tặng",		333},
				{"Tiểu Thiệt Thảo",				157},
				{"Giấy viết đầy bùa chú",		351},
				{"Thủ cấp Tạ Phi",			60},
				{"Thư của Tạ Vũ Điền",		28},
				{"Tâm Ý Gian",			65},
				{"Tín Phù",				343},
				{"Bồ câu đưa thư",				330},
				{"Nhật ký Tín Sứ",			334},
				{"Tinh tinh thảo",				17},
				{"Hùng đảm thảo",				3},
				{"Thịt gấu",				412},
				{"Tay gấu",				198},
				{"Giấy Tuyên",				11},
				{"Huyền Thưởng Cáo Thị",			373},
				{"Lỗ tai dính đầy máu",		357},
			}
		},
		{
			"Chữ cái y",
			{
				{"Pháo hoa",				145},
				{"Pháo hoa 2_Ngoại Chủng",			206},
				{"Pháo hoa 3_Ngoại Chủng",			207},
				{"Pháo hoa 4_Ngoại Chủng",			208},
				{"Nhãn kính xà dược",			172},
				{"Di thư của Yến Tiểu Lục",		131},
				{"Bản Đồ Yến Tử Ổ",			149},
				{"Dương Châu Trắc Thiên Đài",			383},
				{"Dương Phù",				69},
				{"Thủ cấp Nam Tử Dao Sơn",		20},
				{"Thủ cấp Diệp Long Diên",		56},
				{"Ly dạ quang",				364},
				{"Dạ Minh Châu",				102},
				{"Cột của Đội 1",			337},
				{"Một bức thư",			85},
				{"Một vạn lượng bạc",			142},
				{"Một tờ giấy (99)",	104},
				{"Âm Phù",				68},
				{"Ngân Thiềm Yêu Bài",			154},
				{"Ngân phiếu",				129},
				{"Ảnh Giả Ám Ký",			13},
				{"Du Long Giác",				200},
				{"Du Long Giác",				325},
				{"Mật hàm Ngu Tẩu",			302},
				{"Quả du",				6},
				{"Ngọc Phật",				376},
				{"Ngọc Giản Dịch Văn",			378},
				{"Ngọc Tủy Phi Phượng",			392},
				{"Gối của Dụ Bà Bà",		81},
				{"Ngự Tứ Chiết Phiến",			308},
				{"Ngự Dụng Khí Cụ",			372},
			}
		},
		{
			"Chữ cái z",
			{
				{"Tặc Huyệt Tàng Trân",			304},
				{"Đầu Trương Sinh",			362},
				{"Râu Chân Nhân",			43},
				{"Giấy và bút",				388},
				{"Thủ cấp Chu Quang Chiếu",		57},
				{"Chu Hồng Đơn",				166},
				{"Chu hồng quả",				156},
				{"Thư do Chu Hy viết",		100},
				{"Bình đựng đầy Linh Tuyền",		314},
				{"Bình đựng bột kì lạ",	368},
				{"Bắt được Túy Hán",			144},
				{"Tử La Lan",				16},
				{"Tử Tinh Mẫu Đơn",			139},
				{"Tử Ngọc Băng Xà",			118},
				{"Tử Ngọc Khoáng Thạch",			99},
			}
		},
	}
};

local _tbSkillItems	= {
	{"Thủ",		{1,1,1,1,1,0,255,nil,0,0}},
	{"Kiếm",		{1,1,2,1,1,0,255,nil,0,0}},
	{"Đao",		{1,1,3,1,1,0,255,nil,0,0}},
	{"Côn",		{1,1,4,1,1,0,255,nil,0,0}},
	{"Thương",		{1,1,5,1,1,0,255,nil,0,0}},
	{"Chùy",		{1,1,6,1,1,0,255,nil,0,0}},
	{"Phi tiêu",	{1,2,1,1,1,0,255,nil,0,0}},  
	{"Phi đao",	{1,2,2,1,1,0,255,nil,0,0}},  
	{"Tụ tiễn",	{1,2,3,1,1,0,255,nil,0,0}},  
};

local _tbHorseItems	= {
	{
		{"Mã bài (Táo Hồng Mã)",		{1,12,1,1}},
		{"Mã bài (Thanh Mã)",		{1,12,2,1}},
		{"Mã bài (Đại Uyển Mã)",		{1,12,3,2}},
		{"Mã bài (Ô Truy)",		{1,12,4,2}},
		{"Mã bài (Ô Vân Đạp Tuyết)",	{1,12,5,3}},
		{"Mã bài (Đích Lô)",		{1,12,6,3}},
	},
	{
		{"Mã bài (Tuyệt Ảnh)",		{1,12,7,3}},
		{"Mã bài (Chiếu Dạ Ngọc Sư Tử)",	{1,12,8,3}},
		{"Mã bài (Hãn Huyết Bảo Mã)",	{1,12,9,3}},
		{"Mã bài (Xích Thố)",		{1,12,10,4}},
		{"Mã bài (Bôn Tiêu)",		{1,12,11,4}},
		{"Mã bài (Phiên Vũ)",		{1,12,12,4}},
	},
};

tb.tbMap	= {};
for _, tbPos in ipairs(_tbMap) do
	local tbMap	= tb.tbMap[tbPos[1]];
	if (not tbMap) then
		tbMap	= {};
		tb.tbMap[tbPos[1]]	= tbMap;
	end;
	tbMap[tbPos[2]]	= {unpack(tbPos, 2)};
end;

function tb:OnUse()
	if (it.nParticular == 3) then
		self:OnTransPak(self.tbMap);
	elseif (it.nParticular == 4) then
		self:OnSkillPak();
	elseif (it.nParticular == 12) then
		self:OnTaskItemPak(self.tbItems);
	end
	return 0;
end;

function tb:OnTransPak(tbPosTb, szFrom)
	if (type(tbPosTb[1]) == "string") then
		local nRet, szMsg = Map:CheckTagServerPlayerCount(tbPosTb[2])
		if nRet ~= 1 then
			me.Msg(szMsg);
			return 0;
		end
		me.Msg(string.format("Ngồi yên, đi %s！(%d,%d,%d)",unpack(tbPosTb)));
		me.NewWorld(unpack(tbPosTb,2));
		return;
	end;
	local tbOpt	= {};
	local nCount	= 9;
	for szName, tbPos in next, tbPosTb, szFrom do
		if (nCount <= 0) then
			tbOpt[#tbOpt]	= {"Sau", self.OnTransPak, self, tbPosTb, tbOpt[#tbOpt-1][1]};
			break;
		end;
		tbOpt[#tbOpt+1]	= {szName, self.OnTransPak, self, tbPos};
		nCount	= nCount - 1;
	end;
	tbOpt[#tbOpt+1]	= {"Kết Thúc đối thoại"};
	Dialog:Say("Muốn đi đâu thì đi!<pic=48>", tbOpt);
end;

function tb:OnSkillPak()
	Dialog:Say("Đã học kỹ năng, không có gì là không thể!<pic=20>", {
		{"Tăng đến cấp 100!", self.LevelUp, self},
		{"Nhận được vật phẩm trang bị", self.SelectItem, self},
		{"Ra khỏi môn phái & Tẩy điểm kỹ năng & Tẩy điểm tiềm năng", self.ClearCall, self},
		{"Gia nhập môn phái", "Npc.tbMenPaiNpc:FactionDialog", Npc.tbMenPaiNpc.DialogMaster},
		{"Học toàn bộ kỹ năng sống ", self.AddLifeSkill, self},
		(me.nFightState == 1 and {"Hủy trạng thái chiến đấu", me.SetFightState, 0}) or {"Vào trạng thái chiến đấu", me.SetFightState, 1},
		{"Nhận Ngựa", self.SelectHorse, self, 1},
		{"Nhận được 10 Cửu Chuyển Tục Mệnh Hoàn",self.AddItemJiuzhuan,self},
			{"Bỏ tất cả đạo cụ trong túi",me.ThrowAllItem},
		{"Kết thúc đối thoại"},
	});
end;

function tb:OnTaskItemPak(tbItems, nFrom)
	if (type(tbItems[2]) == "number") then
		Dialog:AskNumber(string.format("Bao nhiêu [%s]？", tbItems[1]), 1, 100, self._OnAskItem, self, me, tbItems);
		me.Msg("Nếu như lúc này trên Client của bạn không thể hiện thị bàn phím ảo, xin nhấp phím Enter, mặc định nhận được 1 ");
		return;
	end;
	local tbOpt	= {};
	local nCount	= 9;
	for nIndex = nFrom or 1, #tbItems[2] do
		if (nCount <= 0) then
			tbOpt[#tbOpt]	= {"Sau", self.OnTaskItemPak, self, tbItems, nIndex};
			break;
		end;
		tbOpt[#tbOpt+1]	= {tbItems[2][nIndex][1], self.OnTaskItemPak, self, tbItems[2][nIndex]};
		nCount	= nCount - 1;
	end;
	tbOpt[#tbOpt+1]	= {"Kết thúc đối thoại"};
	Dialog:Say("Nhiệm vụ liên tục. Tình yêu đằm thắm.<pic=11>\nXin chọn vật nhẩm bạn muốn nhận", tbOpt);
end;

function tb:LevelUp()
	ST_LevelUp(100-me.nLevel);
	Timer:Register(18, self._OnTimer, self);
end;

function tb:SelectItem()
	local tbOpt	= {};
	for _, tbItem in pairs(_tbSkillItems) do
		tbOpt[#tbOpt+1]	= {tbItem[1], Item.AddPlayerItem, me, unpack(tbItem[2])};
	end;
	tbOpt[#tbOpt+1]	= {"Kết thúc đối thoại"};
	Dialog:Say("Bạn cần loại vũ khí nào <pic=44>", tbOpt);
end;

function tb:SelectHorse(nPageIdx)
	local tbOpt	= {};
	for _, tbItem in pairs(_tbHorseItems[nPageIdx]) do
		tbItem[2][8]	= 0;
		tbOpt[#tbOpt+1]	= {tbItem[1], Item.AddPlayerItem, me, unpack(tbItem[2])};
	end;
	if (nPageIdx == 1) then
		tbOpt[#tbOpt+1]	= {"Trang kế>>", self.SelectHorse, self, 2};
	else
		tbOpt[#tbOpt+1]	= {"<<Trang trước", self.SelectHorse, self, 1};
	end
	tbOpt[#tbOpt+1]	= {"Kết thúc đối thoại"};
	Dialog:Say("Bạn cần Mã bài nào<pic=44>", tbOpt);
end;

function tb:SelectHorse(nPageIdx)
	local tbOpt	= {};
	for _, tbItem in pairs(_tbHorseItems[nPageIdx]) do
		tbOpt[#tbOpt+1]	= {tbItem[1], Item.AddPlayerItem, me, unpack(tbItem[2])};
	end;
	if (nPageIdx == 1) then
		tbOpt[#tbOpt+1]	= {"Trang kế>>", self.SelectHorse, self, 2};
	else
		tbOpt[#tbOpt+1]	= {"<<Trang trước", self.SelectHorse, self, 1};
	end
	tbOpt[#tbOpt+1]	= {"Kết thúc đối thoại"};
	Dialog:Say("Bạn cần Mã bài nào<pic=44>", tbOpt);
end;

function tb:ClearCall()
	me.ResetFightSkillPoint();
	me.JoinFaction(0);
	me.SetTask(2,1,1);
	me.UnAssignPotential();
	me.Msg("Đã biến thành thịt gà!");
end;

function tb:AddLifeSkill()
	for i = 1, 10 do
		LifeSkill:AddLifeSkill(me, i, 1)
	end;
	for i=1,23 do
		LifeSkill:AddSkillExp(me, i, 3000000);
	end
	me.Msg("Không có gì là không thể!");
end;

function tb:_OnTimer()
	me.RestoreMana();
	me.RestoreLife();
	me.RestoreStamina();
	return 0;
end;

function tb:_OnAskItem(pPlayer, tbItem, nCount)
	pPlayer.Msg(string.format("Nhận được, %s x %d！(20,1,%d,1)", tbItem[1], nCount, tbItem[2]));
	for i = 1, nCount do
		pPlayer.AddQuest(1, tbItem[2], 1);
	end;
end;

function tb:AddItemJiuzhuan()
	for i = 1, 10 do
		Item.AddPlayerItem(me,18,1,24,1);
	end;
end;

function Item.AddPlayerItem(pPlayer, nGenre, nDetail, nParticular, nLevel, nSeries, nEnhTimes, nLucky, nVersion, uRandSeed)

	return	KItem.AddPlayerItem(
		pPlayer,
		nGenre,
		nDetail,
		nParticular,
		nLevel,
		nSeries or Env.SERIES_NONE,
		nEnhTimes or 0,
		nLucky or 0,
		nil,nil,
		nVersion or 0,
		uRandSeed or 0
	);

end
