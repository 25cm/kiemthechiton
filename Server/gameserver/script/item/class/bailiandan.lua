
local tbBailiandan = Item:GetClass("bailiandan");
tbBailiandan.MAX_USE_COUNT = 200;

function tbBailiandan:OnUse()
	if me.GetBaiLianDanUseCount() >= self.MAX_USE_COUNT then
		me.Msg("Tối đa <color=yellow>"..self.MAX_USE_COUNT.."<color>, bạn không thể dùng được nữa.");
		return 0;
	end
	
	if me.nLevel < it.nReqLevel then
		me.Msg("Bạn chưa đạt cấp "..it.nReqLevel..", không thể dùng Bách Luyện Đơn.");
		return 0;
	end
	
	local nAddExp = 130 * me.nLevel^2 + 2600 * me.nLevel + 9750;
	
	me.AddExp(nAddExp);
	me.AddBaiLianDanUseCount(1);
	me.Msg("Bạn đã sử dụng <color=yellow>"..me.GetBaiLianDanUseCount()..
		"<color> Bách Luyện Đơn, dùng tối đa <color=yellow>"..self.MAX_USE_COUNT.."<color>.");
	return 1;
end

function tbBailiandan:GetTip(nState)
	local nAddExp = 130 * me.nLevel^2 + 2600 * me.nLevel + 9750;
	local szTip = "Dùng vật phẩm này có thể nhận được <color=yellow>"..nAddExp.."<color> kinh nghiệm.";
	return szTip;
end
