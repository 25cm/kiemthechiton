
-- 召唤道具 
-- zhengyuhua

local tbItem = Item:GetClass("domainzhaohuan")

function tbItem:OnUse()
	if Item:IsBindItemUsable(it, me.dwTongId) ~= 1 then
		return 0;
	end
	if Domain:GetBattleState() ~= Domain.BATTLE_STATE then
		me.Msg("Trong thời gian chinh chiến, mới có thể sử dụng Lệnh bài triệu hồi");
		return 0;
	end
	local nMapId, nX, nY = me.GetWorldPos()
	local bFight = Domain:HasBattleRight(me.dwTongId, nMapId);
	if bFight ~= 1 then
		me.Msg("Trong khu vực chinh chiến, mới có thể sử dụng Lệnh bài triệu hồi");
		return 0;
	end
	local tbOpenState = Domain:GetOpenStateTable();
	if not tbOpenState then
		return 0;	
	end
	local nTemplateId = it.GetExtParam(1);
	if Domain.tbGame[me.nMapId] then
		local pNpc = Domain.tbGame[me.nMapId]:AddTongNpc(nTemplateId, tbOpenState.nNpcLevel, me.dwTongId, nX, nY, 0, 2)
		if pNpc then
			local pOwner = KUnion.GetUnion(me.dwUnionId) or KTong.GetTong(me.dwTongId);
			if pOwner then
				pNpc.SetTitle(pOwner.GetName());
			end
			return 1;
		end
	end
	return 0;
end

-- TODO
function tbItem:GetTip(nState)
	local nOwnerTongId = KLib.Number2UInt(it.GetGenInfo(Item.TASK_OWNER_TONGID, 0));
	if nState == Item.TIPS_SHOP then
		return "<color=gold>Đạo cụ này sau khi mua <color=red>sẽ khóa bang hội<color>, người ngoài không thể sử dụng!<color>";
	elseif nOwnerTongId == 0 then
		return "<color=gold>Đạo cụ này không khóa bang hội, bất cứ ai cũng có thể sử dụng<color>";
	elseif nOwnerTongId == me.dwTongId then
		return "<color=gold>Đạo cụ này đã khóa bang hội, người bang hội khác không thể sử dụng<color>";
	else
		return "<color=red>Đạo cụ này đã khóa bang hội, bạn không thể sử dụng!<color>"
	end
end
