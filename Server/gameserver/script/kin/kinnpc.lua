-------------------------------------------------------------------
--File: kinnpc.lua
--Author: lbh
--Date: 2007-7-4 11:47
--Describe: 帮会相关npc对话逻辑
-------------------------------------------------------------------
if not Kin then --调试需要
	Kin = {}
	print(GetLocalDate("%Y/%m/%d/%H/%M/%S").." build ok ..")
end

Kin.AwardCount = {
	{{1, 1, 2, 2, 3}, {1, 1, 2, 3, 4}, {1, 2, 3, 4, 5},},
	{{1, 2, 4, 6, 9}, {1, 2, 4, 8, 12}, {1, 3, 6, 10, 15},},
	};


function Kin:DlgCreateKin(szKin, nCamp)
	if me.GetCamp() == 0 then
		Dialog:Say("Người mới chơi, không thể lập gia tộc!")
		return 0
	end
	if me.IsCaptain() ~= 1 then
		Dialog:Say("Không phải đội trưởng, không thể lập gia tộc!")
		return 0
	end	
	local nTeamId = me.nTeamId
	local anPlayerId, nPlayerNum = KTeam.GetTeamMemberList(nTeamId)
	--if not anPlayerId or not nPlayerNum or nPlayerNum < 1 or me.nLevel < 50 then 
	--	Dialog:Say("Tổ đội 3 người trên cấp 50 độ thân mật cấp 2 mới lập được gia tộc")
	--	return 0
	--end
	local aLocalPlayer, nLocalPlayerNum = me.GetTeamMemberList()
	--TODO:判断是否在周围
	if nPlayerNum ~= nLocalPlayerNum then
		Dialog:Say("Tổ đội cùng đến mới lập được gia tộc!")
		return 0
	end
	if me.nCashMoney < self.CREATE_KIN_MONEY then
		Dialog:Say("Lập gia tộc cần <color=yellow>"..self.CREATE_KIN_MONEY.."<color> bạc, vui lòng mang đủ bạc trên người.")
		return 0
	end
	local function _FindIndex(nId)
		for i, v in ipairs(anPlayerId) do
			if v == nId then
				return i
			end
		end
	end
	local anStoredRepute = {}
	for i, cPlayer in ipairs(aLocalPlayer) do
		if cPlayer.nPlayerIndex ~= me.nPlayerIndex then
			if cPlayer.nLevel < 50 then
				Dialog:Say("Cấp dưới 50, không thể lập gia tộc!")
				return 0
			end
			if cPlayer.GetCamp() == 0 then
				Dialog:Say("Người mới chơi, không thể lập gia tộc!")
				return 0
			end
			local nFavor = me.GetFriendFavor(cPlayer.szName)
			if not nFavor or nFavor < 100 then
				Dialog:Say("Độ thân mật chưa đạt cấp 2, không thể lập gia tộc!")
				return 0
			end
			local nKinId = cPlayer.GetKinMember();
			if nKinId and nKinId ~= 0 then
				Dialog:Say("Một thành viên trong đội đã có gia tộc, không thể lập gia tộc!");
				return 0
			end
		end
		local j = _FindIndex(cPlayer.nId)
		if not j then
			return 0
		end
		--按anPlayerId的次序记录缓存的江湖威望
		anStoredRepute[j] = cPlayer.nPrestige;
	end
	if not szKin or szKin == "" then
		me.CallClientScript{"Kin:ShowCreateKinDlg"}
		return 0
	end
	local nRet = self:CreateKin_GS1(anPlayerId, anStoredRepute, szKin, nCamp, me.nId)
	if nRet ~= 1 then
		local szMsg = "Lập gia tộc thất bại!"
		if nRet == -1 then
			szMsg = szMsg.."Độ dài tên gia tộc phải từ 3-6 ký tự!"
		elseif nRet == -2 then
			szMsg = szMsg.."Không sử dụng các ký tự đặc biệt để đặt tên, có thể sử dụng ký hiệu [] !"
		elseif nRet == -3 then
			szMsg = szMsg.."Tên gia tộc chứa các từ ngữ nhạy cảm, hãy nhập lại!"
		elseif nRet == -4 then
			szMsg = szMsg.."Tên gia tộc đã tồn tại!"
		elseif nRet == -5 then
			szMsg = szMsg.."Thành viên trong nhóm đã có gia tộc!"
		end
		Dialog:Say(szMsg);
		return 0
	end
	return 1
end


-- 领取周活动目标奖励
function Kin:DlgGetWeeklyActionAward(bIsGetAward)
	local nKinId , nMemberId = me.GetKinMember();
	local cKin = KKin.GetKin(nKinId);
	if (not cKin) then
		return 0;
	end
	local cMember = cKin.GetMember(nMemberId);
	if (not cMember) then
		return 0;
	end
	local nPersonalWeeklyOffer = cMember.GetLastWeekKinOffer();

	local nLastTask = cKin.GetLastWeeklyTask();	
	if (0 == nLastTask) then
		Dialog:Say("Hoạt động tuần gia tộc, bạn không đủ điều kiện nhận thưởng.");
		return 0;
	end
	local nKinWeeklyOffer = cKin.GetLastWeekKinOffer();	
	local nPersonalOfferLevel = Kin:GetPersonalOfferLevel(nPersonalWeeklyOffer, nLastTask);
	local nKinOfferLevel = Kin:GetKinOfferLevel(nKinWeeklyOffer, nLastTask);
	local nLevel = nPersonalOfferLevel;
	if (nKinOfferLevel < nPersonalOfferLevel) then
		nLevel = nKinOfferLevel;
	end
	local nCurTime = GetTime();
	local nCurNo = tonumber(os.date("%Y%W", nCurTime));
	local nSysNo = KGblTask.SCGetDbTaskInt(DBTASK_KIN_WEEKLYACTION_NO);
	local nPlayerNo = me.GetTask(2061, 1);
	if (nSysNo ~= nCurNo) then
		Dialog:Say("Hệ thống duy trì mục tiêu tuần gia tộc, hãy quay trở lại sau để nhận thưởng.");
		return 0;
	end
	if (0 == bIsGetAward or nCurNo == nPlayerNo) then
		if (0 == nLevel or 0 == nPersonalWeeklyOffer) then
			local szMsg = "Căn cứ vào đóng góp của bạn trong tuần, bạn không đủ điều kiên nhận thưởng, lý do có thể như sau:\n 1.Bạn không tham gia hoạt động tuần gia tộc\n 2.Bạn đã nhận thưởng\n 3.Đóng góp của bạn không đủ điều kiện\n 4.Tổng đóng góp của cả gia tộc không đủ điều kiện tối thiểu";
			Dialog:Say(szMsg,
				{"Vâng, tôi biết."}
				);
			return 0;
		end
		local nLastTaskLevel = cKin.GetLastTaskLevel();
		if (0 == nLastTaskLevel) then
			nLastTaskLevel = Kin.TASK_LEVEL_LOW;	-- 默认是50级的周任务目标等级
		end
		local szMsg = "Đóng góp của bạn vào hoạt động tuần trước là <color=yellow>" .. nKinOfferLevel .. "<color>, mục tiêu <color=yellow>" .. nPersonalOfferLevel .. "<color>. Với đóng góp tuần trước bạn có thể nhận phần thưởng cấp <color=yellow>" .. nLevel .. "<color>, bạn có chắc muốn nhận?";
		Dialog:Say(szMsg,
			{
				{"Có, tôi muốn nhận luôn.", self.DlgGetWeeklyActionAward, Kin, 1},
				{"Để tôi nhận sau."},
			});
		return 0;
	elseif (1 == bIsGetAward and nCurNo ~= nPlayerNo) then
		local nFigure, nLastTaskLevel = self:GetAwardIndex();
		local nIsCaptainGetAward = cKin.GetIsCaptainGetAward();
		if (nIsCaptainGetAward == 1 and nFigure == 2) then
			nFigure = 1;
		end
		local nCount = Kin.AwardCount[nFigure][nLastTaskLevel][nLevel];
		if (not nCount) then
			return;
		end
		local nFreeCount, tbFunExecute = SpecialEvent.ExtendAward:DoCheck("KinWeekAction", me, nCount) 
		
		if me.CountFreeBagCell() < (nCount + nFreeCount) then
			Dialog:Say(string.format("Hành trang không đủ chỗ trống, cần ít nhất %s ô trống để nhận thưởng!", (nCount + nFreeCount)));
			return 0;
		end
		for i = 1, nCount do
			me.AddItem(18, 1, 276, 2);
		end
		Dbg:WriteLog("Hoạt động tuần gia tộc", string.format("Người chơi [%s] hoàn thành mục tiêu, có thể nhận phần thưởng cấp %s: %s rương hoạt động tuần gia tộc.", me.szName, nLevel, nCount));
	
		-- 增加帮会建设资金和帮主、族长、副族长、个人的股份		
		local nStockBaseCount = 30; -- 股份基数
		Tong:AddStockBaseCount_GS1(me.nId, nStockBaseCount * nCount, 0.7, 0.1, 0.1, 0.05, 0.05);
		SpecialEvent.ExtendAward:DoExecute(tbFunExecute);
		
		-- 增加族长和副族长的领袖荣誉
		if nFigure == 2 then
			local tbHonor = {20, 60, 120, 200, 300};  -- 1到5级完成度的领袖荣誉表
			local nCaptainId = Kin:GetPlayerIdByMemberId(nKinId, cKin.GetCaptain());	-- 族长ID
			local nAssistantId = Kin:GetPlayerIdByMemberId(nKinId, cKin.GetAssistant()); -- 副族长ID
			if tbHonor[nKinOfferLevel] then
				PlayerHonor:AddPlayerHonorById_GS(nCaptainId, PlayerHonor.HONOR_CLASS_LINGXIU, 0, tbHonor[nKinOfferLevel]);
				PlayerHonor:AddPlayerHonorById_GS(nAssistantId, PlayerHonor.HONOR_CLASS_LINGXIU, 0, tbHonor[nKinOfferLevel]/2);
			end
		end
		
		me.SetTask(2061, 1, nCurNo);
		me.AddKinReputeEntry(nCount * 3);			-- 增加江湖威望;
		
		-- 记录玩家领取到家族周目标奖励的次数
		Stats.Activity:AddCount(me, Stats.TASK_COUNT_WEEKLYTASK, 1);
		
		GCExcute{"Kin:SetLWKinOffer0_GC", me.dwKinId, nMemberId, nFigure};
	else
		return 0;
	end
end

-- 获取要领取的奖励索引
function Kin:GetAwardIndex()
	local nFigure = me.nKinFigure;
	local nFirstIndex = 1;
	local nSecIndex = 1;
	if (1 == nFigure) then	-- 族长
		nFirstIndex = 2;
	else
		nFirstIndex = 1;
	end	
	local nKinId = me.dwKinId;
	local cKin = KKin.GetKin(nKinId);
	local nLastTaskLevel = cKin.GetLastTaskLevel();
	if (Kin.TASK_LEVEL_LOW == nLastTaskLevel) then	-- 上周周任务目标等级
		nSecIndex = 1;
	elseif (Kin.TASK_LEVEL_MID == nLastTaskLevel) then
		nSecIndex = 2;
	elseif (Kin.TASK_LEVEL_HIGH == nLastTaskLevel) then
		nSecIndex = 3;
	end
	return nFirstIndex, nSecIndex;
end

-- 家族活动相关
function Kin:DlgAboutWeeklyAction()
	local szMsg = "Vì bạn đã có những đóng góp xuất sắc cho gia đình nên sẽ được khen thưởng hàng tuần, vì vậy hãy nhanh tay hành động nhé.\nNhân tiện, bạn đến đây làm gì?";
	Dialog:Say(szMsg,
		{
			{"Đổi mức HĐ tuần Gia Tộc", self.DlgModifyTaskLevel, self},
			{"Nhận phần thưởng HĐ tuần Gia Tộc", self.DlgGetWeeklyActionAward, self, 0},
		});
end

-- 修改家族周活动目标等级
function Kin:DlgModifyTaskLevel()
	local szMsg = "初级家族周活动目标适合平均等级在50-79级之间的家族选择；中级周活动目标时候平均等级在80-89级之间的家族选择；高级家族周活动目标适合平均等级超过90级的家族选择。" ..
					"当然，随着等级的提高，奖励也会相应增加。现在要修改吗？如果修改了将从下周开始执行。";
	Dialog:Say(szMsg,
		{
			{"修改为初级家族周活动目标", self.ModifyLevel, self, Kin.TASK_LEVEL_LOW},
			{"修改为中级家族周活动目标", self.ModifyLevel, self, Kin.TASK_LEVEL_MID},
			{"修改为高级家族周活动目标", self.ModifyLevel, self, Kin.TASK_LEVEL_HIGH},
		});
end

function Kin:ModifyLevel(nTaskLevel)
	local nKinId, nMemberId = me.GetKinMember()
	if self:CheckSelfRight(nKinId, nMemberId, 2) ~= 1 then
		Dialog:Say("你没有权限修改这个内容或者权限被冻结，请让你们族长或副族长来吧。");
		return 0;
	end 
	
	if (nTaskLevel ~= Kin.TASK_LEVEL_LOW and nTaskLevel ~= Kin.TASK_LEVEL_MID and nTaskLevel ~= Kin.TASK_LEVEL_HIGH) then
		return 0;
	end

	local szMsg = "";
	if (0 == TimeFrame:GetState("OpenLevel89") and (nTaskLevel == Kin.TASK_LEVEL_MID or nTaskLevel == Kin.TASK_LEVEL_HIGH)) then
		szMsg = szMsg .. "目前本服没有开启89级上限，不能把周活动目标等级修改为中级或高级。";
	elseif (0 == TimeFrame:GetState("OpenLevel99") and nTaskLevel == Kin.TASK_LEVEL_HIGH) then
		szMsg = szMsg .. "目前本服没有开启99级上限，不能把周活动目标等级修改为高级。";
	end
	if ("" ~= szMsg) then
		Dialog:Say(szMsg);
		return 0;
	end
	local nKinId = me.dwKinId;
	local cKin = KKin.GetKin(nKinId);
	GCExcute{"Kin:SetNewTaskLevel_GC", nKinId , nTaskLevel};
	local szLevel = "";
	if (Kin.TASK_LEVEL_LOW == nTaskLevel) then
		szLevel = szLevel .. "初级";
	elseif (Kin.TASK_LEVEL_MID == nTaskLevel) then
		szLevel = szLevel .. "中级";
	elseif (Kin.TASK_LEVEL_HIGH == nTaskLevel) then
		szLevel = szLevel .. "高级";
	end
	szMsg = "您所属家族的周活动目标等级已经成功修改为<color=yellow>" .. szLevel .. "<color>，将于下周生效。";
	Dialog:Say(szMsg);
end
-- 家族更换阵营
function Kin:DlgChangeCamp(nCamp)
	local nKinId, nExcutorId = me.GetKinMember()
	local nRet, cKin = self:CheckSelfRight(nKinId, nExcutorId, 1)
	
	
	if nRet ~= 1 then
		Dialog:Say("只有家族族长才能更换家族阵营");
		return 0;
	end
	if cKin.GetBelongTong() ~= 0 then
		Dialog:Say("家族在帮会中，不能更改家族阵营！");
		return 0;
	end
	local nDate = tonumber(Lib:GetLocalDay(GetTime()));
	if cKin.GetChangeCampDate() == nDate then
		Dialog:Say("一天只能更改家族阵营一次，今天已经更改过一次阵营了。")
		return 0;
	end
	if me.nCashMoney < self.CHANGE_CAMP then
		Dialog:Say("修改阵营需要交纳<color=red>"..(self.CHANGE_CAMP / 10000).."万<color>剑侠币，你身上没有足够的剑侠币！");
		return 0;
	end
	if not nCamp then
		Dialog:Say("修改阵营需要交纳<color=red>"..(self.CHANGE_CAMP / 10000).."万<color>剑侠币，请选择要改变的阵营:",
			{{"宋方", self.DlgChangeCamp, self, 1},
			 {"金方", self.DlgChangeCamp, self, 2},
			 {"中立", self.DlgChangeCamp, self, 3},
			 {"让我再考虑一下"}
			});
	else
		if cKin.GetCamp() == nCamp then
			Dialog:Say("你的家族已经是属于该阵营，不需要更换！");
			return 0;
		end
		-- 先扣钱了……GC挂了会导致吞钱~写个log吧
		me.CostMoney(self.CHANGE_CAMP, Player.emKPAY_KIN_CAMP);
		Dbg:WriteLog("家族","扣取更换阵营费用"..self.CHANGE_CAMP, "角色名:"..me.szName, "帐号:"..me.szAccount, "家族ID:"..nKinId);
		GCExcute{"Kin:ChangeCamp_GC", nKinId, nExcutorId, nCamp}
	end
end


-- 家族令牌相关选择
function Kin:DlgKinExp()
	local nKinId, nMemberId = me.GetKinMember();	
	if nKinId == 0 then
		Dialog:Say("Bạn đã gia nhập gia tộc");
	end
	
	local cKin = KKin.GetKin(nKinId);	
	if not cKin then
		return 0;
	end
	
	-- 判断需不需要收费给牌子 如果没设置预定时间，则不用收费，否则则要收费清空预定时间再给牌子
	local tbSay = {};
	if cKin.GetKinBuildFlagOrderTime() == 0 then
		table.insert(tbSay, {"Nhận mã thông báo gia tộc", self.DlgGetKinExp, self, 0});
	else
	 	table.insert(tbSay, {"Sửa thời gian và địa điểm cắm cờ gia tộc", self.DlgChangBuildFlagSetting, self, 0});
	end
	table.insert(tbSay, {"Kết thúc đối thoại"});
	
	Dialog:Say("为了您更方便的开启家族插旗活动，在您领取家族令牌并使用它的时候，可以设置以后自动开启家族插旗活动的时间。当然，如果不满意已经设置的时间，您可以修改它，当然修改时我们会收取一点手续费。那么，现在您想干什么呢？", tbSay)
end

-- 家族插旗时间修改
function Kin:DlgChangBuildFlagSetting(bConfirm)
	local nKinId, nMemberId = me.GetKinMember();	
	if nKinId == 0 then
		Dialog:Say("Bạn đã gia nhập gia tộc");
	end
	
	local cKin = KKin.GetKin(nKinId);	
	if not cKin then
		return 0;
	end
	
	local nRet, cKin = self:CheckSelfRight(nKinId, nMemberId, 2);	
	if nRet ~= 1 then
		Dialog:Say("Chỉ có tộc trưởng hoặc tộc phó mới có thể nhận mã thông báo gia tộc!");
		return 0;
	end
	
	local nTime = GetTime();
	local nNowDay = tonumber(os.date("%m%d", nTime));
	
	-- 如果今天已经领过了
	if cKin.GetGainExpState() == nNowDay then
		Dialog:Say("你的家族今天已经领取过家族令牌了, 如果你想修改的话，请明天再来领吧。");
		return 0;
	end
	
	if bConfirm ~= 1 then
		Dialog:Say("Sửa thời gian và địa điểm cắm cờ gia tộc rất tốn kém, cần mang đủ 100000 bạc để thực hiện.",
				{{"Ta có đủ bạc", self.ConfirmBuildFlagSetting, self},
			 	{"Để ta suy nghĩ đã"}		
		})
		return 0;
	end
	
	-- 如果包包不足
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("Hành trang đã đầy!")
		return 0;
	end
	
	if me.CostMoney(100000, Player.emKPAY_BUILD_FLAG_TIME) ~= 1 then
		me.Msg("Sửa thời gian và địa điểm cắm cờ gia tộc rất tốn kém, cần mang đủ 100000 bạc để thực hiện.");
		return 0;
	end
	
	Dbg:WriteLog("Kin","PlayerID:"..me.nId,"Account:"..me.szAccount.."修改插旗预定时间花费：100000银两");
	
	return GCExcute{"Kin:ChangeKinExpState_GC", me.nId, nKinId, nMemberId};
end

function Kin:ConfirmBuildFlagSetting()
	Dialog:Say("Bạn có chắc muốn thay đổi? Không hối tiếc chứ?",
				{{"Vâng, tôi chắc chắn", self.DlgChangBuildFlagSetting, self, 1},
			 	 {"Không thay đổi"}		
				})
end

-- 家族令牌的领取
function Kin:DlgGetKinExp(bConfirm)
	local nKinId, nMemberId = me.GetKinMember();
	if nKinId == 0 then
		Dialog:Say("Bạn đã gia nhập gia tộc");
		return 0;
	end
	
	local nRet, cKin = self:CheckSelfRight(nKinId, nMemberId, 2);	
	if nRet ~= 1 then
		Dialog:Say("Chỉ có tộc trưởng hoặc tộc phó mới có thể nhận mã thông báo gia tộc!");
		return 0;
	end

	local nTime = GetTime();
	local nNowDay = tonumber(os.date("%m%d", nTime));

	
	--  家族已经领取过了的情况要重新处理,领过了但没设置时间 和 领过了并设置了时间的要分开处理
	local nOrderTime = cKin.GetKinBuildFlagOrderTime();	
	if bConfirm ~= 1 and cKin.GetGainExpState() == nNowDay then 
		Dialog:Say("你的家族已经领取过了。请尽快设置家族插旗活动的时间及地点");
		return 0;
	end
	
	-- 还没领
	if bConfirm ~= 1 and cKin.GetGainExpState() ~= nNowDay then 
		Dialog:Say("在您使用“家族令牌”的同时，请设置自动开启家族插旗活动的时间，地点我们会自动帮您记录，以便今后为您的家族自动开启这项活动。",
				{{"是的，我要领取", self.DlgGetKinExp, Kin, 1},
			 	{"等下再来领取"}		
				})
		return 0;
	end
	
	-- 如果包包不足
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("Hành trang đã đầy!")
		return 0;
	end
	
	return GCExcute{"Kin:GetKinLingPai_GC", nKinId, nMemberId};
end

function Kin:DlgShowKinRecruitmentList()
	me.CallClientScript({"UiManager:OpenWindow", "UI_KINRCM_LIST" });
end
