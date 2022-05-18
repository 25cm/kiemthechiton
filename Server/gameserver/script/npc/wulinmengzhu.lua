-------------------------------------------------------------------
--File: wulinmengzhu.lua võ lâm minh chủ
--Author: luobaohang
--Date: 2007-9-19 16:36
--Describe: 武林盟主
-------------------------------------------------------------------

--	武林盟主;	
local tbWuLinMengZhu = Npc:GetClass("wulinmengzhu");

function tbWuLinMengZhu:OnDialog()
	Dialog:Say("Khi lập tộc cần tạo nhóm. Lập Tộc yêu cầu tối thiểu phải có 1 người. Chi phí hết 100 Vạn Bạc !", 
		{
			{"Lập <color=green>Gia Tộc<color>", Kin.DlgCreateKin, Kin},
			{"Lập <color=yellow>Bang Hội<color>", Tong.DlgCreateTong, Tong},
			{"Đổi phe gia tộc", Kin.DlgChangeCamp, Kin},
			{"Đổi phe bang hội", Tong.DlgChangeCamp, Tong},
			{"Nhận Lệnh Bài Gia Tộc", Kin.DlgKinExp, Kin},
			{"Nhận lợi tức bang hội", Tong.DlgTakeStock, Tong},
			{"Hoạt động tuần của gia tộc", Kin.DlgAboutWeeklyAction, Kin},
			{"Thưởng ưu tú bang", Tong.DlgGreatBonus, Tong},
			{"Nhận phần thưởng thi đấu gia tộc", EPlatForm.GetKinAward, EPlatForm},
			{"Đóng"}		
		})
end

function tbWuLinMengZhu:NoAccept()
	Dialog:Say("Tạm không thụ lý việc này, xin trở lại sau.")
end
