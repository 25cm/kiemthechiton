
local tbItem = Item:GetClass("army_token")
tbItem.tbItemId = 
{
	[606] = 0,	--单次
	[607] = 1,	--无限军营令牌
	[195] = 1,	--无限传送符
	[235] = 1,
}
tbItem.tbTransMap = {
	{"Phục Ngưu Sơn Quân Doanh [Thanh Long]",556,1631,3142},
	{"Phục Ngưu Sơn Quân Doanh [Chu Tước]",558,1631,3142},
	{"Phục Ngưu Sơn Quân Doanh [Huyền Vũ]",559,1631,3142}
}
tbItem.nTime = 2;

function tbItem:OnUse()
	local szMsg = "Mời chọn Quân doanh bạn muốn đến";
	local tbOpt = {}
	for i, tbItem in ipairs(self.tbTransMap) do
		table.insert(tbOpt, {tbItem[1], self.OnTrans, self, it.dwId, i})
	end
	
	Lib:SmashTable(tbOpt);
	
	self.nOptionAutoTeamId = #tbOpt + 1;
	table.insert(tbOpt, { "Tự tổ đội", self.OnTrans, self, it.dwId, self.nOptionAutoTeamId });
	
	table.insert(tbOpt, {"Kết thúc đối thoại"});
	Dialog:Say(szMsg, tbOpt);
end

function tbItem:OnTrans(nItemId, nTransId)
	local pPlayer = me;
	if nTransId == self.nOptionAutoTeamId then
		pPlayer.CallClientScript({ "AutoTeam:OpenUi" });
		return;
	end
	
	if pPlayer.nLevel < 60 then
		pPlayer.Msg("Người chơi <cấp 60 không được vào Quân doanh");
		return;
	end
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
		self:TransSure(nItemId, nTransId, pPlayer.nId);
		return 0;
	end

	GeneralProcess:StartProcess("Đang chuyển đến Quân doanh...", self.nTime * Env.GAME_FPS, {self.TransSure, self, nItemId, nTransId, pPlayer.nId}, nil, tbEvent);	-- 在战斗状态下需要nTime秒的延时
end

function tbItem:TransSure(nItemId, nTransId, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	local pItem = KItem.GetObjById(nItemId);
	if not pItem or not pPlayer then
		return 0;
	end
	if self.tbItemId[pItem.nParticular] ~= 1 then
		local nCount = pItem.nCount;
		if nCount <= 1 then
			if (pPlayer.DelItem(pItem, Player.emKLOSEITEM_USE) ~= 1) then
				pPlayer.Msg("Xóa Chiêu Thư Tống Kim thất bại!");
				return 0;
			end
		else
			pItem.SetCount(nCount - 1, Item.emITEM_DATARECORD_REMOVE);
			pItem.Sync();
		end
	end
	pPlayer.NewWorld(self.tbTransMap[nTransId][2], self.tbTransMap[nTransId][3], self.tbTransMap[nTransId][4]);
end
