-----------------------------------------------------
--文件名		：	battle_bouns.lua
--创建者		：	zhouchenfei
--创建时间		：	2007-10-23
--功能描述		：	战场中的分值处理
------------------------------------------------------

-- 重置积分
function Battle:ResetBonus(pPlayer, nNowTime)
	pPlayer.Msg("Tích lũy bị trừ hết!");
	pPlayer.SetTask(self.TSKGID, self.TSK_BTPLAYER_TOTALBOUNS, 0);
	pPlayer.SetTask(self.TSKGID, self.TSK_BTPLAYER_LASTBOUNSTIME, nNowTime);
end

-- 重置使用积分上限
function Battle:OnWeekEvent_ResetUseBouns()
	local nUseBouns	 = me.GetTask(self.TSKGID, self.TSK_BTPLAYER_USEBOUNS);
	Battle:DbgWrite(Dbg.LOG_INFO, "OnWeekEvent_ResetUseBouns", self.TSKGID, self.TSK_BTPLAYER_USEBOUNS, 0);
	me.SetTask(self.TSKGID, self.TSK_BTPLAYER_USEBOUNS, 0);
end

-- 检查是否是新的一周
function Battle:CheckNewWeek(pPlayer, nNowTime)
	local nLastTime		  	= pPlayer.GetTask(self.TSKGID, self.TSK_BTPLAYER_LASTBOUNSTIME);
	local nLastDay 			= math.ceil(nLastTime / (3600 * 24));
	local nNowDay			= math.ceil(nNowTime / (3600 * 24));
	
	if (nNowDay <= nLastDay) then
		return;
	end

	-- 从星期天开始算,为一个星期的第一天
	nLastDay 			= nLastDay - 4;
	nNowDay				= nNowDay - 4;
	local nLastWeek		= math.floor(nLastDay / 7);
	local nNowWeek		= math.floor(nNowDay / 7);
	if (nNowWeek > nLastWeek) then
		return 1;
	end
	return 0;
end

-- 处理连斩积分奖励
function Battle:ProcessSeriesBouns(tbKillerBattleInfo, tbDeathBattleInfo)
	local nMeRank			= tbDeathBattleInfo.nRank;
	local nPLRank			= tbKillerBattleInfo.nRank;
	-- 符合连斩条件 计算有效连斩
	if (5 >= (nPLRank - nMeRank)) then
		local nSeriesKill	= tbKillerBattleInfo.nSeriesKill + 1;
		tbKillerBattleInfo.nSeriesKill	= nSeriesKill;

		if (math.fmod(nSeriesKill, 3) == 0) then	
			tbKillerBattleInfo.nTriSeriesNum	= tbKillerBattleInfo.nTriSeriesNum + 1;
			self:AddShareBouns(tbKillerBattleInfo, self.SERIESKILLBOUNS)
			local szMsg = string.format("%s - %s %s liên tiếp giết %d quân địch %s, nhận thưởng liên trảm %d điểm tích lũy.", Battle.NAME_CAMP[tbKillerBattleInfo.tbCamp.nCampId], Battle.NAME_RANK[tbKillerBattleInfo.nRank], tbKillerBattleInfo.pPlayer.szName, tbKillerBattleInfo.nSeriesKill,tbDeathBattleInfo.pPlayer.szName, self.SERIESKILLBOUNS);
			KDialog.MsgToGlobal(szMsg);	
		end

		if (tbKillerBattleInfo.nMaxSeriesKill < nSeriesKill) then
			tbKillerBattleInfo.nMaxSeriesKill = nSeriesKill;
		end
	end
	
	-- 计算连斩	
	local nSeriesKillNum	= tbKillerBattleInfo.nSeriesKillNum + 1;
	tbKillerBattleInfo.nSeriesKillNum	= nSeriesKillNum;

	if (tbKillerBattleInfo.nMaxSeriesKillNum < nSeriesKillNum) then
		tbKillerBattleInfo.nMaxSeriesKillNum = nSeriesKillNum;
	end
	
end

-- 获得杀死玩家积分奖励
function Battle:GiveKillerBouns(tbKillerBattleInfo, tbDeathBattleInfo)
	tbKillerBattleInfo.nKillPlayerNum	= tbKillerBattleInfo.nKillPlayerNum + 1;
	
	-- 要不要做安全性检测呢？
	local nMeRank		= tbDeathBattleInfo.nRank;
	local nPLRank		= tbKillerBattleInfo.nRank;
	
	local nRadioRank	= 1;
	nRadioRank			= (10 - (nPLRank - nMeRank)) / 10;
	local nPoints		= math.floor(Battle.tbBonusBase.KILLPLAYER * nRadioRank);
	local nBounsDif		= self:AddShareBouns(tbKillerBattleInfo, nPoints)
	if (nBounsDif > 0) then
		tbKillerBattleInfo.nKillPlayerBouns = tbKillerBattleInfo.nKillPlayerBouns + nPoints;
	end
end

-- 获得战旗积分奖励
function Battle:GetTheFlagBouns(tbBattleInfo)
	local nCamp				= tbBattleInfo.tbCamp.nCampId;
	local nBounsDif 		= self:AddShareBouns(tbBattleInfo, Battle.tbBonusBase.SNAPFLAG)
	if (nBounsDif > 0) then
		tbBattleInfo.nFlagsBouns = tbBattleInfo.nFlagsBouns + Battle.tbBonusBase.SNAPFLAG;
	end
	tbBattleInfo.nFlagNum	= tbBattleInfo.nFlagNum + 1;
end

-- 获得珍宝积分奖励
function Battle:GetTheTreasure(tbBattleInfo)
	local nCamp				= tbBattleInfo.tbCamp.nCampId;
	local nBounsDif 		= self:AddShareBouns(tbBattleInfo, Battle.tbBonusBase.GETITEM)
	if (nBounsDif > 0) then
		tbBattleInfo.nTreasureBouns = tbBattleInfo.nTreasureBouns + Battle.tbBonusBase.GETITEM;
	end
	tbBattleInfo.nTreasure	= tbBattleInfo.nTreasure + 1;
end

-- 积分换经验
function Battle:BounsChangeExp(nLevel, nBouns)
	local nExp = 0;
	if (nLevel < 40) then
		return 0;
	end
	
	if (nLevel > 100) then
		nLevel = 100;
	end
	
	nExp = math.floor(( 700 + math.floor(( nLevel - 40 ) / 5 ) * 100 ) * 60 * 7 /200 )	* nBouns -- 1个积分点的基础经验值
	
	local nKinId = me.dwKinId;
	local cKin = KKin.GetKin(nKinId);
	if (cKin) then
		local nWeeklyTask = cKin.GetWeeklyTask();
		if (Kin.TASK_BATTLE == nWeeklyTask) then
			nExp = math.floor(nExp * 20000);
		end
	end
	return nExp;
end

-- 战局结束时的声望按排名奖励
function Battle:AwardFinalShengWang(tbPlayerList)
	local nNowShengWang = 0;
	local nMaxRank		= 0;
	local nIndex		= 0;
	for i = 1, #tbPlayerList do
		local tbBattleInfo 	= tbPlayerList[i];
		local nNowShengWang	= 0;
		local nRankSheng	= 0;
		local nBounsSheng	= 0;
		if (1 == i) then
			nRankSheng = Battle.tbRANKSHENGWANG[1];
		elseif (2 <= i and 4 >= i) then
			nRankSheng = Battle.tbRANKSHENGWANG[2];
		elseif (5 <= i and 10 >= i) then
			nRankSheng = Battle.tbRANKSHENGWANG[3];
		elseif (11 <= i and 20 >= i) then
			nRankSheng = Battle.tbRANKSHENGWANG[4];
		end
		
		for key, tbRankBouns in ipairs(Battle.tbBOUNSSHENGWANG) do
			if (tbBattleInfo.nBouns >= tbRankBouns[1]) then
				nBounsSheng = tbRankBouns[2];
				break;
			end
		end
		nNowShengWang = nRankSheng;
		if (nBounsSheng > nNowShengWang) then
			nNowShengWang = nBounsSheng;
		end
		local nCamp			= tbBattleInfo.tbCamp.nCampId;
		tbBattleInfo.nShengWang 	= tbBattleInfo.nShengWang + nNowShengWang;
		tbBattleInfo.pPlayer.Msg(string.format("Xếp hạng: <color=green>%d<color>, bạn nhận được <color=white>%d<color> điểm danh vọng chiến trường.", i, tbBattleInfo.nShengWang));
	end
end
function Battle:AwardJbCoin(tbPlayerList)
	local nMaxRank		= 0;
	local nIndex		= 0;
	for i = 1, #tbPlayerList do
		local tbBattleInfo 	= tbPlayerList[i];
		local nJbBonus	= 0;
		if (1 == i) then
	tbBattleInfo.pPlayer.AddStackItem(18,1,1194,11,nil,1);
			tbBattleInfo.pPlayer.Earn(500000,0);
			tbBattleInfo.pPlayer.AddBindMoney(1000000);
			tbBattleInfo.pPlayer.AddJbCoin(150000);
			tbBattleInfo.pPlayer.AddBindCoin(100000);
			tbBattleInfo.pPlayer.Msg("<color=green>Hành trang trống >=5 để nhận<color> <color=yellow>Phần Thưởng 15 vạn dồng thường<color>");
			----------------------------------------------
					GlobalExcute({"Dialog:GlobalNewsMsg_GS","Người chơi <color=green>"..tbBattleInfo.pPlayer.szName.."<color> đã xuất sắc giành <color=gold>Hạng 1<color> trên <color=red>Chiến Trường Tống Kim<color>"});
        KDialog.MsgToGlobal("Người chơi <color=green>"..tbBattleInfo.pPlayer.szName.."<color> đã xuất sắc giành <color=gold>Hạng 1<color> trên <color=yellow>Chiến Trường Tống Kim<color>!");
		--------------------------------------
		elseif (2 == i ) then
	tbBattleInfo.pPlayer.AddStackItem(18,1,1194,12,nil,1);
			tbBattleInfo.pPlayer.Earn(400000,0);
			tbBattleInfo.pPlayer.AddBindMoney(900000);
			tbBattleInfo.pPlayer.AddJbCoin(120000);
			tbBattleInfo.pPlayer.AddBindCoin(80000);
			tbBattleInfo.pPlayer.Msg("<color=green>Hành trang trống >=5 để nhận<color> <color=yellow>Phần Thưởng 12 vạn dồng thường<color>");
		elseif (3 == i ) then
	tbBattleInfo.pPlayer.AddStackItem(18,1,1194,13,nil,1);
			tbBattleInfo.pPlayer.Earn(400000,0);
			tbBattleInfo.pPlayer.AddBindMoney(800000);
			tbBattleInfo.pPlayer.AddJbCoin(100000);
			tbBattleInfo.pPlayer.AddBindCoin(80000);
			tbBattleInfo.pPlayer.Msg("<color=green>Hành trang trống >=5 để nhận<color> <color=yellow>Phần Thưởng 10 vạn đồng thường<color>");
		elseif (4 <= i ) then
	tbBattleInfo.pPlayer.AddStackItem(18,1,1194,14,nil,1);
			tbBattleInfo.pPlayer.Earn(300000,0);
			tbBattleInfo.pPlayer.AddBindMoney(700000);
			tbBattleInfo.pPlayer.AddJbCoin(70000);
			tbBattleInfo.pPlayer.AddBindCoin(70000);
			tbBattleInfo.pPlayer.Msg("<color=green>Hành trang trống >=5 để nhận<color> <color=yellow>Phần Thưởng 7 vạn đồng thường<color>");
		elseif (11<= i ) then
	tbBattleInfo.pPlayer.AddStackItem(18,1,1194,15,nil,1);
			tbBattleInfo.pPlayer.Earn(300000,0);
			tbBattleInfo.pPlayer.AddBindMoney(600000);
			tbBattleInfo.pPlayer.AddJbCoin(50000);
			tbBattleInfo.pPlayer.AddBindCoin(60000);
			tbBattleInfo.pPlayer.Msg("<color=green>Hành trang trống >=5 để nhận<color> <color=yellow>Phần Thưởng 5 vạn đồng thường<color>");
		elseif (21 <= i ) then
	tbBattleInfo.pPlayer.AddStackItem(18,1,1194,16,nil,1);
			tbBattleInfo.pPlayer.Earn(300000,0);
			tbBattleInfo.pPlayer.AddBindMoney(500000);
			tbBattleInfo.pPlayer.AddJbCoin(30000);
			tbBattleInfo.pPlayer.AddBindCoin(50000);
			tbBattleInfo.pPlayer.Msg("<color=green>Hành trang trống >=5 để nhận<color> <color=yellow>Phần Thưởng 3 vạn đồng thường<color>");
		end
	end
end
-- 战局结束时的声望按排名奖励
function Battle:AwardFinalHonor(tbPlayerList)
	local nNowHonor = 0;
	local nMaxRank		= 0;
	local nIndex		= 0;
	for i = 1, #tbPlayerList do
		local tbBattleInfo 	= tbPlayerList[i];
		local nNowHonor	= 0;
		local nRankHonor	= 0;
		local nBounsHonor	= 0;
		if (1 == i) then
			nRankHonor = Battle.tbRANKHONOR[1];
		elseif (2 <= i and 5 >= i) then
			nRankHonor = Battle.tbRANKHONOR[2];
		elseif (6 <= i and 10 >= i) then
			nRankHonor = Battle.tbRANKHONOR[3];
		elseif (11 <= i and 20 >= i) then
			nRankHonor = Battle.tbRANKHONOR[4];
		end
		
		for key, tbRankBouns in ipairs(Battle.tbBOUNSHONOR) do
			if (tbBattleInfo.nBouns >= tbRankBouns[1]) then
				nBounsHonor = tbRankBouns[2];
				break;
			end
		end
		nNowHonor = nRankHonor;
		if (nBounsHonor > nNowHonor) then
			nNowHonor = nBounsHonor;
		end
		local nCamp			= tbBattleInfo.tbCamp.nCampId;
		tbBattleInfo.nHonor = tbBattleInfo.nHonor + nNowHonor;
		tbBattleInfo.pPlayer.Msg(string.format("Xếp hạng: <color=green>%d<color>, bạn nhận được <color=white>%d<color> điểm vinh dự chiến trường.", i, tbBattleInfo.nHonor));
	end
end

-- 战局结束时的功勋按排名奖励
function Battle:AwardFinalGongXun(tbPlayerList)
--	local nNowGongXun 	= 0;
--	local nMaxRank		= 0;
--	local nIndex		= 0;
--	for i = 1, #tbPlayerList do
--		if (i > nMaxRank) then
--			nIndex = nIndex + 1;
--			if (not self.tbGONGXUNRANK[nIndex]) then
--		--		print("self.tbSHENGWANGRANK[nIndex] error (Battle:AwardFinalGongXun(tbPlayerList, tbBattleAwardSheng))");
--			end
--			nMaxRank		= self.tbGONGXUNRANK[nIndex][1];
--			nNowGongXun		= self.tbGONGXUNRANK[nIndex][2];
--		end
--		local tbBattleInfo 	= tbPlayerList[i];
--		local nGongXun 		= tbBattleInfo.nGongXun + nNowGongXun;
--		local nCamp			= tbBattleInfo.tbCamp.nCampId;
--		tbBattleInfo.pPlayer.Msg(string.format("排名为：<color=green>%d<color>，你获得了<color=white>%d<color>点战场功勋值奖励。", i, nGongXun));
--		tbBattleInfo.nGongXun = nGongXun;
--	end
end

function Battle:AwardFinalWeiWang(tbPlayerList, nBattleLevel)
	if (not tbPlayerList) then
		return;
	end
	local nFlag = 0;
	local nOpenTime = KGblTask.SCGetDbTaskInt(DBTASD_SERVER_SETMAXLEVEL99);
	if (nOpenTime <= 0) then
		nFlag = 1;
	else
		if (nBattleLevel >= 2) then
			nFlag = 1;
		end
	end
	for i, v in ipairs(tbPlayerList) do
		if (self.tbWeiWangRank[1] == i) then
			self:AwardWeiWang(v, 10, 50);	-- 冠军有6点威望
		elseif (self.tbWeiWangRank[1] < i and self.tbWeiWangRank[2] >= i) then
			self:AwardWeiWang(v, 8, 40);
		elseif (i > self.tbWeiWangRank[2] and self.tbWeiWangRank[3] >= i) then
			self:AwardWeiWang(v, 6, 30);
		else
			if (nFlag == 1) then
				local nBouns = v.nBouns;
				if (4500 <= nBouns) then
					self:AwardWeiWang(v, 5, 20, 1);
				elseif (3000 <= nBouns) then
					self:AwardWeiWang(v, 4, 20, 1);
				elseif (1800 <= nBouns) then
					self:AwardWeiWang(v, 3, 15, 1);
				elseif (1500 <= nBouns) then
					self:AwardWeiWang(v, 2, 15, 1);
				elseif (1200 <= nBouns) then
					self:AwardWeiWang(v, 2, 10, 1);
				elseif (800 <= nBouns) then
					self:AwardWeiWang(v, 1, 10, 1);
				elseif (500 <= nBouns) then
					self:AwardWeiWang(v, 0, 10, 1);
				end			
			end
		end
	end
end

function Battle:AwardFinalOffer(tbPlayerList, nBattleLevel)
	if (not tbPlayerList) then
		return;
	end 
	local nStockBaseCount = 0;
	for i, v in ipairs(tbPlayerList) do
		if (i >= 1 and i <= 3) then
			self:AwardOffer(v, 150);	-- 前3名有150的贡献度
			nStockBaseCount = 100;
		elseif (4 <= i and 10 >= i) then
			self:AwardOffer(v, 120);	-- 前10名有120的贡献度
			nStockBaseCount = 80;
		elseif (i >= 10 and 20 >= i) then
			self:AwardOffer(v, 100);	-- 前20名有100的贡献度
			nStockBaseCount = 60;
		else
			local nBouns = v.nBouns;
			if (5000 <= nBouns) then
				self:AwardOffer(v, 80); -- 5000积分以上的有80的贡献度
				nStockBaseCount = 50;
			elseif (5000 > nBouns and 4000 <= nBouns) then
				self:AwardOffer(v, 60); -- 4000积分以上的有60的贡献度
				nStockBaseCount = 30;
			elseif (4000 > nBouns and 3000 <= nBouns) then
				self:AwardOffer(v, 40);	-- 3000积分以上的有40的贡献度
				nStockBaseCount = 20;
			elseif (3000 > nBouns and 1500 <= nBouns) then
				self:AwardOffer(v, 30);	-- 1500积分以上的有30的贡献度
				nStockBaseCount = 10;
			end
		end
		if v and v.pPlayer then
			-- 增加建设资金和族长、个人的股份
			Tong:AddStockBaseCount_GS1(v.pPlayer.nId, nStockBaseCount, 0.75, 0.2, 0.05, 0, 0, WeeklyTask.GETOFFER_TYPE_BATTLE);
		end
		
		if (i > 0 and i <= 20 and nBattleLevel == 3) then
			-- 成就：高级战场前20名
			Achievement:FinishAchievement(v.pPlayer.nId, Achievement.BATTLE_GAOJI_20);
		end
	end
end

function Battle:AwardOffer(tbBattleInfo, nOffer)
	local pPlayer = tbBattleInfo.pPlayer;
	if (not pPlayer) then
		return 0;
	end
	pPlayer.AddOfferEntry(nOffer, WeeklyTask.GETOFFER_TYPE_BATTLE);
end

function Battle:AwardWeiWang(tbBattleInfo, nWeiWang, nGongXian, nFlag)
	local pPlayer = tbBattleInfo.pPlayer;
	if (not pPlayer) then
		return 0;
	end
	
	-- 加入帮会，并且帮会通过考验期 by zhangjinpin@kingsoft
	if nFlag == 1 then
		if not pPlayer.dwTongId or pPlayer.dwTongId == 0 then
			return 0;
		end
	
		local pTong = KTong.GetTong(pPlayer.dwTongId);
		if not pTong or pTong.GetTestState() ~= 0 then
			return 0;
		end
	end
	-- end

	if tbBattleInfo.tbMission and tbBattleInfo.tbMission.nBattleLevel then
		if tbBattleInfo.tbMission.nBattleLevel == 1 and TimeFrame:GetStateGS("OpenOneFengXiangBattle") == 1 then
			nWeiWang = math.floor(nWeiWang / 2);
		end
		pPlayer.AddKinReputeEntry(nWeiWang, "battle");
	end
end

function Battle:AwardFinalXinDe(tbPlayerList)
	if (not tbPlayerList) then
		return;
	end
	for i = 1, #tbPlayerList do
		if (1 == i) then
			self:AwardXinDe(tbPlayerList[i].pPlayer, 300000);	-- 冠军由6点威望
		elseif (2 <= i and 10 >= i) then
			self:AwardXinDe(tbPlayerList[i].pPlayer, 200000);
		else
			local nBouns = tbPlayerList[i].nBouns;
			if (3000 < nBouns) then
				self:AwardXinDe(tbPlayerList[i].pPlayer, 150000);
			elseif (3000 >= nBouns and 500 <= nBouns) then
				self:AwardXinDe(tbPlayerList[i].pPlayer, 100000);
			end
		end
	end	
end

function Battle:AwardXinDe(pPlayer, nXinDe)
	if (nXinDe <= 0) then
		return;
	end
	Setting:SetGlobalObj(pPlayer);
	Task:AddInsight(nXinDe);
	Setting:RestoreGlobalObj();
end

-- 奖励积分大于3000的玩家可以获得物质奖励
function Battle:AwardFinalGoods(tbPlayerList, nBattleLevel)
	if (not tbPlayerList) then
		return;
	end
	
	local nItemId = self.tbPaiItemId[nBattleLevel];
	for i = 1, #tbPlayerList do
		local nBouns	= tbPlayerList[i].nBouns;
		local pPlayer	= tbPlayerList[i].pPlayer;
		if (self.tbAWARDBOUNS[1] <= nBouns) then
			pPlayer.SetTask(self.TSKGID, self.TSK_BTPLAYER_ZHANCHANGLINGPAI, nItemId);
			pPlayer.SetTask(self.TSKGID, self.TSK_BTPLAYER_FUDAI ,2);
			Dialog:SendInfoBoardMsg(pPlayer, "Gặp Hiệu Úy Mộ Binh ở Báo danh chiến trường nhận thưởng.");
		elseif (self.tbAWARDBOUNS[2] <= nBouns) then
			pPlayer.SetTask(self.TSKGID, self.TSK_BTPLAYER_FUDAI ,1);
			Dialog:SendInfoBoardMsg(pPlayer, "Gặp Hiệu Úy Mộ Binh ở Báo danh chiến trường nhận thưởng.");
		end
		if (nBouns > 0) then
			pPlayer.SetTask(self.TSKGID, self.TSK_BTPLAYER_BOUNSFORWARD, 1);
		end
	end	
end

-- 师徒成就：战场
function Battle:GetAchievement(tbPlayerList, nBattleLevel)
	if (not tbPlayerList) then
		return;
	end
	-- nBattleLevel = 1（初级 扬州），2（中级 凤翔），3（高级 襄阳）
	for i = 1, #tbPlayerList do
		local pPlayer = tbPlayerList[i].pPlayer;
		-- 目前成就系统里面只需要添加扬州战场成就，如果以后要添加其他的，可以在这里补充
		if (pPlayer and nBattleLevel == 1) then
			Achievement:FinishAchievement(pPlayer.nId, Achievement.BATTLE_YANGZHOU);
		end
	end
end

-- 获得一个战场令牌
function Battle:AwardGood(pPlayer, nItemId, nPaiCount, nFuCount, nBouns, nBattleLevel)
	local nFreeCount, tbExecute = SpecialEvent.ExtendAward:DoCheck("Battle", pPlayer, nBouns, nBattleLevel);
	
	if (pPlayer.CountFreeBagCell() < (nPaiCount + nFuCount + nFreeCount) * Battle.nTimes ) then
		return 0;
	end
	for i = 1, Battle.nTimes do
		if (nPaiCount > 0) then
			pPlayer.AddItem(18,1,112,nItemId);
			self:WriteLog("AwardGood", string.format("Give player %s a zhanchanglingpai", pPlayer.szName));
			pPlayer.SetTask(self.TSKGID, self.TSK_BTPLAYER_ZHANCHANGLINGPAI, 0);
		end
		if (nFuCount > 0) then
			for i=1, nFuCount do
				local pItem = pPlayer.AddItem(18,1,80,1);
				assert(pItem);
				self:WriteLog("AwardGood", string.format("Give player %s a fudai", pPlayer.szName));
				--local szDate = os.date("%Y/%m/%d/%H/%M/%S", GetTime() + 3600 * 48);
				--pPlayer.SetItemTimeout(pItem, szDate);
				--pItem.Sync();
			end
			pPlayer.SetTask(self.TSKGID, self.TSK_BTPLAYER_FUDAI, 0);
		end
		if (nBouns > 0) then
			local nMyUserBouns		= self:GetMyUseBouns();
			local nFinalBouns		= nBouns;
			if (nMyUserBouns + nBouns > self.BATTLES_POINT2EXP_MAXEXP) then
				nFinalBouns = self.BATTLES_POINT2EXP_MAXEXP - nMyUserBouns;
			end
			local nExp 				= self:BounsChangeExp(pPlayer.nLevel, nFinalBouns) * self.BOUNS2EXPMUL;
			if (nExp > 0) then
				pPlayer.AddExp(nExp);
			end
			self:AddUseBouns(pPlayer, nFinalBouns, nMyUserBouns);
			pPlayer.SetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_TOTALBOUNS, 0);
		end
		SpecialEvent.ExtendAward:DoExecute(tbExecute);
	end
	return 1;
end

-- 更新每天玩家最大功勋值
function Battle:UpdatePlayerHonorAndShengWang(tbPlayerList)
	for _, tbBattleInfo in pairs(tbPlayerList) do
		tbBattleInfo:SetPlayerHonor();
		tbBattleInfo:SetPlayerShengWang();
	end
end

-- 如果玩家的身份是未出师弟子，那么他的师徒任务当中的宋金战场次数加1
function Battle:UpdateShiTuBattleCount(tbPlayerList)
	if (not tbPlayerList) then
		return;
	end
	local tbItem = Item:GetClass("teacher2student");
	for i, v in ipairs(tbPlayerList) do
		local pPlayer = v.pPlayer;
		if (pPlayer) then
			if (pPlayer.GetTrainingTeacher()) then
				local tbBattleInfo	= Battle:GetPlayerData(pPlayer);
				local nEnterBattleTime = tbBattleInfo.nEnterBattleTime;
				local nCurTime = GetTime();
				local nInBattleTime = nCurTime - nEnterBattleTime;
				if (tbItem.BATTLE_VALID_TIME <= nInBattleTime) then
					local nNeed_Battle = pPlayer.GetTask(Relation.TASK_GROUP, Relation.TASK_ID_SHITU_BATTLE) + 1;
					pPlayer.SetTask(Relation.TASK_GROUP, Relation.TASK_ID_SHITU_BATTLE, nNeed_Battle);
				end
			end
		end
	end
end

-- 计算离上次更新时间过了多少天
function Battle:CalculateDay(nLastTime, nNowTime)
	local nLastDay 	= math.ceil(nLastTime / (3600 * 24));
	local nNowDay	= math.ceil(nNowTime / (3600 * 24));
	local nDays		= nNowDay - nLastDay;
	if (nDays < 0) then
		nDays = 0;
	end
	return nDays;
end

-- 清零
function Battle:ClearBouns(pPlayer)
	self:SetTotalBouns(pPlayer, 0);
end

-- 个人玩家奖励
function Battle:AwardPlayerList(tbPlayerReaultList, nBattleLevel)
	self:AwardFinalHonor(tbPlayerReaultList);
	self:AwardJbCoin(tbPlayerReaultList);
	self:AwardFinalShengWang(tbPlayerReaultList);
	self:UpdatePlayerHonorAndShengWang(tbPlayerReaultList);
	self:UpdateShiTuBattleCount(tbPlayerReaultList);
	self:AwardFinalWeiWang(tbPlayerReaultList, nBattleLevel);
	self:AwardFinalOffer(tbPlayerReaultList, nBattleLevel);
	self:AwardFinalXinDe(tbPlayerReaultList);
	self:AwardFinalGoods(tbPlayerReaultList, nBattleLevel);
	self:GetAchievement(tbPlayerReaultList, nBattleLevel);
end

function Battle:_BTPrint(tbPlayerReaultList)
	print("szName, nBouns, nGongXun, nShengWang");
	for _, tbBattleInfo in ipairs(tbPlayerReaultList) do
		print(tbBattleInfo.pPlayer.szName, tbBattleInfo.nBouns, tbBattleInfo.nGongXun, tbBattleInfo.nShengWang);
	end
end

-- 累加积分--TODO
function Battle:AddUseBouns(pPlayer, nChangeBouns, nMyUserBouns)
	if (0 == nChangeBouns) then
		return;
	end
	pPlayer.SetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_USEBOUNS, nChangeBouns + nMyUserBouns);
end

-- 获得已用积分记录--TODO
function Battle:GetMyUseBouns()
	local nMyBouns = me.GetTask(Battle.TSKGID, Battle.TSK_BTPLAYER_USEBOUNS);
	return nMyBouns;
end

function Battle:AddShareBouns(tbBattleInfo, nBouns)
	local tbShareTeamMember = tbBattleInfo.pPlayer.GetTeamMemberList(1);
	if (not tbShareTeamMember) then
		return tbBattleInfo:AddBounsWithCamp(nBouns);
	end
	
	local nResult	= 0;	
	local nCount	= #tbShareTeamMember;
	if (0 < nCount) then
		local nTimes	= self.tbPOINT_TIMES_SHARETEAM[nCount];
		local nPoints	= nBouns * nTimes;
		nResult			= tbBattleInfo:AddBounsWithCamp(nPoints);
	end

-- 组队共享暂时不用
--	for _, pPlayer in pairs(tbShareTeamMember) do
--		if (pPlayer.nId ~= tbBattleInfo.pPlayer.nId) then
--			local nFaction, nRoutId = self:GetFactionNumber(pPlayer);
--			if (0 ~= nFaction) then
--				local nTimes	= self.tbPOINT_TIMES_SHAREFACTION[nFaction][nRoutId];
--				local nPoints	= nBouns * nTimes;
--				self:GetPlayerData(pPlayer):AddBounsWithCamp(nPoints);
--			end
--		end
--	end
	return nResult;
end

function Battle:GetFactionNumber(pPlayer)
	local nFaction 	= pPlayer.nFaction;
	if (0 == nFaction) then
		Battle:DbgOut("GetFactionNumber", pPlayer.szName, "Chưa gia nhập môn phái!");
		return 0;
	end
	local nRouteId	= pPlayer.nRouteId;
	if (0 == nRouteId) then
		Battle:DbgOut("GetFactionNumber", pPlayer.szName, "Chưa chọn nhánh, không thể nhận Mật tịch môn phái!");
		return 0;
	end
	return nFaction, nRouteId;
end

function Battle:OnWeekEvent_ResetBattleHonor()
	-- TODO 排名
	local pPlayer = me;
	for i = self.TSK_BTPLAYER_HONOR1, self.TSK_BTPLAYER_HONOR4, 1 do
		pPlayer.SetTask(self.TSKGID, i, 0);
	end
end

function Battle:GetRemainJunXu()
	local nRemainJunXu = me.GetTask(self.TSKGID, self.TSK_BTPLAYER_JUNXU);
	return nRemainJunXu;
end


PlayerSchemeEvent:RegisterGlobalWeekEvent({Battle.OnWeekEvent_ResetUseBouns, Battle});
PlayerSchemeEvent:RegisterGlobalWeekEvent({Battle.OnWeekEvent_ResetBattleHonor, Battle});
