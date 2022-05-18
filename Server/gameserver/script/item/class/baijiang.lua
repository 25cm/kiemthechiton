-- 神秘家书
local tbBaijiang = Item:GetClass("baijiang");

function tbBaijiang:OnUse()
	local szInfo = "Đức Khoái huynh thân mến:\n"..
	"Tháng trước gặp bọn Kim ở Hán Thủy Cổ Độ đấu 3 ngày 3 đêm, xác chết đầy đồng, máu chảy thành sông. Phu phụ chủ nhân biệt tích, đệ hiện trị thương tại nhà dân, không thể về kịp.\n"..
	"Tháng trước Thu Lâm tỷ đưa con chủ nhân về quê, xin giúp đỡ đừng để kẻ thù tìm thấy họ. Trận Cổ Độ rất kỳ quặc, nhiều cao thủ ẩn cư đều có mặt, ắt có uẩn khúc.\n"..
	"Đôi ba dòng chưa cạn ý, đợi khi quay về sẽ kể tiếp. Nếu trước mùa hè vẫn chưa quay lại, thì tính mạng của 2 người đó đều nhờ vào huynh, hy vọng chủ nhân bình an vô sự.\n"..
	"                                                                                                                     Đệ Bạch Cương xin bái tạ";
	Dialog:Say(szInfo)
	return 0;
end
