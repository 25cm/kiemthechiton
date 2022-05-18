-- văn kiện danh : yuelao2. lua
-- sáng tạo người : furuilei
-- sáng tạo thời gian: 2010-01-13 11:37:53
-- công năng miêu tả: kết hôn tương quan npc( cung cấp đối thoại tuyển hạng đích giáo dục npc)

	local tbNpc = Npc:GetClass( "marry_yuelao2");

	function tbNpc:OnDialog()

	local szMsg = "Say rượu đương ca, nhân sinh bao nhiêu, lai lai lai, nhượng chúng ta đau nhức ẩm tam bôi!";

	local tbOpt = {
	{ "Ta muốn tham quan Danh Cư Hiệp Sỹ", self. GetJiaoyuMsg1, self},
	{ "Ta muốn tham quan Trang Viên Quý Tộc", self. GetJiaoyuMsg2, self},
	{ "Ta muốn tham quan Bãi Biển Vương Hầu", self. GetJiaoyuMsg3, self},
	{ "Ta muốn tham quan Hoàng Gia Tiên Cảnh", self. GetJiaoyuMsg4, self},
	{ "Sau đó trở lại xem đi "}
	};
Dialog:Say(szMsg, tbOpt);
end

function tbNpc:GetJiaoyuMsg1()
me. NewWorld(498, 1633, 3309);
end

function tbNpc:GetJiaoyuMsg2()
me. NewWorld(499, 1466, 3292);
end

function tbNpc:GetJiaoyuMsg3()
me. NewWorld(500, 1601, 3185);
end

function tbNpc:GetJiaoyuMsg4()
me. NewWorld(575, 1494, 3378);
end

