-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(545); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪��ʯ�ȡ�---------------
local tbTestTrap1	= tbTest:GetTrapClass("to_exit545")

-- �������Trap�¼�
function tbTestTrap1:OnPlayer()	
	me.NewWorld(111,1942,3204)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(1)
end;
