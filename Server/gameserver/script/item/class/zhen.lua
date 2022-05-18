

Require("\\script\\item\\class\\equip.lua");


local tbBook = Item:NewClass("zhen", "equip");


function tbBook:GetTip(nState)		-- 获取秘籍Tip

	local szTip = "";
	local nId   = it.GetExtParam(1);

	szTip = szTip..self:Tip_ReqAttrib();
	szTip = szTip..self:Tip_BaseAttrib(nState);

	local nNearSkillId, nMapSkillId, nMaxLevel = GetZhenSkillInfo(nId);

	if (nNearSkillId <= 0) then
		return szTip;
	end

	local szMsg = "<color=cyan>cấp 1<color>";
	if (nMapSkillId > 0) then
		szMsg = szMsg .. "\n<color=green>Hiệu quả toàn bản đồ<color>\n";
		szMsg = szMsg .. self:GetZhenFaSkillInfo(nMapSkillId, 1);
	end;
	if (nNearSkillId > 0) then
		szMsg = szMsg .. "<color=green>Hiệu quả cộng thêm cự ly gần<color>\n";
		szMsg = szMsg .. self:GetZhenFaSkillInfo(nNearSkillId, 1);
	end;

	
	szMsg = szMsg .. string.format("\n<color=cyan>Cấp %s <color>[<color=red>cấp cao nhất<color>]", nMaxLevel);
	if (nMapSkillId > 0) then
		szMsg = szMsg .. "\n<color=green>Hiệu quả toàn bản đồ<color>\n";
		szMsg = szMsg .. self:GetZhenFaSkillInfo(nMapSkillId, nMaxLevel);
	end;
	if (nNearSkillId > 0) then
		szMsg = szMsg .. "<color=green>Hiệu quả cộng thêm cự ly gần<color>\n";
		szMsg = szMsg .. self:GetZhenFaSkillInfo(nNearSkillId, nMaxLevel);
	end;

	szMsg = string.gsub(szMsg, "<color=white>Duy trì: <color><color=gold>%d*giây<color>\n", "");--以后的技能tips中的持续时间格式
	szMsg = string.gsub(szMsg, "Thời gian duy trì: <color=gold>%d*giây<color>\n", "");--现在的技能tips中的持续时间格式
	szTip = szTip..szMsg;
	return szTip;

end

function tbBook:GetZhenFaSkillInfo(nSkillId, nLevel)
	local tbInfo = nil;

	if (nLevel > 0) then
		tbInfo	= KFightSkill.GetSkillInfo(nSkillId, nLevel);
	else
		nLevel	= 0;
	end
	
	if (not tbInfo) then
		return;
	end
	
	local szClassName = tbInfo.szClassName;
	local tbSkill = assert(FightSkill.tbClass[szClassName], "Skill{"..szClassName.."} bot found!");	
	local tbMsg = {};
	tbSkill:GetDescAboutLevel(tbMsg, tbInfo);
	return table.concat(tbMsg, "\n").."\n";
end;

function tbBook:CalcValueInfo()
	local nValue = it.nOrgValue;
	local nStarLevel, szNameColor, szTransIcon = Item:CalcStarLevelInfo(it.nVersion, it.nDetail, it.nLevel, nValue);
	return	nValue, nStarLevel, szNameColor, szTransIcon;
end

