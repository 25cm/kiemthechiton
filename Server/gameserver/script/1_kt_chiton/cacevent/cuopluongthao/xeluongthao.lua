local tbXeLuongThao = Npc:GetClass("sltk_xeluongthao");
tbXeLuongThao.tbItemInfo = {bForceBind=1,};
function tbXeLuongThao:OnDialog()
DoScript("\\script\\event\\cacevent\\cuopluongthao\\xeluongthao.lua");
DoScript("\\script\\event\\cacevent\\cuopluongthao\\tangmau.lua");
DoScript("\\script\\event\\cacevent\\cuopluongthao\\tangdame.lua");
DoScript("\\script\\event\\cacevent\\cuopluongthao\\tangkhang.lua");
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
    GeneralProcess:StartProcess("Đang Lấy", 5 * Env.GAME_FPS, {self.GetQuest, self, me.nId, him.dwId}, nil, tbEvent);
end
function tbXeLuongThao:GetQuest(nPlayerId, nNpcId)
    local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
    if (not pPlayer) then
        return;
    end    
	me.AddItem(18,1,20324,1) -- Quân Lương
	 KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> cướp được <color=pink>Quân Lương<color><color>");	   
    local pNpc = KNpc.GetById(nNpcId);
    if (not pNpc) then
        return;
    end
	 pNpc.Delete();
	return 0;
end  