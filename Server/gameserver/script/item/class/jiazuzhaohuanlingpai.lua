Require("\\script\\item\\class\\zhaohuanlingpailogic.lua");

local tbItem = Item:GetClass("jiazuzhaohuanlingpai");
tbItem.nTime = 10;							-- 延时的时间(秒)

tbItem.tbItemList = {
		[87] = 10,		--家族召唤令牌，10次；
	}
function tbItem:OnUse()
	local pPlayer = me;
	
	local nCanSendIn  = Item:IsCallInAtMap(pPlayer.nMapId, unpack(it.TbGDPL()));
	if (nCanSendIn ~= 1) then
		pPlayer.Msg("Đạo cụ này không thể dùng trong bản đồ này.")
		return 0;
	end
	local nKinId, nKinMemId = pPlayer.GetKinMember();
	if nKinId == nil or nKinId <= 0 then
		pPlayer.Msg("Bạn chưa có gia tộc, không thể dùng Lệnh bài triệu hồi gia tộc.")
		return 0;
	end
	if pPlayer.nKinFigure <= 0 or pPlayer.nKinFigure >= 4 then
		pPlayer.Msg("Chỉ có thành viên gia tộc mới dùng được Lệnh bài triệu hồi gia tộc.")
		return 0;		
	end
	local tbOpt = 
	{
		{"Sử dụng",self.SendAllMember, self, it.dwId},
		{"Rời khỏi"},
	}
	Dialog:Say("Bạn có muốn dùng Lệnh bài triệu hồi gia tộc triệu hồi các thành viên gia tộc đang online đến không?",tbOpt);
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
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
	};
	if (0 == pPlayer.nFightState) then				-- 玩家在非战斗状态下传送无延时正常传送
		self:SendAllMemberSuccess(pPlayer.nId, nItemId)
		return 0;
	end
	GeneralProcess:StartProcess("Đang gửi yêu cầu triệu hồi...", self.nTime * Env.GAME_FPS, {self.SendAllMemberSuccess, self, pPlayer.nId, nItemId}, nil, tbEvent);	-- 在战斗状态下需要nTime秒的延时
end


function tbItem:SendAllMemberSuccess(nPlayerId, nItemId)

	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	if pPlayer == nil then
		return 0;
	end
	local nKinId, nKinMemId = pPlayer.GetKinMember();
	if pPlayer.nKinFigure <= 0 or pPlayer.nKinFigure >= 4 then
		pPlayer.Msg("Chỉ có thành viên gia tộc mới dùng được Lệnh bài triệu hồi gia tộc.")
		return 0;
	end
	local pItem = KItem.GetObjById(nItemId);
	if pItem == nil then
		pPlayer.Msg("Lệnh bài triệu hồi gia tộc của bạn đã bị xóa, thao tác có bất thường, hãy liên hệ GM.");
		return 0; 
	end	
	local nMapId, nPosX, nPosY = pPlayer.GetWorldPos();
	local nUseCount = pItem.GetGenInfo(1,0);
	if self.tbItemList[pItem.nParticular] - nUseCount <= 1 then
		if (pPlayer.DelItem(pItem, Player.emKLOSEITEM_USE) ~= 1) then
			pPlayer.Msg("Xóa Lệnh bài triệu hồi gia tộc thất bại!");
			return 0;
		end
	else
		pItem.SetGenInfo(1,nUseCount + 1);
		pItem.Sync();
	end
	local nFightState = pPlayer.nFightState;
	GCExcute({"Item.tbZhaoHuanLingPai:SelectPlayer", 1, nMapId, nPosX, nPosY, nPlayerId, nKinId, pPlayer.szName, nFightState});
	pPlayer.Msg("Bạn đã dùng Lệnh bài triệu hồi gia tộc thành công, tất cả các thành viên gia tộc đang online sẽ nhận được lời triệu hồi.");
end


function tbItem:GetTip(nState)
	local nUseCount = it.GetGenInfo(1,0)
	local nLastCount = self.tbItemList[it.nParticular] - nUseCount;
	local szTip = "";
	szTip = szTip..string.format("<color=0x8080ff>Nhấn chuột phải dùng<color>\n");
	szTip = szTip..string.format("<color=yellow>Số lần dùng còn: %s<color>",nLastCount);
	return szTip;
end

