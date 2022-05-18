-- 文件名　：hongniang.lua
-- 创建者　：furuilei
-- 创建时间：2009-11-26 10:19:50
-- 描述	   : 结婚相关npc（红娘）

local tbNpc = Npc:GetClass("marry_hongniang");

function tbNpc:OnDialog()
	if (Marry:CheckState() == 0) then
		return 0;
	end
	local szMsg = "  Lương duyên tiền định, ngọc phục cầu loan, ngày lành tháng tốt bài đường thành thân.";
	local tbOpt = 
	{
		{"[Tìm hiểu Hiệp Lữ]", self.Introduce, self},
		{"[Song phương hủy quan hệ hiệp lữ]", Marry.DialogNpc.OnRemoveQiuhun, Marry.DialogNpc},
		{"[Đơn phương hủy quan hệ hiệp lữ]", Marry.DialogNpc.OnSingleRemoveQiuhun, Marry.DialogNpc},
		{"Kết thúc đối thoại"},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:Introduce()
	local tbNpc = Npc:GetClass("marry_dlgjiaoyunpc");
	tbNpc:OnDialog();
end
