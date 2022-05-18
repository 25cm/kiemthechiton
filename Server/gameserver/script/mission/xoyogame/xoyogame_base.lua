--
-- 逍遥谷闯关活动脚本

-- Trap点加载
XoyoGame.BaseGame = Mission:New();
local BaseGame = XoyoGame.BaseGame;

local tbTrap = {}
-- 玩家触发trap点
function tbTrap:OnPlayerTrap(szClassName)
	if not self.tbGame then
		return 0;
	end
	
	local tbRoom = self.tbGame:GetPlayerRoom(me.nId);
	if tbRoom and tbRoom.OnPlayerTrap then
		tbRoom:OnPlayerTrap(szClassName);
	elseif self.tbGame.tbTrap[szClassName] then
		me.NewWorld(me.nMapId, unpack(self.tbGame.tbTrap[szClassName]));
	end
end

-- 定义玩家进入地图事件
function tbTrap:OnEnter()
	if (not self.tbGame) or (not self.nMapId) then
		return 0;
	end
	self.tbGame:JoinNextGame(me);
end

-- 定义玩家离开地图事件
function tbTrap:OnLeave()

end

-- 初始化地图
function BaseGame:MapInit(nMapId)
	local tbMapTrap = Map:GetClass(nMapId);
	for szFnc in pairs(tbTrap) do			-- 复制函数
		tbMapTrap[szFnc] = tbTrap[szFnc];
	end
	tbMapTrap.tbGame = self;
	tbMapTrap.nMapId = nMapId;
end

-- 初始化关卡 
function BaseGame:InitGame(tbMap, nCityMapId)
	for i = 1, #tbMap do
		self:MapInit(tbMap[i]);
	end
	self.nGameId = nCityMapId;
	self.tbMap = tbMap;
	self.tbRoom = {};			-- 房间对象表
	self.tbTrap = {};			-- Trap点传送
	self.tbTeam = {};			-- 队伍信息
	self.tbPlayer = {};			-- 玩家所在房间信息
	self.tbNextGameTeam = {};
	self.nNextTeamCount = 0;
	self.tbAddXoyoTimesPlayerId = {};   -- 已扣除逍遥次数的玩家id，防刷
	
	self.tbMisCfg = 
	{
		tbLeavePos	= {[1] = {nCityMapId, unpack(XoyoGame.LEAVE_POS[nCityMapId])}},	-- 离开坐标
		tbDeathRevPos = {{tbMap[1], 49088 / 32,	74208 / 32}},		-- 死亡重生点
		nDeathPunish = 1,
		nPkState = Player.emKPK_STATE_PRACTISE,
		nInLeagueState = 1,
		nLogOutRV = Mission.LOGOUTRV_DEF_XOYO,
	}
	self:Open();
end

-- 报名下次闯关(不检查资格,资格检查在npc逻辑上做)  -- TODO
function BaseGame:JoinNextGame(pPlayer)
	local nTeamId = pPlayer.nTeamId;
	if self.tbTeam[nTeamId] then
		return 0;
	end
	if nTeamId ~= 0 then
		if self.tbNextGameTeam[nTeamId] == nil and self.nNextTeamCount < XoyoGame.MAX_TEAM then
			self.tbNextGameTeam[nTeamId] = 1
			self.nNextTeamCount = self.nNextTeamCount + 1;
			KStatLog.ModifyAdd("xoyogame", "Tổ đội tham gia Tiêu Dao Cốc trong ngày", "Tổng", 1);
		elseif self.tbNextGameTeam[nTeamId] then
			self.tbNextGameTeam[nTeamId] = self.tbNextGameTeam[nTeamId] + 1;
		else
			pPlayer.Msg("Tổ đội tham gia đủ số lượng!")
		end
	else
		print("Đã vào Tiêu Dao Cốc", pPlayer.szName);
		Dbg:WriteLog("XoyoGame", "Đã vào Tiêu Dao Cốc");
		Dialog:SendBlackBoardMsg(pPlayer, "Nguy hiểm! Đã vào trong Tiêu Dao Cốc, về thành trong 5 giây!");
		Timer:Register(5 * Env.GAME_FPS, self.QuiteMap, self, pPlayer.nId);
		return 0;
	end
	pPlayer.GetTempTable("XoyoGame").tbGame = self;
	self:JoinPlayer(pPlayer, 1);
end

function BaseGame:QuiteMap(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if pPlayer then
		pPlayer.LeaveTeam();
		pPlayer.TeamDisable(0);
		pPlayer.ForbidExercise(0);
		pPlayer.ForbidEnmity(0);
		pPlayer.NewWorld(unpack(self.tbMisCfg.tbLeavePos[1]));
	end
	return 0;
end

function BaseGame:OnJoin(nGroupId)
	me.TeamDisable(1);
	me.ForbidExercise(1);
	me.ForbidEnmity(1);
	local nLastFrameTime = 0
	if self.nTimerId and self.nTimerId > 0 then
		nLastFrameTime = tonumber(Timer:GetRestTime(self.nTimerId));
	else
		local nCurTime = tonumber(os.date("%H%M", GetTime()));
		if (nCurTime >= XoyoGame.START_TIME1 and nCurTime < XoyoGame.END_TIME1) or 
			(nCurTime >= XoyoGame.START_TIME2 and nCurTime < XoyoGame.END_TIME2) then
			-- 计算下一场的开启剩余时间
			nLastFrameTime = ((30 - (nCurTime % 100) % 30) * 60 - tonumber(os.date("%S", GetTime())) 
				+ XoyoGame.LOCK_MANAGER_TIME)* Env.GAME_FPS;
		end
	end
	if nLastFrameTime > 0 then
		Dialog:SetBattleTimer(me,  "<color=green>Thời gian báo danh còn: %s<color>", nLastFrameTime);
		Dialog:SendBattleMsg(me, "");
		Dialog:ShowBattleMsg(me,  1,  0);
	end
end

function BaseGame:LogOutRV()
	-- 拔萝卜用到了打雪仗技能
	for _, nSkillId in pairs(Esport.tbTemplateId2Skill) do
		if me.IsHaveSkill(nSkillId) == 1 then
			me.DelFightSkill(nSkillId);
		end
	end
	
	for _, nBuffId in pairs(Esport.tbTemplateId2Buff) do
		if me.GetSkillState(nBuffId) > 0 then
			me.RemoveSkillState(nBuffId);
		end
	end
	
	me.RemoveSkillState(1450); -- 头顶的萝卜状态
	XoyoGame.RoomCarrot.DeleteCarrotInBag(me);
end

-- 开始一轮闯关
function BaseGame:StartNewGame()
	local tbTemp = {};
	self.tbAddXoyoTimesPlayerId = {};
	self:CalcRoomOccupy();
	for nTeamId, nCount in pairs(self.tbNextGameTeam) do
		table.insert(tbTemp, nTeamId);
		self.tbTeam[nTeamId] = {};
		self.tbTeam[nTeamId].nCurRoomCount = 0; -- 玩过几个房间
	end
	self:AddXoyoTimes(tbTemp);
	if #tbTemp > 0 then
		self:RandomRoom(tbTemp, 1);
	end
	self.tbNextGameTeam = {};
	self.nNextTeamCount = 0;
	GCExcute{"XoyoGame:SyncGameData_GC", self.nGameId, 0}
	-- 给玩家一个很假的计时
	self.nTimerId = Timer:Register(XoyoGame.START_GAME_TIME * Env.GAME_FPS, self.CloseTimer, self);
end

function BaseGame:AddXoyoTimes(tbTeam)
	local fnExcute = function (pPlayer)
		self.tbAddXoyoTimesPlayerId[pPlayer.nId] = 1;
		local nTimes = XoyoGame:GetPlayerTimes(pPlayer)
		if nTimes > 0 then
			pPlayer.SetTask(XoyoGame.TASK_GROUP, XoyoGame.TIMES_ID, nTimes - 1);
		else
			Dbg:WriteLog("xoyogame", "Error Nếu số của Thung lũng Xiaoyao là 0, bạn vẫn có thể vào TDC！");
		end
		pPlayer.AddOfferEntry(10, WeeklyTask.GETOFFER_TYPE_XOYOGAME);	-- 参加逍遥谷奖励10点贡献度
		
		-- 记录玩家参加逍遥谷的次数
		Stats.Activity:AddCount(pPlayer, Stats.TASK_COUNT_XOYOGAME, 1);
		
		-- KStatLog.ModifyAdd("xoyogame", string.format("本日参加了第%d次逍遥谷的人数", nTimes + 1), "Tổng", 1);
		
		-- 师徒成就：参加逍遥谷
		Achievement:FinishAchievement(pPlayer.nId, Achievement.XOYOGAME);
	end
	XoyoGame.BaseRoom:TeamPlayerExcute(fnExcute, tbTeam);
end

function BaseGame:CloseTimer()
	self.nTimerId = nil;
	return 0;
end

-- 看看队里有没有没扣逍遥次数的玩家
function BaseGame:CheckTeamValidity(nTeamId)
	local tbMember, nCount = KTeam.GetTeamMemberList(nTeamId);
	local nValidPlayerNum = 0;
	if not tbMember then
		print("Xoyogame","BaseGameKhông thể tìm thấy đội");
		return 0;
	end
	for _, nPlayerId in ipairs(tbMember) do
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if pPlayer then
			if not self.tbAddXoyoTimesPlayerId[pPlayer.nId] then
				pPlayer.Msg("Ngươi là ai mà dám đến Tiêu Dao Cốc? Đừng tưởng rằng lão phu lớn tuổi, mắt không còn nhìn thông.");
				if  XoyoGame:GetPlayerGame(pPlayer.nId) == self then
					self:KickPlayer(pPlayer);
				else
					Setting:SetGlobalObj(pPlayer);
					self:OnLeave();
					Setting:RestoreGlobalObj();
					self:QuiteMap(pPlayer.nId);
				end
			else
				nValidPlayerNum = nValidPlayerNum + 1;
			end
		end
	end
	if nValidPlayerNum == 0 then
		return 0;
	else
		return 1;
	end
end

function BaseGame:FilterTeam(tbTeam)
	local tbRes = {};
	for _, nTeamId in ipairs(tbTeam) do
		if self:CheckTeamValidity(nTeamId) == 1 then
			table.insert(tbRes, nTeamId);
		end
	end
	
	return tbRes;
end

-- 
function BaseGame:RandomRoom(tbTeam, nRoomLevel)
	tbTeam = self:FilterTeam(tbTeam);
	local tbTemp = {};
	local tbNewRooms = {};
	local tbRoomWeight = {};
	local nTotalWeight = 0;
	local nTeamCount = #tbTeam;
	-- 打乱队伍
	for i = 1, nTeamCount do
		local nRandom = MathRandom(nTeamCount);
		tbTeam[i], tbTeam[nRandom] = tbTeam[nRandom], tbTeam[i]
	end
	-- 寻找合适当前人数的房间组合
	local tbXoyoRoomWeight = XoyoGame:GetRoomWeight()[nRoomLevel];
	for nRoomId, tbWeightInfo in pairs(tbXoyoRoomWeight) do
		if not self.tbRoom[nRoomId] and tbWeightInfo.nWeight > 0 then 		-- 房间没被占用
			nTotalWeight = nTotalWeight + tbWeightInfo.nWeight;
			-- 按房间参与人数再分组
			if not tbRoomWeight[tbWeightInfo.nTeams] then
				tbRoomWeight[tbWeightInfo.nTeams] = {};
			end
			tbRoomWeight[tbWeightInfo.nTeams][nRoomId] = tbWeightInfo;
		end
	end
	-- 随机房间
	local nWhileTimes = 0;
	while (nTeamCount > 0) do
		nWhileTimes = nWhileTimes + 1;
		local nRandom = MathRandom(nTotalWeight);
		local nSumWeight = 0;
		local nRoomId = nil;
		local nTeams = nil;
		local nWeight = nil;
		
		for _nTeams, _tbWeight in pairs(tbRoomWeight) do
			for _nRoomId, _tbInfo in pairs(_tbWeight) do
				nSumWeight = nSumWeight + _tbInfo.nWeight
				if nSumWeight >= nRandom then
					if _nTeams <= nTeamCount then
						nRoomId, nTeams, nWeight = _nRoomId, _nTeams, _tbInfo.nWeight;
					end
					break;
				end
			end
			if nRoomId then break end;
		end
		
		if nRoomId then
			local tbTemp = {}
			tbTemp.nRoomId = nRoomId;
			tbTemp.tbTeam = {}
			for i = 0, nTeams - 1 do
				table.insert(tbTemp.tbTeam, tbTeam[nTeamCount - i]);
				Dbg:WriteLog("XoyoGame", tbTeam[nTeamCount - i], "Mục nhập được chỉ định"..tbTemp.nRoomId.."Phòng số！")
			end
			local nRet = self:AddRoom(tbTemp.nRoomId, unpack(tbTemp.tbTeam));	
			if nRet == 1 then
				table.insert(tbNewRooms, nRoomId);
			end
			tbRoomWeight[nTeams][nRoomId] = nil;
			nTotalWeight = nTotalWeight - nWeight;
			nTeamCount = nTeamCount - nTeams;
		end
		if nWhileTimes >= 200 then
			for i = 1, nTeamCount do
				self:KickTeam(tbTeam[i], nil, "Không tìm thấy phòng thích hợp");
			end
			Dbg:WriteLog("[XoyoGame]Random Room nWhileTimes >= 100");
			break;
		end
	end
	
	-- 结束循环
	local nTimerId = Timer:Register(XoyoGame.ROOM_TIME[nRoomLevel] * Env.GAME_FPS, self.EndRoomTime, self, tbNewRooms, nRoomLevel);
	for _, nRoomId in ipairs(tbNewRooms) do
		if self.tbRoom[nRoomId] then
			self.tbRoom[nRoomId].nTimerId = nTimerId;
		end
	end
	self.nEndRoomTimerId = nTimerId;
end

function BaseGame:EndRoomTeamProcess(tbTeams, tbNextLevel, nRoomId, nIsWinner)
	for _, nTeamId in pairs(tbTeams) do
		if self.tbTeam[nTeamId] then
			self.tbTeam[nTeamId].nCurRoomCount = self.tbTeam[nTeamId].nCurRoomCount + 1;
			local tbMember, nCount = KTeam.GetTeamMemberList(nTeamId);
			if self.tbTeam[nTeamId].nCurRoomCount >= XoyoGame.PLAY_ROOM_COUNT or nCount == 0 then
				self:KickTeam(nTeamId, 1);
			else
				table.insert(tbNextLevel, nTeamId);
			end

			if nIsWinner == 1 then
				Dbg:WriteLog("XoyoGame", nTeamId, nRoomId .."Vào phòng thành công");
			else
				Dbg:WriteLog("XoyoGame", nTeamId, nRoomId .."Vào phòng thất bại");
			end
			

			--失败LOG统计
			if XoyoGame.LOG_ATTEND_OPEN == 1  and nIsWinner ~= 1 then
				if not tbMember then
					return;
				end
				local szName = "";
				for i = 1, #tbMember do
					local pPlayer = KPlayer.GetPlayerObjById(tbMember[i]);	
					if pPlayer then
						szName = szName.."  "..pPlayer.szName;
					end
				end
				Dbg:WriteLog("xoyogame", "attend Người chơi:"..szName, nRoomId .."Số phòng không thành công", "chi phí thời gian:0");
			end				
		end
	end	
end


-- 房间时间到
function BaseGame:EndRoomTime(tbRoomsId, nLevel)
	local tbUpgrateTeam = {};
	local tbStayTeam 	= {};
	for i = 1, #tbRoomsId do
		if self.tbRoom[tbRoomsId[i]] then
			local tbWinner, tbLoser = self.tbRoom[tbRoomsId[i]]:CheckWinner();
			self:EndRoomTeamProcess(tbWinner, tbUpgrateTeam, tbRoomsId[i], 1); -- 队伍晋级
			self:EndRoomTeamProcess(tbLoser, tbStayTeam, tbRoomsId[i], 0); -- 留下来
			self.tbRoom[tbRoomsId[i]]:Close();
			self.tbRoom[tbRoomsId[i]] = nil;
		end
	end
	if #tbUpgrateTeam > 0 and nLevel < XoyoGame.ROOM_MAX_LEVEL then
		KStatLog.ModifyAdd("xoyogame", string.format("Đến hôm nay%sThứ hạng trong phòng", nLevel + 1), "Tổng", #tbUpgrateTeam);
		self:RandomRoom(tbUpgrateTeam, nLevel + 1);		-- 队伍房间升级
	end
	if #tbStayTeam > 0 then
		self:RandomRoom(tbStayTeam, nLevel)
	end
	self.nEndRoomTimerId = nil;
	return 0;
end

-- 剔除队伍
function BaseGame:KickTeam(nTeamId, bAward, szMsg)
	szMsg = szMsg or "";
	if not self.tbTeam[nTeamId] then
		return 0;
	end
	if self.tbTeam[nTeamId].nRoomId then
		local nRoomId = self.tbTeam[nTeamId].nRoomId
		if self.tbRoom[nRoomId] then
			self.tbRoom[nRoomId]:DelTeamInfo(nTeamId);
		end
	end
	
	local tbTeamer, nCount = KTeam.GetTeamMemberList(nTeamId);	
	for i=1, nCount do
		local pPlayer = KPlayer.GetPlayerObjById(tbTeamer[i]);
		if pPlayer then
			if bAward and bAward == 1 then
				local tbItemInfo = {bForceBind = 1};
			pPlayer.AddStackItem(18,1,3046,1,nil,5); --ruong mg
			pPlayer.AddStackItem(18,1,3019,1,nil,5); --ruong mg
			pPlayer.AddStackItem(18,1,3039,1,nil,2); --ruong mg
			pPlayer.AddExp(2000000)
			pPlayer.Earn(200000,0);
			pPlayer.AddBindMoney(200000);
			pPlayer.AddJbCoin(10000);
			pPlayer.AddBindCoin(10000);	
			pPlayer.Msg("<color=green>Hành trang trống >5 để nhận<color> <color=yellow>Phần Thưởng 1 Vạn Đồng<color>!");
-----------------------------------------------------
KDialog.NewsMsg(1, Env.NEWSMSG_COUNT,"Người chơi <color=green>"..pPlayer.szName.."<color> hoàn thành 5 Ải <color=red>Tiêu Dao Cốc<color> nhận được <color=gold>3 Vạn Đồng<color>");
	KDialog.MsgToGlobal("Người chơi <color=green>"..pPlayer.szName.."<color> hoàn thành 5 Ải <color=red>Tiêu Dao Cốc<color> nhận được <color=gold>3 Vạn Đồng<color>");
--------------------------------------------------------				
			end
			Dialog:ShowBattleMsg(pPlayer,  0,  0); --关闭界面
			self:KickPlayer(pPlayer, szMsg);
		end
	end
	self.tbTeam[nTeamId] = nil;		-- 删除队伍信息
end

function BaseGame:OnLeave(nGroupId, szReason)
	local nPlayerId = me.nId;
	local nTeamId = me.nTeamId;
	if self.tbPlayer[nPlayerId] then	-- 玩家可能仍在某个房间的逻辑内
		local nRoomId = self.tbPlayer[nPlayerId];
		self.tbPlayer[nPlayerId] = nil;
		if self.tbRoom[nRoomId] then
			self.tbRoom[nRoomId]:PlayerLeaveRoom(nPlayerId);
		end
	elseif self.tbNextGameTeam[nTeamId] then
		self.tbNextGameTeam[nTeamId] = self.tbNextGameTeam[nTeamId] - 1
		if self.tbNextGameTeam[nTeamId] == 0 then
			self.tbNextGameTeam[nTeamId] = nil;
			self.nNextTeamCount = self.nNextTeamCount - 1;
			GCExcute{"XoyoGame:ReduceTeam_GC", self.nGameId};
		end
	end
	me.TeamDisable(0);
	me.ForbidExercise(0);
	me.ForbidEnmity(0);
	me.LeaveTeam();
	me.GetTempTable("XoyoGame").tbGame = nil;
end

-- 关房间
function BaseGame:CloseRoom(nRoomId)
	if self.tbRoom and self.tbRoom[nRoomId] then
		self.tbRoom[nRoomId]:Close();
		self.tbRoom[nRoomId] = nil;
	end
end

function BaseGame:CloseGame()
	if self.tbRoom then
		for nId, _ in pairs(self.tbRoom) do
			self:CloseRoom(nId);
		end
	end
	
	if self.nEndRoomTimerId then
		Timer:Close(self.nEndRoomTimerId);
		self.nEndRoomTimerId = nil;
	end
	if self:IsOpen() == 1 then
		self:Close();
	end
end

-- 增加一个房间
function BaseGame:AddRoom(nRoomId, ...)
	if self.tbRoom[nRoomId] then		-- 房间已经被占用;
		print("The Room is occupy", nRoomId, ...)
		return 0;
	end
	if not XoyoGame.RoomSetting.tbRoom[nRoomId] then	-- 没有这个配置的房间
		return 0;
	end
	local tbRoomSetting = XoyoGame.RoomSetting.tbRoom[nRoomId];
	local tbRoomExp = XoyoGame.tbRoomExp[nRoomId];
	
	if not XoyoGame.RoomSetting.tbRoom[nRoomId].DerivedRoom then
		self.tbRoom[nRoomId] = Lib:NewClass(XoyoGame.BaseRoom);
	else
		self.tbRoom[nRoomId] = Lib:NewClass(XoyoGame.RoomSetting.tbRoom[nRoomId].DerivedRoom);
	end
	
	self.tbRoom[nRoomId]:InitRoom(self, tbRoomSetting, self.tbMap[tbRoomSetting.nMapIndex], 
		nRoomId, tbRoomExp);
	self.tbRoom[nRoomId]:JoinRoom(...)
	self.tbRoom[nRoomId]:Start();
	return 1;
end

-- 统计房间的占用
function BaseGame:CalcRoomOccupy()
	local szLog = ""
	for nRoomId, _ in pairs(self.tbRoom) do
		szLog = nRoomId.."Người truyền đạt gian bị chiếm dụng ";
	end
	Dbg:WriteLog("XoyoGame", szLog)
end

function BaseGame:SetPlayerInRoom(nPlayerId, nRoomId)
	self.tbPlayer[nPlayerId] = nRoomId;
end

function BaseGame:GetPlayerRoom(nPlayerId)
	if not self.tbPlayer or not self.tbRoom then
		return nil;
	end
	local  nRoomId = self.tbPlayer[nPlayerId];
	if nRoomId then
		return self.tbRoom[nRoomId];
	end
	return nil;
end

function BaseGame:__TeamJoinNextGame(nTeamId)
	local tbMember, nCount = KTeam.GetTeamMemberList(nTeamId);
	for i = 1, nCount do
		local pPlayer = KPlayer.GetPlayerObjById(tbMember[i])
		if pPlayer then
			self:KickPlayer(pPlayer);
			self:JoinNextGame(pPlayer);
		end
	end
end

-- 测试房间用,实际功能不需要
function BaseGame:TestRoom(nMap, tbMap, nRoomId)
	if me.nTeamId == 0 then
		return 0;
	end
	self:CloseRoom(nRoomId);
	self:InitGame(tbMap, nMap);
	self:__TeamJoinNextGame(me.nTeamId);
	self.tbTeam[me.nTeamId] = {};
	self.tbTeam[me.nTeamId].nCurRoomCount = XoyoGame.PLAY_ROOM_COUNT - 1;
	self:AddRoom(nRoomId, me.nTeamId);
	local nRoomLevel = XoyoGame.RoomSetting.tbRoom[nRoomId].nRoomLevel;
	self.nEndRoomTimerId = Timer:Register(XoyoGame.ROOM_TIME[nRoomLevel] * Env.GAME_FPS, self.EndRoomTime, self, {nRoomId}, nRoomLevel);
	self.tbRoom[nRoomId].nTimerId = self.nEndRoomTimerId;
end

-- 
function BaseGame:TestGame(nMap, tbMap)
	if me.nTeamId == 0 then
		return 0;
	end
	self:InitGame(tbMap, nMap);
	self:JoinNextGame(me);
	self:StartNewGame();
end

function BaseGame:TestPKRoom(nMap, tbMap, nRoomId, nRoomLevel, nTeamId2)
	local nTeamId1 = me.nTeamId
	if nTeamId1 == 0 or not nTeamId2 then
		return 0;
	end
	
	self:CloseRoom(nRoomId);
	self:InitGame(tbMap, nMap);
	self:__TeamJoinNextGame(nTeamId1);
	self:__TeamJoinNextGame(nTeamId2);
	
	self.tbTeam[nTeamId1] = {};
	self.tbTeam[nTeamId1].nCurRoomCount = XoyoGame.PLAY_ROOM_COUNT - 1;
	self.tbTeam[nTeamId2] = {};
	self.tbTeam[nTeamId2].nCurRoomCount = XoyoGame.PLAY_ROOM_COUNT - 1;
	self:AddRoom(nRoomId, nTeamId1, nTeamId2);
	self.nEndRoomTimerId  = Timer:Register(XoyoGame.ROOM_TIME[nRoomLevel] * Env.GAME_FPS, self.EndRoomTime, self, {nRoomId}, nRoomLevel);
	self.tbRoom[nRoomId].nTimerId = self.nEndRoomTimerId;
end




