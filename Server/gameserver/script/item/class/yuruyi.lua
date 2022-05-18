
local tbYuruyi = Item:GetClass("yuruyi");

function tbYuruyi:OnUse()
	local pPlayer 		= me;
	local nShengWang 	= 1;
	local nFlag			= Player:AddRepute(pPlayer, 10, 1, nShengWang);
	
	if (0 == nFlag) then
		return;
	elseif (1 == nFlag) then
		pPlayer.Msg("Bạn đã đạt cấp cao nhất của danh vọng Đại đoàn viên dân tộc, không thể sử dụng Ngọc Như Ý");
		return;
	end
	
	return 1;	
end
