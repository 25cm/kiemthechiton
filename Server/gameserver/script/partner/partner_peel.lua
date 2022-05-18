------------------------------------------------------
-- 文件名　：partner_peel.lua
-- 创建者　：dengyong
-- 创建时间：2010-01-05 17:07:20
-- 描  述  ：洗同伴等级相关脚本
------------------------------------------------------

if not MODULE_GAMESERVER then
	return;
end

if not Partner then
	Partner = {};
end

-- 返回1，表示当前没有申请；返回0，表示当前有有效的申请
function Partner:GetPeelState(pPlayer)
	local nApplyTime = pPlayer.GetTask(self.TASK_PEEL_PARTNER_GROUPID, self.TASK_PEEL_PARTNER_SUBID);
	
	if nApplyTime == 0 then
		return 1;
	else
		local nDiffTime = GetTime() - nApplyTime;
		
		if nDiffTime <= 0 or nDiffTime > self.PEEL_USABLE_MAXTIME then
			return 1;
		else
			return 0;
		end 
	end
end

-- 申请洗同伴等级
function Partner:ApplyPeelPartner(nPlayerId)
	local pPlayer = me or KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return;
	end
	
	if pPlayer.IsAccountLock() == 1 then
		pPlayer.Msg("Tài khoản của bạn bị khóa, không thể áp dụng cho sự hồi sinh của đồng hành! Vui lòng mở  khóa.");
		Partner:SendClientMsg("Tài khoản của bạn bị khóa, không thể áp dụng cho sự hồi sinh của đồng hành! Vui lòng mở  khóa.");
		return 0;
	end
	
	pPlayer.SetTask(self.TASK_PEEL_PARTNER_GROUPID, self.TASK_PEEL_PARTNER_SUBID, GetTime());
	pPlayer.AddSkillState(self.PEELDEBUFF_SKILLID, 1, 2, self.PEEL_USABLE_MAXTIME * Env.GAME_FPS, 1, 0, 1);
	
	pPlayer.Msg("Bạn đã hồi sinh thành công 1 đồng hành");
end

-- 取消申请
function Partner:CancelPeelPartner(nPlayerId)
	local pPlayer = me or KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return;
	end
	
	pPlayer.SetTask(self.TASK_PEEL_PARTNER_GROUPID, self.TASK_PEEL_PARTNER_SUBID, 0);
	pPlayer.RemoveSkillState(self.PEELDEBUFF_SKILLID);
	
	pPlayer.Msg("Bạn đã hủy hồi sinh đồng hành");
end

-- 将指定的同伴剥离成1级的同伴，并将同伴的价值转化为道具返给玩家
function Partner:PeelPartner(pPartner)
	if not pPartner or pPartner.GetValue(self.emKPARTNERATTRIBTYPE_LEVEL) < 120 then
		return 0;
	end
	
	local nStarLevel = self:GetSelfStartCount(pPartner);
	
	-- 转化道具（同伴精华液）
	local tbRetItem = self:CalPeelRetItem(pPartner);
	local nItemCount = Lib:CountTB(tbRetItem);
	if me.CountFreeBagCell() < nItemCount then
		me.Msg("Hành trang đã đầy, vui lòng thử lại");
		self:SendClientMsg("Hành trang đã đầy, vui lòng thử lại");
		return 0;
	end
	
	-- 返还道具LOG的格式："返还情况，{道具名，应加个数，实加个数}， {道具名，应加个数，实加个数}。。"
	local szLog = "";
	for nLevel, nCount in pairs(tbRetItem) do
		if szLog == "" then
			 szLog = string.format("Sự trở lại của: ", pPartner.szName);
		end
		local nAddCount = me.AddStackItem(self.tbPartnerJinghua.nGenre, self.tbPartnerJinghua.nDetail, 
			self.tbPartnerJinghua.nParticular, nLevel, nil, nCount);
			
		-- 记录返还道具的返还情况		
		szLog = szLog..string.format("{%d cấp %d %d}；", nLevel, nCount, nAddCount);
	end
	if szLog == "" then
		szLog = "Không được trả lại";
	end
	
	-- 将同伴的属性降到1级时的属性
	pPartner.SetValue(self.emKPARTNERATTRIBTYPE_EXP, 0);	-- 经验
	pPartner.SetValue(self.emKPARTNERATTRIBTYPE_LEVEL, 1);	-- 等级
	pPartner.SetValue(self.emKPARTNERATTRIBTYPE_FRIENDSHIP, self.FRIENDSHIP_INIT);	--亲密度
	pPartner.SetValue(self.emKPARTNERATTRIBTYPE_TALENT, self.TAlENT_MIN);	-- 领悟度
	pPartner.SetValue(self.emKPARTNERATTRIBTYPE_PotentialPoint, 0);			-- 剩余潜能点数重置	
	pPartner.SetValue(self.emKPARTNERATTRIBTYPE_DECRFSLASTTIME, 0);
	pPartner.SetValue(self.emKPARTNERATTRIBTYPE_DECRFSTODAY, 0);
	pPartner.SetValue(self.emKPARTNERATTRIBTYPE_SKILLBOOK, 0);
	
	self:CaclulatePotential(pPartner.nPartnerIndex);	-- 重新开始随机潜能
	
	-- 所有技能等级都变为1级
	for i = 1, pPartner.nSkillCount do
		local tbSkill = pPartner.GetSkill(i - 1);
		tbSkill.nLevel = 1;
		pPartner.SetSkill(i - 1, tbSkill);
	end
	
	me.Msg(string.format("Mức độ thân mật, cấp độ và kỹ năng của đồng hành %s đã trở thành 1.", pPartner.szName));
	self:SendClientMsg(string.format("Mức độ thân mật, cấp độ và kỹ năng của đồng hành %s đã trở thành 1.", pPartner.szName));
	
	if nStarLevel >= self.PEELLIMITSTARLEVEL * 2 then		-- 6.5星以上的做任务变量重置
		me.SetTask(self.TASK_PEEL_PARTNER_GROUPID, self.TASK_PEEL_PARTNER_SUBID, 0);
		me.RemoveSkillState(self.PEELDEBUFF_SKILLID);
	end
	
	return 1, szLog;
end

-- 计算剥离同伴时，同伴清华液的返回表
function Partner:CalPeelRetItem(pPartner)
	local nValue = self:GetPeelValue(pPartner);	
	
	local tbLevel = {4, 3, 2, 1};
	local tbRet = {};
	for _, nLevel in pairs(tbLevel) do
		if nValue <= 0 then
			break;
		end
		
		local szIndex = string.format("%s_%s_%s_%s", self.tbPartnerJinghua.nGenre, self.tbPartnerJinghua.nDetail,
			self.tbPartnerJinghua.nParticular, nLevel);
		local nItemValue = self.tbItemTalentValue[szIndex].nBindValue;	-- 返还的同伴精华液始终绑定
		local nCount = math.floor(nValue / nItemValue);
		if nCount > 0 then
			tbRet[nLevel] = nCount;
			nValue = nValue - nCount * nItemValue;
		end
	end
	
	return tbRet;
end

-- 计算返还价值量
function Partner:GetPeelValue(pPartner)
	if not pPartner then
		return 0;
	end
	
	local nValue = 0;
	--local nRate = self:GetRate(pPartner);
	local nRate = self:GetPeelRate(pPartner);	-- 剥离时要去掉同伴秘笈所增加的同伴财富
	local nRateLower = math.max(40, nRate - 10);
	
	-- 计算领悟度价值量需要的最大等级数
	local nSkillCount = pPartner.nSkillCount;
	local nNeedLevelMax = self.tbFsTalRate[nSkillCount][1];
	
	-- 计算领悟度价值量时的比率
	local nTempId = self.tbPartIdToNpcId[pPartner.GetValue(self.emKPARTNERATTRIBTYPE_TEMPID)];
	local nPartnerType = self.tbPartnerAttrib[nTempId].nType;
	local nTalentRate = self.tbSkillRule[nPartnerType].nCalRate;
	
	-- 将技能升级概率（即领悟度）维持在平均水平后，升技能成功一次的消耗
	for i = nRateLower, nRate - 1 do
		local nCalLevel = math.min(i, nNeedLevelMax);
		nValue = nValue + self.tbTalentLevel[nCalLevel] * nTalentRate;
	end
	
	-- 在将技能升级概率维护在平均水平前的消耗需要（只有一次）
	local nPreValue = 0;
	for j = 40, nRateLower - 1 do
		local nCalLevel = math.min(j, nNeedLevelMax);
		nPreValue = nPreValue + self.tbTalentLevel[nCalLevel] * nTalentRate;
	end

	local nSkillUpTimes = math.floor(pPartner.GetValue(self.emKPARTNERATTRIBTYPE_LEVEL)/5);
	nValue = nValue * nRate/100 * nSkillUpTimes * self.PEEL_VALUERATE + nPreValue;
	
	local nBookValue = self:GetPartnerSkillBookValue(pPartner);
	return nValue + nBookValue;
end

-- 注意：这与GetRate()接口不同，前者不需要去除同伴秘笈所增加的点数对概率的影响，主要是在计算财富的时候用，
-- 而GetPeelRate()需要去队同伴秘笈所增加的点数对概率的影响，主要是计算剥离财富用
function Partner:GetPeelRate(pPartner)
	if pPartner == nil then
		assert(false);
		return;
	end
	-- 当前技能点数
	local nSkillPoint = 0;
	for i = 0, pPartner.nSkillCount - 1 do
		local tbSkill = pPartner.GetSkill(i);
		nSkillPoint = nSkillPoint + tbSkill.nLevel - 1;
	end
	
	-- 这里算技能升级概率时应当送去吃技能书所得到的技能点数
	local nBookSkillPoint = 0;
	local nBookValue = pPartner.GetValue(self.emKPARTNERATTRIBTYPE_SKILLBOOK);
	while nBookValue > 0 do
		nBookSkillPoint = nBookSkillPoint + nBookValue%10;
		nBookValue = math.floor(nBookValue/10);
	end
	
	nSkillPoint = nSkillPoint - nBookSkillPoint;
	local nSkillChannce = math.floor(pPartner.GetValue(self.emKPARTNERATTRIBTYPE_LEVEL) / 5);

	-- 该同伴的实际技能升级概率
	local nSkillUpRate = 0;
	if nSkillChannce ~= 0 then
		nSkillUpRate =  math.floor(nSkillPoint * 100 / nSkillChannce);
	end
	-- 该同伴计算时采用的最大概率
	if not self.tbFsTalRate[pPartner.nSkillCount] then
		return 0;
	end
	
	local nMaxRate = self.tbFsTalRate[pPartner.nSkillCount][2] or 100;
	return math.min(nMaxRate, nSkillUpRate);
end	