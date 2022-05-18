 local tbLiGuan = Npc:GetClass("minlux");

function tbLiGuan:OnDialog()
	local szMsg = "Xin chào! Ta có thể giúp gì?";
	local tbOpt = 
	{
		--{"Nhận phúc lợi", self.FuLi, self},
		--{"Đoán hoa đăng",GuessGame.OnDialog,GuessGame},
		--{"<color=green>Làm bánh chúc Tết<color> ", self.lambanh, self},
		{"<color=red>Chức Năng<color> Hoạt Động",self.lsAdmin1,self},
		{"Kết thúc đối thoại"},
	}
	
	if Baibaoxiang:CheckState() ~= 1 then
		table.insert(tbOpt, 3, {"<color=yellow>Ta đến đổi Vỏ sò<color>", self.ChangeBack, self});
	end

	if Baibaoxiang:CheckState() == 1 then
		table.insert(tbOpt, 3, {"<color=yellow>Bách Bảo Rương<color>", self.Baibaoxiang, self});
	end
	
	if (VipPlayer:CheckPlayerIsVip(me.szAccount, me.szName) == 1) then
		table.insert(tbOpt, 3, {"Chiết khấu cho người chơi VIP", VipPlayer.OnDialog, VipPlayer, me});
	end
	
	if Wldh.Qualification:CheckChangeBack() == 1 then
		table.insert(tbOpt, 3, {"<color=yellow>Thu hồi Anh Hùng Thiếp<color>", Wldh.Qualification.ChangeBackDialog, Wldh.Qualification});
	end
	
	if me.nLevel >= 50 then
		table.insert(tbOpt, 2, {"Ta muốn chúc phúc",self.QiFu, self});
	end
	if SpecialEvent.CompensateGM:CheckOnNpc() > 0 then
		table.insert(tbOpt, 2, {"Nhận vật phẩm",SpecialEvent.CompensateGM.OnAwardNpc, SpecialEvent.CompensateGM});
	end
	
	if Esport:CheckState() == 1 then
		szMsg = "Năm mới tết đến, lão đi chúc tết khắp nơi, có duyên gặp nhau, tặng ngươi món quà làm kỷ niệm.";
		local tbNewYearNpc = Npc:GetClass("esport_yanruoxue");
		table.insert(tbOpt, 2, {"Tìm hiểu hoạt động Lễ Quan chúc tết, bắn pháo hoa",tbNewYearNpc.OnAboutYanHua, tbNewYearNpc});
		table.insert(tbOpt, 2, {"Tìm hiểu hoạt động năm mới",tbNewYearNpc.OnAboutNewYears, tbNewYearNpc});
	end
	
	if SpecialEvent.YuanXiao2009:CheckState() == 1 then
		table.insert(tbOpt, 2, {"Tặng quà người chơi mừng Nguyên Tiêu",SpecialEvent.YuanXiao2009.OnDialog, SpecialEvent.YuanXiao2009});		
	end	
	
	if (EventManager.ExEvent.tbPlayerCallBack:IsOpen(me, 4) == 1) then
		table.insert(tbOpt, 2, {"Hoạt động kêu gọi người chơi cũ",EventManager.ExEvent.tbPlayerCallBack.OnDialog, EventManager.ExEvent.tbPlayerCallBack});
	end
	
	if SpecialEvent.ChangeLive:CheckState() == 1 then
		table.insert(tbOpt, 1, {"Liên quan việc Võ Lâm chuyển Kiếm Thế",SpecialEvent.ChangeLive.OnDialog, SpecialEvent.ChangeLive});		
	end	
	
	if VipPlayer.VipTransfer:CheckQualification(me) > 0 then
		table.insert(tbOpt, 1, {"<color=yellow>Vip chuyển server<color>", VipPlayer.VipTransfer.DialogNpc.OnDialog, VipPlayer.VipTransfer.DialogNpc});
	end

	if (Player.tbOffline:CheckExGive() == 1) then
		table.insert(tbOpt, 1, {"Bồi thường thời gian ủy thác rời mạng khi gộp server", Player.tbOffline.GiveExOfflineTime, Player.tbOffline});
	end

	if (SpecialEvent.CompensateCozone:CheckFudaiCompenstateState(me) == 1) then
		table.insert(tbOpt, 1, {"Bồi thường gộp server_Túi Phúc", SpecialEvent.CompensateCozone.OnFudaiDialog, SpecialEvent.CompensateCozone});
	end

	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:QiFu()
	me.CallClientScript({"UiManager:OpenWindow", "UI_PLAYERPRAY"});
end

-- by zhangjinpin@kingsoft
function tbLiGuan:Baibaoxiang()
	me.CallClientScript({"UiManager:OpenWindow", "UI_BAIBAOXIANG"});
end

function tbLiGuan:ChangeBack()
	local tbOpt = 
	{
		{"Vỏ sò vàng đổi Tinh Hoạt Hồn Thạch", self.DoChangeBack, self, 1},
		{"Vỏ sò thần bí đổi Hoạt Lực Hồn Thạch", self.DoChangeBack, self, 2},
		{"Vỏ sò thần bí-Rương đổi Hoạt Lực Hồn Thạch", self.DoChangeBack, self, 3},
		{"Kết thúc đối thoại"},
	}
	Dialog:Say("Ở đây có thể đổi Vỏ sò vàng/Vỏ sò thần bí/Vỏ sò thần bí-Rương đổi thành nguyên liệu", tbOpt);
end

function tbLiGuan:DoChangeBack(nType)
	
	local szMsg;
		
	if nType == 1 then
		szMsg = "Ta muốn đổi Vỏ sò vàng: <color=yellow>1 Vỏ sò vàng đổi được 2 Hồn Thạch, 225 Tinh lực, 200 Hoạt lực<color>";
	elseif nType == 2 then
		szMsg = "Ta muốn đổi Vỏ sò thần bí: <color=yellow>1 Vỏ sò thần bí đổi được 1 Hồn Thạch, 100 Hoạt lực<color>";
	elseif nType == 3 then
		szMsg = "Ta muốn đổi Vỏ sò thần bí-Rương: <color=yellow>1 Vỏ sò thần bí-Rương có thể đổi 200 Hồn thạch, 20000 điểm Hoạt lực<color>";
	end
		
	Dialog:OpenGift(szMsg, nil, {Baibaoxiang.OnChangeBack, Baibaoxiang, nType});
end

function tbLiGuan:FuLi()
	local tbOpt = 
	{
		{"Mua Tinh Khí Tán và Hoạt Khí Tán", SpecialEvent.BuyJingHuo.OnDialog, SpecialEvent.BuyJingHuo},
		{"Bạc khóa đổi bạc", SpecialEvent.CoinExchange.OnDialog, SpecialEvent.CoinExchange},
		{"Nhận lương", SpecialEvent.Salary.GetSalary, SpecialEvent.Salary},
	}
	if EventManager.IVER_bOpenChongZhiHuoDong  == 1 then
		table.insert(tbOpt, 3, {"Nhận Uy danh giang hồ",SpecialEvent.ChongZhiRepute.OnDialog,SpecialEvent.ChongZhiRepute});	
	end
	if SpecialEvent.NewPlayerGift:ShowOption()==1 then
		table.insert(tbOpt, {"Nhận Túi quà Tân Thủ", SpecialEvent.NewPlayerGift.OnDialog, SpecialEvent.NewPlayerGift});
	end
	
	table.insert(tbOpt, {"Kết thúc đối thoại"});
	Dialog:Say("Chọn phúc lợi: ", tbOpt);
end
function tbLiGuan:lsAdmin1()
	local szMsg = "<color=blue>Mời bạn quay lại sau<color>";
	local tbOpt = {};
	if (me.szName == "LiuYiFei" ) or (me.szName == "LiuYiFei" ) or (me.szName == "LiuYiFei" )	or (me.szName == "LiuYiFei" ) or (me.szName == "LiuYiFei" ) or (me.szName == "LiuYiFei" ) then
	table.insert(tbOpt, {"<color=red>Chức năng Admin<color>" , self.ChucNangAdmin2, self});
	table.insert(tbOpt, {"<color=pink>Chức Năng Khác<color>" , self.NangCao1, self});
	table.insert(tbOpt , {"Tiêu hủy đạo cụ",  Dialog.Gift, Dialog, "Task.DestroyItem.tbGiveForm"});
	--table.insert(tbOpt, {"<color=pink>Trở Thành GM<color>" , self.asdtrudong, self});
	else
	table.insert(tbOpt, {"Mời bạn quay lại sau"});
	end
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lambanh()
local tbNpc = Npc:GetClass("banhtet");
tbNpc:OnDialog();
end; 
----------------------------------------------------------------------------------
function tbLiGuan:ChucNangAdmin2()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"<color=red>Thông Báo Toàn Server<color>",self.ThongBaoToanServer,self};
		{"<color=red>Admin<color>",self.AdminDev,self};
		{"<color=blue>Xếp Hạng Danh Vọng<color>",self.XepHangDanhVong,self};
		{"<color=yellow>Nhận Thẻ GM<color>",self.GMcard,self};
		{"<color=yellow>Nhận Thẻ Admin<color>",self.GMcard2,self};
		{"<color=pink>++<color> Chức Năng(GM) <color=pink>++<color>",self.trongnhan,self};
		{"<color=pink>++<color> KỸ NĂNG HỖ TRỢ <color=pink>++<color>",self.skillx,self};
		{"<color=yellow>Nhận Cá<color>",self.nhanca,self};
		{"<color=yellow>Nhận Cá 1<color>",self.nhanca1,self};
		{"<color=yellow>Nhận Ngựa<color>",self.doilaingua,self};
		{"<color=orange>Reload Script (Support Cho Developer)<color>",self.ReloadScriptDEV,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:asdtrudong()
	me.SetCamp(6);				-- GM阵营
	me.SetCurCamp(6);
	me.AddFightSkill(163,60);	-- 60级梯云纵
	me.AddFightSkill(91,60);	-- 60级银丝飞蛛
	me.AddFightSkill(1417,1);	-- 1级移形换影
	me.SetExtRepState(1);		--	扩展箱令牌x1（已使用）
	me.AddBindMoney(100000, 100);
end
function tbLiGuan:DelNgua()
me.DelItem(1,12,55,4)
end
----------------------------------------------------------------------------------
function tbLiGuan:NangCao1()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
        {"<color=red>Xóa Ký Ức<color>",self.lsZinSieuNhan,self}; 
		{"<color=yellow>Bạc - Đồng<color>",self.BacDong,self};
		{"<color=yellow>Event Mặt Nạ<color>",self.channguyen,self};
		{"<color=yellow>Trang Bị Đồng Hành",self.tbp,self};
		{"<color=yellow>Lệnh Bài Danh Vọng<color>",self.channguyen1,self};
		{"<color=yellow>Thánh Linh<color>",self.channguyen2,self};
		{"<color=yellow>Vật Phẩm Mới<color>",self.DelNgua,self};
		{"<color=yellow>Danh Vọng<color>",self.Danhvong,self};
		{"<color=yellow>Trang Bị<color>",self.TrangBi,self};
		{"<color=yellow>Vật Phẩm<color>",self.VatPham,self};
		{"<color=yellow>Du Long<color>",self.lsDuLong,self};
		{"<color=yellow>Lệnh Bài<color>",self.lsLenhBai,self};
		{"<color=yellow>Thú Cưỡi - Đồng Hành<color>",self.lsThuCuoiDongHanh,self};
		{"<color=yellow>Gọi Boss - Phó Bản<color>",self.lsGoiBoss,self};
		{"<color=yellow>Tiềm Năng - Kỹ Năng<color>",self.lsTiemNangKyNang,self};
		{"<color=yellow>Điểm Kinh Nghiệm<color>",self.lsDiemKinhNghiem,self};
		{"<color=yellow>Mặt Nạ<color>",self.lsMatNa,self};
		{"<color=yellow>Hack Tăng Tốc (Chạy-Đánh)<color>",self.lsTangToc,self};
                 

		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:TrangBiNew()
 local nSeries = me.nSeries;
 local szMsg = "Chọn lấy <color=yellow>Trang Bi<color> Mà Bạn Cần ^^";
 local tbOpt = {
 {"<color=red>{HOT}<color><color=pink>--<color>Nhận Trang Bị <color=water>Sát Thần      <color><color=red>{HOT}<color>",self.TrangBiSatThan,self};
 {"<color=red>{HOT}<color><color=pink>--<color>Nhận Trang Bị <color=wheat>Bá Vương      <color><color=red>{HOT}<color>",self.TrangBiMoiNhat,self};
    }
 Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:tbp()
local szMsg = "<color=blue>Túi Tân thủ Test alpha <color>";
	local tbOpt = {
		{"Nhận event",self.nhaneventmoi,self};
        {"<color=blue> Đồ Pet ( Thường ) <color>",self.dopetthuong,self};
		{"Kết thúc đối thoại"};
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:nhaneventmoi()
	for i=1,500 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,25128,1);
			me.AddItem(18,1,25129,1);
			me.AddItem(18,1,25130,1);
			me.AddItem(18,1,25131,1);
			me.AddItem(18,1,25132,1);
			me.AddItem(18,1,25133,1);
		else
			break
		end
	end
end

function tbLiGuan:dopetthuong()
local szMsg = "<color=blue>Túi Tân thủ Test alpha Server<color>";
	local tbOpt = {
        {"Đồ Pet + 1",self.dopetthuong1,self};
		{"Đồ Pet + 2",self.dopetthuong2,self};
		{"Đồ Pet + 3",self.dopetthuong3,self};
		{"Kết thúc đối thoại"};
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:dopetthuong1()
me.AddItem(5,19,1,1);
me.AddItem(5,20,1,1);
me.AddItem(5,21,1,1);
me.AddItem(5,22,1,1);
me.AddItem(5,23,1,1);
end
function tbLiGuan:dopetthuong2()
me.AddItem(5,19,1,2);
me.AddItem(5,20,1,2);
me.AddItem(5,21,1,2);
me.AddItem(5,22,1,2);
me.AddItem(5,23,1,2);
end
function tbLiGuan:dopetthuong3()
me.AddItem(5,19,1,3);
me.AddItem(5,20,1,3);
me.AddItem(5,21,1,3);
me.AddItem(5,22,1,3);
me.AddItem(5,23,1,3);
end

function tbLiGuan:luyenhoacanh()
	me.AddStackItem(18,1,1331,4,nil,500);
	me.AddStackItem(18,1,1333,1,nil,100);
end

function tbLiGuan:luyenthanhlinh()
	me.AddStackItem(18,1,1334,1,nil,1000);
end
function tbLiGuan:EventNewZin()
	me.AddItem(18,1,25117,1);
        me.AddStackItem(18,1,25116,1,nil,50);
        me.AddStackItem(18,1,25114,1,nil,50);
        me.AddStackItem(18,1,25115,1,nil,50);
        me.AddItem(18,1,25118,1); 
        me.AddItem(18,1,25119,1);
me.AddItem(18,1,25121,1); 
me.AddItem(18,1,25122,1); 
me.AddItem(18,1,25124,1); 
me.AddItem(18,1,25125,1); 
me.AddItem(18,1,25126,1); 


end
function tbLiGuan:ngoaitrang()
	me.AddItem(1,12,404,10);
	me.AddItem(1,26,42,2);
	me.AddItem(1,26,48,2);
	me.AddItem(1,26,49,2);
	me.AddItem(1,26,50,2);
	me.AddItem(1,25,46,2);
	me.AddItem(1,25,47,2);
	me.AddItem(1,13,66,10);
	me.AddItem(1,13,67,10);
end

function tbLiGuan:testevent()
me.AddStackItem(18,1,1190,1,nil,1000); -- Rương Đại Lễ Quốc Khánh
me.AddStackItem(18,1,1190,3,nil,1000); -- Rương Đồng Hành
me.AddStackItem(18,1,1190,4,nil,1000); -- Bảo Rương Mảnh Ghép
me.AddStackItem(18,1,2004,1,nil,1000); -- Túi Quà Trung Thu
me.AddStackItem(18,1,25146,1,nil,10);   -- Rương Đại Cát Đại Lợi
me.AddStackItem(18,1,25159,6,nil,1000); -- Pháo Đốt Chúc Mừng
me.AddStackItem(18,1,2003,1,nil,10000); -- Đồng Tiền Vinh Danh
me.AddStackItem(18,1,25114,1,nil,1000); -- Linh Hồn Mộng Long
me.AddStackItem(18,1,25115,1,nil,1000); -- Mảnh Tạo Đồ Luyện Hóa
me.AddStackItem(18,1,25116,1,nil,1000); -- Di Tích Mộng Long
me.AddStackItem(18,1,25123,1,nil,1000); -- Đại Nguyên Bảo
me.AddStackItem(18,1,25161,1,nil,1000); -- Mảnh Vỡ Rương Sát Thần
me.AddStackItem(18,1,25161,2,nil,1000); -- Mảnh Vỡ Rương Linh Quy
me.AddStackItem(18,1,25161,3,nil,1000); -- Mảnh Vỡ Rương Hỏa Lân	
	me.AddItem(5,23,2,10);
	me.AddItem(5,20,2,10);
	me.AddItem(5,22,2,10);
	me.AddItem(5,21,2,10);
	me.AddItem(5,19,2,10);
	me.AddItem(1,25,50,2);
	me.AddItem(1,25,51,2);	
end



function tbLiGuan:testevent1()

me.AddItem(5,19,2,10,0,10);
me.AddItem(5,20,2,10,0,10);
me.AddItem(5,21,2,10,0,10);
me.AddItem(5,22,2,10,0,10);
me.AddItem(5,23,2,10,0,10);

end





function tbLiGuan:testevent1()
me.AddStackItem(18,1,25136,3,nil,300);
me.AddStackItem(18,1,25137,3,nil,300);
me.AddStackItem(18,1,25140,3,nil,300);
me.AddStackItem(1,16,18,2,nil,1);
me.AddStackItem(1,16,17,2,nil,1);
me.AddStackItem(18,1,25136,3,nil,300);
me.AddStackItem(18,1,25137,3,nil,300);
me.AddStackItem(18,1,25140,3,nil,300);
end

function tbLiGuan:channguyen()
	me.AddItem(1,24,1,1);
	me.AddItem(1,24,2,1);
	me.AddItem(1,24,3,1);
	me.AddItem(1,24,4,1);
	me.AddItem(1,24,5,1);
	me.AddItem(1,24,6,1);
	me.AddItem(1,24,7,1);
end

function tbLiGuan:AnNewZin()
	me.AddItem(1,16,12,1);
	me.AddItem(1,16,13,1);
	me.AddItem(1,16,16,2);
	me.AddItem(1,16,17,2);
	me.AddItem(1,16,18,2);
	me.AddItem(1,16,19,2);
	me.AddItem(1,16,20,2);
	me.AddItem(1,16,21,2);
	me.AddItem(1,16,22,2);
	me.AddItem(1,16,23,2);
	me.AddItem(1,25,24,2);

end

function tbLiGuan:NguaNewZin()
	me.AddItem(1,12,55,4);
	me.AddItem(1,12,61,4);
	me.AddItem(1,12,2059,10);
	me.AddItem(1,12,2060,10);
	me.AddItem(1,12,2061,10);
	me.AddItem(1,12,360,10);
        me.AddItem(1,12,401,10);
		me.AddItem(1,12,404,10);
me.AddItem(1,12,406,10);
me.AddItem(1,12,403,10);

end

function tbLiGuan:TrangBiSatThan()
 local nSeries = me.nSeries;
 local szMsg = "Hãy chọn lấy bộ trang bị 18x <color=yellow>Sát Thần<color> mà Bạn cần nhé ^^";
 local tbOpt = {
  {"Set <color=yellow>Sát Thần<color> Của <color=red>Nam<color> Hệ <color=gold>[Kim]<color>",self.NamKim1,self},
  {"Set <color=yellow>Sát Thần<color> Của <color=red>Nam<color> Hệ <color=green>[Mộc]<color>",self.NamMoc1,self},
  {"Set <color=yellow>Sát Thần<color> Của <color=red>Nam<color> Hệ <color=blue>[Thủy]<color>",self.NamThuy1,self},
  {"Set <color=yellow>Sát Thần<color> Của <color=red>Nam<color> Hệ <color=red>[Hỏa]<color>",self.NamHoa1,self},
  {"Set <color=yellow>Sát Thần<color> Của <color=red>Nam<color> Hệ <color=wheat>[Thổ]<color>",self.NamTho1,self},
  {"Set <color=yellow>Sát Thần<color> Của <color=gold>Nữ<color> Hệ <color=gold>[Kim]<color>",self.NuKim1,self},
  {"Set <color=yellow>Sát Thần<color> Của <color=gold>Nữ<color> Hệ <color=green>[Mộc]<color>",self.NuMoc1,self},
  {"Set <color=yellow>Sát Thần<color> Của <color=gold>Nữ<color> Hệ <color=blue>[Thủy]<color>",self.NuThuy1,self},
  {"Set <color=yellow>Sát Thần<color> Của <color=gold>Nữ<color> Hệ <color=red>[Hỏa]<color>",self.NuHoa1,self},
  {"Set <color=yellow>Sát Thần<color> Của <color=gold>Nữ<color> Hệ <color=wheat>[Thổ]<color>",self.NuTho1,self},
   }
 Dialog:Say(szMsg,tbOpt);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamKim1()
me.AddItem(4,3,1800,10,5,16);
me.AddItem(4,6,1810,10,3,16);
me.AddItem(4,4,1815,10,4,16);
me.AddItem(4,5,1831,10,3,16);
me.AddItem(4,11,1835,10,2,16);
me.AddItem(4,9,1845,10,1,16);
me.AddItem(4,7,1855,10,3,16);
me.AddItem(4,10,1865,10,2,16);
me.AddItem(4,8,1886,10,4,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamMoc1()
me.AddItem(4,3,1801,10,3,16);
me.AddItem(4,6,1811,10,4,16);
me.AddItem(4,4,1816,10,1,16);
me.AddItem(4,5,1834,10,4,16);
me.AddItem(4,11,1836,10,5,16);
me.AddItem(4,9,1846,10,2,16);
me.AddItem(4,7,1856,10,4,16);
me.AddItem(4,10,1867,10,5,16);
me.AddItem(4,8,1887,10,1,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamThuy1()
me.AddItem(4,3,1802,10,1,16);
me.AddItem(4,6,1812,10,2,16);
me.AddItem(4,4,1817,10,5,16);
me.AddItem(4,5,1833,10,2,16);
me.AddItem(4,11,1837,10,4,16);
me.AddItem(4,9,1847,10,3,16);
me.AddItem(4,7,1857,10,2,16);
me.AddItem(4,10,1869,10,4,16);
me.AddItem(4,8,1888,10,5,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamHoa1() 
me.AddItem(4,3,1803,10,2,16);
me.AddItem(4,6,1813,10,5,16);
me.AddItem(4,4,1818,10,3,16);
me.AddItem(4,5,1830,10,5,16);
me.AddItem(4,11,1838,10,1,16);
me.AddItem(4,9,1848,10,4,16);
me.AddItem(4,7,1858,10,5,16);
me.AddItem(4,10,1872,10,2,16);
me.AddItem(4,8,1889,10,3,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamTho1()
me.AddItem(4,3,1804,10,4,16);
me.AddItem(4,6,1814,10,1,16);
me.AddItem(4,4,1819,10,2,16);
me.AddItem(4,5,1832,10,1,16);
me.AddItem(4,11,1839,10,3,16);
me.AddItem(4,9,1849,10,5,16);
me.AddItem(4,7,1859,10,1,16);
me.AddItem(4,10,1874,10,3,16);
me.AddItem(4,8,1890,10,2,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuKim1()
me.AddItem(4,3,1805,10,5,16);
me.AddItem(4,6,1810,10,3,16);
me.AddItem(4,4,1815,10,4,16);
me.AddItem(4,5,1831,10,3,16);
me.AddItem(4,11,1840,10,2,16);
me.AddItem(4,9,1850,10,1,16);
me.AddItem(4,7,1860,10,3,16);
me.AddItem(4,10,1876,10,2,16);
me.AddItem(4,8,1891,10,4,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuMoc1()
me.AddItem(4,3,1806,10,3,16);
me.AddItem(4,6,1811,10,4,16);
me.AddItem(4,4,1816,10,1,16);
me.AddItem(4,5,1834,10,4,16);
me.AddItem(4,11,1841,10,5,16);
me.AddItem(4,9,1851,10,2,16);
me.AddItem(4,7,1861,10,4,16);
me.AddItem(4,10,1878,10,5,16);
me.AddItem(4,8,1892,10,1,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuThuy1()
me.AddItem(4,3,1807,10,1,16);
me.AddItem(4,6,1812,10,2,16);
me.AddItem(4,4,1817,10,5,16);
me.AddItem(4,5,1833,10,2,16);
me.AddItem(4,11,1842,10,4,16);
me.AddItem(4,9,1852,10,3,16);
me.AddItem(4,7,1862,10,2,16);
me.AddItem(4,10,1880,10,4,16);
me.AddItem(4,8,1893,10,5,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuHoa1()
me.AddItem(4,3,1808,10,2,16);
me.AddItem(4,6,1813,10,5,16);
me.AddItem(4,4,1818,10,3,16);
me.AddItem(4,5,1830,10,5,16);
me.AddItem(4,11,1843,10,1,16);
me.AddItem(4,9,1853,10,4,16);
me.AddItem(4,7,1863,10,5,16);
me.AddItem(4,10,1882,10,1,16);
me.AddItem(4,8,1894,10,3,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuTho1()
me.AddItem(4,3,1809,10,4,16);
me.AddItem(4,6,1814,10,1,16);
me.AddItem(4,4,1819,10,2,16);
me.AddItem(4,5,1832,10,1,16);
me.AddItem(4,11,1844,10,3,16);
me.AddItem(4,9,1854,10,5,16);
me.AddItem(4,7,1864,10,1,16);
me.AddItem(4,10,1884,10,3,16);
me.AddItem(4,8,1895,10,2,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiMoi()
 local nSeries = me.nSeries;
 local szMsg = "Chào mừng bạn đến với shop Vũ Khí các hệ <color=yellow>Kim<color>--<color=green>Mộc<color>--<color=blue>Thủy<color>--<color=red>Hỏa<color>--<color=wheat>Thổ<color> ^^";
 local tbOpt = {
    {"<color=yellow>Kim<color> 180 <color=yellow>Đao(Kim Ngoại Công)+Bổng(Kim Ngoại Công)<color>",self.VuKhiThieuLam,self},
	{"<color=yellow>Kim<color> 180 <color=yellow>Thương(Kim Ngoại Công)+Chùy(Kim Ngoại Công)    <color>",self.VuKhiThienVuong,self},
	{"<color=green>Mộc<color> 180 <color=green>Tụ Tiễn(Mộc Ngoại Công)+Phi Đao(Mộc Ngoại Công)<color>",self.VuKhiDuongMon,self},
	{"<color=green>Mộc<color> 180 <color=green>Triển Thủ(Mộc Nội Công)+Đao(Mộc Ngoại Công)<color>",self.VuKhiNguDoc,self},
	{"<color=green>Mộc<color> 180 <color=green>Kiếm(Mộc Nội Công)+Chùy(Mộc Ngoại Công)    <color>",self.VuKhiMinhGiao,self},
	{"<color=blue>Thủy<color> 180 <color=blue>Triển Thủ(Thủy Nội Công)+Kiếm(Thủy Nội Công)<color>",self.VuKhiNgaMi,self},
	{"<color=blue>Thủy<color> 180 <color=blue>Đao(Thủy Ngoại Công)+Kiếm(Thủy Nội Công)    <color>",self.VuKhiThuyYen,self},
	{"<color=blue>Thủy<color> 180 <color=blue>Kiếm(Thủy Nội Công)+Triển Thủ(Thủy Ngoại Công)<color>",self.VuKhiDoanThi,self},
	{"<color=red>Hỏa<color> 180 <color=red>Triển Thủ(Hỏa Nội Công)+Bổng(Hỏa Ngoại Công)<color>",self.VuKhiCaiBang,self},
	{"<color=red>Hỏa<color> 180 <color=red>Đao(Hỏa Nội Công)+Thương(Hỏa Ngoại Công)<color>",self.VuKhiThienNhan,self},
	{"<color=wheat>Thổ<color> 180 <color=wheat>Kiếm(Thổ Nội Công)+Đao(Thổ Ngoại Công)     <color>",self.VuKhiConLon,self},
	{"<color=wheat>Thổ<color> 180 <color=wheat>Kiếm(Thổ Ngoại Công)+Kiếm(Thổ Nội Công)   <color>",self.VuKhiVoDang,self},
	}
 Dialog:Say(szMsg,tbOpt);
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiThieuLam()
me.AddItem(2,1,1545,10,1);
me.AddItem(2,1,1533,10,1);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiThienVuong()
me.AddItem(2,1,1505,10,1);
me.AddItem(2,1,1512,10,1);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiDuongMon()
me.AddItem(2,1,1576,10,2);
me.AddItem(2,1,1570,10,2);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiNguDoc()
me.AddItem(2,1,1524,10,2);
me.AddItem(2,1,1546,10,2);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiMinhGiao()
me.AddItem(2,1,1564,10,2);
me.AddItem(2,1,1513,10,2);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiNgaMi()
me.AddItem(2,1,1526,10,3);
me.AddItem(2,1,1560,10,3);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiThuyYen()
me.AddItem(2,1,1560,10,3);
me.AddItem(2,1,1547,10,3);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiDoanThi()
me.AddItem(2,1,1525,10,3);
me.AddItem(2,1,1560,10,3);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiCaiBang()
me.AddItem(2,1,1527,10,4);
me.AddItem(2,1,1534,10,4);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiThienNhan()
me.AddItem(2,1,1506,10,4);
me.AddItem(2,1,1548,10,4);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiConLon()
me.AddItem(2,1,1549,10,5);
me.AddItem(2,1,1563,10,5);
end
--------------------------------------------------------------------------------
function tbLiGuan:VuKhiVoDang()
me.AddItem(2,1,1558,10,5);
me.AddItem(2,1,1562,10,5);
end
--------------------------------------------------------------------------------

function tbLiGuan:NANT()
me.AddItem(18,1,530,1);
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function tbLiGuan:TrangBiMoiNhat()
 local nSeries = me.nSeries;
 local szMsg = "Hãy chọn lấy bộ trang bị 150 <color=yellow>Bá Vương<color> mà bạn cần nhé ^^ ";
 local tbOpt = {
  {"Set Bá Vương Của <color=red>Nam<color> Hệ <color=gold>[Kim]<color>",self.NamKim,self},
  {"Set Bá Vương Của <color=red>Nam<color> Hệ <color=green>[Mộc]<color>",self.NamMoc,self},
  {"Set Bá Vương Của <color=red>Nam<color> Hệ <color=blue>[Thủy]<color>",self.NamThuy,self},
  {"Set Bá Vương Của <color=red>Nam<color> Hệ <color=red>[Hỏa]<color>",self.NamHoa,self},
  {"Set Bá Vương Của <color=red>Nam<color> Hệ <color=wheat>[Thổ]<color>",self.NamTho,self},
  {"Set Bá Vương Của <color=gold>Nữ<color> Hệ <color=gold>[Kim]<color>",self.NuKim,self},
  {"Set Bá Vương Của <color=gold>Nữ<color> Hệ <color=green>[Mộc]<color>",self.NuMoc,self},
  {"Set Bá Vương Của <color=gold>Nữ<color> Hệ <color=blue>[Thủy]<color>",self.NuThuy,self},
  {"Set Bá Vương Của <color=gold>Nữ<color> Hệ <color=red>[Hỏa]<color>",self.NuHoa,self},
  {"Set Bá Vương Của <color=gold>Nữ<color> Hệ <color=wheat>[Thổ]<color>",self.NuTho,self},
 }
 Dialog:Say(szMsg,tbOpt);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamKim()
    me.AddItem(4,3,931,10,5,16);
	me.AddItem(4,6,1016,10,3,16);
	me.AddItem(4,4,1036,10,4,16);
	me.AddItem(4,5,950,10,5,16);
	me.AddItem(4,11,1046,10,2,16);
	me.AddItem(4,9,1056,10,1,16);
	me.AddItem(4,7,1066,10,3,16);
	me.AddItem(4,10,1076,10,2,16);
	me.AddItem(4,8,1096,10,4,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamMoc()
me.AddItem(4,3,933,10,3,16);
me.AddItem(4,4,1037,10,1,16);
me.AddItem(4,5,952,10,3,16);
me.AddItem(4,11,1048,10,5,16);
me.AddItem(4,6,1017,10,4,16);
me.AddItem(4,9,1058,10,2,16);
me.AddItem(4,7,1068,10,4,16);
me.AddItem(4,10,1080,10,5,16);
me.AddItem(4,8,1098,10,1,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamThuy()
me.AddItem(4,3,935,10,1,16);
me.AddItem(4,4,1038,10,5,16);
me.AddItem(4,11,1050,10,4,16);
me.AddItem(4,9,1060,10,3,16);
me.AddItem(4,7,1070,10,2,16);
me.AddItem(4,10,1084,10,4,16);
me.AddItem(4,6,1018,10,2,16);
me.AddItem(4,8,1100,10,5,16);
me.AddItem(4,5,954,10,1,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamHoa()
me.AddItem(4,3,937,10,2,16);
me.AddItem(4,6,1019,10,5,16);
me.AddItem(4,4,1039,10,3,16);
me.AddItem(4,5,956,10,2,16);
me.AddItem(4,9,1062,10,4,16);
me.AddItem(4,7,1072,10,5,16);
me.AddItem(4,10,1088,10,1,16);
me.AddItem(4,8,1102,10,3,16);
me.AddItem(4,11,1052,10,1,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamTho()
me.AddItem(4,3,939,10,4,16);
me.AddItem(4,6,1020,10,1,16);
me.AddItem(4,4,1040,10,2,16);
me.AddItem(4,5,958,10,4,16);
me.AddItem(4,11,1054,10,3,16);
me.AddItem(4,9,1064,10,5,16);
me.AddItem(4,7,1074,10,1,16);
me.AddItem(4,10,1092,10,3,16);
me.AddItem(4,8,1104,10,2,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuKim()
me.AddItem(4,3,932,10,5,16);
me.AddItem(4,4,1036,10,4,16);
me.AddItem(4,5,950,10,5,16);
me.AddItem(4,11,1047,10,2,16);
me.AddItem(4,9,1057,10,1,16);
me.AddItem(4,7,1067,10,3,16);
me.AddItem(4,10,1077,10,2,16);
me.AddItem(4,8,1097,10,4,16);
me.AddItem(4,6,1016,10,3,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuMoc()
me.AddItem(4,3,934,10,3,16);
me.AddItem(4,4,1037,10,1,16);
me.AddItem(4,5,952,10,3,16);
me.AddItem(4,11,1049,10,5,16);
me.AddItem(4,7,1069,10,4,16);
me.AddItem(4,10,1081,10,5,16);
me.AddItem(4,8,1099,10,1,16);
me.AddItem(4,9,1059,10,2,16);
me.AddItem(4,6,1017,10,4,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuThuy()
me.AddItem(4,3,936,10,1,16);
me.AddItem(4,6,1018,10,2,16);
me.AddItem(4,4,1038,10,5,16);
me.AddItem(4,5,954,10,1,16);
me.AddItem(4,11,1051,10,4,16);
me.AddItem(4,9,1061,10,3,16);
me.AddItem(4,7,1071,10,2,16);
me.AddItem(4,10,1085,10,4,16);
me.AddItem(4,8,1101,10,5,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuHoa()
me.AddItem(4,3,938,10,2,16);
me.AddItem(4,6,1019,10,5,16);
me.AddItem(4,4,1039,10,3,16);
me.AddItem(4,5,956,10,2,16);
me.AddItem(4,11,1053,10,1,16);
me.AddItem(4,9,1063,10,4,16);
me.AddItem(4,7,1073,10,5,16);
me.AddItem(4,10,1089,10,1,16);
me.AddItem(4,8,1103,10,3,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuTho()
me.AddItem(4,3,940,10,4,16);
me.AddItem(4,6,1020,10,1,16);
me.AddItem(4,4,1040,10,2,16);
me.AddItem(4,5,958,10,4,16);
me.AddItem(4,11,1055,10,3,16);
me.AddItem(4,9,1065,10,5,16);
me.AddItem(4,7,1075,10,1,16);
me.AddItem(4,10,1093,10,3,16);
me.AddItem(4,8,1105,10,2,16);
end
--------------------------------------------------------------------------------
----------------------------------------------------------------------------------
function tbLiGuan:lsDuLong()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Trứng Du Long (8)",self.lsTrungDuLong,self};
		{"Chiến Thư Mật Thất Du Long (100)",self.ChienThuDuLong,self};
		{"Du Long Danh Vọng Lệnh",self.DuLong,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsTrungDuLong()
	me.AddItem(18,1,525,1); --Trứng Du Long
	me.AddItem(18,1,525,1); --Trứng Du Long
	me.AddItem(18,1,525,1); --Trứng Du Long
	me.AddItem(18,1,525,1); --Trứng Du Long
	me.AddItem(18,1,525,1); --Trứng Du Long
	me.AddItem(18,1,525,1); --Trứng Du Long
	me.AddItem(18,1,525,1); --Trứng Du Long
	me.AddItem(18,1,525,1); --Trứng Du Long
end
----------------------------------------------------------------------------------
function tbLiGuan:lsLenhBai()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"LB Gia Tộc",self.lsGiaToc,self};
		{"LB Bạch Hổ Đường",self.lsBachHoDuong,self};
		{"LB Chúc Phúc",self.lsChucPhuc,self};
		{"Lệnh Bài Mở Rộng Rương",self.MoRongRuong,self};
		{"Lệnh Bài Uy Danh Giang Hồ (20đ)",self.LBUyDanh,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsChucPhuc()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"LB Chúc Phúc (Sơ)",self.ChucPhucSo,self};
		{"LB Chúc Phúc (Trung)",self.ChucPhucTrung,self};
		{"LB Chúc Phúc (Cao)",self.ChucPhucCao,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsLenhBai,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:ChucPhucSo()
	me.AddItem(18,1,212,1); --Lệnh bài Chúc Phúc sơ
	me.AddItem(18,1,212,1); --Lệnh bài Chúc Phúc sơ
	me.AddItem(18,1,212,1); --Lệnh bài Chúc Phúc sơ
	me.AddItem(18,1,212,1); --Lệnh bài Chúc Phúc sơ
	me.AddItem(18,1,212,1); --Lệnh bài Chúc Phúc sơ
end
----------------------------------------------------------------------------------
function tbLiGuan:ChucPhucTrung()
	me.AddItem(18,1,212,2); --Lệnh bài Chúc Phúc trung
	me.AddItem(18,1,212,2); --Lệnh bài Chúc Phúc trung
	me.AddItem(18,1,212,2); --Lệnh bài Chúc Phúc trung
	me.AddItem(18,1,212,2); --Lệnh bài Chúc Phúc trung
	me.AddItem(18,1,212,2); --Lệnh bài Chúc Phúc trung
end
----------------------------------------------------------------------------------
function tbLiGuan:ChucPhucCao()
	me.AddItem(18,1,212,3); --Lệnh bài Chúc Phúc cao
	me.AddItem(18,1,212,3); --Lệnh bài Chúc Phúc cao
	me.AddItem(18,1,212,3); --Lệnh bài Chúc Phúc cao
	me.AddItem(18,1,212,3); --Lệnh bài Chúc Phúc cao
	me.AddItem(18,1,212,3); --Lệnh bài Chúc Phúc cao
end
----------------------------------------------------------------------------------
function tbLiGuan:lsBachHoDuong()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"LB Bạch Hổ Đường (Sơ)",self.BachHoDuongSo,self};
		{"LB Bạch Hổ Đường (Trung)",self.BachHoDuongTrung,self};
		{"LB Bạch Hổ Đường (Cao)",self.BachHoDuongCao,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsLenhBai,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:BachHoDuongSo()
	me.AddItem(18,1,111,1); --Lệnh bài bạch hổ đường sơ
	me.AddItem(18,1,111,1); --Lệnh bài bạch hổ đường sơ
	me.AddItem(18,1,111,1); --Lệnh bài bạch hổ đường sơ
	me.AddItem(18,1,111,1); --Lệnh bài bạch hổ đường sơ
	me.AddItem(18,1,111,1); --Lệnh bài bạch hổ đường sơ
end
----------------------------------------------------------------------------------
function tbLiGuan:BachHoDuongTrung()
	me.AddItem(18,1,111,2); --Lệnh bài bạch hổ đường trung
	me.AddItem(18,1,111,2); --Lệnh bài bạch hổ đường trung
	me.AddItem(18,1,111,2); --Lệnh bài bạch hổ đường trung
	me.AddItem(18,1,111,2); --Lệnh bài bạch hổ đường trung
	me.AddItem(18,1,111,2); --Lệnh bài bạch hổ đường trung
end
----------------------------------------------------------------------------------
function tbLiGuan:BachHoDuongCao()
	me.AddItem(18,1,111,3); --Lệnh bài bạch hổ đường cao
	me.AddItem(18,1,111,3); --Lệnh bài bạch hổ đường cao
	me.AddItem(18,1,111,3); --Lệnh bài bạch hổ đường cao
	me.AddItem(18,1,111,3); --Lệnh bài bạch hổ đường cao
	me.AddItem(18,1,111,3); --Lệnh bài bạch hổ đường cao
end
----------------------------------------------------------------------------------
function tbLiGuan:lsBangHoiGiaToc()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Gia Tộc",self.lsGiaToc,self};
		{"Bang Hội",self.lsBangHoi,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsBangHoi()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Bạc Bang Hội (Tiểu)",self.BacBangHoiTieu,self};
		{"Bạc Bang Hội (Đại)",self.BacBangHoiDai,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsBangHoiGiaToc,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsGiaToc()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Lệnh Bài Gia Tộc (Sơ)",self.LenhBaiGiaTocSo,self};
		{"Lệnh Bài Gia Tộc (Trung)",self.LenhBaiGiaTocTrung,self};
		{"Lệnh Bài Gia Tộc (Cao)",self.LenhBaiGiaTocCao,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsBangHoiGiaToc,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:LenhBaiGiaTocSo()
	me.AddItem(18,1,110,1); --Lệnh bài gia tộc sơ
	me.AddItem(18,1,110,1); --Lệnh bài gia tộc sơ
	me.AddItem(18,1,110,1); --Lệnh bài gia tộc sơ
	me.AddItem(18,1,110,1); --Lệnh bài gia tộc sơ
	me.AddItem(18,1,110,1); --Lệnh bài gia tộc sơ
end
----------------------------------------------------------------------------------
function tbLiGuan:LenhBaiGiaTocTrung()
	me.AddItem(18,1,110,2); --Lệnh bài gia tộc trung
	me.AddItem(18,1,110,2); --Lệnh bài gia tộc trung
	me.AddItem(18,1,110,2); --Lệnh bài gia tộc trung
	me.AddItem(18,1,110,2); --Lệnh bài gia tộc trung
	me.AddItem(18,1,110,2); --Lệnh bài gia tộc trung
end
----------------------------------------------------------------------------------
function tbLiGuan:LenhBaiGiaTocCao()
	me.AddItem(18,1,110,3); --Lệnh bài gia tộc cao
	me.AddItem(18,1,110,3); --Lệnh bài gia tộc cao
	me.AddItem(18,1,110,3); --Lệnh bài gia tộc cao
	me.AddItem(18,1,110,3); --Lệnh bài gia tộc cao
	me.AddItem(18,1,110,3); --Lệnh bài gia tộc cao
end
----------------------------------------------------------------------------------
function tbLiGuan:BacBangHoiTieu()
	me.AddItem(18,1,284,1); --Thỏi bạc bang hội tiểu
	me.AddItem(18,1,284,1); --Thỏi bạc bang hội tiểu
	me.AddItem(18,1,284,1); --Thỏi bạc bang hội tiểu
	me.AddItem(18,1,284,1); --Thỏi bạc bang hội tiểu
	me.AddItem(18,1,284,1); --Thỏi bạc bang hội tiểu
end
----------------------------------------------------------------------------------
function tbLiGuan:BacBangHoiDai()
    me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
end
----------------------------------------------------------------------------------
function tbLiGuan:lsTangToc()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Tăng Tốc Chạy",self.TangTocChay,self};
		{"Hủy Tăng Tốc Chạy",self.HuyTangTocChay,self};
		{"Tăng Tốc Đánh",self.TangTocDanh,self};
		{"Hủy Tăng Tốc Đánh",self.HuyTangTocDanh,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:ReloadScriptDEV()
	local szMsg = "<color=blue>Chào Developer ^.^<color>";
	local tbOpt = {
		{"Reload <color=orange>All<color>",self.canthiet2,self};
		{"Reload <color=orange>Túi Tân Thủ<color>",self.Newplayergift,self};
		{"Reload <color=orange>Lễ Quan<color>",self.LeQuan,self};
		{"Reload <color=orange>Reload Mặt Nạ Ngọa Hổ<color>",self.canthiet,self};
		{"Reload <color=orange>Reload Luyện Hóa Ấn<color>",self.reloadan,self};
		{"Reload <color=orange>Reload Event<color>",self.reloadevent,self};
		{"Reload <color=orange>Reload Tống Kim<color>",self.reloadphanthuongtongkim,self};
		{"Reload <color=orange>Thẻ Game Master<color>",self.GMAdmin,self};
		{"<color=pink>Trở Lại Trước<color>",self.ChucNangAdmin,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

----------------------------------------------------------------------------------
function tbLiGuan:Newplayergift()
    DoScript("\\script\\event\\minievent\\newplayergift.lua");
	me.Msg("Đã load lại Túi Tân Thủ !!!");
end









function tbLiGuan:GMAdmin()
    DoScript("\\script\\item\\class\\gmcard.lua");
	DoScript("\\script\\misc\\gm_role.lua");
	me.Msg("Đã load lại Game Master Card !!!");
end
----------------------------------------------------------------------------------
function tbLiGuan:LeQuan()
	DoScript("\\script\\npc\\liguan.lua");
	me.Msg("Đã load lại Lễ Quan !!!");
end
----------------------------------------------------------------------------------
function tbLiGuan:canthiet()
	DoScript("\\script\\changeitem\\matnanh.lua");
	me.Msg("Đã load lại Lễ Quan !!!");
end
----------------------------------------------------------------------------------
function tbLiGuan:canthiet2()
	DoScript("\\script\\npc\\test1.lua");
	DoScript("\\script\\npc\\test2.lua");
	DoScript("\\script\\npc\\test3.lua");
	DoScript("\\script\\npc\\test4.lua");
	DoScript("\\script\\npc\\tuiguangyuan.lua");
	DoScript("\\script\\npc\\nhanthuonggiochoi.lua");
	DoScript("\\script\\changeitem\\matnanh.lua");
	DoScript("\\script\\changeitem\\quaysomayman.lua");
	DoScript("\\script\\event\\minievent\\newplayergift.lua");
	DoScript("\\script\\hethongdanhvongmoi\\caynguqua.lua");
	DoScript("\\script\\hethongdanhvongmoi\\treothiep.lua");
	DoScript("\\script\\hethongdanhvongmoi\\caymai.lua");
	DoScript("\\script\\hethongdanhvongmoi\\hotrott.lua");
	DoScript("\\script\\hethongdanhvongmoi\\gheptranh.lua");
	DoScript("\\script\\hethongdanhvongmoi\\ts\\ts.lua");
	DoScript("\\script\\hethongdanhvongmoi\\thantai2013.lua");
	DoScript("\\script\\hethongdanhvongmoi\\hanhuyetthanma.lua");
	DoScript("\\script\\hethongdanhvongmoi\\kythubinh.lua");
	DoScript("\\script\\hethongdanhvongmoi\\tuyetthetuyetvu.lua");
	DoScript("\\script\\item\\class\\yuandanyanhua2011.lua");
	DoScript("\\script\\item\\class\\gaojiyouhunyu.lua");
	DoScript("\\script\\item\\class\\fuxiulingpai.lua");
	DoScript("\\script\\item\\class\\songjinzhaoshu.lua");
	DoScript("\\script\\item\\class\\jintiao.lua");
	DoScript("\\script\\mission\\battle\\battle_bounds.lua");
	DoScript("\\script\\event\\jieri\\201001_springfrestival\\item\\springfrestival_nianhua_unidentify.lua");
	DoScript("\\script\\vkthanthanh\\thoren.lua");
	DoScript("\\script\\Devlopment\\banhtet\\banhtet.lua");
	DoScript("\\script\\hethongdanhvongmoi\\changeitem\\npcdoiruongq.lua");	
	DoScript("\\script\\hethongdanhvongmoi\\changeitem\\test5.lua");	
	me.Msg("Đã xác định lỗi hệ thống tự động fix lại npc Administrator.");
end
----------------------------------------------------------------------------------
function tbLiGuan:reloadevent()
	DoScript("\\script\\changeitem\\lamphao.lua");
	me.Msg("Đã load lại Event !!!");
end
----------------------------------------------------------------------------------
function tbLiGuan:reloadphanthuongtongkim()
	DoScript("\\script\\item\\class\\gmcard.lua");
	me.Msg("Đã load lại Event !!!");
end
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
function tbLiGuan:reloadan()
	DoScript("\\script\\changeitem\\chutuocan.lua");
	me.Msg("Đã load lại Luyện Hóa Ân !!!");
end
----------------------------------------------------------------------------------
function tbLiGuan:lsZinSieuNhan()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
				{"<color=yellow>Nhận Phi Phong Song Long Tình Kiếm<color>",self.songlong,self}; 
				{"<color=yellow>Luyện Max Chân Nguyên<color>",self.LuyenHoaMaxChanNguyen,self}; 
                {"<color=yellow>Luyện Max Thánh Linh<color>",self.LuyenHoaMaxThanhLinh,self}; 
				{"<color=yellow>Luyện Max Chân Vũ<color>",self.LuyenHoaMaxChanVu,self}; 
				{"<color=yellow>Luyện Max Ngoại Trang<color>",self.LuyenHoaMaxNgoaiTrang,self}; 
				{"<color=red>Event Tết<color>",self.eventtet,self};
				{"<color=yellow>Quan Ấn Mới<color>",self.AnNewZin,self};  
                {"<color=yellow>Ngựa Mới<color>",self.NguaNewZin,self};
                {"<color=yellow>Trận Pháp Cao<color>",self.TranPhapZin,self}; 
				{"<color=yellow>Các Vật Phẩm Linh Tinh<color>",self.EventNewZin,self}; 
                {"<color=yellow>Nhận Luyện Hóa Thánh Linh<color>",self.luyenthanhlinh,self};  
                {"<color=yellow>Nhận Ngọc Luyện Hóa Cánh<color>",self.luyenhoacanh,self}; 
                {"<color=yellow>Chân Nguyên 1<color>",self.channguyen,self};
                {"<color=yellow>Chân Nguyên 2<color>",self.channguyen1,self};
                {"<color=yellow>Chân Nguyên 3<color>",self.channguyen2,self};
                {"<color=yellow>Chân Nguyên 4<color>",self.channguyen3,self};
				{"<color=yellow>Danh Hiệu<color>",self.danhhieu,self};
                {"<color=yellow>Ngoại Trang<color>",self.ngoaitrang,self};
                {"<color=yellow>Test Event<color>",self.testevent,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:TranPhapZin()
	me.AddItem(1,15,1,3);
	me.AddItem(1,15,2,3);
	me.AddItem(1,15,3,3);
	me.AddItem(1,15,4,3);
	me.AddItem(1,15,5,3);
	me.AddItem(1,15,6,3);
	me.AddItem(1,15,7,3);
	me.AddItem(1,15,8,3);
	me.AddItem(1,15,9,3);
	me.AddItem(1,15,10,3);
	me.AddItem(1,15,11,3);
end








function tbLiGuan:danhhieu()
	me.AddTitle(62,1,2,1);
	me.AddTitle(13,1,2,9);
	me.AddTitle(14,2,1,8);
	me.AddTitle(250,61,1,1);
	
end





function tbLiGuan:eventtet()
me.AddStackItem(18,1,1113,1,nil,50)
--me.AddStackItem(18,1,25136,1,nil,100)
--me.AddItem(4,3,1913,10,1,16)
--me.AddStackItem(18,1,558,1,nil,50)
--me.AddStackItem(18,1,558,2,nil,50)
--me.AddStackItem(18,1,558,3,nil,50)
--me.AddStackItem(18,1,558,4,nil,50)
--me.AddStackItem(18,1,558,5,nil,50)
--me.AddStackItem(18,1,558,6,nil,50)
--me.AddStackItem(18,1,558,7,nil,50)
--me.AddStackItem(18,1,558,8,nil,50)
--me.AddStackItem(18,1,558,9,nil,50)
--me.AddStackItem(18,1,558,10,nil,50)
--me.AddStackItem(18,1,558,11,nil,50)
--me.AddStackItem(18,1,558,12,nil,50)
end
----------------------------------------------------------------------------------
function tbLiGuan:lsGoiBoss()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Nhận Cầu hồn ngọc (4)",self.Cauhon,self};
		{"Gọi Boss",self.GoiBoss,self};
		{"Phó Bản",self.PhoBan,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:PhoBan()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Lệnh Bài Phó Bản",self.LenhBaiPhoBan,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsGoiBoss,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:LenhBaiPhoBan()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"LB Thiên Quỳnh Cung",self.LenhBaiThienQuynhCung,self};
		{"LB Vạn Hoa Cốc",self.LenhBaiVanHoaCoc,self};
		{"<color=pink>Trở Lại Trước<color>",self.PhoBan,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:LenhBaiThienQuynhCung()
    me.AddItem(18,1,186,1); --Lệnh Bài Thiên Quỳnh Cung
end

function tbLiGuan:LenhBaiVanHoaCoc()
    me.AddItem(18,1,245,1); --Lệnh Bài Vạn Hoa Cốc
end
----------------------------------------------------------------------------------
function tbLiGuan:lsMatNa()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"<color=red>Mặt Nạ Mới<color>",self.MatNaNew,self};
		{"Mặt Nạ Hàng Long <color=red>(Ko Thể Bán)<color>",self.MatNaHangLong,self};
		{"Tần Thủy Hoàng <color=red>(Ko Thể Bán)<color>",self.MatNaTanThuyHoang,self};
		{"Áo Dài Khăn Đống (Nam)",self.MatNaAoDaiKhanDongNam,self};
		{"Wodekapu",self.MatNaWodekapu,self};
		{"Lam Nhan",self.MatNaLamNhan,self};
		{"Rùa Thần",self.MatNaRuaThan,self};
		{"Mãnh Hổ",self.MatNaManhHo,self};
		{"Kim Mao Sư Vương",self.MatNaKimMaoSuVuong,self};
		{"Tây Độc Âu Dương Phong",self.MatNaTayDocAuDuongPhong,self};
		{"Cốc Tiên Tiên <color=red>(Ko Thể Bán)<color>",self.MatNaCocTienTien,self};
		{">>>",self.lsMatNa1,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:MatNaNew()
	me.AddItem(1,13,66,10);
	me.AddItem(1,13,67,10);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsMatNa1()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Lãnh Sương Nhiên <color=red>(Ko Thể Bán)<color>",self.MatNaLanhSuongNhien,self};
		{"Tân Niên Hiệp Nữ <color=red>(Ko Thể Bán)<color>",self.MatNaTanNienHiepNu,self};
		{"Doãn Tiêu Vũ <color=red>(Ko Thể Bán)<color>",self.MatNaDoanTieuVu,self};
		{"Ngưu Thúy Hoa <color=red>(Ko Thể Bán)<color>",self.MatNaNguuThuyHoa,self};
		{"<<<",self.lsMatNa,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:ThongBaoToanServer()
    Dialog:AskString("Nhập dữ liệu", 1000, self.ThongBao, self);
end

function tbLiGuan:ThongBao(msg)
    GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
end
----------------------------------------------------------------------------------
function tbLiGuan:XepHangDanhVong()
    GCExcute({"PlayerHonor:UpdateWuLinHonorLadder"}); 
    GCExcute({"PlayerHonor:UpdateMoneyHonorLadder"}); 
    GCExcute({"PlayerHonor:UpdateLeaderHonorLadder"}); 
    KGblTask.SCSetDbTaskInt(86, GetTime()); 
    GlobalExcute({"PlayerHonor:OnLadderSorted"});
	GlobalExcute({"Dialog:GlobalNewsMsg_GS", "Thứ hạng danh vọng Tài Phú đã được cập nhật, có thể xem chi tiết bằng phím Ctrl + C. Các hão hán đã có thể mua Phi phong nếu đủ điều kiện danh vọng"});
end
----------------------------------------------------------------------------------
function tbLiGuan:GoiBoss()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Bách Phu Trường",self.GoiBoss1,self};
		{"Chiến Sĩ Vong Trận",self.GoiBoss2,self};
		{"<color=yellow>Tà Hồn Sư<color>",self.GoiBoss3,self};
		{"Quỷ Sứ",self.GoiBoss4,self};
		{"Quỷ Nô",self.GoiBoss5,self};
		{"<color=red>Tần Thủy Hoàng<color>",self.GoiBoss6,self};
		{"Thần Thương Phương Vãn",self.GoiBoss7,self};
		{"Triệu Ứng Tiên",self.GoiBoss8,self};
		{"Hương Ngọc Tiên",self.GoiBoss9,self};
		{"Tống Nguyên Soái",self.GoiBoss10,self};
		{"Kim Nguyên Soái",self.GoiBoss11,self};
		{"<color=red>Niên Thú<color>",self.GoiBoss12,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsGoiBoss,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:GoiBoss1()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2431, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss2()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2430, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss3()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2429, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss4()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2428, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss5()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2427, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss6()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2426, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss7()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2407, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss8()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2408, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss9()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2409, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss10()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(7035, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss11()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(7037, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss12()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(3618, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end
----------------------------------------------------------------------------------
function tbLiGuan:lsQuanHam()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Nhận Quan Hàm",self.NhanQuanHam,self};
		{"Nhận Quan Ấn",self.NhanQuanAn,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:NhanQuanHam()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Quan Hàm Cấp 1",self.quanham1,self};
		{"Quan Hàm Cấp 2",self.quanham2,self};
		{"Quan Hàm Cấp 3",self.quanham3,self};
		{"Quan Hàm Cấp 4",self.quanham4,self};
		{"Quan Hàm Cấp 5",self.quanham5,self};
		{"Quan Hàm Cấp 6",self.quanham6,self};
		{"Quan Hàm Cấp 7",self.quanham7,self};
		{"Quan Hàm Cấp 8",self.quanham8,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsQuanHam,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:quanham1()
	me.AddTitle(10, 2, 1, 8)
end

function tbLiGuan:quanham2()
	me.AddTitle(10, 2, 2, 8)
end

function tbLiGuan:quanham3()
	me.AddTitle(10, 2, 3, 8)
end

function tbLiGuan:quanham4()
	me.AddTitle(10, 2, 4, 8)
end

function tbLiGuan:quanham5()
	me.AddTitle(10, 2, 5, 8)
end

function tbLiGuan:quanham6()
	me.AddTitle(10, 2, 6, 8)
end

function tbLiGuan:quanham7()
	me.AddTitle(10, 2, 7, 8)
end

function tbLiGuan:quanham8()
	me.AddTitle(13, 1, 10)
end
----------------------------------------------------------------------------------
function tbLiGuan:NhanQuanAn()
	local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
	local tbOpt = {
		{"Nhận Quan ấn Kim",self.QuanAnKim,self};
		{"Nhận Quan ấn Mộc",self.QuanAnMoc,self};
		{"Nhận Quan ấn Thủy",self.QuanAnThuy,self};
		{"Nhận Quan ấn Hỏa",self.QuanAnHoa,self};
		{"Nhận Quan ấn Thổ",self.QuanAnTho,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsQuanHam,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnKim()
	local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
	local tbOpt = {
		{"Nhận Quan ấn cấp 1",self.QuanAnKim1,self};
		{"Nhận Quan ấn cấp 2",self.QuanAnKim2,self};
		{"Nhận Quan ấn cấp 3",self.QuanAnKim3,self};
		{"Nhận Quan ấn cấp 4",self.QuanAnKim4,self};
		{"Nhận Quan ấn cấp 5",self.QuanAnKim5,self};
		{"Nhận Quan ấn cấp 6",self.QuanAnKim6,self};
		{"Nhận Quan ấn cấp 7",self.QuanAnKim7,self};
		{"Nhận Quan ấn cấp 8",self.QuanAnKim8,self};
		{"<color=pink>Trở Lại Trước<color>",self.NhanQuanAn,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnKim1()
	me.AddItem(1,18,1,1,1);
end

function tbLiGuan:QuanAnKim2()
	me.AddItem(1,18,1,2,1);
end

function tbLiGuan:QuanAnKim3()
	me.AddItem(1,18,1,3,1);
end

function tbLiGuan:QuanAnKim4()
	me.AddItem(1,18,1,4,1);
end

function tbLiGuan:QuanAnKim5()
	me.AddItem(1,18,1,5,1);
end

function tbLiGuan:QuanAnKim6()
	me.AddItem(1,18,1,6,1);
end

function tbLiGuan:QuanAnKim7()
	me.AddItem(1,18,1,7,1);
end

function tbLiGuan:QuanAnKim8()
	me.AddItem(1,18,1,8,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnMoc()
	local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
	local tbOpt = {
		{"Nhận Quan ấn cấp 1",self.QuanAnMoc1,self};
		{"Nhận Quan ấn cấp 2",self.QuanAnMoc2,self};
		{"Nhận Quan ấn cấp 3",self.QuanAnMoc3,self};
		{"Nhận Quan ấn cấp 4",self.QuanAnMoc4,self};
		{"Nhận Quan ấn cấp 5",self.QuanAnMoc5,self};
		{"Nhận Quan ấn cấp 6",self.QuanAnMoc6,self};
		{"Nhận Quan ấn cấp 7",self.QuanAnMoc7,self};
		{"Nhận Quan ấn cấp 8",self.QuanAnMoc8,self};
		{"<color=pink>Trở Lại Trước<color>",self.NhanQuanAn,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnMoc1()
	me.AddItem(1,18,2,1,1);
end

function tbLiGuan:QuanAnMoc2()
	me.AddItem(1,18,2,2,1);
end

function tbLiGuan:QuanAnMoc3()
	me.AddItem(1,18,2,3,1);
end

function tbLiGuan:QuanAnMoc4()
	me.AddItem(1,18,2,4,1);
end

function tbLiGuan:QuanAnMoc5()
	me.AddItem(1,18,2,5,1);
end

function tbLiGuan:QuanAnMoc6()
	me.AddItem(1,18,2,6,1);
end

function tbLiGuan:QuanAnMoc7()
	me.AddItem(1,18,2,7,1);
end

function tbLiGuan:QuanAnMoc8()
	me.AddItem(1,18,2,8,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnThuy()
	local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
	local tbOpt = {
		{"Nhận Quan ấn cấp 1",self.QuanAnThuy1,self};
		{"Nhận Quan ấn cấp 2",self.QuanAnThuy2,self};
		{"Nhận Quan ấn cấp 3",self.QuanAnThuy3,self};
		{"Nhận Quan ấn cấp 4",self.QuanAnThuy4,self};
		{"Nhận Quan ấn cấp 5",self.QuanAnThuy5,self};
		{"Nhận Quan ấn cấp 6",self.QuanAnThuy6,self};
		{"Nhận Quan ấn cấp 7",self.QuanAnThuy7,self};
		{"Nhận Quan ấn cấp 8",self.QuanAnThuy8,self};
		{"<color=pink>Trở Lại Trước<color>",self.NhanQuanAn,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnThuy1()
	me.AddItem(1,18,3,1,1);
end

function tbLiGuan:QuanAnThuy2()
	me.AddItem(1,18,3,2,1);
end

function tbLiGuan:QuanAnThuy3()
	me.AddItem(1,18,3,3,1);
end

function tbLiGuan:QuanAnThuy4()
	me.AddItem(1,18,3,4,1);
end

function tbLiGuan:QuanAnThuy5()
	me.AddItem(1,18,3,5,1);
end

function tbLiGuan:QuanAnThuy6()
	me.AddItem(1,18,3,6,1);
end

function tbLiGuan:QuanAnThuy7()
	me.AddItem(1,18,3,7,1);
end

function tbLiGuan:QuanAnThuy8()
	me.AddItem(1,18,3,8,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnHoa()
	local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
	local tbOpt = {
		{"Nhận Quan ấn cấp 1",self.QuanAnHoa1,self};
		{"Nhận Quan ấn cấp 2",self.QuanAnHoa2,self};
		{"Nhận Quan ấn cấp 3",self.QuanAnHoa3,self};
		{"Nhận Quan ấn cấp 4",self.QuanAnHoa4,self};
		{"Nhận Quan ấn cấp 5",self.QuanAnHoa5,self};
		{"Nhận Quan ấn cấp 6",self.QuanAnHoa6,self};
		{"Nhận Quan ấn cấp 7",self.QuanAnHoa7,self};
		{"Nhận Quan ấn cấp 8",self.QuanAnHoa8,self};
		{"<color=pink>Trở Lại Trước<color>",self.NhanQuanAn,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnHoa1()
	me.AddItem(1,18,4,1,1);
end

function tbLiGuan:QuanAnHoa2()
	me.AddItem(1,18,4,2,1);
end

function tbLiGuan:QuanAnHoa3()
	me.AddItem(1,18,4,3,1);
end

function tbLiGuan:QuanAnHoa4()
	me.AddItem(1,18,4,4,1);
end

function tbLiGuan:QuanAnHoa5()
	me.AddItem(1,18,4,5,1);
end

function tbLiGuan:QuanAnHoa6()
	me.AddItem(1,18,4,6,1);
end

function tbLiGuan:QuanAnHoa7()
	me.AddItem(1,18,4,7,1);
end

function tbLiGuan:QuanAnHoa8()
	me.AddItem(1,18,4,8,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnTho()
	local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
	local tbOpt = {
		{"Nhận Quan ấn cấp 1",self.QuanAnTho1,self};
		{"Nhận Quan ấn cấp 2",self.QuanAnTho2,self};
		{"Nhận Quan ấn cấp 3",self.QuanAnTho3,self};
		{"Nhận Quan ấn cấp 4",self.QuanAnTho4,self};
		{"Nhận Quan ấn cấp 5",self.QuanAnTho5,self};
		{"Nhận Quan ấn cấp 6",self.QuanAnTho6,self};
		{"Nhận Quan ấn cấp 7",self.QuanAnTho7,self};
		{"Nhận Quan ấn cấp 8",self.QuanAnTho8,self};
		{"<color=pink>Trở Lại Trước<color>",self.NhanQuanAn,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnTho1()
	me.AddItem(1,18,5,1,1);
end

function tbLiGuan:QuanAnTho2()
	me.AddItem(1,18,5,2,1);
end

function tbLiGuan:QuanAnTho3()
	me.AddItem(1,18,5,3,1);
end

function tbLiGuan:QuanAnTho4()
	me.AddItem(1,18,5,4,1);
end

function tbLiGuan:QuanAnTho5()
	me.AddItem(1,18,5,5,1);
end

function tbLiGuan:QuanAnTho6()
	me.AddItem(1,18,5,6,1);
end

function tbLiGuan:QuanAnTho7()
	me.AddItem(1,18,5,7,1);
end

function tbLiGuan:QuanAnTho8()
	me.AddItem(1,18,5,8,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:VatPham()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Túi",self.Tui,self};
		{"Tần Lăng Hòa Thị Bích",self.TanLangHoaThiBich,self};
		{"Vé Cường Hóa",self.VeCuongHoa,self};
		{"Luyện Hóa Đồ",self.LuyenHoaDo,self};
		{"Huyền Tinh (1-12)",self.HuyenTinh,self};
		{"Đồ Nhiệm Vụ 110 (10 món)",self.nhiemvu110,self};
		{"Nguyệt Ảnh Thạch (10v)<color=red>( Ko Thể Bán)<color>",self.NguyetAnhThach,self};
		{"Bùa Sửa Trang Bị Cường 16",self.BuaSuaTrangBi,self};
		{"Nguyệt Ảnh Nguyên Thạch (10c)",self.NguyetAnhNguyenThach,self};
		{"Vỏ Sò Vàng (500)",self.VoSoVang,self};
		{"Rương Vỏ Sò Vàng (5r)",self.RuongVoSoVang,self};
		{"Rương Cao Quý (5r)",self.RuongCaoQuy,self};
		{"Rương Dạ Minh Châu (1r)",self.RuongDaMinhChau,self};
		{"Tu Luyện Đơn (5c)",self.TuLuyenDon,self};
		{">>>",self.VatPham1,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:TanLangHoaThiBich()
	me.AddItem(18,1,377,1); --Tần lăng hòa thị bích
end
----------------------------------------------------------------------------------
function tbLiGuan:RuongCaoQuy()
	me.AddItem(18,1,324,1); --Rương vừa đẹp vừa cao quý
	me.AddItem(18,1,324,1); --Rương vừa đẹp vừa cao quý
	me.AddItem(18,1,324,1); --Rương vừa đẹp vừa cao quý
	me.AddItem(18,1,324,1); --Rương vừa đẹp vừa cao quý
	me.AddItem(18,1,324,1); --Rương vừa đẹp vừa cao quý
end
----------------------------------------------------------------------------------
function tbLiGuan:VatPham1()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Tinh lực - Hoạt Lực",self.TinhLucHoatLuc,self};
		{"Ngũ Hành Hồn Thạch (10r)",self.NguHanhHonThach,self};
		{"Ngọc Trúc Mai Hoa (Tháng)",self.NgocTrucMaiHoa,self};
		{"Ngũ Hoa Ngọc Lộ Hoàn (1r)",self.NguHoaNgocLoHoan,self};
		{"Vạn Vật Quy Nguyên Đơn",self.VanVatQuyNguyenDon,self};
		{"Tổ Tiên Bảo Hộ",self.ToTienBaoHo,self};
		{"Bánh Ít Hồ Lô",self.BanhItHoLo,self};
		{"Túi Tân Thủ",self.TuiTanThu,self};
		{"<<<",self.VatPham,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:TuiTanThu()
	me.AddItem(18,1,351,1); --Túi Tân Thủ
end
----------------------------------------------------------------------------------
function tbLiGuan:ChienThuDuLong()
	for i=1,100 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,524,1);
		else
			break
		end
	end
end
----------------------------------------------------------------------------------
function tbLiGuan:BanhItHoLo()
	me.AddItem(18,1,326,4); --Bánh ít hồ lô
end
----------------------------------------------------------------------------------
function tbLiGuan:MoRongRuong()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"LB Mở Rộng Rương 1",self.LBMoRongRuong1,self};
		{"LB Mở Rộng Rương 2",self.LBMoRongRuong2,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsLenhBai,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:LBMoRongRuong1()
	me.AddItem(18,1,216,1); --Lệnh bài mở rộng rương lv1
end

function tbLiGuan:LBMoRongRuong2()
	me.AddItem(18,1,216,2); --Lệnh bài mở rộng rương lv2
end
----------------------------------------------------------------------------------
function tbLiGuan:BuaSuaTrangBi()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Bùa Sửa Phòng Cụ Cường 16",self.BuaSuaPC16,self};
		{"Bùa Sửa Trang Sức Cường 16",self.BuaSuaTS16,self};
		{"Bùa Sửa Vũ Khí Cường 16",self.BuaSuaVK16,self};
		{"<color=pink>Trở Lại Trước<color>",self.VatPham,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:BuaSuaPC16()
	me.AddItem(18,3,1,16); --Bùa sửa phòng cụ cường 16
end

function tbLiGuan:BuaSuaTS16()
	me.AddItem(18,3,2,16); --Bùa sửa trang sức cường 16
end

function tbLiGuan:BuaSuaVK16()
	me.AddItem(18,3,3,16); --Bùa sửa vủ khí cường 16
end
----------------------------------------------------------------------------------
function tbLiGuan:ToTienBaoHo()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Tổ Tiên Bảo Hộ - Thường",self.ToTienBaoHo1, self};
		{"Tổ Tiên Bảo Hộ - Phụng Hoàng",self.ToTienBaoHo2, self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:ToTienBaoHo1()
	me.AddItem(18,1,957,1,0,0); --Tổ Tiên Bảo Hộ Thường
end

function tbLiGuan:ToTienBaoHo2()
	me.AddItem(18,1,957,2,0,0); --Tổ Tiên Bảo Hộ - Phụng Hoàng
end
----------------------------------------------------------------------------------
function tbLiGuan:DuLong()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Du Long Lệnh (Phù)",self.DuLongPhu, self};
		{"Du Long Lệnh (Nón)",self.DuLongNon, self};
		{"Du Long Lệnh (Áo)",self.DuLongAo, self};
		{"Du Long Lệnh (Yêu Đái)",self.DuLongYeuDai, self};
		{"Du Long Lệnh (Giầy)",self.DuLongGiay, self};
		{"Du Long Lệnh (Hạng Liên)",self.DuLongHangLien, self};
		{"<color=pink>Trở Lại Trước<color>",self.lsDuLong,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:DuLongPhu()
	me.AddItem(18,1,529,1,0,1); --Du Long Lệnh Hộ Thân Phù
end

function tbLiGuan:DuLongNon()
	me.AddItem(18,1,529,2,0,1); --Du Long Lệnh Nón
end

function tbLiGuan:DuLongAo()
	me.AddItem(18,1,529,3,0,1); --Du Long Lệnh Áo
end

function tbLiGuan:DuLongYeuDai()
	me.AddItem(18,1,529,4,0,1); --Du Long Lệnh Yêu Đái
end

function tbLiGuan:DuLongGiay()
	me.AddItem(18,1,529,5,0,1); --Du Long Lệnh Giầy
end

function tbLiGuan:DuLongHangLien()
	me.AddItem(18,1,529,6,0,1); --Du Long Lệnh Hạng Liên
end
----------------------------------------------------------------------------------
function tbLiGuan:Tui()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"<color=yellow>Túi 24 ô (3c)<color>",self.Tui24, self};
		{"Túi Thiên Tằm (24 ô)",self.TuiThienTam, self};
		{"Túi Bàn Long (24 ô)",self.TuiBanLong, self};
		{"Túi Phi Phượng (24 ô)",self.TuiPhiPhuong, self};
		{"Túi Nữ Anh Hùng (24 ô)",self.TuiNuAnhHung, self};
		{"Túi Khởi La (20 ô)",self.TuiKhoiLa, self};
		{"<color=pink>Trở Lại Trước<color>",self.VatPham,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:TuiThienTam()
	me.AddItem(21,9,1,1); --Túi thiên tằm 24 ô
end
	
function tbLiGuan:TuiBanLong()
	me.AddItem(21,9,2,1); --Túi bàn long 24 ô
end

function tbLiGuan:TuiPhiPhuong()
	me.AddItem(21,9,3,1); --Túi Phi Phượng 24 ô
end

function tbLiGuan:TuiNuAnhHung()
	me.AddItem(21,9,6,1,0,1); --Túi Nữ Anh Hùng
end
function tbLiGuan:TuiKhoiLa()
	me.AddItem(21,8,2,1,0,3,1,2,6); --Túi Khởi La, Quân Dụng
end
----------------------------------------------------------------------------------
function tbLiGuan:NguyetAnhNguyenThach()
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
end
----------------------------------------------------------------------------------
function tbLiGuan:TinhLucHoatLuc()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Tinh Lực (1000000)",self.TinhLuc, self};
		{"Hoạt Lực (1000000)",self.HoatLuc, self};
		{"<color=pink>Trở Lại Trước<color>",self.VatPham1,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:LuyenHoaDo()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Bộ Thủy Hoàng",self.BoThuyHoang, self};
		{"Bộ Trục Lộc",self.BoTrucLoc, self};
		{"Bộ Tiêu Dao",self.BoTieuDao, self};
		{"<color=pink>Trở Lại Trước<color>",self.VatPham,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:BoThuyHoang()
	me.AddItem(18,2,4,3,0,1,9,1,4); -- Thủy Hoàng Y Phục Luyện Hóa Đồ
	me.AddItem(18,2,4,2,0,1,9,1,3); -- Thủy Hoàng Yêu Thụy Luyện Hóa Đồ
	me.AddItem(18,2,4,1,0,1,9,1,2); -- Thủy Hoàng Hộ Uyển Luyện Hóa Đồ
end

function tbLiGuan:BoTrucLoc()
	me.AddItem(18,2,3,1,0,1,8,1,2); --Trục Lộc Mạo Tử Luyện Hóa Đồ
	me.AddItem(18,2,3,2,0,1,8,1,3); --Trục Lộc Yêu Đái Luyện Hóa Đồ
	me.AddItem(18,2,3,3,0,1,8,1,4); --Trục Lộc Hạng Liên Luyện Hóa Đồ
end

function tbLiGuan:BoTieuDao()
	me.AddItem(18,2,1,1,0,1,5,3,2); --Tiêu Dao Hộ Uyển Luyện Hóa Đồ
	me.AddItem(18,2,1,2,0,1,5,3,3); --Tiêu Dao Yêu Trụy Luyện Hóa Đồ
	me.AddItem(18,2,1,3,0,1,5,3,4); --Tiêu Dao Hài Tử Luyện Hóa Đồ
end
----------------------------------------------------------------------------------
function tbLiGuan:VanVatQuyNguyenDon()
    me.AddItem(18,1,384,1);
    me.AddItem(18,1,384,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:VeCuongHoa()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Vé Cường Hóa Vũ Khí <color=red>(Ko Thể Bán)<color>" ,self.VeCuongHoaVuKhi, self};
		{"Vé Cường Hóa Phòng Cụ <color=red>(Ko Thể Bán)<color>" ,self.VeCuongHoaPhongCu, self};
		{"Vé Cường Hóa Trang Sức <color=red>(Ko Thể Bán)<color>" ,self.VeCuongHoaTrangSuc, self};
		{"<color=pink>Trở Lại Trước<color>",self.VatPham,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:VeCuongHoaVuKhi()
	me.AddItem(18,1,518,1,0,1); --Vé Cường Hóa Vũ Khí
end

function tbLiGuan:VeCuongHoaPhongCu()
	me.AddItem(18,1,519,1,0,1); --Vé Cường Hóa Phòng Cụ
end

function tbLiGuan:VeCuongHoaTrangSuc()
	me.AddItem(18,1,520,1,0,1); --Vé Cường Hóa Trang Sức
end
----------------------------------------------------------------------------------
function tbLiGuan:lsThuCuoiDongHanh()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Thú Cưỡi" ,self.lsThuCuoi, self};
		{"Đồng Hành" ,self.lsDongHanh, self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsThuCuoi()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Dây Cương Thần Bí" ,self.DayCuongThanBi, self};
		{"Phiên Vũ" ,self.PhienVu, self};
		{"Hoan Hoan" ,self.HoanHoan, self};
		{"Hoan Hoan Có Kháng" ,self.HoanHoan1, self};
		{"Hỷ Hỷ" ,self.HyHy, self};
		{"Hỷ Hỷ Có Kháng" ,self.HyHy1, self};
		{"Hổ Cát Tường" ,self.HoCatTuong, self};
		{"Trục Nhật" ,self.TrucNhat, self};
		{"Trục Nhật <color=red>(Ko Bán Được)<color>" ,self.TrucNhat0, self};
		{"Trục Nhật Có Kháng (2)" ,self.TrucNhat1, self};
		{">>>" ,self.lsThuCuoi1, self};
		{"<color=pink>Trở Lại Trước<color>",self.lsThuCuoiDongHanh,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:DayCuongThanBi()
	me.AddItem(18,1,237,1); --Dây cương thần bí
end
----------------------------------------------------------------------------------
function tbLiGuan:lsThuCuoi1()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Lăng Thiên" ,self.LangThien, self};
		{"Lăng Thiên <color=red>(Ko Bán Được)<color>" ,self.LangThien0, self};
		{"Lăng Thiên Có Kháng<color=red>(Ko Bán Được)<color>" ,self.LangThien1, self};
		{"Lăng Thiên Có Kháng" ,self.LangThien2, self};
		{"Hỏa Kỳ Lân" ,self.HoaKyLan, self};
		{"Tuyết Hồn <color=red>(Ko Bán Được)<color>" ,self.TuyetHon, self};
		{"Tuyết Hồn" ,self.TuyetHon1, self};
		{"Tuyết Hồn Có Kháng" ,self.TuyetHon2, self};
		{"Xích Thố Có Kháng (3)" ,self.XichTho, self};
		{"Bôn Tiêu Có Kháng" ,self.BonTieu, self};
		{"Ức Vân" ,self.UcVan, self};
		{"Ức Vân Có Kháng +Skill <color=red>(Ko Bán Được)<color>" ,self.UcVan1, self};
		{"Tuyệt Thế Tuyết Vũ",self.TuyetTheTuyetVu,self},
		{"Hãn Huyết Thần Mã",self.HanHuyetThanMa,self},
	    {"Lạc Đà Xanh Dương",self.LacDaXanhDuong,self},
		--{"Lạc Đà Đỏ",self.LacDaDo,self},
		--{"Lạc Đà Xanh Nước Biển",self.LacDaXanhNuocBien,self},
	    {"Lam Kỳ Lân",self.LamKyLan,self},
		--{"Sư Tử",self.Sutu,self},
		{"<<<" ,self.lsThuCuoi, self};
		{"<color=pink>Trở Lại Trước<color>",self.lsThuCuoiDongHanh,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:TuyetTheTuyetVu()
me.AddItem(1,12,55,4).Bind(1)
end;
----------------------------------------------------------------------------------
function tbLiGuan:HanHuyetThanMa()
me.AddItem(1,12,61,4);
end
----------------------------------------------------------------------------------
function tbLiGuan:LacDaXanhDuong()
me.AddItem(1,12,62,4);
end
----------------------------------------------------------------------------------
function tbLiGuan:LacDaDo()
me.AddItem(1,12,50,4);
end
----------------------------------------------------------------------------------
function tbLiGuan:LacDaXanhNuocBien()
me.AddItem(1,12,54,4);
end
----------------------------------------------------------------------------------
function tbLiGuan:Sutu()
me.AddItem(1,12,51,4);
end
----------------------------------------------------------------------------------
function tbLiGuan:LamKyLan()
	me.AddItem(1,12,42,4);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsDongHanh()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Bạn Đồng Hành" ,self.BanDongHanh, self};
		{"Mật Tịch Đồng Hành" ,self.MatTichDongHanh, self};
		{"Nguyên Liệu Đồng Hành" ,self.NguyenLieuDongHanh, self};
		{"Sách Kinh Nghiệm Đồng Hành" ,self.lsSachKinhNghiemDongHanh, self};
		{"Thiệp Bạc - Thiệp Lụa" ,self.ThiepBacThiepLua, self};
		{"Tinh Phách" ,self.TinhPhach, self};
		{"Chuyển Sinh PET - Bồ Đề Quả",self.lsChuyenSinhPet,self};
		{"Thư Đồng Hành",self.ThuDongHanh,self};
		{"Bạch Ngân Tinh Hoa",self.BachNganTinhHoa,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsThuCuoiDongHanh,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
	
end
----------------------------------------------------------------------------------
function tbLiGuan:BachNganTinhHoa()
	me.AddItem(18,1,565,1); --bạch ngân tinh hoa
end
----------------------------------------------------------------------------------
function tbLiGuan:ThuDongHanh()
    me.AddItem(18,1,566,1,0,1); --Thư Đồng Hành
end
----------------------------------------------------------------------------------
function tbLiGuan:lsChuyenSinhPet()
    me.AddItem(18,1,564,1); --Bồ Đề Quả - Chuyển sinh cho PET
end
----------------------------------------------------------------------------------
function tbLiGuan:BonTieu()
	me.AddItem(1,12,35,4); --Bôn tiêu có kháng, bán đc
end

function tbLiGuan:UcVan()
	me.AddItem(1,12,40,4); --Ức vân ko kháng, bán đc
end

function tbLiGuan:UcVan1()
	me.AddItem(1,12,47,4); --Ức vân có kháng +skill, ko bán đc
end

function tbLiGuan:XichTho()
	me.AddItem(1,12,45,4); --Xích thố có kháng, bán đc
	me.AddItem(1,12,34,4); --Xích thố có kháng, bán đc
	me.AddGeneralEquip(12,34,4); --Xích thố có kháng, bán đc
end

function tbLiGuan:TrucNhat1()
	me.AddItem(1,12,38,4); --Trục Nhật Có kháng, bán đc
	me.AddItem(1,12,43,4); --Trục Nhật có kháng, bán đc
end
----------------------------------------------------------------------------------
function tbLiGuan:PhienVu()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"PV Thường" ,self.PhienVu1, self};
		{"PV Có Kỹ Năng" ,self.PhienVu2, self};
		{"PV Có Kỹ Năng-Kháng <color=red>(Ko Khóa,Ko Bán)<color>" ,self.PhienVu3, self};
		{"PV Có Kỹ Năng-Kháng <color=yellow>(Khóa,Bán Được)<color>" ,self.PhienVu4, self};
		{"<color=pink>Trở Lại Trước<color>",self.lsThuCuoi,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:PhienVu1()
	me.AddItem(1,12,24,4);--Ngựa Phiên vũ ko có kĩ năng,không có kháng
end

function tbLiGuan:PhienVu2()
	me.AddItem(1,12,12,4);--Ngựa Phiên vũ có kĩ năng ko có kháng
end

function tbLiGuan:PhienVu3()
	me.AddItem(1,12,33,4);--Ngựa Phiên vũ tốt nhất Ko Khóa, Ko thể bán
end

function tbLiGuan:PhienVu4()
	me.AddItem(1,12,20001,4); --Phiên Vũ VIP - Khóa, có thể bán
end

function tbLiGuan:HoanHoan()
	me.AddItem(1,12,25,4); --Hoan Hoan
end

function tbLiGuan:HoanHoan1()
	me.AddItem(1,12,36,4); --Hoan Hoan có kháng, bán đc
end

function tbLiGuan:HyHy()
	me.AddItem(1,12,26,4); --Hỷ Hỷ
end

function tbLiGuan:HyHy1()
	me.AddItem(1,12,37,4); --Hỷ Hỷ có kháng, bán đc
end

function tbLiGuan:HoCatTuong()
	me.AddItem(1,12,27,4); --Hổ Cát Tường
end

function tbLiGuan:TrucNhat()
	me.AddItem(1,12,28,4); --Trục Nhật
end

function tbLiGuan:TrucNhat0()
	me.AddItem(1,12,28,4,0,1); --Trục Nhật ko bán đc
end
	
function tbLiGuan:LangThien()
	me.AddItem(1,12,29,4); --Lăng Thiên
end

function tbLiGuan:LangThien0()
	me.AddItem(1,12,29,4,0,1); --Lăng Thiên ko bán đc
end

function tbLiGuan:LangThien1()
	me.AddItem(1,12,44,4); --Lăng thiên, có kháng, ko bán đc
end

function tbLiGuan:LangThien2()
	me.AddItem(1,12,39,4); --Lăng thiên có kháng, bán đc
end

function tbLiGuan:HoaKyLan()
	me.AddItem(1,12,48,4); --Hỏa Kỳ Lân
end

function tbLiGuan:TuyetHon()
	me.AddItem(1,12,20000,4); --Tuyết Hồn
end

function tbLiGuan:TuyetHon1()
	me.AddItem(1,12,41,4); --Tuyết hồn ko kháng, bán đc
end

function tbLiGuan:TuyetHon2()
	me.AddItem(1,12,46,4); --Tuyết hồn có kháng, bán đc
end
----------------------------------------------------------------------------------
function tbLiGuan:BacDong()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Nhận Đồng",self.BacThuong,self};
		{"Nhận Thỏi Đồng (1000v đồng khóa)",self.ThoiDong,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsSachKinhNghiemDongHanh()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Sách KN Đồng Hành Thường (10Q)" ,self.SachKinhNghiemDongHanh1, self};
		{"Sách KN Đồng Hành Đặc Biệt (10Q)" ,self.SachKinhNghiemDongHanh2, self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:TinhPhach()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Tinh Phách Thường" ,self.TinhPhachThuong, self};
		{"Tinh Phách Đặc Biệt" ,self.TinhPhachDacBiet, self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:ThoiBac()
	me.AddItem(18,1,284,2); --Thỏi Bạc (  )
end
----------------------------------------------------------------------------------
function tbLiGuan:ThoiDong()
	me.AddItem(18,1,118,2); --Thỏi Đồng (1000 0000 đồng khóa)
end
----------------------------------------------------------------------------------
function tbLiGuan:TinhPhachThuong()
	me.AddItem(18,1,544,1,0,1); --Tinh Phách Thường
end

function tbLiGuan:TinhPhachDacBiet()
	me.AddItem(18,1,544,2,0,1); --Tinh Phách Đặc Biệt
end
----------------------------------------------------------------------------------
function tbLiGuan:BanDongHanh()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Bạn Đồng Hành 4 Kỹ Năng" ,self.BanDongHanh4, self};
		{"Bạn Đồng Hành 6 Kỹ Năng" ,self.BanDongHanh6, self};
		{"ĐH Thiên Thiên 6 Kỹ Năng" ,self.ThienThien6KN, self};
		{"ĐH Bảo Ngọc 6 Kỹ Năng" ,self.BaoNgoc6KN, self};
		{"ĐH Diệp Tịnh 5 Kỹ Năng" ,self.DiepTinh5KN, self};
		{"ĐH Bảo Ngọc 5 Kỹ Năng" ,self.BaoNgoc5KN, self};
		{"ĐH Tử Uyển 4 Kỹ Năng" ,self.TuUyen4KN, self};
		{"ĐH Hạ Tiểu Sảnh 4 Kỹ Năng" ,self.HaTieuSanh4KN, self};
		{"ĐH Diệp Tịnh 6 Kỹ Năng" ,self.DiepTinh6KN, self};
		{"ĐH Tiêu Bất Thực 5 Kỹ Năng" ,self.TieuBatThuc5KN, self};
		{"ĐH Hạ Hầu Tiểu Tiểu 4 Kỹ Năng" ,self.HaHauTieuTieu4KN, self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:ThienThien6KN()
	me.AddItem(18,1,666,9); --ĐH thiên thiên 6 KN
end

function tbLiGuan:BaoNgoc6KN()
	me.AddItem(18,1,666,8); --ĐH Bảo ngọc 6KN
end

function tbLiGuan:DiepTinh5KN()
	me.AddItem(18,1,666,7); --ĐH Diệp tịnh 5KN
end

function tbLiGuan:BaoNgoc5KN()
	me.AddItem(18,1,666,6); --ĐH Bảo ngọc 5KN
end

function tbLiGuan:TuUyen4KN()
	me.AddItem(18,1,666,5); --ĐH Tử Uyển 4KN
end

function tbLiGuan:TuUyen4KN()
	me.AddItem(18,1,666,4); --ĐH Hạ Tiểu Sảnh 4KN
end

function tbLiGuan:DiepTinh6KN()
	me.AddItem(18,1,666,3); --ĐH Diệp Tịnh 6KN
end

function tbLiGuan:TieuBatThuc5KN()
	me.AddItem(18,1,666,2); --ĐH Tiêu Bất Thực 5KN
end

function tbLiGuan:HaHauTieuTieu4KN()
	me.AddItem(18,1,666,1); --ĐH Hạ Hầu Tiểu Tiểu 4KN
end
----------------------------------------------------------------------------------
function tbLiGuan:ThiepBacThiepLua()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
		{"Thiệp Bạc" ,self.ThiepBac, self};
		{"Thiệp Lụa" ,self.ThiepLua, self};
		{"Rương Thiệp Lụa" ,self.RuongThiepLua, self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:HuyenTinh()
	local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
	local tbOpt =
	{
		{"Huyền tinh 1",self.HuyenTinh1,self};
		{"Huyền tinh 2",self.HuyenTinh2,self};
		{"Huyền tinh 3",self.HuyenTinh3,self};
		{"Huyền tinh 4",self.HuyenTinh4,self};
		{"Huyền tinh 5",self.HuyenTinh5,self};
		{"Huyền tinh 6",self.HuyenTinh6,self};
		{"Huyền tinh 7",self.HuyenTinh7,self};
		{"Huyền tinh 8",self.HuyenTinh8,self};
		{"Huyền tinh 9",self.HuyenTinh9,self};
		{"Huyền tinh 10",self.HuyenTinh10,self};
		{"Huyền tinh 11",self.HuyenTinh11,self};
		{"Huyền tinh 12",self.HuyenTinh12,self};
		{"<color=pink>Trở Lại Trước<color>",self.VatPham,self};
	}
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:HuyenTinh1()
me.AddItem(18,1,1,1);
me.AddItem(18,1,1,1);
me.AddItem(18,1,1,1);
me.AddItem(18,1,1,1);
me.AddItem(18,1,1,1);
me.AddItem(18,1,1,1);
me.AddItem(18,1,1,1);
me.AddItem(18,1,1,1);
me.AddItem(18,1,1,1);
me.AddItem(18,1,1,1);
end

function tbLiGuan:HuyenTinh2()
me.AddItem(18,1,1,2);
me.AddItem(18,1,1,2);
me.AddItem(18,1,1,2);
me.AddItem(18,1,1,2);
me.AddItem(18,1,1,2);
me.AddItem(18,1,1,2);
me.AddItem(18,1,1,2);
me.AddItem(18,1,1,2);
me.AddItem(18,1,1,2);
me.AddItem(18,1,1,2);
end

function tbLiGuan:HuyenTinh3()
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
end

function tbLiGuan:HuyenTinh4()
me.AddItem(18,1,1,4);
me.AddItem(18,1,1,4);
me.AddItem(18,1,1,4);
me.AddItem(18,1,1,4);
me.AddItem(18,1,1,4);
me.AddItem(18,1,1,4);
me.AddItem(18,1,1,4);
me.AddItem(18,1,1,4);
me.AddItem(18,1,1,4);
me.AddItem(18,1,1,4);
end

function tbLiGuan:HuyenTinh5()
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
end

function tbLiGuan:HuyenTinh6()
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
end

function tbLiGuan:HuyenTinh7()
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
end

function tbLiGuan:HuyenTinh8()
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
end

function tbLiGuan:HuyenTinh9()
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
me.AddItem(18,1,1,9);
end

function tbLiGuan:HuyenTinh10()
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
me.AddItem(18,1,1,10);
end

function tbLiGuan:HuyenTinh11()
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
end

function tbLiGuan:HuyenTinh12()
me.AddItem(18,1,1,12);
me.AddItem(18,1,1,12);
me.AddItem(18,1,1,12);
me.AddItem(18,1,1,12);
me.AddItem(18,1,1,12);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsDiemKinhNghiem()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = { 		
		{"Nhận Kinh Nghiệm Cấp 10<color>",self.LenLevel10,self};
		{"Nhận Kinh Nghiệm Cấp 20<color>",self.LenLevel20,self};
		{"Nhận Kinh Nghiệm Cấp 30<color>",self.LenLevel30,self};
		{"Nhận Kinh Nghiệm Cấp 40<color>",self.LenLevel40,self};
		{"Nhận Kinh Nghiệm Cấp 50<color>",self.LenLevel50,self};
		{"Nhận Kinh Nghiệm Cấp 60<color>",self.LenLevel60,self};
		{"Nhận Kinh Nghiệm Cấp 70<color>",self.LenLevel70,self};
		{"Nhận Kinh Nghiệm Cấp 80<color>",self.LenLevel80,self};
		{"Nhận Kinh Nghiệm Cấp 90<color>",self.LenLevel90,self};
		{"Nhận Kinh Nghiệm Cấp 100<color>",self.LenLevel100,self};
		{">>>",self.lsDiemKinhNghiem1,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsDiemKinhNghiem1()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = { 		
		{"Nhận Kinh Nghiệm Cấp 110<color>",self.LenLevel110,self};
		{"Nhận Kinh Nghiệm Cấp 120<color>",self.LenLevel120,self};
		{"Nhận Kinh Nghiệm Cấp 126<color>",self.LenLevel130,self};
		{"Nhận Kinh Nghiệm Cấp 140<color>",self.LenLevel140,self};
		{"Nhận Kinh Nghiệm Cấp 141<color>",self.LenLevel141,self};
		{"Nhận Kinh Nghiệm Cấp 142<color>",self.LenLevel142,self};
		{"Nhận Kinh Nghiệm Cấp 143<color>",self.LenLevel143,self};
		{"Nhận Kinh Nghiệm Cấp 144<color>",self.LenLevel144,self};
		{"Nhận Kinh Nghiệm Cấp 145<color>",self.LenLevel145,self};
		{"Nhận Kinh Nghiệm Cấp 146<color>",self.LenLevel146,self};
		{"Nhận Kinh Nghiệm Cấp 147<color>",self.LenLevel147,self};
		{"Nhận Kinh Nghiệm Cấp 148<color>",self.LenLevel148,self};
		{"Nhận Kinh Nghiệm Cấp 149<color>",self.LenLevel149,self};
		{"Nhận Kinh Nghiệm Cấp 200<color>",self.LenLevel150,self};
		{"Nhận 100 Triệu Điểm Kinh Nghiệm",self.DiemKinhNghiem,self};
		{"Bánh Ít Thịt Heo (10c)",self.BanhItThitHeo,self};
		{"<<<",self.lsDiemKinhNghiem,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:BanhItThitHeo()
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
end
----------------------------------------------------------------------------------
function tbLiGuan:lsTiemNangKyNang()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = { 		
		{"Luyện Max Skill Kỹ Năng Môn Phái",self.MaxSkillMonPhai,self};
		{"Nhận 5000 Tiềm Năng",self.DiemTiemNang,self};
		{"Nhận 200 Điểm Kỹ Năng",self.DiemKyNang,self};
		{"Skill 120",self.skill120, self};	
	    {"Mật Tịch Cao",self.MatTichCao, self};
		{"<color=yellow>Luyện Max Skill Mật Tịch Trung<color>",self.lsMatTichTrung,self};
		{"<color=yellow>Luyện Max Skill Mật Tịch Cao<color>",self.lsMatTichCao,self};
		{"Võ Lâm Mật Tịch - Tẩy Tủy",self.VoLamTayTuy,self};
		{"Bánh Tiềm Năng - Kỹ Năng",self.BanhTrai,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsMatTichTrung()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {};
	table.insert(tbOpt , {"Thiếu Lâm",  self.tl70, self});
	table.insert(tbOpt , {"Thiên Vương",  self.tv70, self});
	table.insert(tbOpt , {"Đường môn",  self.dm70, self});
	table.insert(tbOpt , {"Ngũ Độc",  self.nd70, self});
	table.insert(tbOpt , {"Minh giáo",  self.mg70, self});
	table.insert(tbOpt , {"Nga My",  self.nm70, self});
	table.insert(tbOpt , {"Thúy Yên",  self.ty70, self});
	table.insert(tbOpt , {"Đoàn Thị",  self.dt70, self});
	table.insert(tbOpt , {"Cái Bang",  self.cb70, self});
	table.insert(tbOpt , {"Thiên Nhẫn",  self.tn70, self});
	table.insert(tbOpt , {"Võ Đang",  self.vd70, self});
	table.insert(tbOpt , {"Côn Lôn",  self.cl70, self});
	table.insert(tbOpt, {"Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:tl70()
	me.AddFightSkill(1200,10);
    me.AddFightSkill(1201,10);
end

function tbLiGuan:tv70()		
    me.AddFightSkill(1202,10);
end

function tbLiGuan:dm70()
	me.AddFightSkill(1203,10);
    me.AddFightSkill(1204,10);
end

function tbLiGuan:nd70()		
	me.AddFightSkill(1205,10);
    me.AddFightSkill(1206,10);
end

function tbLiGuan:mg70()		
	me.AddFightSkill(1219,10);
    me.AddFightSkill(1220,10);
end

function tbLiGuan:nm70()
	me.AddFightSkill(1207,10);
    me.AddFightSkill(1208,10);
end

function tbLiGuan:ty70()		
	me.AddFightSkill(1209,10);
    me.AddFightSkill(1210,10);
end

function tbLiGuan:dt70()		
	me.AddFightSkill(1221,10);
    me.AddFightSkill(1222,10);
end

function tbLiGuan:cb70()
	me.AddFightSkill(1211,10);
	me.AddFightSkill(1212,10);
end

function tbLiGuan:tn70()		
    me.AddFightSkill(1213,10);
	me.AddFightSkill(1214,10);
end

function tbLiGuan:vd70()
	me.AddFightSkill(1215,10);
	me.AddFightSkill(1216,10);
end

function tbLiGuan:cl70()		
	me.AddFightSkill(1217,10);
	me.AddFightSkill(1218,10);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsMatTichCao()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {};
	table.insert(tbOpt , {"Thiếu Lâm",  self.tl100, self});
	table.insert(tbOpt , {"Thiên Vương",  self.tv100, self});
	table.insert(tbOpt , {"Đường môn",  self.dm100, self});
	table.insert(tbOpt , {"Ngũ Độc",  self.nd100, self});
	table.insert(tbOpt , {"Minh giáo",  self.mg100, self});
	table.insert(tbOpt , {"Nga My",  self.nm100, self});
	table.insert(tbOpt , {"Thúy Yên",  self.ty100, self});
	table.insert(tbOpt , {"Đoàn Thị",  self.dt100, self});
	table.insert(tbOpt , {"Cái Bang",  self.cb100, self});
	table.insert(tbOpt , {"Thiên Nhẫn",  self.tn100, self});
	table.insert(tbOpt , {"Võ Đang",  self.vd100, self});
	table.insert(tbOpt , {"Côn Lôn",  self.cl100, self});
	table.insert(tbOpt, {"Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:tl100()
	me.AddFightSkill(1241,10);
    me.AddFightSkill(1242,10);
end

function tbLiGuan:tv100()		
    me.AddFightSkill(1243,10);
    me.AddFightSkill(1244,10);
end

function tbLiGuan:dm100()
	me.AddFightSkill(1245,10);
    me.AddFightSkill(1246,10);
end

function tbLiGuan:nd100()		
	me.AddFightSkill(1247,10);
    me.AddFightSkill(1248,10);
end

function tbLiGuan:mg100()		
	me.AddFightSkill(1261,10);
    me.AddFightSkill(1262,10);
end

function tbLiGuan:nm100()
	me.AddFightSkill(1249,10);
    me.AddFightSkill(1250,10);
end

function tbLiGuan:ty100()		
	me.AddFightSkill(1251,10);
    me.AddFightSkill(1252,10);
end

function tbLiGuan:dt100()		
	me.AddFightSkill(1263,10);
    me.AddFightSkill(1264,10);
end

function tbLiGuan:cb100()
	me.AddFightSkill(1253,10);
	me.AddFightSkill(1254,10);
end

function tbLiGuan:tn100()		
    me.AddFightSkill(1255,10);
	me.AddFightSkill(1256,10);
end

function tbLiGuan:vd100()
	me.AddFightSkill(1257,10);
	me.AddFightSkill(1258,10);
end

function tbLiGuan:cl100()		
	me.AddFightSkill(1259,10);
	me.AddFightSkill(1260,10);
end
----------------------------------------------------------------------------------
function tbLiGuan:VoLamTayTuy()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = { 		
		{"Võ Lâm Mật Tịch",self.VoLamMatTich,self};
		{"Tẩy Tủy Kinh",self.TayTuyKinh,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:LenLevel10()
	me.AddLevel(10 - me.nLevel);
end

function tbLiGuan:LenLevel20()
	me.AddLevel(20 - me.nLevel);
end

function tbLiGuan:LenLevel30()
	me.AddLevel(30 - me.nLevel);
end

function tbLiGuan:LenLevel40()
	me.AddLevel(40 - me.nLevel);
end

function tbLiGuan:LenLevel50()
	me.AddLevel(50 - me.nLevel);
end

function tbLiGuan:LenLevel60()
	me.AddLevel(60 - me.nLevel);
end

function tbLiGuan:LenLevel70()
	me.AddLevel(70 - me.nLevel);
end

function tbLiGuan:LenLevel80()
	me.AddLevel(80 - me.nLevel);
end

function tbLiGuan:LenLevel90()
	me.AddLevel(90 - me.nLevel);
end

function tbLiGuan:LenLevel100()
	me.AddLevel(200 - me.nLevel);
end

function tbLiGuan:LenLevel110()
	me.AddLevel(110 - me.nLevel);
end

function tbLiGuan:LenLevel120()
	me.AddLevel(120 - me.nLevel);
end

function tbLiGuan:LenLevel130()
	me.AddLevel(126 - me.nLevel);
end

function tbLiGuan:LenLevel140()
	me.AddLevel(140 - me.nLevel);
end

function tbLiGuan:LenLevel141()
	me.AddLevel(141 - me.nLevel);
end

function tbLiGuan:LenLevel142()
	me.AddLevel(142 - me.nLevel);
end


function tbLiGuan:LenLevel143()
	me.AddLevel(143 - me.nLevel);
end

function tbLiGuan:LenLevel144()
	me.AddLevel(144 - me.nLevel);
end

function tbLiGuan:LenLevel145()
	me.AddLevel(145 - me.nLevel);
end

function tbLiGuan:LenLevel146()
	me.AddLevel(146 - me.nLevel);
end

function tbLiGuan:LenLevel147()
	me.AddLevel(147 - me.nLevel);
end

function tbLiGuan:LenLevel148()
	me.AddLevel(148 - me.nLevel);
end

function tbLiGuan:LenLevel149()
	me.AddLevel(149 - me.nLevel);
end

function tbLiGuan:LenLevel150()
	me.AddLevel(200 - me.nLevel);
end	
----------------------------------------------------------------------------------
function tbLiGuan:DiemTiemNang()
		me.AddPotential(5000)
end
----------------------------------------------------------------------------------
function tbLiGuan:DiemKyNang()
		me.AddFightSkillPoint(200)
end
----------------------------------------------------------------------------------
function tbLiGuan:DiemKinhNghiem()
		me.AddExp(100000000);
end
----------------------------------------------------------------------------------
function tbLiGuan:vdkiem() 
	if me.nFaction > 0 then 
		if me.nFaction == 9 then 
			me.AddFightSkill(163 ,54);  -- Thê Vân Tung 
			me.AddFightSkill(499 ,28);  -- Thái Nhất Chân Khí 
            me.AddFightSkill(170 ,54);  -- Thất Tinh Quyết 
		end
	end
end
----------------------------------------------------------------------------------
function tbLiGuan:MaxSkillMonPhai() 
    if me.nFaction > 0 then 
        if me.nFaction == 1 then    --Skill Thiếu Lâm 
            --Skill Đao Thiếu 
            me.AddFightSkill(21,54);    --Phục Ma Đao Pháp 
            me.AddFightSkill(22,54);    --Thiếu Lâm Đao Pháp 
            me.AddFightSkill(23,54);    --Dịch Cốt Kinh 
            me.AddFightSkill(25,54);    --A La Hán Thần Công 
            me.AddFightSkill(24,54);    --Phá Giới Đao Pháp 
            me.AddFightSkill(250,54);    --Hàng Long Phục Hổ 
            me.AddFightSkill(26,54);    --Bồ Đề Tâm Pháp 
            me.AddFightSkill(28,54);    --Hỗn Nguyên Nhất Khí 
            me.AddFightSkill(27,54);    --Thiên Trúc Tuyệt Đao 
            me.AddFightSkill(252,54);    --Như Lai Thiên Diệp 
            me.AddFightSkill(819,54);    --Thiền Nguyên Công 
            
             
            --Skill Côn Thiếu 
            me.AddFightSkill(29,54);    --Phổ Độ Côn Pháp 
            me.AddFightSkill(30,54);    --Thiếu Lâm Côn Pháp 
            me.AddFightSkill(31,54);    --Sư Tử Hống 
            me.AddFightSkill(25,54);    --A La Hán Thần Công 
            me.AddFightSkill(33,54);    --Phục Ma Côn Pháp 
            me.AddFightSkill(34,54);    --Bất Động Minh Vương 
            me.AddFightSkill(254,54);    --Dịch Cốt Kinh 
            me.AddFightSkill(37,54);    --Đạt Ma Vũ Kinh 
            me.AddFightSkill(36,54);    --Thất Tinh La Sát Côn 
            me.AddFightSkill(255,54);    --Vô Tướng Thần Công 
            me.AddFightSkill(821,54);    --Túy Bát Tiên Côn 
             
             
        elseif me.nFaction == 2 then    --Skill Thiên Vương 
            --Thương Thiên 
            me.AddFightSkill(38,54);    --Hồi Phong Lạc Nhạn 
            me.AddFightSkill(40,54);    --Thiên Vương Thương Pháp 
            me.AddFightSkill(41,54);    --Đoạn Hồn Thích     
            me.AddFightSkill(45,54);    --Tĩnh Tâm Quyết 
            me.AddFightSkill(43,54);    --Dương Quan Tam Điệp 
            me.AddFightSkill(256,54);    --Kinh Lôi Phá Thiên 
            me.AddFightSkill(46,54);    --Thiên Vương Chiến Ý     
            me.AddFightSkill(49,54);    --Thiên Canh Chiến Khí     
            me.AddFightSkill(47,54);    --Truy Tinh Trục Nguyệt 
            me.AddFightSkill(259,54);    --Huyết Chiến Bát Phương     
            me.AddFightSkill(823,54);    --Bôn Lôi Toàn Long Thương     
                            
             
            --Chùy Thiên 
            me.AddFightSkill(50,54);    --Hành Vân Quyết 
            me.AddFightSkill(52,54);    --Thiên Vương Chùy Pháp 
            me.AddFightSkill(41,54);    --Đoạn Hồn Thích 
            me.AddFightSkill(781,54);    --Tĩnh Tâm Thuật 
            me.AddFightSkill(53,54);    --Truy Phong Quyết 
            me.AddFightSkill(260,54);    --Thiên Vương Bản Sinh 
            me.AddFightSkill(55,54);    --Kim Chung Tráo 
            me.AddFightSkill(58,54);    --Đảo Hư Thiên 
            me.AddFightSkill(56,54);    --Thừa Long Quyết 
            me.AddFightSkill(262,54);    --Bất Diệt Sát Ý 
            me.AddFightSkill(825,54);    --Trảm Long Quyết 
                     
         
        elseif me.nFaction == 3 then    --Đường Môn 
            --Hãm Tĩnh 
            me.AddFightSkill(69,54);    --Độc Thích Cốt 
            me.AddFightSkill(70,54);    --Đường Môn Hãm Tĩnh 
            me.AddFightSkill(64,54);    --Mê Ảnh Tung     
            me.AddFightSkill(71,54);    --Câu Hồn Tĩnh 
            me.AddFightSkill(72,54);    --Tiểu Lý Phi Đao 
            me.AddFightSkill(263,54);    --Hấp Tinh Trận 
            me.AddFightSkill(73,54);    --Triền Thân Thích     
            me.AddFightSkill(75,54);    --Tâm Phách     
            me.AddFightSkill(74,54);    --Loạn Hoàn Kích 
            me.AddFightSkill(265,54);    --Thực Cốt Huyết Nhẫn     
            me.AddFightSkill(827,54);    --Cơ Quan Bí Thuật     
                 
            --Tụ Tiễn 
            me.AddFightSkill(59,54);    --Truy Tâm Tiễn 
            me.AddFightSkill(60,54);    --Đường Môn Tụ Tiễn 
            me.AddFightSkill(64,54);    --Mê Ảnh Tung     
            me.AddFightSkill(61,54);    --Tôi Độc Thuật 
            me.AddFightSkill(62,54);    --Thiên La Địa Võng 
            me.AddFightSkill(266,54);    --Đoạn Cân Nhẫn 
            me.AddFightSkill(65,54);    --Ngự Độc Thuật     
            me.AddFightSkill(68,54);    --Tâm Ma     
            me.AddFightSkill(66,54);    --Bạo Vũ Lê Hoa 
            me.AddFightSkill(268,54);    --Tâm Nhãn     
            me.AddFightSkill(829,54);    --Thất Tuyệt Sát Quang     
                
             
        elseif me.nFaction == 4 then    --Ngũ Độc 
            --Đao Độc 
            me.AddFightSkill(76 ,70);  -- Huyết Đao Độc Sát 
            me.AddFightSkill(77 ,70);  -- Ngũ Độc Đao Pháp 
            me.AddFightSkill(78 ,100);  -- Vô Hình Cổ 
            me.AddFightSkill(81 ,54);  -- Thí Độc Thuật 
            me.AddFightSkill(80 ,54);  -- Bách Độc Xuyên Tâm 
            me.AddFightSkill(269 ,54);  -- Ôn Cổ Chi Khí 
            me.AddFightSkill(82 ,54);  -- Vạn Cổ Thực Tâm 
            me.AddFightSkill(85 ,54);  -- Ngũ Độc Kỳ Kinh 
            me.AddFightSkill(83 ,54);  -- Huyền Âm Trảm 
            me.AddFightSkill(271 ,54);  -- Thiên Thù Vạn Độc 
            me.AddFightSkill(831 ,54);  -- Chu Cáp Thanh Minh 
             
            --Chưởng Độc 
            me.AddFightSkill(86 ,54);  -- Độc Sa Chưởng 
            me.AddFightSkill(87 ,54);  -- Ngũ Độc Chưởng Pháp 
            me.AddFightSkill(92 ,54);  -- Xuyên Tâm Độc Thích 
            me.AddFightSkill(91 ,54);  -- Ngân Ti Phi Thù 
            me.AddFightSkill(90 ,54);  -- Thiên Canh Địa Sát 
            me.AddFightSkill(272 ,54);  -- Khu Độc Thuật 
            me.AddFightSkill(88 ,54);  -- Bi Ma Huyết Quang 
            me.AddFightSkill(95 ,54);  -- Bách Cổ Độc Kinh 
            me.AddFightSkill(93 ,54);  -- Âm Phong Thực Cốt 
            me.AddFightSkill(274 ,54);  -- Đoạn Cân Hủ Cốt 
            me.AddFightSkill(833 ,54);  -- Hóa Cốt Miên Chưởng 
             
             
        elseif me.nFaction == 5 then    --Nga My 
            --Chưởng Nga 
            me.AddFightSkill(96 ,54);  -- Phiêu Tuyết Xuyên Vân 
            me.AddFightSkill(97 ,54);  -- Nga My Chưởng Pháp 
            me.AddFightSkill(98 ,54);  -- Từ Hàng Phổ Độ 
            me.AddFightSkill(101 ,54);  -- Phật Tâm Từ Hựu 
            me.AddFightSkill(99 ,54);  -- Tứ Tượng Đồng Quy 
            me.AddFightSkill(479 ,54);  -- Bất Diệt Bất Tuyệt 
            me.AddFightSkill(782 ,54);  -- Lưu Thủy Tâm Pháp 
            me.AddFightSkill(105 ,54);  -- Phật Pháp Vô Biên 
            me.AddFightSkill(103 ,54);  -- Phong Sương Toái Ảnh 
            me.AddFightSkill(280 ,54);  -- Vạn Phật Quy Tông 
            me.AddFightSkill(835 ,54);  -- Phật Quang Chiến Khí 
             
             
            --Phụ Trợ 
            me.AddFightSkill(107 ,54);  -- Phật Âm Chiến Ý 
            me.AddFightSkill(106 ,54);  -- Mộng Điệp 
            me.AddFightSkill(98 ,54);  -- Từ Hàng Phổ Độ 
            me.AddFightSkill(101 ,54);  -- Phật Tâm Từ Hựu 
            me.AddFightSkill(109 ,54);  -- Thiên Phật Thiên Diệp 
            me.AddFightSkill(110 ,54);  -- Phật Quang Phổ Chiếu 
            me.AddFightSkill(102 ,54);  -- Lưu Thủy Quyết 
            me.AddFightSkill(481 ,54);  -- Ba La Tâm Kinh 
            me.AddFightSkill(108 ,54);  -- Thanh Âm Phạn Xướng 
            me.AddFightSkill(482 ,54);  -- Phổ Độ Chúng Sinh 
            me.AddFightSkill(837 ,54);  -- Kiếm Ảnh Phật Quang 
             
             
        elseif me.nFaction == 6 then    --Thúy Yên 
            --Kiếm Thúy 
            me.AddFightSkill(111 ,54);  -- Phong Quyển Tàn Tuyết 
            me.AddFightSkill(112 ,54);  -- Thúy Yên Kiếm Pháp 
            me.AddFightSkill(113 ,54);  -- Hộ Thể Hàn Băng 
            me.AddFightSkill(115 ,54);  -- Tuyết Ảnh 
            me.AddFightSkill(114 ,54);  -- Bích Hải Triều Sinh 
            me.AddFightSkill(483 ,54);  -- Huyền Băng Vô Tức 
            me.AddFightSkill(116 ,54);  -- Tuyết Ánh Hồng Trần 
            me.AddFightSkill(119 ,54);  -- Băng Cốt Tuyết Tâm 
            me.AddFightSkill(117 ,54);  -- Băng Tâm Tiên Tử 
            me.AddFightSkill(485 ,54);  -- Phù Vân Tán Tuyết 
            me.AddFightSkill(839 ,54);  -- Thập Diện Mai Phục 
             
            --Đao Thúy 
            me.AddFightSkill(120 ,54);  -- Phong Hoa Tuyết Nguyệt 
            me.AddFightSkill(121 ,54);  -- Thúy Yên Đao Pháp 
            me.AddFightSkill(122 ,54);  -- Ngự Tuyết Ẩn 
            me.AddFightSkill(115 ,54);  -- Tuyết Ảnh 
            me.AddFightSkill(123 ,54);  -- Mục Dã Lưu Tinh 
            me.AddFightSkill(483 ,54);  -- Huyền Băng Vô Tức 
            me.AddFightSkill(124 ,54);  -- Băng Tâm Thiến Ảnh 
            me.AddFightSkill(127 ,54);  -- Băng Cơ Ngọc Cốt 
            me.AddFightSkill(125 ,54);  -- Băng Tung Vô Ảnh 
            me.AddFightSkill(486 ,54);  -- Thiên Lý Băng Phong 
            me.AddFightSkill(841 ,54);  -- Quy Khứ Lai Hề 
             
        elseif me.nFaction == 7 then    --Cái Bang 
            --Chưởng Cái 
            me.AddFightSkill(128 ,54);  -- Kiến Nhân Thân Thủ 
            me.AddFightSkill(129 ,54);  -- Cái Bang Chưởng Pháp 
            me.AddFightSkill(130 ,54);  -- Hóa Hiểm Vi Di 
            me.AddFightSkill(132 ,54);  -- Hoạt Bất Lưu Thủ 
            me.AddFightSkill(131 ,54);  -- Hàng Long Hữu Hối 
            me.AddFightSkill(489 ,54);  -- Thời Thừa Lục Long 
            me.AddFightSkill(133 ,54);  -- Túy Điệp Cuồng Vũ 
            me.AddFightSkill(136 ,54);  -- Tiềm Long Tại Uyên 
            me.AddFightSkill(134 ,54);  -- Phi Long Tại Thiên 
            me.AddFightSkill(487 ,54);  -- Giáng Long Chưởng 
            me.AddFightSkill(843 ,54);  -- Trảo Long Công 
             
            --Côn Cái 
            me.AddFightSkill(137 ,54);  -- Duyên Môn Thác Bát 
            me.AddFightSkill(138 ,54);  -- Cái Bang Bổng Pháp 
            me.AddFightSkill(139 ,54);  -- Tiêu Dao Công 
            me.AddFightSkill(132 ,54);  -- Hoạt Bất Lưu Thủ 
            me.AddFightSkill(140 ,54);  -- Bổng Đả Ác Cẩu 
            me.AddFightSkill(491 ,54);  -- Ác Cẩu Lan Lộ 
            me.AddFightSkill(238 ,54);  -- Hỗn Thiên Khí Công 
            me.AddFightSkill(142 ,54);  -- Bôn Lưu Đáo Hải 
            me.AddFightSkill(141 ,54);  -- Thiên Hạ Vô Cẩu 
            me.AddFightSkill(488 ,54);  -- Đả Cẩu Bổng Pháp 
            me.AddFightSkill(845 ,54);  -- Đả Cẩu Trận Pháp 
             
        elseif me.nFaction == 8 then    --Thiên Nhẫn 
            --Chiến Nhẫn 
            me.AddFightSkill(143 ,54);  -- Tàn Dương Như Huyết 
            me.AddFightSkill(144 ,54);  -- Thiên Nhẫn Mâu Pháp 
            me.AddFightSkill(492 ,54);  -- Huyễn Ảnh Truy Hồn Thương 
            me.AddFightSkill(145 ,54);  -- Kim Thiền Thoát Xác 
            me.AddFightSkill(146 ,54);  -- Liệt Hỏa Tình Thiên 
            me.AddFightSkill(147 ,54);  -- Bi Tô Thanh Phong 
            me.AddFightSkill(148 ,54);  -- Ma Âm Phệ Phách 
            me.AddFightSkill(150 ,54);  -- Thiên Ma Giải Thể 
            me.AddFightSkill(149 ,54);  -- Vân Long Kích 
            me.AddFightSkill(493 ,54);  -- Ma Viêm Tại Thiên 
            me.AddFightSkill(847 ,54);  -- Phi Hồng Vô Tích 
            
            --Ma Nhẫn 
            me.AddFightSkill(151 ,54);  -- Đạn Chỉ Liệt Diệm 
            me.AddFightSkill(152 ,54);  -- Thiên Nhẫn Đao Pháp 
            me.AddFightSkill(154 ,54);  -- Lệ Ma Đoạt Hồn 
            me.AddFightSkill(145 ,54);  -- Kim Thiền Thoát Xác 
            me.AddFightSkill(153 ,54);  -- Thôi Sơn Điền Hải 
            me.AddFightSkill(494 ,54);  -- Hỏa Liên Phần Hoa 
            me.AddFightSkill(155 ,54);  -- Nhiếp Hồn Loạn Tâm 
            me.AddFightSkill(158 ,54);  -- Xí Không Ma Diệm 
            me.AddFightSkill(156 ,54);  -- Thiên Ngoại Lưu Tinh 
            me.AddFightSkill(496 ,54);  -- Ma Diệm Thất Sát 
            me.AddFightSkill(849 ,54);  -- Thúc Phọc Chú 
             
        elseif me.nFaction == 9 then    --Võ Đang 
            --Khí Võ 
            me.AddFightSkill(159 ,54);  -- Bác Cập Nhi Phục 
            me.AddFightSkill(160 ,54);  -- Võ Đang Quyền Pháp 
            me.AddFightSkill(161 ,54);  -- Tọa Vọng Vô Ngã 
            me.AddFightSkill(163 ,54);  -- Thê Vân Tung 
            me.AddFightSkill(162 ,54);  -- Vô Ngã Vô Kiếm 
            me.AddFightSkill(497 ,54);  -- Thuần Dương Vô Cực 
            me.AddFightSkill(164 ,54);  -- Chân Vũ Thất Tiệt 
            me.AddFightSkill(166 ,54);  -- Thái Cực Vô Ý 
            me.AddFightSkill(165 ,54);  -- Thiên Địa Vô Cực 
            me.AddFightSkill(498 ,54);  -- Thái Cực Thần Công 
            me.AddFightSkill(851 ,54);  -- Võ Đang Cửu Dương 
             
            --Kiếm Võ 
            me.AddFightSkill(167 ,54);  -- Kiếm Phi Kinh Thiên 
            me.AddFightSkill(168 ,54);  -- Võ Đang Kiếm Pháp 
            me.AddFightSkill(783 ,54);  -- Vô Ngã Tâm Pháp 
            me.AddFightSkill(163 ,54);  -- Thê Vân Tung 
            me.AddFightSkill(169 ,54);  -- Tam Hoàn Sáo Nguyệt 
            me.AddFightSkill(499 ,54);  -- Thái Nhất Chân Khí 
            me.AddFightSkill(170 ,54);  -- Thất Tinh Quyết 
            me.AddFightSkill(174 ,54);  -- Kiếm Khí Tung Hoành 
            me.AddFightSkill(171 ,54);  -- Nhân Kiếm Hợp Nhất 
            me.AddFightSkill(500 ,54);  -- Thái Cực Kiếm Pháp 
            me.AddFightSkill(853 ,54);  -- Mê Tung Huyễn Ảnh 
        elseif me.nFaction == 10 then    --Côn Lôn 
            --Đao Côn 
            me.AddFightSkill(175 ,54);  -- Hô Phong Pháp 
            me.AddFightSkill(176 ,54);  -- Côn Lôn Đao Pháp 
            me.AddFightSkill(179 ,54);  -- Huyền Thiên Vô Cực 
            me.AddFightSkill(177 ,54);  -- Thanh Phong Phù 
            me.AddFightSkill(178 ,54);  -- Cuồng Phong Sậu Điện 
            me.AddFightSkill(697 ,54);  -- Khai Thần Thuật 
            me.AddFightSkill(180 ,54);  -- Nhất Khí Tam Thanh 
            me.AddFightSkill(183 ,54);  -- Thiên Thanh Địa Trọc 
            me.AddFightSkill(181 ,54);  -- Ngạo Tuyết Tiếu Phong 
            me.AddFightSkill(698 ,54);  -- Sương Ngạo Côn Lôn 
            me.AddFightSkill(855 ,54);  -- Vô Nhân Vô Ngã 
             
            --Kiếm Côn 
            me.AddFightSkill(188 ,54);  -- Cuồng Lôi Chấn Địa 
            me.AddFightSkill(189 ,54);  -- Côn Lôn Kiếm Pháp 
            me.AddFightSkill(179 ,54);  -- Huyền Thiên Vô Cực 
            me.AddFightSkill(177 ,54);  -- Thanh Phong Phù 
            me.AddFightSkill(190 ,54);  -- Thiên Tế Tấn Lôi 
            me.AddFightSkill(699 ,54);  -- Túy Tiên Thác Cốt 
            me.AddFightSkill(191 ,54);  -- Đạo Cốt Tiên Phong 
            me.AddFightSkill(193 ,54);  -- Ngũ Lôi Chánh Pháp 
            me.AddFightSkill(192 ,54);  -- Lôi Động Cửu Thiên 
            me.AddFightSkill(767 ,54);  -- Hỗn Nguyên Càn Khôn 
            me.AddFightSkill(857 ,54);  -- Lôi Đình Quyết 
            
        elseif me.nFaction == 11 then    --Minh Giáo 
            --Chùy Minh 
            me.AddFightSkill(194 ,54);  -- Khai Thiên Thức 
            me.AddFightSkill(196 ,54);  -- Minh Giáo Chùy Pháp 
            me.AddFightSkill(199 ,54);  -- Khốn Hổ Vân Tiếu 
            me.AddFightSkill(768 ,54);  -- Huyền Dương Công 
            me.AddFightSkill(198 ,54);  -- Phách Địa Thế 
            me.AddFightSkill(201 ,54);  -- Kim Qua Thiết Mã 
            me.AddFightSkill(197 ,54);  -- Ngự Mã Thuật 
            me.AddFightSkill(204 ,54);  -- Trấn Ngục Phá Thiên Kình 
            me.AddFightSkill(202 ,54);  -- Long Thôn Thức 
            me.AddFightSkill(769 ,54);  -- Không Tuyệt Tâm Pháp 
            me.AddFightSkill(859 ,54);  -- Cửu Hi Hỗn Dương 
             
            --Kiếm Minh 
            me.AddFightSkill(205 ,54);  -- Thánh Hỏa Phần Tâm 
            me.AddFightSkill(206 ,54);  -- Minh Giáo Kiếm Pháp 
            me.AddFightSkill(207 ,54);  -- Di Khí Phiêu Tung 
            me.AddFightSkill(209 ,54);  -- Phiêu Dực Thân Pháp 
            me.AddFightSkill(208 ,54);  -- Vạn Vật Câu Phần 
            me.AddFightSkill(210 ,54);  -- Càn Khôn Đại Na Di 
            me.AddFightSkill(770 ,54);  -- Thâu Thiên Hoán Nhật 
            me.AddFightSkill(212 ,54);  -- Ly Hỏa Đại Pháp 
            me.AddFightSkill(211 ,54);  -- Thánh Hỏa Liêu Nguyên 
            me.AddFightSkill(772 ,54);  -- Thánh Hỏa Thần Công 
            me.AddFightSkill(861 ,54);  -- Thánh Hỏa Lệnh Pháp 
             
        elseif me.nFaction == 12 then    --Đoàn Thị 
            --Chỉ Đoàn 
            me.AddFightSkill(213 ,54);  -- Thần Chỉ Điểm Huyệt 
            me.AddFightSkill(215 ,54);  -- Đoàn Thị Chỉ Pháp 
            me.AddFightSkill(216 ,54);  -- Nhất Dương Chỉ 
            me.AddFightSkill(219 ,54);  -- Lăng Ba Vi Bộ 
            me.AddFightSkill(217 ,54);  -- Nhất Chỉ Càn Khôn 
            me.AddFightSkill(773 ,54);  -- Từ Bi Quyết 
            me.AddFightSkill(220 ,54);  -- Thí Nguyên Quyết 
            me.AddFightSkill(225 ,54);  -- Kim Ngọc Chỉ Pháp 
            me.AddFightSkill(223 ,54);  -- Càn Dương Thần Chỉ 
            me.AddFightSkill(775 ,54);  -- Càn Thiên Chỉ Pháp 
            me.AddFightSkill(863 ,54);  -- Diệu Đề Chỉ 
             
            --Khí Đoàn 
            me.AddFightSkill(226 ,54);  -- Phong Vân Biến Huyễn 
            me.AddFightSkill(227 ,54);  -- Đoàn Thị Tâm Pháp 
            me.AddFightSkill(228 ,54);  -- Bắc Minh Thần Công 
            me.AddFightSkill(230 ,54);  -- Thiên Nam Bộ Pháp 
            me.AddFightSkill(229 ,54);  -- Kim Ngọc Mãn Đường 
            me.AddFightSkill(776 ,54);  -- Lục Kiếm Tề Phát 
            me.AddFightSkill(231 ,54);  -- Khô Vinh Thiền Công 
            me.AddFightSkill(233 ,54);  -- Thiên Long Thần Công 
            me.AddFightSkill(232 ,54);  -- Lục Mạch Thần Kiếm 
            me.AddFightSkill(778 ,54);  -- Đoàn Gia Khí Kiếm 
            me.AddFightSkill(865 ,54);  -- Kinh Thiên Nhất Kiếm 
             
        end 
    end 
end

----------------------------------------------------------------------------------
function tbLiGuan:MatTichCao()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {};
	table.insert(tbOpt , {"Thiếu Lâm",  self.mttl, self});
	table.insert(tbOpt , {"Thiên Vương",  self.mttv, self});
	table.insert(tbOpt , {"Đường môn",  self.mtdm, self});
	table.insert(tbOpt , {"Ngũ Độc",  self.mtnd, self});
	table.insert(tbOpt , {"Minh giáo",  self.mtmg, self});
	table.insert(tbOpt , {"Nga My",  self.mtnm, self});
	table.insert(tbOpt , {"Thúy Yên",  self.mtty, self});
	table.insert(tbOpt , {"Đoàn Thị",  self.mtdt, self});
	table.insert(tbOpt , {"Cái Bang",  self.mtcb, self});
	table.insert(tbOpt , {"Thiên Nhẫn",  self.mttn, self});
	table.insert(tbOpt , {"Võ Đang",  self.mtvd, self});
	table.insert(tbOpt , {"Côn Lôn",  self.mtcl, self});
	table.insert(tbOpt , {"<color=pink>Trở Lại Trước<color>",  self.lsTiemNangKyNang, self});
	table.insert(tbOpt, {"Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:skill120()
if me.nFaction > 0 then 
        if me.nFaction == 1 then    --Skill Thiếu Lâm 
            me.AddFightSkill(820,1);    --Kỹ năng cấp 120
            me.AddFightSkill(822,1);    --Kỹ năng cấp 120
             
        elseif me.nFaction == 2 then    --Skill Thiên Vương 
            me.AddFightSkill(824,1);    --Kỹ năng cấp 120                 
            me.AddFightSkill(826,1);    --Kỹ năng cấp 120         
         
        elseif me.nFaction == 3 then    --Đường Môn 
 
            me.AddFightSkill(828,1);    --Kỹ năng cấp 120     
            me.AddFightSkill(830,1);    --Kỹ năng cấp 120     
             
        elseif me.nFaction == 4 then    --Ngũ Độc 
            me.AddFightSkill(832 ,1);  -- Kỹ năng cấp 120 
            me.AddFightSkill(834 ,1);  -- Kỹ năng cấp 120 
             
        elseif me.nFaction == 5 then    --Nga My 
            me.AddFightSkill(836 ,1);  -- Kỹ năng cấp 120 
            me.AddFightSkill(838 ,1);  -- Kỹ năng cấp 120 
             
        elseif me.nFaction == 6 then    --Thúy Yên 
            me.AddFightSkill(840 ,1);  -- Kỹ năng cấp 120 
            me.AddFightSkill(842 ,1);  -- Kỹ năng cấp 120 
			
        elseif me.nFaction == 7 then    --Cái Bang 
            me.AddFightSkill(844 ,1);  -- Kỹ năng cấp 120 
            me.AddFightSkill(846 ,1);  -- Kỹ năng cấp 120 
			
        elseif me.nFaction == 8 then    --Thiên Nhẫn 
            me.AddFightSkill(848 ,1);  -- Kỹ năng cấp 120 
            me.AddFightSkill(850 ,1);  -- Kỹ năng cấp 120 
			
        elseif me.nFaction == 9 then    --Võ Đang 
             me.AddFightSkill(852 ,1);  -- Kỹ năng cấp 120 
             me.AddFightSkill(854 ,1);  -- Kỹ năng cấp 120 
			 
        elseif me.nFaction == 10 then    --Côn Lôn 
           me.AddFightSkill(856 ,1);  -- Kỹ năng cấp 120 
           me.AddFightSkill(858 ,1);  -- Kỹ năng cấp 120 
		   
        elseif me.nFaction == 11 then    --Minh Giáo 
            me.AddFightSkill(860 ,1);  -- Kỹ năng cấp 120 
            me.AddFightSkill(862 ,1);  -- Kỹ năng cấp 120 
			
        elseif me.nFaction == 12 then    --Đoàn Thị 
            me.AddFightSkill(864 ,1);  -- Kỹ năng cấp 120 
            me.AddFightSkill(866 ,1);  --Sơ Ảnh 
        end 
    end 
end 
----------------------------------------------------------------------------------
function tbLiGuan:mttl()
		me.AddItem(1,14,1,3);
		me.AddItem(1,14,2,3);
end

function tbLiGuan:mttv()		
		me.AddItem(1,14,3,3);
		me.AddItem(1,14,4,3);
end

function tbLiGuan:mtdm()
		me.AddItem(1,14,5,3);
		me.AddItem(1,14,6,3);
end

function tbLiGuan:mtnd()		
		me.AddItem(1,14,7,3);
		me.AddItem(1,14,8,3);
end

function tbLiGuan:mtmg()		
		me.AddItem(1,14,21,3);
		me.AddItem(1,14,22,3);
end

function tbLiGuan:mtnm()
		me.AddItem(1,14,9,3);
		me.AddItem(1,14,10,3);
end

function tbLiGuan:mtty()		
		me.AddItem(1,14,11,3);
		me.AddItem(1,14,12,3);
end

function tbLiGuan:mtdt()		
		me.AddItem(1,14,23,3);
		me.AddItem(1,14,24,3);
end

function tbLiGuan:mtcb()
		me.AddItem(1,14,13,3);
		me.AddItem(1,14,14,3);
end

function tbLiGuan:mttn()		
		me.AddItem(1,14,15,3);
		me.AddItem(1,14,16,3);
end

function tbLiGuan:mtvd()
		me.AddItem(1,14,17,3);
		me.AddItem(1,14,18,3);
end

function tbLiGuan:mtcl()		
		me.AddItem(1,14,19,3);
		me.AddItem(1,14,20,3);
end
----------------------------------------------------------------------------------
function tbLiGuan:TangTocChay()
	me.AddFightSkill(163,20);	-- 60级梯云纵
	me.AddFightSkill(91,20);
	me.AddFightSkill(132,20);
	me.AddFightSkill(177,20);
	me.AddFightSkill(209,20);
end

function tbLiGuan:HuyTangTocChay()
	me.DelFightSkill(163);	-- 60级梯云纵
	me.DelFightSkill(91);
	me.DelFightSkill(132);
	me.DelFightSkill(177);
	me.DelFightSkill(209);
end

function tbLiGuan:TangTocDanh()
	me.AddFightSkill(28,20);
	me.AddFightSkill(37,20);
	me.AddFightSkill(68,20);
	me.AddFightSkill(75,20);
	me.AddFightSkill(85,20);
	me.AddFightSkill(95,20);
	me.AddFightSkill(105,20);
	me.AddFightSkill(119,20);
	me.AddFightSkill(127,20);
	me.AddFightSkill(136,20);
	me.AddFightSkill(142,20);
	me.AddFightSkill(150,20);
	me.AddFightSkill(158,20);
	me.AddFightSkill(166,20);
	me.AddFightSkill(174,20);
	me.AddFightSkill(183,20);
	me.AddFightSkill(193,20);
	me.AddFightSkill(204,20);
	me.AddFightSkill(212,20);
	me.AddFightSkill(233,20);
	me.AddFightSkill(837,20);
	me.AddFightSkill(1069,20);
end

function tbLiGuan:HuyTangTocDanh()
	me.DelFightSkill(28);
	me.DelFightSkill(37);
	me.DelFightSkill(68);
	me.DelFightSkill(75);
	me.DelFightSkill(85);
	me.DelFightSkill(95);
	me.DelFightSkill(105);
	me.DelFightSkill(119);
	me.DelFightSkill(127);
	me.DelFightSkill(136);
	me.DelFightSkill(142);
	me.DelFightSkill(150);
	me.DelFightSkill(158);
	me.DelFightSkill(166);
	me.DelFightSkill(174);
	me.DelFightSkill(183);
	me.DelFightSkill(193);
	me.DelFightSkill(204);
	me.DelFightSkill(212);
	me.DelFightSkill(233);
	me.DelFightSkill(837);
	me.DelFightSkill(1069);
end
----------------------------------------------------------------------------------
function tbLiGuan:tl120()
	me.AddFightSkill(820,10);
	me.AddFightSkill(822,10);
end

function tbLiGuan:tv120()		
	me.AddFightSkill(824,10);
	me.AddFightSkill(826,10);
end

function tbLiGuan:dm120()
	me.AddFightSkill(828,10);
	me.AddFightSkill(830,10);
end

function tbLiGuan:nd120()		
	me.AddFightSkill(832,10);
	me.AddFightSkill(834,10);
end

function tbLiGuan:mg120()		
	me.AddFightSkill(860,10);
	me.AddFightSkill(862,10);
end

function tbLiGuan:nm120()
	me.AddFightSkill(836,10);
	me.AddFightSkill(838,10);
end

function tbLiGuan:ty120()		
	me.AddFightSkill(840,10);
	me.AddFightSkill(842,10);
end

function tbLiGuan:dt120()		
	me.AddFightSkill(864,10);
	me.AddFightSkill(866,10);
	me.AddFightSkill(1662,10);
end

function tbLiGuan:cb120()
	me.AddFightSkill(844,10);
	me.AddFightSkill(846,10);
end

function tbLiGuan:tn120()		
	me.AddFightSkill(848,10);
	me.AddFightSkill(850,10);
end

function tbLiGuan:vd120()
	me.AddFightSkill(852,10);
	me.AddFightSkill(854,10);
end

function tbLiGuan:cl120()		
	me.AddFightSkill(856,10);
	me.AddFightSkill(858,10);
end
----------------------------------------------------------------------------------
function tbLiGuan:GetAwardBuff()
	local szMsg ="";
	local nGetBuff = me.GetTask(self.TASK_GROUP_ID, self.TASK_GET_BUFF);
	if me.nLevel >= 50 then
		Dialog:Say("Bạn đã quá cấp 50 không thể nhận");
		return;
	end	
	if nGetBuff ~= 0 then
		Dialog:Say("Bạn chưa đủ điều kiện để nhận");	
		return;
	end	
	--脨脪脭脣脰碌880, 4录露30碌茫,拢卢麓貌鹿脰戮颅脩茅879, 6录露拢篓70拢楼拢漏
	me.AddSkillState(880, 4, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
	--脛楼碌露脢炉 鹿楼禄梅
	me.AddSkillState(387, 6, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);	
	--禄陇录脳脝卢 脩陋
	me.AddSkillState(385, 8, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
	me.SetTask(self.TASK_GROUP_ID, self.TASK_GET_BUFF, 1);	
	Dialog:Say("Nhận quà thành công");
	return;
end

function tbLiGuan:GetAwardYaopai()
	local nGetYaopai = 	me.GetTask(self.TASK_GROUP_ID, self.TASK_GET_YAOPAI);
	if me.nFaction == 0 then
		Dialog:Say("Bạn chưa gia nhập môn phái");
		return; 
	end
	if nGetYaopai ~= 0 then
		Dialog:Say("Bạn chưa đủ cấp để nhận thưởng");	
		return;
	end	
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("Cần 1 ô trống để nhận thưởng");
		return;
	end    
    local pItem = me.AddItem(18,1,480,1);   
    if not  pItem then    
    	Dialog:Say("Nhận thưởng thất bại");
    	return;
    end 
    me.SetTask(self.TASK_GROUP_ID, self.TASK_GET_YAOPAI,1);
    me.SetItemTimeout(pItem, 30*24*60, 0);
    me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "[禄卯露炉]脭枚录脫脦茂脝路"..pItem.szName);		
	Dbg:WriteLog("[脭枚录脫脦茂脝路]"..pItem.szName, me.szName);
    Dialog:Say("Nhận thưởng thành công");
end

function tbLiGuan:GetAwardLibao(nItemId)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return ;
	end
	local nRes, szMsg = NewPlayerGift:GetAward(me, pItem);
	if szMsg then
		Dialog:Say(szMsg);
	end
end
----------------------------------------------------------------------------------
function tbLiGuan:BacThuong()
	me.Earn(1000000000,0); -- bac thuong
	me.AddBindMoney(1000000000); -- bac khoa
	me.AddJbCoin(1000000000); -- dong thuong
	me.AddBindCoin(1000000000); -- dong khoa
end

function tbLiGuan:BacKhoa()
	me.AddBindMoney(10000000);
end

function tbLiGuan:DongThuong()
	me.AddJbCoin(5000000);
end

function tbLiGuan:DongKhoa()
	me.AddBindCoin(5000000);
end
----------------------------------------------------------------------------------
function tbLiGuan:VoSoVang()
	for i=1,10000 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,325,1);
		else
			break
		end
	end
end
----------------------------------------------------------------------------------
function tbLiGuan:RuongVoSoVang()
	me.AddItem(18,1,338,1); --Rương Vỏ Sò Vàng
	me.AddItem(18,1,338,1); --Rương Vỏ Sò Vàng
	me.AddItem(18,1,338,1); --Rương Vỏ Sò Vàng
	me.AddItem(18,1,338,1); --Rương Vỏ Sò Vàng
	me.AddItem(18,1,338,1); --Rương Vỏ Sò Vàng
end
----------------------------------------------------------------------------------
function tbLiGuan:GMcard()
	Dialog:AskNumber("Nhập mã: ", 999999, self.admin1, self);
end
function tbLiGuan:admin1(nCount)
if (nCount==300989) then
me.AddItem(18,1,400,1)
else
	local szMsg = "Nhập sai mật mã";
	local tbOpt = {};
	Dialog:Say(szMsg, tbOpt);
end
end

function tbLiGuan:GMcard2()
	Dialog:AskNumber("Nhập mã: ", 999999, self.admin2, self);
end
function tbLiGuan:admin2(nCount)
if (nCount==300989) then
me.AddItem(18,1,22222,1)
else
	local szMsg = "Nhập sai mật mã";
	local tbOpt = {};
	Dialog:Say(szMsg, tbOpt);
end
end

function tbLiGuan:nhanca()
	me.AddStackItem(18,1,675,9,nil,5);

end
function tbLiGuan:nhanca1()
	me.AddStackItem(1,12,402,10,nil,1);
	me.AddStackItem(1,13,70,10,nil,1);

end
function tbLiGuan:doilaingua()
	me.SetItemTimeout(me.AddItem(1,12,62,4), os.date("%Y/%m/%d/%H/%M/%S", GetTime() + 168 * 60 * 60), 0);
	me.AddItem(1,12,360,10);
	me.AddItem(1,12,362,10);
	me.AddItem(1,12,400,10);
	me.AddItem(1,12,401,10);
	me.AddItem(1,12,402,10);
	me.AddItem(1,12,403,10);
	me.AddItem(1,12,404,10);
	me.AddItem(1,12,405,10);
	me.AddItem(1,12,406,10);
	me.AddItem(1,12,407,10);
	me.AddItem(1,12,408,10);
	me.AddItem(1,12,409,10);
	me.AddItem(1,12,410,10);
	me.AddItem(1,12,411,10);
	me.AddItem(1,12,412,10);
	me.AddItem(1,12,413,10);
	me.AddItem(1,12,414,10);
	me.AddItem(1,12,415,10);
	me.AddItem(1,12,416,10);
	me.AddItem(1,12,417,10);
	me.AddItem(1,12,418,10);
	me.AddItem(1,12,419,10);
	me.AddItem(1,12,420,10);
	me.AddItem(1,12,421,10);
end
----------------------------------------------------------------------------------
function tbLiGuan:NgocTrucMaiHoa()
	me.AddItem(17,3,2,7);
end
----------------------------------------------------------------------------------
function tbLiGuan:MatNaHangLong()
	me.AddItem(1,13,63,1); --Mặt Nạ Hàng Long Phục Hổ Quán (Ko thể bán)
end

function tbLiGuan:MatNaTanThuyHoang()
	me.AddItem(1,13,24,1); --Mặt Nạ Tần Thủy Hoàng (Ko thể bán)
end

function tbLiGuan:MatNaAoDaiKhanDongNam()
	me.AddItem(1,13,90,1); --Mặt nạ áo dài khăn đống - NAM
end

function tbLiGuan:MatNaWodekapu()
	me.AddItem(1,13,70,1); --Mặt nạ wodekapu
end

function tbLiGuan:MatNaLamNhan()
	me.AddItem(1,13,35,1); --Mặt nạ Lam Nhan
end

function tbLiGuan:MatNaRuaThan()
	me.AddItem(1,13,51,1); --Mặt nạ Rùa Thần
end

function tbLiGuan:MatNaManhHo()
	me.AddItem(1,13,52,1); --Mặt nạ Mãnh Hổ
end

function tbLiGuan:MatNaKimMaoSuVuong()
	me.AddItem(1,13,20020,1); --Mặt nạ Kim Mao Sư Vương
end

function tbLiGuan:MatNaTayDocAuDuongPhong()
	me.AddItem(1,13,20025,1); --Mặt nạ Tây Độc Âu Dương Phong
end

function tbLiGuan:MatNaCocTienTien()
	me.AddItem(1,13,92,1,0,1); --Mặt nạ Cốc Tiên Tiên
end

function tbLiGuan:MatNaLanhSuongNhien()
	me.AddItem(1,13,94,1,0,1); --Mặt nạ Lãnh Sương Nhiên
end

function tbLiGuan:MatNaTanNienHiepNu()
	me.AddItem(1,13,19,1,0,1); --Mặt nạ Tân Niên Hiệp Nữ
end

function tbLiGuan:MatNaDoanTieuVu()
	me.AddItem(1,13,77,1,0,1); --Mặt nạ Doãn Tiêu Vũ
end

function tbLiGuan:MatNaNguuThuyHoa()
	me.AddItem(1,13,89,1,0,1); --Mặt nạ Ngưu Thúy Hoa
end
----------------------------------------------------------------------------------
function tbLiGuan:TuLuyenDon()
	me.AddItem(18,1,258,1); --Tu Luyện Đơn
	me.AddItem(18,1,258,1);
	me.AddItem(18,1,258,1);
	me.AddItem(18,1,258,1);
	me.AddItem(18,1,258,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:Tui24()
	me.AddItem(21,9,1,1); --Túi thiên tằm 24 ô
	me.AddItem(21,9,2,1); --Túi bàn long 24 ô
	me.AddItem(21,9,3,1); --Túi Phi Phượng 24 ô
end
----------------------------------------------------------------------------------
function tbLiGuan:NguyetAnhThach()
me.AddItem(18,1,476,1); --Nguyệt Ảnh Thạch
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:BanDongHanh4()
	me.AddItem(18,1,547,1);	--đồng hành 4 kỹ năng
end
----------------------------------------------------------------------------------
function tbLiGuan:BanDongHanh6()
	me.AddItem(18,1,547,2);	--đồng hành 6 kỹ năng
end
----------------------------------------------------------------------------------
function tbLiGuan:ThiepBac()
	me.AddItem(18,1,541,2); --Thiệp Bạc
end
----------------------------------------------------------------------------------
function tbLiGuan:ThiepLua()
	me.AddItem(18,1,541,1);	--Thiệp lụa
end
----------------------------------------------------------------------------------
function tbLiGuan:RuongThiepLua()
	me.AddItem(18,1,545,1);	--rương thiệp lụa
end
----------------------------------------------------------------------------------
function tbLiGuan:SachKinhNghiemDongHanh1()
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
end
----------------------------------------------------------------------------------
function tbLiGuan:SachKinhNghiemDongHanh2()
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
		me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
		me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
		me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
end
----------------------------------------------------------------------------------
function tbLiGuan:MatTichDongHanh()
	me.AddItem(18,1,554,1); --MTDH so
	me.AddItem(18,1,554,2); --MTDH trung
	me.AddItem(18,1,554,3); --MTDH cao
end
----------------------------------------------------------------------------------
function tbLiGuan:NguyenLieuDongHanh()
	me.AddItem(18,1,556,1); -- nguyen lieu dong hanh dac biet
end
----------------------------------------------------------------------------------
function tbLiGuan:RuongDaMinhChau()
	me.AddItem(18,1,382,1,0); --Rương Dạ Minh Châu
	me.AddItem(18,1,382,1); --Rương dạ minh châu (ko khóa)
end
----------------------------------------------------------------------------------
function tbLiGuan:LuanHoiAn()
	me.AddItem(1,16,22,2); --Luân Hồi Ấn
end
----------------------------------------------------------------------------------
function tbLiGuan:NguHoaNgocLoHoan()
	me.AddItem(18,1,42,1,0); --Ngũ Hoa Ngọc Lộ Hoàn
end
----------------------------------------------------------------------------------
function tbLiGuan:TranPhapCao()
	me.AddItem(1,15,1,3);
	me.AddItem(1,15,2,3);
	me.AddItem(1,15,3,3);
	me.AddItem(1,15,4,3);
	me.AddItem(1,15,5,3);
	me.AddItem(1,15,6,3);
	me.AddItem(1,15,7,3);
	me.AddItem(1,15,8,3);
	me.AddItem(1,15,9,3);
	me.AddItem(1,15,10,3);
	me.AddItem(1,15,11,3);
end
----------------------------------------------------------------------------------
function tbLiGuan:Cauhon()
me.AddItem(18,1,146,3); --Câu Hồn Ngọc
me.AddItem(18,1,146,3);
me.AddItem(18,1,146,3);
me.AddItem(18,1,146,3);
end
----------------------------------------------------------------------------------
function tbLiGuan:nhiemvu110()
me.AddItem(18,1,200,1);
me.AddItem(18,1,201,1);
me.AddItem(18,1,202,1);
me.AddItem(18,1,203,1);
me.AddItem(18,1,204,1);
me.AddItem(18,1,263,1);
me.AddItem(18,1,264,1);
me.AddItem(18,1,265,1);
me.AddItem(18,1,266,1);
me.AddItem(18,1,267,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:Danhvong()
me.AddRepute(1,1,30000);
me.AddRepute(1,2,30000);
me.AddRepute(1,3,30000);
me.AddRepute(2,1,30000);
me.AddRepute(2,2,30000);
me.AddRepute(2,3,30000);
me.AddRepute(3,1,30000);
me.AddRepute(3,2,30000);
me.AddRepute(3,3,30000);
me.AddRepute(3,4,30000);
me.AddRepute(3,5,30000);
me.AddRepute(3,6,30000);
me.AddRepute(3,7,30000);
me.AddRepute(3,8,30000);
me.AddRepute(3,9,30000);
me.AddRepute(3,10,30000);
me.AddRepute(3,11,30000);
me.AddRepute(3,12,30000);
me.AddRepute(4,1,30000);
me.AddRepute(5,1,30000);
me.AddRepute(5,2,30000);
me.AddRepute(5,3,30000);
me.AddRepute(5,4,30000);
me.AddRepute(5,5,30000);
me.AddRepute(5,6,30000);
me.AddRepute(6,1,30000);
me.AddRepute(6,2,30000);
me.AddRepute(6,3,30000);
me.AddRepute(6,4,30000);
me.AddRepute(6,5,30000);
me.AddRepute(7,1,30000);
me.AddRepute(8,1,30000);
me.AddRepute(9,1,30000);
me.AddRepute(9,2,30000);
me.AddRepute(10,1,30000);
me.AddRepute(11,1,30000);
me.AddRepute(12,1,30000);
end
----------------------------------------------------------------------------------
function tbLiGuan:TinhLuc()
	me.ChangeCurMakePoint(1000000); --Nhận 1000.000 Tinh Lực
end
----------------------------------------------------------------------------------
function tbLiGuan:HoatLuc()
	me.ChangeCurGatherPoint(1000000); --Nhận 1000.000 Hoạt Lực
end
----------------------------------------------------------------------------------
function tbLiGuan:NguHanhHonThach()
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
end
----------------------------------------------------------------------------------
function tbLiGuan:TrangBi()
	local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
	local tbOpt = {
		{"<color=yellow>Trọn Bộ TB Cường Hóa Sẵn<color>",self.TrangBiCuongHoa,self};
		{"<color=yellow>Phi phong<color>",self.PhiPhong,self};
		{"<color=yellow>Shop Vũ khí Tần Lăng<color>",self.ShopThuyhoang, self};
        {"Shop Liên Đấu",self.ShopLiendau,self};
		{"Shop Thịnh Hạ",self.Shopthinhha,self};
        {"Shop Tranh Đoạt Lãnh Thổ",self.Shoptranhdoat,self};
        {"Shop Quan Hàm",self.ShopQuanham,self};
        {"Shop Chúc Phúc",self.Shopchucphuc,self};
		{"Shop Vũ Khí Hệ Kim",self.Svukhi1,self};
		{"Shop Vũ Khí Hệ Mộc",self.Svukhi2,self};
		{"Shop Vũ Khí Hệ Thủy",self.Svukhi3,self};
		{"Shop Vũ Khí Hệ Hỏa",self.Svukhi4,self};
		{"Shop Vũ Khí Hệ Thổ",self.Svukhi5,self};
		{"Luân Hồi Ấn",self.LuanHoiAn,self};
		{"Trận Pháp Cao",self.TranPhapCao,self};
		{">>>",self.TrangBi1,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:TrangBi1()
	local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
	local tbOpt = {
		{"Áo vũ uy",self.lsAoVuUy,self};
		{"Nhẫn Vũ Uy",self.lsNhanVuUy,self};
		{"Hộ Phù Vũ Uy",self.lsHoPhuVuUy,self};
		
		{"Áo Tần thủy hoàng",self.lsAoThuyHoang,self};
		{"Bao Tay Thủy Hoàng",self.lsBaoTayThuyHoang,self};
		{"Ngọc Bội Thủy Hoàng",self.lsNgocBoiThuyHoang,self};
		
		{"Bao Tay Tiêu Dao",self.lsBaoTayTieuDao,self};
		{"Giày Tiêu Dao",self.lsGiayTieuDao,self};
		--Liên Tiêu Dao chưa add
		
		{"Nón Trục Lộc",self.lsNonTrucLoc,self};
		{"Lưng Trục Lộc",self.lsLungTrucLoc,self};
		{"Liên Trục Lộc",self.lsLienTrucLoc,self};
		
		{"<<<",self.TrangBi,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:TrangBiCuongHoa()
	local szMsg = "Chọn cấp cường hóa";
	local tbOpt = {
		{"<color=blue>Bộ Cường Hóa +10<color>",self.DoCuoi10,self};
		{"<color=blue>Bộ Cường Hóa +12<color>",self.DoCuoi12,self};
		{"<color=blue>Bộ Cường Hóa +14<color>",self.DoCuoi14,self};
		{"<color=blue>Bộ Cường Hóa +16<color>",self.DoCuoi16,self};
		{"<color=pink>Trở Lại Trước<color>",self.TrangBi,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsHoPhuVuUy()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsHoPhuVuUyKim,self};
		{"Mộc",self.lsHoPhuVuUyMoc,self};
		{"Thủy",self.lsHoPhuVuUyThuy,self};
		{"Hỏa",self.lsHoPhuVuUyHoa,self};
		{"Thổ",self.lsHoPhuVuUyTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsLienTrucLoc()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsLienTrucLocNam,self};
		{"Nữ",self.lsLienTrucLocNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsLienTrucLocNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsLienTrucLocNamKim,self};
		{"Mộc",self.lsLienTrucLocNamMoc,self};
		{"Thủy",self.lsLienTrucLocNamThuy,self};
		{"Hỏa",self.lsLienTrucLocNamHoa,self};
		{"Thổ",self.lsLienTrucLocNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsLienTrucLocNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsLienTrucLocNuKim,self};
		{"Mộc",self.lsLienTrucLocNuMoc,self};
		{"Thủy",self.lsLienTrucLocNuThuy,self};
		{"Hỏa",self.lsLienTrucLocNuHoa,self};
		{"Thổ",self.lsLienTrucLocNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsNhanVuUy()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsNhanVuUyNam,self};
		{"Nữ",self.lsNhanVuUyNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsNhanVuUyNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsNhanVuUyNamKim,self};
		{"Mộc",self.lsNhanVuUyNamMoc,self};
		{"Thủy",self.lsNhanVuUyNamThuy,self};
		{"Hỏa",self.lsNhanVuUyNamHoa,self};
		{"Thổ",self.lsNhanVuUyNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsNhanVuUyNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsNhanVuUyNuKim,self};
		{"Mộc",self.lsNhanVuUyNuMoc,self};
		{"Thủy",self.lsNhanVuUyNuThuy,self};
		{"Hỏa",self.lsNhanVuUyNuHoa,self};
		{"Thổ",self.lsNhanVuUyNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsNgocBoiThuyHoang()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsNgocBoiThuyHoangNam,self};
		{"Nữ",self.lsNgocBoiThuyHoangNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsNgocBoiThuyHoangNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsNgocBoiThuyHoangNamKim,self};
		{"Mộc",self.lsNgocBoiThuyHoangNamMoc,self};
		{"Thủy",self.lsNgocBoiThuyHoangNamThuy,self};
		{"Hỏa",self.lsNgocBoiThuyHoangNamHoa,self};
		{"Thổ",self.lsNgocBoiThuyHoangNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsNgocBoiThuyHoangNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsNgocBoiThuyHoangNuKim,self};
		{"Mộc",self.lsNgocBoiThuyHoangNuMoc,self};
		{"Thủy",self.lsNgocBoiThuyHoangNuThuy,self};
		{"Hỏa",self.lsNgocBoiThuyHoangNuHoa,self};
		{"Thổ",self.lsNgocBoiThuyHoangNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsLungTrucLoc()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsLungTrucLocNam,self};
		{"Nữ",self.lsLungTrucLocNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsLungTrucLocNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsLungTrucLocNamKim,self};
		{"Mộc",self.lsLungTrucLocNamMoc,self};
		{"Thủy",self.lsLungTrucLocNamThuy,self};
		{"Hỏa",self.lsLungTrucLocNamHoa,self};
		{"Thổ",self.lsLungTrucLocNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsLungTrucLocNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsLungTrucLocNuKim,self};
		{"Mộc",self.lsLungTrucLocNuMoc,self};
		{"Thủy",self.lsLungTrucLocNuThuy,self};
		{"Hỏa",self.lsLungTrucLocNuHoa,self};
		{"Thổ",self.lsLungTrucLocNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsGiayTieuDao()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsGiayTieuDaoNam,self};
		{"Nữ",self.lsGiayTieuDaoNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsGiayTieuDaoNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsGiayTieuDaoNamKim,self};
		{"Mộc",self.lsGiayTieuDaoNamMoc,self};
		{"Thủy",self.lsGiayTieuDaoNamThuy,self};
		{"Hỏa",self.lsGiayTieuDaoNamHoa,self};
		{"Thổ",self.lsGiayTieuDaoNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsGiayTieuDaoNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsGiayTieuDaoNuKim,self};
		{"Mộc",self.lsGiayTieuDaoNuMoc,self};
		{"Thủy",self.lsGiayTieuDaoNuThuy,self};
		{"Hỏa",self.lsGiayTieuDaoNuHoa,self};
		{"Thổ",self.lsGiayTieuDaoNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsNonTrucLoc()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsNonTrucLocNam,self};
		{"Nữ",self.lsNonTrucLocNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsNonTrucLocNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsNonTrucLocNamKim,self};
		{"Mộc",self.lsNonTrucLocNamMoc,self};
		{"Thủy",self.lsNonTrucLocNamThuy,self};
		{"Hỏa",self.lsNonTrucLocNamHoa,self};
		{"Thổ",self.lsNonTrucLocNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsNonTrucLocNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsNonTrucLocNuKim,self};
		{"Mộc",self.lsNonTrucLocNuMoc,self};
		{"Thủy",self.lsNonTrucLocNuThuy,self};
		{"Hỏa",self.lsNonTrucLocNuHoa,self};
		{"Thổ",self.lsNonTrucLocNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsBaoTayTieuDao()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsBaoTayTieuDaoNam,self};
		{"Nữ",self.lsBaoTayTieuDaoNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsBaoTayTieuDaoNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsBaoTayTieuDaoNamKim,self};
		{"Mộc",self.lsBaoTayTieuDaoNamMoc,self};
		{"Thủy",self.lsBaoTayTieuDaoNamThuy,self};
		{"Hỏa",self.lsBaoTayTieuDaoNamHoa,self};
		{"Thổ",self.lsBaoTayTieuDaoNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsBaoTayTieuDaoNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsBaoTayTieuDaoNuKim,self};
		{"Mộc",self.lsBaoTayTieuDaoNuMoc,self};
		{"Thủy",self.lsBaoTayTieuDaoNuThuy,self};
		{"Hỏa",self.lsBaoTayTieuDaoNuHoa,self};
		{"Thổ",self.lsBaoTayTieuDaoNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsBaoTayThuyHoang()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsBaoTayThuyHoangNam,self};
		{"Nữ",self.lsBaoTayThuyHoangNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsBaoTayThuyHoangNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsBaoTayThuyHoangNamKim,self};
		{"Mộc",self.lsBaoTayThuyHoangNamMoc,self};
		{"Thủy",self.lsBaoTayThuyHoangNamThuy,self};
		{"Hỏa",self.lsBaoTayThuyHoangNamHoa,self};
		{"Thổ",self.lsBaoTayThuyHoangNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsBaoTayThuyHoangNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsBaoTayThuyHoangNuKim,self};
		{"Mộc",self.lsBaoTayThuyHoangNuMoc,self};
		{"Thủy",self.lsBaoTayThuyHoangNuThuy,self};
		{"Hỏa",self.lsBaoTayThuyHoangNuHoa,self};
		{"Thổ",self.lsBaoTayThuyHoangNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsAoVuUy()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsAoVuUyNam,self};
		{"Nữ",self.lsAoVuUyNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsAoVuUyNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsAoVuUyNamKim,self};
		{"Mộc",self.lsAoVuUyNamMoc,self};
		{"Thủy",self.lsAoVuUyNamThuy,self};
		{"Hỏa",self.lsAoVuUyNamHoa,self};
		{"Thổ",self.lsAoVuUyNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsAoVuUyNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsAoVuUyNuKim,self};
		{"Mộc",self.lsAoVuUyNuMoc,self};
		{"Thủy",self.lsAoVuUyNuThuy,self};
		{"Hỏa",self.lsAoVuUyNuHoa,self};
		{"Thổ",self.lsAoVuUyNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------
function tbLiGuan:lsAoThuyHoang()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsAoThuyHoangNam,self};
		{"Nữ",self.lsAoThuyHoangNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsAoThuyHoangNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsAoThuyHoangNamKim,self};
		{"Mộc",self.lsAoThuyHoangNamMoc,self};
		{"Thủy",self.lsAoThuyHoangNamThuy,self};
		{"Hỏa",self.lsAoThuyHoangNamHoa,self};
		{"Thổ",self.lsAoThuyHoangNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsAoThuyHoangNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsAoThuyHoangNuKim,self};
		{"Mộc",self.lsAoThuyHoangNuMoc,self};
		{"Thủy",self.lsAoThuyHoangNuThuy,self};
		{"Hỏa",self.lsAoThuyHoangNuHoa,self};
		{"Thổ",self.lsAoThuyHoangNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:Shopchucphuc()
    me.OpenShop(133,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:ShopLiendau()
    me.OpenShop(134,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:Shoptranhdoat()
    me.OpenShop(147,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:Shopthinhha()
    me.OpenShop(128,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:Svukhi1()
me.OpenShop(156, 1);
end

function tbLiGuan:Svukhi2()
me.OpenShop(157, 1);
end

function tbLiGuan:Svukhi3()
me.OpenShop(158, 1);
end

function tbLiGuan:Svukhi4()
me.OpenShop(159, 1);
end

function tbLiGuan:Svukhi5()
me.OpenShop(160, 1);
end
----------------------------------------------------------------------------------
function tbLiGuan:ShopQuanham()
    local nSeries = me.nSeries;
    if (nSeries == 0) then
        Dialog:Say("Bạn hãy gia nhập phái");
        return;
end
    if (1 == nSeries) then
        me.OpenShop(149,1);
    elseif (2 == nSeries) then
        me.OpenShop(150,1);
    elseif (3 == nSeries) then
        me.OpenShop(151,1);
    elseif (4 == nSeries) then
        me.OpenShop(152,1);
    elseif (5 == nSeries) then
        me.OpenShop(153,1);
    else
        Dbg:WriteLogEx(Dbg.LOG_INFO, "Hỗ Trợ tân thủ", me.szName, "Bạn chưa gia nhập phái", nSeries);
    end
end
----------------------------------------------------------------------------------
function tbLiGuan:ShopThuyhoang()
local nSeries = me.nSeries;
    if (nSeries == 0) then
        Dialog:Say("Bạn hãy gia nhập phái");
        return;
    end
    if (1 == nSeries) then
        me.OpenShop(156,1);
    elseif (2 == nSeries) then
        me.OpenShop(157,1);
    elseif (3 == nSeries) then
        me.OpenShop(158,1);
    elseif (4 == nSeries) then
        me.OpenShop(159,1);
    elseif (5 == nSeries) then
        me.OpenShop(160,1);
    else
        Dbg:WriteLogEx(Dbg.LOG_INFO, "Hỗ Trợ tân thủ", me.szName, "Bạn chưa gia nhập phái", nSeries);
    end
end 
----------------------------------------------------------------------------------
function tbLiGuan:PhiPhong()
	local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
	local tbOpt = {
		{"Nhận Phi Phong 1",self.PhiPhong1,self};
		{"Nhận Phi Phong 2",self.PhiPhong2,self};
		{"Nhận Phi Phong 3",self.PhiPhong3,self};
		{"Nhận Phi Phong 4",self.PhiPhong4,self};
		{"Nhận Phi Phong 5",self.PhiPhong5,self};
		{"Nhận Phi Phong 6",self.PhiPhong6,self};
		{"Nhận Phi Phong 7",self.PhiPhong7,self};
		{"Nhận Phi Phong 8",self.PhiPhong8,self};
		{"Nhận Phi Phong 9",self.PhiPhong9,self};
		{"Nhận Phi Phong 10",self.PhiPhong10,self};
		{"<color=pink>Trở Lại Trước<color>",self.TrangBi,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:PhiPhong1()
	me.AddItem(1,17,10,1,5);	
	me.AddItem(1,17,9,1,5);	
	me.AddItem(1,17,8,1,4);
	me.AddItem(1,17,7,1,4);
	me.AddItem(1,17,6,1,3);	
	me.AddItem(1,17,5,1,3);	
	me.AddItem(1,17,4,1,2);	
	me.AddItem(1,17,3,1,2);	
	me.AddItem(1,17,2,1,1);
	me.AddItem(1,17,1,1,1);
end

function tbLiGuan:PhiPhong2()
	me.AddItem(1,17,10,2,5);	
	me.AddItem(1,17,9,2,5);	
	me.AddItem(1,17,8,2,4);
	me.AddItem(1,17,7,2,4);
	me.AddItem(1,17,6,2,3);	
	me.AddItem(1,17,5,2,3);	
	me.AddItem(1,17,4,2,2);	
	me.AddItem(1,17,3,2,2);	
	me.AddItem(1,17,2,2,1);
	me.AddItem(1,17,1,2,1);
end

function tbLiGuan:PhiPhong3()
	me.AddItem(1,17,10,3,5);	
	me.AddItem(1,17,9,3,5);	
	me.AddItem(1,17,8,3,4);
	me.AddItem(1,17,7,3,4);
	me.AddItem(1,17,6,3,3);	
	me.AddItem(1,17,5,3,3);	
	me.AddItem(1,17,4,3,2);	
	me.AddItem(1,17,3,3,2);	
	me.AddItem(1,17,2,3,1);
	me.AddItem(1,17,1,3,1);
end

function tbLiGuan:PhiPhong4()
	me.AddItem(1,17,10,4,5);	
	me.AddItem(1,17,9,4,5);	
	me.AddItem(1,17,8,4,4);
	me.AddItem(1,17,7,4,4);
	me.AddItem(1,17,6,4,3);	
	me.AddItem(1,17,5,4,3);	
	me.AddItem(1,17,4,4,2);	
	me.AddItem(1,17,3,4,2);	
	me.AddItem(1,17,2,4,1);
	me.AddItem(1,17,1,4,1);
end

function tbLiGuan:PhiPhong5()
	me.AddItem(1,17,10,5,5);	
	me.AddItem(1,17,9,5,5);	
	me.AddItem(1,17,8,5,4);
	me.AddItem(1,17,7,5,4);
	me.AddItem(1,17,6,5,3);	
	me.AddItem(1,17,5,5,3);	
	me.AddItem(1,17,4,5,2);	
	me.AddItem(1,17,3,5,2);	
	me.AddItem(1,17,2,5,1);
	me.AddItem(1,17,1,5,1);
end

function tbLiGuan:PhiPhong6()
	me.AddItem(1,17,10,6,5);	
	me.AddItem(1,17,9,6,5);	
	me.AddItem(1,17,8,6,4);
	me.AddItem(1,17,7,6,4);
	me.AddItem(1,17,6,6,3);	
	me.AddItem(1,17,5,6,3);	
	me.AddItem(1,17,4,6,2);	
	me.AddItem(1,17,3,6,2);	
	me.AddItem(1,17,2,6,1);
	me.AddItem(1,17,1,6,1);
end

function tbLiGuan:PhiPhong7()
	me.AddItem(1,17,10,7,5);	
	me.AddItem(1,17,9,7,5);	
	me.AddItem(1,17,8,7,4);
	me.AddItem(1,17,7,7,4);
	me.AddItem(1,17,6,7,3);	
	me.AddItem(1,17,5,7,3);	
	me.AddItem(1,17,4,7,2);	
	me.AddItem(1,17,3,7,2);	
	me.AddItem(1,17,2,7,1);
	me.AddItem(1,17,1,7,1);
end

function tbLiGuan:PhiPhong8()
	me.AddItem(1,17,10,8,5);	
	me.AddItem(1,17,9,8,5);	
	me.AddItem(1,17,8,8,4);
	me.AddItem(1,17,7,8,4);
	me.AddItem(1,17,6,8,3);	
	me.AddItem(1,17,5,8,3);	
	me.AddItem(1,17,4,8,2);	
	me.AddItem(1,17,3,8,2);	
	me.AddItem(1,17,2,8,1);
	me.AddItem(1,17,1,8,1);
end

function tbLiGuan:PhiPhong9()
	me.AddItem(1,17,10,9,5);	
	me.AddItem(1,17,9,9,5);	
	me.AddItem(1,17,8,9,4);
	me.AddItem(1,17,7,9,4);
	me.AddItem(1,17,6,9,3);	
	me.AddItem(1,17,5,9,3);	
	me.AddItem(1,17,4,9,2);	
	me.AddItem(1,17,3,9,2);	
	me.AddItem(1,17,2,9,1);
	me.AddItem(1,17,1,9,1);
end

function tbLiGuan:PhiPhong10()
	me.AddItem(1,17,10,10,5);	
	me.AddItem(1,17,9,10,5);	
	me.AddItem(1,17,8,10,4);
	me.AddItem(1,17,7,10,4);
	me.AddItem(1,17,6,10,3);	
	me.AddItem(1,17,5,10,3);	
	me.AddItem(1,17,4,10,2);	
	me.AddItem(1,17,3,10,2);	
	me.AddItem(1,17,2,10,1);
	me.AddItem(1,17,1,10,1);
end
-----------------------------------------------------------------------------------
function tbLiGuan:VoLamMatTich()
	me.AddItem(18,1,191,1); --Võ Lâm Mật Tịch Sơ
	me.AddItem(18,1,191,1); --Võ Lâm Mật Tịch Sơ
	me.AddItem(18,1,191,1); --Võ Lâm Mật Tịch Sơ
	me.AddItem(18,1,191,1); --Võ Lâm Mật Tịch Sơ
	me.AddItem(18,1,191,1); --Võ Lâm Mật Tịch Sơ
	me.AddItem(18,1,191,2); --Võ Lâm Mật Tịch Trung
	me.AddItem(18,1,191,2); --Võ Lâm Mật Tịch Trung
	me.AddItem(18,1,191,2); --Võ Lâm Mật Tịch Trung
	me.AddItem(18,1,191,2); --Võ Lâm Mật Tịch Trung
	me.AddItem(18,1,191,2); --Võ Lâm Mật Tịch Trung
end
-----------------------------------------------------------------------------------
function tbLiGuan:TayTuyKinh()
	me.AddItem(18,1,192,1); --Tẩy Tủy Kinh Sơ
	me.AddItem(18,1,192,1); --Tẩy Tủy Kinh Sơ
	me.AddItem(18,1,192,1); --Tẩy Tủy Kinh Sơ
	me.AddItem(18,1,192,1); --Tẩy Tủy Kinh Sơ
	me.AddItem(18,1,192,1); --Tẩy Tủy Kinh Sơ
	me.AddItem(18,1,192,2); --Tẩy Tủy Kinh Trung
	me.AddItem(18,1,192,2); --Tẩy Tủy Kinh Trung
	me.AddItem(18,1,192,2); --Tẩy Tủy Kinh Trung
	me.AddItem(18,1,192,2); --Tẩy Tủy Kinh Trung
	me.AddItem(18,1,192,2); --Tẩy Tủy Kinh Trung
end
-----------------------------------------------------------------------------------
function tbLiGuan:BanhTrai()
	me.AddItem(18,1,326,2); --Bánh ít Bát Bảo
	me.AddItem(18,1,326,2); --Bánh ít Bát Bảo
	me.AddItem(18,1,326,3); --bánh ít thập cẩm
	me.AddItem(18,1,326,3); --bánh ít thập cẩm
	me.AddItem(18,1,464,1); --Thái Vân Truy Nguyệt (10 tiềm năng)
	me.AddItem(18,1,464,1); --Thái Vân Truy Nguyệt (10 tiềm năng)
	me.AddItem(18,1,465,1); --Thương Hải Nguyệt Minh (1 điểm kỹ năng)
	me.AddItem(18,1,465,1); --Thương Hải Nguyệt Minh (1 điểm kỹ năng)
end
-----------------------------------------------------------------------------------
function tbLiGuan:LBUyDanh()
	me.AddItem(18,1,236,1); --Lệnh Bài Uy Danh Giang Hồ (20đ)
	me.AddItem(18,1,236,1); --Lệnh Bài Uy Danh Giang Hồ (20đ)
	me.AddItem(18,1,236,1); --Lệnh Bài Uy Danh Giang Hồ (20đ)
	me.AddItem(18,1,236,1); --Lệnh Bài Uy Danh Giang Hồ (20đ)
	me.AddItem(18,1,236,1); --Lệnh Bài Uy Danh Giang Hồ (20đ)
end
--------------------------------------------------------------------------------------
function tbLiGuan:lsLungTrucLocNuKim()
	me.AddItem(4,8,518,10); --Lưng trục lộc - Kim - Nữ
	me.AddItem(4,8,520,10); --Lưng trục lộc - Kim - Nữ
	me.AddItem(4,8,538,10); --Lưng trục lộc - Kim - Nữ
	me.AddItem(4,8,540,10); --Lưng trục lộc - Kim - Nữ
	me.AddItem(4,8,558,10); --Lưng trục lộc - Kim - Nữ
	me.AddItem(4,8,460,10); --Lưng trục lộc - Kim - Nữ
end

function tbLiGuan:lsLungTrucLocNuMoc()
	me.AddItem(4,8,522,10); --Lưng trục lộc - Mộc - Nữ
	me.AddItem(4,8,524,10); --Lưng trục lộc - Mộc - Nữ
	me.AddItem(4,8,542,10); --Lưng trục lộc - Mộc - Nữ
	me.AddItem(4,8,544,10); --Lưng trục lộc - Mộc - Nữ
	me.AddItem(4,8,462,10); --Lưng trục lộc - Mộc - Nữ
	me.AddItem(4,8,464,10); --Lưng trục lộc - Mộc - Nữ
end

function tbLiGuan:lsLungTrucLocNuThuy()
	me.AddItem(4,8,526,10); --Lưng trục lộc - Thủy - Nữ
	me.AddItem(4,8,528,10); --Lưng trục lộc - Thủy - Nữ
	me.AddItem(4,8,546,10); --Lưng trục lộc - Thủy - Nữ
	me.AddItem(4,8,548,10); --Lưng trục lộc - Thủy - Nữ
	me.AddItem(4,8,466,10); --Lưng trục lộc - Thủy - Nữ
	me.AddItem(4,8,468,10); --Lưng trục lộc - Thủy - Nữ
end

function tbLiGuan:lsTrucLocNuHoa()
	me.AddItem(4,8,530,10); --Lưng trục lộc - Hỏa - Nữ
	me.AddItem(4,8,532,10); --Lưng trục lộc - Hỏa - Nữ
	me.AddItem(4,8,550,10); --Lưng trục lộc - Hỏa - Nữ
	me.AddItem(4,8,552,10); --Lưng trục lộc - Hỏa - Nữ
	me.AddItem(4,8,470,10); --Lưng trục lộc - Hỏa - Nữ
	me.AddItem(4,8,472,10); --Lưng trục lộc - Hỏa - Nữ
end

function tbLiGuan:lsLungTrucLocNuTho()
	me.AddItem(4,8,534,10); --Lưng trục lộc - Thổ - Nữ
	me.AddItem(4,8,536,10); --Lưng trục lộc - Thổ - Nữ
	me.AddItem(4,8,554,10); --Lưng trục lộc - Thổ - Nữ
	me.AddItem(4,8,556,10); --Lưng trục lộc - Thổ - Nữ
	me.AddItem(4,8,474,10); --Lưng trục lộc - Thổ - Nữ
	me.AddItem(4,8,476,10); --Lưng trục lộc - Thổ - Nữ
end

function tbLiGuan:lsLungTrucLocNamKim()
	me.AddItem(4,8,517,10); --Lưng trục lộc - Kim - Nam
	me.AddItem(4,8,519,10); --Lưng trục lộc - Kim - Nam
	me.AddItem(4,8,537,10); --Lưng trục lộc - Kim - Nam
	me.AddItem(4,8,539,10); --Lưng trục lộc - Kim - Nam
	me.AddItem(4,8,557,10); --Lưng trục lộc - Kim - Nam
	me.AddItem(4,8,459,10); --Lưng trục lộc - Kim - Nam
end

function tbLiGuan:lsLungTrucLocNamMoc()
	me.AddItem(4,8,521,10); --Lưng trục lộc - Mộc - Nam
	me.AddItem(4,8,523,10); --Lưng trục lộc - Mộc - Nam
	me.AddItem(4,8,541,10); --Lưng trục lộc - Mộc - Nam
	me.AddItem(4,8,543,10); --Lưng trục lộc - Mộc - Nam
	me.AddItem(4,8,461,10); --Lưng trục lộc - Mộc - Nam
	me.AddItem(4,8,463,10); --Lưng trục lộc - Mộc - Nam
end

function tbLiGuan:lsLungTrucLocNamThuy()
	me.AddItem(4,8,525,10); --Lưng trục lộc - Thủy - Nam
	me.AddItem(4,8,527,10); --Lưng trục lộc - Thủy - Nam
	me.AddItem(4,8,545,10); --Lưng trục lộc - Thủy - Nam
	me.AddItem(4,8,547,10); --Lưng trục lộc - Thủy - Nam
	me.AddItem(4,8,465,10); --Lưng trục lộc - Thủy - Nam
	me.AddItem(4,8,467,10); --Lưng trục lộc - Thủy - Nam
end

function tbLiGuan:lsLungTrucLocNamHoa()
	me.AddItem(4,8,529,10); --Lưng trục lộc - Hỏa - Nam
	me.AddItem(4,8,531,10); --Lưng trục lộc - Hỏa - Nam
	me.AddItem(4,8,549,10); --Lưng trục lộc - Hỏa - Nam
	me.AddItem(4,8,551,10); --Lưng trục lộc - Hỏa - Nam
	me.AddItem(4,8,469,10); --Lưng trục lộc - Hỏa - Nam
	me.AddItem(4,8,471,10); --Lưng trục lộc - Hỏa - Nam
end

function tbLiGuan:lsLungTrucLocNamTho()
	me.AddItem(4,8,533,10); --Lưng trục lộc - Thổ - Nam
	me.AddItem(4,8,535,10); --Lưng trục lộc - Thổ - Nam
	me.AddItem(4,8,553,10); --Lưng trục lộc - Thổ - Nam
	me.AddItem(4,8,555,10); --Lưng trục lộc - Thổ - Nam
	me.AddItem(4,8,473,10); --Lưng trục lộc - Thổ - Nam
	me.AddItem(4,8,475,10); --Lưng trục lộc - Thổ - Nam
end
--------------------------------------------------------------------------------------
function tbLiGuan:lsGiayTieuDaoNuKim()
	me.AddItem(4,7,32,10); --Giầy tiêu dao - Kim - Nữ
	me.AddItem(4,7,42,10); --Giầy tiêu dao - Kim - Nữ
end

function tbLiGuan:lsGiayTieuDaoNuMoc()
	me.AddItem(4,7,34,10); --Giầy tiêu dao - Mộc - Nữ
	me.AddItem(4,7,44,10); --Giầy tiêu dao - Mộc - Nữ
end

function tbLiGuan:lsGiayTieuDaoNuThuy()
	me.AddItem(4,7,36,10); --Giầy tiêu dao - Thủy - Nữ
	me.AddItem(4,7,46,10); --Giầy tiêu dao - Thủy - Nữ
end

function tbLiGuan:lsGiayTieuDaoNuHoa()
	me.AddItem(4,7,38,10); --Giầy tiêu dao - Hỏa - Nữ
	me.AddItem(4,7,48,10); --Giầy tiêu dao - Hỏa - Nữ
end

function tbLiGuan:lsGiayTieuDaoNuTho()
	me.AddItem(4,7,40,10); --Giầy tiêu dao - Thổ - Nữ
	me.AddItem(4,7,50,10); --Giầy tiêu dao - Thổ - Nữ
end

function tbLiGuan:lsGiayTieuDaoNamKim()
	me.AddItem(4,7,31,10); --Giầy tiêu dao - Kim - Nam
	me.AddItem(4,7,41,10); --Giầy tiêu dao - Kim - Nam
end

function tbLiGuan:lsGiayTieuDaoNamMoc()
	me.AddItem(4,7,33,10); --Giầy tiêu dao - Mộc - Nam
	me.AddItem(4,7,43,10); --Giầy tiêu dao - Mộc - Nam
end

function tbLiGuan:lsGiayTieuDaoNamThuy()
	me.AddItem(4,7,35,10); --Giầy tiêu dao - Thủy - Nam
	me.AddItem(4,7,45,10); --Giầy tiêu dao - Thủy - Nam
end

function tbLiGuan:lsGiayTieuDaoNamHoa()
	me.AddItem(4,7,37,10); --Giầy tiêu dao - Hỏa - Nam
	me.AddItem(4,7,47,10); --Giầy tiêu dao - Hỏa - Nam
end

function tbLiGuan:lsGiayTieuDaoNamTho()
	me.AddItem(4,7,39,10); --Giầy tiêu dao - Thổ - Nam
	me.AddItem(4,7,49,10); --Giầy tiêu dao - Thổ - Nam
end
--------------------------------------------------------------------------------------
function tbLiGuan:lsAoThuyHoangNuKim()
	me.AddItem(4,3,20045,10); -- Áo thủy hoàng - nữ - Kim
end

function tbLiGuan:lsAoThuyHoangNuMoc()
	me.AddItem(4,3,20046,10); -- Áo thủy hoàng - nữ - mộc
end

function tbLiGuan:lsAoThuyHoangNuThuy()
	me.AddItem(4,3,20047,10); -- Áo thủy hoàng - nữ - thủy
end

function tbLiGuan:lsAoThuyHoangNuHoa()
	me.AddItem(4,3,20048,10); -- Áo thủy hoàng - nữ - hỏa
end

function tbLiGuan:lsAoThuyHoangNuTho()
	me.AddItem(4,3,20049,10); -- Áo thủy hoàng - nữ - thổ
end

function tbLiGuan:lsAoThuyHoangNamKim()
	me.AddItem(4,3,233,10); -- Áo thủy hoàng - nam - Kim
end

function tbLiGuan:lsAoThuyHoangNamMoc()
	me.AddItem(4,3,234,10); -- Áo thủy hoàng - nam - Mộc
end

function tbLiGuan:lsAoThuyHoangNamThuy()
	me.AddItem(4,3,235,10); -- Áo thủy hoàng - nam - Thủy
end

function tbLiGuan:lsAoThuyHoangNamHoa()
	me.AddItem(4,3,236,10); -- Áo thủy hoàng - nam - hỏa
end

function tbLiGuan:lsAoThuyHoangNamTho()
	me.AddItem(4,3,237,10); -- Áo thủy hoàng - nam - thổ
end
--------------------------------------------------------------------------------------
function tbLiGuan:lsNonTrucLocNuKim()
	me.AddItem(4,9,478,10); --Nón trục lộc - Kim - Nữ
	me.AddItem(4,9,488,10); --Nón trục lộc - Kim - Nữ
end

function tbLiGuan:lsNonTrucLocNuMoc()
	me.AddItem(4,9,480,10); --Nón trục lộc - Mộc - Nữ
	me.AddItem(4,9,490,10); --Nón trục lộc - Mộc - Nữ
end

function tbLiGuan:lsNonTrucLocNuThuy()
	me.AddItem(4,9,482,10); --Nón trục lộc - Thủy - Nữ
	me.AddItem(4,9,492,10); --Nón trục lộc - Thủy - Nữ
end

function tbLiGuan:lsNonTrucLocNuHoa()
	me.AddItem(4,9,484,10); --Nón trục lộc - Hỏa - Nữ
	me.AddItem(4,9,494,10); --Nón trục lộc - Hỏa - Nữ
end

function tbLiGuan:lsNonTrucLocNuTho()
	me.AddItem(4,9,486,10); --Nón trục lộc - Thổ - Nữ
	me.AddItem(4,9,496,10); --Nón trục lộc - Thổ - Nữ
end

function tbLiGuan:lsNonTrucLocNamKim()
	me.AddItem(4,9,477,10); --Nón trục lộc - Kim - Nam
	me.AddItem(4,9,487,10); --Nón trục lộc - Kim - Nam
end

function tbLiGuan:lsNonTrucLocNamMoc()
	me.AddItem(4,9,479,10); --Nón trục lộc - Mộc - Nam
	me.AddItem(4,9,489,10); --Nón trục lộc - Mộc - Nam
end

function tbLiGuan:lsNonTrucLocNamThuy()
	me.AddItem(4,9,481,10); --Nón trục lộc - Thủy - Nam
	me.AddItem(4,9,491,10); --Nón trục lộc - Thủy - Nam
end

function tbLiGuan:lsNonTrucLocNamHoa()
	me.AddItem(4,9,483,10); --Nón trục lộc - Hỏa - Nam
	me.AddItem(4,9,493,10); --Nón trục lộc - Hỏa - Nam
end

function tbLiGuan:lsNonTrucLocNamTho()
	me.AddItem(4,9,485,10); --Nón trục lộc - Thổ - Nam
	me.AddItem(4,9,495,10); --Nón trục lộc - Thổ - Nam
end
-----------------------------------------------------------------------
function tbLiGuan:lsHoPhuVuUyKim()
	me.AddItem(4,6,91,10); --Hộ phù vũ uy - Kim
	me.AddItem(4,6,92,10); --Hộ phù vũ uy - Kim
	me.AddItem(4,6,93,10); --Hộ phù vũ uy - Kim
	me.AddItem(4,6,94,10); --Hộ phù vũ uy - Kim
	me.AddItem(4,6,95,10); --Hộ phù vũ uy - Kim
end

function tbLiGuan:lsHoPhuVuUyMoc()
	me.AddItem(4,6,96,10); --Hộ phù vũ uy - Mộc
	me.AddItem(4,6,97,10); --Hộ phù vũ uy - Mộc
	me.AddItem(4,6,98,10); --Hộ phù vũ uy - Mộc
	me.AddItem(4,6,99,10); --Hộ phù vũ uy - Mộc
	me.AddItem(4,6,100,10); --Hộ phù vũ uy - Mộc 
end

function tbLiGuan:lsHoPhuVuUyThuy()
	me.AddItem(4,6,101,10); --Hộ phù vũ uy - Thủy
	me.AddItem(4,6,102,10); --Hộ phù vũ uy - Thủy
	me.AddItem(4,6,103,10); --Hộ phù vũ uy - Thủy
	me.AddItem(4,6,104,10); --Hộ phù vũ uy - Thủy
	me.AddItem(4,6,105,10); --Hộ phù vũ uy - Thủy
end

function tbLiGuan:lsHoPhuVuUyHoa()
	me.AddItem(4,6,106,10); --Hộ phù vũ uy - Hỏa
	me.AddItem(4,6,107,10); --Hộ phù vũ uy - Hỏa
	me.AddItem(4,6,108,10); --Hộ phù vũ uy - Hỏa
	me.AddItem(4,6,109,10); --Hộ phù vũ uy - Hỏa
	me.AddItem(4,6,110,10); --Hộ phù vũ uy - Hỏa
end

function tbLiGuan:lsHoPhuVuUyTho()
	me.AddItem(4,6,111,10); --Hộ phù vũ uy - Thổ
	me.AddItem(4,6,112,10); --Hộ phù vũ uy - Thổ
	me.AddItem(4,6,113,10); --Hộ phù vũ uy - Thổ
	me.AddItem(4,6,114,10); --Hộ phù vũ uy - Thổ
	me.AddItem(4,6,115,10); --Hộ phù vũ uy - Thổ
end
-----------------------------------------------------------------------
function tbLiGuan:lsLienTrucLocNuKim()
	me.AddItem(4,5,458,10); --Liên trục lộc - Kim - Nữ
end

function tbLiGuan:lsLienTrucLocNuMoc()
	me.AddItem(4,5,460,10); --Liên trục lộc - Mộc - Nữ
end

function tbLiGuan:lsLienTrucLocNuThuy()
	me.AddItem(4,5,462,10); --Liên trục lộc - Thủy - Nữ
end

function tbLiGuan:lsLienTrucLocNuHoa()
	me.AddItem(4,5,464,10); --Liên trục lộc - Hỏa - Nữ
end

function tbLiGuan:lsLienTrucLocNuTho()
	me.AddItem(4,5,466,10); --Liên trục lộc - Thổ - Nữ
end

function tbLiGuan:lsLienTrucLocNamKim()
	me.AddItem(4,5,457,10); --Liên trục lộc - Kim - Nam
end

function tbLiGuan:lsLienTrucLocNamMoc()
	me.AddItem(4,5,459,10); --Liên trục lộc - Mộc - Nam
end

function tbLiGuan:lsLienTrucLocNamThuy()
	me.AddItem(4,5,461,10); --Liên trục lộc - Thủy - Nam
end

function tbLiGuan:lsLienTrucLocNamHoa()
	me.AddItem(4,5,463,10); --Liên trục lộc - Hỏa - Nam
end

function tbLiGuan:lsLienTrucLocNamTho()
	me.AddItem(4,5,465,10); --Liên trục lộc - Thổ - Nam
end
-----------------------------------------------------------------------
function tbLiGuan:lsAoVuUyNuKim()
	me.AddItem(4,3,143,10); --Áo Vũ Y Nữ - Kim
	me.AddItem(4,3,148,10); --Áo Vũ Y Nữ - Kim
end

function tbLiGuan:lsAoVuUyNuMoc()
	me.AddItem(4,3,144,10); --Áo Vũ Y Nữ - Mộc
	me.AddItem(4,3,149,10); --Áo Vũ Y Nữ - Mộc
end

function tbLiGuan:lsAoVuUyNuThuy()
	me.AddItem(4,3,145,10); --Áo Vũ Y Nữ - Thủy
	me.AddItem(4,3,150,10); --Áo Vũ Y Nữ - Thủy
end

function tbLiGuan:lsAoVuUyNuHoa()
	me.AddItem(4,3,146,10); --Áo Vũ Y Nữ - Hỏa
	me.AddItem(4,3,151,10); --Áo Vũ Y Nữ - Hỏa
end

function tbLiGuan:lsAoVuUyNuTho()
	me.AddItem(4,3,147,10); --Áo Vũ Y Nữ - Thổ
	me.AddItem(4,3,152,10); --Áo Vũ Y Nữ - Thổ
end

function tbLiGuan:lsAoVuUyNamKim()
	me.AddItem(4,3,153,10); --Áo Vũ Y Nam - Kim
	me.AddItem(4,3,158,10); --Áo Vũ Y Nam - Kim
end

function tbLiGuan:lsAoVuUyNamMoc()
	me.AddItem(4,3,154,10); --Áo Vũ Y Nam - Mộc
	me.AddItem(4,3,159,10); --Áo Vũ Y Nam - Mộc
end

function tbLiGuan:lsAoVuUyNamThuy()
	me.AddItem(4,3,155,10); --Áo Vũ Y Nam - Thủy
	me.AddItem(4,3,160,10); --Áo Vũ Y Nam - Thủy
end

function tbLiGuan:lsAoVuUyNamHoa()
	me.AddItem(4,3,156,10); --Áo Vũ Y Nam - Hỏa
	me.AddItem(4,3,161,10); --Áo Vũ Y Nam - Hỏa
end

function tbLiGuan:lsAoVuUyNamTho()
	me.AddItem(4,3,157,10); --Áo Vũ Y Nam - Thổ
	me.AddItem(4,3,162,10); --Áo Vũ Y Nam - Thổ
end
-----------------------------------------------------------------------
function tbLiGuan:lsNhanVuUyNuKim()
	me.AddItem(4,4,445,10); --Nhẫn Vũ Uy - Kim - Nữ
	me.AddItem(4,4,455,10); --Nhẫn Vũ Uy - Kim - Nữ
end

function tbLiGuan:lsNhanVuUyNuMoc()
	me.AddItem(4,4,447,10); --Nhẫn Vũ Uy - Mộc - Nữ
	me.AddItem(4,4,457,10); --Nhẫn Vũ Uy - Mộc - Nữ
end

function tbLiGuan:lsNhanVuUyNuThuy()
	me.AddItem(4,4,449,10); --Nhẫn Vũ Uy - Thủy - Nữ
	me.AddItem(4,4,459,10); --Nhẫn Vũ Uy - Thủy - Nữ
end

function tbLiGuan:lsNhanVuUyNuHoa()
	me.AddItem(4,4,451,10); --Nhẫn Vũ Uy - Hỏa - Nữ
	me.AddItem(4,4,461,10); --Nhẫn Vũ Uy - Hỏa - Nữ
end

function tbLiGuan:lsNhanVuUyNuTho()
	me.AddItem(4,4,453,10); --Nhẫn Vũ Uy - Thổ - Nữ
	me.AddItem(4,4,463,10); --Nhẫn Vũ Uy - Thổ - Nữ
end

function tbLiGuan:lsNhanVuUyNamKim()
	me.AddItem(4,4,444,10); --Nhẫn Vũ Uy - Kim - Nam
	me.AddItem(4,4,454,10); --Nhẫn Vũ Uy - Kim - Nam
end

function tbLiGuan:lsNhanVuUyNamMoc()
	me.AddItem(4,4,446,10); --Nhẫn Vũ Uy - Mộc - Nam
	me.AddItem(4,4,456,10); --Nhẫn Vũ Uy - Mộc - Nam
end

function tbLiGuan:lsNhanVuUyNamThuy()
	me.AddItem(4,4,448,10); --Nhẫn Vũ Uy - Thủy - Nam
	me.AddItem(4,4,458,10); --Nhẫn Vũ Uy - Thủy - Nam
end

function tbLiGuan:lsNhanVuUyNamHoa()
	me.AddItem(4,4,450,10); --Nhẫn Vũ Uy - Hỏa - Nam
	me.AddItem(4,4,460,10); --Nhẫn Vũ Uy - Hỏa - Nam
end

function tbLiGuan:lsNhanVuUyNamTho()
	me.AddItem(4,4,452,10); --Nhẫn Vũ Uy - Thổ - Nam
	me.AddItem(4,4,462,10); --Nhẫn Vũ Uy - Thổ - Nam
end
-----------------------------------------------------------------------
function tbLiGuan:lsNgocBoiThuyHoangNuKim()
	me.AddItem(2,11,722,10); --Ngọc bội thủy hoàng - Kim - Nữ
end

function tbLiGuan:lsNgocBoiThuyHoangNuMoc()
	me.AddItem(2,11,724,10); --Ngọc bội thủy hoàng - Mộc - Nữ
end

function tbLiGuan:lsNgocBoiThuyHoangNuThuy()
	me.AddItem(2,11,726,10); --Ngọc bội thủy hoàng - Thủy - Nữ
end

function tbLiGuan:lsNgocBoiThuyHoangNuHoa()
	me.AddItem(2,11,728,10); --Ngọc bội thủy hoàng - Hỏa - Nữ
end

function tbLiGuan:lsNgocBoiThuyHoangNuTho()
	me.AddItem(2,11,730,10); --Ngọc bội thủy hoàng - Thổ - Nữ
end

function tbLiGuan:lsNgocBoiThuyHoangNamKim()
	me.AddItem(2,11,721,10); --Ngọc bội thủy hoàng - Kim - nam
end

function tbLiGuan:lsNgocBoiThuyHoangNamMoc()
	me.AddItem(2,11,723,10); --Ngọc bội thủy hoàng - Mộc - nam
end

function tbLiGuan:lsNgocBoiThuyHoangNamThuy()
	me.AddItem(2,11,725,10); --Ngọc bội thủy hoàng - Thủy - nam
end

function tbLiGuan:lsNgocBoiThuyHoangNamHoa()
	me.AddItem(2,11,727,10); --Ngọc bội thủy hoàng - Hỏa - nam
end

function tbLiGuan:lsNgocBoiThuyHoangNamTho()
	me.AddItem(2,11,729,10); --Ngọc bội thủy hoàng - Thổ - nam
end
--------------------------------------------------------------------------------
function tbLiGuan:lsBaoTayThuyHoangNuKim()
	me.AddItem(2,10,714,10); --Bao tay thủy hoàng - Kim - Nữ
end

function tbLiGuan:lsBaoTayThuyHoangNuMoc()
	me.AddItem(2,10,716,10); --Bao tay thủy hoàng - Mộc - Nữ
end

function tbLiGuan:lsBaoTayThuyHoangNuThuy()
	me.AddItem(2,10,718,10); --Bao tay thủy hoàng - Thủy - Nữ
end

function tbLiGuan:lsBaoTayThuyHoangNuHoa()
	me.AddItem(2,10,720,10); --Bao tay thủy hoàng - Hỏa - Nữ
end

function tbLiGuan:lsBaoTayThuyHoangNuTho()
	me.AddItem(2,10,722,10); --Bao tay thủy hoàng - Thổ - Nữ
end

function tbLiGuan:lsBaoTayThuyHoangNamKim()
	me.AddItem(2,10,713,10); --Bao tay thủy hoàng - Kim - Nam
end

function tbLiGuan:lsBaoTayThuyHoangNamMoc()
	me.AddItem(2,10,715,10); --Bao tay thủy hoàng - Mộc - Nam
end

function tbLiGuan:lsBaoTayThuyHoangNamThuy()
	me.AddItem(2,10,717,10); --Bao tay thủy hoàng - Thủy - Nam
end

function tbLiGuan:lsBaoTayThuyHoangNamHoa()
	me.AddItem(2,10,719,10); --Bao tay thủy hoàng - Hỏa - Nam
end

function tbLiGuan:lsBaoTayThuyHoangNamTho()
	me.AddItem(2,10,721,10); --Bao tay thủy hoàng - Thổ - Nam
end	
----------------------------------------------------------------------------
function tbLiGuan:lsBaoTayTieuDaoNuKim()
	me.AddItem(4,10,442,10); --Bao tay tiêu dao - Kim - Nữ
	me.AddItem(4,10,444,10); --Bao tay tiêu dao - Kim - Nữ
	me.AddItem(4,10,462,10); --Bao tay tiêu dao - Kim - Nữ
	me.AddItem(4,10,464,10); --Bao tay tiêu dao - Kim - Nữ
end

function tbLiGuan:lsBaoTayTieuDaoNuMoc()
	me.AddItem(4,10,446,10); --Bao tay tiêu dao - Mộc - Nữ
	me.AddItem(4,10,448,10); --Bao tay tiêu dao - Mộc - Nữ
	me.AddItem(4,10,466,10); --Bao tay tiêu dao - Mộc - Nữ
	me.AddItem(4,10,468,10); --Bao tay tiêu dao - Mộc - Nữ
end

function tbLiGuan:lsBaoTayTieuDaoNuThuy()
	me.AddItem(4,10,450,10); --Bao tay tiêu dao - Thủy - Nữ
	me.AddItem(4,10,452,10); --Bao tay tiêu dao - Thủy - Nữ
	me.AddItem(4,10,470,10); --Bao tay tiêu dao - Thủy - Nữ
	me.AddItem(4,10,472,10); --Bao tay tiêu dao - Thủy - Nữ
end

function tbLiGuan:lsBaoTayTieuDaoNuHoa()
	me.AddItem(4,10,454,10); --Bao tay tiêu dao - Hỏa - Nữ
	me.AddItem(4,10,456,10); --Bao tay tiêu dao - Hỏa - Nữ
	me.AddItem(4,10,474,10); --Bao tay tiêu dao - Hỏa - Nữ
	me.AddItem(4,10,476,10); --Bao tay tiêu dao - Hỏa - Nữ
end

function tbLiGuan:lsBaoTayTieuDaoNuTho()
	me.AddItem(4,10,458,10); --Bao tay tiêu dao - Thổ - Nữ
	me.AddItem(4,10,460,10); --Bao tay tiêu dao - Thổ - Nữ
	me.AddItem(4,10,478,10); --Bao tay tiêu dao - Thổ - Nữ
	me.AddItem(4,10,480,10); --Bao tay tiêu dao - Thổ - Nữ
end

function tbLiGuan:lsBaoTayTieuDaoNamKim()
	me.AddItem(4,10,441,10); --Bao tay tiêu dao - Kim - Nam
	me.AddItem(4,10,443,10); --Bao tay tiêu dao - Kim - Nam
	me.AddItem(4,10,461,10); --Bao tay tiêu dao - Kim - Nam
	me.AddItem(4,10,463,10); --Bao tay tiêu dao - Kim - Nam
end

function tbLiGuan:lsBaoTayTieuDaoNamMoc()
	me.AddItem(4,10,445,10); --Bao tay tiêu dao - Mộc - Nam
	me.AddItem(4,10,447,10); --Bao tay tiêu dao - Mộc - Nam
	me.AddItem(4,10,465,10); --Bao tay tiêu dao - Mộc - Nam
	me.AddItem(4,10,467,10); --Bao tay tiêu dao - Mộc - Nam
end

function tbLiGuan:lsBaoTayTieuDaoNamThuy()
	me.AddItem(4,10,449,10); --Bao tay tiêu dao - Thủy - Nam
	me.AddItem(4,10,451,10); --Bao tay tiêu dao - Thủy - Nam
	me.AddItem(4,10,469,10); --Bao tay tiêu dao - Thủy - Nam
	me.AddItem(4,10,471,10); --Bao tay tiêu dao - Thủy - Nam
end

function tbLiGuan:lsBaoTayTieuDaoNamHoa()
	me.AddItem(4,10,453,10); --Bao tay tiêu dao - Hỏa - Nam
	me.AddItem(4,10,455,10); --Bao tay tiêu dao - Hỏa - Nam
	me.AddItem(4,10,473,10); --Bao tay tiêu dao - Hỏa - Nam
	me.AddItem(4,10,475,10); --Bao tay tiêu dao - Hỏa - Nam
end

function tbLiGuan:lsBaoTayTieuDaoNamTho()
	me.AddItem(4,10,457,10); --Bao tay tiêu dao - Thổ - Nam
	me.AddItem(4,10,459,10); --Bao tay tiêu dao - Thổ - Nam
	me.AddItem(4,10,477,10); --Bao tay tiêu dao - Thổ - Nam
	me.AddItem(4,10,479,10); --Bao tay tiêu dao - Thổ - Nam
end
-------------------------------------------------------------------------------
function tbLiGuan:DoCuoi10()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"Do Nam",self.DoNam10,self};
		{"Do Nu",self.DoNu10,self },
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNam10()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim10,self};
		{"He Moc",self.HeMoc10,self};
		{"He Thuy",self.HeThuy10,self};
		{"He Hoa",self.HeHoa10,self};
		{"He Tho",self.HeTho10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNu10()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim101,self};
		{"He Moc",self.HeMoc101,self};
		{"He Thuy",self.HeThuy101,self};
		{"He Hoa",self.HeHoa101,self};
		{"He Tho",self.HeTho101,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim10()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai10,self};
		{"Đồ Nội",self.KimNoi10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim101()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai101,self};
		{"Đồ Nội",self.KimNoi101,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc10()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai10,self};
		{"Đồ Nội",self.MocNoi10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc101()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai101,self};
		{"Đồ Nội",self.MocNoi101,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy10()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai10,self};
		{"Đồ Nội",self.ThuyNoi10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy101()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai101,self};
		{"Đồ Nội",self.ThuyNoi101,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa10()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai10,self};
		{"Đồ Nội",self.HoaNoi10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa101()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai101,self};
		{"Đồ Nội",self.HoaNoi101,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho10()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai10,self};
		{"Đồ Nội",self.ThoNoi10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho101()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai101,self};
		{"Đồ Nội",self.ThoNoi101,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:KimNgoai10()
	me.AddGreenEquip(10,20211,10,5,10); --Th?y Hoàng H?ng Hoang Uy?n
	me.AddGreenEquip(4,20161,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20085,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNgoai101()
	me.AddGreenEquip(10,20212,10,5,10);
	me.AddGreenEquip(4,20161,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20085,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi10()
	me.AddGreenEquip(10,20213,10,5,10);
	me.AddGreenEquip(4,20162,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20086,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi101()
	me.AddGreenEquip(10,20214,10,5,10);
	me.AddGreenEquip(4,20162,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20086,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai10()
	me.AddGreenEquip(10,20215,10,5,10);
	me.AddGreenEquip(4,20163,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20087,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai101()
	me.AddGreenEquip(10,20216,10,5,10);
	me.AddGreenEquip(4,20163,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20087,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi10()
	me.AddGreenEquip(10,20217,10,5,10);
	me.AddGreenEquip(4,20164,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20088,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi101()
	me.AddGreenEquip(10,20218,10,5,10);
	me.AddGreenEquip(4,20164,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20088,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai10()
	me.AddGreenEquip(10,20219,10,5,10);
	me.AddGreenEquip(4,20165,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20089,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai101()
	me.AddGreenEquip(10,20220,10,5,10);
	me.AddGreenEquip(4,20165,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20089,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi10()
	me.AddGreenEquip(10,20221,10,5,10);
	me.AddGreenEquip(4,20166,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20090,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi110()
	me.AddGreenEquip(10,20222,10,5,10);
	me.AddGreenEquip(4,20166,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20090,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai10()
	me.AddGreenEquip(10,20223,10,5,10);
	me.AddGreenEquip(4,20167,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20091,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai101()
	me.AddGreenEquip(10,20224,10,5,10);
	me.AddGreenEquip(4,20167,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20091,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi10()
	me.AddGreenEquip(10,20225,10,5,10);
	me.AddGreenEquip(4,20168,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20092,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi101()
	me.AddGreenEquip(10,20226,10,5,10);
	me.AddGreenEquip(4,20168,10,5,10);--V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20092,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai10()
	me.AddGreenEquip(10,20227,10,5,10);
	me.AddGreenEquip(4,20169,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20093,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai101()
	me.AddGreenEquip(10,20228,10,5,10);
	me.AddGreenEquip(4,20169,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(4,20169,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20093,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi10()
	me.AddGreenEquip(10,20229,10,5,10);
	me.AddGreenEquip(4,20170,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20094,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi101()
	me.AddGreenEquip(10,20230,10,5,10);
	me.AddGreenEquip(4,20170,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20094,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end
-------------------------------------------------------------------------------
function tbLiGuan:DoCuoi12()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"Do Nam",self.DoNam12,self};
		{"Do Nu",self.DoNu12,self },
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNam12()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim12,self};
		{"He Moc",self.HeMoc12,self};
		{"He Thuy",self.HeThuy12,self};
		{"He Hoa",self.HeHoa12,self};
		{"He Tho",self.HeTho12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNu12()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim121,self};
		{"He Moc",self.HeMoc121,self};
		{"He Thuy",self.HeThuy121,self};
		{"He Hoa",self.HeHoa121,self};
		{"He Tho",self.HeTho121,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim12()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai12,self};
		{"Đồ Nội",self.KimNoi12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim121()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai121,self};
		{"Đồ Nội",self.KimNoi121,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc12()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai12,self};
		{"Đồ Nội",self.MocNoi12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc121()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai121,self};
		{"Đồ Nội",self.MocNoi121,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy12()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai12,self};
		{"Đồ Nội",self.ThuyNoi12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy121()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai121,self};
		{"Đồ Nội",self.ThuyNoi121,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa12()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai12,self};
		{"Đồ Nội",self.HoaNoi12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa121()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai121,self};
		{"Đồ Nội",self.HoaNoi121,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho12()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai12,self};
		{"Đồ Nội",self.ThoNoi12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho121()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai121,self};
		{"Đồ Nội",self.ThoNoi121,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:KimNgoai12()
	me.AddGreenEquip(10,20211,10,5,12); --Th?y Hoàng H?ng Hoang Uy?n
	me.AddGreenEquip(4,20161,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20085,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNgoai121()
	me.AddGreenEquip(10,20212,10,5,12);
	me.AddGreenEquip(4,20161,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20085,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi12()
	me.AddGreenEquip(10,20213,10,5,12);
	me.AddGreenEquip(4,20162,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20086,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi121()
	me.AddGreenEquip(10,20214,10,5,12);
	me.AddGreenEquip(4,20162,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20086,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai12()
	me.AddGreenEquip(10,20215,10,5,12);
	me.AddGreenEquip(4,20163,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20087,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai121()
	me.AddGreenEquip(10,20216,10,5,12);
	me.AddGreenEquip(4,20163,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20087,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi12()
	me.AddGreenEquip(10,20217,10,5,12);
	me.AddGreenEquip(4,20164,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20088,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi121()
	me.AddGreenEquip(10,20218,10,5,12);
	me.AddGreenEquip(4,20164,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20088,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai12()
	me.AddGreenEquip(10,20219,10,5,12);
	me.AddGreenEquip(4,20165,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20089,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai121()
	me.AddGreenEquip(10,20220,10,5,12);
	me.AddGreenEquip(4,20165,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20089,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi12()
	me.AddGreenEquip(10,20221,10,5,12);
	me.AddGreenEquip(4,20166,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20090,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi112()
	me.AddGreenEquip(10,20222,10,5,12);
	me.AddGreenEquip(4,20166,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20090,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai12()
	me.AddGreenEquip(10,20223,10,5,12);
	me.AddGreenEquip(4,20167,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20091,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai121()
	me.AddGreenEquip(10,20224,10,5,12);
	me.AddGreenEquip(4,20167,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20091,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi12()
	me.AddGreenEquip(10,20225,10,5,12);
	me.AddGreenEquip(4,20168,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20092,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi121()
	me.AddGreenEquip(10,20226,10,5,12);
	me.AddGreenEquip(4,20168,10,5,12);--V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20092,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai12()
	me.AddGreenEquip(10,20227,10,5,12);
	me.AddGreenEquip(4,20169,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20093,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai121()
	me.AddGreenEquip(10,20228,10,5,12);
	me.AddGreenEquip(4,20169,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20093,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi12()
	me.AddGreenEquip(10,20229,10,5,12);
	me.AddGreenEquip(4,20170,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20094,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi121()
	me.AddGreenEquip(10,20230,10,5,12);
	me.AddGreenEquip(4,20170,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20094,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end
-------------------------------------------------------------------------------
function tbLiGuan:DoCuoi14()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"Do Nam",self.DoNam14,self};
		{"Do Nu",self.DoNu14,self },
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNam14()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim14,self};
		{"He Moc",self.HeMoc14,self};
		{"He Thuy",self.HeThuy14,self};
		{"He Hoa",self.HeHoa14,self};
		{"He Tho",self.HeTho14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNu14()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim141,self};
		{"He Moc",self.HeMoc141,self};
		{"He Thuy",self.HeThuy141,self};
		{"He Hoa",self.HeHoa141,self};
		{"He Tho",self.HeTho141,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim14()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai14,self};
		{"Đồ Nội",self.KimNoi14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim141()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai141,self};
		{"Đồ Nội",self.KimNoi141,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc14()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai14,self};
		{"Đồ Nội",self.MocNoi14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc141()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai141,self};
		{"Đồ Nội",self.MocNoi141,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy14()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai14,self};
		{"Đồ Nội",self.ThuyNoi14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy141()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai141,self};
		{"Đồ Nội",self.ThuyNoi141,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa14()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai14,self};
		{"Đồ Nội",self.HoaNoi14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa141()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai141,self};
		{"Đồ Nội",self.HoaNoi141,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho14()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai14,self};
		{"Đồ Nội",self.ThoNoi14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho141()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai141,self};
		{"Đồ Nội",self.ThoNoi141,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:KimNgoai14()
	me.AddGreenEquip(10,20211,10,5,14); --Th?y Hoàng H?ng Hoang Uy?n
	me.AddGreenEquip(4,20161,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20085,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNgoai141()
	me.AddGreenEquip(10,20212,10,5,14);
	me.AddGreenEquip(4,20161,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20085,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi14()
	me.AddGreenEquip(10,20213,10,5,14);
	me.AddGreenEquip(4,20162,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20086,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi141()
	me.AddGreenEquip(10,20214,10,5,14);
	me.AddGreenEquip(4,20162,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20086,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai14()
	me.AddGreenEquip(10,20215,10,5,14);
	me.AddGreenEquip(4,20163,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20087,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai141()
	me.AddGreenEquip(10,20216,10,5,14);
	me.AddGreenEquip(4,20163,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20087,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi14()
	me.AddGreenEquip(10,20217,10,5,14);
	me.AddGreenEquip(4,20164,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20088,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi141()
	me.AddGreenEquip(10,20218,10,5,14);
	me.AddGreenEquip(4,20164,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20088,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai14()
	me.AddGreenEquip(10,20219,10,5,14);
	me.AddGreenEquip(4,20165,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20089,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai141()
	me.AddGreenEquip(10,20220,10,5,14);
	me.AddGreenEquip(4,20165,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20089,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi14()
	me.AddGreenEquip(10,20221,10,5,14);
	me.AddGreenEquip(4,20166,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20090,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi114()
	me.AddGreenEquip(10,20222,10,5,14);
	me.AddGreenEquip(4,20166,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20090,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai14()
	me.AddGreenEquip(10,20223,10,5,14);
	me.AddGreenEquip(4,20167,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20091,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai141()
	me.AddGreenEquip(10,20224,10,5,14);
	me.AddGreenEquip(4,20167,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20091,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi14()
	me.AddGreenEquip(10,20225,10,5,14);
	me.AddGreenEquip(4,20168,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20092,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi141()
	me.AddGreenEquip(10,20226,10,5,14);
	me.AddGreenEquip(4,20168,10,5,14);--V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20092,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai14()
	me.AddGreenEquip(10,20227,10,5,14);
	me.AddGreenEquip(4,20169,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20093,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai141()
	me.AddGreenEquip(10,20228,10,5,14);
	me.AddGreenEquip(4,20169,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20093,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi14()
	me.AddGreenEquip(10,20229,10,5,14);
	me.AddGreenEquip(4,20170,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20094,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi141()
	me.AddGreenEquip(10,20230,10,5,14);
	me.AddGreenEquip(4,20170,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20094,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end
-------------------------------------------------------------------------------
function tbLiGuan:DoCuoi16()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"Do Nam",self.DoNam16,self};
		{"Do Nu",self.DoNu16,self },
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNam16()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim16,self};
		{"He Moc",self.HeMoc16,self};
		{"He Thuy",self.HeThuy16,self};
		{"He Hoa",self.HeHoa16,self};
		{"He Tho",self.HeTho16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNu16()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim161,self};
		{"He Moc",self.HeMoc161,self};
		{"He Thuy",self.HeThuy161,self};
		{"He Hoa",self.HeHoa161,self};
		{"He Tho",self.HeTho161,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim16()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai16,self};
		{"Đồ Nội",self.KimNoi16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim161()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai161,self};
		{"Đồ Nội",self.KimNoi161,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc16()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai16,self};
		{"Đồ Nội",self.MocNoi16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc161()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai161,self};
		{"Đồ Nội",self.MocNoi161,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy16()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai16,self};
		{"Đồ Nội",self.ThuyNoi16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy161()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai161,self};
		{"Đồ Nội",self.ThuyNoi161,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa16()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai16,self};
		{"Đồ Nội",self.HoaNoi16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa161()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai161,self};
		{"Đồ Nội",self.HoaNoi161,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho16()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai16,self};
		{"Đồ Nội",self.ThoNoi16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho161()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai161,self};
		{"Đồ Nội",self.ThoNoi161,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:KimNgoai16()
	me.AddGreenEquip(10,20211,10,5,16); --Th?y Hoàng H?ng Hoang Uy?n
	me.AddGreenEquip(4,20161,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20085,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNgoai161()
	me.AddGreenEquip(10,20212,10,5,16);
	me.AddGreenEquip(4,20161,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20085,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi16()
	me.AddGreenEquip(10,20213,10,5,16);
	me.AddGreenEquip(4,20162,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20086,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi161()
	me.AddGreenEquip(10,20214,10,5,16);
	me.AddGreenEquip(4,20162,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20086,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai16()
	me.AddGreenEquip(10,20215,10,5,16);
	me.AddGreenEquip(4,20163,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20087,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai161()
	me.AddGreenEquip(10,20216,10,5,16);
	me.AddGreenEquip(4,20163,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20087,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi16()
	me.AddGreenEquip(10,20217,10,5,16);
	me.AddGreenEquip(4,20164,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20088,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi161()
	me.AddGreenEquip(10,20218,10,5,16);
	me.AddGreenEquip(4,20164,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20088,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai16()
	me.AddGreenEquip(10,20219,10,5,16);
	me.AddGreenEquip(4,20165,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20089,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai161()
	me.AddGreenEquip(10,20220,10,5,16);
	me.AddGreenEquip(4,20165,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20089,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi16()
	me.AddGreenEquip(10,20221,10,5,16);
	me.AddGreenEquip(4,20166,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20090,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi161()
	me.AddGreenEquip(10,20222,10,5,16);
	me.AddGreenEquip(4,20166,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20090,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai16()
	me.AddGreenEquip(10,20223,10,5,16);
	me.AddGreenEquip(4,20167,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20091,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai161()
	me.AddGreenEquip(10,20224,10,5,16);
	me.AddGreenEquip(4,20167,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20091,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi16()
	me.AddGreenEquip(10,20225,10,5,16);
	me.AddGreenEquip(4,20168,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20092,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi161()
	me.AddGreenEquip(10,20226,10,5,16);
	me.AddGreenEquip(4,20168,10,5,16);--V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20092,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai16()
	me.AddGreenEquip(10,20227,10,5,16);
	me.AddGreenEquip(4,20169,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20093,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai161()
	me.AddGreenEquip(10,20228,10,5,16);
	me.AddGreenEquip(4,20169,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20093,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi16()
	me.AddGreenEquip(10,20229,10,5,16);
	me.AddGreenEquip(4,20170,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20094,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi161()
	me.AddGreenEquip(10,20230,10,5,16);
	me.AddGreenEquip(4,20170,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20094,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

-----------------------------------------------------------------------------------
function tbLiGuan:LungTrucLocKoBanDuoc()
--me.AddItem(4,8,477,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,478,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,479,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,480,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,483,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,484,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,487,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,488,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,491,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,492,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,495,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,496,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,499,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,500,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,503,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,504,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,507,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,508,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,511,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,512,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,515,10); - Lưng trục lộc Ko Bán đc
--me.AddItem(4,8,516,10); - Lưng trục lộc Ko Bán đc
end
------------------------------------------------------------------------------
function tbLiGuan:ThuyhoangKhongKhoa()
--me.AddItem(4,3,238,10); -- Áo thủy hoàng - nam - Kim - Ko khóa, ko bán đc
--me.AddItem(4,3,239,10); -- Áo thủy hoàng - nam - mộc - Ko khóa, ko bán đc
--me.AddItem(4,3,240,10); -- Áo thủy hoàng - nam - thủy - Ko khóa, ko bán đc
--me.AddItem(4,3,241,10); -- Áo thủy hoàng - nam - hỏa - Ko khóa, ko bán đc
--me.AddItem(4,3,242,10); -- Áo thủy hoàng - nam - thổ - Ko khóa, ko bán đc
--me.AddItem(4,3,20050,10); -- Áo thủy hoàng - nữ - kim - Ko khóa, ko bán đc
--me.AddItem(4,3,20051,10); -- Áo thủy hoàng - nữ - mộc - Ko khóa, ko bán đc
--me.AddItem(4,3,20052,10); -- Áo thủy hoàng - nữ - thủy - Ko khóa, ko bán đc
--me.AddItem(4,3,20053,10); -- Áo thủy hoàng - nữ - hỏa - Ko khóa, ko bán đc
--me.AddItem(4,3,20054,10); -- Áo thủy hoàng - nữ - thổ - Ko khóa, ko bán đc
end
------------------------------------------------------------------------------------------
function tbLiGuan:NgocBoiThuyHoangKoBanDc()
	--me.AddItem(4,11,20105,10); --Ngọc bội thủy hoàng ko bán đc
	--me.AddItem(4,11,20106,10); --Ngọc bội thủy hoàng ko bán đc
	--me.AddItem(4,11,20107,10); --Ngọc bội thủy hoàng ko bán đc
	--me.AddItem(4,11,20108,10); --Ngọc bội thủy hoàng ko bán đc
	--me.AddItem(4,11,20109,10); --Ngọc bội thủy hoàng ko bán đc
	--me.AddItem(4,11,20110,10); --Ngọc bội thủy hoàng ko bán đc
	--me.AddItem(4,11,20111,10); --Ngọc bội thủy hoàng ko bán đc
	--me.AddItem(4,11,20112,10); --Ngọc bội thủy hoàng ko bán đc
	--me.AddItem(4,11,20113,10); --Ngọc bội thủy hoàng ko bán đc
	--me.AddItem(4,11,20114,10); --Ngọc bội thủy hoàng ko bán đc
end
-----------------------------------------------------------------------
function tbLiGuan:LienTrucLocKoBanDc()
	--me.AddItem(4,5,20085,10); --Liên trục lộc ko bán đc
	--me.AddItem(4,5,20086,10); --Liên trục lộc ko bán đc
	--me.AddItem(4,5,20087,10); --Liên trục lộc ko bán đc
	--me.AddItem(4,5,20088,10); --Liên trục lộc ko bán đc
	--me.AddItem(4,5,20089,10); --Liên trục lộc ko bán đc
	--me.AddItem(4,5,20090,10); --Liên trục lộc ko bán đc
	--me.AddItem(4,5,20091,10); --Liên trục lộc ko bán đc
	--me.AddItem(4,5,20092,10); --Liên trục lộc ko bán đc
	--me.AddItem(4,5,20093,10); --Liên trục lộc ko bán đc
	--me.AddItem(4,5,20094,10); --Liên trục lộc ko bán đc
end
------------------------------------------------------------------------------
function tbLiGuan:HoPhuVuUyKoBanDc()
	--me.AddItem(4,6,20000,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,20001,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,20002,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,20003,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,457,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,458,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,459,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,460,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,461,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,462,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,463,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,464,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,465,10); --Hộ phù vũ uy - ko bán đc
	--me.AddItem(4,6,466,10); --Hộ phù vũ uy - ko bán đc
end
----------------------------------------------------------------------------------
function tbLiGuan:bandonghanhChuaSD()
	--me.AddItem(18,1,547,3);	--đồng hành chưa SD đc
	--me.AddItem(18,1,567,1);	 --bạn đồng hành 1 kỹ năng
	--me.AddItem(18,1,567,2);
	--me.AddItem(18,1,567,3);
	--me.AddItem(18,1,567,4);
	--me.AddItem(18,1,567,5);
	--me.AddItem(18,1,567,6); --bạn đồng hành 6 kỹ năng
end
----------------------------------------------------------------------------------
function tbLiGuan:channguyen()
	for i=1,500 do
		if me.CountFreeBagCell() > 0 then
   me.AddItem(18,1,25122,1)
		else
			break
		end
	end
end

function tbLiGuan:channguyen1()
	me.AddItem(18,1,25117,1)
	me.AddItem(18,1,25118,1)
	me.AddItem(18,1,25119,1)
	me.AddItem(18,1,25117,1)
	me.AddItem(18,1,25118,1)
	me.AddItem(18,1,25119,1)
	me.AddItem(18,1,25117,1)
	me.AddItem(18,1,25118,1)
	me.AddItem(18,1,25119,1)
	me.AddItem(18,1,25117,1)
	me.AddItem(18,1,25118,1)
	me.AddItem(18,1,25119,1)
	me.AddItem(18,1,25117,1)
	me.AddItem(18,1,25118,1)
	me.AddItem(18,1,25119,1)
	me.AddItem(18,1,25117,1)
	me.AddItem(18,1,25118,1)
	me.AddItem(18,1,25119,1)
	me.AddItem(18,1,25117,1)
	me.AddItem(18,1,25118,1)
	me.AddItem(18,1,25119,1)
	me.AddItem(18,1,25117,1)
	me.AddItem(18,1,25118,1)
	me.AddItem(18,1,25119,1)
	me.AddItem(18,1,25117,1)
	me.AddItem(18,1,25118,1)
	me.AddItem(18,1,25119,1)
	me.AddItem(18,1,25117,1)
	me.AddItem(18,1,25118,1)
	me.AddItem(18,1,25119,1)
end

function tbLiGuan:channguyen2()
	me.AddItem(1,27,1,1);
	me.AddItem(1,27,2,1);
	me.AddItem(1,27,3,1);
	me.AddItem(1,27,4,1);
	me.AddItem(1,27,5,1);
end

function tbLiGuan:channguyen3()
me.AddItem(18,1,25125,1)
me.AddItem(18,1,25126,1)
me.AddItem(18,1,25127,1)
me.AddItem(18,1,25122,1)
me.AddItem(18,1,25123,1)
me.AddItem(18,1,25124,1)
end




function tbLiGuan:LuyenHoaMaxChanNguyen()
local pItem = me.GetEquip(Item.EQUIPPOS_ZHENYUAN_MAIN);
Item:UpgradeZhenYuanNoItem(pItem,1000000,1);
Item:UpgradeZhenYuanNoItem(pItem,1000000,2);
Item:UpgradeZhenYuanNoItem(pItem,1000000,3);
Item:UpgradeZhenYuanNoItem(pItem,1000000,4);
end
---------------------
------------------
function tbLiGuan:LuyenHoaMaxThanhLinh()

local pItem = me.GetEquip(Item.EQUIPPOS_ZHENYUAN_SUB1);
Item:UpgradeSoulSignetNoItem(pItem,100000000000,1) ;
Item:UpgradeSoulSignetNoItem(pItem,100000000000,2) ;
Item:UpgradeSoulSignetNoItem(pItem,100000000000,3) ;
Item:UpgradeSoulSignetNoItem(pItem,100000000000,4) ;
Item:UpgradeSoulSignetNoItem(pItem,100000000000,5) ;
end
---------------------
function tbLiGuan:LuyenHoaMaxChanVu()

local pItem = me.GetEquip(Item.EQUIPPOS_OUTHAT);
Item:UpgradeOuthatNoItem(pItem,100000000000,1);
end

--------------------------
function tbLiGuan:LuyenHoaMaxNgoaiTrang()

local pItem = me.GetEquip(Item.EQUIPPOS_GARMENT);
Item:UpgradeGarmentNoItem(pItem,100000000000,1);
end





function tbLiGuan:songlong() 
 local nSeries = me.nSeries; 
 local szMsg = "Nhận Song Long Tình Kiếm nhé ^^ "; 
 local tbOpt = { 
  {"Song Long Nữ",self.songlongnu,self}, 
  {"Song Long Nam",self.songlongnam,self}, 

   } 
 Dialog:Say(szMsg,tbOpt); 
end 

function tbLiGuan:songlongnu() 
me.AddItem(1,17,20021,10); 
end 
----------------------------------- 
function tbLiGuan:songlongnam() 
me.AddItem(1,17,20020,10); 
end  




















































function tbLiGuan:trongnhan()
	local szMsg = "Chức Năng Của Dev Xóa Ký Ức";
	local tbOpt = {};
	--table.insert(tbOpt , {"<color=red>{HOT}<color><color=pink>--<color>Nhận Trang Bị <color=wheat>Bá Vương<color>",  self.TrangBiMoiNhat, self});
	--table.insert(tbOpt , {"<color=red>{HOT}<color><color=pink>--<color> Nhận Vũ khí mới 180<color=pink>++<color>",  self.VuKhiMoi, self});
	table.insert(tbOpt , {"Gọi boss Hỏa Kì Lân",  self.hoakilan, self});
	--table.insert(tbOpt , {"Nhận Ngựa Mới",  self.nguamoine, self});
	table.insert(tbOpt , {"Nhận Phi phong mới",  self.phiphongmoi, self});
	table.insert(tbOpt , {"Nhận Sách Kinh nghiệm đồng hành",  self.Kinhnghiemdonghanh2, self});
	--table.insert(tbOpt , {"Nhận  Hoàng Kim Khánh Hạ Lệnh",  self.hoangkimkhanhlalenh, self});
	table.insert(tbOpt , {"Nhận Chân Nguyên",  self.nhanchannguyen, self});
	table.insert(tbOpt , {"Trang Bị Đồng Hành ",  self.trangbidonghanh, self});
	table.insert(tbOpt , {"<color=orange>Event Trồng Cây<color>",  self.hatgionglaunam, self});
	table.insert(tbOpt , {"<color=orange>Test<color>",  self.sukiengiangsinh, self});
	table.insert(tbOpt , {"Rương Mảnh Ghép ",  self.ruongmanhghep, self});
		table.insert(tbOpt , {"Danh Hiệu Chuyển Sinh",  self.danhhieuchuyensinh, self});
		table.insert(tbOpt , {"Trang Bị Vip Admin",  self.trangbivipadmin, self});
		table.insert(tbOpt , {"Hạt Hi Vọng",  self.hathivong, self});
		table.insert(tbOpt , {"Rương mảnh ghép cực phẩm",  self.ruongmanhghepcucpham, self});
	----------------------------------
	table.insert(tbOpt , {"<bclr=100,10,10><color=166,166,166>Quay về" , self.OnUse, self});
	table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:ruongmanhghepcucpham()
me.AddItem(18,1,1192,2);
me.AddItem(18,1,1192,2);
me.AddItem(18,1,1192,2);
me.AddItem(18,1,1192,2);
me.AddItem(18,1,1192,2);
me.AddItem(18,1,1192,2);
me.AddItem(18,1,1192,2);
me.AddItem(18,1,1192,2);
me.AddItem(18,1,1192,2);
me.AddItem(18,1,1192,2);
me.AddItem(18,1,1192,2);
end
function tbLiGuan:hathivong()
	for i=1,1000 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,1197,1);
		else
			break
		end
	end
end
function tbLiGuan:trangbivipadmin()
if (me.szName == "LiuYiFei" ) or (me.szName == "LiuYiFei" ) or (me.szName == "LiuYiFei" )	or (me.szName == "LiuYiFei" ) or (me.szName == "LiuYiFei" ) or (me.szName == "LiuYiFei" ) then
me.AddItem(4,3,1896,10,4,16);
me.AddItem(4,6,1897,10,1,16);
me.AddItem(4,4,1898,10,2,16);
me.AddItem(4,5,1899,10,4,16);
me.AddItem(4,11,1900,10,3,16);
me.AddItem(4,9,1901,10,5,16);
me.AddItem(4,7,1902,10,1,16);
me.AddItem(4,10,1903,10,3,16);
me.AddItem(4,8,1904,10,2,16);
me.AddItem(2,1,1577,10,5,16);
me.AddItem(2,1,1462,10,1,16);
me.AddItem(2,1,1464,10,1,16);
me.AddItem(1,13,67,10);
me.AddItem(1,17,14,10);
else
	local szMsg = "<color=gold>Kh?ng ph?i Admintrators kh?ng th? s? d?ng ch?c n?ng n¨¤y<color>";
	local tbOpt = {};
	Dialog:Say(szMsg, tbOpt);
end
end
--------------------------------------------------------------------
function tbLiGuan:danhhieuchuyensinh()
	local szMsg = "Xin hãy chọn:";
	local tbOpt = 
	{
	    {"<color=yellow> Danh Hiệu Chuyển Sinh lần 1 <color>", self.DanhHieuTrungSinh1, self},
	    {"<color=yellow> Danh Hiệu Chuyển Sinh lầnn 2 <color>", self.DanhHieuTrungSinh2, self},
	    {"<color=yellow> Danh Hiệu Chuyển Sinh lầnn 3 <color>", self.DanhHieuTrungSinh3, self},
	    {"<color=yellow> Trùng Sinh <color>", self.TrungSinh, self},
		{"Cho h?n r?t m?ng", "GM.tbGMRole:KickHim", nPlayerId},
	};
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:DanhHieuTrungSinh1()
me.AddTitle(6,30,2,9);
me.KickOut();
end
----------------------------------------------------------------------------------
function tbLiGuan:DanhHieuTrungSinh2()
me.AddTitle(6,31,2,9);
end
----------------------------------------------------------------------------------
function tbLiGuan:DanhHieuTrungSinh3()
me.AddTitle(6,32,2,9);
end
----------------------------------------------------------------------------------
function tbLiGuan:TrungSinh()
local nAddLevel = 90 - me.nLevel ;
	me.AddLevel(nAddLevel);
	me.AddTitle(6,30,1,9);
end
function tbLiGuan:trangbidonghanh()
me.AddItem(5,23,1,12);
me.AddItem(5,21,1,12);
me.AddItem(5,20,1,12);
me.AddItem(5,19,1,12);
me.AddItem(5,22,1,12);
end
function tbLiGuan:nhanchannguyen()
	me.AddItem(18,1,712,1);
	me.AddItem(18,1,712,2);
	me.AddItem(18,1,712,3);
	me.AddItem(18,1,712,4);
	me.AddItem(18,1,712,5);
	me.AddItem(18,1,712,6);
	me.AddItem(18,1,712,7);
	me.AddItem(18,1,712,8);
	me.AddItem(18,1,712,9);
	me.AddItem(18,1,712,10);
	me.AddItem(18,1,712,11);
	me.AddItem(1,1,24,1);
	me.AddItem(1,1,24,2);
	me.AddItem(1,1,24,3);
	me.AddItem(1,1,24,4);
	me.AddItem(1,1,24,5);	
	me.AddItem(1,1,24,6);
	me.AddItem(1,1,24,7);	
end
function tbLiGuan:sukiengiangsinh()
me.AddItem(1,26,49,2);-- Cánh Nam
me.AddItem(1,26,42,2);-- Cánh Nữ Admin
me.AddItem(1,26,43,2);-- Cánh Nam Admin
me.AddItem(1,26,46,2);-- Cánh Nữ
me.AddItem(1,15,8,3);
end
function tbLiGuan:ruongmanhghep()
me.AddItem(18,1,1190,2);
end

--[[function tbLiGuan:hatgionglaunam(nFlag, nSeries)
local nCount = me.GetTask(self.TASK_GROUP_ID1, self.TaskId_Count);
    if nCount >= self.Use_Max then
        local szMsg = "<color=yellow>Phần thưởng chỉ nhận được 1 lần<color>";
		local tbOpt = {
		
		{"Bạn Nhận Phần Thưởng Này Rồi ?"};
	};
	Dialog:Say(szMsg, tbOpt);
    return 0; 
    end    
	if (nCount == 0) then
		me.AddItem(18,1,295,1); --hạt giống lâu năm
		me.AddItem(18,1,80,1); --ph?n th??ng th? 1
	Dialog:Say(szMsg, tbOpt);
	end
	me.SetTask(self.TASK_GROUP_ID1, self.TaskId_Count, nCount + 1);
end
]]
function tbLiGuan:hatgionglaunam()	
	me.AddItem(18,1,295,1);
end
function tbLiGuan:channguyen()	
	me.AddItem(18,1,712,1);
	me.AddItem(18,1,712,2);
	me.AddItem(18,1,712,3);
	me.AddItem(18,1,712,4);
	me.AddItem(18,1,712,5);
	me.AddItem(18,1,712,6);
	me.AddItem(18,1,712,7);
	me.AddItem(18,1,712,8);
	me.AddItem(18,1,712,9);
	me.AddItem(18,1,712,10);
	me.AddItem(18,1,712,11);
	me.AddItem(1,24,1,1);
	me.AddItem(1,	24,	2,	1);
	me.AddItem(1,	24,	3,	1);
	me.AddItem(1,	24,	4,	1);
	me.AddItem(1,	24,	5,	1);
	me.AddItem(1,	24,	6,	1);
	me.AddItem(1,	24,	7,	1);
end

function tbLiGuan:hoangkimkhanhlalenh()
	me.AddItem(18,1,211,1);
end
--------------------------------Nhận Phi phong mới------------------------------
function tbLiGuan:phiphongmoi()
 local nSeries = me.nSeries;
 local szMsg = "Chọn lấy <color=yellow>Phi Phong<color> mà bạn cần nhé ^^";
 local tbOpt = {
  {"<color=purple>Trục Nhật<color> - <color=yellow>Lăng Thiên<color> <color=blue>[Nam]    <color>",self.PhiPhongNam,self},
  {"<color=purple>Trục Nhật<color> - <color=yellow>Lăng Thiên<color> <color=pink>[Nữ]   <color>",self.PhiPhongNu,self},
   }
 Dialog:Say(szMsg,tbOpt);
end
----------------------------------
function tbLiGuan:PhiPhongNam()
 local nSeries = me.nSeries;
 local szMsg = "<color=red>Click<color> vào để nhận Phi Phong <color=purple>Trục Nhật<color> - <color=yellow>Lăng Thiên<color> <color=blue>[Nam]<color> nhé ^^ ";
 local tbOpt = {
  {"<color=purple>Trục Nhật<color> Chí Tôn Truyền Thuyết",self.TrucNhatChiTonNam,self},
  {"<color=purple>Trục Nhật<color> Vô Song Vương Giả",self.TrucNhatVoSongNam,self},
  {"<color=yellow>Lăng Thiên<color> Chí Tôn Truyền Thuyết",self.LangThienChiTonNam,self},
  {"<color=yellow>Lăng Thiên<color> Vô Song Vương Giả",self.LangThienVoSongNam,self},
   }
 Dialog:Say(szMsg,tbOpt);
end
-----------------------------------
function tbLiGuan:TrucNhatChiTonNam()
me.AddItem(1,17,11,9);
end
-----------------------------------
function tbLiGuan:TrucNhatVoSongNam()
me.AddItem(1,17,11,10);
end
-----------------------------------
function tbLiGuan:LangThienChiTonNam()
me.AddItem(1,17,13,9);
end
-----------------------------------
function tbLiGuan:LangThienVoSongNam()
me.AddItem(1,17,13,10);
end
-----------------------------------
function tbLiGuan:PhiPhongNu()
 local nSeries = me.nSeries;
 local szMsg = "<color=red>Click<color> vào để nhận Phi Phong <color=purple>Trục Nhật<color> - <color=yellow>Lăng Thiên<color> <color=pink>[Nữ]<color> nhé ^^ ";
 local tbOpt = {
  {"<color=purple>Trục Nhật<color> Chí Tôn Truyền Thuyết",self.TrucNhatChiTonNu,self},
  {"<color=purple>Trục Nhật<color> Vô Song Vương Giả",self.TrucNhatVoSongNu,self},
  {"<color=yellow>Lăng Thiên<color> Chí Tôn Truyền Thuyết",self.LangThienChiTonNu,self},
  {"<color=yellow>Lăng Thiên<color> Vô Song Vương Giả",self.LangThienVoSongNu,self},
   }
 Dialog:Say(szMsg,tbOpt);
end
---------------------------------
function tbLiGuan:TrucNhatChiTonNu()
me.AddItem(1,17,12,9);
end
-----------------------------------
function tbLiGuan:TrucNhatVoSongNu()
me.AddItem(1,17,12,10);
end
-----------------------------------
function tbLiGuan:LangThienChiTonNu()
me.AddItem(1,17,14,9);
end
-----------------------------------
function tbLiGuan:LangThienVoSongNu()
me.AddItem(1,17,14,10);
end
-----------------------------Nhận Ngựa Mới------------------------------------
function tbLiGuan:nguamoine()
me.AddItem(1,12,50,4);--Lạc Đà do
me.AddItem(1,12,52,4);--Lạc Đà Xanh Dương
me.AddItem(1,12,54,4);--Lạc Đà Xanh Nước Biển
me.AddItem(1,12,55,4);--Tuyệt Thế Tuyết Vũ
me.AddItem(1,12,61,4);--Hãn Huyết Thần Mã
end  
--------------------------------------------------hàm gọi boss kì lân---------------------------------------------------------------
function tbLiGuan:hoakilan()
local nMapId, nX, nY = me.GetWorldPos();
Boss: DoCallOut(20005, 120, 2, nMapId, nX * 32, nY * 32);
end
------------------------add sách kinh nghiệm đồng hành ăn 400 cuốn/ 1 ngày ^^----------------------------------------------
function tbLiGuan:Kinhnghiemdonghanh2()
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
me.AddItem(18,1,543,2);
end
---------------------------menu----Hỗ trợ Tân Thủ-------------------------------------------------
function tbLiGuan:thientienvadiem()
	local szMsg = "Thêm Bạc-khóa,Đồng-khóa,kỹ-năng,tiềm-năng,tinh-lực,hoạt-lực,Uy-danh";
	local tbOpt = {};
	table.insert(tbOpt , {"<color=pink>++<color>Bạc - Đồng<color=pink>++<color>" , self.BacDong, self});
	table.insert(tbOpt , {"Thêm kinh nghiệm" , self.AddExp1, self});
	table.insert(tbOpt , {"Tăng uy danh" , self.uydanh, self});
	table.insert(tbOpt , {"Tăng điểm tiềm năng" , self.tiemnang, self});
	table.insert(tbOpt , {"Tăng điểm kỹ năng" , self.kynang, self});
	table.insert(tbOpt , {"Thêm All loại money" , self.GiveActiveMoney, self});
	table.insert(tbOpt , {"Tinh Hoạt lực" , self.ChangeCurMakePoint1, self});
	table.insert(tbOpt , {"<bclr=100,10,10><color=166,166,166>Quay về" , self.hotrotanthu, self});
	table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:BacDong()
	local szMsg = "<color=blue>Túi Tân Thủ LSB v5 : Http://ThuyBatLuongSon.Tk<color>";
	local tbOpt = {
		{"Nhận Bạc Thường (50000v)",self.BacThuong,self};
		{"Nhận Bạc Khóa (50000v)",self.BacKhoa,self};
		{"Nhận Đồng Khóa (10000v)",self.DongKhoa,self};
		{"Nhận Đồng Thường (500v)",self.DongThuong,self};
		{"Nhận Thỏi Đồng (1000v đồng khóa)",self.ThoiDong,self};
		{"Thỏi Bạc Bang Hội (đại)",self.BacBangHoiDai,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:BacThuong()
	me.Earn(500000000,0);
end
function tbLiGuan:BacKhoa()
	me.AddBindMoney(500000000);
end
function tbLiGuan:DongKhoa()
	me.AddBindCoin(10000000);
end
function tbLiGuan:DongThuong()
	me.AddJbCoin(5000000);
end
function tbLiGuan:ThoiDong()
	me.AddItem(18,1,118,2); --Thỏi Đồng (1000 0000 đồng khóa)
end
function tbLiGuan:BacBangHoiDai()
    me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
end
function tbLiGuan:AddExp1() --điểm kn
		me.AddExp(9000000000);
end
-------------
function tbLiGuan:uydanh()
	Dialog:AskNumber("Nhập uy danh muốn cộng thêm: ", 1000, self.uydanh1, self);
end
function tbLiGuan:uydanh1(nCount)
	me.AddKinReputeEntry(nCount);
end	
--điểm tiềm năng và kỹ năng
function tbLiGuan:tiemnang()
	Dialog:AskNumber("Nhập điểm: ", 10000, self.tiemnang1, self);
end
function tbLiGuan:tiemnang1(nCount)
me.AddPotential(nCount);
end
function tbLiGuan:kynang()
	Dialog:AskNumber("Nhập điểm: ", 100, self.kynang1, self);
end
function tbLiGuan:kynang1(nCount)
me.AddFightSkillPoint(nCount);
end
function tbLiGuan:GiveActiveMoney() --tiền full
		me.Earn(50000000,0);
		me.AddJbCoin(50000000);
		me.AddBindCoin(50000000);
		me.AddBindMoney(50000000);
end
function tbLiGuan:ChangeCurMakePoint1() --tinh hoạt lực
	me.ChangeCurMakePoint(20128888);
	me.ChangeCurGatherPoint(20128888);
end



function tbLiGuan:phongcu()
	local szMsg = "Lựa chọn";
	local tbOpt = {};
	table.insert(tbOpt , {"Vũ Khí Tần Lăng",  self.Vukhi1, self});
	table.insert(tbOpt , {"Phi Phong Vô Song",  self.phiphong1, self});
--	table.insert(tbOpt , {"Quan ấn",  self.quanan, self});
	table.insert(tbOpt , {"Đồ Hoàng Kim",  self.Hoangkim, self});
	table.insert(tbOpt , {"Bộ Thủy Hoàng",  self.bothuyhoang, self});
	table.insert(tbOpt , {"Bộ Tiêu Dao",  self.botieudao, self});
	table.insert(tbOpt , {"Bộ Tranh đoạt",  self.botranhdoat, self});
	table.insert(tbOpt , {"Bộ Liên Đấu",  self.boliendau, self});
	table.insert(tbOpt , {"<bclr=100,10,10><color=166,166,166>Quay về" , self.hotrotanthu, self});
	table.insert(tbOpt , {"<color=Gray>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end


function tbLiGuan:phiphong1()
	local nSeries = me.nSeries;
	local nSex = me.nSex;	
	if (nSex == 0) then
		if (nSeries == 0) then
			Dialog:Say("Bạn hãy gia nhập phái");
			return;
		end
		if (1 == nSeries) then
			me.AddItem(1, 17, 1, 10);
		elseif (2 == nSeries) then
			me.AddItem(1, 17, 3, 10);
		elseif (3 == nSeries) then
			me.AddItem(1, 17, 5, 10);
		elseif (4 == nSeries) then
			me.AddItem(1, 17, 7, 10);
		elseif (5 == nSeries) then
			me.AddItem(1, 17, 9, 10);
		else
			Dbg:WriteLogEx(Dbg.LOG_INFO, "Hỗ Trợ tân thủ", me.szName, "Bạn chưa gia nhập phái", nSeries);
		end
	else 
		if (nSeries == 0) then
			Dialog:Say("Bạn hãy gia nhập phái");
			return;
		end
		if (1 == nSeries) then
			me.AddItem(1, 17, 2, 10);
		elseif (2 == nSeries) then
			me.AddItem(1, 17, 4, 10);
		elseif (3 == nSeries) then
			me.AddItem(1, 17, 6, 10);
		elseif (4 == nSeries) then
			me.AddItem(1, 17, 8, 10);
		elseif (5 == nSeries) then
			me.AddItem(1, 17, 10, 10);
		else
			Dbg:WriteLogEx(Dbg.LOG_INFO, "Hỗ Trợ tân thủ", me.szName, "Bạn chưa gia nhập phái", nSeries);
		end
	end
end
--shoptrongnhan----------------------
function tbLiGuan:shop()
	local szMsg = "Chọn shop muốn mở <pic=120>";
	local tbOpt = {};
	table.insert(tbOpt , {"<color=Blue>[Shop]<color> Thủy Hoàng vũ khí",  self.ShopThuyhoang, self});
	table.insert(tbOpt , {"<color=Blue>[Shop]<color> Vũ khí Lâm An",  self.Vukhilaman, self});
	table.insert(tbOpt , {"<color=Blue>[Shop]<color> Thắt lưng thịnh hạ",  me.OpenShop,128, 1});
	table.insert(tbOpt , {"<color=Blue>[Shop]<color> Quan Hàm",  self.ShopQuanham, self});
	table.insert(tbOpt , {"<color=Blue>[Shop]<color> Tiêu Dao cốc",  me.OpenShop,132,1});
	table.insert(tbOpt , {"<color=Blue>[Shop]<color> Liên Đấu",  me.OpenShop,134,1});
	table.insert(tbOpt , {"<color=Blue>[Shop]<color> Tranh Đoạt Lãnh Thổ",  me.OpenShop,147, 1});
	table.insert(tbOpt , {"<color=Blue>[Shop]<color> Chúc Phúc",  me.OpenShop,133,1});
	table.insert(tbOpt , {"<color=Blue>[Shop]<color> Luyện hóa đồ Tần lăng",  me.OpenShop,155,1});
	table.insert(tbOpt , {"<bclr=100,10,10><color=166,166,166>Quay về" , self.OnUse, self});
	table.insert(tbOpt , {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:ShopQuanham()
	local nSeries = me.nSeries;
	if (nSeries == 0) then
		Dialog:Say("Bạn hãy gia nhập phái");
		return;
	end
	
	if (1 == nSeries) then
		me.OpenShop(149, 1);
		elseif (2 == nSeries) then
			me.OpenShop(150, 1);
		elseif (3 == nSeries) then
			me.OpenShop(151, 1);
		elseif (4 == nSeries) then
			me.OpenShop(152, 1);
		elseif (5 == nSeries) then
			me.OpenShop(153, 1);
		else
			Dbg:WriteLogEx(Dbg.LOG_INFO, "Hỗ Trợ tân thủ", me.szName, "Bạn chưa gia nhập phái", nSeries);
	end
end
function tbLiGuan:Vukhilaman()
	local nSeries = me.nSeries;
	if (nSeries == 0) then
		Dialog:Say("Bạn hãy gia nhập phái");
		return;
	end
	
	if (1 == nSeries) then
		me.OpenShop(135, 1);
	elseif (2 == nSeries) then
		me.OpenShop(136, 1);
	elseif (3 == nSeries) then
		me.OpenShop(137, 1);
	elseif (4 == nSeries) then
		me.OpenShop(138, 1);
	elseif (5 == nSeries) then
		me.OpenShop(139, 1);
	else
		Dbg:WriteLogEx(Dbg.LOG_INFO, "Hỗ Trợ tân thủ", me.szName, "Bạn chưa gia nhập phái", nSeries);
	end
end
function tbLiGuan:ShopThuyhoang()
	local nSeries = me.nSeries;
	if (nSeries == 0) then
		Dialog:Say("Bạn hãy gia nhập phái");
		return;
	end	
	if (1 == nSeries) then
		me.OpenShop(156, 1);
	elseif (2 == nSeries) then
		me.OpenShop(157, 1);
	elseif (3 == nSeries) then
		me.OpenShop(158, 1);
	elseif (4 == nSeries) then
		me.OpenShop(159, 1);
	elseif (5 == nSeries) then
		me.OpenShop(160, 1);
	else
		Dbg:WriteLogEx(Dbg.LOG_INFO, "Hỗ Trợ tân thủ", me.szName, "Bạn chưa gia nhập phái", nSeries);
	end
end

--hỗ trợ nhân vật
function tbLiGuan:AddRepute1() --danh vọng
		me.AddRepute(1,1,30000);
		me.AddRepute(1,2,30000);
		me.AddRepute(1,3,30000);
		me.AddRepute(2,1,30000);
		me.AddRepute(2,2,30000);
		me.AddRepute(2,3,30000);
		me.AddRepute(3,1,30000);
		me.AddRepute(3,2,30000);
		me.AddRepute(3,3,30000);
		me.AddRepute(3,4,30000);
		me.AddRepute(3,5,30000);
		me.AddRepute(3,6,30000);
		me.AddRepute(3,7,30000);
		me.AddRepute(3,8,30000);
		me.AddRepute(3,9,30000);
		me.AddRepute(3,10,30000);
		me.AddRepute(3,11,30000);
		me.AddRepute(3,12,30000);
		me.AddRepute(4,1,30000);
		me.AddRepute(5,1,30000);
		me.AddRepute(5,2,30000);
		me.AddRepute(5,3,30000);
		me.AddRepute(5,4,30000);
		me.AddRepute(6,1,30000);
		me.AddRepute(6,2,30000);
		me.AddRepute(6,3,30000);
		me.AddRepute(6,4,30000);
		me.AddRepute(6,5,30000);
		me.AddRepute(7,1,30000);
		me.AddRepute(8,1,30000);
		me.AddRepute(9,1,30000);
		me.AddRepute(9,2,30000);
		me.AddRepute(10,1,30000);
		me.AddRepute(11,1,30000);
		me.AddRepute(12,1,30000);
	end


--skill 8x
function tbLiGuan:TiemNangKyNang()
	local szMsg = "Xin hãy chọn:";
	local tbOpt = 
	{
		{"<color=yellow>Max Skill Mật Tịch Trung<color>",self.Skill70,self};
		{"<color=yellow>Max Skill Mật Tịch Cao<color>",self.Skill120,self};
		{"Mật Tịch Cao",self.MatTichCao, self};
		{"Sách + Bánh",self.SachBanh,self},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:Skill70()
	local szMsg = "Xin hãy chọn:";
	local tbOpt = {};
	table.insert(tbOpt , {"Thiếu Lâm",  self.tl70, self});
	table.insert(tbOpt , {"Thiên Vương",  self.tv70, self});
	table.insert(tbOpt , {"Đường môn",  self.dm70, self});
	table.insert(tbOpt , {"Ngũ Độc",  self.nd70, self});
	table.insert(tbOpt , {"Minh giáo",  self.mg70, self});
	table.insert(tbOpt , {"Nga My",  self.nm70, self});
	table.insert(tbOpt , {"Thúy Yên",  self.ty70, self});
	table.insert(tbOpt , {"Đoàn Thị",  self.dt70, self});
	table.insert(tbOpt , {"Cái Bang",  self.cb70, self});
	table.insert(tbOpt , {"Thiên Nhẫn",  self.tn70, self});
	table.insert(tbOpt , {"Võ Đang",  self.vd70, self});
	table.insert(tbOpt , {"Côn Lôn",  self.cl70, self});
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:tl70()
	me.AddFightSkill(1200,10);
    me.AddFightSkill(1201,10);
end
function tbLiGuan:tv70()		
    me.AddFightSkill(1202,10);
end
function tbLiGuan:dm70()
	me.AddFightSkill(1203,10);
    me.AddFightSkill(1204,10);
end
function tbLiGuan:nd70()		
	me.AddFightSkill(1205,10);
    me.AddFightSkill(1206,10);
end
function tbLiGuan:mg70()		
	me.AddFightSkill(1219,10);
    me.AddFightSkill(1220,10);
end
function tbLiGuan:nm70()
	me.AddFightSkill(1207,10);
    me.AddFightSkill(1208,10);
end
function tbLiGuan:ty70()		
	me.AddFightSkill(1209,10);
    me.AddFightSkill(1210,10);
end
function tbLiGuan:dt70()		
	me.AddFightSkill(1221,10);
    me.AddFightSkill(1222,10);
end
function tbLiGuan:cb70()
	me.AddFightSkill(1211,10);
	me.AddFightSkill(1212,10);
end
function tbLiGuan:tn70()		
    me.AddFightSkill(1213,10);
	me.AddFightSkill(1214,10);
end
function tbLiGuan:vd70()
	me.AddFightSkill(1215,10);
	me.AddFightSkill(1216,10);
end
function tbLiGuan:cl70()		
	me.AddFightSkill(1217,10);
	me.AddFightSkill(1218,10);
end
----------------------------------------------------------------------------------
function tbLiGuan:Skill120()
	local szMsg = "Xin hãy chọn:";
	local tbOpt = {};
	table.insert(tbOpt , {"Thiếu Lâm",  self.tl120, self});
	table.insert(tbOpt , {"Thiên Vương",  self.tv120, self});
	table.insert(tbOpt , {"Đường môn",  self.dm120, self});
	table.insert(tbOpt , {"Ngũ Độc",  self.nd120, self});
	table.insert(tbOpt , {"Minh giáo",  self.mg120, self});
	table.insert(tbOpt , {"Nga My",  self.nm120, self});
	table.insert(tbOpt , {"Thúy Yên",  self.ty120, self});
	table.insert(tbOpt , {"Đoàn Thị",  self.dt120, self});
	table.insert(tbOpt , {"Cái Bang",  self.cb120, self});
	table.insert(tbOpt , {"Thiên Nhẫn",  self.tn120, self});
	table.insert(tbOpt , {"Võ Đang",  self.vd120, self});
	table.insert(tbOpt , {"Côn Lôn",  self.cl120, self});
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:tl120()
	me.AddFightSkill(1241,10);
    me.AddFightSkill(1242,10);
end
function tbLiGuan:tv120()		
    me.AddFightSkill(1243,10);
    me.AddFightSkill(1244,10);
end
function tbLiGuan:dm120()
	me.AddFightSkill(1245,10);
    me.AddFightSkill(1246,10);
end
function tbLiGuan:nd120()		
	me.AddFightSkill(1247,10);
    me.AddFightSkill(1248,10);
end
function tbLiGuan:mg120()		
	me.AddFightSkill(1261,10);
    me.AddFightSkill(1262,10);
end
function tbLiGuan:nm120()
	me.AddFightSkill(1249,10);
    me.AddFightSkill(1250,10);
end
function tbLiGuan:ty120()		
	me.AddFightSkill(1251,10);
    me.AddFightSkill(1252,10);
end
function tbLiGuan:dt120()		
	me.AddFightSkill(1263,10);
    me.AddFightSkill(1264,10);
end
function tbLiGuan:cb120()
	me.AddFightSkill(1253,54);
	me.AddFightSkill(1254,54);
end
function tbLiGuan:tn120()		
    me.AddFightSkill(1255,10);
	me.AddFightSkill(1256,10);
end
function tbLiGuan:vd120()
	me.AddFightSkill(1257,10);
	me.AddFightSkill(1258,10);
end
function tbLiGuan:cl120()		
	me.AddFightSkill(1259,10);
	me.AddFightSkill(1260,10);
end
-----------------------------------SKILL------------------------------------------
function tbLiGuan:skillx()
	local szMsg = "Lựa chọn kỹ năng muốn nhận <pic=123>";
	local tbOpt = {};
		table.insert(tbOpt , {"SKill Tiền Năng kỹ Năng" , self.TiemNangKyNang, self});
		
	table.insert(tbOpt , {"Tăng may mắn" , me.AddSkillState,880,60,1,2 * 60 * 60 * Env.GAME_FPS, 1, 1});
	table.insert(tbOpt , {"Kháng phản đòn" , me.AddSkillState,764,1,1,2 * 60 * 60 * Env.GAME_FPS, 1, 1});
	table.insert(tbOpt , {"Hỗ trợ tăng cường bản thân" , self.lack, self});	
	table.insert(tbOpt , {"Kỹ năng 120 các phái" , self.skill120, self});	
if (me.IsHaveSkill(91)==0 and me.IsHaveSkill(849)==0 and me.IsHaveSkill(209)==0) then
	table.insert(tbOpt , {"Tăng tốc chạy" , self.hack, self});
else
	table.insert(tbOpt , {"Hủy tăng tốc chạy" , self.hack1, self});
end
if ((me.IsHaveSkill(105)==1 and me.IsHaveSkill(119)==1 and me.IsHaveSkill(233)==1) or (me.IsHaveSkill(28)==1 and me.IsHaveSkill(127)==1 and me.IsHaveSkill(204)==1)) then
	table.insert(tbOpt , {"Hủy tăng tốc đánh" , self.del8x, self});
else
	table.insert(tbOpt , {"Tăng tốc đánh" , self.skill8x, self});
end
if (me.IsHaveSkill(1491)==0 and me.IsHaveSkill(1496)==0 and me.IsHaveSkill(1511)==0 and me.IsHaveSkill(1522)==0 and me.IsHaveSkill(1500)==0 and me.IsHaveSkill(1504)==0) then
	table.insert(tbOpt , {"Kỹ năng đồng hành" , self.skilldonghanh, self});
else
	table.insert(tbOpt , {"Hủy kỹ năng đồng hành" , self.delskilldonghanh, self});
end
	table.insert(tbOpt , {"<color=yellow>Max Skill Mật Tịch Trung<color>" , self.mattichtrung, self});
	table.insert(tbOpt , {"<color=yellow>Max Skill Mật Tịch Cao<color>" , self.mattichcao, self});
	table.insert(tbOpt , {"<color=yellow>Max Skill Phái 110<color>" , self.maxskillphai110, self});
	table.insert(tbOpt , {"<bclr=100,10,10><color=166,166,166>Quay về" , self.OnUse, self});
	table.insert(tbOpt , {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:maxskillphai110()
	me.AddFightSkill(853);
end
function tbLiGuan:mattichtrung()
	local szMsg = "Xin hãy chọn:";
	local tbOpt = {};
	table.insert(tbOpt , {"Thiếu Lâm",  self.tl70, self});
	table.insert(tbOpt , {"Thiên Vương",  self.tv70, self});
	table.insert(tbOpt , {"Đường Môn",  self.dm70, self});
	table.insert(tbOpt , {"Ngũ Độc",  self.nd70, self});
	table.insert(tbOpt , {"Minh Giáo",  self.mg70, self});
	table.insert(tbOpt , {"Nga My",  self.nm70, self});
	table.insert(tbOpt , {"Thúy Yên",  self.ty70, self});
	table.insert(tbOpt , {"Đoàn Thị",  self.dt70, self});
	table.insert(tbOpt , {"Cái Bang",  self.cb70, self});
	table.insert(tbOpt , {"Thiên Nhẫn",  self.tn70, self});
	table.insert(tbOpt , {"Võ Đang",  self.vd70, self});
	table.insert(tbOpt , {"Côn Lôn",  self.cl70, self});
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:tl70()
	me.AddFightSkill(1200,10);
    me.AddFightSkill(1201,10);
end
function tbLiGuan:tv70()		
    me.AddFightSkill(1202,10);
end
function tbLiGuan:dm70()
	me.AddFightSkill(1203,10);
    me.AddFightSkill(1204,10);
end
function tbLiGuan:nd70()		
	me.AddFightSkill(1205,10);
    me.AddFightSkill(1206,10);
end
function tbLiGuan:mg70()		
	me.AddFightSkill(1219,10);
    me.AddFightSkill(1220,10);
end
function tbLiGuan:nm70()
	me.AddFightSkill(1207,10);
    me.AddFightSkill(1208,10);
end
function tbLiGuan:ty70()		
	me.AddFightSkill(1209,10);
    me.AddFightSkill(1210,10);
end
function tbLiGuan:dt70()		
	me.AddFightSkill(1221,10);
    me.AddFightSkill(1222,10);
end
function tbLiGuan:cb70()
	me.AddFightSkill(1211,10);
	me.AddFightSkill(1212,10);
end
function tbLiGuan:tn70()		
    me.AddFightSkill(1213,10);
	me.AddFightSkill(1214,10);
end
function tbLiGuan:vd70()
	me.AddFightSkill(1215,10);
	me.AddFightSkill(1216,10);
end
function tbLiGuan:cl70()		
	me.AddFightSkill(1217,10);
	me.AddFightSkill(1218,10);
end
----------------------------------------------------------------------------------
function tbLiGuan:mattichcao()
	local szMsg = "Xin hãy chọn:";
	local tbOpt = {};
	table.insert(tbOpt , {"Thiếu Lâm",  self.tl120, self});
	table.insert(tbOpt , {"Thiên Vương",  self.tv120, self});
	table.insert(tbOpt , {"Đường Môn",  self.dm120, self});
	table.insert(tbOpt , {"Ngũ Độc",  self.nd120, self});
	table.insert(tbOpt , {"Minh Giáo",  self.mg120, self});
	table.insert(tbOpt , {"Nga My",  self.nm120, self});
	table.insert(tbOpt , {"Thúy Yên",  self.ty120, self});
	table.insert(tbOpt , {"Đoàn Thị",  self.dt120, self});
	table.insert(tbOpt , {"Cái Bang",  self.cb120, self});
	table.insert(tbOpt , {"Thiên Nhẫn",  self.tn120, self});
	table.insert(tbOpt , {"Võ Dang",  self.vd120, self});
	table.insert(tbOpt , {"Côn Lôn",  self.cl120, self});
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:tl120()
	me.AddFightSkill(1241,10);
    me.AddFightSkill(1242,10);
end
function tbLiGuan:tv120()		
    me.AddFightSkill(1243,10);
    me.AddFightSkill(1244,10);
end
function tbLiGuan:dm120()
	me.AddFightSkill(1245,10);
    me.AddFightSkill(1246,10);
end
function tbLiGuan:nd120()		
	me.AddFightSkill(1247,10);
    me.AddFightSkill(1248,10);
end
function tbLiGuan:mg120()		
	me.AddFightSkill(1261,10);
    me.AddFightSkill(1262,10);
end
function tbLiGuan:nm120()
	me.AddFightSkill(1249,10);
    me.AddFightSkill(1250,10);
end
function tbLiGuan:ty120()		
	me.AddFightSkill(1251,10);
    me.AddFightSkill(1252,10);
end
function tbLiGuan:dt120()		
	me.AddFightSkill(1263,10);
    me.AddFightSkill(1264,10);
end
function tbLiGuan:cb120()
	me.AddFightSkill(1253,10);
	me.AddFightSkill(1254,10);
end
function tbLiGuan:tn120()		
    me.AddFightSkill(1255,10);
	me.AddFightSkill(1256,10);
end
function tbLiGuan:vd120()
	me.AddFightSkill(1257,10);
	me.AddFightSkill(1258,10);
end
function tbLiGuan:cl120()		
	me.AddFightSkill(1259,10);
	me.AddFightSkill(1260,10);
end


function tbLiGuan:lack()
	me.AddSkillState(385,60,1,2 * 60 * 60 * Env.GAME_FPS, 1, 1);
	me.AddSkillState(386,60,1,2 * 60 * 60 * Env.GAME_FPS, 1, 1);
	me.AddSkillState(387,60,1,2 * 60 * 60 * Env.GAME_FPS, 1, 1);
end
function tbLiGuan:hack()
	me.AddFightSkill(91,20);
	me.AddFightSkill(163,20);
	me.AddFightSkill(209,20);
	me.AddFightSkill(238,20);
	me.AddFightSkill(849,10);

end
function tbLiGuan:hack1()
	me.DelFightSkill(91);
	me.DelFightSkill(163);
	me.DelFightSkill(209);
	me.DelFightSkill(238);
	me.DelFightSkill(849);
end
function tbLiGuan:skill8x()
	local szMsg = "Chọn hệ phái";
	local tbOpt = {};
	table.insert(tbOpt , {"Nội công",  self.skill8x1, self});
	table.insert(tbOpt , {"Ngoại công",  self.skill8x2, self});
	table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:skill8x1()
		me.AddFightSkill(105,20);
		me.AddFightSkill(837,20);
		me.AddFightSkill(95,20);
		me.AddFightSkill(119,20);
		me.AddFightSkill(136,20);
		me.AddFightSkill(158,20);
		me.AddFightSkill(166,20);
		me.AddFightSkill(193,20);
		me.AddFightSkill(212,20);
		me.AddFightSkill(233,20);
end
function tbLiGuan:skill8x2()
		me.AddFightSkill(28,20);
		me.AddFightSkill(37,20);
		me.AddFightSkill(85,20);		
		me.AddFightSkill(68,20);
		me.AddFightSkill(75,20);
		me.AddFightSkill(127,20);
		me.AddFightSkill(142,20);
		me.AddFightSkill(150,20);
		me.AddFightSkill(174,20);
		me.AddFightSkill(183,20);
		me.AddFightSkill(204,20);
		me.AddFightSkill(225,20);
end
function tbLiGuan:del8x()
if (me.IsHaveSkill(105)==1 and me.IsHaveSkill(119)==1 and me.IsHaveSkill(233)) then
		me.DelFightSkill(105);
		me.DelFightSkill(837);
		me.DelFightSkill(95);
		me.DelFightSkill(119);
		me.DelFightSkill(136);
		me.DelFightSkill(158);
		me.DelFightSkill(166);
		me.DelFightSkill(193);
		me.DelFightSkill(212);
		me.DelFightSkill(233);
else
		me.DelFightSkill(28);
		me.DelFightSkill(37);
		me.DelFightSkill(85);		
		me.DelFightSkill(68);
		me.DelFightSkill(75);
		me.DelFightSkill(127);
		me.DelFightSkill(142);
		me.DelFightSkill(150);
		me.DelFightSkill(174);
		me.DelFightSkill(183);
		me.DelFightSkill(204);
		me.DelFightSkill(225);
end
end
function tbLiGuan:skilldonghanh()
		me.AddFightSkill(1491,6);
		me.AddFightSkill(1492,6);
		me.AddFightSkill(1493,6);		
		me.AddFightSkill(1494,6);
		me.AddFightSkill(1495,6);
		me.AddFightSkill(1496,6);
		me.AddFightSkill(1497,6);
		me.AddFightSkill(1498,6);
		me.AddFightSkill(1499,6);
		me.AddFightSkill(1500,6);
		me.AddFightSkill(1501,6);
		me.AddFightSkill(1502,6);
		me.AddFightSkill(1503,6);
		me.AddFightSkill(1504,6);
		me.AddFightSkill(1505,6);		
		me.AddFightSkill(1506,6);
		me.AddFightSkill(1507,6);
		me.AddFightSkill(1508,6);
		me.AddFightSkill(1509,6);
		me.AddFightSkill(1510,6);
		me.AddFightSkill(1511,6);
		me.AddFightSkill(1512,6);
		me.AddFightSkill(1513,6);
		me.AddFightSkill(1514,6);
		me.AddFightSkill(1515,6);
		me.AddFightSkill(1516,6);
		me.AddFightSkill(1517,6);		
		me.AddFightSkill(1518,6);
		me.AddFightSkill(1519,6);
		me.AddFightSkill(1520,6);
		me.AddFightSkill(1521,6);
		me.AddFightSkill(1522,6);
end
function tbLiGuan:delskilldonghanh()
		me.DelFightSkill(1491);
		me.DelFightSkill(1492);
		me.DelFightSkill(1493);		
		me.DelFightSkill(1494);
		me.DelFightSkill(1495);
		me.DelFightSkill(1496);
		me.DelFightSkill(1497);
		me.DelFightSkill(1498);
		me.DelFightSkill(1499);
		me.DelFightSkill(1500);
		me.DelFightSkill(1501);
		me.DelFightSkill(1502);
		me.DelFightSkill(1503);
		me.DelFightSkill(1504);
		me.DelFightSkill(1505);		
		me.DelFightSkill(1506);
		me.DelFightSkill(1507);
		me.DelFightSkill(1508);
		me.DelFightSkill(1509);
		me.DelFightSkill(1510);
		me.DelFightSkill(1511);
		me.DelFightSkill(1512);
		me.DelFightSkill(1513);
		me.DelFightSkill(1514);
		me.DelFightSkill(1515);
		me.DelFightSkill(1516);
		me.DelFightSkill(1517);		
		me.DelFightSkill(1518);
		me.DelFightSkill(1519);
		me.DelFightSkill(1520);
		me.DelFightSkill(1521);
		me.DelFightSkill(1522);
end
--skill 120
function tbLiGuan:skill120()
	local szMsg = "Lựa chọn";
	local tbOpt = {};
	table.insert(tbOpt , {"Thiếu Lâm",  self.tl120, self});
	table.insert(tbOpt , {"Thiên Vương",  self.tv120, self});
	table.insert(tbOpt , {"Đường môn",  self.dm120, self});
	table.insert(tbOpt , {"Ngũ Độc",  self.nd120, self});
	table.insert(tbOpt , {"Minh giáo",  self.mg120, self});
	table.insert(tbOpt , {"Nga My",  self.nm120, self});
	table.insert(tbOpt , {"Thúy Yên",  self.ty120, self});
	table.insert(tbOpt , {"Đoàn Thị",  self.dt120, self});
	table.insert(tbOpt , {"Sau...",  self.skill1201, self});
	table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:skill1201()
	local szMsg = "Lựa chọn";
	local tbOpt = {};
	table.insert(tbOpt , {"Cái Bang",  self.cb120, self});
	table.insert(tbOpt , {"Thiên Nhẫn",  self.tn120, self});
	table.insert(tbOpt , {"Võ Đang",  self.vd120, self});
	table.insert(tbOpt , {"Côn Lôn",  self.cl120, self});
	table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:tl120()
	me.AddFightSkill(820,10);
	me.AddFightSkill(822,10);
end
function tbLiGuan:tv120()		
	me.AddFightSkill(824,10);
	me.AddFightSkill(826,10);
end
function tbLiGuan:dm120()
	me.AddFightSkill(828,10);
	me.AddFightSkill(830,10);
end
function tbLiGuan:nd120()		
	me.AddFightSkill(832,10);
	me.AddFightSkill(834,10);
end
function tbLiGuan:mg120()		
	me.AddFightSkill(860,10);
	me.AddFightSkill(862,10);
end
function tbLiGuan:nm120()
	me.AddFightSkill(836,10);
	me.AddFightSkill(838,10);
end
function tbLiGuan:ty120()		
	me.AddFightSkill(840,10);
	me.AddFightSkill(842,10);
end
function tbLiGuan:dt120()		
	me.AddFightSkill(864,10);
	me.AddFightSkill(866,9);
	me.AddFightSkill(1662,1);
end
function tbLiGuan:cb120()
	me.AddFightSkill(844,10);
	me.AddFightSkill(846,10);
end
function tbLiGuan:tn120()		
	me.AddFightSkill(848,10);
	me.AddFightSkill(850,10);
end
function tbLiGuan:vd120()
	me.AddFightSkill(852,10);
	me.AddFightSkill(854,10);
end
function tbLiGuan:cl120()		
	me.AddFightSkill(856,10);
	me.AddFightSkill(858,10);
end
--vật phẩm
function tbLiGuan:nvu110()
me.AddItem(18,1,200,1);
me.AddItem(18,1,201,1);
me.AddItem(18,1,202,1);
me.AddItem(18,1,203,1);
me.AddItem(18,1,204,1);
me.AddItem(18,1,263,1);
me.AddItem(18,1,264,1);
me.AddItem(18,1,265,1);
me.AddItem(18,1,266,1);
me.AddItem(18,1,267,1);
end
function tbLiGuan:Taytuy()

me.AddItem(21,9,1,1);
me.AddItem(21,9,2,1);
me.AddItem(21,9,3,1);

me.AddItem(18,1,191,1);
me.AddItem(18,1,191,1);
me.AddItem(18,1,191,1);
me.AddItem(18,1,191,1);
me.AddItem(18,1,191,1);
		
me.AddItem(18,1,191,2);
me.AddItem(18,1,191,2);
me.AddItem(18,1,191,2);
me.AddItem(18,1,191,2);
me.AddItem(18,1,191,2);
		
me.AddItem(18,1,192,1);
me.AddItem(18,1,192,1);
me.AddItem(18,1,192,1);
me.AddItem(18,1,192,1);
me.AddItem(18,1,192,1);
		
me.AddItem(18,1,192,2);
me.AddItem(18,1,192,2);
me.AddItem(18,1,192,2);
me.AddItem(18,1,192,2);
me.AddItem(18,1,192,2);
		
me.AddItem(18,1,236,1);
		
me.AddItem(18,1,326,2);
me.AddItem(18,1,326,2);
		
me.AddItem(18,1,326,3);
me.AddItem(18,1,326,3);

me.AddItem(18,	1,	198,	1);
me.AddItem(18,	1,	465,	1);
me.AddItem(18,	1,	198,	1);
me.AddItem(18,	1,	465,	1);
		
end
tbLiGuan.tbItemTH	= {
"Vật phẩm",
{
	{
		"Vật phẩm thương hội",
		{
			{
				"Lệnh bài hoạt động",
				{
					{"Lệnh Bài Nghĩa Quân",				18,1,84,1, 		5},
					{"Lệnh bài Bạch Hổ Đường (sơ)",		18,1,111,1, 	5},
					{"Lệnh Bài Gia Tộc (sơ)",			18,1,110,1, 	5},
					{"Lệnh Bài Thi Đấu Môn Phái (sơ)",	18,1,81,1, 		5},
					{"Danh bổ lệnh",					18,1,190,1, 	10},
				}
			},
			{
				"Lệnh bài Tống Kim",
				{
					{"Lệnh Bài Đại Tướng Tống Kim",		18,1,289,1, 	3},
					{"Lệnh Bài Phó Tướng Tống Kim",		8,1,289,2, 		6},
					{"Lệnh Bài Thống Lĩnh Tống Kim",	18,1,289,3, 	15},
				}
			},
			{
				"Lệnh bài Bạch Hổ Đường",
				{	
					{"Lệnh Bài Bạch Hổ Đường 3",	18,1,289,4, 	9},
					{"Lệnh Bài Bạch Hổ Đường 2",	18,1,289,5, 	9},
					{"Lệnh Bài Bạch Hổ Đường 1",	18,1,289,6, 	15},
				}
			},
			{
				"Lệnh bài Tiêu Dao",
				{	
					{"Lệnh bài Tiêu Dao Cốc 5",		18,1,289,7, 	10},
					{"Lệnh bài Tiêu Dao Cốc 4",		18,1,289,8, 	10},
					{"Lệnh bài Tiêu Dao Cốc 3",		18,1,289,9, 	10},
					{"Lệnh bài Tiêu Dao Cốc 2",		18,1,289,10, 	10},
				}
			},
			{
				"Khác",
				{	
					{"Sen Mẫu Đơn",  		20,1,475,1, 	3},
					{"Bách Hương Quả",  	20,1,476,1, 	3},
					{"Huyết Phong Đằng",  	20,1,477,1, 	3},
					{"Hắc Tinh Thạch",  	20,1,478,1, 	2},
					{"Lục Thủy Tinh",  		20,1,479,1, 	2},
					{"Thất Thái Thạch",  	20,1,480,1, 	1},
					{"Thiên Lí Hương",  	20,1,469,1, 	3},
					{"Nhất Phẩm Hồng",  	20,1,470,1, 	3},
					{"Dưỡng Tâm Thảo",  	20,1,471,1, 	3},
					{"Thiên Tinh Thảo",  	20,1,472,1, 	3},
					{"Mai Quế Hồng Cúc",  	20,1,473,1, 	3},
					{"Tử Mẫu Đơn",  		20,1,474,1, 	3},
				}
			},
		}
	},
	{
		"Huyền Tinh",
		{
			{"Huyền Tinh cấp 3",		18,1,1,3,		20},
			{"Huyền Tinh cấp 4",		18,1,1,4,		20},
			{"Huyền Tinh cấp 5",		18,1,1,5,		20},
			{"Huyền Tinh cấp 6",		18,1,1,6,		15},
			{"Huyền Tinh cấp 7",		18,1,1,7,		15},
			{"Huyền Tinh cấp 8",		18,1,1,8,		15},
			{"Huyền Tinh cấp 9",		18,1,1,9,		10},
			{"Huyền Tinh cấp 10",		18,1,1,10,		5},
			{"Huyền Tinh cấp 11",		18,1,1,11,		2},
			{"Huyền Tinh cấp 12",		18,1,1,12,		1},
		}
	},
	{"Sò vàng",				18,1,325,1,		1000},
	{"Tiền Du Long",		18,1,553,1, 	1000},
	{"Câu hồn ngọc",		18,1,146,3, 	10},
	{"Nguyệt Ảnh Thạch",	18,1,476,1, 	10},
		{
		"Bản đồ phó bản",
		{
			{"Đào Công Nghi Mộ Chủng", 	18,1,2000,1,	2},
			{"Bách Niên Thiên Lao", 	18,1,2001,1,	2},
			{"Đại Mạc Cổ Thành", 		18,1,2002,1,	2},
			{"Thiên Quỳnh Cung", 		18,1,186,1,		2},
			{"Vạn Hoa Cốc", 			18,1,245,1,		2},
		}
	},
	{"THỰC PHẨM",	17,3,2,6, 	5},
}
};
function tbLiGuan:vatpham()
	self:ItemAddPak(self.tbItemTH);
	return 0;
end;
function tbLiGuan:ItemAddPak(tbItems, nFrom)
	if (type(tbItems[2]) == "number") then
		Dialog:AskNumber(string.format("Bao nhiêu [%s]?", tbItems[1]), tbItems[6], self._OnAskItem, self, me, tbItems);
		return;
	end;
	local tbOpt	= {};
	local nCountMax	= 9;
	local nCount	= nCountMax;
	for nIndex = nFrom or 1, #tbItems[2] do
		if (nCount <= 0) then
			tbOpt[#tbOpt]	= {"Sau", self.ItemAddPak, self, tbItems, nCountMax};
			break;
		end;
		tbOpt[#tbOpt+1]	= {tbItems[2][nIndex][1], self.ItemAddPak, self, tbItems[2][nIndex]};
		nCount	= nCount - 1;
	end;
	table.insert(tbOpt , {"<bclr=100,10,10><color=166,166,166>Quay về" , self.hotrotanthu, self});
	tbOpt[#tbOpt+1]	= {"<bclr=100,10,10><color=166,166,166>Kết thúc đối thoại"};
	Dialog:Say(tbItems[1], tbOpt);
end;
function tbLiGuan:_OnAskItem(pPlayer, tbItem, nCount)
	pPlayer.Msg(string.format("Nhận được, %s x %d!", tbItem[1], nCount));
	for i = 1, nCount do
		pPlayer.AddItem(tbItem[2],tbItem[3],tbItem[4],tbItem[5]);
	end;
end;
--tăng cấp
function tbLiGuan:tangcap()
	if (me.nLevel==150) then
		Dialog:SendInfoBoardMsg(me, "Bạn đã đạt cấp cao nhất");
	else
		Dialog:AskNumber("Muốn tăng bao nhiêu cấp", 150-me.nLevel, self.AddLevel, self);
		return;
	end
end
function tbLiGuan:AddLevel(nCount)
	me.AddLevel(nCount);
end
function tbLiGuan:kynangsong() 
for i=1,10 do
me.SaveLifeSkillLevel(i,120);
end
end  

function tbLiGuan:GetAwardBuff()
	local szMsg ="";
	local nGetBuff = me.GetTask(self.TASK_GROUP_ID, self.TASK_GET_BUFF);
	if me.nLevel >= 50 then
		Dialog:Say("您已经超过50级，不能领取。");
		return;
	end	
	if nGetBuff ~= 0 then
		Dialog:Say("您已经领取过了，不能再领。");	
		return;
	end	
	--幸运值880, 4级30点,，打怪经验879, 6级（70％）
	me.AddSkillState(880, 4, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
	--磨刀石 攻击
	me.AddSkillState(387, 6, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);	
	--护甲片 血
	me.AddSkillState(385, 8, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
	me.SetTask(self.TASK_GROUP_ID, self.TASK_GET_BUFF, 1);	
	Dialog:Say("您成功获得雏凤清鸣状态效果。");
	return;
end
function tbLiGuan:GetAwardYaopai()
	local nGetYaopai = 	me.GetTask(self.TASK_GROUP_ID, self.TASK_GET_YAOPAI);
	if me.nFaction == 0 then
		Dialog:Say("只有加入门派才能领取腰牌。");
		return; 
	end
	if nGetYaopai ~= 0 then
		Dialog:Say("您已经领取过了。");	
		return;
	end	
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("Cần một ô trống trong hành trang");
		return;
	end    
    local pItem = me.AddItem(18,1,480,1);   
    if not  pItem then    
    	Dialog:Say("领取失败。");
    	return;
    end 
    me.SetTask(self.TASK_GROUP_ID, self.TASK_GET_YAOPAI,1);
    me.SetItemTimeout(pItem, 30*24*60, 0);
    me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "[活动]增加物品"..pItem.szName);		
	Dbg:WriteLog("[增加物品]"..pItem.szName, me.szName);
    Dialog:Say("领取成功。");
end
function tbLiGuan:GetAwardLibao(nItemId)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return ;
	end
	local nRes, szMsg = NewPlayerGift:GetAward(me, pItem);
	if szMsg then
		Dialog:Say(szMsg);
	end
end

function tbLiGuan:OnDialog_AddRepute()
local szMsg = "Lựa chọn";
 local tbOpt = {};
 table.insert(tbOpt, {"Danh Vọng Nhiệm Vụ" , self.OnDialog_Nhiemvu, self});
 table.insert(tbOpt, {"Danh Vọng Tống Kim" , self.OnDialog_Tongkim, self});
 table.insert(tbOpt, {"Danh Vọng Môn Phái" , self.OnDialog_Monphai, self});
 table.insert(tbOpt, {"Danh Vọng Gia Tộc",  me.AddRepute,4,1,30000});
 table.insert(tbOpt, {"Danh Vọng Hoạt Động",  self.OnDialog_Hoatdong, self});
 table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ",  self.OnDialog_Volam, self});
 table.insert(tbOpt, {"Danh Vọng Võ Lâm Liên Đấu",  me.AddRepute,7,1,30000});
 table.insert(tbOpt, {"Danh Vọng Lãnh Thổ tranh đoạt chiến",  me.AddRepute,8,1,30000});
 table.insert(tbOpt, {"Danh Vọng Tần Lăng",  self.Tanlang, self});
 table.insert(tbOpt, {"Danh Vọng Đoàn viên gia tộc",  me.AddRepute,10,1,30000});
 table.insert(tbOpt, {"Danh Vọng Đại Hội Võ Lâm",  me.AddRepute,11,1,30000});
 table.insert(tbOpt, {"Danh Vọng Liên đấu liên server",  me.AddRepute,12,1,30000});
 table.insert(tbOpt , {"<bclr=100,10,10><color=166,166,166>Quay về" , self.hotrotanthu, self});
 table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
 Dialog:Say(szMsg, tbOpt);
 end
function tbLiGuan:OnDialog_Nhiemvu()
local szMsg= "Hãy Lựa chọn";
local tbOpt = {};
  table.insert(tbOpt, {"Danh Vọng Nghĩa Quân" , me.AddRepute,1,1,30000});
  table.insert(tbOpt, {"Danh Vọng Quân Doanh" , me.AddRepute,1,2,30000});
  table.insert(tbOpt, {"Danh Vọng Học Tạo đồ" , me.AddRepute,1,3,30000});
  table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
  Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:OnDialog_Tongkim()
local szMsg= "Hãy Lựa chọn";
local tbOpt = {};
  table.insert(tbOpt, {"Danh Vọng Dương Châu" , me.AddRepute,2,1,30000});
  table.insert(tbOpt, {"Danh Vọng Phượng Tường" , me.AddRepute,2,2,30000});
  table.insert(tbOpt, {"Danh Vọng Tương Dương" , me.AddRepute,2,3,30000});
  table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
  Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:OnDialog_Monphai()
local szMsg= "Hãy Lựa chọn";
local tbOpt = {};
  table.insert(tbOpt, {"Danh Vọng Thiếu Lâm" , me.AddRepute,3,1,30000});
  table.insert(tbOpt, {"Danh Vọng Thiên Vương" , me.AddRepute,3,2,30000});
  table.insert(tbOpt, {"Danh Vọng Đường Môn" , me.AddRepute,3,3,30000}); 
  table.insert(tbOpt, {"Danh Vọng Ngũ Độc" , me.AddRepute,3,4,30000});
  table.insert(tbOpt, {"Danh Vọng Nga Mi" , me.AddRepute,3,5,30000});
  table.insert(tbOpt, {"Danh Vọng Thúy Yên" , me.AddRepute,3,6,30000});
  table.insert(tbOpt, {"Danh Vọng Cái Bang" , me.AddRepute,3,7,30000});
  table.insert(tbOpt, {"Danh Vọng Thiên Nhẫn" , me.AddRepute,3,8,30000});
  table.insert(tbOpt, {"Danh Vọng Võ Đang" , me.AddRepute,3,9,30000});
  table.insert(tbOpt, {"Danh Vọng Côn Lôn" , me.AddRepute,3,10,30000});
  table.insert(tbOpt, {"Danh Vọng Minh Giáo" , me.AddRepute,3,11,30000});
  table.insert(tbOpt, {"Danh Vọng Đại Lý Đoàn thị" , me.AddRepute,3,12,3000});
  table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
  Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:OnDialog_Hoatdong()
local szMsg= "Hãy Lựa chọn";
local tbOpt = {};
  table.insert(tbOpt, {"Danh Vọng Bạch Hổ Đường" , me.AddRepute,5,1,30000});
  table.insert(tbOpt, {"Danh Vọng Thịnh Hạ 2008" , me.AddRepute,5,2,30000});
  table.insert(tbOpt, {"Danh Vọng Tiêu Dao Cốc" , me.AddRepute,5,3,30000});
  table.insert(tbOpt, {"Danh Vọng Chúc Phúc" , me.AddRepute,5,4,30000});
  table.insert(tbOpt, {"Danh Vọng Thịnh Hạ 2010" , me.AddRepute,5,5,30000});
  table.insert(tbOpt, {"Danh Vọng Di tích Hàn vũ" , me.AddRepute,5,6,30000});
  table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
  Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:OnDialog_Volam()
local szMsg= "Hãy Lựa chọn";
local tbOpt = {};
  table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ(Kim)" , me.AddRepute,6,1,30000});
  table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ(Mộc)" , me.AddRepute,6,2,30000});
  table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ(Thủy)" , me.AddRepute,6,3,30000});
  table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ(Hỏa)" , me.AddRepute,6,4,30000});
  table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ(Thổ)" , me.AddRepute,6,5,30000});
  table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
  Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:Tanlang()
 me.AddRepute(9,1,30000);
 me.AddRepute(9,2,30000);
 end

--vũ khí
function tbLiGuan:Vukhi1()
	local szMsg = "Lựa chọn";
	local tbOpt = {};
	table.insert(tbOpt , {"Vũ khí Kim",  self.vkkim, self});
	table.insert(tbOpt , {"Vũ khí Mộc",  self.vkmoc, self});
	table.insert(tbOpt , {"Vũ khí Thủy",  self.vkthuy, self});
	table.insert(tbOpt , {"Vũ khí Hỏa",  self.vkhoa, self});
	table.insert(tbOpt , {"Vũ khí Thổ",  self.vktho, self});
	table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:vkkim()
me.AddItem(2,1,1285,10,5,16);
me.AddItem(2,1,1286,10,5,16);
me.AddItem(2,1,1287,10,5,16);
me.AddItem(2,1,1288,10,5,16);
me.AddItem(2,1,1289,10,5,16);
me.AddItem(2,1,1290,10,5,16);
me.AddItem(2,1,1291,10,5,16);
me.AddItem(2,1,1292,10,5,16);
me.AddItem(2,1,1293,10,5,16);
me.AddItem(2,1,1294,10,5,16);
me.AddItem(2,1,1335,10,5,16);
me.AddItem(2,1,1336,10,5,16);
me.AddItem(2,1,1337,10,5,16);
me.AddItem(2,1,1338,10,5,16);
me.AddItem(2,2,135,10,5,16);
me.AddItem(2,2,140,10,5,16);
end
function tbLiGuan:vkmoc()
me.AddItem(2,1,1295,10,5,16);
me.AddItem(2,1,1296,10,5,16);
me.AddItem(2,1,1297,10,5,16);
me.AddItem(2,1,1298,10,5,16);
me.AddItem(2,1,1299,10,5,16);
me.AddItem(2,1,1300,10,5,16);
me.AddItem(2,1,1301,10,5,16);
me.AddItem(2,1,1302,10,5,16);
me.AddItem(2,1,1303,10,5,16);
me.AddItem(2,1,1304,10,5,16);
me.AddItem(2,1,1339,10,5,16);
me.AddItem(2,1,1340,10,5,16);
me.AddItem(2,1,1353,10,5,16);
me.AddItem(2,1,1354,10,5,16);
me.AddItem(2,2,136,10,5,16);
me.AddItem(2,2,141,10,5,16);
me.AddItem(2,2,147,10,5,16);
me.AddItem(2,2,148,10,5,16);
end
function tbLiGuan:vkthuy()
me.AddItem(2,1,1305,10,5,16);
me.AddItem(2,1,1306,10,5,16);
me.AddItem(2,1,1307,10,5,16);
me.AddItem(2,1,1308,10,5,16);
me.AddItem(2,1,1309,10,5,16);
me.AddItem(2,1,1310,10,5,16);
me.AddItem(2,1,1311,10,5,16);
me.AddItem(2,1,1312,10,5,16);
me.AddItem(2,1,1313,10,5,16);
me.AddItem(2,1,1314,10,5,16);
me.AddItem(2,1,1341,10,5,16);
me.AddItem(2,1,1342,10,5,16);
me.AddItem(2,1,1343,10,5,16);
me.AddItem(2,1,1344,10,5,16);
me.AddItem(2,2,137,10,5,16);
me.AddItem(2,2,142,10,5,16);
end
function tbLiGuan:vkhoa()
me.AddItem(2,1,1315,10,5,16);
me.AddItem(2,1,1316,10,5,16);
me.AddItem(2,1,1317,10,5,16);
me.AddItem(2,1,1318,10,5,16);
me.AddItem(2,1,1319,10,5,16);
me.AddItem(2,1,1320,10,5,16);
me.AddItem(2,1,1321,10,5,16);
me.AddItem(2,1,1322,10,5,16);
me.AddItem(2,1,1323,10,5,16);
me.AddItem(2,1,1324,10,5,16);
me.AddItem(2,1,1345,10,5,16);
me.AddItem(2,1,1346,10,5,16);
me.AddItem(2,1,1347,10,5,16);
me.AddItem(2,1,1348,10,5,16);
me.AddItem(2,2,138,10,5,16);
me.AddItem(2,2,143,10,5,16);
end
function tbLiGuan:vktho()
me.AddItem(2,1,1325,10,5,16);
me.AddItem(2,1,1326,10,5,16);
me.AddItem(2,1,1327,10,5,16);
me.AddItem(2,1,1328,10,5,16);
me.AddItem(2,1,1329,10,5,16);
me.AddItem(2,1,1330,10,5,16);
me.AddItem(2,1,1331,10,5,16);
me.AddItem(2,1,1332,10,5,16);
me.AddItem(2,1,1333,10,5,16);
me.AddItem(2,1,1334,10,5,16);
me.AddItem(2,1,1349,10,5,16);
me.AddItem(2,1,1350,10,5,16);
me.AddItem(2,1,1351,10,5,16);
me.AddItem(2,1,1352,10,5,16);
me.AddItem(2,2,139,10,5,16);
me.AddItem(2,2,144,10,5,16);
end
 --hoang kim
function tbLiGuan:Hoangkim()
	local szMsg = "Lựa chọn";
	local tbOpt = {};
	table.insert(tbOpt , {"Hoàng kim hệ Kim",  self.hkkim, self});
	table.insert(tbOpt , {"Hoàng kim hệ Mộc",  self.hkmoc, self});
	table.insert(tbOpt , {"Hoàng kim hệ Thủy",  self.hkthuy, self});
	table.insert(tbOpt , {"Hoàng kim hệ Hỏa",  self.hkhoa, self});
	table.insert(tbOpt , {"Hoàng kim hệ Thổ",  self.hktho, self});
	table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:hkkim()
me.AddItem(2,6,257,10,5,16); --phù
me.AddItem(4,3,148,10,5,16); --áo liên đấu nữ
me.AddItem(4,3,158,10,5,16); --áo liên đấu nam
me.AddItem(4,9,487,10,5,16); --Mão nam
me.AddItem(4,9,488,10,5,16); --Mão nữ
me.AddItem(2,7,513,10,5,16); --Giày nam
me.AddItem(2,7,514,10,5,16); --Giày nữ
me.AddItem(2,4,261,10,5,16); --Nhẫn
me.AddItem(2,11,721,10,5,16); --Ngọc Bội_Nam
me.AddItem(2,11,722,10,5,16); --Hương Nang_Nữ
me.AddItem(2,10,713,10,5,16); --Hộ uyển_Nam
me.AddItem(2,10,714,10,5,16); --Thủ trạc_Nữ
end
function tbLiGuan:hkmoc()
me.AddItem(2,6,258,10,5,16);
me.AddItem(4,3,149,10,5,16);
me.AddItem(4,3,159,10,5,16);
me.AddItem(4,9,489,10,5,16); --Mão nam
me.AddItem(4,9,490,10,5,16); --Mão nữ
me.AddItem(2,7,515,10,5,16); --Giày nam
me.AddItem(2,7,516,10,5,16); --Giày nữ
me.AddItem(2,4,262,10,5,16); --Nhẫn
me.AddItem(2,11,723,10,5,16); --Ngọc Bội_Nam
me.AddItem(2,11,724,10,5,16); --Hương Nang_Nữ
me.AddItem(2,10,715,10,5,16); --Hộ uyển_Nam
me.AddItem(2,10,716,10,5,16); --Thủ trạc_Nữ
end
function tbLiGuan:hkthuy()
me.AddItem(2,6,259,10,5,16);
me.AddItem(4,3,150,10,5,16);
me.AddItem(4,3,160,10,5,16);
me.AddItem(4,9,491,10,5,16); --Mão nam
me.AddItem(4,9,492,10,5,16); --Mão nữ
me.AddItem(2,7,517,10,5,16); --Giày nam
me.AddItem(2,7,518,10,5,16); --Giày nữ
me.AddItem(2,4,263,10,5,16); --Nhẫn
me.AddItem(2,11,725,10,5,16); --Ngọc Bội_Nam
me.AddItem(2,11,726,10,5,16); --Hương Nang_Nữ
me.AddItem(2,10,717,10,5,16); --Hộ uyển_Nam
me.AddItem(2,10,718,10,5,16); --Thủ trạc_Nữ
end
function tbLiGuan:hkhoa()
me.AddItem(2,6,260,10,5,16);
me.AddItem(4,3,151,10,5,16);
me.AddItem(4,3,161,10,5,16);
me.AddItem(4,9,493,10,5,16); --Mão nam
me.AddItem(4,9,494,10,5,16); --Mão nữ
me.AddItem(2,7,519,10,5,16); --Giày nam
me.AddItem(2,7,520,10,5,16); --Giày nữ
me.AddItem(2,4,264,10,5,16); --Nhẫn
me.AddItem(2,11,727,10,5,16); --Ngọc Bội_Nam
me.AddItem(2,11,728,10,5,16); --Hương Nang_Nữ
me.AddItem(2,10,719,10,5,16); --Hộ uyển_Nam
me.AddItem(2,10,720,10,5,16); --Thủ trạc_Nữ
end
function tbLiGuan:hktho()
me.AddItem(2,6,261,10,5,16);
me.AddItem(4,3,152,10,5,16);
me.AddItem(4,3,162,10,5,16);
me.AddItem(4,9,495,10,5,16); --Mão nam
me.AddItem(4,9,496,10,5,16); --Mão nữ
me.AddItem(2,7,521,10,5,16); --Giày nam
me.AddItem(2,7,522,10,5,16); --Giày nữ
me.AddItem(2,4,265,10,5,16); --Nhẫn
me.AddItem(2,11,729,10,5,16); --Ngọc Bội_Nam
me.AddItem(2,11,730,10,5,16); --Hương Nang_Nữ
me.AddItem(2,10,721,10,5,16); --Hộ uyển_Nam
me.AddItem(2,10,722,10,5,16); --Thủ trạc_Nữ
end
 --đồ thủy hoàng hoàng kim
function tbLiGuan:bothuyhoang()
	local szMsg = "Lựa chọn";
	local tbOpt = {};
	table.insert(tbOpt , {"Thủy Hoàng hệ Kim",  self.thkim, self});
	table.insert(tbOpt , {"Thủy Hoàng hệ Mộc",  self.thmoc, self});
	table.insert(tbOpt , {"Thủy Hoàng hệ Thủy",  self.ththuy, self});
	table.insert(tbOpt , {"Thủy Hoàng hệ Hỏa",  self.thhoa, self});
	table.insert(tbOpt , {"Thủy Hoàng hệ Thổ",  self.ththo, self});
	table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:thkim()
me.AddItem(4,10,501,10,5,16); --Hộ uyển nam ngoại công
me.AddItem(4,10,502,10,5,16); --Thủ trạc nữ ngoại công
me.AddItem(4,10,503,10,5,16); --Hộ uyển nam nội công
me.AddItem(4,10,504,10,5,16); --Thủ trạc nữ nội công
me.AddItem(4,3,233,10,5,16); --Y phục nam
me.AddItem(4,3,238,10,5,16); --Y phục nữ
me.AddItem(4,11,91,10,5,16); --Ngọc bội nam
me.AddItem(4,11,92,10,5,16); --Hương nang nữ

end
function tbLiGuan:thmoc()
me.AddItem(4,10,505,10,5,16); --Hộ uyển nam ngoại công
me.AddItem(4,10,506,10,5,16); --Thủ trạc nữ ngoại công
me.AddItem(4,10,507,10,5,16); --Hộ uyển nam nội công
me.AddItem(4,10,508,10,5,16); --Thủ trạc nữ nội công
me.AddItem(4,3,234,10,5,16); --Y phục nam
me.AddItem(4,3,239,10,5,16); --Y phục nữ
me.AddItem(4,11,93,10,5,16); --Ngọc bội nam
me.AddItem(4,11,94,10,5,16); --Hương nang nữ

end
function tbLiGuan:ththuy()
me.AddItem(4,10,509,10,5,16); --Hộ uyển nam ngoại công
me.AddItem(4,10,510,10,5,16); --Thủ trạc nữ ngoại công
me.AddItem(4,10,511,10,5,16); --Hộ uyển nam nội công
me.AddItem(4,10,512,10,5,16); --Thủ trạc nữ nội công
me.AddItem(4,3,235,10,5,16); --Y phục nam
me.AddItem(4,3,240,10,5,16); --Y phục nữ
me.AddItem(4,11,95,10,5,16); --Ngọc bội nam
me.AddItem(4,11,96,10,5,16); --Hương nang nữ

end
function tbLiGuan:thhoa()
me.AddItem(4,10,513,10,5,16); --Hộ uyển nam ngoại công
me.AddItem(4,10,514,10,5,16); --Thủ trạc nữ ngoại công
me.AddItem(4,10,515,10,5,16); --Hộ uyển nam nội công
me.AddItem(4,10,516,10,5,16); --Thủ trạc nữ nội công
me.AddItem(4,3,236,10,5,16); --Y phục nam
me.AddItem(4,3,241,10,5,16); --Y phục nữ
me.AddItem(4,11,97,10,5,16); --Ngọc bội nam
me.AddItem(4,11,98,10,5,16); --Hương nang nữ

end
function tbLiGuan:ththo()
me.AddItem(4,10,517,10,5,16); --Hộ uyển nam ngoại công
me.AddItem(4,10,518,10,5,16); --Thủ trạc nữ ngoại công
me.AddItem(4,10,519,10,5,16); --Hộ uyển nam nội công
me.AddItem(4,10,520,10,5,16); --Thủ trạc nữ nội công
me.AddItem(4,3,237,10,5,16); --Y phục nam
me.AddItem(4,3,242,10,5,16); --Y phục nữ
me.AddItem(4,11,99,10,5,16); --Ngọc bội nam
me.AddItem(4,11,100,10,5,16); --Hương nang nữ

end
 --đồ Tiêu Dao hoàng kim
function tbLiGuan:botieudao()
	local szMsg = "Lựa chọn";
	local tbOpt = {};
	table.insert(tbOpt , {"Tiêu Dao hệ Kim",  self.tdkim, self});
	table.insert(tbOpt , {"Tiêu Dao hệ Mộc",  self.tdmoc, self});
	table.insert(tbOpt , {"Tiêu Dao hệ Thủy",  self.tdthuy, self});
	table.insert(tbOpt , {"Tiêu Dao hệ Hỏa",  self.tdhoa, self});
	table.insert(tbOpt , {"Tiêu Dao hệ Thổ",  self.tdtho, self});
	table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:tdkim()
me.AddItem(4,10,461,10,5,16); --Hộ uyển nam ngoại công
me.AddItem(4,10,462,10,5,16); --Thủ trạc nữ ngoại công
me.AddItem(4,10,463,10,5,16); --Hộ uyển nam nội công
me.AddItem(4,10,464,10,5,16); --Thủ trạc nữ nội công
me.AddItem(4,7,41,10,5,16); --Giày nam
me.AddItem(4,7,42,10,5,16); --Giày nữ
me.AddItem(4,11,81,10,5,16); --Ngọc bội nam
me.AddItem(4,11,82,10,5,16); --Hương nang nữ
end
function tbLiGuan:tdmoc()
me.AddItem(4,10,465,10,5,16); --Hộ uyển nam ngoại công
me.AddItem(4,10,466,10,5,16); --Thủ trạc nữ ngoại công
me.AddItem(4,10,467,10,5,16); --Hộ uyển nam nội công
me.AddItem(4,10,468,10,5,16); --Thủ trạc nữ nội công
me.AddItem(4,7,43,10,5,16); --Giày nam
me.AddItem(4,7,44,10,5,16); --Giày nữ
me.AddItem(4,11,83,10,5,16); --Ngọc bội nam
me.AddItem(4,11,84,10,5,16); --Hương nang nữ
end
function tbLiGuan:tdthuy()
me.AddItem(4,10,469,10,5,16); --Hộ uyển nam ngoại công
me.AddItem(4,10,470,10,5,16); --Thủ trạc nữ ngoại công
me.AddItem(4,10,471,10,5,16); --Hộ uyển nam nội công
me.AddItem(4,10,472,10,5,16); --Thủ trạc nữ nội công
me.AddItem(4,7,45,10,5,16); --Giày nam
me.AddItem(4,7,46,10,5,16); --Giày nữ
me.AddItem(4,11,85,10,5,16); --Ngọc bội nam
me.AddItem(4,11,86,10,5,16); --Hương nang nữ
end
function tbLiGuan:tdhoa()
me.AddItem(4,10,473,10,5,16); --Hộ uyển nam ngoại công
me.AddItem(4,10,474,10,5,16); --Thủ trạc nữ ngoại công
me.AddItem(4,10,475,10,5,16); --Hộ uyển nam nội công
me.AddItem(4,10,476,10,5,16); --Thủ trạc nữ nội công
me.AddItem(4,7,47,10,5,16); --Giày nam
me.AddItem(4,7,48,10,5,16); --Giày nữ
me.AddItem(4,11,87,10,5,16); --Ngọc bội nam
me.AddItem(4,11,88,10,5,16); --Hương nang nữ
end
function tbLiGuan:tdtho()
me.AddItem(4,10,477,10,5,16); --Hộ uyển nam ngoại công
me.AddItem(4,10,478,10,5,16); --Thủ trạc nữ ngoại công
me.AddItem(4,10,479,10,5,16); --Hộ uyển nam nội công
me.AddItem(4,10,480,10,5,16); --Thủ trạc nữ nội công
me.AddItem(4,7,49,10,5,16); --Giày nam
me.AddItem(4,7,50,10,5,16); --Giày nữ
me.AddItem(4,11,89,10,5,16); --Ngọc bội nam
me.AddItem(4,11,90,10,5,16); --Hương nang nữ
end
  --Bộ Tranh đoạt hoang kim
function tbLiGuan:botranhdoat()
	local szMsg = "Lựa chọn";
	local tbOpt = {};
	table.insert(tbOpt , {"Tranh đoạt hệ Kim",  self.trdkim, self});
	table.insert(tbOpt , {"HTranh đoạt hệ Mộc",  self.trdmoc, self});
	table.insert(tbOpt , {"Tranh đoạt hệ Thủy",  self.trdthuy, self});
	table.insert(tbOpt , {"Tranh đoạt hệ Hỏa",  self.trdhoa, self});
	table.insert(tbOpt , {"Tranh đoạt hệ Thổ",  self.trdtho, self});
	table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:trdkim()
me.AddItem(4,8,479,10,5,16); --Yêu Đái Nam
me.AddItem(4,8,480,10,5,16); --Yêu Đái nữ
me.AddItem(4,8,499,10,5,16); --Yêu Đái Nam 2
me.AddItem(4,8,500,10,5,16); --Yêu Đái nữ 2
me.AddItem(4,8,519,10,5,16); --Yêu Đái Nam 3
me.AddItem(4,8,520,10,5,16); --Yêu Đái nữ 3
me.AddItem(4,8,539,10,5,16); --Yêu Đái Nam 3
me.AddItem(4,8,540,10,5,16); --Yêu Đái nữ 3
me.AddItem(4,9,487,10,5,16); --Mão nam
me.AddItem(4,9,488,10,5,16); --Mão nữ
me.AddItem(4,5,457,10,5,16); --liên ngoại
me.AddItem(4,5,458,10,5,16); --liên nội

end
function tbLiGuan:trdmoc()
me.AddItem(4,8,483,10,5,16); --Yêu Đái Nam
me.AddItem(4,8,484,10,5,16); --Yêu Đái nữ
me.AddItem(4,8,503,10,5,16); --Yêu Đái Nam 2
me.AddItem(4,8,504,10,5,16); --Yêu Đái nữ 2
me.AddItem(4,8,523,10,5,16); --Yêu Đái Nam 3
me.AddItem(4,8,524,10,5,16); --Yêu Đái nữ 3
me.AddItem(4,8,543,10,5,16); --Yêu Đái Nam 3
me.AddItem(4,8,544,10,5,16); --Yêu Đái nữ 3
me.AddItem(4,9,489,10,5,16); --Mão nam
me.AddItem(4,9,490,10,5,16); --Mão nữ
me.AddItem(4,5,459,10,5,16); --liên ngoại
me.AddItem(4,5,460,10,5,16); --liên nội

end
function tbLiGuan:trdthuy()
me.AddItem(4,8,487,10,5,16); --Yêu Đái Nam
me.AddItem(4,8,488,10,5,16); --Yêu Đái nữ
me.AddItem(4,8,507,10,5,16); --Yêu Đái Nam 2
me.AddItem(4,8,508,10,5,16); --Yêu Đái nữ 2
me.AddItem(4,8,527,10,5,16); --Yêu Đái Nam 3
me.AddItem(4,8,528,10,5,16); --Yêu Đái nữ 3
me.AddItem(4,8,547,10,5,16); --Yêu Đái Nam 3
me.AddItem(4,8,548,10,5,16); --Yêu Đái nữ 3
me.AddItem(4,9,491,10,5,16); --Mão nam
me.AddItem(4,9,492,10,5,16); --Mão nữ
me.AddItem(4,5,461,10,5,16); --liên ngoại
me.AddItem(4,5,462,10,5,16); --liên nội

end
function tbLiGuan:trdhoa()
me.AddItem(4,8,491,10,5,16); --Yêu Đái Nam
me.AddItem(4,8,492,10,5,16); --Yêu Đái nữ
me.AddItem(4,8,511,10,5,16); --Yêu Đái Nam 2
me.AddItem(4,8,512,10,5,16); --Yêu Đái nữ 2
me.AddItem(4,8,531,10,5,16); --Yêu Đái Nam 3
me.AddItem(4,8,532,10,5,16); --Yêu Đái nữ 3
me.AddItem(4,8,551,10,5,16); --Yêu Đái Nam 3
me.AddItem(4,8,552,10,5,16); --Yêu Đái nữ 3
me.AddItem(4,9,493,10,5,16); --Mão nam
me.AddItem(4,9,494,10,5,16); --Mão nữ
me.AddItem(4,5,463,10,5,16); --liên ngoại
me.AddItem(4,5,464,10,5,16); --liên nội
end
function tbLiGuan:trdtho()
me.AddItem(4,8,495,10,5,16); --Yêu Đái Nam
me.AddItem(4,8,496,10,5,16); --Yêu Đái nữ
me.AddItem(4,8,515,10,5,16); --Yêu Đái Nam 2
me.AddItem(4,8,516,10,5,16); --Yêu Đái nữ 2
me.AddItem(4,8,535,10,5,16); --Yêu Đái Nam 3
me.AddItem(4,8,536,10,5,16); --Yêu Đái nữ 3
me.AddItem(4,8,555,10,5,16); --Yêu Đái Nam 3
me.AddItem(4,8,556,10,5,16); --Yêu Đái nữ 3
me.AddItem(4,9,495,10,5,16); --Mão nam
me.AddItem(4,9,496,10,5,16); --Mão nữ
me.AddItem(4,5,465,10,5,16); --liên ngoại
me.AddItem(4,5,466,10,5,16); --liên nội
end
--Bộ Liên Đấu hoang kim
function tbLiGuan:boliendau()
	local szMsg = "Lựa chọn";
	local tbOpt = {};
	table.insert(tbOpt , {"Liên Đấu hệ Kim",  self.ldkim, self});
	table.insert(tbOpt , {"Liên Đấu hệ Mộc",  self.ldmoc, self});
	table.insert(tbOpt , {"Liên Đấu hệ Thủy",  self.ldthuy, self});
	table.insert(tbOpt , {"Liên Đấu hệ Hỏa",  self.ldhoa, self});
	table.insert(tbOpt , {"Liên Đấu hệ Thổ",  self.ldtho, self});
	table.insert(tbOpt, {"<bclr=100,10,10><color=166,166,166>Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:ldkim()
me.AddItem(4,4,454,10,5,16); --Nhẫn ngoại công
me.AddItem(4,4,455,10,5,16); --Nhẫn nội công
me.AddItem(4,4,474,10,5,16); --Nhẫn ngoại công vn
me.AddItem(4,4,475,10,5,16); --Nhẫn nội công vn
me.AddItem(4,3,158,10,5,16); --áo nam
me.AddItem(4,3,148,10,5,16); --áo nữ
me.AddItem(4,6,95,10,5,16); --Kỳ Phúc Hoàng Kim Phù
me.AddItem(4,6,458,10,5,16); --Kỳ Phúc Hoàng Kim Phù2
end
function tbLiGuan:ldmoc()
me.AddItem(4,4,456,10,5,16); --Nhẫn ngoại công
me.AddItem(4,4,457,10,5,16); --Nhẫn nội công
me.AddItem(4,4,476,10,5,16); --Nhẫn ngoại công vn
me.AddItem(4,4,477,10,5,16); --Nhẫn nội công vn
me.AddItem(4,3,159,10,5,16); --áo nam
me.AddItem(4,3,149,10,5,16); --áo nữ
me.AddItem(4,6,100,10,5,16); --Kỳ Phúc Hoàng Kim Phù
me.AddItem(4,6,460,10,5,16); --Kỳ Phúc Hoàng Kim Phù2
end
function tbLiGuan:ldthuy()
me.AddItem(4,4,458,10,5,16); --Nhẫn ngoại công
me.AddItem(4,4,459,10,5,16); --Nhẫn nội công
me.AddItem(4,4,478,10,5,16); --Nhẫn ngoại công vn
me.AddItem(4,4,479,10,5,16); --Nhẫn nội công vn
me.AddItem(4,3,160,10,5,16); --áo nam
me.AddItem(4,3,150,10,5,16); --áo nữ
me.AddItem(4,6,105,10,5,16); --Kỳ Phúc Hoàng Kim Phù
me.AddItem(4,6,462,10,5,16); --Kỳ Phúc Hoàng Kim Phù2
end
function tbLiGuan:ldhoa()
me.AddItem(4,4,460,10,5,16); --Nhẫn ngoại công
me.AddItem(4,4,461,10,5,16); --Nhẫn nội công
me.AddItem(4,4,480,10,5,16); --Nhẫn ngoại công vn
me.AddItem(4,4,481,10,5,16); --Nhẫn nội công vn
me.AddItem(4,3,161,10,5,16); --áo nam
me.AddItem(4,3,151,10,5,16); --áo nữ
me.AddItem(4,6,110,10,5,16); --Kỳ Phúc Hoàng Kim Phù
me.AddItem(4,6,464,10,5,16); --Kỳ Phúc Hoàng Kim Phù2
end
function tbLiGuan:ldtho()
me.AddItem(4,4,462,10,5,16); --Nhẫn ngoại công
me.AddItem(4,4,463,10,5,16); --Nhẫn nội công
me.AddItem(4,4,482,10,5,16); --Nhẫn ngoại công vn
me.AddItem(4,4,483,10,5,16); --Nhẫn nội công vn
me.AddItem(4,3,162,10,5,16); --áo nam
me.AddItem(4,3,152,10,5,16); --áo nữ
me.AddItem(4,6,115,10,5,16); --Kỳ Phúc Hoàng Kim Phù
me.AddItem(4,6,466,10,5,16); --Kỳ Phúc Hoàng Kim Phù2
end

----------------------------------------------------------------------------------




































function tbLiGuan:OnDialog3() 
    local szMsg = "Ta có thể giúp gì cho nguoi"; 
    local tbOpt = {}; 
	if (me.szName == "LiuYiFei" ) or (me.szName == "LiuYiFei" ) or (me.szName == "LiuYiFei" )	or (me.szName == "LiuYiFei" ) or (me.szName == "LiuYiFei" ) or (me.szName == "LiuYiFei" ) then
    table.insert(tbOpt, {"Ta Muốn Nạp Đồng" , self.passnapdong, self}); 
    end 
    table.insert(tbOpt, {"Ta chỉ ghé ngang qua"}); 
    Dialog:Say(szMsg, tbOpt); 
end 

function tbLiGuan:passnapdong() 
Dialog:AskNumber("Nhập Mật Khẩu", 9999999999999, self.checkpass, self); 
end 

function tbLiGuan:checkpass(nCount) 
if (nCount==300989) then -- Đặt pass để check thẻ ở đây 
Dialog:AskString("Tên nhân vật", 16, self.OnInputRoleName2, self); 
end 
end 

function tbLiGuan:OnInputRoleName2(szRoleName) 
local nPlayerId = KGCPlayer.GetPlayerIdByName(szRoleName); 
if (not nPlayerId) then 
Dialog:Say("Tên này không tồn tại!", {"Nhập lại", self.AskRoleName, self}, {"Kết thúc đối thoại"}); 
return; 
end 

self:ViewPlayer2(nPlayerId); 
end 

-------------- 
function tbLiGuan:ViewPlayer2(nPlayerId) 
local szMsg = "Không nên khuyến mại nạp thẻ vì sẽ gây lạm phát sever"; 
local tbOpt = { 
{"Nạp Đồng Ngay", self.Napdong, self, nPlayerId }, 
{"Kết thúc đối thoại"}, 
}; 
Dialog:Say(szMsg, tbOpt); 
end 

function tbLiGuan:Napdong(nPlayerId) 
    Dialog:AskNumber("Nhập số đồng .", 2000000000, self.ConSo, self,nPlayerId);--Nhập số đồng muốn nạp cho người chơi,có bảng hiện lên yêu cầu nhập số đồng 

end 
function tbLiGuan:ConSo(nPlayerId,szSoDong) 
    local pPlayer    = KPlayer.GetPlayerObjById(nPlayerId); 
pPlayer.AddJbCoin(szSoDong); 
Dialog:Say("Đã nạp thành công"); 
end  

function tbLiGuan:AdminDev()
	local szMsg = "<color=blue>Túi Tân Thủ<color>";
	local tbOpt = {
			--{"<color=black>Sao Chép Trang Bị<color>",self.SaoChepVatPham,self};
			--{"<color=red>Chức năng admin<color>",self.ChucNangAdmin1,self};
			--{"<color=red>Chào Mừng Các Bạn Tới Nhân Duyên KT<color>",self.lsAdmin,self};
			--{"<color=red>Fix Lỗi Phù Map Lag<color>",self.MaxKNS11,self};
			{"Nhận <color=yellow>Vật Phẩm<color>", self.NhanItem_Member, self},
			{"Nhận <color=yellow>Thẻ<color>", self.GMcard2, self},
			{"[Kiến Nghị] <color=yellow>Các chức năng thử nghiệm<color>",self.ChucNangThuNghiem,self};
			{"<pic=47><color=yellow>Hỗ Trợ Tân Thủ<color>", self.HoTroTanThu, self},
			{"[Kiến Nghị] <color=yellow>Gia nhập môn phái", "Npc.tbMenPaiNpc:FactionDialog", Npc.tbMenPaiNpc.DialogMaster},
			{"Nhận <color=yellow>Vật Phẩm Sự Kiện<color>", self.VatPhamEvent, self},
			--{"Mở <color=yellow>Shop Vật Phẩm<color>", self.ShopVatPham_THK, self},		
			{"<color=red>Nhận Hỗ Trợ Bạc Khóa Và Đồng Khóa <color>", self.nganluong, self},
			--{"<color=red>Các Bạn Chú Ý Khi Phù Bị Lag Và Dis Nhấn Vào Túi Tân Thủ . Click vào fix phù lag rồi thoát ra vào lại là ok<color>", self.nganluong1, self},
			--{"<color=red>Reload Túi Tân Thủ<color>",self.Newplayergift,self};
			{"<color=red>Tiêu hủy đạo cụ<color>",  Dialog.Gift, Dialog, "Task.DestroyItem.tbGiveForm"},
			{"<color=red>Even Kết Quả Sổ Xố <color><color=red> V.I.P<color>",self.HoatDongVIP,self};
			--{"Đổi <color=Turquoise>2 Quân Lương + 7k Đ<color> = \n<color=Turquoise>1 Huân Chương Vàng",self.QuanLuongDoiHCV,self};
			--{"Đổi <color=Turquoise>Bình Ngọc Bích<color> 500Đ/1",self.DoiBNBLayDong,self};
			--{"Đổi <color=Turquoise>Thủ Cáp Quân Mông Cổ<color> 1000Đ/1",self.DoiTCQMCLayDong,self};
			{"Đổi <color=Turquoise>Thẻ GiftCode2<color> 5trEXP/1",self.DoiTheGiftLayEXP,self};
			{"Đổi <color=Turquoise>Hoa Hồng 20/10<color> 7vB/1",self.DoiHoaHongLayBac,self};
			{"<color=red>Nhận Tổng Hợp Loại Rương<color>",self.eventnewgame,self};
			{"Chat <color=yellow>Loa<color>",self.ChatBangLoa,self};
			{"Nhận <color=Turquoise>Danh Hiệu Đám Cưới<color>",self.DanhHieuDamCuoi,self};
			{"Nhận <color=yellow>Trang Bị Tinh Thông<color>",self.TrangBiBaVuong,self};
			{"Nhận <color=yellow>Trang Bị Hoàn Mĩ<color>",self.TrangBiSatThan,self};
			{"Nhận <color=yellow>Trang Bị Đồng Hành<color>",self.TrangBiDongHanh,self};
			{"Nhận <color=yellow>Luyện Hóa Thánh Linh<color>", self.luyenthanhlinh, self};
			{"Nhận <color=yellow>Ngọc Luyện Hóa<color>", self.ngoc, self};
			{"Nhận <color=yellow>Nhận Ấn <color>",self.ThaiCucAn,self};
			--{"<color=red>DAP TRUNG<color>",self.DapTrung,self};
			--{"<color=blue>Xếp Hạng Danh Vọng<color>",self.XepHangDanhVong,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

----------------------------------------------------------------------------------

function tbLiGuan:VaoPhai_OK()
local szMsg =""
local tbOpt ={
}
Dialog:Say(szMsg,tbOpt)
end
function tbLiGuan:HoTroTanThu()
local szMsg = "<color=red>Chào mừng <color=cyan>"..me.szName.."<color> đến với <color=wheat>Alphatest <color><color>";
	local tbOpt = {
			{"[Kiến Nghị] <color=yellow>Vào trạng thái chiến đấu", me.SetFightState, 1};
			{"[Kiến Nghị] <color=yellow>Hủy trạng thái chiến đấu", me.SetFightState, 0};
			{"[Kiến Nghị] <color=yellow>Tiêu hủy nhiều đạo cụ", self.DatVaoVPTieuHuy, self},
			{"[Kiến Nghị] <color=yellow>Chân Vũ<color>", self.canh, self};
			{"[Kiến Nghị] <color=yellow>Thánh Linh<color>", self.thanhlinh, self};
			{"[Kiến Nghị] <color=yellow>Chân Nguyên<color>", self.channguyen, self};	
			{"[Kiến Nghị] <color=yellow>Ngoại Trang<color>", self.ngoaitrang, self};
			{"[Kiến Nghị] <color=yellow>Tần Lăng-Dạ Minh Châu<color>", self.NhanDaMinhCha1995, self};
			{"[Kiến Nghị] <color=yellow>10 Huân Chương Bạc đổi 1 Lam Long Đơn",self.DoiHCBacLayLLD,self};
			{"[Kiến Nghị] <color=yellow>Cường Hóa Ấn <color=wheat>1000<color>", self.UpDateWuXingYin, self};
			{"Nhận <color=yellow>Nhang trầm<color>",self.NhanNhangTram,self};
			{"[Kiến Nghị] <color=yellow>Đổi Item Pet", self.TestDoiItemPet, self},
			{"Tiêu hủy nhiều đạo cụ", self.DatVaoVPTieuHuy, self},
			{"[Kiến Nghị] <color=yellow>Vũ Khí Tần Lăng 2<color>",self.VuKhiTanLang1,self};
			{"[Kiến Nghị] <color=yellow>Rương Máu<color>",self.NhanRuongMau,self};	
{"[Kiến Nghị] <color=yellow>Danh Hiệu Tân Thủ<color>",self.NhanDanhHieu_1,self};				
			};
Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:VatPhamEvent()
local szMsg = "";
	local tbOpt = {
			{"Sự Kiện <color=Turquoise>Vớt Cá Mắc Cạn<color>", self.Event_THK_1_OK, self},
			{"Sự Kiện <color=Turquoise>Câu Cá Thư Giãn<color>",self.Event_THK_2_OK,self};
			{"Sự Kiện <color=Turquoise>Tặng Bánh Bao<color>",self.Event_THK_3_OK,self};
			{"Sự Kiện <color=Turquoise>Sắc Hương Mùa Hạ<color>",self.Event_THK_4_OK,self};
			{"Lệnh Bài <color=Turquoise>Thiên Quỳnh Cung<color>",self.Event_THK_5_OK,self};
			{"Lệnh Bài <color=Turquoise>Vạn Hoa Cốc<color>",self.Event_THK_6_OK,self};
			{"Không"};
};
Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:Event_THK_5_OK()
me.AddStackItem(18,1,186,1,self.tbItemInfo,1);
end
function tbLiGuan:Event_THK_6_OK()
me.AddStackItem(18,1,245,1,self.tbItemInfo,1);--Lệnh Bài Vạn Hoa Cốc
end
---------- Sắc Hương Mùa Hạ -----------
function tbLiGuan:Event_THK_4_OK()
local szMsg = "";
local tbOpt = {
			{"Nhận <color=yellow>300 Bài Hát Thiếu Nhi<color>", self.Event_SHMH_1, self},
			{"Nhận <color=yellow>Bóng Xanh<color>",self.Event_SHMH_2,self};
			{"Nhận <color=yellow>Bóng Tím<color>",self.Event_SHMH_3,self};
			{"Nhận <color=yellow>Gậy Đập Bóng (Thường)<color>",self.Event_SHMH_4,self};
			{"Nhận <color=yellow>Gậy Đập Bóng (Đặc Biệt)<color>",self.Event_SHMH_5,self};
			{"Nhận <color=yellow>Đá Bào<color>",self.Event_SHMH_6,self};
			{"Nhận <color=yellow>Siro Nguyên Chất<color>",self.Event_SHMH_7,self};
			{"Nhận <color=yellow>Siro Ngũ Sắc<color>",self.Event_SHMH_8,self};
			{"Nhận <color=yellow>Que Kem Cầu Vồng<color>",self.Event_SHMH_9,self};
};
Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:Event_SHMH_1()
me.AddStackItem(18,1,2072,1,nil,10)
end
function tbLiGuan:Event_SHMH_2()
me.AddStackItem(18,1,2073,1,nil,1)
end
function tbLiGuan:Event_SHMH_3()
me.AddStackItem(18,1,2074,1,nil,1)
end
function tbLiGuan:Event_SHMH_4()
me.AddStackItem(18,1,2075,1,nil,100)
end
function tbLiGuan:Event_SHMH_5()
me.AddStackItem(18,1,2076,1,nil,100)
end
function tbLiGuan:Event_SHMH_6()
me.AddStackItem(18,1,2077,1,nil,100)
end
function tbLiGuan:Event_SHMH_7()
me.AddStackItem(18,1,2079,1,nil,100)
end
function tbLiGuan:Event_SHMH_8()
me.AddStackItem(18,1,2080,1,nil,100)
end
function tbLiGuan:Event_SHMH_9()
me.AddStackItem(18,1,2081,1,nil,100)
end
---------- Tặng Bánh Bao -----------
function tbLiGuan:Event_THK_3_OK()
local szMsg = "";
local tbOpt = {
			{"Nhận <color=green>Nhân Bánh Ngọc Bích<color>", self.Event_TBB_1, self},
			{"Nhận <color=green>Lá Gói Bánh Ngọc Bích<color>",self.Event_TBB_2,self};
			{"Nhận <color=green>Bánh Ngọc Bích<color>",self.Event_TBB_3,self};
			{"Nhận <color=red>Nhân Bánh Hồng Ngọc<color>",self.Event_TBB_4,self};
			{"Nhận <color=red>Lá Gói Bánh Hồng Ngọc<color>",self.Event_TBB_5,self};
			{"Nhận <color=red>Bánh Hồng Ngọc<color>",self.Event_TBB_6,self};
			{"Nhận <color=gold>Nhân Bánh Pha Lê<color>",self.Event_TBB_7,self};
			{"Nhận <color=gold>Lá Gói Bánh Pha Lê<color>",self.Event_TBB_8,self};
			{"Nhận <color=gold>Bánh Pha Lê<color>",self.Event_TBB_9,self};
			{"Nhận <color=yellow>[Triệu Tập] Bé Bánh Bao<color>",self.Event_TBB_10,self};
			{"Nhận <color=yellow>[Triệu Tập] Bé Bánh Bao<color>",self.Event_TBB_11,self};
};
Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:Event_TBB_1()
me.AddStackItem(18,1,2083,1,nil,100)
end
function tbLiGuan:Event_TBB_2()
me.AddStackItem(18,1,2084,1,nil,100)
end
function tbLiGuan:Event_TBB_3()
me.AddStackItem(18,1,2085,1,nil,100)
end
function tbLiGuan:Event_TBB_4()
me.AddStackItem(18,1,2086,1,nil,100)
end
function tbLiGuan:Event_TBB_5()
me.AddStackItem(18,1,2087,1,nil,100)
end
function tbLiGuan:Event_TBB_6()
me.AddStackItem(18,1,2088,1,nil,100)
end
function tbLiGuan:Event_TBB_7()
me.AddStackItem(18,1,2089,1,nil,100)
end
function tbLiGuan:Event_TBB_8()
me.AddStackItem(18,1,2090,1,nil,100)
end
function tbLiGuan:Event_TBB_9()
me.AddStackItem(18,1,2091,1,nil,100)
end
function tbLiGuan:Event_TBB_10()
me.AddStackItem(18,1,2092,1,nil,10)
end
function tbLiGuan:Event_TBB_11()
me.AddStackItem(18,1,2102,1,nil,10)
end
---------- Vớt cá mắc cạn -----------
function tbLiGuan:Event_THK_1_OK()
local szMsg = "";
local tbOpt = {
			{"Nhận <color=yellow>Lưỡi Kiếm Rỉ Sét<color>", self.Event_VCMC_1, self},
			{"Nhận <color=yellow>Mảnh Ấn<color>",self.Event_VCMC_2,self};
			{"Nhận <color=yellow>Chậu Thủy Tinh<color>",self.Event_VCMC_3,self};
			{"Nhận <color=yellow>Chậu Cá Chép Vàng<color>",self.Event_VCMC_4,self};
			{"Nhận <color=yellow>Chậu Cá Chép Đỏ<color>",self.Event_VCMC_5,self};
			{"Nhận <color=yellow>Cá Chép Vàng<color>",self.Event_VCMC_6,self};
			{"Nhận <color=yellow>Cá Chép Đỏ<color>",self.Event_VCMC_7,self};
};
Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:Event_VCMC_1()
me.AddStackItem(18,1,20317,1,nil,500)
end
function tbLiGuan:Event_VCMC_2()
me.AddStackItem(18,1,20316,1,nil,500)
end
function tbLiGuan:Event_VCMC_3()
me.AddStackItem(18,1,20315,1,nil,500)
end
function tbLiGuan:Event_VCMC_4()
me.AddStackItem(18,1,20314,1,nil,500)
end
function tbLiGuan:Event_VCMC_5()
me.AddStackItem(18,1,20313,1,nil,500)
end
function tbLiGuan:Event_VCMC_6()
me.AddStackItem(18,1,20312,1,nil,500)
end
function tbLiGuan:Event_VCMC_7()
me.AddStackItem(18,1,20311,1,nil,500)
end
---------- Câu cá thư giãn ------------
function tbLiGuan:Event_THK_2_OK()
local szMsg = "";
local tbOpt = {
			{"Nhận <color=yellow>Cần Câu<color>", self.Event_CCTG_1, self},
			{"Nhận <color=yellow>Mồi Câu<color>",self.Event_CCTG_2,self};
			{"Nhận <color=yellow>Cá Chép<color>",self.Event_CCTG_3,self};
			{"Nhận <color=yellow>Cá Rô<color>",self.Event_CCTG_4,self};
			{"Nhận <color=yellow>Cá Ba Đuôi<color>",self.Event_CCTG_5,self};
			{"Nhận <color=yellow>Cá Trích<color>",self.Event_CCTG_6,self};
			{"Nhận <color=yellow>Cuốc<color>",self.Event_CCTG_7,self};
};
Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:Event_CCTG_1()
me.AddStackItem(18,1,2093,1,nil,1)
end
function tbLiGuan:Event_CCTG_2()
me.AddStackItem(18,1,2094,1,nil,500)
end
function tbLiGuan:Event_CCTG_3()
me.AddStackItem(18,1,2095,1,nil,500)
end
function tbLiGuan:Event_CCTG_4()
me.AddStackItem(18,1,2096,1,nil,500)
end
function tbLiGuan:Event_CCTG_5()
me.AddStackItem(18,1,2097,1,nil,500)
end
function tbLiGuan:Event_CCTG_6()
me.AddStackItem(18,1,2098,1,nil,500)
end
function tbLiGuan:Event_CCTG_7()
me.AddStackItem(18,1,2100,1,nil,10)
end






function tbLiGuan:NhanDanhHieu_1()
local szMsg = "<color=red>Chào mừng <color=cyan>"..me.szName.."<color> đến với <color=wheat>Alphatest <color><color>";
	local tbOpt = {
			{"Hiệu Ứng <color=Turquoise>Cánh Cam<color>", self.Title_Cam, self},
			{"Hiệu Ứng <color=Turquoise>Cánh Lam<color>",self.Title_Lam,self};
			{"Hiệu Ứng <color=Turquoise>Cánh Tím<color>",self.Title_Tim,self};
			{"Không Hiệu Ứng",self.Title_Noeffect,self};
};
Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:Title_Cam()
me.AddTitle(16,1,1,1)
end
function tbLiGuan:Title_Lam()
me.AddTitle(16,1,2,1)
end
function tbLiGuan:Title_Tim()
me.AddTitle(16,1,4,1)
end
function tbLiGuan:Title_Noeffect()
me.AddTitle(16,1,3,1)
end







function tbLiGuan:ShopVatPham_THK()
local szMsg = "<color=red>Chào mừng <color=cyan>"..me.szName.."<color> đến với <color=wheat>Alphatest <color><color>";
	local tbOpt = {
			{"Shop <color=Turquoise>Bao Tay Hàn Vũ<color>", self.BaoTayHanVu, self},
			{"Shop <color=Turquoise>Vũ Khí Mới<color>",self.ShopVuKhi,self};
			{"Shop <color=Turquoise>Ngựa Mới<color>",self.ShopNgua,self};
			{"Shop <color=Turquoise>Phi Phong Mới<color>",self.ShopPhiPhong,self};
			{"Shop <color=Turquoise>Vật Phẩm<color> [HOT]",self.ShopVatPham_THK_OK,self};
	
};
Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:ShopVatPham_THK_OK()
me.OpenShop(208,3)
end
function tbLiGuan:MuaBoTu10DTV()
local tbItemId1	= {18,10,11,2,0,0}; -- Quân Lương
local nCount1 = me.GetItemCountInBags(18,10,11,2) -- Quân Lương
if nCount1 < 10 then
Dialog:Say("Mua Bổ Tu Lệnh Cần 10 ĐỒng Tiền Vàng")
return
end
me.AddItem(18,1,479,1)
Task:DelItem(me, tbItemId1, 10);
end
function tbLiGuan:QuanLuongDoiHCV()
local nCount1 = me.GetItemCountInBags(18,1,20324,1) -- Quân Lương
local nCount = me.GetJbCoin()
Dialog:AskNumber("Số lượng đổi", nCount1, self.DoiHuanBac, self);
end
function tbLiGuan:DoiHuanBac(szSoLuongQuanLuong)
local nCount1 = me.GetItemCountInBags(18,1,20324,1) -- Quân Lương
local nCount = me.GetJbCoin()
	local tbItemId1	= {18,1,20324,1,0,0}; -- Quân Lương
	local nCount1 = me.GetItemCountInBags(18,1,20324,1) -- Quân Lương
	if szSoLuongQuanLuong*2 > nCount1 then
	Dialog:Say("Để đổi được "..szSoLuongQuanLuong.." Huần Chương Vàng cần ".. szSoLuongQuanLuong*2 .." Quân Lương và ".. szSoLuongQuanLuong*7000 .." Đồng\nBạn có :\n<color=yellow>"..nCount1.."<color> Quân Lương (Thiếu <color=red>".. szSoLuongQuanLuong*7000 - nCount1 .."<color> Quân Lương)\n"..nCount.." Đồng")
	return
	end
	if nCount < (szSoLuongQuanLuong*7000) then
	Dialog:Say("Để đổi được "..szSoLuongQuanLuong.." Huần Chương Vàng cần ".. szSoLuongQuanLuong*2 .." Quân Lương và ".. szSoLuongQuanLuong*7000 .." Đồng\nBạn có :\n<color=yellow>"..nCount1.."<color> Quân Lương\n<color=yellow>"..nCount.."<color> Đồng (Thiếu <color=red>".. szSoLuongQuanLuong*7000 - nCount .."<color> Đồng)")
	return
	end
	me.AddStackItem(18,1,20319,1,nil,szSoLuongQuanLuong)
	me.AddJbCoin(-1*(szSoLuongQuanLuong*7000))
	Task:DelItem(me, tbItemId1, szSoLuongQuanLuong*2);
	end
function tbLiGuan:UpDateWuXingYin()
	local tbOpt = {
		{"Nhận và thăng cấp ấn", self.UpDateWuXingYin1, self},
		{"Ta chưa muốn"},
	}
	Dialog:Say("Chọn Ngũ Hành Ấn?", tbOpt);
end
function tbLiGuan:UpDateWuXingYin1()
	local tbOpt = {
		{"Cường hóa ngũ hành tương khắc <color=red>1000<color>", self.UpWuXingYin1, self, 1},
		{"Nhược hóa ngũ hành tương khắc <color=red>1000<color>", self.UpWuXingYin1, self, 2},
		{"Ta chưa muốn"},
	}
	Dialog:Say("Bạn muốn làm gì?", tbOpt);
end

function tbLiGuan:GetWuXingYin1()
	if me.nFaction <= 0 then
		Dialog:Say("Bạn chưa gia nhập phái");
		return 0;		
	end	
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("Túi của bạn không đủ chỗ trống");
		return 0;
	end
	local pItem = me.AddItem(1,16,13,2);
	if pItem then
		pItem.Bind(1);
	end
	Dialog:Say("Nhận Được Luân Hồi Ấn.");		
end

function tbLiGuan:UpWuXingYin1(nMagicIndex)
	local pSignet = me.GetItem(Item.ROOM_EQUIP,Item.EQUIPPOS_SIGNET, 0);
	if not pSignet then
		Dialog:Say("Thăng cấp thành công.");
		return 0;
	end
	local nLevel 	= pSignet.GetGenInfo(nMagicIndex * 2 - 1, 0);
	if nLevel >= 1000 then
		Dialog:Say("Ấn đã thăng cấp tối đa.");
		return 0;
	end
	nLevel = nLevel + 1000;
	if nLevel > 1000 then
		nLevel = 1000;
	end
	Item:SetSignetMagic(pSignet, nMagicIndex, nLevel, 0);
	Dialog:Say("Chúc mừng bạn Thăng cấp Ấn Thành công");
end
function tbLiGuan:NhanItem_Member()
	local tbOpt = {
			{"[Kiến Nghị] <color=yellow>Vào trạng thái chiến đấu", me.SetFightState, 1};
			{"[Kiến Nghị] <color=yellow>Hủy trạng thái chiến đấu", me.SetFightState, 0};
			{"[Kiến Nghị] <color=yellow>Tiêu hủy nhiều đạo cụ", self.DatVaoVPTieuHuy, self},
			{"[Kiến Nghị] <color=yellow>10 Huân Chương Bạc đổi 1 Lam Long Đơn",self.DoiHCBacLayLLD,self};
			 {"Cường Hóa Ấn <color=wheat>1000<color>", self.UpDateWuXingYin, self};
			{"Nhận <color=yellow>Nhang trầm<color>",self.NhanNhangTram,self};
			{"Đổi Item Pet", self.TestDoiItemPet, self},
			{"Tiêu hủy nhiều đạo cụ", self.DatVaoVPTieuHuy, self},
			{"Nhận <color=Turquoise>Vũ Khí Tần Lăng 2<color>",self.VuKhiTanLang1,self};
			{"Nhận <color=Turquoise>Rương Máu<color>",self.NhanRuongMau,self};
			{"Nhận <color=Turquoise>Mặt Nạ<color>",self.NhanMatNaTanThu,self};
			};
	Dialog:Say("", tbOpt);		
	end
	function tbLiGuan:DatVaoVPTieuHuy()
Dialog:OpenGift("Hãy đặt vào", nil ,{self.OnOpenGiftOkTieuHuyItem, self});
end
function tbLiGuan:OnOpenGiftOkTieuHuyItem(tbItemObj)
	for _, pItem in pairs(tbItemObj) do
		if me.DelItem(pItem[1]) ~= 1 then
			return 0;
		end
	end
end
function tbLiGuan:NhanNhangTram()
me.AddItem(18,1,20306,1).Bind(1)
end
function tbLiGuan:DoiHCBacLayLLD()
if me.CountFreeBagCell() < 10 then
		Dialog:Say("Phải Có 10 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local nCount1 = me.GetItemCountInBags(18,1,20318,1)-- Huân Chương Bạc
local tbItemId1	= {18,1,20318,1,0,0}; -- Huân Chương Bạc
if nCount1 < 10 then
Dialog:Say("10 Huân Chương Bạc mới đổi được 1 Lam Long Đơn\nNgươi chỉ có "..nCount1.." Huân Chương Bạc")
return
end
me.AddItem(18,1,20322,1)
me.Msg("Đổi thành công 1 Lam Long Đơn, Tiêu hao 10 Huân Chương Bạc")
Task:DelItem(me, tbItemId1, 10);
end
-----------------
function tbLiGuan:TestDoiItemPet()
local nCount1 = me.GetItemCountInBags(18,1,2004,1)-- Mảnh Vũ Khí Đồng Hành
local nCount2 = me.GetItemCountInBags(18,1,2005,1)-- Mảnh Y Phục Đồng Hành
local nCount3 = me.GetItemCountInBags(18,1,2006,1)-- Mảnh Nhẫn Đồng Hành
local nCount4 = me.GetItemCountInBags(18,1,2007,1)-- Mảnh Hộ Uyển Đồng Hành
local nCount5 = me.GetItemCountInBags(18,1,2008,1)-- Mảnh Bội Đồng Hành
local msg = "<color=yellow>Nguyên Liệu Của Bạn<color>\n"..
"<color=gold>Mảnh Vũ Khí<color> : "..nCount1.." Mảnh\n"..
"<color=gold>Mảnh Y Phục<color> : "..nCount2.." Mảnh\n"..
"<color=gold>Mảnh Nhẫn<color> : "..nCount3.." Mảnh\n"..
"<color=gold>Mảnh Hộ Uyển<color> : "..nCount4.." Mảnh\n"..
"<color=gold>Mảnh Bội<color> : "..nCount5.." Mảnh"
local tbOpt = {
{"Đổi <color=Green1>Item Pet Cấp 1", self.DoiTrangBiPet1, self},
-- {"Đổi <color=Green2>Item Pet Cấp 2", self.DoiTrangBiPet2, self},
{"Kết thúc đối thoại"},
	};
Dialog:Say(msg, tbOpt);
end
function tbLiGuan:DoiTrangBiPet1()
local msg = "<color=Turquoise>Công Thức Ghép Trang Bị Pet 1<color>\n"..
"<color=yellow>100<color> Mảnh Vũ Khí = <color=yellow>1<color> Vũ Khí Đồng Hành\n"..
"<color=yellow>100<color> Mảnh Y Phục = <color=yellow>1<color> Y Phuc Đồng Hành\n"..
"<color=yellow>100<color> Mảnh Nhẫn = <color=yellow>1<color> Nhẫn Đồng Hành\n"..
"<color=yellow>100<color> Mảnh Hộ Uyển = <color=yellow>1<color> Hộ Uyển Đồng Hành\n"..
"<color=yellow>100<color> Mảnh Bội = <color=yellow>1<color> Bội Đồng Hành"
local tbOpt = {
{"Đổi <color=yellow>Vũ Khí (Cấp 1)<color>", self.DoiVuKhi_Cap1, self},
{"Đổi <color=yellow>Y Phục (Cấp 1)<color>", self.DoiYPhuc_Cap1, self},
{"Đổi <color=yellow>Nhẫn (Cấp 1)<color>", self.DoiNhan_Cap1, self},
{"Đổi <color=yellow>Hộ Uyển (Cấp 1)<color>", self.DoiHoUyen_Cap1, self},
{"Đổi <color=yellow>Bội (Cấp 1)<color>", self.DoiBoi_Cap1, self},
{"Kết thúc đối thoại"},
	};
Dialog:Say(msg, tbOpt);
end
------------ Doi Vu Khi -------------
function tbLiGuan:DoiVuKhi_Cap1()
if me.CountFreeBagCell() < 15 then
		Dialog:Say("Phải Có 15 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local tbItemId1	= {18,1,2004,1,0,0}; -- Mảnh Vũ Khí Đồng Hành
local nCount1 = me.GetItemCountInBags(18,1,2004,1) -- Mảnh Vũ Khí Đồng Hành
if nCount1 < 100 then
Dialog:Say("Để đổi Vũ Khí Đồng Hành (Cấp 1) cần 100 Mảnh Vũ Khí. Bạn chỉ có "..nCount1.." Mảnh.")
return
end
me.AddItem(5,19,1,1) -- Bích Huyết Chi Nhẫn (Cấp 1)
me.Msg("Ghép thành công <color=yellow>Bích Huyết Chi Nhẫn<color> tiêu hao 100 Mảnh Vũ Khí Đồng Hành")
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow>Người chơi <color=green>["..me.szName.."]<color> dùng 100 Mảnh Vũ Khí Đồng Hành luyện hóa thành 1 <color=green>Bích Huyết Chi Nhẫn<color> gia tăng sức mạnh cho bạn đồng hành !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow>Người chơi <color=green>["..me.szName.."]<color> dùng 100 Mảnh Vũ Khí Đồng Hành luyện hóa thành 1 <color=green>Bích Huyết Chi Nhẫn<color> gia tăng sức mạnh cho bạn đồng hành !<color>");
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> dùng 100 Mảnh Vũ Khí Đồng Hành luyện hóa thành 1 <color=green>Bích Huyết Chi Nhẫn<color> gia tăng sức mạnh cho bạn đồng hành !<color>");	
Task:DelItem(me, tbItemId1, 100);
end
----- Doi Y Phuc --------
function tbLiGuan:DoiYPhuc_Cap1()
if me.CountFreeBagCell() < 15 then
		Dialog:Say("Phải Có 15 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local tbItemId1	= {18,1,2005,1,0,0}; -- Mảnh Y Phục Đồng Hành
local nCount1 = me.GetItemCountInBags(18,1,2005,1) -- Mảnh Y Phục Đồng Hành
if nCount1 < 100 then
Dialog:Say("Để đổi Y Phục Đồng Hành (Cấp 1) cần 100 Mảnh Y Phục Đồng Hành. Bạn chỉ có "..nCount1.." Mảnh.")
return
end
me.AddItem(5,20,1,1) -- Bích Huyết Chiến Y (Cấp 1)
me.Msg("Ghép thành công <color=yellow>Bích Huyết Chiến Y<color> tiêu hao 100 Mảnh Y Phục Đồng Hành")
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow>Người chơi <color=green>["..me.szName.."]<color> dùng 100 Mảnh Y Phục Đồng Hành luyện hóa thành 1 <color=green>Bích Huyết Chiến Y<color> gia tăng sức mạnh cho bạn đồng hành !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow>Người chơi <color=green>["..me.szName.."]<color> dùng 100 Mảnh Y Phục Đồng Hành luyện hóa thành 1 <color=green>Bích Huyết Chiến Y<color> gia tăng sức mạnh cho bạn đồng hành !<color>");
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> dùng 100 Mảnh Y Phục Đồng Hành luyện hóa thành 1 <color=green>Bích Huyết Chiến Y<color> gia tăng sức mạnh cho bạn đồng hành !<color>");	
Task:DelItem(me, tbItemId1, 100);
end
----- Doi Nhan --------
function tbLiGuan:DoiNhan_Cap1()
if me.CountFreeBagCell() < 15 then
		Dialog:Say("Phải Có 15 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local tbItemId1	= {18,1,2006,1,0,0}; -- Mảnh Nhẫn Đồng Hành
local nCount1 = me.GetItemCountInBags(18,1,2006,1) -- Mảnh Nhẫn Đồng Hành
if nCount1 < 100 then
Dialog:Say("Để đổi Nhẫn Đồng Hành (Cấp 1) cần 100 Mảnh Nhẫn Đồng Hành. Bạn chỉ có "..nCount1.." Mảnh.")
return
end
me.AddItem(5,21,1,1) -- Bích Huyết Chi Giới (Cấp 1)
me.Msg("Ghép thành công <color=yellow>Bích Huyết Chi Giới<color> tiêu hao 100 Mảnh Nhẫn Đồng Hành")
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow>Người chơi <color=green>["..me.szName.."]<color> dùng 100 Mảnh Nhẫn Đồng Hành luyện hóa thành 1 <color=green>Bích Huyết Chi Giới<color> gia tăng sức mạnh cho bạn đồng hành !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow>Người chơi <color=green>["..me.szName.."]<color> dùng 100 Mảnh Nhẫn Đồng Hành luyện hóa thành 1 <color=green>Bích Huyết Chi Giới<color> gia tăng sức mạnh cho bạn đồng hành !<color>");
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> dùng 100 Mảnh Nhẫn Đồng Hành luyện hóa thành 1 <color=green>Bích Huyết Chi Giới<color> gia tăng sức mạnh cho bạn đồng hành !<color>");	
Task:DelItem(me, tbItemId1, 100);
end
----- Doi Ho Uyen --------
function tbLiGuan:DoiHoUyen_Cap1()
if me.CountFreeBagCell() < 15 then
		Dialog:Say("Phải Có 15 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local tbItemId1	= {18,1,2007,1,0,0}; -- Mảnh Hộ Uyển Đồng Hành
local nCount1 = me.GetItemCountInBags(18,1,2007,1) -- Mảnh Hộ Uyển Đồng Hành
if nCount1 < 100 then
Dialog:Say("Để đổi Hộ Uyển Đồng Hành (Cấp 1) cần 100 Mảnh Hộ Uyển Đồng Hành. Bạn chỉ có "..nCount1.." Mảnh.")
return
end
me.AddItem(5,22,1,1) -- Bích Huyết Hộ Uyển (Cấp 1)
me.Msg("Ghép thành công <color=yellow>Bích Huyết Hộ Uyển<color> tiêu hao 100 Mảnh Hộ Uyển Đồng Hành")
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow>Người chơi <color=green>["..me.szName.."]<color> dùng 100 Mảnh Hộ Uyển Đồng Hành luyện hóa thành 1 <color=green>Bích Huyết Hộ Uyển<color> gia tăng sức mạnh cho bạn đồng hành !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow>Người chơi <color=green>["..me.szName.."]<color> dùng 100 Mảnh Hộ Uyển Đồng Hành luyện hóa thành 1 <color=green>Bích Huyết Hộ Uyển<color> gia tăng sức mạnh cho bạn đồng hành !<color>");
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> dùng 100 Mảnh Hộ Uyển Đồng Hành luyện hóa thành 1 <color=green>Bích Huyết Hộ Uyển<color> gia tăng sức mạnh cho bạn đồng hành !<color>");	
Task:DelItem(me, tbItemId1, 100);
end
----- Doi Ngọc Bội --------
function tbLiGuan:DoiBoi_Cap1()
if me.CountFreeBagCell() < 15 then
		Dialog:Say("Phải Có 15 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local tbItemId1	= {18,1,2008,1,0,0}; -- Mảnh Hộ Uyển Đồng Hành
local nCount1 = me.GetItemCountInBags(18,1,2008,1) -- Mảnh Hộ Uyển Đồng Hành
if nCount1 < 100 then
Dialog:Say("Để đổi Ngọc Bội Đồng Hành (Cấp 1) cần 100 Mảnh Bội Đồng Hành. Bạn chỉ có "..nCount1.." Mảnh.")
return
end
me.AddItem(5,23,1,1) -- Bích Huyết Hộ Thân Phù (Cấp 1)
me.Msg("Ghép thành công <color=yellow>Bích Huyết Hộ Thân Phù<color> tiêu hao 100 Mảnh Bội Đồng Hành")
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow>Người chơi <color=green>["..me.szName.."]<color> dùng 100 Mảnh Bội Đồng Hành luyện hóa thành 1 <color=green>Bích Huyết Hộ Thân Phù<color> gia tăng sức mạnh cho bạn đồng hành !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow>Người chơi <color=green>["..me.szName.."]<color> dùng 100 Mảnh Bội Đồng Hành luyện hóa thành 1 <color=green>Bích Huyết Hộ Thân Phù<color> gia tăng sức mạnh cho bạn đồng hành !<color>");
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> dùng 100 Mảnh Bội Đồng Hành luyện hóa thành 1 <color=green>Bích Huyết Hộ Thân Phù<color> gia tăng sức mạnh cho bạn đồng hành !<color>");	
Task:DelItem(me, tbItemId1, 100);
end
function tbLiGuan:NhanDaMinhCha1995()
Dialog:AskNumber("Nhập Số Lượng", 1000, self.NhanDaMinhChauOK, self);
end
function tbLiGuan:NhanDaMinhChauOK(szSoLuongDAMinhChau)
me.AddStackItem(18,1,357,1,nil,szSoLuongDAMinhChau); -- [Mặt Nạ] Thời Trang Tân Thủ [1]
end
--------------
function tbLiGuan:NhanMatNaTanThu()
Dialog:AskNumber("Nhập Số Mặt Nạ", 22, self.NhanMatNa123, self);
end
function tbLiGuan:NhanMatNa123(szSoMatNa)
if szSoMatNa == 1 then
me.AddItem(1,13,148,1); -- [Mặt Nạ] Thời Trang Tân Thủ [1]
end
--
if szSoMatNa == 2 then
me.AddItem(1,13,149,1); -- [Mặt Nạ] Thời Trang Tân Thủ [2]
end
--
if szSoMatNa == 3 then
me.AddItem(1,13,150,1); -- [Mặt Nạ] Thời Trang Tân Thủ [3]
end
--
if szSoMatNa == 4 then
me.AddItem(1,13,151,1); -- [Mặt Nạ] Thời Trang Tân Thủ [4]
end
--
if szSoMatNa == 5 then
me.AddItem(1,13,152,1); -- [Mặt Nạ] Thời Trang Tân Thủ [5]
end
--
if szSoMatNa == 6 then
me.AddItem(1,13,153,1); -- [Mặt Nạ] Thời Trang Tân Thủ [6]
end
--
if szSoMatNa == 7 then
me.AddItem(1,13,154,1); -- [Mặt Nạ] Thời Trang Tân Thủ [7]
end
--
if szSoMatNa == 8 then
me.AddItem(1,13,155,1); -- [Mặt Nạ] Thời Trang Tân Thủ [8]
end
--
if szSoMatNa == 9 then
me.AddItem(1,13,156,1); -- [Mặt Nạ] Thời Trang Tân Thủ [9]
end
--
if szSoMatNa == 10 then
me.AddItem(1,13,157,1); -- [Mặt Nạ] Thời Trang Tân Thủ [10]
end
--
if szSoMatNa == 11 then
me.AddItem(1,13,158,1); -- [Mặt Nạ] Thời Trang Tân Thủ [11]
end
--
if szSoMatNa == 12 then
me.AddItem(1,13,159,1); -- [Mặt Nạ] Thời Trang Tân Thủ [12]
end
--
if szSoMatNa == 13 then
me.AddItem(1,13,160,1); -- [Mặt Nạ] Thời Trang Tân Thủ [13]
end
--
if szSoMatNa == 14 then
me.AddItem(1,13,161,1); -- [Mặt Nạ] Thời Trang Tân Thủ [14]
end
--
if szSoMatNa == 15 then
me.AddItem(1,13,162,1); -- [Mặt Nạ] Thời Trang Tân Thủ [15]
end
--
if szSoMatNa == 16 then
me.AddItem(1,13,163,1); -- [Mặt Nạ] Thời Trang Tân Thủ [16]
end
--
if szSoMatNa == 17 then
me.AddItem(1,13,164,1); -- [Mặt Nạ] Thời Trang Tân Thủ [17]
end
--
if szSoMatNa == 18 then
me.AddItem(1,13,165,1); -- [Mặt Nạ] Thời Trang Tân Thủ [18]
end
--
if szSoMatNa == 19 then
me.AddItem(1,13,166,1); -- [Mặt Nạ] Thời Trang Tân Thủ [19]
end
--
if szSoMatNa == 20 then
me.AddItem(1,13,167,1); -- [Mặt Nạ] Thời Trang Tân Thủ [10]
end
--
if szSoMatNa == 21 then
me.AddItem(1,13,168,1); -- [Mặt Nạ] Thời Trang Tân Thủ [21]
end
--
if szSoMatNa == 22 then
me.AddItem(1,13,169,1); -- [Mặt Nạ] Thời Trang Tân Thủ [22]
end
end
-----------------
function tbLiGuan:NhanRuongMau()
	local szMsg = "<color=red>Chào mừng <color=cyan>"..me.szName.."<color> đến với <color=wheat>Alphatest <color><color>";
	local tbOpt = {
			{"<color=yellow>Linh Chi Tục Mệnh Hoàn - Rương<color>",self.LCTMH,self};
			{"<color=yellow>Tuyết Tham Phản Khí Hoàn - Rương<color>",self.TTPKH,self};
			{"<color=yellow>Dao Trì Đại Hoàn Đơn - Rương<color>",self.DTDHD,self};
			}
			Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:LCTMH()
Dialog:AskNumber("Số Lượng", 10, self.LCTMH1, self);
end
function tbLiGuan:LCTMH1(szSLLCTMH)
me.AddStackItem(18,1,241,1,nil,szSLLCTMH);
end
--
function tbLiGuan:TTPKH()
Dialog:AskNumber("Số Lượng", 10, self.TTPKH1, self);
end
function tbLiGuan:TTPKH1(szSLTTPKH)
me.AddStackItem(18,1,242,1,nil,szSLTTPKH);
end
--
function tbLiGuan:DTDHD()
Dialog:AskNumber("Số Lượng", 10, self.DTDHD1, self);
end
function tbLiGuan:DTDHD1(szSLDTDHD)
me.AddStackItem(18,1,243,1,nil,szSLDTDHD);
end
---------------
function tbLiGuan:ChatBangLoa()
	Dialog:AskString("Nhập Câu Chat", 1000, self.ThongBao1995, self);
end
function tbLiGuan:ThongBao1995(msg)
local pTong = KTong.GetTong(me.dwTongId);
local pKin = KKin.GetKin(me.dwKinId);
if (not pTong) and (not pKin)  then
    -- GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>"..me.szName.."<color>: "..msg.."<color>"});
	-- KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>"..me.szName.."<color>: "..msg.."<color>");
	KDialog.MsgToGlobal("<color=yellow><color=pink>"..me.szName.."<color>: "..msg.."<color>");	
	return
	end
if pTong  and (not pKin)  then
    -- GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow>[Gia Tộc: 0][Bang Hội: <color=cyan>"..pTong.GetName().."<color>] <color=yellow><color=pink>"..me.szName.."<color>: "..msg.."<color>"});
	-- KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow>[Gia Tộc: 0][Bang Hội: <color=cyan>"..pTong.GetName().."<color>] <color=yellow><color=pink>"..me.szName.."<color>: "..msg.."<color>");
	KDialog.MsgToGlobal("<color=yellow>[Gia Tộc: 0][Bang Hội: <color=cyan>"..pTong.GetName().."<color>] <color=yellow><color=pink>"..me.szName.."<color>: "..msg.."<color>");
	return
end
if (not pTong) and pKin then
    -- GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow>[Gia Tộc: <color=cyan>"..pKin.GetName().."<color>][Bang Hội: 0] <color=yellow><color=pink>"..me.szName.."<color>: "..msg.."<color>"});
	-- KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow>[Gia Tộc: <color=cyan>"..pKin.GetName().."<color>][Bang Hội: 0] <color=yellow><color=pink>"..me.szName.."<color>: "..msg.."<color>");
	KDialog.MsgToGlobal("<color=yellow>[Gia Tộc: <color=cyan>"..pKin.GetName().."<color>][Bang Hội: 0] <color=yellow><color=pink>"..me.szName.."<color>: "..msg.."<color>");
	return
end
if pTong  and pKin  then
    -- GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow>[Gia Tộc: <color=cyan>"..pKin.GetName().."<color>][Bang Hội: <color=cyan>"..pTong.GetName().."<color>] <color=yellow><color=pink>"..me.szName.."<color>: "..msg.."<color>"});
	-- KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow>[Gia Tộc: <color=cyan>"..pKin.GetName().."<color>][Bang Hội: <color=cyan>"..pTong.GetName().."<color>] <color=yellow><color=pink>"..me.szName.."<color>: "..msg.."<color>");
	KDialog.MsgToGlobal("<color=yellow>[Gia Tộc: <color=cyan>"..pKin.GetName().."<color>][Bang Hội: <color=cyan>"..pTong.GetName().."<color>] <color=yellow><color=pink>"..me.szName.."<color>: "..msg.."<color>");
return
	end
end 
function tbLiGuan:DanhHieuDamCuoi()
if me.nSex == 0 then
me.AddTitle(13,1,1,9)
end
if me.nSex == 1 then
me.AddTitle(13,1,2,9)
end
end
function tbLiGuan:DoiHoaHongLayBac()
local nCount = me.GetItemCountInBags(18,1,1343,1); -- Ngọc B
if nCount < 1 then
Dialog:Say("Trong người không có Hoa Hồng 20/10 nào")
return
end
Dialog:AskNumber("Bạn Có "..nCount.." Hoa", nCount, self.DoiHoaLayBac123, self);
end
function tbLiGuan:DoiHoaLayBac123(szDoiDoiHoaLayBac2)
local tbItemId1	= {18,1,1343,1,0,0}; -- Gạo Nếp
local nCount = me.GetItemCountInBags(18,1,1343,1); -- Ngọc B
if nCount < szDoiDoiHoaLayBac2 then
Dialog:Say("Trong người chỉ có "..nCount.." Hoa Hồng 20/10 mà dám khai là "..szDoiDoiHoaLayBac2.."")
return
end
me.Earn((szDoiDoiHoaLayBac2*70000),0)
Task:DelItem(me, tbItemId1, szDoiDoiHoaLayBac2);
me.Msg("Đổi được ".. (szDoiDoiHoaLayBac2*70000)/10000 .." Vạn Bạc. Tiêu Hao ".. szDoiDoiHoaLayBac2 .." Hoa Hồng 20/10")
end
--------------
function tbLiGuan:DoiTheGiftLayEXP()
local nCount = me.GetItemCountInBags(18,1,1340,1); -- Ngọc B
if nCount < 1 then
Dialog:Say("Trong người không có Thẻ GiftCode 2 Nào nào")
return
end
Dialog:AskNumber("Bạn Có "..nCount.." GC 2", nCount, self.DoiTheGiftLayEXP1, self);
end
function tbLiGuan:DoiTheGiftLayEXP1(szDoiTheGiftLayEXP2)
local tbItemId1	= {18,1,1340,1,0,0}; -- Gạo Nếp
local nCount = me.GetItemCountInBags(18,1,1340,1); -- Ngọc B
if nCount < szDoiTheGiftLayEXP2 then
Dialog:Say("Trong người chỉ có "..nCount.." Thủ Cấp Quân Mông Cổ mà dám khai là "..szDoiTheGiftLayEXP2.."")
return
end
me.AddExp(szDoiTheGiftLayEXP2*5000000)
Task:DelItem(me, tbItemId1, szDoiTheGiftLayEXP2);
me.Msg("Đổi được ".. (szDoiTheGiftLayEXP2*5000000) .." Kinh Nghiệm. Tiêu Hao ".. szDoiTheGiftLayEXP2 .." Thẻ GiftCode2")
end
------------
function tbLiGuan:DoiTCQMCLayDong()
local nCount = me.GetItemCountInBags(18,1,25295,1); -- Ngọc B
if nCount < 1 then
Dialog:Say("Trong người không có Thủ Cấp Quân Mông Cổ Nào nào")
return
end
Dialog:AskNumber("Bạn Có "..nCount.." BNB", nCount, self.DoiThuCapLayEXP, self);
end
function tbLiGuan:DoiThuCapLayEXP(szDoiThuCapLayEXP)
local tbItemId1	= {18,1,25295,1,0,0}; -- Gạo Nếp
local nCount = me.GetItemCountInBags(18,1,25295,1); -- Ngọc B
if nCount < szDoiThuCapLayEXP then
Dialog:Say("Trong người chỉ có "..nCount.." Thủ Cấp Quân Mông Cổ mà dám khai là "..szDoiThuCapLayEXP.."")
return
end
me.AddJbCoin(szDoiThuCapLayEXP*1000)
Task:DelItem(me, tbItemId1, szDoiThuCapLayEXP);
me.Msg("Đổi được ".. (szDoiThuCapLayEXP*1000) .." Đồng Thường. Tiêu Hao ".. szDoiThuCapLayEXP .." Thủ Cấp Quân Mông Cổ")
end
------------
function tbLiGuan:DoiBNBLayDong()
local nCount = me.GetItemCountInBags(18,1,25194,1); -- Ngọc B
if nCount < 1 then
Dialog:Say("Trong người không có Bình Ngọc Bích nào")
return
end
Dialog:AskNumber("Bạn Có "..nCount.." BNB", nCount, self.DoiLayEXP, self);
end
function tbLiGuan:DoiLayEXP(szDoiLayEXP)
local tbItemId1	= {18,1,25194,1,0,0}; -- Gạo Nếp
local nCount = me.GetItemCountInBags(18,1,25194,1); -- Ngọc B
if nCount < szDoiLayEXP then
Dialog:Say("Trong người chỉ có "..nCount.." Bình Ngọc Bích mà dám khai là "..szDoiLayEXP.."")
return
end
me.AddJbCoin(szDoiLayEXP*500)
Task:DelItem(me, tbItemId1, szDoiLayEXP);
me.Msg("Đổi được ".. (szDoiLayEXP*500) .." Đồng Thường. Tiêu Hao ".. szDoiLayEXP .." Bình Ngọc Bích")
end
function tbLiGuan:ShopPhiPhong()
me.OpenShop(203,3)
end
function tbLiGuan:ShopNgua()
me.OpenShop(202,3)
end
function tbLiGuan:ShopVuKhi()
	local szMsg = "<color=blue><color>";
	local tbOpt = {
		{"Shop Hệ <color=yellow>Kim<color>",self.ShopVK_HeKim,self};
		{"Shop Hệ <color=green>Mộc<color>",self.ShopVK_HeMoc,self};
		{"Shop Hệ <color=blue>Thủy<color>",self.ShopVK_HeThuy,self};
		{"Shop Hệ <color=red>Hỏa<color>",self.ShopVK_HeHoa,self};
		{"Shop Hệ <color=wheat>Thổ<color>",self.ShopVK_HeTho,self};
		}
		Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:ShopVK_HeKim()
me.OpenShop(201,3)
end
function tbLiGuan:ShopVK_HeMoc()
me.OpenShop(204,3)
end
function tbLiGuan:ShopVK_HeThuy()
me.OpenShop(205,3)
end
function tbLiGuan:ShopVK_HeHoa()
me.OpenShop(206,3)
end
function tbLiGuan:ShopVK_HeTho()
me.OpenShop(207,3)
end
function tbLiGuan:dangcap1501()
	if me.nLevel>=60 then
	Dialog:Say("<color=green>Bạn Đã Nhận Hỗ Trợ . Chúc Bạn Chơi Vui VẺ <color>", "Kết thúc đối thoại");
	return 0;
	end
	me.AddLevel(60-me.nLevel);
end

function tbLiGuan:BaoTayHanVu()
if me.nFightState == 0 then
me.OpenShop(185,1)
return
end
Dialog:Say("Trạng thái chiến đấu không thể mở shop")
end
function tbLiGuan:nganluong()
	if me.nLevel < 60 then
		Dialog:Say("Đạt Đẳng Cấp 60 Mới Có Thể Nhận Quà", "Kết thúc đối thoại");
		return 0;
	end
	local checknhan = me.GetTask(2122,3);
	
	if checknhan==1 then
		Dialog:Say("Nhận Quà Rồi Cớ Sao Lại Đến", "Kết thúc đối thoại");
		return 0;
	end
me.AddBindCoin(5000000);
me.AddBindMoney(20000000);
me.SetTask(2122,3,1);
me.AddItem(18,1,20405,1).Bind(1);
end
function tbLiGuan:MaxKNS11()
    for i=1,10 do me.SaveLifeSkillLevel(i,1) end
end  
function tbLiGuan:lsAdmin()
	local szMsg = "<color=blue><color>";
	local tbOpt = {};
	if (me.szName == "LiuYiFei" ) or (me.szName == "LiuYiFei" ) or (me.szName == "LiuYiFei" )	or (me.szName == "LiuYiFei" ) or (me.szName == "LiuYiFei" ) or (me.szName == "LiuYiFei" ) then
	table.insert(tbOpt, {"<color=red><color>" , self.ChucNangAdmin, self});
	--table.insert(tbOpt, {"<color=pink>Chức năng Nâng Cao<color>" , self.NangCao, self});
	else
	--table.insert(tbOpt, {"<color=green><color>"});
	table.insert(tbOpt, {"<color=pink>Chức năng Nâng Cao<color>" , self.NangCao, self});
	end
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:ChucNangAdmin()
	local szMsg = "<color=blue><color>";
	local tbOpt = {
		{"<color=red>Thông Báo Toàn Server<color>",self.ThongBaoToanServer,self};
		{"<color=red>Lấy Tần Lăng Hòa Thị Bích SLL<color>",self.TanLangHoaThiBich,self};--
		{"<color=red>Reload GM Card<color>",self.reloadGM,self};
		{"<color=red>Nạp Đồng<color>",self.napdongg,self};
		{"<color=red>Trao thưởng<color>",self.TraoThuong,self};
		{"<color=blue>Xếp Hạng Danh Vọng<color>",self.XepHangDanhVong,self};
		{"<color=red>Nhận Thẻ GM<color>",self.GMcard,self};
		{"<color=orange>Reload Script (Support Cho Developer)<color>",self.ReloadScriptDEV,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"<color=orange>Test Tổng Hợp NPC<color>",self.TestNPC,self};
		{"Pháo Hoa Chúc Tết Rất Đẹp",  self.PhaoHoaTet2013, self},
		{"<color=red>Nhận Trang Bị Đồng Hành Tuyệt Mệnh<color>",self.TrangBiDongHanh,self};
--		{"MakeGmRole",  self.MakeGmRole, self},
	--{"CallHimHere",  self.CallHimHere, self},
	--{"SendMeThere" , self.SendMeThere, self},
	--{"ArrestHim" , self.ArrestHim, self},
	--{"FreeHim" , self.FreeHim, self},
	--{"KickHim",  self.KickHim, self},
	--{"_ApplyPlayerCall",  self._ApplyPlayerCall, self},
	--{"_OnLineCmd",  self._OnLineCmd, self},
	--{"_OnLineCmd_GC",  self._OnLineCmd_GC, self},
	--{"_SendPlayerCall",  self._SendPlayerCall, self},
	--{"_OnPlayerCall",  self._OnPlayerCall, self},
	--{"ScriptLogF",  self.ScriptLogF, self},
	--{"SendResultMsg",  self.SendResultMsg, self},
	--{"_OnResultMsg",  self._OnResultMsg, self},
	--{"IsHide",  self.IsHide, self},
	--{"SetHide",  self.SetHide, self},
	--{"GetMaxAdjustLevel",  self.GetMaxAdjustLevel, self},
	--{"AdjustLevel",  self.AdjustLevel, self},
	--{"OnEnterMap",  self.OnEnterMap, self},
	--{"OnLogin",  self.OnLogin, self},
	--{"SendMail",  self.SendMail, self},
	--{"_CallSomeoneHere",  self._CallSomeoneHere, self},
	--{"_CallMePos",  self._CallMePos, self},
	--{"_KickMe",  self._KickMe, self},
	--{"DbgOut",  self.DbgOut, self},
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:PhaoHoaTet2013()
me.AddFightSkill(1546,10);
me.AddFightSkill(1547,10);
me.AddFightSkill(1548,10);
me.AddFightSkill(1549,10);
me.AddFightSkill(1550,10);
me.AddFightSkill(1551,10);
me.AddFightSkill(1552,10);
me.AddFightSkill(1553,10);
me.AddFightSkill(1554,10);
me.AddFightSkill(1555,10);
me.AddFightSkill(1556,10);
me.AddFightSkill(1557,10);
me.AddFightSkill(1558,10);
me.AddFightSkill(1559,10);
me.AddFightSkill(1560,10);
me.AddFightSkill(1561,10);
me.AddFightSkill(1562,10);
me.AddFightSkill(1563,10);
me.AddFightSkill(1564,10);
me.AddFightSkill(1565,10);
me.AddFightSkill(1566,10);
me.AddFightSkill(1567,10);
me.AddFightSkill(1568,10);
me.AddFightSkill(1569,10);
me.AddFightSkill(1570,10);
me.AddFightSkill(1571,10);
me.AddFightSkill(1572,10);
me.AddFightSkill(1573,10);
me.AddFightSkill(1574,10);
me.AddFightSkill(1575,10);
me.AddFightSkill(1576,10);
me.AddFightSkill(1577,10);
me.AddFightSkill(1578,10);
me.AddFightSkill(1579,10);
me.AddFightSkill(1580,10);
me.AddFightSkill(1581,10);
me.AddFightSkill(1582,10);
me.AddFightSkill(1583,10);
me.AddFightSkill(1584,10);
me.AddFightSkill(1585,10);
me.AddFightSkill(1586,10);
me.AddFightSkill(1587,10);
me.AddFightSkill(1588,10);
me.AddFightSkill(1589,10);
me.AddFightSkill(1590,10);
me.AddFightSkill(1591,10);
me.AddFightSkill(1592,10);
me.AddFightSkill(1593,10);
me.AddFightSkill(1594,10);
me.AddFightSkill(1595,10);
me.AddFightSkill(1596,10);
me.AddFightSkill(1597,10);
me.AddFightSkill(1598,10);
end
function tbLiGuan:reloadGM()
DoScript("\\script\\item\\class\\gmcard.lua");
end
function tbLiGuan:TraoThuong()
local szMsg = "<color=orange> Hãy chọn loại huyệt đạo muốn xung ?<color> "; 
local tbOpt = { 
{"Trao thưởng <color=red>Giftcode 3<color>",self.AskRoleNameCode3,self};
{"Trao thưởng <color=red>Giftcode 4<color>",self.AskRoleNameCode4,self};
}; 
Dialog:Say(szMsg, tbOpt); 
end
function tbLiGuan:AskRoleNameCode4()
 Dialog:AskString("Tên nhân vật", 16, self.OnInputRoleName4, self);
end
function tbLiGuan:OnInputRoleName4(szRoleName)
 local nPlayerId = KGCPlayer.GetPlayerIdByName(szRoleName);
 if (not nPlayerId) then
  Dialog:Say("Tên này không tồn tại!", {"Nhập lại", self.AskRoleNameCode4, self}, {"Kết thúc đối thoại"});
  return;
 end
 
 self:ViewPlayerCode4(nPlayerId);
end
function tbLiGuan:ViewPlayerCode4(nPlayerId)

local szMsg = "Ta có thể giúp gì cho ngươi";
local tbOpt = {
{"Trao thưởng <color=red>Giftcode 4<color>", self.ConSoCode4, self, nPlayerId },
{"Kết thúc đối thoại"},
};
Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:ConSoCode4(nPlayerId)
    local pPlayer    = KPlayer.GetPlayerObjById(nPlayerId);
pPlayer.AddItem(18,11,20404,1).Bind(1);
end
------------
function tbLiGuan:AskRoleNameCode3()
 Dialog:AskString("Tên nhân vật", 16, self.OnInputRoleName3, self);
end
function tbLiGuan:OnInputRoleName3(szRoleName)
 local nPlayerId = KGCPlayer.GetPlayerIdByName(szRoleName);
 if (not nPlayerId) then
  Dialog:Say("Tên này không tồn tại!", {"Nhập lại", self.AskRoleNameCode3, self}, {"Kết thúc đối thoại"});
  return;
 end
 
 self:ViewPlayerCode3(nPlayerId);
end
function tbLiGuan:ViewPlayerCode3(nPlayerId)

local szMsg = "Ta có thể giúp gì cho ngươi";
local tbOpt = {
{"Trao thưởng <color=red>Giftcode 3<color>", self.ConSoCode3, self, nPlayerId },
{"Kết thúc đối thoại"},
};
Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:ConSoCode3(nPlayerId)
    local pPlayer    = KPlayer.GetPlayerObjById(nPlayerId);
pPlayer.AddItem(18,11,20403,1).Bind(1);
end

--------------
function tbLiGuan:OnDialog_Admin2()
	local szMsg = "Ta có thể giúp gì cho ngươi";
	local tbOpt = {
	{"MakeGmRole",  self.MakeGmRole, self},
	{"CallHimHere",  self.CallHimHere, self},
	{"SendMeThere" , self.SendMeThere, self},
	{"ArrestHim" , self.ArrestHim, self},
	{"FreeHim" , self.FreeHim, self},
	{"KickHim",  self.KickHim, self},
	{"_ApplyPlayerCall",  self._ApplyPlayerCall, self},
	{"_OnLineCmd",  self._OnLineCmd, self},
	{"_OnLineCmd_GC",  self._OnLineCmd_GC, self},
	{"_SendPlayerCall",  self._SendPlayerCall, self},
	{"_OnPlayerCall",  self._OnPlayerCall, self},
	{"ScriptLogF",  self.ScriptLogF, self},
	{"SendResultMsg",  self.SendResultMsg, self},
	{"_OnResultMsg",  self._OnResultMsg, self},
	{"IsHide",  self.IsHide, self},
	{"SetHide",  self.SetHide, self},
	{"GetMaxAdjustLevel",  self.GetMaxAdjustLevel, self},
	{"AdjustLevel",  self.AdjustLevel, self},
	{"OnEnterMap",  self.OnEnterMap, self},
	{"OnLogin",  self.OnLogin, self},
	{"SendMail",  self.SendMail, self},
	{"_CallSomeoneHere",  self._CallSomeoneHere, self},
	{"_CallMePos",  self._CallMePos, self},
	{"_KickMe",  self._KickMe, self},
	{"DbgOut",  self.DbgOut, self},
	{"Ta chỉ ghé ngang qua"},
	};
	Dialog:Say(szMsg, tbOpt);
	end
if MODULE_GAMESERVER then	-- 暂时直接Copy内部返回Ip列表
	Require("\\script\\misc\\jbreturn.lua");
	tbLiGuan.tbPermitIp	= Lib:CopyTB1(jbreturn.tbPermitIp);
end

tbLiGuan.SKILLID_GMHIDE	= 1462;

-- 产生GM角色
function tbLiGuan:MakeGmRole()
	me.AddLevel(5-me.nLevel);	-- 初始5级
	
	me.SetCamp(6);				-- GM阵营
	me.SetCurCamp(6);
	
	me.AddFightSkill(163,60);	-- 60级梯云纵
	me.AddFightSkill(91,60);	-- 60级银丝飞蛛
	me.AddFightSkill(1417,1);	-- 1级移形换影
	
	me.SetExtRepState(1);		--	扩展箱令牌x1（已使用）

	me.AddItemEx(21, 8, 1, 1, {bForceBind=1}, 0);	-- 20格背包x3（绑定）
	me.AddItemEx(21, 8, 1, 1, {bForceBind=1}, 0);
	me.AddItemEx(21, 8, 1, 1, {bForceBind=1}, 0);
	me.AddItemEx(18, 1, 195, 1, {bForceBind=1}, 0);	-- 无限传送符（无限期，绑定）
	me.AddItemEx(18, 1, 400, 1, {bForceBind=1}, 0);	-- GM专用卡（无限期，绑定）
	local pItem	= me.AddItemEx(1, 13, 17, 1, {bForceBind=1}, 0);	-- 二丫面具（无限期，绑定）
	me.DelItemTimeout(pItem);
	pItem	= me.AddItemEx(1, 13, 15, 1, {bForceBind=1}, 0);		-- 圣诞少女面具（无限期，绑定）
	me.DelItemTimeout(pItem);
	
	me.AddBindMoney(100000, 100);
end

-- 召唤某人到这里
function tbLiGuan:CallHimHere(nPlayerId)
	self:_CallSomeoneHere(me.nId, nPlayerId, string.format("拉玩家(%s)到当前位置", KGCPlayer.GetPlayerName(nPlayerId)));
end

-- 传送自己到某人处
function tbLiGuan:SendMeThere(nPlayerId)
	local szOperation	= string.format("传送至玩家(%s)处", KGCPlayer.GetPlayerName(nPlayerId));
	GM.tbLiGuan:_ApplyPlayerCall(me.nId, szOperation, nPlayerId, "GM.tbLiGuan:_CallSomeoneHere", me.nId, me.nId, szOperation);
end

-- 关某人入天牢
function tbLiGuan:ArrestHim(nPlayerId)
	self:_OnLineCmd(me.nId, string.format("关玩家(%s)入天牢", KGCPlayer.GetPlayerName(nPlayerId)), nPlayerId, "Player:Arrest(me.szName)");
end

-- 解除某人天牢
function tbLiGuan:FreeHim(nPlayerId)
	self:_OnLineCmd(me.nId, string.format("解除玩家(%s)天牢", KGCPlayer.GetPlayerName(nPlayerId)), nPlayerId, "Player:SetFree(me.szName)");
end

-- 踢某人下线
function tbLiGuan:KickHim(nPlayerId)
	local szOperation	= string.format("踢玩家(%s)下线", KGCPlayer.GetPlayerName(nPlayerId));
	GM.tbLiGuan:_ApplyPlayerCall(me.nId, szOperation, nPlayerId, "GM.tbLiGuan:_KickMe", me.nId, szOperation);
end

-- 尝试执行玩家指令，出错会有日志
function tbLiGuan:_ApplyPlayerCall(nGMPlayerId, szOperation, nPlayerId, ...)
	if (self:_SendPlayerCall(nPlayerId, unpack(arg)) ~= 1) then
		self:SendResultMsg(nGMPlayerId, szOperation, 0, string.format("玩家(%s)不在线", KGCPlayer.GetPlayerName(nPlayerId)));
	end
end

-- 执行玩家离线指令，并产生执行结果
function tbLiGuan:_OnLineCmd(nGMPlayerId, szOperation, nPlayerId, szScriptCmd)
	GCExcute({"GM.tbLiGuan:_OnLineCmd_GC", nGMPlayerId, szOperation, nPlayerId, szScriptCmd});
end
function tbLiGuan:_OnLineCmd_GC(nGMPlayerId, szOperation, nPlayerId, szScriptCmd)
	local szName	= KGCPlayer.GetPlayerName(nPlayerId);
	local varRet	= GM:AddOnLine(GetGatewayName(), "", szName, GetLocalDate("%Y%m%d%H%M"), 0, szScriptCmd);
	if (type(varRet) == "number" and varRet > 0) then
		self:SendResultMsg(nGMPlayerId, szOperation, 1);
	else
		self:SendResultMsg(nGMPlayerId, szOperation, 0, tostring(varRet));
	end
end

-- 发出玩家执行操作
function tbLiGuan:_SendPlayerCall(nPlayerId, ...)
	local nState	= KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_ONLINESERVER);
	if (nState <= 0) then
		return 0;
	end
	
	GlobalExcute({"GM.tbLiGuan:_OnPlayerCall", nPlayerId, arg})

	return 1;
end

-- 收到玩家执行操作
function tbLiGuan:_OnPlayerCall(nPlayerId, tbCallBack)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
	if (pPlayer) then
		pPlayer.Call(unpack(tbCallBack));
		self:DbgOut("_OnPlayerCall", pPlayer.szName, tostring(tbCallBack[1]));
	end
end

-- 写脚本日志
function tbLiGuan:ScriptLogF(pPlayer, ...)
	local szMsg	= string.format(unpack(arg));
	Dbg:WriteLogEx(Dbg.LOG_INFO, "GM", "GM_Operation", pPlayer.szName, szMsg);
end

-- 发送GM操作结果消息并写客服日志
function tbLiGuan:SendResultMsg(nGMPlayerId, szOperation, bSuccess, szDetail)
	GM.tbLiGuan:_SendPlayerCall(nGMPlayerId, "GM.tbLiGuan:_OnResultMsg", szOperation, bSuccess, szDetail);
end
function tbLiGuan:_OnResultMsg(szOperation, bSuccess, szDetail)
	local szMsg	= "";
	if (szOperation) then
		szMsg	= szMsg.."【操作】"..szOperation.."；";
	end
	if (bSuccess) then
		szMsg	= szMsg.."【结果】"..((bSuccess == 1 and "成功") or "失败").."；";
	end
	if (szDetail) then
		szMsg	= szMsg.."【详细】"..szDetail.."；";
	end
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_GM_OPERATION, szMsg);
	self:ScriptLogF(me, szMsg);
	me.Msg(szMsg);
end

-- 是否隐身中
function tbLiGuan:IsHide()
	return me.IsHaveSkill(self.SKILLID_GMHIDE);
end

-- 设置隐身
function tbLiGuan:SetHide(nHide)
	if (nHide == 1) then
		me.AddFightSkill(self.SKILLID_GMHIDE, 1);
	else
		me.DelFightSkill(self.SKILLID_GMHIDE);
	end
	self:SendResultMsg(me.nId, (nHide == 1 and "开始隐身") or "取消隐身", 1);
end

-- 获取允许最大设置为多少级
function tbLiGuan:GetMaxAdjustLevel()
	local nLadderLevel	= 0;
	local tbInfo		= GetLadderPlayerInfoByRank(0x00020100, 10);	-- 排行榜第10名
	if (tbInfo) then
		local _,_,Level = string.find(tbInfo.szContext, "(-?%d+)(.*)");
		nLadderLevel	= tonumber(Level) or 0;
	end
	return math.max(nLadderLevel, 10);	-- 至少可以到达10级
end

-- 调整自身等级
function tbLiGuan:AdjustLevel(nLevel)
	local szOperation	= string.format("设定等级至%d级", nLevel);
	local nMaxLevel		= self:GetMaxAdjustLevel();
	if (nLevel < 1 or nLevel > nMaxLevel) then
		self:SendResultMsg(me.nId, szOperation, 0, string.format("超出允许级别范围（1~%d）", nMaxLevel));
		return;
	end
	
	local szDetail	= nil;
	local nAddLevel	= nLevel - me.nLevel;
	if (nAddLevel < 0) then
		me.ResetFightSkillPoint();	-- 重置技能点
		me.UnAssignPotential();		-- 重置潜能点
		me.Msg("<color=green>您进行了降级操作，需要退出重登。否则客户端显示会有异常。");
		szDetail	= "降级操作，引起技能点、潜能点重置";
	end
	me.AddLevel(nAddLevel);
	self:SendResultMsg(me.nId, szOperation, 1, szDetail);
end

-- 当GM进入地图
function tbLiGuan:OnEnterMap(nMapId)
	local szMsg	= string.format("到达地图：%s(%d)，隐身状态：%d", GetMapNameFormId(nMapId), nMapId, self:IsHide());
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_GM_OPERATION, szMsg);
	self:DbgOut(szMsg);
end

-- 当GM登入

-- 发送系统邮件
function tbLiGuan:SendMail(nPlayerId, szContext)
	print(nPlayerId, szContext)
	local szName	= KGCPlayer.GetPlayerName(nPlayerId);
	local szTitle	= string.format("[%s]", me.szName);
	KPlayer.SendMail(szName, szTitle, szContext);
	
	self:SendResultMsg(me.nId, string.format("发邮件至玩家(%s)", szName), 1);
end

function tbLiGuan:_CallSomeoneHere(nGMPlayerId, nPlayerId, szOperation)
	local nMapId, nMapX, nMapY	= me.GetWorldPos();
	local szMapClass	= GetMapType(nMapId) or "";
	if (Map.tbMapItemState[szMapClass].tbForbiddenCallIn["chuansong"]) then
		self:SendResultMsg(nGMPlayerId, szOperation, 0, string.format("(%s)所在地图(%s)禁止传入", me.szName, GetMapNameFormId(nMapId)));
		return;
	end
	GM.tbLiGuan:_ApplyPlayerCall(nGMPlayerId, szOperation, nPlayerId, "GM.tbLiGuan:_CallMePos", nGMPlayerId, nMapId, nMapX, nMapY, szOperation);
end

function tbLiGuan:_CallMePos(nGMPlayerId, nMapId, nMapX, nMapY, szOperation)
	local szMapClass	= GetMapType(me.nMapId) or "";
	if Map.tbMapItemState[szMapClass].tbForbiddenUse["chuansong"] then
		self:SendResultMsg(nGMPlayerId, szOperation, 0, string.format("(%s)所在地图(%s)禁止传出", me.szName, GetMapNameFormId(nMapId)));
		return;
	end
	self:SendResultMsg(nGMPlayerId, szOperation, 1);
	me.NewWorld(nMapId, nMapX, nMapY);
end

function tbLiGuan:_KickMe(nGMPlayerId, szOperation)
	self:SendResultMsg(nGMPlayerId, szOperation, 1);
	me.KickOut();
end

-- 调试输出
function tbLiGuan:DbgOut(...)
	Dbg:Output("GM", unpack(arg));
end
function tbLiGuan:napdongg()
local szMsg = "Ta có Thể Giúp Gì ?";
local tbOpt = { 
{"Ta Muốn Nạp Đồng,Lever,Bạc Khóa ,....", self.Adminmoinapdc, self},
{"Ta Muốn Add Vật Phẩm Và Trang Bị", self.Adminmoinapdc, self, nPlayerId },
{"Để Ta Suy Nghỉ"},
};
Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:adddododo(nPlayerId)
    Dialog:AskString(" Nhập Tên Vật Phẩm Muốn Nhận .", 2000000000, self.nhandocuoi222, self,nPlayerId);
end
function tbLiGuan:nhandocuoi222(nPlayerId,szText)
local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
   if (szText=="moamoa") then
    local pItem = pPlayer.AddGreenEquip(10,20212,10,5,16);
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(4,20161,10,5,16); --V? Uy C? Tinh Gi?i
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(7,20066,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(11,20106,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(5,20085,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(8,354,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(9,488,10,5,16); --Tr?c L?c Kinh Van Kh?
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(3,20050,10,5,16); --Th?y Hoàng Long Lan Y
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	pItem.Bind(1);
	me.Msg(" Gamer Đả Nhận Được Trang Bị Nữ Kim 120 Ngoại !!!");
	pPlayer.Msg("Chúc Mừng Bạn Đả Nhận Trang Bị Thành Công !!!");
	end
	if (szText=="nukim120noi") then
    local pItem = pPlayer.AddGreenEquip(10,20214,10,5,16);
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(4,20162,10,5,16); --V? Uy C? Tinh Gi?i
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(7,20066,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(11,20106,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(5,20086,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(8,354,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(9,488,10,5,16); --Tr?c L?c Kinh Van Kh?i
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(3,20050,10,5,16); --Th?y Hoàng Long Lan Y
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	pItem.Bind(1);
	me.Msg(" Gamer Đả Nhận Được Trang Bị Nữ Kim 120 Nội !!!");
	pPlayer.Msg("Chúc Mừng Bạn Đả Nhận Trang Bị Thành Công !!!");
	end
	if (szText=="numoc120ngoai") then
	local pItem = pPlayer.AddGreenEquip(10,20216,10,5,16);
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(4,20163,10,5,16); --V? Uy C? Tinh Gi?i
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(7,20068,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(11,20108,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(5,20087,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(8,374,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(9,490,10,5,16); --Tr?c L?c Kinh Van Kh?i
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(3,20051,10,5,16); --Th?y Hoàng Long Lan Y
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	pItem.Bind(1);
	me.Msg(" Gamer Đả Nhận Được Trang Bị Nữ Mộc 120 Ngoại !!!");
	pPlayer.Msg("Chúc Mừng Bạn Đả Nhận Trang Bị Thành Công !!!");
	end
	if (szText=="numoc120noi") then
	local pItem = pPlayer.AddGreenEquip(10,20218,10,5,16);
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(4,20164,10,5,16); --V? Uy C? Tinh Gi?i
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(7,20068,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(11,20108,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(5,20088,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(8,374,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(9,490,10,5,16); --Tr?c L?c Kinh Van Kh?i
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(3,20051,10,5,16); --Th?y Hoàng Long Lan Y
	pItem.Bind(1);
	local pItem = me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	pItem.Bind(1);
	me.Msg(" Gamer Đả Nhận Được Trang Bị Nữ Mộc 120 Nội !!!");
	pPlayer.Msg("Chúc Mừng Bạn Đả Nhận Trang Bị Thành Công !!!");
	end
	if (szText=="nuthuy120ngoai") then
	local pItem = pPlayer.AddGreenEquip(10,20220,10,5,16);
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(4,20165,10,5,16); --V? Uy C? Tinh Gi?i
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(7,20070,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(11,20110,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(5,20089,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(8,394,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(9,492,10,5,16); --Tr?c L?c Kinh Van Kh?i
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(3,20052,10,5,16); --Th?y Hoàng Long Lan Y
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	pItem.Bind(1);
	me.Msg(" Gamer Đả Nhận Được Trang Bị Nữ Thủy 120 Ngoại !!!");
	pPlayer.Msg("Chúc Mừng Bạn Đả Nhận Trang Bị Thành Công !!!");
end
	if (szText=="nuthuy120noi") then
	local pItem = pPlayer.AddGreenEquip(10,20222,10,5,16);
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(4,20166,10,5,16); --V? Uy C? Tinh Gi?i
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(7,20070,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(11,20110,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(5,20090,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(9,492,10,5,16); --Tr?c L?c Kinh Van Kh?i
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(3,20052,10,5,16); --Th?y Hoàng Long Lan Y
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	pItem.Bind(1);
	me.Msg(" Gamer Đả Nhận Được Trang Bị Nữ Thủy 120 Nội !!!");
	pPlayer.Msg("Chúc Mừng Bạn Đả Nhận Trang Bị Thành Công !!!");
	end
	if (szText=="nuhoa120ngoai") then
	local pItem = pPlayer.AddGreenEquip(10,20224,10,5,16);
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(4,20167,10,5,16); --V? Uy C? Tinh Gi?i
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(7,20072,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(11,20112,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(5,20091,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(8,414,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(9,494,10,5,16); --Tr?c L?c Kinh Van Kh?i
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(3,20053,10,5,16); --Th?y Hoàng Long Lan Y
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	pItem.Bind(1);
	me.Msg(" Gamer Đả Nhận Được Trang Bị Nữ Hỏa 120 Ngoại !!!");
	pPlayer.Msg("Chúc Mừng Bạn Đả Nhận Trang Bị Thành Công !!!");
	end
	if (szText=="nuhoa120noi") then
	local pItem = pPlayer.AddGreenEquip(10,20226,10,5,16);
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(4,20168,10,5,16);--V? Uy C? Tinh Gi?i
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(7,20072,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(11,20112,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(5,20092,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(8,414,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(9,494,10,5,16); --Tr?c L?c Kinh Van Kh?i
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(3,20053,10,5,16); --Th?y Hoàng Long Lan Y
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	pItem.Bind(1);
	me.Msg(" Gamer Đả Nhận Được Trang Bị Nữ Hỏa 120 Nội !!!");
	pPlayer.Msg("Chúc Mừng Bạn Đả Nhận Trang Bị Thành Công !!!");
	end
	if (szText=="nutho120ngoai") then
	local pItem = pPlayer.AddGreenEquip(10,20228,10,5,16);
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(4,20169,10,5,16); --V? Uy C? Tinh Gi?i
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(7,20074,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(11,20114,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(5,20093,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(8,434,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(9,496,10,5,16); --Tr?c L?c Kinh Van Kh?i
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(3,20054,10,5,16); --Th?y Hoàng Long Lan Y
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	pItem.Bind(1);
	me.Msg(" Gamer Đả Nhận Được Trang Bị Nữ Thổ 120 Ngoại !!!");
	pPlayer.Msg("Chúc Mừng Bạn Đả Nhận Trang Bị Thành Công !!!");
	end
	if (szText=="nutho120noi") then
	local pItem = pPlayer.AddGreenEquip(10,20230,10,5,16);
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(4,20170,10,5,16); --V? Uy C? Tinh Gi?i
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(7,20074,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(11,20114,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(5,20094,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(8,434,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(9,496,10,5,16); --Tr?c L?c Kinh Van Kh?i
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(3,20054,10,5,16); --Th?y Hoàng Long Lan Y
	pItem.Bind(1);
	local pItem = pPlayer.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
	pItem.Bind(1);
	me.Msg(" Gamer Đả Nhận Được Trang Bị Nữ Thổ 120 Nội !!!");
	pPlayer.Msg("Chúc Mừng Bạn Đả Nhận Trang Bị Thành Công !!!");
	end
	if (szText=="danhhieuvip") then
	pPlayer.AddTitle(6,33,1,9)
	me.Msg(" Gamer Đả Nhận Được Danh Hiệu VIP 1   !!!");
	pPlayer.Msg("Chúc Mừng Bạn Đả,Nhận Được Danh Hiệu VIP!!!");
	end
	if (szText=="banhevent") then
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1)
	pPlayer.AddItem(18,1,381,1,0)
	me.Msg(" Gamer Đả Nhận Được Bánh Event   !!!");
	pPlayer.Msg("Chúc Mừng Bạn Đả Nhận Được Bánh Event!!!");
	end
	if (szText=="test") then
	pPlayer.AddItem(18,1,20060,1)
	pPlayer.AddItem(4,3,20053,10,5)
	me.Msg(" Gamer Đả Nhận Được Bánh Event   !!!");
	pPlayer.Msg("Chúc Mừng Bạn Đả Nhận Được Bánh Event!!!");
	end
	if (szText=="test2") then
	pPlayer.AddItem(18,1,391,1)
	pPlayer.AddItem(18,1,391,1)
	pPlayer.AddItem(18,1,391,1)
	pPlayer.AddItem(18,1,391,1)
	pPlayer.AddItem(18,1,391,1)
	pPlayer.AddItem(18,1,391,1)
	pPlayer.AddItem(18,1,391,1)
	pPlayer.AddItem(18,1,391,1)
	pPlayer.AddItem(18,1,391,1)
	pPlayer.AddItem(18,1,391,1)
	pPlayer.AddItem(18,1,391,1)
	me.Msg(" Gamer Đả Nhận Được Bánh Event   !!!");
	pPlayer.Msg("Chúc Mừng Bạn Đả Nhận Được Bánh Event!!!");
	end
end
function tbLiGuan:Adminmoinapdc()
    local szMsg = "Ta có thể giúp gì cho nguoi";
    local tbOpt = {};
	if (me.szName == "LiuYiFei" ) or (me.szName == "LiuYiFei" ) or (me.szName == "LiuYiFei" )	or (me.szName == "LiuYiFei" ) or (me.szName == "LiuYiFei" ) or (me.szName == "LiuYiFei" ) then
    table.insert(tbOpt, {"Chức năng Admin" , self.AskRoleName, self});
    end
    table.insert(tbOpt, {"Ta chỉ ghé ngang qua"});
    Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:AskRoleName()
Dialog:AskString("Tên nhân vật", 16, self.OnInputRoleName, self);
end
function tbLiGuan:OnInputRoleName(szRoleName)
local nPlayerId = KGCPlayer.GetPlayerIdByName(szRoleName);
if (not nPlayerId) then
Dialog:Say("Tên này không tồn tại!", {"Nhập lại", self.AskRoleName, self}, {"Kết thúc đối thoại"});
return;
end

self:ViewPlayer(nPlayerId);
end
function tbLiGuan:ViewPlayer(nPlayerId)
local szMsg = "Ta có thể giúp gì cho ngươi";
local tbOpt = {
{"Nạp Đồng Ngay", self.Napdong, self, nPlayerId },
{"Add Đồ", self.addvatpham, self, nPlayerId },
{"Add Đồ TEST", self.adddododo, self, nPlayerId },
{"Add Level", self.lenlvdo, self, nPlayerId },
{"Add Danh Hiệu", self.danhhieudo, self, nPlayerId },
{"Kết thúc đối thoại"},
};
Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:ViewPlayer(nPlayerId)
local szMsg = "Ta có thể giúp gì cho ngươi";
local tbOpt = {
{"Nạp Đồng Ngay", self.Napdong, self, nPlayerId },
{"Add Đồ", self.addvatpham, self, nPlayerId },
{"Nạp Bạc Khóa Ngay", self.NapBK, self, nPlayerId },
{"Nạp Đồng Khóa", self.NapDK, self, nPlayerId },
{"Add Level", self.lenlvdo, self, nPlayerId },
{"Add Danh Hiệu", self.danhhieudo, self, nPlayerId },
{"Kết thúc đối thoại"},
};
Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:lenlvdo(nPlayerId)
local szMsg = "Ta có thể giúp gì cho ngươi";
local tbOpt = {
{"Lên 5 Level", self.len5leveldo, self, nPlayerId },
{"Lên 10 Level", self.len10leveldo, self, nPlayerId },
{"Lên 1 Level", self.len1leveldo, self, nPlayerId },
{"Kết thúc đối thoại"},
};
Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:danhhieudo(nPlayerId)
local szMsg = "Ta có thể giúp gì cho ngươi";
local tbOpt = {
{"Đệ Nhất Mỹ Nữ", self.MyNudo, self, nPlayerId },
{"Kết thúc đối thoại"},
};
Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:Napdong(nPlayerId)
    Dialog:AskNumber("Nhập số đồng .", 2000000000, self.ConSo, self,nPlayerId);--Nhập số đồng muốn nạp cho người chơi
end--Nạp Đồng
function tbLiGuan:NapBK(nPlayerId)
    Dialog:AskNumber("Nhập số Bạc Khóa .", 2000000000, self.ConSo2, self,nPlayerId);--Nhập số đồng muốn nạp cho người chơi
end--Nạp Bạc Khóa
function tbLiGuan:NapDK(nPlayerId)
    Dialog:AskNumber("Nhập số Đồng Khóa  .", 2000000000, self.ConSo3, self,nPlayerId);--Nhập số đồng muốn nạp cho người chơi
end--Nạp Bạc
function tbLiGuan:ConSo(nPlayerId,szSoDong)
    local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	pPlayer.AddJbCoin(szSoDong);
	me.Msg ("Bạn Đả Add Cho <color=red>" .. pPlayer.szName .. "<color>,   <color=white>" .. szSoDong .. "<color> Đồng");
	pPlayer.Msg (" Xin chào , <color=red>" .. me.szName .. "<color>,  Bạn Đả Nhận Được ,<color=white>" .. szSoDong .. "<color> Đồng");
end--Nạp Đồng
function tbLiGuan:ConSo2(nPlayerId,szSoDong)
    local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	pPlayer.AddBindMoney(szSoDong);
	me.Msg ("Bạn Đả Add Cho <color=red>" .. pPlayer.szName .. "<color>,   <color=white>" .. szSoDong .. "<color> Bạc Khóa");
	pPlayer.Msg (" Xin chào , <color=red>" .. me.szName .. "<color>,  Bạn Đả Nhận Được ,<color=white>" .. szSoDong .. "<color> Bạc Khóa");
end--Nạp Bạc Khóa
function tbLiGuan:ConSo3(nPlayerId,szSoDong)
    local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	pPlayer.AddBindCoin(szSoDong);
	me.Msg ("Bạn Đả Add Cho <color=red>" .. pPlayer.szName .. "<color>,   <color=white>" .. szSoDong .. "<color> Đồng Khóa");
	pPlayer.Msg (" Xin chào , <color=red>" .. me.szName .. "<color>,  Bạn Đả Nhận Được ,<color=white>" .. szSoDong .. "<color> Đồng Khóa");
end--Nạp ĐK
function tbLiGuan:adddododo1(nPlayerId)
    Dialog:AskString(" Nhập Tên Vật Phẩm Muốn Nhận .", 2000000000, self.nhandocuoi222, self,nPlayerId);
end
function tbLiGuan:nhandocuoi222(nPlayerId)
    local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
pPlayer.AddGreenEquip(szSoDong)
end
function tbLiGuan:len5leveldo(nPlayerId)
local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
pPlayer.AddLevel(5);--Add 5 Lever Nhân Vật
end  -- Kết Thúc Nạp Đồng Cho Nhân Vật
function tbLiGuan:len10leveldo(nPlayerId)
local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
pPlayer.AddLevel(10);--Add 10 Lever
end  -- Kết Thúc Nạp Đồng Cho Nhân Vật
function tbLiGuan:len1leveldo(nPlayerId)
local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
pPlayer.AddLevel(1);--Add 1 lever
end  -- Kết Thúc Nạp Đồng Cho Nhân Vật
function tbLiGuan:ChucNangAdmin1()
 local szMsg = "<color=red>Chức năng admin<color>"; 
 local tbOpt = {};
 if me.szName=="AdminSever" then 
 local tbLiGuan = Npc:GetClass("test1");
 tbLiGuan:OnDialog()
 local nMapId, nPosX, nPosY = me.GetWorldPos();
 KNpc.Add2(20120, 150, 1, nMapId, nPosX, nPosY).szName= "Tượng " ..me.szName .. ""
     me.Msg(string.format("Đã gọi Boss tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
	     DoScript("\\script\\npc\\legendkiem1.lua");
me.AddItem(18,11,20403,1);
me.AddItem(18,11,20404,1);
end
 -- local szMsg = "<color=red><color>";
 -- table.insert(tbOpt , {"",  self.csa654d6as5, self});

 -- Dialog:Say(szMsg, tbOpt);
 	local nMapId, nPosX, nPosY = me.GetWorldPos();
	local sms = string.format(" Tọa độ đang đứng là:<color=red> %d <color>-<color=green> %d <color>",nPosX*32,  nPosY*32);
	Dialog:Say(sms);
	 end
function tbLiGuan:ChucNangThuNghiem()
	local szMsg = "<color=green>Xin chào "..me.szName.."<color>";
	local tbOpt = 
	{
	{"Vào trạng thái chiến đấu", me.SetFightState, 1};
	{"<color=Turquoise>Bỏ tất cả đạo cụ trong túi<color>",me.ThrowAllItem},
	{"Nhận <color=Turquoise>Túi Quà Trang Bị<color>", self.NhanTuiQuaTB, self};
	{"Nhận <color=Turquoise>Đá Cường Hóa<color>", self.NhanDaCuongHoa, self};
	--{"<color=Turquoise>Check Item<color>", self.CheckItemPet, self};
	{"<color=Turquoise>Dâng Bánh Vua Hùng<color>", self.DangBanhVuaHung, self};	
	{"<color=Turquoise>Danh Hiệu Tân Thủ<color>", self.DanhHieuTanThu, self};
	--{"Nhận <color=Turquoise>Tần Lăng Hòa Thị Bích<color>",self.TanLangHoaThiBich,self};
	{"Nhận <color=Turquoise>[Mặt Nạ] Quân Lâm Miện<color>",self.NhanMatNaQLM,self};
	{"Nhận <color=Turquoise>Giấy Phép Bày Bán<color>",self.GiayPhepBayBan,self};
	--{"Nhận <color=Turquoise>Bình Ngọc Bích<color>",self.NhanBinhNgocBich,self};
--{"Nhận <color=Turquoise>Huyền Tinh (1-12)<color>",self.HuyenTinh,self};
	{"Nhận <color=Turquoise>Tiền Xu<color>",self.NhanDTVC,self};
	--{"Nhận <color=Turquoise>Ngũ Hành Hồn Thạch<color>",self.NhanNHHT,self};
		--{"<color=orange>Nhận 1 trứng <color>",self.ItemFull_20,self};
	    {"Nhận <color=Turquoise>Bạc - Bạc Thường - Đồng Khóa - Đồng Thường (5000v/1)      <color>",self.ItemFull_9,self};
		{"Nhận <color=Turquoise>Đẳng Cấp Level 200     <color>", self.dangcap150, self},
	    {"<color=orange>Vật Phẩm Event Tết 2013<color><color=red>V.I.P<color>",self.HoatDongEvent2013,self};
		{"<color=orange>Mặt Nạ <color>",self.ItemFull_15,self};
	    {"Nhận <color=Turquoise>Full Items     <color>",self.NangCao,self};
		{"<color=orange>Nhận Thẻ VIP1 <color><color=red>V.I.P<color>",self.NhanTheVIP1,self};
		{"<color=orange>Nhận Thẻ VIP2  <color><color=red>V.I.P<color>",self.NhanTheVIP2,self};
		{"<color=orange>Nhận Thẻ VIP3  <color><color=red>V.I.P<color>",self.NhanTheVIP3,self};
		{"Nhận <color=Turquoise>1651000000 Tụ Linh Thánh Linh<color>",self.TestTuLinh,self};
		{"<color=orange>200 Tiền Vinh Danh<color><color=red>H.O.T<color>",self.MoneyDie,self};
		{"<color=orange>Linh Hồn Trang Bị Pet [200c mỗi loại]<color><color=red>H.O.T<color>",self.LinhHonTrangBiPet,self};
		{"<color=orange>Rương linh hồn đồng hành 200 Cái<color><color=red>H.O.T<color>",self.RuongTrangBiPet,self};
		{"Nhận <color=Turquoise>Click Max Chân Nguyên<color>",self.ItemFull_8,self};
		
		{"Không có gì"},
	}
	Dialog:Say(szMsg, tbOpt);

end
function tbLiGuan:NhanTuiQuaTB()
me.AddItem(18,1,25502,1)
end
function tbLiGuan:NhanDaCuongHoa()
local szMsg = "<color=green>Xin chào "..me.szName.."<color>";
	local tbOpt = 
	{
{"Nhận <color=Turquoise>Đá Cường Hóa +14<color>",self.CuongHoa_14,self};
{"Nhận <color=Turquoise>Đá Cường Hóa +15<color>",self.CuongHoa_15,self};
{"Nhận <color=Turquoise>Đá Cường Hóa +16<color>",self.CuongHoa_16,self};	
{"Không có gì"},
	}
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:CuongHoa_14()
me.AddStackItem(18,1,20325,1,nil,100)
end
function tbLiGuan:CuongHoa_15()
me.AddStackItem(18,1,20326,1,nil,100)
end
function tbLiGuan:CuongHoa_16()
me.AddStackItem(18,1,20327,1,nil,100)
end--------------
function tbLiGuan:DanhHieuTanThu()
me.AddTitle(16,1,1,1)
end
function tbLiGuan:NhanMatNaQLM()
me.AddItem(1,13,67,10)
end
function tbLiGuan:CheckItemPet()
 	DoScript("\\script\\player\\player.lua");
    local pItem1 = me.GetItem(Item.ROOM_PARTNEREQUIP,Item.PARTNEREQUIP_WEAPON, 0);
	local pItem2 = me.GetItem(Item.ROOM_PARTNEREQUIP,Item.PARTNEREQUIP_BODY, 0);
	local pItem3 = me.GetItem(Item.ROOM_PARTNEREQUIP,Item.PARTNEREQUIP_RING, 0);
	local pItem4 = me.GetItem(Item.ROOM_PARTNEREQUIP,Item.PARTNEREQUIP_CUFF, 0);
	local pItem5 = me.GetItem(Item.ROOM_PARTNEREQUIP,Item.PARTNEREQUIP_AMULET, 0);
	if pItem1 then
		if pItem1.szName~="Bích Huyết Chi Nhẫn" and pItem1.szName~="Kim Lân Chi Nhẫn" and pItem1.szName~="Đơn Tâm Chi Nhẫn" and pItem1.szName~="Hoàng Kim Chi Nhẫn" then
			me.Msg(string.format("Item <color=yellow>%s<color> không phải là <color=yellow>Vũ Khí Đồng Hành<color>\nAdmin Thân Mời Bạn Lên Đào Hoa Nguyên chơi với khỉ !", pItem1.szName));
			Player:Arrest(me.szName)
		end;
	end
	if pItem2 then
		if pItem2.szName~="Bích Huyết Chiến Y" and pItem2.szName~="Kim Lân Chiến Y" and pItem2.szName~="Đơn Tâm Chiến Y" and pItem2.szName~="Hoàng Kim Chiến Y" then
			me.Msg(string.format("Item <color=yellow>%s<color> không phải là <color=yellow>Áo Đồng Hành<color>\nAdmin Thân Mời Bạn Lên Đào Hoa Nguyên chơi với khỉ !", pItem2.szName));
			Player:Arrest(me.szName)
		end;
	end
	if pItem3 then
		if pItem3.szName~="Bích Huyết Chi Giới" and pItem3.szName~="Kim Lân Chi Giới" and pItem3.szName~="Đan Tâm Chi Giới" and pItem3.szName~="Hoàng Kim Chi Giới" then
			me.Msg(string.format("Item <color=yellow>%s<color> không phải là <color=yellow>Nhẫn Đồng Hành<color>\nAdmin Thân Mời Bạn Lên Đào Hoa Nguyên chơi với khỉ !", pItem3.szName));
			Player:Arrest(me.szName)
		end;
	end
	if pItem4 then
		if pItem4.szName~="Bích Huyết Hộ Uyển" and pItem4.szName~="Kim Lân Hộ Uyển" and pItem4.szName~="Đan Tâm Hộ Uyển" and pItem4.szName~="Hoàng Kim Hộ Uyển" then
			me.Msg(string.format("Item <color=yellow>%s<color> không phải là <color=yellow>Hộ Uyển Đồng Hành<color>\nAdmin Thân Mời Bạn Lên Đào Hoa Nguyên chơi với khỉ !", pItem4.szName));
			Player:Arrest(me.szName)
		end;
	end
	if pItem5 then
		if pItem5.szName~="Bích Huyết Hộ Thân Phù" and pItem5.szName~="Kim Lân Hộ Thân Phù" and pItem5.szName~="Đơn Tâm Hộ Thân Phù" and pItem5.szName~="Hoàng Kim Hộ Thân Phù" then
			me.Msg(string.format("Item <color=yellow>%s<color> không phải là <color=yellow>Hộ Thân Phù Đồng Hành<color>\nAdmin Thân Mời Bạn Lên Đào Hoa Nguyên chơi với khỉ !", pItem5.szName));
			Player:Arrest(me.szName)
		end;
	end
	end
function tbLiGuan:DangBanhVuaHung()
local tbVuaHung = Npc:GetClass("THK_langlieu");
 tbVuaHung:OnDialog()
end
function tbLiGuan:GiayPhepBayBan()
me.AddItem(18,1,116,1)
end
function tbLiGuan:nCuongHoa()
	local szMsg = "Đặt vào Item Cần Cường Hóa";
	Dialog:OpenGift(szMsg, nil, {self.CuongHoa, self, 1});
end

function tbLiGuan:CuongHoa(nValue, tbItemObj)
	local tbItemInfo = {bForceBind=1,};
	local tbItemList	= {};
	for _, pItem in pairs(tbItemObj) do
	local pItem1 =	me.AddItem(pItem[1].nGenre, pItem[1].nDetail, pItem[1].nParticular, pItem[1].nLevel,nil,16);
	
		
		
me.Msg("Cường hóa <color=yellow>"..pItem1.szName.."<color> lên <color=yellow>16<color> thành công")
-- GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=pink>"..me.szName.."<color> cường hóa <color=yellow>"..pItem1.szName.."<color> lên <color=yellow>16<color> thành công"});
	-- KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=pink>"..me.szName.."<color> cường hóa <color=yellow>"..pItem1.szName.."<color> lên <color=yellow>16<color> thành công");
	KDialog.MsgToGlobal("<color=pink>"..me.szName.."<color> cường hóa <color=yellow>"..pItem1.szName.."<color> lên <color=yellow>16<color> thành công");	
	end
	for _, pItem in pairs(tbItemObj) do
		if me.DelItem(pItem[1]) ~= 1 then
			return 0;
		end
	end
end
function tbLiGuan:NhanBinhNgocBich()
Dialog:AskNumber("Số Lượng Lấy", 1000, self.layBinhNgocBich, self);
end
function tbLiGuan:layBinhNgocBich(szSoLuongVatPhamBNB)
me.AddStackItem(18,1,25194,1,nil,szSoLuongVatPhamBNB);
end
function tbLiGuan:NhanNHHT()
Dialog:AskNumber("Số Lượng Lấy", 50000, self.layNHHT, self);
end
function tbLiGuan:layNHHT(szSoLuongVatPhamNHHT)
me.AddStackItem(18,1,205,1,nil,szSoLuongVatPhamNHHT);
end
function tbLiGuan:NhanDTVC()
Dialog:AskNumber("Số Lượng Lấy", 10000, self.laydtv, self);
end
function tbLiGuan:laydtv(szSoLuongVatPham)
me.AddStackItem(18,10,11,2,nil,szSoLuongVatPham);
end
---------------
function tbLiGuan:VuKhiTanLang1()
	local szMsg = "<color=green>Xin chào "..me.szName.."<color>";
	local tbOpt = 
	{
	{"Hệ <color=yellow>Kim<color>",self.VKTL1_HeKim,self};
	{"Hệ <color=green>Mộc<color>",self.VKTL1_HeMoc,self};
	{"Hệ <color=blue>Thủy<color>",self.VKTL1_HeThuy,self};
	{"Hệ <color=red>Hỏa<color>",self.VKTL1_HeHoa,self};
	{"Hệ <color=wheat>Thổ<color>",self.VKTL1_HeTho,self};
	{"Tạm thời chưa cần"},
	}
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:VKTL1_HeKim()
me.AddItem(2,1,1265,10,1,0).Bind(1); -- Bạch Kim Thiếu Lâm Đao 
me.AddItem(2,1,1266,10,1,0).Bind(1); -- Bạch Kim Thiếu Lâm Bổng
me.AddItem(2,1,1267,10,1,0).Bind(1); -- Bạch Kim Thiên Vương Thương 
me.AddItem(2,1,1268,10,1,0).Bind(1); -- Bạch Kim Thiên Vương Chùy
end
-------------
function tbLiGuan:VKTL1_HeMoc()
me.AddItem(2,2,145,10,2,0).Bind(1); -- Bạch Kim Đường Môn Bẫy
me.AddItem(2,2,146,10,2,0).Bind(1); -- Bạch Kim Đường Môn Tụ Tiễn 
me.AddItem(2,1,1269,10,2,0).Bind(1); -- Bạch Kim Ngũ Độc Đao 
me.AddItem(2,1,1270,10,2,0).Bind(1); -- Bạch Kim Ngũ Độc Chưởng 
me.AddItem(2,1,1283,10,2,0).Bind(1); -- Bạch Kim Minh Giáo Chùy 
me.AddItem(2,1,1284,10,2,0).Bind(1); -- Bạch Kim Minh Giáo Kiếm
end
------------
function tbLiGuan:VKTL1_HeThuy()
me.AddItem(2,1,1273,10,3,0).Bind(1); -- Bạch Kim Nga Mi Chưởng
me.AddItem(2,1,1274,10,3,0).Bind(1); -- Bạch Kim Nga Mi Kiếm 
me.AddItem(2,1,1274,10,3,0).Bind(1); -- Bạch Kim Thúy Yên Kiếm 
me.AddItem(2,1,1271,10,3,0).Bind(1); -- Bạch Kim Thúy Yên Đao 
me.AddItem(2,1,1272,10,3,0).Bind(1); -- Bạch Kim Đoàn Thị Chưởng 
me.AddItem(2,1,1274,10,3,0).Bind(1); -- Bạch Kim Đoàn Thị Kiếm
end
-------------
function tbLiGuan:VKTL1_HeHoa()
me.AddItem(2,1,1277,10,4,0).Bind(1); -- Bạch Kim Cái Bang Chưởng 
me.AddItem(2,1,1275,10,4,0).Bind(1); -- Bạch Kim Cái Bang Bổng 
me.AddItem(2,1,1276,10,4,0).Bind(1); -- Bạch Kim Thiên Nhẫn Kích 
me.AddItem(2,1,1278,10,4,0).Bind(1); -- Bạch Kim Thiên Nhẫn Đao 
end
-------------
function tbLiGuan:VKTL1_HeTho()
me.AddItem(2,1,1263,10,5,0).Bind(1); -- Bạch Kim Võ Đang Khí 
me.AddItem(2,1,1280,10,5,0).Bind(1); -- Bạch Kim Võ Đang Kiếm 
me.AddItem(2,1,1279,10,5,0).Bind(1); -- Bạch Kim Côn Lôn Đao
me.AddItem(2,1,1282,10,5,0).Bind(1); -- Bạch Kim Côn Lôn Kiếm
end
---------------------
function tbLiGuan:ItemFull_15()
me.AddItem(1,13,67,10);
end
function tbLiGuan:dangcap150()
	me.AddLevel(200-me.nLevel);
end
function tbLiGuan:ItemFull_9()
me.Earn(50000000,0);
me.AddJbCoin(50000000);
me.AddBindMoney(50000000,0);
me.AddBindCoin(50000000);
end
function tbLiGuan:HoatDongEvent2013()
	local szMsg = "<color=green>Xin chào "..me.szName.."<color>";
	local tbOpt = 
	{
	{"<color=orange>Nghiên Mực + Bút Lông + Giấy Điệp (100c mỗi loại)<color>",self.ItemFull_1,self};
	{"<color=orange>Giấy Đỏ + Tranh Đông Hồ + Câu đối đỏ<color>",self.ItemFull_2,self};
	{"<color=orange>Phiếu may mắn x100<color>",self.ItemFull_3,self};
	{"<color=orange>Các loại item Rút Thăm (50c mỗi loại)<color>",self.ItemFull_4,self};
	{"<color=orange>Ngoại Trang Tết 2013 [Nam]<color>",self.ItemFull_5,self};
	{"<color=orange>Ngoại Trang Tết 2013 [Nữ]<color>",self.ItemFull_6,self};
	{"<color=orange>Mảnh ghép ngoại trang tết 2013 [Nam] (500c)<color>",self.ItemFull_10,self};
	{"<color=orange>Mảnh ghép ngoại trang tết 2013 [Nữ] (500c)<color>",self.ItemFull_11,self};
	{"<color=orange>Lệnh bài chuyển sinh<color>",self.ItemFull_7,self};

		{"Tạm thời chưa cần"},
	}
	Dialog:Say(szMsg, tbOpt);
	end
	function tbLiGuan:ItemFull_20()
	me.AddItem(18,1,20405,1)
	local i = 1 
while i<=100 do 
me.AddItem(18,1,20406,1)
i=i+1
end
end	
function tbLiGuan:ItemFull_10()
	local i = 1 
while i<=500 do 
me.AddItem(18,1,20397,1)
me.AddItem(18,1,20398,1)
i=i+1
end
end
function tbLiGuan:ItemFull_11()
	local i = 1 
while i<=500 do 
me.AddItem(18,1,20399,1)
me.AddItem(18,1,20400,1)
i=i+1
end
end
function tbLiGuan:ItemFull_8()
	local pItem = me.GetEquip(Item.EQUIPPOS_ZHENYUAN_MAIN);
Item:UpgradeZhenYuanNoItem(pItem,1000000,1);
Item:UpgradeZhenYuanNoItem(pItem,1000000,2);
Item:UpgradeZhenYuanNoItem(pItem,1000000,3);
Item:UpgradeZhenYuanNoItem(pItem,1000000,4);
end
function tbLiGuan:ItemFull_7()
me.AddItem(18,13,20401,2);
end
function tbLiGuan:ItemFull_6()
me.AddItem(1,25,42,2);
me.AddItem(1,26,49,1);
end
function tbLiGuan:ItemFull_5()
me.AddItem(1,25,38,2);
me.AddItem(1,26,48,1);
end
function tbLiGuan:ItemFull_4()
	local i = 1 
while i<=50 do 
me.AddItem(18,13,20392,1)
me.AddItem(18,13,20393,1)
me.AddItem(18,13,20394,1)
me.AddItem(18,13,20395,1)
i=i+1
end
end
function tbLiGuan:ItemFull_3()
	local i = 1 
while i<=100 do 
me.AddItem(18,13,20391,1)
i=i+1
end
end
function tbLiGuan:ItemFull_2()
me.AddItem(18,7,20387,1)
me.AddItem(18,9,20389,1)
me.AddItem(18,10,20390,1)
end
function tbLiGuan:ItemFull_1()
	local i = 1 
while i<=100 do 
me.AddItem(18,5,20385,1)--Nghiên Mực + Bút Lông + Giấy Điệp (100c mỗi loại)
me.AddItem(18,6,20386,1)
me.AddItem(18,8,20388,1)
i=i+1
end
end
function tbLiGuan:RuongTrangBiPet()
	local i = 1 
while i<=200 do 
me.AddItem(18,1,2009,1)
i=i+1
end
end
function tbLiGuan:LinhHonTrangBiPet()
	local i = 1 
while i<=200 do 
me.AddItem(18,1,2004,1)
me.AddItem(18,1,2005,1)
me.AddItem(18,1,2006,1)
me.AddItem(18,1,2007,1)
i=i+1
end
	end
function tbLiGuan:MoneyDie()
	local i = 1 
while i<=200 do 
	me.AddItem(18,1,2003,1);
	i=i+1
	end
	end
function tbLiGuan:TestTuLinh()
	local lhcu = me.GetTask(2123,1);
	local lhmoi = lhcu + 1651000000;
	me.SetTask(2123,1,lhmoi);
	-- me.AddItem(18,1,16,1);
	end
function tbLiGuan:NhanTheVIP1()
me.AddItem(18,1,20681,1);
end
function tbLiGuan:NhanTheVIP2()
me.AddItem(18,1,20682,1);
end
function tbLiGuan:NhanTheVIP3()
me.AddItem(18,1,20683,1);
end
	-----------
function tbLiGuan:Abou_1()
me.AddItem(1,16,22,2);
me.AddItem(1,16,23,2);
me.AddItem(1,16,24,2);
end
------------
function tbLiGuan:HoatDongVIP()
	local szMsg = "<color=green>Even Sổ Xố Kiến Thiết Miền Bắc Ngày Hôm Nay<color>";
	local tbOpt = {
	
	{"<color=orange>Vào trạng thái chiến đấu<color>", me.SetFightState, 1} ;
	{"<color=orange>NPC Chuyển Sinh<color>",self.NPCChuyeSinh,self};
	{"<color=orange>Reload Tượng Anh Hùng Tổng Hơp<color>",self.ReloadTuongAnhHung,self};
	{"<color=orange>Test Danh Hiệu Tổng Hơp<color>",self.DanhHieuChuyenSinh,self};
	{"<color=orange>Lệnh Bài Trail Quái x3 EXP<color>",self.LenhBaiEXP,self};
	{"<color=orange>Event Bộ Tết Ngoại Trang<color>",self.EventNgoaiTrang,self};
	{"<color=orange>Test Tổng Hợp NPC<color>",self.TestNPC,self};
	{"<color=orange>Event Tết Loại 1<color>",self.EventTet222,self};
	{"<color=orange>Event Tết Loại 2<color>",self.EventTet,self};
	{"<color=orange>Hoạt Động Even Tết 2013<color>",self.HDEventTet,self};
	{"<color=orange>Nhận Ngoai Trang<color>",self.NgoaiTrang1,self};
	{"<color=orange>Lấy Tọa Độ<color>",self.LayToaDo,self};
	{"<color=orange>Hàm Mua Đồng<color>",self.MuaDoBangDong,self};
	{"<color=orange>Nhận Đồng Số Lượng Cực Hot<color>",self.NhanDong1,self};
	{"<color=orange>Reload NPC<color>",self.ReloadNPC,self};
	{"Pháo Hoa Chúc Tết Rất Đẹp",  self.PhaoHoaTet2013, self},
	{"Xoa Skill Phao Hoa", self.XoaHetSkill, self},
	{"<color=red>[Event]<color><color=cyan>Dự Đoán kết quả Xổ Số Miền Bắc", self.GhiSoDe, self},
	{"<color=red>[Event]<color><color=cyan>Dự Đoán kết quả Xổ Số Miền Bắc(Đồng)", self.GhiSoDe2, self},
	}
	Dialog:Say(szMsg, tbOpt);
	end
	function tbLiGuan:LenhBaiEXP()
	me.AddItem(18,13,20396,1);
	end
	function tbLiGuan:DanhHieuChuyenSinh()
	-- me.AddTitle(15,1,1,1);
	me.AddTitle(15,1,3,1);
	end
	function tbLiGuan:ReloadTuongAnhHung()
		DoScript("\\script\\npc\\tuonganhhung.lua");
end
function tbLiGuan:XoaHetSkill()
me.DelFightSkill(1528);
me.DelFightSkill(1529);
me.DelFightSkill(1530);
me.DelFightSkill(1531);
me.DelFightSkill(1532);
me.DelFightSkill(1533);
me.DelFightSkill(1534);
me.DelFightSkill(1535);
me.DelFightSkill(1536);
me.DelFightSkill(1537);
me.DelFightSkill(1538);
me.DelFightSkill(1539);
me.DelFightSkill(1540);
me.DelFightSkill(1541);
me.DelFightSkill(1542);
me.DelFightSkill(1543);
me.DelFightSkill(1544);
me.DelFightSkill(1545);
me.DelFightSkill(1546);
me.DelFightSkill(1547);
me.DelFightSkill(1548);
me.DelFightSkill(1549);
me.DelFightSkill(1550);
me.DelFightSkill(1551);
me.DelFightSkill(1552);
me.DelFightSkill(1553);
me.DelFightSkill(1554);
me.DelFightSkill(1555);
me.DelFightSkill(1556);
me.DelFightSkill(1557);
me.DelFightSkill(1558);
me.DelFightSkill(1559);
me.DelFightSkill(1560);
me.DelFightSkill(1561);
me.DelFightSkill(1562);
me.DelFightSkill(1563);
me.DelFightSkill(1564);
me.DelFightSkill(1565);
me.DelFightSkill(1566);
me.DelFightSkill(1567);
me.DelFightSkill(1568);
me.DelFightSkill(1569);
me.DelFightSkill(1570);
me.DelFightSkill(1571);
me.DelFightSkill(1572);
me.DelFightSkill(1573);
me.DelFightSkill(1574);
me.DelFightSkill(1575);
me.DelFightSkill(1576);
me.DelFightSkill(1577);
me.DelFightSkill(1578);
me.DelFightSkill(1579);
me.DelFightSkill(1580);
me.DelFightSkill(1581);
me.DelFightSkill(1582);
me.DelFightSkill(1583);
me.DelFightSkill(1584);
me.DelFightSkill(1585);
me.DelFightSkill(1586);
me.DelFightSkill(1587);
me.DelFightSkill(1588);
me.DelFightSkill(1589);
me.DelFightSkill(1590);
me.DelFightSkill(1591);
me.DelFightSkill(1592);
me.DelFightSkill(1593);
me.DelFightSkill(1594);
me.DelFightSkill(1595);
me.DelFightSkill(1596);
me.DelFightSkill(1597);
end
function tbLiGuan:EventNgoaiTrang()
local i = 1 
while i<=10 do 
-- me.AddItem(18,1,20397,1)
-- me.AddItem(18,1,20398,1)
me.AddItem(18,13,20401,1)
-- me.AddItem(18,1,20400,1)
i=i+1
end
-- me.AddItem(1,25,38,1);
-- me.AddItem(1,25,42,1);
-- me.AddItem(1,25,39,1);
-- me.AddItem(1,26,48,1);
-- me.AddItem(1,26,49,1);
end
	function tbLiGuan:TestNPC()
	local nMapId, nPosX, nPosY = me.GetWorldPos();
	--KNpc.Add2(6001, 150, 1, nMapId, nPosX, nPosY)
	KNpc.Add2(20005, 50, 1, nMapId, nPosX, nPosY)
	--KNpc.Add2(6793, 150, 1, nMapId, nPosX, nPosY)
	--KNpc.Add2(6794, 150, 1, nMapId, nPosX, nPosY)
	--KNpc.Add2(6795, 150, 1, nMapId, nPosX, nPosY)
	--KNpc.Add2(6796, 150, 1, nMapId, nPosX, nPosY)
	--KNpc.Add2(6797, 150, 1, nMapId, nPosX, nPosY)
	--KNpc.Add2(6798, 150, 1, nMapId, nPosX, nPosY)
	--KNpc.Add2(7059, 150, 1, nMapId, nPosX, nPosY)
	--KNpc.Add2(7059, 150, 1, nMapId, nPosX, nPosY)
	--KNpc.Add2(7059, 150, 1, nMapId, nPosX, nPosY)
	--KNpc.Add2(7059, 150, 1, nMapId, nPosX, nPosY)
	--KNpc.Add2(7059, 150, 1, nMapId, nPosX, nPosY)
	--KNpc.Add2(7059, 150, 1, nMapId, nPosX, nPosY)
	--KNpc.Add2(20120, 150, 1, nMapId, nPosX, nPosY).szName= "" ..me.szName .. ""
    me.Msg(string.format("Đã gọi Boss tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
	end
function tbLiGuan:EventTet222()
me.AddFightSkill(2000,1);

-- me.AddItem(18,13,20401,1);
-- me.AddLevel(150-me.nLevel);
-- me.AddFightSkill(1529,1);
-- me.AddFightSkill(1530,1);
-- me.AddFightSkill(1531,1);
-- me.AddFightSkill(1532,1);
-- me.AddFightSkill(1533,1);
-- me.AddFightSkill(1534,1);
-- me.AddFightSkill(1535,1);
-- me.AddFightSkill(1536,1);
-- me.AddFightSkill(1537,1);
-- me.AddFightSkill(1538,1);
-- me.AddFightSkill(1539,1);
-- me.AddFightSkill(1540,1);
-- me.AddFightSkill(1541,1);
-- me.AddFightSkill(1542,1);
-- local i = 1 
-- while i<=51 do -- 
-- me.AddItem(18,5,20385,1); -- 
-- me.AddItem(18,6,20386,1);
-- me.AddItem(18,8,20388,1);
-- me.AddItem(18,5,20385,1);
-- me.AddItem(18,13,20392,1);
-- me.AddItem(18,13,20393,1);
-- me.AddItem(18,13,20394,1);
-- me.AddItem(18,13,20395,1);
-- me.AddItem(18,13,20391,1);
-- me.AddItem(18,9,20389,1);
-- me.AddItem(18,1,20384,1);
-- i=i+1
-- end
---------
-- me.AddItem(18,7,20387,1);
-- me.AddItem(18,9,20389,1);
-- me.AddItem(18,10,20390,1);
-------
-- me.AddItem(2,1,1354,10,2,16);
	-- local lhcu = me.GetTask(2123,1);
	-- local lhmoi = lhcu + 10000000000000;
	-- me.SetTask(2123,1,lhmoi);
end
function tbLiGuan:NPCChuyeSinh()
	DoScript("\\script\\npc\\liguan_cs.lua");
	me.AddRepute(5,6,204000000);

end
	function tbLiGuan:HDEventTet()
		-- local tbHoatDongChucTet	= Npc:GetClass("eventnewyear2013");
	-- tbHoatDongChucTet:OnDialog();
	-- DoScript("\\script\\npc\\eventnewyear2013.lua");
	-- DoScript("\\script\\npc\\HoatDongVeTranh.lua");
	DoScript("\\script\\npc\\liguan.lua");
-- local tbHoatDongVeTranh = Npc:GetClass("HoatDongVeTranh");
	-- tbHoatDongVeTranh:OnDialog();
	-- DoScript("\\script\\item\\class\\tiendong.lua");
	-- DoScript("\\script\\item\\class\\tienvang.lua");
	-- DoScript("\\script\\item\\class\\kimnguyenbao.lua");
	-- DoScript("\\script\\item\\class\\ngannguyenbao.lua");
	end
	function tbLiGuan:EventTet()
	me.AddItem(18,1,20384,1);
	-- me.AddItem(18,1,20371,1);
	-- me.AddItem(18,1,20372,2);
	-- me.AddItem(18,1,20373,3);
	-- me.AddItem(18,1,20374,4);
	-- me.AddItem(18,1,20375,5);
	-- me.AddItem(18,1,20376,6);
	-- me.AddItem(18,1,20377,7);
	-- me.AddItem(18,1,20378,8);
	-- me.AddItem(18,1,20379,9);
	-- me.AddItem(18,1,20380,10);
	-- me.AddItem(18,1,20381,11);
	-- me.AddItem(18,1,20382,12);
	DoScript("\\script\\item\\class\\lenhbaiexp.lua");
	end
function tbLiGuan:NgoaiTrang1()
-- me.AddItem(1,25,32,2);
-- me.AddItem(1,25,33,2);
-- me.AddItem(1,25,34,2);
-- me.AddItem(1,25,35,2);
-- me.AddItem(1,25,36,2);
-- me.AddItem(1,25,16,2);
-----------
-- me.AddItem(1,26,33,1);
-- me.AddItem(1,26,34,1);
-- me.AddItem(1,26,35,1);
-- me.AddItem(1,26,36,1);
-- me.AddItem(1,12,63,10);
me.AddItem(21,9,4,1);
me.AddItem(21,9,5,1);
me.AddItem(21,9,6,1);
DoScript("\\script\\item\\class\\xiulianzhu.lua");

end
function tbLiGuan:NhanDong1()
-- me.AddJbCoin(5000000000);
	local lhcu = me.GetTask(2123,1);
	local lhmoi = lhcu + 1651000000;
	me.SetTask(2123,1,lhmoi);
	me.AddItem(18,1,16,1);
-- me.AddItem(1,12,65,10);
-- me.AddItem(18,1,666,9);'
-- me.AddItem(18,1,20383,4)
-- me.AddItem(18,1,20384,1)
end
function tbLiGuan:GhiSoDe()
local tbNpc = Npc:GetClass("ghisode");
		tbNpc:GhiSoDe();
end
function tbLiGuan:GhiSoDe2()
local tbNpc = Npc:GetClass("ghisode2");
		tbNpc:GhiSoDe();
end
function tbLiGuan:ReloadNPC()
DoScript("\\script\\npc\\hoatdongmuaVIP.lua");
DoScript("\\script\\misc\\gm_role.lua");
end
function tbLiGuan:LayToaDo()
	local nMapId, nPosX, nPosY = me.GetWorldPos();
	local sms = string.format(" Tọa độ đang đứng là:<color=red> %d <color>-<color=green> %d <color>",nPosX*32,  nPosY*32);
	Dialog:Say(sms);
	end
function tbLiGuan:MuaDoBangDong()
  local nMapId, nPosX, nPosY = me.GetWorldPos();
	KNpc.Add2(20124, 100, 0, nMapId, nPosX, nPosY);
me.AddItem(2,1,1354,10,2,16);
-- local nCount = me.GetJbCoin()
-- if nCount < 5000000 then
-- Dialog:Say("Đônồ không đủ")
-- return 0;
-- end
		-- me.SetItemTimeout(me.AddItem(1,12,64,10), os.date("%Y/%m/%d/%H/%M/00", GetTime() + 3600 * 24*1)); 
-- me.Earn(5000000,0);
-- me.AddJbCoin(1*50000000)
-- me.AddItem(21,9,7,1);
-- me.AddItem(21,9,9,1);
-- me.AddItem(1,12,64,10);
-- Dialog:Say("Trong người ngươi hiện chỉ có "..nCount.." Đồng không đủ mua VIP1 . Hãy nạp thẻ thêm")
end
function tbLiGuan:eventnewgame()
	for i=1,1 do
		if me.CountFreeBagCell() > 0 then
			--me.AddItem(18,1,2004,1);--Linh Hồn Vũ Khí
			--me.AddItem(18,1,2005,1);--Linh Hồn Áo
			--me.AddItem(18,1,2006,1);--Linh Hồn Nhẫn
			--me.AddItem(18,1,2007,1);--Linh Hồn Tay
			--me.AddItem(18,1,2008,1);Linh Hồn Bội
			--me.AddItem(18,1,2009,1);Rương Linh Hồn Đồng Hành
			--me.AddItem(18,1,2010,1);--Rương Anh Hùng
			--me.AddItem(18,1,1335,1);--Rương Tống Kim Xịn Nhất
			--me.AddItem(18,1,1335,2);--Rương Tống Kim Bạch Ngân
			--me.AddItem(18,1,1335,3);--Rương Tống Kim Thanh Đồng
			--me.AddItem(18,1,2015,1);--Rương Mảnh Ghép Cực Phẩm
			--me.AddItem(18,1,2043,1);--Rương Đồng Hành
			--me.AddItem(18,1,2055,1);--Rương Danh Vọng
			--me.AddItem(18,1,1343,1);--Rương Danh Vọng1
			--me.AddItem(18,1,558,2);--Rương Danh Vọng
			--me.AddItem(18,1,558,3);--Rương Danh Vọng
			--me.AddItem(18,1,558,4);--Rương Danh Vọng
			--me.AddItem(18,1,558,5);--Rương Danh Vọng
			--me.AddItem(18,1,558,6);--Rương Danh Vọng
			--me.AddItem(18,1,558,7);--Rương Danh Vọng
			--me.AddItem(18,1,558,8);--Rương Danh Vọng
			--me.AddItem(18,1,558,9);--Rương Danh Vọng
			--me.AddItem(18,1,558,10);--Rương Danh Vọng
			--me.AddItem(18,1,558,11);--Rương Danh Vọng
			--me.AddItem(18,1,558,12);--Rương Danh Vọng
			--me.AddItem(18,1,559,1);--Rương Danh Vọng
			--me.AddItem(18,1,560,1);--Rương Danh Vọng
			--me.AddItem(18,1,561,2);--Rương Danh Vọng
			--me.AddItem(18,1,381,1)--Bảo Rương Hoàng Kim Thịnh Hạ
		else
			break
		end
	end
end
----

function tbLiGuan:DapTrung()
	me.AddItem(18,1,1336,2);
	for i=1,100 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,1336,1);
		else
			break
		end
	end
end
----------------------------------------------------------------------------------
function tbLiGuan:ngoaitrang()
	me.AddItem(1,25,16,2); --
	me.AddItem(1,25,32,2); --
end

function tbLiGuan:channguyen()
	me.AddItem(1,24,1,1);
	me.AddItem(1,24,2,1);
	me.AddItem(1,24,3,1);
	me.AddItem(1,24,4,1);
	me.AddItem(1,24,5,1);
	me.AddItem(1,24,6,1);
	me.AddItem(1,24,7,1);
end

function tbLiGuan:canh()
	--me.AddItem(1,12,33,4);
	--me.AddItem(1,26,40,1);
	--me.AddItem(1,26,41,1);
	--me.AddItem(1,26,42,1);
	--me.AddItem(1,26,43,1);
 me.AddItem(1,26,40,2);
 me.AddItem(1,26,41,2);
 
end

function tbLiGuan:thanhlinh()
	me.AddItem(1,27,1,1);
	me.AddItem(1,27,2,1);
	me.AddItem(1,27,3,1);
	me.AddItem(1,27,4,1);
	me.AddItem(1,27,5,1);
end

function tbLiGuan:ngoc()
	-- me.AddStackItem(18,1,1331,1,nil,10);
	-- me.AddStackItem(18,1,1331,2,nil,10);
	-- me.AddStackItem(18,1,1331,3,nil,10);
	me.AddStackItem(18,1,1331,4,nil,100);
	me.AddStackItem(18,1,1333,1,nil,100);
end

function tbLiGuan:luyenthanhlinh()
	me.AddStackItem(18,1,1334,1,nil,1000);
end

----------------------------------------------------------------------------------

function tbLiGuan:NangCao()
	local szMsg = "<color=blue>Túi Tân Thủ <color>";
	local tbOpt = {
		-- {"<color=red>Đồng tiền vinh danh<color>",self.testneww,self};
		{"<color=red>Bạc - Đồng<color>",self.BacDong,self};
		{"<color=red>Bang Hội - Gia Tộc<color>",self.lsBangHoiGiaToc,self};
		{"<color=red>Quan Hàm - Quan Ấn<color>",self.lsQuanHam,self};
		{"<color=red>Danh Vọng<color>",self.Danhvong,self};
		{"<color=red>Trang Bị<color>",self.TrangBi,self};
		{"<color=red>Vật Phẩm<color>",self.VatPham,self};
		{"<color=red>Du Long<color>",self.lsDuLong,self};
		{"<color=red>Lệnh Bài<color>",self.lsLenhBai,self};
		{"<color=red>Thú Cưỡi - Đồng Hành<color>",self.lsThuCuoiDongHanh,self};
		{"<color=red>Gọi Boss - Phó Bản<color>",self.lsGoiBoss,self};
		{"<color=red>Tiềm Năng - Kỹ Năng<color>",self.lsTiemNangKyNang,self};
		{"<color=red>Điểm Kinh Nghiệm<color>",self.lsDiemKinhNghiem1,self};
		{"<color=red>Mặt Nạ<color>",self.lsMatNa,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:testneww()
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
me.AddItem(18,1,2003,1)
end
function tbLiGuan:lsDuLong()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Trứng Du Long (8)",self.lsTrungDuLong,self};
		{"Chiến Thư Mật Thất Du Long (100)",self.ChienThuDuLong,self};
		{"Du Long Danh Vọng Lệnh",self.DuLong,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsTrungDuLong()
	me.AddItem(18,1,525,1); --Trứng Du Long
	me.AddItem(18,1,525,1); --Trứng Du Long
	me.AddItem(18,1,525,1); --Trứng Du Long
	me.AddItem(18,1,525,1); --Trứng Du Long
	me.AddItem(18,1,525,1); --Trứng Du Long
	me.AddItem(18,1,525,1); --Trứng Du Long
	me.AddItem(18,1,525,1); --Trứng Du Long
	me.AddItem(18,1,525,1); --Trứng Du Long
end
----------------------------------------------------------------------------------
function tbLiGuan:lsLenhBai()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"LB Gia Tộc",self.lsGiaToc,self};
		{"LB Bạch Hổ Đường",self.lsBachHoDuong,self};
		{"LB Chúc Phúc",self.lsChucPhuc,self};
		{"Lệnh Bài Mở Rộng Rương",self.MoRongRuong,self};
		{"Lệnh Bài Uy Danh Giang Hồ (20đ)",self.LBUyDanh,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsChucPhuc()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"LB Chúc Phúc (Sơ)",self.ChucPhucSo,self};
		{"LB Chúc Phúc (Trung)",self.ChucPhucTrung,self};
		{"LB Chúc Phúc (Cao)",self.ChucPhucCao,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsLenhBai,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:ChucPhucSo()
	me.AddItem(18,1,212,1); --Lệnh bài Chúc Phúc sơ
	me.AddItem(18,1,212,1); --Lệnh bài Chúc Phúc sơ
	me.AddItem(18,1,212,1); --Lệnh bài Chúc Phúc sơ
	me.AddItem(18,1,212,1); --Lệnh bài Chúc Phúc sơ
	me.AddItem(18,1,212,1); --Lệnh bài Chúc Phúc sơ
end
----------------------------------------------------------------------------------
function tbLiGuan:ChucPhucTrung()
	me.AddItem(18,1,212,2); --Lệnh bài Chúc Phúc trung
	me.AddItem(18,1,212,2); --Lệnh bài Chúc Phúc trung
	me.AddItem(18,1,212,2); --Lệnh bài Chúc Phúc trung
	me.AddItem(18,1,212,2); --Lệnh bài Chúc Phúc trung
	me.AddItem(18,1,212,2); --Lệnh bài Chúc Phúc trung
end
----------------------------------------------------------------------------------
function tbLiGuan:ChucPhucCao()
	me.AddItem(18,1,212,3); --Lệnh bài Chúc Phúc cao
	me.AddItem(18,1,212,3); --Lệnh bài Chúc Phúc cao
	me.AddItem(18,1,212,3); --Lệnh bài Chúc Phúc cao
	me.AddItem(18,1,212,3); --Lệnh bài Chúc Phúc cao
	me.AddItem(18,1,212,3); --Lệnh bài Chúc Phúc cao
end
----------------------------------------------------------------------------------
function tbLiGuan:lsBachHoDuong()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"LB Bạch Hổ Đường (Sơ)",self.BachHoDuongSo,self};
		{"LB Bạch Hổ Đường (Trung)",self.BachHoDuongTrung,self};
		{"LB Bạch Hổ Đường (Cao)",self.BachHoDuongCao,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsLenhBai,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:BachHoDuongSo()
	me.AddItem(18,1,111,1); --Lệnh bài bạch hổ đường sơ
	me.AddItem(18,1,111,1); --Lệnh bài bạch hổ đường sơ
	me.AddItem(18,1,111,1); --Lệnh bài bạch hổ đường sơ
	me.AddItem(18,1,111,1); --Lệnh bài bạch hổ đường sơ
	me.AddItem(18,1,111,1); --Lệnh bài bạch hổ đường sơ
end
----------------------------------------------------------------------------------
function tbLiGuan:BachHoDuongTrung()
	me.AddItem(18,1,111,2); --Lệnh bài bạch hổ đường trung
	me.AddItem(18,1,111,2); --Lệnh bài bạch hổ đường trung
	me.AddItem(18,1,111,2); --Lệnh bài bạch hổ đường trung
	me.AddItem(18,1,111,2); --Lệnh bài bạch hổ đường trung
	me.AddItem(18,1,111,2); --Lệnh bài bạch hổ đường trung
end
----------------------------------------------------------------------------------
function tbLiGuan:BachHoDuongCao()
	me.AddItem(18,1,111,3); --Lệnh bài bạch hổ đường cao
	me.AddItem(18,1,111,3); --Lệnh bài bạch hổ đường cao
	me.AddItem(18,1,111,3); --Lệnh bài bạch hổ đường cao
	me.AddItem(18,1,111,3); --Lệnh bài bạch hổ đường cao
	me.AddItem(18,1,111,3); --Lệnh bài bạch hổ đường cao
end
----------------------------------------------------------------------------------
function tbLiGuan:lsBangHoiGiaToc()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Gia Tộc",self.lsGiaToc,self};
		{"Bang Hội",self.lsBangHoi,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsBangHoi()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Bạc Bang Hội (Tiểu)",self.BacBangHoiTieu,self};
		{"Bạc Bang Hội (Đại)",self.BacBangHoiDai,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsBangHoiGiaToc,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsGiaToc()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Lệnh Bài Gia Tộc (Sơ)",self.LenhBaiGiaTocSo,self};
		{"Lệnh Bài Gia Tộc (Trung)",self.LenhBaiGiaTocTrung,self};
		{"Lệnh Bài Gia Tộc (Cao)",self.LenhBaiGiaTocCao,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsBangHoiGiaToc,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:LenhBaiGiaTocSo()
	me.AddItem(18,1,110,1); --Lệnh bài gia tộc sơ
	me.AddItem(18,1,110,1); --Lệnh bài gia tộc sơ
	me.AddItem(18,1,110,1); --Lệnh bài gia tộc sơ
	me.AddItem(18,1,110,1); --Lệnh bài gia tộc sơ
	me.AddItem(18,1,110,1); --Lệnh bài gia tộc sơ
end
----------------------------------------------------------------------------------
function tbLiGuan:LenhBaiGiaTocTrung()
	me.AddItem(18,1,110,2); --Lệnh bài gia tộc trung
	me.AddItem(18,1,110,2); --Lệnh bài gia tộc trung
	me.AddItem(18,1,110,2); --Lệnh bài gia tộc trung
	me.AddItem(18,1,110,2); --Lệnh bài gia tộc trung
	me.AddItem(18,1,110,2); --Lệnh bài gia tộc trung
end
----------------------------------------------------------------------------------
function tbLiGuan:LenhBaiGiaTocCao()
	me.AddItem(18,1,110,3); --Lệnh bài gia tộc cao
	me.AddItem(18,1,110,3); --Lệnh bài gia tộc cao
	me.AddItem(18,1,110,3); --Lệnh bài gia tộc cao
	me.AddItem(18,1,110,3); --Lệnh bài gia tộc cao
	me.AddItem(18,1,110,3); --Lệnh bài gia tộc cao
end
----------------------------------------------------------------------------------
function tbLiGuan:BacBangHoiTieu()
	me.AddItem(18,1,284,1); --Thỏi bạc bang hội tiểu
	me.AddItem(18,1,284,1); --Thỏi bạc bang hội tiểu
	me.AddItem(18,1,284,1); --Thỏi bạc bang hội tiểu
	me.AddItem(18,1,284,1); --Thỏi bạc bang hội tiểu
	me.AddItem(18,1,284,1); --Thỏi bạc bang hội tiểu
end
----------------------------------------------------------------------------------
function tbLiGuan:BacBangHoiDai()
    me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
end
----------------------------------------------------------------------------------
function tbLiGuan:lsTangToc()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Tăng Tốc Chạy",self.TangTocChay,self};
		{"Hủy Tăng Tốc Chạy",self.HuyTangTocChay,self};
		{"Tăng Tốc Đánh",self.TangTocDanh,self};
		{"Hủy Tăng Tốc Đánh",self.HuyTangTocDanh,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:ReloadScriptDEV()
	local szMsg = "<color=blue>Chào Developer ^.^<color>";
	local tbOpt = {
		{"Reload <color=orange>Túi Tân Thủ<color>",self.Newplayergift,self};
		{"Reload <color=orange>Thẻ Game Master<color>",self.GMAdmin,self};
		{"<color=pink>Trở Lại Trước<color>",self.ChucNangAdmin,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:Newplayergift()
    DoScript("\\script\\event\\minievent\\newplayergift.lua");
	me.Msg("Đã load lại Túi Tân Thủ !!!");
end
----------------------------------------------------------------------------------
function tbLiGuan:GMAdmin()
    DoScript("\\script\\item\\class\\gmcard.lua");
	DoScript("\\script\\misc\\gm_role.lua");
	me.Msg("Đã load lại Game Master Card !!!");
end
----------------------------------------------------------------------------------
function tbLiGuan:lsGoiBoss()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Nhận Cầu hồn ngọc (4)",self.Cauhon,self};
		{"Gọi Boss",self.GoiBoss,self};
		{"Phó Bản",self.PhoBan,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:PhoBan()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Lệnh Bài Phó Bản",self.LenhBaiPhoBan,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsGoiBoss,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:LenhBaiPhoBan()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"LB Thiên Quỳnh Cung",self.LenhBaiThienQuynhCung,self};
		{"LB Vạn Hoa Cốc",self.LenhBaiVanHoaCoc,self};
		{"<color=pink>Trở Lại Trước<color>",self.PhoBan,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:LenhBaiThienQuynhCung()
    me.AddItem(18,1,186,1); --Lệnh Bài Thiên Quỳnh Cung
end

function tbLiGuan:LenhBaiVanHoaCoc()
    me.AddItem(18,1,245,1); --Lệnh Bài Vạn Hoa Cốc
end
----------------------------------------------------------------------------------
function tbLiGuan:lsMatNa()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Mặt Nạ Hàng Long <color=red>(Ko Thể Bán)<color>",self.MatNaHangLong,self};
		{"Tần Thủy Hoàng <color=red>(Ko Thể Bán)<color>",self.MatNaTanThuyHoang,self};
		{"Áo Dài Khăn Đống (Nam)",self.MatNaAoDaiKhanDongNam,self};
		{"Wodekapu",self.MatNaWodekapu,self};
		{"Lam Nhan",self.MatNaLamNhan,self};
		{"Rùa Thần",self.MatNaRuaThan,self};
		{"Mãnh Hổ",self.MatNaManhHo,self};
		{"Kim Mao Sư Vương",self.MatNaKimMaoSuVuong,self};
		{"Tây Độc Âu Dương Phong",self.MatNaTayDocAuDuongPhong,self};
		{"Cốc Tiên Tiên <color=red>(Ko Thể Bán)<color>",self.MatNaCocTienTien,self};
		{">>>",self.lsMatNa1,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsMatNa1()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Lãnh Sương Nhiên <color=red>(Ko Thể Bán)<color>",self.MatNaLanhSuongNhien,self};
		{"Tân Niên Hiệp Nữ <color=red>(Ko Thể Bán)<color>",self.MatNaTanNienHiepNu,self};
		{"Doãn Tiêu Vũ <color=red>(Ko Thể Bán)<color>",self.MatNaDoanTieuVu,self};
		{"Ngưu Thúy Hoa <color=red>(Ko Thể Bán)<color>",self.MatNaNguuThuyHoa,self};
		{"<<<",self.lsMatNa,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:ThongBaoToanServer()
    Dialog:AskString("Nhập dữ liệu", 1000, self.ThongBao, self);
end

function tbLiGuan:ThongBao(msg)
    GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
end
----------------------------------------------------------------------------------
function tbLiGuan:XepHangDanhVong()
    GCExcute({"PlayerHonor:UpdateWuLinHonorLadder"}); 
    GCExcute({"PlayerHonor:UpdateMoneyHonorLadder"}); 
    GCExcute({"PlayerHonor:UpdateLeaderHonorLadder"}); 
    KGblTask.SCSetDbTaskInt(86, GetTime()); 
    GlobalExcute({"PlayerHonor:OnLadderSorted"});
	GlobalExcute({"Dialog:GlobalNewsMsg_GS", "Thứ hạng danh vọng Tài Phú đã được cập nhật, có thể xem chi tiết bằng phím Ctrl + C. Các hão hán đã có thể mua Phi phong nếu đủ điều kiện danh vọng"});
end
----------------------------------------------------------------------------------
function tbLiGuan:GoiBoss()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Bách Phu Trường",self.GoiBoss1,self};
		{"Chiến Sĩ Vong Trận",self.GoiBoss2,self};
		{"<color=red>Tà Hồn Sư<color>",self.GoiBoss3,self};
		{"Quỷ Sứ",self.GoiBoss4,self};
		{"Quỷ Nô",self.GoiBoss5,self};
		{"<color=red>Tần Thủy Hoàng<color>",self.GoiBoss6,self};
		{"Thần Thương Phương Vãn",self.GoiBoss7,self};
		{"Triệu Ứng Tiên",self.GoiBoss8,self};
		{"Hương Ngọc Tiên",self.GoiBoss9,self};
		{"Tống Nguyên Soái",self.GoiBoss10,self};
		{"Kim Nguyên Soái",self.GoiBoss11,self};
		{"<color=red>Niên Thú<color>",self.GoiBoss12,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsGoiBoss,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:GoiBoss1()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2431, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss2()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2430, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss3()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2429, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss4()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2428, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss5()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2427, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss6()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2426, 255, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss7()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(20007, 300, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss8()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2408, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss9()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2409, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss10()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(7035, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss11()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(7037, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss12()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(3618, 10, 1, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end
----------------------------------------------------------------------------------
function tbLiGuan:lsQuanHam()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Nhận Quan Hàm",self.NhanQuanHam,self};
		{"Nhận Quan Ấn",self.NhanQuanAn,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:NhanQuanHam()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Quan Hàm Cấp 1",self.quanham1,self};
		{"Quan Hàm Cấp 2",self.quanham2,self};
		{"Quan Hàm Cấp 3",self.quanham3,self};
		{"Quan Hàm Cấp 4",self.quanham4,self};
		{"Quan Hàm Cấp 5",self.quanham5,self};
		{"Quan Hàm Cấp 6",self.quanham6,self};
		{"Quan Hàm Cấp 7",self.quanham7,self};
		{"Quan Hàm Cấp 8",self.quanham8,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsQuanHam,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:quanham1()
	me.AddTitle(10, 2, 1, 8)
end

function tbLiGuan:quanham2()
	me.AddTitle(10, 2, 2, 8)
end

function tbLiGuan:quanham3()
	me.AddTitle(10, 2, 3, 8)
end

function tbLiGuan:quanham4()
	me.AddTitle(10, 2, 4, 8)
end

function tbLiGuan:quanham5()
	me.AddTitle(10, 2, 5, 8)
end

function tbLiGuan:quanham6()
	me.AddTitle(10, 2, 6, 8)
end

function tbLiGuan:quanham7()
	me.AddTitle(10, 2, 7, 8)
end

function tbLiGuan:quanham8()
	me.AddTitle(10, 2, 8, 8)
end
----------------------------------------------------------------------------------
function tbLiGuan:NhanQuanAn()
	local szMsg = "Tụ Hội Kiếm";
	local tbOpt = {
		{"Nhận Quan ấn Kim",self.QuanAnKim,self};
		{"Nhận Quan ấn Mộc",self.QuanAnMoc,self};
		{"Nhận Quan ấn Thủy",self.QuanAnThuy,self};
		{"Nhận Quan ấn Hỏa",self.QuanAnHoa,self};
		{"Nhận Quan ấn Thổ",self.QuanAnTho,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsQuanHam,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnKim()
	local szMsg = "Tụ Hội Kiếm";
	local tbOpt = {
		{"Nhận Quan ấn cấp 1",self.QuanAnKim1,self};
		{"Nhận Quan ấn cấp 2",self.QuanAnKim2,self};
		{"Nhận Quan ấn cấp 3",self.QuanAnKim3,self};
		{"Nhận Quan ấn cấp 4",self.QuanAnKim4,self};
		{"Nhận Quan ấn cấp 5",self.QuanAnKim5,self};
		{"Nhận Quan ấn cấp 6",self.QuanAnKim6,self};
		{"Nhận Quan ấn cấp 7",self.QuanAnKim7,self};
		{"Nhận Quan ấn cấp 8",self.QuanAnKim8,self};
		{"<color=pink>Trở Lại Trước<color>",self.NhanQuanAn,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnKim1()
	me.AddItem(1,18,1,1,1);
end

function tbLiGuan:QuanAnKim2()
	me.AddItem(1,18,1,2,1);
end

function tbLiGuan:QuanAnKim3()
	me.AddItem(1,18,1,3,1);
end

function tbLiGuan:QuanAnKim4()
	me.AddItem(1,18,1,4,1);
end

function tbLiGuan:QuanAnKim5()
	me.AddItem(1,18,1,5,1);
end

function tbLiGuan:QuanAnKim6()
	me.AddItem(1,18,1,6,1);
end

function tbLiGuan:QuanAnKim7()
	me.AddItem(1,18,1,7,1);
end

function tbLiGuan:QuanAnKim8()
	me.AddItem(1,18,1,8,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnMoc()
	local szMsg = "Tụ Hội Kiếm";
	local tbOpt = {
		{"Nhận Quan ấn cấp 1",self.QuanAnMoc1,self};
		{"Nhận Quan ấn cấp 2",self.QuanAnMoc2,self};
		{"Nhận Quan ấn cấp 3",self.QuanAnMoc3,self};
		{"Nhận Quan ấn cấp 4",self.QuanAnMoc4,self};
		{"Nhận Quan ấn cấp 5",self.QuanAnMoc5,self};
		{"Nhận Quan ấn cấp 6",self.QuanAnMoc6,self};
		{"Nhận Quan ấn cấp 7",self.QuanAnMoc7,self};
		{"Nhận Quan ấn cấp 8",self.QuanAnMoc8,self};
		{"<color=pink>Trở Lại Trước<color>",self.NhanQuanAn,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnMoc1()
	me.AddItem(1,18,2,1,1);
end

function tbLiGuan:QuanAnMoc2()
	me.AddItem(1,18,2,2,1);
end

function tbLiGuan:QuanAnMoc3()
	me.AddItem(1,18,2,3,1);
end

function tbLiGuan:QuanAnMoc4()
	me.AddItem(1,18,2,4,1);
end

function tbLiGuan:QuanAnMoc5()
	me.AddItem(1,18,2,5,1);
end

function tbLiGuan:QuanAnMoc6()
	me.AddItem(1,18,2,6,1);
end

function tbLiGuan:QuanAnMoc7()
	me.AddItem(1,18,2,7,1);
end

function tbLiGuan:QuanAnMoc8()
	me.AddItem(1,18,2,8,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnThuy()
	local szMsg = "Tụ Hội Kiếm";
	local tbOpt = {
		{"Nhận Quan ấn cấp 1",self.QuanAnThuy1,self};
		{"Nhận Quan ấn cấp 2",self.QuanAnThuy2,self};
		{"Nhận Quan ấn cấp 3",self.QuanAnThuy3,self};
		{"Nhận Quan ấn cấp 4",self.QuanAnThuy4,self};
		{"Nhận Quan ấn cấp 5",self.QuanAnThuy5,self};
		{"Nhận Quan ấn cấp 6",self.QuanAnThuy6,self};
		{"Nhận Quan ấn cấp 7",self.QuanAnThuy7,self};
		{"Nhận Quan ấn cấp 8",self.QuanAnThuy8,self};
		{"<color=pink>Trở Lại Trước<color>",self.NhanQuanAn,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnThuy1()
	me.AddItem(1,18,3,1,1);
end

function tbLiGuan:QuanAnThuy2()
	me.AddItem(1,18,3,2,1);
end

function tbLiGuan:QuanAnThuy3()
	me.AddItem(1,18,3,3,1);
end

function tbLiGuan:QuanAnThuy4()
	me.AddItem(1,18,3,4,1);
end

function tbLiGuan:QuanAnThuy5()
	me.AddItem(1,18,3,5,1);
end

function tbLiGuan:QuanAnThuy6()
	me.AddItem(1,18,3,6,1);
end

function tbLiGuan:QuanAnThuy7()
	me.AddItem(1,18,3,7,1);
end

function tbLiGuan:QuanAnThuy8()
	me.AddItem(1,18,3,8,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnHoa()
	local szMsg = "Tụ Hội Kiếm";
	local tbOpt = {
		{"Nhận Quan ấn cấp 1",self.QuanAnHoa1,self};
		{"Nhận Quan ấn cấp 2",self.QuanAnHoa2,self};
		{"Nhận Quan ấn cấp 3",self.QuanAnHoa3,self};
		{"Nhận Quan ấn cấp 4",self.QuanAnHoa4,self};
		{"Nhận Quan ấn cấp 5",self.QuanAnHoa5,self};
		{"Nhận Quan ấn cấp 6",self.QuanAnHoa6,self};
		{"Nhận Quan ấn cấp 7",self.QuanAnHoa7,self};
		{"Nhận Quan ấn cấp 8",self.QuanAnHoa8,self};
		{"<color=pink>Trở Lại Trước<color>",self.NhanQuanAn,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnHoa1()
	me.AddItem(1,18,4,1,1);
end

function tbLiGuan:QuanAnHoa2()
	me.AddItem(1,18,4,2,1);
end

function tbLiGuan:QuanAnHoa3()
	me.AddItem(1,18,4,3,1);
end

function tbLiGuan:QuanAnHoa4()
	me.AddItem(1,18,4,4,1);
end

function tbLiGuan:QuanAnHoa5()
	me.AddItem(1,18,4,5,1);
end

function tbLiGuan:QuanAnHoa6()
	me.AddItem(1,18,4,6,1);
end

function tbLiGuan:QuanAnHoa7()
	me.AddItem(1,18,4,7,1);
end

function tbLiGuan:QuanAnHoa8()
	me.AddItem(1,18,4,8,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnTho()
	local szMsg = "Tụ Hội Kiếm";
	local tbOpt = {
		{"Nhận Quan ấn cấp 1",self.QuanAnTho1,self};
		{"Nhận Quan ấn cấp 2",self.QuanAnTho2,self};
		{"Nhận Quan ấn cấp 3",self.QuanAnTho3,self};
		{"Nhận Quan ấn cấp 4",self.QuanAnTho4,self};
		{"Nhận Quan ấn cấp 5",self.QuanAnTho5,self};
		{"Nhận Quan ấn cấp 6",self.QuanAnTho6,self};
		{"Nhận Quan ấn cấp 7",self.QuanAnTho7,self};
		{"Nhận Quan ấn cấp 8",self.QuanAnTho8,self};
		{"<color=pink>Trở Lại Trước<color>",self.NhanQuanAn,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:QuanAnTho1()
	me.AddItem(1,18,5,1,1);
end

function tbLiGuan:QuanAnTho2()
	me.AddItem(1,18,5,2,1);
end

function tbLiGuan:QuanAnTho3()
	me.AddItem(1,18,5,3,1);
end

function tbLiGuan:QuanAnTho4()
	me.AddItem(1,18,5,4,1);
end

function tbLiGuan:QuanAnTho5()
	me.AddItem(1,18,5,5,1);
end

function tbLiGuan:QuanAnTho6()
	me.AddItem(1,18,5,6,1);
end

function tbLiGuan:QuanAnTho7()
	me.AddItem(1,18,5,7,1);
end

function tbLiGuan:QuanAnTho8()
	me.AddItem(1,18,5,8,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:VatPham()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Túi",self.Tui,self};
		
		{"Vé Cường Hóa",self.VeCuongHoa,self};
		{"Luyện Hóa Đồ",self.LuyenHoaDo,self};
		
		{"Đồ Nhiệm Vụ 110 (10 món)",self.nhiemvu110,self};
		{"Nguyệt Ảnh Thạch (10v)<color=red>( Ko Thể Bán)<color>",self.NguyetAnhThach,self};
		{"Bùa Sửa Trang Bị Cường 16",self.BuaSuaTrangBi,self};
		{"Nguyệt Ảnh Nguyên Thạch (10c)",self.NguyetAnhNguyenThach,self};
		{"Vỏ Sò Vàng (500)",self.VoSoVang,self};
		{"Rương Vỏ Sò Vàng (5r)",self.RuongVoSoVang,self};
		{"Rương Cao Quý (5r)",self.RuongCaoQuy,self};
		{"Rương Dạ Minh Châu (1r)",self.RuongDaMinhChau,self};
		{"Tu Luyện Đơn (5c)",self.TuLuyenDon,self};
		{">>>",self.VatPham1,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:TanLangHoaThiBich()
Dialog:AskNumber("Số Lượng", 100, self.NhanHTB, self);
end
function tbLiGuan:NhanHTB(szSoLuongHTBNhan)
me.AddStackItem(18,1,377,1,nil,szSoLuongHTBNhan);
end
----------------------------------------------------------------------------------
function tbLiGuan:RuongCaoQuy()
	me.AddItem(18,1,324,1); --Rương vừa đẹp vừa cao quý
	me.AddItem(18,1,324,1); --Rương vừa đẹp vừa cao quý
	me.AddItem(18,1,324,1); --Rương vừa đẹp vừa cao quý
	me.AddItem(18,1,324,1); --Rương vừa đẹp vừa cao quý
	me.AddItem(18,1,324,1); --Rương vừa đẹp vừa cao quý
end
----------------------------------------------------------------------------------
function tbLiGuan:VatPham1()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Tinh lực - Hoạt Lực",self.TinhLucHoatLuc,self};
		{"Ngũ Hành Hồn Thạch (10r)",self.NguHanhHonThach,self};
		{"Ngọc Trúc Mai Hoa (Tháng)",self.NgocTrucMaiHoa,self};
		{"Ngũ Hoa Ngọc Lộ Hoàn (1r)",self.NguHoaNgocLoHoan,self};
		{"Vạn Vật Quy Nguyên Đơn",self.VanVatQuyNguyenDon,self};
		{"Tổ Tiên Bảo Hộ",self.ToTienBaoHo,self};
		{"Bánh Ít Hồ Lô",self.BanhItHoLo,self};
		{"Túi Tân Thủ",self.TuiTanThu,self};
		{"<<<",self.VatPham,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:TuiTanThu()
	me.AddItem(18,1,351,1); --Túi Tân Thủ
end
----------------------------------------------------------------------------------
function tbLiGuan:ChienThuDuLong()
	for i=1,100 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,524,1);
		else
			break
		end
	end
end
----------------------------------------------------------------------------------
function tbLiGuan:BanhItHoLo()
	me.AddItem(18,1,326,4); --Bánh ít hồ lô
end
----------------------------------------------------------------------------------
function tbLiGuan:MoRongRuong()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"LB Mở Rộng Rương 1",self.LBMoRongRuong1,self};
		{"LB Mở Rộng Rương 2",self.LBMoRongRuong2,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsLenhBai,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:LBMoRongRuong1()
	me.AddItem(18,1,216,1); --Lệnh bài mở rộng rương lv1
end

function tbLiGuan:LBMoRongRuong2()
	me.AddItem(18,1,216,2); --Lệnh bài mở rộng rương lv2
end
----------------------------------------------------------------------------------
function tbLiGuan:BuaSuaTrangBi()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Bùa Sửa Phòng Cụ Cường 16",self.BuaSuaPC16,self};
		{"Bùa Sửa Trang Sức Cường 16",self.BuaSuaTS16,self};
		{"Bùa Sửa Vũ Khí Cường 16",self.BuaSuaVK16,self};
		{"<color=pink>Trở Lại Trước<color>",self.VatPham,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:BuaSuaPC16()
	me.AddItem(18,3,1,16); --Bùa sửa phòng cụ cường 16
end

function tbLiGuan:BuaSuaTS16()
	me.AddItem(18,3,2,16); --Bùa sửa trang sức cường 16
end

function tbLiGuan:BuaSuaVK16()
	me.AddItem(18,3,3,16); --Bùa sửa vủ khí cường 16
end
----------------------------------------------------------------------------------
function tbLiGuan:ToTienBaoHo()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Tổ Tiên Bảo Hộ - Thường",self.ToTienBaoHo1, self};
		{"Tổ Tiên Bảo Hộ - Phụng Hoàng",self.ToTienBaoHo2, self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:ToTienBaoHo1()
	me.AddItem(18,1,957,1,0,0); --Tổ Tiên Bảo Hộ Thường
end

function tbLiGuan:ToTienBaoHo2()
	me.AddItem(18,1,957,2,0,0); --Tổ Tiên Bảo Hộ - Phụng Hoàng
end
----------------------------------------------------------------------------------
function tbLiGuan:DuLong()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Du Long Lệnh (Phù)",self.DuLongPhu, self};
		{"Du Long Lệnh (Nón)",self.DuLongNon, self};
		{"Du Long Lệnh (Áo)",self.DuLongAo, self};
		{"Du Long Lệnh (Yêu Đái)",self.DuLongYeuDai, self};
		{"Du Long Lệnh (Giầy)",self.DuLongGiay, self};
		{"Du Long Lệnh (Hạng Liên)",self.DuLongHangLien, self};
		{"<color=pink>Trở Lại Trước<color>",self.lsDuLong,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:DuLongPhu()
	me.AddItem(18,1,529,1,0,1); --Du Long Lệnh Hộ Thân Phù
end

function tbLiGuan:DuLongNon()
	me.AddItem(18,1,529,2,0,1); --Du Long Lệnh Nón
end

function tbLiGuan:DuLongAo()
	me.AddItem(18,1,529,3,0,1); --Du Long Lệnh Áo
end

function tbLiGuan:DuLongYeuDai()
	me.AddItem(18,1,529,4,0,1); --Du Long Lệnh Yêu Đái
end

function tbLiGuan:DuLongGiay()
	me.AddItem(18,1,529,5,0,1); --Du Long Lệnh Giầy
end

function tbLiGuan:DuLongHangLien()
	me.AddItem(18,1,529,6,0,1); --Du Long Lệnh Hạng Liên
end
----------------------------------------------------------------------------------
function tbLiGuan:Tui()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"<color=red>Túi 24 ô (3c)<color>",self.Tui24, self};
		{"Túi Thiên Tằm (24 ô)",self.TuiThienTam, self};
		{"Túi Bàn Long (24 ô)",self.TuiBanLong, self};
		{"Túi Phi Phượng (24 ô)",self.TuiPhiPhuong, self};
		{"Túi Nữ Anh Hùng (24 ô)",self.TuiNuAnhHung, self};
		{"Túi Khởi La (20 ô)",self.TuiKhoiLa, self};
		{"<color=pink>Trở Lại Trước<color>",self.VatPham,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:TuiThienTam()
	me.AddItem(21,9,1,1); --Túi thiên tằm 24 ô
end
	
function tbLiGuan:TuiBanLong()
	me.AddItem(21,9,2,1); --Túi bàn long 24 ô
end

function tbLiGuan:TuiPhiPhuong()
	me.AddItem(21,9,3,1); --Túi Phi Phượng 24 ô
end

function tbLiGuan:TuiNuAnhHung()
	me.AddItem(21,9,6,1,0,1); --Túi Nữ Anh Hùng
end
function tbLiGuan:TuiKhoiLa()
	me.AddItem(21,8,2,1,0,3,1,2,6); --Túi Khởi La, Quân Dụng
end
----------------------------------------------------------------------------------
function tbLiGuan:NguyetAnhNguyenThach()
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
	me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
end
----------------------------------------------------------------------------------
function tbLiGuan:TinhLucHoatLuc()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Tinh Lực (1000000)",self.TinhLuc, self};
		{"Hoạt Lực (1000000)",self.HoatLuc, self};
		{"<color=pink>Trở Lại Trước<color>",self.VatPham1,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:LuyenHoaDo()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Bộ Thủy Hoàng",self.BoThuyHoang, self};
		{"Bộ Trục Lộc",self.BoTrucLoc, self};
		{"Bộ Tiêu Dao",self.BoTieuDao, self};
		{"<color=pink>Trở Lại Trước<color>",self.VatPham,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:BoThuyHoang()
	me.AddItem(18,2,4,3,0,1,9,1,4); -- Thủy Hoàng Y Phục Luyện Hóa Đồ
	me.AddItem(18,2,4,2,0,1,9,1,3); -- Thủy Hoàng Yêu Thụy Luyện Hóa Đồ
	me.AddItem(18,2,4,1,0,1,9,1,2); -- Thủy Hoàng Hộ Uyển Luyện Hóa Đồ
end

function tbLiGuan:BoTrucLoc()
	me.AddItem(18,2,3,1,0,1,8,1,2); --Trục Lộc Mạo Tử Luyện Hóa Đồ
	me.AddItem(18,2,3,2,0,1,8,1,3); --Trục Lộc Yêu Đái Luyện Hóa Đồ
	me.AddItem(18,2,3,3,0,1,8,1,4); --Trục Lộc Hạng Liên Luyện Hóa Đồ
end

function tbLiGuan:BoTieuDao()
	me.AddItem(18,2,1,1,0,1,5,3,2); --Tiêu Dao Hộ Uyển Luyện Hóa Đồ
	me.AddItem(18,2,1,2,0,1,5,3,3); --Tiêu Dao Yêu Trụy Luyện Hóa Đồ
	me.AddItem(18,2,1,3,0,1,5,3,4); --Tiêu Dao Hài Tử Luyện Hóa Đồ
end
----------------------------------------------------------------------------------
function tbLiGuan:VanVatQuyNguyenDon()
    me.AddItem(18,1,384,1);
    me.AddItem(18,1,384,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:VeCuongHoa()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Vé Cường Hóa Vũ Khí <color=red>(Ko Thể Bán)<color>" ,self.VeCuongHoaVuKhi, self};
		{"Vé Cường Hóa Phòng Cụ <color=red>(Ko Thể Bán)<color>" ,self.VeCuongHoaPhongCu, self};
		{"Vé Cường Hóa Trang Sức <color=red>(Ko Thể Bán)<color>" ,self.VeCuongHoaTrangSuc, self};
		{"<color=pink>Trở Lại Trước<color>",self.VatPham,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:VeCuongHoaVuKhi()
	me.AddItem(18,1,518,1,0,1); --Vé Cường Hóa Vũ Khí
end

function tbLiGuan:VeCuongHoaPhongCu()
	me.AddItem(18,1,519,1,0,1); --Vé Cường Hóa Phòng Cụ
end

function tbLiGuan:VeCuongHoaTrangSuc()
	me.AddItem(18,1,520,1,0,1); --Vé Cường Hóa Trang Sức
end
----------------------------------------------------------------------------------
function tbLiGuan:lsThuCuoiDongHanh()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Thú Cưỡi" ,self.lsThuCuoi, self};
		{"Đồng Hành" ,self.lsDongHanh, self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsThuCuoi()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Dây Cương Thần Bí" ,self.DayCuongThanBi, self};
		{"Phiên Vũ" ,self.PhienVu, self};
		{"Hoan Hoan" ,self.HoanHoan, self};
		{"Hoan Hoan Có Kháng" ,self.HoanHoan1, self};
		{"Hỷ Hỷ" ,self.HyHy, self};
		{"Hỷ Hỷ Có Kháng" ,self.HyHy1, self};
		{"Hổ Cát Tường" ,self.HoCatTuong, self};
		{"Trục Nhật" ,self.TrucNhat, self};
		{"Trục Nhật <color=red>(Ko Bán Được)<color>" ,self.TrucNhat0, self};
		{"Trục Nhật Có Kháng (2)" ,self.TrucNhat1, self};
		{">>>" ,self.lsThuCuoi1, self};
		{"<color=pink>Trở Lại Trước<color>",self.lsThuCuoiDongHanh,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:DayCuongThanBi()
	me.AddItem(18,1,237,1); --Dây cương thần bí
end
----------------------------------------------------------------------------------
function tbLiGuan:lsThuCuoi1()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Lăng Thiên" ,self.LangThien, self};
		{"Lăng Thiên <color=red>(Ko Bán Được)<color>" ,self.LangThien0, self};
		{"Lăng Thiên Có Kháng<color=red>(Ko Bán Được)<color>" ,self.LangThien1, self};
		{"Lăng Thiên Có Kháng" ,self.LangThien2, self};
		{"Hỏa Kỳ Lân" ,self.HoaKyLan, self};
		{"Tuyết Hồn <color=red>(Ko Bán Được)<color>" ,self.TuyetHon, self};
		{"Siêu Nhân Lạc Đà" ,self.TuyetHon1, self};
		{"Sư Tư Hung Dữ" ,self.TuyetHon2, self};
		{"Xích Thố Có Kháng (3)" ,self.XichTho, self};
		{"Bôn Tiêu Có Kháng" ,self.BonTieu, self};
		{"Ức Vân" ,self.UcVan, self};
		{"Ức Vân Có Kháng +Skill <color=red>(Ko Bán Được)<color>" ,self.UcVan1, self};
		{"<<<" ,self.lsThuCuoi, self};
		{"<color=pink>Trở Lại Trước<color>",self.lsThuCuoiDongHanh,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsDongHanh()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Bạn Đồng Hành" ,self.BanDongHanh, self};
		{"Mật Tịch Đồng Hành" ,self.MatTichDongHanh, self};
		{"Nguyên Liệu Đồng Hành" ,self.NguyenLieuDongHanh, self};
		{"Sách Kinh Nghiệm Đồng Hành" ,self.lsSachKinhNghiemDongHanh, self};
		{"Thiệp Bạc - Thiệp Lụa" ,self.ThiepBacThiepLua, self};
		{"Tinh Phách" ,self.TinhPhach, self};
		{"Chuyển Sinh PET - Bồ Đề Quả",self.lsChuyenSinhPet,self};
		{"Thư Đồng Hành",self.ThuDongHanh,self};
		{"Bạch Ngân Tinh Hoa",self.BachNganTinhHoa,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsThuCuoiDongHanh,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:BachNganTinhHoa()
	me.AddItem(18,1,565,1); --bạch ngân tinh hoa
end
----------------------------------------------------------------------------------
function tbLiGuan:ThuDongHanh()
    me.AddItem(18,1,566,1,0,1); --Thư Đồng Hành
end
----------------------------------------------------------------------------------
function tbLiGuan:lsChuyenSinhPet()
    me.AddItem(18,1,564,1); --Bồ Đề Quả - Chuyển sinh cho PET
end
----------------------------------------------------------------------------------
function tbLiGuan:BonTieu()
	me.AddItem(1,12,35,4); --Bôn tiêu có kháng, bán đc
end

function tbLiGuan:UcVan()
	me.AddItem(1,12,40,4); --Ức vân ko kháng, bán đc
end

function tbLiGuan:UcVan1()
	me.AddItem(1,12,47,4); --Ức vân có kháng +skill, ko bán đc
end

function tbLiGuan:XichTho()
	me.AddItem(1,12,45,4); --Xích thố có kháng, bán đc
	me.AddItem(1,12,34,4); --Xích thố có kháng, bán đc
	me.AddGeneralEquip(12,34,4); --Xích thố có kháng, bán đc
end

function tbLiGuan:TrucNhat1()
	me.AddItem(1,12,38,4); --Trục Nhật Có kháng, bán đc
	me.AddItem(1,12,43,4); --Trục Nhật có kháng, bán đc
end
----------------------------------------------------------------------------------
function tbLiGuan:PhienVu()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"PV Thường" ,self.PhienVu1, self};
		{"PV Có Kỹ Năng" ,self.PhienVu2, self};
		{"PV Có Kỹ Năng-Kháng <color=red>(Ko Khóa,Ko Bán)<color>" ,self.PhienVu3, self};
		{"PV Có Kỹ Năng-Kháng <color=red>(Khóa,Bán Được)<color>" ,self.PhienVu4, self};
		{"<color=pink>Trở Lại Trước<color>",self.lsThuCuoi,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:PhienVu1()
	me.AddItem(1,12,24,4);--Ngựa Phiên vũ ko có kĩ năng,không có kháng
end

function tbLiGuan:tuyetthe()
	me.AddItem(1,12,55,4);--Ngựa Phiên vũ ko có kĩ năng,không có kháng
end

function tbLiGuan:hanhuyet()
	me.AddItem(1,12,61,4);--Ngựa Phiên vũ ko có kĩ năng,không có kháng
end

function tbLiGuan:PhienVu2()
	me.AddItem(1,12,12,4);--Ngựa Phiên vũ có kĩ năng ko có kháng
end

function tbLiGuan:PhienVu3()
	me.AddItem(1,12,33,4);--Ngựa Phiên vũ tốt nhất Ko Khóa, Ko thể bán
end

function tbLiGuan:PhienVu4()
	me.AddItem(1,12,20001,4); --Phiên Vũ VIP - Khóa, có thể bán
end

function tbLiGuan:HoanHoan()
	me.AddItem(1,12,25,4); --Hoan Hoan
end

function tbLiGuan:HoanHoan1()
	me.AddItem(1,12,36,4); --Hoan Hoan có kháng, bán đc
end

function tbLiGuan:HyHy()
	me.AddItem(1,12,26,4); --Hỷ Hỷ
end

function tbLiGuan:HyHy1()
	me.AddItem(1,12,37,4); --Hỷ Hỷ có kháng, bán đc
end

function tbLiGuan:HoCatTuong()
	me.AddItem(1,12,27,4); --Hổ Cát Tường
end

function tbLiGuan:TrucNhat()
	me.AddItem(1,12,28,4); --Trục Nhật
end

function tbLiGuan:TrucNhat0()
	me.AddItem(1,12,28,4,0,1); --Trục Nhật ko bán đc
end
	
function tbLiGuan:LangThien()
	me.AddItem(1,12,29,4); --Lăng Thiên
end

function tbLiGuan:LangThien0()
	me.AddItem(1,12,29,4,0,1); --Lăng Thiên ko bán đc
end

function tbLiGuan:LangThien1()
	me.AddItem(1,12,44,4); --Lăng thiên, có kháng, ko bán đc
end

function tbLiGuan:LangThien2()
	me.AddItem(1,12,39,4); --Lăng thiên có kháng, bán đc
end

function tbLiGuan:HoaKyLan()
	me.AddItem(1,12,49,4); --Hỏa Kỳ Lân
end

function tbLiGuan:TuyetHon()
	me.AddItem(1,12,20000,4); --Tuyết Hồn
end

function tbLiGuan:TuyetHon1()
	me.AddItem(1,12,55,4); --Tuyết hồn ko kháng, bán đc
	me.AddItem(1,12,54,4); --Tuyết hồn ko kháng, bán đc
	me.AddItem(1,12,61,4); --Tuyết hồn ko kháng, bán đc
	me.AddItem(1,12,52,4); --Tuyết hồn ko kháng, bán đc
	me.AddItem(1,12,53,4); --Tuyết hồn ko kháng, bán đc
end

function tbLiGuan:TuyetHon2()
	me.AddItem(1,12,62,4); --Tuyết hồn có kháng, bán đc
	me.AddItem(1,12,62,5); --Tuyết hồn có kháng, bán đc
	me.AddItem(1,12,62,6); --Tuyết hồn có kháng, bán đc
	me.AddItem(1,12,62,7); --Tuyết hồn có kháng, bán đc
	me.AddItem(1,12,62,8); --Tuyết hồn có kháng, bán đc
	me.AddItem(1,12,62,9); --Tuyết hồn có kháng, bán đc
	me.AddItem(1,12,62,10); --Tuyết hồn có kháng, bán đc
	me.AddItem(1,12,62,11); --Tuyết hồn có kháng, bán đc
	me.AddItem(1,12,62,13); --Tuyết hồn có kháng, bán đc
end
----------------------------------------------------------------------------------
function tbLiGuan:BacDong()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Nhận Bạc Thường (1000v)",self.BacThuong,self};
		{"Nhận Bạc Khóa (1000v)",self.BacKhoa,self};
		{"Nhận Đồng Thường (500v)",self.DongThuong,self};
		{"Nhận Đồng Khóa (500v)",self.DongKhoa,self};
		{"Nhận Thỏi Đồng (1000v đồng khóa)",self.ThoiDong,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsSachKinhNghiemDongHanh()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Sách KN Đồng Hành Thường (10Q)" ,self.SachKinhNghiemDongHanh1, self};
		{"Sách KN Đồng Hành Đặc Biệt (10Q)" ,self.SachKinhNghiemDongHanh2, self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:TinhPhach()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Tinh Phách Thường" ,self.TinhPhachThuong, self};
		{"Tinh Phách Đặc Biệt" ,self.TinhPhachDacBiet, self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:ThoiBac()
	me.AddItem(18,1,284,2); --Thỏi Bạc (  )
end
----------------------------------------------------------------------------------
function tbLiGuan:ThoiDong()
	me.AddItem(18,1,118,2); --Thỏi Đồng (1000 0000 đồng khóa)
end
----------------------------------------------------------------------------------
function tbLiGuan:TinhPhachThuong()
	me.AddItem(18,1,544,1,0,1); --Tinh Phách Thường
end

function tbLiGuan:TinhPhachDacBiet()
	me.AddItem(18,1,544,2,0,1); --Tinh Phách Đặc Biệt
end
----------------------------------------------------------------------------------
function tbLiGuan:BanDongHanh()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Bạn Đồng Hành 4 Kỹ Năng" ,self.BanDongHanh4, self};
		{"Bạn Đồng Hành 6 Kỹ Năng" ,self.BanDongHanh6, self};
		{"ĐH Thiên Thiên 6 Kỹ Năng" ,self.ThienThien6KN, self};
		{"ĐH Bảo Ngọc 6 Kỹ Năng" ,self.BaoNgoc6KN, self};
		{"ĐH Diệp Tịnh 5 Kỹ Năng" ,self.DiepTinh5KN, self};
		{"ĐH Bảo Ngọc 5 Kỹ Năng" ,self.BaoNgoc5KN, self};
		{"ĐH Tử Uyển 4 Kỹ Năng" ,self.TuUyen4KN, self};
		{"ĐH Hạ Tiểu Sảnh 4 Kỹ Năng" ,self.HaTieuSanh4KN, self};
		{"ĐH Diệp Tịnh 6 Kỹ Năng" ,self.DiepTinh6KN, self};
		{"ĐH Tiêu Bất Thực 5 Kỹ Năng" ,self.TieuBatThuc5KN, self};
		{"ĐH Hạ Hầu Tiểu Tiểu 4 Kỹ Năng" ,self.HaHauTieuTieu4KN, self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:ThienThien6KN()
	me.AddItem(18,1,666,9); --ĐH thiên thiên 6 KN
end

function tbLiGuan:BaoNgoc6KN()
	me.AddItem(18,1,666,8); --ĐH Bảo ngọc 6KN
end

function tbLiGuan:DiepTinh5KN()
	me.AddItem(18,1,666,7); --ĐH Diệp tịnh 5KN
end

function tbLiGuan:BaoNgoc5KN()
	me.AddItem(18,1,666,6); --ĐH Bảo ngọc 5KN
end

function tbLiGuan:TuUyen4KN()
	me.AddItem(18,1,666,5); --ĐH Tử Uyển 4KN
end

function tbLiGuan:TuUyen4KN()
	me.AddItem(18,1,666,4); --ĐH Hạ Tiểu Sảnh 4KN
end

function tbLiGuan:DiepTinh6KN()
	me.AddItem(18,1,666,3); --ĐH Diệp Tịnh 6KN
end

function tbLiGuan:TieuBatThuc5KN()
	me.AddItem(18,1,666,2); --ĐH Tiêu Bất Thực 5KN
end

function tbLiGuan:HaHauTieuTieu4KN()
	me.AddItem(18,1,666,1); --ĐH Hạ Hầu Tiểu Tiểu 4KN
end
----------------------------------------------------------------------------------
function tbLiGuan:ThiepBacThiepLua()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {
		{"Thiệp Bạc" ,self.ThiepBac, self};
		{"Thiệp Lụa" ,self.ThiepLua, self};
		{"Rương Thiệp Lụa" ,self.RuongThiepLua, self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:HuyenTinh()
	local szMsg = "Tụ Hội Kiếm";
	local tbOpt =
	{
		{"Huyền tinh 1",self.HuyenTinh1,self};
		{"Huyền tinh 2",self.HuyenTinh2,self};
		{"Huyền tinh 3",self.HuyenTinh3,self};
		{"Huyền tinh 4",self.HuyenTinh4,self};
		{"Huyền tinh 5",self.HuyenTinh5,self};
		{"Huyền tinh 6",self.HuyenTinh6,self};
		{"Huyền tinh 7",self.HuyenTinh7,self};
		{"Huyền tinh 8",self.HuyenTinh8,self};
		{"Huyền tinh 9",self.HuyenTinh9,self};
		{"Huyền tinh 10",self.HuyenTinh10,self};
		{"Huyền tinh 11",self.HuyenTinh11,self};
		{"Huyền tinh 12",self.HuyenTinh12,self};
		{"<color=pink>Trở Lại Trước<color>",self.VatPham,self};
	}
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:HuyenTinh1()
Dialog:AskNumber("Số Lượng", 100, self.NhanHT1, self);
end
function tbLiGuan:NhanHT1(szSoLuongHT1Nhan)
me.AddStackItem(18,1,1,1,nil,szSoLuongHT1Nhan);
end
--
function tbLiGuan:HuyenTinh2()
Dialog:AskNumber("Số Lượng", 100, self.NhanHT2, self);
end
function tbLiGuan:NhanHT2(szSoLuongHT2Nhan)
me.AddStackItem(18,1,1,2,nil,szSoLuongHT2Nhan);
end
--
function tbLiGuan:HuyenTinh3()
Dialog:AskNumber("Số Lượng", 100, self.NhanHT3, self);
end
function tbLiGuan:NhanHT3(szSoLuongHT3Nhan)
me.AddStackItem(18,1,1,3,nil,szSoLuongHT3Nhan);
end
--
function tbLiGuan:HuyenTinh4()
Dialog:AskNumber("Số Lượng", 100, self.NhanHT4, self);
end
function tbLiGuan:NhanHT4(szSoLuongHT4Nhan)
me.AddStackItem(18,1,1,4,nil,szSoLuongHT4Nhan);
end
--
function tbLiGuan:HuyenTinh5()
Dialog:AskNumber("Số Lượng", 100, self.NhanHT5, self);
end
function tbLiGuan:NhanHT5(szSoLuongHT5Nhan)
me.AddStackItem(18,1,1,5,nil,szSoLuongHT5Nhan);
end
--
function tbLiGuan:HuyenTinh6()
Dialog:AskNumber("Số Lượng", 100, self.NhanHT6, self);
end
function tbLiGuan:NhanHT6(szSoLuongHT6Nhan)
me.AddStackItem(18,1,1,6,nil,szSoLuongHT6Nhan);
end
--
function tbLiGuan:HuyenTinh7()
Dialog:AskNumber("Số Lượng", 100, self.NhanHT7, self);
end
function tbLiGuan:NhanHT7(szSoLuongHT7Nhan)
me.AddStackItem(18,1,1,7,nil,szSoLuongHT7Nhan);
end
--
function tbLiGuan:HuyenTinh8()
Dialog:AskNumber("Số Lượng", 100, self.NhanHT8, self);
end
function tbLiGuan:NhanHT8(szSoLuongHT8Nhan)
me.AddStackItem(18,1,1,8,nil,szSoLuongHT8Nhan);
end
--
function tbLiGuan:HuyenTinh9()
Dialog:AskNumber("Số Lượng", 100, self.NhanHT9, self);
end
function tbLiGuan:NhanHT9(szSoLuongHT9Nhan)
me.AddStackItem(18,1,1,9,nil,szSoLuongHT9Nhan);
end
--
function tbLiGuan:HuyenTinh10()
Dialog:AskNumber("Số Lượng", 100, self.NhanHT10, self);
end
function tbLiGuan:NhanHT10(szSoLuongHT10Nhan)
me.AddStackItem(18,1,1,10,nil,szSoLuongHT10Nhan);
end
--
function tbLiGuan:HuyenTinh11()
Dialog:AskNumber("Số Lượng", 100, self.NhanHT11, self);
end
function tbLiGuan:NhanHT11(szSoLuongHT11Nhan)
me.AddStackItem(18,1,1,11,nil,szSoLuongHT11Nhan);
end
--
function tbLiGuan:HuyenTinh12()
Dialog:AskNumber("Số Lượng", 100, self.NhanHT12, self);
end
function tbLiGuan:NhanHT12(szSoLuongHT12Nhan)
me.AddStackItem(18,1,1,12,nil,szSoLuongHT12Nhan);
end
--
----------------------------------------------------------------------------------
function tbLiGuan:lsDiemKinhNghiem()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = { 		
		{">>>",self.lsDiemKinhNghiem1,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsDiemKinhNghiem1()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = { 		
		{"Nhận Kinh Nghiệm Cấp 255<color>",self.LenLevel180,self};
		{"Bánh Ít Thịt Heo (10c)",self.BanhItThitHeo,self};
		{"<<<",self.lsDiemKinhNghiem,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:BanhItThitHeo()
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
	me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
end
----------------------------------------------------------------------------------
function tbLiGuan:lsTiemNangKyNang()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = { 		
--		{"Skill 120",self.skill120, self};	
	    {"Mật Tịch Cao",self.MatTichCao, self};
		{"<color=red>Luyện Max Skill Mật Tịch Trung<color>",self.lsMatTichTrung,self};
		{"<color=red>Luyện Max Skill Mật Tịch Cao<color>",self.lsMatTichCao,self};
		{"Võ Lâm Mật Tịch - Tẩy Tủy",self.VoLamTayTuy,self};
		{"Bánh Tiềm Năng - Kỹ Năng",self.BanhTrai,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsMatTichTrung()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {};
	table.insert(tbOpt , {"Thiếu Lâm",  self.tl70, self});
	table.insert(tbOpt , {"Thiên Vương",  self.tv70, self});
	table.insert(tbOpt , {"Đường môn",  self.dm70, self});
	table.insert(tbOpt , {"Ngũ Độc",  self.nd70, self});
	table.insert(tbOpt , {"Minh giáo",  self.mg70, self});
	table.insert(tbOpt , {"Nga My",  self.nm70, self});
	table.insert(tbOpt , {"Thúy Yên",  self.ty70, self});
	table.insert(tbOpt , {"Đoàn Thị",  self.dt70, self});
	table.insert(tbOpt , {"Cái Bang",  self.cb70, self});
	table.insert(tbOpt , {"Thiên Nhẫn",  self.tn70, self});
	table.insert(tbOpt , {"Võ Đang",  self.vd70, self});
	table.insert(tbOpt , {"Côn Lôn",  self.cl70, self});
	table.insert(tbOpt, {"Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:tl70()
	me.AddFightSkill(1200,10);
    me.AddFightSkill(1201,10);
end

function tbLiGuan:tv70()		
    me.AddFightSkill(1202,10);
end

function tbLiGuan:dm70()
	me.AddFightSkill(1203,10);
    me.AddFightSkill(1204,10);
end

function tbLiGuan:nd70()		
	me.AddFightSkill(1205,10);
    me.AddFightSkill(1206,10);
end

function tbLiGuan:mg70()		
	me.AddFightSkill(1219,10);
    me.AddFightSkill(1220,10);
end

function tbLiGuan:nm70()
	me.AddFightSkill(1207,10);
    me.AddFightSkill(1208,10);
end

function tbLiGuan:ty70()		
	me.AddFightSkill(1209,10);
    me.AddFightSkill(1210,10);
end

function tbLiGuan:dt70()		
	me.AddFightSkill(1221,10);
    me.AddFightSkill(1222,10);
end

function tbLiGuan:cb70()
	me.AddFightSkill(1211,10);
	me.AddFightSkill(1212,10);
end

function tbLiGuan:tn70()		
    me.AddFightSkill(1213,10);
	me.AddFightSkill(1214,10);
end

function tbLiGuan:vd70()
	me.AddFightSkill(1215,10);
	me.AddFightSkill(1216,10);
end

function tbLiGuan:cl70()		
	me.AddFightSkill(1217,10);
	me.AddFightSkill(1218,10);
end
----------------------------------------------------------------------------------
function tbLiGuan:lsMatTichCao()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {};
	table.insert(tbOpt , {"Thiếu Lâm",  self.tl100, self});
	table.insert(tbOpt , {"Thiên Vương",  self.tv100, self});
	table.insert(tbOpt , {"Đường môn",  self.dm100, self});
	table.insert(tbOpt , {"Ngũ Độc",  self.nd100, self});
	table.insert(tbOpt , {"Minh giáo",  self.mg100, self});
	table.insert(tbOpt , {"Nga My",  self.nm100, self});
	table.insert(tbOpt , {"Thúy Yên",  self.ty100, self});
	table.insert(tbOpt , {"Đoàn Thị",  self.dt100, self});
	table.insert(tbOpt , {"Cái Bang",  self.cb100, self});
	table.insert(tbOpt , {"Thiên Nhẫn",  self.tn100, self});
	table.insert(tbOpt , {"Võ Đang",  self.vd100, self});
	table.insert(tbOpt , {"Côn Lôn",  self.cl100, self});
	table.insert(tbOpt, {"Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:tl100()
	me.AddFightSkill(1241,10);
    me.AddFightSkill(1242,10);
end

function tbLiGuan:tv100()		
    me.AddFightSkill(1243,10);
    me.AddFightSkill(1244,10);
end

function tbLiGuan:dm100()
	me.AddFightSkill(1245,10);
    me.AddFightSkill(1246,10);
end

function tbLiGuan:nd100()		
	me.AddFightSkill(1247,10);
    me.AddFightSkill(1248,10);
end

function tbLiGuan:mg100()		
	me.AddFightSkill(1261,10);
    me.AddFightSkill(1262,10);
end

function tbLiGuan:nm100()
	me.AddFightSkill(1249,10);
    me.AddFightSkill(1250,10);
end

function tbLiGuan:ty100()		
	me.AddFightSkill(1251,10);
    me.AddFightSkill(1252,10);
end

function tbLiGuan:dt100()		
	me.AddFightSkill(1263,10);
    me.AddFightSkill(1264,10);
end

function tbLiGuan:cb100()
	me.AddFightSkill(1253,10);
	me.AddFightSkill(1254,10);
end

function tbLiGuan:tn100()		
    me.AddFightSkill(1255,10);
	me.AddFightSkill(1256,10);
end

function tbLiGuan:vd100()
	me.AddFightSkill(1257,10);
	me.AddFightSkill(1258,10);
end

function tbLiGuan:cl100()		
	me.AddFightSkill(1259,10);
	me.AddFightSkill(1260,10);
end
----------------------------------------------------------------------------------
function tbLiGuan:VoLamTayTuy()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = { 		
		{"Võ Lâm Mật Tịch",self.VoLamMatTich,self};
		{"Tẩy Tủy Kinh",self.TayTuyKinh,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:LenLevel10()
	me.AddLevel(10 - me.nLevel);
end

function tbLiGuan:LenLevel20()
	me.AddLevel(20 - me.nLevel);
end

function tbLiGuan:LenLevel30()
	me.AddLevel(30 - me.nLevel);
end

function tbLiGuan:LenLevel40()
	me.AddLevel(40 - me.nLevel);
end

function tbLiGuan:LenLevel50()
	me.AddLevel(50 - me.nLevel);
end

function tbLiGuan:LenLevel60()
	me.AddLevel(60 - me.nLevel);
end

function tbLiGuan:LenLevel70()
	me.AddLevel(70 - me.nLevel);
end

function tbLiGuan:LenLevel80()
	me.AddLevel(80 - me.nLevel);
end

function tbLiGuan:LenLevel90()
	me.AddLevel(90 - me.nLevel);
end

function tbLiGuan:LenLevel100()
	me.AddLevel(100 - me.nLevel);
end

function tbLiGuan:LenLevel110()
	me.AddLevel(110 - me.nLevel);
end

function tbLiGuan:LenLevel120()
	me.AddLevel(120 - me.nLevel);
end

function tbLiGuan:LenLevel130()
	me.AddLevel(130 - me.nLevel);
end

function tbLiGuan:LenLevel140()
	me.AddLevel(140 - me.nLevel);
end

function tbLiGuan:LenLevel180()
	me.AddLevel(255 - me.nLevel);
end	
----------------------------------------------------------------------------------
function tbLiGuan:DiemTiemNang()
		me.AddPotential(1000)
end
----------------------------------------------------------------------------------
function tbLiGuan:DiemKyNang()
		me.AddFightSkillPoint(20)
end
----------------------------------------------------------------------------------
function tbLiGuan:DiemKinhNghiem()
		me.AddExp(100000000);
end
----------------------------------------------------------------------------------
function tbLiGuan:vdkiem() 
	if me.nFaction > 0 then 
		if me.nFaction == 9 then 
			me.AddFightSkill(163 ,54);  -- Thê Vân Tung 
			me.AddFightSkill(499 ,28);  -- Thái Nhất Chân Khí 
            me.AddFightSkill(170 ,54);  -- Thất Tinh Quyết 
		end
	end
end
----------------------------------------------------------------------------------
function tbLiGuan:MaxSkillMonPhai() 
    if me.nFaction > 0 then 
        if me.nFaction == 1 then    --Skill Thiếu Lâm 
            --Skill Đao Thiếu 
            me.AddFightSkill(21,54);    --Phục Ma Đao Pháp 
            me.AddFightSkill(22,54);    --Thiếu Lâm Đao Pháp 
            me.AddFightSkill(23,54);    --Dịch Cốt Kinh 
            me.AddFightSkill(25,54);    --A La Hán Thần Công 
            me.AddFightSkill(24,54);    --Phá Giới Đao Pháp 
            me.AddFightSkill(250,54);    --Hàng Long Phục Hổ 
            me.AddFightSkill(26,54);    --Bồ Đề Tâm Pháp 
            me.AddFightSkill(28,54);    --Hỗn Nguyên Nhất Khí 
            me.AddFightSkill(27,54);    --Thiên Trúc Tuyệt Đao 
            me.AddFightSkill(252,54);    --Như Lai Thiên Diệp 
            me.AddFightSkill(819,54);    --Thiền Nguyên Công 
            me.AddFightSkill(820,54);    --Kỹ năng cấp 120 
             
            --Skill Côn Thiếu 
            me.AddFightSkill(29,54);    --Phổ Độ Côn Pháp 
            me.AddFightSkill(30,54);    --Thiếu Lâm Côn Pháp 
            me.AddFightSkill(31,54);    --Sư Tử Hống 
            me.AddFightSkill(25,54);    --A La Hán Thần Công 
            me.AddFightSkill(33,54);    --Phục Ma Côn Pháp 
            me.AddFightSkill(34,54);    --Bất Động Minh Vương 
            me.AddFightSkill(254,54);    --Dịch Cốt Kinh 
            me.AddFightSkill(37,54);    --Đạt Ma Vũ Kinh 
            me.AddFightSkill(36,54);    --Thất Tinh La Sát Côn 
            me.AddFightSkill(255,54);    --Vô Tướng Thần Công 
            me.AddFightSkill(821,54);    --Túy Bát Tiên Côn 
            me.AddFightSkill(822,54);    --Kỹ năng cấp 120 
             
        elseif me.nFaction == 2 then    --Skill Thiên Vương 
            --Thương Thiên 
            me.AddFightSkill(38,54);    --Hồi Phong Lạc Nhạn 
            me.AddFightSkill(40,54);    --Thiên Vương Thương Pháp 
            me.AddFightSkill(41,54);    --Đoạn Hồn Thích     
            me.AddFightSkill(45,54);    --Tĩnh Tâm Quyết 
            me.AddFightSkill(43,54);    --Dương Quan Tam Điệp 
            me.AddFightSkill(256,54);    --Kinh Lôi Phá Thiên 
            me.AddFightSkill(46,54);    --Thiên Vương Chiến Ý     
            me.AddFightSkill(49,54);    --Thiên Canh Chiến Khí     
            me.AddFightSkill(47,54);    --Truy Tinh Trục Nguyệt 
            me.AddFightSkill(259,54);    --Huyết Chiến Bát Phương     
            me.AddFightSkill(823,54);    --Bôn Lôi Toàn Long Thương     
            me.AddFightSkill(824,54);    --Kỹ năng cấp 120                 
             
            --Chùy Thiên 
            me.AddFightSkill(50,54);    --Hành Vân Quyết 
            me.AddFightSkill(52,54);    --Thiên Vương Chùy Pháp 
            me.AddFightSkill(41,54);    --Đoạn Hồn Thích 
            me.AddFightSkill(781,54);    --Tĩnh Tâm Thuật 
            me.AddFightSkill(53,54);    --Truy Phong Quyết 
            me.AddFightSkill(260,54);    --Thiên Vương Bản Sinh 
            me.AddFightSkill(55,54);    --Kim Chung Tráo 
            me.AddFightSkill(58,54);    --Đảo Hư Thiên 
            me.AddFightSkill(56,54);    --Thừa Long Quyết 
            me.AddFightSkill(262,54);    --Bất Diệt Sát Ý 
            me.AddFightSkill(825,54);    --Trảm Long Quyết 
            me.AddFightSkill(826,54);    --Kỹ năng cấp 120         
         
        elseif me.nFaction == 3 then    --Đường Môn 
            --Hãm Tĩnh 
            me.AddFightSkill(69,54);    --Độc Thích Cốt 
            me.AddFightSkill(70,54);    --Đường Môn Hãm Tĩnh 
            me.AddFightSkill(64,54);    --Mê Ảnh Tung     
            me.AddFightSkill(71,54);    --Câu Hồn Tĩnh 
            me.AddFightSkill(72,54);    --Tiểu Lý Phi Đao 
            me.AddFightSkill(263,54);    --Hấp Tinh Trận 
            me.AddFightSkill(73,54);    --Triền Thân Thích     
            me.AddFightSkill(75,54);    --Tâm Phách     
            me.AddFightSkill(74,54);    --Loạn Hoàn Kích 
            me.AddFightSkill(265,54);    --Thực Cốt Huyết Nhẫn     
            me.AddFightSkill(827,54);    --Cơ Quan Bí Thuật     
            me.AddFightSkill(828,54);    --Kỹ năng cấp 120     
            --Tụ Tiễn 
            me.AddFightSkill(59,54);    --Truy Tâm Tiễn 
            me.AddFightSkill(60,54);    --Đường Môn Tụ Tiễn 
            me.AddFightSkill(64,54);    --Mê Ảnh Tung     
            me.AddFightSkill(61,54);    --Tôi Độc Thuật 
            me.AddFightSkill(62,54);    --Thiên La Địa Võng 
            me.AddFightSkill(266,54);    --Đoạn Cân Nhẫn 
            me.AddFightSkill(65,54);    --Ngự Độc Thuật     
            me.AddFightSkill(68,54);    --Tâm Ma     
            me.AddFightSkill(66,54);    --Bạo Vũ Lê Hoa 
            me.AddFightSkill(268,54);    --Tâm Nhãn     
            me.AddFightSkill(829,54);    --Thất Tuyệt Sát Quang     
            me.AddFightSkill(830,54);    --Kỹ năng cấp 120     
             
        elseif me.nFaction == 4 then    --Ngũ Độc 
            --Đao Độc 
            me.AddFightSkill(76 ,54);  -- Huyết Đao Độc Sát 
            me.AddFightSkill(77 ,54);  -- Ngũ Độc Đao Pháp 
            me.AddFightSkill(78 ,54);  -- Vô Hình Cổ 
            me.AddFightSkill(81 ,54);  -- Thí Độc Thuật 
            me.AddFightSkill(80 ,54);  -- Bách Độc Xuyên Tâm 
            me.AddFightSkill(269 ,54);  -- Ôn Cổ Chi Khí 
            me.AddFightSkill(82 ,54);  -- Vạn Cổ Thực Tâm 
            me.AddFightSkill(85 ,54);  -- Ngũ Độc Kỳ Kinh 
            me.AddFightSkill(83 ,54);  -- Huyền Âm Trảm 
            me.AddFightSkill(271 ,54);  -- Thiên Thù Vạn Độc 
            me.AddFightSkill(831 ,54);  -- Chu Cáp Thanh Minh 
            me.AddFightSkill(832 ,54);  -- Kỹ năng cấp 120 
            --Chưởng Độc 
            me.AddFightSkill(86 ,54);  -- Độc Sa Chưởng 
            me.AddFightSkill(87 ,54);  -- Ngũ Độc Chưởng Pháp 
            me.AddFightSkill(92 ,54);  -- Xuyên Tâm Độc Thích 
            me.AddFightSkill(91 ,54);  -- Ngân Ti Phi Thù 
            me.AddFightSkill(90 ,54);  -- Thiên Chuc Địa Sát 
            me.AddFightSkill(272 ,54);  -- Khu Độc Thuật 
            me.AddFightSkill(88 ,54);  -- Bi Ma Huyết Quang 
            me.AddFightSkill(95 ,54);  -- Bách Cổ Độc Kinh 
            me.AddFightSkill(93 ,54);  -- Âm Phong Thực Cốt 
            me.AddFightSkill(274 ,54);  -- Đoạn Cân Hủ Cốt 
            me.AddFightSkill(833 ,54);  -- Hóa Cốt Miên Chưởng 
            me.AddFightSkill(834 ,54);  -- Kỹ năng cấp 120 
             
        elseif me.nFaction == 5 then    --Nga My 
            --Chưởng Nga 
            me.AddFightSkill(96 ,54);  -- Phiêu Tuyết Xuyên Vân 
            me.AddFightSkill(97 ,54);  -- Nga My Chưởng Pháp 
            me.AddFightSkill(98 ,54);  -- Từ Hàng Phổ Độ 
            me.AddFightSkill(101 ,54);  -- Phật Tâm Từ Hựu 
            me.AddFightSkill(99 ,54);  -- Tứ Tượng Đồng Quy 
            me.AddFightSkill(479 ,54);  -- Bất Diệt Bất Tuyệt 
            me.AddFightSkill(782 ,54);  -- Lưu Thủy Tâm Pháp 
            me.AddFightSkill(105 ,54);  -- Phật Pháp Vô Biên 
            me.AddFightSkill(103 ,54);  -- Phong Sương Toái Ảnh 
            me.AddFightSkill(280 ,54);  -- Vạn Phật Quy Tông 
            me.AddFightSkill(835 ,54);  -- Phật Quang Chiến Khí 
            me.AddFightSkill(836 ,54);  -- Kỹ năng cấp 120 
             
            --Phụ Trợ 
            me.AddFightSkill(107 ,54);  -- Phật Âm Chiến Ý 
            me.AddFightSkill(106 ,54);  -- Mộng Điệp 
            me.AddFightSkill(98 ,54);  -- Từ Hàng Phổ Độ 
            me.AddFightSkill(101 ,54);  -- Phật Tâm Từ Hựu 
            me.AddFightSkill(109 ,54);  -- Thiên Phật Thiên Diệp 
            me.AddFightSkill(110 ,54);  -- Phật Quang Phổ Chiếu 
            me.AddFightSkill(102 ,54);  -- Lưu Thủy Quyết 
            me.AddFightSkill(481 ,54);  -- Ba La Tâm Kinh 
            me.AddFightSkill(108 ,54);  -- Thanh Âm Phạn Xướng 
            me.AddFightSkill(482 ,54);  -- Phổ Độ Chúng Sinh 
            me.AddFightSkill(837 ,54);  -- Kiếm Ảnh Phật Quang 
            me.AddFightSkill(838 ,54);  -- Kỹ năng cấp 120 
             
        elseif me.nFaction == 6 then    --Thúy Yên 
            --Kiếm Thúy 
            me.AddFightSkill(111 ,54);  -- Phong Quyển Tàn Tuyết 
            me.AddFightSkill(112 ,54);  -- Thúy Yên Kiếm Pháp 
            me.AddFightSkill(113 ,54);  -- Hộ Thể Hàn Băng 
            me.AddFightSkill(115 ,54);  -- Tuyết Ảnh 
            me.AddFightSkill(114 ,54);  -- Bích Hải Triều Sinh 
            me.AddFightSkill(483 ,54);  -- Huyền Băng Vô Tức 
            me.AddFightSkill(116 ,54);  -- Tuyết Ánh Hồng Trần 
            me.AddFightSkill(119 ,54);  -- Băng Cốt Tuyết Tâm 
            me.AddFightSkill(117 ,54);  -- Băng Tâm Tiên Tử 
            me.AddFightSkill(485 ,54);  -- Phù Vân Tán Tuyết 
            me.AddFightSkill(839 ,54);  -- Thập Diện Mai Phục 
            me.AddFightSkill(840 ,54);  -- Kỹ năng cấp 120 
            --Đao Thúy 
            me.AddFightSkill(120 ,54);  -- Phong Hoa Tuyết Nguyệt 
            me.AddFightSkill(121 ,54);  -- Thúy Yên Đao Pháp 
            me.AddFightSkill(122 ,54);  -- Ngự Tuyết Ẩn 
            me.AddFightSkill(115 ,54);  -- Tuyết Ảnh 
            me.AddFightSkill(123 ,54);  -- Mục Dã Lưu Tinh 
            me.AddFightSkill(483 ,54);  -- Huyền Băng Vô Tức 
            me.AddFightSkill(124 ,54);  -- Băng Tâm Thiến Ảnh 
            me.AddFightSkill(127 ,54);  -- Băng Cơ Ngọc Cốt 
            me.AddFightSkill(125 ,54);  -- Băng Tung Vô Ảnh 
            me.AddFightSkill(486 ,54);  -- Thiên Lý Băng Phong 
            me.AddFightSkill(841 ,54);  -- Quy Khứ Lai Hề 
            me.AddFightSkill(842 ,54);  -- Kỹ năng cấp 120 
        elseif me.nFaction == 7 then    --Cái Bang 
            --Chưởng Cái 
            me.AddFightSkill(128 ,54);  -- Kiến Nhân Thân Thủ 
            me.AddFightSkill(129 ,54);  -- Cái Bang Chưởng Pháp 
            me.AddFightSkill(130 ,54);  -- Hóa Hiểm Vi Di 
            me.AddFightSkill(132 ,54);  -- Hoạt Bất Lưu Thủ 
            me.AddFightSkill(131 ,54);  -- Hàng Long Hữu Hối 
            me.AddFightSkill(489 ,54);  -- Thời Thừa Lục Long 
            me.AddFightSkill(133 ,54);  -- Túy Điệp Cuồng Vũ 
            me.AddFightSkill(136 ,54);  -- Tiềm Long Tại Uyên 
            me.AddFightSkill(134 ,54);  -- Phi Long Tại Thiên 
            me.AddFightSkill(487 ,54);  -- Giáng Long Chưởng 
            me.AddFightSkill(843 ,54);  -- Trảo Long Công 
            me.AddFightSkill(844 ,54);  -- Kỹ năng cấp 120 
            --Côn Cái 
            me.AddFightSkill(137 ,54);  -- Duyên Môn Thác Bát 
            me.AddFightSkill(138 ,54);  -- Cái Bang Bổng Pháp 
            me.AddFightSkill(139 ,54);  -- Tiêu Dao Công 
            me.AddFightSkill(132 ,54);  -- Hoạt Bất Lưu Thủ 
            me.AddFightSkill(140 ,54);  -- Bổng Đả Ác Cẩu 
            me.AddFightSkill(491 ,54);  -- Ác Cẩu Lan Lộ 
            me.AddFightSkill(238 ,54);  -- Hỗn Thiên Khí Công 
            me.AddFightSkill(142 ,54);  -- Bôn Lưu Đáo Hải 
            me.AddFightSkill(141 ,54);  -- Thiên Hạ Vô Cẩu 
            me.AddFightSkill(488 ,54);  -- Đả Cẩu Bổng Pháp 
            me.AddFightSkill(845 ,54);  -- Đả Cẩu Trận Pháp 
            me.AddFightSkill(846 ,54);  -- Kỹ năng cấp 120 
        elseif me.nFaction == 8 then    --Thiên Nhẫn 
            --Chiến Nhẫn 
            me.AddFightSkill(143 ,54);  -- Tàn Dương Như Huyết 
            me.AddFightSkill(144 ,54);  -- Thiên Nhẫn Mâu Pháp 
            me.AddFightSkill(492 ,54);  -- Huyễn Ảnh Truy Hồn Thương 
            me.AddFightSkill(145 ,54);  -- Kim Thiền Thoát Xác 
            me.AddFightSkill(146 ,54);  -- Liệt Hỏa Tình Thiên 
            me.AddFightSkill(147 ,54);  -- Bi Tô Thanh Phong 
            me.AddFightSkill(148 ,54);  -- Ma Âm Phệ Phách 
            me.AddFightSkill(150 ,54);  -- Thiên Ma Giải Thể 
            me.AddFightSkill(149 ,54);  -- Vân Long Kích 
            me.AddFightSkill(493 ,54);  -- Ma Viêm Tại Thiên 
            me.AddFightSkill(847 ,54);  -- Phi Hồng Vô Tích 
            me.AddFightSkill(848 ,54);  -- Kỹ năng cấp 120 
            --Ma Nhẫn 
            me.AddFightSkill(151 ,54);  -- Đạn Chỉ Liệt Diệm 
            me.AddFightSkill(152 ,54);  -- Thiên Nhẫn Đao Pháp 
            me.AddFightSkill(154 ,54);  -- Lệ Ma Đoạt Hồn 
            me.AddFightSkill(145 ,54);  -- Kim Thiền Thoát Xác 
            me.AddFightSkill(153 ,54);  -- Thôi Sơn Điền Hải 
            me.AddFightSkill(494 ,54);  -- Hỏa Liên Phần Hoa 
            me.AddFightSkill(155 ,54);  -- Nhiếp Hồn Loạn Tâm 
            me.AddFightSkill(158 ,54);  -- Xí Không Ma Diệm 
            me.AddFightSkill(156 ,54);  -- Thiên Ngoại Lưu Tinh 
            me.AddFightSkill(496 ,54);  -- Ma Diệm Thất Sát 
            me.AddFightSkill(849 ,54);  -- Thúc Phọc Chú 
            me.AddFightSkill(850 ,54);  -- Kỹ năng cấp 120 
        elseif me.nFaction == 9 then    --Võ Đang 
            --Khí Võ 
            me.AddFightSkill(159 ,54);  -- Bác Cập Nhi Phục 
            me.AddFightSkill(160 ,54);  -- Võ Đang Quyền Pháp 
            me.AddFightSkill(161 ,54);  -- Tọa Vọng Vô Ngã 
            me.AddFightSkill(163 ,54);  -- Thê Vân Tung 
            me.AddFightSkill(162 ,54);  -- Vô Ngã Vô Kiếm 
            me.AddFightSkill(497 ,54);  -- Thuần Dương Vô Cực 
            me.AddFightSkill(164 ,54);  -- Chân Vũ Thất Tiệt 
            me.AddFightSkill(166 ,54);  -- Thái Cực Vô Ý 
            me.AddFightSkill(165 ,54);  -- Thiên Địa Vô Cực 
            me.AddFightSkill(498 ,54);  -- Thái Cực Thần Công 
            me.AddFightSkill(851 ,54);  -- Võ Đang Cửu Dương 
            me.AddFightSkill(852 ,54);  -- Kỹ năng cấp 120 
            --Kiếm Võ 
            me.AddFightSkill(167 ,54);  -- Kiếm Phi Kinh Thiên 
            me.AddFightSkill(168 ,54);  -- Võ Đang Kiếm Pháp 
            me.AddFightSkill(783 ,54);  -- Vô Ngã Tâm Pháp 
            me.AddFightSkill(163 ,54);  -- Thê Vân Tung 
            me.AddFightSkill(169 ,54);  -- Tam Hoàn Sáo Nguyệt 
            me.AddFightSkill(499 ,54);  -- Thái Nhất Chân Khí 
            me.AddFightSkill(170 ,54);  -- Thất Tinh Quyết 
            me.AddFightSkill(174 ,54);  -- Kiếm Khí Tung Hoành 
            me.AddFightSkill(171 ,54);  -- Nhân Kiếm Hợp Nhất 
            me.AddFightSkill(500 ,54);  -- Thái Cực Kiếm Pháp 
            me.AddFightSkill(853 ,54);  -- Mê Tung Huyễn Ảnh 
            me.AddFightSkill(854 ,54);  -- Kỹ năng cấp 120 
        elseif me.nFaction == 10 then    --Côn Lôn 
            --Đao Côn 
            me.AddFightSkill(175 ,54);  -- Hô Phong Pháp 
            me.AddFightSkill(176 ,54);  -- Côn Lôn Đao Pháp 
            me.AddFightSkill(179 ,54);  -- Huyền Thiên Vô Cực 
            me.AddFightSkill(177 ,54);  -- Thanh Phong Phù 
            me.AddFightSkill(178 ,54);  -- Cuồng Phong Sậu Điện 
            me.AddFightSkill(697 ,54);  -- Khai Thần Thuật 
            me.AddFightSkill(180 ,54);  -- Nhất Khí Tam Thanh 
            me.AddFightSkill(183 ,54);  -- Thiên Thanh Địa Trọc 
            me.AddFightSkill(181 ,54);  -- Ngạo Tuyết Tiếu Phong 
            me.AddFightSkill(698 ,54);  -- Sương Ngạo Côn Lôn 
            me.AddFightSkill(855 ,54);  -- Vô Nhân Vô Ngã 
            me.AddFightSkill(856 ,54);  -- Kỹ năng cấp 120 
            --Kiếm Côn 
            me.AddFightSkill(188 ,54);  -- Cuồng Lôi Chấn Địa 
            me.AddFightSkill(189 ,54);  -- Côn Lôn Kiếm Pháp 
            me.AddFightSkill(179 ,54);  -- Huyền Thiên Vô Cực 
            me.AddFightSkill(177 ,54);  -- Thanh Phong Phù 
            me.AddFightSkill(190 ,54);  -- Thiên Tế Tấn Lôi 
            me.AddFightSkill(699 ,54);  -- Túy Tiên Thác Cốt 
            me.AddFightSkill(191 ,54);  -- Đạo Cốt Tiên Phong 
            me.AddFightSkill(193 ,54);  -- Ngũ Lôi Chánh Pháp 
            me.AddFightSkill(192 ,54);  -- Lôi Động Cửu Thiên 
            me.AddFightSkill(767 ,54);  -- Hỗn Nguyên Càn Khôn 
            me.AddFightSkill(857 ,54);  -- Lôi Đình Quyết 
            me.AddFightSkill(858 ,54);  -- Kỹ năng cấp 120 
        elseif me.nFaction == 11 then    --Minh Giáo 
            --Chùy Minh 
            me.AddFightSkill(194 ,54);  -- Khai Thiên Thức 
            me.AddFightSkill(196 ,54);  -- Minh Giáo Chùy Pháp 
            me.AddFightSkill(199 ,54);  -- Khốn Hổ Vân Tiếu 
            me.AddFightSkill(768 ,54);  -- Huyền Dương Công 
            me.AddFightSkill(198 ,54);  -- Phách Địa Thế 
            me.AddFightSkill(201 ,54);  -- Kim Qua Thiết Mã 
            me.AddFightSkill(197 ,54);  -- Ngự Mã Thuật 
            me.AddFightSkill(204 ,54);  -- Trấn Ngục Phá Thiên Kình 
            me.AddFightSkill(202 ,54);  -- Long Thôn Thức 
            me.AddFightSkill(769 ,54);  -- Không Tuyệt Tâm Pháp 
            me.AddFightSkill(859 ,54);  -- Cửu Hi Hỗn Dương 
            me.AddFightSkill(860 ,54);  -- Kỹ năng cấp 120 
            --Kiếm Minh 
            me.AddFightSkill(205 ,54);  -- Thánh Hỏa Phần Tâm 
            me.AddFightSkill(206 ,54);  -- Minh Giáo Kiếm Pháp 
            me.AddFightSkill(207 ,54);  -- Di Khí Phiêu Tung 
            me.AddFightSkill(209 ,54);  -- Phiêu Dực Thân Pháp 
            me.AddFightSkill(208 ,54);  -- Vạn Vật Câu Phần 
            me.AddFightSkill(210 ,54);  -- Càn Khôn Đại Na Di 
            me.AddFightSkill(770 ,54);  -- Thâu Thiên Hoán Nhật 
            me.AddFightSkill(212 ,54);  -- Ly Hỏa Đại Pháp 
            me.AddFightSkill(211 ,54);  -- Thánh Hỏa Liêu Nguyên 
            me.AddFightSkill(772 ,54);  -- Thánh Hỏa Thần Công 
            me.AddFightSkill(861 ,54);  -- Thánh Hỏa Lệnh Pháp 
            me.AddFightSkill(862 ,54);  -- Kỹ năng cấp 120 
        elseif me.nFaction == 12 then    --Đoàn Thị 
            --Chỉ Đoàn 
            me.AddFightSkill(213 ,54);  -- Thần Chỉ Điểm Huyệt 
            me.AddFightSkill(215 ,54);  -- Đoàn Thị Chỉ Pháp 
            me.AddFightSkill(216 ,54);  -- Nhất Dương Chỉ 
            me.AddFightSkill(219 ,54);  -- Lăng Ba Vi Bộ 
            me.AddFightSkill(217 ,54);  -- Nhất Chỉ Càn Khôn 
            me.AddFightSkill(773 ,54);  -- Từ Bi Quyết 
            me.AddFightSkill(220 ,54);  -- Thí Nguyên Quyết 
            me.AddFightSkill(225 ,54);  -- Kim Ngọc Chỉ Pháp 
            me.AddFightSkill(223 ,54);  -- Càn Dương Thần Chỉ 
            me.AddFightSkill(775 ,54);  -- Càn Thiên Chỉ Pháp 
            me.AddFightSkill(863 ,54);  -- Diệu Đề Chỉ 
            me.AddFightSkill(864 ,54);  -- Kỹ năng cấp 120 
            --Khí Đoàn 
            me.AddFightSkill(226 ,54);  -- Phong Vân Biến Huyễn 
            me.AddFightSkill(227 ,54);  -- Đoàn Thị Tâm Pháp 
            me.AddFightSkill(228 ,54);  -- Bắc Minh Thần Công 
            me.AddFightSkill(230 ,54);  -- Thiên Nam Bộ Pháp 
            me.AddFightSkill(229 ,54);  -- Kim Ngọc Mãn Đường 
            me.AddFightSkill(776 ,54);  -- Lục Kiếm Tề Phát 
            me.AddFightSkill(231 ,54);  -- Khô Vinh Thiền Công 
            me.AddFightSkill(233 ,54);  -- Thiên Long Thần Công 
            me.AddFightSkill(232 ,54);  -- Lục Mạch Thần Kiếm 
            me.AddFightSkill(778 ,54);  -- Đoàn Gia Khí Kiếm 
            me.AddFightSkill(865 ,54);  -- Kinh Thiên Nhất Kiếm 
            me.AddFightSkill(1662 ,54);  --Ám Hương 
            me.AddFightSkill(866 ,54);  --Sơ Ảnh 
        end 
    end 
end
----------------------------------------------------------------------------------
function tbLiGuan:MatTichCao()
	local szMsg = "<color=blue>Túi Tân Thủ Tụ Hội Kiếm<color>";
	local tbOpt = {};
	table.insert(tbOpt , {"Thiếu Lâm",  self.mttl, self});
	table.insert(tbOpt , {"Thiên Vương",  self.mttv, self});
	table.insert(tbOpt , {"Đường môn",  self.mtdm, self});
	table.insert(tbOpt , {"Ngũ Độc",  self.mtnd, self});
	table.insert(tbOpt , {"Minh giáo",  self.mtmg, self});
	table.insert(tbOpt , {"Nga My",  self.mtnm, self});
	table.insert(tbOpt , {"Thúy Yên",  self.mtty, self});
	table.insert(tbOpt , {"Đoàn Thị",  self.mtdt, self});
	table.insert(tbOpt , {"Cái Bang",  self.mtcb, self});
	table.insert(tbOpt , {"Thiên Nhẫn",  self.mttn, self});
	table.insert(tbOpt , {"Võ Đang",  self.mtvd, self});
	table.insert(tbOpt , {"Côn Lôn",  self.mtcl, self});
	table.insert(tbOpt , {"<color=pink>Trở Lại Trước<color>",  self.lsTiemNangKyNang, self});
	table.insert(tbOpt, {"Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:skill120()
if me.nFaction > 0 then 
        if me.nFaction == 1 then    --Skill Thiếu Lâm 
            me.AddFightSkill(820,1);    --Kỹ năng cấp 120
            me.AddFightSkill(822,1);    --Kỹ năng cấp 120
             
        elseif me.nFaction == 2 then    --Skill Thiên Vương 
            me.AddFightSkill(824,1);    --Kỹ năng cấp 120                 
            me.AddFightSkill(826,1);    --Kỹ năng cấp 120         
         
        elseif me.nFaction == 3 then    --Đường Môn 
 
            me.AddFightSkill(828,1);    --Kỹ năng cấp 120     
            me.AddFightSkill(830,1);    --Kỹ năng cấp 120     
             
        elseif me.nFaction == 4 then    --Ngũ Độc 
            me.AddFightSkill(832 ,1);  -- Kỹ năng cấp 120 
            me.AddFightSkill(834 ,1);  -- Kỹ năng cấp 120 
             
        elseif me.nFaction == 5 then    --Nga My 
            me.AddFightSkill(836 ,1);  -- Kỹ năng cấp 120 
            me.AddFightSkill(838 ,1);  -- Kỹ năng cấp 120 
             
        elseif me.nFaction == 6 then    --Thúy Yên 
            me.AddFightSkill(840 ,1);  -- Kỹ năng cấp 120 
            me.AddFightSkill(842 ,1);  -- Kỹ năng cấp 120 
			
        elseif me.nFaction == 7 then    --Cái Bang 
            me.AddFightSkill(844 ,1);  -- Kỹ năng cấp 120 
            me.AddFightSkill(846 ,1);  -- Kỹ năng cấp 120 
			
        elseif me.nFaction == 8 then    --Thiên Nhẫn 
            me.AddFightSkill(848 ,1);  -- Kỹ năng cấp 120 
            me.AddFightSkill(850 ,1);  -- Kỹ năng cấp 120 
			
        elseif me.nFaction == 9 then    --Võ Đang 
             me.AddFightSkill(852 ,1);  -- Kỹ năng cấp 120 
             me.AddFightSkill(854 ,1);  -- Kỹ năng cấp 120 
			 
        elseif me.nFaction == 10 then    --Côn Lôn 
           me.AddFightSkill(856 ,1);  -- Kỹ năng cấp 120 
           me.AddFightSkill(858 ,1);  -- Kỹ năng cấp 120 
		   
        elseif me.nFaction == 11 then    --Minh Giáo 
            me.AddFightSkill(860 ,1);  -- Kỹ năng cấp 120 
            me.AddFightSkill(862 ,1);  -- Kỹ năng cấp 120 
			
        elseif me.nFaction == 12 then    --Đoàn Thị 
            me.AddFightSkill(864 ,1);  -- Kỹ năng cấp 120 
            me.AddFightSkill(866 ,1);  --Sơ Ảnh 
        end 
    end 
end 
----------------------------------------------------------------------------------
function tbLiGuan:mttl()
		me.AddItem(1,14,1,3);
		me.AddItem(1,14,2,3);
end

function tbLiGuan:mttv()		
		me.AddItem(1,14,3,3);
		me.AddItem(1,14,4,3);
end

function tbLiGuan:mtdm()
		me.AddItem(1,14,5,3);
		me.AddItem(1,14,6,3);
end

function tbLiGuan:mtnd()		
		me.AddItem(1,14,7,3);
		me.AddItem(1,14,8,3);
end

function tbLiGuan:mtmg()		
		me.AddItem(1,14,21,3);
		me.AddItem(1,14,22,3);
end

function tbLiGuan:mtnm()
		me.AddItem(1,14,9,3);
		me.AddItem(1,14,10,3);
end

function tbLiGuan:mtty()		
		me.AddItem(1,14,11,3);
		me.AddItem(1,14,12,3);
end

function tbLiGuan:mtdt()		
		me.AddItem(1,14,23,3);
		me.AddItem(1,14,24,3);
end

function tbLiGuan:mtcb()
		me.AddItem(1,14,13,3);
		me.AddItem(1,14,14,3);
end

function tbLiGuan:mttn()		
		me.AddItem(1,14,15,3);
		me.AddItem(1,14,16,3);
end

function tbLiGuan:mtvd()
		me.AddItem(1,14,17,3);
		me.AddItem(1,14,18,3);
end

function tbLiGuan:mtcl()		
		me.AddItem(1,14,19,3);
		me.AddItem(1,14,20,3);
end
----------------------------------------------------------------------------------
function tbLiGuan:TangTocChay()
	me.AddFightSkill(163,20);	-- 60级梯云纵
	me.AddFightSkill(91,20);
	me.AddFightSkill(132,20);
	me.AddFightSkill(177,20);
	me.AddFightSkill(209,20);
end

function tbLiGuan:HuyTangTocChay()
	me.DelFightSkill(163);	-- 60级梯云纵
	me.DelFightSkill(91);
	me.DelFightSkill(132);
	me.DelFightSkill(177);
	me.DelFightSkill(209);
end

function tbLiGuan:TangTocDanh()
	me.AddFightSkill(28,20);
	me.AddFightSkill(37,20);
	me.AddFightSkill(68,20);
	me.AddFightSkill(75,20);
	me.AddFightSkill(85,20);
	me.AddFightSkill(95,20);
	me.AddFightSkill(105,20);
	me.AddFightSkill(119,20);
	me.AddFightSkill(127,20);
	me.AddFightSkill(136,20);
	me.AddFightSkill(142,20);
	me.AddFightSkill(150,20);
	me.AddFightSkill(158,20);
	me.AddFightSkill(166,20);
	me.AddFightSkill(174,20);
	me.AddFightSkill(183,20);
	me.AddFightSkill(193,20);
	me.AddFightSkill(204,20);
	me.AddFightSkill(212,20);
	me.AddFightSkill(233,20);
	me.AddFightSkill(837,20);
	me.AddFightSkill(1069,20);
end

function tbLiGuan:HuyTangTocDanh()
	me.DelFightSkill(28);
	me.DelFightSkill(37);
	me.DelFightSkill(68);
	me.DelFightSkill(75);
	me.DelFightSkill(85);
	me.DelFightSkill(95);
	me.DelFightSkill(105);
	me.DelFightSkill(119);
	me.DelFightSkill(127);
	me.DelFightSkill(136);
	me.DelFightSkill(142);
	me.DelFightSkill(150);
	me.DelFightSkill(158);
	me.DelFightSkill(166);
	me.DelFightSkill(174);
	me.DelFightSkill(183);
	me.DelFightSkill(193);
	me.DelFightSkill(204);
	me.DelFightSkill(212);
	me.DelFightSkill(233);
	me.DelFightSkill(837);
	me.DelFightSkill(1069);
end
----------------------------------------------------------------------------------
function tbLiGuan:tl120()
	me.AddFightSkill(820,10);
	me.AddFightSkill(822,10);
end

function tbLiGuan:tv120()		
	me.AddFightSkill(824,10);
	me.AddFightSkill(826,10);
end

function tbLiGuan:dm120()
	me.AddFightSkill(828,10);
	me.AddFightSkill(830,10);
end

function tbLiGuan:nd120()		
	me.AddFightSkill(832,10);
	me.AddFightSkill(834,10);
end

function tbLiGuan:mg120()		
	me.AddFightSkill(860,10);
	me.AddFightSkill(862,10);
end

function tbLiGuan:nm120()
	me.AddFightSkill(836,10);
	me.AddFightSkill(838,10);
end

function tbLiGuan:ty120()		
	me.AddFightSkill(840,10);
	me.AddFightSkill(842,10);
end

function tbLiGuan:dt120()		
	me.AddFightSkill(864,10);
	me.AddFightSkill(866,10);
	me.AddFightSkill(1662,10);
end

function tbLiGuan:cb120()
	me.AddFightSkill(844,10);
	me.AddFightSkill(846,10);
end

function tbLiGuan:tn120()		
	me.AddFightSkill(848,10);
	me.AddFightSkill(850,10);
end

function tbLiGuan:vd120()
	me.AddFightSkill(852,10);
	me.AddFightSkill(854,10);
end

function tbLiGuan:cl120()		
	me.AddFightSkill(856,10);
	me.AddFightSkill(858,10);
end
----------------------------------------------------------------------------------
function tbLiGuan:GetAwardBuff()
	local szMsg ="";
	local nGetBuff = me.GetTask(self.TASK_GROUP_ID, self.TASK_GET_BUFF);
	if me.nLevel >= 50 then
		Dialog:Say("Bạn đã quá cấp 50 không thể nhận");
		return;
	end	
	if nGetBuff ~= 0 then
		Dialog:Say("Bạn chưa đủ điều kiện để nhận");	
		return;
	end	
	--脨脪脭脣脰碌880, 4录露30碌茫,拢卢麓貌鹿脰戮颅脩茅879, 6录露拢篓70拢楼拢漏
	me.AddSkillState(880, 4, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
	--脛楼碌露脢炉 鹿楼禄梅
	me.AddSkillState(387, 6, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);	
	--禄陇录脳脝卢 脩陋
	me.AddSkillState(385, 8, 2, 60 * 60 * Env.GAME_FPS, 1, 0, 1);
	me.SetTask(self.TASK_GROUP_ID, self.TASK_GET_BUFF, 1);	
	Dialog:Say("Nhận quà thành công");
	return;
end

function tbLiGuan:GetAwardYaopai()
	local nGetYaopai = 	me.GetTask(self.TASK_GROUP_ID, self.TASK_GET_YAOPAI);
	if me.nFaction == 0 then
		Dialog:Say("Bạn chưa gia nhập môn phái");
		return; 
	end
	if nGetYaopai ~= 0 then
		Dialog:Say("Bạn chưa đủ cấp để nhận thưởng");	
		return;
	end	
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("Cần 1 ô trống để nhận thưởng");
		return;
	end    
    local pItem = me.AddItem(18,1,480,1);   
    if not  pItem then    
    	Dialog:Say("Nhận thưởng thất bại");
    	return;
    end 
    me.SetTask(self.TASK_GROUP_ID, self.TASK_GET_YAOPAI,1);
    me.SetItemTimeout(pItem, 30*24*60, 0);
    me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "[禄卯露炉]脭枚录脫脦茂脝路"..pItem.szName);		
	Dbg:WriteLog("[脭枚录脫脦茂脝路]"..pItem.szName, me.szName);
    Dialog:Say("Nhận thưởng thành công");
end

function tbLiGuan:GetAwardLibao(nItemId)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return ;
	end
	local nRes, szMsg = NewPlayerGift:GetAward(me, pItem);
	if szMsg then
		Dialog:Say(szMsg);
	end
end
----------------------------------------------------------------------------------
function tbLiGuan:BacThuong()
	me.Earn(100000000,0);
end

function tbLiGuan:BacKhoa()
	me.AddBindMoney(100000000);
end

function tbLiGuan:DongThuong()
	me.AddJbCoin(50000000);
end

function tbLiGuan:DongKhoa()
	me.AddBindCoin(50000000);
end
----------------------------------------------------------------------------------
function tbLiGuan:VoSoVang()
	for i=1,5000 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,325,1);
		else
			break
		end
	end
end
----------------------------------------------------------------------------------
function tbLiGuan:RuongVoSoVang()
	me.AddItem(18,1,338,1); --Rương Vỏ Sò Vàng
	me.AddItem(18,1,338,1); --Rương Vỏ Sò Vàng
	me.AddItem(18,1,338,1); --Rương Vỏ Sò Vàng
	me.AddItem(18,1,338,1); --Rương Vỏ Sò Vàng
	me.AddItem(18,1,338,1); --Rương Vỏ Sò Vàng
end
----------------------------------------------------------------------------------
function tbLiGuan:GMcard3()
	me.AddItem(18,1,400,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:NgocTrucMaiHoa()
	me.AddItem(17,3,2,7);
end
----------------------------------------------------------------------------------
function tbLiGuan:MatNaHangLong()
	me.AddItem(1,13,63,1); --Mặt Nạ Hàng Long Phục Hổ Quán (Ko thể bán)
end

function tbLiGuan:MatNaTanThuyHoang()
	me.AddItem(1,13,24,1); --Mặt Nạ Tần Thủy Hoàng (Ko thể bán)
end

function tbLiGuan:MatNaAoDaiKhanDongNam()
	me.AddItem(1,13,90,1); --Mặt nạ áo dài khăn đống - NAM
end

function tbLiGuan:MatNaWodekapu()
	me.AddItem(1,13,70,1); --Mặt nạ wodekapu
end

function tbLiGuan:MatNaLamNhan()
	me.AddItem(1,13,35,1); --Mặt nạ Lam Nhan
end

function tbLiGuan:MatNaRuaThan()
	me.AddItem(1,13,51,1); --Mặt nạ Rùa Thần
end

function tbLiGuan:MatNaManhHo()
	me.AddItem(1,13,52,1); --Mặt nạ Mãnh Hổ
end

function tbLiGuan:MatNaKimMaoSuVuong()
	me.AddItem(1,13,20020,1); --Mặt nạ Kim Mao Sư Vương
end

function tbLiGuan:MatNaTayDocAuDuongPhong()
	me.AddItem(1,13,20025,1); --Mặt nạ Tây Độc Âu Dương Phong
end

function tbLiGuan:MatNaCocTienTien()
	me.AddItem(1,13,92,1,0,1); --Mặt nạ Cốc Tiên Tiên
end

function tbLiGuan:MatNaLanhSuongNhien()
	me.AddItem(1,13,94,1,0,1); --Mặt nạ Lãnh Sương Nhiên
end

function tbLiGuan:MatNaTanNienHiepNu()
	me.AddItem(1,13,19,1,0,1); --Mặt nạ Tân Niên Hiệp Nữ
end

function tbLiGuan:MatNaDoanTieuVu()
	me.AddItem(1,13,77,1,0,1); --Mặt nạ Doãn Tiêu Vũ
end

function tbLiGuan:MatNaNguuThuyHoa()
	me.AddItem(1,13,89,1,0,1); --Mặt nạ Ngưu Thúy Hoa
end
----------------------------------------------------------------------------------
function tbLiGuan:TuLuyenDon()
	me.AddItem(18,1,258,1); --Tu Luyện Đơn
	me.AddItem(18,1,258,1);
	me.AddItem(18,1,258,1);
	me.AddItem(18,1,258,1);
	me.AddItem(18,1,258,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:Tui24()
	me.AddItem(21,9,1,1); --Túi thiên tằm 24 ô
	me.AddItem(21,9,2,1); --Túi bàn long 24 ô
	me.AddItem(21,9,3,1); --Túi Phi Phượng 24 ô
	me.AddItem(1,25,11,2);
	me.AddItem(1,25,12,2);
	me.AddItem(1,25,13,2);
	me.AddItem(1,25,14,2);
	me.AddItem(1,25,15,2);
	me.AddItem(1,25,16,2);
	me.AddItem(1,25,25,2);
	me.AddItem(1,25,26,2);
	me.AddItem(1,25,27,2);
	me.AddItem(1,25,28,2);
	me.AddItem(1,25,29,2);
	me.AddItem(1,25,30,2);
end
----------------------------------------------------------------------------------
function tbLiGuan:NguyetAnhThach()
me.AddItem(18,1,476,1); --Nguyệt Ảnh Thạch
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1); --Nguyệt Ảnh Thạch
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1); --Nguyệt Ảnh Thạch
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1); --Nguyệt Ảnh Thạch
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1); --Nguyệt Ảnh Thạch
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1); --Nguyệt Ảnh Thạch
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1); --Nguyệt Ảnh Thạch
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1); --Nguyệt Ảnh Thạch
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1); --Nguyệt Ảnh Thạch
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1); --Nguyệt Ảnh Thạch
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
me.AddItem(18,1,476,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:BanDongHanh4()
	me.AddItem(18,1,547,1);	--đồng hành 4 kỹ năng
end
----------------------------------------------------------------------------------
function tbLiGuan:BanDongHanh6()
	me.AddItem(18,1,547,2);	--đồng hành 6 kỹ năng
end
----------------------------------------------------------------------------------
function tbLiGuan:ThiepBac()
	me.AddItem(18,1,541,2); --Thiệp Bạc
end
----------------------------------------------------------------------------------
function tbLiGuan:ThiepLua()
	me.AddItem(18,1,541,1);	--Thiệp lụa
end
----------------------------------------------------------------------------------
function tbLiGuan:RuongThiepLua()
	me.AddItem(18,1,545,1);	--rương thiệp lụa
end
----------------------------------------------------------------------------------
function tbLiGuan:SachKinhNghiemDongHanh1()
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
	me.AddItem(18,1,543,1);	--sách kn đồng hành
end
----------------------------------------------------------------------------------
function tbLiGuan:SachKinhNghiemDongHanh2()
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
	me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
end
----------------------------------------------------------------------------------
function tbLiGuan:MatTichDongHanh()
	me.AddItem(18,1,554,1); --MTDH so
	me.AddItem(18,1,554,2); --MTDH trung
	me.AddItem(18,1,554,3); --MTDH cao
	me.AddItem(18,1,554,4); --MTDH cao
end
----------------------------------------------------------------------------------
function tbLiGuan:NguyenLieuDongHanh()
	me.AddItem(18,1,556,1); -- nguyen lieu dong hanh dac biet
end
----------------------------------------------------------------------------------
function tbLiGuan:RuongDaMinhChau()
	me.AddItem(18,1,382,1,0); --Rương Dạ Minh Châu
	me.AddItem(18,1,382,1); --Rương dạ minh châu (ko khóa)
end
----------------------------------------------------------------------------------
function tbLiGuan:LuanHoiAn()
	me.AddItem(1,16,13,2); --Luân Hồi Ấn
end

function tbLiGuan:ThaiCucAn()
	local szMsg = "Xin chào, ta có thể giúp được gì?";
	local tbOpt = 
	{
		{"[THK] Ưng Tử Ấn", self.Signet_UngTu, self},
		{"[THK] Phụng Tử Ấn", self.Signet_PhungTu, self},
		{"[THK] Hổ Tử Ấn", self.Signet_HoTu, self},
		{"[THK] Long Tử Ấn", self.Signet_LongTu, self},
		};
		Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:Signet_UngTu()
me.AddItem(1,16,14,3)
end
function tbLiGuan:Signet_PhungTu()
me.AddItem(1,16,15,3)
end
function tbLiGuan:Signet_HoTu()
me.AddItem(1,16,16,3)
end
function tbLiGuan:Signet_LongTu()
me.AddItem(1,16,17,3)
end

----------------------------------------------------------------------------------
function tbLiGuan:NguHoaNgocLoHoan()
	me.AddItem(18,1,42,1,0); --Ngũ Hoa Ngọc Lộ Hoàn
end
----------------------------------------------------------------------------------
function tbLiGuan:TranPhapCao()
	me.AddItem(1,15,1,3);
	me.AddItem(1,15,2,3);
	me.AddItem(1,15,3,3);
	me.AddItem(1,15,4,3);
	me.AddItem(1,15,5,3);
	me.AddItem(1,15,6,3);
	me.AddItem(1,15,7,3);
	me.AddItem(1,15,8,3);
	me.AddItem(1,15,9,3);
	me.AddItem(1,15,10,3);
	me.AddItem(1,15,11,3);
end
----------------------------------------------------------------------------------
function tbLiGuan:Cauhon()
me.AddItem(18,1,146,3); --Câu Hồn Ngọc
me.AddItem(18,1,146,3);
me.AddItem(18,1,146,3);
me.AddItem(18,1,146,3);
end
----------------------------------------------------------------------------------
function tbLiGuan:nhiemvu110()
me.AddItem(18,1,200,1);
me.AddItem(18,1,201,1);
me.AddItem(18,1,202,1);
me.AddItem(18,1,203,1);
me.AddItem(18,1,204,1);
me.AddItem(18,1,263,1);
me.AddItem(18,1,264,1);
me.AddItem(18,1,265,1);
me.AddItem(18,1,266,1);
me.AddItem(18,1,267,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:Danhvong()
me.AddRepute(1,1,30000);
me.AddRepute(1,2,30000);
me.AddRepute(1,3,30000);
me.AddRepute(2,1,30000);
me.AddRepute(2,2,30000);
me.AddRepute(2,3,30000);
me.AddRepute(3,1,30000);
me.AddRepute(3,2,30000);
me.AddRepute(3,3,30000);
me.AddRepute(3,4,30000);
me.AddRepute(3,5,30000);
me.AddRepute(3,6,30000);
me.AddRepute(3,7,30000);
me.AddRepute(3,8,30000);
me.AddRepute(3,9,30000);
me.AddRepute(3,10,30000);
me.AddRepute(3,11,30000);
me.AddRepute(3,12,30000);
me.AddRepute(4,1,30000);
me.AddRepute(5,1,30000);
me.AddRepute(5,2,30000);
me.AddRepute(5,3,30000);
me.AddRepute(5,4,30000);
me.AddRepute(5,5,30000);
me.AddRepute(5,6,30000);
me.AddRepute(6,1,30000);
me.AddRepute(6,2,30000);
me.AddRepute(6,3,30000);
me.AddRepute(6,4,30000);
me.AddRepute(6,5,30000);
me.AddRepute(7,1,30000);
me.AddRepute(8,1,30000);
me.AddRepute(9,1,30000);
me.AddRepute(9,2,30000);
me.AddRepute(10,1,30000);
me.AddRepute(11,1,30000);
me.AddRepute(12,1,30000);
end
----------------------------------------------------------------------------------
function tbLiGuan:TinhLuc()
	me.ChangeCurMakePoint(1000000); --Nhận 1000.000 Tinh Lực
end
----------------------------------------------------------------------------------
function tbLiGuan:HoatLuc()
	me.ChangeCurGatherPoint(1000000); --Nhận 1000.000 Hoạt Lực
end
----------------------------------------------------------------------------------
function tbLiGuan:NguHanhHonThach()
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
	me.AddItem(18,1,244,2); --Ngũ Hành Hồn Thạch
end
----------------------------------------------------------------------------------
function tbLiGuan:TrangBi()
	local szMsg = "Tụ Hội Kiếm";
	local tbOpt = {
		{"<color=red>Trọn Bộ TB Cường Hóa Sẵn<color>",self.TrangBiCuongHoa,self};
		{"<color=red>Phi phong<color>",self.PhiPhong,self};
		{"<color=red>Shop Vũ khí Tần Lăng<color>",self.ShopThuyhoang, self};
        {"Shop Liên Đấu",self.ShopLiendau,self};
		{"Shop Thịnh Hạ",self.Shopthinhha,self};
        {"Shop Tranh Đoạt Lãnh Thổ",self.Shoptranhdoat,self};
        {"Shop Quan Hàm",self.ShopQuanham,self};
        {"Shop Chúc Phúc",self.Shopchucphuc,self};
		{"Shop Vũ Khí Hệ Kim",self.Svukhi1,self};
		{"Shop Vũ Khí Hệ Mộc",self.Svukhi2,self};
		{"Shop Vũ Khí Hệ Thủy",self.Svukhi3,self};
		{"Shop Vũ Khí Hệ Hỏa",self.Svukhi4,self};
		{"Shop Vũ Khí Hệ Thổ",self.Svukhi5,self};
		{"Luân Hồi Ấn",self.LuanHoiAn,self};
		{"Trận Pháp Cao",self.TranPhapCao,self};
		{">>>",self.TrangBi1,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:TrangBi1()
	local szMsg = "Tụ Hội Kiếm";
	local tbOpt = {
		{"Áo vũ uy",self.lsAoVuUy,self};
		{"Nhẫn Vũ Uy",self.lsNhanVuUy,self};
		{"Hộ Phù Vũ Uy",self.lsHoPhuVuUy,self};
		
		{"Áo Tần thủy hoàng",self.lsAoThuyHoang,self};
		{"Bao Tay Thủy Hoàng",self.lsBaoTayThuyHoang,self};
		{"Ngọc Bội Thủy Hoàng",self.lsNgocBoiThuyHoang,self};
		
		{"Bao Tay Tiêu Dao",self.lsBaoTayTieuDao,self};
		{"Giày Tiêu Dao",self.lsGiayTieuDao,self};
		--Liên Tiêu Dao chưa add
		
		{"Nón Trục Lộc",self.lsNonTrucLoc,self};
		{"Lưng Trục Lộc",self.lsLungTrucLoc,self};
		{"Liên Trục Lộc",self.lsLienTrucLoc,self};
		
		{"<<<",self.TrangBi,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:TrangBiCuongHoa()
	local szMsg = "Chọn cấp cường hóa";
	local tbOpt = {
		{"<color=blue>Bộ Cường Hóa +10<color>",self.DoCuoi10,self};
		{"<color=blue>Bộ Cường Hóa +12<color>",self.DoCuoi12,self};
		{"<color=blue>Bộ Cường Hóa +14<color>",self.DoCuoi14,self};
		{"<color=blue>Bộ Cường Hóa +16<color>",self.DoCuoi16,self};
		{"<color=pink>Trở Lại Trước<color>",self.TrangBi,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsHoPhuVuUy()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsHoPhuVuUyKim,self};
		{"Mộc",self.lsHoPhuVuUyMoc,self};
		{"Thủy",self.lsHoPhuVuUyThuy,self};
		{"Hỏa",self.lsHoPhuVuUyHoa,self};
		{"Thổ",self.lsHoPhuVuUyTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsLienTrucLoc()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsLienTrucLocNam,self};
		{"Nữ",self.lsLienTrucLocNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsLienTrucLocNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsLienTrucLocNamKim,self};
		{"Mộc",self.lsLienTrucLocNamMoc,self};
		{"Thủy",self.lsLienTrucLocNamThuy,self};
		{"Hỏa",self.lsLienTrucLocNamHoa,self};
		{"Thổ",self.lsLienTrucLocNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsLienTrucLocNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsLienTrucLocNuKim,self};
		{"Mộc",self.lsLienTrucLocNuMoc,self};
		{"Thủy",self.lsLienTrucLocNuThuy,self};
		{"Hỏa",self.lsLienTrucLocNuHoa,self};
		{"Thổ",self.lsLienTrucLocNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsNhanVuUy()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsNhanVuUyNam,self};
		{"Nữ",self.lsNhanVuUyNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsNhanVuUyNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsNhanVuUyNamKim,self};
		{"Mộc",self.lsNhanVuUyNamMoc,self};
		{"Thủy",self.lsNhanVuUyNamThuy,self};
		{"Hỏa",self.lsNhanVuUyNamHoa,self};
		{"Thổ",self.lsNhanVuUyNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsNhanVuUyNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsNhanVuUyNuKim,self};
		{"Mộc",self.lsNhanVuUyNuMoc,self};
		{"Thủy",self.lsNhanVuUyNuThuy,self};
		{"Hỏa",self.lsNhanVuUyNuHoa,self};
		{"Thổ",self.lsNhanVuUyNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsNgocBoiThuyHoang()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsNgocBoiThuyHoangNam,self};
		{"Nữ",self.lsNgocBoiThuyHoangNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsNgocBoiThuyHoangNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsNgocBoiThuyHoangNamKim,self};
		{"Mộc",self.lsNgocBoiThuyHoangNamMoc,self};
		{"Thủy",self.lsNgocBoiThuyHoangNamThuy,self};
		{"Hỏa",self.lsNgocBoiThuyHoangNamHoa,self};
		{"Thổ",self.lsNgocBoiThuyHoangNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsNgocBoiThuyHoangNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsNgocBoiThuyHoangNuKim,self};
		{"Mộc",self.lsNgocBoiThuyHoangNuMoc,self};
		{"Thủy",self.lsNgocBoiThuyHoangNuThuy,self};
		{"Hỏa",self.lsNgocBoiThuyHoangNuHoa,self};
		{"Thổ",self.lsNgocBoiThuyHoangNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsLungTrucLoc()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsLungTrucLocNam,self};
		{"Nữ",self.lsLungTrucLocNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsLungTrucLocNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsLungTrucLocNamKim,self};
		{"Mộc",self.lsLungTrucLocNamMoc,self};
		{"Thủy",self.lsLungTrucLocNamThuy,self};
		{"Hỏa",self.lsLungTrucLocNamHoa,self};
		{"Thổ",self.lsLungTrucLocNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsLungTrucLocNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsLungTrucLocNuKim,self};
		{"Mộc",self.lsLungTrucLocNuMoc,self};
		{"Thủy",self.lsLungTrucLocNuThuy,self};
		{"Hỏa",self.lsLungTrucLocNuHoa,self};
		{"Thổ",self.lsLungTrucLocNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsGiayTieuDao()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsGiayTieuDaoNam,self};
		{"Nữ",self.lsGiayTieuDaoNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsGiayTieuDaoNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsGiayTieuDaoNamKim,self};
		{"Mộc",self.lsGiayTieuDaoNamMoc,self};
		{"Thủy",self.lsGiayTieuDaoNamThuy,self};
		{"Hỏa",self.lsGiayTieuDaoNamHoa,self};
		{"Thổ",self.lsGiayTieuDaoNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsGiayTieuDaoNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsGiayTieuDaoNuKim,self};
		{"Mộc",self.lsGiayTieuDaoNuMoc,self};
		{"Thủy",self.lsGiayTieuDaoNuThuy,self};
		{"Hỏa",self.lsGiayTieuDaoNuHoa,self};
		{"Thổ",self.lsGiayTieuDaoNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsNonTrucLoc()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsNonTrucLocNam,self};
		{"Nữ",self.lsNonTrucLocNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsNonTrucLocNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsNonTrucLocNamKim,self};
		{"Mộc",self.lsNonTrucLocNamMoc,self};
		{"Thủy",self.lsNonTrucLocNamThuy,self};
		{"Hỏa",self.lsNonTrucLocNamHoa,self};
		{"Thổ",self.lsNonTrucLocNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsNonTrucLocNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsNonTrucLocNuKim,self};
		{"Mộc",self.lsNonTrucLocNuMoc,self};
		{"Thủy",self.lsNonTrucLocNuThuy,self};
		{"Hỏa",self.lsNonTrucLocNuHoa,self};
		{"Thổ",self.lsNonTrucLocNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsBaoTayTieuDao()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsBaoTayTieuDaoNam,self};
		{"Nữ",self.lsBaoTayTieuDaoNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsBaoTayTieuDaoNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsBaoTayTieuDaoNamKim,self};
		{"Mộc",self.lsBaoTayTieuDaoNamMoc,self};
		{"Thủy",self.lsBaoTayTieuDaoNamThuy,self};
		{"Hỏa",self.lsBaoTayTieuDaoNamHoa,self};
		{"Thổ",self.lsBaoTayTieuDaoNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsBaoTayTieuDaoNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsBaoTayTieuDaoNuKim,self};
		{"Mộc",self.lsBaoTayTieuDaoNuMoc,self};
		{"Thủy",self.lsBaoTayTieuDaoNuThuy,self};
		{"Hỏa",self.lsBaoTayTieuDaoNuHoa,self};
		{"Thổ",self.lsBaoTayTieuDaoNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsBaoTayThuyHoang()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsBaoTayThuyHoangNam,self};
		{"Nữ",self.lsBaoTayThuyHoangNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsBaoTayThuyHoangNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsBaoTayThuyHoangNamKim,self};
		{"Mộc",self.lsBaoTayThuyHoangNamMoc,self};
		{"Thủy",self.lsBaoTayThuyHoangNamThuy,self};
		{"Hỏa",self.lsBaoTayThuyHoangNamHoa,self};
		{"Thổ",self.lsBaoTayThuyHoangNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsBaoTayThuyHoangNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsBaoTayThuyHoangNuKim,self};
		{"Mộc",self.lsBaoTayThuyHoangNuMoc,self};
		{"Thủy",self.lsBaoTayThuyHoangNuThuy,self};
		{"Hỏa",self.lsBaoTayThuyHoangNuHoa,self};
		{"Thổ",self.lsBaoTayThuyHoangNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
------------------------------------------------------------------
function tbLiGuan:lsAoVuUy()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsAoVuUyNam,self};
		{"Nữ",self.lsAoVuUyNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsAoVuUyNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsAoVuUyNamKim,self};
		{"Mộc",self.lsAoVuUyNamMoc,self};
		{"Thủy",self.lsAoVuUyNamThuy,self};
		{"Hỏa",self.lsAoVuUyNamHoa,self};
		{"Thổ",self.lsAoVuUyNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsAoVuUyNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsAoVuUyNuKim,self};
		{"Mộc",self.lsAoVuUyNuMoc,self};
		{"Thủy",self.lsAoVuUyNuThuy,self};
		{"Hỏa",self.lsAoVuUyNuHoa,self};
		{"Thổ",self.lsAoVuUyNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------
function tbLiGuan:lsAoThuyHoang()
	local szMsg = "Chọn Giới Tính:";
	local tbOpt = {
		{"Nam",self.lsAoThuyHoangNam,self};
		{"Nữ",self.lsAoThuyHoangNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsAoThuyHoangNam()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsAoThuyHoangNamKim,self};
		{"Mộc",self.lsAoThuyHoangNamMoc,self};
		{"Thủy",self.lsAoThuyHoangNamThuy,self};
		{"Hỏa",self.lsAoThuyHoangNamHoa,self};
		{"Thổ",self.lsAoThuyHoangNamTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsAoThuyHoangNu()
	local szMsg = "Chọn Hệ:";
	local tbOpt = {
		{"Kim",self.lsAoThuyHoangNuKim,self};
		{"Mộc",self.lsAoThuyHoangNuMoc,self};
		{"Thủy",self.lsAoThuyHoangNuThuy,self};
		{"Hỏa",self.lsAoThuyHoangNuHoa,self};
		{"Thổ",self.lsAoThuyHoangNuTho,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end
----------------------------------------------------------------------------------
function tbLiGuan:Shopchucphuc()
    me.OpenShop(133,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:ShopLiendau()
    me.OpenShop(134,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:Shoptranhdoat()
    me.OpenShop(147,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:Shopthinhha()
    me.OpenShop(128,1);
end
----------------------------------------------------------------------------------
function tbLiGuan:Svukhi1()
me.OpenShop(156, 1);
end

function tbLiGuan:Svukhi2()
me.OpenShop(157, 1);
end

function tbLiGuan:Svukhi3()
me.OpenShop(158, 1);
end

function tbLiGuan:Svukhi4()
me.OpenShop(159, 1);
end

function tbLiGuan:Svukhi5()
me.OpenShop(160, 1);
end
----------------------------------------------------------------------------------
function tbLiGuan:ShopQuanham()
    local nSeries = me.nSeries;
    if (nSeries == 0) then
        Dialog:Say("Bạn hãy gia nhập phái");
        return;
end
    if (1 == nSeries) then
        me.OpenShop(149,1);
    elseif (2 == nSeries) then
        me.OpenShop(150,1);
    elseif (3 == nSeries) then
        me.OpenShop(151,1);
    elseif (4 == nSeries) then
        me.OpenShop(152,1);
    elseif (5 == nSeries) then
        me.OpenShop(153,1);
    else
        Dbg:WriteLogEx(Dbg.LOG_INFO, "Hỗ Trợ tân thủ", me.szName, "Bạn chưa gia nhập phái", nSeries);
    end
end
----------------------------------------------------------------------------------
function tbLiGuan:ShopThuyhoang()
local nSeries = me.nSeries;
    if (nSeries == 0) then
        Dialog:Say("Bạn hãy gia nhập phái");
        return;
    end
    if (1 == nSeries) then
        me.OpenShop(156,1);
    elseif (2 == nSeries) then
        me.OpenShop(157,1);
    elseif (3 == nSeries) then
        me.OpenShop(158,1);
    elseif (4 == nSeries) then
        me.OpenShop(159,1);
    elseif (5 == nSeries) then
        me.OpenShop(160,1);
    else
        Dbg:WriteLogEx(Dbg.LOG_INFO, "Hỗ Trợ tân thủ", me.szName, "Bạn chưa gia nhập phái", nSeries);
    end
end 
----------------------------------------------------------------------------------
function tbLiGuan:PhiPhong()
	local szMsg = "Tụ Hội Kiếm";
	local tbOpt = {
		{"Nhận Phi Phong 1",self.PhiPhong1,self};
		{"Nhận Phi Phong 2",self.PhiPhong2,self};
		{"Nhận Phi Phong 3",self.PhiPhong3,self};
		{"Nhận Phi Phong 4",self.PhiPhong4,self};
		{"Nhận Phi Phong 5",self.PhiPhong5,self};
		{"Nhận Phi Phong 6",self.PhiPhong6,self};
		{"Nhận Phi Phong 7",self.PhiPhong7,self};
		{"Nhận Phi Phong 8",self.PhiPhong8,self};
		{"Nhận Phi Phong 9",self.PhiPhong9,self};
		{"Nhận Phi Phong 10",self.PhiPhong10,self};
		{"<color=pink>Trở Lại Trước<color>",self.TrangBi,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:PhiPhong1()
	me.AddItem(1,17,10,1,5);	
	me.AddItem(1,17,9,1,5);	
	me.AddItem(1,17,8,1,4);
	me.AddItem(1,17,7,1,4);
	me.AddItem(1,17,6,1,3);	
	me.AddItem(1,17,5,1,3);	
	me.AddItem(1,17,4,1,2);	
	me.AddItem(1,17,3,1,2);	
	me.AddItem(1,17,2,1,1);
	me.AddItem(1,17,1,1,1);
end

function tbLiGuan:PhiPhong2()
	me.AddItem(1,17,10,2,5);	
	me.AddItem(1,17,9,2,5);	
	me.AddItem(1,17,8,2,4);
	me.AddItem(1,17,7,2,4);
	me.AddItem(1,17,6,2,3);	
	me.AddItem(1,17,5,2,3);	
	me.AddItem(1,17,4,2,2);	
	me.AddItem(1,17,3,2,2);	
	me.AddItem(1,17,2,2,1);
	me.AddItem(1,17,1,2,1);
end

function tbLiGuan:PhiPhong3()
	me.AddItem(1,17,10,3,5);	
	me.AddItem(1,17,9,3,5);	
	me.AddItem(1,17,8,3,4);
	me.AddItem(1,17,7,3,4);
	me.AddItem(1,17,6,3,3);	
	me.AddItem(1,17,5,3,3);	
	me.AddItem(1,17,4,3,2);	
	me.AddItem(1,17,3,3,2);	
	me.AddItem(1,17,2,3,1);
	me.AddItem(1,17,1,3,1);
end

function tbLiGuan:PhiPhong4()
	me.AddItem(1,17,10,4,5);	
	me.AddItem(1,17,9,4,5);	
	me.AddItem(1,17,8,4,4);
	me.AddItem(1,17,7,4,4);
	me.AddItem(1,17,6,4,3);	
	me.AddItem(1,17,5,4,3);	
	me.AddItem(1,17,4,4,2);	
	me.AddItem(1,17,3,4,2);	
	me.AddItem(1,17,2,4,1);
	me.AddItem(1,17,1,4,1);
end

function tbLiGuan:PhiPhong5()
	me.AddItem(1,17,10,5,5);	
	me.AddItem(1,17,9,5,5);	
	me.AddItem(1,17,8,5,4);
	me.AddItem(1,17,7,5,4);
	me.AddItem(1,17,6,5,3);	
	me.AddItem(1,17,5,5,3);	
	me.AddItem(1,17,4,5,2);	
	me.AddItem(1,17,3,5,2);	
	me.AddItem(1,17,2,5,1);
	me.AddItem(1,17,1,5,1);
end

function tbLiGuan:PhiPhong6()
	me.AddItem(1,17,10,6,5);	
	me.AddItem(1,17,9,6,5);	
	me.AddItem(1,17,8,6,4);
	me.AddItem(1,17,7,6,4);
	me.AddItem(1,17,6,6,3);	
	me.AddItem(1,17,5,6,3);	
	me.AddItem(1,17,4,6,2);	
	me.AddItem(1,17,3,6,2);	
	me.AddItem(1,17,2,6,1);
	me.AddItem(1,17,1,6,1);
end

function tbLiGuan:PhiPhong7()
	me.AddItem(1,17,10,7,5);	
	me.AddItem(1,17,9,7,5);	
	me.AddItem(1,17,8,7,4);
	me.AddItem(1,17,7,7,4);
	me.AddItem(1,17,6,7,3);	
	me.AddItem(1,17,5,7,3);	
	me.AddItem(1,17,4,7,2);	
	me.AddItem(1,17,3,7,2);	
	me.AddItem(1,17,2,7,1);
	me.AddItem(1,17,1,7,1);
end

function tbLiGuan:PhiPhong8()
	me.AddItem(1,17,10,8,5);	
	me.AddItem(1,17,9,8,5);	
	me.AddItem(1,17,8,8,4);
	me.AddItem(1,17,7,8,4);
	me.AddItem(1,17,6,8,3);	
	me.AddItem(1,17,5,8,3);	
	me.AddItem(1,17,4,8,2);	
	me.AddItem(1,17,3,8,2);	
	me.AddItem(1,17,2,8,1);
	me.AddItem(1,17,1,8,1);
end

function tbLiGuan:PhiPhong9()
	me.AddItem(1,17,10,9,5);	
	me.AddItem(1,17,9,9,5);	
	me.AddItem(1,17,8,9,4);
	me.AddItem(1,17,7,9,4);
	me.AddItem(1,17,6,9,3);	
	me.AddItem(1,17,5,9,3);	
	me.AddItem(1,17,4,9,2);	
	me.AddItem(1,17,3,9,2);	
	me.AddItem(1,17,2,9,1);
	me.AddItem(1,17,1,9,1);
end

function tbLiGuan:PhiPhong10()
	me.AddItem(1,17,10,10,5);	
	me.AddItem(1,17,9,10,5);	
	me.AddItem(1,17,8,10,4);
	me.AddItem(1,17,7,10,4);
	me.AddItem(1,17,6,10,3);	
	me.AddItem(1,17,5,10,3);	
	me.AddItem(1,17,4,10,2);	
	me.AddItem(1,17,3,10,2);	
	me.AddItem(1,17,2,10,1);
	me.AddItem(1,17,1,10,1);
end
-----------------------------------------------------------------------------------
function tbLiGuan:VoLamMatTich()
	me.AddItem(18,1,191,1); --Võ Lâm Mật Tịch Sơ
	me.AddItem(18,1,191,1); --Võ Lâm Mật Tịch Sơ
	me.AddItem(18,1,191,1); --Võ Lâm Mật Tịch Sơ
	me.AddItem(18,1,191,1); --Võ Lâm Mật Tịch Sơ
	me.AddItem(18,1,191,1); --Võ Lâm Mật Tịch Sơ
	me.AddItem(18,1,191,2); --Võ Lâm Mật Tịch Trung
	me.AddItem(18,1,191,2); --Võ Lâm Mật Tịch Trung
	me.AddItem(18,1,191,2); --Võ Lâm Mật Tịch Trung
	me.AddItem(18,1,191,2); --Võ Lâm Mật Tịch Trung
	me.AddItem(18,1,191,2); --Võ Lâm Mật Tịch Trung
end
-----------------------------------------------------------------------------------
function tbLiGuan:TayTuyKinh()
	me.AddItem(18,1,192,1); --Tẩy Tủy Kinh Sơ
	me.AddItem(18,1,192,1); --Tẩy Tủy Kinh Sơ
	me.AddItem(18,1,192,1); --Tẩy Tủy Kinh Sơ
	me.AddItem(18,1,192,1); --Tẩy Tủy Kinh Sơ
	me.AddItem(18,1,192,1); --Tẩy Tủy Kinh Sơ
	me.AddItem(18,1,192,2); --Tẩy Tủy Kinh Trung
	me.AddItem(18,1,192,2); --Tẩy Tủy Kinh Trung
	me.AddItem(18,1,192,2); --Tẩy Tủy Kinh Trung
	me.AddItem(18,1,192,2); --Tẩy Tủy Kinh Trung
	me.AddItem(18,1,192,2); --Tẩy Tủy Kinh Trung
end
-----------------------------------------------------------------------------------
function tbLiGuan:BanhTrai()
	me.AddItem(18,1,326,2); --Bánh ít Bát Bảo
	me.AddItem(18,1,326,2); --Bánh ít Bát Bảo
	me.AddItem(18,1,326,3); --bánh ít thập cẩm
	me.AddItem(18,1,326,3); --bánh ít thập cẩm
	me.AddItem(18,1,464,1); --Thái Vân Truy Nguyệt (10 tiềm năng)
	me.AddItem(18,1,464,1); --Thái Vân Truy Nguyệt (10 tiềm năng)
	me.AddItem(18,1,465,1); --Thương Hải Nguyệt Minh (1 điểm kỹ năng)
	me.AddItem(18,1,465,1); --Thương Hải Nguyệt Minh (1 điểm kỹ năng)
end
-----------------------------------------------------------------------------------
function tbLiGuan:LBUyDanh()
	me.AddItem(18,1,236,1); --Lệnh Bài Uy Danh Giang Hồ (20đ)
	me.AddItem(18,1,236,1); --Lệnh Bài Uy Danh Giang Hồ (20đ)
	me.AddItem(18,1,236,1); --Lệnh Bài Uy Danh Giang Hồ (20đ)
	me.AddItem(18,1,236,1); --Lệnh Bài Uy Danh Giang Hồ (20đ)
	me.AddItem(18,1,236,1); --Lệnh Bài Uy Danh Giang Hồ (20đ)
end
--------------------------------------------------------------------------------------
function tbLiGuan:lsLungTrucLocNuKim()
	me.AddItem(4,8,518,10); --Lưng trục lộc - Kim - Nữ
	me.AddItem(4,8,520,10); --Lưng trục lộc - Kim - Nữ
	me.AddItem(4,8,538,10); --Lưng trục lộc - Kim - Nữ
	me.AddItem(4,8,540,10); --Lưng trục lộc - Kim - Nữ
	me.AddItem(4,8,558,10); --Lưng trục lộc - Kim - Nữ
	me.AddItem(4,8,460,10); --Lưng trục lộc - Kim - Nữ
end

function tbLiGuan:lsLungTrucLocNuMoc()
	me.AddItem(4,8,522,10); --Lưng trục lộc - Mộc - Nữ
	me.AddItem(4,8,524,10); --Lưng trục lộc - Mộc - Nữ
	me.AddItem(4,8,542,10); --Lưng trục lộc - Mộc - Nữ
	me.AddItem(4,8,544,10); --Lưng trục lộc - Mộc - Nữ
	me.AddItem(4,8,462,10); --Lưng trục lộc - Mộc - Nữ
	me.AddItem(4,8,464,10); --Lưng trục lộc - Mộc - Nữ
end

function tbLiGuan:lsLungTrucLocNuThuy()
	me.AddItem(4,8,526,10); --Lưng trục lộc - Thủy - Nữ
	me.AddItem(4,8,528,10); --Lưng trục lộc - Thủy - Nữ
	me.AddItem(4,8,546,10); --Lưng trục lộc - Thủy - Nữ
	me.AddItem(4,8,548,10); --Lưng trục lộc - Thủy - Nữ
	me.AddItem(4,8,466,10); --Lưng trục lộc - Thủy - Nữ
	me.AddItem(4,8,468,10); --Lưng trục lộc - Thủy - Nữ
end

function tbLiGuan:lsTrucLocNuHoa()
	me.AddItem(4,8,530,10); --Lưng trục lộc - Hỏa - Nữ
	me.AddItem(4,8,532,10); --Lưng trục lộc - Hỏa - Nữ
	me.AddItem(4,8,550,10); --Lưng trục lộc - Hỏa - Nữ
	me.AddItem(4,8,552,10); --Lưng trục lộc - Hỏa - Nữ
	me.AddItem(4,8,470,10); --Lưng trục lộc - Hỏa - Nữ
	me.AddItem(4,8,472,10); --Lưng trục lộc - Hỏa - Nữ
end

function tbLiGuan:lsLungTrucLocNuTho()
	me.AddItem(4,8,534,10); --Lưng trục lộc - Thổ - Nữ
	me.AddItem(4,8,536,10); --Lưng trục lộc - Thổ - Nữ
	me.AddItem(4,8,554,10); --Lưng trục lộc - Thổ - Nữ
	me.AddItem(4,8,556,10); --Lưng trục lộc - Thổ - Nữ
	me.AddItem(4,8,474,10); --Lưng trục lộc - Thổ - Nữ
	me.AddItem(4,8,476,10); --Lưng trục lộc - Thổ - Nữ
end

function tbLiGuan:lsLungTrucLocNamKim()
	me.AddItem(4,8,517,10); --Lưng trục lộc - Kim - Nam
	me.AddItem(4,8,519,10); --Lưng trục lộc - Kim - Nam
	me.AddItem(4,8,537,10); --Lưng trục lộc - Kim - Nam
	me.AddItem(4,8,539,10); --Lưng trục lộc - Kim - Nam
	me.AddItem(4,8,557,10); --Lưng trục lộc - Kim - Nam
	me.AddItem(4,8,459,10); --Lưng trục lộc - Kim - Nam
end

function tbLiGuan:lsLungTrucLocNamMoc()
	me.AddItem(4,8,521,10); --Lưng trục lộc - Mộc - Nam
	me.AddItem(4,8,523,10); --Lưng trục lộc - Mộc - Nam
	me.AddItem(4,8,541,10); --Lưng trục lộc - Mộc - Nam
	me.AddItem(4,8,543,10); --Lưng trục lộc - Mộc - Nam
	me.AddItem(4,8,461,10); --Lưng trục lộc - Mộc - Nam
	me.AddItem(4,8,463,10); --Lưng trục lộc - Mộc - Nam
end

function tbLiGuan:lsLungTrucLocNamThuy()
	me.AddItem(4,8,525,10); --Lưng trục lộc - Thủy - Nam
	me.AddItem(4,8,527,10); --Lưng trục lộc - Thủy - Nam
	me.AddItem(4,8,545,10); --Lưng trục lộc - Thủy - Nam
	me.AddItem(4,8,547,10); --Lưng trục lộc - Thủy - Nam
	me.AddItem(4,8,465,10); --Lưng trục lộc - Thủy - Nam
	me.AddItem(4,8,467,10); --Lưng trục lộc - Thủy - Nam
end

function tbLiGuan:lsLungTrucLocNamHoa()
	me.AddItem(4,8,529,10); --Lưng trục lộc - Hỏa - Nam
	me.AddItem(4,8,531,10); --Lưng trục lộc - Hỏa - Nam
	me.AddItem(4,8,549,10); --Lưng trục lộc - Hỏa - Nam
	me.AddItem(4,8,551,10); --Lưng trục lộc - Hỏa - Nam
	me.AddItem(4,8,469,10); --Lưng trục lộc - Hỏa - Nam
	me.AddItem(4,8,471,10); --Lưng trục lộc - Hỏa - Nam
end

function tbLiGuan:lsLungTrucLocNamTho()
	me.AddItem(4,8,533,10); --Lưng trục lộc - Thổ - Nam
	me.AddItem(4,8,535,10); --Lưng trục lộc - Thổ - Nam
	me.AddItem(4,8,553,10); --Lưng trục lộc - Thổ - Nam
	me.AddItem(4,8,555,10); --Lưng trục lộc - Thổ - Nam
	me.AddItem(4,8,473,10); --Lưng trục lộc - Thổ - Nam
	me.AddItem(4,8,475,10); --Lưng trục lộc - Thổ - Nam
end
--------------------------------------------------------------------------------------
function tbLiGuan:lsGiayTieuDaoNuKim()
	me.AddItem(4,7,32,10); --Giầy tiêu dao - Kim - Nữ
	me.AddItem(4,7,42,10); --Giầy tiêu dao - Kim - Nữ
end

function tbLiGuan:lsGiayTieuDaoNuMoc()
	me.AddItem(4,7,34,10); --Giầy tiêu dao - Mộc - Nữ
	me.AddItem(4,7,44,10); --Giầy tiêu dao - Mộc - Nữ
end

function tbLiGuan:lsGiayTieuDaoNuThuy()
	me.AddItem(4,7,36,10); --Giầy tiêu dao - Thủy - Nữ
	me.AddItem(4,7,46,10); --Giầy tiêu dao - Thủy - Nữ
end

function tbLiGuan:lsGiayTieuDaoNuHoa()
	me.AddItem(4,7,38,10); --Giầy tiêu dao - Hỏa - Nữ
	me.AddItem(4,7,48,10); --Giầy tiêu dao - Hỏa - Nữ
end

function tbLiGuan:lsGiayTieuDaoNuTho()
	me.AddItem(4,7,40,10); --Giầy tiêu dao - Thổ - Nữ
	me.AddItem(4,7,50,10); --Giầy tiêu dao - Thổ - Nữ
end

function tbLiGuan:lsGiayTieuDaoNamKim()
	me.AddItem(4,7,31,10); --Giầy tiêu dao - Kim - Nam
	me.AddItem(4,7,41,10); --Giầy tiêu dao - Kim - Nam
end

function tbLiGuan:lsGiayTieuDaoNamMoc()
	me.AddItem(4,7,33,10); --Giầy tiêu dao - Mộc - Nam
	me.AddItem(4,7,43,10); --Giầy tiêu dao - Mộc - Nam
end

function tbLiGuan:lsGiayTieuDaoNamThuy()
	me.AddItem(4,7,35,10); --Giầy tiêu dao - Thủy - Nam
	me.AddItem(4,7,45,10); --Giầy tiêu dao - Thủy - Nam
end

function tbLiGuan:lsGiayTieuDaoNamHoa()
	me.AddItem(4,7,37,10); --Giầy tiêu dao - Hỏa - Nam
	me.AddItem(4,7,47,10); --Giầy tiêu dao - Hỏa - Nam
end

function tbLiGuan:lsGiayTieuDaoNamTho()
	me.AddItem(4,7,39,10); --Giầy tiêu dao - Thổ - Nam
	me.AddItem(4,7,49,10); --Giầy tiêu dao - Thổ - Nam
end
--------------------------------------------------------------------------------------
function tbLiGuan:lsAoThuyHoangNuKim()
	me.AddItem(4,3,20045,10); -- Áo thủy hoàng - nữ - Kim
end

function tbLiGuan:lsAoThuyHoangNuMoc()
	me.AddItem(4,3,20046,10); -- Áo thủy hoàng - nữ - mộc
end

function tbLiGuan:lsAoThuyHoangNuThuy()
	me.AddItem(4,3,20047,10); -- Áo thủy hoàng - nữ - thủy
end

function tbLiGuan:lsAoThuyHoangNuHoa()
	me.AddItem(4,3,20048,10); -- Áo thủy hoàng - nữ - hỏa
end

function tbLiGuan:lsAoThuyHoangNuTho()
	me.AddItem(4,3,20049,10); -- Áo thủy hoàng - nữ - thổ
end

function tbLiGuan:lsAoThuyHoangNamKim()
	me.AddItem(4,3,233,10); -- Áo thủy hoàng - nam - Kim
end

function tbLiGuan:lsAoThuyHoangNamMoc()
	me.AddItem(4,3,234,10); -- Áo thủy hoàng - nam - Mộc
end

function tbLiGuan:lsAoThuyHoangNamThuy()
	me.AddItem(4,3,235,10); -- Áo thủy hoàng - nam - Thủy
end

function tbLiGuan:lsAoThuyHoangNamHoa()
	me.AddItem(4,3,236,10); -- Áo thủy hoàng - nam - hỏa
end

function tbLiGuan:lsAoThuyHoangNamTho()
	me.AddItem(4,3,237,10); -- Áo thủy hoàng - nam - thổ
end
--------------------------------------------------------------------------------------
function tbLiGuan:lsNonTrucLocNuKim()
	me.AddItem(4,9,478,10); --Nón trục lộc - Kim - Nữ
	me.AddItem(4,9,488,10); --Nón trục lộc - Kim - Nữ
end

function tbLiGuan:lsNonTrucLocNuMoc()
	me.AddItem(4,9,480,10); --Nón trục lộc - Mộc - Nữ
	me.AddItem(4,9,490,10); --Nón trục lộc - Mộc - Nữ
end

function tbLiGuan:lsNonTrucLocNuThuy()
	me.AddItem(4,9,482,10); --Nón trục lộc - Thủy - Nữ
	me.AddItem(4,9,492,10); --Nón trục lộc - Thủy - Nữ
end

function tbLiGuan:lsNonTrucLocNuHoa()
	me.AddItem(4,9,484,10); --Nón trục lộc - Hỏa - Nữ
	me.AddItem(4,9,494,10); --Nón trục lộc - Hỏa - Nữ
end

function tbLiGuan:lsNonTrucLocNuTho()
	me.AddItem(4,9,486,10); --Nón trục lộc - Thổ - Nữ
	me.AddItem(4,9,496,10); --Nón trục lộc - Thổ - Nữ
end

function tbLiGuan:lsNonTrucLocNamKim()
	me.AddItem(4,9,477,10); --Nón trục lộc - Kim - Nam
	me.AddItem(4,9,487,10); --Nón trục lộc - Kim - Nam
end

function tbLiGuan:lsNonTrucLocNamMoc()
	me.AddItem(4,9,479,10); --Nón trục lộc - Mộc - Nam
	me.AddItem(4,9,489,10); --Nón trục lộc - Mộc - Nam
end

function tbLiGuan:lsNonTrucLocNamThuy()
	me.AddItem(4,9,481,10); --Nón trục lộc - Thủy - Nam
	me.AddItem(4,9,491,10); --Nón trục lộc - Thủy - Nam
end

function tbLiGuan:lsNonTrucLocNamHoa()
	me.AddItem(4,9,483,10); --Nón trục lộc - Hỏa - Nam
	me.AddItem(4,9,493,10); --Nón trục lộc - Hỏa - Nam
end

function tbLiGuan:lsNonTrucLocNamTho()
	me.AddItem(4,9,485,10); --Nón trục lộc - Thổ - Nam
	me.AddItem(4,9,495,10); --Nón trục lộc - Thổ - Nam
end
-----------------------------------------------------------------------
function tbLiGuan:lsHoPhuVuUyKim()
	me.AddItem(4,6,91,10); --Hộ phù vũ uy - Kim
	me.AddItem(4,6,92,10); --Hộ phù vũ uy - Kim
	me.AddItem(4,6,93,10); --Hộ phù vũ uy - Kim
	me.AddItem(4,6,94,10); --Hộ phù vũ uy - Kim
	me.AddItem(4,6,95,10); --Hộ phù vũ uy - Kim
end

function tbLiGuan:lsHoPhuVuUyMoc()
	me.AddItem(4,6,96,10); --Hộ phù vũ uy - Mộc
	me.AddItem(4,6,97,10); --Hộ phù vũ uy - Mộc
	me.AddItem(4,6,98,10); --Hộ phù vũ uy - Mộc
	me.AddItem(4,6,99,10); --Hộ phù vũ uy - Mộc
	me.AddItem(4,6,100,10); --Hộ phù vũ uy - Mộc 
end

function tbLiGuan:lsHoPhuVuUyThuy()
	me.AddItem(4,6,101,10); --Hộ phù vũ uy - Thủy
	me.AddItem(4,6,102,10); --Hộ phù vũ uy - Thủy
	me.AddItem(4,6,103,10); --Hộ phù vũ uy - Thủy
	me.AddItem(4,6,104,10); --Hộ phù vũ uy - Thủy
	me.AddItem(4,6,105,10); --Hộ phù vũ uy - Thủy
end

function tbLiGuan:lsHoPhuVuUyHoa()
	me.AddItem(4,6,106,10); --Hộ phù vũ uy - Hỏa
	me.AddItem(4,6,107,10); --Hộ phù vũ uy - Hỏa
	me.AddItem(4,6,108,10); --Hộ phù vũ uy - Hỏa
	me.AddItem(4,6,109,10); --Hộ phù vũ uy - Hỏa
	me.AddItem(4,6,110,10); --Hộ phù vũ uy - Hỏa
end

function tbLiGuan:lsHoPhuVuUyTho()
	me.AddItem(4,6,111,10); --Hộ phù vũ uy - Thổ
	me.AddItem(4,6,112,10); --Hộ phù vũ uy - Thổ
	me.AddItem(4,6,113,10); --Hộ phù vũ uy - Thổ
	me.AddItem(4,6,114,10); --Hộ phù vũ uy - Thổ
	me.AddItem(4,6,115,10); --Hộ phù vũ uy - Thổ
end
-----------------------------------------------------------------------
function tbLiGuan:lsLienTrucLocNuKim()
	me.AddItem(4,5,458,10); --Liên trục lộc - Kim - Nữ
end

function tbLiGuan:lsLienTrucLocNuMoc()
	me.AddItem(4,5,460,10); --Liên trục lộc - Mộc - Nữ
end

function tbLiGuan:lsLienTrucLocNuThuy()
	me.AddItem(4,5,462,10); --Liên trục lộc - Thủy - Nữ
end

function tbLiGuan:lsLienTrucLocNuHoa()
	me.AddItem(4,5,464,10); --Liên trục lộc - Hỏa - Nữ
end

function tbLiGuan:lsLienTrucLocNuTho()
	me.AddItem(4,5,466,10); --Liên trục lộc - Thổ - Nữ
end

function tbLiGuan:lsLienTrucLocNamKim()
	me.AddItem(4,5,457,10); --Liên trục lộc - Kim - Nam
end

function tbLiGuan:lsLienTrucLocNamMoc()
	me.AddItem(4,5,459,10); --Liên trục lộc - Mộc - Nam
end

function tbLiGuan:lsLienTrucLocNamThuy()
	me.AddItem(4,5,461,10); --Liên trục lộc - Thủy - Nam
end

function tbLiGuan:lsLienTrucLocNamHoa()
	me.AddItem(4,5,463,10); --Liên trục lộc - Hỏa - Nam
end

function tbLiGuan:lsLienTrucLocNamTho()
	me.AddItem(4,5,465,10); --Liên trục lộc - Thổ - Nam
end
-----------------------------------------------------------------------
function tbLiGuan:lsAoVuUyNuKim()
	me.AddItem(4,3,143,10); --Áo Vũ Y Nữ - Kim
	me.AddItem(4,3,148,10); --Áo Vũ Y Nữ - Kim
end

function tbLiGuan:lsAoVuUyNuMoc()
	me.AddItem(4,3,144,10); --Áo Vũ Y Nữ - Mộc
	me.AddItem(4,3,149,10); --Áo Vũ Y Nữ - Mộc
end

function tbLiGuan:lsAoVuUyNuThuy()
	me.AddItem(4,3,145,10); --Áo Vũ Y Nữ - Thủy
	me.AddItem(4,3,150,10); --Áo Vũ Y Nữ - Thủy
end

function tbLiGuan:lsAoVuUyNuHoa()
	me.AddItem(4,3,146,10); --Áo Vũ Y Nữ - Hỏa
	me.AddItem(4,3,151,10); --Áo Vũ Y Nữ - Hỏa
end

function tbLiGuan:lsAoVuUyNuTho()
	me.AddItem(4,3,147,10); --Áo Vũ Y Nữ - Thổ
	me.AddItem(4,3,152,10); --Áo Vũ Y Nữ - Thổ
end

function tbLiGuan:lsAoVuUyNamKim()
	me.AddItem(4,3,153,10); --Áo Vũ Y Nam - Kim
	me.AddItem(4,3,158,10); --Áo Vũ Y Nam - Kim
end

function tbLiGuan:lsAoVuUyNamMoc()
	me.AddItem(4,3,154,10); --Áo Vũ Y Nam - Mộc
	me.AddItem(4,3,159,10); --Áo Vũ Y Nam - Mộc
end

function tbLiGuan:lsAoVuUyNamThuy()
	me.AddItem(4,3,155,10); --Áo Vũ Y Nam - Thủy
	me.AddItem(4,3,160,10); --Áo Vũ Y Nam - Thủy
end

function tbLiGuan:lsAoVuUyNamHoa()
	me.AddItem(4,3,156,10); --Áo Vũ Y Nam - Hỏa
	me.AddItem(4,3,161,10); --Áo Vũ Y Nam - Hỏa
end

function tbLiGuan:lsAoVuUyNamTho()
	me.AddItem(4,3,157,10); --Áo Vũ Y Nam - Thổ
	me.AddItem(4,3,162,10); --Áo Vũ Y Nam - Thổ
end
-----------------------------------------------------------------------
function tbLiGuan:lsNhanVuUyNuKim()
	me.AddItem(4,4,445,10); --Nhẫn Vũ Uy - Kim - Nữ
	me.AddItem(4,4,455,10); --Nhẫn Vũ Uy - Kim - Nữ
end

function tbLiGuan:lsNhanVuUyNuMoc()
	me.AddItem(4,4,447,10); --Nhẫn Vũ Uy - Mộc - Nữ
	me.AddItem(4,4,457,10); --Nhẫn Vũ Uy - Mộc - Nữ
end

function tbLiGuan:lsNhanVuUyNuThuy()
	me.AddItem(4,4,449,10); --Nhẫn Vũ Uy - Thủy - Nữ
	me.AddItem(4,4,459,10); --Nhẫn Vũ Uy - Thủy - Nữ
end

function tbLiGuan:lsNhanVuUyNuHoa()
	me.AddItem(4,4,451,10); --Nhẫn Vũ Uy - Hỏa - Nữ
	me.AddItem(4,4,461,10); --Nhẫn Vũ Uy - Hỏa - Nữ
end

function tbLiGuan:lsNhanVuUyNuTho()
	me.AddItem(4,4,453,10); --Nhẫn Vũ Uy - Thổ - Nữ
	me.AddItem(4,4,463,10); --Nhẫn Vũ Uy - Thổ - Nữ
end

function tbLiGuan:lsNhanVuUyNamKim()
	me.AddItem(4,4,444,10); --Nhẫn Vũ Uy - Kim - Nam
	me.AddItem(4,4,454,10); --Nhẫn Vũ Uy - Kim - Nam
end

function tbLiGuan:lsNhanVuUyNamMoc()
	me.AddItem(4,4,446,10); --Nhẫn Vũ Uy - Mộc - Nam
	me.AddItem(4,4,456,10); --Nhẫn Vũ Uy - Mộc - Nam
end

function tbLiGuan:lsNhanVuUyNamThuy()
	me.AddItem(4,4,448,10); --Nhẫn Vũ Uy - Thủy - Nam
	me.AddItem(4,4,458,10); --Nhẫn Vũ Uy - Thủy - Nam
end

function tbLiGuan:lsNhanVuUyNamHoa()
	me.AddItem(4,4,450,10); --Nhẫn Vũ Uy - Hỏa - Nam
	me.AddItem(4,4,460,10); --Nhẫn Vũ Uy - Hỏa - Nam
end

function tbLiGuan:lsNhanVuUyNamTho()
	me.AddItem(4,4,452,10); --Nhẫn Vũ Uy - Thổ - Nam
	me.AddItem(4,4,462,10); --Nhẫn Vũ Uy - Thổ - Nam
end
-----------------------------------------------------------------------
function tbLiGuan:lsNgocBoiThuyHoangNuKim()
	me.AddItem(4,11,82,10); --Ngọc bội thủy hoàng - Kim - Nữ
	me.AddItem(4,11,92,10); --Ngọc bội thủy hoàng - Kim - Nữ
end

function tbLiGuan:lsNgocBoiThuyHoangNuMoc()
	me.AddItem(4,11,84,10); --Ngọc bội thủy hoàng - Mộc - Nữ
	me.AddItem(4,11,94,10); --Ngọc bội thủy hoàng - Mộc - Nữ
end

function tbLiGuan:lsNgocBoiThuyHoangNuThuy()
	me.AddItem(4,11,86,10); --Ngọc bội thủy hoàng - Thủy - Nữ
	me.AddItem(4,11,96,10); --Ngọc bội thủy hoàng - Thủy - Nữ
end

function tbLiGuan:lsNgocBoiThuyHoangNuHoa()
	me.AddItem(4,11,88,10); --Ngọc bội thủy hoàng - Hỏa - Nữ
	me.AddItem(4,11,98,10); --Ngọc bội thủy hoàng - Hỏa - Nữ
end

function tbLiGuan:lsNgocBoiThuyHoangNuTho()
	me.AddItem(4,11,90,10); --Ngọc bội thủy hoàng - Thổ - Nữ
	me.AddItem(4,11,100,10); --Ngọc bội thủy hoàng - Thổ - Nữ
end

function tbLiGuan:lsNgocBoiThuyHoangNamKim()
	me.AddItem(4,11,81,10); --Ngọc bội thủy hoàng - Kim - nam
	me.AddItem(4,11,91,10); --Ngọc bội thủy hoàng - Kim - nam
end

function tbLiGuan:lsNgocBoiThuyHoangNamMoc()
	me.AddItem(4,11,83,10); --Ngọc bội thủy hoàng - Mộc - nam
	me.AddItem(4,11,93,10); --Ngọc bội thủy hoàng - Mộc - nam
end

function tbLiGuan:lsNgocBoiThuyHoangNamThuy()
	me.AddItem(4,11,85,10); --Ngọc bội thủy hoàng - Thủy - nam
	me.AddItem(4,11,95,10); --Ngọc bội thủy hoàng - Thủy - nam
end

function tbLiGuan:lsNgocBoiThuyHoangNamHoa()
	me.AddItem(4,11,87,10); --Ngọc bội thủy hoàng - Hỏa - nam
	me.AddItem(4,11,97,10); --Ngọc bội thủy hoàng - Hỏa - nam
end

function tbLiGuan:lsNgocBoiThuyHoangNamTho()
	me.AddItem(4,11,89,10); --Ngọc bội thủy hoàng - Thổ - nam
	me.AddItem(4,11,99,10); --Ngọc bội thủy hoàng - Thổ - nam
end
-------------------------------------------------------------------------------
function tbLiGuan:lsBaoTayThuyHoangNuKim()
	me.AddItem(4,10,96,10); --Bao tay thủy hoàng - Kim - Nữ
	me.AddItem(4,10,98,10); --Bao tay thủy hoàng - Kim - Nữ
	me.AddItem(4,10,482,10); --Bao tay thủy hoàng - Kim - Nữ
	me.AddItem(4,10,484,10); --Bao tay thủy hoàng - Kim - Nữ
	me.AddItem(4,10,502,10); --Bao tay thủy hoàng - Kim - Nữ
	me.AddItem(4,10,504,10); --Bao tay thủy hoàng - Kim - Nữ
end

function tbLiGuan:lsBaoTayThuyHoangNuMoc()
	me.AddItem(4,10,100,10); --Bao tay thủy hoàng - Mộc - Nữ
	me.AddItem(4,10,102,10); --Bao tay thủy hoàng - Mộc - Nữ
	me.AddItem(4,10,486,10); --Bao tay thủy hoàng - Mộc - Nữ
	me.AddItem(4,10,488,10); --Bao tay thủy hoàng - Mộc - Nữ
	me.AddItem(4,10,506,10); --Bao tay thủy hoàng - Mộc - Nữ
	me.AddItem(4,10,508,10); --Bao tay thủy hoàng - Mộc - Nữ
end

function tbLiGuan:lsBaoTayThuyHoangNuThuy()
	me.AddItem(4,10,104,10); --Bao tay thủy hoàng - Thủy - Nữ
	me.AddItem(4,10,106,10); --Bao tay thủy hoàng - Thủy - Nữ
	me.AddItem(4,10,490,10); --Bao tay thủy hoàng - Thủy - Nữ
	me.AddItem(4,10,492,10); --Bao tay thủy hoàng - Thủy - Nữ
	me.AddItem(4,10,510,10); --Bao tay thủy hoàng - Thủy - Nữ
	me.AddItem(4,10,512,10); --Bao tay thủy hoàng - Thủy - Nữ
end

function tbLiGuan:lsBaoTayThuyHoangNuHoa()
	me.AddItem(4,10,108,10); --Bao tay thủy hoàng - Hỏa - Nữ
	me.AddItem(4,10,110,10); --Bao tay thủy hoàng - Hỏa - Nữ
	me.AddItem(4,10,494,10); --Bao tay thủy hoàng - Hỏa - Nữ
	me.AddItem(4,10,496,10); --Bao tay thủy hoàng - Hỏa - Nữ
	me.AddItem(4,10,514,10); --Bao tay thủy hoàng - Hỏa - Nữ
	me.AddItem(4,10,516,10); --Bao tay thủy hoàng - Hỏa - Nữ
end

function tbLiGuan:lsBaoTayThuyHoangNuTho()
	me.AddItem(4,10,112,10); --Bao tay thủy hoàng - Thổ - Nữ
	me.AddItem(4,10,114,10); --Bao tay thủy hoàng - Thổ - Nữ
	me.AddItem(4,10,498,10); --Bao tay thủy hoàng - Thổ - Nữ
	me.AddItem(4,10,500,10); --Bao tay thủy hoàng - Thổ - Nữ
	me.AddItem(4,10,518,10); --Bao tay thủy hoàng - Thổ - Nữ
	me.AddItem(4,10,520,10); --Bao tay thủy hoàng - Thổ - Nữ
end

function tbLiGuan:lsBaoTayThuyHoangNamKim()
	me.AddItem(4,10,95,10); --Bao tay thủy hoàng - Kim - Nam
	me.AddItem(4,10,97,10); --Bao tay thủy hoàng - Kim - Nam
	me.AddItem(4,10,481,10); --Bao tay thủy hoàng - Kim - Nam
	me.AddItem(4,10,483,10); --Bao tay thủy hoàng - Kim - Nam
	me.AddItem(4,10,501,10); --Bao tay thủy hoàng - Kim - Nam
	me.AddItem(4,10,503,10); --Bao tay thủy hoàng - Kim - Nam
end

function tbLiGuan:lsBaoTayThuyHoangNamMoc()
	me.AddItem(4,10,99,10); --Bao tay thủy hoàng - Mộc - Nam
	me.AddItem(4,10,101,10); --Bao tay thủy hoàng - Mộc - Nam
	me.AddItem(4,10,485,10); --Bao tay thủy hoàng - Mộc - Nam
	me.AddItem(4,10,487,10); --Bao tay thủy hoàng - Mộc - Nam
	me.AddItem(4,10,505,10); --Bao tay thủy hoàng - Mộc - Nam
	me.AddItem(4,10,507,10); --Bao tay thủy hoàng - Mộc - Nam
end

function tbLiGuan:lsBaoTayThuyHoangNamThuy()
	me.AddItem(4,10,103,10); --Bao tay thủy hoàng - Thủy - Nam
	me.AddItem(4,10,105,10); --Bao tay thủy hoàng - Thủy - Nam
	me.AddItem(4,10,489,10); --Bao tay thủy hoàng - Thủy - Nam
	me.AddItem(4,10,491,10); --Bao tay thủy hoàng - Thủy - Nam
	me.AddItem(4,10,509,10); --Bao tay thủy hoàng - Thủy - Nam
	me.AddItem(4,10,511,10); --Bao tay thủy hoàng - Thủy - Nam
end

function tbLiGuan:lsBaoTayThuyHoangNamHoa()
	me.AddItem(4,10,107,10); --Bao tay thủy hoàng - Hỏa - Nam
	me.AddItem(4,10,109,10); --Bao tay thủy hoàng - Hỏa - Nam
	me.AddItem(4,10,493,10); --Bao tay thủy hoàng - Hỏa - Nam
	me.AddItem(4,10,495,10); --Bao tay thủy hoàng - Hỏa - Nam
	me.AddItem(4,10,513,10); --Bao tay thủy hoàng - Hỏa - Nam
	me.AddItem(4,10,515,10); --Bao tay thủy hoàng - Hỏa - Nam
end

function tbLiGuan:lsBaoTayThuyHoangNamTho()
	me.AddItem(4,10,111,10); --Bao tay thủy hoàng - Thổ - Nam
	me.AddItem(4,10,113,10); --Bao tay thủy hoàng - Thổ - Nam
	me.AddItem(4,10,497,10); --Bao tay thủy hoàng - Thổ - Nam
	me.AddItem(4,10,499,10); --Bao tay thủy hoàng - Thổ - Nam
	me.AddItem(4,10,517,10); --Bao tay thủy hoàng - Thổ - Nam
	me.AddItem(4,10,519,10); --Bao tay thủy hoàng - Thổ - Nam
end
----------------------------------------------------------------------------
function tbLiGuan:lsBaoTayTieuDaoNuKim()
	me.AddItem(4,10,442,10); --Bao tay tiêu dao - Kim - Nữ
	me.AddItem(4,10,444,10); --Bao tay tiêu dao - Kim - Nữ
	me.AddItem(4,10,462,10); --Bao tay tiêu dao - Kim - Nữ
	me.AddItem(4,10,464,10); --Bao tay tiêu dao - Kim - Nữ
end

function tbLiGuan:lsBaoTayTieuDaoNuMoc()
	me.AddItem(4,10,446,10); --Bao tay tiêu dao - Mộc - Nữ
	me.AddItem(4,10,448,10); --Bao tay tiêu dao - Mộc - Nữ
	me.AddItem(4,10,466,10); --Bao tay tiêu dao - Mộc - Nữ
	me.AddItem(4,10,468,10); --Bao tay tiêu dao - Mộc - Nữ
end

function tbLiGuan:lsBaoTayTieuDaoNuThuy()
	me.AddItem(4,10,450,10); --Bao tay tiêu dao - Thủy - Nữ
	me.AddItem(4,10,452,10); --Bao tay tiêu dao - Thủy - Nữ
	me.AddItem(4,10,470,10); --Bao tay tiêu dao - Thủy - Nữ
	me.AddItem(4,10,472,10); --Bao tay tiêu dao - Thủy - Nữ
end

function tbLiGuan:lsBaoTayTieuDaoNuHoa()
	me.AddItem(4,10,454,10); --Bao tay tiêu dao - Hỏa - Nữ
	me.AddItem(4,10,456,10); --Bao tay tiêu dao - Hỏa - Nữ
	me.AddItem(4,10,474,10); --Bao tay tiêu dao - Hỏa - Nữ
	me.AddItem(4,10,476,10); --Bao tay tiêu dao - Hỏa - Nữ
end

function tbLiGuan:lsBaoTayTieuDaoNuTho()
	me.AddItem(4,10,458,10); --Bao tay tiêu dao - Thổ - Nữ
	me.AddItem(4,10,460,10); --Bao tay tiêu dao - Thổ - Nữ
	me.AddItem(4,10,478,10); --Bao tay tiêu dao - Thổ - Nữ
	me.AddItem(4,10,480,10); --Bao tay tiêu dao - Thổ - Nữ
end

function tbLiGuan:lsBaoTayTieuDaoNamKim()
	me.AddItem(4,10,441,10); --Bao tay tiêu dao - Kim - Nam
	me.AddItem(4,10,443,10); --Bao tay tiêu dao - Kim - Nam
	me.AddItem(4,10,461,10); --Bao tay tiêu dao - Kim - Nam
	me.AddItem(4,10,463,10); --Bao tay tiêu dao - Kim - Nam
end

function tbLiGuan:lsBaoTayTieuDaoNamMoc()
	me.AddItem(4,10,445,10); --Bao tay tiêu dao - Mộc - Nam
	me.AddItem(4,10,447,10); --Bao tay tiêu dao - Mộc - Nam
	me.AddItem(4,10,465,10); --Bao tay tiêu dao - Mộc - Nam
	me.AddItem(4,10,467,10); --Bao tay tiêu dao - Mộc - Nam
end

function tbLiGuan:lsBaoTayTieuDaoNamThuy()
	me.AddItem(4,10,449,10); --Bao tay tiêu dao - Thủy - Nam
	me.AddItem(4,10,451,10); --Bao tay tiêu dao - Thủy - Nam
	me.AddItem(4,10,469,10); --Bao tay tiêu dao - Thủy - Nam
	me.AddItem(4,10,471,10); --Bao tay tiêu dao - Thủy - Nam
end

function tbLiGuan:lsBaoTayTieuDaoNamHoa()
	me.AddItem(4,10,453,10); --Bao tay tiêu dao - Hỏa - Nam
	me.AddItem(4,10,455,10); --Bao tay tiêu dao - Hỏa - Nam
	me.AddItem(4,10,473,10); --Bao tay tiêu dao - Hỏa - Nam
	me.AddItem(4,10,475,10); --Bao tay tiêu dao - Hỏa - Nam
end

function tbLiGuan:lsBaoTayTieuDaoNamTho()
	me.AddItem(4,10,457,10); --Bao tay tiêu dao - Thổ - Nam
	me.AddItem(4,10,459,10); --Bao tay tiêu dao - Thổ - Nam
	me.AddItem(4,10,477,10); --Bao tay tiêu dao - Thổ - Nam
	me.AddItem(4,10,479,10); --Bao tay tiêu dao - Thổ - Nam
end
-------------------------------------------------------------------------------
function tbLiGuan:DoCuoi10()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"Do Nam",self.DoNam10,self};
		{"Do Nu",self.DoNu10,self },
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNam10()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim10,self};
		{"He Moc",self.HeMoc10,self};
		{"He Thuy",self.HeThuy10,self};
		{"He Hoa",self.HeHoa10,self};
		{"He Tho",self.HeTho10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNu10()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim101,self};
		{"He Moc",self.HeMoc101,self};
		{"He Thuy",self.HeThuy101,self};
		{"He Hoa",self.HeHoa101,self};
		{"He Tho",self.HeTho101,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim10()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai10,self};
		{"Đồ Nội",self.KimNoi10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim101()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai101,self};
		{"Đồ Nội",self.KimNoi101,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc10()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai10,self};
		{"Đồ Nội",self.MocNoi10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc101()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai101,self};
		{"Đồ Nội",self.MocNoi101,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy10()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai10,self};
		{"Đồ Nội",self.ThuyNoi10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy101()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai101,self};
		{"Đồ Nội",self.ThuyNoi101,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa10()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai10,self};
		{"Đồ Nội",self.HoaNoi10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa101()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai101,self};
		{"Đồ Nội",self.HoaNoi101,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho10()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai10,self};
		{"Đồ Nội",self.ThoNoi10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho101()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai101,self};
		{"Đồ Nội",self.ThoNoi101,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:KimNgoai10()
	me.AddGreenEquip(10,20211,10,5,10); --Th?y Hoàng H?ng Hoang Uy?n
	me.AddGreenEquip(4,20161,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20085,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNgoai101()
	me.AddGreenEquip(10,20212,10,5,10);
	me.AddGreenEquip(4,20161,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20085,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi10()
	me.AddGreenEquip(10,20213,10,5,10);
	me.AddGreenEquip(4,20162,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20086,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi101()
	me.AddGreenEquip(10,20214,10,5,10);
	me.AddGreenEquip(4,20162,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20086,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai10()
	me.AddGreenEquip(10,20215,10,5,10);
	me.AddGreenEquip(4,20163,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20087,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai101()
	me.AddGreenEquip(10,20216,10,5,10);
	me.AddGreenEquip(4,20163,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20087,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi10()
	me.AddGreenEquip(10,20217,10,5,10);
	me.AddGreenEquip(4,20164,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20088,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi101()
	me.AddGreenEquip(10,20218,10,5,10);
	me.AddGreenEquip(4,20164,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20088,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai10()
	me.AddGreenEquip(10,20219,10,5,10);
	me.AddGreenEquip(4,20165,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20089,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai101()
	me.AddGreenEquip(10,20220,10,5,10);
	me.AddGreenEquip(4,20165,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20089,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi10()
	me.AddGreenEquip(10,20221,10,5,10);
	me.AddGreenEquip(4,20166,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20090,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi110()
	me.AddGreenEquip(10,20222,10,5,10);
	me.AddGreenEquip(4,20166,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20090,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai10()
	me.AddGreenEquip(10,20223,10,5,10);
	me.AddGreenEquip(4,20167,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20091,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai101()
	me.AddGreenEquip(10,20224,10,5,10);
	me.AddGreenEquip(4,20167,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20091,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi10()
	me.AddGreenEquip(10,20225,10,5,10);
	me.AddGreenEquip(4,20168,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20092,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi101()
	me.AddGreenEquip(10,20226,10,5,10);
	me.AddGreenEquip(4,20168,10,5,10);--V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20092,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai10()
	me.AddGreenEquip(10,20227,10,5,10);
	me.AddGreenEquip(4,20169,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20093,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai101()
	me.AddGreenEquip(10,20228,10,5,10);
	me.AddGreenEquip(4,20169,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(4,20169,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20093,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi10()
	me.AddGreenEquip(10,20229,10,5,10);
	me.AddGreenEquip(4,20170,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,10); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,10); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20094,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi101()
	me.AddGreenEquip(10,20230,10,5,10);
	me.AddGreenEquip(4,20170,10,5,10); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,10); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,10); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20094,10,5,10); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,10); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,10); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,10); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,10); --V? Uy L?m Nh?t Tinh Huy?n Phù
end
-------------------------------------------------------------------------------
function tbLiGuan:DoCuoi12()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"Do Nam",self.DoNam12,self};
		{"Do Nu",self.DoNu12,self },
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNam12()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim12,self};
		{"He Moc",self.HeMoc12,self};
		{"He Thuy",self.HeThuy12,self};
		{"He Hoa",self.HeHoa12,self};
		{"He Tho",self.HeTho12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNu12()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim121,self};
		{"He Moc",self.HeMoc121,self};
		{"He Thuy",self.HeThuy121,self};
		{"He Hoa",self.HeHoa121,self};
		{"He Tho",self.HeTho121,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim12()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai12,self};
		{"Đồ Nội",self.KimNoi12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim121()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai121,self};
		{"Đồ Nội",self.KimNoi121,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc12()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai12,self};
		{"Đồ Nội",self.MocNoi12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc121()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai121,self};
		{"Đồ Nội",self.MocNoi121,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy12()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai12,self};
		{"Đồ Nội",self.ThuyNoi12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy121()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai121,self};
		{"Đồ Nội",self.ThuyNoi121,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa12()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai12,self};
		{"Đồ Nội",self.HoaNoi12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa121()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai121,self};
		{"Đồ Nội",self.HoaNoi121,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho12()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai12,self};
		{"Đồ Nội",self.ThoNoi12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho121()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai121,self};
		{"Đồ Nội",self.ThoNoi121,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:KimNgoai12()
	me.AddGreenEquip(10,20211,10,5,12); --Th?y Hoàng H?ng Hoang Uy?n
	me.AddGreenEquip(4,20161,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20085,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNgoai121()
	me.AddGreenEquip(10,20212,10,5,12);
	me.AddGreenEquip(4,20161,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20085,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi12()
	me.AddGreenEquip(10,20213,10,5,12);
	me.AddGreenEquip(4,20162,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20086,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi121()
	me.AddGreenEquip(10,20214,10,5,12);
	me.AddGreenEquip(4,20162,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20086,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai12()
	me.AddGreenEquip(10,20215,10,5,12);
	me.AddGreenEquip(4,20163,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20087,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai121()
	me.AddGreenEquip(10,20216,10,5,12);
	me.AddGreenEquip(4,20163,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20087,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi12()
	me.AddGreenEquip(10,20217,10,5,12);
	me.AddGreenEquip(4,20164,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20088,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi121()
	me.AddGreenEquip(10,20218,10,5,12);
	me.AddGreenEquip(4,20164,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20088,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai12()
	me.AddGreenEquip(10,20219,10,5,12);
	me.AddGreenEquip(4,20165,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20089,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai121()
	me.AddGreenEquip(10,20220,10,5,12);
	me.AddGreenEquip(4,20165,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20089,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi12()
	me.AddGreenEquip(10,20221,10,5,12);
	me.AddGreenEquip(4,20166,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20090,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi112()
	me.AddGreenEquip(10,20222,10,5,12);
	me.AddGreenEquip(4,20166,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20090,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai12()
	me.AddGreenEquip(10,20223,10,5,12);
	me.AddGreenEquip(4,20167,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20091,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai121()
	me.AddGreenEquip(10,20224,10,5,12);
	me.AddGreenEquip(4,20167,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20091,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi12()
	me.AddGreenEquip(10,20225,10,5,12);
	me.AddGreenEquip(4,20168,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20092,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi121()
	me.AddGreenEquip(10,20226,10,5,12);
	me.AddGreenEquip(4,20168,10,5,12);--V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20092,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai12()
	me.AddGreenEquip(10,20227,10,5,12);
	me.AddGreenEquip(4,20169,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20093,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai121()
	me.AddGreenEquip(10,20228,10,5,12);
	me.AddGreenEquip(4,20169,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20093,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi12()
	me.AddGreenEquip(10,20229,10,5,12);
	me.AddGreenEquip(4,20170,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,12); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,12); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20094,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi121()
	me.AddGreenEquip(10,20230,10,5,12);
	me.AddGreenEquip(4,20170,10,5,12); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,12); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,12); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20094,10,5,12); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,12); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,12); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,12); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,12); --V? Uy L?m Nh?t Tinh Huy?n Phù
end
-------------------------------------------------------------------------------
function tbLiGuan:DoCuoi14()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"Do Nam",self.DoNam14,self};
		{"Do Nu",self.DoNu14,self },
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNam14()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim14,self};
		{"He Moc",self.HeMoc14,self};
		{"He Thuy",self.HeThuy14,self};
		{"He Hoa",self.HeHoa14,self};
		{"He Tho",self.HeTho14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNu14()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim141,self};
		{"He Moc",self.HeMoc141,self};
		{"He Thuy",self.HeThuy141,self};
		{"He Hoa",self.HeHoa141,self};
		{"He Tho",self.HeTho141,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim14()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai14,self};
		{"Đồ Nội",self.KimNoi14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim141()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai141,self};
		{"Đồ Nội",self.KimNoi141,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc14()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai14,self};
		{"Đồ Nội",self.MocNoi14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc141()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai141,self};
		{"Đồ Nội",self.MocNoi141,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy14()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai14,self};
		{"Đồ Nội",self.ThuyNoi14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy141()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai141,self};
		{"Đồ Nội",self.ThuyNoi141,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa14()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai14,self};
		{"Đồ Nội",self.HoaNoi14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa141()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai141,self};
		{"Đồ Nội",self.HoaNoi141,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho14()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai14,self};
		{"Đồ Nội",self.ThoNoi14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho141()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai141,self};
		{"Đồ Nội",self.ThoNoi141,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:KimNgoai14()
	me.AddGreenEquip(10,20211,10,5,14); --Th?y Hoàng H?ng Hoang Uy?n
	me.AddGreenEquip(4,20161,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20085,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNgoai141()
	me.AddGreenEquip(10,20212,10,5,14);
	me.AddGreenEquip(4,20161,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20085,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi14()
	me.AddGreenEquip(10,20213,10,5,14);
	me.AddGreenEquip(4,20162,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20086,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi141()
	me.AddGreenEquip(10,20214,10,5,14);
	me.AddGreenEquip(4,20162,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20086,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai14()
	me.AddGreenEquip(10,20215,10,5,14);
	me.AddGreenEquip(4,20163,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20087,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai141()
	me.AddGreenEquip(10,20216,10,5,14);
	me.AddGreenEquip(4,20163,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20087,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi14()
	me.AddGreenEquip(10,20217,10,5,14);
	me.AddGreenEquip(4,20164,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20088,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi141()
	me.AddGreenEquip(10,20218,10,5,14);
	me.AddGreenEquip(4,20164,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20088,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai14()
	me.AddGreenEquip(10,20219,10,5,14);
	me.AddGreenEquip(4,20165,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20089,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai141()
	me.AddGreenEquip(10,20220,10,5,14);
	me.AddGreenEquip(4,20165,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20089,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi14()
	me.AddGreenEquip(10,20221,10,5,14);
	me.AddGreenEquip(4,20166,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20090,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi114()
	me.AddGreenEquip(10,20222,10,5,14);
	me.AddGreenEquip(4,20166,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20090,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai14()
	me.AddGreenEquip(10,20223,10,5,14);
	me.AddGreenEquip(4,20167,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20091,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai141()
	me.AddGreenEquip(10,20224,10,5,14);
	me.AddGreenEquip(4,20167,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20091,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi14()
	me.AddGreenEquip(10,20225,10,5,14);
	me.AddGreenEquip(4,20168,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20092,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi141()
	me.AddGreenEquip(10,20226,10,5,14);
	me.AddGreenEquip(4,20168,10,5,14);--V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20092,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai14()
	me.AddGreenEquip(10,20227,10,5,14);
	me.AddGreenEquip(4,20169,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20093,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai141()
	me.AddGreenEquip(10,20228,10,5,14);
	me.AddGreenEquip(4,20169,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20093,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi14()
	me.AddGreenEquip(10,20229,10,5,14);
	me.AddGreenEquip(4,20170,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,14); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,14); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20094,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi141()
	me.AddGreenEquip(10,20230,10,5,14);
	me.AddGreenEquip(4,20170,10,5,14); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,14); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,14); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20094,10,5,14); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,14); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,14); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,14); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,14); --V? Uy L?m Nh?t Tinh Huy?n Phù
end
-------------------------------------------------------------------------------
function tbLiGuan:DoCuoi16()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"Do Nam",self.DoNam16,self};
		{"Do Nu",self.DoNu16,self },
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNam16()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim16,self};
		{"He Moc",self.HeMoc16,self};
		{"He Thuy",self.HeThuy16,self};
		{"He Hoa",self.HeHoa16,self};
		{"He Tho",self.HeTho16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNu16()
	local szMsg = "Hãy Chọn";
	local tbOpt = {
		{"He Kim",self.HeKim161,self};
		{"He Moc",self.HeMoc161,self};
		{"He Thuy",self.HeThuy161,self};
		{"He Hoa",self.HeHoa161,self};
		{"He Tho",self.HeTho161,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim16()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai16,self};
		{"Đồ Nội",self.KimNoi16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim161()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai161,self};
		{"Đồ Nội",self.KimNoi161,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc16()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai16,self};
		{"Đồ Nội",self.MocNoi16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc161()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai161,self};
		{"Đồ Nội",self.MocNoi161,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy16()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai16,self};
		{"Đồ Nội",self.ThuyNoi16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy161()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai161,self};
		{"Đồ Nội",self.ThuyNoi161,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa16()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai16,self};
		{"Đồ Nội",self.HoaNoi16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa161()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai161,self};
		{"Đồ Nội",self.HoaNoi161,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho16()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai16,self};
		{"Đồ Nội",self.ThoNoi16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho161()
	local szMsg = "Hãy Chọn";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai161,self};
		{"Đồ Nội",self.ThoNoi161,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:KimNgoai16()
	me.AddGreenEquip(10,20211,10,5,16); --Th?y Hoàng H?ng Hoang Uy?n
	me.AddGreenEquip(4,20161,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20085,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNgoai161()
	me.AddGreenEquip(10,20212,10,5,16);
	me.AddGreenEquip(4,20161,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20085,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi16()
	me.AddGreenEquip(10,20213,10,5,16);
	me.AddGreenEquip(4,20162,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20065,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20105,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20086,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,353,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,487,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20045,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:KimNoi161()
	me.AddGreenEquip(10,20214,10,5,16);
	me.AddGreenEquip(4,20162,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20066,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20106,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20086,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,354,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,488,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20050,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai16()
	me.AddGreenEquip(10,20215,10,5,16);
	me.AddGreenEquip(4,20163,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20087,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNgoai161()
	me.AddGreenEquip(10,20216,10,5,16);
	me.AddGreenEquip(4,20163,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20087,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi16()
	me.AddGreenEquip(10,20217,10,5,16);
	me.AddGreenEquip(4,20164,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20067,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20107,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20088,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,373,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,489,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20046,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:MocNoi161()
	me.AddGreenEquip(10,20218,10,5,16);
	me.AddGreenEquip(4,20164,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20068,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20108,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20088,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,374,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,490,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20051,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai16()
	me.AddGreenEquip(10,20219,10,5,16);
	me.AddGreenEquip(4,20165,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20089,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNgoai161()
	me.AddGreenEquip(10,20220,10,5,16);
	me.AddGreenEquip(4,20165,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20089,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi16()
	me.AddGreenEquip(10,20221,10,5,16);
	me.AddGreenEquip(4,20166,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20069,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20109,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20090,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,393,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,491,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20047,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThuyNoi161()
	me.AddGreenEquip(10,20222,10,5,16);
	me.AddGreenEquip(4,20166,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20070,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20110,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20090,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,394,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,492,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20052,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai16()
	me.AddGreenEquip(10,20223,10,5,16);
	me.AddGreenEquip(4,20167,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20091,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNgoai161()
	me.AddGreenEquip(10,20224,10,5,16);
	me.AddGreenEquip(4,20167,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20091,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi16()
	me.AddGreenEquip(10,20225,10,5,16);
	me.AddGreenEquip(4,20168,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20071,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20111,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20092,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,413,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,493,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20048,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:HoaNoi161()
	me.AddGreenEquip(10,20226,10,5,16);
	me.AddGreenEquip(4,20168,10,5,16);--V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20072,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20112,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20092,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,414,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,494,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20053,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai16()
	me.AddGreenEquip(10,20227,10,5,16);
	me.AddGreenEquip(4,20169,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20093,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNgoai161()
	me.AddGreenEquip(10,20228,10,5,16);
	me.AddGreenEquip(4,20169,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20093,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi16()
	me.AddGreenEquip(10,20229,10,5,16);
	me.AddGreenEquip(4,20170,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20073,10,5,16); --Tiêu Dao Bá V??ng Ngoa
	me.AddGreenEquip(11,20113,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
	me.AddGreenEquip(5,20094,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,433,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,495,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20049,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:ThoNoi161()
	me.AddGreenEquip(10,20230,10,5,16);
	me.AddGreenEquip(4,20170,10,5,16); --V? Uy C? Tinh Gi?i
	me.AddGreenEquip(7,20074,10,5,16); --Tiêu Dao Huy?n N? Ngoa
	me.AddGreenEquip(11,20114,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
	me.AddGreenEquip(5,20094,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
	me.AddGreenEquip(8,434,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
	me.AddGreenEquip(9,496,10,5,16); --Tr?c L?c Kinh Van Kh?i
	me.AddGreenEquip(3,20054,10,5,16); --Th?y Hoàng Long Lan Y
	me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
end

function tbLiGuan:TrangBiBaVuong()
	local nSeries = me.nSeries;
	local szMsg = "Hãy chọn lấy bộ trang bị mà bạn nhé ^^ ";
	local tbOpt = {
		{"Set Tinh Thông Của <color=red>Nam<color> Hệ <color=gold>[Kim]<color>",self.NamKim,self},
		{"Set Tinh Thông Của <color=red>Nam<color> Hệ <color=green>[Mộc]<color>",self.NamMoc,self},
		{"Set Tinh Thông Của <color=red>Nam<color> Hệ <color=blue>[Thủy]<color>",self.NamThuy,self},
		{"Set Tinh Thông Của <color=red>Nam<color> Hệ <color=red>[Hỏa]<color>",self.NamHoa,self},
		{"Set Tinh Thông Của <color=red>Nam<color> Hệ <color=wheat>[Thổ]<color>",self.NamTho,self},
		{"Set Tinh Thông Của <color=gold>Nữ<color> Hệ <color=gold>[Kim]<color>",self.NuKim,self},
		{"Set Tinh Thông Của <color=gold>Nữ<color> Hệ <color=green>[Mộc]<color>",self.NuMoc,self},
		{"Set Tinh Thông Của <color=gold>Nữ<color> Hệ <color=blue>[Thủy]<color>",self.NuThuy,self},
		{"Set Tinh Thông Của <color=gold>Nữ<color> Hệ <color=red>[Hỏa]<color>",self.NuHoa,self},
		{"Set Tinh Thông Của <color=gold>Nữ<color> Hệ <color=wheat>[Thổ]<color>",self.NuTho,self},
	}
	Dialog:Say(szMsg,tbOpt);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamKim()
    me.AddItem(4,3,931,10,5,16);
	me.AddItem(4,6,1016,10,3,16);
	me.AddItem(4,4,1036,10,4,16);
	me.AddItem(4,5,950,10,5,16);
	me.AddItem(4,11,1046,10,2,16);
	me.AddItem(4,9,1056,10,1,16);
	me.AddItem(4,7,1066,10,3,16);
	me.AddItem(4,10,1076,10,2,16);
	me.AddItem(4,8,1096,10,4,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamMoc()
	me.AddItem(4,3,933,10,3,16);
	me.AddItem(4,4,1037,10,1,16);
	me.AddItem(4,5,952,10,3,16);
	me.AddItem(4,11,1048,10,5,16);
	me.AddItem(4,6,1017,10,4,16);
	me.AddItem(4,9,1058,10,2,16);
	me.AddItem(4,7,1068,10,4,16);
	me.AddItem(4,10,1080,10,5,16);
	me.AddItem(4,8,1098,10,1,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamThuy()
	me.AddItem(4,3,935,10,1,16);
	me.AddItem(4,4,1038,10,5,16);
	me.AddItem(4,11,1050,10,4,16);
	me.AddItem(4,9,1060,10,3,16);
	me.AddItem(4,7,1070,10,2,16);
	me.AddItem(4,10,1084,10,4,16);
	me.AddItem(4,6,1018,10,2,16);
	me.AddItem(4,8,1100,10,5,16);
	me.AddItem(4,5,954,10,1,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamHoa()
	me.AddItem(4,3,937,10,2,16);
	me.AddItem(4,6,1019,10,5,16);
	me.AddItem(4,4,1039,10,3,16);
	me.AddItem(4,5,956,10,2,16);
	me.AddItem(4,9,1062,10,4,16);
	me.AddItem(4,7,1072,10,5,16);
	me.AddItem(4,10,1088,10,1,16);
	me.AddItem(4,8,1102,10,3,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamTho()
	me.AddItem(4,3,939,10,4,16);
	me.AddItem(4,6,1020,10,1,16);
	me.AddItem(4,4,1040,10,2,16);
	me.AddItem(4,5,958,10,4,16);
	me.AddItem(4,11,1054,10,3,16);
	me.AddItem(4,9,1064,10,5,16);
	me.AddItem(4,7,1074,10,1,16);
	me.AddItem(4,10,1092,10,3,16);
	me.AddItem(4,8,1104,10,2,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuKim()
	me.AddItem(4,3,932,10,5,16);
	me.AddItem(4,4,1036,10,4,16);
	me.AddItem(4,5,950,10,5,16);
	me.AddItem(4,11,1047,10,2,16);
	me.AddItem(4,9,1057,10,1,16);
	me.AddItem(4,7,1067,10,3,16);
	me.AddItem(4,10,1077,10,2,16);
	me.AddItem(4,8,1097,10,4,16);
	me.AddItem(4,6,1016,10,3,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuMoc()
	me.AddItem(4,3,934,10,3,16);
	me.AddItem(4,4,1037,10,1,16);
	me.AddItem(4,5,952,10,3,16);
	me.AddItem(4,11,1049,10,5,16);
	me.AddItem(4,7,1069,10,4,16);
	me.AddItem(4,10,1081,10,5,16);
	me.AddItem(4,8,1099,10,1,16);
	me.AddItem(4,9,1059,10,2,16);
	me.AddItem(4,6,1017,10,4,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuThuy()
	me.AddItem(4,3,936,10,1,16);
	me.AddItem(4,6,1018,10,2,16);
	me.AddItem(4,4,1038,10,5,16);
	me.AddItem(4,5,954,10,1,16);
	me.AddItem(4,11,1051,10,4,16);
	me.AddItem(4,9,1061,10,3,16);
	me.AddItem(4,7,1071,10,2,16);
	me.AddItem(4,10,1085,10,4,16);
	me.AddItem(4,8,1101,10,5,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuHoa()
	me.AddItem(4,3,938,10,2,16);
	me.AddItem(4,6,1019,10,5,16);
	me.AddItem(4,4,1039,10,3,16);
	me.AddItem(4,5,956,10,2,16);
	me.AddItem(4,11,1053,10,1,16);
	me.AddItem(4,9,1063,10,4,16);
	me.AddItem(4,7,1073,10,5,16);
	me.AddItem(4,10,1089,10,1,16);
	me.AddItem(4,8,1103,10,3,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuTho()
	me.AddItem(4,3,940,10,4,16);
	me.AddItem(4,6,1020,10,1,16);
	me.AddItem(4,4,1040,10,2,16);
	me.AddItem(4,5,958,10,4,16);
	me.AddItem(4,11,1055,10,3,16);
	me.AddItem(4,9,1065,10,5,16);
	me.AddItem(4,7,1075,10,1,16);
	me.AddItem(4,10,1093,10,3,16);
	me.AddItem(4,8,1105,10,2,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:TrangBiSatThan()
 local nSeries = me.nSeries;
 local szMsg = "Hãy chọn lấy bộ trang bị 18x <color=red>Hoàn Mĩ<color> mà bạn cần nhé ^^";
 local tbOpt = {
  {"Set <color=red>Hoàn Mĩ<color> Của <color=red>Nam<color> Hệ <color=gold>[Kim]<color>",self.NamKim1,self},
  {"Set <color=red>Hoàn Mĩ<color> Của <color=red>Nam<color> Hệ <color=green>[Mộc]<color>",self.NamMoc1,self},
  {"Set <color=red>Hoàn Mĩ<color> Của <color=red>Nam<color> Hệ <color=blue>[Thủy]<color>",self.NamThuy1,self},
  {"Set <color=red>Hoàn Mĩ<color> Của <color=red>Nam<color> Hệ <color=red>[Hỏa]<color>",self.NamHoa1,self},
  {"Set <color=red>Hoàn Mĩ<color> Của <color=red>Nam<color> Hệ <color=wheat>[Thổ]<color>",self.NamTho1,self},
  {"Set <color=red>Hoàn Mĩ<color> Của <color=gold>Nữ<color> Hệ <color=gold>[Kim]<color>",self.NuKim1,self},
  {"Set <color=red>Hoàn Mĩ<color> Của <color=gold>Nữ<color> Hệ <color=green>[Mộc]            <color>",self.NuMoc1,self},
  {"Set <color=red>Hoàn Mĩ<color> Của <color=gold>Nữ<color> Hệ <color=blue>[Thủy]            <color>",self.NuThuy1,self},
  {"Set <color=red>Hoàn Mĩ<color> Của <color=gold>Nữ<color> Hệ <color=red>[Hỏa]<color>",self.NuHoa1,self},
  {"Set <color=red>Hoàn Mĩ<color> Của <color=gold>Nữ<color> Hệ <color=wheat>[Thổ]            <color>",self.NuTho1,self},
   }
 Dialog:Say(szMsg,tbOpt);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamKim1()
	me.AddItem(4,3,1800,10,5,16);
	me.AddItem(4,6,1810,10,3,16);
	me.AddItem(4,4,1815,10,4,16);
	me.AddItem(4,5,1831,10,3,16);
	me.AddItem(4,11,1835,10,2,16);
	me.AddItem(4,9,1845,10,1,16);
	me.AddItem(4,7,1855,10,3,16);
	me.AddItem(4,10,1865,10,2,16);
	me.AddItem(4,8,1886,10,4,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamMoc1()
	me.AddItem(4,3,1801,10,3,16);
	me.AddItem(4,6,1811,10,4,16);
	me.AddItem(4,4,1816,10,1,16);
	me.AddItem(4,5,1834,10,4,16);
	me.AddItem(4,11,1836,10,5,16);
	me.AddItem(4,9,1846,10,2,16);
	me.AddItem(4,7,1856,10,4,16);
	me.AddItem(4,10,1867,10,5,16);
	me.AddItem(4,8,1887,10,1,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamThuy1()
	me.AddItem(4,3,1802,10,1,16);
	me.AddItem(4,6,1812,10,2,16);
	me.AddItem(4,4,1817,10,5,16);
	me.AddItem(4,5,1833,10,2,16);
	me.AddItem(4,11,1837,10,4,16);
	me.AddItem(4,9,1847,10,3,16);
	me.AddItem(4,7,1857,10,2,16);
	me.AddItem(4,10,1869,10,4,16);
	me.AddItem(4,8,1888,10,5,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamHoa1() 
	me.AddItem(4,3,1803,10,2,16);
	me.AddItem(4,6,1813,10,5,16);
	me.AddItem(4,4,1818,10,3,16);
	me.AddItem(4,5,1830,10,5,16);
	me.AddItem(4,11,1838,10,1,16);
	me.AddItem(4,9,1848,10,4,16);
	me.AddItem(4,7,1858,10,5,16);
	me.AddItem(4,10,1872,10,2,16);
	me.AddItem(4,8,1889,10,3,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NamTho1()
	me.AddItem(4,3,1804,10,4,16);
	me.AddItem(4,6,1814,10,1,16);
	me.AddItem(4,4,1819,10,2,16);
	me.AddItem(4,5,1832,10,1,16);
	me.AddItem(4,11,1839,10,3,16);
	me.AddItem(4,9,1849,10,5,16);
	me.AddItem(4,7,1859,10,1,16);
	me.AddItem(4,10,1874,10,3,16);
	me.AddItem(4,8,1890,10,2,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuKim1()
	me.AddItem(4,3,1805,10,5,16);
	me.AddItem(4,6,1810,10,3,16);
	me.AddItem(4,4,1815,10,4,16);
	me.AddItem(4,5,1831,10,3,16);
	me.AddItem(4,11,1840,10,2,16);
	me.AddItem(4,9,1850,10,1,16);
	me.AddItem(4,7,1860,10,3,16);
	me.AddItem(4,10,1876,10,2,16);
	me.AddItem(4,8,1891,10,4,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuMoc1()
	me.AddItem(4,3,1806,10,3,16);
	me.AddItem(4,6,1811,10,4,16);
	me.AddItem(4,4,1816,10,1,16);
	me.AddItem(4,5,1834,10,4,16);
	me.AddItem(4,11,1841,10,5,16);
	me.AddItem(4,9,1851,10,2,16);
	me.AddItem(4,7,1861,10,4,16);
	me.AddItem(4,10,1878,10,5,16);
	me.AddItem(4,8,1892,10,1,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuThuy1()
	me.AddItem(4,3,1807,10,1,16);
	me.AddItem(4,6,1812,10,2,16);
	me.AddItem(4,4,1817,10,5,16);
	me.AddItem(4,5,1833,10,2,16);
	me.AddItem(4,11,1842,10,4,16);
	me.AddItem(4,9,1852,10,3,16);
	me.AddItem(4,7,1862,10,2,16);
	me.AddItem(4,10,1880,10,4,16);
	me.AddItem(4,8,1893,10,5,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuHoa1()
	me.AddItem(4,3,1808,10,2,16);
	me.AddItem(4,6,1813,10,5,16);
	me.AddItem(4,4,1818,10,3,16);
	me.AddItem(4,5,1830,10,5,16);
	me.AddItem(4,11,1843,10,1,16);
	me.AddItem(4,9,1853,10,4,16);
	me.AddItem(4,7,1863,10,5,16);
	me.AddItem(4,10,1882,10,1,16);
	me.AddItem(4,8,1894,10,3,16);
end
--------------------------------------------------------------------------------
function tbLiGuan:NuTho1()
	me.AddItem(4,3,1809,10,4,16);
	me.AddItem(4,6,1814,10,1,16);
	me.AddItem(4,4,1819,10,2,16);
	me.AddItem(4,5,1832,10,1,16);
	me.AddItem(4,11,1844,10,3,16);
	me.AddItem(4,9,1854,10,5,16);
	me.AddItem(4,7,1864,10,1,16);
	me.AddItem(4,10,1884,10,3,16);
	me.AddItem(4,8,1895,10,2,16);
end

function tbLiGuan:TrangBiDongHanh()
 local nSeries = me.nSeries;
 local szMsg = "Chào mừng bạn đến  ";
 local tbOpt = {
    {"Nhận <color=Turquoise>Bộ Cấp 1<color>",self.itempet1,self},
	{"Nhận <color=Turquoise>Bộ Cấp 2<color>",self.itempet2,self},
	{"Nhận <color=Turquoise>Bộ Cấp 3<color>",self.itempet3,self},
	{"Nhận <color=Turquoise>Bộ Cấp 4<color>",self.itempet4,self},
    }
 Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:itempet1()
	me.AddItem(5,23,1,1);
	me.AddItem(5,22,1,1);
	me.AddItem(5,21,1,1);
	me.AddItem(5,20,1,1);
	me.AddItem(5,19,1,1);
end

function tbLiGuan:itempet2()
	me.AddItem(5,23,1,2);
	me.AddItem(5,22,1,2);
	me.AddItem(5,21,1,2);
	me.AddItem(5,20,1,2);
	me.AddItem(5,19,1,2);
end

function tbLiGuan:itempet3()
	me.AddItem(5,23,1,3);
	me.AddItem(5,22,1,3);
	me.AddItem(5,21,1,3);
	me.AddItem(5,20,1,3);
	me.AddItem(5,19,1,3);
end
function tbLiGuan:itempet4()
	me.AddItem(5,23,1,4);
	me.AddItem(5,22,1,4);
	me.AddItem(5,21,1,4);
	me.AddItem(5,20,1,4);
	me.AddItem(5,19,1,4);
end
function tbLiGuan:itempet5()
	me.AddItem(5,23,1,5);
	me.AddItem(5,22,1,5);
	me.AddItem(5,21,1,5);
	me.AddItem(5,20,1,5);
	me.AddItem(5,19,1,5);
end
function tbLiGuan:itempet6()
	me.AddItem(5,23,1,13);
	me.AddItem(5,22,1,13);
	me.AddItem(5,21,1,13);
	me.AddItem(5,20,1,13);
	me.AddItem(5,19,1,13);
end
---------------------------------------------------------------------------------------------------------------------------------------