local tbthucung1 = Npc:GetClass("thucung1");
function tbthucung1:OnDialog()
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
GeneralProcess:StartProcess("Đang bắt", 5 * Env.GAME_FPS, {self.ThuThap111, self, me.nId, him.dwId}, nil, tbEvent);
	 };
	 end
	 
function tbthucung1:ThuThap111(nPlayerId, nNpcId)
local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)

	if (not pPlayer) then
		return;
	end	
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc) then
		return;
	end
    me.AddStackItem(18,1,1333,10,nil,2)
    me.AddStackItem(18,1,1334,10,nil,5)	
	me.AddExp(300000);
	me.Msg("Nhận được <color=yellow>2 Chân Nguyên Tu Luyện Đơn<color>");
	me.Msg("Nhận được <color=yellow>5 Thánh Linh Bảo Hạp Hồn<color>");	
    me.Msg("Nhận được <color=yellow>300.000 Kinh Nghiệm<color>");
	pNpc.Delete();
	end
----------------------------------------------