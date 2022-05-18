local tbdanhtrong1 = Npc:GetClass("danhtrong1");
function tbdanhtrong1:OnDialog()
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
GeneralProcess:StartProcess("Đang đánh Trống", 5 * Env.GAME_FPS, {self.ThuThap111, self, me.nId, him.dwId}, nil, tbEvent);
	 };
	 end
	 
function tbdanhtrong1:ThuThap111(nPlayerId, nNpcId)
local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)

	if (not pPlayer) then
		return;
	end	
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc) then
		return;
	end
    me.AddJbCoin(30000);
	me.AddExp(1000000);
	me.Msg("Nhận được <color=yellow>3 Vạn Đồng<color>");
    me.Msg("Nhận được <color=yellow>1 Triệu Kinh Nghiệm<color>");
	pNpc.Delete();
		GlobalExcute({"Dialog:GlobalNewsMsg_GS","Người chơi<color=green> "..me.szName.."<color> nhanh tay  <color=red>Đánh Trống Cổ Vũ Server<color> nhận thưởng <color=gold>3 Vạn Đồng<color>"});
	KDialog.MsgToGlobal("Người chơi<color=green> "..me.szName.."<color> nhanh tay  <color=yellow>Đánh Trống Cổ Vũ Server<color> nhận thưởng <color=gold>3 Vạn Đồng<color>");
	
	end
----------------------------------------------