
-- 金犀

------------------------------------------------------------------------------------------
-- initialize

local tbJinxi = Item:GetClass("jinxi");

------------------------------------------------------------------------------------------
-- public

function tbJinxi:InitGenInfo()
	return	{ it.GetExtParam(1) };		-- 初始化金犀耐久
end

function tbJinxi:OnUse()					-- 准备道具修理
	me.PrepareItemRepair(it.dwId);
	return	0;
end

function tbJinxi:GetTip(nState)
	local szTip = "";
	szTip = szTip.."<color=0x8080ff>Số điểm còn có thể dùng: "..it.GetGenInfo(1).."<color>";
	return	szTip;
end
