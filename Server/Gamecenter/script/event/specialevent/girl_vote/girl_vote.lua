-- 文件名　：girl_vote_gc.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-06-04 17:49:23
-- 描  述  ：

SpecialEvent.Girl_Vote = SpecialEvent.Girl_Vote or {};
local tbGirl = SpecialEvent.Girl_Vote;

function tbGirl:IsOpen()
	return Task.IVER_nEvent_GirlVote or 0;
end

function tbGirl:CheckState(nSTState, nEDState)
	if self:IsOpen() ~= 1 then
		return 0;
	end
	
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
	if not self.STATE[nEDState] then
		return 0;
	end
	
	if nCurDate >= (self.STATE[nSTState] or 0) and  nCurDate < self.STATE[nEDState] then
		return 1;
	end
end

function tbGirl:GetGblBuf()
	return self.tbGblBuf or {};
end

function tbGirl:SetGblBuf(tbBuf)
	self.tbGblBuf = tbBuf;
end

function tbGirl:IsHaveGirl(szName)
	local tbBuf = self:GetGblBuf();
	if tbBuf[szName] then
		return 1;
	end
	return 0;
end

function tbGirl:SignUpBuf(szName)
	local tbBuf = self:GetGblBuf();
	if tbBuf[szName] then
		return 1;
	end
	tbBuf[szName] = {"",0,0};
	if (MODULE_GC_SERVER) then
		KGblTask.SCSetDbTaskInt(DBTASK_GIRL_VOTE_MAX, (KGblTask.SCGetDbTaskInt(DBTASK_GIRL_VOTE_MAX) + 1));
		GlobalExcute({"SpecialEvent.Girl_Vote:SignUpBuf", szName});
	end
	self:SetGblBuf(tbBuf);
end

function tbGirl:BufVoteTicket(szName, nTickets, tbFans)
	local tbBuf = self:GetGblBuf();
	if tbBuf[szName] then
		if szName ~= tbFans.szFansName then
			if tbBuf[szName][2] < (tbFans.nTotleTickets + nTickets) then
				tbBuf[szName][2] 	= (tbFans.nTotleTickets + nTickets);
				tbBuf[szName][1] 	= tbFans.szFansName;
				tbBuf[szName][3] 	= tbFans.nFansSex
			end
		end
	end
	if (MODULE_GC_SERVER) then 
		local nCurHonor = PlayerHonor:GetPlayerHonorByName(szName, PlayerHonor.HONOR_CLASS_PRETTYGIRL, 0);
		PlayerHonor:SetPlayerHonorByName(szName, PlayerHonor.HONOR_CLASS_PRETTYGIRL, 0, nCurHonor + nTickets)
		GlobalExcute({"SpecialEvent.Girl_Vote:BufVoteTicket", szName, nTickets, tbFans});
	end
	if (not MODULE_GC_SERVER) then 
		local nPlayerId = KGCPlayer.GetPlayerIdByName(szName);
		local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
		if pPlayer then
			pPlayer.Msg(string.format("<color=yellow>%s<color>给你投了<color=yellow>%s<color>朵玫瑰，赶快向他道谢吧。", tbFans.szFansName, nTickets));
		end
	end
	self:SetGblBuf(tbBuf);
	Dbg:WriteLog("SpecialEvent.Girl_Vote", tbFans.szFansName.."投了"..nTickets.."票给"..szName);
end

function tbGirl:SetPassGirl(szName, nFlag)
	local tbBuf = self:GetGblBuf();
	if not tbBuf[szName] then
		return 1;
	end
	tbBuf[szName][4] = nFlag;
	if (MODULE_GC_SERVER) then
		GlobalExcute({"SpecialEvent.Girl_Vote:SetPassGirl", szName});
	end
end
