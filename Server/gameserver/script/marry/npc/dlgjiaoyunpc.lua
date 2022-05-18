-- 文件名　：dlgjiaoyunpc.lua
-- 创建者　：furuilei
-- 创建时间：2010-01-13 11:37:53
-- 功能描述：典礼相关npc（提供对话选项的教育npc）

local tbNpc = Npc:GetClass("marry_dlgjiaoyunpc");

function tbNpc:OnDialog()
	if (Marry:CheckState() == 0) then
		return 0;
	end
	local szMsg = "   Xin hãy trân trọng thời khắc này.";
	local tbOpt = {
		{"<color=gold>Giới thiệu hệ thống Hiệp Lữ<color>", self.GetJiaoyuMsg1, self},
		{"<color=gold>Tìm hiểu Hoa Tình<color>", self.GetJiaoyuMsg2, self},
		{"<color=gold>Quy trình Điểm Lễ<color>", self.GetJiaoyuMsg3, self},
		{"<color=gold>Lợi ích của Điểm Lễ<color>", self.GetJiaoyuMsg4, self},
		{"<color=gold>Các NPC liên quan<color>", self.GetJiaoyuMsg5, self},
		{"<color=gold>Lễ cưới và tiệc cưới<color>", self.GetJiaoyuMsg6, self},
		{"Ta đã hiểu hết rồi"}
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:GetJiaoyuMsg1()
	me.SetTask(1022,216,1,1);
	local szMsg = [[
<color=green>[Điều kiện điểm lễ]<color>
    1, Hai bên nam nữ đều phải đạt cấp <color=yellow>69<color>
    2, Hai bên nam nữ đều phải ở trạng thái <color=yellow>độc thân<color>, không có nạp cát, quan hệ hiệp lữ
    3, <color=yellow>Độ thân mật<color> của hai bên đạt cấp <color=yellow>3<color>.
]];
  	local tbOpt = { 
    	{"Trở về", self.OnDialog, self}
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:GetJiaoyuMsg2()
	me.SetTask(1022,217,1,1);
	local szMsg = [[
<color=green>[Tác dụng của Hoa Tình]<color>
    Trong các loại đạo cụ để kết thành hiệp lữ đều cần <color=yellow>Hoa Tình<color>, Sau khi có Hoa Tình có thể mua được vật phẩm ở chỗ Thương nhân Điểm Lễ-Vạn Hữu Toàn

<color=green>[Làm cách nào để nhận được Hoa Tình]<color>
    1, Vào <color=yellow>Kỳ Trân Các <color> mua Hoa Tình, đây là cách <color=yellow>nhanh nhất<color> nhận được Hoa Tình.
    2, Hoàn thành <color=yellow>Tiêu Dao Cốc ải 3 trở lên<color>, sẽ có xác suất nhận được <color=yellow>Hoa Tình<color>, Sau khi thu thập nhận được 1 <color=yellow>Nhụy Hoa Tình<color>；
       Kỹ năng sống đạt đến cấp <color=yellow>60<color> sẽ học được cách chế tao Nhụy Hoa Tình, tiêu hao <color=yellow>150<color> tinh, hoạt lực sẽ nhận được <color=yellow>Hoa Tình khóa<color>。
]];
  	local tbOpt = { 
    	{"Trở về", self.OnDialog, self}
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:GetJiaoyuMsg3()
	me.SetTask(1022,218,1,1);
	local szMsg = [[
<color=green>[Nạp Cát]<color>
    1, Dùng <color=yellow>Hoa Tình<color> đến Giang Tân Thôn chỗ <color=yellow>Vạn Hữu Toàn<color> mua Túi Nạp Cát. <color=yellow>Chỉ cần 1 người mua là được.<color>
    2, Nhấp chuột phải vào Túi Nạp Cát nhận được <color=yellow>Thẻ Nạp Cát<color>.
    3, Hai bên nam nữ tổ đội, một bên dùng <color=yellow>Thẻ Nạp Cát<color> tiếp hành Nạp Cát. Bên kia đồng ý là được.
<color=green>[Điển Lễ]<color>
    1, Sau khi nạp cát thành công, <color=yellow>Bên nam<color> dùng Hoa Tình đến Giang Tân Thôn chỗ Vạn Hữu Toàn để mua <color=yellow>Túi Quà Lễ<color>, Nếu bên nữ lỡ tay mua có thể nhấp chuột phải đổi lại Hoa Tình.
    2, Hai bên nam nữ tổ đội, Bên nam dùng túi quà đến Giang Tân Thôn chỗ <color=yellow>Nguyệt Lão<color> đặt trước <color=yellow>Lễ Vật<color>.
]];
	local tbOpt = { 
    	{"Trở về", self.OnDialog, self}
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:GetJiaoyuMsg4()
	me.SetTask(1022,219,1,1);
	local szMsg = [[

	<color=green>[điển lễ thật là tốt chỗ]<color>

	Nhượng lão nguyệt chứng kiến các ngươi trong lúc đó đích tình ý ba! Trở thành hiệp lữ hậu nâm còn nghĩ thu được các loại duy trì liên tục tính thật là tốt chỗ:

	1, <color=yellow> chuyên chúc xưng hào. <color> nạp cát, tổ chức điển lễ hậu quân hữu xưng hào cho thấy thân phận, nói cho người khác ngươi đã lòng có tương ứng liễu!

	2, <color=yellow> hiệp lữ tọa kỵ. <color> bạch hổ hoan hoan, bạch lộc hỉ hỉ cùng các ngươi làm bạn đáo thiên nhai, nhượng thế nhân chứng kiến các ngươi cảm thiên động địa đích ái tình. <color=yellow>( cận hoàng gia điển lễ lễ bao đặc biệt )<color>

	3, <color=yellow> xa hoa hiệp lữ tín vật. <color> hiệp lữ tín vật mỹ lệ hựu lợi ích thực tế. Sử dụng hiệp lữ tín vật tức khả thu được <color=yellow> ý hợp tâm đầu, hiệp lữ tọa kỵ, hiệp lữ truyền tống, kinh nghiệm gia thành, hiệp lữ quang hoàn <color>. ( bất đồng đẳng cấp đích hiệp lữ tín vật khả thu được đích công năng bất đồng )

	Tình hình cụ thể và tỉ mỉ thỉnh tìm đọc F12 bang trợ túi gấm lý đích kể lại bang trợ.

	]];
  	local tbOpt = { 
    	{"Trở về", self.OnDialog, self}
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:GetJiaoyuMsg5()
	me.SetTask(1022,220,1,1);
	local szMsg = [[
<color=green>[Nguyệt Lão]<color>
   Nguyệt Lão ở Giang Tân Thôn là nhân vật không thể thiếu trong quá trình Điển Lễ. Đến đó để:
    1, Chọn ngày Điển Lễ
    2, Tham Gia Điển Lễ
    3, Xem lịch Điển Lễ gần nhất
    4, Tham quan sân khấu Điển Lễ
    5, Sau khi cử hành Điển Lễ, nhận Tín vật Hiệp Lữ

<color=green>[Thương Nhân Hôn Lễ Vạn Hữu Toàn<color>
    Giang Tân Thôn-Thương nhân hôn lễ Vạn Hữu Toàn có bán các vật phẩm cần trong hôn lễ như: túi nạp cát, sính lễ, pháo hoa ... Chỉ cần người chơi có <color=yellow>Hoa Tình<color> là được.
    Hoa Tình có thể mua trên Kỳ Trân Các hoặc tham gia Tiêu Dao Cốc để thu thập Nhụy Hoa chế tạo thành.

<color=green>[Hồng Di]<color>
    Sau khi nạp cát thành công, nếu hối hận với sự lựa chọn của mình có thể đến NPC Hồng Di
    <color=yellow>Xin Giải Trừ Nạp Cát<color>
]];
  	local tbOpt = { 
    	{"Trở về", self.OnDialog, self}
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:GetJiaoyuMsg6()
	me.SetTask(1022,221,1,1);
	local szMsg = [[
<color=green>[Quy trình Điểm Lễ]<color>

    Khu Điển Lễ luôn mở từ <color=yellow>12h đến 7h sáng hôm sau.<color> Sau thời gian đó sẽ tự động đóng.
    
    1, <color=red>Chuẩn bị: <color>Hai vị hiệp lữ và khác đi và Khu Điển Lễ, khách có thể <color=yellow>Tặng Chúc Phúc<color> ở chỗ Người Nhận Lễ
    2, <color=red>Bắt đầu: <color>Huynh đệ kết nghĩa, mật hữu hoặc hai vị hiệp lữ nhấp vào Người Chủ Trì Điển Lễ Cát Tường để bắt đầu.
    3, <color=red>Bái đường: <color>Các NPC trong trò chơi sẽ đến chúc mừng, hai vị hiệp lữ bái đường, khách bắn pháo hoa chúc mừng.
    4, <color=red>Yến tiệc: <color>Khách có thể nhấp vào món ăn trên bàn, sau khi căn được phần thưởng nhất định. Lúc này hai vị hiệp lữ có thẻ đến giữa bàn tiệc tìm "Phúc Lâm Môn" mở trò chơi nhỏ.
    5, <color=red>Thời Gian: <color>Khu Điển Lễ luôn mở từ <color=yellow>12h đến 7h sáng hôm sau.<color> Sau thời gian đó sẽ tự động đóng.
]];
  	local tbOpt = { 
   	 	{"Trở về", self.OnDialog, self}
	};
	Dialog:Say(szMsg, tbOpt);
end
