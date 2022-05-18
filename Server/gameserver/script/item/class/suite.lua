

Require("\\script\\item\\class\\equip.lua");


local tbSuite = Item:NewClass("suite", "equip");
if not tbSuite then
	tbSuite = Item:GetClass("suite");
end

function tbSuite:init()
	self.m_tbSuiteMASS = nil;
end

tbSuite:init();


function tbSuite:GetTip(nState, tbEnhRandMASS, tbEnhEnhMASS)		-- 获取套装装备Tip

	local szTip = "";

	if (Item.EQUIP_GOLD == it.nGenre) then
		self.m_tbSuiteMASS = me.GetGoldSuiteAttrib(it.nSuiteId);
	elseif (Item.EQUIP_GREEN == it.nGenre) then
		self.m_tbSuiteMASS = me.GetGreenSuiteAttrib(it.nSuiteId);
	else
		print("Sử dụng bộ ClassName không phải trang phục! Hãy kiểm tra file cấu hình đạo cụ!");
		return	szTip;
	end

	szTip = szTip.."<color=white>";
	szTip = szTip..self:Tip_ReqAttrib();
	szTip = szTip..self:Tip_Durability();
	szTip = szTip..self:Tip_Level();
	szTip = szTip..self:Tip_Series(nState);
	szTip = szTip.."<color>";
	szTip = szTip..self:Tip_BaseAttrib(nState);
	szTip = szTip..self:Tip_RandAttrib(nState, tbEnhRandMASS);
	szTip = szTip..self:Tip_SuiteInfo();
	szTip = szTip..self:Tip_SuiteAttrib(nState);
	szTip = szTip..self:Tip_EnhAttrib(nState, tbEnhEnhMASS);
	szTip = szTip..self:Tip_RepairInfo(nState);
	szTip = szTip..self:Tip_StrAttrib(nState);		--给套装添加"Cường 15"的TIP激活

	self.m_tbSuiteMASS = nil;
	return	szTip;

end



function tbSuite:Tip_SuiteInfo()	-- 获得Tip字符串：套装信息

	local szTip = "";
	local tbMASS = self.m_tbSuiteMASS;

	if (tbMASS.nCount <= 1) then
		return	szTip;				-- 整套只有一件的套装不显示套装信息
	end
	szTip = szTip.."\n\n<color=blue>"..tbMASS.szName.."("..tbMASS.nEquip.."/"..tbMASS.nCount..")<color>";

	for i = 0, #tbMASS.tbPos do
		local szName = tbMASS.tbPos[i].szName;
		local nHoldStatus = tbMASS.tbPos[i].nHoldStatus;
		if (szName ~= "") then
			if (self.HOLDSTATUS_EQUIP == nHoldStatus) then	-- 装备在身上
				szTip = szTip.."\n <color=yellow>"..szName.."<color>";
			else												-- 没有该装备
				szTip = szTip.."\n <color=gray>"..szName.."<color>";
			end
		end
	end

	return	szTip;

end

function tbSuite:Tip_SuiteAttrib(nState)	-- 获得Tip字符串：套装激活属性

	local szTip = "";

	if (nState == Item.TIPS_PREVIEW) then	-- 属性预览状态，显示魔法属性范围

		local tbBaseProp = KItem.GetEquipBaseProp(it.nGenre, it.nDetail, it.nParticular, it.nLevel, it.nVersion);
		if (tbBaseProp) then
			local tbSuiteMA = tbBaseProp.tbSuiteMA;
			for _, tbMA in ipairs(tbSuiteMA) do
				local szDesc = (tbMA.szName ~= "") and FightSkill:GetMagicDesc(tbMA.szName, tbMA.tbValue, nil, 1);
				szTip = szTip.."\n("..tbMA.nNum.."cái) "..szDesc;
			end
		end

	else

		local tbSuiteMA = self.m_tbSuiteMASS.tbSuiteMA;

		for _, tbMA in ipairs(tbSuiteMA) do
			local szDesc = (tbMA.szName ~= "") and FightSkill:GetMagicDesc(tbMA.szName, tbMA.tbValue, nil, 1);
			if szDesc and (szDesc ~= "") then
				if (tbMA.bActive ~= 1) then
					szTip = szTip.."<color=gray>";	-- 未激活显示为灰色
				end
				szTip = szTip.."\n("..tbMA.nNum.."cái) "..szDesc;
				if (tbMA.bActive ~= 1) then
					szTip = szTip.."<color>";
				end
				szTip = szTip;
			end
		end

	end
	if szTip ~= "" then
		szTip = "<color=greenyellow>"..szTip.."<color>"
	end

	return	szTip;

end

function tbSuite:Tip_StrAttrib(nState)
	local nNewEnhanceTimes = Item.tbTransferEquip.nNewEnhanceTimes;
	local nNewStrengthen = Item.tbTransferEquip.nNewStrengthen;
	local nType = Item.tbTransferEquip.nType or -1;
	if UiManager.IVER_nqianghua15 == 1 then
		return	"";	
	end
	if (nState ~= Item.TIPS_TRANSFER or (nNewStrengthen and nNewStrengthen == 0) or Item:GetEquipType(it) ~= nType) and 
		(it.IsWhite() == 1 or it.nEnhTimes < 14 or it.nEnhTimes > 15 ) then
		return	"";						-- 白色装备不显示强化激活属性
	end

	local nCount = 0;					-- 改造属性计数	
	local szTip = "\n<color=blue>Cải tạo<color>";
	local tbMASS = it.GetStrMASS();		-- 获得道具强化激活魔法属性
	for i = 1, #tbMASS do
		local tbMA = tbMASS[i];
		local szDesc = self:GetMagicAttribDesc(tbMA.szName, tbMA.tbValue);
		
		if (szDesc ~= "") and (tbMA.bVisible == 1) then
			nCount = nCount + 1;
			if (nState == Item.TIPS_STRENGTHEN  and Item:CheckStrengthenEquip(it) == 1) or 
				(nNewStrengthen and nNewStrengthen > 0 and Item:GetEquipType(it) == nType) then
				local _, _, _, nStrengthenColor = self:CalcEnhanceAttrib(Item.TIPS_ENHANCE);	--用装备强化时所用的颜色列表
				local szColor = string.format("<color=0x%x>", nStrengthenColor);
				szDesc = "\n"..szColor..Lib:StrFillL(string.format("(Cường hóa +%d sửa)", tbMA.nTimes), 12)..szDesc.."<color>";
			elseif (tbMA.bActive == 1) and (tbMA.bVisible == 1) then
				szDesc = "\n"..Lib:StrFillL(string.format("(Cường hóa +%d sửa)", tbMA.nTimes), 12)..szDesc;
			else
				if nScriptVersion ~= 1 then
					szDesc = "\n<color=gray>"..Lib:StrFillL(string.format("(Cường hóa +%d sửa)", tbMA.nTimes), 12)..szDesc.."<color>";
				elseif tbMA.nTimes <= Item:CalcMaxEnhanceTimes(it) then
					szDesc = "\n<color=gray>"..Lib:StrFillL(string.format("(+ %d sửa)", tbMA.nTimes), 12)..szDesc.."<color>";
				end
			end
		end

		szTip = szTip..szDesc;
	end

	if nCount == 0 then
		return	"";
	else
		return	"\n<color=greenyellow>"..szTip.."<color>";
	end
end
