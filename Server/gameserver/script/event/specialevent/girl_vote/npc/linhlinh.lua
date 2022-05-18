
 local tbLiGuan = Npc:GetClass("linhlinh");

tbLiGuan.MAX_RECENTPLAYER	= 15;	-- 最近操作玩家列表
tbLiGuan.IDMatNa = 18;
tbLiGuan.TASK_GR_DO =	3008;
tbLiGuan.TASK_ID_nGenre	=	1;
tbLiGuan.TASK_ID_nDetail = 2;
tbLiGuan.TASK_ID_nParticular	=	3;
tbLiGuan.TASK_ID_nLevel = 4;
tbLiGuan.TASK_ID_Giay = 5;
tbLiGuan.TASK_ID_Phut = 6;
tbLiGuan.TASK_ID_Gio = 7;
tbLiGuan.TASK_ID_Ngay = 8;
tbLiGuan.TASK_ID_SoLuong = 9;
tbLiGuan.TASK_ID_CAPDO = 10;
tbLiGuan.tbRemoteList	= {};	-- 全服玩家列表，每次开主菜单刷新
tbLiGuan.TaskGourp = 9999;
tbLiGuan.TaskId_Key = 1;
tbLiGuan.TaskGourp_CS = 8888;
tbLiGuan.TaskId_Count_CS = 1;
tbLiGuan.TaskId_Flag_CS = 2;
tbLiGuan.tbItemInfo = {
bForceBind=0,
};
tbLiGuan.TaskId_Count = 1;
tbLiGuan.TASK_GROUP_ID1 = 3010;
SpecialEvent.Topplayer = SpecialEvent.Topplayer ;
local Topplayer = SpecialEvent.Topplayer ;
function tbLiGuan:OnUse()
DoScript("\\script\\event\\cacevent\\renbinhkhigiapvatrangsuc\\tanglaodai.lua");

DoScript("\\script\\event\\cacevent\\tetthieunhi\\tambangtu.lua");
DoScript("\\script\\event\\cacevent\\cauca\\cuoc.lua");
DoScript("\\script\\event\\cacevent\\cauca\\hopdungca.lua");
DoScript("\\script\\event\\cacevent\\cauca\\cancau.lua");
DoScript("\\script\\event\\cacevent\\vip\\lenhbaichungminhvip.lua");
DoScript("\\script\\item\\class\\admincard.lua"); -- duong dan de reload file
DoScript("\\script\\event\\minievent\\newplayergift.lua"); -- duong dan de reload file
DoScript("\\script\\NguyenHoPhuc87\\daygift.lua");
DoScript("\\script\\NguyenHoPhuc87\\hethongvip.lua");
DoScript("\\script\\event\\cacevent\\batca\\vuahung.lua");
DoScript("\\script\\event\\cacevent\\batca\\binhthuytinh.lua");
DoScript("\\script\\NguyenHoPhuc87\\hotrotanthu.lua");
DoScript("\\script\\baibaoxiang\\item\\jinxiangzi.lua");
DoScript("\\script\\task\\tmptasknpc.lua");
DoScript("\\script\\task\\treasuremap\\npc\\entrancenpc.lua");
DoScript("\\script\\mission\\battle\\battle_bouns.lua");
DoScript("\\script\\item\\class\\gradediamonds.lua");
DoScript("\\script\\item\\class\\randomitem.lua");
	DoScript("\\script\\item\\class\\tuiquatrangbi.lua");
	DoScript("\\script\\boss\\qinshihuang\\map\\qinshihuangling_5.lua");
	DoScript("\\script\\event\\cacevent\\denhung\\hopquavuahung.lua");
	DoScript("\\script\\item\\class\\gmcard.lua");
	DoScript("\\script\\event\\cacevent\\cuopluongthao\\dach14.lua");
	DoScript("\\script\\event\\cacevent\\cuopluongthao\\dach15.lua");
	DoScript("\\script\\event\\cacevent\\cuopluongthao\\dach16.lua");
	DoScript("\\script\\npc\\basesetting.lua");
	DoScript("\\script\\event\\jieri\\200903_zhishujie\\logic.lua");
	DoScript("\\script\\item\\class\\gmcard.lua");
	DoScript("\\script\\item\\class\\eventpn.lua");
	DoScript("\\script\\item\\class\\eventpresent.lua");
	DoScript("\\script\\fightskill\\faction\\daliduanshi.lua")
	DoScript("\\script\\domainbattle\\npc\\chaotingyushi.lua")
	DoScript("\\script\\tong\\tonglogic_gs.lua")
	DoScript("\\script\\kin\\kinlogic_gs.lua")
	DoScript("\\script\\event\\jieri\\200903_zhishujie\\logic.lua")
	DoScript("\\script\\tong\\tonglogic.lua")
	DoScript("\\script\\event\\jieri\\playertop\\playertop_item.lua")
	DoScript("\\script\\event\\jieri\\playertop\\playertop_def.lua")
	DoScript("\\script\\boss\\qinshihuang\\npc\\boss_hoakylan.lua")
	DoScript("\\script\\event\\cacevent\\tetthieunhi\\hoakylan_dialog.lua");
	DoScript("\\script\\event\\cacevent\\tetthieunhi\\lamkylan_dialog.lua");
	DoScript("\\script\\event\\cacevent\\tetthieunhi\\hackylan_dialog.lua");
DoScript("\\script\\boss\\qinshihuang\\npc\\boss_lamkylan.lua")
DoScript("\\script\\boss\\qinshihuang\\npc\\boss_hackylan.lua")
DoScript("\\script\\event\\cacevent\\tetthieunhi\\item_bebanhbao.lua") -- Reload Siro Ngũ Sắc
DoScript("\\script\\event\\cacevent\\cauca\\thuongnhandacsan.lua");
DoScript("\\script\\npc\\taoyuanxiangdao.lua");
DoScript("\\script\\map\\taoyuanrukou\\taoyuanrukou.lua");
DoScript("\\script\\boss\\qinshihuang\\npc\\boss_hackylan.lua");
DoScript("\\script\\boss\\qinshihuang\\npc\\boss_hoakylan.lua");
DoScript("\\script\\boss\\qinshihuang\\npc\\boss_lamkylan.lua");
DoScript("\\script\\boss\\qinshihuang\\npc\\boss_bachyeu.lua");
DoScript("\\script\\pvp\\baihutang_def.lua");
DoScript("\\script\\event\\cacevent\\mongcosu\\mongcosu_dien.lua");
DoScript("\\script\\event\\cacevent\\mongcosu\\mongcosu_van.lua");
DoScript("\\script\\event\\cacevent\\mongcosu\\mongcosu_loi.lua");
DoScript("\\script\\event\\cacevent\\mongcosu\\mongcosu_nguyet.lua");
DoScript("\\script\\event\\cacevent\\mongcosu\\mongcosu_nhat.lua");
DoScript("\\script\\event\\youlongmibao\\item\\youlongge_happyegg.lua");
DoScript("\\script\\event\\cacevent\\mongcosu\\mongcosu_phong.lua");
	local nMapId, nPosX, nPosY = me.GetWorldPos();
	local nCount555 = me.GetTask(self.TASK_GROUP_ID1, self.TaskId_Count);
		local nMapId, nPosX, nPosY = me.GetWorldPos();
	-- local nState	= KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_ONLINESERVER);
	local sms = string.format("Tọa độ đang đứng là:<color=yellow> %d <color>-<color=green> %d <color>",nPosX*32,  nPosY*32);
	local sms1 = string.format("Tọa độ đang đứng là:<color=yellow> %d <color>-<color=green> %d <color>",nPosX,  nPosY);
	local sms2 = string.format("Tọa độ đang đứng là:<color=yellow> %d <color>-<color=green> %d <color>",nPosX/8,  nPosY/16);

	-- Dialog:Say(sms);
	for i=1 ,5 do
	local szMsg = "Vị trí hiện tại của bạn là :\n<color=red>Map<color>: "..GetMapNameFormId(nMapId).." \n<color=red>ID Map<color>: "..nMapId.."\n<color=red>Tọa Độ<color>: "..math.floor(nPosX/8).."/"..math.floor(nPosY/16).."\n"..sms.."\n"..sms1.."\n"..sms2.."";
	local tbOpt = {
		{"<color=yellow>Bỏ tất cả đạo cụ trong túi",me.ThrowAllItem},	
	};
	table.insert(tbOpt, 1,{"<color=yellow>Game Master - Administrator", self.lsGameMaster, self,});
	table.insert(tbOpt, 2,{"<color=yellow>Một Số Hàm Quan Trọng", self.SuDungCacHam, self,});
	table.insert(tbOpt, 3,{"<color=yellow>Thông Báo Thế Giới<color>",self.ThongBaoTheGioi,self,});
	table.insert(tbOpt, 4,{"<color=gold>Thông Báo Toàn Server<color>",self.ThongBaoToanServer,self,});
	table.insert(tbOpt, 5,{"<color=yellow>Sự Kiện<color>", self.CacSuKien1, self,});
	table.insert(tbOpt, 6,{"<color=yellow>Người Chơi Bên Cạnh", self.AroundPlayer, self,});
	table.insert(tbOpt, 7,{"<color=yellow>Chức năng Nâng Cao<color>", self.NangCao, self,});
	table.insert(tbOpt, 8,{"<color=gold>Đào Hoa Nguyên", self.LenDaoNguyen, self,});
	table.insert(tbOpt, 8,{"Nhận <color=Turquoise>Mặt Nạ<color>",self.NhanMatNaTanThu,self,});

	Dialog:Say(szMsg, tbOpt);
end;
end
function tbLiGuan:NhanMatNaTanThu()
Dialog:AskNumber("Nhập Số Mặt Nạ", 99, self.NhanMatNa123, self);
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
--
if szSoMatNa == 23 then
me.AddItem(1,13,172,1); -- [Mặt Nạ] Thời Trang Tân Thủ [22]
end
--
if szSoMatNa == 24 then
me.AddItem(1,13,173,1); -- [Mặt Nạ] Thời Trang Tân Thủ [22]
end
--
if szSoMatNa == 25 then
me.AddItem(1,13,174,1); -- [Mặt Nạ] Thời Trang Tân Thủ [22]
end
--
if szSoMatNa == 26 then
me.AddItem(1,13,175,1); -- [Mặt Nạ] Thời Trang Tân Thủ [22]
end
--
if szSoMatNa == 27 then
me.AddItem(1,13,176,1); -- [Mặt Nạ] Thời Trang Tân Thủ [22]
end
--
if szSoMatNa == 28 then
me.AddItem(1,13,177,1); -- [Mặt Nạ] Thời Trang Tân Thủ [22]
end
--
if szSoMatNa == 29 then
me.AddItem(1,13,178,1); -- [Mặt Nạ] Thời Trang Tân Thủ [22]
end
--
if szSoMatNa == 30 then
me.AddItem(1,13,179,1); -- [Mặt Nạ] Thời Trang Tân Thủ [22]
end
--
if szSoMatNa == 31 then
me.AddItem(1,13,180,1); -- [Mặt Nạ] Thời Trang Tân Thủ [22]
end
--
if szSoMatNa == 32 then
me.AddItem(1,13,181,1); -- [Mặt Nạ] Thời Trang Tân Thủ [22]
end
end
function tbLiGuan:LenDaoNguyen()
local szMsg = ""
local tbOpt = {
{"Lên <color=gold>Đào Hoa Nguyên 1<color>", me.NewWorld, 1497, 1626, 3187};
{"Lên <color=gold>Đào Hoa Nguyên 2<color>", me.NewWorld, 1498, 1626, 3187};
{"Lên <color=gold>Đào Hoa Nguyên 3<color>", me.NewWorld, 1499, 1626, 3187};
{"Lên <color=gold>Đào Hoa Nguyên 4<color>", me.NewWorld, 1500, 1626, 3187};
{"Lên <color=gold>Đào Hoa Nguyên 5<color>", me.NewWorld, 1501, 1626, 3187};
{"Lên <color=gold>Đào Hoa Nguyên 6<color>", me.NewWorld, 1502, 1626, 3187};
{"Lên <color=gold>Đào Hoa Nguyên 7<color>", me.NewWorld, 1503, 1626, 3187};
};
Dialog:Say(szMsg,tbOpt);
end
function tbLiGuan:SuDungCacHam()
local szMsg = ""
local tbOpt = {
    {"Xóa Task", self.XoaTaskCanThiet, self};
    {"Thêm Danh Hiệu", self.ThemDanhHieu, self};
	{"Thêm NPC", self.ThemNPC1, self};
	{"Xóa NPC", self.XoaNPC1, self};
	{"Thêm Vật Phẩm", self.ThemItem, self};
	{"Thêm Trang Bị", self.ThemTrangBi, self};
	{"Thử Kỹ Năng", self.TestThuSkill, self};
	{"Thêm Kỹ Năng", self.ThemKyNang, self};
	{"Xóa Kỹ Năng", self.XoaKyNang, self};
	{"Thử Nghiệm Pic", self.TestPic, self};
    {"Tăng Tốc Độ Đánh", self.TangTocDoDanh, self};

		};
		Dialog:Say(szMsg,tbOpt);
end
function tbLiGuan:XoaTaskCanThiet()
Dialog:AskNumber("Nhập ID Task",9999,self.TaskCanXoa_1,self, nTaskXoa);
end
function tbLiGuan:TaskCanXoa_1(nTaskXoa)
local nCount = me.GetTask(nTaskXoa, 1);
local Msg = "Hiện tại task <color=green>"..nTaskXoa.."<color> đang là <color=cyan>"..nCount.."<color>"
local tbOpt = {
    {"Xóa Hết", self.TaskCanXoa_2, self,nTaskXoa};
	};
	Dialog:Say(Msg,tbOpt);
end
function tbLiGuan:TaskCanXoa_2(nTaskXoa)
local nCount = me.GetTask(nTaskXoa, 1);
me.SetTask(nTaskXoa, 1, 0*nCount);
end

function tbLiGuan:ThemDanhHieu()
Dialog:AskNumber("Nhập Genre",999,self.DanhHieu_1,self, nGenreDH);
end
function tbLiGuan:DanhHieu_1(nGenreDH)
Dialog:AskNumber("Nhập DetailType",999,self.DanhHieu_2 ,self, nGenreDH, nDetaiDH);
end
function tbLiGuan:DanhHieu_2(nGenreDH, nDetaiDH)
Dialog:AskNumber("Nhập Id",999,self.DanhHieu_3 ,self, nGenreDH, nDetaiDH,nIdDH);
end
function tbLiGuan:DanhHieu_3(nGenreDH, nDetaiDH,nIdDH)
Dialog:AskNumber("Nhập Rank",999,self.DanhHieu_4 ,self, nGenreDH, nDetaiDH,nIdDH,nRankDH);
end
function tbLiGuan:DanhHieu_4(nGenreDH, nDetaiDH,nIdDH,nRankDH)
me.AddTitle(nGenreDH, nDetaiDH,nIdDH,nRankDH);
end













function tbLiGuan:TestTOP()
	for i=1 ,5 do
	if GetTotalLadderRankByName(Topplayer.nLadderType[i], me.szName)==1 then
			me.AddItem(18,1,2077,i);
			me.Msg("Bạn nhận được lệnh bài xây tượng".." <color=green>"..Topplayer.Name[i]);
			end
			end
end
function tbLiGuan:TangTocDoDanh()
local szMsg = "Vị trí hiện tại của bạn là "
local tbOpt = {
	{"Ngoại Công", self.SpeedNgoaiCong, self},
	{"Nội Công", self.SpeedNoiCong, self},
		};
		Dialog:Say(szMsg,tbOpt);
end
function tbLiGuan:SpeedNgoaiCong()
Dialog:AskNumber("Nhập Số", 54, self.SpeedNgoaiCong1, self);
end
function tbLiGuan:SpeedNgoaiCong1(szSpeedNgoaiCong)
me.AddFightSkill(37,szSpeedNgoaiCong) -- Đạt Ma Vũ Kinh (Thiếu Lâm Bổng)
me.AddFightSkill(28,szSpeedNgoaiCong) -- Hỗn Nguyên Nhất Khí (Thiếu Lâm Đao)
me.AddFightSkill(204,szSpeedNgoaiCong) -- Trấn Ngục Phá Thiên (Minh Giáo Chùy)
me.AddFightSkill(85,szSpeedNgoaiCong) -- Ngũ Độc Kỳ Kinh (Ngũ Độc Đao)
me.AddFightSkill(68,szSpeedNgoaiCong) -- Tâm Ma (Đường Môn Tụ Tiễn)
me.AddFightSkill(75,szSpeedNgoaiCong) -- Tâm Phách (Đường Môn Bẫy)
me.AddFightSkill(127,szSpeedNgoaiCong) -- Băng Cơ Ngọc Cốt (Thúy Yên Đao)
me.AddFightSkill(142,szSpeedNgoaiCong) -- Bôn Lưu Đáo Hải (Cái Bang Bổng)
me.AddFightSkill(105,szSpeedNgoaiCong) -- Phật Pháp Vô Biên (Thiên Nhẫn Thương)
me.AddFightSkill(174,szSpeedNgoaiCong) -- Kiếm Khí Tung Hoành (Võ Đang Kiếm)
me.AddFightSkill(183,szSpeedNgoaiCong) -- Thiên Thanh Địa Trọc (Côn Lôn Đao)
end
function tbLiGuan:SpeedNoiCong()
Dialog:AskNumber("Nhập Số", 54, self.SpeedNgoaiCong1, self);
end
function tbLiGuan:SpeedNoiCong1(szSpeedNoiCong)
me.AddFightSkill(212,szSpeedNgoaiCong) -- Ly Hỏa Đại Pháp (Minh Giáo Kiếm)
me.AddFightSkill(95,szSpeedNgoaiCong) -- Bách Cổ Độc Kinh (Ngũ Độc Chưởng)
me.AddFightSkill(233,szSpeedNgoaiCong) -- Thiên Long Thần Công (Đoàn Thị Kiếm)
me.AddFightSkill(105,szSpeedNgoaiCong) -- Phật Pháp Vô Biên (Nga Mi Chưởng)
me.AddFightSkill(119,szSpeedNgoaiCong) -- Băng Cốt Tuyết Tâm (Thúy Yên Kiếm)
me.AddFightSkill(136,szSpeedNgoaiCong) -- Tiềm Long Tại Uyên (Cái Bang CHưởng)
me.AddFightSkill(158,szSpeedNgoaiCong) -- Xí Không Ma Diệm (Thiên Nhẫn Đao)
me.AddFightSkill(166,szSpeedNgoaiCong) -- Thái Cực Vô Ý (Võ Đang Khí)
me.AddFightSkill(193,szSpeedNgoaiCong) -- Ngũ Lôi Chánh Pháp (Côn Lôn Kiếm)
end
function tbLiGuan:CacSuKien1()
local szMsg = "Vị trí hiện tại của bạn là "
local tbOpt = {
	{"Sự Kiện <color=yellow>Vang Dội Chiến Công<color>", self.VangDoiChienCong, self},
	{"Sự Kiện <color=yellow>Vớt Cá Mắc Cạn<color>", self.VotCaMacCan, self},
{"Sự Kiện <color=yellow>Đoạt Lương Thảo<color>", self.DoaLuongThao, self},
{"Sự Kiện <color=yellow>Đại Chiến Big Boss<color>", self.DaiChienBigBoss, self},
{"Sự Kiện <color=yellow>Rương Xuất Hiện<color>", self.RuongXuatHien, self},
{"Sự Kiện <color=yellow>Giải Cứu Bé Bánh Bao<color>", self.GiaiCuuBeBanhBao, self},
{"Sự Kiện <color=yellow>Oẳn Tù Tì<color>", self.EventOanTuTi, self},
{"Gọi NPC Hỗ Trợ", self.GoiHoTroDame, self},
{"Xóa NPC Hỗ Trợ", self.XoaHoTroDame, self},
{"Test", self.TestTask, self},
		};
		Dialog:Say(szMsg,tbOpt);
end
function tbLiGuan:EventOanTuTi()
local szMsg = "Mời <color=yellow>"..me.szName.."<color> chọn"
local tbOpt = {
{"Gọi NPC", self.Goi_NPC_THK_OK, self},
{"\n<pic=0> <color=green>", self.Chon_Keo, self},
{"\n<pic=1> <color=green>", self.Chon_Dam, self},
{"\n<pic=2> <color=green>", self.Chon_La, self},
};
Dialog:Say(szMsg,tbOpt);
end
function tbLiGuan:Goi_NPC_THK_OK()
-- local pNpc = KNpc.Add2(9627, 255, 0,1,1402,3078)
	-- pNpc.szName =	"Tăng Lão Đại";
	-- pNpc.SetTitle("<color=gold>Sự Kiện Oẳn Tù Tì<color>");
KDialog.MsgToGlobal("<color=yellow><color=cyan>Tăng Lão Đại<color> đã xuất hiện tại <pos=1,1398,3080><color=yellow> <color=green>[175/192: Vân Trung Trấn]<color> nhân sĩ <color=green>Đẳng Cấp Từ 130 - 140<color> mau tới <color=green>Oẳn Tù Tì<color> để giành lấy Kinh Nghiệm<color>");	   

end
function tbLiGuan:Chon_La()
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	

	nRand = MathRandom(1, 9);
	

	local tbRate = {3,3,3};
	local tbAward = {1,2,3};
	-- Nguoi choi dang chon La
	-- 1 la Keo
    -- 2 la Dam
	-- 3 la La
	for i = 1, 3 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
if (tbAward[nIndex]==1) then -- NPC Chon Keo - Member Chon La
me.Msg("Thua")
end
if (tbAward[nIndex]==2) then -- NPC Chon Dam - Member Chon La
me.Msg("Thắng")
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> Oẳn Tù Tì với <color=green>Thần Tài<color> giành chiến thắng nhận <color=green>2 Tiền Xu<color><color>");	   
end
if (tbAward[nIndex]==3) then -- NPC Chon La - Member Chon La
me.Msg("Hòa")
end
end
function tbLiGuan:Chon_Dam()
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	

	nRand = MathRandom(1, 9);
	

	local tbRate = {3,3,3};
	local tbAward = {1,2,3};
	-- Nguoi choi dang chon Dam
	-- 1 la Keo
    -- 2 la Dam
	-- 3 la La
	for i = 1, 3 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
if (tbAward[nIndex]==1) then -- NPC Chon Keo - Member Chon Dam
me.Msg("Thắng")
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> Oẳn Tù Tì với <color=green>Thần Tài<color> giành chiến thắng nhận <color=green>2 Tiền Xu<color><color>");	   
end
if (tbAward[nIndex]==2) then -- NPC Chon Dam - Member Chon Dam
me.Msg("Hòa")
end
if (tbAward[nIndex]==3) then -- NPC Chon La - Member Chon Dam
me.Msg("Thua")
end
end
function tbLiGuan:Chon_Keo()
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	

	nRand = MathRandom(1, 9);
	

	local tbRate = {3,3,3};
	local tbAward = {1,2,3};
	-- Nguoi choi dang chon Keo
	-- 1 la Keo
    -- 2 la Dam
	-- 3 la La
	for i = 1, 3 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
if (tbAward[nIndex]==1) then -- NPC Chon Keo - Member Chon Keo
me.Msg("Hòa")
end
if (tbAward[nIndex]==2) then -- NPC Chon Dam - Member Chon Keo
me.Msg("Thua")
end
if (tbAward[nIndex]==3) then -- NPC Chon La - Member Chon Keo
me.Msg("Thắng")
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> Oẳn Tù Tì với <color=green>Thần Tài<color> giành chiến thắng nhận <color=green>2 Tiền Xu<color><color>");	   
end
end
---------------------------
function tbLiGuan:XoaHoTroDame()
ClearMapNpcWithName(123, "Tăng Dame");
ClearMapNpcWithName(123, "Tăng Kháng");
ClearMapNpcWithName(123, "Tăng Máu");
--------------
ClearMapNpcWithName(132, "Tăng Dame");
ClearMapNpcWithName(132, "Tăng Kháng");
ClearMapNpcWithName(132, "Tăng Máu");
--------------
ClearMapNpcWithName(130, "Tăng Dame");
ClearMapNpcWithName(130, "Tăng Kháng");
ClearMapNpcWithName(130, "Tăng Máu");
end
function tbLiGuan:GoiHoTroDame()
local nMapId,nX,nY = me.GetWorldPos();
KDialog.MsgToGlobal("<color=yellow><color=green>Hỗ Trợ Dame - Máu - Kháng<color> xuất hiện tại <pos="..nMapId..","..nX..","..nY.."><color>");	
KNpc.Add2(20224, 1, 0, nMapId, nX, nY);
KNpc.Add2(20225, 1, 0, nMapId, nX+5 , nY-1);
KNpc.Add2(20226, 1, 0, nMapId, nX+10 , nY-2);
end
function tbLiGuan:GiaiCuuBeBanhBao()
local szMsg = "Vị trí hiện tại của bạn là "
local tbOpt = {
{"Thông Báo <color=yellow>Bé Bánh Bao<color>", self.ThongBao_BeBanhBao, self},
{"Gọi <color=yellow>Bé Bánh Bao<color>", self.Call_BeBanhBao, self},
{"Gọi <color=yellow>Bạch Yêu<color>", self.Call_BachYeu, self},
{"Di Chuyển <color=yellow>Bé Bánh Bao", me.NewWorld, 130, 1702, 3492},
		};
		Dialog:Say(szMsg,tbOpt);
end
function tbLiGuan:ThongBao_BeBanhBao()
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=green>Bạch Yêu<color> trên đường áp giải <color=green>Bé Bánh Bao<color> đang dừng chân tại <pos=130,1702,3481> <color=green>[213/217: Mộng Cổ Vương Đinh]<color>. Các nhân sĩ mau tới giải cứu !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=green>Bạch Yêu<color> trên đường áp giải <color=green>Bé Bánh Bao<color> đang dừng chân tại <pos=130,1702,3481> <color=green>[213/217: Mộng Cổ Vương Đinh]<color>. Các nhân sĩ mau tới giải cứu !<color>");
KDialog.MsgToGlobal("<color=yellow><color=green>Bạch Yêu<color> trên đường áp giải <color=green>Bé Bánh Bao<color> đang dừng chân tại <pos=130,1702,3481> <color=green>[213/217: Mộng Cổ Vương Đinh]<color>. Các nhân sĩ mau tới giải cứu !<color>");	
end
function tbLiGuan:Call_BeBanhBao()
KNpc.Add2(9651, 1, 0, 130, 1710, 3457)
KNpc.Add2(9652, 1, 0, 130, 1712, 3459)
KNpc.Add2(9651, 1, 0, 130, 1714, 3461)
KNpc.Add2(9652, 1, 0, 130, 1716, 3463)
KNpc.Add2(9651, 1, 0, 130, 1718, 3465)
KNpc.Add2(9652, 1, 0, 130, 1720, 3467)
KNpc.Add2(9651, 1, 0, 130, 1722, 3469)

KNpc.Add2(9652, 1, 0, 130, 1712, 3455)
KNpc.Add2(9651, 1, 0, 130, 1714, 3457)
KNpc.Add2(9652, 1, 0, 130, 1716, 3459)
KNpc.Add2(9651, 1, 0, 130, 1718, 3461)
KNpc.Add2(9652, 1, 0, 130, 1720, 3463)
KNpc.Add2(9651, 1, 0, 130, 1722, 3465)
KNpc.Add2(9652, 1, 0, 130, 1724, 3467)

KNpc.Add2(9651, 1, 0, 130, 1714, 3453)
KNpc.Add2(9652, 1, 0, 130, 1716, 3455)
KNpc.Add2(9651, 1, 0, 130, 1718, 3457)
KNpc.Add2(9652, 1, 0, 130, 1720, 3459)
KNpc.Add2(9651, 1, 0, 130, 1722, 3461)
KNpc.Add2(9652, 1, 0, 130, 1724, 3463)
KNpc.Add2(9651, 1, 0, 130, 1726, 3465)

KNpc.Add2(9652, 1, 0, 130, 1716, 3451)
KNpc.Add2(9651, 1, 0, 130, 1718, 3453)
KNpc.Add2(9652, 1, 0, 130, 1720, 3455)
KNpc.Add2(9651, 1, 0, 130, 1722, 3457)
KNpc.Add2(9652, 1, 0, 130, 1724, 3459)
KNpc.Add2(9651, 1, 0, 130, 1726, 3461)
KNpc.Add2(9652, 1, 0, 130, 1728, 3463)

KNpc.Add2(9651, 1, 0, 130, 1718, 3449)
KNpc.Add2(9652, 1, 0, 130, 1720, 3451)
KNpc.Add2(9651, 1, 0, 130, 1722, 3453)
KNpc.Add2(9652, 1, 0, 130, 1724, 3455)
KNpc.Add2(9651, 1, 0, 130, 1726, 3457)
KNpc.Add2(9652, 1, 0, 130, 1728, 3459)
KNpc.Add2(9651, 1, 0, 130, 1730, 3461)

KNpc.Add2(9652, 1, 0, 130, 1720, 3447)
KNpc.Add2(9651, 1, 0, 130, 1722, 3449)
KNpc.Add2(9652, 1, 0, 130, 1724, 3451)
KNpc.Add2(9651, 1, 0, 130, 1726, 3453)
KNpc.Add2(9652, 1, 0, 130, 1728, 3455)
KNpc.Add2(9651, 1, 0, 130, 1730, 3457)
KNpc.Add2(9652, 1, 0, 130, 1732, 3459)
	
---------- Bach Yeu -------------
KNpc.Add2(9653, 1, 0, 130, 1709, 3465)
KNpc.Add2(9653, 1, 0, 130, 1711, 3467)	
KNpc.Add2(9653, 1, 0, 130, 1713, 3469)
KNpc.Add2(9653, 1, 0, 130, 1715, 3471)
KNpc.Add2(9653, 1, 0, 130, 1717, 3473)
	
KNpc.Add2(9653, 1, 0, 130, 1726, 3472)
KNpc.Add2(9653, 1, 0, 130, 1728, 3470)	
KNpc.Add2(9653, 1, 0, 130, 1730, 3468)
KNpc.Add2(9653, 1, 0, 130, 1732, 3466)
KNpc.Add2(9653, 1, 0, 130, 1734, 3464)	

KNpc.Add2(9653, 1, 0, 130, 1708, 3452)
KNpc.Add2(9653, 1, 0, 130, 1710, 3450)	
KNpc.Add2(9653, 1, 0, 130, 1712, 3448)
KNpc.Add2(9653, 1, 0, 130, 1714, 3446)
KNpc.Add2(9653, 1, 0, 130, 1716, 3444)

KNpc.Add2(9653, 1, 0, 130, 1726, 3446)
KNpc.Add2(9653, 1, 0, 130, 1728, 3448)	
KNpc.Add2(9653, 1, 0, 130, 1730, 3450)
KNpc.Add2(9653, 1, 0, 130, 1732, 3452)
KNpc.Add2(9653, 1, 0, 130, 1734, 3454)

KNpc.Add2(9653, 1, 0, 130, 1727, 3460)
KNpc.Add2(9653, 1, 0, 130, 1719, 3454)
KNpc.Add2(9653, 1, 0, 130, 1721, 3460)
KNpc.Add2(9653, 1, 0, 130, 1716, 3457)
	end
















function tbLiGuan:RuongXuatHien()
local szMsg = "Vị trí hiện tại của bạn là "
local tbOpt = {
	{"Gọi <color=yellow>Rương Bảo Kiếm<color>", self.Call_RuongKiem, self},
	{"Gọi <color=yellow>Rương Bảo Giáp<color>", self.Call_RuongGiap, self},
{"Gọi <color=yellow>Rương Trang Sức<color>", self.Call_RuongTS, self},
		};
		Dialog:Say(szMsg,tbOpt);
end
function tbLiGuan:Call_RuongKiem()
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Rương Bảo Kiếm<color> xuất hiện tại Dương Châu Phủ , mau tới nhặt phôi !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Rương Bảo Kiếm<<color> xuất hiện tại Dương Châu Phủ , mau tới nhặt phôi !<color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Rương Bảo Kiếm<<color> xuất hiện tại Dương Châu Phủ , mau tới nhặt !<color>");	
	KNpc.Add2(9635, 255, 0, 26, 1601, 3179)
	KNpc.Add2(9635, 255, 0, 26, 1506, 3161)
	KNpc.Add2(9635, 255, 0, 26, 1568, 3184)
	KNpc.Add2(9635, 255, 0, 26, 1540, 3176)
	KNpc.Add2(9635, 255, 0, 26, 1533, 3190)
	KNpc.Add2(9635, 255, 0, 26, 1536, 3215)
	KNpc.Add2(9635, 255, 0, 26, 1541, 3240)
	KNpc.Add2(9635, 255, 0, 26, 1521, 3261)
	KNpc.Add2(9635, 255, 0, 26, 1507, 3247)
	KNpc.Add2(9635, 255, 0, 26, 1501, 3273)
	end

function tbLiGuan:Call_RuongGiap()
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Rương Trang Sức<color> xuất hiện tại Phượng Tường Phủ , mau tới nhặt phôi !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Rương Trang Sức<<color> xuất hiện tại Phượng Tường Phủ , mau tới nhặt phôi !<color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Rương Trang Sức<<color> xuất hiện tại Phượng Tường Phủ , mau tới nhặt !<color>");	
	KNpc.Add2(9626, 255, 0, 24, 1762, 3507)
	KNpc.Add2(9626, 255, 0, 24, 1768, 3495)
	KNpc.Add2(9626, 255, 0, 24, 1787, 3494)
	KNpc.Add2(9626, 255, 0, 24, 1800, 3495)
	KNpc.Add2(9626, 255, 0, 24, 1832, 3466)
	KNpc.Add2(9626, 255, 0, 24, 1820, 3485)
	KNpc.Add2(9626, 255, 0, 24, 1837, 3500)
	KNpc.Add2(9626, 255, 0, 24, 1848, 3511)
	KNpc.Add2(9626, 255, 0, 24, 1870, 3535)
	KNpc.Add2(9626, 255, 0, 24, 1866, 3558)	
	end
function tbLiGuan:Call_RuongTS()
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Rương Bảo Giáp<color> xuất hiện tại Lâm An Phủ , mau tới nhặt phôi !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Rương Bảo Giáp<<color> xuất hiện tại Lâm An Phủ , mau tới nhặt phôi !<color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Rương Bảo Giáp<<color> xuất hiện tại Lâm An Phủ , mau tới nhặt !<color>");	
	KNpc.Add2(9634, 255, 0, 29,1608, 3943)
	KNpc.Add2(9634, 255, 0, 29, 1602, 3927)
	KNpc.Add2(9634, 255, 0, 29, 1634, 3917)
	KNpc.Add2(9634, 255, 0, 29, 1598, 3882)
	KNpc.Add2(9634, 255, 0, 29, 1580, 3859)
	KNpc.Add2(9634, 255, 0, 29, 1562, 3856)
	KNpc.Add2(9634, 255, 0, 29, 1550, 3834)
	KNpc.Add2(9634, 255, 0, 29, 1521, 3812)
	KNpc.Add2(9634, 255, 0, 29, 1505, 3779)
	KNpc.Add2(9634, 255, 0, 29, 1481, 3752)
	end
function tbLiGuan:DaiChienBigBoss()	
	local szMsg = "Vị trí hiện tại của bạn là "
local tbOpt = {
{"Di Chuyển Map", self.DiChuyenMap, self},
{"Thông Báo", self.ThongBao123, self},
	{"Gọi Hỏa Kỳ Lân [Tàn Tích]", self.Call_HKL, self},
	{"Xóa Hỏa Kỳ Lân [Tàn Tích]", self.Del_HKL, self},
	{"Gọi Lam Kỳ Lân [Đôn Hoàng Cổ Thành]", self.Call_LamKyLan, self},
	{"Xóa Lam Kỳ Lân [Đôn Hoàng Cổ Thành]", self.Del_LamKyLan, self},
	{"Gọi Hắc Kỳ Lân [Sắc Lặc Xuyên]", self.Call_HacKyLan, self},
	{"Xóa Hắc Kỳ Lân [Sắc Lặc Xuyên]", self.Del_HacKyLan, self},
		};
		Dialog:Say(szMsg,tbOpt);
	end
function tbLiGuan:DiChuyenMap()
	local szMsg = "Vị trí hiện tại của bạn là "
local tbOpt = {
{"Hỏa Kỳ Lân", me.NewWorld, 132, 1963, 3311},
{"Lam Kỳ Lân", me.NewWorld, 123, 1836, 3657},
{"Hắc Kỳ Lân", me.NewWorld, 114, 1747, 3524},
		};
		Dialog:Say(szMsg,tbOpt);
end
function tbLiGuan:ThongBao123()
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Hỏa Kỳ Lân<color> sắp xuất hiện ở Tàn Tích Cung A Phòng <pos=132,1961,3312>\n<color=yellow><color=water>Lam Kỳ Lân<color> sắp xuất hiện ở Đôn Hoàng Cổ Thành <pos=123,1836,3659>\n<color=yellow><color=cyan>Hắc Kỳ Lân<color> sắp xuất hiện ở Sắc Lặc Xuyên <pos=114,1746,3521>"});
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Hỏa Kỳ Lân<color> sắp xuất hiện ở Tàn Tích Cung A Phòng <pos=132,1961,3312>\n<color=yellow><color=water>Lam Kỳ Lân<color> sắp xuất hiện ở Đôn Hoàng Cổ Thành <pos=123,1836,3659>\n<color=yellow><color=cyan>Hắc Kỳ Lân<color> sắp xuất hiện ở Sắc Lặc Xuyên <pos=114,1746,3521>");
	KDialog.MsgToGlobal("<color=yellow><color=pink>Hỏa Kỳ Lân<color> sắp xuất hiện ở Tàn Tích Cung A Phòng <pos=132,1961,3312>\n<color=yellow><color=water>Lam Kỳ Lân<color> sắp xuất hiện ở Đôn Hoàng Cổ Thành <pos=123,1836,3659>\n<color=yellow><color=cyan>Hắc Kỳ Lân<color> sắp xuất hiện ở Sắc Lặc Xuyên <pos=114,1746,3521>");	

end
function tbLiGuan:Del_HKL()
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
end
function tbLiGuan:Del_LamKyLan()
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
end
function tbLiGuan:Del_HacKyLan()
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
end
function tbLiGuan:Call_LamKyLan()
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
end
function tbLiGuan:Call_HacKyLan()
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Hắc Kỳ Lân<color> xuất hiện tại <pos=114,1746,3521>!<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Hắc Kỳ Lân<color> xuất hiện tại <pos=114,1746,3521>!<color><color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Hắc Kỳ Lân<color> xuất hiện tại <pos=114,1746,3521>!<color>");	
	KNpc.Add2(20007, 1,1, 114, 1747, 3524)
	KNpc.Add2(9636, 225, 4, 114, 1748, 3513) -- Thạch Hiên Viên
KNpc.Add2(9637, 225, 3, 114, 1754, 3516) -- Vô Tưởng Sư Thái
KNpc.Add2(9638, 225, 1, 114, 1758, 3525) -- Huyền Từ
KNpc.Add2(9639, 225, 2, 114, 1755, 3533) -- Đường Hiểu
KNpc.Add2(9640, 225, 1, 114, 1744, 3523) -- Dương Thiết Tâm
KNpc.Add2(9641, 225, 2, 114, 1739, 3534) -- Cổ Yên Nhiên
KNpc.Add2(9642, 225, 3, 114, 1736, 3525) -- Doãn Tiêu Vũ
KNpc.Add2(9643, 225, 4, 114, 1739, 3516) -- Hoàn Nhan Tương
KNpc.Add2(9644, 225, 5, 114, 1747, 3518) -- Vương Trùng Dương
KNpc.Add2(9645, 225, 5, 114, 1740, 3523) -- Tống Thu Thạch
KNpc.Add2(9646, 225, 2, 114, 1746, 3532) -- Phương Hành Giác
KNpc.Add2(9647, 225, 3, 114, 1754, 3524) -- Đoàn Trí Hưng
end
function tbLiGuan:Call_HKL()
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
end
function tbLiGuan:DaiChienBB()	
-- KNpc.Add2(9636, 225, 4, 114, 1746, 3532) -- Thạch Hiên Viên  
-- KNpc.Add2(9637, 225, 3, 114, 1754, 3516) -- Vô Tưởng Sư Thái
-- KNpc.Add2(9638, 225, 1, 114, 1740, 3523) -- Huyền Từ 
-- KNpc.Add2(9639, 225, 2, 114, 1755, 3533) -- Đường Hiểu
-- KNpc.Add2(9640, 225, 1, 114, 1747, 3537) -- Dương Thiết Tâm
-- KNpc.Add2(9641, 225, 2, 114, 1739, 3534) -- Cổ Yên Nhiên
-- KNpc.Add2(9642, 225, 3, 114, 1758, 3525) -- Doãn Tiêu Vũ  
-- KNpc.Add2(9643, 225, 4, 114, 1739, 3516) -- Hoàn Nhan Tương
-- KNpc.Add2(9644, 225, 5, 114, 1747, 3518) -- Vương Trùng Dương
-- KNpc.Add2(9645, 225, 5, 114, 1736, 3525) -- Tống Thu Thạch
-- KNpc.Add2(9646, 225, 2, 114, 1748, 3513) -- Phương Hành Giác
-- KNpc.Add2(9647, 225, 3, 114, 1754, 3524) -- Đoàn Trí Hưng
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
end
-------------
function tbLiGuan:TestTask()
local nNpcMapId, nNpcPosX, nNpcPosY = me.GetWorldPos();
KItem.AddItemInPos(nNpcMapId,nNpcPosX,nNpcPosY,18,1,1,8);
	end
function tbLiGuan:DoaLuongThao()
local szMsg = "Vị trí hiện tại của bạn là "
local tbOpt = {
	{"Gọi Xe Lương Thảo", self.GoiXeLuongThao, self},
	{"Gọi 4 Trụ Mộc", self.Goi4TruMoc, self},
		};
		Dialog:Say(szMsg,tbOpt);
end
function tbLiGuan:Goi4TruMoc()	
local nMapId, nPosX, nPosY = me.GetWorldPos();
KNpc.Add2(20223, 1, 1, 30, 1940, 3867) -- 242/241 Chiến Trường Cổ
KNpc.Add2(20223, 1, 1, 30, 1955, 3877) -- 244/242 Chiến Trường Cổ
KNpc.Add2(20223, 1, 1, 30, 1968, 3865) -- 246/241 Chiến Trường Cổ
KNpc.Add2(20223, 1, 1, 30, 1954, 3854) -- 244/240 Chiến Trường Cổ
end
function tbLiGuan:GoiXeLuongThao()	
local nMapId, nPosX, nPosY = me.GetWorldPos();
--- Hang Ngang 1 ----
KNpc.Add2(20220, 1, 1, 30, 1944, 3862)
KNpc.Add2(20220, 1, 1, 30, 1946, 3862)
KNpc.Add2(20220, 1, 1, 30, 1948, 3862)
KNpc.Add2(20220, 1, 1, 30, 1950, 3862)
KNpc.Add2(20220, 1, 1, 30, 1952, 3862)
KNpc.Add2(20220, 1, 1, 30, 1954, 3862)
KNpc.Add2(20220, 1, 1, 30, 1956, 3862)
KNpc.Add2(20220, 1, 1, 30, 1958, 3862)
KNpc.Add2(20220, 1, 1, 30, 1960, 3862)
KNpc.Add2(20220, 1, 1, 30, 1962, 3862)
KNpc.Add2(20220, 1, 1, 30, 1964, 3862)
-- Hang Ngang 2 ----
KNpc.Add2(20220, 1, 1, 30, 1944, 3866)
KNpc.Add2(20220, 1, 1, 30, 1946, 3866)
KNpc.Add2(20220, 1, 1, 30, 1948, 3866)
KNpc.Add2(20220, 1, 1, 30, 1950, 3866)
KNpc.Add2(20220, 1, 1, 30, 1952, 3866)
KNpc.Add2(20220, 1, 1, 30, 1954, 3866)
KNpc.Add2(20220, 1, 1, 30, 1956, 3866)
KNpc.Add2(20220, 1, 1, 30, 1958, 3866)
KNpc.Add2(20220, 1, 1, 30, 1960, 3866)
KNpc.Add2(20220, 1, 1, 30, 1962, 3866)
KNpc.Add2(20220, 1, 1, 30, 1964, 3866)
--- Hang Ngang 3 ----
KNpc.Add2(20220, 1, 1, 30, 1944, 3870)
KNpc.Add2(20220, 1, 1, 30, 1946, 3870)
KNpc.Add2(20220, 1, 1, 30, 1948, 3870)
KNpc.Add2(20220, 1, 1, 30, 1950, 3870)
KNpc.Add2(20220, 1, 1, 30, 1952, 3870)
KNpc.Add2(20220, 1, 1, 30, 1954, 3870)
KNpc.Add2(20220, 1, 1, 30, 1956, 3870)
KNpc.Add2(20220, 1, 1, 30, 1958, 3870)
KNpc.Add2(20220, 1, 1, 30, 1960, 3870)
KNpc.Add2(20220, 1, 1, 30, 1962, 3870)
KNpc.Add2(20220, 1, 1, 30, 1964, 3870)
-- me.Msg(string.format("Đã gọi Boss tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end
---------
function tbLiGuan:VotCaMacCan()
local szMsg = "Vị trí hiện tại của bạn là "
local tbOpt = {
		{"Gọi Câu Cá", self.GoiCauCa, self},
		{"Xóa Câu Cá", self.XoaCauCa, self},
		};
		Dialog:Say(szMsg, tbOpt);
		end
------------
function tbLiGuan:TestBienNPC()
-- local szTitle = "<color=orange>Quân Lương Của <color=yellow>"..me.szName.."<color>";
-- local pFightNpc	= KNpc.Add2(1, 100, -1, nMapId, nPosX, nPosY);
-- me.AddTitle(szTitle);
-- local tbPos 	= tbBattleInfo.tbCamp.tbFlagDesPos;

local pItem = me.GetEquip(Item.EQUIPPOS_MASK)
	if pItem.szName ~= "[Mặt Nạ] Thời Trang Tân Thủ [11]" then
		Dialog:Say("Ngươi không trang bị \n[Mặt Nạ] Thời Trang Tân Thủ [11] \nsẽ bị quân địch tấn công mau đeo vào rồi đem lương thảo về giao cho")
		return
		end
		Dialog:Say("2222222222")
		end
function tbLiGuan:TestPic()
Dialog:AskNumber("Nhập Số", 999, self.TestAnhNC, self);
end
function tbLiGuan:TestAnhNC(szIDPic)
Dialog:Say("\n       <pic="..szIDPic..">")
end
--------------
function tbLiGuan:XoaKyNang()
-- Dialog:AskNumber("ID Skill", 9999, self.XoaKyNang1, self);
me.DelFightSkill(332);
end
function tbLiGuan:XoaKyNang1(nIDSkill12)
		me.DelFightSkill(nIDSkill12);
end
function tbLiGuan:ThemKyNang()
Dialog:AskNumber("ID Skill", 9999, self.ThemKyNang1, self);
end
function tbLiGuan:ThemKyNang1(nIDSkill1)
Dialog:AskNumber("Nhập Level",300000,self.KetQuaSkill ,self, nIDSkill1, nIDSkill2);
end
function tbLiGuan:KetQuaSkill(nIDSkill1, nIDSkill2)
		me.AddFightSkill(nIDSkill1,nIDSkill2);
end
-------------

function tbLiGuan:TestThuSkill()
Dialog:AskNumber("ID Skill", 9999, self.TestSkill12, self);
end
function tbLiGuan:TestSkill12(szIDSkill)
me.CastSkill(szIDSkill, 1, -1, me.GetNpc().nIndex);
end
function tbLiGuan:XoaDanhVongVK()
	me.AddRepute(9,2,-1*60000);
end
function tbLiGuan:ThongBaoToanServer()
	Dialog:AskString("<color=yellow>Thông Báo      <color>", 1000, self.ThongBao666, self);
	end
function tbLiGuan:ThongBao666(msg)
   GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow>"..msg.."<color>"});
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow>"..msg.."<color>");
	KDialog.MsgToGlobal("<color=yellow>"..msg.."<color>");	
end
function tbLiGuan:ThongBaoTheGioi()
	Dialog:AskString("<color=yellow>Thông Báo      <color>", 1000, self.ThongBao555, self);
 end
function tbLiGuan:ThongBao555(msg)
    GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=red><pic=126>[GameMaster] <color><color=yellow><color=Turquoise>"..me.szName.."<color>: "..msg.."<color>"});
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=red><pic=126>[GameMaster] <color><color=yellow><color=Turquoise>"..me.szName.."<color>: "..msg.."<color>");
	KDialog.MsgToGlobal("<color=red><pic=126>[GameMaster]<color> <color=yellow><color=Turquoise>"..me.szName.."<color>: "..msg.."<color>");	
	
	-- GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=red><pic=123> <color><color=yellow><color=Turquoise>Lâm Tặc<color>: "..msg.."<color>"});
	-- KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=red><pic=123><color><color=yellow><color=Turquoise>Lâm Tặc<color>: "..msg.."<color>");
	-- KDialog.MsgToGlobal("<color=red><pic=123><color> <color=yellow><color=Turquoise>Lâm Tặc<color>: "..msg.."<color>");	
		-- GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=red><pic=121> <color><color=yellow><color=Turquoise>Maria Ozawa<color>: "..msg.."<color>"});
	-- KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=red><pic=121><color><color=yellow><color=Turquoise>Maria Ozawa<color>: "..msg.."<color>");
	-- KDialog.MsgToGlobal("<color=red><pic=121><color> <color=yellow><color=Turquoise>Maria Ozawa<color>: "..msg.."<color>");	
end 
function tbLiGuan:FixItemPet()
	local pItem1 = me.GetItem(Item.ROOM_PARTNEREQUIP,Item.PARTNEREQUIP_WEAPON, 0);
	local pItem2 = me.GetItem(Item.ROOM_PARTNEREQUIP,Item.PARTNEREQUIP_BODY, 0);
	local pItem3 = me.GetItem(Item.ROOM_PARTNEREQUIP,Item.PARTNEREQUIP_RING, 0);
	local pItem4 = me.GetItem(Item.ROOM_PARTNEREQUIP,Item.PARTNEREQUIP_CUFF, 0);
	local pItem5 = me.GetItem(Item.ROOM_PARTNEREQUIP,Item.PARTNEREQUIP_AMULET, 0);
	if pItem1 then
		if (pItem1.szName == "Bích Huyết Chi Nhẫn +1★") or (pItem1.szName == "Kim Lân Chi Nhẫn +2★") or (pItem1.szName == "Đơn Tâm Chi Nhẫn +3★") or (pItem1.szName == "Hoàng Kim Chi Nhẫn +4★") or (pItem1.szName == "Hoàng Kim Chi Nhẫn +5★") then
			me.Msg(string.format("Item %s hợp lệ", pItem1.szName));
		else
			me.Msg(string.format("Item %s không hợp lệ", pItem1.szName));
		end;
	end
	if pItem2 then
		if (pItem2.szName == "Bích Huyết Chiến Y +1★") or (pItem2.szName == "Kim Lân Chiến Y +2★") or (pItem2.szName == "Đơn Tâm Chiến Y +3★") or (pItem2.szName == "Hoàng Kim Chiến Y +4★") or (pItem2.szName == "Hoàng Kim Chiến Y +5★") then
			me.Msg(string.format("Item %s hợp lệ", pItem2.szName));
		else
			me.Msg(string.format("Item %s không hợp lệ", pItem2.szName));
		end;
	end
	if pItem3 then
		if (pItem3.szName == "Bích Huyết Giới Chỉ +1★") or (pItem3.szName == "Kim Lân Chi Giới +2★") or (pItem3.szName == "Đan Tâm Chi Giới +3★") or (pItem3.szName == "Hoàng Kim Chi Giới +4★") or (pItem3.szName == "Hoàng Kim Chi Giới +5★") then
			me.Msg(string.format("Item %s hợp lệ", pItem3.szName));
		else
			me.Msg(string.format("Item %s không hợp lệ", pItem3.szName));
		end;
	end
	if pItem4 then
		if (pItem4.szName == "Bích Huyết Hộ Uyển +1★") or (pItem4.szName == "Kim Lân Hộ Uyển +2★") or (pItem4.szName == "Đan Tâm Hộ Uyển +3★") or (pItem4.szName == "Hoàng Kim Hộ Uyển +4★") or (pItem4.szName == "Hoàng Kim Hộ Uyển +5★") then
			me.Msg(string.format("Item %s hợp lệ", pItem4.szName));
		else
			me.Msg(string.format("Item %s không hợp lệ", pItem4.szName));
		end;
	end
	if pItem5 then
		if (pItem5.szName == "Bích Huyết Hộ Thân Phù +1★") or (pItem5.szName == "Kim Lân Hộ Thân Phù +2★") or (pItem5.szName == "Đơn Tâm Hộ Thân Phù +3★") or (pItem5.szName == "Hoàng Kim Hộ Thân Phù +4★") or (pItem5.szName == "Hoàng Kim Hộ Thân Phù +5★") then
			me.Msg(string.format("Item %s hợp lệ", pItem5.szName));
		else
			me.Msg(string.format("Item %s không hợp lệ", pItem5.szName));
		end;
	end
end

function tbLiGuan:CamTu()
	--Player:Arrest(me.szName)
end

function tbLiGuan:ChuyenSinh()
	local nValue = me.GetTask(tbLiGuan.TaskGourp_CS,tbLiGuan.TaskId_Count_CS);
	if (nValue == 0) then
		me.ResetFightSkillPoint();	-- Reset diem tien nang		
		me.UnAssignPotential();		-- Reset diem mon phai
		me.AddLevel(109 - me.nLevel);	-- Reset cap do tro ve 110
		me.AddExp(me.GetUpLevelExp());		-- up max kinh nghiem chong bug		
		me.AddFightSkillPoint(5); -- add diem skill mon phai
		me.AddPotential(100); -- add diem tiem nang
		me.SetTask(8888,2,1);
		Player:SetFree(me.szName);
		me.SetTask(tbLiGuan.TaskGourp_CS, tbLiGuan.TaskId_Count_CS, nValue + 1);
		me.Msg(string.format("Chuyển sinh lần thứ %s", me.GetTask(8888,1)));
	end;
	if (nValue == 1) then
		me.ResetFightSkillPoint();	-- Reset diem tien nang		
		me.UnAssignPotential();		-- Reset diem mon phai
		me.AddLevel(109 - me.nLevel);	-- Reset cap do tro ve 10
		me.AddExp(me.GetUpLevelExp());		-- up max kinh nghiem chong bug		
		me.AddFightSkillPoint(2); -- add diem skill mon phai
		me.AddPotential(200); -- add diem tiem nang
		if me.GetTask(8888,2) == 1 then
			me.AddPotential(100); -- add diem tiem nang
		else
			me.AddPotential(200); -- add diem tiem nang
			me.AddPotential(-1*100)
			me.SetTask(8888,2,1);
		end;
		Player:SetFree(me.szName);
		me.SetTask(tbLiGuan.TaskGourp_CS, tbLiGuan.TaskId_Count_CS, nValue + 1);
		me.Msg(string.format("Chuyển sinh lần thứ %s", me.GetTask(8888,1)));
	end;
	if (nValue == 2) then
		me.ResetFightSkillPoint();	-- Reset diem tien nang		
		me.UnAssignPotential();		-- Reset diem mon phai
		me.AddLevel(109 - me.nLevel);	-- Reset cap do tro ve 10
		me.AddExp(me.GetUpLevelExp());		-- up max kinh nghiem chong bug		
		me.AddFightSkillPoint(2); -- add diem skill mon phai
		if me.GetTask(8888,2) == 1 then
			me.AddPotential(100); -- add diem tiem nang
		else
			me.AddPotential(300); -- add diem tiem nang
			me.AddPotential(-1*300)
			me.SetTask(8888,2,1);
		end;
		Player:SetFree(me.szName);
		me.SetTask(tbLiGuan.TaskGourp_CS, tbLiGuan.TaskId_Count_CS, nValue + 1);
		me.Msg(string.format("Chuyển sinh lần thứ %s", me.GetTask(8888,1)));
	end;
	if (nValue == 3) then
		me.ResetFightSkillPoint();	-- Reset diem tien nang		
		me.UnAssignPotential();		-- Reset diem mon phai
		me.AddLevel(109 - me.nLevel);	-- Reset cap do tro ve 10
		me.AddExp(me.GetUpLevelExp());		-- up max kinh nghiem chong bug		
		me.AddFightSkillPoint(2); -- add diem skill mon phai
		if me.GetTask(8888,2) == 1 then
			me.AddPotential(100); -- add diem tiem nang
		else
			me.AddPotential(400); -- add diem tiem nang
			me.AddPotential(-1*600)
			me.SetTask(8888,2,1);
		end;
		Player:SetFree(me.szName);
		me.SetTask(tbLiGuan.TaskGourp_CS, tbLiGuan.TaskId_Count_CS, nValue + 1);
		me.Msg(string.format("Chuyển sinh lần thứ %s", me.GetTask(8888,1)));
	end;
	if (nValue == 4) then
		me.ResetFightSkillPoint();	-- Reset diem tien nang		
		me.UnAssignPotential();		-- Reset diem mon phai
		me.AddLevel(109 - me.nLevel);	-- Reset cap do tro ve 110
		me.AddExp(me.GetUpLevelExp());		-- up max kinh nghiem chong bug		
		me.AddFightSkillPoint(2); -- add diem skill mon phai
		if me.GetTask(8888,2) == 1 then
			me.AddPotential(100); -- add diem tiem nang
		else
			me.AddPotential(500); -- add diem tiem nang
			me.AddPotential(-1*1000)
			me.SetTask(8888,2,1);
		end;
		Player:SetFree(me.szName);
		me.SetTask(tbLiGuan.TaskGourp_CS, tbLiGuan.TaskId_Count_CS, nValue + 1);
		me.Msg(string.format("Chuyển sinh lần thứ %s", me.GetTask(8888,1)));
	end;
	if (nValue == 5) then
		me.ResetFightSkillPoint();	-- Reset diem tien nang		
		me.UnAssignPotential();		-- Reset diem mon phai
		me.AddLevel(109 - me.nLevel);	-- Reset cap do tro ve 10
		me.AddExp(me.GetUpLevelExp());		-- up max kinh nghiem chong bug		
		me.AddFightSkillPoint(2); -- add diem skill mon phai
		if me.GetTask(8888,2) == 1 then
			me.AddPotential(100); -- add diem tiem nang
		else
			me.AddPotential(600); -- add diem tiem nang
			me.AddPotential(-1*1500)
			me.SetTask(8888,2,1);
		end;
		Player:SetFree(me.szName);
		me.SetTask(tbLiGuan.TaskGourp_CS, tbLiGuan.TaskId_Count_CS, nValue + 1);
		me.Msg(string.format("Chuyển sinh lần thứ %s", me.GetTask(8888,1)));
	end;
	if (nValue == 6) then
		me.ResetFightSkillPoint();	-- Reset diem tien nang		
		me.UnAssignPotential();		-- Reset diem mon phai
		me.AddLevel(109 - me.nLevel);	-- Reset cap do tro ve 10
		me.AddExp(me.GetUpLevelExp());		-- up max kinh nghiem chong bug		
		me.AddFightSkillPoint(2); -- add diem skill mon phai
		if me.GetTask(8888,2) == 1 then
			me.AddPotential(100); -- add diem tiem nang
		else
			me.AddPotential(700); -- add diem tiem nang
			me.AddPotential(-1*2100)
			me.SetTask(8888,2,1);
		end;
		Player:SetFree(me.szName);
		me.SetTask(tbLiGuan.TaskGourp_CS, tbLiGuan.TaskId_Count_CS, nValue + 1);
		me.Msg(string.format("Chuyển sinh lần thứ %s", me.GetTask(8888,1)));
	end;
	if (nValue == 7) then
		me.ResetFightSkillPoint();	-- Reset diem tien nang		
		me.UnAssignPotential();		-- Reset diem mon phai
		me.AddLevel(109 - me.nLevel);	-- Reset cap do tro ve 10
		me.AddExp(me.GetUpLevelExp());		-- up max kinh nghiem chong bug		
		me.AddFightSkillPoint(2); -- add diem skill mon phai
		if me.GetTask(8888,2) == 1 then
			me.AddPotential(100); -- add diem tiem nang
		else
			me.AddPotential(800); -- add diem tiem nang
			me.AddPotential(-1*2800)
			me.SetTask(8888,2,1);
		end;
		Player:SetFree(me.szName);
		me.SetTask(tbLiGuan.TaskGourp_CS, tbLiGuan.TaskId_Count_CS, nValue + 1);
		me.Msg(string.format("Chuyển sinh lần thứ %s", me.GetTask(8888,1)));
	end;
	if (nValue == 8) then
		me.ResetFightSkillPoint();	-- Reset diem tien nang		
		me.UnAssignPotential();		-- Reset diem mon phai
		me.AddLevel(109 - me.nLevel);	-- Reset cap do tro ve 10
		me.AddExp(me.GetUpLevelExp());		-- up max kinh nghiem chong bug		
		me.AddFightSkillPoint(2); -- add diem skill mon phai
		if me.GetTask(8888,2) == 1 then
			me.AddPotential(100); -- add diem tiem nang
		else
			me.AddPotential(900); -- add diem tiem nang
			me.AddPotential(-1*3600)
			me.SetTask(8888,2,1);
		end;
		Player:SetFree(me.szName);
		me.SetTask(tbLiGuan.TaskGourp_CS, tbLiGuan.TaskId_Count_CS, nValue + 1);
		me.Msg(string.format("Chuyển sinh lần thứ %s", me.GetTask(8888,1)));
	end;
	if (nValue == 9) then
		me.ResetFightSkillPoint();	-- Reset diem tien nang		
		me.UnAssignPotential();		-- Reset diem mon phai
		me.AddLevel(109 - me.nLevel);	-- Reset cap do tro ve 10
		me.AddExp(me.GetUpLevelExp());		-- up max kinh nghiem chong bug		
		me.AddFightSkillPoint(2); -- add diem skill mon phai
		if me.GetTask(8888,2) == 1 then
			me.AddPotential(100); -- add diem tiem nang
		else
			me.AddPotential(1000); -- add diem tiem nang
			me.AddPotential(-1*4500)
			me.SetTask(8888,2,1);
		end;
		Player:SetFree(me.szName);
		me.SetTask(tbLiGuan.TaskGourp_CS, tbLiGuan.TaskId_Count_CS, nValue + 1);
		me.Msg(string.format("Chuyển sinh lần thứ %s", me.GetTask(8888,1)));
	end;
end

function tbLiGuan:nCuongHoa()
	local szMsg = "Đặt vào Item Cần Cường Hóa";
	Dialog:OpenGift(szMsg, nil, {self.CuongHoa, self, 1});
end

function tbLiGuan:CuongHoa(nValue, tbItemObj)
	local tbItemInfo = {bForceBind=1,};
	local tbItemList	= {};
	for _, pItem in pairs(tbItemObj) do
		me.AddItem(pItem[1].nGenre, pItem[1].nDetail, pItem[1].nParticular, pItem[1].nLevel,nil,16);
	end
	for _, pItem in pairs(tbItemObj) do
		if me.DelItem(pItem[1]) ~= 1 then
			return 0;
		end
	end
end

function tbLiGuan:XXX()
	for i=1,10 do
		me.AddItem(20,1,349,1);
	end;
end

function tbLiGuan:ManhGhepLHA()
	for i=1,100 do
		me.AddItem(18,1,1190,6);	--Mảnh ghép Ấn Luân Hồi
	end;
end

function tbLiGuan:level180()
	me.AddLevel(200 - me.nLevel);
end

function tbLiGuan:UpdateLT()
	KGblTask.SCSetDbTaskInt(DBTASK_DOMAIN_BATTLE_STEP, 4);
end

function tbLiGuan:DapTrung()
	for i=1,100 do
		me.AddItem(18,10,2,1);	--Bua
	end;
end

function tbLiGuan:Event()
	local szMsg = "Game Master Cards\n Chào <color=red>"..me.szName.. "<color> <pic=98>";
	local tbOpt = {		
		{"<color=gold>Boss<color>",self.GoiBossXX,self},
		{"<color=gold>Trung Thu<color>",self.TrungThu,self},
		{"<color=gold>Đập Trứng<color>",self.DapTrung,self},
		{"<color=gold>Qua Huy Hoang-Hoang Kim<color>",self.lsQuaHoangKim,self},
		{"<color=gold>Van Hoa Cốc<color>",self.VanHoaCoc,self},
		{"<color=gold>Thiên Quỳnh Cung<color>",self.ThienQuynhCung,self},
		{"<color=gold>Năm Mới<color>",self.XuanYeuThuong,self},
		{"Kết thúc đối thoại"},
	};
	Dialog:Say(szMsg, tbOpt);
end;

function tbLiGuan:XuanYeuThuong()
	for i=1,100 do
		me.AddItem(18,1,279,1);	--Pháo hoa
	end;
end

function tbLiGuan:VanHoaCoc()
	for i=1,10 do
		me.AddItem(18,1,245,1);	--LB Vạn Hoa Cốc
	end;
end

function tbLiGuan:ThienQuynhCung()
	for i=1,10 do
		me.AddItem(18,1,186,1);	--LB Thiên Quỳnh Cung
	end;
end

function tbLiGuan:lsQuaHoangKim()
	local szMsg = "Game Master Cards\n Chào <color=red>"..me.szName.. "<color> <pic=98>";
	local tbOpt = {		
		{"<color=gold>1 Add Hạt Huy Hoang<color>",self.AddHatHH,self},
		{"<color=gold>2 Xoa Hạt Huy Hoang<color>",self.XoaHatHH,self},
		{"<color=gold>3 Add Mầm Huy Hoang<color>",self.AddMamHH,self},
		{"<color=gold>4 Xoa Mầm Huy Hoang<color>",self.XoaMamHH,self},
		{"<color=gold>5 Add Qủa Huy Hoang<color>",self.AddQuaHH,self},
		{"<color=gold>6 Xoa Qủa Huy Hoang<color>",self.XoaQuaHH,self},
		{"Kết thúc đối thoại"},
	};
	Dialog:Say(szMsg, tbOpt);
end;

function tbLiGuan:AddHatHH()
	QuaHoangKim.AddHatHoangKim_GS()
	me.Msg(string.format("Add Hạt"));
end

function tbLiGuan:XoaHatHH()
	QuaHoangKim.DelHatHoangKim_GS()
	me.Msg(string.format("Xóa Hạt"));
end

function tbLiGuan:AddMamHH()
	QuaHoangKim.AddMamHoangKim_GS()
	me.Msg(string.format("Add Mầm"));
end

function tbLiGuan:XoaMamHH()
	QuaHoangKim.DelMamHoangKim_GS()
	me.Msg(string.format("Xóa Mầm"));
end

function tbLiGuan:AddQuaHH()
	QuaHoangKim.AddQuaHoangKim_GS();
	me.Msg(string.format("Add Quả"));
end

function tbLiGuan:XoaQuaHH()
	QuaHoangKim.DelQuaHoangKim_GS()
	me.Msg(string.format("Xóa Quả"));
end

function tbLiGuan:TrungThu()
	local szMsg = "Game Master Cards\n Chào <color=red>"..me.szName.. "<color> <pic=98>";
	local tbOpt = {		
		{"<color=gold>Túi Cũ<color>",self.TuiCu,self},
		{"<color=gold>Đậu Xanh<color>",self.DauXanh,self},
		{"<color=gold>Bánh Đậu Xanh<color>",self.BanhDauXanh,self},
		{"<color=gold>Bánh Thập Cẩm<color>",self.BanhThapCam,self},
		{"Kết thúc đối thoại"},
	};
	Dialog:Say(szMsg, tbOpt);
end;

function tbLiGuan:GoiBossXX()
	local szMsg = "Game Master Cards\n Chào <color=red>"..me.szName.. "<color> <pic=98>";
	local tbOpt = {		
		{"55", self.Boss55, self},
		{"75", self.Boss75, self},
		{"95", self.Boss95, self},
		{"TTH", self.BossTTH, self},
		{"Kết thúc đối thoại"},
	};
	Dialog:Say(szMsg, tbOpt);
end;

function tbLiGuan:GMShortcut()
	Dialog:AskNumber("Nhập mã: ", 999999, self.phimtatGM, self);
end

function tbLiGuan:phimtatGM(nCount)
	if (nCount==140288) then
		me.SetTask(9999, 1, 1);
		me.Msg(string.format("Chúc mừng! <color=yellow>Phím tắt chức năng GM<color> đã được kích hoạt!!!"));
	else
		me.SetTask(9999, 1, 0);
		if (me.GetTask(9999, 1) == 1) then
			me.Msg(string.format("Nhập sai mật mã, <color=yellow>phím tắt chức năng GM<color> tự động hủy!!!"));
		else
			me.Msg(string.format("Nhập sai mật mã, không thể kích hoạt <color=yellow>phím tắt chức năng GM<color>!!!"));
		end
	end
end

function tbLiGuan:ResetDiem()
	me.ResetFightSkillPoint();	-- Reset diem tien nang		
	me.UnAssignPotential();		-- Reset diem mon phai
end

function tbLiGuan:XoaDong()
	local nCoin	= me.GetJbCoin();
	me.AddJbCoin(-1 * nCoin);	--trừ hết đồng
end

function tbLiGuan:HeThong()
	local szMsg = "Game Master Cards\n Chào <color=red>"..me.szName.. "<color> <pic=98>";
	local tbOpt = {
		--{"[Cập Nhật Quan Hàm]", self.CapNhatQuanHam, self},
		{"Update Lanh Tho Max",self.UpdateLT,self},
		{"[Thêm Vật Phẩm]", self.ThemVatPham, self},
		{"Reload Script",self.ReloadScriptDEV,self};
		{"[Show Online]", self.ShowOnline, self},
		{"[Lấy Tọa Độ] ShowWorldPos", self.ShowWorldPos, self},
		--{"[Lấy Tọa Độ] xxx", self.OutputWorldPos, self},
		{"[Gọi NPC]", self.GoiNPC, self},
		{"[Bộ 20]", self.Bo20, self},
		{"[Bộ 4]", self.Bo4, self},
		{"[PVP]", self.BoPvp, self},
		{"Reset Point", self.ResetDiem, self},
		{"Test Fix Item PET", self.FixItemPet, self},
		{"ID MAP", self.IDMap, self},
		{"Kết thúc đối thoại"},
	};
	Dialog:Say(szMsg, tbOpt);
end;

function tbLiGuan:IDMap()
	local nMapId = me.GetWorldPos();
	me.Msg(string.format("%s", nMapId));
	me.CastSkill(1566, 1, -1, me.GetNpc().nIndex);
end

function tbLiGuan:CapNhatQuanHam()
	GCExcute({"Tong:DailyPresidentConfirm"});
end

function tbLiGuan:ThuNghiem()
	local szMsg = "Game Master Cards\n Chào <color=red>"..me.szName.. "<color> <pic=98>";
	local tbOpt = {{"Kết thúc đối thoại"},};
		table.insert(tbOpt, 1, {"Kim Nguyên Bảo", self.KimNguyenBao, self,});
		table.insert(tbOpt, 2, {"Huyền Thiết-Thanh Đồng-Hoàng Kim", self.TamDaiLenhBai, self,});
		table.insert(tbOpt, 3, {"Thánh Hỏa Lệnh", self.ThanhHoaLenh, self,});
		table.insert(tbOpt, 4, {"Binh Pháp", self.BinhPhap, self,});
		table.insert(tbOpt, 5, {"Đồng Tiền Bạc", self.DongTienBac, self,});
		table.insert(tbOpt, 6, {"Item Pet", self.ItemPet, self,});
		table.insert(tbOpt, 7, {"Huân Chương Vinh Dự", self.HuanChuong, self,});
		table.insert(tbOpt, 8, {"Hoa Tinh", self.HoaTinh, self,});
		table.insert(tbOpt, 9, {"100 Mảnh ghép Luân Hồi Ấn", self.ManhGhepLHA, self,});
		table.insert(tbOpt, 10, {"Ép Chân Nguyên", self.EpChanNguyen, self,});
		table.insert(tbOpt, 11, {"Ép Thánh Linh", self.EpThanhLinh, self,});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:ThemTrangBi()
Dialog:AskNumber("Nhập Genre",300000,self.So11,self, nSo1);
end
function tbLiGuan:So11(nSo11)
Dialog:AskNumber("Nhập DetailType",300000,self.So22 ,self, nSo11, nSo22);
end
function tbLiGuan:So22(nSo11,nSo22)
Dialog:AskNumber("Nhập ParticularType",300000,self.So33 ,self, nSo11, nSo22,nSo33);
end
function tbLiGuan:So33(nSo11,nSo22,nSo33)
Dialog:AskNumber("Nhập Level",10,self.So44 ,self, nSo11, nSo22,nSo33,nSo44);
end
function tbLiGuan:So44(nSo11,nSo22,nSo33,nSo44)
Dialog:AskNumber("Nhập Series",16,self.So55 ,self, nSo11, nSo22,nSo33,nSo44,nSo55);
end
function tbLiGuan:So55(nSo11,nSo22,nSo33,nSo44,nSo55)
Dialog:AskNumber("Cấp Cường Hóa",16,self.KetQua11 ,self, nSo11, nSo22,nSo33,nSo44,nSo55,nSo66);
end
function tbLiGuan:KetQua11(nSo11, nSo22,nSo33,nSo44,nSo55,nSo66)
local pItem = me.AddItem(nSo11, nSo22,nSo33,nSo44,nSo5,nSo66);
		
		me.Msg("Add thành công "..pItem.szName.." cường hóa cấp "..nSo66.."");
end
function tbLiGuan:EpChanNguyen()
	local szMsg = "Chân nguyên tu luyện. Hộ thể cường thân, Phát quang thiên hạ.";
	local tbOpt = {
		{"Tu Luyện <color=gold>Dòng Thứ 1<color>", self.tuluyen1, self},
		{"Tu Luyện <color=gold>Dòng Thứ 2<color>", self.tuluyen2, self},
		{"Tu Luyện <color=gold>Dòng Thứ 3<color>", self.tuluyen3, self},
		{"Tu Luyện <color=gold>Dòng Thứ 4<color>", self.tuluyen4, self},
		{"Kết thúc đối thoại"},
	};
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:tuluyen1()

	local pItem = me.GetEquip(Item.EQUIPPOS_ZHENYUAN_MAIN);
	if pItem == nil then
	me.Msg("Ngươi không trang bị Chân Nguyên. Vui lòng trang bị sau đó mới có thể Tu Luyện");
	return 0;
	end
	local nLevel = pItem.GetGenInfo(1 * 2 - 1, 0);
	if nLevel >= 400 then
	--if nLevel >= 200 then
		me.Msg("Thuộc tính chân nguyên đã đạt tới hạn. Không thể tu luyện thêm");
		return 0;
	end
	--Item:UpgradeZhenYuanNoItem(pItem,100,1);
	Item:UpgradeZhenYuanNoItem(pItem,50000,1);--Test
	me.Msg(string.format("Chúc mừng <color=gold>%s<color> tu luyện Chân Nguyên thành công thuộc tính Dòng Thứ 1 tăng <color=gold> 10,000 điểm<color>.", me.szName));
	
end

function tbLiGuan:tuluyen2(pThisItem)
	
	local pItem = me.GetEquip(Item.EQUIPPOS_ZHENYUAN_MAIN);
	if pItem == nil then
	me.Msg("Ngươi không trang bị Chân Nguyên. Vui lòng trang bị sau đó mới có thể Tu Luyện");
	return 0;
	end
	local nLevel = pItem.GetGenInfo(2 * 2 - 1, 0);
	if nLevel >= 400 then
	me.Msg("Thuộc tính chân nguyên đã đạt tới hạn. Không thể tu luyện thêm");
	return 0;
	end
	--Item:UpgradeZhenYuanNoItem(pItem,100,2);
	Item:UpgradeZhenYuanNoItem(pItem,50000,2);
	me.Msg(string.format("Chúc mừng <color=gold>%s<color> tu luyện Chân Nguyên thành công thuộc tính Dòng Thứ 2 tăng <color=gold> 10,000 điểm<color>.", me.szName));
	
end

function tbLiGuan:tuluyen3(pThisItem)
	local pItem = me.GetEquip(Item.EQUIPPOS_ZHENYUAN_MAIN);
	if pItem == nil then
	me.Msg("Ngươi không trang bị Chân Nguyên. Vui lòng trang bị sau đó mới có thể Tu Luyện");
	return 0;
	end
	local nLevel = pItem.GetGenInfo(3 * 2 - 1, 0);
	if nLevel >= 400 then
	me.Msg("Thuộc tính chân nguyên đã đạt tới hạn. Không thể tu luyện thêm");
	return 0;
	end
	--Item:UpgradeZhenYuanNoItem(pItem,100,3);
	Item:UpgradeZhenYuanNoItem(pItem,50000,3);
	me.Msg(string.format("Chúc mừng <color=gold>%s<color> tu luyện Chân Nguyên thành công thuộc tính Dòng Thứ 3 tăng <color=gold> 10,000 điểm<color>.", me.szName));
	
end

function tbLiGuan:tuluyen4(pThisItem)
	local pItem = me.GetEquip(Item.EQUIPPOS_ZHENYUAN_MAIN);
	if pItem == nil then
	me.Msg("Ngươi không trang bị Chân Nguyên. Vui lòng trang bị sau đó mới có thể Tu Luyện");
	return 0;
	end
	local nLevel = pItem.GetGenInfo(4 * 2 - 1, 0);
	if nLevel >= 400 then
	me.Msg("Thuộc tính chân nguyên đã đạt tới hạn. Không thể tu luyện thêm");
	return 0;
	end
	--Item:UpgradeZhenYuanNoItem(pItem,100,4);
	Item:UpgradeZhenYuanNoItem(pItem,50000,4);
	me.Msg(string.format("Chúc mừng <color=gold>%s<color> tu luyện Chân Nguyên thành công thuộc tính Dòng Thứ 4 tăng <color=gold> 10,000 điểm<color>.", me.szName));
	
end

function tbLiGuan:EpThanhLinh()
	local lhcu = me.GetTask(2123,1);
	local lhmoi = lhcu + 1000000;
	me.SetTask(2123,1,lhmoi);
	me.Msg(string.format("Ngươi vừa tích lũy được thêm <color=gold> 100,000 <color> linh hồn"));
end

function tbLiGuan:KimNguyenBao()
	for i=1,100 do
		me.AddItem(18,1,1338,1);
		me.AddItem(18,1,1338,2);
	end;
end

function tbLiGuan:TamDaiLenhBai()
	for i=1,100 do
		me.AddItem(18, 10, 8, 1);
		me.AddItem(18, 10, 8, 2);
		me.AddItem(18, 10, 8, 3);
	end;
end

function tbLiGuan:ThanhHoaLenh()
	for i=1,100 do
		me.AddItem(18, 10, 9, 1);
		me.AddItem(18, 10, 9, 2);
		me.AddItem(18, 10, 9, 3);
	end;
end

function tbLiGuan:BinhPhap()
	for i=1,100 do
		me.AddItem(18, 10, 10, 1);
		me.AddItem(18, 10, 10, 2);
		me.AddItem(18, 10, 10, 3);
	end;
end

function tbLiGuan:DongTienBac()
	for i=1,100 do
		me.AddItem(18, 10, 11, 1);
		me.AddItem(18, 10, 11, 2);
		me.AddItem(18, 10, 11, 3);
	end;
end

function tbLiGuan:ItemPet()
	for i=1,10 do
		me.AddItem(5, 19, 1, i);	--Vu Khi
		me.AddItem(5, 20, 1, i);	--Ao
		me.AddItem(5, 21, 1, i);	--Nhan
		me.AddItem(5, 22, 1, i);	--Tay
		me.AddItem(5, 23, 1, i);	--Phù
	end;
end

function tbLiGuan:HuanChuong()
	for i=1,100 do
		if me.CountFreeBagCell() > 1 then
			me.AddItem(18,1,920,1); --Huân Chương vinh dự
		else
			break
		end;
	end;
end

function tbLiGuan:LuaTrai()
	me.AddItem(18,1,53,1,0); --Lua trai
	me.AddItem(18,1,53,1,0); --Lua trai
	me.AddItem(18,1,53,1,0); --Lua trai
	me.AddItem(18,1,53,1,0); --Lua trai
	me.AddItem(18,1,53,1,0); --Lua trai
end

function tbLiGuan:Bo20()
	local tbTmpNpc	= Npc:GetClass("tmpnpc1");
	tbTmpNpc:OnDialog();
end

function tbLiGuan:Bo4()
	local tbTmpNpc	= Npc:GetClass("tmpnpc2");
	tbTmpNpc:OnDialog();
end

function tbLiGuan:BoPvp()
	local tbTmpNpc	= Npc:GetClass("tmpnpc3");
	tbTmpNpc:OnDialog();
end

function tbLiGuan:ShowOnline()
	me.Msg("Srv:["..GetServerName().."] Online:"..KPlayer.GetPlayerCount());
end

function tbLiGuan:ShowWorldPos()
	local nMapId, nMapX, nMapY = me.GetWorldPos();
	me.Msg(string.format("%d,\t%d,\t%d", nMapId, nMapX, nMapY));
end

function tbLiGuan:OutputWorldPos(szPosName)
	if (szPosName == nil) then
		szPosName = "";
	end
	
	local nMapId, nMapX, nMapY = me.GetWorldPos();
	me.Msg(string.format("<color=yellow>%s<color>\t%d,\t%d,\t%d", szPosName, nMapId, nMapX, nMapY));
	
	if (g_szPosOutputFileKey == nil) then
		g_szPosOutputFileKey = "pos_output";
		if (KFile.TabFile_Load("\\log\\pos_output.txt", g_szPosOutputFileKey, "true") ~= 1) then
			me.Msg("Mở file \\log\\pos_output.txt thất bại");
			return;
		end
	end
	local nFileRowCount = KFile.TabFile_GetRowCount(g_szPosOutputFileKey);
	if (nFileRowCount == 0) then
		KFile.TabFile_SetCell(g_szPosOutputFileKey, 1, 1, "POS_NAME");
		KFile.TabFile_SetCell(g_szPosOutputFileKey, 1, 2, "MAP_ID");
		KFile.TabFile_SetCell(g_szPosOutputFileKey, 1, 3, "MAP_X");
		KFile.TabFile_SetCell(g_szPosOutputFileKey, 1, 4, "MAP_Y");
		KFile.TabFile_SetCell(g_szPosOutputFileKey, 1, 5, "MINIMAP_X");
		KFile.TabFile_SetCell(g_szPosOutputFileKey, 1, 6, "MINIMAP_Y");
		nFileRowCount = 1;
	end
	local nPosNameRow = KFile.TabFile_Search(g_szPosOutputFileKey, 1, szPosName, 1);
	if (nPosNameRow <= 0) then
		nPosNameRow = nFileRowCount + 1;
	end
	KFile.TabFile_SetCell(g_szPosOutputFileKey, nPosNameRow, 1, szPosName);
	KFile.TabFile_SetCell(g_szPosOutputFileKey, nPosNameRow, 2, nMapId);
	KFile.TabFile_SetCell(g_szPosOutputFileKey, nPosNameRow, 3, nMapX);
	KFile.TabFile_SetCell(g_szPosOutputFileKey, nPosNameRow, 4, nMapY);
	KFile.TabFile_SetCell(g_szPosOutputFileKey, nPosNameRow, 5, math.floor(nMapX / 8));
	KFile.TabFile_SetCell(g_szPosOutputFileKey, nPosNameRow, 6, math.floor(nMapY / 16));
	KFile.TabFile_Save(g_szPosOutputFileKey);
end

function tbLiGuan:lsGameMaster()
	local nIsHide	= GM.tbGMRole:IsHide();
	local tbOpt = {
		{(nIsHide == 1 and "<color=yellow>Hủy Ẩn Thân<color>") or "<color=yellow>Bắt Đầu Ẩn Thân<color>", "GM.tbGMRole:SetHide", 1 - nIsHide},
		--{"<color=yellow>GM<color>", "GM.tbGMRole:MakeGmRole", self},
		{"Nhận <color=Turquoise>Click Max Chân Nguyên<color>",self.ItemFull_8,self};
		-- {"Test Đổi Item Pet", self.TestDoiItemPet, self},

		{"Nhập Tên Nhân Vật", self.AskRoleName, self},
		{"Người Chơi Bên Cạnh", self.AroundPlayer, self},
		{"Thao Tác Gần Đây", self.RecentPlayer, self},
		-- {"Tự Điều Chỉnh Cấp", self.AdjustLevel, self},
		{"Xếp Hạng Danh Vọng",self.XepHangDanhVong,self};
		-- {"Thông Báo Toàn Server",self.ThongBaoToanServer,self};
		{"Đạo cụ tạm thời", self.Daocutamthoi, self},
		-- {"Thêm Vật Phẩm", self.ThemVatPham, self},
		{"Tiêu hủy đạo cụ",  Dialog.Gift, Dialog, "Task.DestroyItem.tbGiveForm"},
		{"Tẩy Tủy", self.OnDialog_taytuy, self},
		-- {"Gọi NPC", self.GoiNPC, self},
		{"Di chuyển", self.DichuyenOnDialog, self},
		{"Nhận 1 ức tiền, đồng", self.ThemTien, self},
		{"Danh Sách Output Người chơi", self.OutputAllPlayer, self},
		{"Triệu tập tất cả người chơi", self.ComeHereAll, self},
		{"Danh sách người chơi", self.ListAllPlayer, self},
		--{"Nhận Tu Luyện Time", self.TuLuyen, self},
		--{"Nhập Trang Bị", self.NhapTrangBi, self},
		--{"Thêm Kỹ Năng", self.ThemKyNang, self},
		--{"Phóng viên thi đấu liên server", self.LookWldh, self},
		--{"Hoàng Lăng không giới hạn", self.SuperQinling, self},
		{"Kết thúc đối thoại"},
	};
	local tbRecentPlayerList	= me.GetTempTable("GM").tbRecentPlayerList or {};
	for nIndex, nPlayerId in ipairs(tbRecentPlayerList) do
		local tbInfo	= self.tbRemoteList[nPlayerId];
		if (tbInfo) then
			tbOpt[#tbOpt+1]	= {"<color=green>"..tbInfo[1], self.SelectPlayer, self, nPlayerId, tbInfo[1]};
		end
	end
	Dialog:Say("<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK", tbOpt);
	self.tbRemoteList	= {};
	GlobalExcute({"GM.tbPlayer:RemoteList_Fetch", me.nId})
	DoScript("\\script\\misc\\gm_player.lua");
	return 0;
end;
function tbLiGuan:TestMoKhoaTrangBi()
	local szMsg = "Đặt vào Item Cần Cường Hóa";
	Dialog:OpenGift(szMsg, nil, {self.CuongHoa23, self, 1});
end
function tbLiGuan:CuongHoa23(nValue, tbItemObj)
	local tbItemList	= {};
	local nCount = 0; 
    for i = 1, #tbItemObj do 
        nCount = nCount + tbItemObj[i][1].nCount; 
    end 

    if nCount ~= 1 then 
        Dialog:Say("Chỉ được đặt vào 1 vật phẩm", {"Ta biết rồi !"}); 
        return 0; 
    end 
	for _, pItem in pairs(tbItemObj) do
		local pItem1 =	me.AddStackItem(pItem[1].nGenre, pItem[1].nDetail, pItem[1].nParticular, pItem[1].nLevel,self.tbItemInfo,1);
	end
	for _, pItem in pairs(tbItemObj) do
		if me.DelItem(pItem[1]) ~= 1 then
			return 0;
		end
	end
end
function tbLiGuan:ThemKinhNghiem()

end
function tbLiGuan:TestThemKinhNghiem(szKinhNghiem)
me.AddExp(10000000000)
end
function tbLiGuan:ItemFull_8()
	local pItem = me.GetEquip(Item.EQUIPPOS_ZHENYUAN_MAIN);
Item:UpgradeZhenYuanNoItem(pItem,1000000,1);
Item:UpgradeZhenYuanNoItem(pItem,1000000,2);
Item:UpgradeZhenYuanNoItem(pItem,1000000,3);
Item:UpgradeZhenYuanNoItem(pItem,1000000,4);
end
function tbLiGuan:VangDoiChienCong()
local msg = "15h30 : Move Hết Về 187/204 Đại Lý\n"..
"16h05 : Gọi Đợt Quái Đầu 15 Con\n"..
"16h15 : Gọi Đợt Quái Hai 15 Con\n"..
"16h25 : Gọi Đợt Quái Ba 15 Con\n"..
"16h30 : Gọi Đợt Quái Tư 15 Con\n"..
"1 Con Quái Rớt Ra 35% Lam Long Đơn , 65% Huân Chương Bạc"
local tbOpt = {
{"Triệu Tập Về Đại Lý", self.TrieuTapMember, self},
{"Gọi Đợt 1 (16h05)", self.GoiBoss_1, self},
{"Gọi Đợt 2 (16h15)", self.GoiBoss_2, self},
{"Gọi Đợt 3 (16h25)", self.GoiBoss_3, self},
{"Gọi Đợt 4 (16h30)", self.GoiBoss_4, self},
{"Kết thúc đối thoại"},
};
Dialog:Say(msg, tbOpt);
end
function tbLiGuan:TrieuTapMember()
local nTime = tonumber(os.date("%H%M", GetTime()));
local nHour = tonumber(os.date("%H", GetTime()));
local nMinute = tonumber(os.date("%M", GetTime()));
local nSecond = tonumber(os.date("%S", GetTime()));
-- if nTime < 1545 then
-- Dialog:Say("Bây giờ là "..nHour.." Giờ "..nMinute.." Phút "..nSecond.." Giây. \n15h45 Mới được phép triệu tập")
-- return
-- end
local nMapId, nMapX, nMapY = me.GetWorldPos();
me.Msg("Triệu tập tất cả !");
-- self:RemoteCall_ApplyAll("me.NewWorld", nMapId, nMapX, nMapY);
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Giặc Ngoại Xâm<color> đang chuẩn bị tiến công tới <pos=28,1500,3275> Lâm An Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Giặc Ngoại Xâm<color> đang chuẩn bị tiến công tới <pos=28,1500,3275> Lâm An Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color><color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Giặc Ngoại Xâm<color> đang chuẩn bị tiến công tới <pos=28,1500,3275> Lâm An Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>");	
end
function tbLiGuan:GoiBoss_1()
local nTime = tonumber(os.date("%H%M", GetTime()));
local nHour = tonumber(os.date("%H", GetTime()));
local nMinute = tonumber(os.date("%M", GetTime()));
local nSecond = tonumber(os.date("%S", GetTime()));
-- if nTime < 1605 then
-- Dialog:Say("Bây giờ là "..nHour.." Giờ "..nMinute.." Phút "..nSecond.." Giây. \n16h05 Mới được phép Gọi Đợt 1 (16h05)")
-- return
-- end
KNpc.Add2(20214, 255, 0, 28, 1493, 3269)
KNpc.Add2(20214, 255, 0, 28, 1493, 3264)
KNpc.Add2(20214, 255, 0, 28, 1487, 3272)
KNpc.Add2(20214, 255, 0, 28, 1493, 3276)
KNpc.Add2(20214, 255, 0, 28, 1499, 3269)
KNpc.Add2(20214, 255, 0, 28, 1498, 3261)
KNpc.Add2(20214, 255, 0, 28, 1503, 3262)
KNpc.Add2(20214, 255, 0, 28, 1508, 3266)
KNpc.Add2(20214, 255, 0, 28, 1508, 3284)
KNpc.Add2(20214, 255, 0, 28, 1512, 3284)
KNpc.Add2(20214, 255, 0, 28, 1519, 3279)
KNpc.Add2(20214, 255, 0, 28, 1519, 3267)
KNpc.Add2(20214, 255, 0, 28, 1531, 3267)
KNpc.Add2(20214, 255, 0, 28, 1533, 3279)
KNpc.Add2(20214, 255, 0, 28, 1520, 3284)
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Lâm An Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Lâm An Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color><color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Lâm An Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>");	
end
function tbLiGuan:GoiBoss_2()
local nTime = tonumber(os.date("%H%M", GetTime()));
local nHour = tonumber(os.date("%H", GetTime()));
local nMinute = tonumber(os.date("%M", GetTime()));
local nSecond = tonumber(os.date("%S", GetTime()));
if nTime < 1615 then
Dialog:Say("Bây giờ là "..nHour.." Giờ "..nMinute.." Phút "..nSecond.." Giây. \n16h15 Mới được phép Gọi Đợt 2 (16h15)")
return
end
KNpc.Add2(20214, 255, 0, 28, 1493, 3269)
KNpc.Add2(20214, 255, 0, 28, 1493, 3264)
KNpc.Add2(20214, 255, 0, 28, 1487, 3272)
KNpc.Add2(20214, 255, 0, 28, 1493, 3276)
KNpc.Add2(20214, 255, 0, 28, 1499, 3269)
KNpc.Add2(20214, 255, 0, 28, 1498, 3261)
KNpc.Add2(20214, 255, 0, 28, 1503, 3262)
KNpc.Add2(20214, 255, 0, 28, 1508, 3266)
KNpc.Add2(20214, 255, 0, 28, 1508, 3284)
KNpc.Add2(20214, 255, 0, 28, 1512, 3284)
KNpc.Add2(20214, 255, 0, 28, 1519, 3279)
KNpc.Add2(20214, 255, 0, 28, 1519, 3267)
KNpc.Add2(20214, 255, 0, 28, 1531, 3267)
KNpc.Add2(20214, 255, 0, 28, 1533, 3279)
KNpc.Add2(20214, 255, 0, 28, 1520, 3284)
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Lâm An Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Lâm An Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color><color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Lâm An Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>");	
end
function tbLiGuan:GoiBoss_3()
local nTime = tonumber(os.date("%H%M", GetTime()));
local nHour = tonumber(os.date("%H", GetTime()));
local nMinute = tonumber(os.date("%M", GetTime()));
local nSecond = tonumber(os.date("%S", GetTime()));
if nTime < 1625 then
Dialog:Say("Bây giờ là "..nHour.." Giờ "..nMinute.." Phút "..nSecond.." Giây. \n16h25 Mới được phép Gọi Đợt 3 (16h25)")
return
end
KNpc.Add2(20214, 255, 0, 28, 1493, 3269)
KNpc.Add2(20214, 255, 0, 28, 1493, 3264)
KNpc.Add2(20214, 255, 0, 28, 1487, 3272)
KNpc.Add2(20214, 255, 0, 28, 1493, 3276)
KNpc.Add2(20214, 255, 0, 28, 1499, 3269)
KNpc.Add2(20214, 255, 0, 28, 1498, 3261)
KNpc.Add2(20214, 255, 0, 28, 1503, 3262)
KNpc.Add2(20214, 255, 0, 28, 1508, 3266)
KNpc.Add2(20214, 255, 0, 28, 1508, 3284)
KNpc.Add2(20214, 255, 0, 28, 1512, 3284)
KNpc.Add2(20214, 255, 0, 28, 1519, 3279)
KNpc.Add2(20214, 255, 0, 28, 1519, 3267)
KNpc.Add2(20214, 255, 0, 28, 1531, 3267)
KNpc.Add2(20214, 255, 0, 28, 1533, 3279)
KNpc.Add2(20214, 255, 0, 28, 1520, 3284)
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Lâm An Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Lâm An Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color><color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Lâm An Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>");	
end
function tbLiGuan:GoiBoss_4()
local nTime = tonumber(os.date("%H%M", GetTime()));
local nHour = tonumber(os.date("%H", GetTime()));
local nMinute = tonumber(os.date("%M", GetTime()));
local nSecond = tonumber(os.date("%S", GetTime()));
if nTime < 1630 then
Dialog:Say("Bây giờ là "..nHour.." Giờ "..nMinute.." Phút "..nSecond.." Giây. \n16h30 Mới được phép Gọi Đợt 4 (16h30)")
return
end
KNpc.Add2(20214, 255, 0, 28, 1493, 3269)
KNpc.Add2(20214, 255, 0, 28, 1493, 3264)
KNpc.Add2(20214, 255, 0, 28, 1487, 3272)
KNpc.Add2(20214, 255, 0, 28, 1493, 3276)
KNpc.Add2(20214, 255, 0, 28, 1499, 3269)
KNpc.Add2(20214, 255, 0, 28, 1498, 3261)
KNpc.Add2(20214, 255, 0, 28, 1503, 3262)
KNpc.Add2(20214, 255, 0, 28, 1508, 3266)
KNpc.Add2(20214, 255, 0, 28, 1508, 3284)
KNpc.Add2(20214, 255, 0, 28, 1512, 3284)
KNpc.Add2(20214, 255, 0, 28, 1519, 3279)
KNpc.Add2(20214, 255, 0, 28, 1519, 3267)
KNpc.Add2(20214, 255, 0, 28, 1531, 3267)
KNpc.Add2(20214, 255, 0, 28, 1533, 3279)
KNpc.Add2(20214, 255, 0, 28, 1520, 3284)
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Lâm An Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>"});
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Lâm An Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color><color>");
KDialog.MsgToGlobal("<color=yellow><color=pink>Giặc Ngoại Xâm<color> công tới <pos=28,1500,3275> Lâm An Phủ . Lệnh triệu tập các nhân sĩ có hiệu lệnh !<color>");	
end
--------------
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
{"Đổi <color=Green2>Item Pet Cấp 2", self.DoiTrangBiPet2, self},
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
-------------------
function tbLiGuan:GoiCauCa()
 GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow>Sự Kiện Vớt Cá Mắc Cạn bắt đầu tại <pos=1,1422,3183> . Mau chân tới vớt cá nào các nhân sĩ<color>"});
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow><color=yellow>Sự Kiện Vớt Cá Mắc Cạn bắt đầu tại <pos=1,1422,3183> . Mau chân tới vớt cá nào các nhân sĩ<color>");
	KDialog.MsgToGlobal("<color=yellow><color=yellow>Sự Kiện Vớt Cá Mắc Cạn bắt đầu tại <pos=1,1422,3183> . Mau chân tới vớt cá nào các nhân sĩ<color>");	
KNpc.Add2(20216, 255, 0, 1, 1420, 3185)
end
function tbLiGuan:XoaCauCa()
GlobalExcute({"Dialog:GlobalNewsMsg_GS","<color=yellow>Sự Kiện Vớt Cá Mắc Cạn đã kết thúc mai tới tiếp nhé<color>"});
	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"<color=yellow>Sự Kiện Vớt Cá Mắc Cạn đã kết thúc mai tới tiếp nhé<color>");
	KDialog.MsgToGlobal("<color=yellow>Sự Kiện Vớt Cá Mắc Cạn đã kết thúc mai tới tiếp nhé<color>");	
ClearMapNpcWithName(1, "");
end
function tbLiGuan:MuaTLHL1()
if me.CountFreeBagCell() < 5 then
		Dialog:Say("Phải Có 5 Ô Trống Trong Túi Hành Trang!");
		return 0;
	end
local nCount = me.GetJbCoin()
if nCount < 10000 then
Dialog:Say("Trong người ngươi hiện chỉ có <color=cyan>"..nCount.."<color> Đồng không đủ mua <color=cyan>5k Tinh Lực + Hoạt Lực<color>")
return 0;
end
me.ChangeCurMakePoint(5000);--X là số tinh lực cần add
me.ChangeCurGatherPoint(5000);-- Y là số hoạt lực cần add
me.AddJbCoin(-1*10000)
end
---------------------
function tbLiGuan:XoaNPC1()
	Dialog:AskNumber("ID Map",500,self.So2111,self, nSo15);
end
function tbLiGuan:So2111(nSo15)
Dialog:AskString("Nhập Tên",300000,self.KetQua123456 ,self, nSo15, tenboss);
end
function tbLiGuan:KetQua123456(nSo15,tenboss)
local nMapId, nPosX, nPosY = me.GetWorldPos();
ClearMapNpcWithName(nSo15, ""..tenboss.."");
me.Msg("<color=yellow>Đã xóa <color=Turquoise>"..tenboss.."<color> tại <color=Turquoise>"..GetMapNameFormId(nMapId).."<color> (Số "..nSo15..")<color>") 
end
---------------
function tbLiGuan:ThemNPC1()
	Dialog:AskNumber("Nhập ID NPC",300000,self.SoIDNPC,self, nSoIDNPC);
end
function tbLiGuan:SoIDNPC(nSoIDNPC)
Dialog:AskNumber("Nhập Level NPC",255,self.KetQuaGoiNPC ,self, nSoIDNPC, nSoLevelNPC);
end
function tbLiGuan:KetQuaGoiNPC(nSoIDNPC, nSoLevelNPC)
local nMapId, nPosX, nPosY = me.GetWorldPos();
local pNpc = KNpc.Add2(nSoIDNPC, nSoLevelNPC, 0, nMapId, nPosX, nPosY)
-- KNpc.Add2(szIDNPC, 255, 0, nMapId, nPosX, nPosY)
me.Msg("<color=yellow>Đã gọi <color=Turquoise>"..pNpc.szName.."<color> (Cấp "..nSoLevelNPC..") tại <color=Turquoise>"..GetMapNameFormId(nMapId).."<color> tọa độ <color=Turquoise>"..math.floor(nPosX/8).."/"..math.floor(nPosY/16).."<color>")
end
function tbLiGuan:ThemItem()
Dialog:AskNumber("Nhập Genre",300000,self.So1,self, nSo1);
-- me.AddTitle(13,1,1,9)
end
function tbLiGuan:So1(nSo1)
Dialog:AskNumber("Nhập DetailType",300000,self.So2 ,self, nSo1, nSo2);
end
function tbLiGuan:So2(nSo1,nSo2)
Dialog:AskNumber("Nhập ParticularType",300000,self.So3 ,self, nSo1, nSo2,nSo3);
end
function tbLiGuan:So3(nSo1,nSo2,nSo3)
Dialog:AskNumber("Nhập Level",300000,self.So4 ,self, nSo1, nSo2,nSo3,nSo4);
end
function tbLiGuan:So4(nSo1,nSo2,nSo3,nSo4)
Dialog:AskNumber("Nhập Số Lượng",500,self.KetQua ,self, nSo1, nSo2,nSo3,nSo4,nSo5);
end
function tbLiGuan:KetQua(nSo1, nSo2,nSo3,nSo4,nSo5)
me.AddStackItem(nSo1, nSo2,nSo3,nSo4,nil,nSo5);
end
function tbLiGuan:Tuluyen()
 me.AddXiuWeiTime(10000000);
end

function tbLiGuan:DichuyenOnDialog()
 local tbOpt = {
   {"Đảo Tẩy Tủy", me.NewWorld, 255, 1652, 3389},
   {"Hoàng Lăng", me.NewWorld, 1536, 1567, 3629},
   {"Vân Lĩnh", self.vanlinh, self},
   
 };
 Dialog:Say("Chọn nơi muốn đến!", tbOpt);
end

function tbLiGuan:vanlinh()
	Task.FourfoldMap:ApplyTeamMap(1, 2, 0);
end

function tbLiGuan:OnDialog_taytuy()
	local tbOpt = {};
	local nChangeGerneIdx = Faction:GetChangeGenreIndex(me);
		if(nChangeGerneIdx >= 1)then
			local szMsg;
				if(Faction:Genre2Faction(me, nChangeGerneIdx) > 0 )then --كז`ӑў
					szMsg = "Tôi muốn chọn phái song tu";
				else
					szMsg = "Tôi muốn tẩy điểm võ công";
				end
			table.insert(tbOpt, {szMsg, self.OnChangeGenreFaction, self, me});
		end
		table.insert(tbOpt, {"Tẩy điểm tiềm năng", self.OnResetDian, self, me, 1});
		table.insert(tbOpt, {"Tẩy điểm kỹ năng", self.OnResetDian, self, me, 2});
		table.insert(tbOpt, {"Tẩy điểm Tiềm năng và kỹ năng", self.OnResetDian, self, me, 0});
		table.insert(tbOpt, {"Không thèm tẩy nữa"});
	local szMsg = "Tôi sẽ rửa được điểm được giao và điểm kỹ năng của tiềm năng cho bạn để phân bổ lại. Ở phía sau có một hang động, nơi bạn có thể trải nghiệm những cuộc chiến sau khi thử nghiệm hiệu quả của việc phân phối lại. Nếu không, bạn có thể quay lại với tôi. Khi bạn đã hài lòng với việc chuyển giao của người dân từ võ nghệ thuật ở mặt sau của võ nghệ thuật của bạn.";
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:OnResetDian(pPlayer, nType)
	local szMsg = "";
		if (1 == nType) then
			pPlayer.SetTask(2,1,1);
			pPlayer.UnAssignPotential();
			szMsg = "Tẩy điểm thành công. có thể lại điểm Tiềm Năng";
		elseif (2 == nType) then
			pPlayer.ResetFightSkillPoint();
			szMsg = "Tẩy điểm thành công. có thể cộng lại điểm Kỹ Năng";
		elseif (0 == nType) then
			pPlayer.ResetFightSkillPoint();
			pPlayer.SetTask(2,1,1);
			pPlayer.UnAssignPotential();
			szMsg = "Tẩy điểm thành công, có thể cộng lại điểm Tiềm Năng và Kỹ Năng.";
		end
	Setting:SetGlobalObj(pPlayer);
	Dialog:Say(szMsg);
	Setting:RestoreGlobalObj();
end

function tbLiGuan:OnChangeGenreFaction(pPlayer)
	local tbOpt = {};
	local nFactionGenre = Faction:GetChangeGenreIndex(pPlayer);
		for nFactionId, tbFaction in ipairs(Player.tbFactions) do
			if (Faction:CheckGenreFaction(pPlayer, nFactionGenre, nFactionId) == 1) then
				table.insert(tbOpt, {tbFaction.szName, self.OnChangeGenreFactionSelected, self, pPlayer, nFactionId});
			end
		end
		table.insert(tbOpt,{"Kết thúc đối thoại"});
	local szMsg = "Hãy chọn lại môn phái mà bạn muốn gia nhập vào.";
	Setting:SetGlobalObj(pPlayer);
	Dialog:Say(szMsg, tbOpt);
	Setting:RestoreGlobalObj();
end

function tbLiGuan:OnChangeGenreFactionSelected(pPlayer, nFactionId)
	local nGenreId   = Faction:GetChangeGenreIndex(pPlayer);
	local nPrevFaction   = Faction:Genre2Faction(pPlayer, nGenreId);
	local nResult, szMsg = Faction:ChangeGenreFaction(pPlayer, nGenreId, nFactionId);
		if(nResult == 1)then
			if (nPrevFaction == 0) then -- ֚һՎנў
				szMsg = "Bạn đã chọn %s Hãy tìm gặp thương nhân tẩy tủy để mua loại vũ khí của môn phái bạn vừa chọn dùng. Hãy chú ý lựa chọn đúng loại vũ khí của môn phái đó nhé.";
			else
				szMsg = "Bạn đã chuyển sang %s，Chú ý khi thay đổi phái thì Hệ trên phi phong và Hệ của ngũ hành ấn cũng thay đổi theo."
			end
			szMsg = string.format(szMsg, Player.tbFactions[nFactionId].szName);
		end
	Setting:SetGlobalObj(pPlayer);
	Dialog:Say(szMsg);
	Setting:RestoreGlobalObj();
end 

function tbLiGuan:Daocutamthoi()
	local szMsg = "Ta có thể giúp gì cho ngươi";
	local tbOpt = {};
	table.insert(tbOpt , {"Đồ hỗ trợ",  self.dohotro, self});
	table.insert(tbOpt , {"Túi Truyền Tống",  self.tuitruyentong, self});
	table.insert(tbOpt , {"Túi Kỹ Năng",  self.tuikynang, self});
	table.insert(tbOpt , {"Túi Nhiệm Vụ",  self.tuinhiemvu, self});
	table.insert(tbOpt , {"Túi Người Chơi",  self.tuinguoichoi, self});
	table.insert(tbOpt , {"Chiến trường Tống Kim",  self.chtrgtongkim, self});
	table.insert(tbOpt ,{"Cường Hóa Ấn <color=wheat>1500<color>", self.UpDateWuXingYin, self});
	table.insert(tbOpt , {"Kết thúc đối thoại"});
	Dialog:Say(szMsg, tbOpt);
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
		{"Nhận Luân Hồi Ấn", self.GetWuXingYin1, self},
		{"Cường hóa ngũ hành tương khắc <color=red>1500<color>", self.UpWuXingYin1, self, 1},
		{"Nhược hóa ngũ hành tương khắc <color=red>1500<color>", self.UpWuXingYin1, self, 2},
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
		Dialog:Say("Luân Hồi Ấn đã thăng cấp tối đa.");
		return 0;
	end
	nLevel = nLevel + 1000;
	if nLevel > 1000 then
		nLevel = 1000;
	end
	Item:SetSignetMagic(pSignet, nMagicIndex, nLevel, 0);
	Dialog:Say("Chúc mừng bạn Thăng cấp Luân Hồi Ấn Thành công");
end
function tbLiGuan:dohotro()
	local tbTmpNpc	= Npc:GetClass("tmpnpc");
	tbTmpNpc:OnDialog();
end

function tbLiGuan:tuitruyentong()
	local tbItem	= Item:GetClass("tempitem");
	tbItem:OnTransPak(tbItem.tbMap);
end

function tbLiGuan:tuikynang()
	local tbItem	= Item:GetClass("tempitem");
	tbItem:OnSkillPak();
end

function tbLiGuan:tuinhiemvu()
	local tbItem	= Item:GetClass("tempitem");
	tbItem:OnTaskItemPak(tbItem.tbItems);
end

function tbLiGuan:tuinguoichoi()
	GM.tbPlayer:Main();
end

function tbLiGuan:chtrgtongkim()
	Battle:GM();
end

function tbLiGuan:NhapTrangBi(nFlag, nSeries)
	if not nFlag then
		local szMsg = "Nhận trang bị hệ nào?";
		local tbOpt =
		{
			{"Hệ Kim",self.NhapTrangBi,self,1,1},
			{"Hệ Mộc",self.NhapTrangBi,self,1,2},
			{"Hệ Thủy",self.NhapTrangBi,self,1,3},
			{"Hệ Hỏa",self.NhapTrangBi,self,1,4},
			{"Hệ Thổ",self.NhapTrangBi,self,1,5},
		}
		Dialog:Say(szMsg,tbOpt);
	elseif nFlag == 1 then
		local szMsg = "Nam hay nữ?";
		local tbOpt =
		{
			{"Nam",self.NhapTrangBi,self,2,nSeries},
			{"Nữ",self.NhapTrangBi,self,2,nSeries+5},
		}
		Dialog:Say(szMsg,tbOpt);
	else	
			local tbItems = self.tbSetItem;
			for i = 1, 23 do
				me.AddItem(unpack(tbItems[i][nSeries]));
			end
	end
end

tbLiGuan.tbSetItem = {
		{{2,6,257,10},{2,6,258,10},{2,6,259,10},{2,4,264,10},{2,6,261,10},{2,6,257,10},{2,6,258,10},{2,6,259,10},{2,4,264,10},{2,6,261,10},},
		{{2,7,513,10},{2,7,515,10},{2,7,517,10},{2,5,349,10},{2,7,521,10},{2,7,514,10},{2,7,516,10},{2,7,518,10},{2,7,520,10},{2,7,522,10},},
		{{2,10,713,10},{2,10,715,10},{2,10,717,10},{2,6,260,10},{2,10,721,10},{2,10,714,10},{2,10,716,10},{2,10,718,10},{2,10,720,10},{2,10,722,10},},
		{{2,5,346,10},{2,5,347,10},{2,5,348,10},{2,7,519,10},{2,5,350,10},{2,5,346,10},{2,5,347,10},{2,5,348,10},{2,7,519,10},{2,5,350,10},},
		{{2,11,721,10},{2,11,723,10},{2,11,725,10},{2,10,719,10},{2,11,729,10},{2,11,722,10},{2,11,724,10},{2,11,726,10},{2,11,728,10},{2,11,730,10},},
		{{2,4,261,10},{2,4,262,10},{2,4,263,10},{2,11,727,10},{2,4,265,10},{2,4,261,10},{2,4,262,10},{2,4,263,10},{2,11,727,10},{2,4,265,10},},
		{{4,6,95,10},{4,6,100,10},{4,6,105,10},{4,3,161,10},{4,6,115,10},{4,6,95,10},{4,6,100,10},{4,6,105,10},{4,3,151,10},{4,6,115,10},},
		{{4,3,158,10},{4,3,159,10},{4,3,160,10},{4,3,236,10},{4,3,162,10},{4,3,148,10},{4,3,149,10},{4,3,150,10},{4,4,460,10},{4,3,152,10},},
		{{4,8,353,10},{4,8,373,10},{4,8,393,10},{4,4,460,10},{4,8,433,10},{4,8,354,10},{4,8,374,10},{4,8,394,10},{4,8,414,10},{4,8,434,10},},
		{{4,8,459,10},{4,8,463,10},{4,8,467,10},{4,4,461,10},{4,8,475,10},{4,8,460,10},{4,8,464,10},{4,8,468,10},{4,4,461,10},{4,8,476,10},},
		{{4,9,487,10},{4,9,489,10},{4,9,491,10},{4,5,463,10},{4,9,495,10},{4,9,488,10},{4,9,490,10},{4,9,492,10},{4,8,472,10},{4,9,496,10},},
		{{4,10,461,10},{4,10,465,10},{4,10,469,10},{4,5,464,10},{4,10,477,10},{4,10,462,10},{4,10,466,10},{4,10,470,10},{4,5,463,10},{4,10,478,10},},
		{{4,10,463,10},{4,10,467,10},{4,10,471,10},{4,6,110,10},{4,10,479,10},{4,10,464,10},{4,10,468,10},{4,10,472,10},{4,9,494,10},{4,10,480,10},},
		{{4,10,501,10},{4,10,505,10},{4,10,509,10},{4,7,47,10},{4,10,517,10},{4,10,502,10},{4,10,506,10},{4,10,510,10},{4,5,464,10},{4,10,518,10},},
		{{4,10,503,10},{4,10,507,10},{4,10,511,10},{4,8,413,10},{4,10,519,10},{4,10,504,10},{4,10,508,10},{4,10,512,10},{4,10,474,10},{4,10,520,10},},
		{{4,3,233,10},{4,3,234,10},{4,3,235,10},{4,8,471,10},{4,3,237,10},{4,3,238,10},{4,3,239,10},{4,3,240,10},{4,6,110,10},{4,3,242,10},},
		{{4,4,454,10},{4,4,456,10},{4,4,458,10},{4,9,493,10},{4,4,462,10},{4,4,454,10},{4,4,456,10},{4,4,458,10},{4,10,476,10},{4,4,462,10},},
		{{4,4,455,10},{4,4,457,10},{4,4,459,10},{4,10,473,10},{4,4,463,10},{4,4,455,10},{4,4,457,10},{4,4,459,10},{4,10,514,10},{4,4,463,10},},
		{{4,7,41,10},{4,7,43,10},{4,7,45,10},{4,10,475,10},{4,7,49,10},{4,7,42,10},{4,7,44,10},{4,7,46,10},{4,10,516,10},{4,7,50,10},},
		{{4,5,457,10},{4,5,459,10},{4,5,461,10},{4,10,513,10},{4,5,465,10},{4,5,457,10},{4,5,459,10},{4,5,461,10},{4,3,241,10},{4,5,465,10},},
		{{4,5,458,10},{4,5,460,10},{4,5,462,10},{4,10,515,10},{4,5,466,10},{4,5,458,10},{4,5,460,10},{4,5,462,10},{4,7,48,10},{4,5,466,10},},
		{{4,11,81,10},{4,11,83,10},{4,11,85,10},{4,11,87,10},{4,11,89,10},{4,11,82,10},{4,11,84,10},{4,11,86,10},{4,11,88,10},{4,11,90,10},},
		{{4,11,91,10},{4,11,93,10},{4,11,95,10},{4,11,97,10},{4,11,99,10},{4,11,92,10},{4,11,94,10},{4,11,96,10},{4,11,98,10},{4,11,100,10},},
}

function tbLiGuan:ThemTien()
	me.AddJbCoin(100000000);
	me.AddBindCoin(100000000);
	me.Earn(100000000,0);
	me.AddBindMoney(100000000);
end

function tbLiGuan:GoiNPC(nFlag, nID, nLevel, nSeries)
	if not nFlag  then
		Dialog:AskNumber("Nhập ID NPC",30000, self.GoiNPC, self, 1);
	elseif nFlag == 1 then 
		Dialog:AskNumber("Nhập Level NPC",150, self.GoiNPC, self, 2, nID);
	elseif nFlag == 2 then
		Dialog:AskNumber("Nhập Series NPC",150, self.GoiNPC, self, 3, nID, nLevel);
	elseif nFlag == 3 then
		local nMapId, nPosX, nPosY = me.GetWorldPos();
		local pNpc = KNpc.Add2( nID , nLevel, nSeries , nMapId, nPosX, nPosY, 0, 1);
		if pNpc then
			me.Msg(string.format("Npc đã nhập (%d, %d, %d)!",nID, nLevel, nSeries));
		end
	end

end

function tbLiGuan:ThemKyNang(nFlag,nSkill,nSkillLevel)
	if not nFlag then
		Dialog:AskNumber("Nhập Skill ID",30000, self.ThemKyNang,self,1);
	elseif nFlag ==1 then
		Dialog:AskNumber("Nhập Skill Level",30000, self.ThemKyNang,self,2,nSkill);
	else
	me.AddFightSkill(nSkill,nSkillLevel);	
	end
end

function tbLiGuan:ThemVatPham()
	Dialog:AskNumber("Nhập Genre",300000, self.Genre,self);
end

function tbLiGuan:Genre(nGenre)
	Dialog:AskNumber("Nhập Detail",300000,self.Detail,self, nGenre);
end

function tbLiGuan:Detail(nGenre, nDetail)
Dialog:AskNumber("Nhập Particular",300000,self.Particular,self, nGenre, nDetail);
end

function tbLiGuan:Particular(nGenre, nDetail, nParticular)
Dialog:AskNumber("Nhập Level",300000,self.Level ,self, nGenre, nDetail, nParticular);
end

function tbLiGuan:Level(nGenre, nDetail, nParticular, nLevel)
Dialog:AskNumber("Nhập Series",300000,self.nSeries ,self, nGenre, nDetail, nParticular, nLevel);
end

function tbLiGuan:nSeries(nGenre, nDetailType, nParticularType, nLevel, nSeries)
local szMsg=string.format("Item đã nhập là là %d, %d, %d, %d, %d!", nGenre, nDetailType, nParticularType, nLevel, nSeries);
	if szMsg then
	me.AddItem(nGenre, nDetailType, nParticularType, nLevel, nSeries);
	me.Msg(szMsg);
	end
end

function tbLiGuan:SuperQinling()
	me.NewWorld(1536, 1567, 3629);
	me.SetTask(2098, 1, 0);
	me.AddSkillState(1413, 4, 1, 2 * 60 * 60 * Env.GAME_FPS, 1, 1);
end

function tbLiGuan:AskRoleName()
	Dialog:AskString("Tên nhân vật", 16, self.OnInputRoleName, self);
end

function tbLiGuan:OnInputRoleName(szRoleName)
	local nPlayerId	= KGCPlayer.GetPlayerIdByName(szRoleName);
	if (not nPlayerId) then
		Dialog:Say("Tên này không tồn tại!", {"Nhập lại", self.AskRoleName, self}, {"Kết thúc đối thoại"});
		return;
	end
	self:ViewPlayer(nPlayerId);
end

function tbLiGuan:ViewPlayer(nPlayerId)
	-- 插入最近玩家列表
	--[[local tbRecentPlayerList	= self.tbRecentPlayerList or {};
	self.tbRecentPlayerList		= tbRecentPlayerList;
	for nIndex, nRecentPlayerId in ipairs(tbRecentPlayerList) do
		if (nRecentPlayerId == nPlayerId) then
			table.remove(tbRecentPlayerList, nIndex);
			break;
		end
	end
	if (#tbRecentPlayerList >= self.MAX_RECENTPLAYER) then
		table.remove(tbRecentPlayerList);
	end
	table.insert(tbRecentPlayerList, 1, nPlayerId);

	local szName	= KGCPlayer.GetPlayerName(nPlayerId);
	local tbInfo	= GetPlayerInfoForLadderGC(szName);
	local tbState	= {
		[0]		= "Không online",
		[-1]	= "Đang xử lý",
		[-2]	= "Auto?",
	};
	local nState	= KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_ONLINESERVER);
	local pPlayer    = KPlayer.GetPlayerObjById(nPlayerId);
	local szIp	= pPlayer.GetPlayerIpAddress();
	local nMapId, nPosX, nPosY = pPlayer.GetWorldPos();
	local szBT = pPlayer.nTotalMoney;
	local szBK = pPlayer.GetBindMoney();
	local szBTT	= (string.format(" %d Vạn",szBT/10000));
	local szBKK	= (string.format(" %d Vạn",szBK/10000));
	local szDT = pPlayer.nCoin;
	local szDK = pPlayer.nBindCoin;
	local szTNC = pPlayer.nRemainPotential;
	local szTNSM = pPlayer.nStrength;
	local szTNTP = pPlayer.nDexterity;
	local szTNNGC = pPlayer.nVitality;
	local szTNNC = pPlayer.nEnergy;
	local szDTT	= (string.format(" %d Vạn",szDT/10000));
	local szDKK	= (string.format(" %d Vạn",szDK/10000));
	local szMap	= (string.format(" %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
    local nLevel = me.GetTask(tbLiGuan.TASK_GR_DO,tbLiGuan.TASK_ID_nLevel);
	local tbText	= {
		{"Tên :", szName},
		{"Tài khoản :", tbInfo.szAccount},
		{"IP hiện tại :  " , szIp},
		{"Đang đứng tại Map" , szMap},
		{"nPlayerId ", nPlayerId},
		{"Cấp :", tbInfo.nLevel},
		{"Giới tính :", (tbInfo.nSex == 1 and "Nữ") or "Nam"},
		{"Hệ phái :", Player:GetFactionRouteName(tbInfo.nFaction, tbInfo.nRoute)},
		{"Bạc thường : ", szBTT},
		{"Bạc khóa : ", szBKK},
		{"đồng thường : ", szDTT},
		{"đồng khóa : ", szDKK},
		{"Tiềm Năng Còn: ", szTNC},
        {"Sức Mạnh: ", szTNTP},
        {"Thân Pháp: ", szTNTP},
        {"Ngoại Công: ", szTNNGC},
		{"Nội Công: ", szTNNC},
		{"Tộc :", tbInfo.szKinName},
		{"Bang hội :", tbInfo.szTongName},
		{"Uy danh :", KGCPlayer.GetPlayerPrestige(nPlayerId)},
		--{"Trạng thái", (tbState[nState] or "<color=green>Trên mạng<color>") .. "("..nState..")"},
	}
	local szMsg	= "";
	for _, tb in ipairs(tbText) do
		szMsg	= szMsg .. "\n  " .. Lib:StrFillL(tb[1], 6) .. tostring(tb[2]);
	end
	local szButtonColor	= (nState > 0 and "") or "<color=gray>";
	local tbOpt = {
		{szButtonColor.."Kéo hắn qua đây", "GM.tbGMRole:CallHimHere", nPlayerId},
		{szButtonColor.."Đưa ta đi", "GM.tbGMRole:SendMeThere", nPlayerId},
		{szButtonColor.."Cho hắn rớt mạng", "GM.tbGMRole:KickHim", nPlayerId},
		{"Đưa vào thiên lao", "GM.tbGMRole:ArrestHim", nPlayerId},
		{"Thoát khỏi thiên lao", "GM.tbGMRole:FreeHim", nPlayerId},
		{"Gửi thư", self.SendMail, self, nPlayerId},
		{"Bỏ Tất cả vật phẩm", self.NemVatPham, self, nPlayerId},
		{"Gửi VẬT PHẨM", self.GuiVatPham, self, nPlayerId},
		{"Kết thúc đối thoại"},
	};
	Dialog:Say(szMsg, tbOpt);
	]]
	-- 插入最近玩家列表
	local tbRecentPlayerList	= self.tbRecentPlayerList or {};
	self.tbRecentPlayerList		= tbRecentPlayerList;
	for nIndex, nRecentPlayerId in ipairs(tbRecentPlayerList) do
		if (nRecentPlayerId == nPlayerId) then
			table.remove(tbRecentPlayerList, nIndex);
			break;
		end
	end
	if (#tbRecentPlayerList >= self.MAX_RECENTPLAYER) then
		table.remove(tbRecentPlayerList);
	end
	table.insert(tbRecentPlayerList, 1, nPlayerId);

	local szName	= KGCPlayer.GetPlayerName(nPlayerId);
	local tbInfo	= GetPlayerInfoForLadderGC(szName);
	local tbState	= {
		[0]		= "Không online",
		[-1]	= "Đang xử lý",
		[-2]	= "Auto?",
	};
	local nState	= KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_ONLINESERVER);
	local tbText	= {
		{"Tên", szName},
		{"Tài khoản", tbInfo.szAccount},
		{"Cấp", tbInfo.nLevel},
		{"Giới tính", (tbInfo.nSex == 1 and "Nữ") or "Nam"},
		{"Hệ phái", Player:GetFactionRouteName(tbInfo.nFaction, tbInfo.nRoute)},
		{"Tộc", tbInfo.szKinName},
		{"Bang hội", tbInfo.szTongName},
		{"Uy danh", KGCPlayer.GetPlayerPrestige(nPlayerId)},
		{"Trạng thái", (tbState[nState] or "<color=green>Trên mạng<color>") .. "("..nState..")"},
	}
	local szMsg	= "";
	for _, tb in ipairs(tbText) do
		szMsg	= szMsg .. "\n  " .. Lib:StrFillL(tb[1], 6) .. tostring(tb[2]);
	end
	local szButtonColor	= (nState > 0 and "") or "<color=gray>";
	local tbOpt = {
		{szButtonColor.."Kéo hắn qua đây", "GM.tbGMRole:CallHimHere", nPlayerId},
		{szButtonColor.."Đưa ta đi", "GM.tbGMRole:SendMeThere", nPlayerId},
		{szButtonColor.."Cho hắn rớt mạng", "GM.tbGMRole:KickHim", nPlayerId},
		{"Đưa vào thiên lao", "GM.tbGMRole:ArrestHim", nPlayerId},
		{"Thoát khỏi thiên lao", "GM.tbGMRole:FreeHim", nPlayerId},
		{"Gửi thư", self.SendMail, self, nPlayerId},
		{"Bỏ Tất cả vật phẩm", self.NemVatPham, self, nPlayerId},
		{"Gửi VẬT PHẨM", self.GuiVatPham, self, nPlayerId},
		{"Kết thúc đối thoại"},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:NemVatPham(nPlayerId)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
	pPlayer.ThrowAllItem();
end

function tbLiGuan:RecentPlayer()
	local tbOpt	= {};
	for nIndex, nPlayerId in ipairs(self.tbRecentPlayerList or {}) do
		local szName	= KGCPlayer.GetPlayerName(nPlayerId);
		local nState	= KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_ONLINESERVER);
		tbOpt[#tbOpt+1]	= {((nState > 0 and "<color=green>") or "")..szName, self.ViewPlayer, self, nPlayerId};
	end
	tbOpt[#tbOpt + 1]	= {"Kết thúc đối thoại"};
	
	Dialog:Say("Người chơi cần chọn: ", tbOpt);
end

function tbLiGuan:AroundPlayer()
	local tbPlayer	= {};
	local _, nMyMapX, nMyMapY	= me.GetWorldPos();
	for _, pPlayer in ipairs(KPlayer.GetAroundPlayerList(me.nId, 50)) do
		if (pPlayer.szName ~= me.szName) then
			local _, nMapX, nMapY	= pPlayer.GetWorldPos();
			local nDistance	= (nMapX - nMyMapX) ^ 2 + (nMapY - nMyMapY) ^ 2;
			tbPlayer[#tbPlayer+1]	= {nDistance, pPlayer};
		end
	end
	local function fnLess(tb1, tb2)
		return tb1[1] < tb2[1];
	end
	table.sort(tbPlayer, fnLess);
	local tbOpt	= {};
	for _, tb in ipairs(tbPlayer) do
		local pPlayer	= tb[2];
		tbOpt[#tbOpt+1]	= {pPlayer.szName, self.ViewPlayer, self, pPlayer.nId};
		if (#tbOpt >= 8) then
			break;
		end
	end
	tbOpt[#tbOpt + 1]	= {"Kết thúc đối thoại"};
	
	Dialog:Say("Người chơi cần chọn: ", tbOpt);
end

function tbLiGuan:AdjustLevel()
	local nMaxLevel	= 150; --GM.tbGMRole:GetMaxAdjustLevel();
	Dialog:AskNumber("Đẳng cấp (1-"..nMaxLevel..")", nMaxLevel, "GM.tbGMRole:AdjustLevel");
end

function tbLiGuan:SendMail(nPlayerId)
	Dialog:AskString("Nội dung thư", 500, "GM.tbGMRole:SendMail", nPlayerId);
end

function tbLiGuan:GuiVatPham(nPlayerId)
	local szMsg = "Hãy chọn vật phẩm muốn gửi";
	local tbOpt = {
			{"<color=gold>Than Mat Cap 2<color>",self.ThanMat,self, nPlayerId},
			{"Bạc Khóa (1000v)", self.SendBacKhoa5, self, nPlayerId},
			{"Bạc (1000v)", self.SendBac4, self, nPlayerId},
			{"Đồng Khóa (100v)", self.SendDongKhoa3, self, nPlayerId},
			{"Đồng Khóa (200v)", self.SendDongKhoa4, self, nPlayerId},
			{"Đồng Khóa (500v)", self.SendDongKhoa5, self, nPlayerId},
			--{"Đồng Khóa (-500v)", self.SendDongKhoa55, self, nPlayerId},
			{"Đồng (10v)", self.SendDong1, self, nPlayerId},
			{"Đồng (20v)", self.SendDong2, self, nPlayerId},
			{"Đồng (50v)", self.SendDong3, self, nPlayerId},
			{"Đồng (100v)", self.SendDong4, self, nPlayerId},
			{"Đồng (200v)", self.SendDong5, self, nPlayerId},
			{"Đồng (500v)", self.SendDong6, self, nPlayerId},
			{"Len Level 110", self.SendDKN8, self, nPlayerId},
			{"500tr KN", self.SendDKN500, self, nPlayerId},
			{"Xoa Dong (Vo Hieu)", self.XoaDongXX, self, nPlayerId},
			{"Gửi Items", self.ThemVatPham2, self, nPlayerId},
			{"Xin đợi"},
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:ThanMat(nPlayerId)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
	Relation:AddFriendFavor(me.szName, pPlayer.szName, 102);
end

function tbLiGuan:XoaDongXX(nPlayerId)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
	local nCoin	= pPlayer.GetJbCoin();
	pPlayer.AddJbCoin(-1 * nCoin);	--trừ hết đồng
end

function tbLiGuan:SendDKN500(nPlayerId)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
	pPlayer.AddExp(500000000);	--300tr DKN
end

function tbLiGuan:SendBacKhoa5(nPlayerId)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
	pPlayer.AddBindMoney(10000000);	--1000v bạc khóa
end

function tbLiGuan:SendBac4(nPlayerId)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
	pPlayer.Earn(10000000,0);	--1000v bạc
end

function tbLiGuan:SendDongKhoa3(nPlayerId)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
	pPlayer.AddBindCoin(1000000);	--100v Đồng khóa
end

function tbLiGuan:SendDongKhoa4(nPlayerId)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
	pPlayer.AddBindCoin(2000000);	--200v Đồng khóa
end

function tbLiGuan:SendDongKhoa5(nPlayerId)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
	pPlayer.AddBindCoin(5000000);	--500v Đồng khóa
end

function tbLiGuan:SendDongKhoa55(nPlayerId)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
	pPlayer.AddBindCoin(-1*5000000);	--500v Đồng khóa
	pPlayer.AddJbCoin(-1*2000000);	--200v Đồng
end

function tbLiGuan:SendDong1(nPlayerId)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
	pPlayer.AddJbCoin(100000);	--10v Đồng
end

function tbLiGuan:SendDong2(nPlayerId)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
	pPlayer.AddJbCoin(200000);	--20v Đồng
end

function tbLiGuan:SendDong3(nPlayerId)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
	pPlayer.AddJbCoin(500000);	--50v Đồng
end

function tbLiGuan:SendDong4(nPlayerId)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
	pPlayer.AddJbCoin(1000000);	--100v Đồng
end

function tbLiGuan:SendDong5(nPlayerId)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
	pPlayer.AddJbCoin(2000000);	--200v Đồng
end

function tbLiGuan:SendDong6(nPlayerId)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
	pPlayer.AddJbCoin(5000000);	--500v Đồng
end

function tbLiGuan:NhapSoLuong(nPlayerId)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
	Dialog:AskString("Số lượng bạc", 3000, self.SendBacKhoa, self); --, nPlayerId
end

function tbLiGuan:SendBacKhoa(nPlayerId)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
	local nSoluong = 1000000; --100v bạc khóa
	pPlayer.AddBindMoney(nSoluong);
end

function tbLiGuan:SendBac(nPlayerId)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
	local nSoluong = 1000000; --100v bạc
	pPlayer.Earn(nSoluong,0);
end

function tbLiGuan:SendDong(nPlayerId)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
	local nSoluong = 10000; --1v Đồng
	pPlayer.AddJbCoin(nSoluong);
end

function tbLiGuan:SendDKN8(nPlayerId)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
	--pPlayer.AddExp(10000000);	--5tr diem kinh nghiem
	pPlayer.AddLevel(110 - pPlayer.nLevel);
end

function tbLiGuan:ThemVatPham2(nPlayerId)
	Dialog:AskNumber("Nhập Genre",30000, self.Genre2,self, nPlayerId);
end

function tbLiGuan:Genre2(nPlayerId, nGenre)
	Dialog:AskNumber("Nhập Detail",30000,self.Detail2,self, nPlayerId, nGenre);
end

function tbLiGuan:Detail2(nPlayerId, nGenre, nDetail)
	Dialog:AskNumber("Nhập Particular",30000,self.Particular2,self, nPlayerId, nGenre, nDetail);
end

function tbLiGuan:Particular2(nPlayerId, nGenre, nDetail, nParticular)
	Dialog:AskNumber("Nhập Level",30000,self.Level2 ,self, nPlayerId, nGenre, nDetail, nParticular);
end

function tbLiGuan:Level2(nPlayerId, nGenre, nDetail, nParticular, nLevel)
	Dialog:AskNumber("Nhập Series",30000,self.nSeries2 ,self, nPlayerId, nGenre, nDetail, nParticular, nLevel);
end

function tbLiGuan:nSeries2(nPlayerId, nGenre, nDetail, nParticular, nLevel, nSeries)
	local pPlayer	= KPlayer.GetPlayerObjById(nPlayerId);
		pPlayer.AddItem(nGenre, nDetail, nParticular, nLevel, nSeries);
		pPlayer.Msg("Hệ thống gửi tới ngươi 1 món quà");
		me.Msg("Gửi thành công items");
end

function tbLiGuan:LookWldh()
	if not GLOBAL_AGENT then
		local szMsg = "Lối vào cho phóng viên thi đấu liên server <pic=98><pic=98><pic=98>";
		local tbOpt = {
			{"Vào Đảo Anh Hùng", self.EnterGlobalServer, self},
			{"Xin đợi"}};
		Dialog:Say(szMsg, tbOpt);
		return 0;
	end
	local szMsg = "Lối vào cho phóng viên thi đấu liên server <pic=98><pic=98><pic=98>";
	local tbOpt = {
			{"Đảo Anh Hùng", self.ReturnGlobalServer, self},
			{"Lâm An Phủ", self.ReturnMyServer, self},
			{"Xem trận chung kết Đơn đấu", self.Wldh_SelectFaction, self},
			{"Xem trận chung kết Song đấu", self.Wldh_SelectVsState, self, 2, 1},
			{"Xem trận chung kết Tam đấu", self.Wldh_SelectVsState, self, 3, 1},
			{"Xem trận chung kết Ngũ đấu", self.Wldh_SelectVsState, self, 4, 1},
			{"Xem trận chung kết Đoàn thể đấu", self.Wldh_SelectBattleVsState, self},
			{"Xin đợi"},
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:ReturnMyServer()
	me.GlobalTransfer(29, 1694, 4037);
end

function tbLiGuan:Wldh_SelectBattleVsState()
	local szMsg = "";
	local tbOpt = {
		{"Đấu trường đoàn thể hạng 1 (Kim)", self.Wldh_EnterBattleMap, self, 1, 1},
		{"Đấu trường đoàn thể hạng 1 (Tống)", self.Wldh_EnterBattleMap, self, 1, 2},
		{"Đấu trường đoàn thể tứ kết (Kim 1)", self.Wldh_EnterBattleMap, self, 1, 1},
		{"Đấu trường đoàn thể tứ kết (Tống 1)", self.Wldh_EnterBattleMap, self, 1, 2},
		{"Đấu trường đoàn thể tứ kết (Kim 2)", self.Wldh_EnterBattleMap, self, 2, 1},
		{"Đấu trường đoàn thể tứ kết (Tống 2)", self.Wldh_EnterBattleMap, self, 2, 2},
		{"Quay lại", self.LookWldh, self},
		{"Kết thúc đối thoại"},		
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:Wldh_EnterBattleMap(nAreaId, nCamp)
	local tbMap = {
		[1] = 1631,
		[2] = 1632,
	};
	local tbPos = {
		[1] = {1767, 2977},
		[2] = {1547, 3512},
	};	
	local nMapId = tbMap[nAreaId];
	
	me.NewWorld(nMapId, unpack(tbPos[nCamp]));
end

function tbLiGuan:Wldh_SelectFaction()
	local szMsg = "Chọn môn phái muốn xem?";
	local tbOpt = {};
	for i=1, 12  do
		table.insert(tbOpt, {Player:GetFactionRouteName(i).."Chung kết", self.Wldh_SelectVsState, self, 1, i});
	end
	table.insert(tbOpt, {"Quay lại", self.LookWldh, self});
	table.insert(tbOpt, {"Để ta suy nghĩ"});
	Dialog:Say(szMsg, tbOpt);	
end

function tbLiGuan:Wldh_SelectVsState(nType, nReadyId)
	local szMsg = "Chọn hạng mục muốn xem?";
	local tbOpt = {
		{"Đấu trường hạng 1", self.Wldh_SelectPkMap, self, nType, nReadyId, 1},
		{"Đấu trường tứ kết", self.Wldh_SelectPkMap, self, nType, nReadyId, 2},
		{"Đấu trường top 8", self.Wldh_SelectPkMap, self, nType, nReadyId, 4},
		{"Đấu trường top 16", self.Wldh_SelectPkMap, self, nType, nReadyId, 8},
		{"Đấu trường top 32", self.Wldh_SelectPkMap, self, nType, nReadyId, 16},
		{"Quay lại", self.LookWldh, self},
		{"Kết thúc đối thoại"},
		};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:Wldh_SelectPkMap(nType, nReadyId, nMapCount)
	local szMsg = "Chọn đấu trường muốn xem?";
	local tbOpt = {};
	for i=1, nMapCount do
		local szSelect = string.format("Đấu trường (%s)", i);
		table.insert(tbOpt, {szSelect, self.Wldh_EnterPkMap, self, nType, nReadyId, i});
	end
	table.insert(tbOpt, {"Quay lại", self.LookWldh, self});
	table.insert(tbOpt, {"Để ta suy nghĩ"});	
	Dialog:Say(szMsg, tbOpt);	
end

function tbLiGuan:Wldh_EnterPkMap(nType, nReadyId, nAearId)
	local nMapId = Wldh:GetMapMacthTable(nType)[nReadyId];
	local nPosX, nPosY = unpack(Wldh:GetMapPKPosTable(nType)[nAearId]);
	me.NewWorld(nMapId, nPosX, nPosY);
end

function tbLiGuan:EnterGlobalServer()
	local nGateWay = Transfer:GetTransferGateway();
	if nGateWay <= 0  then
		nGateWay = tonumber(string.sub(GetGatewayName(), 5, 8));
		me.SetTask(Transfer.tbServerTaskId[1], Transfer.tbServerTaskId[2], nGateWay);
	end
	local nMapId = Wldh.Battle.tbLeagueName[nGateWay] and Wldh.Battle.tbLeagueName[nGateWay][2];
	if not nMapId then
		Dialog:Say("Không được phép vào đảo anh hùng。");
		return 0;
	end
	local nCanSure = Map:CheckGlobalPlayerCount(nMapId);
	if nCanSure < 0 then
		me.Msg("Con đường phía trước không thông。");
		return 0;
	end
	if nCanSure == 0 then
		me.Msg("Địa điểm tổ chức đã đầy người, vui lòng trở lại sau。");
		return 0;
	end
	me.GlobalTransfer(nMapId, 1648, 3377);
end

function tbLiGuan:ReturnGlobalServer()
	local nGateWay = Transfer:GetTransferGateway();
	if not Wldh.Battle.tbLeagueName[nGateWay] then
		me.NewWorld(1609, 1680, 3269);
		return 0;
	end
	local nMapId = Wldh.Battle.tbLeagueName[nGateWay][2];
	if nMapId then
		me.NewWorld(nMapId, 1680, 3269);
		return 0;
	end
	me.NewWorld(1609, 1680, 3269);
end

function tbLiGuan:ThongBaoToanServer()
    Dialog:AskString("Nhập dữ liệu", 1000, self.ThongBao, self);
end

function tbLiGuan:ThongBao(msg)
    GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
end

function tbLiGuan:XepHangDanhVong()
    GCExcute({"PlayerHonor:UpdateWuLinHonorLadder"}); --Võ Lâm
    GCExcute({"PlayerHonor:UpdateMoneyHonorLadder"}); --Tài Phú
    GCExcute({"PlayerHonor:UpdateLeaderHonorLadder"}); --Thủ Lĩnh
    GCExcute({"PlayerHonor:UpdateSpringHonorLadder"}); 
    GCExcute({"PlayerHonor:UpdateXoyoLadder"});  --tiêu dao
	GCExcute({"PlayerHonor:UpdateLevelHonorLadder"}); --Level
    GCExcute({"PlayerHonor:OnSchemeLoadFactionHonorLadder"});  --môn phái
    GCExcute({"PlayerHonor:OnSchemeUpdateSongJinBattleHonorLadder"});  --
    GCExcute({"PlayerHonor:OnSchemeUpdateDragonBoatHonorLadder"}); 
    GCExcute({"PlayerHonor:OnSchemeUpdateWeiwangHonorLadder"}); 
    GCExcute({"PlayerHonor:OnSchemeUpdatePrettygirlHonorLadder"}); 
    GCExcute({"PlayerHonor:OnSchemeUpdateKaimenTaskHonorLadder"}); 
    KGblTask.SCSetDbTaskInt(86, GetTime()); 
    GlobalExcute({"PlayerHonor:OnLadderSorted"});
	GlobalExcute({"Dialog:GlobalNewsMsg_GS", "Hệ thống Danh Vọng đã cập nhật, có thể xem chi tiết bằng phím Ctrl + C."});
end

function tbLiGuan:ReloadScriptDEV()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Reload <color=orange>Thẻ Game Master<color>",self.GMAdmin,self};
		{"Reload <color=orange>NPC Event<color>",self.NPCEvent,self};
		{"Reload <color=orange>Script Event<color>",self.ScriptEvent,self};
		{"Reload <color=orange>File .Lua<color>",self.ReloadLua,self};
		{"Reload Script", self.Reload, self},
		{"Super Reload Script", self.SuperReload, self},
		{"Reload NPC Vua Hùng", self.ReloadVuHung, self},
		{"Reload <color=orange>Túi Tân Thủ<color>",self.Newplayergift,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:ReloadVuHung()
DoScript("\\script\\event\\cacevent\\denhung\\vuahung.lua");
end
function tbLiGuan:Reload()
	local nRet1 = DoScript("\\script\\item\\class\\gmcard.lua");
	local nRet2 = DoScript("\\script\\misc\\gm_role.lua");
	local nRet3	= DoScript("\\script\\event\\minievent\\newplayergift.lua");
	local nRet3	= DoScript("\\script\\misc\\gm.lua");
	GCExcute({"DoScript", "\\script\\misc\\gm_role.lua"});
	DoScript("\\script\\event\\minievent\\daygift.lua");
	DoScript("\\script\\factionelect\\factionelect_gs.lua");
	local szMsg	= "Reloaded!!("..nRet1..","..nRet2..","..nRet3..GetLocalDate(") %Y-%m-%d %H:%M:%S");
	me.Msg(szMsg);
	print(szMsg);
end

function tbLiGuan:NPCEvent()
    DoScript("\\script\\npc\\liguan.lua");
	me.Msg("Đã load lại bộ NPC Event !!! \n<color=yellow> - Nữ Hiệp \n - Anh Hùng<color>");
end

function tbLiGuan:ScriptEvent()
	DoScript("\\script\\event\\NguyenHoPhuc87\\ghepmanhluyenhoa.lua");
	DoScript("\\script\\event\\NguyenHoPhuc87\\hethongtraodoi.lua");
	DoScript("\\script\\event\\NguyenHoPhuc87\\shopptv.lua");
	DoScript("\\script\\misc\\customercmd_gs.lua");
	me.Msg("Đã reload lại bộ Script Event !!!");
end

function tbLiGuan:SuperReload()
 local tbOpt = {
  {"Super Reload Script", Lib._SuperScript:DoScriptDir(),Lib._SuperScript},
 };
end

function tbLiGuan:Newplayergift()
    DoScript("\\script\\event\\minievent\\newplayergift.lua");
	me.Msg("Đã load lại Túi Tân Thủ (Newplayergift.lua)!!!");
end

function tbLiGuan:GMAdmin()
	DoScript("\\script\\item\\class\\admincard.lua");
	DoScript("\\script\\misc\\gm_role.lua");
	me.Msg("Đã load lại GMCard và AdminCard!!!");
end

function tbLiGuan:ReloadLua(nFlag, nPath)
	if not nFlag then
		Dialog:AskString("Path Lua",255,self.ReloadLua,self,1);
	else
	DoScript(nPath);
	end
end

function tbLiGuan:NangCao()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"<color=yellow>Bạc & Đồng<color>",self.BacDong,self};
		{"<color=yellow>Bang Hội & Gia Tộc<color>",self.lsBangHoiGiaToc,self};
		{"<color=yellow>Quan Hàm & Quan Ấn<color>",self.lsQuanHamQuanAn,self};
		{"<color=yellow>Danh Vọng<color>",self.lsDanhVong,self};
		{"<color=yellow>Trang Bị<color>",self.TrangBi,self};
		{"<color=yellow>Vật Phẩm<color>",self.VatPham,self};
		{"<color=yellow>Du Long<color>",self.lsDuLong,self};
		{"<color=yellow>Lệnh Bài<color>",self.lsLenhBai,self};
		{"<color=yellow>Thú Cưỡi & Đồng Hành<color>",self.lsThuCuoiDongHanh,self};
		{"<color=yellow>Gọi Boss & Phó Bản<color>",self.lsGoiBoss,self};
		{"<color=yellow>Tiềm Năng & Kỹ Năng<color>",self.lsTiemNangKyNang,self};
		{"<color=yellow>Điểm Kinh Nghiệm<color>",self.lsDiemKinhNghiem,self};
		{"<color=yellow>Mặt Nạ<color>",self.lsMatNa,self};
		{"<color=yellow>Hack Tăng Tốc (Chạy-Đánh)<color>",self.lsTangToc,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:BacDong()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:BacThuong()
	me.Earn(10000000,0);
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

function tbLiGuan:ThoiDong()
	me.AddItem(18,1,118,2); --Thỏi Đồng (1000 0000 đồng khóa)
end

function tbLiGuan:lsBangHoiGiaToc()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Gia Tộc",self.lsGiaToc,self};
		{"Bang Hội",self.lsBangHoi,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:lsGiaToc()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Lệnh Bài Gia Tộc (Sơ)",self.LenhBaiGiaTocSo,self};
		{"Lệnh Bài Gia Tộc (Trung)",self.LenhBaiGiaTocTrung,self};
		{"Lệnh Bài Gia Tộc (Cao)",self.LenhBaiGiaTocCao,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsBangHoiGiaToc,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:LenhBaiGiaTocSo()
	for i=1,5 do
		me.AddItem(18,1,110,1); --Lệnh bài gia tộc sơ
	end
end

function tbLiGuan:LenhBaiGiaTocTrung()
	for i=1,5 do
		me.AddItem(18,1,110,2); --Lệnh bài gia tộc trung
	end
end

function tbLiGuan:LenhBaiGiaTocCao()
	for i=1,5 do
		me.AddItem(18,1,110,3); --Lệnh bài gia tộc cao
	end
end

function tbLiGuan:lsBangHoi()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Bạc Bang Hội (Tiểu)",self.BacBangHoiTieu,self};
		{"Bạc Bang Hội (Đại)",self.BacBangHoiDai,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsBangHoiGiaToc,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:BacBangHoiTieu()
	for i=1,5 do
		me.AddItem(18,1,284,1); --Thỏi bạc bang hội tiểu
	end
end

function tbLiGuan:BacBangHoiDai()
	for i=1,5 do
		me.AddItem(18,1,284,2); --Thỏi bạc bang hội đại
	end
end

function tbLiGuan:lsQuanHamQuanAn()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Nhận Quan Hàm",self.NhanQuanHam,self};
		{"Nhận Quan Ấn",self.NhanQuanAn,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:NhanQuanHam()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Quan Hàm Cấp 1",self.quanham1,self};
		{"Quan Hàm Cấp 2",self.quanham2,self};
		{"Quan Hàm Cấp 3",self.quanham3,self};
		{"Quan Hàm Cấp 4",self.quanham4,self};
		{"Quan Hàm Cấp 5",self.quanham5,self};
		{"Quan Hàm Cấp 6",self.quanham6,self};
		{"Quan Hàm Cấp 7",self.quanham7,self};
		{"Quan Hàm Cấp 8",self.quanham8,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsQuanHamQuanAn,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

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

function tbLiGuan:NhanQuanAn()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Nhận Quan ấn Kim",self.QuanAnKim,self};
		{"Nhận Quan ấn Mộc",self.QuanAnMoc,self};
		{"Nhận Quan ấn Thủy",self.QuanAnThuy,self};
		{"Nhận Quan ấn Hỏa",self.QuanAnHoa,self};
		{"Nhận Quan ấn Thổ",self.QuanAnTho,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsQuanHamQuanAn,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:QuanAnKim()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:QuanAnMoc()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:QuanAnThuy()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:QuanAnHoa()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:QuanAnTho()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:lsDanhVong()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Nhận Toàn Bộ Danh Vọng",self.DanhVongFull,self};
		{"Xóa Toàn Bộ Danh Vọng",self.XoaDanhVongFull,self};
		{"Chọn Từng Loại Danh Vọng",self.ChonDanhVong,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:DanhVongFull()
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

function tbLiGuan:XoaDanhVongFull()
	me.AddRepute(1,1,-1*30000);
	me.AddRepute(1,2,-1*30000);
	me.AddRepute(1,3,-1*30000);
	me.AddRepute(2,1,-1*30000);
	me.AddRepute(2,2,-1*30000);
	me.AddRepute(2,3,-1*30000);
	me.AddRepute(3,1,-1*30000);
	me.AddRepute(3,2,-1*30000);
	me.AddRepute(3,3,-1*30000);
	me.AddRepute(3,4,-1*30000);
	me.AddRepute(3,5,-1*30000);
	me.AddRepute(3,6,-1*30000);
	me.AddRepute(3,7,-1*30000);
	me.AddRepute(3,8,-1*30000);
	me.AddRepute(3,9,-1*30000);
	me.AddRepute(3,10,-1*30000);
	me.AddRepute(3,11,-1*30000);
	me.AddRepute(3,12,-1*30000);
	me.AddRepute(4,1,-1*30000);
	me.AddRepute(5,1,-1*30000);
	me.AddRepute(5,2,-1*30000);
	me.AddRepute(5,3,-1*30000);
	me.AddRepute(5,4,-1*30000);
	me.AddRepute(5,5,-1*30000);
	me.AddRepute(5,6,-1*30000);
	me.AddRepute(6,1,-1*30000);
	me.AddRepute(6,2,-1*30000);
	me.AddRepute(6,3,-1*30000);
	me.AddRepute(6,4,-1*30000);
	me.AddRepute(6,5,-1*30000);
	me.AddRepute(7,1,-1*30000);
	me.AddRepute(8,1,-1*30000);
	me.AddRepute(9,1,-1*30000);
	me.AddRepute(9,2,-1*30000);
	me.AddRepute(10,1,-1*30000);
	me.AddRepute(11,1,-1*30000);
	me.AddRepute(12,1,-1*30000);
end

function tbLiGuan:ChonDanhVong()
local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {};
	table.insert(tbOpt, {"Danh Vọng Nhiệm Vụ" , self.OnDialog_Nhiemvu, self});
	table.insert(tbOpt, {"Danh Vọng Tống Kim" , self.OnDialog_Tongkim, self});
	table.insert(tbOpt, {"Danh Vọng Môn Phái" , self.OnDialog_Monphai, self});
	table.insert(tbOpt, {"Danh Vọng Gia Tộc",  self.Giatoc, self});
	table.insert(tbOpt, {"Danh Vọng Hoạt Động",  self.OnDialog_Hoatdong, self});
	table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ",  self.OnDialog_Volam, self});
	table.insert(tbOpt, {"Danh Vọng Võ Lâm Liên Đấu",  self.Liendau, self});
	table.insert(tbOpt, {"Danh Vọng Lãnh Thổ tranh đoạt chiến",  self.Lanhtho, self});
	table.insert(tbOpt, {"Danh Vọng Tần Lăng",  self.Tanlang, self});
	table.insert(tbOpt, {"Danh Vọng Đoàn viên gia tộc",  self.Doanvien, self});
	table.insert(tbOpt, {"Danh Vọng Đại Hội Võ Lâm",  self.Daihoivolam, self});
	table.insert(tbOpt, {"Danh Vọng Liên đấu liên server",  self.Liendauserver, self});
	table.insert(tbOpt, {"Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:OnDialog_Nhiemvu()
local szMsg= "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
local tbOpt = {};
	table.insert(tbOpt, {"Danh Vọng Nghĩa Quân" , self.Nghiaquan, self});
	table.insert(tbOpt, {"Danh Vọng Quân Doanh" , self.Quandoanh, self});
	table.insert(tbOpt, {"Danh Vọng Học Tạo đồ" , self.Hoctaodo, self});
	table.insert(tbOpt, {"Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:Nghiaquan()
	me.AddRepute(1,1,30000);
end

function tbLiGuan:Quandoanh()
	me.AddRepute(1,2,30000);
end

function tbLiGuan:Hoctaodo()
	me.AddRepute(1,3,30000);
end

function tbLiGuan:OnDialog_Tongkim()
local szMsg= "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
local tbOpt = {};
		table.insert(tbOpt, {"Danh Vọng Dương Châu" , self.Duongchau, self});
		table.insert(tbOpt, {"Danh Vọng Phượng Tường" , self.Phuongtuong, self});
		table.insert(tbOpt, {"Danh Vọng Tương Dương" , self.Tuongduong, self});
		table.insert(tbOpt, {"Ta chỉ ghé ngang qua"});
		Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:Duongchau()
	me.AddRepute(2,1,30000);
end

function tbLiGuan:Phuongtuong()
	me.AddRepute(2,2,30000);
end

function tbLiGuan:Tuongduong()
	me.AddRepute(2,3,30000);
end

function tbLiGuan:OnDialog_Monphai()
local szMsg= "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
local tbOpt = {};
		table.insert(tbOpt, {"Danh Vọng Thiếu Lâm" , self.Thieulam, self});
		table.insert(tbOpt, {"Danh Vọng Thiên Vương" , self.Thienvuong, self});
		table.insert(tbOpt, {"Danh Vọng Đường Môn" , self.Duongmon, self});	
		table.insert(tbOpt, {"Danh Vọng Ngũ Độc" , self.Ngudoc, self});
		table.insert(tbOpt, {"Danh Vọng Nga Mi" , self.Ngami, self});
		table.insert(tbOpt, {"Danh Vọng Thúy Yên" , self.Thuyyen, self});
		table.insert(tbOpt, {"Danh Vọng Cái Bang" , self.Caibang, self});
		table.insert(tbOpt, {"Danh Vọng Thiên Nhẫn" , self.Thiennhan, self});
		table.insert(tbOpt, {"Danh Vọng Võ Đang" , self.Vodang, self});
		table.insert(tbOpt, {"Danh Vọng Côn Lôn" , self.Conlon, self});
		table.insert(tbOpt, {"Danh Vọng Minh Giáo" , self.Minhgiao, self});
		table.insert(tbOpt, {"Danh Vọng Đại Lý Đoàn thị" , self.Doanthi, self});
		table.insert(tbOpt, {"Ta chỉ ghé ngang qua"});
		Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:Thieulam()
	me.AddRepute(3,1,30000);
end

function tbLiGuan:ThienVuong()
	me.AddRepute(3,2,30000);
end

function tbLiGuan:Duongmon()
	me.AddRepute(3,3,30000);
end

function tbLiGuan:Ngudoc()
	me.AddRepute(3,4,30000);
end

function tbLiGuan:Ngami()
	me.AddRepute(3,5,30000);
end

function tbLiGuan:Thuyyen()
	me.AddRepute(3,6,30000);
end

function tbLiGuan:Caibang()
	me.AddRepute(3,7,30000);
end

function tbLiGuan:Thiennhan()
	me.AddRepute(3,8,30000);
end

function tbLiGuan:Vodang()
	me.AddRepute(3,9,30000);
end

function tbLiGuan:Conlon()
	me.AddRepute(3,10,30000);
end

function tbLiGuan:Minhgiao()
	me.AddRepute(3,11,30000);
end

function tbLiGuan:Doanthi()
	me.AddRepute(3,12,30000);
end

function tbLiGuan:Giatoc()
	me.AddRepute(4,1,30000);
end

function tbLiGuan:OnDialog_Hoatdong()
local szMsg= "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
local tbOpt = {};
	table.insert(tbOpt, {"Danh Vọng Bạch Hổ Đường" , self.Bachho, self});
	table.insert(tbOpt, {"Danh Vọng Thịnh Hạ 2008" , self.Thinhha2008, self});
	table.insert(tbOpt, {"Danh Vọng Tiêu Dao Cốc" , self.Tieudaococ, self});
	table.insert(tbOpt, {"Danh Vọng Chúc Phúc" , self.Chucphuc, self});
	table.insert(tbOpt, {"Danh Vọng Thịnh Hạ 2010" , self.Thinhha2010, self});
	table.insert(tbOpt, {"Danh Vọng Di tích Hàn vũ" , self.Ditichhanvu, self});
	table.insert(tbOpt, {"Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end
function tbLiGuan:Bachho()
	me.AddRepute(5,1,30000);
end

function tbLiGuan:Thinhha2008()
	me.AddRepute(5,2,30000);
end

function tbLiGuan:Tieudaococ()
	me.AddRepute(5,3,30000);
end

function tbLiGuan:Chucphuc()
	me.AddRepute(5,4,30000);
end

function tbLiGuan:Thinhha2010()
	me.AddRepute(5,5,30000);
end

function tbLiGuan:Ditichhanvu()
	me.AddRepute(5,6,30000);
end

function tbLiGuan:OnDialog_Volam()
local szMsg= "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
local tbOpt = {};
	table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ(Kim)" , self.CaothuKim, self});
	table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ(Mộc)" , self.CaothuMoc, self});
	table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ(Thủy)" , self.CaothuThuy, self});
	table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ(Hỏa)" , self.CaothuHoa, self});
	table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ(Thổ)" , self.CaothuTho, self});
	table.insert(tbOpt, {"Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:CaothuKim()
	me.AddRepute(6,1,30000);
end

function tbLiGuan:CaothuMoc()
	me.AddRepute(6,1,30000);
end

function tbLiGuan:CaothuThuy()
	me.AddRepute(6,1,30000);
end

function tbLiGuan:CaothuHoa()
	me.AddRepute(6,1,30000);
end

function tbLiGuan:CaothuTho()
	me.AddRepute(6,1,30000);
end

function tbLiGuan:Liendau()
	me.AddRepute(7,1,30000);
end

function tbLiGuan:Lanhtho()
	me.AddRepute(8,1,30000);
end

function tbLiGuan:Tanlang()
	me.AddRepute(9,1,30000);
	me.AddRepute(9,2,30000);
end

function tbLiGuan:Doanvien()
	me.AddRepute(10,1,30000);
end

function tbLiGuan:Daihoivolam()
	me.AddRepute(11,1,30000);
end

function tbLiGuan:Liendauserver()
	me.AddRepute(12,1,30000);
end

function tbLiGuan:TrangBi()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"<color=yellow>Trọn Bộ TB Cường Hóa Sẵn<color>",self.TrangBiCuongHoa,self};
		{"Nhận Trang Bị <color=red>Bá Vương<color>",self.TrangBiBaVuong,self};
		{"Nhận Trang Bị <color=red>Sát Thần<color>",self.TrangBiSatThan,self};
		{"Nhận <color=yellow>Vũ khí 180<color>",self.VuKhiMoi,self},
		{"Phi Phong",self.PhiPhong,self};
		{"Shop Vũ khí Tần Lăng",self.ShopThuyHoang, self};
        --{"Shop Liên Đấu",self.ShopLienDau,self};
		--{"Shop Thịnh Hạ",self.ShopThinhHa,self};
        --{"Shop Tranh Đoạt Lãnh Thổ",self.ShopTranhDoat,self};
        --{"Shop Quan Hàm",self.ShopQuanHam,self};
        --{"Shop Chúc Phúc",self.ShopChucPhuc,self};
		{"Chan Nguyen",self.ChanNguyen,self};
		{"Luyen Hoa Chan Nguyen",self.LuyenChanNguyen,self};
		{"Thanh Linh",self.ThanhLinh,self};
		{"Luyen Hoa Thanh Linh",self.LuyenThanhLinh,self};
		{"Chan Vu",self.ChanVu,self};
		{"Luyen Hoa Chan Vu",self.LuyenChanVu,self};
		{"Ngoai Trang",self.NgoaiTrang,self};
		{"Ngoai Trang Luyen Hoa",self.NgoaiTrangLuyen,self};
		{"Luân Hồi Ấn",self.LuanHoiAn,self};
		{"Trận Pháp Cao",self.TranPhapCao,self};
		--{"Shop Vũ Khí Hệ Kim",self.SVuKhi1,self};
		--{"Shop Vũ Khí Hệ Mộc",self.SVuKhi2,self};
		--{"Shop Vũ Khí Hệ Thủy",self.SVuKhi3,self};
		--{"Shop Vũ Khí Hệ Hỏa",self.SVuKhi4,self};
		--{"Shop Vũ Khí Hệ Thổ",self.SVuKhi5,self};
		{">>>",self.TrangBi1,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:TrangBi1()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Áo vũ uy",self.lsAoVuUy,self};
		{"Nhẫn Vũ Uy",self.lsNhanVuUy,self};
		{"Hộ Phù Vũ Uy",self.lsHoPhuVuUy,self};
		{"Áo Tần thủy hoàng",self.lsAoThuyHoang,self};
		{"Bao Tay Thủy Hoàng",self.lsBaoTayThuyHoang,self};
		{"Ngọc Bội Thủy Hoàng",self.lsNgocBoiThuyHoang,self};
		{"Bao Tay Tiêu Dao",self.lsBaoTayTieuDao,self};
		{"Giày Tiêu Dao",self.lsGiayTieuDao,self};
		{"Nón Trục Lộc",self.lsNonTrucLoc,self};
		{"Lưng Trục Lộc",self.lsLungTrucLoc,self};
		{"Liên Trục Lộc",self.lsLienTrucLoc,self};
		{"<<<",self.TrangBi,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:ChanNguyen()
	me.AddItem(1,24,1,1);
	me.AddItem(1,24,2,1);
	me.AddItem(1,24,3,1);
	me.AddItem(1,24,4,1);
	me.AddItem(1,24,5,1);
	me.AddItem(1,24,6,1);
	me.AddItem(1,24,7,1);
end

function tbLiGuan:ThanhLinh()
	me.AddItem(1,27,1,1);
	me.AddItem(1,27,2,1);
	me.AddItem(1,27,3,1);
	me.AddItem(1,27,4,1);
	me.AddItem(1,27,5,1);
end

function tbLiGuan:LuyenThanhLinh()
	me.AddStackItem(18,1,1334,1,nil,1000);
end

function tbLiGuan:LuyenChanNguyen()
	me.AddStackItem(18,1,1335,1,nil,1000);
end

function tbLiGuan:LuyenChanVu()
	me.AddStackItem(18,1,1339,1,nil,100);
	me.AddStackItem(18,1,1339,2,nil,100);
	me.AddStackItem(18,1,1339,3,nil,100);
	me.AddStackItem(18,1,1339,4,nil,100);
end

function tbLiGuan:ChanVu()
	me.AddItem(1,26,38,1);
	me.AddItem(1,26,39,1);
	me.AddItem(1,26,40,2);
	me.AddItem(1,26,41,2);
	me.AddItem(1,26,42,2);
	me.AddItem(1,26,43,2);
	me.AddItem(1,26,46,1);
	me.AddItem(1,26,47,1);
end

function tbLiGuan:NgoaiTrang()
	me.AddItem(1,25,51,2);
	me.AddItem(1,25,52,2);
	me.AddItem(1,25,53,2);
	me.AddItem(1,25,54,2);
	me.AddItem(1,25,55,2);
	me.AddItem(1,25,56,2);
	me.AddItem(1,25,57,2);
	me.AddItem(1,25,58,2);
	me.AddItem(1,25,59,2);
	me.AddItem(1,25,60,2);
	me.AddItem(1,25,61,2);
	me.AddItem(1,25,62,2);
	me.AddItem(1,25,63,2);
	me.AddItem(1,25,64,2);
	me.AddItem(1,25,65,2);
	me.AddItem(1,25,66,2);
	me.AddItem(1,25,67,2);
	me.AddItem(1,25,68,2);
	me.AddItem(1,25,69,2);
	me.AddItem(1,25,70,2);
	me.AddItem(1,25,71,2);
	me.AddItem(1,25,72,2);
	me.AddItem(1,25,73,2);
	me.AddItem(1,25,74,2);
	me.AddItem(1,25,75,2);
	me.AddItem(1,25,76,2);
	me.AddItem(1,25,77,2);
	me.AddItem(1,25,78,2);
	me.AddItem(1,25,79,2);
	me.AddItem(1,25,80,2);
	me.AddItem(1,25,81,2);
	me.AddItem(1,25,82,2);
	me.AddItem(1,25,83,2);
	me.AddItem(1,25,84,2);
	me.AddItem(1,25,85,2);
	me.AddItem(1,25,86,2);
	me.AddItem(1,25,87,2);
end

function tbLiGuan:NgoaiTrangLuyen()
	me.AddItem(1,25,51,2);
	me.AddItem(1,25,52,2);
	me.AddItem(1,25,53,2);
	me.AddItem(1,25,54,2);
	me.AddItem(1,25,55,2);
	me.AddItem(1,25,56,2);
	me.AddItem(1,25,57,2);
	me.AddItem(1,25,58,2);
	me.AddItem(1,25,59,2);
	me.AddItem(1,25,60,2);
	me.AddItem(1,25,61,2);
	me.AddItem(1,25,62,2);
	me.AddItem(1,25,63,2);
	me.AddItem(1,25,64,2);
	me.AddItem(1,25,65,2);
	me.AddItem(1,25,66,2);
	me.AddItem(1,25,67,2);
	me.AddItem(1,25,68,2);
	me.AddItem(1,25,69,2);
	me.AddItem(1,25,70,2);
	me.AddItem(1,25,71,2);
	me.AddItem(1,25,72,2);
	me.AddItem(1,25,73,2);
	me.AddItem(1,25,74,2);
	me.AddItem(1,25,75,2);
	me.AddItem(1,25,76,2);
	me.AddItem(1,25,77,2);
	me.AddItem(1,25,78,2);
	me.AddItem(1,25,79,2);
	me.AddItem(1,25,80,2);
	me.AddItem(1,25,81,2);
	me.AddItem(1,25,82,2);
	me.AddItem(1,25,83,2);
	me.AddItem(1,25,84,2);
	me.AddItem(1,25,85,2);
	me.AddItem(1,25,86,2);
	me.AddItem(1,25,87,2);
end

function tbLiGuan:TrangBiCuongHoa()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:DoCuoi10()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Do Nam",self.DoNam10,self};
		{"Do Nu",self.DoNu10,self },
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNam10()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai10,self};
		{"Đồ Nội",self.KimNoi10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim101()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai101,self};
		{"Đồ Nội",self.KimNoi101,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc10()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai10,self};
		{"Đồ Nội",self.MocNoi10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc101()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai101,self};
		{"Đồ Nội",self.MocNoi101,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy10()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai10,self};
		{"Đồ Nội",self.ThuyNoi10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy101()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai101,self};
		{"Đồ Nội",self.ThuyNoi101,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa10()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai10,self};
		{"Đồ Nội",self.HoaNoi10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa101()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai101,self};
		{"Đồ Nội",self.HoaNoi101,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho10()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai10,self};
		{"Đồ Nội",self.ThoNoi10,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho101()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:DoCuoi12()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Do Nam",self.DoNam12,self};
		{"Do Nu",self.DoNu12,self },
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNam12()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai12,self};
		{"Đồ Nội",self.KimNoi12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim121()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai121,self};
		{"Đồ Nội",self.KimNoi121,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc12()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai12,self};
		{"Đồ Nội",self.MocNoi12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc121()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai121,self};
		{"Đồ Nội",self.MocNoi121,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy12()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai12,self};
		{"Đồ Nội",self.ThuyNoi12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy121()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai121,self};
		{"Đồ Nội",self.ThuyNoi121,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa12()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai12,self};
		{"Đồ Nội",self.HoaNoi12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa121()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai121,self};
		{"Đồ Nội",self.HoaNoi121,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho12()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai12,self};
		{"Đồ Nội",self.ThoNoi12,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho121()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:DoCuoi14()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Do Nam",self.DoNam14,self};
		{"Do Nu",self.DoNu14,self },
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNam14()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai14,self};
		{"Đồ Nội",self.KimNoi14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim141()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai141,self};
		{"Đồ Nội",self.KimNoi141,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc14()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai14,self};
		{"Đồ Nội",self.MocNoi14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc141()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai141,self};
		{"Đồ Nội",self.MocNoi141,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy14()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai14,self};
		{"Đồ Nội",self.ThuyNoi14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy141()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai141,self};
		{"Đồ Nội",self.ThuyNoi141,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa14()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai14,self};
		{"Đồ Nội",self.HoaNoi14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa141()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai141,self};
		{"Đồ Nội",self.HoaNoi141,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho14()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai14,self};
		{"Đồ Nội",self.ThoNoi14,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho141()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:DoCuoi16()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Do Nam",self.DoNam16,self};
		{"Do Nu",self.DoNu16,self },
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:DoNam16()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai16,self};
		{"Đồ Nội",self.KimNoi16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeKim161()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.KimNgoai161,self};
		{"Đồ Nội",self.KimNoi161,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc16()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai16,self};
		{"Đồ Nội",self.MocNoi16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeMoc161()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.MocNgoai161,self};
		{"Đồ Nội",self.MocNoi161,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy16()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai16,self};
		{"Đồ Nội",self.ThuyNoi16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeThuy161()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.ThuyNgoai161,self};
		{"Đồ Nội",self.ThuyNoi161,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa16()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai16,self};
		{"Đồ Nội",self.HoaNoi16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeHoa161()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.HoaNgoai161,self};
		{"Đồ Nội",self.HoaNoi161,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho16()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt ={
		{"Đồ Ngoại",self.ThoNgoai16,self};
		{"Đồ Nội",self.ThoNoi16,self};
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:HeTho161()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:PhiPhong()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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
		{"Nhận Danh Hiệu Vô Song",self.VoSong,self};
		{"<color=pink>Trở Lại Trước<color>",self.TrangBi,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:VoSong()
	me.SetHonorLevel(10);
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

function tbLiGuan:ShopThuyHoang()
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

function tbLiGuan:ShopLienDau()
    me.OpenShop(134,1);
end

function tbLiGuan:ShopChucPhuc()
    me.OpenShop(133,1);
end

function tbLiGuan:ShopTranhDoat()
    me.OpenShop(147,1);
end

function tbLiGuan:ShopThinhHa()
    me.OpenShop(128,1);
end

function tbLiGuan:SVuKhi1()
	me.OpenShop(156, 1);
end

function tbLiGuan:SVuKhi2()
	me.OpenShop(157, 1);
end

function tbLiGuan:SVuKhi3()
	me.OpenShop(158, 1);
end

function tbLiGuan:SVuKhi4()
	me.OpenShop(159, 1);
end

function tbLiGuan:SVuKhi5()
	me.OpenShop(160, 1);
end

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

function tbLiGuan:lsAoVuUy()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Nam",self.lsAoVuUyNam,self};
		{"Nữ",self.lsAoVuUyNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsAoVuUyNam()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:lsNhanVuUy()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Nam",self.lsNhanVuUyNam,self};
		{"Nữ",self.lsNhanVuUyNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsNhanVuUyNam()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:lsHoPhuVuUy()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:lsAoThuyHoang()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Nam",self.lsAoThuyHoangNam,self};
		{"Nữ",self.lsAoThuyHoangNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsAoThuyHoangNam()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:lsBaoTayThuyHoang()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Nam",self.lsBaoTayThuyHoangNam,self};
		{"Nữ",self.lsBaoTayThuyHoangNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsBaoTayThuyHoangNam()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:lsNgocBoiThuyHoang()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Nam",self.lsNgocBoiThuyHoangNam,self};
		{"Nữ",self.lsNgocBoiThuyHoangNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsNgocBoiThuyHoangNam()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:lsBaoTayTieuDao()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Nam",self.lsBaoTayTieuDaoNam,self};
		{"Nữ",self.lsBaoTayTieuDaoNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsBaoTayTieuDaoNam()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:lsGiayTieuDao()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Nam",self.lsGiayTieuDaoNam,self};
		{"Nữ",self.lsGiayTieuDaoNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsGiayTieuDaoNam()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:lsNonTrucLoc()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Nam",self.lsNonTrucLocNam,self};
		{"Nữ",self.lsNonTrucLocNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsNonTrucLocNam()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:lsLungTrucLoc()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Nam",self.lsLungTrucLocNam,self};
		{"Nữ",self.lsLungTrucLocNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsLungTrucLocNam()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:lsLienTrucLoc()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Nam",self.lsLienTrucLocNam,self};
		{"Nữ",self.lsLienTrucLocNu,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	}
	Dialog:Say(szMsg,tbOpt);
end

function tbLiGuan:lsLienTrucLocNam()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:LuanHoiAn()
	me.AddItem(1,16,13,2,0,1); --Luân Hồi Ấn
	me.AddItem(1,16,16,2,0,1); --Luân Hồi Ấn
	me.AddItem(1,16,17,2,0,1); --Luân Hồi Ấn
	me.AddItem(1,16,18,2,0,1); --Luân Hồi Ấn
	me.AddItem(1,16,19,2,0,1); --Luân Hồi Ấn
	me.AddItem(1,16,20,2,0,1); --Luân Hồi Ấn
	me.AddItem(1,16,21,2,0,1); --Luân Hồi Ấn
	me.AddItem(1,16,22,2,0,1); --Luân Hồi Ấn
	me.AddItem(1,16,23,2,0,1); --Luân Hồi Ấn
	me.AddItem(1,16,24,2,0,1); --Luân Hồi Ấn
end

function tbLiGuan:TranPhapCao()
--me.AddItem(1,15,19,3);
--me.AddItem(1,15,18,3);
--me.AddItem(1,15,17,3);
--me.AddItem(1,15,16,3);
--me.AddItem(1,15,15,3);
--me.AddItem(1,15,14,3);
--me.AddItem(1,15,13,3);
--me.AddItem(1,15,12,3);
me.AddItem(1,15,11,3);
me.AddItem(1,15,10,3);
me.AddItem(1,15,9,3);
me.AddItem(1,15,8,3);
me.AddItem(1,15,7,3);
me.AddItem(1,15,6,3);
me.AddItem(1,15,5,3);
me.AddItem(1,15,4,3);
me.AddItem(1,15,3,3);
me.AddItem(1,15,2,3);
me.AddItem(1,15,1,3);
end

function tbLiGuan:VatPham()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Túi",self.lsTui,self};
		--{"[Lua Trai]", self.LuaTrai, self},
		{"[Tàng Bảo Đồ]", self.TangBaoDo, self},
		{"[LAK]", self.ThuocLak, self},
		{"Hòa Thị Ngọc", self.HoaThiNgoc, self},
		{"100 Tần Lăng Hòa Thị Bích",self.TanLangHoaThiBich,self};
		{"100 Tần Lăng Hòa Thị Bích khóa",self.TanLangHoaThiBich2,self};
		{"Huyền Tinh (1-12)",self.HuyenTinh,self};
		--{"Đồ Nhiệm Vụ 110 (10 món)",self.nhiemvu110,self};
		{"Vỏ Sò Vàng (1000)",self.VoSoVang,self};
		{"Rương Cao Quý (10)",self.RuongCaoQuy,self};
		{"Rương Phi Thiên Vũ",self.RuongPhiThienVu,self};
		--{"Vé Cường Hóa",self.VeCuongHoa,self};
		{"Luyện Hóa Đồ",self.LuyenHoaDo,self};
		{"Mảnh Ghép Tinh Thạch",self.ManhTinhThach,self};
		--{"Bùa Sửa Trang Bị Cường 16",self.BuaSuaTrangBi,self};
		--{"Nguyệt Ảnh Thạch",self.NguyetAnhThach,self};
		--{"Nguyệt Ảnh Nguyên Thạch",self.NguyetAnhNguyenThach,self};
		--{"Rương Vỏ Sò Vàng (5r)",self.RuongVoSoVang,self};
		--{"Rương Dạ Minh Châu (1r)",self.RuongDaMinhChau,self};
		--{"Tu Luyện Đơn (5c)",self.TuLuyenDon,self};
		{">>>",self.VatPham1,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:ManhTinhThach()
	for i=1,100 do
		me.AddItem(18,1,1340,1); --mảnh tinh thạch 1
		me.AddItem(18,1,1340,2); --mảnh tinh thạch 2
		me.AddItem(18,1,1340,3); --mảnh tinh thạch 3
		me.AddItem(18,1,1340,4); --mảnh tinh thạch 4
	end
end

function tbLiGuan:RuongPhiThienVu()
	for i=1,100 do
		me.AddItem(18,10,12,13); --Rương Phi Thiên Vũ
	end
end

function tbLiGuan:HoaThiNgoc()
	for i=1,5 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(22,1,81,1); --hòa thị ngọc
		else
			break
		end
	end
end

function tbLiGuan:TangBaoDo()
	for i=1,10 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,9,3); --Tàng bảo đồ
		else
			break
		end
	end
end

function tbLiGuan:ThuocLak()
	for i=1,10 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,66,10); --Ma đao thạch cấp 10
			--me.AddItem(18,1,72,10); --Ma đao thạch cấp 10 (gương)
			me.AddItem(18,1,67,10); --Hộ giáp phiến cấp 10
			--me.AddItem(18,1,73,10); --Hộ giáp phiến cấp 10 (gương)
			me.AddItem(18,1,68,10); --Ngũ hành thạch cấp 10
			--me.AddItem(18,1,74,10); --Ngũ hành thạch cấp 10 (gương)
		else
			break
		end
	end
end

function tbLiGuan:VatPham1()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:lsTui()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:Tui24()
	me.AddItem(21,9,1,1); --Túi thiên tằm 24 ô
	me.AddItem(21,9,2,1); --Túi bàn long 24 ô
	me.AddItem(21,9,3,1); --Túi Phi Phượng 24 ô
end

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

function tbLiGuan:TanLangHoaThiBich()
	for i=1,100 do
		me.AddItem(18,1,377,1); --Tần lăng hòa thị bích
	end;
end

function tbLiGuan:TanLangHoaThiBich2()
	me.AddStackItem(18,1,377,1,self.tbItemInfo,100);--Tần lăng hòa thị bích
end

function tbLiGuan:VeCuongHoa()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Vé Cường Hóa Vũ Khí <color=red>(Ko Thể Bán)<color>" ,self.VeCuongHoaVuKhi, self};
		{"Vé Cường Hóa Phòng Cụ <color=red>(Ko Thể Bán)<color>" ,self.VeCuongHoaPhongCu, self};
		{"Vé Cường Hóa Trang Sức <color=red>(Ko Thể Bán)<color>" ,self.VeCuongHoaTrangSuc, self};
		{"<color=pink>Trở Lại Trước<color>",self.VatPham,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:VeCuongHoaVuKhi()
	me.AddItem(18,1,518,1,0,1); --Vé Cường Hóa Vũ Khí
end

function tbLiGuan:VeCuongHoaPhongCu()
	me.AddItem(18,1,519,1,0,1); --Vé Cường Hóa Phòng Cụ
end

function tbLiGuan:VeCuongHoaTrangSuc()
	me.AddItem(18,1,520,1,0,1); --Vé Cường Hóa Trang Sức
end

function tbLiGuan:LuyenHoaDo()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Bộ Thủy Hoàng",self.BoThuyHoang, self};
		{"Bộ Trục Lộc",self.BoTrucLoc, self};
		{"Bộ Tiêu Dao",self.BoTieuDao, self};
		{"<color=pink>Trở Lại Trước<color>",self.VatPham,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

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

function tbLiGuan:HuyenTinh()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:HuyenTinh1()
	for i=1,10 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,1,1); --Huyền tinh 1
		else
			break
		end
	end
end

function tbLiGuan:HuyenTinh2()
	for i=1,10 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,1,2); --Huyền tinh 2
		else
			break
		end
	end
end

function tbLiGuan:HuyenTinh3()
	for i=1,10 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,1,3); --Huyền tinh 3
		else
			break
		end
	end
end

function tbLiGuan:HuyenTinh4()
	for i=1,10 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,1,4);
		else
			break
		end
	end
end

function tbLiGuan:HuyenTinh5()
	for i=1,10 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,1,5);
		else
			break
		end
	end
end

function tbLiGuan:HuyenTinh6()
	for i=1,10 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,1,6);
		else
			break
		end
	end
end

function tbLiGuan:HuyenTinh7()
	for i=1,10 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,1,7);
		else
			break
		end
	end
end

function tbLiGuan:HuyenTinh8()
	for i=1,10 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,1,8);
		else
			break
		end
	end
end

function tbLiGuan:HuyenTinh9()
	for i=1,10 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,1,9);
		else
			break
		end
	end
end

function tbLiGuan:HuyenTinh10()
	for i=1,10 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,1,10);
		else
			break
		end
	end
end

function tbLiGuan:HuyenTinh11()
	for i=1,10 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,1,11);
		else
			break
		end
	end
end

function tbLiGuan:HuyenTinh12()
	for i=1,10 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,1,12);
		else
			break
		end
	end
end

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

function tbLiGuan:NguyetAnhThach()
	for i=1,1000 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,476,1); --Nguyệt Ảnh Thạch
		else
			break
		end
	end
end

function tbLiGuan:BuaSuaTrangBi()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Bùa Sửa Phòng Cụ Cường 16",self.BuaSuaPC16,self};
		{"Bùa Sửa Trang Sức Cường 16",self.BuaSuaTS16,self};
		{"Bùa Sửa Vũ Khí Cường 16",self.BuaSuaVK16,self};
		{"<color=pink>Trở Lại Trước<color>",self.VatPham,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:BuaSuaPC16()
	me.AddItem(18,3,1,16); --Bùa sửa phòng cụ cường 16
end

function tbLiGuan:BuaSuaTS16()
	me.AddItem(18,3,2,16); --Bùa sửa trang sức cường 16
end

function tbLiGuan:BuaSuaVK16()
	me.AddItem(18,3,3,16); --Bùa sửa vủ khí cường 16
end

function tbLiGuan:NguyetAnhNguyenThach()
	for i=1,100 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(22,1,91,1,0,1); --Nguyệt Ảnh Nguyên Thạch
		else
			break
		end
	end
end

function tbLiGuan:VoSoVang()
	for i=1,500 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,325,1); --Vỏ Sò Vàng
		else
			break
		end
	end
end

function tbLiGuan:RuongVoSoVang()
	for i=1,10 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,338,1); --Rương Vỏ Sò Vàng
		else
			break
		end
	end
end

function tbLiGuan:RuongCaoQuy()
	for i=1,20 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,324,1); --Rương vừa đẹp vừa cao quý
		else
			break
		end
	end
end

function tbLiGuan:RuongDaMinhChau()
	me.AddItem(18,1,382,1); --Rương dạ minh châu
end

function tbLiGuan:TuLuyenDon()
	for i=1,5 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,258,1); --Tu Luyện Đơn
		else
			break
		end
	end
end

function tbLiGuan:TinhLucHoatLuc()
	me.ChangeCurMakePoint(1000000); --Nhận 1000.000 Tinh Lực
	me.ChangeCurGatherPoint(1000000); --Nhận 1000.000 Hoạt Lực
end

function tbLiGuan:NguHanhHonThach()
	for i=1,20 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,244,2); --Rương Ngũ Hành Hồn Thạch
		else
			break
		end
	end
end

function tbLiGuan:NgocTrucMaiHoa()
	for i=1,1 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(19,3,1,7); --Ngọc Trúc Mai Hoa
		else
			break
		end
	end
end

function tbLiGuan:NguHoaNgocLoHoan()
	for i=1,5 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,42,1,0); --Ngũ Hoa Ngọc Lộ Hoàn
		else
			break
		end
	end
end

function tbLiGuan:VanVatQuyNguyenDon()
	for i=1,5 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,384,1); --Vạn vật quy nguyên đơn
		else
			break
		end
	end
end

function tbLiGuan:ToTienBaoHo()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Tổ Tiên Bảo Hộ - Thường",self.ToTienBaoHo1, self};
		{"Tổ Tiên Bảo Hộ - Phụng Hoàng",self.ToTienBaoHo2, self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:ToTienBaoHo1()
	me.AddItem(18,1,957,1,0,0); --Tổ Tiên Bảo Hộ Thường
end

function tbLiGuan:ToTienBaoHo2()
	me.AddItem(18,1,957,2,0,0); --Tổ Tiên Bảo Hộ - Phụng Hoàng
end

function tbLiGuan:BanhItHoLo()
	me.AddItem(18,1,326,4); --Bánh ít hồ lô
end

function tbLiGuan:TuiTanThu()
	me.AddItem(18,1,351,1); --Túi Tân Thủ
end

function tbLiGuan:lsDuLong()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Trứng Du Long (8)",self.lsTrungDuLong,self};
		{"Chiến Thư Mật Thất Du Long (100)",self.ChienThuDuLong,self};
		{"Du Long Danh Vọng Lệnh",self.DuLongDanhVongLenh,self};
		{"Tiền Du Long",self.Tiendulong,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:Tiendulong()
	for i=1,1000 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,553,1,0,0);
		else
			break
		end
	end
end

function tbLiGuan:lsTrungDuLong()
	for i=1,10 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,525,1); --Trứng Du Long
		else
			break
		end
	end
end

function tbLiGuan:ChienThuDuLong()
	for i=1,100 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,524,1);
		else
			break
		end
	end
end

function tbLiGuan:DuLongDanhVongLenh()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:lsLenhBai()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Danh Bổ Lệnh",self.lsDanhBoLenh,self};
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

function tbLiGuan:lsDanhBoLenh()
	for i=1,300 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,190,1); --Danh bổ lệnh
		else
			break
		end
	end
end

function tbLiGuan:lsBachHoDuong()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"LB Bạch Hổ Đường (Sơ)",self.BachHoDuongSo,self};
		{"LB Bạch Hổ Đường (Trung)",self.BachHoDuongTrung,self};
		{"LB Bạch Hổ Đường (Cao)",self.BachHoDuongCao,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsLenhBai,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:BachHoDuongSo()
	for i=1,5 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,111,1); --Lệnh bài bạch hổ đường sơ
		else
			break
		end
	end
end

function tbLiGuan:BachHoDuongTrung()
	for i=1,5 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,111,2); --Lệnh bài bạch hổ đường trung
		else
			break
		end
	end
end

function tbLiGuan:BachHoDuongCao()
	for i=1,5 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,111,3); --Lệnh bài bạch hổ đường cao
		else
			break
		end
	end
end

function tbLiGuan:lsChucPhuc()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"LB Chúc Phúc (Sơ)",self.ChucPhucSo,self};
		{"LB Chúc Phúc (Trung)",self.ChucPhucTrung,self};
		{"LB Chúc Phúc (Cao)",self.ChucPhucCao,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsLenhBai,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:ChucPhucSo()
	for i=1,5 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,212,1); --Lệnh bài Chúc Phúc sơ
		else
			break
		end
	end
end

function tbLiGuan:ChucPhucTrung()
	for i=1,5 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,212,2); --Lệnh bài Chúc Phúc trung
		else
			break
		end
	end
end

function tbLiGuan:ChucPhucCao()
	for i=1,5 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,212,3); --Lệnh bài Chúc Phúc cao
		else
			break
		end
	end
end

function tbLiGuan:MoRongRuong()
	me.AddItem(18,1,216,1); --Lệnh bài mở rộng rương lv1
	me.AddItem(18,1,216,2); --Lệnh bài mở rộng rương lv2
end

function tbLiGuan:LBUyDanh()
	for i=1,5 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,236,1); --Lệnh Bài Uy Danh Giang Hồ (20đ)
		else
			break
		end
	end
end

function tbLiGuan:lsThuCuoiDongHanh()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Thú Cưỡi" ,self.lsThuCuoi, self};
		{"Đồng Hành" ,self.lsDongHanh, self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:lsThuCuoi()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:lsThuCuoi1()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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
		{"<<<" ,self.lsThuCuoi, self};
		{"<color=pink>Trở Lại Trước<color>",self.lsThuCuoiDongHanh,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:DayCuongThanBi()
	me.AddItem(18,1,237,1); --Dây cương thần bí
end

function tbLiGuan:PhienVu()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:lsDongHanh()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Bạn Đồng Hành" ,self.BanDongHanh, self};
		{"Mật Tịch Đồng Hành" ,self.MatTichDongHanh, self};
		{"Đồng Hành Tẩy Tủy Kinh" ,self.Donghanhtaytuy, self};
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

function tbLiGuan:Donghanhtaytuy()
me.AddItem(18,1,616,1);
me.AddItem(18,1,617,2);
end

function tbLiGuan:BanDongHanh()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"ĐH năm mới 6 Kỹ Năng" ,self.BanDongHanh6KN, self};
		{"ĐH chu đáo 4 Kỹ Năng" ,self.BanDongHanh4KN, self};
		{"ĐH Võ Lâm 4 Kỹ Năng" ,self.BanDongHanhVL, self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:BanDongHanh6KN()
	me.AddItem(18,1,547,2); --Đồng hành 6 KN
	me.AddItem(18,1,547,2); --Đồng hành 6 KN
end

function tbLiGuan:BanDongHanh4KN()
	me.AddItem(18,1,547,1); --ĐH 4KN
	me.AddItem(18,1,547,1); --ĐH 4KN
end

function tbLiGuan:BanDongHanhVL()
	me.AddItem(18,1,547,1); --ĐH 4KN
	me.AddItem(18,1,547,1); --ĐH 4KN
end

function tbLiGuan:MatTichDongHanh()
	me.AddItem(18,1,554,4); --MTDH cao
	me.AddItem(18,1,554,4); --MTDH cao
	me.AddItem(18,1,554,4); --MTDH cao
	me.AddItem(18,1,554,4); --MTDH cao
	me.AddItem(18,1,554,4); --MTDH cao
	me.AddItem(18,1,554,4); --MTDH cao
end

function tbLiGuan:NguyenLieuDongHanh()
	me.AddItem(18,1,556,1); -- nguyen lieu dong hanh dac biet
end

function tbLiGuan:lsSachKinhNghiemDongHanh()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Sách KN Đồng Hành Thường (10Q)" ,self.SachKinhNghiemDongHanh1, self};
		{"Sách KN Đồng Hành Đặc Biệt (10Q)" ,self.SachKinhNghiemDongHanh2, self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:SachKinhNghiemDongHanh1()
	for i=1,10 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,543,1);	--sách kn đồng hành
		else
			break
		end
	end
	
end

function tbLiGuan:SachKinhNghiemDongHanh2()
	for i=1,10 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,543,2,0,1); --Sách KN Đồng Hành Đặc Biệt
		else
			break
		end
	end
end

function tbLiGuan:ThiepBacThiepLua()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Thiệp Bạc (5)" ,self.ThiepBac, self};
		{"Thiệp Lụa (5)",self.ThiepLua, self};
		{"Rương Thiệp Lụa" ,self.RuongThiepLua, self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:ThiepBac()
	for i=1,10 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,541,2); --Thiệp Bạc
		else
			break
		end
	end
end

function tbLiGuan:ThiepLua()
	for i=1,10 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,541,1);	--Thiệp lụa
		else
			break
		end
	end
end

function tbLiGuan:TinhPhach()
	me.AddItem(18,1,544,1); --Tinh Phách thường
	me.AddItem(18,1,544,2); --Tinh Phách đặc biệt
	me.AddItem(18,1,544,3); --Tinh Phách kỳ diệu
	me.AddItem(18,1,544,4); --Tinh Phách thần kỳ
end

function tbLiGuan:lsChuyenSinhPet()
    me.AddItem(18,1,564,1); --Bồ Đề Quả - Chuyển sinh cho PET
end

function tbLiGuan:ThuDongHanh()
    me.AddItem(18,1,566,1,0,1); --Thư Đồng Hành
end

function tbLiGuan:BachNganTinhHoa()
	me.AddItem(18,1,565,1); --Bạch ngân tinh hoa
end

function tbLiGuan:lsGoiBoss()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Nhận Cầu hồn ngọc (4)",self.Cauhon,self};
		{"Gọi Boss",self.GoiBoss,self};
		{"Phó Bản",self.PhoBan,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:Cauhon()
	me.AddItem(18,1,146,3); --Cầu hồn ngọc
	me.AddItem(18,1,146,3);
	me.AddItem(18,1,146,3);
	me.AddItem(18,1,146,3);
	me.AddItem(18,1,146,3);
end

function tbLiGuan:GoiBoss()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		--[[{"Bách Phu Trường",self.GoiBoss1,self};
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
		{"<color=red>Niên Thú<color>",self.GoiBoss12,self};]]
		{"<color=gold>Nhu Tiểu Thúy (Kim)<color>",self.GoiBoss1,self},
		{"<color=green>Trương Thiện Đức (Mộc)<color>",self.GoiBoss2,self},
		{"<color=blue>Cổ Dật Sơn (Thủy)<color>",self.GoiBoss3,self},
		{"<color=red>Ô Thanh Sơn (Hỏa)<color>",self.GoiBoss4,self},
		{"<color=wheat>Trần Vô Mệnh (Thổ)<color>",self.GoiBoss5,self},
		{"<color=gold>Vạn Tuyết Sơn (Kim)<color>",self.GoiBoss6,self},
		{"<color=green>Hình Bộ Đầu (Mộc)<color>",self.GoiBoss7,self},
		{"<color=blue>Vạn Lão Điên (Thủy)<color>",self.GoiBoss8,self},
		{"<color=red>Cao Sĩ Hiền (Hỏa)<color>",self.GoiBoss9,self},
		{"<color=wheat>Thác Bạc Sơn Xuyên (Thổ)<color>",self.GoiBoss10,self},
		{"<color=gold>Dương Liễu (Kim)<color>",self.GoiBoss11,self},
		{"<color=green>Thần Thương Phương Vấn (Mộc)<color>",self.GoiBoss12,self},
		{"<color=blue>Triệu Ứng Tiên (Thủy)<color>",self.GoiBoss13,self},
		{"<color=red>Hướng Ngọc Tiên (Hỏa)<color>",self.GoiBoss14,self},
		{"<color=wheat>Man Tăng Bất Giới Hòa Thượng (Thổ)<color>",self.GoiBoss15,self},
		{"Tần Thủy Hoàng-Hoan Thần",self.GoiBoss16,self},
		{"Tần Thủy Hoàng-Mị Ảnh",self.GoiBoss17,self},
		{"Tần Thủy Hoàng-Tử Vi",self.GoiBoss18,self},
		{"<color=pink>Trở Lại Trước<color>",self.lsGoiBoss,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:Boss55()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
	KNpc.Add2(2401, 59,75, nMapId, nPosX, nPosY);
	KNpc.Add2(2402, 59,75, nMapId, nPosX, nPosY);
	KNpc.Add2(2403, 59,75, nMapId, nPosX, nPosY);
	KNpc.Add2(2404, 59,75, nMapId, nPosX, nPosY);
	KNpc.Add2(2405, 59,75, nMapId, nPosX, nPosY);
	KNpc.Add2(2406, 59,75, nMapId, nPosX, nPosY);
end

function tbLiGuan:Boss75()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2407, 79,75, nMapId, nPosX, nPosY);
	KNpc.Add2(2408, 79,75, nMapId, nPosX, nPosY);
	KNpc.Add2(2409, 79,75, nMapId, nPosX, nPosY);
	KNpc.Add2(2410, 79,75, nMapId, nPosX, nPosY);
	KNpc.Add2(2411, 79,75, nMapId, nPosX, nPosY);
end

function tbLiGuan:Boss95()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2421, 99,75, nMapId, nPosX, nPosY);
	KNpc.Add2(2422, 99,75, nMapId, nPosX, nPosY);
	KNpc.Add2(2423, 99,75, nMapId, nPosX, nPosY);
	KNpc.Add2(2424, 99,75, nMapId, nPosX, nPosY);
	KNpc.Add2(2425, 99,75, nMapId, nPosX, nPosY);
end

function tbLiGuan:BossTTH()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2426, 150,75, nMapId, nPosX, nPosY);
	KNpc.Add2(2451, 150,75, nMapId, nPosX, nPosY);
	KNpc.Add2(2452, 150,75, nMapId, nPosX, nPosY);
	KNpc.Add2(2453, 150,75, nMapId, nPosX, nPosY);
	KNpc.Add2(2454, 150,75, nMapId, nPosX, nPosY);
	KNpc.Add2(2455, 150,75, nMapId, nPosX, nPosY);
end

function tbLiGuan:GoiBoss1()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2934 , 1,95, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss2()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2935, 2,95, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss3()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2936, 3,95, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss4()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2937, 4,95, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss5()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2938, 5,95, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss6()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2401 , 6,45, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss7()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2402, 7,45, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss8()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2403, 8,45, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss9()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2404, 9,45, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss10()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2405, 10,45, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss11()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2( 2406 , 11,75, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss12()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2407, 12,75, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss13()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2408, 13,75, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss14()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2409, 14,75, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end
function tbLiGuan:GoiBoss15()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2410, 15,75, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss16()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2474, 16,120, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss17()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2475, 17,120, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

function tbLiGuan:GoiBoss18()
    local nMapId, nPosX, nPosY = me.GetWorldPos();
    KNpc.Add2(2426, 18,120, nMapId, nPosX, nPosY);
    me.Msg(string.format("Đã gọi Bos tại map số %d tọa độ %d/%d",nMapId,nPosX/8,nPosY/16));
end

--[[
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
--]]

function tbLiGuan:PhoBan()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Lệnh Bài Phó Bản",self.LenhBaiPhoBan,self};
		{"<color=pink>Trở Lại Trước<color>",self.lsGoiBoss,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:LenhBaiPhoBan()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"LB Thiên Quỳnh Cung",self.LenhBaiThienQuynhCung,self};
		{"LB Vạn Hoa Cốc",self.LenhBaiVanHoaCoc,self};
		{"<color=pink>Trở Lại Trước<color>",self.PhoBan,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:LenhBaiThienQuynhCung()
    me.AddItem(18,1,186,1); --Lệnh Bài Thiên Quỳnh Cung
end

function tbLiGuan:LenhBaiVanHoaCoc()
    me.AddItem(18,1,245,1); --Lệnh Bài Vạn Hoa Cốc
end

function tbLiGuan:lsTiemNangKyNang()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = { 		
		{"Luyện Max Skill Kỹ Năng Môn Phái",self.MaxSkillMonPhai,self};
		{"Nhận 1000 Tiềm Năng",self.DiemTiemNang,self};
		{"Xóa 1000 Tiềm Năng",self.XoaDiemTiemNang,self};
		{"Nhận 20 Điểm Kỹ Năng",self.DiemKyNang,self};
		{"Xóa 20 Điểm Kỹ Năng",self.XoaDiemKyNang,self};
		{"Skill 120",self.skill120, self};	
	    {"Mật Tịch Cao",self.MatTichCao, self};
		{"Luyện Max Skill Mật Tịch Trung",self.lsMatTichTrung,self};
		{"Luyện Max Skill Mật Tịch Cao",self.lsMatTichCao,self};
		{"Võ Lâm Mật Tịch - Tẩy Tủy",self.VoLamTayTuy,self};
		{"Bánh Tiềm Năng - Kỹ Năng",self.BanhTrai,self};
		{"Reset Skill",self.Resetskill,self},
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:Resetskill()
	me.ResetFightSkillPoint();
end

function tbLiGuan:MaxSkillMonPhai() 
    if me.nFaction > 0 then 
        if me.nFaction == 1 then    --Skill Thiếu Lâm 
            --Skill Đao Thiếu 
            me.AddFightSkill(21,20);    --Phục Ma Đao Pháp 
            me.AddFightSkill(22,20);    --Thiếu Lâm Đao Pháp 
            me.AddFightSkill(23,20);    --Dịch Cốt Kinh 
            me.AddFightSkill(25,20);    --A La Hán Thần Công 
            me.AddFightSkill(24,20);    --Phá Giới Đao Pháp 
            me.AddFightSkill(250,20);    --Hàng Long Phục Hổ 
            me.AddFightSkill(26,20);    --Bồ Đề Tâm Pháp 
            me.AddFightSkill(28,20);    --Hỗn Nguyên Nhất Khí 
            me.AddFightSkill(27,20);    --Thiên Trúc Tuyệt Đao 
            me.AddFightSkill(252,20);    --Như Lai Thiên Diệp 
            me.AddFightSkill(819,20);    --Thiền Nguyên Công 
            --me.AddFightSkill(820,20);    --Kỹ năng cấp 120 
            --Skill Côn Thiếu 
            me.AddFightSkill(29,20);    --Phổ Độ Côn Pháp 
            me.AddFightSkill(30,20);    --Thiếu Lâm Côn Pháp 
            me.AddFightSkill(31,20);    --Sư Tử Hống 
            me.AddFightSkill(25,20);    --A La Hán Thần Công 
            me.AddFightSkill(33,20);    --Phục Ma Côn Pháp 
            me.AddFightSkill(34,20);    --Bất Động Minh Vương 
            me.AddFightSkill(254,20);    --Dịch Cốt Kinh 
            me.AddFightSkill(37,20);    --Đạt Ma Vũ Kinh 
            me.AddFightSkill(36,20);    --Thất Tinh La Sát Côn 
            me.AddFightSkill(255,20);    --Vô Tướng Thần Công 
            me.AddFightSkill(821,20);    --Túy Bát Tiên Côn 
            --me.AddFightSkill(822,20);    --Kỹ năng cấp 120 
        elseif me.nFaction == 2 then    --Skill Thiên Vương 
            --Thương Thiên 
            me.AddFightSkill(38,20);    --Hồi Phong Lạc Nhạn 
            me.AddFightSkill(40,20);    --Thiên Vương Thương Pháp 
            me.AddFightSkill(41,20);    --Đoạn Hồn Thích     
            me.AddFightSkill(45,20);    --Tĩnh Tâm Quyết 
            me.AddFightSkill(43,20);    --Dương Quan Tam Điệp 
            me.AddFightSkill(256,20);    --Kinh Lôi Phá Thiên 
            me.AddFightSkill(46,20);    --Thiên Vương Chiến Ý     
            me.AddFightSkill(49,20);    --Thiên Canh Chiến Khí     
            me.AddFightSkill(47,20);    --Truy Tinh Trục Nguyệt 
            me.AddFightSkill(259,20);    --Huyết Chiến Bát Phương     
            me.AddFightSkill(823,20);    --Bôn Lôi Toàn Long Thương     
            --me.AddFightSkill(824,20);    --Kỹ năng cấp 120
            --Chùy Thiên 
            me.AddFightSkill(50,20);    --Hành Vân Quyết 
            me.AddFightSkill(52,20);    --Thiên Vương Chùy Pháp 
            me.AddFightSkill(41,20);    --Đoạn Hồn Thích 
            me.AddFightSkill(781,20);    --Tĩnh Tâm Thuật 
            me.AddFightSkill(53,20);    --Truy Phong Quyết 
            me.AddFightSkill(260,20);    --Thiên Vương Bản Sinh 
            me.AddFightSkill(55,20);    --Kim Chung Tráo 
            me.AddFightSkill(58,20);    --Đảo Hư Thiên 
            me.AddFightSkill(56,20);    --Thừa Long Quyết 
            me.AddFightSkill(262,20);    --Bất Diệt Sát Ý 
            me.AddFightSkill(825,20);    --Trảm Long Quyết 
            --me.AddFightSkill(826,20);    --Kỹ năng cấp 120
        elseif me.nFaction == 3 then    --Đường Môn 
            --Hãm Tĩnh 
            me.AddFightSkill(69,20);    --Độc Thích Cốt 
            me.AddFightSkill(70,20);    --Đường Môn Hãm Tĩnh 
            me.AddFightSkill(64,20);    --Mê Ảnh Tung     
            me.AddFightSkill(71,20);    --Câu Hồn Tĩnh 
            me.AddFightSkill(72,20);    --Tiểu Lý Phi Đao 
            me.AddFightSkill(263,20);    --Hấp Tinh Trận 
            me.AddFightSkill(73,20);    --Triền Thân Thích     
            me.AddFightSkill(75,20);    --Tâm Phách     
            me.AddFightSkill(74,20);    --Loạn Hoàn Kích 
            me.AddFightSkill(265,20);    --Thực Cốt Huyết Nhẫn     
            me.AddFightSkill(827,20);    --Cơ Quan Bí Thuật     
            --me.AddFightSkill(828,20);    --Kỹ năng cấp 120     
            --Tụ Tiễn 
            me.AddFightSkill(59,20);    --Truy Tâm Tiễn 
            me.AddFightSkill(60,20);    --Đường Môn Tụ Tiễn 
            me.AddFightSkill(64,20);    --Mê Ảnh Tung     
            me.AddFightSkill(61,20);    --Tôi Độc Thuật 
            me.AddFightSkill(62,20);    --Thiên La Địa Võng 
            me.AddFightSkill(266,20);    --Đoạn Cân Nhẫn 
            me.AddFightSkill(65,20);    --Ngự Độc Thuật     
            me.AddFightSkill(68,20);    --Tâm Ma     
            me.AddFightSkill(66,20);    --Bạo Vũ Lê Hoa 
            me.AddFightSkill(268,20);    --Tâm Nhãn     
            me.AddFightSkill(829,20);    --Thất Tuyệt Sát Quang     
            --me.AddFightSkill(830,20);    --Kỹ năng cấp 120
        elseif me.nFaction == 4 then    --Ngũ Độc 
            --Đao Độc 
            me.AddFightSkill(76 ,20);  -- Huyết Đao Độc Sát 
            me.AddFightSkill(77 ,20);  -- Ngũ Độc Đao Pháp 
            me.AddFightSkill(78 ,20);  -- Vô Hình Cổ 
            me.AddFightSkill(81 ,20);  -- Thí Độc Thuật 
            me.AddFightSkill(80 ,20);  -- Bách Độc Xuyên Tâm 
            me.AddFightSkill(269 ,20);  -- Ôn Cổ Chi Khí 
            me.AddFightSkill(82 ,20);  -- Vạn Cổ Thực Tâm 
            me.AddFightSkill(85 ,20);  -- Ngũ Độc Kỳ Kinh 
            me.AddFightSkill(83 ,20);  -- Huyền Âm Trảm 
            me.AddFightSkill(271 ,20);  -- Thiên Thù Vạn Độc 
            me.AddFightSkill(831 ,20);  -- Chu Cáp Thanh Minh 
            --me.AddFightSkill(832 ,20);  -- Kỹ năng cấp 120 
            --Chưởng Độc 
            me.AddFightSkill(86 ,20);  -- Độc Sa Chưởng 
            me.AddFightSkill(87 ,20);  -- Ngũ Độc Chưởng Pháp 
            me.AddFightSkill(92 ,20);  -- Xuyên Tâm Độc Thích 
            me.AddFightSkill(91 ,20);  -- Ngân Ti Phi Thù 
            me.AddFightSkill(90 ,20);  -- Thiên Canh Địa Sát 
            me.AddFightSkill(272 ,20);  -- Khu Độc Thuật 
            me.AddFightSkill(88 ,20);  -- Bi Ma Huyết Quang 
            me.AddFightSkill(95 ,20);  -- Bách Cổ Độc Kinh 
            me.AddFightSkill(93 ,20);  -- Âm Phong Thực Cốt 
            me.AddFightSkill(274 ,20);  -- Đoạn Cân Hủ Cốt 
            me.AddFightSkill(833 ,20);  -- Hóa Cốt Miên Chưởng 
            --me.AddFightSkill(834 ,20);  -- Kỹ năng cấp 120
        elseif me.nFaction == 5 then    --Nga My 
            --Chưởng Nga 
            me.AddFightSkill(96 ,20);  -- Phiêu Tuyết Xuyên Vân 
            me.AddFightSkill(97 ,20);  -- Nga My Chưởng Pháp 
            me.AddFightSkill(98 ,20);  -- Từ Hàng Phổ Độ 
            me.AddFightSkill(101 ,20);  -- Phật Tâm Từ Hựu 
            me.AddFightSkill(99 ,20);  -- Tứ Tượng Đồng Quy 
            me.AddFightSkill(479 ,20);  -- Bất Diệt Bất Tuyệt 
            me.AddFightSkill(782 ,20);  -- Lưu Thủy Tâm Pháp 
            me.AddFightSkill(105 ,20);  -- Phật Pháp Vô Biên 
            me.AddFightSkill(103 ,20);  -- Phong Sương Toái Ảnh 
            me.AddFightSkill(280 ,20);  -- Vạn Phật Quy Tông 
            me.AddFightSkill(835 ,20);  -- Phật Quang Chiến Khí 
            --me.AddFightSkill(836 ,20);  -- Kỹ năng cấp 120
            --Phụ Trợ 
            me.AddFightSkill(107 ,20);  -- Phật Âm Chiến Ý 
            me.AddFightSkill(106 ,20);  -- Mộng Điệp 
            me.AddFightSkill(98 ,20);  -- Từ Hàng Phổ Độ 
            me.AddFightSkill(101 ,20);  -- Phật Tâm Từ Hựu 
            me.AddFightSkill(109 ,20);  -- Thiên Phật Thiên Diệp 
            me.AddFightSkill(110 ,20);  -- Phật Quang Phổ Chiếu 
            me.AddFightSkill(102 ,20);  -- Lưu Thủy Quyết 
            me.AddFightSkill(481 ,20);  -- Ba La Tâm Kinh 
            me.AddFightSkill(108 ,20);  -- Thanh Âm Phạn Xướng 
            me.AddFightSkill(482 ,20);  -- Phổ Độ Chúng Sinh 
            me.AddFightSkill(837 ,20);  -- Kiếm Ảnh Phật Quang 
           --me.AddFightSkill(838 ,20);  -- Kỹ năng cấp 120
        elseif me.nFaction == 6 then    --Thúy Yên 
            --Kiếm Thúy 
            me.AddFightSkill(111 ,20);  -- Phong Quyển Tàn Tuyết 
            me.AddFightSkill(112 ,20);  -- Thúy Yên Kiếm Pháp 
            me.AddFightSkill(113 ,20);  -- Hộ Thể Hàn Băng 
            me.AddFightSkill(115 ,20);  -- Tuyết Ảnh 
            me.AddFightSkill(114 ,20);  -- Bích Hải Triều Sinh 
            me.AddFightSkill(483 ,20);  -- Huyền Băng Vô Tức 
            me.AddFightSkill(116 ,20);  -- Tuyết Ánh Hồng Trần 
            me.AddFightSkill(119 ,20);  -- Băng Cốt Tuyết Tâm 
            me.AddFightSkill(117 ,20);  -- Băng Tâm Tiên Tử 
            me.AddFightSkill(485 ,20);  -- Phù Vân Tán Tuyết 
            me.AddFightSkill(839 ,20);  -- Thập Diện Mai Phục 
            --me.AddFightSkill(840 ,20);  -- Kỹ năng cấp 120 
            --Đao Thúy 
            me.AddFightSkill(120 ,20);  -- Phong Hoa Tuyết Nguyệt 
            me.AddFightSkill(121 ,20);  -- Thúy Yên Đao Pháp 
            me.AddFightSkill(122 ,20);  -- Ngự Tuyết Ẩn 
            me.AddFightSkill(115 ,20);  -- Tuyết Ảnh 
            me.AddFightSkill(123 ,20);  -- Mục Dã Lưu Tinh 
            me.AddFightSkill(483 ,20);  -- Huyền Băng Vô Tức 
            me.AddFightSkill(124 ,20);  -- Băng Tâm Thiến Ảnh 
            me.AddFightSkill(127 ,20);  -- Băng Cơ Ngọc Cốt 
            me.AddFightSkill(125 ,20);  -- Băng Tung Vô Ảnh 
            me.AddFightSkill(486 ,20);  -- Thiên Lý Băng Phong 
            me.AddFightSkill(841 ,20);  -- Quy Khứ Lai Hề 
            --me.AddFightSkill(842 ,20);  -- Kỹ năng cấp 120
        elseif me.nFaction == 7 then    --Cái Bang 
            --Chưởng Cái 
            me.AddFightSkill(128 ,20);  -- Kiến Nhân Thân Thủ 
            me.AddFightSkill(129 ,20);  -- Cái Bang Chưởng Pháp 
            me.AddFightSkill(130 ,20);  -- Hóa Hiểm Vi Di 
            me.AddFightSkill(132 ,20);  -- Hoạt Bất Lưu Thủ 
            me.AddFightSkill(131 ,20);  -- Hàng Long Hữu Hối 
            me.AddFightSkill(489 ,20);  -- Thời Thừa Lục Long 
            me.AddFightSkill(133 ,20);  -- Túy Điệp Cuồng Vũ 
            me.AddFightSkill(136 ,20);  -- Tiềm Long Tại Uyên 
            me.AddFightSkill(134 ,20);  -- Phi Long Tại Thiên 
            me.AddFightSkill(487 ,20);  -- Giáng Long Chưởng 
            me.AddFightSkill(843 ,20);  -- Trảo Long Công 
            --me.AddFightSkill(844 ,20);  -- Kỹ năng cấp 120 
            --Côn Cái 
            me.AddFightSkill(137 ,20);  -- Duyên Môn Thác Bát 
            me.AddFightSkill(138 ,20);  -- Cái Bang Bổng Pháp 
            me.AddFightSkill(139 ,20);  -- Tiêu Dao Công 
            me.AddFightSkill(132 ,20);  -- Hoạt Bất Lưu Thủ 
            me.AddFightSkill(140 ,20);  -- Bổng Đả Ác Cẩu 
            me.AddFightSkill(491 ,20);  -- Ác Cẩu Lan Lộ 
            me.AddFightSkill(238 ,20);  -- Hỗn Thiên Khí Công 
            me.AddFightSkill(142 ,20);  -- Bôn Lưu Đáo Hải 
            me.AddFightSkill(141 ,20);  -- Thiên Hạ Vô Cẩu 
            me.AddFightSkill(488 ,20);  -- Đả Cẩu Bổng Pháp 
            me.AddFightSkill(845 ,20);  -- Đả Cẩu Trận Pháp 
            --me.AddFightSkill(846 ,20);  -- Kỹ năng cấp 120 
        elseif me.nFaction == 8 then    --Thiên Nhẫn 
            --Chiến Nhẫn 
            me.AddFightSkill(143 ,20);  -- Tàn Dương Như Huyết 
            me.AddFightSkill(144 ,20);  -- Thiên Nhẫn Mâu Pháp 
            me.AddFightSkill(492 ,20);  -- Huyễn Ảnh Truy Hồn Thương 
            me.AddFightSkill(145 ,20);  -- Kim Thiền Thoát Xác 
            me.AddFightSkill(146 ,20);  -- Liệt Hỏa Tình Thiên 
            me.AddFightSkill(147 ,20);  -- Bi Tô Thanh Phong 
            me.AddFightSkill(148 ,20);  -- Ma Âm Phệ Phách 
            me.AddFightSkill(150 ,20);  -- Thiên Ma Giải Thể 
            me.AddFightSkill(149 ,20);  -- Vân Long Kích 
            me.AddFightSkill(493 ,20);  -- Ma Viêm Tại Thiên 
            me.AddFightSkill(847 ,20);  -- Phi Hồng Vô Tích 
            --me.AddFightSkill(848 ,20);  -- Kỹ năng cấp 120 
            --Ma Nhẫn 
            me.AddFightSkill(151 ,20);  -- Đạn Chỉ Liệt Diệm 
            me.AddFightSkill(152 ,20);  -- Thiên Nhẫn Đao Pháp 
            me.AddFightSkill(154 ,20);  -- Lệ Ma Đoạt Hồn 
            me.AddFightSkill(145 ,20);  -- Kim Thiền Thoát Xác 
            me.AddFightSkill(153 ,20);  -- Thôi Sơn Điền Hải 
            me.AddFightSkill(494 ,20);  -- Hỏa Liên Phần Hoa 
            me.AddFightSkill(155 ,20);  -- Nhiếp Hồn Loạn Tâm 
            me.AddFightSkill(158 ,20);  -- Xí Không Ma Diệm 
            me.AddFightSkill(156 ,20);  -- Thiên Ngoại Lưu Tinh 
            me.AddFightSkill(496 ,20);  -- Ma Diệm Thất Sát 
            me.AddFightSkill(849 ,20);  -- Thúc Phọc Chú 
            --me.AddFightSkill(850 ,20);  -- Kỹ năng cấp 120 
        elseif me.nFaction == 9 then    --Võ Đang 
            --Khí Võ 
            me.AddFightSkill(159 ,20);  -- Bác Cập Nhi Phục 
            me.AddFightSkill(160 ,20);  -- Võ Đang Quyền Pháp 
            me.AddFightSkill(161 ,20);  -- Tọa Vọng Vô Ngã 
            me.AddFightSkill(163 ,20);  -- Thê Vân Tung 
            me.AddFightSkill(162 ,20);  -- Vô Ngã Vô Kiếm 
            me.AddFightSkill(497 ,20);  -- Thuần Dương Vô Cực 
            me.AddFightSkill(164 ,20);  -- Chân Vũ Thất Tiệt 
            me.AddFightSkill(166 ,20);  -- Thái Cực Vô Ý 
            me.AddFightSkill(165 ,20);  -- Thiên Địa Vô Cực 
            me.AddFightSkill(498 ,20);  -- Thái Cực Thần Công 
            me.AddFightSkill(851 ,20);  -- Võ Đang Cửu Dương 
            --me.AddFightSkill(852 ,20);  -- Kỹ năng cấp 120 
            --Kiếm Võ 
            me.AddFightSkill(167 ,20);  -- Kiếm Phi Kinh Thiên 
            me.AddFightSkill(168 ,20);  -- Võ Đang Kiếm Pháp 
            me.AddFightSkill(783 ,20);  -- Vô Ngã Tâm Pháp 
            me.AddFightSkill(163 ,20);  -- Thê Vân Tung 
            me.AddFightSkill(169 ,20);  -- Tam Hoàn Sáo Nguyệt 
            me.AddFightSkill(499 ,20);  -- Thái Nhất Chân Khí 
            me.AddFightSkill(170 ,20);  -- Thất Tinh Quyết 
            me.AddFightSkill(174 ,20);  -- Kiếm Khí Tung Hoành 
            me.AddFightSkill(171 ,20);  -- Nhân Kiếm Hợp Nhất 
            me.AddFightSkill(500 ,20);  -- Thái Cực Kiếm Pháp 
            me.AddFightSkill(853 ,20);  -- Mê Tung Huyễn Ảnh 
            --me.AddFightSkill(854 ,20);  -- Kỹ năng cấp 120
        elseif me.nFaction == 10 then    --Côn Lôn 
            --Đao Côn 
            me.AddFightSkill(175 ,20);  -- Hô Phong Pháp 
            me.AddFightSkill(176 ,20);  -- Côn Lôn Đao Pháp 
            me.AddFightSkill(179 ,20);  -- Huyền Thiên Vô Cực 
            me.AddFightSkill(177 ,20);  -- Thanh Phong Phù 
            me.AddFightSkill(178 ,20);  -- Cuồng Phong Sậu Điện 
            me.AddFightSkill(697 ,20);  -- Khai Thần Thuật 
            me.AddFightSkill(180 ,20);  -- Nhất Khí Tam Thanh 
            me.AddFightSkill(183 ,20);  -- Thiên Thanh Địa Trọc 
            me.AddFightSkill(181 ,20);  -- Ngạo Tuyết Tiếu Phong 
            me.AddFightSkill(698 ,20);  -- Sương Ngạo Côn Lôn 
            me.AddFightSkill(855 ,20);  -- Vô Nhân Vô Ngã 
            --me.AddFightSkill(856 ,20);  -- Kỹ năng cấp 120 
            --Kiếm Côn 
            me.AddFightSkill(188 ,20);  -- Cuồng Lôi Chấn Địa 
            me.AddFightSkill(189 ,20);  -- Côn Lôn Kiếm Pháp 
            me.AddFightSkill(179 ,20);  -- Huyền Thiên Vô Cực 
            me.AddFightSkill(177 ,20);  -- Thanh Phong Phù 
            me.AddFightSkill(190 ,20);  -- Thiên Tế Tấn Lôi 
            me.AddFightSkill(699 ,20);  -- Túy Tiên Thác Cốt 
            me.AddFightSkill(191 ,20);  -- Đạo Cốt Tiên Phong 
            me.AddFightSkill(193 ,20);  -- Ngũ Lôi Chánh Pháp 
            me.AddFightSkill(192 ,20);  -- Lôi Động Cửu Thiên 
            me.AddFightSkill(767 ,20);  -- Hỗn Nguyên Càn Khôn 
            me.AddFightSkill(857 ,20);  -- Lôi Đình Quyết 
            --me.AddFightSkill(858 ,20);  -- Kỹ năng cấp 120 
        elseif me.nFaction == 11 then    --Minh Giáo 
            --Chùy Minh 
            me.AddFightSkill(194 ,20);  -- Khai Thiên Thức 
            me.AddFightSkill(196 ,20);  -- Minh Giáo Chùy Pháp 
            me.AddFightSkill(199 ,20);  -- Khốn Hổ Vân Tiếu 
            me.AddFightSkill(768 ,20);  -- Huyền Dương Công 
            me.AddFightSkill(198 ,20);  -- Phách Địa Thế 
            me.AddFightSkill(201 ,20);  -- Kim Qua Thiết Mã 
            me.AddFightSkill(197 ,20);  -- Ngự Mã Thuật 
            me.AddFightSkill(204 ,20);  -- Trấn Ngục Phá Thiên Kình 
            me.AddFightSkill(202 ,20);  -- Long Thôn Thức 
            me.AddFightSkill(769 ,20);  -- Không Tuyệt Tâm Pháp 
            me.AddFightSkill(859 ,20);  -- Cửu Hi Hỗn Dương 
            --me.AddFightSkill(860 ,20);  -- Kỹ năng cấp 120 
            --Kiếm Minh 
            me.AddFightSkill(205 ,20);  -- Thánh Hỏa Phần Tâm 
            me.AddFightSkill(206 ,20);  -- Minh Giáo Kiếm Pháp 
            me.AddFightSkill(207 ,20);  -- Di Khí Phiêu Tung 
            me.AddFightSkill(209 ,20);  -- Phiêu Dực Thân Pháp 
            me.AddFightSkill(208 ,20);  -- Vạn Vật Câu Phần 
            me.AddFightSkill(210 ,20);  -- Càn Khôn Đại Na Di 
            me.AddFightSkill(770 ,20);  -- Thâu Thiên Hoán Nhật 
            me.AddFightSkill(212 ,20);  -- Ly Hỏa Đại Pháp 
            me.AddFightSkill(211 ,20);  -- Thánh Hỏa Liêu Nguyên 
            me.AddFightSkill(772 ,20);  -- Thánh Hỏa Thần Công 
            me.AddFightSkill(861 ,20);  -- Thánh Hỏa Lệnh Pháp 
            --me.AddFightSkill(862 ,20);  -- Kỹ năng cấp 120 
        elseif me.nFaction == 12 then    --Đoàn Thị 
            --Chỉ Đoàn 
            me.AddFightSkill(213 ,20);  -- Thần Chỉ Điểm Huyệt 
            me.AddFightSkill(215 ,20);  -- Đoàn Thị Chỉ Pháp 
            me.AddFightSkill(216 ,20);  -- Nhất Dương Chỉ 
            me.AddFightSkill(219 ,20);  -- Lăng Ba Vi Bộ 
            me.AddFightSkill(217 ,20);  -- Nhất Chỉ Càn Khôn 
            me.AddFightSkill(773 ,20);  -- Từ Bi Quyết 
            me.AddFightSkill(220 ,20);  -- Thí Nguyên Quyết 
            me.AddFightSkill(225 ,20);  -- Kim Ngọc Chỉ Pháp 
            me.AddFightSkill(223 ,20);  -- Càn Dương Thần Chỉ 
            me.AddFightSkill(775 ,20);  -- Càn Thiên Chỉ Pháp 
            me.AddFightSkill(863 ,20);  -- Diệu Đề Chỉ 
            --me.AddFightSkill(864 ,20);  -- Kỹ năng cấp 120 
            --Khí Đoàn 
            me.AddFightSkill(226 ,20);  -- Phong Vân Biến Huyễn 
            me.AddFightSkill(227 ,20);  -- Đoàn Thị Tâm Pháp 
            me.AddFightSkill(228 ,20);  -- Bắc Minh Thần Công 
            me.AddFightSkill(230 ,20);  -- Thiên Nam Bộ Pháp 
            me.AddFightSkill(229 ,20);  -- Kim Ngọc Mãn Đường 
            me.AddFightSkill(776 ,20);  -- Lục Kiếm Tề Phát 
            me.AddFightSkill(231 ,20);  -- Khô Vinh Thiền Công 
            me.AddFightSkill(233 ,20);  -- Thiên Long Thần Công 
            me.AddFightSkill(232 ,20);  -- Lục Mạch Thần Kiếm 
            me.AddFightSkill(778 ,20);  -- Đoàn Gia Khí Kiếm 
            me.AddFightSkill(865 ,20);  -- Kinh Thiên Nhất Kiếm 
            --me.AddFightSkill(1662 ,20);  --Ám Hương 
            --me.AddFightSkill(866 ,20);  --Sơ Ảnh 
        end 
    end 
end

function tbLiGuan:DiemTiemNang()
	me.AddPotential(1000)
end

function tbLiGuan:DiemKyNang()
	me.AddFightSkillPoint(20)
end

function tbLiGuan:XoaDiemTiemNang()
	me.AddPotential(-1*1000)
end

function tbLiGuan:XoaDiemKyNang()
	me.AddFightSkillPoint(-1*79)
end

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

function tbLiGuan:MatTichCao()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:lsMatTichTrung()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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

function tbLiGuan:lsMatTichCao()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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
	table.insert(tbOpt, {"Ta chỉ ghé ngang qua"});
	Dialog:Say(szMsg, tbOpt);
end

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

function tbLiGuan:VoLamTayTuy()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = { 		
		{"Võ Lâm Mật Tịch",self.VoLamMatTich,self};
		{"Tẩy Tủy Kinh",self.TayTuyKinh,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:VoLamMatTich()
	for i=1,5 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,191,1); --Võ Lâm Mật Tịch Sơ
		else
			break
		end
	end
	for i=1,5 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,191,2); --Võ Lâm Mật Tịch Trung
		else
			break
		end
	end
end

function tbLiGuan:TayTuyKinh()
	for i=1,5 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,192,1); --Tẩy Tủy Kinh Sơ
		else
			break
		end
	end
	for i=1,5 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,192,2); --Tẩy Tủy Kinh Trung
		else
			break
		end
	end
end

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

function tbLiGuan:lsDiemKinhNghiem()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = { 		
		{"Nhận Kinh Nghiệm Cấp 110<color>",self.LenLevel110,self};
		{"Nhận Kinh Nghiệm Cấp 130<color>",self.LenLevel130,self};
		{"Nhận Kinh Nghiệm Cấp 140<color>",self.LenLevel140,self};
		{"Nhận Kinh Nghiệm Cấp 150<color>",self.LenLevel150,self};
		{"Nhận <color=yellow>level 160<color>",self.level180,self}, 
		{"Nhận 500 Triệu Điểm Kinh Nghiệm",self.DiemKinhNghiem,self};
		{"Bánh Ít Thịt Heo (10c)",self.BanhItThitHeo,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
	{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:LenLevel110()
	me.AddLevel(110 - me.nLevel);
end

function tbLiGuan:LenLevel130()
	me.AddLevel(130 - me.nLevel);
end

function tbLiGuan:LenLevel140()
	me.AddLevel(140 - me.nLevel);
end

function tbLiGuan:LenLevel150()
	me.AddLevel(150 - me.nLevel);
end	

function tbLiGuan:DiemKinhNghiem()
	me.AddExp(500000000);
end

function tbLiGuan:BanhItThitHeo()
	for i=1,20 do
		if me.CountFreeBagCell() > 0 then
			me.AddItem(18,1,326,1); --Bánh ít thịt heo (điểm KN)
		else
			break
		end
	end
end

function tbLiGuan:lsMatNa()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Mặt Nạ Full",self.MatNaFull,self};
		{"Mặt Nạ Hàng Long <color=red>(Ko Thể Bán)<color>",self.MatNaHangLong,self};
		{"Mặt Nạ Quân Lâm Miện (có thể stop sv)",self.QuanLamMien,self};
		{"Mặt Nạ Tuyệt Thế Quán",self.TuyetTheQuan,self};
		{"Tần Thủy Hoàng <color=red>(Ko Thể Bán)<color>",self.MatNaTanThuyHoang,self};
		{"Lãnh Sương Nhiên <color=red>(Ko Thể Bán)<color>",self.MatNaLanhSuongNhien,self};
		{"Kim Mao Sư Vương",self.MatNaKimMaoSuVuong,self};
		{"Tây Độc Âu Dương Phong",self.MatNaTayDocAuDuongPhong,self};
		{"Cốc Tiên Tiên <color=red>(Ko Thể Bán)<color>",self.MatNaCocTienTien,self};
		{">>>",self.lsMatNa1,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:MatNaFull()
	me.AddItem(1,13,1,1); --Bé trai vui vẻ
	me.AddItem(1,13,2,1); --Bé gái vui vẻ
	me.AddItem(1,13,146,1);
end

function tbLiGuan:lsMatNa1()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"Tân Niên Hiệp Nữ <color=red>(Ko Thể Bán)<color>",self.MatNaTanNienHiepNu,self};
		{"Doãn Tiêu Vũ <color=red>(Ko Thể Bán)<color>",self.MatNaDoanTieuVu,self};
		{"Ngưu Thúy Hoa <color=red>(Ko Thể Bán)<color>",self.MatNaNguuThuyHoa,self};
		{"Áo Dài Khăn Đống (Nam)",self.MatNaAoDaiKhanDongNam,self};
		{"Wodekapu",self.MatNaWodekapu,self};
		{"Lam Nhan",self.MatNaLamNhan,self};
		{"Rùa Thần",self.MatNaRuaThan,self};
		{"Mãnh Hổ",self.MatNaManhHo,self};
		{"<<<",self.lsMatNa,self};
		{"<color=pink>Trở Lại Trước<color>",self.NangCao,self};
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

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

function tbLiGuan:QuanLamMien()
	me.AddItem(1,13,67,10); --Quân Lâm Miện
end

function tbLiGuan:TuyetTheQuan()
	me.AddItem(1,13,66,10); --Tuyệt Thế Quán
end

function tbLiGuan:lsTangToc()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
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
	me.AddFightSkill(68,40); --Đường môn - Tâm ma
	me.AddFightSkill(75,40); --Đường môn - Tâm phách
	--me.AddFightSkill(150,40); --Thiên nhẫn - Thiên ma giải thể
	--me.AddFightSkill(158,40); --Thiên nhẫn - Xí không ma diệm
	me.AddFightSkill(183,40); --Côn lôn - Thiên thanh địa trọc
	me.AddFightSkill(193,40); --Côn lôn - Ngũ lôi chánh pháp
	me.AddFightSkill(204,40); --Minh giáo - Trấn ngục phá thiên kình
	me.AddFightSkill(212,40); --Minh giáo - Ly hỏa đại pháp
	--me.AddFightSkill(28,20); --Thiếu lâm - Hỗn nguyên nhất khí
	--me.AddFightSkill(37,20); --Thiếu lâm - Đạt ma vũ kinh
	--me.AddFightSkill(85,20); --Ngũ độc - Ngũ độc kỳ kinh
	--me.AddFightSkill(95,20); --Ngũ độc - Bách cổ độc kinh
	--me.AddFightSkill(105,20); --Nga my - Phật pháp vô biên
	--me.AddFightSkill(119,20); --Thúy yên - Băng cốt tuyết tâm
	--me.AddFightSkill(127,20); --Thúy yên - Băng cơ ngọc cốt
	--me.AddFightSkill(136,20); --Cái bang - Tiềm long tại uyên
	--me.AddFightSkill(142,20); --Cái bang - Bôn lưu đáo hải
	--me.AddFightSkill(166,20); --Võ đang - Thái cực vô ý
	--me.AddFightSkill(174,20); --Võ đang - Kiếm khí tung hoành
	--me.AddFightSkill(233,20); --Đoàn thị - Thiên long thần công
	--me.AddFightSkill(837,20); --Nga my - Kiểm ảnh phật quang
end

function tbLiGuan:HuyTangTocDanh()
	me.DelFightSkill(68);
	me.DelFightSkill(75);
	--me.DelFightSkill(150);
	--me.DelFightSkill(158);
	me.DelFightSkill(183);
	me.DelFightSkill(193);
	me.DelFightSkill(204);
	me.DelFightSkill(212);
	--me.DelFightSkill(28);
	--me.DelFightSkill(37);
	--me.DelFightSkill(85);
	--me.DelFightSkill(95);
	--me.DelFightSkill(105);
	--me.DelFightSkill(119);
	--me.DelFightSkill(127);
	--me.DelFightSkill(136);
	--me.DelFightSkill(142);
	--me.DelFightSkill(166);
	--me.DelFightSkill(174);
	--me.DelFightSkill(233);
	--me.DelFightSkill(837);
end

function tbLiGuan:About()
	local szMsg = "<pic=28>Game Master Cards LSB v1 \n Chào Admin <color=red>"..me.szName.. "<color> <pic=98> \n Http://ThuyBatLuongSon.TK";
	local tbOpt = {
		{"<color=orange>Version: 1.0<color>"},
		{"<color=orange>Yahoo: NguyenHoPhuc87<color>"},
		{"<color=orange>Email: NguyenHoPhuc87@Gmail.com<color>"},
		{"Ta Chỉ Xem Qua Thôi..."},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbLiGuan:TrangBiBaVuong()
	local nSeries = me.nSeries;
	local szMsg = "Hãy chọn lấy bộ trang bị mà bạn nhé ^^ ";
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

function tbLiGuan:TrangBiSatThan()
	local nSeries = me.nSeries;
	local szMsg = "Hãy chọn lấy bộ trang bị 18x <color=yellow>Sát Thần<color> mà bạn cần nhé ^^";
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

function tbLiGuan:VuKhiThieuLam()
	me.AddItem(2,1,1545,10,1);
	me.AddItem(2,1,1533,10,1);
end

function tbLiGuan:VuKhiThienVuong()
	me.AddItem(2,1,1505,10,1);
	me.AddItem(2,1,1512,10,1);
end

function tbLiGuan:VuKhiDuongMon()
	me.AddItem(2,1,1576,10,2);
	me.AddItem(2,1,1570,10,2);
end

function tbLiGuan:VuKhiNguDoc()
	me.AddItem(2,1,1524,10,2);
	me.AddItem(2,1,1546,10,2);
end

function tbLiGuan:VuKhiMinhGiao()
	me.AddItem(2,1,1564,10,2);
	me.AddItem(2,1,1513,10,2);
end

function tbLiGuan:VuKhiNgaMi()
	me.AddItem(2,1,1526,10,3);
	me.AddItem(2,1,1560,10,3);
end

function tbLiGuan:VuKhiThuyYen()
	me.AddItem(2,1,1560,10,3);
	me.AddItem(2,1,1547,10,3);
end

function tbLiGuan:VuKhiDoanThi()
	me.AddItem(2,1,1525,10,3);
	me.AddItem(2,1,1560,10,3);
end

function tbLiGuan:VuKhiCaiBang()
	me.AddItem(2,1,1527,10,4);
	me.AddItem(2,1,1534,10,4);
end

function tbLiGuan:VuKhiThienNhan()
	me.AddItem(2,1,1501,10,4);
	me.AddItem(2,1,1548,10,4);
end

function tbLiGuan:VuKhiConLon()
	me.AddItem(2,1,1549,10,5);
	me.AddItem(2,1,1563,10,5);
end

function tbLiGuan:VuKhiVoDang()
	me.AddItem(2,1,1561,10,5);
	me.AddItem(2,1,1563,10,5);
end


function tbLiGuan:OutputAllPlayer()
	me.Msg(" ", "Danh sách người chơi hiện tại");
	for nPlayerId, tbInfo in pairs(self.tbRemoteList) do
		local szMsg	= string.format("%d cấp %s %s", tbInfo[2],
			Player:GetFactionRouteName(tbInfo[3], tbInfo[4]), GetMapNameFormId(tbInfo[5]));
		me.Msg(szMsg, tbInfo[1]);
	end
end

function tbLiGuan:ComeHereAll()
	local nMapId, nMapX, nMapY = me.GetWorldPos();
	me.Msg("Đã triệu tập !");
	self:RemoteCall_ApplyAll("me.NewWorld", nMapId, nMapX, nMapY);
end

function tbLiGuan:ListAllPlayer()
	local tbOpt	= {};
	for nPlayerId, tbInfo in pairs(self.tbRemoteList) do
		tbOpt[#tbOpt+1]	= {"<color=green>"..tbInfo[1], self.SelectPlayer, self, nPlayerId, tbInfo[1]};
	end
	tbOpt[#tbOpt + 1]	= {"<color=gray>Kết thúc đối thoại"};
	Dialog:Say("Ngươi muốn gì？<pic=58>", tbOpt);
end

function tbLiGuan:SelectPlayer(nPlayerId, szPlayerName)
	-- 插入最近操作玩家
	local tbPlayerData			= me.GetTempTable("GM");
	local tbRecentPlayerList	= tbPlayerData.tbRecentPlayerList or {};
	tbPlayerData.tbRecentPlayerList	= tbRecentPlayerList;
	for nIndex, nRecentPlayerId in ipairs(tbRecentPlayerList) do
		if (nRecentPlayerId == nPlayerId) then
			table.remove(tbRecentPlayerList, nIndex);
			break;
		end
	end
	if (#tbRecentPlayerList >= self.MAX_RECENTPLAYER) then
		table.remove(tbRecentPlayerList);
	end
	table.insert(tbRecentPlayerList, 1, nPlayerId);
	
	local tbInfo	= self.tbRemoteList[nPlayerId];
	if (not tbInfo) then
		me.Msg(string.format("[%s]Biến mất không 1 dấu vết...", szPlayerName));
		return;
	end
	
	local szMsg	= string.format("Tên： %s\nCấp： %d\nLộ tuyến：%s\nVị trí：%s",
		tbInfo[1], tbInfo[2], Player:GetFactionRouteName(tbInfo[3], tbInfo[4]),
		GetMapNameFormId(tbInfo[5]));
	
	Dialog:Say(szMsg,
		{"Kéo hắn đến đây", self.CallSomeoneHere, self, nPlayerId},
		{"Đưa ta đi", self.RemoteCall_ApplyOne, self, nPlayerId, "GM.tbPlayer:CallSomeoneHere", me.nId},
		{"Kick hắn rớt mạng", self.RemoteCall_ApplyOne, self, nPlayerId, "me.KickOut"},
		{"<color=gray>Kết thúc"}
	);
end

function tbLiGuan:CallSomeoneHere(nPlayerId)
	local nMapId, nMapX, nMapY = me.GetWorldPos();
	self:RemoteCall_ApplyOne(nPlayerId, "me.NewWorld", nMapId, nMapX, nMapY);
end


--== 全服玩家列表 ==--
-- 将本服务器玩家列表发送出去
function tbLiGuan:RemoteList_Fetch(nToPlayerId)
	local tbLocalPlayer = KPlayer.GetAllPlayer();
	local tbRemoteList	= {};
	for _, pPlayer in pairs(tbLocalPlayer) do
		tbRemoteList[pPlayer.nId]	= {
			pPlayer.szName,
			pPlayer.nLevel,
			pPlayer.nFaction,
			pPlayer.nRouteId,
			pPlayer.nMapId,
		};
	end
	GlobalExcute({"GM.tbPlayer:RemoteList_Receive", nToPlayerId, tbRemoteList})
end
-- 收到传回的玩家列表
function tbLiGuan:RemoteList_Receive(nToPlayerId, tbRemoteList)
	local pPlayer	= KPlayer.GetPlayerObjById(nToPlayerId);
	if (not pPlayer) then
		return;
	end
	for nPlayerId, tbInfo in pairs(tbRemoteList) do
		self.tbRemoteList[nPlayerId]	= tbInfo;
	end
end


--== 全服/单一玩家执行 ==--
-- 申请为全服玩家执行
function tbLiGuan:RemoteCall_ApplyAll(...)
	GlobalExcute({"GM.tbPlayer:RemoteCall_DoAll", arg})
end
-- 为本服务器玩家执行
function tbLiGuan:RemoteCall_DoAll(tbCallBack)
	local tbLocalPlayer = KPlayer.GetAllPlayer();
	for _, pPlayer in pairs(tbLocalPlayer) do
		pPlayer.Call(unpack(tbCallBack));
	end
end
-- 申请为单一玩家执行
function tbLiGuan:RemoteCall_ApplyOne(nToPlayerId, ...)
	GlobalExcute({"GM.tbPlayer:RemoteCall_DoOne", nToPlayerId, arg})
end
-- 为本服务器玩家执行
function tbLiGuan:RemoteCall_DoOne(nToPlayerId, tbCallBack)
	local pPlayer	= KPlayer.GetPlayerObjById(nToPlayerId);
	if (pPlayer) then
		pPlayer.Call(unpack(tbCallBack));
	end
end
