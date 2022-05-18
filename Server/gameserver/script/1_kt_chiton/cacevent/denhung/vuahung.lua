local tbVuaHung = Npc:GetClass("vuahung");
function tbVuaHung:OnDialog()
DoScript("\\script\\event\\cacevent\\denhung\\hopquavuahung.lua");
DoScript("\\script\\event\\cacevent\\denhung\\tuinguyenlieu.lua");
DoScript("\\script\\event\\cacevent\\denhung\\vuahung.lua");
DoScript("\\script\\event\\cacevent\\denhung\\luhuong.lua");
local nCount1 = me.GetItemCountInBags(18,1,20299,1);
local nCount2 = me.GetItemCountInBags(18,1,20300,1);
local nCount3 = me.GetItemCountInBags(18,1,20301,1);
local nCount4 = me.GetItemCountInBags(18,1,20302,1);
local szMsg = "<color=yellow><pic=49>Nguyên Liệu Của Bạn<pic=49>\n<color=pink>Bình Nước<color> <color=yellow>"..nCount1.."<color>\n<color=pink>Gạo Nếp<color> <color=yellow>"..nCount2.."<color>\n<color=pink>Lá Dong<color> <color=yellow>"..nCount3.."<color>\n<color=pink>Khuôn Làm Bánh<color> <color=yellow>"..nCount4.."<color>\n<pic=49>Công Thức Ghép Bánh<pic=49>\n<color=pink>Bánh Dày<color> : 3 Bình Nước + 1 Gạo Nếp\n<color=pink>Bánh Tét<color> : 3 Bình Nước + 2 Gạo Nếp + 5 Lá Dong + 1 Khuôn Làm Bánh\n<pic=49>Cách Kiếm Nguyên Liệu<pic=49>\n<color=pink>Túi Nguyên Liệu<color> : đánh quái > 115 (Mở ra Bình Nước , Lá Dong , Gạo Nếp\n<color=pink>Khuôn Bánh<color> : 1 Đồng Tiền Vàng = 10 Khuôn Làm Bánh"; 
local tbOpt = { 

{"Nhận Thưởng Sử Dụng Hộp Quà Vua Hùng",self.GiftHopQuaVH,self};
{"Nộp <color=Turquoise>Bánh Tét<color> + <color=Turquoise>Bánh Dày<color>",self.NopBanhTet,self};
{"Làm <color=Turquoise>Bánh Dày<color>",self.LamBanhDay,self};
{"Làm <color=Turquoise>Bánh Tét<color>",self.LamBanhTet,self};
{"Làm <color=Turquoise>Chè Trôi Nước<color>",self.LamCheTroiNc,self};

--{"Nhận <color=Turquoise>Túi Nguyên Liệu<color>",self.NhanTuiNL1,self};
{"Mua <color=Turquoise>Khuôn Làm Bánh<color>",self.MuaKhuonBanh,self};

}; 
Dialog:Say(szMsg, tbOpt);
end

------ Lam Che Troi Nuoc --------
function tbVuaHung:LamCheTroiNc()
local nCount1 = me.GetItemCountInBags(18,1,20307,1); -- Đg cát
local nCount2 = me.GetItemCountInBags(18,1,20308,1); -- Mè đen
local nCount3 = me.GetItemCountInBags(18,1,20310,1); -- Bột Nếp
local nCount4 = me.GetItemCountInBags(18,1,20300,1); -- Gạo Nếp
local szMsg = "<color=pink>Nguyên Liệu Của Bạn<color>\n"..
"<color=yellow>Đường Cát<color>: "..nCount1.."\n"..
"<color=yellow>Mè Đen<color>: "..nCount2.."\n"..
"<color=yellow>Bột Nếp<color>: "..nCount3.."\n"..
"<color=yellow>Gạo Nếp<color>: "..nCount4.."\n"..
"Công Thức : <color=yellow>Đường Cát<color>x5 + <color=yellow>Mè Đen<color>x1 + <color=yellow>Bột Nếp<color>x1\n"..
"<color=pink>Sử dụng <color=yellow>Chè Trôi Nước<color><color>\n"..
"<color=yellow>100 Lần<color>: 5000 NHHT + 20 HTB + 150tr EXP\n"..
"<color=yellow>200 Lần<color>: 1v NHHT + 20 HTB + 200tr EXP\n"..
"<color=yellow>300 Lần<color>: 1v5 NHHT + 20 HTB + 300tr EXP\n"
local tbOpt = { 
{"Mua <color=Turquoise>Mè Đen<color>",self.MuaMeDen,self};
{"Xay <color=Turquoise>Gạo Nếp<color> thành <color=Turquoise>Bột Nếp<color>",self.XayGaoRaBot,self};
{"Làm <color=Turquoise>Chè Trôi Nước<color>",self.LamCheTroiNuoc15,self};
}; 
Dialog:Say(szMsg, tbOpt);
end
------- Xay gao ra bot ----------
function tbVuaHung:XayGaoRaBot()
Dialog:AskNumber("Số Lượng Gạo Xay", 20, self.XayGaoRaBot1995, self);
end
function tbVuaHung:XayGaoRaBot1995(szSoLuongGao)
if me.CountFreeBagCell() < 10 then
		Dialog:Say("Phải Có 10 Ô Trống Trong Túi Hành Trang");
		return 0;
	end
local nCount1 = me.GetItemCountInBags(18,1,20300,1) -- Gạo Nếp
if nCount1 < szSoLuongGao then
Dialog:Say("Trong người ngươi có "..nCount1.." Gạo Nếp. Mà ngươi dám khai có "..szSoLuongGao.." sao")
return
end


	local tbEvent = 
	{
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SITE,
		Player.ProcessBreakEvent.emEVENT_USEITEM,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_DROPITEM,
		Player.ProcessBreakEvent.emEVENT_SENDMAIL,
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
	}
	 local tbOpt = {
				 GeneralProcess:StartProcess("<color=pink>Đang Xay Gạo<color>", 5 * Env.GAME_FPS, {self.XayGaoOK, self, szSoLuongGao}, nil, tbEvent);
	 };
	end
function tbVuaHung:XayGaoOK(szSoLuongGao)
local tbItemId1	= {18,1,20300,1,0,0}; -- Gạo Nếp
me.AddStackItem(18,1,20309,1,nil,szSoLuongGao)
Task:DelItem(me, tbItemId1, szSoLuongGao);
end
------- Lam Che Troi Nuoc ---------
function tbVuaHung:LamCheTroiNuoc15()
if me.CountFreeBagCell() < 5 then
		Dialog:Say("Phải Có 5 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local tbItemId1	= {18,1,20307,1,0,0}; -- Đường Cát
local tbItemId2	= {18,1,20308,1,0,0}; -- Mè Đen
local tbItemId3	= {18,1,20309,1,0,0}; -- Bột Nếp
local nCount1 = me.GetItemCountInBags(18,1,20307,1) -- Đường Cát
local nCount2 = me.GetItemCountInBags(18,1,20308,1) -- Mè Đen
local nCount3 = me.GetItemCountInBags(18,1,20309,1) -- Bột Nếp
if nCount1 < 5 or nCount2 < 1  or nCount3 < 1 then
Dialog:Say("Làm <color=yellow>Chè Trôi Nước<color> cần 5 Đường Cát + 1 Mè Đen + 1 Bột Nếp . \nNgươi chỉ có "..nCount1.." Đường Cát , "..nCount2.." Mè Đen , "..nCount3.." Bột Nếp")
return
end
me.AddItem(18,1,20310,1)
me.Msg("Đổi thành công 1 Chè Trôi Nước")
Task:DelItem(me, tbItemId1, 5);
Task:DelItem(me, tbItemId2, 1);
Task:DelItem(me, tbItemId3, 1);
end
----- Mua Me Den ------------
function tbVuaHung:MuaMeDen()
		if me.CountFreeBagCell() < 10 then
		Dialog:Say("Hành Trang không đủ chỗ trống.Hãy sắp xếp còn trống 10 ô rồi quay lại gặp ta！");
		return 0;
	end
	local tbItemId1	= {18,10,11,2,0,0};
	local nCount1 = me.GetItemCountInBags(18,10,11,2)
		-->> Giải thích đoạn IF: giải sử mua 1 HT, tức là cần 10 ĐTV. như vậy thì chỉ cần lấy số lượng HT nó cần mua*10 là ra giá ? lấy số lượng x 10, xem có lớn hơn tiền trên người thì cho mua.
	if nCount1 < 1 then
		Dialog:Say("Để mua được 2 Mè Đen cần 1 Đồng Tiền Vàng")
	return
	end
		me.AddStackItem(18,1,20308,1,nil,2);
		Task:DelItem(me, tbItemId1, 1);
		me.Msg("Mua thành công 2 Mè Đen , tiêu hảo 1 Đồng Tiền Vàng")
	end;
----- Nhan Thuong ---------------
function tbVuaHung:GiftHopQuaVH()
local nCount555 = me.GetTask(3009,1);
local szMsg = "Ngươi đã sử dụng "..nCount555.." Hộp Quà Vua Hùng.\nSử dụng Hộp Quà Vua Hùng lần thứ 100 , 200 , 300 sẽ nhận được phần thưởng\n"..
"<color=yellow>Lần 100<color>: 1v NHHT + 100tr EXP + 30 Hòa Thị Bích + 2 Tinh Thạch Thánh Hỏa + 10 Chân Nguyên Tu Luyện Đơn + 10 Thánh Linh Bảo Hạp Hồn\n"..
"<color=yellow>Lần 200<color>: 1v5 NHHT + 150tr EXP + 50 Hòa Thị Bích + 3 Tinh Thạch Thánh Hỏa + 13 Chân Nguyên Tu Luyện Đơn + 13 Thánh Linh Bảo Hạp Hồn\n"..
"<color=yellow>Lần 300<color>: 2v NHHT + 200tr EXP + 70 Hòa Thị Bích + 4 Tinh Thạch Thánh Hỏa + 15 Chân Nguyên Tu Luyện Đơn + 15 Thánh Linh Bảo Hạp Hồn\n"
Dialog:Say(szMsg)
end
---- Mua Khuon Banh ---------
function tbVuaHung:MuaKhuonBanh()
		if me.CountFreeBagCell() < 10 then
		Dialog:Say("Hành Trang không đủ chỗ trống.Hãy sắp xếp còn trống 10 ô rồi quay lại gặp ta！");
		return 0;
	end
	local tbItemId1	= {18,10,11,2,0,0};
	local nCount1 = me.GetItemCountInBags(18,10,11,2)
		-->> Giải thích đoạn IF: giải sử mua 1 HT, tức là cần 10 ĐTV. như vậy thì chỉ cần lấy số lượng HT nó cần mua*10 là ra giá ? lấy số lượng x 10, xem có lớn hơn tiền trên người thì cho mua.
	if nCount1 < 1 then
		Dialog:Say("Để mua được 5 Khuôn Làm Bánh cần 1 Đồng Tiền Vàng")
	return
	end
		me.AddStackItem(18,1,20302,1,nil,5);
		Task:DelItem(me, tbItemId1, 1);
		me.Msg("Mua thành công 5 Khuôn Làm Bánh , tiêu hảo 1 Đồng Tiền Vàng")
	end;
---- Lay tui nguyen lieu ---------
function tbVuaHung:NhanTuiNL1()
Dialog:AskNumber("<color=yellow>Số Lượng    <color>", 100, self.muakeo, self);
end
function tbVuaHung:muakeo(szIDVatPham)
me.AddStackItem(18,1,25298,1,nil,szIDVatPham);
end
---------- Nop 2 Loai Banh ------------
function tbVuaHung:NopBanhTet()
if me.CountFreeBagCell() < 5 then
		Dialog:Say("Phải Có 5 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local tbItemId1	= {18,1,20303,1,0,0}; -- Bánh dày
local tbItemId2	= {18,1,20304,1,0,0}; -- Bánh Tét
local nCount1 = me.GetItemCountInBags(18,1,20303,1) -- Bánh dày
local nCount2 = me.GetItemCountInBags(18,1,20304,1) -- Bánh Tét
if nCount1 < 1 or nCount2 < 1 then
Dialog:Say("Cần 1 Bánh dày và 1 Bánh Tét . \nNgươi chỉ có "..nCount1.." Bánh dày , "..nCount2.." Bánh Tét")
return
end
me.AddItem(18,1,20305,1)
me.Msg("Đổi thành công 1 Hộp Quà Vua Hùng")
Task:DelItem(me, tbItemId1, 1);
Task:DelItem(me, tbItemId2, 1);
end
---------- Banh Day --------------
function tbVuaHung:LamBanhDay()
if me.CountFreeBagCell() < 5 then
		Dialog:Say("Phải Có 5 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local tbItemId1	= {18,1,20299,1,0,0}; -- Bình nước
local tbItemId2	= {18,1,20300,1,0,0}; -- Gạo nếp
local nCount1 = me.GetItemCountInBags(18,1,20299,1) -- Bình nước
local nCount2 = me.GetItemCountInBags(18,1,20300,1) -- Gạo nếp
if nCount1 < 3 or nCount2 < 1 then
Dialog:Say("Làm <color=yellow>Bánh Dày<color> cần 3 Bình Nước và 1 Gạo Nếp . \nNgươi chỉ có "..nCount1.." Bình Nước , "..nCount2.." Gạo Nếp")
return
end
me.AddItem(18,1,20303,1)
me.Msg("Đổi thành công 1 Bánh Dày")
Task:DelItem(me, tbItemId1, 3);
Task:DelItem(me, tbItemId2, 1);
end
--------Banh Tet-----
function tbVuaHung:LamBanhTet()
if me.CountFreeBagCell() < 5 then
		Dialog:Say("Phải Có 5 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local tbItemId1	= {18,1,20299,1,0,0}; -- Bình nước
local tbItemId2	= {18,1,20300,1,0,0}; -- Gạo nếp
local tbItemId3	= {18,1,20301,1,0,0}; -- Lá dong
local tbItemId4	= {18,1,20302,1,0,0}; -- Khuôn làm bánh
local nCount1 = me.GetItemCountInBags(18,1,20299,1) -- Bình nước
local nCount2 = me.GetItemCountInBags(18,1,20300,1) -- Gạo nếp
local nCount3 = me.GetItemCountInBags(18,1,20301,1) -- Lá dong
local nCount4 = me.GetItemCountInBags(18,1,20302,1) -- Khuôn làm bánh
if nCount1 < 3 or nCount2 < 2 or nCount3 < 5 or nCount4 < 1 then
Dialog:Say("Làm <color=yellow>Bánh Dày<color> cần 3 Bình Nước + 2 Gạo nếp + 5 Lá Dong + 1 Khuôn Làm Bánh . \nNgươi chỉ có "..nCount1.." Bình Nước , "..nCount2.." Gạo Nếp , "..nCount3.." Lá Dong , "..nCount4.." Khuôn Làm Bánh")
return
end
me.AddItem(18,1,20304,1)
me.Msg("Đổi thành công 1 Bánh Tét")
Task:DelItem(me, tbItemId1, 3);
Task:DelItem(me, tbItemId2, 2);
Task:DelItem(me, tbItemId3, 5);
Task:DelItem(me, tbItemId4, 1);
end