-------------------------------------------------------
-- 文件名　：baibaoxiang.lua
-- 创建者　：zhangjinpin@kingsoft
-- 创建时间：2009-04-06 20:46:39
-- 文件描述：
-------------------------------------------------------

Require("\\script\\baibaoxiang\\baibaoxiang_def.lua");

-- on-off switch
function Baibaoxiang:CheckState()
	return self.bOpen;
end

function Baibaoxiang:_SetState(bOpen)
	self.bOpen = bOpen;
end

-- init
function Baibaoxiang:Init()
	
	if self:CheckState() ~= 1 then
		return;
	end
	
	-- read rate
	local tbMap1 = Lib:LoadTabFile(self.RATE_START_PATH);
	local tbMap2 = Lib:LoadTabFile(self.RATE_NORMAL_PATH);
	
	if not tbMap1 or not tbMap2 then
		return;
	end
	
	-- save
	self.tbRateStart = tbMap1;
	self.tbRateNormal = tbMap2;
end

-- 32 bits(0-31)：[ type:3(1-5) | level:2(1-3) ]，last 2 bits save random(3)

-- save one round result
function Baibaoxiang:SetRoundResult(pPlayer, nRound, nType, nLevel, nRandGrid)
	
	if nRound < 1 or nRound > 6 then
		return;
	end
	
	-- task
	local nTask = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_RESULT);
	
	-- offset
	local nIndex = (nRound - 1) * 5;
		
	nTask = Lib:SetBits(nTask, nType, nIndex, nIndex + 2);
	nTask = Lib:SetBits(nTask, nLevel, nIndex + 3, nIndex + 4); 
	nTask = Lib:SetBits(nTask, nRandGrid, 30, 31); 

	-- save new task
	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_RESULT, nTask);
end

-- get first result
function Baibaoxiang:GetStartResult(pPlayer)

	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;

	-- random
	nRand = MathRandom(1, 10000);

	-- get field
	for i = 1, #self.tbRateStart do
		nAdd = nAdd + self.tbRateStart[i].Rate;
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
	
	-- find nil return
	if nIndex == 0 then
		return 0;
	end
	
	-- num type
	local nType = self.tbAwardConType[self.tbRateStart[nIndex].Type];
	
	-- num level
	local nLevel = tonumber(self.tbRateStart[nIndex].Level);
	
	-- save to current task
	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_TYPE, nType);
	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_LEVEL, nLevel);
	
	-- result
	return 1, nType, nLevel;
end

-- get advanced result
function Baibaoxiang:GetNormalResult(pPlayer, nTimes)
	
	-- get total
	local nLevel = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_LEVEL);
	local nType = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_TYPE);
	
	-- no level or type box
	if nLevel <= 0 or nType == 5 then
		return 0;
	end

	local i = 0;
	local nAdd = 0;
	local nRand = 0;
	local nIndex = 0;
	
	-- random
	nRand = MathRandom(1, 10000);
	
	-- no match level
	if not self.tbRateNormal[nLevel] then
		return 0;
	end 
	
	-- fill 3 rate
	local tbRate = {
		self.tbRateNormal[nLevel].Level_1_Rate,
		self.tbRateNormal[nLevel].Level_2_Rate,
		self.tbRateNormal[nLevel].Level_3_Rate,
	};
	
	-- cac multiple
	local nAwardNum = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_COIN) / 2;
	
	-- add rate
	--if nLevel == 4 then
	--	tbRate[3] = tbRate[3] * nAwardNum;
	--elseif nLevel == 5 then
	--	tbRate[2] = tbRate[2] * nAwardNum;
	--	tbRate[3] = tbRate[3] * nAwardNum;
	--end
	
	-- get index
	for i = 1, 3 do
		nAdd = nAdd + tbRate[i];
		if nAdd >= nRand then
			nIndex = i;
			break;
		end
	end
	
	-- have match index
	if nIndex > 0 then
		
		-- cac total level
		local nTotalLevel = nLevel + nIndex;

		-- switch overflow
		if nTotalLevel > self.MAX_LEVEL then
			
			-- set max level 6
			pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_LEVEL, self.MAX_LEVEL);
			
			-- set overflow flag
			pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_OVERFLOW, 1);
		
		else
			-- set current total level
			pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_LEVEL, nTotalLevel);	
		end
	
		return 1, nType, nIndex;
		
	-- not found
	else
		-- so build a new map
		local tbRandMap = {};
		
		for i = 1, 4 do
			
			-- checkout now type
			if nType ~= i then
				table.insert(tbRandMap, {i, 1});
				table.insert(tbRandMap, {i, 1});
				table.insert(tbRandMap, {i, 1});
				table.insert(tbRandMap, {i, 2});
				table.insert(tbRandMap, {i, 3});
			end
		end
		
		-- run a real random
		local nRandom = MathRandom(1, #tbRandMap);
		
		-- load type & level
		local nRandType = tbRandMap[nRandom][1];
		local nRandLevel = tbRandMap[nRandom][2]; 
		
		-- clear total type & level
		pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_TYPE, 0);
		pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_LEVEL, 0);
		
		return 2, nRandType, nRandLevel;
	end
end

-- check client get result
function Baibaoxiang:CheckAllowGetResult(pPlayer, nCoin)
	
	if self:CheckState() ~= 1 then
		return 0;
	end
	
	local nInterval = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_INTERVAL);
	
	if GetTime() - nInterval < 3 then
		return 0;
	end
	
	-- cac multiple
	local nAwardNum = nCoin / 2;
	
	-- only 3 type
	if nAwardNum ~= 1 and nAwardNum ~= 5 and nAwardNum ~= 25 then	
		return 0;
	end
	
	-- check overflow
	local bOverflow = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_OVERFLOW);
	
	if bOverflow == 1 then
		return 0;
	end

	-- check times
	local nTimes = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_TIMES);
	local bContinue = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_CONTINUE);	
	
	if nTimes > 0 and bContinue == 0 then
		return 0;
	end
	
	-- check coin. the last step 
	local nTaskCoin = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_COIN);
	
	if nTaskCoin <= 0 then

		-- find coin in bags
		local nFind = pPlayer.GetItemCountInBags(18, 1, 325, 1);
	
		-- check num
		if nFind < nCoin then	
			return 0;
		end
		
		-- consume item
		-- todo: return
		local bRet = pPlayer.ConsumeItemInBags(tonumber(nCoin), 18, 1, 325, 1);
		
		-- log
		self:_Log(pPlayer, "Nhan so: "..nCoin);
	
		-- set coin
		pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_COIN, nCoin);
		
		-- call gc deal
		GCExcute({"Baibaoxiang:AddCoin_GC", pPlayer.nId, tonumber(nCoin) * 2});	
	end
	
	-- can get result
	return 1;
end

-- client to server event
function Baibaoxiang:GetResult(pPlayer, nCoin)
	
	-- options
	local bOK = self:CheckAllowGetResult(pPlayer, nCoin);
	
	if bOK ~= 1 then
		pPlayer.Msg("Hi?n gi? kh?ng th? s? d?ng Bách B?o R??ng.");
		return;
	end
	
	-- interval
	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_INTERVAL, GetTime());
	
	-- overflow flag
	local bOverflow = 0;
	
	-- result table
	local tbResult = {};
	
	-- get play times
	local nTimes = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_TIMES);	
	
	-- first time
	if nTimes <= 0 then
		
		-- get first result
		local bOK, nType, nLevel = self:GetStartResult(pPlayer);
		
		-- failed(error condition, need log)
		if bOK ~= 1 then
			self:_Reset(pPlayer);
			return;
		end
			
		local nRandGrid = 0;
		
		-- box 1/2
		if nType == 5 then
			nRandGrid = MathRandom(1, 2);
		-- level 1/3
		elseif nLevel == 1 then
			nRandGrid = MathRandom(1, 3);
		end
		
		-- save one time award
		self:SetRoundResult(pPlayer, 1, nType, nLevel, nRandGrid);
	
		-- save times
		pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_TIMES, 1);
		
		-- box type over
		if nType == 5 then
			pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_CONTINUE, 0);
		else
			pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_CONTINUE, 1);
		end
		
		-- to client
		tbResult.Type = nType;
		tbResult.Level = nLevel;
		tbResult.Times = 1;
		tbResult.Grid = nRandGrid;
		
	-- times(n)
	else
		
		-- cac current time
		local nCurrTimes = nTimes + 1;

		-- get result
		local bOK, nType, nLevel = self:GetNormalResult(pPlayer);
		
		-- failed(error condition, need log)
		if bOK <= 0 then
			self:_Reset(pPlayer);
			return;
		end
		
		local nRandGrid = 0;
		
		-- box 1/2
		if nType == 5 then
			nRandGrid = MathRandom(1, 2);
		-- level 1/3
		elseif nLevel == 1 then
			nRandGrid = MathRandom(1, 3);
		end
		
		-- save one time award
		self:SetRoundResult(pPlayer, nCurrTimes, nType, nLevel, nRandGrid);
			
		-- same type
		if bOK == 1 then
			
			local nTotalLevel = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_LEVEL);
			
			if nTotalLevel == 6 then
				pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_CONTINUE, 0);
			else	
				-- can continue		
				pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_CONTINUE, 1);
			end
			
			-- save times
			pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_TIMES, nCurrTimes);
					
		-- different type
		elseif bOK == 2 then
			
			-- direct reset
			self:_Reset(pPlayer);
		end
		
		-- to client
		tbResult.Type = nType;
		tbResult.Level = nLevel;
		tbResult.Times = nCurrTimes;
		tbResult.Grid = nRandGrid;
	end
	
	-- call client script
	pPlayer.CallClientScript({"Ui:ServerCall", "UI_BAIBAOXIANG", "OnRecvResult", tbResult});
end

-- check get award
function Baibaoxiang:CheckAllowGetAward(pPlayer, nType)

	if self:CheckState() ~= 1 then
		return 0;
	end
	
	local nInterval = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_INTERVAL);
	
	if GetTime() - nInterval < 3 then
		return 0;
	end
	
	-- cac multiple
	local nAwardNum = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_COIN) / 2;
	
	-- check level
	local nAwardLevel = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_LEVEL);
	
	if nAwardLevel <= 0 then
		return 0;
	end
		
	-- check type
	local nAwardType = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_TYPE);
	
	if not self.tbAwardType[nAwardType] then
		return 0;
	end
		
	-- check overflow space
	local nSpaceGC = 0;
	local bOverflow = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_OVERFLOW);	
	
	if bOverflow == 1 then
		local nCaichi = KGblTask.SCGetDbTaskInt(DBTASK_BAIBAOXIANG_CAICHI) / 100;
		
		nSpaceGC = math.floor(nCaichi / 2000) + 1;
		
		-- max 20 space
		if nSpaceGC > 20 then
			nSpaceGC = 20;
		end
	end
	
	-- check space
	if nType == 1 then
	
		-- get award index
		local szAwardType = self.tbAwardType[nAwardType];
		local nAward = self.tbAwardValue[szAwardType][nAwardLevel];
	
		-- xuanjing or box
		if nAwardType == 1 or nAwardType == 5 then
			if pPlayer.CountFreeBagCell() < nAwardNum + nSpaceGC then
				Dialog:SendBlackBoardMsg(pPlayer, "Hanh trang khong du cho trong. Hay sap xep va thu lai");
				return 0;
			end
			
		-- money
		elseif nAwardType == 3 then
			if nAward * nAwardNum + pPlayer.nCashMoney > pPlayer.GetMaxCarryMoney() then
				Dialog:SendBlackBoardMsg(pPlayer, "So tien tren nguoi vuot qua gioi han. Hay gui tien va thu lai");
				return 0;
			end
		end
		
		-- extra check
		if pPlayer.CountFreeBagCell() < nSpaceGC then
			Dialog:SendBlackBoardMsg(pPlayer, "Hanh trang khong du cho trong. Hay sap xep va thu lai");
			return 0;
		end
		
	-- coin
	elseif nType == 2 then
		
		-- box type
		if nAwardType == 5 then 
			return 0;
		end
		
		local nAward = self.tbAwardValue["贝壳"][nAwardLevel];
		local nSpace = math.floor(nAward * nAwardNum / 1000) + 1;

		if pPlayer.CountFreeBagCell() < nSpace + nSpaceGC then
			local szMsg = string.format("Hanh trang khong du cho trong. Can  %s o trong moi nhan thuong duoc", nSpace + nSpaceGC);
			Dialog:SendBlackBoardMsg(pPlayer, szMsg);
			return 0
		end
		
	-- unknwon type
	else
		return 0;
	end
	
	-- can get award
	return 1;
end

-- client to server event
function Baibaoxiang:GetAward(pPlayer, nType)
	
	-- check allow
	local bOK = self:CheckAllowGetAward(pPlayer, nType);
	
	if bOK ~= 1 then
		return;
	end
	
	-- interval
	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_INTERVAL, GetTime());
	
	-- get multiple
	local nAwardNum = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_COIN) / 2;
	
	-- get level & type
	local nAwardLevel = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_LEVEL);
	local nAwardType = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_TYPE);
	
	-- get award
	if nType == 1 then
		
		-- get award index
		local szAwardType = self.tbAwardType[nAwardType];
		local nAward = self.tbAwardValue[szAwardType][nAwardLevel];
	
		-- xuanjing
		if nAwardType == 1 then
			local i = 0;
			for i = 1, nAwardNum do
				pPlayer.AddItem(18, 1, 1, nAward);
			end
			
			-- channel
			if nAwardLevel >= 4 then
				pPlayer.SendMsgToFriend("Hao huu cua ban [<color=yellow>"..pPlayer.szName.."<color>] nhan tu Bac Bao Ruong <color=yellow>"
					..nAwardNum.."<color> Huyen Tinh "..nAward.."");
				Player:SendMsgToKinOrTong(pPlayer, " Nhan tu Bac Bao Ruong "..nAwardNum.." Huyen Tinh "..nAward..".", 0);
			end
			
			-- log
			self:_Log(pPlayer, "Nhan duoc" .. nAward .. "Huyen Tinh" .. nAwardNum .. " 1 ");
			
		-- jinghuo
		elseif nAwardType == 2 then
			pPlayer.ChangeCurMakePoint(nAward * nAwardNum);
			pPlayer.ChangeCurGatherPoint(nAward * nAwardNum);
			
			-- channel
			if nAwardLevel >= 4 then
				pPlayer.SendMsgToFriend("Hao huu cua ban [<color=yellow>"..pPlayer.szName.."<color>] nhan tu Bac Bao Ruong <color=yellow>"
					..(nAward * nAwardNum).."<color> Tinh Hoat luc");
				Player:SendMsgToKinOrTong(pPlayer, " Nhan tu Bac Bao Ruong "..(nAward * nAwardNum).." Tinh Hoat luc", 0);
			end
			
			-- need channel msg 
			pPlayer.Msg(string.format("Ban nhan duoc <color=yellow>%s<color> Tinh luc", nAward * nAwardNum));
			pPlayer.Msg(string.format("Ban nhan duoc <color=yellow>%s<color> Hoat luc", nAward * nAwardNum));
			
			-- log
			self:_Log(pPlayer, "Nhan duoc" .. (nAward * nAwardNum) .. "tinh ho?t l?c");
			
		-- money
		elseif nAwardType == 3 then
			pPlayer.Earn(nAward * nAwardNum, Player.emKEARN_BAIBAOXIANG_MONEY);
			
			-- channel
			if nAwardLevel >= 4 then
				pPlayer.SendMsgToFriend("Hao huu cua ban [<color=yellow>"..pPlayer.szName.."<color>] nhan tu Bac Bao Ruong <color=yellow>"
					..(nAward * nAwardNum).."<color> Luong bac!");
				Player:SendMsgToKinOrTong(pPlayer, " Nhan tu Bac Bao Ruong "..(nAward * nAwardNum).." Luong bac!", 0);
			end	
			
			-- log
			self:_Log(pPlayer, "Nhan duoc" .. (nAward * nAwardNum) .. "Luong bac");
			
		-- bind money
		elseif nAwardType == 4 then
			pPlayer.AddBindCoin(nAward * nAwardNum, Player.emKBINDCOIN_ADD_BAIBAOXIANG);
			
			-- channel
			if nAwardLevel >= 4 then
				pPlayer.SendMsgToFriend("Hao huu cua ban [<color=yellow>"..pPlayer.szName.."<color>] nhan tu Bac Bao Ruong <color=yellow>"
					..(nAward * nAwardNum)..string.format("<color> %s", IVER_g_szCoinName));
				Player:SendMsgToKinOrTong(pPlayer, " Nhan tu Bac Bao Ruong "..(nAward * nAwardNum)..string.format(" %s", IVER_g_szCoinName), 0);
			end	
			
			-- log
			self:_Log(pPlayer, "Nhan duoc" .. (nAward * nAwardNum) .. "Dong Khoa");
			
		-- box
		elseif nAwardType == 5 then
			local i = 0;
			for i = 1, nAwardNum do
				pPlayer.AddItem(18, 1, 324, 1);
			end
			pPlayer.SendMsgToFriend("Hao huu cua ban <color=yellow>"..pPlayer.szName.."<color> Nhan thuong tu Bach Bao Ruong <color=yellow>"
				..(nAward * nAwardNum).."<color> Ruong");
			Player:SendMsgToKinOrTong(pPlayer, " Nhan thuong tu Bach Bao Ruong "..(nAward * nAwardNum).." Ruong", 0);
			KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Hao huu cua ban <color=green>"..pPlayer.szName.."<color> Nhan thuong tu Bach Bao Ruong <color=red>"
				..(nAward * nAwardNum).."<color> Ruong");
	KDialog.MsgToGlobal("Hao huu cua ban <color=green>"..pPlayer.szName.."<color> Nhan thuong tu Bach Bao Ruong <color=yellow>"
				..(nAward * nAwardNum).."<color> Ruong");
					
			-- log
			self:_Log(pPlayer, "Nhan thuong" .. (nAward * nAwardNum) .. "Ruong");
		end
		
		local bOverflow = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_OVERFLOW);	
		
		-- check overflow
		if bOverflow == 1 then
				
			-- lock player
			pPlayer.AddWaitGetItemNum(1);
			
			-- call gc deal
			GCExcute({"Baibaoxiang:GetCoin_GC", pPlayer.nId});	
		end
	
	-- get coin
	elseif nType == 2 then
		
		-- box type forbidden
		if nAwardType == 5 then
			return;
		end
		
		-- num
		local nAward = self.tbAwardValue["贝壳"][nAwardLevel];
	
		-- give coin
		pPlayer.AddStackItem(18, 1, 325, 1, nil, nAward * nAwardNum);
		
		if nAwardLevel >= 4 then
			pPlayer.SendMsgToFriend("Hao huu cua ban [<color=yellow>"..pPlayer.szName.."<color>] Nhan thuong tu Bach Bao Ruong <color=yellow>"
				..(nAward * nAwardNum).."<color> Vo So Vang!");
			Player:SendMsgToKinOrTong(pPlayer, " Nhan thuong tu Bach Bao Ruong "..(nAward * nAwardNum).." Vo so vang !", 0);
		end
				
		-- log
		self:_Log(pPlayer, "Nhan duoc" .. (nAward * nAwardNum) .. "Vo So Vang");		
			
		local bOverflow = pPlayer.GetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_OVERFLOW);	
		
		-- check overflow
		if bOverflow == 1 then
				
			-- lock player
			pPlayer.AddWaitGetItemNum(1);
			
			-- call gc deal
			GCExcute({"Baibaoxiang:GetCoin_GC", pPlayer.nId});	
		end
	
	-- unknwon type
	else
		return;
	end
	
	-- call client
	pPlayer.CallClientScript({"Ui:ServerCall", "UI_BAIBAOXIANG", "OnReset"});
	
	-- reset
	self:_Reset(pPlayer);
end

-- gc callback
function Baibaoxiang:GetCoin_GS(nPlayerID, nCoin)
	
	-- get obj by player id
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerID);
	
	-- offline?
	if not pPlayer then
		return;
	end
	
	-- stack item
	pPlayer.AddStackItem(18, 1, 325, 1, nil, nCoin);
	
	-- unlock
	pPlayer.AddWaitGetItemNum(-1);
	
	-- channel
	local szMsg = string.format("Nguoi choi <color=green>%s<color> nhan thuong tu Bach Bao Ruong %s vo so vang ! That may man.", pPlayer.szName, nCoin);
	KDialog.NewsMsg(1, Env.NEWSMSG_NORMAL, szMsg);
	
	pPlayer.SendMsgToFriend("hao huu cua ban [<color=green>"..pPlayer.szName.."<color>] Nhan thuong tu Bach Bao Ruong <color=yellow>"
		..nCoin.."<color> vo so vang");
		
	Player:SendMsgToKinOrTong(pPlayer, " Nhan thuong tu Bach Bao Ruong "..nCoin.." vo so vang", 0);
	
	-- add news to help
	self:UpdateHelpTable(pPlayer, nCoin);
	
	-- log
	local nLeft = math.floor(KGblTask.SCGetDbTaskInt(DBTASK_BAIBAOXIANG_CAICHI) / 100);
	local szLog = "Nhan duoc tu Bach Bao Ruong" .. nCoin .. "Vo So vang, Vo So Vang con lai:" .. nLeft;
	self:_Log(pPlayer, szLog);
end

-- c2s function
function Baibaoxiang:OnPlayerGetAward(nType)
	self:GetAward(me, nType);
end

function Baibaoxiang:OnPlayerGetResult(nCoin)
	self:GetResult(me, nCoin)
end

-- reset
function Baibaoxiang:_Reset(pPlayer)
	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_LEVEL, 0);
	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_TIMES, 0);
	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_TYPE, 0);
	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_COIN, 0);
	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_RESULT, 0);
	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_CONTINUE, 0);
	pPlayer.SetTask(self.TASK_GROUP_ID, self.TASK_BAIBAOXIANG_OVERFLOW, 0);
end

-- log
function Baibaoxiang:_Log(pPlayer, szLog)

	-- log
	Dbg:WriteLog("Baibaoxiang", "Bach Bao Ruong", pPlayer.szAccount, pPlayer.szName, szLog);
			
	-- service log
	pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "Su dung Bach Bao Ruong" .. szLog);	
end

-- help table
function Baibaoxiang:UpdateHelpTable(pPlayer, nCoin)

	-- time
	local nAddTime = GetTime();
	local nEndTime = nAddTime + 60 * 60 * 24 * 30;
	
	local i = 0;
	local szMsg = "";
	local tbMap = {};
	local nCount = 0;
	
	-- fill text
	local szDate = os.date("%H:%M:%S Ngày: %d Tháng: %m N?m: %Y ", GetTime());
	local szTxt = "<color=cyan>" .. szDate .. "\n" .."<color=yellow>" .. pPlayer.szName 
		.. " <color=green>Nhan duoc tu Bach Bao Ruong: " .. "<color=yellow> " .. nCoin 
		.. " <color=green>" .. " Vo So Vang!<color>";
	
	-- get help
	local tbHelp = Task.tbHelp.tbNewsList[21];
	
	-- nil then clear count
	if not tbHelp then
		nCount = 0;
	else
		-- get msg key
		local szHelp = Task.tbHelp.tbNewsList[21].szMsg;
		
		-- no msg or ""
		if not szHelp or #szHelp < 1 then
			nCount = 0;
		else
			-- split to table
			tbMap = Lib:SplitStr(szHelp, "\n\n");
			nCount = #tbMap;
		end
	end
    
    -- max 10 no hole
	if nCount == 10 then
		
		-- roll up 
		for i = 1, 8 do 
			tbMap[i] = tbMap[i + 1];
			local nStart, nEnd = string.find(tbMap[i], ". ");
			tbMap[i] = string.sub(tbMap[i], 1, nStart - 2) .. i .. ". " .. string.sub(tbMap[i], nEnd + 1);
		end
		
		-- 9 special for 2 pos
		tbMap[9] = tbMap[10];
		local nStart, nEnd = string.find(tbMap[9], ". ");
		tbMap[9] = string.sub(tbMap[9], 1, nStart - 3) .. "9. " .. string.sub(tbMap[9], nEnd + 1);
		
		-- 10 final
		tbMap[10] = "<color=pink>10. " .. szTxt;
	else
		-- add to last
		tbMap[nCount + 1] = "<color=pink>" .. (nCount + 1).. ". " .. szTxt;
	end

	-- contract to msg
	for i = 1, #tbMap - 1 do
	   szMsg = szMsg .. tbMap[i] .. "\n\n";
	end             
	
	-- last cut "\n\n"
	szMsg = szMsg .. tbMap[#tbMap];
	
	-- call addnews
	Task.tbHelp:AddDNews(Task.tbHelp.NEWSKEYID.NEWS_BAIBAOXIANG, "Bach Bao Ruong", szMsg, nEndTime, nAddTime);
end

-- only for test
function Baibaoxiang:ClearHelpTable()
	
	local nAddTime = GetTime();
	local nEndTime = nAddTime + 60 * 60 * 24 * 30;
	
	Task.tbHelp:AddDNews(Task.tbHelp.NEWSKEYID.NEWS_BAIBAOXIANG, "Bach Bao Ruong", "", nEndTime, nAddTime);
end

function Baibaoxiang:OnChangeBack(nType, tbItem)
	
	local tbType = 
	{
		[1] = {18, 1, 325, 1},
		[2] = {22, 1, 61, 1},
		[3] = {18, 1, 337, 1},
	};
	
	if not tbType[nType] then
		return 0;
	end
	
	local nExCount = 0;
	for _, tbItem in pairs(tbItem) do
		local pItem = tbItem[1];
		local szKey = string.format("%s,%s,%s,%s", pItem.nGenre, pItem.nDetail, pItem.nParticular, pItem.nLevel)
		
		if szKey == string.format("%s,%s,%s,%s", unpack(tbType[nType])) then
			nExCount = nExCount + pItem.nCount;
		end
	end
	
	if nExCount <= 0 then
		Dialog:Say("Xin vui long chon chinh xac");
		return 0;
	end
	
	local nExTempCount = 0;
	for _, tbItem in pairs(tbItem) do
		local pItem = tbItem[1];
		local szKey = string.format("%s,%s,%s,%s", pItem.nGenre, pItem.nDetail, pItem.nParticular, pItem.nLevel)
		if szKey == string.format("%s,%s,%s,%s", unpack(tbType[nType])) then
			me.DelItem(pItem);
			nExTempCount = nExTempCount + pItem.nCount;
		end
		if nExTempCount >= nExCount then
			break;
		end
	end
	
	if nType == 1 then
		
		me.AddStackItem(18, 1, 205, 1, nil, nExCount * 2);
		
		me.ChangeCurMakePoint(nExCount * 225); 	-- jingli
		me.Msg(string.format("Nhan duoc <color=yellow>%s<color> Tinh Luc", nExCount * 225));
		
		me.ChangeCurGatherPoint(nExCount * 200); 	-- huoli		
		me.Msg(string.format("Nhan duoc <color=yellow>%s<color> Hoat Luc", nExCount * 200));
		
	elseif nType == 2 then
		me.AddStackItem(18, 1, 205, 1, nil, nExCount);
		me.ChangeCurGatherPoint(nExCount * 100); 	-- huoli
		me.Msg(string.format("Nhan duoc <color=yellow>%s<color> Hoat Luc", nExCount * 100));
	
	elseif nType == 3 then
		me.AddStackItem(18, 1, 205, 1, nil, nExCount * 200);
		me.ChangeCurGatherPoint(nExCount * 20000); 	-- huoli
		me.Msg(string.format("Nhan duoc <color=yellow>%s<color> Hoat Luc", nExCount * 20000));
	end
end

if (not MODULE_GAMESERVER) then
	return 0;
end

-- call init
Baibaoxiang:Init();
