-------------------------------------------------------
-- 文件名　：marry_talk.lua
-- 创建者　：zhangjinpin@kingsoft
-- 创建时间：2010-01-05 01:26:15
-- 文件描述：
-------------------------------------------------------

Require("\\script\\marry\\logic\\marry_def.lua");

if (not MODULE_GAMESERVER) then
	return 0;
end

Marry.tbNpcTalk = 
{
	[1] = 
	{
		[6500] = 
		{
			[1] = {"Trẫm tới rồi, trẫm tới rồi, các vị ái khanh bình thân."},
			[2] = {"Hôm nay là ngày quan trọng của%svà%s", 1},
			[3] = {"Trẫm hôm nay giành thời gian đến đây cử hành buổi lễ cho hai khanh "},
			[4] = {"Hy vọng hai khanh từ nay về sau"},
			[5] = {"luôn vui vẻ"},
			[6] = {"bình an, hòa hợp"},
			[7] = {"Biển cạn đá mòn vẫn đồng tâm"},
			[8] = {"Đất rộng trời cao cùng nhau cất cánh"},
			[9] = {"Hãy nhớ rõ, ta rất yêu mến hai khanh"},
		},
		[6501] = 
		{
			[1] = {"Tuổi già chân tay không linh hoạt nữa rồi."},
			[2] = {"Đến chậm một bước xin các vị thứ lỗi"},
			[3] = {"Nói một chút nhé？"},
			[4] = {"Đàn ông phải hiểu phụ nữ chút, làm phụ nữ không dễ dàng."},
			[5] = {"Phụ nữ phải quan hệ tốt với mẹ chồng, giúp chồng, dạy con"},
			[6] = {"Hai trái tim trăm năm ân ái"},
			[7] = {"Nghìn năm nhân duyên một mối"},
			[8] = {"Chúc mừng！"},
		},
		[6502] = 
		{
			[1] = {"Hôm nay, ánh mặt trời chiếu rọi, mối lương duyên trời ban"},
			[2] = {"Bằng hữu sum vầy, cùng nhau chúc phúc "},
			[3] = {"Trong ngày vui hôm nay"},
			[4] = {"Ta trân trọng thay mặt các vị thủ lĩnh Khu Mật viện, Hàn Lâm viện,"},
			[5] = {"Giành những lời chúc nhiệt tình và tốt đẹp nhất đến hai vị"},
			[6] = {"Hy vọng hai vị từ nay về sau "},
			[7] = {"Có thể chăm chỉ làm việc,tôn trọng lẫn nhau、"},
			[8] = {"Hiếu thuận với người già, yêu thương con cái"},
			[9] = {"Sự nghiệp phát triển, gia đình đầm ấm."},
			[10] = {"Cám ơn "},
		},
		[6503] = 
		{
			[1] = {"Hôm nay là một ngày vui lớn"},
			[2] = {"Hôm nay là một ngày ấm áp,"},
			[3] = {"Đối với hai vị ,hôm nay là ngày khó quên trong đời"},
			[4] = {"Dùng đôi mắt sáng của các bạn tận hưởng không gian vô hạn"},
			[5] = {"Dùng lý tưởng đẹp đẽ của các bạn đi tận hưởng tuổi trẻ"},
			[6] = {"Dùng bước chân mềm mại để tận hưởng cuộc sống lung linh trên thảm cỏ thơm"},
			[7] = {"Dùng ý chí quên đi mọi chông gai,phiền não trong cuộc sống,"},
			[8] = {"Dùng tình yêu trong sáng của các bạn để sưởi ấm tuổi già của cha mẹ"},
			[9] = {"Tuổi trẻ thật tốt!"},
		},
		[6504] = 
		{
			[1] = {"Vì sự có mặt của bạn"},
			[2] = {"Cô đơn tự tiêu tan."},
			[3] = {"Vì có bạn"},
			[4] = {"Bao nhiêu niềm vui tự đến"},
			[5] = {"Chúc các bạn cùng tận hưởng tình yêu"},
			[6] = {"Cùng vượt qua sương gió, sống đến bạc đầu."},
			[7] = {"Chúc các bạn tuổi xuân đẹp đẽ,"},
			[8] = {"Cuộc đời viên mãn, không có gì phải hối tiếc！"}, 
			[9] = {"Hôm nay là thời khắc hai lữ hiệp bước vào lễ đường thần thánh"},
			[10] = {"Tôi thay mặt các vị quan khách chúc phúc cho hai người"},
			[11] = {"Hạnh phúc viên mãn, mãi mãi cùng trời đất"},
		},
		[6505] = 
		{
			[1] = {"Đây là mùa lãng mạn,"},
			[2] = {"Đại nữ hiệp ôm một giấc mộng tình yêu ngọt ngào."},
			[3] = {"Đây là thời khắc làm say lòng người"},
			[4] = {"Đại nữ hiệp đón một mùa xuân hạnh phúc và ấm áp"},
			[5] = {"Để chào đón mùa xuân này đến,"},
			[6] = {"Hoa tươi mỉm cười mà khoe sắc"},
			[7] = {"Để chào đón thời khắc này đến"},
			[8] = {"Ánh sao đêm nay tỏa sáng"},
			[9] = {"Chúc phúc hai lữ hiệp trở thành phu thê"},
			[10] = {"Cám ơn tất cả những người quan tâm và yêu mến hai bạn"},
		},
		[6506] = 
		{
			[1] = {"Tục ngữ nói:Có duyên nghìn năm sẽ gặp lại"},
			[2] = {"Hai lữ hiệp đều xuất sắc, nên khi vừa gặp nhau"},
			[3] = {"Đã tâm đầu ý hợp, vùa gặp đã xiêu lòng,"},
			[4] = {"Hai trái tim cùng chung nhịp đập"},
			[5] = {"tình yêu rực cháy"},
			[6] = {"Hai lữ hiệp gặp nhau, đồng ý đồng lòng"},
			[7] = {"Hai lữ hiệp kết giao là một đôi trời đất tạo ra"},
			[8] = {"Khi cuộc sống mới của họ bắt đầu,"},
			[9] = {"Tôi hy vọng đại hiệp,nữ hiệp hiểu nhau, thông cảm lẫn nhau "},
			[10] = {"Chân tình không đổi, hạnh phúc vô biên"},
		},
		[6507] = 
		{
			[1] = {"Các tiểu tử, lão phu đã đến."},
			[2] = {"Chúc hai người viên mãn đến bạc đầu"},
			[3] = {"Một ngày kết thành mối tình"},
			[4] = {"Trăm năm không đổi một trái tim"},
			[5] = {"Trên đường đời dài mênh mông"},
			[6] = {"Cùng bầu bạn, chỗ dựa cho nhau"},
			[7] = {"Bên nhau bất kể lúc an nhàn hay sương gió"},
			[8] = {"Nhiệm vụ còn đang chờ tôi"},
			[9] = {"Thời gian đến, sáng lên！"},
		},
		[6508] = 
		{
			[1] = {"Cho chúng tôi hạnh phúc mà nhảy múa"},
			[2] = {"Hát ca vì niềm vui của đôi bạn"},
			[3] = {"Nâng cốc vì tình yêu nồng thắm"},
			[4] = {"Chúc hai bạn trên đường đời luôn chói sáng tình yêu "},
			[5] = {"Tận hưởng mỹ vị trong thiên hạ đừng để lãng phí"},
			[6] = {"Tận hưởng rượu ngon trong thiên hạ đừng để say"},
			[7] = {"Mời mọi người nâng cốc, dùng tiệc"},
		},
		[6509] = 
		{
			[1] = {"Hai bạn nếu như lâu dài"},
			[2] = {"Sớm sớm chiều chiều."},
			[3] = {"Chỉ cần chân tình, thuần khiết"},
			[4] = {"Hoa nở hoa tàn cũng mãi đẹp"},
			[5] = {"Chỉ cần tình cảm chân thực,"},
			[6] = {"Trăng tròn trăng khuyết rồi lại tròn"}, 
			[7] = {"Chỉ cần tâm tâm tương đồng"},
			[8] = {"Núi xa sông xa cũng không thấy xa"},
			[9] = {"Chỉ cần tôn trọng nhau như khách,"}, 
			[10] = {"Nghìn khó vạn khó cũng không sợ"},
			[11] = {"La Quý Kỷ, có thể hiểu tôi không？"},
		},
	},
	[2] = 
	{
		[3506] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa"},
			[3] = {"Trong chùa có lão hòa thượng"}, 
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"} 
		},
		[3542] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3579] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3585] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3554] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3530] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3536] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3548] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3560] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3590] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3595] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3512] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3518] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3524] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
	},
	[3] = 
	{
		[2425] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[4184] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[2426] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3316] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[4665] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[2422] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[2423] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[2424] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[4002] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3244] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3227] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3228] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3301] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3245] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3247] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3250] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3320] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
	},
	[4] = 
	{
		[3561] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3562] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3563] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3564] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3565] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3566] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3567] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3568] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3569] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3576] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3601] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3603] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[4041] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[4042] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[2607] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[2608] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[2606] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
	},
	[5] = 
	{
		[80] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[81] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3590] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3591] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[76] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3234] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3237] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[4237] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3230] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[3655] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[41] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[161] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[193] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[199] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[228] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
		[245] = 
		{
			[1] = {"Phía trước có ngọn núi."},
			[2] = {"Trên núi có ngôi chùa."},
			[3] = {"Trong chùa có lão hòa thượng"},
			[4] = {"còn có tiểu hòa thượng"},
			[5] = {"lão hòa thượng đang kể chuyện cho tiểu hòa thượng nghe"},
			[6] = {"Kể chuyện gì?"},
			[7] = {"NPC kể cho bạn biết dưới đây"},
		},
	}
};

