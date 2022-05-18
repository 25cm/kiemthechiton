-------------------------------------------------------------------
--Describe:	增加武林大会专用绑银道具

local tbKuaFuHuoBi = Item:GetClass("kuafuhuobi");

function tbKuaFuHuoBi:OnUse()
	local nValue = it.GetExtParam(1);
	if nValue <= 0 then
		return 0;
	end
	if GLOBAL_AGENT then
		me.Msg("Rất tiếc, bạc khóa chuyên dùng cho hoạt động liên server chỉ sử dụng tại máy chủ thông thường.")
		return 0;
	end
	local nCurrentMoney = KGCPlayer.OptGetTask(me.nId, KGCPlayer.TSK_CURRENCY_MONEY);
	if nCurrentMoney + nValue <= me.GetMaxCarryMoney() then
		GCExcute{"Player:Nor_DataSync_GC", me.szName, nValue}
		me.Msg("Bạn tăng "..nValue.." bạc khóa chuyên dùng cho hoạt động liên server.");
		return 1;
	else
		me.Msg("Rất tiếc, bạc khóa chuyên dùng cho hoạt động liên server đã đạt mức cao nhất, không thể sử dụng vật phẩm.")
		return 0;
	end
end
