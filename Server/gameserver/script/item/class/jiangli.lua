-------------------------------------------------------------------
--Describe:	增加奖励基金道具

local tbJiangLi = Item:GetClass("jiangli");
tbJiangLi.ADD_GREAT_BOUNS = 1000000;
function tbJiangLi:OnUse()
	local pTong = KTong.GetTong(me.dwTongId);
	if not pTong then
		me.Msg("Không phải thành viên bang hội, không thể sử dụng!");
		return 0;
	end
	if Tong:AddGreatBonus_GS(me.dwTongId, tbJiangLi.ADD_GREAT_BOUNS) == 0 then
		me.Msg("Quỹ thưởng bang đã đạt mức giới hạn");
		return 0;
	end
	me.Msg("Quỹ thưởng bang hội <color=yellow>"..(tbJiangLi.ADD_GREAT_BOUNS/10000).."<color>");
	KTong.Msg2Tong(me.dwTongId, me.szName.." tăng quỹ bang hội <color=green>"..(tbJiangLi.ADD_GREAT_BOUNS/10000).."<color>");
	return 1;
end
