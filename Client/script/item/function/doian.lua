
if not Item.AnGift  then
	Item.AnGift  = {};
end

local tbGift = Item.AnGift;

function tbGift:CheckGiftItem(tbGiftSelf, pPickItem, pDropItem, nX, nY)
	if pDropItem then
		if (pDropItem.szClass ~= Item.UPGRADE_EQUIP_CLASS) then
			me.Msg("Vật phẩm này không phải là Ấn, không thể tách.");
			return 0;
		end
	end
	return 1;
end
