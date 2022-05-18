-- 文件名　：partnermiji.lua
-- 创建者　：jiazhenwei
-- 创建时间：2010-01-19 11:32:29
-- 描  述  ：同伴秘籍

local tbItem = Item:GetClass("miji_tbEx");

tbItem.tbBookValue =  
{                          
	600000,    --初级      
	3000000,  --中级       
	18000000 --高级        
};         

--对应等级需要的星级数(2倍值)
tbItem.tbGradeRequire =  
{       
	0,                   
	12,
	16
}; 

function tbItem:OnUse()
	if (Partner.bOpenPartner ~= 1) then
		Dialog:Say("Tính năng đồng hành chưa mở.vui lòng thử lại sau");
		return 0;
	end	
	
	self:OnSelectUse(it.dwId);
end

function tbItem:OnSelectUse(dwId, nParam, bSure)
	bSure = bSure or 0;
	
	if me.nPartnerCount <= 0 then
		me.Msg("Bạn chưa có đồng hành!");
		return 0;
	end
	
	if bSure == 0 then
		local szMsg = "Bạn muốn tăng cấp kỹ năng cho đồng hành:";
		local tbOpt = {};
		for i = 1, me.nPartnerCount do
			local pPartner = me.GetPartner(i - 1);
			if pPartner then
				table.insert(tbOpt, {pPartner.szName, self.OnSelectUse, self, dwId, i - 1, 1});
			end
		end
		
		table.insert(tbOpt, {"Để ta suy nghĩ đã"});
		Dialog:Say(szMsg, tbOpt);
		
		return 0;
	else
		local pPartner = me.GetPartner(nParam);
		local pItem = KItem.GetObjById(dwId);
		if not pPartner or not pItem then
			return 0;
		end
		local nCount = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_SKILLBOOK);   --用个位，十位，百位表示三个级别的技能书个数
		if nCount < 0 then
			nCount = 0;
		end
		--检查使用同类物品的次数
		--if self:CheckSkillBookCount(nCount) == 1 then
		--	Dialog:Say("Đồng hành đã sử dụng 2 quyển Mật tịch đồng hành", {"Ta biết rồi"});
		--	return 0;
		--end		
		--等级判定
		if pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_LEVEL) < 120 then
			Dialog:Say("Đồng hành chưa đạt cấp 120 chưa thể sử dụng!", {"Ta biết rồi"});
			return 0;
		end
		
		--技能检查
		if self:CheckSkill(nParam)  == 1 then
			Dialog:Say("Đồng hành không có kỹ năng nào nhỏ hơn 10 cấp!", {"Ta biết rồi"});
			return 0;
		end		
		
		self:AddPartnerSkillLevel(nParam, dwId);
	end
	
	return 1;
end

--检查有没有小于6级的技能
function tbItem:CheckSkill(nParam)
	local pPartner = me.GetPartner(nParam);
	if pPartner then
		for i = 1, pPartner.nSkillCount do
			local tbSkill = pPartner.GetSkill(i - 1);
			if tbSkill.nLevel < 10 then
				return 0;
			end
		end
	end
	return 1;
end

--随机一个小于6级的技能加一级
function tbItem:AddPartnerSkillLevel(nParam, dwId)
	local pPartner = me.GetPartner(nParam);
	local pItem = KItem.GetObjById(dwId);
	local tbStatisSkil = {};
	if not pPartner or not pItem then
		return 0;
	end
	local nLevel = pItem.nLevel;
	local szName = pItem.szName;
	--找等级小于6的技能
	for i = 1, pPartner.nSkillCount do
		local tbSkill = pPartner.GetSkill(i - 1);
		if tbSkill.nLevel < 10 then
			table.insert(tbStatisSkil, {i - 1, tbSkill.nId, tbSkill.nLevel});
		end
	end
	local nAddSkillIndex = MathRandom(#tbStatisSkil); --随机一个技能增加
	pPartner.SetSkill(tbStatisSkil[nAddSkillIndex][1],{["nId"] = tbStatisSkil[nAddSkillIndex][2], ["nLevel"] = tbStatisSkil[nAddSkillIndex][3] + 1});
	me.Msg(string.format("Bạn đã sử dụng Mật tịch đồng hành (đặc biệt), kỹ năng đồng hành <color=yellow>%s<color> tăng lên 1 cấp",KFightSkill.GetSkillName(tbStatisSkil[nAddSkillIndex][2])));
	pItem.Delete(me);
	local nCount = pPartner.GetValue(Partner.emKPARTNERATTRIBTYPE_SKILLBOOK);
	if nCount < 0 then
		nCount = 0;
	end
	nCount = nCount + 10 ^ (nLevel - 1);
	pPartner.SetValue(Partner.emKPARTNERATTRIBTYPE_SKILLBOOK, nCount);
	PlayerHonor:UpdatePartnerValue(me, 0);
	Dbg:WriteLog("Log dong hanh:", me.szName, " voi dong hanh ", pPartner.szName," su dung: ", szName," tang cap kỹ nang ", self.tbBookValue[nLevel]);
	return 1;
end

--检查使用同类物品的次数
function tbItem:CheckSkillBookCount(nCount)
	local nCountEx = 0;
	local nNum = 0;
	for i = 1, 3 do
		nNum = math.fmod(nCount, 10 ^ i);
		nCountEx = nCountEx + math.floor(nNum / (10 ^ (i - 1)));
	end
	if nCountEx >= 2 then
		return 1;
	end
	return 0;
end

function tbItem:CheckPartnerGrade(nParam, dwId)
	local pPartner = me.GetPartner(nParam);
	local pItem = KItem.GetObjById(dwId);
	if not pPartner or not pItem then
		return 1;
	end
	local nLevel = pItem.nLevel;
	local nGradeXing = Partner:GetSelfStartCount(pPartner);
	if nGradeXing > self.tbGradeRequire[nLevel] and (not self.tbGradeRequire[nLevel + 1] or nGradeXing <= self.tbGradeRequire[nLevel + 1]) then		
		return 0;
	end
	return 1;
end
