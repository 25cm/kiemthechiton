local tbCayToXanhTot = Npc:GetClass("caytoxanhtot");
function tbCayToXanhTot:OnDialog()
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
GeneralProcess:StartProcess("Đang châm lửa", 0.5 * Env.GAME_FPS, {self.ThuThap111, self, me.nId, him.dwId}, nil, tbEvent);
	 };
	 end
	 
function tbCayToXanhTot:ThuThap111(nPlayerId, nNpcId)
local tbItemInfo = {bForceBind = 1};
local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
local tbItemId1 = {18,1,3039,1,0,0}; -- Thư chúc phúc
local nCount1 = me.GetItemCountInBags(18,1,3039,1);
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
	nRand = MathRandom(1, 2756);
	-- fill 3 rate	
	local tbRate = {800,500,500,800,10,80,15,10,10,1,10,10,10};
	local tbAward = {1,2,3,4,5,6,7,8,9,10,11,12,13}
	 
			for i = 1, 13 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
	if nCount1 < 1 then
Dialog:Say("<color=yellow>Không có pháo hoa<color>")
	return 0;
		else

	--if nIndex == 0 then
	--Task:DelItem(me, tbItemId1, 1);
		--me.Msg("Xin lỗi bạn quá đen <pic=0>.");
		--return 0;
	--end;
		if (tbAward[nIndex]==1) then
	Task:DelItem(me, tbItemId1, 1);
	me.CastSkill(307, 1, -1, me.GetNpc().nIndex);
me.AddStackItem(18,1,1334,10,tbItemInfo,5);

	end
	----------------------------------
	if (tbAward[nIndex]==2) then
	Task:DelItem(me, tbItemId1, 1);
	me.CastSkill(307, 1, -1, me.GetNpc().nIndex);
	me.AddStackItem(18,1,1333,10,tbItemInfo,2);	

	end	
----------------------------------------------
			if (tbAward[nIndex]==3) then
				Task:DelItem(me, tbItemId1, 1);
				me.CastSkill(1564, 1, -1, me.GetNpc().nIndex);
me.AddStackItem(18,1,3019,1,tbItemInfo,3);

	end
	------------------------------------
				if (tbAward[nIndex]==4) then
	Task:DelItem(me, tbItemId1, 1);
	me.CastSkill(1565, 1, -1, me.GetNpc().nIndex);
me.AddStackItem(18,1,3046,1,tbItemInfo,3);

	end
	-------------------------------------
				if (tbAward[nIndex]==5) then
					Task:DelItem(me, tbItemId1, 1);
					me.CastSkill(391, 1, -1, me.GetNpc().nIndex);
					--me.CallClientScript({"UiManager:OpenWindow", "UI_WEDDING", 1});
	me.AddItem(18,1,1331,3).Bind(1);

	KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..me.szName.."<color> đốt pháo hoa nhận được <color=red>Tinh Thạch Đoạn Hải<color> và nhiều phần thưởng bất ngờ");
	KDialog.MsgToGlobal("<color=green>"..me.szName.."<color> đốt pháo hoa nhận được <color=yellow>Tinh Thạch Đoạn Hải<color> và nhiều phần thưởng bất ngờ");
	end
	--------------------------------------------
				if (tbAward[nIndex]==6) then
					Task:DelItem(me, tbItemId1, 1);
					me.CastSkill(391, 1, -1, me.GetNpc().nIndex);
					--me.CallClientScript({"UiManager:OpenWindow", "UI_WEDDING", 1});
me.AddItem(18,1,1194,1);

			KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..me.szName.."<color> đốt pháo hoa nhận được <color=red>Kim Nguyên Bảo (Tiểu)<color> thật may mắn");
	end
	----------------------------------------
				if (tbAward[nIndex]==7) then
	Task:DelItem(me, tbItemId1, 1);
	me.CastSkill(1562, 1, -1, me.GetNpc().nIndex);
	--me.CallClientScript({"UiManager:OpenWindow", "UI_WEDDING", 1});
me.AddStackItem(18,1,377,1,tbItemInfo,1);

      KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..me.szName.."<color> đốt pháo hoa nhận được <color=red>Tần Lăng - Hòa Thị Bích<color> và nhiều phần thưởng bất ngờ");
	  KDialog.MsgToGlobal("Người chơi <color=green>"..me.szName.."<color> đốt pháo hoa nhận được <color=yellow>Tần Lăng - Hòa Thị Bích<color> và nhiều phần thưởng bất ngờ");
	end
	----------------------------------------------
					if (tbAward[nIndex]==8) then
	Task:DelItem(me, tbItemId1, 1);
	me.CastSkill(1562, 1, -1, me.GetNpc().nIndex);
	--me.CallClientScript({"UiManager:OpenWindow", "UI_WEDDING", 1});
me.AddItem(18,1,186,1);

			KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..me.szName.."<color> đốt pháo hoa nhận được <color=red>[Bản Đồ] Thiên Quỳnh Cung<color> thật may mắn !");	
	end
	----------------------------------------
					if (tbAward[nIndex]==9) then
	Task:DelItem(me, tbItemId1, 1);
	me.CastSkill(1563, 1, -1, me.GetNpc().nIndex);
	--me.CallClientScript({"UiManager:OpenWindow", "UI_WEDDING", 1});
me.AddItem(18,1,245,1);

			KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..me.szName.."<color> đốt pháo hoa nhận được <color=red>[Bản Đồ] Vạn Hoa Cốc<color> thật may mắn !");	
	end
	------------------------------------------
					if (tbAward[nIndex]==10) then
	Task:DelItem(me, tbItemId1, 1);
	me.CastSkill(1563, 1, -1, me.GetNpc().nIndex);
	--me.CallClientScript({"UiManager:OpenWindow", "UI_WEDDING", 1});
me.AddItem(18,1,1331,4);

			KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..me.szName.."<color> đốt pháo hoa nhận được <color=red>Tinh Thạch Thánh Hỏa<color> thật may mắn !");
	KDialog.MsgToGlobal("Người chơi <color=green>"..me.szName.."<color> đốt pháo hoa nhận được <color=yellow>Tinh Thạch Thánh Hỏa<color> thật may mắn !");
	end
						if (tbAward[nIndex]==11) then
	Task:DelItem(me, tbItemId1, 1);
	me.CastSkill(1563, 1, -1, me.GetNpc().nIndex);
	--me.CallClientScript({"UiManager:OpenWindow", "UI_WEDDING", 1});
me.AddItem(18,1,2000,1);

			KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..me.szName.."<color> đốt pháo hoa nhận được <color=red>[Bản Đồ] Bách Niên Thiên Lao<color> thật may mắn !");
	end
						if (tbAward[nIndex]==12) then
	Task:DelItem(me, tbItemId1, 1);
	me.CastSkill(1563, 1, -1, me.GetNpc().nIndex);
	--me.CallClientScript({"UiManager:OpenWindow", "UI_WEDDING", 1});
me.AddItem(18,1,2001,1);

			KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..me.szName.."<color> đốt pháo hoa nhận được <color=red>[Bản Đồ] Đào Chu Công Mộ Chủng<color> thật may mắn !");
	end
						if (tbAward[nIndex]==13) then
	Task:DelItem(me, tbItemId1, 1);
	me.CastSkill(1563, 1, -1, me.GetNpc().nIndex);
	--me.CallClientScript({"UiManager:OpenWindow", "UI_WEDDING", 1});
me.AddItem(18,1,2002,1);

			KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..me.szName.."<color> đốt pháo hoa nhận được <color=red>[Bản Đồ] Đại Mạc Cổ Thành<color> thật may mắn !");	
	end
	end
	

	return 0;
		end;