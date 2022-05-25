-------------------------------------------------------------------
--File: xmas_laoren2.lua
--Author: fenghewen
--Date: 2008-12-16 10:23
--Describe: ʥ������npc�ű�
-------------------------------------------------------------------
if  MODULE_GC_SERVER then
	return;
end
local tbSantaClaus = Npc:GetClass("xmas_laoren2");
tbSantaClaus.tbSocks = {18,1,269,1};	--ʥ������
tbSantaClaus.nLevelLimit = 60

function tbSantaClaus:OnDialog()
	local nCheck = SpecialEvent.Xmas2008:Check();
	if nCheck == -1 then
		Dialog:Say("ʥ�����ˣ����û��ʼ���һ�Ҫ׼��һ��ʱ����������ء�")
		return 0;		
	end
	if nCheck == 0 then
		Dialog:Say("ʥ�����ˣ����ﶼ�����ˣ���Ϣһ����뿪��")
		return 0;
	end	
	Dialog:Say("��λʥ�����֣������ڴ˴�����������Ե��������������ͷ�������~~~���ӣ��ٺ٣�",
		{
			{"��������", self.RecevePresent, self, him.dwId},
			{"����㿴�����뿪��"}
		})
end

-- ��������
function tbSantaClaus:RecevePresent(nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		return 0
	end
	
	local tbNpcTemp = pNpc.GetTempTable("Npc");
	if not tbNpcTemp.tbPlayerList then
		tbNpcTemp.tbPlayerList = {};
	end
	
	local tbPlayerList = tbNpcTemp.tbPlayerList;
	if tbPlayerList[me.nId] == 1  then
		Dialog:Say("�㲻���Ѿ��õ������������ﲻ�࣬����������ɡ�");
		return 0;
	end
	
	if me.nLevel < self.nLevelLimit  then
		Dialog:Say("��~~ �����������������޷�ʶ��������� ��60���Ժ������ɡ�");
		return 0;
	end
	
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("��ı����ռ䲻��!")
		return 0;
	end
	
	-- ������
	local pItem = me.AddItem(unpack(self.tbSocks));
	if pItem then
		pItem.Bind(1);
		tbPlayerList[me.nId] = 1;
	end
end
	

