if MODULE_GAMESERVER then

function Partner:Init(pPartner, nPartnerTempId, nType, szName, nPotentialTemp, varSkillOrSeries)
	pPartner.SetName(szName);		-- 同伴名字，初始时为NPC的名字
	pPartner.SetValue(self.emKPARTNERATTRIBTYPE_TEMPID, nPartnerTempId);	 		 -- 同伴的模板ID	
	pPartner.SetValue(self.emKPARTNERATTRIBTYPE_EXP, 0);							 -- 经验初始为0
	pPartner.SetValue(self.emKPARTNERATTRIBTYPE_LEVEL, 1);							 -- 等级初始为1	
	pPartner.SetValue(self.emKPARTNERATTRIBTYPE_FRIENDSHIP, self.FRIENDSHIP_INIT);	 -- 亲密度初始为60
	pPartner.SetValue(self.emKPARTNERATTRIBTYPE_TALENT, self.TAlENT_MIN);	  		 -- 领悟度初始为40
	pPartner.SetValue(self.emKPARTNERATTRIBTYPE_PotentialTemp, nPotentialTemp);		 -- 潜能模板
	pPartner.SetValue(self.emKPARTNERATTRIBTYPE_CREATETIME, GetTime());				 -- 创建时间
	
	self:CaclulatePotential(pPartner.nPartnerIndex);
	
	if type(varSkillOrSeries) == "number" then
		local nSeries = varSkillOrSeries;
		self:GenerateSkill(pPartner, nType, nSeries);		  						 -- 生成技能
	else
		local tbSkillId = varSkillOrSeries;
		for nIndex, nSkillId in pairs(tbSkillId) do								 -- 直接添加技能
			local tbSkill = {};
			tbSkill.nId = nSkillId;
			tbSkill.nLevel = 1;
			
			pPartner.AddSkill(tbSkill);
		end
	end
end

function Partner:PreUpgrade(pPartner)	
	local nExp = pPartner.GetValue(self.emKPARTNERATTRIBTYPE_EXP);			-- 累计经验
	local nCurLevel = pPartner.GetValue(self.emKPARTNERATTRIBTYPE_LEVEL);	-- 当前等级

	if nCurLevel >= self.MAXLEVEL then
		local szMsg = "Đồng hành đã đạt cấp cao nhất, không thể thăng cấp nữa.";
		return 0, szMsg;
	end	
	
	if nExp < self.tbLevelSetting[nCurLevel].nExp then
		return 0, "Không đủ kinh nghiệm, chưa thể thăng cấp!";	
	end
	
	return 1;	
end

function Partner:UpgradeSkill(pPartner)
	local nRes, varRes, nResultId = self:CalToUpgradeSkill(pPartner);
	local szResult;
	if nRes == 0 then
		if nResultId == 1 then
			szResult = ", tất cả kỹ năng đã đạt tối đa";
		elseif nResultId == 2 then
			szResult = "Thất bại";
		end
	else
		szResult = "Thành công";
	end
	local szLog = string.format("Log đồng hành: Đồng hành của %s - %s với %d lĩnh ngộ nâng kỹ năng %s",me.szName, pPartner.szName, pPartner.GetValue(self.emKPARTNERATTRIBTYPE_TALENT) % 1000, szResult);
	Dbg:WriteLog(szLog);
	
	if nRes == 0 then
		me.Msg(varRes);
		self:SendClientMsg(varRes);
		return;
	end
	
	local nSkillIndex = varRes;		--如果可以提升技能，第二个参数是要提升的技能索引	
	local tbSkill = pPartner.GetSkill(nSkillIndex - 1);		-- 在程序中索引是从0开始的，要减1
	
	if not tbSkill then
		return;
	end
	
	if tbSkill.nLevel >= self.SKILLMAXLEVEL then
		return;
	end
	
	tbSkill.nLevel = tbSkill.nLevel + 1;
	local nNewTalentLevel, nPointRemain = self:GetTalentLevelAdded(pPartner, -self.TALENT_DECREASE, 0);
	local _, szMsg = self:AddTalent(pPartner, nNewTalentLevel, nPointRemain);		-- 提升技能成功，扣除10点的领悟度
	if szMsg ~= "" then
		me.Msg(szMsg);
		self:SendClientMsg(szMsg);
	end
	
	pPartner.SetSkill(nSkillIndex - 1, tbSkill); 	-- 在程序中索引是从0开始的，要减1
	
	me.Msg(string.format("Chúc mừng, đồng hành của bạn - %s đã nâng cấp kỹ năng [%s] đến %d!", pPartner.szName, KFightSkill.GetSkillName(tbSkill.nId), tbSkill.nLevel));
	self:SendClientMsg(string.format("Kỹ năng [%s] tăng đến cấp %d!", KFightSkill.GetSkillName(tbSkill.nId), tbSkill.nLevel));
	
	local tbPlayerTasks	= Task:GetPlayerTask(me).tbTasks;
	local tbTask = tbPlayerTasks[tonumber(self.TASK_SKILLUP_MAIN, 16)];	-- 主任务ID
	if tbTask and tbTask.nReferId == tonumber(self.TASK_SKILLUP_SUB, 16) then
		me.SetTask(self.TASKID_MAIN, self.TASKID_SKILLUP, 1);
	end
end

function Partner:CalToUpgradeSkill(pPartner)
	local nTalent = pPartner.GetValue(self.emKPARTNERATTRIBTYPE_TALENT);	-- 同伴当前的领悟度
	local nTalentLevel = nTalent % 1000;
	
	local tbSkillIndex = {};
	local nSkillCount = pPartner.nSkillCount;	-- 当前同伴拥有的技能总数
	for i = 1, nSkillCount do
		local tbSkill = pPartner.GetSkill(i - 1);	-- 在程序中的索引是从0开始的，要减1
		if tbSkill.nLevel < self.SKILLMAXLEVEL then
			table.insert(tbSkillIndex, i);
		end
	end
	
	if #tbSkillIndex == 0 then
		local szMsg = string.format("Đồng hành của bạn - %s đã nâng tất cả kỹ năng đến mức tối đa, không thể nâng nữa!", pPartner.szName);
		return 0, szMsg, 1;
	end
	
	if MathRandom(1, 100) > nTalentLevel then
		local szMsg = "Thật tiếc, đồng hành không nâng cấp kỹ năng được, hãy tăng thêm 5 cấp rồi thử lại.";
		return 0, szMsg, 2;
	end
	
	local nGenIndex = MathRandom(1, #tbSkillIndex);
	return 1, tbSkillIndex[nGenIndex], 0;
end

function Partner:CanUpgradeSkill(pPartner)
	if not pPartner then
		return 0;
	end
	
	for i = 1, pPartner.nSkillCount do
		local tbSkill = pPartner.GetSkill(i - 1);
		if tbSkill.nLevel < self.SKILLMAXLEVEL then
			return 1;
		end
	end
	
	return 0;
end

function Partner:AddExp(pPartner, nExp)
	local nCurLevel = pPartner.GetValue(self.emKPARTNERATTRIBTYPE_LEVEL);	-- 当前等级
	
	if nCurLevel >= self.MAXLEVEL then
		local szMsg = string.format("Đồng hành của bạn đã đạt cấp tối đa, không thể nhận kinh nghiệm nữa!");
		return 0, szMsg;
	end
	
	local nStoreMax = self:GetMaxStoreExp(pPartner);		-- 计算当前能累积的最大经验值
	local nCurExp = pPartner.GetValue(self.emKPARTNERATTRIBTYPE_EXP);
	if nCurExp >= nStoreMax then
		local szMsg = string.format("Đồng hành của bạn - %s đã đạt kinh nghiệm tối đa, để tránh rớt kinh nghiệm, hãy nâng cấp cho đồng hành!", pPartner.szName);
		return 0, szMsg;
	end

	local nActualExp = nCurExp + nExp;
	if nActualExp >= nStoreMax then
		nActualExp = nStoreMax;
	end
	
	if nActualExp >= nStoreMax and nCurLevel < self.MAXLEVEL - 9 then
			me.CallClientScript({"PopoTip:ShowPopo", 23});
	elseif nCurExp < Partner.tbLevelSetting[nCurLevel].nExp and 
		nActualExp >= Partner.tbLevelSetting[nCurLevel].nExp and
		nCurLevel < self.MAXLEVEL then
			me.CallClientScript({"PopoTip:ShowPopo", 21});
	end
		
	pPartner.SetValue(self.emKPARTNERATTRIBTYPE_EXP, nActualExp);
	return 1, nActualExp - nCurExp;		-- 增加经验成功，返回1和实际增加的经验
end


function Partner:AddTalent(pPartner, nNewLevel, nPointRemain)
	local nTalent = pPartner.GetValue(self.emKPARTNERATTRIBTYPE_TALENT);	-- 当前领悟度
	local nTalentLevel = nTalent % 1000;	-- nCurTalent = nTalentLevel*1000 + nTalentPoint
	
	local szMsg = "";
	if nTalentLevel >= self.TALENT_MAX and nNewLevel >= nTalentLevel then
		szMsg = string.format("Đồng hành của bạn - %s đã thông suốt, không cần nâng lĩnh ngộ nữa!", pPartner.szName);
		return 0, szMsg;
	end
			
	if nNewLevel < nTalentLevel then  	-- 领悟度降低了
		if nNewLevel <= self.TAlENT_MIN then
			szMsg = string.format("Đồng hành của bạn - %s tổn hao tâm trí, lĩnh ngộ giảm %d! Đã giảm đến mức thấp nhất.", pPartner.szName,  nTalentLevel - nNewLevel);
		else
			szMsg = string.format("Đồng hành của bạn - %s tổn hao tâm trí, lĩnh ngộ giảm %d!", pPartner.szName,  self.TALENT_DECREASE);
		end
		
	elseif nNewLevel > nTalentLevel then		-- 领悟度提高了
		szMsg = string.format("Đồng hành của bạn - %s lĩnh ngộ tăng đến %d.", pPartner.szName, nNewLevel);
	end		
	
	if nNewLevel >= self.TALENT_MAX then
		nPointRemain = 0;
	end
	
	local nNewTalent = nNewLevel + nPointRemain * 1000;
	pPartner.SetValue(self.emKPARTNERATTRIBTYPE_TALENT, nNewTalent);
	
	return 1, szMsg;
end

function Partner:AddFriendship(pPartner, nAddFriendship)
	local nFriendship = pPartner.GetValue(self.emKPARTNERATTRIBTYPE_FRIENDSHIP);	-- 当前亲密度
	
	if nFriendship >= self.FRIENDSHIP_MAX and nAddFriendship > 0 then
		local szMsg = string.format("Độ thân mật của bạn và đồng hành đã đạt tối đa, không phải nâng điểm thân mật nữa.", pPartner.szName);
		return 0, szMsg;
	end
	
	local nNewFriendship = nFriendship + nAddFriendship;
	
	nNewFriendship = math.max(nNewFriendship, 0);	-- 最小为0
	
	nNewFriendship = math.min(nNewFriendship, self.FRIENDSHIP_MAX);	-- 最大为10000
	
	local szMsg = "";
	if nAddFriendship > 0 then
		szMsg = string.format("Độ thân mật của bạn và đồng hành - %s tăng %0.2f.", pPartner.szName, nNewFriendship/100);
	end
	
	pPartner.SetValue(self.emKPARTNERATTRIBTYPE_FRIENDSHIP, nNewFriendship);
	
	return 1, szMsg;
end

function Partner:OnKillBoss(pPlayer, pNpc)
	if not pPlayer or not pNpc then
		return;
	end
	
	if not self.tbLevelSetting then
		return;
	end
	
	local tbShareMember = {pPlayer};	-- 可以分享经验的玩家列表
	
	local tbPlayerId = KTeam.GetTeamMemberList(pPlayer.nTeamId);
	if tbPlayerId then
		local nNpcMapId, nNpcX, nNpcY = pNpc.GetWorldPos();
		for _, nPlayerId in pairs(tbPlayerId) do
			local pTeamMember = KPlayer.GetPlayerObjById(nPlayerId);
			if pTeamMember and pTeamMember.nId ~= pPlayer.nId then
				local nPlayerMapId, nPlayerPosX, nPlayerPosY = pTeamMember.GetWorldPos();
				local nDisSquare = math.floor(math.sqrt((nNpcX - nPlayerPosX)^2 + (nNpcY - nPlayerPosY)^2) * 32);
				if (nDisSquare < self.SHAREEXPDISTANCE) then		-- 在可分享经验范围内才可以分享经验
					table.insert(tbShareMember, pTeamMember);		-- 分享经验的玩家个数加1
				end
			end
		end
	end
	
	self:GetAwardByKillBoss(tbShareMember, pNpc.nLevel, pNpc.GetNpcType());	
end

function Partner:GetAwardByKillBoss(tbPlayer, nNpcLevel, nNpcType)
	local szExpType = nNpcType == 1 and "nJYExp" or "nSLExp";	
	
	for _, pPlayer in pairs(tbPlayer) do
		local bAdd = 1;		-- 标识是否可以给该玩家加经验，大于1的时候表示可以，否则表示不可以
		local pPartner = pPlayer.GetPartner(pPlayer.nActivePartner);
		if pPartner then
			
			local nLevel = pPartner.GetValue(self.emKPARTNERATTRIBTYPE_LEVEL);	-- 同伴等级
			if math.abs(nLevel - nNpcLevel) > 15 then
				bAdd = 0;
			end
			
			if bAdd ~= 0 then
				local nEarnRate = 100;	-- 获得经验、亲密度的比例, 100为满值
				
				if not self.tbNpcExp[nNpcLevel] then
					break;
				end
				
				local nExp = self.tbNpcExp[nNpcLevel][szExpType] * nEarnRate / 100;	
				
				local nRes, szMsg = self:AddExp(pPartner, nExp);
				if nRes == 1 then
					local nExpAdded = szMsg;	-- 如果nRes=1,则第二个参数为加上去的经验
					szMsg = string.format("Kinh nghiệm của đồng hành %s tăng %d", pPartner.szName, nExpAdded);
				end
			
				pPlayer.Msg(szMsg);
			end
		end
	end
end

function Partner:TryToPersuade(pPlayer, pNpc, nItemLevel)
	if not self.tbPartnerAttrib then
		return 0, "Sử dụng đạo cụ thất bại!";
	end
	
	if pPlayer.nFaction == 0 then
		return 0, "Chưa gia nhập môn phái không thể thuyết phục đồng hành!";
	end
	
	if pPlayer.nLevel < self.PERSUADELEVELLIMIT then		-- 100级以后才可以说服同伴
		return 0, "Sau khi trở thành đại hiệp trên cấp 100 mới có thể đi tìm đồng hành!";
	end
		
	if not self.tbPartnerAttrib[pNpc.nTemplateId] then
		return 0, "Tên này trông rất hung dữ, tốt nhất nên tránh xa. Hãy thử với những tên có biểu tượng hình tim xem sao.";
	end
	
	local nType = self.tbPartnerAttrib[pNpc.nTemplateId].nType;
	if pPlayer.nLevel < self.tbSkillRule[nType].nLevelRequire then
		return 0, string.format("Phải đạt cấp %d mới có thể thuyết phục loại NPC này!", self.tbSkillRule[nType].nLevelRequire);
	end
	
	if not self.tbPartnerAttrib[pNpc.nTemplateId] then
		self:SendClientMsg("Tên này trông rất hung dữ, tốt nhất nên tránh xa. Hãy thử với những tên có biểu tượng hình tim xem sao.");
		return 0, "Tên này trông rất hung dữ, tốt nhất nên tránh xa. Hãy thử với những tên có biểu tượng hình tim xem sao.";
	end
	
	if nItemLevel ~= self.tbPartnerAttrib[pNpc.nTemplateId].nTypeLevel then
		return 0, "Thứ này sao có thể thuyết phục được, hãy mau đem loại thiệp thích hợp đến đây.";
	end
	
	local nLifeRate = math.ceil(pNpc.nCurLife/pNpc.nMaxLife * 100);
	if nLifeRate > self.tbPartnerAttrib[pNpc.nTemplateId].nLifeRatio then
		return 0, string.format("Tên này rất ngoan cố, chỉ khi máu ít hơn %d, mới khiến hắn khuất phục được!", 
			self.tbPartnerAttrib[pNpc.nTemplateId].nLifeRatio);
	end
	
	local nPlayerMapId, nPlayerPosX, nPlayerPosY = pPlayer.GetWorldPos();
	local nNpcMapId, nNpcPosX, nNpcPosY	= pNpc.GetWorldPos();
	if nPlayerMapId ~= nNpcMapId then
		Dbg:WriteLog("Partner", 
			string.format("%s đang thử thuyết phục NPC khác bản đồ làm đồng hành!", pPlayer.szName));
		return 0, "Sử dụng đạo cụ thất bại!";
	end
	local nDistance = math.ceil(math.sqrt((nPlayerPosX - nNpcPosX) ^ 2 + (nPlayerPosY - nNpcPosY) ^ 2) * 32);
	if nDistance > self.MAXPERSUADEDISTANCE then
		return 0, "Đối tượng nghe không rõ bạn nói, hãy tới gần hơn.";
	end
		
	if pPlayer.nPartnerLimit == 0 then
		pPlayer.SetPartnerLimit(self.PARTNERLIMIT_MIN);
	end	
	if pPlayer.nPartnerCount >= pPlayer.nPartnerLimit then
		local szMsg = string.format("Bạn đã có nhiều đồng hành rồi, đừng tham lam quá.");
		return 0, szMsg;
	end
end


function Partner:CreatePartner(nPlayerId, dwNpcId, nItemId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId)
	local pItem = KItem.GetObjById(nItemId)
	if not pPlayer or not pItem then
		return 0;
	end
	pPlayer.RemoveSkillState(self.nPersuadeSkillId);
	pPlayer.GetTempTable("Partner").nPersuadeRefCount = 0;
	
	local pNpc = KNpc.GetById(dwNpcId);
	if not pNpc or pNpc.IsDead() == 1 then
		return 0;
	end
	
	if not self.tbPartnerAttrib then
		return 0;
	end
	
	if self:ConsumePartnerItem(pItem, pPlayer) ~= 1 then
		Dbg:WriteLog("Partner", "Partner:CreatePartner DeleteItem Failed!")
		return 0;
	end
	
	local nRate = self.tbPartnerAttrib[pNpc.nTemplateId].nRate;		-- 该NPC能被说服的概率
	if MathRandom(1, 100) > nRate then
		if pNpc.GetTempTable("Partner").nPersuadeRefCount <= 1 then		-- 去掉被说服状态
			pNpc.RemoveTaskState(self.nBePersuadeSkillId);
		end		
		pNpc.GetTempTable("Partner").nPersuadeRefCount = pNpc.GetTempTable("Partner").nPersuadeRefCount - 1;

		pPlayer.Msg("Thật đáng tiếc, dù bạn đã sử dụng thiệp nhưng thuyết phục thất bại!");
		return 0;	-- 说服失败直接返回，不删除NPC
	end

	local nRes = self:AddPartner(pPlayer.nId, pNpc.nTemplateId, pNpc.nSeries);
	if nRes == 0 then
		return;
	end
	
	Dbg:WriteLog("Log đồng hành: ", pPlayer.szName, "Dùng ", pItem.szName, "Nhận được đồng hành: ", pNpc.szName);
		
	pNpc.RemoveTaskState(self.nBePersuadeSkillId);			-- 去掉被说服状态
	pNpc.GetTempTable("Partner").nPersuadeRefCount = 0;
	if self.tbPartnerAttrib[pNpc.nTemplateId].IsDrop == 0 then
		pNpc.DieWithoutPunish();				-- 删除NPC，不掉落不给经验
	else
		pNpc.DieWithoutPunish();				-- TODO:需要加掉落。
	end
	pPlayer.Msg("Chúc mừng! Bạn có thể cùng đồng hành xông pha giang hồ rồi!");
	pPlayer.CallClientScript({"PopoTip:ShowPopo", 22});
	
	local tbPlayerTasks	= Task:GetPlayerTask(pPlayer).tbTasks;
	local tbTask = tbPlayerTasks[tonumber(self.TASK_FINDPARTNER_MAIN, 16)];	-- 主任务ID
	if tbTask and tbTask.nReferId == tonumber(self.TASK_FINDPARTNER_SUB, 16) then
		pPlayer.SetTask(self.TASKID_MAIN, self.TASKID_FINDPARTNER, 1);
	end
	
	return 1;
end

function Partner:ConsumePartnerItem(pItem, pPlayer)
	local nCount = pItem.nCount - 1;
	if nCount == 0 then
		return pPlayer.DelItem(pItem);	-- 直接删除不用手动添加消耗记录
	else
		local pOwnner = pItem.GetOwner()
		if not pOwnner or pOwnner.nId ~= pPlayer.nId then
			return 0;
		end
		pItem.SetCount(nCount);
		
		local nIndex = Spreader:CalBitByGDPL(pItem.nGenre, pItem.nDetail, pItem.nParticular, pItem.nLevel);
		local nConsumeValue = 0;
		local szType = "";
		if pItem.IsIbItem() == 1 then
			nConsumeValue = pItem.nBuyPrice * 1 * Spreader.tbIbItem[nIndex]/100;
			szType = "Ib vật phẩm";
		else
			if Spreader.tbNonIbItem[nIndex] and pItem.IsBind() <= Spreader.tbNonIbItem[nIndex].bCanBind then
				nConsumeValue = Spreader.tbNonIbItem[nIndex].nBuyPrice;
				szType = "Không phải IB vật phẩm";
			end
		end
		
		if nConsumeValue > 0 then
			Spreader:AddConsume(nConsumeValue);
			Dbg:WriteLog("Spreader:OnItemConsumed",
				"Sứ giả log tiêu hao: ",
				Spreader:ExtractZoneGroup(),
				pPlayer.szAccount,
				string.format("[%s] dùng %s [%s] 1 cái, log tiêu hao tăng [%s]", pPlayer.szName,
					szType, pItem.szName, tostring(nConsumeValue))
			);
		end
		return 1;
	end
	return 0;	
end

function Partner:AddPartner(nPlayerId, nTemplateId, nSeries, nPotentialTemp)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return 0;
	end
	
	if not self.tbPartnerAttrib[nTemplateId] then
		return 0;
	end	

	local nPartnerTempId = self.tbPartnerAttrib[nTemplateId].nId;	-- 同伴的模板ID，存盘用	

	if pPlayer.nPartnerLimit == 0 then
		pPlayer.SetPartnerLimit(self.PARTNERLIMIT_MIN);
	end	
	local pPartner = pPlayer.AddPartner(nPartnerTempId);
	if not pPartner then
		return 0;
	end
	
	if not nPotentialTemp then
		 nPotentialTemp = self:RandomPotentialTemp(pPlayer);
	end
	
	local nType = self.tbPartnerAttrib[nTemplateId].nType;
	if not nType then
		return 0;
	end
	
	local szName = KNpc.GetNameByTemplateId(nTemplateId);
	if not nSeries or nSeries == 0 then
		nSeries = MathRandom(1, 5);
	end
	self:Init(pPartner, nPartnerTempId, nType, szName, nPotentialTemp, nSeries);		-- 初始化同伴的基本属性信息
	
	return 1;
end

function Partner:ResetPartnerPotential(pPartner, nPotentialTemp)
	if not pPartner then
		return 0;
	end
	
	if nPotentialTemp < 1 or nPotentialTemp > #self.tbPotentialTemp then
		return 0;		-- 给定的潜能模板ID不合法，直接RETURN
	end
	
	pPartner.SetValue(self.emKPARTNERATTRIBTYPE_PotentialTemp, nPotentialTemp);
	
	local nSumPotential = 0;
	for nAttribIndex = 0, 3 do
		nSumPotential = nSumPotential + pPartner.GetAttrib(nAttribIndex);
		pPartner.SetAttrib(nAttribIndex, 0);
	end
	
	self:AddPotential_Pure(pPartner.nPartnerIndex, nSumPotential);
	
	return nPotentialTemp;
end

function Partner:TurnPartnerToItem(pPlayer, pPartner)
	if not pPartner then
		return 0;
	end
	
	if pPartner.GetValue(self.emKPARTNERATTRIBTYPE_LEVEL) > 1 then
		self:SendClientMsg("Chỉ có đồng hành cấp 1 mới có thể chuyển hóa thành đạo cụ!");
		pPlayer.Msg("Chỉ có đồng hành cấp 1 mới có thể chuyển hóa thành đạo cụ!");
		return 0;
	end
		
	if pPlayer.CountFreeBagCell() < 1 then
		self:SendClientMsg("Túi bạn không đủ trống, xin thu xếp lại!");
		pPlayer.Msg("Túi bạn không đủ trống, xin thu xếp lại!");
		return 0;
	end
	
	local nRes, pItem = self:SavePartnerInfoToGenInfo(pPlayer, pPartner);
	if nRes == 0 then
		return 0;
	end
	
	self:DissolveConfirm(pPlayer.nId, pPartner.nPartnerIndex, 1);
	
	return 1, pItem;
end

function Partner:SavePartnerInfoToGenInfo(pPlayer, pPartner)	
	if not pPartner then
		return 0;
	end
	
	local nPartnerTempId = pPartner.GetValue(self.emKPARTNERATTRIBTYPE_TEMPID);		-- 模板ID
	local nPotentialTemp = pPartner.GetValue(self.emKPARTNERATTRIBTYPE_PotentialTemp);  -- 潜能分配模板
	
	local tbSkillGenInfo = {};			-- 把同伴的技能信息记录到道具的扩展参数中
	for i = 1, pPartner.nSkillCount do
		local tbSkill = pPartner.GetSkill(i - 1);
		if tbSkill then
			tbSkillGenInfo[math.ceil(i/2)] = tbSkillGenInfo[math.ceil(i/2)] or 0;
			local nBitBegin = (i % 2) == 0 and 16 or 0; 
			tbSkillGenInfo[math.ceil(i/2)] = Lib:SetBits(tbSkillGenInfo[math.ceil(i/2)], tbSkill.nId, nBitBegin, nBitBegin + 15);
		end
	end
		
	local pItem = pPlayer.AddItem(self.tbChildPartner.nGenre, self.tbChildPartner.nDetail, 
		self.tbChildPartner.nParticular, pPartner.nSkillCount - 1);
	if not pItem then
		return 0;
	end
	
	pItem.SetGenInfo(1, nPartnerTempId);
	pItem.SetGenInfo(2, nPotentialTemp);
	for i = 1, #tbSkillGenInfo do
		pItem.SetGenInfo(i + 2, tbSkillGenInfo[i]);
	end	
	pItem.Sync();	-- 同步到客户端
	
	return 1, pItem;
end

function Partner:TurnItemToPartner(pPlayer, nPartnerTempId, nPotentialTemp, tbSkillId)
	if not pPlayer or not nPartnerTempId or not nPotentialTemp or not tbSkillId then
		return 0;
	end
	
	if pPlayer.nPartnerCount >= pPlayer.nPartnerLimit then
		pPlayer.Msg("Danh sách đồng hành của bạn đã đầy, không thể nhận thêm đồng hành mới!");
		self:SendClientMsg("Danh sách đồng hành của bạn đã đầy, không thể nhận thêm đồng hành mới!");
		return 0;
	end
	
	local pPartner = pPlayer.AddPartner(nPartnerTempId);
	if not pPartner then
		return 0;
	end
	
	local nNpcTempId = self.tbPartIdToNpcId[nPartnerTempId]; 
	local nType = self.tbPartnerAttrib[nNpcTempId].nType;
	local szName = KNpc.GetNameByTemplateId(nNpcTempId);
	
	self:Init(pPartner, nPartnerTempId, nType, szName, nPotentialTemp, tbSkillId);
	local szMsg = string.format("Bạn đã nhận đồng hành %s", szName);
	pPlayer.Msg(szMsg);
	self:SendClientMsg(szMsg);
	
	return 1;
end

function Partner:RandomPotentialTemp(pPlayer)
	local nRateSum = 0;		-- 统计配置表中的权重总和
	for _, tbData in pairs(self.tbPotentialTemp) do
		nRateSum = nRateSum + tbData.nRate or 0;
	end
	
	if nRateSum == 0 then
		return MathRandom(1, #self.tbPotentialTemp);
	end
	
	local nRandom = MathRandom(1, nRateSum);
	for nPotentialTempId, tbData in pairs(self.tbPotentialTemp) do
		nRandom = nRandom - tbData.nRate;
		if nRandom <= 0 then
			return nPotentialTempId;
		end
	end
	
	if nRandom > 0 then
		Dbg:WriteLog("Log đồng hành: ", pPlayer.szName, 
			string.format("Dạng tiềm năng ngẫu nhiên vượt mức! Tỷ trọng trung bình là %d, trị ngẫu nhiên %d", nRateSum, nRandom + nRateSum));
				
		return MathRandom(1, #self.tbPotentialTemp);
	end
end

function Partner:GenerateSkill(pPartner, nType, nSeries)
	if not self.tbSkillRule then
		return;
	end
	
	if not self.tbSkillSetting then 
		return;
	end
	
	if not self.tbSeries[nSeries] and self.tbSeries[#self.tbSeries] ~= nSeries then
		return;
	end

	local tbSkillCountRate = self.tbSkillRule[nType];
	if not tbSkillCountRate then
		return;		-- 给定同伴类型没有对应的配置
	end

	local nCountAll = self:RandomSkillCount(tbSkillCountRate, nType);	
	
	local tbBichuSkill = self:GenBichuSkill(tbSkillCountRate, nCountAll, nSeries);
	
	local tbRandomSkill = {};
	if #tbBichuSkill < nCountAll then
		if not tbSkillCountRate.nRandomSkillTemplateId or tbSkillCountRate.nRandomSkillTemplateId == 0 then
			print(string.format("skillrule.txt, [Type = %d] Hàng hiện tại không có mẫu ID kỹ năng ngẫu nhiên!", nType));
		else
			local nRandomCount = nCountAll - #tbBichuSkill;
			tbRandomSkill = self:GenRandomSkill(tbSkillCountRate.nRandomSkillTemplateId, nSeries, nRandomCount);
		end
	end
	
	local tbSkillAll = {};
	Lib:MergeTable(tbSkillAll, tbBichuSkill);
	Lib:MergeTable(tbSkillAll, tbRandomSkill);
		
	for _, nAddSkillId in pairs(tbSkillAll) do
		local tbAddSkill = {};
		tbAddSkill.nId = nAddSkillId;
		tbAddSkill.nLevel = 1;		-- 初始时所有技能都是1级
		pPartner.AddSkill(tbAddSkill);		
	end
	
end

function Partner:ApplySkill(nPlayerId, nPartnerIndex, nApply)
	local nApply = nApply or 0;
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return;
	end

	local pPartner = pPlayer.GetPartner(nPartnerIndex);
	if not pPartner then
		return;
	end
	
	for i = 0, pPartner.nSkillCount - 1 do
		local tbSkill = pPartner.GetSkill(i);
		if nApply == 0 then
			pPlayer.AddSkillState(tbSkill.nId, tbSkill.nLevel, 0, 6 * 60 * Env.GAME_FPS);	-- 技能状态不存档,始终有效
		else
			pPlayer.RemoveSkillState(tbSkill.nId);
		end
	end
end

function Partner:OnCallPartner(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return;
	end
	
	if Partner.bClosePartnerTimer then	
		self:UnRegisterPartnerTimer(pPlayer);
		return;
	end
	
	local pPartner = pPlayer.GetPartner(pPlayer.nActivePartner);
	if not pPartner then
		self:UnRegisterPartnerTimer(pPlayer);
		return;
	end
		
	if pPlayer.nFightState == 0 then
		return;
	end
	
	if pPlayer.IsDead() == 1 then
		return;
	end
	
	self:DecreaseFriendship(nPlayerId);
	
	local tbPlayerState = pPlayer.GetNpc().GetState(16);
	for _, nSingleState in pairs(tbPlayerState) do
		if nSingleState ~= 0 then 
			return;		-- 直接return掉
		end
	end
	
	if pPartner.GetValue(self.emKPARTNERATTRIBTYPE_FRIENDSHIP) >= self.FRIENDSHIP_SHUYUAN then
		local nTempId = self.tbPartIdToNpcId[pPartner.GetValue(self.emKPARTNERATTRIBTYPE_TEMPID)];
		local nEffectNpcId = self.tbPartnerAttrib[nTempId].nEffectNpcId;
		local nLevel = pPartner.GetValue(self.emKPARTNERATTRIBTYPE_LEVEL);
		local nPlayerMapId, nPlayerPosX, nPlayerPosY = pPlayer.GetWorldPos();

		local pNpc = KNpc.Add2(nEffectNpcId, nLevel, -1, nPlayerMapId, nPlayerPosX, nPlayerPosY, 0, 0, 0, 1);
		if not pNpc then
			Dbg:WriteLog("Partner", "Add Npc Faild!", nEffectNpcId, nLevel, nPlayerMapId, nPlayerPosX, nPlayerPosY)
			return 0;
		end
		pNpc.szName = pPartner.szName;
		pNpc.SetTitle(string.format("Đồng hành của %s", pPlayer.szName));
		pNpc.SetNpcAI(0, 0, 0, 0, 0, 0, 0, 0); 	-- 让同伴出来不动
		pNpc.SetCamp(0);	-- 新手阵营
		pNpc.SetCurCamp(0);
		pNpc.AddTaskState(1475);	-- 加无敌状态,1475为无敌BUFF技能ID
		pNpc.SetLiveTime(5 * Env.GAME_FPS)	-- 加生存时间, 5秒
		local nEffectSkillId = MathRandom(1523, 1524);	-- 在两个技能中随机一个
		pNpc.AddFightSkill(nEffectSkillId, 1, 1);
		pNpc.Sync();
		pNpc.DoSkill(nEffectSkillId, -1, pNpc.nIndex);	-- 施放动作

	end
end

function Partner:DecreaseFriendship(nPlayerId)
	local pPlayer = KPlayer.GetPlayerObjById(nPlayerId);
	if not pPlayer then
		return;
	end
	
	if pPlayer.nActivePartner == -1 then
		return;
	end
	
	local pPartner = pPlayer.GetPartner(pPlayer.nActivePartner);
	if not pPartner then
		return;
	end
	
	if pPartner.GetValue(self.emKPARTNERATTRIBTYPE_LEVEL) < self.FRIENDSHIP_DECLEVEL then
		return;
	end
	
	
	local nTodayDecr = pPartner.GetValue(self.emKPARTNERATTRIBTYPE_DECRFSTODAY); --今天已经衰减了多少
	
	local nLastTime = pPartner.GetValue(self.emKPARTNERATTRIBTYPE_DECRFSLASTTIME);
	local nNowTime = GetTime();
	
	local nLastTime_day = Lib:GetLocalDay(nLastTime);
	local nNowTime_day = Lib:GetLocalDay(nNowTime);
	
	local nDiff = nNowTime - nLastTime;
	local nToDel = math.ceil(nDiff / self.FRIENDSHIP_TIMEDIFF);
	
	if nNowTime_day - nLastTime_day > 0 then
		if nToDel > self.FRIENDSHIP_DECMAX then
			nToDel = self.FRIENDSHIP_DECMAX;
		end
		
		self:AddFriendship(pPartner, -nToDel);
		pPartner.SetValue(self.emKPARTNERATTRIBTYPE_DECRFSTODAY, nToDel);			
	else
		if nToDel > self.FRIENDSHIP_DECMAX - nTodayDecr then
			nToDel = self.FRIENDSHIP_DECMAX - nTodayDecr;
		end
		
		self:AddFriendship(pPartner, -nToDel);
		pPartner.SetValue(self.emKPARTNERATTRIBTYPE_DECRFSTODAY, nTodayDecr + nToDel);
	end
	pPartner.SetValue(self.emKPARTNERATTRIBTYPE_DECRFSLASTTIME, nNowTime);
	
	if pPartner.GetValue(self.emKPARTNERATTRIBTYPE_FRIENDSHIP) < self.FRIENDSHIP_SHUYUAN then
		self:DoPartnerCallBack(pPlayer, 0);	-- 不用再减亲密度了
		local szMsg = string.format("Độ thân mật của bạn và đồng hành - %s chưa đạt 40, đồng hành không thể giúp đỡ!", pPartner.szName);
		pPlayer.Msg(szMsg);
		self:SendClientMsg(szMsg);
	end
end

function Partner:GetFriendshipValue(nIndex)
	local pPartner = me.GetPartner(nIndex);
	if pPartner == nil then
		assert(false);
		return;
	end
	local nLevel = pPartner.GetValue(self.emKPARTNERATTRIBTYPE_LEVEL);
	local nRate = Partner:GetRate(pPartner);
	nRate = math.floor(nRate / 10) * 10;
	if not self.tbMaintenance[nRate] then
		nRate = self.SKILLUPRATEMIN;
	end
	local nBasePrice = self.tbMaintenance[nRate].nMaintenance; -- 维护价值
	local nTempId = self.tbPartIdToNpcId[pPartner.GetValue(self.emKPARTNERATTRIBTYPE_TEMPID)];
	local nType = self.tbPartnerAttrib[nTempId].nType;
	local nPointValue = nBasePrice / 600 * self.tbSkillRule[nType].nCalRate / 10;
	
	return nPointValue;
end

function Partner:RegisterPartnerTimer(pPlayer)
	if not pPlayer then
		return 0;
	end
	
	if not Partner.bClosePartnerTimer and not pPlayer.GetTempTable("Partner").nPartnerTimer then
		pPlayer.GetTempTable("Partner").nPartnerTimer = Timer:Register(self.EFFECTTIME * 60 * Env.GAME_FPS, self.OnCallPartner,
			self, pPlayer.nId);	
			
		return 1;
	end
	
	return 0;
end

function Partner:UnRegisterPartnerTimer(pPlayer)
	if not pPlayer then
		return 0;
	end
	
	if pPlayer.GetTempTable("Partner").nPartnerTimer then
		Timer:Close(pPlayer.GetTempTable("Partner").nPartnerTimer);
		pPlayer.GetTempTable("Partner").nPartnerTimer = nil;
	end
	
	return 1;
end

function Partner:ResetDecrTime(pPartner)
	if pPartner then
		local nLastTime = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_DECRFSLASTTIME);
		local nNowTime = GetTime();
		local nLastTime_day = Lib:GetLocalDay(nLastTime);
		local nNowTime_day = Lib:GetLocalDay(nNowTime);
		
		if nNowTime_day ~= nLastTime_day then
			pPartner.SetValue(Partner.emKPARTNERATTRIBTYPE_DECRFSTODAY, 0);	 -- 如果跨天了，需要手动重设一下数据
		end
		pPartner.SetValue(Partner.emKPARTNERATTRIBTYPE_DECRFSLASTTIME, nNowTime);
		
		if pPartner.nPartnerIndex == me.nActivePartner and me.nFightState == 1  then
			Partner:RegisterPartnerTimer(me);
		end
	end
end



function Partner:RandomSkillCount(tbSkillCountRate, nType)	
	local nRandom = MathRandom(1, 100);	-- 产生的随机数，用来随机技能的总个数
	local nCountAll = 0;	-- 返回值，技能的总个数
	local nMinInThisType = 0;			-- 该类别的NPC允许的技能个数的最低值
	
	for i = self.SKILLCOUNTMIN, self.SKILLCOUNTMAX do
		if tbSkillCountRate["nRateOf"..i.."Skills"] > 0  and nMinInThisType == 0 then
			nMinInThisType = i;
		end
				
		nRandom = nRandom - tbSkillCountRate["nRateOf"..i.."Skills"];		
		
		if nRandom <= 0 then
			nCountAll = i;
			break;
		end
	end
	
	if nRandom > 0 then 		
		if nMinInThisType == 0 then
			nCountAll = self.SKILLCOUNTMIN;
		else
			nCountAll = nMinInThisType;		-- 这种类别同伴的技能总数最低值
		end
		
	end
	
	return nCountAll;
end

function  Partner:GenBichuSkill(tbSkillCountRate, nCountAll, nSeries)
	local nCanBichuCount = nCountAll;	-- 技能的最大个数
	local tbSkill = {};		-- 存放生成的必出技能ID
	for i = 1, self.BICHUSKILLCOUNT do
		local szBichuSkillId = tbSkillCountRate["nBichuSkill"..i.."Id"];
		local tbBichuSkillId = Lib:SplitStr(szBichuSkillId);
		if #tbBichuSkillId ~= 0 then
			for j = 1, #tbBichuSkillId do
				local nSkillId = tonumber(tbBichuSkillId[j]);
				if not nSkillId then
					break;
				end
				
				local nThisSeries = self.tbSkillSeries[nSkillId];
				if nThisSeries and (nSeries == nThisSeries or nThisSeries == -1 or nSeries == -1) then
					table.insert(tbSkill, nSkillId);
					nCanBichuCount = nCanBichuCount - 1;
					break;
				end
			end
		end
		
		if nCanBichuCount <= 0 then
			break;
		end
	end
	
	return tbSkill;
end

function Partner:GenRandomSkill(nRandomSkillTemplateId, nSeries, nCount)
	local tbUsabelSkillList = {};	-- 可用的技能列表
	local nWeight = 0;	-- 权重总值
	for _, tbList in pairs(self.tbSkillSetting[nRandomSkillTemplateId]) do
		if tbList.nSeries == -1 or tbList.nSeries == nSeries then
			nWeight = nWeight + tbList.nRate;
			tbUsabelSkillList = self:TabInsertPriority(tbUsabelSkillList, tbList);
		end

	end
	
	local tbRandomSkill = {};
	for i = 1, nCount do
		local nRandom = MathRandom(1, nWeight);
		for nKey, tbSkillData in pairs(tbUsabelSkillList) do
			nRandom = nRandom - tbSkillData.nRate;
			if nRandom <= 0 then
				table.insert(tbRandomSkill, tbSkillData.nSkillId);
				nWeight = nWeight - tbSkillData.nRate;	-- 扣除刚学到的技能的权重
				table.remove(tbUsabelSkillList, nKey);	-- 把刚学到的技能从随机表里删除
				break;
			end
		end
	end
	
	return tbRandomSkill;
end

function Partner:TabInsertPriority(tb, tbData)
	local nBegin = 1;
	local nEnd   = #tb;
	local nIndex = math.ceil((nBegin + nEnd)/2);
	while tb[nIndex] do
		if tb[nIndex].nRate > tbData.nRate then
			if nIndex == nEnd then
				nIndex = nIndex + 1;
				break;
			end
			nBegin = nIndex;
			nIndex = math.ceil((nBegin + nEnd)/2);
		elseif tb[nIndex].nRate < tbData.nRate then
			if nIndex == nBegin then
				nIndex = nBegin;
				break;
			end
			nEnd = nIndex;
			nIndex = math.floor((nBegin + nEnd)/2);
		else
			nIndex = nIndex + 1;
			break;
		end
		
		if nBegin == nEnd - 1 and tb[nBegin].nRate > tbData.nRate and tb[nEnd].nRate < tbData.nRate then
			nIndex = nEnd;
			break;
		end
	end
	
	table.insert(tb, nIndex, tbData);

	return tb;
end


end 	-- if MODULE_GAMESERVER then

function Partner:GetTalentLevelAdded(pPartner, nValueAdded, nType)
	if not pPartner then
		return 0, 0;
	end
	
	local nCurTalent = pPartner.GetValue(self.emKPARTNERATTRIBTYPE_TALENT);	
	local nNewTalentLevel = nCurTalent % 1000;	 -- nCurTalent = nTalentLevel*1000 + nTalentPoint
	local nTalentPoint = math.floor(nCurTalent / 1000);
	
	local nSkillCount = pPartner.nSkillCount;
	local nNeedLevelMax = self.tbFsTalRate[nSkillCount][1];
	
	local nTempId = self.tbPartIdToNpcId[pPartner.GetValue(self.emKPARTNERATTRIBTYPE_TEMPID)];
	local nPartnerType = self.tbPartnerAttrib[nTempId].nType;
	local nTalentRate = self.tbSkillRule[nPartnerType].nCalRate;
	
	nType = nType or 1;	
	if nType == 0 then
		nNewTalentLevel = math.min(nNewTalentLevel + nValueAdded, self.TALENT_MAX);	-- 最大不能超过100
		nNewTalentLevel = math.max(nNewTalentLevel, self.TAlENT_MIN);	-- 最小不能小于40
	else
		nTalentPoint = nTalentPoint + nValueAdded;
	end
	

	while nNewTalentLevel < self.TALENT_MAX do
		local nCalLevel = math.min(nNewTalentLevel, nNeedLevelMax);
		if nTalentPoint >= self.tbTalentLevel[nCalLevel] * nTalentRate then
			nTalentPoint = nTalentPoint - self.tbTalentLevel[nCalLevel] * nTalentRate;
			nNewTalentLevel = nNewTalentLevel + 1;
		else
			break;
		end
	end
	
	if nNewTalentLevel >= self.TALENT_MAX then
		nTalentPoint = 0;
	end
	
	return nNewTalentLevel, nTalentPoint;
end

function Partner:GetMaxStoreExp(pPartner)
	local nLevel = pPartner.GetValue(self.emKPARTNERATTRIBTYPE_LEVEL);
	if nLevel >= self.MAXLEVEL then
		return 0;
	end
	
	local nExpSum = 0;
	for i = nLevel, nLevel + self.LEVELEXPSTROE - 1 do
		nExpSum = nExpSum + self.tbLevelSetting[i].nExp;
		if i >= self.MAXLEVEL - 1 then	
			break;
		end
	end
	
	return nExpSum;
end

function Partner:GetPartnerValue(pPartner)
	if not pPartner then
		return 0;
	end

	local nNpcId = self.tbPartIdToNpcId[pPartner.GetValue(self.emKPARTNERATTRIBTYPE_TEMPID)];
	local nType = self.tbPartnerAttrib[nNpcId].nType;

	local nBaseValue = self.tbBaseValue[nType]["nValueOf"..pPartner.nSkillCount.."Skills"];
	if not nBaseValue then
		return 0;
	end
	
	local nSkillUpRate = self:GetRate(pPartner);
	nSkillUpRate = math.floor(nSkillUpRate / 10) * 10;  -- 向下取整十
	if not self.tbMaintenance[nSkillUpRate] then
		nSkillUpRate = self.SKILLUPRATEMIN;
	end
	local nTempId = self.tbPartIdToNpcId[pPartner.GetValue(self.emKPARTNERATTRIBTYPE_TEMPID)];
	local nPartnerType = self.tbPartnerAttrib[nTempId].nType;
	local nCalRate = self.tbSkillRule[nPartnerType].nCalRate;

	local nTitleValue = self.tbMaintenance[nSkillUpRate].nTitleValue; 
	nTitleValue = nTitleValue * pPartner.GetValue(self.emKPARTNERATTRIBTYPE_LEVEL) / self.MAXLEVEL * nCalRate;
	
	local nBookValue = self:GetPartnerSkillBookValue(pPartner);
	return nBaseValue + nTitleValue + nBookValue;
end

function Partner:GetPartnerSkillBookValue(pPartner)
	local nValue = 0;		

	if pPartner then
		local nCount = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_SKILLBOOK);
		if nCount < 0 then
			nCount = 0;
		end
		for i =1 , 3 do
			local nNum = math.fmod(nCount, 10 ^ i);
			nValue = nValue + math.floor(nNum / (10^(i - 1)))* self.tbBookValue[i];
		end
	end
	
	return nValue;
end

function Partner:GetRate(pPartner)
	if pPartner == nil then
		assert(false);
		return;
	end
	local nSkillPoint = 0;
	for i = 0, pPartner.nSkillCount - 1 do
		local tbSkill = pPartner.GetSkill(i);
		nSkillPoint = nSkillPoint + tbSkill.nLevel - 1;
	end
	
	local nSkillChannce = math.floor(pPartner.GetValue(self.emKPARTNERATTRIBTYPE_LEVEL) / 5);

	local nSkillUpRate = 0;
	if nSkillChannce ~= 0 then
		nSkillUpRate =  math.floor(nSkillPoint * 100 / nSkillChannce);
	end
	if not self.tbFsTalRate[pPartner.nSkillCount] then
		return 0;
	end
	
	local nMaxRate = self.tbFsTalRate[pPartner.nSkillCount][2] or 100;
	return math.min(nMaxRate, nSkillUpRate);
end

function Partner:SendClientMsg(szMsg)
	me.CallClientScript({"UiManager:OpenWindow", "UI_INFOBOARD", szMsg});
end

function Partner:GetSelfStartCount(pPartner)
	if not pPartner then
		return 0;
	end

	local nPartnerValue = self:GetPartnerValue(pPartner);
	local nCount = 1;
	for i = 2, Partner.MAXSTARLEVEL do
		local nLevelValue = self.tbStarLevel[i].nStarValue;
		if nPartnerValue >= nLevelValue then
			nCount = nCount + 1;
		end
	end
	
	if nCount < 2 then
		nCount = 2;
	end
	
	return nCount;
end
