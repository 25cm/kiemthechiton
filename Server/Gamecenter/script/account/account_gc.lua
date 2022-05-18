
function Account:OnPhoneLockResult(szName, nResult)
	return GlobalExcute{"Account:OnUnlockPhoneLockResult", szName, nResult};
end

function Account:OnApplyPhoneLock(szName)
	local nRet = ApplyUnlockPhoneLock(szName);
	if nRet ~= 1 then
		self:OnPhoneLockResult(szName, 2);			-- ÷ÿ∏¥…Í«Î
	end
end

