-------------------------------------------------------------------
--File: 	factionbattle_gs.lua
--Author: 	zhengyuhua
--Date: 	2008-1-8 17:38
--Describe:	门派战--gamecenter端脚本
-------------------------------------------------------------------
-- 开启门派战
function FactionBattle:StartFactionBattle_GS()
	local nRet = 0
	self.tbData = {};
	assert(self:LoadArenaRange(self.SETTING_PATH..self.ARENA_RANGE) == 1);	-- 读取混战随机范围配置
	assert(self:LoadArenaPoint(self.SETTING_PATH..self.ARENA_POINT) == 1);	-- 读取淘汰定点配置
	assert(self:LoadBoxPoint(self.SETTING_PATH..self.BOX_POINT) == 1);		-- 读取箱子的刷点
	if not self.tbBattleFlag then
		self.tbBattleFlag = {}
	end
--	local nCurDate = tonumber(os.date("%d", GetTime()))
--	if nCurDate <= 7  then
--		self.MAX_LEVEL = 150;
--	else
--		self.MAX_LEVEL = 100;
--	end
	for i = 1, Player.FACTION_NUM do
		self.tbBattleFlag[i] = 1;
	end
	for nFaction, nMapId in pairs(self.FACTION_TO_MAP) do
		if IsMapLoaded(nMapId) == 1 then	-- 地图加载则开启活动		
			self.tbData[nFaction] = Lib:NewClass(self.tbBaseFaction, nFaction, nMapId);	-- 创建活动数据对象
			nRet = 1;
			
			--额外事件，活动系统
			SpecialEvent.ExtendEvent:DoExecute("Open_FactionBattle", nFaction, nMapId);
		end
	end
	if nRet == 1 then
		self:StartSignUp();
	end
		local szMsg = "<color=green>Thi Đấu Loạn Phái<color> sẽ bắt đầu sau <color=blue>30 phút<color> nữa, hãy đến gặp <color=red>NPC Hỗ Trợ Tân Thủ<color> tại Đạo Hương Thôn để đăng kí tham gia."
	KDialog.NewsMsg(0, Env.NEWSMSG_NORMAL, szMsg);
	KDialog.MsgToGlobal("<color=green>Thi Đấu Loạn Phái<color> sẽ bắt đầu sau <color=blue>30 phút<color> nữa, hãy đến gặp <color=gold>NPC Hỗ Trợ Tân Thủ<color> tại Đạo Hương Thôn để đăng kí tham gia.");
end

function FactionBattle:EndBattle_GS2(nFaction)
	if not self.tbBattleFlag then
		self.tbBattleFlag = {}
	end
	self.tbBattleFlag[nFaction] = 0;
end

function FactionBattle:GetBattleFlag(nFaction)
	if not self.tbBattleFlag then
		self.tbBattleFlag = {}
	end
	return self.tbBattleFlag[nFaction];
end

function FactionBattle:GetFactionData(nFaction)
	if self.tbData then
		return self.tbData[nFaction];
	end
end

-- 启动活动
function FactionBattle:StartSignUp()
	for i, tbInfo in pairs(self.tbData) do
		tbInfo:TimerStart();
		tbInfo:CheckMap();
	end
	local szMsg = "<color=green>Thi Đấu Loạn Phái<color> sẽ bắt đầu sau <color=blue>30 phút<color> nữa, hãy đến gặp <color=red>NPC Hỗ Trợ Tân Thủ<color> tại Đạo Hương Thôn để đăng kí tham gia."
	KDialog.NewsMsg(0, Env.NEWSMSG_NORMAL, szMsg);
	KDialog.MsgToGlobal("<color=green>Thi Đấu Loạn Phái<color> sẽ bắt đầu sau <color=blue>30 phút<color> nữa, hãy đến gặp <color=gold>NPC Hỗ Trợ Tân Thủ<color> tại Đạo Hương Thôn để đăng kí tham gia.");
end

-- 离开地图
function FactionBattle:OnLeaveMap(nFaction)
	local tbData = self:GetFactionData(nFaction);
	local nPlayerId = me.nId;
	if tbData then
		if tbData:FindAttendPlayer(nPlayerId) == 1 then		-- 暂时恢复原来状态
			tbData:KickPlayerFromArena(nPlayerId);
			tbData:ResumeNormalState(nPlayerId);
		end
		tbData:DelMapPlayerTable(nPlayerId);
	end
	me.nForbidChangePK = 0;
	me.ForbidEnmity(0);		--仇杀
	me.ForbidExercise(0); 	--切磋 
	me.DisabledStall(0);	--摆摊
end

-- 进入地图
function FactionBattle:OnEnterMap(nFaction, bIsNewWorld)
	local tbData = self:GetFactionData(nFaction)
	if tbData then
		tbData:AddMapPlayerTable(me.nId);
		if tbData:FindAttendPlayer(me.nId) == 1 then		-- 设置比赛准备状态
			-- TODO
		end
	end
	self:TrapIn(me);
	me.SetFightState(0);
	me.nPkModel = Player.emKPK_STATE_PRACTISE;
	me.nForbidChangePK = 1;
	me.ForbidEnmity(1);		-- 禁止仇杀
	me.ForbidExercise(1); 	-- 禁止切磋 
	me.DisabledStall(1);	--禁止摆摊
end

-- 读取各个比赛场地的随机进入点
function FactionBattle:LoadArenaRange(szFullPath)
	self.tbArenaRange = {}
	local tbNumColName = {ARENA_ID = 1, X = 1, Y = 1, RADII = 1};
	local tbFileData = Lib:LoadTabFile(szFullPath, tbNumColName);
	if not tbFileData then
		return 0;
	end
	for nIndex, tbRow in pairs(tbFileData) do
		if not self.tbArenaRange[tbRow.ARENA_ID] then
			self.tbArenaRange[tbRow.ARENA_ID] = {}
		end
		local tbPoint = {nX = tbRow.X, nY = tbRow.Y, nR = tbRow.RADII};	-- 中心X,Y,半径
		table.insert(self.tbArenaRange[tbRow.ARENA_ID], tbPoint);
	end
	return 1;
end

-- 淘汰赛定点载入
function FactionBattle:LoadArenaPoint(szFullPath)
	self.tbArenaPoint = {}
	local tbNumColName = {ARENA_ID = 1, X1 = 1, Y1 = 1, X2 = 1, Y2 = 1};
	local tbFileData = Lib:LoadTabFile(szFullPath, tbNumColName);
	if not tbFileData then
		return 0;
	end
	for nIndex, tbRow in pairs(tbFileData) do
		self.tbArenaPoint[tbRow.ARENA_ID] = {}	-- 有重复定点则会覆盖
		self.tbArenaPoint[tbRow.ARENA_ID][1] = {tbRow.X1, tbRow.Y1};
		self.tbArenaPoint[tbRow.ARENA_ID][2] = {tbRow.X2, tbRow.Y2};
	end
	return 1;
end

-- 加载奖励箱子的刷点
function FactionBattle:LoadBoxPoint(szFullPath)
	self.tbBoxPoint = {}
	local tbNumColName = {GROUP = 1, X = 1, Y = 1};
	local tbFileData = Lib:LoadTabFile(szFullPath, tbNumColName);
	if not tbFileData then
		return 0;
	end
	for nIndex, tbRow in pairs(tbFileData) do
		if not self.tbBoxPoint[tbRow.GROUP] then
			self.tbBoxPoint[tbRow.GROUP] = {}
		end
		local tbPoint = {nX = tbRow.X, nY = tbRow.Y};	-- 中心X,Y,半径
		table.insert(self.tbBoxPoint[tbRow.GROUP], tbPoint);
	end
	return 1;
end

-- 加载奖励箱子的刷点
function FactionBattle:LoadBoxPoint(szFullPath)
	self.tbBoxPoint = {}
	local tbNumColName = {GROUP = 1, X = 1, Y = 1};
	local tbFileData = Lib:LoadTabFile(szFullPath, tbNumColName);
	if not tbFileData then
		return 0;
	end
	for nIndex, tbRow in pairs(tbFileData) do
		if not self.tbBoxPoint[tbRow.GROUP] then
			self.tbBoxPoint[tbRow.GROUP] = {}
		end
		local tbPoint = {nX = tbRow.X, nY = tbRow.Y};	-- 中心X,Y,半径
		table.insert(self.tbBoxPoint[tbRow.GROUP], tbPoint);
	end
	return 1;
end

-- 获取某个混战区的一个随机点
function FactionBattle:GetRandomPoint(nArenaId)
	if not self.tbArenaRange or not self.tbArenaRange[nArenaId] then
		return;
	end
	local nArenaRangeNum = #self.tbArenaRange[nArenaId];
	local tbRandomRange = self.tbArenaRange[nArenaId][MathRandom(nArenaRangeNum)];
	if not tbRandomRange then
		return;
	end
	local nAngle = 6.28 * MathRandom()				-- 随机弧度度 3.14 * 2 = 6.28
	local nRadii = MathRandom(tbRandomRange.nR)	-- 随机距离
	local nX = math.floor(math.cos(nAngle) * nRadii + tbRandomRange.nX);
	local nY = math.floor(math.sin(nAngle) * nRadii + tbRandomRange.nY);
	return nX, nY;
end

-- 获取某个淘汰赛区域的两个定点
function FactionBattle:GetElimFixPoint(nArenaId)
	if self.tbArenaPoint and self.tbArenaPoint[nArenaId] then
		return self.tbArenaPoint[nArenaId][1], self.tbArenaPoint[nArenaId][2];
	end
end

-- 关闭活动
function FactionBattle:ShutDown(nFaction)
	if self.tbData and self.tbData[nFaction]then
		self.tbData[nFaction] = nil;
	end
	GCExcute{"FactionBattle:EndBattle_GC" , nFaction};
end

function FactionBattle:ShowMsgToMapPlayer(nFaction, szMsg)
	if self.tbData and self.tbData[nFaction] then 
		self.tbData[nFaction]:MsgToMapPlayer(szMsg);
	end
end

-- 传送玩家至某个传入点
function FactionBattle:TrapIn(pPlayer)
	local nRandom = MathRandom(4);
	if pPlayer and self.REV_POINT[nRandom] then
		pPlayer.NewWorld(self.FACTION_TO_MAP[pPlayer.nFaction], unpack(self.REV_POINT[nRandom]));
	end
end

function FactionBattle:FinalWinner(nFaction, nPlayerId)
	GCExcute{"FactionBattle:FinalWinner_GC", nFaction, nPlayerId};
	-- 冠军旗子
	self:AwardChampionStart(nFaction, nPlayerId);
end


function FactionBattle:ShowCandidate(nFaction)
	local tbCandidate = GetCurCandidate(nFaction);
	print("Tháng này：")
	Lib:ShowTB(tbCandidate);
	tbCandidate = GetLastMonthCandidate(nFaction);
	print("Tháng trước:");
	Lib:ShowTB(tbCandidate);
	print("Trước:");
	tbCandidate = GetAllElectWinner(nFaction);
	Lib:ShowTB(tbCandidate);
	print("Gần đây:")
	local tbPlayer = GetCurWinner(nFaction);
	if tbPlayer then
		Lib:ShowTB(tbPlayer);
	end
end
