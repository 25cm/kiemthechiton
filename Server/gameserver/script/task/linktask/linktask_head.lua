
-- ====================== 文件信息 ======================

-- 劍俠世界任務鏈頭文件（第二版）
-- Edited by peres
-- 2007/12/25 PM 00:00 聖誕節前夜

-- 很多事情不需要預測
-- 預測會帶來猶豫
-- 因為心裡會有恐懼

-- ======================================================

Require("\\script\\task\\linktask\\linktask_file.lua");
Require("\\script\\task\\linktask\\linktask_award.lua");
Require("\\script\\lib\\gift.lua");

-- 任務ID
LinkTask.TSKG_LINKTASK		= 6;  -- 整個任務鏈的任務組 ID

LinkTask.TSK_TASKNUM		= 1;  -- 任務進行次數
LinkTask.TSK_TASKOPEN		= 2;  -- 是否接受正式開始任務
LinkTask.TSK_CANCELNUM		= 3;  -- 取消任務的次數
LinkTask.TSK_CANCELTIME		= 4;  -- 取消任務的時間記錄
LinkTask.TSK_CONTAIN		= 5;  -- 取消任務的容忍次數

LinkTask.TSK_TASKID			= 6;  -- 記錄當前接任務的ID，表格內指定
LinkTask.TSK_TASKTYPE		= 7;  -- 記錄當前接任務的類型

LinkTask.TSK_TASKTEXT		= 8;  -- 記錄任務的文字索引號

LinkTask.TSK_DATE			= 9;  -- 記錄完成任務的日期
LinkTask.TSK_NUM_PERDAY		= 10; -- 記錄每日完成任務的數量

LinkTask.TSK_AWARDSAVE		= 11;  -- 記錄領獎中斷狀態
LinkTask.TSK_RANDOMSEED		= 12; -- 記錄獎勵時的隨機種子

LinkTask.TSK_LINKAWARDDATE	= 13; -- 記錄領取鏈獎勵的日期，即使取消了任務也不能重復領
LinkTask.TSK_TOTALNUM_PERDAY= 14; -- 記錄每天完成任務的總量
LinkTask.TSK_TOTAL_10_TIMTES	= 15; -- 記錄一天共有個連續10次

LinkTask.TSK_EX_MONEY_20		= 20;
LinkTask.TSK_EX_MONEY_30		= 21;
LinkTask.TSK_EX_MONEY_40		= 22;
LinkTask.TSK_EX_MONEY_50		= 23;

-- 額外金錢記錄的變量組
LinkTask.tbExMoneyAward			= {
		[20] = LinkTask.TSK_EX_MONEY_20,
		[30] = LinkTask.TSK_EX_MONEY_30,
		[40] = LinkTask.TSK_EX_MONEY_40,
		[50] = LinkTask.TSK_EX_MONEY_50,
	}

-- 常量
LinkTask.CONTAIN_LIMIT   = 3;    -- 最大容忍次數
LinkTask.PAUSE_TIME      = 300;  -- 任務暫停不能接的時間（秒）

LinkTask.PERDAY_NUM_MAX	= 50;	-- 每天最多可以做 50 次，包括取消

-- 給予界面實例
LinkTask.tbGiftDialog = Gift:New();
LinkTask.tbGiftDialog._szTitle = "Cho vật phẩm";

LinkTask.tbBillDialog	= Gift:New();
LinkTask.tbBillDialog.szTitle = "Đổi ngân phiếu";

LinkTask.TSKGID				= 2015;
LinkTask.TSK_LIMITWEIWANG	= 1;
LinkTask.LIMITWEIWANG		= 30;
LinkTask.JINGLI				= 250;
LinkTask.HUOLI				= 250;

LinkTask.TSK_RANDOMNUMBER	= {1001,1002,1003,1004,1005,1006,1007,1008,1009}; -- 記錄獎勵時的隨機數3個

-- 初始化表格文件以及任務數據
function LinkTask:OnInit()
--	self:InitFile();
end;

LinkTask:OnInit();
LinkTask:InitAward();

-- 確定玩家屬於哪個任務等級段
function LinkTask:SelectLevelGroup()
	local nLevel = me.nLevel; --GetLevel();
	local nTabLevel = 0;
	local nGroup = 0;
	
	local nRow = self.tbfile_TaskLevelGroup:GetRow();
	local i=0;
	
	self:_Debug("Get the level group file row: "..nRow);
	
	for i=1, nRow do
		nTabLevel = self.tbfile_TaskLevelGroup:GetCellInt("Level", i);
		nGroup    = self.tbfile_TaskLevelGroup:GetCellInt("LevelGroup", i);
		if nLevel<=nTabLevel then
			return nGroup;
		end;
	end;
end;

-- 隨機選擇一個任務，返回這個任務的編號
function LinkTask:SelectTask()
	local nLevelGroup = self:SelectLevelGroup();
	local nTypeRow = self.tbfile_TaskType:CountRate("Level"..nLevelGroup);
	
	if nTypeRow<1 then
		self:_Debug("Select task type error!");
		return
	end;
	
	local nType = self.tbfile_TaskType:GetCellInt("TypeId", nTypeRow);
	
	self:_Debug("Task level group: "..nLevelGroup);
	self:_Debug("Select task type: "..nType);
	
	-- 各個相對應的任務表
	local tbTask = {};
	
	tbTask = self.tbfile_SubTask[nType];
	
	local nTaskRow = tbTask:CountRate("Level"..nLevelGroup);
	
	if nTaskRow<1 then
		self:_Debug("Select task row error!");
		return
	end;
	
	local nTaskId  = tbTask:GetCellInt("TaskId", nTaskRow);
		
		self:_Debug("Select a task Id: "..nTaskId);
	
	-- 儲存任務類型和行數在玩家變量裡
	self:SetTask(self.TSK_TASKID, nTaskId);
	self:SetTask(self.TSK_TASKTYPE, nType);
	
	-- 選擇一個任務文字描述
	self:SetTaskText(me, nType);
	
	self:_Debug("Select task return ", nType, nTaskId);
	return nType, nTaskId;
end;

-- 給玩家開始一個任務
function LinkTask:StartTask()
	
	-- 每天固定次數的限制
	local nTotalNum	= self:GetTaskTotalNum_PerDay();
	
	if nTotalNum >= self.PERDAY_NUM_MAX then
		return 0, 0;
	end;
	
	local nTaskType, nSubTaskId = self:SelectTask();
	local tbTask 	= Task:GetPlayerTask(me).tbTasks[nTaskType];
	
	-- 如果當前玩家已經有了這個主任務，則應該關掉，避免加不上任務的情況
	Task:CloseTask(nTaskType, "linktask_finish");

	self:_Debug("Start Task: "..nTaskType..", "..nSubTaskId);
	
	local tbTask = Task:DoAccept(nTaskType, nSubTaskId);
	if (not tbTask) then
		return;
	end
	
	return nTaskType, nSubTaskId;
end;


-- 正式開始任務鏈，不可逆
function LinkTask:Open()
	
	self:SetTask(self.TSK_TASKOPEN, 1);
	
	-- 清空所有的任務數據
	self:SetTask(self.TSK_TASKNUM, 0);
	self:SetTask(self.TSK_CANCELNUM, 0);
	self:SetTask(self.TSK_CANCELTIME, 0);
	self:SetTask(self.TSK_CONTAIN, 0);
	self:SetTask(self.TSK_TASKID, 0);
	self:SetTask(self.TSK_TASKTYPE, 0);
	self:SetTask(self.TSK_TASKTEXT, 0);
	self:SetTask(self.TSK_DATE, 0);
	self:SetTask(self.TSK_NUM_PERDAY, 0);
	self:SetTask(self.TSK_AWARDSAVE, 0);
	self:SetTask(self.TSK_RANDOMSEED, 0);
	self:SetTask(self.TSK_TOTALNUM_PERDAY, 0);
	self:SetTask(self.TSK_TOTAL_10_TIMTES, 0);

end;


-- 把任務總數和每天完成的任務次數 +1
function LinkTask:AddTaskNum()
	local nTaskNum = self:GetTask(self.TSK_TASKNUM);
	
	nTaskNum = nTaskNum + 1;

	self:SetTask(self.TSK_TASKNUM, nTaskNum);
	
	-- 給每天完成的次數 + 1;
	self:AddTaskNum_PerDay();	
end;


-- 給每天完成的任務次數 +1
function LinkTask:AddTaskNum_PerDay()
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));  -- 獲取日期：XXXX/XX/XX 格式
	local nOldDate = self:GetTask(self.TSK_DATE);
	local nNum = self:GetTaskNum_PerDay();
	local nTotalNum = self:GetTaskTotalNum_PerDay();
	-- 計算一天內連續10次任務的個數
	local n10TimesNum = self:GetTask(self.TSK_TOTAL_10_TIMTES);
	
	if nNowDate~=nOldDate then
		nNum 	= 0;
		nTotalNum = 0;
		n10TimesNum = 0;
		
		-- 清空階段性金錢獎勵
		self:SetTask(self.TSK_LINKAWARDDATE, 0);
		
		for i, j in pairs(self.tbExMoneyAward) do
			self:SetTask(self.tbExMoneyAward[i], 0);
		end;
				
	end;
	
	nNum = nNum + 1;
	nTotalNum = nTotalNum + 1;

	self:SetTask(self.TSK_DATE, nNowDate);	
	self:SetTaskNum_PerDay(nNum);
	-- 記錄當天完成任務的總數
	self:SetTaskTotalNum_PerDay(nTotalNum);

	local n10Flag = math.fmod(nNum, 10);
	if (0 == n10Flag) then
		n10TimesNum = n10TimesNum + 1;
		self:SetTask(self.TSK_TOTAL_10_TIMTES, n10TimesNum);
	end
	
	-- 記錄玩家完成義軍任務的次數
	Stats.Activity:AddCount(me, Stats.TASK_COUNT_YIJUN, 1);

	-- 記錄每天完成的最大次數
	--KStatLog.ModifyMax("LinkTask", me.szName, "當天連續完成任務鏈最大次數", nNum);
end;


-- 檢查每天的任務是否過期，清除任務數量
function LinkTask:CheckPerDayTask()
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));  -- 獲取日期：XXXX/XX/XX 格式
	local nOldDate = self:GetTask(self.TSK_DATE);
	local nNum = self:GetTaskNum_PerDay();
	local nTotalNum = self:GetTaskTotalNum_PerDay();
	local n10TimesNum = self:GetTask10TimesNum_PerDay();
	
	if nNowDate~=nOldDate then
		nNum = 0;
		nTotalNum = 0;
		n10TimesNum = 0;

		-- 清空階段性金錢獎勵
		self:SetTask(self.TSK_LINKAWARDDATE, 0);
		
		-- 清空階段性金錢獎勵
		for i, j in pairs(self.tbExMoneyAward) do
			self:SetTask(self.tbExMoneyAward[i], 0);
		end;
	end;
	
	self:SetTask(self.TSK_DATE, nNowDate);	
	self:SetTaskNum_PerDay(nNum);
	-- 記錄當天完成任務的總數
	self:SetTaskTotalNum_PerDay(nTotalNum);
	self:SetTask10TimesNum_PerDay(n10TimesNum);
end;


-- 獲取當前已經做了多少次任務
function LinkTask:GetTaskNum()
	return self:GetTask(self.TSK_TASKNUM);
end;

-- 獲取每天完成的連續10次任務的數量
function LinkTask:GetTask10TimesNum_PerDay()
	return self:GetTask(self.TSK_TOTAL_10_TIMTES);
end

-- 獲取每天完成任務的總數量
function LinkTask:GetTaskTotalNum_PerDay()
	return self:GetTask(self.TSK_TOTALNUM_PERDAY);
end;

-- 設置做了多少次任務
function LinkTask:SetTaskNum(nNum)
	self:SetTask(self.TSK_TASKNUM, nNum);
end;

-- 獲取每天完成的任務數量
function LinkTask:GetTaskNum_PerDay()
	return self:GetTask(self.TSK_NUM_PERDAY);
end;

-- 設置每天完成任務的數量
function LinkTask:SetTaskNum_PerDay(nNum)
	self:SetTask(self.TSK_NUM_PERDAY, nNum);
end;

-- 設置每天完成任務的總數量
function LinkTask:SetTaskTotalNum_PerDay(nNum)
	self:SetTask(self.TSK_TOTALNUM_PERDAY, nNum);
end;

-- 記錄一天中連續10次的個數
function LinkTask:SetTask10TimesNum_PerDay(num)
	self:SetTask(self.TSK_TOTAL_10_TIMTES, num);
end 

function LinkTask:SetTask(nTaskId, nValue)
	me.SetTask(self.TSKG_LINKTASK, nTaskId, nValue);
end;

function LinkTask:GetTask(nTaskId)
	return me.GetTask(self.TSKG_LINKTASK, nTaskId);
end;


-- 檢測任務除了交物品任務之外還有沒有未完成的目標
function LinkTask:CheckTaskFinish()
	local nTaskType		= LinkTask:GetTask(LinkTask.TSK_TASKTYPE);
	local tbTask	 	= Task:GetPlayerTask(me).tbTasks[nTaskType];
	
	-- 還有未完成的目標
	for _, tbCurTag in pairs(tbTask.tbCurTags) do
		if (not tbCurTag:IsDone()) then
			self:_Debug("Check task state: underway  Tags Name: "..tbCurTag.szTargetName);
			return 0;
		end;
	end;
	
	-- 全部目標完成
	return 1;
end;

-- 檢測任務裡是否有收集物品任務
function LinkTask:CheckHaveItemTarget()
	local nSubTaskId	= self:GetTask(self.TSK_TASKID);
	local tbTaget		= Task.tbSubDatas[nSubTaskId].tbSteps[1].tbTargets[1];
	local szTargetName	= tbTaget.szTargetName; -- 得到這個目標的名字
	
	if szTargetName == "SearchItemWithDesc" or szTargetName == "SearchItemBySuffix" then
		return 1;
	else
		return 0;
	end;
end;

-- 給與界面的處理
function LinkTask:ShowGiftDialog()
	-- 在這裡獲取任務所需的物品	
	Dialog:Gift("LinkTask.tbGiftDialog");
end;


function LinkTask.tbGiftDialog:OnUpdate()
--	local nSubTaskId	= me.GetTask(1,6);
--	local tbSubDatas	= Task.tbSubDatas[nSubTaskId];
--		if not tbSubDatas then
--			LinkTask.tbGiftDialog._szContent = "<color=red>客戶端錯誤，無任務數據，請升級客戶端！<color>";
--			return;
--		end;
--	local tbTaget		= tbSubDatas.tbSteps[1].tbTargets[1];
--		if not tbTargets then
--			LinkTask.tbGiftDialog._szContent = "<color=red>客戶端錯誤，無任務目標數據，請升級客戶端！<color>";
--			return;
--		end;
--	local szNeed		= "<color=yellow>"..tbTaget.nNeedCount.."個"..tbTaget.szItemName.."<color>";
--	local szMain		= "請把我需要的"..szNeed.."放到這裡來吧！";
	
	LinkTask.tbGiftDialog._szContent	= "Vui lòng bỏ vật phẩm ta cần vào đây!";

end;


function LinkTask.tbGiftDialog:OnOK()
	local nSubTaskId	= LinkTask:GetTask(LinkTask.TSK_TASKID);
	local tbTaget		= Task.tbSubDatas[nSubTaskId].tbSteps[1].tbTargets[1];
	local szTargetName	= tbTaget.szTargetName;
	
	local pFind = LinkTask.tbGiftDialog:First();
	local tbNeed, tbNow, tbDelItem	= {}, {}, {};
	local nAccordNum	= 0;
	
	if szTargetName == "SearchItemWithDesc" then
		tbNeed.nGenre		= tbTaget.nGenre;
		tbNeed.nDetail		= tbTaget.nDetail;
		tbNeed.nParticular	= tbTaget.nParticular;
		tbNeed.nLevel		= tbTaget.nLevel;
		tbNeed.nSeries		= tbTaget.nFive;
		tbNeed.nNeedCount	= tbTaget.nNeedCount;
	elseif szTargetName == "SearchItemBySuffix" then
		tbNeed.szItemName	= tbTaget.szItemName;
		tbNeed.szSuffix		= tbTaget.szSuffix;
		tbNeed.nNeedCount	= tbTaget.nNeedCount;
	end;
	
	LinkTask:_Debug("Target need count: ", tbNeed.nNeedCount);
	
	if pFind==nil then
		Dialog:Say("Bạn chưa để vật phẩm vào!");
		tbDelItem = {};
		return;
	end;
	
	while pFind do
		
		if szTargetName == "SearchItemWithDesc" then
			tbNow.nGenre      = pFind.nGenre;
			tbNow.nDetail     = pFind.nDetail;
			tbNow.nParticular = pFind.nParticular;
			tbNow.nLevel      = pFind.nLevel;
			tbNow.nSeries     = pFind.nSeries;
			
			if (tbNow.nGenre == tbNeed.nGenre) and (tbNow.nDetail == tbNeed.nDetail) and (tbNow.nParticular == tbNeed.nParticular) and (tbNow.nLevel == tbNeed.nLevel) and (tbNow.nSeries == tbNeed.nSeries) then
				nAccordNum = nAccordNum + pFind.nCount;
				table.insert(tbDelItem, pFind);
			end;
			
		elseif szTargetName == "SearchItemBySuffix" then
			tbNow.szItemName	= pFind.szOrgName;
			tbNow.szSuffix		= pFind.szSuffix;
			
			LinkTask:_Debug("Get Name & Need Name: ", tbNow.szItemName, tbNow.szSuffix, " / ", tbNeed.szItemName, tbNeed.szSuffix);
			
			if (tbNow.szItemName == tbNeed.szItemName) and (tbNow.szSuffix == tbNeed.szSuffix) then
				nAccordNum = nAccordNum + pFind.nCount;
				table.insert(tbDelItem, pFind);
			end;
		end;
			
		pFind = LinkTask.tbGiftDialog:Next();
	end;
	
	if nAccordNum == tbNeed.nNeedCount then
		for i=1, #tbDelItem do
			if tbDelItem[i].Delete(me) ~= 1 then
				return ;
			end
		end;
		
		LinkTask:OnAward();
		
		return;
	else
		LinkTask:_Debug("Check item faile, get right count: "..nAccordNum.." , need: "..tbNeed.nNeedCount);
		
		Dialog:Say("Số lượng vật phẩm không phù hợp, hãy kiểm tra lại!");
		tbDelItem = {};
		return;
	end;
end;


-- 任務引擎直接調用的獎勵函數
function LinkTask:OnAward()
	
	-- 將狀態設置為開始發獎狀態
	self:SetAwardState(1);
	
	local nFreeCell = me.CountFreeBagCell();
	local nTaskNum	= self:GetTaskNum_PerDay();
	local nFreeCount, tbExecute = SpecialEvent.ExtendAward:DoCheck("LinkTask", me, nTaskNum + 1);
	if nFreeCell < 6 + nFreeCount then
		Dialog:Say(string.format("Chừa ít nhất <color=yellow>%s ô trống<color> trong túi để nhận thưởng!",(6 + nFreeCount)));
		return;
	end;
	
	-- 調用獎勵函數發獎
	self:ShowAwardDialog(self:SelectAwardType());
end;

-- 保存獎勵狀態，以防玩家掉線不能領獎
function LinkTask:SetAwardState(nState)
	self:_Debug("Set Award State: "..nState);
	self:SetTask(self.TSK_AWARDSAVE, nState);
end;

function LinkTask:GetAwardState()
	return self:GetTask(self.TSK_AWARDSAVE);
end;

--修正為存儲隨機數，不是隨機種子
function LinkTask:SaveRandomSeed(nRandom, nBit)
	me.SetTask(self.TSKGID, self.TSK_RANDOMNUMBER[nBit], nRandom or 0);
end;

function LinkTask:ClearRandomSeed()
	for _, nTask in pairs(self.TSK_RANDOMNUMBER) do
		me.SetTask(self.TSKGID, nTask, 0);
	end
end

--修正為存儲隨機數，不是隨機種子
function LinkTask:GetRandomSeed(nBit)
	return me.GetTask(self.TSKGID, self.TSK_RANDOMNUMBER[nBit]);
end;

-- 發完獎的後續處理
function LinkTask:AwardFinish()
	
	-- 設置已經發完獎勵，首先執行此語句以保證安全性
	self:SetAwardState(2);
		
	local nTaskType			= self:GetTask(LinkTask.TSK_TASKTYPE);
	local nTaskNum			= self:GetTaskNum_PerDay();
	local n10TimesNum		= self:GetTask10TimesNum_PerDay();
	
	local nDailyAward		= self:GetTask(self.TSK_LINKAWARDDATE);	
	local nNowDate			= tonumber(GetLocalDate("%Y%m%d"));

	local nTaskTotalNum		= self:GetTaskTotalNum_PerDay();
	local nAwardFlag		= math.fmod(nTaskNum + 1, 10);

	-- 每天完成的第一輪任務獲得3點威望和200000心得
	
	local nFreeCount, tbExecute = SpecialEvent.ExtendAward:DoCheck("LinkTask", me, nTaskNum + 1);
	SpecialEvent.ExtendAward:DoExecute(tbExecute);

	-- 寫入領取鏈獎勵的日期
	if nTaskNum == 49 then
		local tbItemInfo = {bForceBind = 1};
		me.AddStackItem(18,1,3046,1,nil,30);
	    me.AddStackItem(18,1,3019,1,nil,30);
		me.AddStackItem(18,1,3039,1,nil,5);
		me.AddExp(5000000);
		me.AddBindMoney(500000);
		me.AddJbCoin(30000);
		me.AddBindCoin(50000);		
		me.Msg("<color=green>Hành trang trống >=5 để nhận<color> <color=yellow>Phần Thưởng 3 Vạn Đồng<color>!");
		GlobalExcute({"Dialog:GlobalNewsMsg_GS","Người chơi <color=green>"..me.szName.."<color> hoàn thành 50 NV <color=red>Bao Vạn Đồng<color> nhận được <color=gold>3 Vạn Đồng<color>"});
        KDialog.MsgToGlobal("Người chơi <color=green>"..me.szName.."<color> hoàn thành 50 NV <color=gold>Bao Vạn Đồng<color> nhận được <color=yellow>3 Vạn Đồng<color>");
		self:SetTask(self.TSK_LINKAWARDDATE, tonumber(GetLocalDate("%Y%m%d")));
			
	end;
	
	-- 用於修改老玩家召回任務變量修改
	Task.OldPlayerTask:AddPlayerTaskValue(me.nId, 2082, 1);	
	
	-- 次數 +1
	self:AddTaskNum();

	-- 將容忍次數清零
	self:SetTask(self.TSK_CONTAIN, 0);
	
	self:ClearRandomSeed();
	Task:CloseTask(nTaskType, "linktask_finish");

end;


function LinkTask:AwardShengWang(nShengWang)
	me.AddRepute(1, 1, nShengWang);
end

function LinkTask:AwardWeiWang(nWeiWang, nGongXian)
	me.AddKinReputeEntry(nWeiWang, "linktask");
end

function LinkTask:AwardXinDe(nXinDe)
	if (nXinDe <= 0) then
		return;
	end
	local pPlayer = me;
	Setting:SetGlobalObj(pPlayer);
	Task:AddInsight(nXinDe);
	Setting:RestoreGlobalObj();
end

function LinkTask:AwardJingHuo()
	local nEffect	= Player:GetLevelEffect(me.nLevel);
	local nJing = math.floor(self.JINGLI * nEffect);
	local nHuo 	= math.floor(self.HUOLI * nEffect);
	return nJing, nHuo ; -- 活力
end


-- 取消任務
function LinkTask:Cancel()
	local nTaskType		= LinkTask:GetTask(LinkTask.TSK_TASKTYPE);
	
	local nCancel = self:GetTask(self.TSK_CANCELNUM);
	local nContain = self:GetTask(self.TSK_CONTAIN);
	
	if nCancel>=1 then
		nCancel = nCancel - 1;
		self:SetTask(self.TSK_CANCELNUM, nCancel);
		
		-- 使用任務引擎的放棄機制
		Task:CloseTask(nTaskType, "giveup");
		me.Msg("Bạn đã sử dụng 1 cơ hội hủy nhiệm vụ! Hiện tại bạn còn: <color=yellow>"..nCancel.."<color>");
	else
		-- 如果沒有取消機會的情況下取消，總任務數清 0
		self:SetTaskNum(0);
		self:SetTaskNum_PerDay(0);
		
		nContain = nContain + 1;
		self:SetTask(self.TSK_CONTAIN, nContain);
		Task:CloseTask(nTaskType, "giveup");
		
		me.Msg("<color=yellow>Bạn đã hủy nhiệm vụ khi không có cơ hội hủy, tổng số nhiệm vụ bằng 0<color>!");
		
		if nContain >= self.CONTAIN_LIMIT then
			self:Pause();
			return 1;
		end;
	end;
	
	return 0;

end;

-- 超過容忍次數，任務暫停，並清空任務
function LinkTask:Pause()
	local nNowTime = me.nOnlineTime;
	self:SetTask(self.TSK_CANCELTIME, nNowTime);
	self:SetTaskNum(0);
	self:SetTaskNum_PerDay(0);
	me.Msg("Bạn đã hủy nhiệm vụ quá "..self.CONTAIN_LIMIT.." lần, nên nghỉ một lúc thì hơn!");
end;




-- 返回任務的價值量，返回值為 TABLE，{Value1, Value2}
function LinkTask:GetTaskValue()
	local nSubTaskId	= self:GetTask(self.TSK_TASKID);
	local nTaskType		= self:GetTask(LinkTask.TSK_TASKTYPE);
	local tbTask  = 0;
	
	if nTaskType>0 then
		tbTask = self.tbfile_SubTask[nTaskType];
	else
		self:_Debug("function:GetTaskValue  Get Type Error!");
		return {0, 0};
	end;
	
	local nTaskRow = tbTask:GetDateRow("TaskId", nSubTaskId);
	local nTaskValue1 = tbTask:GetCellInt("Value1", nTaskRow);
	local nTaskValue2 = tbTask:GetCellInt("Value2", nTaskRow);
	
	self:_Debug("Get task value: "..nTaskValue1.." / "..nTaskValue2);
	return {nTaskValue1, nTaskValue2};
end;



-- ====================== 組隊相關函數 ======================

-- 當隊長共享時，隊員所顯示的對話框
function LinkTask:Team_ShowTaskInfo(pPlayer, szCaptainName, nTaskType, nSubTaskId)
	local szTaskName	= Task.tbSubDatas[nSubTaskId].szName;
	
	Dialog:Say(
			"Đội trưởng hiện tại của bạn <color=yellow>"..szCaptainName.."<color> muốn chia sẻ với bạn Nhiệm vụ nghĩa quân: <color=green>"..szTaskName.."<color>, bạn đồng ý không?",
			{
				{"Phải", LinkTask.Team_AcceptTask, LinkTask, pPlayer, szCaptainName, nTaskType, nSubTaskId},
				{"Không"},
			}
		);
end;


-- 這裡的 ME 會不會有問題？？？
function LinkTask:Team_AcceptTask(pPlayer, szCaptainName, nTaskType, nSubTaskId)

--	print ("Team get task: "..me.szName, pPlayer.szName);
	-- 如果當前玩家已經有了這個主任務，則應該關掉，避免加不上任務的情況
	Task:CloseTask(nTaskType, "linktask_finish");

	self:_Debug("Start Task: "..nTaskType..", "..nSubTaskId);
	
	local tbTask = Task:DoAccept(nTaskType, nSubTaskId);
	if (not tbTask) then
		return;
	end
	
--	print ("LinkTask get param: ", szCaptainName, nTaskType, nSubTaskId);
	
	-- 儲存任務類型和行數在玩家變量裡
	pPlayer.SetTask(LinkTask.TSKG_LINKTASK, LinkTask.TSK_TASKTYPE, nTaskType);	
	pPlayer.SetTask(LinkTask.TSKG_LINKTASK, LinkTask.TSK_TASKID, nSubTaskId);
	
	LinkTask:SetTaskText(pPlayer, nTaskType);
	
end;



-- 義軍銀票兌換過程

-- 給與界面的處理
function LinkTask:ShowBillGiftDialog(nNpcId)
	
	if not nNpcId then nNpcId = 0; end;
	LinkTask.tbBillDialog.nNpcId	= nNpcId;
	-- 在這裡獲取任務所需的物品	
	Dialog:Gift("LinkTask.tbBillDialog");
end;

function LinkTask.tbBillDialog:OnUpdate()
	local nAvailablyDay = me.GetTask(2057, 1);
	local nToday = tonumber(os.date("%Y%m%d", GetTime()));
	if (nAvailablyDay >= nToday) then
		local nYear = math.floor(nAvailablyDay / 10000);
		local nMonth = math.floor(nAvailablyDay % 10000 / 100);
		local nDay = math.floor(nAvailablyDay % 100);
		LinkTask.tbBillDialog._szContent	= "Xin bỏ ngân phiếu vào đây, một lần có thể bỏ nhiều ngân phiếu.\n\nTrước <color=yellow>"..nYear.." - "..nMonth.." - "..nDay.."<color>, có thể đến gặp Quan Quân Nhu (nghĩa quân) để trực tiếp đổi ngân phiếu.";
	else
		LinkTask.tbBillDialog._szContent	= "Xin bỏ ngân phiếu vào đây, một lần có thể bỏ nhiều ngân phiếu.";
	end 
end;

function LinkTask.tbBillDialog:OnOK()
	local pFind = LinkTask.tbBillDialog:First();
	local tbDelItem = {};
	local nBillCount = 0; -- 一共有多少張銀票
	
	if pFind==nil then
		Dialog:Say("Bạn chưa để vật phẩm vào!");
		tbDelItem = {};
		return;
	end;
	
	while pFind do
		
		if pFind.nGenre == 18 and pFind.nDetail == 1 and pFind.nParticular == 262 then
			nBillCount = nBillCount + pFind.nCount;
			table.insert(tbDelItem, pFind);
		else
			Dialog:Say("Ta chỉ có thể đổi ngân phiếu, hãy kiểm tra lại xem có để nhầm thứ khác?");
			tbDelItem = {};
			return;
		end;	
		pFind = LinkTask.tbBillDialog:Next();
	end;

	for i=1, #tbDelItem do
		if tbDelItem[i].Delete(me) ~= 1 then
			-- 刪除銀票出錯直接返回，不發錢了
			tbDelItem = {};
			nBillCount = 0;
			return ;
		end
	end;
	
	-- 發錢
	for i=1, nBillCount do
		me.Earn( (10000 * LinkTask:_CountLevelProductivity()) / 2, Player.emKEARN_YIJUN );
	end;

	-- 累加變量
	if LinkTask.tbBillDialog.nNpcId ~=0 then
		local nLimit = BaiHuTang.tbGetAwardCount[LinkTask.tbBillDialog.nNpcId] or 0;
		nLimit = nLimit + 1;
		BaiHuTang.tbGetAwardCount[LinkTask.tbBillDialog.nNpcId] = nLimit;
	end;
end;
