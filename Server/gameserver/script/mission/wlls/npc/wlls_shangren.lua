-------------------------------------------------------
-- �ļ�������wlls_shangren.lua
-- �����ߡ���zhouchenfei
-- ����ʱ�䣺2009-12-24 14:58:48
-- �ļ�������
-------------------------------------------------------

local tbNpc	= Npc:GetClass("wlls_yaoshang");

-- ��NPC�Ի�
function tbNpc:OnDialog(szCamp)
	local szMsg = "";
	local tbOpt	= {};
	if (GLOBAL_AGENT) then
		szMsg	= "���ã��������ʹ�ÿ���ר������������ҩƷ��";
		tbOpt	= 	
		{
			{"�������", self.OnBuySpeYao, self},
			{"���ٿ��ǿ���"},
		};
	else
		szMsg = "�������ָ�·Ӣ�ۻ���ڴˣ����������������������ҵ����������ɫ��ʵ������ο���İ���";
		tbOpt = 
		{
			{"<color=gold>����������<color>ҩƷ", self.OnBuyYaoByBind, self},
			{"ҩƷ", self.OnBuyYao, self},
			{"ʳ��", self.OnBuyCai, self},
		};
	end

	Dialog:Say(szMsg, tbOpt);
end

-- ��ҩ
function tbNpc:OnBuySpeYao()
	me.OpenShop(164,7);
end

function tbNpc:OnBuyYao()
	me.OpenShop(14,1);
end

function tbNpc:OnBuyYaoByBind()
	me.OpenShop(14,7);
end

-- ���
function tbNpc:OnBuyCai()
	me.OpenShop(21,1);
end

function tbNpc:OnBuyCaiByBind()
	me.OpenShop(21,7);
end
