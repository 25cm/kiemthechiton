




local tb = Item:GetClass("linktask_worldmap");

function tb:OnUse()
	return;
end

function tb:PickUp(nX, nY)
	me.Msg("Nhận được 1 Địa Đồ Chí!");
	return 0;
end
