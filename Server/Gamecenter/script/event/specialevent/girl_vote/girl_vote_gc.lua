-- 文件名　：girl_vote_gc.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-06-04 17:49:23
-- 描  述  ：

if (not MODULE_GC_SERVER) then
	return 0;
end

SpecialEvent.Girl_Vote = SpecialEvent.Girl_Vote or {};
local tbGirl = SpecialEvent.Girl_Vote;

function tbGirl:StartEvent()
	if tonumber(GetLocalDate("%Y%m%d")) > self.STATE_AWARD[5] then
		SetGblIntBuf(GBLINTBUF_GIRL_VOTE, 0, 1, {});
		SetGblIntBuf(GBLINTBUF_GIRL_VOTE2, 0, 1, {});
		return 0;
	end
	
	self.tbGblBuf = {};
	local tbBuf = GetGblIntBuf(GBLINTBUF_GIRL_VOTE, 0, 1);
	if tbBuf and type(tbBuf)=="table"  then
		self.tbGblBuf = tbBuf;
	end
	
	self.tbGblBuf2 = {};
	local tbBuf2 = GetGblIntBuf(GBLINTBUF_GIRL_VOTE2, 0, 1);
	if tbBuf2 and type(tbBuf2)=="table"  then
		self.tbGblBuf2 = tbBuf2;
	end	
end

--GC数据同步给GS
function tbGirl:OnRecConnectEvent(nConnectId)
	
	if self.tbGblBuf then
		for szName, tbInfo in pairs(self.tbGblBuf) do
			GSExcute(nConnectId, {"SpecialEvent.Girl_Vote:OnRecConnectMsg", szName, tbInfo});
		end
	end
	
	if self.tbGblBuf2 then
		if self.tbGblBuf2.tZList then
			for szGateWayId, tbInfo in pairs(self.tbGblBuf2.tZList) do
				GSExcute(nConnectId, {"SpecialEvent.Girl_Vote:OnRecConnectMsgZList", szGateWayId, tbInfo});
			end
		end
		
		if self.tbGblBuf2.tGList then
			for szZone, tbInfo in pairs(self.tbGblBuf2.tGList) do
				GSExcute(nConnectId, {"SpecialEvent.Girl_Vote:OnRecConnectMsgGList", szZone, tbInfo});
			end
		end
		
		if self.tbGblBuf2.tPList then
			for szGateWayId, tbInfo in pairs(self.tbGblBuf2.tPList) do
				GSExcute(nConnectId, {"SpecialEvent.Girl_Vote:OnRecConnectMsgGateWay", szGateWayId, tbInfo});
			end			
		end		
	end
end

function tbGirl:RankAndWriteFile()
	local tbBuf = self:GetGblBuf();
	SetGblIntBuf(GBLINTBUF_GIRL_VOTE, 0, 1, tbBuf);
	PlayerHonor:OnSchemeUpdatePrettygirlHonorLadder();
	local szGateway	= GetGatewayName();
	local szOutFile = "\\girlvoteladder\\girlvotehonor_" .. szGateway .. ".txt";
	local szContext = "GatewayId\tAccount\tRoleName\tTicket\tRank\tFaction\tRoute\tLevel\tKin\tTong\tFansName\tFansTicket\tSex\n";
	KFile.WriteFile(szOutFile, szContext);
	local tbBuf = self:GetGblBuf();
	if tbBuf then
		for szName, tbInBuf in pairs(tbBuf) do
			local tbInfo = GetPlayerInfoForLadderGC(szName);
			if tbInfo then
				local nRank  = GetPlayerHonorRankByName(szName, PlayerHonor.HONOR_CLASS_PRETTYGIRL, 0);	
				local nHonor = PlayerHonor:GetPlayerHonorByName(szName, PlayerHonor.HONOR_CLASS_PRETTYGIRL, 0);
				local szKin  = tbInfo.szKinName;
				local szTong = tbInfo.szTongName;
				local szFansName 	= tbInBuf[1];
				local nFansTickets	= tbInBuf[2];
				local nFansSex		= tbInBuf[3];
				local szFansSex	 	= Player.SEX[nFansSex]
				if szFansName == "" then
					szFansName = "";
					nFansTickets = 0;
					szFansSex = "";
				end
				if not tbInfo.szKinName or (string.len(tbInfo.szKinName) <= 0) then
					szKin = "无家族";
				end 
				if not tbInfo.szTongName or (string.len(tbInfo.szTongName) <= 0) then
					szTong = "无帮会";
				end
				local szOut = string.format("%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n",
					szGateway,
					tbInfo.szAccount or "",
					szName or "",
					nHonor or 0,
					nRank or 0,
					Player:GetFactionRouteName(tbInfo.nFaction) or "",
					Player:GetFactionRouteName(tbInfo.nFaction, tbInfo.nRoute) or "",
					tbInfo.nLevel or 0,
					szKin or "",
					szTong or "",
					szFansName or "",
					nFansTickets or 0,
					szFansSex or "");
				KFile.AppendFile(szOutFile, szOut);	
			else
				Dbg:WriteLog("SpecialEvent.Girl_Vote","找不到该玩家数据:", szName);
			end
		end
	end
end

local function OnSort(tbA, tbB)
	if tbA[1] == tbB[1] then
		return tbA[1] > tbB[1]
	end 
	return tbA[1] < tbB[1];
end

function tbGirl:LoadPassGirlFile(szPath)
	local tbBuf = self:GetGblBuf();
	local tbFile = Lib:LoadTabFile(szPath)
	if not tbFile then
		print("【LoadPassGirlFile】找不到该路径文件", szPath);
		return 0;
	end

	local nGateway	= tonumber(string.sub(GetGatewayName(), 5, 6));
	local tbFinishGirl = {};
	for _, tbTemp in pairs(tbFile) do
		local nRank = tonumber(tbTemp.Rank) or 0;
		if nRank > 0 and nRank <= 20 then
			tbFinishGirl[tbTemp.GatewayId] = tbFinishGirl[tbTemp.GatewayId] or {};
			table.insert(tbFinishGirl[tbTemp.GatewayId], {nRank, tbTemp});
		end
		if tonumber(string.sub(tbTemp.GatewayId, 5, 6)) == nGateway then
			if tbBuf[tbTemp.RoleName] then
				self:SetPassGirl(tbTemp.RoleName, 1);
			end
		end
	end
	
	for _, tbGate in pairs(tbFinishGirl) do
		table.sort(tbGate, OnSort);
		for i, tbTmp in ipairs(tbGate) do
			if i <= 10 then
				local tbTemp = tbTmp[2];
				self:SetPassState2Girl(tbTemp);
				if tonumber(string.sub(tbTemp.GatewayId, 5, 6)) == nGateway then
					if tbBuf[tbTemp.RoleName] then
						self:SetPassGirl(tbTemp.RoleName, 2);
					end
				end
			end
		end
	end
	
	
	SetGblIntBuf(GBLINTBUF_GIRL_VOTE, 0, 1, tbBuf);
	
	local tbBuf2 = self:GetGblBuf2();
	SetGblIntBuf(GBLINTBUF_GIRL_VOTE2, 0, 1, tbBuf2);
end

function tbGirl:RankAndWriteFile2()
	local tbBuf = self:GetGblBuf2();
	SetGblIntBuf(GBLINTBUF_GIRL_VOTE2, 0, 1, tbBuf);
	local szGateway	= GetGatewayName();
	local szOutFile = "\\girlvoteladder\\girlvote2honor_" .. szGateway .. ".txt";
	local szContext = "GatewayId\tAccount\tRoleName\tTicket\tRank\tFaction\tRoute\tLevel\tKin\tTong\tFans1Name\tFans1Ticket\tFans1Gateway\tFans2Name\tFans2Ticket\tFans2Gateway\tFans3Name\tFans3Ticket\tFans3Gateway\tFans4Name\tFans4Ticket\tFans4Gateway\tFans5Name\tFans5Ticket\tFans5Gateway\n";
	KFile.WriteFile(szOutFile, szContext);
	if tbBuf and tbBuf.tPList then
		for szGateWayId, tbInBuf in pairs(tbBuf.tPList) do
			for szRoleName, tbPInfor in pairs(tbInBuf) do
				local szAccount = tbPInfor[4] or "";
				local nTicket = tbPInfor[2] or 0;
				local tbFans = {};
				for i=1, 5 do
					tbFans[i] = {"",0,""};
					if tbPInfor[3] and tbPInfor[3][i] then
					 	tbFans[i][1] = tbPInfor[3][i][1] or "";
					 	tbFans[i][2] = tbPInfor[3][i][2] or 0;
					 	tbFans[i][3] = tbPInfor[3][i][3] or "";
					end
				end
				local szFaction = "";
				local szRoute = "";
				local nLevel = 0;
				local szKin = "";
				local szTong = "";
				if szGateWayId == szGateway then
					local tbInfo = GetPlayerInfoForLadderGC(szRoleName);
					if tbInfo then
						szKin  = tbInfo.szKinName;
						szTong = tbInfo.szTongName;
						if not tbInfo.szKinName or (string.len(tbInfo.szKinName) <= 0) then
							szKin = "无家族";
						end
						if not tbInfo.szTongName or (string.len(tbInfo.szTongName) <= 0) then
							szTong = "无帮会";
						end
						szFaction = Player:GetFactionRouteName(tbInfo.nFaction) or "";
						szRoute	= Player:GetFactionRouteName(tbInfo.nFaction, tbInfo.nRoute) or "";
						nLevel = tbInfo.nLevel or 0;
					end
				end
				local szOut = string.format("%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n",
					szGateWayId,
					szAccount,
					szRoleName,
					nTicket,
					0,
					szFaction,
					szRoute,
					nLevel,
					szKin,
					szTong,
					tbFans[1][1],
					tbFans[1][2],
					tbFans[1][3],
					tbFans[2][1],
					tbFans[2][2],
					tbFans[2][3],
					tbFans[3][1],
					tbFans[3][2],
					tbFans[3][3],
					tbFans[4][1],
					tbFans[4][2],
					tbFans[4][3],
					tbFans[5][1],
					tbFans[5][2],
					tbFans[5][3]);
				KFile.AppendFile(szOutFile, szOut);	
			end
		end
	end
end

GCEvent:RegisterGCServerStartFunc(SpecialEvent.Girl_Vote.StartEvent, SpecialEvent.Girl_Vote);
GCEvent:RegisterGCServerShutDownFunc(SpecialEvent.Girl_Vote.RankAndWriteFile, SpecialEvent.Girl_Vote)
GCEvent:RegisterGCServerShutDownFunc(SpecialEvent.Girl_Vote.RankAndWriteFile2, SpecialEvent.Girl_Vote)
