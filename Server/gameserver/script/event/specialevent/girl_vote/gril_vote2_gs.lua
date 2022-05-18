-- 文件名　：gril_vote_gs.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-06-05 11:36:22
-- 描  述  ：
if (MODULE_GC_SERVER) then
	return 0;
end
SpecialEvent.Girl_Vote = SpecialEvent.Girl_Vote or {};
local tbGirl = SpecialEvent.Girl_Vote;

function tbGirl:OnRecConnectMsgZList(szGateWayId , tbInfo)
	if not self.tbGblBuf2 then
		self.tbGblBuf2 = {};
	end
	if not self.tbGblBuf2.tZList then
		self.tbGblBuf2.tZList = {};
	end
	self.tbGblBuf2.tZList[szGateWayId] = tbInfo;
end

function tbGirl:OnRecConnectMsgGList(ZoneName, tbInfo)
	if not self.tbGblBuf2 then
		self.tbGblBuf2 = {};
	end
	if not self.tbGblBuf2.tGList then
		self.tbGblBuf2.tGList = {};
	end
	self.tbGblBuf2.tGList[ZoneName] = tbInfo;
end

function tbGirl:OnRecConnectMsgGateWay(szGateWay, tbInfo)
	if not self.tbGblBuf2 then
		self.tbGblBuf2 = {};
	end
	if not self.tbGblBuf2.tPList then
		self.tbGblBuf2.tPList = {};
	end
	self.tbGblBuf2.tPList[szGateWay] = tbInfo;
end

function tbGirl:State2VoteTickets1(szGateWay, szName, nExTicket)
	--if szName == me.szName then
	--	Dialog:Say("不能自己给自己投票哦!");
	--	return 0;
	--end
	local tbBuf = self:GetGblBuf2();
	if not tbBuf.tPList or not tbBuf.tPList[szGateWay] or not tbBuf.tPList[szGateWay][szName] then
		Dialog:Say("好像这个美女呀。");
		return 0;
	end	
	local tbRole = tbBuf.tPList[szGateWay][szName];
	local nUseTask, nNews = self:GetTaskGirlVoteId2(szGateWay, szName);
	if nUseTask == 0 then
		Dialog:Say("你已经给50个美女投过票了，不能再给其他美女投票。去投给你自己的那50个美女吧。");	
		return 0;
	end
	if me.CountFreeBagCell() < 2 then
		Dialog:Say("需要2格背包空间，才能进行投票！");
		return 0;
	end	
	local szInput = string.format("输入票数", szName);
	
	if nExTicket == 1 then
		szInput =  string.format("输入票数<color=yellow>(加成)", szName);
	end
	local nCount = tonumber(me.GetItemCountInBags(unpack(SpecialEvent.Girl_Vote.ITEM_MEIGUI))) or 0;
	Dialog:AskNumber(szInput, nCount, self.State2VoteTickets2, self, szGateWay, szName, (nExTicket or 0));
end

function tbGirl:State2VoteTickets2(szGateWay, szName, nExTicket, nTickets)
	if nTickets <= 0 then
		return 0;
	end
	if me.CountFreeBagCell() < 2 then
		Dialog:Say("需要2格背包空间，才能进行投票！");
		return 0;
	end
	--判断身上的玫瑰数够不够；
	local nCount = me.GetItemCountInBags(unpack(SpecialEvent.Girl_Vote.ITEM_MEIGUI));
	if nCount < nTickets then
		Dialog:Say("你身上没有那么多玫瑰。");
		return 0;
	end
	
	local nUseTask, nNews = self:GetTaskGirlVoteId2(szGateWay, szName);
	if nUseTask == 0 then
		Dialog:Say("你已经给50个美女投过票了，不能再给其他美女投票。去投给你自己的那50个美女吧。");	
		return 0;
	end
	
	--扣除玫瑰；
	local bRet = me.ConsumeItemInBags(nTickets, unpack(SpecialEvent.Girl_Vote.ITEM_MEIGUI));
	--增加投票
	if bRet ~= 0 then
		me.Msg("扣除玫瑰失败，投票失败");
		return 0;
	end
	
	for i=1, nTickets do
		local nCurR = MathRandom(1,100);
		if nCurR == 1 then
			me.AddItem(unpack(SpecialEvent.Girl_Vote.ITEM_MEIGUI_REBACK));
		end
	end
	local nServer = tonumber(string.sub(szGateWay, 5, -1)) or 0;
	local nGroupId = SpecialEvent.Girl_Vote.TSK_GROUP;
	local nTotleTickets = me.GetTask(nGroupId, (nUseTask + (SpecialEvent.Girl_Vote.DEF_TASK_SAVE_FANS - 1)));
	if nNews == 1 then
		me.SetTaskStr(nGroupId, nUseTask, szName);
		me.SetTask(nGroupId, (nUseTask + self.DEF_TASK_OFFSET), nServer)
	end
	if nExTicket == 1 then
		nTickets = math.floor(nTickets * 1.2);
	end
	me.SetTask(nGroupId, (nUseTask + (SpecialEvent.Girl_Vote.DEF_TASK_SAVE_FANS - 1)), (nTotleTickets + nTickets));
	local tbFans = {
		szFansName = me.szName, 
		nFansSex   = me.nSex, 
		nTotleTickets = nTotleTickets,
	};
	GCExcute({"SpecialEvent.Girl_Vote:BufVoteTicket2", szGateWay, szName, nTickets, tbFans});
	Dialog:Say(string.format("你成功给%s投了%s票。", szName, nTickets));
end

function tbGirl:GetTaskGirlVoteId2(szGateWay, szName)
	local nServer = tonumber(string.sub(szGateWay, 5, -1)) or 0;
	local nGroupId = SpecialEvent.Girl_Vote.TSK_GROUP;
	local nUseTask = nil;
	local nNew = 0;
	if me.GetTask(nGroupId, self.TSK_FANS_CLEAR) == 0 then
		for nTask = self.TSKSTR_FANS_NAME[1], self.TSKSTR_FANS_NAME[2] do
			me.SetTask(nGroupId, nTask, 0);
		end
		me.SetTask(nGroupId, self.TSK_FANS_CLEAR, 1);
	end
	for nTask = self.TSKSTR_FANS_NAME[1], self.TSKSTR_FANS_NAME[2], SpecialEvent.Girl_Vote.DEF_TASK_SAVE_FANS do
		if me.GetTaskStr(nGroupId, nTask) == szName and me.GetTask(nGroupId, (nTask + self.DEF_TASK_OFFSET)) == nServer then
			nUseTask = nTask;
			break;
		end
		if me.GetTaskStr(nGroupId, nTask) == "" then
			nUseTask = nUseTask or nTask;
			nNew = 1;
		end
	end
	return (nUseTask or 0), nNew;
end

function tbGirl:LoadFinishFile(szPath)
	local tbFile = Lib:LoadTabFile(szPath);
	if not tbFile then
		return 0;
	end
	SpecialEvent.Girl_Vote.tbFinishWinList = {};
	
	for _, tbRole in pairs(tbFile) do
		local szRoleGateWay = string.sub(tbRole.GatewayId, 5, 6);
		SpecialEvent.Girl_Vote.tbFinishWinList[szRoleGateWay] = SpecialEvent.Girl_Vote.tbFinishWinList[szRoleGateWay] or {};
		SpecialEvent.Girl_Vote.tbFinishWinList[szRoleGateWay][tbRole.RoleName] = SpecialEvent.Girl_Vote.tbFinishWinList[szRoleGateWay][tbRole.RoleName] or {};
		local tbInfo = SpecialEvent.Girl_Vote.tbFinishWinList[szRoleGateWay][tbRole.RoleName];
		tbInfo.nRank = tonumber(tbRole.Rank) or 0;
		tbInfo.szFansName = tbRole.FansName;
		tbInfo.szFansGateWay = string.sub(tbRole.FansGateway, 5, 6);
	end
end

function tbGirl:OnLogin()
	if me.nSex ~= Env.SEX_FEMALE then
		return 0;
	end
	
	local nSkillLevel = me.GetTask(SpecialEvent.Girl_Vote.TSK_GROUP, SpecialEvent.Girl_Vote.TSK_Award_Buff_Level);
	if nSkillLevel > 0 then
		local nSaveTime = me.GetTask(SpecialEvent.Girl_Vote.TSK_GROUP, SpecialEvent.Girl_Vote.TSK_Award_Buff);
		local nGetTime = Lib:GetDate2Time(SpecialEvent.Girl_Vote.STATE_AWARD[1]);
		local nSkillLastTime = SpecialEvent.Girl_Vote.DEF_SKILL_LASTTIME;
		if nSaveTime < nGetTime then
			nSkillLastTime = 365*24*3600; --越南版要重开，技能时间不一样，简单做判断保证两版本正常
		end
		local nLastTime = (nSaveTime + nSkillLastTime) - GetTime();
		if nLastTime > 60 and me.GetSkillState(1415) <= 0 then
			me.AddSkillState(1415,nSkillLevel,2,18*nLastTime, 1,0,1);
		end
	end
	
	if self:CheckState(5, 6) == 1 then
		if me.FindTitle(unpack(self.DEF_FINISH_MATCH_TITLE)) == 1 then
			return 0;
		end		
		local tbBuf = self:GetGblBuf2();
		local szGateWay = GetGatewayName();
		if self.GATEWAY_TRANS[szGateWay] then
			szGateWay = self.GATEWAY_TRANS[szGateWay][1];
		end
		if tbBuf and tbBuf.tPList and tbBuf.tPList[szGateWay] and tbBuf.tPList[szGateWay][me.szName] then
			me.AddTitle(unpack(self.DEF_FINISH_MATCH_TITLE));
			me.SetCurTitle(unpack(self.DEF_FINISH_MATCH_TITLE));			
		end
	end
end

function tbGirl:LoadMyGirlFile(szPath)
	local tbFile = Lib:LoadTabFile(szPath)
	if not tbFile then
		return 
	end
	self.tbGirlKinTong = {tbKin={},tbTong={}};
	for _, tbTemp in pairs(tbFile) do
		local szGateWay = tbTemp.GatewayId;
		local nRank 	= tonumber(tbTemp.Rank) or 0;
		local szKin 	= tbTemp.Kin;
		local szTong 	= tbTemp.Tong;
		if self.GATEWAY_TRANS[szGateWay] then
			szGateWay = self.GATEWAY_TRANS[szGateWay][1];
		end		
		if szGateWay == GetGatewayName() then
			if nRank > 0 and nRank <= 20 then
				self.tbGirlKinTong.tbKin[szKin] = self.tbGirlKinTong.tbKin[szKin] or {};
				self.tbGirlKinTong.tbKin[szKin].nGirl = self.tbGirlKinTong.tbKin[szKin].nGirl or 0;
				self.tbGirlKinTong.tbKin[szKin].nGirl = self.tbGirlKinTong.tbKin[szKin].nGirl + 1;
				
				self.tbGirlKinTong.tbTong[szTong] = self.tbGirlKinTong.tbTong[szTong] or {};
				self.tbGirlKinTong.tbTong[szTong].nGirl = self.tbGirlKinTong.tbTong[szTong].nGirl or 0;
				self.tbGirlKinTong.tbTong[szTong].nGirl = self.tbGirlKinTong.tbTong[szTong].nGirl + 1;
			end
			if nRank == 1 then
				self.tbGirlKinTong.tbTong[szTong].nNO1Girl = 1;
			end
		end
	end
end

function tbGirl:TongGetGirl()
	local nTongId = me.dwTongId;
	if nTongId == nil or nTongId <= 0 then
		return 0;
	end
	
	local cTong = KTong.GetTong(nTongId)
	if not cTong then
		return 0;
	end
	
	local szTongName = cTong.GetName();
	
	local nKinId, nKinMemId = me.GetKinMember();
	if nKinId == nil or nKinId <= 0 then
		return 0;
	end
	
	if Kin:HaveFigure(nKinId, nKinMemId, 4) ~= 1 then
		return 0;
	end
	
	if not self.tbGirlKinTong or not self.tbGirlKinTong.tbTong then
		return 0;
	end
	
	if not self.tbGirlKinTong.tbTong[szTongName] then
		return 0;
	end
	return self.tbGirlKinTong.tbTong[szTongName].nGirl or 0;
end

function tbGirl:KinGetGirl()
	local nKinId, nKinMemId = me.GetKinMember();
	if nKinId == nil or nKinId <= 0 then
		return 0;
	end
	
	if Kin:HaveFigure(nKinId, nKinMemId, 4) ~= 1 then
		return 0;
	end	
	local cKin = KKin.GetKin(nKinId);
	local szKinName = cKin.GetName();
	
	if not self.tbGirlKinTong or not self.tbGirlKinTong.tbKin then
		return 0;
	end
	
	if not self.tbGirlKinTong.tbKin[szKinName] then
		return 0;
	end
	return self.tbGirlKinTong.tbKin[szKinName].nGirl or 0;
end

function tbGirl:TongIsNO1Girl()
	local nTongId = me.dwTongId;
	if nTongId == nil or nTongId <= 0 then
		return 0;
	end
	
	local cTong = KTong.GetTong(nTongId)
	if not cTong then
		return 0;
	end
	
	local szTongName = cTong.GetName();
	
	local nKinId, nKinMemId = me.GetKinMember();
	if nKinId == nil or nKinId <= 0 then
		return 0;
	end
	
	if Kin:HaveFigure(nKinId, nKinMemId, 4) ~= 1 then
		return 0;
	end
	
	if not self.tbGirlKinTong or not self.tbGirlKinTong.tbTong then
		return 0;
	end
	
	if not self.tbGirlKinTong.tbTong[szTongName] then
		return 0;
	end
	return self.tbGirlKinTong.tbTong[szTongName].nNO1Girl or 0;	
end

PlayerEvent:RegisterGlobal("OnLogin", SpecialEvent.Girl_Vote.OnLogin, SpecialEvent.Girl_Vote);