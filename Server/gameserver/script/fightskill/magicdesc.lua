local tbSeriesColor	= {
	[Env.SERIES_NONE]	= "white",
	[Env.SERIES_METAL]	= "gold",
	[Env.SERIES_WOOD]	= "wood",
	[Env.SERIES_WATER]	= "water",
	[Env.SERIES_FIRE]	= "fire",
	[Env.SERIES_EARTH]	= "earth",
};

local function Add1(value1, value2, bEx2)
	if type(value1) == "table" then
		value1 = value1.nPoint;
	end
	if type(value2) == "table" then
		value2 = value2.nPoint;
	end
	if (not value2) or (value1 == value2) then
		local str = "";
		if (value1 > 0) then
			str = "+";
		elseif (value1 < 0) then
			value1 = -value1;
			str = "-";
		end
		str = str..value1;
		return str;
	else
		if (value1 * value2 < 0) then
			assert(false);
			return;
		end
		local str = "";
		if (value2 > 0) then
			str = "+";
		elseif (value2 < 0) then
			value1 = -value1;
			value2 = -value2;
			str = "-";
		end
		return string.format("%s%s%s%s", str, value1, (bEx2 == 1) and "→" or "đến", value2);
	end
end

local function Add2(value1, value2, bEx2)
	if type(value1) == "table" then
		value1 = value1.nPoint;
	end
	if type(value2) == "table" then
		value2 = value2.nPoint;
	end
	if (not value2) or (value1 == value2) then
		local str = "";
		if (value1 > 0) then
			str = "-";
		elseif (value1 < 0) then
			value1 = -value1;
			str = "+";
		end
		str = str..value1;
		return str;
	else
		if (value1 * value2 < 0) then
			assert(false);
			return;
		end
		local str = "";
		if (value2 > 0) then
			str = "-";
		elseif (value2 < 0) then
			value1 = -value1;
			value2 = -value2;
			str = "+";
		end
		return string.format("%s%s%s%s", str, value1, (bEx2 == 1) and "→" or "đến", value2);
	end
end

local function Add3(value1, value2, bEx2)
	if type(value1) == "table" then
		value1 = value1.nPoint;
	end
	if type(value2) == "table" then
		value2 = value2.nPoint;
	end
	if (not value2) or (value1 == value2) then
		local str = "";
		if (value1 > 0) then
			str = "Tăng cường";
		elseif (value1 < 0) then
			str = "Suy yếu";
		end
		str = str..value1;
		return str;
	else
		if (value1 * value2 < 0) then
			assert(false);
			return;
		end
		local str = "";
		if (value2 > 0) then
			str = "Tăng cường";
		elseif (value2 < 0) then
			value1 = -value1;
			value2 = -value2;
			str = "Suy yếu";
		end
		return string.format("%s%s%s%s", str, value1, (bEx2 == 1) and "→" or "đến", value2);
	end
end

local function Add4(value1, value2, bEx2)
	if type(value1) == "table" then
		value1 = value1.nPoint;
	end
	if type(value2) == "table" then
		value2 = value2.nPoint;
	end
	if (not value2) or (value1 == value2) then
		return tostring(value1);
	end
	return string.format("%s%s%s", value1, (bEx2 == 1) and "→" or "đến", value2);
end

local function Add5(value1, value2, bEx2)
	if type(value1) == "table" then
		value1 = value1.nPoint;
	end
	if type(value2) == "table" then
		value2 = value2.nPoint;
	end
	if (not value2) or (value1 == value2) then
		local str = "";
		if (value1 > 0) then
			str = "Lớn";
		elseif (value1 < 0) then
			value1 = -value1;
			str = "Nhỏ";
		end
		str = str..value1;
		return str;
	else
		if (value1 * value2 < 0) then
			assert(false);
			return;
		end
		local str = "";
		if (value2 > 0) then
			str = "Lớn";
		elseif (value2 < 0) then
			value1 = -value1;
			value2 = -value2;
			str = "Nhỏ";
		end
		return string.format("%s%s%s%s", str, value1, (bEx2 == 1) and "→" or "đến", value2);
	end
end

local function Add6(value1, value2, bEx2)
	if type(value1) == "table" then
		value1 = value1.nPoint;
	end
	if type(value2) == "table" then
		value2 = value2.nPoint;
	end
	if (not value2) or (value1 == value2) then
		local str = "";
		if (value1 > 0) then
			str = "Nhỏ";
		elseif (value1 < 0) then
			value1 = -value1;
			str = "Lớn";
		end
		str = str..value1;
		return str;
	else
		if (value1 * value2 < 0) then
			assert(false);
			return;
		end
		local str = "";
		if (value2 > 0) then
			str = "Nhỏ";
		elseif (value2 < 0) then
			value1 = -value1;
			value2 = -value2;
			str = "Lớn";
		end
		return string.format("%s%s%s%s", str, value1, (bEx2 == 1) and "→" or "đến", value2);
	end
end

local function ChangeMagicTableToValue(tbMagic)
	if not tbMagic then
		return nil;
	end
	for i = 2, 4 do
		if tbMagic[i] and type(tbMagic[i]) == "table" then
			tbMagic[i] = tbMagic[i].nPoint;
		end
	end
	return tbMagic;
end

local function Frame2Sec(value)
	if type(value) == "table" then
		value = value.nPoint;
	end
	return math.floor(value / Env.GAME_FPS * 10) / 10; 
end

local function Frame2Sec2(value)
	if type(value) == "table" then
		if value.nType == 1 then
			local nValue = math.floor(value.nPoint / Env.GAME_FPS * 10) / 10;
			if nValue >= 0 then
				return "+" .. nValue .. " giây ";
			else
				return "-" .. -nValue .. " giây ";
			end
		elseif value.nType == 2 then
			if value.nPoint>= 0 then
				return "+" .. value.nPoint .. "%";
			else
				return "-" .. -value.nPoint .. "%";
			end
		elseif value.nType == 3 then
			return "trở thành " .. value.nPoint .. " giây ";
		end
	else
		local nNo = math.floor(value / Env.GAME_FPS * 10) / 10;
		if (nNo >= 0) then
			return "+" .. nNo .. " giây ";
		else
			return "-" .. -nNo .. " giây ";
		end;
	end
	return "Chưa biết";
end;

local function GetSkillName(value)
	if type(value) == "table" then
		value = value.nPoint;
	end
	local szName = KFightSkill.GetSkillName(value);
	local tbTrueName = Lib:SplitStr(szName, "&");
	return tbTrueName[1];
end

local function CastSkill(nSkillId, nLevel)
	local str = "Bao gồm";
	local tbSkillInfo = KFightSkill.GetSkillInfo(nSkillId, nLevel);
	local nActualLevel = me.GetSkillLevel (nSkillId);
	local nSkillLevel = nLevel;
	if (nSkillLevel > nActualLevel) then
		nSkillLevel = nActualLevel;
	end

	if (nSkillLevel < 0) then
		nSkillLevel = 0;
	end
	if nLevel >= 63 then
		str = str.."<color=green>["..tbSkillInfo.szName.."]<color>: <color=gold>"..nSkillLevel.."cấp <color>";
	else
		str = str.."<color=green>["..tbSkillInfo.szName.."]<color>: <color=gold>"..nSkillLevel.."cấp <color>, ".."Tối đa <color=gold>"..nLevel.."cấp <color>";
	end
	return str;
end

local function GetIgnoreAttackDesc(tbSkillInfo)
	if (tbSkillInfo.nLevel > 6) then
		return;
	end;

	local szMsg = "Hóa giải đòn tấn công của người chơi <color=gold>cấp %s và quan hàm thấp hơn<color> với xác suất nhất định";
	local szLevel = tostring(tbSkillInfo.nLevel + 1);
	szMsg = string.format(szMsg, szLevel);

	return szMsg;
end;

local function EnchantDesc(tbMagic)
	if (not tbMagic) then
		return "";
	end;

	local szClassName = SkillEnchant:GetNameById(tbMagic[1]);
	local tbData = SkillEnchant:GetClass(szClassName);
	if (not tbData) then
		return "";
	end;

	local szDesc = "";
	for _, tb in pairs(tbData.tbEnchantData) do
		for szName, tbMgc in pairs(tb.magic) do
			if (type(tbMgc) == "table") then
				local tbData = {};
				tbData[1] = tb.RelatedSkillId;
				if (tbMgc.value1) then
					local tbPoint1 = {};
					for _, tbP in pairs(tbMgc.value1[2]) do
						tbPoint1[#tbPoint1 + 1] = {tbP[1], tbP[2]};
					end;
					tbData[2] = {};
					tbData[2].nType = tbMgc.value1[1];
					tbData[2].nPoint = Lib.Calc:Link(tbMagic[2], tbPoint1);
				end;

				if (tbMgc.value2) then
					local tbPoint2 = {};
					for _, tbP in pairs(tbMgc.value2[2]) do
						tbPoint2[#tbPoint2 + 1] = {tbP[1], tbP[2]};
					end;
					tbData[3] = {};
					tbData[3].nType = tbMgc.value2[1];
					tbData[3].nPoint = Lib.Calc:Link(tbMagic[2], tbPoint2);
				end;

				if (tbMgc.value3) then
					local tbPoint3 = {};
					for _, tbP in pairs(tbMgc.value3[2]) do
						tbPoint3[#tbPoint3 + 1] = {tbP[1], tbP[2]};
					end;
					tbData[4] = {};
					tbData[4].nType = tbMgc.value3[1];
					tbData[4].nPoint = Lib.Calc:Link(tbMagic[2], tbPoint3);
				end;
			
				local szMsg = FightSkill:GetMagicDesc(szName, tbData, nil, nil, true);
				if (szMsg and szMsg ~= "") then
					if (szDesc ~= "") then
						szDesc = szDesc .. "\n";
					end;
					szDesc = szDesc .. szMsg;
				end;
			end;
		end;
	end;
	return szDesc;
end;

local tbSkillParam1_Desc = {
			"Tốc độ xung kích của <color=orange>%s<color>: <color=gold>%s<color>",
			"Cự ly di chuyển nhanh của <color=orange>%s<color>: <color=gold>%s%%<color>",
		}

local function SkillParam1(tbMagic1)
	if tbMagic1 and type(tbMagic1[1]) == "table" then
		tbMagic1[1] = tbMagic1[1].nPoint;
	end
	if tbMagic1 and type(tbMagic1[2]) == "table" then
		tbMagic1[2] = tbMagic1[2].nPoint;
	end
	local nNo = 0;
	if (tbMagic1 and tbMagic1[1] == 41)  then --天王
		nNo = 1;
	elseif (tbMagic1[1] == 64) then
		nNo = 2;
	end;
	if (nNo ~= 0) then
		local szSkillName = GetSkillName(tbMagic1[1]);
		return string.format(
					tbSkillParam1_Desc[nNo],
					szSkillName,
					Add1(tbMagic1[2])
				);
	end;
	return "";
end;

local function MissileRange(tbMagic1)
	tbMagic1 = ChangeMagicTableToValue(tbMagic1);
	assert(tbMagic1[4]);
	local nNo = tbMagic1[2] and 2 or 4;
	local szMsg = ""
	szMsg = string.format(
				"Phạm vị <color=orange>%s<color>-%s: <color=gold>%s ô<color>",
				GetSkillName(tbMagic1[1]),
				((nNo == 4) and "Sát thương" or "Hiệu quả"),
				Add1(tbMagic1[nNo])
			);
	return szMsg;
end;

local function AddedwithEnemyCount(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
	if type(tbMagic1[2]) == "table" then
		tbMagic1[2] = tbMagic1[2].nPoint;
	end
	local szMsg = "Mỗi lần thêm 1 kẻ địch sẽ tăng những thuộc tính sau, ";
	szMsg = szMsg.."Cộng dồn tối đa <color=gold>"..tbMagic1[2].."<color>".."Hiệu quả\n";
	local tbInfo = nil;
	if (tbMagic1[2] > 0) then
		tbInfo	= KFightSkill.GetSkillInfo(tbMagic1[1], tbSkillInfo.nLevel);
	else
		tbMagic1[2]	= 0;
	end
	if (not tbInfo) then
		return;
	end

	local szClassName = tbInfo.szClassName;
	local tbSkill = assert(FightSkill.tbClass[szClassName], "Skill{"..szClassName.."} not found!");
	local tbMsg = {};
	tbSkill:GetDescAboutLevel(tbMsg, tbInfo);
	szMsg = szMsg .. table.concat(tbMsg, "\n").."\n";
	szMsg = string.gsub(szMsg, "Duy trì: <color=gold>%d*.*%d* giây<color>\n", "");
	szMsg = string.gsub(szMsg, "<color=white>Duy trì: <color><color=gold>%d*giây<color>\n", "");--以后的技能tips中的持续时间格式
	return szMsg;
end;



FightSkill.ENCHANT_DESCS =
{
	[1] =
	{
		{"keephide", {"Sử dụng <color=orange>%s<color> không bị mất ẩn thân", {"getskillname", 1}}},
		{"appenddamage_p", {"Phát huy lực tấn công cơ bản của <color=orange>%s<color>: <color=gold>%s%%<color>", {"getskillname", 1}, {"add1", 2}}},
		{"allseriesstateresisttime", {"Thời gian bị trạng thái Ngũ Hành của <color=orange>%s<color>: <color=gold>%s<color>", {"getskillname", 1}, {"add1", 2}}},
		{"state_hurt_resisttime", {"Thời gian <color=orange>%s<color> thọ thương: <color=gold>%s<color>", {"getskillname", 1}, {"add1", 2}}},
		{"state_weak_resisttime", {"Thời gian <color=orange>%s<color> suy yếu: <color=gold>%s<color>", {"getskillname", 1}, {"add1", 2}}},
		{"state_burn_resisttime", {"Thời gian <color=orange>%s<color> bị bỏng: <color=gold>%s<color>", {"getskillname", 1}, {"add1", 2}}},
		{"state_stun_resisttime", {"Thời gian <color=orange>%s<color> bị choáng: <color=gold>%s<color>", {"getskillname", 1}, {"add1", 2}}},
		{"state_slowall_resisttime", {"Thời gian <color=orange>%s<color> làm chậm: <color=gold>%s<color>", {"getskillname", 1}, {"add1", 2}}},
		{"damage_all_resist", {"Kháng tất cả của <color=orange>%s<color>: <color=gold>%s<color>", {"getskillname", 1}, {"add1", 2}}},
		{"state_slowall_attack", {"Xác suất làm chậm của <color=orange>%s<color>: <color=gold>%s%%<color>", {"getskillname", 1}, {"add1", 2}}},
		{"state_palsy_attack", {"Xác suất gây tê liệt của <color=orange>%s<color>: <color=gold>%s%%<color>, duy trì <color=gold>%s giây<color>", {"getskillname", 1}, {"add1", 2}, { "frame2sec", 3}}},
		{"skill_attackradius", {"Cự ly thi triển của <color=orange>%s<color>: <color=gold>%s<color>", {"getskillname", 1}, {"add1", 2}}},
		{"missile_lifetime_v", function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				tbMagic1 = ChangeMagicTableToValue(tbMagic1);
				if (tbMagic1[2] == 0) then
					return "";
				end
				return string.format("Thời gian duy trì của <color=orange>%s<color>: <color=gold>Tăng %s giây<color>", GetSkillName(tbMagic1[1]), Frame2Sec(tbMagic1[2]));
			end
		},
		{"state_fixed_attack", {"<color=orange>%s<color>-Định thân: <color=gold>%s%%<color>, duy trì <color=gold>%s giây<color>", {"getskillname", 1}, {"add1", 2},{"frame2sec", 3}}},	
		{"state_zhican_attack", {"Tỷ lệ chí tàn của <color=orange>%s<color>: <color=gold>%s%%<color>, duy trì <color=gold>%s giây<color>", {"getskillname", 1}, {"add1", 2},{"frame2sec", 3}}},	
		{"skill_mintimepercast_v", {"<color=orange>%s<color>-Giãn cách: <color=gold>%s<color>", {"getskillname", 1}, {"frame2sec2", 2}}},
		{"state_drag_attack", function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				tbMagic1 = ChangeMagicTableToValue(tbMagic1);
				return string.format("<color=orange>%s<color>-Giật lại: <color=gold>%s%%<color>, khoảng cách lớn nhất <color=gold>%d<color>",
					GetSkillName(tbMagic1[1]), 
					tbMagic1[2], 
					tbMagic1[3]*tbMagic1[4]);
			end
		},
		{"state_knock_attack", function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				tbMagic1 = ChangeMagicTableToValue(tbMagic1);
				return string.format("<color=orange>%s<color>-Đánh lui: <color=gold>%s%%<color>, khoảng cách đánh lui <color=gold>%d<color>", 
					GetSkillName(tbMagic1[1]), 
					tbMagic1[2],
					tbMagic1[3]*tbMagic1[4]);
			end
		},
		{"missile_speed_v", {"Tốc độ bay của <color=orange>%s<color>: <color=gold>%s<color>", {"getskillname", 1}, {"add1", 2}}},
		{"skill_missilenum_v",{"Số lượng của <color=orange>%s<color>: <color=gold>%s<color>", {"getskillname", 1}, {"add1", 2}}},
		{"fastmanareplenish_v", {"<color=orange>%s<color> khiến đối thủ mỗi nửa giây hồi phục nội lực: <color=gold>%s điểm<color>", {"getskillname", 1}, {"add1", 2}}},
		{"fastlifereplenish_v", {"Hiệu quả hồi máu của <color=orange>%s<color>: <color=gold>%s%%<color>", {"getskillname", 1}, {"add1", 2}}},
		{"lifemax_p", {"Sinh lực tối đa của <color=orange>%s<color>: <color=gold>%s%%<color>", {"getskillname", 1}, {"add1", 2}}},
		{"manamax_p", {"Nội lực tối đa của <color=orange>%s<color>: <color=gold>%s%%<color>", {"getskillname", 1}, {"add1", 2}}},
		{"ignoreskill", {"Xác suất né tránh hoàn toàn của <color=orange>%s<color>: <color=gold>%s%%<color>", {"getskillname", 1}, {"add1", 2}}},
		{"missile_ablility", {"<color=orange>%s<color> có <color=gold>%s%%<color> xuyên suốt mục tiêu", {"getskillname", 1},  2}},
		{"skill_param1_v",
					function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
			 			return SkillParam1(tbMagic1);
					end
		},
		{"missile_range",
					function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
			 				return MissileRange(tbMagic1);
					end
		},
		{"skill_maxmissile",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				tbMagic1 = ChangeMagicTableToValue(tbMagic1);
				if (tbMagic1[2] == 0) then
					return "";
				end
				return string.format("Bố trí tối đa của <color=orange>%s<color>: <color=gold>+%s<color>", GetSkillName(tbMagic1[1]), tbMagic1[2]);
			end
		},
	}
}

FightSkill.MAGIC_DESCS =
{
	[1] = --攻击力基础&五行相克属性
	{
		{ "seriesdamage_r",
			function(tbMagic, tbSkillInfo, tbMagic2, bEx2)
				local szMsg = "";
				local szSeries = "";
				if (tbMagic[1] == 0) then
					return "";
				end
				szMsg = string.format("Ngũ hành tương khắc: <color=gold>%s<color>", tbMagic[1]);
				if(tbSkillInfo.nSeries ~= 0) then
					szSeries	= string.format("<color=gold>(<color><color=%s>%s<color><color=gold>)<color>", 
							tbSeriesColor[tbSkillInfo.nSeries] or "",
							Env.SERIES_NAME[tbSkillInfo.nSeries] or tostring(tbSkillInfo.nSeries));
				end
				szMsg = szMsg..szSeries;
				return szMsg;
			end
		},
		{ "seriesenhance_r", { "Tấn công người chơi khắc hệ, trị tương khắc của kỹ năng: <color=gold>%s<color>" , { "add1", 1 } } },
		{ "seriesenhance",
			function(tbMagic, tbSkillInfo, tbMagic2, bEx2)
				if (tbMagic[1] == 0) then
					return "";
				end
				return string.format("Cường hóa ngũ hành tương khắc: <color=gold>%s<color> điểm", Add1(tbMagic[1], tbMagic2 and tbMagic2[1], bEx2));
			end
		},
		{ "seriesabate",
			function(tbMagic, tbSkillInfo, tbMagic2, bEx2)
				if (tbMagic[1] == 0) then
					return "";
				end
				return string.format("Nhược hóa ngũ hành tương khắc: <color=gold>%s<color> điểm", Add1(tbMagic[1], tbMagic2 and tbMagic2[1], bEx2));
			end
		},
	},
	[2] = --命中类属性
	{
		{ "attackrating_v", { "Điểm đánh trúng: <color=gold>%s<color>", { "add1", 1 } } },
		{ "attackrating_p", { "Tỷ lệ đánh trúng: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "attackratingenhance_v", { "Điểm đánh trúng: <color=gold>%s<color>", { "add1", 1 } } },
		{ "attackratingenhance_p", { "Tỷ lệ đánh trúng: <color=gold>%s%%<color>", { "add1", 1 } } },
	},
	[3] = --忽略闪避类属性
	{
		{ "ignoredefense_p", { "Bỏ qua né tránh đối thủ: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "ignoredefense_v", { "Bỏ qua né tránh đối thủ: <color=gold>%s<color>", { "add1", 1 } } },
		{ "ignoredefenseenhance_p", { "Bỏ qua né tránh đối thủ: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "ignoredefenseenhance_v", { "Bỏ qua né tránh đối thủ: <color=gold>%s<color>", { "add1", 1 } } },
		{ "ignoreattack",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				return GetIgnoreAttackDesc(tbSkillInfo);
			end}
	},
	[4] = --出招动作属性
	{
		{ "attackspeed_v",  { "Tốc độ xuất chiêu hệ ngoại công: <color=gold>%s<color>", { "add1", 1 } } },
		{ "castspeed_v",  { "Tốc độ xuất chiêu hệ nội công: <color=gold>%s<color>", { "add1", 1 } } },
	},
	[5] = --五行伤害百分比类属性
	{
		{ "physicsenhance_p",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				if (tbMagic1[1] == 0) then
					return "";
				end
				return string.format("Vật công: <color=gold>%s%%<color>", Add1(tbMagic1[1], tbMagic2 and tbMagic2[1], bEx2));
			end
		},
		{ "addphysicsdamage_p", { "Vật công ngoại: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "add_physicpoisondamage_p",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				local szMsg = string.format("Độc công ngoại: <color=gold>%s%%<color>", Add1(tbMagic1[1], tbMagic2 and tbMagic2[1], bEx2));
				if (tbMagic1[2] > 0) then
					szMsg = szMsg.."/nửa giây<color>, duy trì <color=gold>"..frame2sec(tbMagic1[2]).." giây<color>";
				end
				return szMsg;
			end
		},
		{ "add_physiccolddamage_p", { "Băng công ngoại: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "add_physicfiredamage_p", { "Hỏa công ngoại: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "add_physiclightdamage_p", { "Lôi công ngoại: <color=gold>%s%%<color>", { "add1", 1 } } },
		
		{ "addphysicsmagic_p", { "Vật công nội: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "add_magicpoisondamage_p",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				local szMsg = string.format("Độc công nội: <color=gold>%s%%<color>", Add1(tbMagic1[1], tbMagic2 and tbMagic2[1], bEx2));
				if (tbMagic1[2] > 0) then
					szMsg = szMsg.."<color=gold>/nửa giây<color>, duy trì <color=gold>"..frame2sec(tbMagic1[2]).." giây<color>";
				end
				return szMsg;
			end
		},
		{ "add_magiccolddamage_p", { "Băng công nội: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "add_magicfiredamage_p", { "Hỏa công nội: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "add_magiclightdamage_p", { "Lôi công nội: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "reducepercentonmaxhp_p",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				local szMsg = "";
				if tbMagic1[1] > 0 then
					szMsg = szMsg.."Khấu trừ sinh lực tối đa "..tbMagic1[1].."%";
					szMsg = szMsg..(tbMagic1[2]+tbMagic1[3] > 0 and "\n" or "");
				end
				if  tbMagic1[2] > 0 then 
					szMsg = szMsg.."Khấu trừ nội lực tối đa "..tbMagic1[2].."%";
					szMsg = szMsg..(tbMagic1[3] > 0 and "\n" or "");
				end
				if  tbMagic1[3] > 0 then 
					szMsg = szMsg.."Khấu trừ thể lực tối đa "..tbMagic1[3].."%";
				end
				return string.format("<color=red>%s<color>", szMsg);
			end
		},
		{ "reducepercentoncurhp_p",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				local szMsg = "";
				if tbMagic1[1] > 0 then
					szMsg = szMsg.."Khấu trừ sinh lực hiện tại "..tbMagic1[1].."%";
					szMsg = szMsg..(tbMagic1[2]+tbMagic1[3] > 0 and "\n" or "");
				end
				if  tbMagic1[2] > 0 then 
					szMsg = szMsg.."Khấu trừ nội lực hiện tại "..tbMagic1[2].."%";
					szMsg = szMsg..(tbMagic1[3] > 0 and "\n" or "");
				end
				if  tbMagic1[3] > 0 then 
					szMsg = szMsg.."Khấu trừ thể lực hiện tại "..tbMagic1[3].."%";
				end
				return string.format("<color=red>%s<color>", szMsg);
			end
		},
		{ "magic_turnphysicaldammage", { "Tấn công thường chuyển hóa thành tấn công ngũ hành: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "damage_inc_p", 			{ "Gây sát thương: <color=gold>%s%%<color>", { "add5", 1 } } },
	},
	[6] = --五行伤害点数类属性
	{
		{ "physicsdamage_v", { "Vật công: <color=gold>%s đến %s điểm<color>", 1, 3 } },--内功系用
		{ "physicsenhance_v", { "Vật công: <color=gold>%s đến %s điểm<color>", 1, 3 } },
		{ "poisondamage_v", { "Độc công: <color=gold>%s điểm/nửa giây<color>, duy trì <color=gold>%s giây<color>", 1 ,{ "frame2sec", 2}} },
		{ "colddamage_v", { "Băng công: <color=gold>%s đến %s điểm<color>", 1, 3 } },
		{ "firedamage_v", { "Hỏa công: <color=gold>%s đến %s điểm<color>", 1, 3 } },
		{ "lightingdamage_v", { "Lôi công: <color=gold>%s đến %s điểm<color>", 1, 3 } },
		{ "magicdamage_v", { "Ngũ hành công: <color=gold>%s đến %s điểm<color>", 1, 3 } },
		{ "appenddamage_p",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				local szMsg = "";
				local nAppend = tbSkillInfo.nAppenDamageP or tbMagic1[1];
				if (nAppend == 0) then
					szMsg = "<color=gray>Không bị ảnh hưởng bởi đánh thường<color>";
				else
					szMsg = string.format("Phát huy lực tấn công cơ bản: <color=gold>%s%%<color>", nAppend);
					if tbSkillInfo.bIsPhysical == 1 then
						szMsg = szMsg.."Tấn công hệ ngoại công";
					elseif tbSkillInfo.bIsPhysical == 0 then
						szMsg = szMsg.."Tấn công hệ nội công";
					end
				end
				return szMsg;
			end
		},
		
		{ "addphysicsdamage_v", { "Vật công ngoại: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "addpoisondamage_v", { "Độc công ngoại: <color=gold>%s điểm/nửa giây<color>, duy trì <color=gold>%s giây<color>", { "add1", 1 },{ "frame2sec", 2} } },
		{ "addcolddamage_v", { "Băng công ngoại: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "addfiredamage_v", { "Hỏa công ngoại: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "addlightingdamage_v", { "Lôi công ngoại: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "addphysicsmagic_v", { "Vật công nội: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "addpoisonmagic_v", { "Độc công nội: <color=gold>%s điểm/nửa giây<color>, duy trì <color=gold>%s giây<color>", { "add1", 1 },{ "frame2sec", 2} } },
		{ "addcoldmagic_v", { "Băng công nội: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "addfiremagic_v", { "Hỏa công nội: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "addlightingmagic_v", { "Lôi công nội: <color=gold>%s điểm<color>", { "add1", 1 } } },
	},
	[7] = --会心属性_状态用属性
	{
		{ "deadlystrikeenhance_r", { "Chí mạng: <color=gold>%s<color>", { "add1", 1 } } },
		{ "deadlystrikedamageenhance_p", { "Tấn công khi đánh chí mạng: <color=gold>%s%%<color>", { "add1", 1 } } }
	},
	[8] = --五行效果类属性
	{
		{ "state_hurt_attack", { "Xác suất làm thọ thương: <color=gold>%s%%<color>, duy trì <color=gold>%s giây<color>",1,{ "frame2sec", 2} } },
		{ "state_weak_attack", { "Xác suất làm suy yếu: <color=gold>%s%%<color>, duy trì <color=gold>%s giây<color>", 1,{ "frame2sec", 2} } },
		{ "state_slowall_attack",
			 function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
			 	local nRate = tbMagic1[1];
			 	local szInfo = string.format("Xác suất làm chậm: <color=gold>%s%%<color>, duy trì <color=gold>%s giây<color>",
			 		nRate, Frame2Sec(tbMagic1[2]));

			 	return szInfo;
			end
		},
		{ "state_burn_attack", { "Xác suất gây bỏng: <color=gold>%s%%<color>, duy trì <color=gold>%s giây<color>", 1,{ "frame2sec", 2} } },
		{ "state_stun_attack", { "Xác suất gây choáng: <color=gold>%s%%<color>, duy trì <color=gold>%s giây<color>", 1,{ "frame2sec", 2} } },
		{ "seriesstate_added", 
			 function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				local tbMsg = {
						"Tỷ lệ gây thọ thương: +<color=gold>",
						"Tỷ lệ suy nhược: +<color=gold>",
						"Tỷ lệ làm chậm: +<color=gold>",
						"Tỷ lệ bỏng: +<color=gold>",
						"Tỷ lệ choáng: +<color=gold>",
						"Gây hiệu quả ngũ hành tương ứng: Tăng <color=gold>",
					};
				local nSeries = me.nSeries;
				if (nSeries >  6 or nSeries <=0) then
					nSeries = 6;
				end;
			 	local szMsg = tbMsg[nSeries]..tbMagic1[1].."<color>";
			 	return szMsg;
			end
		},
	},

	[9] = --其他负面效果类属性
	{
		{ "state_fixed_attack", { "Xác suất gây bất động: <color=gold>%s%%<color>, duy trì <color=gold>%s giây<color>", 1,{ "frame2sec", 2}  } },
		{ "state_palsy_attack", { "Xác suất gây tê liệt: <color=gold>%s%%<color>, duy trì <color=gold>%s giây<color>", 1,{ "frame2sec", 2}  } },
		{ "state_slowrun_attack", { "Xác suất gây giảm tốc độ chạy: <color=gold>%s%%<color>, duy trì <color=gold>%s giây<color>", 1,{ "frame2sec", 2}  } },
		{ "state_freeze_attack", { "Xác suất gây đóng băng: <color=gold>%s%%<color>, duy trì <color=gold>%s giây<color>", 1,{ "frame2sec", 2}  } },
		{ "state_confuse_attack",  { "Xác suất gây hỗn loạn: <color=gold>%s%%<color>, duy trì <color=gold>%s giây<color>", 1,{ "frame2sec", 2}  } },
		{ "state_knock_attack",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				return string.format("Xác suất gây tấn công đẩy lùi: <color=gold>%s%%<color>, cự ly đánh lui <color=gold>%s<color>",
					tbMagic1[1],
					tbMagic1[2] * tbMagic1[3]);
			end
		},
		{ "state_drag_attack",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				return string.format("Tỷ lệ bị giật lại: <color=gold>%s%%<color>, khoảng cách lớn nhất <color=gold>%s<color>",
					tbMagic1[1],
					tbMagic1[2] * tbMagic1[3]);
			end
		},
		{ "state_silence_attack",  { "Xác suất gây bất lực: <color=gold>%s%%<color>, duy trì <color=gold>%s giây<color>", 1,{ "frame2sec", 2}  } },
		{ "state_zhican_attack",  { "Tỷ lệ tạo thành chí tàn: <color=gold>%s%%<color>, duy trì <color=gold>%s giây<color>", 1,{ "frame2sec", 2}  } },
		{ "state_float_attack",  { "Tỷ lệ tạo thành phù không: <color=gold>%s%%<color>, duy trì <color=gold>%s giây<color>", 1,{ "frame2sec", 2}  } },
		{ "locked_state",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				local szMsg = "";
				if tbMagic1[1] == 1 then
					szMsg = szMsg.."Không thể di chuyển";
					szMsg = szMsg..(tbMagic1[2]+tbMagic1[3] > 0 and "\n" or "");
				end
				if  tbMagic1[2] == 1 then 
					szMsg = szMsg.."Không thể sử dụng kỹ năng";
					szMsg = szMsg..(tbMagic1[3] > 0 and "\n" or "");
				end
				if  tbMagic1[3] == 1 then 
					szMsg = szMsg.."Không thể sử dụng đạo cụ";
				end
				return string.format("<color=red>%s<color>", szMsg);
			end
		},
	},
	[10] = --偷取类属性
	{
		{ "steallife_p",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				local szMsg = (tbMagic1[2] < 100) and (Add4(tbMagic1[2], tbMagic2 and tbMagic2[2], bEx2).."% gây cho ") or "";
				szMsg = szMsg.." sát thương <color=gold>";
				szMsg = szMsg..((tbMagic1[1] >= 0) and Add4( tbMagic1[1],  tbMagic2 and tbMagic2[1], bEx2) or Add4(-tbMagic1[1],  tbMagic2 and -tbMagic2[1], bEx2));
				szMsg = szMsg.."%<color> chuyển hóa thành sinh lực"..((tbMagic1[1] >= 0) and "Trả lời" or "Tổn thất");
				return szMsg;
			end
		},
		{ "stealmana_p",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				local szMsg = (tbMagic1[2] < 100) and (Add4(tbMagic1[2], tbMagic2 and tbMagic2[2], bEx2).."% gây cho ") or "";
				szMsg = szMsg.." sát thương <color=gold>";
				szMsg = szMsg..((tbMagic1[1] >= 0) and Add4( tbMagic1[1],  tbMagic2 and tbMagic2[1], bEx2) or Add4(-tbMagic1[1],  tbMagic2 and -tbMagic2[1], bEx2));
				szMsg = szMsg.."%<color> chuyển hóa thành nội lực"..((tbMagic1[1] >= 0) and "Trả lời" or "Tổn thất");
				return szMsg;
			end
		},
		{ "stealstamina_p",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				local szMsg = (tbMagic1[2] < 100) and (Add4(tbMagic1[2], tbMagic2 and tbMagic2[2], bEx2).."% gây cho ") or "";
				szMsg = szMsg.." sát thương <color=gold>";
				szMsg = szMsg..((tbMagic1[1] >= 0) and Add4( tbMagic1[1],  tbMagic2 and tbMagic2[1], bEx2) or Add4(-tbMagic1[1],  tbMagic2 and -tbMagic2[1], bEx2));
				szMsg = szMsg.."%<color> chuyển hóa thành thể lực"..((tbMagic1[1] >= 0) and "Trả lời" or "Tổn thất");
				return szMsg;
			end
		},
		{ "steallifeenhance_p",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				local szMsg = (tbMagic1[2] < 100) and (Add4(tbMagic1[2], tbMagic2 and tbMagic2[2], bEx2).."% gây cho ") or "";
				szMsg = szMsg.." sát thương <color=gold>";
				szMsg = szMsg..((tbMagic1[1] >= 0) and Add4( tbMagic1[1],  tbMagic2 and tbMagic2[1], bEx2) or Add4(-tbMagic1[1],  tbMagic2 and -tbMagic2[1], bEx2));
				szMsg = szMsg.."%<color> chuyển hóa thành sinh lực"..((tbMagic1[1] >= 0) and "Trả lời" or "Tổn thất");
				return szMsg;
			end
		},
		{ "stealmanaenhance_p",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				local szMsg = (tbMagic1[2] < 100) and (Add4(tbMagic1[2], tbMagic2 and tbMagic2[2], bEx2).."% gây cho ") or "";
				szMsg = szMsg.." sát thương <color=gold>";
				szMsg = szMsg..((tbMagic1[1] >= 0) and Add4( tbMagic1[1],  tbMagic2 and tbMagic2[1], bEx2) or Add4(-tbMagic1[1],  tbMagic2 and -tbMagic2[1], bEx2));
				szMsg = szMsg.."%<color> chuyển hóa thành nội lực"..((tbMagic1[1] >= 0) and "Trả lời" or "Tổn thất");
				return szMsg;
			end
		},
		{ "stealstaminaenhance_p",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				local szMsg = (tbMagic1[2] < 100) and (Add4(tbMagic1[2], tbMagic2 and tbMagic2[2], bEx2).."% gây cho ") or "";
				szMsg = szMsg.." sát thương <color=gold>";
				szMsg = szMsg..((tbMagic1[1] >= 0) and Add4( tbMagic1[1],  tbMagic2 and tbMagic2[1], bEx2) or Add4(-tbMagic1[1],  tbMagic2 and -tbMagic2[1], bEx2));
				szMsg = szMsg.."%<color> chuyển hóa thành thể lực"..((tbMagic1[1] >= 0) and "Trả lời" or "Tổn thất");
				return szMsg;
			end
		},
	},
	[11] = --五行抗性类属性_状态用属性
	{
		{ "damage_all_resist",  { "Kháng tất cả: <color=gold>%s<color>", { "add1", 1 } } },
		{ "damage_physics_resist",  { "Kháng vật công: <color=gold>%s<color>", { "add1", 1 } } },
		{ "damage_poison_resist",  { "Kháng độc công: <color=gold>%s<color>", { "add1", 1 } } },
		{ "damage_cold_resist",  { "Kháng băng công: <color=gold>%s<color>", { "add1", 1 } } },
		{ "damage_fire_resist",  { "Kháng hỏa công: <color=gold>%s<color>", { "add1", 1 } } },
		{ "damage_light_resist",  { "Kháng lôi công 111: <color=gold>%s<color>", { "add1", 1 } } },
		{ "damage_series_resist",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				local tbResist = { "Kháng vật công", "Kháng hỏa công", "Kháng băng công", "Kháng lôi công 222", "Kháng độc công" };
				local szResist = tbResist[tbMagic1[3] + 1];
				if not szResist then
					return string.format("Kháng ngũ hành tương ứng: <color=gold>%s<color>", Add1(tbMagic1[1], tbMagic2 and tbMagic2[1], bEx2));
				end
				return string.format("%s: <color=gold>%s<color>", szResist, Add1(tbMagic1[1], tbMagic2 and tbMagic2[1], bEx2));
			end
		},
		{ "damage_physics_receive_p", { "Chịu sát thương vật lý: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "damage_poison_receive_p",  { "Chịu sát thương độc công: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "damage_cold_receive_p",  { "Chịu sát thương băng công: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "damage_fire_receive_p",  { "Chịu sát thương hỏa công: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "damage_light_receive_p",  { "Chịu sát thương lôi công: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "physicsresmax_p",  { "Kháng vật công tối đa: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "coldresmax_p",  { "Kháng băng công tối đa: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "fireresmax_p",  { "Kháng hỏa công tối đa: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "lightingresmax_p",  { "Kháng lôi công tối đa: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "poisonresmax_p",  { "Kháng độc công tối đa: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "allresmax_p",  { "Kháng tất cả tối đa: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "damage_return_receive_p",  { "Kháng phản đòn thọ thương: <color=gold>%s%%<color>", { "add2", 1 } } },
		{ "npcdamageadded", {"Sát thương quái: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "ignoreresist_p", {"Tỷ lệ bỏ qua kháng <color=gold>%s%%<color>: <color=gold>%s%%<color>", 1, { "add1", 2 }}},
		{ "redeivedamage_dec_p", 	{ "Chịu sát thương: <color=gold>%s%%<color>", { "add6", 1 } } },
		{ "redeivedamage_dec_p2", 	{ "Sát thương ngũ hành: <color=gold>%s%%<color>", { "add6", 1 } } },
		{ "defence_level",  { "Kháng linh hoạt: <color=gold>%s<color>\n<color=gray>  Tấn công địch có kháng linh hoạt nhỏ hơn hoặc bằng bản thân, nếu mở rộng sát thương càng hiệu quả hơn.<color>", { "add1", 1 }} },
	},
	[12] = --抵抗五行效果时间类属性
	{
		{ "state_hurt_resisttime",  { "Thời gian bị thương: <color=gold>%s<color>", { "add2", 1 } } },
		{ "state_weak_resisttime",  { "Thời gian bị yếu: <color=gold>%s<color>", { "add2", 1 } } },
		{ "state_slowall_resisttime", { "Thời gian bị làm chậm: <color=gold>%s<color>", { "add2", 1 } } },
		{ "state_burn_resisttime",  { "Thời gian bị bỏng: <color=gold>%s<color>", { "add2", 1 } } },
		{ "state_stun_resisttime",  { "Thời gian bị choáng: <color=gold>%s<color>", { "add2", 1 } } },
		{ "allseriesstateresisttime",  { "Thời gian bị trạng thái ngũ hành: <color=gold>%s<color>", { "add2", 1 } } },
	},
	[13] = --抵抗其他负面效果时间类属性
	{
		{ "state_fixed_resisttime",  { "Thời gian bị bất động: <color=gold>%s<color>", { "add2", 1 } } },
		{ "state_palsy_resisttime",  { "Thời gian bị tê liệt: <color=gold>%s<color>", { "add2", 1 } } },
		{ "state_slowrun_resisttime", { "Thời gian bị giảm tốc độ chạy: <color=gold>%s<color>", { "add2", 1 } } },
		{ "state_freeze_resisttime",  { "Thời gian bị đóng băng: <color=gold>%s<color>", { "add2", 1 } } },
		{ "state_confuse_resisttime", { "Thời gian bị hỗn loạn: <color=gold>%s<color>", { "add2", 1 } } },
		{ "state_knock_resisttime",  { "Thời gian bị tấn công đẩy lùi: <color=gold>%s<color>", { "add2", 1 } } },
		{ "state_drag_resisttime",  { "Thời gian bị kéo lại: <color=gold>%s<color>", { "add2", 1 } } },
		{ "state_silence_resisttime",  { "Thời gian bị bất lực: <color=gold>%s<color>", { "add2", 1 } } },
		{ "allspecialstateresisttime",  { "Thời gian bị trạng thái bất lợi: <color=gold>%s<color>", { "add2", 1 } } },
	},
	[14] = --抵抗五行效果几率类属性
	{
		{ "state_hurt_resistrate",  { "Xác suất bị thương: <color=gold>%s<color>", { "add2", 1 } } },
		{ "state_weak_resistrate",  { "Xác suất bị suy yếu: <color=gold>%s<color>", { "add2", 1 } } },
		{ "state_slowall_resistrate", { "Xác suất bị làm chậm: <color=gold>%s<color>", { "add2", 1 } } },
		{ "state_burn_resistrate",  { "Xác suất bị bỏng: <color=gold>%s<color>", { "add2", 1 } } },
		{ "state_stun_resistrate",  { "Xác suất bị choáng: <color=gold>%s<color>", { "add2", 1 } } },
		{ "allseriesstateresistrate",  { "Xác suất bị trạng thái ngũ hành: <color=gold>%s<color>", { "add2", 1 } } },
	},
	[15] = --抵抗其他负面效果几率类属性
	{
		{ "state_fixed_resistrate",  { "Xác suất bị bất động: <color=gold>%s<color>", { "add2", 1 } } },
		{ "state_palsy_resistrate",  { "Xác suất bị tê liệt: <color=gold>%s<color>", { "add2", 1 } } },
		{ "state_slowrun_resistrate", { "Xác suất bị giảm tốc độ chạy: <color=gold>%s<color>", { "add2", 1 } } },
		{ "state_freeze_resistrate",  { "Xác suất bị đóng băng: <color=gold>%s<color>", { "add2", 1 } } },
		{ "state_confuse_resistrate", { "Xác suất bị hỗn loạn: <color=gold>%s<color>", { "add2", 1 } } },
		{ "state_knock_resistrate",  { "Xác suất bị tấn công đẩy lùi: <color=gold>%s<color>", { "add2", 1 } } },
		{ "state_drag_resistrate",  { "Xác suất bị kéo lại: <color=gold>%s<color>", { "add2", 1 } } },
		{ "state_silence_resistrate",  { "Xác suất bị bất lực: <color=gold>%s<color>", { "add2", 1 } } },
		{ "allspecialstateresistrate",  { "Xác suất bị trạng thái bất lợi: <color=gold>%s<color>", { "add2", 1 } } },
	},
	[16] = --加成造成五行效果时间类属性
	{
		{ "state_hurt_attacktime",  { "Thời gian gây thọ thương: <color=gold>%s<color>", { "add1", 1 } } },
		{ "state_weak_attacktime",  { "Thời gian gây suy yếu: <color=gold>%s<color>", { "add1", 1 } } },
		{ "state_slowall_attacktime", { "Thời gian gây làm chậm: <color=gold>%s<color>", { "add1", 1 } } },
		{ "state_burn_attacktime",  { "Thời gian gây bỏng: <color=gold>%s<color>", { "add1", 1 } } },
		{ "state_stun_attacktime",  { "Thời gian gây choáng: <color=gold>%s<color>", { "add1", 1 } } },
		{ "seriesstate_time_added",  { "Thời gian tạo ra trạng thái ngũ hành: <color=gold>%s<color>", { "add1", 1 } } },
	},
	[17] = --加成造成其他负面效果时间类属性
	{
		{ "state_fixed_attacktime",  { "Thời gian gây bất động: <color=gold>%s<color>", { "add1", 1 } } },
		{ "state_palsy_attacktime",  { "Thời gian gây tê liệt: <color=gold>%s<color>", { "add1", 1 } } },
		{ "state_slowrun_attacktime", { "Thời gian gây giảm tốc độ chạy: <color=gold>%s<color>", { "add1", 1 } } },
		{ "state_freeze_attacktime",  { "Thời gian gây đóng băng: <color=gold>%s<color>", { "add1", 1 } } },
		{ "state_confuse_attacktime", { "Thời gian gây hỗn loạn: <color=gold>%s<color>", { "add1", 1 } } },
		{ "state_knock_attacktime",  { "Thời gian gây tấn công đẩy lùi: <color=gold>%s<color>", { "add1", 1 } } },
		{ "state_drag_attacktime",  { "Thời gian gây kéo lại: <color=gold>%s<color>", { "add1", 1 } } },
		{ "state_silence_attacktime",  { "Thời gian gây bất lực: <color=gold>%s<color>", { "add1", 1 } } },
	},
	[18] = --加成造成五行效果几率类属性
	{
		{ "state_hurt_attackrate",  { "Tỷ lệ gây thọ thương: <color=gold>%s<color>", { "add1", 1 } } },
		{ "state_weak_attackrate",  { "Tỷ lệ gây suy yếu: <color=gold>%s<color>", { "add1", 1 } } },
		{ "state_slowall_attackrate", { "Tỷ lệ gây làm chậm: <color=gold>%s<color>", { "add1", 1 } } },
		{ "state_burn_attackrate",  { "Tỷ lệ gây bỏng: <color=gold>%s<color>", { "add1", 1 } } },
		{ "state_stun_attackrate",  { "Tỷ lệ gây choáng: <color=gold>%s<color>", { "add1", 1 } } },
	},
	[19] = --加成造成其他负面效果几率类属性
	{
		{ "state_fixed_attackrate",  { "Tỷ lệ gây bất động: <color=gold>%s<color>", { "add1", 1 } } },
		{ "state_palsy_attackrate",  { "Tỷ lệ gây tê liệt: <color=gold>%s%<color>", { "add1", 1 } } },
		{ "state_slowrun_attackrate", { "Tỷ lệ gây giảm tốc độ chạy: <color=gold>%s<color>", { "add1", 1 } } },
		{ "state_freeze_attackrate",  { "Tỷ lệ gây đóng băng: <color=gold>%s<color>", { "add1", 1 } } },
		{ "state_confuse_attackrate", { "Tỷ lệ gây hỗn loạn: <color=gold>%s<color>", { "add1", 1 } } },
		{ "state_knock_attackrate",  { "Tỷ lệ gây tấn công đẩy lùi: <color=gold>%s<color>", { "add1", 1 } } },
		{ "state_drag_attackrate",  { "Tỷ lệ gây kéo lại: <color=gold>%s<color>", { "add1", 1 } } },
		{ "state_silence_attackrate",  { "Tỷ lệ gây bất lực: <color=gold>%s<color>", { "add1", 1 } } },
	},
	[20] = --免疫五行效果类属性
	{
		{ "state_hurt_ignore",  { "Hóa giải và miễn nhiễm sát thương" } },
		{ "state_weak_ignore",  { "Hóa giải và miễn nhiễm suy yếu" } },
		{ "state_slowall_ignore",  { "Hóa giải và miễn nhiễm làm chậm" } },
		{ "state_burn_ignore",  { "Hóa giải và miễn nhiễm bỏng" } },
		{ "state_stun_ignore",  { "Hóa giải và miễn nhiễm choáng" } },
	},
	[21] = --清除并免疫其它负面效果类属性
	{
		{ "state_fixed_ignore",  { "Hóa giải và miễn nhiễm bất động" } },
		{ "state_palsy_ignore",  { "Hóa giải và miễn nhiễm tê liệt" } },
		{ "state_slowrun_ignore",  { "Hóa giải và miễn nhiễm giảm tốc độ chạy" } },
		{ "state_freeze_ignore",  { "Hóa giải và miễn nhiễm đóng băng" } },
		{ "state_confuse_ignore",  { "Hóa giải và miễn nhiễm hỗn loạn" } },
		{ "state_knock_ignore",  { "Hóa giải và miễn nhiễm tấn công đầy lùi" } },
		{ "state_drag_ignore",  { "Hóa giải và miễn nhiễm kéo lại" } },
		{ "state_silence_ignore",  { "Hóa giải và miễn nhiễm bất lực" } },
		{ "ignoredebuff",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				local tbValue2 = {};
				local tbState = {
						[0]	= "Thọ thương",
						[1] = "Suy yếu",
						[2] = "Làm chậm",
						[3] = "Bỏng",
						[4] = "Choáng",
						[5] = "Bất động ",
						[6] = "Tê liệt",
						[7] = "Giảm tốc",
						[8] = "Đóng băng",
						[9] = "Hỗn loạn",
						[10] = "Đánh lui",
						[11] = "Lôi kéo",
						[12] = "Bất lực",
						[13] = "Chí tàn",
						[14] = "Phù không",
					};
				local nValue = tbMagic1[1]
				do
					local i = 0
					repeat
						if nValue == 2*math.floor(nValue/2) then
							tbValue2[i] = 0
							nValue = math.floor(nValue/2)
							i = i+1
						else
							tbValue2[i] = 1
							nValue = math.floor(nValue/2)
							i = i+1
						end
					until nValue == 0
				end
				local szMsg = "";
				local nNum = #tbValue2;
				do
					local bS1,bS2 = 1,1;
					for i=0,4 do
						bS1 = tbValue2[i] and bS1*tbValue2[i] or 0;
					end
					if bS1 == 1 then
						szMsg = szMsg..((szMsg~="" )and "\n" or "").."<color=gold>Hóa giải và miễn nhiễm trạng thái ngũ hành<color>";
						for i=0,4 do
							tbValue2[i] = 0;
						end
					end
					
					for i=5,14 do
						bS2 = tbValue2[i] and bS2*tbValue2[i] or 0;
					end
					if bS2 == 1 then
						szMsg = szMsg..((szMsg~="") and "\n" or "").."<color=gold>Hóa giải và miễn nhiễm trạng thái bất lợi<color>";
						for i=5,14 do
							tbValue2[i] = 0;
						end
					end
				end
				
				for i =0, nNum do
					if tbValue2[i] == 1 then
						szMsg = szMsg..((szMsg~="") and "\n" or "").."<color=gold>Thanh trừ và miễn dịch"..(tbState[i] or "Chưa rõ").."<color>";
					end
				end
				return string.format("%s", szMsg);
			end
		},
	},
	[22] = --闪避类属性_状态用属性
	{
		{ "adddefense_v", { "Né tránh: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "adddefense_p", { "Né tránh: <color=gold>%s%%<color>", { "add1", 1 } } },
	},
	[23] = --受攻击反弹类属性
	{
		{ "meleedamagereturn_v",  { "Phản đòn cận chiến: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "meleedamagereturn_p",  { "Phản đòn cận chiến: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "rangedamagereturn_v",  { "Phản đòn tầm xa: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "rangedamagereturn_p",  { "Phản đòn tầm xa: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "poisondamagereturn_v",  { "Phản đòn khi bị sát thương độc: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "poisondamagereturn_p",  { "Phản đòn khi bị sát thương độc: <color=gold>%s%%<color>", { "add1", 1 } } },
	},
	[24] = --命、内、体最大值类属性
	{
		{ "lifemax_v",  { "Sinh lực tối đa: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "lifemax_p",
			 function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
			 	local nLifeMax = tbMagic1[1];
				return string.format("Tỉ lệ sinh lực tối đa: <color=gold>Tăng %s%%<color>", nLifeMax);
			 end
		},
		{ "manamax_v",  { "Nội lực tối đa: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "manamax_p",
			 function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
			 	local nManaMax = tbMagic1[1];
				return string.format("Tỉ lệ nội lực tối đa: <color=gold>Tăng %s%%<color>", nManaMax);
			 end
		},
		{ "staminamax_v",  { "Thể lực tối đa: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "staminamax_p",  { "Tỷ lệ thể lực tối đa: <color=gold>%s%%<color>", { "add1", 1 } } },
	},
	[25] = --命、内、体回复类属性
	{
		{ "lifereplenish_v",  { "Mỗi 5 giây hồi phục sinh lực: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "fastlifereplenish_v",
			 function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
			 	local nLifeUp = 0;
			 	if (not tbSkillInfo) then
			 		nLifeUp = tbMagic1[1];
			 	else
			 		nLifeUp = tbMagic1[1];
			 	end
				return string.format("Mỗi nửa giây hồi phục sinh lực: <color=gold>%s điểm<color>", nLifeUp);
			 end
		},
		{ "manareplenish_v",  { "Mỗi 5 giây hồi phục nội lực: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "fastmanareplenish_v",  { "Mỗi nửa giây hồi phục nội lực: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "staminareplenish_v",  { "Mỗi 5 giây hồi phục thể lực: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "faststaminareplenish_v",  { "Mỗi nửa giây hồi phục thể lực: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "lifepotion_v",  { "Mỗi nửa giây hồi phục sinh lực: <color=gold>%s điểm<color>, duy trì <color=gold>%s giây<color>", { "add1", 1 },{ "frame2sec", 2} } },
		{ "manapotion_v",  { "Mỗi nửa giây hồi phục nội lực: <color=gold>%s điểm<color>, duy trì <color=gold>%s giây<color>", { "add1", 1 },{ "frame2sec", 2} } },
		{ "lifereplenish_p",  { "Hiệu suất hồi phục sinh lực: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "manareplenish_p",  { "Hiệu suất hồi phục nội lực: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "lifegrow_v",  { "Mỗi nửa giây hồi phục sinh lực: <color=gold>%s điểm<color>, duy trì <color=gold>%s giây<color>", { "add1", 1 },{ "frame2sec", 2} } },
		{ "managrow_v",  { "Mỗi nửa giây hồi phục nội lực: <color=gold>%s điểm<color>, duy trì <color=gold>%s giây<color>", { "add1", 1 },{ "frame2sec", 2} } },
		{ "staminagrow_v", { "Mỗi nửa giây hồi phục thể lực: <color=gold>%s điểm<color>, duy trì <color=gold>%s giây<color>", { "add1", 1 },{ "frame2sec", 2} } },
	},
	[26] = --其他杂七杂八属性
	{
		{ "magic_calldummy",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				return string.format("Tỷ lệ người chơi bị thương: <color=gold>%s%%<color><enter>Tỷ lệ quái bị thương: <color=gold>%s%%<color>",
					tbMagic1[2]/10 * 4,
					tbMagic1[2]/10);
			end
		},
		{ "destory_missile",  { "Tỷ lệ bị kỹ năng bay đánh trúng không thể tiếp tục gây sát thương: <color=gold>%s%%<color>", 1 } },
		{ "weapondamagemin_v",  { "Tấn công ngoại tối thiểu: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "weapondamagemax_v",  { "Tấn công ngoại tối đa: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "weaponmagicmin_v",  { "Tấn công nội tối thiểu: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "weaponmagicmax_v",  { "Tấn công nội tối đa: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "weaponbasedamagetrim",  { "Tấn công cơ bản của vũ khí: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "armordefense_v",  { "Né tránh: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "expenhance_p",  { "Kinh nghiệm giết địch: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "expxiuwei_v",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				return string.format("Luyện nhận được   Còn <color=gold>%s<color> điểm", me.GetTask(1023, 4));
			end
		},
		{ "knockback_p",  { "Xác suất tấn công đẩy lùi: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "drag_p",  { "Xác suất tấn công kéo lại: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "stun_p",  { "Xác suất tấn công gây hôn mê: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "life_v",  { "Sinh lực hiện tại: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "mana_v",  { "Nội lực hiện tại: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "stamina_v",  { "Hồi phục thể lực: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "strength_v",  { "Sức mạnh: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "dexterity_v",  { "Thân pháp: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "vitality_v",  { "Ngoại công: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "energy_v",  { "Nội công: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "poisonres_p",  { "Độc phòng: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "fireres_p",  { "Hỏa phòng:  <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "lightingres_p",  { "Lôi phòng: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "physicsres_p",  { "Vật phòng: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "coldres_p",  { "Băng phòng: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "freezetimereduce_p",  { "Thời gian làm chậm: <color=gold>%s%%<color>", { "add2", 1 } } },
		{ "poisontimereduce_p",  { "Thời gian trúng độc: <color=gold>%s%%<color>", { "add2", 1 } } },
		{ "poisontimeenhance_p",  { "Thời gian duy trì độc: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "poisondamagereduce_v",  { "Độc sát: <color=gold>%s<color>", { "add2", 1 } } },
		{ "stuntimereduce_p",  { "Thời gian choáng: <color=gold>%s%%<color>", { "add2", 1 } } },
		{ "fastwalkrun_v",  { "Tốc độ di chuyển: <color=gold>%s<color>", { "add1", 1 } } },
		{ "fastwalkrun_p",
			function(tbMagic, tbSkillInfo, tbMagic2, bEx2)
				if (tbMagic[1] == 0) then
					return "";
				end
				return string.format("Tốc độ di chuyển: <color=gold>%s%%<color>", Add1(tbMagic[1], tbMagic2 and tbMagic2[1], bEx2));
			end
		},
		{ "fasthitrecover_v",  { "Thời gian thọ thương: <color=gold>%s<color>", { "add2", 1 } } },
		{ "allres_p",  { "Kháng tất cả: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "slowmissile_b",  { "Giảm tốc khí công" } },
		{ "changecamp_b",  { "Mê hoặc đối thủ" } },
		{ "physicsarmor_v",  { "Vật lý hộ giáp: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "coldarmor_v",  { "Băng hộ giáp: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "firearmor_v",  { "Hỏa hộ giáp: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "poisonarmor_v",  { "Độc hộ giáp: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "lightingarmor_v",  { "Điện hộ giáp: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "damage2addmana_p",  { "Chịu sát thương chuyển hóa thành nội lực: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "lucky_v",  { "May mắn: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "lucky_v_partner",  { "May mắn: <color=gold>%s điểm<color>", { "add1", 1 } } },
		{ "allskill_v",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				if (FightSkill.MAGIC_INVALID == tbMagic1[3]) then
					local tbAddSkillType = {
							[0] = "Toàn bộ",	--0
							[1] = "Phái",	--1
							[2] = "Bí kíp",	--2
							[3] = "Đồng hành",	--4
							[4] = "Có thể kích hoạt thêm thuộc tính trang bị",	--5
							[5] = "Chưa thể kích hoạt thêm thuộc tính trang bị",	--5
						};
					local szMsg = "";
					for i=0,31 do
						if tbMagic1[2] == 5 then
							szMsg = szMsg..tbAddSkillType[4];--Co the kham nam
							return szMsg;
						elseif tbMagic1[2] == 6 then
							szMsg = szMsg..tbAddSkillType[5];--Khong the kham nam
							return szMsg;
						elseif tbMagic1[2] == 0 then
							szMsg = szMsg..tbAddSkillType[0];
							break;
						end
						if Lib:LoadBits(tbMagic1[2],i,i) ==1 then
							if szMsg == "" then
								szMsg = tbAddSkillType[i+1];
							else
								szMsg = szMsg.." và "..tbAddSkillType[i+1];
							end
						end
					end;
					szMsg = string.format("Kỹ năng %s: <color=gold>Cấp %s<color>",szMsg, Add1(tbMagic1[1], tbMagic2 and tbMagic2[1], bEx2));
					return szMsg;
				end
				local szSkillName	= GetSkillName(tbMagic1[3]);
				return string.format(
					"<color=blue>%s<color> cấp: <color=gold>%s<color>",
					szSkillName,
					Add1(tbMagic1[1], tbMagic2 and tbMagic2[1], bEx2)
				);
			end
		},
		{ "metalskill_v",  { "Cấp võ công hệ Kim: <color=gold>Cấp %s<color>", { "add1", 1 } } },
		{ "woodskill_v",  { "Cấp võ công hệ Mộc: <color=gold>Cấp %s<color>", { "add1", 1 } } },
		{ "waterskill_v",  { "Cấp võ công hệ Thủy: <color=gold>Cấp %s<color>", { "add1", 1 } } },
		{ "fireskill_v",  { "Cấp võ công hệ Hỏa: <color=gold>Cấp %s<color>", { "add1", 1 } } },
		{ "earthskill_v",  { "Cấp võ công hệ Thổ: <color=gold>Cấp %s<color>", { "add1", 1 } } },
		{ "knockback_p",  { "Xác suất tấn công đẩy lùi: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "drag_p",  { "Xác suất tấn công kéo lại: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "badstatustimereduce_v",  { "Thời gian duy trì trạng thái xấu: <color=gold>%s giây<color>", { "add2", 1 } } },
		{ "manashield_p",  { "Khi nội lực lớn hơn 15%% dùng nội lực hút sát thương: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "fatallystrikeenhance_p",  { "Xác suất tấn công chí mạng:  <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "coldenhance_p",  { "Thời gian làm chậm: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "fireenhance_p",  { "Hỏa sát tối đa: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "lightingenhance_p",  { "Lôi sát tối đa: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "poisonenhance_p",  { "Giãn cách độc phát: <color=gold>%s%%<color>", { "add2", 1 } } },
		{ "magicenhance_p",  { "Sát thương ngũ hành: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "knockbackenhance_p",  { "Xác suất đánh trúng đẩy lùi: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "dragenhance_p",  { "Xác suất đánh trúng kéo lại: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "stunenhance_p",  { "Xác suất đánh trúng gây choáng: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "fatallystrikeres_p",  { "Lực kháng chí mạng: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "dynamicmagicshield_v",  { "Hóa giải sát thương: <color=gold>%s điểm<color>, không vượt quá sát thương ban đầu <color=gold>%s%%<color>", { "add1", 1 },2 } },
		{ "posionweaken",  { "Hóa giải sát thương độc: <color=gold>%s điểm<color>, không vượt quá <color=gold>%s%%<color> sát thương ban đầu", { "add1", 1 },2 } },
		{ "staticmagicshieldcur_p",  { "Dùng toàn bộ nội lực chuyển hóa thành khiên tương đương <color=gold>%s%%<color> nội lực đã mất để kháng sát thương, tối thiểu phải giữ lại 15%% nội lực<enter>Duy trì: <color=gold>%s giây<color>", 1, { "frame2sec", 2}  } },
		{ "addstealfeatureskill",  { "Kỹ năng ngụy trang còn: <color=gold>%s lần<color>", 1 } },
		{ "ignoreskill",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				local nRateMin = tbMagic1[1];
				local nRateMax;
				if (tbMagic2 and tbMagic2[1]) then
					nRateMax = tbMagic2[1];
				end
				local tbIgnoreString = {
						[1] = string.format(
								"Xác suất <color=gold>%s%%<color> giải <color=gold>%s<color> bùa, xác suất <color=gold>%s%%<color> miễn nhiễm bùa",
								KFightSkill.GetMissileRate(tbSkillInfo.nId, tbSkillInfo.nLevel),
								Add4(tbMagic1[2], tbMagic2 and tbMagic2[2], bEx2),
								Add4(tbMagic1[1], tbMagic2 and tbMagic2[1], bEx2)
								),
						[2] = string.format("Xác suất <color=gold>%s%%<color> tránh công nội", Add4(nRateMin, nRateMax, bEx2)),
						[3] = string.format("Xác suất <color=gold>%s%%<color> tránh công nội ngoại", Add4(nRateMin, nRateMax, bEx2)),
						[4] = string.format("Xác suất <color=gold>%s%%<color> tránh công ngoại", Add4(nRateMin, nRateMax, bEx2)),
						[5] = string.format("Xác suất <color=gold>%s%%<color> nhận trạng thái tránh cạm bẫy hoàn toàn", KFightSkill.GetMissileRate(tbSkillInfo.nId, tbSkillInfo.nLevel)),
						[6] = string.format("Xác suất <color=gold>%s%%<color> tránh tấn công tầm xa", Add4(nRateMin, nRateMax, bEx2)),
						[7] = string.format("Dùng <color=gold>%s%%<color> né tránh tất cả tấn công", Add4(nRateMin, nRateMax, bEx2)),
						[8] = string.format("Có xác suất <color=gold>%s%%<color> né tránh kỹ năng vô hiệu của npc", Add4(nRateMin, nRateMax, bEx2)),
					};
				if tbIgnoreString[tbMagic1[3]] then
					return tbIgnoreString[tbMagic1[3]];
				else
					print("[ERROR]unknown ignoreskill style:", tbMagic1[3]);
					return "";
				end
			end
		},
		{ "ignore_skillstyle_bydist",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				return string.format(
					"Tỷ lệ né tránh hoàn toàn nội ngoại công: <color=gold>(Khoảng cách 2 bên/%s)%%<color>",
					tbMagic1[1]/100)
			end
		},
		{ "returnskill_p",  { "Xác suất phản đòn bùa chú: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "poison2decmana_p",  { "Khiến mục tiêu bị độc sát với xác suất <color=gold>%s%%<color> tổn thất nội lực, duy trì <color=gold>#f2-giây<color>", 1 } },
		{ "hide",
			 function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
			 	local nLastTime = tbMagic1[2] + KFightSkill.GetAddSkillHideTime(tbSkillInfo.nId);
			 	if (tbMagic1[3] == 1) then
					return string.format(
						"Ẩn thân <color=gold>%s giây<color>, đồng đội thấy, hiện hình sau khi thi triển võ công",
						Frame2Sec(nLastTime)
					);
				elseif (tbMagic1[3] == 2) then
					return string.format(
						"Ẩn thân <color=gold>%s giây<color>, cùng phe thấy, hiện hình sau khi thi triển võ công",
						Frame2Sec(nLastTime)
					);
				end
				return "";
			end
		},
		{ "keephide",
			 function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
			 	if (tbMagic1[1] == 1) then
					return string.format("Kỹ năng này không phá vỡ trạng thái ẩn thân");
				end
			end
		},
		{ "clearnegativestate",  { "Xác suất <color=gold>%s%%<color> giải trừ trạng thái khác thường cho người chơi phe ta trong phạm vi nhất định", 1 } },
		{ "prop_invincibility",  { "Không bị sát thương" } },
		{ "fatallystrike_p",  { "Xác suất chí mạng: <color=gold>%s%%, bỏ qua kháng %s", 1, 3 } },
		{ "revive",
			function(tbMagic, tbSkillInfo, tbMagic2, bEx2)
				return string.format(
					"Xác suất <color=gold>%s%%<color> hồi sinh và hồi phục sinh lực <color=gold>%s%%<color>, nội lực <color=gold>%s%%<color>, thể lực <color=gold>%s%%<color>",
					KFightSkill.GetMissileRate(tbSkillInfo.nId, tbSkillInfo.nLevel),
					Add4(tbMagic[1], tbMagic2 and tbMagic2[1], bEx2),
					Add4(tbMagic[2], tbMagic2 and tbMagic2[2], bEx2),
					Add4(tbMagic[3], tbMagic2 and tbMagic2[3], bEx2)
				);
			end
		},
		{ "ignorecurse",  { "Xác suất <color=gold>%s%%<color> giải <color=gold>%s bùa<color> và miễn nhiễm bùa", 1, 3 } },
		{ "ignoreinitiative",
			function(tbMagic, tbSkillInfo, tbMagic2, bEx2)
				return string.format(
					"Xác suất <color=gold>%s%%<color> giải trừ <color=gold>%s kỹ năng hỗ trợ chủ động <color> và không nhận được kỹ năng đồng dạng",
					KFightSkill.GetMissileRate(tbSkillInfo.nId, tbSkillInfo.nLevel),
					Add4(tbMagic[1], tbMagic2 and tbMagic2[1], bEx2)
				);
			end
		},
		{ "prop_showhide",  { "Có thể phát hiện đối thủ ẩn thân" } },
		{ "prop_ignoretrap",  { "Xác suất %s%% không thi triển cạm bẫy", 1 } },
		{ "prop_evadeattack",  { "Xác suất %s%% né tránh tấn công và hiệu ứng kèm theo", 1 } },
		{ "suddendeath",  { "Mục tiêu bị trạng thái này sau <color=gold>%s giây<color> sẽ có tỷ lệ <color=gold>%s%%<color> bị trọng thương tức thì", { "frame2sec", 2}, 1 } },
		{ "infectcurse",
			function(tbMagic, tbSkillInfo, tbMagic2, bEx2)
				return string.format(
					"Xác suất <color=gold>%d%%<color> lây <color=gold>%s<color> bùa chú của mình sang đối thủ kế cận\nMỗi lần lây tối đa ảnh hưởng <color=gold>%d<color> mục tiêu",
					KFightSkill.GetMissileRate(tbSkillInfo.nId, tbSkillInfo.nLevel),
					Add4(tbMagic[1], tbMagic2 and tbMagic2[1], bEx2),
					tbSkillInfo.tbWholeMagic["missile_hitcount"][1]
				);
			end
		},
		{ "infectpoison",  { "Lây độc công <color=gold>%s%%<color>", 1 } },
		{ "subexplose",  { "Kinh nghiệm trọng thương tổn thất: <color=gold>%s%%<color>", { "add2", 1 } } },
		{ "addexpshare",  { "Nhận được kinh nghiệm khi đồng đội đánh quái: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "skill_appendskill",  { "%s", { "castskill", 1, 2} } },
		{ "skill_appendskill2",  { "%s", { "castskill", 1, 2} } },
		{ "skill_appendskill3",  { "%s", { "castskill", 1, 2} } },
		{ "skill_appendskill4",  { "%s", { "castskill", 1, 2} } },
		{ "skill_appendskill5",  { "%s", { "castskill", 1, 2} } },
		{ "skill_appendskill6",  { "%s", { "castskill", 1, 2} } },
		{ "ignoreattackontime",  { "Cách mỗi <color=gold>%s giây<color> bỏ qua nửa giây tấn công", { "frame2sec", 1 } } },
		{ "skilldamageptrim",  { "Phát huy lực tấn công cơ bản: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "skillselfdamagetrim",  { "Phát huy lực tấn công kỹ năng: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "defencedeadlystrikedamagetrim",  { "Chịu sát thương chí mạng: <color=gold>%s%%<color>", { "add2", 1 } } },
		{ "wastemanap",  { "Hút nội lực mục tiêu: <color=gold>%s%%<color>", 1 } },
		{ "rdclifewithdis",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				return string.format("Sát thương căn cứ cự ly di chuyển trong mỗi nửa giây\nPhát huy sức tấn công cơ bản: <color=gold>Cự ly di chuyển * %s%%<color>, không vượt quá <color=gold>%s%%<color>",
					tbMagic1[1] / 100, math.floor(tbMagic1[1] / 100 * tbMagic1[2]));
			end
		},
		{ "addmagicbydist",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				local tbState = {
					[0]	= "Thọ thương",
					[1] = "Suy yếu",
					[2] = "Làm chậm",
					[3] = "Bỏng",
					[4] = "Choáng",
					[5] = "Bất động ",
					[6] = "Tê liệt",
					[7] = "Giảm tốc",
					[8] = "Đóng băng",
					[9] = "Hỗn loạn",
					[10] = "Đánh lui",
					[11] = "Lôi kéo",
					[12] = "Bất lực",
					[13] = "Chí tàn",
					[14] = "Phù không",
					};
				return string.format("<color=gold>%s<color>Thời gian: <color=gold>(Khoảng cách 2 bên /%s)%%<color>, tối đa không vượt quá <color=gold>%s%%<color>",
					tbState[tbMagic1[1]], tbMagic1[2] / 100, math.floor(tbMagic1[3] / tbMagic1[2] * 100));
			end
		},
		{ "clear_cd",  { "Xóa giãn cách thi triển của tất cả võ công"} },
		{ "runattack_damageadded",  { "Tấn công sau mỗi lần chạm mục tiêu: <color=gold>%s%%<color>", { "add1", 1 } } },
		{ "addedwith_enemycount",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				return AddedwithEnemyCount(tbMagic1, tbSkillInfo, tbMagic2, bEx2);
			end;
		},
		{ "attackenhancebycostmana_p",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				return string.format("Tăng tổng lực tấn công <color=gold>(Phần trăm nội lực hiện tại * %s%%)<color>",
					tbMagic1[1]);
			end
		},
		{ "missile_random",
			 function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
			 	if (tbMagic1[2] == 0) then
					return string.format(
						"Tỷ lệ xuất hiện mỗi chiêu thức: <color=gold>%s%%<color>",
						tbMagic1[1]
					);
				elseif (tbMagic1[2] == 1) then
					return string.format(
						"Tất cả chiêu thức ngẫu nhiên xuất hiện <color=gold>%s%%<color>",
						tbMagic1[1]
					);
				else
					return string.format("Chưa biết loại hình xuất hiện đạn ngẫu nhiên");
				end
				return "";
			end
		},
		{ "superposemagic",  { "Cộng dồn tối đa: <color=gold>%s lần<color>", 1} },
		{ "disguise_part_base", 
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				if Item.szResPart[tbMagic1[2]] then
					return string.format("Có thể thay đổi bề ngoài của %s", Item.szResPart[tbMagic1[2]]);
				end				
				return "";
			end
		},
		{ "disguise_part_effect", ""}
	},
	[27] = -- 对其他技能加成属性
	{
		{ "changecdtype", 
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				local szMsg = string.format("<color=orange>%s<color> dùng hình thức thay đổi: ",GetSkillName(tbMagic1[1]));
				if (tbMagic1[3]~=0) then
					szMsg = szMsg.."\n    Số lần có thể dùng trong thời gian chờ: <color=gold>"..(tbMagic1[3]/100).." lần<color>"
				end;
				szMsg = szMsg.."\n    Số lần dùng tối đa: <color=gold>"..(math.floor(tbMagic1[2]/100)).." lần<color>";
				return szMsg;
			end
		},
		{ "changecdtype2", 
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				local szMsg = string.format("<color=orange>%s<color> dùng hình thức thay đổi: ",GetSkillName(tbMagic1[1]));
				if (tbMagic1[3]~=0) then
					szMsg = szMsg.."\n    Số lần có thể dùng trong thời gian chờ: <color=gold>"..(tbMagic1[3]/100).." lần<color>"
				end;
				szMsg = szMsg.."\n    Số lần dùng tối đa: <color=gold>"..(math.floor(tbMagic1[2]/100)).." lần<color>";
				return szMsg;
			end
		},
		{ "changecdtype3", 
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				local szMsg = string.format("<color=orange>%s<color> dùng hình thức thay đổi: ",GetSkillName(tbMagic1[1]));
				if (tbMagic1[3]~=0) then
					szMsg = szMsg.."\n    Số lần có thể dùng trong thời gian chờ: <color=gold>"..(tbMagic1[3]/100).." lần<color>"
				end;
				szMsg = szMsg.."\n    Số lần dùng tối đa: <color=gold>"..(math.floor(tbMagic1[2]/100)).." lần<color>";
				return szMsg;
			end
		},
		{ "changecdtype4", 
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				local szMsg = string.format("<color=orange>%s<color> dùng hình thức thay đổi: ",GetSkillName(tbMagic1[1]));
				if (tbMagic1[3]~=0) then
					szMsg = szMsg.."\n    Số lần có thể dùng trong thời gian chờ: <color=gold>"..(tbMagic1[3]/100).." lần<color>"
				end;
				szMsg = szMsg.."\n    Số lần dùng tối đa: <color=gold>"..(math.floor(tbMagic1[2]/100)).." lần<color>";
				return szMsg;
			end
		},
		{ "recover_usepoint", 
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				return string.format(
					"Số lần <color=orange>%s<color> có thể dùng: ",
					GetSkillName(tbMagic1[1]),
					tbMagic1[2]/100
				);
			end
		},
		{"addmissilenum", {"Số lượng của <color=orange>%s<color>: <color=gold>%s<color>", {"getskillname", 1}, {"add1", 2}}},
		{"addrestorelife", {"Hiệu quả hồi máu của <color=orange>%s<color>: <color=gold>%s%%<color>", {"getskillname", 1}, {"add1", 2}}},
		{"addmaxlife", {"Sinh lực tối đa của <color=orange>%s<color>: <color=gold>%s%%<color>", {"getskillname", 1}, {"add1", 3}}},
		{"addmaxmana", {"Nội lực tối đa của <color=orange>%s<color>: <color=gold>%s%%<color>", {"getskillname", 1}, {"add1", 3}}},
		{"addmissilerange", {"Phạm vi hiệu quả của <color=orange>%s<color>: <color=gold>%s ô<color>", {"getskillname", 1}, {"add1", 2}}},
		{"addmissilerange2", {"Phạm vi hiệu quả của <color=orange>%s<color>: <color=gold>%s ô<color>", {"getskillname", 1}, {"add1", 2}}},
		{"addmissilerange3", {"Phạm vi hiệu quả của <color=orange>%s<color>: <color=gold>%s ô<color>", {"getskillname", 1}, {"add1", 2}}},
		{"addmissilerange4", {"Phạm vi hiệu quả của <color=orange>%s<color>: <color=gold>%s ô<color>", {"getskillname", 1}, {"add1", 2}}},
		{"addmissilerange5", {"Phạm vi hiệu quả của <color=orange>%s<color>: <color=gold>%s ô<color>", {"getskillname", 1}, {"add1", 2}}},
		{"addmissilerange6", {"Phạm vi hiệu quả của <color=orange>%s<color>: <color=gold>%s ô<color>", {"getskillname", 1}, {"add1", 2}}},
		{"addskillslowstaterate", {"Xác suất làm chậm của <color=orange>%s<color>: <color=gold>%s%%<color>", {"getskillname", 1}, {"add1", 3}}},
		{"addskillcastrange", {"Cự ly thi triển của <color=orange>%s<color>: <color=gold>%s<color>", {"getskillname", 1}, {"add1", 3}}},
		{"addrunattackspeed", {"Tốc độ xung kích của <color=orange>%s<color>: <color=gold>%s<color>", {"getskillname", 1}, {"add1", 3}}},
		{"addmoveposdistance", {"Cự ly di chuyển nhanh của <color=orange>%s<color>: <color=gold>%s%%<color>", {"getskillname", 1}, {"add1", 2}}},
		{"addmissilespeed", {"Tốc độ bay của <color=orange>%s<color>: <color=gold>%s<color>", {"getskillname", 1}, {"add1", 3}}},
		{"addignoreskillrate", {"Xác suất né tránh hoàn toàn của <color=orange>%s<color>: <color=gold>%s%%<color>", {"getskillname", 1}, {"add1", 3}}},
		{"addmissilelifetime", {"Thời gian duy trì của <color=orange>%s<color>: <color=gold>Tăng %s giây<color>", {"getskillname", 1}, {"frame2sec", 3}}},
		{"adddragspeed", {"Tốc độ kéo người của <color=orange>%s<color>: <color=gold>%s<color>", {"getskillname", 1}, {"add1", 3}}},
		{"addmissilecolrange", {"Phạm vi va chạm của <color=orange>%s<color>: <color=gold>%s ô<color>", {"getskillname", 1}, {"add1", 2}}},
		{"addmissiledamagerange", {"Phạm vi sát thương của <color=orange>%s<color>: <color=gold>%s ô<color>", {"getskillname", 1}, {"add1", 2}}},
		{"addskillhidetime",    { "Thời gian ẩn thân của <color=orange>%s<color>: <color=gold>Tăng %s giây<color>", {"getskillname", 1}, { "frame2sec", 2}}},
		{"decreaseskillcasttime", {"Thời gian giãn cách thi triển của <color=orange>%s<color>: <color=gold>Giảm %s giây<color>", {"getskillname", 1}, {"frame2sec", 2}}},
		{"decautoskillcdtime", {"Thời gian giãn cách xuất hiện của <color=orange>%s<color>: <color=gold>Giảm %s giây<color>", {"getskillname", 1}, {"frame2sec", 3}}},
		{"addmissilethroughrate", {"<color=orange>%s<color> có <color=gold>%s%%<color> xuyên suốt mục tiêu", {"getskillname", 1},  2}},
		{"addpowerwhencol", {"<color=orange>%s<color> lực tấn công sau mỗi lần xuyên suốt mục tiêu <color=gold>%s%%<color>, cộng dồn tối đa <color=gold>%s%%<color>", {"getskillname", 1},  {"add1", 2}, 3}},
		{"addrangewhencol", {"<color=orange>%s<color> phạm vi hiệu quả sau mỗi lần xuyên suốt mục tiêu <color=gold>%s ô<color>, cộng dồn tối đa <color=gold>%s ô<color>", {"getskillname", 1},  {"add1", 2}, 3}},
		{"stealstate", {"Ngẫu nhiên đánh cắp 1 trạng thái hỗ trợ <color=gold>cấp %s cao nhất<color> của kẻ địch không phải quái vật\nTiếp tục thi triển trạng thái đánh cắp cho mục tiêu là bản thân hoặc đồng đội.", 3}},
		{"stealskillstate", {"Đã đánh cắp trạng thái thành công, tiếp tục thi triển trạng thái đánh cắp"}},
		{"addfastmanareplenish_v", {"<color=orange>%s<color> khiến đối thủ mỗi nửa giây hồi phục nội lực: <color=gold>%s điểm<color>", {"getskillname", 1}, {"add1", 2}}},
		{"addignoreskill",
			function(tbMagic1, tbSkillInfo, tbMagic2, bEx2)
				if (tbMagic1[3] == 1) then
					return string.format(
						"Giúp <color=orange>%s<color> có xác suất <color=gold>%s%%<color> giải <color=gold>%s<color> bùa, xác suất <color=gold>%s%%<color> miễn nhiễm bùa",
						KFightSkill.GetMissileRate(tbSkillInfo.nId, tbSkillInfo.nLevel),
						Add4(tbMagic1[2], tbMagic2 and tbMagic2[2], bEx2),
						Add4(tbMagic1[1], tbMagic2 and tbMagic2[1], bEx2)
					);
				elseif (tbMagic1[3] == 2) then
					return string.format(
						"Giúp <color=orange>%s<color> tránh công nội <color=gold>%s%%<color>",
						GetSkillName(tbMagic1[1]),
						Add4(tbMagic1[2], tbMagic2 and tbMagic2[2], bEx2)
					);
				elseif (tbMagic1[3] == 3) then
					return string.format(
						"Giúp <color=orange>%s<color> tránh công nội ngoại <color=gold>%s%%<color>",
						GetSkillName(tbMagic1[1]),
						Add4(tbMagic1[2], tbMagic2 and tbMagic2[2], bEx2)
					);
				end
				print("[ERROR]unknown ignoreskill style:", tbMagic1[3]);
				return "";
			end
		},
		{"addenchant",
			function(tbMagic, tbSkillInfo, tbMagic2, bEx2)
				return EnchantDesc(tbMagic, tbSkillInfo, tbMagic2, bEx2);
			end;
		},
		{ "addstartskill",
			function(tbMagic, tbSkillInfo, tbMagic2, bEx2)
				local tbMsg = {};
				local tbChildInfo	= KFightSkill.GetSkillInfo(tbMagic[2], tbMagic[3]);
				FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
				local szSkillInfo = table.concat(tbMsg, "\n").."\n";
				if (tbMagic[1] == 182 and tbMagic[2] == 1660) then
					return string.format("");
				else
					return string.format(
						"<color=orange>%s<color> đồng thời thi triển: <color=green>%s %s-cấp<color>\n%s",
						GetSkillName(tbMagic[1]), GetSkillName(tbMagic[2]), tbMagic[3],
						szSkillInfo
					);
				end
			end
		},
		{ "addflyskill",
			function(tbMagic, tbSkillInfo, tbMagic2, bEx2)
				local tbMsg = {};
				local tbChildInfo	= KFightSkill.GetSkillInfo(tbMagic[2], tbMagic[3]);
				FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
				local szSkillInfo = table.concat(tbMsg, "\n").."\n";
				return string.format(
					"Trong khi dùng <color=orange>%s<color> thi triển: <color=green>%s  %s-cấp<color>\n%s",
					GetSkillName(tbMagic[1]), GetSkillName(tbMagic[2]), tbMagic[3],
					szSkillInfo
				);
			end
		},
		{ "addvanishskill",
			function(tbMagic, tbSkillInfo, tbMagic2, bEx2)
				local tbMsg = {};
				local tbChildInfo	= KFightSkill.GetSkillInfo(tbMagic[2], tbMagic[3]);
				FightSkill:GetClass("default"):GetDescAboutLevel(tbMsg, tbChildInfo, 0);
				local szSkillInfo = table.concat(tbMsg, "\n").."\n";
				return string.format(
					"<color=orange>%s<color> kết thúc thi triển: <color=green>%s %s-cấp<color>\n%s",
					GetSkillName(tbMagic[1]), GetSkillName(tbMagic[2]), tbMagic[3],
					szSkillInfo
				);
			end
		},
		},
	[28] = --触发自动释放技能类属性
	{
		{ "autoskill",
			function(tbMagic, tbSkillInfo, tbMagic2, bEx2)
				local tbAutoInfo	= KFightSkill.GetAutoInfo(tbMagic[1], tbMagic[2]);
				local szClassName	= (tbSkillInfo and tbSkillInfo.szClassName) or "default";
				return FightSkill.tbClass[szClassName]:GetAutoDesc(tbAutoInfo, tbSkillInfo);
			end,
		},
	},
	[29] = -- 激活效果
	{
		{"active_all_ornament", "Kích hoạt thuộc tính ẩn của trang sức"},
		{"active_all_hide_attrib", "Kích hoạt thuộc tính ẩn toàn bộ trang bị"},
		{"active_suit",
			function(tbMagic, tbSkillInfo, tbMagic2, bEx2)
				local tbSuiteAttrib = KItem.GetPlayerGreenSuiteAttrib(me, tbMagic[1]);
				if tbSuiteAttrib then
					return string.format("<color=gold>Kích hoạt <color=green>%s<color>-<color=green>%d<color> thuộc tính trang bị<color>", tbSuiteAttrib.szName, tbMagic[2]);
				end
				return "";
			end,
		},
	},
	[30] =
	{
		{"missle_range", {"Phạm vi hiệu quả của <color=orange>%s<color>: <color=gold>%s ô<color>"}},
	}
}

FightSkill.tbStr2Fun =
{
	["add1"]		= Add1,
	["add2"]		= Add2,
	["add3"]		= Add3,
	["add4"]		= Add4,
	["add5"]		= Add5,
	["add6"]		= Add6,
	["frame2sec"]	= Frame2Sec,
	["frame2sec2"]	= Frame2Sec2,
	["castskill"]	= CastSkill,
	["getskillname"]	= GetSkillName,
};

function FightSkill:ParingDesc(tbParams, tbMagicData)
	local strDescSrc = tbParams[1];
	local strResult = "";
	local strNow = strDescSrc;
	local strTrans = {strDescSrc};
	local nCount = 1;
	local nFindCur = 0;
	while (true) do

		nFindCur = string.find(strDescSrc,"%%s", nFindCur + 1);
		if (not nFindCur) then
			break;
		end

		nCount = nCount + 1;
		strTrans[nCount] = "";
		if (type(tbParams[nCount]) == "table") then

			local funPas = {};
			for i = 1, #tbParams[nCount] - 1 do
				funPas[i] = tbMagicData[tbParams[nCount][i+1]];
			end
			if (#funPas < 1) then
				return "";
			end;

			if (type(tbParams[nCount][1]) == "string") then
				if (type(self.tbStr2Fun[tbParams[nCount][1]]) == "function") then
					strTrans[nCount] = self.tbStr2Fun[tbParams[nCount][1]](unpack(funPas));
				else
					print("FightSkill:ParingDesc can not find func", tbParams[nCount][1]);
				end
			elseif (type(tbParams[nCount][1]) == "table") then
				strTrans[nCount] = tbParams[nCount][1][funPas[1]] or tostring(funPas[1]);
			end

		else
			if type(tbMagicData[tbParams[nCount]]) == "table" then
				strTrans[nCount] = tbMagicData[tbParams[nCount]].nPoint;
			else
				strTrans[nCount] = tbMagicData[tbParams[nCount]];
			end
			

		end

	end

	if (not strTrans)then
		print("FightSkill:ParingDesc strTrans is nill");
		return "null";
	end
	return string.format(unpack(strTrans));

end

function FightSkill:GetMagicDesc(szMagicName, tbMagicData, tbSkillInfo, bNoColor, bEnchantMagic)
	local szMsg = "";
	if (bEnchantMagic and bEnchantMagic == true) then
		local tbMagicDesc = self:GetEnchantMaigcDesc(szMagicName);
		for _, varMagicDesc in pairs(tbMagicDesc) do
			local szDesc = "";
			if (not varMagicDesc) and (szMagicName ~= "") then
				print(string.format("magic[%s] not found!", tostring(szMagicName)));
				szDesc = "";
			elseif (type(varMagicDesc) == "table") then
				local tbParams	= { varMagicDesc[1] };
				for i = 2, #varMagicDesc do
					tbParams[i]	= varMagicDesc[i];
				end
				szDesc = self:ParingDesc(tbParams, tbMagicData, tbSkillInfo);
			elseif (type(varMagicDesc) == "function") then
				szDesc = varMagicDesc(tbMagicData, tbSkillInfo);
			elseif (type(varMagicDesc) == "string") then
				szDesc = ""..varMagicDesc;
			end
			if (szDesc and szDesc ~= "") then
				if (szMsg ~= "") then
				szMsg = szMsg .. "\n";
				end;
				szMsg = szMsg .. szDesc;
			end;
		end;
	else
		local szDesc = "";
		local varMagicDesc = self:GetOriginalMagicDesc(szMagicName);
		if (not varMagicDesc) and (szMagicName ~= "") then
			print(string.format("magic[%s] not found!", tostring(szMagicName)));
			return	"";
		end

		if (type(varMagicDesc) == "table") then
			local tbParams	= { varMagicDesc[1] };
			for i = 2, #varMagicDesc do
				tbParams[i]	= varMagicDesc[i];
			end
			szDesc = self:ParingDesc(tbParams, tbMagicData, tbSkillInfo);
		elseif (type(varMagicDesc) == "function") then
			szDesc = varMagicDesc(tbMagicData, tbSkillInfo);
		elseif (type(varMagicDesc) == "string") then
			szDesc = ""..varMagicDesc;
		end
		if (szDesc and szDesc ~= "") then
			szMsg = szMsg .. szDesc;
		end;
	end;

	if (1 ~= bNoColor) then
		return	szMsg;
	end

	return	string.gsub(szMsg, "<color([^>]*)>", "");

end

function FightSkill:GetOriginalMagicDesc(szDescMagicName)
	for _,tbMagicGroup in ipairs(FightSkill.MAGIC_DESCS) do
		if (type(tbMagicGroup) == "table") then
			for _, tbMagicDesc in pairs(tbMagicGroup) do
				local szMagicName = tbMagicDesc[1];
				local MagicDesc = tbMagicDesc[2];
				if (szMagicName == szDescMagicName) then
					return MagicDesc;
				end
			end
		end
	end
end

function FightSkill:GetEnchantMaigcDesc(szDescMagicName)
	local tbDesc = {};
	for _,tbMagicGroup in ipairs(FightSkill.ENCHANT_DESCS) do
		if (type(tbMagicGroup) == "table") then
			for _, tbMagicDesc in pairs(tbMagicGroup) do
				local szMagicName = tbMagicDesc[1];
				local MagicDesc = tbMagicDesc[2];
				if (szMagicName == szDescMagicName) then
					tbDesc[#tbDesc + 1] = MagicDesc;
				end
			end
		end
	end
	return tbDesc;
end;

function FightSkill:GetExtentMagicDesc(szMagicName, tbMagicDataLow, tbMagicDataHigh, bEx2)

	local varMagicDesc = self:GetOriginalMagicDesc(szMagicName);
	local szDesc = "";

	if (not varMagicDesc) and (szMagicName ~= "") then
		print(string.format("magic[%s] not found!", tostring(szMagicName)));
		return	"";
	end

	if (type(varMagicDesc) == "table") then
		local tbParams	= { varMagicDesc[1] };
		for i = 2, #varMagicDesc do
			tbParams[i]	= varMagicDesc[i];
		end
		szDesc = self:ParingExtentDesc(tbParams, tbMagicDataLow, tbMagicDataHigh, bEx2);
	elseif (type(varMagicDesc) == "function") then
		szDesc = varMagicDesc(tbMagicDataLow, tbSkillInfo, tbMagicDataHigh, bEx2);
	elseif (type(varMagicDesc) == "string") then
		szDesc = ""..varMagicDesc;
	end

	if bEx2 == 1 then
		szDesc = string.gsub(szDesc, "<color([^>]*)>", "");
		szDesc = string.gsub(szDesc, "→", "<color=gold>→<color>");
	end

	return szDesc;

end

function FightSkill:ParingExtentDesc(tbParams, tbMagicDataLow, tbMagicDataHigh, bEx2)

	local strDescSrc = tbParams[1];
	local strResult = "";
	local strNow = strDescSrc;
	local strTrans = {strDescSrc};
	local nCount = 1;
	local nFindCur = 0;

	while (true) do

		nFindCur = string.find(strDescSrc, "%%s", nFindCur + 1);
		if (not nFindCur) then
			break;
		end

		nCount = nCount + 1;
		strTrans[nCount] = "";

		if (type(tbParams[nCount]) == "table") then

			local funPasLow = {};
			local funPasUp = {};

			for i = 1, #tbParams[nCount] - 1 do
				funPasLow[i] = tbMagicDataLow[tbParams[nCount][i+1]];
				funPasUp[i] = tbMagicDataHigh[tbParams[nCount][i+1]];
			end

			if (type(tbParams[nCount][1]) == "string") then
				if (type(self.tbStr2Fun[tbParams[nCount][1]]) == "function") then
					strTrans[nCount] = self.tbStr2Fun[tbParams[nCount][1]](unpack(funPasLow), unpack(funPasUp), bEx2);
				else
					print("FightSkill:ParingDesc can not find func", tbParams[nCount][1]);
				end
			end
		end
	end

	if (not strTrans)then
		print("FightSkill:ParingDesc strTrans is nill");
		return "null";
	end

	return string.format(unpack(strTrans));

end

