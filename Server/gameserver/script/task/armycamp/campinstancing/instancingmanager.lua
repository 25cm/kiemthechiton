Require("\\script\\task\\armycamp\\define.lua")

local tbManager = Task.tbArmyCampInstancingManager;
tbManager.tbInstancingUsable = {};		-- 副本使用情况
tbManager.tbWaitQueue = {};				-- 等待GC完成地图载入的玩家队列
tbManager.tbInstancingLib = {};			-- 副本基类库


function tbManager:GetInstancingBase(nInstancingTemplateId)
	if (not self.tbInstancingLib[nInstancingTemplateId]) then
		self.tbInstancingLib[nInstancingTemplateId] = {};
		self.tbInstancingLib[nInstancingTemplateId].nInstancingTemplateId = nInstancingTemplateId;
		self.tbInstancingLib[nInstancingTemplateId].tbSetting = self:GetInstancingSetting(nInstancingTemplateId);
	end
	
	return self.tbInstancingLib[nInstancingTemplateId];
end


function tbManager:AskRegisterInstancing(nInstancingTemplateId, nPlayerId)
	local tbSetting = self:GetInstancingSetting(nInstancingTemplateId);	
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	assert(pPlayer);
	
	local tbNow	= os.date("*t", GetTime());
	if (self:Time2Int(tbNow) == pPlayer.GetTask(tbSetting.tbInstancingTimeId.nTaskGroup, tbSetting.tbInstancingTimeId.nTaskId)) then
		self:Warring(pPlayer, "Lúc này đã báo danh rồi, không thể báo danh phó bản, xin vui lòng đợi");
		return;
	end
	
	if (self:GetCurOpenInstancingNum(tbNow.hour) >= self.nInstancingMaxCount) then
		self:Warring(pPlayer, "Số phó bản đã đến giới hạn");
		return;
	end
	
	if (pPlayer.nTeamId <= 0 or pPlayer.IsCaptain() ~= 1) then
		self:Warring(pPlayer, "Đội trưởng mới được báo danh");
		return;
	end
	
	
	if (self:CheckRegisterTime(nInstancingTemplateId, nPlayerId) ~= 1) then
		self:Warring(pPlayer, "Xin báo danh đúng thời gian quy định");
		return;
	end
	
	
	if (self:CheckTeamRegisterCondition(nInstancingTemplateId, nPlayerId) ~= 1) then
		return;
	end
	
	
	local szMsg = "Đội này đã báo danh phó bản"..tbSetting.szName;
	KTeam.Msg2Team(pPlayer.nTeamId, szMsg);
	
	self:RegisterSucess(nInstancingTemplateId, nPlayerId);
end



function tbManager:CheckRegisterTime(nInstancingTemplateId, nPlayerId)
	local tbSetting = self:GetInstancingSetting(nInstancingTemplateId);
	local nNowTime	= GetTime();
	local tbToday	= os.date("*t", nNowTime);
	local nHour 	= tbToday.hour;
	local nMin		= tbToday.min;
	local bOK		= 0;
	for _, nOpenHour in ipairs(tbSetting.tbOpenHour) do
		if (nOpenHour == nHour) then
			bOK = 1;
		end
	end
	if (bOK ~= 1) then
		return 0;
	end

	if (nMin > tbSetting.tbOpenDuration) then
		return 0;
	end
	
	return 1;
end

function tbManager:CheckTeamRegisterCondition(nInstancingTemplateId, nPlayerId)
	local pCaptain = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pCaptain) then
		return 0;
	end
	
	local tbSetting = self:GetInstancingSetting(nInstancingTemplateId);
	local tbTeammateList, _ = pCaptain.GetTeamMemberList();
	
	local nCount = 0;
	for _, pPlayer in ipairs(tbTeammateList) do
		if (pPlayer.nMapId == pCaptain.nMapId) then
			local nRet, szMsg = self:CheckRegisterCondition(nInstancingTemplateId, pPlayer.nId);
			if (nRet ~= 1) then
				self:Warring(pCaptain, szMsg);
				return 0;
			end	
			
			if (pPlayer.nMapId == pCaptain.nMapId) then
				nCount = nCount + 1;
			end
		end
	end
	
--	if (nCount < tbSetting.nMinPlayer) then
--		self:Warring(pCaptain, "Phải có "..(tbSetting.nMinPlayer-nCount).." đội viên ở gần.");
--		return 0;
--	end
	
	return 1;
end



function tbManager:RegisterSucess(nInstancingTemplateId, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	assert(pPlayer);
	local tbInstancingList = self:GetRunInstancingList();
	for _, tbInstancing in pairs(tbInstancingList) do
		if (tbInstancing.nTeamId == pPlayer.nTeamId) then
			tbInstancing.nTeamId = nil;
		end
	end;
	
	local nMapId = self:GetFreeInstancing(nInstancingTemplateId);
	if (nMapId) then
		self:OpenMap(nMapId, nInstancingTemplateId, nPlayerId)
	else
		local nMapTemplateId = self:GetInstancingSetting(nInstancingTemplateId).nInstancingMapTemplateId;
		if (LoadDynMap(Map.DYNMAP_TREASUREMAP, nMapTemplateId, nInstancingTemplateId) == 1) then
			self.tbWaitQueue[#self.tbWaitQueue + 1] = {nPlayerId = nPlayerId, nInstancingTemplateId = nInstancingTemplateId};
		end
	end
end


function tbManager:AskEnterInstancing(nInstancingTemplateId, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	
	local nRet, szErrorMsg = self:CheckEnterCondition(nInstancingTemplateId, nPlayerId);
	if (nRet ~= 1) then
		self:Warring(pPlayer, szErrorMsg);
		return;
	end

	local tbSetting = self:GetInstancingSetting(nInstancingTemplateId);
	local tbInstancingList = self:GetRunInstancingList();
	assert(tbInstancingList);

	for _, tbInstancing in pairs(tbInstancingList) do 
		if ((tbInstancing.nTeamId == pPlayer.nTeamId) and
			(tbInstancing.nInstancingTemplateId == nInstancingTemplateId) and
			self:Time2Int(tbInstancing.tbOpenTime) > pPlayer.GetTask(tbSetting.tbInstancingTimeId.nTaskGroup, tbSetting.tbInstancingTimeId.nTaskId)) then -- TODO:liuchang 跨年的时候会有问题
				if (self:CheckTaskLimit(pPlayer, tbSetting.nInstancingEnterLimit_D) ~= 1) then
					self:Warring(pPlayer, "Số lần ngươi vào phó bản đã đến giới hạn.");
					return;
				else
					self:BindPlayer2Instancing(pPlayer.nId, nInstancingTemplateId, tbInstancing.tbOpenTime, tbInstancing.nMapId, tbInstancing.nRegisterMapId); -- TODO:liuchang 有漏洞
					tbInstancing:OnPlayerAskEnter(pPlayer.nId);
					return;
				end
		end
	end
	
	for _, tbInstancing in pairs(tbInstancingList) do		
		local nPlayerInstancingMapId = pPlayer.GetTask(tbSetting.tbInstancingMapId.nTaskGroup, tbSetting.tbInstancingMapId.nTaskId);
		if (tbInstancing.nMapId == nPlayerInstancingMapId) and
			(tbInstancing.nInstancingTemplateId == nInstancingTemplateId) then
			if (self:Time2Int(tbInstancing.tbOpenTime) == pPlayer.GetTask(tbSetting.tbInstancingTimeId.nTaskGroup, tbSetting.tbInstancingTimeId.nTaskId)) then
				tbInstancing:OnPlayerAskEnter(pPlayer.nId);
				return;
			end
		end
	end

	local nRegisterMapId = pPlayer.GetTask(tbSetting.nRegisterMapId.nTaskGroup, tbSetting.nRegisterMapId.nTaskId);
	local tbNow	= os.date("*t", GetTime());
	local nLastHour = (self:Time2Int(tbNow) - pPlayer.GetTask(tbSetting.tbInstancingTimeId.nTaskGroup, tbSetting.tbInstancingTimeId.nTaskId));
	local nLastMin = nLastHour * 60 + tbNow.min;	
	if (nLastMin * 60 < tbSetting.nInstancingExistTime) then
		if (nRegisterMapId ~= pPlayer.nMapId and nRegisterMapId ~= 0) then
			self:Send2RegisterMap(nRegisterMapId, nPlayerId);
			return;
		end
	end
		
	self:Warring(pPlayer, "Báo danh trước hoặc tìm được khu quân doanh của đội lúc báo danh vào phó bản");
end

function tbManager:Send2RegisterMap(nRegisterMapId, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	assert(pPlayer);
	Setting:SetGlobalObj(pPlayer, him, it)
	local szRegisterMapName = Task:GetMapName(nRegisterMapId);
	
	local szMainMsg = "Bạn là người thứ "..szRegisterMapName.." báo danh, xin tới khu vực này để vào phó bản";
	
	local tbOpt = {
		{"Bây giờ đi", self.ChoseCamp, self, nPlayerId, nRegisterMapId, 1631, 3142},		
		{"Kết thúc đối thoại"}
	}
	
	Dialog:Say(szMainMsg, tbOpt);
	Setting:RestoreGlobalObj();
end

function tbManager:ChoseCamp(nPlayerId, nMapId, nPosX, nPosY)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	assert(pPlayer);
	
	pPlayer.NewWorld(nMapId, nPosX, nPosY);
end

function tbManager:CheckEnterCondition(nInstancingTemplateId, nPlayerId)
	local tbSetting = self:GetInstancingSetting(nInstancingTemplateId);
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return 0, "Người chơi không tồn tại";
	end
	
	if (pPlayer.nFaction <= 0) then
		return 0, pPlayer.szName.."Là người chơi chữ trắng!";
	end
	
	if (pPlayer.nLevel < tbSetting.nMinLevel) then
		return 0, pPlayer.szName.." (đẳng cấp) nhỏ hơn"..tbSetting.nMinLevel;
	end
	
	if (pPlayer.nLevel > tbSetting.nMaxLevel) then
		return 0, pPlayer.szName.." (đẳng cấp) lớn hơn"..tbSetting.nMaxLevel;
	end
	
	local nHaveTask = 0;
	for _, nTaskId in ipairs(tbSetting.tbHaveTask) do
		if (Task:HaveTask(pPlayer, nTaskId) == 1) then
			nHaveTask = 1;
			break;
		end
	end
	
	if (nHaveTask ~= 1 and #tbSetting.tbHaveTask > 0) then
		return 0, pPlayer.szName ..tbSetting.szNoTaskMsg;
	end
	
	return 1;
end


function tbManager:CheckRegisterCondition(nInstancingTemplateId, nPlayerId)
	local tbSetting = self:GetInstancingSetting(nInstancingTemplateId);
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return 0, "Người chơi không tồn tại";
	end
	
	
	if (pPlayer.nFaction <= 0) then
		return 0, pPlayer.szName.."Là người chơi chữ trắng!";
	end
	
	if (pPlayer.nLevel < tbSetting.nMinLevel) then
		return 0, pPlayer.szName.." (đẳng cấp) nhỏ hơn"..tbSetting.nMinLevel;
	end
	
	if (pPlayer.nLevel > tbSetting.nMaxLevel) then
		return 0, pPlayer.szName.." (đẳng cấp) lớn hơn"..tbSetting.nMaxLevel;
	end
	
	if (self:CheckTaskLimit(pPlayer, tbSetting.nInstancingEnterLimit_D) ~= 1) then
		return 0, pPlayer.szName.."Số lần vào phó bản hôm nay đã đến giớn hạn.";
		
	end
	
	local tbNow	= os.date("*t", GetTime());
	if (self:Time2Int(tbNow) == pPlayer.GetTask(tbSetting.tbInstancingTimeId.nTaskGroup, tbSetting.tbInstancingTimeId.nTaskId)) then
		return 0, pPlayer.szName.."Lúc này đã báo danh rồi";
	end
	
	local nHaveTask = 0;
	for _, nTaskId in ipairs(tbSetting.tbHaveTask) do
		if (Task:HaveTask(pPlayer, nTaskId) == 1) then
			nHaveTask = 1;
			break;
		end
	end
	if (nHaveTask ~= 1 and #tbSetting.tbHaveTask > 0) then
		return 0, pPlayer.szName ..tbSetting.szNoTaskMsg;
	end
	
	local nNum = pPlayer.GetTask(StatLog.StatTaskGroupId , 5) + 1;
	pPlayer.SetTask(StatLog.StatTaskGroupId , 5, nNum);
	return 1;
end


function tbManager:OnLoadMapFinish(nMapId, nMapTemplateId, nInstancingTemplateId)
	if (#self.tbWaitQueue == 0) then
		assert(false);
		return;
	end
	local tbSetting = self:GetInstancingSetting(nInstancingTemplateId);
	for nIndex = 1, #self.tbWaitQueue do
		if (nInstancingTemplateId == self.tbWaitQueue[nIndex].nInstancingTemplateId) then
			local pPlayer = KPlayer.GetPlayerObjById(self.tbWaitQueue[nIndex].nPlayerId);
			if (pPlayer and pPlayer.nTeamId ~= 0) then
				self.tbInstancingUsable[nInstancingTemplateId][#self.tbInstancingUsable[nInstancingTemplateId] + 1] = {MapTemplateId = nMapTemplateId, MapId = nMapId, Free = 0};
				self:OpenMap(nMapId, nInstancingTemplateId, pPlayer.nId);
				table.remove(self.tbWaitQueue, nIndex);
				break;
			else
				self.tbInstancingUsable[nInstancingTemplateId][#self.tbInstancingUsable[nInstancingTemplateId] + 1] = {MapTemplateId = nMapTemplateId, MapId = nMapId, Free = 1};
				table.remove(self.tbWaitQueue, nIndex);
				break;
			end
		end
	end
end


function tbManager:GetFreeInstancing(nInstancingTemplateId)
	if (not self.tbInstancingUsable[nInstancingTemplateId]) then
		self.tbInstancingUsable[nInstancingTemplateId] = {};
		return;
	end
	
	for _, tbInstancing in ipairs(self.tbInstancingUsable[nInstancingTemplateId]) do
		if (tbInstancing.Free == 1) then
			return tbInstancing.MapId;
		end
	end
end


function tbManager:IsArmyCampInstancingMap(nMapTemplateId)
	for _, tbSetting in pairs(self.tbSettings) do
		if (tbSetting.nInstancingMapTemplateId == nMapTemplateId) then
			return 1;
		end
	end
	
	return 0;
end

function tbManager:GetNpcLevel(pPlayer)
	local tbDay2Level = {
			[1] = {80, 90},
			[2] = {120, 100},
			[3] = {210, 110},
			[4] = {390, 120},
			[5] = {720, 130},
		};
	local nNowTime = GetTime();
	local nNowDay	= Lib:GetLocalDay(nNowTime);
	local nOpenTime = KGblTask.SCGetDbTaskInt(DBTASD_SERVER_STARTTIME);
	local nOpenDay	= Lib:GetLocalDay(nOpenTime);
	local nDetDay	= nNowDay - nOpenDay;
	local nNpcLevel = 0;
	local nLimitLevel	= 0;
	for _, tbInfo in ipairs(tbDay2Level) do
		if (nDetDay < tbInfo[1]) then
			break;
		end
		nLimitLevel = tbInfo[2];
	end
	if (nOpenTime <= 0 or nLimitLevel <= 0) then
		nLimitLevel = 90;
	end
	if (not pPlayer) then
		return nLimitLevel;
	end
	local tbTeammateList, nMemCount = pPlayer.GetTeamMemberList();
	if (tbTeammateList) then
		for _, pPlayer in ipairs(tbTeammateList) do
			nNpcLevel = nNpcLevel + pPlayer.nLevel;
		end
		if (nMemCount > 0) then
			nNpcLevel = math.ceil(nNpcLevel/nMemCount);
		end
	end
	if (nNpcLevel < nLimitLevel) then
		nNpcLevel = nLimitLevel;
	end
	return nNpcLevel;
end

function tbManager:OpenMap(nMapId, nInstancingTemplateId, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	assert(pPlayer);
	
	ResetMapNpc(nMapId);
	local tbInstancingBase = self:GetInstancingBase(nInstancingTemplateId);
	local tbInstancing = Lib:NewClass(tbInstancingBase);
	tbInstancing.nMapId = nMapId;
	tbInstancing.nTeamId = pPlayer.nTeamId;
	tbInstancing.nOpenerId = nPlayerId;
	tbInstancing.szOpenerName = pPlayer.szName;
	tbInstancing.nPlayerCount = 0;
	tbInstancing.tbOpenTime	= os.date("*t", GetTime());
	tbInstancing.nRegisterMapId = pPlayer.nMapId;
	tbInstancing.szRegisterMapName = Task:GetMapName(tbInstancing.nRegisterMapId);
	tbInstancing.nNpcLevel = self:GetNpcLevel(pPlayer);
	local tbInstancingList = self:GetRunInstancingList();
	assert(not tbInstancingList[nMapId]);
	tbInstancingList[nMapId] = tbInstancing;
	self:BindTeam2Instancing(nPlayerId, nInstancingTemplateId, tbInstancing.tbOpenTime, nMapId, pPlayer.nMapId);
	tbInstancing:OnOpen();
	
	
	for _, tbInstancing in ipairs(self.tbInstancingUsable[nInstancingTemplateId]) do
		if (tbInstancing.MapId == nMapId) then
			tbInstancing.Free = 0;
			break;
		end
	end
	
	SpecialEvent.ExtendEvent:DoExecute("Open_ArmyCamp", nMapId, nInstancingTemplateId);
	
	self.tbCampState = self.tbCampState or {};
	local nToday = tonumber(GetLocalDate("%Y%m%d"));
	self.tbCampState[nToday] = self.tbCampState[nToday] or {};
	self.tbCampState[nToday][nInstancingTemplateId] = self.tbCampState[nToday][nInstancingTemplateId] or {};
	local tbThisCampState = self.tbCampState[nToday][nInstancingTemplateId];
	tbThisCampState[tonumber(tbInstancing.tbOpenTime.hour)] = tbThisCampState[tonumber(tbInstancing.tbOpenTime.hour)] or {};
	local tbThisHourState = tbThisCampState[tonumber(tbInstancing.tbOpenTime.hour)];
	tbThisHourState.nTeamCount = tbThisHourState.nTeamCount or 0;
	tbThisHourState.nTeamCount = tbThisHourState.nTeamCount + 1;
end

function tbManager:BindTeam2Instancing(nPlayerId, nInstancingTemplateId, tbOpenTime, nMapId, nRegisterMapId)
	local pCaptain = KPlayer.GetPlayerObjById(nPlayerId);
	assert(pCaptain);
	local tbTeammateList, _ = pCaptain.GetTeamMemberList();
	for _, pPlayer in ipairs(tbTeammateList) do
		if (pPlayer.nMapId == nRegisterMapId) then
			if (self:CheckRegisterCondition(nInstancingTemplateId, pPlayer.nId) == 1) then
				self:BindPlayer2Instancing(pPlayer.nId, nInstancingTemplateId, tbOpenTime, nMapId, nRegisterMapId);
			end
		end
	end
end


function tbManager:BindPlayer2Instancing(nPlayerId, nInstancingTemplateId, tbOpenTime, nMapId, nRegisterMapId)
	local tbSetting = self:GetInstancingSetting(nInstancingTemplateId);
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if (not pPlayer) then
		return;
	end
	
	pPlayer.DirectSetTask(tbSetting.tbInstancingMapId.nTaskGroup, tbSetting.tbInstancingMapId.nTaskId, nMapId, 1); 									-- 玩家记录所属的FB地图Id
	pPlayer.DirectSetTask(tbSetting.tbInstancingTimeId.nTaskGroup, tbSetting.tbInstancingTimeId.nTaskId, self:Time2Int(tbOpenTime), 1);	-- 玩家记录自己和副本绑定的时间
	pPlayer.SetTask(tbSetting.nRegisterMapId.nTaskGroup, tbSetting.nRegisterMapId.nTaskId, nRegisterMapId);										-- 玩家记录他的报名地图Id
end


function tbManager:CloseMap(nMapId)
	local tbInstancingList = self:GetRunInstancingList();
	assert(tbInstancingList[nMapId]);
	local tbInstancing = tbInstancingList[nMapId];
	local nInstancingTemplateId = tbInstancing.nInstancingTemplateId;
	for _, tbInstancing in ipairs(self.tbInstancingUsable[nInstancingTemplateId]) do
		if (tbInstancing.MapId == tbInstancingList[nMapId].nMapId) then
			tbInstancing.Free = 1;
			break;
		end
	end
	
	tbInstancingList[nMapId] = nil;
end


function tbManager:GetRunInstancingList()
	if (not self.tbInstancingList) then
		self.tbInstancingList = {};
	end
	
	return self.tbInstancingList;
end

function tbManager:GetInstancing(nMapId)
	return self.tbInstancingList[nMapId];
end


function tbManager:GetInstancingSetting(nInstancingTemplateId)
	assert(self.tbSettings[nInstancingTemplateId])
	return self.tbSettings[nInstancingTemplateId];
end

function tbManager:GetRevivePos(nInstancingTemplateId)
	local tbSetting = self:GetInstancingSetting(nInstancingTemplateId);
	return unpack(tbSetting.tbRevivePos);
end

function tbManager:GetInstancingExistTime(nInstancingTemplateId)
	local tbSetting = self:GetInstancingSetting(nInstancingTemplateId);
	return tbSetting.nInstancingExistTime;
end

function tbManager:GetMinPlayerCount(nInstancingTemplateId)
	local tbSetting = self:GetInstancingSetting(nInstancingTemplateId);
	return tbSetting.nMinPlayer;
end

function tbManager:GetMaxPlayerCount(nInstancingTemplateId)
	local tbSetting = self:GetInstancingSetting(nInstancingTemplateId);
	return tbSetting.nMaxPlayer;
end

function tbManager:GetLevelMinLimit(nInstancingTemplateId)
	local tbSetting = self:GetInstancingSetting(nInstancingTemplateId);
	return tbSetting.nMinLevel;
end

function tbManager:GetLevelMaxLimit()
	local tbSetting = self:GetInstancingSetting(nInstancingTemplateId);
	return tbSetting.nMaxLevel;
end

function tbManager:GetRegisterWaitTime(nInstancingTemplateId)
	if (not nInstancingTemplateId) then
		nInstancingTemplateId = 1;
	end
	
	local tbSetting = self:GetInstancingSetting(nInstancingTemplateId);
	local nNowTime	= GetTime();
	local tbToday	= os.date("*t", nNowTime);
	local nHour 	= tbToday.hour;
	local nNextHour	= 0;
	local nMin		= tbToday.min;
	local bOK		= 0;
	
	for _, nOpenHour in ipairs(tbSetting.tbOpenHour) do
		if (nOpenHour == nHour and nMin <= tbSetting.tbOpenDuration) then
			return 0;
		elseif (nOpenHour > nHour) then
			return (60 - nMin) + (nOpenHour - nHour -1) * 60;
		end
	end
	
	return (tbSetting.tbOpenHour[1] + 24 - nHour -1) * 60 + (60 - nMin);
end

function tbManager:OpenArmyCampUi(nPlayerId, nTimerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	assert(pPlayer);

	if nTimerId <= 0 then
		return 0;
	end
	local nLastFrameTime = tonumber(Timer:GetRestTime(nTimerId));
	local szMsg = "<color=green>Phó bản kết thúc còn<color> <color=white>%s<color>"
	Dialog:SetBattleTimer(pPlayer,  szMsg, nLastFrameTime);
	Dialog:ShowBattleMsg(pPlayer,  1,  0); --开启界面
		
end

function tbManager:CloseArmyCampUi(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	assert(pPlayer);	
	Dialog:ShowBattleMsg(pPlayer,  0,  0); -- 关闭界面
end

function tbManager:GetGutTaskTimesThisWeek(nInstancingTemplateId, nPlayerId)
	local pPlayer = nil;
	if (MODULE_GAMECLIENT) then
		pPlayer = me;
	else
		pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	end
	
	if (not pPlayer) then
		return;
	end
	
	if (not nInstancingTemplateId) then
		nInstancingTemplateId = 1;
	end
	
	local tbSetting = self:GetInstancingSetting(nInstancingTemplateId);
	
	return pPlayer.GetTask(tbSetting.nJuQingTaskLimit_W.nTaskGroup, tbSetting.nJuQingTaskLimit_W.nTaskId);
end

function tbManager:GetCurOpenInstancingNum(nHour)
	local tbRunInstancingList = self:GetRunInstancingList();
	local nCount = 0;
	for _, Instancing in pairs(tbRunInstancingList) do
		if (Instancing.tbOpenTime.hour == nHour) then
			nCount = nCount + 1;
		end
	end
	
	return nCount;
end

function tbManager:GetRegisterTeamNum(nDate, nHour, nTemplateId)
	local nCount = 0;
	if (self.tbCampState) then
		for nIterDate, tbDateCampState in pairs(self.tbCampState) do
			if (not nDate or nIterDate == nDate) then
				for nInstanceId, tbInstanceState in pairs(self.tbCampState[nIterDate]) do
					if (not nTemplateId or nTemplateId == nInstanceId) then
						for nH, tbThisHourState in pairs(tbInstanceState) do
							if (not nHour or nHour == nH) then
								if (tbThisHourState) then
									nCount = nCount + tbThisHourState.nTeamCount or 0;
								end
							end
						end
					end
				 end
			end
		end
	end

	return nCount;
end

function tbManager:GetDailyTaskTimesThisWeek(nInstancingTemplateId, nPlayerId)
	local pPlayer = nil;
	
	if (MODULE_GAMECLIENT) then
		pPlayer = me;
	else
		pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	end

	if (not pPlayer) then
		return;
	end
	
	if (not nInstancingTemplateId) then
		nInstancingTemplateId = 1;
	end
	
	local tbSetting = self:GetInstancingSetting(nInstancingTemplateId);
	
	return pPlayer.GetTask(tbSetting.nDailyTaskLimit_W.nTaskGroup, tbSetting.nDailyTaskLimit_W.nTaskId);
end

function tbManager:EnterInstancingThisDay(nInstancingTemplateId, nPlayerId)
	local pPlayer = nil;
	if (MODULE_GAMECLIENT) then
		pPlayer = me;
	else
		pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	end

	assert(pPlayer);
	
	if (not nInstancingTemplateId) then
		nInstancingTemplateId = 1;
	end
	
	local tbSetting = self:GetInstancingSetting(nInstancingTemplateId);
	local nTimes = pPlayer.GetTask(tbSetting.nInstancingEnterLimit_D.nTaskGroup, tbSetting.nInstancingEnterLimit_D.nTaskId);
	
	return nTimes;
end


function tbManager:GetBingShuReadTimesThisDay(nPlayerId)
	local pPlayer;
	if (MODULE_GAMECLIENT) then
		pPlayer = me;
	else
		pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	end
	
	assert(pPlayer);
	
	local nReadCount = 0;
	if (pPlayer.nLevel < 110) then
		nReadCount = 1 - pPlayer.GetTask(1022, 118);
	else
		nReadCount = 1 - pPlayer.GetTask(1022, 164);
	end;
	return nReadCount;
end

function tbManager:JiGuanShuReadedTimesThisDay(nPlayerId)
	local pPlayer;
	if (MODULE_GAMECLIENT) then
		pPlayer = me;
	else
		pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	end
	
	assert(pPlayer);
	
	local nReadCount = 0;
	if (pPlayer.nLevel < 110) then
		nReadCount = 1 - pPlayer.GetTask(1022, 131);
	else
		nReadCount = 1 - pPlayer.GetTask(1022, 166);
	end;
	return nReadCount;
end


function tbManager:CheckTaskLimit(pPlayer, tbTask)
	if (pPlayer.GetTask(tbTask.nTaskGroup, tbTask.nTaskId) >= tbTask.nLimitValue) then
		return 0;
	end
	
	return 1;
end


function tbManager:WeekEvent()
	me.SetTask(1024, 52, 0, 1);
	me.SetTask(1024, 51, 0, 1);
	me.SetTask(1024, 55, 0, 1);
	me.SetTask(1024, 58, 0, 1);
	me.SetTask(1022, 174, 0, 1);
	me.SetTask(1022, 180, 0, 1);
	me.SetTask(1022, 187, 1, 1);
end

function tbManager:DailyEvent()
	if (me.nLevel < 110) then
		me.SetTask(1022, 118, 1, 1);	-- 读兵书标记
		me.SetTask(1022, 131, 1, 1);	-- 机关书
		me.SetTask(1022, 132, 1, 1);	
	elseif (me.nLevel > 109 and me.nLevel < 130) then
		me.SetTask(1022, 164, 1, 1);    -- 读兵书标记
		me.SetTask(1022, 166, 1, 1);    -- 机关书
		me.SetTask(1022, 171, 1, 1);
	else
		me.SetTask(1022, 181, 1, 1);    -- 读兵书标记
		me.SetTask(1022, 183, 1, 1);    -- 机关书
		me.SetTask(1022, 185, 1, 1);	
	end;
	
	me.SetTask(2043, 1, 0, 1);
	me.SetTask(1022, 173, 1, 1);
end

function tbManager:Warring(pPlayer, szMsg, nTime)
	if (MODULE_GAMESERVER) then
		pPlayer.CallClientScript({"Ui:ServerCall", "UI_TASKTIPS", "Begin", szMsg, nTime});		
	end
end


function tbManager:ShowTip(pPlayer, szMsg, nTime)
	if (MODULE_GAMESERVER) then
		pPlayer.CallClientScript({"Ui:ServerCall", "UI_TASKTIPS", "Begin", szMsg, nTime});		
	end
end

function tbManager:Tip2MapPlayer(nMapId, szMsg, nTime)
	local tbPlayList, nCount = KPlayer.GetMapPlayer(nMapId);
	for _, pPlayer in ipairs(tbPlayList) do
		self:ShowTip(pPlayer, szMsg, nTime);
	end
end

function tbManager:Time2Int(tbTime)
	local nYear = tbTime.year or 0;
	local nDay	= tbTime.yday or 0;
	local nHour = tbTime.hour or 0;
	return	nYear * 1000 * 100 + nDay * 100 + nHour;
end

PlayerSchemeEvent:RegisterGlobalDailyEvent({Task.tbArmyCampInstancingManager.DailyEvent, Task.tbArmyCampInstancingManager});

PlayerSchemeEvent:RegisterGlobalWeekEvent({Task.tbArmyCampInstancingManager.WeekEvent, Task.tbArmyCampInstancingManager});
