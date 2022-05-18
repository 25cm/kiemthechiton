local tbCJDBook = Item:GetClass("cjdbook");
tbCJDBook.USEMAXTIME = 500;
tbCJDBook.tbInfo = 
{
	"<color=gold>NPC có dấu ! là nhận nhiệm vụ, dấu ? là giao nhiệm vụ",
	"<color=gold>Nhấn Tab mở bản đồ nhỏ xem tin tức",
	"<color=gold>Nhấn F12 mở bảng nhiệm vụ, nhấn chữ màu vàng để đến nơi chỉ định",
	"<color=gold>Nhấn F2 mở hành trang, đặt thuốc vào ô phím tắt muốn dùng",
	"<color=gold>Có thể nhấn chuột phải vào hình đạo cụ trong hành trang để sử dụng.",
	"<color=gold>Nhấn Enter mở thanh tán gẫu, nhập nội dung và gửi đi",
	"<color=gold>Nhấn Ctrl+chuột phải vào đối tượng để tương tác",
	"<color=gold>Đối thoại với NPC, chọn mua đạo cụ trang bị thích hợp",
	"<color=gold>Kích hoạt trang bị dựa vào tương sinh tương khắc của ngũ hành.",
	"<color=gold>Khi đã chọn kỹ năng của hệ phái nào thì chỉ được theo hệ phái đó.",
	"<color=gold>Tìm đệ tử môn phái để đến bổn môn, nhận nhiệm vụ môn phái.",
	"<color=gold>Nhấn P mở tổ đội hoặc nhấn Ctrl+chuột phải vào người chơi muốn tổ đội",
	"<color=gold>Mở Kỳ Trân Các bằng cách nhấn vào Trân hoặc Ctrl+z",
	"<color=gold>Nhấn Ctrl+Tab thay đổi qua lại các giao diện",
	"<color=gold>Nhận hoạt lực thông qua nhiệm vụ sư môn, chính tuyến và ủy thác rời mạng",
	"<color=gold>Kỹ năng chế tạo cần tiêu hao tinh lực."
}

function tbCJDBook:OnUse()
	local nMeUseCount = me.GetTask(1021, 1) or 0;
	if (nMeUseCount >= self.USEMAXTIME) then
		me.Msg("Đã sử dụng hơn 500 lần, không thể tiếp tục dùng.");
		return 0;
	end
	
	local nRandomInfoIdx = MathRandom(1, #self.tbInfo);
	Dialog:Say("Nhắc nhở:\n"..self.tbInfo[nRandomInfoIdx])
	me.AddExp(100);
	me.SetTask(1021, 1, nMeUseCount + 1);
	return 1;
end;
