-- �ļ�������merchent.lua
-- �����ߡ���jiazhenwei
-- ����ʱ�䣺2010-03-10 16:41:20
-- ��  ��  ��Ģ���̵�

local tbNpc = Npc:GetClass("td_merchent");

function tbNpc:OnDialog()
	me.OpenShop(169, 10);
end
