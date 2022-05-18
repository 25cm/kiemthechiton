
-- τݾĻaúguozi_summer.lua
-- Դݨ֟aúsunduoliang
-- Դݨʱݤú2009-07-09 09:12:56
-- Ĩ  ˶  ú

local tbItem = Item:GetClass("tuiqualonghon")
tbItem.tbBoss = {
	{"<color=gold>Nhận Trang Bị Truyền Thuyết +0<color>",100 , 1},
};

function tbItem:OnUse()
if me.CountFreeBagCell() < 15 then
		Dialog:Say("Phải Có 15 Ô Trống Trong Túi Hành Trang");
		return 0;
	end
if me.nFaction == 0 then
Dialog:Say("Bạn chưa gia nhập môn phái")
return
end
if me.nRouteId == 0 then
Dialog:Say("Bạn chưa chọn hệ phái")
return
end
	
	local szMsg = "Ấn vào đây để nhận - Lưu ý : sau khi nhận thưởng vật phẩm sẽ biến mất <pic=12> ";
	local tbOpt = {
		{"<color=orange>Nhận<color>",self.GetItem1, self, it.dwId},
			};
	local nType, nTime = it.GetTimeOut();
	if nType and nType >= 0 and nTime and nTime > 0 then
		table.insert(tbOpt, 3, {"Trao Doi Khong Gioi Han", self.ChangeItem, self, it.dwId});
	end
	
	Dialog:Say(szMsg, tbOpt);
end

function tbItem:ChangeItem(nItemId)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	if me.DelItem(pItem) ~= 1 then
		return;
	end
	local pItem1 = 
	 me.AddGreenEquip(8,520,10,5,12).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(8,538,10,5,12).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
  me.AddGreenEquip(10,20212,10,5,12).Bind(1);
 me.AddGreenEquip(4,20161,10,5,12).Bind(1); --V? Uy C? Tinh Gi?i
 me.AddGreenEquip(7,20066,10,5,12).Bind(1); --Tiêu Dao Huy?n N? Ngoa
 me.AddGreenEquip(11,20106,10,5,12).Bind(1); --Th?y Hoàng Chi?n Th?n B?ng Tinh H??ng Nang
 me.AddGreenEquip(5,20085,10,5,12).Bind(1); --Tr?c L?c Thiên ?i?p L?u Van Liên
 me.AddGreenEquip(8,354,10,5,12).Bind(1); --Tr?c L?c Hoàng Long Tri?n Yêu
 me.AddGreenEquip(9,488,10,5,12).Bind(1); --Tr?c L?c Kinh Van Kh?i
 me.AddGreenEquip(3,20050,10,5,12).Bind(1); --Th?y Hoàng Long Lan Y
 me.AddGreenEquip(6,20000,10,5,12).Bind(1); --V? Uy L?m Nh?t Tinh Huy?n Phù
	if pItem1 then
		pItem1.Bind(1);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("Ban Da Nhan Duoc Hoa Thi Ngoc"));
	end
end

function tbItem:GetItem1(nItemId)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	local szMsg = "Nhận Trang Bị Theo Hệ Phái";
	local tbOpt = {};
	for _, tbBoss in ipairs(self.tbBoss) do
		table.insert(tbOpt, {tbBoss[1], self.GetItem1_1, self, nItemId, tbBoss[2], tbBoss[3]});
	end
	table.insert(tbOpt, {"Ta Chưa Muốn Nhận"});
	Dialog:Say(szMsg, tbOpt);
end

function tbItem:GetItem1_1(nItemId)
	if TimeFrame:GetState("OpenBoss120") ~= 1 then
		Dialog:Say("Șʼ܊ª۹δߪǴìЖ՚һŜגۻكӄìȫѡձגۻϤٟ˖ʹλщc");
		return 0;
	end
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	if me.IsHaveItemInBags(pItem) ~= 1 then
		return;
	end
	if me.DelItem(pItem) ~= 1 then
		return;
	end
if (me.nSeries == 1) and (me.nSex == 0) then --Hệ Kim + Nam
   local pItem =
     me.AddItem(4,3,931,10,5,0).Bind(1); 
	me.AddItem(4,6,1016,10,3,0).Bind(1); 
	me.AddItem(4,4,1036,10,4,0).Bind(1); 
	me.AddItem(4,5,950,10,5,0).Bind(1); 
	me.AddItem(4,11,1046,10,2,0).Bind(1); 
	me.AddItem(4,9,1056,10,1,0).Bind(1); 
	me.AddItem(4,7,1066,10,3,0).Bind(1); 
	me.AddItem(4,10,1076,10,2,0).Bind(1); 
	me.AddItem(4,8,1096,10,4,0).Bind(1); 
   end
if (me.nSeries == 1) and (me.nSex == 1) then --Hệ Kim + Nữ 
local pItem =
me.AddItem(4,3,932,10,5,0).Bind(1); 
me.AddItem(4,4,1036,10,4,0).Bind(1); 
me.AddItem(4,5,950,10,5,0).Bind(1); 
me.AddItem(4,11,1047,10,2,0).Bind(1); 
me.AddItem(4,9,1057,10,1,0).Bind(1); 
me.AddItem(4,7,1067,10,3,0).Bind(1); 
me.AddItem(4,10,1077,10,2,0).Bind(1); 
me.AddItem(4,8,1097,10,4,0).Bind(1); 
me.AddItem(4,6,1016,10,3,0).Bind(1); 
end  
if (me.nSeries == 2) and (me.nSex == 0) then --Hệ Mộc + Nam
local pItem = me.AddItem(4,3,933,10,3,0).Bind(1); 
me.AddItem(4,4,1037,10,1,0).Bind(1); 
me.AddItem(4,5,952,10,3,0).Bind(1); 
me.AddItem(4,11,1048,10,5,0).Bind(1); 
me.AddItem(4,6,1017,10,4,0).Bind(1); 
me.AddItem(4,9,1058,10,2,0).Bind(1); 
me.AddItem(4,7,1068,10,4,0).Bind(1); 
me.AddItem(4,10,1080,10,5,0).Bind(1); 
me.AddItem(4,8,1098,10,1,0).Bind(1); 
end
if (me.nSeries == 2) and (me.nSex == 1) then --Hệ Mộc + Nữ
local pItem =me.AddItem(4,3,934,10,3,0).Bind(1); 
me.AddItem(4,4,1037,10,1,0).Bind(1); 
me.AddItem(4,5,952,10,3,0).Bind(1); 
me.AddItem(4,11,1049,10,5,0).Bind(1); 
me.AddItem(4,7,1069,10,4,0).Bind(1); 
me.AddItem(4,10,1081,10,5,0).Bind(1); 
me.AddItem(4,8,1099,10,1,0).Bind(1); 
me.AddItem(4,9,1059,10,2,0).Bind(1); 
me.AddItem(4,6,1017,10,4,0).Bind(1); 
end
if (me.nSeries == 3) and (me.nSex == 0) then --Hệ Thủy + Nam
local pItem =me.AddItem(4,3,935,10,1,0).Bind(1); 
me.AddItem(4,4,1038,10,5,0).Bind(1); 
me.AddItem(4,11,1050,10,4,0).Bind(1); 
me.AddItem(4,9,1060,10,3,0).Bind(1); 
me.AddItem(4,7,1070,10,2,0).Bind(1); 
me.AddItem(4,10,1084,10,4,0).Bind(1); 
me.AddItem(4,6,1018,10,2,0).Bind(1); 
me.AddItem(4,8,1100,10,5,0).Bind(1); 
me.AddItem(4,5,954,10,1,0).Bind(1); 
end
if (me.nSeries == 3) and (me.nSex == 1) then --Hệ Thủy + Nữ
local pItem =
me.AddItem(4,3,936,10,1,0).Bind(1); 
me.AddItem(4,6,1018,10,2,0).Bind(1); 
me.AddItem(4,4,1038,10,5,0).Bind(1); 
me.AddItem(4,5,954,10,1,0).Bind(1); 
me.AddItem(4,11,1051,10,4,0).Bind(1); 
me.AddItem(4,9,1061,10,3,0).Bind(1); 
me.AddItem(4,7,1071,10,2,0).Bind(1); 
me.AddItem(4,10,1085,10,4,0).Bind(1); 
me.AddItem(4,8,1101,10,5,0).Bind(1); 
end
if (me.nSeries == 4) and (me.nSex == 0) then --Hệ Hỏa + Nam
local pItem = me.AddItem(4,3,937,10,2,0).Bind(1); 
me.AddItem(4,6,1019,10,5,0).Bind(1); 
me.AddItem(4,4,1039,10,3,0).Bind(1); 
me.AddItem(4,5,956,10,2,0).Bind(1); 
me.AddItem(4,9,1062,10,4,0).Bind(1); 
me.AddItem(4,7,1072,10,5,0).Bind(1); 
me.AddItem(4,10,1088,10,1,0).Bind(1); 
me.AddItem(4,8,1102,10,3,0).Bind(1); 
me.AddItem(4,11,1052,10,1,0).Bind(1); 
end
if (me.nSeries == 4) and (me.nSex == 1) then --Hệ Hỏa + Nữ
local pItem =
me.AddItem(4,3,938,10,2,0).Bind(1); 
me.AddItem(4,6,1019,10,5,0).Bind(1); 
me.AddItem(4,4,1039,10,3,0).Bind(1); 
me.AddItem(4,5,956,10,2,0).Bind(1); 
me.AddItem(4,11,1053,10,1,0).Bind(1); 
me.AddItem(4,9,1063,10,4,0).Bind(1); 
me.AddItem(4,7,1073,10,5,0).Bind(1); 
me.AddItem(4,10,1089,10,1,0).Bind(1); 
me.AddItem(4,8,1103,10,3,0).Bind(1); 
end
if (me.nSeries == 5) and (me.nSex == 0) then --Hệ Thổ + Nam 
local pItem = me.AddItem(4,3,939,10,4,0).Bind(1); 
me.AddItem(4,6,1020,10,1,0).Bind(1); 
me.AddItem(4,4,1040,10,2,0).Bind(1); 
me.AddItem(4,5,958,10,4,0).Bind(1); 
me.AddItem(4,11,1054,10,3,0).Bind(1); 
me.AddItem(4,9,1064,10,5,0).Bind(1); 
me.AddItem(4,7,1074,10,1,0).Bind(1); 
me.AddItem(4,10,1092,10,3,0).Bind(1); 
me.AddItem(4,8,1104,10,2,0).Bind(1); 
end
if (me.nSeries == 5) and (me.nSex == 1) then --Hệ Thổ + Nữ 
local pItem =me.AddItem(4,3,940,10,4,0).Bind(1); 
me.AddItem(4,6,1020,10,1,0).Bind(1); 
me.AddItem(4,4,1040,10,2,0).Bind(1); 
me.AddItem(4,5,958,10,4,0).Bind(1); 
me.AddItem(4,11,1055,10,3,0).Bind(1); 
me.AddItem(4,9,1065,10,5,0).Bind(1); 
me.AddItem(4,7,1075,10,1,0).Bind(1); 
me.AddItem(4,10,1093,10,3,0).Bind(1); 
me.AddItem(4,8,1105,10,2,0).Bind(1); 
end 
 if pItem then
		--pItem.Bind(1);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("Chúc Mừng"));
	end
	me.Msg("<color=yellow>Chúc Mừng Bạn Đã Nhận Được Trang Bị Bá Vương +12<color> ");
end

function tbItem:GetItem2(nItemId)
	if TimeFrame:GetState("OpenBoss120") ~= 1 then
		Dialog:Say("Șʼ܊ª۹δߪǴìЖ՚һŜגۻكӄìȫѡձגۻϤٟ˖ʹλщc");
		return 0;
	end
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	if me.IsHaveItemInBags(pItem) ~= 1 then
		return;
	end
	if me.DelItem(pItem) ~= 1 then
		return;
	end
	local pItem = me.AddItem(22,1,81,1);
	if pItem then
		--pItem.Bind(1);
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, string.format("ʹԃʢЄڻʵۻȡۍˏԱһٶ"));
	end
	me.Msg("ԉ٦ۻȡһࠩ<color=yellow>ۍˏԱ<color>");
end
