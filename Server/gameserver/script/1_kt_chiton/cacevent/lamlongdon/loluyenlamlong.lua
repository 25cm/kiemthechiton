local tbLoLuyenLLD = Npc:GetClass("sltk_loluỵenlld");
tbLoLuyenLLD.tbItemInfo = {bForceBind=1,};
function tbLoLuyenLLD:OnDialog()
DoScript("\\script\\event\\cacevent\\lamlongdon\\loluyenlamlong.lua");
local nCount1 = me.GetItemCountInBags(18,1,20323,1); -- Lam Long Đơn (Thô)
local nCount23 = me.GetJbCoin() -- Get Đồng
local tbItemId1	= {18,1,20323,1,0,0};
local szMsg = "1 <color=yellow>Lam Long Đơn (Thô)<color> + 7000 Đồng = 1 <color=yellow>Lam Long Đơn<color>"
local tbOpt = { 
{"Luyện <color=blue>Lam Long Đơn<color>",self.LuyenLamLongDon,self};
}; 
Dialog:Say(szMsg, tbOpt);
end
function tbLoLuyenLLD:LuyenLamLongDon()
	if me.CountFreeBagCell() < 10 then
		Dialog:Say("Hành Trang không đủ chỗ trống.Hãy sắp xếp còn trống 10 ô rồi quay lại gặp ta！");
		return 0;
	end
local nCount1 = me.GetItemCountInBags(18,1,20323,1); -- Lam Long Đơn (Thô)
if nCount1 ==0 then
Dialog:Say("Trong người không có Lam Long Đơn (Thô)")
return
end
Dialog:AskNumber("Số Lượng Luyện Hóa", nCount1, self.luyenhoa, self);
end
function tbLoLuyenLLD:luyenhoa(szIDVatPham)
if szIDVatPham > 200 then
Dialog:Say("Mỗi lần luyện hóa tối đa là 200 Lam Long Đơn (Thô)")
return
end
local tbItemId1	= {18,1,20323,1,0,0}; -- Lam Long Đơn (Thô)
local nCount1 = me.GetItemCountInBags(18,1,20323,1); -- Lam Long Đơn (Thô)
local nCount23 = me.GetJbCoin() -- Get Đồng
if (szIDVatPham*7000) > nCount23 then
Dialog:Say("Để luyện hóa "..szIDVatPham.." Lam Long Đơn (Thô) cần ".. szIDVatPham*7000 .." Đồng")
return
end
me.AddStackItem(18,1,20322,1,nil,szIDVatPham);
me.AddJbCoin(-7000*szIDVatPham)
-- KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> luyện hóa "..szIDVatPham.." Lam Long Đơn (Thô) thành "..szIDVatPham.." Lam Long Đơn<color>");	
me.Msg("Luyện hóa thành công "..szIDVatPham.." Lam Long Đơn , tiêu hao ".. szIDVatPham*7000 .." Đồng")
Task:DelItem(me, tbItemId1, szIDVatPham);
end
