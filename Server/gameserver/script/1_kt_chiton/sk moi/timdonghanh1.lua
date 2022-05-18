local tbtimdonghanh1 = Npc:GetClass("timdonghanh1");
function tbtimdonghanh1:OnDialog()
local tbOpt =
	{	
   		{"Kết thúc đối thoại"}
	}
	table.insert(tbOpt, 1, {"<pic=135>Phần Thưởng <color=yellow>4kill, 5skill, 6skill<color>"});
	table.insert(tbOpt, 1, {"<pic=135>Phần Thưởng <color=yellow>1 Vạn Đồng<color>"});
	table.insert(tbOpt, 1, {"<pic=135>Cách bắt <color=gold>Nhấn chuột trái vào NPC<color>"});
	table.insert(tbOpt, 1, {"<pic=135>Thời gian mỗi đợt <color=green>4 phút<color>"});	
	table.insert(tbOpt, 1, {"<pic=135>Số đợt xuất hiện <color=green>5 Đợt<color>"});
	table.insert(tbOpt, 1, {"<pic=135>5 Đồng Hành <color=red>Bảo Ngọc<color>"});
	table.insert(tbOpt, 1, {"<pic=135>Hình thức <color=gold>Xuất hiện ngẫu nhiên trong Map<color>"});
	table.insert(tbOpt, 1, {"<pic=135>Vị trí <color=yellow>Đạo Hương Thôn<color>"});
	Dialog:Say("<color=red>Truy Tìm Đồng Hành<color> diễn ra 2 lần /1 Ngày. Vào lúc: <color=green>15h00 - 19h30 hàng ngày<color>,",tbOpt);
end;
