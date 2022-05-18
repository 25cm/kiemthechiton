-- 文件名　：chefu2.lua
-- 创建者　：furuilei
-- 创建时间：2010-01-13 11:37:53
-- 功能描述：结婚相关npc（提供对话选项的教育npc）

local tbNpc = Npc:GetClass("marry_chefu2");

function tbNpc:OnDialog()
	local szMsg = "Ngàn dăm xa chớp mắt đã đến, nào, chúng ta cùng đi";
	local tbOpt = {
		{"Ta muốn tham quan Danh Cư Hiệp Sỹ", self.GetJiaoyuMsg1, self},
		{"Ta muốn tham quan Gia trang Quý tộc", self.GetJiaoyuMsg2, self},
		{"Ta muốn tham quan Bãi biển Vương hầu", self.GetJiaoyuMsg3, self},
		{"Ta muốn tham quan Tiên cảnh Hoàng gia", self.GetJiaoyuMsg4, self},
		{"Trở về thôn Giang Tân tìm Hồng Di Nguyệt Lão", self.GetJiaoyuMsg5, self},		
		{"Sau này lại ghé thăm nhé "}
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:GetJiaoyuMsg1()
	me.NewWorld(498, 1633, 3309);
end

function tbNpc:GetJiaoyuMsg2()
	me.NewWorld(499, 1466, 3292);
end

function tbNpc:GetJiaoyuMsg3()
	me.NewWorld(500, 1601, 3185);
end

function tbNpc:GetJiaoyuMsg4()
	me.NewWorld(575, 1494, 3378);
end

function tbNpc:GetJiaoyuMsg5()
	me.NewWorld(5, 1633, 2957);
end