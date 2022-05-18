
-- Éú»î¼¼ÄÜ½Å±¾Àà
Require("\\script\\lifeskill\\define.lua");

-------------------------------------------------------------------------
-- [C/S]ÏµÍ³Æô¶¯µÄÊ±ºò³õÊ¼»¯
function LifeSkill:OnInit()
	local nSkillCount	= self:LoadAllSkill();
	local nRecipeCount	= self:LoadAllRecipe();
	self:DbgOut(string.format("LifeSkill System Inited! %d Skill(s) and %d Recipe(s) loaded!", nSkillCount, nRecipeCount));
end


function LifeSkill:_OnLogin()
	local nSkillCount = self:LoadSkill();
	local nRecipeCount = self:LoadRecipe();

	-- ¼ÓÉÏÄÇÐ©¿ÉÒÔ×Ô¶¯Ìí¼ÓµÄÅä·½	
	local tbPlayerLifeSkills = self:GetMyLifeSkill(me);
	for _, tbSkill in pairs(tbPlayerLifeSkills.tbLifeSkills) do
		for _, tbBelongRecipe in pairs(self.tbLifeSkillDatas[tbSkill.nSkillId].tbRecipeDatas) do
			if ((self:HasLearnRecipe(me, tbBelongRecipe.ID) ~= 1) and tbBelongRecipe.AutoAppend == 1 and tbBelongRecipe.SkillLevel <= tbSkill.nLevel and tbBelongRecipe.Storage == 0) then
				self:AddRecipe(me, tbBelongRecipe.ID);
			end
		end		
	end

	
	--Ôö¼Ó»î¶¯Åä·½
	--if me.nLevel >= 20 then
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
	for nRecipeId, tbEventRecipe in pairs(self.tbStorageDatas) do
		if (not tbEventRecipe.nAutoAppend or tbEventRecipe.nAutoAppend == 1) then
			if tbEventRecipe.nStartDate == 0 and tbEventRecipe.nEndDate == 0 then
				self:AddRecipe(me, nRecipeId, 0);
			elseif nNowDate >= tbEventRecipe.nStartDate and nNowDate < tbEventRecipe.nEndDate then
				self:AddRecipe(me, nRecipeId, 0)
			end
		end
	end
	--end

	self:DbgOut(string.format(me.szName.." %d Skill (s) and %d Recipe(s) Loaded!", nSkillCount, nRecipeCount));

end

function LifeSkill:_OnLogout()
	if (MODULE_GAMESERVER) then
		local nSkillCount = 0;
		local nRecipeCount = 0;
		
		local tbPlayerLifeSkills = self:GetMyLifeSkill(me);
		for _, tbSkill in pairs(tbPlayerLifeSkills.tbLifeSkills) do
			me.SaveAddLifeSkill(tbSkill.nSkillId, tbSkill.nLevel, tbSkill.nExp);
			nSkillCount = nSkillCount + 1;
			for _, tbRecipe in pairs(tbSkill.tbRecipes) do
				me.SaveAddRecipe(tbRecipe.nRecipeId);
				nRecipeCount = nRecipeCount + 1;
			end
		end
		
		self:DbgOut(string.format(me.szName.." %d Skill (s) and %d Recipe(s) Saveed!", nSkillCount, nRecipeCount));
		
	end
end


-------------------------------------------------------------------------
function LifeSkill:LoadSkill()
	local tbSkillList = me.GetLifeSkillList();
	if (not tbSkillList or #tbSkillList == 0) then
		return 0;
	end
	
	for _, tbSkill in ipairs(tbSkillList) do
		self:NewSkill(me, tbSkill.nSkillId, tbSkill.nLevel, tbSkill.nExp);
	end
	
	return #tbSkillList;
end


-------------------------------------------------------------------------
function LifeSkill:NewSkill(pPlayer, nSkillId, nLevel, nCurExp)
	local tbSkillData = self.tbLifeSkillDatas[nSkillId];
	if (not tbSkillData) then
		pPlayer.Msg("KhÃ´ng biáº¿t ká»¹ nÄƒng ".. nSkillId);
		return nil;
	end
	
	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	if (tbPlayerLifeSkills.tbLifeSkills[nSkillId]) then
		pPlayer.Msg("Láº·p láº¡i cÃ¡c ká»¹ nÄƒng "..tbPlayerLifeSkills.tbLifeSkills[nSkillId].tbSkillData.Name);
		return nil;
	end
	
	local tbLifeSkill = Lib:NewClass(self._tbSkillClassBase);
	
	tbLifeSkill.nSkillId	= nSkillId;
	tbLifeSkill.nLevel		= nLevel;
	tbLifeSkill.nExp		= nCurExp or 0;
	tbLifeSkill.tbSkillData = tbSkillData;
	tbLifeSkill.tbRecipes	= {};
	tbLifeSkill.me			= pPlayer;
	
	tbPlayerLifeSkills.tbLifeSkills[nSkillId]	= tbLifeSkill;
	
	return tbLifeSkill;
end


-------------------------------------------------------------------------
function LifeSkill:LoadRecipe()
	local tbRecipeList = me.GetRecipeList();
	if (not tbRecipeList or #tbRecipeList == 0) then
		return 0;
	end
	
	for _, nRecipeId in ipairs(tbRecipeList) do
		self:NewRecipe(me, nRecipeId);
	end
	
	return #tbRecipeList;
end

-------------------------------------------------------------------------
function LifeSkill:NewRecipe(pPlayer, nRecipeId)
	local tbRecipeData = self.tbRecipeDatas[nRecipeId];
	if (not tbRecipeData) then
		pPlayer.Msg("KhÃ´ng biáº¿t cÃ´ng thá»©c "..nRecipeId);
		return nil;
	end
	
	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	local tbSkill = tbPlayerLifeSkills.tbLifeSkills[tbRecipeData.Belong];
	if (not tbSkill) then
		pPlayer.Msg("KhÃ´ng thuá»™c ká»¹ nÄƒng "..tbRecipeData.Belong..","..tbRecipeData.Name);
		return nil;
	end
	
	if (tbSkill.tbRecipes[nRecipeId]) then
--		pPlayer.Msg("ÖØ¸´Åä·½ - "..tbRecipeData.Name);
		return nil;
	end
	local tbRecipe = Lib:NewClass(self._tbRecipeClassBase);
	
	tbRecipe.nRecipeId = nRecipeId;
	tbRecipe.tbRecipeData = tbRecipeData;
	tbRecipe.tbSkillData =  self.tbLifeSkillDatas[tbRecipeData.Belong];
	tbSkill.tbRecipes[nRecipeId] = tbRecipe;
	
	return tbRecipe;
end


-------------------------------------------------------------------------
-- ÎªÍæ¼ÒÌí¼ÓÒ»¸ö¼¼ÄÜ
function LifeSkill:AddLifeSkill(pPlayer, nSkillId, nLevel)
	local tbLifeSkill = LifeSkill:NewSkill(pPlayer, nSkillId, nLevel);
	if (not tbLifeSkill) then
		return;
	end
	pPlayer.SaveAddLifeSkill(tbLifeSkill.nSkillId, tbLifeSkill.nLevel, tbLifeSkill.nExp); -- Êý¾Ý´æµ½³ÌÐòÖÐÈ¥
	self:AddRecipeForLevelChange(pPlayer, nSkillId, nLevel);
	self:AddTitleForLevelChange(pPlayer, nSkillId, nLevel);
end


-------------------------------------------------------------------------
-- É¾³ýÍæ¼ÒÒ»¸ö¼¼ÄÜ
function LifeSkill:RemoveLifeSkill(pPlayer, nSkillId)
	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	local tbSkill = tbPlayerLifeSkills.tbLifeSkills[nSkillId];
	if (not tbSkill) then
		pPlayer.Msg("Náº¿u khÃ´ng cÃ³ ká»¹ nÄƒng nÃ y: ",nSkillId);
		return;
	end
	
	for _, tbRecipe in pairs(tbSkill.tbRecipes) do
		self:RemoveRecipe(pPlayer, tbRecipe.nRecipeId);
	end
	
	tbPlayerLifeSkills[nSkillId] = nil;
	pPlayer.SaveDelLifeSkill(nSkillId);
	pPlayer.Msg("Há»§y bá» ká»¹ nÄƒng sá»‘ng thÃ nh cÃ´ng.");
end


-------------------------------------------------------------------------
-- ÎªÍæ¼ÒÌí¼ÓÒ»¸öÅä·½
function LifeSkill:AddRecipe(pPlayer, nRecipeId, nMsg)
	local nBelongSkillId = self:GetBelongSkillId(nRecipeId);
	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	local tbSkill = tbPlayerLifeSkills.tbLifeSkills[nBelongSkillId];
	local tbRecipeData = self.tbRecipeDatas[nRecipeId];
	local nStorageRecipeId = nil;
	if self.tbStorageDatas[nRecipeId] then
		nStorageRecipeId = 1;
	end
	if (not tbRecipeData) then
		if not nStorageRecipeId then
			pPlayer.Msg("KhÃ´ng cÃ³ cÃ´ng thá»©c nÃ y");
		end
		return;
	end
	
	if (not tbSkill) then
		if not nStorageRecipeId then
			pPlayer.Msg("Ká»¹ nÄƒng nÃ y Ä‘Ã£ cÃ³ rá»“i, khÃ´ng thá»ƒ há»c tiáº¿p");
		end
		return;
	end
	
	if (tbRecipeData.SkillLevel > tbSkill.nLevel) then
		if not nStorageRecipeId then
			pPlayer.Msg("Ká»¹ nÄƒng trÃ¬nh Ä‘á»™ lÃ  khÃ´ng Ä‘á»§, khÃ´ng thá»ƒ há»c cÃ´ng thá»©c nÃ y");
		end
		return;
	end
	
	local tbRecipe = LifeSkill:NewRecipe(pPlayer, nRecipeId);
	
	if (not tbRecipe) then
		return;
	end
	
	pPlayer.SaveAddRecipe(nRecipeId);
	if nMsg ~= 0 then
		pPlayer.Msg("Ká»¹ nÄƒng sá»‘ng Ä‘Æ°á»£c nÃ¢ng cáº¥p, cÃ³ thá»ƒ cháº¿ táº¡o thÃªm váº­t pháº©m má»›i");
	end
	return 1;
end


-------------------------------------------------------------------------
-- É¾³ýÍæ¼ÒÒ»¸öÅä·½
function LifeSkill:RemoveRecipe(pPlayer, nRecipeId)
	local nBelongSkillId = self:GetBelongSkillId(nRecipeId);
	if (self:HasLearnSkill(pPlayer, nBelongSkillId) ~= 1) then
		pPlayer.Msg("Há»§y bá» cÃ¡c lá»—i cÃ´ng thá»©c, cÃ´ng thá»©c nÃ y khÃ´ng thuá»™c vá» ká»¹ nÄƒng!");
		return;
	end
	
	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	local tbSkill = tbPlayerLifeSkills.tbLifeSkills[nBelongSkillId];
	if (not tbSkill.tbRecipes[nRecipeId]) then
		pPlayer.Msg("Há»§y bá» cÃ´ng thá»©c khÃ´ng xÃ¡c Ä‘á»‹nh cÃ´ng thá»©c khÃ´ng tá»“n táº¡i:", nRecipeId)
	end
	
	tbSkill.tbRecipes[nRecipeId] = nil;
	pPlayer.SaveDelRecipe(nRecipeId);
	pPlayer.Msg("XÃ³a cÃ´ng thá»©c thÃ nh cÃ´ng!");
end


-------------------------------------------------------------------------
-- ÎªÖ¸¶¨¼¼ÄÜÌí¼Ó¾­Ñé
function LifeSkill:AddSkillExp(pPlayer, nSkillId, nExp)

	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	local tbSkill = tbPlayerLifeSkills.tbLifeSkills[nSkillId];
	if (not tbSkill) then
		return;
	end
	
	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	tbSkill.nExp  = tbSkill.nExp + nExp;
	local szName  = self.tbLifeSkillDatas[nSkillId].Name;
	pPlayer.Msg("Báº¡n nháº­n Ä‘Æ°á»£c "..nExp.." Ä‘iá»ƒm kinh nghiá»‡m cháº¿ táº¡o");

	
	local nGene = tbSkill.tbSkillData.Gene;
	local nAddExp = 0;
	if (nGene == 0) then --ÖÆÔì¾­Ñé
		nAddExp = pPlayer.GetTask(StatLog.StatTaskGroupId , 8) + nExp;
		pPlayer.SetTask(StatLog.StatTaskGroupId , 8, nAddExp);
	else	-- ¼Ó¹¤
		nAddExp = pPlayer.GetTask(StatLog.StatTaskGroupId , 7) + nExp;
		pPlayer.SetTask(StatLog.StatTaskGroupId , 7, nAddExp);
	end
	
	-- TODO:liuchang ´¦Àí×î¸ßµÈ¼¶
	local nNextLevel = tbSkill.nLevel + 1;
	
	while (true) do
		if (nNextLevel > tbSkill.tbSkillData.nMaxLevel) then
			nNextLevel = tbSkill.tbSkillData.nMaxLevel;
			break;
		else
			if (self:CanLevelUp(nSkillId, nNextLevel, tbSkill.nExp) == 1) then
				if (self:SetSkillLevel(pPlayer, nSkillId, nNextLevel) == 1) then
					tbSkill.nExp = tbSkill.nExp - self:GetLevelUpExp(nSkillId, nNextLevel);
					nNextLevel = nNextLevel + 1;
				else
					return;
				end
			else
				break;
			end
		end;
	end;		

	if (tbSkill.nExp > self:GetLevelUpExp(nSkillId, nNextLevel)) then
		tbSkill.nExp = self:GetLevelUpExp(nSkillId, nNextLevel);
	end
	
	pPlayer.SaveLifeSkillExp(nSkillId, tbSkill.nExp);

end

-------------------------------------------------------------------------

-- »ñÈ¡Ê¦Í½³É¾Í
function LifeSkill:GetAchievement(pPlayer, nLevel)
	if (not pPlayer or nLevel <= 0) then
		return;
	end
	if (nLevel >= 30) then
		Achievement:FinishAchievement(pPlayer.nId, Achievement.LIFISKILL_30);
	elseif (nLevel >= 20) then
		Achievement:FinishAchievement(pPlayer.nId, Achievement.LIFISKILL_20);
	end
end

-------------------------------------------------------------------------
-- Éè¶¨µÈ¼¶
function LifeSkill:SetSkillLevel(pPlayer, nSkillId, nLevel)
	if (not nLevel or nLevel <= 0) then
		nLevel = 1;
	end
	
	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	local tbSkill = tbPlayerLifeSkills.tbLifeSkills[nSkillId];
	if (not tbSkill) then
		return nil;
	end
	
	if (tbSkill.nLevel == tbSkill.tbSkillData.MaxLevel) then
		return 0;
	end
	
	tbSkill.nLevel = nLevel;
	if (tbSkill.nLevel > tbSkill.tbSkillData.MaxLevel) then
		tbSkill.nLevel = tbSkill.tbSkillData.MaxLevel;
	end
	
	pPlayer.SaveLifeSkillLevel(nSkillId, tbSkill.nLevel);

	self:AddRecipeForLevelChange(pPlayer, nSkillId, nLevel);
	
	self:AddTitleForLevelChange(pPlayer, nSkillId, nLevel);
	
	self:GetAchievement(pPlayer, nLevel);
	
	local nGene = tbSkill.tbSkillData.Gene;
	--Ð´Log
	local bMax = 1;
	for iSkillId, vtbSkill in pairs(tbPlayerLifeSkills.tbLifeSkills) do
		if (vtbSkill.nGene == nGene and nLevel < vtbSkill.nLevel) then
			bMax = 0;
			break;
		end
	end	
	if bMax == 1 then
		if (nGene == 0) then
			KStatLog.ModifyField("roleinfo", pPlayer.szName, "×î¸ßÉú»î¼¼ÄÜ", tbSkill.tbSkillData.Name);
			KStatLog.ModifyField("roleinfo", pPlayer.szName, "×î¸ßÉú»î¼¼ÄÜµÈ¼¶", nLevel);
			--KStatLog.ModifyMax("roleinfo", pPlayer.szName, "ÖÆÔìÏµ¼¼ÄÜµÈ¼¶", nLevel)
		else
			--KStatLog.ModifyField("roleinfo", pPlayer.szName, "µÈ¼¶×î¸ßµÄ¼Ó¹¤Ïµ¼¼ÄÜ", tbSkill.tbSkillData.Name)
			--KStatLog.ModifyMax("roleinfo", pPlayer.szName, "¼Ó¹¤Ïµ¼¼ÄÜµÈ¼¶", nLevel)
		end
	end
		
	return 1;
end



-------------------------------------------------------------------------
-- ·µ»ØÖ¸¶¨µÈ¼¶ÐèÒªµÄ¾­Ñé(Ö»¿¼ÂÇµ¥¼¶)
function LifeSkill:GetLevelUpExp(nSkillId, nLevel)
	return self.tbLifeSkillDatas[nSkillId].tbSkillExpMap[nLevel];
end


-------------------------------------------------------------------------
-- ·µ»ØÔö¼ÓÖ¸¶¨¾­ÑéÊÇ·ñ¿ÉÒÔÉý¼¶
function LifeSkill:CanLevelUp(nSkillId, nLevel, nExp)
	local nNeedExp = self:GetLevelUpExp(nSkillId, nLevel);
	if (not nExp or not nNeedExp) then
		print("LifeSkillExpError", nSkillId, nLevel, nExp);
		return 0;
	end
	if (nExp >= nNeedExp) then
		return 1;
	end
	
	return 0;
end


-------------------------------------------------------------------------
-- »ñµÃÖ¸¶¨¼¼ÄÜµÄµÈ¼¶
function LifeSkill:GetSkillLevel(pPlayer, nSkillId)
	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	local tbSkill = tbPlayerLifeSkills.tbLifeSkills[nSkillId];
	if (not tbSkill) then
		return 0;
	end
	
	return tbSkill.nLevel;
end


-------------------------------------------------------------------------
-- ·µ»ØÖ¸¶¨¼¼ÄÜµ±Ç°¾­Ñé
function LifeSkill:GetSkillCurExp(pPlayer, nSkillId)
	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	local tbSkill = tbPlayerLifeSkills.tbLifeSkills[nSkillId];
	if (not tbSkill) then
		return 0;
	end
	
	return tbSkill.nExp;
end


-------------------------------------------------------------------------
-- ÊÇ·ñÑ§Ï°¹ýÄ³ÖÖ¼¼ÄÜ
function LifeSkill:HasLearnSkill(pPlayer, nSkillId)
	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	if (tbPlayerLifeSkills.tbLifeSkills[nSkillId]) then
		return 1;
	else
		return 0;
	end
end


-------------------------------------------------------------------------
-- »ñµÃÖªµÀÅä·½ËùÊô¼¼ÄÜ
function LifeSkill:GetBelongSkillId(nRecipeId)
	return self.tbRecipeDatas[nRecipeId].Belong;
end


-------------------------------------------------------------------------
-- ·µ»ØÊÇ·ñÑ§¹ýÖ¸¶¨Åä·½
function LifeSkill:HasLearnRecipe(pPlayer, nRecipeId)
	if not self.tbRecipeDatas[nRecipeId] then   -- ÓÐ¿ÉÄÜÎª¿Õ zounan
		Setting:SetGlobalObj(pPlayer);
		Player:ProcessIllegalProtocol("LifeSkill:HasLearnRecipe","nRecipeId", nRecipeId);
		Setting:RestoreGlobalObj();
		return 0;
	end
	local nBelongSkillId = self.tbRecipeDatas[nRecipeId].Belong;
	local tbPlayerLifeSkills = self:GetMyLifeSkill(pPlayer);
	local tbSkill = tbPlayerLifeSkills.tbLifeSkills[nBelongSkillId];
	if (not tbSkill) then
		return 0;
	end

	if (tbSkill.tbRecipes[nRecipeId]) then
		return 1;
	else
		return 0;
	end
end


-------------------------------------------------------------------------
-- ÖÆÔìÎïÆ·
function LifeSkill:MakeProduct(nRecipeId)
	if me.IsAccountLock() ~= 0 then
		me.Msg("TÃ i khoáº£n cá»§a báº¡n Ä‘ang khÃ³a, khÃ´ng thá»ƒ thá»±c hiá»‡n thao tÃ¡c ");
		return;
	end
	if (self:HasLearnRecipe(me, nRecipeId) ~= 1) then
		me.Msg("KhÃ´ng cÃ³ cÃ´ng thá»©c cá»¥ thá»ƒ");
		me.SynProduceResult(nRecipeId, 0);
		return;
	end
	
	if (me.nFightState > 0) then
		me.Msg("KhÃ´ng thá»ƒ sá»­ dá»¥ng ká»¹ nÄƒng sá»‘ng");
		me.SynProduceResult(nRecipeId, 0);
		return 0;
	end
	
	if (me.GetNpc().nDoing ~= Npc.DO_STAND) then
		me.Msg("Gian hÃ ng chá»‰ Ä‘Æ°á»£c sá»­ dá»¥ng trong tÃ¬nh tráº¡ng ká»¹ nÄƒng sá»‘ng.");
		me.SynProduceResult(nRecipeId, 0);
		return 0;
	end
	
	--»î¶¯Åä·½
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
	if self.tbStorageDatas[nRecipeId] then
		if self.tbStorageDatas[nRecipeId].nStartDate > 0 and self.tbStorageDatas[nRecipeId].nEndDate > 0 then
			if nNowDate < self.tbStorageDatas[nRecipeId].nStartDate or nNowDate >= self.tbStorageDatas[nRecipeId].nEndDate then
				me.Msg("CÃ´ng thá»©c cho cÃ´ng thá»©c hoáº¡t Ä‘á»™ng hiá»‡n nay khÃ´ng há»£p lá»‡.");
				me.SynProduceResult(nRecipeId, 0);
				return 0;
			end
		end
	end
	
	
	local tbRecipeData = self.tbRecipeDatas[nRecipeId];
	for _,stuff in ipairs(tbRecipeData.tbStuffSet) do
		if (stuff.nCount and stuff.nCount > 0) then
			
			local nCount = me.GetItemCountInBags(stuff.tbItem[1], stuff.tbItem[2], stuff.tbItem[3], stuff.tbItem[4], stuff.tbItem[5], LifeSkill:GetBindType(stuff.nBind));
			if (nCount < stuff.nCount) then
				me.Msg("NguyÃªn liá»‡u khÃ´ng Ä‘á»§, khÃ´ng thá»ƒ cháº¿ táº¡o");
				me.SynProduceResult(nRecipeId, 0);
				return 0;
			end
		end
	end
	
	local tbPlayerLifeSkills = self:GetMyLifeSkill(me);
	local nBelongSkillId = self:GetBelongSkillId(nRecipeId);
	local tbSkill = tbPlayerLifeSkills.tbLifeSkills[nBelongSkillId];
	local nGene = tbSkill.tbSkillData.Gene;
	
	if (nGene == 1) then
		if (me.dwCurGTP < tbRecipeData.Cost) then
			me.Msg("KhÃ´ng Ä‘á»§ hoáº¡t lá»±c khÃ´ng thá»ƒ cháº¿ táº¡o váº­t pháº©m.");
			me.SynProduceResult(nRecipeId, 0);
			return;
		end
	elseif (nGene == 0) then -- ÖÆÔìÏµ
		if (me.dwCurMKP < tbRecipeData.Cost) then
			me.Msg("KhÃ´ng Ä‘á»§ tinh lá»±c khÃ´ng thá»ƒ cháº¿ táº¡o váº­t pháº©m");
			me.SynProduceResult(nRecipeId, 0);
			return 0;
		end 
	else
		print("Éú»î¼¼ÄÜÖÖÀà²»Ó¦¸ÃÊÇ0,1Ö®ÍâµÄÊý", nGene);
		assert(false);
	end
	
	local nInterval = tbRecipeData.MakeTime;
	
	local tbEvent = 
	{
		Player.ProcessBreakEvent.emEVENT_MOVE,
		Player.ProcessBreakEvent.emEVENT_ATTACK,
		Player.ProcessBreakEvent.emEVENT_SITE,
		Player.ProcessBreakEvent.emEVENT_USEITEM,
		Player.ProcessBreakEvent.emEVENT_ARRANGEITEM,
		Player.ProcessBreakEvent.emEVENT_DROPITEM,
		Player.ProcessBreakEvent.emEVENT_SENDMAIL,		
		Player.ProcessBreakEvent.emEVENT_TRADE,
		Player.ProcessBreakEvent.emEVENT_CHANGEFIGHTSTATE,
		Player.ProcessBreakEvent.emEVENT_CLIENTCOMMAND,
		Player.ProcessBreakEvent.emEVENT_ATTACKED,
		Player.ProcessBreakEvent.emEVENT_DEATH,
		Player.ProcessBreakEvent.emEVENT_LOGOUT,
		Player.ProcessBreakEvent.emEVENT_BUYITEM,
		Player.ProcessBreakEvent.emEVENT_SELLITEM,
	}
	local szMsg = "";
	if (nGene == 0) then
		szMsg = "Äang cháº¿ táº¡o..";
	elseif(nGene == 1) then 
		szMsg = "Äang cháº¿ táº¡o..";
	end

	GeneralProcess:StartProcess(szMsg, nInterval, {self.OnMakeProductResult, self, nRecipeId, 0}, {self.OnMakeProductResult, self, nRecipeId, 1}, tbEvent);
	
end

function LifeSkill:OnMakeProductResult(nRecipeId, bBreak)

	if (bBreak == 1) then
		me.Msg("Cháº¿ táº¡o bá»‹ giÃ¡n Ä‘oáº¡n.");
		me.SynProduceResult(nRecipeId, 0);
		return;	
	end
	
	if (self:HasLearnRecipe(me, nRecipeId) == 0) then
		me.Msg("CÃ´ng thá»©c nÃ y khÃ´ng há»c cÃ¡ch lÃ m thÃ nh cÃ´ng.");
		me.SynProduceResult(nRecipeId, 0);
		return;
	end
	
	local tbRecipeData = self.tbRecipeDatas[nRecipeId];
	
	local tbSkillData  = self.tbLifeSkillDatas[tbRecipeData.Belong];
	local szLifeSkillType = "";
	
	if (tbSkillData.nGene == 0) then
		szLifeSkillType = "ºÏ³É"..tbRecipeData.Name;
	elseif(tbSkillData.nGene == 1) then
		szLifeSkillType = "¼Ó¹¤"..tbRecipeData.Name;
	end
	
	--»î¶¯Åä·½
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
	if self.tbStorageDatas[nRecipeId] then
		if self.tbStorageDatas[nRecipeId].nStartDate > 0 and self.tbStorageDatas[nRecipeId].nEndDate > 0 then
			if nNowDate < self.tbStorageDatas[nRecipeId].nStartDate or nNowDate >= self.tbStorageDatas[nRecipeId].nEndDate then
				me.Msg("CÃ´ng thá»©c cho cÃ´ng thá»©c hoáº¡t Ä‘á»™ng hiá»‡n nay khÃ´ng há»£p lá»‡.");
				me.SynProduceResult(nRecipeId, 0);
				return 0;
			end
		end
	end
	
	local nCanProduct, tbFunExecute, szExtendInfo, tbTempProductSet = SpecialEvent.ExtendAward:DoCheck("LifeSkill", me, nRecipeId)
	local tbProductSet = tbRecipeData.tbProductSet;
	if nCanProduct == 1 and tbTempProductSet and #tbTempProductSet > 0 then
		tbProductSet = tbTempProductSet;
		if szExtendInfo and szExtendInfo ~= "" then
			me.Msg(szExtendInfo);
		end
	end
	
	local nPercent = MathRandom(100);
	local tbFinalProduct = nil;
	for _, tbProduct in ipairs(tbProductSet) do
		nPercent = nPercent - tbProduct.nRate;
		local tbItem = tbProduct.tbItem;
		local tbBaseProp = KItem.GetItemBaseProp(tbItem[1], tbItem[2], tbItem[3], tbItem[4]);
		if (nPercent <= 0) and tbBaseProp then
			local bBind = LifeSkill:GetBindType(tbProduct.nBind);
			if bBind == -1 then
				bBind = KItem.IsItemBindByBindType(tbBaseProp.nBindType);
			end
			tbFinalProduct =
			{
				nGenre		= tbItem[1],
				nDetail		= tbItem[2],
				nParticular	= tbItem[3],
				nLevel		= tbItem[4],
				nSeries		= (tbBaseProp.nSeries > 0) and tbBaseProp.nSeries or tbItem[6],
				bBind		= bBind,
				nLucky		= tbItem[5],
				nCount		= 1,
			}; 
			break;
		end
	end
	
	if (tbFinalProduct) then
		if (me.CanAddItemIntoBag(tbFinalProduct) ~= 1) then
			me.Msg("HÃ nh trang khÃ´ng Ä‘á»§ chá»— trá»‘ng");
			me.SynProduceResult(nRecipeId, 0);
			return;
		end
	end	
	
	-- ÅÐ¶Ï²ÄÁÏÊÇ·ñ×ã¹»
	for _, stuff in ipairs(tbRecipeData.tbStuffSet) do
		if (stuff.nCount and stuff.nCount > 0) then
			local nCount = me.GetItemCountInBags(stuff.tbItem[1], stuff.tbItem[2], stuff.tbItem[3], stuff.tbItem[4], stuff.tbItem[5], LifeSkill:GetBindType(stuff.nBind));
			if (nCount < stuff.nCount) then
				me.Msg("NguyÃªn liá»‡u "..szLifeSkillType.." khÃ´ng Ä‘á»§ cháº¿ táº¡o tháº¥t báº¡i");
				me.SynProduceResult(nRecipeId, 0);
				return;
			end
		end
	end
	
	local nCost = 0;
	for _, stuff in ipairs(tbRecipeData.tbStuffSet) do
		if (stuff.nCount and stuff.nCount > 0) then
			local bRet;
			if LifeSkill:GetBindType(stuff.nBind) >= 0 then
				bRet = me.ConsumeItemInBags2(stuff.nCount, stuff.tbItem[1], stuff.tbItem[2], stuff.tbItem[3], stuff.tbItem[4], stuff.tbItem[5], LifeSkill:GetBindType(stuff.nBind));
			else
				bRet = me.ConsumeItemInBags(stuff.nCount, stuff.tbItem[1], stuff.tbItem[2], stuff.tbItem[3], stuff.tbItem[4], stuff.tbItem[5]);
			end
			
			if (bRet ~= 0) then
				me.Msg("Cháº¥t liá»‡u kháº¥u trá»« tháº¥t báº¡i.");
				me.SynProduceResult(nRecipeId, 0);
				return;
			end
			-- »ñµÃ²ÄÁÏËùÐèµÄ¾«»î
			local nStuffCost = self.tbCost[stuff.tbItem[1]..","..stuff.tbItem[2]..","..stuff.tbItem[3]..","..stuff.tbItem[4]]
			if nStuffCost then
				nCost = nCost + stuff.nCount * nStuffCost / Spreader.ExchangeRate_Gold2JingHuo
			end
		end
	end
	
	local nGene = tbSkillData.Gene;
	if (tbSkillData.Gene == 1) then
		if (me.dwCurGTP < tbRecipeData.Cost) then
			me.Msg("KhÃ´ng Ä‘á»§ hoáº¡t lá»±c");
			me.SynProduceResult(nRecipeId, 0);
			return;
		end
		me.ChangeCurGatherPoint(-tbRecipeData.Cost);
	elseif(tbSkillData.Gene == 0) then
		if (me.dwCurMKP < tbRecipeData.Cost) then
			me.Msg("KhÃ´ng Ä‘á»§ tinh lá»±c");
			me.SynProduceResult(nRecipeId, 0);
			return;
		end
		me.ChangeCurMakePoint(-tbRecipeData.Cost);
		if tbRecipeData.Consume == 1 then
			nCost = nCost + tbRecipeData.Cost / Spreader.ExchangeRate_Gold2JingHuo; -- ¼ÇÂ¼ibvalue
		else
			nCost = 0;		-- Ïä×Ó
			-- Spreader:OnMakeBox(nRecipeId)
		end
	end
	
	if (tbFinalProduct) then
		-- ¼ÓÎïÆ·
		local tbItemInfo = {
				nSeries = tbFinalProduct.nSeries,
				nLucky = tbFinalProduct.nLucky,
			};
		if tbFinalProduct.bBind >= 0 then
		 	tbItemInfo.bForceBind = tbFinalProduct.bBind;
		end
		
		local pItem = me.AddItemEx(tbFinalProduct.nGenre, tbFinalProduct.nDetail, tbFinalProduct.nParticular, tbFinalProduct.nLevel, tbItemInfo, Player.emKITEMLOG_TYPE_PRODUCE);

		if pItem then
			
			pItem.nBuyPrice = pItem.nBuyPrice + nCost;
			pItem.SetCustom(Item.CUSTOM_TYPE_MAKER, me.szName);		-- ¼ÇÂ¼ÖÆÔìÕßÃû×Ö
			pItem.Sync();
		
			local nLevelDec = math.floor(me.nLevel / 10);
			local szLevelRang = (nLevelDec * 10 + 1) .. "¡«" .. (nLevelDec * 10 + 10);
			-- ¼ÇÂ¼¼ÛÖµÁ¿
			--KStatLog.ModifyAdd("LifeSkillStat", szLevelRang, "Í¨¹ýÉú»î¼¼ÄÜÖÆÔìµÄµÀ¾ß¼ÛÖµ×ÜÁ¿", pItem.nValue);
			
			-- ¼Ó¾­Ñé
			self:AddSkillExp(me, self:GetBelongSkillId(nRecipeId), tbRecipeData.ExpGain);
			
			me.Msg(szLifeSkillType.." Cháº¿ táº¡o thÃ nh cÃ´ng")
		else

			me.Msg(szLifeSkillType.." Cháº¿ táº¡o tháº¥t báº¡i")

		end

	else

		me.Msg(szLifeSkillType.." Cháº¿ táº¡o tháº¥t báº¡i")

	end
	
	me.SynProduceResult(nRecipeId, 1);

end


-------------------------------------------------------------------------
function LifeSkill:OnLogout()
	self:SaveAllSkill();
	self:SaveAllRecipe();	
end


-------------------------------------------------------------------------
-- È¡µÃµ±Ç°Íæ¼ÒÉú»î¼¼ÄÜÊý¾Ý
function LifeSkill:GetMyLifeSkill(pPlayer)
	local tbPlayerData		= pPlayer.GetTempTable("LifeSkill");
	local tbPlayerLifeSkill	= tbPlayerData.tbLifeSkill;
	if (not tbPlayerLifeSkill) then
		tbPlayerLifeSkill	= {
			tbLifeSkills	= {},
		};
		tbPlayerData.tbLifeSkill	= tbPlayerLifeSkill;
	end
	
	return tbPlayerLifeSkill;
end


-------------------------------------------------------------------------
-- Íæ¼ÒÉý¼¶ÎªÆäÌí¼ÓÉú»î¼¼ÄÜ
function LifeSkill:AddSkillWhenPlayerLevelUp(nLevel)
	if (MODULE_GAMESERVER) then
		if (nLevel == 20) then
			for i=1, 11 do
				self:AddLifeSkill(me, i, 1)
			end
		end
	end
end


function LifeSkill:AddRecipeForLevelChange(pPlayer, nSkillId, nSkillLevel)
	-- ¼ÓÉÏÄÇÐ©¿ÉÒÔ×Ô¶¯Ìí¼ÓµÄÅä·½
	for _, tbBelongRecipe in pairs(self.tbLifeSkillDatas[nSkillId].tbRecipeDatas) do
		if (tbBelongRecipe.AutoAppend == 1 and tbBelongRecipe.SkillLevel <= nSkillLevel and tbBelongRecipe.Storage == 0) then
			self:AddRecipe(pPlayer, tbBelongRecipe.ID);
		end
	end
	
	--Ôö¼Ó»î¶¯Åä·½
	local nNowDate = tonumber(GetLocalDate("%Y%m%d"));
	for nRecipeId, tbEventRecipe in pairs(self.tbStorageDatas) do
		if (not tbEventRecipe.nBelong or tbEventRecipe.nBelong == nSkillId) 
			and (not tbEventRecipe.nAutoAppend or tbEventRecipe.nAutoAppend == 1) then
			if tbEventRecipe.nStartDate == 0 and tbEventRecipe.nEndDate == 0 then
				self:AddRecipe(me, nRecipeId)
			elseif nNowDate >= tbEventRecipe.nStartDate and nNowDate < tbEventRecipe.nEndDate then
				self:AddRecipe(me, nRecipeId)
			end
		end
	end	
	
end


function LifeSkill:AddTitleForLevelChange(pPlayer, nSkillId, nSkillLevel)
	if (LifeSkill.tbLifeSkillLevelForTitle[nSkillId] and LifeSkill.tbLifeSkillLevelForTitle[nSkillId][nSkillLevel]) then
		local tbTitle = LifeSkill.tbLifeSkillLevelForTitle[nSkillId][nSkillLevel];
		pPlayer.AddTitle(tbTitle[1] or 0, tbTitle[2] or 0, tbTitle[3] or 0, tbTitle[4] or 0);
	end

end

-------------------------------------------------------------------------
-- ¹©µ÷ÊÔÓÃ
function LifeSkill:ShowMySkill(pPlayer)
	local tbPlayerLifeSkills = LifeSkill:GetMyLifeSkill(pPlayer);
	if (tbPlayerLifeSkills) then
		for _, tbSkill in pairs(tbPlayerLifeSkills.tbLifeSkills) do
			pPlayer.Msg(tbSkill.tbSkillData.Name.."Sá»­ dá»¥ng "..tbSkill.nLevel.." thÃ nh cÃ´ng nháº­n Ä‘Æ°á»£c. Kinh nghiá»‡m: "..tbSkill.nExp);
			if (tbSkill.tbRecipes) then
				for _, tbRecipe in pairs(tbSkill.tbRecipes) do
					pPlayer.Msg("    "..tbRecipe.tbRecipeData.Name)
				end
			end
		end
	end
end

--»ñµÃ°ó¶¨ÀàÐÍ(0Îª°ó¶¨ºÍ²»°ó¶¨¶¼¿É, 1-°ó¶¨, 2-²»°ó¶¨)
function LifeSkill:GetBindType(nBind)
	if nBind == 0 then
		return -1;
	end
	if nBind == 1 then
		return 1;
	end
	if nBind == 2 then
		return 0;
	end
	return -1;
end


-- ×¢²áÍ¨ÓÃÉÏÏßÊÂ¼þ
PlayerEvent:RegisterGlobal("OnLogin", LifeSkill._OnLogin, LifeSkill);

-- ×¢²áÀëÏßÊÂ¼þ
PlayerEvent:RegisterGlobal("OnLogout", LifeSkill._OnLogout, LifeSkill)
