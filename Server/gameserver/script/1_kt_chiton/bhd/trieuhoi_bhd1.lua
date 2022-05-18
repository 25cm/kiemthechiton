local tbtrieuhoi_bhd1 = Npc:GetClass("trieuhoi_bhd1");
function tbtrieuhoi_bhd1:OnDialog()
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
GeneralProcess:StartProcess("Triệu hồi <color=yellow>Boss Bạch Hổ Đường 1<color=yellow>", 0.5 * Env.GAME_FPS, {self.ThuThap111, self, me.nId, him.dwId}, nil, tbEvent);
	 };
	 end
	 
function tbtrieuhoi_bhd1:ThuThap111(nPlayerId, nNpcId)
local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)

	if (not pPlayer) then
		return;
	end	
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc) then
		return;
	end
	local nNowMinute = tonumber(GetLocalDate("%M"));
	if (nNowMinute >= 5 and nNowMinute <= 7) then
			local nMapId = me.GetWorldPos();		
	if (nMapId == 236) then
				local nMapId, nPosX, nPosY = me.GetWorldPos();
local pNpc = KNpc.Add2(2661, 110, 0, nMapId, nPosX, nPosY)				
ClearMapNpcWithName(236, "Tạp Giới Chuyển Sinh");
me.Msg("Bạn triệu hồi thành công <color=yellow>Thủ Lĩnh Bạch Hổ Đường Tầng 1<color>");
local msg = "Sau một thời gian ẩn thân <color=green>Thủ Lĩnh Bạch Hổ Đường 1<color> đã xuất hiện ở <color=gold>Tầng 1 - Bạch Hổ Đường_Tây [Cao]<color>";
   GlobalExcute({"Dialog:GlobalNewsMsg_GS", msg});
	KDialog.NewsMsg(0, Env.NEWSMSG_COUNT, msg);
	KDialog.MsgToGlobal(msg);
	end				
		elseif (nNowMinute >= 0 and nNowMinute <= 4) then
Dialog:Say("Trong khoảng thời gian: (từ phút thứ 5 đến phút thứ 7) mới triệu hồi được <color=yellow>Thủ Lĩnh Bạch Hổ Đường Tầng 1<color>")		
	elseif (nNowMinute >= 8 and nNowMinute <= 29) then
Dialog:Say("Trong khoảng thời gian: (từ phút thứ 5 đến phút thứ 7) mới triệu hồi được <color=yellow>Thủ Lĩnh Bạch Hổ Đường Tầng 1<color>")	
		elseif (nNowMinute >= 30 and nNowMinute <= 59) then
Dialog:Say("Bạch Hổ Đường chưa mở!<color>")

	end
	end----------------------------------------------