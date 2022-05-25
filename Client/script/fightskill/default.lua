
local tbDefault	= FightSkill:GetClass("default");

local tbWeaponName	= {
	[11]	= "Tay không, Triền thủ",
	[12]	= "Kiếm",
	[13]	= "Đao",
	[14]	= "Côn",
	[15]	= "Thương",
	[16]	= "Chùy",
	[21]	= "Phi tiêu",
	[22]	= "Phi đao",
	[23]	= "Tụ tiễn",
	[24]	= "Cơ quan",
}

local tbHoresName	= {
	"Không thể thi triển khi cưỡi ngựa",
	"Phải cưỡi ngựa để thi triển",
}

local tbSeriesColor	= {
	[Env.SERIES_NONE]	= "white",
	[Env.SERIES_METAL]	= "gold",
	[Env.SERIES_WOOD]	= "wood",
	[Env.SERIES_WATER]	= "water",
	[Env.SERIES_FIRE]	= "fire",
	[Env.SERIES_EARTH]	= "earth",
};

local function Frame2Sec(value)
	return math.floor(value / Env.GAME_FPS * 10) / 10;
end

function tbDefault:OnLevelUp()
end;

function tbDefault:GetDesc(tbThisInfo, bNext, bShowTitle, bNoNeedLevel) -- bNoNeedLevel 不需要自身能级也能取到对应技能TIP
	local tbInfo	= tbThisInfo;
	local bMaxLevel = 0;
	local tbMsg	= {};
	
	local szTitle	= string.format("<color=yellow>%s<color>\n", tbInfo.szName);
	if (not bNext or bShowTitle) then
		if(tbInfo.szProperty ~= "") then
			tbMsg[#tbMsg+1]	= string.format("<color=metal>%s<color>",tbInfo.szProperty.."\n");
		end;

		if (tbInfo.nIsAura == 1 and not bNoNeedLevel) then
			tbMsg[#tbMsg+1] = "<color=gray>(Kéo đến thanh phím tắt, nhấn phím số để tự động thi triển)<color>";
		end
		if(tbInfo.nSkillType == 1) then
			tbMsg[#tbMsg+1]	= string.format("<color=gray>(Kỹ năng hệ cách đấu, xuất chiêu không ảnh hưởng bởi tốc đánh)<color>");
		end;

		if(tbInfo.szDesc ~= "") then
			tbMsg[#tbMsg+1]	= string.format("%s",tbInfo.szDesc);
		end;
		
		if (MODULE_GAMECLIENT and FightSkill:CheckCanAddSkillPoint(me, tbInfo.nId) ~= 1) then
			if(tbInfo.nId == Player.tbFactions[me.nFaction].tbRoutes[1].tbSkills[11].nId or
			   tbInfo.nId == Player.tbFactions[me.nFaction].tbRoutes[2].tbSkills[11].nId) then
				tbMsg[#tbMsg+1] = "<color=green>(Sau khi nhận và hoàn thành nhiệm vụ kỹ năng cấp 110 ở chỗ đệ tử môn phái, thì có thể cộng điểm tăng cấp kỹ năng này)<color>";
			end;
		end;
	end

	if (me.nLevel < tbInfo.nReqLevel and not bNoNeedLevel) then
		tbMsg[#tbMsg+1]	= string.format("<color=red>Nhân vật đạt cấp %d sẽ học được kỹ năng này<color>", tbInfo.nReqLevel);
		return szTitle, table.concat(tbMsg, "\n");
	end
	
	if (not bNext or bShowTitle) then
		if (tbInfo.nRouteLimited and tbInfo.nRouteLimited > 0) then
			if (me.nRouteId ~= tbInfo.nRouteLimited or me.nFaction ~= tbInfo.nFactionLimited) then
				tbMsg[#tbMsg+1]	= "\nYêu cầu hệ phái: <color=red>"..Player:GetFactionRouteName(tbInfo.nFactionLimited, tbInfo.nRouteLimited).."<color>";
			else
				tbMsg[#tbMsg+1]	= "\nYêu cầu hệ phái:"..Player:GetFactionRouteName(tbInfo.nFactionLimited, tbInfo.nRouteLimited);
			end
		elseif (tbInfo.nFactionLimited and tbInfo.nFactionLimited > 0) then
			if (me.nFaction ~= tbInfo.nFactionLimited) then
				tbMsg[#tbMsg+1]	= "\nYêu cầu môn phái: <color=red>"..Player:GetFactionRouteName(tbInfo.nFactionLimited, nil).."<color>";
			else
				tbMsg[#tbMsg+1]	= "\nYêu cầu môn phái:"..Player:GetFactionRouteName(tbInfo.nFactionLimited, nil);
			end
		end
		
		if(tbInfo.nSeries ~= 0) then
			tbMsg[#tbMsg+1]	= string.format("\nNgũ hành: <color=%s>Hệ %s<color>",
				tbSeriesColor[tbInfo.nSeries] or "",
				Env.SERIES_NAME[tbInfo.nSeries] or tostring(tbInfo.nSeries));
		end;
		
		if (tbInfo.nWeaponLimited ~= 0) then
			if(tbInfo.nSeries == 0) then
				tbMsg[#tbMsg+1] = "";
			end
			tbMsg[#tbMsg+1]	= string.format("Vũ khí: <color=gold>%s<color>",
				tbWeaponName[tbInfo.nWeaponLimited] or tostring(tbInfo.nWeaponLimited));
		end;

		if (tbInfo.nHorseLimited ~= 0) then
			if(tbInfo.nSeries == 0) then
				tbMsg[#tbMsg+1] = "";
			end
			tbMsg[#tbMsg+1]	= string.format("%s\n",tbHoresName[tbInfo.nHorseLimited] or
				("Hạn chế cưỡi ngựa?:"..tostring(tbInfo.nHorseLimited)));
		else
			tbMsg[#tbMsg+1]	= "";	
		end;
	end
	
	if (tbThisInfo) then
		local nMaxLevel = KFightSkill.GetSkillMaxLevel(tbInfo.nId);
		local szLevel	= "";
		if (nMaxLevel > 0) then
			szLevel = string.format("<color=gold>Cấp %d/%d<color>", tbInfo.nLevel, nMaxLevel);
		else
			szLevel = string.format("<color=gold>Cấp %d<color>", tbInfo.nLevel);
		end
		if (bNext ~= 1) then
			if (tbInfo.nBaseLevel and tbInfo.nBaseLevel ~= tbInfo.nLevel) then	-- 有受到加成
				szLevel	= szLevel..string.format(" (%d", tbInfo.nBaseLevel);
				if (tbInfo.nAddPoint and tbInfo.nAddPoint > 0) then
					szLevel	= szLevel.."+"..tbInfo.nAddPoint;
				end
			
				if (tbInfo.nLevelAddition and tbInfo.nLevelAddition > 0) then
					szLevel	= szLevel..string.format("<color=cyan>+%d<color>", tbInfo.nLevelAddition);
				end;
				
				szLevel	= szLevel..")";
			end
		end;
		if (bNext) then
			tbMsg[#tbMsg+1]	= string.format("<color=cyan>Cấp kế<color>: %s", szLevel);
		else
			tbMsg[#tbMsg+1]	= string.format("<color=cyan>Cấp hiện tại<color>: %s", szLevel);
		end
		local nMaxSkillLevel = KFightSkill.GetSkillMaxLevel(tbInfo.nId);
		if (tbInfo.nBaseLevel and (nMaxSkillLevel <= (tbInfo.nBaseLevel + (tbInfo.nAddPoint or 0))) and nMaxSkillLevel ~= 0) then
			bMaxLevel = 1;
		end
		if (bMaxLevel == 1) then
			if(tbInfo.nExpPercent) then
			else	
				tbMsg[#tbMsg+1]	= string.format("<color=red>Đã đạt cấp cao nhất<color>");
			end
		end
		
		self:GetDescAboutLevel(tbMsg, tbThisInfo);
	else
		tbMsg[#tbMsg+1]	= string.format("<color=cyan>Cấp hiện tại<color>: <color=gold>0/%d<color>", KFightSkill.GetSkillMaxLevel(tbInfo.nId));
	end
	
	return szTitle, table.concat(tbMsg, "\n").."\n";
end;

function tbDefault:GetDescAboutLevel(tbMsg, tbInfo, bShow)
	local bShow = bShow or 1;
	if (not tbInfo) then
		return;
	end
	if bShow == 1 then
		if (tbInfo.nExpPercent) then
			local nMaxLevel = KFightSkill.GetSkillMaxLevel(tbInfo.nId);
			if (tbInfo.nBaseLevel < nMaxLevel) then
				tbMsg[#tbMsg+1]	= string.format("Độ tu luyện: <color=gold>%d%%<color>", tbInfo.nExpPercent);
			else
				tbMsg[#tbMsg+1]	= string.format("<color=red>Đã luyện đến cấp cao nhất<color>");
			end
		end;
		if (tbInfo.nAttackRadius ~= 0) then
			tbMsg[#tbMsg+1]	= string.format("<color=blue>Cự ly thi triển: <color><color=gold>%d<color>", tbInfo.nAttackRadius);
		end;
	
		self:GetParamDesc(tbMsg, tbInfo.nParam1, tbInfo.nParam2, tbInfo);
	
		if (tbInfo.nCost ~= 0) then
			tbMsg[#tbMsg+1]	= string.format("<color=blue>%s mất: <color><color=gold>%d<color>",
				FightSkill.COSTTYPE_NAME[tbInfo.nCostType] or tostring(tbInfo.nCostType).."?", tbInfo.nCost);
		end;
	
		if (tbInfo.nMinTimePerCast > 0) then
			if (tbInfo.nMinTimePerCast == tbInfo.nMinTimePerCastOnHorse or tbInfo.nMinTimePerCastOnHorse <= 0 or tbInfo.nHorseLimited == 1) then
				local nMinTimePerCast = math.max(0, tbInfo.nMinTimePerCast - KFightSkill.GetDecreaseSkillCastTime(tbInfo.nId));
				tbMsg[#tbMsg+1]	= string.format("<color=blue>Khoảng cách thi triển: <color><color=gold>%s giây<color>",
					Frame2Sec(nMinTimePerCast));
			else
				local nMinTimePerCast = math.max(0, tbInfo.nMinTimePerCastOnHorse - KFightSkill.GetDecreaseSkillCastTime(tbInfo.nId));
				tbMsg[#tbMsg+1]	= string.format("<color=blue>Khoảng cách thi triển: <color><color=gold>%s giây<color>\n<color=blue>Cưỡi ngựa thi triển<color>: <color=gold>%s giây<color>",
					Frame2Sec(tbInfo.nMinTimePerCast), Frame2Sec(nMinTimePerCast));
			end;
		end;
	end
	
	if (tbInfo.nMaxMissile > 0) then
		if (tbInfo.nChildSkillNum and tbInfo.nChildSkillNum > 1) then
			tbMsg[#tbMsg+1]	= string.format("<color=blue>Tối đa bố trí được: <color><color=gold> %d <color>", math.floor(tbInfo.nMaxMissile/tbInfo.nChildSkillNum));
		else
			tbMsg[#tbMsg+1]	= string.format("<color=blue>Tối đa bố trí được: <color><color=gold> %d <color>", tbInfo.nMaxMissile);
		end
	end

	self:GetAllMagicsDesc(tbMsg, tbInfo);
	
	if (tbInfo.nAddPercent) then
		tbMsg[#tbMsg+1]	= string.format("Nhận thêm kỹ năng khác: <color=gold>%d%%<color>", tbInfo.nAddPercent);
	end;

	if (tbInfo.nSkillDamageP and tbInfo.nSkillDamageP ~= 100) then
		tbMsg[#tbMsg+1]	= string.format("Thi triển kỹ năng: <color=gold>%d%%<color>", tbInfo.nSkillDamageP);
	end

	if (not tbInfo.tbWholeMagic.appenddamage_p) then
		if (tbInfo.nAppenDamageP and tbInfo.nAppenDamageP >= 0) then
			local szMsg = "";
			local nAppend = tbInfo.nAppenDamageP;
			if (nAppend == 0) then
				szMsg = "<color=gray>Không bị ảnh hưởng bởi đánh thường<color>";
			else
				szMsg = string.format("Phát huy lực đánh thường: <color=gold>%s%%<color>", nAppend);
				if tbInfo.bIsPhysical == 1 then
					szMsg = szMsg.."Tấn công hệ ngoại công";
				elseif tbInfo.bIsPhysical == 0 then
					szMsg = szMsg.."Tấn công hệ nội công";
				end
			end
			tbMsg[#tbMsg+1] = szMsg
		end
	end
	
	if (tbInfo.nChildSkillNum and tbInfo.nChildSkillNum > 0) then
		tbMsg[#tbMsg+1]	= string.format("Số chiêu thức: <color=gold> %d <color>", tbInfo.nChildSkillNum);
	end
	
	if (tbInfo.nMissileHitcount > 0) then
		if (tbInfo.nIsChainLightting == 1) then
			tbMsg[#tbMsg+1]	= string.format("Số liên hoàn: <color=gold>%d lần<color>", tbInfo.nMissileHitcount);
		else	
			tbMsg[#tbMsg+1]	= string.format("Số người ảnh hưởng: <color=gold>mỗi chiêu %d <color>", tbInfo.nMissileHitcount);
		end		
	end
	
	if (tbInfo.nStateTime > 0 and tbInfo.nIsAura ~= 1) then
		if tbInfo.nId ~= 1259 then --隐藏反两仪刀法技能持续时间显示
			tbMsg[#tbMsg+1]	= string.format("<color=white>Duy trì: <color><color=gold>%s giây<color>", Frame2Sec(tbInfo.nStateTime));
		end
	end;
	
	local tbAddMagic = {
		"addskilldamagep",
		"addskilldamagep2",
		"addskilldamagep3",
		"addskilldamagep4",
		"addskilldamagep5",
		"addskilldamagep6",
	};
	for i = 0, #tbAddMagic do
		local tbAdd = tbInfo.tbWholeMagic[tbAddMagic[i]]
		if (tbAdd and tbAdd[3] ==1) then
			tbMsg[#tbMsg+1]	= string.format("<color=green>Tấn công của [%s] thêm: <color><color=Gold>%d%%<color>", KFightSkill.GetSkillName(tbAdd[1]), tbAdd[2]);
		end
	end;

	local tbChild	= {};
	tbInfo.tbChild	= tbChild;
	local tbEvent	= tbInfo.tbEvent;
	if (tbEvent) then
		if (tbEvent.nAddStartSkillId) then
			tbChild[#tbChild+1] = {"\nĐồng thời thi triển:\n%s", tbEvent.nAddStartSkillId, tbEvent.nAddStartSkillLevel};
		elseif (tbEvent.nStartSkillId and tbEvent.nStartSkillId > 0) then
			tbChild[#tbChild+1]	= {"\nĐồng thời thi triển:\n%s", tbEvent.nStartSkillId, tbEvent.nLevel};
		end;

		if (tbEvent.nFlySkillId and tbEvent.nFlySkillId > 0) then
			tbChild[#tbChild+1]	= {"\nĐang duy trì thi triển:\n%s",tbEvent.nFlySkillId, tbEvent.nLevel};
		end;
		if (tbEvent.nCollideSkillId and tbEvent.nCollideSkillId > 0) then
			tbChild[#tbChild+1]	= {"\nKhi bị đánh thi triển:\n%s", tbEvent.nCollideSkillId, tbEvent.nLevel};
		end;
		if (tbEvent.nVanishedSkillId and tbEvent.nVanishedSkillId > 0) then
			tbChild[#tbChild+1]	= {"\nKhi kết thúc thi triển:\n%s", tbEvent.nVanishedSkillId, tbEvent.nLevel};
		end;
		if (tbEvent.HitSkillId and tbEvent.HitSkillId > 0) then
			tbChild[#tbChild+1]	= {"\nKhi trúng mục tiêu thi triển:\n%s", tbEvent.HitSkillId, tbEvent.nLevel};
		end;
	end;
	
	for _, tb in pairs(tbChild) do
		local szName	= KFightSkill.GetSkillName(tb[2]);
		local nLevel	= tb[3];
		if (nLevel and nLevel > 0) then -- 有等级
			szName	= string.format("<color=green>[%s] cấp %d<color>", szName, nLevel);
		else
			nLevel	= tbInfo.nLevel;
		end;
		tbMsg[#tbMsg+1]	= string.format(tb[1], szName);
		local tbChildInfo	= KFightSkill.GetSkillInfo(tb[2], nLevel);
		self:GetDescAboutLevel(tbMsg, tbChildInfo, 0);--子技能不显示消耗和距离的属性
	end;
end;

function tbDefault:GetParamDesc(tbMsg, nParam1, nParam2)
end;

function tbDefault:GetAllMagicsDesc(tbMsg, tbInfo)
	for _,tbMagicGroup in ipairs(FightSkill.MAGIC_DESCS) do
		if (type(tbMagicGroup) == "table") then
			for _, tbMagicDesc in pairs(tbMagicGroup) do
				local szMagicName = tbMagicDesc[1];
				local MagicDesc = tbMagicDesc[2];
				local tbMagicPropList = self:GetMagicProp(tbInfo, szMagicName);
				if (tbMagicPropList) then
					for _, tbMagicProp in ipairs(tbMagicPropList) do
						local szMsg	= FightSkill:GetMagicDesc(szMagicName, tbMagicProp, tbInfo);
						if (szMsg ~= "") then
							tbMsg[#tbMsg+1]	= szMsg;
						end;
					end
				end
			end
		else
			print("Thuộc tính ma pháp chưa chia nhóm");
		end
	end	
end;

function tbDefault:GetMagicProp(tbInfo, szSrcMagicName)
	local tbRet = {};
	
	local tbTotleMagic = 
	{
		tbInfo.tbWholeMagic,
	}
	for _, tbMagicList in pairs(tbTotleMagic) do
		for szMagicName, tbMagicProp in pairs(tbMagicList) do
			if (szMagicName == szSrcMagicName) then
				if (not string.find(szMagicName, "^addskilldamagep%d$") or tbMagicProp[3] == 1) then
					tbRet[#tbRet+1] = tbMagicProp;
				end
			end
		end
	end
	
	if (#tbRet > 0) then
		return  tbRet;
	end
end


function tbDefault:GetAutoDesc(tbAutoInfo, tbSkill)
	tbSkill.tbChild[#tbSkill.tbChild+1]	= {
		string.format("%s thi triển: <color=gold>%%s<color>", (FightSkill.AUTOTYPE_NAME[tbAutoInfo.nType] or tostring(tbAutoInfo.nType))),
		tbAutoInfo.nSkillId,
		tbAutoInfo.nSkillLevel,
	};
	return "";
end;
