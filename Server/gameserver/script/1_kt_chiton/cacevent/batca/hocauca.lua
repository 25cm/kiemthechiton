local tbHoCauCa = Npc:GetClass("sltk_hoca");
function tbHoCauCa:OnDialog()
if me.CountFreeBagCell() < 5 then
		Dialog:Say("Phải Có 5 Ô Trống Trong Túi Hành Trang");
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
				 GeneralProcess:StartProcess("Đang Vớt Cá", 5 * Env.GAME_FPS, {self.OnDialog4, self}, nil, tbEvent);
	 };
end
function tbHoCauCa:OnDialog4()
local tbItemInfo = {bForceBind = 1};
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	-- random
	nRand = MathRandom(1, 100);
	-- fill 3 rate	
	local tbRate = {5,5,5,25,60};
	local tbAward = {1,2,3,4,5}
	 
			for i = 1, 5 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
	if (tbAward[nIndex]==1) then
	me.AddStackItem(18,1,20311,1,tbItemInfo,1);
	Dialog:SendBlackBoardMsg(me, string.format("<pic=125>Vớt được <color=red>1 Cá Chép Đỏ<color>!"));
me.Msg("Vớt được <color=yellow>1 Cá Chép Đỏ<color>")
	end
	if (tbAward[nIndex]==2) then
		me.AddStackItem(18,1,20312,1,tbItemInfo,1);
		Dialog:SendBlackBoardMsg(me, string.format("<pic=125>Vớt được <color=yellow>1 Cá Chép Vàng<color>!"));
me.Msg("Vớt được <color=yellow>1 Cá Chép Vàng<color>")
	end	
	if (tbAward[nIndex]==3) then
		me.AddStackItem(18,1,2097,1,tbItemInfo,1);
		Dialog:SendBlackBoardMsg(me, string.format("<pic=125>Vớt được <color=gold>1 Cá Ba Đuôi<color>!"));	
me.Msg("Vớt được <color=yellow>1 Cá Ba Đuôi<color>")
	end
	if (tbAward[nIndex]==4) then
	me.AddBindCoin(1000);
		Dialog:SendBlackBoardMsg(me, string.format("<pic=125>Mạnh tay quá <color=gold>Cá nhảy ra ngoài rồi !<color>!"));	
me.Msg("Vớt được <color=yellow>1000 Đồng Khóa<color>")
	end
	if (tbAward[nIndex]==5) then
	me.AddExp(50000);
			Dialog:SendBlackBoardMsg(me, string.format("<pic=125>Vợt bị thủng <color=red>Không vớt được Cá !<color>!"));
me.Msg("Vớt được <color=yellow>50.000 Kinh Nghiệm<color>")
	end		
	end