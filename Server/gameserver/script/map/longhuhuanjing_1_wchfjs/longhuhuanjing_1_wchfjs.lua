-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(443); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- �����ض�Trap��ص� ---------------
local tbTestTrap	= tbTest:GetTrapClass("wchfjs2longhuhuanjing")

-- �������Trap�¼�
function tbTestTrap:OnPlayer()
	me.NewWorld(59,1409,2919)	-- ����,[��ͼId,����X,����Y]
	me.SetFightState(1);
end;

-- ����Npc Trap�¼�
function tbTestTrap:OnNpc()
	
end;
