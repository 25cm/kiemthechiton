-- �ļ�������dragonboat.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-05-04 14:49:00
-- ��  ��  ������ӻ���

local tbItem = Item:GetClass("td_fuzou");
local GEN_WEAR			= 1;
local GEN_SKILL_ATTACK1 = 2;
local GEN_SKILL_ATTACK2 = 3;
tbItem.ITEM_BOAT_ID = {18,1,638};
tbItem.PRODUCT_SKILL = {
	
	--������
	[1] = {
		--����Id�����ƣ�����������ȼ�,��Ҫ������
		{1611, "��", "ʹĿ�궨��3�룬���㹥����",{[1]=1,[2]=1}, 15000},
		{1612, "��", "ʹĿ����˾��룬���㹥����",{[1]=1,[2]=1}, 15000},
		{1613, "��", "ʹĿ��ٻ�5�룬���㹥����",{[1]=1,[2]=1}, 15000},
		{1614, "��", "ʹĿ�����2�룬���㹥����",{[1]=1,[2]=1}, 15000},
		{1615, "��", "ʹĿ��ѣ��2�룬���㹥����",{[1]=1,[2]=1}, 15000},
	},
};

tbItem.PRODUCT_BOAT = {
	--�;ã��������죬�������죬�Ƿ������
	[1] = {10,1,0,{1383,1}},	--1��,15�;ã�2�ι����Ը��죬0�η����и��죬������
	[2] = {10,2,0,{1383,2}},	--2��,15�;ã�1�ι����Ը��죬1�η����и��죬������
}

tbItem.GEN_WEAR		  	= 1;
tbItem.GEN_SKILL_ATTACK = {2,3};

function tbItem:GetGenId(nSel, pItem)
	if not pItem then
		return 0;
	end
	local tbProp = self.PRODUCT_BOAT[pItem.nLevel];
	
	local tbSkillAttack = {};
	for _, nGenId in ipairs(Esport.DragonBoat.GEN_SKILL_ATTACK) do
		table.insert(tbSkillAttack, {nGenId, pItem.GetGenInfo(nGenId, 0)})
	end
		
	if nSel == 1 then
		for i=1, tbProp[2] do
			if tbSkillAttack[i] and tbSkillAttack[i][2] <= 0 then
				return tbSkillAttack[i][1];
			end
		end
	end
	return 0;
end


function tbItem:GetTip()
	local szTip  = "";
	local tbProp = self.PRODUCT_BOAT[it.nLevel];
	local nWear  = tbProp[1] - it.GetGenInfo(Esport.DragonBoat.GEN_WEAR, 0);
	local szWear = string.format("�;öȣ�%s", nWear);
	if nWear >= 10 then
		szWear = string.format("\n<color=green>%s<color>", szWear);
	elseif nWear >= 5 then
		szWear = string.format("\n%s", szWear);
	else
		szWear = string.format("\n<color=red>%s<color>", szWear);
	end
	
	szTip = szTip .. szWear;
	szTip = szTip .. self:GetSkillTip(it);
	return szTip;
end

function tbItem:GetSkillTip(pItem)
	local tbProp = self.PRODUCT_BOAT[pItem.nLevel];
	local nWear  = tbProp[1] - pItem.GetGenInfo(self.GEN_WEAR, 0);
	
	local tbSkillAttack = {};
	for _, nGenId in ipairs(self.GEN_SKILL_ATTACK) do
		table.insert(tbSkillAttack, pItem.GetGenInfo(nGenId, 0))
	end
	
	local szTip = "";
	for i=1, tbProp[2], 1 do
		if tbSkillAttack[i] > 0 then
			szTip = szTip .. string.format("\n<color=green>�����Ը��죺%s<color>", KFightSkill.GetSkillName(tbSkillAttack[i]));
		else
			szTip = szTip .. string.format("\n<color=gray>�����Ը��죺δ����<color>");
		end
	end
	
	return szTip;
end

function tbItem:CheckSkill(pItem, nSkillId)
	for _, nGenId in pairs(self.GEN_SKILL_ATTACK) do
		if pItem.GetGenInfo(nGenId, 0) == nSkillId then
			return 1;
		end
	end
	return 0;
end

-- ���ھ���ƽ̨�����Ʒ��麯������ͬ�Ļ���ͣ���ͬ����Ʒ������Ҫ��ͬ�ļ�����
function tbItem:ItemCheckFun(pItem)
	if (not pItem) then
		return 0, "�ػ�����֮����Ʒ�����ڡ�";
	end
	local nUseBoat = 0;
	local nGenId1 = self:GetGenId(1, pItem);
	local nGenId2 = self:GetGenId(2, pItem);
	if nGenId1 <= 0 and nGenId2 <= 0 then
		nUseBoat = 1;
	end
	if nUseBoat == 0 then
		return 0, "��������ӻ�����û��������������μӱ����ܳԿ��ġ��ȸ���һ�����������ɡ�";
	end			
	return 1;
end

--����
function tbItem:OpenProduct(nType)
	Dialog:OpenGift("������Ҫ���������ӻ���", nil, {self.OnProduct, self, nType});
end

function tbItem:OnProduct(nType, tbItem)
	if #tbItem <= 0 or #tbItem >= 2 then
		Dialog:Say("�������Ҫ���������ӻ�����ֻ��Ҫ����һ������ӻ�����");
		return 0;
	end
	local pItem = tbItem[1][1];
	local szKey = string.format("%s,%s,%s", pItem.nGenre, pItem.nDetail, pItem.nParticular)
	if szKey ~= string.format("%s,%s,%s", unpack(self.ITEM_BOAT_ID)) then
		Dialog:Say("�������Ҫ���������ӻ����������Ĳ�������ӻ�����");
		return 0;
	end
	local nGenId1 = self:GetGenId(nType, pItem)
	if nGenId1 <= 0 then
		Dialog:Say("�������ӻ��������Ѹ�������ˣ������ٽ��и��졣");
		return 0;
	end
	self:OnProduct1(nType, pItem.dwId);
	return 0;
end

function tbItem:OnProduct1(nSel, nItemId)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	local nGenId = self:GetGenId(nSel, pItem)
	if nGenId <= 0 then
		Dialog:Say("�������ӻ��������ͼ��ܸ�������ɣ������ٽ��и��졣", {{"�����ϲ�", self.OnProductSel, self, nItemId},{"�����Ի�"}});
		return 0;
	end
	
	local tbOpt = {};
	for nSelSkill, tbSkill in pairs(self.PRODUCT_SKILL[nSel]) do
		if tbSkill[4][pItem.nLevel] then
			local szSelect = "����-"..tbSkill[2];
			if self:CheckSkill(pItem, tbSkill[1]) > 0 then
				szSelect = string.format("<color=green>%s<color>",szSelect);
			end
			table.insert(tbOpt, {szSelect, self.OnProduct2, self, nSel, nSelSkill, nItemId});
		end
	end
	--table.insert(tbOpt, {"�����ϲ�", self.OnProduct1, self, nSel, nItemId});
	table.insert(tbOpt, {"�����Ի�"});
	Dialog:Say("����Ҫ������������أ�������Ҫ������������Ŷ��ϣ�����Ǯ���ˣ��Ǻ�~~", tbOpt);
end

function tbItem:OnProduct2(nSel, nSelSkill, nItemId) 
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	local nSkillId 		= self.PRODUCT_SKILL[nSel][nSelSkill][1];
	local szSkillName 	= self.PRODUCT_SKILL[nSel][nSelSkill][2];
	local szSkillDesc 	= self.PRODUCT_SKILL[nSel][nSelSkill][3];
	local nNeedBindMoney = self.PRODUCT_SKILL[nSel][nSelSkill][5];
	
	if self:CheckSkill(pItem, nSkillId) > 0 then
		Dialog:Say("�������ӻ����Ѿ��������������,����ͬʱ����ͬһ����", {{"���������������ӻ���", self.OnProduct1, self, nSel, nItemId},{"�����Ի�"}});
		return 0;
	end
	
	local szMsg = string.format("��ѡ��ļ����ǣ�<color=yellow>%s<color>\n\n����Ч����<color=yellow>%s<color>\n\n������ã�<color=yellow>%s������<color>", szSkillName, szSkillDesc, nNeedBindMoney);
	local tbOpt = {
		{"��Ҫ���и���", self.OnProduct3, self, nSel, nSelSkill, nItemId},
		{"�����ϲ�", self.OnProduct1, self, nSel, nItemId},
		{"���ٿ��ǿ���"},
	}
	Dialog:Say(szMsg, tbOpt);
end

function tbItem:OnProduct3(nSel, nSelSkill, nItemId) 
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	local nSkillId = self.PRODUCT_SKILL[nSel][nSelSkill][1];
	local nNeedBindMoney =self.PRODUCT_SKILL[nSel][nSelSkill][5];
	if me.GetBindMoney() < nNeedBindMoney then
		Dialog:Say(string.format("�������������Ҫ<color=yellow>%s������<color>����İ��������㣬�޷����졣", nNeedBindMoney));
		return 0;
	end
	
	me.CostBindMoney(nNeedBindMoney, Player.emKBINDMONEY_COST_EVENT);
	
	local nGenId = self:GetGenId(nSel, pItem)
	if nGenId <= 0 then
		return 0;
	end
	
	pItem.SetGenInfo(nGenId, nSkillId);
	if pItem.IsBind() ~= 1 then
		pItem.Bind(1);
	end
	pItem.Sync();
	Dialog:Say("��ɹ��������������ӻ�����");
end
