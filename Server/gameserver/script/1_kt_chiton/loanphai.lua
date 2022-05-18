local tbloanphai = Npc:GetClass("loanphai");
function tbloanphai:OnDialog()
local tbOpt =
	{	
   		{"Kết thúc đối thoại"}
	}

	--table.insert(tbOpt, 1, {"<pic=135>Vào xem Liên Đấu<color=green>Lôi Đài 4<color>", self.loidai13, self});	
	--table.insert(tbOpt, 1, {"<pic=135>Vào xem Liên Đấu<color=green>Lôi Đài 3<color>", self.loidai12, self});	
	--table.insert(tbOpt, 1, {"<pic=135>Vào xem Liên Đấu<color=green>Lôi Đài 2<color>", self.loidai11, self});
	--table.insert(tbOpt, 1, {"<pic=135>Vào xem Liên Đấu<color=green>Lôi Đài 1<color>", self.loidai10, self});
	table.insert(tbOpt, 1, {"<pic=135>Vào <color=green>Lôi Đài Thi Đấu 6vs6<color>", self.loidai3, self});
	table.insert(tbOpt, 1, {"<pic=135>Vào <color=green>Lôi Đài Thi Đấu 3vs3<color>", self.loidai2, self});
    table.insert(tbOpt, 1, {"<pic=135>Vào <color=green>Lôi Đài Thi Đấu 1vs1<color>", self.loidai1, self});
	table.insert(tbOpt, 1, {"<pic=135>Vào <color=green>Tẩy Tủy Đảo Sơn Động<color>", self.loidai5, self});
	table.insert(tbOpt, 1, {"<pic=135>Cửa Hàng <color=gold>Vũ Khí Tần Lăng<color>",self.shopvktl,self});
	table.insert(tbOpt, 1, {"<pic=135>Chức Năng <color=yellow>Tiêu hủy nhiều đạo cụ", self.DatVaoVPTieuHuy, self});
	table.insert(tbOpt, 1, {"<pic=135>Map <color=gold>Di Chuyển Nhanh<color>", self.dichuyennhanh, self});
	table.insert(tbOpt, 1, {"<pic=135>Vào <color=yellow>Thi Đấu Loạn Phái<color>", "Npc.tbMenPaiNpc:FactionDialog", Npc.tbMenPaiNpc.DialogMaster});
if me.nFaction == 0 then
	table.insert(tbOpt, 1, {"<pic=135> <color=red>Gia Nhập Môn Phái<color>", "Npc.tbMenPaiNpc:FactionDialog", Npc.tbMenPaiNpc.DialogMaster});
	else
    table.insert(tbOpt, 1, {"<pic=135> <color=red>Chọn Môn Phái Muốn Đối Thoại<color>", "Npc.tbMenPaiNpc:FactionDialog", Npc.tbMenPaiNpc.DialogMaster});	
	end
	Dialog:Say("<color=yellow>Thi Đấu Loạn Phái<color> 1 Trận /1 Ngày. Diễn ra vào lúc: <color=green>20h30 hàng ngày<color>, bắt đầu báo danh lúc: <color=green>20h<color> tại <color=red>NPC Hỗ Trợ Tân Thủ <color> tại <color=yellow>Đạo Hương Thôn<color>. Tối đa 3 Tài Khoản/ 1IP tham gia <color=yellow>Thi Đấu Loạn Phái<color>",tbOpt);
end;

function tbloanphai:tdlp()
me.NewWorld(241,1563,3392);
end;
function tbloanphai:loidai1()
me.NewWorld(93,1622,3324);
end;
function tbloanphai:loidai3()
me.NewWorld(105,1692,3224);
end;
function tbloanphai:loidai2()
me.NewWorld(57,1586,3205);
end;
function tbloanphai:loidai10()
me.NewWorld(1425,1615,3726);
end
function tbloanphai:loidai11()
me.NewWorld(1425,1670,3674);
end
function tbloanphai:loidai12()
me.NewWorld(1425,1727,3618);
end
function tbloanphai:loidai13()
me.NewWorld(1425,1780,3566);
end
function tbloanphai:loidai5()
	me.NewWorld(256,1582,3199);
end

function tbloanphai:dichuyennhanh()
local szMsg = "Thành Chính:<color=yellow>Đạo Hương Thôn <color>";
local tbOpt = {
			--{"[Map] <color=yellow>Đạo Hương Thôn <color>", self.dht, self},
			{"[Map] <color=yellow>Tần Lăng 3<color>",self.tl3,self};
			{"[Map] <color=yellow>Bạch Hổ Đường<color>",self.bhd,self};
			{"[Map] <color=yellow>Tiêu Dao Cốc<color>",self.tdc,self};
			{"[Map] <color=yellow>Quân Doanh<color>",self.qd,self};			
			{"[Map mở phó bản] <color=yellow>Vạn Hoa Cốc<color>",self.vhc,self};
			{"[Map mở phó bản] <color=yellow>Thiên Quỳnh Cung<color>",self.tqc,self};
			{"[Map mở phó bản] <color=yellow>Đại Mạc Cổ Thành<color>",self.dmct,self};
			{"[Map mở phó bản] <color=yellow>Bách Niên Thiên Nao<color>",self.bntn,self};
			{"[Map mở phó bản] <color=yellow>Đào Chu Công Nghi Chủng<color>",self.daomo,self};
			--{"[Map mở phó bản] <color=yellow>Cho Lên Đảo 24H<color>",self.nguc,self};
};
Dialog:Say(szMsg, tbOpt);
end
function tbloanphai:bhd()
me.NewWorld(233,1617,3179);
end;
function tbloanphai:tdc()
me.NewWorld(341,1625,3182);
end;
function tbloanphai:qd()
me.NewWorld(556,1603,3203);
end;
function tbloanphai:dht()
me.NewWorld(4,1616,3244);
end;

function tbloanphai:tl3()
me.NewWorld(1538,1776,3189);
end;
function tbloanphai:tl4()
me.NewWorld(1539,1932,3793);
end;
function tbloanphai:vhc()
me.NewWorld(30,1623,4041);
end;
function tbloanphai:tqc()
me.NewWorld(39,2035,3252);
end;
function tbloanphai:dmct()
me.NewWorld(94,1778,3925);
end;
function tbloanphai:daomo()
me.NewWorld(35,2014,3975);
end;
function tbloanphai:bntn()
me.NewWorld(31,2022,3558);
end;
function tbloanphai:nguc()
me.NewWorld(568,1604,3234);
end;

function tbloanphai:DatVaoVPTieuHuy()
Dialog:OpenGift("Hãy đặt vào", nil ,{self.OnOpenGiftOkTieuHuyItem, self});
end
function tbloanphai:OnOpenGiftOkTieuHuyItem(tbGiftObj)
	for _, pItem in pairs(tbGiftObj) do
		if me.DelItem(pItem[1]) ~= 1 then
			return 0;
		end
	end
end
function tbloanphai:shopvktl()
local szMsg = "Chọn Shop cần mở:";
local tbOpt = {
        {"Hòa Thị Bích đổi <color=yellow>Thanh Đồng Luyện Phổ<color>", self.ChangeRefine, self}, 
		{"Danh Vọng đổi <color=yellow>Thanh Đồng Luyện Phổ<color>", self.OnChangeReputeToRefine, self},
		{"Shop Vũ Khí Hệ <color=yellow>Kim<color>",self.Svukhi1,self};
		{"Shop Vũ Khí Hệ <color=green>Mộc<color>",self.Svukhi2,self};
		{"Shop Vũ Khí Hệ <color=blue>Thủy<color>",self.Svukhi3,self};
		{"Shop Vũ Khí Hệ <color=red>Hỏa<color>",self.Svukhi4,self};
		{"Shop Vũ Khí Hệ <color=gold>Thổ<color>",self.Svukhi5,self};
};
Dialog:Say(szMsg, tbOpt);
end
function tbloanphai:Svukhi1()
me.OpenShop(156, 1);
end

function tbloanphai:Svukhi2()
me.OpenShop(157, 1);
end

function tbloanphai:Svukhi3()
me.OpenShop(158, 1);
end

function tbloanphai:Svukhi4()
me.OpenShop(159, 1);
end

function tbloanphai:Svukhi5()
me.OpenShop(160, 1);
end
function tbloanphai:ChangeRefine()
	local tbParam = 
	{
		tbAward = {{nGenre = 18, nDetail = 2, nParticular = 385, nLevel = 1, nCount = 1, nBind=1}},
		tbMareial = {{nGenre = 18, nDetail = 1, nParticular = 377, nLevel = 1, nCount = 5}},
	};
	Dialog:OpenGift("Đặt vào 5 Hòa Thị Bích có thể đổi 1 Luyên Hóa Đồ Phổ", tbParam);
end

function tbloanphai:OnChangeReputeToRefine()
	Dialog:Say("Ngươi muốn dùng <color=yellow>500 điểm Danh Vọng – Phát Khâu Môn<color> đổi Thanh Đồng Luyện Phổ cấp 110 chứ? <color=yellow>Chỉ có thể giảm điểm trong cấp danh vọng hiện tại.<color>",
		{
			{"Vâng", self.ChangeReputeToRefine, self},
			{"Không"},
		}
		);
end

function tbloanphai:ChangeReputeToRefine()
	local nDelRepute	= 500;
	local nRepute		= me.GetReputeValue(9,2);
	local nLevel		= me.GetReputeLevel(9,2);
	if (nDelRepute > nRepute) then
		Dialog:Say("Cấp Danh Vọng – Phát Khâu Môn hiện tại không đủ để giảm <color=yellow>500 điểm<color>!");
		return;
	end

	if (me.CountFreeBagCell() < 1) then
		Dialog:Say("Hành trang không đủ chỗ trống, không thể đổi Vũ Khí Thanh Đồng Luyện Hóa Đồ.");
		return;
	end	
	
	me.AddRepute(9, 2, -1*nDelRepute);
	local nNowRepute	= me.GetReputeValue(9,2);
	local nNowLevel		= me.GetReputeLevel(9,2);
	local szLog = string.format("%s delete %d repute, last Repute: %d, Level: %d, now Repute: %d, level: %d!!", me.szName, nDelRepute, nRepute, nLevel, nNowRepute, nNowLevel);
	Dbg:WriteLogEx(Dbg.LOG_INFO, "Qinshihuang", "npc", "ChangeReputeToRefine", szLog);
	local pItem			= me.AddItem(18,2,385,1,1,1);
	if (not pItem) then
		Dbg:WriteLogEx(Dbg.LOG_INFO, "Qinshihuang", "ChangeReputeToRefine", string.format("%s get the item failed!", me.szName));
		return;
	end
	Dbg:WriteLogEx(Dbg.LOG_INFO, "Qinshihuang", "ChangeReputeToRefine", string.format("%s get the item success!", me.szName));
end