
local tbItem = Item:GetClass("merchant")

function tbItem:InitGenInfo()
	-- 設定有效期限
	it.SetTimeOut(1, 12 * 60);
	return	{ };
end
