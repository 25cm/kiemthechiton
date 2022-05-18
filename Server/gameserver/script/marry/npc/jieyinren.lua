-------------------------------------------------------
-- 文件名　：jieyinren.lua
-- 创建者　：zhangjinpin@kingsoft
-- 创建时间：2010-03-05 10:44:22
-- 文件描述：
-------------------------------------------------------

local tbNpc = Npc:GetClass("marry_jieyin");

function tbNpc:OnDialog()
	local szMsg = "Quan quan con chim gáy, tại hà chi châu. Yểu điệu thục nữ, quân tử hảo cầu. Vị này đại hiệp, nhìn ra được: ngươi cho dù đang ở giang hồ, cũng có đồng tâm ái người cùng suốt đời đích mỹ hảo nguyện vọng a!";
	local tbOpt = 
	{
		{"<color=yellow>Tham dự buổi lễ<color>", Marry.AttendWedding, Marry},
		{"Quay lại Giang Tân Thôn", self.TransBack, self},
		{"Để ta suy nghĩ thêm"},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:TransBack()
	me.NewWorld(5, 1633, 2957);
end
