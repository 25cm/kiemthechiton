local tbcauca123 = Npc:GetClass("cauca123");
function tbcauca123:OnDialog()
local tbOpt =
	{	
   		{"Kết thúc đối thoại"}
	}
	table.insert(tbOpt, 1, {"<pic=135>Phần Thưởng: <color=yellow>Các loại cá<color>"});
	table.insert(tbOpt, 1, {"<pic=135>Mồi câu nhận được qua HĐ: <color=green>Tống Kim, Loạn Phái <color>"});
	table.insert(tbOpt, 1, {"<pic=135>Vật phẩm cần có: <color=red>Mồi câu<color>"});
	table.insert(tbOpt, 1, {"<pic=135>Cách thức: <color=gold>Nhấn chuột phải vào cần câu<color>"});
	table.insert(tbOpt, 1, {"<pic=135>Địa điểm: <color=yellow>Đạo Hương Thôn<color>"});
	table.insert(tbOpt, 1, {"<pic=135>Nhận <color=gold>Cần Câu Cá<color>", self.cancau, self});
	Dialog:Say("<color=green>Sự Kiện Câu Cá Thư Giãn<color> diễn ra hàng ngày tại con sông nhỏ chảy quanh <color=green>Đạo Hương Thôn<color>",tbOpt);
end;
function tbcauca123:cancau()
	local szMsg = "Xin hãy lựa chon:";
	local tbOpt = {
		{"<pic=135> Nhận <color=yellow>Cần Câu Cá<color>",self.cancau1,self};
		{"<pic=135> Đến <color=green>Bãi Câu Cá 1<color>",self.bai11,self};
		{"<pic=135> Đến <color=green>Bãi Câu Cá 2<color>",self.bai22,self};
		{"<pic=135> Kết thúc đối thoại"},
		}
		Dialog:Say(szMsg, tbOpt);
end
function tbcauca123:cancau1()
me.AddItem(18,1,2093,1);
end;
function tbcauca123:bai11()
me.NewWorld(4,1636,3225);
end;
function tbcauca123:bai22()
me.NewWorld(4,1651,3216);
end;