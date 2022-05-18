

function Battle:GM()
	local tbOpt	= {};
	--tbOpt[#tbOpt + 1]	= {"Đồ Hỗ Trợ", "Battle:GM_Equipment"};
	local tbMission	= nil;
	for nLevel = 1, 3 do
		for i = 1, 3 do
			tbMission	= self:GetMission(nLevel, i);
			if (tbMission) then
				break;
			end
		end
		if (tbMission) then
			break;
		end
	end
	
	if (tbMission) then
		if (tbMission.nState == 1) then
			tbOpt[#tbOpt + 1]	= {"Bắt đầu Khai chiến tống kim", "Battle:GM_Start"};
		end
		tbOpt[#tbOpt + 1]	= {"Kết Thúc trận chiến hiện tại", "Battle:GM_Close"};
	else
	--	for nRuleId, tbRule in ipairs(self.tbRuleBases) do-------
	--		tbOpt[#tbOpt + 1]	= {"Khai chiến-"..tbRule.szRuleName, "Battle:GM_Open", nRuleId};---------
	--	end---------
	--	for nRuleId, tbRule in ipairs(self.tbRuleBases) do
		--	tbOpt[#tbOpt + 1]	= {"Khai chiến-Cửu Khúc Chiến "..tbRule.szRuleName, "Battle:GM_OpenSp", nRuleId};
	--	end
		--for nRuleId, tbRule in ipairs(self.tbRuleBases) do
		--	tbOpt[#tbOpt + 1]	= {"Khai chiến-Bàn Long Cốc Chiến "..tbRule.szRuleName, "Battle:GM_OpenSp1", nRuleId};
	--	end		
		for nRuleId, tbRule in ipairs(self.tbRuleBases) do
			tbOpt[#tbOpt + 1]	= {"Khai chiến-Ngũ Trượng Nguyên Chiến "..tbRule.szRuleName, "Battle:GM_OpenSp_JiaYuGuan", nRuleId};
		end		
	end
	
	--tbOpt[#tbOpt + 1]	= {"Báo Danh Chiến Trường - Tống", "Battle:GM_GotoSignUp", Battle.CAMPID_SONG};
	--tbOpt[#tbOpt + 1]	= {"Báo Danh Chiến Trường - Kim", "Battle:GM_GotoSignUp", Battle.CAMPID_JIN};


	--tbOpt[#tbOpt + 1]	= {"Cấp độ - Sơ", "Battle:GM_LevelUp", 1};
	--tbOpt[#tbOpt + 1]	= {"Cấp độ - Trung", "Battle:GM_LevelUp", 2};
	--tbOpt[#tbOpt + 1]	= {"Cấp độ - Cao", "Battle:GM_LevelUp", 3};
	
	
	tbOpt[#tbOpt + 1]	= {"Kết thúc đối thoại"};

	Dialog:Say("Chiến Trường Tống Kim<pic=42>", tbOpt);
end

function Battle:GM_Equipment()
	local tbTmpNpc	= Npc:GetClass("tmpnpc");
	tbTmpNpc:OnDialog();
end

function Battle:GM_Open(nRuleId, nSeqNum)
	if nSeqNum == nil then
		nSeqNum = 1;
	end
	for nLevel = 1, 3 do
		local tbMission	= self:GetMission(nLevel);
		if (tbMission) then
			me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s] Trong tiến trình, xin vui lòng tắt!", tbMission:GetFullName()));
		else
			local szBattleTime = GetLocalDate("%y%m%d%H");
			self:OpenBattle(1, nLevel, 190 + nLevel - 1, string.format("（Gỡ lỗi phiên bản%d）", nLevel), nRuleId, 1, nSeqNum, 1, szBattleTime);
			self:OpenBattle(1, nLevel, 266 + nLevel - 1, string.format("（Gỡ lỗi phiên bản%d）", nLevel), nRuleId, 1, nSeqNum, 2, szBattleTime);
			if (nLevel == 1) then
				print("Chiến Trường 3 - 1");
				self:OpenBattle(1, nLevel, 284, string.format("（Gỡ lỗi phiên bản%d）", nLevel), nRuleId, 1, nSeqNum, 3, szBattleTime);
			end			
			
			tbMission	= self:GetMission(nLevel, 1);
			if (tbMission) then
				me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s]một Khai chiến Thành công", tbMission:GetFullName()));
			end
			tbMission	= self:GetMission(nLevel, 2);
			if (tbMission) then
				me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s]Hai Khai chiến Thành công", tbMission:GetFullName()));
			end

			if (nLevel == 1) then
				print("Chiến Trường 3 - ");
				tbMission	= self:GetMission(nLevel, 3);
				if (tbMission) then
					me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s]Ba  Khai chiến Thành công", tbMission:GetFullName()));
				end
			end

		end
	end
end

function Battle:GM_OpenSp(nRuleId, nSeqNum)
	if nSeqNum == nil then
		nSeqNum = 1;
	end
	for nLevel = 1, 3 do
		local tbMission	= self:GetMission(nLevel);
		if (tbMission) then
			me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s] Trong tiến trình, xin vui lòng tắt!", tbMission:GetFullName()));
		else
			local szBattleTime = GetLocalDate("%y%m%d%H");
			self:OpenBattle(1, nLevel, 187 + nLevel - 1, string.format("（Gỡ lỗi phiên bản%d）", nLevel), nRuleId, 1, nSeqNum, 1, szBattleTime);
			self:OpenBattle(1, nLevel, 263 + nLevel - 1, string.format("（Gỡ lỗi phiên bản%d）", nLevel), nRuleId, 1, nSeqNum, 2, szBattleTime);
			tbMission	= self:GetMission(nLevel, 1);
			if (tbMission) then
				me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s]một Khai chiến Thành công", tbMission:GetFullName()));
			end
			tbMission	= self:GetMission(nLevel, 2);
			if (tbMission) then
				me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s]Hai Khai chiến Thành công", tbMission:GetFullName()));
			end
		end
	end
end

function Battle:GM_OpenSp1(nRuleId, nSeqNum)
	if nSeqNum == nil then
		nSeqNum = 1;
	end
	for nLevel = 1, 3 do
		local tbMission	= self:GetMission(nLevel);
		if (tbMission) then
			me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s] Trong tiến trình, xin vui lòng tắt!", tbMission:GetFullName()));
		else
			local szBattleTime = GetLocalDate("%y%m%d%H");
			self:OpenBattle(1, nLevel, 193 + nLevel - 1, string.format("（Gỡ lỗi phiên bản%d）", nLevel), nRuleId, 1, nSeqNum, 1, szBattleTime);
			self:OpenBattle(1, nLevel, 269 + nLevel - 1, string.format("（Gỡ lỗi phiên bản%d）", nLevel), nRuleId, 1, nSeqNum, 2, szBattleTime);
			tbMission	= self:GetMission(nLevel, 1);
			if (tbMission) then
				me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s]một Khai chiến Thành công", tbMission:GetFullName()));
			end
			tbMission	= self:GetMission(nLevel, 2);
			if (tbMission) then
				me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s]Hai Khai chiến Thành công", tbMission:GetFullName()));
			end
		end
	end
end

function Battle:GM_OpenSp_JiaYuGuan(nRuleId, nSeqNum)
	if nSeqNum == nil then
		nSeqNum = 1;
	end
	for nLevel = 1, 3 do
		local tbMission	= self:GetMission(nLevel);
		if (tbMission) then
			me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s] Trong tiến trình, xin vui lòng tắt!", tbMission:GetFullName()));
		else
			local szBattleTime = GetLocalDate("%y%m%d%H");
			self:OpenBattle(1, nLevel, 1635 + nLevel*3 - 3, string.format("（Gỡ lỗi phiên bản%d）", nLevel), nRuleId, 2, nSeqNum, 1, szBattleTime);
			self:OpenBattle(1, nLevel, 1636 + nLevel*3 - 3, string.format("（Gỡ lỗi phiên bản%d）", nLevel), nRuleId, 2, nSeqNum, 2, szBattleTime);
			tbMission	= self:GetMission(nLevel, 1);
			if (tbMission) then
				me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s]một Khai chiến Thành công", tbMission:GetFullName()));
			end
			tbMission	= self:GetMission(nLevel, 2);
			if (tbMission) then
				me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s]Hai Khai chiến Thành công", tbMission:GetFullName()));
			end
		end
	end
end

function Battle:GM_Start()
	local tbBackupData		= self.tbBTPLNUM_LOWBOUND;
	self.tbBTPLNUM_LOWBOUND	= {0, 0, 0};
	for nLevel = 1, 3 do
		for i=1, 3 do
			local tbMission	= self:GetMission(nLevel, i);
			if (not tbMission) then
				me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s] Không mở, không thể đi đến chiến tranh!", self.NAME_GAMELEVEL[nLevel]));
			elseif (tbMission.nState ~= 1) then
				me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s] Nhà nước không, không thể đi đến chiến tranh!", tbMission:GetFullName()));
			else
				tbMission.nSignUpMsgCount	= 1;
				tbMission:GoNextState();
				me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s] Đăng ký đã kết thúc, cuộc chiến bắt đầu.", tbMission:GetFullName()));
			end
		end
	end
	self.tbBTPLNUM_LOWBOUND	= tbBackupData;
end

function Battle:GM_Close(nRuleId)
	for nLevel = 1, 3 do
		for i=1, 3 do
			local tbMission	= self:GetMission(nLevel, i);
			if (tbMission) then
				self:CloseBattle(nLevel, tbMission.nBattleKey, i);
				me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s] Tắt thành công!", tbMission:GetFullName()));
			else
				me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s] Không mở, không có thể bị đóng cửa!", self.NAME_GAMELEVEL[nLevel]));
			end
		end
	end
end

function Battle:GM_CloseOneBattle(nLevel, nSeq)
	local tbMission	= self:GetMission(nLevel, nSeq);
	if (tbMission) then
		self:CloseBattle(nLevel, tbMission.nBattleKey, nSeq);
		me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s] Tắt thành công!", tbMission:GetFullName()));
	else
		me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s] Không mở, không có thể bị đóng cửa!", self.NAME_GAMELEVEL[nLevel]));
	end
end

function Battle:GM_StartOnBattle(nLevel, nSeq)
	local tbBackupData		= self.tbBTPLNUM_LOWBOUND;
	self.tbBTPLNUM_LOWBOUND	= {0, 0, 0};

	local tbMission	= self:GetMission(nLevel, nSeq);
	if (not tbMission) then
		me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s] Không mở, không thể đi đến chiến tranh!", self.NAME_GAMELEVEL[nLevel]));
	elseif (tbMission.nState ~= 1) then
		me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s] Nhà nước không, không thể đi đến chiến tranh!", tbMission:GetFullName()));
	else
		tbMission.nSignUpMsgCount	= 1;
		tbMission:GoNextState();
		me.Msg(string.format("--Chuyển Server nơi ghi danh Tống Kim[%s] Đăng ký đã kết thúc, cuộc chiến bắt đầu.", tbMission:GetFullName()));
	end

	self.tbBTPLNUM_LOWBOUND	= tbBackupData;
end

function Battle:GM_GotoOneSignUp(nCampId, nBattleSeq)
	local nLevel	= Battle:GetJoinLevel(me);
	
	if (nLevel <= 0) then
		me.Msg("您的等级不足以参加Chuyển Server nơi ghi danh Tống Kim，请先提升等级！");
		return;
	end
	
	if (self.MAPID_LEVEL_CAMP[nLevel][nBattleSeq]) then
		local nMapId	= self.MAPID_LEVEL_CAMP[nLevel][nBattleSeq][nCampId];
		me.NewWorld(nMapId, 1686, 3276);
		me.Msg(string.format("Theo cấp độ của bạn, bạn đã được đưa đến điểm đăng ký！",
			Battle.NAME_CAMP[nLevel], Battle.NAME_GAMELEVEL[nLevel], nBattleSeq));
	end	
end

function Battle:GM_GotoSignUp(nCampId)
	local nLevel	= Battle:GetJoinLevel(me);
	
	if (nLevel <= 0) then
		me.Msg("您的等级不足以参加Chuyển Server nơi ghi danh Tống Kim，请先提升等级！");
		return;
	end
	local tbOpt = {};
	for i=1, #self.MAPID_LEVEL_CAMP[nLevel] do
		tbOpt[#tbOpt + 1] = { string.format("报名点%d", i), "Battle:GM_GotoOneSignUp", nCampId, i};
	end
	Dialog:Say("Bạn chọn chiến trường nào？", tbOpt);
end

function Battle:GM_LevelUp(nLevel)
	local nMyLevel		= me.nLevel;
	local nNextLevel	= Battle.LEVEL_LIMIT[nLevel+1] or 256;
	local tbLevelDesc	= { "初", "中", "高" };
	local szLevelName	= string.format("%s(%s级)", Battle.NAME_GAMELEVEL[nLevel], tbLevelDesc[nLevel]);
	if (nMyLevel >= nNextLevel) then
		me.Msg(string.format("Cấp độ của bạn quá cao để bị hạ cấp để tham gia %s 了！", szLevelName));
	else
		ST_LevelUp(Battle.LEVEL_LIMIT[nLevel] - me.nLevel);
		me.Msg(string.format("Cấp độ của bạn đã đáp ứng các yêu cầu cấp độ！", szLevelName));
	end
	me.AddFightSkill("梯云纵", 60);
	me.AddFightSkill("无形蛊", 60);
end

function Battle:AddBounsNoCamp(nBouns)
	local tbTempDate = Battle:GetPlayerData(me);
	if (not tbTempDate) then
		me.Msg("Hiện tại chiến trường chưa được mở, không có dữ liệu chiến trường của người chơi");
		return;
	end
	
	if (tbTempDate.tbMission.nState ~= 2) then
		me.Msg("Không có điểm nào có thể được thêm trước khi trận chiến bắt đầu");
		return;
	end
	tbTempDate:AddBounsWithoutCamp(nBouns);
end

function Battle:AddBounsCamp(nBouns)
	local tbTempDate = Battle:GetPlayerData(me);
	if (not tbTempDate) then
		me.Msg("Hiện tại chiến trường chưa được mở, không có dữ liệu chiến trường của người chơi");
		return;
	end
	
	if (tbTempDate.tbMission.nState ~= 2) then
		me.Msg("Không có điểm nào có thể được thêm trước khi trận chiến bắt đầu");
		return;
	end
	tbTempDate:AddBounsWithCamp(nBouns);
end
