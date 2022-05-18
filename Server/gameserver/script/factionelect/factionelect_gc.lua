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
		for i = 1, self.FACTION_NUM do
			self:SendMailToWinner(i);
		end
	end
	local nDate = tonumber(os.date("%d"));
	if nDate == 1 then
		StartVote();
	end
end

-- 发送信件给胜利者
function FactionElect:SendMailToWinner(nFaction)
	local tbWinner = GetCurWinner(nFaction);
	local szName = tbWinner.szName;
	if tbWinner.nPlayerId ~= 0 then
		szName = KGCPlayer.GetPlayerName(tbWinner.nPlayerId);
	end
	if szName == "" then	-- 没有选举优胜者（没人获得候选人资格，很极端的情况）
		return 0;
	end
	local szTitle = "Thư gửi các môn đệ";
	local szSender = "<Sender>"..self.FACTION_TO_MASTER[nFaction].."<Sender>";
	local szContent = szSender..szName.."：\n\n    Hãy chuẩn bị tham gia vào những hoạt động mới của môn phái mình. \n Chưởng môn: "..self.FACTION_TO_MASTER[nFaction];
	SendMailGC(tbWinner.nPlayerId, szTitle, szContent);
end

-- 投票给某个候选人
function FactionElect:VoteToCandidate_GC(nFaction, nElectId, nPlayerId, nVote)
	if IsVoting() ~= 1 then
		return 0;
	end
	VoteToCandidate(nFaction, nElectId, nVote)
	GlobalExcute{"FactionElect:VoteToCandidate_GS2", nPlayerId};
end
