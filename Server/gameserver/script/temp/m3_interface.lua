
local m3_interface_test = Npc:GetClass("m3_test");

local m3_test = m3_interface_test;

function m3_test:OnDialog()
	Dialog:Say("<pic:\\image\\ui\\temp\\say.spr><head:\\image\\icon\\npc\\portrait_default_female.spr>[Giao diện đối thoại hiển thị]<enter><enter>Ngươi có biết, bờ hồ ở phía tây chân núi có mọc 1 loại hoa tên Hồng Ưng Tử, nó chỉ ra hoa vào giờ Mão mùng 3 hàng tháng rồi tàn ngay lập tức. Giờ ngươi hãy đi hái giùm ta 3 đóa Hồng Ưng Tử, về việc làm thế nào tính toán thời gian ngươi có thể hỏi Toán Mệnh Tiên Sinh.<enter><enter>Ta không muốn nói nhiều, ngươi chỉ cần biết thứ đó rất quan trọng với ta, đi đi.",
				{{"Yên tâm, ta đi đây", m3_test.exit},
				 {"Ta muốn xem các nhiệm vụ khác", m3_test.task},
				 {"Ta muốn biết một số tin tức gần đây", m3_test.exit},
				 {"Tối nay có thể ăn cơm chung rồi", m3_test.exit},
				 {"Kết thúc đối thoại", m3_test.exit},});
end;



function m3_test:exit()
	
end;
