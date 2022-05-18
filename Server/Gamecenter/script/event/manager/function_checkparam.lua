Require("\\script\\event\\manager\\define.lua");
local tbFun = EventManager.tbFun;

--已保证当前me为玩家
tbFun.tbLimitParamFun =
{
	CheckTaskDay 		= "CheckTaskDay", 		--Day天最多只能领取MaxCount次:需要2个任务变量param:dddd
	CheckTask			= "CheckTask", 			--任务变量>=几时返回不通过;需要1个任务变量param:dd
	CheckTaskLt			= "CheckTaskLt", 		--任务变量<几时返回不通过;需要1个任务变量param:dd
	CheckTaskEq			= "CheckTaskEq", 		--任务变量~=几时返回不通过;需要1个任务变量param:dd	
	CheckTaskCurTime	= "CheckTaskCurTime", 	--检查任务变量和当前时间比较
	CheckTaskGotoEvent 	= "CheckTaskGotoEvent", --跳到当前大活动的某个小活动事件；不再执行下面函数

	CheckGTaskDay 		= "CheckGTaskDay", 		--Day天最多只能领取MaxCount次:需要2个任务变量param:dddd
	CheckGTask			= "CheckGTask", 		--任务变量>=几时返回不通过;需要1个任务变量param:dd
	CheckGTaskLt		= "CheckGTaskLt", 		--任务变量<几时返回不通过;需要1个任务变量param:dd
	CheckGTaskEq		= "CheckGTaskEq", 		--任务变量==几时返回不通过;需要1个任务变量param:dd	
	CheckGTaskCurTime	= "CheckGTaskCurTime", 	--检查任务变量和当前时间比较
	CheckGTaskGotoEvent = "CheckGTaskGotoEvent",--跳到当前大活动的某个小活动事件；
	
	CheckExp 		= "CheckExp", 			--整次获得最多只能获得经验上限, 需要1个任务变量param:dd
	CheckExpDay		= "CheckExpDay", 		--Day天最多只能获得经验上限为ExpLimit, 需要2个任务变量param:dddd
	CheckMonthPay	= "CheckMonthPay", 		--本月累计充值达到n元,param:d
	CheckLevel		= "CheckLevel",			--达到nLevel等级玩家,param:d
	CheckFaction 	= "CheckFaction",		--限制等于该门派玩家,门派ID查表得,param:d
	CheckCamp 		= "CheckCamp",			--阵营限制,param:d
	CheckWeiWang	= "CheckWeiWang",		--江湖威望达到n，param:d
	CheckFreeBag	= "CheckFreeBag",		--检查背包空间
	CheckSex		= "CheckSex",			--检查性别(0,男性,1女性)
	CheckExt		= "CheckExt",			--检查每个累计充值扩展点高四位是否等于某值,等于返回失败,已激活
	CheckItemInBag	= "CheckItemInBag",		--检查身上是否有物品param:g,d,p,l,n,bool :bool ==0为身上要有物品条件通过
	CheckItemInAll	= "CheckItemInAll",		--检查身上,储物箱是否有物品g,d,p,l,n,bool:bool ==0为身上要有物品条件通过
	CheckInMapType	= "CheckInMapType",		--检查所在地图类型
	CheckInMapLevel = "CheckInMapLevel",	--检查所在地图等级
	CheckNpcAtNear	= "CheckNpcAtNear",		--检查npc是否在附近
	CheckLuaScript	= "CheckLuaScript",		--自定义脚本；
	CheckBindMoneyMax= "CheckBindMoneyMax",	--检查绑定银两上限
	CheckMoneyMax	= "CheckMoneyMax",		--检查银两上限
	
	CheckMoneyHonor = "CheckMoneyHonor",	--检查财富荣誉
	CheckNpcTaskEq	= "CheckNpcTaskEq",		--检查npc临时变量等于（npc消失后清除）
	CheckNpcTaskGt	= "CheckNpcTaskGt",		--检查npc临时变量等于（npc消失后清除）
	CheckNpcTaskLt	= "CheckNpcTaskLt",		--检查npc临时变量等于（npc消失后清除）
	CheckInKin		= "CheckInKin",			--检查是否在某个家族中
	CheckInTong		= "CheckInTong",		--检查是否在某个帮会中
	CheckHaveKin	= "CheckHaveKin",		--检查是否有家族
	CheckHaveTong	= "CheckHaveTong",		--检查是否有帮会
	CheckFuliJingHuoWeiWang="CheckFuliJingHuoWeiWang",--检查是否达到福利精活的江湖威望
	
	SetAwardId		= "CheckEventAward", 	--奖励表路径,param:string
	SetAwardIdUi	= "CheckEventAwardUi",	--给予界面奖励表路径,param:string	
	GoToEvent		= "CheckGoToEvent",		--事件跳转，跳转完回调回来会继续往下执行
	GoToOtherEvent	= "CheckGoToOtherEvent",--事件跳转到其他事件，跳转完回调回来会继续往下执行
	--自动检查
	AddItem 		= "CheckAddItem",			--获得物品
	AddBaseMoney 	= "CheckAddBaseMoney",		--生产效率绑定银两
	CoinBuyHeShiBi 	= "CheckCoinBuyHeShiBi",	--检测是否够资格购买和石壁；
	DelItem			= "CheckDelItem",			--删除物品
	AddXiulianTime 	= "CheckAddXiulianTime",	--自检增加修炼时间
	
	AddBindMoney	= "CheckBindMoneyMax",	  --检查绑定银两上限
	AddMoney		= "CheckMoneyMax",		  --检查银两上限		
	
	CheckRandom 		= "CheckRandom",		-- 检查几率
	CheckAddXiulianTime = "CheckAddXiulianTime",-- 检查增加修炼时间
	CheckTimeFrame 		= "CheckTimeFrame",     -- 检查时间轴
	AddExBindCoinByPay 	= "CheckExBindCoinByPay",--充值领取绑金（按一定比率返回）
	CheckLoginTimeSpace = "CheckLoginTimeSpace",-- 检查与上一次登陆时间间隔N小时以上
	CheckISCanGetRepute = "CheckISCanGetRepute" -- 检查是不是激活了江湖威望的领取
	
};

--和玩家无关的检查，无需保证当前me为玩家
tbFun.tbLimitParamFunWithOutPlayer =
{
	CheckLuaScriptNoMe  = "CheckLuaScript",	--设置脚本
	CheckGDate			= "CheckGDate",		--活动总时间判断YYYYmmddHHMM或YYYYmmdd
	CheckWeek			= "CheckWeek",		--检查周几
}

--条件判断 START----------------------------

--表，类型(nCheckType -  nil:普通的检查,检查函数都执行;  1:选项检查函数,选项变灰使用 2:表示eventId partId找不到时不报错) 
function tbFun:CheckParam(tbParam, nCheckType)
	if tbParam== nil then
		tbParam = {};
	end
	
	local nFlagW, szMsgW = self:CheckParamWithOutPlayer(tbParam, nCheckType);
	if nFlagW ~= 0 then
		return nFlagW, szMsgW;
	end
	
	local tbTaskPacth = self:GetParam(tbParam, "SetTaskBatch", 1);
	local nTaskPacth = 0;
	for _, nT in pairs(tbTaskPacth) do
		local nTempId = tonumber(nT) or 0;
		if nTempId > nTaskPacth then
			nTaskPacth = nTempId
		end
	end
	local nFlag = nil;
	if nCheckType == 2 then
		nFlag = 1;
	end
	local nEventId 	= tonumber(self:GetParam(tbParam, "__nEventId",nFlag)[1]);
	local nPartId 	= tonumber(self:GetParam(tbParam, "__nPartId",nFlag)[1]);	
	EventManager:GetTempTable().BASE_nTaskBatch = nTaskPacth;
	EventManager:GetTempTable().CurEventId = nEventId;
	EventManager:GetTempTable().CurPartId  = nPartId;
	local nReFlag = 0;
	local szReMsg = nil;	
	for nParam, szParam in ipairs(tbParam) do
		local nSit = string.find(szParam, ":");
		if nSit and nSit > 0 then
			local szFlag = string.sub(szParam, 1, nSit - 1);
			local szContent = string.sub(szParam, nSit + 1, string.len(szParam));
			if self.tbLimitParamFun[szFlag] ~= nil then
				local fncExcute = self[self.tbLimitParamFun[szFlag]];
				if fncExcute then
					local nFlag, szMsg = fncExcute(self, szContent, tbParam, nCheckType, nTaskPacth);
					if nFlag and nFlag ~= 0 then
						nReFlag = nFlag;
						szReMsg = szMsg;
						break;
						--条件不符合.
					end;
				end
			end
		end
	end
	EventManager:GetTempTable().BASE_nTaskBatch = 0;
	EventManager:GetTempTable().nCurEventId = 0;
	EventManager:GetTempTable().nCurPartId  = 0;
	return nReFlag, szReMsg;
end

function tbFun:CheckParamWithOutPlayer(tbParam, nCheckType)
	if tbParam== nil then
		tbParam = {};
	end
	local tbTaskPacth = self:GetParam(tbParam, "SetTaskBatch", 1);
	local nTaskPacth = 0;
	for nParam, szParam in ipairs(tbParam) do
		local nSit = string.find(szParam, ":");
		if nSit and nSit > 0 then
			local szFlag = string.sub(szParam, 1, nSit - 1);
			local szContent = string.sub(szParam, nSit + 1, string.len(szParam));
			if self.tbLimitParamFunWithOutPlayer[szFlag] ~= nil then
				local fncExcute = self[self.tbLimitParamFunWithOutPlayer[szFlag]];
				if fncExcute then
					local nFlag, szMsg = fncExcute(self, szContent, tbParam, nCheckType, nTaskPacth);
					if nFlag and nFlag ~= 0 then
						return nFlag, szMsg;
						--条件不符合.
					end;
				end
			end
		end
	end
	return 0;
end

--TaskDay:MaxCount, TaskId1, TaskId1	--每天最多只能领取MaxCount次:需要2个任务变量
function tbFun:CheckTaskDay(szParam, tbGParam, nCheckType, nTaskPacth)
	local tbParam = self:SplitStr(szParam);
	
	local nMaxCount = tonumber(tbParam[1]);
	local nTaskId1 = tonumber(tbParam[2]);
	local nTaskId2 = tonumber(tbParam[3]);
	local szReturnMsg = tbParam[4] or "你今天参加的次数已达上限";
	local nEventPartId 	= tonumber(tbParam[5]) or 0;
	
	local nTask1 = EventManager:GetTask(nTaskId1, nTaskPacth);
	local nTask2 = EventManager:GetTask(nTaskId2, nTaskPacth);
	local nNowDay = tonumber(GetLocalDate("%Y%m%d"));
	if (nNowDay > nTask2) then
		EventManager:SetTask(nTaskId1, 0);
		EventManager:SetTask(nTaskId2, nNowDay);
	end
	nTask1 = EventManager:GetTask(nTaskId1, nTaskPacth);
	if nTask1 >= nMaxCount and nMaxCount ~= 0 then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

--Task:MaxCount;TaskId									--整次活动只能领取MaxCount次;需要1个任务变量
function tbFun:CheckTask(szParam, tbGParam, nCheckType, nTaskPacth)
	local tbParam = self:SplitStr(szParam);

	local nMaxCount = tonumber(tbParam[2]);
	local nTaskId1  = tonumber(tbParam[1]);
	local szReturnMsg = tbParam[3] or "你参加的次数已达上限";
	local nEventPartId 	= tonumber(tbParam[4]) or 0;
	local nTask1 = EventManager:GetTask(nTaskId1, nTaskPacth);
	if nTask1 >= nMaxCount then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

function tbFun:CheckTaskLt(szParam, tbGParam, nCheckType, nTaskPacth)
	local tbParam = self:SplitStr(szParam);

	local nMaxCount = tonumber(tbParam[2]);
	local nTaskId1  = tonumber(tbParam[1]);
	local szReturnMsg = tbParam[3] or "你参加的次数已达上限";
	local nEventPartId 	= tonumber(tbParam[4]) or 0;
	local nTask1 = EventManager:GetTask(nTaskId1, nTaskPacth);
	if nTask1 < nMaxCount and nMaxCount ~= 0 then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;	
end

function tbFun:CheckTaskEq(szParam, tbGParam, nCheckType, nTaskPacth)
	local tbParam = self:SplitStr(szParam);

	local nMaxCount = tonumber(tbParam[2]);
	local nTaskId1  = tonumber(tbParam[1]);
	local szReturnMsg = tbParam[3] or "你参加的次数已达上限";
	local nEventPartId 	= tonumber(tbParam[4]) or 0;
	local nTask1 = EventManager:GetTask(nTaskId1, nTaskPacth);
	if nTask1 ~= nMaxCount then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end


--TaskDay:MaxCount, TaskId1, TaskId1	--每天最多只能领取MaxCount次:需要2个任务变量
function tbFun:CheckGTaskDay(szParam, tbGParam, nCheckType, nTaskPacth)
	local tbParam = self:SplitStr(szParam);
	
	local nMaxCount = tonumber(tbParam[1]);
	local nGroupId = tonumber(tbParam[2]); 
	local nTaskId1 = tonumber(tbParam[3]);
	local nTaskId2 = tonumber(tbParam[4]);
	local szReturnMsg = tbParam[5] or "你今天参加的次数已达上限";
	local nEventPartId 	= tonumber(tbParam[6]) or 0;
	
	local nTask1 = me.GetTask(nGroupId, nTaskId1);
	local nTask2 = me.GetTask(nGroupId, nTaskId2);
	local nNowDay = tonumber(GetLocalDate("%Y%m%d"));
	if (nNowDay > nTask2) then
		me.SetTask(nGroupId, nTaskId1, 0);
		me.SetTask(nGroupId, nTaskId2, nNowDay);
	end
	nTask1 = me.GetTask(nGroupId, nTaskId1);
	if nTask1 >= nMaxCount and nMaxCount ~= 0 then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

--Task:MaxCount;TaskId									--整次活动只能领取MaxCount次;需要1个任务变量
function tbFun:CheckGTask(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	
	local nGroupId  = tonumber(tbParam[1]);
	local nTaskId1  = tonumber(tbParam[2]);
	local nMaxCount = tonumber(tbParam[3]);
	local szReturnMsg = tbParam[4] or "你参加的次数已达上限";
	local nEventPartId 	= tonumber(tbParam[5]) or 0;
	local nTask1 = me.GetTask(nGroupId, nTaskId1);
	if nTask1 >= nMaxCount and nMaxCount ~= 0 then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

function tbFun:CheckGTaskLt(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	
	local nGroupId  = tonumber(tbParam[1]);
	local nTaskId1  = tonumber(tbParam[2]);
	local nMaxCount = tonumber(tbParam[3]);
	local szReturnMsg = tbParam[4] or "你参加的次数已达上限";
	local nEventPartId 	= tonumber(tbParam[5]) or 0;
	local nTask1 = me.GetTask(nGroupId, nTaskId1);
	if nTask1 < nMaxCount and nMaxCount ~= 0 then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;	
end

function tbFun:CheckGTaskEq(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	
	local nGroupId  = tonumber(tbParam[1]);
	local nTaskId1  = tonumber(tbParam[2]);
	local nMaxCount = tonumber(tbParam[3]);
	local szReturnMsg = tbParam[4] or "你参加的次数已达上限";
	local nEventPartId 	= tonumber(tbParam[5]) or 0;
	local nTask1 = me.GetTask(nGroupId, nTaskId1);
	if nTask1 ~= nMaxCount then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end



--
function tbFun:CheckMonthPay(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local nMonthPayLimit = tonumber(tbParam[1]) or 0;
	local szReturnMsg 	= tbParam[2];
	local nEventPartId 	= tonumber(tbParam[3]) or 0;
	if not nMonthPayLimit then
		print("【活动系统出错】MonthPay参数不对。");
		return 1;
	end
	szReturnMsg = szReturnMsg or string.format("您当月累计%s为<color=yellow>%s%s<color>，当月累计%s达到<color=yellow>%s%s<color>才能参加本次活动。", IVER_g_szPayName, me.GetExtMonthPay(1), IVER_g_szPayUnit, IVER_g_szPayName, nMonthPayLimit * IVER_g_nPayDouble, IVER_g_szPayUnit);
	if me.GetExtMonthPay() < nMonthPayLimit then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

function tbFun:CheckGDate(szParam)
	local tbParam = Lib:SplitStr(szParam, ",");
	local nStartDate = tonumber(tbParam[1]);
	local nEndDate = tonumber(tbParam[2]);
	local nNowDate = tonumber(GetLocalDate("%Y%m%d%H%M"));
	if nStartDate == -1 then
		return 1, "本活动已经暂时关闭。";
	end
	if nStartDate == 0 and nEndDate == 0 then
		return 0;
	end
	if nStartDate == 0 and nEndDate ~= 0 then
		if nEndDate < nNowDate then
			return 1, "本活动已经结束。";
		end
	end
	if nStartDate ~= 0 and nEndDate == 0 then
		if nStartDate > nNowDate then
			return 1, "本活动还没开始。";
		end
	end
	if nStartDate ~= 0 and nEndDate ~= 0 then
		if nNowDate < nStartDate or nNowDate > nEndDate then
			return 1, "不在活动期间。";
		end
	end 
	return 0;
end

function tbFun:CheckLevel(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);

	local nLevelParam = tonumber(tbParam[1]);
	local szReturnMsg = tbParam[2];
	if not tbParam[2] or tbParam[2] == "" then
		szReturnMsg = tbParam[2] or string.format("您的等级没达到要求，需要达到%s级。", nLevelParam);
	end
	
	
	local nEventPartId 	= tonumber(tbParam[3]) or 0;
	if me.nLevel < nLevelParam then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

function tbFun:CheckFaction(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local szReturnMsg = tbParam[2] or "您的门派不满足要求。";
	local nEventPartId 	= tonumber(tbParam[3]) or 0;
	if me.nFaction == tonumber(tbParam[1]) then
		return 0;
	end
	return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
end

function tbFun:CheckCamp(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local szReturnMsg = tbParam[2] or "您的阵营不满足要求。";
	local nEventPartId 	= tonumber(tbParam[3]) or 0;
	if me.GetCamp() == tonumber(tbParam[1]) then
		return 0;
	end
	return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);	
end

function tbFun:CheckWeek(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local szReturnMsg = tbParam[2] or "现在不是活动期间。";
	local nEventPartId 	= tonumber(tbParam[3]) or 0;
	if tonumber(GetLocalDate("%w")) == tonumber(tbParam[1]) then
		return 0;
	end
	return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
end

function tbFun:CheckEventAward(nParam)
	nParam = tonumber(nParam);
	if not nParam then
		return 1, "奖励表不存在";
	end
	if not self.AwardList[nParam] then
		return 1, "奖励表不存在";
	end

	local nCount = 0;
	local nMoney = 0;
	local nBindMoney = 0;
	for ni, tbItem in ipairs(self.AwardList[nParam].tbAward) do
		if tbItem.nRandRate == 0 and tbItem.nGenre ~= 0 and tbItem.nDetail ~= 0 and tbItem.nParticular ~= 0 then
			if tbItem.nNeedBagFree > 0 then
				nCount = nCount + tbItem.nNeedBagFree;
			else
				nCount = nCount + tbItem.nAmount;
			end
		end
		if tbItem.nRandRate == 0 and tbItem.nJxMoney > 0 then
			nMoney = nMoney + tbItem.nJxMoney;
		end
		if tbItem.nRandRate == 0 and tbItem.nJxBindMoney > 0 then
			nBindMoney = nBindMoney + tbItem.nJxBindMoney;
		end		
	end
	
	if nBindMoney + me.GetBindMoney() > me.GetMaxCarryMoney() then
		return 1, "你的身上的绑定银两即将达到上限，请清理一下身上的绑定银两。";
	end
	
	if nMoney + me.nCashMoney > me.GetMaxCarryMoney() then
		return 1, "你的身上的银两即将达到上限，请清理一下身上的银两。";
	end	
	
	local nCFlag, szCMsg = self:_CheckItemFree(me, nCount)
	if nCFlag == 1 then
		return 1, szCMsg;
	end	
	
	for ni, tbItem in ipairs(self.AwardList[nParam].tbMareial) do
		local nFlag, szMsg = self:_CheckItem(me, tbItem)
		if nFlag == 1 then
			return 1, szMsg;
		end
	end
	
	return 0;
end

function tbFun:CheckEventAwardUi(szParam)
	local tbParam = self:SplitStr(szParam);
	local nParam = tonumber(tbParam[1]);
	if not nParam then
		return 1, "奖励表不存在";
	end
	if not self.AwardList[nParam] then
		return 1, "奖励表不存在";
	end

	local nCount = 0;
	for ni, tbItem in ipairs(self.AwardList[nParam].tbAward) do
		if tbItem.nRandRate == 0 and tbItem.nGenre ~= 0 and tbItem.nDetail ~= 0 and tbItem.nParticular ~= 0 then
			local tbItemInfo = {};
			if self:TimerOutCheck(tbItem.szTimeLimit) == 1 then
				tbItemInfo.bTimeOut = 1;
			end
			
			if tbItem.nBind > 0 then
				tbItemInfo.bForceBind = tbItem.nBind;
			end			
			local nFreeCount = KItem.GetNeedFreeBag(tbItem.nGenre, tbItem.nDetail, tbItem.nParticular, tbItem.nLevel, tbItemInfo, (tbItem.nAmount or 1))
			nCount = nCount + nFreeCount;
		end
	end	
	
	local nCFlag, szCMsg = self:_CheckItemFree(me, nCount)
	if nCFlag == 1 then
		return 1, szCMsg;
	end
	
	return 0;
end

function tbFun:_CheckItem(pPlayer, tbItem)
	if tbItem.nJxMoney ~= 0 then
		if pPlayer.nCashMoney < tbItem.nJxMoney then
			return 1, "对不起，您身上的银两不足。";
		end
	end
	
	if tbItem.nJxBindMoney ~= 0 then
		if pPlayer.GetBindMoney() + pPlayer.nCashMoney < tbItem.nJxBindMoney then
			return 1, "对不起，您身上的银两不足。";
		end
	end
	
	if tbItem.nJxCoin ~= 0 then
		if pPlayer.nBindingCoinMoney < tbItem.nJxCoin then
			return 1, string.format("对不起，您的绑定%s不足。", IVER_g_szCoinName);
		end
	end
	
	if tbItem.nGenre ~= 0 and tbItem.nDetail ~= 0 and tbItem.nParticular ~= 0 then
		local nCount = pPlayer.GetItemCountInBags(tbItem.nGenre, tbItem.nDetail, tbItem.nParticular, tbItem.nLevel, tbItem.nSeries);
		if nCount < tbItem.nAmount then
			return 1, "对不起，您的物品不足。";
		end
	end	
	return 0;
end

function tbFun:_CheckItemFree(pPlayer, nCount)
	if nCount > 0 and pPlayer.CountFreeBagCell() < nCount then
		return 1, string.format("对不起，您身上的背包空间不足，需要%s格背包空间。", nCount);
	end
	return 0;
end

function tbFun:CheckWeiWang(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local nWeiWangLimit = tonumber(tbParam[1]) or 0;
	local szReturnMsg = tonumber(tbParam[2]) or string.format("您的江湖威望不足%s点，不能参加本次活动。", nWeiWangLimit);
	local nEventPartId 	= tonumber(tbParam[3]) or 0;
	if me.nPrestige < nWeiWangLimit then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

function tbFun:CheckAddItem(szParam)
	local tbParam 	= self:SplitStr(szParam);
	local tbItem 	= self:SplitStr(tbParam[1]);
	local nG	  	= tonumber(tbItem[1]);
	local nD		= tonumber(tbItem[2]);
	local nP		= tonumber(tbItem[3]);
	local nL		= tonumber(tbItem[4]);
	local nCount	= tonumber(tbParam[2]);
	local nBind		= tonumber(tbParam[3]);
	local nTimeOut	= tonumber(tbParam[4]);
	local nNeed = KItem.GetNeedFreeBag(nG, nD, nP, nL, {bTimeOut=nTimeOut}, nCount);
	if me.CountFreeBagCell() < nNeed then
		return 1, string.format("对不起，您身上的背包空间不足，需要%s格背包空间。", nNeed);
	end
	return 0;
end

function tbFun:CheckFreeBag(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local nCount	= tonumber(tbParam[1]);
	local szReturnMsg = tbParam[2] or string.format("对不起，您身上的背包空间不足，需要%s格背包空间。", nCount);
	local nEventPartId 	= tonumber(tbParam[3]) or 0;
	if me.CountFreeBagCell() < nCount then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

function tbFun:CheckBindMoneyMax(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local nCount	= tonumber(tbParam[1]);
	local szReturnMsg = tbParam[2] or string.format("对不起，您身上的绑定银两将达上限，请先整理身上的绑定银两。");
	local nEventPartId 	= tonumber(tbParam[3]) or 0;
	if me.GetBindMoney() + nCount > me.GetMaxCarryMoney() then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

function tbFun:CheckMoneyMax(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local nCount	= tonumber(tbParam[1]);
	local szReturnMsg = tbParam[2] or string.format("对不起，您身上的银两将达上限，请先整理身上的银两。");
	local nEventPartId 	= tonumber(tbParam[3]) or 0;
	if me.nCashMoney + nCount > me.GetMaxCarryMoney() then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

function tbFun:CheckMoneyHonor(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local nHonor	= tonumber(tbParam[1]);
	local szReturnMsg = tbParam[2] or string.format("对不起，您的财富荣誉没达到%s点。", nHonor);
	local nEventPartId 	= tonumber(tbParam[3]) or 0;
	if PlayerHonor:GetPlayerHonorByName(me.szName, 8, 0) < nHonor then
		EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		return 1, szReturnMsg;
	end	
	return 0;
end

function tbFun:CheckSex(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local nSex = tonumber(tbParam[1]);
	local szReturnMsg = tbParam[2] or string.format("对不起，只有%s玩家才能领取。", Env.SEX_NAME[nSex]);
	local nEventPartId 	= tonumber(tbParam[3]) or 0;
	if not Env.SEX_NAME[nSex] then
		print("【活动系统】Sex参数错误");
		return 1;
	end
	if nSex ~= me.nSex then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

function tbFun:CheckExt(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local nBit		= tonumber(tbParam[1]);
	local nExt 		= tonumber(tbParam[2]);
	local szReturnMsg = tbParam[3] or "你的帐号已经被激活";
	local nEventPartId 	= tonumber(tbParam[4]) or 0;
	if me.GetActiveValue(nBit) ~= nExt then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

function tbFun:CheckItemInBag(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local szItem 	= tbParam[1];
	local nCount 	= tonumber(tbParam[2]) or 1;
	local bInOrOut 	= tonumber(tbParam[3]) or 0;
	local szReturnMsg 	= tbParam[4] or string.format("你拥有的%s不满足要求。", KItem.GetNameById(unpack(tbItem)));
	local nEventPartId 	= tonumber(tbParam[5]) or 0;	
	local tbItem 	= self:SplitStr(szItem);
	local nBagCount = me.GetItemCountInBags(unpack(tbItem)) or 0;
	if bInOrOut == 0 then
		if nBagCount < nCount then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	else
		if nBagCount >= nCount then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	end
	return 0;
end

function tbFun:CheckItemInAll(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local szItem 	= tbParam[1];
	local nCount 	= tonumber(tbParam[2]);
	local bInOrOut 	= tonumber(tbParam[3]) or 0;
	local szReturnMsg 	= tbParam[4];
	local nEventPartId 	= tonumber(tbParam[5]) or 0;	
	local tbItem 	= self:SplitStr(szItem);
	local tbFind = me.FindItemInBags(unpack(tbItem));
	local tbFind2 = me.FindItemInRepository(unpack(tbItem));
	if bInOrOut == 0 then
		if #tbFind + #tbFind2 <  nCount then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	else
		if #tbFind + #tbFind2 >=  nCount then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	end
	return 0;
end

function tbFun:CheckInMapType(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local szType 	= tbParam[1];
	local bInOrOut 	= tonumber(tbParam[2]) or 0;
	local szReturnMsg 	= tbParam[3];
	local nEventPartId 	= tonumber(tbParam[4]) or 0;	
	
	local nMapIndex = SubWorldID2Idx(me.nMapId);
	local nMapTemplateId = SubWorldIdx2MapCopy(nMapIndex);
	local szMapType = GetMapType(nMapTemplateId);
	if bInOrOut == 0 then	--必须在szType类型的地图
		if szType ~= szMapType then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	else
		if szType == szMapType then --必须不在szType类型的地图
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end	
	end

	return 0;
end

function tbFun:CheckInMapLevel(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local nLevel 	= tbParam[1];
	local bInOrOut 	= tonumber(tbParam[2]) or 0;
	local szReturnMsg 	= tbParam[3];
	local nEventPartId 	= tonumber(tbParam[4]) or 0;	
	
	local nMapIndex = SubWorldID2Idx(me.nMapId);
	local nMapTemplateId = SubWorldIdx2MapCopy(nMapIndex);
	local nMapLevel = GetMapLevel(nMapTemplateId);
	if bInOrOut == 0 then --必须在nMapLevel等级以上的地图（包括nMapLevel）
		if nMapLevel < nLevel then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	elseif bInOrOut == 1 then --必须等于nMapLevel等级的地图
		if nMapLevel ~= nLevel then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end		
	else
		--必须小于nMapLevel等级的地图（不包括nMapLevel）
		if nMapLevel >= nLevel then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	end

	return 0;
end


function tbFun:CheckDialogNpcAtNear(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local szReturnMsg 	= tbParam[1] or string.format("你附近有%s在，必须附近没有其他对话npc才行", pNpc.szName);
	local nEventPartId 	= tonumber(tbParam[2]) or 0;	
	
	local tbNpcList = KNpc.GetAroundNpcList(me, 10);
	for _, pNpc in ipairs(tbNpcList) do
		if pNpc.nKind == 3 then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	end
	return 0;
end


function tbFun:CheckNpcAtNear(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local nNpcId 	= tonumber(tbParam[1]) or 0;
	local bBeLong 	= tonumber(tbParam[2]) or 0;
	local szReturnMsg 	= tbParam[3] or "你附近找不到你想要的npc";
	local nEventPartId 	= tonumber(tbParam[4]) or 0;	
	local nFind = 0;
	local tbNpcList = KNpc.GetAroundNpcList(me, 20);
	for _, pNpc in ipairs(tbNpcList) do
		if pNpc.nTemplateId == nNpcId then
			if bBeLong == 1 then
				if pNpc.GetTempTable("Npc").EventManager then
					if pNpc.GetTempTable("Npc").EventManager.nBeLongPlayerId == me.nId then
						nFind = 1;
						break
					end
				end
			else
				nFind = 1;
				break;
			end
		end
	end	
	if nFind == 0 then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
	end
	return 0;
end

function tbFun:CheckTaskCurTime(szParam, tbGParam, nCheckType, nTaskPacth)
	local tbParam 	= self:SplitStr(szParam);
	local nTaskId 	= tonumber(tbParam[1]) or 0;
	local nSec 		= tonumber(tbParam[2]) or 0;
	local nType 	= tonumber(tbParam[3]) or 0;
	local szReturnMsg 	= tbParam[4] or "";
	local nEventPartId 	= tonumber(tbParam[5]) or 0;	
	if EventManager:GetTask(nTaskId, nTaskPacth) == 0 then
		return 0;
	end
	if nType == 0 then --如果在n秒内的情况，不满足
		if EventManager:GetTask(nTaskId, nTaskPacth) + nSec > GetTime() then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	end
	if nType == 1 then --如果在n秒外的情况，不满足
		if EventManager:GetTask(nTaskId, nTaskPacth) + nSec < GetTime() then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	end
	return 0;
end

--跳转，不往下执行
function tbFun:CheckTaskGotoEvent(szParam, tbGParam, nCheckType, nTaskPacth)
	local tbParam 	= self:SplitStr(szParam);
	local nTaskId 	= tonumber(tbParam[1]) or 0;
	local nValue 	= tonumber(tbParam[2]) or 0;
	local nType 	= tonumber(tbParam[3]) or 0;
	local nEventPartId 	= tonumber(tbParam[4]) or 0;
	local nEventId 	= tonumber(self:GetParam(tbGParam, "__nEventId")[1]);
	local nPartId 	= tonumber(self:GetParam(tbGParam, "__nPartId")[1]);
	if nEventPartId == nPartId then
		print("【活动系统】Error!!!CheckTaskGotoEvent重复调用自己");
		return 0;
	end
	if nType == 0 then--等于
		if EventManager:GetTask(nTaskId, nTaskPacth) == nValue then
			return EventManager:GotoEventPartTable(nEventId, nEventPartId, nCheckType, nil, 2);
		end
	end
	if nType == 1 then--小于
		if EventManager:GetTask(nTaskId, nTaskPacth) < nValue then
			return EventManager:GotoEventPartTable(nEventId, nEventPartId, nCheckType, nil, 2);
		end
	end
	if nType == 2 then--大于
		if EventManager:GetTask(nTaskId, nTaskPacth) > nValue then
			return EventManager:GotoEventPartTable(nEventId, nEventPartId, nCheckType, nil, 2);
		end		
	end	
	return 0;
end

function tbFun:CheckGTaskCurTime(szParam, tbGParam)
	local tbParam 	= self:SplitStr(szParam);
	local nGroupId 	= tonumber(tbParam[1]) or 0;
	local nTaskId 	= tonumber(tbParam[2]) or 0;
	local nSec 		= tonumber(tbParam[3]) or 0;
	local nType 	= tonumber(tbParam[4]) or 0;
	local szReturnMsg 	= tbParam[5] or "";
	local nEventPartId 	= tonumber(tbParam[6]) or 0;	
	if me.GetTask(nGroupId, nTaskId) == 0 then
		return 0;
	end
	if nType == 0 then --如果在n秒内的情况，不满足
		if me.GetTask(nGroupId, nTaskId) + nSec > GetTime() then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	end
	if nType == 1 then --如果在n秒外的情况，不满足
		if me.GetTask(nGroupId, nTaskId) + nSec < GetTime() then
			return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam);
		end
	end
	return 0;
end

function tbFun:CheckGTaskGotoEvent(szParam, tbGParam, nCheckType)
	local tbParam 	= self:SplitStr(szParam);
	local nGroupId 	= tonumber(tbParam[1]) or 0;
	local nTaskId 	= tonumber(tbParam[2]) or 0;
	local nValue 	= tonumber(tbParam[3]) or 0;
	local nType 	= tonumber(tbParam[4]) or 0;
	local nEventPartId 	= tonumber(tbParam[5]) or 0;
	local nEventId 	= tonumber(self:GetParam(tbGParam, "__nEventId")[1]);
	local nPartId 	= tonumber(self:GetParam(tbGParam, "__nPartId")[1]);
	if nEventPartId == nPartId then
		print("【活动系统】Error!!!CheckTaskGotoEvent重复调用自己");
		return 0;
	end
	if nType == 0 then--等于
		if me.GetTask(nGroupId, nTaskId) == nValue then
			return EventManager:GotoEventPartTable(nEventId, nEventPartId, nCheckType);
		end
	end
	if nType == 1 then--小于
		if me.GetTask(nGroupId, nTaskId) < nValue then
			return EventManager:GotoEventPartTable(nEventId, nEventPartId, nCheckType);
		end
	end
	if nType == 2 then--大于
		if me.GetTask(nGroupId, nTaskId) > nValue then
			return EventManager:GotoEventPartTable(nEventId, nEventPartId, nCheckType);
		end		
	end	
	return 0;
end

function tbFun:CheckLuaScript(szParam, tbGParam, nCheckType)
	local tbParam = self:SplitStr(szParam);
	local szScript = tbParam[1];
	local nEventPartId 	= tonumber(tbParam[2]) or 0;	
	
	szScript = string.gsub(szScript, "<enter>", "\n");
	szScript = string.gsub(szScript, "<tab>", "\t");
	local nReturn, szReturnMsg = loadstring(szScript)();
	if nReturn == 1 then
		return EventManager:CheckGotoEventPartTable(nEventPartId, szReturnMsg, tbGParam, nCheckType);
	end
	return nReturn;
end

function tbFun:CheckAddBaseMoney(szParam, tbGParam, nCheckType)
	local tbParam = self:SplitStr(szParam);
	local nMoney  = tonumber(tbParam[1]) or 0;
	local nType   = tonumber(tbParam[2]) or 0;
	local nLimit  = tonumber(tbParam[3]) or 0 ;
	local nAdd = math.floor(nMoney * me.GetProductivity() / 100);
	if nLimit > 0 and nAdd > nLimit then
		nAdd = nLimit;
	end
	if nType == 1 then
	 	local nMoneyInBag = me.nCashMoney;
	 	local szType = "银两";	
	 	if nMoneyInBag + nAdd > me.GetMaxCarryMoney() then
			return 1, string.format("您身上的%s将要达到上限，请整理后再来领取。", szType);
		end
	elseif nType == 7 then
		local nMoneyInBag = me.GetBindMoney();
		local szType = "绑定银两";
	 	if nMoneyInBag + nAdd > me.GetMaxCarryMoney() then
			return 1, string.format("您身上的%s将要达到上限，请整理后再来领取。", szType);
		end			
	end
	return 0;
end

function tbFun:CheckCoinBuyHeShiBi(szParam, tbGParam, nCheckType)
	if SpecialEvent.BuyHeShiBi:Check() == 0 then
		return 1;
	end
	return 0;
end

function tbFun:CheckGoToEvent(szParam, tbGParam, nCheckType)
	local tbParam = self:SplitStr(szParam);
	local nEventPartId 	= tonumber(tbParam[1]) or 0;

	if nEventPartId > 0 then
		local nEventId 	= tonumber(self:GetParam(tbGParam, "__nEventId")[1]);
		local nPartId 	= tonumber(self:GetParam(tbGParam, "__nPartId")[1]);
		if nEventPartId == nPartId then
			print("【活动系统】Error!!!CheckTaskGotoEvent重复调用自己");
			return 0;
		end
		return EventManager:GotoEventPartTable(nEventId, nEventPartId, 1);
	end
end

function tbFun:CheckGoToOtherEvent(szParam, tbGParam, nCheckType)
	local tbParam = self:SplitStr(szParam);
	local nEventEId 	= tonumber(tbParam[1]) or 0;
	local nEventPartId 	= tonumber(tbParam[2]) or 0;
	if nEventPartId > 0 then
		local nEventId 	= tonumber(self:GetParam(tbGParam, "__nEventId")[1]);
		local nPartId 	= tonumber(self:GetParam(tbGParam, "__nPartId")[1]);
		if nEventEId == nEventId and nEventPartId == nPartId then
			print("【活动系统】Error!!!CheckTaskGotoEvent重复调用自己");
			return 0;
		end
		return EventManager:GotoEventPartTable(nEventEId, nEventPartId, 1);
	end	
end

function tbFun:CheckNpcTaskEq(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local szKey 		= tbParam[1] or 0;
	local nTskValue 	= tonumber(tbParam[2]) or 0;
	local szReturnMsg 	= tbParam[3] or "你的条件不满足。";
	if not him then
		return 1, szReturnMsg;
	end
	local tbTable = him.GetTempTable("Npc");
	tbTable.EventManager = tbTable.EventManager or {};
	tbTable.EventManager.tbTask = tbTable.EventManager.tbTask or {};
	tbTable.EventManager.tbTask[szKey] = tbTable.EventManager.tbTask[szKey] or {};
	local nValue = tonumber(tbTable.EventManager.tbTask[szKey][me.nId]) or 0;
	if nTskValue ~= nValue then
		return 1, szReturnMsg;
	end
	return 0;
end

function tbFun:CheckNpcTaskGt(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local szKey 		= tbParam[1] or 0;
	local nTskValue 	= tonumber(tbParam[2]) or 0;
	local szReturnMsg 	= tbParam[3] or "你的条件不满足。";
	if not him then
		return 1, szReturnMsg;
	end
	local tbTable = him.GetTempTable("Npc");
	tbTable.EventManager = tbTable.EventManager or {};
	tbTable.EventManager.tbTask = tbTable.EventManager.tbTask or {};
	tbTable.EventManager.tbTask[szKey] = tbTable.EventManager.tbTask[szKey] or {};
	local nValue = tonumber(tbTable.EventManager.tbTask[szKey][me.nId]) or 0;
	if nTskValue >= nValue then
		return 1, szReturnMsg;
	end
	return 0;
end

function tbFun:CheckNpcTaskLt(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local szKey 		= tbParam[1] or 0;
	local nTskValue 	= tonumber(tbParam[2]) or 0;
	local szReturnMsg 	= tbParam[3] or "你的条件不满足。";
	if not him then
		return 1, szReturnMsg;
	end
	local tbTable = him.GetTempTable("Npc");
	tbTable.EventManager = tbTable.EventManager or {};
	tbTable.EventManager.tbTask = tbTable.EventManager.tbTask or {};
	tbTable.EventManager.tbTask[szKey] = tbTable.EventManager.tbTask[szKey] or {};
	local nValue = tonumber(tbTable.EventManager.tbTask[szKey][me.nId]) or 0;	
	if nTskValue <= nValue then
		return 1, szReturnMsg;
	end
	return 0;
end

-- by zhangjinpin@kingsoft
function tbFun:CheckAddXiulianTime(szParam, tbGParam)	
	
	local tbParam = self:SplitStr(szParam);
	local nTime = tonumber(tbParam[1]) or 0;
	local szReturnMsg = tbParam[2] or "你领取后修炼珠的总时间超过了上限！";	
	
	local tbXiuLianZhu = Item:GetClass("xiulianzhu");
	if tbXiuLianZhu:GetReTime() + nTime > 14 then
		return 1, szReturnMsg;
	end
	
	return 0;
end

function tbFun:CheckRandom(szParam, tbGParam)
	
	local tbParam = self:SplitStr(szParam);
	local nMin = tonumber(tbParam[1]) or 1;
	local nMax = tonumber(tbParam[2]) or 1;
	local szReturnMsg = tbParam[3] or "你的条件不满足。";	
	
	local nRandom = MathRandom(1, nMax);
	if nRandom > nMin then
		return 1, szReturnMsg;
	end
	
	return 0;
end

function tbFun:CheckFuliJingHuoWeiWang(szParam, tbGParam)
	local nPrestige = Player.tbBuyJingHuo:GetTodayPrestige()
	if (nPrestige <= 0) then
		return 1, "还没进行全区威望排名，无法知道今天的优惠威望要求，请等排名后再来吧";
	end
	
	if (me.nPrestige < nPrestige) then
		return 1, "你的江湖威望不足<color=red>"..nPrestige.."点<color>。";
	end
	return 0;
end

function tbFun:CheckTimeFrame(szParam, tbGParam)	
	local tbParam = self:SplitStr(szParam);
	local szClass = tbParam[1];
	local nReqState = tonumber(tbParam[2]) or 1;
	local szReturnMsg = tbParam[3] or "你的条件不满足。";	
	local nCurState = TimeFrame:GetState(szClass);
	if nCurState == nReqState then 
		return 0;	
	end
	return 1 , szReturnMsg;
end

function tbFun:CheckExBindCoinByPay(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local nTaskId = tonumber(tbParam[1]) or 0;
	local nMinMoney = tonumber(tbParam[2]) or 0;
	local nMaxMoney = tonumber(tbParam[3]) or 0;
	local nRate = tonumber(tbParam[4]) or 0;
	local nPay = me.GetExtMonthPay();
	if nMaxMoney < nPay and nMaxMoney ~= 0 then
		nPay = nMaxMoney;
	end
	local nCount = math.floor((nPay - nMinMoney)/ 50);
	if nCount == 0 then
		return 1,  string.format("充值超过%s才可以领取(超过的部分每50返回%s％)。", nMinMoney, nRate);
	end
	if EventManager:GetTask(nTaskId) >= nCount then
		return 1,  string.format("赠送的%s绑定金币已经成功领取完毕，继续充值才可以再次领奖(超过的部分每50返回%s％)。", nCount*50 * nRate, nRate);
	end
	return 0;
end

function tbFun:CheckInKin(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local szKins = tbParam[1];
	local tbKins = Lib:SplitStr(szKins, "&");
	local nFigure = tonumber(tbParam[2]) or 0;
	local szReturnMsg = tbParam[3] or "对不起，您的条件不满足。";
	local nKinId, nKinMemId = me.GetKinMember();
	if nKinId == nil or nKinId <= 0 then
		return 1, "对不起，您不是家族成员。";
	end
	
	if nFigure > 0 and Kin:HaveFigure(nKinId, nKinMemId, nFigure) ~= 1 then
		return 1, "对不起，您的家族权限条件不够。";
	end	
	local cKin = KKin.GetKin(nKinId);
	local szKinName = cKin.GetName();	
	for _, szKin in pairs(tbKins) do
		if szKin == szKinName then
			return 0;
		end
	end
	return 1, szReturnMsg;
end

function tbFun:CheckInTong(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local szTongs = tbParam[1];
	local tbTongs = Lib:SplitStr(szTongs, "&");
	local nFigure = tonumber(tbParam[2]) or 0;
	local szReturnMsg = tbParam[3] or "对不起，您的条件不满足。";
	local nTongId = me.dwTongId;
	if nTongId == nil or nTongId <= 0 then
		return 1, "对不起，您不是帮会成员。";
	end
	
	local cTong = KTong.GetTong(nTongId)
	if not cTong then
		return 1, "对不起，您不是帮会成员。";
	end
	
	local szTongName = cTong.GetName();
	
	local nKinId, nKinMemId = me.GetKinMember();
	if nKinId == nil or nKinId <= 0 then
		return 1, "对不起，您不是帮会成员。";
	end
	
	if nFigure > 0 and Kin:HaveFigure(nKinId, nKinMemId, nFigure) ~= 1 then
		return 1, "对不起，您的家族权限条件不够。";
	end	
	for _, szTongs in pairs(tbTongs) do
		if szTongs == szTongName then
			return 0;
		end
	end
	return 1, szReturnMsg;	
end

function tbFun:CheckHaveKin(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local nFigure = tonumber(tbParam[1]) or 0;
	local szReturnMsg = tbParam[2] or "对不起，您不是家族成员。";
	local nKinId, nKinMemId = me.GetKinMember();
	if nKinId == nil or nKinId <= 0 then
		return 1, szReturnMsg;
	end
	if nFigure > 0 and Kin:HaveFigure(nKinId, nKinMemId, nFigure) ~= 1 then
		return 1, szReturnMsg;
	end
	return 0;
end

function tbFun:CheckHaveTong(szParam, tbGParam)
	local tbParam = self:SplitStr(szParam);
	local nFigure = tonumber(tbParam[1]) or 0;
	local szReturnMsg = tbParam[2] or "对不起，您不是帮会成员。";
	local nTongId = me.dwTongId;
	if nTongId == nil or nTongId <= 0 then
		return 1, szReturnMsg;
	end
	
	local cTong = KTong.GetTong(nTongId)
	if not cTong then
		return 1, szReturnMsg;
	end
	
	local nKinId, nKinMemId = me.GetKinMember();
	if nKinId == nil or nKinId <= 0 then
		return 1, szReturnMsg;
	end
	
	if nFigure > 0 and Kin:HaveFigure(nKinId, nKinMemId, nFigure) ~= 1 then
		return 1, szReturnMsg;
	end	

	return 0;		
end

function tbFun:CheckLoginTimeSpace(szParam)
	local tbParam = self:SplitStr(szParam);
	local nNumber = tonumber(tbParam[1]) or 0;
	local szReturnMsg = tbParam[2] or "您登陆间隔的小时数不足当前检查的小时数！";
	local nLastLoginTime = me.GetTask(2063, 16) or 0;
	local nData = me.GetTask(2063, 17) or 0;
	if nData - nLastLoginTime < nNumber*3600 then
		return 1, szReturnMsg;
	end
	if nLastLoginTime == 0 or nData == 0 then
		return 1, szReturnMsg;
	end
	return 0;
end

function tbFun:CheckISCanGetRepute(szParam)
	local tbParam = self:SplitStr(szParam);
	local szReturnMsg = tbParam[1] or "您还没有激活领取江湖威望，可以到礼官那里去激活！";
	if SpecialEvent.ChongZhiRepute:CheckISCanGetRepute() == 0 then
		return 1, szReturnMsg;
	end
	return 0;
end

function tbFun:CheckDelItem(szParam)
	local tbParam 	= self:SplitStr(szParam);
	local szItem	= tbParam[1];
	local nCount	= tonumber(tbParam[2]) or 1;
	local tbItem 	= self:SplitStr(szItem);
	local nBagCount = me.GetItemCountInBags(unpack(tbItem)) or 0;
	if nBagCount < nCount then
		return 1, string.format("你身上背包中的物品<color=yellow>%s<color>数量不足<color=red>%s个<color>。", KItem.GetNameById(unpack(tbItem)), nCount);
	end
	return 0;
end

---条件判断 END ------------
