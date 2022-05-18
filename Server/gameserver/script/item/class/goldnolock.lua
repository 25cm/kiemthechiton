
local GoldnLok = Item:GetClass("goldnolock");

function GoldnLok:OnUse()
	if me.GetMaxCarryMoney() < 15000000 then
			me.Msg("Sau khi sử dụng, bạc trên người bạn sẽ quá giới hạn cho phép, hãy kiểm tra lại trước khi sử dụng.");
			return 0;
		end
	me.Earn(15000000,0);
	return 1;
end
