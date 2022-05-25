SpecialEvent.ActiveGift = SpecialEvent.ActiveGift or {};
local ActiveGift = SpecialEvent.ActiveGift;

function ActiveGift:GetActiveInfo(nId)
	local tbActive = self.tbActiveInfo[nId];
	if not tbActive then
		return "";
	end
	return tbActive.szInfo;	
end

function ActiveGift:GetAwardInfo(nId)
	local szLoginInfo, szActiveInfo = "", "";
	local nMonthnActive = 0;
	local nActive = 0;
	if self.tbMonthAward[nId] then
		szLoginInfo =  self.tbMonthAward[nId].szInfor or "";
		nMonthnActive = self.tbMonthAward[nId].nActive or 0;
	end	
	if self.tbActiveAward[nId] then
		szActiveInfo =  self.tbActiveAward[nId].szInfor or "";
		nActive = self.tbActiveAward[nId].nActive or 0;
	end
	return szLoginInfo, szActiveInfo, nMonthnActive, nActive;
end

function ActiveGift:GetAwardState(nId)
	local nActiveTimes = me.GetTask(self.nTaskGroupId, self.nActiveAwardTime);
	local nActiveState = me.GetTask(self.nTaskGroupId, self.nActiveAwardNum);
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
	if nActiveTimes ~= nNowDate  then
		nActiveState = 0;
	end
	local nMonthTime = me.GetTask(self.nTaskGroupId, self.nMonthAwardTime);
	local nMonthActiveState = me.GetTask(self.nTaskGroupId, self.nMonthAwardNum);
	local nNowMonth = tonumber(GetLocalDate("%m"));
	if nMonthTime ~= nNowMonth  then
		nMonthActiveState = 0;
	end
	return self:CheckBit(nActiveState, nId), self:CheckBit(nMonthActiveState, nId);
end

function ActiveGift:GetActiveGrade()
	local nTimes = me.GetTask(self.nTaskGroupId, self.nActiveTime);
	local nActiveGrade = me.GetTask(self.nTaskGroupId, self.nActiveGrade);
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
	if nTimes ~= nNowDate  then
		return 0;
	end
	return math.min(nActiveGrade, self.nMaxActiveGrade);
end

function ActiveGift:GetMonthActive()
	local nTimes = me.GetTask(self.nTaskGroupId, self.nMonthActiveTime);
	local nMonthActiveGrade = me.GetTask(self.nTaskGroupId, self.nMonthActiveGrade);
	local nNowMonth = tonumber(GetLocalDate("%m"));
	if nTimes ~= nNowMonth  then
		return 0;
	end
	return math.min(nMonthActiveGrade, self.nMaxMonthActive);
end
