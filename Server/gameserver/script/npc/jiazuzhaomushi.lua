
local tbNpc = Npc:GetClass("jiazuzhaomushi");

function tbNpc:OnDialog()
	Dialog:Say("Mệnh sẽ đáp ứng được xác định sẽ yêu mến! Và như anh hùng của chiến trường, trò chuyện với sẽ là như thế nào dễ chịu là một điều!\n\n"..
	           "Gia nhập môn phái, bạn có thể xem thông tin tuyển dụng của gia đình tôi, việc lựa chọn yêu thích của gia đình để áp dụng cho tham gia\n\n"..
	           "Nếu bạn cần để tạo ra một gia đình, trưởng phái viên đặc biệt anh trai <color=green> vua để tìm võ nghệ thuật <color> thành phố. Ông tôi, Ma núi ở các thành phố lớn có trách nhiệm để tham gia các rào cản gia đình hoạt động của hiệp sĩ hướng dẫn, tham gia vào gia đình, hãy chắc chắn để đi đến hiểu Oh!",
		{
			{"Danh sách các gia tộc chiêu mộ", self.OpenKinRecruitment, self},
			{"Kết thúc đối thoại"},
		})
end


function tbNpc:OpenKinRecruitment()
	if me.nFaction==0 then
	    Dialog:Say("Bạn chưa gia nhập môn phái, hãy gia nhập môn phái nào đó rồi thử lại",
	    	{
			    {"Kết thúc đối thoại"},
		    }
		  )
	else
	    me.CallClientScript({"UiManager:OpenWindow", "UI_KINRCM_LIST" });
	end
end
