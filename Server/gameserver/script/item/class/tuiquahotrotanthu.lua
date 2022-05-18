
local tbItem	= Item:GetClass("tuiquahotrotanthu");
function tbItem:OnUse()
	if me.nFaction == 0 then
		Dialog:Say("Chưa gia nhập môn phái không thể mở túi")
	end
	if me.nRouteId == 0 then
		Dialog:Say("Chưa chọn hệ phái không thể mở túi")
	end
	if me.CountFreeBagCell() < 15 then
		Dialog:Say("Trống 15 ô mới mở được túi quà");
		return 0;
	end
	local tbItemId = {}
	if (me.nSeries == 1) and (me.nSex == 0) then --Hệ Kim + Nam
		local pItem =
		me.AddGreenEquip(8,519,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,537,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(10,20211,10,5,14).Bind(1); --Th?y Hoàng H?ng Hoang Uy?n
		me.AddGreenEquip(4,20161,10,5,14).Bind(1); --V? Uy C? Tinh Gi?i
		me.AddGreenEquip(7,20065,10,5,14).Bind(1); --Tiêu Dao Bá V??ng Ngoa
		me.AddGreenEquip(11,20105,10,5,14).Bind(1); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
		me.AddGreenEquip(5,20085,10,5,14).Bind(1); --Tr?c L?c Thiên ?i?p L?u Van Liên
		me.AddGreenEquip(8,353,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(9,487,10,5,14).Bind(1); --Tr?c L?c Kinh Van Kh?i
		me.AddGreenEquip(3,20045,10,5,14).Bind(1); --Th?y Hoàng Long Lan Y
		me.AddGreenEquip(6,20000,10,5,14).Bind(1); --V? Uy L?m Nh?t Tinh Huy?n Phù
		me.AddItem(1,17,1,10).Bind(1);
	end
	if (me.nSeries == 1) and (me.nSex == 1) then --Hệ Kim + Nữ 
		local pItem =
		me.AddGreenEquip(8,520,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,538,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(10,20212,10,5,14).Bind(1);
		me.AddGreenEquip(4,20161,10,5,14).Bind(1); --V? Uy C? Tinh Gi?i
		me.AddGreenEquip(7,20066,10,5,14).Bind(1); --Tiêu Dao Huy?n N? Ngoa
		me.AddGreenEquip(11,20106,10,5,14).Bind(1); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
		me.AddGreenEquip(5,20085,10,5,14).Bind(1); --Tr?c L?c Thiên ?i?p L?u Van Liên
		me.AddGreenEquip(8,354,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(9,488,10,5,14).Bind(1); --Tr?c L?c Kinh Van Kh?i
		me.AddGreenEquip(3,20050,10,5,14).Bind(1); --Th?y Hoàng Long Lan Y
		me.AddGreenEquip(6,20000,10,5,14).Bind(1); --V? Uy L?m Nh?t Tinh Huy?n Phù
		me.AddItem(1,17,2,10).Bind(1);
	end  
	if (me.nSeries == 2) and (me.nSex == 0) then --Hệ Mộc + Nam
		local pItem = me.AddGreenEquip(8,523,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,541,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(10,20215,10,5,14).Bind(1);
		me.AddGreenEquip(4,20163,10,5,14).Bind(1); --V? Uy C? Tinh Gi?i
		me.AddGreenEquip(7,20067,10,5,14).Bind(1); --Tiêu Dao Bá V??ng Ngoa
		me.AddGreenEquip(11,20107,10,5,14).Bind(1); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
		me.AddGreenEquip(5,20087,10,5,14).Bind(1); --Tr?c L?c Thiên ?i?p L?u Van Liên
		me.AddGreenEquip(8,373,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(9,489,10,5,14).Bind(1); --Tr?c L?c Kinh Van Kh?i
		me.AddGreenEquip(3,20046,10,5,14).Bind(1); --Th?y Hoàng Long Lan Y
		me.AddGreenEquip(6,20001,10,5,14).Bind(1); --V? Uy L?m Nh?t Tinh Huy?n Phù
		me.AddItem(1,17,3,10).Bind(1);
	end
	if (me.nSeries == 2) and (me.nSex == 1) then --Hệ Mộc + Nữ
		local pItem =me.AddGreenEquip(8,524,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,542,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(10,20216,10,5,14).Bind(1);
		me.AddGreenEquip(4,20163,10,5,14).Bind(1); --V? Uy C? Tinh Gi?i
		me.AddGreenEquip(7,20068,10,5,14).Bind(1); --Tiêu Dao Huy?n N? Ngoa
		me.AddGreenEquip(11,20108,10,5,14).Bind(1); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
		me.AddGreenEquip(5,20087,10,5,14).Bind(1); --Tr?c L?c Thiên ?i?p L?u Van Liên
		me.AddGreenEquip(8,374,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(9,490,10,5,14).Bind(1); --Tr?c L?c Kinh Van Kh?i
		me.AddGreenEquip(3,20051,10,5,14).Bind(1); --Th?y Hoàng Long Lan Y
		me.AddGreenEquip(6,20001,10,5,14).Bind(1); --V? Uy L?m Nh?t Tinh Huy?n Phù
		me.AddItem(1,17,4,10).Bind(1); 
	end
	if (me.nSeries == 3) and (me.nSex == 0) then --Hệ Thủy + Nam
		local pItem =me.AddGreenEquip(8,527,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,545,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(10,20219,10,5,14).Bind(1);
		me.AddGreenEquip(4,20165,10,5,14).Bind(1); --V? Uy C? Tinh Gi?i
		me.AddGreenEquip(7,20069,10,5,14).Bind(1); --Tiêu Dao Bá V??ng Ngoa
		me.AddGreenEquip(11,20109,10,5,14).Bind(1); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
		me.AddGreenEquip(5,20089,10,5,14).Bind(1); --Tr?c L?c Thiên ?i?p L?u Van Liên
		me.AddGreenEquip(8,393,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(9,491,10,5,14).Bind(1); --Tr?c L?c Kinh Van Kh?i
		me.AddGreenEquip(3,20047,10,5,14).Bind(1); --Th?y Hoàng Long Lan Y
		me.AddGreenEquip(6,20002,10,5,14).Bind(1); --V? Uy L?m Nh?t Tinh Huy?n Phù
		me.AddItem(1,17,5,10).Bind(1); 
	end
	if (me.nSeries == 3) and (me.nSex == 1) then --Hệ Thủy + Nữ
		local pItem =
		me.AddGreenEquip(8,528,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,546,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(10,20220,10,5,14).Bind(1);
		me.AddGreenEquip(4,20165,10,5,14).Bind(1); --V? Uy C? Tinh Gi?i
		me.AddGreenEquip(7,20070,10,5,14).Bind(1); --Tiêu Dao Huy?n N? Ngoa
		me.AddGreenEquip(11,20110,10,5,14).Bind(1); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
		me.AddGreenEquip(5,20089,10,5,14).Bind(1); --Tr?c L?c Thiên ?i?p L?u Van Liên
		me.AddGreenEquip(8,394,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(9,492,10,5,14).Bind(1); --Tr?c L?c Kinh Van Kh?i
		me.AddGreenEquip(3,20052,10,5,14).Bind(1); --Th?y Hoàng Long Lan Y
		me.AddGreenEquip(6,20002,10,5,14).Bind(1); --V? Uy L?m Nh?t Tinh Huy?n Phù
		me.AddItem(1,17,6,10).Bind(1);
	end
	if (me.nSeries == 4) and (me.nSex == 0) then --Hệ Hỏa + Nam
		local pItem = me.AddGreenEquip(8,531,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,549,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(10,20223,10,5,14).Bind(1);
		me.AddGreenEquip(4,20167,10,5,14).Bind(1); --V? Uy C? Tinh Gi?i
		me.AddGreenEquip(7,20071,10,5,14).Bind(1); --Tiêu Dao Bá V??ng Ngoa
		me.AddGreenEquip(11,20111,10,5,14).Bind(1); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
		me.AddGreenEquip(5,20091,10,5,14).Bind(1); --Tr?c L?c Thiên ?i?p L?u Van Liên
		me.AddGreenEquip(8,413,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(9,493,10,5,14).Bind(1); --Tr?c L?c Kinh Van Kh?i
		me.AddGreenEquip(3,20048,10,5,14).Bind(1); --Th?y Hoàng Long Lan Y
		me.AddGreenEquip(6,20003,10,5,14).Bind(1); --V? Uy L?m Nh?t Tinh Huy?n Phù
		me.AddItem(1,17,7,10).Bind(1);
	end
	if (me.nSeries == 4) and (me.nSex == 1) then --Hệ Hỏa + Nữ
		local pItem =
		me.AddGreenEquip(8,532,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,550,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(10,20224,10,5,14).Bind(1);
		me.AddGreenEquip(4,20167,10,5,14).Bind(1); --V? Uy C? Tinh Gi?i
		me.AddGreenEquip(7,20072,10,5,14).Bind(1); --Tiêu Dao Huy?n N? Ngoa
		me.AddGreenEquip(11,20112,10,5,14).Bind(1); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
		me.AddGreenEquip(5,20091,10,5,14).Bind(1); --Tr?c L?c Thiên ?i?p L?u Van Liên
		me.AddGreenEquip(8,414,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(9,494,10,5,14).Bind(1); --Tr?c L?c Kinh Van Kh?i
		me.AddGreenEquip(3,20053,10,5,14).Bind(1); --Th?y Hoàng Long Lan Y
		me.AddGreenEquip(6,20003,10,5,14).Bind(1); --V? Uy L?m Nh?t Tinh Huy?n Phù
		me.AddItem(1,17,8,10).Bind(1);
	end
	if (me.nSeries == 5) and (me.nSex == 0) then --Hệ Thổ + Nam 
		local pItem = me.AddGreenEquip(8,535,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,553,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(10,20227,10,5,14).Bind(1);
		me.AddGreenEquip(4,20169,10,5,14).Bind(1); --V? Uy C? Tinh Gi?i
		me.AddGreenEquip(7,20073,10,5,14).Bind(1); --Tiêu Dao Bá V??ng Ngoa
		me.AddGreenEquip(11,20113,10,5,14).Bind(1); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
		me.AddGreenEquip(5,20093,10,5,14).Bind(1); --Tr?c L?c Thiên ?i?p L?u Van Liên
		me.AddGreenEquip(8,433,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(9,495,10,5,14).Bind(1); --Tr?c L?c Kinh Van Kh?i
		me.AddGreenEquip(3,20049,10,5,14).Bind(1); --Th?y Hoàng Long Lan Y
		me.AddGreenEquip(6,20004,10,5,14).Bind(1); --V? Uy L?m Nh?t Tinh Huy?n Phù
		me.AddItem(1,17,9,10).Bind(1);
	end
	if (me.nSeries == 5) and (me.nSex == 1) then --Hệ Thổ + Nữ 
		local pItem =me.AddGreenEquip(8,536,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(8,554,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(10,20228,10,5,14).Bind(1);
		me.AddGreenEquip(4,20169,10,5,14).Bind(1); --V? Uy C? Tinh Gi?i
		me.AddGreenEquip(7,20074,10,5,14).Bind(1); --Tiêu Dao Huy?n N? Ngoa
		me.AddGreenEquip(11,20114,10,5,14).Bind(1); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
		me.AddGreenEquip(5,20093,10,5,14).Bind(1); --Tr?c L?c Thiên ?i?p L?u Van Liên
		me.AddGreenEquip(8,434,10,5,14).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
		me.AddGreenEquip(9,496,10,5,14).Bind(1); --Tr?c L?c Kinh Van Kh?i
		me.AddGreenEquip(3,20054,10,5,14).Bind(1); --Th?y Hoàng Long Lan Y
		me.AddGreenEquip(6,20004,10,5,14).Bind(1); --V? Uy L?m Nh?t Tinh Huy?n Phù
		me.AddItem(1,17,10,10).Bind(1); 
	end 
end;