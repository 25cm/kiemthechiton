local tbtreoquatet123 = Npc:GetClass("treoquatet123");
function tbtreoquatet123:OnDialog()
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
GeneralProcess:StartProcess("Treo hộp quà", 0.5 * Env.GAME_FPS, {self.ThuThap111, self, me.nId, him.dwId}, nil, tbEvent);
	 };
	 end
	 
function tbtreoquatet123:ThuThap111(nPlayerId, nNpcId)
local tbItemInfo = {bForceBind = 1};
local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
local tbItemId1 = {18,1,3039,3,0,0}; -- Thư chúc phúc
local nCount1 = me.GetItemCountInBags(18,1,3039,3);
	if (not pPlayer) then
		return;
	end	
	local pNpc = KNpc.GetById(nNpcId);
	if (not pNpc) then
		return;
	end
	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	-- random
	nRand = MathRandom(1, 17783);
	-- fill 3 rate	
	local tbRate = {3000,1000,2000,2000,2000,3000,3000,1000,500,200,30,50,3};
	local tbAward = {1,2,3,4,5,6,7,8,9,10,11,12,13}
	 
			for i = 1, 13 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
	if nCount1 < 1 then
Dialog:Say("<color=yellow>Không có Hộp Quà Tết<color>")
	return 0;
		else


	if (tbAward[nIndex]==1) then
	Task:DelItem(me, tbItemId1, 1);
me.AddStackItem(18,1,553,1,tbItemInfo,15);

	end
----------------------------------------------
	if (tbAward[nIndex]==2) then
	Task:DelItem(me, tbItemId1, 1);
me.AddStackItem(18,1,553,1,tbItemInfo,30);

	end
	------------------------------------
	if (tbAward[nIndex]==3) then
	Task:DelItem(me, tbItemId1, 1);
me.AddStackItem(18,1,263,1,tbItemInfo,2);

	end
	---------------------------
	if (tbAward[nIndex]==4) then
	Task:DelItem(me, tbItemId1, 1);
me.AddStackItem(18,1,215,1,tbItemInfo,2);

	end
	-------------------------
	if (tbAward[nIndex]==5) then
	Task:DelItem(me, tbItemId1, 1);
me.AddStackItem(18,1,366,1,tbItemInfo,2);

	end
	-------------------------------
	
	if (tbAward[nIndex]==6) then
	Task:DelItem(me, tbItemId1, 1);
me.AddStackItem(18,1,1333,10,tbItemInfo,2);

	end
	---------------------------------------
	if (tbAward[nIndex]==7) then
	Task:DelItem(me, tbItemId1, 1);
me.AddStackItem(18,1,1334,10,tbItemInfo,5);

	end
	-------------------------------------
	if (tbAward[nIndex]==8) then
	Task:DelItem(me, tbItemId1, 1);
me.AddStackItem(18,1,3046,1,tbItemInfo,2);

	end
	-------------------------------------
	if (tbAward[nIndex]==9) then
	Task:DelItem(me, tbItemId1, 1);
me.AddStackItem(18,1,3046,1,tbItemInfo,4);

	end
	--------------------------------------
	if (tbAward[nIndex]==10) then
	Task:DelItem(me, tbItemId1, 1);
me.AddStackItem(18,1,3046,1,tbItemInfo,6);

	end

		-----------------------------------------
		if (tbAward[nIndex]==11) then
	Task:DelItem(me, tbItemId1, 1);
me.AddStackItem(18,1,553,1,tbItemInfo,200);

	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..me.szName.."<color> trang trí Cây Thông Noel nhận được <color=red>200 Tiền Du Long<color> và nhiều phần thưởng bất ngờ");
	  KDialog.MsgToGlobal("Người chơi <color=green>"..me.szName.."<color> trang trí Cây Thông Noel nhận được <color=yellow>200 Tiền Du Long<color> và nhiều phần thưởng bất ngờ");
	end
		----------------------------------------
	if (tbAward[nIndex]==12) then
	Task:DelItem(me, tbItemId1, 1);
me.AddStackItem(18,1,377,1,tbItemInfo,1);

      KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..me.szName.."<color> trang trí Cây Thông Noel nhận được <color=red>1 Tần Lăng - Hòa Thị Bích<color> và nhiều phần thưởng bất ngờ");
	  KDialog.MsgToGlobal("Người chơi <color=green>"..me.szName.."<color> trang trí Cây Thông Noel nhận được <color=yellow>1 Tần Lăng - Hòa Thị Bích<color> và nhiều phần thưởng bất ngờ");
	end
	------------------------------------------
	if (tbAward[nIndex]==13) then
	Task:DelItem(me, tbItemId1, 1);
me.AddItem(18,1,1331,4);

			KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..me.szName.."<color> trang trí Cây Thông Noel nhận được <color=red>Tinh Thạch Thánh Hỏa<color> thật may mắn !");
	KDialog.MsgToGlobal("Người chơi <color=green>"..me.szName.."<color> trang trí Cây Thông Noel nhận được <color=yellow>Tinh Thạch Thánh Hỏa<color> thật may mắn !");
	end
	end
	

	return 0;
		end;