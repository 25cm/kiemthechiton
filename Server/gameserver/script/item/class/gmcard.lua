-- GM专用卡
local tbGMCard = Item:GetClass("gmcard");
tbGMCard.MAX_RECENTPLAYER = 15;

function tbGMCard:OnUse()
DoScript("\\script\\item\\class\\gmcard.lua");
 local nIsHide = GM.tbGMRole:IsHide();
 local tbOpt = {
 {"Chức năng Admin", self.OnDialog_Admin, self},
 {"<color=blue>Chức năng GM<color>", self.OnDialog_GM, self},
{"Cường Hóa +16", self.nCuongHoa, self};
 --{"<color=orange>Long Hồn Tướng Quân<color>", self.LongHonRuongQuan, self},
 --{"<color=orange>Test Thú Nuôi<color>", self.TestThuNuoi, self},
  --{"<color=red>Tẩy Tủy<color>", self.OnDialog_taytuy, self},
 	{"Nhận <color=yellow>Vũ Khí HKMP +16<color>",self.NhanVuKhiThanThanh,self};
 --{"<color=orange>Event Hỏa Kỳ Lân<color>",self.EventHoaKyLan,self};
 --{"<color=orange>Event Hái Hoa<color>",self.EventHaiHoa,self};
 --{"<color=orange>Xua Đuổi Thú Dữ<color>",self.XuaDuoiThuDu,self};
 --{"<color=orange>Gọi Xua Đuổi Thú Dữ<color>",self.XuaDuoiThuDu000,self};
-- {"<color=orange>Hạt Giống Hồng Hoa<color>",self.TraoThuong,self};
--{"<color=yellow>He Thong Event Moi<color>", self.EventMoi, self},
{"Find Post", self.TestNPC, self},
{"<color=orange>Cường Hóa Ấn<color>",self.CuongHoaAn,self};
  --{"Goi NPC", self.GoiNPC, self},
  {"Đạo cụ tạm thời", self.Daocutamthoi, self},
  {"Tiêu hủy đạo cụ",  Dialog.Gift, Dialog, "Task.DestroyItem.tbGiveForm"},
  
 
  -- {"Tẩy Tủy", self.OnDialog_taytuy, self},
  {"Di chuyển", self.DichuyenOnDialog, self},
  {"Reload Script", self.ReloadScript, self},
  {"Ta chưa cần"},
 };
  Dialog:Say(" Các bạn vất vã rồi!<pic=28>\n\n   Vì nhân dân phục vụ<pic=98><pic=98>", tbOpt);
  return 0;
end;
function tbGMCard:nCuongHoa()
	local szMsg = "Đặt vào Item Cần Cường Hóa";
	Dialog:OpenGift(szMsg, nil, {self.CuongHoa, self, 1});
end

function tbGMCard:CuongHoa(nValue, tbItemObj)
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

function tbGMCard:LongHonRuongQuan()
 local tbTuongQuanLH = Npc:GetClass("longhontuongquan");
 tbTuongQuanLH:OnDialog()
 local nAddLevel = 130 - me.nLevel ;
 me.AddLevel(nAddLevel)
		 me.ResetFightSkillPoint();
		 me.UnAssignPotential();

		 me.KickOut();
		me.AddItem(18,1,547,3)
		me.DelTitle(17,1,10,1)
end
function tbGMCard:TestThuNuoi()
 me.AddStackItem(18,1,25293,1,nil,1)
 me.AddStackItem(18,1,324,1,nil,10)
 me.OpenShop(200,1)
 local nMapId, nPosX, nPosY = me.GetWorldPos();
 KNpc.Add2(3673, 150, 1, nMapId, nPosX, nPosY).szName="Tượng DepRucRo"
 KNpc.Add2(3670, 150, 1, nMapId, nPosX, nPosY).szName="Tượng LTYếnThanh"
 me.AddItem(5,21,1,4)
 ClearMapNpcWithName(1, "Tượng LTYếnThanh");
me.AddStackItem(18,1,25299,1,nil,500)
end
function tbGMCard:OnDialog_taytuy()
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
function tbGMCard:OnResetDian(pPlayer, nType)
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
function tbGMCard:OnChangeGenreFaction(pPlayer)
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
function tbGMCard:OnChangeGenreFactionSelected(pPlayer, nFactionId)
 
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
function tbGMCard:RungCayHaiQua()
		    local msg = "<color=yellow><color=pink>Hỏa Kỳ Lân<color> xuất hiện 222/222 Tàn Tích Cung A Phòng<color>";
    GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	 KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	 KDialog.MsgToGlobal(msg);
		   local msg = "<color=yellow><color=pink>Diễm Cô Nương<color> đi mất rồi thật tiếc cho ai chưa nhận được vật phẩm<color>";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
		    local msg = "<color=yellow><color=pink>Diễm Cô Nương<color> xuất hiện<color>";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	 KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	 KDialog.MsgToGlobal(msg);
	ClearMapNpcWithName(132, "Diễm Cô Nương");
	 ClearMapNpcWithName(132, "Hỏa Kỳ Lân");
	 KNpc.Add2(9952, 255, 1,132, 1772,3561);
	end
function tbGMCard:TestNPC()
		local nMapId, nPosX, nPosY = me.GetWorldPos();
	local sms = string.format(" Tọa độ đang đứng là:<color=yellow> %d <color>-<color=green> %d <color>",nPosX*32,  nPosY*32);
	Dialog:Say(sms);
 --me.AddItem(5,21,1,2)
 KNpc.Add2(3670, 150, 1,25, 1628,3133).szName = "Tượng "..me.szName.."";
 ClearMapNpcWithName(25, "Tượng MasterCuuLOng");
end
function tbGMCard:EventHoaKyLan()
local szMsg = "<color=cyan>"..me.szName.."<color>"; 
local tbOpt = { 
--{"Gọi <color=yellow>Hỏa Kỳ Lân<color>",self.GoiHKL1,self};
--{"Gọi <color=yellow>Diễm Cô Nương<color>",self.GoiDiemNuong1,self};
}; 
Dialog:Say(szMsg, tbOpt);
 --me.AddItem(5,19,1,4)
 --me.AddItem(5,20,1,4)
 --me.AddItem(5,21,1,4)
 --me.AddItem(5,22,1,4)
 --me.AddItem(5,23,1,4)
end
function tbGMCard:GoiHKL1()
 KNpc.Add2(9951, 150, 1,132, 1782,3561);
		    --local msg = "<color=yellow>Hỏa Kỳ Lân<color> xuất hiện Tàn Tích Cung A Phòng<color>";
  --GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	-- KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	-- KDialog.MsgToGlobal(msg);
	--------------
		--   local msg = "<color=yellow>Boss đã chết . Diễm Nương xuất hiện<color>";
    --GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	--KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	--KDialog.MsgToGlobal(msg);
----------------
		--  local msg = "<color=yellow>Boss đã chết . Diễm Nương xuất hiện<color>";
    --GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	 --KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	--KDialog.MsgToGlobal(msg);
	--KNpc.Add2(9952, 255, 1,132, 1783,3552);
	--ClearMapNpcWithName(132, "Hỏa Kỳ Lân");
end
function tbGMCard:GoiDiemNuong1()
--KNpc.Add2(9952, 255, 1,28, 1426,3252);
end
function tbGMCard:EventHaiHoa()
local szMsg = "<color=cyan>"..me.szName.."<color>"; 
local tbOpt = { 
{"Gọi 100 Hoa Hồng Đỏ <color=yellow>10h<color><color>",self.HoaHongDo10,self};
{"Gọi 100 Hoa Hồng Phấn <color=yellow>10h15<color><color>",self.HoaHongDo1015,self};
{"Gọi 100 Hoa Hồng Đỏ <color=yellow>10h30<color><color>",self.HoaHongDo1030,self};
{"Gọi 100 Hoa Hồng Phấn <color=yellow>10h45<color><color>",self.HoaHongDo1045,self};
{"Gọi 100 Hoa Hồng Đỏ <color=yellow>11h<color><color>",self.HoaHongDo11,self};
--------------
{"Gọi 100 Hoa Hồng Đỏ <color=yellow>20h<color><color>",self.HoaHongDo20,self};
{"Gọi 100 Hoa Hồng Phấn <color=yellow>20h15<color><color>",self.HoaHongDo2015,self};
{"Gọi 100 Hoa Hồng Đỏ <color=yellow>20h30<color><color>",self.HoaHongDo2030,self};
{"Gọi 100 Hoa Hồng Phấn <color=yellow>20h45<color><color>",self.HoaHongDo2045,self};
{"Gọi 100 Hoa Hồng Đỏ <color=yellow>21h<color><color>",self.HoaHongDo21,self};
}; 
Dialog:Say(szMsg, tbOpt);
end
function tbGMCard:HoaHongDo2045()
KNpc.Add2(9933, 255, 1,28, 1426,3252);
KNpc.Add2(9933, 255, 1,28, 1420,3257);
KNpc.Add2(9933, 255, 1,28, 1417,3249);
KNpc.Add2(9933, 255, 1,28, 1432,3254);
KNpc.Add2(9933, 255, 1,28, 1426,3252);
KNpc.Add2(9933, 255, 1,28, 1426,3261);
KNpc.Add2(9933, 255, 1,28, 1419,3268);
KNpc.Add2(9933, 255, 1,28, 1425,3273);
KNpc.Add2(9933, 255, 1,28, 1426,3275);
KNpc.Add2(9933, 255, 1,28, 1437,3271);
KNpc.Add2(9933, 255, 1,28, 1436,3298);
KNpc.Add2(9933, 255, 1,28, 1443,3293);
KNpc.Add2(9933, 255, 1,28, 1446,3303);
KNpc.Add2(9933, 255, 1,28, 1453,3300);
KNpc.Add2(9933, 255, 1,28, 1460,3299);
KNpc.Add2(9933, 255, 1,28, 1426,3252);
KNpc.Add2(9933, 255, 1,28, 1463,3302);
KNpc.Add2(9933, 255, 1,28, 1464,3309);
KNpc.Add2(9933, 255, 1,28, 1457,3212);
KNpc.Add2(9933, 255, 1,28, 1463,3316);
KNpc.Add2(9933, 255, 1,28, 1470,3319);
KNpc.Add2(9933, 255, 1,28, 1456,3320);
KNpc.Add2(9933, 255, 1,28, 1449,3314);
KNpc.Add2(9933, 255, 1,28, 1479,3326);
KNpc.Add2(9933, 255, 1,28, 1471,3331);
KNpc.Add2(9933, 255, 1,28, 1462,3336);
KNpc.Add2(9933, 255, 1,28, 1483,3336);
KNpc.Add2(9933, 255, 1,28, 1490,3333);
KNpc.Add2(9933, 255, 1,28, 1468,3284);
KNpc.Add2(9933, 255, 1,28, 1472,3279);
KNpc.Add2(9933, 255, 1,28, 1463,3274);
KNpc.Add2(9933, 255, 1,28, 1460,3262);
KNpc.Add2(9933, 255, 1,28, 1452,3267);
KNpc.Add2(9933, 255, 1,28, 1465,3294);
KNpc.Add2(9933, 255, 1,28, 1469,3288);
KNpc.Add2(9933, 255, 1,28, 1476,3291);
KNpc.Add2(9933, 255, 1,28, 1484,3284);
KNpc.Add2(9933, 255, 1,28, 1491,3294);
KNpc.Add2(9933, 255, 1,28, 1426,3252);
KNpc.Add2(9933, 255, 1,28, 1487,3299);
KNpc.Add2(9933, 255, 1,28, 1496,3296);
KNpc.Add2(9933, 255, 1,28, 1497,3290);
KNpc.Add2(9933, 255, 1,28, 1504,3296);
KNpc.Add2(9933, 255, 1,28, 1509,3285);
KNpc.Add2(9933, 255, 1,28, 1518,3286);
KNpc.Add2(9933, 255, 1,28, 1522,3276);
KNpc.Add2(9933, 255, 1,28, 1426,3252);
KNpc.Add2(9933, 255, 1,28, 1516,3274);
KNpc.Add2(9933, 255, 1,28, 1524,3274);
KNpc.Add2(9933, 255, 1,28, 1524,3261);
KNpc.Add2(9933, 255, 1,28, 1518,3259);
KNpc.Add2(9933, 255, 1,28, 1533,3265);
KNpc.Add2(9933, 255, 1,28, 1537,3275);
KNpc.Add2(9933, 255, 1,28, 1536,3283);
KNpc.Add2(9933, 255, 1,28, 1540,3284);
KNpc.Add2(9933, 255, 1,28, 1547,3276);
KNpc.Add2(9933, 255, 1,28, 1553,3272);
KNpc.Add2(9933, 255, 1,28, 1549,3263);
KNpc.Add2(9933, 255, 1,28, 1552,3254);
KNpc.Add2(9933, 255, 1,28, 1559,3250);
KNpc.Add2(9933, 255, 1,28, 1551,3249);
KNpc.Add2(9933, 255, 1,28, 1547,3237);
KNpc.Add2(9933, 255, 1,28, 1541,3228);
KNpc.Add2(9933, 255, 1,28, 1533,3228);
KNpc.Add2(9933, 255, 1,28, 1563,3248);
KNpc.Add2(9933, 255, 1,28, 1570,3244);
KNpc.Add2(9933, 255, 1,28, 1572,3250);
KNpc.Add2(9933, 255, 1,28, 1579,3243);
KNpc.Add2(9933, 255, 1,28, 1575,3225);
KNpc.Add2(9933, 255, 1,28, 1586,3244);
KNpc.Add2(9933, 255, 1,28, 1590,3227);
KNpc.Add2(9933, 255, 1,28, 1598,3222);
KNpc.Add2(9933, 255, 1,28, 1604,3221);
KNpc.Add2(9933, 255, 1,28, 1596,3257);
KNpc.Add2(9933, 255, 1,28, 1595,3268);
KNpc.Add2(9933, 255, 1,28, 1599,3268);
KNpc.Add2(9933, 255, 1,28, 1608,3268);
KNpc.Add2(9933, 255, 1,28, 1607,3275);
KNpc.Add2(9933, 255, 1,28, 1615,3278);
KNpc.Add2(9933, 255, 1,28, 1611,3284);
KNpc.Add2(9933, 255, 1,28, 1607,3292);
KNpc.Add2(9933, 255, 1,28, 1600,3299);
KNpc.Add2(9933, 255, 1,28, 1593,3302);
KNpc.Add2(9933, 255, 1,28, 1587,3291);
KNpc.Add2(9933, 255, 1,28, 1578,3293);
KNpc.Add2(9933, 255, 1,28, 1578,3283);
KNpc.Add2(9933, 255, 1,28, 1566,3281);
KNpc.Add2(9933, 255, 1,28, 1611,3284);
KNpc.Add2(9933, 255, 1,28, 1596,3205);
KNpc.Add2(9933, 255, 1,28, 1594,3197);
KNpc.Add2(9933, 255, 1,28, 1587,3195);
KNpc.Add2(9933, 255, 1,28, 1599,3192);
KNpc.Add2(9933, 255, 1,28, 1609,3200);
KNpc.Add2(9933, 255, 1,28, 1614,3202);
KNpc.Add2(9933, 255, 1,28, 1621,3200);
KNpc.Add2(9933, 255, 1,28, 1629,3201);
KNpc.Add2(9933, 255, 1,28, 1638,3207);
KNpc.Add2(9933, 255, 1,28, 1639,3220);
KNpc.Add2(9933, 255, 1,28, 1650,3227);
KNpc.Add2(9933, 255, 1,28, 1652,3241);
KNpc.Add2(9933, 255, 1,28, 1660,3232);
		   local msg = "<color=yellow><color=red>Hoa Hồng Đỏ<color> đang mọc lên rực rỡ ở Đại Lý Phủ mọi người mau tới hái đem về tặng cho Nam Cung Tử Tuyết<color>";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
	end
function tbGMCard:HoaHongDo2015()
KNpc.Add2(9933, 255, 1,28, 1426,3252);
KNpc.Add2(9933, 255, 1,28, 1420,3257);
KNpc.Add2(9933, 255, 1,28, 1417,3249);
KNpc.Add2(9933, 255, 1,28, 1432,3254);
KNpc.Add2(9933, 255, 1,28, 1426,3252);
KNpc.Add2(9933, 255, 1,28, 1426,3261);
KNpc.Add2(9933, 255, 1,28, 1419,3268);
KNpc.Add2(9933, 255, 1,28, 1425,3273);
KNpc.Add2(9933, 255, 1,28, 1426,3275);
KNpc.Add2(9933, 255, 1,28, 1437,3271);
KNpc.Add2(9933, 255, 1,28, 1436,3298);
KNpc.Add2(9933, 255, 1,28, 1443,3293);
KNpc.Add2(9933, 255, 1,28, 1446,3303);
KNpc.Add2(9933, 255, 1,28, 1453,3300);
KNpc.Add2(9933, 255, 1,28, 1460,3299);
KNpc.Add2(9933, 255, 1,28, 1426,3252);
KNpc.Add2(9933, 255, 1,28, 1463,3302);
KNpc.Add2(9933, 255, 1,28, 1464,3309);
KNpc.Add2(9933, 255, 1,28, 1457,3212);
KNpc.Add2(9933, 255, 1,28, 1463,3316);
KNpc.Add2(9933, 255, 1,28, 1470,3319);
KNpc.Add2(9933, 255, 1,28, 1456,3320);
KNpc.Add2(9933, 255, 1,28, 1449,3314);
KNpc.Add2(9933, 255, 1,28, 1479,3326);
KNpc.Add2(9933, 255, 1,28, 1471,3331);
KNpc.Add2(9933, 255, 1,28, 1462,3336);
KNpc.Add2(9933, 255, 1,28, 1483,3336);
KNpc.Add2(9933, 255, 1,28, 1490,3333);
KNpc.Add2(9933, 255, 1,28, 1468,3284);
KNpc.Add2(9933, 255, 1,28, 1472,3279);
KNpc.Add2(9933, 255, 1,28, 1463,3274);
KNpc.Add2(9933, 255, 1,28, 1460,3262);
KNpc.Add2(9933, 255, 1,28, 1452,3267);
KNpc.Add2(9933, 255, 1,28, 1465,3294);
KNpc.Add2(9933, 255, 1,28, 1469,3288);
KNpc.Add2(9933, 255, 1,28, 1476,3291);
KNpc.Add2(9933, 255, 1,28, 1484,3284);
KNpc.Add2(9933, 255, 1,28, 1491,3294);
KNpc.Add2(9933, 255, 1,28, 1426,3252);
KNpc.Add2(9933, 255, 1,28, 1487,3299);
KNpc.Add2(9933, 255, 1,28, 1496,3296);
KNpc.Add2(9933, 255, 1,28, 1497,3290);
KNpc.Add2(9933, 255, 1,28, 1504,3296);
KNpc.Add2(9933, 255, 1,28, 1509,3285);
KNpc.Add2(9933, 255, 1,28, 1518,3286);
KNpc.Add2(9933, 255, 1,28, 1522,3276);
KNpc.Add2(9933, 255, 1,28, 1426,3252);
KNpc.Add2(9933, 255, 1,28, 1516,3274);
KNpc.Add2(9933, 255, 1,28, 1524,3274);
KNpc.Add2(9933, 255, 1,28, 1524,3261);
KNpc.Add2(9933, 255, 1,28, 1518,3259);
KNpc.Add2(9933, 255, 1,28, 1533,3265);
KNpc.Add2(9933, 255, 1,28, 1537,3275);
KNpc.Add2(9933, 255, 1,28, 1536,3283);
KNpc.Add2(9933, 255, 1,28, 1540,3284);
KNpc.Add2(9933, 255, 1,28, 1547,3276);
KNpc.Add2(9933, 255, 1,28, 1553,3272);
KNpc.Add2(9933, 255, 1,28, 1549,3263);
KNpc.Add2(9933, 255, 1,28, 1552,3254);
KNpc.Add2(9933, 255, 1,28, 1559,3250);
KNpc.Add2(9933, 255, 1,28, 1551,3249);
KNpc.Add2(9933, 255, 1,28, 1547,3237);
KNpc.Add2(9933, 255, 1,28, 1541,3228);
KNpc.Add2(9933, 255, 1,28, 1533,3228);
KNpc.Add2(9933, 255, 1,28, 1563,3248);
KNpc.Add2(9933, 255, 1,28, 1570,3244);
KNpc.Add2(9933, 255, 1,28, 1572,3250);
KNpc.Add2(9933, 255, 1,28, 1579,3243);
KNpc.Add2(9933, 255, 1,28, 1575,3225);
KNpc.Add2(9933, 255, 1,28, 1586,3244);
KNpc.Add2(9933, 255, 1,28, 1590,3227);
KNpc.Add2(9933, 255, 1,28, 1598,3222);
KNpc.Add2(9933, 255, 1,28, 1604,3221);
KNpc.Add2(9933, 255, 1,28, 1596,3257);
KNpc.Add2(9933, 255, 1,28, 1595,3268);
KNpc.Add2(9933, 255, 1,28, 1599,3268);
KNpc.Add2(9933, 255, 1,28, 1608,3268);
KNpc.Add2(9933, 255, 1,28, 1607,3275);
KNpc.Add2(9933, 255, 1,28, 1615,3278);
KNpc.Add2(9933, 255, 1,28, 1611,3284);
KNpc.Add2(9933, 255, 1,28, 1607,3292);
KNpc.Add2(9933, 255, 1,28, 1600,3299);
KNpc.Add2(9933, 255, 1,28, 1593,3302);
KNpc.Add2(9933, 255, 1,28, 1587,3291);
KNpc.Add2(9933, 255, 1,28, 1578,3293);
KNpc.Add2(9933, 255, 1,28, 1578,3283);
KNpc.Add2(9933, 255, 1,28, 1566,3281);
KNpc.Add2(9933, 255, 1,28, 1611,3284);
KNpc.Add2(9933, 255, 1,28, 1596,3205);
KNpc.Add2(9933, 255, 1,28, 1594,3197);
KNpc.Add2(9933, 255, 1,28, 1587,3195);
KNpc.Add2(9933, 255, 1,28, 1599,3192);
KNpc.Add2(9933, 255, 1,28, 1609,3200);
KNpc.Add2(9933, 255, 1,28, 1614,3202);
KNpc.Add2(9933, 255, 1,28, 1621,3200);
KNpc.Add2(9933, 255, 1,28, 1629,3201);
KNpc.Add2(9933, 255, 1,28, 1638,3207);
KNpc.Add2(9933, 255, 1,28, 1639,3220);
KNpc.Add2(9933, 255, 1,28, 1650,3227);
KNpc.Add2(9933, 255, 1,28, 1652,3241);
KNpc.Add2(9933, 255, 1,28, 1660,3232);
		   local msg = "<color=yellow><color=red>Hoa Hồng Đỏ<color> đang mọc lên rực rỡ ở Đại Lý Phủ mọi người mau tới hái đem về tặng cho Nam Cung Tử Tuyết<color>";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
	end
function tbGMCard:HoaHongDo21()
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1420,3257);
KNpc.Add2(9932, 255, 1,28, 1417,3249);
KNpc.Add2(9932, 255, 1,28, 1432,3254);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1426,3261);
KNpc.Add2(9932, 255, 1,28, 1419,3268);
KNpc.Add2(9932, 255, 1,28, 1425,3273);
KNpc.Add2(9932, 255, 1,28, 1426,3275);
KNpc.Add2(9932, 255, 1,28, 1437,3271);
KNpc.Add2(9932, 255, 1,28, 1436,3298);
KNpc.Add2(9932, 255, 1,28, 1443,3293);
KNpc.Add2(9932, 255, 1,28, 1446,3303);
KNpc.Add2(9932, 255, 1,28, 1453,3300);
KNpc.Add2(9932, 255, 1,28, 1460,3299);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1463,3302);
KNpc.Add2(9932, 255, 1,28, 1464,3309);
KNpc.Add2(9932, 255, 1,28, 1457,3212);
KNpc.Add2(9932, 255, 1,28, 1463,3316);
KNpc.Add2(9932, 255, 1,28, 1470,3319);
KNpc.Add2(9932, 255, 1,28, 1456,3320);
KNpc.Add2(9932, 255, 1,28, 1449,3314);
KNpc.Add2(9932, 255, 1,28, 1479,3326);
KNpc.Add2(9932, 255, 1,28, 1471,3331);
KNpc.Add2(9932, 255, 1,28, 1462,3336);
KNpc.Add2(9932, 255, 1,28, 1483,3336);
KNpc.Add2(9932, 255, 1,28, 1490,3333);
KNpc.Add2(9932, 255, 1,28, 1468,3284);
KNpc.Add2(9932, 255, 1,28, 1472,3279);
KNpc.Add2(9932, 255, 1,28, 1463,3274);
KNpc.Add2(9932, 255, 1,28, 1460,3262);
KNpc.Add2(9932, 255, 1,28, 1452,3267);
KNpc.Add2(9932, 255, 1,28, 1465,3294);
KNpc.Add2(9932, 255, 1,28, 1469,3288);
KNpc.Add2(9932, 255, 1,28, 1476,3291);
KNpc.Add2(9932, 255, 1,28, 1484,3284);
KNpc.Add2(9932, 255, 1,28, 1491,3294);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1487,3299);
KNpc.Add2(9932, 255, 1,28, 1496,3296);
KNpc.Add2(9932, 255, 1,28, 1497,3290);
KNpc.Add2(9932, 255, 1,28, 1504,3296);
KNpc.Add2(9932, 255, 1,28, 1509,3285);
KNpc.Add2(9932, 255, 1,28, 1518,3286);
KNpc.Add2(9932, 255, 1,28, 1522,3276);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1516,3274);
KNpc.Add2(9932, 255, 1,28, 1524,3274);
KNpc.Add2(9932, 255, 1,28, 1524,3261);
KNpc.Add2(9932, 255, 1,28, 1518,3259);
KNpc.Add2(9932, 255, 1,28, 1533,3265);
KNpc.Add2(9932, 255, 1,28, 1537,3275);
KNpc.Add2(9932, 255, 1,28, 1536,3283);
KNpc.Add2(9932, 255, 1,28, 1540,3284);
KNpc.Add2(9932, 255, 1,28, 1547,3276);
KNpc.Add2(9932, 255, 1,28, 1553,3272);
KNpc.Add2(9932, 255, 1,28, 1549,3263);
KNpc.Add2(9932, 255, 1,28, 1552,3254);
KNpc.Add2(9932, 255, 1,28, 1559,3250);
KNpc.Add2(9932, 255, 1,28, 1551,3249);
KNpc.Add2(9932, 255, 1,28, 1547,3237);
KNpc.Add2(9932, 255, 1,28, 1541,3228);
KNpc.Add2(9932, 255, 1,28, 1533,3228);
KNpc.Add2(9932, 255, 1,28, 1563,3248);
KNpc.Add2(9932, 255, 1,28, 1570,3244);
KNpc.Add2(9932, 255, 1,28, 1572,3250);
KNpc.Add2(9932, 255, 1,28, 1579,3243);
KNpc.Add2(9932, 255, 1,28, 1575,3225);
KNpc.Add2(9932, 255, 1,28, 1586,3244);
KNpc.Add2(9932, 255, 1,28, 1590,3227);
KNpc.Add2(9932, 255, 1,28, 1598,3222);
KNpc.Add2(9932, 255, 1,28, 1604,3221);
KNpc.Add2(9932, 255, 1,28, 1596,3257);
KNpc.Add2(9932, 255, 1,28, 1595,3268);
KNpc.Add2(9932, 255, 1,28, 1599,3268);
KNpc.Add2(9932, 255, 1,28, 1608,3268);
KNpc.Add2(9932, 255, 1,28, 1607,3275);
KNpc.Add2(9932, 255, 1,28, 1615,3278);
KNpc.Add2(9932, 255, 1,28, 1611,3284);
KNpc.Add2(9932, 255, 1,28, 1607,3292);
KNpc.Add2(9932, 255, 1,28, 1600,3299);
KNpc.Add2(9932, 255, 1,28, 1593,3302);
KNpc.Add2(9932, 255, 1,28, 1587,3291);
KNpc.Add2(9932, 255, 1,28, 1578,3293);
KNpc.Add2(9932, 255, 1,28, 1578,3283);
KNpc.Add2(9932, 255, 1,28, 1566,3281);
KNpc.Add2(9932, 255, 1,28, 1611,3284);
KNpc.Add2(9932, 255, 1,28, 1596,3205);
KNpc.Add2(9932, 255, 1,28, 1594,3197);
KNpc.Add2(9932, 255, 1,28, 1587,3195);
KNpc.Add2(9932, 255, 1,28, 1599,3192);
KNpc.Add2(9932, 255, 1,28, 1609,3200);
KNpc.Add2(9932, 255, 1,28, 1614,3202);
KNpc.Add2(9932, 255, 1,28, 1621,3200);
KNpc.Add2(9932, 255, 1,28, 1629,3201);
KNpc.Add2(9932, 255, 1,28, 1638,3207);
KNpc.Add2(9932, 255, 1,28, 1639,3220);
KNpc.Add2(9932, 255, 1,28, 1650,3227);
KNpc.Add2(9932, 255, 1,28, 1652,3241);
KNpc.Add2(9932, 255, 1,28, 1660,3232);
		   local msg = "<color=yellow><color=red>Hoa Hồng Phấn<color> đang mọc lên rực rỡ ở Đại Lý Phủ mọi người mau tới hái đem về tặng cho Nam Cung Tử Tuyết<color>";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
	end
function tbGMCard:HoaHongDo2030()
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1420,3257);
KNpc.Add2(9932, 255, 1,28, 1417,3249);
KNpc.Add2(9932, 255, 1,28, 1432,3254);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1426,3261);
KNpc.Add2(9932, 255, 1,28, 1419,3268);
KNpc.Add2(9932, 255, 1,28, 1425,3273);
KNpc.Add2(9932, 255, 1,28, 1426,3275);
KNpc.Add2(9932, 255, 1,28, 1437,3271);
KNpc.Add2(9932, 255, 1,28, 1436,3298);
KNpc.Add2(9932, 255, 1,28, 1443,3293);
KNpc.Add2(9932, 255, 1,28, 1446,3303);
KNpc.Add2(9932, 255, 1,28, 1453,3300);
KNpc.Add2(9932, 255, 1,28, 1460,3299);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1463,3302);
KNpc.Add2(9932, 255, 1,28, 1464,3309);
KNpc.Add2(9932, 255, 1,28, 1457,3212);
KNpc.Add2(9932, 255, 1,28, 1463,3316);
KNpc.Add2(9932, 255, 1,28, 1470,3319);
KNpc.Add2(9932, 255, 1,28, 1456,3320);
KNpc.Add2(9932, 255, 1,28, 1449,3314);
KNpc.Add2(9932, 255, 1,28, 1479,3326);
KNpc.Add2(9932, 255, 1,28, 1471,3331);
KNpc.Add2(9932, 255, 1,28, 1462,3336);
KNpc.Add2(9932, 255, 1,28, 1483,3336);
KNpc.Add2(9932, 255, 1,28, 1490,3333);
KNpc.Add2(9932, 255, 1,28, 1468,3284);
KNpc.Add2(9932, 255, 1,28, 1472,3279);
KNpc.Add2(9932, 255, 1,28, 1463,3274);
KNpc.Add2(9932, 255, 1,28, 1460,3262);
KNpc.Add2(9932, 255, 1,28, 1452,3267);
KNpc.Add2(9932, 255, 1,28, 1465,3294);
KNpc.Add2(9932, 255, 1,28, 1469,3288);
KNpc.Add2(9932, 255, 1,28, 1476,3291);
KNpc.Add2(9932, 255, 1,28, 1484,3284);
KNpc.Add2(9932, 255, 1,28, 1491,3294);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1487,3299);
KNpc.Add2(9932, 255, 1,28, 1496,3296);
KNpc.Add2(9932, 255, 1,28, 1497,3290);
KNpc.Add2(9932, 255, 1,28, 1504,3296);
KNpc.Add2(9932, 255, 1,28, 1509,3285);
KNpc.Add2(9932, 255, 1,28, 1518,3286);
KNpc.Add2(9932, 255, 1,28, 1522,3276);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1516,3274);
KNpc.Add2(9932, 255, 1,28, 1524,3274);
KNpc.Add2(9932, 255, 1,28, 1524,3261);
KNpc.Add2(9932, 255, 1,28, 1518,3259);
KNpc.Add2(9932, 255, 1,28, 1533,3265);
KNpc.Add2(9932, 255, 1,28, 1537,3275);
KNpc.Add2(9932, 255, 1,28, 1536,3283);
KNpc.Add2(9932, 255, 1,28, 1540,3284);
KNpc.Add2(9932, 255, 1,28, 1547,3276);
KNpc.Add2(9932, 255, 1,28, 1553,3272);
KNpc.Add2(9932, 255, 1,28, 1549,3263);
KNpc.Add2(9932, 255, 1,28, 1552,3254);
KNpc.Add2(9932, 255, 1,28, 1559,3250);
KNpc.Add2(9932, 255, 1,28, 1551,3249);
KNpc.Add2(9932, 255, 1,28, 1547,3237);
KNpc.Add2(9932, 255, 1,28, 1541,3228);
KNpc.Add2(9932, 255, 1,28, 1533,3228);
KNpc.Add2(9932, 255, 1,28, 1563,3248);
KNpc.Add2(9932, 255, 1,28, 1570,3244);
KNpc.Add2(9932, 255, 1,28, 1572,3250);
KNpc.Add2(9932, 255, 1,28, 1579,3243);
KNpc.Add2(9932, 255, 1,28, 1575,3225);
KNpc.Add2(9932, 255, 1,28, 1586,3244);
KNpc.Add2(9932, 255, 1,28, 1590,3227);
KNpc.Add2(9932, 255, 1,28, 1598,3222);
KNpc.Add2(9932, 255, 1,28, 1604,3221);
KNpc.Add2(9932, 255, 1,28, 1596,3257);
KNpc.Add2(9932, 255, 1,28, 1595,3268);
KNpc.Add2(9932, 255, 1,28, 1599,3268);
KNpc.Add2(9932, 255, 1,28, 1608,3268);
KNpc.Add2(9932, 255, 1,28, 1607,3275);
KNpc.Add2(9932, 255, 1,28, 1615,3278);
KNpc.Add2(9932, 255, 1,28, 1611,3284);
KNpc.Add2(9932, 255, 1,28, 1607,3292);
KNpc.Add2(9932, 255, 1,28, 1600,3299);
KNpc.Add2(9932, 255, 1,28, 1593,3302);
KNpc.Add2(9932, 255, 1,28, 1587,3291);
KNpc.Add2(9932, 255, 1,28, 1578,3293);
KNpc.Add2(9932, 255, 1,28, 1578,3283);
KNpc.Add2(9932, 255, 1,28, 1566,3281);
KNpc.Add2(9932, 255, 1,28, 1611,3284);
KNpc.Add2(9932, 255, 1,28, 1596,3205);
KNpc.Add2(9932, 255, 1,28, 1594,3197);
KNpc.Add2(9932, 255, 1,28, 1587,3195);
KNpc.Add2(9932, 255, 1,28, 1599,3192);
KNpc.Add2(9932, 255, 1,28, 1609,3200);
KNpc.Add2(9932, 255, 1,28, 1614,3202);
KNpc.Add2(9932, 255, 1,28, 1621,3200);
KNpc.Add2(9932, 255, 1,28, 1629,3201);
KNpc.Add2(9932, 255, 1,28, 1638,3207);
KNpc.Add2(9932, 255, 1,28, 1639,3220);
KNpc.Add2(9932, 255, 1,28, 1650,3227);
KNpc.Add2(9932, 255, 1,28, 1652,3241);
KNpc.Add2(9932, 255, 1,28, 1660,3232);
		   local msg = "<color=yellow><color=red>Hoa Hồng Phấn<color> đang mọc lên rực rỡ ở Đại Lý Phủ mọi người mau tới hái đem về tặng cho Nam Cung Tử Tuyết<color>";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
	end
function tbGMCard:HoaHongDo20()
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1420,3257);
KNpc.Add2(9932, 255, 1,28, 1417,3249);
KNpc.Add2(9932, 255, 1,28, 1432,3254);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1426,3261);
KNpc.Add2(9932, 255, 1,28, 1419,3268);
KNpc.Add2(9932, 255, 1,28, 1425,3273);
KNpc.Add2(9932, 255, 1,28, 1426,3275);
KNpc.Add2(9932, 255, 1,28, 1437,3271);
KNpc.Add2(9932, 255, 1,28, 1436,3298);
KNpc.Add2(9932, 255, 1,28, 1443,3293);
KNpc.Add2(9932, 255, 1,28, 1446,3303);
KNpc.Add2(9932, 255, 1,28, 1453,3300);
KNpc.Add2(9932, 255, 1,28, 1460,3299);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1463,3302);
KNpc.Add2(9932, 255, 1,28, 1464,3309);
KNpc.Add2(9932, 255, 1,28, 1457,3212);
KNpc.Add2(9932, 255, 1,28, 1463,3316);
KNpc.Add2(9932, 255, 1,28, 1470,3319);
KNpc.Add2(9932, 255, 1,28, 1456,3320);
KNpc.Add2(9932, 255, 1,28, 1449,3314);
KNpc.Add2(9932, 255, 1,28, 1479,3326);
KNpc.Add2(9932, 255, 1,28, 1471,3331);
KNpc.Add2(9932, 255, 1,28, 1462,3336);
KNpc.Add2(9932, 255, 1,28, 1483,3336);
KNpc.Add2(9932, 255, 1,28, 1490,3333);
KNpc.Add2(9932, 255, 1,28, 1468,3284);
KNpc.Add2(9932, 255, 1,28, 1472,3279);
KNpc.Add2(9932, 255, 1,28, 1463,3274);
KNpc.Add2(9932, 255, 1,28, 1460,3262);
KNpc.Add2(9932, 255, 1,28, 1452,3267);
KNpc.Add2(9932, 255, 1,28, 1465,3294);
KNpc.Add2(9932, 255, 1,28, 1469,3288);
KNpc.Add2(9932, 255, 1,28, 1476,3291);
KNpc.Add2(9932, 255, 1,28, 1484,3284);
KNpc.Add2(9932, 255, 1,28, 1491,3294);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1487,3299);
KNpc.Add2(9932, 255, 1,28, 1496,3296);
KNpc.Add2(9932, 255, 1,28, 1497,3290);
KNpc.Add2(9932, 255, 1,28, 1504,3296);
KNpc.Add2(9932, 255, 1,28, 1509,3285);
KNpc.Add2(9932, 255, 1,28, 1518,3286);
KNpc.Add2(9932, 255, 1,28, 1522,3276);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1516,3274);
KNpc.Add2(9932, 255, 1,28, 1524,3274);
KNpc.Add2(9932, 255, 1,28, 1524,3261);
KNpc.Add2(9932, 255, 1,28, 1518,3259);
KNpc.Add2(9932, 255, 1,28, 1533,3265);
KNpc.Add2(9932, 255, 1,28, 1537,3275);
KNpc.Add2(9932, 255, 1,28, 1536,3283);
KNpc.Add2(9932, 255, 1,28, 1540,3284);
KNpc.Add2(9932, 255, 1,28, 1547,3276);
KNpc.Add2(9932, 255, 1,28, 1553,3272);
KNpc.Add2(9932, 255, 1,28, 1549,3263);
KNpc.Add2(9932, 255, 1,28, 1552,3254);
KNpc.Add2(9932, 255, 1,28, 1559,3250);
KNpc.Add2(9932, 255, 1,28, 1551,3249);
KNpc.Add2(9932, 255, 1,28, 1547,3237);
KNpc.Add2(9932, 255, 1,28, 1541,3228);
KNpc.Add2(9932, 255, 1,28, 1533,3228);
KNpc.Add2(9932, 255, 1,28, 1563,3248);
KNpc.Add2(9932, 255, 1,28, 1570,3244);
KNpc.Add2(9932, 255, 1,28, 1572,3250);
KNpc.Add2(9932, 255, 1,28, 1579,3243);
KNpc.Add2(9932, 255, 1,28, 1575,3225);
KNpc.Add2(9932, 255, 1,28, 1586,3244);
KNpc.Add2(9932, 255, 1,28, 1590,3227);
KNpc.Add2(9932, 255, 1,28, 1598,3222);
KNpc.Add2(9932, 255, 1,28, 1604,3221);
KNpc.Add2(9932, 255, 1,28, 1596,3257);
KNpc.Add2(9932, 255, 1,28, 1595,3268);
KNpc.Add2(9932, 255, 1,28, 1599,3268);
KNpc.Add2(9932, 255, 1,28, 1608,3268);
KNpc.Add2(9932, 255, 1,28, 1607,3275);
KNpc.Add2(9932, 255, 1,28, 1615,3278);
KNpc.Add2(9932, 255, 1,28, 1611,3284);
KNpc.Add2(9932, 255, 1,28, 1607,3292);
KNpc.Add2(9932, 255, 1,28, 1600,3299);
KNpc.Add2(9932, 255, 1,28, 1593,3302);
KNpc.Add2(9932, 255, 1,28, 1587,3291);
KNpc.Add2(9932, 255, 1,28, 1578,3293);
KNpc.Add2(9932, 255, 1,28, 1578,3283);
KNpc.Add2(9932, 255, 1,28, 1566,3281);
KNpc.Add2(9932, 255, 1,28, 1611,3284);
KNpc.Add2(9932, 255, 1,28, 1596,3205);
KNpc.Add2(9932, 255, 1,28, 1594,3197);
KNpc.Add2(9932, 255, 1,28, 1587,3195);
KNpc.Add2(9932, 255, 1,28, 1599,3192);
KNpc.Add2(9932, 255, 1,28, 1609,3200);
KNpc.Add2(9932, 255, 1,28, 1614,3202);
KNpc.Add2(9932, 255, 1,28, 1621,3200);
KNpc.Add2(9932, 255, 1,28, 1629,3201);
KNpc.Add2(9932, 255, 1,28, 1638,3207);
KNpc.Add2(9932, 255, 1,28, 1639,3220);
KNpc.Add2(9932, 255, 1,28, 1650,3227);
KNpc.Add2(9932, 255, 1,28, 1652,3241);
KNpc.Add2(9932, 255, 1,28, 1660,3232);
		   local msg = "<color=yellow><color=red>Hoa Hồng Đỏ<color> đang mọc lên rực rỡ ở Đại Lý Phủ mọi người mau tới hái đem về tặng cho Nam Cung Tử Tuyết<color>";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
	end
------------
function tbGMCard:HoaHongDo1045()
KNpc.Add2(9933, 255, 1,28, 1426,3252);
KNpc.Add2(9933, 255, 1,28, 1420,3257);
KNpc.Add2(9933, 255, 1,28, 1417,3249);
KNpc.Add2(9933, 255, 1,28, 1432,3254);
KNpc.Add2(9933, 255, 1,28, 1426,3252);
KNpc.Add2(9933, 255, 1,28, 1426,3261);
KNpc.Add2(9933, 255, 1,28, 1419,3268);
KNpc.Add2(9933, 255, 1,28, 1425,3273);
KNpc.Add2(9933, 255, 1,28, 1426,3275);
KNpc.Add2(9933, 255, 1,28, 1437,3271);
KNpc.Add2(9933, 255, 1,28, 1436,3298);
KNpc.Add2(9933, 255, 1,28, 1443,3293);
KNpc.Add2(9933, 255, 1,28, 1446,3303);
KNpc.Add2(9933, 255, 1,28, 1453,3300);
KNpc.Add2(9933, 255, 1,28, 1460,3299);
KNpc.Add2(9933, 255, 1,28, 1426,3252);
KNpc.Add2(9933, 255, 1,28, 1463,3302);
KNpc.Add2(9933, 255, 1,28, 1464,3309);
KNpc.Add2(9933, 255, 1,28, 1457,3212);
KNpc.Add2(9933, 255, 1,28, 1463,3316);
KNpc.Add2(9933, 255, 1,28, 1470,3319);
KNpc.Add2(9933, 255, 1,28, 1456,3320);
KNpc.Add2(9933, 255, 1,28, 1449,3314);
KNpc.Add2(9933, 255, 1,28, 1479,3326);
KNpc.Add2(9933, 255, 1,28, 1471,3331);
KNpc.Add2(9933, 255, 1,28, 1462,3336);
KNpc.Add2(9933, 255, 1,28, 1483,3336);
KNpc.Add2(9933, 255, 1,28, 1490,3333);
KNpc.Add2(9933, 255, 1,28, 1468,3284);
KNpc.Add2(9933, 255, 1,28, 1472,3279);
KNpc.Add2(9933, 255, 1,28, 1463,3274);
KNpc.Add2(9933, 255, 1,28, 1460,3262);
KNpc.Add2(9933, 255, 1,28, 1452,3267);
KNpc.Add2(9933, 255, 1,28, 1465,3294);
KNpc.Add2(9933, 255, 1,28, 1469,3288);
KNpc.Add2(9933, 255, 1,28, 1476,3291);
KNpc.Add2(9933, 255, 1,28, 1484,3284);
KNpc.Add2(9933, 255, 1,28, 1491,3294);
KNpc.Add2(9933, 255, 1,28, 1426,3252);
KNpc.Add2(9933, 255, 1,28, 1487,3299);
KNpc.Add2(9933, 255, 1,28, 1496,3296);
KNpc.Add2(9933, 255, 1,28, 1497,3290);
KNpc.Add2(9933, 255, 1,28, 1504,3296);
KNpc.Add2(9933, 255, 1,28, 1509,3285);
KNpc.Add2(9933, 255, 1,28, 1518,3286);
KNpc.Add2(9933, 255, 1,28, 1522,3276);
KNpc.Add2(9933, 255, 1,28, 1426,3252);
KNpc.Add2(9933, 255, 1,28, 1516,3274);
KNpc.Add2(9933, 255, 1,28, 1524,3274);
KNpc.Add2(9933, 255, 1,28, 1524,3261);
KNpc.Add2(9933, 255, 1,28, 1518,3259);
KNpc.Add2(9933, 255, 1,28, 1533,3265);
KNpc.Add2(9933, 255, 1,28, 1537,3275);
KNpc.Add2(9933, 255, 1,28, 1536,3283);
KNpc.Add2(9933, 255, 1,28, 1540,3284);
KNpc.Add2(9933, 255, 1,28, 1547,3276);
KNpc.Add2(9933, 255, 1,28, 1553,3272);
KNpc.Add2(9933, 255, 1,28, 1549,3263);
KNpc.Add2(9933, 255, 1,28, 1552,3254);
KNpc.Add2(9933, 255, 1,28, 1559,3250);
KNpc.Add2(9933, 255, 1,28, 1551,3249);
KNpc.Add2(9933, 255, 1,28, 1547,3237);
KNpc.Add2(9933, 255, 1,28, 1541,3228);
KNpc.Add2(9933, 255, 1,28, 1533,3228);
KNpc.Add2(9933, 255, 1,28, 1563,3248);
KNpc.Add2(9933, 255, 1,28, 1570,3244);
KNpc.Add2(9933, 255, 1,28, 1572,3250);
KNpc.Add2(9933, 255, 1,28, 1579,3243);
KNpc.Add2(9933, 255, 1,28, 1575,3225);
KNpc.Add2(9933, 255, 1,28, 1586,3244);
KNpc.Add2(9933, 255, 1,28, 1590,3227);
KNpc.Add2(9933, 255, 1,28, 1598,3222);
KNpc.Add2(9933, 255, 1,28, 1604,3221);
KNpc.Add2(9933, 255, 1,28, 1596,3257);
KNpc.Add2(9933, 255, 1,28, 1595,3268);
KNpc.Add2(9933, 255, 1,28, 1599,3268);
KNpc.Add2(9933, 255, 1,28, 1608,3268);
KNpc.Add2(9933, 255, 1,28, 1607,3275);
KNpc.Add2(9933, 255, 1,28, 1615,3278);
KNpc.Add2(9933, 255, 1,28, 1611,3284);
KNpc.Add2(9933, 255, 1,28, 1607,3292);
KNpc.Add2(9933, 255, 1,28, 1600,3299);
KNpc.Add2(9933, 255, 1,28, 1593,3302);
KNpc.Add2(9933, 255, 1,28, 1587,3291);
KNpc.Add2(9933, 255, 1,28, 1578,3293);
KNpc.Add2(9933, 255, 1,28, 1578,3283);
KNpc.Add2(9933, 255, 1,28, 1566,3281);
KNpc.Add2(9933, 255, 1,28, 1611,3284);
KNpc.Add2(9933, 255, 1,28, 1596,3205);
KNpc.Add2(9933, 255, 1,28, 1594,3197);
KNpc.Add2(9933, 255, 1,28, 1587,3195);
KNpc.Add2(9933, 255, 1,28, 1599,3192);
KNpc.Add2(9933, 255, 1,28, 1609,3200);
KNpc.Add2(9933, 255, 1,28, 1614,3202);
KNpc.Add2(9933, 255, 1,28, 1621,3200);
KNpc.Add2(9933, 255, 1,28, 1629,3201);
KNpc.Add2(9933, 255, 1,28, 1638,3207);
KNpc.Add2(9933, 255, 1,28, 1639,3220);
KNpc.Add2(9933, 255, 1,28, 1650,3227);
KNpc.Add2(9933, 255, 1,28, 1652,3241);
KNpc.Add2(9933, 255, 1,28, 1660,3232);
		   local msg = "<color=yellow><color=red>Hoa Hồng Phấn<color> đang mọc lên rực rỡ ở Đại Lý Phủ mọi người mau tới hái đem về tặng cho Nam Cung Tử Tuyết<color>";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
	end
function tbGMCard:HoaHongDo1015()
KNpc.Add2(9933, 255, 1,28, 1426,3252);
KNpc.Add2(9933, 255, 1,28, 1420,3257);
KNpc.Add2(9933, 255, 1,28, 1417,3249);
KNpc.Add2(9933, 255, 1,28, 1432,3254);
KNpc.Add2(9933, 255, 1,28, 1426,3252);
KNpc.Add2(9933, 255, 1,28, 1426,3261);
KNpc.Add2(9933, 255, 1,28, 1419,3268);
KNpc.Add2(9933, 255, 1,28, 1425,3273);
KNpc.Add2(9933, 255, 1,28, 1426,3275);
KNpc.Add2(9933, 255, 1,28, 1437,3271);
KNpc.Add2(9933, 255, 1,28, 1436,3298);
KNpc.Add2(9933, 255, 1,28, 1443,3293);
KNpc.Add2(9933, 255, 1,28, 1446,3303);
KNpc.Add2(9933, 255, 1,28, 1453,3300);
KNpc.Add2(9933, 255, 1,28, 1460,3299);
KNpc.Add2(9933, 255, 1,28, 1426,3252);
KNpc.Add2(9933, 255, 1,28, 1463,3302);
KNpc.Add2(9933, 255, 1,28, 1464,3309);
KNpc.Add2(9933, 255, 1,28, 1457,3212);
KNpc.Add2(9933, 255, 1,28, 1463,3316);
KNpc.Add2(9933, 255, 1,28, 1470,3319);
KNpc.Add2(9933, 255, 1,28, 1456,3320);
KNpc.Add2(9933, 255, 1,28, 1449,3314);
KNpc.Add2(9933, 255, 1,28, 1479,3326);
KNpc.Add2(9933, 255, 1,28, 1471,3331);
KNpc.Add2(9933, 255, 1,28, 1462,3336);
KNpc.Add2(9933, 255, 1,28, 1483,3336);
KNpc.Add2(9933, 255, 1,28, 1490,3333);
KNpc.Add2(9933, 255, 1,28, 1468,3284);
KNpc.Add2(9933, 255, 1,28, 1472,3279);
KNpc.Add2(9933, 255, 1,28, 1463,3274);
KNpc.Add2(9933, 255, 1,28, 1460,3262);
KNpc.Add2(9933, 255, 1,28, 1452,3267);
KNpc.Add2(9933, 255, 1,28, 1465,3294);
KNpc.Add2(9933, 255, 1,28, 1469,3288);
KNpc.Add2(9933, 255, 1,28, 1476,3291);
KNpc.Add2(9933, 255, 1,28, 1484,3284);
KNpc.Add2(9933, 255, 1,28, 1491,3294);
KNpc.Add2(9933, 255, 1,28, 1426,3252);
KNpc.Add2(9933, 255, 1,28, 1487,3299);
KNpc.Add2(9933, 255, 1,28, 1496,3296);
KNpc.Add2(9933, 255, 1,28, 1497,3290);
KNpc.Add2(9933, 255, 1,28, 1504,3296);
KNpc.Add2(9933, 255, 1,28, 1509,3285);
KNpc.Add2(9933, 255, 1,28, 1518,3286);
KNpc.Add2(9933, 255, 1,28, 1522,3276);
KNpc.Add2(9933, 255, 1,28, 1426,3252);
KNpc.Add2(9933, 255, 1,28, 1516,3274);
KNpc.Add2(9933, 255, 1,28, 1524,3274);
KNpc.Add2(9933, 255, 1,28, 1524,3261);
KNpc.Add2(9933, 255, 1,28, 1518,3259);
KNpc.Add2(9933, 255, 1,28, 1533,3265);
KNpc.Add2(9933, 255, 1,28, 1537,3275);
KNpc.Add2(9933, 255, 1,28, 1536,3283);
KNpc.Add2(9933, 255, 1,28, 1540,3284);
KNpc.Add2(9933, 255, 1,28, 1547,3276);
KNpc.Add2(9933, 255, 1,28, 1553,3272);
KNpc.Add2(9933, 255, 1,28, 1549,3263);
KNpc.Add2(9933, 255, 1,28, 1552,3254);
KNpc.Add2(9933, 255, 1,28, 1559,3250);
KNpc.Add2(9933, 255, 1,28, 1551,3249);
KNpc.Add2(9933, 255, 1,28, 1547,3237);
KNpc.Add2(9933, 255, 1,28, 1541,3228);
KNpc.Add2(9933, 255, 1,28, 1533,3228);
KNpc.Add2(9933, 255, 1,28, 1563,3248);
KNpc.Add2(9933, 255, 1,28, 1570,3244);
KNpc.Add2(9933, 255, 1,28, 1572,3250);
KNpc.Add2(9933, 255, 1,28, 1579,3243);
KNpc.Add2(9933, 255, 1,28, 1575,3225);
KNpc.Add2(9933, 255, 1,28, 1586,3244);
KNpc.Add2(9933, 255, 1,28, 1590,3227);
KNpc.Add2(9933, 255, 1,28, 1598,3222);
KNpc.Add2(9933, 255, 1,28, 1604,3221);
KNpc.Add2(9933, 255, 1,28, 1596,3257);
KNpc.Add2(9933, 255, 1,28, 1595,3268);
KNpc.Add2(9933, 255, 1,28, 1599,3268);
KNpc.Add2(9933, 255, 1,28, 1608,3268);
KNpc.Add2(9933, 255, 1,28, 1607,3275);
KNpc.Add2(9933, 255, 1,28, 1615,3278);
KNpc.Add2(9933, 255, 1,28, 1611,3284);
KNpc.Add2(9933, 255, 1,28, 1607,3292);
KNpc.Add2(9933, 255, 1,28, 1600,3299);
KNpc.Add2(9933, 255, 1,28, 1593,3302);
KNpc.Add2(9933, 255, 1,28, 1587,3291);
KNpc.Add2(9933, 255, 1,28, 1578,3293);
KNpc.Add2(9933, 255, 1,28, 1578,3283);
KNpc.Add2(9933, 255, 1,28, 1566,3281);
KNpc.Add2(9933, 255, 1,28, 1611,3284);
KNpc.Add2(9933, 255, 1,28, 1596,3205);
KNpc.Add2(9933, 255, 1,28, 1594,3197);
KNpc.Add2(9933, 255, 1,28, 1587,3195);
KNpc.Add2(9933, 255, 1,28, 1599,3192);
KNpc.Add2(9933, 255, 1,28, 1609,3200);
KNpc.Add2(9933, 255, 1,28, 1614,3202);
KNpc.Add2(9933, 255, 1,28, 1621,3200);
KNpc.Add2(9933, 255, 1,28, 1629,3201);
KNpc.Add2(9933, 255, 1,28, 1638,3207);
KNpc.Add2(9933, 255, 1,28, 1639,3220);
KNpc.Add2(9933, 255, 1,28, 1650,3227);
KNpc.Add2(9933, 255, 1,28, 1652,3241);
KNpc.Add2(9933, 255, 1,28, 1660,3232);
		   local msg = "<color=yellow><color=red>Hoa Hồng Phấn<color> đang mọc lên rực rỡ ở Đại Lý Phủ mọi người mau tới hái đem về tặng cho Nam Cung Tử Tuyết<color>";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
	end
function tbGMCard:HoaHongDo11()
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1420,3257);
KNpc.Add2(9932, 255, 1,28, 1417,3249);
KNpc.Add2(9932, 255, 1,28, 1432,3254);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1426,3261);
KNpc.Add2(9932, 255, 1,28, 1419,3268);
KNpc.Add2(9932, 255, 1,28, 1425,3273);
KNpc.Add2(9932, 255, 1,28, 1426,3275);
KNpc.Add2(9932, 255, 1,28, 1437,3271);
KNpc.Add2(9932, 255, 1,28, 1436,3298);
KNpc.Add2(9932, 255, 1,28, 1443,3293);
KNpc.Add2(9932, 255, 1,28, 1446,3303);
KNpc.Add2(9932, 255, 1,28, 1453,3300);
KNpc.Add2(9932, 255, 1,28, 1460,3299);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1463,3302);
KNpc.Add2(9932, 255, 1,28, 1464,3309);
KNpc.Add2(9932, 255, 1,28, 1457,3212);
KNpc.Add2(9932, 255, 1,28, 1463,3316);
KNpc.Add2(9932, 255, 1,28, 1470,3319);
KNpc.Add2(9932, 255, 1,28, 1456,3320);
KNpc.Add2(9932, 255, 1,28, 1449,3314);
KNpc.Add2(9932, 255, 1,28, 1479,3326);
KNpc.Add2(9932, 255, 1,28, 1471,3331);
KNpc.Add2(9932, 255, 1,28, 1462,3336);
KNpc.Add2(9932, 255, 1,28, 1483,3336);
KNpc.Add2(9932, 255, 1,28, 1490,3333);
KNpc.Add2(9932, 255, 1,28, 1468,3284);
KNpc.Add2(9932, 255, 1,28, 1472,3279);
KNpc.Add2(9932, 255, 1,28, 1463,3274);
KNpc.Add2(9932, 255, 1,28, 1460,3262);
KNpc.Add2(9932, 255, 1,28, 1452,3267);
KNpc.Add2(9932, 255, 1,28, 1465,3294);
KNpc.Add2(9932, 255, 1,28, 1469,3288);
KNpc.Add2(9932, 255, 1,28, 1476,3291);
KNpc.Add2(9932, 255, 1,28, 1484,3284);
KNpc.Add2(9932, 255, 1,28, 1491,3294);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1487,3299);
KNpc.Add2(9932, 255, 1,28, 1496,3296);
KNpc.Add2(9932, 255, 1,28, 1497,3290);
KNpc.Add2(9932, 255, 1,28, 1504,3296);
KNpc.Add2(9932, 255, 1,28, 1509,3285);
KNpc.Add2(9932, 255, 1,28, 1518,3286);
KNpc.Add2(9932, 255, 1,28, 1522,3276);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1516,3274);
KNpc.Add2(9932, 255, 1,28, 1524,3274);
KNpc.Add2(9932, 255, 1,28, 1524,3261);
KNpc.Add2(9932, 255, 1,28, 1518,3259);
KNpc.Add2(9932, 255, 1,28, 1533,3265);
KNpc.Add2(9932, 255, 1,28, 1537,3275);
KNpc.Add2(9932, 255, 1,28, 1536,3283);
KNpc.Add2(9932, 255, 1,28, 1540,3284);
KNpc.Add2(9932, 255, 1,28, 1547,3276);
KNpc.Add2(9932, 255, 1,28, 1553,3272);
KNpc.Add2(9932, 255, 1,28, 1549,3263);
KNpc.Add2(9932, 255, 1,28, 1552,3254);
KNpc.Add2(9932, 255, 1,28, 1559,3250);
KNpc.Add2(9932, 255, 1,28, 1551,3249);
KNpc.Add2(9932, 255, 1,28, 1547,3237);
KNpc.Add2(9932, 255, 1,28, 1541,3228);
KNpc.Add2(9932, 255, 1,28, 1533,3228);
KNpc.Add2(9932, 255, 1,28, 1563,3248);
KNpc.Add2(9932, 255, 1,28, 1570,3244);
KNpc.Add2(9932, 255, 1,28, 1572,3250);
KNpc.Add2(9932, 255, 1,28, 1579,3243);
KNpc.Add2(9932, 255, 1,28, 1575,3225);
KNpc.Add2(9932, 255, 1,28, 1586,3244);
KNpc.Add2(9932, 255, 1,28, 1590,3227);
KNpc.Add2(9932, 255, 1,28, 1598,3222);
KNpc.Add2(9932, 255, 1,28, 1604,3221);
KNpc.Add2(9932, 255, 1,28, 1596,3257);
KNpc.Add2(9932, 255, 1,28, 1595,3268);
KNpc.Add2(9932, 255, 1,28, 1599,3268);
KNpc.Add2(9932, 255, 1,28, 1608,3268);
KNpc.Add2(9932, 255, 1,28, 1607,3275);
KNpc.Add2(9932, 255, 1,28, 1615,3278);
KNpc.Add2(9932, 255, 1,28, 1611,3284);
KNpc.Add2(9932, 255, 1,28, 1607,3292);
KNpc.Add2(9932, 255, 1,28, 1600,3299);
KNpc.Add2(9932, 255, 1,28, 1593,3302);
KNpc.Add2(9932, 255, 1,28, 1587,3291);
KNpc.Add2(9932, 255, 1,28, 1578,3293);
KNpc.Add2(9932, 255, 1,28, 1578,3283);
KNpc.Add2(9932, 255, 1,28, 1566,3281);
KNpc.Add2(9932, 255, 1,28, 1611,3284);
KNpc.Add2(9932, 255, 1,28, 1596,3205);
KNpc.Add2(9932, 255, 1,28, 1594,3197);
KNpc.Add2(9932, 255, 1,28, 1587,3195);
KNpc.Add2(9932, 255, 1,28, 1599,3192);
KNpc.Add2(9932, 255, 1,28, 1609,3200);
KNpc.Add2(9932, 255, 1,28, 1614,3202);
KNpc.Add2(9932, 255, 1,28, 1621,3200);
KNpc.Add2(9932, 255, 1,28, 1629,3201);
KNpc.Add2(9932, 255, 1,28, 1638,3207);
KNpc.Add2(9932, 255, 1,28, 1639,3220);
KNpc.Add2(9932, 255, 1,28, 1650,3227);
KNpc.Add2(9932, 255, 1,28, 1652,3241);
KNpc.Add2(9932, 255, 1,28, 1660,3232);
		   local msg = "<color=yellow><color=red>Hoa Hồng Đỏ<color> đang mọc lên rực rỡ ở Đại Lý Phủ mọi người mau tới hái đem về tặng cho Nam Cung Tử Tuyết<color>";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
	end
function tbGMCard:HoaHongDo1030()
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1420,3257);
KNpc.Add2(9932, 255, 1,28, 1417,3249);
KNpc.Add2(9932, 255, 1,28, 1432,3254);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1426,3261);
KNpc.Add2(9932, 255, 1,28, 1419,3268);
KNpc.Add2(9932, 255, 1,28, 1425,3273);
KNpc.Add2(9932, 255, 1,28, 1426,3275);
KNpc.Add2(9932, 255, 1,28, 1437,3271);
KNpc.Add2(9932, 255, 1,28, 1436,3298);
KNpc.Add2(9932, 255, 1,28, 1443,3293);
KNpc.Add2(9932, 255, 1,28, 1446,3303);
KNpc.Add2(9932, 255, 1,28, 1453,3300);
KNpc.Add2(9932, 255, 1,28, 1460,3299);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1463,3302);
KNpc.Add2(9932, 255, 1,28, 1464,3309);
KNpc.Add2(9932, 255, 1,28, 1457,3212);
KNpc.Add2(9932, 255, 1,28, 1463,3316);
KNpc.Add2(9932, 255, 1,28, 1470,3319);
KNpc.Add2(9932, 255, 1,28, 1456,3320);
KNpc.Add2(9932, 255, 1,28, 1449,3314);
KNpc.Add2(9932, 255, 1,28, 1479,3326);
KNpc.Add2(9932, 255, 1,28, 1471,3331);
KNpc.Add2(9932, 255, 1,28, 1462,3336);
KNpc.Add2(9932, 255, 1,28, 1483,3336);
KNpc.Add2(9932, 255, 1,28, 1490,3333);
KNpc.Add2(9932, 255, 1,28, 1468,3284);
KNpc.Add2(9932, 255, 1,28, 1472,3279);
KNpc.Add2(9932, 255, 1,28, 1463,3274);
KNpc.Add2(9932, 255, 1,28, 1460,3262);
KNpc.Add2(9932, 255, 1,28, 1452,3267);
KNpc.Add2(9932, 255, 1,28, 1465,3294);
KNpc.Add2(9932, 255, 1,28, 1469,3288);
KNpc.Add2(9932, 255, 1,28, 1476,3291);
KNpc.Add2(9932, 255, 1,28, 1484,3284);
KNpc.Add2(9932, 255, 1,28, 1491,3294);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1487,3299);
KNpc.Add2(9932, 255, 1,28, 1496,3296);
KNpc.Add2(9932, 255, 1,28, 1497,3290);
KNpc.Add2(9932, 255, 1,28, 1504,3296);
KNpc.Add2(9932, 255, 1,28, 1509,3285);
KNpc.Add2(9932, 255, 1,28, 1518,3286);
KNpc.Add2(9932, 255, 1,28, 1522,3276);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1516,3274);
KNpc.Add2(9932, 255, 1,28, 1524,3274);
KNpc.Add2(9932, 255, 1,28, 1524,3261);
KNpc.Add2(9932, 255, 1,28, 1518,3259);
KNpc.Add2(9932, 255, 1,28, 1533,3265);
KNpc.Add2(9932, 255, 1,28, 1537,3275);
KNpc.Add2(9932, 255, 1,28, 1536,3283);
KNpc.Add2(9932, 255, 1,28, 1540,3284);
KNpc.Add2(9932, 255, 1,28, 1547,3276);
KNpc.Add2(9932, 255, 1,28, 1553,3272);
KNpc.Add2(9932, 255, 1,28, 1549,3263);
KNpc.Add2(9932, 255, 1,28, 1552,3254);
KNpc.Add2(9932, 255, 1,28, 1559,3250);
KNpc.Add2(9932, 255, 1,28, 1551,3249);
KNpc.Add2(9932, 255, 1,28, 1547,3237);
KNpc.Add2(9932, 255, 1,28, 1541,3228);
KNpc.Add2(9932, 255, 1,28, 1533,3228);
KNpc.Add2(9932, 255, 1,28, 1563,3248);
KNpc.Add2(9932, 255, 1,28, 1570,3244);
KNpc.Add2(9932, 255, 1,28, 1572,3250);
KNpc.Add2(9932, 255, 1,28, 1579,3243);
KNpc.Add2(9932, 255, 1,28, 1575,3225);
KNpc.Add2(9932, 255, 1,28, 1586,3244);
KNpc.Add2(9932, 255, 1,28, 1590,3227);
KNpc.Add2(9932, 255, 1,28, 1598,3222);
KNpc.Add2(9932, 255, 1,28, 1604,3221);
KNpc.Add2(9932, 255, 1,28, 1596,3257);
KNpc.Add2(9932, 255, 1,28, 1595,3268);
KNpc.Add2(9932, 255, 1,28, 1599,3268);
KNpc.Add2(9932, 255, 1,28, 1608,3268);
KNpc.Add2(9932, 255, 1,28, 1607,3275);
KNpc.Add2(9932, 255, 1,28, 1615,3278);
KNpc.Add2(9932, 255, 1,28, 1611,3284);
KNpc.Add2(9932, 255, 1,28, 1607,3292);
KNpc.Add2(9932, 255, 1,28, 1600,3299);
KNpc.Add2(9932, 255, 1,28, 1593,3302);
KNpc.Add2(9932, 255, 1,28, 1587,3291);
KNpc.Add2(9932, 255, 1,28, 1578,3293);
KNpc.Add2(9932, 255, 1,28, 1578,3283);
KNpc.Add2(9932, 255, 1,28, 1566,3281);
KNpc.Add2(9932, 255, 1,28, 1611,3284);
KNpc.Add2(9932, 255, 1,28, 1596,3205);
KNpc.Add2(9932, 255, 1,28, 1594,3197);
KNpc.Add2(9932, 255, 1,28, 1587,3195);
KNpc.Add2(9932, 255, 1,28, 1599,3192);
KNpc.Add2(9932, 255, 1,28, 1609,3200);
KNpc.Add2(9932, 255, 1,28, 1614,3202);
KNpc.Add2(9932, 255, 1,28, 1621,3200);
KNpc.Add2(9932, 255, 1,28, 1629,3201);
KNpc.Add2(9932, 255, 1,28, 1638,3207);
KNpc.Add2(9932, 255, 1,28, 1639,3220);
KNpc.Add2(9932, 255, 1,28, 1650,3227);
KNpc.Add2(9932, 255, 1,28, 1652,3241);
KNpc.Add2(9932, 255, 1,28, 1660,3232);
		   local msg = "<color=yellow><color=red>Hoa Hồng Đỏ<color> đang mọc lên rực rỡ ở Đại Lý Phủ mọi người mau tới hái đem về tặng cho Nam Cung Tử Tuyết<color>";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
	end
function tbGMCard:HoaHongDo10()
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1420,3257);
KNpc.Add2(9932, 255, 1,28, 1417,3249);
KNpc.Add2(9932, 255, 1,28, 1432,3254);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1426,3261);
KNpc.Add2(9932, 255, 1,28, 1419,3268);
KNpc.Add2(9932, 255, 1,28, 1425,3273);
KNpc.Add2(9932, 255, 1,28, 1426,3275);
KNpc.Add2(9932, 255, 1,28, 1437,3271);
KNpc.Add2(9932, 255, 1,28, 1436,3298);
KNpc.Add2(9932, 255, 1,28, 1443,3293);
KNpc.Add2(9932, 255, 1,28, 1446,3303);
KNpc.Add2(9932, 255, 1,28, 1453,3300);
KNpc.Add2(9932, 255, 1,28, 1460,3299);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1463,3302);
KNpc.Add2(9932, 255, 1,28, 1464,3309);
KNpc.Add2(9932, 255, 1,28, 1457,3212);
KNpc.Add2(9932, 255, 1,28, 1463,3316);
KNpc.Add2(9932, 255, 1,28, 1470,3319);
KNpc.Add2(9932, 255, 1,28, 1456,3320);
KNpc.Add2(9932, 255, 1,28, 1449,3314);
KNpc.Add2(9932, 255, 1,28, 1479,3326);
KNpc.Add2(9932, 255, 1,28, 1471,3331);
KNpc.Add2(9932, 255, 1,28, 1462,3336);
KNpc.Add2(9932, 255, 1,28, 1483,3336);
KNpc.Add2(9932, 255, 1,28, 1490,3333);
KNpc.Add2(9932, 255, 1,28, 1468,3284);
KNpc.Add2(9932, 255, 1,28, 1472,3279);
KNpc.Add2(9932, 255, 1,28, 1463,3274);
KNpc.Add2(9932, 255, 1,28, 1460,3262);
KNpc.Add2(9932, 255, 1,28, 1452,3267);
KNpc.Add2(9932, 255, 1,28, 1465,3294);
KNpc.Add2(9932, 255, 1,28, 1469,3288);
KNpc.Add2(9932, 255, 1,28, 1476,3291);
KNpc.Add2(9932, 255, 1,28, 1484,3284);
KNpc.Add2(9932, 255, 1,28, 1491,3294);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1487,3299);
KNpc.Add2(9932, 255, 1,28, 1496,3296);
KNpc.Add2(9932, 255, 1,28, 1497,3290);
KNpc.Add2(9932, 255, 1,28, 1504,3296);
KNpc.Add2(9932, 255, 1,28, 1509,3285);
KNpc.Add2(9932, 255, 1,28, 1518,3286);
KNpc.Add2(9932, 255, 1,28, 1522,3276);
KNpc.Add2(9932, 255, 1,28, 1426,3252);
KNpc.Add2(9932, 255, 1,28, 1516,3274);
KNpc.Add2(9932, 255, 1,28, 1524,3274);
KNpc.Add2(9932, 255, 1,28, 1524,3261);
KNpc.Add2(9932, 255, 1,28, 1518,3259);
KNpc.Add2(9932, 255, 1,28, 1533,3265);
KNpc.Add2(9932, 255, 1,28, 1537,3275);
KNpc.Add2(9932, 255, 1,28, 1536,3283);
KNpc.Add2(9932, 255, 1,28, 1540,3284);
KNpc.Add2(9932, 255, 1,28, 1547,3276);
KNpc.Add2(9932, 255, 1,28, 1553,3272);
KNpc.Add2(9932, 255, 1,28, 1549,3263);
KNpc.Add2(9932, 255, 1,28, 1552,3254);
KNpc.Add2(9932, 255, 1,28, 1559,3250);
KNpc.Add2(9932, 255, 1,28, 1551,3249);
KNpc.Add2(9932, 255, 1,28, 1547,3237);
KNpc.Add2(9932, 255, 1,28, 1541,3228);
KNpc.Add2(9932, 255, 1,28, 1533,3228);
KNpc.Add2(9932, 255, 1,28, 1563,3248);
KNpc.Add2(9932, 255, 1,28, 1570,3244);
KNpc.Add2(9932, 255, 1,28, 1572,3250);
KNpc.Add2(9932, 255, 1,28, 1579,3243);
KNpc.Add2(9932, 255, 1,28, 1575,3225);
KNpc.Add2(9932, 255, 1,28, 1586,3244);
KNpc.Add2(9932, 255, 1,28, 1590,3227);
KNpc.Add2(9932, 255, 1,28, 1598,3222);
KNpc.Add2(9932, 255, 1,28, 1604,3221);
KNpc.Add2(9932, 255, 1,28, 1596,3257);
KNpc.Add2(9932, 255, 1,28, 1595,3268);
KNpc.Add2(9932, 255, 1,28, 1599,3268);
KNpc.Add2(9932, 255, 1,28, 1608,3268);
KNpc.Add2(9932, 255, 1,28, 1607,3275);
KNpc.Add2(9932, 255, 1,28, 1615,3278);
KNpc.Add2(9932, 255, 1,28, 1611,3284);
KNpc.Add2(9932, 255, 1,28, 1607,3292);
KNpc.Add2(9932, 255, 1,28, 1600,3299);
KNpc.Add2(9932, 255, 1,28, 1593,3302);
KNpc.Add2(9932, 255, 1,28, 1587,3291);
KNpc.Add2(9932, 255, 1,28, 1578,3293);
KNpc.Add2(9932, 255, 1,28, 1578,3283);
KNpc.Add2(9932, 255, 1,28, 1566,3281);
KNpc.Add2(9932, 255, 1,28, 1611,3284);
KNpc.Add2(9932, 255, 1,28, 1596,3205);
KNpc.Add2(9932, 255, 1,28, 1594,3197);
KNpc.Add2(9932, 255, 1,28, 1587,3195);
KNpc.Add2(9932, 255, 1,28, 1599,3192);
KNpc.Add2(9932, 255, 1,28, 1609,3200);
KNpc.Add2(9932, 255, 1,28, 1614,3202);
KNpc.Add2(9932, 255, 1,28, 1621,3200);
KNpc.Add2(9932, 255, 1,28, 1629,3201);
KNpc.Add2(9932, 255, 1,28, 1638,3207);
KNpc.Add2(9932, 255, 1,28, 1639,3220);
KNpc.Add2(9932, 255, 1,28, 1650,3227);
KNpc.Add2(9932, 255, 1,28, 1652,3241);
KNpc.Add2(9932, 255, 1,28, 1660,3232);
		   local msg = "<color=yellow><color=red>Hoa Hồng Đỏ<color> đang mọc lên rực rỡ ở Đại Lý Phủ mọi người mau tới hái đem về tặng cho Nam Cung Tử Tuyết<color>";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
	end
-----------------------
function tbGMCard:NhanVuKhiThanThanh()
local szMsg = "<color=cyan>"..me.szName.."<color>"; 
local tbOpt = { 
{"Vũ Khí <color=yellow>Thiếu Lâm<color><color>",self.VuKhiThieuLamTest,self};
{"Vũ Khí <color=yellow>Thiên Vương<color><color>",self.VuKhiThienVuongTest,self};
{"Vũ Khí <color=yellow>Đường Môn<color><color>",self.VuKhiDuongMonTest,self};
{"Vũ Khí <color=yellow>Ngũ Độc<color><color>",self.VuKhiNguDocTest,self};
{"Vũ Khí <color=yellow>Minh Giáo<color><color>",self.VuKhiMinhGiaoTest,self};
{"Vũ Khí <color=yellow>Đoàn Thị<color><color>",self.VuKhiDoanThiTest,self};
{"Vũ Khí <color=yellow>Thúy Yên<color><color>",self.VuKhiThuyYenTest,self};
{"Vũ Khí <color=yellow>Nga Mi<color><color>",self.VuKhiNgaMiTest,self};
{"Vũ Khí <color=yellow>Cái Bang<color><color>",self.VuKhiCaiBangTest,self};
{"Vũ Khí <color=yellow>Thiên Nhẫn<color><color>",self.VuKhiThienNhanTest,self};
{"Vũ Khí <color=yellow>Côn Lôn<color><color>",self.VuKhiConLonTest,self};
{"Vũ Khí <color=yellow>Võ Đang<color><color>",self.VuKhiVoDangTest,self};

}; 
Dialog:Say(szMsg, tbOpt);
end
function tbGMCard:VuKhiThieuLamTest()
me.AddItem(2,1,1447,10,1,16)
me.AddItem(2,1,1448,10,1,16)

	end
function tbGMCard:VuKhiThienVuongTest()

 me.AddItem(2,1,1449,10,1,16)
me.AddItem(2,1,1450,10,1,16)

	end

function tbGMCard:VuKhiDuongMonTest()

me.AddItem(2,2,1469,10,2,16)
me.AddItem(2,2,1470,10,2,16)

	end

function tbGMCard:VuKhiNguDocTest()

 me.AddItem(2,1,1451,10,2,16)
me.AddItem(2,1,1452,10,2,16)

	end

function tbGMCard:VuKhiMinhGiaoTest()

me.AddItem(2,1,1465,10,2,16)
 me.AddItem(2,1,1466,10,2,16)

	end

function tbGMCard:VuKhiDoanThiTest()
 me.AddItem(2,1,1468,10,3,16)
me.AddItem(2,1,1454,10,3,16)

	end

function tbGMCard:VuKhiThuyYenTest()
 me.AddItem(2,1,1453,10,3,16)
me.AddItem(2,1,1456,10,3,16)

	end

function tbGMCard:VuKhiNgaMiTest()
me.AddItem(2,1,1455,10,3,16)
 me.AddItem(2,1,1467,10,3,16)

	end

function tbGMCard:VuKhiCaiBangTest()
me.AddItem(2,1,1457,10,4,16)
me.AddItem(2,1,1459,10,4,16)

	end

function tbGMCard:VuKhiThienNhanTest()
 me.AddItem(2,1,1458,10,4,16)
me.AddItem(2,1,1460,10,4,16)

	end

function tbGMCard:VuKhiConLonTest()
me.AddItem(2,1,1461,10,5,16)
me.AddItem(2,1,1464,10,5,16)

	end

function tbGMCard:VuKhiVoDangTest()
 me.AddItem(2,1,1462,10,5,16)
 me.AddItem(2,1,1463,10,5,16)

	end
function tbGMCard:TestTuLinh()
	local lhcu = me.GetTask(2123,1);
	local lhmoi = lhcu + 1651000000;
	me.SetTask(2123,1,lhmoi);
	-- me.AddItem(18,1,16,1);
	end
	function tbGMCard:ItemFull_26()
	local tbOpt = {
		-- {"Nhận Luân Hồi Ấn", self.GetWuXingYin1, self},
		{"Cường hóa ngũ hành tương khắc <color=red>1500<color>", self.UpWuXingYin1, self, 1},
		{"Nhược hóa ngũ hành tương khắc <color=red>1500<color>", self.UpWuXingYin1, self, 2},
		{"Ta chưa muốn"},
	}
	Dialog:Say("Bạn muốn làm gì?", tbOpt);
end
function tbGMCard:UpWuXingYin1(nMagicIndex)
	local pSignet = me.GetItem(Item.ROOM_EQUIP,Item.EQUIPPOS_SIGNET, 0);
	if not pSignet then
		Dialog:Say("Thăng cấp thành công.");
		return 0;
	end
	local nLevel 	= pSignet.GetGenInfo(nMagicIndex * 2 - 1, 0);
	if nLevel >= 1500 then
		Dialog:Say("Ấn đã thăng cấp tối đa.");
		return 0;
	end
	nLevel = nLevel + 1500;
	if nLevel > 1500 then
		nLevel = 1500;
	end
	Item:SetSignetMagic(pSignet, nMagicIndex, nLevel, 0);
	Dialog:Say("Chúc mừng bạn Thăng cấp  Ấn Thành công");
end
	function tbGMCard:ItemFull_8()
	local pItem = me.GetEquip(Item.EQUIPPOS_ZHENYUAN_MAIN);
Item:UpgradeZhenYuanNoItem(pItem,1000000,1);
Item:UpgradeZhenYuanNoItem(pItem,1000000,2);
Item:UpgradeZhenYuanNoItem(pItem,1000000,3);
Item:UpgradeZhenYuanNoItem(pItem,1000000,4);
end
function tbGMCard:LoiDinhAnCuongHoa(nMagicIndex)
	local pSignet = me.GetItem(Item.ROOM_EQUIP,Item.EQUIPPOS_SIGNET, 0);
	if not pSignet then
		Dialog:Say("Thăng cấp thành công.");
		return 0;
	end
	local nLevel 	= pSignet.GetGenInfo(nMagicIndex * 2 - 1, 0);
	if nLevel >= 1500 then
		Dialog:Say("Ấn đã thăng cấp tối đa.");
		return 0;
	end
	nLevel = nLevel + 1500;
	if nLevel > 1500 then
		nLevel = 1500;
	end
	Item:SetSignetMagic(pSignet, nMagicIndex, nLevel, 0);

end
function tbGMCard:CuongHoaAn()
	local szMsg = "<color=green>Bạn muốn mua mấy giờ ?<color> \n<color=red>Chú Ý<color> x2 EXP không cộng dồn thời gian nếu bạn mua nhiều lần";
	local tbOpt = 
	{
{"<color=yellow>Cường Hóa [Max 2000]<color>",self.LoiDinhAnCuongHoa,self,1};
{"<color=yellow>Nhược Hóa [Max 2000]<color>",self.LoiDinhAnCuongHoa,self,2};
}
Dialog:Say(szMsg,tbOpt)
end

function tbGMCard:XuaDuoiThuDu()
 	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
		--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
	--KNpc.Add2(20164, 255, 1,1, 1409,3087);
		   -- local msg = "<color=yellow><color=pink>Thú Dữ Làm Loạn<color> Xuất hiện ở Vân Trung Trấn . Chuẩn bị rớt Lệnh bài Bạch Ngân Liên Đấu<color>";
   -- GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	-- KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	-- KDialog.MsgToGlobal(msg);
			   -- local msg = "<color=yellow><color=pink>Thú Dữ Làm Loạn<color> Xuất hiện ở Vân Trung Trấn . Lệnh bài Bạch Ngọc<color>";
   -- GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	-- KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	-- KDialog.MsgToGlobal(msg);
				   -- local msg = "<color=yellow><color=pink>Thú Dữ Làm Loạn<color> Xuất hiện ở Vân Trung Trấn . Bạch Ngọc<color>";
   -- GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	-- KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	-- KDialog.MsgToGlobal(msg);
					   -- local msg = "<color=yellow><color=pink>Thú Dữ Làm Loạn<color> Xuất hiện ở Vân Trung Trấn . Rớt Vũ Khí Hoàng Kim Môn Phái Thiên Nhẫn (Đao)<color>";
   -- GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	-- KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	-- KDialog.MsgToGlobal(msg);
		   -- local msg = "<color=yellow>Các ngươi thật là ỷ mạnh hiếp yếu mà . Hẹn ngày mai trả thù<color>";
   -- GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	-- KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	-- KDialog.MsgToGlobal(msg);
			   -- local msg = "<color=yellow><color=pink>Thú Dữ Làm Loạn<color> quay lại tấn công dân lành Vân Trung Trấn <pic=20><color>- Đợt 2 rớt <color=pink>Bạch Ngọc<color>. Mở";
   -- GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	-- KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	-- KDialog.MsgToGlobal(msg);
				   -- local msg = "<color=yellow><color=pink>Thú Dữ Làm Loạn<color> quay lại tấn công dân lành Vân Trung Trấn <pic=20><color>- Đợt 3 rớt <color=pink>Vũ Khí HKMP Thiên Vương (Thương)+16<color>.";
   -- GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	-- KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	-- KDialog.MsgToGlobal(msg);
					   -- local msg = "<color=yellow><color=pink>Thú Dữ Làm Loạn<color> quay lại tấn công dân lành Vân Trung Trấn <pic=20><color>- Đợt 4 rớt <color=pink>Vũ Khí HKMP Cái Bang (Chưởng)+16<color>.";
   -- GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	-- KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	-- KDialog.MsgToGlobal(msg);
	--------
				   -- local msg = "<color=yellow><color=pink>Dân Lành<color> anh hùng hào kiệt mau về Vân Trung Trấn sử dụng túi tân thủ Vào Trạng Thái Chiến đáu giúp dân với <pic=4><pic=4><pic=4><pic=4><pic=4><color>";
   -- GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	-- KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	-- KDialog.MsgToGlobal(msg);
	--
					   local msg = "<color=pink>Bảo trì server trong 10'. Sau 5' nữa<color>. Mọi người thoát game ";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
	end
	function tbGMCard:GoiNPC()
-- KNpc.Add2(20167, 255, 1,24, 1777,3535);
-- local tbThichTieuNuong = Npc:GetClass("thichtieunuong");
-- tbThichTieuNuong:OnDialog()
	-- local pItem1 = me.AddItem(2,1,1460,10,4,16); -- Đao Hỏa Nội 8x
	-- pItem1.Bind(1);
-- me.SetItemTimeout(pItem1, 1*24*60, 0); -- 2 ngày
me.AddItem(2,1,1459,10,4,16)
	end
		function tbGMCard:XuaDuoiThuDu000()
				   -- local msg = "<color=yellow>Các bạn vào <color=pink>cuulongkiem.net<color> xong vào Diễn Đàn có cái banner ngay đó click vào đóng góp nhé<color> ";
   -- GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	-- KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	-- KDialog.MsgToGlobal(msg);
	-- KNpc.Add2(20166, 255, 1,25, 1630, 3129);
	-- ClearMapNpcWithName(1, "Người Nghèo");
	me.AddStackItem(18,1,25298,1,nil,10)
	end
function tbGMCard:TraoThuong()
local szMsg = "<color=orange><color> "; 
local tbOpt = { 
{"Trao <color=yellow>Hạt Giống Hồng Hoa<color>",self.AskRoleNameCode3,self};
}; 
Dialog:Say(szMsg, tbOpt); 
end
function tbGMCard:AskRoleNameCode3()
 Dialog:AskString("Tên nhân vật", 16, self.OnInputRoleName3, self);
end
function tbGMCard:OnInputRoleName3(szRoleName)
 local nPlayerId = KGCPlayer.GetPlayerIdByName(szRoleName);
 if (not nPlayerId) then
  Dialog:Say("Tên này không tồn tại!", {"Nhập lại", self.AskRoleNameCode3, self}, {"Kết thúc đối thoại"});
  return;
 end
 
 self:ViewPlayerCode3(nPlayerId);
end
function tbGMCard:ViewPlayerCode3(nPlayerId)

local szMsg = "Ta có thể giúp gì cho ngươi";
local tbOpt = {
{"Trao thưởng <color=yellow>Hạt Giống Hồng Hoa<color>", self.ConSoCode3, self, nPlayerId },
{"Kết thúc đối thoại"},
};
Dialog:Say(szMsg, tbOpt);
end
function tbGMCard:ConSoCode3(nPlayerId)
    local pPlayer    = KPlayer.GetPlayerObjById(nPlayerId);
	local nCount = pPlayer.GetJbCoin()
if pPlayer.CountFreeBagCell() < 51 then
		Dialog:Say("Phải Có 51 Ô Trống Trong Túi Hành Trang");
		return 0;
	end

	pPlayer.AddStackItem(18,1,554,4,nil,50)


end

function tbGMCard:EventMoi()
local szMsg = ("111111111111111111")
local tbOpt = {
{"Reload An Xin", self.ReloadAnXin, self}, 
{"Reload Cay Mai", self.ReloadCayMai, self},
{"Reload Than Tai", self.ReloadThanTai, self},
{"Reload Noi Ruong", self.ReloadNoiRuoiu, self},
{"Reload Thich Tieu Nuong", self.ReloadThichTieuNuong, self},
{"Nhan Ngua Tan Thu", self.NhanNgua, self},
}
Dialog:Say(szMsg,tbOpt)
end
function tbGMCard:ReloadAnXin()
DoScript("\\script\\npc\\onglaoanxin.lua");
end
function tbGMCard:ReloadThichTieuNuong()
DoScript("\\script\\npc\\thichtieunuong.lua");
end
function tbGMCard:ReloadCayMai()
DoScript("\\script\\npc\\hoamainammoi.lua");
end
function tbGMCard:ReloadThanTai()
DoScript("\\script\\npc\\thantaibanphuc.lua");
end
function tbGMCard:ReloadNoiRuoiu()
DoScript("\\script\\npc\\noinauruou.lua");
end
function tbGMCard:sukien2013()
local szMsg = (
  	         "<color=yellow>Chuỗi sự kiện 2013<color>\nĐể chi tiết hơn về từng sự kiện quý đồng đạo click vào sự kiện muốn xem"
)			 
local tbOpt = { 
{"Sự Kiện <color=pink>Họa Lại Tranh Tết<color>", self.TranhTet, self}, 
{"Sự Kiện <color=pink>Hái Tử Thủy Tinh<color>", self.Haituthuytinh, self}, 
{"Sự Kiện <color=pink>Ngũ Thần Hạ Phàm<color>", self.NguThanHaPham, self}, 
{"Sự Kiện <color=pink>Chúc Phúc Đầu Năm<color>", self.TTTDoiHT10, self}, 
{"Sự Kiện <color=pink>Tranh Xuân Giáp Tết<color>", self.TTTDoiHT12, self}, 
{"Sự Kiện <color=pink>Kim Rương Bảo Hạp<color>", self.TTTDoiHT12, self}, 
{"Sự Kiện <color=pink>Tranh Đoạt Rương Quý<color>", self.TTTDoiHT12, self},
{"Sự Kiện <color=pink>Trừ Họa Cho Dân<color>", self.TTTDoiHT12, self},
{"Sự Kiện <color=pink>Tiêu Diệt Sâu Bọ<color>", self.TTTDoiHT12, self},
{"Sự Kiện <color=pink>Lễ Bảo An Khang<color>", self.TTTDoiHT12, self},
{"Sự Kiện <color=pink>Pháo Hoa Mừng Xuân<color>", self.TTTDoiHT12, self},
{"Sự Kiện <color=pink>Thần Tài Phát Lộc<color>", self.TTTDoiHT12, self},
{"Sự Kiện <color=pink>Hái Quả Hoàng Kim<color>", self.TTTDoiHT12, self},
{"Sự Kiện <color=pink>Tứ Thần Ấn<color>", self.TTTDoiHT12, self},
{"Sự Kiện <color=pink>Bánh Chưng Năm Mới<color>", self.TTTDoiHT12, self},
{"Sự Kiện <color=pink>Chúc Tết Năm Mới<color>", self.TTTDoiHT12, self},
{"Sự Kiện <color=pink>Nấu Rượu <color>", self.TTTDoiHT12, self},
{"Sự Kiện <color=pink>Luyện Cấp Đoạt Bình Ngọc<color>", self.TTTDoiHT12, self},
{"Sự Kiện <color=pink>Thần Đơn Tăng Công Lực<color>", self.TTTDoiHT12, self},
{"Sự Kiện <color=pink>Lì Xì Chưởng Môn<color>", self.TTTDoiHT12, self},
{"Ta chỉ ghé ngang qua"}, 
}; 
Dialog:Say(szMsg, tbOpt); 
end
function tbGMCard:TranhTet()
local szMsg = ("Sự Kiện: <color=orange>Tranh Tết<color>\n"..
  	         "NPC liên quan: <color=orange>Thầy Đồ<color>\n"..
  	         "Vật Phẩm liên quan: \n<color=orange>Tranh Tết (chưa giám định)<color>,<color=cyan>Tranh 12 con giáp<color>"..
  	         "Cách thức tham gia: Đem 1 Tranh Tết (chưa giám định) + 1 bút lông đến <color=cyan>Thầy Đồ<color> để vẽ lại ra tranh 1 trong 12 con giáp. Thu thập đủ 12 Tranh con giáp đỏi được túi quà mừng xuân."
			 )			 
local tbOpt = { 
{"Tranh Con Giáp <color=yellow>Tý<color>", self.TranhTy, self}, 
{"Tranh Con Giáp <color=yellow>Sửu<color>", self.TranhSuu, self}, 
{"Tranh Con Giáp <color=yellow>Dần<color>", self.TranhDan, self}, 
{"Tranh Con Giáp <color=yellow>Mẹo<color>", self.TranhMeo, self}, 
{"Tranh Con Giáp <color=yellow>Thìn<color>", self.TranhThin, self}, 
{"Tranh Con Giáp <color=yellow>Tị<color>", self.TranhTi, self}, 
{"Tranh Con Giáp <color=yellow>Ngọ<color>", self.TranhNgo, self}, 
{"Tranh Con Giáp <color=yellow>Mùi<color>", self.TranhMui, self}, 
{"Tranh Con Giáp <color=yellow>Thân<color>", self.TranhThan, self}, 
{"Tranh Con Giáp <color=yellow>Dậu<color>", self.TranhDau, self}, 
{"Tranh Con Giáp <color=yellow>Tuất<color>", self.TranhTuat, self}, 
{"Tranh Con Giáp <color=yellow>Hợi<color>", self.TranhHoi, self}, 
{"Nhận <color=yellow>Tranh Tết (Chưa giám định)<color>", self.TranhTet, self}, 
{"Nhận <color=yellow>Bút Lông<color>", self.ButLong, self}, 
{"Ta chỉ ghé ngang qua"}, 
}; 
Dialog:Say(szMsg, tbOpt); 
end
function tbGMCard:NguThanHaPham()
local szMsg = ("Sự Kiện: <color=orange>Ngũ Thần Hạ Phàm<color>\n"..
  	         "NPC liên quan:\n<color=yellow>Kim Thần Hạ Phàm<color>,<color=green>Mộc Thần Hạ Phàm<color>,<color=blue>Thủy Thần Hạ Phàm<color>,<color=red>Hỏa Thần Hạ Phàm<color>,<color=wheat>Thổ Thần Hạ Phàm<color>\n"..
  	         "Thời gian xuất hiện:\n<color=yellow>Kim Thần Hạ Phàm [15h30<color>\n<color=green>Mộc Thần Hạ Phàm<color>\n<color=blue>Thủy Thần Hạ Phàm<color>\n<color=red>Hỏa Thần Hạ Phàm<color>\n<color=wheat>Thổ Thần Hạ Phàm<color>\n"..
  	         "Phần Thưởng : <color=yellow>Kim Thần Lệnh Bài<color>,<color=green>Mộc Thần Lệnh<color>,<color=blue>Thủy Thần Lệnh<color>,<color=red>Hỏa Thần Lệnh<color>,<color=wheat>Thổ Thần Lệnh<color>."
			 )			 
local tbOpt = { 
{"Nhận <color=yellow>200 Kim Thần Lệnh Bài<color>", self.Nhan200KTLB, self}, 
{"Nhận <color=green>200 Mộc Thần Lệnh Bài<color>", self.Nhan200MTLB, self}, 
{"Nhận <color=blue>200 Thủy Thần Lệnh Bài<color>", self.Nhan200TTLB, self}, 
{"Nhận <color=red>200 Hỏa Thần Lệnh Bài<color>", self.Nhan200HTLB, self}, 
{"Nhận <color=wheat>200 Thổ Thần Lệnh Bài<color>", self.Nhan200ThoTLB, self}, 
{"Đổi <color=yellow>Vũ Khí Thần Thánh 130<color>", self.VuKhiThanThanh, self}, 
{"Ta chỉ ghé ngang qua"}, 
}; 
Dialog:Say(szMsg, tbOpt); 
end
function tbGMCard:VuKhiThanThanh()
	local szMsg = "Để đổi được <color=yellow>Vũ Khí Thần Thánh cấp 130<color> cần \n<color=yellow>200 Kim Thần Lệnh<color>\n<color=green>200 Mộc Thần Lệnh<color>\n<color=blue>200 Thủy Thần Lệnh<color>\n<color=red>200 Hỏa Thần Lệnh<color>\n<color=wheat>200 Thổ Thần Lệnh<color>";
	local tbOpt = 
	{
		    {"Vũ Khí <color=yellow>__Thiếu Lâm__<color>",self.VuKhiThieuLam,self};
			{"Vũ Khí <color=yellow>__Thiên Vương__<color>",self.VuKhiThienVuong,self};
			{"Vũ Khí <color=green>__Đường Môn__<color>",self.VuKhiDuongMon,self};
			{"Vũ Khí <color=green>__Ngũ Độc__<color>",self.VuKhiNguDoc,self};
			{"Vũ Khí <color=green>__Minh Giáo__<color>",self.VuKhiMinhGiao,self};
			{"Vũ Khí <color=blue>__Thúy Yên__<color>",self.VuKhiThuyYen,self};
			{"Vũ Khí <color=blue>__Nga Mi__<color>",self.VuKhiNgaMi,self};
			{"Vũ Khí <color=blue>__Đoàn Thị__<color>",self.VuKhiDoanThi,self};
			{"Vũ Khí <color=red>__Cái Bang__<color>",self.VuKhiCaiBang,self};
			{"Vũ Khí <color=red>__Thiên Nhẫn__<color>",self.VuKhiThienNhan,self};
			{"Vũ Khí <color=wheat>__Côn Lôn__<color>",self.VuKhiConLon,self};
			{"Vũ Khí <color=wheat>__Võ Đang__<color>",self.VuKhiVoDang,self};
			}
					Dialog:Say(szMsg, tbOpt);
end	
function tbGMCard:VuKhiThieuLam()
	local tbOpt = 
	{
		    {"<color=yellow>__Thiếu Lâm__<color> Đao",self.VuKhiThieuLamDao,self};
			{"<color=yellow>__Thiếu Lâm__<color> Bổng",self.VuKhiThieuLamBong,self};
			}
Dialog:Say("<color=yellow>Vũ Khí Thần Thánh<color> Thiếu Lâm",tbOpt);
end
function tbGMCard:VuKhiThieuLamDao()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Thiếu Lâm Đao<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
function tbGMCard:VuKhiThieuLamBong()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Thiếu Lâm Bổng<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
----------- Thiên Vương ------------
function tbGMCard:VuKhiThienVuong()
	local tbOpt = 
	{
		    {"<color=yellow>__Thiên Vương__<color> Thương",self.VuKhiThienVuongThuong,self};
			{"<color=yellow>__Thiên Vương__<color> Chùy",self.VuKhiThienVuongChuy,self};
			}
Dialog:Say("<color=yellow>Vũ Khí Thần Thánh<color> Thiên Vương",tbOpt);
end
function tbGMCard:VuKhiThienVuongThuong()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Thiên Vương Thương<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
function tbGMCard:VuKhiThienVuongChuy()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Thiên Vương Chùy<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
-------------- ĐM TT ---------------
function tbGMCard:VuKhiDuongMon()
	local tbOpt = 
	{
		    {"<color=yellow>__Đường Môn__<color> Tụ Tiễn",self.VuKhiDuongMonTuTien,self};
			{"<color=yellow>__Đường Môn__<color> Hãm Tĩnh",self.VuKhiDuongMonHamTinh,self};
			}
Dialog:Say("<color=yellow>Vũ Khí Thần Thánh<color> Đường Môn",tbOpt);
end
function tbGMCard:VuKhiDuongMonTuTien()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Đường Môn Tụ Tiễn<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
function tbGMCard:VuKhiDuongMonHamTinh()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Đường Môn Hãm Tĩnh<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
-------------- Ngũ Độc ---------------
function tbGMCard:VuKhiNguDoc()
	local tbOpt = 
	{
		    {"<color=yellow>__Đường Môn__<color> Tụ Tiễn",self.VuKhiNguDocDao,self};
			{"<color=yellow>__Đường Môn__<color> Hãm Tĩnh",self.VuKhiNguDocChuong,self};
			}
Dialog:Say("<color=yellow>Vũ Khí Thần Thánh<color> Ngũ Độc",tbOpt);
end
function tbGMCard:VuKhiNguDocDao()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Ngũ Độc Đao<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
function tbGMCard:VuKhiNguDocChuong()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Ngũ Độc Chưởng<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
-------------- Minh Giáo ---------------
function tbGMCard:VuKhiMinhGiao()
	local tbOpt = 
	{
		    {"<color=yellow>__Minh Giáo__<color> Kiếm",self.VuKhiMinhGiaoKiem,self};
			{"<color=yellow>__Minh Giáo__<color> Chùy",self.VuKhiMinhGiaoChuy,self};
			}
Dialog:Say("<color=yellow>Vũ Khí Thần Thánh<color> Minh Giáo",tbOpt);
end
function tbGMCard:VuKhiMinhGiaoKiem()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Minh Giáo Kiếm<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
function tbGMCard:VuKhiMinhGiaoChuy()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Minh Giáo Chùy<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
-------------- Thúy Yên ---------------
function tbGMCard:VuKhiThuyYen()
	local tbOpt = 
	{
		    {"<color=yellow>__Thúy Yên__<color> Đao",self.VuKhiThuyYenDao,self};
			{"<color=yellow>__Thúy Yên__<color> Kiếm",self.VuKhiThuyYenKiem,self};
			}
Dialog:Say("<color=yellow>Vũ Khí Thần Thánh<color> Thúy Yên",tbOpt);
end
function tbGMCard:VuKhiThuyYenDao()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Thúy Yên<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
function tbGMCard:VuKhiThuyYenKiem()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Thúy Yên Kiếm<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
-------------- Nga Mi ---------------
function tbGMCard:VuKhiNgaMi()
	local tbOpt = 
	{
		    {"<color=yellow>__Nga Mi__<color> Kiếm",self.VuKhiNgaMiKiem,self};
			{"<color=yellow>__Nga Mi__<color> Chưởng",self.VuKhiNgaMiChuong,self};
			}
Dialog:Say("<color=yellow>Vũ Khí Thần Thánh<color> Nga Mi",tbOpt);
end
function tbGMCard:VuKhiNgaMiKiem()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Nga Mi Kiếm<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
function tbGMCard:VuKhiNgaMiChuong()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Nga Mi Chưởng<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
-------------- Đoàn Thị ---------------
function tbGMCard:VuKhiDoanThi()
	local tbOpt = 
	{
		    {"<color=yellow>__Đoàn Thị__<color> Kiếm",self.VuKhiDoanThiKiem,self};
			{"<color=yellow>__Đoàn Thị__<color> Chỉ",self.VuKhiDoanThiChi,self};
			}
Dialog:Say("<color=yellow>Vũ Khí Thần Thánh<color> Đoàn Thị",tbOpt);
end
function tbGMCard:VuKhiDoanThiKiem()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Đoàn Thị Kiếm<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
function tbGMCard:VuKhiDoanThiChi()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Đoàn Thị Chỉ<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
-------------- Cái Bang ---------------
function tbGMCard:VuKhiCaiBang()
	local tbOpt = 
	{
		    {"<color=yellow>__Cái Bang__<color> Chưởng",self.VuKhiCaiBangChuong,self};
			{"<color=yellow>__Cái Bang__<color> Bổng",self.VuKhiCaiBangBong,self};
			}
Dialog:Say("<color=yellow>Vũ Khí Thần Thánh<color> Thiên Nhẫn",tbOpt);
end
function tbGMCard:VuKhiCaiBangChuong()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Cái Bang Chưởng<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
function tbGMCard:VuKhiCaiBangBong()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Cái Bang Bổng<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
-------------- Thiên Nhẫn ---------------
function tbGMCard:VuKhiCaiBang()
	local tbOpt = 
	{
		    {"<color=yellow>__Thiên Nhẫn__<color> Đao",self.VuKhiThienNhanDao,self};
			{"<color=yellow>__Thiên Nhẫn__<color> Kích",self.VuKhiThienNhanKich,self};
			}
Dialog:Say("<color=yellow>Vũ Khí Thần Thánh<color> Thiên Nhẫn",tbOpt);
end
function tbGMCard:VuKhiThienNhanDao()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Thiên Nhẫn Đao<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
function tbGMCard:VuKhiThienNhanKich()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Thiên Nhẫn Kích<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
-------------- Côn Lôn ---------------
function tbGMCard:VuKhiCaiBang()
	local tbOpt = 
	{
		    {"<color=yellow>__Côn Lôn__<color> Đao",self.VuKhiConLonDao,self};
			{"<color=yellow>__Côn Lôn__<color> Kiếm",self.VuKhiConLonKiem,self};
			}
Dialog:Say("<color=yellow>Vũ Khí Thần Thánh<color> Côn Lôn",tbOpt);
end
function tbGMCard:VuKhiConLonDao()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Côn Lôn Đao<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
function tbGMCard:VuKhiConLonKiem()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Côn Lôn Kiếm<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
-------------- Võ Đang ---------------
function tbGMCard:VuKhiCaiBang()
	local tbOpt = 
	{
		    {"<color=yellow>__Võ Đang__<color> Kiếm",self.VuKhiVoDangKiem,self};
			{"<color=yellow>__Võ Đang__<color> Khí",self.VuKhiVoDangKhi,self};
			}
Dialog:Say("<color=yellow>Vũ Khí Thần Thánh<color> Võ Đang",tbOpt);
end
function tbGMCard:VuKhiVoDangKiem()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Võ Đang Kiếm<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
function tbGMCard:VuKhiVoDangKhi()	
local tbItemId	= {18,1,25197,1,0,0}; -- Kim Thần Lệnh
local tbItemId1	= {18,1,25198,1,0,0}; -- Mộc Thần Lệnh
local tbItemId2	= {18,1,25199,1,0,0}; -- Thủy Thần Lệnh
local tbItemId3	= {18,1,25200,1,0,0}; -- Hỏa Thần Lệnh
local tbItemId4	= {18,1,25201,1,0,0}; -- Thổ Thần Lệnh
local nCount = me.GetItemCountInBags(18,1,25197,1); -- Kim Thần Lệnh
local nCount1 = me.GetItemCountInBags(18,1,25198,1); -- Mộc Thần Lệnh
local nCount2 = me.GetItemCountInBags(18,1,25199,1); -- Thủy Thần Lệnh
local nCount3 = me.GetItemCountInBags(18,1,25200,1); -- Hỏa Thần Lệnh
local nCount4 = me.GetItemCountInBags(18,1,25201,1); -- Thổ Thần Lệnh
if nCount < 200 or nCount1 < 200 or nCount2 < 200 or nCount3 < 200 or nCount4 < 200 then
Dialog:Say("Cần <color=yellow>200 Lệnh Thần Lệnh<color> mỗi loại")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>Vũ Khí Võ Đang Khí<color><color>")
	Task:DelItem(me, tbItemId, 200);
	Task:DelItem(me, tbItemId1, 200);
	Task:DelItem(me, tbItemId2, 200);
	Task:DelItem(me, tbItemId3, 200);
	Task:DelItem(me, tbItemId4, 200);
	end
function tbGMCard:Nhan200KTLB()
local i = 1     
while i<=200 do
me.AddItem(18,1,25197,1); -- Kim Thần Lệnh Bài
i=i+1
end
end
function tbGMCard:Nhan200MTLB()
local i = 1     
while i<=200 do
me.AddItem(18,1,25198,1); -- Mộc Thần Lệnh Bài
i=i+1
end
end
function tbGMCard:Nhan200TTLB()
local i = 1     
while i<=200 do
me.AddItem(18,1,25199,1); -- Thủy Thần Lệnh Bài
i=i+1
end
end
function tbGMCard:Nhan200HTLB()
local i = 1     
while i<=200 do
me.AddItem(18,1,25200,1); -- Hỏa Thần Lệnh Bài
i=i+1
end
end
function tbGMCard:Nhan200ThoTLB()
local i = 1     
while i<=200 do
me.AddItem(18,1,25201,1); -- Thổ Thần Lệnh Bài
i=i+1
end
end
---------------
function tbGMCard:Haituthuytinh()
local szMsg = ("Sự Kiện: <color=orange>Hái Tử Thủy Tinh<color>\n"..
  	         "NPC liên quan: <color=orange>Tử Thủy Tinh<color>\n"..
  	         "Thời gian xuất hiện: <color=orange>Vào lúc:<color> và <color=orange>Tại:<color>\n"..
  	         "Phần Thưởng khi hái: <color=orange>1 Tử Thủy Tinh<color> và <color=orange>100tr Kinh Nghiệm<color>."
)			 
local tbOpt = { 
{"Nhận <color=yellow>500 Tử Thủy Tinh<color>", self.Nhan500TTT, self}, 
{"10 Tử Thủy Tinh = 1 Huyền Tinh 8", self.TTTDoiHT8, self}, 
{"50 Tử Thủy Tinh = 1 Huyền Tinh 10", self.TTTDoiHT10, self}, 
{"100 Tử Thủy Tinh = 1 Huyền Tinh 12", self.TTTDoiHT12, self}, 
{"Ta chỉ ghé ngang qua"}, 
}; 
Dialog:Say(szMsg, tbOpt); 
end
function tbGMCard:Nhan500TTT()
local i = 1     
while i<=500 do
me.AddItem(18,1,25216,1); -- Tử Thủy Tinh
i=i+1
end
end
function tbGMCard:TTTDoiHT8()
local tbItemId2	= {18,1,25216,1,0,0}; -- Tử Thủy Tinh
local nCount1 = me.GetItemCountInBags(18,1,25216,1); -- Tử Thủy Tinh
if nCount1 < 10 then
Dialog:Say("Cần <color=yellow>10 Tử Thủy Tinh<color>")
return 0;
end
me.AddItem(18,1,1,8);
me.Msg("<color=yellow>Đổi thành công <color=pink>1 Huyền Tinh 8<color><color>")
	Task:DelItem(me, tbItemId2, 10);
end
function tbGMCard:TTTDoiHT10()
local tbItemId2	= {18,1,25216,1,0,0}; -- Tử Thủy Tinh
local nCount1 = me.GetItemCountInBags(18,1,25216,1); -- Tử Thủy Tinh
if nCount1 < 50 then
Dialog:Say("Cần <color=yellow>40 Tử Thủy Tinh<color>")
return 0;
end
me.AddItem(18,1,1,10);
me.Msg("<color=yellow>Đổi thành công <color=pink>1 Huyền Tinh 10<color><color>")
	Task:DelItem(me, tbItemId2, 50);
end
function tbGMCard:TTTDoiHT12()
local tbItemId2	= {18,1,25216,1,0,0}; -- Tử Thủy Tinh
local nCount1 = me.GetItemCountInBags(18,1,25216,1); -- Tử Thủy Tinh
if nCount1 < 100 then
Dialog:Say("Cần <color=yellow>10 Tử Thủy Tinh<color>")
return 0;
end
me.AddItem(18,1,1,12);
me.Msg("<color=yellow>Đổi thành công <color=pink>1 Huyền Tinh 10<color><color>")
	Task:DelItem(me, tbItemId2, 100);
end
---------
function tbGMCard:cxzbncas()
-- local nMapId, nPosX, nPosY = me.GetWorldPos();
	-- KNpc.Add2(7237, 255, 1,nMapId, nPosX, nPosY)
	me.AddItem(1,16,22,3);
	me.AddItem(1,16,23,3);
	me.AddItem(1,16,24,3);
	me.AddItem(1,16,25,3);
end
function tbGMCard:TestBossMoi()
local nMapId, nPosX, nPosY = me.GetWorldPos();
	-- KNpc.Add2(20148, 255, 1,nMapId, nPosX, nPosY)
	-- KNpc.Add2(20149, 255, 2, nMapId, nPosX, nPosY)
	-- KNpc.Add2(20150, 255, 3,nMapId, nPosX, nPosY)
	-- KNpc.Add2(20151, 255, 4, nMapId, nPosX, nPosY)
	KNpc.Add2(20152, 255, 5, nMapId, nPosX, nPosY)
	end
function tbGMCard:TrangBi9x()
	local tbHoTro90 = Item:GetClass("tuiquahotrotanthu9x")

	tbHoTro90:OnUse()
		DoScript("\\script\\TuiQuaHoTroTanThu9x.lua");

	end
function tbGMCard:TienDuLong()
      local i = 1     
while i<=5000 do
me.AddItem(18,1,553,1)
       i=i+1;
end
end
function tbGMCard:CuongHoaQuanAn() 
local szMsg = "Xin chào ! <color=green>" .. me.szName .. "<color>"; 
local tbOpt = {  
{"<color=orange>Cường Hóa Ấn<color>", self.NangCapLenThanThuVP, self,1},
-- {"<color=yellow>Ta muốn cường hóa Phiên Vũ<color>", self.ChangeItemThanhVienVIP, self, 1},
{"Để Ta Suy Nghỉ"}, 
}; 
Dialog:Say(szMsg, tbOpt); 
end 
function tbGMCard:NangCapLenThanThuVP(nLevel) 
    local szContent = string.format("<color=yellow>Chỉ được đặt vào<color><color=cyan>\nHuyền Vũ Ấn\nChu Tước Ấn\nThanh Long Ấn\nBạch Hổ Ấn\nNgọc Tỷ Ấn\nLôi Đình Ấn<color> "); 
    Dialog:OpenGift(szContent, nil, {tbGMCard.OnOpenGiftOkThanhVienVip, tbGMCard, nLevel}); 
end 
function tbGMCard:OnOpenGiftOkThanhVienVip(nLevel, tbItemObj) 
    --Vật phẩm cường hóa 6 loại ấn -- 
    local huyenvuan ="1,16,16,2"; 
    local bachhoan ="1,16,17,2";
    local chutuocan ="1,16,18,2";
    local thanhlongan ="1,16,19,2";
    local ngoctyan ="1,16,20,2";	
	local loidinhan ="1,16,21,2";	
    --Đếm số lượng nguyên liệu 
      local nCount = 0; 
     for i = 1, #tbItemObj do 
         nCount = nCount + tbItemObj[i][1].nCount; 
     end 
    --Check đúng 1 Ấn -- 
    if nCount ~= 1 then 
        Dialog:Say("<color=pink>Chú ý : <color>Mỗi lần chỉ được đặt vào \n<color=yellow>1 Loại Ấn<color>", {"Ta biết rồi !"}); 
         return 0; 
     end 
    --Check có phải là 1 trong 6 Ấn không -- 
    for i = 1, #tbItemObj do 
        local pItem = tbItemObj[i][1]; 
        local szKey = string.format("%s,%s,%s,%s",pItem.nGenre,pItem.nDetail,pItem.nParticular,pItem.nLevel); 
        if (szKey ~= huyenvuan) and (szKey ~= bachhoan) and (szKey ~= chutuocan) and (szKey ~= thanhlongan) and (szKey ~= ngoctyan) and (szKey ~= loidinhan) then 
            Dialog:Say("<color=red>Chú Ý:<color> Đây không phải \n<color=yellow>1 trong 6 loại ấn<color>", {"Xin lỗi ! Ta Nhầm !"}); 
            return 0; 
        end 
if (szKey == huyenvuan) then 
local szMsg = "<color=cyan>Huyền Vũ Ấn<color>\nCường Hóa <color=yellow>tối đa 1000<color>\nNhược Hóa <color=yellow>tối đa 1000<color>\nMỗi lần cường hóa tiêu hao <color=yellow>2000 Tiền Du Long<color>"; 
local tbOpt = {
{"<color=yellow>Cường Hóa [Max 1000]<color>",self.HuyenVuAnCuongHoa,self,1};
{"<color=yellow>Nhược Hóa [Max 1000]<color>",self.HuyenVuAnCuongHoa,self,2};
}; 
Dialog:Say(szMsg, tbOpt); 
end 
-----------
if (szKey == bachhoan) then 
local szMsg = "<color=cyan>Bạch Hổ Ấn<color>\nCường Hóa <color=yellow>tối đa 1200<color>\nNhược Hóa <color=yellow>tối đa 1200<color>\nMỗi lần cường hóa tiêu hao <color=yellow>2000 Tiền Du Long<color>"; 
local tbOpt = {
{"<color=yellow>Cường Hóa [Max 1200]<color>",self.BachHoAnCuongHoa,self,1};
{"<color=yellow>Nhược Hóa [Max 1200]<color>",self.BachHoAnCuongHoa,self,2};
}; 
Dialog:Say(szMsg, tbOpt); 
end 
-----------		
if (szKey == chutuocan) then 
local szMsg = "<color=cyan>Chu Tước Ấn<color>\nCường Hóa <color=yellow>tối đa 1400<color>\nNhược Hóa <color=yellow>tối đa 1400<color>\nMỗi lần cường hóa tiêu hao <color=yellow>2000 Tiền Du Long<color>"; 
local tbOpt = {
{"<color=yellow>Cường Hóa [Max 1400]<color>",self.ChuTuocAnCuongHoa,self,1};
{"<color=yellow>Nhược Hóa [Max 1400]<color>",self.ChuTuocAnCuongHoa,self,2};
}; 
Dialog:Say(szMsg, tbOpt); 
end 
-----------		
if (szKey == thanhlongan) then 
local szMsg = "<color=cyan>Thanh Long Ấn<color>\nCường Hóa <color=yellow>tối đa 1600<color>\nNhược Hóa <color=yellow>tối đa 1600<color>\nMỗi lần cường hóa tiêu hao <color=yellow>2000 Tiền Du Long<color>"; 
local tbOpt = {
{"<color=yellow>Cường Hóa [Max 1600]<color>",self.ThanhLongAnCuongHoa,self,1};
{"<color=yellow>Nhược Hóa [Max 1600]<color>",self.ThanhLongAnCuongHoa,self,2};
}; 
Dialog:Say(szMsg, tbOpt); 
end 
-----------
if (szKey == ngoctyan) then 
local szMsg = "<color=cyan>Ngọc Tỷ Ấn<color>\nCường Hóa <color=yellow>tối đa 1800<color>\nNhược Hóa <color=yellow>tối đa 1800<color>\nMỗi lần cường hóa tiêu hao <color=yellow>2000 Tiền Du Long<color>"; 
local tbOpt = {
{"<color=yellow>Cường Hóa [Max 1800]<color>",self.NgocTyAnCuongHoa,self,1};
{"<color=yellow>Nhược Hóa [Max 1800]<color>",self.NgocTyAnCuongHoa,self,2};
}; 
Dialog:Say(szMsg, tbOpt); 
end 
-----------
if (szKey == loidinhan) then 
local szMsg = "<color=cyan>Lôi Đình Ấn<color>\nCường Hóa <color=yellow>tối đa 2000<color>\nNhược Hóa <color=yellow>tối đa 2000<color>\nMỗi lần cường hóa tiêu hao <color=yellow>2000 Tiền Du Long<color>"; 
local tbOpt = {
{"<color=yellow>Cường Hóa [Max 2000]<color>",self.LoiDinhAnCuongHoa,self,1};
{"<color=yellow>Nhược Hóa [Max 2000]<color>",self.LoiDinhAnCuongHoa,self,2};
}; 
Dialog:Say(szMsg, tbOpt); 
end 
end
end
function tbGMCard:HuyenVuAnCuongHoa(nMagicIndex)
local tbItem	= {18,1,553,1,0,0};
local nCount = me.GetItemCountInBags(18,1,553,1);
if nCount < 2000 then
Dialog:Say("Cần thêm <color=yellow>2000 Tiền Du Long<color> mới thăng cấp <color=yellow>Huyền Vũ Ấn<color> được.")
return 
end
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
	me.Msg("Chúc mừng <color=cyan>"..me.szName.."<color> thăng cấp <color=yellow>Huyền Vũ Ấn<color> thành công. Sức mạnh tăng đáng kể !");
				Task:DelItem(me, tbItem, 2000);

end
--
function tbGMCard:BachHoAnCuongHoa(nMagicIndex)
local tbItem	= {18,1,553,1,0,0};
local nCount = me.GetItemCountInBags(18,1,553,1);
if nCount < 2000 then
Dialog:Say("Cần thêm <color=yellow>2000 Tiền Du Long<color> mới thăng cấp <color=yellow>Bạch Hổ Ấn<color> được.")
return 
end
	local pSignet = me.GetItem(Item.ROOM_EQUIP,Item.EQUIPPOS_SIGNET, 0);
	if not pSignet then
		Dialog:Say("Thăng cấp thành công.");
		return 0;
	end
	local nLevel 	= pSignet.GetGenInfo(nMagicIndex * 2 - 1, 0);
	if nLevel >= 1200 then
		Dialog:Say("Ấn đã thăng cấp tối đa.");
		return 0;
	end
	nLevel = nLevel + 1200;
	if nLevel > 1200 then
		nLevel = 1200;
	end
	Item:SetSignetMagic(pSignet, nMagicIndex, nLevel, 0);
	me.Msg("Chúc mừng <color=cyan>"..me.szName.."<color> thăng cấp <color=yellow>Bạch Hổ Ấn<color> thành công. Sức mạnh tăng đáng kể !");
				Task:DelItem(me, tbItem, 2000);

end
--
function tbGMCard:ChuTuocAnCuongHoa(nMagicIndex)
local tbItem	= {18,1,553,1,0,0};
local nCount = me.GetItemCountInBags(18,1,553,1);
if nCount < 2000 then
Dialog:Say("Cần thêm <color=yellow>2000 Tiền Du Long<color> mới thăng cấp <color=yellow>Chu Tước Ấn<color> được.")
return 
end
	local pSignet = me.GetItem(Item.ROOM_EQUIP,Item.EQUIPPOS_SIGNET, 0);
	if not pSignet then
		Dialog:Say("Thăng cấp thành công.");
		return 0;
	end
	local nLevel 	= pSignet.GetGenInfo(nMagicIndex * 2 - 1, 0);
	if nLevel >= 1400 then
		Dialog:Say("Ấn đã thăng cấp tối đa.");
		return 0;
	end
	nLevel = nLevel + 1400;
	if nLevel > 1400 then
		nLevel = 1400;
	end
	Item:SetSignetMagic(pSignet, nMagicIndex, nLevel, 0);
	me.Msg("Chúc mừng <color=cyan>"..me.szName.."<color> thăng cấp <color=yellow>Chu Tước Ấn<color> thành công. Sức mạnh tăng đáng kể !");
				Task:DelItem(me, tbItem, 2000);

end
--
function tbGMCard:ThanhLongAnCuongHoa(nMagicIndex)
local tbItem	= {18,1,553,1,0,0};
local nCount = me.GetItemCountInBags(18,1,553,1);
if nCount < 2000 then
Dialog:Say("Cần thêm <color=yellow>2000 Tiền Du Long<color> mới thăng cấp <color=yellow>Thanh Long Ấn<color> được.")
return 
end
	local pSignet = me.GetItem(Item.ROOM_EQUIP,Item.EQUIPPOS_SIGNET, 0);
	if not pSignet then
		Dialog:Say("Thăng cấp thành công.");
		return 0;
	end
	local nLevel 	= pSignet.GetGenInfo(nMagicIndex * 2 - 1, 0);
	if nLevel >= 1600 then
		Dialog:Say("Ấn đã thăng cấp tối đa.");
		return 0;
	end
	nLevel = nLevel + 1600;
	if nLevel > 1600 then
		nLevel = 1600;
	end
	Item:SetSignetMagic(pSignet, nMagicIndex, nLevel, 0);
	me.Msg("Chúc mừng <color=cyan>"..me.szName.."<color> thăng cấp <color=yellow>Thanh Long Ấn<color> thành công. Sức mạnh tăng đáng kể !");
				Task:DelItem(me, tbItem, 2000);

end
--
function tbGMCard:NgocTyAnCuongHoa(nMagicIndex)
local tbItem	= {18,1,553,1,0,0};
local nCount = me.GetItemCountInBags(18,1,553,1);
if nCount < 2000 then
Dialog:Say("Cần thêm <color=yellow>2000 Tiền Du Long<color> mới thăng cấp <color=yellow>Ngọc Tỷ Ấn<color> được.")
return 
end
	local pSignet = me.GetItem(Item.ROOM_EQUIP,Item.EQUIPPOS_SIGNET, 0);
	if not pSignet then
		Dialog:Say("Thăng cấp thành công.");
		return 0;
	end
	local nLevel 	= pSignet.GetGenInfo(nMagicIndex * 2 - 1, 0);
	if nLevel >= 1800 then
		Dialog:Say("Ấn đã thăng cấp tối đa.");
		return 0;
	end
	nLevel = nLevel + 1800;
	if nLevel > 1800 then
		nLevel = 1800;
	end
	Item:SetSignetMagic(pSignet, nMagicIndex, nLevel, 0);
	me.Msg("Chúc mừng <color=cyan>"..me.szName.."<color> thăng cấp <color=yellow>Ngọc Tỷ Ấn<color> thành công. Sức mạnh tăng đáng kể !");
				Task:DelItem(me, tbItem, 2000);

end
--
function tbGMCard:LoiDinhAnCuongHoa(nMagicIndex)
local tbItem	= {18,1,553,1,0,0};
local nCount = me.GetItemCountInBags(18,1,553,1);
if nCount < 2000 then
Dialog:Say("Cần thêm <color=yellow>2000 Tiền Du Long<color> mới thăng cấp <color=yellow>Lôi Đình Ấn<color> được.")
return 
end
	local pSignet = me.GetItem(Item.ROOM_EQUIP,Item.EQUIPPOS_SIGNET, 0);
	if not pSignet then
		Dialog:Say("Thăng cấp thành công.");
		return 0;
	end
	local nLevel 	= pSignet.GetGenInfo(nMagicIndex * 2 - 1, 0);
	if nLevel >= 2000 then
		Dialog:Say("Ấn đã thăng cấp tối đa.");
		return 0;
	end
	nLevel = nLevel + 2000;
	if nLevel > 2000 then
		nLevel = 2000;
	end
	Item:SetSignetMagic(pSignet, nMagicIndex, nLevel, 0);
	me.Msg("Chúc mừng <color=cyan>"..me.szName.."<color> thăng cấp <color=yellow>Lôi Đình Ấn<color> thành công. Sức mạnh tăng đáng kể !");
			Task:DelItem(me, tbItem, 2000);
end
-----
------------------
function tbGMCard:NhanVatPhamMoi()
me.AddItem(18,1,25194,1);
me.AddItem(18,1,25195,1);
me.AddItem(18,1,25196,1);
me.AddItem(18,1,25197,1);
me.AddItem(18,1,25198,1);
me.AddItem(18,1,25199,1);
me.AddItem(18,1,25200,1)
me.AddItem(18,1,25201,1);
me.AddItem(18,1,25202,1);
me.AddItem(18,1,25203,1);
me.AddItem(18,1,25204,1);
me.AddItem(18,1,25205,1);
me.AddItem(18,1,25206,1);
me.AddItem(18,1,25207,1);
me.AddItem(18,1,25208,1);
me.AddItem(18,1,25209,1);
me.AddItem(18,1,25210,1);
me.AddItem(18,1,25211,1);
me.AddItem(18,1,25212,1);
me.AddItem(18,1,25213,1);
me.AddItem(18,1,25214,1);
me.AddItem(18,1,25215,1);
me.AddItem(18,1,25216,1);
me.AddItem(18,1,25217,1);
me.AddItem(18,1,25218,1);
me.AddItem(18,1,25219,1);
me.AddItem(18,1,25220,1);
me.AddItem(18,1,25221,1);
me.AddItem(18,1,25222,1);
me.AddItem(18,1,25223,1);
me.AddItem(18,1,25224,1);
me.AddItem(18,1,25225,1);
me.AddItem(18,1,25226,1);
me.AddItem(18,1,25227,1);
me.AddItem(18,1,25228,1);
me.AddItem(18,1,25229,1);
me.AddItem(18,1,25230,1);
me.AddItem(18,1,25231,1);
me.AddItem(18,1,25232,1);
end
function tbGMCard:TestTrangBi()
if me.nFaction == 0 then
Dialog:Say("<color=yellow>Chưa gia nhập môn phái không thể mở<color>")
return 
end
	local tbInfo	= GetPlayerInfoForLadderGC(me.szName);
	if tbInfo.nSex == 0 and (me.nFaction == 2) and (me.nRouteId == 1) then -- Thiên Vương Thương Nam
		local item1 = me.AddItem(2,9,810,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,812,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,410,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,312,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,412,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,316,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,210,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,410,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,211,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,751,10,1,14);
		item10.Bind(1);
			end
	if tbInfo.nSex == 1 and (me.nFaction == 2) and (me.nRouteId == 1) then -- Thiên Vương Thương Nữ
		local item11 = me.AddItem(2,9,820,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,822,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,420,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,322,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,422,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,316,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,210,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,420,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,211,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,751,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 2) and (me.nRouteId == 2) then -- Thiên Vương Chùy Nam
		local item1 = me.AddItem(2,9,810,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,812,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,410,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,312,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,412,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,316,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,210,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,410,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,211,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,761,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 2) and (me.nRouteId == 2) then -- Thiên Vương Chùy Nữ
		local item11 = me.AddItem(2,9,820,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,822,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,420,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,322,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,422,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,316,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,210,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,420,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,211,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,761,10,1,14);
		item20.Bind(1);
		end
		-------------
					if tbInfo.nSex == 0 and (me.nFaction == 1) and (me.nRouteId == 1) then -- Thiếu Lâm Đao
			local item1 = me.AddItem(2,9,830,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,832,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,410,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,312,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,412,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,316,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,210,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,410,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,211,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,731,10,1,14);
		item10.Bind(1);
		end
		if tbInfo.nSex == 0 and (me.nFaction == 1) and (me.nRouteId == 2) then -- Thiếu Lâm Bổng
				local item1 = me.AddItem(2,9,810,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,812,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,410,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,312,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,412,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,316,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,210,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,410,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,211,10,1,14);
		item9.Bind(1)
		local item10 = me.AddItem(2,1,741,10,1,14);
		item10.Bind(1);
		end
		---------------
			if tbInfo.nSex == 0 and (me.nFaction == 3) and (me.nRouteId == 2) then -- ĐMTT Nam
		local item1 = me.AddItem(2,9,850,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,852,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,430,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,332,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,432,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,322,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,220,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,430,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,221,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,2,100,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 3) and (me.nRouteId == 2)then -- ĐMTT Nữ
		local item11 = me.AddItem(2,9,860,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,862,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,440,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,342,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,442,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,322,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,220,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,440,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,221,10,1,14);
		item19.Bind(1);
		local item20 =  me.AddItem(2,2,100,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 3) and (me.nRouteId == 1) then -- ĐMHT Nam
		local item1 = me.AddItem(2,9,850,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,852,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,430,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,332,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,432,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,322,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,220,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,430,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,221,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,2,90,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 3) and (me.nRouteId == 1) then -- ĐMHT Nữ
		local item11 = me.AddItem(2,9,860,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,862,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,440,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,342,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,442,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,322,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,220,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,440,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,221,10,1,14);
		item19.Bind(1);
		local item20 =  me.AddItem(2,2,90,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 4) and (me.nRouteId == 1) then -- 5 Độc Đao Nam
		local item1 = me.AddItem(2,9,850,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,852,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,430,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,332,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,432,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,322,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,220,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,430,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,221,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,771,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1  and (me.nFaction == 4) and (me.nRouteId == 1) then -- 5 Độc Đao Nữ
		local item11 = me.AddItem(2,9,860,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,862,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,440,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,342,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,442,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,322,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,220,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,440,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,221,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,771,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 4) and (me.nRouteId == 2) then -- 5 Độc Chưởng Nam
		local item1 = me.AddItem(2,9,870,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,872,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,430,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,332,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,432,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,322,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,220,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,430,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,221,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,781,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 4) and (me.nRouteId == 2) then -- 5 Độc Chưởng Nữ
		local item11 = me.AddItem(2,9,880,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,882,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,440,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,342,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,442,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,322,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,220,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,440,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,221,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,781,10,1,14);
		item20.Bind(1);
        end
			if tbInfo.nSex == 0 and (me.nFaction == 11) and (me.nRouteId == 2) then -- MGK Nam
		local item1 = me.AddItem(2,9,850,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,852,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,430,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,332,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,432,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,322,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,220,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,430,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,221,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,1001,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 11) and (me.nRouteId == 2) then -- MGK Nữ
		local item11 = me.AddItem(2,9,860,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,862,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,440,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,342,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,442,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,322,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,220,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,440,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,221,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,1001,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 11) and (me.nRouteId == 1) then -- Minh Giáo Chùy Nam
		local item1 = me.AddItem(2,9,850,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,852,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,430,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,332,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,432,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,322,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,220,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,430,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,221,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,991,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 11) and (me.nRouteId == 1) then -- MGC Nữ
		local item11 = me.AddItem(2,9,860,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,862,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,440,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,342,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,442,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,322,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,220,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,440,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,221,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,991,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 12) and (me.nRouteId == 2) then -- ĐTK Nam
		local item1 = me.AddItem(2,9,910,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,912,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,450,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,352,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,452,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,328,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,230,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,450,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,231,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,821,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 12) and (me.nRouteId == 2) then -- ĐTK nữ
		local item11 = me.AddItem(2,9,920,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,922,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,460,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,362,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,462,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,328,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,230,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,460,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,231,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,821,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 12) and (me.nRouteId == 1) then -- ĐTC Nam
		local item1 = me.AddItem(2,9,890,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,892,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,450,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,352,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,452,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,328,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,230,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,450,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,231,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,801,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 12) and (me.nRouteId == 1) then -- ĐTC Nữ
		local item11 = me.AddItem(2,9,900,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,902,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,460,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,362,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,462,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,328,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,230,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,460,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,231,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,801,10,1,14);
		item20.Bind(1);
		end
		if (me.nFaction == 5) and (me.nRouteId == 1) then -- Nga Mi Chưởng
		local item11 = me.AddItem(2,9,920,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,922,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,460,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,362,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,462,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,328,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,230,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,460,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,231,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,811,10,1,14);
		item20.Bind(1);
		end
		if (me.nFaction == 5) and (me.nRouteId == 2) then -- Nga Mi Kiếm
		local item11 = me.AddItem(2,9,920,10,1,14);
		item11.Bind(1)
		local item12 = me.AddItem(2,3,922,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,460,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,362,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,462,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,328,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,230,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,460,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,231,10,1,14);
		item19.Bind(1);
		local item10 = me.AddItem(2,1,821,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 6) and (me.nRouteId == 2) then -- TYD Nam
		local item1 = me.AddItem(2,9,910,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,912,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,450,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,352,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,452,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,328,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,230,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,450,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,231,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,791,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 or (me.nFaction == 6) and (me.nRouteId == 2) then -- TYD Nữ
		local item11 = me.AddItem(2,9,920,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,922,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,460,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,362,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,462,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,328,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,230,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,460,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,231,10,1,14);
		item19.Bind(1);
		local item20 =  me.AddItem(2,1,791,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 6) and (me.nRouteId == 1) then --TYK Nam
		local item1 = me.AddItem(2,9,910,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,912,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,450,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,352,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,452,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,328,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,230,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,450,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,231,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,821,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 6) and (me.nRouteId == 1) then --TYK Nữ
		local item11 = me.AddItem(2,9,920,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,922,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,460,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,362,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,462,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,328,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,230,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,460,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,231,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,821,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 7) and (me.nRouteId == 1) then -- Cái Bang Rồng Nam
		local item1 = me.AddItem(2,9,950,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,952,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,470,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,372,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,472,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,334,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,240,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,470,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,241,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,851,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 7) and (me.nRouteId == 1) then -- Cái Bang Rồng Nữ
		local item11 = me.AddItem(2,9,960,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,962,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,480,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,382,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,482,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,334,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,240,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,480,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,241,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,851,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 7) and (me.nRouteId == 2) then -- Cái Bang Bổng Nam
		local item1 = me.AddItem(2,9,950,10,1,00);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,952,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,470,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,372,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,472,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,334,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,240,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,470,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,241,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,831,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 7) and (me.nRouteId == 2) then -- Cái Bang Bổng Nữ
		local item11 = me.AddItem(2,9,960,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,962,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,480,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,382,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,482,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,334,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,240,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,480,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,241,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,831,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and  (me.nFaction == 8) and (me.nRouteId == 2) then -- Ma Nhẫn Nam
		local item1 = me.AddItem(2,9,950,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,952,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,470,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,372,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,472,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,334,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,240,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,470,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,241,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,861,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 8) and (me.nRouteId == 2) then -- Ma Nhẫn Nữ
		local item11 = me.AddItem(2,9,960,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,962,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,480,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,382,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,482,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,334,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,240,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,480,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,241,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,861,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 8) and (me.nRouteId == 1) then -- Thiên Nhẫn Thương Nam
		local item1 = me.AddItem(2,9,930,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,932,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,470,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,372,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,472,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,334,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,240,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,470,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,241,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,841,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 8) and (me.nRouteId == 1) then -- THiên Nhẫn Kích Nữ
		local item11 = me.AddItem(2,9,940,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,942,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,480,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,382,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,482,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,334,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,240,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,480,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,241,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,841,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 9) and (me.nRouteId == 1) then -- Võ Đang Khí Nam
		local item1 = me.AddItem(2,9,990,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,992,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,490,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,392,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,492,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,340,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,250,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,490,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,251,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,891,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 9) and (me.nRouteId == 1) then -- Võ Đang Khí Nữ
		local item11 = me.AddItem(2,9,1000,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,1002,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,500,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,402,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,502,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,340,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,250,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,500,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,251,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,891,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0  and  (me.nFaction == 9) and (me.nRouteId == 2) then -- Võ đang kiếm nam
		local item1 = me.AddItem(2,9,970,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,972,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,490,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,392,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,492,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,340,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,250,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,490,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,251,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,881,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 9) and (me.nRouteId == 2) then
		local item11 = me.AddItem(2,9,980,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,982,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,500,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,402,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,502,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,340,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,250,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,500,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,251,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,881,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 10) and (me.nRouteId == 2) then -- CLK Nam
		local item1 = me.AddItem(2,9,990,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,992,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,490,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,392,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,492,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,340,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,250,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,490,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,251,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,901,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 10) and (me.nRouteId == 2) then -- CLK Nũ
		local item11 = me.AddItem(2,9,1000,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,1002,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,500,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,402,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,502,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,340,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,250,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,500,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,251,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,901,10,1,14);
		item20.Bind(1);
		end
			if tbInfo.nSex == 0 and (me.nFaction == 10) and (me.nRouteId == 1) then -- CLĐ Nam
		local item1 = me.AddItem(2,9,990,10,1,14);
		item1.Bind(1);
		local item2 = me.AddItem(2,3,992,10,1,14);
		item2.Bind(1);
		local item3 = me.AddItem(2,8,490,10,1,14);
		item3.Bind(1);
		local item4 = me.AddItem(2,10,392,10,1,14);
		item4.Bind(1);
		local item5 = me.AddItem(2,7,492,10,1,14);
		item5.Bind(1);
		local item6 = me.AddItem(2,5,340,10,1,14);
		item6.Bind(1);
		local item7 = me.AddItem(2,4,250,10,1,14);
		item7.Bind(1);
		local item8 = me.AddItem(2,11,490,10,1,14);
		item8.Bind(1);
		local item9 = me.AddItem(2,6,251,10,1,14);
		item9.Bind(1);
		local item10 = me.AddItem(2,1,871,10,1,14);
		item10.Bind(1);
		end
			if tbInfo.nSex == 1 and (me.nFaction == 10) and (me.nRouteId == 1) then -- CLĐ Nữ
		local item11 = me.AddItem(2,9,1000,10,1,14);
		item11.Bind(1);
		local item12 = me.AddItem(2,3,1002,10,1,14);
		item12.Bind(1);
		local item13 = me.AddItem(2,8,500,10,1,14);
		item13.Bind(1);
		local item14 = me.AddItem(2,10,402,10,1,14);
		item14.Bind(1);
		local item15 = me.AddItem(2,7,502,10,1,14);
		item15.Bind(1);
		local item16 = me.AddItem(2,5,340,10,1,14);
		item16.Bind(1);
		local item17 = me.AddItem(2,4,250,10,1,14);
		item17.Bind(1);
		local item18 = me.AddItem(2,11,500,10,1,14);
		item18.Bind(1);
		local item19 = me.AddItem(2,6,251,10,1,14);
		item19.Bind(1);
		local item20 = me.AddItem(2,1,871,10,1,14);
		item20.Bind(1);
		end
end
function tbGMCard:SuperReload()
    -- local nMapId, nPosX, nPosY = me.GetWorldPos();
	-- KNpc.Add2(7185, 100, 0, nMapId, nPosX, nPosY);
me.AddItem(1,16,16,2);
me.AddItem(1,16,17,2);
me.AddItem(1,16,18,2);
me.AddItem(1,16,19,2);
me.AddItem(1,16,20,2);
me.AddItem(1,16,21,2);
end
function tbGMCard:Daocutamthoi()
	local szMsg = "Ta có thể giúp gì cho ngươi";
	local tbOpt = {};
	table.insert(tbOpt , {"Đồ hỗ trợ",  self.dohotro, self});
	table.insert(tbOpt , {"Túi Truyền Tống",  self.tuitruyentong, self});
	--table.insert(tbOpt , {"Túi Kỹ Năng",  self.tuikynang, self});
	table.insert(tbOpt , {"Túi Nhiệm Vụ",  self.tuinhiemvu, self});
	--table.insert(tbOpt , {"Túi Người Chơi",  self.tuinguoichoi, self});
	--table.insert(tbOpt , {"Chiến trường Tống Kim",  self.chtrgtongkim, self});
	table.insert(tbOpt , {"Kết thúc đối thoại"});
	Dialog:Say(szMsg, tbOpt);
end
function tbGMCard:dohotro()
	local tbTmpNpc	= Npc:GetClass("tmpnpc");
	tbTmpNpc:OnDialog();
end
function tbGMCard:tuitruyentong()
	local tbItem	= Item:GetClass("tempitem");
	tbItem:OnTransPak(tbItem.tbMap);
end
function tbGMCard:tuikynang()
	local tbItem	= Item:GetClass("tempitem");
	tbItem:OnSkillPak();
end
function tbGMCard:tuinhiemvu()
	local tbItem	= Item:GetClass("tempitem");
	tbItem:OnTaskItemPak(tbItem.tbItems);
end
function tbGMCard:tuinguoichoi()
	GM.tbPlayer:Main();
end
function tbGMCard:chtrgtongkim()
	Battle:GM();
end
function tbGMCard:DichuyenOnDialog()
 local tbOpt = {
   {"Phượng Tường Phủ", me.NewWorld, 24, 1762, 3536},
   {"Đảo Tẩy Tủy", me.NewWorld, 255, 1652, 3389},
   {"Hoàng Lăng", me.NewWorld, 1536, 1567, 3629},
   {"Vân Lĩnh", self.vanlinh, self},
   
 };
 Dialog:Say("Chọn nơi muốn đến!", tbOpt);
end
function tbGMCard:vanlinh()
	Task.FourfoldMap:ApplyTeamMap(1, 2, 0);
--	Task.FourfoldMap:OnDialog();

end

function tbGMCard:Tuluyen()
 me.AddXiuWeiTime(10000000);
end
function tbGMCard:OnDialog_GM()
 local nIsHide = GM.tbGMRole:IsHide();
 
 local tbOpt = {
  
	{(nIsHide == 1 and "Hủy ẩn thân") or "Bắt đầu ẩn thân", "GM.tbGMRole:SetHide", 1 - nIsHide},
	{"Nhập tên nhân vật", self.AskRoleName, self},
	{"Người chơi bên cạnh", self.AroundPlayer, self},
	{"Thao tác gần đây", self.RecentPlayer, self},
	{"Tự điều chỉnh cấp", self.AdjustLevel, self},
	{"Xếp hạng danh vọng", self.XepHangDanhVong, self},
	{"Reload Script", self.Reload, self},
 
	{"<color=yellow>Phóng viên thi đấu liên server<color>", self.LookWldh, self},
	{"<color=yellow>Hoàng Lăng không giới hạn<color>", self.SuperQinling, self},
	{"Ta chưa cần"},
 };
 
 Dialog:Say("\n  Các bạn vất vả rồi!<pic=28>\n\n     Vì nhân dân phục vụ<pic=98><pic=98><pic=98>", tbOpt);
 
 return 0;
end;
function tbGMCard:SuperQinling()
 me.NewWorld(1536, 1567, 3629);
 me.SetTask(2098, 1, 0);
 me.AddSkillState(1413, 4, 1, 2 * 60 * 60 * Env.GAME_FPS, 1, 1);
end
function tbGMCard:ReloadScript()
-- me.AddItem(18,1,547,3).Bind(1);
	local nRet1 = DoScript("\\script\\item\\class\\gmcard.lua");
	local nRet2 = DoScript("\\script\\misc\\gm_role.lua");
	local nRet3	= DoScript("\\script\\event\\minievent\\newplayergift.lua");
	local nRet3	= DoScript("\\script\\misc\\gm.lua");
	GCExcute({"DoScript", "\\script\\misc\\gm_role.lua"});
	DoScript("\\script\\event\\minievent\\daygift.lua");
	DoScript("\\script\\npc\\longhontuongquan.lua");
	DoScript("\\script\\event\\minievent\\daygift.lua");
DoScript("\\script\\item\\class\\tuiquahotrotanthu9x.lua");
DoScript("\\script\\item\\class\\banhchung.lua");
DoScript("\\script\\item\\class\\binhngocbich.lua");
DoScript("\\script\\baibaoxiang\\item\\jinxiangzi.lua");
DoScript("\\script\\npc\\onglaoanxin.lua");
DoScript("\\script\\npc\\liguan_cs.lua");
DoScript("\\script\\npc\\thunuoi.lua");
DoScript("\\script\\npc\\thichtieunuong.lua");
DoScript("\\script\\npc\\thaydo.lua");
DoScript("\\script\\boss\\qinshihuang\\npc\\npc.lua");
DoScript("\\script\\tong\\tongnpc.lua");
DoScript("\\script\\task\\task.lua");
DoScript("\\script\\task\\wanted\\wanter_npc.lua");
DoScript("\\script\\fightskill\\faction\\wudang.lua");
DoScript("\\script\\npc\\giacatluon.lua");
DoScript("\\script\\npc\\letinhnhan.lua");
DoScript("\\script\\npc\\basesetting.lua");
DoScript("\\script\\npc\\diemconuong.lua");
DoScript("\\script\\domainbattle\\npc\\xuanzhan.lua");
DoScript("\\script\\domainbattle\\domainbattle_npc.lua");
DoScript("\\script\\domainbattle\\domainbattle_gs.lua");
DoScript("\\script\\npc\\noinauruou.lua");
DoScript("\\script\\npc\\hoamainammoi.lua");
	DoScript("\\script\\factionelect\\factionelect_gs.lua");
DoScript("\\script\\event\\minievent\\newplayergift.lua");
DoScript("\\script\\npc\\liguan.lua");
DoScript("\\script\\npc\\caytoxanhtot.lua");
	local szMsg	= "Reloaded!!("..nRet1..","..nRet2..","..nRet3..GetLocalDate(") %Y-%m-%d %H:%M:%S");
	me.Msg(szMsg);
	print(szMsg);
end
function tbGMCard:XepHangDanhVong() 
    GCExcute({"PlayerHonor:UpdateWuLinHonorLadder"}); --võ lâm
    GCExcute({"PlayerHonor:UpdateMoneyHonorLadder"}); --tài phú
    GCExcute({"PlayerHonor:UpdateLeaderHonorLadder"});  --thủ lĩnh
    GCExcute({"PlayerHonor:UpdateSpringHonorLadder"}); 
	GCExcute({"PlayerHonor:UpdateLevelHonorLadder"});
    GCExcute({"PlayerHonor:UpdateXoyoLadder"});  --tiêu dao
    GCExcute({"PlayerHonor:OnSchemeLoadFactionHonorLadder"});  --môn phái
    GCExcute({"PlayerHonor:OnSchemeUpdateSongJinBattleHonorLadder"});  --
    GCExcute({"PlayerHonor:OnSchemeUpdateDragonBoatHonorLadder"}); 
    GCExcute({"PlayerHonor:OnSchemeUpdateWeiwangHonorLadder"}); 
    GCExcute({"PlayerHonor:OnSchemeUpdatePrettygirlHonorLadder"}); 
    GCExcute({"PlayerHonor:OnSchemeUpdateKaimenTaskHonorLadder"}); 
    KGblTask.SCSetDbTaskInt(86, GetTime()); 
    GlobalExcute({"PlayerHonor:OnLadderSorted"});     
    print("Xếp hạng lại danh vọng."); 
end  
function tbGMCard:AskRoleName()
 Dialog:AskString("Tên nhân vật", 16, self.OnInputRoleName, self);
end
function tbGMCard:OnInputRoleName(szRoleName)
 local nPlayerId = KGCPlayer.GetPlayerIdByName(szRoleName);
 if (not nPlayerId) then
  Dialog:Say("Tên này không tồn tại!", {"Nhập lại", self.AskRoleName, self}, {"Kết thúc đối thoại"});
  return;
 end
 
 self:ViewPlayer(nPlayerId);
end
function tbGMCard:ViewPlayer(nPlayerId)
 -- 插入最近玩家列表
 local tbRecentPlayerList = self.tbRecentPlayerList or {};
 self.tbRecentPlayerList  = tbRecentPlayerList;
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
 local szName = KGCPlayer.GetPlayerName(nPlayerId);
 local tbInfo = GetPlayerInfoForLadderGC(szName);
 local tbState = {
  [0]  = "Không online",
  [-1] = "Đang xử lý",
  [-2] = "Auto?",
 };
 local nState = KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_ONLINESERVER);
 local tbText = {
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
 local szMsg = "";
 for _, tb in ipairs(tbText) do
  szMsg = szMsg .. "\n  " .. Lib:StrFillL(tb[1], 6) .. tostring(tb[2]);
 end
 local szButtonColor = (nState > 0 and "") or "<color=gray>";
 local tbOpt = {
  {szButtonColor.."Kéo hắn qua đây", "GM.tbGMRole:CallHimHere", nPlayerId},
  {szButtonColor.."Đưa ta đi", "GM.tbGMRole:SendMeThere", nPlayerId},
  {szButtonColor.."Cho hắn rớt mạng", "GM.tbGMRole:KickHim", nPlayerId},
  {"Đưa vào thiên lao", "GM.tbGMRole:ArrestHim", nPlayerId},
  {"Thoát khỏi thiên lao", "GM.tbGMRole:FreeHim", nPlayerId},
  {"Gửi thư", self.SendMail, self, nPlayerId},
  {"Kết thúc đối thoại"},
 };
 Dialog:Say(szMsg, tbOpt);
end
function tbGMCard:RecentPlayer()
 local tbOpt = {};
 for nIndex, nPlayerId in ipairs(self.tbRecentPlayerList or {}) do
  local szName = KGCPlayer.GetPlayerName(nPlayerId);
  local nState = KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_ONLINESERVER);
  tbOpt[#tbOpt+1] = {((nState > 0 and "<color=green>") or "")..szName, self.ViewPlayer, self, nPlayerId};
 end
 tbOpt[#tbOpt + 1] = {"Kết thúc đối thoại"};
 
 Dialog:Say("Người chơi cần chọn: ", tbOpt);
end
function tbGMCard:AroundPlayer()
 local tbPlayer = {};
 local _, nMyMapX, nMyMapY = me.GetWorldPos();
 for _, pPlayer in ipairs(KPlayer.GetAroundPlayerList(me.nId, 50)) do
  if (pPlayer.szName ~= me.szName) then
   local _, nMapX, nMapY = pPlayer.GetWorldPos();
   local nDistance = (nMapX - nMyMapX) ^ 2 + (nMapY - nMyMapY) ^ 2;
   tbPlayer[#tbPlayer+1] = {nDistance, pPlayer};
  end
 end
 local function fnLess(tb1, tb2)
  return tb1[1] < tb2[1];
 end
 table.sort(tbPlayer, fnLess);
 local tbOpt = {};
 for _, tb in ipairs(tbPlayer) do
  local pPlayer = tb[2];
  tbOpt[#tbOpt+1] = {pPlayer.szName, self.ViewPlayer, self, pPlayer.nId};
  if (#tbOpt >= 8) then
   break;
  end
 end
 tbOpt[#tbOpt + 1] = {"Kết thúc đối thoại"};
 
 Dialog:Say("Người chơi cần chọn: ", tbOpt);
end
function tbGMCard:AdjustLevel()
 local nMaxLevel = GM.tbGMRole:GetMaxAdjustLevel();
 Dialog:AskNumber("Đẳng cấp kỳ vọng (1-"..nMaxLevel..")", nMaxLevel, "GM.tbGMRole:AdjustLevel");
end
function tbGMCard:SendMail(nPlayerId)
 Dialog:AskString("Nội dung thư", 500, "GM.tbGMRole:SendMail", nPlayerId);
end
function tbGMCard:LookWldh()
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
   {"Trở lại Đảo Anh hùng", self.ReturnGlobalServer, self},
   {"Trở lại Lin'an", self.ReturnMyServer, self},
   {"Xem trận chung kết Đơn đấu", self.Wldh_SelectFaction, self},
   {"Xem trận chung kết Song đấu", self.Wldh_SelectVsState, self, 2, 1},
   {"Xem trận chung kết Tam đấu", self.Wldh_SelectVsState, self, 3, 1},
   {"Xem trận chung kết Ngũ đấu", self.Wldh_SelectVsState, self, 4, 1},
   {"Xem trận chung kết Đoàn thể đấu", self.Wldh_SelectBattleVsState, self},
   {"Xin đợi"},
  };
 Dialog:Say(szMsg, tbOpt);
end
function tbGMCard:ReturnMyServer()
 me.GlobalTransfer(29, 1694, 4037);
end
function tbGMCard:Wldh_SelectBattleVsState()
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
function tbGMCard:Wldh_EnterBattleMap(nAreaId, nCamp)
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
function tbGMCard:Wldh_SelectFaction()
 local szMsg = "Chọn môn phái muốn xem?";
 local tbOpt = {};
 for i=1, 12  do
  table.insert(tbOpt, {Player:GetFactionRouteName(i).."Chung kết", self.Wldh_SelectVsState, self, 1, i});
 end
 table.insert(tbOpt, {"Quay lại", self.LookWldh, self});
 table.insert(tbOpt, {"Để ta suy nghĩ"});
 Dialog:Say(szMsg, tbOpt); 
end
function tbGMCard:Wldh_SelectVsState(nType, nReadyId)
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
function tbGMCard:Wldh_SelectPkMap(nType, nReadyId, nMapCount)
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
function tbGMCard:Wldh_EnterPkMap(nType, nReadyId, nAearId)
 local nMapId = Wldh:GetMapMacthTable(nType)[nReadyId];
 local nPosX, nPosY = unpack(Wldh:GetMapPKPosTable(nType)[nAearId]);
 me.NewWorld(nMapId, nPosX, nPosY);
end
function tbGMCard:EnterGlobalServer()
 local nGateWay = Transfer:GetTransferGateway();
 if nGateWay <= 0  then
  nGateWay = tonumber(string.sub(GetGatewayName(), 5, 8));
  me.SetTask(Transfer.tbServerTaskId[1], Transfer.tbServerTaskId[2], nGateWay);
 end
 local nMapId = Wldh.Battle.tbLeagueName[nGateWay] and Wldh.Battle.tbLeagueName[nGateWay][2];
 if not nMapId then
  Dialog:Say("Máy chủ quận của bạn không được phép vào Đảo Anh hùng.");
  return 0;
 end
 local nCanSure = Map:CheckGlobalPlayerCount(nMapId);
 if nCanSure < 0 then
  me.Msg("Con đường phía trước bị chặn。");
  return 0;
 end
 if nCanSure == 0 then
  me.Msg("Địa điểm võ thuật đã hết chỗ, vui lòng thử lại sau。");
  return 0;
 end
 me.GlobalTransfer(nMapId, 1648, 3377);
end
function tbGMCard:ReturnGlobalServer()
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
function tbGMCard:OnDialog_Admin()
-- if me.nLevel < 120 then
-- me.AddFightSkill(163,60); -- 60级梯云纵
-- me.AddFightSkill(91,60);
-- me.AddFightSkill(1417,5);
-- me.AddLevel(120-me.nLevel);
-- me.AddItem(1,12,33,4);
-- me.AddItem(21,9,1,1);
-- me.AddItem(21,9,2,1);
-- me.AddItem(21,9,3,1);
-- end
 
 local szMsg = "Ta có thể giúp gì cho ngươi";
 local tbOpt = {
 		{"Nhận <color=red>Max Chân Nguyên<color>",self.ItemFull_8,self};
		{"Nhận <color=red>Cường hóa max ấn<color>",self.ItemFull_26,self};
		{"Nhận <color=red>Nhận 1tỷ6 Tụ Linh Thánh Linh<color>",self.TestTuLinh,self};
 {"Nhận hỗ trợ tân thủ",self.Point,self},
  {"Nhận vật phẩm hỗ trợ",self.GM,self},
  {"Nhận trang bị",self.TrangBi,self},
  {"Nhận Set Đồ Cuối Đã +16",self.DoCuoi12,self},
  {"Nhận Set Đồ Cuối Đã +16",self.DoCuoi13,self},
  {"Reset Skill",self.Resetskill,self},
   {"Danh Vọng" , self.OnDialog_AddRepute, self},
    {"Đồng Hành" , self.Donghanh, self},
    {"không có gì"},
 };
 Dialog:Say(szMsg, tbOpt);
 end
function tbGMCard:Donghanh()
 local szMsg = "Hãy chọn lấy thứ ngươi muốn đi :";
 local tbOpt=
 {
  {"Nhận Thiệp lụa",self.Thieplua,self},
  {"Nhận Thiệp bạc",self.Thiepbac,self},
  {"Nhận Sách Kinh nghiệm đồng hành",self.Kinhnghiemdonghanh,self},
  {"Nhận Sách Kinh nghiệm đồng hành2",self.Kinhnghiemdonghanh2,self},
  {"Nhận Mật Tịch đồng hành",self.Mattichdonghanh,self},
  {"Nhận Tinh phách",self.Tinhphach,self},
  {"Đồng hành tẩy tủy kinh",self.Donghanhtaytuy,self},
  {"Tiền du long",self.Tiendulong,self},
  {"Nhận Đồng Hành",self.Nhandonghanh,self},
  {"Bồ đề quả",self.Bodequa,self},
    {"không có gì"},
 };
 Dialog:Say(szMsg,tbOpt);
end
function tbGMCard:Bodequa()
me.AddItem(18,1,564,1);
me.AddItem(18,1,564,1);
me.AddItem(18,1,564,1);
me.AddItem(18,1,564,1);
me.AddItem(18,1,564,1);
end
function tbGMCard:Donghanhtaytuy()
me.AddItem(18,1,616,1);
me.AddItem(18,1,617,2);
end
function tbGMCard:Nhandonghanh()
me.AddItem(18,1,666,1);
me.AddItem(18,1,666,2);
me.AddItem(18,1,666,3);
me.AddItem(18,1,666,4);
me.AddItem(18,1,666,5);
me.AddItem(18,1,666,6);
me.AddItem(18,1,666,7);
me.AddItem(18,1,666,8);
end
function tbGMCard:Tiendulong()
for i=1,1000 do
  if me.CountFreeBagCell() > 0 then
   me.AddItem(18,1,553,1);
  else
   break
  end
 end
end
function tbGMCard:Mattichdonghanh()
me.AddItem(18,1,554,1);
me.AddItem(18,1,554,2);
me.AddItem(18,1,554,3);
end
function tbGMCard:Tinhphach()
me.AddItem(18,1,544,1);
me.AddItem(18,1,544,2);
me.AddItem(18,1,544,3);
me.AddItem(18,1,544,4);
end
function tbGMCard:Kinhnghiemdonghanh()
me.AddItem(18,1,543,1);
me.AddItem(18,1,543,1);
me.AddItem(18,1,543,1);
me.AddItem(18,1,543,1);
me.AddItem(18,1,543,1);
me.AddItem(18,1,543,1);
me.AddItem(18,1,543,1);
me.AddItem(18,1,543,1);
me.AddItem(18,1,543,1);
me.AddItem(18,1,543,1);
me.AddItem(18,1,543,1);
me.AddItem(18,1,543,1);
me.AddItem(18,1,543,1);
me.AddItem(18,1,543,1);
me.AddItem(18,1,543,1);
end
function tbGMCard:Kinhnghiemdonghanh2()
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
function tbGMCard:Thieplua()
me.AddItem(18,1,541,1);
me.AddItem(18,1,541,1);
me.AddItem(18,1,541,1);
me.AddItem(18,1,541,1);
me.AddItem(18,1,541,1);
end
function tbGMCard:Thiepbac()
me.AddItem(18,1,541,2);
me.AddItem(18,1,541,2);
me.AddItem(18,1,541,2);
me.AddItem(18,1,541,2);
me.AddItem(18,1,541,2);
end
function tbGMCard:Point()
 local szMsg = "Hãy chọn lấy thứ ngươi muốn đi :";
 local tbOpt=
 {
  {"Lên level 5 lv",self.LenLevel150,self},
  {"Nhận Tiền Bạc Đồng",self.DongKhoa2,self},
  {"Nhận đồng khóa",self.DongKhoa,self},
  {"Nhận bạc khóa",self.BacKhoa,self},
  {"Nhận Bạc thường",self.Bacthuong,self},
  {"Nhận Đồng thường",self.Dongthuong,self},
  {"Skill 120 các phái",self.Skill,self},
  {"Point",self.Point1,self},
  {"Skill Point",self.SkilPoint1,self},
  {"Nhận Đồng thường"},
    {"không có gì"},
 };
 Dialog:Say(szMsg,tbOpt);
end
function tbGMCard:DongKhoa2()
me.Earn(500000000,0);
me.AddJbCoin(500000000);
me.AddBindCoin(500000000);
me.AddBindMoney(500000000);
end
function tbGMCard:Bacthuong()
me.Earn(500000000,0);
end
function tbGMCard:Resetskill()
me.ResetFightSkillPoint();
end
function tbGMCard:Point1()
me.AddPotential(1000);
end
function tbGMCard:SkilPoint1()
me.AddFightSkillPoint(100);
end
function tbGMCard:Trancao()
me.AddItem(1,15,19,3);
me.AddItem(1,15,12,3);
me.AddItem(1,15,13,3);
me.AddItem(1,15,14,3);
me.AddItem(1,15,15,3);
me.AddItem(1,15,16,3);
me.AddItem(1,15,17,3);
me.AddItem(1,15,18,3);
end
function tbGMCard:Skill()
local nFaction = me.nFaction;
 if (nFaction == 0) then
  Dialog:Say("Bạn hãy gia nhập phái");
  return;
 end
if (1 == nFaction) then
 me.AddFightSkill(820,60);
 me.AddFightSkill(822,60);
 elseif (2 == nFaction) then
 me.AddFightSkill(824,60);
 me.AddFightSkill(826,60);
 elseif (3 == nFaction) then
 me.AddFightSkill(828,60);
 me.AddFightSkill(830,60);
 elseif (4 == nFaction) then
 me.AddFightSkill(832,60);
 me.AddFightSkill(834,60);
 elseif (5 == nFaction) then
 me.AddFightSkill(836,60);
 me.AddFightSkill(838,60);
 elseif (6 == nFaction) then
 me.AddFightSkill(840,60);
 me.AddFightSkill(842,60);
 elseif (7 == nFaction) then
 me.AddFightSkill(844,60);
 me.AddFightSkill(846,60);
 elseif (8 == nFaction) then
 me.AddFightSkill(848,60);
 me.AddFightSkill(850,60);
 elseif (9 == nFaction) then
 me.AddFightSkill(852,60);
 me.AddFightSkill(854,60);
 elseif (10 == nFaction) then
  me.AddFightSkill(861,60);
 me.AddFightSkill(856,60);
 me.AddFightSkill(858,60);
 elseif (11 == nFaction) then
  me.AddFightSkill(861,60);
 me.AddFightSkill(860,60);
 me.AddFightSkill(862,60);
 elseif (12 == nFaction) then
 me.AddFightSkill(864,60);
 me.AddFightSkill(866,60);
 else
  Dbg:WriteLogEx(Dbg.LOG_INFO, "Hỗ Trợ tân thủ", me.szName, "Bạn chưa gia nhập phái", nFaction);
 end
end
function tbGMCard:Dongthuong()
me.AddJbCoin(500000000);
end
function tbGMCard:LenLevel150()
 me.AddLevel(5);
end
function tbGMCard:DongKhoa()
 me.AddBindCoin(500000000);
end
function tbGMCard:BacKhoa()
 me.AddBindMoney(500000000);
end
function tbGMCard:GM()
 local szMsg = "Danh sách vật phẩm hỗ trợ:";
 local tbOpt = 
 { 
  {"Nhận Luyện hóa đồ",self.MatNa,self},
  {"Nhận Tinh lực",self.TinhLuc,self},
  {"Nhận Hoạt lực",self.HoatLuc,self},
  {"Nhận Huyền tinh",self.HuyenTinh,self},
  {"Nhận Ngũ hành hồn thạch",self.NguHanhHonThach,self},
  {"Nhận Danh vọng",self.Danhvong,self},
  {"Nhận Đồ nhiệm vụ 110",self.nhiemvu110,self},
  {"Nhận Cầu hồn ngọc",self.Cauhon,self},
  {"Nhận New item",self.New,self},
  {"không có gì"},
 };
 Dialog:Say(szMsg,tbOpt);
end
function tbGMCard:OnDialog_Nhiemvu()
local szMsg= "Hãy Lựa chọn";
local tbOpt = {};
  table.insert(tbOpt, {"Danh Vọng Nghĩa Quân" , self.Nghiaquan, self});
  table.insert(tbOpt, {"Danh Vọng Quân Doanh" , self.Quandoanh, self});
  table.insert(tbOpt, {"Danh Vọng Học Tạo đồ" , self.Hoctaodo, self});
  table.insert(tbOpt, {"Ta chỉ ghé ngang qua"});
  Dialog:Say(szMsg, tbOpt);
end
function tbGMCard:Nghiaquan()
  me.AddRepute(1,1,30000);
 end
 function tbGMCard:Quandoanh()
  me.AddRepute(1,2,30000);
 end
 function tbGMCard:Hoctaodo()
  me.AddRepute(1,3,30000);
 end
function tbGMCard:OnDialog_Tongkim()
local szMsg= "Hãy Lựa chọn";
local tbOpt = {};
  table.insert(tbOpt, {"Danh Vọng Dương Châu" , self.Duongchau, self});
  table.insert(tbOpt, {"Danh Vọng Phượng Tường" , self.Phuongtuong, self});
  table.insert(tbOpt, {"Danh Vọng Tương Dương" , self.Tuongduong, self});
  table.insert(tbOpt, {"Ta chỉ ghé ngang qua"});
  Dialog:Say(szMsg, tbOpt);
end
function tbGMCard:Duongchau()
  me.AddRepute(2,1,30000);
 end
function tbGMCard:Phuongtuong()
  me.AddRepute(2,2,30000);
 end
function tbGMCard:Tuongduong()
  me.AddRepute(2,3,30000);
 end
function tbGMCard:OnDialog_Monphai()
local szMsg= "Hãy Lựa chọn";
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
function tbGMCard:Thieulam()
  me.AddRepute(3,1,30000);
 end
 function tbGMCard:ThienVuong()
  me.AddRepute(3,2,30000);
 end
 function tbGMCard:Duongmon()
  me.AddRepute(3,3,30000);
 end
 function tbGMCard:Ngudoc()
  me.AddRepute(3,4,30000);
 end
 function tbGMCard:Ngami()
  me.AddRepute(3,5,30000);
 end
 function tbGMCard:Thuyyen()
  me.AddRepute(3,6,30000);
 end
 function tbGMCard:Caibang()
  me.AddRepute(3,7,30000);
 end
 function tbGMCard:Thiennhan()
  me.AddRepute(3,8,30000);
 end
 function tbGMCard:Vodang()
  me.AddRepute(3,9,30000);
 end
 function tbGMCard:Conlon()
  me.AddRepute(3,10,30000);
 end
 function tbGMCard:Minhgiao()
  me.AddRepute(3,11,30000);
 end
 function tbGMCard:Doanthi()
  me.AddRepute(3,12,30000);
 end
function tbGMCard:Giatoc()
  me.AddRepute(4,1,30000);
 end
 function tbGMCard:OnDialog_Hoatdong()
local szMsg= "Hãy Lựa chọn";
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
function tbGMCard:Bachho()
  me.AddRepute(5,1,30000);
 end
 function tbGMCard:Thinhha2008()
  me.AddRepute(5,2,30000);
 end
 function tbGMCard:Tieudaococ()
  me.AddRepute(5,3,30000);
 end
 function tbGMCard:Chucphuc()
  me.AddRepute(5,4,30000);
 end
 function tbGMCard:Thinhha2010()
  me.AddRepute(5,5,30000);
 end
 function tbGMCard:Ditichhanvu()
  me.AddRepute(5,6,30000);
 end
 function tbGMCard:OnDialog_Volam()
local szMsg= "Hãy Lựa chọn";
local tbOpt = {};
  table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ(Kim)" , self.CaothuKim, self});
  table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ(Mộc)" , self.CaothuMoc, self});
  table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ(Thủy)" , self.CaothuThuy, self});
  table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ(Hỏa)" , self.CaothuHoa, self});
  table.insert(tbOpt, {"Danh Vọng Khiêu Chiến Võ Lâm cao thủ(Thổ)" , self.CaothuTho, self});
  table.insert(tbOpt, {"Ta chỉ ghé ngang qua"});
  Dialog:Say(szMsg, tbOpt);
end
 function tbGMCard:CaothuKim()
  me.AddRepute(6,1,30000);
 end
  function tbGMCard:CaothuMoc()
  me.AddRepute(6,1,30000);
 end
  function tbGMCard:CaothuThuy()
  me.AddRepute(6,1,30000);
 end
  function tbGMCard:CaothuHoa()
  me.AddRepute(6,1,30000);
 end
  function tbGMCard:CaothuTho()
  me.AddRepute(6,1,30000);
 end
function tbGMCard:Liendau()
 me.AddRepute(7,1,30000);
 end
function tbGMCard:Lanhtho()
 me.AddRepute(8,1,30000);
 end
 function tbGMCard:Tanlang()
 me.AddRepute(9,1,30000);
 me.AddRepute(9,2,30000);
 end
function tbGMCard:Doanvien()
 me.AddRepute(10,1,30000);
 end
function tbGMCard:Daihoivolam()
 me.AddRepute(11,1,30000);
 end
function tbGMCard:Liendauserver()
 me.AddRepute(12,1,30000);
 end
function tbGMCard:OnDialog_AddRepute()
local szMsg = "Ta có thể giúp gì cho ngươi";
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
function tbGMCard:New()
me.AddItem(1,25,37,1);
me.AddItem(1,25,38,1);
me.AddItem(1,25,39,1);
me.AddItem(1,25,40,1);
me.AddItem(1,26,37,1);
me.AddItem(1,26,38,1);
me.AddItem(1,26,39,1);
me.AddItem(1,26,40,1);
me.AddItem(1,16,13,2);
me.AddItem(18,1,216,2);
me.AddItem(18,1,216,3);
me.AddItem(18,1,216,4);
me.AddItem(18,1,216,5);
me.AddItem(18,1,237,1);
me.AddItem(18,1,326,1);
me.AddItem(18,1,326,4);
me.AddItem(18,3,1,16);
me.AddItem(18,3,2,16);
me.AddItem(18,3,3,16);
me.AddItem(18,1,567,1);
me.AddItem(18,1,567,2);
me.AddItem(18,1,567,3);
me.AddItem(18,1,567,4);
me.AddItem(18,1,567,5);
me.AddItem(18,1,567,6);
me.AddItem(18,1,567,7);
me.AddItem(18,1,567,8);
me.AddItem(18,1,567,9);
me.AddItem(18,1,567,10);
me.AddItem(18,1,666,9);
me.AddItem(18,1,666,8);
me.AddItem(18,1,666,7);
me.AddItem(18,1,666,6);
me.AddItem(18,1,666,5);
me.AddItem(18,1,666,4);
me.AddItem(18,1,666,3);
me.AddItem(18,1,666,2);
me.AddItem(18,1,666,1);
me.AddItem(1,2,10,713,10);
me.AddItem(1,2,10,714,10);
me.AddItem(1,2,10,715,10);
me.AddItem(1,2,10,716,10);
me.AddItem(1,2,10,717,10);
me.AddItem(1,2,10,718,10);
me.AddItem(1,2,10,719,10);
me.AddItem(1,2,10,720,10);
me.AddItem(1,2,10,721,10);
me.AddItem(1,2,10,722,10);
end
function tbGMCard:Cauhon()
me.AddItem(18,1,146,3);
me.AddItem(18,1,146,3);
me.AddItem(18,1,146,3);
me.AddItem(18,1,146,3);
me.AddItem(18,1,146,3);
end
function tbGMCard:nhiemvu110()
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
me.AddItem(18,1,377,1);
me.AddItem(18,1,565,1);
me.AddItem(5,19,1,1);
me.AddItem(5,20,1,1);
me.AddItem(5,23,1,1);
end
function tbGMCard:Danhvong()
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
function tbGMCard:TinhLuc()
 me.ChangeCurMakePoint(20002000);
end
function tbGMCard:HoatLuc()
 me.ChangeCurGatherPoint(20002000);
end
function tbGMCard:HuyenTinh()
 local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
 local tbOpt =
 {
  {"Huyền tinh 3",self.HuyenTinh3,self},
  {"Huyền tinh 5",self.HuyenTinh5,self},
  {"Huyền tinh 6",self.HuyenTinh6,self},
  {"Huyền tinh 7",self.HuyenTinh7,self},
  {"Huyền tinh 8",self.HuyenTinh8,self},
  {"Huyền tinh 9",self.HuyenTinh9,self},
  {"Huyền tinh 10",self.HuyenTinh10,self},
  {"Huyền tinh 11",self.HuyenTinh11,self},
  {"Huyền tinh 12",self.HuyenTinh12,self},
    {"không có gì"},
 }
 
 Dialog:Say(szMsg,tbOpt);
end
function tbGMCard:NguHanhHonThach()
 for i=1,100 do
  if me.CountFreeBagCell() > 0 then
   me.AddItem(18,1,244,2);
  else
   break
  end
 end
end
function tbGMCard:HuyenTinh3()
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
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
me.AddItem(18,1,1,3);
end
function tbGMCard:HuyenTinh5()
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
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
me.AddItem(18,1,1,5);
end
function tbGMCard:HuyenTinh6()
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
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
me.AddItem(18,1,1,6);
end
function tbGMCard:HuyenTinh7()
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
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
me.AddItem(18,1,1,7);
end
function tbGMCard:HuyenTinh8()
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
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
me.AddItem(18,1,1,8);
end
function tbGMCard:HuyenTinh9()
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
function tbGMCard:HuyenTinh10()
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
function tbGMCard:HuyenTinh11()
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
me.AddItem(18,1,1,11);
end

function tbGMCard:HuyenTinh12()
me.AddItem(18,1,1,12);
me.AddItem(18,1,1,12);
me.AddItem(18,1,1,12);
me.AddItem(18,1,1,12);
me.AddItem(18,1,1,12);
end
function tbGMCard:TrangBi()
 local szMsg = "Hãy chọn lấy thứ mà ngươi muốn :";
 local tbOpt = {
  {"Nhận Quan ấn cấp 8",self.QuanAn8,self},
  {"Nhận Áo vũ uy",self.Vuuy,self},
  {"Nhận Thú cưỡi",self.Thucuoi,self},
  {"Nhận Tẩy tủy",self.Taytuy,self},
  {"Nhận Áo Tần thủy hoàng",self.Thuyhoang,self},
  {"Nhận Hộ uyển - Thủ trạc",self.Baotay,self},
  {"Nhận Nón hoàng kim",self.Non,self},
  {"Nhận Giày hoàng kim",self.Giay,self},
  {"Nhận Lưng hoàng kim",self.Lung,self},
  {"Nhận Ngọc bội",self.Ngocboi,self},
  {"Nhận Nhẫn hoàng kim kim",self.Nhan,self},
  {"Nhận Liên hoàng kim",self.Lien,self},
  {"Nhận Hộ phù hoàng kim",self.Hophu,self},
  {"Cửa hàng Vũ khí TTH",  self.ShopThuyhoang, self},
  {"Nhận Mật tịch cao",self.Mattichcao,self},
  {"Nhận Phi phong vô song",self.PhiPhong,self},
  {"Trận pháp cao",self.Trancao,self},
  {"Ngọc Trúc Mai hoa",self.Ngoctrucmaihoa,self},  
  {"không có gì"},  
 }
 
 Dialog:Say(szMsg,tbOpt);
end
function tbGMCard:Ngoctrucmaihoa()
me.AddItem(17,3,2,6);
me.AddItem(17,3,2,7);
end
function tbGMCard:ShopThuyhoang()
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
function tbGMCard:Mattichcao()
local nFaction = me.nFaction;
 if (nFaction == 0) then
  Dialog:Say("Bạn hãy gia nhập phái");
  return;
 end
 
 if (1 == nFaction) then
 me.AddItem(1,14,1,2);
 me.AddItem(1,14,2,2);
 me.AddItem(1,14,1,3);
 me.AddItem(1,14,2,3);
 elseif (2 == nFaction) then
 me.AddItem(1,14,3,2);
 me.AddItem(1,14,4,2);
 me.AddItem(1,14,3,3);
 me.AddItem(1,14,4,3);
 elseif (3 == nFaction) then
 me.AddItem(1,14,5,2);
 me.AddItem(1,14,6,2);
 me.AddItem(1,14,5,3);
 me.AddItem(1,14,6,3);
 elseif (4 == nFaction) then
 me.AddItem(1,14,7,2);
 me.AddItem(1,14,8,2);
 me.AddItem(1,14,7,3);
 me.AddItem(1,14,8,3);
 elseif (5 == nFaction) then
 me.AddItem(1,14,9,2);
 me.AddItem(1,14,10,2);
 me.AddItem(1,14,9,3);
 me.AddItem(1,14,10,3);
 elseif (6 == nFaction) then
 me.AddItem(1,14,11,2);
 me.AddItem(1,14,12,2);
 me.AddItem(1,14,11,3);
 me.AddItem(1,14,12,3);
 elseif (7 == nFaction) then
 me.AddItem(1,14,13,2);
 me.AddItem(1,14,14,2);
 me.AddItem(1,14,13,3);
 me.AddItem(1,14,14,3);
 elseif (8 == nFaction) then
 me.AddItem(1,14,15,2);
 me.AddItem(1,14,16,2);
 me.AddItem(1,14,15,3);
 me.AddItem(1,14,16,3);
 elseif (9 == nFaction) then
 me.AddItem(1,14,17,2);
 me.AddItem(1,14,18,2);
 me.AddItem(1,14,17,3);
 me.AddItem(1,14,18,3);
 elseif (10 == nFaction) then
 me.AddItem(1,14,19,2);
 me.AddItem(1,14,20,2);
 me.AddItem(1,14,19,3);
 me.AddItem(1,14,20,3);
 elseif (11 == nFaction) then
 me.AddItem(1,14,21,2);
 me.AddItem(1,14,22,2);
 me.AddItem(1,14,21,3);
 me.AddItem(1,14,22,3);
 elseif (12 == nFaction) then
 me.AddItem(1,14,23,2);
 me.AddItem(1,14,24,2);
 me.AddItem(1,14,23,3);
 me.AddItem(1,14,24,3);
 else
  Dbg:WriteLogEx(Dbg.LOG_INFO, "Hỗ Trợ tân thủ", me.szName, "Bạn chưa gia nhập phái", nFaction);
 end
end
function tbGMCard:Taytuy()
 me.AddItem(1,12,24,4);
 me.AddItem(1,12,12,4);
 me.AddItem(1,12,33,4);
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
 me.AddItem(18,1,400,1);
end
 
function tbGMCard:Lung()
me.AddItem(4,8,517,10);
me.AddItem(4,8,518,10);
me.AddItem(4,8,519,10);
me.AddItem(4,8,520,10);
me.AddItem(4,8,521,10);
me.AddItem(4,8,522,10);
me.AddItem(4,8,523,10);
me.AddItem(4,8,524,10);
me.AddItem(4,8,525,10);
me.AddItem(4,8,526,10);
me.AddItem(4,8,527,10);
me.AddItem(4,8,528,10);
me.AddItem(4,8,529,10);
me.AddItem(4,8,530,10);
me.AddItem(4,8,531,10);
me.AddItem(4,8,532,10);
me.AddItem(4,8,533,10);
me.AddItem(4,8,534,10);
me.AddItem(4,8,535,10);
me.AddItem(4,8,536,10);
me.AddItem(4,8,537,10);
me.AddItem(4,8,538,10);
me.AddItem(4,8,539,10);
me.AddItem(4,8,540,10);
me.AddItem(4,8,541,10);
me.AddItem(4,8,542,10);
me.AddItem(4,8,543,10);
me.AddItem(4,8,544,10);
me.AddItem(4,8,545,10);
me.AddItem(4,8,546,10);
me.AddItem(4,8,547,10);
me.AddItem(4,8,548,10);
me.AddItem(4,8,549,10);
me.AddItem(4,8,550,10);
me.AddItem(4,8,551,10);
me.AddItem(4,8,552,10);
me.AddItem(4,8,553,10);
me.AddItem(4,8,554,10);
me.AddItem(4,8,555,10);
me.AddItem(4,8,556,10);
me.AddItem(4,8,459,10);
me.AddItem(4,8,460,10);
me.AddItem(4,8,463,10);
me.AddItem(4,8,464,10);
me.AddItem(4,8,467,10);
me.AddItem(4,8,468,10);
me.AddItem(4,8,471,10);
me.AddItem(4,8,472,10);
me.AddItem(4,8,475,10);
me.AddItem(4,8,476,10);
me.AddItem(4,8,479,10);
me.AddItem(4,8,480,10);
me.AddItem(4,8,483,10);
me.AddItem(4,8,484,10);
me.AddItem(4,8,487,10);
me.AddItem(4,8,488,10);
me.AddItem(4,8,491,10);
me.AddItem(4,8,492,10);
me.AddItem(4,8,495,10);
me.AddItem(4,8,496,10);
me.AddItem(4,8,499,10);
me.AddItem(4,8,500,10);
me.AddItem(4,8,503,10);
me.AddItem(4,8,504,10);
me.AddItem(4,8,507,10);
me.AddItem(4,8,508,10);
me.AddItem(4,8,511,10);
me.AddItem(4,8,512,10);
me.AddItem(4,8,515,10);
me.AddItem(4,8,516,10);
end
function tbGMCard:Giay()
me.AddItem(4,7,31,10);
me.AddItem(4,7,32,10);
me.AddItem(4,7,33,10);
me.AddItem(4,7,34,10);
me.AddItem(4,7,35,10);
me.AddItem(4,7,36,10);
me.AddItem(4,7,37,10);
me.AddItem(4,7,38,10);
me.AddItem(4,7,39,10);
me.AddItem(4,7,40,10);
me.AddItem(4,7,41,10);
me.AddItem(4,7,42,10);
me.AddItem(4,7,43,10);
me.AddItem(4,7,44,10);
me.AddItem(4,7,45,10);
me.AddItem(4,7,46,10);
me.AddItem(4,7,47,10);
me.AddItem(4,7,48,10);
me.AddItem(4,7,49,10);
me.AddItem(4,7,50,10);
end
function tbGMCard:Thuyhoang()
me.AddItem(4,3,233,10);
me.AddItem(4,3,234,10);
me.AddItem(4,3,235,10);
me.AddItem(4,3,236,10);
me.AddItem(4,3,237,10);
me.AddItem(4,3,238,10);
me.AddItem(4,3,239,10);
me.AddItem(4,3,240,10);
me.AddItem(4,3,241,10);
me.AddItem(4,3,242,10);
me.AddItem(4,3,20045,10);
me.AddItem(4,3,20046,10);
me.AddItem(4,3,20047,10);
me.AddItem(4,3,20048,10);
me.AddItem(4,3,20049,10);
me.AddItem(4,3,20050,10);
me.AddItem(4,3,20051,10);
me.AddItem(4,3,20052,10);
me.AddItem(4,3,20053,10);
me.AddItem(4,3,20054,10);
end

function tbGMCard:Non()
me.AddItem(4,9,477,10);
me.AddItem(4,9,478,10);
me.AddItem(4,9,479,10);
me.AddItem(4,9,480,10);
me.AddItem(4,9,481,10);
me.AddItem(4,9,482,10);
me.AddItem(4,9,483,10);
me.AddItem(4,9,484,10);
me.AddItem(4,9,485,10);
me.AddItem(4,9,486,10);
me.AddItem(4,9,487,10);
me.AddItem(4,9,488,10);
me.AddItem(4,9,489,10);
me.AddItem(4,9,490,10);
me.AddItem(4,9,491,10);
me.AddItem(4,9,492,10);
me.AddItem(4,9,493,10);
me.AddItem(4,9,494,10);
me.AddItem(4,9,495,10);
me.AddItem(4,9,496,10);
end
 
function tbGMCard:Hophu()
 me.AddItem(4,6,95,10);
 me.AddItem(4,6,100,10);
 me.AddItem(4,6,105,10);
 me.AddItem(4,6,110,10);
 me.AddItem(4,6,115,10);
 me.AddItem(4,6,20000,10);
 me.AddItem(4,6,20001,10);
 me.AddItem(4,6,20002,10);
 me.AddItem(4,6,20003,10);
 me.AddItem(4,6,457,10);
 me.AddItem(4,6,458,10);
 me.AddItem(4,6,459,10);
 me.AddItem(4,6,460,10);
 me.AddItem(4,6,461,10);
 me.AddItem(4,6,462,10);
 me.AddItem(4,6,463,10);
 me.AddItem(4,6,464,10);
 me.AddItem(4,6,465,10);
 me.AddItem(4,6,466,10);
end
function tbGMCard:MatNa()
 me.AddItem(1,13,92,1); 
 me.AddItem(1,13,94,1); 
 me.AddItem(1,13,18,1); 
 me.AddItem(1,13,19,1);
 me.AddItem(1,13,77,1); 
 me.AddItem(1,13,89,1); 
 me.AddItem(18,1,518,1);
 me.AddItem(18,1,519,1);
 me.AddItem(18,1,520,1);
 me.AddItem(18,2,4,3);
 me.AddItem(18,2,4,2);
 me.AddItem(18,2,4,1);
 me.AddItem(18,2,3,1);
 me.AddItem(18,2,3,2);
 me.AddItem(18,2,3,3);
 me.AddItem(18,2,1,1);
 me.AddItem(18,2,1,2);
 me.AddItem(18,2,1,3);
 me.AddItem(18,1,1305,1);
 me.AddItem(18,1,1305,2);
 me.AddItem(18,1,510,1);
 me.AddItem(18,1,566,1);
 me.AddItem(18,1,541,2);
 me.AddItem(18,1,543,2);
 me.AddItem(18,1,1199,1);
 me.AddItem(18,1,1198,1);
 me.AddItem(18,1,1286,1);
 me.AddItem(1,16,13,2);
 me.AddItem(5,19,1,1);
 me.AddItem(5,20,1,1);
 me.AddItem(5,23,1,1);
 me.AddItem(1,12,28,4);
 me.AddItem(1,12,29,4);
 me.AddItem(18,1,957,1);
 me.AddItem(18,1,957,2);
 me.AddItem(18,1,541,2);
 me.AddItem(18,1,541,1);
 me.AddItem(18,1,544,1);
 me.AddItem(18,1,544,2);
 me.AddItem(18,1,529,7);
 me.AddItem(18,1,529,8);
 me.AddItem(18,1,529,9);
 me.AddItem(18,1,529,1);
 me.AddItem(18,1,529,6);
 me.AddItem(18,1,529,2);
 me.AddItem(18,1,529,3);
 me.AddItem(18,1,529,4);
 me.AddItem(18,1,529,5);
 me.AddItem(21,9,6,1);
 me.AddItem(21,9,4,1);
 me.AddItem(21,8,2,1);
 me.AddItem(22,1,91,1);
end
function tbGMCard:PhiPhong()
local nSeries = me.nSeries;
 if (nSeries == 0) then
  Dialog:Say("Bạn hãy gia nhập phái");
  return;
 end
 
 if (1 == nSeries) then
 local nSex = me.nSex;
  
 if (0 == nSex) then --male
 me.AddItem(1,17,1,10);
 else   --female
  me.AddItem(1,17,2,10);
 end
 elseif (2 == nSeries) then
 local nSex = me.nSex;
  
 if (0 == nSex) then --male
  me.AddItem(1,17,3,10); 
 else   --female
  me.AddItem(1,17,4,10); 
 end
 elseif (3 == nSeries) then
 local nSex = me.nSex;
  
 if (0 == nSex) then --male
 me.AddItem(1,17,5,10); 
 else   --female
 me.AddItem(1,17,6,10); 
 end
 elseif (4 == nSeries) then
  local nSex = me.nSex;
  
 if (0 == nSex) then --male
  me.AddItem(1,17,7,10);
 else   --female
 me.AddItem(1,17,8,10);
 end
 elseif (5 == nSeries) then
  local nSex = me.nSex;
  
 if (0 == nSex) then --male
 me.AddItem(1,17,9,10); 
 else   --female
 me.AddItem(1,17,10,10); 
 end
 else
  Dbg:WriteLogEx(Dbg.LOG_INFO, "Quan Lãnh Thổ", me.szName, "Bạn chưa gia nhập phái", nSeries);
 end
end
function tbGMCard:QuanAn8()
local nSeries = me.nSeries;
 if (nSeries == 0) then
  Dialog:Say("Bạn hãy gia nhập phái");
  return;
 end
 
 if (1 == nSeries) then
 me.AddItem(1,18,1,8);
 me.AddItem(1,18,6,1);
 me.AddItem(1,18,11,1);
 elseif (2 == nSeries) then
 me.AddItem(1,18,2,8);
 me.AddItem(1,18,7,1);
 me.AddItem(1,18,12,1);
 elseif (3 == nSeries) then
 me.AddItem(1,18,3,8);
 me.AddItem(1,18,8,1);
 me.AddItem(1,18,13,1);
 elseif (4 == nSeries) then
 me.AddItem(1,18,4,8);
 me.AddItem(1,18,9,1);
 me.AddItem(1,18,14,1);
 elseif (5 == nSeries) then
 me.AddItem(1,18,5,8);
 me.AddItem(1,18,10,1);
 me.AddItem(1,18,15,1);
 else
  Dbg:WriteLogEx(Dbg.LOG_INFO, "Quan Lãnh Thổ", me.szName, "Bạn chưa gia nhập phái", nSeries);
 end
end
function tbGMCard:Lien()
 me.AddItem(4,5,20085,10);
 me.AddItem(4,5,20086,10);
 me.AddItem(4,5,20087,10);
 me.AddItem(4,5,20088,10);
 me.AddItem(4,5,20089,10);
 me.AddItem(4,5,20090,10);
 me.AddItem(4,5,20091,10);
 me.AddItem(4,5,20092,10);
 me.AddItem(4,5,20093,10);
 me.AddItem(4,5,20094,10);
 me.AddItem(4,5,457,10);
 me.AddItem(4,5,458,10);
 me.AddItem(4,5,459,10);
 me.AddItem(4,5,460,10);
 me.AddItem(4,5,461,10);
 me.AddItem(4,5,462,10);
 me.AddItem(4,5,463,10);
 me.AddItem(4,5,464,10);
 me.AddItem(4,5,465,10);
 me.AddItem(4,5,466,10);
end
function tbGMCard:Thucuoi()
 me.AddItem(1,12,38,4);
 me.AddItem(1,12,39,4);
 me.AddItem(1,12,40,4);
 me.AddItem(1,12,41,4);
 me.AddItem(1,12,43,4);
 me.AddItem(1,12,44,4);
 me.AddItem(1,12,45,4);
 me.AddItem(1,12,46,4);
 me.AddItem(18,1,1285,1);
 me.AddItem(18,1,1285,2);
 me.AddItem(18,1,1285,3);
 me.AddItem(18,1,1285,4);
 me.AddItem(18,1,1285,5);
 me.AddItem(18,1,1285,6);
 me.AddItem(1,12,24,4);
 me.AddItem(1,12,25,4);
 me.AddItem(1,12,26,4);
 me.AddItem(1,12,27,4);
 me.AddItem(1,12,28,4);
 me.AddItem(1,12,29,4);
 me.AddItem(1,12,30,4);
 me.AddItem(1,12,31,4);
 me.AddItem(1,12,32,4);
 me.AddItem(1,12,33,4);
 me.AddItem(1,12,34,4);
 me.AddItem(1,12,35,4);
 me.AddItem(1,12,36,4);
 me.AddItem(1,12,37,4);
 me.AddItem(1,12,38,4);
 me.AddItem(1,12,39,4);
 me.AddItem(1,12,40,4);
 me.AddItem(1,12,41,4);
 me.AddItem(1,12,46,4);
 me.AddItem(1,12,47,4);
 me.AddItem(1,12,48,4);
 me.AddItem(1,12,2000,4);
 me.AddItem(1,12,20001,4);
 me.AddGeneralEquip(12,25,4);
 me.AddGeneralEquip(12,26,4);
 me.AddGeneralEquip(12,27,4);
 me.AddGeneralEquip(12,33,4);
 me.AddGeneralEquip(12,34,4);
end

function tbGMCard:Vuuy()
 me.AddItem(4,3,143,10);
 me.AddItem(4,3,145,10);
 me.AddItem(4,3,146,10);
 me.AddItem(4,3,147,10);
 me.AddItem(4,3,148,10);
 me.AddItem(4,3,149,10);
 me.AddItem(4,3,150,10);
 me.AddItem(4,3,151,10);
 me.AddItem(4,3,152,10);
 me.AddItem(4,3,153,10);
 me.AddItem(4,3,154,10);
 me.AddItem(4,3,155,10);
 me.AddItem(4,3,156,10);
 me.AddItem(4,3,157,10);
 me.AddItem(4,3,158,10);
 me.AddItem(4,3,159,10);
 me.AddItem(4,3,160,10);
 me.AddItem(4,3,161,10);
 me.AddItem(4,3,162,10);
end

function tbGMCard:Nhan()
 me.AddItem(4,4,444,10);
 me.AddItem(4,4,445,10);
 me.AddItem(4,4,446,10);
 me.AddItem(4,4,447,10);
 me.AddItem(4,4,448,10);
 me.AddItem(4,4,449,10);
 me.AddItem(4,4,450,10);
 me.AddItem(4,4,451,10);
 me.AddItem(4,4,452,10);
 me.AddItem(4,4,453,10);
 me.AddItem(4,4,454,10);
 me.AddItem(4,4,455,10);
 me.AddItem(4,4,456,10);
 me.AddItem(4,4,457,10);
 me.AddItem(4,4,458,10);
 me.AddItem(4,4,459,10);
 me.AddItem(4,4,460,10);
 me.AddItem(4,4,461,10);
 me.AddItem(4,4,462,10);
 me.AddItem(4,4,463,10);
end
function tbGMCard:Ngocboi()
 me.AddItem(4,11,20105,10);
 me.AddItem(4,11,20106,10);
 me.AddItem(4,11,20107,10);
 me.AddItem(4,11,20108,10);
 me.AddItem(4,11,20109,10);
 me.AddItem(4,11,20110,10);
 me.AddItem(4,11,20111,10);
 me.AddItem(4,11,20112,10);
 me.AddItem(4,11,20113,10);
 me.AddItem(4,11,20114,10);
 me.AddItem(4,11,81,10);
 me.AddItem(4,11,82,10);
 me.AddItem(4,11,83,10);
 me.AddItem(4,11,84,10);
 me.AddItem(4,11,85,10);
 me.AddItem(4,11,86,10);
 me.AddItem(4,11,87,10);
 me.AddItem(4,11,90,10);
 me.AddItem(4,11,91,10);
 me.AddItem(4,11,92,10);
 me.AddItem(4,11,93,10);
 me.AddItem(4,11,94,10);
 me.AddItem(4,11,95,10);
 me.AddItem(4,11,96,10);
 me.AddItem(4,11,97,10);
 me.AddItem(4,11,98,10);
 me.AddItem(4,11,99,10);
 me.AddItem(4,11,100,10);
end
function tbGMCard:Baotay()
 me.AddItem(4,10,95,10);
 me.AddItem(4,10,96,10);
 me.AddItem(4,10,97,10);
 me.AddItem(4,10,98,10);
 me.AddItem(4,10,99,10);
 me.AddItem(4,10,100,10);
 me.AddItem(4,10,101,10);
 me.AddItem(4,10,102,10);
 me.AddItem(4,10,103,10);
 me.AddItem(4,10,104,10);
 me.AddItem(4,10,105,10);
 me.AddItem(4,10,106,10);
 me.AddItem(4,10,107,10);
 me.AddItem(4,10,108,10);
 me.AddItem(4,10,109,10);
 me.AddItem(4,10,110,10);
 me.AddItem(4,10,111,10);
 me.AddItem(4,10,112,10);
 me.AddItem(4,10,113,10);
 me.AddItem(4,10,114,10);
 me.AddItem(4,10,441,10);
 me.AddItem(4,10,442,10);
 me.AddItem(4,10,443,10);
 me.AddItem(4,10,444,10);
 me.AddItem(4,10,445,10);
 me.AddItem(4,10,446,10);
 me.AddItem(4,10,447,10);
 me.AddItem(4,10,448,10);
 me.AddItem(4,10,449,10);
 me.AddItem(4,10,450,10);
 me.AddItem(4,10,451,10);
 me.AddItem(4,10,452,10);
 me.AddItem(4,10,453,10);
 me.AddItem(4,10,454,10);
 me.AddItem(4,10,455,10);
 me.AddItem(4,10,456,10);
 me.AddItem(4,10,457,10);
 me.AddItem(4,10,459,10);
 me.AddItem(4,10,460,10);
 me.AddItem(4,10,461,10);
 me.AddItem(4,10,462,10);
 me.AddItem(4,10,463,10);
 me.AddItem(4,10,464,10);
 me.AddItem(4,10,465,10);
 me.AddItem(4,10,466,10);
 me.AddItem(4,10,467,10);
 me.AddItem(4,10,468,10);
 me.AddItem(4,10,469,10);
 me.AddItem(4,10,470,10);
 me.AddItem(4,10,471,10);
 me.AddItem(4,10,472,10);
 me.AddItem(4,10,473,10);
 me.AddItem(4,10,474,10);
 me.AddItem(4,10,475,10);
 me.AddItem(4,10,476,10);
 me.AddItem(4,10,477,10);
 me.AddItem(4,10,478,10);
 me.AddItem(4,10,479,10);
 me.AddItem(4,10,480,10);
 me.AddItem(4,10,481,10); 
end
function tbGMCard:DoCuoi12()
local nSeries = me.nSeries;
 local szMsg = "Hay chon";
 local tbOpt = {
  {"Đồ Ngoại Công",self.Dongoai,self},
  {"Đồ Nội Công",self.Donoi,self },
 }
 Dialog:Say(szMsg,tbOpt);
end
function tbGMCard:Dongoai()
local nSex = me.nSex;
  local nSeries = me.nSeries;
 if (nSeries == 0) then
  Dialog:Say("Bạn hãy gia nhập phái");
  return;
 end
 
 if (1 == nSeries) then
 
  if (0 == nSex) then --male
  me.AddGreenEquip(8,519,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(8,537,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(10,20211,10,5,16); --Th?y Hoàng H?ng Hoang Uy?n
 me.AddGreenEquip(4,20161,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20065,10,5,16); --Tiêu Dao Bá V??ng Ngoa
 me.AddGreenEquip(11,20105,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
 me.AddGreenEquip(5,20085,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,353,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,487,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20045,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 else   --female
 me.AddGreenEquip(8,520,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(8,538,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
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
 elseif (2 == nSeries) then
 
  if (0 == nSex) then --male
  me.AddGreenEquip(8,523,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(8,541,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(10,20215,10,5,16);
 me.AddGreenEquip(4,20163,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20067,10,5,16); --Tiêu Dao Bá V??ng Ngoa
 me.AddGreenEquip(11,20107,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
 me.AddGreenEquip(5,20087,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,373,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,489,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20046,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 else   --female
 me.AddGreenEquip(8,524,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(8,542,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
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
 elseif (3 == nSeries) then
 
  if (0 == nSex) then --male
  me.AddGreenEquip(8,527,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(8,545,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(10,20219,10,5,16);
 me.AddGreenEquip(4,20165,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20069,10,5,16); --Tiêu Dao Bá V??ng Ngoa
 me.AddGreenEquip(11,20109,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
 me.AddGreenEquip(5,20089,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,393,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,491,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20047,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
 else   --female
 me.AddGreenEquip(8,528,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(8,546,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(10,20220,10,5,16);
 me.AddGreenEquip(4,20165,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20070,10,5,16); --Tiêu Dao Huy?n N? Ngoa
 me.AddGreenEquip(11,20110,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
 me.AddGreenEquip(5,20089,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,394,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,492,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20052,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
 end
 elseif (4 == nSeries) then
 
  if (0 == nSex) then --male
  me.AddGreenEquip(8,531,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(8,549,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(10,20223,10,5,16);
 me.AddGreenEquip(4,20167,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20071,10,5,16); --Tiêu Dao Bá V??ng Ngoa
 me.AddGreenEquip(11,20111,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
 me.AddGreenEquip(5,20091,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,413,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,493,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20048,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 else   --female
 me.AddGreenEquip(8,532,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(8,550,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
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
 elseif (5 == nSeries) then
 
  if (0 == nSex) then --male
  me.AddGreenEquip(8,535,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(8,553,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(10,20227,10,5,16);
 me.AddGreenEquip(4,20169,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20073,10,5,16); --Tiêu Dao Bá V??ng Ngoa
 me.AddGreenEquip(11,20113,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
 me.AddGreenEquip(5,20093,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,433,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,495,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20049,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 else   --female
 me.AddGreenEquip(8,536,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(8,554,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(10,20228,10,5,16);
 me.AddGreenEquip(4,20169,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20074,10,5,16); --Tiêu Dao Huy?n N? Ngoa
 me.AddGreenEquip(11,20114,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
 me.AddGreenEquip(5,20093,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,434,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,496,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20054,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
 end
 else
  Dbg:WriteLogEx(Dbg.LOG_INFO, "Quan Lãnh Thổ", me.szName, "Bạn chưa gia nhập phái", nSeries);
 end
 ---local szMsg = "Hay chon";
 --local tbOpt = {
 -- {"He Kim",self.HeKim,self},
 -- {"He Moc",self.HeMoc,self},
 -- {"He Thuy",self.HeThuy,self},
 -- {"He Hoa",self.HeHoa,self},
 -- {"He Tho",self.HeTho,self},
 --}
 --Dialog:Say(szMsg,tbOpt);
end
function tbGMCard:Donoi()
local nSex = me.nSex;
  local nSeries = me.nSeries;
 if (nSeries == 0) then
  Dialog:Say("Bạn hãy gia nhập phái");
  return;
 end
 
 if (1 == nSeries) then
  if (0 == nSex) then --male
 me.AddGreenEquip(8,519,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(8,537,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(10,20213,10,5,16);
 me.AddGreenEquip(4,20162,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20065,10,5,16); --Tiêu Dao Bá V??ng Ngoa
 me.AddGreenEquip(11,20105,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
 me.AddGreenEquip(5,20086,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,353,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,487,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20045,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 else   --female
 me.AddGreenEquip(8,520,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(8,538,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 
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
 elseif (2 == nSeries) then
 
  if (0 == nSex) then --male
 me.AddGreenEquip(8,523,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(8,541,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 
  me.AddGreenEquip(10,20217,10,5,16);
 me.AddGreenEquip(4,20164,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20067,10,5,16); --Tiêu Dao Bá V??ng Ngoa
 me.AddGreenEquip(11,20107,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
 me.AddGreenEquip(5,20088,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,373,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,489,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20046,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 else   --female
me.AddGreenEquip(8,524,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(8,542,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
    me.AddGreenEquip(10,20218,10,5,16);
 me.AddGreenEquip(4,20164,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20068,10,5,16); --Tiêu Dao Huy?n N? Ngoa
 me.AddGreenEquip(11,20108,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
 me.AddGreenEquip(5,20088,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,374,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,490,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20051,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
 end
 elseif (3 == nSeries) then
 
  if (0 == nSex) then --male
 me.AddGreenEquip(8,527,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(8,545,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 
   me.AddGreenEquip(10,20221,10,5,16);
 me.AddGreenEquip(4,20166,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20069,10,5,16); --Tiêu Dao Bá V??ng Ngoa
 me.AddGreenEquip(11,20109,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
 me.AddGreenEquip(5,20090,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,393,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,491,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20047,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
 else   --female
 me.AddGreenEquip(8,528,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(8,546,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(10,20222,10,5,16);
 me.AddGreenEquip(4,20166,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20070,10,5,16); --Tiêu Dao Huy?n N? Ngoa
 me.AddGreenEquip(11,20110,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
 me.AddGreenEquip(5,20090,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,394,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,492,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20052,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
 end
 elseif (4 == nSeries) then
 
  if (0 == nSex) then --male
 me.AddGreenEquip(8,531,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(8,549,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 
   me.AddGreenEquip(10,20225,10,5,16);
 me.AddGreenEquip(4,20168,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20071,10,5,16); --Tiêu Dao Bá V??ng Ngoa
 me.AddGreenEquip(11,20111,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
 me.AddGreenEquip(5,20092,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,413,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,493,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20048,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
 else   --female
 me.AddGreenEquip(8,532,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(8,550,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
   me.AddGreenEquip(10,20226,10,5,16);
 me.AddGreenEquip(4,20168,10,5,16);--V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20072,10,5,16); --Tiêu Dao Huy?n N? Ngoa
 me.AddGreenEquip(11,20112,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
 me.AddGreenEquip(5,20092,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,414,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,494,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20053,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
 end
 elseif (5 == nSeries) then
 
  if (0 == nSex) then --male
  me.AddGreenEquip(8,535,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(8,553,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
   me.AddGreenEquip(10,20229,10,5,16);
 me.AddGreenEquip(4,20170,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20073,10,5,16); --Tiêu Dao Bá V??ng Ngoa
 me.AddGreenEquip(11,20113,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
 me.AddGreenEquip(5,20094,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,433,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,495,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20049,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
 else   --female
  me.AddGreenEquip(10,20230,10,5,16);
me.AddGreenEquip(8,536,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(8,554,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 
 me.AddGreenEquip(4,20170,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20074,10,5,16); --Tiêu Dao Huy?n N? Ngoa
 me.AddGreenEquip(11,20114,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
 me.AddGreenEquip(5,20094,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,434,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,496,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20054,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 end
 else
  Dbg:WriteLogEx(Dbg.LOG_INFO, "Quan Lãnh Thổ", me.szName, "Bạn chưa gia nhập phái", nSeries);
 end
 
end
 
 

function tbGMCard:DoCuoi13()
 local szMsg = "Hay chon";
 local tbOpt = {
  {"Do Nam",self.DoNam,self},
  {"Do Nu",self.DoNu,self },
 }
 Dialog:Say(szMsg,tbOpt);
end
function tbGMCard:DoNam()
 local szMsg = "Hay chon";
 local tbOpt = {
  {"He Kim",self.HeKim,self},
  {"He Moc",self.HeMoc,self},
  {"He Thuy",self.HeThuy,self},
  {"He Hoa",self.HeHoa,self},
  {"He Tho",self.HeTho,self},
 }
 Dialog:Say(szMsg,tbOpt);
end
function tbGMCard:DoNu()
 local szMsg = "Hay chon";
 local tbOpt = {
  {"He Kim",self.HeKim1,self},
  {"He Moc",self.HeMoc1,self},
  {"He Thuy",self.HeThuy1,self},
  {"He Hoa",self.HeHoa1,self},
  {"He Tho",self.HeTho1,self},
 }
 Dialog:Say(szMsg,tbOpt);
end
function tbGMCard:HeKim()
 local szMsg = "Hay chon";
 local tbOpt ={
  {"Do Ngoai",self.KimNgoai,self},
  {"Do Noi",self.KimNoi,self},
 }
 Dialog:Say(szMsg,tbOpt);
end
function tbGMCard:HeKim1()
 local szMsg = "Hay chon";
 local tbOpt ={
  {"Do Ngoai",self.KimNgoai1,self},
  {"Do Noi",self.KimNoi1,self},
 }
 Dialog:Say(szMsg,tbOpt);
end
function tbGMCard:HeMoc()
 local szMsg = "Hay chon";
 local tbOpt ={
  {"Do Ngoai",self.MocNgoai,self},
  {"Do Noi",self.MocNoi,self},
 }
 Dialog:Say(szMsg,tbOpt);
end
function tbGMCard:HeMoc1()
 local szMsg = "Hay chon";
 local tbOpt ={
  {"Do Ngoai",self.MocNgoai1,self},
  {"Do Noi",self.MocNoi1,self},
 }
 Dialog:Say(szMsg,tbOpt);
end
function tbGMCard:HeThuy()
 local szMsg = "Hay chon";
 local tbOpt ={
  {"Do Ngoai",self.ThuyNgoai,self},
  {"Do Noi",self.ThuyNoi,self},
 }
 Dialog:Say(szMsg,tbOpt);
end
function tbGMCard:HeThuy1()
 local szMsg = "Hay chon";
 local tbOpt ={
  {"Do Ngoai",self.ThuyNgoai1,self},
  {"Do Noi",self.ThuyNoi1,self},
 }
 Dialog:Say(szMsg,tbOpt);
end
function tbGMCard:HeHoa()
 local szMsg = "Hay chon";
 local tbOpt ={
  {"Do Ngoai",self.HoaNgoai,self},
  {"Do Noi",self.HoaNoi,self},
 }
 Dialog:Say(szMsg,tbOpt);
end
function tbGMCard:HeHoa1()
 local szMsg = "Hay chon";
 local tbOpt ={
  {"Do Ngoai",self.HoaNgoai1,self},
  {"Do Noi",self.HoaNoi1,self},
 }
 Dialog:Say(szMsg,tbOpt);
end
function tbGMCard:HeTho()
 local szMsg = "Hay chon";
 local tbOpt ={
  {"Do Ngoai",self.ThoNgoai,self},
  {"Do Noi",self.ThoNoi,self},
 }
 Dialog:Say(szMsg,tbOpt);
end
function tbGMCard:HeTho1()
 local szMsg = "Hay chon";
 local tbOpt ={
  {"Do Ngoai",self.ThoNgoai1,self},
  {"Do Noi",self.ThoNoi1,self},
 }
 Dialog:Say(szMsg,tbOpt);
end
function tbGMCard:KimNgoai()
 me.AddGreenEquip(10,20211,10,5,16); --Th?y Hoàng H?ng Hoang Uy?n
 me.AddGreenEquip(4,20161,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20065,10,5,16); --Tiêu Dao Bá V??ng Ngoa
 me.AddGreenEquip(11,20105,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
 me.AddGreenEquip(5,20085,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,353,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,487,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20045,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 
 --Chua bo trang bi vao******************************
end
function tbGMCard:KimNgoai1()
 me.AddGreenEquip(10,20212,10,5,16);
 me.AddGreenEquip(4,20161,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20066,10,5,16); --Tiêu Dao Huy?n N? Ngoa
 me.AddGreenEquip(11,20106,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
 me.AddGreenEquip(5,20085,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,354,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,488,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20050,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
end
function tbGMCard:KimNoi()
 me.AddGreenEquip(10,20213,10,5,16);
 me.AddGreenEquip(4,20162,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20065,10,5,16); --Tiêu Dao Bá V??ng Ngoa
 me.AddGreenEquip(11,20105,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
 me.AddGreenEquip(5,20086,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,353,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,487,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20045,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
end
function tbGMCard:KimNoi1()
 me.AddGreenEquip(10,20214,10,5,16);
 me.AddGreenEquip(4,20162,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20066,10,5,16); --Tiêu Dao Huy?n N? Ngoa
 me.AddGreenEquip(11,20106,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
 me.AddGreenEquip(5,20086,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,354,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,488,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20050,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20000,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
end
function tbGMCard:MocNgoai()
 me.AddGreenEquip(10,20215,10,5,16);
 me.AddGreenEquip(4,20163,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20067,10,5,16); --Tiêu Dao Bá V??ng Ngoa
 me.AddGreenEquip(11,20107,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
 me.AddGreenEquip(5,20087,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,373,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,489,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20046,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
end
function tbGMCard:MocNgoai1()
 me.AddGreenEquip(10,20216,10,5,16);
 me.AddGreenEquip(4,20163,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20068,10,5,16); --Tiêu Dao Huy?n N? Ngoa
 me.AddGreenEquip(11,20108,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
 me.AddGreenEquip(5,20087,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,374,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,490,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20051,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
end
function tbGMCard:MocNoi()
 me.AddGreenEquip(10,20217,10,5,16);
 me.AddGreenEquip(4,20164,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20067,10,5,16); --Tiêu Dao Bá V??ng Ngoa
 me.AddGreenEquip(11,20107,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
 me.AddGreenEquip(5,20088,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,373,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,489,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20046,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
end
function tbGMCard:MocNoi1()
 me.AddGreenEquip(10,20218,10,5,16);
 me.AddGreenEquip(4,20164,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20068,10,5,16); --Tiêu Dao Huy?n N? Ngoa
 me.AddGreenEquip(11,20108,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
 me.AddGreenEquip(5,20088,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,374,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,490,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20051,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20001,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
end

function tbGMCard:ThuyNgoai()
 me.AddGreenEquip(10,20219,10,5,16);
 me.AddGreenEquip(4,20165,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20069,10,5,16); --Tiêu Dao Bá V??ng Ngoa
 me.AddGreenEquip(11,20109,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
 me.AddGreenEquip(5,20089,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,393,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,491,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20047,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
end
function tbGMCard:ThuyNgoai1()
 me.AddGreenEquip(10,20220,10,5,16);
 me.AddGreenEquip(4,20165,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20070,10,5,16); --Tiêu Dao Huy?n N? Ngoa
 me.AddGreenEquip(11,20110,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
 me.AddGreenEquip(5,20089,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,394,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,492,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20052,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
end
function tbGMCard:ThuyNoi()
 me.AddGreenEquip(10,20221,10,5,16);
 me.AddGreenEquip(4,20166,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20069,10,5,16); --Tiêu Dao Bá V??ng Ngoa
 me.AddGreenEquip(11,20109,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
 me.AddGreenEquip(5,20090,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,393,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,491,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20047,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
end
function tbGMCard:ThuyNoi1()
 me.AddGreenEquip(10,20222,10,5,16);
 me.AddGreenEquip(4,20166,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20070,10,5,16); --Tiêu Dao Huy?n N? Ngoa
 me.AddGreenEquip(11,20110,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
 me.AddGreenEquip(5,20090,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,394,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,492,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20052,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20002,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
end
function tbGMCard:HoaNgoai()
 me.AddGreenEquip(10,20223,10,5,16);
 me.AddGreenEquip(4,20167,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20071,10,5,16); --Tiêu Dao Bá V??ng Ngoa
 me.AddGreenEquip(11,20111,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
 me.AddGreenEquip(5,20091,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,413,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,493,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20048,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
end
function tbGMCard:HoaNgoai1()
 me.AddGreenEquip(10,20224,10,5,16);
 me.AddGreenEquip(4,20167,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20072,10,5,16); --Tiêu Dao Huy?n N? Ngoa
 me.AddGreenEquip(11,20112,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
 me.AddGreenEquip(5,20091,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,414,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,494,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20053,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
end
function tbGMCard:HoaNoi()
 me.AddGreenEquip(10,20225,10,5,16);
 me.AddGreenEquip(4,20168,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20071,10,5,16); --Tiêu Dao Bá V??ng Ngoa
 me.AddGreenEquip(11,20111,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
 me.AddGreenEquip(5,20092,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,413,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,493,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20048,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
end
function tbGMCard:HoaNoi1()
 me.AddGreenEquip(10,20226,10,5,16);
 me.AddGreenEquip(4,20168,10,5,16);--V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20072,10,5,16); --Tiêu Dao Huy?n N? Ngoa
 me.AddGreenEquip(11,20112,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
 me.AddGreenEquip(5,20092,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,414,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,494,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20053,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20003,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
end

function tbGMCard:ThoNgoai()
 me.AddGreenEquip(10,20227,10,5,16);
 me.AddGreenEquip(4,20169,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20073,10,5,16); --Tiêu Dao Bá V??ng Ngoa
 me.AddGreenEquip(11,20113,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
 me.AddGreenEquip(5,20093,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,433,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,495,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20049,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
end
function tbGMCard:ThoNgoai1()
 me.AddGreenEquip(10,20228,10,5,16);
 me.AddGreenEquip(4,20169,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20074,10,5,16); --Tiêu Dao Huy?n N? Ngoa
 me.AddGreenEquip(11,20114,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
 me.AddGreenEquip(5,20093,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,434,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,496,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20054,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
end
function tbGMCard:ThoNoi()
 me.AddGreenEquip(10,20229,10,5,16);
 me.AddGreenEquip(4,20170,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20073,10,5,16); --Tiêu Dao Bá V??ng Ngoa
 me.AddGreenEquip(11,20113,10,5,16); --Th?y Hoàng Chi?n Th?n ??ng Van B?i
 me.AddGreenEquip(5,20094,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,433,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,495,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20049,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
end
function tbGMCard:ThoNoi1()
 me.AddGreenEquip(10,20230,10,5,16);
 me.AddGreenEquip(4,20170,10,5,16); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20074,10,5,16); --Tiêu Dao Huy?n N? Ngoa
 me.AddGreenEquip(11,20114,10,5,16); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
 me.AddGreenEquip(5,20094,10,5,16); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,434,10,5,16); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,496,10,5,16); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20054,10,5,16); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20004,10,5,16); --V? Uy L?m Nh?t Tinh Huy?n Phù
 --Chua bo trang bi vao******************************
end
function tbGMCard:OnDialog_taytuy()
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
function tbGMCard:OnResetDian(pPlayer, nType)
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
function tbGMCard:OnChangeGenreFaction(pPlayer)
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
function tbGMCard:OnChangeGenreFactionSelected(pPlayer, nFactionId)
 
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
