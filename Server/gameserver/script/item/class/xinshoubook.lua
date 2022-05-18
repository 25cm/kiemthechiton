-- 新手锦囊
local tbXinShouBook = Item:GetClass("xinshoubook");

tbXinShouBook.szInfo = "        Ngươi trước khi bước chân vào giang hồ, phải nắm vững một số kiến thức. Khi gặp phải nghi vấn, hãy đến đây tìm đọc thông tin, có thể sẽ tìm được đáp án.\n"..
"    Nếu không thận trọng mất đi Cẩm nang, có thể <color=gold>nhấp vào dấu hỏi ở góc trái trên cùng<color>, hoặc <color=gold>ấn phím F12 để mở giao diện Cẩm nang trợ giúp<color>, mục <color=gold>chi tiết<color> cung cấp rất nhiều loại thông tin.\n"..
"                                                              Thu Di"


function tbXinShouBook:OnUse()
	local tbOpt = {};
	tbOpt = Lib:MergeTable( tbOpt,{
			{"Thao tác cơ bản",	self.JiBenCaoZuo, self },
			{"Thao tác chiến đấu",	self.ZhanDouCaoZuo, self },
			{"Gia nhập môn phái",	self.JiaRuMenPai, self},
			{"Hệ thống ngũ hành",	self.WuXingXiTong, self},
			{"Hướng dẫn đường đi",  self.JiaoTongZhiNan, self},
			{"Hướng dẫn luyện cấp",  self.LianJiZhiNan, self},
			{"Hồng phúc trời ban",  self.TianCiHongFu, self},
			{"Đóng"},
	});
			
	Dialog:Say(self.szInfo,tbOpt);
	
	return 0;
end;

function tbXinShouBook:JiBenCaoZuo()
   
  local tbOpt = {};
  tbOpt = Lib:MergeTable( tbOpt,{
			{"Trở về",  self.OnUse, self},
			{"Đóng"},
	});
   
  Dialog:Say("    <color=yellow>Di chuyển<color>: Nhấp chuột trái lên mặt đất. Nhấn <color=gold>R<color> để đi bộ/chạy bộ.\n"..
  	         "    <color=yellow>Đối thoại NPC<color>: Nhấp chuột trái lên npc. Trên đầu có dấu ! là có nhiệm vụ để nhận, dấu ? để giao.\n"..
  	         "    <color=yellow>Xem nhiệm vụ<color>: Nhấn <color=gold>F4<color> mở bảng nhiệm vụ. Nhấp <color=gold>chữ vàng gạch dưới<color> tự tìm đường. Trong <color=gold>Hướng dẫn<color> đưa ra tất cả nhiệm vụ đẳng cấp hiện tại có thể nhận.\n"..
  	         "    <color=yellow>Xem bản đồ<color>: Nhấn <color=gold>Tab<color> mở bản đồ nhỏ. nhấn giữ chuột phải có thể kéo bản đồ. Nhấp nút <color=gold>khu vực<color> và <color=gold>Bản đồ thế giới<color> xem vị trí địa lý xung quanh, đường đi."
 
  ,tbOpt);
  	     
  return 0;
end;

function tbXinShouBook:ZhanDouCaoZuo()
   
  local tbOpt = {};
  tbOpt = Lib:MergeTable( tbOpt,{
			{"Trở về",  self.OnUse, self},
			{"Đóng"},
	});
   
  Dialog:Say(
  	"    <color=yellow>Tấn công<color>: <color=gold>Nhấp chuột trái hoặc chuột phải vào mục tiêu<color>. Bên dưới giao diện có thể thiết lập kỹ năng tấn công bằng phím trái phải. Sau khi gia nhập môn phái, nhấn F3 mở bảng kỹ năng để tăng kỹ năng môn phái.\n"..
  	"    <color=yellow>Phục hồi chiến đấu<color>: <color=gold>Chỗ Chủ Tửu Lầu có bán thức ăn<color> dùng khi luyện cấp. <color=gold>Tiệm thuốc có bán thuốc<color> dùng để PK.\n"..
  	"    <color=yellow>Thanh phím tắt<color>: Tất cả đạo cụ và chiêu thức sử dụng được đều có thể <color=gold>nhấp và kéo<color> đến thanh phím tắt, nhấn <color=gold>phím số<color> để sử dụng.\n"..
  	"    <color=yellow>Nhặt vật phẩm<color>: Nhấp chuột trái vào vật phẩm trên đất, hoặc nhấn <color=gold>phím khoảng trắng<color>. Nhấp và kéo nó ra khỏi hành trang để vứt bỏ.\n"..
  	"    <color=yellow>Trang bị<color>: <color=gold>Nhấp chuột phải<color> vào trang bị trong hành trang là có thể mặc nó lên người. <color=gold>Tất cả trang bị trên nhân vật đều được khóa, sau khi khóa sẽ không thể vứt bỏ mà chỉ được bán<color>."
  	,tbOpt);
  	     
  return 0;
end;



function tbXinShouBook:JiaRuMenPai()
   
  local tbOpt = {};
  tbOpt = Lib:MergeTable( tbOpt,{
			{"Trở về",  self.OnUse, self},
			{"Đóng"},
	});
   
  Dialog:Say(
  	"   Nhân vật đạt <color=gold>cấp 10<color>, <color=gold>Đệ tử tiếp dẫn của các phái<color> ở Tân Thủ Thôn sẽ đưa đến chỗ <color=gold>Chưởng môn<color> để gia nhập môn phái.\n"..
  	"   Mỗi phái chia làm 2 nhánh, sau khi gia nhập môn phái cần nâng điểm để chọn nhánh. Đến cấp 60 gặp Chưởng môn nhờ đưa đi Tẩy Tủy Đảo tẩy lại điểm.\n"..
  	"   Nhấn F12 mở cẩm nang tìm hiểu về môn phái, các thứ khác."
  	,tbOpt);
  	     
  return 0;
end;


function tbXinShouBook:WuXingXiTong()
   
  local tbOpt = {};
  tbOpt = Lib:MergeTable( tbOpt,{
			{"Phân chia môn phái ngũ hành",  self.WuXingHuaFen, self},
			{"Thứ tự kích hoạt trang bị",  self.JiHuoShunXu, self},
			{"Trở về",  self.OnUse, self},
			{"Đóng"},
	});
   
  Dialog:Say(
  	"    Ngũ hành gồm Kim, Mộc, Thủy, Hỏa, Thổ, tuân theo nguyên lý tương sinh tương khắc.\n\n"..
    "    <color=gold>Ngũ hành tương khắc: Kim khắc Mộc, Mộc khắc Thổ, Thổ khắc Thủy, Thủy khắc Hỏa, Hỏa khắc Kim.<color>\n"..
    "    <color=gold>Tất cả môn phái đều thuộc ngũ hành, tuân theo nguyên lý ngũ hành tương khắc.<color> Ví dụ, khi phái hệ Kim tấn công hệ Mộc sẽ được cộng điểm tấn công vượt mức, ngược lại sẽ được giảm mức độ sát thương. NPC trong trò chơi cũng có chia ngũ hành.\n\n"..
    "    <color=gold>Ngũ hành tương sinh: Kim sinh Thủy, Thủy sinh Mộc, Mộc sinh Hỏa, Hỏa sinh Thổ, Thổ sinh Kim.<color>\n"..
    "    <color=gold>Tất cả trang bị đều thuộc ngũ hành, tuân theo nguyên lý ngũ hành tương sinh.<color> Ví dụ, đao thuộc tính Hỏa cần trang bị thuộc tính Mộc mới kích hoạt được thuộc tính ẩn."
  	,tbOpt);
  	     
  return 0;
end;


function tbXinShouBook:WuXingHuaFen()
   
  local tbOpt = {};
  tbOpt = Lib:MergeTable( tbOpt,{
			{"Thứ tự kích hoạt trang bị",  self.JiHuoShunXu, self},
			{"Trở về",  self.OnUse, self},
			{"Đóng"},
	});
   
  Dialog:Say(
     "\n    <color=yellow>Hệ Kim: Thiên Vương, Thiếu Lâm<color>\n"..
     "    <color=green>Hệ Mộc: Đường Môn, Ngũ Độc, Minh Giáo<color>\n"..
     "    <color=turquoise>Hệ Thủy: Nga My, Thúy Yên, Đoàn Thị<color>\n"..
     "    <color=red>Hệ Hỏa: Cái Bang, Thiên Nhẫn<color>\n"..
     "    Hệ Thổ: Võ Đang, Côn Lôn"
  	,tbOpt);
  	     
  return 0;
end;

function tbXinShouBook:JiHuoShunXu()
   
  local tbOpt = {}; 
  tbOpt = Lib:MergeTable( tbOpt,{
			{"Phân chia môn phái ngũ hành",  self.WuXingHuaFen, self},
			{"Trở về",  self.OnUse, self},
			{"Đóng"},
	});
   
  Dialog:Say(
    "    <color=gold>Nhấn F1 mở bảng thuộc tính nhân vật, nhấp vào \"Đổi kiểu trang bị ngũ hành\",<color> có thể xem thứ tự kích hoạt các loại trang bị.\n\n"..
    "Nón và vũ khí, có thể kích hoạt giày và hộ thân phù.\n"..
    "Giày và hộ thân phù, có thể kích hoạt hộ uyển và ngọc bội.\n"..
    "Hộ uyển và ngọc bội, có thể kích hoạt yêu đái và nhẫn.\n"..
    "Yêu đái và nhẫn, có thể kích hoạt y phục và hạng liên.\n"..
    "Y phục và hạng liên, có thể kích hoạt nón và vũ khí.\n\n"..
    "    <color=gold>Tips trên trang bị có tiến cử môn phái,<color> làm theo gợi ý sẽ kích hoạt được ngũ hành tương sinh của trang bị."
  	,tbOpt);
  	     
  return 0;
end;


function tbXinShouBook:JiaoTongZhiNan()
  local tbOpt = {};
  tbOpt = Lib:MergeTable( tbOpt,{
			{"Trở về",  self.OnUse, self},
			{"Đóng"},
	});
   
  Dialog:Say(
     "    <color=gold>Mỗi Tân Thủ Thôn đều liên kết với môn phái và thành thị nhất định.<color> Nhấn Tab mở giao diện bản đồ, thông qua <color=gold>Bản đồ khu vực<color> và <color=gold>Bản đồ thế giới<color> có thể xem đường đi xung quanh Tân Thủ Thôn.\n"..
     "    <color=gold>Xa Phu ở các Tân Thủ Thôn và thành thị có thể đưa bạn qua lại.<color>\n"..
     "    Mỗi Tân Thủ Thôn đều có đệ tử tiếp nhận của 12 môn phái phụ trách đưa người chơi đến phái đó, đồng thời <color=gold>các Truyền Tống Môn Phái sẽ phụ trách đưa người chơi trở về Tân Thủ Thôn.<color>"
  	,tbOpt);
  	     
  return 0;
end;

function tbXinShouBook:LianJiZhiNan()
  
  local tbOpt = {};
  tbOpt = Lib:MergeTable( tbOpt,{
			{"Hướng dẫn luyện cấp",  self.LianJiDiTu, self},
			{"Trở về",  self.OnUse, self},
				{"Đóng"},
	});
   
  Dialog:Say(
     "    Ngoài các nhiệm vụ phong phú ra bạn còn có thể đi luyện cấp.\n\n"..
     "<color=yellow>Viên châu trong tay, tiềm lực vô hạn<color>\n"..
     "    Đạt <color=gold>cấp 20<color> gặp <color=gold>Chưởng môn<color> nhận <color=gold>Tu Luyện Châu<color>, sử dụng khi luyện cấp sẽ được thêm kinh nghiệm và may mắn.\n\n"..
     "<color=yellow>Chọn đối thủ luyện cấp phù hợp<color>\n"..
     "    Nhấn Tab mở giao diện bản đồ, nhấp mở khu vực bản đồ, sau tên bản đồ sẽ có ký hiệu cấp. <color=gold>Chữ đỏ chính là khu luyện cấp<color>. Luyện cấp phải đánh quái thường, tất cả quái nhiệm vụ chỉ nhận được 1 điểm kinh nghiệm, khi cấp nhân vật thấp hoặc cao hơn quái 5 cấp, kinh nghiệm nhận được sẽ giảm đáng kể.\n\n"..
     "<color=yellow>Khiêu chiến thủ lĩnh tinh anh, đốt lửa uống rượu càng thêm hăng<color>\n"..
     "    Bản đồ cấp 15 trở lên có quái <color=gold>Tinh anh<color> hoặc <color=gold>Thủ lĩnh<color>, sau khi tiêu diệt sẽ xuất hiện <color=gold>Lửa trại<color>, <color=gold>đốt lửa trại ở trạng thái tổ đội<color> nhận được phần thưởng kinh nghiệm vượt mức, kết hợp Tu Luyện Châu sẽ thăng cấp rất nhanh. <color=gold>Trạng thái Lửa trại, uống rượu sẽ được thêm kinh nghiệm.<color> Càng nhiều người trong tổ đội uống cùng 1 loại rượu, kinh nghiệm nhận được càng nhiều. <color=gold>Rượu nhặt được khi luyện cấp hoặc mua tại Kỳ Trân Các.<color>"
  	,tbOpt);
  	     
  return 0;
end;
	
function tbXinShouBook:LianJiDiTu()

	local tbOpt = {};
  tbOpt = Lib:MergeTable( tbOpt,{
			{"Trở về",  self.LianJiZhiNan, self},
		
			{"Đóng"},
	});
	Dialog:Say(
     "    <color=gold>Cấp 1 - 20<color> nên làm nhiệm vụ Chính tuyến để thăng cấp (tìm Bạch Thu Lâm ở các Tân Thủ Thôn để nhận), cũng có thể đánh quái luyện cấp ở bản đồ cấp 5 và 15 xung quanh Tân Thủ Thôn.\n"..
     "    <color=gold>Cấp 21 - 50<color> có thể đánh quái luyện cấp ở bản đồ cấp 25, 35, 45 xung quanh môn phái.\n"..    
     "    <color=gold>Cấp 50 - 90<color> có thể luyện cấp ở bản đồ xung quanh thành.\n"..
     "    <color=gold>Cấp 90 trở lên<color> có thể luyện cấp ở bản đồ cao cấp xung quanh Tân Thủ Thôn."
  	,tbOpt);
  	     
  return 0;
end;

function tbXinShouBook:TianCiHongFu()
  local tbOpt = {};
  tbOpt = Lib:MergeTable( tbOpt,{
			{"Trở về",  self.OnUse, self},
			{"Đóng"},
	});
   
  Dialog:Say(
     "    Đánh quái luyện cấp ở bên ngoài có xác suất nhận được <color=gold>Túi Phúc Hoàng Kim<color>.\n"..
     string.format("    Mở Túi Phúc nhận được phần thưởng nhất định, bao gồm: kinh nghiệm, bạc khóa hoặc %s khóa. <color=gold>%s khóa có thể giao dịch tại Kỳ Trân Các.<color>\n", IVER_g_szCoinName, IVER_g_szCoinName)..
     "    Mỗi ngày tài khoản chỉ nhận được phần thưởng khi mở 10 túi phúc đầu tiên, nếu vượt quá 10 túi thì chỉ nhận được phần thưởng là 100 bạc khóa."
  	,tbOpt);
  	     
  return 0;
end;
