
-- 背包脚本
-- zhengyuhua

local tbBag = Item:GetClass("extbag");

function tbBag:GetTip()
	if it.GetBagPosLimit() > 0 then
		return string.format("<color=gold>Túi này chỉ có thể đặt trong ô túi thứ %d!", it.GetBagPosLimit());
	end
	return ""
end





