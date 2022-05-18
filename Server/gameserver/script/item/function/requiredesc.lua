
-- 道具：需求属性文字描述

-- 需求属性枚举，注意保持与程序的一致性
local REQ_STR		= 1;				-- 力量需求
local REQ_DEX		= 2;				-- 身法需求
local REQ_VIT		= 3;				-- 外功需求
local REQ_ENG		= 4;				-- 内功需求
local REQ_LEVEL		= 5;				-- 等级需求
local REQ_FACTION	= 6;				-- 门派需求
local REQ_SERIES	= 7;				-- 五行需求
local REQ_SEX		= 8;				-- 性别需求

Item.REQ_DESC_TABLE =
{
	[REQ_STR]		= function(nValue)
		return	"Yêu cầu Sức Mạnh: "..tostring(nValue).."";
	end,
	[REQ_DEX]		= function(nValue)
		return	"Yêu cầu Thân Pháp: "..tostring(nValue).."";
	end,
	[REQ_VIT]		= function(nValue)
		return	"Yêu cầu Ngoại Công"..tostring(nValue).."";
	end,
	[REQ_ENG]		= function(nValue)
		return	"Yêu cầu Nội Công: "..tostring(nValue).."";
	end,
	[REQ_LEVEL]		= function(nValue)
		return	"Yêu cầu cấp: "..tostring(nValue).."";
	end,
	[REQ_FACTION]	= function(nValue)
		local szFaction = Player.FACTION_NAME[nValue];
		if (not szFaction) then
			szFaction = "";
		end
		return "Yêu cầu môn phái: "..szFaction;
	end,
	[REQ_SERIES]	= function(nValue)
		local szSeries = Env.SERIES_NAME[nValue];
		if (not szSeries) then
			szSeries = "";
		end
		return "Yêu cầu ngũ hành: "..szSeries;
	end,
	[REQ_SEX]		= function(nValue)
		local szSex = Env.SEX_NAME[nValue];
		if (not szSex) then
			szSex = "";
		end
		return "Yêu cầu giới tính: "..szSex;
	end,
};

function Item:GetRequireDesc(nReqAttrib, nValue)
	local fProc = self.REQ_DESC_TABLE[nReqAttrib];
	if (not fProc) then
		return	"";
	end
	return	fProc(nValue);
end
