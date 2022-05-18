

local tbItem = Item:GetClass("xiulianzhu");

tbItem.tbExpLimit = {
	[1]		= 300000,	-- 10~19
	[2]		= 480000,	-- 20~29 ľޣ2ʾǳ10
	[3]		= 800000,	-- 30~39
	[4]		= 1200000,	-- 40~49
	[5]		= 1680000,	-- 50~59 
	[6]		= 2200000,	-- 60~69
	[7]		= 2880000,	-- 70~79
	[8]		= 3600000,	-- 80~89
	[9]		= 4400000,	-- 90~99
	[10]	= 5280000,	-- 100~109
	[11]	= 6200000,	-- 110~119
	[12]	= 7240000,	-- 120~129
	[13]	= 8400000,	-- 130~139
	[14]	= 9600000,	-- 140~149
	[15]	= 9600000,	-- 150
};

tbItem.tbXiuWeiLimit = {
	[1] = 2400,
	[2] = 2400,
	[3] = 4000,
	[4] = 6000,
	[5] = 8400,
	[6] = 11200,
	[7] = 14400,
	[8] = 18000,
	[9] = 22000,
	[10] = 26400,
};

tbItem.TASKGROUPID_HAVETASK = 1022; 

tbItem.tbTaskHaveId = {
	[2] = 188, 
	[3] = 189,
	[4] = 190,	
};

tbItem.tbPlayerTaskId = {
	[2] = {
			[1]		= { 0x184, 0x245 },
			[2]		= { 0x17F, 0x240 }, 
			[3]		= { 0x187, 0x248 },
			[4]		= { 0x181, 0x242 },
			[5]		= { 0x186, 0x247 },
			[6]		= { 0x188, 0x249 },
			[7]		= { 0x180, 0x241 },
			[8]		= { 0x185, 0x246 },
			[9]		= { 0x183, 0x244 },
			[10]	= { 0x182, 0x243 },
			[11]	= { 0x189, 0x24A },
			[12]	= { 0x18A, 0x24B },
		},
	[3] = {
			[1]		= { 0x19A, 0x25B }, 
			[2]		= { 0x195, 0x256 },
			[3]		= { 0x19D, 0x25E },
			[4]		= { 0x197, 0x258 },
			[5]		= { 0x19C, 0x25D },
			[6]		= { 0x19E, 0x25F },
			[7]		= { 0x196, 0x257 },
			[8]		= { 0x19B, 0x25C },
			[9]		= { 0x199, 0x25A },
			[10]	= { 0x198, 0x259 },
			[11]	= { 0x19F, 0x260 },
			[12]	= { 0x1A0, 0x261 },
		},
	[4] = {
			[1]		= { 0x1A6, 0x267 }, 
			[2]		= { 0x1A1, 0x262 },
			[3]		= { 0x1A9, 0x26A },
			[4]		= { 0x1A3, 0x264 },
			[5]		= { 0x1A8, 0x269 },
			[6]		= { 0x1AA, 0x26B },
			[7]		= { 0x1A2, 0x263 },
			[8]		= { 0x1A7, 0x268 },
			[9]		= { 0x1A5, 0x266 },
			[10]	= { 0x1A4, 0x265 },
			[11]	= { 0x1AB, 0x26C },
			[12]	= { 0x1AC, 0x26D },		
		},
	};


tbItem.MIN_PLAYER_LEVEL		= Item.IVER_nXiuLianZhuLevel;			
tbItem.TASKGROUP			= 1023;			
tbItem.TASKLASTTIME_ID		= 1;			
tbItem.TASKREMAINTIME_ID	= 2;			
tbItem.TASKEXPLIMIT_ID		= 3;			
tbItem.TASKXIUWEI_ID		= 4;			
tbItem.TASKOLDPRTIME_ID		= 5;			
tbItem.TASKCANGETEXTIME_ID	= 6;			
tbItem.MAX_REMAINTIME		= 14;			
tbItem.SKILL_ID_EXP			= 332;			
tbItem.SKILL_ID_LUCKY		= 333;			
tbItem.SKILL_ID_XIUWEI		= 380;			
tbItem.XIULIANREMAINTIME	= 1.5;			
tbItem.EXPTIMES				= 1.2;			
tbItem.SKILL_ID_EXP_LEVEL	= Item.IVER_nXiuLianZhuSkillLevel;			
tbItem.TASK_XIULIAN_ADDTIME	= 7;			
tbItem.LIMIT_ADDTIME		= 10;

tbItem.TASK_GROUP_COZONE 	= 2065;			
tbItem.TASK_GETEXTIME_FLAG 	= 2;			
tbItem.TASK_SUBPLAYER_EXTIME = 3;			


function tbItem:OnLevelUp(nLevel)
	if (nLevel < self.MIN_PLAYER_LEVEL) then
		return;
	end
	if (me.GetTask(self.TASKGROUP,self.TASKLASTTIME_ID) ~= 0) then
		return;
	end
	local nNowTime		= GetTime();
	local nRemainTime	= self.XIULIANREMAINTIME;		
	local nRemainExp	= 0;
	me.SetTask(self.TASKGROUP, self.TASKLASTTIME_ID, nNowTime);
	me.SetTask(self.TASKGROUP, self.TASKREMAINTIME_ID, nRemainTime * 10);
	me.SetTask(self.TASKGROUP, self.TASKEXPLIMIT_ID, nRemainExp);
end

function tbItem:OnUse()
	local tbOpt = {};
	local tbGerneFaction = Faction:GetGerneFactionInfo(me);
	
	for _, nFactionId in ipairs(tbGerneFaction)do
		if(nFactionId ~= me.nFaction)then
			local szMsg = "Thay đổi đến ".. tostring(Player.tbFactions[nFactionId].szName);
			table.insert(tbOpt, 1, {szMsg, self.OnSwitchFaction, self, nFactionId});
		
		end
	end
	
	--table.insert(tbOpt, 2, {"Linh Hồn Tu Luyện Bảo", self.thanhlinhluyen, self});
	
	local nNowLevel = me.nLevel;
	if (self.MIN_PLAYER_LEVEL > nNowLevel) then	
		tbOpt = Lib:MergeTable( tbOpt, {{"Kết thúc đối thoại"}});
		Dialog:Say(string.format("Bạn chưa đạt đến cấp %d quy định của trạng thái tu luyện, hãy tiếp tục cố gắng!", tbItem.MIN_PLAYER_LEVEL),
			tbOpt);
		return 0;
	end	
	
	if (20 < me.nLevel and 50 > me.nLevel and me.nFaction > 0) then
		local nIndex	= math.floor(me.nLevel / 10);
		local nMod		= math.fmod(me.nLevel, 10);
		local nHaveTaskId = self.tbTaskHaveId[nIndex];
		if (nHaveTaskId) then
			if (nMod > 0) then
				local nFlag = me.GetTask(self.TASKGROUPID_HAVETASK, nHaveTaskId);
				if (nFlag == 0) then
					tbOpt = Lib:MergeTable({{string.format("Nhiệm vụ phụ tuyến môn phái cấp %d", nIndex * 10), self.CheckFactionTask, self, nIndex}}, tbOpt);
				end
			end
		end
	end

	self:Update();
	
	local nExpSkillLevel, nExpStateType, nExpEndTime, bExpIsNoClearOnDeath			= me.GetSkillState(self.SKILL_ID_EXP);
	local nLuckySkillLevel, nLuckyStateType, nLuckyEndTime, bLuckyIsNoClearOnDeath	= me.GetSkillState(self.SKILL_ID_LUCKY);
	
	local nRemainTime	= self:GetRemainTime();
	local nMiniter		= (nRemainTime % 1) * 60;
	

	local nRemainTime	= self:GetRemainTime();
	local nMiniter		= (nRemainTime % 1) * 60;
	local szMsg	= "    Đặt tay lên cảm thấy khí huyết cuộn dâng. " ..
		"<color=yellow>Bạn có thể mở trạng thái tu luyện để nhận kinh nghiệm đánh quái x2 và tăng 10 điểm may mắn,<color> <color=red>một khi đã mở tu luyện sẽ không thể đóng lại trước khi hết giờ.<color>" ..
		string.format("\n    Thời gian tu luyện tích lũy còn: <color=green>%d<color> <color=yellow>giờ<color> <color=green>%d<color> <color=yellow>phút<color>. Bạn muốn mở bao lâu?", nRemainTime, nMiniter);
	tbOpt = Lib:MergeTable({{"<color=yellow>Nhận thưởng hàng ngày<color>", SpecialEvent.PhanThuong.OnDialog, SpecialEvent.PhanThuong}}, tbOpt);	
		tbOpt = Lib:MergeTable({{"<color=green>Tụ Linh Thánh Linh<color>", self.thanhlinhmienphi, self}}, tbOpt);	
-- {"<color=green>Tụ Linh Thánh Linh<color>", self.thanhlinhmienphi, self},
		tbOpt = Lib:MergeTable( tbOpt,{
			{"Ta muốn mở tu luyện", self.OnOpenXiuLianSure, self},
			{"Kết thúc đối thoại"},
		});
	
	Dialog:Say(szMsg, tbOpt);

	return 0;
end

function tbItem:OnOpenXiuLianSure()
	local nRemainTime	= self:GetRemainTime();
	local nMiniter		= (nRemainTime % 1) * 60;
	local szMsg	= "    Đặt tay lên cảm thấy khí huyết cuộn dâng. " ..
		"<color=yellow>Bạn có thể mở trạng thái tu luyện để nhận kinh nghiệm đánh quái x2 và tăng 10 điểm may mắn,<color> <color=red>một khi đã mở tu luyện sẽ không thể đóng lại trước khi hết giờ.<color>" ..
		string.format("\n    Thời gian tu luyện tích lũy còn: <color=green>%d<color> <color=yellow>giờ<color> <color=green>%d<color> <color=yellow>phút<color>. Bạn muốn mở bao lâu?", nRemainTime, nMiniter);
	local tbOpt = 
	{
			{"Ta muốn mở 0.5 giờ.",	self.StartPractice, self, 0.5},
			{"Ta muốn mở 1 giờ.",		self.StartPractice, self, 1},
			{"Ta muốn mở 1.5 giờ.",	self.StartPractice, self, 1.5},
			{"Ta muốn mở 2 giờ.",		self.StartPractice, self, 2},
			{"Ta muốn mở 4 giờ.",		self.StartPractice, self, 4},
			{"Ta muốn mở 6 giờ.",		self.StartPractice, self, 6},
			{"Ta muốn mở 8 giờ.",		self.StartPractice, self, 8},
			{"Không mở nữa."},
	}
	Dialog:Say(szMsg, tbOpt);
end

function tbItem:OnSwitchFaction(nFactionId)
	local tbOpt = {
			{"Đồng ý", self.OnSwitchFactionEx, self, nFactionId},
			{"Hủy"},
		};
		
	Dialog:Say("Xác định muốn đổi môn phái?\n\n<color=green>Sau khi đổi tham gia nhiệm vụ nghĩa quân, Chiến trường Tống Kim, ải gia tộc, Bạch Hổ Đường sẽ nhận được danh vọng ngũ hành tương ứng với môn phái mới, đồng thời đến chỗ NPC mua trang bị danh vọng ngũ hành tương ứng với môn phái mới.<color>", tbOpt);
end

function tbItem:OnSwitchFactionEx(nFactionId)
	local nResult, szMsg = Faction:SwitchFaction(me, nFactionId);
	if (szMsg) then
		me.Msg(szMsg)
	end
end

function tbItem:GetReTime()
	self:Update();
	return me.GetTask(self.TASKGROUP, self.TASKREMAINTIME_ID) / 10;
end

function tbItem:GetRemainTime()
	return me.GetTask(self.TASKGROUP, self.TASKREMAINTIME_ID) / 10;
end

-- ״̬
function tbItem:StartPractice(nChooseTime)
	self:Update();
	local nRemainTime = self:GetRemainTime();
	local szMsg = "";
	local tbOpt = {};
	local nNewLunckyTime	= 0;
	local nNewExpTime		= 0;
	local nNewXiuWeiTime	= 0;
	if (nChooseTime > nRemainTime) then
		szMsg = string.format("Thời gian tu luyện bạn tích lũy không đủ, không thể mở trạng thái tu luyện <color=yellow>(%.1f)<color> giờ.", nChooseTime);
	else
		local nLuckySkillLevel, nLuckyStateType, nLuckyEndTime, bLuckyIsNoClearOnDeath	= me.GetSkillState(self.SKILL_ID_LUCKY);
		local nExpSkillLevel, nExpStateType, nExpEndTime, bExpIsNoClearOnDeath			= me.GetSkillState(self.SKILL_ID_EXP);
		local nXiuSkillLevel, nXiuStateType, nXiuEndTime, bXiuIsNoClearOnDeath			= me.GetSkillState(self.SKILL_ID_XIUWEI);
		if (not nLuckyEndTime) then
			nLuckyEndTime = 0;
		end
		
		if (not nExpEndTime) then
			nExpEndTime = 0;
		end
		
		if (not nXiuEndTime) then
			nXiuEndTime = 0;
		end
		
		szMsg = string.format("Bạn đã tăng <color=yellow>(%.1f)<color> giờ tu luyện, bây giờ đánh quái nhận được <color=yellow>2<color> lần kinh nghiệm, đồng thời may mắn tăng <color=yellow>10<color>!", nChooseTime);
		nRemainTime = nRemainTime - nChooseTime;
		local nRemainExp 	= self:GetExpLimit();
		local nXiuWeiLimit	= self:GetXiuWeiLimit();
		local nRemainLimitExp = me.GetTask(self.TASKGROUP, self.TASKEXPLIMIT_ID);
		if (not nExpSkillLevel or nExpSkillLevel <= 0) then
			nRemainLimitExp = 0;
		end		
		local nAddExp		= nRemainExp * nChooseTime + nRemainLimitExp;
		nNewExpTime			= nChooseTime * 18 * 3600 + nExpEndTime;
		nNewLunckyTime		= nChooseTime * 18 * 3600 + nLuckyEndTime;
		nNewXiuWeiTime		= nChooseTime * 18 * 3600 + nXiuEndTime;

		if (nRemainExp * self.LIMIT_ADDTIME < nAddExp) then
			Dialog:Say("Kinh nghiệm tích lũy của Tu Luyện Châu vượt hơn mức tối đa so với kinh nghiệm hiện tại, không thể mở nữa!");
			return 0;
		end


		local nRemainXiuwei = me.GetTask(self.TASKGROUP, self.TASKXIUWEI_ID);
		if (not nXiuSkillLevel or nXiuSkillLevel <= 0) then
			nRemainXiuwei = 0;
		end
		local nAddXiuWei	= nXiuWeiLimit * nChooseTime + nRemainXiuwei;		
		me.AddSkillState(self.SKILL_ID_EXP, self.SKILL_ID_EXP_LEVEL, 1, nNewExpTime, 1);
		me.SetTask(self.TASKGROUP, self.TASKEXPLIMIT_ID, nAddExp);
		me.AddSkillState(self.SKILL_ID_LUCKY, 2, 1, nNewLunckyTime, 1);
		me.AddSkillState(self.SKILL_ID_XIUWEI, 1, 1, nNewXiuWeiTime, 1);
		me.SetTask(self.TASKGROUP, self.TASKXIUWEI_ID, nAddXiuWei);
		me.SetTask(self.TASKGROUP, self.TASKREMAINTIME_ID, nRemainTime * 10);
		
		Stats.Activity:AddCount(me, Stats.TASK_COUNT_XIULIANZHU, nChooseTime * 10);
	end
	Dialog:Say(szMsg,"Kết Thúc Đối Thoại");
end

function tbItem:ExpExhausted()
	local nExpSkillLevel, nExpStateType, nExpEndTime, bExpIsNoClearOnDeath = me.GetSkillState(self.SKILL_ID_EXP);
	local nXiuSkillLevel, nXiuStateType, nXiuEndTime, bXiuIsNoClearOnDeath = me.GetSkillState(self.SKILL_ID_XIUWEI);
	if (nExpSkillLevel < 0) then
		return;
	end
	me.RemoveSkillState(self.SKILL_ID_EXP);
	if (nXiuSkillLevel > 0) then
		me.Msg("Bạn đạt đến giới hạn kinh nghiệm tu luyện, đánh quái sẽ không được kinh nghiệm x2, nhưng vẫn được tu luyện mật tịch và tăng 10 điểm may mắn.");
	else
		me.Msg("Bạn đạt đến giới hạn kinh nghiệm tu luyện, đánh quái sẽ không được kinh nghiệm x2, nhưng vẫn nhận được mật tịch và tăng 10 điểm may mắn.");		
	end
end

function tbItem:XiuWeiExhausted()
	local nXiuSkillLevel, nXiuStateType, nXiuEndTime, bXiuIsNoClearOnDeath = me.GetSkillState(self.SKILL_ID_XIUWEI);
	local nExpSkillLevel, nExpStateType, nExpEndTime, bExpIsNoClearOnDeath = me.GetSkillState(self.SKILL_ID_EXP);
	if (nXiuSkillLevel < 0) then
		return;
	end
	me.RemoveSkillState(self.SKILL_ID_XIUWEI);
	if (nExpSkillLevel > 0) then
		me.Msg("Bạn đạt đến giới hạn tu luyện mật tịch, độ tu luyện mật tịch kỹ năng sẽ không tăng, nhưng vẫn nhận được kinh nghiệm đánh quái x2 và tăng 10 điểm may mắn.");
	else
		me.Msg("Bạn đạt đến giới hạn tu luyện mật tịch, độ tu luyện mật tịch kỹ năng sẽ không tăng, nhưng vẫn nhận được kinh nghiệm đánh quái x2 và tăng 10 điểm may mắn.");
	end
end

function tbItem:CheckFactionTask(nIndex)
	if (20 >= me.nLevel or 50 <= me.nLevel) then
		Dialog:Say("Hiện giờ cấp của bạn không thể nhận nhiệm nhiệm vụ đánh quái của môn phái!");
		return 0;
	end
	
	if (me.nFaction <= 0) then
		Dialog:Say("Bạn chưa gia nhập môn phái, không thể nhận nhiệm vụ môn phái");
	end
	
	local nNowIndex = math.floor(me.nLevel / 10);
	local nMod		= math.fmod(me.nLevel, 10);
	
	if (nMod == 0) then
		return 0;
	end
	
	local tbTaskList = self.tbPlayerTaskId[nNowIndex];
	if (not tbTaskList) then
		Dialog:Say("Nhiệm vụ môn phái của cấp hiện tại không tồn tại!");
		return 0;
	end
	
	local tbOpt = {};
	for i, tbTask in ipairs(tbTaskList) do
		if (tbTask[1] and tbTask[2]) then
			if (Task:HaveDoneSubTask(me, tbTask[1], tbTask[2]) == 0 and Task.tbTaskDatas[tbTask[1]]) then
				local szTaskName = Task.tbTaskDatas[tbTask[1]].szName;
				local tbReferData	= Task.tbReferDatas[tbTask[2]];
				if (tbReferData) then
					local tbVisable	= tbReferData.tbVisable;
					local bOK	= Lib:DoTestFuncs(tbVisable);
					if (bOK) then
						local tbSubData	= Task.tbSubDatas[tbReferData.nSubTaskId];
						if (tbSubData) then
							local szMsg = "";
							if (tbSubData.tbAttribute.tbDialog.Start) then
								if (tbSubData.tbAttribute.tbDialog.Start.szMsg) then 		
									szMsg = tbSubData.tbAttribute.tbDialog.Start.szMsg;
								else
									szMsg = tbSubData.tbAttribute.tbDialog.Start.tbSetpMsg[1];
								end
							end
							tbOpt[#tbOpt + 1] = {szTaskName, TaskAct.TalkInDark, TaskAct, szMsg, Task.AskAccept, Task, tbTask[1], tbTask[2]};		
						end
					end
				end
			end
		end
	end
	tbOpt[#tbOpt + 1] = {"Để ta suy nghĩ đã"};
	Dialog:Say(string.format("Danh sách nhiệm vụ môn phái %d: ", nNowIndex * 10), tbOpt);
end

function tbItem:GetExpLimit()
	local nExpLimit = 0;
	local nLevel = me.nLevel;
	local nIndex = 0;
	if (nLevel < self.MIN_PLAYER_LEVEL) then
		return nExpLimit;
	elseif (nLevel > 150) then
		nIndex = 15;
	else
		nIndex = math.floor(nLevel / 10);
	end
	nExpLimit = self.tbExpLimit[nIndex] * self.EXPTIMES;
	return nExpLimit;
end

function tbItem:GetXiuWeiLimit()
	local nXiuLimit = 0;
	local nLevel = me.nLevel;
	local nIndex = 0;
	if (nLevel < self.MIN_PLAYER_LEVEL) then
		return nXiuLimit;
	elseif (nLevel > 100) then
		nIndex = 10;
	else
		nIndex = math.floor(nLevel / 10);
	end
	nXiuLimit = self.tbXiuWeiLimit[nIndex] * 2;
	return nXiuLimit;
end

function tbItem:Update()
	local nLastTime		= me.GetTask(self.TASKGROUP, self.TASKLASTTIME_ID);
	local nNowTime		= GetTime();
	local nDays			= self:CalculateDay(nLastTime, nNowTime);
	local nRemainTime	= nDays * 1.5 + self:GetRemainTime();
	if (nRemainTime < 0.1) then
		nRemainTime = 0;
	end
	if (nRemainTime > self.MAX_REMAINTIME) then
		nRemainTime = self.MAX_REMAINTIME;
	end
	
	if (nLastTime <= 0) then
		nRemainTime = 1.5;
	end
	
	me.SetTask(self.TASKGROUP, self.TASKLASTTIME_ID, nNowTime);
	me.SetTask(self.TASKGROUP, self.TASKREMAINTIME_ID, nRemainTime * 10); -- Сʱʮ
end

function tbItem:CalculateDay(nLastTime, nNowTime)
	local nLastDay 	= Lib:GetLocalDay(nLastTime);
	local nNowDay	= Lib:GetLocalDay(nNowTime);
	local nDays		= nNowDay - nLastDay;
	if (nDays < 0) then
		nDays = 0;
	end
	return nDays;
end

function tbItem:GetTip(nState)
	local nLuckySkillLevel, nLuckyStateType, nLuckyEndTime, bLuckyIsNoClearOnDeath	= me.GetSkillState(self.SKILL_ID_LUCKY);
	local szTip = "";

	local nLastTime		= me.GetTask(self.TASKGROUP, self.TASKLASTTIME_ID);
	local nNowTime		= GetTime();
	local nDays			= self:CalculateDay(nLastTime, nNowTime);
	local nRemainTime	= nDays * 1.5 + me.GetTask(self.TASKGROUP, self.TASKREMAINTIME_ID) / 10;
	if (nRemainTime < 0.1) then
		nRemainTime = 0;
	end
	if (nRemainTime > self.MAX_REMAINTIME) then
		nRemainTime = self.MAX_REMAINTIME;
	end

	local nMiniter		= (nRemainTime % 1) * 60;
	local szRemainMsg	= string.format("Thời gian tu luyện tích lũy hiện tại: <color=green>%d<color><color=yellow> giờ <color><color=green>%d<color><color=yellow> phút<color>,\n", nRemainTime, nMiniter);


	if (not nLuckyEndTime) then
		nLuckyEndTime	= 0;
		szTip = szTip..string.format(szRemainMsg .. "<color=0x8080ff>Nhấn chuột phải dùng<color>.");
	else
		szTip = szTip..string.format(szRemainMsg .. "<color=0x8080ff> đã trong trạng thái tu luyện<color>.");
	end
	return szTip;
end

function tbItem:GetXiuLianZhuInfo()
	local pPlayer 		= me;
	self:Update();
	local nCount 		= pPlayer.GetItemCountInBags(18,1,16,1);
	local nRemainTime	= pPlayer.GetTask(self.TASKGROUP, self.TASKREMAINTIME_ID) / 10;
	local nLuckySkillLevel, nLuckyStateType, nLuckyEndTime, bLuckyIsNoClearOnDeath	= pPlayer.GetSkillState(self.SKILL_ID_LUCKY);
	if (0 >= nLuckySkillLevel) then
		nLuckyEndTime = 0;
	end
	return nCount, nRemainTime, nLuckyEndTime;
end

function tbItem:AddRemainTime(nMin)
	local nHour = self:GetReTime() + string.format("%0.1f",nMin/60);
	if nHour > self.MAX_REMAINTIME then
		nHour = self.MAX_REMAINTIME
	end
	me.SetTask(self.TASKGROUP, self.TASKREMAINTIME_ID, (nHour*10));
end

function tbItem:CheckAddableCommon(bAdd, ...)
	
	-- add private condition
	if arg[1] ~= nil then
		
		-- private callback
		local bOk = arg[1](unpack(arg, 2));
		
		if bOk ~= 1 then
		 	return 0;
		end
	end  
	
	-- check
	if (not bAdd) or (bAdd ~= 1) then
		
		-- get remain extra time
		local nExtraTime = me.GetTask(self.TASKGROUP, self.TASK_XIULIAN_ADDTIME);
		
		if nExtraTime <= 0 then
			return 0;
		end
		
		return 1;
	
	-- add
	elseif (bAdd == 1) then
		
		-- get remain xiulian time
		local nRemainTime = self:GetRemainTime();
		
		-- get remain extra time
		local nExtraTime = me.GetTask(self.TASKGROUP, self.TASK_XIULIAN_ADDTIME) / 10;
		
		-- full time
		if (nRemainTime >= self.MAX_REMAINTIME) then
			Dialog:Say(string.format("Thời gian tu luyện đã đủ, không thể nhận thời gian tu luyện bổ sung.\n\nThời gian tu luyện bổ sung: <color=yellow>%s giờ<color>", nExtraTime));
			return 0;
		end

		-- free time
		local nFreeTime = self.MAX_REMAINTIME - nRemainTime;
		
		if (nFreeTime > nExtraTime) then
			nFreeTime = nExtraTime;
		end
		
		-- add minute
		self:AddRemainTime(nFreeTime * 60);
		
		-- dec extra time
		nExtraTime = nExtraTime - nFreeTime;
		
		-- save task
		me.SetTask(self.TASKGROUP, self.TASK_XIULIAN_ADDTIME, nExtraTime * 10);
		
		Dialog:Say("Thời gian tu luyện của bạn đã tăng <color=yellow>" .. nFreeTime .. "<color> giờ, thời gian tu luyện bổ sung: <color=yellow>" .. nExtraTime .. "<color> giờ.");
	end
end

function tbItem:CheckAddable(bAdd)
	local nBufLevel = me.GetSkillState(881);
	local nCurDate = tonumber(os.date("%Y%m%d", GetTime()));
	local nDate = me.GetTask(2038, 4)
	if nBufLevel > 0 and nDate ~= nCurDate then
		if bAdd == 1 then
			if self:GetRemainTime() == 14 then
				Dialog:Say("Thời gian tu luyện của bạn đã đầy, không thể nhận thời gian tu luyện thêm.")
				return 0;
			end
			self:AddRemainTime(30);
			me.SetTask(2038, 4, nCurDate);
			Dialog:Say("Thời gian tu luyện của bạn đã tăng <color=green>30 phút<color>");
		end	
		return 1;
	else
		if bAdd == 1 then
			Dialog:Say("Bạn đã dùng hết thời gian tu luyện")
		end
		return 0;
	end
end

function tbItem:CheckAddableCoZone(bAdd)
	local nCurDate = tonumber(os.date("%Y%m%d", GetTime()));
	local nDate = me.GetTask(2065, 1)
	if GetTime() < KGblTask.SCGetDbTaskInt(DBTASK_COZONE_TIME) + 7 * 24 * 60 * 60 and nDate ~= nCurDate then
		if bAdd == 1 then
			if self:GetRemainTime() == 14 then
				Dialog:Say("Thời gian tu luyện của bạn đã đầy, không thể nhận thời gian tu luyện thêm.")
				return 0;
			end
			self:AddRemainTime(120);
			me.SetTask(2065, 1, nCurDate);
			Dialog:Say("Thời gian tu luyện của bạn đã tăng <color=green>2 giờ<color>");
		end	
		return 1;
	else
		if bAdd == 1 then
			Dialog:Say("Bạn đã dùng hết thời gian tu luyện")
		end
		return 0;
	end
end

function tbItem:CheckAddableSubPlayer(bAdd)
	if (me.nLevel < 50) then
		return 0;
	end
	if (me.IsSubPlayer() == 0 and 1 == me.GetTask(self.TASK_GROUP_COZONE, self.TASK_GETEXTIME_FLAG)) then
		me.SetTask(self.TASK_GROUP_COZONE, self.TASK_GETEXTIME_FLAG, 0);
	end
	if (not bAdd) then
		if (me.IsSubPlayer() == 1 and 0 == me.GetTask(self.TASK_GROUP_COZONE, self.TASK_GETEXTIME_FLAG)) then
			local nExtraTime = math.floor(KGblTask.SCGetDbTaskInt(DBTASK_SERVER_STARTTIME_DISTANCE) / (24 * 3600)) * 0.5 * 10;
			me.SetTask(self.TASK_GROUP_COZONE, self.TASK_GETEXTIME_FLAG, 1);
			if (nExtraTime >= 0) then
				me.SetTask(self.TASK_GROUP_COZONE, self.TASK_SUBPLAYER_EXTIME, nExtraTime);
			end
		end
		if (me.GetTask(self.TASK_GROUP_COZONE, self.TASK_SUBPLAYER_EXTIME) > 0) then
			return 1;
		else
			return 0;
		end
	end
	if (bAdd == 1 and me.GetTask(self.TASK_GROUP_COZONE, self.TASK_SUBPLAYER_EXTIME) >= 0) then
		local nExtraTime = me.GetTask(self.TASK_GROUP_COZONE, self.TASK_SUBPLAYER_EXTIME) / 10;
		local nStillHaveTime = self:GetRemainTime();
		local nNeedTime = 14 - nStillHaveTime;
		if (nExtraTime == 0) then
			Dialog:Say("Thời gian tu luyện thêm đã hết, không thể bổ sung.");
			return 0;
		end
		if (nStillHaveTime == 14) then
			Dialog:Say("Thời gian tu luyện đã đủ, không cần bổ sung.");
			return 0;
		end
		if (nExtraTime >= 0 and nExtraTime < nNeedTime) then
			nNeedTime = nExtraTime;
		end
		self:AddRemainTime(nExtraTime * 60);
		nExtraTime = nExtraTime - nNeedTime;
		if (nExtraTime < 0) then
			nExtraTime = 0;
		end
		me.SetTask(self.TASK_GROUP_COZONE, self.TASK_SUBPLAYER_EXTIME, nExtraTime * 10);
		Dialog:Say("Đã bổ sung thời gian tu luyện <color=yellow>" .. nNeedTime .. "<color> giờ, thời gian tu luyện còn <color=yellow>" .. nExtraTime .. "<color> giờ.");
		return 1;
	else
		return 0;
	end
end

function tbItem:CheckOldPCallBack(bAdd)
	if ((not bAdd) or (bAdd ~= 1)) then
		if EventManager.ExEvent.tbPlayerCallBack:IsOpen(me, 3) == 1 and
			me.GetTask(self.TASKGROUP, self.TASKCANGETEXTIME_ID) == 0 then
			local nCanAddTime = me.GetTask(self.TASKGROUP, self.TASKOLDPRTIME_ID);
			if (0 == nCanAddTime and (0 == me.GetTask(self.TASKGROUP, self.TASKCANGETEXTIME_ID))) then
				local nLeaveDay = EventManager.ExEvent.tbPlayerCallBack:GetLeaveDay(me);
				nCanAddTime = nLeaveDay * 0.5 * 10;
				me.SetTask(self.TASKGROUP, self.TASKOLDPRTIME_ID, nCanAddTime);
				me.SetTask(self.TASKGROUP, self.TASKCANGETEXTIME_ID, 1);
			end				
			return 1;
		end
		
		if me.GetTask(self.TASKGROUP, self.TASKCANGETEXTIME_ID) == 1 and me.GetTask(self.TASKGROUP, self.TASKOLDPRTIME_ID) > 0 then
			return 1;
		end
		
		return 0;
	elseif (bAdd == 1) then
		local nRemainTime = self:GetReTime();
		local nCanAddTime = me.GetTask(self.TASKGROUP, self.TASKOLDPRTIME_ID) / 10;
		if (nRemainTime >= self.MAX_REMAINTIME) then
			Dialog:Say(string.format("Thời gian tu luyện của bạn đã đầy, không cần thêm.\n\n<color=yellow>Thời gia tu luyện thêm còn: %s giờ<color>", nCanAddTime));
			return 0;
		end

		local nNeedTime = (self.MAX_REMAINTIME - nRemainTime)
		if (nNeedTime > nCanAddTime) then
			nNeedTime = nCanAddTime;
		end
		self:AddRemainTime(nNeedTime * 60);
		nCanAddTime = nCanAddTime - nNeedTime;
		me.SetTask(self.TASKGROUP, self.TASKOLDPRTIME_ID, nCanAddTime * 10);
		Dialog:Say("Thời gian tu luyện của bạn đã tăng <color=yellow>" .. nNeedTime .. "<color> giờ, thời gian tu luyện có thể nhận thêm: <color=yellow>" .. nCanAddTime .. "<color> giờ.");
	end
end

function tbItem:CheckAddablePreMonth(bAdd)
	local nCurDate = tonumber(GetLocalDate("%y%m%d"));
	local szMsg = string.format(
	[[%s tích lũy %s đạt <color=red>%s<color>, có thể nhận được những ưu đãi sau:
   <color=yellow>
 Thêm một lần chúc phúc mỗi ngày <color>
   (Tự nhận) 
 <color=yellow>
 Thêm 30 phút x2 kinh nghiệm mỗi ngày <color>
   (Nhận từ Tu Luyện Châu)
   <color=yellow>
 1 Vô Hạn Truyền Tống Phù (1 tháng)<color>
   (Nhanh chóng nhận được khi có đặc quyền nạp thẻ)<color=yellow>
   <color=yellow>
 1 Càn Khôn Phù (10 lần)<color>
   (Nhanh chóng nhận được khi có đặc quyền nạp thẻ)
  <color=yellow>
 Mỗi tuần nhận 20 điểm Uy danh giang hồ<color>
   (Đạt cấp 60, %s đạt %s, mỗi tuần đến chỗ Lễ Quan nhận 10 điểm Uy danh giang hồ. %s đạt %s, mỗi tuần đến chỗ Lễ Quan nhận 20 điểm Uy danh giang hồ)
]],IVER_g_szPayMonth, IVER_g_szPayName, IVER_g_szPayLevel2, IVER_g_szPayName, IVER_g_szPayLevel1, IVER_g_szPayName, IVER_g_szPayLevel2
	);
	if me.GetTask(2038, 6) < nCurDate then
		if bAdd == 1 then
			if me.GetExtMonthPay() < IVER_g_nPayLevel2 then
				Dialog:Say(string.format("Tháng này nhân vật %s không đủ %s, ", IVER_g_szPayName, IVER_g_szPayLevel2)..szMsg)
				return 0;
			end
			if self:GetRemainTime() == 14 then
				Dialog:Say("Thời gian tu luyện của bạn đã đầy, không thể nhận thời gian tu luyện thêm.")
				return 0;
			end
			self:AddRemainTime(30);
			me.SetTask(2038, 6, nCurDate);
			Dialog:Say("Thời gian tu luyện tăng <color=green>30 phút<color>\n\n"..szMsg);
			me.Msg("Thời gian tu luyện của bạn đã tăng <color=green>30 phút<color>");
		end	
		return 1;
	else
		if bAdd == 1 then
			Dialog:Say("Ngươi đã nhận thêm thời gian tu luyện ngày hôm nay\n\n"..szMsg);
		end
		return 0;
	end
end
function tbItem:Init()
	if (MODULE_GAMESERVER) then
		PlayerEvent:RegisterGlobal("On4TimeExpExhausted", self.ExpExhausted, self);
		PlayerEvent:RegisterGlobal("OnLevelUp", self.OnLevelUp, self);
		PlayerEvent:RegisterGlobal("OnXiuWeiExhausted", self.XiuWeiExhausted, self);
	end
end

function tbItem:WriteLog(...)
	if (MODULE_GAMESERVER) then
		Dbg:WriteLogEx(Dbg.LOG_INFO, "Item", "XiuLianZhu", unpack(arg));
	end
end

function tbItem:thanhlinhluyen()
local tbOpt = {
	--	{"<color=gold>Tụ Linh Thánh Linh Phí Tổn<color>", self.thanhlinhphi, self},
		{"<color=green>Tụ Linh Thánh Linh<color>", self.thanhlinhmienphi, self},
		{"Kết thúc đối thoại"},
	};
	local solinhhon = me.GetTask(2123,1);
	local chiphi = solinhhon*200;
	local msgString = string.format("Thu thập linh hồn thông qua tu luyện giúp tăng sức mạnh cho <color=gold>Thánh Linh<color>. Với mỗi linh hồn thu thập được, ngươi có thể tăng <color=gold>1 Tụ linh<color>.\n\nSố linh hồn hiện tại ngươi đang chiếm giữ \nlà : <color=green> %d linh hồn <color>.\n\nMỗi lần <color=gold>Tụ Linh<color> sẽ sử dụng tất cả số linh hồn đang có",solinhhon);
	Dialog:Say(msgString, tbOpt);
end

function tbItem:thanhlinhmienphi()
local tbOpt = {
		{"Tụ linh thuộc tính <color=gold>Thứ Nhất<color>", self.thanhlinhmienphi1, self},
		{"Tụ linh thuộc tính <color=gold>Thứ Hai<color>", self.thanhlinhmienphi2, self},
		{"Tụ linh thuộc tính <color=gold>Thứ Thứ Ba<color>", self.thanhlinhmienphi3, self},
		{"Tụ linh thuộc tính <color=gold>Thứ Tư<color>", self.thanhlinhmienphi4, self},
		{"Tụ linh thuộc tính <color=gold>Thứ Năm<color>", self.thanhlinhmienphi5, self},
		{"Kết thúc đối thoại"},
	};
	local solinhhon = me.GetTask(2123,1);
	local chiphi = solinhhon;
	local msgString = string.format("Thu thập linh hồn thông qua tu luyện giúp tăng sức mạnh cho <color=gold>Thánh Linh<color>. Với mỗi linh hồn thu thập được, ngươi có thể tăng <color=gold>1 Tụ linh<color>.\n\nSố linh hồn hiện tại ngươi đang chiếm giữ \nlà : <color=green> %d linh hồn <color>.",solinhhon);
	Dialog:Say(msgString, tbOpt);
end

function tbItem:thanhlinhmienphi1()
	local solinhhon = me.GetTask(2123,1);
	local chiphi = solinhhon;
	local pItem = me.GetEquip(Item.EQUIPPOS_ZHENYUAN_SUB1);
	if pItem == nil then
	me.Msg("Ngươi không trang bị Thánh Linh. Vui lòng trang bị sau đó mới có thể tụ linh");
	return 0;
	end
	Item:UpgradeSoulSignetNoItem(pItem,chiphi,1);
	me.SetTask(2123,1,0);
	me.Msg(string.format("Chúc mừng <color=gold>%s<color> tụ linh thành công thuộc tính thứ nhất tăng <color=gold> %d điểm<color>.", me.szName, chiphi));
	
end


function tbItem:thanhlinhmienphi2()
	local solinhhon = me.GetTask(2123,1);
	local chiphi = solinhhon;
	local pItem = me.GetEquip(Item.EQUIPPOS_ZHENYUAN_SUB1);
	if pItem == nil then
	me.Msg("Ngươi không trang bị Thánh Linh. Vui lòng trang bị sau đó mới có thể tụ linh");
	return 0;
	end
	Item:UpgradeSoulSignetNoItem(pItem,chiphi,2);
	me.SetTask(2123,1,0);
	me.Msg(string.format("Chúc mừng <color=gold>%s<color> tụ linh thành công thuộc tính thứ nhất tăng <color=gold> %d điểm<color>.", me.szName, chiphi));
	
end

function tbItem:thanhlinhmienphi3()
	local solinhhon = me.GetTask(2123,1);
	local chiphi = solinhhon;
	local pItem = me.GetEquip(Item.EQUIPPOS_ZHENYUAN_SUB1);
	if pItem == nil then
	me.Msg("Ngươi không trang bị Thánh Linh. Vui lòng trang bị sau đó mới có thể tụ linh");
	return 0;
	end
	Item:UpgradeSoulSignetNoItem(pItem,chiphi,3);
	me.SetTask(2123,1,0);
	me.Msg(string.format("Chúc mừng <color=gold>%s<color> tụ linh thành công thuộc tính thứ nhất tăng <color=gold> %d điểm<color>.", me.szName, chiphi));
	
end

function tbItem:thanhlinhmienphi4()
	local solinhhon = me.GetTask(2123,1);
	local chiphi = solinhhon;
	local pItem = me.GetEquip(Item.EQUIPPOS_ZHENYUAN_SUB1);
	if pItem == nil then
	me.Msg("Ngươi không trang bị Thánh Linh. Vui lòng trang bị sau đó mới có thể tụ linh");
	return 0;
	end
	Item:UpgradeSoulSignetNoItem(pItem,chiphi,4);
	me.SetTask(2123,1,0);
	me.Msg(string.format("Chúc mừng <color=gold>%s<color> tụ linh thành công thuộc tính thứ nhất tăng <color=gold> %d điểm<color>.", me.szName, chiphi));
	
end

function tbItem:thanhlinhmienphi5()
	local solinhhon = me.GetTask(2123,1);
	local chiphi = solinhhon;
	local pItem = me.GetEquip(Item.EQUIPPOS_ZHENYUAN_SUB1);
	if pItem == nil then
	me.Msg("Ngươi không trang bị Thánh Linh. Vui lòng trang bị sau đó mới có thể tụ linh");
	return 0;
	end
	Item:UpgradeSoulSignetNoItem(pItem,chiphi,5);
	me.SetTask(2123,1,0);
	me.Msg(string.format("Chúc mừng <color=gold>%s<color> tụ linh thành công thuộc tính thứ nhất tăng <color=gold> %d điểm<color>.", me.szName, chiphi));
	
end

function tbItem:thanhlinhphi()
local tbOpt = {
		{"Tụ Linh Hóa Thánh Linh", self.Mau, self},
		{"Kết thúc đối thoại"},
	};
	local solinhhon = me.GetTask(2123,1);
	local chiphi = solinhhon*200;
	local msgString = string.format("Thu thập linh hồn thông qua tu luyện giúp tăng sức mạnh cho <color=gold>Thánh Linh<color>. Với mỗi linh hồn thu thập được, ngươi có thể tăng <color=gold>1 Tụ linh<color>.\n\nSố linh hồn hiện tại ngươi đang chiếm giữ \nlà : <color=green> %d linh hồn <color>.\n\nMỗi lần <color=gold>Tụ Linh<color> sẽ sử dụng tất cả số linh hồn đang có. Ngoài ra còn tốn một khoảng chi phí nhất định.\n\n<color=gold>Tụ linh<color> lần này tốn <color=red>%d bạc<color>\n\n<color=gold>Tụ Linh<color> miễn phí, điểm <color=gold>Tụ Linh<color> bằng <color=red>1/5 Linh Hồn<color>",solinhhon, chiphi);
	Dialog:Say(msgString, tbOpt);
end

tbItem:Init();
