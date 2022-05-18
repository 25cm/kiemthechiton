-------------------------------------------------------------------
--Describe:	增加武林大会专用绑银道具

local tbBangYin = Item:GetClass("bangyin");

function tbBangYin:OnUse()
	local nValue = it.GetExtParam(1);
	if nValue <= 0 then
		return 0;
	end
	local nCurrentMoney = KGCPlayer.OptGetTask(me.nId, KGCPlayer.TSK_CURRENCY_MONEY);
	if nCurrentMoney + nValue <= me.GetMaxCarryMoney() then
		GCExcute{"Player:Nor_DataSync_GC", me.szName, nValue}
		me.Msg("Bạn đã tăng thành công"..nValue.."Hai lượng bạc cho các giải đấu võ thuật。");
	else
		me.Msg("Xin lỗi, lượng bạc đặc biệt dành cho đấu võ trên người của ngươi sau khi sử dụng vật phẩm sẽ đạt đến giới hạn trên, hiện tại vẫn chưa thể sử dụng。")
	end
	return 1;
end