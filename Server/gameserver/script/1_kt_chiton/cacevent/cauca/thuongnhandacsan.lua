local tbTNDS = Npc:GetClass("thk_tnds");
tbTNDS.tbItemInfo = {bForceBind=1,};
tbTNDS.TASK_GROUP_ID1 = 3024;
tbTNDS.TASK_GROUP_ID2 = 3025;
tbTNDS.TaskId_Count = 1;
function tbTNDS:OnDialog()
DoScript("\\script\\event\\cacevent\\cauca\\thuongnhandacsan.lua");
local szMsg = "Những thứ ta bán đều là đặc sản của vùng này, ngươi có muốn xem thử không?"
local tbOpt = { 
{"Sự Kiện <color=yellow>Câu Cá<color>",self.Event_CauCa,self};
{"Đặc sản",self.OpenShop,self};
{"Không mua nữa",self.LuyenLamLongDon,self};
}; 
Dialog:Say(szMsg, tbOpt);
end
function tbTNDS:OpenShop()
me.OpenShop(109,1)
end
function tbTNDS:Event_CauCa()
local nCount1 = me.GetItemCountInBags(18,1,2095,1)
local nCount2 = me.GetItemCountInBags(18,1,2096,1)
local nCount3 = me.GetItemCountInBags(18,1,2097,1)
local nCount4 = me.GetItemCountInBags(18,1,2098,1)
local szMsg = "Hiện nay sức khỏe ta đã yếu dần, không thể đi câu cá được nữa, mong các nhân sĩ giang hồ giúp ta câu cá đem cá tới đây ta thưởng\n"..
"Có 4 loại cá ta vẫn thường hay câu là \n<color=green>Cá Chép - Cá Rô - Cá Ba Đuôi - Cá Trích<color>\n"..
"Chỉ có <color=green>Cá Ba Đuôi - Cá Trích<color> là giá trị hơn cả\n"..
"Phần thưởng cho mỗi 1 vật phẩm giao nộp như sau:\n"..
"<color=green>Cá Chép<color> (<color=gold>Hiện có: "..nCount1.."<color>) 5tr Kinh Nghiệm\n".. 
"<color=green>Cá Rô<color> (<color=gold>Hiện có: "..nCount2.."<color>) 7tr Kinh Nghiệm\n".. 
"<color=green>Cá Ba Đuôi<color> (<color=gold>Hiện có: "..nCount3.."<color>) 15tr Kinh Nghiệm\n".. 
"<color=green>Cá Trích<color> (<color=gold>Hiện có: "..nCount4.."<color>) 25tr Kinh Nghiệm"
local tbOpt = { 
{"Nộp <color=green>Cá Chép<color>",self.GiaoNop_CC,self};
{"Nộp <color=green>Cá Rô<color>",self.GiaoNop_CR,self};
{"Nộp <color=green>Cá Ba Đuôi<color>",self.GiaoNop_CBD,self};
{"Nộp <color=green>Cá Trích<color>",self.GiaoNop_CT,self};
{"Tìm hiểu <color=yellow>Sự Kiện Câu Cá<color>",self.Help_Event_CauCa,self};
}; 
Dialog:Say(szMsg, tbOpt);
end

function tbTNDS:Help_Event_CauCa()
local szMsg = "<color=gold>Cuốc<color>: Nhận ở <color=green>NPC Thương Nhân Đặc Sản<color> \n179/190 Vân Trung Trấn\n"..
"\n<color=gold>Mồi Câu<color>: Dùng <color=gold>Cuốc<color> đến <color=green>186/196 Vân Trung Trấn để đào\n"..
"\nNơi đào <color=gold>Mồi Câu<color> chỉ có <color=green>NPC Thương Nhân Đặc Sản<color> mới biết rõ nên hãy đi theo địa chỉ của ông ta mới tới được<color>\n"..
"\nGiao nộp đủ 100 <color=green>Cá Trích<color> nhận danh hiệu\n"..
"                   <color=yellow>Cao Thủ Câu Cá<color>\n"..
"<color=yellow>1 Phi Phong Tụ Hội Huyền Thoại (30 Ngày)"
local tbOpt = { 
-- {"Nhận <color=green>Cuốc<color>", self.NhanCuoc,self};
-- {"Nhận <color=green>Cần Câu<color>", self.NhanCanCau,self};
{"Đến chỗ đào <color=gold>Mồi Câu<color> [Tọa Độ 1]", me.NewWorld, 1, 1493, 3146};
{"Đến chỗ đào <color=gold>Mồi Câu<color> [Tọa Độ 2]", me.NewWorld, 1, 1492, 3151};
{"Đến chỗ đào <color=gold>Mồi Câu<color> [Tọa Độ 3]", me.NewWorld, 1, 1484, 3148};
}; 
Dialog:Say(szMsg, tbOpt);
end
function tbTNDS:NhanCanCau()
me.AddItem(18,1,2093,1)
end
function tbTNDS:NhanCuoc()
me.AddItem(18,1,2100,1)
end





function tbTNDS:GiaoNop_CC()
local nCount1 = me.GetItemCountInBags(18,1,2095,1)
	if me.CountFreeBagCell() < 5 then
		Dialog:Say("Hành Trang không đủ chỗ trống.Hãy sắp xếp còn trống 5 ô rồi quay lại gặp ta！");
		return 0;
	end
if nCount1 == 0 then
Dialog:Say("Trong người không có <color=green>Cá Chép<color>")
return
end
Dialog:AskNumber("Số Lượng Nộp", nCount1, self.GiaoNop_CC_1, self);
end
function tbTNDS:GiaoNop_CC_1(szCaChep)
if szCaChep > 100 then
Dialog:Say("Mỗi lần giao nộp tối đa là <color=green>100<color>")
return
end
local tbItemId1	= {18,1,2095,1,0,0}; -- Lam Long Đơn (Thô)
me.AddExp(szCaChep*5000000)
me.Msg("<color=yellow><color=green>"..me.szName.."<color> giao nộp <color=green>"..szCaChep.."<color> Cá Chép\nNhận : <color=green>".. szCaChep*5000000 .."<color> Điểm Kinh Nghiệm<color>")
Task:DelItem(me, tbItemId1, szCaChep);
end

function tbTNDS:GiaoNop_CR()
local nCount1 = me.GetItemCountInBags(18,1,2096,1)
	if me.CountFreeBagCell() < 5 then
		Dialog:Say("Hành Trang không đủ chỗ trống.Hãy sắp xếp còn trống 5 ô rồi quay lại gặp ta！");
		return 0;
	end
if nCount1 == 0 then
Dialog:Say("Trong người không có <color=green>Cá Rô<color>")
return
end
Dialog:AskNumber("Số Lượng Nộp", nCount1, self.GiaoNop_CR_1, self);
end
function tbTNDS:GiaoNop_CR_1(szCaRo)
if szCaRo > 100 then
Dialog:Say("Mỗi lần giao nộp tối đa là <color=green>100<color>")
return
end
local tbItemId1	= {18,1,2096,1,0,0}; -- Lam Long Đơn (Thô)
me.AddExp(szCaRo*7000000)
me.Msg("<color=yellow><color=green>"..me.szName.."<color> giao nộp <color=green>"..szCaRo.."<color> Cá Rô\nNhận : <color=green>".. szCaRo*7000000 .."<color> Điểm Kinh Nghiệm<color>")
Task:DelItem(me, tbItemId1, szCaRo);
end


function tbTNDS:GiaoNop_CBD()
local nCount1 = me.GetItemCountInBags(18,1,2097,1)
	if me.CountFreeBagCell() < 5 then
		Dialog:Say("Hành Trang không đủ chỗ trống.Hãy sắp xếp còn trống 5 ô rồi quay lại gặp ta！");
		return 0;
	end
if nCount1 == 0 then
Dialog:Say("Trong người không có <color=green>Cá Ba Đuôi<color>")
return
end
Dialog:AskNumber("Số Lượng Nộp", nCount1, self.GiaoNop_CBD_1, self);
end
function tbTNDS:GiaoNop_CBD_1(szCaBaDuoi)
if szCaBaDuoi > 100 then
Dialog:Say("Mỗi lần giao nộp tối đa là <color=green>100<color>")
return
end
local tbItemId1	= {18,1,2097,1,0,0}; -- Lam Long Đơn (Thô)
me.AddExp(szCaBaDuoi*15000000)
me.Msg("<color=yellow><color=green>"..me.szName.."<color> giao nộp <color=green>"..szCaBaDuoi.."<color> Cá Ba Đuôi\nNhận : <color=green>".. szCaBaDuoi*15000000 .."<color> Điểm Kinh Nghiệm<color>")
Task:DelItem(me, tbItemId1, szCaBaDuoi);
end

function tbTNDS:GiaoNop_CT()
local nCount50 = me.GetTask(self.TASK_GROUP_ID1, self.TaskId_Count);
local nCount51 = me.GetTask(self.TASK_GROUP_ID2, self.TaskId_Count);
local szMsg = "Số <color=green>Cá Trích<color> đã nộp: <color=cyan>"..nCount50.."<color>\n"..
"\nGiao nộp đủ 100 <color=green>Cá Trích<color> nhận danh hiệu\n"..
"                   <color=yellow>Cao Thủ Câu Cá<color>\n"..
"<color=yellow>1 Phi Phong Tụ Hội Huyền Thoại (30 Ngày)"
local tbOpt = {
{"Nộp <color=green>Cá Trích<color>",self.GiaoNop_CT_GiaoNop,self};
}; 
if (nCount50 >= 100) and (nCount51 < 1) then
table.insert(tbOpt, 1,{"Nhận Danh Hiệu <color=gold>Cao Thủ Câu Cá\n<color=gold>1 Phi Phong Tụ Hội Huyền Thoại (30 Ngày)", self.NhanDanhHieu, self,});
end
Dialog:Say(szMsg, tbOpt);
end
function tbTNDS:NhanDanhHieu()
	if me.CountFreeBagCell() < 5 then
		Dialog:Say("Hành Trang không đủ chỗ trống.Hãy sắp xếp còn trống 5 ô rồi quay lại gặp ta！");
		return 0;
	end
local tbTimeOut = 30*24*60;	--30 ngày
local nCount50 = me.GetTask(self.TASK_GROUP_ID1, self.TaskId_Count);
local nCount51 = me.GetTask(self.TASK_GROUP_ID2, self.TaskId_Count);
if nSex == 1 then
local pItem1 = me.AddItem(1,17,20020,10);	-- Phi Phong Tụ Hội Huyền Thoại - Nam
me.AddTitle(18,1,1,1)
me.SetItemTimeout(pItem1, tbTimeOut, 0);
pItem1.Bind(1);
me.Msg("Nhận được danh hiệu: <color=gold>Cao Thủ Câu Cá<color>")
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> đã giao nộp cho \n<color=green>NPC Thương Nhân Đặc Sản<color>\n<color=cyan>"..nCount50.." Cá Trích<color>\nNhận danh hiệu: <color=gold>Cao Thủ Câu Cá<color>\n<color=gold>1 Phi Phong Tụ Hội Huyền Thoại - Nam (30 Ngày)<color><color>");
me.SetTask(self.TASK_GROUP_ID2, self.TaskId_Count, nCount51 + 1);
else
local pItem2 = me.AddItem(1,17,20021,10);	-- Phi Phong Tụ Hội Huyền Thoại - Nữ
me.AddTitle(18,1,1,1)
me.SetItemTimeout(pItem2, tbTimeOut, 0);
pItem2.Bind(1);
me.Msg("Nhận được danh hiệu: <color=gold>Cao Thủ Câu Cá<color>")
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> đã giao nộp cho \n<color=green>NPC Thương Nhân Đặc Sản<color>\n<color=cyan>"..nCount50.." Cá Trích<color>\nNhận danh hiệu: <color=gold>Cao Thủ Câu Cá<color>\n<color=gold>1 Phi Phong Tụ Hội Huyền Thoại - Nữ (30 Ngày)<color><color>");	   
me.SetTask(self.TASK_GROUP_ID2, self.TaskId_Count, nCount51 + 1);
end
end






function tbTNDS:GiaoNop_CT_GiaoNop()
local nCount1 = me.GetItemCountInBags(18,1,2098,1)
	if me.CountFreeBagCell() < 5 then
		Dialog:Say("Hành Trang không đủ chỗ trống.Hãy sắp xếp còn trống 5 ô rồi quay lại gặp ta！");
		return 0;
	end
if nCount1 == 0 then
Dialog:Say("Trong người không có <color=green>Cá Trích<color>")
return
end
Dialog:AskNumber("Số Lượng Nộp", nCount1, self.GiaoNop_CT_1, self);
end
function tbTNDS:GiaoNop_CT_1(szCaTrich)
local nCount50 = me.GetTask(self.TASK_GROUP_ID1, self.TaskId_Count);
if szCaTrich > 50 then
Dialog:Say("Mỗi lần giao nộp tối đa là <color=green>50<color>")
return
end
if szCaTrich + nCount50 > 100 then
Dialog:Say("<color=green>Cá Trích<color> tối đa nộp là <color=green>100<color> Con.\nNgươi đã nộp cho ta <color=green>"..nCount50.."<color> Cá Trích trước đó\nGiờ chỉ được nộp thêm <color=green>".. 100 - nCount50 .."<color> Cá Trích nữa")
return
end
local tbItemId1	= {18,1,2098,1,0,0}; -- Lam Long Đơn (Thô)
me.AddExp(szCaTrich*25000000)
me.SetTask(self.TASK_GROUP_ID1, self.TaskId_Count, nCount50 + szCaTrich);
me.Msg("<color=yellow><color=green>"..me.szName.."<color> giao nộp <color=green>"..szCaTrich.."<color> Cá Trích\nNhận : <color=green>".. szCaTrich*25000000 .."<color> Điểm Kinh Nghiệm<color>\n<color=yellow>Số <color=green>Cá Trích<color> đã nộp là : <color=green>".. nCount50+ szCaTrich .."")
Task:DelItem(me, tbItemId1, szCaTrich);
end