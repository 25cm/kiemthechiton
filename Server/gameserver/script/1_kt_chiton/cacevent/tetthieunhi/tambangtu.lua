local tbTamBangTu = Npc:GetClass("thk_tambangtu");
tbTamBangTu.tbItemInfo = {
        bForceBind=1,
};
function tbTamBangTu:OnDialog()
DoScript("\\script\\event\\cacevent\\tetthieunhi\\tambangtu.lua");
local msg = "<color=cyan>Tam Bạng Tử<color> xin chào "..me.szName.." !"
local tbOpt = { 
{"Hoạt Động <color=gold>Tết Thiếu Nhi<color>",self.Event16,self};
{"Hoạt Động <color=gold>Giải Cứu Bé Bánh Bao<color>",self.Event_GCBBB,self};
}; 
Dialog:Say(msg, tbOpt);
end
function tbTamBangTu:Event16()
local nCount1 = me.GetItemCountInBags(18,1,2077,1) -- Đá Bào
local nCount2 = me.GetItemCountInBags(18,10,11,2) -- Tiền Xu
local nCount3 = me.GetItemCountInBags(18,1,2079,1) -- Siro Nguyên Chất
local szMsg = "<color=green>Công thức<color>\n"..
"5 <color=yellow>Đá Bào<color> + 2 <color=yellow>Tiền Xu<color> = 1 <color=yellow>Siro Ngũ Sắc<color>\n"..
"5 <color=yellow>Đá Bào<color> + 1 <color=yellow>Siro Nguyên Chất<color> + 1 Tiền Xu = 1 <color=yellow>Que Kem Cầu Vồng<color>\n"..
"<color=green>Nguyên Liệu Của Ngươi Có<color>\n"..
"<color=yellow>Đá Bào<color>: <color=green>"..nCount1.."<color>\n"..
"<color=yellow>Tiền Xu<color>: <color=green>"..nCount2.."<color>\n"..
"<color=yellow>Siro Nguyên Chất<color>: <color=green>"..nCount3.."<color>\n"..
"\n<color=green>Đá Bào<color> và <color=green>Siro Nguyên Chất<color> nhặt khi tiêu diệt quái > 115" 
local tbOpt = { 
{"Chế Biến <color=yellow>Siro Ngũ Sắc<color>",self.Lam_SiroNguSac,self};
{"Chế Biến <color=yellow>Que Kem Cầu Vồng<color>",self.Lam_QueKemCauVong,self};
}; 
Dialog:Say(szMsg, tbOpt);
end
function tbTamBangTu:Lam_QueKemCauVong()
if me.CountFreeBagCell() < 10 then
		Dialog:Say("Phải Có 10 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local tbItemId1	= {18,1,2077,1,0,0}; -- Đá Bào 
local tbItemId2	= {18,1,2079,1,0,0}; -- Siro Nguyên Chất
local tbItemId3	= {18,10,11,2,0,0}; -- Tiền Xu 
local nCount1 = me.GetItemCountInBags(18,1,2077,1) -- Đá Bào
local nCount2 = me.GetItemCountInBags(18,1,2079,1) -- Siro Nguyên Chất
local nCount3 = me.GetItemCountInBags(18,10,11,2) -- Tiền Xu
if nCount1 < 5 or nCount2 < 2 or nCount3 < 1 then -- Check Đá Bào < 5 hoặc Siro Nguyên Chất < 1
Dialog:Say("<color=green>Công Thức<color>\n5 <color=yellow>Đá Bào<color> + 1 <color=yellow>Siro Nguyên Chất<color> + 1 <color=yellow>Tiền Xu<color> = 1 <color=yellow>Que Kem Cầu Vồng<color>\n<color=green>\n\nNguyên Liệu Của Ngươi<color>\n<color=yellow>Đá Bào<color> <color=green>"..nCount1.."<color>\n<color=yellow>Siro Nguyên Chất<color> <color=green>"..nCount2.."<color>")
return
end
me.AddItem(18,1,2081,1) -- Add 1 Que Kem Cầu Vồng
me.Msg("<color=yellow>Chế Biến thành công 1 Que Kem Cầu Vồng<color>")
Task:DelItem(me, tbItemId1, 5); -- Xóa 5 Item Đá Bào
Task:DelItem(me, tbItemId2, 1); -- Xóa 1 Item Siro Nguyên Chất
Task:DelItem(me, tbItemId3, 1); -- Xóa 1 Item Siro Nguyên Chất
end
function tbTamBangTu:Lam_SiroNguSac()
if me.CountFreeBagCell() < 10 then
		Dialog:Say("Phải Có 10 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local tbItemId1	= {18,1,2077,1,0,0}; -- Đá Bào 
local tbItemId2	= {18,10,11,2,0,0}; -- Tiền Xu 
local nCount1 = me.GetItemCountInBags(18,1,2077,1) -- Đá Bào
local nCount2 = me.GetItemCountInBags(18,10,11,2) -- Tiền Xu
if nCount1 < 5 or nCount2 < 2 then -- Check Đá Bào < 5 hoặc Tiền Xu < 2
Dialog:Say("<color=green>Công Thức<color>\n5 <color=yellow>Đá Bào<color> + 2 <color=yellow>Tiền Xu<color> = 1 <color=yellow>Siro Ngũ Sắc<color>\n\n<color=green>Nguyên Liệu Của Ngươi<color> \n<color=yellow>Đá Bào<color> <color=green>"..nCount1.."<color>\n<color=yellow>Tiền Xu<color> <color=green>"..nCount2.."<color>")
return
end
me.AddItem(18,1,2080,1) -- Add 1 Siro Ngũ Sắc
me.Msg("<color=yellow>Chế Biến thành công 1 Siro Ngũ Sắc<color>")
Task:DelItem(me, tbItemId1, 5); -- Xóa 5 Item Đá Bào
Task:DelItem(me, tbItemId2, 2); -- Xóa 2 Item Tiền Xu
end
function tbTamBangTu:Event_GCBBB()
DoScript("\\script\\event\\cacevent\\tetthieunhi\\tambangtu.lua");
local msg = "<color=cyan>Tam Bạng Tử<color> xin chào "..me.szName.." !"
local tbOpt = { 
{"Làm <color=green>Bánh Ngọc Bích<color>",self.Create_BanhNgocBich,self};
{"Làm <color=red>Bánh Hồng Ngọc<color>",self.Create_BanhHongNgoc,self};
{"Làm <color=gold>Bánh Pha Lê<color>",self.Create_BanhPhaLe,self};
}; 
Dialog:Say(msg, tbOpt);
end
function tbTamBangTu:Create_BanhNgocBich()
local nCount1 = me.GetItemCountInBags(18,1,2083,1) -- Nhân Bánh Ngọc Bích
local nCount2 = me.GetItemCountInBags(18,1,2084,1) -- Lá Gói Bánh Ngọc Bích
local msg = "                    <color=green>Bánh Ngọc Bích<color>\n"..
"<pic=126><color=cyan>Công Thức<color>\n"..
"1 <color=green>Nhân Bánh Ngọc Bích<color>\n5 <color=green>Lá Gói Bánh Ngọc Bích<color>\n"..
"\n<pic=126><color=cyan>Nguyên Liệu Hiện Có<color>\n"..
"<color=green>Nhân Bánh Ngọc Bích<color>: "..nCount1.."\n"..
"<color=green>Lá Gói Bánh Ngọc Bích<color>: "..nCount2..""
local tbOpt = { 
{"Làm <color=green>Bánh Ngọc Bích<color>",self.Create_BanhNgocBich_OK_1,self};
}; 
Dialog:Say(msg, tbOpt);
end
function tbTamBangTu:Create_BanhNgocBich_OK_1()
local tbItemId1	= {18,1,2083,1,0,0}; -- Nhân Bánh Ngọc Bích
local tbItemId2	= {18,1,2084,1,0,0}; -- Lá Gói Bánh Ngọc Bích
local nCount1 = me.GetItemCountInBags(18,1,2083,1) -- Nhân Bánh Ngọc Bích
local nCount2 = me.GetItemCountInBags(18,1,2084,1) -- Lá Gói Bánh Ngọc Bích
local msg = "                    <color=green>Bánh Ngọc Bích<color>\n"..
"<pic=126><color=cyan>Công Thức<color>\n"..
"1 <color=green>Nhân Bánh Ngọc Bích<color>\n5 <color=green>Lá Gói Bánh Ngọc Bích<color>\n"..
"\n<pic=126><color=cyan>Nguyên Liệu Hiện Có<color>\n"..
"<color=green>Nhân Bánh Ngọc Bích<color> <color=red>"..nCount1.."<color>/1\n"..
"<color=green>Lá Gói Bánh Ngọc Bích<color> <color=red>"..nCount2.."<color>/5"
if nCount1 < 1 or nCount2 < 5 then
Dialog:Say(msg)
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
    GeneralProcess:StartProcess("Đang Làm Bánh", 2 * Env.GAME_FPS, {self.Create_BanhNgocBich_OK, self, me.nId, him.dwId}, nil, tbEvent);

	};
end
function tbTamBangTu:Create_BanhNgocBich_OK()
if me.CountFreeBagCell() < 5 then
		Dialog:Say("Phải Có 5 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local tbItemId1	= {18,1,2083,1,0,0}; -- Nhân Bánh Ngọc Bích
local tbItemId2	= {18,1,2084,1,0,0}; -- Lá Gói Bánh Ngọc Bích
local nCount1 = me.GetItemCountInBags(18,1,2083,1) -- Nhân Bánh Ngọc Bích
local nCount2 = me.GetItemCountInBags(18,1,2084,1) -- Lá Gói Bánh Ngọc Bích
me.AddStackItem(18,1,2085,1,self.tbItemInfo,1)
Task:DelItem(me, tbItemId1, 1);
Task:DelItem(me, tbItemId2, 5);
end

--------------------------------
function tbTamBangTu:Create_BanhHongNgoc()
local nCount1 = me.GetItemCountInBags(18,1,2086,1) -- <color=red>Nhân Bánh Hồng Ngọc<color>
local nCount2 = me.GetItemCountInBags(18,1,2087,1) -- <color=red>Lá Gói Bánh Hồng Ngọc<color>
local msg = "                    <color=red>Bánh Hồng Ngọc<color>\n"..
"<pic=126><color=cyan>Công Thức<color>\n"..
"1 <color=red>Nhân Bánh Hồng Ngọc<color>\n5 <color=red>Lá Gói Bánh Hồng Ngọc<color>\n"..
"\n<pic=126><color=cyan>Nguyên Liệu Hiện Có<color>\n"..
"<color=red>Nhân Bánh Hồng Ngọc<color>: "..nCount1.."\n"..
"<color=red>Lá Gói Bánh Hồng Ngọc<color>: "..nCount2..""
local tbOpt = { 
{"Làm <color=red>Bánh Hồng Ngọc<color>",self.Create_BanhHongNgoc_OK_1,self};
}; 
Dialog:Say(msg, tbOpt);
end
function tbTamBangTu:Create_BanhHongNgoc_OK_1()
local tbItemId1	= {18,1,2086,1,0,0}; -- <color=red>Nhân Bánh Hồng Ngọc<color>
local tbItemId2	= {18,1,2087,1,0,0}; -- <color=red>Lá Gói Bánh Hồng Ngọc<color>
local nCount1 = me.GetItemCountInBags(18,1,2086,1) -- <color=red>Nhân Bánh Hồng Ngọc<color>
local nCount2 = me.GetItemCountInBags(18,1,2087,1) -- <color=red>Lá Gói Bánh Hồng Ngọc<color>
local msg = "                    <color=red>Bánh Hồng Ngọc<color>\n"..
"<pic=126><color=cyan>Công Thức<color>\n"..
"1 <color=red>Nhân Bánh Hồng Ngọc<color>\n5 <color=red>Lá Gói Bánh Hồng Ngọc<color>\n"..
"\n<pic=126><color=cyan>Nguyên Liệu Hiện Có<color>\n"..
"<color=red>Nhân Bánh Hồng Ngọc<color> <color=red>"..nCount1.."<color>/1\n"..
"<color=red>Lá Gói Bánh Hồng Ngọc<color> <color=red>"..nCount2.."<color>/5"
if nCount1 < 1 or nCount2 < 5 then
Dialog:Say(msg)
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
    GeneralProcess:StartProcess("Đang Làm Bánh", 2 * Env.GAME_FPS, {self.Create_BanhHongNgoc_OK, self, me.nId, him.dwId}, nil, tbEvent);

	};
end
function tbTamBangTu:Create_BanhHongNgoc_OK()
if me.CountFreeBagCell() < 5 then
		Dialog:Say("Phải Có 5 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local tbItemId1	= {18,1,2086,1,0,0}; -- <color=red>Nhân Bánh Hồng Ngọc<color>
local tbItemId2	= {18,1,2087,1,0,0}; -- <color=red>Lá Gói Bánh Hồng Ngọc<color>
local nCount1 = me.GetItemCountInBags(18,1,2086,1) -- <color=red>Nhân Bánh Hồng Ngọc<color>
local nCount2 = me.GetItemCountInBags(18,1,2087,1) -- <color=red>Lá Gói Bánh Hồng Ngọc<color>
me.AddStackItem(18,1,2088,1,self.tbItemInfo,1)
Task:DelItem(me, tbItemId1, 1);
Task:DelItem(me, tbItemId2, 5);
end

------------ La Pha Le -----------------
function tbTamBangTu:Create_BanhPhaLe()
local nCount1 = me.GetItemCountInBags(18,1,2089,1) -- <color=red>Nhân Bánh Hồng Ngọc<color>
local nCount2 = me.GetItemCountInBags(18,1,2090,1) -- <color=gold>Lá Gói Bánh Pha Lê<color>
local msg = "                    <color=gold>Bánh Pha Lê<color>\n"..
"<pic=126><color=cyan>Công Thức<color>\n"..
"1 <color=red>Nhân Bánh Hồng Ngọc<color>\n5 <color=gold>Lá Gói Bánh Pha Lê<color>\n"..
"\n<pic=126><color=cyan>Nguyên Liệu Hiện Có<color>\n"..
"<color=gold>Nhân Bánh Pha Lê<color>: "..nCount1.."\n"..
"<color=gold>Lá Gói Bánh Pha Lê<color>: "..nCount2..""
local tbOpt = { 
{"Làm <color=gold>Bánh Pha Lê<color>",self.Create_BanhPhaLe_OK_1,self};
}; 
Dialog:Say(msg, tbOpt);
end
function tbTamBangTu:Create_BanhPhaLe_OK_1()
local tbItemId1	= {18,1,2089,1,0,0}; -- <color=gold>Nhân Bánh Pha Lê<color>
local tbItemId2	= {18,1,2090,1,0,0}; -- <color=gold>Lá Gói Bánh Pha Lê<color>
local nCount1 = me.GetItemCountInBags(18,1,2089,1) -- <color=gold>Nhân Bánh Pha Lê<color>
local nCount2 = me.GetItemCountInBags(18,1,2090,1) -- <color=gold>Lá Gói Bánh Pha Lê<color>
local msg = "                    <color=gold>Bánh Pha Lê<color>\n"..
"<pic=126><color=cyan>Công Thức<color>\n"..
"1 <color=gold>Nhân Bánh Pha Lê<color>\n5 <color=gold>Lá Gói Bánh Pha Lê<color>\n"..
"\n<pic=126><color=cyan>Nguyên Liệu Hiện Có<color>\n"..
"<color=gold>Nhân Bánh Pha Lê<color> <color=red>"..nCount1.."<color>/1\n"..
"<color=gold>Lá Gói Bánh Pha Lê<color> <color=red>"..nCount2.."<color>/5"
if nCount1 < 1 or nCount2 < 5 then
Dialog:Say(msg)
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
    GeneralProcess:StartProcess("Đang Làm Bánh", 2 * Env.GAME_FPS, {self.Create_BanhPhaLe_OK, self, me.nId, him.dwId}, nil, tbEvent);

	};
end
function tbTamBangTu:Create_BanhPhaLe_OK()
if me.CountFreeBagCell() < 5 then
		Dialog:Say("Phải Có 5 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local tbItemId1	= {18,1,2089,1,0,0}; -- <color=gold>Nhân Bánh Pha Lê<color>
local tbItemId2	= {18,1,2090,1,0,0}; -- <color=red>Lá Gói Bánh Hồng Ngọc<color>
local nCount1 = me.GetItemCountInBags(18,1,2089,1) -- <color=gold>Nhân Bánh Pha Lê<color>
local nCount2 = me.GetItemCountInBags(18,1,2090,1) -- <color=red>Lá Gói Bánh Hồng Ngọc<color>
me.AddStackItem(18,1,2091,1,self.tbItemInfo,1)
Task:DelItem(me, tbItemId1, 1);
Task:DelItem(me, tbItemId2, 5);
end