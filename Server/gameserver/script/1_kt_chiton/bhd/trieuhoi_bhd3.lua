local tbtrieuhoi_bhd3 = Npc:GetClass("trieuhoi_bhd3");
function tbtrieuhoi_bhd3:OnDialog()
	local tbEvent = 
	{
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
	}
	 local tbOpt = {
GeneralProcess:StartProcess("Triệu hồi <color=yellow>Boss BHĐ 3<color=yellow>", 0.5 * Env.GAME_FPS, {self.ThuThap111, self, me.nId, him.dwId}, nil, tbEvent);
	 };
	 end
	 
function tbtrieuhoi_bhd3:ThuThap111(nPlayerId, nNpcId)
local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)

	if (not pPlayer) then
		return;
	end	
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc) then
		return;
	end
	local nNowMinute = tonumber(GetLocalDate("%M"));
			if (nNowMinute >= 20 and nNowMinute <= 29) then
			local nMapId = me.GetWorldPos();
			if (nMapId == 240) then
			local nMapId, nPosX, nPosY = me.GetWorldPos();
local pNpc = KNpc.Add2(2688, 125, 0, nMapId, nPosX, nPosY)
ClearMapNpcWithName(240, "Tạp Giới Chuyển Sinh");
me.Msg("Bạn triệu hồi thành công <color=yellow>Thủ Lĩnh Bạch Hổ Đường Tầng 3<color>");
	end	
	
		elseif (nNowMinute >= 0 and nNowMinute <= 19) then
Dialog:Say("Sau phút thứ: 20 mới triệu hồi được <color=yellow>Thủ Lĩnh Bạch Hổ Đường Tầng 3<color>")		
	end
	end----------------------------------------------