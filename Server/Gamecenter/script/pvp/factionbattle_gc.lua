-------------------------------------------------------------------
--File: 	factionbattle.lua
--Author: 	zhengyuhua
--Date: 	2008-1-8 17:38
--Describe:	门派战--gamecenter端脚本
-------------------------------------------------------------------

-- 开启活动
function FactionBattle:StartFactionBattle()
	local nWeek = tonumber(GetLocalDate("%w"));
	if nWeek ~= self.OPEN_WEEK_DATE[1] and nWeek ~= self.OPEN_WEEK_DATE[2] and nWeek ~= self.OPEN_WEEK_DATE[3] and nWeek ~= self.OPEN_WEEK_DATE[4] and nWeek ~= self.OPEN_WEEK_DATE[5] and nWeek ~= self.OPEN_WEEK_DATE[6] and nWeek ~= self.OPEN_WEEK_DATE[7] then
		return;
	end
	local nCurId = GetFactionBattleCurId();
	nCurId = nCurId + 1;
	SetFactionBattleCurId(nCurId)
	GlobalExcute{"FactionBattle:StartFactionBattle_GS"};
	self:InitFactionNewsTable();
end

function FactionBattle:EndBattle_GC(nFaction)
	GlobalExcute{"FactionBattle:EndBattle_GS2", nFaction};
end

-- 记录活动结果
function FactionBattle:FinalWinner_GC(nFaction, nPlayerId)
	--联赛开启后，关闭门派竞技新人王显示，关闭门派大师兄候选人资格。
	if Wlls:GetMacthSession() <= 0 then
		-- by zhangjinpin@kingsoft
		local bFind = 0;
		local tbList = GetCurCandidate(nFaction);
		for _, tbRow in pairs(tbList or {}) do
			if tbRow.nPlayerId == nPlayerId then
				bFind = 1;
				break;
			end	
		end
		if bFind == 0 then
			KGCPlayer.SetPlayerPrestige(nPlayerId, KGCPlayer.GetPlayerPrestige(nPlayerId) + 100);
			Dbg:WriteLog("FactionBattle", "Tân Nhân Vương", KGCPlayer.GetPlayerName(nPlayerId), "tăng 100 điểm uy danh");
		end
		-- end
		SetCurCandidate(nFaction, nPlayerId);
	end
	local szName = KGCPlayer.GetPlayerName(nPlayerId);
	self:RecNewsForNewsMan(nFaction, szName);
end

function FactionBattle:InitFactionNewsTable()
	
	-- 门派名TODO：这样的方式不好，需要人工维护
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
	self.tbMenPaiNew = {};
	local tbNewsInfo = {};
	tbNewsInfo.nKey		= Task.tbHelp.NEWSKEYID.NEWS_MENPAI_NEW;
	tbNewsInfo.szTitle	= "Tân nhân vương 12 môn phái";
	tbNewsInfo.nAddTime = GetTime();
	tbNewsInfo.nEndTime = tbNewsInfo.nAddTime + 3600 * 48;
	tbNewsInfo.szMsg	= "";
	self.tbNewsInfo = tbNewsInfo;

	for i=1, 12 do
		local tbInfo = {};
		tbInfo.szName	= "chỗ trống";
		tbInfo.nLevel	= 0;
		tbInfo.szKin	= "Không Gia Tộc";
		tbInfo.szTong	= "Không Bang Hội";
		tbInfo.nSex		= 0;
		self.tbMenPaiNew[i] = tbInfo;
	end
	self:WriteNewsLog("InitFactionNewsTable", "Init Vote News Msg Successed");
end

-- 获取门派新人王消息信息
function FactionBattle:RecNewsForNewsMan(nFaction, szName)
	self:WriteNewsLog("RecNewsForNewsMan", nFaction, szName);
	if (nFaction <= 0) then
		return;
	end
	local szMsg = self:GetMenPaiNewsMsg(nFaction, szName);
	self:WriteNewsLog("Tin tức", szMsg);
	local tbSendInfo = self.tbNewsInfo;
	Task.tbHelp:AddDNews(tbSendInfo.nKey, tbSendInfo.szTitle, szMsg, tbSendInfo.nEndTime, tbSendInfo.nAddTime);
end

-- 获取门派新人王消息
function FactionBattle:GetMenPaiNewsMsg(nFaction, szName)
	self:ProcessPlayerInfo(nFaction, szName, self.tbMenPaiNew);
	local szMsg = "";
	for i=1, 12 do
		local tbInfo = self.tbMenPaiNew[i];
		local szOneMsg = string.format("Tân Nhân Vương: <color=yellow>%s<color>\n    Tên： <color=yellow>%s<color>\n    Cấp độ： <color=green>%d<color>\n    Gia Tộc： <color=pink>%s<color>\n    Bang Hội： <color=pink>%s<color>\n", self.MENPAINAME[i], tbInfo.szName, tbInfo.nLevel, tbInfo.szKin, tbInfo.szTong);
	
		szMsg = szMsg .. szOneMsg;
	end
	return szMsg;
end

function FactionBattle:ProcessPlayerInfo(nFaction, szName, tbMenPai)
	local tbPlayerInfo = GetPlayerInfoForLadderGC(szName);
	if (tbPlayerInfo) then -- 玩家不存在
		self:WriteNewsLog(ProcessPlayerInfo, nFaction, szName);
		local tbMenInfo = {};
		tbMenInfo.szName = szName;
		tbMenInfo.nLevel = tbPlayerInfo.nLevel;
		if (string.len(tbPlayerInfo.szKinName) > 0) then
			tbMenInfo.szKin	 = tbPlayerInfo.szKinName;
		else
			tbMenInfo.szKin	 = "Không Gia Tộc";
		end
		
		if (string.len(tbPlayerInfo.szTongName) > 0) then
			tbMenInfo.szTong	 = tbPlayerInfo.szTongName;
		else
			tbMenInfo.szTong	 = "Không Bang Hội";
		end
		tbMenInfo.nSex = tbPlayerInfo.nSex;
		tbMenPai[nFaction] = tbMenInfo;
	end
end

function FactionBattle:WriteNewsLog(...)
	if (MODULE_GAMESERVER) then
		Dbg:WriteLogEx(Dbg.LOG_INFO, "PVP", "FactionBattle", unpack(arg));
	end
	if (MODULE_GC_SERVER) then
		Dbg:Output("PVP", "FactionBattle", unpack(arg));
	end
end

--
function FactionBattle:TestCandidate_GC(nFaction, nPlayerId)
	SetCurCandidate(nFaction, nPlayerId);
end

-- 
function FactionBattle:TestVote_GC(nFaction, nElectId, nVote)
	VoteToCandidate(nFaction, nElectId, nVote);
end
