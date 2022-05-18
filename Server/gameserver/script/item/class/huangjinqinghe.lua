

local tbLingPai = Item:GetClass("huangjinqinghe");
tbLingPai.nDuration	= Env.GAME_FPS * 3600 * 24 * 7;
tbLingPai.nSkillId	= 881;

function tbLingPai:OnUse()
	me.AddSkillState(self.nSkillId, 1, 2, self.nDuration, 1, 0, 1);		-- 7天
	return 1;
end

function tbLingPai:GetTip()
	return "Sau khi dùng sẽ nhận được những hiệu quả sau\n<color=gold>Khi tăng cấp ngũ hành, hiệu quả Hồn Thạch tăng 20%\nPhí cường hóa trang bị giảm 20%\nTu Luyện Châu mỗi ngày sẽ tăng thêm 0.5 giờ tu luyện\nSử dụng Lệnh Bài Nghĩa Quân, Lệnh Bài Bạch Hổ Đường, Lệnh Bài Gia Tộc, Lệnh Bài Tống Kim, Lệnh Bài Thi Đấu Môn Phái, danh vọng thu được tăng 50%<color>\nNhấn chuột phải dùng, hiệu quả kéo dài 7 ngày"
end

