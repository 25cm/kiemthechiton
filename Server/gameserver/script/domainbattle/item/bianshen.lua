-- 文件名　：bianshen.lua
-- 创建者　：xiewen
-- 创建时间：2008-11-07 10:46:46

-- 变身道具

local tbBianshen = Item:GetClass("bianshenlingpai");

tbBianshen.nSkillId		=	889;

function tbBianshen:OnUse()
	tbBianshen.nDuration = Env.GAME_FPS * it.GetExtParam(1);

	local pNpc = me.GetNpc();
	if not pNpc or pNpc.GetRangeDamageFlag() ~= 1 then
		me.Msg("Ngươi phải sử dụng đạo cụ này trong trạng thái chiến đấu");
		return 0;
	end

	if me.nLevel < it.nReqLevel then
		me.Msg("Đẳng cấp không đủ, không thể sử dụng đạo cụ biến thân.");
		return 0;
	end

	if Item:IsBindItemUsable(it, me.dwTongId) ~= 1 then
		return 0;
	end

	local tbOpenState = Domain:GetOpenStateTable();
	if not tbOpenState then
		print("Domain:GetOpenStateTable() failed");
		return 0;		
	end
	local a,b = it.GetTimeOut();
	if b == 0 then
		me.SetItemTimeout(it,os.date("%Y/%m/%d/%H/%M/00", GetTime() + 3600 * 24)); -- 领取当天有效
		it.Sync();
	end
	it.Bind(1);		-- 强制绑定
	me.AddSkillState(tbBianshen.nSkillId, tbOpenState.nSkillLevel, 0, tbBianshen.nDuration, 1, 1);
	return	0;
end

-- TODO
function tbBianshen:GetTip(nState)
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
