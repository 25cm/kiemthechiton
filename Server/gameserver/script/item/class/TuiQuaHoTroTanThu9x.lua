
local tbHoTro90 = Item:GetClass("tuiquahotrotanthu9x")
function tbHoTro90:OnUse()
if me.nLevel < 120 then
	local szMsg = "Mở ra bạn sẽ nhận được <color=yellow>Set đồ 10X +16 và Vũ Khí 10X +16 theo hệ phái<color>";
	local tbOpt = {
		{"<color=orange>Nhận<color>",self.NhanHoTro9x, self},
			};

	Dialog:Say(szMsg, tbOpt);
end
if me.nLevel >= 120 then
 local tbItemId	= {18,1,25502,1,0,0};
	Task:DelItem(me, tbItemId, 1);
 end
 end

function tbHoTro90:NhanHoTro9x()
if me.CountFreeBagCell() < 25 then
		Dialog:Say("Phải Có 25 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local tbItemId2 = {18,1,25502,1,0,0} -- Mảnh Ghép Huyền Vũ Ấn
if me.nFaction == 0 then
Dialog:Say("<color=yellow>Chưa gia nhập môn phái không thể mở<color>")
return 
end
if me.nRouteId == 0 then
Dialog:Say("Chưa chọn hệ phái")
return
end
	local tbInfo	= GetPlayerInfoForLadderGC(me.szName);
	
	--Add level 120
	me.AddLevel(120-me.nLevel);
	
	--Check môn phái theo nFaction
	--3: Đường Môn
	--4: Ngũ Độc
	--12: Đoàn Thị
	--5: Nga My
	--6: Thúy Yên
	--7: Cái Bang
	--8: Thiên Nhẫn
	--9: Võ Đang
	--10: Côn Lôn
	--(nếu check theo hệ phái thì thêm me.nRouteId)
	--Kim
	if (me.nFaction == 2 or me.nFaction == 1) then
		--Vũ Khí
		me.AddItem(2,1,1215,10,1,16).Bind(1); --Thương
		me.AddItem(2,1,1216,10,1,16).Bind(1); --Chùy
		me.AddItem(2,1,1219,10,1,16).Bind(1); --Đao
		me.AddItem(2,1,1218,10,1,16).Bind(1); --Côn
		
		--TB
		if tbInfo.nSex == 0 then --Nam
			me.AddGreenEquip(8,477,10,4,16).Bind(1); --Lưng bạch ngân nam hệ Kim
			me.AddGreenEquip(10,481,10,5,16).Bind(1); --Tay bạch ngân nam hệ Kim
			me.AddGreenEquip(4,444,10,3,16).Bind(1); --Nhẫn bạch ngân nam hệ Kim
			me.AddGreenEquip(9,477,10,4,16).Bind(1); --Nón bạch ngân nam hệ Kim
			me.AddGreenEquip(3,223,10,5,16).Bind(1); --Áo bạch ngân nam hệ Kim
			me.AddGreenEquip(5,447,10,4,16).Bind(1); --Liên bạch ngân nam hệ Kim
			me.AddGreenEquip(11,71,10,5,16).Bind(1); --Bội bạch ngân nam hệ Kim
			me.AddGreenEquip(6,94,10,3,16).Bind(1); --Phù bạch ngân nam hệ Kim
			me.AddGreenEquip(7,31,10,1,16).Bind(1); --Giày bạch ngân nam hệ Kim
			me.AddItem(1,17,1,10).Bind(1);--ff10 nam
		else -- Nữ
			me.AddGreenEquip(8,478,10,4,16).Bind(1); --Lưng bạch ngân nữ hệ Kim
			me.AddGreenEquip(10,482,10,5,16).Bind(1); --Tay bạch ngân nữ hệ Kim
			me.AddGreenEquip(4,444,10,3,16).Bind(1); --Nhẫn bạch ngân nữ hệ Kim
			me.AddGreenEquip(9,478,10,4,16).Bind(1); --Nón bạch ngân nữ hệ Kim
			me.AddGreenEquip(3,228,10,5,16).Bind(1); --Áo bạch ngân nữ hệ Kim
			me.AddGreenEquip(5,447,10,4,16).Bind(1); --Liên bạch ngân nữ hệ Kim
			me.AddGreenEquip(11,72,10,5,16).Bind(1); --Bội bạch ngân nữ hệ Kim
			me.AddGreenEquip(6,94,10,3,16).Bind(1); --Phù bạch ngân nữ hệ Kim
			me.AddGreenEquip(7,32,10,1,16).Bind(1); --Giày bạch ngân nữ hệ Kim
			me.AddItem(1,17,2,10).Bind(1);--ff10 nữ
		end
	end
	
	--Mộc
	if (me.nFaction == 3 or me.nFaction == 4 or me.nFaction == 11) then
		--Vũ Khí
		me.AddItem(2,1,1226,10,1,16).Bind(1); --Chùy ngoại
		me.AddItem(2,1,1229,10,1,16).Bind(1); --Đao ngoại
		me.AddItem(2,1,1233,10,1,16).Bind(1); --Kiếm nội
		me.AddItem(2,1,1234,10,1,16).Bind(1); --Triền Thủ nội
		me.AddItem(2,2,126,10,1,16).Bind(1); --Phi đao
		me.AddItem(2,2,131,10,1,16).Bind(1); --Tụ tiễn
		
		--TB
		if tbInfo.nSex == 0 then --Nam
			me.AddGreenEquip(8,481,10,4,16).Bind(1); --Lưng bạch ngân nam hệ Mộc
			me.AddGreenEquip(10,485,10,5,16).Bind(1); --Tay bạch ngân nam hệ Mộc
			me.AddGreenEquip(4,446,10,3,16).Bind(1); --Nhẫn bạch ngân nam hệ Mộc
			me.AddGreenEquip(9,479,10,4,16).Bind(1); --Nón bạch ngân nam hệ Mộc
			me.AddGreenEquip(3,224,10,5,16).Bind(1); --Áo bạch ngân nam hệ Mộc
			me.AddGreenEquip(5,449,10,4,16).Bind(1); --Liên bạch ngân nam hệ Mộc
			me.AddGreenEquip(11,73,10,5,16).Bind(1); --Bội bạch ngân nam hệ Mộc
			me.AddGreenEquip(6,99,10,3,16).Bind(1); --Phù bạch ngân nam hệ Mộc
			me.AddGreenEquip(7,33,10,1,16).Bind(1); --Giày bạch ngân nam hệ Mộc
			me.AddItem(1,17,3,10).Bind(1);
		else -- Nữ
			me.AddGreenEquip(8,482,10,4,16).Bind(1); --Lưng bạch ngân nữ hệ Mộc
			me.AddGreenEquip(10,486,10,5,16).Bind(1); --Tay bạch ngân nữ hệ Mộc
			me.AddGreenEquip(4,446,10,3,16).Bind(1); --Nhẫn bạch ngân nữ hệ Mộc
			me.AddGreenEquip(9,480,10,4,16).Bind(1); --Nón bạch ngân nữ hệ Mộc
			me.AddGreenEquip(3,229,10,5,16).Bind(1); --Áo bạch ngân nữ hệ Mộc
			me.AddGreenEquip(5,449,10,4,16).Bind(1); --Liên bạch ngân nữ hệ Mộc
			me.AddGreenEquip(11,74,10,5,16).Bind(1); --Bội bạch ngân nữ hệ Mộc
			me.AddGreenEquip(6,99,10,3,16).Bind(1); --Phù bạch ngân nữ hệ Mộc
			me.AddGreenEquip(7,34,10,1,16).Bind(1); --Giày bạch ngân nữ hệ Mộc
			me.AddItem(1,17,4,10).Bind(1);
		end
	end
	
	--Thủy
	if (me.nFaction == 12 or me.nFaction == 5 or me.nFaction == 6) then
		--Vũ Khí
		me.AddItem(2,1,1237,10,1,16).Bind(1); --Triền thủ ngoại
		me.AddItem(2,1,1239,10,1,16).Bind(1); --Đao ngoại
		me.AddItem(2,1,1243,10,1,16).Bind(1); --Kiếm nội
		me.AddItem(2,1,1244,10,1,16).Bind(1); --Triền thủ nội
		
		--TB
		if tbInfo.nSex == 0 then --Nam
			me.AddGreenEquip(8,485,10,4,16).Bind(1); --Lưng bạch ngân nam hệ Thủy
			me.AddGreenEquip(10,489,10,5,16).Bind(1); --Tay bạch ngân nam hệ Thủy
			me.AddGreenEquip(4,448,10,3,16).Bind(1); --Nhẫn bạch ngân nam hệ Thủy
			me.AddGreenEquip(9,481,10,4,16).Bind(1); --Nón bạch ngân nam hệ Thủy
			me.AddGreenEquip(3,225,10,5,16).Bind(1); --Áo bạch ngân nam hệ Thủy
			me.AddGreenEquip(5,451,10,4,16).Bind(1); --Liên bạch ngân nam hệ Thủy
			me.AddGreenEquip(11,75,10,5,16).Bind(1); --Bội bạch ngân nam hệ Thủy
			me.AddGreenEquip(6,104,10,3,16).Bind(1); --Phù bạch ngân nam hệ Thủy
			me.AddGreenEquip(7,35,10,1,16).Bind(1); --Giày bạch ngân nam hệ Thủy
			me.AddItem(1,17,5,10).Bind(1);
		else -- Nữ
			me.AddGreenEquip(8,486,10,4,16).Bind(1); --Lưng bạch ngân nữ hệ Thủy
			me.AddGreenEquip(10,490,10,5,16).Bind(1); --Tay bạch ngân nữ hệ Thủy
			me.AddGreenEquip(4,448,10,3,16).Bind(1); --Nhẫn bạch ngân nữ hệ Thủy
			me.AddGreenEquip(9,482,10,4,16).Bind(1); --Nón bạch ngân nữ hệ Thủy
			me.AddGreenEquip(3,230,10,5,16).Bind(1); --Áo bạch ngân nữ hệ Thủy
			me.AddGreenEquip(5,451,10,4,16).Bind(1); --Liên bạch ngân nữ hệ Thủy
			me.AddGreenEquip(11,76,10,5,16).Bind(1); --Bội bạch ngân nữ hệ Thủy
			me.AddGreenEquip(6,104,10,3,16).Bind(1); --Phù bạch ngân nữ hệ Thủy
			me.AddGreenEquip(7,36,10,1,16).Bind(1); --Giày bạch ngân nữ hệ Thủy
			me.AddItem(1,17,6,10).Bind(1);
		end
	end
	
	--Hỏa
	if (me.nFaction == 7 or me.nFaction == 8) then
		--Vũ Khí
		me.AddItem(2,1,1248,10,1,16).Bind(1); --Côn ngoại
		me.AddItem(2,1,1251,10,1,16).Bind(1); --Thương ngoại (TĐXC)
		me.AddItem(2,1,1252,10,1,16).Bind(1); --Đao nội
		me.AddItem(2,1,1254,10,1,16).Bind(1); --Triền thủ nội
		
		--TB
		if tbInfo.nSex == 0 then --Nam
			me.AddGreenEquip(8,489,10,4,16).Bind(1); --Lưng bạch ngân nam hệ Hỏa
			me.AddGreenEquip(10,493,10,5,16).Bind(1); --Tay bạch ngân nam hệ Hỏa
			me.AddGreenEquip(4,450,10,3,16).Bind(1); --Nhẫn bạch ngân nam hệ Hỏa
			me.AddGreenEquip(9,483,10,4,16).Bind(1); --Nón bạch ngân nam hệ Hỏa
			me.AddGreenEquip(3,226,10,5,16).Bind(1); --Áo bạch ngân nam hệ Hỏa
			me.AddGreenEquip(5,453,10,4,16).Bind(1); --Liên bạch ngân nam hệ Hỏa
			me.AddGreenEquip(11,77,10,5,16).Bind(1); --Bội bạch ngân nam hệ Hỏa
			me.AddGreenEquip(6,109,10,3,16).Bind(1); --Phù bạch ngân nam hệ Hỏa
			me.AddGreenEquip(7,37,10,1,16).Bind(1); --Giày bạch ngân nam hệ Hỏa
			me.AddItem(1,17,7,10).Bind(1);
		else -- Nữ
			me.AddGreenEquip(8,490,10,4,16).Bind(1); --Lưng bạch ngân nữ hệ Hỏa
			me.AddGreenEquip(10,494,10,5,16).Bind(1); --Tay bạch ngân nữ hệ Hỏa
			me.AddGreenEquip(4,450,10,3,16).Bind(1); --Nhẫn bạch ngân nữ hệ Hỏa
			me.AddGreenEquip(9,484,10,4,16).Bind(1); --Nón bạch ngân nữ hệ Hỏa
			me.AddGreenEquip(3,231,10,5,16).Bind(1); --Áo bạch ngân nữ hệ Hỏa
			me.AddGreenEquip(5,453,10,4,16).Bind(1); --Liên bạch ngân nữ hệ Hỏa
			me.AddGreenEquip(11,78,10,5,16).Bind(1); --Bội bạch ngân nữ hệ Hỏa
			me.AddGreenEquip(6,109,10,3,16).Bind(1); --Phù bạch ngân nữ hệ Hỏa
			me.AddGreenEquip(7,38,10,1,16).Bind(1); --Giày bạch ngân nữ hệ Hỏa
			me.AddItem(1,17,8,10).Bind(1);
		end
	end
	
	--Thổ
	if (me.nFaction == 9 or me.nFaction == 10) then
		--Vũ Khí
		me.AddItem(2,1,1259,10,1,16).Bind(1); --Đao ngoại
		me.AddItem(2,1,1260,10,1,16).Bind(1); --Kiếm nội
		
		--TB
		if tbInfo.nSex == 0 then --Nam
			me.AddGreenEquip(8,493,10,4,16).Bind(1); --Lưng bạch ngân nam hệ Thổ
			me.AddGreenEquip(10,497,10,5,16).Bind(1); --Tay bạch ngân nam hệ Thổ
			me.AddGreenEquip(4,452,10,3,16).Bind(1); --Nhẫn bạch ngân nam hệ Thổ
			me.AddGreenEquip(9,485,10,4,16).Bind(1); --Nón bạch ngân nam hệ Thổ
			me.AddGreenEquip(3,227,10,5,16).Bind(1); --Áo bạch ngân nam hệ Thổ
			me.AddGreenEquip(5,455,10,4,16).Bind(1); --Liên bạch ngân nam hệ Thổ
			me.AddGreenEquip(11,79,10,5,16).Bind(1); --Bội bạch ngân nam hệ Thổ
			me.AddGreenEquip(6,114,10,3,16).Bind(1); --Phù bạch ngân nam hệ Thổ
			me.AddGreenEquip(7,39,10,1,16).Bind(1); --Giày bạch ngân nam hệ Thổ
			me.AddItem(1,17,9,10).Bind(1);
		else -- Nữ
			me.AddGreenEquip(8,494,10,4,16).Bind(1); --Lưng bạch ngân nữ hệ Thổ
			me.AddGreenEquip(10,498,10,5,16).Bind(1); --Tay bạch ngân nữ hệ Thổ
			me.AddGreenEquip(4,452,10,3,16).Bind(1); --Nhẫn bạch ngân nữ hệ Thổ
			me.AddGreenEquip(9,486,10,4,16).Bind(1); --Nón bạch ngân nữ hệ Thổ
			me.AddGreenEquip(3,232,10,5,16).Bind(1); --Áo bạch ngân nữ hệ Thổ
			me.AddGreenEquip(5,455,10,4,16).Bind(1); --Liên bạch ngân nữ hệ Thổ
			me.AddGreenEquip(11,80,10,5,16).Bind(1); --Bội bạch ngân nữ hệ Thổ
			me.AddGreenEquip(6,114,10,3,16).Bind(1); --Phù bạch ngân nữ hệ Thổ
			me.AddGreenEquip(7,40,10,1,16).Bind(1); --Giày bạch ngân nữ hệ Thổ
			me.AddItem(1,17,10,10).Bind(1);
		end
	end
	
	--Thông báo nhận thưởng thành công
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Chúc mừng người chơi <color=green>"..me.szName.."<color> nhận thưởng <color=red>Tân Thủ Mới<color> thành công");
	Task:DelItem(me, tbItemId2, 1); -- Xóa Túi Hỗ Trợ Tân Thủ	
 end
