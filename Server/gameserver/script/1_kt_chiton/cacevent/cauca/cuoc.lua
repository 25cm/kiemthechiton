local tbItem = Item:GetClass("thk_cuoc");
tbItem.tbItemInfo = {bForceBind=1,};
function tbItem:OnUse()
DoScript("\\script\\event\\cacevent\\cauca\\cuoc.lua");
local nMapId, nPosX, nPosY = me.GetWorldPos();
if ((nMapId == 1) and (nPosX == 1493) and (nPosY == 3146)) or ((nMapId == 1) and (nPosX == 1492) and (nPosY == 3151)) or ((nMapId == 1) and (nPosX == 1484) and (nPosY == 3148)) then
self:DaoMoiCau()
return
end
self:DiChuyenToiChoDaoMoi()
end
function tbItem:DiChuyenToiChoDaoMoi()
local szMsg = "<color=red>Chú Ý<color>: nơi này không có <color=green>Mồi Câu<color>\n"..
"<color=yellow>Sử dụng chức năng dưới đây để tới nơi một cách<color>\n"..
"<color=gold>Nhanh Chóng\n"..
"Chính Xác"
local tbOpt = {
{"Đến chỗ đào <color=gold>Mồi Câu<color> [Tọa Độ 1]", me.NewWorld, 1, 1493, 3146};
{"Đến chỗ đào <color=gold>Mồi Câu<color> [Tọa Độ 2]", me.NewWorld, 1, 1492, 3151};
{"Đến chỗ đào <color=gold>Mồi Câu<color> [Tọa Độ 3]", me.NewWorld, 1, 1484, 3148};
}; 
Dialog:Say(szMsg, tbOpt);
end
function tbItem:DaoMoiCau()
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
GeneralProcess:StartProcess("<pic=126>Đang Đào", 5* Env.GAME_FPS, {self.OnDialog4, self, it.dwId}, nil, tbEvent);
				 end
function tbItem:OnDialog4(nItemId)
local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0
	end
	if me.DelItem(pItem) == 1 then
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	-- random
	nRand = MathRandom(1, 10);
	-- fill 3 rate	
	local tbRate = {4,6};
	local tbAward = {1,2};

	 
			for i = 1, 2 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
	if (tbAward[nIndex]==1) then -- Cá Chép
	me.Msg("<color=yellow>Đào Thất Bại <color=black>|<color> Hãy Thử Lại<color>")
	end
	if (tbAward[nIndex]==2) then -- Cá Chép
	me.AddStackItem(18,1,2094,1,self.tbItemInfo,1)
	end
	end
	end
	