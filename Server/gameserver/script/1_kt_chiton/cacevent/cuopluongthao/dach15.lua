local tbItem	= Item:GetClass("THK_dach15");
function tbItem:OnUse()
DoScript("\\script\\event\\cacevent\\cuopluongthao\\dach15.lua");
	local szMsg = "Đặt vào Item Cần Cường Hóa";
	Dialog:OpenGift(szMsg, nil, {self.CuongHoa, self, 1});
end
function tbItem:CuongHoa(nValue, tbItemObj)
local tbItemId1	= {18,1,20326,1,0,0}; -- Lam Long Đơn (Thô)
	local tbItemInfo = {bForceBind=1,};
	local tbItemList	= {};
	local nCount = 0; 
    for i = 1, #tbItemObj do 
        nCount = nCount + tbItemObj[i][1].nCount; 
    end 
    --Check đúng 15 Mảnh ghép hay không? 
    if nCount ~= 1 then 
        Dialog:Say("Chỉ được đặt vào 1 vật phẩm", {"Ta biết rồi !"}); 
        return 0; 
    end 
	for _, pItem in pairs(tbItemObj) do
	if pItem[1].szName == "Phi Phong Song Long Huyền Thoại" then
	Dialog:Say("Cái này mà củng đòi nâng cấp");
	return;
	end	
		local pItem1 =	me.AddItem(pItem[1].nGenre, pItem[1].nDetail, pItem[1].nParticular, pItem[1].nLevel,nil,15);
		pItem1.Bind(1)
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> sử dụng <color=pink>Đá Cường Hóa 15<color> cường hóa <color=green>"..pItem1.szName.."<color> lên 15 không mất Huyền Tinh và Tiền<color>");	   
me.ConsumeItemInBags(1, 18, 1, 20326, 1);
	end
	for _, pItem in pairs(tbItemObj) do
		if me.DelItem(pItem[1]) ~= 1 then
			return 0;
		end
	end
end