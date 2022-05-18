local tbCotCo = Npc:GetClass("sltk_cotcohn");
tbCotCo.tbItemInfo = {bForceBind=1,};
tbCotCo.TaskId_Count = 1;
tbCotCo.TASK_GROUP_ID1 = 3012;
tbCotCo.TASK_GROUP_ID2 = 3013;
function tbCotCo:OnDialog()
DoScript("\\script\\event\\cacevent\\cuopluongthao\\cotcohn.lua");
local nCount = me.GetTask(self.TASK_GROUP_ID1, self.TaskId_Count);
local nCount2 = me.GetTask(self.TASK_GROUP_ID2, self.TaskId_Count);
local Msg = "Bạn đã gắn <color=yellow>"..nCount.."<color> Huy Chương Vàng \n"..
"Mỗi 1 Huy Chương Vàng gắn lên bạn nhận được 10tr EXP + 1 Lam Long Đơn (Thô)\n"..
"Khi gắn tới số Huy Chương Vàng quy định bạn sẽ nhận được phần thưởng\n"..
"Trong suốt sự kiện mỗi người chơi gắn tối đa <color=yellow>301<color> Huy Chương Vàng\n"..
"<color=yellow>Gắn 50<color>: 5 Ngôi Sao Vàng + 50tr EXP\n"..
"<color=yellow>Gắn 150<color>: 10 Ngôi Sao Vàng + 1 Đá Cường Hóa (+14) + 70tr EXP\n"..
"<color=yellow>Gắn 250<color>: 15 Ngôi Sao Vàng + 2 Đá Cường Hóa (+14) + 100tr EXP\n"..
"<color=yellow>Gắn 300<color>: 20 Ngôi Sao Vàng + 3 Đá Cường Hóa (+14) + 150tr EXP"
	local tbOpt = {
		{"Gắn <color=yellow>Huy Chương Vàng<color>", self.GanHuyChuongVang, self},
		{"10 <color=yellow>Ngôi Sao Bạc<color> =\n1<color=yellow> Huân Chương Vàng<color>", self.DoiSaoBacLayHCV, self},
		{"Ta chưa muốn"},
	}
	if nCount >= 50 and nCount2 == 0 then
	table.insert(tbOpt, 1,{"Đạt Tới 50 Lần", self.DatToi50Lan, self,});
	end
	if nCount >= 150 and nCount2 == 1 then
	table.insert(tbOpt, 1,{"Đạt Tới 150 Lần", self.DatToi150Lan, self,});
	end
	if nCount >= 250 and nCount2 == 2 then
	table.insert(tbOpt, 1,{"Đạt Tới 250 Lần", self.DatToi250Lan, self,});
	end
	if nCount >= 300 and nCount2 == 3 then
	table.insert(tbOpt, 1,{"Đạt Tới 300 Lần", self.DatToi300Lan, self,});
	end
	Dialog:Say(Msg, tbOpt);
end
function tbCotCo:DoiSaoBacLayHCV()
local tbItemId1	= {18,1,20320,1,0,0}; -- 
local nCount1 = me.GetItemCountInBags(18,1,20320,1)
if nCount1 < 10 then
Dialog:Say("Ngươi chỉ có "..nCount1.." Ngôi Sao Bạc")
return
end
me.AddItem(18,1,20319,1)
Task:DelItem(me, tbItemId1, 10);
end
---------------
function tbCotCo:DatToi50Lan()
local nCount2 = me.GetTask(self.TASK_GROUP_ID2, self.TaskId_Count);
	if me.CountFreeBagCell() < 10 then
		Dialog:Say("Hành Trang không đủ chỗ trống.Hãy sắp xếp còn trống 10 ô rồi quay lại gặp ta！");
		return 0;
	end
	me.AddStackItem(18,1,20321,1,nil,5)
	me.AddExp(50000000)
	me.SetTask(self.TASK_GROUP_ID2, self.TaskId_Count, nCount2 + 1);
	KDialog.MsgToGlobal("<color=cyan>"..me.szName.."<color> <color=orange>đã gắn đạt tới mốc <color=yellow>50 Huy Chương Vàng<color> lên Cờ Tổ Quốc, nhận được <color=yellow>5 Ngôi Sao Vàng<color> và <color=yellow>50tr Kinh Nghiệm");	
end
function tbCotCo:DatToi150Lan()
local nCount2 = me.GetTask(self.TASK_GROUP_ID2, self.TaskId_Count);
	if me.CountFreeBagCell() < 10 then
		Dialog:Say("Hành Trang không đủ chỗ trống.Hãy sắp xếp còn trống 10 ô rồi quay lại gặp ta！");
		return 0;
	end
	me.AddStackItem(18,1,20321,1,nil,10)
	me.AddExp(100000000)
	me.AddItem(18,1,20325,1)
	me.SetTask(self.TASK_GROUP_ID2, self.TaskId_Count, nCount2 + 1);
	KDialog.MsgToGlobal("<color=cyan>"..me.szName.."<color> <color=orange>đã gắn đạt tới mốc <color=yellow>150 Huy Chương Vàng<color> lên Cờ Tổ Quốc, nhận được <color=yellow>10 Ngôi Sao Vàng<color> , <color=yellow>100tr Kinh Nghiệm<color> và <color=yellow>1 Đá Cương Hóa (+14)<color>");	
end
function tbCotCo:DatToi250Lan()
local nCount2 = me.GetTask(self.TASK_GROUP_ID2, self.TaskId_Count);
	if me.CountFreeBagCell() < 10 then
		Dialog:Say("Hành Trang không đủ chỗ trống.Hãy sắp xếp còn trống 10 ô rồi quay lại gặp ta！");
		return 0;
	end
	me.AddStackItem(18,1,20321,1,nil,15)
	me.AddExp(150000000)
	me.AddItem(18,1,20325,1)
	me.AddItem(18,1,20325,1)
	me.SetTask(self.TASK_GROUP_ID2, self.TaskId_Count, nCount2 + 1);
	KDialog.MsgToGlobal("<color=cyan>"..me.szName.."<color> <color=orange>đã gắn đạt tới mốc <color=yellow>250 Huy Chương Vàng<color> lên Cờ Tổ Quốc, nhận được <color=yellow>15 Ngôi Sao Vàng<color> , <color=yellow>150tr Kinh Nghiệm<color> và <color=yellow>2 Đá Cương Hóa (+14)<color>");	
end
function tbCotCo:DatToi300Lan()
local nCount2 = me.GetTask(self.TASK_GROUP_ID2, self.TaskId_Count);
	if me.CountFreeBagCell() < 10 then
		Dialog:Say("Hành Trang không đủ chỗ trống.Hãy sắp xếp còn trống 10 ô rồi quay lại gặp ta！");
		return 0;
	end
	me.AddStackItem(18,1,20321,1,nil,20)
	me.AddExp(200000000)
	me.AddItem(18,1,20325,1)
	me.AddItem(18,1,20325,1)
	me.SetTask(self.TASK_GROUP_ID2, self.TaskId_Count, nCount2 + 1);
	KDialog.MsgToGlobal("<color=cyan>"..me.szName.."<color> <color=orange>đã gắn đạt tới mốc <color=yellow>300 Huy Chương Vàng<color> lên Cờ Tổ Quốc, nhận được <color=yellow>20 Ngôi Sao Vàng<color> , <color=yellow>200tr Kinh Nghiệm<color> và <color=yellow>2 Đá Cương Hóa (+14)<color>");	
end
function tbCotCo:GanHuyChuongVang()
local nCount = me.GetTask(self.TASK_GROUP_ID1, self.TaskId_Count);
if nCount > 301 then
Dialog:Say("Mỗi nhân vật tối đa là 301 Huân Chương Vàng")
return
end
	if me.CountFreeBagCell() < 10 then
		Dialog:Say("Hành Trang không đủ chỗ trống.Hãy sắp xếp còn trống 10 ô rồi quay lại gặp ta！");
		return 0;
	end
local tbItemId1	= {18,1,20319,1,0,0}; -- Huân Chương Vàng
	local nCount1 = me.GetItemCountInBags(18,1,20319,1) -- Huân Chương Vàng
	if nCount1 == 0 then
	Dialog:Say("Ngươi không có Huy Chương Vàng không thể gắn")
	return
	end
if nCount == 0 then
Dialog:AskNumber("Số Lượng Gắn", 301, self.GanHCV, self);
return
end
if nCount > 0 then
Dialog:AskNumber("Số Lượng Gắn", (301 - nCount), self.GanHCV, self);
return
end
end
function tbCotCo:GanHCV(szSoLuongGan)
local tbItemId1	= {18,1,20319,1,0,0}; -- Huân Chương Vàng
local nCount = me.GetTask(self.TASK_GROUP_ID1, self.TaskId_Count);
local nCount1 = me.GetItemCountInBags(18,1,20319,1) -- Huân Chương Vàng
if szSoLuongGan > 100 then 
Dialog:Say("Mỗi lần gắn tối đa 100 Huy Chương Vàng")
return
end
if szSoLuongGan > nCount1 then
Dialog:Say("Ngưoi chỉ có "..nCount1.." Huy Chương Vàng")
return
end
if szSoLuongGan > 50 then
me.AddExp(10000000*szSoLuongGan)
me.AddStackItem(18,1,20323,1,self.tbItemInfo,szSoLuongGan)
me.Msg("<color=orange>Gắn <color=yellow>"..szSoLuongGan.." Huy Chương Vàng<color> lên Cờ Tổ Quốc, bạn nhận được <color=yellow>".. 10000000*szSoLuongGan .."<color> Kinh Nghiệm và <color=yellow>".. szSoLuongGan .." Lam Long Đơn (Thô)")
Task:DelItem(me, tbItemId1, szSoLuongGan);
me.SetTask(self.TASK_GROUP_ID1, self.TaskId_Count, nCount + szSoLuongGan);
KDialog.MsgToGlobal("<color=cyan>"..me.szName.."<color> <color=orange>gắn <color=yellow>"..szSoLuongGan.." Huy Chương Vàng<color> lên Cờ Tổ Quốc, nhận được <color=yellow>".. 10000000*szSoLuongGan .."<color> Kinh Nghiệm và <color=yellow>".. szSoLuongGan .." Lam Long Đơn (Thô)");	
return
end
me.AddExp(10000000*szSoLuongGan)
me.AddStackItem(18,1,20323,1,self.tbItemInfo,szSoLuongGan)
me.Msg("<color=orange>Gắn <color=yellow>"..szSoLuongGan.." Huy Chương Vàng<color> lên Cờ Tổ Quốc, bạn nhận được <color=yellow>".. 10000000*szSoLuongGan .."<color> Kinh Nghiệm và <color=yellow>".. szSoLuongGan .." Lam Long Đơn (Thô)")
Task:DelItem(me, tbItemId1, szSoLuongGan);
me.SetTask(self.TASK_GROUP_ID1, self.TaskId_Count, nCount + szSoLuongGan);
end