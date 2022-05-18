-- 文件名　：visitornpc.lua
-- 创建者　：furuilei
-- 创建时间：2009-12-10 11:52:28
-- 功能描述：典礼到访npc

local tbManager = {};
Marry.VisitorManager = tbManager;

--=============================================================
tbManager.NPC_EXIST_TIME = 18 * 10;

tbManager.OP_MSG_CHAT		= 1;	-- 发送对话信息
tbManager.OP_MSG_FILM		= 2;	-- 电影字幕
tbManager.OP_MSG_HEITIAO	= 3;	-- 黑条信息
tbManager.OP_MSG_CHANNEL	= 4;	-- 聊天栏信息
tbManager.OP_MSG_INFOBOARD	= 5;	-- 中央黄色字信息
tbManager.OP_SKILL		= 6;	-- 释放技能

tbManager.TB_PATH_POSFILE = {
	[1] = "\\setting\\marry\\visitornpc_1.txt",
	[2] = "\\setting\\marry\\visitornpc_2.txt",
	[3] = "\\setting\\marry\\visitornpc_3.txt",
	[4] = "\\setting\\marry\\visitornpc_4.txt",
	};
	
tbManager.TB_NPCID = {
	[1] = {6589, 6590, 6591, 6592, 6593, 6594},
	[2] = {6583, 6584, 6585, 6586, 6587, 6588},
	[3] = {6569, 6570, 6567, 6575, 6579, 6580, 6581, 6582},
	[4] = {6572, 6568, 6571, 6574, 6573, 6576, 6577, 6578},
	};

tbManager.TB_OPT = {
	[1] = {
		[6589] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Đại sư rèn vũ khí Điềm Tửu thúc đã đến!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6589>：“Nữ hiệp xinh đẹp tốt hơn rượu hoa quả”<end><npc=6589>：“Đại hiệp chính là bình rượu.”<end><npc=6589>：“Chúc mừng ngươi!Rượu và bình từ nay như hình với bóng”<end><npc=6589>：“Chúc mừng ngươi!Hai người mãi mãi không phân ly!”<end><npc=6589>：“Rượu ngon làm ta thấm vào gan ruột nhưng không nặng bằng tình cảm của các ngươi”<end><npc=6589>：“Điềm Tửu thúc hy vọng các ngươi sống vui vẻ”<end><npc=6589>：“Sau này thường về thăm”<end><npc=6589>：“Anh chị em trong nghĩa quân nhớ các ngươi!”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Nữ hiệp xinh đẹp tốt hơn rượu hoa quả", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Đại hiệp chính là bình rượu", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc mừng ngươi!Rượu và bình từ nay như hình với bóng", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc mừng ngươi!Hai người mãi mãi không phân ly", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Rượu ngon làm ta thấm vào gan ruột nhưng không nặng bằng tình cảm của các ngươi", nStayTime = 3}},
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Điềm Tửu thúc hy vọng các ngươi sống vui vẻ。", nStayTime = 3}},
		[9] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Sau này thường về thăm", nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Anh chị em trong nghĩa quân nhớ các ngươi", nStayTime = 1}},
		[11] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1762, 3150} , nStayTime = 3}},
		[12] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Nghĩa quân<color=red>Điềm Tửu thúc<color>chúc các hai vị lữ hiệp cuộc sống hạnh phúc,hình bóng không rời!", nStayTime = 1}},
		[13] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "Nghĩa quân<color=gold>Điềm Tửu thúc<color>nhân hôn lễ này chúc các hai vị lữ hiệp cuộc sống hạnh phúc,hình bóng không rời!", nStayTime = 8}},
		},
		[6590] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Giáo Ngũ Độc:Thái Điệp Tiên Tử Điệp Phiêu Phiêu đã đến!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6590>：“Ngươi là ngọn gió bay xa ngàn dặm”<end><npc=6590>：“Muội ấy là tia chớp sáng trên trời”<end><npc=6590>：“Ngươi là mặt trời chiếu trên đồng cỏ”<end><npc=6590>：“Muội ấy là ngôi sao trong đêm!”<end><npc=6590>：“Ta giải quyết các công việc đại sự ngày hôm nay”<end><npc=6590>：“Trong người rất mệt mỏi”<end><npc=6590>：“Nhưng được biết ngày vui hôm nay của các ngươi,ta nhất định đến chúc mừng!”<end><npc=6590>：“Chúc hai vị lữ hiệp,luôn được tốt lành,ước mơ trọn vẹn!”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ngươi là ngọn gió bay xa ngàn dặm.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Muội ấy là tia chớp sáng trên trời.", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ngươi là mặt trời chiếu trên đồng cỏ", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Muội ấy là ngôi sao trong đêm!", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ta giải quyết các công việc đại sự ngày hôm nay", nStayTime = 3}},
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Trong người rất mệt mỏi", nStayTime = 3}},
		[9] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Nhưng được biết ngày vui hôm nay của các ngươi,ta nhất định đến chúc mừng!", nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc hai vị lữ hiệp,luôn được tốt lành,ước mơ trọn vẹn! ", nStayTime = 1}},
		[11] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1762, 3150} , nStayTime = 3}},
		[12] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Thái Điệp Tiên Tử<color=red>Điệp Phiêu Phiêu<color>Chúc hai vị lữ hiệp,luôn được tốt lành,ước mơ trọn vẹn!", nStayTime = 1}},
		[13] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "Thái Điệp Tiên Tử<color=gold>Điệp Phiêu Phiêu<color>Trong hôn lễ hôm nay chúc hai vị lữ hiệp,luôn được tốt lành,ước mơ trọn vẹn! ", nStayTime = 8}},
		},
		[6591] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Tiêu Dao Cốc Tần Trọng đã đến!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6591>：“Không cần mơ mộng,không cần kỳ vọng,hai vị giống như đôi chim liền cánh”<end><npc=6591>：“Ta Tần Trọng hy vọng hai vị”<end><npc=6591>：“Cùng dựa vào nhau,bay lên bầu trời càng cao càng rộng”<end><npc=6591>：“Chúc phúc cho hai vị lữ hiệp”<end><npc=6591>：“Hòa hợp,vui vẻ”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Không cần mơ mộng,không cần kỳ vọng,hai vị giống như đôi chim liền cánh", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ta Tần Trọng hy vọng hai vị", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Cùng dựa vào nhau,bay lên bầu trời càng cao càng rộng", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc phúc cho hai vị lữ hiệp", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Hòa hợp,vui vẻ", nStayTime = 1}},
		[8] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1762, 3150} , nStayTime = 3}},
		[9] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Tiêu Dao Cốc<color=red>Tần Trọng<color>Chúc phúc cho hai vị lữ hiệp hòa hợp,vui vẻ!", nStayTime = 1}},
		[10] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "Tiêu Dao Cốc<color=gold>Tần Trọng<color>nhân hôn lễ này chúc phúc cho hai vị lữ hiệp hòa hợp,vui vẻ!", nStayTime = 8}},
		},
		[6592] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Ân Phương,cái tên này quen thuộc quá,huynh ấy có đến không?", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6592>：“Yêu đúng người vào đúng lúc là hạnh phúc cả đời;”<end><npc=6592>：“Yêu nhầm người vào đúng lúc là một sự đau lòng;”<end><npc=6592>：“Yêu nhầm người không đúng lúc là một lần phóng đãng;”<end><npc=6592>：“Yêu đúng người không đúng lúc là một tiếng thở dài.”<end><npc=6592>：“Sự gắn bó của các ngươi làm ta yên lòng.”<end><npc=6592>：“Ta thật lòng chúc phúc cho ngươi,Thanh Muội.”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Yêu đúng người vào đúng lúc là hạnh phúc cả đời;", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Yêu nhầm người vào đúng lúc là một sự đau lòng;", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Yêu nhầm người không đúng lúc là một lần phóng đãng;", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Yêu đúng người không đúng lúc là một tiếng thở dài.", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Sự gắn bó của các ngươi làm ta yên lòng.", nStayTime = 1}},
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ta thật lòng chúc phúc cho ngươi,Thanh Muội.", nStayTime = 1}},
		[9] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1762, 3150} , nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "<color=red>Ân Phương<color>Chúc cho hai vị lữ hiệp mãi mãi hiểu nhau", nStayTime = 1}},
		[11] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "<color=gold>Ân Phương<color>nhân hôn lễ này chúc cho hai vị lữ hiệp mãi mãi hiểu nhau", nStayTime = 8}},
		},
		[6593] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Tiêu Dao Cốc Tử Uyển đã đến!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6593>：“Cảnh giới của hai người yêu nhau là gì?Là không có giới hạn.”<end><npc=6593>：“Chúc hai vị lữ hiệp mãi mãi đồng tâm.”<end><npc=6593>：“Giang hồ hiểm ác lòng người khó đoán”<end><npc=6593>：“Các ngươi vốn là một đôi trời sinh đất tạo.”<end><npc=6593>：“Về sau phải chăm sóc,khoan dung với nhau”<end><npc=6593>：“Chúc mừng các ngươi!”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Cảnh giới của hai người yêu nhau là gì?Là không có giới hạn.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc hai vị lữ hiệp mãi mãi đồng tâm.", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Mãi mãi vui vẻ như hôn lễ. ", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Các ngươi vốn là một đôi trời sinh đất tạo.", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Về sau phải chăm sóc,khoan dung với nhau.", nStayTime = 3}},
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc mừng các ngươi!", nStayTime = 1}},
		[9] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1762, 3150} , nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Tiêu Dao Cốc<color=red>Tử Uyển<color>Chúc hai lữ hiệp kết thành lương duyên,trăm năm hòa hợp!", nStayTime = 1}},
		[11] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "Tiêu Dao Cốc<color=gold>Tử Uyển<color>nhân hôn lễ này chúc hai lữ hiệp kết thành lương duyên,trăm năm hòa hợp!", nStayTime = 8}},
		},
		[6594] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Ân Đồng,bóng dáng quen thuộc,muội đến rồi!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6594>：“Nếu như duyên cạn cũng cố gắng nắm giữ.”<end><npc=6594>：“Vốn dĩ ngọt ngào cũng trở thành trói buộc.”<end><npc=6594>：“Trở thành lồng sắt nhốt chúng ta.”<end><npc=6594>：“Tri kỉ của cây đàn là đôi tay.”<end><npc=6594>：“Tri kỉ của nước mắt là niềm vui.”<end><npc=6594>：“Tri kỷ của tri kỷ là một đời!”<end><npc=6594>：“Nhất Lầu ca ca,người trong lòng huynh là muội ấy.”<end><npc=6594>：“Vậy thì hãy trân trọng muội ấy,để muội ấy trong tim.”<end><npc=6594>：“Huynh nhất định phải hạnh phúc hơn muội.”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Nếu như duyên cạn cũng cố gắng nắm giữ.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Vốn dĩ ngọt ngào cũng trở thành trói buộc.", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Trở thành lồng sắt nhốt chúng ta.", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Tri kỉ của cây đàn là đôi tay.", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Tri kỉ của nước mắt là niềm vui.", nStayTime = 3}},
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Tri kỷ của tri kỷ là một đời!", nStayTime = 3}},
		[9] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Nhất Lầu ca ca,người trong lòng huynh là muội ấy.", nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Vậy thì hãy trân trọng muội ấy,để muội ấy trong tim.", nStayTime = 3}},
		[11] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Huynh nhất định phải hạnh phúc hơn muội.", nStayTime = 1}},
		[12] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1762, 3150} , nStayTime = 3}},
		[13] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "<color=red>Ân Đồng<color>Chúc hai vị lữ hiệp đồng tâm,hạnh phúc đến bạc đầu", nStayTime = 1}},
		[14] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "<color=gold>Ân Đồng<color>dự hôn lễ xin chúc hai vị lữ hiệp đồng tâm,hạnh phúc đến bạc đầu", nStayTime = 8}},
		},
	},
	[2] = {
		[6583] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Lạt Thủ Thần y Trương Thiện Đức đã đến!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6583>：“Thiên Đường tràn ngập niềm vui.”<end><npc=6583>：“Mở ra ánh trăng sáng ”<end><npc=6583>：“堪叹：只羡鸳鸯不羡仙。”<end><npc=6583>：“Hãy đưa tay ra,đón nhận hạnh phúc.”<end><npc=6583>：“Để hạnh phúc nở hoa rực rỡ!”<end><npc=6583>：“Chúc hai lữ hiệp tương lai hạnh phúc.”<end><npc=6583>：“Và luôn mang theo lời chúc của ta!”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Thiên Đường tràn ngập niềm vui.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Mở ra ánh trăng sáng ", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Thở dài: Nhìn mà ghen tị với đôi uyên ương.", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Hãy đưa tay ra,đón nhận hạnh phúc.", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Để hạnh phúc nở hoa rực rỡ!", nStayTime = 3}},
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc hai lữ hiệp tương lai hạnh phúc.", nStayTime = 3}},
		[9] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Và luôn mang theo lời chúc của ta!", nStayTime = 1}},
		[10] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1603, 3170} , nStayTime = 3}},
		[11] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Lạt Thủ Thần y<color=red>Trương Thiện Đức<color>chúc hai vị lữ hiệp kết thành lương duyên,trăm năm hòa hợp!", nStayTime = 1}},
		[12] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "Lạt Thủ Thần y<color=gold>Trương Thiện Đức<color>dự hôn lễ xin chúc hai vị lữ hiệp kết thành lương duyên,trăm năm hòa hợp!", nStayTime = 8}},
		},
		[6584] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Tiền bối Võ Đang Nhất Diệp Trân Nhân đã đến!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6584>：“Vì hiểu nhau nên yêu nhau.”<end><npc=6584>：“由相爱而更加相知。”<end><npc=6584>：“Mọi người thường nói các ngươi do thần tiên kết đôi!”<end><npc=6584>：“Chúc hai vị tâm đầu ý hợp mãi mãi!”<end><npc=6584>：“Đệ tử Võ Đang lần lượt nhờ ta gửi lời chúc mừng!”<end><npc=6584>：“Các anh em hy vọng hai vị sau hôn lễ.”<end><npc=6584>：“Đừng quên tinh hoa võ nghệ của mình.”<end><npc=6584>：“Sang năm tới,hy vọng hai vị lại quy tụ tại Võ Đang”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Vì hiểu nhau nên yêu nhau.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Vì yêu nhau càng cần hiểu nhau.", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Mọi người thường nói các ngươi do thần tiên kết đôi!", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc hai vị tâm đầu ý hợp mãi mãi!", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Đệ tử Võ Đang lần lượt nhờ ta gửi lời chúc mừng!", nStayTime = 3}},
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Các anh em hy vọng hai vị sau hôn lễ.", nStayTime = 3}},
		[9] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Đừng quên tinh hoa võ nghệ của mình.", nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Sang năm tới,hy vọng hai vị lại quy tụ tại Võ Đang.", nStayTime = 1}},
		[11] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1603, 3170} , nStayTime = 3}},
		[12] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Tiền bối Võ Đang<color=red>Nhất Diệp Trân Nhân<color>chúc hai lữ hiệp tâm đầu ý hợp mãi mãi!", nStayTime = 1}},
		[13] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "Tiền bối Võ Đang<color=gold>Nhất Diệp Trân Nhân<color>dự hôn lễ xin chúc hai lữ hiệp tâm đầu ý hợp mãi mãi!", nStayTime = 8}},
		},
		[6585] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Nhu Tiểu Thúy - giang hồ gọi là Mẫu Đại Trùng cũng đến chúc mừng!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6585>：“Đàn ông trước khi Nạp Cát cảm thấy nữ hiệp phù hợp với mình rất hiếm.”<end><npc=6585>：“Nạp thành lữ hiệp rồi cảm thấy nữ hiệp phù hợp với mình rất nhiều.”<end><npc=6585>：“Ây da,tại sao lại nhìn tôi với ánh mắt kì lạ vậy.”<end><npc=6585>：“Tôi chỉ đùa chút thôi.”<end><npc=6585>：“Hôm nay,tôi thật lòng đến chúc phúc hai vị mà.”<end><npc=6585>：“Đồng tâm,hòa thuận đến bạc đầu”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Đàn ông trước khi Nạp Cát cảm thấy nữ hiệp phù hợp với mình rất hiếm.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Nạp thành lữ hiệp rồi cảm thấy nữ hiệp phù hợp với mình rất nhiều.", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ây da,tại sao lại nhìn tôi với ánh mắt kì lạ vậy.", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Tôi chỉ đùa chút thôi.", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Hôm nay,tôi thật lòng đến chúc phúc hai vị mà.", nStayTime = 3}},
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Đồng tâm,hòa thuận đến bạc đầu.", nStayTime = 1}},
		[9] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1603, 3170} , nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "<color=red>Nhu Tiểu Thúy<color>chúc hai vị lữ hiệp đồng tâm,hòa thuận đến bạc đầu.", nStayTime = 1}},
		[11] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "<color=gold>Nhu Tiểu Thúy<color>dự hôn lễ xin chúc hai vị lữ hiệp đồng tâm,hòa thuận đến bạc đầu.", nStayTime = 8}},
		},
		[6586] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Hạ Tiểu Sảnh - thiếu nữ nhu mì cũng đến chúc mừng!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6586>：“Hôm nay là ngày đại hỷ của hai vị.”<end><npc=6586>：“Cốc chủ Tiêu Dao Cốc phê chuẩn cho tôi đến chúc mừng.”<end><npc=6586>：“Niềm vui của lữ hiệp tuy không gì sánh được.”<end><npc=6586>：“Nhưng chỉ có thể tồn tại ở nơi quang vinh và lương thiện”<end><npc=6586>：“Hy vọng hai vị về sau thường xuyên đến Tiêu Dao Cốc thăm chúng tôi.”<end><npc=6586>：“Tôi cũng có người trong lòng.”<end><npc=6586>：“Cũng muốn ở bên người đó.”<end><npc=6586>：“Cùng đi ngao du thiên hạ.”<end><npc=6586>：“Tâm trạng Tiểu Sảnh không vui,xin hai vị đừng trách.”<end><npc=6586>：“Tiểu Sảnh thật lòng mong hai vị hạnh phúc viên mãn.。”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Hôm nay là ngày đại hỷ của hai vị.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Cốc chủ Tiêu Dao Cốc phê chuẩn cho tôi đến chúc mừng.", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Niềm vui của lữ hiệp tuy không gì sánh được.", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Nhưng chỉ có thể tồn tại ở nơi quang vinh và lương thiện", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Hy vọng hai vị về sau thường xuyên đến Tiêu Dao Cốc thăm chúng tôi.", nStayTime = 3}},
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Tôi cũng có người trong lòng. ", nStayTime = 3}},
		[9] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Cũng muốn ở bên người đó.", nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Cùng đi ngao du thiên hạ.", nStayTime = 3}},
		[11] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Tâm trạng Tiểu Sảnh không vui,xin hai vị đừng trách.", nStayTime = 3}},
		[12] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Tiểu Sảnh thật lòng mong hai vị hạnh phúc viên mãn.", nStayTime = 1}},
		[13] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1603, 3170} , nStayTime = 3}},
		[14] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "<color=red>Hạ Tiểu Sảnh: <color>chúc hai vị hạnh phúc viên mãn,sống đến bạc đầu!", nStayTime = 1}},
		[15] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "<color=gold>Hạ Tiểu Sảnh: <color>Chúc hai vị hạnh phúc viên mãn,sống đến bạc đầu!", nStayTime = 8}},
		},
		[6587] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Đại lão bạch,ông chủ quán rượu đã đến!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6587>：“Chúc mừng hai vị đã tìm được tri kỉ một đời.”<end><npc=6587>：“Đây là chuyện lớn đời người.”<end><npc=6587>：“Hãy tin rằng đây là quyết định sáng suốt của các ngươi.”<end><npc=6587>：“Sau hôn lễ,các người đừng quên ta.”<end><npc=6587>：“Gặt hái được những kinh nghiệm mới.”<end><npc=6587>：“Đừng quên chia sẻ với ta!”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc mừng hai vị đã tìm được tri kỉ một đời.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Đây là chuyện lớn đời người.", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Hãy tin rằng đây là quyết định sáng suốt của các ngươi.", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Sau hôn lễ,các người đừng quên ta.", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Gặt hái được những kinh nghiệm mới.", nStayTime = 3}},
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Đừng quên chia sẻ với ta!", nStayTime = 1}},
		[9] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1603, 3170} , nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "ông chủ quán rượu<color=red>Đại lão bạch<color>chúc hai vị kết thành lương duyên,trăm năm hạnh phúc!", nStayTime = 1}},
		[11] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "ông chủ quán rượu<color=gold>Đại lão bạch<color>dự hôn lễ xin chúc hai vị kết thành lương duyên,trăm năm hạnh phúc!", nStayTime = 8}},
		},
		[6588] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Đường Vũ của Tiêu Dao Tứ Tiên đã đến!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6588>：“Càng yêu thì càng cần gắn bó.”<end><npc=6588>：“Nên giữa hai người không được có sự so đo.”<end><npc=6588>：“Lão phu là người từng trải,khi còn trẻ ta cũng khôi ngô tuấn tú. ”<end><npc=6588>：“Đáng tiếc là thời gian không đợi ai.”<end><npc=6588>：“Lão phu ước trẻ lại 50 tuổi!”<end><npc=6588>：“Hãy trân trọng người trước mắt nhé!”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Càng yêu thì càng cần gắn bó.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Nên giữa hai người không được có sự so đo.", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Lão phu là người từng trải,khi còn trẻ ta cũng khôi ngô tuấn tú. ", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Đáng tiếc là thời gian không đợi ai.", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Lão phu ước trẻ lại 50 tuổi!", nStayTime = 3}},
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Hãy trân trọng người trước mắt nhé!", nStayTime = 1}},
		[9] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1603, 3170} , nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Tiêu Dao Tứ Tiên<color=red>Đường Vũ: <color>chúc hai vị trân trọng lẫn nhau,viên mãn hạnh phúc!", nStayTime = 1}},
		[11] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "Tiêu Dao Tứ Tiên<color=gold>Đường Vũ: <color>nhân buổi lễ hôm nay chúc hai vị trân trọng lẫn nhau,viên mãn hạnh phúc!", nStayTime = 8}},
		},
	},
	[3] = {		
		[6569] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Doãn Tiêu Vũ Chưởng môn nhân của Thúy Yên môn đến!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6569>：“Thật là ngưỡng mộ hai vị.”<end><npc=6569>：“Ta tin ta cũng sẽ có được tri kỉ trong đời.”<end><npc=6569>：“Ta tin ta và Diệp Luật Sở Tài cũng sẽ có ngày hôm nay.”<end><npc=6569>：“Hôm nay ta thay mặt tỷ muội trong Thúy Yên môn chúc mừng.”<end><npc=6569>：“Trong thiên hạ,tình nhân rồi cũng trở thành phu thê.”<end><npc=6569>：“Mối lương duyên định sẵn từ kiếp trước.”<end><npc=6569>：“Điển Lễ đại hỷ!Trăm năm hòa hợp!”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Thật là ngưỡng mộ hai vị.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ta tin ta cũng sẽ có được tri kỉ trong đời.", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ta tin ta và Diệp Luật Sở Tài cũng sẽ có ngày hôm nay.", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Hôm nay ta thay mặt tỷ muội trong Thúy Yên môn chúc mừng.", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Trong thiên hạ,tình nhân rồi cũng trở thành phu thê.", nStayTime = 3}},
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Mối lương duyên định sẵn từ kiếp trước.", nStayTime = 3}},
		[9] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Điển Lễ đại hỷ!Trăm năm hòa hợp!", nStayTime = 1}},
		[10] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1694, 3085} , nStayTime = 3}},
		[11] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Chưởng môn nhân của Thúy Yên môn<color=red>Doãn Tiêu Vũ<color>chúc hai vị lữ hiệp hỷ kết lương duyên,trăm năm hòa hợp!", nStayTime = 1}},
		[12] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "Chưởng môn nhân của Thúy Yên môn<color=gold>Doãn Tiêu Vũ<color>dự hôn lễ hôm nay chúc hai vị lữ hiệp hỷ kết lương duyên,trăm năm hòa hợp!", nStayTime = 8}},
		},
		[6570] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Hoàn Nhan Tương giáo chủ giáo Thiên Nhẫn đến!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6570>：“Đã từng có một tình cảm chân tình trước mắt ta.”<end><npc=6570>：“我没有珍惜。”<end><npc=6570>：“Đến khi mất đi.”<end><npc=6570>：“Ta mới hối hận không kịp.”<end><npc=6570>：“Đó là sự đau khổ nhất trong nhân gian!”<end><npc=6570>：“Nếu ông trời có thể cho tôi cơ hội làm lại.”<end><npc=6570>：“Ta sẽ nói với Tiêu Vũ ba chữ:<color=red>Ta yêu nàng<color>!”<end><npc=6570>：“Nếu phải cho mối tình này một thời hạn”<end><npc=6570>：“Ta hy vọng là<color=red>'1 vạn năm'<color>！”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Đã từng có một tình cảm chân tình trước mắt ta.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ta không biết trân trọng.", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Đến khi mất đi.", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ta mới hối hận không kịp.", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Đó là sự đau khổ nhất trong nhân gian!", nStayTime = 3}},		
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Nếu ông trời có thể cho ta cơ hội làm lại.", nStayTime = 3}},
		[9] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ta sẽ nói với Tiêu Vũ ba tiếng:ta yêu nàng!", nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Nếu phải cho mối tình này một kì hạn.", nStayTime = 3}},		
		[11] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ta hy vọng sẽ là 1 vạn năm!", nStayTime = 1}},
		[12] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1694, 3085} , nStayTime = 3}},
		[13] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Giáo chủ giáo Thiên Nhẫn<color=red>Hoàn Nhan Tương<color>chúc hai vị mãi mãi sánh đôi!", nStayTime = 1}},
		[14] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "Giáo chủ giáo Thiên Nhẫn<color=gold>Hoàn Nhan Tương<color>dự hôn lễ này chúc hai vị mãi mãi sánh đôi!", nStayTime = 8}},
		},
		[6567] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Một bóng đen vừa lướt qua,có phải là Ná Lộ Hào Hiệp đến đây không!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6567>：“Phiêu bạt trong giang hồ đã lâu.”<end><npc=6567>：“Trần Vô Mệnh ta không phải không muốn yên ổn.”<end><npc=6567>：“Ta muốn có một gia đình.”<end><npc=6567>：“Một nơi không cần hoa lệ.”<end><npc=6567>：“Khi ta mệt mỏi.”<end><npc=6567>：“Ta sẽ nghĩ về đó.”<end><npc=6567>：“Khi ta bị đe dọa.”<end><npc=6567>：“Ta cũng không sợ hãi.”<end><npc=6567>：“Ta rất ngưỡng mộ các ngươi!”<end><npc=6567>：“Chúc các ngươi trân trọng lẫn nhau,viên mãn,hạnh phúc!”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Phiêu bạt trong giang hồ đã lâu.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Trần Vô Mệnh ta không phải không muốn yên ổn.", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ta muốn có một gia đình.", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Một nơi không cần hoa lệ.", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Khi ta mệt mỏi.", nStayTime = 3}},
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ta sẽ nghĩ về đó.", nStayTime = 3}},
		[9] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Khi ta bị đe dọa.", nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ta cũng không sợ hãi.", nStayTime = 3}},
		[11] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ta rất ngưỡng mộ các ngươi!", nStayTime = 3}},
		[12] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc các ngươi trân trọng lẫn nhau,viên mãn,hạnh phúc!", nStayTime = 1}},
		[13] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1694, 3085} , nStayTime = 13}},
		[14] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Hiệp khách Khoái Đao<color=red>Trần Vô Mệnh<color>Chúc các ngươi trân trọng lẫn nhau,viên mãn,hạnh phúc!", nStayTime = 1}},
		[15] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "Hiệp khách Khoái Đao<color=gold>Trần Vô Mệnh<color>nhân hôn lễ này chúc các ngươi trân trọng lẫn nhau,viên mãn,hạnh phúc!", nStayTime = 8}},
		},
		[6575] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Lại là một giang hồ hào kiệt,Dương Liễu nữ hiệp đến!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6575>：“Lời hứa là một đời một kiếp.”<end><npc=6575>：“Giữ trọn lời thề.”<end><npc=6575>：“Tín vật là dấu ấn của lời hứa.”<end><npc=6575>：“Cầm tín vật trên tay cũng như đặt vào trong tim.”<end><npc=6575>：“Những gì có được xin đừng đòi hỏi!”<end><npc=6575>：“Bởi những gì đã có là một mối tình không thể chia cắt.”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Lời hứa là một đời một kiếp.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Giữ trọn lời thề.", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Tín vật là dấu ấn của lời hứa.", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Cầm tín vật trên tay cũng như đặt vào trong tim.", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Những gì có được xin đừng đòi hỏi!", nStayTime = 3}},
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Bởi những gì đã có là một mối tình không thể chia cắt.", nStayTime = 1}},
		[9] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1694, 3085} , nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "nữ hiệp<color=red>Dương Liễu<color>chúc hai vị hôn lễ đại hỷ,trăm năm hòa hợp!", nStayTime = 1}},
		[11] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "nữ hiệp<color=gold>Dương Liễu<color>chúc hai vị hôn lễ đại hỷ,trăm năm hòa hợp!", nStayTime = 8}},
		},		
		[6579] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Đại viên nhất phẩm đương triều Triệu Nhữ Ngu Triệu đại nhân đến! ", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6579>：“Vì có ngươi,cô đơn tự tiêu tan.”<end><npc=6579>：“Vì có ngươi,hạnh phúc tràn đầy!”<end><npc=6579>：“Chúc các ngươi tận hưởng hạnh phúc.”<end><npc=6579>：“Vượt qua sóng gió,bên nhau đến bạc đầu.”<end><npc=6579>：“Chúc các ngươi tuổi xuân đẹp đẽ!”<end><npc=6579>：“Cuộc đời tươi đẹp,không có gì phải hối tiếc.”<end><npc=6579>：“Hôm nay là thời khắc hai lữ hiệp bước vào lễ đường thần thánh.”<end><npc=6579>：“Ta thay mặt các quan khách chân thành chúc phúc cho đại hiệp,nữ hiệp.”<end><npc=6579>：“Hạnh phúc viên mãn mãi mãi”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Vì có ngươi,cô đơn tự tiêu tan.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Vì có ngươi,hạnh phúc tràn đầy!", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc các ngươi tận hưởng hạnh phúc.", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Vượt qua sóng gió,bên nhau đến bạc đầu.", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc các ngươi tuổi xuân đẹp đẽ!", nStayTime = 3}},
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Cuộc đời tươi đẹp,không có gì phải hối tiếc.", nStayTime = 3}},
		[9] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Hôm nay là thời khắc hai lữ hiệp bước vào lễ đường thần thánh.", nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ta thay mặt các quan khách chân thành chúc phúc cho đại hiệp,nữ hiệp.", nStayTime = 3}},
		[11] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Hạnh phúc viên mãn mãi mãi.", nStayTime = 1}},
		[12] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1694, 3085} , nStayTime = 3}},
		[13] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "<color=red>Triệu Nhữ Ngu<color>Triệu đại nhân chúc các ngươi hạnh phúc viên mãn mãi mãi!", nStayTime = 1}},
		[14] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "<color=gold>Triệu Nhữ Ngu<color>Triệu đại nhân chúc các ngươi hạnh phúc viên mãn mãi mãi!", nStayTime = 8}},
		},
		[6580] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Đại sư rèn trang sức của nghĩa quân Hảo Phiêu Tịnh đến!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6580>：“Tình yêu!!!”<end><npc=6580>：“Đây không phải là trái tim này đi gõ cửa trái tim khác.”<end><npc=6580>：“Mà là hai trái tim cùng bùng cháy.”<end><npc=6580>：“Cuộc sống!!!！！！”<end><npc=6580>：“Là mỗi ngày bình thường.”<end><npc=6580>：“Mà khiến bạn không thể quên được.”<end><npc=6580>：“Lữ hiệp à !!?”<end><npc=6580>：“Đợi ta cử hành hôn lễ rồi sẽ tông kết lại.”<end><npc=6580>：“Hy vọng các ngươi nồng thắm.”<end><npc=6580>：“Phiêu Tịnh tỷ ta muốn bế con của các ngươi.”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Tình yêu!!!", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Đây không phải là trái tim này đi gõ cửa trái tim khác.", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Mà là hai trái tim cùng bùng cháy.", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Cuộc sống!!!", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Là mỗi ngày bình thường.", nStayTime = 3}},
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Mà khiến bạn không thể quên được.", nStayTime = 3}},
		[9] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Hôn nhân à!!?", nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Đợi ta kết hôn rồi sẽ tổng kết lại.", nStayTime = 3}},
		[11] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Hy vọng các ngươi nồng thắm.", nStayTime = 3}},
		[12] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Phiêu Tịnh tỷ ta muốn bế con của các ngươi.", nStayTime = 1}},
		[13] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1694, 3085} , nStayTime = 3}},
		[14] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Nghĩa quân<color=red>Hảo Phiêu Tịnh<color>chúc hai vị mãi mãi nồng thắm!", nStayTime = 1}},
		[15] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "Nghĩa quân<color=gold>Hảo Phiêu Tịnh<color>chúc hai vị mãi mãi nồng thắm!", nStayTime = 8}},
		},
		[6581] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Lão tiền bối bang Thiên Vương Dương Anh đến!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6581>：“Tuổi già chân tay không linh hoạt nữa rồi.”<end><npc=6581>：“Đến chậm một bước xin các vị thứ lỗi.”<end><npc=6581>：“Chia sẻ một chút nhé ?”<end><npc=6581>：“Đàn ông phải hiểu phụ nữ,làm phụ nữ không dễ dàng.”<end><npc=6581>：“Phụ nữ phải quan hệ tốt với mẹ chồng, giúp chồng, dạy con.”<end><npc=6581>：“Hai trái tim trăm năm ân ái.”<end><npc=6581>：“Nghìn năm nhân duyên một mối”<end><npc=6581>：“Chúc mừng,chúc mừng.”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Tuổi già chân tay không linh hoạt nữa rồi.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Đến chậm một bước xin các vị thứ lỗi.", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chia sẻ một chút nhé ?", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Đàn ông phải hiểu phụ nữ,làm phụ nữ không dễ dàng.", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Phụ nữ phải quan hệ tốt với mẹ chồng, giúp chồng, dạy con.", nStayTime = 3}},
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Hai trái tim trăm năm ân ái.", nStayTime = 3}},
		[9] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Nghìn năm nhân duyên một mối", nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc mừng,chúc mừng.", nStayTime = 1}},
		[11] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1694, 3085} , nStayTime = 3}},
		[12] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Lão tiền bối bang Thiên Vương<color=red>Dương Anh<color>chúc hai lữ hiệp trăm năm ân ái!", nStayTime = 1}},
		[13] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "Lão tiền bối bang Thiên Vương<color=gold>Dương Anh<color>chúc hai lữ hiệp trăm năm ân ái!", nStayTime = 8}},
		},
		[6582] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Đường Hiểu-môn chủ Đường môn đến!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6582>：“Tình là trái tim say mê nóng bỏng.”<end><npc=6582>：“Là ngọn lửa không thể nào dập tắt.”<end><npc=6582>：“Là dục vọng không bao giờ thỏa mãn.”<end><npc=6582>：“Là niềm vui ngọt ngào như đường mật.”<end><npc=6582>：“Là sự điên cuồng như say,như mất trí.”<end><npc=6582>：“Là sự lao khổ không có bình yên.”<end><npc=6582>：“Là sự bình yên không có lao khổ!”<end><npc=6582>：“Sự gắn bó của các ngươi là sự thăng hoa của tình cảm”<end><npc=6582>：“Tiền duyên ba đời,mãi mãi đồng tâm.”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Tình là trái tim say mê nóng bỏng.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Là ngọn lửa không thể nào dập tắt.", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Là dục vọng không bao giờ thỏa mãn.", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Là niềm vui ngọt ngào như đường mật.", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Là sự điên cuồng như say,như mất trí.", nStayTime = 3}},
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Là sự lao khổ không có bình yên.", nStayTime = 3}},
		[9] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Là sự bình yên không có lao khổ!", nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Sự gắn bó của các ngươi là sự thăng hoa của tình cảm", nStayTime = 3}},
		[11] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Tiền duyên ba đời,mãi mãi đồng tâm.", nStayTime = 1}},
		[12] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1694, 3085} , nStayTime = 3}},
		[13] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Môn chủ Đường môn<color=red>Đường Hiểu<color>chúc các ngươi tiền duyên ba đời,mãi mãi đồng tâm!", nStayTime = 1}},
		[14] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "Môn chủ Đường môn<color=gold>Đường Hiểu<color>chúc các ngươi tiền duyên ba đời,mãi mãi đồng tâm!", nStayTime = 8}},
		},
	},
	[4] = {
		[6572] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Đoàn Hoàng Gia Giá phủ Đại Lý đến!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6572>：“Các ngươi về sau,sớm sớm chiều chiều.”<end><npc=6572>：“Chỉ cần chân tình, thuần khiết,Hoa nở hoa tàn cũng mãi đẹp.”<end><npc=6572>：“Chỉ cần tình cảm chân thực,trăng tròn trăng khuyết rồi lại tròn.”<end><npc=6572>：“Chỉ cần tâm tâm tương đồng，núi xa sông xa cũng không sợ.”<end><npc=6572>：“Chỉ cần tương thân tương ái,nghìn khó vạn khó cũng không nản.”<end><npc=6572>：“La Quý Kỷ,ngươi có hiểu ta không？”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Các ngươi về sau,sớm sớm chiều chiều.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chỉ cần chân tình, thuần khiết，hoa nở hoa tàn cũng mãi đẹp.", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chỉ cần tình cảm chân thực,trăng tròn trăng khuyết rồi lại tròn.", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chỉ cần tâm tâm tương đồng，núi xa sông xa cũng không sợ.", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chỉ cần tương thân tương ái,nghìn khó vạn khó cũng không nản.", nStayTime = 3}},
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "La Quý Kỷ,ngươi có hiểu ta không？", nStayTime = 1}},		
		[9] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1591, 3216} , nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Đoàn Thị môn chủ Đại Lý<color=red>Đoàn Trí Hưng<color>Chúc hai vị lữ hiệp tâm tâm tương đồng!", nStayTime = 1}},
		[11] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "Đoàn Thị môn chủ Đại Lý<color=gold>Đoàn Trí Hưng<color>Chúc hai vị lữ hiệp tâm tâm tương đồng!", nStayTime = 8}},
		},
		[6568] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Dương Thiết Tâm bang chủ bang Thiên Vương đến!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6568>：“Đến chậm 1 bước,không còn chỗ.”<end><npc=6568>：“Các ngươi vốn là một đôi trời sinh đất tạo.”<end><npc=6568>：“Từ nay song đôi.”<end><npc=6568>：“Về sau phải chăm sóc khoan dung với nhau.”<end><npc=6568>：“Ta thay mặt bang Thiên Vương chúc phúc các ngươi!”<end><npc=6568>：“Trong tương lai.”<end><npc=6568>：“Bang Thiên Vương vẫn cần đến sự hỗ trợ của hai vị.。”<end><npc=6568>：“Con đường chúng ta đi còn rất dài.”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Đến chậm 1 bước,không còn chỗ.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Các ngươi vốn là một đôi trời sinh đất tạo.", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Từ nay song đôi.", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Về sau phải chăm sóc khoan dung với nhau.", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ta thay mặt bang Thiên Vương chúc phúc các ngươi!", nStayTime = 3}},
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Trong tương lai.", nStayTime = 3}},
		[9] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Bang Thiên Vương vẫn cần đến sự hỗ trợ của hai vị.", nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Con đường chúng ta đi còn rất dài.", nStayTime = 1}},
		[11] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1591, 3216} , nStayTime = 3}},
		[12] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "bang chủ bang Thiên Vương<color=red>Dương Thiết Tâm<color>chúc hai vị lữ hiệp gia đình đầm ấm,hạnh phúc!", nStayTime = 1}},
		[13] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "bang chủ bang Thiên Vương<color=gold>Dương Thiết Tâm<color>chúc hai vị lữ hiệp gia đình đầm ấm,hạnh phúc!", nStayTime = 8}},
		},
		[6571] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Đại sư Vương Trùng Dương bậc thầy võ học đến!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6571>：“Ý trời khó đoán,nghèo khó dễ đến.”<end><npc=6571>：“Giữa 1 biển người đã tìm thấy nửa kia.”<end><npc=6571>：“Chắc hẳn là duyên phận nghìn năm trước.”<end><npc=6571>：“Tu 10 năm mới ngồi chung con thuyền.”<end><npc=6571>：“Tu 100 năm mới là vợ chồng!”<end><npc=6571>：“Vô số cái ngẫu nhiên kết thành tất yếu.”<end><npc=6571>：“Cho nên hôm nay đã nên duyên vợ chồng.”<end><npc=6571>：“Hãy giữ gìn duyên phận này.”<end><npc=6571>：“Đệ tử Võ Đang chúc mừng các ngươi.”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ý trời khó đoán,nghèo khó dễ đến.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Giữa 1 biển người đã tìm thấy nửa kia.", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chắc hẳn là duyên phận nghìn năm trước.", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Tu 10 năm mới ngồi chung con thuyền.", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Tu 100 năm mới là vợ chồng!", nStayTime = 3}},		
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Vô số cái ngẫu nhiên kết thành tất yếu.", nStayTime = 3}},
		[9] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Cho nên hôm nay đã nên duyên vợ chồng.", nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Hãy giữ gìn duyên phận này.", nStayTime = 3}},		
		[11] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Đệ tử Võ Đang chúc mừng các ngươi.", nStayTime = 1}},
		[12] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1591, 3216} , nStayTime = 3}},
		[13] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "bậc thầy võ học<color=red>Vương Trùng Dương<color>chúc hai lữ hiệp nhất tâm hướng thiện!", nStayTime = 1}},
		[14] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "bậc thầy võ học<color=gold>Vương Trùng Dương<color>chúc hai lữ hiệp nhất tâm hướng thiện!", nStayTime = 8}},
		},
		[6574] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Thừa tướng Hàn Thác Trụ Hàn đại nhân đến!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6574>：“Hôm nay, ánh mặt trời chiếu rọi, mối lương duyên trời ban”<end><npc=6574>：“Bằng hữu sum vầy, cùng nhau chúc phúc!”<end><npc=6574>：“Trong ngày vui hôm nay.”<end><npc=6574>：“Ta trân trọng thay mặt các vị thủ lĩnh Khu Mật viện,Hàn Lâm viện”<end><npc=6574>：“Giành những lời chúc nhiệt tình và tốt đẹp nhất đến hai vị”<end><npc=6574>：“Hy vọng hai vị từ nay về sau ”<end><npc=6574>：“Có thể chăm chỉ làm việc,tôn trọng lẫn nhau,hiếu thuận với người già, yêu thương con cái”<end><npc=6574>：“Sự nghiệp phát triển, gia đình hạnh phúc.”<end><npc=6574>：“Cám ơn!”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Hôm nay, ánh mặt trời chiếu rọi, mối lương duyên trời ban", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Bằng hữu sum vầy, cùng nhau chúc phúc!", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Trong ngày vui hôm nay.", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ta trân trọng thay mặt các vị thủ lĩnh Khu Mật viện,Hàn Lâm viện", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Giành những lời chúc tốt đẹp nhất đến hai vị!", nStayTime = 3}},		
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Hy vọng hai vị từ nay về sau ", nStayTime = 3}},
		[9] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Có thể chăm chỉ làm việc,tôn trọng lẫn nhau、hiếu thuận với người già, yêu thương con cái", nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Sự nghiệp phát triển, gia đình hạnh phúc.", nStayTime = 3}},		
		[11] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Cám ơn! ", nStayTime = 1}},
		[12] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1591, 3216} , nStayTime = 3}},
		[13] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Thừa tướng<color=red>Hàn Thác Trụ<color>chúc các ngươi sự nghiệp phát triển, gia đình hạnh phúc!", nStayTime = 1}},
		[14] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "Thừa tướng<color=gold>Hàn Thác Trụ<color>chúc các ngươi sự nghiệp phát triển, gia đình hạnh phúc!", nStayTime = 8}},
		},
		[6573] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Đại tướng quân Tất Đại Ngộ đến!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6573>：“Lão phu thấy các ngươi tâm đầu ý hợp,cảm thấy an lòng.”<end><npc=6573>：“Chúng ta nhảy múa mừng những người lương thiện!”<end><npc=6573>：“Ca hát vì những người vui vẻ.”<end><npc=6573>：“Nâng cốc vì những người hạnh phúc.”<end><npc=6573>：“Chúc cho con đường họ đi tràn đầy ánh nắng!”<end><npc=6573>：“Tận hưởng mỹ vị trong thiên hạ đừng để lãng phí”<end><npc=6573>：“喝尽人间美酒不要喝醉。”<end><npc=6573>：“Mời mọi người nâng cốc, dùng tiệc”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Lão phu thấy các ngươi tâm đầu ý hợp,cảm thấy an lòng.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chúng ta nhảy múa mừng những người lương thiện!", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ca hát vì những người vui vẻ.", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Nâng cốc vì những người hạnh phúc.", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc cho con đường họ đi tràn đầy ánh nắng!", nStayTime = 3}},		
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Tận hưởng mỹ vị trong thiên hạ đừng để lãng phí.", nStayTime = 3}},
		[9] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Tận hưởng rượu ngon trong thiên hạ đừng để say.", nStayTime = 3}},	
		[10] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Mời mọi người nâng cốc, dùng tiệc", nStayTime = 1}},
		[11] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1591, 3216} , nStayTime = 3}},
		[12] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "<color=red>Tất Đại Ngộ<color>Đại tướng quân chúc cho hai vị lữ hiệp sánh đôi đến bạc đầu!", nStayTime = 1}},
		[13] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "<color=gold>Tất Đại Ngộ<color>Đại tướng quân chúc cho hai vị lữ hiệp sánh đôi đến bạc đầu!", nStayTime = 8}},
		},
		[6576] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Đại sư thiết kế y phục Thẩm Hà Diệp đến!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6576>：“cùng chúc phúc,cùng vui với các ngươi.”<end><npc=6576>：“Vì hôm nay trong lòng ta cũng vui mừng thay ngươi!”<end><npc=6576>：“Hôm nay ta thay mặt nghĩa quân.”<end><npc=6576>：“Chúc các ngươi trăm năm hòa hợp,sống đến bạc đầu!”<end><npc=6576>：“Hãy nuôi 1 đứa trẻ bụ bẫm!”<end><npc=6576>：“Quần áo của nó về sau Hà Diệp tỷ sẽ lo.”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Cùng chúc phúc,cùng vui với các ngươi.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Vì hôm nay trong lòng ta cũng vui mừng thay ngươi!", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Hôm nay ta thay mặt nghĩa quân.", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc các ngươi trăm năm hòa hợp,sống đến bạc đầu!", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Hãy nuôi 1 đứa trẻ bụ bẫm!", nStayTime = 3}},		
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Quần áo của nó về sau Hà Diệp tỷ sẽ lo.", nStayTime = 1}},
		[9] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1591, 3216} , nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Nghĩa quân<color=red>Thẩm Hà Diệp<color>chúc hai lữ hiệp là tài tử giai nhân,vĩnh viễn đồng tâm!", nStayTime = 1}},
		[11] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "Nghĩa quân<color=gold>Thẩm Hà Diệp<color>chúc hai lữ hiệp là tài tử giai nhân,vĩnh viễn đồng tâm!", nStayTime = 8}},
		},
		[6577] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Mông Cổ Đại Hãn,Thiết Mộc Chân ngàn dặm xa xôi đến dự hôn lễ!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6577>：“Huynh là mũi tên bay,muội ấy là tiếng gió cạnh mũi tên.。”<end><npc=6577>：“Huynh là chim ưng trúng thương,muội ấy là ánh trăng an ủi.”<end><npc=6577>：“Huynh vững chắc như tùng,muội ấy mềm mại như cỏ.”<end><npc=6577>：“愿，二位天长地久。”<end><npc=6577>：“Huynh ấy sẽ luôn là tri kỷ của cô nương.”<end><npc=6577>：“Muội là người trong tim huynh ấy đời đời kiếp kiếp.”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Huynh là mũi tên bay,muội ấy là tiếng gió cạnh mũi tên.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Huynh là chim ưng trúng thương,muội ấy là ánh trăng an ủi.", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Huynh vững chắc như tùng,muội ấy mềm mại như cỏ.", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chúc hai vị mãi mãi cùng trời đất.", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Huynh ấy sẽ luôn là tri kỷ của cô nương. ", nStayTime = 3}},		
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Muội là người trong tim huynh ấy đời đời kiếp kiếp.", nStayTime = 1}},
		[9] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1591, 3216} , nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Mông Cổ Đại Hãn <color=red>Thiết Mộc Chân<color>chúc hai vị đời đời kiếp kiếp sát cánh bên nhau!", nStayTime = 1}},
		[11] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "Mông Cổ Đại Hãn <color=gold>Thiết Mộc Chân<color>chúc hai vị đời đời kiếp kiếp sát cánh bên nhau!", nStayTime = 8}},
		},
		[6578] = {
		[1] = {nOpt = tbManager.OP_MSG_HEITIAO, tbInfo = {szMsg = "Đại văn hào Tân Khí Tật đến!", nStayTime = 5}},
		[2] = {nOpt = tbManager.OP_MSG_FILM, tbInfo = {szMsg = "<npc=6578>：“tục ngữ có câu, hữu duyên thiên lý năng tương ngộ.”<end><npc=6578>：“các ngươi đều kiệt xuất nổi bật nên vừa gặp đã thích vừa nhìn đã yêu”<end><npc=6578>：“Hai trái tim cùng chung nhịp đập.”<end><npc=6578>：“Ngọn lửa tình yêu rực cháy.”<end><npc=6578>：“Các ngươi đã yêu nhau.”<end><npc=6578>：“ Đồng ý đồng lòng”<end><npc=6578>：“Các ngươi kết giao là một đôi trời đất tạo ra.”<end><npc=6578>：“Khi cuộc sống mới bắt đầu.”<end><npc=6578>：“Ta hy vọng đại hiệp,nữ hiệp cảm thông chia sẻ với nhau.”<end><npc=6578>：“Chân tình không đổi,hạnh phúc vô biên.”<end>", nStayTime = 1}},
		[3] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "tục ngữ có câu, hữu duyên thiên lý năng tương ngộ.", nStayTime = 3}},
		[4] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "các ngươi đều kiệt xuất nổi bật nên vừa gặp đã thích vừa nhìn đã yêu.", nStayTime = 3}},
		[5] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Hai trái tim cùng chung nhịp đập.", nStayTime = 3}},
		[6] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ngọn lửa tình yêu rực cháy.", nStayTime = 3}},
		[7] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Các ngươi đã yêu nhau.", nStayTime = 2}},		
		[8] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Đồng ý đồng lòng.", nStayTime = 2}},
		[9] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Các ngươi kết giao là một đôi trời đất tạo ra.", nStayTime = 3}},
		[10] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Khi cuộc sống mới bắt đầu.", nStayTime = 3}},
		[11] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Ta hy vọng đại hiệp,nữ hiệp cảm thông chia sẻ với nhau.", nStayTime = 3}},		
		[12] = {nOpt = tbManager.OP_MSG_CHAT, tbInfo = {szMsg = "Chân tình không đổi,hạnh phúc vô biên.", nStayTime = 1}},
		[13] = {nOpt = tbManager.OP_SKILL, tbInfo = {nSkillId = 1561, tbSkillPos = {1591, 3216} , nStayTime = 3}},
		[14] = {nOpt = tbManager.OP_MSG_INFOBOARD, tbInfo = {szMsg = "Đại văn hào<color=red>Tân Khí Tật<color>chúc các ngươi chân tình không đổi,hạnh phúc vô biên!", nStayTime = 1}},
		[15] = {nOpt = tbManager.OP_MSG_CHANNEL, tbInfo = {szMsg = "Đại văn hào<color=gold>Tân Khí Tật<color>chúc các ngươi chân tình không đổi,hạnh phúc vô biên!", nStayTime = 8}},
		},
	},
	}
	
--=============================================================
	
function tbManager:Open(nMapId)
	local tbVisitorNpcPos = self:GetVisitorPos(nMapId);
	if (not tbVisitorNpcPos) then
		return;
	end	
	Marry:SetPerformState(nMapId, 1);
	
	local nTimerId = Timer:Register(1, self.Perform, self, nMapId, tbVisitorNpcPos);
	Marry:AddSpecTimer(nMapId, "visitornpc", nTimerId);
end

function tbManager:GetVisitorPos(nMapId)
	local nMapLevel = Marry:GetWeddingMapLevel(nMapId);
	if (not self.TB_PATH_POSFILE[nMapLevel]) then
		return;
	end
	local tbPosSetting = Lib:LoadTabFile(self.TB_PATH_POSFILE[nMapLevel]);
	
	local tbPos = {};
	-- 加载来访npc坐标
	for nRow, tbRowData in pairs(tbPosSetting) do
		local tbTemp = {};
		tbTemp[1] = tonumber(tbRowData["PosX"]);
		tbTemp[2] = tonumber(tbRowData["PosY"]);
		table.insert(tbPos, tbTemp);
	end
	return tbPos;
end

-- 来访npc表演
function tbManager:Perform(nMapId, tbVisitorNpcPos)
	local tbCurNpcInfo = self:GetCurNpcInfo(nMapId, tbVisitorNpcPos);
	if (not tbCurNpcInfo) then
		Marry:SetPerformState(nMapId, 0);
		return 0;
	end
	
	local nNpcIndex = tbCurNpcInfo.nNpcIndex;
	local nCurSkillIndex = tbCurNpcInfo.nCurSkillIndex
	local nWeddingMapLevel = Marry:GetWeddingMapLevel(nMapId);
	local nNpcTemplateId = self.TB_NPCID[nWeddingMapLevel][nNpcIndex];
	local tbCurInfo = self.TB_OPT[nWeddingMapLevel][nNpcTemplateId][nCurSkillIndex];
	local nNpcId = tbCurNpcInfo.nNpcId;
	
	if (not nNpcId and not tbCurInfo) then
		Marry:SetPerformState(nMapId, 0);
		return 0;
	end
	
	local nNextTime = self:Play(nMapId, nNpcId, tbCurInfo);
	return nNextTime;
	-- return self:Play(nMapId, nNpcId, tbCurInfo);
end

-- 获取当前npc的操作信息（返回值pNpc, tbInfo）
function tbManager:GetCurNpcInfo(nMapId, tbVisitorNpcPos)
	local tbCurNpcInfo = Marry:GetVisitorNpc(nMapId);
	-- 头一次召唤来访npc
	if (not tbCurNpcInfo) then
		return self:AddNewVisitorNpc(nMapId, 0, tbVisitorNpcPos);
	end
	
	local nNpcIndex = tbCurNpcInfo.nNpcIndex;
	local nNpcId = tbCurNpcInfo.nNpcId;
	local nCurSkillIndex = tbCurNpcInfo.nCurSkillIndex + 1;
	local nWeddingMapLevel = Marry:GetWeddingMapLevel(nMapId);
	local nNpcTemplateId = self.TB_NPCID[nWeddingMapLevel][nNpcIndex];
	local tbCurOpt = self.TB_OPT[nWeddingMapLevel][nNpcTemplateId][nCurSkillIndex];
	-- 每一个来访npc表演完之后，召唤下一个npc继续
	if (not tbCurOpt) then
		return self:AddNewVisitorNpc(nMapId, nNpcIndex, tbVisitorNpcPos);
	end
	
	-- 当前的来访npc还没有表演完，继续进行下一个步骤的表演
	tbCurNpcInfo.nCurSkillIndex = nCurSkillIndex;
	Marry:SetVisitorNpc(nMapId, tbCurNpcInfo);
	return tbCurNpcInfo;
end

-- 增加一个新的来访npc
function tbManager:AddNewVisitorNpc(nMapId, nCurNpcIndex, tbVisitorNpcPos)
	local nNpcIndex = nCurNpcIndex + 1;
	local nWeddingMapLevel = Marry:GetWeddingMapLevel(nMapId);
	if (not self.TB_NPCID[nWeddingMapLevel][nNpcIndex] or not tbVisitorNpcPos) then
		return;
	end

	local nNpcTemplateId = self.TB_NPCID[nWeddingMapLevel][nNpcIndex];
	local tbNpcPos = tbVisitorNpcPos[nNpcIndex];
	if (not tbNpcPos) then
		return;
	end
	local pNpc = KNpc.Add2(nNpcTemplateId , 120, -1, nMapId, unpack(tbNpcPos));
	if (not pNpc) then
		return;
	end
	
	local tbNpcInfo = {};
	tbNpcInfo.nNpcIndex = nNpcIndex;
	tbNpcInfo.nNpcId = pNpc.dwId;
	tbNpcInfo.nCurSkillIndex = 1;
	
	Marry:SetVisitorNpc(nMapId, tbNpcInfo);
	
	return tbNpcInfo;
end

function tbManager:Play(nMapId, nNpcId, tbCurInfo)
	local nStayTime = 0;
	local nOptType = tbCurInfo.nOpt;
	if (self.OP_MSG_CHAT == nOptType) then
		nStayTime = self:Play_SendChat(nNpcId, tbCurInfo.tbInfo);
	elseif (self.OP_MSG_FILM == nOptType) then
		nStayTime = self:Play_Film(nMapId, tbCurInfo.tbInfo);
	elseif (self.OP_MSG_HEITIAO == nOptType) then
		nStayTime = self:Play_Heitiao(nMapId, tbCurInfo.tbInfo);
	elseif (self.OP_MSG_CHANNEL == nOptType) then
		nStayTime = self:Play_Channel(nMapId, nNpcId, tbCurInfo.tbInfo);
	elseif (self.OP_MSG_INFOBOARD == nOptType) then
		nStayTime = self:Play_InfoBordMsg(nMapId, tbCurInfo.tbInfo);
	elseif (self.OP_SKILL == nOptType) then
		nStayTime = self:Play_CastSkill(nNpcId, tbCurInfo.tbInfo);
	end
	return nStayTime * Env.GAME_FPS;
end

function tbManager:GetAllPlayers(nMapId)
	local tbPlayerList = Marry:GetAllPlayers(nMapId) or {};
	return tbPlayerList;
end

-- 表演（头顶上说话）
function tbManager:Play_SendChat(nNpcId, tbCurInfo)
	local pNpc = KNpc.GetById(nNpcId);
	if (pNpc) then
		pNpc.SendChat(tbCurInfo.szMsg);
	end
	return tbCurInfo.nStayTime;
end

-- 表演（电影模式）
function tbManager:Play_Film(nMapId, tbCurInfo)
	local tbPlayerList = self:GetAllPlayers(nMapId);
	for _, pPlayer in pairs(tbPlayerList) do
		Setting:SetGlobalObj(pPlayer);
		TaskAct:Talk(tbCurInfo.szMsg);
		Setting:RestoreGlobalObj();
	end
	return tbCurInfo.nStayTime;
end

-- 表演（黑条信息）
function tbManager:Play_Heitiao(nMapId, tbCurInfo)
	local tbPlayerList = self:GetAllPlayers(nMapId);
	for _, pPlayer in pairs(tbPlayerList) do
		Dialog:SendBlackBoardMsg(pPlayer, tbCurInfo.szMsg);
	end
	return tbCurInfo.nStayTime;
end

-- 表演（聊天频道信息）
function tbManager:Play_Channel(nMapId, nNpcId, tbCurInfo)
	local tbPlayerList = self:GetAllPlayers(nMapId);
	local pNpc = KNpc.GetById(nNpcId);
	for _, pPlayer in pairs(tbPlayerList) do
		Setting:SetGlobalObj(pPlayer);
		me.Msg(tbCurInfo.szMsg, pNpc.szName);
		Setting:RestoreGlobalObj();
	end
	return tbCurInfo.nStayTime;
end

function tbManager:Play_InfoBordMsg(nMapId, tbCurInfo)
	local tbPlayerList = self:GetAllPlayers(nMapId);
	local szMsg = string.format("<color=yellow>%s<color>", tbCurInfo.szMsg)
	for _, pPlayer in pairs(tbPlayerList) do
		Dialog:SendInfoBoardMsg(pPlayer, szMsg);
	end
	return tbCurInfo.nStayTime;
end

-- 表演（释放技能）
function tbManager:Play_CastSkill(nNpcId, tbCurInfo)
	local pNpc = KNpc.GetById(nNpcId);
	if (pNpc) then
		pNpc.CastSkill(tbCurInfo.nSkillId, 1, unpack(tbCurInfo.tbSkillPos));
	end
	return tbCurInfo.nStayTime;
end
