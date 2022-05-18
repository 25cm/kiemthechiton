local tbNhaSuuTapCa = Npc:GetClass("sltk_nhasttca");
tbNhaSuuTapCa.tbItemInfo = {bForceBind=1,};
function tbNhaSuuTapCa:OnDialog()
DoScript("\\script\\event\\cacevent\\batca\\songlongthaigia.lua");
DoScript("\\script\\event\\cacevent\\batca\\vuahung.lua");
local nCount1 = me.GetItemCountInBags(18,1,20311,1); -- Cá Chép Đỏ
local nCount2 = me.GetItemCountInBags(18,1,20312,1); -- Cá Chép Vàng
local nCount3 = me.GetItemCountInBags(18,1,20313,1); -- Chậu Cá Chép Đỏ
local nCount4 = me.GetItemCountInBags(18,1,20314,1); -- Chậu Cá Chép Vàng
local nCount5 = me.GetItemCountInBags(18,1,20315,1); -- Chậu Thủy Tinh
local szMsg = "Hãy đưa ta <color=yellow>Chậu Cá Chép Đỏ<color> hoặc <color=yellow>Chậu Cá Chép Vàng<color> ta sẽ tặng ngươi phần thưởng\n"..
"1 <color=yellow>Cá Chép Đỏ<color> + 1 <color=yellow>Chậu Thủy Tinh<color> = 1 <color=yellow>Chậu Cá Chép Đỏ<color>\n"..
"1 <color=yellow>Cá Chép Vàng<color> + 1 <color=yellow>Chậu Thủy Tinh<color> = 1 <color=yellow>Chậu Cá Chép Vàng<color>\n"..
"<color=yellow>Chậu Thủy Tinh<color> : 1 Đồng Tiền Vàng/3 Chậu" 
local tbOpt = { 
{"Nộp <color=pink>Chậu Cá Chép Đỏ<color>",self.NopBinhCaChepDo,self};
{"Nộp <color=pink>Chậu Cá Chép Vàng<color>",self.NopBinhCaChepVang,self};
{"Mua <color=pink>Chậu Thủy Tinh<color>",self.MuaBinhThuyTinh,self};
{"Đổi <color=pink>2 Lưỡi Kiếm Rỉ<color> lấy <color=pink>1 Mảnh Ấn<color>",self.DoiLuoiKiemLayManhAn,self};
-- {"Sự Kiện Vua Hùng",self.SuKienVuaHung,self};
-- {"Mua Ngũ Hành Hồn Thạch\n10v Đồng Khóa = 7.000 NHHT", self.MuaNHHT1, self},
{"Mua Tu Luyện Đơn\n5000 Đồng Khóa = 1 Tu Luyện Đơn", self.MuaTuLuyenDon, self},
{"Mua Rương Hồn Thạch (100 cái)\n5000 Đồng Khóa = 1 r", self.MuaRuongHonThach, self},
-- {"Mua 5k Tinh Lực + Hoạt Lực\n= 1 Đồng Tiền Vàng", self.MuaTLHL1, self},
-- {"Tiêu hủy đạo cụ",  Dialog.Gift, Dialog, "Task.DestroyItem.tbGiveForm"},
}; 
Dialog:Say(szMsg, tbOpt);
end
function tbNhaSuuTapCa:MuaRuongHonThach()
Dialog:AskNumber("Nhập Số Lượng", 10, self.MuaRuongHonThach_OK, self);
end
function tbNhaSuuTapCa:MuaRuongHonThach_OK(szSoLuongNHHT)
		if me.CountFreeBagCell() < 10 then
		Dialog:Say("Hành Trang không đủ chỗ trống.Hãy sắp xếp còn trống 10 ô rồi quay lại gặp ta！");
		return 0;
	end
local nCoin = me.nBindCoin
if nCoin < szSoLuongNHHT*5000 then
Dialog:Say("Cần ".. szSoLuongNHHT*5000 .." Đồng Khóa mới mua được "..szSoLuongNHHT.." Rương Hồn Thạch (100 cái)\nSố Đồng Khóa của bạn là "..nCoin.."")
return
end
me.AddStackItem(18,1,244,1,self.tbItemInfo,szSoLuongNHHT)
me.AddBindCoin(-1*(szSoLuongNHHT*5000))
end
function tbNhaSuuTapCa:DoiVatPhamTuINL()
me.Msg("")
end
function tbNhaSuuTapCa:MuaTLHL1()
if me.CountFreeBagCell() < 5 then
		Dialog:Say("Phải Có 5 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local nCount = me.GetJbCoin()
local tbItemId1	= {18,10,11,2,0,0}; -- 
local nCount1 = me.GetItemCountInBags(18,10,11,2)
if nCount < 1 then
Dialog:Say("Trong người ngươi hiện chỉ có <color=cyan>"..nCount.."<color> Đồng Tiền Vàng không đủ mua <color=cyan>5k Tinh Lực + Hoạt Lực<color>")
return 0;
end
me.ChangeCurMakePoint(5000);--X là số tinh lực cần add
me.ChangeCurGatherPoint(5000);-- Y là số hoạt lực cần add
Task:DelItem(me, tbItemId1, 1);
end
function tbNhaSuuTapCa:MuaTuLuyenDon()
		if me.CountFreeBagCell() < 10 then
		Dialog:Say("Hành Trang không đủ chỗ trống.Hãy sắp xếp còn trống 10 ô rồi quay lại gặp ta！");
		return 0;
	end
local nCoin = me.nBindCoin
if nCoin < 5000 then
Dialog:Say("Cần 5000 Đồng Khóa mới mua được 1 Tu Luyện Đơn\nSố Đồng Khóa của bạn là "..nCoin.."")
return
end
me.AddStackItem(18,1,258,1,self.tbItemInfo,1)
me.AddBindCoin(-1*5000)
end
function tbNhaSuuTapCa:MuaNHHT1()
		if me.CountFreeBagCell() < 10 then
		Dialog:Say("Hành Trang không đủ chỗ trống.Hãy sắp xếp còn trống 10 ô rồi quay lại gặp ta！");
		return 0;
	end
local nCoin = me.nBindCoin
if nCoin < 100000 then
Dialog:Say("Cần 10v Đồng Khóa mới mua được 7.000 NHHT\nSố Đồng Khóa của bạn là "..nCoin.."")
return
end
me.AddStackItem(18,1,205,1,self.tbItemInfo,7000)
me.AddBindCoin(-1*100000)
end
--------- Su Kien Vu Hung --------
function tbNhaSuuTapCa:SuKienVuaHung()
local tbVuaHung = Npc:GetClass("sltk_langlieu");
tbVuaHung:OnDialog()
end
--------- Doi Manh An ---------
function tbNhaSuuTapCa:DoiLuoiKiemLayManhAn()
Dialog:AskNumber("Số Lượng", 2000, self.DoiManhAn, self);
end
function tbNhaSuuTapCa:DoiManhAn(szSoLuongLuoKiemDoi)
local tbItemId1	= {18,1,20317,1,0,0}; -- Lưỡi Kiếm Rỉ Sét
local nCount5 = me.GetItemCountInBags(18,1,20317,1); -- Lưỡi Kiếm Rỉ Sét
if nCount5 < szSoLuongLuoKiemDoi*2 then
Dialog:Say("Muốn đổi lấy "..szSoLuongLuoKiemDoi.." Mảnh Ấn cần ".. szSoLuongLuoKiemDoi*2 .." Lưỡi Kiếm Rỉ Set")
return
end
me.AddStackItem(18,1,20316,1,nil,szSoLuongLuoKiemDoi);
	Task:DelItem(me, tbItemId1, szSoLuongLuoKiemDoi*2);
	me.Msg("Ngươi đã đổi "..szSoLuongLuoKiemDoi.." Mảnh Ấn . Tiêu hao ".. szSoLuongLuoKiemDoi*2 .." Lưỡi Kiếm Rỉ Sét")
end
function tbNhaSuuTapCa:MuaBinhThuyTinh()
		if me.CountFreeBagCell() < 10 then
		Dialog:Say("Hành Trang không đủ chỗ trống.Hãy sắp xếp còn trống 10 ô rồi quay lại gặp ta！");
		return 0;
	end
	local tbItemId1	= {18,10,11,2,0,0};
	local nCount1 = me.GetItemCountInBags(18,10,11,2)
		-->> Giải thích đoạn IF: giải sử mua 1 HT, tức là cần 10 ĐTV. như vậy thì chỉ cần lấy số lượng HT nó cần mua*10 là ra giá ? lấy số lượng x 10, xem có lớn hơn tiền trên người thì cho mua.
	if nCount1 < 1 then
		Dialog:Say("Để mua được 3 Chậu Thủy Tinh cần 1 Đồng Tiền Vàng")
	return
	end
		me.AddStackItem(18,1,20315,1,nil,3);
		Task:DelItem(me, tbItemId1, 1);
		me.Msg("Mua thành công 3 Chậu Thủy Tinh , tiêu hảo 1 Đồng Tiền Vàng")
	end;
----- Mua Binh Thuy TInh (Test)-----------
-- function tbNhaSuuTapCa:MuaBinhThuyTinh()
-- local nCount1 = me.GetItemCountInBags(18,10,11,2); -- Đồng Tiền Vàng
-- local nSoLuong = math.floor(nCount1/3)
-- if nCount1 < 1 then
-- Dialog:Say("Cần ít nhất trong người là 3 Đồng Tiền Vàng mới được phép mua Chậu Thủy Tinh")
-- return
-- end
-- Dialog:AskNumber("Số Lượng", nSoLuong , self.MuaBinhThuyTInh, self);
-- end
-- function tbNhaSuuTapCa:MuaBinhThuyTInh(szSoLuongBinhThuyTinh)
-- if me.CountFreeBagCell() < 10 then
		-- Dialog:Say("Phải Có 10 Ô Trống Trong Túi Hành Trang");
		-- return 0;
	-- end
-- local tbItemId1	= {18,10,11,2,0,0}; -- Đồng Tiền Vàng
-- local nCount1 = me.GetItemCountInBags(18,10,11,2); -- Đồng Tiền Vàng
-- local nSoLuong = math.floor(nCount1/3)
-- if szSoLuongBinhThuyTinh < 3 then
-- Dialog:Say("Ít nhất phải mua 3 Chậu Thủy Tinh trở lên")
-- return
-- end
-- if szSoLuongBinhThuyTinh > 300 then
-- Dialog:Say("1 Lần mua tối đa là 300 Chậu Thủy Tinh (Tương ứng 100 Đồng Tiền Vàng)")
-- return
-- end
-- if nCount1 < szSoLuongBinhThuyTinh/3 then
-- Dialog:Say("Để mua "..szSoLuongBinhThuyTinh.." Chậu Thủy Tinh cần ".. szSoLuongBinhThuyTinh/3 .." Đồng Tiền Vàng")
-- return
-- end
-- me.AddStackItem(18,1,20315,1,nil,szSoLuongBinhThuyTinh);
-- Task:DelItem(me, tbItemId1, szSoLuongBinhThuyTinh/3 );
-- end
---- Nộp Chậu Cá Chép Đỏ --------
function tbNhaSuuTapCa:NopBinhCaChepDo()
local nCount3 = me.GetItemCountInBags(18,1,20313,1); -- Chậu Cá Chép Đỏ
if nCount3 == 0 then
Dialog:Say("Trong người không có Chậu Cá Chép Đỏ")
return
end
Dialog:AskNumber("Số Lượng Đổi", nCount3, self.NopBinhCa1, self);
end
function tbNhaSuuTapCa:NopBinhCa1(szSoLuongBinhCa)
local tbItemId1	= {18,1,20313,1,0,0}; -- Chậu Cá Chép Đỏ
me.AddExp(10000000*szSoLuongBinhCa);
me.Msg("Bạn giao nộp <color=yellow>"..szSoLuongBinhCa.." Chậu Cá Chép Đỏ<color> cho <color=yellow>Song Long Thái Gia<color> nhận được <color=yellow>".. szSoLuongBinhCa*10000000 .."<color> Điểm Kinh Nghiệm")
Task:DelItem(me, tbItemId1, szSoLuongBinhCa);
end
---- Nộp Chậu Cá Chép Vàng --------
function tbNhaSuuTapCa:NopBinhCaChepVang()
local nCount3 = me.GetItemCountInBags(18,1,20314,1); -- Chậu Cá Chép Vàng
if nCount3 == 0 then
Dialog:Say("Trong người không có Chậu Cá Chép Vàng")
return
end
Dialog:AskNumber("Số Lượng Đổi", nCount3, self.NopBinhCaVang1, self);
end
function tbNhaSuuTapCa:NopBinhCaVang1(szSoLuongBinhCaVang)
local tbItemId1	= {18,1,20314,1,0,0}; -- Chậu Cá Chép Vàng
me.AddExp(15000000*szSoLuongBinhCaVang);
me.Msg("Bạn giao nộp <color=yellow>"..szSoLuongBinhCaVang.." Chậu Cá Chép Vàng<color> cho <color=yellow>Song Long Thái Gia<color> nhận được <color=yellow>".. szSoLuongBinhCaVang*15000000 .."<color> Điểm Kinh Nghiệm")
Task:DelItem(me, tbItemId1, szSoLuongBinhCaVang);
end