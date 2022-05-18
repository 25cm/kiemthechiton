local tbAdviceBook = Item:GetClass("advicebook");

tbAdviceBook.szInfo = "    Sống trong giang hồ hiểm ác, dựa vào sức mạnh cá nhân sẽ không chống đỡ nổi. Phải mở rộng quan hệ với hiệp khách khác, dựa vào sức mạnh tập thể mới vượt qua được.\n"


function tbAdviceBook:OnUse()
	local tbOpt = {};
	tbOpt = Lib:MergeTable( tbOpt,{
			{"Làm sao tán gẫu",	self.LiaoTian, self },
			{"Làm sao thêm bạn tốt",	self.JiaHaoYou, self },
			{"Làm sao tổ đội",	self.ZuDui, self},
			{"Đóng"},
	});
			
	Dialog:Say(self.szInfo,tbOpt);
	
	return 0;
end;

function tbAdviceBook:LiaoTian()
   
  local tbOpt = {};
  tbOpt = Lib:MergeTable( tbOpt,{
			{"Trở về",  self.OnUse, self},
			{"Đóng"},
	});
   
  Dialog:Say("    <color=gold>Nhấn Enter mở khung tán gẫu.<color> Ở khung tán gẫu góc trái sẽ xuất hiện con trỏ chuột.\n"..
  	         "     Nhấn chữ \"LC\" sẽ hiện ra tất cả kênh tán gẫu. <color=gold>Cấp 10 gia nhập môn phái có thể dùng \"Tán gẫu môn phái\", cấp 30 dùng \"Tán gẫu chung\", cấp 55 dùng \"Tán gẫu thành thị\".<color> Sau khi chọn kênh tán gẫu, đánh chữ vào khung, nhấn enter là gởi.\n"..
  	         "    <color=gold>Cách mở tán gẫu riêng (cá nhân): \n"..
  	         "    1. Ở khung tán gẫu nhập\"/tên đối phương\", enter.\n"..
  	         "    2. Ở kênh tán gẫu nhấn \"Ctrl+chuột trái\" vào tên đối phương.\n"..
  	         "    3. Nhấn \"Ctrl+chuột phải\" vào tên đối phương, chọn \"Tán gẫu\".<color>\n"..
             "    Nhấn chọn biểu cảm sẽ giúp cuộc đối thoại thêm phong phú."
  ,tbOpt);
  	     
  return 0;
end;

function tbAdviceBook:JiaHaoYou()
   
  local tbOpt = {};
  tbOpt = Lib:MergeTable( tbOpt,{
			{"Trở về",  self.OnUse, self},
			{"Đóng"},
	});
   
  Dialog:Say("    Giang hồ nữ nhi vào Nam ra Bắc, chẳng lẽ không có hảo hữu?\n"..
  	         "    <color=gold>Cách thêm hảo hữu:\n"..
  	         "    1. 	Ở kênh chat nhấn chuột trái vào tên đối phương, chọn \"Bạn\".\n"..
  	         "    2. Nhấn \"Ctrl + chuột phải\" vào tên đối phương trong màn hình trò chơi, chọn \"Bạn\".\n"..
  	         "    3. 	Nhấn F5 mở giao diện quan hệ, chọn \"Bạn\".<color>\n"..
  	         "    Hệ thống sẽ gửi lời mời kết hảo hữu, người được mời là <color=gold>hảo hữu tạm thời (chữ trắng)<color>. Cả hai cùng thao tác tự động đổi thành <color=gold>hảo hữu chính thức (chữ vàng)<color>.\n"..
             "    <color=gold>Hảo hữu chính thức tổ đội luyện cấp để tăng độ thân mật.<color> Là điều kiện để thành thành viên gia tộc và mật hữu."
  ,tbOpt);
  	     
  return 0;
end;


function tbAdviceBook:ZuDui()
   
  local tbOpt = {};
  tbOpt = Lib:MergeTable( tbOpt,{
			{"Trở về",  self.OnUse, self},
			{"Đóng"},
	});
   
  Dialog:Say("    Lợi ích của tổ đội là mọi người hưởng được nhiều kinh nghiệm đánh quái, thăng cấp nhanh hơn. <color=gold>Tổ đội cùng làm nhiệm vụ sẽ có lợi hơn.<color>\n"..
  	         "    Cách lập nhóm:\n"..
  	         "    <color=gold>1. Nhấn \"Ctrl + chuột phải\" vào người chơi muốn lập tổ đội, chọn tổ đội hoặc nhập đội trong hộp thoại.<color> Mời tổ đội khác sẽ tự động lập thành nhóm và mình thành nhóm trưởng, <color=gold>trên đầu nhóm trưởng có biểu tượng cờ đỏ.<color>\n"..
  	         "    <color=gold>2. Nhấn nút tổ đội trên giao diện hoặc phím P để mở bảng tổ đội.<color> Có thể nhập thông tin và xem thông tin trong bảng này. Sau khi lập nhóm, nhóm trưởng vào \"Chiêu mộ thành viên\" chọn \"Thêm tên\" để thêm đồng đội."

  ,tbOpt);
  	     
  return 0;
end;
