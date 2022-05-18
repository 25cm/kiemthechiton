local tbBeBanhBao = Npc:GetClass("thk_bebanhbao");
tbBeBanhBao.tbItemInfo = {
        bForceBind=1,
};
function tbBeBanhBao:OnDialog()
DoScript("\\script\\event\\cacevent\\tetthieunhi\\bebanhbao.lua");
local msg = "<color=cyan>Bé Bánh Bao<color> xin chào "..me.szName.." !"
local tbOpt = { 
{"Tặng <color=green>Bánh Ngọc Bích<color>",self.Give_BanhNgocBich,self};
{"Tặng <color=red>Bánh Hồng Ngọc<color>",self.Give_BanhHongNgoc,self};
{"Tặng <color=gold>Bánh Pha Lê<color>",self.Give_BanhPhaLe,self};
}; 
Dialog:Say(msg, tbOpt);
end
function tbBeBanhBao:Give_BanhNgocBich()
local tbItemId1	= {18,1,2085,1,0,0}; -- Bánh Ngọc Bích
local nCount1 = me.GetItemCountInBags(18,1,2085,1) -- Bánh Ngọc Bích
if nCount1 < 1 then
Dialog:SendBlackBoardMsg(me, string.format("Cần <color=green>Bánh Ngọc Bích<color> !"));
return
end
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
    GeneralProcess:StartProcess("Đang Tặng", 5 * Env.GAME_FPS, {self.Give_BanhNgocBich_OK, self, me.nId, him.dwId}, self.tbItemInfo, tbEvent); -- 5s Thuần Phục
	 };
end
function tbBeBanhBao:Give_BanhNgocBich_OK(nPlayerId, nNpcId)
local tbItemId1	= {18,1,2085,1,0,0}; -- Bánh Ngọc Bích
local nCount1 = me.GetItemCountInBags(18,1,2085,1) -- Bánh Ngọc Bích
  local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
    if (not pPlayer) then
        return;
    end    
-------
me.AddExp(30000000) -- 30tr EXp
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> tặng <color=green>Bé Bánh Bao<color> <color=green>Bánh Ngọc Bích<color> nhận lại <color=green>30tr Điểm Kinh Nghiệm<color><color>");	
-------
Task:DelItem(me, tbItemId1, 1);
local pNpc = KNpc.GetById(nNpcId);
pNpc.Delete();
if (not pNpc) then
return;
end
pNpc.Delete();
return 0;
end

function tbBeBanhBao:Give_BanhHongNgoc()
local tbItemId1	= {18,1,2088,1,0,0}; -- Bánh Hồng Ngọc
local nCount1 = me.GetItemCountInBags(18,1,2088,1) -- Bánh Hồng Ngọc
if nCount1 < 1 then
Dialog:SendBlackBoardMsg(me, string.format("Cần <color=red>Bánh Hồng Ngọc<color> !"));
return
end
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
    GeneralProcess:StartProcess("Đang Tặng", 5 * Env.GAME_FPS, {self.Give_BanhHongNgoc_OK, self, me.nId, him.dwId}, self.tbItemInfo, tbEvent); -- 5s Thuần Phục
	 };
end
function tbBeBanhBao:Give_BanhHongNgoc_OK(nPlayerId, nNpcId)
local tbItemId1	= {18,1,2088,1,0,0}; -- Bánh Hồng Ngọc
local nCount1 = me.GetItemCountInBags(18,1,2088,1) -- Bánh Hồng Ngọc
  local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
    if (not pPlayer) then
        return;
    end    
-------
me.AddExp(50000000) -- 50tr EXp
me.AddStackItem(18,1,1,8,self.tbItemInfo,1) -- 1 Huyền Tinh 8
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> tặng <color=green>Bé Bánh Bao<color> <color=red>Bánh Hồng Ngọc<color> nhận lại <color=green>50tr Điểm Kinh Nghiệm<color> và <color=green>1 Huyền Tinh (Cấp 8)<color><color>");	
-------
Task:DelItem(me, tbItemId1, 1);
local pNpc = KNpc.GetById(nNpcId);
pNpc.Delete();
if (not pNpc) then
return;
end
pNpc.Delete();
return 0;
end

function tbBeBanhBao:Give_BanhPhaLe()
local tbItemId1	= {18,1,2091,1,0,0}; -- Bánh Pha Lê
local nCount1 = me.GetItemCountInBags(18,1,2091,1) -- Bánh Pha Lê
if nCount1 < 1 then
Dialog:SendBlackBoardMsg(me, string.format("Cần <color=gold>Bánh Pha Lê<color> !"));
return
end
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
    GeneralProcess:StartProcess("Đang Tặng", 5 * Env.GAME_FPS, {self.Give_BanhPhaLe_OK, self, me.nId, him.dwId}, self.tbItemInfo, tbEvent); -- 5s Thuần Phục
	 };
end
function tbBeBanhBao:Give_BanhPhaLe_OK(nPlayerId, nNpcId)
local tbItemId1	= {18,1,2091,1,0,0}; -- Bánh Pha Lê
local nCount1 = me.GetItemCountInBags(18,1,2091,1) -- Bánh Pha Lê
  local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
    if (not pPlayer) then
        return;
    end    
-------
me.AddExp(70000000) -- 70tr EXp
me.AddStackItem(18,1,1,9,self.tbItemInfo,1) -- 1 Huyền Tinh 9
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> tặng <color=green>Bé Bánh Bao<color> <color=gold>Bánh Pha Lê<color> nhận lại <color=green>70tr Điểm Kinh Nghiệm<color> và <color=green>1 Huyền Tinh (Cấp 9)<color><color>");	
-------
Task:DelItem(me, tbItemId1, 1);
local pNpc = KNpc.GetById(nNpcId);
pNpc.Delete();
if (not pNpc) then
return;
end
pNpc.Delete();
return 0;
end