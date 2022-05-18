-- 文件名　：gril_vote_gs.lua
-- 创建者　：sunduoliang
-- 创建时间：2009-06-05 11:36:22
-- 描  述  ：
if (MODULE_GC_SERVER) then
	return 0;
end
SpecialEvent.Girl_Vote = SpecialEvent.Girl_Vote or {};
local tbGirl = SpecialEvent.Girl_Vote;

function tbGirl:GetRose(pPlayer, nNum)
	if self:IsOpen() ~= 1 then
		return 0;
	end
	local tbItemInfo = {};
	for i=1, nNum do
		local pItem = pPlayer.AddItemEx(self.ITEM_MEIGUI[1], self.ITEM_MEIGUI[2], self.ITEM_MEIGUI[3], self.ITEM_MEIGUI[4], tbItemInfo, Player.emKITEMLOG_TYPE_JOINEVENT);
		if pItem then
			--local nSec = math.floor((Lib:GetDate2Time(self.STATE[6]) - GetTime() / 60));
			--if nSec > 0 then
			--	pPlayer.SetItemTimeout(pItem, nSec, 0);			
			--end
			Dbg:WriteLog("SpecialEvent.Girl_Vote", pPlayer.szName.."获得物品："..pItem.szName);
		end
	end
end

function tbGirl:OnRecConnectMsg(szName, tbInfo)
	if not self.tbGblBuf then
		self.tbGblBuf = {};
	end
	if not self.tbGblBuf[szName] then
		self.tbGblBuf[szName] = tbInfo;
	end
end

function tbGirl:State1VoteTickets1(szName, nExTicket)
	--if szName == me.szName then
	--	Dialog:Say("不能自己给自己投票哦!");
	--	return 0;
	--end
	if KGblTask.SCGetDbTaskInt(DBTASK_GIRL_VOTE_MAX) >= 100000 then
		Dialog:Say("本服务器报名人数太多了,已达上限,请和游戏管理员联系.");
		return 0;
	end
	
	if SpecialEvent.Girl_Vote:IsHaveGirl(szName) == 0 then
		Dialog:Say("好像这个美女没有报名呀，你可以先叫她来报名，组队投票还能获得20%的额外票数加成哦。");
		return 0;
	end
	local nUseTask, nNews = self:GetTaskGirlVoteId(szName);
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
	Dialog:AskNumber(szInput, nCount, self.State1VoteTickets2, self, szName, (nExTicket or 0));
end

function tbGirl:State1VoteTickets2(szName, nExTicket, nTickets)
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
	
	local nUseTask, nNews = self:GetTaskGirlVoteId(szName);
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
	
	local nGroupId = SpecialEvent.Girl_Vote.TSK_GROUP;
	local nTotleTickets = me.GetTask(nGroupId, (nUseTask + (SpecialEvent.Girl_Vote.DEF_TASK_SAVE_FANS - 1)));
	if nNews == 1 then
		me.SetTaskStr(nGroupId, nUseTask, szName);
	end
	if nExTicket == 1 then
		nTickets = math.floor(nTickets * 1.2);
	end
	me.SetTask(nGroupId, (nUseTask + (SpecialEvent.Girl_Vote.DEF_TASK_SAVE_FANS - 1)), (nTotleTickets + nTickets));
	local tbFans = {
		szFansName = me.szName, 
		nFansSex   = me.nSex, 
		nTotleTickets = nTotleTickets,
	}
	GCExcute({"SpecialEvent.Girl_Vote:BufVoteTicket", szName, nTickets, tbFans});
	Dialog:Say(string.format("你成功给%s投了%s票。", szName, nTickets));
end

function tbGirl:GetTaskGirlVoteId(szName)
	local nGroupId = SpecialEvent.Girl_Vote.TSK_GROUP;
	local nUseTask = nil;
	local nNew = 0;
	for nTask = SpecialEvent.Girl_Vote.TSKSTR_FANS_NAME[1], SpecialEvent.Girl_Vote.TSKSTR_FANS_NAME[2], SpecialEvent.Girl_Vote.DEF_TASK_SAVE_FANS do
		if me.GetTaskStr(nGroupId, nTask) == szName then
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

function tbGirl:GetAward(pPlayer, nType, szMsg)
	if not self.DEF_AWARD_LIST[nType] then
		return 0;
	end
	
	if pPlayer.CountFreeBagCell() < self.DEF_AWARD_LIST[nType].freebag then
		Dialog:Say(string.format("您的背包空间不足，需要%s格背包空间。", self.DEF_AWARD_LIST[nType].freebag));
		return 0;
	end
	
	for szType, tbTmp in pairs(self.DEF_AWARD_LIST[nType]) do
		if szType == "mask" then
			local pItem = pPlayer.AddItem(unpack(tbTmp));
			if pItem then
				pItem.Bind(1);
				--pPlayer.SetItemTimeout(pItem, 365*24*60, 0);
				Dbg:WriteLog("SpecialEvent.Girl_Vote", pPlayer.szName.."获得物品："..pItem.szName);
				pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "【美女评选】获得"..pItem.szName);
			end
		end
		
		if szType == "skill" then
			pPlayer.AddSkillState(unpack(tbTmp));
			pPlayer.SetTask(SpecialEvent.Girl_Vote.TSK_GROUP, SpecialEvent.Girl_Vote.TSK_Award_Buff, GetTime());
			pPlayer.SetTask(SpecialEvent.Girl_Vote.TSK_GROUP, SpecialEvent.Girl_Vote.TSK_Award_Buff_Level, tbTmp[2]);
			Dbg:WriteLog("SpecialEvent.Girl_Vote", pPlayer.szName.."获得技能Buf："..tostring(tbTmp[1])..tostring(tbTmp[2]));
			pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "【美女评选】获得技能Buf："..tostring(tbTmp[1])..tostring(tbTmp[2]));
		end
		
		if szType == "title" then
			pPlayer.AddTitle(unpack(tbTmp));
			pPlayer.SetCurTitle(unpack(tbTmp));
			Dbg:WriteLog("SpecialEvent.Girl_Vote", pPlayer.szName.."获得称号："..tostring(tbTmp[1])..tostring(tbTmp[2])..tostring(tbTmp[3]));
			pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "【美女评选】获得称号："..tostring(tbTmp[1])..tostring(tbTmp[2])..tostring(tbTmp[3]));			
		end
		
		if szType == "item" then
			pPlayer.AddStackItem(unpack(tbTmp));
			Dbg:WriteLog("SpecialEvent.Girl_Vote", pPlayer.szName.."获得物品：10玄晶个数："..tostring(tbTmp[6]));
			pPlayer.PlayerLog(Log.emKPLAYERLOG_TYPE_JOINSPORT, "【美女评选】获得物品：10玄晶个数："..tostring(tbTmp[6]));						
		end
	end
	Dialog:Say(szMsg);
	return 1;
end
