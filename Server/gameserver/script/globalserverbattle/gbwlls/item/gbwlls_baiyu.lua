-- °×Óñ
local tbItem = Item:GetClass("baiyu");

function tbItem:OnUse()
	local nFlag = Player:AddRepute(me, 12, 1, 480);

	if (0 == nFlag) then
		return;
	elseif (1 == nFlag) then
		me.Msg("Danh Vong Lien Dau Lien Server dat cap cao nhat. Khong the su dung them LB Danh Vong");
		return;
	end
	return 1;
end