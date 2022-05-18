local tbthucung123 = Npc:GetClass("thucung123");
function tbthucung123:OnDialog()
local tbOpt =
	{	
   		{"Kết thúc đối thoại"}
	}
	table.insert(tbOpt, 1, {"<pic=135>Phần Thưởng <color=yellow>2 Vạn Đồng<color>"});
	table.insert(tbOpt, 1, {"<pic=135>Cách bắt <color=gold>Nhấn chuột trái vào NPC<color>"});
	table.insert(tbOpt, 1, {"<pic=135>Thời gian mỗi đợt <color=green>4 phút <color>"});	
	table.insert(tbOpt, 1, {"<pic=135>Số đợt xuất hiện <color=green>5 Đợt <color>"});
	table.insert(tbOpt, 1, {"<pic=135>5 Loại thú cưng <color=red>Thỏ, Rắn, Hổ, Rùa, Gấu<color>"});
	table.insert(tbOpt, 1, {"<pic=135>Hình thức <color=gold>Xuất hiện ngẫu nhiên trong Map<color>"});
	table.insert(tbOpt, 1, {"<pic=135>Vị trí <color=yellow>Đạo Hương Thôn<color>"});
	Dialog:Say("<color=blue>Sự Kiện Thú Cung<color> diễn ra 2 lần /1 Ngày. Vào lúc: <color=green>11h30 - 22h hàng ngày<color>,",tbOpt);
end;
