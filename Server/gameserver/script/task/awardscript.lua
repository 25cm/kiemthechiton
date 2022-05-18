
-- 每周前4次日常劇情副本，給玩家派發2w不綁定銀兩。在獎勵面板顯示，4次之後，獎勵面板顯示銀兩為0兩，並在任務結束時告知：本周已領取完4次不綁定銀兩。
-- "Task:Award_1(20000)"
function Task:Award_1(nMoney)
	local tbNow	= os.date("*t", GetTime());
	local nAwardTime = me.GetTask(2043, 100);
	
	if (nAwardTime >= 4) then
		me.Msg("Nhận 0 lượng bạc");
		return;
	end
	
	nAwardTime = nAwardTime + 1;
	
	me.SetTask(2043, 100, nAwardTime);
	
	me.Earn(nMoney, Player.emKEARN_TASK_ARMYCAMP);
	KStatLog.ModifyAdd("jxb", "[Đầu ra] Nhiệm vụ doanh trại", "Tổng", nMoney);
end

-- 每周前4次日常劇情副本，給玩家派發3點江湖威望。在獎勵面板顯示，4次之後，獎勵面板顯示江湖威望0點，並在任務結束時告知：本周已領取完4次江湖威望。
-- "Task:Award_2(3)"
function Task:Award_2(nWeiWang)
	local tbNow	= os.date("*t", GetTime());
	local nAwardTime = me.GetTask(2043, 101);
	
	if (nAwardTime >= 4) then
		me.Msg("Nhận 0 điểm uy danh");
		return;
	end
	
	nAwardTime = nAwardTime + 1;
	
	me.SetTask(2043, 101, nAwardTime);
	
	me.AddKinReputeEntry(nWeiWang);
	Dbg:WriteLogEx(Dbg.LOG_INFO, "Task", "Award_2", me.szName, string.format("Award WeiWang %d", nWeiWang));
end

-- 獎勵綁定魂石
function Task:Award_3(nCount)
	if (nCount <= 0) then
		return 0;
	end
	me.AddStackItem(18,1,205,1, {bForceBind = 1}, nCount);
	Dbg:WriteLogEx(Dbg.LOG_INFO, "Task", "Award_3", me.szName, string.format("Award hunshi %d", nCount));
end

function Task:WeekClearAwardTaskValue()
	me.SetTask(2043, 100, 0);
	me.SetTask(2043, 101, 0);
end


PlayerSchemeEvent:RegisterGlobalWeekEvent({Task.WeekClearAwardTaskValue, Task});
