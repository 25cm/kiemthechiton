-- �ļ�������signup.lua
-- �����ߡ���sunduoliang
-- ����ʱ�䣺2009-05-04 16:23:47
-- ��  ��  ������npc

local tbNpc = Npc:GetClass("dragonboat_signup");

tbNpc.tbChangeItemList = {
	[1] = {
		szContext = "1����Ӱ֮ʯ��ȡһ�����ˣ�2�ι����Ը��죩",
		tbGiftParam = {
			tbAward = { {nGenre=18, nDetail=1, nParticular=327, nLevel=1,nCount=1,},},
			tbMareial = { { nGenre = 18, nDetail = 1, nParticular = 476,nLevel = 1, nCount = 1,},},
		},
	},
	[2] = {
		szContext = "1����Ӱ֮ʯ��ȡһ�ҳ˷磨1�ι����Ը��켰һ�η����Ը��죩",
		tbGiftParam = {
			tbAward = { {nGenre=18, nDetail=1, nParticular=327, nLevel=2,nCount=1,},},
			tbMareial = { { nGenre = 18, nDetail = 1, nParticular = 476,nLevel = 1, nCount = 1,},},
		},
	},
	[3] = {
		szContext = "1����Ӱ֮ʯ��ȡһ����ˮ��2�η����Ը��죩",
		tbGiftParam = {
			tbAward = { {nGenre=18, nDetail=1, nParticular=327, nLevel=3,nCount=1,},},
			tbMareial = { { nGenre = 18, nDetail = 1, nParticular = 476,nLevel = 1, nCount = 1,},},
		},
	},
	[4] = {
		szContext = "5����Ӱ֮ʯ��ȡһ�Ұ��ۣ�2�ι����Ը��켰1�η����Ը��죩",
		tbGiftParam = {
			tbAward = { {nGenre=18, nDetail=1, nParticular=327, nLevel=4,nCount=1,},},
			tbMareial = { { nGenre = 18, nDetail = 1, nParticular = 476,nLevel = 1, nCount = 5,},},
		},
	},
};

function tbNpc:OnDialog()
	local nState = EPlatForm:GetMacthState();
	if (EPlatForm:GetMacthType(EPlatForm:GetMacthSession()) ~= 2) then
		local tbOpt = {{"��������"},};
		if (nState == EPlatForm.DEF_STATE_REST) then
			tbOpt = {
				{"��ȡ���ջ����", EPlatForm.GetPlayerAward_Final, EPlatForm},
				{"��ȡ���影��", EPlatForm.GetKinAward, EPlatForm},
				{"��������"},	
			};
		end
		Dialog:Say("���ڲ���������ʱ�䣬�����ʱ�������ɣ�", tbOpt);
		return 0;	
	end		

	if EPlatForm:IsSignUpByAward(me) > 0 then
		Dialog:Say("���ϴα����Ľ�����û���أ��Ͽ���ɡ��콱��", 
			{
				{"�ã��찡", EPlatForm.GetPlayerAward_Single, EPlatForm},
				{"���ٿ��ǿ���"},
			}
		);
		return 0;
	end
	
	if (nState == EPlatForm.DEF_STATE_CLOSE) then
		Dialog:Say("���徺����δ���������Щ�������ɣ�");
		return 0;
	end

	EPlatForm:UpdateEventCount(me);
	local nCount = EPlatForm:GetEventCount(me);
	local nTotalCount = EPlatForm:GetPlayerTotalCount(me);
	local szStateName = EPlatForm.DEF_STATE_MSG[nState];
	local szMsg = string.format("�ٺ٣����µļ��徺����أ���������������������μӡ�Ŀǰ�����Ѿ�����<color=yellow>%s<color>������μӱ�����\n\n", szStateName);
	if (nState == EPlatForm.DEF_STATE_MATCH_1 or nState == EPlatForm.DEF_STATE_MATCH_2) then
		szMsg = string.format("%s<color=yellow>�����ʣ�������%s��\n", szMsg, nCount);
		if (nState == EPlatForm.DEF_STATE_MATCH_1) then
			szMsg = string.format("%s���׶��Ѿ��μӵ��ܳ�����%d��", szMsg, nTotalCount);
		end
	end
	
	local tbOpt = {
		{"�μӼ��徺������������",			EPlatForm.tbNpc.OnDialog,		EPlatForm.tbNpc},
		{"��Ҫ��ѯ�������",				EPlatForm.tbNpc.QueryMatch,		EPlatForm.tbNpc},
		{"��ȡ���ջ����",				EPlatForm.GetPlayerAward_Final,	EPlatForm},
		{"��ȡ���影��",					EPlatForm.GetKinAward,			EPlatForm},
		{"��Ӱ֮ʯ�̵�",				self.ChangeItem,				self},
		{"���۸���",						self.ProductBoat,				self},
		{"�˽�������",				self.OnAbout,					self},
		{"��㿴��"},
	};

	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:ProductBoat()
	local szMsg = "�������ֻ��Ҫ��������Ǯ�Ϳ��Զ��İ������۽��и��죬�Ӷ�ʹ����������������������ȡ�ñ�����ʤ����";
	local tbOpt = {
		{"�˽����۸���", self.AboutBoat, self},
		{"�����Ը���", self.OpenProductBoatUi, self, 1},
		{"�����Ը���", self.OpenProductBoatUi, self, 2},
		{"��㿴��"},
	};
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:ChangeItem(nLevel)
	
	me.OpenShop(166,3);
	do return end;
	
	if (EPlatForm:GetMacthType(EPlatForm:GetMacthSession()) ~= 2) then
		Dialog:Say("���û�п��ţ����ܶһ����ߡ�");
		return;
	end
	
	if (not nLevel) then
		local tbOpt = {};
		for nLevel, tbInfo in ipairs(self.tbChangeItemList) do
			table.insert(tbOpt, {tbInfo.szContext, self.ChangeItem, self, nLevel});
		end
		tbOpt[#tbOpt + 1] = {"��������"};
		Dialog:Say("1����Ӱ֮ʯ��ȡһ�����˻��߳˷������ˮ��5����Ӱ֮ʯ��ȡһ�Ұ��ۡ���Ӱ֮ʯ����ȥ�ӻ�������Ӱԭʯ��������ܼӹ������õ�����Ҫ�һ����ֵ��ߣ�", tbOpt);
		return 0;
	end
	local tbParam = self.tbChangeItemList[nLevel];
	
	if (not tbParam or not tbParam.tbGiftParam) then
		return 0;
	end
	
	Dialog:OpenGift(tbParam.szContext, tbParam.tbGiftParam);
	
end

function tbNpc:AboutBoat()
	local szMSg = self.tbAbout[5][2];
	Dialog:Say(szMSg,{{"��֪����", self.ProductBoat, self}});
end

function tbNpc:OpenProductBoatUi(nType)
	Dialog:OpenGift("������Ҫ���������", nil, {self.OnProductBoat, self, nType});
end

function tbNpc:OnProductBoat(nType, tbItem)
	if #tbItem <= 0 or #tbItem >= 2 then
		Dialog:Say("�������Ҫ��������ۣ�ֻ��Ҫ����һ�����ۡ�");
		return 0;
	end
	local pItem = tbItem[1][1];
	local szKey = string.format("%s,%s,%s", pItem.nGenre, pItem.nDetail, pItem.nParticular)
	if szKey ~= string.format("%s,%s,%s", unpack(Esport.DragonBoat.ITEM_BOAT_ID)) then
		Dialog:Say("�������Ҫ��������ۣ������Ĳ������ۡ�");
		return 0;
	end
	local nGenId1 = Esport.DragonBoat:GetBoatRestGenId(nType, pItem)
	if nGenId1 <= 0 then
		Dialog:Say("������������Ѹ�������ˣ������ٽ��и��졣");
		return 0;
	end
	self:OnProductBoat1(nType, pItem.dwId);
	return 0;
end

function tbNpc:OnProductBoat1(nSel, nItemId)
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	local nGenId = Esport.DragonBoat:GetBoatRestGenId(nSel, pItem)
	if nGenId <= 0 then
		Dialog:Say("������۱����ͼ��ܸ�������ɣ������ٽ��и��졣", {{"�����ϲ�", self.OnProductBoatSel, self, nItemId},{"�����Ի�"}});
		return 0;
	end
	
	local tbOpt = {};
	for nSelSkill, tbSkill in pairs(Esport.DragonBoat.PRODUCT_SKILL[nSel]) do
		if tbSkill[4][pItem.nLevel] then
			local szSelect = "����-"..tbSkill[2];
			if Esport.DragonBoat:CheckSkill(pItem, tbSkill[1]) > 0 then
				szSelect = string.format("<color=green>%s<color>",szSelect);
			end
			table.insert(tbOpt, {szSelect, self.OnProductBoat2, self, nSel, nSelSkill, nItemId});
		end
	end
	--table.insert(tbOpt, {"�����ϲ�", self.OnProductBoat1, self, nSel, nItemId});
	table.insert(tbOpt, {"�����Ի�"});
	Dialog:Say("����Ҫ������������أ�������Ҫ������������Ŷ��ϣ�����Ǯ���ˣ��Ǻ�~~", tbOpt);
end

function tbNpc:OnProductBoat2(nSel, nSelSkill, nItemId) 
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	
	local nSkillId 		= Esport.DragonBoat.PRODUCT_SKILL[nSel][nSelSkill][1];
	local szSkillName 	= Esport.DragonBoat.PRODUCT_SKILL[nSel][nSelSkill][2];
	local szSkillDesc 	= Esport.DragonBoat.PRODUCT_SKILL[nSel][nSelSkill][3];
	local nNeedBindMoney = Esport.DragonBoat.PRODUCT_SKILL[nSel][nSelSkill][5];
	
	if Esport.DragonBoat:CheckSkill(pItem, nSkillId) > 0 then
		Dialog:Say("��������Ѿ��������������,����ͬʱ����ͬһ����", {{"����������ֻ����", self.OnProductBoat1, self, nSel, nItemId},{"�����Ի�"}});
		return 0;
	end
	
	local szMsg = string.format("��ѡ��ļ����ǣ�<color=yellow>%s<color>\n\n����Ч����<color=yellow>%s<color>\n\n������ã�<color=yellow>%s������<color>", szSkillName, szSkillDesc, nNeedBindMoney);
	local tbOpt = {
		{"��Ҫ���и���", self.OnProductBoat3, self, nSel, nSelSkill, nItemId},
		{"�����ϲ�", self.OnProductBoat1, self, nSel, nItemId},
		{"���ٿ��ǿ���"},
	}
	Dialog:Say(szMsg, tbOpt);
end

function tbNpc:OnProductBoat3(nSel, nSelSkill, nItemId) 
	local pItem = KItem.GetObjById(nItemId);
	if not pItem then
		return 0;
	end
	local nSkillId = Esport.DragonBoat.PRODUCT_SKILL[nSel][nSelSkill][1];
	local nNeedBindMoney =Esport.DragonBoat.PRODUCT_SKILL[nSel][nSelSkill][5];
	if me.GetBindMoney() < nNeedBindMoney then
		Dialog:Say(string.format("�������������Ҫ<color=yellow>%s������<color>����İ��������㣬�޷����졣", nNeedBindMoney));
		return 0;
	end
	
	me.CostBindMoney(nNeedBindMoney, Player.emKBINDMONEY_COST_EVENT);
	
	local nGenId = Esport.DragonBoat:GetBoatRestGenId(nSel, pItem)
	if nGenId <= 0 then
		return 0;
	end
	
	pItem.SetGenInfo(nGenId, nSkillId);
	if pItem.IsBind() ~= 1 then
		pItem.Bind(1);
	end
	pItem.Sync();
	
	Dialog:Say("��ɹ�������ֻ���ۡ�", {{"��������",self.ProductBoat, self},{"�����Ի�"}});
end

tbNpc.tbAbout = {
{"��ν����į��ˮկ��", [[
    ��į��ˮկ����˵��û��ʲô��û�������ðɡ�������Ӧ����˵�˰ɡ����������㰳�Ǽ�į��ˮկ�Ǹ�ʲô�ġ�
    �����������ӵģ���һ�����ڣ��ͼ����ֵ�ҹ�����º�������Ȼ���ü�į���͡���ô���أ����ڤ˼���룬��������������ҹ�룬ȥ���֮�л����ۣ��ȿ�Ӧ�������Ž���ּ�į�����һ��������˵�á���ҹ�����������;�������һ��į��ˮɽկ������կ����ÿ����綼��ȥ���֮�л���ˮ���������ۣ���й��į����֮���ο���Ӣ�ꡣĿǰ���Ǽ�į��ˮկ����Խ��Խ�࣬�Ѿ���չ�ú���׳���ˡ�
    ��ô�����ǲ���Ҳ��������ǰ�������~~~�ȣ��ȣ�������������]]
},
{"�����ʱ��",string.format([[
    �������������׶Σ�
    ����ѡ�����׶Σ����˻�ս��ÿ���µ�7��~20�ţ�����14�죬�����ʱ��Ϊÿ���10�㡪��23�㣬ÿ15���ӿ���һ����10��Ϊ��һ����22��45Ϊÿ�����һ��������ʱ��5���ӡ�
    ����Ԥѡ���׶Σ�ս�Ӷ�ս�����ܻ�������ǰ120�ļ��������ս�ӽ��������ÿ���µ�21��~26�ţ�����6�졣�����ʱ��ÿ�칲2�֣����缰���ϸ�һ�֣�ÿ���15�㡪��17�㣬21��30����23��00��
	��������׶Σ�����ս�Ӿ�����8ǿս�����ʸ���롣ÿ���µ�27�ţ�Ϊ��1�죬21��30~~23��00Ϊ����ʱ�䡣]])
},
{"��βμӱ���",[[
    �������60�����ϵ���ҿ���ȥ�����ִ������ݱ����μӣ�ÿ�����ÿ����2�λ��ᡣ�μӱ����������Լ���ר�����ۣ����ۿ��Բ�ȡһ����ʽ��ã�ͬʱ���ܽ��ж�����죬ʹ����и�������������]]
},
{"��λ��ר������",[[
    ���۵Ļ�ȡ��ʽ��ȥ�ӻ��깺����Ӱԭʯ�������������������Ӱ֮ʯ����ȥ���ݴ���ȡ��1����Ӱ֮ʯ��ȡһ����ͨ���ۣ�5����Ӱ֮ʯ�ɻ�ȡ���ۡ����ۡ�
    ]]
},
{"�˽����۸���",[[
    ���۸��칲�������ࣺ�����Ը���ͷ����Ը��죬�ֱ���4�����췽��
    <color=yellow>1.�����Ը��죺<color>
    ����-�ı���ʹ���۾��м������������ٶȵ�������
    ����-������ʹ���۾���ѣ��������
    ����-���ˣ�ʹ���۾��ж���������
    ����-���У�ʹ���۾��л���������
    <color=yellow>2.�����Ը��죺<color>
    ����-ʯ����ʹ���۾���ȥ�������߶���ͳٻ��ı���������
    ����-���ģ�ʹ���۾���ȥ�������߻��Һͳٻ��ı���������
    ����-���꣺ȥʹ���۾���ȥ��������ѣ�κͳٻ��ı���������
    ����-���ۣ�ʹ���۾���ȥ��������һ�и���Ч���ı�������������<color=yellow>���ۣ�����<color>���Ը��죩
    <color=yellow>ע�⣺<color>��ͬ���ۿɽ��еĸ����ǲ�ͬ�ģ�ͬһ�������ֻ�ܽ������޴�������������Ͳ����ٽ��д�����졣����������ϸ˵�����Ѹ�����ȫ�����۽��������¸��죬����������ѡ����췽��]]
},
{"���������",[[
    ���������ᱻ����������أ�������ʼʱ�������Լ���ӵ�����۵���۽��������ͼ��������ʼ�����Ϳ������źӵ���ָʾ���յ���ȥ���ӵ��ڻ����������ֵ�Ư���·���Ļ��������벻���Ľ�������ܻ��ǿ�����ܣ����ص��ߣ�Ҳ�������������������壬������������������췣һ�������������ӣ�ͨ�����ϻ��������Ч����
���ײ���ӵ�����ϰ��������Ӱ��ϵ�դ�������������еĹµ��������ѣ��һ��ʱ�䣬���л�����Ҫ��ܣ���õļ���Ҳ�ܶԶ�����ɲ���Ӱ�죬��֮�ǻ������أ�ǧ��С�ġ�]]
},
{"ʤ��������",[[
    ��ͨ���յ���Ⱥ�˳��������Ⱥ��ж����Σ�ǰ5������ñ��䣬���鼰�����Ƚ��������������ܻ�þ��飬�����������Ƚ�����]]
},
}

function tbNpc:OnAbout()
	local szMSg = "��į��ˮɽկ�ڴ˾������۱�������Ҫ�˽���Щ�����أ�";
	local tbOpt = {};
	for i, tbMsg in pairs(self.tbAbout) do
		table.insert(tbOpt, {tbMsg[1], self.AboutInfo, self, i});
	end
	table.insert(tbOpt, {"��������"});
	Dialog:Say(szMSg, tbOpt);
end

function tbNpc:AboutInfo(nSel)
	local szMSg = self.tbAbout[nSel][2];
	Dialog:Say(szMSg,{{"��֪����", self.OnAbout, self}});
end
