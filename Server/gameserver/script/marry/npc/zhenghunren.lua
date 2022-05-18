-- 文件名　：zhenghunren.lua
-- 创建者　：furuilei
-- 创建时间：2009-12-30 17:31:20
-- 功能描述：典礼npc（证婚人）

local tbNpc = Npc:GetClass("marry_zhenghunren");

--====================================================

tbNpc.OP_MSG_CHAT		= 1;	-- 发送对话信息
tbNpc.OP_MSG_FILM		= 2;	-- 电影字幕
tbNpc.OP_MSG_HEITIAO	= 3;	-- 黑条信息
tbNpc.OP_MSG_CHANNEL	= 4;	-- 聊天栏信息
tbNpc.OP_MSG_INFOBOARD	= 5;	-- 中央黄色字信息
tbNpc.OP_SKILL			= 6;	-- 释放技能

-- 证婚人的对话以及操作。1,2,3,4分别代表平民到皇家4个档次的证婚人
tbNpc.tbOpt = {
	[1] = {
		[1] = {nOpt = tbNpc.OP_MSG_HEITIAO, tbInfo = {szMsg = "Thủ lĩnh nghĩa quân Bạch Thu Lâm lên lễ đài bắt đầu buổi Điển Lễ.", nStayTime = 2}},	
		[2] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[3] = {nOpt = tbNpc.OP_MSG_CHANNEL, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[4] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Ngọn lửa hạnh phúc đã được thắp sáng, các vị khách tham dự buổi lễ sẽ nhận được phần thưởng kinh nghiệm lớn.", nStayTime = 8}},			
		[5] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[6] = {nOpt = tbNpc.OP_MSG_CHANNEL, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[7] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Ngọn lửa hạnh phúc đã được thắp sáng, các vị khách tham dự buổi lễ sẽ nhận được phần thưởng kinh nghiệm lớn.", nStayTime = 8}},		
		[8] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[9] = {nOpt = tbNpc.OP_MSG_CHANNEL, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[10] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Ngọn lửa hạnh phúc đã được thắp sáng, các vị khách tham dự buổi lễ sẽ nhận được phần thưởng kinh nghiệm lớn.", nStayTime = 8}},			
		[11] = {nOpt = tbNpc.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6656>：“Thưa chu vị hương thân phụ lão, huynh đệ tỷ muội trong nghĩa quân.”<end><npc=6656>：“Nhờ tình yêu, đã gắn kết hai bạn trẻ của chúng ta.”<end><npc=6656>：“Trong lòng ta vô cùng xúc động.”<end><npc=6656>：“Hai người họ đều là nam thanh, nữ tú trong số các huynh đệ, tỷ muội của nghĩa quân chúng ta.”<end><npc=6656>：“Chàng trai với một tướng mạo đường đường như Cây Ngọc Bích.”<end><npc=6656>：“Cô gái với vẻ đẹp Bế Nguyệt Tu Hoa, Khuynh Quốc Khuynh Thành”<end><npc=6656>：“Họ đến với nhau như lời gọi của trời và đất”<end><npc=6656>：“Liệt tổ liệt tông ở trên, ta Bạch Thu Lâm ở đây làm chứng cho hôn lễ của 2 ngươi.”<end>", nStayTime = 1}},
		[12] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Thưa chu vị hương thân phụ lão, huynh đệ tỷ muội trong nghĩa quân.", nStayTime = 4}},
		[13] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Nhờ tình yêu, đã gắn kết hai bạn trẻ của chúng ta.", nStayTime = 4}},
		[14] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Trong lòng ta vô cùng xúc động.", nStayTime = 4}},
		[15] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Hai người họ đều là nam thanh, nữ tú trong số các huynh đệ, tỷ muội của nghĩa quân chúng ta.", nStayTime = 4}},
		[16] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Chàng trai với một tướng mạo đường đường như Cây Ngọc Bích", nStayTime = 4}},
		[17] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Cô gái với vẻ đẹp Bế Nguyệt Tu Hoa, Khuynh Quốc Khuynh Thành", nStayTime = 4}},
		[18] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Họ đến với nhau như lời gọi của trời và đất.", nStayTime = 4}},		
		[19] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Liệt tổ liệt tông ở trên, ta Bạch Thu Lâm ở đây làm chứng cho hôn lễ của 2 con.", nStayTime = 4}},
		[20] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Phía dưới nghe ta chỉ thị...", nStayTime = 3}},
		[21] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Nhất bái thiên địa !", nStayTime = 1}},
		[22] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1560, tbSkillPos = {1762, 3150} , nStayTime = 2}},
		[23] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1559, tbSkillPos = {1762, 3150} , nStayTime = 3}},	
		[24] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc 2 bạn trẻ đại phú đại quý !", nStayTime = 1}},	
		[25] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1762, 3150} , nStayTime = 5}},		
		[26] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Nhị bái cao đường !", nStayTime = 1}},
		[27] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1557, tbSkillPos = {1762, 3150} , nStayTime = 2}},
		[28] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1559, tbSkillPos = {1762, 3150} ,  nStayTime = 3}},	
		[29] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc 2 bạn trăm năm hạnh phúc !", nStayTime = 1}},
		[30] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1762, 3150} , nStayTime = 5}},	
		[31] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Phu thê giao bái !", nStayTime = 1}},
		[32] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1556, tbSkillPos = {1762, 3150} ,  nStayTime = 2}},
		[33] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1559, tbSkillPos = {1762, 3150} ,  nStayTime = 3}},		
		[34] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc 2 bạn trẻ vĩnh kết đồng tâm !", nStayTime = 1}},
		[35] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1762, 3150} , nStayTime = 5}},	
		[36] = {nOpt = tbNpc.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6656>：“Ta tuyên bố: 2 con chính thức thành vợ thành chồng của nhau.”<end><npc=6656>：“Từ nay về sau hai ngươi phải tôn trọng, giúp đỡ nhau.”<end><npc=6656>：“Chúc 2 ngươi yêu thương nhau đến Bạc Đầu”<end>", nStayTime = 1}},
		[37] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Ta tuyên bố: 2 con chính thức thành vợ thành chồng của nhau.", nStayTime = 4}},
		[38] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Từ nay về sau hai ngươi phải tôn trọng, giúp đỡ nhau.", nStayTime = 4}},
		[39] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc 2 ngươi yêu thương nhau đến Bạc Đầu", nStayTime = 4}},
		[40] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1561,  tbSkillPos = {1762, 3150} , nStayTime = 2}},		
		[41] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1558,  tbSkillPos = {1762, 3150} , nStayTime = 3}},	
		},
	[2] = {
		[1] = {nOpt = tbNpc.OP_MSG_HEITIAO, tbInfo = {szMsg = "Thủ lĩnh nghĩa quân Bạch Thu Lâm lên lễ đài bắt đầu buổi Điển Lễ.", nStayTime = 2}},	
		[2] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[3] = {nOpt = tbNpc.OP_MSG_CHANNEL, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[4] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Ngọn lửa hạnh phúc đã được thắp sáng, các vị khách tham dự buổi lễ sẽ nhận được phần thưởng kinh nghiệm lớn.", nStayTime = 8}},			
		[5] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[6] = {nOpt = tbNpc.OP_MSG_CHANNEL, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[7] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Ngọn lửa hạnh phúc đã được thắp sáng, các vị khách tham dự buổi lễ sẽ nhận được phần thưởng kinh nghiệm lớn.", nStayTime = 8}},		
		[8] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[9] = {nOpt = tbNpc.OP_MSG_CHANNEL, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[10] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Ngọn lửa hạnh phúc đã được thắp sáng, các vị khách tham dự buổi lễ sẽ nhận được phần thưởng kinh nghiệm lớn.", nStayTime = 8}},			
		[11] = {nOpt = tbNpc.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6656>：“Thưa chu vị hương thân phụ lão, huynh đệ tỷ muội trong nghĩa quân.”<end><npc=6656>：“Nhờ tình yêu, đã gắn kết hai bạn trẻ của chúng ta.”<end><npc=6656>：“Trong lòng ta vô cùng xúc động.”<end><npc=6656>：“Hai người họ đều là nam thanh, nữ tú trong số các huynh đệ, tỷ muội của nghĩa quân chúng ta.”<end><npc=6656>：“Chàng trai với một tướng mạo đường đường như Cây Ngọc Bích.”<end><npc=6656>：“Cô gái với vẻ đẹp Bế Nguyệt Tu Hoa, Khuynh Quốc Khuynh Thành”<end><npc=6656>：“Họ đến với nhau như lời gọi của trời và đất”<end><npc=6656>：“Liệt tổ liệt tông ở trên, ta Bạch Thu Lâm ở đây làm chứng cho hôn lễ của 2 ngươi.”<end>", nStayTime = 1}},
		[12] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Thưa chu vị hương thân phụ lão, huynh đệ tỷ muội trong nghĩa quân.", nStayTime = 4}},
		[13] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Nhờ tình yêu, đã gắn kết hai bạn trẻ của chúng ta.", nStayTime = 4}},
		[14] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Trong lòng ta vô cùng xúc động.", nStayTime = 4}},
		[15] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Hai người họ đều là nam thanh, nữ tú trong số các huynh đệ, tỷ muội của nghĩa quân chúng ta.", nStayTime = 4}},
		[16] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Chàng trai với một tướng mạo đường đường như Cây Ngọc Bích", nStayTime = 4}},
		[17] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Cô gái với vẻ đẹp Bế Nguyệt Tu Hoa, Khuynh Quốc Khuynh Thành", nStayTime = 4}},
		[18] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Họ đến với nhau như lời gọi của trời và đất.", nStayTime = 4}},		
		[19] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Liệt tổ liệt tông ở trên, ta Bạch Thu Lâm ở đây làm chứng cho hôn lễ của 2 con.", nStayTime = 4}},
		[20] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Phía dưới nghe ta chỉ thị...", nStayTime = 3}},
		[21] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Nhất bái thiên địa!", nStayTime = 1}},
		[22] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1560, tbSkillPos = {1603, 3170} , nStayTime = 2}},
		[23] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1559, tbSkillPos = {1603, 3170} , nStayTime = 3}},	
		[24] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc 2 bạn trẻ đại phú đại quý!", nStayTime = 1}},	
		[25] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1603, 3170} , nStayTime = 5}},		
		[26] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Nhị bái cao đường !", nStayTime = 1}},
		[27] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1557, tbSkillPos = {1603, 3170} , nStayTime = 2}},
		[28] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1559, tbSkillPos = {1603, 3170} ,  nStayTime = 3}},	
		[29] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc 2 bạn trăm năm hạnh phúc !", nStayTime = 1}},
		[30] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1603, 3170} , nStayTime = 5}},	
		[31] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Phu thê giao bái !", nStayTime = 1}},
		[32] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1556, tbSkillPos = {1603, 3170} ,  nStayTime = 2}},
		[33] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1559, tbSkillPos = {1603, 3170} ,  nStayTime = 3}},		
		[34] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc 2 bạn trẻ vĩnh kết đồng tâm !", nStayTime = 1}},
		[35] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1603, 3170} , nStayTime = 5}},	
		[36] = {nOpt = tbNpc.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6656>：“Ta tuyên bố: 2 con chính thức thành vợ thành chồng của nhau.”<end><npc=6656>：“Từ nay về sau hai ngươi phải tôn trọng, giúp đỡ nhau.”<end><npc=6656>：“Chúc 2 ngươi yêu thương nhau đến Bạc Đầu”<end>", nStayTime = 1}},
		[37] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Ta tuyên bố: 2 con chính thức thành vợ thành chồng của nhau.", nStayTime = 4}},
		[38] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Từ nay về sau hai ngươi phải tôn trọng, giúp đỡ nhau.", nStayTime = 4}},
		[39] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc 2 ngươi yêu thương nhau đến Bạc Đầu", nStayTime = 4}},
		[40] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1561,  tbSkillPos = {1603, 3170} , nStayTime = 2}},		
		[41] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1558,  tbSkillPos = {1603, 3170} , nStayTime = 3}},	
		},
	[3] = {
		[1] = {nOpt = tbNpc.OP_MSG_HEITIAO, tbInfo = {szMsg = "Thủ lĩnh nghĩa quân Bạch Thu Lâm lên lễ đài bắt đầu buổi Điển Lễ.", nStayTime = 2}},	
		[2] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[3] = {nOpt = tbNpc.OP_MSG_CHANNEL, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[4] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Ngọn lửa hạnh phúc đã được thắp sáng, các vị khách tham dự buổi lễ sẽ nhận được phần thưởng kinh nghiệm lớn.", nStayTime = 8}},			
		[5] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[6] = {nOpt = tbNpc.OP_MSG_CHANNEL, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[7] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Ngọn lửa hạnh phúc đã được thắp sáng, các vị khách tham dự buổi lễ sẽ nhận được phần thưởng kinh nghiệm lớn.", nStayTime = 8}},		
		[8] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[9] = {nOpt = tbNpc.OP_MSG_CHANNEL, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[10] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Ngọn lửa hạnh phúc đã được thắp sáng, các vị khách tham dự buổi lễ sẽ nhận được phần thưởng kinh nghiệm lớn.", nStayTime = 8}},			
		[11] = {nOpt = tbNpc.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6656>：“Thưa chu vị hương thân phụ lão, huynh đệ tỷ muội trong nghĩa quân.”<end><npc=6656>：“Nhờ tình yêu, đã gắn kết hai bạn trẻ của chúng ta.”<end><npc=6656>：“Trong lòng ta vô cùng xúc động.”<end><npc=6656>：“Hai người họ đều là nam thanh, nữ tú trong số các huynh đệ, tỷ muội của nghĩa quân chúng ta.”<end><npc=6656>：“Chàng trai với một tướng mạo đường đường như Cây Ngọc Bích.”<end><npc=6656>：“Cô gái với vẻ đẹp Bế Nguyệt Tu Hoa, Khuynh Quốc Khuynh Thành”<end><npc=6656>：“Họ đến với nhau như lời gọi của trời và đất”<end><npc=6656>：“Liệt tổ liệt tông ở trên, ta Bạch Thu Lâm ở đây làm chứng cho hôn lễ của 2 ngươi.”<end>", nStayTime = 1}},
		[12] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Thưa chu vị hương thân phụ lão, huynh đệ tỷ muội trong nghĩa quân.", nStayTime = 4}},
		[13] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Nhờ tình yêu, đã gắn kết hai bạn trẻ của chúng ta.", nStayTime = 4}},
		[14] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Trong lòng ta vô cùng xúc động.", nStayTime = 4}},
		[15] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Hai người họ đều là nam thanh, nữ tú trong số các huynh đệ, tỷ muội của nghĩa quân chúng ta.", nStayTime = 4}},
		[16] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Chàng trai với một tướng mạo đường đường như Cây Ngọc Bích", nStayTime = 4}},
		[17] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Cô gái với vẻ đẹp Bế Nguyệt Tu Hoa, Khuynh Quốc Khuynh Thành", nStayTime = 4}},
		[18] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Họ đến với nhau như lời gọi của trời và đất.", nStayTime = 4}},		
		[19] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Liệt tổ liệt tông ở trên, ta Bạch Thu Lâm ở đây làm chứng cho hôn lễ của 2 con.", nStayTime = 4}},
		[20] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Phía dưới nghe ta chỉ thị...", nStayTime = 3}},
		[21] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Nhất bái thiên địa!", nStayTime = 1}},
		[22] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1560, tbSkillPos = {1694, 3085} , nStayTime = 2}},
		[23] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1559, tbSkillPos = {1694, 3085} , nStayTime = 3}},	
		[24] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc 2 bạn trẻ đại phú đại quý!", nStayTime = 1}},	
		[25] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1694, 3085} , nStayTime = 5}},		
		[26] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Nhị bái cao đường !", nStayTime = 1}},
		[27] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1557, tbSkillPos = {1694, 3085} , nStayTime = 2}},
		[28] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1559, tbSkillPos = {1694, 3085} ,  nStayTime = 3}},	
		[29] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc 2 bạn trăm năm hạnh phúc !", nStayTime = 1}},
		[30] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1694, 3085} , nStayTime = 5}},	
		[31] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Phu thê giao bái !", nStayTime = 1}},
		[32] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1556, tbSkillPos = {1694, 3085} ,  nStayTime = 2}},
		[33] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1559, tbSkillPos = {1694, 3085} ,  nStayTime = 3}},		
		[34] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc 2 bạn trẻ vĩnh kết đồng tâm !", nStayTime = 1}},
		[35] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1694, 3085} , nStayTime = 5}},	
		[36] = {nOpt = tbNpc.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6656>：“Ta tuyên bố: 2 con chính thức thành vợ thành chồng của nhau.”<end><npc=6656>：“Từ nay về sau hai ngươi phải tôn trọng, giúp đỡ nhau.”<end><npc=6656>：“Chúc 2 ngươi yêu thương nhau đến Bạc Đầu”<end>", nStayTime = 1}},
		[37] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Ta tuyên bố: 2 con chính thức thành vợ thành chồng của nhau.", nStayTime = 4}},
		[38] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Từ nay về sau hai ngươi phải tôn trọng, giúp đỡ nhau.", nStayTime = 4}},
		[39] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc 2 ngươi yêu thương nhau đến Bạc Đầu", nStayTime = 4}},
		[40] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1561,  tbSkillPos = {1694, 3085} , nStayTime = 2}},		
		[41] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1558,  tbSkillPos = {1694, 3085} , nStayTime = 3}},	
		},
	[4] = {
		[1] = {nOpt = tbNpc.OP_MSG_HEITIAO, tbInfo = {szMsg = "Thủ lĩnh nghĩa quân Bạch Thu Lâm lên lễ đài bắt đầu buổi Điển Lễ.", nStayTime = 2}},	
		[2] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[3] = {nOpt = tbNpc.OP_MSG_CHANNEL, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[4] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Ngọn lửa hạnh phúc đã được thắp sáng, các vị khách tham dự buổi lễ sẽ nhận được phần thưởng kinh nghiệm lớn.", nStayTime = 8}},			
		[5] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[6] = {nOpt = tbNpc.OP_MSG_CHANNEL, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[7] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Ngọn lửa hạnh phúc đã được thắp sáng, các vị khách tham dự buổi lễ sẽ nhận được phần thưởng kinh nghiệm lớn.", nStayTime = 8}},		
		[8] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[9] = {nOpt = tbNpc.OP_MSG_CHANNEL, tbInfo = {szMsg = "Chủ trì buổi lễ đã lên lễ đài, mời các khách quan tập trung ở lễ đài để buổi lễ được bắt đầu", nStayTime = 1}},
		[10] = {nOpt = tbNpc.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Ngọn lửa hạnh phúc đã được thắp sáng, các vị khách tham dự buổi lễ sẽ nhận được phần thưởng kinh nghiệm lớn.", nStayTime = 8}},			
		[11] = {nOpt = tbNpc.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6656>：“Thưa chu vị hương thân phụ lão, huynh đệ tỷ muội trong nghĩa quân.”<end><npc=6656>：“Nhờ tình yêu, đã gắn kết hai bạn trẻ của chúng ta.”<end><npc=6656>：“Trong lòng ta vô cùng xúc động.”<end><npc=6656>：“Hai người họ đều là nam thanh, nữ tú trong số các huynh đệ, tỷ muội của nghĩa quân chúng ta.”<end><npc=6656>：“Chàng trai với một tướng mạo đường đường như Cây Ngọc Bích.”<end><npc=6656>：“Cô gái với vẻ đẹp Bế Nguyệt Tu Hoa, Khuynh Quốc Khuynh Thành”<end><npc=6656>：“Họ đến với nhau như lời gọi của trời và đất”<end><npc=6656>：“Liệt tổ liệt tông ở trên, ta Bạch Thu Lâm ở đây làm chứng cho hôn lễ của 2 ngươi.”<end>", nStayTime = 1}},
		[12] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Thưa chu vị hương thân phụ lão, huynh đệ tỷ muội trong nghĩa quân.", nStayTime = 4}},
		[13] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Nhờ tình yêu, đã gắn kết hai bạn trẻ của chúng ta.", nStayTime = 4}},
		[14] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Trong lòng ta vô cùng xúc động.", nStayTime = 4}},
		[15] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Hai người họ đều là nam thanh, nữ tú trong số các huynh đệ, tỷ muội của nghĩa quân chúng ta.", nStayTime = 4}},
		[16] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Chàng trai với một tướng mạo đường đường như Cây Ngọc Bích", nStayTime = 4}},
		[17] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Cô gái với vẻ đẹp Bế Nguyệt Tu Hoa, Khuynh Quốc Khuynh Thành", nStayTime = 4}},
		[18] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Họ đến với nhau như lời gọi của trời và đất.", nStayTime = 4}},		
		[19] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Liệt tổ liệt tông ở trên, ta Bạch Thu Lâm ở đây làm chứng cho hôn lễ của 2 con.", nStayTime = 4}},
		[20] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Phía dưới nghe ta chỉ thị...", nStayTime = 3}},
		[21] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Nhất bái thiên địa!", nStayTime = 1}},
		[22] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1560, tbSkillPos = {1591, 3216} , nStayTime = 2}},
		[23] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1559, tbSkillPos = {1591, 3216} , nStayTime = 3}},	
		[24] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc 2 bạn trẻ đại phú đại quý!", nStayTime = 1}},	
		[25] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1591, 3216} , nStayTime = 5}},		
		[26] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Nhị bái cao đường !", nStayTime = 1}},
		[27] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1557, tbSkillPos = {1591, 3216} , nStayTime = 2}},
		[28] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1559, tbSkillPos = {1591, 3216} ,  nStayTime = 3}},	
		[29] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc 2 bạn trăm năm hạnh phúc !", nStayTime = 1}},
		[30] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1591, 3216} , nStayTime = 5}},	
		[31] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Phu thê giao bái !", nStayTime = 1}},
		[32] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1556, tbSkillPos = {1591, 3216} ,  nStayTime = 2}},
		[33] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1559, tbSkillPos = {1591, 3216} ,  nStayTime = 3}},		
		[34] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc 2 bạn trẻ vĩnh kết đồng tâm !", nStayTime = 1}},
		[35] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1591, 3216} , nStayTime = 5}},	
		[36] = {nOpt = tbNpc.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6656>：“Ta tuyên bố: 2 con chính thức thành vợ thành chồng của nhau.”<end><npc=6656>：“Từ nay về sau hai ngươi phải tôn trọng, giúp đỡ nhau.”<end><npc=6656>：“Chúc 2 ngươi yêu thương nhau đến Bạc Đầu”<end>", nStayTime = 1}},
		[37] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Ta tuyên bố: 2 con chính thức thành vợ thành chồng của nhau.", nStayTime = 4}},
		[38] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Từ nay về sau hai ngươi phải tôn trọng, giúp đỡ nhau.", nStayTime = 4}},
		[39] = {nOpt = tbNpc.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc 2 ngươi yêu thương nhau đến Bạc Đầu", nStayTime = 4}},
		[40] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1561,  tbSkillPos = {1591, 3216} , nStayTime = 2}},		
		[41] = {nOpt = tbNpc.OP_SKILL, tbInfo = {nSkillId = 1558,  tbSkillPos = {1591, 3216} , nStayTime = 3}},	
		},
	};

--====================================================

function tbNpc:GetOptList(nWeddingMapLevel)
	return self.tbOpt[nWeddingMapLevel] or {};
end

function tbNpc:GetZhenghunNpc(nMapId)
	local nNpcId = Marry:GetWithnessesId(nMapId);
	return KNpc.GetById(nNpcId);
end

function tbNpc:GetCurStep(nMapId)
	local pNpc = self:GetZhenghunNpc(nMapId);
	if (not pNpc) then
		return 0;
	end
	
	local tbNpcData = pNpc.GetTempTable("Marry") or {};
	return tbNpcData.nCurZhenghunStep or 0;
end

function tbNpc:AddCurStep(nMapId)
	local pNpc = self:GetZhenghunNpc(nMapId);
	if (not pNpc) then
		return 0;
	end
	
	local tbNpcData = pNpc.GetTempTable("Marry") or {};
	tbNpcData.nCurZhenghunStep = tbNpcData.nCurZhenghunStep or 0;
	tbNpcData.nCurZhenghunStep = tbNpcData.nCurZhenghunStep + 1;
end

-- 证婚人开始活动
function tbNpc:Start(nMapId, nWeddingMapLevel, tbCoupleName)
	local tbOptList = self:GetOptList(nWeddingMapLevel);
	if (#tbOptList == 0) then
		return 0;
	end

	Marry:SetPerformState(nMapId, 1);
	Timer:Register(1, self.NextStep, self, nMapId, tbOptList, tbCoupleName);
end

function tbNpc:NextStep(nMapId, tbOptList, tbCoupleName)
	local nCurStep = self:GetCurStep(nMapId);
	if (0 == nCurStep) then
		local tbNpc = Npc:GetClass("marry_jixiang");
		tbNpc:Marry(tbCoupleName, nMapId);
		Marry:SetPerformState(nMapId, 0);
		return 0;
	end
	
	local tbCurOptInfo = tbOptList[nCurStep];
	if (not tbCurOptInfo) then
		local tbNpc = Npc:GetClass("marry_jixiang");
		tbNpc:Marry(tbCoupleName, nMapId);
		Marry:SetPerformState(nMapId, 0);
		return 0;
	end
	
	local nStayTime = self:DoOpt(nMapId, tbCurOptInfo);
	self:AddCurStep(nMapId);
	if (nStayTime == 0) then
		nStayTime = 1;
	end
	if (not self.nPlayTime) then
		self.nPlayTime = 1;
	end
	self.nPlayTime = self.nPlayTime + nStayTime;
	return nStayTime;
end

function tbNpc:DoOpt(nMapId, tbCurOptInfo)
	local nStayTime = 0;
	local nOpt = tbCurOptInfo.nOpt;
	if (self.OP_MSG_CHAT == nOpt) then
		nStayTime = self:Play_SendChat(nMapId, tbCurOptInfo.tbInfo);
	elseif (self.OP_MSG_FILM == nOpt) then
		nStayTime = self:Play_Film(nMapId, tbCurOptInfo.tbInfo);
	elseif (self.OP_MSG_HEITIAO == nOpt) then
		nStayTime = self:Play_Heitiao(nMapId, tbCurOptInfo.tbInfo);
	elseif (self.OP_MSG_CHANNEL == nOpt) then
		nStayTime = self:Play_Channel(nMapId, tbCurOptInfo.tbInfo);
	elseif (self.OP_MSG_INFOBOARD == nOpt) then
		nStayTime = self:Play_InfoBordMsg(nMapId, tbCurOptInfo.tbInfo);
	elseif (self.OP_SKILL == nOpt) then
		nStayTime = self:Play_CastSkill(nMapId, tbCurOptInfo.tbInfo);
	end
	return nStayTime * Env.GAME_FPS;
end

function tbNpc:GetAllPlayers(nMapId)
	local tbPlayerList = Marry:GetAllPlayers(nMapId) or {};
	return tbPlayerList;
end

-- 表演（头顶上说话）
function tbNpc:Play_SendChat(nMapId, tbCurInfo)
	local pNpc = self:GetZhenghunNpc(nMapId);
	if (pNpc) then
		pNpc.SendChat(tbCurInfo.szMsg);
	end
	return tbCurInfo.nStayTime;
end

-- 表演（电影模式）
function tbNpc:Play_Film(nMapId, tbCurInfo)
	local tbPlayerList = self:GetAllPlayers(nMapId);
	for _, pPlayer in pairs(tbPlayerList) do
		Setting:SetGlobalObj(pPlayer);
		TaskAct:Talk(tbCurInfo.szMsg);
		Setting:RestoreGlobalObj();
	end
	return tbCurInfo.nStayTime;
end

-- 表演（黑条信息）
function tbNpc:Play_Heitiao(nMapId, tbCurInfo)
	local tbPlayerList = self:GetAllPlayers(nMapId);
	for _, pPlayer in pairs(tbPlayerList) do
		Dialog:SendBlackBoardMsg(pPlayer, tbCurInfo.szMsg);
	end
	return tbCurInfo.nStayTime;
end

-- 表演（聊天频道信息）
function tbNpc:Play_Channel(nMapId, tbCurInfo)
	local tbPlayerList = self:GetAllPlayers(nMapId);
	local pNpc = self:GetZhenghunNpc(nMapId);
	for _, pPlayer in pairs(tbPlayerList) do
		Setting:SetGlobalObj(pPlayer);
		me.Msg(tbCurInfo.szMsg, pNpc.szName);
		Setting:RestoreGlobalObj();
	end
	return tbCurInfo.nStayTime;
end

-- 表演（屏幕中央信息）
function tbNpc:Play_InfoBordMsg(nMapId, tbCurInfo)
	local tbPlayerList = self:GetAllPlayers(nMapId);
	local szMsg = string.format("<color=yellow>%s<color>", tbCurInfo.szMsg)
	for _, pPlayer in pairs(tbPlayerList) do
		Dialog:SendInfoBoardMsg(pPlayer, szMsg);
	end
	return tbCurInfo.nStayTime;
end

-- 表演（释放技能）
function tbNpc:Play_CastSkill(nMapId, tbCurInfo)
	local pNpc = self:GetZhenghunNpc(nMapId);
	local nSkillLevel = tbCurInfo.nSkillLevel or 1;
	if (pNpc) then
		pNpc.CastSkill(tbCurInfo.nSkillId, nSkillLevel, unpack(tbCurInfo.tbSkillPos));
	end
	return tbCurInfo.nStayTime;
end

--=============================================================================

-- 玩家点击证婚人触发的对话
function tbNpc:OnDialog()
	local szMsg = "Ngươi có thể từ nơi này lĩnh hiệp lữ tín vật. Cũng có thể đi giang tân thôn hoa lão nguyệt lĩnh.";
	local tbOpt = {
		{"Nhận tín vật hiệp lữ", self.GetWeddingRing, self},
		{"Để ta coi lại"},
		};
		
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:GetWeddingRing()
	local tbYuelao = Npc:GetClass("marry_yuelao");
	tbYuelao:GetWeddingRing()
end
