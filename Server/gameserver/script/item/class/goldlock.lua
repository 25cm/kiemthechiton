
local GoldnLok = Item:GetClass("goldlock");

function GoldnLok:OnUse()
	if (me.GetMaxCarryMoney() < 20000000) then
			me.Msg("Sau khi sử dụng, bạc khóa trên người bạn sẽ quá giới hạn cho phép, hãy kiểm tra lại trước khi sử dụng.");
			return 0;
	end
	me.AddBindMoney(20000000);
	return 1;
end
