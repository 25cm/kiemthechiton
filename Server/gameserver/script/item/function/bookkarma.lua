
-- 秘籍修为功能相关

-- 功能函数/回调函数接口，增加秘籍修为（服务端）

Item.emXIUWEI_ADD_TYPE_NORMAL			= 0;	-- 直接获得修为
Item.emXIUWEI_ADD_TYPE_XIULIANZHU		= 1;	-- 通过开启修炼珠获得修为

function Item:AddBookKarma(pPlayer, nAddKarma, nAddType)
	if (0 == self:IsCanAddBookKarma(pPlayer, nAddType)) then
		return 0;
	end

	local pItem = pPlayer.GetEquip(Item.EQUIPPOS_BOOK);
	if (not pItem) then
		return	0;								-- 身上没有秘籍，失败
	end

	local tbSetting = self:GetExternSetting("book", pItem.nVersion);
	if (not tbSetting) then
		return	0;
	end

	local tbSkill =								-- 秘籍所对应技能ID列表
	{
		pItem.GetExtParam(17),
		pItem.GetExtParam(18),
		pItem.GetExtParam(19),
		pItem.GetExtParam(20),
	};

	local nLevel = pItem.GetGenInfo(1);			-- 秘籍当前等级
	local nKarma = pItem.GetGenInfo(2);			-- 秘籍当前修为
	
	local nUpExp;
	if pItem.nLevel == 3 then 
		nUpExp = tbSetting.m_tbHighLevelKarma[nLevel];
	else
		nUpExp = tbSetting.m_tbLevelKarma[nLevel];
	end
	
	if ((not nUpExp) or (nUpExp <= 0)) then		-- 升到满级了
		return 1;
	end
	
	if (nLevel > pPlayer.nLevel + 5) then		-- 秘籍等级超过角色等级5级以上，不再加修为
			return	1;								
	elseif (nLevel == pPlayer.nLevel + 5) then	-- 秘籍等级等于角色等级5级的时候，只加到满为止即可
		if (nKarma >= nUpExp) then
			return 1;
		end
		if (nAddKarma + nKarma > nUpExp) then
			nAddKarma = nUpExp - nKarma;
		end
	end
	
	local nOrgLevel = nLevel;
	nKarma = nKarma + nAddKarma;

	for _, nSkill in ipairs(tbSkill) do
		if (nSkill > 0) then
			if (1 ~= pPlayer.IsHaveSkill(nSkill)) then
				pPlayer.AddFightSkill(nSkill, 1);		-- 角色没有秘籍对应的技能，则加上该技能
			end
			pPlayer.AddSkillExp(nSkill, nAddKarma);	-- 增加角色的技能熟练度
		end
	end

	while (true) do
		local nLevelUp;	-- 秘籍升级下一级所需的修为
		if pItem.nLevel == 3 then
			nLevelUp = tbSetting.m_tbHighLevelKarma[nLevel];
		else
			nLevelUp = tbSetting.m_tbLevelKarma[nLevel];
		end
		if (not nLevelUp) or (nLevelUp <= 0) then
			nKarma = 0;							-- 已经升至顶级，不再增加修为
			pPlayer.Msg("Mật tịch hiện tại đã cấp cao nhất, tiếp tục tu luyện không thể tăng kỹ năng mật tịch.");
			break;
		end
		if (nKarma > nLevelUp) then			-- 升级
			nLevel = nLevel + 1;
			nKarma = nKarma - nLevelUp;
		else
			break;
		end
	end

	if (pPlayer.UpdateBook(nLevel, nKarma) == 1) then		-- 秘籍属性更新处理
		pPlayer.Msg("Nhận được "..nAddKarma.." điểm tu luyện mật tịch!");	-- 发送系统消息
	end

	if (nLevel ~= nOrgLevel) then				-- 等级发生变化
		pPlayer.Msg("Tăng đẳng cấp mật tịch!");		-- 发送系统消息
	end

	return	1;

end

function Item:IsCanAddBookKarma(pPlayer, nAddType)
	if (not pPlayer) then
		return 0;
	end
	if (not nAddType) then
		return 1;
	end
	
	-- 通过修炼珠开启获得修为
	if (nAddType == self.emXIUWEI_ADD_TYPE_XIULIANZHU) then
		local nXiuSkillLevel = pPlayer.GetSkillState(380);
		if (not nXiuSkillLevel or nXiuSkillLevel <= 0) then
			return 0;
		end
	end
	return 1;
end
