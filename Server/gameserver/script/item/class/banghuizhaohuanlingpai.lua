-------------------------------------------------------------------
--File: 	
--Author: 	sunduoliang
--Date: 		2008-4-14
--Describe:	帮会召唤令牌
-------------------------------------------------------------------
Require("\\script\\item\\class\\zhaohuanlingpailogic.lua");

-- 帮会召唤令牌
local tbItem = Item:GetClass("banghuizhaohuanlingpai");
tbItem.nTime = 10;							-- 延时的时间(秒)
function tbItem:OnUse()
	do return end --暂时不开放
	local pPlayer = me;
	local nTongId = pPlayer.dwTongId;
	if nTongId == nil or nTongId <= 0 then
		pPlayer.Msg("Bạn không có trong bang hội, không thể sử dụng vật phẩm.")
		return 0;
	end
	local nSelfKinId, nSelfMemberId = pPlayer.GetKinMember();
	if Tong:CheckSelfRight(nTongId, nSelfKinId, nSelfMemberId, 0) ~= 1 then
		pPlayer.Msg("Chỉ có bang chủ hoặc trưởng lão mới có quyền sử dụng Lệnh bài triệu hồi bang hội!");
		return 0;
	end
	local tbOpt = 
	{
		{"Sử dụng",self.SendAllMember, self, it.dwId},
		{"Hủy bỏ"},
	}
	Dialog:Say("Bạn có muốn sử dụng Lệnh bài triệu hồi bang hội, tất cả các thành viên bang hội sẽ được triệu hồi?",tbOpt);
	return 0;
end

function tbItem:SendAllMember(nItemId)
	local pPlayer = me;
	local tbEvent	= {						-- 会中断延时的事件
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SITE,
		Player.ProcessBreakEvent.emEVENT_USEITEM,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_DROPITEM,
		Player.ProcessBreakEvent.emEVENT_SENDMAIL,
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_DEATH,
	};
	if (0 == pPlayer.nFightState) then				-- 玩家在非战斗状态下传送无延时正常传送
		self:SendAllMemberSuccess(pPlayer.nId, nItemId)
		return 0;
	end
	GeneralProcess:StartProcess("Đang gửi yêu cầu triệu hồi...", self.nTime * Env.GAME_FPS, {self.SendAllMemberSuccess, self, pPlayer.nId, nItemId}, nil, tbEvent);	-- 在战斗状态下需要nTime秒的延时
end


-- 功能:	召唤玩家
-- 参数:	nMapId 要传至的报名点的Id
function tbItem:SendAllMemberSuccess(nPlayerId, nItemId)

	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	if pPlayer == nil then
		return 0;
	end
	
	local nTongId = pPlayer.dwTongId;
	if nTongId == nil or nTongId <= 0 then
		pPlayer.Msg("Bạn không có trong bang hội, không thể sử dụng vật phẩm.")
		return 0;
	end
	
	local nSelfKinId, nSelfMemberId = pPlayer.GetKinMember();
	if Tong:CheckSelfRight(nTongId, nSelfKinId, nSelfMemberId, 0) ~= 1 then
		pPlayer.Msg("Chỉ có bang chủ hoặc trưởng lão mới có quyền sử dụng Lệnh bài triệu hồi bang hội!");
		return 0;
	end
	
	local pItem = KItem.GetObjById(nItemId);
	if pItem == nil then
		pPlayer.Msg("Lệnh bài triệu hồi bang hội của bạn đã bị xóa, có hành vi bất hợp pháp xảy ra, xin vui lòng liên hệ GM.");
		return 0; 
	end	
	local nMapId, nPosX, nPosY = pPlayer.GetWorldPos();
	if (pPlayer.DelItem(pItem, Player.emKLOSEITEM_USE) ~= 1) then
		pPlayer.Msg("Xóa Lệnh bài triệu hồi bang hội thất bại!");
		return 0;
	end
	local nFightState = pPlayer.nFightState;
	--对所有帮会成员发送请求
	GCExcute({"Item.tbZhaoHuanLingPai:SelectPlayer", 2, nMapId, nPosX, nPosY, nPlayerId, nTongId, pPlayer.szName, nFightState});
	pPlayer.Msg("Bạn đã sử dụng thành công Lệnh bài triệu hồi bang hội, các thành viên sẽ nhận được thông báo yêu cầu triệu hồi.");
end

