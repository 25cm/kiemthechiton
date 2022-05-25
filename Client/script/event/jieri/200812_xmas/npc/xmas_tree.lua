-------------------------------------------------------------------
--File: xmas_tree.lua
--Author: fenghewen
--Date: 2008-12-16 10:23
--Describe: ʥ����npc�ű�
-------------------------------------------------------------------
if  MODULE_GC_SERVER then
	return;
end
local tbChristmasTree = Npc:GetClass("xmas_tree");
tbChristmasTree.tbSocks = {18,1,269,1};	--ʥ������
--tbChristmasTree.tbSnowGroups = {18,1,537,1};	--Сѩ�� 
tbChristmasTree.tbSnowGroups = {22,1,45,1};	--Сѩ�� 
tbChristmasTree.nSnowGroupRate = 20
tbChristmasTree.nLevelLimit = 60

function tbChristmasTree:OnDialog()
	if SpecialEvent.Xmas2008:Check() ~= 1 then
		Dialog:Say(string.format("�ۣ�������ʥ�����ء���������û�й�����Ŷ"));
		return 0;
	end	
	Dialog:Say("�ۣ�������ʥ�����أ����滹������ô���������һ��û��ϵ��",
		{
			{"ժȡ����", self.RecevePresent, self, him.dwId},
			{"�ҿ������ѣ��뿪��"}
		})
end

-- ժȡ����
function tbChristmasTree:RecevePresent(nNpcId)
	local pNpc = KNpc.GetById(nNpcId);
	if not pNpc then
		return 0;
	end
	local tbNpcTemp = pNpc.GetTempTable("Npc");
	
	if not tbNpcTemp.tbPlayerList then
		tbNpcTemp.tbPlayerList = {};
	end
	
	local tbPlayerList = tbNpcTemp.tbPlayerList;
	
	if tbPlayerList[me.nId] == 1 then
		Dialog:Say("�Һ����Ѿ��ù������ˣ����Ǹ���������ɡ�");
		return 0;
	end
	
	if me.nLevel < self.nLevelLimit then
		Dialog:Say("�ҹ������������ò����������60�������ðɡ�");
		return 0;
	end
	
	if me.CountFreeBagCell() < 1 then
		Dialog:Say("��ı����ռ䲻��!")
		return 0;
	end
	
	local nRusult = MathRandom(1, 100);
	
	if nRusult > self.nSnowGroupRate then
		-- ��Сѩ��
		local nNum = MathRandom(1, 9);
		local nG, nD, nP, nL = unpack(tbChristmasTree.tbSnowGroups);
		me.AddStackItem(nG, nD, nP, nL, {bTimeOut=1}, nNum);
	else
		-- ������
		local pItem = me.AddItem(unpack(self.tbSocks));
		if pItem then
			pItem.Bind(1);
		end
	end
	
	tbPlayerList[me.nId] = 1;
end


