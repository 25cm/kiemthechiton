if not MODULE_GAMESERVER then
	return;
end
function GoiBossSLTK:AddHoaKyLan_GS()
		local nMapIndex = SubWorldID2Idx(132);
	if nMapIndex < 0 then
		return;
	end
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Hỏa Kỳ Lân<color> xuất hiện tại <pos=132,1961,3312>!<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Hỏa Kỳ Lân<<color> xuất hiện tại <pos=132,1961,3312>!<color><color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Hỏa Kỳ Lân<<color> xuất hiện tại <pos=132,1961,3312>!<color>");	
	KNpc.Add2(20005, 1, 0, 132, 1963, 3311)
KNpc.Add2(9636, 225, 4, 132, 1954, 3302) -- Thạch Hiên Viên
KNpc.Add2(9637, 225, 3, 132, 1954, 3302) -- Vô Tưởng Sư Thái
KNpc.Add2(9638, 225, 1, 132, 1954, 3302) -- Huyền Từ
KNpc.Add2(9639, 225, 2, 132, 1954, 3302) -- Đường Hiểu
KNpc.Add2(9640, 225, 1, 132, 1964, 3299) -- Dương Thiết Tâm
KNpc.Add2(9641, 225, 2, 132, 1964, 3299) -- Cổ Yên Nhiên
KNpc.Add2(9642, 225, 3, 132, 1964, 3299) -- Doãn Tiêu Vũ
KNpc.Add2(9643, 225, 4, 132, 1964, 3299) -- Hoàn Nhan Tương
KNpc.Add2(9644, 225, 5, 132, 1964, 3299) -- Vương Trùng Dương
KNpc.Add2(9645, 225, 5, 132, 1970, 3310) -- Tống Thu Thạch
KNpc.Add2(9646, 225, 2, 132, 1970, 3310) -- Phương Hành Giác
KNpc.Add2(9647, 225, 3, 132, 1970, 3310) -- Đoàn Trí Hưng
KNpc.Add2(9654, 225, 3, 132, 1970, 3310) -- Tần Thủy Hoàng
	end
function GoiBossSLTK:XoaHoaKyLan_GS()
		local nMapIndex = SubWorldID2Idx(132);
	if nMapIndex < 0 then
		return;
	end
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Hỏa Kỳ Lân<color> đã rời đi khỏi Tàn Tích Cung A Phòng bỏ lại nơi hoang vũ những dấu chân in hằn trên đó!<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Hỏa Kỳ Lân<color> đã rời đi khỏi Tàn Tích Cung A Phòng bỏ lại nơi hoang vũ những dấu chân in hằn trên đó!<color><color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Hỏa Kỳ Lân<color> đã rời đi khỏi Tàn Tích Cung A Phòng bỏ lại nơi hoang vũ những dấu chân in hằn trên đó!<color>");	
ClearMapNpcWithName(132, "Hỏa Kỳ Lân");
	ClearMapNpcWithName(132, "Thạch Hiên Viên");
	ClearMapNpcWithName(132, "Vô Tưởng Sư Thái");
	ClearMapNpcWithName(132, "Huyền Từ");
	ClearMapNpcWithName(132, "Đường Hiểu");
	ClearMapNpcWithName(132, "Dương Thiết Tâm");
	ClearMapNpcWithName(132, "Cổ Yên Nhiên");
	ClearMapNpcWithName(132, "Doãn Tiêu Vũ");
	ClearMapNpcWithName(132, "Hoàn Nhan Tương");
	ClearMapNpcWithName(132, "Vương Trùng Dương");
	ClearMapNpcWithName(132, "Tống Thu Thạch");
	ClearMapNpcWithName(132, "Phương Hành Giác");
	ClearMapNpcWithName(132, "Đoàn Trí Hưng");
	ClearMapNpcWithName(132, "Tần Thủy Hoàng");
	end
	----------------
function GoiBossSLTK:AddLamKyLan_GS()
		local nMapIndex = SubWorldID2Idx(123);
	if nMapIndex < 0 then
		return;
	end
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Lam Kỳ Lân<color> xuất hiện tại <pos=123,1836,3659>!<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Lam Kỳ Lân<<color> xuất hiện tại <pos=123,1836,3659>!<color><color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Lam Kỳ Lân<<color> xuất hiện tại <pos=123,1836,3659>!<color>");	
	KNpc.Add2(20006, 1, 0, 123, 1836, 3657)
	KNpc.Add2(9636, 225, 4, 123, 1830, 3650) -- Thạch Hiên Viên
KNpc.Add2(9637, 225, 3, 123, 1830, 3650) -- Vô Tưởng Sư Thái
KNpc.Add2(9638, 225, 1, 123, 1830, 3650) -- Huyền Từ
KNpc.Add2(9639, 225, 2, 123, 1844, 3649) -- Đường Hiểu
KNpc.Add2(9640, 225, 1, 123, 1844, 3649) -- Dương Thiết Tâm
KNpc.Add2(9641, 225, 2, 123, 1844, 3649) -- Cổ Yên Nhiên
KNpc.Add2(9642, 225, 3, 123, 1842, 3665) -- Doãn Tiêu Vũ
KNpc.Add2(9643, 225, 4, 123, 1842, 3665) -- Hoàn Nhan Tương
KNpc.Add2(9644, 225, 5, 123, 1842, 3665) -- Vương Trùng Dương
KNpc.Add2(9645, 225, 5, 123, 1827, 3665) -- Tống Thu Thạch
KNpc.Add2(9646, 225, 2, 123, 1827, 3665) -- Phương Hành Giác
KNpc.Add2(9647, 225, 3, 123, 1827, 3665) -- Đoàn Trí Hưng
	KNpc.Add2(9654, 225, 3, 123, 1827, 3665) -- Tan Thuy Hoang
	end
function GoiBossSLTK:XoaLamKyLan_GS()
		local nMapIndex = SubWorldID2Idx(123);
	if nMapIndex < 0 then
		return;
	end
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Lam Kỳ Lân<color> đã rời đi khỏi Đôn Hoàng Cổ Thành bỏ lại nơi hoang vũ những dấu chân in hằn trên đó!<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Lam Kỳ Lân<color> đã rời đi khỏi Đôn Hoàng Cổ Thành bỏ lại nơi hoang vũ những dấu chân in hằn trên đó!<color><color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Lam Kỳ Lân<color> đã rời đi khỏi Đôn Hoàng Cổ Thành bỏ lại nơi hoang vũ những dấu chân in hằn trên đó!<color>");	
ClearMapNpcWithName(123, "Lam Kỳ Lân");	
	ClearMapNpcWithName(123, "Thạch Hiên Viên");
	ClearMapNpcWithName(123, "Vô Tưởng Sư Thái");
	ClearMapNpcWithName(123, "Huyền Từ");
	ClearMapNpcWithName(123, "Đường Hiểu");
	ClearMapNpcWithName(123, "Dương Thiết Tâm");
	ClearMapNpcWithName(123, "Cổ Yên Nhiên");
	ClearMapNpcWithName(123, "Doãn Tiêu Vũ");
	ClearMapNpcWithName(123, "Hoàn Nhan Tương");
	ClearMapNpcWithName(123, "Vương Trùng Dương");
	ClearMapNpcWithName(123, "Tống Thu Thạch");
	ClearMapNpcWithName(123, "Phương Hành Giác");
	ClearMapNpcWithName(123, "Đoàn Trí Hưng");
	ClearMapNpcWithName(123, "Tần Thủy Hoàng");
	end
	----------------
	function GoiBossSLTK:AddHacKyLan_GS()
		local nMapIndex = SubWorldID2Idx(114);
	if nMapIndex < 0 then
		return;
	end
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Hắc Kỳ Lân<color> xuất hiện tại <pos=114,1746,3521>!<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Hắc Kỳ Lân<color> xuất hiện tại <pos=114,1746,3521>!<color><color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Hắc Kỳ Lân<color> xuất hiện tại <pos=114,1746,3521>!<color>");	
	KNpc.Add2(20007, 1, 0, 114, 1747, 3524)
	KNpc.Add2(9636, 225, 4, 114, 1748, 3513) -- Thạch Hiên Viên
KNpc.Add2(9637, 225, 3, 114, 1754, 3516) -- Vô Tưởng Sư Thái
KNpc.Add2(9638, 225, 1, 114, 1758, 3525) -- Huyền Từ
KNpc.Add2(9639, 225, 2, 114, 1755, 3533) -- Đường Hiểu
KNpc.Add2(9640, 225, 1, 114, 1747, 3537) -- Dương Thiết Tâm
KNpc.Add2(9641, 225, 2, 114, 1739, 3534) -- Cổ Yên Nhiên
KNpc.Add2(9642, 225, 3, 114, 1736, 3525) -- Doãn Tiêu Vũ
KNpc.Add2(9643, 225, 4, 114, 1739, 3516) -- Hoàn Nhan Tương
KNpc.Add2(9644, 225, 5, 114, 1747, 3518) -- Vương Trùng Dương
KNpc.Add2(9645, 225, 5, 114, 1740, 3523) -- Tống Thu Thạch
KNpc.Add2(9646, 225, 2, 114, 1746, 3532) -- Phương Hành Giác
KNpc.Add2(9647, 225, 3, 114, 1754, 3524) -- Đoàn Trí Hưng
KNpc.Add2(9654, 225, 3, 114, 1754, 3524) -- Tần Thủy Hoàng
	end
function GoiBossSLTK:XoaHacKyLan_GS()
		local nMapIndex = SubWorldID2Idx(114);
	if nMapIndex < 0 then
		return;
	end
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Hắc Kỳ Lân<color> đã rời đi khỏi Sắc Lặc Xuyên bỏ lại nơi hoang vũ những dấu chân in hằn trên đó!<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Hắc Kỳ Lân<color> đã rời đi khỏi Sắc Lặc Xuyên bỏ lại nơi hoang vũ những dấu chân in hằn trên đó!<color><color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Hắc Kỳ Lân<color> đã rời đi khỏi Sắc Lặc Xuyên bỏ lại nơi hoang vũ những dấu chân in hằn trên đó!<color>");	
	ClearMapNpcWithName(114, "Hắc Kỳ Lân");
	ClearMapNpcWithName(114, "Thạch Hiên Viên");
	ClearMapNpcWithName(114, "Vô Tưởng Sư Thái");
	ClearMapNpcWithName(114, "Huyền Từ");
	ClearMapNpcWithName(114, "Đường Hiểu");
	ClearMapNpcWithName(114, "Dương Thiết Tâm");
	ClearMapNpcWithName(114, "Cổ Yên Nhiên");
	ClearMapNpcWithName(114, "Doãn Tiêu Vũ");
	ClearMapNpcWithName(114, "Hoàn Nhan Tương");
	ClearMapNpcWithName(114, "Vương Trùng Dương");
	ClearMapNpcWithName(114, "Tống Thu Thạch");
	ClearMapNpcWithName(114, "Phương Hành Giác");
	ClearMapNpcWithName(114, "Đoàn Trí Hưng");
	ClearMapNpcWithName(114, "Tần Thủy Hoàng");
	end