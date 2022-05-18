local tbRuouCaoLuong = Item:GetClass("ruoucaoluong")
function tbRuouCaoLuong:OnUse()
if me.CountFreeBagCell() < 10 then
		Dialog:Say("Phải Có 10 Ô Trống Trong Túi Hành Trang");
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
				 GeneralProcess:StartProcess("Đang uống rượu", 5 * Env.GAME_FPS, {self.OnDialog4, self}, nil, tbEvent);
	 };
	--Dialog:Say("",tbOpt);
end
function tbRuouCaoLuong:OnDialog4()
local tbItemId2	= {18,1,25244,1,0,0};
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	-- random
	nRand = MathRandom(1, 7000);
	-- fill 3 rate	
	local tbRate = {1000,1000,1000,1000,1000,1000,1000};
	local tbAward = 
{
[1] = {18,1,25239,1};
[2] = {18,1,25240,1};
[3] = {18,1,25241,1};
[4] = {18,1,25242,1};
[5] = {18,1,25194,1};
[6] = {18,1,375,1};
[7] = {18,1,216,3};

}
if me.CountFreeBagCell() < 10 then
		Dialog:Say("Phải Có 10 Ô Trống Trong Túi Hành Trang");
		return 0;
	end
			for i = 1, 7 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
	local pItem = me.AddItem(unpack(tbAward[nIndex]));
	pItem.Bind(1);
	me.Msg("Nhận được <color=cyan>"..pItem.szName.."<color>"); 
	Task:DelItem(me, tbItemId2, 1);
		end