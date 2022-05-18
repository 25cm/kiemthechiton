local tbhoatdong1 = Npc:GetClass("hoatdong1");
function tbhoatdong1:OnDialog()
local tbOpt =
	{	
   		{"Kết thúc đối thoại"}
	}
	table.insert(tbOpt, 1, {"<pic=135>Trò Chơi <color=yellow>Oẳn Tù Tì<color>", self.trochoi1, self});
	table.insert(tbOpt, 1, {"<pic=135>Đánh Trống <color=yellow>Cổ vũ Server<color>", self.danhtrong1, self});
	table.insert(tbOpt, 1, {"<pic=135>Thu phục <color=gold>Thú Cưng<color>", self.thucung1, self});	
	table.insert(tbOpt, 1, {"<pic=135>Tìm kiếm <color=gold>Bảo Rương May Mắn<color>", self.baoruong1, self});
	--table.insert(tbOpt, 1, {"<pic=135>Khiêu chiến <color=green>Cao Thủ [Kim Dung Truyện]<color>", self.kimdung1, self});	
	table.insert(tbOpt, 1, {"<pic=135>Giải cứu <color=green>Xe Chở Quân Lương<color>", self.quanluong1, self});
	table.insert(tbOpt, 1, {"<pic=135>Chống <color=red>Quân Mông Cổ<color>", self.mongco1, self});
	table.insert(tbOpt, 1, {"<pic=135>Câu cá <color=yellow>Thư Giãn<color>", self.cancau, self});
	Dialog:Say("Bạn có thể tham gia các hoạt động <color=green>Đang Diễn Ra<color> tại đây:",tbOpt);
end;
--------------------------------
function tbhoatdong1:cancau()
	local szMsg = "Sự kiện <color=yellow>Câu Cá Thư Giản<color> diễn ra hàng ngày tại <color=green>Bãi Câu [Đạo Hương Thôn]<color>";
	local tbOpt = {
		{"<pic=135> Nhận: <color=yellow>Cần Câu Cá<color>",self.cancau1,self};
		{"<pic=135> Đến: <color=green>Bãi Câu Cá 1<color>",self.bai11,self};
		{"<pic=135> Đến: <color=green>Bãi Câu Cá 2<color>",self.bai22,self};
		{"<pic=135> Kết thúc đối thoại"},
		}
		Dialog:Say(szMsg, tbOpt);
end
function tbhoatdong1:cancau1()
me.AddItem(18,1,2093,1);
end;
function tbhoatdong1:bai11()
me.NewWorld(4,1636,3225);
end;
function tbhoatdong1:bai22()
me.NewWorld(4,1647,3220);
end;
------------------------------------
function tbhoatdong1:mongco1()
	local szMsg = "Sự kiện <color=gold>Chống Quân Mông Cổ<color> diễn ra 2lần/1ngày, lúc <color=green>14h00 và 19h40<color>.";
	local tbOpt = {
		{"<pic=135> Đến Chiến Trường: <color=blue>Mông Cổ Vương Đình<color>",self.mongco2,self};
		{"<pic=135> Giết [Quân Mông Cổ] nhận: <color=yellow>2000 Đồng<color>"};
		{"<pic=135> Giết [Thành Các Tư Hãn] nhận: <color=yellow>10 Vạn Đồng<color>"};
		{"<pic=135> Kết thúc đối thoại"},
		}
		Dialog:Say(szMsg, tbOpt);
end
function tbhoatdong1:mongco2()
me.NewWorld(130,1734,3475);
end;
-------------------------------
function tbhoatdong1:quanluong1()
	local szMsg = "Sự kiện <color=gold>Gải Cứu [Xe Chở Quân Lương]<color> diễn ra 2lần/1ngày, lúc <color=green>17h30 và 22h00<color>.";
	local tbOpt = {
		{"<pic=135> Đến Chiến Trường: <color=blue>Lương Sơn Bạc<color>",self.quanluong2,self};
		{"<pic=135> Số đợt xuất hiện: <color=red>4 Đợt<color>"};
		{"<pic=135> Giết [Sơn Tặc] nhận: <color=yellow>1000 Đồng<color>"};
		{"<pic=135> Giải Cứu [Xe Chở Quân Lương] nhận: <color=yellow>5 Vạn Đồng<color>"};
		{"<pic=135> Giết [Tống Giang] nhận: <color=yellow>5 Vạn Đồng<color>"};		
		{"<pic=135> Kết thúc đối thoại"},
		}
		Dialog:Say(szMsg, tbOpt);
end
function tbhoatdong1:quanluong2()
me.NewWorld(133,1713,3452);
end;
-------------------------------------
function tbhoatdong1:kimdung1()
	local szMsg = "Sự kiện <color=gold>Khiêu chiến [Cao Thủ - Kim Dung Truyện]<color> diễn ra hàng ngày vào các giờ lẻ, lúc: <color=green>10h30, 11h30, 12h30, 13h30, 14h30, 16h30, 17h30, 18h30, 19h30, 20h30, 21h30, 23h30<color>.";
	local tbOpt = {
		{"<pic=135> Vị trí: <color=green>Ngẫu nhiên [Map 115]<color>"};
		{"<pic=135> Giết [Boss] nhận: <color=yellow>5 Vạn Đồng<color>"};		
		{"<pic=135> Kết thúc đối thoại"},
		}
		Dialog:Say(szMsg, tbOpt);
end
---------------------------------------
function tbhoatdong1:baoruong1()
	local szMsg = "Sự kiện <color=yellow>Bảo Rương May Mắn<color> diễn ra 2lần/1ngày, lúc <color=green>14h30 và 19h30<color>.";
	local tbOpt = {
		{"<pic=135> Vị trí: <color=green>Ngẫu nhiên [Map Đạo Hương Thôn]<color>"};
		{"<pic=135> Số đợt: <color=red>4 đợt<color>"};
		{"<pic=135> Tên Rương: <color=gold>Vàng, Bạc, Đồng, Châu Báu, Trang Sức<color>"};		
		{"<pic=135> Phần Thưởng: <color=yellow>2 Vạn Đồng<color>"};
		{"<pic=135> Phần Thưởng: <color=yellow>3 Vạn Đồng Khóa<color>"};
		{"<pic=135> Phần Thưởng: <color=yellow>Rương MG hoặc VP<color>"};		
		{"<pic=135> Kết thúc đối thoại"},
		}
		Dialog:Say(szMsg, tbOpt);
end
---------------------------------------
function tbhoatdong1:danhtrong1()
	local szMsg = "Sự kiện <color=gold>Đánh Trống Cổ Vũ<color> diễn ra hàng ngày vào các giờ chẵn, lúc <color=green>8h00, 9h00, 10h00, 11h00, 12h00, 13h00, 14h00, 15h00, 16h00, 17h00, 18h00, 19h00, 20h00, 21h00, 22h00, 23h00<color>.";
	local tbOpt = {
		{"<pic=135> Vị trí: <color=green>Ngẫu nhiên [Map Đạo Hương Thôn]<color>"};
		{"<pic=135> Phần Thưởng: <color=yellow>3 Vạn Đồng<color>"};
		{"<pic=135> Kết thúc đối thoại"},
		}
		Dialog:Say(szMsg, tbOpt);
end
--------------------------
function tbhoatdong1:thucung1()
	local szMsg = "Sự kiện <color=yellow>Thu Phục Thú Cưng<color> diễn ra 2lần/1ngày, lúc <color=green>11h30 và 22h45<color>.";
	local tbOpt = {
		{"<pic=135> Vị trí: <color=green>Ngẫu nhiên [Map Đạo Hương Thôn]<color>"};
		{"<pic=135> Số đợt: <color=red>4 đợt<color>"};
		{"<pic=135> Tên Thú Cưng: <color=yellow>Thỏ, Rùa, Hổ, Rắn, Gấu<color>"};		
		{"<pic=135> Phần Thưởng: <color=yellow>2 Vạn Đồng<color>"};		
		{"<pic=135> Kết thúc đối thoại"},
		}
		Dialog:Say(szMsg, tbOpt);
end
-----------------------------
function tbhoatdong1:trochoi1()
	local szMsg = "Trò Chơi Dân Gian <color=yellow>Oẳn Tù Tì<color> diễn ra 2lần/1ngày, lúc <color=green>(16h15 đến 16h25)<color> và <color=green>(20h15 đến 20h25)<color>.";
	local tbOpt = {
		{"<pic=135> Vị trí: <color=green>Đạo Hương Thôn<color>"};
		{"<pic=135> NPC trò chơi: <color=red>Bé Thả Diều<color>"};		
		{"<pic=135> Phần Thưởng: <color=yellow>Kinh Nghiệm,  Đồng Khóa<color>"};		
		{"<pic=135> Kết thúc đối thoại"},
		}
		Dialog:Say(szMsg, tbOpt);
end