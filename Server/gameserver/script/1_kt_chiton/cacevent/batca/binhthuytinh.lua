local tbBinhThuyTinh = Item:GetClass("THK_binhthuytinh");
function tbBinhThuyTinh:OnUse()
DoScript("\\script\\event\\cacevent\\batca\\binhthuytinh.lua");
local nCount1 = me.GetItemCountInBags(18,1,20311,1); -- Cá Chép Đỏ
local nCount2 = me.GetItemCountInBags(18,1,20312,1); -- Cá Chép Vàng
local nCount3 = me.GetItemCountInBags(18,1,20313,1); -- Chậu Cá Chép Đỏ
local nCount4 = me.GetItemCountInBags(18,1,20314,1); -- Chậu Cá Chép Vàng
local nCount5 = me.GetItemCountInBags(18,1,20315,1); -- Chậu Thủy Tinh
local szMsg = "<color=Turquoise>Cá Chép Đỏ<color> : <color=yellow>"..nCount1.."<color>\n<color=Turquoise>Cá Chép Vàng<color> : <color=yellow>"..nCount2.."<color>\n<color=Turquoise>Chậu Thủy Tinh<color> : <color=yellow>"..nCount5.."<color>\n"..
"\n1 <color=yellow>Cá Chép Đỏ<color> + 1 <color=yellow>Chậu Thủy Tinh<color> = 1 <color=yellow>Chậu Cá Chép Đỏ<color>\n"..
"1 <color=yellow>Cá Chép Vàng<color> + 1 <color=yellow>Chậu Thủy Tinh<color> = 1 <color=yellow>Chậu Cá Chép Vàng<color>"
local tbOpt = { 
{"Thả <color=yellow>Cá Chép Đỏ<color> vào Chậu",self.ThaCaChepDo,self};
{"Thả <color=yellow>Cá Chép Vàng<color> vào Chậu",self.ThaCaChepVang,self};
}; 
Dialog:Say(szMsg, tbOpt);
end
---------- Thả Cá Chép Vàng --------------
function tbBinhThuyTinh:ThaCaChepVang()
local nCount1 = me.GetItemCountInBags(18,1,20312,1); -- Cá Chép Đỏ
if nCount1 == 0 then
Dialog:Say("Không có Cá Chép Vàng")
return
end
	Dialog:AskNumber("Cá Chép Vàng muốn thả", nCount1 ,self.SoCaVang,self, nSoCaChepVang);
end
function tbBinhThuyTinh:SoCaVang(nSoCaChepVang)
local nCount1 = me.GetItemCountInBags(18,1,20315,1); -- Cá Chép Đỏ
Dialog:AskNumber("Số Chậu Thủy Tinh",nCount1,self.KetQuaThaCaVang ,self, nSoCaChepVang, nSoBinhThuyTinh);
end
function tbBinhThuyTinh:KetQuaThaCaVang(nSoCaChepVang,nSoBinhThuyTinh)
if nSoCaChepVang ~= nSoBinhThuyTinh then
Dialog:Say("Để thả "..nSoCaChepVang.." Cá Chép Vàng vào Chậu Thủy Tinh cần "..nSoCaChepVang.." Chậu Thủy Tinh")
return
end
local tbItemId1	= {18,1,20312,1,0,0}; -- Cá Chép Vàng
local tbItemId2	= {18,1,20315,1,0,0}; -- Chậu Thủy Tinh
local nCount1 = me.GetItemCountInBags(18,1,20312,1); -- Cá Chép Vàng
local nCount2 = me.GetItemCountInBags(18,1,20315,1); -- Chậu Thủy Tinh
me.AddStackItem(18,1,20314,1,nil,nSoCaChepVang)
Task:DelItem(me, tbItemId1, nSoCaChepVang);
Task:DelItem(me, tbItemId2, nSoCaChepVang);
end
---------- Thả Cá Chép Đỏ --------------
function tbBinhThuyTinh:ThaCaChepDo()
local nCount1 = me.GetItemCountInBags(18,1,20311,1); -- Cá Chép Đỏ
if nCount1 == 0 then
Dialog:Say("Không có Cá Chép Đỏ")
return
end
	Dialog:AskNumber("Cá Chép Đỏ muốn thả", nCount1 ,self.So2,self, nSo1);
end
function tbBinhThuyTinh:So2(nSo1)
local nCount1 = me.GetItemCountInBags(18,1,20315,1); -- Cá Chép Đỏ
Dialog:AskNumber("Số Chậu Thủy Tinh",nCount1,self.KetQuaThaCa ,self, nSo1, nSo2);
end
function tbBinhThuyTinh:KetQuaThaCa(nSo1,nSo2)
if nSo1 ~= nSo2 then
Dialog:Say("Để thả "..nSo1.." Cá Chép Đỏ vào Chậu Thủy Tinh cần "..nSo1.." Chậu Thủy Tinh")
return
end
local tbItemId1	= {18,1,20311,1,0,0}; -- Cá Chép Đỏ
local tbItemId2	= {18,1,20315,1,0,0}; -- Chậu Thủy Tinh
local nCount1 = me.GetItemCountInBags(18,1,20311,1); -- Cá Chép Đỏ
local nCount2 = me.GetItemCountInBags(18,1,20315,1); -- Chậu Thủy Tinh
me.AddStackItem(18,1,20313,1,nil,nSo1)
Task:DelItem(me, tbItemId1, nSo1);
Task:DelItem(me, tbItemId2, nSo1);
end