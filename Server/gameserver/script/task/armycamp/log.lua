--軍營log2接口

Require("\\script\\task\\armycamp\\define.lua");

local StatLog = {};
Task.tbArmyCampInstancingManager.StatLog = StatLog;


-- Lên đến 15 chữ số, 16 chữ số-32 chữ số ghi tuần
-- Loại bản ghi 15 bit là 1, tiếp theo là loại bản ghi 2
StatLog.LogList = 
{
	--  {描述，類型（1,按人頭算，2,總量）}
	[1] = {"Có bao nhiêu người chơi đã vào ngục tối trong tuần này", 1};
	[2] = {"Có bao nhiêu người chơi tiếp quản câu chuyện trong tuần này",1};
[3] = {"Có bao nhiêu người chơi đã tham gia ngục tối hàng ngày trong tuần này", 1};
[4] = {"Có bao nhiêu người chơi đã hoàn thành một bản sao của câu chuyện trong tuần này", 1};
[5] = {"Có bao nhiêu người chơi đã hoàn thành phó bản hàng ngày trong tuần này", 1};
[6] = {"Có bao nhiêu người chơi đã đọc cuốn sách này trong tuần này", 1};
[7] = {"Có bao nhiêu người chơi đã đọc sách quân sự trong tuần này", 1};
[8] = {"Có bao nhiêu người chơi đã đọc xong cuốn sách cơ chế trong tuần này", 1};
[9] = {"Có bao nhiêu người chơi đã đọc xong cuốn sách về chiến tranh trong tuần này", 1};
[10] = {"Có bao nhiêu người chơi đã nhận nhiệm vụ ngẫu nhiên trong ngục tối tuần này", 1};
[11] = {"Thành tích học tập được tạo ra trong tuần này", 2};
[12] = {"Độ bền của các cơ quan sản xuất trong tuần này", 2};
[13] = {""};
[14] = {""};
[15] = {""};
[16] = {"Số lượng mặt nạ (loại% s) được sản xuất trong tuần này", 2};
}
StatLog.nTaskGroupId = 2044;
StatLog.nTaskId = 11;

function StatLog:WriteLog(nLogId, nValue, pPlayer, nArg)
	if not self.LogList[nLogId] then
		return 0;
	end
	if (pPlayer) then
		Setting:SetGlobalObj(pPlayer, him, it);
	end
	local nWeek = tonumber(GetLocalDate("%W"));
	local nYear	= tonumber(GetLocalDate("%Y"));
	local szKey = string.format("%sNăm%sTuần", nYear, nWeek);
	local szField = self.LogList[nLogId][1];
	if nArg then
		szField = string.format(szField, nArg);
	end
	if self.LogList[nLogId][2] == 2 then
		KStatLog.ModifyAdd("armycamp", szKey, szField, nValue)
	elseif self.LogList[nLogId][2] == 1 then
		local nTaskValue = me.GetTask(self.nTaskGroupId, self.nTaskId);
		if self:GetWeek(nTaskValue) < nWeek then
			nTaskValue = self:SetWeek(nWeek);
		end
		if KLib.GetBit(nTaskValue, nLogId) == 0 then
			local nSetTask = KLib.SetBit(nTaskValue, nLogId, 1) 
			me.SetTask(self.nTaskGroupId, self.nTaskId, nSetTask);
			KStatLog.ModifyAdd("armycamp", szKey, szField, nValue)
		end
	end
	if (pPlayer) then
		Setting:RestoreGlobalObj();
	end
end

function StatLog:GetWeek(nTaskValue)
	local nWeek = math.floor(nTaskValue/2^15)
	return nWeek;
end

function StatLog:SetWeek(nWeek)
	local nSetTaskValue = (nWeek * 2^15);
	me.SetTask(self.nTaskGroupId, self.nTaskId, nSetTaskValue);
	return nSetTaskValue;
end
