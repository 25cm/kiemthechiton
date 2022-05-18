-------------------------------------------------------------------
--File: 	factionelect_gs.lua
--Author: 	zhengyuhua
--Date: 	2008-9-28 18:29
--Describe:	门派选举gs逻辑
-------------------------------------------------------------------

local MAX_PER_PAGE = 10

-- 投票对话逻辑
function FactionElect:VoteDialogLogin(nBegin)
	nBegin = nBegin or 1;
	if (IsVoting() == 0) then
		Dialog:Say("Tuyển chọn Đại Sư Huynh/Đại Sư Tỷ đã kết thúc");
	end
	local nElectVer = GetCurElectVer();
	local nVoteVer = me.GetTask(self.TASK_GROUP, self.TASK_VOTE_VER);
	local nVotedId = me.GetTask(self.TASK_GROUP, self.TASK_VOTE_ID);
	local szDialog = string.format("Hạng 1 <color=green>%s<color> môn phái %s \n", 
		tostring(nElectVer), Player:GetFactionRouteName(me.nFaction));
	local tbList = GetLastMonthCandidate(me.nFaction);
	local tbOpt = {};
	if nVoteVer ~= nElectVer or nVotedId == 0 then
		for i = nBegin, math.min(nBegin + MAX_PER_PAGE - 1, #tbList) do
			local tbCandidate = tbList[i];
			local szInfo = Lib:StrFillL(tbCandidate.szName, 20)..tbCandidate.nVote.." phiếu";
			table.insert(tbOpt, 
				{szInfo, self.VoteConfirm, self, tbCandidate.nElectId, tbCandidate.szName});
		end
		if nBegin + MAX_PER_PAGE <= #tbList then
			tbOpt[#tbOpt + 1] = {"Tiếp theo", FactionElect.VoteDialogLogin, FactionElect, nBegin + MAX_PER_PAGE}
		end
		tbOpt[#tbOpt + 1] = {"Ta muốn suy nghĩ lại"};
	else
		local szName = "";
		for i, tbCandidate in pairs(tbList) do
			local szInfo = Lib:StrFillL("\n  "..tbCandidate.szName, 20)..tbCandidate.nVote.." phiếu";
			szDialog = szDialog..szInfo;
			if tbCandidate.nElectId == nVotedId then
				szName = tbCandidate.szName;
			end
		end
		szDialog = szDialog.."\n\n Bạn phải bỏ phiếu cho <color=green>"..szName.."<color>";
		tbOpt[#tbOpt + 1] = {"Tập xác định"}
	end
	Dialog:Say(szDialog, tbOpt);
end

function FactionElect:VoteConfirm(nElectId, szElectName)
	local nVote = me.nPrestige;
	Dialog:Say("Bạn có chắc chắn muốn bỏ <color=green>"..nVote.."<color> phiếu cho <color=green>"..szElectName.."<color> không ?",
		{
			{"Tập xác định", self.VoteToCandidate_GS, self, nElectId, me.nId},
			{"Ta muốn suy nghĩ lại"}
		});
end

-- 投票给某个候选人
function FactionElect:VoteToCandidate_GS(nElectId, nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return 0;
	end
	if IsVoting() ~= 1 then
		pPlayer.Msg("Hiện tại không phải thời gian bỏ phiếu");
	end
	local nElectVer = GetCurElectVer()
	local nVoteVer = pPlayer.GetTask(self.TASK_GROUP, self.TASK_VOTE_VER);
	local nVotedId = me.GetTask(self.TASK_GROUP, self.TASK_VOTE_ID);
	if nVoteVer ~= nElectVer or nVotedId == 0 then
		pPlayer.SetTask(self.TASK_GROUP, self.TASK_VOTE_VER, nElectVer);	-- 设置已投票
		pPlayer.SetTask(self.TASK_GROUP, self.TASK_VOTE_ID, nElectId);
		local nVote = pPlayer.nPrestige;
		if nVote < 0 then
			return 0;
		end
		GCExcute{"FactionElect:VoteToCandidate_GC", pPlayer.nFaction, nElectId, nPlayerId, nVote};
	else
		pPlayer.Msg("Bạn đã bỏ phiếu rồi!");
	end
end

-- 信息反馈
function FactionElect:VoteToCandidate_GS2(nPlayer)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayer);
	if not pPlayer then
		return 0;
	end
	pPlayer.Msg("Bỏ phiếu thành công !");
end

-- 领取大师兄大师姐称号对话逻辑
function FactionElect:ObtainWinnerTitle()
	local tbWinner = GetCurWinner(me.nFaction);
	local nCurVer = GetCurElectVer() - 1;
	
	if (not tbWinner or me.nId ~= tbWinner.nPlayerId) then
		Dialog:Say("     Ngày đầu tiên của tháng sẽ diễn ra tuyển chọn đại sư huynh (đại sư tỷ)\n    Điều kiện: phải có tên tuổi trong môn phái tháng trước mới được tham gia ứng cử.",
			{
				{"Bạn không đủ điều kiện để bỏ phiếu đại sư huynh ( đại sư tỷ )"}
			});
		return 0;
	end
	local nWinVer = me.GetTask(self.TASK_GROUP, self.TASK_WIN_VER);
	if nCurVer == nWinVer then
		Dialog:Say("   Ngày đầu tiên của tháng sẽ diễn ra tuyển chọn đại sư huynh (đại sư tỷ)\n    Điều kiện: phải có tên tuổi trong môn phái tháng trước mới được tham gia ứng cử.",
			{
				{"Nhận danh hiệu đại sư huynh (đại sư tỷ)"}
			});
		return 0;
	end
	local nTitleLevel = (me.nFaction - 1) * 2 + me.nSex + 1;
	me.AddTitle(self.TITEL_GENRE, self.TITEL_TYPE, nTitleLevel, 0);
	me.SetTask(self.TASK_GROUP, self.TASK_WIN_VER, nCurVer);
	-- by zhangjinpin@kingsoft 改为200
	me.AddKinReputeEntry(200);			-- 江湖威望
	local szFaction = Player:GetFactionRouteName(me.nFaction);
	local szFactionMsg = "Đại sư huynh ( đại sư tỷ) phái: "..szFaction.." lựa chọn người chiến thắng, Thu được danh hiệu đại sư huynh (Đại sư tỷ) "..szFaction.." "
	me.SendMsgToFriend("Hảo hữu của bạn ["..me.szName.. "]"..szFactionMsg);
	Player:SendMsgToKinOrTong(me, szFactionMsg, 1);
	Dialog:Say("   Mỗi tháng vào 1 ngày, Tất cả các đệ tử trong môn phái sẽ được bầu chọn đại sư huynh (đại sư tỷ) \n    Điều kiện: phải có tên tuổi trong môn phái tháng trước mới được tham gia ứng cử.",
	{
		{"Chúc mừng bạn đã chiến thắng trong bầu chọn đại sư huynh/đại sư tỷ."}
	});
	return 1;
end

-- 添加事件
function FactionElect:AddAffair(nTongId, szName, szElectVer, szMenpaiName)	
	if szName and szElectVer and szMenpaiName then
		local pTong = KTong.GetTong(nTongId);
		if pTong then
			pTong.AddHistoryFactionElect(szName, szElectVer, szMenpaiName);
			pTong.AddAffairFactionElect(szName, szElectVer, szMenpaiName);
		end
	end
end
