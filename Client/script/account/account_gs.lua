-------------------------------------------------------------------
--File: account_gs.lua
--Author: lbh
--Date: 2008-6-27 10:04
--Describe: ’À∫≈œ‡πÿGS∂À
-------------------------------------------------------------------
Require("\\script\\account\\account_head.lua");
Require("\\script\\player\\playerevent.lua");

Account.tbUnlockFailCount = {} -- ’À∫≈Ω‚À¯ ß∞‹¥Œ ˝
Account.tbBanUnlockTime = {} -- ’À∫≈Ω˚÷π ±º‰
Account.UNLOCK_FAIL_LIMIT = 5;
Account.UNLOCK_BAN_TIME = 30;	-- Ω‚À¯¥Ô ß∞‹¥Œ ˝∂≥Ω·∂‡…Ÿ∑÷÷”
Account.TIME_UNLOCKPASSPOD = 60 * 5;	-- µ«¬Ω∫Û8∑÷÷”≤ªµ√Ω‚À¯
Account.c2sCmd = {};

function Account:ProcessClientCmd(nId, tbParam)
	if type(nId) ~= "number" then
		return;
	end
	local fun = self.c2sCmd[nId];
	if not fun then
		return;
	end
	fun(Account, unpack(tbParam));
end

function Account:SetAccPsw(nOldPsw, nNewPsw, nr)
	if not nr then
		nr = 1;
	end
	nNewPsw = math.floor(math.floor(nNewPsw * nr) / 64);
	local bSetOldPsw = 0;
	if (nOldPsw ~= 0) then
		bSetOldPsw = 1;
		nOldPsw = math.floor(nOldPsw * math.floor(nNewPsw / 1048576) / 64) - 1000000;
	end
	nNewPsw = nNewPsw % 1048576;
	local nNameId = KLib.String2Id(tostring(me.GetNpc().dwId));
	local nNewPswOrg = nNewPsw;
	local nOldPswOrg = nOldPsw;
	nNewPsw = 0;
	nOldPsw = 0;
	local nPos = 1;
	for i = 1, 6 do
		nNewPsw = nNewPsw + ((nNewPswOrg - nNameId) % 10 + 10) % 10 * nPos;
		nNewPswOrg = math.floor(nNewPswOrg / 10);
		if bSetOldPsw ~= 0 then
			nOldPsw = nOldPsw + ((nOldPswOrg - nNameId) % 10 + 10) % 10 * nPos;		
			nOldPswOrg = math.floor(nOldPswOrg / 10);
		end
		nNameId = math.floor(nNameId / 10);
		nPos = nPos * 10;
	end
	
	if nNewPsw < 100000 or nNewPsw > 999999 then
		me.Msg("Thi·∫øt l·∫≠p kh√¥ng th√†nh c√¥ng: m·∫≠t kh·∫©u ph·∫£i t·ª´ 6 k√Ω t·ª±, v√† kh√¥ng th·ªÉ b·∫Øt ƒë·∫ßu v·ªõi 0");
		return 0;
	end
	
	local szAccount = me.szAccount;
	local nBanTime = self.tbBanUnlockTime[szAccount];
	if nBanTime then
		local nLeftMin = math.ceil(nBanTime / 60 + self.UNLOCK_BAN_TIME -  GetTime() / 60);
		if nLeftMin > 0 then
			me.Msg("<color=yellow>"..nLeftMin.."<color>V√†i ph√∫t sau, b·∫°n h√£y th·ª≠ l·∫°i!");
			return 0;
		end
		self.tbBanUnlockTime[szAccount] = nil;
	end
	
	if me.SetAccountLockCode(nOldPsw, nNewPsw) ~= 1 then
		me.Msg("C·∫•u h√¨nh th·∫•t b·∫°i: m·∫≠t kh·∫©u ban ƒë·∫ßu l√† kh√¥ng ch√≠nh x√°c!");
		self:PswFail();
		return 0;	
	end
	
	if self.tbUnlockFailCount[szAccount] then
		GlobalExcute{"Account:SetUnLockAccFailCount", szAccount, nil};
	end
	
	if (nOldPsw == 0) then
		me.UnLockAccount(nNewPsw); -- ÷ÿ–¬Õ¨≤ΩÀ¯∂®◊¥Ã¨
		me.Msg("Kh√≥a m·∫≠t kh·∫©u T√†i kho·∫£n ƒë∆∞·ª£c thi·∫øt l·∫≠p th√†nh c√¥ng, t√†i kho·∫£n c·ªßa t·∫•t c·∫£ c√°c vai tr√≤ trong c√°c tr√≤ ch∆°i m·ªói khi b·∫°n ƒëƒÉng nh·∫≠p, kh√≥a s·∫Ω m·ªü t·ª± ƒë·ªông!");	
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "Kh√≥a m·∫≠t kh·∫©u T√†i kho·∫£n ƒë∆∞·ª£c thi·∫øt l·∫≠p th√†nh c√¥ng.");
		
	else
		me.Msg("Thay ƒë·ªïi m·∫≠t kh·∫©u t√†i kho·∫£n kh√≥a th√†nh c√¥ng!");
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "Thay doi mat khau tai khoan thanh cong.");
	end

	return 1;
end
Account.c2sCmd[Account.SET_PSW] = Account.SetAccPsw;

function Account:LockAcc()
	if me.LockAccount() ~= 1 then		
		me.Msg("Kh√≥a t√†i kho·∫£n th·∫•t b·∫°i: m·∫≠t kh·∫©u t√†i kho·∫£n kh√≥a kh√¥ng ƒë∆∞·ª£c thi·∫øt l·∫≠p!");
		return;
	end
	me.Msg("T√†i kho·∫£n b·ªã kh√≥a!");
	return 1;
end
Account.c2sCmd[Account.LOCKACC] = Account.LockAcc;

--  «∑Ò”–»®…Í«Î◊‘÷˙Ω‚À¯
function Account:CanApplyDisableLock()
	if me.GetAccountMaxLevel() > me.nLevel then
		return 0;
	end
	return 1;
end

-- …Í«Î◊‘÷˙Ω‚À¯
function Account:DisableLock_Apply()
	if me.IsAccountLockOpen() ~= 1 then
		me.Msg("T√†i kho·∫£n c·ªßa b·∫°n kh√¥ng kh√≥a.");
		return 0;
	end
	if self.CanApplyDisableLock() == 1 then
		me.DisableAccountLock_Apply();
		me.Msg("B·∫°n ƒë√£ g·ª≠i h·ªó tr·ª£ m·ªü kh√≥a, Kh√≥a s·∫Ω ƒë∆∞·ª£c m·ªü <color=yellow> v√†o 5 ng√†y sau <color>, b·∫°n c√≥ th·ªÉ h·ªßy m·ªü kh√≥a b·∫•t c·ª© l√∫c n√†o.")
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "…Í«Î◊‘÷˙Ω‚À¯°£");
	else
		me.Msg("Vui l√≤ng ƒëƒÉng nh·∫≠p v√†o t√†i kho·∫£n c·ªßa b·∫°n ti·∫øp theo ch·ªçn t·ª± gi√∫p ƒë·ª° m·ªü kh√≥a t√†i kho·∫£n.");
	end
	self:SyncJiesuoStateToClient();
end
Account.c2sCmd[Account.JIESUO_APPLY] = Account.DisableLock_Apply;

-- ◊‘÷˙Ω‚À¯ ÷¥––
function Account:DisableLock()
	me.ClearAccountLock();
	Account:DisableLock_Cancel(); -- «Â≥˝◊‘÷˙Ω‚À¯…Í«Î
	
	self:SyncJiesuoStateToClient();
	me.CallClientScript({"Player:JiesuoNotify"});
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "Tro giup mo khoa thanh cong.");
end

-- »°œ˚◊‘÷˙Ω‚À¯…Í«Î
function Account:DisableLock_Cancel()
	me.DisableAccountLock_Cancel();
	self:SyncJiesuoStateToClient();
end

function Account:Jiesuo_Cancel()
	self:DisableLock_Cancel();
	me.Msg("Tr·ª£ gi√∫p m·ªü kh√≥a ƒë√£ ƒë∆∞·ª£c h·ªßy b·ªè.");
	me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "Tro giup mo khoa bi huy bo.");
end
Account.c2sCmd[Account.JIESUO_CANCEL] = Account.Jiesuo_Cancel;

function Account:GetDisableLockApplyTime()
	--me.Msg("…œ¥Œ…Í«ÎΩ‚À¯ ±º‰ "..os.date("%Y-%m-%d %H:%M:%S", me.GetDisableAccountLockApplyTime()));
	return me.GetDisableAccountLockApplyTime();
end

function Account:IsApplyingDisableLock()
	return me.IsApplyingDisableAccountLock();
end
Account.c2sCmd[Account.IS_APPLYING_JIESUO] = Account.IsApplyingDisableLock;

function Account:UnLockAcc(nPsw, nr)
	if (me.GetPasspodMode() == 1) then
		return 0;	-- ”–√‹±££¨‘≠’À∫≈À¯ ß–ß
	end
	
	if not nr then
		nr = 1;
	end
	nPsw = math.floor(math.floor(nPsw * nr) / 64) % 1048576;
	if nPsw == 0 then
		return 0;
	end
	local nNameId = KLib.String2Id(tostring(me.GetNpc().dwId));
	local nOldPsw = nPsw;
	nPsw = 0;
	local nPos = 1;
	for i = 1, 6 do
		nPsw = nPsw + ((nOldPsw - nNameId) % 10 + 10) % 10 * nPos;
		nOldPsw = math.floor(nOldPsw / 10);
		nNameId = math.floor(nNameId / 10);
		nPos = nPos * 10;
	end
	local szAccount = me.szAccount;
	local nBanTime = self.tbBanUnlockTime[szAccount];
	if nBanTime then
		local nLeftMin = math.ceil(nBanTime / 60 + self.UNLOCK_BAN_TIME -  GetTime() / 60);
		if nLeftMin > 0 then
			me.Msg("<color=yellow>"..nLeftMin.."<color>V√†i ph√∫t sau, b·∫°n c√≥ th·ªÉ th·ª≠ ƒë·ªÉ m·ªü kh√≥a t√†i kho·∫£n m·ªôt l·∫ßn n·ªØa!");
			return 0;
		end
		self.tbBanUnlockTime[szAccount] = nil;
	end

	return me.UnLockAccount(nPsw);
end
Account.c2sCmd[Account.UNLOCK] = Account.UnLockAcc;

function Account:UnLockAcc_ByPasspod(szCode)
	if (me.GetPasspodMode() == 0) then
		return 0;	-- Œﬁ√‹±£
	end
	if type(szCode) ~= "string" then
		return 0;
	end

	if me.GetPasspodMode() == self.PASSPODMODE_ZPTOKEN and 
		(GetTime() < Player:GetLastLoginTime(me) + self.TIME_UNLOCKPASSPOD) then
			return 0;	-- Ω…Ω¡Ó≈∆ µ«¬Ω∫Û8∑÷÷”ƒ⁄≤ªµ√Ω‚À¯
	end
	
	local szAccount = me.szAccount;
	local nBanTime = self.tbBanUnlockTime[szAccount];
	if nBanTime then
		local nLeftMin = math.ceil(nBanTime / 60 + self.UNLOCK_BAN_TIME -  GetTime() / 60);
		if nLeftMin > 0 then
			me.Msg("<color=yellow>"..nLeftMin.."<color>V√†i ph√∫t sau, b·∫°n c√≥ th·ªÉ th·ª≠ ƒë·ªÉ m·ªü kh√≥a t√†i kho·∫£n m·ªôt l·∫ßn n·ªØa!");
			return 0;
		end
		self.tbBanUnlockTime[szAccount] = nil;
	end
	me.ClearAccountLock();	-- «Â≥˝∞≤»´À¯
	return me.UnLockPasspodAccount(szCode);
end
Account.c2sCmd[Account.UNLOCK_BYPASSPOD] = Account.UnLockAcc_ByPasspod;

function Account:UnLockAcc_PhoneLock()
	GCExcute{"Account:OnApplyPhoneLock", me.szName};
end
Account.c2sCmd[Account.UNLOCK_PHONELOCK] = Account.UnLockAcc_PhoneLock;

function Account:OnUnlockResult(nResult)
	if (nResult == 1) then
		if self.tbUnlockFailCount[me.szAccount] then
			GlobalExcute{"Account:SetUnLockAccFailCount", me.szAccount, nil};
		end
		me.Msg("M·ªü kh√≥a th√†nh c√¥ng");
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "Mo khoa thanh cong");
		return;
	end
	
	local szErrorMsg = "";
	if (me.GetPasspodMode() ~= 0) then
		
		szErrorMsg = "M·ªü kh√≥a kh√¥ng th√†nh c√¥ng "..(self.FAILED_RESULT[nResult] or "Vui l√≤ng ki·ªÉm tra l·∫°i");
		
		me.Msg(szErrorMsg);
		
		--Õ®÷™øÕªß∂ÀΩÁ√Ê∏¸–¬¥ÌŒÛÃ· æ
		me.CallClientScript({"Ui:ServerCall", "UI_LOCKACCOUNT", "UpdateErrorMsg" , szErrorMsg});	
	
		
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, szErrorMsg);
	else
		
		szErrorMsg = "B·∫°n ƒë√£ nh·∫≠p sai m·∫≠t kh·∫©u, xin vui l√≤ng nh·∫≠p l·∫°i.";
		
		me.Msg(szErrorMsg);
		
	  --Õ®÷™øÕªß∂ÀΩÁ√Ê∏¸–¬¥ÌŒÛÃ· æ
		me.CallClientScript({"Ui:ServerCall", "UI_LOCKACCOUNT", "UpdateErrorMsg" , szErrorMsg});	
		
		me.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, szErrorMsg);
	end
	self:PswFail();
end

function Account:OnUnlockPhoneLockResult(szPlayerName, nResult)
	local pPlayer = KPlayer.GetPlayerByName(szPlayerName);
	if pPlayer then
		if (1 == nResult) then
			pPlayer.UnLockAccount(0);
			pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "Thiet lap khoa thanh cong");
		end
		pPlayer.CallClientScript{"Ui:ServerCall", "UI_LOCKACCOUNT", "PhoneLockResult" , nResult};
	end
end

function Account:SetUnLockAccFailCount(szAccount, nCount)
	self.tbUnlockFailCount[szAccount] = nCount;
end

function Account:SetUnLockAccBanTime(szAccount, nTime)
	self.tbBanUnlockTime[szAccount] = nTime;
	self.tbUnlockFailCount[szAccount] = 0; -- ¥Œ ˝«Â0
end

function Account:PswFail()
	local szAccount = me.szAccount;
	local nFailCount = self.tbUnlockFailCount[szAccount];	
	if not nFailCount then
		nFailCount = 0;
	end
	nFailCount = nFailCount + 1;
	
	if nFailCount >= self.UNLOCK_FAIL_LIMIT then
		
		local szErrorMsg = "ƒê√£ h·∫øt s·ªë l·∫ßn th·ª≠ l·∫°i <color=yellow>"..self.UNLOCK_BAN_TIME..
			"<color>Ph√∫t n·ªØa h√£y th·ª≠ l·∫°i ho·∫∑c li√™n h·ªá v·ªõi b·ªô ph·∫≠n chƒÉm s√≥c kh√°ch h√†ng"
		me.Msg(szErrorMsg);
		
		--Õ®÷™øÕªß∂ÀΩÁ√Ê∏¸–¬¥ÌŒÛÃ· æ
		me.CallClientScript({"Ui:ServerCall", "UI_LOCKACCOUNT", "UpdateErrorMsg" , szErrorMsg});	
		
		local nTime = GetTime();
		self.tbBanUnlockTime[szAccount] = nTime;
		GlobalExcute{"Account:SetUnLockAccBanTime", szAccount, nTime};	

		return 0;
	end	
	me.Msg("B·∫°n ƒë√£ nh·∫≠p qu√° s·ªë l·∫ßn qui ƒë·ªãnh <color=yellow>"..nFailCount..
	"<color>Th·ª© hai, n·∫øu li√™n t·ª•c <color=yellow>"..self.UNLOCK_FAIL_LIMIT.."<color>th·∫•t b·∫°i, trong<color=yellow>"..
		self.UNLOCK_BAN_TIME.."<color>Ph√∫t d∆∞·ªõi c√πng m·ªôt t√†i kho·∫£n vai tr√≤ l√† b·∫°n s·∫Ω kh√¥ng c·ªë g·∫Øng m·ªôt l·∫ßn n·ªØa!");
	
	self.tbUnlockFailCount[szAccount] = nFailCount;
	
	GlobalExcute{"Account:SetUnLockAccFailCount", szAccount, nFailCount};
	return 1;
end

function Account:OnLogin(bExchangeServer)
	if me.GetPasspodMode() == self.PASSPODMODE_ZPMATRIX then
		self:RandomMatrixPos();	-- ÀÊª˙æÿ’Ûø®Œª÷√
	end
	if (bExchangeServer == 1) then
		return;
	end	
	if me.IsApplyingDisableAccountLock() == 1 then		
		local dwTimeApply = me.GetDisableAccountLockApplyTime();
		if dwTimeApply ~= 0 then
			if dwTimeApply + 5 * 24 * 60 * 60 <= GetTime() then
				Account:DisableLock();
			else
				me.CallClientScript({"Player:ApplyJiesuoNotify", me.GetDisableAccountLockApplyTime()});				
			end
		else
			me.CallClientScript({"Player:ApplyJiesuoNotify"});
		end
	end
	self:SyncJiesuoStateToClient();
end

function Account:RandomMatrixPos()
	local tbRow = {'A','B','C','D','E','F','G','H'};
	local tbLine = {1, 2, 3, 4, 5, 6, 7, 8, 9, 0};
	
	local szPos = "";
	for i = 1, 3 do
		local nIndex = MathRandom(#tbRow);
		szPos = szPos..tbRow[nIndex];
		table.remove(tbRow, nIndex);
		nIndex = MathRandom(#tbLine);
		szPos = szPos..tbLine[nIndex];
		table.remove(tbLine, nIndex);
	end
	me.SetMatrixPosition(szPos);
end

function Account:SyncJiesuoStateToClient()
	me.CallClientScript({"Player:SyncJiesuoState_C", self.CanApplyDisableLock()
		, self.IsApplyingDisableLock(), self.GetDisableLockApplyTime()});
end

--  «∑Ò¥Úø™Õ∆π„√‹±£∫Õ¡Ó≈∆
function Account:IsOpenPasspodAd()
	if string.sub(GetGatewayName(), 1, 4) == "gate" then
		return 1;
	end
	return 0;
end

PlayerEvent:RegisterGlobal("OnLogin", Account.OnLogin, Account);

