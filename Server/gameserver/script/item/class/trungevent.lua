
local tbItem = Item:GetClass("trungevent")
function tbItem:OnUse()
local tbItemId2	= {18,1,1336,2,0,0};
	local nCount2 = me.GetItemCountInBags(18,1,1336,2); -- Búa
	if nCount2 < 1 then
	Dialog:Say("<color=yellow>Trong hành trang của bạn không có <color=cyan>Búa<color> . Không thể đập trứng<color>");
		return 0;
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
				 GeneralProcess:StartProcess("<color=pink>Đang Đập Trứng<color>", 5 * Env.GAME_FPS, {self.OnDialog4, self}, nil, tbEvent);
	 };
	--Dialog:Say("",tbOpt);
end
function tbItem:OnDialog4()
local tbItemId2	= {18,1,1336,2,0,0};
local item02= {18,1,1336,1,0,0};
	local nCount2 = me.GetItemCountInBags(18,1,1336,2); -- Búa
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	-- random
	nRand = MathRandom(1, 10000);
	-- fill 3 rate	
	local tbRate = {1000,2000,2000,2000,1500,1500};
	local tbAward = 
{
	[1] = {18,1,1337,9};
	[2] = {18,1,543,1};
	[3] = {18,1,543,1};
	[4] = {18,1,118,2};
	[5] = {18,1,1333,1};
	[6] = {18,1,1334,1};
}
if me.CountFreeBagCell() < 10 then
		Dialog:Say("Phải Có 10 Ô Trống Trong Túi Hành Trang Mới Đập Trứng Được !");
		return 0;
	end
	if nCount2 < 1 then
	Dialog:Say("<color=yellow>Trong hành trang của bạn không có <color=cyan>Búa<color> . Không thể đập trứng<color>");
		return 0;
		end
		me.AddBindMoney(500000);
		Task:DelItem(me, item02, 1);
		end