-- 文件名　：playerpray.lua
-- 創建者　：zhouchenfei
-- 創建時間：2008-09-02 09:29:06

--1.effect	獎勵狀態，			(nid,nlevel)狀態id，狀態等級
--2.money	獎勵金錢，			(nmoney)金錢數
--3.item	獎勵物品，			物品具體id
--4.exp		獎勵經驗，			具體經驗量
--5.playertitle 玩家稱號

local tbPlayerPray	= Task.tbPlayerPray or {};	-- 支持重載
Task.tbPlayerPray	= tbPlayerPray;

tbPlayerPray.TSKGROUP				= 2049;		-- 祈福任務變量
tbPlayerPray.TSK_SAVEELEMENT		= 1;		-- 保存祈福結果 一個整數保存五個結果
tbPlayerPray.TSK_PRAYCOUNT			= 2;		-- 記錄玩家今日系統送的祈福次數,默認為0
tbPlayerPray.TSK_INDIRAWARDFLAG		= 3;		-- 有物品獎勵沒領的記錄
tbPlayerPray.TSK_EXPRAYCOUNT		= 4;		-- 記錄玩家使用道具加上的祈福次數
tbPlayerPray.TSK_TODAYUSEDCOUNT		= 5;		-- 記錄玩家已經祈福的次數
tbPlayerPray.TSK_USEDPRAYITEMFLAG	= 6;		-- 記錄上一次使用祈福令牌時間
tbPlayerPray.TSK_GIVECOUNT			= 7;		-- 充值贈送次數，或者其他贈送獎勵
tbPlayerPray.TSK_IFGETEXTRACOUNT	= 8;		-- 合服子服務器玩家是否領取過額外祈福次數
tbPlayerPray.TSK_CLOSEPRAY			= 200;		-- 關閉開啟祈福功能按鈕

tbPlayerPray.CLOSEPRAYSYS			= 0;		-- 關閉祈福功能的標志，默認為0，表示不關閉，1為關閉
tbPlayerPray.SYSGIVECOUNT			= 1;		-- 系統每天給予的免費祈福次數

-- by zhangjinpin@kingsoft
tbPlayerPray.TASK_INTERVAL			= 9;		-- 處理協議時間間隔
tbPlayerPray.MAX_INTERVAL			= 1;		-- 1秒間隔

function tbPlayerPray:init()
	self.CLOSEPRAYSYS = 0;
	
	if (GLOBAL_AGENT) then
		self:ClosePraySystem();
	end;
end

function tbPlayerPray:ClosePraySystem()
	self.CLOSEPRAYSYS = 1;
end

-- 獲取祈福獎勵配置表
function tbPlayerPray:LoadPraySetting()
	local tbAwardList = {};
	local tbData = Lib:LoadTabFile("\\setting\\task\\help\\playerpray.txt");
	for _, tbRow in ipairs(tbData) do
		local tbSubData = tbAwardList;
		local tbPreData	= nil;
		for i=1, 5 do
			local nElement = tonumber(tbRow["PRAY_" .. i]);
			if (0 >= nElement) then
				break;
			end
			if (not tbSubData[nElement]) then
				tbSubData[nElement] = {};
				tbSubData[nElement].tbAward		= {};
				tbSubData[nElement].tbSubData	= {};
				tbSubData[nElement].szPrayWords	= "";
				tbSubData[nElement].szPrayThing	= "";
			end
			
			tbPreData = tbSubData[nElement];
			tbSubData = tbSubData[nElement].tbSubData;
		end
		
		if (tbPreData) then
			local tbAward		= {};
			local tbEffect		= {};
			local nPrayAgain	= 0;
			for i=1, 8 do
				local szType	= tbRow["AWARD_TYPE_" .. i];
				local szAward	= tbRow["AWARD_VALUE_" .. i];
				if (szType and string.len(szType) > 0) then
					local tbTemp = {};
					if (string.find(szAward, "\"")) then
						szAward = Lib:StrTrim(szAward, "\"")
					end
					tbTemp.szType	= szType;
					tbTemp.szAward	= szAward;
					tbAward[#tbAward + 1]	= tbTemp;
				end
			end
			tbPreData.szPrayWords	= tbRow["PRAYWORDS"];
			tbPreData.szPrayThing	= tbRow["PRAYTHING"];
			tbPreData.tbAward		= tbAward;
			tbPreData.nPrayAgain	= nPrayAgain;
		end
	end
	self.tbAwardList = tbAwardList;
end

-- 獲得某一次的五行屬性 第幾輪祈福
function tbPlayerPray:GetPrayElement(pPlayer, nRound)
	local nAllElement	= pPlayer.GetTask(self.TSKGROUP, self.TSK_SAVEELEMENT);
	local nBegin		= (nRound - 1) * 3;
	local nElement		= Lib:LoadBits(nAllElement, nBegin, nBegin + 2);
	return nElement;
end

-- 保存五行屬性
function tbPlayerPray:SetPrayElement(pPlayer, nRound, nElement)
	local nAllElement	= pPlayer.GetTask(self.TSKGROUP, self.TSK_SAVEELEMENT);
	local nBegin		= (nRound - 1) * 3;
	nAllElement			= Lib:SetBits(nAllElement, nElement, nBegin, nBegin + 2);
	pPlayer.SetTask(self.TSKGROUP, self.TSK_SAVEELEMENT, nAllElement);
	self:WriteLog("SetPrayElement", string.format("Player %s set pray %d round element %d", pPlayer.szName, nRound, nElement));
end

-- 獲得祈福記錄中已經祈福的個數
function tbPlayerPray:GetPrayResultCount(pPlayer)
	local nRound = 0;
	for i=1, 5 do
		local nEle = self:GetPrayElement(pPlayer, i);
		if (nEle <= 0) then
			break;
		end
		nRound = nRound + 1;
	end
	return nRound;
end

function tbPlayerPray:DirGetAward(pPlayer)
	local tbElement = {};
	for i=1, 5 do
		tbElement[#tbElement + 1] = self:GetPrayElement(pPlayer, i);
	end

	return self:GetAward(pPlayer, tbElement);
end

function tbPlayerPray:CheckAllowGetAward(pPlayer)
	if (1 == self.CLOSEPRAYSYS) then
		return 1;
	end
	
	local nTskIndirFlag = pPlayer.GetTask(self.TSKGROUP, self.TSK_INDIRAWARDFLAG);
	if (1 ~= nTskIndirFlag) then
		self:WriteLog("CheckAllowGetAward", string.format("There is no pray award for Player %s!", pPlayer.szName));
		return 1;
	end

	local tbAward = self:DirGetAward(pPlayer);

	if (#tbAward <= 0) then
		self:WriteLog("CheckAllowGetAward", "There is no pray award!", pPlayer.szName, pPlayer.GetTask(self.TSKGROUP, self.TSK_SAVEELEMENT));
		return 1;
	end
	
	if (1 == self:CheckBag(pPlayer, tbAward)) then
		return 2;
	end	
	
	return 0;
end

-- 獎勵祈福物品或者金錢或者其他需要領取的獎勵
function tbPlayerPray:GiveAward(pPlayer)
	local nAwardFlag = self:CheckAllowGetAward(pPlayer);
	if (0 < nAwardFlag) then
		if (2 == nAwardFlag) then
			pPlayer.Msg("Túi không đủ chỗ trống, không thể tặng phần thưởng");
		end
		self:WriteLog("GiveAward", string.format("Player %s is not allowed to get award!!", pPlayer.szName));
		return;
	end
	
	local tbAward = self:DirGetAward(pPlayer);
	for i=1, #tbAward do
		self:GiveDetailAward(pPlayer, tbAward[i]);
	end

	pPlayer.SetTask(self.TSKGROUP, self.TSK_INDIRAWARDFLAG, 0);

	self:GivePrayAnnouns(pPlayer, tbAward);	
end

-- 判斷背包中是否有剩余空間
function tbPlayerPray:CheckBag(pPlayer, tbAward)
	local nCount = 0;
	for i=1, #tbAward do
		if (tbAward[i].szType == "item") then
			nCount = nCount + 1;
		end
	end
	if (pPlayer.CountFreeBagCell() < nCount) then
		return 1;
	end
	return 0;
end

-- 通過給定的五行獲取相應獎勵
function tbPlayerPray:GetAward(pPlayer, tbElement)
	local tbAwardList	= self.tbAwardList;
	local tbAward		= {};
	
	for i=1, #tbElement do
		local nElement	= tbElement[i];
		if (nElement <= 0) then
			break;
		end
		
		if (not tbAwardList[nElement]) then
			if (nElement > 0) then
				self:WriteLog("Player Pray error at element, round", pPlayer.szName, nElement, i);
			end
			break;
		end

		if (tbAwardList[nElement].tbAward) then
			tbAward = tbAwardList[nElement].tbAward;
		end

		tbAwardList = tbAwardList[nElement].tbSubData;	
	end
	return tbAward;
end

-- 獲取獎勵中效果獎勵部分
function tbPlayerPray:GetEffect(pPlayer, tbElement)
	local tbAward	= self:GetAward(pPlayer, tbElement);
	local tbEffect	= {};
	for i=1, #tbAward do
		if ("effect" == tbAward[i].szType) then
			tbEffect[#tbEffect + 1] = tbAward[i];
		end
	end
	return tbEffect;
end

-- 獲得祈福文字說明
function tbPlayerPray:GetPrayWords(pPlayer, tbElement)
	local tbAwardList	= self.tbAwardList;
	local tbWords		= {};
	tbWords.szPrayWords = "";
	tbWords.szPrayThing = "";

	for i=1, #tbElement do
		local nElement	= tbElement[i];
		if (nElement <= 0) then
			break;
		end

		if (not tbAwardList[nElement]) then
			if (nElement > 0) then
				self:WriteLog("Player Pray error at element, round", pPlayer.szName, nElement, i);
			end
			break;
		end

		tbWords.szPrayWords = tbAwardList[nElement].szPrayWords;
		tbWords.szPrayThing = tbAwardList[nElement].szPrayThing;

		tbAwardList = tbAwardList[nElement].tbSubData;	
	end
	return tbWords;
end

-- 具體獎勵物品細節
function tbPlayerPray:GiveDetailAward(pPlayer, tbOneAward)
	local szType	= tbOneAward.szType;
	local szAward	= tbOneAward.szAward;
	local tbValue	= Lib:SplitStr(szAward, ",");
	if (not tbValue or #tbValue <= 0) then
		self:WriteLog("GiveDetailAward", "Award error szType, szAward", pPlayer.szName, szType, szAward);
		return;
	end
	self:WriteLog("GiveDetailAward", "Give player award", pPlayer.szName, szType, szAward);
	local tbNum = {};
	for i=1, #tbValue do
		tbNum[i] = tonumber(tbValue[i]);
	end
	if ("money" == szType) then
		pPlayer.Earn(tbNum[1], Player.emKEARN_BAI_QIU_LIN);
	elseif ("item" == szType) then
		pPlayer.AddItem(unpack(tbNum));
	elseif ("exp" == szType) then
		pPlayer.AddExp(tbNum[1]);
	elseif ("effect" == szType) then
		pPlayer.AddSkillState(unpack(tbNum));
	elseif ("playertitle" == szType) then
		local nSex = tbNum[5];
		tbNum[5] = nil;
		if (nSex == 2) then
			pPlayer.AddTitle(unpack(tbNum));
		elseif (nSex == pPlayer.nSex) then
			pPlayer.AddTitle(unpack(tbNum));
		end
	elseif ("repute" == szType) then
		pPlayer.AddRepute(unpack(tbNum));
	else
		self:WriteLog("GiveDetailAward", "The type is no define or exist!", pPlayer.szName, szType, szAward);
	end
end

-- 申請獲得祈福結果
function tbPlayerPray:OnApplyGetResult()
	local nInterval = me.GetTask(self.TSKGROUP, self.TASK_INTERVAL);
	if GetTime() - nInterval < self.MAX_INTERVAL then
		return 0;
	end
	
	me.SetTask(self.TSKGROUP, self.TASK_INTERVAL, GetTime());
	self:GivePrayResult();
end

function tbPlayerPray:EnablePray(pPlayer)
	pPlayer.SetTask(self.TSKGROUP, self.TSK_CLOSEPRAY, 0);
end

function tbPlayerPray:DisablePray(pPlayer)
	pPlayer.SetTask(self.TSKGROUP, self.TSK_CLOSEPRAY, 1);
end

-- 檢查是否允許繼續祈福
function tbPlayerPray:CheckAllowPray(pPlayer)
	if (1 == self.CLOSEPRAYSYS) then
		return 3;
	end
	
	if (me.nLevel < 50) then
		self:WriteLog("CheckAllowPray", "Stop pray system by level!!!!!!!");		
		return 1;
	end

	local nClosFlag		= pPlayer.GetTask(self.TSKGROUP, self.TSK_CLOSEPRAY);
	if (nClosFlag == 1) then
		self:WriteLog("CheckAllowPray", "Stop pray system by system forbid!!!!!!!");
		return 2;
	end

	-- 有獎未領的時候，不能祈福
	local nValue = pPlayer.GetTask(self.TSKGROUP, self.TSK_INDIRAWARDFLAG);
	if (1 == nValue) then
		self:WriteLog("CheckAllowPray", string.format("Player %s have no pray", me.szName));
		return 3;
	end
	
	-- 沒有祈福機會了
	local nPray = self:GetPrayCount(pPlayer);
	if (nPray <= 0) then
		self:WriteLog("CheckAllowPray", string.format("Player %s have no chance for pray!", me.szName));
		return 3;
	end
	
	return 0;
end

-- 當玩家按確定的時候
function tbPlayerPray:GivePrayResult()
	local pPlayer		= me;
	
	-- 做祈福判斷
	local nPrayFlag		= self:CheckAllowPray(pPlayer);
	if (0 < nPrayFlag) then
		if (1 == nPrayFlag) then
			pPlayer.Msg("Bạn chưa đạt cấp 50, không thể chúc phúc!!");
		elseif (2 == nPrayFlag) then
			pPlayer.Msg("Do lỗi server, hiện đã ngưng chức năng chúc phúc!!");			
		end	
		self:WriteLog("GivePrayResult", string.format("Player %s is not allowed to pray!", pPlayer.szName));
		return;
	end

	-- 判斷是否重新把元素變量清空
	local tbElement = {};
	for i=1, 5 do
		tbElement[#tbElement + 1] = self:GetPrayElement(pPlayer, i);
	end
	local tbAward		= self:GetAward(pPlayer, tbElement);
	if (#tbAward > 0) then
		pPlayer.SetTask(self.TSKGROUP, self.TSK_SAVEELEMENT, 0);
	end

	local nRound		= self:GetPrayResultCount(pPlayer);
	local nEleResult	= Random(5) + 1; -- 因為五行元素從1開始標記，所以要加1
	-- 一輪祈福次數超過了五次
	if (nRound >= 5) then
		self:WriteLog("CheckAllowPray", string.format("Error!! Player %s pray time more then 5 times!", me.szName));
		return;
	end
	self:SetPrayElement(pPlayer, nRound + 1, nEleResult);
	
	-- 獲取間接給的物品
	tbElement = {};
	for i=1, 5 do
		tbElement[#tbElement + 1] = self:GetPrayElement(pPlayer, i);
	end

	tbAward		= self:GetAward(pPlayer, tbElement);
	-- 當有了明確的獎勵後就將完成一次祈福的變量設置為1
	if (#tbAward > 0) then
		
		-- 在這做減少次數的目的是為了
		self:WriteLog("GivePrayResult", string.format("DecParyCount 1 time!!"));
		self:DecPrayCount(pPlayer);

		self:WriteLog("GivePrayResult", "The pray have the result!!");
		pPlayer.SetTask(self.TSKGROUP, self.TSK_INDIRAWARDFLAG, 1);
	end

	pPlayer.CallClientScript({"Ui:ServerCall", "UI_PLAYERPRAY", "OnRecPrayResult", nEleResult});
end

function tbPlayerPray:GivePrayAnnouns(pPlayer, tbAward)
	-- 獲取間接給的物品
	local tbElement = {};
	for i=1, 5 do
		tbElement[#tbElement + 1] = self:GetPrayElement(pPlayer, i);
	end
	
	local nFirstEle = tbElement[1];
	local nCnt		= 0;
	for i = 2, #tbElement do
		if (nFirstEle ~= tbElement[i]) then
			break;
		end
		nCnt = nCnt + 1;
	end
	-- 表示沒有5個相同
	if (4 ~= nCnt) then
		return;
	end
	
	local szMsg = "";

	for i=1, #tbAward do
		if (tbAward[i].szType == "playertitle") then
			szMsg = self:GetAnnounsMsg(pPlayer, nFirstEle);	
			break;
		end
	end
	if (string.len(szMsg) <= 0) then
		return;
	end
	KDialog.NewsMsg(0, Env.NEWSMSG_NORMAL, pPlayer.szName .. szMsg);
	if (pPlayer) then
		pPlayer.SendMsgToFriend("[" .. pPlayer.szName .. "]" .. szMsg);
		Player:SendMsgToKinOrTong(pPlayer, szMsg, 0);
	end
	return;
end

function tbPlayerPray:GetAnnounsMsg(pPlayer, nElement)
	local szTitle	= "";
	local szMsg		= "";
	if (1 == nElement) then
		szMsg = " Cầu 5 chữ Kim! Được 500 điểm danh vọng và danh hiệu <color=255,181,0>[Độc Cô Cầu Bại]<color> ";
	elseif (2 == nElement) then
		szMsg = " Cầu 5 chữ Mộc! Được 500 điểm danh vọng và danh hiệu <color=255,181,0>[Thiên Hạ Vô Song]<color> ";
	elseif (3 == nElement) then
		szMsg = " Cầu 5 chữ Thủy! Được 500 điểm danh vọng";
		if (pPlayer.nSex == 0) then
			szMsg = szMsg .. "và danh hiệu <color=255,181,0>[Phong Nam]<color> ";
		elseif (pPlayer.nSex == 1) then
			szMsg = szMsg .. "và danh hiệu <color=255,181,0>[Tuyệt Đại Phương Hoa]<color> ";
		end
	elseif (4 == nElement) then
		szMsg = " Cầu 5 chữ Hỏa! Được 500 điểm danh vọng";
		if (pPlayer.nSex == 0) then
			szMsg = szMsg .. "và danh hiệu <color=255,181,0>[Hiệp Khách Cuối Cùng Trên Giang Hồ]<color> ";
		elseif (pPlayer.nSex == 1) then
			szMsg = szMsg .. "và <color=255,181,0>[Hiệp Nữ Cuối Cùng Trên Giang Hồ]<color>";
		end
	elseif (5 == nElement) then
		szMsg = " Cầu 5 chữ Thổ! Được 500 điểm danh vọng";
		if (pPlayer.nSex == 0) then
			szMsg = szMsg .. "và danh hiệu <color=255,181,0>[Thiên Chi Kiêu Tử]<color> ";
		elseif (pPlayer.nSex == 1) then
			szMsg = szMsg .. "và danh hiệu <color=255,181,0>[Thiên Chi Kiêu Nữ]<color> ";
		end
	end
	return szMsg;
end

function tbPlayerPray:DecPrayCount(pPlayer)
	local nUsedPray	= pPlayer.GetTask(self.TSKGROUP, self.TSK_PRAYCOUNT);
	local nDailyResetCount = self:GetDailyResetPrayCount(pPlayer);
	local nPray		= nDailyResetCount - nUsedPray;
	local nExPray	= pPlayer.GetTask(self.TSKGROUP, self.TSK_EXPRAYCOUNT);
	local nTodayUsed= pPlayer.GetTask(self.TSKGROUP, self.TSK_TODAYUSEDCOUNT);
	self:WriteLog("DecPrayCount", string.format("Player %s OrgSysPrayCount %d, OrgExPrayCount %d !!", pPlayer.szName, nPray, nExPray));
	if (nPray > 0) then
		nUsedPray = nUsedPray + 1;
		if (nUsedPray > nDailyResetCount) then
			nUsedPray = nDailyResetCount;
		end
		pPlayer.SetTask(self.TSKGROUP, self.TSK_PRAYCOUNT, nUsedPray);
		nTodayUsed = nTodayUsed + 1;
		pPlayer.SetTask(self.TSKGROUP, self.TSK_TODAYUSEDCOUNT, nTodayUsed);
		self:WriteLog("DecPrayCount", string.format("Player %s NowSysPrayCount %d, NowExPrayCount %d !!", pPlayer.szName, nDailyResetCount - nUsedPray, nExPray));
		return 1;
	end
	
	if (nExPray > 0) then
		nExPray = nExPray - 1;
		if (nExPray < 0) then
			nExPray = 0;
		end
		pPlayer.SetTask(self.TSKGROUP, self.TSK_EXPRAYCOUNT, nExPray);
		nTodayUsed = nTodayUsed + 1;
		pPlayer.SetTask(self.TSKGROUP, self.TSK_TODAYUSEDCOUNT, nTodayUsed);
		self:WriteLog("DecPrayCount", string.format("Player %s NowSysPrayCount %d, NowExPrayCount %d !!", pPlayer.szName, nDailyResetCount - nUsedPray, nExPray));
		return 1;	
	end
	
	return 0;
end

function tbPlayerPray:GetPrayCount(pPlayer)
	local nPray, nExPray = self:GetPrayDetailCount(pPlayer);
	return nPray + nExPray;
end

function tbPlayerPray:GetPrayDetailCount(pPlayer)
	local nUsedPray		= pPlayer.GetTask(self.TSKGROUP, self.TSK_PRAYCOUNT);
	local nPray			= self:GetDailyResetPrayCount(pPlayer) - nUsedPray;
	local nExPray		= pPlayer.GetTask(self.TSKGROUP, self.TSK_EXPRAYCOUNT);
	return nPray, nExPray;
end

function tbPlayerPray:OnApplyGetAward()
	
	local nInterval = me.GetTask(self.TSKGROUP, self.TASK_INTERVAL);
	if GetTime() - nInterval < self.MAX_INTERVAL then
		return 0;
	end
	
	--me.SetTask(self.TSKGROUP, self.TASK_INTERVAL, GetTime());
	
	self:GiveAward(me);
	me.CallClientScript({"Ui:ServerCall", "UI_PLAYERPRAY", "OnUpdatePrayState"});
	
	-- 師徒成就：祈福
	Achievement:FinishAchievement(me.nId, Achievement.QIFU);
end

function tbPlayerPray:WriteLog(...)	
	if (MODULE_GAMESERVER) then
		Dbg:WriteLogEx(Dbg.LOG_INFO, "Help", "PlayerPray", unpack(arg));	
	end
	
	if (MODULE_GAMECLIENT) then
		Dbg:Output("Help", "PlayerPray", unpack(arg));
	end
end

function tbPlayerPray:_StaticPray(nMaxCount, tbEle)
	local pPlayer		= me;
	local nStatElement	= 0;
	for i=1, 5 do
		local nElement	= tbEle[i];
		local nBegin	= (i - 1) * 3;
		nStatElement	= Lib:SetBits(nStatElement, nElement, nBegin, nBegin + 2);
	end
	local nCount		= 0;
	local nStatCount	= 0;
	local nAllElement 	= 0;
	local nRound		= 0;
	local tbElement		= {};
	while nCount < nMaxCount do
		local nEleResult	= Random(5) + 1;
		tbElement[#tbElement + 1] = nEleResult;	
		local tbAward		= self:GetAward(pPlayer, tbElement);
		local tbEffect		= self:GetEffect(pPlayer, tbElement);		
		if (#tbAward > 0 or #tbEffect > 0) then
			local nStatEle	= 0;
			for i=1, #tbElement do
				local nElement	= tbElement[i];
				local nBegin	= (i - 1) * 3;
				nStatEle		= Lib:SetBits(nStatEle, nElement, nBegin, nBegin + 2);
			end
			if (nStatEle == nStatElement) then
				nStatCount = nStatCount + 1;
			end
			nAllElement = 0;
			nRound		= 0;
			tbElement	= {};
			nCount		= nCount + 1;			
		end
	end
	print(string.format("nCount = %d, nMaxCount = %d", nStatCount, nMaxCount));
end

function tbPlayerPray:GM_Refresh()
	self:ResetElementRound();
	me.SetTask(self.TSKGROUP, self.TSK_INDIRAWARDFLAG, 0);
end

-- 每天會重置祈福次數
function tbPlayerPray:ResetElementRound()
	self:ResetGiveCount(me);
	me.SetTask(self.TSKGROUP, self.TSK_PRAYCOUNT, 0);
	me.SetTask(self.TSKGROUP, self.TSK_TODAYUSEDCOUNT, 0);
end

function tbPlayerPray:Pray_OnLogin()
	self:ResetGiveCount(me);
end

function tbPlayerPray:ResetGiveCount(pPlayer)
	local nMoney = pPlayer.GetExtMonthPay();
	local nCount = 0;
	
	if Task.IVER_nResetGive == 1 then
		if (nMoney >= 48 and pPlayer.nLevel >= 50) then
			nCount = 1;
		end	
	end
	
	-- *******合服優惠，合服7天後過期*******
	if GetTime() < KGblTask.SCGetDbTaskInt(DBTASK_COZONE_TIME) + 7 * 24 * 60 * 60 and pPlayer.nLevel >= 50 then
			nCount = nCount + 1;
	end
	-- *************************************
	
	-- *******合服優惠，子服務器玩家可以獲得額外祈福次數*******
	if (pPlayer.IsSubPlayer() == 1 and pPlayer.GetTask(self.TSKGROUP, self.TSK_IFGETEXTRACOUNT) == 0 and pPlayer.nLevel >= 50) then
		local nExtraCount = math.floor(KGblTask.SCGetDbTaskInt(DBTASK_SERVER_STARTTIME_DISTANCE) / (24 * 3600));
		if (nExtraCount >= 0) then
			self:AddExPrayCount(pPlayer, nExtraCount);
		end
		pPlayer.SetTask(self.TSKGROUP, self.TSK_IFGETEXTRACOUNT, 1);
	end
	if (pPlayer.IsSubPlayer() == 0 and pPlayer.GetTask(self.TSKGROUP, self.TSK_IFGETEXTRACOUNT) == 1) then
		pPlayer.SetTask(self.TSKGROUP, self.TSK_IFGETEXTRACOUNT, 0);
	end
	-- ********************************************************
	pPlayer.SetTask(self.TSKGROUP, self.TSK_GIVECOUNT, nCount);
end

-- 判斷今天是否使用過祈福令牌，1表示今天已經使用過了，0表示沒有用過
function tbPlayerPray:CheckLingPaiUsed(pPlayer, nNowTime)
	local nUsedTime = pPlayer.GetTask(self.TSKGROUP, self.TSK_USEDPRAYITEMFLAG);
	local nLastDay	= Lib:GetLocalDay(nUsedTime);
	local nNowDay	= Lib:GetLocalDay(nNowTime);
	if (nLastDay >= nNowDay) then
		return 1;
	end
	return 0;
end

function tbPlayerPray:AddCountByLingPai(pPlayer, nCount)
	self:AddExPrayCount(pPlayer, nCount);
	pPlayer.CallClientScript({"Ui:ServerCall", "UI_PLAYERPRAY", "OnUpdatePrayState"});
end

function tbPlayerPray:GetDailyResetPrayCount(pPlayer)
	local nMoneyPray = pPlayer.GetTask(self.TSKGROUP, self.TSK_GIVECOUNT);
	return self.SYSGIVECOUNT + nMoneyPray;
end

function tbPlayerPray:AddExPrayCount(pPlayer, nCount)
	local nLastCount = pPlayer.GetTask(self.TSKGROUP, self.TSK_EXPRAYCOUNT);
	nLastCount = nLastCount + nCount;
	pPlayer.SetTask(self.TSKGROUP, self.TSK_EXPRAYCOUNT, nLastCount);
	self:WriteLog("tbPlayerPray:AddExPrayCount", string.format("Player %s have add %d counts pray times!", pPlayer.szName, nCount));
end

function tbPlayerPray:SetLingPaiUsedTime(pPlayer, nTime)
	pPlayer.SetTask(self.TSKGROUP, self.TSK_USEDPRAYITEMFLAG, nTime);
end

if (MODULE_GAMESERVER) then
	tbPlayerPray:LoadPraySetting();
	PlayerSchemeEvent:RegisterGlobalDailyEvent({tbPlayerPray.ResetElementRound, tbPlayerPray});
	PlayerEvent:RegisterGlobal("OnLogin", tbPlayerPray.Pray_OnLogin, tbPlayerPray);
end

if (MODULE_GAMECLIENT) then
	tbPlayerPray:LoadPraySetting();
end

tbPlayerPray:init();
