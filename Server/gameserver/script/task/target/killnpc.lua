
local tb	= Task:GetTarget("KillNpc");
tb.szTargetName	= "KillNpc";	--本目標 - 名字，暫時還沒用到

--目標 - 執行流程：
--	1、Init			系統啟動LoadSub時生成此目標類 - 第一次派生，並針對每一個派生調用Init
--	2、Start/Load	需要激活一個目標時，系統生成此類 - 第二次派生，並調用Start（剛進入此步驟）或Load（玩家上線時載入舊目標）
--	3、Close		目標需要終止時，系統會調用Close
--	4、系統銷毀此目標 - 第二次派生

--此外：
--	Save、GetDesc	在目標被激活期間（步驟2之後，步驟3之前），會根據情況不定期調用
--	GetStaticDesc	在目標被初始化之後（步驟1之後），會根據情況不定期調用

--目標 - 執行流程：
--	1、Init			系統啟動時生成此目標類 - 第一次派生，並針對每一個派生調用Init
--	2、Start/Load	需要激活一個目標時，系統生成此類 - 第二次派生，並調用Start（剛進入此步驟）或Load（玩家上線時載入舊目標）
--	3、Close		目標需要終止時，系統會調用Close
--	4、系統銷毀此目標 - 第二次派生

--此外：
--	Save、GetDesc	在目標被激活期間（步驟2之後，步驟3之前），會根據情況不定期調用
--	GetStaticDesc	在目標被初始化之後（步驟1之後），會根據情況不定期調用

----==== 以下一段是所有目標都必須定義 - 幾個函數 ====----

--目標初始化
--具體參數可在任務編輯器中自定義
function tb:Init(nNpcTempId, nMapId, nNeedCount, szBeforePop, szLaterPop)
	self.nNpcTempId		= nNpcTempId;
	self.szNpcName		= KNpc.GetNameByTemplateId(nNpcTempId);
	self.nMapId			= nMapId;
	self.szMapName		= Task:GetMapName(nMapId);
	self.nNeedCount		= nNeedCount;
	self.szBeforePop	= szBeforePop;
	self.szLaterPop		= szLaterPop;
end;

--目標開啟
function tb:Start()
	self.nCount		= 0;
end;

--目標保存
--根據任務變量組Id（nGroupId）以及組內變量起始Id（nStartTaskId），保存本目標 - 運行期數據
--返回實際存入 - 變量數量
function tb:Save(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	self.me.SetTask(nGroupId, nStartTaskId, self.nCount);
	return 1;
end;

--目標載入
--根據任務變量組Id（nGroupId）以及組內變量起始Id（nStartTaskId），載入本目標 - 運行期數據
--返回實際載入 - 變量數量
function tb:Load(nGroupId, nStartTaskId)
	self.tbSaveTask	= {	-- 這裡保存下來，以後隨時可以自行同步客戶端
		nGroupId		= nGroupId,
		nStartTaskId	= nStartTaskId,
	};
	self.nCount		= self.me.GetTask(nGroupId, nStartTaskId);

	return 1;
end;

--返回目標是否達成
function tb:IsDone()
	return self.nCount >= self.nNeedCount;
end;

--返回目標進行中 - 描述（客戶端）
function tb:GetDesc()
	local szMsg	= "Đánh bại ";
	if (self.nMapId ~= 0) then
		szMsg	= szMsg..self.szMapName.." - ";
	end;
	szMsg	= szMsg..string.format("%s：%d/%d", self.szNpcName, self.nCount, self.nNeedCount);
	return szMsg;
end;

--返回目標 - 靜態描述，與當前玩家進行 - 情況無關
function tb:GetStaticDesc()
	local szMsg	= "Đánh bại ";
	if (self.nMapId ~= 0) then
		szMsg	= szMsg..self.szMapName.." - ";
	end;
	szMsg	= szMsg..string.format("%s %d", self.szNpcName, self.nNeedCount);
	return szMsg;
end;

--目標活動停止
--	szReason，停止 - 原因：
--		"logout"	玩家下線
--		"finish"	步驟完成
--		"giveup"	玩家放棄任務
--		"failed"	任務失敗
--		"refresh"	客戶端刷新
function tb:Close(szReason)
	local oldPlayer = me;
	me = self.me;
	me = oldPlayer;
end;

----==== 以下是本目標所特有 - 函數定義，如有雷同，純屬巧合 ====----
function tb:OnKillNpc(pPlayer, pNpc)
	if (self:IsDone()) then
		return;
	end;
	if (self.nNpcTempId ~= pNpc.nTemplateId) then
		return;
	end;
	if (self.nMapId ~= 0 and self.nMapId ~= self.me.GetMapId()) then
		return;
	end;
	self.nCount	= self.nCount + 1;
	
	
	local tbSaveTask	= self.tbSaveTask;
	if (MODULE_GAMESERVER and tbSaveTask) then	-- 自行同步到客戶端，要求客戶端刷新
		self.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId, self.nCount, 1);
		KTask.SendRefresh(self.me, self.tbTask.nTaskId, self.tbTask.nReferId, tbSaveTask.nGroupId);
	end;
	
	if (self:IsDone()) then	-- 本目標是一旦達成後不會失效 - 
		self.me.Msg("Mục tiêu:"..self:GetStaticDesc());
		self.tbTask:OnFinishOneTag();
	end;
	
end;
