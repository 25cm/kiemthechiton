local tbTuiQuaVKHKMP	= Item:GetClass("tuiquavkhkmp");
function tbTuiQuaVKHKMP:OnUse()
if me.CountFreeBagCell() < 10 then
		Dialog:Say("Phải Có 10 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
if me.nFaction == 0 then
Dialog:Say("Chưa chọn môn phái")
return
end
if me.nRouteId == 0 then
Dialog:Say("Chưa chọn hệ phái")
return
end
local tbItemId2 = {18,1,25210,1,0,0}
	if (me.nFaction == 1) and (me.nRouteId == 1) then -- Thiếu Lâm Đao
	local pItem1 = me.AddItem(2,1,1447,10,1,16)
pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
------
if (me.nFaction == 1) and (me.nRouteId == 2) then -- Thiếu Lâm Bổng
	local pItem1 = me.AddItem(2,1,1448,10,1,16) -- Bổng Ngoại Kim 8x
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
if (me.nFaction == 2) and (me.nRouteId == 1) then -- Thiên Vương Thương
	local pItem1 = me.AddItem(2,1,1449,10,1,16) -- Thương Ngoại Kim 8x
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
if (me.nFaction == 2) and (me.nRouteId == 2) then -- Thiên Vương Chùy
	local pItem1 = me.AddItem(2,1,1450,10,1,16) -- Chùy Ngoại Kim 8x
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
if (me.nFaction == 3) and (me.nRouteId == 1) then -- Đường Môn Bẫy
	local pItem1 = me.AddItem(2,2,1469,10,2,16); -- Phi Đao Mộc 8x
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
if (me.nFaction == 3) and (me.nRouteId == 2) then -- Đường Môn Tụ Tiễn
	local pItem1 = me.AddItem(2,2,1470,10,2,16); -- Tụ Tiễn Mộc 8x 
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
if (me.nFaction == 4) and (me.nRouteId == 1) then -- Ngũ Độc Đao
	local pItem1 = me.AddItem(2,1,1451,10,2,16) -- Đao Ngoại Mộc 8x
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
if (me.nFaction == 4) and (me.nRouteId == 2) then -- Ngũ Độc Chưởng
	local pItem1 = me.AddItem(2,1,1452,10,2,12) -- Triển Thủ Mộc Nội 8x
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
if (me.nFaction == 5) and (me.nRouteId == 1) then -- Nga Mi Chưởng
	local pItem1 = me.AddItem(2,1,1455,10,3,16) -- Triển Thủ Thủy Nội 8x
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
if (me.nFaction == 5) and (me.nRouteId == 2) then -- Nga Mi Kiếm
	local pItem1 = me.AddItem(2,1,1467,10,3,16) -- Kiếm Thủy Nội 8x
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
if (me.nFaction == 6) and (me.nRouteId == 1) then -- Kiếm Thúy Yên
	local pItem1 = me.AddItem(2,1,1456,10,3,16) -- Kiếm Thủy Nội 8x
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
if (me.nFaction == 6) and (me.nRouteId == 2) then -- Đao Thúy Yên
	local pItem1 = me.AddItem(2,1,1453,10,3,16) -- Đao Thủy Ngoại 8x
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
if (me.nFaction == 7) and (me.nRouteId == 1) then -- Cái Bang Chưởng
	local pItem1 = me.AddItem(2,1,1459,10,4,16) -- Triển Thủ Hỏa Nội 8x
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
if (me.nFaction == 7) and (me.nRouteId == 2) then -- Cái Bang Bổng
	local pItem1 = me.AddItem(2,1,1457,10,4,16) -- Bổng Hỏa Ngoại 8x
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
if (me.nFaction == 8) and (me.nRouteId == 1) then -- Thiên Nhẫn Kích
	local pItem1 = me.AddItem(2,1,1458,10,4,16) -- Thương Hỏa Ngoại 8x
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
if (me.nFaction == 8) and (me.nRouteId == 2) then -- Thiên Nhẫn Đao
	local pItem1 = me.AddItem(2,1,1460,10,4,16); -- Đao Hỏa Nội 8x
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
if (me.nFaction == 9) and (me.nRouteId == 1) then -- Võ Đang Khí
	local pItem1 = me.AddItem(2,1,1463,10,5,16) -- Kiếm Thổ Nội 8x
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
if (me.nFaction == 9) and (me.nRouteId == 2) then -- Võ Đang Kiếm
	local pItem1 = me.AddItem(2,1,1462,10,5,16) -- Kiếm Thổ Ngoại 8x
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
if (me.nFaction == 10) and (me.nRouteId == 1) then -- Đao Côn Lôn
	local pItem1 = me.AddItem(2,1,1461,10,5,16) -- Đao Thổ Ngoại 8x
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
if (me.nFaction == 10) and (me.nRouteId == 2) then -- Kiếm Côn Lôn
	local pItem1 = me.AddItem(2,1,1463,10,5,16) -- Kiếm Thổ Nội 8x
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
if (me.nFaction == 11) and (me.nRouteId == 1) then -- Chùy Minh Giáo
	local pItem1 = me.AddItem(2,1,1465,10,2,16) -- Chùy Mộc Ngoại 8x
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
if (me.nFaction == 11) and (me.nRouteId == 2) then -- Kiếm Minh Giáo
	local pItem1 = me.AddItem(2,1,1466,10,2,16) -- Kiếm Mộc Nội 8x
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
if (me.nFaction == 12) and (me.nRouteId == 1) then -- Đoàn Thị Chưởng
	local pItem1 = me.AddItem(2,1,1454,10,3,16) -- Triển Thủ Thủy Ngoại 8x
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
if (me.nFaction == 12) and (me.nRouteId == 2) then -- Đoàn Thị Khí
	local pItem1 = me.AddItem(2,1,1468,10,3,16) -- Kiếm Thủy Nội 8x
	pItem1.Bind(1);
me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
end
	Task:DelItem(me, tbItemId2, 1);
	end