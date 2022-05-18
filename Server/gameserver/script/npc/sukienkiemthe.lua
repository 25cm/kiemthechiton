local tbSuKienKiemThe = Npc:GetClass("sukienkiemthe");
function tbSuKienKiemThe:OnDialog()
local tbOpt =
	{	
   		{"Kết thúc đối thoại"}
	}

    table.insert(tbOpt, 1, {"<pic=135> Đổi <color=yellow>Đồng Thường<color>", self.dongthuong, self});	
	table.insert(tbOpt, 1, {"<pic=135> Thông Tin <color=green>Hoạt Động InGame<color>",self.hdgame, self});		
	table.insert(tbOpt, 1, {"<pic=135> Thông Tin <color=red>Các Loại Boss<color>", self.boss, self});
	table.insert(tbOpt, 1, {"<pic=135> Cách để có <color=gold>Đồng Hành 4-5-6Skill<color>", self.donghanh, self});
    table.insert(tbOpt, 1, {"<pic=135> Cách lên <color=gold>Tài Phú Nhanh<color>", self.taiphu, self});
	table.insert(tbOpt, 1, {"<pic=135> Sự Kiện <color=green>Đang diễn ra<color>" , self.sukieningame, self});
	table.insert(tbOpt, 1, {"<pic=135> Nhận thưởng <color=yellow>Đoán hoa đăng",GuessGame.OnDialog,GuessGame});
	table.insert(tbOpt, 1, {"<pic=135> Train <color=yellow>Đồng + Đồng Khóa<color>", self.dongkhoa, self});
	table.insert(tbOpt, 1, {"<pic=135> Bảng Thông Tin <color=yellow>Tài Phú<color>", self.xhtaiphu, self});	
	Dialog:Say("Mọi thắc mắc về game xin liên hệ:                 <color=green>Mr.Thành - Zalo:0973158043<color>",tbOpt);
end
------------------------doi do----------------------

function tbSuKienKiemThe:xhtaiphu()
	local szMsg = "Thông tin bảng xếp hạng tài phú:";
	local tbOpt = 
	{
	{"FF1 - Siêu Phàm <color=green>150.000 Tài Phú<color>"};
	{"FF2 - Xuất Trần <color=green>200.000 Tài Phú<color>"};
    {"FF3 - Lăng Tuyệt <color=blue>260.000 Tài Phú<color>"};	
	{"FF4 - Kinh Thế <color=blue>330.000 Tài Phú<color>"};
	{"FF5 - Ngự Không <color=red>410.000 Tài Phú<color>"};
	{"FF6 - Hỗn Thiên <color=red>500.000 Tài Phú<color>"};
	{"FF7 - Số Phượng<color=gold>600.000 Tài Phú<color>"};
	{"FF8 - Tiềm Long <color=gold>720.000 Tài Phú<color>"};
	{"FF9 - Chí Tôn <color=yellow>850.000 Tài Phú<color>"};
	{"FF10 - Vô Song <color=yellow>1.000.000 Tài Phú<color>"};
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;
function tbSuKienKiemThe:sukieningame()
	local szMsg = "Chọn loại sự kiện cần tìm hiểu:";
	local tbOpt = 
	{	
	{"Sự Kiện <color=green>Đốt Pháo Hoa<color>" , self.phaohoa, self};
	{"Sự Kiện <color=green>Đắp Người Tuyết<color>" , self.nguoituyet, self};
	{"Sự Kiện <color=green>Treo Quà Tết<color>" , self.treoqua, self},
	{"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;
function tbSuKienKiemThe:dongthuong()
	local szMsg = "Chọn loại cần đổi:";
	local tbOpt = 
	{
    {"Đổi 1 <color=green>Sách KN đồng hành<color> = 1 <color=yellow>Tiền Đồng<color>", self.doiruongmg1, self};	
	{"Đổi 1 <color=green>Thiệp Bạc<color> = 2 <color=yellow>Tiền Đồng Thường<color>", self.doithiepbac, self};
	{"Đổi 1 <color=green>Bản Đồ Bí Cảnh<color> = 10 <color=yellow>Tiền Đồng Thường<color>", self.doibicanh, self};
	{"Đổi 40 <color=green>Danh Bổ Lệnh<color> = 1 <color=yellow>Vạn Đồng<color>",self.danhbolenh, self},
	{"Đổi LB <color=green>Tiêu Dao Cốc<color> lấy <color=yellow>Đồng Thường<color>", self.doitdc, self};
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;

function tbSuKienKiemThe:dongkhoa()
	local szMsg = "Chọn loại cần đổi:";
	local tbOpt = 
	{	
	{"Train Đồng <color=yellow>Map Tần Lăng 1 + 2 + 3+ 4<color>"};
	{"Train Đồng Khóa <color=green>Map Tần Lăng 1 + 2 + 3+ 4<color>"};
	{"Train Đồng Khóa <color=green>Map 115 Mông Cổ Vương Đình<color>"};
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;

----------------------------hoat dong-------------------------------
function tbSuKienKiemThe:taiphu()
	local szMsg = "Khi vào game:";
	local tbOpt = 
	{	
	{"<color=yellow>Đập thêm 1 vũ khí +16<color>"};
	{"<color=yellow>Chế đồ và đập set đồ thứ 2<color>"};
	{"<color=yellow>Nâng Cấp đồng hành 4skill lên cấp 120<color>"};
	{"<color=yellow>Mua Bát Qoái Trận tại Tiền trang<color>"};
	{"<color=yellow>Mua và nâng cấp Ngoại Trang<color>"};
	{"<color=yellow>Nâng cấp Chấn Nguyên + Thánh Linh<color>"};
	{"<color=yellow>Luyện Hóa Đồ liên đấu, TĐLT, TDC, Tần Lăng<color>"};
	{"<color=yellow>Nâng cấp Mặt Nạ, Ấn, Ngựa, TB Đồng Hành<color>"};	
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;
function tbSuKienKiemThe:donghanh()
	local szMsg = "Đồng hành bắt được từ thiệp bạc radom: 4, 5, 6 skill";
	local tbOpt = 
	{	
	{"<color=yellow>Bắt Pet trong TDC<color>"};
	{"<color=yellow>Đổi LB Triệu Hồi Boss TDC = Danh Bổ Lệnh, sau đó bắt pet<color>"};
	{"<color=yellow>Khiêu Chiến Du Long<color>"};
	{"<color=yellow>Tần Thủy Hoàng: 2 pet 4skill, 1 pet 5skill<color>"};
	{"<color=yellow>Đại Cao Thủ: 2 pet 4skill<color>"};
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;
function tbSuKienKiemThe:boss()
	local szMsg = " <color=red>Boss<color> Hỏa Kỳ Lân xuất hiện lúc 20h00 hàng ngày, Tất cả các Tổ Đội tham gia tiệt diệt Hỏa Kỳ Lân đều nhận được Phần Thưởng";
	local tbOpt = 
	{	
	--{"<color=yellow>Vô Danh Thần Tăng<color> <color=green>xuất hiện tại<color> Đào Hoa Nguyên"};
	--{"<color=yellow>Độc Cô Cầu Bại<color> <color=green>xuất hiện tại<color> Lương Sơn Bạc"};
	--{"<color=yellow>Đông Phương Bất Bại<color> <color=green>xuất hiện tại<color> Cổ Lãng Dữ"};
	--{"<color=yellow>Trương Tam Phong<color> <color=green>xuất hiện tại<color> Nguyệt Nha Tuyền"};
	--{"<color=yellow>Tiêu Phong<color> <color=green>xuất hiện tại<color> Tàn Tích Dạ Lang"};
	--{"<color=yellow>Trương Vô Kỵ<color> <color=green>xuất hiện tại<color> Thần Nữ Phong"};
	--{"<color=yellow>Hư Trúc<color> <color=green>xuất hiện tại<color> Tích Cung A Phòng"};
{"<color=yellow>Hỏa Kỳ Lân<color> <color=green>xuất hiện tại<color> Tích Cung A Phòng"};	
	{"<color=gold>Hoàng Kim 45<color> xuất hiện 9h30p - 15h30p -  22h30p"};
	{"<color=gold>Hoàng Kim 75<color> xuất hiện 9h32p - 15h32p -  22h32p"};
	{"<color=gold>Hoàng Kim 95<color> xuất hiện 15h35p - 22h35p"};
	{"<color=yellow>Tần Thuỷ Hoàng<color> xuất hiện 15h36p -  22h36p"};	
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;
function tbSuKienKiemThe:hdgame()
	local szMsg = " Thông Tin Các <color=yellow>Hoạt Động InGame<color> :";
	local tbOpt = 
	{
{"<color=yellow>Tống Kim<color>" , self.tongkim, self};
{"<color=yellow>Bạch Hổ Đường<color>" , self.bhd, self};
{"<color=yellow>Thi Đấu Loạn Phái<color>" , self.loanphai, self};
{"<color=yellow>Tranh Đoạt Lãnh Thổ<color>" , self.tdlt, self};
{"<color=red>NV Thương Hội<color>" , self.thuonghoi, self};
{"<color=red>Tiêu Dao Cốc<color>" , self.tdc, self};
{"<color=red>Bao Vạn Đồng<color>" , self.bvd, self};
{"<color=red>Săn Hải Tặc<color>" , self.haitac, self};
{"<color=green>Quân Doanh<color>" , self.quandoanh, self};
{"<color=green>Tầng Lăng<color>" , self.tanlang, self};
{"<color=green>Khiêu Chiến Du Long<color>" , self.dulong, self};
{"<color=green>Tàng Bản Đồ<color>" , self.bando, self};
{"<color=gold>Bách Bảo Rương<color>" , self.bachbaoruong, self};
{"<color=gold>Bí Cảnh<color>" , self.bicanh, self};
{"<color=gold>Luyện Công<color>" , self.train, self};
		
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;
function tbSuKienKiemThe:thuonghoi()
	local szMsg = "<color=red>NV Thương Hội<color> Hoàn thành 40NV nhận tổng 50 vạn đồng";
	local tbOpt = 
	{	
	{"<color=green>Số lần:<color> 1 lần/1 tuần"};
	{"<color=yellow>Phần Thưởng:<color> hòa thị bích, tiền du long..."};	
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;
function tbSuKienKiemThe:phaohoa()
	local szMsg = "<color=red>Pháo Hoa<color> nhận được khi thâm gia các hoạt động Ingame:";
	local tbOpt = 
	{	
	{"<color=green>Địa Điểm:<color> Dùng lửa trại tại Đạo Hương Thôn đốt pháo"};
	{"<color=yellow>Phần Thưởng:<color> Đồng Thường/ Rương Mảnh Ghép/ Rương vật Phẩm/ Tiền Du Long ...."};	
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;
function tbSuKienKiemThe:nguoituyet()
	local szMsg = "<color=red>Bông Tuyết<color> Mua trên Kỳ Trân Các giá 2 vạn đồng:";
	local tbOpt = 
	{	
	{"<color=green>Địa Điểm:<color> Đắp Người Tuyết tại Đạo Hương Thôn"};
	{"<color=yellow>Phần Thưởng:<color> Rương Mảnh Ghép/ Đồng Hành/ Tiền Du Long/ ...."};	
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;
function tbSuKienKiemThe:treoqua()
	local szMsg = "<color=red>Hộp Quà Tết<color> Mua trên Kỳ Trân Các giá 2 vạn đồng khóa:";
	local tbOpt = 
	{	
	{"<color=green>Địa Điểm:<color> Trang trí Cây Thông Noel tại Đạo Hương Thôn"};
	{"<color=yellow>Phần Thưởng:<color> Tiền Du Long/ Rương Mảnh Ghép/ Hòa Thị Bích ...."};	
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;

function tbSuKienKiemThe:tongkim()
	local szMsg = "<color=red>Tống Kim:<color> diễn ra trong 30phút, ngày 7 trận";
	local tbOpt = 
	{	
	{"<color=green>Thời Gian:<color> 11h/ 13h/ 15h/ 17h/ 19h/ 21h/ 23h"};
	{"<color=yellow>Phần Thưởng:<color> Đồng Thường/ Rương Mảnh Ghép/ Rương vật Phẩm/ Pháo Hoa/ Tiền Du Long ...."};	
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;
function tbSuKienKiemThe:bhd()
	local szMsg = "<color=red>Bạch Hổ Đường :<color> tối đa 2Lần /1Ngày";
	local tbOpt = 
	{	
	{"<color=green>Thời Gian:<color> từ 9h đến 19h;  từ 22h đến 24h "};
	{"<color=yellow>Phần Thưởng:<color> Đồng Thường/ Rương Mảnh Ghép/ Rương vật Phẩm/ Pháo Hoa/ Tiền Du Long ...."};	
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;
function tbSuKienKiemThe:loanphai()
	local szMsg = "<color=red>Thi Đấu Loạn Phái:<color> tất cả các ngày trong tuần, 3 Trận/ 1ngày";
	local tbOpt = 
	{	
	{"<color=green>Thời Gian Báo Danh:<color> từ 10h - 16h - 20h hàng ngày"};
	{"<color=green>Thời Gian Diễn Ra:<color> lúc 10h30 - 16h30- 20h30 hàng ngày "};
	{"<color=yellow>Phần Thưởng:<color> Đồng Thường/ Rương Mảnh Ghép/ Rương vật Phẩm/ Pháo Hoa/ Tiền Du Long ...."};	
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;
function tbSuKienKiemThe:tdlt()
	local szMsg = "<color=red>Tranh Đoạt Lãnh Thổ:<color>tất cả các ngày trong tuần, diễn ra trong 25 phút";
	local tbOpt = 
	{	
	{"<color=green>Thời Gian Tuyên Chiến:<color> 21h"};
	{"<color=green>Thời Gian Bắt Đầu:<color> 21h30"};
	{"<color=green>Thời Gian Kết Thúc:<color> 21h55"};
	{"Giết <color=green>Nguyên Soái Thủ Thành<color> nhận 10 vạn đồng thường"};
	{"<color=yellow>Phần Thưởng:<color> Quan Ấn/ Đồng Thường/ Rương Mảnh Ghép/ Rương vật Phẩm/ Pháo Hoa/ Tiền Du Long ...."};	
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;
function tbSuKienKiemThe:tdc()
	local szMsg = "<color=red>Tiêu Dao Cốc:<color> Tối đa 2Lần/1ngày";
	local tbOpt = 
	{	
	{"<color=green>Thời Gian:<color> Sáng: từ 9h đến 19h30; Tối:  từ 22h đến 24h"};
	{"<color=yellow>Phần Thưởng:<color> Đồng Thường/ Rương Mảnh Ghép/ Rương vật Phẩm/ Pháo Hoa/ Tiền Du Long ...."};	
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;
function tbSuKienKiemThe:bvd()
	local szMsg = "<color=red>Bao Vạn Đồng :<color> tối đa 50 Nhiệm vụ /1Ngày";
	local tbOpt = 
	{	
	{"<color=green>Chỉ có loại nhiệm vụ giết 24 NPC<color>"};
	{"Các mốc nhiệm vụ: 10, 50 nhận <color=yellow>Phần Thưởng<color>"};
	{"<color=yellow>Phần Thưởng:<color> Đồng Thường/ Rương Mảnh Ghép/ Rương vật Phẩm/ Pháo Hoa/ Tiền Du Long ...."};	
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;

function tbSuKienKiemThe:haitac()
	local szMsg = "<color=red>Săn Hải Tặc:<color> Tích Lũy Tối đa 30 lần, Chỉ có nhiệm vụ săn HT 95";
	local tbOpt = 
	{	
	{"<color=green>Số nhiệm vụ tối đa:<color> 10 Nhiệm Vụ/ 1Ngày"};
	{"<color=yellow>Phần Thưởng:<color> Đồng Thường/ Rương Mảnh Ghép/ Rương vật Phẩm/ Pháo Hoa/ Tiền Du Long ...."};	
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;
function tbSuKienKiemThe:quandoanh()
	local szMsg = "<color=red>Quân Doanh:<color> 3Lần/ 1Ngày";
	local tbOpt = 
	{	
	{"<color=green>Thời Gian:<color> Từ 9h đến 19h30;  từ 22h đến 24h; Mỗi Phó bản chỉ được tham gia 1lần /1ngày. "};
	{"<color=yellow>Phần Thưởng:<color> Giết Boss cuối nhận : Đồng Thường/ Rương Mảnh Ghép/ Rương vật Phẩm/ Pháo Hoa/ Tiền Du Long ...."};	
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;
function tbSuKienKiemThe:tanlang()
	local szMsg = "<color=red>Tần Lăng:<color> Tối đa 2h/1ngày";
	local tbOpt = 
	{	
	{"<color=green>Thời Gian mở tần lăng 5:<color> Chiều từ 15h đến 16h"};
	{"<color=green>Thời Gian mở tần lăng 5:<color> Tối từ 22h đến 23h"};
	{"<color=yellow>Phần Thưởng:<color> Đồng Thường/ Rương MG/ Rương VP ...."};	
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;
function tbSuKienKiemThe:dulong()
	local szMsg = "<color=red>Khiêu Chiến Du Long:<color> không tích lũy";
	local tbOpt = 
	{	
	{"<color=green>Số Lần Tham Gia:<color> Tối đa 200Lần/1Ngày"};
	{"<color=yellow>Phần Thưởng:<color> Danh Vọng Lệnh, Rương Mảnh Ghép, Tiền Du Long ...."};	
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;
function tbSuKienKiemThe:bando()
	local szMsg = "<color=red>Tàng Bản Đồ:<color> Vạn Hoa Cốc, Thiên Quỳnh Cung, Đại Mạc Cổ Thành, Bách Niên Thiên Lao, Đào Chu Công Mộ Chủng ";
	local tbOpt = 
	{
	{"Tham gia sự kiện Đốt pháo hoa có cơ hội nhận được <color=gold>Lệnh Bài<color>"};
	{"<color=green>Số Lần Tham Gia:<color> Không giới hạn"};
	{"<color=yellow>Phần Thưởng:<color> Giết Boss cuối nhận: Đồng Thường/ Rương Mảnh Ghép/ Rương vật Phẩm/ Pháo Hoa/ Tiền Du Long ..."};	
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;
function tbSuKienKiemThe:bicanh()
	local szMsg = "<color=red>Bí Cảnh :<color> Thời Gian và Phần thưởng:";
	local tbOpt = 
	{	
	{"<color=green>Thời Gian:<color> Tích lũy 2h/1Ngày; Tích lũy tối đa 10h"};
	{"<color=yellow>Phần Thưởng:<color> Kinh Nghiệm x4/ Bạc Thường/ Sách Kinh Nghiệm Đồng Hành..."};	
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;
function tbSuKienKiemThe:train()
	local szMsg = "<color=red>Luyện Công:<color> Địa điểm và Phần thưởng:";
	local tbOpt = 
	{	
	{"<color=green>Địa điểm:<color> Map 115 Mông Cổ Vương Đình "};
	{"<color=yellow>Phần Thưởng:<color> Đồng khóa"};	
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;
function tbSuKienKiemThe:bachbaoruong()
	local szMsg = "<color=red>Vỏ sò vàng:<color> nhận được từ Tống Kim, Thi Đấu Loạn Phái";
	local tbOpt = 
	{	
	{"<color=yellow>Phần Thưởng:<color> Rương Vừa Đẹp Vừa Cao Quý, Đồng Khóa, Tinh Hoạt Lực, Bạc Thường,... "};	
	{"<color=yellow>Rương Vừa Đẹp Vừa Cao Quý:<color> mở ra có tỉ lệ nhận đc Tinh Thạch Thánh Hỏa"};	
	    {"Kết Thúc"},
	}
	Dialog:Say(szMsg, tbOpt);
end;

--------------------------------------------------------------

function tbSuKienKiemThe:KhieuchienDAM()
	me.NewWorld(174,1622,3237);
end
function tbSuKienKiemThe:KhieuchienTCTH()
	me.NewWorld(174,1622,3237);
end
function tbSuKienKiemThe:Khieuchien()
	me.NewWorld(167,1646,3177);
end
function tbSuKienKiemThe:doiruongmg1()
	 local tbNpc = Npc:GetClass("doiruongmg1");
	tbNpc:OnDialog_1();
end;
function tbSuKienKiemThe:doiruongmg2()
	 local tbNpc = Npc:GetClass("doiruongmg2");
	tbNpc:OnDialog_1();
end;
function tbSuKienKiemThe:doibicanh()
	 local tbNpc = Npc:GetClass("doibicanh");
	tbNpc:OnDialog_1();
end;
function tbSuKienKiemThe:doithiepbac()
	 local tbNpc = Npc:GetClass("doithiepbac");
	tbNpc:OnDialog_1();
end;
function tbSuKienKiemThe:doitdc()
	 local tbNpc = Npc:GetClass("changeItemtoDong_npc");
	tbNpc:OnDialog_1();
end;
function tbSuKienKiemThe:danhbolenh()
	 local tbNpc = Npc:GetClass("doirmg1");
	 tbNpc:OnDialog_1();
end;
function tbSuKienKiemThe:hotromoi()
if me.CountFreeBagCell() < 10 then
		Dialog:Say("Phải Có 10 Ô Trống Trong Túi Hành Trang");
else
			if me.nLevel > 130 then
Dialog:Say("Nhân vật cấp 130 mới nhận được Hỗ Trợ này !")
	end
				if me.nLevel < 130 then
Dialog:Say("Nhân vật cấp 130 mới nhận được Hỗ Trợ này !")
	end
if me.nLevel == 130 then
	me.AddLevel(133-me.nLevel);
	 --me.AddItem(1,17,1,5);
	  --me.AddItem(1,17,2,5);
	        --me.AddItem(5,23,1,2); -- Phù Cấp 2
			--me.AddItem(5,20,1,2); -- Áo Cấp 2
			--me.AddItem(5,22,1,2); -- Bao Tay Cấp 2
			--me.AddItem(5,21,1,2); -- Nhẫn Cấp 2
			--me.AddItem(5,19,1,2); -- Vũ Khí Cấp 2
			--me.AddItem(1,12,20041,10); --ngua tuyet hon
			--me.AddItem(1,16,15,3); --an2
  --me.AddItem(1,13,157,4); --matna2
end  
end
end;
function tbSuKienKiemThe:donghanh4(nPlayerId)
	me.AddStackItem(18,1,666,5,tbItemInfo,3);    -- dong hanh 4 skill
end