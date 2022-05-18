local tbLamKyLanDoiThoai = Npc:GetClass("satthu95_lamkylan");
tbLamKyLanDoiThoai.tbItemInfo = {
        bForceBind=1,
};
function tbLamKyLanDoiThoai:OnDialog()
DoScript("\\script\\event\\cacevent\\tetthieunhi\\hoakylan_dialog.lua");
local tbItemId1	= {18,1,2072,1,0,0}; -- 300 Bài Hát Thiếu Nhi
local nCount1 = me.GetItemCountInBags(18,1,2072,1) -- 300 Bài Hát Thiếu Nhi
if nCount1 < 1 then
Dialog:SendBlackBoardMsg(me, string.format("Để thuần phục <color=blue>Lam Kỳ Lân<color> cần <color=yellow> 1 Quyển 300 Bài Hát Thiếu Nhi<color> !"));
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
    GeneralProcess:StartProcess("Đang Thuần Phục", 5 * Env.GAME_FPS, {self.GetQuest, self, me.nId, him.dwId}, nil, tbEvent); -- 5s Thuần Phục
	 };
end
function tbLamKyLanDoiThoai:GetQuest(nPlayerId, nNpcId)
  local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
    if (not pPlayer) then
        return;
    end    
-------
local tbItemId1	= {18,1,2072,1,0,0}; -- 300 Bài Hát Thiếu Nhi
local nCount1 = me.GetItemCountInBags(18,1,2072,1) -- 300 Bài Hát Thiếu Nhi
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	nRand = MathRandom(1, 100);
	local tbRate = {50, 30, 15, 5}; -- Rate Item
	local tbAward = {1 ,2, 3, 4}; -- Rate 4 con số
	for i = 1, 4 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
if (tbAward[nIndex]==1) then -- Xác xuất ra số 1 là 50/100 (50%)
me.AddExp(50000000); -- Nhận được 50tr EXP
Task:DelItem(me, tbItemId1, 1); -- Xóa 1 Item tbItemId1 được khai báo ở trên là 300 Bài Hát Thiếu Nhi
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> thuần phục <color=blue>Lam Kỳ Lân<color> nhận được <color=green>50tr EXP<color>!<color>");	
end
if (tbAward[nIndex]==2) then -- Xác xuất ra số 1 là 30/100 (30%)
me.AddExp(70000000); -- Nhận được 70tr EXP
Task:DelItem(me, tbItemId1, 1); -- Xóa 1 Item tbItemId1 được khai báo ở trên là 300 Bài Hát Thiếu Nhi
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> thuần phục <color=blue>Lam Kỳ Lân<color> nhận được <color=green>50tr EXP<color>!<color>");	
end
if (tbAward[nIndex]==3) then -- Xác xuất ra số 1 là 15/100 (15%)
me.AddExp(100000000); -- Nhận được 100tr EXP
Task:DelItem(me, tbItemId1, 1); -- Xóa 1 Item tbItemId1 được khai báo ở trên là 300 Bài Hát Thiếu Nhi
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> thuần phục <color=blue>Lam Kỳ Lân<color> nhận được <color=green>50tr EXP<color>!<color>");	
end
if (tbAward[nIndex]==4) then -- Xác xuất ra số 1 là 5/100 (5%)
me.AddExp(150000000); -- Nhận được 150tr EXP
Task:DelItem(me, tbItemId1, 1); -- Xóa 1 Item tbItemId1 được khai báo ở trên là 300 Bài Hát Thiếu Nhi
KDialog.MsgToGlobal("<color=yellow>Người chơi <color=green>["..me.szName.."]<color> thuần phục <color=blue>Lam Kỳ Lân<color> nhận được <color=green>50tr EXP<color>!<color>");	
end
-------
local pNpc = KNpc.GetById(nNpcId);
if (not pNpc) then
return;
end
pNpc.Delete();
return 0;
end