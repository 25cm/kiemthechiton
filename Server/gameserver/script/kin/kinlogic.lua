-------------------------------------------------------------------
--File: kinlogic.lua
--Author: lbh
--Date: 2007-6-26 14:57
--Describe: 基础家族逻辑
-------------------------------------------------------------------
if not Kin then --调试需要
	Kin = {}
	print(GetLocalDate("%Y/%m/%d/%H/%M/%S").." build ok ..")
end

--定义临时变量，用于生成运行期的唯一流水ID号
if not Kin.nJourNum then
	Kin.nJourNum = 0
end

--记录家族脚本临时数据
if not Kin.aKinData then
	Kin.aKinData = {}
end

function Kin:GetKinData(nKinId)
	local aKinData = self.aKinData[nKinId]
	if aKinData then
		return aKinData
	end
	aKinData = {}
	self.aKinData[nKinId] = aKinData
	--记录推荐入帮事件
	aKinData.aIntroduceEvent = {}	
	aKinData.aIntroduceCancel = {}
	--记录踢人响应事件
	aKinData.aKickEvent = {}
	if MODULE_GC_SERVER then
	else
		--邀请成员缓存
		aKinData.aInviteEvent = {}
		--家族总威望价值量缓存
		aKinData.nTotalRepValue = 0
		--族长额外获得价值量缓存
		aKinData.nCaptainRepValue = 0
	end
	return aKinData
end

function Kin:DelKinData(nKinId)
	if self.aKinData[nKinId] then
		self.aKinData[nKinId] = nil
	end
end

--判断执行者的权限
--nFigureLevel：哪个级别以上才能操作
function Kin:CheckSelfRight(nKinId, nExcutorId, nFigureLevel)
	if nKinId == 0 or nExcutorId == 0 then
		return 0
	end
	local cKin = KKin.GetKin(nKinId)
	if not cKin then
		return 0
	end
	--执行者为-1默认系统执行
	if nExcutorId == -1 then
		return 1, cKin;
	end
	local cMemberExcutor = cKin.GetMember(nExcutorId)
	if not cMemberExcutor then
		return 0, cKin;
	end
	
	-- 是否拥有该职位的权限
	if self:HaveFigure(nKinId, nExcutorId, nFigureLevel) == 0 then
		return 0;
	end
	
	--族长冻结状态
	if nFigureLevel <= 2 and cMemberExcutor.GetFigure() == 1 and cKin.GetCaptainLockState() == 1 then
		if MODULE_GAMESERVER then
			local pPlayer = KPlayer.GetPlayerObjById(cMemberExcutor.GetPlayerId());
			if pPlayer then
				pPlayer.Msg("Đã bị cách chức, quyền Tộc trưởng không còn!");
			end
		end
		return 0, cKin, cMemberExcutor;
	end
	
	-- 未解锁
	if nFigureLevel <= 2 then
		if MODULE_GAMESERVER then
			local pPlayer = KPlayer.GetPlayerObjById(cMemberExcutor.GetPlayerId());
			if pPlayer and pPlayer.IsAccountLock() ~= 0 then
				pPlayer.Msg("Bạn chưa mở khóa, quyền hạn Tộc trưởng đã bị khóa!");
				return 0, cKin, cMemberExcutor;
			end
		end
	end
	
	return 1, cKin, cMemberExcutor;
end

-- 是不是拥有该职位
function Kin:HaveFigure(nKinId, nExcutorId, nFigureLevel)
	if nKinId == 0 or nExcutorId == 0 then
		return 0
	end
	local cKin = KKin.GetKin(nKinId)
	if not cKin then
		return 0
	end
	--执行者为-1默认系统执行
	if nExcutorId == -1 then
		return 1, cKin;
	end
	local cMemberExcutor = cKin.GetMember(nExcutorId)
	if not cMemberExcutor then
		return 0, cKin;
	end
	if cMemberExcutor.GetFigure() > nFigureLevel then
		return 0, cKin, cMemberExcutor;
	end
	return 1, cKin, cMemberExcutor;
end

--判断是否能创建家族
function Kin:CanCreateKin(anPlayerId)
	--基础逻辑里只要有一个人就可以建立家族，真实人数限制在上层逻辑判定
	if not anPlayerId or #anPlayerId < 1 then
		return 0
	end
	--判断若有成员已有家族则不能创建
	for i, nPlayerId in ipairs(anPlayerId) do
		local nKin, nMember = KKin.GetPlayerKinMember(nPlayerId)
		if nKin ~= 0 or nMember ~= 0 then
			return 0
		end
	end
	return 1
end

--以列表的PlayerId创建家族
function Kin:CreateKin(anPlayerId, anStoredRepute, szKinName, nCamp, nCreateTime, tbStock)
	-- 阵营是否合法范围
	if nCamp < 1 or nCamp > 3 then
		return nil
	end
	local cKin, nKinId = KKin.AddKin(szKinName)
	if not cKin then
		return nil
	end
	if not tbStock then
		return 0;
	end
	--不允许ID为0
	if nKinId == 0 then
		KKin.DelKin(nKinId)
		return nil
	end
	--KStatLog.ModifyField("Kin", szKinName, "家族ID", tostring(nKinId));
	local nMemberId = 0
	--将列表的Player加入家族中
	for i, nPlayerId in ipairs(anPlayerId) do
		nMemberId = nMemberId + 1
		local cMember = cKin.AddMember(nMemberId)
		if not cMember then
			return nil
		end
		if MODULE_GC_SERVER then
			KKin.SetPlayerKinMember(nPlayerId, nKinId, nMemberId)
			local szMsg = string.format("%s gia nhập gia tộc", KGCPlayer.GetPlayerName(nPlayerId));
			_G.KinLog(szKinName,  Log.emKKIN_LOG_TYPE_KINSTRUCTURE, szMsg);
		end
		cMember.SetPlayerId(nPlayerId)
		cMember.SetJoinTime(nCreateTime)
		--cMember.SetRepute(anStoredRepute[i])	--加本身缓存的江湖威望
		if MODULE_GC_SERVER then
			tbStock[i] = KGCPlayer.OptGetTask(nPlayerId, KGCPlayer.TSK_TONGSTOCK);
		end
		cMember.SetPersonalStock(tbStock[i]);
		if i == 1 then
			cMember.SetFigure(self.FIGURE_CAPTAIN)
			if MODULE_GC_SERVER then
				KGCPlayer.SetPlayerPrestige(nPlayerId, KGCPlayer.GetPlayerPrestige(nPlayerId) + 20);
			end
		else
			cMember.SetFigure(self.FIGURE_REGULAR)
			if MODULE_GC_SERVER then
					KGCPlayer.SetPlayerPrestige(nPlayerId, KGCPlayer.GetPlayerPrestige(nPlayerId) + 5);
			end
		end
	end
	cKin.SetCamp(nCamp)
	cKin.SetCreateTime(nCreateTime)
	--设置家族名字
	cKin.SetName(szKinName)
	--设置称号
	cKin.SetTitleCaptain("Tộc trưởng")
	cKin.SetTitleAssistant("Tộc phó")
	cKin.SetTitleMan("Thành viên_Nam")
	cKin.SetTitleWoman("Thành viên_Nữ")
	cKin.SetTitleRetire("Thành Viên Danh Dự")
	--组队队长作为族长
	cKin.SetCaptain(1)
	--设置ID生成器
	cKin.SetMemberIdGentor(nMemberId)
	local tbHistory = {};
	for i=1,6 do	-- 5个成员，不足记录空串
		local szMsg = ""
		if anPlayerId[i] then
			szMsg = KGCPlayer.GetPlayerName(anPlayerId[i]);
			if not szMsg then
				szMsg = "";
			end
		end
		tbHistory[i] = szMsg;
	end
	cKin.AddHistoryEstablish(szKinName, unpack(tbHistory));
	_DbgOut("Kin:CreateKin succeed")
	return cKin, nKinId
end

function Kin:CheckMemberCanAdd(nKinId, nPlayerId)
	--已有家族
	local nPreKin, nPreMember = KKin.GetPlayerKinMember(nPlayerId);
	if nPreKin ~= 0 then
		local cPreKin = KKin.GetKin(nPreKin);
		if (cPreKin) then
			local cPreMember = cPreKin.GetMember(nPreMember);
			if cPreMember and cPreMember.GetPlayerId() == nPlayerId then
				return 0			
			end
		end
		-- 数据有问题，清除
		KKin.DelPlayerKinMember(nPlayerId);
	end
	local cKin = KKin.GetKin(nKinId)
	if not cKin then
		return 0
	end
	local nRegular, nSigned, nRetire = cKin.GetMemberCount()
	if nRegular + nSigned >= self.MEMBER_LIMITED then
		return 0
	end
	return 1
end

function Kin:CheckQuitTong(cKin)
	if not cKin then
		return 0;
	end
	local nMemberCount = cKin.nMemberCount;
	local nQuitDisagrre;		
	if nMemberCount > 0 then
		nQuitDisagrre = math.floor(nMemberCount / 3);	-- 反对退出帮会的人数需要达到的总人数1/3
		if nQuitDisagrre < 1 then		--  防止家族人数少于3永不能成功退帮
			nQuitDisagrre = 1;
		end
		local cMemberItor = cKin.GetMemberItor()
		local cCurMember = cMemberItor.GetCurMember()
		while cCurMember do
			if cCurMember.GetQuitVoteState() == 2 then	--投反对票的成员
				nQuitDisagrre = nQuitDisagrre - 1;
			end
			cCurMember = cMemberItor.NextMember();
		end
	end
	if nQuitDisagrre < 1 then		-- 反对人数超过总人数的1/3
		return 0;
	end
	return 1;
end

function Kin:ParseHistory(tbRecord)
	if not Kin.HistoryFormat then
		return "";
	end
	if not tbRecord or not Kin.HistoryFormat[tbRecord.nType] then
		return "";
	end
	local tbParse = Kin.HistoryFormat[tbRecord.nType];
	if tbParse.nContentNum > #tbRecord.tbContent then
		return "";
	end
	return string.format("%s："..tbParse.szFormat, os.date("Năm %Y Tháng %m Ngày %d", tbRecord.nTime), unpack(tbRecord.tbContent));
end

-- 根据贡献度和任务的不同来计算贡献度Tộc trưởng
function Kin:GetKinOfferLevel(nOffer, nTask)
	if (not nOffer or not nTask or nOffer < 0 or nTask < self.TASK_BAIHUTANG or nTask > self.TASK_ARMYCAMP) then
		return 0;
	end
	local nLevle = 0;
	if (not self.TASK_LEVEL_KIN_SCORE[nTask] or self.TASK_LEVEL_KIN_SCORE[nTask] <= 0) then
		return 0;
	end
	nLevle = math.floor(nOffer / self.TASK_LEVEL_KIN_SCORE[nTask]);
	if (nLevle > 5) then
		nLevle = 5;
	end
	return nLevle;
end

-- 根据玩家贡献度和任务类型计算贡献度Tộc trưởng
function Kin:GetPersonalOfferLevel(nOffer, nTask)
	if (not nOffer or not nTask or nOffer < 0 or nTask < self.TASK_BAIHUTANG or nTask > self.TASK_ARMYCAMP) then
		return 0;
	end
	local nLevel = 0;
	if (not self.TASK_LEVEL_PERSONAL_SCORE[nTask] or self.TASK_LEVEL_PERSONAL_SCORE[nTask] <= 0) then
		return 0;
	end
	nLevel = math.floor(nOffer / self.TASK_LEVEL_PERSONAL_SCORE[nTask]);
	if (nLevel > 5) then
		nLevel = 5;
	end
	return nLevel;
end

function Kin:PerKinMemberWeeklyTask(cKin)
	if (not cKin) then
		return 0;
	end
	local itor = cKin.GetMemberItor();
	local cMember = itor.GetCurMember();
	while cMember do
		local nWeeklyKinOffer = cMember.GetWeeklyKinOffer();
		cMember.SetLastWeekKinOffer(nWeeklyKinOffer);
		cMember.SetWeeklyKinOffer(0);
		cMember = itor.NextMember();
	end
end

-- 统计每周的周活动Tộc trưởng数据
function Kin:StatisticsWeeklyTaskLevel(cKin)
	if (not cKin) then
		return 0;
	end
	-- 统计家族周活动Tộc trưởng数据
	local nKinOffer = cKin.GetWeeklyKinOffer();
	local nTask = cKin.GetWeeklyTask();
	local nKinOfferLevel = self:GetKinOfferLevel(nKinOffer, nTask);
	if (not self.KinLevel_WeeklyTask) then
		self.KinLevel_WeeklyTask = {};
	end
	if (not self.KinLevel_WeeklyTask[nTask]) then
		self.KinLevel_WeeklyTask[nTask] = {};
	end
	if (not self.KinLevel_WeeklyTask[nTask][nKinOfferLevel]) then
		self.KinLevel_WeeklyTask[nTask][nKinOfferLevel] = 0;
	end
	self.KinLevel_WeeklyTask[nTask][nKinOfferLevel] = self.KinLevel_WeeklyTask[nTask][nKinOfferLevel] + 1;
	
	-- 统计家族成员周活动Tộc trưởng数据
	if (not self.PersonalLevel_WeeklyTask) then
		self.PersonalLevel_WeeklyTask = {};
	end
	if (not self.PersonalLevel_WeeklyTask[nTask]) then
		self.PersonalLevel_WeeklyTask[nTask] = {};
	end
	local itor = cKin.GetMemberItor();
	local cMember = itor.GetCurMember();
	while cMember do
		local nPersonalWeeklyKinOffer = cMember.GetWeeklyKinOffer();
		local nPersonalOfferLevel = self:GetPersonalOfferLevel(nPersonalWeeklyKinOffer, nTask);
		if (not self.PersonalLevel_WeeklyTask[nTask][nPersonalOfferLevel]) then
			self.PersonalLevel_WeeklyTask[nTask][nPersonalOfferLevel] = 0;
		end
		self.PersonalLevel_WeeklyTask[nTask][nPersonalOfferLevel] = self.PersonalLevel_WeeklyTask[nTask][nPersonalOfferLevel] + 1;
		cMember = itor.NextMember();
	end
end

-- 记录周目标流水号
function Kin:RecordWeeklyActionNo()
	local nOldNo = KGblTask.SCGetDbTaskInt(DBTASK_KIN_WEEKLYACTION_NO);
	local nNewNo = tonumber(os.date("%Y%W", GetTime()));
	if (nOldNo ~= nNewNo) then
		KGblTask.SCSetDbTaskInt(DBTASK_KIN_WEEKLYACTION_NO, nNewNo);
	end
end

-- 记录周活动Tộc trưởng数据到数据库
function Kin:LogWeeklyTaskLevel()
	local tbTaskName = {"baihutang", "battle", "wanted", "xoyogame", "armycamp"};
	if (not self.KinLevel_WeeklyTask) then
		self.KinLevel_WeeklyTask = {};
	end
	for nTask = 1, 5 do
		if (not self.KinLevel_WeeklyTask[nTask]) then
			self.KinLevel_WeeklyTask[nTask] = {};
		end
		for nKinLevel = 0, 5 do
			if (not self.KinLevel_WeeklyTask[nTask][nKinLevel]) then
				self.KinLevel_WeeklyTask[nTask][nKinLevel] = 0;
			end
			KStatLog.ModifyField("kinweeklytask", tbTaskName[nTask], tostring(nKinLevel) .. "Tộc trưởng", tostring(self.KinLevel_WeeklyTask[nTask][nKinLevel]));
			self.KinLevel_WeeklyTask[nTask][nKinLevel] = 0;
		end
	end
	
	if (not self.PersonalLevel_WeeklyTask) then
		self.PersonalLevel_WeeklyTask = {};
	end
	for nTask = 1, 5 do
		if (not self.PersonalLevel_WeeklyTask[nTask]) then
			self.PersonalLevel_WeeklyTask[nTask] = {};
		end
		for nPersonLevel = 0, 5 do
			if (not self.PersonalLevel_WeeklyTask[nTask][nPersonLevel]) then
				self.PersonalLevel_WeeklyTask[nTask][nPersonLevel] = 0;
			end
			KStatLog.ModifyField("personweeklytask", tbTaskName[nTask], tostring(nPersonLevel) .. "Tộc trưởng", tostring(self.PersonalLevel_WeeklyTask[nTask][nPersonLevel]));
			self.PersonalLevel_WeeklyTask[nTask][nPersonLevel] = 0;
		end
	end
end

function Kin:ClearAllStock(nKinId)
	local pKin = KKin.GetKin(nKinId)
	if not pKin then
		return 0;
	end
	local pMemberItor = pKin.GetMemberItor()
	local pMember = pMemberItor.GetCurMember();
	while pMember do
		pMember.SetPersonalStock(0);		-- 清除个人股份数
		pMember = pMemberItor.NextMember()
	end
end

-- 通过MemberId获得玩家的PlayerId
function Kin:GetPlayerIdByMemberId(nKinId, nMemberId)
	local pKin = KKin.GetKin(nKinId);
	if not pKin then 
		return 0;
	end
	
	local pMember = pKin.GetMember(nMemberId);
	if not pMember then 
		return 0;
	end
	
	return pMember.GetPlayerId();
end
