local tbSuKienKiemThe = Npc:GetClass("sukienkiemthe1");
function tbSuKienKiemThe:OnDialog()
local tbOpt = 
	{	
   		{"Kết thúc đối thoại"}
	}
	table.insert(tbOpt, 1, {"<pic=135> Nâng Cấp <color=blue>Kinh Mạch<color>", self.NangKinhMach, self});
    table.insert(tbOpt, 1, {"<pic=135> Nâng Cấp <color=green>Già Lam Kinh<color>", self.glk, self});
    table.insert(tbOpt, 1, {"<pic=135> Nâng Cấp <color=green>Trận Pháp - Bát Quái Trận<color>", self.tranphap, self});	
	table.insert(tbOpt, 1, {"<pic=135> Nâng Cấp <color=gold>Trang Bị Đồng Hành<color>", self.LHTBDH, self});
	table.insert(tbOpt, 1, {"<pic=135> Nâng Cấp <color=yellow>Ngựa<color>", self.ngua, self});
	table.insert(tbOpt, 1, {"<pic=135> Nâng Cấp <color=yellow>Mặt Nạ<color>", self.matna, self});
    table.insert(tbOpt, 1, {"<pic=135> Nâng Cấp <color=yellow>Ấn <color>", self.an, self});
	table.insert(tbOpt, 1, {"<pic=135> Ghép <color=red>Tinh Thạch Ngoại Trang<color>", self.changeStone, self});

	
	Dialog:Say("Xin chọn mục cần nâng cấp:",tbOpt);
end


function tbSuKienKiemThe:NangKinhMach()
	 local tbNpc = Npc:GetClass("NangKinhMach");
	 tbNpc:OnDialog_1();
end;

function tbSuKienKiemThe:changestone2()
	 local tbNpc = Npc:GetClass("changestone2");
	 tbNpc:OnDialog_1();
end;

function tbSuKienKiemThe:changestone3()
	 local tbNpc = Npc:GetClass("changestone3");
	 tbNpc:OnDialog_1();
end;

function tbSuKienKiemThe:changestone4()
	 local tbNpc = Npc:GetClass("changestone4");
	 tbNpc:OnDialog_1();
end;


--------------------------tinh thach---------------------------
function tbSuKienKiemThe:changeStone()
	local szMsg = "Tính năng đổi tinh thạnh luyện hoá ngoại trang";
	local tbOpt = {
		{"<color=green>Tinh Thạch Ảnh Nguyệt (cấp 2)<color>", self.changestone2, self},
		{"<color=blue>Tinh Thạch Đoạn Hải (cấp 3)<color>", self.changestone3, self},
		{"<color=red>Tinh Thạch Thánh Hỏa (cấp 4)<color>", self.changestone4, self},
		{"Kết Thúc Đối Thoại."},
		};
		Dialog:Say(szMsg, tbOpt);
		end
-------------------------------pet-------------------------------------
function tbSuKienKiemThe:LHTBDH()
	local szMsg = "Để <color=red>Trang bị đồng hành<color> + Mảnh Ghép Trang Bị Đồng Hành trong Rương";
	local tbOpt = {
		{"<color=gold>Trang Bị Đồng Hành Cấp 1<color> ", self.TBDHC2, self},
		{"<color=gold>Trang Bị Đồng Hành Cấp 2<color> ", self.TBDHC3, self},
		{"<color=gold>Trang Bị Đồng Hành Cấp 3<color> ", self.TBDHC4, self},
		{"<color=gold>Trang Bị Đồng Hành Cấp 4<color> ", self.TBDHC5, self},
		{"<color=gold>Trang Bị Đồng Hành Cấp 5<color> ", self.TBDHC6, self},
		{"<color=gold>Trang Bị Đồng Hành Cấp 6<color> ", self.TBDHC7, self},
		{"<color=gold>Trang Bị Đồng Hành Cấp 7<color> ", self.TBDHC8, self},
		{"<color=gold>Trang Bị Đồng Hành Cấp 8<color> ", self.TBDHC9, self},
		{"<color=gold>Trang Bị Đồng Hành Cấp 9<color> ", self.TBDHC10, self},
		{"<color=gold>Trang Bị Đồng Hành Cấp 10<color> ", self.TBDHC11, self},		
		{"Kết Thúc Đối Thoại."},
		};
		Dialog:Say(szMsg, tbOpt);
		end
---------------------------------------bat dau-------------------------------
function tbSuKienKiemThe:TBDHC2()
	local szMsg = " Nâng Cấp <color=red>TB Đồng Hành +1<color> = <color=red>TB Đồng Hành<color> + 200 Mảnh Ghép ĐH ";
	local tbOpt = {
		{"<color=gold>Vũ Khí Đồng Hành +1<color>", self.vkdhc2, self},
		{"<color=gold>Áo Đồng Hành +1<color>", self.aodhc2, self},
		{"<color=gold>Nhẫn Đồng Hành +1<color>", self.nhandhc2, self},
		{"<color=gold>Tay Đồng Hành +1<color>", self.taydhc2, self},
		{"<color=gold>Phù Đồng Hành +1<color>", self.boidhc2, self},
		{"Kết Thúc Đối Thoại."},
		};
		Dialog:Say(szMsg, tbOpt);
		end

function tbSuKienKiemThe:vkdhc2()
	local tbItemId1 = {18,1,2004,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,19,1,10,0,0}; -- vk1
	local nCount1 = me.GetItemCountInBags(18,1,2004,1);
	local nCount2 = me.GetItemCountInBags(5,19,1,10);
	if nCount1 >= 200 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,19,2,10);
		 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Vũ Khí Đồng Hành +1<color> ");
		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Vũ Khí Đồng Hành +1<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Vũ Khí Đồng Hành<color> và 200 MG VK Đồng Hành hãy đến tìm ta . ")
		
		 
	end
end

function tbSuKienKiemThe:aodhc2()
	local tbItemId1 = {18,1,2005,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,20,1,10,0,0}; -- ao1
	local nCount1 = me.GetItemCountInBags(18,1,2005,1);
	local nCount2 = me.GetItemCountInBags(5,20,1,10);
if nCount1 >= 200 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,20,2,10);
		 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Áo Đồng Hành +1<color> ");
		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Áo Đồng Hành +1<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Áo Đồng Hành<color> và 200 MG Áo Đồng Hành hãy đến tìm ta . ");
	end
end

function tbSuKienKiemThe:nhandhc2()
	local tbItemId1 = {18,1,2006,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,21,1,10,0,0}; -- nhan1
	local nCount1 = me.GetItemCountInBags(18,1,2006,1);
	local nCount2 = me.GetItemCountInBags(5,21,1,10);
	if nCount1 >= 200 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,21,2,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Nhẫn Đồng Hành +1<color> ");
			 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Nhẫn Đồng Hành +1<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Nhẫn Đồng Hành<color> và 200 MG Nhẫn Đồng Hành hãy đến tìm ta . ");
	end
end
function tbSuKienKiemThe:taydhc2()
	local tbItemId1 = {18,1,2007,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,22,1,10,0,0}; -- tay1
	local nCount1 = me.GetItemCountInBags(18,1,2007,1);
	local nCount2 = me.GetItemCountInBags(5,22,1,10);
	if nCount1 >= 200 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,22,2,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Tay Đồng Hành +1<color> ");
			 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Tay Đồng Hành +1<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Tay Đồng Hành<color> và 200 MG Tay Đồng Hành hãy đến tìm ta . ");
	end
end
function tbSuKienKiemThe:boidhc2()
	local tbItemId1 = {18,1,2008,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,23,1,10,0,0}; -- phu1
	local nCount1 = me.GetItemCountInBags(18,1,2008,1);
	local nCount2 = me.GetItemCountInBags(5,23,1,10);
	if nCount1 >= 200 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,23,2,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Phù Đồng Hành +1<color> ");
			 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Phù Đồng Hành +1<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Phù Đồng Hành Cấp 1<color> và 200 MG Phù Đồng Hành hãy đến tìm ta . ");
	end
end	
		-----------------------------------------------------
function tbSuKienKiemThe:TBDHC3()
	local szMsg = " Nâng Cấp <color=red>TB Đồng Hành +2<color> = <color=red>TB Đồng Hành +1<color> + 400 Mảnh Ghép ĐH ";
	local tbOpt = {
		{"<color=gold>Vũ Khí Đồng Hành +2<color>", self.vkdhc3, self},
		{"<color=gold>Áo Đồng Hành +2<color>", self.aodhc3, self},
		{"<color=gold>Nhẫn Đồng Hành +2<color>", self.nhandhc3, self},
		{"<color=gold>Tay Đồng Hành +2<color>", self.taydhc3, self},
		{"<color=gold>Phù Đồng Hành +2<color>", self.boidhc3, self},
		};
		Dialog:Say(szMsg, tbOpt);
		end	
function tbSuKienKiemThe:vkdhc3()
	local tbItemId1 = {18,1,2004,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,19,2,10,0,0}; -- vk1
	local nCount1 = me.GetItemCountInBags(18,1,2004,1);
	local nCount2 = me.GetItemCountInBags(5,19,2,10);
	if nCount1 >= 400 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 400);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,19,3,10);
		 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Vũ Khí Đồng Hành +2<color> ");
		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Vũ Khí Đồng Hành +2<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Vũ Khí Đồng Hành +1<color> và 400 MG VK Đồng Hành hãy đến tìm ta . ")
		
		 
	end
end

function tbSuKienKiemThe:aodhc3()
	local tbItemId1 = {18,1,2005,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,20,2,10,0,0}; -- ao1
	local nCount1 = me.GetItemCountInBags(18,1,2005,1);
	local nCount2 = me.GetItemCountInBags(5,20,2,10);
if nCount1 >= 400 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 400);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,20,3,10);
		 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Áo Đồng Hành +2<color> ");
		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Áo Đồng Hành +2<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Áo Đồng Hành +1<color> và 400 MG Áo Đồng Hành hãy đến tìm ta . ");
	end
end

function tbSuKienKiemThe:nhandhc3()
	local tbItemId1 = {18,1,2006,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,21,2,10,0,0}; -- nhan1
	local nCount1 = me.GetItemCountInBags(18,1,2006,1);
	local nCount2 = me.GetItemCountInBags(5,21,2,10);
	if nCount1 >= 400 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 400);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,21,3,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Nhẫn Đồng Hành +2<color> ");
			 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Nhẫn Đồng Hành +2<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	KDialog.MsgToGlobal(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Nhẫn Đồng Hành +1<color> và 400 MG Nhẫn Đồng Hành hãy đến tìm ta . ");
	end
end
function tbSuKienKiemThe:taydhc3()
	local tbItemId1 = {18,1,2007,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,22,2,10,0,0}; -- tay1
	local nCount1 = me.GetItemCountInBags(18,1,2007,1);
	local nCount2 = me.GetItemCountInBags(5,22,2,10);
	if nCount1 >= 400 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 400);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,22,3,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Tay Đồng Hành +2<color> ");
			 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Tay Đồng Hành +2<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Tay Đồng Hành +1<color> và 400 MG Tay Đồng Hành hãy đến tìm ta . ");
	end
end
function tbSuKienKiemThe:boidhc3()
	local tbItemId1 = {18,1,2008,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,23,2,10,0,0}; -- phu1
	local nCount1 = me.GetItemCountInBags(18,1,2008,1);
	local nCount2 = me.GetItemCountInBags(5,23,2,10);
	if nCount1 >= 400 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 400);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,23,3,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Phù Đồng Hành +2<color> ");
			  local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Phù Đồng Hành +2<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Phù Đồng Hành +1<color> và 400 MG Phù Đồng Hành hãy đến tìm ta . ");
	end
end			
---------------------------------------------
function tbSuKienKiemThe:TBDHC4()
	local szMsg = " Nâng Cấp <color=red>TB Đồng Hành +3<color> = <color=red>TB Đồng Hành +2<color> + 600 Mảnh Ghép ĐH ";
	local tbOpt = {
		{"<color=gold>Vũ Khí Đồng Hành +3<color>", self.vkdhc4, self},
		{"<color=gold>Áo Đồng Hành +3<color>", self.aodhc4, self},
		{"<color=gold>Nhẫn Đồng Hành +3<color>", self.nhandhc4, self},
		{"<color=gold>Tay Đồng Hành +3<color>", self.taydhc4, self},
		{"<color=gold>Phù Đồng Hành +3<color>", self.boidhc4, self},
		{"Kết Thúc Đối Thoại."},
		};
		Dialog:Say(szMsg, tbOpt);
		end	
function tbSuKienKiemThe:vkdhc4()
	local tbItemId1 = {18,1,2004,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,19,3,10,0,0}; -- vk1
	local nCount1 = me.GetItemCountInBags(18,1,2004,1);
	local nCount2 = me.GetItemCountInBags(5,19,3,10);
	if nCount1 >= 600 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 600);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,19,4,10);
		 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Vũ Khí Đồng Hành +3<color> ");
		  local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Vũ Khí Đồng Hành +3<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Vũ Khí Đồng Hành +2<color> và 600 MG VK Đồng Hành hãy đến tìm ta . ")
		
		 
	end
end

function tbSuKienKiemThe:aodhc4()
	local tbItemId1 = {18,1,2005,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,20,3,10,0,0}; -- ao1
	local nCount1 = me.GetItemCountInBags(18,1,2005,1);
	local nCount2 = me.GetItemCountInBags(5,20,3,10);
if nCount1 >= 600 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 600);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,20,4,10);
		 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Áo Đồng Hành +3<color> ");
		  local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Áo Đồng Hành +3<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Áo Đồng Hành +2<color> và 600 MG Áo Đồng Hành hãy đến tìm ta . ");
	end
end

function tbSuKienKiemThe:nhandhc4()
	local tbItemId1 = {18,1,2006,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,21,3,10,0,0}; -- nhan1
	local nCount1 = me.GetItemCountInBags(18,1,2006,1);
	local nCount2 = me.GetItemCountInBags(5,21,3,10);
	if nCount1 >= 600 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 600);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,21,4,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Nhẫn Đồng Hành +3<color> ");
			  local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Nhẫn Đồng Hành +3<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Nhẫn Đồng Hành +2<color> và 600 MG Nhẫn Đồng Hành hãy đến tìm ta . ");
	end
end
function tbSuKienKiemThe:taydhc4()
	local tbItemId1 = {18,1,2007,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,22,3,10,0,0}; -- tay1
	local nCount1 = me.GetItemCountInBags(18,1,2007,1);
	local nCount2 = me.GetItemCountInBags(5,22,3,10);
	if nCount1 >= 600 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 600);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,22,4,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Tay Đồng Hành +3<color> ");
			  local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Tay Đồng Hành +3<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	KDialog.MsgToGlobal(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Tay Đồng Hành +2<color> và 600 MG Tay Đồng Hành hãy đến tìm ta . ");
	end
end
function tbSuKienKiemThe:boidhc4()
	local tbItemId1 = {18,1,2008,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,23,3,10,0,0}; -- phu1
	local nCount1 = me.GetItemCountInBags(18,1,2008,1);
	local nCount2 = me.GetItemCountInBags(5,23,3,10);
	if nCount1 >= 600 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 600);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,23,4,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Phù Đồng Hành +3<color> ");
 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Phù Đồng Hành +3<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Phù Đồng Hành +2<color> và 600 MG Phù Đồng Hành hãy đến tìm ta . ");
	end
end	
		-----------------------------------------------------------
function tbSuKienKiemThe:TBDHC5()
	local szMsg = " Nâng Cấp <color=red>TB Đồng Hành +4<color> = <color=red>TB Đồng Hành +3<color> + 800 Mảnh Ghép ĐH ";
	local tbOpt = {
		{"<color=gold>Vũ Khí Đồng Hành +4<color>", self.vkdhc5, self},
		{"<color=gold>Áo Đồng Hành +4<color>", self.aodhc5, self},
		{"<color=gold>Nhẫn Đồng Hành +4<color>", self.nhandhc5, self},
		{"<color=gold>Tay Đồng Hành +4<color>", self.taydhc5, self},
		{"<color=gold>Phù Đồng Hành +4<color>", self.boidhc5, self},
		{"Kết Thúc Đối Thoại."},
		};
		Dialog:Say(szMsg, tbOpt);
		end	
function tbSuKienKiemThe:vkdhc5()
	local tbItemId1 = {18,1,2004,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,19,4,10,0,0}; -- vk1
	local nCount1 = me.GetItemCountInBags(18,1,2004,1);
	local nCount2 = me.GetItemCountInBags(5,19,4,10);
	if nCount1 >= 800 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 800);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,19,5,10);
		 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Vũ Khí Đồng Hành +4<color> ");
local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Vũ Khí Đồng Hành +4<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Vũ Khí Đồng Hành +3<color> và 800 MG VK Đồng Hành hãy đến tìm ta . ")
		
		 
	end
end

function tbSuKienKiemThe:aodhc5()
	local tbItemId1 = {18,1,2005,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,20,4,10,0,0}; -- ao1
	local nCount1 = me.GetItemCountInBags(18,1,2005,1);
	local nCount2 = me.GetItemCountInBags(5,20,4,10);
if nCount1 >= 800 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 800);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,20,5,10);
		 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Áo Đồng Hành +4<color> ");
local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Áo Đồng Hành +4<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Áo Đồng Hành +3<color> và 800 MG Áo Đồng Hành hãy đến tìm ta . ");
	end
end

function tbSuKienKiemThe:nhandhc5()
	local tbItemId1 = {18,1,2006,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,21,4,10,0,0}; -- nhan1
	local nCount1 = me.GetItemCountInBags(18,1,2006,1);
	local nCount2 = me.GetItemCountInBags(5,21,4,10);
	if nCount1 >= 800 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 800);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,21,5,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Nhẫn Đồng Hành +4<color> ");
local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Nhẫn Đồng Hành +4<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Nhẫn Đồng Hành +3<color> và 800 MG Nhẫn Đồng Hành hãy đến tìm ta . ");
	end
end
function tbSuKienKiemThe:taydhc5()
	local tbItemId1 = {18,1,2007,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,22,4,10,0,0}; -- tay1
	local nCount1 = me.GetItemCountInBags(18,1,2007,1);
	local nCount2 = me.GetItemCountInBags(5,22,4,10);
	if nCount1 >= 800 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 800);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,22,5,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Tay Đồng Hành +4<color> ");
local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Tay Đồng Hành +4<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Tay Đồng Hành +3<color> và 800 MG Tay Đồng Hành hãy đến tìm ta . ");
	end
end
function tbSuKienKiemThe:boidhc5()
	local tbItemId1 = {18,1,2008,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,23,4,10,0,0}; -- phu1
	local nCount1 = me.GetItemCountInBags(18,1,2008,1);
	local nCount2 = me.GetItemCountInBags(5,23,4,10);
	if nCount1 >= 800 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 800);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,23,5,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Phù Đồng Hành +4<color> ");
local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Phù Đồng Hành +4<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Phù Đồng Hành +3<color> và 800 MG Phù Đồng Hành hãy đến tìm ta . ");
	end
end	
		--------------------------------------------------
function tbSuKienKiemThe:TBDHC6()
	local szMsg = " Nâng Cấp <color=red>TB Đồng Hành +5<color> = <color=red>TB Đồng Hành +4<color> + 1000 Mảnh Ghép ĐH ";
	local tbOpt = {
		{"<color=gold>Vũ Khí Đồng Hành +5<color>", self.vkdhc6, self},
		{"<color=gold>Áo Đồng Hành +5<color>", self.aodhc6, self},
		{"<color=gold>Nhẫn Đồng Hành +5<color>", self.nhandhc6, self},
		{"<color=gold>Tay Đồng Hành +5<color>", self.taydhc6, self},
		{"<color=gold>Phù Đồng Hành +5<color>", self.boidhc6, self},
		{"Kết Thúc Đối Thoại."},
		};
		Dialog:Say(szMsg, tbOpt);
		end	
function tbSuKienKiemThe:vkdhc6()
	local tbItemId1 = {18,1,2004,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,19,5,10,0,0}; -- vk1
	local nCount1 = me.GetItemCountInBags(18,1,2004,1);
	local nCount2 = me.GetItemCountInBags(5,19,5,10);
	if nCount1 >= 1000 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 1000);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,19,6,10);
		 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Vũ Khí Đồng Hành +5<color> ");
		 			 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Vũ Khí Đồng Hành +5<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Vũ Khí Đồng Hành +4<color> và 1000 MG VK Đồng Hành hãy đến tìm ta . ")
		
		 
	end
end

function tbSuKienKiemThe:aodhc6()
	local tbItemId1 = {18,1,2005,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,20,5,10,0,0}; -- ao1
	local nCount1 = me.GetItemCountInBags(18,1,2005,1);
	local nCount2 = me.GetItemCountInBags(5,20,5,10);
if nCount1 >= 1000 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 1000);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,20,6,10);
		 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Áo Đồng Hành +5<color> ");
		 			 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Áo Đồng Hành +5<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Áo Đồng Hành +4<color> và 1000 MG Áo Đồng Hành hãy đến tìm ta . ");
	end
end

function tbSuKienKiemThe:nhandhc6()
	local tbItemId1 = {18,1,2006,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,21,5,10,0,0}; -- nhan1
	local nCount1 = me.GetItemCountInBags(18,1,2006,1);
	local nCount2 = me.GetItemCountInBags(5,21,5,10);
	if nCount1 >= 1000 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 1000);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,21,6,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Nhẫn Đồng Hành +5<color> ");
			 			 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Nhẫn Đồng Hành +5<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Nhẫn Đồng Hành +4<color> và 1000 MG Nhẫn Đồng Hành hãy đến tìm ta . ");
	end
end
function tbSuKienKiemThe:taydhc6()
	local tbItemId1 = {18,1,2007,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,22,5,10,0,0}; -- tay1
	local nCount1 = me.GetItemCountInBags(18,1,2007,1);
	local nCount2 = me.GetItemCountInBags(5,22,5,10);
	if nCount1 >= 1000 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 1000);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,22,6,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Tay Đồng Hành +5<color> ");
			 			 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Tay Đồng Hành +5<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Tay Đồng Hành +4<color> và 1000 MG Tay Đồng Hành hãy đến tìm ta . ");
	end
end
function tbSuKienKiemThe:boidhc6()
	local tbItemId1 = {18,1,2008,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,23,5,10,0,0}; -- phu1
	local nCount1 = me.GetItemCountInBags(18,1,2008,1);
	local nCount2 = me.GetItemCountInBags(5,23,5,10);
	if nCount1 >= 1000 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 1000);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,23,6,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Phù Đồng Hành +5<color> ");
			 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Phù Đồng Hành +5<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Phù Đồng Hành +4<color> và 1000 MG Phù Đồng Hành hãy đến tìm ta . ");
	end
end	

		--------------------------------------------------
function tbSuKienKiemThe:TBDHC7()
	local szMsg = " Nâng Cấp <color=red>TB Đồng Hành +6<color> = <color=red>TB Đồng Hành +5<color> + 1300 Mảnh Ghép ĐH ";
	local tbOpt = {
		{"<color=gold>Vũ Khí Đồng Hành +6<color>", self.vkdhc7, self},
		{"<color=gold>Áo Đồng Hành +6<color>", self.aodhc7, self},
		{"<color=gold>Nhẫn Đồng Hành +6<color>", self.nhandhc7, self},
		{"<color=gold>Tay Đồng Hành +6<color>", self.taydhc7, self},
		{"<color=gold>Phù Đồng Hành +6<color>", self.boidhc7, self},
		{"Kết Thúc Đối Thoại."},
		};
		Dialog:Say(szMsg, tbOpt);
		end	
function tbSuKienKiemThe:vkdhc7()
	local tbItemId1 = {18,1,2004,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,19,6,10,0,0}; -- vk1
	local nCount1 = me.GetItemCountInBags(18,1,2004,1);
	local nCount2 = me.GetItemCountInBags(5,19,6,10);
	if nCount1 >= 1300 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 1300);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,19,7,10);
		 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Vũ Khí Đồng Hành +6<color> ");
		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Vũ Khí Đồng Hành +6<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Vũ Khí Đồng Hành +5<color> và 1300 MG VK Đồng Hành hãy đến tìm ta . ")
		
		 
	end
end

function tbSuKienKiemThe:aodhc7()
	local tbItemId1 = {18,1,2005,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,20,6,10,0,0}; -- ao1
	local nCount1 = me.GetItemCountInBags(18,1,2005,1);
	local nCount2 = me.GetItemCountInBags(5,20,6,10);
if nCount1 >= 1300 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 1300);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,20,7,10);
		 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Áo Đồng Hành +6<color> ");
		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Áo Đồng Hành +6<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Áo Đồng Hành +5<color> và 1300 MG Áo Đồng Hành hãy đến tìm ta . ");
	end
end

function tbSuKienKiemThe:nhandhc7()
	local tbItemId1 = {18,1,2006,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,21,6,10,0,0}; -- nhan1
	local nCount1 = me.GetItemCountInBags(18,1,2006,1);
	local nCount2 = me.GetItemCountInBags(5,21,6,10);
	if nCount1 >= 1300 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 1300);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,21,7,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Nhẫn Đồng Hành +6<color> ");
			 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Nhẫn Đồng Hành +6<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Nhẫn Đồng Hành +5<color> và 1300 MG Nhẫn Đồng Hành hãy đến tìm ta . ");
	end
end
function tbSuKienKiemThe:taydhc7()
	local tbItemId1 = {18,1,2007,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,22,6,10,0,0}; -- tay1
	local nCount1 = me.GetItemCountInBags(18,1,2007,1);
	local nCount2 = me.GetItemCountInBags(5,22,6,10);
	if nCount1 >= 1300 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 1300);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,22,7,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Tay Đồng Hành +6<color> ");
			 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Tay Đồng Hành +6<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Tay Đồng Hành +5<color> và 1300 MG Tay Đồng Hành hãy đến tìm ta . ");
	end
end
function tbSuKienKiemThe:boidhc7()
	local tbItemId1 = {18,1,2008,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,23,6,10,0,0}; -- phu1
	local nCount1 = me.GetItemCountInBags(18,1,2008,1);
	local nCount2 = me.GetItemCountInBags(5,23,6,10);
	if nCount1 >= 1300 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 1300);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,23,7,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Phù Đồng Hành +6<color> ");
local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Phù Đồng Hành +6<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Phù Đồng Hành +5<color> và 1300 MG Phù Đồng Hành hãy đến tìm ta . ");
	end
end	
		-----------------------------------------------
function tbSuKienKiemThe:TBDHC8()
local szMsg = " Nâng Cấp <color=red>TB Đồng Hành +7<color> = <color=red>TB Đồng Hành +6<color> + 1600 Mảnh Ghép ĐH ";
	local tbOpt = {
		{"<color=gold>Vũ Khí Đồng Hành +7<color>", self.vkdhc8, self},
		{"<color=gold>Áo Đồng Hành +7<color>", self.aodhc8, self},
		{"<color=gold>Nhẫn Đồng Hành +7<color>", self.nhandhc8, self},
		{"<color=gold>Tay Đồng Hành +7<color>", self.taydhc8, self},
		{"<color=gold>Phù Đồng Hành +7<color>", self.boidhc8, self},
		{"Kết Thúc Đối Thoại."},
		};
		Dialog:Say(szMsg, tbOpt);
		end	
function tbSuKienKiemThe:vkdhc8()
	local tbItemId1 = {18,1,2004,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,19,7,10,0,0}; -- vk1
	local nCount1 = me.GetItemCountInBags(18,1,2004,1);
	local nCount2 = me.GetItemCountInBags(5,19,7,10);
	if nCount1 >= 1600 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 1600);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,19,8,10);
		 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Vũ Khí Đồng Hành +7<color> ");
		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Vũ Khí Đồng Hành +7<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Vũ Khí Đồng Hành +6<color> và 1600 MG VK Đồng Hành hãy đến tìm ta . ")
		
		 
	end
end

function tbSuKienKiemThe:aodhc8()
	local tbItemId1 = {18,1,2005,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,20,7,10,0,0}; -- ao1
	local nCount1 = me.GetItemCountInBags(18,1,2005,1);
	local nCount2 = me.GetItemCountInBags(5,20,7,10);
if nCount1 >= 1600 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 1600);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,20,8,10);
		 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Áo Đồng Hành +7<color> ");
		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Áo Đồng Hành +7<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Áo Đồng Hành +6<color> và 1600 MG Áo Đồng Hành hãy đến tìm ta . ");
	end
end

function tbSuKienKiemThe:nhandhc8()
	local tbItemId1 = {18,1,2006,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,21,7,10,0,0}; -- nhan1
	local nCount1 = me.GetItemCountInBags(18,1,2006,1);
	local nCount2 = me.GetItemCountInBags(5,21,7,10);
	if nCount1 >= 1600 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 1600);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,21,8,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Nhẫn Đồng Hành +7<color> ");
			 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Nhẫn Đồng Hành +7<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Nhẫn Đồng Hành +6<color> và 1600 MG Nhẫn Đồng Hành hãy đến tìm ta . ");
	end
end
function tbSuKienKiemThe:taydhc8()
	local tbItemId1 = {18,1,2007,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,22,7,10,0,0}; -- tay1
	local nCount1 = me.GetItemCountInBags(18,1,2007,1);
	local nCount2 = me.GetItemCountInBags(5,22,7,10);
	if nCount1 >= 1600 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 1600);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,22,8,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Tay Đồng Hành +7<color> ");
local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Tay Đồng Hành +7<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Tay Đồng Hành +6<color> và 1600 MG Tay Đồng Hành hãy đến tìm ta . ");
	end
end
function tbSuKienKiemThe:boidhc8()
	local tbItemId1 = {18,1,2008,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,23,7,10,0,0}; -- phu1
	local nCount1 = me.GetItemCountInBags(18,1,2008,1);
	local nCount2 = me.GetItemCountInBags(5,23,7,10);
	if nCount1 >= 1600 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 1600);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,23,8,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Phù Đồng Hành +7<color> ");
local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Phù Đồng Hành +7<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Phù Đồng Hành +6<color> và 1600 MG Phù Đồng Hành hãy đến tìm ta . ");
	end
end	
		---------------------------------------------------
function tbSuKienKiemThe:TBDHC9()
local szMsg = " Nâng Cấp <color=red>TB Đồng Hành +8<color> = <color=red>TB Đồng Hành +7<color> + 2000 Mảnh Ghép ĐH ";
	local tbOpt = {
		{"<color=gold>Vũ Khí Đồng Hành +8<color>", self.vkdhc9, self},
		{"<color=gold>Áo Đồng Hành +8<color>", self.aodhc9, self},
		{"<color=gold>Nhẫn Đồng Hành +8<color>", self.nhandhc9, self},
		{"<color=gold>Tay Đồng Hành +8<color>", self.taydhc9, self},
		{"<color=gold>Phù Đồng Hành +8<color>", self.boidhc9, self},
		{"Kết Thúc Đối Thoại."},
		};
		Dialog:Say(szMsg, tbOpt);
		end	
function tbSuKienKiemThe:vkdhc9()
	local tbItemId1 = {18,1,2004,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,19,8,10,0,0}; -- vk1
	local nCount1 = me.GetItemCountInBags(18,1,2004,1);
	local nCount2 = me.GetItemCountInBags(5,19,8,10);
	if nCount1 >= 2000 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 2000);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,19,9,10);
		 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Vũ Khí Đồng Hành +8<color> ");
 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Vũ Khí Đồng Hành +8<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Vũ Khí Đồng Hành +7<color> và 2000 MG VK Đồng Hành hãy đến tìm ta . ")
		
		 
	end
end

function tbSuKienKiemThe:aodhc9()
	local tbItemId1 = {18,1,2005,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,20,8,10,0,0}; -- ao1
	local nCount1 = me.GetItemCountInBags(18,1,2005,1);
	local nCount2 = me.GetItemCountInBags(5,20,8,10);
if nCount1 >= 2000 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 2000);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,20,9,10);
		 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Áo Đồng Hành +8<color> ");
local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Áo Đồng Hành +8<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Áo Đồng Hành +7 <color> và 2000 MG Áo Đồng Hành hãy đến tìm ta . ");
	end
end

function tbSuKienKiemThe:nhandhc9()
	local tbItemId1 = {18,1,2006,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,21,8,10,0,0}; -- nhan1
	local nCount1 = me.GetItemCountInBags(18,1,2006,1);
	local nCount2 = me.GetItemCountInBags(5,21,8,10);
	if nCount1 >= 2000 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 2000);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,21,9,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Nhẫn Đồng Hành +8<color> ");
local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Nhẫn Đồng Hành +8<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Nhẫn Đồng Hành +7<color> và 2000 MG Nhẫn Đồng Hành hãy đến tìm ta . ");
	end
end
function tbSuKienKiemThe:taydhc9()
	local tbItemId1 = {18,1,2007,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,22,8,10,0,0}; -- tay1
	local nCount1 = me.GetItemCountInBags(18,1,2007,1);
	local nCount2 = me.GetItemCountInBags(5,22,8,10);
	if nCount1 >= 2000 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 2000);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,22,9,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Tay Đồng Hành +8<color> ");
local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Tay Đồng Hành +8<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Tay Đồng Hành +7<color> và 2000 MG Tay Đồng Hành hãy đến tìm ta . ");
	end
end
function tbSuKienKiemThe:boidhc9()
	local tbItemId1 = {18,1,2008,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,23,8,10,0,0}; -- phu1
	local nCount1 = me.GetItemCountInBags(18,1,2008,1);
	local nCount2 = me.GetItemCountInBags(5,23,8,10);
	if nCount1 >= 2000 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 2000);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,23,9,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Phù Đồng Hành +8<color> ");
local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Phù Đồng Hành +8<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Phù Đồng Hành +7<color> và 2000 MG Phù Đồng Hành hãy đến tìm ta . ");
	end
end	
		------------------------------------------------------------
function tbSuKienKiemThe:TBDHC10()
local szMsg = " Nâng Cấp <color=red>TB Đồng Hành +9<color> = <color=red>TB Đồng Hành +8<color> + 2500 Mảnh Ghép ĐH ";
	local tbOpt = {
		{"<color=gold>Vũ Khí Đồng Hành +9<color>", self.vkdhc10, self},
		{"<color=gold>Áo Đồng Hành +9<color>", self.aodhc10, self},
		{"<color=gold>Nhẫn Đồng Hành +9<color>", self.nhandhc10, self},
		{"<color=gold>Tay Đồng Hành +9<color>", self.taydhc10, self},
		{"<color=gold>Phù Đồng Hành +9<color>", self.boidhc10, self},
		{"Kết Thúc Đối Thoại."},
		};
		Dialog:Say(szMsg, tbOpt);
		end	
function tbSuKienKiemThe:vkdhc10()
	local tbItemId1 = {18,1,2004,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,19,9,10,0,0}; -- vk1
	local nCount1 = me.GetItemCountInBags(18,1,2004,1);
	local nCount2 = me.GetItemCountInBags(5,19,9,10);
	if nCount1 >= 2500 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 2500);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,19,10,10);
		 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Vũ Khí Đồng Hành +9<color> ");
 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Vũ Khí Đồng Hành +9<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Vũ Khí Đồng Hành +8<color> và 2500 MG VK Đồng Hành hãy đến tìm ta . ")
		
		 
	end
end

function tbSuKienKiemThe:aodhc10()
	local tbItemId1 = {18,1,2005,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,20,9,10,0,0}; -- ao1
	local nCount1 = me.GetItemCountInBags(18,1,2005,1);
	local nCount2 = me.GetItemCountInBags(5,20,9,10);
if nCount1 >= 2500 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 2500);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,20,10,10);
		 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Áo Đồng Hành +9<color> ");
local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Áo Đồng Hành +9<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Áo Đồng Hành +8<color> và 2500 MG Áo Đồng Hành hãy đến tìm ta . ");
	end
end

function tbSuKienKiemThe:nhandhc10()
	local tbItemId1 = {18,1,2006,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,21,9,10,0,0}; -- nhan1
	local nCount1 = me.GetItemCountInBags(18,1,2006,1);
	local nCount2 = me.GetItemCountInBags(5,21,9,10);
	if nCount1 >= 2500 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 2500);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,21,10,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Nhẫn Đồng Hành +9<color> ");
local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Nhẫn Đồng Hành +9<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Nhẫn Đồng Hành +8<color> và 2500 MG Nhẫn Đồng Hành hãy đến tìm ta . ");
	end
end
function tbSuKienKiemThe:taydhc10()
	local tbItemId1 = {18,1,2007,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,22,9,10,0,0}; -- tay1
	local nCount1 = me.GetItemCountInBags(18,1,2007,1);
	local nCount2 = me.GetItemCountInBags(5,22,9,10);
	if nCount1 >= 2500 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 2500);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,22,10,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Tay Đồng Hành +9<color> ");
 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Tay Đồng Hành +9<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Tay Đồng Hành +8<color> và 2500 MG Tay Đồng Hành hãy đến tìm ta . ");
	end
end
function tbSuKienKiemThe:boidhc10()
	local tbItemId1 = {18,1,2008,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,23,9,10,0,0}; -- phu1
	local nCount1 = me.GetItemCountInBags(18,1,2008,1);
	local nCount2 = me.GetItemCountInBags(5,23,9,10);
	if nCount1 >= 2500 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 2500);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,23,10,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Phù Đồng Hành +9<color> ");
 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Phù Đồng Hành +9<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Phù Đồng Hành +8<color> và 2500 MG Phù Đồng Hành hãy đến tìm ta . ");
	end
end			
------------------------------------------------------------------
function tbSuKienKiemThe:TBDHC11()
local szMsg = " Nâng Cấp <color=red>TB Đồng Hành +10<color> = <color=red>TB Đồng Hành +9<color> + 3000 Mảnh Ghép ĐH ";
	local tbOpt = {
		{"<color=gold>Vũ Khí Đồng Hành +10<color>", self.vkdhc11, self},
		{"<color=gold>Áo Đồng Hành +10<color>", self.aodhc11, self},
		{"<color=gold>Nhẫn Đồng Hành +10<color>", self.nhandhc11, self},
		{"<color=gold>Tay Đồng Hành +10<color>", self.taydhc11, self},
		{"<color=gold>Phù Đồng Hành +10<color>", self.boidhc11, self},
		{"Kết Thúc Đối Thoại."},
		};
		Dialog:Say(szMsg, tbOpt);
		end	
function tbSuKienKiemThe:vkdhc11()
	local tbItemId1 = {18,1,2004,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,19,10,10,0,0}; -- vk1
	local nCount1 = me.GetItemCountInBags(18,1,2004,1);
	local nCount2 = me.GetItemCountInBags(5,19,10,10);
	if nCount1 >= 2500 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 3000);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,19,11,10);
		 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Vũ Khí Đồng Hành +10<color> ");
 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Vũ Khí Đồng Hành +10<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Vũ Khí Đồng Hành +9<color> và 3000 MG VK Đồng Hành hãy đến tìm ta . ")
		
		 
	end
end

function tbSuKienKiemThe:aodhc11()
	local tbItemId1 = {18,1,2005,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,20,10,10,0,0}; -- ao1
	local nCount1 = me.GetItemCountInBags(18,1,2005,1);
	local nCount2 = me.GetItemCountInBags(5,20,10,10);
if nCount1 >= 2500 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 3000);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,20,11,10);
		 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Áo Đồng Hành +10<color> ");
local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Áo Đồng Hành +10<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Áo Đồng Hành +9<color> và 3000 MG Áo Đồng Hành hãy đến tìm ta . ");
	end
end

function tbSuKienKiemThe:nhandhc11()
	local tbItemId1 = {18,1,2006,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,21,10,10,0,0}; -- nhan1
	local nCount1 = me.GetItemCountInBags(18,1,2006,1);
	local nCount2 = me.GetItemCountInBags(5,21,10,10);
	if nCount1 >= 2500 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 3000);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,21,11,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Nhẫn Đồng Hành +10<color> ");
local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Nhẫn Đồng Hành +10<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Nhẫn Đồng Hành +9<color> và 3000 MG Nhẫn Đồng Hành hãy đến tìm ta . ");
	end
end
function tbSuKienKiemThe:taydhc11()
	local tbItemId1 = {18,1,2007,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,22,10,10,0,0}; -- tay1
	local nCount1 = me.GetItemCountInBags(18,1,2007,1);
	local nCount2 = me.GetItemCountInBags(5,22,10,10);
	if nCount1 >= 2500 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 3000);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,22,11,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Tay Đồng Hành +10<color> ");
 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Tay Đồng Hành +10<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Tay Đồng Hành +9<color> và 3000 MG Tay Đồng Hành hãy đến tìm ta . ");
	end
end
function tbSuKienKiemThe:boidhc11()
	local tbItemId1 = {18,1,2008,1,0,0}; -- Dong tien vang
	local tbItemId2 = {5,23,10,10,0,0}; -- phu1
	local nCount1 = me.GetItemCountInBags(18,1,2008,1);
	local nCount2 = me.GetItemCountInBags(5,23,10,10);
	if nCount1 >= 2500 and nCount2 >=1 then
	Task:DelItem(me, tbItemId1, 3000);
	Task:DelItem(me, tbItemId2, 1);
	me.AddItem(5,23,11,10);
			 Dialog:Say(" Chúc mừng bạn nhận được <color=red>Phù Đồng Hành +10<color> ");
 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Phù Đồng Hành +10<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);
		else
		Dialog:Say(" Khi nào đủ 1 <color=red>Phù Đồng Hành +9<color> và 3000 MG Phù Đồng Hành hãy đến tìm ta . ");
	end
end	
-----------------------------an--------------------------------------

function tbSuKienKiemThe:an()
	local szMsg = " Để <color=yellow>Ấn<color> + MG Ấn trong Rương ";
	local tbOpt = {
		{" <color=yellow>Ấn +1<color> = <color=green>Thanh Long Ấn<color> + 100 MG Ấn ", self.an1, self},
		{" <color=yellow>Ấn +2<color> = <color=green>Ấn +1<color> + 200 MG Ấn ", self.an2, self},
		{" <color=yellow>Ấn +3<color> = <color=green>Ấn +2<color> + 300 MG Ấn ", self.an3, self},
		{" <color=yellow>Ấn +4<color> = <color=green>Ấn +3<color> + 400 MG Ấn ", self.an4, self},
		{" <color=yellow>Ấn +5<color> = <color=green>Ấn +4<color> + 500 MG Ấn ", self.an5, self},
		{" <color=yellow>Ấn +6<color> = <color=green>Ấn +5<color> + 600 MG Ấn ", self.an6, self},
		{" <color=yellow>Ấn +7<color> = <color=green>Ấn +6<color> + 700 MG Ấn ", self.an7, self},
		{" <color=yellow>Ấn +8<color> = <color=green>Ấn +7<color> + 800 MG Ấn ", self.an8, self},
		{" <color=yellow>Ấn +9<color> = <color=green>Ấn +8<color> + 900 MG Ấn ", self.an9, self},
		{" <color=yellow>Ấn +10<color> = <color=green>Ấn +9<color> + 1000 MG Ấn ", self.an10, self},
		{"Kết Thúc Đối Thoại."},
	};
	Dialog:Say(szMsg, tbOpt);
	
end

function tbSuKienKiemThe:an1()
	local tbItemId1 = {1,16,14,10,0,0}; -- an 1
	local tbItemId2 = {18,1,20316,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,16,14,10);
	local nCount2 = me.GetItemCountInBags(18,1,20316,1);
	if nCount1 >= 1 and nCount2 >= 100 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 100);
	me.AddItem(1,16,15,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Thanh Long Ấn +1<color> ");
		 		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Thanh Long Ấn +1<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Thanh Long Ấn<color> và 100 MG Ấn hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:an2()
	local tbItemId1 = {1,16,15,10,0,0}; -- mat na 1
	local tbItemId2 = {18,1,20316,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,16,15,10);
	local nCount2 = me.GetItemCountInBags(18,1,20316,1);
	if nCount1 >= 1 and nCount2 >= 200 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 200);
	me.AddItem(1,16,16,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Thanh Long Ấn +2<color> ");
		 		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Thanh Long Ấn +2<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Thanh Long Ấn +1<color> và 200 MG Ấn hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:an3()
	local tbItemId1 = {1,16,16,10,0,0}; -- mat na 1
	local tbItemId2 = {18,1,20316,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,16,16,10);
	local nCount2 = me.GetItemCountInBags(18,1,20316,1);
	if nCount1 >= 1 and nCount2 >= 300 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 300);
	me.AddItem(1,16,17,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Thanh Long Ấn +3<color> ");
		 		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Thanh Long Ấn +3<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Thanh Long Ấn +2<color> và 300 MG Ấn hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:an4()
	local tbItemId1 = {1,16,17,10,0,0}; -- mat na 1
	local tbItemId2 = {18,1,20316,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,16,17,10);
	local nCount2 = me.GetItemCountInBags(18,1,20316,1);
	if nCount1 >= 1 and nCount2 >= 400 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 400);
	me.AddItem(1,16,18,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Thanh Long Ấn +4<color> ");
		 		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Thanh Long Ấn +4<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Thanh Long Ấn +3<color> và 400 MG Ấn hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:an5()
	local tbItemId1 = {1,16,18,10,0,0}; -- mat na 1
	local tbItemId2 = {18,1,20316,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,16,18,10);
	local nCount2 = me.GetItemCountInBags(18,1,20316,1);
	if nCount1 >= 1 and nCount2 >= 500 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 500);
	me.AddItem(1,16,19,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Thanh Long Ấn +5<color> ");
		 		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Thanh Long Ấn +5<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Thanh Long Ấn +4<color> và 500 MG Ấn hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:an6()
	local tbItemId1 = {1,16,19,10,0,0}; -- mat na 1
	local tbItemId2 = {18,1,20316,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,16,19,10);
	local nCount2 = me.GetItemCountInBags(18,1,20316,1);
	if nCount1 >= 1 and nCount2 >= 600 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 600);
	me.AddItem(1,16,20,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Thanh Long Ấn +6<color> ");
		 		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Thanh Long Ấn +6<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Thanh Long Ấn +5<color> và 600 MG Ấn hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:an7()
	local tbItemId1 = {1,16,20,10,0,0}; -- mat na 1
	local tbItemId2 = {18,1,20316,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,16,20,10);
	local nCount2 = me.GetItemCountInBags(18,1,20316,1);
	if nCount1 >= 1 and nCount2 >= 700 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 700);
	me.AddItem(1,16,21,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Thanh Long Ấn +7<color> ");
		 		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Thanh Long Ấn +7<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Thanh Long Ấn +6<color> và 700 MG Ấn hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:an8()
	local tbItemId1 = {1,16,21,10,0,0}; -- mat na 1
	local tbItemId2 = {18,1,20316,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,16,21,10);
	local nCount2 = me.GetItemCountInBags(18,1,20316,1);
	if nCount1 >= 1 and nCount2 >= 800 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 800);
	me.AddItem(1,16,22,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Thanh Long Ấn +8<color> ");
		 		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Thanh Long Ấn +8<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Thanh Long Ấn +7<color> và 800 MG Ấn hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:an9()
	local tbItemId1 = {1,16,22,10,0,0}; -- mat na 1
	local tbItemId2 = {18,1,20316,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,16,22,10);
	local nCount2 = me.GetItemCountInBags(18,1,20316,1);
	if nCount1 >= 1 and nCount2 >= 900 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 900);
	me.AddItem(1,16,23,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Thanh Long Ấn +9<color> ");
		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Thanh Long Ấn +9<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Thanh Long Ấn +8<color> và 900 MG Ấn hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:an10()
	local tbItemId1 = {1,16,23,10,0,0}; -- mat na 1
	local tbItemId2 = {18,1,20316,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,16,23,10);
	local nCount2 = me.GetItemCountInBags(18,1,20316,1);
	if nCount1 >= 1 and nCount2 >= 1000 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 1000);
	me.AddItem(1,16,24,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Thanh Long Ấn +10<color> ");
		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Thanh Long Ấn +10<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Ấn +9<color> và 1000 MG Ấn hãy đến tìm ta .");
	end
end
-------------------------------------gia lam kinh-------------------------------------------------------
function tbSuKienKiemThe:glk()
	local szMsg = " Để <color=yellow>Già Lam Kinh<color> + MG Già Lam Kinh trong Rương ";
	local tbOpt = {
		{" <color=yellow>Già Lam Kinh +1<color> = <color=green>Già Lam Kinh<color> + 100 MG GLK ", self.glk1, self},
		{" <color=yellow>Già Lam Kinh +2<color> = <color=green>GLK +1<color> + 200 MG GLK ", self.glk2, self},
		{" <color=yellow>Già Lam Kinh +3<color> = <color=green>GLK +2<color> + 300 MG GLK ", self.glk3, self},
		{" <color=yellow>Già Lam Kinh +4<color> = <color=green>GLK +3<color> + 400 MG GLK ", self.glk4, self},
		{" <color=yellow>Già Lam Kinh +5<color> = <color=green>GLK +4<color> + 500 MG GLK ", self.glk5, self},
		{" <color=yellow>Già Lam Kinh +6<color> = <color=green>GLK +5<color> + 600 MG GLK ", self.glk6, self},
		{" <color=yellow>Già Lam Kinh +7<color> = <color=green>GLK +6<color> + 700 MG GLK ", self.glk7, self},
		{" <color=yellow>Già Lam Kinh +8<color> = <color=green>GLK +7<color> + 800 MG GLK ", self.glk8, self},
		{" <color=yellow>Già Lam Kinh +9<color> = <color=green>GLK +8<color> + 900 MG GLK ", self.glk9, self},
		{" <color=yellow>Già Lam Kinh +10<color> = <color=green>GLK +9<color> + 1000 MG GLK ", self.glk10, self},
		{"Kết Thúc Đối Thoại."},
	};
	Dialog:Say(szMsg, tbOpt);
	
end

function tbSuKienKiemThe:glk1()
	local tbItemId1 = {1,14,25,10,0,0}; -- glk 1
	local tbItemId2 = {18,1,3051,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,14,25,10);
	local nCount2 = me.GetItemCountInBags(18,1,3051,1);
	if nCount1 >= 1 and nCount2 >= 100 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 100);
	me.AddItem(1,14,26,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Già Lam Kinh +1<color> ");
		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Già Lam Kinh +1<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Già Lam Kinh<color> và 100 MG Già Lam Kinh hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:glk2()
	local tbItemId1 = {1,14,26,10,0,0}; -- glk 1
	local tbItemId2 = {18,1,3051,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,14,26,10);
	local nCount2 = me.GetItemCountInBags(18,1,3051,1);
	if nCount1 >= 1 and nCount2 >= 200 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 200);
	me.AddItem(1,14,27,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Già Lam Kinh +2<color> ");
		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Già Lam Kinh +2<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Già Lam Kinh +1<color> và 200 MG Già Lam Kinh hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:glk3()
	local tbItemId1 = {1,14,27,10,0,0}; -- glk 1
	local tbItemId2 = {18,1,3051,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,14,27,10);
	local nCount2 = me.GetItemCountInBags(18,1,3051,1);
	if nCount1 >= 1 and nCount2 >= 300 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 300);
	me.AddItem(1,14,28,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Già Lam Kinh +3<color> ");
		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Già Lam Kinh +3<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Già Lam Kinh +2<color> và 300 MG Già Lam Kinh hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:glk4()
	local tbItemId1 = {1,14,28,10,0,0}; -- glk 1
	local tbItemId2 = {18,1,3051,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,14,28,10);
	local nCount2 = me.GetItemCountInBags(18,1,3051,1);
	if nCount1 >= 1 and nCount2 >= 400 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 400);
	me.AddItem(1,14,29,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Già Lam Kinh +4<color> ");
		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Già Lam Kinh +4<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Già Lam Kinh +3<color> và 400 MG Già Lam Kinh hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:glk5()
	local tbItemId1 = {1,14,29,10,0,0}; -- glk 1
	local tbItemId2 = {18,1,3051,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,14,29,10);
	local nCount2 = me.GetItemCountInBags(18,1,3051,1);
	if nCount1 >= 1 and nCount2 >= 500 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 500);
	me.AddItem(1,14,30,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Già Lam Kinh +5<color> ");
		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Già Lam Kinh +5<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Già Lam Kinh +4<color> và 500 MG Già Lam Kinh hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:glk6()
	local tbItemId1 = {1,14,30,10,0,0}; -- glk 1
	local tbItemId2 = {18,1,3051,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,14,30,10);
	local nCount2 = me.GetItemCountInBags(18,1,3051,1);
	if nCount1 >= 1 and nCount2 >= 600 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 600);
	me.AddItem(1,14,31,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Già Lam Kinh +6<color> ");
		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Già Lam Kinh +6<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Già Lam Kinh +5<color> và 600 MG Già Lam Kinh hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:glk7()
	local tbItemId1 = {1,14,31,10,0,0}; -- glk 1
	local tbItemId2 = {18,1,3051,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,14,31,10);
	local nCount2 = me.GetItemCountInBags(18,1,3051,1);
	if nCount1 >= 1 and nCount2 >= 700 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 700);
	me.AddItem(1,14,32,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Già Lam Kinh +7<color> ");
		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Già Lam Kinh +7<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Già Lam Kinh +6<color> và 700 MG Già Lam Kinh hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:glk8()
	local tbItemId1 = {1,14,32,10,0,0}; -- glk 1
	local tbItemId2 = {18,1,3051,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,14,32,10);
	local nCount2 = me.GetItemCountInBags(18,1,3051,1);
	if nCount1 >= 1 and nCount2 >= 800 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 800);
	me.AddItem(1,14,33,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Già Lam Kinh +8<color> ");
		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Già Lam Kinh +8<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Già Lam Kinh +7<color> và 800 MG Già Lam Kinh hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:glk9()
	local tbItemId1 = {1,14,33,10,0,0}; -- glk 1
	local tbItemId2 = {18,1,3051,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,14,33,10);
	local nCount2 = me.GetItemCountInBags(18,1,3051,1);
	if nCount1 >= 1 and nCount2 >= 900 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 900);
	me.AddItem(1,14,34,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Già Lam Kinh +9<color> ");
		 		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Già Lam Kinh +9<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Già Lam Kinh +8<color> và 900 MG Già Lam Kinh hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:glk10()
	local tbItemId1 = {1,14,34,10,0,0}; -- glk 1
	local tbItemId2 = {18,1,3051,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,14,34,10);
	local nCount2 = me.GetItemCountInBags(18,1,3051,1);
	if nCount1 >= 1 and nCount2 >= 1000 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 1000);
	me.AddItem(1,14,35,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Già Lam Kinh +10<color> ");
		 		 local szMsg = string.format("Người chơi <color=green>"..me.szName.."<color> nâng cấp thành công <color=red>Già Lam Kinh +10<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Già Lam Kinh +9<color> và 1000 MG Già Lam Kinh hãy đến tìm ta .");
	end
end
-----------------------------------ngua-----------------------------------------------------------
function tbSuKienKiemThe:ngua()
	local szMsg = " Để <color=yellow>Ngựa<color> + MG Ngựa trong Rương ";
	local tbOpt = {
		{" <color=yellow>Thần Thú +1<color> = <color=green>Phiên Vũ<color> + 100 MG Ngựa ", self.ngua1, self},
		{" <color=yellow>Thần Thú +2<color> = <color=green>Thần Thú +1<color> + 200 MG Ngựa ", self.ngua2, self},
		{" <color=yellow>Thần Thú +3<color> = <color=green>Thần Thú +2<color> + 300 MG Ngựa ", self.ngua3, self},
		{" <color=yellow>Thần Thú +4<color> = <color=green>Thần Thú +3<color> + 400 MG Ngựa ", self.ngua4, self},
		{" <color=yellow>Thần Thú +5<color> = <color=green>Thần Thú +4<color> + 500 MG Ngựa ", self.ngua5, self},
		{" <color=yellow>Thần Thú +6<color> = <color=green>Thần Thú +5<color> + 600 MG Ngựa ", self.ngua6, self},
		{" <color=yellow>Thần Thú +7<color> = <color=green>Thần Thú +6<color> + 700 MG Ngựa ", self.ngua7, self},
		{" <color=yellow>Thần Thú +8<color> = <color=green>Thần Thú +7<color> + 800 MG Ngựa ", self.ngua8, self},
		{" <color=yellow>Thần Thú +9<color> = <color=green>Thần Thú +8<color> + 900 MG Ngựa ", self.ngua9, self},
		{" <color=yellow>Thần Thú +10<color> = <color=green>Thần Thú +9<color> + 1000 MG Ngựa ", self.ngua10, self},
		{"Kết Thúc Đối Thoại."},
	};
	Dialog:Say(szMsg, tbOpt);
	
end
function tbSuKienKiemThe:ngua1()
	local tbItemId1 = {1,12,33,4,0,0}; -- glk 1
	local tbItemId2 = {18,1,1192,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,12,33,4);
	local nCount2 = me.GetItemCountInBags(18,1,1192,1);
	if nCount1 >= 1 and nCount2 >= 100 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 100);
	me.AddItem(1,12,20041,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>[Thần Thú +1] Tuyết Hồn<color> ");
		 local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>[Thần Thú +1] Tuyết Hồn<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);			 

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Phiên Vũ<color> và 100 MG Ngựa hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:ngua2()
	local tbItemId1 = {1,12,20041,10,0,0}; -- glk 1
	local tbItemId2 = {18,1,1192,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,12,20041,10);
	local nCount2 = me.GetItemCountInBags(18,1,1192,1);
	if nCount1 >= 1 and nCount2 >= 200 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 200);
	me.AddItem(1,12,20040,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>[Thần Thú +2] Hắc Kỳ Lân<color> ");
		 local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>[Thần Thú +2] Hắc Kỳ Lân<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);		 

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>[Thần Thú +1] Tuyết Hồn<color> và 200 MG Ngựa hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:ngua3()
	local tbItemId1 = {1,12,20040,10,0,0}; -- glk 1
	local tbItemId2 = {18,1,1192,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,12,20040,10);
	local nCount2 = me.GetItemCountInBags(18,1,1192,1);
	if nCount1 >= 1 and nCount2 >= 300 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 300);
	me.AddItem(1,12,20084,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>[Thần Thú +3] Hắc Mao Sư Vương<color> ");
		 local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>[Thần Thú +3] Hắc Mao Sư Vương<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);	 

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>[Thần Thú +2] Hắc Kỳ Lân<color> và 300 MG Ngựa hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:ngua4()
	local tbItemId1 = {1,12,20084,10,0,0}; -- glk 1
	local tbItemId2 = {18,1,1192,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,12,20084,10);
	local nCount2 = me.GetItemCountInBags(18,1,1192,1);
	if nCount1 >= 1 and nCount2 >= 400 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 400);
	me.AddItem(1,12,20057,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>[Thần Thú +4] Tuyết Địa Sa Mạc<color> ");
		 local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>[Thần Thú +4] Tuyết Địa Sa Mạc<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);		 

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>[Thần Thú +3] Hắc Mao Sư Vương<color> và 400 MG Ngựa hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:ngua5()
	local tbItemId1 = {1,12,20057,10,0,0}; -- glk 1
	local tbItemId2 = {18,1,1192,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,12,20057,10);
	local nCount2 = me.GetItemCountInBags(18,1,1192,1);
	if nCount1 >= 1 and nCount2 >= 500 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 500);
	me.AddItem(1,12,20070,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>[Thần Thú +5] Hỏa Vũ Thiên Hương<color> ");
		 local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>[Thần Thú +5] Hỏa Vũ Thiên Hương<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>[Thần Thú +4] Tuyết Địa Sa Mạc<color> và 400 MG Ngựa hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:ngua6()
	local tbItemId1 = {1,12,20070,10,0,0}; -- glk 1
	local tbItemId2 = {18,1,1192,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,12,20070,10);
	local nCount2 = me.GetItemCountInBags(18,1,1192,1);
	if nCount1 >= 1 and nCount2 >= 600 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 600);
	me.AddItem(1,12,20077,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>[Thần Thú +6] Linh Dương Giáp<color> ");
local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>[Thần Thú +6] Linh Dương Giáp<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>[Thần Thú +5] Hỏa Vũ Thiên Hương<color> và 600 MG Ngựa hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:ngua7()
	local tbItemId1 = {1,12,20077,10,0,0}; -- glk 1
	local tbItemId2 = {18,1,1192,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,12,20077,10);
	local nCount2 = me.GetItemCountInBags(18,1,1192,1);
	if nCount1 >= 1 and nCount2 >= 700 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 700);
	me.AddItem(1,12,20045,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>[Thần Thú +7] Bạch Lộc<color> ");
local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>[Thần Thú +7] Bạch Lộc<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>[Thần Thú +6] Linh Dương Giáp<color> và 700 MG Ngựa hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:ngua8()
	local tbItemId1 = {1,12,20045,10,0,0}; -- glk 1
	local tbItemId2 = {18,1,1192,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,12,20045,10);
	local nCount2 = me.GetItemCountInBags(18,1,1192,1);
	if nCount1 >= 1 and nCount2 >= 800 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 800);
	me.AddItem(1,12,20043,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>[Thần Thú +8] Hồng Long Xích Diệm<color> ");
local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>[Thần Thú +8] Hồng Long Xích Diệm<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>[Thần Thú +7] Bạch Lộc<color> và 800 MG Ngựa hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:ngua9()
	local tbItemId1 = {1,12,20043,10,0,0}; -- glk 1
	local tbItemId2 = {18,1,1192,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,12,20043,10);
	local nCount2 = me.GetItemCountInBags(18,1,1192,1);
	if nCount1 >= 1 and nCount2 >= 900 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 900);
	me.AddItem(1,12,20082,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>[Thần Thú +9] Kim Tượng Thái Đạt<color> ");
local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>[Thần Thú +9] Kim Tượng Thái Đạt<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>[Thần Thú +9] Hồng Long Xích Diệm<color> và 900 MG Ngựa hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:ngua10()
	local tbItemId1 = {1,12,20082,10,0,0}; -- glk 1
	local tbItemId2 = {18,1,1192,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,12,20082,10);
	local nCount2 = me.GetItemCountInBags(18,1,1192,1);
	if nCount1 >= 1 and nCount2 >= 1000 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 1000);
	me.AddItem(1,12,271,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>[Thần Thú +10] Vua PK - Kinh Huyền Sấm<color> ");
local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>[Thần Thú +10] Vua PK - Kinh Huyền Sấm<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>[Thần Thú +9] Kim Tượng Thái Đạt<color> và 1000 MG Ngựa hãy đến tìm ta .");
	end
end
--------------------------mat na--------------------------------------
function tbSuKienKiemThe:matna()
	local szMsg = " Để <color=yellow>Mặt Nạ<color> + MG Mặt Nạ trong Rương ";
	local tbOpt = {		
		{" <color=yellow>Mặt Nạ +1<color> = <color=green>Mặt Nạ Cửu Thiên<color> + 100 MG Mặt Nạ ", self.matna1, self},
		{" <color=yellow>Mặt Nạ +2<color> = <color=green>Mặt Nạ +1<color> + 200 MG Mặt Nạ ", self.matna2, self},
		{" <color=yellow>Mặt Nạ +3<color> = <color=green>Mặt Nạ +2<color> + 300 MG Mặt Nạ ", self.matna3, self},
		{" <color=yellow>Mặt Nạ +4<color> = <color=green>Mặt Nạ +3<color> + 400 MG Mặt Nạ ", self.matna4, self},
		{" <color=yellow>Mặt Nạ +5<color> = <color=green>Mặt Nạ +4<color> + 500 MG Mặt Nạ ", self.matna5, self},
		{" <color=yellow>Mặt Nạ +6<color> = <color=green>Mặt Nạ +5<color> + 600 MG Mặt Nạ ", self.matna6, self},
		{" <color=yellow>Mặt Nạ +7<color> = <color=green>Mặt Nạ +6<color> + 700 MG Mặt Nạ ", self.matna7, self},
		{" <color=yellow>Mặt Nạ +8<color> = <color=green>Mặt Nạ +7<color> + 800 MG Mặt Nạ ", self.matna8, self},
		{" <color=yellow>Mặt Nạ +9<color> = <color=green>Mặt Nạ +8<color> + 900 MG Mặt Nạ ", self.matna9, self},
		{" <color=yellow>Mặt Nạ +10<color> = <color=green>Mặt Nạ +9<color> + 1000 MG Mặt Nạ ", self.matna10, self},
		{"Kết Thúc Đối Thoại."},
	};
	Dialog:Say(szMsg, tbOpt);
	
end

function tbSuKienKiemThe:matna1()
	local tbItemId1 = {1,13,156,10,0,0}; -- mat na 1
	local tbItemId2 = {18,1,25117,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,13,156,10);
	local nCount2 = me.GetItemCountInBags(18,1,25117,1);
	if nCount1 >= 1 and nCount2 >= 100 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 100);
	me.AddItem(1,13,157,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Mặt Nạ Cửu Thiên +1<color> ");
		 			local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>Mặt Nạ Cửu Thiên +1<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Mặt Nạ Cửu Thiên<color> và 100 MG Mặt Nạ hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:matna2()
	local tbItemId1 = {1,13,157,10,0,0}; -- mat na 2
	local tbItemId2 = {18,1,25117,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,13,157,10);
	local nCount2 = me.GetItemCountInBags(18,1,25117,1);
	if nCount1 >= 1 and nCount2 >= 200 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 200);
	me.AddItem(1,13,158,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Mặt Nạ Cửu Thiên +2<color> ");
		 		 			local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>Mặt Nạ Cửu Thiên Quán +2<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Mặt Nạ Cửu Thiên +1<color> và 200 MG Mặt Nạ hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:matna3()
	local tbItemId1 = {1,13,158,10,0,0}; -- mat na 1
	local tbItemId2 = {18,1,25117,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,13,158,10);
	local nCount2 = me.GetItemCountInBags(18,1,25117,1);
	if nCount1 >= 1 and nCount2 >= 300 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 300);
	me.AddItem(1,13,159,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Mặt Nạ Cửu Thiên +3<color> ");
		 		 			local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>Mặt Nạ Cửu Thiên +3<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Mặt Nạ Cửu Thiên +2<color> và 300 MG Mặt Nạ hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:matna4()
	local tbItemId1 = {1,13,159,10,0,0}; -- mat na 1
	local tbItemId2 = {18,1,25117,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,13,159,10);
	local nCount2 = me.GetItemCountInBags(18,1,25117,1);
	if nCount1 >= 1 and nCount2 >= 400 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 400);
	me.AddItem(1,13,160,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Mặt Nạ Cửu Thiên +4<color> ");
		 		 		 			local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>Mặt Nạ Cửu Thiên +4<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Mặt Nạ Cửu Thiên +3<color> và 400 MG Mặt Nạ hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:matna5()
	local tbItemId1 = {1,13,160,10,0,0}; -- mat na 1
	local tbItemId2 = {18,1,25117,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,13,160,10);
	local nCount2 = me.GetItemCountInBags(18,1,25117,1);
	if nCount1 >= 1 and nCount2 >= 500 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 500);
	me.AddItem(1,13,161,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Mặt Nạ Cửu Thiên +5<color> ");
		 		 		 			local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>Mặt Nạ Cửu Thiên +5<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Mặt Nạ Cửu Thiên +4<color> và 500 MG Mặt Nạ hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:matna6()
	local tbItemId1 = {1,13,161,10,0,0}; -- mat na 1
	local tbItemId2 = {18,1,25117,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,13,161,10);
	local nCount2 = me.GetItemCountInBags(18,1,25117,1);
	if nCount1 >= 1 and nCount2 >= 600 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 600);
	me.AddItem(1,13,162,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Mặt Nạ Cửu Thiên +6<color> ");
		 		 		 			local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>Mặt Nạ Cửu Thiên +6<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 [<color=yellow>Mặt Nạ Cửu Thiên +5<color> và 600 MG Mặt Nạ hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:matna7()
	local tbItemId1 = {1,13,162,10,0,0}; -- mat na 1
	local tbItemId2 = {18,1,25117,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,13,162,10);
	local nCount2 = me.GetItemCountInBags(18,1,25117,1);
	if nCount1 >= 1 and nCount2 >= 700 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 700);
	me.AddItem(1,13,163,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Mặt Nạ Cửu Thiên +7<color> ");
		 		 		 			local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>Mặt Nạ Cửu Thiên Cửu Thiên +7<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Mặt Nạ Cửu Thiên +6<color> và 700 MG Mặt Nạ hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:matna8()
	local tbItemId1 = {1,13,163,10,0,0}; -- mat na 1
	local tbItemId2 = {18,1,25117,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,13,163,10);
	local nCount2 = me.GetItemCountInBags(18,1,25117,1);
	if nCount1 >= 1 and nCount2 >= 800 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 800);
	me.AddItem(1,13,164,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Mặt Nạ Cửu Thiên +8<color> ");
		 		 		 			local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>Mặt Nạ Cửu Thiên Quán +8<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Mặt Nạ Cửu Thiên +7<color> và 800 MG Mặt Nạ hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:matna9()
	local tbItemId1 = {1,13,164,10,0,0}; -- mat na 1
	local tbItemId2 = {18,1,25117,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,13,164,10);
	local nCount2 = me.GetItemCountInBags(18,1,25117,1);
	if nCount1 >= 1 and nCount2 >= 900 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 900);
	me.AddItem(1,13,165,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Mặt Nạ Cửu Thiên +9<color> ");
		 		 		 			local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>Mặt Nạ Cửu Thiên +9<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Mặt Nạ Cửu Thiên +8<color> và 900 MG Mặt Nạ hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:matna10()
	local tbItemId1 = {1,13,165,10,0,0}; -- mat na 1
	local tbItemId2 = {18,1,25117,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,13,165,10);
	local nCount2 = me.GetItemCountInBags(18,1,25117,1);
	if nCount1 >= 1 and nCount2 >= 1000 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 1000);
	me.AddItem(1,13,166,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>Mặt Nạ Cửu Thiên +10<color> ");
		 		 		 			local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>Mặt Nạ Cửu Thiên +10<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>Mặt Nạ Cửu Thiên +9<color> và 1000 MG Mặt Nạ hãy đến tìm ta .");
	end
end
------------------------------------------------------------------------------------------------------------------------

function tbSuKienKiemThe:tranphap()
	local szMsg = " Để <color=yellow>Bát Quái Trận<color> + Mảnh Trận Pháp trong Rương ";
	local tbOpt = {		
		{" <color=yellow>Bát Quái Trận +1<color> = <color=green>Bát Quái Trận<color> + 100 Mảnh Trận Pháp ", self.tranphap1, self},
		{" <color=yellow>Bát Quái Trận +2<color> = <color=green>Bát Quái Trận +1<color> + 200 Mảnh Trận Pháp ", self.tranphap2, self},
		{" <color=yellow>Bát Quái Trận +3<color> = <color=green>Bát Quái Trận +2<color> + 300 Mảnh Trận Pháp ", self.tranphap3, self},
		{" <color=yellow>Bát Quái Trận +4<color> = <color=green>Bát Quái Trận +3<color> + 400 Mảnh Trận Pháp ", self.tranphap4, self},
		{" <color=yellow>Bát Quái Trận +5<color> = <color=green>Bát Quái Trận +4<color> + 500 Mảnh Trận Pháp ", self.tranphap5, self},
		{" <color=yellow>Bát Quái Trận +6<color> = <color=green>Bát Quái Trận +5<color> + 600 Mảnh Trận Pháp ", self.tranphap6, self},
		{" <color=yellow>Bát Quái Trận +7<color> = <color=green>Bát Quái Trận +6<color> + 700 Mảnh Trận Pháp ", self.tranphap7, self},
		{" <color=yellow>Bát Quái Trận +8<color> = <color=green>Bát Quái Trận +7<color> + 800 Mảnh Trận Pháp ", self.tranphap8, self},
		{" <color=yellow>Bát Quái Trận +9<color> = <color=green>Bát Quái Trận +8<color> + 900 Mảnh Trận Pháp ", self.tranphap9, self},
		{" <color=yellow>Bát Quái Trận +10<color> = <color=green>Bát Quái Trận +9<color> + 1000 Mảnh Trận Pháp ", self.tranphap10, self},
		
		{"Kết Thúc Đối Thoại."},
	};
	Dialog:Say(szMsg, tbOpt);
	
end

function tbSuKienKiemThe:tranphap1()
	local tbItemId1 = {1,15,12,10,0,0}; -- mat na 1
	local tbItemId2 = {18,1,26000,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,15,12,10);
	local nCount2 = me.GetItemCountInBags(18,1,26000,1);
	if nCount1 >= 1 and nCount2 >= 100 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 100);
	me.AddItem(1,15,13,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>[Trận Pháp]Bát Quái Trận +1<color> ");
		 			local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>[Trận Pháp]Bát Quái Trận +1<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>[Trận Pháp]Bát Quái Trận<color> và 100 Mảnh Trận Pháp hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:tranphap2()
	local tbItemId1 = {1,15,13,10,0,0}; -- mat na 2
	local tbItemId2 = {18,1,26000,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,15,13,10);
	local nCount2 = me.GetItemCountInBags(18,1,26000,1);
	if nCount1 >= 1 and nCount2 >= 200 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 200);
	me.AddItem(1,15,14,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>[Trận Pháp]Bát Quái Trận +2<color> ");
		 			local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>[Trận Pháp]Bát Quái Trận +2<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>[Trận Pháp]Bát Quái Trận +1<color> và 200 Mảnh Trận Pháp hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:tranphap3()
	local tbItemId1 = {1,15,14,10,0,0}; -- mat na 2
	local tbItemId2 = {18,1,26000,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,15,14,10);
	local nCount2 = me.GetItemCountInBags(18,1,26000,1);
	if nCount1 >= 1 and nCount2 >= 300 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 300);
	me.AddItem(1,15,15,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>[Trận Pháp]Bát Quái Trận +3<color> ");
		 			local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>[Trận Pháp]Bát Quái Trận +3<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>[Trận Pháp]Bát Quái Trận +2<color> và 300 Mảnh Trận Pháp hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:tranphap4()
	local tbItemId1 = {1,15,15,10,0,0}; -- mat na 2
	local tbItemId2 = {18,1,26000,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,15,15,10);
	local nCount2 = me.GetItemCountInBags(18,1,26000,1);
	if nCount1 >= 1 and nCount2 >= 400 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 400);
	me.AddItem(1,15,16,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>[Trận Pháp]Bát Quái Trận +4<color> ");
		 			local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>[Trận Pháp]Bát Quái Trận +4<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>[Trận Pháp]Bát Quái Trận +3<color> và 400 Mảnh Trận Pháp hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:tranphap5()
	local tbItemId1 = {1,15,16,10,0,0}; -- mat na 2
	local tbItemId2 = {18,1,26000,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,15,16,10);
	local nCount2 = me.GetItemCountInBags(18,1,26000,1);
	if nCount1 >= 1 and nCount2 >= 500 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 500);
	me.AddItem(1,15,17,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>[Trận Pháp]Bát Quái Trận +5<color> ");
		 			local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>[Trận Pháp]Bát Quái Trận +5<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>[Trận Pháp]Bát Quái Trận +4<color> và 500 Mảnh Trận Pháp hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:tranphap6()
	local tbItemId1 = {1,15,17,10,0,0}; -- mat na 2
	local tbItemId2 = {18,1,26000,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,15,17,10);
	local nCount2 = me.GetItemCountInBags(18,1,26000,1);
	if nCount1 >= 1 and nCount2 >= 600 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 600);
	me.AddItem(1,15,18,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>[Trận Pháp]Bát Quái Trận +6<color> ");
		 			local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>[Trận Pháp]Bát Quái Trận +6<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>[Trận Pháp]Bát Quái Trận +5<color> và 600 Mảnh Trận Pháp hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:tranphap7()
	local tbItemId1 = {1,15,18,10,0,0}; -- mat na 2
	local tbItemId2 = {18,1,26000,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,15,18,10);
	local nCount2 = me.GetItemCountInBags(18,1,26000,1);
	if nCount1 >= 1 and nCount2 >= 700 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 700);
	me.AddItem(1,15,19,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>[Trận Pháp]Bát Quái Trận +7<color> ");
		 			local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>[Trận Pháp]Bát Quái Trận +7<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>[Trận Pháp]Bát Quái Trận +6<color> và 700 Mảnh Trận Pháp hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:tranphap8()
	local tbItemId1 = {1,15,19,10,0,0}; -- mat na 2
	local tbItemId2 = {18,1,26000,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,15,19,10);
	local nCount2 = me.GetItemCountInBags(18,1,26000,1);
	if nCount1 >= 1 and nCount2 >= 800 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 800);
	me.AddItem(1,15,20,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>[Trận Pháp]Bát Quái Trận +8<color> ");
		 			local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>[Trận Pháp]Bát Quái Trận +8<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>[Trận Pháp]Bát Quái Trận +7<color> và 800 Mảnh Trận Pháp hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:tranphap9()
	local tbItemId1 = {1,15,20,10,0,0}; -- mat na 2
	local tbItemId2 = {18,1,26000,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,15,20,10);
	local nCount2 = me.GetItemCountInBags(18,1,26000,1);
	if nCount1 >= 1 and nCount2 >= 900 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 900);
	me.AddItem(1,15,21,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>[Trận Pháp]Bát Quái Trận +9<color> ");
		 			local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>[Trận Pháp]Bát Quái Trận +9<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>[Trận Pháp]Bát Quái Trận +8<color> và 900 Mảnh Trận Pháp hãy đến tìm ta .");
	end
end
function tbSuKienKiemThe:tranphap10()
	local tbItemId1 = {1,15,21,10,0,0}; -- mat na 2
	local tbItemId2 = {18,1,26000,1,0,0}; -- dtv
	local nCount1 = me.GetItemCountInBags(1,15,21,10);
	local nCount2 = me.GetItemCountInBags(18,1,26000,1);
	if nCount1 >= 1 and nCount2 >= 1000 then
	Task:DelItem(me, tbItemId1, 1);
	Task:DelItem(me, tbItemId2, 1000);
	me.AddItem(1,15,22,10);
		 Dialog:Say(" Chúc mừng bạn nhận được 1 <color=yellow>[Trận Pháp]Bát Quái Trận +10<color> ");
		 			local szMsg = string.format("Người chơi <color=blue>"..me.szName.."<color> nâng cấp thành công <color=red>[Trận Pháp]Bát Quái Trận +10<color> thật bá đạo !");
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, szMsg);
	self:BroadCast(szMsg);

		else
		Dialog:Say(" Khi nào đủ 1 <color=yellow>[Trận Pháp]Bát Quái Trận +9<color> và 1000 Mảnh Trận Pháp hãy đến tìm ta .");
	end
end