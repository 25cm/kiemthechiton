-- Map �����ӼӲ���
-- ��ӭɾ����

-------------- �����ض���ͼ�ص� ---------------
local tbTest = Map:GetClass(523); -- ��ͼId

-- ������ҽ����¼�
function tbTest:OnEnter(szParam)
	
end;

-- ��������뿪�¼�
function tbTest:OnLeave(szParam)
	
end;

-------------- ���뿪��---------------
local tbTestTrap6	= tbTest:GetTrapClass("to_exit523")

-- �������Trap�¼�
function tbTestTrap6:OnPlayer()	
	me.NewWorld(29,1491,3761)	-- ����,[��ͼId,����X,����Y]	
	me.SetFightState(0)
end;
