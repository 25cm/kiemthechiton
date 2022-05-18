--官府通缉任务
--孙多良
--2008.08.05
Require("\\script\\task\\wanted\\wanted_def.lua");

--测试使用,完成任务
function Wanted:_Test_FinishTask()
	if Task:GetPlayerTask(me).tbTasks[Wanted.TASK_MAIN_ID] then
		for _, tbCurTag in ipairs(Task:GetPlayerTask(me).tbTasks[Wanted.TASK_MAIN_ID].tbCurTags) do
			if (tbCurTag.OnKillNpc) then
				if (tbCurTag:IsDone()) then
					--杀死Boss玩家的队友身上有任务完成时调用	
					if me.GetTask(Wanted.TASK_GROUP, Wanted.TASK_FINISH) == 1 then
						me.SetTask(Wanted.TASK_GROUP, Wanted.TASK_FINISH, 0);
					end
					break;
				end;
				tbCurTag.nCount	= tbCurTag.nCount + 1;		
				local tbSaveTask	= tbCurTag.tbSaveTask;
				if (MODULE_GAMESERVER and tbSaveTask) then	-- 自行同步到客户端，要求客户端刷新
					tbCurTag.me.SetTask(tbSaveTask.nGroupId, tbSaveTask.nStartTaskId, tbCurTag.nCount, 1);
					KTask.SendRefresh(tbCurTag.me, tbCurTag.tbTask.nTaskId, tbCurTag.tbTask.nReferId, tbSaveTask.nGroupId);
				end;
								
				if (tbCurTag:IsDone()) then	-- 本目标Có一旦达成后不会失效的
					tbCurTag.me.Msg("Mục tiêu: "..tbCurTag:GetStaticDesc());
					tbCurTag.tbTask:OnFinishOneTag();
				end;
				
				--杀死Boss玩家的队友身上有任务完成时调用				
				if me.GetTask(Wanted.TASK_GROUP, Wanted.TASK_FINISH) == 1 then
					me.SetTask(Wanted.TASK_GROUP, Wanted.TASK_FINISH, 0);
				end
			end
		end;
	end
end

function Wanted:GetLevelGroup(nLevel)
	if nLevel < self.LIMIT_LEVEL then
		return 0;
	end
	local nMax = 0;
	for ni, nLevelSeg in ipairs(self.LevelGroup) do
		if nLevel <= nLevelSeg then
			return ni;
		end
		nMax = ni;
	end
	return nMax;
end

function Wanted:GetTask(nTaskId)
	return me.GetTask(self.TASK_GROUP, nTaskId);
end

function Wanted:SetTask(nTaskId, nValue)
	return me.DirectSetTask(self.TASK_GROUP, nTaskId, nValue);
end

function Wanted:Check_Task()
	if me.nLevel < self.LIMIT_LEVEL then
		return 3;
	end
	if self:GetTask(self.TASK_FIRST) == 0 then
		if self:GetTask(self.TASK_COUNT) == 0 then
			self:SetTask(self.TASK_COUNT, self.Day_COUNT);
		end
		self:SetTask(self.TASK_FIRST, 1);
	end
	--if self:GetTask(self.TASK_ACCEPT_ID) <= 0 then
	--	return 0;
	--end
	local tbTask = Task:GetPlayerTask(me).tbTasks[self.TASK_MAIN_ID];
	if not tbTask then
		--self:SetTask(self.TASK_ACCEPT_ID, 0);
		return 0;	--未接任务
	end
	
	if self:CheckTaskFinish() == 1 then
		return 1;	--已完成
	else
		return 2;	--未完成
	end
	return 0;
end

function Wanted:CheckLimitTask()
	--if me.GetTask(1022,107) == 1 then
		--Dialog:Say("Bổ Đầu Hình Bộ: Đại hiệp, chưa hoàn thành nhiệm vụ chính tuyến cấp 50, không thể nhận nhiệm vụ.");
		--return 0;
	--end
	
	--江湖威望判断
	--if (me.nPrestige < self.LIMIT_REPUTE) then
		--local szFailDesc = "Uy danh giang hồ chưa đạt 20, không thể nhận nhiệm vụ.";
		--Dialog:Say(szFailDesc);
		--return 0;
	--end
	
	local nType = self:GetLevelGroup(me.nLevel);
	if nType <= 0 then
		Dialog:Say("Bổ Đầu Hình Bộ: Đại hiệp, Ở cấp độ của bạn, làm thế nào những tên trộm nhỏ trong đấu trường có thể cần bạn hành động?。");
		return 0;
	end
	if self:GetTask(self.TASK_COUNT) <= 0 then
		Dialog:Say("Bổ Đầu Hình Bộ: Đại hiệp, không còn nhiệm vụ có thể nhận.")
		return 0;
	end
	return 1;	
end

-- 检测任务除了交物品任务之外还有没有未完成的目标
function Wanted:CheckTaskFinish()
	local tbTask	 	= Task:GetPlayerTask(me).tbTasks[self.TASK_MAIN_ID];
	
	-- 还有未完成的目标
	for _, tbCurTag in pairs(tbTask.tbCurTags) do
		if (not tbCurTag:IsDone()) then
			return 0;
		end;
	end;
	
	-- 全部目标完成
	return 1;
end;

function Wanted:SingleAcceptTask()
	if self:Check_Task() ~= 0 then
		return 0;
	end
	if self:CheckLimitTask() ~= 1 then
		return 0;
	end
	local nType = self:GetLevelGroup(me.nLevel);
	local tbOpt = {};
	for i=1, nType do 
		table.insert(tbOpt, {string.format("Nhiệm vụ cấp %s",40+i*10), self.GetRandomTask, self, i});
	end
	table.insert(tbOpt, {"Để ta suy nghĩ đã"});
	Dialog:Say("Bạn có thể nhận các nhiệm vụ sau đây, nhiệm vụ cấp càng cao càng khó.", tbOpt);
end

function Wanted:GetRandomTask(nLevelSeg)
	if self:CheckLimitTask() ~= 1 then
		return 0;
	end	
	if self.TaskLevelSeg[nLevelSeg] then
		local nP = Random(#self.TaskLevelSeg[nLevelSeg]) + 1;
		local nTaskId = self.TaskLevelSeg[nLevelSeg][nP];
		self:AcceptTask(nTaskId, nLevelSeg);
		return nTaskId;
	end
end

function Wanted:AcceptTask(nTaskId, nLevelSeg)
	if self:Check_Task() ~= 0 then
		return 0;
	end
	if self:CheckLimitTask() ~= 1 then
		return 0;
	end
	Task:DoAccept(self.TASK_MAIN_ID, nTaskId);
	self:SetTask(self.TASK_ACCEPT_ID, nTaskId);
	self:SetTask(self.TASK_LEVELSEG, nLevelSeg);
	self:SetTask(self.TASK_FINISH, 1);
	self:SetTask(self.TASK_COUNT, self:GetTask(self.TASK_COUNT) -1);
	
	-- 记录参加次数
	local nNum = me.GetTask(StatLog.StatTaskGroupId , 4) + 1;
	me.SetTask(StatLog.StatTaskGroupId , 4, nNum);
	
	-- 记录玩家参加官府通缉的次数
	Stats.Activity:AddCount(me, Stats.TASK_COUNT_WANTED, 1);
end

function Wanted:CaptainAcceptTask()
	local tbTeamMembers, nMemberCount	= me.GetTeamMemberList();
	local tbPlayerName	 = {};
	if (not tbTeamMembers) then
		Dialog:Say("Bổ Đầu Hình Bộ: Ngươi không có tổ đội!");
		return;
	end
	if self:Check_Task() ~= 0 then
		return 0;
	end
	if self:CheckLimitTask() ~= 1 then
		return 0;
	end
	local nType = self:GetLevelGroup(me.nLevel);
	local tbOpt = {};
	for i=1, nType do 
		table.insert(tbOpt, {string.format("Nhiệm vụ cấp %s",40+i*10), self.TeamAcceptTask, self, i});
	end
	table.insert(tbOpt, {"Để ta suy nghĩ đã"});
	Dialog:Say("Bạn có thể nhận các nhiệm vụ sau đây, nhiệm vụ cấp càng cao càng khó.", tbOpt);
		
end

function Wanted:TeamAcceptTask(nLevelSeg, nFlag)
	local tbTeamMembers, nMemberCount	= me.GetTeamMemberList();
	local tbPlayerName	 = {};
	if (not tbTeamMembers) then
		Dialog:Say("Bổ Đầu Hình Bộ: Ngươi không có tổ đội!");
		return;
	end
	local nTeamTaskId = 0;
	if nFlag == 1 then
		nTeamTaskId = self:GetRandomTask(nLevelSeg);
	end
	local pOldMe = me;
	local nOldIndex	= me.nPlayerIndex
	local nCaptainLevel	= me.nLevel;	-- 队长的等级
	local szCaptainName =  me.szName;	-- 队长的名字
	
	for i=1, nMemberCount do
		if (nOldIndex ~= tbTeamMembers[i].nPlayerIndex) then
			
			me = tbTeamMembers[i];
			if self:Check_Task() == 0 and self:CheckLimitTask() == 1 and self:GetLevelGroup(me.nLevel) >= nLevelSeg then
					if nFlag == 1 and nTeamTaskId > 0 then
						local szMsg = string.format("Bổ Đầu Hình Bộ: Đội trưởng <color=yellow>%s<color> có nhiệm vụ muốn chia sẻ: nhiệm vụ cấp %s - <color=green>Truy bắt Hải Tặc %s<color>, ngươi có sẵn sàng nhận không?", szCaptainName, (40 + nLevelSeg*10),self.TaskFile[nTeamTaskId].szTaskName);
						local tbOpt = 
						{
							{"Có", self.AcceptTask, self, nTeamTaskId, nLevelSeg},
							{"Không"},
						}
						Dialog:Say(szMsg, tbOpt);
					else
						table.insert(tbPlayerName, {tbTeamMembers[i].nPlayerIndex, tbTeamMembers[i].szName});
					end
			end;
		end;
	end;
	me = pOldMe;
	
	if nFlag == 1 then
		return
	end
	
	if #tbPlayerName <= 0 then
		Dialog:Say("Bổ Đầu Hình Bộ: Các thành viên trong đội không thể chia sẻ nhiệm vụ, cần đáp ứng các điều kiện sau:<color=yellow>\n\n    Cấp độ phù hợp với đội trưởng và nhiệm vụ\n    Chưa nhận bất kỳ nhiệm vụ Truy nã nào\n    Vẫn còn số lần tham gia truy bắt Hải Tặc\n    Trong phạm vi gần đội trưởng\n    Đã hoàn thành nhiệm vụ chính tuyến cấp 50\n    Uy danh giang hồ đạt 20 điểm<color>\n");
		return;
	end;
	
	local szMembersName	= "\n";
	
	for i=1, #tbPlayerName do
		szMembersName = szMembersName.."<color=yellow>"..tbPlayerName[i][2].."<color>\n";
	end;
	local szMsg = string.format("Bổ Đầu Hình Bộ: Nhiệm vụ có thể chia sẻ với đồng đội:\n%s\nNgươi có muốn chia sẻ?", szMembersName);
	local tbOpt = 
	{
		{"Có", self.TeamAcceptTask, self, nLevelSeg, 1},
		{"Không"},
	}
	Dialog:Say(szMsg, tbOpt);	
end

function Wanted:CancelTask(nFlag)
	if self:Check_Task() ~= 2 then
		return 0;
	end
	if nFlag == 1 then
		self:SetTask(self.TASK_ACCEPT_ID, 0);
		self:SetTask(self.TASK_FINISH, 0);
		Task:CloseTask(self.TASK_MAIN_ID, "giveup");
		return;
	end
	local szMsg = "Bổ Đầu Hình Bộ: Ngươi có chắc chắn muốn hủy nhiệm vụ?";
	local tbOpt = {
		{"Ta muốn hủy nhiệm vụ", self.CancelTask, self, 1},
		{"Để ta suy nghĩ đã"}
	}
	Dialog:Say(szMsg, tbOpt);
	return;
end

function Wanted:FinishTask()
	if self:Check_Task() ~= 1 then
		return 0;
	end	
	self:ShowAwardDialog()	
end

-- 师徒成就：官府通缉
function Wanted:GetAchievement(pPlayer)
	if (not pPlayer) then
		return;
	end
	
	-- nLevle的具体数值对应等级和配置文件"\\setting\\task\\wanted\\level_group.txt"相同
	local nLevel = self:GetTask(self.TASK_LEVELSEG);
	local nAchievementId = 0;
	if (1 == nLevel) then
		nAchievementId = Achievement.TONGJI_55;
	elseif (2 == nLevel) then
		nAchievementId = Achievement.TONGJI_65;
	elseif (3 == nLevel) then
		nAchievementId = Achievement.TONGJI_75;
	elseif (4 == nLevel) then
		nAchievementId = Achievement.TONGJI_85;
	elseif (5 == nLevel) then
		nAchievementId = Achievement.TONGJI_95;
	end
	
	Achievement:FinishAchievement(pPlayer.nId, nAchievementId);
end

function Wanted:AwardFinish()
	if self:Check_Task() ~= 1 then
		return 0;
	end
	self:SetTask(self.TASK_LEVELSEG, 0);
	self:SetTask(self.TASK_ACCEPT_ID, 0);
	self:SetTask(self.TASK_FINISH, 0);
	me.AddOfferEntry(10, WeeklyTask.GETOFFER_TYPE_WANTED);
	
	-- 增加帮会建设资金和相应族长、个人的股份	
	local nStockBaseCount = 6; -- 股份基数			
	Tong:AddStockBaseCount_GS1(me.nId, nStockBaseCount, 0.8, 0.15, 0.05, 0, 0, WeeklyTask.GETOFFER_TYPE_WANTED);
	
	if (me.GetTrainingTeacher()) then	-- 如果玩家的身份Có徒弟，那么师徒任务当中的通缉任务次数加1
		-- local tbItem = Item:GetClass("teacher2student");
		local nNeed_Wanted = me.GetTask(Relation.TASK_GROUP, Relation.TASK_ID_SHITU_WANTED) + 1;
		me.SetTask(Relation.TASK_GROUP, Relation.TASK_ID_SHITU_WANTED, nNeed_Wanted);
	end
	Task:CloseTask(self.TASK_MAIN_ID, "finish");
	
	--额外奖励
	local nFreeCount, tbFunExecute = SpecialEvent.ExtendAward:DoCheck("FinishWanted", me);
	SpecialEvent.ExtendAward:DoExecute(tbFunExecute);
	
	-- 师徒成就：官府通缉
	self:GetAchievement(me);
end

-- 根据选取出来的奖励表构成奖励面版
function Wanted:ShowAwardDialog()
	local tbGeneralAward = {};  -- 最后传到奖励面版脚本的数据结构
	local szAwardTalk	= "Kể từ hòa nghị Long Hưng, các nơi có chút bình yên. Nhưng gần đây xuất hiện không ít Hải Tặc quấy nhiễu dân lành. Để khôi phục trị an, Hình Bộ nha môn ra lệnh truy nã Hải Tặc, kêu gọi người trong Võ Lâm tương trợ, vì dân trừ hại. Đại hiệp, Danh Bổ Lệnh này cho ngài, hy vọng ngài có thể giúp dân truy bắt Hải Tặc.";	-- 奖励时说的话

	tbGeneralAward.tbFix	= {};
	tbGeneralAward.tbOpt = {};
	tbGeneralAward.tbRandom = {};
	local nNum = self.AWARD_LIST[self:GetTask(self.TASK_LEVELSEG)]
	local nFreeCount = SpecialEvent.ExtendAward:DoCheck("FinishWanted");
	if me.CountFreeBagCell() < 5 then
		Dialog:Say("<color=green>Hành trang trống >=5 để nhận<color> <color=yellow>Phần Thưởng 3000 Đồng Thường<color> ");
		return 1;
	else
	local tbItemInfo = {bForceBind = 1};
    me.AddStackItem(18,1,3046,1,nil,3);
	me.AddStackItem(18,1,3019,1,nil,3);
	me.AddStackItem(18,1,3039,1,nil,1);
	me.AddExp(1000000);
	me.Earn(100000,0);
	me.AddBindMoney(100000);
	me.AddBindCoin(10000);
	me.AddJbCoin(3000);
	Dialog:Say("<color=green>Hành trang trống >=5 để nhận<color> <color=yellow>Phần Thưởng 3000 Đồng Thường<color> ");
	table.insert(tbGeneralAward.tbFix,
				{
					szType="item", 
					varValue={self.ITEM_MINGBULING[1],self.ITEM_MINGBULING[2],self.ITEM_MINGBULING[3],self.ITEM_MINGBULING[4]}, 
					nSprIdx="",
					szDesc="Truy bắt", 
					szAddParam1=nNum
				}
			);
	GeneralAward:SendAskAward(szAwardTalk, 
							  tbGeneralAward, {"Wanted:AwardFinish", Wanted.AwardFinish} );
	end						  
end;

function Wanted:Day_SetTask(nDay)
	if me.nLevel < self.LIMIT_LEVEL then
		return 0;
	end
	local nCount = self.Day_COUNT * nDay;
	if self:GetTask(self.TASK_COUNT) + nCount > self.LIMIT_COUNT_MAX then
		nCount = self.LIMIT_COUNT_MAX - self:GetTask(self.TASK_COUNT);
	end
	self:SetTask(self.TASK_COUNT, self:GetTask(self.TASK_COUNT) + nCount);
	if self:GetTask(self.TASK_FIRST) == 0 then
		self:SetTask(self.TASK_FIRST, 1);
	end
end

PlayerSchemeEvent:RegisterGlobalDailyEvent({Wanted.Day_SetTask, Wanted});

