-- 文件名　：wldh_wulinyingxiong.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-09-23 16:11:42
-- 描  述  ：

local tbItem = Item:GetClass("wldh_wulinyingxiong");

function tbItem:OnUse()
	local nFlag = Player:AddRepute(me, 11, 1, 480);

	if (0 == nFlag) then
		return;
	elseif (1 == nFlag) then
		me.Msg("Danh Vong Dai Hoi Vo Lam dat cap cao nhat. Khong the su dung them LB Danh Vong");
		return;
	end
	return 1;
end
