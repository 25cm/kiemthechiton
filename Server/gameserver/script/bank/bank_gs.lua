-- Œƒº˛√˚°°£∫bank.lua
-- ¥¥Ω®’ﬂ°°£∫furuilei
-- ¥¥Ω® ±º‰£∫2008-11-24 14:57:51

if MODULE_GAMECLIENT then
	return;
end

Bank.tbc2sFun = {};

if (GLOBAL_AGENT) then
	Bank.nBankState = 0;
else
	Bank.nBankState = 1;
end;


function Bank:SetBankState(nState)
	self.nBankState = nState;
end

-- ¥Ê»ÎΩ±“
function Bank:GoldSave(nValue)
	if (not nValue or 0 == Lib:IsInteger(nValue)) then
		return;
	end
	if (not nValue or nValue <= 0 or nValue > me.nCoin) then
		local szMsg = "B·∫°n kh√¥ng mang theo ƒë·ªß b·∫°c, kh√¥ng th·ªÉ th·ª±c hi·ªán thao t√°c v·ª´a ch·ªçn.";
		me.Msg(szMsg);
		return;
	end
	local nMoneyOld = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_SUM);
--	me.Msg("µ±«∞£®¥Ê»ÎΩ±“«∞£©«Æ◊Øƒ⁄Ω±“ ˝¡øŒ™£∫"..nMoneyOld.."∏ˆ°£");
	local bRet = me.RestoreCoin(nValue);
	if (bRet == 0) then
		me.Msg("B√¢y gi·ªù c√°c tr√≤ ch∆°i ƒëang ch·∫°y t·ª´ t·ª´, t√¥i s·∫Ω ƒëi m·ªôt l·∫ßn n·ªØa ƒë·ªÉ ti·∫øt ki·ªám ti·ªÅn.");
	else
		if (nMoneyOld == 0) then
			me.CallClientScript({"Bank:UpdateInfo", nValue});
		end;
	end
end
Bank.tbc2sFun["GoldSave"] = Bank.GoldSave;

-- ¥”«Æ◊Ø»°≥ˆΩ±“
function Bank:GoldDraw(nGoldDrawCount)
	if (not nGoldDrawCount or 0 == Lib:IsInteger(nGoldDrawCount)) then
		return;
	end
	local nGoldSum = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_SUM);
	if (not nGoldDrawCount or nGoldDrawCount <= 0 or nGoldDrawCount > nGoldSum) then
		local szMsg = "S·ªë ti·ªÅn b·∫°n v·ª´a nh·∫≠p kh√¥ng ƒë√∫ng, xin vui l√≤ng nh·∫≠p l·∫°i.";
		me.Msg(szMsg);
		return;
	end
	
	local nGoldLimit = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_LIMIT);
	local nHaveDraw = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_TODAYTAKEOUTGOLDCOUNT);
	local nDate = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_TAKEOUTGOLD_DATE);
	local nTime = GetTime();
	
	if (nTime - nDate >= self.DAYSECOND) then
		if (nGoldDrawCount > nGoldLimit)then
			me.Msg("B·∫°n mu·ªën lo·∫°i b·ªè v√†ng qu√° m·ª©c gi·ªõi h·∫°n.");
			return;
		end
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_TAKEOUTGOLD_DATE, nTime);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_TODAYTAKEOUTGOLDCOUNT, nGoldDrawCount);
	else
		if ((nGoldDrawCount + nHaveDraw) > nGoldLimit) then
			local nCanDrawCount = nGoldLimit - nHaveDraw;
			if (nCanDrawCount < 0) then
				nCanDrawCount = 0;
			end
			local szMsg = "B·∫°n lo·∫°i b·ªè trong v√≤ng 24 gi·ªù v√†ng v∆∞·ª£t qu√° gi·ªõi h·∫°n, b·∫°n c√≥ th·ªÉ ƒë∆∞a ra l√™n t·ªõi<color=yellow>" .. nCanDrawCount .. "<color>Ω±“°£";
			me.Msg(szMsg);
			return;
		end
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_TODAYTAKEOUTGOLDCOUNT, nGoldDrawCount + nHaveDraw);
	end
	local bRet = me.TakeOutCoin(nGoldDrawCount);
	if (bRet == 0) then
		me.Msg("Game ƒëang b·ªã ch·∫°y ch·∫≠m, h√£y nh·∫≠n l·∫°i ti·ªÅn c·ªßa b·∫°n");
	end
end
Bank.tbc2sFun["GoldDraw"] = Bank.GoldDraw;

-- »°œ˚Œ¥…˙–ßµƒΩ±“÷ß»°…œœﬁ
function Bank:CancelGoldLimit()
	me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_EFFICIENT_DAY, 0);
	me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_UNEFFICIENT_LIMIT, 0);
	me.Msg("B·∫°n ƒë√£ h·ªßy b·ªè r√∫t ti·ªÅn");	
	me.CallClientScript({"Bank:UpdateInfo"});
end
Bank.tbc2sFun["CancelGoldLimit"] = Bank.CancelGoldLimit;

-- –ﬁ∏ƒΩ±“÷ß»°…œœﬁ
function Bank:ModifyGoldLimit(nNewGoldLimit)
	if (not nNewGoldLimit or 0 == Lib:IsInteger(nNewGoldLimit)) then
		return;
	end
	if (not nNewGoldLimit or nNewGoldLimit <= 0 or nNewGoldLimit > Bank.MAX_COIN) then
		me.Msg("S·ªë b·∫°n nh·∫≠p v√†o kh√¥ng ƒë√∫ng, xin vui l√≤ng nh·∫≠p l·∫°i.");
		return;
	end
	
	local nOldGoldLimit = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_LIMIT);
	local szMsg = "";
	local nTime = GetTime();
	
	if nNewGoldLimit <= nOldGoldLimit then
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_LIMIT, nNewGoldLimit);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_UNEFFICIENT_LIMIT, 0);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_EFFICIENT_DAY, 0);
		szMsg = "S·ªë v√†ng m·ªõi c·ªßa b·∫°n <color=yellow>" .. nNewGoldLimit .. "<color> ƒê√£ c√≥ hi·ªáu l·ª±c";
	else
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_UNEFFICIENT_LIMIT, nNewGoldLimit);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_EFFICIENT_DAY, nTime + self.EFFECITDAYS * self.DAYSECOND);
		szMsg = "S·ªë v√†ng m·ªõi c·ªßa b·∫°n <color=yellow>" .. nNewGoldLimit .. "<color> s·∫Ω ƒë∆∞·ª£c "..self.EFFECITDAYS.."	ngay sau ƒë√≥.";
	end
	
	me.Msg(szMsg);
	me.CallClientScript({"Bank:UpdateInfo"});
end
Bank.tbc2sFun["ModifyGoldLimit"] = Bank.ModifyGoldLimit;

-- ¥¶¿Ì¥Ê»Î“¯¡Ω≤Ÿ◊˜
function Bank:SilverSave(nValue)
	if (not nValue or 0 == Lib:IsInteger(nValue)) then
		return;
	end
	if (not nValue or nValue <= 0 or nValue > me.nCashMoney) then
		me.Msg("S·ªë b·∫°n nh·∫≠p v√†o kh√¥ng ƒë√∫ng, xin vui l√≤ng nh·∫≠p l·∫°i.");
		return;
	end
	local nMoney = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_SUM) + nValue;
	if (nMoney > me.GetMaxCarryMoney()) then
		me.Msg("B·∫°n c√≥ m·ª©c ti·ªÅn g·ª≠i hi·ªán t·∫°i c·ªßa b·∫°c ƒë·∫°t ƒë·∫øn s·ªë l∆∞·ª£ng t·ªëi ƒëa cho ph√©p ƒë·ªÉ l∆∞u tr·ªØ.");
		return;
	end
	me.CostMoney(nValue, Player.emKPAY_RESTOREBANK);
	me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_SUM, nMoney);
	
	local szMsg = "B·∫°n ƒë√£ g·ª≠i b·∫°c <color=yellow>" .. nValue .. "<color> .";
	me.Msg(szMsg);
	me.CallClientScript({"Bank:UpdateInfo"});
	
	szMsg = "G·ª≠i b·∫°c v√†o ti·ªÅn trang: " .. nValue;
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_COINBANK, szMsg);
end
Bank.tbc2sFun["SilverSave"] = Bank.SilverSave;

-- »°≥ˆ“¯¡Ω≤Ÿ◊˜
function Bank:SilverDraw(nSilverDrawCount)	
	if (not nSilverDrawCount or 0 == Lib:IsInteger(nSilverDrawCount)) then
		return;
	end
	local nSilverSum = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_SUM);
	if (not nSilverDrawCount or nSilverDrawCount <= 0 or nSilverDrawCount > nSilverSum) then
		me.Msg("S·ªë b·∫°n nh·∫≠p v√†o kh√¥ng ƒë√∫ng, xin vui l√≤ng nh·∫≠p l·∫°i.");
		return;
	end	
	
	local nSilverLimit = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_LIMIT);
	local nHaveDraw = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_TODAYTAKEOUTSILVERCOUNT);
	local nTime = GetTime();
	local nDate = me.GetTask(self.TASK_GROUP, self.TASK_ID_TAKEOUTSILVER_DATE);
	
	if (me.nCashMoney + nSilverDrawCount > me.GetMaxCarryMoney()) then
		me.Msg("B·∫°n kh√¥ng th·ªÉ r√∫t qu√° s·ªë ti·ªÅn m√¨nh ƒë√£ g·ª≠i.");
		return;	
	end
	
	if (nTime - nDate >= self.DAYSECOND) then
		if (nSilverDrawCount > nSilverLimit) then
			me.Msg("B·∫°n mu·ªën lo·∫°i b·ªè b·∫°c gi·ªõi h·∫°n ?");
			return;
		end
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_TAKEOUTSILVER_DATE, nTime);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_TODAYTAKEOUTSILVERCOUNT, nSilverDrawCount);
	else
		if ((nSilverDrawCount + nHaveDraw) > nSilverLimit) then
			local nCanDrawCount = nSilverLimit - nHaveDraw;
			if (nCanDrawCount < 0) then
				nCanDrawCount = 0;
			end
			local szMsg = "B·∫°n lo·∫°i b·ªè trong v√≤ng 24 gi·ªù so v·ªõi gi·ªõi h·∫°n nhi·ªÅu h∆°n, b·∫°n c≈©ng c√≥ th·ªÉ lo·∫°i b·ªè l√™n ƒë·∫øn: <color=yellow>" .. nCanDrawCount .. "<color> b·∫°c."
			me.Msg(szMsg);
			return;
		end
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_TODAYTAKEOUTSILVERCOUNT, nHaveDraw + nSilverDrawCount);
	end	
	
	local nMoney = nSilverSum - nSilverDrawCount;	
	me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_SUM, nMoney);
	me.Earn(nSilverDrawCount, Player.emKEARN_DRAWBANK);
		
	local szMsg = "B·∫°n ƒë√£ x√≥a th√†nh c√¥ng v·ªõi: <color=yellow>" .. nSilverDrawCount .. "<color> gi·ªõi h·∫°n";
	me.Msg(szMsg);
	me.CallClientScript({"Bank:UpdateInfo"});
	
	szMsg = "R√∫t b·∫°c: " .. nSilverDrawCount;
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_COINBANK, szMsg);
end
Bank.tbc2sFun["SilverDraw"] = Bank.SilverDraw;

-- »°œ˚Œ¥…˙–ßµƒ“¯¡Ω÷ß»°…œœﬁ
function Bank:CancelSilverLimit()
	me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_EFFICIENT_DAY, 0);
	me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_UNEFFICIENT_LIMIT, 0);
	me.Msg("B·∫°n ƒë√£ hu·ª∑ b·ªè hi·ªáu l·ª±c c·ªßa b·∫°c kh√¥ng gi·ªõi h·∫°n thu h·ªìi.");	
	me.CallClientScript({"Bank:UpdateInfo"});
end
Bank.tbc2sFun["CancelSilverLimit"] = Bank.CancelSilverLimit;

-- –ﬁ∏ƒ“¯¡Ω÷ß»°…œœﬁ
function Bank:ModifySilverLimit(nNewSilverLimit)
	if (not nNewSilverLimit or 0 == Lib:IsInteger(nNewSilverLimit)) then
		return;
	end
	if (not nNewSilverLimit or nNewSilverLimit <= 0 or nNewSilverLimit > Bank.MAX_MONEY) then
		me.Msg("S·ªë b·∫°n nh·∫≠p v√†o kh√¥ng ƒë√∫ng, xin vui l√≤ng nh·∫≠p l·∫°i.");
		return;
	end
	local nOldSilverLimit = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_LIMIT);
	local szMsg = "";
	local nTime = GetTime();
	
	if nNewSilverLimit <= nOldSilverLimit then
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_LIMIT, nNewSilverLimit);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_UNEFFICIENT_LIMIT, 0);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_EFFICIENT_DAY, 0);
		szMsg = "B·∫°n ƒë√£ s·ª≠a gi·ªõi h·∫°n b·∫°c m·ªõi: <color=yellow>" .. nNewSilverLimit .. "<color> ƒë√£ c√≥ hi·ªáu l·ª±c";
	else
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_UNEFFICIENT_LIMIT, nNewSilverLimit);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_EFFICIENT_DAY, nTime + self.EFFECITDAYS * self.DAYSECOND);
		szMsg = "B·∫°n ƒë√£ s·ª≠a gi·ªõi h·∫°n b·∫°c m·ªõi: <color=yellow>" .. nNewSilverLimit .. "<color> s·∫Ω ƒë∆∞·ª£c "..self.EFFECITDAYS.." √≥ hi·ªáu l·ª±c v√†o ng√†y";
	end
	
	me.Msg(szMsg);
	me.CallClientScript({"Bank:UpdateInfo"});
end
Bank.tbc2sFun["ModifySilverLimit"] = Bank.ModifySilverLimit;

-- ≈–∂œ≤¢÷¥––Ω±““‘º∞“¯¡Ωµƒ…˙–ß≤Ÿ◊˜
function Bank:DoEfficient()
	self:DoGoldEfficient();
	self:DoSilverEfficient();
	me.CallClientScript({"Bank:UpdateInfo"});
end
Bank.tbc2sFun["DoEfficient"] = Bank.DoEfficient;

-- ≈–∂œ≤¢÷¥––Ω±“µƒ…˙–ß≤Ÿ◊˜,»Áπ˚¥Ê‘⁄0÷µ,∞—∏√÷µ∏≥÷µŒ™ƒ¨»œ÷µ
function Bank:DoGoldEfficient()
	local nEfficientTime = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_EFFICIENT_DAY);
	local nTime = GetTime();
		
	if (nEfficientTime > 0 and nTime >= nEfficientTime) then
		local nNewGoldLimit = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_UNEFFICIENT_LIMIT);
		if (nNewGoldLimit == 0) then
			return 0;
		end
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_LIMIT, nNewGoldLimit);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_EFFICIENT_DAY, 0);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_UNEFFICIENT_LIMIT, 0);
	end	
	
	local nGoldLimit = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_LIMIT);
	if (0 == nGoldLimit) then
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_GOLD_LIMIT, Bank.DEFAULTCOINLIMIT);
	end
end

-- ≈–∂œ≤¢÷¥––“¯¡Ωµƒ…˙–ß≤Ÿ◊˜£¨»Áπ˚¥Ê‘⁄0÷µ£¨∞—∏√÷µ∏≥÷µŒ™ƒ¨»œ÷µ
function Bank:DoSilverEfficient()
	local nEfficientTime = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_EFFICIENT_DAY);
	local nTime = GetTime();
	
	if (nEfficientTime > 0 and nTime >= nEfficientTime) then
		local nNewSilverLimit = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_UNEFFICIENT_LIMIT);
		if (0 == nNewSilverLimit) then
			return 0;
		end
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_LIMIT, nNewSilverLimit);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_EFFICIENT_DAY, 0);
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_UNEFFICIENT_LIMIT, 0);
	end
	
	local nSilverLimit = me.GetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_LIMIT);
	if (0 == nSilverLimit) then
		me.SetTask(Bank.TASK_GROUP, Bank.TASK_ID_SILVER_LIMIT, Bank.DEFAULTMONEYLIMIT);
	end
end
