-------------------------------------------------------------------
--File: 	factionelect_gc.lua
--Author: 	zhengyuhua
--Date: 	2008-9-28 18:29
--Describe:	门派选举gc逻辑
-------------------------------------------------------------------

-- 门派投票时间任务
function FactionElect:FactionVoteSchedule()
	if IsVoting() == 1 then -- 如果已经在投票期间则关闭投票
		EndVote();
		-- 信件
		local tbSendHelpForDa = {};
		for i = 1, self.FACTION_NUM do
			self:SendMailToWinner(i, tbSendHelpForDa);
		end
		self:RecordHistory();
		self:RecNewsForMenPaiDaShiXiong(tbSendHelpForDa);
	end
	local nDate = tonumber(GetLocalDate("%d"));
	if nDate == self.START_DATE then
		PlayerHonor:UpdateWuLinHonorLadder();
		Wlls:SetFactionElectPlayer();
		StartVote();
	end
end

-- 记录历史
function FactionElect:RecordHistory()
	local tbMenpaiName = {
		[1] = "Thiếu Lâm";
		[2] = "Thiên Vương";
		[3] = "Đường Môn";
		[4] = "Ngũ Độc";
		[5] = "Nga My";
		[6] = "Thúy Yên";
		[7] = "Cái Bang";
		[8] = "Thiên Nhẫn";
		[9] = "Võ Đang";
		[10] = "Côn Lôn";
		[11] = "Minh Giáo";
		[12] = "Đoàn Thị";
	};
	
	for i = 1, self.FACTION_NUM do
	local tbWinner = GetCurWinner(i);
		if tbWinner then					
			local szName = KGCPlayer.GetPlayerName(tbWinner.nPlayerId);
			if szName then		
				local nKinId = KGCPlayer.GetKinId(tbWinner.nPlayerId);
				if nKinId then			
					local pKin = KKin.GetKin(nKinId)
					if pKin then
						local nTongId = pKin.GetBelongTong();
						local pTong = KTong.GetTong(nTongId);	
						local nElectVer = GetCurElectVer();
						if pTong then
							pTong.AddHistoryFactionElect(szName, tostring(nElectVer), tbMenpaiName[i]);
							pTong.AddAffairFactionElect(szName, tostring(nElectVer), tbMenpaiName[i]);
							GlobalExcute{"FactionElect:AddAffair", nTongId, szName, tostring(nElectVer), tbMenpaiName[i]};
						end
					end
				end
			end
		end
	end
end

-- 发送信件给胜利者
function FactionElect:SendMailToWinner(nFaction, tbSendHelpForDa)
	local tbWinner = GetCurWinner(nFaction);
	local szName = tbWinner.szName;
	if tbWinner.nPlayerId ~= 0 then
		szName = KGCPlayer.GetPlayerName(tbWinner.nPlayerId);
	end
	if szName == "" then	-- 没有选举优胜者（没人获得候选人资格，很极端的情况）
		return 0;
	end
	local szTitle = "Thư chúc mừng của môn phái";
	local szSender = "<Sender>"..self.FACTION_TO_MASTER[nFaction].."<Sender>";
	local szContent = szSender..szName..":\n\nTrước mặt các đồng môn, ngươi đã bộc lộ rất nhiều tài năng, xứng đáng trở thành \"Môn phái đại sư huynh (tỷ)\".\n    <color=yellow>Mau đến gặp chưởng môn để nhận danh hiệu  \"Môn phái đại sư huynh (tỷ)\"!<color>\n    Mong là ngươi sẽ tiếp tục cố gắng để xứng đáng với danh hiệu này.\n\n              Chưởng môn nhân:"..self.FACTION_TO_MASTER[nFaction];
	SendMailGC(tbWinner.nPlayerId, szTitle, szContent);
	tbSendHelpForDa[nFaction] = szName;
end

-- 投票给某个候选人
function FactionElect:VoteToCandidate_GC(nFaction, nElectId, nPlayerId, nVote)
	if IsVoting() ~= 1 then
		return 0;
	end
	VoteToCandidate(nFaction, nElectId, nVote)
	GlobalExcute{"FactionElect:VoteToCandidate_GS2", nPlayerId};
end

-- 获取门派大师兄消息的信息
function FactionElect:RecNewsForMenPaiDaShiXiong(tbMenPaiDa)
	self:WriteElectLog("RecNewsForMenPaiDaShiXiong","Elect Man Pai Da Shi Xiong");
	self.MENPAINAME = {
		[1] = "Thiếu Lâm";
		[2] = "Thiên Vương";
		[3] = "Đường Môn";
		[4] = "Ngũ Độc";
		[5] = "Nga My";
		[6] = "Thúy Yên";
		[7] = "Cái Bang";
		[8] = "Thiên Nhẫn";
		[9] = "Võ Đang";
		[10] = "Côn Lôn";
		[11] = "Minh Giáo";
		[12] = "Đoàn Thị";
	};

	self.tbMenPaiDa = {};
	local tbNewsInfo = {};
	tbNewsInfo.nKey		= Task.tbHelp.NEWSKEYID.NEWS_MENPAIJINGJI_DASHIXING;
	tbNewsInfo.szTitle	= string.format("Đại sư huynh, đại sư tỷ mười hai môn phái lần thứ %d", GetCurElectVer() - 1);
	tbNewsInfo.nAddTime = GetTime();
	tbNewsInfo.nEndTime = tbNewsInfo.nAddTime + 3600 * 24 * 27;
	tbNewsInfo.szMsg	= "";

	for i=1, 12 do
		local tbInfo = {};
		tbInfo.szName	= "Trống";
		tbInfo.nLevel	= 0;
		tbInfo.szKin	= "Không gia tộc";
		tbInfo.szTong	= "Không bang hội";
		tbInfo.nSex		= 0;
		if (5 == i) then
			tbInfo.nSex = 1;
		end
		self.tbMenPaiDa[i] = tbInfo;
	end
	for key, szName in pairs(tbMenPaiDa) do
		if (szName) then
			self:ProcessPlayerInfo(key, szName, self.tbMenPaiDa);
		end
	end
	local szMsg = self:GetMenPaiDaNewsMsg();
	Task.tbHelp:AddDNews(tbNewsInfo.nKey, tbNewsInfo.szTitle, szMsg, tbNewsInfo.nEndTime, tbNewsInfo.nAddTime);
end

-- 获取门派大师兄消息
function FactionElect:GetMenPaiDaNewsMsg()
	local szMsg = "";
	for i=1, 12 do
		local tbInfo = self.tbMenPaiDa[i];
		local szOneMsg = "";
		if (tbInfo.nSex == 0) then
			szOneMsg = string.format("Đại sư huynh <color=yellow>%s<color>\n", self.MENPAINAME[i]);
		elseif (tbInfo.nSex == 1) then
			szOneMsg = string.format("Đại sư tỷ <color=yellow>%s<color>\n", self.MENPAINAME[i]);
		end
		szOneMsg = szOneMsg .. 
				string.format("    Tên: <color=yellow>%s<color>\n", tbInfo.szName) .. 
				string.format("    Đẳng cấp: <color=green>%d<color>\n", tbInfo.nLevel) .. 
				string.format("    Gia tộc: <color=pink>%s<color>\n", tbInfo.szKin) .. 
				string.format("    Bang hội: <color=pink>%s<color>\n\n", tbInfo.szTong);
		szMsg = szMsg .. szOneMsg;
	end
	return szMsg;
end

-- 处理玩家信息
function FactionElect:ProcessPlayerInfo(nFaction, szName, tbMenPai)
	local tbPlayerInfo = GetPlayerInfoForLadderGC(szName);
	if (tbPlayerInfo) then -- 玩家不存在
		self:WriteElectLog("ProcessPlayerInfo", nFaction, szName);
		local tbMenInfo = {};
		tbMenInfo.szName = szName;
		tbMenInfo.nLevel = tbPlayerInfo.nLevel;
		if (string.len(tbPlayerInfo.szKinName) > 0) then
			tbMenInfo.szKin	 = tbPlayerInfo.szKinName;
		else
			tbMenInfo.szKin	 = "Không gia tộc";
		end
		
		if (string.len(tbPlayerInfo.szTongName) > 0) then
			tbMenInfo.szTong	 = tbPlayerInfo.szTongName;
		else
			tbMenInfo.szTong	 = "Không bang hội";
		end
		tbMenInfo.nSex = tbPlayerInfo.nSex;
		tbMenPai[nFaction] = tbMenInfo;
	end
end

function FactionElect:WriteElectLog(...)
	if (MODULE_GAMESERVER) then
		Dbg:WriteLogEx(Dbg.LOG_INFO, "PVP", "FactionElect", unpack(arg));
	end
	if (MODULE_GC_SERVER) then
		Dbg:Output("PVP", "FactionElect", unpack(arg));
	end
end


