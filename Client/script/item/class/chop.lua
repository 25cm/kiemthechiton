
Require("\\script\\item\\class\\equip.lua");


local tbChop = Item:NewClass("chop", "equip");
if not tbChop then
	tbChop = Item:GetClass("chop");
end

function tbChop:OnUse()
	if Item.tbFactionToken:GetTokenItem(me) then
		self:SelectEquip(it.dwId);
		return;
	end
	
	if (me.CanUseItem(it) == 1) then
		me.AutoEquip(it);
	else
		self:DialogChange(it);
	end
end

function tbChop:SelectEquip(dwItemId)
	local szMsg = "Đã trang bị <color=green>Tín Vật Tông Môn<color>, có thể chọn <color=green>dung hợp quan ấn<color> để thêm hiệu quả vào Tín Vật Tông Môn.";
	local pItem = Item.tbFactionToken:GetTokenItem(me);
	if not pItem then
		return;
	end
	
	if Item.tbFactionToken:GetTokenBaseProb(pItem) then
		szMsg = string.format("%s\nTín Vật hiện tại <color=green>đã có hiệu quả quan ấn<color>, sau khi thay thế thì hiệu quả quan ấn sẽ <color=red>được thay bằng hiệu quả quan ấn mới<color>, hiệu quả trước biến mất.", szMsg);
	else
		szMsg = string.format("%s\nQuan ấn sau khi dung hợp vào Tín Vật, <color=pink>thời gian hiệu lực sẽ lưu lại<color>, nhưng không thể <color=red>rút quan ấn từ Tín Vật<color>.", szMsg);
	end
	
	szMsg = string.format("%s\nHãy chọn thao tác: ", szMsg);
	
	local tbOpt = 
	{
		{"<color=green>Dung hợp quan ấn<color>", Item.tbFactionToken.OnAddChop, Item.tbFactionToken, me.nId, dwItemId},
		{"Trang bị ngay", self.OnAutoEquip, self, dwItemId}
	};
	
	Dialog:Say(szMsg, tbOpt);
end

function tbChop:OnAutoEquip(dwItemId)
	local pChop = Item:CheckItemId(dwItemId);
	if not pChop then
		return;
	end
	
	if (me.CanUseItem(pChop) == 1) then
		me.AutoEquip(pChop);
	else
		self:DialogChange(pChop);
	end
end

function tbChop:GetTip(nState, tbEnhRandMASS, tbEnhEnhMASS)		-- 获取套装装备Tip

	local szTip = "";

	if (Item.EQUIPPOS_CHOP ~= it.nEquipPos) then
		return	szTip;
	end

	szTip = szTip.."<color=white>";
	szTip = szTip..self:Tip_ReqAttrib();
	szTip = szTip..self:Tip_Durability();
	szTip = szTip..self:Tip_Level();
	szTip = szTip..self:Tip_Series(nState);
	szTip = szTip.."<color>\n";
	
	local tbAttrib = it.GetBaseAttrib();
	local tbDef = FightSkill:GetClass("default");
	
	local nLiuQiLevel = 0;
	for i = 1, #tbAttrib do
		if tbAttrib[i].szName == "allskill_v" then
			local tbMsg = {};
			local tbInfo = KFightSkill.GetSkillInfo(tbAttrib[i].tbValue[3], tbAttrib[i].tbValue[1]);
			if (tbAttrib[i].tbValue[3] == 899) then --六气化玉功
				nLiuQiLevel = tbAttrib[i].tbValue[1];
			end;
			
			if (i ~= 1) then
				szTip = szTip..string.format("\n\nKỹ năng: <color=yellow>%s<color>\n", KFightSkill.GetSkillName(tbAttrib[i].tbValue[3]));
				local tbInfo = KFightSkill.GetSkillInfo(tbAttrib[i].tbValue[3], tbAttrib[i].tbValue[1]);
				if(tbInfo.szProperty ~= "") then
					szTip = szTip..string.format("<color=metal>%s<color>\n",tbInfo.szProperty);
				end;
				if(tbInfo.szDesc ~= "") then
					szTip = szTip..tbInfo.szDesc.."\n\n";
				end;
				tbMsg = { string.format("<color=cyan>Cấp %d<color>", tbAttrib[i].tbValue[1]) }; 
			end;
			tbDef:GetDescAboutLevel(tbMsg, tbInfo)
			szTip = szTip..table.concat(tbMsg, "\n");
		end
	end
	
	szTip = szTip..self:Tip_RepairInfo(nState);
	
	szTip = string.gsub(szTip, "nLevel", nLiuQiLevel);
	
	return	Lib:StrTrim(szTip, "\n");
end

function tbChop:CalcValueInfo()
	local nValue = it.nOrgValue;
	local nStarLevel, szNameColor, szTransIcon = Item:CalcStarLevelInfo(it.nVersion, it.nDetail, it.nLevel, nValue);
	return	nValue, nStarLevel, szNameColor, szTransIcon;
end
