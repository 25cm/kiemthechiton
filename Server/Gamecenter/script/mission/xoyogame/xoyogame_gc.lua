
-- 逍遥谷GC逻辑
function XoyoGame:InitGC()
	self.tbData = {}
end

function XoyoGame:CreateManager_GC(nMapId)
	if not XoyoGame.MANAGER_GROUP[nMapId] then
		return 0;
	end
	local tbCurData = {}
	for i, nGameId in pairs(self.MANAGER_GROUP[nMapId]) do
		tbCurData[nGameId] = self.tbData[nGameId];
	end
	GlobalExcute {"XoyoGame:CreateManager_GS2", nMapId, tbCurData};
end

function XoyoGame:SyncGameData_GC(nCityMapId, nData)
	self.tbData[nCityMapId] = nData;
	GlobalExcute{"XoyoGame:SyncGameData_GS2", nCityMapId, nData};
end

function XoyoGame:ReduceTeam_GC(nGameId, nData)
	self.tbData[nGameId] = nData;
	GlobalExcute{"XoyoGame:ReduceTeam_GS2", nGameId};
end

-- 开始新的一轮闯关
function XoyoGame:StartNewRound()
	GlobalExcute{"XoyoGame:LockManager", 1};		-- 先锁所有的manager
	Timer:Register(self.LOCK_MANAGER_TIME * Env.GAME_FPS, self.StartGame_GC, self)	-- 一定时间后执行开始操作
end

function XoyoGame:StartGame_GC()
	GlobalExcute{"XoyoGame:StartGame_GS2"};
	return 0;
end

-- 每天更新逍遥排行榜数据
function XoyoGame:ChallengeDailyRankUpdate()
	local tbTime = os.date("*t", GetTime());
	if tbTime.day == 1 then
		PlayerHonor:UpdateXoyoLadder(1);
		SetXoyoAwardResult();
		ClearXoyoLadderData();
		KGblTask.SCSetDbTaskInt(DBTASK_XOYO_FINAL_LADDER_MONTH, tbTime.year*100+tbTime.month);
	else
		PlayerHonor:UpdateXoyoLadder(0);
	end
end

XoyoGame:InitGC();
